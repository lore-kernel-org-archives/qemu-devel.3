Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0FEC3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLS-0007W8-92; Sun, 04 May 2025 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLP-0007T2-Ho
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLO-0005CE-2G
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2264aefc45dso58852965ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395872; x=1747000672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/tk0gbWoG4ApvXZ5c0JKBgUdcITDobE9RIrWnb6spIQ=;
 b=uQ+eRlOtBzBq7CikOTB055G8LygEOkXihgGfPUQMtIW3HLQaDquot6F5pHZbqBFVC2
 chgyJYwYWWgngWLvLgVF0bIWiN2l+o77dngAONAF1MqJHee81nJDld/979Ij8wB23iV9
 RtoqZlDdyEezkUlIG08ddtZpHTJlHis9ijHT2oDMuvP8/02kbV4/qczWZdDsDzhGq7K5
 ueWg+HF812GxrZLkIuQKXuJr0WcnjmCPSBjU1eNA8zGoQjCVffPGvOuPcj5XV9Io2awU
 E6dKii4w/IHYNG7F02YbFI/A6AOkI6M+wvEsKaNUU4pgJjOEY749HGwP3O7YDduGE76r
 vjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395872; x=1747000672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tk0gbWoG4ApvXZ5c0JKBgUdcITDobE9RIrWnb6spIQ=;
 b=tpJe3S+toVeYfxdO7MXkWScWAdFCnI4hX/fDtkrmvk5cbP1zyRa6lFICsQw7JiHDtJ
 zuini6n5xTH5zLmqqrhIRD2bnB9RoxxjlBn1r/e+QYHQCE9urBvERrbn7OioJaMOfAXJ
 ibOZQ4/8+h20N3AMHbfm+jX7qhPy7fBG3q3H7lrCAXIF7qDdgttIuP/i7MzuQt3BrBMB
 1fF6KmvrUqvOZvm8a2RJVA91G5t+5qRe+vA1Q+7CRsQeYCKP55dLjkVRr+je6rD2JDhx
 CrEyWMVzwD7fkrQpHnqmMZ7egPX2ABgKTEvi1GHrMhzbc1W4I3GGOwl8/cIVHNhcjkCI
 YRVA==
X-Gm-Message-State: AOJu0Yx5WBYzSsRheUmo8y7jpfhQXh3RT6SIhnwJ26E43ea+6WNX8FG4
 pgnZHnwebSL8xhk2GCNOASunWttDXpBaakLp8JRXHeAj8Hgq6X19RPiwnXR6QpjDXPzw04euo1m
 gbk4=
X-Gm-Gg: ASbGnctl73+nP4unaBpYX43wqNDZENAl3yUG1SQL9I8KtOS7F/HJVzsUwVUKGp0dtAD
 ruoPpKR8xTHwReBnZKnTZpEwOXGCsZeKi1Q89epjr54OonDgSecieFb247HJGrTU9ol1LFECS/P
 vUumYUNPs13uas73jYJ9Nkk5uHtEdbEEtvxxXRQYcZdDRF7ONNiKRZQvElT1nA5mRVHZvz04zHc
 5A3H6YiiBo/R7Y5EXW4zYwZoQeifuifS25/6NTaOwBN2hwIJRIex8byT3wsrw7n5Ju/AUlcYlJN
 Ul0oWgrLDvD75BVcLiGdNcZM7NggD2cI04j3cYDFYt4FXdLs
X-Google-Smtp-Source: AGHT+IHX4B3MtSbPeoHfu5rcPv/UTsigKurblHN2gBuy1xugWg/RnALJkq6fkZSYL6exMOXH8S9yiA==
X-Received: by 2002:a17:902:ef02:b0:224:2717:7993 with SMTP id
 d9443c01a7336-22e1eadac90mr79083055ad.45.1746395872673; 
 Sun, 04 May 2025 14:57:52 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:52 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/core/machine: Fix indentation
Date: Sun,  4 May 2025 21:56:34 +0000
Message-Id: <20250504215639.54860-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix indentation for some elements in the hardware compat arrays.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/core/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37..b8ae155dfa 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {};
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
 GlobalProperty hw_compat_9_2[] = {
-    {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+    { "arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
     { "virtio-balloon-pci", "vectors", "0" },
     { "virtio-balloon-pci-transitional", "vectors", "0" },
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
@@ -58,12 +58,12 @@ GlobalProperty hw_compat_9_1[] = {
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
-    {"arm-cpu", "backcompat-cntfrq", "true" },
+    { "arm-cpu", "backcompat-cntfrq", "true" },
     { "scsi-hd", "migrate-emulated-scsi-request", "false" },
     { "scsi-cd", "migrate-emulated-scsi-request", "false" },
-    {"vfio-pci", "skip-vsc-check", "false" },
+    { "vfio-pci", "skip-vsc-check", "false" },
     { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
-    {"sd-card", "spec_version", "2" },
+    { "sd-card", "spec_version", "2" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
-- 
2.34.1



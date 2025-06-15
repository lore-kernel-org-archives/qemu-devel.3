Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A71C71135
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 00:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQbEY-0006Hm-D5; Sat, 14 Jun 2025 20:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uQbEX-0006HF-2c
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 20:28:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uQbEV-0007j0-I2
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 20:28:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235ef29524fso4414425ad.1
 for <qemu-devel@nongnu.org>; Sat, 14 Jun 2025 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749947301; x=1750552101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ew6FhwV7k+RCBqhhgmkMcyj1wtfFtnRN4ZJrEDhTzag=;
 b=HlkLgc5QrgGUHxymWMiUk3xTMynVuv64PjmhmW2Y+RdmxaQWO6jUOiRg0dRADX2RlH
 wTU7//7O9BZ27gTJE3J+FEG0QeFLeqBZiCsYqAIiFf5AOyZUlHdYSCZLNdA2pSUfQ+/a
 jas20Mz4LowX+/CV81QggHKSmqNVL15Z1ggU6+Mhy5tGl2YliybZOeviFwZsSCmsWEeN
 EGta6SAo5W83Vte3K0WFR4SXhIZ4oUn6iin4JfmotoyoBxU0KVUf/gKrBaaIWuViX1Hx
 vDlWvAMhyg0QI2HfSPuBQQPcUNa8PpU8Lh/2XFp7TvyDc5dCHsmKM7okK7MjML7qDUZ7
 LrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749947301; x=1750552101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ew6FhwV7k+RCBqhhgmkMcyj1wtfFtnRN4ZJrEDhTzag=;
 b=pNxVSmGaMvvidjzY2Wj15//HnqzDu8DhpKgvKIZGafN+t811DwrqWogLUaKlR5Rrg3
 NYTiIduEtbBo3dadHXv6Vvl8PzcIDvj+awUDH02szd6x0cNYreR00PA/QVbeUVKGoZxD
 +Tp+9beQHhCuNP9kfUtKXre+0AoKGXACktXHXwNTMtjLils8s6C3jvjfRZL8tW+r3/v3
 r0Rh+8lv5uBKfJPpDg774t/oed8U30CnlRYc/K0YfH4VfzLFB8Wfd4EyF/7xC6mpPYDP
 zks7L0C4SrLzhHiCxaOjlgFiuhRkvFenuhmk5q0VGcsONL2ceY6gQFb2iP2Yw+5ti80Q
 j/4A==
X-Gm-Message-State: AOJu0YyRllAHqzsXSN2J26toQBKIRkfNtl9Z9DVa9mNcHjTY+RiYZIeV
 EdnsqrTic7WkTLYNP4IW5NkRF5eK4QZDvyhGnEf0Et1nboc84hniYp0YaXGqvSB6nzg=
X-Gm-Gg: ASbGncvDbbEnuA9svOhmtPxW5VgHj9/NXPihU/+eGTgsgdpibkquwYhkryBM5Ls2QDf
 gQf76IYdD8n/YmGuXBOio6H5aVA3F8GRZ1wNRoovUYRp7W/WjqqoOULpgBej5407L9K5baY0Mea
 dmBjx+ccL9r+cGugGRVo7+pcnKCch9HigH29HwcOq2b/v7m15IZfSM+Frz3lqq3tDfkybknaAgF
 N5ZubWPFzgOEEJqrHY2wY5FxdzoPixj86ANPOIByN4/qoqIOIEXYiHwrcjocDOF40E3xVgwGsMM
 /tBwWiyAgpKPAovTLV7tFA95UVy6iowJZHYHaEo7EotecOXZViQawkJo+KVegd8e8DA=
X-Google-Smtp-Source: AGHT+IGzv59KuEeLJBlFeViV0YF0jWQqZVNZJmDFTtevi2F0FpYV9jQltLpV0bn3MFJE3oU66LS1hg==
X-Received: by 2002:a05:6a20:2591:b0:1f0:d190:fc1f with SMTP id
 adf61e73a8af0-21fbd516415mr2457975637.2.1749947301463; 
 Sat, 14 Jun 2025 17:28:21 -0700 (PDT)
Received: from bong-com.. ([210.97.55.153]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1680eeasm4046628a12.46.2025.06.14.17.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 17:28:21 -0700 (PDT)
From: Haseung Bong <hasueng@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, thuth@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, Haseung Bong <hasueng@gmail.com>
Subject: [PATCH v2] Subject: [PATCH] tests/vm: update openbsd image to 7.7
Date: Sun, 15 Jun 2025 09:27:01 +0900
Message-ID: <20250615002701.302943-1-hasueng@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=hasueng@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Update tests/vm/openbsd to release 7.7

Signed-off-by: Haseung Bong <hasueng@gmail.com>
---
 tests/vm/openbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5e4f76f398..2ea86a01ba 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
-    csum = "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.7/amd64/install77.iso"
+    csum = "da0106e39463f015524dca806f407c37a9bdd17e6dfffe533b06a2dd2edd8a27"
     size = "20G"
     pkgs = [
         # tools
-- 
2.43.0



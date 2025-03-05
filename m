Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27258C282DC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 10:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tplyE-00044M-BM; Wed, 05 Mar 2025 05:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <santimonserr@gmail.com>)
 id 1tplyA-00042H-Py; Wed, 05 Mar 2025 05:27:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <santimonserr@gmail.com>)
 id 1tply9-0003xT-4L; Wed, 05 Mar 2025 05:27:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso5622516f8f.0; 
 Wed, 05 Mar 2025 02:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741170433; x=1741775233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6X6zVvvCMknyzkVrokVVkUeRaa2ENKNrv2kjgTF8LB4=;
 b=eVITOjrbyeDxPEsZoCNCAheiZVZMM8N3Z6FFqwpyhqJcQt9BvZ6wUD8oa3n8ijexZV
 b3qrVAxLBgBxdHSwPueKGccedFRTI8bcHq8m2WX8AVjsPMYwSWZQ3h0ns07Jf2YSakjt
 4/6Vc6nyp4DUajvGL/aZ3Ij+FIuwQ9btE9lnHZGv1BjCyNEf46/VOYtjcycr0ajugiBq
 7tS29SB51SV3fwqsAlAnSLakErjHGqLRaPoy30C4gM2YXuBfwo+J25QXBY6xpnO/mshr
 2gbUM9N3dvXEkiFx8NexSNb8KBhxnzynJ5Qg5mIMacVpToUiUlgVxjhd5JnmPQ1X8bLB
 XRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741170433; x=1741775233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6X6zVvvCMknyzkVrokVVkUeRaa2ENKNrv2kjgTF8LB4=;
 b=HFkgk2FXWFxNH15aArFgzw0E3P9rEq/Ws023IBWeKcsrbQ3cmS5eRjHy6ZhucdwsbK
 hkcFC7lXK+/q84a61QxJoS7nqVy0LPbe9pSdiNovhsDs193J1iWaMFEk/UhZs4JYO8Dy
 pt+oYYS9/QW9XUVO083Lm+3EGpApnoY3hnZ62XEnbL/RrGlpXlhI+6R+da+o2diAFD1l
 JLat6IZjnRfP9YNdNL2yRsMiSbPU+q23BFZKeglzurMQNrA6Quf9Cp0/XxYKCvoOacYq
 OAjAc8tpbgzmPKpiBc+rSV3tpXM1A/o5WeK6PRuFujSXVz9WMH1Sw0gcsCU8l6SS8E+4
 2NOQ==
X-Gm-Message-State: AOJu0Yxw3GXLQo7inxIJwgQFwDRImi8s+TEUxQk1+qWRixw9J16FEWWe
 198ktQxuRIhSZxmMuuo8RXWqm2wqnyYAGG/gMKqHI/JpNFNDOocU7gqwGon8
X-Gm-Gg: ASbGncs128/ozYKxLI63c1abh3gIuc0o8PadSUILiaZ2WfW2sRubu1VrNYuzRPhkimK
 PLfMhE0eTYCC/AQGlWGFonilAe4piB/mO3Iih7UoEbyui2KTfjrFHzRyi1OyVls9jU6eJKiJg0T
 Y46v/KH6HUl69MFxVWYp9StFUZF/VXEMW2O6K8LCZFmpKIn7kMmuuDuF/givy/GzT9VinMZevEU
 b/uUPAE1YbBuXWd0ImVRA/nWBoHoZP/PxZLPRjf4ALwCYrRmf5K/fI1EfLBEiRwDVd5ImJGNSC/
 1EZfhnXFIJW43eZdBoorHcD/m5tAMithJ15K0vwJsRNEA00RX1/VZPgPIg==
X-Google-Smtp-Source: AGHT+IHEY1/pa85S2JVbUAnOS1ShRcseeK8JhRUeOvpVmOkDuSdh8iEx7Dw3wJNuAWIFe4fhrQy6sg==
X-Received: by 2002:a05:6000:154c:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-3911f75a94dmr1960393f8f.26.1741170433184; 
 Wed, 05 Mar 2025 02:27:13 -0800 (PST)
Received: from bsc-848818730.bsc.es ([84.88.187.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e13fsm20351885f8f.100.2025.03.05.02.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 02:27:12 -0800 (PST)
From: Santiago Monserrat Campanello <santimonserr@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, laurent@vivier.eu, mjt@tls.msk.ru,
 Santiago Monserrat Campanello <santimonserr@gmail.com>
Subject: [PATCH] docs/about/emulation: Fix broken link
Date: Wed,  5 Mar 2025 11:26:32 +0100
Message-ID: <20250305102632.91376-1-santimonserr@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=santimonserr@gmail.com; helo=mail-wr1-x436.google.com
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

semihosting link to risc-v changed

Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2717
---
the original one linked it's still accesible on
https://github.com/riscv-non-isa/riscv-semihosting/blob/0.2/riscv-semihosting-spec.adoc
---
 docs/about/emulation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3bc3579434..a72591ee4d 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -171,7 +171,7 @@ for that architecture.
     - Unified Hosting Interface (MD01069)
   * - RISC-V
     - System and User-mode
-    - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc
+    - https://github.com/riscv-non-isa/riscv-semihosting/blob/main/riscv-semihosting.adoc
   * - Xtensa
     - System
     - Tensilica ISS SIMCALL
-- 
2.43.0



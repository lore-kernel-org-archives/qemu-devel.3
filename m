Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FF5C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAl-0001uN-Qu; Fri, 08 Mar 2024 06:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAe-0001gv-Ow
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:49 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAc-0001mU-SD
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:48 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd3bdb6e9eso13611055ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896424; x=1710501224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KA7usGuy5763tDDR81q3Y0bKb8LCa9XwSaIVi2DTPc=;
 b=OZYAGugHc/Bx6Ujdn2ykNM+jCKyeZMb2fTKx+KMzRlOA8/1eMd7mJm4FnWKkHC/lG4
 vZKWbGUBhf6/oBS4ecpmE94dyW4A8nZPQdoSq3JlfUAjqSdBFaq3kD8wiS5+PC+R3K4k
 N2beYCLna6d6LaT6YHt1qNmsDV2av9ABSfClVjb6tVhNokCQPJqtlyPeOrD/C8LlDhXc
 tGSiHN2an6ICX1WteVrXrOGXNJAqEtkmaco1Aq/qbUJdLjflOAV2hOvQziGCLo7K/HCz
 4GfvzvkNnT6MzDPWkSbOAvk0Z1IBvXYZVWAf+oeHvEcBs9ZCq20kehY81MCUuiDhopfh
 Ktgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896424; x=1710501224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KA7usGuy5763tDDR81q3Y0bKb8LCa9XwSaIVi2DTPc=;
 b=TYp3ITgb/Sx+fGPx410TSRV7EebajAoVaTCcMPY+4LteP0iBoXMR0Y+40/zTHhr0JN
 xaOSsnfgpUcZrhnwIQln4rf6vfE+lIB8qaKkwUvrHOH8EEVYH0ccJtCLgZSrsXZvez72
 gcEidoHxvBzHTffZW4uVER9pBBwxSFzesQOMGiHkvQnb3Bss6yOFTfuIvl7cpD1M+F02
 ZNvvVMkXw8/38h5bxCMkcGaj5MhHNCXJkt4Ig1gYCW7Vvt/yICmDUNbPKjZCZlBnQr0o
 uqNcJq1NVCM6cblb/Eg7kmCq5BoxOWm7KYwWGqig75uaaonB4ycxXLYxr+KURbcs8vq2
 G0Rg==
X-Gm-Message-State: AOJu0YzZ+7zoOwza+Z02MizmOuoV/Ve4t5mOivBFyPFhKMDO9VPsFmoC
 Jac9jENmJpz60H913WFlipzI9brlrXZsge1o5ArJkW44/l5cgGIXimlRUUxjeZIKCw==
X-Google-Smtp-Source: AGHT+IH/8a9NiGFii1zHhE6op3snKNEMlzJShRT0ElsE3abvAQWp433bPmTB6ANM1GJVbI4esJY8yw==
X-Received: by 2002:a17:902:e843:b0:1dc:fba1:1522 with SMTP id
 t3-20020a170902e84300b001dcfba11522mr12575958plg.41.1709896424257; 
 Fri, 08 Mar 2024 03:13:44 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:43 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anup Patel <apatel@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/34] hw/intc/riscv_aplic: Fix setipnum_le write emulation for
 APLIC MSI-mode
Date: Fri,  8 Mar 2024 21:11:49 +1000
Message-ID: <20240308111152.2856137-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anup Patel <apatel@ventanamicro.com>

The writes to setipnum_le register in APLIC MSI-mode have special
consideration for level-triggered interrupts as-per section "4.9.2
Special consideration for level-sensitive interrupt sources" of the
RISC-V AIA specification.

Particularly, the below text from the RISC-V specification defines
the behaviour of writes to setipnum_le for level-triggered interrupts:

"A second option is for the interrupt service routine to write the
APLIC’s source identity number for the interrupt to the domain’s
setipnum register just before exiting. This will cause the interrupt’s
pending bit to be set to one again if the source is still asserting
an interrupt, but not if the source is not asserting an interrupt."

Fix setipnum_le write emulation for APLIC MSI-mode by implementing
the above behaviour in riscv_aplic_set_pending() function.

Fixes: e8f79343cfc8 ("hw/intc: Add RISC-V AIA APLIC device emulation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240306095722.463296-2-apatel@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index e98e258deb..775bb96164 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -218,13 +218,25 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
     }
 
     sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if ((sm == APLIC_SOURCECFG_SM_INACTIVE) ||
-        ((!aplic->msimode || (aplic->msimode && !pending)) &&
-         ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
-          (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)))) {
+    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
         return;
     }
 
+    if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
+        (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
+        if (!aplic->msimode || (aplic->msimode && !pending)) {
+            return;
+        }
+        if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
+            (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
+            return;
+        }
+        if (!(aplic->state[irq] & APLIC_ISTATE_INPUT) &&
+            (sm == APLIC_SOURCECFG_SM_LEVEL_HIGH)) {
+            return;
+        }
+    }
+
     riscv_aplic_set_pending_raw(aplic, irq, pending);
 }
 
-- 
2.44.0



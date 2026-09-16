Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B755C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMG-00011V-TI; Wed, 16 Sep 2026 03:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kLb-0000Hq-EG; Wed, 16 Sep 2026 03:46:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kLX-0005JA-GD; Wed, 16 Sep 2026 03:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544614; bh=m1oTYw45ddi3rXkgBBmOEWYhHHu6u5u1u+DJlqe6R/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y22uEGNHsRfUOwr/52T0IXjJ+b7FqlyQ2aMAc7l7y587PsqphaTZZWGXhddTSGYwJ
 xX7lm6eeJkmDLqAdl3vCvWss3R7J9K1chn5YjYzPDQm3PZimRrhDmmnIFmUp5m6MPb
 QHu8GlxY+KgrsvSuQVpuKTyHUEPJc/huN2L5vMhyQJkp4v57CbH916Y23xdKBNSDbL
 LmdIkfj2x6i2EH8z2r4fjzO4QY1z34LwSXhXzXbdWDdHH9t4rPBt6WF/C36vaqMtLd
 GRkna3O27LtTn0Gof/fcNywEHAs7jdduNmFDr8llTrWU2LuyF9XXxGsC3KRwwJ/TxK
 IZoLkaaJmemcw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E84701D55AA;
 Wed, 16 Sep 2026 10:43:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 78040429B51;
 Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 63C635A6F9; Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 28/49] hw/sd: sdhci: Accept version 4 enable without
 UHS-I
Date: Wed, 16 Sep 2026 10:42:46 +0300
Message-ID: <20260916074346.671467-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Meng <bin.meng@processmission.com>

Host Control 2 writes have been conditional on modeled UHS-I support
since commit 0034ebe6ee31. Host Version 4 Enable does not control UHS
signaling, so controllers without modeled UHS-I cannot enter version
4 mode.

Retain Host Version 4 Enable independently of UHS-I while continuing
to reject UHS-specific fields and keeping voltage changes UHS-gated.

Cc: qemu-stable@nongnu.org
Fixes: 0034ebe6ee31 ("sdhci: implement UHS-I voltage switch")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723151853.2143177-9-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 10dddf15e294f01561bacd815c78f2da03c4f1a0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bebbf6e5e03..8d07bb0e81e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1344,11 +1344,24 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
-    case SDHC_ACMD12ERRSTS:
+    case SDHC_ACMD12ERRSTS: {
+        uint16_t hostctl2_mask = mask >> 16;
+        uint16_t hostctl2_value = value >> 16;
+
         MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
-        if (s->uhs_mode >= UHS_I) {
-            MASKED_WRITE(s->hostctl2, mask >> 16, value >> 16);
+        if (s->uhs_mode < UHS_I) {
+            /*
+             * VERSION4 is writable even without UHS-I. Preserve all other
+             * Host Control 2 bits when UHS-I is not supported.
+             */
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
 
+            hostctl2_mask |= ~independent;
+            hostctl2_value &= independent;
+        }
+        MASKED_WRITE(s->hostctl2, hostctl2_mask, hostctl2_value);
+
+        if (s->uhs_mode >= UHS_I) {
             if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, V18_ENA)) {
                 sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_1_8V);
             } else {
@@ -1356,6 +1369,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             }
         }
         break;
+    }
 
     case SDHC_CAPAB:
     case SDHC_CAPAB + 4:
-- 
2.47.3



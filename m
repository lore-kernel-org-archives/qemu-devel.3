Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF15C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsq6-0001sf-2h; Wed, 19 Aug 2026 22:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspm-0001pa-CE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:51 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspk-0000Km-9C
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:49 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c70e2904dso2291916d50.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194127; x=1787798927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=weR0SmSkyvTsHI8HzTlXiZC1s5xIKhEaofwIx1H+ZMg=;
 b=NOjf4FkF5ovMH+oHkGVscS73fSBiABbnr8tEkcSQVJIFc5EiGgI+XbvgUoZhVCjtGB
 3Kf1I9WJYKxk9CdGN9Q3MTkJsSja3SeEQZSQYr5S1U7nLUCFN3P1r5pa84fYV5CMcTxX
 +/rtT86F2CH1ftAzuVnuMaQpkOa/pxVnaUWgh/h0IvpwT5Dz4/6a6mPOoFW0ZFR5fT+0
 h2E6cIegG8NXj3W2qdsqME0VaQzjWr7FediiX5njWJWvAs4kihTihICKqdNtdQO3k4jn
 QngtJSdkQOXXorS/cIiObtDsZgudXEHCBpcWu1AwZuyN0+RFlsgRRUSc7aDKeWUunxos
 Di7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194127; x=1787798927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=weR0SmSkyvTsHI8HzTlXiZC1s5xIKhEaofwIx1H+ZMg=;
 b=cpEYeTDmH+Ac65GoYCUQL+9pH1VNvsYhvRT+JTOnd0SaXji2J05tHtX8tgibEsCypW
 3aENBEzwOTvhARcEf4QYj9rB6u5JUm+c4VwNZx7LBIXLdM40NTZnUwzuVnK7BZE5JZIv
 oHd3dpqO5vWA+zVzPRpj52iWS2t3FPS//9RQtOAA12eCauIQ7bNNQjVqgGEXbUhiBmw4
 ZiclWK8T+Coh9f3/UH0/lGimsARhXbPfG2Mp+9tixHFmneSqkXxJUdvQjdoJzb2vwRg3
 7qsy//5JWBQsOQKVJRNsAKDXqw80V8fHQR9J7IJlekZ6eAL6A1DLCl08EIQ+1CVdMSCq
 VwxQ==
X-Gm-Message-State: AFuF++m9+YC6bmmt86yKEtXmSICmb+fo7PreAPQRoeqrnFjDJm2Vc9Ep
 /QP9JpkpcxWitOuIo7qzzHCqnFITLv3ac/h9vIuRHg+VgRNRtA7Igmxa6tQLWw==
X-Gm-Gg: AR+sD12t19wtjcm26XSQKBDJhH+HnlJaJVGIgASXE5LuI9/cGdUQE2gTQH4lVfiPal+
 S2vO6T0hKmw51+SQHZiL1X4kNpaYkB7dnYD4dDG2U5qOeG5Uu0Uyn6B9mhHFm3LT2JJd2Zi5180
 GsLXPJwKFOEOGF5LfTk7fnDp7xFFQkjj7+nPYYRjys4h6rF7BCZc4If80kD76uJJRiLQBsfbejf
 7cQpUYcZBLlIxIbysYC594Q4OIvAuGlaI4IybyN8Tv5Qn+C9l6KB4sxwuUbo98tBoHodFSsx4pt
 yj9FtoGmeBwK4iUObhKIT9dCGHqY4B0FM4XvDNnr2f2vmsHXLw+nLmoDE5EAqnRkPUqmi5ZnjuS
 q8GDVUNyhACVqlRoWWWxMJgjygVmVi3gzmftQE7ifAvAQ3AG8hdhTuBRk6Zz7Rg723sEzARSVQO
 phoH4kgvpNhunklXCwhgYihBl/1GKU/noDw++rTbeWa3gkJxMs11/+dsu1fyC6wtJ74uGt149Ls
 ete9kTAu+oVl8f2PzWjA4NrbzX+vXp9dQy0utzokj5n3adpbkhq0A==
X-Received: by 2002:a53:add1:0:b0:66b:31bf:d36a with SMTP id
 956f58d0204a3-66ccb597d77mr2623978d50.21.1787194127088; 
 Wed, 19 Aug 2026 19:48:47 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:45 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org (open list:SD (Secure Card))
Subject: [PATCH 01/16] hw/sd/sdhci: add i.MX uSDHC SDCLK_AUTO_GATE and
 NO_SDMA_BOUNDARY quirks
Date: Wed, 19 Aug 2026 21:48:19 -0500
Message-Id: <20260820024834.3286721-2-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb131.google.com
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

The i.MX uSDHC issues commands with SDCLK auto-gated (its driver never
sets SDCLK_EN), and its SDMA does not honour the 512 KiB ADMA buffer
boundary the generic core assumes. Add two opt-in quirk bits for this:

  - SDCLK_AUTO_GATE: treat the clock as running once the internal clock
    is enabled and stable, instead of also requiring SDCLK_EN.
  - NO_SDMA_BOUNDARY: skip the buffer-boundary break in multi-block SDMA.

Both default off and are a no-op when the bit is clear, so no existing
user of the SDHCI models changes behaviour; a machine opts in by setting
the bits on its own uSDHC instances (the i.MX 95 SoC does so).

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/sd/sdhci.c         | 67 +++++++++++++++++++++++++++++++++++++++----
 include/hw/sd/sdhci.h | 21 ++++++++++++++
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e58a6103970..327e9a7cb74 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -611,12 +611,27 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     }
 
     /*
-     * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
-     * possible stop at page boundary if initial address is not page aligned,
-     * allow them to work properly
+     * The i.MX/FSL uSDHC silicon does not implement the SDHCI "Host SDMA
+     * Buffer Boundary" mechanism; it transfers all blocks back-to-back
+     * regardless of buffer-boundary address alignment. The blksize-quirk
+     * in esdhc_write() forces bits 14:12 to 0b111 (= 512 KiB) so Linux's
+     * "zero this field out" pattern doesn't trip a 4 KiB boundary break,
+     * but the real hardware never pauses for the boundary at all, so
+     * neither should we. Skipping the page-aligned path makes the SDMA
+     * transfer run to completion (blkcnt -> 0) and fire transfer-complete,
+     * which is what the FSL U-Boot SPL driver expects (it doesn't ack
+     * SDMA-boundary IRQs by re-writing SYSAD). Controllers with this
+     * behaviour set SDHCI_QUIRK_NO_SDMA_BOUNDARY.
      */
-    if ((s->sdmasysad % boundary_chk) == 0) {
-        page_aligned = true;
+    if (!(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY)) {
+        /*
+         * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not
+         * account for possible stop at page boundary if initial address
+         * is not page aligned, allow them to work properly
+         */
+        if ((s->sdmasysad % boundary_chk) == 0) {
+            page_aligned = true;
+        }
     }
 
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
@@ -992,9 +1007,26 @@ static void sdhci_data_transfer(void *opaque)
     }
 }
 
+static bool sdhci_clock_is_on(SDHCIState *s)
+{
+    /*
+     * The i.MX (u)SDHC has no software SD-clock-enable bit (the card clock
+     * is auto-gated by hardware), so its driver never sets
+     * SDHC_CLOCK_SDCLK_EN. For such a controller, treat the clock as
+     * running once the internal clock is enabled and stable; otherwise
+     * every command would be silently dropped (no completion/timeout IRQ),
+     * stalling the guest on 10s host-side timeouts.
+     */
+    if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
+        return (s->clkcon & (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE)) ==
+               (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE);
+    }
+    return SDHC_CLOCK_IS_ON(s->clkcon);
+}
+
 static bool sdhci_can_issue_command(SDHCIState *s)
 {
-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
+    if (!sdhci_clock_is_on(s) ||
         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
         ((s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY &&
@@ -1613,6 +1645,9 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 #define ESDHC_VENDOR_SPEC               0xc0
 #define ESDHC_FRC_SDCLK_ON              (1 << 8)
+#define ESDHC_VENDORSPEC_IPGEN          (1 << 11)
+#define ESDHC_VENDORSPEC_HCKEN          (1 << 12)
+#define ESDHC_VENDORSPEC_CKEN           (1 << 14)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -1707,6 +1742,26 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         } else {
             s->prnsts |= ESDHC_PRNSTS_CLOCK_GATE_OFF;
         }
+        /*
+         * An SDCLK_AUTO_GATE i.MX uSDHC drives the SD clock through
+         * VENDORSPEC, not through the SDHCI CLKCON. For those instances
+         * mirror the VENDORSPEC clock-enable bits into clkcon so the
+         * standard SDHCI paths (PRNSTS.SDSTB derived from CLOCK_INT_STABLE;
+         * sdhci_can_issue_command gating on CLOCK_IS_ON) see the clock as
+         * enabled; otherwise the U-Boot fsl_esdhc_imx driver waits forever
+         * for SDSTB. Consumers without the quirk keep the upstream behaviour
+         * (a VENDORSPEC write touches only vendor_spec/prnsts).
+         */
+        if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
+            if (value & (ESDHC_VENDORSPEC_HCKEN | ESDHC_VENDORSPEC_IPGEN)) {
+                s->clkcon |= SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE;
+            }
+            if (value & ESDHC_VENDORSPEC_CKEN) {
+                s->clkcon |= SDHC_CLOCK_SDCLK_EN;
+            } else {
+                s->clkcon &= ~SDHC_CLOCK_SDCLK_EN;
+            }
+        }
         break;
 
     case SDHC_HOSTCTL:
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a9da6203fcb..e6940b62562 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -115,6 +115,27 @@ typedef struct SDHCIState SDHCIState;
  */
 #define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
 
+/*
+ * The i.MX (u)SDHC gates the SD card clock automatically and has no
+ * software-visible "SD Clock Enable" bit: its driver programs only the
+ * divider and the internal-clock enable, never SDHC_CLOCK_SDCLK_EN. With
+ * this quirk the controller is considered ready to issue commands once the
+ * internal clock is enabled and stable, instead of also requiring
+ * SDHC_CLOCK_SDCLK_EN (which such a driver never sets). QEMU-internal bit,
+ * taken from the top of the word to avoid the Linux quirk numbering.
+ */
+#define SDHCI_QUIRK_SDCLK_AUTO_GATE    BIT(31)
+
+/*
+ * The i.MX uSDHC silicon does not implement the SDHCI "Host SDMA Buffer
+ * Boundary" mechanism; it streams all blocks back-to-back regardless of the
+ * buffer-boundary alignment, never pausing at the boundary. With this quirk
+ * the SDMA engine skips the page-aligned boundary-break path so the transfer
+ * runs to completion. QEMU-internal bit, taken from the top of the word to
+ * avoid the Linux quirk numbering.
+ */
+#define SDHCI_QUIRK_NO_SDMA_BOUNDARY    BIT(30)
+
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
                          TYPE_PCI_SDHCI)
-- 
2.34.1



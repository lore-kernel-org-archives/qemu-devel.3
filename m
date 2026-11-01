Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D173606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=AK8AaH2V;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=hyvLz2T5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWZ4-0000r9-9G; Sun, 01 Nov 2026 09:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXJ-0006cz-7i
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:55 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXG-00083i-4w
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ivmZnwM
 t+s5Jg53FGVS2MwDwTbF7w5UU30kVrVbS9v+OaCHB4ELNC73OfjqsbiAnKjXfAuUysiuNR
 bQ6PBG7gM8uUhwSw2ohHGch1JHq4tuxKVBxMHf2iM34970N9pYsW0GF99mWuYkNhSjHXM7
 dOTxggT6mqO5UQ+dQO3e/0IKlbRymMEW/yA3U7+F00pmeeCPENtMa8TpQ0nhfOPopOhsb5
 jol8pzbWoJGPqM6+B2baCKCUnsxaKmhJCaRlnfQ6t3rIOHiUQA17VZREoI5oCIY/PLVhUL
 Ggh7URMmWA9Yo3k4d7X/Ozk9OJ4y3Evyuw22nE+U+d4znQ2JyHwBkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=J
 qFfrLG0QCkUWMgxutuaM6H9oSFr18A2dsIfZ3JbRJs=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=RGf6aNpx0WGqtWKjuXXTkZfEzWCKr0NciYPvgQGyoFPmOHJP5ZR3iRrwa1xNu203U3yP
 Q6l3r+L6LQstxptUgKudXpw0Ys98DSDBgLv7Gc97+l2OTEap5lRTVbOEeNOmDNN2t/i+dw
 +6GXkpreJih0mZOJSiQP9XlSnjd97iwCAga1AxC9RvuvysQGNHD2t7bxHCi85WFFhakZ2/
 VxaH05s5kiODe23T/oCnDlPFuQKjEzoxR13lUUVxIQ3GEoUDgcY8CDfvjWkg7o9gkW+RMH
 lir0XPNrC6TI+NBr2VALbVUDI3ZT58rf1Yz9e0FFpRs2Ai8WDXAwxMqT1vWtpo0w==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=AK8AaH2V; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=hyvLz2T5;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=JqFfrLG0
 QCkUWMgxutuaM6H9oSFr18A2dsIfZ3JbRJs=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=AK8AaH2VT8Q2oK9b1KI5Pg4FO2QsZtRB5wK
 WaxfKfyl2r54ALaNJ1AXVglCu33YVQ8mu+vWy+okuayjx/1m0xiWqrCy1KXx34CGLQS3QI
 eOq8dpXpEtrCUlC/vTCCqcI5nK32zr3/aHoEXjzD8wsX2prlXaPJIcFBrz8CHpPbn7BNb+
 JcwznGGKdb/Ax+Xfnqf9PJvERuWX4BbSmBHNovTMVvsRvQrlceRQI3A64gXqAhbJ8x96Xz
 cgsVBaLQqa3o2DUGiBrECvjfpwBY24L1CRaduOvHRIKToFSQP17628hVhpoCsdd6X6aR6/
 X9VZUpJPjzBAnKFceHGMisgPsIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=JqFfrLG0QCkUWMgxutuaM6H9oSFr18A2dsIfZ3JbRJs=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=hyvLz2T5L/kFhMF/AZ
 HIWqbG8ePPlWU6LAdMsSArBMemMnDnHHk/RPXpNgHHgHKXCIFjQdW0MAeYmPxT7e0lDA==
Received: by mx1.catap.net (OpenSMTPD) id 9f9cf02e;
 Sun, 1 Nov 2026 15:27:38 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 61b19d8f;
 Sun, 1 Nov 2026 15:27:31 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 20/26] hw/mips: add Octeon EMM controller
Date: Sun,  1 Nov 2026 15:23:36 +0100
Message-ID: <20261101142723.41346-21-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Model the Octeon EMM command, DMA, switch and buffer registers needed
by firmware MMC initialization. Give the controller its own reset state
and route its registers through the shared CSR window.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 491 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |   3 +
 2 files changed, 494 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 9388bc005b..f3f8a74cbe 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/datadir.h"
+#include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "hw/char/serial-mm.h"
 #include "hw/core/clock.h"
@@ -42,6 +43,8 @@ OBJECT_DECLARE_TYPE(OcteonPeripheralState, OcteonPeripheralClass,
 
 #define TYPE_OCTEON_MIO "octeon-mio"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonMioState, OCTEON_MIO)
+#define TYPE_OCTEON_EMM "octeon-emm"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonEmmState, OCTEON_EMM)
 #define TYPE_OCTEON_RST "octeon-rst"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
 #define TYPE_OCTEON_INTC "octeon-intc"
@@ -52,6 +55,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CSR_32BIT_SIZE       4
 #define OCTEON_CSR_64BIT_SIZE       8
 #define OCTEON_CSR_HI32_OFFSET      0
+#define OCTEON_CSR_LO32_OFFSET      4
 
 /*
  * Clock defaults follow a Ubiquiti E1000 EBB7304 U-Boot banner.
@@ -153,6 +157,88 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_MIO_FUS_RCMD         0x0001500
 #define OCTEON_MIO_FUS_RCMD_PEND    0x0000000000001000ULL
 #define OCTEON_MIO_FUS_RCMD_DAT     0x0000000000ff0000ULL
+#define OCTEON_MIO_EMM_DMA_FIFO_CFG 0x0000160
+#define OCTEON_MIO_EMM_DMA_FIFO_ADR 0x0000170
+#define OCTEON_MIO_EMM_DMA_FIFO_CMD 0x0000178
+#define OCTEON_MIO_EMM_DMA_CFG      0x0000180
+#define OCTEON_MIO_EMM_DMA_ADR      0x0000188
+#define OCTEON_MIO_EMM_DMA_INT      0x0000190
+#define OCTEON_MIO_EMM_CFG          0x0002000
+#define OCTEON_MIO_EMM_MODEX(x) \
+    (0x0002008 + (x) * OCTEON_CSR_64BIT_SIZE)
+#define OCTEON_MIO_EMM_MODE_COUNT   4
+#define OCTEON_MIO_EMM_INT_EN_OLD   0x0002040
+#define OCTEON_MIO_EMM_SWITCH       0x0002048
+#define OCTEON_MIO_EMM_DMA          0x0002050
+#define OCTEON_MIO_EMM_CMD          0x0002058
+#define OCTEON_MIO_EMM_RSP_STS      0x0002060
+#define OCTEON_MIO_EMM_RSP_LO       0x0002068
+#define OCTEON_MIO_EMM_RSP_HI       0x0002070
+#define OCTEON_MIO_EMM_INT          0x0002078
+#define OCTEON_MIO_EMM_WDOG         0x0002088
+#define OCTEON_MIO_EMM_SAMPLE       0x0002090
+#define OCTEON_MIO_EMM_STS_MASK     0x0002098
+#define OCTEON_MIO_EMM_RCA          0x00020a0
+#define OCTEON_MIO_EMM_BUF_IDX      0x00020e0
+#define OCTEON_MIO_EMM_BUF_DAT      0x00020e8
+#define OCTEON_MIO_EMM_DEBUG        0x00020f8
+#define OCTEON_MIO_EMM_NODE_OFFSET  0x0002000
+#define OCTEON_MIO_EMM_CMD_VAL      (1ULL << 59)
+#define OCTEON_MIO_EMM_DMA_VAL      (1ULL << 59)
+#define OCTEON_MIO_EMM_DMA_BLOCK_CNT_SHIFT 32
+#define OCTEON_MIO_EMM_DMA_BLOCK_CNT_MASK \
+    (0xffffULL << OCTEON_MIO_EMM_DMA_BLOCK_CNT_SHIFT)
+#define OCTEON_MIO_EMM_SWITCH_EXE   (1ULL << 59)
+#define OCTEON_MIO_EMM_CMD_IDX_SHIFT 32
+#define OCTEON_MIO_EMM_CMD_IDX_BITS 6
+#define OCTEON_MIO_EMM_CMD_IDX_MASK \
+    ((1U << OCTEON_MIO_EMM_CMD_IDX_BITS) - 1)
+#define OCTEON_MIO_EMM_CMD_BUS_ID_SHIFT 60
+#define OCTEON_MIO_EMM_BUS_ID_MASK  (OCTEON_MIO_EMM_MODE_COUNT - 1)
+#define OCTEON_MIO_EMM_RSP_STS_CMD_DONE (1ULL << 0)
+#define OCTEON_MIO_EMM_RSP_STS_CMD_IDX_SHIFT 1
+#define OCTEON_MIO_EMM_RSP_STS_RSP_TIMEOUT (1ULL << 13)
+#define OCTEON_MIO_EMM_RSP_STS_DMA_VAL (1ULL << 57)
+#define OCTEON_MIO_EMM_RSP_STS_DMA_PEND (1ULL << 56)
+#define OCTEON_MIO_EMM_RSP_STS_BUS_ID_SHIFT 60
+#define OCTEON_MIO_EMM_DMA_INT_DONE (1ULL << 0)
+#define OCTEON_MIO_EMM_INT_CMD_DONE (1ULL << 1)
+#define OCTEON_MIO_EMM_INT_CMD_ERR  (1ULL << 3)
+#define OCTEON_MIO_EMM_INT_DMA_DONE (1ULL << 2)
+#define OCTEON_MIO_EMM_INT_DMA_ERR  (1ULL << 4)
+#define OCTEON_MIO_EMM_INT_SWITCH_DONE (1ULL << 5)
+#define OCTEON_MIO_EMM_INT_SWITCH_ERR  (1ULL << 6)
+#define OCTEON_MIO_EMM_SWITCH_MODE_MASK ((1ULL << 49) - 1)
+#define OCTEON_MIO_EMM_CFG_BUS_EN_MASK \
+    ((1ULL << OCTEON_MIO_EMM_MODE_COUNT) - 1)
+#define OCTEON_MIO_EMM_LOW_SPEED_HZ    400000
+#define OCTEON_MIO_EMM_MODE_CLK_LO_MASK 0x000000000000ffffULL
+#define OCTEON_MIO_EMM_MODE_CLK_HI_MASK 0x00000000ffff0000ULL
+#define OCTEON_MIO_EMM_MODE_CLK_HI_SHIFT 16
+#define OCTEON_MIO_EMM_BUF_IDX_INC  (1ULL << 16)
+#define OCTEON_MIO_EMM_BUF_WORD_SIZE OCTEON_CSR_64BIT_SIZE
+#define OCTEON_MIO_EMM_BUF_ENTRY_COUNT \
+    (OCTEON_MIO_EMM_BUF_SIZE / OCTEON_MIO_EMM_BUF_WORD_SIZE)
+#define OCTEON_MIO_EMM_BUF_IDX_OFF_MASK \
+    (OCTEON_MIO_EMM_BUF_ENTRY_COUNT - 1)
+#define OCTEON_MMC_CMD_GO_IDLE_STATE 0
+#define OCTEON_MMC_CMD_BUSTEST_R    14
+#define OCTEON_MMC_CMD_BUSTEST_W    19
+/* SD/MMC CMD19 request patterns and CMD14 response patterns. */
+#define OCTEON_MMC_BUSTEST_8_REQ0   0x55
+#define OCTEON_MMC_BUSTEST_8_REQ1   0xaa
+#define OCTEON_MMC_BUSTEST_8_RESP0  0xaa
+#define OCTEON_MMC_BUSTEST_8_RESP1  0x55
+#define OCTEON_MMC_BUSTEST_4_REQ0   0x5a
+#define OCTEON_MMC_BUSTEST_4_REQ4   0x99
+#define OCTEON_MMC_BUSTEST_4_REQ5   0x50
+#define OCTEON_MMC_BUSTEST_4_REQ6   0x0f
+#define OCTEON_MMC_BUSTEST_4_RESP0  0xa5
+#define OCTEON_MMC_BUSTEST_1_REQ0   0x80
+#define OCTEON_MMC_BUSTEST_1_REQ1   0x70
+#define OCTEON_MMC_BUSTEST_1_REQ2   0x78
+#define OCTEON_MMC_BUSTEST_1_REQ3   0x01
+#define OCTEON_MMC_BUSTEST_1_RESP0  0x40
 #define OCTEON_RST_BOOT             0x6001600
 #define OCTEON_RST_SOFT_RST         0x6001680
 /* U-Boot uses the reset controller to park and release secondary cores. */
@@ -226,6 +312,19 @@ struct OcteonMioState {
     bool bootbus_led_mapped;
 };
 
+struct OcteonEmmState {
+    OcteonPeripheralState parent_obj;
+    GHashTable *regs;
+    uint64_t mio_emm_rsp_sts;
+    uint64_t mio_emm_rsp_lo;
+    uint64_t mio_emm_rsp_hi;
+    uint64_t mio_emm_int;
+    uint64_t mio_emm_dma_int;
+    uint16_t mio_emm_buf_idx;
+    bool mio_emm_buf_inc;
+    uint8_t mio_emm_buf[OCTEON_MIO_EMM_BUF_SIZE];
+};
+
 struct OcteonRstState {
     OcteonPeripheralState parent_obj;
     GHashTable *regs;
@@ -353,8 +452,15 @@ void octeon_reg_store(GHashTable *regs, uint64_t reg, uint64_t value)
     g_hash_table_replace(regs, key, stored);
 }
 
+static bool octeon_mio_emm_decode(hwaddr reg, hwaddr *ereg);
+
 bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value)
 {
+    hwaddr ereg;
+
+    if (octeon_mio_emm_decode(reg, &ereg)) {
+        return octeon_reg_lookup(s->emm->regs, ereg, value);
+    }
     if (reg == OCTEON_RST_SOFT_RST) {
         return octeon_reg_lookup(s->rst->regs, reg, value);
     }
@@ -363,6 +469,12 @@ bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value)
 
 static void octeon_csr_store(OcteonState *s, uint64_t reg, uint64_t value)
 {
+    hwaddr ereg;
+
+    if (octeon_mio_emm_decode(reg, &ereg)) {
+        octeon_reg_store(s->emm->regs, ereg, value);
+        return;
+    }
     if (reg == OCTEON_RST_SOFT_RST) {
         octeon_reg_store(s->rst->regs, reg, value);
         return;
@@ -453,6 +565,325 @@ static void octeon_mio_boot_loc_dat_write(OcteonState *s, hwaddr addr,
         OCTEON_MIO_BOOT_LOC_ADR_MASK;
 }
 
+static bool octeon_mio_emm_valid_reg(hwaddr reg)
+{
+    if (reg >= OCTEON_MIO_EMM_MODEX(0) &&
+        reg < OCTEON_MIO_EMM_MODEX(OCTEON_MIO_EMM_MODE_COUNT) &&
+        (reg & (OCTEON_CSR_64BIT_SIZE - 1)) == 0) {
+        return true;
+    }
+
+    switch (reg) {
+    case OCTEON_MIO_EMM_DMA_INT:
+    case OCTEON_MIO_EMM_CFG:
+    case OCTEON_MIO_EMM_SWITCH:
+    case OCTEON_MIO_EMM_DMA:
+    case OCTEON_MIO_EMM_CMD:
+    case OCTEON_MIO_EMM_RSP_STS:
+    case OCTEON_MIO_EMM_INT:
+    case OCTEON_MIO_EMM_DMA_FIFO_CFG:
+    case OCTEON_MIO_EMM_DMA_FIFO_ADR:
+    case OCTEON_MIO_EMM_DMA_FIFO_CMD:
+    case OCTEON_MIO_EMM_DMA_CFG:
+    case OCTEON_MIO_EMM_DMA_ADR:
+    case OCTEON_MIO_EMM_INT_EN_OLD:
+    case OCTEON_MIO_EMM_RSP_LO:
+    case OCTEON_MIO_EMM_RSP_HI:
+    case OCTEON_MIO_EMM_WDOG:
+    case OCTEON_MIO_EMM_SAMPLE:
+    case OCTEON_MIO_EMM_STS_MASK:
+    case OCTEON_MIO_EMM_RCA:
+    case OCTEON_MIO_EMM_BUF_IDX:
+    case OCTEON_MIO_EMM_BUF_DAT:
+    case OCTEON_MIO_EMM_DEBUG:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool octeon_mio_emm_decode(hwaddr reg, hwaddr *ereg)
+{
+    if (octeon_mio_emm_valid_reg(reg)) {
+        *ereg = reg;
+        return true;
+    }
+
+    reg -= OCTEON_MIO_EMM_NODE_OFFSET;
+    if (octeon_mio_emm_valid_reg(reg)) {
+        *ereg = reg;
+        return true;
+    }
+
+    return false;
+}
+
+static bool octeon_mio_emm_execute_write(hwaddr addr, unsigned size)
+{
+    return size == OCTEON_CSR_64BIT_SIZE ||
+           (size == OCTEON_CSR_32BIT_SIZE &&
+            (addr & OCTEON_CSR_LO32_OFFSET));
+}
+
+static void octeon_mio_emm_set_low_speed_mode(OcteonState *s,
+                                               unsigned int bus_id)
+{
+    uint64_t period = DIV_ROUND_UP(s->io_hz, OCTEON_MIO_EMM_LOW_SPEED_HZ);
+    uint64_t value;
+
+    period = MIN(period, UINT16_MAX);
+    if (!octeon_csr_lookup(s, OCTEON_MIO_EMM_MODEX(bus_id), &value)) {
+        value = 0;
+    }
+
+    value &= ~(OCTEON_MIO_EMM_MODE_CLK_LO_MASK |
+               OCTEON_MIO_EMM_MODE_CLK_HI_MASK);
+    value |= period | (period << OCTEON_MIO_EMM_MODE_CLK_HI_SHIFT);
+    octeon_csr_store(s, OCTEON_MIO_EMM_MODEX(bus_id), value);
+}
+
+static void octeon_mio_emm_set_bustest(OcteonState *s)
+{
+    const uint8_t *buf = s->emm->mio_emm_buf;
+    bool bus8 = buf[0] == OCTEON_MMC_BUSTEST_8_REQ0 &&
+                buf[1] == OCTEON_MMC_BUSTEST_8_REQ1;
+    bool bus4 = buf[0] == OCTEON_MMC_BUSTEST_4_REQ0 &&
+                buf[4] == OCTEON_MMC_BUSTEST_4_REQ4 &&
+                buf[5] == OCTEON_MMC_BUSTEST_4_REQ5 &&
+                buf[6] == OCTEON_MMC_BUSTEST_4_REQ6;
+    bool bus1 = buf[0] == OCTEON_MMC_BUSTEST_1_REQ0 &&
+                buf[1] == OCTEON_MMC_BUSTEST_1_REQ1 &&
+                buf[2] == OCTEON_MMC_BUSTEST_1_REQ2 &&
+                buf[3] == OCTEON_MMC_BUSTEST_1_REQ3;
+
+    memset(s->emm->mio_emm_buf, 0, sizeof(s->emm->mio_emm_buf));
+    if (bus8) {
+        s->emm->mio_emm_buf[0] = OCTEON_MMC_BUSTEST_8_RESP0;
+        s->emm->mio_emm_buf[1] = OCTEON_MMC_BUSTEST_8_RESP1;
+    } else if (bus4) {
+        s->emm->mio_emm_buf[0] = OCTEON_MMC_BUSTEST_4_RESP0;
+    } else if (bus1) {
+        s->emm->mio_emm_buf[0] = OCTEON_MMC_BUSTEST_1_RESP0;
+    }
+}
+
+static void octeon_mio_emm_complete_dma(OcteonState *s, uint64_t dma)
+{
+    dma &= ~(OCTEON_MIO_EMM_DMA_VAL | OCTEON_MIO_EMM_DMA_BLOCK_CNT_MASK);
+    octeon_csr_store(s, OCTEON_MIO_EMM_DMA, dma);
+    s->emm->mio_emm_rsp_sts &= ~(OCTEON_MIO_EMM_RSP_STS_DMA_VAL |
+                            OCTEON_MIO_EMM_RSP_STS_DMA_PEND);
+    s->emm->mio_emm_dma_int |= OCTEON_MIO_EMM_DMA_INT_DONE;
+    s->emm->mio_emm_int |= OCTEON_MIO_EMM_INT_DMA_DONE;
+}
+
+static void octeon_mio_emm_command(OcteonState *s, uint64_t cmd)
+{
+    unsigned int cmd_idx = (cmd >> OCTEON_MIO_EMM_CMD_IDX_SHIFT) &
+                           OCTEON_MIO_EMM_CMD_IDX_MASK;
+    unsigned int bus_id = (cmd >> OCTEON_MIO_EMM_CMD_BUS_ID_SHIFT) &
+                          OCTEON_MIO_EMM_BUS_ID_MASK;
+
+    s->emm->mio_emm_rsp_lo = 0;
+    s->emm->mio_emm_rsp_hi = 0;
+    s->emm->mio_emm_rsp_sts =
+        OCTEON_MIO_EMM_RSP_STS_CMD_DONE |
+        ((uint64_t)cmd_idx << OCTEON_MIO_EMM_RSP_STS_CMD_IDX_SHIFT) |
+        ((uint64_t)bus_id << OCTEON_MIO_EMM_RSP_STS_BUS_ID_SHIFT);
+
+    switch (cmd_idx) {
+    case OCTEON_MMC_CMD_GO_IDLE_STATE:
+    case OCTEON_MMC_CMD_BUSTEST_W:
+        break;
+    case OCTEON_MMC_CMD_BUSTEST_R:
+        octeon_mio_emm_set_bustest(s);
+        break;
+    default:
+        s->emm->mio_emm_rsp_sts |= OCTEON_MIO_EMM_RSP_STS_RSP_TIMEOUT;
+        break;
+    }
+
+    s->emm->mio_emm_int |= OCTEON_MIO_EMM_INT_CMD_DONE;
+    if (s->emm->mio_emm_rsp_sts & OCTEON_MIO_EMM_RSP_STS_RSP_TIMEOUT) {
+        s->emm->mio_emm_int |= OCTEON_MIO_EMM_INT_CMD_ERR;
+    }
+}
+
+static uint64_t octeon_mio_emm_read(OcteonState *s, hwaddr reg,
+                                    hwaddr addr, unsigned size)
+{
+    uint64_t value;
+
+    switch (reg) {
+    case OCTEON_MIO_EMM_RSP_STS:
+        value = s->emm->mio_emm_rsp_sts;
+        break;
+    case OCTEON_MIO_EMM_RSP_LO:
+        value = s->emm->mio_emm_rsp_lo;
+        break;
+    case OCTEON_MIO_EMM_RSP_HI:
+        value = s->emm->mio_emm_rsp_hi;
+        break;
+    case OCTEON_MIO_EMM_BUF_DAT:
+        value = ldq_be_p(s->emm->mio_emm_buf + s->emm->mio_emm_buf_idx);
+        if (s->emm->mio_emm_buf_inc) {
+            s->emm->mio_emm_buf_idx =
+                (s->emm->mio_emm_buf_idx + OCTEON_MIO_EMM_BUF_WORD_SIZE) %
+                OCTEON_MIO_EMM_BUF_SIZE;
+        }
+        break;
+    case OCTEON_MIO_EMM_INT:
+        value = s->emm->mio_emm_int;
+        break;
+    case OCTEON_MIO_EMM_DMA_INT:
+        value = s->emm->mio_emm_dma_int;
+        break;
+    case OCTEON_MIO_EMM_CMD:
+    case OCTEON_MIO_EMM_SWITCH:
+    case OCTEON_MIO_EMM_DMA:
+        if (!octeon_csr_lookup(s, reg, &value)) {
+            value = 0;
+        }
+        break;
+    case OCTEON_MIO_EMM_MODEX(0):
+    case OCTEON_MIO_EMM_MODEX(1):
+    case OCTEON_MIO_EMM_MODEX(2):
+    case OCTEON_MIO_EMM_MODEX(3):
+        if (!octeon_csr_lookup(s, reg, &value)) {
+            value = 0;
+        }
+        break;
+    default:
+        if (!octeon_csr_lookup(s, reg, &value)) {
+            value = 0;
+        }
+        break;
+    }
+
+    return octeon_read64(value, addr, size);
+}
+
+static void octeon_mio_emm_write(OcteonState *s, hwaddr reg,
+                                 hwaddr addr, uint64_t value, unsigned size)
+{
+    uint64_t old;
+    uint64_t clear;
+
+    switch (reg) {
+    case OCTEON_MIO_EMM_CMD:
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        if (!(value & OCTEON_MIO_EMM_CMD_VAL)) {
+            return;
+        }
+        if (!octeon_mio_emm_execute_write(addr, size)) {
+            return;
+        }
+
+        octeon_csr_store(s, reg, value & ~OCTEON_MIO_EMM_CMD_VAL);
+        octeon_mio_emm_command(s, value);
+        return;
+    case OCTEON_MIO_EMM_SWITCH:
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        if (!(value & OCTEON_MIO_EMM_SWITCH_EXE)) {
+            return;
+        }
+        if (!octeon_mio_emm_execute_write(addr, size)) {
+            return;
+        }
+        octeon_csr_store(s, reg, value & ~OCTEON_MIO_EMM_SWITCH_EXE);
+        octeon_csr_store(s, OCTEON_MIO_EMM_MODEX(
+                         (value >> OCTEON_MIO_EMM_CMD_BUS_ID_SHIFT) &
+                         OCTEON_MIO_EMM_BUS_ID_MASK),
+                         value & OCTEON_MIO_EMM_SWITCH_MODE_MASK);
+        s->emm->mio_emm_int |= OCTEON_MIO_EMM_INT_SWITCH_DONE;
+        return;
+    case OCTEON_MIO_EMM_DMA:
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        if (!(value & OCTEON_MIO_EMM_DMA_VAL)) {
+            return;
+        }
+        if (!octeon_mio_emm_execute_write(addr, size)) {
+            return;
+        }
+        octeon_mio_emm_complete_dma(s, value);
+        return;
+    case OCTEON_MIO_EMM_INT:
+        clear = octeon_write64(0, addr, value, size);
+        s->emm->mio_emm_int &= ~clear;
+        return;
+    case OCTEON_MIO_EMM_DMA_INT:
+        clear = octeon_write64(0, addr, value, size);
+        s->emm->mio_emm_dma_int &= ~clear;
+        return;
+    case OCTEON_MIO_EMM_MODEX(0):
+    case OCTEON_MIO_EMM_MODEX(1):
+    case OCTEON_MIO_EMM_MODEX(2):
+    case OCTEON_MIO_EMM_MODEX(3):
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        return;
+    case OCTEON_MIO_EMM_CFG:
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        if (octeon_mio_emm_execute_write(addr, size)) {
+            uint64_t enabled = (value & ~old) & OCTEON_MIO_EMM_CFG_BUS_EN_MASK;
+            unsigned int i;
+
+            for (i = 0; i < OCTEON_MIO_EMM_MODE_COUNT; i++) {
+                if (enabled & (1U << i)) {
+                    octeon_mio_emm_set_low_speed_mode(s, i);
+                }
+            }
+        }
+        return;
+    case OCTEON_MIO_EMM_BUF_IDX:
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        s->emm->mio_emm_buf_idx = (value & OCTEON_MIO_EMM_BUF_IDX_OFF_MASK) *
+                             OCTEON_MIO_EMM_BUF_WORD_SIZE;
+        s->emm->mio_emm_buf_inc = value & OCTEON_MIO_EMM_BUF_IDX_INC;
+        return;
+    case OCTEON_MIO_EMM_BUF_DAT:
+        old = ldq_be_p(s->emm->mio_emm_buf + s->emm->mio_emm_buf_idx);
+        value = octeon_write64(old, addr, value, size);
+        stq_be_p(s->emm->mio_emm_buf + s->emm->mio_emm_buf_idx, value);
+        if (s->emm->mio_emm_buf_inc) {
+            s->emm->mio_emm_buf_idx =
+                (s->emm->mio_emm_buf_idx + OCTEON_MIO_EMM_BUF_WORD_SIZE) %
+                OCTEON_MIO_EMM_BUF_SIZE;
+        }
+        return;
+    default:
+        if (!octeon_csr_lookup(s, reg, &old)) {
+            old = 0;
+        }
+        value = octeon_write64(old, addr, value, size);
+        octeon_csr_store(s, reg, value);
+        return;
+    }
+}
+
 static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
                                           unsigned int *source)
 {
@@ -1258,6 +1689,7 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
 {
     OcteonState *s = opaque;
     hwaddr reg = addr & ~7ULL;
+    hwaddr ereg;
     uint64_t value;
 
     if (reg >= OCTEON_MIO_BOOT_REG_CFGX(0) &&
@@ -1294,6 +1726,10 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
+    if (octeon_mio_emm_decode(reg, &ereg)) {
+        return octeon_mio_emm_read(s, ereg, addr, size);
+    }
+
     if (!octeon_csr_lookup(s, reg, &value)) {
         value = 0;
     }
@@ -1305,8 +1741,14 @@ static void octeon_csr_write(void *opaque, hwaddr addr,
 {
     OcteonState *s = opaque;
     hwaddr reg = addr & ~7ULL;
+    hwaddr ereg;
     uint64_t old;
 
+    if (octeon_mio_emm_decode(reg, &ereg)) {
+        octeon_mio_emm_write(s, ereg, addr, value, size);
+        return;
+    }
+
     if (reg == OCTEON_RST_SOFT_RST && value) {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return;
@@ -1707,6 +2149,26 @@ static void octeon_mio_reset_hold(Object *obj, ResetType type)
     octeon_mio_boot_loc_update(s);
 }
 
+static void octeon_emm_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonEmmState *emm = OCTEON_EMM(obj);
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    g_hash_table_remove_all(emm->regs);
+    emm->mio_emm_rsp_sts = 0;
+    emm->mio_emm_rsp_lo = 0;
+    emm->mio_emm_rsp_hi = 0;
+    emm->mio_emm_int = 0;
+    emm->mio_emm_dma_int = 0;
+    emm->mio_emm_buf_idx = 0;
+    emm->mio_emm_buf_inc = false;
+    memset(emm->mio_emm_buf, 0, sizeof(emm->mio_emm_buf));
+}
+
 static void octeon_rst_reset_hold(Object *obj, ResetType type)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
@@ -1774,6 +2236,16 @@ static GHashTable *octeon_reg_table_new(void)
                                  g_free, g_free);
 }
 
+static void octeon_emm_init(Object *obj)
+{
+    OCTEON_EMM(obj)->regs = octeon_reg_table_new();
+}
+
+static void octeon_emm_finalize(Object *obj)
+{
+    g_hash_table_destroy(OCTEON_EMM(obj)->regs);
+}
+
 static void octeon_rst_init(Object *obj)
 {
     OCTEON_RST(obj)->regs = octeon_reg_table_new();
@@ -1803,6 +2275,15 @@ static void octeon_mio_class_init(ObjectClass *klass, const void *data)
                                        NULL, &opc->parent_phases);
 }
 
+static void octeon_emm_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL, octeon_emm_reset_hold,
+                                       NULL, &opc->parent_phases);
+}
+
 static void octeon_rst_class_init(ObjectClass *klass, const void *data)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
@@ -1846,6 +2327,7 @@ static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
 static void octeon_create_peripherals(OcteonState *s)
 {
     s->mio = OCTEON_MIO(octeon_new_peripheral(s, TYPE_OCTEON_MIO, 0));
+    s->emm = OCTEON_EMM(octeon_new_peripheral(s, TYPE_OCTEON_EMM, 0));
     s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
     s->intc = OCTEON_INTC(octeon_new_peripheral(s, TYPE_OCTEON_INTC, 0));
     s->csr_bank = OCTEON_CSR_BANK(octeon_new_peripheral(
@@ -1862,6 +2344,7 @@ static void octeon_realize_peripherals(OcteonState *s)
     octeon_realize_peripheral(&s->csr_bank->parent_obj);
     octeon_realize_peripheral(&s->intc->parent_obj);
     octeon_realize_peripheral(&s->rst->parent_obj);
+    octeon_realize_peripheral(&s->emm->parent_obj);
     octeon_realize_peripheral(&s->mio->parent_obj);
 }
 
@@ -1986,6 +2469,14 @@ static const TypeInfo octeon_machine_types[] = {
         .instance_size = sizeof(OcteonMioState),
         .class_init = octeon_mio_class_init,
     },
+    {
+        .name = TYPE_OCTEON_EMM,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonEmmState),
+        .instance_init = octeon_emm_init,
+        .instance_finalize = octeon_emm_finalize,
+        .class_init = octeon_emm_class_init,
+    },
     {
         .name = TYPE_OCTEON_RST,
         .parent = TYPE_OCTEON_PERIPHERAL,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index e9826f1713..a262107b54 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -20,6 +20,7 @@
 #define OCTEON_CIU3_IDT_COUNT       (OCTEON_MAX_CPUS * 4)
 #define OCTEON_MIO_BOOT_REG_CFG_COUNT 8
 #define OCTEON_MIO_BOOT_LOC_SIZE    0x100
+#define OCTEON_MIO_EMM_BUF_SIZE     512
 #define OCTEON_TWSI_COUNT           2
 #define OCTEON_TWSI_STAT_IDLE       0xf8
 #define OCTEON_SPD_EEPROM_SIZE      139
@@ -38,6 +39,7 @@ typedef enum OcteonCiu3Source {
 
 typedef struct OcteonState OcteonState;
 typedef struct OcteonMioState OcteonMioState;
+typedef struct OcteonEmmState OcteonEmmState;
 typedef struct OcteonRstState OcteonRstState;
 typedef struct OcteonIntcState OcteonIntcState;
 typedef struct OcteonCsrBankState OcteonCsrBankState;
@@ -68,6 +70,7 @@ struct OcteonState {
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
     OcteonMioState *mio;
+    OcteonEmmState *emm;
     OcteonRstState *rst;
     OcteonIntcState *intc;
     OcteonCsrBankState *csr_bank;
-- 
2.56.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB65606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=D71VP2YC;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=qyNiSyGc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1J-0008GE-4l; Thu, 29 Oct 2026 16:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX11-0008BH-QF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:28 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0z-0007Tg-58
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=repX5X0
 loiJX7piqu837hBrXlmO2AWaGtSn+c2L8e6lvHppRSnk3e7Mv09n4rqsnMSduNLoUkBXBX
 ZS01VXKNptWra1kbxW8XKUiyK//IfE7U6qvkhJI2E0g9cwrlOjKtO0fZ1pC0dadWKm6Qsr
 A0VrOPA+gJoOT5/eGVkVYW6kUorqpPktUTujbRGv/OdlOgw0e1f1KzORdeHb66HRcWBuec
 zuvbQoYgpL31lwQ7UTI+gIRZMUdvJxK0FlWSOnSSVR+YUzkUtAeYFNMuCYjqxmcYXKndG5
 wcbjJttoEMv7aUjPdmF1jMXo906J+dkWZB6XhmrEP4PtzbEKvVmZh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=c
 6/UIHsw8wWJ2f9bC3LuIhmFdzyCaeLmRn3AfI8hJqU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=XFgAbsdE+KeHDlRW7sUhVywyd+rokkrGbFIQjez/voBJ3i/nsESrJkeydzws6CiiBqiR
 qvFWtxrzgWTJ4685epHxBflvtTkrz2RQANbu3HWCzqR4m1xf10eQyXlaj7T72qZOlvxWgt
 Oc8qnKskLGoHMONlQ3HUQ+5peiNZbTKIjtFePYsSQ/xQ3M3tsPbRzjWUujNeknixZme54W
 sRirfmYQ7r1M4ANIVOdxqJ6mUfwYx2suuExtADqFzfQ7UPd7dwoOftbVqA2xD+orIFdsXC
 cfZQMa/kdyLiaHYUu6gkNnVjCek8INyxcQUKOif1VNtzAAdXIuvep1DJG2xbDTaQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=D71VP2YC; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=qyNiSyGc;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=c6/UIHsw
 8wWJ2f9bC3LuIhmFdzyCaeLmRn3AfI8hJqU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=D71VP2YCPp8XCz/7PTLYoHTKRLEWozdjryj
 Sl0g8q4tapeeVaxVOhOXvf+gJ4xjVCwshjFCzva4fF7EkGzdCDu5Sh5J5uvIYnOwbeSc2n
 UBY12EmaPi/aOLTwPbJpQe8oR6/6U6LFjd70/I/qNeS56s/+H84MRoBOj4k8GP6Z+VUPiP
 inoLCivjHJBnzdgRQQfJG1O9B/cNSZ12TfohAzqpRFH20Ok80Ei7Ob5LkMf3LQm2T6zUBE
 EQx4Oos5/laZTtf3MrUVlBL+PKaccdGNzcrsvPbEyrDlLgnJr+JEgi5KDkLw4sQU96/Apa
 nx+51j3WTwUsnvsamswx0wvDtbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=c6/UIHsw8wWJ2f9bC3LuIhmFdzyCaeLmRn3AfI8hJqU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=qyNiSyGcWLXtSsZjY1
 8XApnF4XyVYk6Dmad3CmbcmlAaeyWYU8lzoNPksco5OuaB0gpvsASReWzIBIkUzHNWAQ==
Received: by mx1.catap.net (OpenSMTPD) id 737afc2f;
 Thu, 29 Oct 2026 21:46:18 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 509539bb;
 Thu, 29 Oct 2026 21:46:13 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 14/26] hw/mips: add Octeon legacy CIU
Date: Thu, 29 Oct 2026 21:43:59 +0100
Message-ID: <20261029204609.38989-15-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
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

Model the legacy CIU mailbox, IPI, GPIO and UART summary registers.
Mirror mailbox state into CIU3 interrupt sources so firmware using either
controller observes consistent interrupt delivery.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 248 +++++++++++++++++++++++++++++++++++++-
 hw/mips/octeon_internal.h |   1 +
 2 files changed, 248 insertions(+), 1 deletion(-)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 567be0905a..638d96559f 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -69,6 +69,29 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
 #define OCTEON_DR1_BASE             0x020000000ULL
 #define OCTEON_DR1_SIZE             (OCTEON_MAX_PHY_MEM_SIZE - OCTEON_DR0_SIZE)
 
+#define OCTEON_CIU_BASE             0x1070000000000ULL
+#define OCTEON_CIU_LEGACY_PAGE_SIZE (4 * KiB)
+#define OCTEON_CIU_SIZE             (1 * MiB + OCTEON_CIU_LEGACY_PAGE_SIZE)
+#define OCTEON_CIU_FUSE             0x728
+#define OCTEON_CIU_SUM_IPI          0x0000000100000000ULL
+#define OCTEON_CIU_SUM_UART         0x0000000800000000ULL
+#define OCTEON_CIU_ENABLE0          0x88006f1800000000ULL
+#define OCTEON_CIU_IPI_SUM_BASE     0x008
+#define OCTEON_CIU_IPI_SUM_STRIDE   0x10
+#define OCTEON_CIU_IPI_EN_BASE      0x210
+#define OCTEON_CIU_IPI_EN_STRIDE    0x20
+#define OCTEON_CIU_MBOX_SET_BASE    0x600
+#define OCTEON_CIU_MBOX_CLR_BASE    0x680
+#define OCTEON_CIU_MBOX_SET_STRIDE  8
+#define OCTEON_CIU_GPIO_RX_DAT      0x880
+#define OCTEON_CIU_GPIO_TX_SET      0x888
+#define OCTEON_CIU_GPIO_TX_CLR      0x890
+#define OCTEON_CIU_GPIO_BIT_CFG_STRIDE OCTEON_CSR_64BIT_SIZE
+#define OCTEON_CIU_GPIO_BIT_CFGX(x) \
+    (0x900 + (x) * OCTEON_CIU_GPIO_BIT_CFG_STRIDE)
+#define OCTEON_CIU_GPIO_INPUTS      ((1ULL << OCTEON_CIU_GPIO_COUNT) - 1)
+#define OCTEON_CIU_GPIO_BIT_CFG_TX_OE (1ULL << 0)
+
 #define OCTEON_CIU3_BASE            0x1010000000000ULL
 #define OCTEON_CIU3_SIZE            0xb0000000ULL
 #define OCTEON_CIU3_PP_RST          0x100
@@ -97,7 +120,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
 #define OCTEON_CIU3_ISC_SIZE        (OCTEON_CIU3_NINTSN * 8)
 #define OCTEON_CIU3_MBOX_INTSN(cpu) ((cpu) + 0x4000U)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
-
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -147,7 +169,14 @@ struct OcteonRstState {
 
 struct OcteonIntcState {
     OcteonPeripheralState parent_obj;
+    MemoryRegion ciu;
     MemoryRegion ciu3;
+    uint32_t ciu_mbox[OCTEON_MAX_CPUS];
+    uint64_t ciu_ipi_en[OCTEON_MAX_CPUS];
+    uint64_t ciu_gpio_rx;
+    uint64_t ciu_gpio_tx;
+    uint64_t ciu_gpio_bit_cfg[OCTEON_CIU_GPIO_COUNT];
+    bool uart_pending;
     uint64_t ciu3_pp_rst;
     uint32_t ciu3_src_state[OCTEON_CIU3_SRC_COUNT];
     uint64_t ciu3_src_ctl[OCTEON_CIU3_SRC_COUNT];
@@ -305,6 +334,12 @@ static void octeon_ciu3_clear_raw(OcteonState *s, unsigned int source)
     } while (old != cmp);
 }
 
+static bool octeon_ciu3_set_mbox(OcteonState *s, unsigned int cpu)
+{
+    return octeon_ciu3_set_level(s, OCTEON_CIU3_SRC_MBOX0 + cpu,
+                                 qatomic_read(&s->intc->ciu_mbox[cpu]) != 0);
+}
+
 static bool octeon_ciu3_isc_decode(hwaddr reg, uint32_t base,
                                    uint32_t *intsn)
 {
@@ -461,6 +496,12 @@ static void octeon_intc_update_cpu(OcteonState *s, unsigned int cpu_index)
          irq < OCTEON_CIU3_CP0_IRQ_BASE + OCTEON_CIU3_CP0_IRQ_COUNT;
          irq++) {
         level = false;
+        if (irq == 3) {
+            level = qatomic_read(&s->intc->ciu_mbox[cpu_index]) &&
+                    (qatomic_read(&s->intc->ciu_ipi_en[cpu_index]) &
+                     OCTEON_CIU_SUM_IPI);
+        }
+
         if (octeon_ciu3_pending_intsn(s, cpu_index, irq, &intsn)) {
             level = true;
         }
@@ -527,6 +568,189 @@ static uint64_t octeon_ciu3_source_cpu_mask(OcteonState *s, unsigned int src)
         s, qatomic_read(&s->intc->ciu3_src_ctl[src]));
 }
 
+static uint64_t octeon_ciu_gpio_rx_value(OcteonState *s)
+{
+    uint64_t value = 0;
+    unsigned int i;
+
+    for (i = 0; i < OCTEON_CIU_GPIO_COUNT; i++) {
+        uint64_t mask = 1ULL << i;
+
+        if (qatomic_read(&s->intc->ciu_gpio_bit_cfg[i]) &
+            OCTEON_CIU_GPIO_BIT_CFG_TX_OE) {
+            if (qatomic_read(&s->intc->ciu_gpio_tx) & mask) {
+                value |= mask;
+            }
+        } else if (qatomic_read(&s->intc->ciu_gpio_rx) & mask) {
+            value |= mask;
+        }
+    }
+
+    return value;
+}
+
+static uint64_t octeon_ciu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonState *s = opaque;
+    uint64_t value = 0;
+    hwaddr reg = addr & ~7ULL;
+    unsigned int cpu;
+
+    if (reg == 0) {
+        if (qatomic_read(&s->intc->uart_pending)) {
+            value |= OCTEON_CIU_SUM_UART;
+        }
+        octeon_intc_request_cpu_update(s, 0);
+        return octeon_read64(value, addr, size);
+    }
+
+    if (reg == OCTEON_CIU_IPI_EN_BASE) {
+        return octeon_read64(OCTEON_CIU_ENABLE0, addr, size);
+    }
+
+    if (reg == OCTEON_CIU_FUSE) {
+        value = octeon_present_cpu_mask(s);
+        return octeon_read64(value, addr, size);
+    }
+
+    if (reg == OCTEON_CIU_GPIO_RX_DAT) {
+        return octeon_read64(octeon_ciu_gpio_rx_value(s), addr, size);
+    }
+
+    if (reg == OCTEON_CIU_GPIO_TX_SET ||
+        reg == OCTEON_CIU_GPIO_TX_CLR) {
+        return octeon_read64(qatomic_read(&s->intc->ciu_gpio_tx), addr, size);
+    }
+
+    if (reg >= OCTEON_CIU_GPIO_BIT_CFGX(0) &&
+        reg < OCTEON_CIU_GPIO_BIT_CFGX(OCTEON_CIU_GPIO_COUNT)) {
+        unsigned int index = (reg - OCTEON_CIU_GPIO_BIT_CFGX(0)) /
+                             OCTEON_CIU_GPIO_BIT_CFG_STRIDE;
+
+        return octeon_read64(qatomic_read(&s->intc->ciu_gpio_bit_cfg[index]),
+                             addr, size);
+    }
+
+    if (reg >= OCTEON_CIU_IPI_SUM_BASE &&
+        reg < OCTEON_CIU_IPI_SUM_BASE +
+              OCTEON_MAX_CPUS * OCTEON_CIU_IPI_SUM_STRIDE &&
+        ((reg - OCTEON_CIU_IPI_SUM_BASE) &
+         (OCTEON_CIU_IPI_SUM_STRIDE - 1)) == 0) {
+        cpu = (reg - OCTEON_CIU_IPI_SUM_BASE) / OCTEON_CIU_IPI_SUM_STRIDE;
+        if (cpu < s->cpu_count && qatomic_read(&s->intc->ciu_mbox[cpu])) {
+            return octeon_read64(OCTEON_CIU_SUM_IPI, addr, size);
+        }
+    }
+
+    if (reg >= OCTEON_CIU_IPI_EN_BASE &&
+        reg < OCTEON_CIU_IPI_EN_BASE +
+              OCTEON_MAX_CPUS * OCTEON_CIU_IPI_EN_STRIDE &&
+        ((reg - OCTEON_CIU_IPI_EN_BASE) &
+         (OCTEON_CIU_IPI_EN_STRIDE - 1)) == 0) {
+        cpu = (reg - OCTEON_CIU_IPI_EN_BASE) / OCTEON_CIU_IPI_EN_STRIDE;
+        if (cpu < s->cpu_count) {
+            return octeon_read64(qatomic_read(&s->intc->ciu_ipi_en[cpu]),
+                                 addr, size);
+        }
+    }
+
+    if (reg >= OCTEON_CIU_MBOX_CLR_BASE &&
+        reg < OCTEON_CIU_MBOX_CLR_BASE +
+              OCTEON_MAX_CPUS * OCTEON_CIU_MBOX_SET_STRIDE &&
+        ((reg - OCTEON_CIU_MBOX_CLR_BASE) &
+         (OCTEON_CIU_MBOX_SET_STRIDE - 1)) == 0) {
+        cpu = (reg - OCTEON_CIU_MBOX_CLR_BASE) / OCTEON_CIU_MBOX_SET_STRIDE;
+        if (cpu < s->cpu_count) {
+            return octeon_read64(qatomic_read(&s->intc->ciu_mbox[cpu]),
+                                 addr, size);
+        }
+    }
+
+    return 0;
+}
+
+static void octeon_ciu_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t old;
+    unsigned int cpu;
+
+    if (reg >= OCTEON_CIU_IPI_EN_BASE &&
+        reg < OCTEON_CIU_IPI_EN_BASE +
+              OCTEON_MAX_CPUS * OCTEON_CIU_IPI_EN_STRIDE &&
+        ((reg - OCTEON_CIU_IPI_EN_BASE) &
+         (OCTEON_CIU_IPI_EN_STRIDE - 1)) == 0) {
+        cpu = (reg - OCTEON_CIU_IPI_EN_BASE) / OCTEON_CIU_IPI_EN_STRIDE;
+        if (cpu < s->cpu_count) {
+            value = octeon_atomic_write64(&s->intc->ciu_ipi_en[cpu], addr,
+                                          value, size, UINT64_MAX, 0, &old);
+            if (old != value) {
+                octeon_intc_request_cpu_update(s, cpu);
+            }
+        }
+        return;
+    }
+
+    if (reg >= OCTEON_CIU_MBOX_SET_BASE &&
+        reg < OCTEON_CIU_MBOX_SET_BASE +
+              OCTEON_MAX_CPUS * OCTEON_CIU_MBOX_SET_STRIDE &&
+        ((reg - OCTEON_CIU_MBOX_SET_BASE) &
+         (OCTEON_CIU_MBOX_SET_STRIDE - 1)) == 0) {
+        cpu = (reg - OCTEON_CIU_MBOX_SET_BASE) / OCTEON_CIU_MBOX_SET_STRIDE;
+        if (cpu < s->cpu_count) {
+            old = qatomic_fetch_or(&s->intc->ciu_mbox[cpu], value & UINT32_MAX);
+            if ((old | (value & UINT32_MAX)) != old &&
+                octeon_ciu3_set_mbox(s, cpu)) {
+                octeon_intc_request_cpu_update(s, cpu);
+            }
+        }
+        return;
+    }
+
+    if (reg >= OCTEON_CIU_MBOX_CLR_BASE &&
+        reg < OCTEON_CIU_MBOX_CLR_BASE +
+              OCTEON_MAX_CPUS * OCTEON_CIU_MBOX_SET_STRIDE &&
+        ((reg - OCTEON_CIU_MBOX_CLR_BASE) &
+         (OCTEON_CIU_MBOX_SET_STRIDE - 1)) == 0) {
+        cpu = (reg - OCTEON_CIU_MBOX_CLR_BASE) / OCTEON_CIU_MBOX_SET_STRIDE;
+        if (cpu < s->cpu_count) {
+            old = qatomic_fetch_and(&s->intc->ciu_mbox[cpu],
+                                    ~(value & UINT32_MAX));
+            if ((old & (value & UINT32_MAX)) &&
+                octeon_ciu3_set_mbox(s, cpu)) {
+                octeon_intc_request_cpu_update(s, cpu);
+            }
+        }
+        return;
+    }
+
+    if (reg == OCTEON_CIU_GPIO_TX_SET) {
+        value = octeon_write64(0, addr, value, size) &
+                OCTEON_CIU_GPIO_INPUTS;
+        qatomic_or(&s->intc->ciu_gpio_tx, value);
+        return;
+    }
+
+    if (reg == OCTEON_CIU_GPIO_TX_CLR) {
+        value = octeon_write64(0, addr, value, size) &
+                OCTEON_CIU_GPIO_INPUTS;
+        qatomic_and(&s->intc->ciu_gpio_tx, ~value);
+        return;
+    }
+
+    if (reg >= OCTEON_CIU_GPIO_BIT_CFGX(0) &&
+        reg < OCTEON_CIU_GPIO_BIT_CFGX(OCTEON_CIU_GPIO_COUNT)) {
+        unsigned int index = (reg - OCTEON_CIU_GPIO_BIT_CFGX(0)) /
+                             OCTEON_CIU_GPIO_BIT_CFG_STRIDE;
+
+        octeon_atomic_write64(&s->intc->ciu_gpio_bit_cfg[index], addr, value,
+                              size, UINT64_MAX, 0, NULL);
+        return;
+    }
+}
+
 static void octeon_cpu_park_now(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
@@ -591,6 +815,16 @@ static void octeon_ciu3_nmi(OcteonState *s, uint64_t mask)
     }
 }
 
+static const MemoryRegionOps octeon_ciu_ops = {
+    .read = octeon_ciu_read,
+    .write = octeon_ciu_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
 static uint64_t octeon_ciu3_read(void *opaque, hwaddr addr, unsigned size)
 {
     OcteonState *s = opaque;
@@ -799,6 +1033,7 @@ void octeon_irq_set(void *opaque, int irq, int level)
         if (!octeon_ciu3_set_level(s, src, level)) {
             return;
         }
+        qatomic_set(&s->intc->uart_pending, level);
         break;
     default:
         return;
@@ -1042,6 +1277,12 @@ static void octeon_intc_reset_hold(Object *obj, ResetType type)
         opc->parent_phases.hold(obj, type);
     }
 
+    memset(intc->ciu_mbox, 0, sizeof(intc->ciu_mbox));
+    memset(intc->ciu_ipi_en, 0, sizeof(intc->ciu_ipi_en));
+    qatomic_set(&intc->ciu_gpio_rx, OCTEON_CIU_GPIO_INPUTS);
+    qatomic_set(&intc->ciu_gpio_tx, 0);
+    memset(intc->ciu_gpio_bit_cfg, 0, sizeof(intc->ciu_gpio_bit_cfg));
+    qatomic_set(&intc->uart_pending, false);
     qatomic_set(&intc->ciu3_pp_rst, octeon_secondary_cpu_mask(s));
     memset(intc->ciu3_src_state, 0, sizeof(intc->ciu3_src_state));
     memset(intc->ciu3_src_ctl, 0, sizeof(intc->ciu3_src_ctl));
@@ -1134,6 +1375,11 @@ static void mips_octeon_init(MachineState *machine)
     octeon_load_firmware(s);
     octeon_create_cpus(s);
 
+    memory_region_init_io(&s->intc->ciu, OBJECT(s->intc), &octeon_ciu_ops, s,
+                          "octeon.ciu", OCTEON_CIU_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_CIU_BASE,
+                                &s->intc->ciu);
+
     memory_region_init_io(&s->intc->ciu3, OBJECT(s->intc),
                           &octeon_ciu3_ops, s,
                           "octeon.ciu3", OCTEON_CIU3_SIZE);
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index fef88419b5..cd810f3dd5 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -14,6 +14,7 @@
 #include "target/mips/cpu.h"
 
 #define OCTEON_MAX_CPUS             16
+#define OCTEON_CIU_GPIO_COUNT       32
 #define OCTEON_CIU3_CP0_IRQ_COUNT   4
 #define OCTEON_CIU3_IDT_COUNT       (OCTEON_MAX_CPUS * 4)
 
-- 
2.56.0



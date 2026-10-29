Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B14606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=JsiUHJIS;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=QaKqKbCz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUAZ-0006Pz-DR; Thu, 29 Oct 2026 13:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8p-0003dx-1p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:25 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8k-0003H7-BP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=cR/puOy
 FFmoUkXVvTSnh0w9hIOmcqTwqD0WvRJCnS5pfHemT0YEZ7qoXhrQv6kzrWk3Ks/T6YmGUl
 PgmjDXPi2RosFU4ajDh5vbYoIIG72h0MjMG2PqFLzQiK7JXaTRg8lnwNvW5oLjuppcxvfp
 nQTX1w229GoGl31v8e44zfggwq7AthoULf06pl0ZHlOVJxpuINe5N+94tJw0hotap3ePZw
 y1wqf1CbwacyMIn00S7Xp8a/F4VKCZ7INQLaTotdk+5crgfBnLjeJqatl6RnlkegAcx2PF
 LQYtmoy+5q0Q/w0FM180FCp0NZ0dXzNxFDLw7k/XbpwQdXs8Gv504rg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=F
 s1yJ9sMIBUwe8d1EfvoBMEqsytjYcCwmNIoiMssPbY=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=OsWq0tipRzzhVders24109SjOY1cM6UE5Z6uiE0xnJDahCXTNFeHSHg3VeBTt08HmFEW
 BLtMQB8b8xH2lm+k2muW4E229J/AuRgArS9aBL+8OIn02nvI1C3Uw6l1iTRoCkOnnDoPl4
 CNieIOmr6B5sXu+mSY8PIiPOjNKwQ8wM7u5QxBNb4t6QY1BlUkn7pYi9hCYFkk8SQTa7st
 J38q/z7EPNxtwy8hQa1wSgTEZyktzxZQo16b4o6gJIbaY7zuUuJrmm5DU6d9qQJz7oXgdL
 iY9LR6ZwxDW7obhwesR6yQFtuYI1o6Y1nqUiK7xhjAAyuUUQ6l1Z531LQvJEEuAA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=JsiUHJIS; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=QaKqKbCz;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Fs1yJ9sM
 IBUwe8d1EfvoBMEqsytjYcCwmNIoiMssPbY=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=JsiUHJISwlGeWs4SPPl40q6yyP8R+8KG6ap
 X62HQZAgG7BbOW+hqiRA/WkMOJ5dFQwIp79KhqYGt8DKk6bUzuon/8dZVBz8FSZ+vJJxJ/
 1PoFYYyWpNbS0O/tEt/TvpxSQkieqXFkRuF6XFrInvKQqXADSr4IRtKGS7CGtqifl/tfL4
 lZgcGurPUq8xouz7pyfT2wllKlso4N7Lk0b5rY1BZbAQ6SOudICagxybJvTqmPTsql9bH/
 vo2PEhuosojZRSOB2VMmTqS18Nps+IvU+tlVEFCxHyVZ0ysPkMrR0WSvLGkoQlyLJD4W7h
 nMGF+pSL043wFmClEpXU1oFNUUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Fs1yJ9sMIBUwe8d1EfvoBMEqsytjYcCwmNIoiMssPbY=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=QaKqKbCzkzQciGcOqL
 PG6qVMIUQtmIOaAdQfczn64iHIfM9rbe4Flt7JzNHEYiNBIBmfZaT3f7eDKmCx8lcBAA==
Received: by mx1.catap.net (OpenSMTPD) id ab8b91ff;
 Thu, 29 Oct 2026 18:41:56 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 76c8a2d8;
 Thu, 29 Oct 2026 18:41:48 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 24/26] hw/pci-bridge: add Octeon PCI host bridge
Date: Thu, 29 Oct 2026 18:36:24 +0100
Message-ID: <20261029174139.44302-25-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174139.44302-1-kirill@korins.ky>
References: <20261029174139.44302-1-kirill@korins.ky>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the root bus, configuration apertures, I/O window, PEM register
access and interrupt routing. Leave guest PCI memory transactions to a
separate patch.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/Kconfig            |   3 +
 hw/mips/octeon.c           |  69 ++++++-
 hw/mips/octeon_internal.h  |  13 ++
 hw/pci-bridge/meson.build  |   5 +
 hw/pci-bridge/octeon_pci.c | 356 +++++++++++++++++++++++++++++++++++++
 5 files changed, 444 insertions(+), 2 deletions(-)
 create mode 100644 hw/pci-bridge/octeon_pci.c

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 2566df6da6..54ce3cafbd 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -71,6 +71,9 @@ config MIPS_OCTEON
     bool
     default y
     depends on MIPS64 && TARGET_BIG_ENDIAN
+    imply E1000_PCI
+    imply PCI_DEVICES
+    select PCI
     select PFLASH_CFI02
     select SERIAL_MM
     select USB_DWC3
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 94717b6c89..19d1451464 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -94,6 +94,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CIU_FUSE             0x728
 #define OCTEON_CIU_SUM_IPI          0x0000000100000000ULL
 #define OCTEON_CIU_SUM_UART         0x0000000800000000ULL
+#define OCTEON_CIU_SUM_PCI          0x0000001000000000ULL
 #define OCTEON_CIU_ENABLE0          0x88006f1800000000ULL
 #define OCTEON_CIU_IPI_SUM_BASE     0x008
 #define OCTEON_CIU_IPI_SUM_STRIDE   0x10
@@ -137,6 +138,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CIU3_SRC_RAW         0x00000002U
 #define OCTEON_CIU3_NINTSN          (1U << 20)
 #define OCTEON_CIU3_ISC_SIZE        (OCTEON_CIU3_NINTSN * 8)
+#define OCTEON_CIU3_PEM_INTSN_INTA(port) (((0xc0 + (port)) << 12) + 60)
 #define OCTEON_CIU3_MBOX_INTSN(cpu) ((cpu) + 0x4000U)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
 #define OCTEON_CSR_BASE             0x1180000000000ULL
@@ -304,6 +306,18 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CVMSEG_SIZE          0x4000
 #define OCTEON_CVMSEG_TOTAL_SIZE    (OCTEON_MAX_CPUS * OCTEON_CVMSEG_SIZE)
 
+#define OCTEON_GSERX_CFG0           0x90000080
+#define OCTEON_GSERX_QLM_STAT0      0x900000a0
+#define OCTEON_RST_CTLX0            0x6001640
+#define OCTEON_RST_SOFT_PRSTX0      0x60016c0
+#define OCTEON_PEMX_CFG_RD0         0xc0000030
+#define OCTEON_PEMX_CFG_WR0         0xc0000028
+#define OCTEON_PEMX_BIST_STATUS0    0xc0000440
+#define OCTEON_PEMX_ON0             0xc0000420
+#define OCTEON_PEMX_STRAP0          0xc0000408
+
+#define OCTEON_RST_CTL_HOST_MODE    (1ULL << 6)
+#define OCTEON_RST_CTL_RST_DONE     (1ULL << 8)
 #define OCTEON_FLASH_BASE           0x1f400000ULL
 #define OCTEON_FLASH_RESET_BASE     0x1fc00000ULL
 #define OCTEON_FLASH_RESET_SIZE     (4 * MiB)
@@ -385,6 +399,7 @@ struct OcteonIntcState {
     uint64_t ciu_gpio_tx;
     uint64_t ciu_gpio_bit_cfg[OCTEON_CIU_GPIO_COUNT];
     bool uart_pending;
+    bool pci_pending;
     uint64_t ciu3_pp_rst;
     uint32_t ciu3_src_state[OCTEON_CIU3_SRC_COUNT];
     uint64_t ciu3_src_ctl[OCTEON_CIU3_SRC_COUNT];
@@ -517,7 +532,8 @@ bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value)
     if (octeon_mio_emm_decode(reg, &ereg)) {
         return octeon_reg_lookup(s->emm->regs, ereg, value);
     }
-    if (reg == OCTEON_RST_SOFT_RST) {
+    if (reg == OCTEON_RST_CTLX0 || reg == OCTEON_RST_SOFT_PRSTX0 ||
+        reg == OCTEON_RST_SOFT_RST) {
         return octeon_reg_lookup(s->rst->regs, reg, value);
     }
     return octeon_reg_lookup(s->csr_bank->values, reg, value);
@@ -531,7 +547,8 @@ static void octeon_csr_store(OcteonState *s, uint64_t reg, uint64_t value)
         octeon_reg_store(s->emm->regs, ereg, value);
         return;
     }
-    if (reg == OCTEON_RST_SOFT_RST) {
+    if (reg == OCTEON_RST_CTLX0 || reg == OCTEON_RST_SOFT_PRSTX0 ||
+        reg == OCTEON_RST_SOFT_RST) {
         octeon_reg_store(s->rst->regs, reg, value);
         return;
     }
@@ -1031,6 +1048,10 @@ static void octeon_lmc_write(OcteonLmcState *lmc, hwaddr reg,
 static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
                                           unsigned int *source)
 {
+    if (intsn == OCTEON_CIU3_PEM_INTSN_INTA(0)) {
+        *source = OCTEON_CIU3_SRC_PCI_INTA;
+        return true;
+    }
     if (intsn == OCTEON_CIU3_UART0_INTSN) {
         *source = OCTEON_CIU3_SRC_UART0;
         return true;
@@ -1057,6 +1078,8 @@ static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
 static uint32_t octeon_ciu3_source_intsn(unsigned int source)
 {
     switch (source) {
+    case OCTEON_CIU3_SRC_PCI_INTA:
+        return OCTEON_CIU3_PEM_INTSN_INTA(0);
     case OCTEON_CIU3_SRC_UART0:
         return OCTEON_CIU3_UART0_INTSN;
     case OCTEON_CIU3_SRC_USB0:
@@ -1076,6 +1099,7 @@ static uint32_t octeon_ciu3_source_intsn(unsigned int source)
 static bool octeon_ciu3_source_is_level(unsigned int source)
 {
     switch (source) {
+    case OCTEON_CIU3_SRC_PCI_INTA:
     case OCTEON_CIU3_SRC_UART0:
     case OCTEON_CIU3_SRC_USB0:
     case OCTEON_CIU3_SRC_USB1:
@@ -1395,6 +1419,9 @@ static uint64_t octeon_ciu_read(void *opaque, hwaddr addr, unsigned size)
         if (qatomic_read(&s->intc->uart_pending)) {
             value |= OCTEON_CIU_SUM_UART;
         }
+        if (qatomic_read(&s->intc->pci_pending)) {
+            value |= OCTEON_CIU_SUM_PCI;
+        }
         octeon_intc_request_cpu_update(s, 0);
         return octeon_read64(value, addr, size);
     }
@@ -1883,6 +1910,29 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
         return octeon_read64(value, addr, size);
     case OCTEON_RST_PP_POWER:
         return octeon_read64(s->rst->rst_pp_power, addr, size);
+    case OCTEON_GSERX_CFG0:
+        return octeon_read64(1, addr, size);
+    case OCTEON_GSERX_QLM_STAT0:
+        return octeon_read64(3, addr, size);
+    case OCTEON_RST_CTLX0:
+        if (!octeon_csr_lookup(s, reg, &value)) {
+            value = OCTEON_RST_CTL_HOST_MODE | OCTEON_RST_CTL_RST_DONE;
+        }
+        return octeon_read64(value, addr, size);
+    case OCTEON_RST_SOFT_PRSTX0:
+        if (!octeon_csr_lookup(s, reg, &value)) {
+            value = 1;
+        }
+        return octeon_read64(value, addr, size);
+    case OCTEON_PEMX_CFG_RD0:
+    case OCTEON_PEMX_CFG_WR0:
+        return octeon_pci_pem_read(s, reg, addr, size);
+    case OCTEON_PEMX_BIST_STATUS0:
+        return 0;
+    case OCTEON_PEMX_ON0:
+        return octeon_read64(3, addr, size);
+    case OCTEON_PEMX_STRAP0:
+        return octeon_read64(3, addr, size);
     default:
         break;
     }
@@ -1963,6 +2013,11 @@ static void octeon_csr_write(void *opaque, hwaddr addr,
         return;
     }
 
+    if (reg == OCTEON_PEMX_CFG_RD0 || reg == OCTEON_PEMX_CFG_WR0) {
+        octeon_pci_pem_write(s, reg, addr, value, size);
+        return;
+    }
+
     if (reg >= OCTEON_MIO_BOOT_REG_CFGX(0) &&
         reg < OCTEON_MIO_BOOT_REG_CFGX(OCTEON_MIO_BOOT_REG_CFG_COUNT)) {
         unsigned int index = OCTEON_MIO_BOOT_REG_CFG_INDEX(reg);
@@ -2174,6 +2229,13 @@ void octeon_irq_set(void *opaque, int irq, int level)
         }
         qatomic_set(&s->intc->uart_pending, level);
         break;
+    case OCTEON_IRQ_PCI:
+        src = OCTEON_CIU3_SRC_PCI_INTA;
+        if (!octeon_ciu3_set_level(s, src, level)) {
+            return;
+        }
+        qatomic_set(&s->intc->pci_pending, level);
+        break;
     case OCTEON_IRQ_USB0:
         src = OCTEON_CIU3_SRC_USB0;
         if (!octeon_ciu3_set_level(s, src, level)) {
@@ -2550,6 +2612,7 @@ static void octeon_intc_reset_hold(Object *obj, ResetType type)
     qatomic_set(&intc->ciu_gpio_tx, 0);
     memset(intc->ciu_gpio_bit_cfg, 0, sizeof(intc->ciu_gpio_bit_cfg));
     qatomic_set(&intc->uart_pending, false);
+    qatomic_set(&intc->pci_pending, false);
     qatomic_set(&intc->ciu3_pp_rst, octeon_secondary_cpu_mask(s));
     memset(intc->ciu3_src_state, 0, sizeof(intc->ciu3_src_state));
     memset(intc->ciu3_src_ctl, 0, sizeof(intc->ciu3_src_ctl));
@@ -2822,6 +2885,7 @@ static void mips_octeon_init(MachineState *machine)
                                 &s->pow);
 
     octeon_init_usb(s);
+    octeon_init_pci(s);
     octeon_realize_peripherals(s);
 }
 
@@ -2877,6 +2941,7 @@ static void octeon_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = OCTEON_DEFAULT_RAM_SIZE;
     mc->default_ram_id = "octeon.ram";
     mc->max_cpus = OCTEON_MAX_CPUS;
+    mc->pci_allow_0_address = true;
 }
 
 static const TypeInfo octeon_machine_types[] = {
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 6c93c957de..c2a88dac46 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -30,12 +30,14 @@
 
 typedef enum OcteonIRQ {
     OCTEON_IRQ_UART,
+    OCTEON_IRQ_PCI,
     OCTEON_IRQ_USB0,
     OCTEON_IRQ_USB1,
     OCTEON_IRQ_COUNT,
 } OcteonIRQ;
 
 typedef enum OcteonCiu3Source {
+    OCTEON_CIU3_SRC_PCI_INTA,
     OCTEON_CIU3_SRC_UART0,
     OCTEON_CIU3_SRC_USB0,
     OCTEON_CIU3_SRC_USB1,
@@ -93,6 +95,12 @@ struct OcteonState {
     MemoryRegion uart_alias;
     MemoryRegion uart_tx;
     MemoryRegion uart_alias_tx;
+    MemoryRegion pcie_cfg;
+    MemoryRegion pcie_sli_cfg;
+    MemoryRegion pcie0_io;
+
+    DeviceState *pci_host;
+    PCIBus *pci_bus;
 };
 
 guint octeon_uint64_hash(gconstpointer v);
@@ -109,5 +117,10 @@ void octeon_validate_ram_size(uint64_t ram_size);
 void octeon_init_spd(OcteonState *s);
 void octeon_init_twsi(OcteonState *s);
 void octeon_init_usb(OcteonState *s);
+void octeon_init_pci(OcteonState *s);
+uint64_t octeon_pci_pem_read(OcteonState *s, hwaddr reg,
+                             hwaddr addr, unsigned size);
+void octeon_pci_pem_write(OcteonState *s, hwaddr reg, hwaddr addr,
+                          uint64_t value, unsigned size);
 
 #endif
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 073aeacf7f..65ec2087c2 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -9,6 +9,11 @@ stub_ss.add(files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
+if 'CONFIG_TCG' in config_all_accel
+  mips_ss.add(when: 'CONFIG_MIPS_OCTEON',
+              if_true: files('octeon_pci.c'))
+endif
+
 # Sun4u
 pci_ss.add(when: 'CONFIG_SIMBA', if_true: files('simba.c'))
 
diff --git a/hw/pci-bridge/octeon_pci.c b/hw/pci-bridge/octeon_pci.c
new file mode 100644
index 0000000000..e2f856e164
--- /dev/null
+++ b/hw/pci-bridge/octeon_pci.c
@@ -0,0 +1,356 @@
+/*
+ * QEMU Cavium Octeon PCI host bridge model.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "hw/mips/octeon_internal.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "qemu/module.h"
+#include "system/memory.h"
+
+#define TYPE_OCTEON_PCI_HOST "octeon-pci-host"
+OBJECT_DECLARE_TYPE(OcteonPCIHostState, OcteonPCIHostClass,
+                    OCTEON_PCI_HOST)
+
+#define OCTEON_PCIE_CFG_BASE        0x1190400000000ULL
+#define OCTEON_PCIE_CFG_SIZE        0x20000000ULL
+#define OCTEON_PCIE_SLI_CFG_BASE    0x1190c00000000ULL
+#define OCTEON_PCIE_SLI_CFG_PORTS   4
+#define OCTEON_PCIE_SLI_CFG_PORT_SIZE (1ULL << 32)
+#define OCTEON_PCIE_SLI_CFG_SIZE    \
+    (OCTEON_PCIE_SLI_CFG_PORTS * OCTEON_PCIE_SLI_CFG_PORT_SIZE)
+#define OCTEON_PCIE0_IO_BASE        0x11a0400000000ULL
+#define OCTEON_PCIE0_IO_SIZE        (1ULL << 32)
+#define OCTEON_PCIE0_MEM_SIZE       (1ULL << 32)
+#define OCTEON_PCIE0_ENDPOINT_DEVFN PCI_DEVFN(0x0b, 0)
+#define OCTEON_PEMX_CFG_WR0         0xc0000028
+#define OCTEON_PEMX_CFG_RD0         0xc0000030
+#define OCTEON_PCIE_CFG006          0x018
+#define OCTEON_PCIE_CFG031          0x07c
+#define OCTEON_PCIE_CFG032          0x080
+#define OCTEON_PCIE_CFG068          0x110
+
+struct OcteonPCIHostState {
+    PCIHostState parent_obj;
+    MemoryRegion mem;
+    MemoryRegion io;
+    uint32_t pem_cfg_rd_addr;
+    uint64_t pem_cfg_wr;
+    GHashTable *root_cfg;
+};
+
+struct OcteonPCIHostClass {
+    PCIHostBridgeClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+static void octeon_pci_host_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPCIHostState *host = OCTEON_PCI_HOST(obj);
+    OcteonPCIHostClass *opc = OCTEON_PCI_HOST_GET_CLASS(obj);
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    host->pem_cfg_rd_addr = 0;
+    host->pem_cfg_wr = 0;
+    g_hash_table_remove_all(host->root_cfg);
+}
+
+static OcteonPCIHostState *octeon_pci_host(OcteonState *s)
+{
+    return OCTEON_PCI_HOST(s->pci_host);
+}
+
+static uint32_t octeon_pcie_root_cfg_default(uint32_t reg)
+{
+    switch (reg) {
+    case OCTEON_PCIE_CFG006:
+        return 0x00010101;
+    case OCTEON_PCIE_CFG031:
+        return 0x00000011;
+    case OCTEON_PCIE_CFG032:
+        return 0x20110000;
+    default:
+        return 0;
+    }
+}
+
+static uint32_t octeon_pcie_root_cfg_read(OcteonPCIHostState *host,
+                                           uint32_t reg)
+{
+    uint64_t value;
+
+    reg &= ~3U;
+    switch (reg) {
+    case OCTEON_PCIE_CFG006:
+    case OCTEON_PCIE_CFG031:
+    case OCTEON_PCIE_CFG032:
+        return octeon_pcie_root_cfg_default(reg);
+    default:
+        break;
+    }
+
+    if (octeon_reg_lookup(host->root_cfg, reg, &value)) {
+        return value;
+    }
+
+    return octeon_pcie_root_cfg_default(reg);
+}
+
+static void octeon_pcie_root_cfg_write(OcteonPCIHostState *host,
+                                        uint32_t reg, uint32_t value)
+{
+    reg &= ~3U;
+    if (reg == OCTEON_PCIE_CFG068) {
+        value = 0;
+    }
+
+    octeon_reg_store(host->root_cfg, reg, value);
+}
+
+uint64_t octeon_pci_pem_read(OcteonState *s, hwaddr reg,
+                             hwaddr addr, unsigned size)
+{
+    OcteonPCIHostState *host = octeon_pci_host(s);
+    uint64_t value;
+
+    switch (reg) {
+    case OCTEON_PEMX_CFG_RD0:
+        value = ((uint64_t)octeon_pcie_root_cfg_read(
+                     host, host->pem_cfg_rd_addr) << 32) |
+                host->pem_cfg_rd_addr;
+        break;
+    case OCTEON_PEMX_CFG_WR0:
+        value = host->pem_cfg_wr;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return octeon_read64(value, addr, size);
+}
+
+void octeon_pci_pem_write(OcteonState *s, hwaddr reg, hwaddr addr,
+                          uint64_t value, unsigned size)
+{
+    OcteonPCIHostState *host = octeon_pci_host(s);
+
+    switch (reg) {
+    case OCTEON_PEMX_CFG_RD0:
+        value = octeon_write64(0, addr, value, size);
+        host->pem_cfg_rd_addr = value;
+        break;
+    case OCTEON_PEMX_CFG_WR0:
+        value = octeon_write64(host->pem_cfg_wr, addr, value, size);
+        octeon_pcie_root_cfg_write(host, value, value >> 32);
+        host->pem_cfg_wr = value;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t octeon_pci_absent(unsigned size)
+{
+    return size == 1 ? 0xff : size == 2 ? 0xffff : 0xffffffffU;
+}
+
+static bool octeon_pcie_config_addr(hwaddr addr, uint32_t *pci_addr,
+                                    bool sli_cfg)
+{
+    unsigned int bus = (addr >> 20) & 0xff;
+    unsigned int dev = (addr >> 15) & 0x1f;
+    unsigned int fn = (addr >> 12) & 0x7;
+    unsigned int reg = addr & 0xfff;
+
+    if (sli_cfg) {
+        if (addr >= OCTEON_PCIE_SLI_CFG_PORT_SIZE ||
+            bus != 0 || dev != 0 || fn != 0 ||
+            reg >= PCI_CONFIG_SPACE_SIZE) {
+            return false;
+        }
+    } else if (bus != 1 || dev != 0 || fn != 0 ||
+               reg >= PCI_CONFIG_SPACE_SIZE) {
+        return false;
+    }
+
+    *pci_addr = 0x80000000U | (OCTEON_PCIE0_ENDPOINT_DEVFN << 8) | reg;
+    return true;
+}
+
+static uint64_t octeon_pcie_cfg_read(void *opaque, hwaddr addr,
+                                     unsigned size)
+{
+    OcteonState *s = opaque;
+    uint32_t pci_addr;
+
+    if (!octeon_pcie_config_addr(addr, &pci_addr, false)) {
+        return octeon_pci_absent(size);
+    }
+
+    return pci_data_read(s->pci_bus, pci_addr, size);
+}
+
+static void octeon_pcie_cfg_write(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+    uint32_t pci_addr;
+
+    if (octeon_pcie_config_addr(addr, &pci_addr, false)) {
+        pci_data_write(s->pci_bus, pci_addr, value, size);
+    }
+}
+
+static const MemoryRegionOps octeon_pcie_cfg_ops = {
+    .read = octeon_pcie_cfg_read,
+    .write = octeon_pcie_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t octeon_pcie_sli_cfg_read(void *opaque, hwaddr addr,
+                                         unsigned size)
+{
+    OcteonState *s = opaque;
+    uint32_t pci_addr;
+
+    if (!octeon_pcie_config_addr(addr, &pci_addr, true)) {
+        return octeon_pci_absent(size);
+    }
+
+    return pci_data_read(s->pci_bus, pci_addr, size);
+}
+
+static void octeon_pcie_sli_cfg_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+    uint32_t pci_addr;
+
+    if (octeon_pcie_config_addr(addr, &pci_addr, true)) {
+        pci_data_write(s->pci_bus, pci_addr, value, size);
+    }
+}
+
+static const MemoryRegionOps octeon_pcie_sli_cfg_ops = {
+    .read = octeon_pcie_sli_cfg_read,
+    .write = octeon_pcie_sli_cfg_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static int octeon_pci_map_irq(PCIDevice *pci_dev, int irq_num)
+{
+    return 0;
+}
+
+static void octeon_pci_set_irq(void *opaque, int irq_num, int level)
+{
+    octeon_irq_set(opaque, OCTEON_IRQ_PCI, level);
+}
+
+static void octeon_pci_host_init(Object *obj)
+{
+    OcteonPCIHostState *host = OCTEON_PCI_HOST(obj);
+
+    host->root_cfg = g_hash_table_new_full(octeon_uint64_hash,
+                                           octeon_uint64_equal,
+                                           g_free, g_free);
+}
+
+static void octeon_pci_host_finalize(Object *obj)
+{
+    OcteonPCIHostState *host = OCTEON_PCI_HOST(obj);
+
+    g_hash_table_destroy(host->root_cfg);
+}
+
+static void octeon_pci_host_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    OcteonPCIHostClass *opc = OCTEON_PCI_HOST_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->fw_name = "pci";
+    dc->user_creatable = false;
+    resettable_class_set_parent_phases(rc, NULL,
+                                       octeon_pci_host_reset_hold, NULL,
+                                       &opc->parent_phases);
+}
+
+static const TypeInfo octeon_pci_host_info = {
+    .name          = TYPE_OCTEON_PCI_HOST,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(OcteonPCIHostState),
+    .instance_init = octeon_pci_host_init,
+    .instance_finalize = octeon_pci_host_finalize,
+    .class_size    = sizeof(OcteonPCIHostClass),
+    .class_init    = octeon_pci_host_class_init,
+};
+
+static void octeon_pci_host_register_types(void)
+{
+    type_register_static(&octeon_pci_host_info);
+}
+
+type_init(octeon_pci_host_register_types)
+
+void octeon_init_pci(OcteonState *s)
+{
+    DeviceState *dev;
+    OcteonPCIHostState *host;
+    PCIHostState *phb;
+
+    dev = qdev_new(TYPE_OCTEON_PCI_HOST);
+    host = OCTEON_PCI_HOST(dev);
+    s->pci_host = dev;
+    phb = PCI_HOST_BRIDGE(dev);
+
+    memory_region_init(&host->mem, OBJECT(dev), "octeon.pci-mem",
+                       OCTEON_PCIE0_MEM_SIZE);
+    memory_region_init(&host->io, OBJECT(dev), "octeon.pci-io",
+                       OCTEON_PCIE0_IO_SIZE);
+
+    phb->bus = pci_root_bus_new(dev, "pci", &host->mem, &host->io,
+                                OCTEON_PCIE0_ENDPOINT_DEVFN, TYPE_PCI_BUS);
+    s->pci_bus = phb->bus;
+    pci_bus_irqs(s->pci_bus, octeon_pci_set_irq, s, 1);
+    pci_bus_map_irqs(s->pci_bus, octeon_pci_map_irq);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    memory_region_init_io(&s->pcie_cfg, NULL, &octeon_pcie_cfg_ops, s,
+                          "octeon.pcie-config", OCTEON_PCIE_CFG_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_PCIE_CFG_BASE,
+                                &s->pcie_cfg);
+
+    memory_region_init_io(&s->pcie_sli_cfg, NULL, &octeon_pcie_sli_cfg_ops,
+                          s, "octeon.pcie-sli-config",
+                          OCTEON_PCIE_SLI_CFG_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                OCTEON_PCIE_SLI_CFG_BASE,
+                                &s->pcie_sli_cfg);
+
+    memory_region_init_alias(&s->pcie0_io, NULL, "octeon.pcie0-io",
+                             &host->io, 0,
+                             OCTEON_PCIE0_IO_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_PCIE0_IO_BASE,
+                                &s->pcie0_io);
+
+}
-- 
2.56.0



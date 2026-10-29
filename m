Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=LVgj0FE6;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=5vNkjNX/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU9c-0004dY-Ld; Thu, 29 Oct 2026 13:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8n-0003cE-EI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:21 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8j-0003HN-It
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=VyFnjmj
 SkvaixCf3WuJ2eBcUwYI5ZIn4FROQP+fiPcOwtjMfnOpYG6hvliNjfnPL/FyO5lZBLWUd3
 8IBTHPhgKEsJfbt3aupnZ2m78Yg1fmdZVhE/ZcOVxpIAIGMZlMfebGjKpVm/O8GcJlkqiU
 3LsS6TxKhYPrrHhCrGRitmaqKwYdfQb4FRyFQSRYtLkPGdUpfxMT57NUghNWeGtwtuWGjx
 TRhWGFNHG5I/Q42NI+kFeM5Edqw2gO0Xjq1D8TuWNSXzkrnAR+K6X+U12I41l2VNuWAZQ6
 sU5n6qWtWldSTiXxAk5r62X/zqcWuXGXWVe3/DCgBotctcj2dfYJs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=7
 tw3ro9tlDm5abogszBEi5u9EJ3j+tQmmeJ5BsAx9ug=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=bJFbk6IufajA2IyWE/wIFy6nod5yreFYT69m18l/AvgYSRgqXly9Cv9aEVAsSh7q87tE
 DFhebgYPDThzgHed1TO47KjvARNz3ozcMI9o654o+5k3iIhgx3Fty9NQHYmiszsRU5c04w
 OBuGevyxdFH08ngXQ38z29gaHGTDZNtAfxbc7LSWrN67Ry2aOjcX1Lehs5A2LwFGYjxVQH
 +mbIZHHnMYvPOGugsqYUjwlEbNbx7RS18YDfcICaaGSYTRlu+NJOxoCQ7dfnuQU/JKKU/c
 BzwndoFB4QjMawErInyq6JIxS0CEKkFjbaO6JxJEjPTvArRsyO92kwy/sZtiyU2Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=LVgj0FE6; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=5vNkjNX/;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=7tw3ro9t
 lDm5abogszBEi5u9EJ3j+tQmmeJ5BsAx9ug=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=LVgj0FE6LSOwvsZXKkxepJTf98uODIriu+C
 gCwwC2QxU62PtLktF2fR6BTPeVznm7bEe/e+3CJ5qZvLa1w5dUhgEghswJ3YC7UfeTRSqr
 2KteFvuxsfshz1k+cejWY4gLJVx1pU/QarNaCQJ37tXjVcCbLueY2fSk/Iw43bsSeiNt16
 039PDnBJKej/FHtUGmw29VRCTE+5cv9Da1K+J0X1BRqUuJ+fClNN2QUyPoK2JAjjwbx0Tj
 GGfnQAkPiJY2RRPwbZVTWuF0heR4GTyjgfgATU6h/sxhScOehVVqJVX1XcniYx/awI6OQQ
 8BKwmyRfJbP6rj3n/jpsVcigu3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=7tw3ro9tlDm5abogszBEi5u9EJ3j+tQmmeJ5BsAx9ug=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=5vNkjNX/T+1jtPagC6
 SZIXRdmkDAyDtpXGe3Qp0LDxL1Bnv5rAjkBHXp1gebeAk6BD0znjboRkNnotcEs0N1Cg==
Received: by mx2.catap.net (OpenSMTPD) id 9753e372;
 Thu, 29 Oct 2026 18:41:56 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id d2003ec3;
 Thu, 29 Oct 2026 18:41:48 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 23/26] hw/usb: add Octeon USB controller
Date: Thu, 29 Oct 2026 18:36:23 +0100
Message-ID: <20261029174139.44302-24-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174139.44302-1-kirill@korins.ky>
References: <20261029174139.44302-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add the Octeon UCTL wrapper around the DWC3 controller, including the
big endian register window, byte swapping, DMA mapping and interrupt
routing. Instantiate both EBB7304 USB controllers.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/Kconfig           |   1 +
 hw/mips/octeon.c          |  31 ++++
 hw/mips/octeon_internal.h |   6 +
 hw/usb/meson.build        |   5 +
 hw/usb/octeon_usb.c       | 319 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 362 insertions(+)
 create mode 100644 hw/usb/octeon_usb.c

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 5fe5f885e3..2566df6da6 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -73,6 +73,7 @@ config MIPS_OCTEON
     depends on MIPS64 && TARGET_BIG_ENDIAN
     select PFLASH_CFI02
     select SERIAL_MM
+    select USB_DWC3
 
 config MIPS_CPS
     bool
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 7e78511b8f..94717b6c89 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -287,6 +287,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_POW_BASE             0x1670000000000ULL
 #define OCTEON_POW_SIZE             0x2000
 
+#define OCTEON_CIU3_USB0_INTSN      0x68080
+#define OCTEON_CIU3_USB1_INTSN      0x69080
+
 #define OCTEON_UART0_BASE           0x1180000000800ULL
 #define OCTEON_UART0_ALIAS_BASE     0x1180000000c00ULL
 #define OCTEON_UART_TX_REG          0x40
@@ -1032,6 +1035,15 @@ static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
         *source = OCTEON_CIU3_SRC_UART0;
         return true;
     }
+    if (intsn == OCTEON_CIU3_USB0_INTSN) {
+        *source = OCTEON_CIU3_SRC_USB0;
+        return true;
+    }
+    if (intsn == OCTEON_CIU3_USB1_INTSN) {
+        *source = OCTEON_CIU3_SRC_USB1;
+        return true;
+    }
+
     if (intsn >= OCTEON_CIU3_MBOX_INTSN(0) &&
         intsn < OCTEON_CIU3_MBOX_INTSN(OCTEON_MAX_CPUS)) {
         *source = OCTEON_CIU3_SRC_MBOX0 +
@@ -1047,6 +1059,10 @@ static uint32_t octeon_ciu3_source_intsn(unsigned int source)
     switch (source) {
     case OCTEON_CIU3_SRC_UART0:
         return OCTEON_CIU3_UART0_INTSN;
+    case OCTEON_CIU3_SRC_USB0:
+        return OCTEON_CIU3_USB0_INTSN;
+    case OCTEON_CIU3_SRC_USB1:
+        return OCTEON_CIU3_USB1_INTSN;
     }
 
     if (source >= OCTEON_CIU3_SRC_MBOX0 &&
@@ -1061,6 +1077,8 @@ static bool octeon_ciu3_source_is_level(unsigned int source)
 {
     switch (source) {
     case OCTEON_CIU3_SRC_UART0:
+    case OCTEON_CIU3_SRC_USB0:
+    case OCTEON_CIU3_SRC_USB1:
         return true;
     }
 
@@ -2156,6 +2174,18 @@ void octeon_irq_set(void *opaque, int irq, int level)
         }
         qatomic_set(&s->intc->uart_pending, level);
         break;
+    case OCTEON_IRQ_USB0:
+        src = OCTEON_CIU3_SRC_USB0;
+        if (!octeon_ciu3_set_level(s, src, level)) {
+            return;
+        }
+        break;
+    case OCTEON_IRQ_USB1:
+        src = OCTEON_CIU3_SRC_USB1;
+        if (!octeon_ciu3_set_level(s, src, level)) {
+            return;
+        }
+        break;
     default:
         return;
     }
@@ -2791,6 +2821,7 @@ static void mips_octeon_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), OCTEON_POW_BASE,
                                 &s->pow);
 
+    octeon_init_usb(s);
     octeon_realize_peripherals(s);
 }
 
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index f2daa35cdb..6c93c957de 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -22,6 +22,7 @@
 #define OCTEON_MIO_BOOT_LOC_SIZE    0x100
 #define OCTEON_MIO_EMM_BUF_SIZE     512
 #define OCTEON_LMC_COUNT            4
+#define OCTEON_USB_COUNT            2
 #define OCTEON_TWSI_COUNT           2
 #define OCTEON_TWSI_STAT_IDLE       0xf8
 #define OCTEON_SPD_EEPROM_SIZE      139
@@ -29,11 +30,15 @@
 
 typedef enum OcteonIRQ {
     OCTEON_IRQ_UART,
+    OCTEON_IRQ_USB0,
+    OCTEON_IRQ_USB1,
     OCTEON_IRQ_COUNT,
 } OcteonIRQ;
 
 typedef enum OcteonCiu3Source {
     OCTEON_CIU3_SRC_UART0,
+    OCTEON_CIU3_SRC_USB0,
+    OCTEON_CIU3_SRC_USB1,
     OCTEON_CIU3_SRC_MBOX0,
     OCTEON_CIU3_SRC_COUNT = OCTEON_CIU3_SRC_MBOX0 + OCTEON_MAX_CPUS,
 } OcteonCiu3Source;
@@ -103,5 +108,6 @@ void octeon_irq_set(void *opaque, int irq, int level);
 void octeon_validate_ram_size(uint64_t ram_size);
 void octeon_init_spd(OcteonState *s);
 void octeon_init_twsi(OcteonState *s);
+void octeon_init_usb(OcteonState *s);
 
 #endif
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 429dcd6a24..a84b44e58d 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -29,6 +29,11 @@ system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
 system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
 system_ss.add(when: 'CONFIG_ASPEED_UDC', if_true: files('aspeed-udc.c'))
 
+if 'CONFIG_TCG' in config_all_accel
+  mips_ss.add(when: 'CONFIG_MIPS_OCTEON',
+              if_true: files('octeon_usb.c'))
+endif
+
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-regs.c'))
diff --git a/hw/usb/octeon_usb.c b/hw/usb/octeon_usb.c
new file mode 100644
index 0000000000..48e9ec234f
--- /dev/null
+++ b/hw/usb/octeon_usb.c
@@ -0,0 +1,319 @@
+/*
+ * QEMU Cavium Octeon USB controller model.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "hw/mips/octeon_internal.h"
+#include "hw/usb/hcd-dwc3.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+
+#define OCTEON_UCTL_SIZE            0x100
+#define OCTEON_USB0_UCTL_BASE       0x1180068000000ULL
+#define OCTEON_USB1_UCTL_BASE       0x1180069000000ULL
+#define OCTEON_USB0_DWC3_BASE       0x1680000000000ULL
+#define OCTEON_USB1_DWC3_BASE       0x1690000000000ULL
+#define OCTEON_UCTL_SHIM_CFG        0xe8
+#define OCTEON_UCTL_SHIM_CFG_CSR_BYTE_SWAP 0x3
+#define OCTEON_UCTL_SHIM_CFG_CSR_NATIVE    0x3
+
+#define TYPE_OCTEON_USB "octeon-usb"
+OBJECT_DECLARE_TYPE(OcteonUsbState, OcteonUsbClass, OCTEON_USB)
+
+struct OcteonUsbState {
+    SysBusDevice parent_obj;
+    USBDWC3 dwc3;
+    unsigned int index;
+    MemoryRegion uctl;
+    MemoryRegion dwc3_window;
+    AddressSpace dwc3_as;
+    GHashTable *regs;
+    bool dwc3_as_initialized;
+};
+
+struct OcteonUsbClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+static uint64_t octeon_uctl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonUsbState *usb = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t value;
+
+    if (!octeon_reg_lookup(usb->regs, reg, &value)) {
+        value = 0;
+    }
+
+    return octeon_read64(value, addr, size);
+}
+
+static void octeon_uctl_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
+{
+    OcteonUsbState *usb = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t old;
+
+    if (!octeon_reg_lookup(usb->regs, reg, &old)) {
+        old = 0;
+    }
+
+    octeon_reg_store(usb->regs, reg, octeon_write64(old, addr, value, size));
+}
+
+static const MemoryRegionOps octeon_uctl_ops = {
+    .read = octeon_uctl_read,
+    .write = octeon_uctl_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static bool octeon_usb_csr_needs_swap(OcteonUsbState *usb)
+{
+#if TARGET_BIG_ENDIAN
+    uint64_t value;
+
+    if (!octeon_reg_lookup(usb->regs, OCTEON_UCTL_SHIM_CFG, &value)) {
+        return true;
+    }
+
+    return (value & OCTEON_UCTL_SHIM_CFG_CSR_BYTE_SWAP) !=
+           OCTEON_UCTL_SHIM_CFG_CSR_NATIVE;
+#else
+    return false;
+#endif
+}
+
+static uint64_t octeon_usb_swap(uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 2:
+        return bswap16(value);
+    case 4:
+        return bswap32(value);
+    case 8:
+        return bswap64(value);
+    default:
+        return value;
+    }
+}
+
+static uint64_t octeon_dwc3_window_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    OcteonUsbState *usb = opaque;
+    uint64_t value;
+
+    switch (size) {
+    case 1:
+        value = address_space_ldub(&usb->dwc3_as, addr,
+                                   MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 2:
+        value = address_space_lduw_le(&usb->dwc3_as, addr,
+                                      MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 4:
+        value = address_space_ldl_le(&usb->dwc3_as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 8:
+        value = address_space_ldq_le(&usb->dwc3_as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (octeon_usb_csr_needs_swap(usb)) {
+        value = octeon_usb_swap(value, size);
+    }
+
+    return value;
+}
+
+static void octeon_dwc3_window_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size)
+{
+    OcteonUsbState *usb = opaque;
+
+    if (octeon_usb_csr_needs_swap(usb)) {
+        value = octeon_usb_swap(value, size);
+    }
+
+    switch (size) {
+    case 1:
+        address_space_stb(&usb->dwc3_as, addr, value,
+                          MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 2:
+        address_space_stw_le(&usb->dwc3_as, addr, value,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 4:
+        address_space_stl_le(&usb->dwc3_as, addr, value,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 8:
+        address_space_stq_le(&usb->dwc3_as, addr, value,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps octeon_dwc3_window_ops = {
+    .read = octeon_dwc3_window_read,
+    .write = octeon_dwc3_window_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void octeon_usb_reset_hold(Object *obj, ResetType type)
+{
+    OcteonUsbClass *ouc = OCTEON_USB_GET_CLASS(obj);
+    OcteonUsbState *usb = OCTEON_USB(obj);
+
+    if (ouc->parent_phases.hold) {
+        ouc->parent_phases.hold(obj, type);
+    }
+
+    g_hash_table_remove_all(usb->regs);
+}
+
+static void octeon_usb_realize(DeviceState *dev, Error **errp)
+{
+    OcteonUsbState *usb = OCTEON_USB(dev);
+    static const char * const uctl_name[OCTEON_USB_COUNT] = {
+        "octeon.usb0-uctl",
+        "octeon.usb1-uctl",
+    };
+    static const char * const dwc3_window_name[OCTEON_USB_COUNT] = {
+        "octeon.usb0-dwc3-window",
+        "octeon.usb1-dwc3-window",
+    };
+    static const char * const dwc3_as_name[OCTEON_USB_COUNT] = {
+        "octeon.usb0-dwc3-as",
+        "octeon.usb1-dwc3-as",
+    };
+    USBDWC3 *dwc3 = &usb->dwc3;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MemoryRegion *dwc3_mr;
+
+    object_property_set_link(OBJECT(&dwc3->sysbus_xhci), "dma",
+                             OBJECT(get_system_memory()), &error_abort);
+    qdev_prop_set_uint32(DEVICE(&dwc3->sysbus_xhci), "intrs", 1);
+    if (!sysbus_realize(SYS_BUS_DEVICE(dwc3), errp)) {
+        return;
+    }
+
+    dwc3_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dwc3), 0);
+    address_space_init(&usb->dwc3_as, dwc3_mr,
+                       dwc3_as_name[usb->index]);
+    usb->dwc3_as_initialized = true;
+    memory_region_init_io(&usb->uctl, OBJECT(dev), &octeon_uctl_ops, usb,
+                          uctl_name[usb->index], OCTEON_UCTL_SIZE);
+    sysbus_init_mmio(sbd, &usb->uctl);
+    memory_region_init_io(&usb->dwc3_window, OBJECT(dev),
+                          &octeon_dwc3_window_ops, usb,
+                          dwc3_window_name[usb->index], DWC3_SIZE);
+    sysbus_init_mmio(sbd, &usb->dwc3_window);
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&dwc3->sysbus_xhci));
+}
+
+static void octeon_usb_init(Object *obj)
+{
+    OcteonUsbState *usb = OCTEON_USB(obj);
+
+    usb->regs = g_hash_table_new_full(octeon_uint64_hash,
+                                      octeon_uint64_equal,
+                                      g_free, g_free);
+    object_initialize_child(obj, "dwc3", &usb->dwc3, TYPE_USB_DWC3);
+}
+
+static void octeon_usb_finalize(Object *obj)
+{
+    OcteonUsbState *usb = OCTEON_USB(obj);
+
+    if (usb->dwc3_as_initialized) {
+        address_space_destroy(&usb->dwc3_as);
+    }
+    g_hash_table_destroy(usb->regs);
+}
+
+static void octeon_usb_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    OcteonUsbClass *ouc = OCTEON_USB_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = octeon_usb_realize;
+    dc->user_creatable = false;
+    resettable_class_set_parent_phases(rc, NULL, octeon_usb_reset_hold, NULL,
+                                       &ouc->parent_phases);
+}
+
+static const TypeInfo octeon_usb_type_info = {
+    .name = TYPE_OCTEON_USB,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OcteonUsbState),
+    .instance_init = octeon_usb_init,
+    .instance_finalize = octeon_usb_finalize,
+    .class_size = sizeof(OcteonUsbClass),
+    .class_init = octeon_usb_class_init,
+};
+
+static void octeon_usb_register_types(void)
+{
+    type_register_static(&octeon_usb_type_info);
+}
+
+type_init(octeon_usb_register_types)
+
+void octeon_init_usb(OcteonState *s)
+{
+    static const uint64_t uctl_base[OCTEON_USB_COUNT] = {
+        OCTEON_USB0_UCTL_BASE,
+        OCTEON_USB1_UCTL_BASE,
+    };
+    static const uint64_t dwc3_base[OCTEON_USB_COUNT] = {
+        OCTEON_USB0_DWC3_BASE,
+        OCTEON_USB1_DWC3_BASE,
+    };
+    static const OcteonIRQ irq[OCTEON_USB_COUNT] = {
+        OCTEON_IRQ_USB0,
+        OCTEON_IRQ_USB1,
+    };
+    unsigned int i;
+
+    for (i = 0; i < OCTEON_USB_COUNT; i++) {
+        DeviceState *dev = qdev_new(TYPE_OCTEON_USB);
+        OcteonUsbState *usb = OCTEON_USB(dev);
+
+        usb->index = i;
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, uctl_base[i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, dwc3_base[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qemu_allocate_irq(octeon_irq_set, s, irq[i]));
+    }
+}
-- 
2.56.0



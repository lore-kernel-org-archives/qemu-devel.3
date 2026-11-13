Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEC606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=j6y5Hcbl;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=kOkh/7PC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzAv-0002tt-AF; Fri, 13 Nov 2026 16:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9p-0008IK-In
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:50:08 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9m-00060v-BX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:50:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=oRkQ63k
 XSEK3SNWdxLiW2BiOimURktHEkbBE5AbY5uPiWjH0bFaVhBHlI+92D7qNx04YG+uqTlFPV
 LjoWxn3Uk9MofM8VFiSLP+1rBgw1ZmMTmIfjXFEAqiIy0l3DYP4VmoL6akvGRieOOIg9Hp
 x008PgftlidOXMF8sCTqm4YL93wGNfJkd3gEmKsOSbr6V+X/DiTdeKh195anwk76OgQTbl
 l1Dlv/56msAReXUoYLG0HtDmxF80m1j70MHvBPCqREfz/WCjpSg2l4a4ohUdBD4uBCVTMH
 qKtTncQCHgVK13e7o+CZ9rH1nSu62V22NuemdXbZd8KCf6oPRgT5oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=3
 xocM7PkA18WbLqrc1kAlnm/nGjcr39uRQfQU/sPRBM=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=T47uQGQNCs5oue3V1tHKuEqaKve3nIxy3qr5XDe+mxhd6ziGibsIjUuemZh8hSXWEw1s
 ijUpJlXSj2mvaWD92zz2okXEVRU4ljJwInX0xMVvHikCvOCI47uCn/cX8sRmGKpE4c3alN
 s/yTtvWSlPqKepmgIqBAGXpMKfEjhVsWYNVa1rcdPd1KhHVw1tYoMBOLSi3MBVb8wOAXF5
 0wVAX5DzKwQIYo1JkcTcK3kktWW5+ErrpeQQCMvvl2M6te7oV57m8fa1YSWL4ZxyNpATXZ
 siOdBBYwpxfPYRZJLB2ApyknEbVj5Xg1zbGa6sQUghPgOD/ox+jYNPhNGhiyBLxQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=j6y5Hcbl; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=kOkh/7PC;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=3xocM7Pk
 A18WbLqrc1kAlnm/nGjcr39uRQfQU/sPRBM=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=j6y5HcblaYN/vHoA+FLJBs33ei1Tnwynh7p
 yu9RWBaSPGt8tTPnTTnepLUDsTTtT7UwRW7osOqDnqtWwY2yYO/bfsfMFCXV6LtfOSIupL
 2viPBBnHuRhCvnQJzVYnJKXr0xArEFiPC1iEPYu/xVdxdKMXumSWv87kbBvvslADDwAp/Q
 mK9RUxoR/j1FSJqDcQt7FOUMzOyUwVaG8u7HCBDaKdCpr3FHv7ZTRJORgvmE+q1Hy9ZXlw
 3JjUdgsc2eW8aImMifuSCig7+BYkfkQoSWZqeRXoAL4Y+2OF3PVn4id/yBh2SHsV0ztP+4
 ncaa0FtvM7QHISs034iLtA+JzlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=3xocM7PkA18WbLqrc1kAlnm/nGjcr39uRQfQU/sPRBM=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=kOkh/7PCMSk7CJdh2g
 kEt630tS5djUSnHpdXaocu1Pqp/UwbWlp8/dUcafitIOp3C/DUw46RliVxVR3d7RKHCQ==
Received: by mx1.catap.net (OpenSMTPD) id cc690933;
 Fri, 13 Nov 2026 22:49:51 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 36181590;
 Fri, 13 Nov 2026 22:49:33 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v8 18/26] hw/mips: wire the Octeon UART
Date: Fri, 13 Nov 2026 22:45:32 +0100
Message-ID: <20261113214926.98536-19-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

Wire the Octeon UART and its alias to the existing serial-mm device.
Provide the special transmit register window and connect the UART
interrupt to CIU and CIU3.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/Kconfig           |  1 +
 hw/mips/octeon.c          | 69 +++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |  5 +++
 3 files changed, 75 insertions(+)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index cb6057fe38..5fe5f885e3 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -72,6 +72,7 @@ config MIPS_OCTEON
     default y
     depends on MIPS64 && TARGET_BIG_ENDIAN
     select PFLASH_CFI02
+    select SERIAL_MM
 
 config MIPS_CPS
     bool
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 59754cb741..133b3636a0 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -10,6 +10,7 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
+#include "hw/char/serial-mm.h"
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
 #include "hw/core/boards.h"
@@ -48,7 +49,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
 #define TYPE_OCTEON_CSR_BANK "octeon-csr-bank"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 
+#define OCTEON_CSR_32BIT_SIZE       4
 #define OCTEON_CSR_64BIT_SIZE       8
+#define OCTEON_CSR_HI32_OFFSET      0
 
 /*
  * Clock defaults follow a Ubiquiti E1000 EBB7304 U-Boot banner.
@@ -155,6 +158,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_RST_BOOT_C_MUL_SHIFT 30
 #define OCTEON_RST_BOOT_PNR_MUL_SHIFT 24
 
+#define OCTEON_UART0_BASE           0x1180000000800ULL
+#define OCTEON_UART0_ALIAS_BASE     0x1180000000c00ULL
+#define OCTEON_UART_TX_REG          0x40
+#define OCTEON_UART_TX_HI32_OFFSET  OCTEON_CSR_HI32_OFFSET
+#define OCTEON_UART_TX_SIZE         OCTEON_CSR_64BIT_SIZE
+
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -1613,6 +1622,65 @@ static void octeon_init_mio_boot_loc(OcteonState *s)
 }
 
 
+static uint64_t octeon_uart_tx_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void octeon_uart_tx_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+
+    if (size == OCTEON_CSR_32BIT_SIZE &&
+        addr == OCTEON_UART_TX_HI32_OFFSET) {
+        return;
+    }
+
+    serial_io_ops.write(&s->uart->serial, 0, value & 0xff, 1);
+}
+
+static const MemoryRegionOps octeon_uart_tx_ops = {
+    .read = octeon_uart_tx_read,
+    .write = octeon_uart_tx_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void octeon_init_uart(OcteonState *s)
+{
+    SerialMM *uart;
+    qemu_irq uart_irq;
+    MemoryRegion *uart_mmio;
+    int baudbase = s->io_hz / 16;
+
+    uart_irq = qemu_allocate_irq(octeon_irq_set, s, OCTEON_IRQ_UART);
+    uart = serial_mm_init(get_system_memory(), OCTEON_UART0_BASE, 3, uart_irq,
+                          baudbase, serial_hd(0), DEVICE_BIG_ENDIAN);
+    s->uart = uart;
+
+    uart_mmio = sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0);
+    memory_region_init_alias(&s->uart_alias, NULL, "octeon.uart0-alias",
+                             uart_mmio, 0, memory_region_size(uart_mmio));
+    memory_region_add_subregion(get_system_memory(), OCTEON_UART0_ALIAS_BASE,
+                                &s->uart_alias);
+
+    memory_region_init_io(&s->uart_tx, NULL, &octeon_uart_tx_ops, s,
+                          "octeon.uart0-tx", OCTEON_UART_TX_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                OCTEON_UART0_BASE + OCTEON_UART_TX_REG,
+                                &s->uart_tx);
+    memory_region_init_io(&s->uart_alias_tx, NULL, &octeon_uart_tx_ops, s,
+                          "octeon.uart0-alias-tx", OCTEON_UART_TX_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                OCTEON_UART0_ALIAS_BASE + OCTEON_UART_TX_REG,
+                                &s->uart_alias_tx);
+}
+
+
 static void octeon_mio_reset_hold(Object *obj, ResetType type)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
@@ -1833,6 +1901,7 @@ static void mips_octeon_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), OCTEON_CIU3_BASE,
                                 &s->intc->ciu3);
 
+    octeon_init_uart(s);
     memory_region_init_io(&s->csr_bank->csr, OBJECT(s->csr_bank),
                           &octeon_csr_ops, s,
                           "octeon.csr", OCTEON_CSR_SIZE);
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 7b45daba10..fbe4875d66 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -10,6 +10,7 @@
 #define HW_MIPS_OCTEON_INTERNAL_H
 
 #include "qemu/typedefs.h"
+#include "hw/char/serial-mm.h"
 #include "system/memory.h"
 #include "target/mips/cpu.h"
 
@@ -64,6 +65,10 @@ struct OcteonState {
     OcteonRstState *rst;
     OcteonIntcState *intc;
     OcteonCsrBankState *csr_bank;
+    SerialMM *uart;
+    MemoryRegion uart_alias;
+    MemoryRegion uart_tx;
+    MemoryRegion uart_alias_tx;
 };
 
 guint octeon_uint64_hash(gconstpointer v);
-- 
2.56.0



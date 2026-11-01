Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985C606A336
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=WUvWwZvk;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=HSCEOw4t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWYt-00088L-9S; Sun, 01 Nov 2026 09:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXE-0006c5-37
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:52 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXA-000853-Q6
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=RCYFL9r
 tmxJEIfj0EwJHpohdJ/PmpU6c/vVzOhCCGjPmA1a3f99bU/4e6AvNcDP4yQKNQJYlU1NcY
 BYMahsC9RAkCVEaCfP6xtHt4gDbX1dCXkuBRSdMd/QNY4vHvdf7iJrC9aI4AQ4anMKLcte
 d54HOv+fiYDRC2qkVYPIgLZA20CD1chD3kRmtVZxQdVkNlPduTSMZ+BtepcWHhIaXYvsNN
 mCWCnsl2XlwtjCF641ZIBnIbQAiUALN5MQ3YuvEiqtj+fdT7ItfdmnqTUZtGOz/PNpbj2Y
 86yvH31NWIOrfyPMcyBpIAe1l+f2ece4JWQsZMF7ChMvXC7Ymu/jZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=S
 b+KbjYfZ+D0rAjYFTvxzPZMk1M6qGYHrlNtmkCjhSg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Aa8reGIzgk7rSHnXKYJstHn1wRocRzWuc7KWp+ThGiPUWD21HjP2FKENApOvMkEjFe/x
 OKpiOlSajA2QohgcWaI6W4ib1EwXmJyWGifmQpGzlszuwFAzvWgt6mY6CBYYh9UoU7v34j
 ABc+54xiQ5GkxE4nQ1Ze9RmLt0y8a0c8qgp7n4MT4E+HS/rm65nioHqkCvRVOEg9wA3QuM
 d5B2Q7UF1sdakcF4FyKVDx+pfwg2xMdPS6H2KuTEKsRMGqjoMYbp1V2n6ubfmWLhfgINa0
 1mSAjJQ3aLCFGzc2/Lm1OJXDyeZy4ZBKoUjni8EVgHN+8nTzqtkTq7Ay5JQtY8cg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=WUvWwZvk; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=HSCEOw4t;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Sb+KbjYf
 Z+D0rAjYFTvxzPZMk1M6qGYHrlNtmkCjhSg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=WUvWwZvkUrh1l4+jADsw2kOZGyMX8l2JSWB
 LV5UF29fmynJ4uunnBzzp1AAO77mAglanqLadbe+u9imTZlriflWePN8QRBhc9MOTN7ZIK
 zqZ3nsGBlpLT0b+LQOifRUxMC0DGqxUjLrWLxd+3Ip9jm80qTr5cQEDjanNelaksMizrDm
 EkijBXACzUBXcRXiR0H4Wth66SnQhH7D+bGKOiDn7YK1wSf9rLl7+Cr9C2RLdJOCDQyN3Y
 OZ1wiLE3LVaq1A5i58tuNgIllg42vSt5R6r7de5zZOtZTBMwogGqcUOR2Ri7L8KvsyV+Xd
 gINYbqvcokOKAtj29wrKXWG4n3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Sb+KbjYfZ+D0rAjYFTvxzPZMk1M6qGYHrlNtmkCjhSg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=HSCEOw4tqPw+OA01sT
 R3sFjex1f+hw4fqz+IGdzMQdHBvIjXs2RCKCkvgnFhQnUx6cKH/poruvskLjf6dt52DA==
Received: by mx2.catap.net (OpenSMTPD) id 65487aba;
 Sun, 1 Nov 2026 15:27:38 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 3978e8b8;
 Sun, 1 Nov 2026 15:27:31 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 18/26] hw/mips: wire the Octeon UART
Date: Sun,  1 Nov 2026 15:23:34 +0100
Message-ID: <20261101142723.41346-19-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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



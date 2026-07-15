Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96964C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzvB-0005fN-AL; Wed, 15 Jul 2026 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv9-0005cT-Mk
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:07 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv7-0007uq-Al
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=hfRmq9G
 u6/ptu0qU4beWYEPJZwpPMLFMyuXDC3LY5q82YXCrwogKw4heW7LrnpI4E/RlDT4u1bW85
 KSgeEktZ4YxX2ry0MF6lgwxl0MzVZfArj8i2uNCom6CdXvflIbReguyXIix6nZLtfFLYf1
 bWzf3Xxgoif1FDRdfNbKNdPl7ArNoB+G5WJqhqLRVVyz4GdFXLgX1zlD2PCflSM210SQMu
 SLTkbQSeLjcHuQKsbkBkJosAwHyt5btkOOt80e2Sut4xqGmEuLFVvnrWUIm1yBOZ2PuJZv
 rDQD+HTq8ivCOrn6VFKW6Ch4ejIEkdzjSgHSteI5jCOirzFZSdFJtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=u
 IbKli1QgdyezVxeAX0vcwMYcv2NNPb0R3DxNFoBUhM=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Y9d+QdLPkF076QOBSQwngM2jJVNvJ/wj0J+hLReeA1a9IEhYPHWt9Vb6uSTDpVruZI6I
 OR7JB8jWtQCg8qauiBte8fcMxy6C1sc7/c+LNrOBw8ElxPffjzVjeF+xyemuYubt5nulVT
 hnq+3CZuyiVAQuDx3gMaVOHKSCnQhdQE+rFBxppuVQ3vvYVPn9s0qRoRVjkCxWKyqG4h1L
 vUeIp0YwQaFjr8ebJyhVXbOOAUIZRuNBV/xuu/bCVhIC9fHa1po5uZ/I4xYbUjEKBz30j5
 ST+LzsUQWgtRdLu3mcljg2sjWa+/5LVQgwPkNTkO+WE4vsqQmRXhkC9PZGuQO8ww==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=TDB1Rx9t; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=pGakznMY;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=uIbKli1Q
 gdyezVxeAX0vcwMYcv2NNPb0R3DxNFoBUhM=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=TDB1Rx9tMd3EVxnMiqaGV4sXFBHbnbSNyDd
 kQ7HoSJS3S+m9orNNTGE2QnY80CkO/OWAfI9O7WXDQN+PE7krdjT3H7HnMu4QTTwJEUHjE
 DNHUNIvHI39zILeLy83irWZaaJjAYIJEve/kwel+ieV4T6lOmXdU5T0FSB/1QEz3ob4Z5z
 CDkZuN+4uui184s/dmi68PAu2ysSSt60VpqPL6zhhDeQ9/XWdMaRV92uo6jLQwQHaIISo2
 SK+13NuAjcdt4dCFOI5zXnKwP9YRzR+MpQJ+cxw2B8jmulZudGRoN8fmy5nCZbM23ze9Hg
 uZaACrXIYhmDJ+iUr6X9DZ7K9aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=uIbKli1QgdyezVxeAX0vcwMYcv2NNPb0R3DxNFoBUhM=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=pGakznMYFJlIASbLln
 VUneuqT0EVpzuArHAHpTgqgA7mhlvwZbqMvwWSihpHe5jblyXdBhQ6SQzlTuJJmg29CA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 32aa2197
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:53 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a91425ee;
 Wed, 15 Jul 2026 15:44:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 17/25] hw/mips: wire the Octeon UART
Date: Wed, 15 Jul 2026 15:44:03 +0200
Message-ID: <20260715134447.56007-18-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Wire the Octeon UART and its alias to the existing serial-mm device.
Provide the special transmit register window and connect the UART
interrupt to CIU and CIU3.
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
2.54.0



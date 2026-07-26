Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6056C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxzi-0002se-6a; Sun, 26 Jul 2026 08:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzW-0002X1-2i
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:30:05 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzS-0003Mi-Mf
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:30:01 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-848643382fcso1938533b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068997; x=1785673797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=27REuxPMNv1Fu0LlZWSG8x5hpH2IrRj0GYRJSZduzAA=;
 b=aIA8ylz+6NNZHAc7z9HaA0hVqYDyHkB6yNrlsr/4vpu8qi6FMJ5BoLm/S0r++Gr5ad
 jnhIPX+FlsnyrHzA3j4pvF5cyhcR8Aa9+iV8jdWy9jyL6Ci+pepDlt7nc1LaolVCutMT
 nKYAKxX3vHcKuqkFpQM/MbefJI1CaC9jEpjMTddeWRib/LlMm0IW7yjLD6bop7RocY8G
 z3gMNAZ2hIGDPyq3O7xwgnvTY10yzYzCmK3HZk1ReHXhBI0tPnp7dtLV7GtCMpTa700e
 j2gMQe2uFZYqE/RAu3464mTKXK6K1WgvnLuQUTBnX9HCm/YboTGYymIj+Mfbeq/mpq3E
 R9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068997; x=1785673797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=27REuxPMNv1Fu0LlZWSG8x5hpH2IrRj0GYRJSZduzAA=;
 b=szsETXh4haL7SNHWF+KTrV+ErVaudXAH6h5npeiS1/7TU+DtG7uicaPGOw3ai8qJEC
 bfJxrXprLm5/xoIXlcauJ/B1pf3cwQuIFdTLTFXKrtZ7ROSU4tvbNhAFiPIX9bnHjM76
 +KsSJ6y7QSoaFaRMULeEa2dnVbdXFdAXDKYgf++HrE0hWCvfE24FGapoghK7J7hzyNCc
 7df68Iy2qhLdO+iL+2XzQwjXdOat+4y1w9XGiUx7NfXysNIkbyzy7ZGiw3T4JtTF8VCW
 CGbEqO6cekChOpO5JeJRi1Au/RvxmB4ANLDWUbanctJs9/28WsR85LF5+shNsvvF/lCs
 uKdg==
X-Gm-Message-State: AOJu0YytV1PDJLE/bxEt+1r1q+3xuuxWtadM6RvsWZb1E66llwZyFoSO
 qaLfqlk6DINUefFf36Dzvsu1YN3WO9OCEcOk5AGinp6ilrzlS2xKnqTZJlS7v6lMsL0=
X-Gm-Gg: AR+sD11eFJ2vlgN6uCNeEpTj3k6vuClTqtqUADRkVf1+zY4wXIxd3VCRMKpLWv8a2P4
 JvRKSPS62KvA6p+aRftw0H8PNfnbxIrdd3WkxOVirM5LXolmTIDQW3t66vQRwHKzJ3tNbwfbHSI
 WWchgeljZQW97Ocufh/HimZc3f9v23Wpfce4ozRQMQ+BoxuiScXvDe1qXSV1Rr4Raj88T6gdaor
 g/d7BfnLOWXk5rjzOVG5kY9tjCnIbvW9CaYuME4av/1e1VhwvCgR5DpBXAmF3iJayhZ8QXBm7jA
 qcsgOREqoDCG/Q7yxOnml8uobecZ5yOWi/RraoNnqSFDEkWlZSv5JtYBECXzdReEHFgRa732kGj
 jefcNW5hP1g1n4FowSytakc3d4eoYmDKGrNwIaKRvCRIzXsY8kfjZrt4u+FFF8inU+xutS/i4+4
 +0VXOQaopKQxR0gnh0oKie
X-Received: by 2002:a05:6a00:438f:b0:843:468d:7804 with SMTP id
 d2e1a72fcca58-84e5949e987mr3923093b3a.34.1785068997038; 
 Sun, 26 Jul 2026 05:29:57 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:56 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 10/11] hw/ssi: Add K230 SSI XIP read window
Date: Sun, 26 Jul 2026 20:28:28 +0800
Message-ID: <3556bbff1b11bcebe0a4ea40c81ce0b859fcbe15.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Expose logical spi0's 128 MiB flash window as a second SSI MMIO region.
Gate accesses through HI_SYS XIP_EN and build Standard, Dual, or Quad
SDR read commands from the XIP instruction, address, mode, and
dummy-cycle registers.

PIO and IDMA cover explicit SPI transactions, while K230 firmware also
uses memory-mapped accesses to read spi0 flash. Model the XIP aperture so
this interface is visible to the guest.

Keep the window read-only, end each access with chip select inactive,
and discard stale PIO state before issuing an XIP command.

Cover the XIP gate, write rejection, 24-bit and 32-bit addressing, Quad
mode and dummy cycles, and PIO/XIP sharing in qtest.

Also verify that U-Boot can boot Linux through the XIP read path.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst     |   1 +
 hw/misc/k230_hi_sys.c          |   5 +
 hw/riscv/k230.c                |   9 +-
 hw/ssi/k230_dw_ssi.c           | 176 +++++++++++++++++++++++++++++++++
 include/hw/misc/k230_hi_sys.h  |   1 +
 include/hw/ssi/k230_dw_ssi.h   |   6 ++
 tests/qtest/k230-dw-ssi-test.c |  73 ++++++++++++++
 7 files changed, 268 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 3067c1b5d7..e92387ad98 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -23,6 +23,7 @@ The ``k230`` machine supports the following devices:
 * 3 K230 SSI controllers for SPI and QSPI
 * Optional SPI NOR flash on spi0 CS0
 * QSPI IDMA transfers for 8-bit SDR Dual and Quad modes
+* Read-only 128 MiB XIP window for spi0 flash
 
 Boot options
 ------------
diff --git a/hw/misc/k230_hi_sys.c b/hw/misc/k230_hi_sys.c
index 44f5ac61de..1514f28fac 100644
--- a/hw/misc/k230_hi_sys.c
+++ b/hw/misc/k230_hi_sys.c
@@ -115,6 +115,11 @@ void k230_hi_sys_set_ssi(K230HiSysState *s, unsigned int index,
     s->ssi[index] = ssi;
 }
 
+bool k230_hi_sys_xip_enabled(const K230HiSysState *s)
+{
+    return !!(s->ssi_ctrl & K230_SSI_CTRL_XIP_EN);
+}
+
 static void k230_hi_sys_reset(Object *obj, ResetType type)
 {
     K230HiSysState *s = K230_HI_SYS(obj);
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index a666a41c59..e8f3ea499e 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -262,6 +262,10 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
 
         k230_hi_sys_set_ssi(&s->hi_sys, logical_index,
                             &s->dw_ssi[route->ssi_index]);
+        if (logical_index == 0) {
+            k230_dw_ssi_set_hi_sys(&s->dw_ssi[route->ssi_index],
+                                   &s->hi_sys);
+        }
     }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hi_sys), errp)) {
@@ -284,6 +288,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                     memmap[K230_DEV_QSPI1].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dw_ssi[2]), 0,
                     memmap[K230_DEV_SPI].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dw_ssi[2]), 1,
+                    memmap[K230_DEV_FLASH].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->hi_sys), 0,
                     memmap[K230_DEV_HI_SYS_CFG].base);
 
@@ -432,9 +438,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
 
     create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
                                 memmap[K230_DEV_DDRC_CFG].size);
-
-    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
-                                memmap[K230_DEV_FLASH].size);
 }
 
 static void k230_soc_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index c1c4f40e07..d187e3345a 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -19,6 +19,7 @@
 #include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
+#include "hw/misc/k230_hi_sys.h"
 #include "hw/ssi/k230_dw_ssi.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
@@ -347,6 +348,11 @@ bool k230_dw_ssi_is_sleeping(const K230DwSsiState *s)
     return s->sleep_status;
 }
 
+void k230_dw_ssi_set_hi_sys(K230DwSsiState *s, K230HiSysState *hi_sys)
+{
+    s->hi_sys = hi_sys;
+}
+
 static void k230_dw_ssi_deselect(K230DwSsiState *s)
 {
     if (s->active_cs < 0) {
@@ -635,6 +641,171 @@ static uint32_t k230_dw_ssi_dummy_bytes(uint32_t spi_frf,
     return DIV_ROUND_UP(wait_cycles * lines, 8);
 }
 
+static bool k230_dw_ssi_xip_config_supported(K230DwSsiState *s)
+{
+    uint32_t spi_frf = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF);
+    uint32_t spi_ctrlr0 = s->regs[R_SPI_CTRLR0];
+    uint32_t required_lines;
+
+    switch (spi_frf) {
+    case 0:
+        required_lines = 1;
+        break;
+    case 1:
+        required_lines = 2;
+        break;
+    case 2:
+        required_lines = 4;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: XIP does not support SPI_FRF=%u\n",
+                      DEVICE(s)->canonical_path, spi_frf);
+        return false;
+    }
+
+    if (required_lines > s->max_lines ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, TRANS_TYPE) > 2) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported XIP line or transfer type\n",
+                      DEVICE(s)->canonical_path);
+        return false;
+    }
+
+    if (FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, SPI_DDR_EN) ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, INST_DDR_EN) ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, SPI_RXDS_EN) ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, SPI_RXDS_SIG_EN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: XIP DDR/RXDS mode is unsupported\n",
+                      DEVICE(s)->canonical_path);
+        return false;
+    }
+
+    return true;
+}
+
+static bool k230_dw_ssi_prepare_xip_command(
+    K230DwSsiState *s, hwaddr address, K230DwSsiEnhancedCommand *command)
+{
+    uint32_t spi_ctrlr0 = s->regs[R_SPI_CTRLR0];
+    uint32_t inst_l = FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, INST_L);
+    uint32_t addr_l = FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, ADDR_L);
+
+    command->instruction_bits =
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, XIP_INST_EN) && inst_l ?
+        1U << (inst_l + 1) : 0;
+    command->address_bits = addr_l << 2;
+    if (command->address_bits > 32) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported XIP address length %u bits\n",
+                      DEVICE(s)->canonical_path, command->address_bits);
+        return false;
+    }
+
+    command->mode_bits_enabled =
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, XIP_MD_BIT_EN);
+    if (command->mode_bits_enabled) {
+        uint32_t mode_length_encoding =
+            FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, XIP_MBL);
+
+        command->mode_bits = 1U << (mode_length_encoding + 1);
+    }
+
+    command->instruction = s->regs[R_XIP_INCR_INST] &
+        (uint32_t)MAKE_64BIT_MASK(0, command->instruction_bits);
+    command->address = (uint32_t)address &
+        (uint32_t)MAKE_64BIT_MASK(0, command->address_bits);
+    command->mode = s->regs[R_XIP_MODE_BITS] &
+        (uint32_t)MAKE_64BIT_MASK(0, command->mode_bits);
+    command->wait_cycles =
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, WAIT_CYCLES);
+    command->spi_frf = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF);
+    command->trans_type =
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, TRANS_TYPE);
+
+    return true;
+}
+
+static uint64_t k230_dw_ssi_xip_read(void *opaque, hwaddr address,
+                                     unsigned int size)
+{
+    K230DwSsiState *s = K230_DW_SSI(opaque);
+    K230DwSsiEnhancedCommand command = { 0 };
+    uint64_t value = 0;
+    uint32_t dummy_bytes;
+
+    if (!s->hi_sys || !k230_hi_sys_xip_enabled(s->hi_sys)) {
+        return 0;
+    }
+
+    if (!k230_dw_ssi_xip_config_supported(s) ||
+        !k230_dw_ssi_prepare_xip_command(s, address, &command)) {
+        return 0;
+    }
+
+    if (s->active_cs >= 0 || s->phase != K230_DW_SSI_PHASE_IDLE) {
+        k230_dw_ssi_abort_transfer(s);
+    }
+
+    k230_dw_ssi_select(s, 0);
+    if (s->active_cs != 0) {
+        return 0;
+    }
+
+    if (command.instruction_bits != 0) {
+        k230_dw_ssi_send_enhanced_field(s, command.instruction,
+                                         command.instruction_bits);
+    }
+    if (command.address_bits != 0) {
+        k230_dw_ssi_send_enhanced_field(s, command.address,
+                                         command.address_bits);
+    }
+    if (command.mode_bits_enabled) {
+        k230_dw_ssi_send_enhanced_field(s, command.mode,
+                                         command.mode_bits);
+    }
+
+    dummy_bytes = k230_dw_ssi_dummy_bytes(
+        command.spi_frf, command.trans_type, command.wait_cycles);
+    for (uint32_t i = 0; i < dummy_bytes; i++) {
+        ssi_transfer(s->spi, 0);
+    }
+
+    for (unsigned int i = 0; i < size; i++) {
+        value |= (uint64_t)(ssi_transfer(s->spi, 0) & 0xff) << (8 * i);
+    }
+
+    k230_dw_ssi_deselect(s);
+    return value;
+}
+
+static void k230_dw_ssi_xip_write(void *opaque, hwaddr address,
+                                  uint64_t value, unsigned int size)
+{
+    K230DwSsiState *s = K230_DW_SSI(opaque);
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: XIP write at 0x%" HWADDR_PRIx " is unsupported\n",
+                  DEVICE(s)->canonical_path, address);
+}
+
+static const MemoryRegionOps k230_dw_ssi_xip_ops = {
+    .read = k230_dw_ssi_xip_read,
+    .write = k230_dw_ssi_xip_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
 static bool k230_dw_ssi_idma_enabled(const K230DwSsiState *s)
 {
     return FIELD_EX32(s->regs[R_DMACR], DMACR, IDMAE);
@@ -1479,6 +1650,11 @@ static void k230_dw_ssi_init(Object *obj)
                           TYPE_K230_DW_SSI, K230_DW_SSI_MMIO_SIZE);
     sysbus_init_mmio(sbd, &s->mmio);
 
+    memory_region_init_io(&s->xip, obj, &k230_dw_ssi_xip_ops, s,
+                          TYPE_K230_DW_SSI ".xip",
+                          K230_DW_SSI_XIP_WINDOW_SIZE);
+    sysbus_init_mmio(sbd, &s->xip);
+
     for (int i = 0; i < K230_DW_SSI_IRQ_COUNT; i++) {
         sysbus_init_irq(sbd, &s->irqs[i]);
     }
diff --git a/include/hw/misc/k230_hi_sys.h b/include/hw/misc/k230_hi_sys.h
index 4c85da531e..5ef5d64543 100644
--- a/include/hw/misc/k230_hi_sys.h
+++ b/include/hw/misc/k230_hi_sys.h
@@ -50,5 +50,6 @@ struct K230HiSysState {
 
 void k230_hi_sys_set_ssi(K230HiSysState *s, unsigned int index,
                          K230DwSsiState *ssi);
+bool k230_hi_sys_xip_enabled(const K230HiSysState *s);
 
 #endif /* HW_MISC_K230_HI_SYS_H */
diff --git a/include/hw/ssi/k230_dw_ssi.h b/include/hw/ssi/k230_dw_ssi.h
index 49c137d73f..892384f8fb 100644
--- a/include/hw/ssi/k230_dw_ssi.h
+++ b/include/hw/ssi/k230_dw_ssi.h
@@ -30,6 +30,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(K230DwSsiState, K230_DW_SSI)
 #define K230_DW_SSI_REGS_SIZE 0x14c
 #define K230_DW_SSI_NUM_REGS \
     (K230_DW_SSI_REGS_SIZE / sizeof(uint32_t))
+#define K230_DW_SSI_XIP_WINDOW_SIZE 0x08000000
+
+typedef struct K230HiSysState K230HiSysState;
 
 /* SSI GPIO output ordering differs from RISR/ISR bit ordering. */
 typedef enum K230DwSsiIrq {
@@ -78,7 +81,9 @@ struct K230DwSsiState {
     SysBusDevice parent_obj;
 
     MemoryRegion mmio;
+    MemoryRegion xip;
     SSIBus *spi;
+    K230HiSysState *hi_sys;
     qemu_irq *cs_lines;
     qemu_irq irqs[K230_DW_SSI_IRQ_COUNT];
 
@@ -101,5 +106,6 @@ struct K230DwSsiState {
 
 uint32_t k230_dw_ssi_get_spi_mode(const K230DwSsiState *s);
 bool k230_dw_ssi_is_sleeping(const K230DwSsiState *s);
+void k230_dw_ssi_set_hi_sys(K230DwSsiState *s, K230HiSysState *hi_sys);
 
 #endif /* HW_SSI_K230_DW_SSI_H */
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index 6bae56b1a8..e69215ff6c 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -16,6 +16,7 @@
 #define K230_SPI2_BASE          0x91583000ULL
 #define K230_HI_SYS_BASE        0x91585000ULL
 #define K230_SSI_CTRL_ADDR      (K230_HI_SYS_BASE + 0x68)
+#define K230_FLASH_BASE         0xc0000000ULL
 #define K230_PLIC_BASE          0xf00000000ULL
 #define K230_PLIC_PENDING_BASE  0x1000
 #define K230_SSI_CTRLR0          0x000
@@ -83,6 +84,7 @@
 #define K230_SSI_SPI_CTRLR0_XIP_MD_EN     BIT(7)
 #define K230_SSI_SPI_CTRLR0_INST_L_8      (2U << 8)
 #define K230_SSI_SPI_CTRLR0_WAIT(v)       (((v) & 0x1fU) << 11)
+#define K230_SSI_SPI_CTRLR0_XIP_INST_EN   BIT(20)
 #define K230_SSI_SPI_CTRLR0_SPI_DDR_EN    BIT(16)
 #define K230_SSI_SPI_CTRLR0_XIP_MBL_8     (2U << 26)
 
@@ -469,6 +471,24 @@ static void assert_idma_stopped(QTestState *qts, size_t completed)
                      K230_SSI_SR_CMPLTD_DF_SHIFT, ==, completed);
 }
 
+static void enable_xip(QTestState *qts)
+{
+    qtest_writel(qts, K230_SSI_CTRL_ADDR,
+                 K230_SSI_CTRL_RESET | K230_SSI_CTRL_XIP_EN);
+}
+
+static void configure_xip_read(QTestState *qts, uint8_t opcode,
+                               unsigned int address_bits)
+{
+    uint32_t spi_ctrlr0 = K230_SSI_SPI_CTRLR0_TRANS_TYPE(0) |
+                          K230_SSI_SPI_CTRLR0_ADDR_L(address_bits) |
+                          K230_SSI_SPI_CTRLR0_INST_L_8 |
+                          K230_SSI_SPI_CTRLR0_XIP_INST_EN;
+
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_XIP_INCR_INST, opcode);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPI_CTRLR0, spi_ctrlr0);
+}
+
 static void test_register_contract(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -826,6 +846,58 @@ static void test_hi_sys(void)
     qtest_quit(qts);
 }
 
+static void test_xip_read_window(void)
+{
+    static const uint8_t id_expected[] = { 0xef, 0x40, 0x19 };
+    K230SsiFlashImage image;
+    QTestState *qts = k230_ssi_start_with_flash(&image);
+    uint64_t low_addr = K230_FLASH_BASE + K230_SSI_FLASH_PATTERN_ADDR;
+    uint32_t ctrlr0;
+    uint32_t spi_ctrlr0;
+    uint8_t command = FLASH_CMD_JEDEC;
+    uint8_t id[ARRAY_SIZE(id_expected)];
+
+    g_assert_cmphex(qtest_readl(qts, low_addr), ==, 0);
+    configure_xip_read(qts, FLASH_CMD_READ, 24);
+    enable_xip(qts);
+    g_assert_cmphex(qtest_readl(qts, low_addr), ==, 0xc33c5aa5);
+    qtest_writeb(qts, low_addr, 0);
+    g_assert_cmphex(qtest_readb(qts, low_addr), ==, 0xa5);
+
+    configure_xip_read(qts, FLASH_CMD_READ4, 32);
+    g_assert_cmphex(qtest_readl(qts, K230_FLASH_BASE +
+                                K230_SSI_FLASH_HIGH_ADDR),
+                    ==, 0x74737271);
+
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0);
+    ctrlr0 &= ~K230_SSI_CTRLR0_SPI_FRF_MASK;
+    ctrlr0 |= K230_SSI_FRF_QUAD << K230_SSI_CTRLR0_SPI_FRF_SHIFT;
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_CTRLR0, ctrlr0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_XIP_INCR_INST,
+                    FLASH_CMD_QUAD_IO);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_XIP_MODE_BITS, 0xff);
+    spi_ctrlr0 = K230_SSI_SPI_CTRLR0_TRANS_TYPE(1) |
+                 K230_SSI_SPI_CTRLR0_ADDR_L(24) |
+                 K230_SSI_SPI_CTRLR0_INST_L_8 |
+                 K230_SSI_SPI_CTRLR0_XIP_INST_EN |
+                 K230_SSI_SPI_CTRLR0_XIP_MD_EN |
+                 K230_SSI_SPI_CTRLR0_XIP_MBL_8 |
+                 K230_SSI_SPI_CTRLR0_WAIT(4);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPI_CTRLR0, spi_ctrlr0);
+    g_assert_cmphex(qtest_readl(qts, low_addr), ==, 0xc33c5aa5);
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_TR, 8, 0);
+    configure_xip_read(qts, FLASH_CMD_READ, 24);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+    g_assert_cmphex(qtest_readb(qts, low_addr), ==, 0xa5);
+    flash_read_transaction(qts, &command, 1, id, sizeof(id));
+    g_assert_cmpmem(id, sizeof(id), id_expected, sizeof(id_expected));
+    g_assert_cmphex(qtest_readb(qts, low_addr), ==, 0xa5);
+
+    qtest_quit(qts);
+    k230_ssi_flash_image_clear(&image);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -840,5 +912,6 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dw-ssi/qspi-sdr", test_qspi_sdr);
     qtest_add_func("/k230-dw-ssi/idma", test_idma);
     qtest_add_func("/k230-dw-ssi/hi-sys", test_hi_sys);
+    qtest_add_func("/k230-dw-ssi/xip-read-window", test_xip_read_window);
     return g_test_run();
 }
-- 
2.43.0



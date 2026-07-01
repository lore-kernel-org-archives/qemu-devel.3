Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2705BC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2x-0004is-Ru; Wed, 01 Jul 2026 06:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2w-0004iJ-CH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:58 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2s-00051F-TA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:58 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso825268c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901193; x=1783505993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cMQJZgkOEAQK4yPv3fx/MlggqyUj2zpuhGpligitmA=;
 b=qGuG243OHtSIBwM7TO91ecsyf4wbqoyOXM0OHvCrww2+XgsaF4UGcOtNaqlARXW2qa
 84OZNMqFhxP03DkHAB4SVn7jVN0CS+GPVI5PYyxbJU3L6TOsBYZatdcJQGGuCTbnbhWv
 iYFqW+oL4QvYdq22CSs5ctbM7kOK+3cFFI5vFFGN8WzrAseL7uatMBuw5wpWoSEpDaXJ
 fM3L/YSqn//gMeUVuDmZvOldhQm6WXkuLl3vU2xOmKWPYyV2DVod2fzLcCmcsJd09C4h
 +7snJWJIhNk0xEOCBgb/DeTSwWKpe5IOajYW+519EbAzJut+zMy9+60/f2A2V9LeR4wh
 409A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901193; x=1783505993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0cMQJZgkOEAQK4yPv3fx/MlggqyUj2zpuhGpligitmA=;
 b=EhgE0NsxdiyAW35aXUiXPXQ+imnhgRHLDVInNYaySCVJ5KaKbAiZck4ATAyVKVqBAm
 AWEdNNZx88wdo+MhtE99nx6IaQpMp8eZG4yVKU+nMY2GLipj5Te1zzNKydyQiGr4oeyz
 VV9fC/0H8+ITO4i2T8lvw9Pjl8BR3Lbm8SkbT7BahLON3rQfkFsP0JpfHYtsYGGP36fM
 T7/wHeBxtxLYQbyPHazdCaOrLUESSgyQSng8FNE/jUtD5gst2pOy8qcL3UQytZQpIk3i
 WEb+7GeSLC0C1vNmpmVW7pqlKYFsESlv5dYOo57J1Ho7onFdF0YdfJWcIu+C28re41hY
 Bi5Q==
X-Gm-Message-State: AOJu0Yzcg1TvM1fi8BCW1VUWwoAzvWjGjvyYM6vH5AAGLRxjQ+blRVck
 gNOMJz0w1o3gKT7GM9fs3Ke3vqGCoG2sejkDTtGYwfPAwsJZkt2/mNeI4MGRLw==
X-Gm-Gg: AfdE7clZIPxONAj3X6O7XzijBdKQq3K9L0eGXq84eGaowvYBVl8Zi70TkOhVVos18/o
 IU2aoGCaMXfrnSWSHWOt1Mxu2jebDpCSfRdhCvX3OmJSOLHdF0OclJRNG9AxH0ylEh0vgB9fhKd
 Y4nsguFVaAz9z+hvp53RgEoHlS8wjsrOLOKi/i//W0xIPNdPG/wXYBu2fzy/7WDD4nZ57Qv1RdN
 Q/Js05bATc7jXL2Ed/U0qza8ta9O2Rrdr/H+nvouOZNVqqrlr9lnYu/WjYUcAE5tbIjKlVnQ0Mu
 b+axkcrKkQrZxiwO3H8nbHM0QB7YTzEfWk8Gab1KQG4EEhzjVwQCQdP9NcmgjC/m69KqeYR+aaW
 wtE/+QTOV6tl7Sji+a65kNtbUfphl+AIvgM+nOU5HkSWaWo2JjJ9iypvO7LrsIK34VaLh35Cw9w
 qNaS6EMT1T3q0GrOw5NfRwRIVSy4vRjwQ=
X-Received: by 2002:a05:7022:e17:b0:139:f599:8124 with SMTP id
 a92af1059eb24-13b36d86554mr1117679c88.3.1782901193147; 
 Wed, 01 Jul 2026 03:19:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/39] hw/riscv: Add Tenstorrent Atlantis machine
Date: Wed,  1 Jul 2026 20:17:46 +1000
Message-ID: <20260701101752.2522962-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122f.google.com
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

From: Joel Stanley <joel@jms.id.au>

The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
and CoreLab Technology. It is based on the Atlantis SoC, which includes
the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
RISC-V CPU.

Add the tt-atlantis machine containing serial console, interrupt
controllers, and device tree support.

The Atlantis boot images loaded from include OpenSBI and an initial DTB
that is passed to OpenSBI. This is approximated in the model by having
QEMU build the device tree rather than load a DTB image directly.
Subsequent stages may use the modified DTB provided by OpenSBI or opt to
supply their own.

  qemu-system-riscv64 -M tt-atlantis -m 512M \
   -kernel Image -initrd rootfs.cpio -nographic

Co-Developed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260630024952.1520546-8-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                       |  12 +
 docs/system/riscv/tt_atlantis.rst |  41 +++
 docs/system/target-riscv.rst      |   1 +
 include/hw/riscv/tt_atlantis.h    |  50 +++
 hw/riscv/tt_atlantis.c            | 523 ++++++++++++++++++++++++++++++
 hw/riscv/Kconfig                  |  10 +
 hw/riscv/meson.build              |   1 +
 7 files changed, 638 insertions(+)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/riscv/tt_atlantis.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecfd7159d..a6d1e1f676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1790,6 +1790,18 @@ F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 F: tests/functional/riscv64/test_sifive_u.py
 
+Tenstorrent Machines
+M: Joel Stanley <joel@jms.id.au>
+M: Nicholas Piggin <npiggin@gmail.com>
+R: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
+R: Michael Ellerman <mpe@kernel.org>
+R: Portia Stephens <portias@oss.tenstorrent.com>
+L: qemu-riscv@nongnu.org
+S: Supported
+F: docs/system/riscv/tt_*.rst
+F: hw/riscv/tt_*.c
+F: include/hw/riscv/tt_*.h
+
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
 S: Maintained
diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
new file mode 100644
index 0000000000..1f2880d617
--- /dev/null
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -0,0 +1,41 @@
+Tenstorrent Atlantis (``tt-atlantis``)
+======================================
+
+The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
+and CoreLab Technology. It is based on the Atlantis SoC, which includes
+the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
+
+The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
+RISC-V CPU.
+
+tt-atlantis QEMU model features
+-------------------------------
+
+* 8-core Ascalon-X CPU Cluster
+* RISC-V compliant Advanced Interrupt Architecture
+* 16550A compatible UART
+
+Known limitations
+-----------------
+
+The QEMU tt-atlantis machine does not yet model every device on the
+real platform. Notably:
+
+* There is no PCI host bridge, so virtio-pci devices cannot be
+  attached. Boots that need block storage must use ``-initrd`` with
+  an initramfs.
+* The DesignWare UART is modelled with QEMU's ns16550-compatible
+  ``serial_mm`` device; DesignWare-specific registers beyond that
+  set return 0.
+
+Supported software
+------------------
+
+The Tenstorrent Ascalon CPUs avoid proprietary or non-standard
+extensions, so compatibility with existing software is generally
+good. The QEMU tt-atlantis machine works with upstream OpenSBI
+and Linux with default configurations.
+
+The development board hardware will require some implementation
+specific setup in firmware which is being developed and may
+become a requirement or option for the tt-atlantis machine.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 896f14e78b..2639866a3e 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -72,6 +72,7 @@ undocumented; you can get a complete list by running
    riscv/mips
    riscv/shakti-c
    riscv/sifive_u
+   riscv/tt_atlantis
    riscv/virt
    riscv/xiangshan-kunminghu
 
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
new file mode 100644
index 0000000000..a17732ce81
--- /dev/null
+++ b/include/hw/riscv/tt_atlantis.h
@@ -0,0 +1,50 @@
+/*
+ * Tenstorrent Atlantis RISC-V System on Chip
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Tenstorrent, Joel Stanley <joel@jms.id.au>
+ */
+
+#ifndef HW_RISCV_TT_ATLANTIS_H
+#define HW_RISCV_TT_ATLANTIS_H
+
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/riscv/riscv_hart.h"
+
+#define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
+OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
+
+struct TTAtlantisState {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+    Notifier machine_done;
+    const MemMapEntry *memmap;
+
+    RISCVHartArrayState soc;
+    DeviceState *irqchip;
+
+    int fdt_size;
+};
+
+enum {
+    TT_ATL_UART1_IRQ = 39,
+};
+
+enum {
+    TT_ATL_ACLINT,
+    TT_ATL_BOOTROM,
+    TT_ATL_DDR_LO,
+    TT_ATL_DDR_HI,
+    TT_ATL_MAPLIC,
+    TT_ATL_MIMSIC,
+    TT_ATL_SAPLIC,
+    TT_ATL_SIMSIC,
+    TT_ATL_UART1,
+};
+
+#endif
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
new file mode 100644
index 0000000000..1f0cd08ac9
--- /dev/null
+++ b/hw/riscv/tt_atlantis.c
@@ -0,0 +1,523 @@
+/*
+ * Tenstorrent Atlantis RISC-V System on Chip
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Tenstorrent, Joel Stanley <joel@jms.id.au>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qemu/guest-random.h"
+#include "qemu/units.h"
+
+#include "hw/core/boards.h"
+#include "hw/core/loader.h"
+#include "hw/core/sysbus.h"
+
+#include "target/riscv/cpu.h"
+#include "target/riscv/pmu.h"
+
+#include "hw/riscv/boot.h"
+#include "hw/riscv/fdt-common.h"
+#include "hw/riscv/machines-qom.h"
+#include "hw/riscv/riscv_hart.h"
+
+#include "hw/char/serial-mm.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/misc/unimp.h"
+
+#include "system/system.h"
+#include "system/device_tree.h"
+
+#include "hw/riscv/tt_atlantis.h"
+
+#include "aia.h"
+
+#define TT_IRQCHIP_NUM_MSIS       255
+#define TT_IRQCHIP_NUM_SOURCES    128
+#define TT_IRQCHIP_NUM_PRIO_BITS  3
+#define TT_IRQCHIP_GUESTS         63 /* aia_guests, gives guest_index_bits=6 */
+#define TT_IRQCHIP_MIMSIC_STRIDE  0x40000
+
+#define TT_ACLINT_MTIME_SIZE    0x8050
+#define TT_ACLINT_MTIME         0x0
+#define TT_ACLINT_MTIMECMP      0x8000
+#define TT_ACLINT_TIMEBASE_FREQ 1000000000
+
+static const MemMapEntry tt_atlantis_memmap[] = {
+    /* Keep sorted with :'<,'>!sort -g -k 4 */
+    [TT_ATL_DDR_LO] =           { 0x00000000,    0x80000000 },
+    [TT_ATL_BOOTROM] =          { 0x80000000,        0x2000 },
+    [TT_ATL_MIMSIC] =           { 0xa0000000,      0x200000 },
+    [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
+    [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
+    [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
+    [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
+};
+
+static uint32_t fdt_phandle = 1;
+static uint32_t next_phandle(void)
+{
+    return fdt_phandle++;
+}
+
+static void create_fdt_memory(TTAtlantisState *s)
+{
+    void *fdt = MACHINE(s)->fdt;
+    hwaddr size_lo = MACHINE(s)->ram_size;
+    hwaddr size_hi = 0;
+
+    if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
+        size_lo = s->memmap[TT_ATL_DDR_LO].size;
+        size_hi = MACHINE(s)->ram_size - size_lo;
+    }
+
+    create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo,
+                             0, false);
+    if (size_hi) {
+        /*
+         * The first part of the HI address is aliased at the LO address
+         * so do not include that as usable memory. Is there any way
+         * (or good reason) to describe that aliasing 2GB with DT?
+         */
+        create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_HI].base + size_lo,
+                                 size_hi, 0, false);
+    }
+}
+
+static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
+{
+    void *fdt = MACHINE(s)->fdt;
+    g_autofree char *name = NULL;
+    g_autofree uint32_t *aclint_mtimer_cells = NULL;
+    uint32_t aclint_cells_size;
+    hwaddr addr;
+
+    aclint_mtimer_cells = g_new0(uint32_t, s->soc.num_harts * 2);
+
+    for (int cpu = 0; cpu < s->soc.num_harts; cpu++) {
+        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
+    }
+    aclint_cells_size = s->soc.num_harts * sizeof(uint32_t) * 2;
+
+    addr = s->memmap[TT_ATL_ACLINT].base;
+
+    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIX, addr);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mtimer");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, addr + TT_ACLINT_MTIME,
+                                 2, 0x1000,
+                                 2, addr + TT_ACLINT_MTIMECMP,
+                                 2, 0x1000);
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     aclint_mtimer_cells, aclint_cells_size);
+}
+
+static void create_fdt_one_imsic(void *fdt, const MemMapEntry *mem, int cpus,
+                                 uint32_t *intc_phandles, uint32_t msi_phandle,
+                                 int irq_line, uint32_t imsic_guest_bits)
+{
+    g_autofree char *name = NULL;
+    g_autofree uint32_t *imsic_cells = g_new0(uint32_t, cpus * 2);
+
+    for (int cpu = 0; cpu < cpus; cpu++) {
+        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        imsic_cells[cpu * 2 + 1] = cpu_to_be32(irq_line);
+    }
+
+    name = g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIX, mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,imsics");
+
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
+    qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, name, "msi-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     imsic_cells, sizeof(uint32_t) * cpus * 2);
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "riscv,num-ids", TT_IRQCHIP_NUM_MSIS);
+
+    if (imsic_guest_bits) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,guest-index-bits",
+                              imsic_guest_bits);
+    }
+    qemu_fdt_setprop_cell(fdt, name, "phandle", msi_phandle);
+}
+
+static void create_fdt_one_aplic(void *fdt,
+                                 const MemMapEntry *mem,
+                                 uint32_t msi_phandle,
+                                 uint32_t *intc_phandles,
+                                 uint32_t aplic_phandle,
+                                 uint32_t aplic_child_phandle,
+                                 int irq_line, int num_harts)
+{
+    g_autofree char *name =
+        g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIX, mem->base);
+    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
+
+    for (int cpu = 0; cpu < num_harts; cpu++) {
+        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aplic_cells[cpu * 2 + 1] = cpu_to_be32(irq_line);
+    }
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aplic");
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 2);
+    qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
+
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     aplic_cells, num_harts * sizeof(uint32_t) * 2);
+    qemu_fdt_setprop_cell(fdt, name, "msi-parent", msi_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "riscv,num-sources",
+                          TT_IRQCHIP_NUM_SOURCES);
+
+    if (aplic_child_phandle) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,children",
+                              aplic_child_phandle);
+        qemu_fdt_setprop_cells(fdt, name, "riscv,delegation",
+                               aplic_child_phandle, 1, TT_IRQCHIP_NUM_SOURCES);
+    }
+
+    qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
+}
+
+static void create_fdt_pmu(TTAtlantisState *s)
+{
+    char pmu_name[] = "/pmu";
+    void *fdt = MACHINE(s)->fdt;
+    RISCVCPU *hart = &s->soc.harts[0];
+
+    qemu_fdt_add_subnode(fdt, pmu_name);
+    qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
+    riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
+}
+
+static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
+                           uint32_t aplic_s_phandle,
+                           uint32_t imsic_s_phandle)
+{
+    MachineState *ms = MACHINE(s);
+    void *fdt = MACHINE(s)->fdt;
+    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
+
+    fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
+
+    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
+                           s->soc.hartid_base, &fdt_phandle, intc_phandles,
+                           false, false);
+
+    create_fdt_memory(s);
+
+    create_fdt_aclint(s, intc_phandles);
+
+    uint32_t imsic_guest_bits = imsic_num_bits(TT_IRQCHIP_GUESTS + 1);
+
+    /* M-level IMSIC node */
+    uint32_t msi_m_phandle = next_phandle();
+    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
+                         intc_phandles, msi_m_phandle,
+                         IRQ_M_EXT, imsic_guest_bits);
+
+    /* S-level IMSIC node */
+    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
+                         intc_phandles, imsic_s_phandle,
+                         IRQ_S_EXT, imsic_guest_bits);
+
+    uint32_t aplic_m_phandle = next_phandle();
+
+    /* M-level APLIC node */
+    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
+                         msi_m_phandle, intc_phandles,
+                         aplic_m_phandle, aplic_s_phandle,
+                         IRQ_M_EXT, s->soc.num_harts);
+
+    /* S-level APLIC node */
+    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
+                         imsic_s_phandle, intc_phandles,
+                         aplic_s_phandle, 0,
+                         IRQ_S_EXT, s->soc.num_harts);
+}
+
+static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
+                            int irqchip_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
+                                            mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
+    qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
+
+    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
+}
+
+static void create_fdt_rng(void *fdt)
+{
+    uint8_t rng_seed[32];
+
+    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
+}
+
+static void finalize_fdt(TTAtlantisState *s)
+{
+    uint32_t aplic_s_phandle = next_phandle();
+    uint32_t imsic_s_phandle = next_phandle();
+    void *fdt = MACHINE(s)->fdt;
+
+    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
+
+    /*
+     * We want to do this, but the Linux aplic driver was broken before v6.16
+     *
+     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-parent",
+     *                       aplic_s_phandle);
+     */
+
+    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
+                    aplic_s_phandle);
+}
+
+static void create_fdt(TTAtlantisState *s)
+{
+    MachineState *ms = MACHINE(s);
+
+    ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
+                                       "tenstorrent,atlantis", &s->fdt_size);
+
+    qemu_fdt_add_subnode(ms->fdt, "/chosen");
+
+    create_fdt_rng(ms->fdt);
+
+    qemu_fdt_add_subnode(ms->fdt, "/aliases");
+
+    create_fdt_pmu(s);
+}
+
+static void load_fdt(TTAtlantisState *s)
+{
+    MachineState *ms = MACHINE(s);
+    char **node_path;
+    Error *err = NULL;
+
+    ms->fdt = load_device_tree(ms->dtb, &s->fdt_size);
+    if (!ms->fdt) {
+        error_report("load_device_tree() failed");
+        exit(1);
+    }
+
+    qemu_fdt_add_path(ms->fdt, "/chosen");
+
+    /* Clear memory nodes and update with the specified RAM size */
+    node_path = qemu_fdt_node_unit_path(ms->fdt, "memory", &err);
+    if (err) {
+        warn_report_err(err);
+    } else {
+        for (int i = 0; node_path[i]; i++) {
+            warn_report("Replacing device tree %s with the requested RAM size",
+                        node_path[i]);
+            qemu_fdt_nop_node(ms->fdt, node_path[i]);
+        }
+        g_strfreev(node_path);
+    }
+
+    create_fdt_memory(s);
+}
+
+static void tt_atlantis_machine_done(Notifier *notifier, void *data)
+{
+    TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
+    MachineState *machine = MACHINE(s);
+    hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
+    hwaddr mem_size;
+    target_ulong firmware_end_addr, kernel_start_addr;
+    const char *firmware_name = riscv_default_firmware_name(&s->soc);
+    uint64_t fdt_load_addr;
+    uint64_t kernel_entry;
+    RISCVBootInfo boot_info;
+
+    /*
+     * A user provided dtb must include everything, including
+     * dynamic sysbus devices. Our FDT needs to be finalized.
+     */
+    if (machine->dtb == NULL) {
+        finalize_fdt(s);
+    }
+
+    mem_size = machine->ram_size;
+    if (mem_size > s->memmap[TT_ATL_DDR_LO].size) {
+        mem_size = s->memmap[TT_ATL_DDR_LO].size;
+    }
+    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc,
+                                       s->memmap[TT_ATL_DDR_LO].base,
+                                       mem_size);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
+                                                     &start_addr, NULL);
+
+    kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                     firmware_end_addr);
+    if (machine->kernel_filename) {
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+    }
+    kernel_entry = boot_info.image_low_addr;
+
+    fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
+                                           s->memmap[TT_ATL_DDR_LO].size,
+                                           machine, &boot_info);
+    riscv_load_fdt(fdt_load_addr, machine->fdt);
+
+    /* load the reset vector */
+    riscv_setup_rom_reset_vec(machine, &s->soc, start_addr,
+                              s->memmap[TT_ATL_BOOTROM].base,
+                              s->memmap[TT_ATL_BOOTROM].size,
+                              kernel_entry,
+                              fdt_load_addr);
+}
+
+static void tt_atlantis_machine_init(MachineState *machine)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
+
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
+    MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
+    MemoryRegion *bootrom = g_new(MemoryRegion, 1);
+    ram_addr_t lo_ram_size;
+    int hart_count = machine->smp.cpus;
+
+    s->memmap = tt_atlantis_memmap;
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_HART_ARRAY);
+    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "hartid-base", 0,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "num-harts", hart_count,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "resetvec",
+                            s->memmap[TT_ATL_BOOTROM].base,
+                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+
+    s->irqchip = riscv_create_aia(true, TT_IRQCHIP_GUESTS,
+                                  TT_IRQCHIP_MIMSIC_STRIDE,
+                                  TT_IRQCHIP_NUM_SOURCES,
+                                  &s->memmap[TT_ATL_MAPLIC],
+                                  &s->memmap[TT_ATL_SAPLIC],
+                                  &s->memmap[TT_ATL_MIMSIC],
+                                  &s->memmap[TT_ATL_SIMSIC],
+                                  0, 0, hart_count,
+                                  TT_IRQCHIP_NUM_MSIS,
+                                  TT_IRQCHIP_NUM_PRIO_BITS);
+
+    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
+            TT_ACLINT_MTIME_SIZE,
+            0, hart_count,
+            TT_ACLINT_MTIMECMP,
+            TT_ACLINT_MTIME,
+            TT_ACLINT_TIMEBASE_FREQ, true);
+
+    /*
+     * DDR
+     *
+     * The high address is where RAM lives. It is always present and may be
+     * up to 64GB. The low address is an alias of the first 2GB of that RAM.
+     */
+    if (machine->ram_size > s->memmap[TT_ATL_DDR_HI].size) {
+        char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
+        error_report("RAM size is too large, maximum is %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
+                             0, machine->ram_size);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_DDR_HI].base, ram_hi);
+
+    lo_ram_size = MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size);
+    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
+                             0, lo_ram_size);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_DDR_LO].base, ram_lo);
+
+    /* Boot ROM */
+    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
+                           s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, s->memmap[TT_ATL_BOOTROM].base,
+                                bootrom);
+
+    /* UART1, the soc console (UART0 is for the boot microcontroller) */
+    serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
+                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+    /*
+     * Atlantis contains a DesignWare uart while the QEMU machine
+     * uses the serial_mm model with the base ns16550 register set.
+     * Linux's dw driver writes outside of serial_mm's 0x20 sized
+     * mapping and faults.
+     *
+     * Create an unimplemented device region so writes don't fault
+     * and reads return zero, which keeps Linux happy.
+     */
+    create_unimplemented_device("tt-atlantis.uart0",
+                                s->memmap[TT_ATL_UART1].base,
+                                s->memmap[TT_ATL_UART1].size);
+
+    /* Load or create device tree */
+    if (machine->dtb) {
+        load_fdt(s);
+    } else {
+        create_fdt(s);
+    }
+
+    s->machine_done.notify = tt_atlantis_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Tenstorrent Atlantis RISC-V SoC (Experimental)";
+    mc->init = tt_atlantis_machine_init;
+    mc->max_cpus = 8;
+    mc->default_cpus = 8;
+    mc->default_ram_size = 4 * GiB;
+    mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
+    mc->block_default_type = IF_VIRTIO;
+    mc->no_cdrom = 1;
+    mc->default_ram_id = "tt_atlantis.ram";
+}
+
+static const TypeInfo tt_atlantis_types[] = {
+    {
+        .name       = MACHINE_TYPE_NAME("tt-atlantis"),
+        .parent     = TYPE_MACHINE,
+        .class_init = tt_atlantis_machine_class_init,
+        .instance_size = sizeof(TTAtlantisState),
+        .interfaces = riscv64_machine_interfaces,
+    },
+};
+
+DEFINE_TYPES(tt_atlantis_types)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..5033415440 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -120,6 +120,16 @@ config SPIKE
     select RISCV_ACLINT
     select SIFIVE_PLIC
 
+config TENSTORRENT
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select SERIAL_MM
+    select DEVICE_TREE
+
 config XIANGSHAN_KUNMINGHU
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 798477b788..0d82ceacc4 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -11,6 +11,7 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
+riscv_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
-- 
2.54.0



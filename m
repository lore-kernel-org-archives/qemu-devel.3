Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5387D232E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RE-0005mg-M7; Fri, 09 Jan 2026 01:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qh-0005Qp-DW
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:05 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qe-0002xV-Li
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:03 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so2511034a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941819; x=1768546619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjPsO1iN8zblKX1agU+MryhlTz3TLPeuoLfrtv2SguQ=;
 b=CAzk9m9yHEi4w2KTtANY55QaTSWy2CT/sPt5CFP/V81ryQTZY2qIaayi2cQizgM7vZ
 oxIi5T8q/CEGFJZi8iCN8ooxytoQ1obYahfyLC1U+UPB3u2ESIcs3H8XU01KruNBMBgR
 o40AwA+CGaZ86Dhubv5QvrVj5D+8cJ0DzMp4nuhbaNjui67X+7Vg5xoUFtwto+xOd5Ph
 YySTjzDQFWCNrtlOFMRa0EQMu+/D7O8c5wpaq4t8qELhUyg2gBGL04s1OcoHn9dRxcTZ
 keldZrcRmB/fRlWzgTr3HveLBn3P0l5ns21kLwrlfUtNy8FFzbm23k2R/eOI1/YAbNdj
 10IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941819; x=1768546619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mjPsO1iN8zblKX1agU+MryhlTz3TLPeuoLfrtv2SguQ=;
 b=v3dobe3/glTzbUnuiB7KZPj6dafEnzuHETWv+yBWIK/qLbvhClPRG1CWGHoTMYl36L
 tam0STp10+NbKzTKNjYjnbF0DAP9N9Ky7EIaVhNR3hxFMZn97t3s7w1VUErLNwWJuJBT
 imiXhh/LHrSyVCnDbEOM5DSJX7qwcLsOHEkIQkxInMGtMgvI/1XS/6sWbzqCZJtWtBix
 WIRbZxNlDkyg5c0040T+YKoj3MclMciqLVJswBp0BgxwYCdckdsSV1S6RiMuYnpKVLUL
 nA+PuNxAe6ozS/9wvE3d2riN5Nr0hyjKSRya61niih9uLBctu7RWfCIiVwvBb6NtVdzk
 xoKg==
X-Gm-Message-State: AOJu0YwXc+I6fzSQaBcpM8VH8ziB42PMI7MCvRCcXkgvYeCBoWSft+jd
 IxRz0kB8y34MdpIrwLwx2gNh6ghDln4Q6zRjiVLoXEj9ELSnBsRJDK0oHE05Og==
X-Gm-Gg: AY/fxX5g818D1Ki4XInqF69pfR4zaIWK5sJHESL0mR7q6Cj/dCWH3FMNpTk86+Ve5kx
 Ptq7I7CZD2Vt5Wr7bDgAU049b0hpndn+LtteHuTkk7OwpVDlY3TGg8gX/UXngH3OHgwDHDh1UAZ
 +pFEelrDxOZANC1vjjRXtlNjlPzCscKnExq0rl2oiHGrTdvrcCo9fzRwKseQOcsEnvsaJ5YQNic
 Bm7BEAdCMAfMj0Rl9qaLBMSlegtCWK/zp+O0UY40Xh2Orxs3gaFLHfwiC7jGKxKeTRsxEvJ4woV
 cleqNO6j4Ie3ghcswQ6sy6LiNuly8H2sWqCa2m55tM6R7arQT8UX5R+gIMFaEoMKeRAfgidv0YL
 NpT3zTxmV4ZgNCXszlCyQvDUtspTo8dST2yO5kJ6Vch4BLTJ/p0YoThxUQu+Zi5b/H2PrhLXRN3
 xsmWAeHk1oHdoV8Dp7ALpZ/s1+ZRTYh/RXnAVjFlaCl3Cg0VtCXYKh9Jczc7cRHkMQ7rTVPfPOH
 uc/33Emcc7eVGUGYRY=
X-Google-Smtp-Source: AGHT+IH4VFBJ4pNX3HhzOiEhV/kbenH14PqLlhp+k3R7nz5fQKWb2PyeUQsuJZMCXhZWmpafGivdDA==
X-Received: by 2002:a05:6a21:99a1:b0:351:9401:c2b0 with SMTP id
 adf61e73a8af0-3898f91d13emr8615619637.31.1767941818823; 
 Thu, 08 Jan 2026 22:56:58 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:58 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/34] hw/riscv: Add support for MIPS Boston-aia board mode
Date: Fri,  9 Jan 2026 16:54:57 +1000
Message-ID: <20260109065459.19987-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
MIPS CPC, AIA plic, and AIA clint devices. The model can create
boot code, if there is no -bios parameter. We can specify -smp x,
cores=y,thread=z.
Ex: Use 4 cores and 2 threads with each core to
have 8 smp cpus as follows.
  qemu-system-riscv64 -cpu mips-p8700 \
  -m 2G -M boston-aia \
  -smp 8,cores=4,threads=2 -kernel fw_payload.bin \
  -drive file=rootfs.ext2,format=raw -serial stdio

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-11-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/boston-aia.c                       | 471 ++++++++++++++++++++
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/meson.build                        |   1 +
 6 files changed, 500 insertions(+)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/riscv/boston-aia.c

diff --git a/docs/system/riscv/mips.rst b/docs/system/riscv/mips.rst
new file mode 100644
index 0000000000..97096421e1
--- /dev/null
+++ b/docs/system/riscv/mips.rst
@@ -0,0 +1,20 @@
+Boards for RISC-V Processors by MIPS
+====================================
+
+RISC-V processors developed by MIPS support Boston-aia board model. The board
+model supports up to 64 harts with MIPS CPS, MIPS GCR, MIPS CPC, AIA plic,
+and AIA clint devices. The model can create boot code, if there is no
+```-bios``` parameter. Also, we can specify ```-smp x,cores=y,thread=z```.
+
+Running Linux kernel
+--------------------
+
+For example, to use 4 cores and 2 threads with each core to have 8 smp cpus,
+that runs on the ```mips-p8700``` CPU, run qemu as follows:
+
+.. code-block:: bash
+
+   qemu-system-riscv64 -cpu mips-p8700 \
+         -m 2G -M boston-aia \
+         -smp 8,cores=4,threads=2 -kernel fw_payload.bin \
+         -drive file=rootfs.ext2,format=raw -serial stdio
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..3ad5d1ddaf 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -68,6 +68,7 @@ undocumented; you can get a complete list by running
 
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
+   riscv/mips
    riscv/shakti-c
    riscv/sifive_u
    riscv/virt
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index e485bbd1a3..a8e4d0ab33 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -12,3 +12,4 @@
 # CONFIG_MICROCHIP_PFSOC=n
 # CONFIG_SHAKTI_C=n
 # CONFIG_XIANGSHAN_KUNMINGHU=n
+# CONFIG_MIPS_BOSTON_AIA=n
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
new file mode 100644
index 0000000000..1d9fa868c8
--- /dev/null
+++ b/hw/riscv/boston-aia.c
@@ -0,0 +1,471 @@
+/*
+ * MIPS Boston-aia development board emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+
+#include "hw/core/boards.h"
+#include "hw/char/serial-mm.h"
+#include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
+#include "hw/core/loader.h"
+#include "hw/riscv/cps.h"
+#include "hw/pci-host/xilinx-pcie.h"
+#include "hw/core/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "chardev/char.h"
+#include "system/address-spaces.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+
+#include <libfdt.h>
+#include "qom/object.h"
+
+#define TYPE_MIPS_BOSTON_AIA "mips-boston-aia"
+typedef struct BostonState BostonState;
+DECLARE_INSTANCE_CHECKER(BostonState, BOSTON,
+                         TYPE_MIPS_BOSTON_AIA)
+
+enum {
+    BOSTON_PCIE2,
+    BOSTON_PCIE2_MMIO,
+    BOSTON_PLATREG,
+    BOSTON_UART,
+    BOSTON_LCD,
+    BOSTON_FLASH,
+    BOSTON_HIGHDDR,
+};
+
+static const MemMapEntry boston_memmap[] = {
+    [BOSTON_PCIE2] =      { 0x14000000,     0x2000000 },
+    [BOSTON_PCIE2_MMIO] = { 0x16000000,      0x100000 },
+    [BOSTON_PLATREG] =    { 0x17ffd000,        0x1000 },
+    [BOSTON_UART] =       { 0x17ffe000,          0x20 },
+    [BOSTON_LCD] =        { 0x17fff000,           0x8 },
+    [BOSTON_FLASH] =      { 0x18000000,     0x8000000 },
+    [BOSTON_HIGHDDR] =    { 0x80000000,           0x0 },
+};
+
+/* Interrupt numbers for APLIC. */
+#define UART_INT 4
+#define PCIE2_INT 7
+
+struct BostonState {
+    SysBusDevice parent_obj;
+
+    MachineState *mach;
+    RISCVCPSState cps;
+    SerialMM *uart;
+
+    CharFrontend lcd_display;
+    char lcd_content[8];
+    bool lcd_inited;
+};
+
+enum boston_plat_reg {
+    PLAT_FPGA_BUILD     = 0x00,
+    PLAT_CORE_CL        = 0x04,
+    PLAT_WRAPPER_CL     = 0x08,
+    PLAT_SYSCLK_STATUS  = 0x0c,
+    PLAT_SOFTRST_CTL    = 0x10,
+#define PLAT_SOFTRST_CTL_SYSRESET       (1 << 4)
+    PLAT_DDR3_STATUS    = 0x14,
+#define PLAT_DDR3_STATUS_LOCKED         (1 << 0)
+#define PLAT_DDR3_STATUS_CALIBRATED     (1 << 2)
+#define PLAT_DDR3_INTERFACE_RESET       (1 << 3)
+    PLAT_PCIE_STATUS    = 0x18,
+#define PLAT_PCIE_STATUS_PCIE0_LOCKED   (1 << 0)
+#define PLAT_PCIE_STATUS_PCIE1_LOCKED   (1 << 8)
+#define PLAT_PCIE_STATUS_PCIE2_LOCKED   (1 << 16)
+    PLAT_FLASH_CTL      = 0x1c,
+    PLAT_SPARE0         = 0x20,
+    PLAT_SPARE1         = 0x24,
+    PLAT_SPARE2         = 0x28,
+    PLAT_SPARE3         = 0x2c,
+    PLAT_MMCM_DIV       = 0x30,
+#define PLAT_MMCM_DIV_CLK0DIV_SHIFT     0
+#define PLAT_MMCM_DIV_INPUT_SHIFT       8
+#define PLAT_MMCM_DIV_MUL_SHIFT         16
+#define PLAT_MMCM_DIV_CLK1DIV_SHIFT     24
+    PLAT_BUILD_CFG      = 0x34,
+#define PLAT_BUILD_CFG_IOCU_EN          (1 << 0)
+#define PLAT_BUILD_CFG_PCIE0_EN         (1 << 1)
+#define PLAT_BUILD_CFG_PCIE1_EN         (1 << 2)
+#define PLAT_BUILD_CFG_PCIE2_EN         (1 << 3)
+    PLAT_DDR_CFG        = 0x38,
+#define PLAT_DDR_CFG_SIZE               (0xf << 0)
+#define PLAT_DDR_CFG_MHZ                (0xfff << 4)
+    PLAT_NOC_PCIE0_ADDR = 0x3c,
+    PLAT_NOC_PCIE1_ADDR = 0x40,
+    PLAT_NOC_PCIE2_ADDR = 0x44,
+    PLAT_SYS_CTL        = 0x48,
+};
+
+static void boston_lcd_event(void *opaque, QEMUChrEvent event)
+{
+    BostonState *s = opaque;
+    if (event == CHR_EVENT_OPENED && !s->lcd_inited) {
+        qemu_chr_fe_printf(&s->lcd_display, "        ");
+        s->lcd_inited = true;
+    }
+}
+
+static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    BostonState *s = opaque;
+    uint64_t val = 0;
+
+    switch (size) {
+    case 8:
+        val |= (uint64_t)s->lcd_content[(addr + 7) & 0x7] << 56;
+        val |= (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
+        val |= (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
+        val |= (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
+        /* fall through */
+    case 4:
+        val |= (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
+        val |= (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
+        /* fall through */
+    case 2:
+        val |= (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
+        /* fall through */
+    case 1:
+        val |= (uint64_t)s->lcd_content[(addr + 0) & 0x7];
+        break;
+    }
+
+    return val;
+}
+
+static void boston_lcd_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    BostonState *s = opaque;
+
+    switch (size) {
+    case 8:
+        s->lcd_content[(addr + 7) & 0x7] = val >> 56;
+        s->lcd_content[(addr + 6) & 0x7] = val >> 48;
+        s->lcd_content[(addr + 5) & 0x7] = val >> 40;
+        s->lcd_content[(addr + 4) & 0x7] = val >> 32;
+        /* fall through */
+    case 4:
+        s->lcd_content[(addr + 3) & 0x7] = val >> 24;
+        s->lcd_content[(addr + 2) & 0x7] = val >> 16;
+        /* fall through */
+    case 2:
+        s->lcd_content[(addr + 1) & 0x7] = val >> 8;
+        /* fall through */
+    case 1:
+        s->lcd_content[(addr + 0) & 0x7] = val;
+        break;
+    }
+
+    qemu_chr_fe_printf(&s->lcd_display,
+                       "\r%-8.8s", s->lcd_content);
+}
+
+static const MemoryRegionOps boston_lcd_ops = {
+    .read = boston_lcd_read,
+    .write = boston_lcd_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    BostonState *s = opaque;
+    uint32_t gic_freq, val;
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+        return 0;
+    case PLAT_DDR3_STATUS:
+        return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED
+               | PLAT_DDR3_INTERFACE_RESET;
+    case PLAT_MMCM_DIV:
+        gic_freq = 25000000 / 1000000;
+        val = gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
+        val |= 1 << PLAT_MMCM_DIV_MUL_SHIFT;
+        val |= 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
+        val |= 1 << PLAT_MMCM_DIV_CLK1DIV_SHIFT;
+        return val;
+    case PLAT_BUILD_CFG:
+        val = PLAT_BUILD_CFG_PCIE0_EN;
+        val |= PLAT_BUILD_CFG_PCIE1_EN;
+        val |= PLAT_BUILD_CFG_PCIE2_EN;
+        return val;
+    case PLAT_DDR_CFG:
+        val = s->mach->ram_size / GiB;
+        assert(!(val & ~PLAT_DDR_CFG_SIZE));
+        val |= PLAT_DDR_CFG_MHZ;
+        return val;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx "\n",
+                      addr & 0xffff);
+        return 0;
+    }
+}
+
+static void boston_platreg_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    if (size != 4) {
+        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
+        return;
+    }
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+    case PLAT_DDR3_STATUS:
+    case PLAT_PCIE_STATUS:
+    case PLAT_MMCM_DIV:
+    case PLAT_BUILD_CFG:
+    case PLAT_DDR_CFG:
+        /* read only */
+        break;
+    case PLAT_SOFTRST_CTL:
+        if (val & PLAT_SOFTRST_CTL_SYSRESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
+                      " = 0x%" PRIx64 "\n", addr & 0xffff, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps boston_platreg_ops = {
+    .read = boston_platreg_read,
+    .write = boston_platreg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const TypeInfo boston_device = {
+    .name          = TYPE_MIPS_BOSTON_AIA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BostonState),
+};
+
+static void boston_register_types(void)
+{
+    type_register_static(&boston_device);
+}
+type_init(boston_register_types)
+
+#define NUM_INSNS 6
+static void gen_firmware(uint32_t *p)
+{
+    int i;
+    uint32_t reset_vec[NUM_INSNS] = {
+           /* CM relocate */
+           0x1fb802b7,     /* li   t0,0x1fb80000   */
+           0x16100337,     /* li   t1,0x16100000   */
+           0x0062b423,     /* sd   t1,8(t0)        */
+           /* Jump to 0x80000000 */
+           0x00100293,     /* li   t0,1            */
+           0x01f29293,     /* slli t0,t0,1f        */
+           0x00028067      /* jr   t0              */
+    };
+
+    for (i = 0; i < NUM_INSNS; i++) {
+        *p++ = reset_vec[i];
+    }
+}
+
+static inline XilinxPCIEHost *
+xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev = qdev_new(TYPE_XILINX_PCIE_HOST);
+
+    qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
+    qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
+    qdev_prop_set_uint64(dev, "cfg_size", cfg_size);
+    qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
+    qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
+
+    return XILINX_PCIE_HOST(dev);
+}
+
+static void boston_mach_init(MachineState *machine)
+{
+    DeviceState *dev;
+    BostonState *s;
+    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
+    MemoryRegion *sys_mem = get_system_memory();
+    XilinxPCIEHost *pcie2;
+    PCIDevice *pdev;
+    AHCIPCIState *ich9;
+    DriveInfo *hd[6];
+    Chardev *chr;
+    int fw_size;
+
+    if ((machine->ram_size % GiB) ||
+        (machine->ram_size > (4 * GiB))) {
+        error_report("Memory size must be 1GB, 2GB, 3GB, or 4GB");
+        exit(1);
+    }
+
+    if (machine->smp.cpus / machine->smp.cores / machine->smp.threads > 1) {
+        error_report(
+            "Invalid -smp x,cores=y,threads=z. The max number of clusters "
+            "supported is 1");
+        exit(1);
+    }
+
+    dev = qdev_new(TYPE_MIPS_BOSTON_AIA);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s = BOSTON(dev);
+    s->mach = machine;
+
+    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_RISCV_CPS);
+    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type,
+                            &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-hart", machine->smp.threads,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-core", machine->smp.cores,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "gcr-base", GCR_BASE_ADDR,
+                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
+
+    flash =  g_new(MemoryRegion, 1);
+    memory_region_init_rom(flash, NULL, "boston.flash",
+                           boston_memmap[BOSTON_FLASH].size, &error_fatal);
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_FLASH].base,
+                                        flash, 0);
+
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_HIGHDDR].base,
+                                        machine->ram, 0);
+
+    ddr_low_alias = g_new(MemoryRegion, 1);
+    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
+                             machine->ram, 0,
+                             MIN(machine->ram_size, (256 * MiB)));
+    memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
+
+    pcie2 = xilinx_pcie_init(sys_mem, 2,
+                             boston_memmap[BOSTON_PCIE2].base,
+                             boston_memmap[BOSTON_PCIE2].size,
+                             boston_memmap[BOSTON_PCIE2_MMIO].base,
+                             boston_memmap[BOSTON_PCIE2_MMIO].size,
+                             qdev_get_gpio_in(s->cps.aplic, PCIE2_INT));
+
+    platreg = g_new(MemoryRegion, 1);
+    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
+                          "boston-platregs",
+                          boston_memmap[BOSTON_PLATREG].size);
+    memory_region_add_subregion_overlap(sys_mem,
+                          boston_memmap[BOSTON_PLATREG].base, platreg, 0);
+
+    s->uart = serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2,
+                             qdev_get_gpio_in(s->cps.aplic, UART_INT), 10000000,
+                             serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    lcd = g_new(MemoryRegion, 1);
+    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_LCD].base, lcd, 0);
+
+    chr = qemu_chr_new("lcd", "vc:320x240", NULL);
+    qemu_chr_fe_init(&s->lcd_display, chr, NULL);
+    qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
+                             boston_lcd_event, NULL, s, NULL, true);
+
+    pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
+                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
+    ich9 = ICH9_AHCI(pdev);
+    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
+    ahci_ide_create_devs(&ich9->ahci, hd);
+
+    if (machine->firmware) {
+        fw_size = load_image_targphys(machine->firmware,
+                                      0x1fc00000, 4 * MiB, NULL);
+        if (fw_size == -1) {
+            error_report("unable to load firmware image '%s'",
+                          machine->firmware);
+            exit(1);
+        }
+        if (machine->kernel_filename) {
+                fw_size = load_image_targphys(machine->kernel_filename,
+                                              0x80000000, 64 * MiB, NULL);
+                if (fw_size == -1) {
+                    error_report("unable to load kernel image '%s'",
+                                  machine->kernel_filename);
+                    exit(1);
+                }
+        }
+    } else if (machine->kernel_filename) {
+        fw_size = load_image_targphys(machine->kernel_filename,
+                                      0x80000000, 64 * MiB, NULL);
+        if (fw_size == -1) {
+            error_report("unable to load kernel image '%s'",
+                          machine->kernel_filename);
+            exit(1);
+        }
+
+        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000);
+    } else if (!qtest_enabled()) {
+        error_report("Please provide either a -kernel or -bios argument");
+        exit(1);
+    }
+}
+
+static void boston_mach_class_init(MachineClass *mc)
+{
+    mc->desc = "MIPS Boston-aia";
+    mc->init = boston_mach_init;
+    mc->block_default_type = IF_IDE;
+    mc->default_ram_size = 2 * GiB;
+    mc->default_ram_id = "boston.ddr";
+    mc->max_cpus = MAX_HARTS;
+    mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
+}
+
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..0222c93f87 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -128,3 +128,9 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    select PCI_EXPRESS
+    select PCI_EXPRESS_XILINX
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 9023b80087..533472e22a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -16,5 +16,6 @@ riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.52.0



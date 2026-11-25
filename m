Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E2606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=XzYeJIZB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2th-0000SE-6j; Tue, 24 Nov 2026 21:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2tB-0000EL-30
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:42 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t5-00075u-RH
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:39 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b4dd5cb4f6so35879567b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795574252; x=1796179052; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z9B2OsTJxESKKY8dhBVJaIdsu7HrQeQSFpW9GphlygY=;
 b=XzYeJIZB01C1m8Mf8hW4u1H2vHjyaZo6ELsORODCtgNvu0yjEiRv+rXNz3Hdkaqjex
 Kf18DxzF1VcDaj4YCZsYriLno6TEKZcq2E+xnNVooBzwGw7NU/ROR28kvKoGW07JVwTI
 42Iy/LsWUJ4+gfoob6sFkD25qcBMH+YA4A6GXZBy8Fs+1YHxEmuAHSSOiZTXfk2r9K3X
 npYORpZ14NoOgp+tNe7+/ZBPUkGFQzjNWNF8LwmdUujVY2w4eRljRyyWz710v6dOUS2V
 ohpR3EHQYjq1LFsL3tqjumNtv/OroH9ISNrASLxad42OHlZQp40TZbth8K50meRAp5Et
 ss/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574252; x=1796179052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z9B2OsTJxESKKY8dhBVJaIdsu7HrQeQSFpW9GphlygY=;
 b=bShaiTAOZmVX0tFcjQCQyUhUtj8hRMhUQIcG+Z8ylG58AkPrTKv4IGkZlInRPbcF8G
 Fp7ZDXvemblDJcl5/Gb3lEinXC/8DxWHvFizvxzeTGHUMaK0a8AUzKXZafxA5droWQAq
 9Mk1W79W6kp7A09fvMzlII6LHaeTBQjXSWrxlf9g5d1aeD51rNELNKnCssoECCCYw8Cq
 3KvaL+x6hA9Lm2WrqmOZGrRxJKNepwYnITENf/9L2rAaIAi1tcPjd7TFM7cOqUkaSuFp
 lft+xGXOyYAxYLHTJ60Lcf5ey1X7FGdqdF9JhOOoDOEnse40nntNye2dPSpGVDKLyHF8
 dcJw==
X-Gm-Message-State: APuU4Z8v9JORw/sIkCXQwuW7QR606scF5kbRj9QuO9fljjke22Wi8Rop
 /nS2bYY7g0G5VCXHfJLXPGuCQIR1dQL8S1lwPznzX0wURVbrHaRhXqg4kuzWNbkqW5Q=
X-Gm-Gg: AZFdTZf+/emMgcsxSBZmA4+e+JGhpvxvsLjTNA9T8xxxTde2SWA39quLH/z76zVxXAB
 fn2nmMcbDD11yU8Mil12y+dcQ8M17J85aWVnQAoOeZKBgLrMY0MWSoYMGV2wUy4ayv6iesAGaKf
 4sFLggeZrVTC9V679tQYBWaHO+9yd6gkMZLnJ0g0/8qZ/IYKFMOFezUrtnpKnSpoBZmhjxUihzS
 dlxjTZhUV+A+aKl0xKF4vLeaRD48+RAdfOj78ZjRnnUkzxGJAa/NM0Pv5tQfjOF89wPSkodnYw7
 4tZ0zzRjiXK810v2/vwBxHsBWuyRKPzAYJOV8O7gqMgo6a82UIS/8ExYQMgCnZcpSSPfVIZBpT+
 MLZmezAa1DAgia6ldISJgpGH2U/LRYpWLMJBlFP0k2NBLSGr22sIeMdyO+DygnkrveTVYCHatwe
 aPnkkx+g8cJ1NHRJ0fM6tYMT0QBfzkhWYyuZoWOlNwsdUx6+wZlI3tlGi8yEEe37X/NgV1Xdhwz
 80AT1f2ztvb8OZzLZx6RRJM0xMKupg+tLbkCpOwV4JUYYzPoHDToXcuAPwAYSARsh4MwuUXwH5o
 Wzk0dTroZnx3YsRWNAx7sCY/5b8Pks7sbKeMQEBj3iPnVm9kwog895gzeg/IMV8L42Rj/s8ROqA
 0QOB0H2wY
X-Received: by 2002:a05:690c:e284:10b0:8b5:27f1:6889 with SMTP id
 00721157ae682-8b527f16935mr46726557b3.30.1795574252581; 
 Tue, 24 Nov 2026 18:37:32 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:ea8f:7897:2f4d:9891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm65626717b3.8.2026.11.24.18.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:37:32 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:37:24 -0600
Subject: [PATCH 5/8] riscv: Add Spacemit K3 machine
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-spacemit_k3-v1-5-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a spacemit-k3 machine based on the RVA23 compliant Spacemit K3
SoC[1]. This machine currently models the single boot hart (Spacemit
X100) in the system, a uart, boot media (SPI NOR, SD, EMMC, UFS) and
boot-mode selection. This machine accepts the bootrom dumped from the
hardware via -bios, which loads the next boot stage from boot media
based on the boot-mode selection.

[1] https://github.com/spacemit-com/docs-chip/blob/main/en/key_stone/k3/k3_docs/k3_ds.md

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 MAINTAINERS                    |   2 +
 hw/riscv/Kconfig               |  16 ++
 hw/riscv/meson.build           |   1 +
 hw/riscv/spacemit_k3.c         | 525 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/spacemit_k3.h | 104 ++++++++
 5 files changed, 648 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7dfae9f40d..0227d92be2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1859,9 +1859,11 @@ M: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/misc/spacemit_*.c
+F: hw/riscv/spacemit_*.c
 F: hw/ssi/spacemit_*.c
 F: hw/ufs/spacemit_*.c
 F: include/hw/misc/spacemit_*.h
+F: include/hw/riscv/spacemit_*.h
 F: include/hw/ssi/spacemit_*.h
 F: target/riscv/tcg/spacemit_csr.c
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 807fcaaf28..a04a635f98 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -133,6 +133,22 @@ config SIFIVE_U
     select SSI_SD
     select UNIMP
 
+config SPACEMIT
+    bool
+    default y
+    depends on RISCV64
+    select DEVICE_TREE
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select SD
+    select SDHCI
+    select SERIAL_MM
+    select SSI
+    select SSI_M25P80
+    select UFS_SYSBUS
+    select UNIMP
+
 config SPIKE
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b60108787d..2bd7f0dd39 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -23,6 +23,7 @@ riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
+riscv_ss.add(when: 'CONFIG_SPACEMIT', if_true: files('spacemit_k3.c'))
 
 riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
 riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
diff --git a/hw/riscv/spacemit_k3.c b/hw/riscv/spacemit_k3.c
new file mode 100644
index 0000000000..47e5ec1932
--- /dev/null
+++ b/hw/riscv/spacemit_k3.c
@@ -0,0 +1,525 @@
+/*
+ * Spacemit K3 SPI Controller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Anirudh Srinivasan
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/units.h"
+
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+
+#include "hw/riscv/boot.h"
+#include "hw/riscv/riscv_hart.h"
+
+#include "hw/char/serial-mm.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/misc/unimp.h"
+#include "hw/sd/sd.h"
+#include "system/blockdev.h"
+#include "hw/ssi/ssi.h"
+
+#include "system/system.h"
+
+#include "hw/riscv/spacemit_k3.h"
+
+#define SPACEMIT_K3_IRQCHIP_NUM_MSIS       511
+#define SPACEMIT_K3_IRQCHIP_NUM_SOURCES    512
+#define SPACEMIT_K3_IRQCHIP_NUM_PRIO_BITS  3
+#define SPACEMIT_K3_IMSIC_GUESTS           5
+#define SPACEMIT_K3_IMSIC_MSTRIDE          0x1000
+#define SPACEMIT_K3_IMSIC_SSTRIDE          0x40000
+#define SPACEMIT_K3_IMSIC_GUEST_BITS       6
+
+#define SPACEMIT_K3_ACLINT_MTIME_SIZE    0xc000
+#define SPACEMIT_K3_ACLINT_MTIME         0xbff8
+#define SPACEMIT_K3_ACLINT_MTIMECMP      0x4000
+#define SPACEMIT_K3_ACLINT_TIMEBASE_FREQ 24000000
+
+static const MemMapEntry spacemit_k3_memmap[] = {
+    [SPACEMIT_K3_PCIE] =              {  0x80000000,    0x4000000 },
+    [SPACEMIT_K3_ESPI_SLV_MEM] =      {  0x84000000,    0x2000000 },
+    [SPACEMIT_K3_QSPI_AHB] =          {  0xb8000000,    0x8000000 },
+    [SPACEMIT_K3_SRAM] =              {  0xc0800000,      0x80000 },
+    [SPACEMIT_K3_AUDIO_PERIPH] =      {  0xc0880000,     0x180000 },
+    [SPACEMIT_K3_DDR_TRAIN_BUF] =     {  0xc08d0000,      0x10000 },
+    [SPACEMIT_K3_USB_OTG] =           {  0xc0a00000,     0x100000 },
+    [SPACEMIT_K3_UFSHC] =             {  0xc0e00000,      0x40000 },
+    [SPACEMIT_K3_ETH0] =              {  0xcac80000,       0x2000 },
+    [SPACEMIT_K3_DP1] =               {  0xcac88000,       0x4000 },
+    [SPACEMIT_K3_ESPI] =              {  0xcac8c000,       0x1000 },
+    [SPACEMIT_K3_MAILBOX3] =          {  0xcac90c00,        0x400 },
+    [SPACEMIT_K3_USB3] =              {  0xcad00000,     0x100000 },
+    [SPACEMIT_K3_DDRC0] =             {  0xcb000000,    0x1000000 },
+    [SPACEMIT_K3_DDRC1] =             {  0xcc000000,    0x1000000 },
+    [SPACEMIT_K3_I2C1] =              {  0xd4011000,        0x800 },
+    [SPACEMIT_K3_I2C2] =              {  0xd4012000,        0x800 },
+    [SPACEMIT_K3_WDT0] =              {  0xd4014000,       0x1000 },
+    [SPACEMIT_K3_I2C6] =              {  0xd4018800,        0x800 },
+    [SPACEMIT_K3_I2C8] =              {  0xd401D800,        0x800 },
+    [SPACEMIT_K3_SYSCON_APBC] =       {  0xd4015000,       0x1000 },
+    [SPACEMIT_K3_THERMAL] =           {  0xd4018000,        0x100 },
+    [SPACEMIT_K3_UART0] =             {  0xd4017000,        0x100 },
+    [SPACEMIT_K3_GPIO] =              {  0xd4019000,        0x800 },
+    [SPACEMIT_K3_PINCTRL] =           {  0xd401e000,       0x1000 },
+    [SPACEMIT_K3_SYSCON_MPMU] =       {  0xd4050000,      0x10000 },
+    [SPACEMIT_K3_PLL] =               {  0xd4090000,      0x10000 },
+    [SPACEMIT_K3_QSPI] =              {  0xd420c000,       0x1000 },
+    [SPACEMIT_K3_SDHCI0] =            {  0xd4280000,        0x200 },
+    [SPACEMIT_K3_SDHCI1] =            {  0xd4280800,        0x200 },
+    [SPACEMIT_K3_EMMC] =              {  0xd4281000,        0x200 },
+    [SPACEMIT_K3_SYSCON_APMU] =       {  0xd4282800,        0x400 },
+    [SPACEMIT_K3_CPU_CONFIG_UNIT] =   {  0xd4282C00,        0x400 },
+    [SPACEMIT_K3_COUNTER] =           {  0xd5001000,         0x10 },
+    [SPACEMIT_K3_SYSCON_DCIU] =       {  0xd8440000,       0xc000 },
+    [SPACEMIT_K3_CCI550] =            {  0xd8500000,     0x100000 },
+    [SPACEMIT_K3_SEC_APB_CLK_UNIT] =  {  0xf0610000,       0x2000 },
+    [SPACEMIT_K3_SEC_JTAG_SOFTWARE] = {  0xf0618000,       0x1000 },
+    [SPACEMIT_K3_SEC_BCM_CONFIG] =    {  0xf0700000,     0x100000 },
+    [SPACEMIT_K3_MIMSIC] =            {  0xf1000000,      0x10000 },
+    [SPACEMIT_K3_MAPLIC] =            {  0xf1800000,       0x4000 },
+    [SPACEMIT_K3_ACLINT] =            {  0xf1810000,      0x10000 },
+    [SPACEMIT_K3_BOOTROM] =           {  0xffe00000,     0x200000 },
+    [SPACEMIT_K3_SIMSIC] =            {  0xe0400000,     0x200000 },
+    [SPACEMIT_K3_SAPLIC] =            {  0xe0804000,       0x4000 },
+    [SPACEMIT_K3_DRAM] =              { 0x100000000,  0x400000000 },
+};
+
+static void spacemit_k3_machine_done(Notifier *notifier, void *data)
+{
+    SpacemitK3State *s = container_of(notifier, SpacemitK3State,
+                                     machine_done);
+    MachineState *machine = MACHINE(s);
+    hwaddr start_addr = s->memmap[SPACEMIT_K3_BOOTROM].base;
+    const char *firmware_name = riscv_default_firmware_name(&s->soc);
+    RISCVBootInfo boot_info;
+
+    riscv_boot_info_init(&boot_info, &s->soc);
+
+    riscv_find_and_load_firmware(machine, &boot_info,
+                                 firmware_name,
+                                 &start_addr, NULL);
+}
+
+static void spacemit_k3_machine_init(MachineState *machine)
+{
+    SpacemitK3State *s = SPACEMIT_K3_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *bootrom = g_new(MemoryRegion, 1);
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
+    MemoryRegion *ddr_train_buf = g_new(MemoryRegion, 1);
+    int hart_count = machine->smp.cpus;
+    int i;
+
+    s->memmap = spacemit_k3_memmap;
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
+                            s->memmap[SPACEMIT_K3_BOOTROM].base,
+                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+
+    /*
+     * Define APLIC and IMSIC nodes directly (without helper function)
+     * so that we get handles to misic memory regions.
+     */
+    for (i = 0; i < hart_count; i++) {
+        riscv_imsic_create(get_system_memory(),
+                         s->memmap[SPACEMIT_K3_MIMSIC].base +
+                             i * SPACEMIT_K3_IMSIC_MSTRIDE,
+                         i, true, 1, SPACEMIT_K3_IRQCHIP_NUM_MSIS);
+    }
+
+    for (i = 0; i < hart_count; i++) {
+        riscv_imsic_create(
+          get_system_memory(),
+          s->memmap[SPACEMIT_K3_SIMSIC].base + i * SPACEMIT_K3_IMSIC_SSTRIDE, i,
+          false, 1 + SPACEMIT_K3_IMSIC_GUESTS, SPACEMIT_K3_IRQCHIP_NUM_MSIS);
+    }
+
+    s->irqchip = riscv_aplic_create(
+        get_system_memory(), s->memmap[SPACEMIT_K3_MAPLIC].base,
+        s->memmap[SPACEMIT_K3_MAPLIC].size, 0, 0,
+        SPACEMIT_K3_IRQCHIP_NUM_SOURCES, SPACEMIT_K3_IRQCHIP_NUM_PRIO_BITS,
+        true, true, NULL);
+
+    riscv_aplic_create(get_system_memory(), s->memmap[SPACEMIT_K3_SAPLIC].base,
+                       s->memmap[SPACEMIT_K3_SAPLIC].size, 0, 0,
+                       SPACEMIT_K3_IRQCHIP_NUM_SOURCES,
+                       SPACEMIT_K3_IRQCHIP_NUM_PRIO_BITS, true, false,
+                       s->irqchip);
+
+    riscv_aclint_mtimer_create(get_system_memory(),
+            s->memmap[SPACEMIT_K3_ACLINT].base,
+            SPACEMIT_K3_ACLINT_MTIME_SIZE,
+            0, hart_count,
+            SPACEMIT_K3_ACLINT_MTIMECMP,
+            SPACEMIT_K3_ACLINT_MTIME,
+            SPACEMIT_K3_ACLINT_TIMEBASE_FREQ, true);
+
+    riscv_aclint_swi_create(get_system_memory(),
+            s->memmap[SPACEMIT_K3_ACLINT].base,
+            0, hart_count, false);
+
+    /* register system main memory (actual RAM) */
+    memory_region_add_subregion(system_memory, s->memmap[SPACEMIT_K3_DRAM].base,
+                                machine->ram);
+
+    /* boot rom */
+    memory_region_init_rom(bootrom, NULL, "spacemit-k3.bootrom",
+                           s->memmap[SPACEMIT_K3_BOOTROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[SPACEMIT_K3_BOOTROM].base, bootrom);
+
+    memory_region_init_ram(sram, NULL, "sram",
+                             s->memmap[SPACEMIT_K3_SRAM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[SPACEMIT_K3_SRAM].base, sram);
+
+    memory_region_init_ram(ddr_train_buf, NULL, "ddr_train_buf",
+                           s->memmap[SPACEMIT_K3_DDR_TRAIN_BUF].size,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[SPACEMIT_K3_DDR_TRAIN_BUF].base,
+                                ddr_train_buf);
+
+    create_unimplemented_device("spacemit-k3.sec_jtag_software",
+                                s->memmap[SPACEMIT_K3_SEC_JTAG_SOFTWARE].base,
+                                s->memmap[SPACEMIT_K3_SEC_JTAG_SOFTWARE].size);
+
+    create_unimplemented_device("spacemit-k3.syscon_apbc",
+                                s->memmap[SPACEMIT_K3_SYSCON_APBC].base,
+                                s->memmap[SPACEMIT_K3_SYSCON_APBC].size);
+
+    create_unimplemented_device("spacemit-k3.sec_bcm_config",
+                                s->memmap[SPACEMIT_K3_SEC_BCM_CONFIG].base,
+                                s->memmap[SPACEMIT_K3_SEC_BCM_CONFIG].size);
+
+    create_unimplemented_device("spacemit-k3.pll",
+                                s->memmap[SPACEMIT_K3_PLL].base,
+                                s->memmap[SPACEMIT_K3_PLL].size);
+
+    create_unimplemented_device("spacemit-k3.pinctrl",
+                                s->memmap[SPACEMIT_K3_PINCTRL].base,
+                                s->memmap[SPACEMIT_K3_PINCTRL].size);
+
+    create_unimplemented_device("spacemit-k3.counter",
+                                s->memmap[SPACEMIT_K3_COUNTER].base,
+                                s->memmap[SPACEMIT_K3_COUNTER].size);
+
+    create_unimplemented_device("spacemit-k3.sec_apb_clk_unit",
+                                s->memmap[SPACEMIT_K3_SEC_APB_CLK_UNIT].base,
+                                s->memmap[SPACEMIT_K3_SEC_APB_CLK_UNIT].size);
+
+    create_unimplemented_device("spacemit-k3.i2c1",
+                                s->memmap[SPACEMIT_K3_I2C1].base,
+                                s->memmap[SPACEMIT_K3_I2C1].size);
+
+    create_unimplemented_device("spacemit-k3.i2c2",
+                                s->memmap[SPACEMIT_K3_I2C2].base,
+                                s->memmap[SPACEMIT_K3_I2C2].size);
+
+    create_unimplemented_device("spacemit-k3.i2c6",
+                                s->memmap[SPACEMIT_K3_I2C6].base,
+                                s->memmap[SPACEMIT_K3_I2C6].size);
+
+    create_unimplemented_device("spacemit-k3.i2c8",
+                                s->memmap[SPACEMIT_K3_I2C8].base,
+                                s->memmap[SPACEMIT_K3_I2C8].size);
+
+    create_unimplemented_device("spacemit-k3.espi",
+                                s->memmap[SPACEMIT_K3_ESPI].base,
+                                s->memmap[SPACEMIT_K3_ESPI].size);
+
+    create_unimplemented_device("spacemit-k3.audio_periph",
+                                s->memmap[SPACEMIT_K3_AUDIO_PERIPH].base,
+                                s->memmap[SPACEMIT_K3_AUDIO_PERIPH].size);
+
+    create_unimplemented_device("spacemit-k3.mailbox3",
+                                s->memmap[SPACEMIT_K3_MAILBOX3].base,
+                                s->memmap[SPACEMIT_K3_MAILBOX3].size);
+
+    create_unimplemented_device("spacemit-k3.syscon_dciu",
+                                s->memmap[SPACEMIT_K3_SYSCON_DCIU].base,
+                                s->memmap[SPACEMIT_K3_SYSCON_DCIU].size);
+
+    create_unimplemented_device("spacemit-k3.cci550",
+                                s->memmap[SPACEMIT_K3_CCI550].base,
+                                s->memmap[SPACEMIT_K3_CCI550].size);
+
+    create_unimplemented_device("spacemit-k3.espi_slv_mem",
+                                s->memmap[SPACEMIT_K3_ESPI_SLV_MEM].base,
+                                s->memmap[SPACEMIT_K3_ESPI_SLV_MEM].size);
+
+    create_unimplemented_device("spacemit-k3.wdt0",
+                                s->memmap[SPACEMIT_K3_WDT0].base,
+                                s->memmap[SPACEMIT_K3_WDT0].size);
+
+    create_unimplemented_device("spacemit-k3.dp1",
+                                s->memmap[SPACEMIT_K3_DP1].base,
+                                s->memmap[SPACEMIT_K3_DP1].size);
+
+    create_unimplemented_device("spacemit-k3.gpio",
+                                s->memmap[SPACEMIT_K3_GPIO].base,
+                                s->memmap[SPACEMIT_K3_GPIO].size);
+
+    create_unimplemented_device("spacemit-k3.pcie",
+                                s->memmap[SPACEMIT_K3_PCIE].base,
+                                s->memmap[SPACEMIT_K3_PCIE].size);
+
+    create_unimplemented_device("spacemit-k3.usb_otg",
+                                s->memmap[SPACEMIT_K3_USB_OTG].base,
+                                s->memmap[SPACEMIT_K3_USB_OTG].size);
+
+    create_unimplemented_device("spacemit-k3.eth0",
+                                s->memmap[SPACEMIT_K3_ETH0].base,
+                                s->memmap[SPACEMIT_K3_ETH0].size);
+
+    create_unimplemented_device("spacemit-k3.usb3",
+                                s->memmap[SPACEMIT_K3_USB3].base,
+                                s->memmap[SPACEMIT_K3_USB3].size);
+
+    create_unimplemented_device("spacemit-k3.thermal",
+                                s->memmap[SPACEMIT_K3_THERMAL].base,
+                                s->memmap[SPACEMIT_K3_THERMAL].size);
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.cpu_config",
+                            &s->cpu_config, TYPE_SPACEMIT_K3_CPU_CONFIG);
+    object_property_set_int(OBJECT(&s->cpu_config),
+                                "boot-mode", s->boot_mode, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpu_config), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpu_config), 0,
+                    s->memmap[SPACEMIT_K3_CPU_CONFIG_UNIT].base);
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.ddrc0", &s->ddrc0,
+                            TYPE_SPACEMIT_K3_DDRC);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ddrc0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddrc0), 0,
+                    s->memmap[SPACEMIT_K3_DDRC0].base);
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.ddrc1", &s->ddrc1,
+                            TYPE_SPACEMIT_K3_DDRC);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ddrc1), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddrc1), 0,
+                    s->memmap[SPACEMIT_K3_DDRC1].base);
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.syscon_apmu",
+                            &s->syscon_apmu, TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT);
+    sysbus_realize(SYS_BUS_DEVICE(&s->syscon_apmu), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon_apmu), 0,
+                    s->memmap[SPACEMIT_K3_SYSCON_APMU].base);
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.syscon_mpmu",
+                            &s->syscon_mpmu, TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT);
+    sysbus_realize(SYS_BUS_DEVICE(&s->syscon_mpmu), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon_mpmu), 0,
+                    s->memmap[SPACEMIT_K3_SYSCON_MPMU].base);
+
+    for (int num_sdhci = 0; num_sdhci < SPACEMIT_K3_NUM_SDHCI; num_sdhci++) {
+        MemoryRegion *sdhci_vendor_region = g_new(MemoryRegion, 1);
+        g_autofree char *sdhci_name =
+            g_strdup_printf("spacemit-k3.sdhci%d", num_sdhci);
+        g_autofree char *sdhci_vendor_name =
+            g_strdup_printf("spacemit-k3.sdhci%d.vendor", num_sdhci);
+
+        object_initialize_child(OBJECT(machine), sdhci_name,
+                                &s->sdhci[num_sdhci], TYPE_SYSBUS_SDHCI);
+        sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[num_sdhci]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[num_sdhci]), 0,
+                      s->memmap[SPACEMIT_K3_SDHCI0 + num_sdhci].base);
+        sysbus_connect_irq(
+          SYS_BUS_DEVICE(&s->sdhci[num_sdhci]), 0,
+          qdev_get_gpio_in(s->irqchip, SPACEMIT_K3_SDHCI0_IRQ + num_sdhci));
+
+        memory_region_init_ram(sdhci_vendor_region, NULL, sdhci_vendor_name,
+                             0x100, &error_fatal);
+        memory_region_add_subregion(
+          system_memory, s->memmap[SPACEMIT_K3_SDHCI0 + num_sdhci].base + 0x100,
+          sdhci_vendor_region);
+    }
+
+    MemoryRegion *emmc_vendor_region = g_new(MemoryRegion, 1);
+    object_initialize_child(OBJECT(machine), "spacemit-k3.emmc", &s->emmc,
+                            TYPE_SYSBUS_SDHCI);
+    sysbus_realize(SYS_BUS_DEVICE(&s->emmc), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0,
+                    s->memmap[SPACEMIT_K3_EMMC].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
+                       qdev_get_gpio_in(s->irqchip, SPACEMIT_K3_EMMC_IRQ));
+
+    memory_region_init_ram(emmc_vendor_region, NULL, "spacemit-k3.emmc.vendor",
+                           0x100, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[SPACEMIT_K3_EMMC].base + 0x100,
+                                emmc_vendor_region);
+
+    /*
+     * Attach an SD/EMMC card image if one was provided via -drive if=sd
+     * indices 0 and 1 are the 2 SD controllers, index 2 is EMMC
+     */
+    for (int sd_idx = 0; sd_idx < SPACEMIT_K3_NUM_SDHCI + 1; sd_idx++) {
+        bool is_sd = sd_idx < 2;
+        DriveInfo *dinfo = drive_get(IF_SD, 0, sd_idx);
+        if (dinfo) {
+            DeviceState *card =
+              is_sd ? qdev_new(TYPE_SD_CARD) : qdev_new(TYPE_EMMC);
+            qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                              &error_fatal);
+            qdev_realize_and_unref(
+                card,
+                qdev_get_child_bus(DEVICE(is_sd ? &s->sdhci[sd_idx] : &s->emmc),
+                                   "sd-bus"),
+                &error_fatal);
+        }
+    }
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.qspi", &s->qspi,
+                            TYPE_SPACEMIT_K3_SPI);
+    qdev_prop_set_uint32(DEVICE(&s->qspi), "ahb-base",
+                         s->memmap[SPACEMIT_K3_QSPI_AHB].base);
+    sysbus_realize(SYS_BUS_DEVICE(&s->qspi), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0,
+                    s->memmap[SPACEMIT_K3_QSPI].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1,
+                    s->memmap[SPACEMIT_K3_QSPI_AHB].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi), 0,
+                       qdev_get_gpio_in(s->irqchip, SPACEMIT_K3_QSPI_IRQ));
+
+    /* Attach an NOR flash image if one was provided via -drive if=mtd */
+    {
+      DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+      if (dinfo) {
+        DeviceState *flash = qdev_new("w25q64");
+        qdev_prop_set_drive_err(flash, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(
+            flash, qdev_get_child_bus(DEVICE(&s->qspi), "ssi"), &error_fatal);
+
+        qdev_connect_gpio_out_named(
+            DEVICE(&s->qspi), "cs", 0,
+            qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0));
+      }
+    }
+
+    object_initialize_child(OBJECT(machine), "spacemit-k3.ufs", &s->ufs,
+                            TYPE_SPACEMIT_K3_UFS);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ufs), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ufs), 0,
+                    s->memmap[SPACEMIT_K3_UFSHC].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ufs), 0,
+                       qdev_get_gpio_in(s->irqchip, SPACEMIT_K3_UFSHC_IRQ));
+
+    /* Attach a UFS image if one was provided via -drive if=scsi */
+    {
+      DriveInfo *dinfo = drive_get(IF_SCSI, 0, 0);
+      if (dinfo) {
+        DeviceState *lu = qdev_new(TYPE_UFS_LU);
+        qdev_prop_set_drive_err(lu, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(lu, BUS(s->ufs.bus), &error_fatal);
+      }
+    }
+
+    serial_mm_init(system_memory, s->memmap[SPACEMIT_K3_UART0].base, 2,
+                   qdev_get_gpio_in(s->irqchip, SPACEMIT_K3_UART0_IRQ), 115200,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    s->machine_done.notify = spacemit_k3_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+static char *spacemit_k3_get_boot_mode(Object *obj, Error **errp)
+{
+    SpacemitK3State *s = SPACEMIT_K3_MACHINE(obj);
+    static const char * const boot_mode_names[] = {
+        [SPACEMIT_K3_BOOT_MODE_EMMC] = "emmc",
+        [SPACEMIT_K3_BOOT_MODE_NOR]  = "nor",
+        [SPACEMIT_K3_BOOT_MODE_NAND] = "nand",
+        [SPACEMIT_K3_BOOT_MODE_UFS]  = "ufs",
+        [SPACEMIT_K3_BOOT_MODE_USB]  = "usb",
+        [SPACEMIT_K3_BOOT_MODE_UART] = "uart",
+    };
+
+    return g_strdup(boot_mode_names[s->boot_mode]);
+}
+
+static void spacemit_k3_set_boot_mode(Object *obj, const char *value,
+                                      Error **errp) {
+  SpacemitK3State *s = SPACEMIT_K3_MACHINE(obj);
+  int boot_mode = SPACEMIT_K3_BOOT_MODE_NOR; /* Default to NOR */
+
+  if (!strcmp(value, "emmc")) {
+    boot_mode = SPACEMIT_K3_BOOT_MODE_EMMC;
+  } else if (!strcmp(value, "nor")) {
+    boot_mode = SPACEMIT_K3_BOOT_MODE_NOR;
+  } else if (!strcmp(value, "nand")) {
+    boot_mode = SPACEMIT_K3_BOOT_MODE_NAND;
+  } else if (!strcmp(value, "ufs")) {
+    boot_mode = SPACEMIT_K3_BOOT_MODE_UFS;
+  } else if (!strcmp(value, "usb")) {
+    boot_mode = SPACEMIT_K3_BOOT_MODE_USB;
+  } else if (!strcmp(value, "uart")) {
+    boot_mode = SPACEMIT_K3_BOOT_MODE_UART;
+  } else {
+    error_setg(errp, "Invalid boot-mode '%s'", value);
+  }
+  s->boot_mode = boot_mode;
+}
+
+static void spacemit_k3_machine_instance_init(Object *obj)
+{
+    SpacemitK3State *s = SPACEMIT_K3_MACHINE(obj);
+
+    s->boot_mode = SPACEMIT_K3_BOOT_MODE_NOR;
+}
+
+static void spacemit_k3_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Spacemit K3 board";
+    mc->init = spacemit_k3_machine_init;
+    mc->max_cpus = 1;
+    mc->default_cpus = 1;
+    mc->default_ram_id = "spacemit-k3.dram";
+    mc->default_ram_size = 16 * GiB;
+    mc->default_cpu_type = TYPE_RISCV_CPU_SPACEMIT_X100;
+
+    object_class_property_add_str(oc, "boot-mode", spacemit_k3_get_boot_mode,
+                                  spacemit_k3_set_boot_mode);
+    object_class_property_set_description(
+        oc, "boot-mode",
+        "Sets the boot select and download select/mode pins"
+        "on the K3. Possible options are emmc,nor,nand,ufs"
+        "usb,uart. The first 4 options default to SD first"
+        "and the chosen option next.");
+}
+
+static const TypeInfo spacemit_k3_machine_typeinfo = {
+    .name       = TYPE_SPACEMIT_K3_MACHINE,
+    .parent     = TYPE_MACHINE,
+    .instance_init = spacemit_k3_machine_instance_init,
+    .class_init = spacemit_k3_machine_class_init,
+    .instance_size = sizeof(SpacemitK3State),
+};
+
+static void spacemit_k3_machine_init_register_types(void)
+{
+    type_register_static(&spacemit_k3_machine_typeinfo);
+}
+
+type_init(spacemit_k3_machine_init_register_types)
diff --git a/include/hw/riscv/spacemit_k3.h b/include/hw/riscv/spacemit_k3.h
new file mode 100644
index 0000000000..d4d894703b
--- /dev/null
+++ b/include/hw/riscv/spacemit_k3.h
@@ -0,0 +1,104 @@
+/*
+ * Spacemit K3 Machine
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Anirudh Srinivasan
+ */
+
+#ifndef HW_RISCV_SPACEMIT_K3_H
+#define HW_RISCV_SPACEMIT_K3_H
+
+#include "hw/core/boards.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/sd/sdhci.h"
+#include "hw/misc/spacemit_k3_syscon.h"
+#include "hw/ssi/spacemit_k3_spi.h"
+#include "hw/ufs/spacemit_k3_ufs.h"
+
+#define TYPE_SPACEMIT_K3_MACHINE MACHINE_TYPE_NAME("spacemit-k3")
+OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3State, SPACEMIT_K3_MACHINE);
+
+#define SPACEMIT_K3_NUM_SDHCI 2
+
+struct SpacemitK3State {
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
+    SDHCIState sdhci[SPACEMIT_K3_NUM_SDHCI], emmc;
+    SpacemitK3DDRCState ddrc0, ddrc1;
+    SpacemitK3CPUConfigState cpu_config;
+    SpacemitK3SysconAPMUState syscon_apmu;
+    SpacemitK3SysconMPMUState syscon_mpmu;
+    SpacemitK3SpiState qspi;
+    SpacemitK3UFSState ufs;
+
+    int boot_mode;
+};
+
+enum {
+    SPACEMIT_K3_CPU_CONFIG_UNIT,
+    SPACEMIT_K3_SEC_JTAG_SOFTWARE,
+    SPACEMIT_K3_SEC_APB_CLK_UNIT,
+    SPACEMIT_K3_SEC_BCM_CONFIG,
+    SPACEMIT_K3_PLL,
+    SPACEMIT_K3_SYSCON_MPMU,
+    SPACEMIT_K3_SYSCON_APMU,
+    SPACEMIT_K3_SYSCON_APBC,
+    SPACEMIT_K3_UART0,
+    SPACEMIT_K3_PINCTRL,
+    SPACEMIT_K3_COUNTER,
+    SPACEMIT_K3_SDHCI0,
+    SPACEMIT_K3_SDHCI1,
+    SPACEMIT_K3_EMMC,
+    SPACEMIT_K3_BOOTROM,
+    SPACEMIT_K3_SRAM,
+    SPACEMIT_K3_DDR_TRAIN_BUF,
+    SPACEMIT_K3_AUDIO_PERIPH,
+    SPACEMIT_K3_DDRC0,
+    SPACEMIT_K3_DDRC1,
+    SPACEMIT_K3_DRAM,
+    SPACEMIT_K3_MIMSIC,
+    SPACEMIT_K3_SIMSIC,
+    SPACEMIT_K3_MAPLIC,
+    SPACEMIT_K3_SAPLIC,
+    SPACEMIT_K3_ACLINT,
+    SPACEMIT_K3_I2C1,
+    SPACEMIT_K3_I2C2,
+    SPACEMIT_K3_I2C6,
+    SPACEMIT_K3_I2C8,
+    SPACEMIT_K3_ESPI,
+    SPACEMIT_K3_MAILBOX3,
+    SPACEMIT_K3_SYSCON_DCIU,
+    SPACEMIT_K3_CCI550,
+    SPACEMIT_K3_ESPI_SLV_MEM,
+    SPACEMIT_K3_WDT0,
+    SPACEMIT_K3_DP1,
+    SPACEMIT_K3_GPIO,
+    SPACEMIT_K3_QSPI,
+    SPACEMIT_K3_QSPI_AHB,
+    SPACEMIT_K3_UFSHC,
+    SPACEMIT_K3_PCIE,
+    SPACEMIT_K3_USB_OTG,
+    SPACEMIT_K3_ETH0,
+    SPACEMIT_K3_USB3,
+    SPACEMIT_K3_THERMAL,
+};
+
+enum {
+    SPACEMIT_K3_UART0_IRQ = 42,
+    SPACEMIT_K3_SDHCI0_IRQ = 99,
+    SPACEMIT_K3_SDHCI1_IRQ = 100,
+    SPACEMIT_K3_EMMC_IRQ = 101,
+    SPACEMIT_K3_QSPI_IRQ  = 117,
+    SPACEMIT_K3_UFSHC_IRQ  = 135,
+};
+
+#endif

-- 
2.43.0



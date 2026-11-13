Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F065606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ghf1DsHs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrkB-0003WG-Dn; Fri, 13 Nov 2026 08:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnud-0004uH-NM; Fri, 13 Nov 2026 04:49:40 -0500
Received: from smtp47.tsinghua.edu.cn ([101.6.4.71] helo=tsinghua.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnua-0007FZ-K8; Fri, 13 Nov 2026 04:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=kSMmJ0QOsjYMU+TvrW5BJ6fvkMcj5fcXBi
 x6+PAuGR4=; b=ghf1DsHs15652R1khDxIUwjsWMQ35seAnfjkx6JpkX3X3zWHYS
 /KQabOuo1rzejSL/FKRG6C/DjyIvdGbgMUzUHdkLUhTjOGcnLJSGBA6wFaqdTUTO
 CZNRFfVVynHuGaMePP8uPP8Kr9TGjkidR5ZWxkotLIo+e8+JJQIx1EQ/o=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S18;
 Fri, 13 Nov 2026 17:49:32 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 16/20] hw/arm: add Radxa ROCK 5B board
Date: Fri, 13 Nov 2026 17:47:50 +0800
Message-ID: <954564f37ed6b2509781610629e2d20ef2e05a60.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S18
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1ktrWUXFWDGr15ur47twb_yoW3ZFy8pF
 15C34kWrZ7WFWa9w4fJFyj9a15Xw4v9a4jqr1fu3sYyF9rtr1j9r48t34Fka9rWr4qya15
 CrZ3Xr1Sq3W5XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
 IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
 GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
 UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=101.6.4.71;
 envelope-from=w-yf22@mails.tsinghua.edu.cn; helo=tsinghua.edu.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:53 -0500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

Add initial support for the Radxa ROCK 5B board, which uses the RK3588
SoC and 128 MiB to 16 GiB of DRAM. Support direct Linux booting.

The first -serial option drives UART2, the debug console on the ROCK 5B
header. Further -serial options connect to UART1 and UART3 through UART9
in that order.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS        |   1 +
 hw/arm/Kconfig     |   6 ++
 hw/arm/meson.build |   1 +
 hw/arm/rock-5b.c   | 200 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 hw/arm/rock-5b.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3d3388975..544d93c01d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1065,6 +1065,7 @@ M: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/rk3588.c
+F: hw/arm/rock-5b.c
 F: hw/misc/rockchip_cru.c
 F: hw/misc/rockchip_otp.c
 F: hw/misc/rk3588-scmci.c
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eaa55eae29..40f7de823c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -783,3 +783,9 @@ config RK3588
     select REGISTER
     select ROCKCHIP_SFC
     select UNIMP
+
+config ROCK5B
+    bool
+    default y
+    depends on TCG && AARCH64
+    select RK3588
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 70c835814f..9af1e01037 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -121,5 +121,6 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
 arm_common_ss.add(files('boot.c'))
 
 arm_common_ss.add(when: 'CONFIG_RK3588', if_true: files('rk3588.c'))
+arm_common_ss.add(when: 'CONFIG_ROCK5B', if_true: files('rock-5b.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/hw/arm/rock-5b.c b/hw/arm/rock-5b.c
new file mode 100644
index 0000000000..7906d53175
--- /dev/null
+++ b/hw/arm/rock-5b.c
@@ -0,0 +1,200 @@
+/*
+ * Radxa ROCK 5B Board emulation
+ *
+ * Copyright (C) 2026 Process Mission
+ *
+ * Authors:
+ *    Chao Liu <chao.liu@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/rk3588.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties-system.h"
+#include "system/address-spaces.h"
+#include "system/device_tree.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
+#include "system/system.h"
+
+#define TYPE_ROCK5B_MACHINE MACHINE_TYPE_NAME("rock-5b")
+OBJECT_DECLARE_SIMPLE_TYPE(Rock5BMachineState, ROCK5B_MACHINE)
+
+enum {
+    ROCK5B_LOW_RAM,
+    ROCK5B_HIGH_RAM,
+};
+
+static const MemMapEntry rock5b_memmap[] = {
+    [ROCK5B_LOW_RAM]  = { 0x000000000, 0x0f0000000 },
+    [ROCK5B_HIGH_RAM] = { 0x100000000, 0x310000000 },
+};
+
+/* Match the low-memory reservation made by Rockchip U-Boot for BL31. */
+#define ROCK5B_FIRMWARE_RESERVED_SIZE (2 * MiB)
+/* UART2 drives the board's debug header. */
+#define ROCK5B_CONSOLE_UART 2
+
+struct Rock5BMachineState {
+    MachineState parent_obj;
+
+    RK3588SoCState soc;
+    MemoryRegion low_ram;
+    MemoryRegion high_ram;
+    uint64_t low_ram_size;
+    uint64_t high_ram_size;
+    struct arm_boot_info binfo;
+};
+
+/*
+ * The first -serial option drives the debug console; further options
+ * connect to the remaining UARTs in index order.
+ */
+static void rock5b_connect_serial(Rock5BMachineState *s)
+{
+    unsigned int hd = 1;
+
+    /* UART0 in the PMU power domain is not modeled. */
+    for (unsigned int i = 1; i < RK3588_NUM_UARTS; i++) {
+        g_autofree char *prop = g_strdup_printf("uart%u-chardev", i);
+
+        qdev_prop_set_chr(DEVICE(&s->soc), prop,
+                          serial_hd(i == ROCK5B_CONSOLE_UART ? 0 : hd++));
+    }
+}
+
+/*
+ * arm_load_dtb() replaces the memory nodes with a single node for low RAM;
+ * add the RAM above the peripheral hole.
+ */
+static void rock5b_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
+{
+    const Rock5BMachineState *s = container_of(binfo, Rock5BMachineState,
+                                               binfo);
+    hwaddr base = rock5b_memmap[ROCK5B_HIGH_RAM].base;
+    g_autofree char *node = NULL;
+    uint32_t acells, scells;
+
+    if (!s->high_ram_size) {
+        return;
+    }
+
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells", NULL,
+                                   &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells", NULL,
+                                   &error_fatal);
+    node = g_strdup_printf("/memory@%" HWADDR_PRIx, base);
+    qemu_fdt_add_subnode(fdt, node);
+    qemu_fdt_setprop_string(fdt, node, "device_type", "memory");
+    if (qemu_fdt_setprop_sized_cells(fdt, node, "reg", acells, base,
+                                     scells, s->high_ram_size) < 0) {
+        error_report("rock-5b: device tree cells cannot describe RAM "
+                     "above 4 GiB");
+        exit(EXIT_FAILURE);
+    }
+}
+
+/*
+ * arm_load_kernel() enters Linux at EL2, keeps the SMC PSCI conduit and
+ * registers the CPU reset handlers.
+ */
+static void rock5b_direct_boot(Rock5BMachineState *s)
+{
+    s->binfo.ram_size = s->low_ram_size - ROCK5B_FIRMWARE_RESERVED_SIZE;
+    s->binfo.loader_start = ROCK5B_FIRMWARE_RESERVED_SIZE;
+    s->binfo.board_id = -1;
+    s->binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    s->binfo.modify_dtb = rock5b_modify_dtb;
+    arm_load_kernel(&s->soc.cpu[0], MACHINE(s), &s->binfo);
+}
+
+static void rock5b_init(MachineState *ms)
+{
+    Rock5BMachineState *s = ROCK5B_MACHINE(ms);
+
+    if (ms->ram_size < 128 * MiB || ms->ram_size > 16 * GiB) {
+        error_report("rock-5b: memory size must be between "
+                     "128 MiB and 16 GiB");
+        exit(EXIT_FAILURE);
+    }
+
+    if (kvm_enabled()) {
+        error_report("rock-5b: KVM is not supported");
+        exit(EXIT_FAILURE);
+    }
+
+    if (ms->firmware) {
+        error_report("rock-5b: -bios is not supported");
+        exit(EXIT_FAILURE);
+    }
+    if (ms->kernel_filename) {
+        if (!ms->dtb) {
+            error_report("rock-5b: direct Linux boot requires -dtb");
+            exit(EXIT_FAILURE);
+        }
+    } else if (!qtest_enabled()) {
+        error_report("rock-5b: supply a Linux kernel with -kernel");
+        exit(EXIT_FAILURE);
+    }
+
+    /* Initialize the SoC object. */
+    object_initialize_child(OBJECT(s), "soc", &s->soc, TYPE_RK3588_SOC);
+    object_property_set_link(OBJECT(&s->soc), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    rock5b_connect_serial(s);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    s->low_ram_size = MIN(ms->ram_size,
+                          rock5b_memmap[ROCK5B_LOW_RAM].size);
+    s->high_ram_size = ms->ram_size - s->low_ram_size;
+    memory_region_init_alias(&s->low_ram, OBJECT(s), "rock-5b.low-ram",
+                             ms->ram, 0, s->low_ram_size);
+    memory_region_add_subregion(get_system_memory(),
+                                rock5b_memmap[ROCK5B_LOW_RAM].base,
+                                &s->low_ram);
+    if (s->high_ram_size) {
+        memory_region_init_alias(&s->high_ram, OBJECT(s),
+                                 "rock-5b.high-ram", ms->ram,
+                                 s->low_ram_size, s->high_ram_size);
+        memory_region_add_subregion(get_system_memory(),
+                                    rock5b_memmap[ROCK5B_HIGH_RAM].base,
+                                    &s->high_ram);
+    }
+
+    rock5b_direct_boot(s);
+}
+
+static void rock5b_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Radxa ROCK 5B";
+    mc->init = rock5b_init;
+    mc->default_ram_size = 2 * GiB;
+    mc->default_ram_id = "rock-5b.ram";
+    mc->min_cpus = RK3588_NUM_CPUS;
+    mc->default_cpus = RK3588_NUM_CPUS;
+    mc->max_cpus = RK3588_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a55");
+}
+
+static const TypeInfo rock5b_typeinfo = {
+    .name = TYPE_ROCK5B_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(Rock5BMachineState),
+    .class_init = rock5b_class_init,
+};
+
+static void rock5b_register_types(void)
+{
+    type_register_static(&rock5b_typeinfo);
+}
+
+type_init(rock5b_register_types)
-- 
2.53.0



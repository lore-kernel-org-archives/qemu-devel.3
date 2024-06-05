Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBFCC25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEgBW-00038Y-0a; Tue, 04 Jun 2024 22:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBT-00037e-Ur
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:28 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBI-0001gh-FN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id F1C5111401FF;
 Tue,  4 Jun 2024 22:15:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 04 Jun 2024 22:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553713;
 x=1717640113; bh=84HJ4p0kn2I6k5zCPTQUDkUIj3kgHZjO350aurS/Cqk=; b=
 ulaWUlnKJE0z4grdFFmbFfW1wGml0800Jzz4/wJlDooRRmJawdhAAywAoQerO5xP
 5U5k2Dz5MkP9natghFuikoko1tMp3vYcYC7lMKN/MbI0s7ys5HGX1G8b7lC6MBMt
 QmRhYn0KAArIo91wb56FoJx4cWHa0RwDjMDyF1pDBMvLSVubVWegVcGgvJ/KWWg2
 ++YMihFKn4LKz/n157JoWwV8SGe09mAH/EMaK2OL7qizTRqzPOQIGUnHCGCzoA7y
 yYg0Ed+xVZpPkvQuijE73eniMvU/TyZ/ORV76uXeiU8aZtlpWd9kQV9F4YSb8Ira
 8xcCR9K5yt1Bp1laO/rNMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553713; x=
 1717640113; bh=84HJ4p0kn2I6k5zCPTQUDkUIj3kgHZjO350aurS/Cqk=; b=i
 2v7ZT3mQvU5IHUiJHtWSKlfVBesUBp+jHD/aP4RuHK2e7bVYESe9f3nTzYgvFDLi
 R14Y40IYm1PfkoLcDLb3WWjMXFKhz0ZiXI1biChvvUL5ikqaoRTaPQ5lB2MNW8H+
 MsNvBHO3DeyKpyeGkc7qzQXA8PdRWNWDqlS/zetvNQHbBKw2LKJTREzK3Nlm/Xqw
 2YjyQekh5DueaN2PqlRBQy7cof1rKq0s4ZFEUq/to5rULx5Sexa6hegb3EY8xysN
 Y3kpuwLe341JszZ/T0/zJ5n+aI+1Pv8dta0o0PhCFynIGB0BkYZOco7behWfNa/Z
 unShgjlLRQ3tQAV2Sug1w==
X-ME-Sender: <xms:McpfZj9-tSL6862R9CZU1S3pEs0cp8ZbyVWag25v0X-kkqfAHiFQsg>
 <xme:McpfZvt2vSLGxyry9_c58MxFog6hKUMeFQx5qYWacOLayG5Cj-BxvDEk3DlMoJ9Fa
 VZ8k_Oayg5DIqJOZe8>
X-ME-Received: <xmr:McpfZhCDVVRf_9YLJRhE1omcDUlLV4M25zKuyPxSIp03COV1rm1_cV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhephffgvdfgveelveeutedukedukeekfeevjeeiieeikeehveei
 tefgveduudeuudeknecuffhomhgrihhnpehiohgtshhrrdhmrhenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:McpfZveZzLPpHM6jrj9hrIzC31N76mJbwmJnZJzZCgswqwjg0n6_IA>
 <xmx:McpfZoM8ab4CiwsMQ0en60e33opAXWwRKXtKOhWzUDzBi50QkLzfvw>
 <xmx:McpfZhkS14KNJq5HKvazhuO4hyPWmAFLMLo1TOldKrT9Z3c881yp2g>
 <xmx:McpfZiu8fr8CuVsCo-WHss4IrTzuL9k2YRTQgQP2l9t4lUND4-XqXA>
 <xmx:McpfZn2Z4VYCcsQoh1uTpqVUg7t_knQ1ningAfpQgT7zO-Az9yU1_Fmv>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:15:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:15:04 +0100
Subject: [PATCH v3 3/4] hw/mips/loongson3_virt: Wire up loongson_ipi device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v3-3-ddd2c0e03fa3@flygoat.com>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5931;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=PU0pRzZdrbatFFMu+BeAzyWRMViyfj/mEDg8DqP63O4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT4U3pTWL36XyR679h72b9Vb5Z1XMSh2wJf5do6Tnew7
 6xhVFjZUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNJvcHIMDNBqXma1JOfVgxc
 PqonxOdH8C+r4710/5HgPY7j/Ga5GYwM21fb+vx7nFG+5SbnC402FoWCuvPycUGH83/Fl2kaHWD
 lAgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Wire up loongson_ipi device for loongson3_virt machine, so we
can have SMP support for TCG backend as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/Kconfig           |  1 +
 hw/mips/loongson3_bootp.c |  2 --
 hw/mips/loongson3_bootp.h |  3 +++
 hw/mips/loongson3_virt.c  | 39 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index a7f26edebe84..692bede538ee 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -67,6 +67,7 @@ config LOONGSON3V
     imply USB_OHCI_PCI
     select SERIAL
     select GOLDFISH_RTC
+    select LOONGSON_IPI
     select LOONGSON_LIOINTC
     select PCI_EXPRESS_GENERIC_BRIDGE
     select MSI_NONBROKEN
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 03a10b63c1b4..b97b81903b74 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -25,8 +25,6 @@
 #include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
 
-#define LOONGSON3_CORE_PER_NODE 4
-
 static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index 1b0dd3b59171..9091265df7fc 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -200,6 +200,8 @@ struct boot_params {
     struct efi_reset_system_t reset_system;
 };
 
+#define LOONGSON3_CORE_PER_NODE 4
+
 /* Overall MMIO & Memory layout */
 enum {
     VIRT_LOWMEM,
@@ -211,6 +213,7 @@ enum {
     VIRT_BIOS_ROM,
     VIRT_UART,
     VIRT_LIOINTC,
+    VIRT_IPI,
     VIRT_PCIE_MMIO,
     VIRT_HIGHMEM
 };
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 440268a07430..3a4105228c1d 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -36,6 +36,7 @@
 #include "hw/mips/loongson3_bootp.h"
 #include "hw/misc/unimp.h"
 #include "hw/intc/i8259.h"
+#include "hw/intc/loongson_ipi.h"
 #include "hw/loader.h"
 #include "hw/isa/superio.h"
 #include "hw/pci/msi.h"
@@ -74,6 +75,7 @@ const MemMapEntry virt_memmap[] = {
     [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
     [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
     [VIRT_UART] =        { 0x1fe001e0,           0x8 },
+    [VIRT_IPI] =         { 0x3ff01000,         0x400 },
     [VIRT_LIOINTC] =     { 0x3ff01400,          0x64 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_HIGHMEM] =     { 0x80000000,           0x0 }, /* Variable */
@@ -485,6 +487,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     Clock *cpuclk;
     CPUMIPSState *env;
     DeviceState *liointc;
+    DeviceState *ipi = NULL;
     char *filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *kernel_filename = machine->kernel_filename;
@@ -494,6 +497,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *iocsr = g_new(MemoryRegion, 1);
 
     /* TODO: TCG will support all CPU types */
     if (!kvm_enabled()) {
@@ -527,6 +531,19 @@ static void mips_loongson3_virt_init(MachineState *machine)
     create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * MiB);
     create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * MiB);
 
+    memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
+
+    /* IPI controller is in kernel for KVM */
+    if (!kvm_enabled()) {
+        ipi = qdev_new(TYPE_LOONGSON_IPI);
+        qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+        memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
+        memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
+    }
+
     liointc = qdev_new("loongson.liointc");
     sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
 
@@ -543,6 +560,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
     for (i = 0; i < machine->smp.cpus; i++) {
+        int node = i / LOONGSON3_CORE_PER_NODE;
+        int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
 
         /* init CPUs */
@@ -553,12 +572,28 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
-        if (i >= 4) {
+        if (ipi) {
+            hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
+            base += core * 0x100;
+            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
+            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
+        }
+
+        if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
+            MemoryRegion *core_iocsr = g_new(MemoryRegion, 1);
+            g_autofree char *name = g_strdup_printf("loongson3.core%d_iocsr", i);
+            memory_region_init_alias(core_iocsr, OBJECT(cpu), name,
+                                     iocsr, 0, UINT32_MAX);
+            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
+                                        0, core_iocsr);
+        }
+
+        if (node > 0) {
             continue; /* Only node-0 can be connected to LIOINTC */
         }
 
         for (ip = 0; ip < 4 ; ip++) {
-            int pin = i * 4 + ip;
+            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
             sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
                                pin, cpu->env.irq[ip + 2]);
         }

-- 
2.43.0



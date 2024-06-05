Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34826C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEg0w-0007Pt-O3; Tue, 04 Jun 2024 22:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0u-0007P2-TI
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:32 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0t-00076y-56
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B7CEA11401F3;
 Tue,  4 Jun 2024 22:04:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 04 Jun 2024 22:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553070;
 x=1717639470; bh=84HJ4p0kn2I6k5zCPTQUDkUIj3kgHZjO350aurS/Cqk=; b=
 jbo0f/ZMxm/ZmabtgDFN9YBCsLE6f7yysF0ZEHNcjxhgSDl7lNFajePUpMnRkhMC
 o+941zlrrUkZh3w1hrLw7hUfbzJ8j1+RMurYmIk3H1R6IgYAaN4eDI9UTcyVrczS
 qis492PoNDxrrc8KyEysus9OafQycPCCFG5PSu9dakfjruxliAbv6/3IJ4SKqAgx
 55t918nYHxoy163p2/rUtcQtFtr6IQ0cxYW5c85W7eS6S3edh+3zIzaXPVuK0neV
 1RZfN29ENVtjbX1u0sQIyqwhtSPVVBYXevJtpfsW+nnl15Dsnr3ptBDHeai5dYP7
 /H5dfhz3ZmEEi3yg073cjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553070; x=
 1717639470; bh=84HJ4p0kn2I6k5zCPTQUDkUIj3kgHZjO350aurS/Cqk=; b=G
 F8idAKxHk6lHUcru1ojqAWeJxOC00fr/7kv7DQcNhKqJJ2Pbq7atXv/3PFLHLLr7
 gToC0O6FETffti5z4QS8IGbeAq2HyHAirn5YzX9cB2anXis2YmfGfB6WRFPMX3Gs
 gIWIbpYknks7i9FSQnLaufFl/4o7Y6G4+J8R0WBuJU0ux1uqHKchIrM8xZ8qzO8C
 KIzxmHTxtcjNHWFGvBCyialU+GVFb+mrhpAGbVre7TdMB3WBdf/FB2uVOSpWyrFh
 zmo+oAqxM3ephnIkiAjYxQ3n+nOL7H/lnlcA9E1TDKuNh4KcLlgUhc56awY+/swt
 H7/yuIdVpvn1ATW4xJb0w==
X-ME-Sender: <xms:rsdfZofCg08EzkU8daDNwMX7ig8d9R5paUFCQumjC1pKQ27vqFbMJA>
 <xme:rsdfZqM5Sep0kHzc3hduRUHjKXKgqpYET7iuV2ozTqsTwZSDg_XWEPBAVo6kK4kbA
 nipaZx-iA09o8YkYlE>
X-ME-Received: <xmr:rsdfZphUmv4IiP5E1pA1I4Rvfgbw6wpyRyNfkk_xFrIUokvUvp012sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhephffgvdfgveelveeutedukedukeekfeevjeeiieeikeehveei
 tefgveduudeuudeknecuffhomhgrihhnpehiohgtshhrrdhmrhenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:rsdfZt8AuiC53xw80j9n5jkz1yeB-PZmA3rcIhKUZ1rTGf-2pwIV8Q>
 <xmx:rsdfZkt90ne0-MtZNXzVCW25IQUFgt1tCO42Lasqi0y_R3e22KsADw>
 <xmx:rsdfZkFXOy2bszIKXg5ZhIM7r4nG51xTAR5NYhQuz6l4d9evvkCSHg>
 <xmx:rsdfZjMeMtPs0whMHdLunDpZioGw5KUTpfwmGhvmtB8mcvmqy6EAFQ>
 <xmx:rsdfZuXLrlZIZ7ldEEBnmU_guklGcZRFfyyRCc7ko_RcrKsozG00Yqee>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:04:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:04:26 +0100
Subject: [PATCH v2 3/4] hw/mips/loongson3_virt: Wire up loongson_ipi device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v2-3-da26282e03a5@flygoat.com>
References: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5931;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=PU0pRzZdrbatFFMu+BeAzyWRMViyfj/mEDg8DqP63O4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT446tUni68fPPChJgis03/Ztjt64soauo0dpG1eqL4+
 aGSufqSjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZgI52JGhm+pmj3rFm2fO++i
 5JrGn1HO7RmlGtOZNd66qxW8nSAsksrI8O/lMQe16VK8Z45m/Kt728vtYZS53OrN6pOKj5wXxF9
 wYgEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



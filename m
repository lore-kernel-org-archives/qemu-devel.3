Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAFEC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h0k-00086y-Qf; Wed, 08 May 2024 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0b-0007tU-1G
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:57 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0Y-0006Pk-UF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 67137114010A;
 Wed,  8 May 2024 09:06:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 08 May 2024 09:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715173614;
 x=1715260014; bh=4LwRiEoSvlUmlDOR6/fQshKnOWo4pgpnzj5irs2FRIE=; b=
 SJgFrGGeTDrmAaPAEw2L8kSakC8s4CxiraOW8vMFp4zAkLr5RR0rhd7gIBPB8kBr
 aZGzAsRqK2IJLcKcY3TuV8NS2fNbmJ+2dbPgEw3du0k4UYl2hsY0yPiZKKhN3pkT
 fTJIgRk8PIzNYSSKpaFSdcHM1O0ThZc99RlBQUFupQkrEm3foUSDvI7k+0U3Symw
 BQz+5AjSGrEfMnBeZvRnXgc/x/m2z/ppjdjtcG2p8UiOms551lL4F5R35QmZH9aA
 DB3EE72mVbcbRoZy4hcX08KTE2oEHPGEK9tF0+2FmPQ0BphaEABBWWzWh5Q+R7CS
 RwC/bf1IObmsf8gxL1gu8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715173614; x=
 1715260014; bh=4LwRiEoSvlUmlDOR6/fQshKnOWo4pgpnzj5irs2FRIE=; b=R
 SZu7Pbq6ZW8zeCTB642pAxQT5iWBHi/FqGGlFCo7LQpDZ69JoanQXRepRVW8I/oy
 wzfShKHF+DOHM0eD/DC8MZF6cJwfleBK0H29ymIT34O5XxSfqTxmC/1E+e4gf16E
 XUTUteBA/Qh12r4CDWUTbPdO18dTKGUndAoeYyQwCaIOeNnPjr2xj+I2qMNA4TGr
 ruLp9lzjneRoV14/BDM/PwwdI8gEkLJq3iaZWu+aLl0chD1jv4m6czBj3JlgaWSB
 WQzdU1PkYKVXlvpAKJj7yOAc4UJhqkhTq1cfg+5HQRwn0ITMR9bcR5VOKXvP0SIB
 ia1o2splFu+wZ4jL3KbLw==
X-ME-Sender: <xms:7Xg7Zvp1Ielr6sdRSQr38-Q1__yVcufJfAEx-1Qctvh5Q6X7-FJGeQ>
 <xme:7Xg7ZprzqymuHCU6qNkb6pMHAUOdCxsyiYC_fR8n6bGCT74QvpegGjA8Q7Uq5OfYA
 0RrzH8v4RvqeBHdp-A>
X-ME-Received: <xmr:7Xg7ZsNsa1D7zdk5AmUezbGz5pI5mFJ8GKQw-g_TixtgtmSe2aCZzc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhephffgvdfgveelveeutedukedukeekfeevjeeiieeikeehveei
 tefgveduudeuudeknecuffhomhgrihhnpehiohgtshhrrdhmrhenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:7ng7Zi7tG2QmqmzYBI0MTRWewhgjRB9buh7ZI_Rycc7MuXhFZSoHtQ>
 <xmx:7ng7Zu4Up329tEhUXtdNn5EYxpJrL6eCas-xWbG8-KM7d7TumFyI1w>
 <xmx:7ng7ZqhZQM0mU4Ve9PvJc75FKoZ2OW-j2Uyu12m0uom5BVPXphN_EA>
 <xmx:7ng7Zg6ucP5KhpcZ2rd8o0yaRM4jLkFS5k9TjT6DErdqYZsPrOKdWg>
 <xmx:7ng7ZgQ3tcVWBjKPxD64ehC52kRd-vu32o9IdHOn21GDLbdQTqJkjdVP>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:06:53 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 08 May 2024 14:06:50 +0100
Subject: [PATCH 5/5] hw/mips/loongson3_virt: Wire up loongson_ipi device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-loongson3-ipi-v1-5-1a7b67704664@flygoat.com>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
In-Reply-To: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5935;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=42RH1oyQ4ZbhZ7p6E7IwxbgswyXKZxwfM2nsZMpXqU8=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTriucBEdaTbeJiz8p5Te99dm5a6bSdnZMy3nV52z7xe
 F0Veqijo5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZyvoyRYb/zSYv3H4/11ST9
 j+Pl6j3x37ZuO6vU+22X3Op7ZjzJY2b4KxR4eq/TfpHbLLOvLsyPlnb72um+PUL3943ohoKzNle
 3cgEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
index 5c83ef49cf6f..6f09fedc946e 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -57,6 +57,7 @@ config LOONGSON3V
     imply USB_OHCI_PCI
     select SERIAL
     select GOLDFISH_RTC
+    select LOONGSON_IPI
     select LOONGSON_LIOINTC
     select PCI_EXPRESS_GENERIC_BRIDGE
     select MSI_NONBROKEN
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index f99af229327a..474d3556b2e5 100644
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
index b10a611a98f4..1052fb7d6747 100644
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
@@ -466,6 +468,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     Clock *cpuclk;
     CPUMIPSState *env;
     DeviceState *liointc;
+    DeviceState *ipi = NULL;
     char *filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *kernel_filename = machine->kernel_filename;
@@ -475,6 +478,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *iocsr = g_new(MemoryRegion, 1);
 
     /* TODO: TCG will support all CPU types */
     if (!kvm_enabled()) {
@@ -508,6 +512,19 @@ static void mips_loongson3_virt_init(MachineState *machine)
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
 
@@ -524,6 +541,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
     for (i = 0; i < machine->smp.cpus; i++) {
+        int node = i / LOONGSON3_CORE_PER_NODE;
+        int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
 
         /* init CPUs */
@@ -534,12 +553,28 @@ static void mips_loongson3_virt_init(MachineState *machine)
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
+            memory_region_init_alias(core_iocsr, OBJECT(machine), name,
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
2.34.1



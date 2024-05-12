Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2E6C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 12:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s68Be-00017D-2l; Sun, 12 May 2024 08:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s68Bd-00016x-8N
 for qemu-devel@nongnu.org; Sun, 12 May 2024 08:20:17 -0400
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s68Bb-0001r6-3I
 for qemu-devel@nongnu.org; Sun, 12 May 2024 08:20:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 25C891C00121;
 Sun, 12 May 2024 08:20:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Sun, 12 May 2024 08:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715516412; x=1715602812; bh=+A
 0wIJUp2tZgdSmjqd3MGPiSgOY7MNp4bOtWkf2swTM=; b=Xm9ydNE2frGRAscjFY
 5LlEwwmoF8ZlC6o7tbWEICH+WbBjip0QcNYvy5uPAOnh2chaeehSPCteY2+kDhQ1
 BOIF7Xd+JCyi94qj1g2KB7IKyQAQ/PKexJCmxk+ZU47BRoqqYVQhOcyp1gxZbuEj
 SK3dddUA8NZxP2C/qLCr2oT3tJrDk54n6N6cl3HI63LWyqwQI5H0zgRbvq/rUPUl
 uuXjDGGOSeLxl+y0JehjbVZcUubkMPpHUFUtNlJnR4qNCSYHLdLPm8o5YNxvwu0u
 KAhhI7Rv6SUp3L0doR7f/HSJAKQbFU4mD6BNdupHQvmjO43L9Ys0uE9fxAZOki2r
 Jyug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715516412; x=1715602812; bh=+A0wIJUp2tZgd
 Smjqd3MGPiSgOY7MNp4bOtWkf2swTM=; b=fGNYWzdNRqDT2LN3J4Qhis2U2rJQo
 RfQFpcpBXjKg3td21sOoyflSzRBLsMhJ0ZP3tHWYZ75TV0OTvnSdJArI8PgNa4Lt
 1sTPqqmGrPFQgw88Z+BzaBHf3gDwv1+Hcl9W9cBkLYZnRN9HLB4Nu8P5iw/mKThG
 rEdW24BFaJZmG4jfvsJ+DI3V/3brb8z2L/wd80rlyDYAHCAU365eGLgQHMu8i35R
 Nhe+dEhwQroz76WnYFhD8xwZ7D40X0d1U0BIUW3PTyP/FgYp94XJB+88+w6lzS76
 C4PYvk4a4I2ayxaT8Lnku2A3DMlN6adMkGyFI5GNkTQEVlnFT/7vPgsbQ==
X-ME-Sender: <xms:_LNAZma1dXDESZn6xD7K1qWo7dqG65tw0oFkD5gdDYpijISu_pu9ww>
 <xme:_LNAZpb8FZnXlw_GAwd98zYbbZfcBSdkJNK7vteYeezc7aigX7-n9Yxh92d3Y-IN0
 DQuDV17fk2YzWmhNjo>
X-ME-Received: <xmr:_LNAZg-o89TBrKwoOGno3NoinRTdkAd8WYteckZjvaOoxUwkAMIlqPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegvddghedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepffetueegkedtgfejveeuvdfghfegtddvgfehudeghfegheetuedu
 heduveejtefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_LNAZop0c8kzqYrarFzyv2vq1zasSM7obHtVkXAy98NCEuQV8TNMQg>
 <xmx:_LNAZhpfWNgFvx2z2myU6HQpD-zRR3OH6BmVfnn0aUK9iWDvreYneA>
 <xmx:_LNAZmR28DvTWO3fXln_UKKvDt8yo4Km2Al_NSVBu9YyzIMdZQ7csg>
 <xmx:_LNAZhrSjd4tBvUYadCDMQYCzA3HpMF8eIhd3ClizGL7IqzjTvnXHQ>
 <xmx:_LNAZinKeZ4OjQna8udVYkq-X6wzsbEjdmHo08QtYuH9wiN-Rkc2FmBZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 May 2024 08:20:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 12 May 2024 13:20:09 +0100
Subject: [PATCH] hw/mips/loongson3_virt: Implement node counter timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-loongson3_hpt-v1-1-5cb9cbae649b@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAPizQGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0ND3Zz8/Lz04vw84/iMghLd5CQDI3NLgyQjk5QkJaCegqLUtMwKsHn
 RsbW1ABd1xjVfAAAA
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5537;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=jvxnlOaDvJlj5RIgl3BRnMjVOw/prK94TNO/RhAswU8=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSHzb/vlTwVN7JTKeQqeNp5uuvPtx37PKfo59X8qFlpz
 N2wRnZFRwkLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzEuJqRobNQ7b90e8jtA3/X
 he97EvJlgc7De98s72l5lTtcm1vNzcjwPXpZCv/BXXuMjS+9z+3/Z3Dz02uJ3n79lWvvrlwTGLW
 PEQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.148;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Node counter is a timer presents on Loongson-3 chips, which runs
as fast as CPU clock. It's being mapped into a MMIO location.

Emulate this for loongson3_virt machine, in hope that kernel can
use it as a better clock source.

Hardware's behavior on 32-bit read/write is also emulated in case
legacy kernel is trying to use it with hi/lo splitted read.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/loongson3_bootp.h |  1 +
 hw/mips/loongson3_virt.c  | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index 1b0dd3b59171..c6a435397d2c 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -210,6 +210,7 @@ enum {
     VIRT_PCIE_ECAM,
     VIRT_BIOS_ROM,
     VIRT_UART,
+    VIRT_NODECNT,
     VIRT_LIOINTC,
     VIRT_PCIE_MMIO,
     VIRT_HIGHMEM
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index b10a611a98f4..b78ac8032096 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -74,6 +74,7 @@ const MemMapEntry virt_memmap[] = {
     [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
     [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
     [VIRT_UART] =        { 0x1fe001e0,           0x8 },
+    [VIRT_NODECNT] =     { 0x3ff00408,           0x8 },
     [VIRT_LIOINTC] =     { 0x3ff01400,          0x64 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_HIGHMEM] =     { 0x80000000,           0x0 }, /* Variable */
@@ -92,6 +93,7 @@ static const MemMapEntry loader_rommap[] = {
 
 struct LoongsonMachineState {
     MachineState parent_obj;
+    Clock *cpuclk;
     MemoryRegion *pio_alias;
     MemoryRegion *mmio_alias;
     MemoryRegion *ecam_alias;
@@ -145,6 +147,29 @@ static const MemoryRegionOps loongson3_pm_ops = {
     }
 };
 
+static uint64_t loongson3_nodecnt_read(void *opaque,
+                                        hwaddr addr, unsigned size)
+{
+    LoongsonMachineState *s = opaque;
+    int64_t now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t ticks = clock_ns_to_ticks(s->cpuclk, now_ns);
+
+    if (addr == 0x4) {
+        return ticks >> 32;
+    }
+
+    return ticks;
+}
+
+static const MemoryRegionOps loongson3_nodecnt_ops = {
+    .read  = loongson3_nodecnt_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 8,
+};
+
 #define DEF_LOONGSON3_FREQ (800 * 1000 * 1000)
 
 static uint64_t get_cpu_freq_hz(void)
@@ -463,7 +488,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
     int i;
     long bios_size;
     MIPSCPU *cpu;
-    Clock *cpuclk;
     CPUMIPSState *env;
     DeviceState *liointc;
     char *filename;
@@ -471,10 +495,12 @@ static void mips_loongson3_virt_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     ram_addr_t ram_size = machine->ram_size;
+    LoongsonMachineState *ms = LOONGSON_MACHINE(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *nodecnt = g_new(MemoryRegion, 1);
 
     /* TODO: TCG will support all CPU types */
     if (!kvm_enabled()) {
@@ -520,14 +546,14 @@ static void mips_loongson3_virt_init(MachineState *machine)
     sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
                          qdev_get_gpio_in(liointc, RTC_IRQ));
 
-    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
-    clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
+    ms->cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(ms->cpuclk, DEF_LOONGSON3_FREQ);
 
     for (i = 0; i < machine->smp.cpus; i++) {
         int ip;
 
         /* init CPUs */
-        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+        cpu = mips_cpu_create_with_clock(machine->cpu_type, ms->cpuclk);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -553,6 +579,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
                            machine->ram, 0, virt_memmap[VIRT_LOWMEM].size);
     memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
                            NULL, "loongson3_pm", virt_memmap[VIRT_PM].size);
+    memory_region_init_io(nodecnt, NULL, &loongson3_nodecnt_ops, ms,
+                          "loongson3_nodecnt", virt_memmap[VIRT_NODECNT].size);
 
     memory_region_add_subregion(address_space_mem,
                       virt_memmap[VIRT_LOWMEM].base, ram);
@@ -562,6 +590,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
                       virt_memmap[VIRT_HIGHMEM].base, machine->ram);
     memory_region_add_subregion(address_space_mem,
                       virt_memmap[VIRT_PM].base, iomem);
+    memory_region_add_subregion(address_space_mem,
+                      virt_memmap[VIRT_NODECNT].base, nodecnt);
 
     /*
      * We do not support flash operation, just loading bios.bin as raw BIOS.

---
base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
change-id: 20240511-loongson3_hpt-cb02790b24db

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>



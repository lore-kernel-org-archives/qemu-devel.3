Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B24AC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNe-00042r-HR; Fri, 04 Sep 2026 01:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNc-0003ok-K6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:24 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNZ-0001Wn-J2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:24 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so625383a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499340; x=1789104140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zxSoBFPieyj/Sbf0WOY/g9YtC/J/XNWOyvE7PScaKY=;
 b=PfdIKiDlQJF3kxwb4wKJaoHQh8eO4GgD2oM+tI/smSpf+T5HuzBgjtyR5Je1gmHWlC
 ds0D2ZW3Wa1HRzoFMHNxQPzK6Vz1ZczShFfWP/oV4j+8ndXkammJVLzbDaGe7rZeHmeG
 v8TrSu93J+JWwZVkpbtGdxeEuQjMgp6+c+F4ThGrMtqGgE9bjCwsVV2fikae3C3gafnK
 B8CDqR2wAxFgV8w0Bfp2vHtsbKvmebqgFyDV8SkyYYfgDl1Eb31hcf2UNt9LMCdJeCPH
 Y/4wvuHed5gt1tYrON7xGpTkiC1gPAvOTpQywCukxn8jVo/xLsGusq3aJDw+XEDnWg+w
 /gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499340; x=1789104140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5zxSoBFPieyj/Sbf0WOY/g9YtC/J/XNWOyvE7PScaKY=;
 b=D/eC6mA8N3Ad0kwtfA0qG1bI2cSs73+8AHFFJY/NMm74MPDXZYOUTGoqjQxt1N2yTM
 D+FZ1PizpBKZOA3ajSgc7hIq39eilAyxGYBCuiD7ylamSc/PGTq45Co3vY+qaC0LaJre
 ROB6m/ZtoePDWqGFzBaUUAk4eX2+wtQrZtHGPpMtBkNIbeh4mDC874G5bAbVR1Tt3cUT
 QlFsmRPXyjXnt3Dbew5uRZZ+f2qdQAYr8gJv10xZdSZI5Ft7irxzzEYHne+wZEOHbhNN
 LvRoGQAhoQvpsga1giR7KDYlOzecHuAfHLbknR7EY71aQM7eUnquYDt+s9fF76N8ENyu
 jFAw==
X-Gm-Message-State: AFuF++l/x3ZiSdMJUAQ/33aaf75wLFe6F8Bpo69eIYRjcTGFO/L7hde0
 3w3RtLA8YS0gqqSGfolO9Zs5BJfZYlTGCCoU8lSQvbGXXz6REqRrloiWndb6qg==
X-Gm-Gg: AYBFou2vkv6ognZ7DlD468CDtvJQ6HLuboYeeyLFgWUVEzH96o2h4p2Cq3InSR1xGk3
 Nt/B4wWfrlg7Kf3c9ly/5iPuZHJ4k0Tdrqp2eyRD24xKV3uxqyVbvVSVzU1HNEeCqDTLC5w7z4A
 4DX6pXsIKDTzfcZ0hjXC3syhR/5FRRKvbb42PhmXwjjZExssn0PIEhoMiAVQ0KXdguOWT+p25ku
 vqfZusTJnhkuGa+gcBR+o6bHNmGW4S7uhN1KrOM9E2BbNLiaucJYqVeoxh5salr92vSxakeLs8E
 8YmeMHGv7hXOtuHJJec/gUKM44TjjkqO4UIw+l8f3cwbfk7xM1aswtk5VmRZWySsdrnDND6lz/6
 oIBbdkHlO+inKOobBS3fHRjIB/muBVFg677WgzHA0QiPXlDCefu6/a0BneO9J7wvDYFEIUgvkTH
 jSoOqXdhcXXy1+0l6Zyp4fNAy/5FR6jZddpoY729x5QQjQGXO1VUnrBFCWMAOFLjxd/sBYWmktt
 M/Nog==
X-Received: by 2002:a05:6a21:3a85:b0:3d3:ae40:ab0f with SMTP id
 adf61e73a8af0-3da3a1f0a48mr5446819637.26.1788499339867; 
 Thu, 03 Sep 2026 22:22:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:22:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/47] hw/riscv/atlantis: Extract an Atlantis SoC device
Date: Fri,  4 Sep 2026 15:19:42 +1000
Message-ID: <20260904051943.799041-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

Introduce TYPE_TT_ATLANTIS_SOC and move the hart array, AIA, ACLINT,
boot ROM, UART and I2C controllers into the new TTAtlantisSoCState. The
machine keeps ownership of RAM, device tree generation, firmware
loading, and the board-level I2C slaves.

This makes it easier to compose the SoC into a more complex machine in
the future.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-16-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  21 ++++-
 hw/riscv/tt_atlantis.c         | 144 +++++++++++++++++++++++----------
 2 files changed, 119 insertions(+), 46 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 9ca98bfb84..5d4e4d133b 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -19,14 +19,16 @@
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+#define TYPE_TT_ATLANTIS_SOC "tt-atlantis-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
+
 #define TT_ATL_NUM_I2C 5
 
-struct TTAtlantisState {
+struct TTAtlantisSoCState {
     /*< private >*/
-    MachineState parent;
+    DeviceState parent;
 
     /*< public >*/
-    Notifier machine_done;
     const MemMapEntry *memmap;
 
     MemoryRegion *memory;
@@ -39,6 +41,19 @@ struct TTAtlantisState {
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
     MemoryRegion bootrom;
+
+    uint32_t num_harts;
+    char *cpu_type;
+};
+
+struct TTAtlantisState {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+    Notifier machine_done;
+
+    TTAtlantisSoCState soc;
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 2a46336674..c44fd8d6d0 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
@@ -14,6 +15,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 
 #include "target/riscv/cpu.h"
@@ -66,7 +68,7 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
 
-static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
+static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
 {
     assert(busnr < TT_ATL_NUM_I2C);
 
@@ -79,7 +81,7 @@ static uint32_t next_phandle(void)
     return fdt_phandle++;
 }
 
-static void create_fdt_memory(void *fdt, TTAtlantisState *s)
+static void create_fdt_memory(void *fdt, TTAtlantisSoCState *s)
 {
     hwaddr ram_size = memory_region_size(s->dram);
     hwaddr size_lo = ram_size;
@@ -104,7 +106,7 @@ static void create_fdt_memory(void *fdt, TTAtlantisState *s)
     }
 }
 
-static void create_fdt_aclint(void *fdt, TTAtlantisState *s,
+static void create_fdt_aclint(void *fdt, TTAtlantisSoCState *s,
                               uint32_t *intc_phandles)
 {
     g_autofree char *name = NULL;
@@ -206,7 +208,7 @@ static void create_fdt_one_aplic(void *fdt,
     qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
 }
 
-static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
+static void create_fdt_pmu(void *fdt, TTAtlantisSoCState *s)
 {
     char pmu_name[] = "/pmu";
     RISCVCPU *hart = &s->cpus.harts[0];
@@ -216,7 +218,7 @@ static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
     riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
-static void create_fdt_cpu(void *fdt, TTAtlantisState *s,
+static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
                            uint32_t aplic_s_phandle,
                            uint32_t imsic_s_phandle)
 {
@@ -313,7 +315,7 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
-static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
+static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
                                   const char *compat, int addr)
 {
     hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
@@ -325,7 +327,7 @@ static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
-static void finalize_fdt(void *fdt, TTAtlantisState *s)
+static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
@@ -359,9 +361,9 @@ static void finalize_fdt(void *fdt, TTAtlantisState *s)
     create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
 }
 
-static void create_fdt(TTAtlantisState *s)
+static void create_fdt(TTAtlantisState *ams)
 {
-    MachineState *ms = MACHINE(s);
+    MachineState *ms = MACHINE(ams);
     int fdt_size = 0;
 
     ms->fdt = riscv_create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
@@ -373,12 +375,12 @@ static void create_fdt(TTAtlantisState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_pmu(ms->fdt, s);
+    create_fdt_pmu(ms->fdt, &ams->soc);
 }
 
-static void load_fdt(TTAtlantisState *s)
+static void load_fdt(TTAtlantisState *ams)
 {
-    MachineState *ms = MACHINE(s);
+    MachineState *ms = MACHINE(ams);
     char **node_path;
     Error *err = NULL;
     int fdt_size = 0;
@@ -404,7 +406,7 @@ static void load_fdt(TTAtlantisState *s)
         g_strfreev(node_path);
     }
 
-    create_fdt_memory(ms->fdt, s);
+    create_fdt_memory(ms->fdt, &ams->soc);
 }
 
 static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
@@ -418,10 +420,11 @@ static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
-static void tt_atlantis_machine_done(Notifier *notifier, void *data)
+static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
-    TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
-    MachineState *machine = MACHINE(s);
+    TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
+    TTAtlantisSoCState *s = &ams->soc;
+    MachineState *machine = MACHINE(ams);
     hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
     hwaddr mem_size;
     target_ulong firmware_end_addr, kernel_start_addr;
@@ -479,23 +482,39 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
                               fdt_load_addr);
 }
 
-static void tt_atlantis_machine_init(MachineState *machine)
+static void tt_atlantis_soc_init(Object *obj)
 {
-    TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
+    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+
+    object_initialize_child(obj, "uart1", &s->uart1,
+                            TYPE_UNIMPLEMENTED_DEVICE);
 
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        object_initialize_child(obj, "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+    }
+}
+
+static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
+{
+    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(dev);
     ram_addr_t lo_ram_size, ram_size;
-    int hart_count = machine->smp.cpus;
+    int hart_count = s->num_harts;
 
     s->memory = get_system_memory();
 
-    s->dram = machine->ram;
+    if (!s->dram) {
+        error_setg(errp, "'dram' link is not set");
+        return;
+    }
     ram_size = memory_region_size(s->dram);
 
     s->memmap = tt_atlantis_memmap;
 
-    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
-                            TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine->cpu_type,
+    /* CPUs */
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", s->cpu_type,
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
                             &error_abort);
@@ -504,7 +523,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
+        return;
+    }
 
     s->irqchip = riscv_create_aia(s->memory,
                                   true, TT_IMSIC_GUESTS,
@@ -534,26 +555,27 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * up to 64GB. The low address is an alias of the first 2GB of that RAM.
      */
     if (ram_size > s->memmap[TT_ATL_DDR_HI].size) {
-        char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
-        error_report("RAM size is too large, maximum is %s", sz);
-        g_free(sz);
-        exit(EXIT_FAILURE);
+        g_autofree char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
+        error_setg(errp, "RAM size is too large, maximum is %s", sz);
+        return;
     }
 
-    memory_region_init_alias(&s->ram_hi, OBJECT(machine), "ram.high", s->dram,
+    memory_region_init_alias(&s->ram_hi, OBJECT(s), "ram.high", s->dram,
                              0, ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
 
     lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
-    memory_region_init_alias(&s->ram_lo, OBJECT(machine), "ram.low", s->dram,
+    memory_region_init_alias(&s->ram_lo, OBJECT(s), "ram.low", s->dram,
                              0, lo_ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
 
     /* Boot ROM */
-    memory_region_init_rom(&s->bootrom, NULL, "tt-atlantis.bootrom",
-                           s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
+    if (!memory_region_init_rom(&s->bootrom, OBJECT(s), "tt-atlantis.bootrom",
+                                s->memmap[TT_ATL_BOOTROM].size, errp)) {
+        return;
+    }
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
@@ -570,26 +592,56 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * Create an unimplemented device region so writes don't fault
      * and reads return zero, which keeps Linux happy.
      */
-    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
                            "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
                            s->memmap[TT_ATL_UART1].size);
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
-        SysBusDevice *sbd;
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->i2c[i]);
 
-        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
-                                TYPE_DESIGNWARE_I2C);
-        sbd = SYS_BUS_DEVICE(&s->i2c[i]);
-        sysbus_realize(sbd, &error_fatal);
+        if (!sysbus_realize(sbd, errp)) {
+            return;
+        }
         memory_region_add_subregion(s->memory,
                                     s->memmap[TT_ATL_I2C0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
+}
+
+static const Property tt_atlantis_soc_props[] = {
+    DEFINE_PROP_STRING("cpu-type", TTAtlantisSoCState, cpu_type),
+    DEFINE_PROP_UINT32("num-harts", TTAtlantisSoCState, num_harts, 8),
+    DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = tt_atlantis_soc_realize;
+    device_class_set_props(dc, tt_atlantis_soc_props);
+    /* The SoC can only be instantiated from the machine */
+    dc->user_creatable = false;
+}
+
+static void tt_atlantis_machine_init(MachineState *machine)
+{
+    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
+    TTAtlantisSoCState *s = &ams->soc;
+
+    object_initialize_child(OBJECT(machine), "soc", &ams->soc,
+                            TYPE_TT_ATLANTIS_SOC);
+    object_property_set_str(OBJECT(&ams->soc), "cpu-type", machine->cpu_type,
+                            &error_abort);
+    object_property_set_int(OBJECT(&ams->soc), "num-harts", machine->smp.cpus,
+                            &error_abort);
+    object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
+                             &error_abort);
+    qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
     i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
@@ -597,13 +649,13 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
     /* Load or create device tree */
     if (machine->dtb) {
-        load_fdt(s);
+        load_fdt(ams);
     } else {
-        create_fdt(s);
+        create_fdt(ams);
     }
 
-    s->machine_done.notify = tt_atlantis_machine_done;
-    qemu_add_machine_init_done_notifier(&s->machine_done);
+    ams->machine_done.notify = tt_atlantis_machine_done;
+    qemu_add_machine_init_done_notifier(&ams->machine_done);
 }
 
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
@@ -623,6 +675,12 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo tt_atlantis_types[] = {
     {
+        .name       = TYPE_TT_ATLANTIS_SOC,
+        .parent     = TYPE_DEVICE,
+        .instance_size = sizeof(TTAtlantisSoCState),
+        .instance_init = tt_atlantis_soc_init,
+        .class_init = tt_atlantis_soc_class_init,
+    }, {
         .name       = MACHINE_TYPE_NAME("tt-atlantis"),
         .parent     = TYPE_MACHINE,
         .class_init = tt_atlantis_machine_class_init,
-- 
2.55.0



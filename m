Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A409EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafew-0000XZ-Lm; Thu, 15 Feb 2024 12:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-0007yt-6L
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeE-0003wH-D5
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33cf6374e58so533083f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018544; x=1708623344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pnTJErH0qji7fRUt4aVWtRhwjDx7oeKsvtzPxAX2A8w=;
 b=YELXznsUb0fxpcDb67b5StKCq9AE54pN/EjvCX3LjDOJIZ1KxcqFiEV3T52SN4cKgN
 L6f245B2XBhtjDE6zVRyzX887LQDQAEs8N87hmqHEj8ctSNPNOJDmBw54u8hZsiJZW0R
 iWlX+jfv7EwMrqrKG1tFfZcPOT/oJfAzwA48LrJ9LrawraX9giuRfeUw6khVcAZJ7m8C
 CqvcmydBJ/E1xDG+4Bp2Ivq0k8N4SODHf0NCYG4FwFGCzj44WfsaoQ+b/w8BpLtctDhR
 5FVXPD7TbhhUKvgeDdwK5ur474FyRmM+sm8hVm9m99tcLbrrEoAlZjBGqc6Z6/ZEwnhm
 SCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018544; x=1708623344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnTJErH0qji7fRUt4aVWtRhwjDx7oeKsvtzPxAX2A8w=;
 b=wMd3YyZpCjkc3ybNSQhRCo9hQB82BFNgg0Ca0Ew2Qkc+6z69jihnF3QLKAHjNBg5Yu
 jmtBLgacuFOb14T8YZ5KIRjQi9SDXyyHLtR1Sl9/VGRdtAQW05V3fmC050rE9RiDKV9X
 hffgALNXxFX/za5haXVheH357VAxM5syvnvrwoyV3mgrY7BuSIDuIN7DpdVVxHP8KMO6
 w1Cn6oWcl2lPJyiDnTE+wlwzYsxjaigt/JWXICzf/h+zywwgs3Rnxm7/53b7LYl6cNf1
 yjOm9APhAWatX+pp0nreFfjLv5CPZYmWZOvwlLhHcSeXqVxtqKPEr/QJdI6DxQN4kNrQ
 IToQ==
X-Gm-Message-State: AOJu0YwqafQ2QJm6feY7RDNCDh5l3YdH9F6SvVNnw0pyZXIUSP1T0tQj
 E9IBFWZikkGIFW/rgYifXSizn0i3fgDT64jRh313Er2AFoulIR+jLhgvStvUXjKxBCy7RTK5gDu
 w
X-Google-Smtp-Source: AGHT+IHDHdrOr1tHBlIHhz2nBoXf1YpsameVb2apwnewFXe0vokZAknn6EV+eb3nd2B8QaZ/vEH7OQ==
X-Received: by 2002:a5d:644b:0:b0:33c:e395:bd77 with SMTP id
 d11-20020a5d644b000000b0033ce395bd77mr1827473wrw.0.1708018544754; 
 Thu, 15 Feb 2024 09:35:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/35] hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
Date: Thu, 15 Feb 2024 17:35:15 +0000
Message-Id: <20240215173538.2430599-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Armv8.1+ CPUs have the Virtual Host Extension (VHE) which adds a
non-secure EL2 virtual timer.  We implemented the timer itself in the
CPU model, but never wired up its IRQ line to the GIC.

Wire up the IRQ line (this is always safe whether the CPU has the
interrupt or not, since it always creates the outbound IRQ line).
Report it to the guest via dtb and ACPI if the CPU has the feature.

The DTB binding is documented in the kernel's
Documentation/devicetree/bindings/timer/arm\,arch_timer.yaml
and the ACPI table entries are documented in the ACPI specification
version 6.3 or later.

Because the IRQ line ACPI binding is new in 6.3, we need to bump the
FADT table rev to show that we might be using 6.3 features.

Note that exposing this IRQ in the DTB will trigger a bug in EDK2
versions prior to edk2-stable202311, for users who use the virt board
with 'virtualization=on' to enable EL2 emulation and are booting an
EDK2 guest BIOS, if that EDK2 has assertions enabled.  The effect is
that EDK2 will assert on bootup:

 ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48

If you see that assertion you should do one of:
 * update your EDK2 binaries to edk2-stable202311 or newer
 * use the 'virt-8.2' versioned machine type
 * not use 'virtualization=on'

(The versions shipped with QEMU itself have the fix.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Message-id: 20240122143537.233498-3-peter.maydell@linaro.org
---
 include/hw/arm/virt.h    |  2 ++
 hw/arm/virt-acpi-build.c | 20 ++++++++++----
 hw/arm/virt.c            | 60 ++++++++++++++++++++++++++++++++++------
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f69239850e6..bb486d36b14 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -130,6 +130,7 @@ struct VirtMachineClass {
     /* Machines < 6.2 have no support for describing cpu topology to guest */
     bool no_cpu_topology;
     bool no_tcg_lpa2;
+    bool no_ns_el2_virt_timer_irq;
 };
 
 struct VirtMachineState {
@@ -173,6 +174,7 @@ struct VirtMachineState {
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
+    bool ns_el2_virt_timer_irq;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 48febde1ccd..84141228d59 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -533,8 +533,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 /*
- * ACPI spec, Revision 5.1
- * 5.2.24 Generic Timer Description Table (GTDT)
+ * ACPI spec, Revision 6.5
+ * 5.2.25 Generic Timer Description Table (GTDT)
  */
 static void
 build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -548,7 +548,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     uint32_t irqflags = vmc->claim_edge_triggered_timers ?
         1 : /* Interrupt is Edge triggered */
         0;  /* Interrupt is Level triggered  */
-    AcpiTable table = { .sig = "GTDT", .rev = 2, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
@@ -584,7 +584,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 4);
     /* Platform Timer Offset */
     build_append_int_noprefix(table_data, 0, 4);
-
+    if (vms->ns_el2_virt_timer_irq) {
+        /* Virtual EL2 Timer GSIV */
+        build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
+        /* Virtual EL2 Timer Flags */
+        build_append_int_noprefix(table_data, irqflags, 4);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+        build_append_int_noprefix(table_data, 0, 4);
+    }
     acpi_table_end(linker, &table);
 }
 
@@ -771,10 +779,10 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
                             VirtMachineState *vms, unsigned dsdt_tbl_offset)
 {
-    /* ACPI v6.0 */
+    /* ACPI v6.3 */
     AcpiFadtData fadt = {
         .rev = 6,
-        .minor_ver = 0,
+        .minor_ver = 3,
         .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
     };
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 368c2a415ad..0af19436973 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -221,6 +221,20 @@ static void create_randomness(MachineState *ms, const char *node)
     qemu_fdt_setprop(ms->fdt, node, "rng-seed", seed.rng, sizeof(seed.rng));
 }
 
+/*
+ * The CPU object always exposes the NS EL2 virt timer IRQ line,
+ * but we don't want to advertise it to the guest in the dtb or ACPI
+ * table unless it's really going to do something.
+ */
+static bool ns_el2_virt_timer_present(void)
+{
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, ARM_FEATURE_AARCH64) &&
+        arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -338,15 +352,29 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                                 "arm,armv7-timer");
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags);
+    if (vms->ns_el2_virt_timer_irq) {
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_VIRT_IRQ), irqflags);
+    } else {
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags);
+    }
 }
 
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
@@ -789,6 +817,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
@@ -2222,6 +2251,11 @@ static void machvirt_init(MachineState *machine)
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
+
+    /* Now we've created the CPUs we can see if they have the hypvirt timer */
+    vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
+        !vmc->no_ns_el2_virt_timer_irq;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3179,8 +3213,16 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
 
 static void virt_machine_8_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_9_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
+    /*
+     * Don't expose NS_EL2_VIRT timer IRQ in DTB on ACPI on 8.2 and
+     * earlier machines. (Exposing it tickles a bug in older EDK2
+     * guest BIOS binaries.)
+     */
+    vmc->no_ns_el2_virt_timer_irq = true;
 }
 DEFINE_VIRT_MACHINE(8, 2)
 
-- 
2.34.1



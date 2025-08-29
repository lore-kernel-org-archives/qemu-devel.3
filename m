Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995D5CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNH8-0000C6-Tg; Sat, 30 Aug 2025 11:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhx-0000vX-EF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhv-00085K-6H
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz5DpvdRKLST7sQ0QcbECvgSvi9esd0ExsRrMcsUA1I=;
 b=KmypRskxwXfCs/Nl9B6IPh2jWtDBdP5YatzfoVyOTRHJoKa6jGjLj5nl38jOaOTvcgh9jL
 zJtXUOmdTlxxD95BeLSwf6fNknZvBBo+R+/+83nfNxZPg9TLF4cHIcKjgl05AohfOv9szq
 rL11dLImWaSdekfojL6spIfomBZBKGc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-VVgFSRBpPqGNVJxMyuR9-A-1; Fri, 29 Aug 2025 08:59:53 -0400
X-MC-Unique: VVgFSRBpPqGNVJxMyuR9-A-1
X-Mimecast-MFC-AGG-ID: VVgFSRBpPqGNVJxMyuR9-A_1756472392
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7d485153so11511285e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472391; x=1757077191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pz5DpvdRKLST7sQ0QcbECvgSvi9esd0ExsRrMcsUA1I=;
 b=aVPbry115asNmCiS2PfCerNO+TlMN2Ml4I0wnBWJevlNHoEp8lhABaWIuNjsCjRtUU
 JLHRul6qicK8IlxBcW5+ZLg0VUoPP4KepKT9XhwgGvhusklTc4D3aTTKNjWTWMP848Ej
 OJFOy4Nnz/5hvB5344aKM06pvVdw3M4EspCPbqIu+TLxEmaRauQ3rgkJn+8/CbB4Y/sF
 ezL9BY1AGGV50JRFgOyvQ67hu6wl//SOoEEB0FdXAec+lt1A7hDiq2oBl15kWfwiFhKW
 7ihbRrti2Z+RPw3/rtkSqplZUchCbDVZT1H7o9ymQNlXBYsozSOxXpqjSKFNN8OPfPLm
 TPvA==
X-Gm-Message-State: AOJu0Yx0d9tAM8KF2jLNT8Fib6YHCPmP95j7Qgncdn/cJQ+8DrXEJfZa
 HF3nSc+3RPV2fdHXEttGYnMrWLCgMlf3DLEAjZNiAWQ5Syher8VzOeVcapewQGiv9TDSG3n9T6m
 sdsLKZknxN4IW75BlEHaReSaxnUVirfkAiqQl9gtnTyd3K2ICRvYlGxFTrY3FAZKSe4XabQM6sc
 lmxMSYU73fciJotQbvgNjD6IqLOgiNiVkNVhu2L++I
X-Gm-Gg: ASbGncu1t1R51R6SmfU5phujZbskFZF4T6ePIesCXy7M/iYM6387JlgYiiNzrXsn9G9
 G8m3BcyRqx4KmoazRjnzPI2Mb4NXcMxvZywvszgGZjuu/YLvfdPQrfl3+LCu/gAiZ9j/NhwUFug
 PLvUFDi24oKCQgwVbr70kPgz6xtHHRPG1Rpsl1h27Y/8cRMZmLS/S002rxrl/ayZ0oNQ6mufLJV
 EvzsDlTzFFUpe4p8m8q3yZRrZFx8O7Tc1o02Mgy53PkfV2BgbjdPs9Fd1RLLIG5ZPsxJZcYhlrn
 WKCgyT13vE7+HTajHlCFYNiChOnAr6YbFWag2V/vJtJHcENgE240v/Ap92AS9R+HMboRn96xgtR
 L5vKu+SKz0dAoXcd+Qz/aIVUpfDbvc3AM0gPQ7cFpvIA=
X-Received: by 2002:a05:600c:1c07:b0:45b:7ffa:1bf8 with SMTP id
 5b1f17b1804b1-45b7ffa1d60mr19678915e9.23.1756472390766; 
 Fri, 29 Aug 2025 05:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2CfBWucnXYgR8I0GkNh4N43+6VnxgOlF1xi850U2/mOA6jE1ClniOyLHnR36Yn2JbkB17BA==
X-Received: by 2002:a05:600c:1c07:b0:45b:7ffa:1bf8 with SMTP id
 5b1f17b1804b1-45b7ffa1d60mr19678665e9.23.1756472390143; 
 Fri, 29 Aug 2025 05:59:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f30fe02sm115144465e9.18.2025.08.29.05.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/28] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Fri, 29 Aug 2025 14:59:12 +0200
Message-ID: <20250829125935.1526984-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250828111057.468712-6-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 275 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8e302dc013b..60bf18c680b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,6 +435,23 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
@@ -466,7 +483,263 @@ static void pc_init_isa(MachineState *machine)
         exit(1);
     }
 
-    pc_init1(machine, NULL);
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        uint32_t irq;
+
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                       &error_fatal);
+        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 #endif
 
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE3BCD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6M-0002C7-LX; Thu, 28 Mar 2024 11:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6L-00028N-6a
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:37 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6J-0002D6-7B
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56c3260a714so1462276a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641333; x=1712246133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSkLCR/UlhKFiQpvqkRVhG8wkTGDHk2a+aqlC/uZCjk=;
 b=YqXg9vfed/c7VsRnGQ29acL2L9LVHngDw91mev4dHUdKjvmWfvaksjXQwGHqXzQRje
 3xx1PFbmJuj4cZftN4eE3D2+n5QgO1XNMkMyWZkSSsuo349/7Onq+HqqCWj0Dmy29GSy
 NzTCKR0wpWDQX3XNgfYTOBUZ9wAu5Ah2yWPbmHnkk2Luxh7vR+7+VIb164tOgA5qcbxF
 uTtfii3z7z/e/PcxqG8PFdCD0gj1oAX2G15FlPdYUPkaBYwVhkTauGx547CfsyVwADxJ
 LAsq27K1R61XpDKGPJ0pc1v324e916DKZB0BKRNBcxIaZcfV24ZcORmChDQN5NtVoU3b
 MAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641333; x=1712246133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSkLCR/UlhKFiQpvqkRVhG8wkTGDHk2a+aqlC/uZCjk=;
 b=NC35pZtSizBPUo1V4SM9JB1cL++lqjHYO7UhKpmG0eaGYx8ytyI0I84/1UOAFamYpP
 yOQcPU2xtSyMYY4oKku35/b+2qOBahiBgz07qqJ/rbzG7gLGh49Fw2Bie+7qQj+fhonw
 bn/pn0ddMTpNMp3Y/PHdKUS7gBk23ntFdAq8qnb/YGNhmxoY8VISsYnwZ4hwu/jrjFcn
 f+FsqRkKUt0BfvHYdZb8TjdtXR4stZwdgMXYRIgRNnsaDmeO+0yBwwYoM+AmRAWnxHRg
 HRHVmC/tsMHvNL+vG6vrxiX2nb6fn6YZ1Vg1kec21uMe/JqM/YwSjfOR0ijIEgGf/QXr
 fU7Q==
X-Gm-Message-State: AOJu0YzvAsFpw3yWNt4Gsfy9E0hlqXzgObGITRlQaau98lYsuLF7A6eV
 xZI1TvLxjyqO+D+m95Q0xRqjqg6OqfJGHo/BgJ8jDA54o0/26zJ7OmLMew+wTMak13uoC7l3/d8
 6
X-Google-Smtp-Source: AGHT+IF/0mLdvRWo13tehO3NuCCV1getL+XsL801v0qQfgvFLMYq6AAaEiOV3hBAVWA55LBbGiFx8w==
X-Received: by 2002:a17:906:ef05:b0:a4e:207e:b71 with SMTP id
 f5-20020a170906ef0500b00a4e207e0b71mr2083747ejs.6.1711641333084; 
 Thu, 28 Mar 2024 08:55:33 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 bj9-20020a17090736c900b00a4e28cacbddsm393913ejc.57.2024.03.28.08.55.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 08/29] hw/i386/pc: Move CXLState to
 PcPciMachineState
Date: Thu, 28 Mar 2024 16:54:16 +0100
Message-ID: <20240328155439.58719-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

CXL depends on PCIe, which isn't available on non-PCI
machines such the ISA-only PC one.
Move CXLState to PcPciMachineState, and move the CXL
specific calls to pc_pci_machine_initfn() and
pc_pci_machine_done().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ++-
 hw/i386/acpi-build.c | 14 +++++++++++---
 hw/i386/pc.c         | 39 ++++++++++++++++++++-------------------
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 24c8e17e62..a97493d29d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -54,13 +54,14 @@ typedef struct PCMachineState {
     hwaddr memhp_io_base;
 
     SGXEPCState sgx_epc;
-    CXLState cxl_devices_state;
 } PCMachineState;
 
 typedef struct PcPciMachineState {
     PCMachineState parent_obj;
 
     Notifier machine_done;
+
+    CXLState cxl_devices_state;
 } PcPciMachineState;
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b9890886f6..6e8e32e5d2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1554,6 +1554,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_init(&crs_range_set);
     bus = PC_MACHINE(machine)->pcibus;
     if (bus) {
+        PcPciMachineState *ppms;
+
+        assert(pc_machine_is_pci_enabled(pcms));
+        ppms = PC_PCI_MACHINE(machine);
+
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
@@ -1607,7 +1612,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
             /* Handle the ranges for the PXB expanders */
             if (pci_bus_is_cxl(bus)) {
-                MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
+                MemoryRegion *mr = &ppms->cxl_devices_state.host_mr;
                 uint64_t base = mr->addr;
 
                 cxl_present = true;
@@ -2513,6 +2518,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     Object *vmgenid_dev;
     char *oem_id;
     char *oem_table_id;
+    bool pci_enabled = pc_machine_is_pci_enabled(pcms);
+    PcPciMachineState *ppms = pci_enabled ? PC_PCI_MACHINE(pcms) : NULL;
 
     acpi_get_pm_info(machine, &pm);
     acpi_get_misc_info(&misc);
@@ -2640,9 +2647,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           machine->nvdimms_state, machine->ram_slots,
                           x86ms->oem_id, x86ms->oem_table_id);
     }
-    if (pcms->cxl_devices_state.is_enabled) {
+    if (ppms && ppms->cxl_devices_state.is_enabled) {
         cxl_build_cedt(table_offsets, tables_blob, tables->linker,
-                       x86ms->oem_id, x86ms->oem_table_id, &pcms->cxl_devices_state);
+                       x86ms->oem_id, x86ms->oem_table_id,
+                       &ppms->cxl_devices_state);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9226f7115..6d87d1d4c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -598,13 +598,6 @@ void pc_machine_done(Notifier *notifier, void *data)
                                         PCMachineState, machine_done);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    cxl_hook_up_pxb_registers(pcms->pcibus, &pcms->cxl_devices_state,
-                              &error_fatal);
-
-    if (pcms->cxl_devices_state.is_enabled) {
-        cxl_fmws_link_targets(&pcms->cxl_devices_state, &error_fatal);
-    }
-
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
@@ -626,6 +619,13 @@ static void pc_pci_machine_done(Notifier *notifier, void *data)
     PCMachineState *pcms = PC_MACHINE(ppms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
+    cxl_hook_up_pxb_registers(pcms->pcibus, &ppms->cxl_devices_state,
+                              &error_fatal);
+
+    if (ppms->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&ppms->cxl_devices_state, &error_fatal);
+    }
+
     fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
 }
 
@@ -719,13 +719,14 @@ static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
 
 static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
 {
+    PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);
     uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
 
-    if (pcms->cxl_devices_state.fixed_windows) {
+    if (ppms->cxl_devices_state.fixed_windows) {
         GList *it;
 
         start = ROUND_UP(start, 256 * MiB);
-        for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
+        for (it = ppms->cxl_devices_state.fixed_windows; it; it = it->next) {
             CXLFixedWindow *fw = it->data;
             start += fw->size;
         }
@@ -823,6 +824,7 @@ void pc_memory_init(PCMachineState *pcms,
     hwaddr cxl_base, cxl_resv_end = 0;
     X86CPU *cpu = X86_CPU(first_cpu);
     bool pci_enabled = pc_machine_is_pci_enabled(pcms);
+    PcPciMachineState *ppms = pci_enabled ? PC_PCI_MACHINE(pcms) : NULL;
 
     assert(machine->ram_size == x86ms->below_4g_mem_size +
                                 x86ms->above_4g_mem_size);
@@ -926,20 +928,20 @@ void pc_memory_init(PCMachineState *pcms,
         machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
-    if (pcms->cxl_devices_state.is_enabled) {
-        MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
+    if (ppms && ppms->cxl_devices_state.is_enabled) {
+        MemoryRegion *mr = &ppms->cxl_devices_state.host_mr;
         hwaddr cxl_size = MiB;
 
         cxl_base = pc_get_cxl_range_start(pcms);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_resv_end = cxl_base + cxl_size;
-        if (pcms->cxl_devices_state.fixed_windows) {
+        if (ppms->cxl_devices_state.fixed_windows) {
             hwaddr cxl_fmw_base;
             GList *it;
 
             cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
+            for (it = ppms->cxl_devices_state.fixed_windows; it; it = it->next) {
                 CXLFixedWindow *fw = it->data;
 
                 fw->base = cxl_fmw_base;
@@ -979,7 +981,7 @@ void pc_memory_init(PCMachineState *pcms,
             res_mem_end += memory_region_size(&machine->device_memory->mr);
         }
 
-        if (pcms->cxl_devices_state.is_enabled) {
+        if (ppms->cxl_devices_state.is_enabled) {
             res_mem_end = cxl_resv_end;
         }
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
@@ -1010,11 +1012,12 @@ uint64_t pc_pci_hole64_start(void)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);
     MachineState *ms = MACHINE(pcms);
     uint64_t hole64_start = 0;
     ram_addr_t size = 0;
 
-    if (pcms->cxl_devices_state.is_enabled) {
+    if (ppms->cxl_devices_state.is_enabled) {
         hole64_start = pc_get_cxl_range_end(pcms);
     } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &hole64_start, &size);
@@ -1651,7 +1654,6 @@ static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    bool pci_enabled = pc_machine_is_pci_enabled(pcms);
 
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
@@ -1678,9 +1680,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
-    if (pci_enabled) {
-        cxl_machine_init(obj, &pcms->cxl_devices_state);
-    }
 
     pcms->machine_done.notify = pc_machine_done;
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
@@ -1690,6 +1689,8 @@ static void pc_pci_machine_initfn(Object *obj)
 {
     PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
 
+    cxl_machine_init(obj, &ppms->cxl_devices_state);
+
     ppms->machine_done.notify = pc_pci_machine_done;
     qemu_add_machine_init_done_notifier(&ppms->machine_done);
 }
-- 
2.41.0



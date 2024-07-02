Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767A7C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyN-0000xU-Lh; Tue, 02 Jul 2024 16:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyL-0000oU-87
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyF-0001FS-S5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H3osRPyR8JjW6MeyHBrRsmkcAIK1uR3HKs135scl6wM=;
 b=iSJ/zkT5OGuadnO2HhH8N1VlAMl5sUkKXHVuBju2QHSgoxuaKwCK08UaFm15glNkgvFwwT
 srT+liqUX1bcPuN9S8Xk/BKOWwFWk52NsnTQ92167HStlJp1DnkHaKXmvOTI8+gJZduc5R
 aTjUO9rCicxvfqgdenvvcm+j+uaaGZ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Bd83bQuHPVahxbCXr4BRgQ-1; Tue, 02 Jul 2024 16:19:21 -0400
X-MC-Unique: Bd83bQuHPVahxbCXr4BRgQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36785e6c1e6so565355f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951559; x=1720556359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3osRPyR8JjW6MeyHBrRsmkcAIK1uR3HKs135scl6wM=;
 b=qftnUcsOFbTOeA1q3g2XjX43C1gvqEXtyHLoayZzkcut3D0EcjbUDbecqwiubdyFBA
 mhCsdM+Sq05mLJQ+xxjy4jOAc1RT5hml6nyjDrikIC+FdfRxi9gSais+/zLwxjVDzYFK
 ebczWk5nWxB87fjtB+Lzyy2drQ/CffhNiETF8nfBr+ZYaEEfAs0+nIDBi8QbTp1VxbhK
 ivBO+g/FDCiKrNvcEWPobOWpqsDfq+j+a50ZQXgtrD2rhnuUZhRi9J+V2s4oldLaDl2Y
 KtaDdgjED8skpIPq5KDr2AcHMH1dfKGmXo4dIH9MXiMKxxakg3iZ3lYda5y0QXNifuyA
 o/kw==
X-Gm-Message-State: AOJu0YyA3B3sKcKihX2Zx4mBBbNAl3/2UYP5GsmoUmdWxDAylxRFiIlb
 qbaXKj1Dbo0MKUVGp7BdpE6tdYkvxBNtEjwa5csHgfA9L0Of5MXYUxuJza4ieil/EXUwQS2wCTX
 72xY4DUeXiQth8NTq/G9worfH/o5G8gHo6hRHPoKT3m+X2jOuX1MyN96sBtQCeG9ze9EVu/DnUh
 JQb82FdDhTFBzSygKhCB97Z4h4yJ6y0g==
X-Received: by 2002:adf:e682:0:b0:362:6908:e2e3 with SMTP id
 ffacd0b85a97d-3677571c4e8mr6218275f8f.45.1719951559678; 
 Tue, 02 Jul 2024 13:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGezRFkcB9rwxFrW2dCnoNbXe1Iero1jBEBp3U7p7UwUudeD8CNDuuNfjV9Z5ZQg0Ew3jaPuA==
X-Received: by 2002:adf:e682:0:b0:362:6908:e2e3 with SMTP id
 ffacd0b85a97d-3677571c4e8mr6218245f8f.45.1719951559056; 
 Tue, 02 Jul 2024 13:19:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d00sm14169751f8f.99.2024.07.02.13.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:18 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paul Durrant <paul@xen.org>,
 kvm@vger.kernel.org
Subject: [PULL v2 61/88] hw/i386/fw_cfg: Add etc/e820 to fw_cfg late
Message-ID: <63592d296f1a6b1aea223d5a1bb2f20f2f0373e2.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw2@infradead.org>

In e820_add_entry() the e820_table is reallocated with g_renew() to make
space for a new entry. However, fw_cfg_arch_create() just uses the
existing e820_table pointer. This leads to a use-after-free if anything
adds a new entry after fw_cfg is set up.

Shift the addition of the etc/e820 file to the machine done notifier, via
a new fw_cfg_add_e820() function.

Also make e820_table private and use an e820_get_table() accessor function
for it, which sets a flag that will trigger an assert() for any *later*
attempts to add to the table.

Make e820_add_entry() return void, as most callers don't check for error
anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <a2708734f004b224f33d3b4824e9a5a262431568.camel@infradead.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/e820_memory_layout.h |  8 ++------
 hw/i386/fw_cfg.h             |  1 +
 hw/i386/e820_memory_layout.c | 17 ++++++++++++-----
 hw/i386/fw_cfg.c             | 18 +++++++++++++-----
 hw/i386/microvm.c            |  4 ++--
 hw/i386/pc.c                 |  1 +
 target/i386/kvm/kvm.c        |  6 +-----
 target/i386/kvm/xen-emu.c    |  7 +------
 8 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index 7c239aa033..b50acfa201 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -22,13 +22,9 @@ struct e820_entry {
     uint32_t type;
 } QEMU_PACKED __attribute((__aligned__(4)));
 
-extern struct e820_entry *e820_table;
-
-int e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
-int e820_get_num_entries(void);
+void e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
 bool e820_get_entry(int index, uint32_t type,
                     uint64_t *address, uint64_t *length);
-
-
+int e820_get_table(struct e820_entry **table);
 
 #endif
diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 92e310f5fd..e560fd7be8 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -27,5 +27,6 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
+void fw_cfg_add_e820(FWCfgState *fw_cfg);
 
 #endif
diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
index 06970ac44a..3e848fb69c 100644
--- a/hw/i386/e820_memory_layout.c
+++ b/hw/i386/e820_memory_layout.c
@@ -11,22 +11,29 @@
 #include "e820_memory_layout.h"
 
 static size_t e820_entries;
-struct e820_entry *e820_table;
+static struct e820_entry *e820_table;
+static gboolean e820_done;
 
-int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
+void e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
+    assert(!e820_done);
+
     /* new "etc/e820" file -- include ram and reserved entries */
     e820_table = g_renew(struct e820_entry, e820_table, e820_entries + 1);
     e820_table[e820_entries].address = cpu_to_le64(address);
     e820_table[e820_entries].length = cpu_to_le64(length);
     e820_table[e820_entries].type = cpu_to_le32(type);
     e820_entries++;
-
-    return e820_entries;
 }
 
-int e820_get_num_entries(void)
+int e820_get_table(struct e820_entry **table)
 {
+    e820_done = true;
+
+    if (table) {
+        *table = e820_table;
+    }
+
     return e820_entries;
 }
 
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 7c43c325ef..0e4494627c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -48,6 +48,15 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     return NULL;
 }
 
+/* Add etc/e820 late, once all regions should be present */
+void fw_cfg_add_e820(FWCfgState *fw_cfg)
+{
+    struct e820_entry *table;
+    int nr_e820 = e820_get_table(&table);
+
+    fw_cfg_add_file(fw_cfg, "etc/e820", table, nr_e820 * sizeof(*table));
+}
+
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
@@ -60,6 +69,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
+    int nr_e820;
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
@@ -78,8 +88,9 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     }
 
     /* build the array of physical mem area from e820 table */
-    mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
-    for (i = 0, array_count = 0; i < e820_get_num_entries(); i++) {
+    nr_e820 = e820_get_table(NULL);
+    mem_array = g_malloc0(sizeof(*mem_array) * nr_e820);
+    for (i = 0, array_count = 0; i < nr_e820; i++) {
         uint64_t addr, len;
 
         if (e820_get_entry(i, E820_RAM, &addr, &len)) {
@@ -138,9 +149,6 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
-    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
-                    sizeof(struct e820_entry) * e820_get_num_entries());
-
     fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
     /* allocate memory for the NUMA channel: one (64bit) word for the number
      * of nodes, one word for each VCPU->node and one word for each node to
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index fec63cacfa..40edcee7af 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -324,8 +324,6 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
-    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
-                    sizeof(struct e820_entry) * e820_get_num_entries());
 
     rom_set_fw(fw_cfg);
 
@@ -586,9 +584,11 @@ static void microvm_machine_done(Notifier *notifier, void *data)
 {
     MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
                                             machine_done);
+    X86MachineState *x86ms = X86_MACHINE(mms);
 
     acpi_setup_microvm(mms);
     dt_setup_microvm(mms);
+    fw_cfg_add_e820(x86ms->fw_cfg);
 }
 
 static void microvm_powerdown_req(Notifier *notifier, void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77415064c6..d2c29fbfcb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -625,6 +625,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     acpi_setup();
     if (x86ms->fw_cfg) {
         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
+        fw_cfg_add_e820(x86ms->fw_cfg);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index dd8b0f3313..bf182570fe 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2706,11 +2706,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    ret = e820_add_entry(identity_base, 0x4000, E820_RESERVED);
-    if (ret < 0) {
-        fprintf(stderr, "e820_add_entry() table is full\n");
-        return ret;
-    }
+    e820_add_entry(identity_base, 0x4000, E820_RESERVED);
 
     shadow_mem = object_property_get_int(OBJECT(s), "kvm-shadow-mem", &error_abort);
     if (shadow_mem != -1) {
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index fc2c2321ac..2f89dc628e 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -176,12 +176,7 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     s->xen_caps = xen_caps;
 
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    ret = e820_add_entry(XEN_SPECIAL_AREA_ADDR, XEN_SPECIAL_AREA_SIZE,
-                         E820_RESERVED);
-    if (ret < 0) {
-        fprintf(stderr, "e820_add_entry() table is full\n");
-        return ret;
-    }
+    e820_add_entry(XEN_SPECIAL_AREA_ADDR, XEN_SPECIAL_AREA_SIZE, E820_RESERVED);
 
     /* The pages couldn't be overlaid until KVM was initialized */
     xen_primary_console_reset();
-- 
MST



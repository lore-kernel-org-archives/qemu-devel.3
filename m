Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6393C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeDF-0004HR-P6; Tue, 02 Jul 2024 10:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeD3-0003PL-Df
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeD1-0000IE-7U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SNwFHLByhZ9Qs1kayFDYHhFkt3XkniLJLO/2kGyAGIU=;
 b=NymRrvByrFLdtxq0SGmrbJsswsL8OPIk1SrOzPz819bIgPHuY4QM09xAQzDFvErXdPP80X
 OhpI/h7uP3cA4SoWo55BipKnz6xKqInoF8qszZKf7+qhqIUL4NO/TYDpFbgOu/FnnqRUIB
 aeQVXUuNpaP7U6cmzazWDWGmfYuuqS0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-5IewY_O7O5eLKeft1x8Xyw-1; Tue, 02 Jul 2024 10:10:12 -0400
X-MC-Unique: 5IewY_O7O5eLKeft1x8Xyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42566e8a9efso39095095e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929410; x=1720534210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNwFHLByhZ9Qs1kayFDYHhFkt3XkniLJLO/2kGyAGIU=;
 b=sY/vrbxuBZEHMKEKEUorE4t+1oDYMSOAVJ4hhoNqvfzzwA9XEErEHd98mVvowQXA7S
 gobcCBNkX9PueJtET1gQKhKK3gpQNYqMia5gSKupys/2X7tpmjn65a7otPSK8x8kxTaD
 EZkE7BIvA5/1SBTjvFBETzGBT3AMm5GvJ9IjjrtK6wbdVlurZ9OqadSlDZ54t+dYxvzU
 VsUsHyEqPStWjqNFZjC7HqcsBNYEJ/YR/fR/RWd0C1SM1TTf3QjRRjVIzdVUFbI16DXu
 SV9FVMh2ByDM+rOPDblDLySZevsAiDCFib0Q5lu7q84uOQF3idOf3fwxAQTLB/1v6GOj
 tz4A==
X-Gm-Message-State: AOJu0YwLNo2AqbokmrcLsxQHezfhMLnaDCPgJwkjhJ9sNYT8pwBNFzEo
 yaIx2Pdvv+IXS8Au2Q6pfjM5UegGz2nzJpERkAEpLxosTe26iVGt0sfZ+llZcxdTz/Z0A499Ovk
 wzfC+H+2+Vgh2qE10NjSs1MNfFZxrFZ5Js29eEx9W1qGblNuGtdYsnD+SSBoUk0MNOV3sAyYV4z
 DgM2Y00LWh0a3Ry4fqw5kpwffGZrbhnA==
X-Received: by 2002:a05:600c:3b8b:b0:425:8bf0:7659 with SMTP id
 5b1f17b1804b1-4258bf0785amr14106005e9.9.1719929410581; 
 Tue, 02 Jul 2024 07:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2nHoCqso+sjxxE5A3Y3qgpPSKkOlJEY00W5Xrb62L9JbgqvkjIDIE4xy37xJnoLisJB7HHA==
X-Received: by 2002:a05:600c:3b8b:b0:425:8bf0:7659 with SMTP id
 5b1f17b1804b1-4258bf0785amr14105585e9.9.1719929409862; 
 Tue, 02 Jul 2024 07:10:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257cdf4982sm120640705e9.47.2024.07.02.07.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:06 -0400
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
Subject: [PULL 61/91] hw/i386/fw_cfg: Add etc/e820 to fw_cfg late
Message-ID: <36574004704d6c4704aba27f3b3f0f37d6d00d00.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
 hw/i386/e820_memory_layout.c | 16 +++++++++++-----
 hw/i386/fw_cfg.c             | 18 +++++++++++++-----
 hw/i386/microvm.c            |  4 ++--
 hw/i386/pc.c                 |  1 +
 target/i386/kvm/kvm.c        |  6 +-----
 target/i386/kvm/xen-emu.c    |  7 +------
 8 files changed, 32 insertions(+), 29 deletions(-)

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
index 06970ac44a..0d549accbf 100644
--- a/hw/i386/e820_memory_layout.c
+++ b/hw/i386/e820_memory_layout.c
@@ -11,22 +11,28 @@
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
+    if (table)
+        *table = e820_table;
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



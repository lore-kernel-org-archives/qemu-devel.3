Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187E9C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2Z-0002uz-Eo; Sun, 06 Apr 2025 03:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2E-0002sN-WF
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2D-0001zK-1W
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJ+3CUSclvxCiVeh/C6Z4WSuIxHYnFjeMxlkCKfRggY=;
 b=I6cWHutTF153ul2clTbu2HgUb9eFGpvUEZSDLFxXG6Rc539yror4qZ7i2EMNMnJeUbcAPr
 fvrN5SGrOQQZiWE4rFwdaF9skht/lur0MbOhbhZ7ZBETN8vjePJtZsoo3efJHsoJnAFbMe
 kjfqbuBfZX5fHW0WnPjwShcwkCzR6Is=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-3gODA7ttM5urSZf5a15YKA-1; Sun, 06 Apr 2025 03:03:10 -0400
X-MC-Unique: 3gODA7ttM5urSZf5a15YKA-1
X-Mimecast-MFC-AGG-ID: 3gODA7ttM5urSZf5a15YKA_1743922989
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391315098b2so1362031f8f.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922988; x=1744527788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJ+3CUSclvxCiVeh/C6Z4WSuIxHYnFjeMxlkCKfRggY=;
 b=vhirvyJimuBB/E2cUy4KVMlJ85yUfG2qSj85+pNQjTPMJdr4J34EN4hyF42Z0pQzy+
 pwa5aE9M+AJi0Sh8gjz3TIv1+pr+XWdzafpuV2+cvkw1/NLvOXDNlkr+c4NBKBWF76gN
 VAZmIqIYy9m4WlqYweEGB/UO5GLXyLp4hFiRxk2vSTcaBeNzFe1XGH1mvxhTpTIulXOl
 kwriK3SOJaKrsLFWRBIECGKn19fPM+ftHTM/LWrQ1OovfdrzA9HyrNUCuZ7tcnG7J+cr
 Hjl4XiZUh49vEqpgBRxhgcl8fcw5vMNBmsrgm4JCS8SlURUTuXl3MnFEFWmRfQLifZnO
 u68A==
X-Gm-Message-State: AOJu0YzQ5fxBhQbMZEvRTVs5uRXwX4wU9T3fMOLON/j6EnvA1SBwPbNw
 41Tc1PpKT72QXZx/3oGqQL3VWBFqZHxoHnf1iaWwZn5wDk0zg+L/Wvfg1ZCchUAkqV757+qHWOJ
 S7JIP7W/So3XYW6yu1/FoDMBImn3j5Utzz/7Q7P+0F/6Y/eiO+WFw6VNriCd5ghGHdF65P4seUu
 CnyFD0x+g18g6/yFOBmi0B/5prL8qsbWaknxN1
X-Gm-Gg: ASbGncv+2pehvFh6QbKJ37FpnyO+sQg2CNnB+ergmaZsuHcYbQDD7c2UhFcDkkpQz66
 ZlNti6aW2aCrhpq66iVFMUTQWkPVTzK9OIQbhwkbO10LA1H5Kapi0eSXmVRMKUtB7l6MGWIMoMp
 c/FJbE2e5AAClf4Ygc839gEEU0+PkS9c9f57KtxP/hpdUrXA6pEtgacRp1IFpAMG4nUNMVyRiJ9
 kT99Zdm//1DtwkwEwiRnv1mwKLAHR45cOqQR3zvWIZ2Sw2s5tfBGnJqAcQMaxn7aOE6XXgkKuF3
 ZGDDXm8wSEonVIlZJQ==
X-Received: by 2002:a05:6000:188f:b0:39c:12ce:67e with SMTP id
 ffacd0b85a97d-39cba934e24mr6781562f8f.41.1743922988510; 
 Sun, 06 Apr 2025 00:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkQdslpZrml3g9ZfvlPaB/rod8nudcvGZ3L293qK1xQqW4uT1sO8M5QGl+g48vndhrDT+82Q==
X-Received: by 2002:a05:6000:188f:b0:39c:12ce:67e with SMTP id
 ffacd0b85a97d-39cba934e24mr6781533f8f.41.1743922988014; 
 Sun, 06 Apr 2025 00:03:08 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d9cfsm8651683f8f.78.2025.04.06.00.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 04/27] target/riscv: update max_satp_mode based on QOM
 properties
Date: Sun,  6 Apr 2025 09:02:31 +0200
Message-ID: <20250406070254.274797-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Almost all users of cpu->cfg.satp_mode care about the "max" value
satp_mode_max_from_map(cpu->cfg.satp_mode.map).  Convert the QOM
properties back into it.  For TCG, deduce the bitmap of supported modes
from valid_vm[].

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  1 -
 hw/riscv/virt-acpi-build.c | 14 +++++---------
 hw/riscv/virt.c            |  5 ++---
 target/riscv/cpu.c         | 27 ++++++++++-----------------
 target/riscv/csr.c         |  9 +++++++--
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03dec..e9c46120215 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -937,7 +937,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask);
 
-uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 /* Implemented in th_csr.c */
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 2b374ebacbf..1a92a84207d 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -261,7 +261,6 @@ static void build_rhct(GArray *table_data,
     uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
     RISCVCPU *cpu = &s->soc[0].harts[0];
     uint32_t mmu_offset = 0;
-    uint8_t satp_mode_max;
     bool rv32 = riscv_cpu_is_32bit(cpu);
     g_autofree char *isa = NULL;
 
@@ -282,8 +281,7 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
-    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
-        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
+    if (!rv32 && cpu->cfg.max_satp_mode >= VM_1_10_SV39) {
         num_rhct_nodes++;
     }
 
@@ -343,20 +341,18 @@ static void build_rhct(GArray *table_data,
     }
 
     /* MMU node structure */
-    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
-        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
-        satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    if (!rv32 && cpu->cfg.max_satp_mode >= VM_1_10_SV39) {
         mmu_offset = table_data->len - table.table_offset;
         build_append_int_noprefix(table_data, 2, 2);    /* Type */
         build_append_int_noprefix(table_data, 8, 2);    /* Length */
         build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
         build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
         /* MMU Type */
-        if (satp_mode_max == VM_1_10_SV57) {
+        if (cpu->cfg.max_satp_mode == VM_1_10_SV57) {
             build_append_int_noprefix(table_data, 2, 1);    /* Sv57 */
-        } else if (satp_mode_max == VM_1_10_SV48) {
+        } else if (cpu->cfg.max_satp_mode == VM_1_10_SV48) {
             build_append_int_noprefix(table_data, 1, 1);    /* Sv48 */
-        } else if (satp_mode_max == VM_1_10_SV39) {
+        } else if (cpu->cfg.max_satp_mode == VM_1_10_SV39) {
             build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
         } else {
             g_assert_not_reached();
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e517002fdfc..e643a635b72 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -237,10 +237,10 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     uint32_t cpu_phandle;
     MachineState *ms = MACHINE(s);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
-    uint8_t satp_mode_max;
 
     for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
         RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
+        int8_t satp_mode_max = cpu_ptr->cfg.max_satp_mode;
         g_autofree char *cpu_name = NULL;
         g_autofree char *core_name = NULL;
         g_autofree char *intc_name = NULL;
@@ -252,8 +252,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             s->soc[socket].hartid_base + cpu);
         qemu_fdt_add_subnode(ms->fdt, cpu_name);
 
-        if (cpu_ptr->cfg.satp_mode.supported != 0) {
-            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
+        if (satp_mode_max != -1) {
             sv_name = g_strdup_printf("riscv,%s",
                                       satp_mode_str(satp_mode_max, is_32_bit));
             qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4dcab156948..edb2509345d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -390,7 +390,7 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
     g_assert_not_reached();
 }
 
-uint8_t satp_mode_max_from_map(uint32_t map)
+static uint8_t satp_mode_max_from_map(uint32_t map)
 {
     /*
      * 'map = 0' will make us return (31 - 32), which C will
@@ -456,15 +456,13 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
     /*
      * Bare CPUs do not default to the max available.
      * Users must set a valid satp_mode in the command
-     * line.
+     * line.  Otherwise, leave the existing max_satp_mode
+     * in place.
      */
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) != NULL) {
         warn_report("No satp mode set. Defaulting to 'bare'");
-        cpu->cfg.satp_mode.map = (1 << VM_1_10_MBARE);
-        return;
+        cpu->cfg.max_satp_mode = VM_1_10_MBARE;
     }
-
-    cpu->cfg.satp_mode.map = cpu->cfg.satp_mode.supported;
 }
 #endif
 
@@ -1183,8 +1181,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     bool rv32 = riscv_cpu_is_32bit(cpu);
     uint8_t satp_mode_map_max;
 
-    /* The CPU wants the OS to decide which satp mode to use */
-    if (cpu->cfg.satp_mode.supported == 0) {
+    if (cpu->cfg.max_satp_mode == -1) {
+        /* The CPU wants the hypervisor to decide which satp mode to allow */
         return;
     }
 
@@ -1203,14 +1201,14 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
                     (cpu->cfg.satp_mode.supported & (1 << i))) {
                     for (int j = i - 1; j >= 0; --j) {
                         if (cpu->cfg.satp_mode.supported & (1 << j)) {
-                            cpu->cfg.satp_mode.map |= (1 << j);
-                            break;
+                            cpu->cfg.max_satp_mode = j;
+                            return;
                         }
                     }
-                    break;
                 }
             }
         }
+        return;
     }
 
     satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
@@ -1240,12 +1238,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    /* Finally expand the map so that all valid modes are set */
-    for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-        if (cpu->cfg.satp_mode.supported & (1 << i)) {
-            cpu->cfg.satp_mode.map |= (1 << i);
-        }
-    }
+    cpu->cfg.max_satp_mode = satp_mode_map_max;
 }
 #endif
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 79481883565..60de716a2a5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1906,8 +1906,13 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 
 static bool validate_vm(CPURISCVState *env, target_ulong vm)
 {
-    uint64_t mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
-    return get_field(mode_supported, (1 << vm));
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    RISCVCPU *cpu = env_archcpu(env);
+    int satp_mode_supported_max = cpu->cfg.max_satp_mode;
+    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
+
+    assert(satp_mode_supported_max >= 0);
+    return vm <= satp_mode_supported_max && valid_vm[vm];
 }
 
 static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
-- 
2.49.0



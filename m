Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D7EC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvS-0006if-6B; Tue, 18 Feb 2025 11:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvM-0006hg-MM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvK-0004PN-FV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+0sPrl063vk2DmTP4eVLcXBhfa46tJHCgqkyXY65LE=;
 b=A+IUb9qP5VEAHhvykL68LAkMt0DdrqQEQYRk6KBlQ/a2HYczruwoNYgZkO5QVz+ry9C0Yg
 tecXhF54/zTWj0kYUWuGK0wmPl2XMLTwS0xz16XRhNi9TelIxLQAHa/jObXOzIrsUR6AY2
 DnVgSzPR79aacyYeDibc+mdauu74o34=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-00BWUuYqNR6HyIj5l5hQDg-1; Tue, 18 Feb 2025 11:58:11 -0500
X-MC-Unique: 00BWUuYqNR6HyIj5l5hQDg-1
X-Mimecast-MFC-AGG-ID: 00BWUuYqNR6HyIj5l5hQDg_1739897890
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4398ed35b10so8141125e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897889; x=1740502689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+0sPrl063vk2DmTP4eVLcXBhfa46tJHCgqkyXY65LE=;
 b=wEdQ3TQMgrj+/cwcJ74xXMmvlrWQo16wECnrARpVzcWkEbfnuHxetst/L2tS8Ehj5q
 7tUotnOi2A4L6w72DX+rth6jqCqcarirUWt2bqXFjcEMWS/lrNvlrwwEC4Fl6UlH8ffP
 +GtrDtktTh0+7lBcq4ELH8w+mMg56mGA/8zwMJ0pC8r3+x36n+aMRRcgos6aKvwUc8YW
 ss4XMslVfTJsdLO8lkR6IRXLr5C8Nzs7ocCxbwjmAw23gNqo2+gT/3FEzVH303J0MVLD
 7oHJ1WELBBMB975mKFZa39Jf+V0pID4e6DJSWzsxpT73r52opwaLkOdQlkUd1m5FCWTX
 huVg==
X-Gm-Message-State: AOJu0YyQQAT3lbIdVm54obyjxAQCkmsg96DGsjxkIbMcxWMVB8ehyGKP
 JKtn1jS8XWe9KSQdCY0CmXh15cKKNIeic63WpEHwHolTlAn0xT03PSySj2P4kaX+VI8CDIsgSpB
 7QDdw8erQbjFyxkLwWg/gWCnnlldXbgTUMxT2OyrlKij0mfOa4plrcf0I4MaSulj9HnLhL5V88c
 JDDgcUlqz/mVI20IgLMpBFx79UmUbT9EO/UheIvJ0=
X-Gm-Gg: ASbGncuz9PeZB0bbxe+FWE7m1GgpecJH+ezse6RDSgm98NA+psQSTVVJK6SxSy3qCEJ
 bmUejEua9OVHbfON3039WiaD/7sjMPrxxAqXJmIMCB3c+QHP5hv7s+paHySVsXk+NN4Zj2ZTt4R
 Dfak23gSw2hkekRCnykNOZRQOBCfLzV3oVP2ErNGONWN2Akhl0LvUvd9H58j0bcu+vyceddbUnT
 9uBvYfE7EVc8R5bKlbe8dh/qSpvZQfyutRk0KR2ixX8oL7LtZtRkJu2uARCsRGpdTcRxWLD7p7j
 87RIF1Ka6JY=
X-Received: by 2002:a05:600c:4f0b:b0:439:8e3e:b0d6 with SMTP id
 5b1f17b1804b1-4398e3eb2efmr51421355e9.13.1739897888669; 
 Tue, 18 Feb 2025 08:58:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgXGXQN32grRWwfR5FX0wjJr44vydj9yMN/QWBH/5w5kor/YA119mBUfriFecWB7xvMigEKQ==
X-Received: by 2002:a05:600c:4f0b:b0:439:8e3e:b0d6 with SMTP id
 5b1f17b1804b1-4398e3eb2efmr51421105e9.13.1739897888167; 
 Tue, 18 Feb 2025 08:58:08 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b84bcsm193878225e9.40.2025.02.18.08.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:58:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 5/7] target/riscv: update max_satp_mode based on QOM properties
Date: Tue, 18 Feb 2025 17:57:55 +0100
Message-ID: <20250218165757.554178-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218165757.554178-1-pbonzini@redhat.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Almost all users of cpu->cfg.satp_mode care only about the "max" value
satp_mode_max_from_map(cpu->cfg.satp_mode.map); convert the QOM
properties back into it.  For TCG, consult valid_vm[] instead of
the bitmap of accepted modes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  1 -
 hw/riscv/virt-acpi-build.c | 14 +++++---------
 hw/riscv/virt.c            |  5 ++---
 target/riscv/cpu.c         | 27 ++++++++++-----------------
 target/riscv/csr.c         |  9 +++++++--
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cbe..f9b223bf8a7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -911,7 +911,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
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
index 241389d72f8..2394fc71df4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -236,10 +236,10 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
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
@@ -251,8 +251,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             s->soc[socket].hartid_base + cpu);
         qemu_fdt_add_subnode(ms->fdt, cpu_name);
 
-        if (cpu_ptr->cfg.satp_mode.supported != 0) {
-            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
+        if (satp_mode_max != -1) {
             sv_name = g_strdup_printf("riscv,%s",
                                       satp_mode_str(satp_mode_max, is_32_bit));
             qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2d06543217a..ce71ee95a52 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -387,7 +387,7 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
     g_assert_not_reached();
 }
 
-uint8_t satp_mode_max_from_map(uint32_t map)
+static uint8_t satp_mode_max_from_map(uint32_t map)
 {
     /*
      * 'map = 0' will make us return (31 - 32), which C will
@@ -453,15 +453,13 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
 
@@ -1180,8 +1178,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     bool rv32 = riscv_cpu_is_32bit(cpu);
     uint8_t satp_mode_map_max;
 
-    /* The CPU wants the OS to decide which satp mode to use */
-    if (cpu->cfg.satp_mode.supported == 0) {
+    if (cpu->cfg.max_satp_mode == -1) {
+        /* The CPU wants the hypervisor to decide which satp mode to allow */
         return;
     }
 
@@ -1200,14 +1198,14 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
@@ -1237,12 +1235,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
index afb7544f078..78db9aeda57 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1862,8 +1862,13 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 
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
2.48.1



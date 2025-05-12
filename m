Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150ECC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPqs-0007aa-UZ; Mon, 12 May 2025 05:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqe-0007ZE-FE
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqc-0000g3-Dw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwRnKsDuJVQtZOZG3zS2nND1/wRkivQFJYNLU5hoF5o=;
 b=D4LaK05Mm4EItL1vTKAaCHNLX/IuOLtUOsaoYphynmevlPx7XayZEKfApkoLQzHlw13fR9
 xgKHRzM2YfF3Bmam7EUijVhzgRl80sOLXBAFNX1eHEzDIIRhNVEP/t2cIwtxjtdc+8u6q2
 np9Gm1E1rMzILRFQS5R0jS6JU7ECo/s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-u-0tskAHOlGTQZZuwDfp1A-1; Mon, 12 May 2025 05:53:20 -0400
X-MC-Unique: u-0tskAHOlGTQZZuwDfp1A-1
X-Mimecast-MFC-AGG-ID: u-0tskAHOlGTQZZuwDfp1A_1747043599
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5fcd19e6305so1564198a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043598; x=1747648398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwRnKsDuJVQtZOZG3zS2nND1/wRkivQFJYNLU5hoF5o=;
 b=b06PK8JNs7IHrOh1ffWzyv3ALeuzHjoZAF2MhZ+ghDV2Dg0FarUgKdXAmj7z+IeotO
 ByN26rUytKcDE6Ch0rcpeT0R0iBkEpmgBGuSI06Y3oZK0h3T6wR1M8j/tz9wSTGLOhFk
 iXJ9YgwjJTfYXGikCE0X4DPADsBS4d+rkXCsLLBoSZKeFt1U6zBJomJBsKfkcnL/EW5w
 +UE7wYefBWd/xLMA+LBz40IuJXeGLzJoOjncm71eC8IAkudzYg3Yp4hZj07IUxbk9gbA
 wPRGoLbwBeL4tP3pzT01GyFo7dwzdbZKZDUOl45TEUFQ8/ZAEWcTakFWGrHW6Tvqsy4c
 rIxA==
X-Gm-Message-State: AOJu0YzR34LHRuTj96RHeHkzNx4eQZDx5JTwo1t4U/nz0Cgvajgq/+ie
 UGp2sK9ojOa8zD77/UEZa5JpUQ+OGByh821CI425hn2GsH0BGbi5VcdSfUxVwIZbk05EEJh1mxq
 HD5Pfj/fu0sk4AmICEkmYitPBrozaj0iXgjRovPc/XanFSiq3mSWWANkZmJcYU+bldLgbL7t8+7
 WrEtRJWZH9L2HgiDLIjKV4obInEl1AzphB0zr5
X-Gm-Gg: ASbGnctuoGaqoei+j1eKbqGO23UCuun4XH0Epls4eKnzsgulrUAqlT+xXvsOWX75Ids
 sE7xDO0VfNAL2b/graJvIAXPkZxGT1eZGTBrKWljoS75YP7iMorZdk089vvX/Fe7ndenMpqIb74
 ll2EBMDwMaR4udxbVQ0087WkTBkVipfJs+zQEoWgLrIqWmNnzPxp3JWqv4G8W6csg1kE0okxTec
 AQ2HUpNxRtFnGzDijKyL6Q1qbswXI57vIx3N6tDdDcR7CRLU/UZkqSH+tSgb99YKVZ/MtpTMHkj
 NEYDVczJLC6M2uHX1vZlFvYbt5JlQSdUVVEBAAuiI6iUq3Y=
X-Received: by 2002:a05:6402:5190:b0:5fb:d056:e302 with SMTP id
 4fb4d7f45d1cf-5fca0730753mr9709956a12.5.1747043598067; 
 Mon, 12 May 2025 02:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7H4pubhN80MypdNRQEu/o1V8Z/qSJKSPLzmzbsCn9L7tikQ9DSa58TY68Pq1BneW0jZBkWA==
X-Received: by 2002:a05:6402:5190:b0:5fb:d056:e302 with SMTP id
 4fb4d7f45d1cf-5fca0730753mr9709941a12.5.1747043597555; 
 Mon, 12 May 2025 02:53:17 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9d700e92sm5431724a12.55.2025.05.12.02.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 03/26] target/riscv: update max_satp_mode based on QOM
 properties
Date: Mon, 12 May 2025 11:52:03 +0200
Message-ID: <20250512095226.93621-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index c66ac3bc276..852e4681e3d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -928,7 +928,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
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
index be1bf0f6468..719365a95e0 100644
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
index 32c283a6628..48576bff92c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -389,7 +389,7 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
     g_assert_not_reached();
 }
 
-uint8_t satp_mode_max_from_map(uint32_t map)
+static uint8_t satp_mode_max_from_map(uint32_t map)
 {
     /*
      * 'map = 0' will make us return (31 - 32), which C will
@@ -455,15 +455,13 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
 
@@ -1175,8 +1173,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     bool rv32 = riscv_cpu_is_32bit(cpu);
     uint8_t satp_mode_map_max;
 
-    /* The CPU wants the OS to decide which satp mode to use */
-    if (cpu->cfg.satp_mode.supported == 0) {
+    if (cpu->cfg.max_satp_mode == -1) {
+        /* The CPU wants the hypervisor to decide which satp mode to allow */
         return;
     }
 
@@ -1195,14 +1193,14 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
@@ -1232,12 +1230,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
index a32e1455c91..74760f98cca 100644
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



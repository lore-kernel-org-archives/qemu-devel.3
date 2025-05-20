Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CE5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKoA-0001nP-PY; Tue, 20 May 2025 07:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo1-0001L3-2M
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKny-0003Jw-S6
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czKKNWxqZekPBvQJbIT+i70WaEQuVqWlGBCzzJatP78=;
 b=KXpLs82wSe8Qn7eMksPKQ8bo3uRXJ9q0iXPvyfSgrhEHwSnUB30ju/NHbEMfCPeDd1o0vB
 DbtvL8d1Z+DRn2RHMDD/cwBRzm06Dd5v/nE8oq6GWdGvVKyiz2PdsNdJz6caSLwMqnjIVG
 SubLY9iGh7gFzqva4ni/VCnkwrRl/FQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-fzYxYz_YNNC36uI_OyTQ-A-1; Tue, 20 May 2025 07:06:40 -0400
X-MC-Unique: fzYxYz_YNNC36uI_OyTQ-A-1
X-Mimecast-MFC-AGG-ID: fzYxYz_YNNC36uI_OyTQ-A_1747739200
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acf00f500d2so111265066b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739198; x=1748343998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czKKNWxqZekPBvQJbIT+i70WaEQuVqWlGBCzzJatP78=;
 b=b8nJ9BAVdC2lAxKu3Fpnll1exBTNexxPhTP490bQMfHKuPrEHTXl01/7tLFeBIWMUn
 SWqsDeYVI83ntk+hjnfAJIc8A8gN+izvyYEqeABefy3hfqQslm6sxjb91bieYVZ1DM/K
 nWPbaQdf+GQM2b9FVN8jA1mDC6tZtEZDS7sG0QGkzbSqYy+6BXeSI1GsBn7LsK/fRR1f
 ECtcu1qm9Af7M95j9MQKIs4mtHn8A61TAIOFH+U0dkLdh1Vclt3qYv1Vu+PAaut8U2cD
 74Cxs7GOsFQAQv/JoqO70SItF7PsFMjkPF/jFXtyjMBkYkcy14QCfRmFHXJeyAR9A9RW
 ep0Q==
X-Gm-Message-State: AOJu0YwMN6bbubTGQFT98kGWuom1xWCcPaQckH347M7Htdtc3jbe+wJZ
 mDwWqpTyVTdWlSKO1XOooZ/x6kO1UfeMVqjxDMI0xnNklo99u9DMIy1QhgC6RikP6ofel5VW4tP
 8uKdQsyXFkJiel6TLs232sezycuyotYedO1pdNZhEoZEOZ31m7YSdfyv9WuTgoxHXPxw1x26yon
 C6/V/XtvC2ca8e56Y/XErXKKJkPwhudb21iDpW2FKq
X-Gm-Gg: ASbGncvV18gqBWLgA05o1Kc2gtsxHtXOHLZF9Epkx4sHa1F4f4LxA7dHsu7XmxrIhci
 qaqGGWL0iTw73N36o1LffDKdHxOawndtQ/nXz/9Jl2ANhrKVoqZWtF5R9L/XgAnamTb3SDtt0uv
 D4mb3uI/xNBtNBU4v5uLO1fabCa73ep2uoGUSPSVsxQ9y5uweDhUdhwINmbaacL+i35ExCss5o4
 cRl0DeID069k+inIeiZ+DVf956/Fkzl54nb9BxvT0mk6lsx9iXJreyk9v3nR0zARtXS5fTLC2lO
 JOmNrmRu4nKSNA==
X-Received: by 2002:a17:907:6e9e:b0:ad5:6cb5:fc0e with SMTP id
 a640c23a62f3a-ad56cb60bccmr783555966b.25.1747739198403; 
 Tue, 20 May 2025 04:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuKAzrgM9RJdkWd+hivaNV60g9URDIZS5BJdOpC8vRBt0fT2MqN5zDz70P0Nylmgrm5hc3iQ==
X-Received: by 2002:a17:907:6e9e:b0:ad5:6cb5:fc0e with SMTP id
 a640c23a62f3a-ad56cb60bccmr783551866b.25.1747739197938; 
 Tue, 20 May 2025 04:06:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca731sm704409266b.166.2025.05.20.04.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/35] target/riscv: generalize custom CSR functionality
Date: Tue, 20 May 2025 13:05:24 +0200
Message-ID: <20250520110530.366202-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

While at it, constify it so that the RISCVCSR array in RISCVCPUDef
can also be const.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h    | 15 ++++++++++++---
 target/riscv/cpu.c    | 25 ++++++++++++++++++++++++-
 target/riscv/csr.c    |  2 +-
 target/riscv/th_csr.c | 21 +++------------------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ed88adef452..229ade9ed91 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -538,6 +538,8 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCSR RISCVCSR;
+
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
     RISCVCPUProfile *profile;
@@ -546,6 +548,7 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+    const RISCVCSR *custom_csrs;
 } RISCVCPUDef;
 
 /**
@@ -893,6 +896,12 @@ typedef struct {
     uint32_t min_priv_ver;
 } riscv_csr_operations;
 
+struct RISCVCSR {
+    int csrno;
+    bool (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+};
+
 /* CSR function table constants */
 enum {
     CSR_TABLE_SIZE = 0x1000
@@ -947,7 +956,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
@@ -956,8 +965,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* Implemented in th_csr.c */
-void th_register_custom_csrs(RISCVCPU *cpu);
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 01b028653a3..12f4bc41514 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,6 +485,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
+{
+    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
+        int csrno = csr_list[i].csrno;
+        const riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
+        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cpu)) {
+            riscv_set_csr_ops(csrno, csr_ops);
+        }
+    }
+}
+#endif
+
 #if defined(TARGET_RISCV64)
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
@@ -511,7 +524,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
+    riscv_register_custom_csrs(cpu, th_csr_list);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -1304,6 +1317,11 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
         cpu->env.vext_ver = mcc->def->vext_spec;
     }
+#ifndef CONFIG_USER_ONLY
+    if (mcc->def->custom_csrs) {
+        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
+    }
+#endif
 }
 
 typedef struct misa_ext_info {
@@ -2906,6 +2924,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->misa_ext |= def->misa_ext;
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
+
+        if (def->custom_csrs) {
+            assert(!mcc->def->custom_csrs);
+            mcc->def->custom_csrs = def->custom_csrs;
+        }
     }
 
     if (!object_class_is_abstract(c)) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9843fd21914..fb149721691 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -40,7 +40,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
     *ops = csr_ops[csrno & (CSR_TABLE_SIZE - 1)];
 }
 
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops)
 {
     csr_ops[csrno & (CSR_TABLE_SIZE - 1)] = *ops;
 }
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 969a9fe3c80..49eb7bbab5f 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -27,12 +27,6 @@
 #define TH_SXSTATUS_MAEE        BIT(21)
 #define TH_SXSTATUS_THEADISAEE  BIT(22)
 
-typedef struct {
-    int csrno;
-    bool (*insertion_test)(RISCVCPU *cpu);
-    riscv_csr_operations csr_ops;
-} riscv_csr;
-
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -55,20 +49,11 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static riscv_csr th_csr_list[] = {
+const RISCVCSR th_csr_list[] = {
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
-    }
+    },
+    { }
 };
-void th_register_custom_csrs(RISCVCPU *cpu)
-{
-    for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
-        int csrno = th_csr_list[i].csrno;
-        riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
-            riscv_set_csr_ops(csrno, csr_ops);
-        }
-    }
-}
-- 
2.49.0



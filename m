Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78289C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2z-000365-HA; Sun, 06 Apr 2025 03:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2v-000341-O8
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2t-00024I-Vf
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLGZDjEl+mDYF+rHh7AbTvIZ/KOLtGGwB7/cEnreBak=;
 b=Sj+ruoP7wbex6tRoNkCOJlO0uAoZ4gaY02eqZCKcOu6N/GCIAc5tcRe31YILVbbFhNWfPg
 MPhUJrfyzgESLggWQDi5plrMPL7OxF6Qj0hhBXUeWncrvu55Yt5uW957Jfg/L0QUX46p0G
 qZCbczwliJsiEz2owWIDjAvAih9+Dy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-7g46Oe_jMoCDccfzW-QXFg-1; Sun, 06 Apr 2025 03:03:54 -0400
X-MC-Unique: 7g46Oe_jMoCDccfzW-QXFg-1
X-Mimecast-MFC-AGG-ID: 7g46Oe_jMoCDccfzW-QXFg_1743923033
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so19199165e9.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923032; x=1744527832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLGZDjEl+mDYF+rHh7AbTvIZ/KOLtGGwB7/cEnreBak=;
 b=h9V/ZO31rnb+86gOc3GvkxQ0zAW6Od/n+7yl6qWIjROb3jIomn/XM9VQFnp7gtVRRm
 OsehLq0CJrJTOeEtmz+X6J2ZKDLqhZaSrM7GoJfHsMMxzeli2iLlKOGlhiDQJkrmZ/WO
 rhxbzfjDO0/0mXI8fLrXgQSDSMshH0T35KNcQV0bCG4Yd4dlnh80llxL+clNbB90wtFc
 RiPANKMwmgbUmI9Eb6Sett0VHEIZHuO/K4lvq7/0XOhHwq1nQSn9i3HIKnuuUgPbdvQa
 LNZk3W0XE2Dn1DYFKrZxlRjL10hpbfEMMsYVzuL+w+3L3CyE38R8eVIIv6ALqDv3z38X
 hVFg==
X-Gm-Message-State: AOJu0YzP86HO+E4hjOj0jeRAcX5PrNpIcjJg/IKlPQl2sqPF901uegen
 AICan4FNDp64Csrv3g/CA54/zgJ4EtPtJGrRw9A/3P5T0WZk+Rkjt1d+atEURT1vmsRwTdReTvI
 +EF8xIRYxfd2bY7oXG3GbhRFGsJH4ChQ5mUEIXL2h0RxSzT+hkJ4E5XqKjt61HosfAfjKkyNoeI
 7MYKsvUOSIqfgaaptTi36SLR/o0y5YHTiUq8ma
X-Gm-Gg: ASbGncu1+mWceGQ2vEyxSmJPCF26NXyW/p/8H2OaCKXo6JBscZW2zpHnKeNq7rfKr5T
 vc9B6CSVDVdYAFGW+l589veS96Z5zPYIEoAy6lI2r5UAkjbG6K5i1As4sHWeyeERi8NtlhUuEvC
 I+95D7pckfMMgtOcuwHIJqXUoRw10AA6Da4An05MiV1RPbaFyMovaNqY6yViIb2+Ep4XXX/z/ez
 JAjb4BSe4LCibShkq4XHeqCnuGLW24GyoY2QxPUY2qE+hMWQhJnXkPoCssZqCezHmE7SdOmiVIQ
 aD/x/b+qc2Ynn0aTCA==
X-Received: by 2002:a05:600c:3586:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43ecf86a99emr84237025e9.13.1743923031578; 
 Sun, 06 Apr 2025 00:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK83NiUKusGHrImAn/fedmFxsiLcV7iOlirFE8wN/6cS1mdJ4pziw/oPnZBUlY0F+CFs2Tfg==
X-Received: by 2002:a05:600c:3586:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43ecf86a99emr84236615e9.13.1743923031162; 
 Sun, 06 Apr 2025 00:03:51 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d5d1sm8813373f8f.77.2025.04.06.00.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 22/27] target/riscv: generalize custom CSR functionality
Date: Sun,  6 Apr 2025 09:02:49 +0200
Message-ID: <20250406070254.274797-23-pbonzini@redhat.com>
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

While at it, constify it so that the RISCVCSR array in RISCVCPUDef
can also be const.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h    | 15 ++++++++++++---
 target/riscv/cpu.c    | 25 ++++++++++++++++++++++++-
 target/riscv/csr.c    |  2 +-
 target/riscv/th_csr.c | 21 +++------------------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 54dc4cc85d0..679f417336c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -541,6 +541,8 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCSR RISCVCSR;
+
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
     RISCVCPUProfile *profile;
@@ -549,6 +551,7 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+    const RISCVCSR *custom_csrs;
 } RISCVCPUDef;
 
 /**
@@ -900,6 +903,12 @@ typedef struct {
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
@@ -954,7 +963,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
@@ -963,8 +972,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* Implemented in th_csr.c */
-void th_register_custom_csrs(RISCVCPU *cpu);
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6f516163486..9669e9822b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -486,6 +486,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -512,7 +525,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
+    riscv_register_custom_csrs(cpu, th_csr_list);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -1310,6 +1323,11 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2910,6 +2928,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
index 60de716a2a5..560b45d10d0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -38,7 +38,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
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



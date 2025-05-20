Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FEEC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKo0-0001Ci-2X; Tue, 20 May 2025 07:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnq-0000dM-AC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnm-0003H0-Sh
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98EAejV0BwhHSzKOR1AkN1dMFBQxypZdBrFVxi6EVuA=;
 b=IBcVEKfvwF9uP+LTQ79KGcIXeI3UX0yXjkSmjme4bGDqWZh9wIVePZpMY2ueELpQWe/nng
 ixijnrXRWsbmyBGGVheTNuBHkILJ7FEOmZflyNqjGNPo1in+6LIHXXnYgmffN/F/p/digG
 n+zoETTn21z112o2M21tm6ASZK14xsU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-xm5gpKm8OP2LtjclzSP_WQ-1; Tue, 20 May 2025 07:06:29 -0400
X-MC-Unique: xm5gpKm8OP2LtjclzSP_WQ-1
X-Mimecast-MFC-AGG-ID: xm5gpKm8OP2LtjclzSP_WQ_1747739188
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-60211a1705dso553663a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739187; x=1748343987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98EAejV0BwhHSzKOR1AkN1dMFBQxypZdBrFVxi6EVuA=;
 b=R97RaJx3u2zt9+tGSqnH9zOGzUDTJFSHTK7LVHEudBhK3lU5daCjzyWQfsAZpz0E3S
 CjB2WjdULCkrIAd9SjpPxmt7aiQB7Grqsrbj/7XcsQI/j+v6eEjRQAXnJqX8+uozVwqL
 u2y2n+1vnPo96R3SykqbuvA3MaHDLDRvCANxSmIBuFNgSR6AZH6nXtxmi1ywXM8Lm7AB
 OPoD55pQc6Skvgvfiy5Xq3Lccex0OFKW5bosyDhBsOCpYvHetF1ZMze2Gp87ULpbJFbI
 cW6xa0Ng5n8hFGTmTdNbcVbupUGwMlXU1tK2sWETaPxdpdpxceEaIyLUIiswZSHOySCO
 BhNw==
X-Gm-Message-State: AOJu0YzTPCsFWZGXgTsxtvZ6ePGWXj6Vv8J5zZBve+mIQWKwleNeOwrE
 n+1JP+r1k6K1b/FH2id1Lbi2sX0IZValF/AeqIbYAZtOqqQ65n2Dne4UG54JLMidDD3JiWcFnzg
 8JspI8DIEAG/Ueo98cV+aM8TAnL+yyK92TIR6KbIEbctThME4mrAbHHQEkWsmTvuvx5FdGUXvUX
 SXMKlA8WqmPBiewzDmLMEDXX9sFR/XvOvk8N7v3HHR
X-Gm-Gg: ASbGncuCedjZJ/TmQV1QuO4dUWBUpGLBZ7jX3qFPkgOD9GLlXwR2evM4n5dYEFk+Mq/
 0Q4wLHcwo0omuz3a0mm9o9PQMyEhmVCLGaKuzjiRHUwwj9yhx3Ra5j+8HurhthnrbA+bDiaNdIi
 bPAjtKvJ4tJ9KnHQFHKjzT0EFqV7VGIaNAA3Ta0/j2Z2pRmM3IEeqWl6ih+8shF9U50MImRh9PL
 UnhFzuecKiXnFxFsbEwGe1Eg8Qf+fpnBvC0/j0ek+HK2Ndf048DMEfK8yux39XOBfUpRCPLwTii
 3BRhKiRgDspZEg==
X-Received: by 2002:a05:6402:280a:b0:601:f5b2:af97 with SMTP id
 4fb4d7f45d1cf-601f5b2b070mr5146842a12.19.1747739187130; 
 Tue, 20 May 2025 04:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMjcNgkfs8etsVs9m8XapxhNEFWc+jdKX/v4+ALpAQH2xPIrlvypKjNyXbNdGBfgbcbh80Yw==
X-Received: by 2002:a05:6402:280a:b0:601:f5b2:af97 with SMTP id
 4fb4d7f45d1cf-601f5b2b070mr5146815a12.19.1747739186396; 
 Tue, 20 May 2025 04:06:26 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ac336d5sm7061829a12.54.2025.05.20.04.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/35] target/riscv: convert dynamic CPU models to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:19 +0200
Message-ID: <20250520110530.366202-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 113 +++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 82 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8b82a1b7b33..2b26f23bd0a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,38 +485,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-static void riscv_max_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-}
-
 #if defined(TARGET_RISCV64)
-static void rv64_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
-}
-
 static void rv64_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -717,41 +686,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-static void rv128_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-}
-#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
-
 #endif /* !TARGET_RISCV64 */
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
 
-static void rv32_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
-#endif
-}
-
 static void rv32_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -3166,19 +3105,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
-        .instance_init = (initfn),                          \
-        .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        },                                                  \
-    }
-
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3235,7 +3161,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_base_init = riscv_cpu_class_base_init,
     },
 
-    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .priv_spec = PRIV_VERSION_LATEST,
+    ),
+
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
         /*
@@ -3263,15 +3194,23 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV32,
+        .cfg.max_satp_mode = VM_1_10_SV32,
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
 #endif
+    ),
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
@@ -3288,11 +3227,18 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
 #endif
 
 #if defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
@@ -3302,8 +3248,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
-#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV128,
+    ),
+#endif /* CONFIG_TCG */
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI
-- 
2.49.0



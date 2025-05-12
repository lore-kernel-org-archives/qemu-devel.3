Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30378C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrG-0007g6-Nk; Mon, 12 May 2025 05:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPr7-0007do-9P
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPr5-0000iG-Fw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYm0tdgk66Y9sfzi/A+TT2iXMPsiFpEMFYa8+JgEyvA=;
 b=Klq0j8N91ahrJYN3viQNSe2eyjzrkXHrb3t8XSqJI1QRw2yeDgvPOnoiICFrc79zFuZXFi
 MPegyQn4eiRcE+TvEcemvXhbknSZ3/FhLG+osg0+hxtob3zr5Fv/riaHxvsuMf41g2IB4e
 By7lkwbC680t3mqLYCn2ISD40pr18EY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Zen90OEEMSC5hVjaw4nacQ-1; Mon, 12 May 2025 05:53:49 -0400
X-MC-Unique: Zen90OEEMSC5hVjaw4nacQ-1
X-Mimecast-MFC-AGG-ID: Zen90OEEMSC5hVjaw4nacQ_1747043628
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so378251266b.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043628; x=1747648428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYm0tdgk66Y9sfzi/A+TT2iXMPsiFpEMFYa8+JgEyvA=;
 b=kAy8BQmx7iZ5c5MFBanglvolZmmOs18rLBcGsXAxopHQRzkAHL++8TzE1inMNN3EPc
 EnOB9qatXVy+vRswDdWnhNF6ieQ/N55LW22Dd0Hwv0tFWMvZ+O78t5DbEHSNBHUOqhOO
 Un45xaoY2R0oWNALQMKAeNuRsljqGnrg954tCernfPOVWVv7LjDgajcW/2mi9JWrEsej
 GrHJNIk7OZWF5rjQBTWMLQYBBZWr0W+YhXTuRimLOJF0qs8Nkl4kjlJbT6a9qb1qX4gw
 iAhEpmDGdIRmbcFllZkGPSC+eb5PtAJ7//PbeyxjAAz+wKVQa/0qyA0Jj0+/SDPpOSn+
 MbTQ==
X-Gm-Message-State: AOJu0YxGspm6qIXhE1UYVq8t9tGt9AcvC7MhM7GTE4SZbmE4Ua1ai+Mg
 21dHkfCAf3WGgT9P7fBsq5OASt2pkg6gwS2T3Vpc0rwYJ+s57N+F5uN5wQJU17a2mNE0TnuzYre
 S9gcq5eJPSYrL7XzlhZod9ZoHrGfAx0BBArzEpExnlyYy8c82GpTjEMwdPLBBIlyDfKL/EenGHK
 puxlH1CjJ+2NEq5JE0uIejzb54E32u0naxeNYO
X-Gm-Gg: ASbGncsHlV/dBgfiWlkQ3cnMqs39KyozD1LEuDIIEv9jZfetBwIgOw0JnNSOV91s38l
 78h0/ypnDMXux8aJE3bX3lmYFae7e7s04UjOFdZl+cmb+TtEF0ziHYZt5sAHCIyo6Jj6m/U1URr
 wVK3cg6MzdQGypAR8vmv/drabP1NkxbJVvlW847Lzv0HvlHEtBjNKRmUQtGTqF+QnT7HGn20JKw
 QliDf7NW0JrRPFdIh82PfXpmwPQCvGnGwuK5d6pvYOYNg9O0bTCAaSmB/esgDPKVkPs4qJ16JF6
 KLmPVDjIY3UO8F44CCWo+H/D3XsUQ4UiKGjWZPRW3n02T5A=
X-Received: by 2002:a17:907:86ac:b0:ad2:43be:6f04 with SMTP id
 a640c23a62f3a-ad243beca43mr617650466b.51.1747043627928; 
 Mon, 12 May 2025 02:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZJe9ZEPFtLbKGOWIvsfm6m3YK9qOEP3xbd16eV0D4mNivfn/rfLReEr5LI4qVDMMH6t9/Vw==
X-Received: by 2002:a17:907:86ac:b0:ad2:43be:6f04 with SMTP id
 a640c23a62f3a-ad243beca43mr617648366b.51.1747043627453; 
 Mon, 12 May 2025 02:53:47 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd28dsm590880966b.128.2025.05.12.02.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 13/26] target/riscv: convert profile CPU models to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:13 +0200
Message-ID: <20250512095226.93621-14-pbonzini@redhat.com>
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

Profile CPUs reuse the instance_init function for bare CPUs; make them
proper subclasses instead.  Enabling a profile is now done based on the
RISCVCPUDef struct: even though there is room for only one in RISCVCPUDef,
subclasses check that the parent class's profile is enabled through the
parent profile mechanism.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 85 +++++++++++++++++++++++++---------------------
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0330d74ab6b..8a8d61f8099 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -539,6 +539,7 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUProfile *profile;
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f66560442a9..06c612afba7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1487,6 +1487,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    if (mcc->def->profile) {
+        mcc->def->profile->enabled = true;
+    }
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
@@ -2959,36 +2963,6 @@ static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
 };
 
-#if defined(TARGET_RISCV64)
-static void rva22u64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA22U64.enabled = true;
-}
-
-static void rva22s64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA22S64.enabled = true;
-}
-
-static void rva23u64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA23U64.enabled = true;
-}
-
-static void rva23s64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA23S64.enabled = true;
-}
-#endif
-
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -3057,6 +3031,32 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static bool profile_extends(RISCVCPUProfile *trial, RISCVCPUProfile *parent)
+{
+    RISCVCPUProfile *curr;
+    if (!parent) {
+        return true;
+    }
+
+    curr = trial;
+    while (curr) {
+        if (curr == parent) {
+            return true;
+        }
+        curr = curr->u_parent;
+    }
+
+    curr = trial;
+    while (curr) {
+        if (curr == parent) {
+            return true;
+        }
+        curr = curr->s_parent;
+    }
+
+    return false;
+}
+
 static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -3071,6 +3071,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
     if (data) {
         const RISCVCPUDef *def = data;
         mcc->def->bare |= def->bare;
+        if (def->profile) {
+            assert(profile_extends(def->profile, mcc->def->profile));
+            assert(mcc->def->bare);
+            mcc->def->profile = def->profile;
+        }
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3237,19 +3242,22 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
     {                                                       \
         .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
+        .parent = (parent_type_name),                       \
         .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
         },                                                  \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
+    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+        .profile = &(profile_))
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -3328,10 +3336,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
+
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  RVA23U64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.49.0



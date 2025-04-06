Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01183C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2t-00030a-2L; Sun, 06 Apr 2025 03:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2k-0002x8-FP
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2i-00022g-MC
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0idpnQMrNM3L4i3J+UHPU6IavosMyqVZepWIEotysbc=;
 b=ddkkuoiAYSS4T8k6nz7Rk0w4a01F+Kls04uHKvkpdOTIvj3FnHZtCMzWeKXU3rdMerZufD
 lRjB6w3PWHpUUWzf2qcw284HNComGqITAFr9Eg2j8sVOEKgSdqIoqFRsYbUCX4CtRSwPol
 O3vZqj33D56sQJFACPDhT9738VMBn1Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-pFnGIlYrP5SidXcXexFWUQ-1; Sun, 06 Apr 2025 03:03:39 -0400
X-MC-Unique: pFnGIlYrP5SidXcXexFWUQ-1
X-Mimecast-MFC-AGG-ID: pFnGIlYrP5SidXcXexFWUQ_1743923018
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912d9848a7so2124004f8f.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923017; x=1744527817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0idpnQMrNM3L4i3J+UHPU6IavosMyqVZepWIEotysbc=;
 b=fAkzbi1lBm4td9MwIjvC0gbrvfy6jKOV/pe0B7ppAFs/n8dWbX/eip79rZyUxI6e3U
 q2kthwQnz6xaYp0p5tJaqB6YAHOpQoizeUTEpKbHFhR+d/zm+J5c0+a1uBIK6SKqHCD8
 lb3BEAZXTZrkdSvoMxOKtFQy9GLmMLYvzYUAhIlUoygqdpZAcxaFGCgM0u73/dsBA00v
 YZmtmZsigCTmmF+rBU33MU7leSsnju80OjegXnXuR/UiwWvlh0Pgh1D4vfk14YJ/jTTm
 66UUIsx0A3wGAPNe2SiLlzuC7Q1YHQ4bGBaeel2EdHJhWPKBlV9ZIgCMMOkhICDxabdf
 utZw==
X-Gm-Message-State: AOJu0YzuEiAmdYYuPzPGAZmiQNZZVr5UsxZ1VuBcIfZiXkPe7bDbyZ48
 jxghtP1I61XC7OY6wx2O6Eh89JFk7ePtEUhhFRVPcBKYZxJ8FdRTMttF/azy3RUUnbW76ni9O7g
 RgvxiDIXsph3yEki4Oza4i144XHdBvrko9nxRoCQ7x4r8F7Yj+WtNnWv0Pk3SZpKApmc5nGtUlk
 G4eWjfB9yPnsOTBVLYXqQJYnOhBY62cwLhILAx
X-Gm-Gg: ASbGncvrRRZrqs9wC9z3asqxj782sF84Zauni26MaGy+gCYTAdglB5/TaT4F/Xl6XW8
 i9L1ZD5QCxTsxY//f/bXHA3RvkpJQ638M8PFiEfVYLP2HDKtEwNk6sQNZohXLuBNoCKNbvIDqUo
 fVuXlKD7nJvZ+vOxM4iePnGcF0CevHrzJWyu3TfYRTRhmkdkWVrIMxYCpfPVnfVg213OLB8C6RF
 Ev2wo5qNWpXKIr7ZIC6PFnzvd7eGygD0ybujoXojwWuFH/Tjs/C7TdjoCMy+14EFdkzM5lxsCho
 znY6y0kEmgzeItiyuQ==
X-Received: by 2002:a5d:5f81:0:b0:39b:fa24:9523 with SMTP id
 ffacd0b85a97d-39c2e6110dbmr9330421f8f.7.1743923017227; 
 Sun, 06 Apr 2025 00:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEjiePb10RXnvV/vGiM8tNtP+hguEasfR5K4kBy1wupkTHkQBikQtXmImvDyZmBwRkl0S6Bg==
X-Received: by 2002:a5d:5f81:0:b0:39b:fa24:9523 with SMTP id
 ffacd0b85a97d-39c2e6110dbmr9330383f8f.7.1743923016743; 
 Sun, 06 Apr 2025 00:03:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1660eb3sm96242785e9.11.2025.04.06.00.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 15/27] target/riscv: convert profile CPU models to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:42 +0200
Message-ID: <20250406070254.274797-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
index d247b9007a6..54dc4cc85d0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -543,6 +543,7 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUProfile *profile;
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 002f5a15ba2..d3d5c048d02 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1495,6 +1495,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    if (mcc->def->profile) {
+        mcc->def->profile->enabled = true;
+    }
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
@@ -2967,36 +2971,6 @@ static const Property riscv_cpu_properties[] = {
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
@@ -3063,6 +3037,32 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
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
 static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -3077,6 +3077,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
@@ -3243,19 +3248,22 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
     {                                                       \
         .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
+        .parent = (parent_type_name),                       \
         .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
         }),                                                 \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
+    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+        .profile = &(profile_))
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -3334,10 +3342,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif /* CONFIG_TCG */
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9450C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1c-0006Lc-NM; Mon, 28 Apr 2025 03:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1V-0006JA-HF
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1T-0001DT-Ql
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mHjvXubwbcGCb5CSz3Ry6azxLmtZ/PcS2aWp+uI3Is=;
 b=GH3G7tC70ElDh5ewfK5bVyXpAzQuwVPWQ2/NGzO/fjtb7E/OYrJCVIyNsI+LTZgEsbMJBD
 5e1fFthmn+BkujdzBkRfVdO7QReuchfDvNrPXiTIRS8PSeIVZkxB/SRdtNcfNA9Xa0vEyE
 Qog0YxdxfXtFjmnzC7tV6bRTQqI0uBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-_IWENIt4OkOj8HXNVDhomQ-1; Mon, 28 Apr 2025 03:35:23 -0400
X-MC-Unique: _IWENIt4OkOj8HXNVDhomQ-1
X-Mimecast-MFC-AGG-ID: _IWENIt4OkOj8HXNVDhomQ_1745825722
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so1843956f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825721; x=1746430521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mHjvXubwbcGCb5CSz3Ry6azxLmtZ/PcS2aWp+uI3Is=;
 b=LuL2z3FW4KlS7Zfynh6zCIAtqH39yJP1snHkJspXd6hJYLV/JjxE5Dlz2JDmdELx9F
 GcenFT/Vx/fhl5DfU4dUJvBArM1ygUxvac40W68G4wRJgSuY2SAnIDcJvGJ9/HZEOEiX
 /DzrklcTv/fCNa8hG1EiJvBAqDcBLKpCPc7jnVnQe4X8ndleXR4CvN97awZjROI2gJOe
 NG82SP+0fzwIIBq2Rfr9pvxVK/l5FMG+hBe5tNRUp3Illku1qDSlC56+pv1E813BEeCn
 2mPinqbkqhjM8Kz9HHBCaZmtXjaAQsS5xAEKP/r+H/rnlgx6UTUyESfD7EYVtNjaWit9
 wUOw==
X-Gm-Message-State: AOJu0YzKZbalM4nubOaJ060ob5rRAXdg3lsQdwsf1jUKArOAT+KhYw0I
 lLEeYri3k6EerzUHxu45Bk5FAQzP12LB7ZOYC3NMnzpGQxF5Lqm8wkWJ05lXR2OY7Dezmb8WCSh
 j0FY/h6LRshVpz2h73tdEIWhDmIUswTpePhY3OTX0YrWnIIcL7ky6mCnuX9c05izsEcw5Ey+ENC
 6nQbuWUOpyo4ggoVS7a8CYP0pgv9jTeNT2ruGE
X-Gm-Gg: ASbGnctsXsR4KVGMJse7q4/3FIUbu1mnKLbIXp4yVu48OJatGElNev+DiBTF9SpNa0q
 lsqMPKtfD4E32B/gS9lPZgddzW3WHAGDf4p5xO/h6GkhKDuo3DQDiVy+ZtzRgjKN/lyM+IfqGXO
 IDZWMbaOD+57/Bm10Fhe1gJNiEeF/0gm3JnSzxkl1314gNbbY22HpW+CyejUjWhK/M8TUeH5hjJ
 1WfjGlmvgC8xD6E6PWMNOBQJFi5dG12IdXd7UGxdoUOxQLJ761BIQEPPR7TlTCMtT8esQN8gc2f
 HrdP1rWvYcAqHTg=
X-Received: by 2002:a05:6000:2504:b0:391:3f4f:a17f with SMTP id
 ffacd0b85a97d-3a074f397demr7074748f8f.42.1745825720772; 
 Mon, 28 Apr 2025 00:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+prVP/unTuBqXIsRPRxO9fECe6oI2LgCbCm10u5E5Eas2pfUnn9xM2Xrc8f45Y3J7PsJCXg==
X-Received: by 2002:a05:6000:2504:b0:391:3f4f:a17f with SMTP id
 ffacd0b85a97d-3a074f397demr7074723f8f.42.1745825720299; 
 Mon, 28 Apr 2025 00:35:20 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbefc0sm10565189f8f.51.2025.04.28.00.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 14/26] target/riscv: convert profile CPU models to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:29 +0200
Message-ID: <20250428073442.315770-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 85 +++++++++++++++++++++++++---------------------
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b2744b66030..38fd667aba6 100644
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
index 0876b8a959c..c07ce5ddb9b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1488,6 +1488,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    if (mcc->def->profile) {
+        mcc->def->profile->enabled = true;
+    }
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
@@ -2960,36 +2964,6 @@ static const Property riscv_cpu_properties[] = {
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
@@ -3058,6 +3032,32 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
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
@@ -3072,6 +3072,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
@@ -3238,19 +3243,22 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
     {                                                       \
         .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
+        .parent = (parent_type_name),                       \
         .class_data = &((const RISCVCPUDef) {               \
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
@@ -3329,10 +3337,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDDCC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrd-0008KG-7z; Mon, 12 May 2025 05:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrS-0007tq-Aw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrQ-0000kF-C3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqqz4iQZNsh9z8LoBVDu2K6N+1uOhBIWgEvt8IVeXaQ=;
 b=XXJdQYVEoRioyS9RuS99iWvR55rMAVamjcK26cUwq18mO+Jf1bvFaTQeXBGu8X8IV7Wh6m
 wB+MTf8xv3uzGDeGE0JhO2PnNj4aQi8DrzOAsnVr3mAZR0BncwpFvYb4gyeuNYhsoHt302
 nGDlTie+/XFKOGZnwVV+e5MDdjUzfdQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-FleuRbPANPyD7XQDlqiQzw-1; Mon, 12 May 2025 05:54:10 -0400
X-MC-Unique: FleuRbPANPyD7XQDlqiQzw-1
X-Mimecast-MFC-AGG-ID: FleuRbPANPyD7XQDlqiQzw_1747043649
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac37ed2b99fso387072766b.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043648; x=1747648448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pqqz4iQZNsh9z8LoBVDu2K6N+1uOhBIWgEvt8IVeXaQ=;
 b=lslEqHtuPyoeIwKi3XSjua12NvIQT48xlbmj5wZ9PMuUFcq8kOIh3ghKyHNVUuQgXW
 /FtHNWoA2c4+p1HHMc3EbZlD2hsKwEirk2MtacY3srjJqjrpLbuhNCZx+Y7Ck4dGYrM/
 cVA//rorKjrU7UYOmsf8XQjhZNP7ejJh2bFva7DOI8RCZNHVXps7wSLjyP8nDHlTKOBH
 11hFe9QjnLwdFkSRw+VamYDdazufHv+3Bit4WITt+V9Zmwn0MFKQZMzSlVhV/VrjmTAq
 ZKduMIGv8gd2/qw/eYy3p7KUo2wYQcgEx6FM/6TdhCmnkrT1kIuCI9G0urTwfIvo3fP2
 mrfw==
X-Gm-Message-State: AOJu0Yw3aIeOwww1DRvkRW0EAfssEuTYau7fgxf9Fnwj4o5Ia5NxfBZD
 7TH5i1zeHT1/KXLhBeMGXWkVxNfJXY9k6hAoG/4sjrY7AcfuN4wBAkwkBr5Upa6Z4dGp7hLTkHT
 CZLkKa8PYCNYWvQiXjEOSdVA14ale6Je4OPG9bMJQwg+5BZlr/hopgpVRxV0s7/wPdo0CBjU7RR
 5RlMnHYePZ4RsR9qD89BNduwSQ7pQjbL8pK+gZ
X-Gm-Gg: ASbGncv9rJPeb2bKvAf4LzKq7g8oCwulGMStTJkl/3K+/Q3keVHjKMOnD0o8hkP9uhP
 T5KEiK7HF9PvlgOY4AkFQuV8fu9B1DOE/1QKAnL2TswPAqMObm9uQt4KNuOrT8H0lTa0cTkN06O
 Ns1fEdD6UthGGi7jhU3pGfmvzWqt88yrXntz88+s53BTXvRPRB7OWHV2jBLoZ4FSZlDKviQYw93
 xcJdpopaTK9fRVY/FIHWKDS4rUujeLI16JNJzJmAP3Oar4RX1CA25MFklWsmUMUep3O/aFHe7Yw
 NkdE4ymbcXacVHk+xE/o6jWCB0tZc0E+yQ6sJhYLeXOAEbw=
X-Received: by 2002:a17:907:7b04:b0:ac2:6910:a12f with SMTP id
 a640c23a62f3a-ad2191681e0mr1052671866b.46.1747043648423; 
 Mon, 12 May 2025 02:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfEQZ48qk9wKQd7x9C04YZ1CrDjHIh/3kG3bGVgbsNT3K2As71mBPqFCGgYDsr3zV9lpkf8A==
X-Received: by 2002:a17:907:7b04:b0:ac2:6910:a12f with SMTP id
 a640c23a62f3a-ad2191681e0mr1052670266b.46.1747043647927; 
 Mon, 12 May 2025 02:54:07 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c83e4sm600070366b.11.2025.05.12.02.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 18/26] target/riscv: convert SiFive U models to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:18 +0200
Message-ID: <20250512095226.93621-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 79 +++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 0f9be15e47b..1ee05eb393d 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -48,6 +48,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
+#define TYPE_RISCV_CPU_SIFIVE_U         RISCV_CPU_TYPE_NAME("sifive-u")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 661b2384d82..171f27fdd87 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,8 +440,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        int satp_mode)
+static void __attribute__((unused))
+set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -486,23 +486,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_sifive_u_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -671,27 +654,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 
 #endif /* !TARGET_RISCV64 */
 
-#if defined(TARGET_RISCV32) || \
-    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-
-static void rv32_sifive_u_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-#endif
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2921,6 +2883,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
+
+#ifndef CONFIG_USER_ONLY
+            /*
+             * Hack to simplify CPU class hierarchies that include both 32- and
+             * 64-bit models: reduce SV39/48/57/64 to SV32 for 32-bit models.
+             */
+            if (mcc->def->misa_mxl_max == MXL_RV32 &&
+                !valid_vm_1_10_32[mcc->def->cfg.max_satp_mode]) {
+                mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
+            }
+#endif
         }
         if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
             assert(def->priv_spec <= PRIV_VERSION_LATEST);
@@ -3140,6 +3113,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.mmu = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3171,7 +3155,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV32,
+    ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
@@ -3199,8 +3185,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401EBC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2w-00034n-VG; Sun, 06 Apr 2025 03:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2r-000307-8h
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2p-00023v-F7
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MeU3eK5ar2GTqe3qx1h5BuCL3nncCBPQial/X5QVQ0=;
 b=eoqr6nGdjnOxX4F7dU3ILUBQvt0X7D+gXMsJw0xCvMUiOCAalWY0vXcF+wlRVgg/0J3Na1
 g+FychrtWwlXZRO25m3ZESBkkWUSjohYN+F6Guj5GGQxjVAySgmmlfEhgx9dM76jcJIH99
 nJ0mvHgt6OjSic2rjpBCkKlUzqTFVCM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-RMW73dB8Mm2wbr8a8-AcGQ-1; Sun, 06 Apr 2025 03:03:49 -0400
X-MC-Unique: RMW73dB8Mm2wbr8a8-AcGQ-1
X-Mimecast-MFC-AGG-ID: RMW73dB8Mm2wbr8a8-AcGQ_1743923028
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso26629755e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923028; x=1744527828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MeU3eK5ar2GTqe3qx1h5BuCL3nncCBPQial/X5QVQ0=;
 b=ZzEIzYfS6CWgIX5h9Hkjzt1PoUVycuWsNQRTsfLSi5EU8xsIQZDTatsp6LYY/8VIZw
 rMD8pcKfIk2Qdidy635SrkHikxyFdYK4MR8hlUwGs7nC19aq8qhQvI0l54H1O/g0YBub
 A7O+asUmYPhZlNBTRjfzgHBtRyaS8NLp3CADvr0nwGHgXGNbH1yLF84tQ3wQ971peYq4
 eyW3WKveMHtGpMUncYYEwKSj0K1lfvVu/fiviQjVcVH/sYeYXaTC6CIuka2U4ZzbTtaw
 mWsrZ03wfQvO7LKK5dFYkusfZQaTnLR/blQ5Vf7nvG1dRmGZl6vv8AC/vdzuF2fvroOd
 Sq5Q==
X-Gm-Message-State: AOJu0Yyfe3yNriBrGhfUW/bQ+XI+JllSPDxo28pwUfcSM36KtYqfrXYg
 n317RTg5GdCZrrZLm7OUFHC60F9LRepbYu89EqWSnKpCbJBpyv0hLKfCn1e6GhKkPtDI1eKBXfx
 iy29a/mDMdv1izw8a97QEWcAp4GR1QnPHnJlsfEQ0r3vem7LVzIFXanul57GS/IpLTDyz7o3+SI
 sDwtA5ERh8sFX1S3CbGZO1Lsq9kru8gmuDrpMc
X-Gm-Gg: ASbGncuOYWDX8PAAnOFLL6Av1K4gqmI2AUEo1kAooMvU7a4SEJ+QHgT26jkOG560xed
 n/Xapa/rw7OzjyHRbaKlFReYi59PKAPXzAzJHMO3C+1R6em+Q5blGqAj3ntz8g5ldasus/mN6eS
 lZjS6hENG/MvSTqYsGsAKQlrIwHTYWlrPsIKvlw0dvoUYEQVzS/kzmp+9LbcNoUTkP1RokTq5Iv
 aXFigKVu6vdKdQPY/qg81w0xg5C6ClIaNgya2QhmZ7JbpY2APgh3gF/tpYQFugE63WTB0TJHMHd
 l1IJ0UJ358XTulFMgQ==
X-Received: by 2002:a05:600c:1c9d:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43ee077fb74mr30205315e9.27.1743923027904; 
 Sun, 06 Apr 2025 00:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAeows/u8zSI6rG3ilV1HU3mkhxOsz9qZVd+CB1aTbPHels1zmMqjrUsvGiz3wuGDFPTfjBw==
X-Received: by 2002:a05:600c:1c9d:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43ee077fb74mr30204985e9.27.1743923027398; 
 Sun, 06 Apr 2025 00:03:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364cb9asm91908505e9.31.2025.04.06.00.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 20/27] target/riscv: convert SiFive U models to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:47 +0200
Message-ID: <20250406070254.274797-21-pbonzini@redhat.com>
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
index fe1edf3be97..6f516163486 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -441,8 +441,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        int satp_mode)
+static void __attribute__((unused))
+set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -487,23 +487,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -672,27 +655,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 
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
@@ -2925,6 +2887,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
@@ -3144,6 +3117,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3175,7 +3159,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV32,
+    ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
@@ -3203,8 +3189,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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



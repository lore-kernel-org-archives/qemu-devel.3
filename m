Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D138C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnw-0000zX-DD; Tue, 20 May 2025 07:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnr-0000fv-Bb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnp-0003HX-3E
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9zNVAvbEj/OZ5dGDTKyCkTLrX0UKtdUcXjm8cpwpc8=;
 b=UdOkjo9UI/nXIF3vVAMlkGrznYT2D/qYtxnBnkM013aFGsteEae5VAdriTQ/PK2Ca6nWPw
 1xY86IMb8G5qPk8AcmcWAdIg8NJlD612AWYnR/hODiZQjbIVC0ZH4kqpF047YZLjcf8urV
 zLhvLXOXMdMaPWMu0bCVdibJeoJkWok=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-YNRunw6QMd-x0oux76ToQA-1; Tue, 20 May 2025 07:06:31 -0400
X-MC-Unique: YNRunw6QMd-x0oux76ToQA-1
X-Mimecast-MFC-AGG-ID: YNRunw6QMd-x0oux76ToQA_1747739190
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-601a4d2913fso3007051a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739189; x=1748343989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9zNVAvbEj/OZ5dGDTKyCkTLrX0UKtdUcXjm8cpwpc8=;
 b=CB9UPtXjj9Y4h2SzmWLICOUgVFPIbijbigVJFoVR7lZF6c8U3m6+Ado+1Mhazzh02X
 azbxU0b6VKAysui+zOuelGrjJrdb75kYHiVhfEX8m634G6EmA3PqtHwQAw5KvzCMtk/D
 pMsdD0hPzNV2hZRqxExMaDzY7OuDYrib7i7BccrvDWmrcRwIpIk32lDCc4tNqzSSp6L1
 5TN5f1RKFXoKk2e2BgU1HhEv9EgGIWRZiBQNJ/s0x8ZQ46YjgTTrG7Nm24SFYG5p5jlM
 WzNhZSWh1NvEbSEMox09oqtVF4EEGWV2tiwoQ4m6yRSkcdptPr0+sBBQdAYMNSi+Ghsj
 dLgw==
X-Gm-Message-State: AOJu0YxJGh7xiJLDMCpAyk3rmYbLjTq1hVtHU64CEumlmh89rldKeWez
 qFDtrgpPwpgAh1JA/5RNFlJoWfV8TMhvIcLX6FoAvJfmuMu6lyKP2/sssRvFyUYSGLJB3tEWi3d
 WBQ8NXcoTX3dyH2MIYl3hZ4kXsWrRHLiBIOIij12iQPgh/gTLAHvqbTQ8L+h0bsu7Q6hex1DhrM
 FiA+qSae74r1WzIrkxdYe1/7b8KMw/L9uEZvyuBvMD
X-Gm-Gg: ASbGnctKD7EC6GXj4DiDXGyejeF+Up8Op1RnKWnWLx5IT50yZVUem2JSvU2C/Geb1um
 WhGqQWyTNZ7ndnmcLWzNjRBIfA6OAHYZ6p3fs90UV99UdhsFB0IE2JhumvXxNdMLCKMQJJLBH0f
 2zY9tgZuVUOQsyLF7UGaxq2BXdNVpHSYIotjjFNrMj6+oP612dDgSnnBN46O3J8Io7Wp0Iu/wzJ
 rSDnM334QN6BhPbi8xqzhS9FgcdOxU5hpUV/ttS4XCAi7j9ILRyvIAx9Oi79qc4sqcS7aKvfYZn
 cDno5wdQiXLuGg==
X-Received: by 2002:a05:6402:1e89:b0:5fc:aa51:4d9a with SMTP id
 4fb4d7f45d1cf-6011411d313mr14105429a12.26.1747739189124; 
 Tue, 20 May 2025 04:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWzzdSeHlcdQBsRZD5rn0JDj2k/BnLC4gOxcNYghM6mOH2UG5KF433ACa2R1Jp3bmiYW3Fxg==
X-Received: by 2002:a05:6402:1e89:b0:5fc:aa51:4d9a with SMTP id
 4fb4d7f45d1cf-6011411d313mr14105395a12.26.1747739188638; 
 Tue, 20 May 2025 04:06:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d4f1ca8sm7034642a12.6.2025.05.20.04.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/35] target/riscv: convert SiFive E CPU models to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:20 +0200
Message-ID: <20250520110530.366202-26-pbonzini@redhat.com>
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
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 74 ++++++++++++------------------------------
 2 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4cfdb74891e..0f9be15e47b 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -44,6 +44,7 @@
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
+#define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2b26f23bd0a..17ad8b2ca1f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -503,23 +503,6 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
-static void rv64_sifive_e_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -708,23 +691,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
-static void rv32_sifive_e_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv32_ibex_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -746,23 +712,6 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.ext_zbc = true;
     cpu->cfg.ext_zbs = true;
 }
-
-static void rv32_imafcu_nommu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3204,6 +3153,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3212,8 +3170,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV32
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVF,  /* IMAFCU */
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
@@ -3239,7 +3203,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV64
+    ),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
-- 
2.49.0



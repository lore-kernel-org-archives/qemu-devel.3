Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253C8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPre-0008Ov-02; Mon, 12 May 2025 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrI-0007gV-Oi
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrG-0000jo-Th
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0SntZbQwUaXQqozZqm7tcsrLH8RO+joDT7p506a9LM=;
 b=OGnCgtk2qpZwZ1otsH28nyS+OuyTrvyeWNFWkW6EznPLu77vUUy4iLqaWWTGrAdUmi+0Cd
 tpv4l3mytpKXYy0+LOnDmJ+qdsSte4pLEViesXzlfDZXPhPWKZ/3PnFOm6R7lEtSruFk8d
 OR6SGWm3ErwX4PM5devzHen8uOJBU+U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-sUGqQnUeOEasEaeuFZ1H9g-1; Mon, 12 May 2025 05:54:00 -0400
X-MC-Unique: sUGqQnUeOEasEaeuFZ1H9g-1
X-Mimecast-MFC-AGG-ID: sUGqQnUeOEasEaeuFZ1H9g_1747043640
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5fbf5bed97dso4537863a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043639; x=1747648439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0SntZbQwUaXQqozZqm7tcsrLH8RO+joDT7p506a9LM=;
 b=sSwnEd7qkzQfGBEXikE3kiESzakZHE/98p6PqXpMPeFhlQNtSqx9Kx4UtVR0tcEzTD
 5J7WZw6PmDUHfvXEAErC7GNHcN+9pLMcQ2Bkr0V7wmStC0NNprJEVXdlBizHo1pIR9KZ
 09HEHN11M9DqI9CXzsTl9C4IYpYyOAnuD7nInW7RkvIF3rw0CdK3xHXATO6CzgAw+ube
 vh9kF5HSVfQnM8FNNN5+TgkaaAWarqpEyTDK8DZLH1JGtrsEyQpLq2aFGO73X4dT138M
 VP/NEmtUNxzF+0Bbv/z3lIh5VVmPLTB7c0CF9wjFbAiO0ArfoFgT4UJj3ahH4K4KlyBd
 ncSw==
X-Gm-Message-State: AOJu0YwdC+Gfzy5es4Qsphs2eGvWMLrKHBHpp1IhtwaFmvoiCkBcYGZR
 JI2uPnOOpyenW88wQ9DMy6a8USaju/0XIiFgcts+X9PnS3wuIDdnJoaSKiMZQoHGY3cOARiz5y0
 lOjP2t7aTPva6EmHmA45kMNGjFMAXNfgQ1GrRCJ+WeHekxIg/1dwgEQnbXs/Wlr5viLJEZURQtN
 V/teWXleTeOE7oV/ccdjY6JTzgDuEcPiRLvB+K
X-Gm-Gg: ASbGncvXip6Ma1tZEKz1io2XU1H/rEBOaT2OuXo0yIv1pcwJwqECG7CHTceub+/dKnR
 j9kGobhmHBUNyQlq8aGFob3UHyo+I6r4HS0s8Y+sgbioI53/3iitSSaMsmTD7CW6/QgkHE5XCSK
 msHuS26hAz0hNUJCt4nABIsb3hi5lLkTYy20lGgVbVoHpp8pmOIzxm2balPsvMU5aIkKfokp8yh
 4tTbUIuTTJv777uqYt7I/fLHlugzC2mUXfW0c3MUciZ5rbyM+4t0BmAlue1xbpqawTJQ7vxiw7F
 WNFQ8tH4qccf3Qc2Hl+eSxJIE3bh2hx2Iru0yF68Oza/dtI=
X-Received: by 2002:a05:6402:1ed5:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5fca07eb370mr10785363a12.22.1747043638835; 
 Mon, 12 May 2025 02:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkRryKfCfo3yhy9PetJBMgn/MjCAkZ4tVBO/xXpAYPkKyghKBNVeQBtVqFnnq15zcfEP25yw==
X-Received: by 2002:a05:6402:1ed5:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5fca07eb370mr10785351a12.22.1747043638415; 
 Mon, 12 May 2025 02:53:58 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fe7fb0ac1asm1471730a12.7.2025.05.12.02.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 16/26] target/riscv: convert SiFive E CPU models to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:16 +0200
Message-ID: <20250512095226.93621-17-pbonzini@redhat.com>
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
index b4f6e34eac7..aea5d7d197e 100644
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



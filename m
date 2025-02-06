Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95E2C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bO-0001Mj-6B; Thu, 06 Feb 2025 13:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bJ-0001Hn-VX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bI-0001D2-BP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S/fFckl2GPx1zzTTImVbffXXhjNwHps1sJHArnKbZU=;
 b=M2xPRiA15l8OhYz7jIFlPgScXVumAPkYhfIvX+qo8fwDa4S6VIn9zxlLObSQDe/AeOxdiC
 5NDYyi42cfSfq89muuhY9f4Bh9s9olquajmjsnxOCBtAMXPK6gQ411wBd7CSjgLCe97fef
 7oIxHAeAJ04/Lwo8gACdFzjmKhMBRpA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qOCXJ6UIPIWxYjdHjHJd6Q-1; Thu, 06 Feb 2025 13:27:42 -0500
X-MC-Unique: qOCXJ6UIPIWxYjdHjHJd6Q-1
X-Mimecast-MFC-AGG-ID: qOCXJ6UIPIWxYjdHjHJd6Q
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38db560edc3so597042f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866460; x=1739471260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8S/fFckl2GPx1zzTTImVbffXXhjNwHps1sJHArnKbZU=;
 b=tWKBSuoNTkv24mI+veYqX1v1hXPCDuCNwNcR3n1M8/pGMTtqY5UOodQ0ZmaW/57tez
 fLihTvlEj4zESztFUCSMAOmDr2anFLP1ggX6wEQ5UHFvnUH2l56s5tDymrOi/m4fa4Cb
 2NW9Kk+MIi12ITYNFySY4V81u02KAfcysuPVoa6YbcaPdlKU4qcvFZoAp586La6Kow19
 7rsTskQwLdT9OgUKiwVMCft+rE9mfOXAVJrg1YCLQrikeoOUcWR5YBz3bE4o1qCybD1p
 N3OdVeGmOJjxpOtHrRJ9op6Nmp1I7XUhRPuEG1kpjZXLssaJF0q/kUJOMNdkwyYc5SXr
 dnmA==
X-Gm-Message-State: AOJu0YwkCyucnb6PhMA7WdIsrJQ+EsdqbiDNPXwKp0c2pmKTtFaU4z2a
 PtTKxhFD+8BOn//adcIYvY83ko6mIYNVacCT++NFG8Hhsgq+NyArjURNIQpC7FmoKpSiwon9Ddb
 Kj91jJaniwP6KxUsvE9YzCqegutWcd3xd9QCdTWj1AYH3P6X0bcW+eDfaB9TD94fxoTxl9RFHRI
 Qb1W+uDkg1Qkxm4DZOFkpZDeiHkv/CjGDkTCEf3ko=
X-Gm-Gg: ASbGncsC8MbjW+xu+qypiG1CdSDDQfB7Etqs9912P1Lga0aVVhexD4FaNVi82hiyx/2
 MGWgmGqZXKzI3Z0fRfD8yitvSykk8aTp3d02PefKPgPT9ylihvhUmoRuqYb1g0wk0GPjJVEMgoA
 8XgDDkWsNrB4w/gER0FCVvAiqmCVf9MS+94AqtpcJJD9luyPvGtcO6GYHPxNsT6Kar2VeWRdN7j
 r4G4NZsYddzhnOLhraRd0WWFFYuMrUBHWM8VenvBNJp/yrsh97uGvcQS00x+U0fxJETHELJFaSz
 BTt8IIM=
X-Received: by 2002:a5d:5848:0:b0:38d:b2b8:fadd with SMTP id
 ffacd0b85a97d-38dc90ff5c2mr29878f8f.32.1738866459868; 
 Thu, 06 Feb 2025 10:27:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcpXI0zvy385GdXXeHyLFZf/9EFhdyCf8uVQ8ZUHSgnFpdMYqD+JDgypUk/9iBWaq53ivnHg==
X-Received: by 2002:a5d:5848:0:b0:38d:b2b8:fadd with SMTP id
 ffacd0b85a97d-38dc90ff5c2mr29860f8f.32.1738866459482; 
 Thu, 06 Feb 2025 10:27:39 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd3csm2381751f8f.62.2025.02.06.10.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 12/22] target/riscv: convert SiFive E CPU models to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:00 +0100
Message-ID: <20250206182711.2420505-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 target/riscv/cpu.c     | 75 ++++++++++++------------------------------
 2 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index d56b067bf24..bfe1455254c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
+#define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce439f1159d..b47ca531503 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -489,23 +489,6 @@ static void rv64_sifive_u_cpu_init(Object *obj)
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
@@ -694,23 +677,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
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
@@ -732,23 +698,6 @@ static void rv32_ibex_cpu_init(Object *obj)
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
@@ -3096,6 +3045,16 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .satp_mode32 = VM_1_10_MBARE,
+        .satp_mode64 = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3104,8 +3063,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3131,7 +3096,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286FCC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOd2-0006h6-Js; Fri, 09 Feb 2024 06:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOca-00063B-S4
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:45 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcW-0000m0-Jw
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:39 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-363a76d0c71so2814855ab.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476433; x=1708081233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a021EecWvVPRq6Ve8HaYmJGaixy2EoGAOwfIFo+4jJU=;
 b=DV+g0Dh5nCYhPk7PWWVjpjV7hXu+kQiyQJPaQolehFEAyZd/Qeqxrt7Do6h/UA6weK
 c3QZOGA478J9hvwQwYimlFwXxubbqBQXFXXLehAazcgFb4rprJP4ov8sT/jMEutAyEeg
 MHEkDvuoVBI3zpRNaHqCqcVw2YU9Dgw2PVnrGCaa6dUIsh20BURB5+95Vxh64BHF6Vtv
 kH+qW+jfLxYEnmHqROmdYa/uvkpL6DAKT6bEjdXsFicGEZKJH5ApZB10/W+KkxBlOrEQ
 trFUh1m5E/oBa05rpc19j3OdxrZ8k6nYqp8HKOdyc7IUB0I+5BA6UukXUZRmCLSkvHxb
 GPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476433; x=1708081233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a021EecWvVPRq6Ve8HaYmJGaixy2EoGAOwfIFo+4jJU=;
 b=mzYCdPbLBYko6lEh3+Mm58jmAwC8pNc3/CXvQBSw/YJVN6F4T+o1Cbqf0oAZkJvjKU
 P8jU0ELmJPGK8vYFlLqbSIJtkeK08JGU6OpaKbnAv4eTvjIsGs0Bv/AapX5l7gKnDfVv
 XuH5QpnEj2CN1ISDH/gu71yr3qFWSD8D03bgPXEFZVZBqRVR+iqFO5OJkx/cAoOcCyn/
 V34gmsfFIyAiEUnvVaGPo3LVsVOQal56TRT/3PGJ3LlcYgmNIEQAsyni2LlYY/PrsJnl
 Vr9wcSTk6zqxdjbW2rYg65nf4lfn9boiNO5/DdeQlcX6gupJxKyR12h+CTd3F4iI1EnS
 Ky2A==
X-Gm-Message-State: AOJu0Yx36+X0hYi2iTI5Nbv8LdKfzBIoH/ZkczOaUAmMsVZ1CwHGF8y1
 zLMJfbVzvuU81bU20IepWpuFmZUU/ImZu3DHDGlz+fNBxMYL6CqjTI3PBrsAW0ScMg==
X-Google-Smtp-Source: AGHT+IENXzZyKTcfnl+umn16PkWN1pIOx/LFJtckxxifjRMQ9JhhSTyrunFjfkCxIJwzaRle4hYR2A==
X-Received: by 2002:a92:dc03:0:b0:363:d9e0:c9e2 with SMTP id
 t3-20020a92dc03000000b00363d9e0c9e2mr1581530iln.2.1707476433114; 
 Fri, 09 Feb 2024 03:00:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXi0okFb0Ur/c2gd59Cd/cCyCya+waSudeAziyWoAiHK7dmSVYY/QHoFD95pASxlyMbo0qvZkQxXHaK8NVkVVux1GwIbX4/gLhyXpWuObJJk3m6d2Lw9KGBHAE/mCdEShAUNA==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/61] target/riscv: Move misa_mxl_max to class
Date: Fri,  9 Feb 2024 20:57:51 +1000
Message-ID: <20240209105813.3590056-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

misa_mxl_max is common for all instances of a RISC-V CPU class so they
are better put into class.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240203-riscv-v11-2-a23f4848a628@daynix.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |   4 +-
 hw/riscv/boot.c            |   3 +-
 target/riscv/cpu.c         | 160 +++++++++++++++++++------------------
 target/riscv/gdbstub.c     |  12 ++-
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  12 +--
 target/riscv/translate.c   |   3 +-
 8 files changed, 112 insertions(+), 99 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 07f797406c..285a247368 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -189,7 +189,6 @@ struct CPUArchState {
 
     /* RISCVMXL, but uint32_t for vmstate migration */
     uint32_t misa_mxl;      /* current mxl */
-    uint32_t misa_mxl_max;  /* max mxl for this cpu */
     uint32_t misa_ext;      /* current extensions */
     uint32_t misa_ext_mask; /* max ext for this cpu */
     uint32_t xl;            /* current xlen */
@@ -471,6 +470,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+    uint32_t misa_mxl_max;  /* max mxl for this cpu */
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
@@ -781,7 +781,7 @@ enum riscv_pmu_event_idx {
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
-void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
+void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 bool riscv_cpu_is_vendor(Object *cpu_obj);
 
 typedef struct RISCVCPUMultiExtConfig {
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189..12f9792245 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,8 @@
 
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
-    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(&harts->harts[0]);
+    return mcc->misa_mxl_max == MXL_RV32;
 }
 
 /*
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bf58ba4b57..0e6762badd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -301,9 +301,8 @@ const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
     }
 }
 
-void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext)
+void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 {
-    env->misa_mxl_max = env->misa_mxl = mxl;
     env->misa_ext_mask = env->misa_ext = ext;
 }
 
@@ -416,11 +415,7 @@ static void riscv_any_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-#if defined(TARGET_RISCV32)
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-#elif defined(TARGET_RISCV64)
-    riscv_cpu_set_misa(env, MXL_RV64, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-#endif
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
 
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj),
@@ -441,19 +436,17 @@ static void riscv_max_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    RISCVMXL mlx = MXL_RV64;
 
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 
-#ifdef TARGET_RISCV32
-    mlx = MXL_RV32;
-#endif
-    riscv_cpu_set_misa(env, mlx, 0);
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
-                                VM_1_10_SV32 : VM_1_10_SV57);
+#ifdef TARGET_RISCV32
+    set_satp_mode_max_supported(cpu, VM_1_10_SV32);
+#else
+    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
+#endif
 #endif
 }
 
@@ -466,8 +459,6 @@ static void rv64_base_cpu_init(Object *obj)
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 
-    /* We set this in the realise function */
-    riscv_cpu_set_misa(env, MXL_RV64, 0);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -479,8 +470,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa(env, MXL_RV64,
-                       RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
@@ -498,7 +488,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV64, RVI | RVM | RVA | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -515,7 +505,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV64, RVG | RVC | RVS | RVU);
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_11_0;
 
     cpu->cfg.ext_zfa = true;
@@ -546,7 +536,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV64, RVG | RVC | RVS | RVU | RVH);
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
     env->priv_ver = PRIV_VERSION_1_12_0;
 
     /* Enable ISA extensions */
@@ -596,8 +586,6 @@ static void rv128_base_cpu_init(Object *obj)
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 
-    /* We set this in the realise function */
-    riscv_cpu_set_misa(env, MXL_RV128, 0);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -608,7 +596,7 @@ static void rv128_base_cpu_init(Object *obj)
 static void rv64i_bare_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa(env, MXL_RV64, RVI);
+    riscv_cpu_set_misa_ext(env, RVI);
 
     /* Remove the defaults from the parent class */
     RISCV_CPU(obj)->cfg.ext_zicntr = false;
@@ -635,8 +623,6 @@ static void rv32_base_cpu_init(Object *obj)
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 
-    /* We set this in the realise function */
-    riscv_cpu_set_misa(env, MXL_RV32, 0);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -648,8 +634,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa(env, MXL_RV32,
-                       RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
@@ -667,7 +652,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVA | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -684,7 +669,7 @@ static void rv32_ibex_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_12_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -701,7 +686,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -926,7 +911,7 @@ static void riscv_cpu_reset_hold(Object *obj)
         mcc->parent_phases.hold(obj);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = env->misa_mxl_max;
+    env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1303,7 +1288,11 @@ static void riscv_cpu_post_init(Object *obj)
 
 static void riscv_cpu_init(Object *obj)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
     RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    env->misa_mxl = mcc->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -2281,7 +2270,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void riscv_cpu_class_init(ObjectClass *c, void *data)
+static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -2315,6 +2304,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_class_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+
+    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+}
+
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
                                  int max_str_len)
 {
@@ -2351,39 +2347,49 @@ char *riscv_isa_string(RISCVCPU *cpu)
     return isa_str;
 }
 
-#define DEFINE_CPU(type_name, initfn)      \
-    {                                      \
-        .name = type_name,                 \
-        .parent = TYPE_RISCV_CPU,          \
-        .instance_init = initfn            \
+#define DEFINE_CPU(type_name, misa_mxl_max, initfn)         \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_CPU,                           \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
-#define DEFINE_DYNAMIC_CPU(type_name, initfn) \
-    {                                         \
-        .name = type_name,                    \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,     \
-        .instance_init = initfn               \
+#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
-#define DEFINE_VENDOR_CPU(type_name, initfn) \
-    {                                        \
-        .name = type_name,                   \
-        .parent = TYPE_RISCV_VENDOR_CPU,     \
-        .instance_init = initfn              \
+#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_VENDOR_CPU,                    \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
-#define DEFINE_BARE_CPU(type_name, initfn) \
-    {                                      \
-        .name = type_name,                 \
-        .parent = TYPE_RISCV_BARE_CPU,     \
-        .instance_init = initfn            \
+#define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_BARE_CPU,                      \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, initfn) \
-    {                                         \
-        .name = type_name,                    \
-        .parent = TYPE_RISCV_BARE_CPU,        \
-        .instance_init = initfn               \
+#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_BARE_CPU,                      \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
@@ -2396,7 +2402,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
-        .class_init = riscv_cpu_class_init,
+        .class_init = riscv_cpu_common_class_init,
     },
     {
         .name = TYPE_RISCV_DYNAMIC_CPU,
@@ -2413,25 +2419,27 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .parent = TYPE_RISCV_CPU,
         .abstract = true,
     },
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,   rv32_base_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,        rv32_ibex_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31,  rv32_sifive_e_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34,  rv32_imafcu_nommu_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34,  rv32_sifive_u_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV32,  riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,   rv64_base_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51,  rv64_sifive_e_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54,  rv64_sifive_u_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,    rv64_sifive_u_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906,  rv64_thead_c906_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64, rva22s64_profile_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
 #endif
 };
 
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 5ab0abda19..0ae0c47df1 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -49,6 +49,7 @@ static const struct TypeSize vec_lanes[] = {
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     target_ulong tmp;
@@ -61,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return 0;
     }
 
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         return gdb_get_reg32(mem_buf, tmp);
     case MXL_RV64:
@@ -75,12 +76,13 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     int length = 0;
     target_ulong tmp;
 
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         tmp = (int32_t)ldl_p(mem_buf);
         length = 4;
@@ -214,11 +216,12 @@ static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
 
 static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     GString *s = g_string_new(NULL);
     riscv_csr_predicate_fn predicate;
-    int bitsize = 16 << env->misa_mxl_max;
+    int bitsize = 16 << mcc->misa_mxl_max;
     int i;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -310,6 +313,7 @@ static int ricsv_gen_dynamic_vector_xml(CPUState *cs, int base_reg)
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     if (env->misa_ext & RVD) {
@@ -326,7 +330,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  ricsv_gen_dynamic_vector_xml(cs, base_reg),
                                  "riscv-vector.xml", 0);
     }
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a7881de7f9..422e4f121c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1769,14 +1769,14 @@ static void kvm_cpu_accel_register_types(void)
 }
 type_init(kvm_cpu_accel_register_types);
 
-static void riscv_host_cpu_init(Object *obj)
+static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
 #if defined(TARGET_RISCV32)
-    env->misa_mxl_max = env->misa_mxl = MXL_RV32;
+    mcc->misa_mxl_max = MXL_RV32;
 #elif defined(TARGET_RISCV64)
-    env->misa_mxl_max = env->misa_mxl = MXL_RV64;
+    mcc->misa_mxl_max = MXL_RV64;
 #endif
 }
 
@@ -1784,7 +1784,7 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU_HOST,
         .parent = TYPE_RISCV_CPU,
-        .instance_init = riscv_host_cpu_init,
+        .class_init = riscv_host_cpu_class_init,
     }
 };
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 72fe2374dc..81cf22894e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -178,10 +178,9 @@ static const VMStateDescription vmstate_pointermasking = {
 
 static bool rv128_needed(void *opaque)
 {
-    RISCVCPU *cpu = opaque;
-    CPURISCVState *env = &cpu->env;
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
 
-    return env->misa_mxl_max == MXL_RV128;
+    return mcc->misa_mxl_max == MXL_RV128;
 }
 
 static const VMStateDescription vmstate_rv128 = {
@@ -372,7 +371,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
-        VMSTATE_UINT32(env.misa_mxl_max, RISCVCPU),
+        VMSTATE_UNUSED(4),
         VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
         VMSTATE_UINTTL(env.priv, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6574028414..d7639d8670 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -272,10 +272,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
-    CPURISCVState *env = &cpu->env;
 
     /* Validate that MISA_MXL is set properly. */
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -426,6 +425,7 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
  */
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
@@ -592,7 +592,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
-        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -600,7 +600,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
         if (riscv_has_ext(env, RVD)) {
@@ -608,7 +608,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    if (env->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -1307,7 +1307,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
+    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ab18899122..177418b2b9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1168,6 +1168,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu_env(cs);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
 
@@ -1189,7 +1190,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
-    ctx->misa_mxl_max = env->misa_mxl_max;
+    ctx->misa_mxl_max = mcc->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-- 
2.43.0



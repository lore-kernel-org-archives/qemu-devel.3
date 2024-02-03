Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7154BC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 10:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCzh-0007zJ-11; Sat, 03 Feb 2024 05:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzf-0007z3-PE
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:27 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCzd-0006xw-1U
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 05:11:27 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-363b2cc93a8so5579145ab.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 02:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706955084; x=1707559884;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+F1LWw/r966jjBiXwSFUY6rRadocxvwlwPzQCWG2aRg=;
 b=yigdEV+9OvWSphySE6/CKdK52k7TMWWAQkcNgW/XEnf80Vdh65fT/4s80wONRzAdkH
 KscBckxr2emDzor1g+kgcZqDxK3S7G4/wLyzWel5twZpFAG79cFWokjHTLeSMtxsH9ei
 ozFyM7LlTcCb6XFKbmwZ5sQxYc4IZWedXkVCOd6JXKe97TYTEqUVzxu1ZN34JdYriJ1Y
 6T2EtY9Kv9DR9x719UuksW2DOjyjOgKJLi8+JJlo/2j0qS71PICdLOvd1u2fNcJgE178
 G1HdWn8nZKg17TTiMlU76wFp64iknOAcMcaDAh3CXbgBHfHEl9kSebplHOD4tarh8fTK
 wuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706955084; x=1707559884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+F1LWw/r966jjBiXwSFUY6rRadocxvwlwPzQCWG2aRg=;
 b=YxVondNxVQVerZhP2MNUgV52YX19c1plciq3abjD/v5uSr0WpQIBJgNn4GEsjRTx4z
 ULVFQSjlJddvapGN09AH6FW/v2tvWCZTAI6QzImpRv7rnyDu3/xeEu41cyp+BEATdiWy
 +eaFfYY6iDQKevAOmzawC+b+B7C+hanIpb1dp4SkZDr/iiQPNhZu3hxUrlQTiN1xM6GY
 CrFLG/7e4KADkgHMRpy5J2UKjmrSGJIiNb0QN3TRZWTcjz33SRh8b7rgQYMQMTxl66uN
 PuIX0blmL6CCNL7khPgR1owb/jDzwlWeQTZfRc4xURxh98Cy4XsC008B9wXLZMYbUaFV
 EyyQ==
X-Gm-Message-State: AOJu0YwqelsW7iDbh87z4eTvtBnoF0S/uGNgOU6dAhCOJmpga4lGXcIr
 sSwiS3gW9EiR4mSKv6cjiZ6MRHoe71YMM0uLdAB8p2uxBt+EnQgjJNQcNit5T04=
X-Google-Smtp-Source: AGHT+IF6uZgc13aGeslsP2NX6Qm4gFZMhtsjMRNHTfCj04CVWf52RR464AmQlHQyJiAPaSKkvl4yRw==
X-Received: by 2002:a05:6e02:48c:b0:363:bdb9:5c02 with SMTP id
 b12-20020a056e02048c00b00363bdb95c02mr943910ils.8.1706955083786; 
 Sat, 03 Feb 2024 02:11:23 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU/66o723I4E1PchhOIUJaTnh5s1I0b24syxmEPxLzK5lCZmEtwTdzBqoJxwfFpIQScIm5xgCDLH6iLTv0L0ZXwlU0/J9AEDw719NNtjzIJnznyDdWZQNzxYkMdFFyxuf6VCwyhxSDIyZ7cIISXl4atE1px2of9RJLTCnT7YZVXWuYw3tkPxqIZiBvoGGjq4vsA0P536RcIVpWqi0rcgMA/Dabq1+OBCP3tN8FpmB294DfaDXjsqNCjRKQzSnhndmKc8PQFmG84/z4DP35Yfh3wR9PZoNWdx5CI4XlXrAfH/lioh0Z/C4d6Qj7VK9O8l9deK9iaA+fpxOaQfeV458EnxvhY1G7MMF5HBE3Q+oLyQRGVBo3H++bzbBWcapGDl+e+Y6K/eeHDLrdvJtGuJpjjvhaVL8PYh5E5dK0bDG6KYMDqv5E6l7AkvhKByCLBcjuTfyeDQezzZDnOtfq1
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 c17-20020a63ef51000000b005ce472f2d0fsm3117282pgk.66.2024.02.03.02.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 02:11:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 19:11:09 +0900
Subject: [PATCH v11 2/3] target/riscv: Move misa_mxl_max to class
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-riscv-v11-2-a23f4848a628@daynix.com>
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
In-Reply-To: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

misa_mxl_max is common for all instances of a RISC-V CPU class so they
are better put into class.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |   4 +-
 hw/riscv/boot.c            |   3 +-
 target/riscv/cpu.c         | 160 ++++++++++++++++++++++++---------------------
 target/riscv/gdbstub.c     |  12 ++--
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  12 ++--
 target/riscv/translate.c   |   3 +-
 8 files changed, 112 insertions(+), 99 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51381877273e..5c9577f1be7b 100644
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
@@ -783,7 +783,7 @@ enum riscv_pmu_event_idx {
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
-void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
+void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 bool riscv_cpu_is_vendor(Object *cpu_obj);
 
 typedef struct RISCVCPUMultiExtConfig {
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189f0..12f9792245a4 100644
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
index 88e8cc868144..c9d09d175510 100644
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
@@ -921,7 +906,7 @@ static void riscv_cpu_reset_hold(Object *obj)
         mcc->parent_phases.hold(obj);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = env->misa_mxl_max;
+    env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1298,7 +1283,11 @@ static void riscv_cpu_post_init(Object *obj)
 
 static void riscv_cpu_init(Object *obj)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
     RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    env->misa_mxl = mcc->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -2276,7 +2265,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void riscv_cpu_class_init(ObjectClass *c, void *data)
+static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -2309,6 +2298,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
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
@@ -2345,39 +2341,49 @@ char *riscv_isa_string(RISCVCPU *cpu)
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
@@ -2390,7 +2396,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
-        .class_init = riscv_cpu_class_init,
+        .class_init = riscv_cpu_common_class_init,
     },
     {
         .name = TYPE_RISCV_DYNAMIC_CPU,
@@ -2407,25 +2413,27 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
index 5ab0abda19a9..0ae0c47df13e 100644
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
index a7881de7f9eb..422e4f121c63 100644
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
index 72fe2374dc2a..81cf22894e0e 100644
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
index 94dca7e446eb..067f1493fea7 100644
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
index 071fbad7ef43..20dbc737d775 100644
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



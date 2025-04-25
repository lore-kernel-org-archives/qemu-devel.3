Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D54BC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVg-0006NH-EK; Fri, 25 Apr 2025 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVU-00060A-2V
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:28 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVR-0008Mj-Un
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:27 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af9925bbeb7so1867344a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596943; x=1746201743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhsGzjCzZNMLuckp1D05NC/RrQtQo2C3Pqgvn64jC2w=;
 b=Px9Qf6TjA5HlfKEbkv6SO1OdgwHYcmePVg2y9yX6G9oww3BPjC96CbmbJJiUkrg71K
 sHOo7XhSbGPRaMyAkJ7+NB+wpKUgSY/vpxT05ehgZ9UenlRfQ3GV60io2bmszbCcH1On
 2ODEsyBSCiBiM9pfCxaej3vXK0WuCBxuTWzP1fA2jfTrgOyjcmUK4/MQnGp+NSsrqAEI
 0ySaUYi+Xq1kjynEMQcrJ0UZq7nXAZ3s2hiD1V6Nks4wb7qmGrc9suyF6jCxoJS36MpL
 dDLfKPVZLZQ/QAibXHJccDoEiRrVw1BPrBCKzMyKBGrLfGCxrhhusmlKrTHNBiBR9S53
 cvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596943; x=1746201743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhsGzjCzZNMLuckp1D05NC/RrQtQo2C3Pqgvn64jC2w=;
 b=t7Ss6ZxCgUmeCGcVVpTpEHOLp2e/vCD1ygK+hppxPZDVpxsW0RyW93kYL9UFWeIaaT
 W6YGYN6OyAvhvYW5LAssMZnV8DIYQzL4/tDFFau+iYbAGSI7EcKpzyMyDc1FfdTxjj0H
 eRodSmbPjCJkMPOCpYdRil6xN52SYn0wQsRi5be99Oj0EITiS8C4lziYEE5+R070jxxi
 tokNhfSq2BX1gg0/3ERuEm2E6MN42Mr9noO2Lj3rdibUQ/NWqPYKL6uoMI/2/JNNm3SQ
 2RYKIIAsXf0SPAaQ343G6ZLzQNrMncsf3AxiqrF6Tp3xTwxKwhy3WDq6po/fSZfO4nNS
 HLsA==
X-Gm-Message-State: AOJu0YyjPXXmOWzLa/66Cmoxdnc1Qny2duY0OGcJK7AeLd+rzm3v1dyN
 98QnwnGj0rdZqW0w+gRM8egDF30TeDqeB2HWrBnRImBDvzCfmvUOrbXnLLEjtkc5sWiXnmyIdoq
 S
X-Gm-Gg: ASbGncu90MxruYlPVO0TAFw1HO34zuawTvMK/p09t5AsQGPLqgjssHwNKCTNClVM2lp
 Iny4qa4ZbxbKmwgMRjeaQN+S0RgksJsuigZVhpeoi0YWYuZ92VCEp7QK3kTwaHF7/SjjsnhEWg0
 /94TwqGWjH2pT2FVDOyh1iLOwAV4fFtgoE4fF+ZDMxY8U2K5LWSg4SBRuhC/ISTm3pFLMvgzNBj
 jx4ikBtWencYNUEjDS/IxvyW/VNsDich/d3LPx3qCa+CSbqltZbjYWKQNTFfg8RxSiDvb6wbEo6
 lpaTnS8zNumK7xql1mXW7UszUT4TZEYiJK7chJlYiUKnx+0fzdwHxCAWFA007L0/X8ra
X-Google-Smtp-Source: AGHT+IFcyaEjbPkygXqyM38bGO6X/O7Q0WiFM4SDaSI0+KCjBACzEhGuZ+AI8Qyzl1jBF5gD25MUNg==
X-Received: by 2002:a17:90a:e70b:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-30a01399551mr136496a91.23.1745596943215; 
 Fri, 25 Apr 2025 09:02:23 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:22 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 5/9] target/riscv/kvm: add kvm_csr_cfgs[]
Date: Fri, 25 Apr 2025 13:01:59 -0300
Message-ID: <20250425160203.2774835-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At this moment we're not checking if the host has support for any
specific CSR before doing get/put regs. This will cause problems if the
host KVM doesn't support it (see [1] as an example).

We'll use the same approach done with the CPU extensions: read all known
KVM CSRs during init() to check for availability, then read/write them
if they are present. This will be made by either using get-reglist or by
directly reading the CSRs.

For now we'll just convert the CSRs to use a kvm_csr_cfg[] array,
reusing the same KVMCPUConfig abstraction we use for extensions, and use
the array in (get|put)_csr_regs() instead of manually listing them. A
lot of boilerplate will be added but at least we'll automate the get/put
procedure for CSRs, i.e. adding a new CSR in the future will be a matter
of adding it in kvm_csr_regs[] and everything else will be taken care
of.

Despite all the code changes no behavioral change is made.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.h         |   1 +
 target/riscv/kvm/kvm-cpu.c | 121 ++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 679f417336..f5a60d0c52 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -79,6 +79,7 @@ const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
+#define ENV_CSR_OFFSET(_csr) offsetof(CPURISCVState, _csr)
 
 typedef struct riscv_cpu_profile {
     struct riscv_cpu_profile *u_parent;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index fd66bc1759..f881e7eb5d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -114,22 +114,6 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
-#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
-    do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
-        if (_ret) { \
-            return _ret; \
-        } \
-    } while (0)
-
-#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
-    do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
-        if (_ret) { \
-            return _ret; \
-        } \
-    } while (0)
-
 #define KVM_RISCV_GET_TIMER(cs, name, reg) \
     do { \
         int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
@@ -251,6 +235,53 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+#define KVM_CSR_CFG(_name, _env_prop, reg_id) \
+    {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .kvm_reg_id = reg_id}
+
+static KVMCPUConfig kvm_csr_cfgs[] = {
+    KVM_CSR_CFG("sstatus",    mstatus,    RISCV_CSR_REG(sstatus)),
+    KVM_CSR_CFG("sie",        mie,        RISCV_CSR_REG(sie)),
+    KVM_CSR_CFG("stvec",      stvec,      RISCV_CSR_REG(stvec)),
+    KVM_CSR_CFG("sscratch",   sscratch,   RISCV_CSR_REG(sscratch)),
+    KVM_CSR_CFG("sepc",       sepc,       RISCV_CSR_REG(sepc)),
+    KVM_CSR_CFG("scause",     scause,     RISCV_CSR_REG(scause)),
+    KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
+    KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
+    KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+};
+
+static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    return (void *)&cpu->env + csr_cfg->offset;
+}
+
+static uint32_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    return *val32;
+}
+
+static uint64_t kvm_cpu_csr_get_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    return *val64;
+}
+
+static void kvm_cpu_csr_set_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
+                                uint32_t val)
+{
+    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    *val32 = val;
+}
+
+static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
+                                uint64_t val)
+{
+    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    *val64 = val;
+}
+
 #define KVM_EXT_CFG(_name, _prop, _reg_id) \
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .kvm_reg_id = _reg_id}
@@ -598,34 +629,52 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
-    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+        ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+        if (ret) {
+            return ret;
+        }
+
+        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
+        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
+        } else {
+            g_assert_not_reached();
+        }
+    }
 
     return 0;
 }
 
 static int kvm_riscv_put_regs_csr(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+            reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
+        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+            reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
+        } else {
+            g_assert_not_reached();
+        }
 
-    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+        ret = kvm_set_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
 
     return 0;
 }
-- 
2.49.0



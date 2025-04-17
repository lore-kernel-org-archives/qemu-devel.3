Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3710EC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OgG-0008HA-LN; Thu, 17 Apr 2025 08:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofz-000875-B3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Oft-0004Vy-0w
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33677183so8333205ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744894137; x=1745498937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udaXqW5m1IhR0WZ9P2elT1+b0L+6qwUfLojl3p3QNQ4=;
 b=jH6jhzAVTrGkZ+0zdEI7SNeOZuuczZCxqbXjd6KOQj+H2lYVXdkmW37icJuma7gxnV
 UzrF67cK96Hcy04ZRIjFFHcqOszc3NQ0GcuGw+6t9exhWGw0FfvogIiLKZwVDqluyZ1C
 Nwccf1DChO0jxvwcPHrqm37Ihhps9AkN36IPCmOJS7dMXygEx52DhmuWuqLmaa8sIH1h
 1dq9sMwSDrqPNkoPrIUGvQNHRWsdC9mX2tApfyD3LyLfxs2Nn1iZ3iqFHzdM4Bihym69
 oXyGa4/SUb5q7c4zPEYPhxiYoRHgs/VyMQNNRByxvNwnpV7dtrI0lw35xMmcyvR1Gqyx
 G09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894137; x=1745498937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udaXqW5m1IhR0WZ9P2elT1+b0L+6qwUfLojl3p3QNQ4=;
 b=qIa27BCrVV9LHnRCqJiN0cYs+N2PSlbfEYNON66xlT90BWp5TuZqZRoa6XTBwHtJBG
 sidvAhYX9tvjvKb/ofcKLvnBkIy4vTu2I64FobKSaq9+UvGrNVPSuL/3C91cjPYitqb3
 v6fj/q+8EfFF7k3mYxSzkssEGpmoLU65zApBv5OKsX6fsAZUyK3aI/4JFkjdgo44HS2w
 y6QO00VXNQhGPLTB8hZmNb4hBLAtfKgni/hxkbjlShYQ0fkOu49tt2xxxCmKUR4vRyTH
 qXUpLoCGVobPYc9IAY5Gb4A/4spl+9kUvJL3/BRWW/VqUTlV7XJQqTMMH3GeCidqFSBs
 8lvA==
X-Gm-Message-State: AOJu0YwVR6Pd6mLXe13h6g8ntSNXRRyBR/xO3mnU1watIeqa6SgKqpV2
 sCcAfAgZ0QsvjamVXhwR8S/QX9uNDFxCDZp50jn7N/XXeyvh7kTkKbAGh89eLj8iNXBkvQ8OzlT
 Q
X-Gm-Gg: ASbGncsjI7YsaSz2H/HjkdKr243FmjXmCFyLes7IQr6WcBYmY2EbUTFP1GY7pc+08hm
 mUW+ew5ZMB1Vp0sGI7q0SO7TPFN+y0WO132pB6LNfMj+l4ek/puEuisHZB8wYi4cVjpdXBDHxyS
 E2VPg5nnZ39vb6hjYpPFkc+MYMci1fQ+ywNGPBc1mpv3+g5la+HHkWBEDxwU8HJOK/sVutCOGAx
 Uk0ka1We4xMym4QLQL17xDXtavayeAP/+j6yrJiXsMZx2zPOsNSooAjnxCewubqLp6EG7do02ku
 4dUD5GwaUrz5Tn/29JAP4tDiYiaTUU4foWiQbUEqXJZGNU++uET/gWmCRbnLz28lZiKZ
X-Google-Smtp-Source: AGHT+IG1w6i4fqSroOE+SK4HgXDk48V09CBSMeY3RdcMX2BuJEDHyAxF9P+nI19+0AZuktuX7iGuJA==
X-Received: by 2002:a17:902:ea06:b0:224:c46:d14b with SMTP id
 d9443c01a7336-22c35983c51mr80740845ad.52.1744894137240; 
 Thu, 17 Apr 2025 05:48:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm32175065ad.239.2025.04.17.05.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:48:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, abologna@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/7] target/riscv/kvm: add kvm_csr_cfgs[]
Date: Thu, 17 Apr 2025 09:48:36 -0300
Message-ID: <20250417124839.1870494-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/cpu.h         |   1 +
 target/riscv/kvm/kvm-cpu.c | 119 ++++++++++++++++++++++++++-----------
 2 files changed, 84 insertions(+), 36 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..7a56666f9a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -79,6 +79,7 @@ const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
+#define ENV_CSR_OFFSET(_csr) offsetof(CPURISCVState, _csr)
 
 typedef struct riscv_cpu_profile {
     struct riscv_cpu_profile *u_parent;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0bcadab977..99a4f01b15 100644
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
@@ -150,6 +134,7 @@ typedef struct KVMCPUConfig {
     const char *name;
     const char *description;
     target_ulong offset;
+    uint32_t prop_size;
     uint64_t kvm_reg_id;
     bool user_set;
     bool supported;
@@ -251,6 +236,54 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+#define KVM_CSR_CFG(_name, _env_prop, _env_prop_size, reg_id) \
+    {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .prop_size = _env_prop_size, .kvm_reg_id = reg_id}
+
+static KVMCPUConfig kvm_csr_cfgs[] = {
+    KVM_CSR_CFG("sstatus", mstatus, sizeof(uint64_t), RISCV_CSR_REG(sstatus)),
+    KVM_CSR_CFG("sie", mie, sizeof(uint64_t), RISCV_CSR_REG(sie)),
+    KVM_CSR_CFG("stvec", stvec, sizeof(target_ulong), RISCV_CSR_REG(stvec)),
+    KVM_CSR_CFG("sscratch", sscratch, sizeof(target_ulong),
+                RISCV_CSR_REG(sscratch)),
+    KVM_CSR_CFG("sepc", sepc, sizeof(target_ulong), RISCV_CSR_REG(sepc)),
+    KVM_CSR_CFG("scause", scause, sizeof(target_ulong), RISCV_CSR_REG(scause)),
+    KVM_CSR_CFG("stval", stval, sizeof(target_ulong), RISCV_CSR_REG(stval)),
+    KVM_CSR_CFG("sip", mip, sizeof(uint64_t), RISCV_CSR_REG(sip)),
+    KVM_CSR_CFG("satp", satp, sizeof(target_ulong), RISCV_CSR_REG(satp)),
+};
+
+static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    return (void *)&cpu->env + csr_cfg->offset;
+}
+
+static uint64_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
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
@@ -598,34 +631,48 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
 
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
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
+        } else {
+            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
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
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
+            reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
+        } else {
+            reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
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



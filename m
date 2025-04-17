Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7CCC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OgL-0008Lc-QY; Thu, 17 Apr 2025 08:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Og5-00088Z-0H
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofv-0004WF-6F
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22401f4d35aso8806875ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744894140; x=1745498940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTNoXE7RSRnEef5D4Bv3/4CVSyZWZyDxusM8VBgQG10=;
 b=Ae3A5siNaNopRHztmduIRwfsPXsZNFXVT2vh5QtiO/Rqy4GBfySAO0XEoCSHTpQoso
 Wv0rYThqGZ3kztRDwk+l9TqhiT21E0g/h8cqNHkymmsRvtBmTq4t9T8Leb2VILqTSuLq
 btmj1LYBpLzFCkvFddsZ5ekcx3DuSDj+avL8Y7z2qXxTDh8JuXb6m2IEu6agNFgLK5QQ
 OT8L1KUxoKt1MJ8ptslXy8GWOQMkH3RI+dMISHC/6cSjqWVpYDZMRqfpP9e53Q87bsxn
 Y3dJ1hGdlD41Ov/5dyOb8SaK1gK2eGp6XIGPsu5kD2q9npDnzJ5HqbxyGmx6/3CgRH0l
 aGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894140; x=1745498940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTNoXE7RSRnEef5D4Bv3/4CVSyZWZyDxusM8VBgQG10=;
 b=HDQE31D/ixOY6M2MeWKSgbZfNmbV+frs90V25RM7EWnwCyF3jD+VpJQnhoBXdC/FGK
 HtkxcHI75LjiS4NEIJi1h3AYRF1B/a6fm2Udsc3/0aEpLSw6dJYRBuneTi8LQDPIjtZ9
 ax9sHcGlh4dRHdRZHVcj0dAlSCsQFnm7VoaNVcjrIBDDUN1tcWupqEUrz1xBJKXVxbrO
 DWFiFBznhEO3DOZ0cp5d+6Ae5439gmWb16Z2dW/UaFFOcO8JSU0HkXVxMz+oXYUm9dDB
 YQExlItGLmE6+JurdytY7zK5jEw7zKpx+iMc3KPjDP6s+PJvea/clsXa4MTZu8z+HQTe
 cT2w==
X-Gm-Message-State: AOJu0YxpTDmCQKrP+X/oOvaFRBEiJCEKeBi8Lf/dgt6PVBjcI66zCNZh
 JIYfQ0jhn61CvFOEg2ZNApGjCJm0Bx8UxeKqx2B8odMUbni0t48W01CgNmV8btFhFZ35IXDbfut
 m
X-Gm-Gg: ASbGncv70C6VSYxu1HREAkgxvPY42pP5RlC0Qid2OptPNkvl8MTTtie41ZqC5JEaQTa
 W9L+lrpd/ggpTkphgtSZEXtPsTlZgHgH7s9BNfoG0u3GSJ9812jeAZNeXk1joTREPHTzxx5AgMH
 djGEI63x2xWT1PdyQeD8G4t4CfV3hHe/binI5zAKgwCaksmG2IIxcdwi71nVR0tlPRrV51mugE8
 stjWx2dCsebh5CMgCukFn6wPN75HRnYbk3G9TlnRhcLtBflU3X1cqtaPYx3QiKGTptHt2fbCOFE
 9iVfR9hXkqvaBsyog+r6VHL/JiGyrBeg6nu+IYyzZM/Cbx++7+oF+RvDH0tZzDU8gyPP
X-Google-Smtp-Source: AGHT+IETiMhgrBfXzVVA9oDw4KyeBXVhcYrJuEPY6mU1js+KO1kCtt4fpS2z93SygiuXY0b9jef0Hw==
X-Received: by 2002:a17:903:1a44:b0:223:5e76:637a with SMTP id
 d9443c01a7336-22c35909c6amr87263005ad.23.1744894140134; 
 Thu, 17 Apr 2025 05:49:00 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm32175065ad.239.2025.04.17.05.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:48:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, abologna@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/7] target/riscv/kvm: do not read unavailable CSRs
Date: Thu, 17 Apr 2025 09:48:37 -0300
Message-ID: <20250417124839.1870494-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

[1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
This happens because the kernel does not know 'senvcfg', making it
unable to boot because QEMU is reading/wriiting it without any checks.

After converting the CSRs to do "automated" get/put reg procedures in
the previous patch we can now scan for availability. Two functions are
created:

- kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
  forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
  return as indication that the CSR isn't available. This will be use in
  absence of KVM_GET_REG_LIST;

- kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
  to check if the CSRs ids are present.

kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_multiext_csr_cfg()
to reflect that the function is also dealing with CSRs.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 63 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 99a4f01b15..ec74520872 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -638,6 +638,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
         if (ret) {
             return ret;
@@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         if (csr_cfg->prop_size == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
         } else {
@@ -1088,6 +1096,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
     }
 }
 
+static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
+{
+    uint64_t val;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+        struct kvm_one_reg reg;
+
+        reg.id = csr_cfg->kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            if (errno == EINVAL) {
+                csr_cfg->supported = false;
+            } else {
+                error_report("Unable to read KVM CSR %s: %s",
+                             csr_cfg->name, strerror(errno));
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            csr_cfg->supported = true;
+        }
+    }
+}
+
 static int uint64_cmp(const void *a, const void *b)
 {
     uint64_t val1 = *(const uint64_t *)a;
@@ -1144,7 +1178,27 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     }
 }
 
-static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
+{
+    struct kvm_reg_list *reg_search;
+    uint64_t reg_id;
+
+    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        reg_id = csr_cfg->kvm_reg_id;
+        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
+                             sizeof(uint64_t), uint64_cmp);
+        if (!reg_search) {
+            continue;
+        }
+
+        csr_cfg->supported = true;
+    }
+}
+
+static void kvm_riscv_init_multiext_csr_cfg(RISCVCPU *cpu,
+                                            KVMScratchCPU *kvmcpu)
 {
     KVMCPUConfig *multi_ext_cfg;
     struct kvm_one_reg reg;
@@ -1161,7 +1215,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
      * (EINVAL). Use read_legacy() in this case.
      */
     if (errno == EINVAL) {
-        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
+        return;
     } else if (errno != E2BIG) {
         /*
          * E2BIG is an expected error message for the API since we
@@ -1224,6 +1280,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 
     kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
+    kvm_riscv_read_csr_cfg(reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1237,7 +1294,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
 
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
-    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_multiext_csr_cfg(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
-- 
2.49.0



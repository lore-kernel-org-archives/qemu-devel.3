Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F98C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOdG-00073P-MM; Fri, 09 Feb 2024 06:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcW-0005zN-79
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:37 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcQ-0000e2-UN
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:35 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e1226b30ffso427645a34.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476423; x=1708081223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8tr+WXOrEk5pb63eZlupsCIEJrSrl4qAWqhAIUU3bg=;
 b=MgQCqPG9cTHV50diF7WSymVsL0ufa9t52ltWJsCrY3wsOmPWJS+SBdUmfwpWEoJKhb
 np39xgGw+8dKyH9AOYuBlfpCz3LLNYcImAevPQZ0bdR5CMrDMoclqX8W/y4D+3MB9ktl
 efFnmLtyCyEqy3jsZvoPrWiFoYdlelyIC7o3wigGXDWom2hzOO47A/NtCXG5kJ9/kLD0
 SBPB3LYcWTREORT7jO4dljYtmje1hJa3hCtSIIuLNFbFkomo/sCVcf9xOeueGwxfRMLN
 CvbMI+3F05zS+DLkNjsz+2GvLrEkXaU3LTdF0PG7kdJvxg7tRBzECEtXD0M+1XmcAPy+
 JUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476423; x=1708081223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8tr+WXOrEk5pb63eZlupsCIEJrSrl4qAWqhAIUU3bg=;
 b=E+9/U7EjjwX7xdeZTVPkLGMdYO5tNDDOIHCMC77q43kF1S1oWFGh+j9x62y03HxcH5
 hZepFsoNKBqdyqz92fPu1qMwEVp2r72Q9dFEQHDJKXN4yO2mMfw08ywsO9b13pSNiyhx
 cDNrXZB/bI8JkHqFwdq09Rj1e9YhHXMrPhj38JZfpV54Pa277K7ZYehFDjzXBfKku4vo
 B7OPG2jpRCWeFKuBwPTDEDf+LriD50PICVmp1Gy8Cm3mxhGqlybbXBOYilxcYQ96/bof
 Ezo18Oya82bggdNugYOXnZtMs0FAy+wUuMST5nCTZmAmo9oRxDcenoV2stXgNAB2GhQJ
 DZ+w==
X-Gm-Message-State: AOJu0YwpHr8hjCg4SdRoqpl7jbiiS1E5u2LCLdwp5jpaRUdYC+E3ia9C
 fSuCJ0r/xNYoj/YXWg5B9589eIJGBypxz8C3HE6e+r+y1U2UDWCuYQ3I/24Q77/Alw==
X-Google-Smtp-Source: AGHT+IFKggo8hgT7hSXy6hUsmGD6YDYoZr+G/CBq8cWq7aKf3xj/IwMH0Z/pEH8fl7fLon4y1soLCA==
X-Received: by 2002:a05:6358:c83:b0:178:98c8:9d76 with SMTP id
 o3-20020a0563580c8300b0017898c89d76mr1145423rwj.26.1707476423122; 
 Fri, 09 Feb 2024 03:00:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXtA35QJv2ySxNR2bB32sj7JsNjuftEvpNTCb3//c4FSmpI4ERc7Rv3i087Q3o9jXAvUx8Wf3uYLUy8ndIcIzsjdsWDMOiu7sxMP7oJYPa2/9hBEk+7Mni2PlyPhjKIxdP6Ghs=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/61] target/riscv/kvm: initialize 'vlenb' via get-reg-list
Date: Fri,  9 Feb 2024 20:57:48 +1000
Message-ID: <20240209105813.3590056-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x333.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

KVM will check for the correct 'reg_size' when accessing the vector
registers, erroring with EINVAL if we encode the wrong size in reg ID.
Vector registers varies in size with the vector length in bytes, or
'vlenb'. This means that we need the current 'vlenb' being used by the
host, otherwise we won't be able to fetch all vector regs.

We'll deal with 'vlenb' first. Its support was added in Linux 6.8 as a
get-reg-list register. We'll read 'vlenb' via get-reg-list and mark the
register as 'supported'. All 'vlenb' ops via kvm_arch_get_registers()
and kvm_arch_put_registers() will only be done if the reg is supported,
i.e. we fetched it in get-reg-list during init.

If the user sets a new vlenb value using the 'vlen' property, throw an
error if the user value differs from the host.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240123161714.160149-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 85 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 902180e8a5..3812481971 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -352,6 +352,13 @@ static KVMCPUConfig kvm_cboz_blocksize = {
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
+static KVMCPUConfig kvm_v_vlenb = {
+    .name = "vlenb",
+    .offset = CPU_CFG_OFFSET(vlenb),
+    .kvm_reg_id =  KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_VECTOR |
+                   KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)
+};
+
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
     CPURISCVState *env = &cpu->env;
@@ -684,7 +691,8 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
 
 static int kvm_riscv_get_regs_vector(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     target_ulong reg;
     int ret = 0;
 
@@ -710,12 +718,21 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     }
     env->vtype = reg;
 
+    if (kvm_v_vlenb.supported) {
+        ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+        if (ret) {
+            return ret;
+        }
+        cpu->cfg.vlenb = reg;
+    }
+
     return 0;
 }
 
 static int kvm_riscv_put_regs_vector(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     target_ulong reg;
     int ret = 0;
 
@@ -737,6 +754,14 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
 
     reg = env->vtype;
     ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    if (kvm_v_vlenb.supported) {
+        reg = cpu->cfg.vlenb;
+        ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+    }
 
     return ret;
 }
@@ -921,6 +946,33 @@ static int uint64_cmp(const void *a, const void *b)
     return 0;
 }
 
+static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
+                                 struct kvm_reg_list *reglist)
+{
+    struct kvm_one_reg reg;
+    struct kvm_reg_list *reg_search;
+    uint64_t val;
+    int ret;
+
+    reg_search = bsearch(&kvm_v_vlenb.kvm_reg_id, reglist->reg, reglist->n,
+                         sizeof(uint64_t), uint64_cmp);
+
+    if (reg_search) {
+        reg.id = kvm_v_vlenb.kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_report("Unable to read vlenb register, error code: %s",
+                         strerrorname_np(errno));
+            exit(EXIT_FAILURE);
+        }
+
+        kvm_v_vlenb.supported = true;
+        cpu->cfg.vlenb = val;
+    }
+}
+
 static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     KVMCPUConfig *multi_ext_cfg;
@@ -995,6 +1047,10 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
+
+    if (riscv_has_ext(&cpu->env, RVV)) {
+        kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
+    }
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1566,7 +1622,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     int ret;
 
     /* short-circuit without spinning the scratch CPU */
-    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz) {
+    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
+        !riscv_has_ext(env, RVV)) {
         return;
     }
 
@@ -1613,6 +1670,28 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    /* Users are setting vlen, not vlenb */
+    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
+        if (!kvm_v_vlenb.supported) {
+            error_setg(errp, "Unable to set 'vlenb': register not supported");
+            return;
+        }
+
+        reg.id = kvm_v_vlenb.kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg(errp, "Unable to read vlenb register, error %d", errno);
+            return;
+        }
+
+        if (cpu->cfg.vlenb != val) {
+            error_setg(errp, "Unable to set 'vlen' to a different "
+                       "value than the host (%lu)", val * 8);
+            return;
+        }
+    }
+
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
-- 
2.43.0



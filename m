Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675D4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRz9-00053A-3o; Thu, 18 Apr 2024 09:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rxRz7-000525-Jo
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:39:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rxRz5-00025z-Hx
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:39:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-347c6d6fc02so126558f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713447566; x=1714052366;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrM/ng6nAhBYvP+9WXpoWnqe8/L1gEhRX1pjDUM4u8w=;
 b=vD576SW4nyzUI5zIY6HQdYYDdWHRHPweaoUp9/EYLkfv0DpvfnbsX5pKx9JIeXoHws
 6JVgQ0T2ytJLFcSIVPibgoNmTfLLb9ylIBvg8ERPVP0cT2Kn1rEs+4Ie+X72t7F7+dd2
 vPH+p27whQ5+RslQwfIZhpqygd/oMd24pvUcEshDBlWkQllnBGyfvykvKXnQXPsIPvRV
 iwxcLaNIUkqukwsPRH7ah5OgE2vnwQskNzl7/yXbSfmaj+SgAasyGSEYC+TPgpW1kUH9
 uwyW57bU7qKrR0lAAEIC2xfiAb6GCdS4egWII/xbHFw3Nvv88vx79/cKQR2ddMvhTNmG
 YlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713447566; x=1714052366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrM/ng6nAhBYvP+9WXpoWnqe8/L1gEhRX1pjDUM4u8w=;
 b=OPFVQp+0Dye+ftoQVB35yrdf3PJTQIxgUkIhfknZ9OCbRx1JQ/jGqOrJMrHiI5gPk4
 e5SIKlHpPrLCUTFyMTqW1oH1H5/4icRTn5rnauDL/3BV7jWCQPCFpFtZ0HYw/SvJGRpp
 2YvRgD9F1ynyAuK94BMVaH41iZkeDV3enTsj9gcqGd0xhW5fD7PIUWULU5kiaSIAElX0
 +2BZmIM4eM/bFFpiMBsRBFg4Ud/E8sIriE1S5SCltfj26AtXzJ56KdOmMyS2h3VExlny
 VDNG7/n7aNjjVvJ0kecNTyQx0xMqlIstJShRhXk5YtL9vhnWZc9rxW+o3l++15gcU08t
 pLUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkCEGfTqdYXz81HTibt7gRaQHiJUfY2o537iBSpTHAnvPMtKMRc4sJ4YfFj1tZS0nZ+iQtQA3Q5NA8e1218vZNDGNLHiA=
X-Gm-Message-State: AOJu0YwnCS2gSFCkew+Xy3LoMTgEki/e+S8rNme3FrMrZKxOZ6z9vcre
 Po2+PX8xKdyMf6niGdB41hp5QMjmPFfeNq6yKfWQHm6y3p3yoFwBJZFdN8GghqfAqeJVcJvz4Hl
 5DW0=
X-Google-Smtp-Source: AGHT+IEP4ek/5m4WhGkJQA3sOLeNTlx12O6AxG3WlYydEEzPVyT7hRFBsBRpvd1+hAHL0lk+Bwloqg==
X-Received: by 2002:a05:600c:35ca:b0:418:9941:ca28 with SMTP id
 r10-20020a05600c35ca00b004189941ca28mr2013226wmq.2.1713447566158; 
 Thu, 18 Apr 2024 06:39:26 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
 by smtp.gmail.com with ESMTPSA id
 je12-20020a05600c1f8c00b004183edc31adsm6554015wmb.44.2024.04.18.06.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 06:39:24 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] target/riscv: add Smdbltrp extension support
Date: Thu, 18 Apr 2024 15:39:15 +0200
Message-ID: <20240418133916.1442471-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418133916.1442471-1-cleger@rivosinc.com>
References: <20240418133916.1442471-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The Smdbltrp extension allows to generate M-mode targeted double trap
exceptions [1]. Such exceptions are generated if a trap is taken while
mstatus.sdt is set to 1. The specification states that if the Smnrmi
extension is implemented, then the hart enters a critical-error state
and generate a critical-error signal. Since there is no Smrnmi support,
the implementation generates a cpu abort.

Link: https://github.com/riscv/riscv-double-trap/releases/download/v0.56/riscv-double-trap.pdf [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c        |  5 +++++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c |  6 ++++++
 target/riscv/csr.c        | 12 ++++++++++++
 target/riscv/op_helper.c  |  3 +++
 6 files changed, 28 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d159b0c6b6..98f04ecb8c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -176,6 +176,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_12_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
@@ -954,6 +955,9 @@ static void riscv_cpu_reset_hold(Object *obj)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
@@ -1574,6 +1578,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-ssdbltrp", ext_ssdbltrp, false),
+    MULTI_EXT_CFG_BOOL("x-smdbltrp", ext_smdbltrp, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 494a036f6e..660f2eed5b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -545,6 +545,7 @@
 #define MSTATUS_SDT         0x01000000 /* Ssdbltrp extension */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x200000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a149c08167..cf6a802502 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -75,6 +75,7 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3d747e5bfc..5ce0982f2f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1862,6 +1862,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            if (env->mstatus & MSTATUS_MDT)
+                cpu_abort(CPU(cpu), "M-mode double trap\n");
+
+            s = set_field(s, MSTATUS_MDT, 1);
+        }
         env->mstatus = s;
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         if (smode_double_trap) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1a2e739947..200b06e320 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1363,6 +1363,7 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
 static RISCVException write_mstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mstatus = env->mstatus;
     uint64_t mask = 0;
     RISCVMXL xl = riscv_cpu_mxl(env);
@@ -1396,6 +1397,12 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (cfg->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0)
+            mask &= ~MSTATUS_MIE;
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1434,6 +1441,11 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0)
+            mask |= MSTATUS_MIE;
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 468ee58a00..d289d14237 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -354,6 +354,9 @@ target_ulong helper_mret(CPURISCVState *env)
     mstatus = set_field(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
-- 
2.43.0



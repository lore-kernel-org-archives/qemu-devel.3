Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B2606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UyvV4oC/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5Gn-00077I-Dm; Thu, 19 Nov 2026 11:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5G8-0006vl-DX
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:21 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1xU5G5-00025L-72
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:45:15 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2f02f04a426so7083775ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795106712; x=1795711512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3xraGdr2alF8MMz20FS//SLWAloaioYB+YrXGRPJ3wo=;
 b=UyvV4oC/hq4zjYMwA7Ps2uaiOyqC2xQuN3iX7RTbLqUNbvd4wolWFQyRdK8mqAnLxF
 JcQHnJVfGM/uAD0VNIPb+Y20Zy6RgjVZnjn1gZQH4x4QrvZrnPzUkSYsVc6LiOptRMIy
 uFeEe4zDmthEI3ymS8wzwG3QrJK4Ghea8m3qbvF1p02/C7h9MXla4+TqW1Bh/DbMHCVY
 Ws/Y2sEDAmDXxLyxBmfzWfs527x2xK4dfgBBN1ja7dozW07Kl/+iebdveBL9EvXIJSlR
 mHsOvj9erXJj/XlQbmRMv76lZB/QuCr1fynCAfuiAxCEKBLLjE2HBBQJXKDHJPaU3+lI
 COFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106712; x=1795711512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3xraGdr2alF8MMz20FS//SLWAloaioYB+YrXGRPJ3wo=;
 b=oB+sBXTvrjY7L9XPftmDL63NGywE/JeYyQN4tdY5bts7iGo/zWu0eCTAak5HkRv9c0
 pfsEmNjrrlyaij6sfovAzR1eb48e4cNavje5hxYsUaI8SM6p6S8PHpF6xHvMZIoeChpa
 7keJczqwqDnGuIjf5ubMldLxIVhMr4Tlc4hzCCIyxkrfCKNLblcZlWu+faf37bTH1+KN
 Zu0QbqUX1KtWSanT/1XtjePvYZXxkAllkad4QmMEycduongl2JgwHTBBOvWRx+s1wloN
 aaL38etFnUcoJfrLdVKC7uUQX/o9LWKLaNLtuqs8xAyAzuAramNBrrCQF6APebBUEl39
 MjQw==
X-Gm-Message-State: APuU4Z/nWIIZG2LJp9rBQnuVvCtA31sN17rCMc0rSTLs2C5r5NuzOLRG
 Ry2m8y0yHqrnmMiHdFv/XGd0MR4MqpMUdAA7rbEE6G3/RQm0dbcmVuBuU09G6g==
X-Gm-Gg: AZFdTZdPUNW05PKtFt4MS7Dhx4NgsbFQNpPp/3kIB6tNl4gxEOVRjlTldSOmxOfkJ5P
 OxdL4/UPvoX6YsRVe47kyk6x7wETrbxHmrE0lX4jFJGylJdJ8e+AWDAkN8CxjQqynSdtEXS6b4p
 L4ZXO3z/nGly2E8suKW0R+2RCZPzFIMu6APkKT8KB9OiXVU9/IVlCelb+eGzrKzdWxpcHuQH7Kj
 Jq7sAdCTM5WRxsTbMUT3NnZ6xKPoZ+q7eNfmLnF2aORKYJG8oOFhBvsGaQwKDmdwWspMEMMY8wA
 JbA30q2ogt0IA3c+TQtH48h8hkMrXE6/kx1rGWohPtscjabTVfHsjY0BwUqjd+2Ox7/0ktdORg3
 K6hAyCTePw3VnazwgvCYWn7K7N+IOP+bjlWp/TMEKjjqesSEJwtdtAcDlM2eVKwZYwaYx9hESf8
 qfs4dX4MVlS2QK+4g3fBTWbE2rXSUeWr128I/XO8+kLGbCG3jQYDi5E5PWe4zECRGg4WXdMHqO8
 wmFj0om8WxwhNOyYnNRh+frBUDlA7Be2oZdBmihu2FmzED1+87f5O4KMeyLLNTofxkylAXSpyep
 xqLPfW744vxTP1iO8DPpbOD6Az3nMMm6WWDQ7PKQJBpmhq88Mtx3gTMnQnZsTVnf7Y+EQ0VI6cQ
 =
X-Received: by 2002:a17:902:d50e:b0:2ef:e1a8:ef1e with SMTP id
 d9443c01a7336-2f03efb01b8mr4820315ad.8.1795106711632; 
 Thu, 19 Nov 2026 08:45:11 -0800 (PST)
Received: from fedora ([61.74.238.173]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f10e67csm2381365ad.53.2026.11.19.08.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:45:11 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 1/3] target/riscv: Split out riscv_compute_tb_flags
Date: Fri, 20 Nov 2026 01:44:36 +0900
Message-ID: <20261119164438.193579-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119164438.193579-1-suunj1331@gmail.com>
References: <20261119164438.193579-1-suunj1331@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=suunj1331@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the computation of TB flags derived from state that changes on
CSR writes, traps, privilege changes and vsetvl into
riscv_compute_tb_flags(). Continue to read FS/VS, elp, vstart and vl
in riscv_get_tb_cpu_state(), since they can change between lookups.

The lookup calls the new helper directly, preserving the TB flag
values. The helper returns UINT32_MAX when maxsz is below the 8-byte
gvec minimum, so the vl comparison leaves VL_EQ_VLMAX clear in the
same cases as the previous maxsz >= 8 check.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 target/riscv/tcg/tcg-cpu.c | 101 +++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 32 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5834ec1524..5c5d8fcb94 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -99,13 +99,20 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
+/*
+ * Compute the TB flags that depend only on state changed through CSR
+ * writes, traps, privilege changes and vsetvl.  For now the result is
+ * fed straight back to riscv_get_tb_cpu_state(), which adds the bits
+ * that translated code changes between two lookups -- FS/VS dirtying,
+ * elp, vstart, and vl, which fault-only-first loads shrink.
+ */
+static void riscv_compute_tb_flags(CPURISCVState *env, uint32_t *pflags,
+                                   uint64_t *pext_flags, uint32_t *pvlmax)
 {
-    CPURISCVState *env = cpu_env(cs);
     RISCVCPU *cpu = env_archcpu(env);
-    RISCVExtStatus fs, vs;
     uint32_t flags = 0;
     uint64_t ext_flags = 0;
+    uint32_t vlmax_cached = UINT32_MAX;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env, false);
 
     if (cpu->cfg.ext_zve32x) {
@@ -124,49 +131,93 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
         uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
         uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
         uint32_t maxsz = vlmax << vsew;
-        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
-                           (maxsz >= 8);
+
+        /* vl is compared per lookup: fault-only-first loads shrink it. */
+        vlmax_cached = maxsz >= 8 ? vlmax : UINT32_MAX;
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
         flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
                            FIELD_EX64(env->vtype, VTYPE, VLMUL));
-        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
         flags = FIELD_DP32(flags, TB_FLAGS, VTA,
                            FIELD_EX64(env->vtype, VTYPE, VTA));
         flags = FIELD_DP32(flags, TB_FLAGS, VMA,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
-        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
         ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
 
     if (cpu_get_fcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+    }
+
+    if (cpu_get_bcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+    }
+
+#ifndef CONFIG_USER_ONLY
+    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
+    flags |= riscv_env_mmu_index(env, 0);
+
+    if (env->virt_enabled) {
+        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
+    }
+
+    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
+        && !icount_enabled()) {
+        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
+    }
+#endif
+
+    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
+    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
+
+    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
+                           mo_endian_env(env) == MO_BE);
+
+    *pflags = flags;
+    *pext_flags = ext_flags;
+    *pvlmax = vlmax_cached;
+}
+
+static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
+{
+    CPURISCVState *env = cpu_env(cs);
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVExtStatus fs, vs;
+    uint32_t flags, vlmax;
+    uint64_t ext_flags;
+
+    riscv_compute_tb_flags(env, &flags, &ext_flags, &vlmax);
+
+    if (cpu->cfg.ext_zve32x) {
+        bool vstart_eq_zero = env->vstart == 0;
+
+        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX,
+                           vstart_eq_zero && env->vl == vlmax);
+        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, vstart_eq_zero);
+    }
+
+    if (FIELD_EX32(flags, TB_FLAGS, FCFI_ENABLED)) {
         /*
          * For Forward CFI, only the expectation of a lpad at
          * the start of the block is tracked via env->elp. env->elp
          * is turned on during jalr translation.
          */
         flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
-        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
-    }
-
-    if (cpu_get_bcfien(env)) {
-        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
     }
 
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
 #else
-    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
-
-    flags |= riscv_env_mmu_index(env, 0);
     fs = get_field(env->mstatus, MSTATUS_FS);
     vs = get_field(env->mstatus, MSTATUS_VS);
 
     if (env->virt_enabled) {
-        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
         /*
          * Merge DISABLED and !DIRTY states using MIN.
          * We will set both fields when dirtying.
@@ -181,27 +232,13 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
-        && !icount_enabled()) {
-        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
+    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
     }
 #endif
 
     flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
-    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
-    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
-    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
-    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
-
-    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
-    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
-                           mo_endian_env(env) == MO_BE);
-#ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
-        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
-    }
-#endif
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
-- 
2.52.0



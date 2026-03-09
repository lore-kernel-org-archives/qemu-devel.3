Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C09FCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziep-00036Z-Cg; Mon, 09 Mar 2026 18:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziek-000332-1K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:55 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzieg-0004XV-3V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:51 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79885f4a8ffso97379427b3.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093649; x=1773698449; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hY60D7v/rxDcBw9h5eZwOSrkKI4gGjyHlv1OUyQA2c0=;
 b=kGk2vRkdMN1AWbqPDUDuLVnakRymI4HTufqQLgFRkv5uuzicCwtE3x6CbexM2Qdg1e
 9goU0+qOCLk2+4xheEpW1bLNZ3JjURH4GDS/9Sj6B9AEMsIPTzFVxqkFDAJ0FDF9SVOK
 RpABgtsom/VyeyotMaC955vOjv0N5ZDBGsPaZUo++4zlANNSyFy5hORd1eDfp+88G3ij
 BiPzHtyzt5PtzIy4gPElz2ODzzxIJYDWIgAXuW9j4YuKjwz2NcMCvyfqrOTmqigRiyTq
 AbzzrxgMOHOdvpXuwwe+j4qPE7XJOEyCK5/kt13brwZsABB3AGCDaqlkq7dVSGbtosmO
 9D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093649; x=1773698449;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hY60D7v/rxDcBw9h5eZwOSrkKI4gGjyHlv1OUyQA2c0=;
 b=Sfmc0FySH7kJeltVIcL1BIa68toSNqOaCfnBjNjBHB0YQdmS1EOnTnzBzaaEP3HDDQ
 SXQUf0WVyi1qKbzfqQ9V+ILHFyceHZ2a0b0tjsTolAHDWsmO4fRnedVi7NiLO7ph5hyh
 vCeCYavK78ruNvonHc5lNmyP9x3G/rwfpfgIRNEoQTsnkmnGOdw6zRk8A3MxVEkQ6Gat
 pi+4VKVfoARW5b83X9aer77MRpOlBoo/4uOav013nVE4Sw5PDmpIPeKG7dDb1ZdGmMxU
 G36Ls1mjCs/F2JZNfnaY4sLQGfNCfN8bpk0EW/OpIUkRWWf69KGm3NsHWYs9jvxNGS/S
 FM/Q==
X-Gm-Message-State: AOJu0YzJ/nQWeYNBTS+TSi7PfMOJv/1+AX/SXCj3PKrjHz33X4HU5xtZ
 OCV/kPme8n7ZoRg/tEdUl5fYS7gymibx9jTTCZI5K6d6HpwIYaCweurV
X-Gm-Gg: ATEYQzwN1nKCsvutwA8bhZVhGRmieytpWIVt5Dq4SPLkFa87JN9+620jRhkJMYasEMe
 +6IaooWLGffL8bqYt9MwMNJc4UddlfTs6jthkqjOf6fKt8jnv3xNN0Zs7+GPrnl+pwcTG5y2IVC
 hIgEx90lgMWu7x38bXxeYnxVfC1m5EaZSGdl7BdoDUmOLoN2e8NUMvVC2gKjcE6ynpJ74fe24C2
 PzBx7JWl3/3VSaI0T+6f10AmoPmf1b//rvOcDX6EcIQvHR9UNTJzz7ZQiS3V2HdsvuOjejfO+oT
 456O3mdwNKcH4dWTxm5TMEEMClC7jfFs8BD03tK0visbAtV0oewnzUlQ4LoEu1nlVhhir//QOBy
 xvOFP54D1B6uZZYvzbu16cL+qKOAicyNpLWjvzMDNOlrdvTsPYev5WCc8EMmYvg76g7MdkQPo/f
 5U5SQN5f1l5E7T76OjJvNeJtzHZmEih5gRbGQ=
X-Received: by 2002:a05:690c:698b:b0:798:6f0b:86ba with SMTP id
 00721157ae682-798dd6a6ea5mr114092527b3.23.1773093649017; 
 Mon, 09 Mar 2026 15:00:49 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:48 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:38 -0400
Subject: [PATCH v4 06/13] target/arm: add canonical tag check logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-6-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=10551;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=NvQWtYV+wKv0KzfOcoI/k2J4z6Cnibpsfzwdnk4YB6k=;
 b=Ez45Ab2Lkg/oULqCDPCVkHgIW3W96Qo0+8LKrcO4IPzL2rdjJw8syfMG0rXneFJa+l7cBDIfI
 /kUMX1KfoCkAqpNRU8LtA4ULYA8h95484V06sbXnRTtgxzyhF3ocqNQ
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This feature causes tag checks to compare logical address tags against
their canonical form rather than against allocation tags, when the check
happens in a canonically tagged memory region. Described in the ARM ARM
section "Logical Address Tagging".

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/cpu.h               |  1 +
 target/arm/internals.h         | 31 ++++++++++++++++++++++++++++++-
 target/arm/tcg/hflags.c        |  4 ++++
 target/arm/tcg/mte_helper.c    | 21 +++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  7 +++++++
 target/arm/tcg/translate.h     |  1 +
 7 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 38fc56b52e..5e3dc5256f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1154,6 +1154,11 @@ static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
 }
 
+static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) == 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7911912c3e..1f33c0d163 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2527,6 +2527,7 @@ FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
 FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)
+FIELD(TBFLAG_A64, MTX, 47, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a45119caa2..52597a351c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1630,6 +1630,12 @@ static inline bool mtx_check(uint32_t desc, int bit55)
     return (desc >> (R_MTEDESC_MTX_SHIFT + bit55)) & 1;
 }
 
+/* Return whether or not the second nibble of a VA matches bit 55.  */
+static inline bool tag_is_canonical(int ptr_tag, int bit55)
+{
+    return ((ptr_tag + bit55) & 0xf) == 0;
+}
+
 /* Return true if tcma bits mean that the access is unchecked.  */
 static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
 {
@@ -1637,11 +1643,34 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
      * We had extracted bit55 and ptr_tag for other reasons, so fold
      * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
      */
-    bool match = ((ptr_tag + bit55) & 0xf) == 0;
+    bool match = tag_is_canonical(ptr_tag, bit55);
     bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
     return tcma && match;
 }
 
+/* Return true if Canonical Tagging is enabled. */
+static inline bool canonical_tagging_enabled(CPUARMState *env, bool selector)
+{
+    int mmu_idx;
+    uint64_t tcr, mtx_bit;
+
+    /* If mte4 is not implemented, then mtx is by definition not enabled */
+    if (!cpu_isar_feature(aa64_mte_mtx, env_archcpu(env))) {
+        return false;
+    }
+
+    mmu_idx = arm_mmu_idx_el(env, arm_current_el(env));
+    tcr = regime_tcr(env, mmu_idx);
+
+    /*
+     * In two-range regimes, mtx is governed by bit 60 or 61 of TCR, and in
+     * one-range regimes, bit 33 is used.
+     */
+    mtx_bit = regime_has_2_ranges(mmu_idx) ? 60 + selector : 33;
+
+    return extract64(tcr, mtx_bit, 1);
+}
+
 /*
  * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
  * for the tag to be present in the FAR_ELx register.  But for user-only
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index e753124c4c..40a934a8af 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -460,6 +460,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* Cache TCMA as well as TBI. */
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
+        /* Cache MTX. */
+        if (cpu_isar_feature(aa64_mte_mtx, env_archcpu(env))) {
+            DP_TBFLAG_A64(flags, MTX, mtx);
+        }
     }
 
     if (cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 1484087a19..b54fbd11c0 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -854,6 +854,13 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
                                   MMU_DATA_LOAD, ra);
         if (!mem1) {
+            /*
+             * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+             * otherwise it is Untagged. See AArch64.CheckTag.
+             */
+            if (mtx_check(desc, bit55)) {
+                return tag_is_canonical(ptr_tag, bit55);
+            }
             return 1;
         }
         /* Perform all of the comparisons. */
@@ -867,6 +874,12 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
                                   ptr_last - next_page + 1,
                                   MMU_DATA_LOAD, ra);
 
+        /* If either region is canonically tagged, do a canonical tag check */
+        if (mtx_check(desc, bit55) && (!mem1 || !mem2)
+            && (!tag_is_canonical(ptr_tag, bit55))) {
+            return 0;
+        }
+
         /*
          * Perform all of the comparisons.
          * Note the possible but unlikely case of the operation spanning
@@ -974,6 +987,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
         goto done;
     }
 
+
     /*
      * In arm_cpu_realizefn, we asserted that dcz > LOG2_TAG_GRANULE+1,
      * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make
@@ -995,6 +1009,13 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     mem = allocation_tag_mem(env, mmu_idx, align_ptr, MMU_DATA_STORE,
                              dcz_bytes, MMU_DATA_LOAD, ra);
     if (!mem) {
+        /*
+         * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+         * otherwise it is Untagged. See AArch64.CheckTag.
+         */
+        if (mtx_check(desc, bit55) && !tag_is_canonical(ptr_tag, bit55)) {
+            mte_check_fail(env, desc, ptr, ra);
+        }
         goto done;
     }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 874174a15b..366830f7f0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -311,6 +311,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(memop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
@@ -344,6 +345,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(single_mop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
@@ -3002,6 +3004,7 @@ static void handle_sys(DisasContext *s, bool isread,
             desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
             desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
             desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+            desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
 
             tcg_rt = tcg_temp_new_i64();
             gen_helper_mte_check_zva(tcg_rt, tcg_env,
@@ -4872,6 +4875,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, true);
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         /* SIZEM1 and ALIGN we leave 0 (byte write) */
     }
     /* The helper function always needs the memidx even with MTE disabled */
@@ -4926,11 +4930,13 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
     if (s->mte_active[runpriv]) {
         rdesc = FIELD_DP32(rdesc, MTEDESC, TBI, s->tbid);
         rdesc = FIELD_DP32(rdesc, MTEDESC, TCMA, s->tcma);
+        rdesc = FIELD_DP32(rdesc, MTEDESC, MTX, s->mtx);
     }
     if (s->mte_active[wunpriv]) {
         wdesc = FIELD_DP32(wdesc, MTEDESC, TBI, s->tbid);
         wdesc = FIELD_DP32(wdesc, MTEDESC, TCMA, s->tcma);
         wdesc = FIELD_DP32(wdesc, MTEDESC, WRITE, true);
+        wdesc = FIELD_DP32(wdesc, MTEDESC, MTX, s->mtx);
     }
     /* The helper function needs these parts of the descriptor regardless */
     rdesc = FIELD_DP32(rdesc, MTEDESC, MIDX, rmemidx);
@@ -10700,6 +10706,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
     dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
     dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
+    dc->mtx = EX_TBFLAG_A64(tb_flags, MTX);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 74143161f4..846e383c70 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -82,6 +82,7 @@ typedef struct DisasContext {
     uint8_t tbii;      /* TBI1|TBI0 for insns */
     uint8_t tbid;      /* TBI1|TBI0 for data */
     uint8_t tcma;      /* TCMA1|TCMA0 for MTE */
+    uint8_t mtx;       /* MTX1|MTX0 for MTE */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */

-- 
2.52.0



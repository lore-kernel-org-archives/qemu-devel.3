Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B9bm4fm8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsVj-00063X-Nb; Fri, 30 Oct 2026 15:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVe-00062R-DI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:30 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVY-00008E-Rl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:28 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so1421885a34.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389402; x=1793994202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OzML/xttmswDTGgiiMcTH6/xBG066BvkkzoYVKK5mlY=;
 b=B9bm4fm8nJPhooziVFwksRPgOD9gvX+AyeIQQHUS5Ga4VmT2cvVElrQrZE+lSyW0pg
 UPPpkzp2qglwXvPKC0cXjgzZ8oRrsXC2GAq2ob97C/xrRtwL3oiLLvx9rijmU4baua+I
 +BiWY+7I5wD2F65p8R7cluLT1b96rAZvh7aL6vEfuofc52mxafHjF6NJkd/Z8Z4gJobI
 dPSv2bbdoIr0oAmZgcV55/PHl3TOOXGbIuOrqDDq8eSFgr/MMAEATsbl+crtbB9+jLyW
 Ztg9UldODGDU+iWGyp4rcYp7gnzQtSC5jE6XGJIpY20Xkyq/BhyGLOagQf9CFxTLBJ/f
 6YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389402; x=1793994202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OzML/xttmswDTGgiiMcTH6/xBG066BvkkzoYVKK5mlY=;
 b=I3oEgMX3xfsoLYmrON/pxqGtPXsqo63q3GtaLCxPValyqyruX+XbDfDQ27rSqgMiUJ
 A8Xoua8n2lNjg7QKekvdMp6ZSIPVYCaNLScxD+5IhWS68efarAqpjDjucmgVmvE79vkI
 5tgdkjTGWQ8IfOB5Dp9UOu7Q2BHm4mzWkE59lsRT2U1FWKkvE1srqWXJh3KmNMjwrJHj
 oO5UJtsfPsNisYByt/vOhySU3qv2GYU6DgW06kuZ401KLa+gXF9C74xvZk7PDUTWYVYd
 BW23G8MkdwlHhdSYhHWGq0HpTcc+KlgCM846u9AHmEMwUMmM7p2BeWb0p9SGtZ4Htzbu
 jOcA==
X-Gm-Message-State: AFq9FYImQDxTVxWkRncKb3rgSDa6asxIpDWP10yG96G+VPTII4pgu34a
 t5G3nugybrggofjP8gyeAGN1H5yz/jl4mbbJKQv7wDVN1WPyZrkymkMlLGZIDdfPW/TSnwmx8Nh
 h8A+3
X-Gm-Gg: AYBFou0xzrlRRTf+Va/vmjdAxoio1vM3G2vkeN9iaFj9o1Bf0HPbJ7ilv/U1LHSTYVc
 y4s6JZs2TQvjuMT9KQZ3uWMdCYXUi7QQNu0akDvU3IicC2zxuFtqQ4imsZjsx0WifQp2HtQb8Vl
 sFwQ152npiW1L/1GOl+85Hszi/AUX/LfDBCJUSaQ5DPWGh+GcAEqbkyIQhrgJzMNF4h4ElfYfoC
 GRYY3cN1PK8djEFNWHqlv5hFIHKCEYe7R0J3iQPzin9MDObqE7CyZaBQjELGUasQQO8EAJBOwoH
 t9OIiRLW80PnyWl38qZ088IpdmNecJsNrtC/cPU/9iH3KwobU6ZdgF8ccST4pxYSTv5U/WcsmM0
 j4Co1HtDMDJh9rQ9Ly6cFwzdaSyVLnlxr1UEG9JYSdnifZmP+sIfok+yUCj0l7WNQdYZsI5SekK
 ObqJK9Qz9o1gQoOHjN6tpYpQn4C2AMgX1CgsYqH0+TU2SXXKvGWWWOtiBr7xhIjUe5h1pHQa1Cs
 QanX5lj+cKDyfrAxs+uUDVm7oTCvqbybcOjG5SADomlPswW0Ie+575b4EV8yhRTG/F+wrUEXeFb
 5euaTTlJ1sDi/q7lnjWiRnvrFmGZOC2Mova5t27ekwXp0R0Crn4/aYRH
X-Received: by 2002:a05:6820:618:b0:70a:4973:e475 with SMTP id
 006d021491bc7-714f1fd5f99mr2040613eaf.9.1793389402308; 
 Fri, 30 Oct 2026 12:43:22 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/9] target/arm: Add tbflags to DisasContext
Date: Fri, 30 Oct 2026 14:43:10 -0500
Message-ID: <20261030194318.319310-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare to track changes to tbflags across the TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  9 ++++
 target/arm/tcg/translate-a64.c | 95 ++++++++++++++++++----------------
 target/arm/tcg/translate.c     | 60 ++++++++++-----------
 3 files changed, 89 insertions(+), 75 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 57e45ea872..b9254d5524 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -75,6 +75,15 @@ typedef struct DisasContext {
     bool eci_handled;
     int sctlr_b;
     MemOp be_data;
+
+    /*
+     * Current tbflags.  During translation, starts as tb->flags
+     * but updated for known changes to cpu state.  If at some
+     * point we encounter some unknowable change, set tbflags_invalid.
+     */
+    CPUARMTBFlags tbflags;
+    bool tbflags_invalid;
+
 #if !defined(CONFIG_USER_ONLY)
     int user;
 #endif
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0c712e7ac2..d8b6c1df41 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -497,6 +497,7 @@ static void a64_test_cc(DisasCompare64 *c64, int cc)
 static void gen_rebuild_hflags(DisasContext *s)
 {
     gen_helper_rebuild_hflags_a64(tcg_env, tcg_constant_i32(s->current_el));
+    s->tbflags_invalid = true;
 }
 
 static void gen_exception_internal_insn(DisasContext *s, int excp)
@@ -11004,68 +11005,70 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu_env(cpu);
     ARMCPU *arm_cpu = env_archcpu(env);
-    CPUARMTBFlags tb_flags = arm_tbflags_from_tb(dc->base.tb);
     int bound, core_mmu_idx;
 
     dc->isar = &arm_cpu->isar;
     dc->condjmp = 0;
     dc->pc_save = dc->base.pc_first;
     dc->aarch64 = true;
+
+    dc->tbflags = arm_tbflags_from_tb(dc->base.tb);
+
     dc->thumb = false;
     dc->sctlr_b = 0;
-    dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
+    dc->be_data = EX_TBFLAG_ANY(dc->tbflags, BE_DATA) ? MO_BE : MO_LE;
     dc->condexec_mask = 0;
     dc->condexec_cond = 0;
-    core_mmu_idx = EX_TBFLAG_ANY(tb_flags, MMUIDX);
+    core_mmu_idx = EX_TBFLAG_ANY(dc->tbflags, MMUIDX);
     dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
-    dc->tbii = EX_TBFLAG_A64(tb_flags, TBII);
-    dc->tbid = EX_TBFLAG_A64(tb_flags, TBID);
-    dc->tcma = EX_TBFLAG_A64(tb_flags, TCMA);
+    dc->tbii = EX_TBFLAG_A64(dc->tbflags, TBII);
+    dc->tbid = EX_TBFLAG_A64(dc->tbflags, TBID);
+    dc->tcma = EX_TBFLAG_A64(dc->tbflags, TCMA);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
-    dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
-    dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
-    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
-    dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
-    dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
-    dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
-    dc->sve_excp_el = EX_TBFLAG_A64(tb_flags, SVEEXC_EL);
-    dc->sme_excp_el = EX_TBFLAG_A64(tb_flags, SMEEXC_EL);
-    dc->zt0_excp_el = EX_TBFLAG_A64(tb_flags, ZT0EXC_EL);
-    dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
-    dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
+    dc->fp_excp_el = EX_TBFLAG_ANY(dc->tbflags, FPEXC_EL);
+    dc->align_mem = EX_TBFLAG_ANY(dc->tbflags, ALIGN_MEM);
+    dc->pstate_il = EX_TBFLAG_ANY(dc->tbflags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(dc->tbflags, PSTATE__UINJ);
+    dc->fgt_active = EX_TBFLAG_ANY(dc->tbflags, FGT_ACTIVE);
+    dc->fgt_svc = EX_TBFLAG_ANY(dc->tbflags, FGT_SVC);
+    dc->trap_eret = EX_TBFLAG_A64(dc->tbflags, TRAP_ERET);
+    dc->sve_excp_el = EX_TBFLAG_A64(dc->tbflags, SVEEXC_EL);
+    dc->sme_excp_el = EX_TBFLAG_A64(dc->tbflags, SMEEXC_EL);
+    dc->zt0_excp_el = EX_TBFLAG_A64(dc->tbflags, ZT0EXC_EL);
+    dc->vl = (EX_TBFLAG_A64(dc->tbflags, VL) + 1) * 16;
+    dc->svl = (EX_TBFLAG_A64(dc->tbflags, SVL) + 1) * 16;
     dc->max_svl = arm_cpu->sme_max_vq * 16;
     dc->max_any_vl = MAX(dc->max_svl, arm_cpu->sve_max_vq * 16);
-    dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
-    dc->bt = EX_TBFLAG_A64(tb_flags, BT);
-    dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
-    dc->unpriv = EX_TBFLAG_A64(tb_flags, UNPRIV);
-    dc->ata[0] = EX_TBFLAG_A64(tb_flags, ATA);
-    dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
-    dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
-    dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
-    dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
-    dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
-    dc->mtx = EX_TBFLAG_A64(tb_flags, MTX);
-    dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
-    dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
-    dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
-    dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
-    dc->e2h = EX_TBFLAG_A64(tb_flags, E2H);
-    dc->nv = EX_TBFLAG_A64(tb_flags, NV);
-    dc->nv1 = EX_TBFLAG_A64(tb_flags, NV1);
-    dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
+    dc->pauth_active = EX_TBFLAG_A64(dc->tbflags, PAUTH_ACTIVE);
+    dc->bt = EX_TBFLAG_A64(dc->tbflags, BT);
+    dc->btype = EX_TBFLAG_A64(dc->tbflags, BTYPE);
+    dc->unpriv = EX_TBFLAG_A64(dc->tbflags, UNPRIV);
+    dc->ata[0] = EX_TBFLAG_A64(dc->tbflags, ATA);
+    dc->ata[1] = EX_TBFLAG_A64(dc->tbflags, ATA0);
+    dc->mte_active[0] = EX_TBFLAG_A64(dc->tbflags, MTE_ACTIVE);
+    dc->mte_active[1] = EX_TBFLAG_A64(dc->tbflags, MTE0_ACTIVE);
+    dc->mte_store_only[0] = EX_TBFLAG_A64(dc->tbflags, MTE_STORE_ONLY);
+    dc->mte_store_only[1] = EX_TBFLAG_A64(dc->tbflags, MTE0_STORE_ONLY);
+    dc->mtx = EX_TBFLAG_A64(dc->tbflags, MTX);
+    dc->pstate_sm = EX_TBFLAG_A64(dc->tbflags, PSTATE_SM);
+    dc->pstate_za = EX_TBFLAG_A64(dc->tbflags, PSTATE_ZA);
+    dc->sme_trap_nonstreaming = EX_TBFLAG_A64(dc->tbflags, SME_TRAP_NONSTREAMING);
+    dc->naa = EX_TBFLAG_A64(dc->tbflags, NAA);
+    dc->e2h = EX_TBFLAG_A64(dc->tbflags, E2H);
+    dc->nv = EX_TBFLAG_A64(dc->tbflags, NV);
+    dc->nv1 = EX_TBFLAG_A64(dc->tbflags, NV1);
+    dc->nv2 = EX_TBFLAG_A64(dc->tbflags, NV2);
     dc->nv2_mem_e20 = dc->nv2 && dc->e2h;
-    dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
-    dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
-    dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
-    dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
-    dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
-    dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
-    dc->fpmr_el = EX_TBFLAG_A64(tb_flags, FPMR_EL);
+    dc->nv2_mem_be = EX_TBFLAG_A64(dc->tbflags, NV2_MEM_BE);
+    dc->fpcr_ah = EX_TBFLAG_A64(dc->tbflags, AH);
+    dc->fpcr_nep = EX_TBFLAG_A64(dc->tbflags, NEP);
+    dc->gcs_en = EX_TBFLAG_A64(dc->tbflags, GCS_EN);
+    dc->gcs_rvcen = EX_TBFLAG_A64(dc->tbflags, GCS_RVCEN);
+    dc->gcsstr_el = EX_TBFLAG_A64(dc->tbflags, GCSSTR_EL);
+    dc->fpmr_el = EX_TBFLAG_A64(dc->tbflags, FPMR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
@@ -11095,8 +11098,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = EX_TBFLAG_ANY(tb_flags, SS_ACTIVE);
-    dc->pstate_ss = EX_TBFLAG_ANY(tb_flags, PSTATE__SS);
+    dc->ss_active = EX_TBFLAG_ANY(dc->tbflags, SS_ACTIVE);
+    dc->pstate_ss = EX_TBFLAG_ANY(dc->tbflags, PSTATE__SS);
     dc->is_ldex = false;
 
     /* Bound the number of insns to execute to those left on the page.  */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 6983153ffc..49d327de54 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6389,7 +6389,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu_env(cs);
     ARMCPU *cpu = env_archcpu(env);
-    CPUARMTBFlags tb_flags = arm_tbflags_from_tb(dc->base.tb);
     uint32_t condexec, core_mmu_idx;
     bool d32dis = false;
 
@@ -6397,9 +6396,12 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->condjmp = 0;
     dc->pc_save = dc->base.pc_first;
     dc->aarch64 = false;
-    dc->thumb = EX_TBFLAG_AM32(tb_flags, THUMB);
-    dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
-    condexec = EX_TBFLAG_AM32(tb_flags, CONDEXEC);
+
+    dc->tbflags = arm_tbflags_from_tb(dc->base.tb);
+
+    dc->thumb = EX_TBFLAG_AM32(dc->tbflags, THUMB);
+    dc->be_data = EX_TBFLAG_ANY(dc->tbflags, BE_DATA) ? MO_BE : MO_LE;
+    condexec = EX_TBFLAG_AM32(dc->tbflags, CONDEXEC);
     /*
      * the CONDEXEC TB flags are CPSR bits [15:10][26:25]. On A-profile this
      * is always the IT bits. On M-profile, some of the reserved encodings
@@ -6422,40 +6424,40 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         }
     }
 
-    core_mmu_idx = EX_TBFLAG_ANY(tb_flags, MMUIDX);
+    core_mmu_idx = EX_TBFLAG_ANY(dc->tbflags, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
-    dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
-    dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
-    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
-    dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
-    dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
+    dc->fp_excp_el = EX_TBFLAG_ANY(dc->tbflags, FPEXC_EL);
+    dc->align_mem = EX_TBFLAG_ANY(dc->tbflags, ALIGN_MEM);
+    dc->pstate_il = EX_TBFLAG_ANY(dc->tbflags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(dc->tbflags, PSTATE__UINJ);
+    dc->fgt_active = EX_TBFLAG_ANY(dc->tbflags, FGT_ACTIVE);
+    dc->fgt_svc = EX_TBFLAG_ANY(dc->tbflags, FGT_SVC);
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         dc->vfp_enabled = 1;
-        dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
-        dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
-        dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
-        dc->v8m_fpccr_s_wrong = EX_TBFLAG_M32(tb_flags, FPCCR_S_WRONG);
+        dc->v7m_handler_mode = EX_TBFLAG_M32(dc->tbflags, HANDLER);
+        dc->v8m_secure = EX_TBFLAG_M32(dc->tbflags, SECURE);
+        dc->v8m_stackcheck = EX_TBFLAG_M32(dc->tbflags, STACKCHECK);
+        dc->v8m_fpccr_s_wrong = EX_TBFLAG_M32(dc->tbflags, FPCCR_S_WRONG);
         dc->v7m_new_fp_ctxt_needed =
-            EX_TBFLAG_M32(tb_flags, NEW_FP_CTXT_NEEDED);
-        dc->v7m_lspact = EX_TBFLAG_M32(tb_flags, LSPACT);
-        dc->mve_no_pred = EX_TBFLAG_M32(tb_flags, MVE_NO_PRED);
+            EX_TBFLAG_M32(dc->tbflags, NEW_FP_CTXT_NEEDED);
+        dc->v7m_lspact = EX_TBFLAG_M32(dc->tbflags, LSPACT);
+        dc->mve_no_pred = EX_TBFLAG_M32(dc->tbflags, MVE_NO_PRED);
     } else {
-        dc->sctlr_b = EX_TBFLAG_A32(tb_flags, SCTLR__B);
-        dc->hstr_active = EX_TBFLAG_A32(tb_flags, HSTR_ACTIVE);
-        dc->ns = EX_TBFLAG_A32(tb_flags, NS);
-        dc->vfp_enabled = EX_TBFLAG_A32(tb_flags, VFPEN);
-        dc->vec_len = EX_TBFLAG_A32(tb_flags, VECLEN);
-        dc->vec_stride = EX_TBFLAG_A32(tb_flags, VECSTRIDE);
+        dc->sctlr_b = EX_TBFLAG_A32(dc->tbflags, SCTLR__B);
+        dc->hstr_active = EX_TBFLAG_A32(dc->tbflags, HSTR_ACTIVE);
+        dc->ns = EX_TBFLAG_A32(dc->tbflags, NS);
+        dc->vfp_enabled = EX_TBFLAG_A32(dc->tbflags, VFPEN);
+        dc->vec_len = EX_TBFLAG_A32(dc->tbflags, VECLEN);
+        dc->vec_stride = EX_TBFLAG_A32(dc->tbflags, VECSTRIDE);
         dc->sme_trap_nonstreaming =
-            EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
-        dc->neon_excp_el = EX_TBFLAG_A32(tb_flags, NEONEXC_EL);
-        d32dis = EX_TBFLAG_A32(tb_flags, D32DIS);
+            EX_TBFLAG_A32(dc->tbflags, SME_TRAP_NONSTREAMING);
+        dc->neon_excp_el = EX_TBFLAG_A32(dc->tbflags, NEONEXC_EL);
+        d32dis = EX_TBFLAG_A32(dc->tbflags, D32DIS);
     }
 
     dc->invalid_vfp_dreg_mask =
@@ -6481,8 +6483,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = EX_TBFLAG_ANY(tb_flags, SS_ACTIVE);
-    dc->pstate_ss = EX_TBFLAG_ANY(tb_flags, PSTATE__SS);
+    dc->ss_active = EX_TBFLAG_ANY(dc->tbflags, SS_ACTIVE);
+    dc->pstate_ss = EX_TBFLAG_ANY(dc->tbflags, PSTATE__SS);
     dc->is_ldex = false;
 
     dc->page_start = dc->base.pc_first & TARGET_PAGE_MASK;
-- 
2.53.0



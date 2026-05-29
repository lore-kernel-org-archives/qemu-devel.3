Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4A5CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gj-0005Ko-HY; Fri, 29 May 2026 15:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GW-00050C-9l
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:11 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GU-0005Yr-0L
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:07 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso4722246eaf.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084384; x=1780689184; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AlrO//27Om236RSs+kJZmChk5zcuJ68zlH0WDU+6pyU=;
 b=Cj7E3mHiLFZ/Qpk3LPZc7y7Cl1rMvf3MIunLiMzFBaIm7glpEpzpAsZUyJiE3855W/
 jcoUj5rscasgRVGHuIHxdxG9caluu1VGHP5FIvRCwncumL5WrTvelqe73I2XWoOqPocm
 fFwP/XxzPtDvnkp3xbki9tUHhwod/pX1U5gHdIL7zsR5aulvtShYcKVHTxTktf6zeMWr
 MrvWzdrHWU7OL6OzsBWk8L0z4wj4pN3PStg6CEZH2Mpe9qHBtYR6PC607oPcq+I915K+
 WHW1vtx6gbAji3TVHuN2Vuf2Ab1bwU5Gu3uGOtcaZ9xs1VTcB7l0exIZkSMR8M4oQ27a
 RC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084384; x=1780689184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AlrO//27Om236RSs+kJZmChk5zcuJ68zlH0WDU+6pyU=;
 b=YfbkmBPQd7CrVWaUuwsuKXzr/B1i+7Z04at16ke4zD7jiVxLFJlNisArNRaVCiC8lF
 1TGIcMmaL597lTV2pCfOKUqnM+39CeG2F7u5MRrIetRE4bWhnlNoWlTeCZd3ctrQumL0
 EdTrZtruivfQCpvYoFuaSA9p6EaOsusnnGZaR94kBimWXAmZPmjyZ94fb+coKXe5d79o
 SUJ9V/cBCbc5XbpDibzr7bQBgAdV2i0CyE6l2mJ0uytbQats8yCtjWunppfy32QdFzNy
 M5ohbFQ9EQY94boyXzniozkRE/OW68AyPEj5xfTUjylhOnVj3KtO1qJmaYyvBD+W2mY6
 G/mA==
X-Gm-Message-State: AOJu0YwT2SB/uxM9v9vYyhJ/vvSMaVi7BCQSkGgjKwd1eSOe7OpLp2lt
 WddZ/j1DSu6VzuPo/ZvnuT84Fp28IS/tY2+WZSsIGktYPyPDLMzXms40
X-Gm-Gg: Acq92OGRpqcyBN8AU0VHBzzjDc8X+B6zkOXXb5X7VjN8ojDbe8rfgE5PF/GN6D+JIlP
 cmemx7wAiszldyNpVcgwq1EL03Vq8DE1PMS3+OyrV5v6OvPCIN6tMs79ScfM20RH2qjUyRmxyYX
 dqZcXN+yvRf8x7eZ0nF4lisiv6JfCAQ6myeXySnJ6LKKFrpoQRBrt0K3NfabofdrxUbPu3QmukK
 HE8MHgM1A6Ozvk5RV++1dol77SwMxV4k/bWg+AWm3Wlf8x7JiJIHWDikCu6gGQRmUwqcjXZAZSd
 XYXKZKhNgqlJtZ/LdbqoLEr5nsakAo1Iifbbomc7kpOZ/wt0WvZiQKhnUUQdEyZ/74IvQg7sBu9
 df4MtzQ/kBnYMDEWeJFgHbKpQQAlpjSExHDxBG1eRdnyYHGrHc83kutSrmSQUndguDKPaf27kod
 0sVEsMqAf2i/rvgQbHTd9mnHrQupExl2s7rwcYldPOorU=
X-Received: by 2002:a05:6820:4cc1:b0:69d:6a9e:e925 with SMTP id
 006d021491bc7-69e104b941bmr395263eaf.27.1780084384184; 
 Fri, 29 May 2026 12:53:04 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:03 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:46 -0700
Subject: [PATCH v7 06/15] target/arm: add MTX to MTEDESC and DisasContext
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-6-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=5379;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=AyoBnLhE7qQZx6eJGl83wzWfquYA0tuBBKvsqKudltE=;
 b=LdJc1ZrDb7S2/Ymzk6QSwMsKhhOP7WpAxyyahp3RKn9MM5g4W0blsx+/OmsfT5WPc6EKzkaP2
 8FQSOfDjoLVDUio4zUnPv6EXwPyLWug6L/Yw8TV+neKPvZPAcUYtFlS
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc36.google.com
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

Add fields for MTX to DisasContext and MTEDESC. With MTE4, the fields
will be needed in future patches that alter tag check, tag load and tag
store behavior.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/hflags.c        | 2 ++
 target/arm/tcg/translate-a64.c | 7 +++++++
 target/arm/tcg/translate.h     | 1 +
 4 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08f04a57af..dd939ab22b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2536,6 +2536,7 @@ FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
 FIELD(TBFLAG_A64, MTE_STORE_ONLY, 47, 1)
 FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 48, 1)
+FIELD(TBFLAG_A64, MTX, 49, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index d9d783489c..0716ca98fd 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -500,6 +500,8 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* Cache TCMA as well as TBI. */
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
+        /* Cache MTX. */
+        DP_TBFLAG_A64(flags, MTX, mtx);
     }
 
     if (cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a5850fb58d..036081d897 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -312,6 +312,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(memop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
@@ -345,6 +346,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(single_mop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
@@ -3007,6 +3009,7 @@ static void handle_sys(DisasContext *s, bool isread,
             desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
             desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
             desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+            desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
 
             tcg_rt = tcg_temp_new_i64();
             gen_helper_mte_check_zva(tcg_rt, tcg_env,
@@ -4874,6 +4877,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, true);
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         /* SIZEM1 and ALIGN we leave 0 (byte write) */
     }
     /* The helper function always needs the memidx even with MTE disabled */
@@ -4928,11 +4932,13 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
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
@@ -10723,6 +10729,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
     dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
     dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
+    dc->mtx = EX_TBFLAG_A64(tb_flags, MTX);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 551c6ff347..37a7268b32 100644
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
2.54.0



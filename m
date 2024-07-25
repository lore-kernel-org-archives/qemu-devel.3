Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8L9-0002cc-HN; Thu, 25 Jul 2024 19:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8L7-0002Ps-GV; Thu, 25 Jul 2024 19:57:41 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8L4-0001QD-RJ; Thu, 25 Jul 2024 19:57:41 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so314774a91.0; 
 Thu, 25 Jul 2024 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951856; x=1722556656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4H8rjd8FAVhZyHUJ7Wr4IVzz1xIYTikErrKM+JYxcPw=;
 b=lYFh+d6Nqel9smQZmgCBq8bESVOdQa6C4I/cYrr6UPGk9d9OgBlCSQceurse2G0ELC
 nr6qP/XeOzcYHAcAURzVZ5AN63Pyd22Bt9L6ZEQDKMSe/fmlw8bKFwpqdam0ELfZCgCB
 M6mGm2qW6wf6j8arzMPkvnAwLv90/Q1FovCtVM56rCvhs3Mus0xQaHQbDKZ45cS4VajN
 0mUWj7Zc41GZELh50RuDk/eOSonD6bYw6bNc2tpgU6MuTevLX3fJf/uXkRD3m89VbqgG
 g6xIDdNKBLh8jUYeDicWGrDvHtDUMUGq/20AXYVQW3J/FkeB0pPmk5WEq0ZNLNzc2mBJ
 CrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951856; x=1722556656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4H8rjd8FAVhZyHUJ7Wr4IVzz1xIYTikErrKM+JYxcPw=;
 b=ptkZIW14O/X5IjaW5t/TvDtqRVYchcaZ8YM0GuHxpiy3jWd/bdGmfpOg1+dI3FnPwX
 V/viBv1YVtzAAng7zXqwhiJlzdyJaF3HkLrUqdkBKBiv8GsLJP0jDp5HE+qlprnQxakX
 3pBB7SVVjajO3NtMY/qR25TcB4eoUQkm9Iiq7dTsghqQbLqQpLiZJa+yG4+IdQc8Z1dH
 +fgp4Z1zTyKXieJCu58umlVA7VWrxMl8VRRb4KGsN1+Xz04URUEbgVC8V7o1L/khwQdI
 NbuEsE74BjEQXXowPimZr+IYuQ9+Z8YDhVzO+4yQ8EuBVB6Cy9Da453R2OKlsNU/1SQy
 yKOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRJcsShZs1IQGQ30TooCMKRldMAKJgPJHea9awd1ZX4z0eh4l4u/qsf4mG75wQ4naPLRqBvvpfwotFuKttytegHfBf
X-Gm-Message-State: AOJu0YzphYYPYjNiSsRRLb6Jd5dH45RJy53+FCWTPx6cDB0pboG9sKVs
 unUnfO7y277GBtBTjDeTnoualkzSqtuJlN2wFKTOxzPgV8iqnQ9sAiLn5A==
X-Google-Smtp-Source: AGHT+IEyNgUblDXz81ldFRLB3nXq6wwOxi79LwAU0+dXBL/LVuy48XWbr3qthQeqmLjdByCIoDoucg==
X-Received: by 2002:a17:90b:4a52:b0:2c9:755f:d4ae with SMTP id
 98e67ed59e1d1-2cf237871dcmr5179315a91.8.1721951856264; 
 Thu, 25 Jul 2024 16:57:36 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 53/96] target/ppc: Move VMX integer add/sub saturate insns to
 decodetree.
Date: Fri, 26 Jul 2024 09:53:26 +1000
Message-ID: <20240725235410.451624-54-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :

	v{add,sub}{u,s}{b,h,w}s		: VX-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                 |  24 +--
 target/ppc/insn32.decode            |  16 ++
 target/ppc/int_helper.c             |  22 +--
 target/ppc/translate/vmx-impl.c.inc | 238 ++++++++++++++++++++--------
 target/ppc/translate/vmx-ops.c.inc  |  19 +--
 5 files changed, 220 insertions(+), 99 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 4fa089cbf9..dd7526bc2e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -203,18 +203,18 @@ DEF_HELPER_FLAGS_3(vsro, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(vsrv, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(vslv, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(VPRTYBQ, TCG_CALL_NO_RWG, void, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddsbs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddshs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddsws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubsbs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubshs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubsws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddubs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vadduhs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vadduws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsububs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubuhs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubuws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDSBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDSHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDSWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBSBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBSHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBSWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDUBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDUHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDUWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBUBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBUHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBUWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
 DEF_HELPER_FLAGS_3(VADDUQM, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VADDECUQ, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VADDEUQM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index ee33141476..8988fca60e 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -832,6 +832,14 @@ VADDCUW         000100 ..... ..... ..... 00110000000    @VX
 VADDCUQ         000100 ..... ..... ..... 00101000000    @VX
 VADDUQM         000100 ..... ..... ..... 00100000000    @VX
 
+VADDSBS         000100 ..... ..... ..... 01100000000    @VX
+VADDSHS         000100 ..... ..... ..... 01101000000    @VX
+VADDSWS         000100 ..... ..... ..... 01110000000    @VX
+
+VADDUBS         000100 ..... ..... ..... 01000000000    @VX
+VADDUHS         000100 ..... ..... ..... 01001000000    @VX
+VADDUWS         000100 ..... ..... ..... 01010000000    @VX
+
 VADDEUQM        000100 ..... ..... ..... ..... 111100   @VA
 VADDECUQ        000100 ..... ..... ..... ..... 111101   @VA
 
@@ -839,6 +847,14 @@ VSUBCUW         000100 ..... ..... ..... 10110000000    @VX
 VSUBCUQ         000100 ..... ..... ..... 10101000000    @VX
 VSUBUQM         000100 ..... ..... ..... 10100000000    @VX
 
+VSUBSBS         000100 ..... ..... ..... 11100000000    @VX
+VSUBSHS         000100 ..... ..... ..... 11101000000    @VX
+VSUBSWS         000100 ..... ..... ..... 11110000000    @VX
+
+VSUBUBS         000100 ..... ..... ..... 11000000000    @VX
+VSUBUHS         000100 ..... ..... ..... 11001000000    @VX
+VSUBUWS         000100 ..... ..... ..... 11010000000    @VX
+
 VSUBECUQ        000100 ..... ..... ..... ..... 111111   @VA
 VSUBEUQM        000100 ..... ..... ..... ..... 111110   @VA
 
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 2c6b633d65..ef4b2e75d6 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -541,7 +541,7 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
     }
 
 #define VARITHSAT_DO(name, op, optype, cvt, element)                    \
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *vscr_sat,              \
+    void helper_V##name(ppc_avr_t *r, ppc_avr_t *vscr_sat,              \
                         ppc_avr_t *a, ppc_avr_t *b, uint32_t desc)      \
     {                                                                   \
         int sat = 0;                                                    \
@@ -555,17 +555,17 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
         }                                                               \
     }
 #define VARITHSAT_SIGNED(suffix, element, optype, cvt)          \
-    VARITHSAT_DO(adds##suffix##s, +, optype, cvt, element)      \
-    VARITHSAT_DO(subs##suffix##s, -, optype, cvt, element)
+    VARITHSAT_DO(ADDS##suffix##S, +, optype, cvt, element)      \
+    VARITHSAT_DO(SUBS##suffix##S, -, optype, cvt, element)
 #define VARITHSAT_UNSIGNED(suffix, element, optype, cvt)        \
-    VARITHSAT_DO(addu##suffix##s, +, optype, cvt, element)      \
-    VARITHSAT_DO(subu##suffix##s, -, optype, cvt, element)
-VARITHSAT_SIGNED(b, s8, int16_t, cvtshsb)
-VARITHSAT_SIGNED(h, s16, int32_t, cvtswsh)
-VARITHSAT_SIGNED(w, s32, int64_t, cvtsdsw)
-VARITHSAT_UNSIGNED(b, u8, uint16_t, cvtshub)
-VARITHSAT_UNSIGNED(h, u16, uint32_t, cvtswuh)
-VARITHSAT_UNSIGNED(w, u32, uint64_t, cvtsduw)
+    VARITHSAT_DO(ADDU##suffix##S, +, optype, cvt, element)      \
+    VARITHSAT_DO(SUBU##suffix##S, -, optype, cvt, element)
+VARITHSAT_SIGNED(B, s8, int16_t, cvtshsb)
+VARITHSAT_SIGNED(H, s16, int32_t, cvtswsh)
+VARITHSAT_SIGNED(W, s32, int64_t, cvtsdsw)
+VARITHSAT_UNSIGNED(B, u8, uint16_t, cvtshub)
+VARITHSAT_UNSIGNED(H, u16, uint32_t, cvtswuh)
+VARITHSAT_UNSIGNED(W, u32, uint64_t, cvtsduw)
 #undef VARITHSAT_CASE
 #undef VARITHSAT_DO
 #undef VARITHSAT_SIGNED
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 8084af75cc..fdb283c1d4 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -1047,58 +1047,6 @@ TRANS(VRLQ, do_vector_rotl_quad, false, false)
 TRANS(VRLQNM, do_vector_rotl_quad, true, false)
 TRANS(VRLQMI, do_vector_rotl_quad, false, true)
 
-#define GEN_VXFORM_SAT(NAME, VECE, NORM, SAT, OPC2, OPC3)               \
-static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
-                                         TCGv_vec sat, TCGv_vec a,      \
-                                         TCGv_vec b)                    \
-{                                                                       \
-    TCGv_vec x = tcg_temp_new_vec_matching(t);                          \
-    glue(glue(tcg_gen_, NORM), _vec)(VECE, x, a, b);                    \
-    glue(glue(tcg_gen_, SAT), _vec)(VECE, t, a, b);                     \
-    tcg_gen_cmp_vec(TCG_COND_NE, VECE, x, x, t);                        \
-    tcg_gen_or_vec(VECE, sat, sat, x);                                  \
-}                                                                       \
-static void glue(gen_, NAME)(DisasContext *ctx)                         \
-{                                                                       \
-    static const TCGOpcode vecop_list[] = {                             \
-        glue(glue(INDEX_op_, NORM), _vec),                              \
-        glue(glue(INDEX_op_, SAT), _vec),                               \
-        INDEX_op_cmp_vec, 0                                             \
-    };                                                                  \
-    static const GVecGen4 g = {                                         \
-        .fniv = glue(glue(gen_, NAME), _vec),                           \
-        .fno = glue(gen_helper_, NAME),                                 \
-        .opt_opc = vecop_list,                                          \
-        .write_aofs = true,                                             \
-        .vece = VECE,                                                   \
-    };                                                                  \
-    if (unlikely(!ctx->altivec_enabled)) {                              \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
-        return;                                                         \
-    }                                                                   \
-    tcg_gen_gvec_4(avr_full_offset(rD(ctx->opcode)),                    \
-                   offsetof(CPUPPCState, vscr_sat),                     \
-                   avr_full_offset(rA(ctx->opcode)),                    \
-                   avr_full_offset(rB(ctx->opcode)),                    \
-                   16, 16, &g);                                         \
-}
-
-GEN_VXFORM_SAT(vaddubs, MO_8, add, usadd, 0, 8);
-GEN_VXFORM_DUAL_EXT(vaddubs, PPC_ALTIVEC, PPC_NONE, 0,       \
-                    vmul10uq, PPC_NONE, PPC2_ISA300, 0x0000F800)
-GEN_VXFORM_SAT(vadduhs, MO_16, add, usadd, 0, 9);
-GEN_VXFORM_DUAL(vadduhs, PPC_ALTIVEC, PPC_NONE, \
-                vmul10euq, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_SAT(vadduws, MO_32, add, usadd, 0, 10);
-GEN_VXFORM_SAT(vaddsbs, MO_8, add, ssadd, 0, 12);
-GEN_VXFORM_SAT(vaddshs, MO_16, add, ssadd, 0, 13);
-GEN_VXFORM_SAT(vaddsws, MO_32, add, ssadd, 0, 14);
-GEN_VXFORM_SAT(vsububs, MO_8, sub, ussub, 0, 24);
-GEN_VXFORM_SAT(vsubuhs, MO_16, sub, ussub, 0, 25);
-GEN_VXFORM_SAT(vsubuws, MO_32, sub, ussub, 0, 26);
-GEN_VXFORM_SAT(vsubsbs, MO_8, sub, sssub, 0, 28);
-GEN_VXFORM_SAT(vsubshs, MO_16, sub, sssub, 0, 29);
-GEN_VXFORM_SAT(vsubsws, MO_32, sub, sssub, 0, 30);
 GEN_VXFORM_TRANS(vsl, 2, 7);
 GEN_VXFORM_TRANS(vsr, 2, 11);
 GEN_VXFORM_ENV(vpkuhum, 7, 0);
@@ -2641,26 +2589,14 @@ static void gen_xpnd04_2(DisasContext *ctx)
     }
 }
 
-
-GEN_VXFORM_DUAL(vsubsws, PPC_ALTIVEC, PPC_NONE, \
-                xpnd04_2, PPC_NONE, PPC2_ISA300)
-
 GEN_VXFORM_DUAL(vsububm, PPC_ALTIVEC, PPC_NONE, \
                 bcdadd, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM_DUAL(vsububs, PPC_ALTIVEC, PPC_NONE, \
-                bcdadd, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM_DUAL(vsubuhm, PPC_ALTIVEC, PPC_NONE, \
                 bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM_DUAL(vsubuhs, PPC_ALTIVEC, PPC_NONE, \
-                bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM_DUAL(vaddshs, PPC_ALTIVEC, PPC_NONE, \
-                bcdcpsgn, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
                 bcds, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
                 bcdus, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
-                bcdtrunc, PPC_NONE, PPC2_ISA300)
 
 static void gen_vsbox(DisasContext *ctx)
 {
@@ -2937,6 +2873,180 @@ static bool do_vx_vaddsubcuw(DisasContext *ctx, arg_VX *a, int add)
 TRANS(VSUBCUW, do_vx_vaddsubcuw, 0)
 TRANS(VADDCUW, do_vx_vaddsubcuw, 1)
 
+/* Integer Add/Sub Saturate Instructions */
+static inline void do_vadd_vsub_sat
+(
+    unsigned vece, TCGv_vec t, TCGv_vec sat, TCGv_vec a, TCGv_vec b,
+    void (*norm_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
+    void (*sat_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    norm_op(vece, x, a, b);
+    sat_op(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+}
+
+static void gen_vadd_sat_u(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_add_vec, tcg_gen_usadd_vec);
+}
+
+static void gen_vadd_sat_s(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_add_vec, tcg_gen_ssadd_vec);
+}
+
+static void gen_vsub_sat_u(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_sub_vec, tcg_gen_ussub_vec);
+}
+
+static void gen_vsub_sat_s(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_sub_vec, tcg_gen_sssub_vec);
+}
+
+/*
+ * Signed/Unsigned add/sub helper ops for byte/halfword/word
+ * GVecGen4 struct variants.
+ */
+static const TCGOpcode vecop_list_sub_u[] = {
+    INDEX_op_sub_vec, INDEX_op_ussub_vec, INDEX_op_cmp_vec, 0
+};
+static const TCGOpcode vecop_list_sub_s[] = {
+    INDEX_op_sub_vec, INDEX_op_sssub_vec, INDEX_op_cmp_vec, 0
+};
+static const TCGOpcode vecop_list_add_u[] = {
+    INDEX_op_add_vec, INDEX_op_usadd_vec, INDEX_op_cmp_vec, 0
+};
+static const TCGOpcode vecop_list_add_s[] = {
+    INDEX_op_add_vec, INDEX_op_ssadd_vec, INDEX_op_cmp_vec, 0
+};
+
+static const GVecGen4 op_vsububs = {
+    .fniv = gen_vsub_sat_u,
+    .fno = gen_helper_VSUBUBS,
+    .opt_opc = vecop_list_sub_u,
+    .write_aofs = true,
+    .vece = MO_8
+};
+
+static const GVecGen4 op_vaddubs = {
+    .fniv = gen_vadd_sat_u,
+    .fno = gen_helper_VADDUBS,
+    .opt_opc = vecop_list_add_u,
+    .write_aofs = true,
+    .vece = MO_8
+};
+
+static const GVecGen4 op_vsubuhs = {
+    .fniv = gen_vsub_sat_u,
+    .fno = gen_helper_VSUBUHS,
+    .opt_opc = vecop_list_sub_u,
+    .write_aofs = true,
+    .vece = MO_16
+};
+
+static const GVecGen4 op_vadduhs = {
+    .fniv = gen_vadd_sat_u,
+    .fno = gen_helper_VADDUHS,
+    .opt_opc = vecop_list_add_u,
+    .write_aofs = true,
+    .vece = MO_16
+};
+
+static const GVecGen4 op_vsubuws = {
+    .fniv = gen_vsub_sat_u,
+    .fno = gen_helper_VSUBUWS,
+    .opt_opc = vecop_list_sub_u,
+    .write_aofs = true,
+    .vece = MO_32
+};
+
+static const GVecGen4 op_vadduws = {
+    .fniv = gen_vadd_sat_u,
+    .fno = gen_helper_VADDUWS,
+    .opt_opc = vecop_list_add_u,
+    .write_aofs = true,
+    .vece = MO_32
+};
+
+static const GVecGen4 op_vsubsbs = {
+    .fniv = gen_vsub_sat_s,
+    .fno = gen_helper_VSUBSBS,
+    .opt_opc = vecop_list_sub_s,
+    .write_aofs = true,
+    .vece = MO_8
+};
+
+static const GVecGen4 op_vaddsbs = {
+    .fniv = gen_vadd_sat_s,
+    .fno = gen_helper_VADDSBS,
+    .opt_opc = vecop_list_add_s,
+    .write_aofs = true,
+    .vece = MO_8
+};
+
+static const GVecGen4 op_vsubshs = {
+    .fniv = gen_vsub_sat_s,
+    .fno = gen_helper_VSUBSHS,
+    .opt_opc = vecop_list_sub_s,
+    .write_aofs = true,
+    .vece = MO_16
+};
+
+static const GVecGen4 op_vaddshs = {
+    .fniv = gen_vadd_sat_s,
+    .fno = gen_helper_VADDSHS,
+    .opt_opc = vecop_list_add_s,
+    .write_aofs = true,
+    .vece = MO_16
+};
+
+static const GVecGen4 op_vsubsws = {
+    .fniv = gen_vsub_sat_s,
+    .fno = gen_helper_VSUBSWS,
+    .opt_opc = vecop_list_sub_s,
+    .write_aofs = true,
+    .vece = MO_32
+};
+
+static const GVecGen4 op_vaddsws = {
+    .fniv = gen_vadd_sat_s,
+    .fno = gen_helper_VADDSWS,
+    .opt_opc = vecop_list_add_s,
+    .write_aofs = true,
+    .vece = MO_32
+};
+
+static bool do_vx_vadd_vsub_sat(DisasContext *ctx, arg_VX *a, const GVecGen4 *op)
+{
+    REQUIRE_VECTOR(ctx);
+    tcg_gen_gvec_4(avr_full_offset(a->vrt), offsetof(CPUPPCState, vscr_sat),
+                   avr_full_offset(a->vra), avr_full_offset(a->vrb),
+                   16, 16, op);
+
+    return true;
+}
+
+TRANS_FLAGS(ALTIVEC, VSUBUBS, do_vx_vadd_vsub_sat, &op_vsububs)
+TRANS_FLAGS(ALTIVEC, VSUBUHS, do_vx_vadd_vsub_sat, &op_vsubuhs)
+TRANS_FLAGS(ALTIVEC, VSUBUWS, do_vx_vadd_vsub_sat, &op_vsubuws)
+TRANS_FLAGS(ALTIVEC, VSUBSBS, do_vx_vadd_vsub_sat, &op_vsubsbs)
+TRANS_FLAGS(ALTIVEC, VSUBSHS, do_vx_vadd_vsub_sat, &op_vsubshs)
+TRANS_FLAGS(ALTIVEC, VSUBSWS, do_vx_vadd_vsub_sat, &op_vsubsws)
+TRANS_FLAGS(ALTIVEC, VADDUBS, do_vx_vadd_vsub_sat, &op_vaddubs)
+TRANS_FLAGS(ALTIVEC, VADDUHS, do_vx_vadd_vsub_sat, &op_vadduhs)
+TRANS_FLAGS(ALTIVEC, VADDUWS, do_vx_vadd_vsub_sat, &op_vadduws)
+TRANS_FLAGS(ALTIVEC, VADDSBS, do_vx_vadd_vsub_sat, &op_vaddsbs)
+TRANS_FLAGS(ALTIVEC, VADDSHS, do_vx_vadd_vsub_sat, &op_vaddshs)
+TRANS_FLAGS(ALTIVEC, VADDSWS, do_vx_vadd_vsub_sat, &op_vaddsws)
+
 static bool do_vx_vmuleo(DisasContext *ctx, arg_VX *a, bool even,
                          void (*gen_mul)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 7bb11b0549..e28958a126 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -54,18 +54,13 @@ GEN_VXFORM(vsro, 6, 17),
 GEN_VXFORM(xpnd04_1, 0, 22),
 GEN_VXFORM_300(bcdsr, 0, 23),
 GEN_VXFORM_300(bcdsr, 0, 31),
-GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM_DUAL(vadduhs, vmul10euq, 0, 9, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vadduws, 0, 10),
-GEN_VXFORM(vaddsbs, 0, 12),
-GEN_VXFORM_DUAL(vaddshs, bcdcpsgn, 0, 13, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vaddsws, 0, 14),
-GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vsubuws, 0, 26),
-GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_ALTIVEC, PPC2_ISA300),
-GEN_VXFORM(vsubshs, 0, 29),
-GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
+GEN_VXFORM_300_EXT(vmul10uq, 0, 8, 0x0000F800),
+GEN_VXFORM_300(vmul10euq, 0, 9),
+GEN_VXFORM_300(bcdcpsgn, 0, 13),
+GEN_VXFORM_207(bcdadd, 0, 24),
+GEN_VXFORM_207(bcdsub, 0, 25),
+GEN_VXFORM_300(bcdtrunc, 0, 28),
+GEN_VXFORM_300(xpnd04_2, 0, 30),
 GEN_VXFORM_300(bcdtrunc, 0, 20),
 GEN_VXFORM_300(bcdutrunc, 0, 21),
 GEN_VXFORM(vsl, 2, 7),
-- 
2.45.2



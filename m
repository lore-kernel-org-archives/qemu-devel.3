Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26CFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmm-000862-MC; Sun, 05 May 2024 21:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmk-0007x6-3Z
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmM-0002VK-77
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:53 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso1097449a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957465; x=1715562265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23pn23Ru9mnms/OyXaTQIIImH7Xcu3qMniJ5RYzogr4=;
 b=PK34GrbBQJvopDiITlMpoS1bbVbLWCaWzpPewy7h2bKYf3jjpuZZ2C+jpnRYepzlKe
 oOvE+Lekzn+F265Te2S0xMaYJctVPnsuj6ZYPRG+yHH0Bn2TK2QadcKK2Gx6Gynix/MR
 oKUpOCTOz0iyCakw2RiwuF/vDeKVCk0RirvSkARoV2O3NZpzW5kJqlSsmv3A2KV+JwVp
 OLqNdHANK2nvKjFq+8ptcliQ7Hp1IwYBSZWdVPbB/TrVjYjwItRX2/5nBMOEZ8jsWLNw
 9VzxN5f+aojs7/KV/XZpbEhOCKPvM8QH3uzC2VPw0eLRVjT3UX7mkGRXKskOCBGKH3DO
 euBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957465; x=1715562265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23pn23Ru9mnms/OyXaTQIIImH7Xcu3qMniJ5RYzogr4=;
 b=NqaN8Bhba3U/qK/EdOyT+wi4J/L9X+TMz3nrObAMbu5wEjxhCyiXSVjThEy/CPEG7n
 fjz2G0QW7a+feMS9zuGzULMKSK6c8yAPcNKEbaFL1ZvhFEuwDH6mpKthXQZw9s0crIbf
 BxHobskaqENLnFMxqcrCX3e64RiOUlRKLTMR5tE+AqI/tSxZMSQBtBCJy7R1CC9XfHiI
 lVCyxv0wJk2Ueh6U+KzWw9p000mqX63t8uOetcN0Wc9+USXXXkbfSLGLbJ1XQRFA3ifc
 JDXjrVSw5CuCd5UgWTPKZDYQX9G/Z4O5aBOt2qGJ3YZQqmkmMvDzhgD/Ssz/jnhP+poG
 J72g==
X-Gm-Message-State: AOJu0YzP2kjbKBTrMXWvq4/CQurCZQfnUC5p3sWFhVHW6LCWivtDuv3o
 ClAgldc28LGOpNq/eY7j0a5jHwI7DO8ff9i25HgVPB7Jm/Q+UXg8O4/Qj5KLF5Gs+GKri5vwoIH
 p
X-Google-Smtp-Source: AGHT+IEw7EUDQDwnWTWJ/sY9kRpu/I9tMsDpoR4cXa6kMwVxGflbnr4GTQ+OlHUP99Zq8KPeXIq+xw==
X-Received: by 2002:a05:6a20:96cd:b0:1af:b0d0:281 with SMTP id
 hq13-20020a056a2096cd00b001afb0d00281mr2159104pzc.6.1714957464779; 
 Sun, 05 May 2024 18:04:24 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 23/57] target/arm: Use gvec for neon faddp, fmaxp, fminp
Date: Sun,  5 May 2024 18:03:29 -0700
Message-Id: <20240506010403.6204-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  7 -----
 target/arm/tcg/translate-neon.c | 55 ++-------------------------------
 target/arm/tcg/vec_helper.c     | 45 ---------------------------
 3 files changed, 3 insertions(+), 104 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3268477329..065460ea80 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -650,13 +650,6 @@ DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pminh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 144f18ba22..2326a05a0a 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1144,6 +1144,9 @@ DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
 DO_3S_FP_GVEC(VRSQRTS, gen_helper_gvec_rsqrts_nf_s, gen_helper_gvec_rsqrts_nf_h)
+DO_3S_FP_GVEC(VPADD, gen_helper_gvec_faddp_s, gen_helper_gvec_faddp_h)
+DO_3S_FP_GVEC(VPMAX, gen_helper_gvec_fmaxp_s, gen_helper_gvec_fmaxp_h)
+DO_3S_FP_GVEC(VPMIN, gen_helper_gvec_fminp_s, gen_helper_gvec_fminp_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
@@ -1180,58 +1183,6 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
-static bool do_3same_fp_pair(DisasContext *s, arg_3same *a,
-                             gen_helper_gvec_3_ptr *fn)
-{
-    /* FP pairwise operations */
-    TCGv_ptr fpstatus;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    assert(a->q == 0); /* enforced by decode patterns */
-
-
-    fpstatus = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
-                       vfp_reg_offset(1, a->vn),
-                       vfp_reg_offset(1, a->vm),
-                       fpstatus, 8, 8, 0, fn);
-
-    return true;
-}
-
-/*
- * For all the functions using this macro, size == 1 means fp16,
- * which is an architecture extension we don't implement yet.
- */
-#define DO_3S_FP_PAIR(INSN,FUNC)                                    \
-    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
-    {                                                               \
-        if (a->size == MO_16) {                                     \
-            if (!dc_isar_feature(aa32_fp16_arith, s)) {             \
-                return false;                                       \
-            }                                                       \
-            return do_3same_fp_pair(s, a, FUNC##h);                 \
-        }                                                           \
-        return do_3same_fp_pair(s, a, FUNC##s);                     \
-    }
-
-DO_3S_FP_PAIR(VPADD, gen_helper_neon_padd)
-DO_3S_FP_PAIR(VPMAX, gen_helper_neon_pmax)
-DO_3S_FP_PAIR(VPMIN, gen_helper_neon_pmin)
-
 static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 {
     /* Handle a 2-reg-shift insn which can be vectorized. */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 79e1fdcaa9..26a9ca9c14 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2192,51 +2192,6 @@ DO_ABA(gvec_uaba_d, uint64_t)
 
 #undef DO_ABA
 
-#define DO_NEON_PAIRWISE(NAME, OP)                                      \
-    void HELPER(NAME##s)(void *vd, void *vn, void *vm,                  \
-                         void *stat, uint32_t oprsz)                    \
-    {                                                                   \
-        float_status *fpst = stat;                                      \
-        float32 *d = vd;                                                \
-        float32 *n = vn;                                                \
-        float32 *m = vm;                                                \
-        float32 r0, r1;                                                 \
-                                                                        \
-        /* Read all inputs before writing outputs in case vm == vd */   \
-        r0 = float32_##OP(n[H4(0)], n[H4(1)], fpst);                    \
-        r1 = float32_##OP(m[H4(0)], m[H4(1)], fpst);                    \
-                                                                        \
-        d[H4(0)] = r0;                                                  \
-        d[H4(1)] = r1;                                                  \
-    }                                                                   \
-                                                                        \
-    void HELPER(NAME##h)(void *vd, void *vn, void *vm,                  \
-                         void *stat, uint32_t oprsz)                    \
-    {                                                                   \
-        float_status *fpst = stat;                                      \
-        float16 *d = vd;                                                \
-        float16 *n = vn;                                                \
-        float16 *m = vm;                                                \
-        float16 r0, r1, r2, r3;                                         \
-                                                                        \
-        /* Read all inputs before writing outputs in case vm == vd */   \
-        r0 = float16_##OP(n[H2(0)], n[H2(1)], fpst);                    \
-        r1 = float16_##OP(n[H2(2)], n[H2(3)], fpst);                    \
-        r2 = float16_##OP(m[H2(0)], m[H2(1)], fpst);                    \
-        r3 = float16_##OP(m[H2(2)], m[H2(3)], fpst);                    \
-                                                                        \
-        d[H2(0)] = r0;                                                  \
-        d[H2(1)] = r1;                                                  \
-        d[H2(2)] = r2;                                                  \
-        d[H2(3)] = r3;                                                  \
-    }
-
-DO_NEON_PAIRWISE(neon_padd, add)
-DO_NEON_PAIRWISE(neon_pmax, max)
-DO_NEON_PAIRWISE(neon_pmin, min)
-
-#undef DO_NEON_PAIRWISE
-
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-- 
2.34.1



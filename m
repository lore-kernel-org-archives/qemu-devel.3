Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425C9C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIf-0001pS-0A; Fri, 24 May 2024 19:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeI0-0007dB-7O
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHt-0006uJ-6Z
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so2616780b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593112; x=1717197912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vy+becK3ZE58nm2Idqea46QX6RZ3fPSYpS72Z5p5Sd8=;
 b=Z3PcaCb/OWv4cqwp8oINXe5X3sC4vpG2/N16BnTbnaMU+uAYdeSkOCq1CAcoQD+SYI
 6ig5181ZhnEOI+inuCCBqzB/b4/qhS5gIruXhCfk/xY8SeBJxJody3o3bizG8QstyWZt
 392GcETKsj5CP0Zo6zmRDeKlPzXurXGWN4qTG7ArfUAXxCe8uzvMEUivovo4hWtKBCOT
 LMi3c1Vv+YZo/40oI9HY556RK+d0OjkH818/qegehlyo/xMFLWEGyoghpgpfiLyJ4A3b
 rj2WHg/IJZ9vrwoQ4YmuUAXMh+K6u405g1zNu0T6cXmQjwvQ+y8tWZ/ulKy2qv6N2Omq
 ABhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593112; x=1717197912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vy+becK3ZE58nm2Idqea46QX6RZ3fPSYpS72Z5p5Sd8=;
 b=BuVw+MNh5zGahYot0UkHZwNlkZr87GwCFt4nulMA6nZgs7LZ3joe/pDp4Ynrx/gBil
 rhOvF1/cZT5AlOJvFoiSGUCwV6CqzEPGTQe6DwWsAKda5jFSoZjuYLtg2N+FSHDltq3z
 olbkhq+gPtzLNUbwLFoZghe/CAnKW9s93ra4PXt5MfRbL6IuwCnO/pw//p/r/0kXfmJJ
 fn1ePsR2lj1tZlOR00imHvsu1d2fwv0e7NyDDaGpKidbEMx7akdJuzIXqF0jadh+L7cv
 EF1bINbU4cSAkoiaxkwjMk3rv0Ag7znWEqcX/2DfB0+45KVjeqMDToZhjlftRWMXjbt/
 yFGA==
X-Gm-Message-State: AOJu0YxO9mjdqNpz/h/+abHjBeWk3r1krvKAQqevuJnh1m1MKaa98IdD
 jaHh3H2nqdRdyKoJgcKeupw2XyKujRa2GYsRP0aPBRMKKxGH969vqwy2z2fyP6N7/jOlO3xc4Zs
 a
X-Google-Smtp-Source: AGHT+IGuTJqwLfS9Jj9E9paxx80w63zSbl0AJ402OcjI19R2zlwRxnLlNkK5iiRCYQKbgUd1Ragp9w==
X-Received: by 2002:a05:6a00:3198:b0:6f4:9fc7:d239 with SMTP id
 d2e1a72fcca58-6f7727be1f4mr7160793b3a.14.1716593112182; 
 Fri, 24 May 2024 16:25:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 56/67] target/arm: Convert SHSUB, UHSUB to gvec
Date: Fri, 24 May 2024 16:21:10 -0700
Message-Id: <20240524232121.284515-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/arm/helper.h             |   6 --
 target/arm/tcg/translate.h      |   4 +
 target/arm/tcg/gengvec.c        | 144 ++++++++++++++++++++++++++++++++
 target/arm/tcg/neon_helper.c    |  27 ------
 target/arm/tcg/translate-a64.c  |  17 ++--
 target/arm/tcg/translate-neon.c |   4 +-
 6 files changed, 157 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b26bfcb079..b95f24ed0a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -274,12 +274,6 @@ DEF_HELPER_2(neon_rhadd_s16, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_u16, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_s32, s32, s32, s32)
 DEF_HELPER_2(neon_rhadd_u32, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s8, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_u8, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s16, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_u16, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s32, s32, s32, s32)
-DEF_HELPER_2(neon_hsub_u32, i32, i32, i32)
 
 DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index dd99d76bf2..315e0afd04 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -476,6 +476,10 @@ void gen_gvec_shadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_shsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uhsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 0627cec6b2..6a54ad2d21 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1996,3 +1996,147 @@ void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_debug_assert(vece <= MO_32);
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+static void gen_shsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_sar8i_i64(a, a, 1);
+    tcg_gen_vec_sar8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_sub8_i64(d, a, b);
+    tcg_gen_vec_sub8_i64(d, d, t);
+}
+
+static void gen_shsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_sar16i_i64(a, a, 1);
+    tcg_gen_vec_sar16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_sub16_i64(d, a, b);
+    tcg_gen_vec_sub16_i64(d, d, t);
+}
+
+static void gen_shsub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andc_i32(t, b, a);
+    tcg_gen_sari_i32(a, a, 1);
+    tcg_gen_sari_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_sub_i32(d, a, b);
+    tcg_gen_sub_i32(d, d, t);
+}
+
+static void gen_shsub_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_andc_vec(vece, t, b, a);
+    tcg_gen_sari_vec(vece, a, a, 1);
+    tcg_gen_sari_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_sub_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+}
+
+void gen_gvec_shsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 g[4] = {
+        { .fni8 = gen_shsub8_i64,
+          .fniv = gen_shsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shsub16_i64,
+          .fniv = gen_shsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shsub_i32,
+          .fniv = gen_shsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_uhsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_shr8i_i64(a, a, 1);
+    tcg_gen_vec_shr8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_sub8_i64(d, a, b);
+    tcg_gen_vec_sub8_i64(d, d, t);
+}
+
+static void gen_uhsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_shr16i_i64(a, a, 1);
+    tcg_gen_vec_shr16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_sub16_i64(d, a, b);
+    tcg_gen_vec_sub16_i64(d, d, t);
+}
+
+static void gen_uhsub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andc_i32(t, b, a);
+    tcg_gen_shri_i32(a, a, 1);
+    tcg_gen_shri_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_sub_i32(d, a, b);
+    tcg_gen_sub_i32(d, d, t);
+}
+
+static void gen_uhsub_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_andc_vec(vece, t, b, a);
+    tcg_gen_shri_vec(vece, a, a, 1);
+    tcg_gen_shri_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_sub_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+}
+
+void gen_gvec_uhsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 g[4] = {
+        { .fni8 = gen_uhsub8_i64,
+          .fniv = gen_uhsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_uhsub16_i64,
+          .fniv = gen_uhsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_uhsub_i32,
+          .fniv = gen_uhsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index defd28a6f7..d1641a5252 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -206,33 +206,6 @@ uint32_t HELPER(neon_rhadd_u32)(uint32_t src1, uint32_t src2)
     return dest;
 }
 
-#define NEON_FN(dest, src1, src2) dest = (src1 - src2) >> 1
-NEON_VOP(hsub_s8, neon_s8, 4)
-NEON_VOP(hsub_u8, neon_u8, 4)
-NEON_VOP(hsub_s16, neon_s16, 2)
-NEON_VOP(hsub_u16, neon_u16, 2)
-#undef NEON_FN
-
-int32_t HELPER(neon_hsub_s32)(int32_t src1, int32_t src2)
-{
-    int32_t dest;
-
-    dest = (src1 >> 1) - (src2 >> 1);
-    if ((~src1) & src2 & 1)
-        dest--;
-    return dest;
-}
-
-uint32_t HELPER(neon_hsub_u32)(uint32_t src1, uint32_t src2)
-{
-    uint32_t dest;
-
-    dest = (src1 >> 1) - (src2 >> 1);
-    if ((~src1) & src2 & 1)
-        dest--;
-    return dest;
-}
-
 #define NEON_FN(dest, src1, src2) dest = (src1 < src2) ? src1 : src2
 NEON_POP(pmin_s8, neon_s8, 4)
 NEON_POP(pmin_u8, neon_u8, 4)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 00c04425c1..63f7a59f94 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10967,6 +10967,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x04: /* SHSUB, UHSUB */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhsub, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shsub, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11044,16 +11051,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x4: /* SHSUB, UHSUB */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_hsub_s8, gen_helper_neon_hsub_u8 },
-                    { gen_helper_neon_hsub_s16, gen_helper_neon_hsub_u16 },
-                    { gen_helper_neon_hsub_s32, gen_helper_neon_hsub_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             default:
                 g_assert_not_reached();
             }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 29e5c4a0a3..d59d5804c5 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -843,6 +843,8 @@ DO_3SAME_NO_SZ_3(VPMAX_U, gen_gvec_umaxp)
 DO_3SAME_NO_SZ_3(VPMIN_U, gen_gvec_uminp)
 DO_3SAME_NO_SZ_3(VHADD_S, gen_gvec_shadd)
 DO_3SAME_NO_SZ_3(VHADD_U, gen_gvec_uhadd)
+DO_3SAME_NO_SZ_3(VHSUB_S, gen_gvec_shsub)
+DO_3SAME_NO_SZ_3(VHSUB_U, gen_gvec_uhsub)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -953,8 +955,6 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
         FUNC(d, tcg_env, n, m);                                         \
     }
 
-DO_3SAME_32(VHSUB_S, hsub_s)
-DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
 DO_3SAME_32(VRHADD_U, rhadd_u)
 
-- 
2.34.1



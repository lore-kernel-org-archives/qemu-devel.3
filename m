Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AD6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3moI-0003RY-HK; Sun, 05 May 2024 21:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mn2-000070-Vh
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:23 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmS-0002aB-OW
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:10 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2b4a7671abaso875776a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957475; x=1715562275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uheJjsxMAkyDDdCobh1GQO5LshMhzLmNho1t3DewMNE=;
 b=HwdHmJA3c8ylt2knWZZy4oKQ9cYYaKcSopzYRh/ATx+fq5/E5vD+LovC1o4Ea7LrkI
 tQVzlnSjE3+9p0FGYBJ3p2Cl8aA5BsCcdMSJZRB0lO+GG+5TlvAaUpzZhLStA7X1E5ct
 dRWXJrohbZRyj8pCcvQVU+BHLC8xSBqWrt0dl6Y8zVlfj4pq+c+m1AbbPWZStL04cobN
 wGQBu+uB++XBCrmCdRcyMpPGpAMtGoF1VaofS46YjBoLTCBNkbDhmxTXdgiFe5cqQBmf
 uUu5f2znk5j7okEye8B0uO44eXIubycLC1tqRPukD6X3OR/7eEMGIeSjsL6pqdYLu08J
 aCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957475; x=1715562275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uheJjsxMAkyDDdCobh1GQO5LshMhzLmNho1t3DewMNE=;
 b=HQgRoqVxw5zwTOBtz5QqLRh85TfcgAZPWqhXXfvj+/yAawEnSRe+JZ0pMESh5qeDdP
 VBgL4qqiLl1T1p40BQeTEAzo9uWNuF114I6dpZzv9WnZtj8cWR8nvfpIV3XqVA/2Wol3
 ywSKYfloSUgTYujoa2lkIk1UigM/wb1jm1xRkQytSyR1+N7TJ3yaOCh/RIef40Vs2U5Q
 uddy414ZuE2SRHqTECVON6ri8vBw6ldlZJCEwtIG+3+gGmCT0rzeJSOiu6eoWyjV8nPp
 H2WGglW6QqZiSoyPr6PeVBeMgTnE9XzDT92m/m0/bYrAjpVxkwl1I+ZoBiR7ulF7ahB8
 yxtQ==
X-Gm-Message-State: AOJu0YyUzFYewg5TncObZaox+cOKjfCWHvJkB8/hRgHdOtZVRmBV047W
 0Zdm/RhOVWvKQrBKTsAp55ATSubk693Gha0xtFwp63ydJLnJjMs5CSmtIjx5wyg2NGC7bC5wN5s
 J
X-Google-Smtp-Source: AGHT+IHH3kqt6AM6atjjMpptNV89Z28J9/ltHbThARpv5bAmtL3NwU2oJKuE9SzzSaLqjTLDds1zKg==
X-Received: by 2002:a17:90a:2f43:b0:2af:3c0e:f6b8 with SMTP id
 s61-20020a17090a2f4300b002af3c0ef6b8mr7401301pjd.3.1714957475296; 
 Sun, 05 May 2024 18:04:35 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 37/57] target/arm: Convert SRSHL and URSHL (register) to gvec
Date: Sun,  5 May 2024 18:03:43 -0700
Message-Id: <20240506010403.6204-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/helper.h             | 10 +++++++++
 target/arm/tcg/translate.h      |  4 ++++
 target/arm/tcg/neon-dp.decode   | 10 ++-------
 target/arm/tcg/gengvec.c        | 22 +++++++++++++++++++
 target/arm/tcg/neon_helper.c    | 38 ++++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-a64.c  | 17 ++++++---------
 target/arm/tcg/translate-neon.c |  6 ++----
 7 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index a14c040451..25eb7bf5df 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -327,6 +327,16 @@ DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
 DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
 
+DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_srshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_srshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_urshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_urshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_urshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_urshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_2(neon_add_u8, i32, i32, i32)
 DEF_HELPER_2(neon_add_u16, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 87439dcc61..ea63ffc47b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -459,6 +459,10 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_srshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_urshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/neon-dp.decode b/target/arm/tcg/neon-dp.decode
index fd3a01bfa0..8525c65c0d 100644
--- a/target/arm/tcg/neon-dp.decode
+++ b/target/arm/tcg/neon-dp.decode
@@ -117,14 +117,8 @@ VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
   VQSHL_U64_3s   1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
   VQSHL_U_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_rev
 }
-{
-  VRSHL_S64_3s   1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
-  VRSHL_S_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_rev
-}
-{
-  VRSHL_U64_3s   1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
-  VRSHL_U_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_rev
-}
+VRSHL_S_3s       1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_rev
+VRSHL_U_3s       1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_rev
 {
   VQRSHL_S64_3s  1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
   VQRSHL_S_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_rev
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 66a514ba86..d9a9132722 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1217,6 +1217,28 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+void gen_gvec_srshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[] = {
+        gen_helper_gvec_srshl_b, gen_helper_gvec_srshl_h,
+        gen_helper_gvec_srshl_s, gen_helper_gvec_srshl_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
+
+void gen_gvec_urshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[] = {
+        gen_helper_gvec_urshl_b, gen_helper_gvec_urshl_h,
+        gen_helper_gvec_urshl_s, gen_helper_gvec_urshl_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
+
 void gen_uqadd_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
 {
     uint64_t max = MAKE_64BIT_MASK(0, 8 << esz);
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 0af15e9f6e..516ecc1dcb 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -6,10 +6,11 @@
  *
  * This code is licensed under the GNU GPL v2.
  */
-#include "qemu/osdep.h"
 
+#include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
@@ -117,6 +118,17 @@ NEON_VOP_BODY(vtype, n)
 uint32_t HELPER(glue(neon_,name))(CPUARMState *env, uint32_t arg1, uint32_t arg2) \
 NEON_VOP_BODY(vtype, n)
 
+#define NEON_GVEC_VOP2(name, vtype) \
+void HELPER(name)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    vtype *d = vd, *n = vn, *m = vm;                            \
+    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
+        NEON_FN(d[i], n[i], m[i]);                              \
+    }                                                           \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
+}
+
 /* Pairwise operations.  */
 /* For 32-bit elements each segment only contains a single element, so
    the elementwise and pairwise operations are the same.  */
@@ -263,11 +275,23 @@ NEON_VOP(shl_s16, neon_s16, 2)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 8, true, NULL))
 NEON_VOP(rshl_s8, neon_s8, 4)
+NEON_GVEC_VOP2(gvec_srshl_b, int8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 16, true, NULL))
 NEON_VOP(rshl_s16, neon_s16, 2)
+NEON_GVEC_VOP2(gvec_srshl_h, int16_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, (int8_t)src2, 32, true, NULL))
+NEON_GVEC_VOP2(gvec_srshl_s, int32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_d(src1, (int8_t)src2, true, NULL))
+NEON_GVEC_VOP2(gvec_srshl_d, int64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_rshl_s32)(uint32_t val, uint32_t shift)
@@ -283,11 +307,23 @@ uint64_t HELPER(neon_rshl_s64)(uint64_t val, uint64_t shift)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 8, true, NULL))
 NEON_VOP(rshl_u8, neon_u8, 4)
+NEON_GVEC_VOP2(gvec_urshl_b, uint8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 16, true, NULL))
 NEON_VOP(rshl_u16, neon_u16, 2)
+NEON_GVEC_VOP2(gvec_urshl_h, uint16_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, (int8_t)src2, 32, true, NULL))
+NEON_GVEC_VOP2(gvec_urshl_s, int32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_d(src1, (int8_t)src2, true, NULL))
+NEON_GVEC_VOP2(gvec_urshl_d, int64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_rshl_u32)(uint32_t val, uint32_t shift)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fd36137e10..eab28c04b9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10931,6 +10931,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x0a: /* SRSHL, URSHL */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urshl, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srshl, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11081,16 +11088,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0xa: /* SRSHL, URSHL */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_rshl_s8, gen_helper_neon_rshl_u8 },
-                    { gen_helper_neon_rshl_s16, gen_helper_neon_rshl_u16 },
-                    { gen_helper_neon_rshl_s32, gen_helper_neon_rshl_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0xb: /* SQRSHL, UQRSHL */
             {
                 static NeonGenTwoOpEnvFn * const fns[3][2] = {
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 18b048611b..337488bbf1 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -794,6 +794,8 @@ DO_3SAME(VQADD_S, gen_gvec_sqadd_qc)
 DO_3SAME(VQADD_U, gen_gvec_uqadd_qc)
 DO_3SAME(VQSUB_S, gen_gvec_sqsub_qc)
 DO_3SAME(VQSUB_U, gen_gvec_uqsub_qc)
+DO_3SAME(VRSHL_S, gen_gvec_srshl)
+DO_3SAME(VRSHL_U, gen_gvec_urshl)
 
 /* These insns are all gvec_bitsel but with the inputs in various orders. */
 #define DO_3SAME_BITSEL(INSN, O1, O2, O3)                               \
@@ -929,8 +931,6 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
     }                                                                   \
     DO_3SAME_64(INSN, gen_##INSN##_elt)
 
-DO_3SAME_64(VRSHL_S64, gen_helper_neon_rshl_s64)
-DO_3SAME_64(VRSHL_U64, gen_helper_neon_rshl_u64)
 DO_3SAME_64_ENV(VQSHL_S64, gen_helper_neon_qshl_s64)
 DO_3SAME_64_ENV(VQSHL_U64, gen_helper_neon_qshl_u64)
 DO_3SAME_64_ENV(VQRSHL_S64, gen_helper_neon_qrshl_s64)
@@ -999,8 +999,6 @@ DO_3SAME_32(VHSUB_S, hsub_s)
 DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
 DO_3SAME_32(VRHADD_U, rhadd_u)
-DO_3SAME_32(VRSHL_S, rshl_s)
-DO_3SAME_32(VRSHL_U, rshl_u)
 
 DO_3SAME_32_ENV(VQSHL_S, qshl_s)
 DO_3SAME_32_ENV(VQSHL_U, qshl_u)
-- 
2.34.1



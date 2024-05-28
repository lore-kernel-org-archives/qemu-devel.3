Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C0AC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3U5-0003Zr-Vs; Tue, 28 May 2024 16:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Tg-00035A-HW
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TQ-0003j8-RK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so1299587b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928267; x=1717533067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agmYnDBLqC0sF1M3RrDhKCZSVpHUfKoNHHwortczt3I=;
 b=URjhpIy06HL+ke1dAvPK1EZW6M5CV4PJc1M4V21JWUVk/5PQMMZePx1rctvC4pgQBN
 lhZxHObumeEmhiokPqDzypsWnJ+qKEL2J6K9LUuOcvWWbT8oLCHy04baQLjoaGI1wIjY
 pwYpxqpkmBogrhEKujXZLbj8X7dWfaiz+8s0yD3MSG+23bHRLY0WXPz4kvyFUOchf4o7
 wsKL3n8hG7qhkVL/qLLgsKWG0pnaajutsb4X5AFr0uoUIekVO4YlW9ZtD3au6gk3dbRz
 PAdtLtS9zmncLmVAKDdBO0azS58OzNXeUE/ZjnzBJvhrIF9CMXmtzZ2kVBufHzXdxKuq
 /grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928267; x=1717533067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agmYnDBLqC0sF1M3RrDhKCZSVpHUfKoNHHwortczt3I=;
 b=KS6zGh023lrtXDDfNqNOGHK9fN7PcTGr8/ZXl9xUJzlDOa1vi3x/QusSZoOlaWXpqy
 PkO4p0iB/LunBzc1PmBqBWjFKM3hLAkoa8K5JF+Iiig0cWxfLiWm7QQPdJSAqVLmLxMV
 fJKP/+133G+MTg52aBs5ifqnkXwekSr62kyEOhVvQ+2SR4J3R0r3YBinasOohZVlw6zS
 ayV7n0pXrulhUg85yOooSs/5YjIyRyw2otnNKBCOD1/Acx7HhaYcOg9jeU46TuBswz/p
 8R2sMLoqL+hCnN8Mme5bhFlcr+IvTp1Un6tXUmHrvi75mC0fMhvcLHCnJHhQxEuh+Ky1
 oSpA==
X-Gm-Message-State: AOJu0YxRBlZDl3xjk9QuLrS4lI6c8VJhh4Z1GMbDxP2Jzb8OlhQk5LAW
 nFKZ/n6Zuc5Exq56HvAxWLoR4tASGbh+gJrrM8fFlrra7mn1wWBOZ5nxn1VhlAQHhBiYp+LRMgp
 H
X-Google-Smtp-Source: AGHT+IE1WerTZera6FdbmPvnBtGiaF4LUJHDnio3GM0N6LtPqQU3DdeCa9ZYQ7C+/mhlqwYARne97g==
X-Received: by 2002:a05:6a20:3242:b0:1b1:f321:47ff with SMTP id
 adf61e73a8af0-1b212d0a7d4mr11263940637.17.1716928267096; 
 Tue, 28 May 2024 13:31:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 24/33] target/arm: Convert SRHADD, URHADD to gvec
Date: Tue, 28 May 2024 13:30:35 -0700
Message-Id: <20240528203044.612851-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |   7 --
 target/arm/tcg/translate.h      |   4 +
 target/arm/tcg/gengvec.c        | 144 ++++++++++++++++++++++++++++++++
 target/arm/tcg/neon_helper.c    |  27 ------
 target/arm/tcg/translate-a64.c  |  48 ++---------
 target/arm/tcg/translate-neon.c |  26 +-----
 6 files changed, 158 insertions(+), 98 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b95f24ed0a..85f9302563 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -268,13 +268,6 @@ DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
 DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
 
 /* neon_helper.c */
-DEF_HELPER_2(neon_rhadd_s8, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_s16, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_u16, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_s32, s32, s32, s32)
-DEF_HELPER_2(neon_rhadd_u32, i32, i32, i32)
-
 DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_u16, i32, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 315e0afd04..3b1e68b779 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -480,6 +480,10 @@ void gen_gvec_shsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_uhsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_srhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_urhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index c46365c3a6..119826bf28 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2149,3 +2149,147 @@ void gen_gvec_uhsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+static void gen_srhadd8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_or_i64(t, a, b);
+    tcg_gen_vec_sar8i_i64(a, a, 1);
+    tcg_gen_vec_sar8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_add8_i64(d, a, b);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_srhadd16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_or_i64(t, a, b);
+    tcg_gen_vec_sar16i_i64(a, a, 1);
+    tcg_gen_vec_sar16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_add16_i64(d, a, b);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_srhadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_or_i32(t, a, b);
+    tcg_gen_sari_i32(a, a, 1);
+    tcg_gen_sari_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_add_i32(d, a, b);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_srhadd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_or_vec(vece, t, a, b);
+    tcg_gen_sari_vec(vece, a, a, 1);
+    tcg_gen_sari_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_add_vec(vece, d, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_srhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 g[] = {
+        { .fni8 = gen_srhadd8_i64,
+          .fniv = gen_srhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_srhadd16_i64,
+          .fniv = gen_srhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_srhadd_i32,
+          .fniv = gen_srhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_urhadd8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_or_i64(t, a, b);
+    tcg_gen_vec_shr8i_i64(a, a, 1);
+    tcg_gen_vec_shr8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_add8_i64(d, a, b);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_urhadd16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_or_i64(t, a, b);
+    tcg_gen_vec_shr16i_i64(a, a, 1);
+    tcg_gen_vec_shr16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_add16_i64(d, a, b);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_urhadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_or_i32(t, a, b);
+    tcg_gen_shri_i32(a, a, 1);
+    tcg_gen_shri_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_add_i32(d, a, b);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_urhadd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_or_vec(vece, t, a, b);
+    tcg_gen_shri_vec(vece, a, a, 1);
+    tcg_gen_shri_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_add_vec(vece, d, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_urhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 g[] = {
+        { .fni8 = gen_urhadd8_i64,
+          .fniv = gen_urhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_urhadd16_i64,
+          .fniv = gen_urhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_urhadd_i32,
+          .fniv = gen_urhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index d1641a5252..082bfd88ad 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -179,33 +179,6 @@ uint32_t HELPER(glue(neon_,name))(uint32_t arg) \
     return arg; \
 }
 
-#define NEON_FN(dest, src1, src2) dest = (src1 + src2 + 1) >> 1
-NEON_VOP(rhadd_s8, neon_s8, 4)
-NEON_VOP(rhadd_u8, neon_u8, 4)
-NEON_VOP(rhadd_s16, neon_s16, 2)
-NEON_VOP(rhadd_u16, neon_u16, 2)
-#undef NEON_FN
-
-int32_t HELPER(neon_rhadd_s32)(int32_t src1, int32_t src2)
-{
-    int32_t dest;
-
-    dest = (src1 >> 1) + (src2 >> 1);
-    if ((src1 | src2) & 1)
-        dest++;
-    return dest;
-}
-
-uint32_t HELPER(neon_rhadd_u32)(uint32_t src1, uint32_t src2)
-{
-    uint32_t dest;
-
-    dest = (src1 >> 1) + (src2 >> 1);
-    if ((src1 | src2) & 1)
-        dest++;
-    return dest;
-}
-
 #define NEON_FN(dest, src1, src2) dest = (src1 < src2) ? src1 : src2
 NEON_POP(pmin_s8, neon_s8, 4)
 NEON_POP(pmin_u8, neon_u8, 4)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6571b999f4..40aa7a9d57 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10915,7 +10915,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    int pass;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -10969,6 +10968,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x02: /* SRHADD, URHADD */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urhadd, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srhadd, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11021,45 +11027,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         return;
     }
-
-    if (size == 3) {
-        g_assert_not_reached();
-    } else {
-        for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-            NeonGenTwoOpFn *genfn = NULL;
-            NeonGenTwoOpEnvFn *genenvfn = NULL;
-
-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
-
-            switch (opcode) {
-            case 0x2: /* SRHADD, URHADD */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_rhadd_s8, gen_helper_neon_rhadd_u8 },
-                    { gen_helper_neon_rhadd_s16, gen_helper_neon_rhadd_u16 },
-                    { gen_helper_neon_rhadd_s32, gen_helper_neon_rhadd_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
-            default:
-                g_assert_not_reached();
-            }
-
-            if (genenvfn) {
-                genenvfn(tcg_res, tcg_env, tcg_op1, tcg_op2);
-            } else {
-                genfn(tcg_res, tcg_op1, tcg_op2);
-            }
-
-            write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-        }
-    }
-    clear_vec_high(s, is_q, rd);
+    g_assert_not_reached();
 }
 
 /* AdvSIMD three same
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index d59d5804c5..f9a8753906 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -845,6 +845,8 @@ DO_3SAME_NO_SZ_3(VHADD_S, gen_gvec_shadd)
 DO_3SAME_NO_SZ_3(VHADD_U, gen_gvec_uhadd)
 DO_3SAME_NO_SZ_3(VHSUB_S, gen_gvec_shsub)
 DO_3SAME_NO_SZ_3(VHSUB_U, gen_gvec_uhsub)
+DO_3SAME_NO_SZ_3(VRHADD_S, gen_gvec_srhadd)
+DO_3SAME_NO_SZ_3(VRHADD_U, gen_gvec_urhadd)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -922,27 +924,6 @@ DO_SHA2(SHA256H, gen_helper_crypto_sha256h)
 DO_SHA2(SHA256H2, gen_helper_crypto_sha256h2)
 DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
 
-#define DO_3SAME_32(INSN, FUNC)                                         \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        static const GVecGen3 ops[4] = {                                \
-            { .fni4 = gen_helper_neon_##FUNC##8 },                      \
-            { .fni4 = gen_helper_neon_##FUNC##16 },                     \
-            { .fni4 = gen_helper_neon_##FUNC##32 },                     \
-            { 0 },                                                      \
-        };                                                              \
-        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece]); \
-    }                                                                   \
-    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
-    {                                                                   \
-        if (a->size > 2) {                                              \
-            return false;                                               \
-        }                                                               \
-        return do_3same(s, a, gen_##INSN##_3s);                         \
-    }
-
 /*
  * Some helper functions need to be passed the tcg_env. In order
  * to use those with the gvec APIs like tcg_gen_gvec_3() we need
@@ -955,9 +936,6 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
         FUNC(d, tcg_env, n, m);                                         \
     }
 
-DO_3SAME_32(VRHADD_S, rhadd_s)
-DO_3SAME_32(VRHADD_U, rhadd_u)
-
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
     WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
     WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##_s32);    \
-- 
2.34.1



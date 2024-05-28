Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D192C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UD-0004DF-QL; Tue, 28 May 2024 16:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Tm-0003Ax-1I
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TW-0003ks-KZ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so1013522b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928272; x=1717533072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XxAxrOkK1zF0OD6pzy6IUaKx6OajSHHLR/9wKuuiPQ=;
 b=L/VuoVwDIfl7j+cOg7hLwI7dq6y43qfh5Zawk1KYe6YzVlhihmqUS2UfAtqLmOQAwJ
 g0RjNDRQwfte1P+Kd/P5YyZHFxPAuogznxhyTCJcmfUS/7eXayzzIjJsp8Zr3m1UIvhO
 ZjxFOJM8b3/ZuqcbJc7u8Kf1BvsuZ81H0jVNWWyYORMZRTEO6lwEasC3SDnzfL0pXy3J
 48GjVH4nt+UVyZYJTio+UZXCpBDNjqudoRp1sPolVCOoLoj1vB6sio6YMlTJabFsC+v9
 1+byG9PJJMZUbSsJ8CN5eGffXJUDkN8D0/U877oe+cSTmREAMwzuJ/YbUffT5wULwK6C
 b1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928272; x=1717533072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XxAxrOkK1zF0OD6pzy6IUaKx6OajSHHLR/9wKuuiPQ=;
 b=FN5zhnVezIW8rgV+LAXc+bdHuPmkx5SlA/11rkc+hMBH7aTr+cEH9k2FpO0QJ1/bD9
 4bbeHl8k1KYSzN1gQjZTX9oJ6030zAL9CB8SsqTRMTmmWdU7VwFWIoE8Qiv8Dpd0s3ie
 6FaoPfpxtyys3yaaW+7LJG8ouyw3TBXMnHOnvRHLXWp8auTCr6PPNr4Itw17t+8nCsIO
 POsMlORodfuvuRS6WW+wdU4q05EWcpGA/NX1/SjpkSUqslkcf7CcoAX1oCIOYQyKriBv
 HaO0j5D0qudwbwSM5oEkmsMwd/CWWgDPledfV/Awxh5Yvh9pXCG1P9J0hwYqQgRvzyPB
 IP1w==
X-Gm-Message-State: AOJu0YxTzJw/w1hd17Ikr5eDqT/wXbT5sej+dZp6lUCIBbnkSh/gQYMC
 7y+p3rOWbylcQpGPqyNUFHMxfoQx5W2D5GheEVIUxu2kvpjxp4yMmd9+OjBJSmiW4KwRjoBWBHq
 u
X-Google-Smtp-Source: AGHT+IEIYRF9D8AgqyAX7s7VbSs0UMvC5nawkk+TJhX+Gl1K4AZIhdZ++N7QLcx2CxjAaveDc5iovQ==
X-Received: by 2002:a05:6a20:9d8e:b0:1b1:ec00:dac8 with SMTP id
 adf61e73a8af0-1b212df058amr12726988637.27.1716928272053; 
 Tue, 28 May 2024 13:31:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 30/33] target/arm: Tidy SQDMULH, SQRDMULH (vector)
Date: Tue, 28 May 2024 13:30:41 -0700
Message-Id: <20240528203044.612851-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

We already have a gvec helper for the operations, but we aren't
using it on the aa32 neon side.  Create a unified expander for
use by both aa32 and aa64 translators.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  4 ++++
 target/arm/tcg/gengvec.c        | 20 ++++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 23 ++++-------------------
 target/arm/tcg/translate-neon.c | 23 +++--------------------
 4 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3b1e68b779..aba21f730f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -539,6 +539,10 @@ void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sqdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqrdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 119826bf28..56a1dc1f75 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -35,6 +35,26 @@ static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                        opr_sz, max_sz, 0, fn);
 }
 
+void gen_gvec_sqdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_neon_sqdmulh_h, gen_helper_neon_sqdmulh_s
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
+}
+
+void gen_gvec_sqrdmulh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_neon_sqrdmulh_h, gen_helper_neon_sqrdmulh_s
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
+}
+
 void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c4601cde2f..c673b95ec7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -724,19 +724,6 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
-/* Expand a 3-operand + qc + operation using an out-of-line helper.  */
-static void gen_gvec_op3_qc(DisasContext *s, bool is_q, int rd, int rn,
-                            int rm, gen_helper_gvec_3_ptr *fn)
-{
-    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(qc_ptr, tcg_env, offsetof(CPUARMState, vfp.qc));
-    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm), qc_ptr,
-                       is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
-}
-
 /* Expand a 4-operand operation using an out-of-line helper.  */
 static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
                              int rm, int ra, int data, gen_helper_gvec_4 *fn)
@@ -11007,12 +10994,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x16: /* SQDMULH, SQRDMULH */
-        {
-            static gen_helper_gvec_3_ptr * const fns[2][2] = {
-                { gen_helper_neon_sqdmulh_h, gen_helper_neon_sqrdmulh_h },
-                { gen_helper_neon_sqdmulh_s, gen_helper_neon_sqrdmulh_s },
-            };
-            gen_gvec_op3_qc(s, is_q, rd, rn, rm, fns[size - 1][u]);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmulh_qc, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqdmulh_qc, size);
         }
         return;
     }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index f9a8753906..915c9e56db 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -937,28 +937,11 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
     }
 
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
-    WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
-    WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##_s32);    \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        static const GVecGen3 ops[2] = {                                \
-            { .fni4 = gen_##INSN##_tramp16 },                           \
-            { .fni4 = gen_##INSN##_tramp32 },                           \
-        };                                                              \
-        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece - 1]); \
-    }                                                                   \
     static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
-    {                                                                   \
-        if (a->size != 1 && a->size != 2) {                             \
-            return false;                                               \
-        }                                                               \
-        return do_3same(s, a, gen_##INSN##_3s);                         \
-    }
+    { return a->size >= 1 && a->size <= 2 && do_3same(s, a, FUNC); }
 
-DO_3SAME_VQDMULH(VQDMULH, qdmulh)
-DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
+DO_3SAME_VQDMULH(VQDMULH, gen_gvec_sqdmulh_qc)
+DO_3SAME_VQDMULH(VQRDMULH, gen_gvec_sqrdmulh_qc)
 
 #define WRAP_FP_GVEC(WRAPNAME, FPST, FUNC)                              \
     static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
-- 
2.34.1



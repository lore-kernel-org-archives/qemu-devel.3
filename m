Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE8BC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeJD-0003Ij-4S; Fri, 24 May 2024 19:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeI7-00088V-Eb
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:39 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHv-0006xq-AO
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f8f34cb0beso1044755b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593118; x=1717197918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp3TcZ1kWdRpY1y4Aio9ns2hoAb/sdOSYuGPHJgSHnk=;
 b=vsq4SrboSP8D7XxuB/3nWMdkxwUbsgwuA6oQg5vX5p1U7g2mbJV8EITnoo4jXXhFKV
 zII3PnNpiFjiITfTu6B+5gbSKaLc3NqBD/1R/MgB5W5s7AQdZHC5UW/f8uoc9utIsW/s
 nKXMnvqqKXd9X8EFYP0ARJ/y2hx4y6AhVobto1cChoa/KZAv+MDrMLva7sV/u1jzeu8a
 pTd8Zgm1v9kGkzBcnHSVs69fv5S1+toOpLP7tAInE7sBKlIpmdgEMleHN2T0gC7xwWmh
 199UxSbnartf5s1mz68TArek11QIzIezTob3biKTy6FxcpWIYXZowe7N98XnL3dD4pUD
 EqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593118; x=1717197918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp3TcZ1kWdRpY1y4Aio9ns2hoAb/sdOSYuGPHJgSHnk=;
 b=WAZ1Y4E2CHLEFK8sW0xrBR9wgd9JiWJqTzdPN7tI26MAXdeii0CchIcKCYPdab9/mb
 mx8lrYI3T0xxyvevYkBSdTyP5+ms6OfCQzItx3g9xpCm3SmtW7XnpVMnVHkuphH1nTzN
 Nio63xRh0zrCCd13PpCf75+rSgL0Mh1sZR5bu501Ux1PC7UmalCHPnPlGaJBFFUAPp1D
 a02Kxri3709r/r8YAILhOE1NNd2Gbt3T4/Pbgg/jRYttFjWGxjd/I2tlqbxgY4RoyhlB
 2IqiSNphr5EGo62noCOvFpP8y+9QtLV1Ca3kFdWmJkRvkSqeGNNRWHuUHtuDK45mGQNs
 k2IQ==
X-Gm-Message-State: AOJu0YwF57JT6kfi0TfZ9joyLPq2dAM4uRPtG8348MtIHc/0cqrFG2EL
 oR2lnEn6qnZfKFdPhyeulwXGQh2jtnWzNJT4+j6zFB8iFoVzZZmn/woqcDsCgRYMkR9ZWD+/E0A
 /
X-Google-Smtp-Source: AGHT+IEFdzJ1lB3NLD8pQLgs9u0VRq0s5FtDa6c3bVCfuLFFwCoK/cGI4G0obulU+JzkbFdSWGSzhw==
X-Received: by 2002:a05:6a21:1a0:b0:1ac:3b81:2b5a with SMTP id
 adf61e73a8af0-1b212ce1d9cmr5680651637.8.1716593118298; 
 Fri, 24 May 2024 16:25:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 64/67] target/arm: Tidy SQDMULH, SQRDMULH (vector)
Date: Fri, 24 May 2024 16:21:18 -0700
Message-Id: <20240524232121.284515-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

We already have a gvec helper for the operations, but we aren't
using it on the aa32 neon side.  Create a unified expander for
use by both aa32 and aa64 translators.

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
index 32caabd126..462c185f9a 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -34,6 +34,26 @@ static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
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



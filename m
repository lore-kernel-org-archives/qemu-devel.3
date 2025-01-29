Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B2BC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx34-0000xG-Pt; Tue, 28 Jan 2025 20:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx33-0000wS-DV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:21 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx31-0003ao-Nk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165448243fso135574925ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114758; x=1738719558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyXIzV33gyYu8Yx/Zaoosm62k8fnxSLH8R4umO1CXbY=;
 b=hnaadgNo8llYo1lDH5Zmn0Gy9n1CxXS7L8bt3m0Xx4AwOAQ77PErSe3UJpczKJCjB9
 bMLHa51BnwxKd+QJWAJ+6ppEuvQP4plUh24+fs/pUHsRTLZI3WWcAp0Tf6qSSnMIjlx0
 AFgXF5MxX47xU80xINv8XmSazEz4qAba4qVdMlkKuS88nItmmJOfphBAJ6tUDjsvO0mc
 7YzzN6yk+lDXD1+bbTwzz2rG6en6KolYxLqtZiUXJXFUZdo1gzRqq2JTVwyzORZNsWRW
 9jWzTj8+1Gzghas6iYRk5AIeTIh5Xqdc/GD4taMN4lJPi1kZmvOSxiqlqzBpyfWvocNc
 cFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114758; x=1738719558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyXIzV33gyYu8Yx/Zaoosm62k8fnxSLH8R4umO1CXbY=;
 b=JJq3viDFXbdKCXFZ55pbpjn8ZRhvYV9w43bKRyt/3TNxjj1IYvUpuWUEPFQv5GzdfL
 eaLJta6pNHKGkWk8L/8lnel8pKqwjFRAuCH0+8T9c1Ys+tRcygD9euzyNp08uvDALfuh
 oWpdiOexOMAbzJvZ1AVi4+uUuTPZfRwj3ODcn55wi0LyeQiw8ZHLGA0f8dEmogBOVObP
 yEgzUqjvT0ky3ZJh9jOzfTShjttSJ26hJ1TcQWC2Ut5wRZf9A8ymty75qNj5cqezA9BL
 dA3TUCimL+uviAESyaKPZKYwLOs0O0qukBapsO3Wd7Fbhg2HPR4iCeJmis/Qe0PFQ+Qf
 jKOg==
X-Gm-Message-State: AOJu0YxRGbnqt+bIhMrYzlnTt4mHyN/3L8kRMueyI6FHEstvpZDk9NZb
 Jlw5Diq8l0ZVrdvUZ81J6duNK3XrU/l3f6Hdu5lMltEb7IKkRKWDJ1CFKNdLsWhl86wEHmXBVso
 a
X-Gm-Gg: ASbGnctsUAckOdmf1/W6sh+EjJORzxaEGhBYXFoIQxecLZqGKYd4kykKE+T7PVSQNYd
 Vcx2r0xdwUUwFsRQWf2oeTa3GJJx7PPvn5bllTKa1UmDxbfFd81SYqhgnXwHUM24sZyHZqpKZYr
 IGsffQ813MyhKc3CINd6pif5AcbLpQJl6260RrvyxexxWEiLXl268mI6Vxs/oTX+VBE4Ae0VCf5
 XEUee8ltfEzygjmamNaT6omyhU+1s/55JXADXTWRec+lzJU1fJJUZ+fFwHm2sOcyyYEkmk6XMjo
 2/9uQGmsOeds4YEyjNPROjGjY7B+AAkWcGP8roKk6CMTGFPzAg==
X-Google-Smtp-Source: AGHT+IEq1/dKXMyEs4Hrm5fvcwN3uSaPfcUpEtl5VlgMQgUX3Xie/UT+5wgkH4sQc35ls8Y5dMUEyA==
X-Received: by 2002:a17:903:2f84:b0:216:3e87:c9fc with SMTP id
 d9443c01a7336-21dd7c4c204mr21786515ad.5.1738114758443; 
 Tue, 28 Jan 2025 17:39:18 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 29/34] Revert "target/arm: Handle FPCR.AH in FMLSL"
Date: Tue, 28 Jan 2025 17:38:52 -0800
Message-ID: <20250129013857.135256-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reverts commit c5eb0b62e603c1d391ee2199108f0eb34aadc8f5.
---
 target/arm/tcg/translate-a64.c |  4 ++--
 target/arm/tcg/vec_helper.c    | 28 ++++------------------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9b1675b041..d27b4e964d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5997,7 +5997,7 @@ TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
-        int data = (s->fpcr_ah << 2) | (is_2 << 1) | is_s;
+        int data = (is_2 << 1) | is_s;
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm), tcg_env,
@@ -6772,7 +6772,7 @@ TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
 static bool do_fmlal_idx(DisasContext *s, arg_qrrx_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
-        int data = (s->fpcr_ah << 5) | (a->idx << 2) | (is_2 << 1) | is_s;
+        int data = (a->idx << 2) | (is_2 << 1) | is_s;
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm), tcg_env,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 728473e919..b3ed6533bb 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2120,26 +2120,6 @@ static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
     return ptr[is_q & is_2] >> ((is_2 & ~is_q) << 5);
 }
 
-static uint64_t neg4_f16(uint64_t v, bool fpcr_ah)
-{
-    /*
-     * Negate all inputs for FMLSL at once. This is slightly complicated
-     * by the need to avoid flipping the sign of a NaN when FPCR.AH == 1
-     */
-    uint64_t mask = 0x8000800080008000ull;
-    if (fpcr_ah) {
-        uint64_t tmp = v, signbit = 0x8000;
-        for (int i = 0; i < 4; i++) {
-            if (float16_is_any_nan(extract64(tmp, 0, 16))) {
-                mask ^= signbit;
-            }
-            tmp >>= 16;
-            signbit <<= 16;
-        }
-    }
-    return v ^ mask;
-}
-
 /*
  * Note that FMLAL requires oprsz == 8 or oprsz == 16,
  * as there is not yet SVE versions that might use blocking.
@@ -2151,7 +2131,6 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
     intptr_t i, oprsz = simd_oprsz(desc);
     int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
     int is_q = oprsz == 16;
     uint64_t n_4, m_4;
 
@@ -2159,8 +2138,9 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
     n_4 = load4_f16(vn, is_q, is_2);
     m_4 = load4_f16(vm, is_q, is_2);
 
+    /* Negate all inputs for FMLSL at once.  */
     if (is_s) {
-        n_4 = neg4_f16(n_4, fpcr_ah);
+        n_4 ^= 0x8000800080008000ull;
     }
 
     for (i = 0; i < oprsz / 4; i++) {
@@ -2212,7 +2192,6 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
     int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int index = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
-    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 5, 1);
     int is_q = oprsz == 16;
     uint64_t n_4;
     float32 m_1;
@@ -2220,8 +2199,9 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
     /* Pre-load all of the f16 data, avoiding overlap issues.  */
     n_4 = load4_f16(vn, is_q, is_2);
 
+    /* Negate all inputs for FMLSL at once.  */
     if (is_s) {
-        n_4 = neg4_f16(n_4, fpcr_ah);
+        n_4 ^= 0x8000800080008000ull;
     }
 
     m_1 = float16_to_float32_by_bits(((float16 *)vm)[H2(index)], fz16);
-- 
2.43.0



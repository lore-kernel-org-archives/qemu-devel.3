Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA1C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6Q-0007Gd-O1; Tue, 11 Feb 2025 11:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5a-0006UB-Rc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5Y-00038c-Qp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso38875475e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291179; x=1739895979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jcj6yHICioskvhK/l/YSa7/BamYw6z9ASe3319I7LW8=;
 b=AuvM0CzzizTUmURfXaazvhBBQN8ojvhH7kGgl7nWGnz6HehXwtMFTvp1AA6ZwjCeg1
 iqzc2OFcNFcLlSayNaVjTbnXhjF6EreY6Fc5f93981BIEtJjqVTNgckvRJJBM8vZCI3O
 kGSU3CGdkOAs1ojlOONNhRhbKdM+sMqZxcP7NGEZgcmGPjy2Q2f0NFV5CP/FVez8TIp0
 vfOfQo5A6+F+EbSc+ONMluTcdMpVk0JiD0tMmKdLVAxfS8poPotD7O4OTeCP5/eVT0Ag
 udcrPv+tsV2gp+0iUYOA6uzfpWTUDv7ok23Kvrd3vfIqV40K3UN8orDT4QbnLGUQ8F7x
 nyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291179; x=1739895979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jcj6yHICioskvhK/l/YSa7/BamYw6z9ASe3319I7LW8=;
 b=aOUVGko8e2ZLarNQ2VC0Wd9wU/BJUI27X4I/Fzyw9qpz+DJIaK6O/f5o9EWMd5YGZg
 XRyUzBodhY3tiKoGGc5EYB8aIPnlTTVH5WnBhWcklOXz+8WPLUTsnwgDL44Es/i7P7Zd
 TGpJSijy/V6QZqWZ961mjvmSCKQmBBVP6YhhvPqRJqcBCenCTc8GAvl0R8tYLkzvMixg
 H70c8wI18G2CC9rKYhiE9hDlUcqgoQTLY/pJUngGYXskka1zD13YL5XpU5PSZ6oQn3ol
 fN7pzDtmoGsGaFj4mtZdFc9N91eoOvDX9eXjsh76gDWwuFuKQaV70BqSQADGVVO1X5xf
 ejEg==
X-Gm-Message-State: AOJu0Yy7EqDMfSRhjztzFZ8H1Y2C5zjRRNgeOXsBH/2O9xuToqw4htr9
 KaJmX5nH86T0g8/2YTbfO2UkwlwmRH3EMnvfyfQES2U7PT+mFvXpjqxWO8r7irhLIqL8IRfjAYd
 8
X-Gm-Gg: ASbGncvhqpqzADZH34nDecXHr5nzxa5uOEZOjGFtn9XYLrwx1TO9AGNpc+A++mEIxze
 0eCvNelAgoTik69yr2mBu1XUmw8XlVCJuJr8STXYU+c2MqoyURhP+k1H/9tjSMmVAgtaQ20X0qp
 PgyPFkpPXAlyEoLpR3Iedcgu3g2E1t0zjogQtgLNx531vzJlgYWlTVtC8qPkew+S9t276OkSKMP
 kk8Z3B5k4JoYdtxTrvOkm52kSppk8CwjpMV5yE7CNfw6g93R+wzfq4y97Oy8yaCrvXhjSxKKkaS
 3AVqzpVeBM9LdMOW3TaE
X-Google-Smtp-Source: AGHT+IFuB9o+mUiZmFtb0HrnUIe8FGqlPoRk4/7PyuHlWtJ+/5Jis8Ik6RhTGiQW5HG2phZ+HgWXRQ==
X-Received: by 2002:a05:600c:a013:b0:439:3c71:16a6 with SMTP id
 5b1f17b1804b1-4393c711a1cmr103315265e9.29.1739291179300; 
 Tue, 11 Feb 2025 08:26:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/68] target/arm: Handle FPCR.NEP for FCVTXN (scalar)
Date: Tue, 11 Feb 2025 16:25:07 +0000
Message-Id: <20250211162554.4135349-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Unlike the other users of do_2misc_narrow_scalar(), FCVTXN (scalar)
is always double-to-single and must honour FPCR.NEP.  Implement this
directly in a trans function rather than using
do_2misc_narrow_scalar().

We still need gen_fcvtxn_sd() and the f_scalar_fcvtxn[] array for
the FCVTXN (vector) insn, so we move those down in the file to
where they are used.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3195cb5fef1..ac8196136c4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9247,24 +9247,21 @@ static ArithOneOp * const f_scalar_uqxtn[] = {
 };
 TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
 
-static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+static bool trans_FCVTXN_s(DisasContext *s, arg_rr_e *a)
 {
-    /*
-     * 64 bit to 32 bit float conversion
-     * with von Neumann rounding (round to odd)
-     */
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_A64));
-    tcg_gen_extu_i32_i64(d, tmp);
+    if (fp_access_check(s)) {
+        /*
+         * 64 bit to 32 bit float conversion
+         * with von Neumann rounding (round to odd)
+         */
+        TCGv_i64 src = read_fp_dreg(s, a->rn);
+        TCGv_i32 dst = tcg_temp_new_i32();
+        gen_helper_fcvtx_f64_to_f32(dst, src, fpstatus_ptr(FPST_A64));
+        write_fp_sreg_merging(s, a->rd, a->rd, dst);
+    }
+    return true;
 }
 
-static ArithOneOp * const f_scalar_fcvtxn[] = {
-    NULL,
-    NULL,
-    gen_fcvtxn_sd,
-};
-TRANS(FCVTXN_s, do_2misc_narrow_scalar, a, f_scalar_fcvtxn)
-
 #undef WRAP_ENV
 
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
@@ -9366,11 +9363,27 @@ static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
+static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    /*
+     * 64 bit to 32 bit float conversion
+     * with von Neumann rounding (round to odd)
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_A64));
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
 static ArithOneOp * const f_vector_fcvtn[] = {
     NULL,
     gen_fcvtn_hs,
     gen_fcvtn_sd,
 };
+static ArithOneOp * const f_scalar_fcvtxn[] = {
+    NULL,
+    NULL,
+    gen_fcvtxn_sd,
+};
 TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
 TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
-- 
2.34.1



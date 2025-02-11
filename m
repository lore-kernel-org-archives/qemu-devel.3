Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497EBC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5x-0006i3-84; Tue, 11 Feb 2025 11:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5d-0006Ve-Af
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:25 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5b-00039M-Eu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394c192285so10766285e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291182; x=1739895982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yTAezoHOP/iCLVoLliWF3UtQZzqr33hZzleMgsTBjew=;
 b=MvKcCMl4d9aMjRlVNE8EfldDbwH1Hhffb7NeWznumS2n0ebpaiRMAOR6gk6/+aMkr1
 0FfdJUpvExEgxnp65aZgDlp3wcgCZpit0g7i5TZOr3mPfaz9KQmi2KdPF4X5dc+Tnlb3
 KRvCywPDpZS/Jyf7+KnZBDRfcN029lACHcpenAulOP/vz5z7qQR3+tKC5X2WPF1OH4a+
 oOvjkwejpA69nxu/uUswC/aZRBGkHXgvvul/MZc30vam/3YnWKIiWuO/n4BdINBW1kM2
 zpBY057eFiBPO2B3MffWMCpmEF3yfYwlHkVBPitkHw4Bo1wHrXvNtEEFd1X33O5ZslfY
 AsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291182; x=1739895982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTAezoHOP/iCLVoLliWF3UtQZzqr33hZzleMgsTBjew=;
 b=V8gth3RlSEVotSw5SQ3gLvtZT4AbXFnHnsWQ3Qaq72k6zJ0M8O9qZiSGvoa3VjvXeF
 DadMBmeO9BtiIFDWGEHdo7PKuELrk4fGTMCc7qVH8mWpw3Nuzu5ymX26ODXX0Hk6C0Fb
 cN/ed4LOvW/h/eq/TCX7R7PCdB5ZouMrsN6U9Zbw/D0GQG50wcj5+ypBFHmhFs4mzOAG
 wErTevpzWrwatcFrjXq/828zFVYuQVv3pHKWFf/9qqVZO0AkgdBYZmlEh1dTubJFkGZ3
 3yJrtLnBYe6VdIN1SocPRoYNAgUGX2GnOPkWgTaj5rWsG6khnauCDZHAwbGfr/GYv1OZ
 K7Hg==
X-Gm-Message-State: AOJu0Yyh2HVzUt9uApJvkzYZldza36ToXUhFGh+LaJ4049M0VM/WqZdo
 pCdQbgRqpM470aDzAVdWrBcUChR9KX+eFCpRxUDZ4RkocMXpIbkCQhQWa++dugrD8yUDxGzIyxo
 S
X-Gm-Gg: ASbGncvbsgNoTm9lF/V+wdyqq8BPdkCBVAkbj+r1Naa0IkbWiUPNkc1PuC5V/q9dZcp
 ylDDrVBN5ouDF+PP6XgeQ/LYIMPqxlby+EXwEAcE3G/5pQyIcGFlsagUtpKvvN9MX1tGOeIYXhy
 fL6h9sUsHH3tP+qZ03PBK2M6+tIm+sIeFR7X9Y8U2Q0FREY6fdqu0c6ESffxRJ7il5h8Rm/RTIh
 JEv2uv3u5UqKzA6iCX5AoorDXzkedq3pGkOKBR0mqLonB1/hr4cI61SsQv3U+PAYJm0YrvhKoq5
 cmsK2MFku6a7mS23ACRS
X-Google-Smtp-Source: AGHT+IFs2QOBW8wC2DDGUALrOrgJm+HDmZ7ZF+AHAN+tetNy6oE3Ttls+omejE8bReUbPmGu1OSe/w==
X-Received: by 2002:a05:6000:1ac9:b0:38d:db8b:f518 with SMTP id
 ffacd0b85a97d-38ddb8bf750mr9272238f8f.22.1739291182004; 
 Tue, 11 Feb 2025 08:26:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/68] target/arm: Implement FPCR.AH semantics for vector
 FMIN/FMAX
Date: Tue, 11 Feb 2025 16:25:10 +0000
Message-Id: <20250211162554.4135349-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Implement the FPCR.AH == 1 semantics for vector FMIN/FMAX, by
creating new _ah_ versions of the gvec helpers which invoke the
scalar fmin_ah and fmax_ah helpers on each element.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 21 +++++++++++++++++++--
 target/arm/tcg/vec_helper.c    |  8 ++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index fea43b319c3..f1b4606f763 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -972,6 +972,20 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fmax_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmax_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmax_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_fmin_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmin_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmin_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 89f061d20b8..24695ab55b6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5596,6 +5596,13 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
                                        FPST_A64_F16 : FPST_A64);
 }
 
+static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
+                              gen_helper_gvec_3_ptr * const fnormal[3],
+                              gen_helper_gvec_3_ptr * const fah[3])
+{
+    return do_fp3_vector(s, a, data, s->fpcr_ah ? fah : fnormal);
+}
+
 static bool do_fp3_vector_ah(DisasContext *s, arg_qrrr_e *a, int data,
                              gen_helper_gvec_3_ptr * const f[3])
 {
@@ -5636,14 +5643,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[3] = {
     gen_helper_gvec_fmax_s,
     gen_helper_gvec_fmax_d,
 };
-TRANS(FMAX_v, do_fp3_vector, a, 0, f_vector_fmax)
+static gen_helper_gvec_3_ptr * const f_vector_fmax_ah[3] = {
+    gen_helper_gvec_ah_fmax_h,
+    gen_helper_gvec_ah_fmax_s,
+    gen_helper_gvec_ah_fmax_d,
+};
+TRANS(FMAX_v, do_fp3_vector_2fn, a, 0, f_vector_fmax, f_vector_fmax_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[3] = {
     gen_helper_gvec_fmin_h,
     gen_helper_gvec_fmin_s,
     gen_helper_gvec_fmin_d,
 };
-TRANS(FMIN_v, do_fp3_vector, a, 0, f_vector_fmin)
+static gen_helper_gvec_3_ptr * const f_vector_fmin_ah[3] = {
+    gen_helper_gvec_ah_fmin_h,
+    gen_helper_gvec_ah_fmin_s,
+    gen_helper_gvec_ah_fmin_d,
+};
+TRANS(FMIN_v, do_fp3_vector_2fn, a, 0, f_vector_fmin, f_vector_fmin_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[3] = {
     gen_helper_gvec_fmaxnum_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7330b373c38..9f77aa6b919 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1448,6 +1448,14 @@ DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
 DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
 DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
 
+DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
+DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
+DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
+
+DO_3OP(gvec_ah_fmin_h, helper_vfp_ah_minh, float16)
+DO_3OP(gvec_ah_fmin_s, helper_vfp_ah_mins, float32)
+DO_3OP(gvec_ah_fmin_d, helper_vfp_ah_mind, float64)
+
 #endif
 #undef DO_3OP
 
-- 
2.34.1



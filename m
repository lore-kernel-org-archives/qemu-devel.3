Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC05DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7Z-0002v0-I4; Tue, 11 Feb 2025 11:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5k-0006bz-JI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5i-0003CU-US
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:32 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dcc6bfbccso2495358f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291189; x=1739895989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FPWqbuOd6ILta7Uc49ddiSt/7V5hNojb6b7j9kfC68s=;
 b=Wu3g+fnRF66oTG3feT6wvwlGs/nvqZvU/trydLnQ/X8Gu72wjlqekAW/CSFGfSU30L
 uO8V3BiN3cmWXcYJJY//UutaQmxtBpsH0Yo8WT++TBm6DXB7ptH90zOf/C14B7TNN3vr
 d5jxjPsOu8RUZIPBw8mWYlitoGErPooFp8+Opkbc4oF3pTxQPf/6u36gM/2CRZqhcAHM
 Tyf1l+hap1sqVBvheuj39jgLtbSxvJ2VhpEE7tPaGOOsCoO1aNl6Sz6PeSgYSdOVeY9P
 WxREpSkGXGUErMpSdyGCllk5GTjmQkjrLP6IyMGP9GmudMuxiLfS2jqnjefUSExwawU0
 9M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291189; x=1739895989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPWqbuOd6ILta7Uc49ddiSt/7V5hNojb6b7j9kfC68s=;
 b=bLdTYh0r3QKtDsk4Ckzw+16LHaz+IrPOIqFDRL8sBQPfUNO62Yc6G6MKGg5sylZcEU
 nG0w9kb+iQDM6ukUJTp8VHCXoEhW0PMDc+RWnN/Cj0VwIiuxwwya2GHKV8H/LqPON78S
 m+Uhkpy18nLkPV659PWQe2tVo1ZMgpvtaLDpw/0U8gaXQdO9NwYs3Fe6vYdxQSJV/0Iv
 MrUiRakITGp+A65e8CGz+WXDInaNFfmbrQ0xcO8PfMk/o7z1zjnZox70maGgD+lruV+L
 eLVCCbuWxkx02j5KLaLIjIPcLroK/KmG0AYMeWyjIXuS5XsHGRsxKjrpMwT21c9u4OyW
 C44Q==
X-Gm-Message-State: AOJu0YzObFuwjShYbfNMVI+RVerByi0C7A/zDwA9CSduGFpVshjoBVn9
 Scp06HdHtFxRBg8iuflaFaYhwliMqH4GAoQE56PLHwAyXeRqHUfCIJ+PxXN47P5UxsBgrgeda21
 4
X-Gm-Gg: ASbGnct64zrKN0nIjGTPyuA6lsx9bcWLyuRPdN6UfO6KJvtPCbLYLJ4pwM5pzQFPt5x
 o4RmMfxX9soblalxDYMKbyzKEZSG9GtFB+GH2wn8RhIe2Oi7KXiCDJSJ66ovVkWvksKj7UmSKQv
 ENvVOHI1f/9WG3opF/NPV62yG4JSU75SvA+N2v58UqprveYF0f8iHebTyGHxlS6HZzGHzcepUIA
 3FkdqWXTIx0B8ilEMRK8WrpBnwZfHRHbedxiDuSGIyxi+m5v2C7p96r0NoNH8yc2eObFCm8TvtK
 19OPDPnUKdaQnGCRHlQV
X-Google-Smtp-Source: AGHT+IGbaOhZaimNWlIVZ76NVWe0BCInDnPUJcAzsVGxz2QBBakY+Aa9MdFCFnvZRvKrPTqBrCTx4A==
X-Received: by 2002:a05:6000:2aa:b0:38d:daf3:be6a with SMTP id
 ffacd0b85a97d-38ddaf3c061mr11737817f8f.40.1739291189241; 
 Tue, 11 Feb 2025 08:26:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/68] target/arm: Handle FPCR.AH in vector FABD
Date: Tue, 11 Feb 2025 16:25:18 +0000
Message-Id: <20250211162554.4135349-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Split the handling of vector FABD so that it calls a different set
of helpers when FPCR.AH is 1, which implement the "no negation of
the sign of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  4 ++++
 target/arm/tcg/translate-a64.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 15bad0773c0..43505d5fedc 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -722,6 +722,10 @@ DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 83cfcdc43b2..76c41b9bdba 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5888,7 +5888,12 @@ static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
     gen_helper_gvec_fabd_s,
     gen_helper_gvec_fabd_d,
 };
-TRANS(FABD_v, do_fp3_vector, a, 0, f_vector_fabd)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fabd[3] = {
+    gen_helper_gvec_ah_fabd_h,
+    gen_helper_gvec_ah_fabd_s,
+    gen_helper_gvec_ah_fabd_d,
+};
+TRANS(FABD_v, do_fp3_vector_2fn, a, 0, f_vector_fabd, f_vector_ah_fabd)
 
 static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 61e6e54570c..0b84a562c03 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1302,6 +1302,25 @@ static float64 float64_abd(float64 op1, float64 op2, float_status *stat)
     return float64_abs(float64_sub(op1, op2, stat));
 }
 
+/* ABD when FPCR.AH = 1: avoid flipping sign bit of a NaN result */
+static float16 float16_ah_abd(float16 op1, float16 op2, float_status *stat)
+{
+    float16 r = float16_sub(op1, op2, stat);
+    return float16_is_any_nan(r) ? r : float16_abs(r);
+}
+
+static float32 float32_ah_abd(float32 op1, float32 op2, float_status *stat)
+{
+    float32 r = float32_sub(op1, op2, stat);
+    return float32_is_any_nan(r) ? r : float32_abs(r);
+}
+
+static float64 float64_ah_abd(float64 op1, float64 op2, float_status *stat)
+{
+    float64 r = float64_sub(op1, op2, stat);
+    return float64_is_any_nan(r) ? r : float64_abs(r);
+}
+
 /*
  * Reciprocal step. These are the AArch32 version which uses a
  * non-fused multiply-and-subtract.
@@ -1389,6 +1408,10 @@ DO_3OP(gvec_fabd_h, float16_abd, float16)
 DO_3OP(gvec_fabd_s, float32_abd, float32)
 DO_3OP(gvec_fabd_d, float64_abd, float64)
 
+DO_3OP(gvec_ah_fabd_h, float16_ah_abd, float16)
+DO_3OP(gvec_ah_fabd_s, float32_ah_abd, float32)
+DO_3OP(gvec_ah_fabd_d, float64_ah_abd, float64)
+
 DO_3OP(gvec_fceq_h, float16_ceq, float16)
 DO_3OP(gvec_fceq_s, float32_ceq, float32)
 DO_3OP(gvec_fceq_d, float64_ceq, float64)
-- 
2.34.1



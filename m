Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91611C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYo-0006FG-Hn; Mon, 21 Jul 2025 09:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYI-0000Cs-1j
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYD-0005Ik-R3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so47954895e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104448; x=1753709248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wcyNJdNL/xiLYp3N57lKK8EPw8zPH/26wbvTC0tX4sQ=;
 b=qFtt/uhCwYta1r6NkBJ9lnwbeyLfnU0M2w+3ieRvQhQCIxZi9PV+MQb8FTkQ9RGE/4
 6hlVd2ktD2t9aeA8Kao5+exRtAUkBRSb1Jln20aztrjrVm239k9ESmM9IgK9xmayHpR6
 +x1GL62ndOegaa3U+FFsBQyKsPxyBGQO1ZrWZMGhOCpGI8ML2Yfgv1bzTOTdcsSj5zN0
 snCzwBIyQ9IP7j63dRoG7PmWwHWMWDCUtEYC0wP/4D5P8LdebfBATVaQZWtwyG7eHm54
 nbTyTq4zxoB4foi3ADlINgXgZiikc5dYsXunhio0vIyFbQnrlbQdNezDGmMEPkDbcuoG
 cLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104448; x=1753709248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcyNJdNL/xiLYp3N57lKK8EPw8zPH/26wbvTC0tX4sQ=;
 b=pqwrynGn7HTKp+1kUk1psIVMqsZBOLWHec57m/0Zi6hoW/dN+bQe2HH+tcB/zoYU4o
 Bc28Xo2ED2DptOCcFdpPEBwAFg7H9HbLNUsEiojHvdI0Ykjv5GJ9BTDphtNuP5n9nGCC
 vTbaxH6yIdN2Oh9oYjpUx9iAif7mRu/gLrQkQ93C/COAPc75W0VQRO592qrOwcUnRPSS
 rwQYIS2TrxcnMdoXWIlkyN4yXCqh1cVQbE2Ioef1gqbDnSiMdhZgyT9A7SV7lUD1q2Rr
 gllswtwr0Q8basloXlaziWezU4p4aYB6n52ErCQL4Y+PpjpXsmrPC30pUgNM3x09lETV
 bq5Q==
X-Gm-Message-State: AOJu0Yy4ElFaP0LoZNvlFM6RNEXwr1gZdbNMddqMTE6O7n9UX0Gd5fbw
 bfork7NHijF2th7cM2R9F9Vby7g6Rrb+Mll6MhU0hMLJ/gAIpFEo7zth9cV6eF5Pz5ugptZhbkw
 bbVqw
X-Gm-Gg: ASbGncuftkOrGHRiwAJGJhy+LWoPi+pHNNUfuaZwHYYUxwUBDtbAXZ107BRhDENDrw3
 vtlUI/8fvHG6ToGBni26yxP2WFrZWCVbx2mLfGTG9QuayIV+yvkZI38S2t6nEyiiPZfpHGNX9nt
 PiVDh8I+N03lgeySbLy9/hmTzmhPmcHEAfXojqs9M4hlnN5dwlmf5uxeNk6vqvlPjLjfqU6lBix
 pHak1Vqo6wWVJSw+ycYboN2iSuAXGzks/Z/AFACvH+fGaR1a9QTTEQvhvyltzwqk8WM0EpkMq3P
 sRJ3E3SvY83TCU8wAH5npUHHdtd5Yu1egg6/+ez6n2dbHInXFOLFKzQJWrCmS8dPpo527FmnjXF
 6SUbtRIJhI8K2SzTxi7Ms+2vvQSGG
X-Google-Smtp-Source: AGHT+IHP4VR8Fl9G5OcuoYqYTditu/QIIF+7VYjnigXLB4tyhvo6jQD5bktNDB9047NHPdbV3qX9WA==
X-Received: by 2002:a05:600d:10f:b0:456:1611:ce85 with SMTP id
 5b1f17b1804b1-4562e4f7a45mr98215905e9.21.1753104447721; 
 Mon, 21 Jul 2025 06:27:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] target/arm: Add BFADD, BFSUB, BFMUL (unpredicated)
Date: Mon, 21 Jul 2025 14:27:05 +0100
Message-ID: <20250721132718.2835729-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

FEAT_SVE_B16B16 adds bfloat16 versions of the SVE floating point
(unpredicated) instructions, which are encoded via sz==0b00.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-2-peter.maydell@linaro.org
---
 target/arm/tcg/helper.h        | 3 +++
 target/arm/tcg/translate-sve.c | 6 +++++-
 target/arm/tcg/vec_helper.c    | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 0a006d95142..d9ca5b7c56e 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -728,16 +728,19 @@ DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fadd_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_bfadd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fsub_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_bfsub, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmul_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7b575734fde..f00cccf1548 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -190,6 +190,10 @@ static bool gen_gvec_fpst_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
+    /* These insns use MO_8 to encode BFloat16 */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
+        return false;
+    }
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
@@ -4146,7 +4150,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
 
 #define DO_FP3(NAME, name) \
     static gen_helper_gvec_3_ptr * const name##_fns[4] = {          \
-        NULL, gen_helper_gvec_##name##_h,                           \
+        gen_helper_gvec_##name##_b16, gen_helper_gvec_##name##_h,   \
         gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
     };                                                              \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_arg_zzz, name##_fns[a->esz], a, 0)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index bae6165b505..76a9ab0da39 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1467,16 +1467,19 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
+DO_3OP(gvec_fadd_b16, bfloat16_add, float16)
 DO_3OP(gvec_fadd_h, float16_add, float16)
 DO_3OP(gvec_fadd_s, float32_add, float32)
 DO_3OP(gvec_fadd_d, float64_add, float64)
 DO_3OP(gvec_bfadd, bfloat16_add, bfloat16)
 
+DO_3OP(gvec_fsub_b16, bfloat16_sub, float16)
 DO_3OP(gvec_fsub_h, float16_sub, float16)
 DO_3OP(gvec_fsub_s, float32_sub, float32)
 DO_3OP(gvec_fsub_d, float64_sub, float64)
 DO_3OP(gvec_bfsub, bfloat16_sub, bfloat16)
 
+DO_3OP(gvec_fmul_b16, bfloat16_mul, float16)
 DO_3OP(gvec_fmul_h, float16_mul, float16)
 DO_3OP(gvec_fmul_s, float32_mul, float32)
 DO_3OP(gvec_fmul_d, float64_mul, float64)
-- 
2.43.0



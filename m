Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B01C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6T-0007Tk-A8; Tue, 11 Feb 2025 11:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5e-0006Vr-5k
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5c-00039l-GK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43955067383so6056105e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291183; x=1739895983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OYapsXWWu8r+6NSGgdddbEDpLTmPdprJZCqNJSzTqPo=;
 b=JLjhySCNRtduZH4WEbpm4pJedp9ewvVaO8Gzn4qUuiO6xdwMp7nHRYoYVgAei/sewb
 o6RI2jvyzhroJCIHBg7+Wxuwk9l/PK2KopDdzcDc1A5lqLKVqE44zbawmjJJWnR40i+N
 QpLHd+91RNDgSw8iHJFaAP7Vy/C8VR+OGmOWLd4n2WnUoHxFJ+Kg5BeoYZ3FsLWH/pX5
 u0ucjl6uExwc0gMkaGGmHPXEZVnDZ8hgKnmKvA0SpG6oJKrBdiuNHDbM6558sqLM0rKT
 cYQLy7RHhPxIrppwvToj5STOcRXVudsuvbz3kc2yovNXk7hlMxcbOhhXSYDzXbpZU+Sp
 4Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291183; x=1739895983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYapsXWWu8r+6NSGgdddbEDpLTmPdprJZCqNJSzTqPo=;
 b=SDOk67yW9aJYHCxu78oYYFc0lA57pCmH3CZA3ac1RlBrUgI6BlYhTwp772VeeNPoe2
 IrLqdqHrar377qIP1RR7tX0DpKBgOnhMtDTvsASJW1fx6XeefvHFdk3C+8jendEHJIDc
 uHWw2WWRXjIPniQattiPq8B5k2+b58od/8I8cJjhvX0WsEF7EjAjVjP2VtFxPF8A8JPq
 FTIhMjnS84p4eohFUKLOoMG+E3CLSwbySrS4sTcXzRjwJicNDPq34m7UF/rSEZcLqWTB
 CopHuCD/V8ZLAZtp0OClEbUHp0tZJFYZl5mLf7EoJ5RzhHDTuVBcEFDY8Eu9ZHRz/jzl
 YFHg==
X-Gm-Message-State: AOJu0YzOlrVtD+Ewc8WaqBph/Dxl6bEKJ6MrEiX7t9gk4Mue45Kq71mL
 9Kqrmbelqjy/fViZH5n6qczlwKJ8V8hzm0jJddPnFIuRLdZk7crY705HBqFOuE+QsUu0pCiQkI2
 U
X-Gm-Gg: ASbGncuToc+mfx+Ivb8UEb6/QTrj7uPulS0GvAbodJduYB+KJoRSzpKVG11CLeSLFIv
 V3OBRd9i5bhRURlSFjS+6Z2SsNgdL6n7ZCORAITR3/NR2kGMt7x6PJv8ib7LdkmJNPjjqKADTiD
 WdHrn/Upe6SrtlbcZnG3hPeaPNxeYTXe+yf4e+AN81glfSOeHdYBE5V8hyoS07mFK0//8WmF6rS
 p+caxgZsdnmdlQxDnxMhYPMTmnoeJd6rGyuupWXV0bBWbXh65n1Tm4bWgmCFXLbjFtLolCPZnGC
 Jv8WYNggSo8SjlvaoddD
X-Google-Smtp-Source: AGHT+IHkVw6zMlvJvYYJPFW1UAoGyvaD437l3iCkbW68enPuW1T0L4ntEuvkUtT9GvtpnndOftvZsA==
X-Received: by 2002:a05:600c:354c:b0:439:4b9a:a9fb with SMTP id
 5b1f17b1804b1-4394c85448fmr51735635e9.30.1739291182870; 
 Tue, 11 Feb 2025 08:26:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/68] target/arm: Implement FPCR.AH semantics for FMAXV and
 FMINV
Date: Tue, 11 Feb 2025 16:25:11 +0000
Message-Id: <20250211162554.4135349-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Implement the FPCR.AH semantics for FMAXV and FMINV.  These are the
"recursively reduce all lanes of a vector to a scalar result" insns;
we just need to use the _ah_ helper for the reduction step when
FPCR.AH == 1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 24695ab55b6..4ae0426bf76 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7018,27 +7018,35 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int rn, MemOp esz,
 }
 
 static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
-                              NeonGenTwoSingleOpFn *fn)
+                            NeonGenTwoSingleOpFn *fnormal,
+                            NeonGenTwoSingleOpFn *fah)
 {
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
         TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
+        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst,
+                                       s->fpcr_ah ? fah : fnormal);
         write_fp_sreg(s, a->rd, res);
     }
     return true;
 }
 
-TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxnumh)
-TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minnumh)
-TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxh)
-TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minh)
+TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_maxnumh, gen_helper_vfp_maxnumh)
+TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_minnumh, gen_helper_vfp_minnumh)
+TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_maxh, gen_helper_vfp_ah_maxh)
+TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_minh, gen_helper_vfp_ah_minh)
 
-TRANS(FMAXNMV_s, do_fp_reduction, a, gen_helper_vfp_maxnums)
-TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
-TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs)
-TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
+TRANS(FMAXNMV_s, do_fp_reduction, a,
+      gen_helper_vfp_maxnums, gen_helper_vfp_maxnums)
+TRANS(FMINNMV_s, do_fp_reduction, a,
+      gen_helper_vfp_minnums, gen_helper_vfp_minnums)
+TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs, gen_helper_vfp_ah_maxs)
+TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins, gen_helper_vfp_ah_mins)
 
 /*
  * Floating-point Immediate
-- 
2.34.1



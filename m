Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC0C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6g-0008WQ-Sv; Tue, 11 Feb 2025 11:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5v-0006iu-TB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5t-0003Jx-Ik
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:43 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso39887145e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291199; x=1739895999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Gj6jcWGtKBAI4K//T9Lvt8yA3S+QCmxRDkae+sx2h0=;
 b=tlZBVdkADvPWaYH8IKRfn64ujHayaKELsaRbROl2R2nxgUAr+sX/pItJzgbSS1pTsG
 LaudvXqPyv4FxXqBOYsRF4qAqLBFgeSCl9lIRuJQ7rqwGePbXlSLKPMWbugp/q3Sqlwq
 iTdpXnq0wvomstcfFeJzw4QBtRwhDEegl4lj4DjoUX51DQq24y5+pV/EDgzKk9ui6qZZ
 pGeyk+xCFm1nlGpfsYCaMMdeo3HbGdj+NzKhYSquM0L2OSoFo8YspKK1QUzVurmdLaRm
 OlGg3KPh73br0/5yE+aialxdFOOKbS4Q3cvO/JH4/KOHe7bu7MTtK+4D/imc0Rj7khal
 027w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291199; x=1739895999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Gj6jcWGtKBAI4K//T9Lvt8yA3S+QCmxRDkae+sx2h0=;
 b=T5EjT88MDUoeKeT0lxwK8Lm6Vb3RlP2gDaXdKa8KPxArwyXp/HbTxwxIpT9ZMCUAQE
 v4pglmtScNFxgg+IqIdUrf00CtQL8kA++fe14Ad1CVje5ow2fylICl2sXJyg/Fln0M9s
 +qaIFgqBIc80YajLmvwB1xNbBJ6z1N7FS+lR3ftjv7FG95N75zoxJChV84kLWZii0/qy
 MUjNoeVR+o4Desq6LcLqFS92lty5XtP0KNjUmsLt/dfEK5g9vAL2kwLViqtUEh3M6+3N
 ybezCfgDZH4LC3GpH2f9L3bNjyflIMHcYPe1O8f2vYMQ78GpNENYKV5+WOtg9LL4reZi
 dlog==
X-Gm-Message-State: AOJu0Yy7ZRhXKkwiVfIgH2wemBm/GWeqb5LON0qKkNpekm1gFXyKki4y
 jg8GRq/Agvh7IhrAzkPOzJi6j/6ZhnWvqw0KliBg3vaEeGwcf6hbkZKPSMejiKad37nrpnvdIu7
 n
X-Gm-Gg: ASbGncs42QCha+EuNMPyQsQoH4Ulf0t0kDi85eRwzOtacQzXEhQKQ0VKJxBDW4KjjAI
 85Dpq1NQd7g2m98Sye2XvkHoVhJ2dWN6szDmLUWQ+vou2E2f70g8w61TRjUxmUz519k0Ir1BgNC
 Rl0dISPOYSypOyYi0g0z3JJMT5vNlPsPtFKrzpaTNUcEWt0fdCo14RPX97r0hpWTv1YngPgsxfd
 lPgD0Nb4xXIhIhjOvp1ew7lW9mAJCVxq0gZe7G8z+ZGS3NhGoGNMux4gZ6ZUZeaH+WpcNcebqNL
 AifSSRBe4L0Uv+MR5rl9
X-Google-Smtp-Source: AGHT+IH68FrUKD/O9zokyuat6c5ATJVR0bd6AtSPT4TkmLVi+Jv4ivw3GcJICQBqqkIjpS14Ma7Cww==
X-Received: by 2002:a05:600c:5101:b0:439:4b3c:3b1b with SMTP id
 5b1f17b1804b1-4394b3c3c6amr53737285e9.27.1739291199079; 
 Tue, 11 Feb 2025 08:26:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/68] target/arm: Handle FPCR.AH in negation in FMLS (vector)
Date: Tue, 11 Feb 2025 16:25:27 +0000
Message-Id: <20250211162554.4135349-42-peter.maydell@linaro.org>
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics
in FMLS (vector), by implementing a new set of helpers for
the AH=1 case.

The float_muladd_negate_product flag produces the same result
as negating either of the multiplication operands, assuming
neither of the operands are NaNs.  But since FEAT_AFP does not
negate NaNs, this behaviour is exactly what we need.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  4 ++++
 target/arm/tcg/translate-a64.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    | 22 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index be47edff896..f0a783b7088 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -782,6 +782,10 @@ DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dc35e5d896e..3ab84611a65 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5860,7 +5860,12 @@ static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
     gen_helper_gvec_vfms_s,
     gen_helper_gvec_vfms_d,
 };
-TRANS(FMLS_v, do_fp3_vector, a, 0, f_vector_fmls)
+static gen_helper_gvec_3_ptr * const f_vector_fmls_ah[3] = {
+    gen_helper_gvec_ah_vfms_h,
+    gen_helper_gvec_ah_vfms_s,
+    gen_helper_gvec_ah_vfms_d,
+};
+TRANS(FMLS_v, do_fp3_vector_2fn, a, 0, f_vector_fmls, f_vector_fmls_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmeq[3] = {
     gen_helper_gvec_fceq_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ae3cb50fa24..fc3e6587b81 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1558,6 +1558,24 @@ static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
     return float64_muladd(float64_chs(op1), op2, dest, 0, stat);
 }
 
+static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
+                                 float_status *stat)
+{
+    return float16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
+static float32 float32_ah_mulsub_f(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    return float32_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
+static float64 float64_ah_mulsub_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    return float64_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
 #define DO_MULADD(NAME, FUNC, TYPE)                                        \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status *stat, uint32_t desc)                       \
@@ -1584,6 +1602,10 @@ DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
 DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
 
+DO_MULADD(gvec_ah_vfms_h, float16_ah_mulsub_f, float16)
+DO_MULADD(gvec_ah_vfms_s, float32_ah_mulsub_f, float32)
+DO_MULADD(gvec_ah_vfms_d, float64_ah_mulsub_f, float64)
+
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
  */
-- 
2.34.1



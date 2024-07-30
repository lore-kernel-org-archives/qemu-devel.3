Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3929BC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJu-00040M-Bv; Tue, 30 Jul 2024 12:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJs-0003pv-OS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJp-0000I1-1O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428163f7635so27352085e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355399; x=1722960199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iDXGs+7guPqwtDoRL/y+LlQlY9IQZ4XWQ35haRtARdg=;
 b=eITtdWourb0qB8xke3jBw6nplm/fK6GREgpsvwHe6njMIgwxpTUgSDsRJ8EoPUcth4
 u2vL/Kxm5e57ShgOxBqlVZ9LS8VG1Pf5Pq7fQolmxTAZqQpTj0+UksUWuA2ibHnwB/Kr
 iXRH/NojnLFaketdiclGYtKFFa9q8y9Yvo6KIVDqV3ygI7WKu2J5N41Yhroq9COpyKHV
 GM/lHSuhYJNEFhftYQXNXJVhZJTFKda/+gSyLwK30NpeSrTJH59IZYKy3Cbw6xL5iRby
 vPc+oWPSMp1LmQ2uGqsMoq1rDqrkSXjCKSTXoXGKSqSzy8nalCheyWpRSkrYUjXecZnP
 Dx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355399; x=1722960199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDXGs+7guPqwtDoRL/y+LlQlY9IQZ4XWQ35haRtARdg=;
 b=wQfSv49EVE5RCQE7AzJIl/rrbLZU+0hen6GcN5e533RWyOv15Ge8SQtkedT+9JdYMp
 0xB+oFnfZo/mMKKowfA8ftgp0Jp6UGWXo9jJ24+liNbhE4L0I+dcYMyxX1hDotmpcrkR
 dDSYzSCMdBnePvamhSHgCrcfoJJHR7CxrGtZE5Ifsww2sR2Dw8SN8NRxXxYThxTuF0TM
 npO+1Nrxr/KiHdD2ekK6HoARmZK4JrjDZo7tgakpE07Ka52ONkQDbC/TAX94mV+3zhpR
 hZGzMM7TzPrQlxJE8fOnOhkKnhqi3pPi+N1xKu52kz5pSYd8MzhmbwnuydOwCcBFmMQI
 hDbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOIsp40flcWDeNmpQSZZH1kAHN8uz5HxogUecsZysFWA+8FoffEayXVnDIV1Hg2ugbIFIlEwWu3Q4GXNg10gqxUVgDe/M=
X-Gm-Message-State: AOJu0YzbuXiqIfYrbRf7Qfk08VY2ZomPSuWEmioL73ZtdYBds/LrxGLV
 jmuEZNQe0UefnoaF9mgd4kVh/bt71mW9zY1SbNZclpDjm4Tv6jQZob1KzONY6mckdcGFXOTiohb
 +
X-Google-Smtp-Source: AGHT+IGZWc2oIOPACORoSQfToOSj5K/k3XRvcITYBo4TlAvSSsmwL/k+tOD6VBheekPGZDgSOtPapw==
X-Received: by 2002:a05:600c:468e:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42811a8f351mr84164095e9.0.1722355399506; 
 Tue, 30 Jul 2024 09:03:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/8] target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()
Date: Tue, 30 Jul 2024 17:03:05 +0100
Message-Id: <20240730160306.2959745-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement the FPCR.EBF=1 semantics for bfdotadd() operations:
 * is_ebf() sets up fpst and fpst_odd
 * bfdotadd_ebf() implements the fused paired-multiply-and-add
   operation that we need

The paired-multiply-and-add is similar to f16_dotadd() and
we use the same trick here as in that function, but the inputs
here are bfloat16 rather than float16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 57 +++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index baf04a0561b..64076c1c595 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2792,7 +2792,20 @@ DO_MMLA_B(gvec_usmmla_b, do_usmmla_b)
 
 bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
 {
-    /* FPCR is ignored for BFDOT and BFMMLA. */
+    /*
+     * For BFDOT, BFMMLA, etc, the behaviour depends on FPCR.EBF.
+     * For EBF = 0, we ignore the FPCR bits which determine rounding
+     * mode and denormal-flushing, and we do unfused multiplies and
+     * additions with intermediate rounding of all products and sums.
+     * For EBF = 1, we honour FPCR rounding mode and denormal-flushing bits,
+     * and we perform a fused two-way sum-of-products without intermediate
+     * rounding of the products.
+     * In either case, we don't set fp exception flags.
+     *
+     * EBF is AArch64 only, so even if it's set in the FPCR it has
+     * no effect on AArch32 instructions.
+     */
+    bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
     float_status bf_status = {
         .tininess_before_rounding = float_tininess_before_rounding,
         .float_rounding_mode = float_round_to_odd_inf,
@@ -2801,8 +2814,19 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
         .default_nan_mode = true,
     };
 
+    if (ebf) {
+        float_status *fpst = &env->vfp.fp_status;
+        set_flush_to_zero(get_flush_to_zero(fpst), &bf_status);
+        set_flush_inputs_to_zero(get_flush_inputs_to_zero(fpst), &bf_status);
+        set_float_rounding_mode(get_float_rounding_mode(fpst), &bf_status);
+
+        /* EBF=1 needs to do a step with round-to-odd semantics */
+        *oddstatusp = bf_status;
+        set_float_rounding_mode(float_round_to_odd, oddstatusp);
+    }
+
     *statusp = bf_status;
-    return false;
+    return ebf;
 }
 
 float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
@@ -2824,7 +2848,34 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
-    g_assert_not_reached();
+    /*
+     * Compare f16_dotadd() in sme_helper.c, but here we have
+     * bfloat16 inputs. In particular that means that we do not
+     * want the FPCR.FZ16 flush semantics, so we use the normal
+     * float_status for the input handling here.
+     */
+    float64 e1r = float32_to_float64(e1 << 16, fpst);
+    float64 e1c = float32_to_float64(e1 & 0xffff0000u, fpst);
+    float64 e2r = float32_to_float64(e2 << 16, fpst);
+    float64 e2c = float32_to_float64(e2 & 0xffff0000u, fpst);
+    float64 t64;
+    float32 t32;
+
+    /*
+     * The ARM pseudocode function FPDot performs both multiplies
+     * and the add with a single rounding operation.  Emulate this
+     * by performing the first multiply in round-to-odd, then doing
+     * the second multiply as fused multiply-add, and rounding to
+     * float32 all in one step.
+     */
+    t64 = float64_mul(e1r, e2r, fpst_odd);
+    t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+
+    /* This conversion is exact, because we've already rounded. */
+    t32 = float64_to_float32(t64, fpst);
+
+    /* The final accumulation step is not fused. */
+    return float32_add(sum, t32, fpst);
 }
 
 void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
-- 
2.34.1



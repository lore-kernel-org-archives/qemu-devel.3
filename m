Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E7FC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLbA-0005tf-QZ; Fri, 07 Feb 2025 05:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLb3-0005rP-WC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLb2-0008Ej-Af
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33vv0LTRkoa8007dZV9o44ZqrRUf3Wofq/Zn2BVSNwk=;
 b=K1p1Yf2AZ8HvKw7qh22QJwuDmL8ukW8pMq86OTwphKMy+6fLpVpx0MHm5NKDuctIHPW5G5
 fMteeaxlqYQRW4gNp+94Hm5m1eh+uHRmQfFyL1J1ApcQXhfvQk0uDp+aR6bhtOtQZjj/oT
 g8MTaTheOQ/SVSx0Tjt09mAlFjf7nLI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-N9G2cArxM1mFlsXwjlM7QA-1; Fri, 07 Feb 2025 05:28:26 -0500
X-MC-Unique: N9G2cArxM1mFlsXwjlM7QA-1
X-Mimecast-MFC-AGG-ID: N9G2cArxM1mFlsXwjlM7QA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa689b88293so210736066b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924104; x=1739528904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33vv0LTRkoa8007dZV9o44ZqrRUf3Wofq/Zn2BVSNwk=;
 b=TCtTj0s1aOSXrYiYegyktbcuHo8+HWly7nOzVwwe4ixp2jePrgqB5XckP8ZXerlRff
 wqy46WnjGkxUhZNPCVFftI+Snj1MbeFMKGdNfvo+gYLKpeVzJFBcEkUuMSefHS3qi4Tc
 1fUE6YclDMwOfc3p0K+FYXKm7PiYtlNVMhMIrMazMpYs/+L0nv/4IQLKAtH9AQfRIbC9
 olAvjL+WB8KYxTbnLn1n6DKvPCJB8fZTd25s2p9TQsKO7UpytZ7+KkF3eqNZyR76ZBgV
 Hqqnl5Bf3BzqzJFOgTMs//KaRZMPdQj+elVh4O2PfToTCoyNx9+YwKsmhQbfi1GMSZl4
 ga/A==
X-Gm-Message-State: AOJu0YzgDLPEi6Y6p5qKqaHHxmCq5oNKYktNVx/zss6zf2jKqC1eJa7E
 blxlOCmBADPhUx/UkXT1LUAKRM0NT1W96gNC8yL4D17KD04qDMkoxf52PFZPAPdEjFMy+WZ0YWX
 XZd6ha03795gPlzMf5rUQ1b/1jxeBGXwOH8speZotQivlz8RKbgFU01OPg+HuebcCIXw/V0ZXbG
 ajw1jOhMRM0qAeJZKrwY+mhUQ7yA7V4pAP3pi0NeM=
X-Gm-Gg: ASbGncubPjh3bqfOdWe5/jKcLdi2GE1qj/niPkSD3T1YdG8lQngawuGrJDQcxch1QCs
 zaXG6LuZ6SofAIhSr0gua70eWJwNWgYZuPElGrQAG8tf4JLe1RPI6gaGhujd02CuN4NfUx6Hws+
 yVUf9MSt+qnh1SazDGZY7wAPhKac4ZvE8pX2hHzB4UszuqUOP2oVIyNCUSENja441oXIWJu1OpD
 gqXZCRPCYJ93uqS15752xn5F4kgV7XeodgtaImTZQg4XTK9FVmqpWaAMxeqgkQ3r1OJ2TtRy/4M
 zOvvJA==
X-Received: by 2002:a17:907:7b06:b0:ab6:eec6:7cab with SMTP id
 a640c23a62f3a-ab789c3ac8amr290121666b.38.1738924103577; 
 Fri, 07 Feb 2025 02:28:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHqrwcYyki9L94lm9JNRv1CKRHNj2x75DX/w52qEeR3bu4HoLpqn2gugVPM9hwXKaBxAp+kA==
X-Received: by 2002:a17:907:7b06:b0:ab6:eec6:7cab with SMTP id
 a640c23a62f3a-ab789c3ac8amr290118366b.38.1738924103085; 
 Fri, 07 Feb 2025 02:28:23 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab79298641asm19003166b.90.2025.02.07.02.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/7] target/i386: Do not raise Invalid for 0 * Inf + QNaN
Date: Fri,  7 Feb 2025 11:27:59 +0100
Message-ID: <20250207102802.2445596-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207102802.2445596-1-pbonzini@redhat.com>
References: <20250207102802.2445596-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 8adcff4ae7 ("fpu: handle raising Invalid for infzero in
pick_nan_muladd") we changed the handling of 0 * Inf + QNaN to always
raise the Invalid exception regardless of target architecture.  (This
was a change affecting hppa, i386, sh4 and tricore.) However, this
was incorrect for i386, which documents in the SDM section 14.5.2
that for the 0 * Inf + NaN case that it will only raise the Invalid
exception when the input is an SNaN.  (This is permitted by the IEEE
754-2008 specification, which documents that whether we raise Invalid
for 0 * Inf + QNaN is implementation defined.)

Adjust the softfloat pick_nan_muladd code to allow the target to
suppress the raising of Invalid for the inf * zero + NaN case (as an
extra flag orthogonal to its choice for when to use the default NaN),
and enable that for x86.

We do not revert here the behaviour change for hppa, sh4 or tricore:
 * The sh4 manual is clear that it should signal Invalid
 * The tricore manual is a bit vague but doesn't say it shouldn't
 * The hppa manual doesn't talk about fused multiply-add corner
   cases at all

Cc: qemu-stable@nongnu.org
Fixes: 8adcff4ae7 (""fpu: handle raising Invalid for infzero in pick_nan_muladd")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20250116112536.4117889-2-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/fpu/softfloat-types.h | 16 +++++++++++++---
 target/i386/tcg/fpu_helper.c  |  5 ++++-
 fpu/softfloat-parts.c.inc     |  5 +++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 616c290145f..2e43d1dd9e6 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -280,11 +280,21 @@ typedef enum __attribute__((__packed__)) {
     /* No propagation rule specified */
     float_infzeronan_none = 0,
     /* Result is never the default NaN (so always the input NaN) */
-    float_infzeronan_dnan_never,
+    float_infzeronan_dnan_never = 1,
     /* Result is always the default NaN */
-    float_infzeronan_dnan_always,
+    float_infzeronan_dnan_always = 2,
     /* Result is the default NaN if the input NaN is quiet */
-    float_infzeronan_dnan_if_qnan,
+    float_infzeronan_dnan_if_qnan = 3,
+    /*
+     * Don't raise Invalid for 0 * Inf + NaN. Default is to raise.
+     * IEEE 754-2008 section 7.2 makes it implementation defined whether
+     * 0 * Inf + QNaN raises Invalid or not. Note that 0 * Inf + SNaN will
+     * raise the Invalid flag for the SNaN anyway.
+     *
+     * This is a flag which can be ORed in with any of the above
+     * DNaN behaviour options.
+     */
+    float_infzeronan_suppress_invalid = (1 << 7),
 } FloatInfZeroNaNRule;
 
 /*
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 3d764bc138d..de6d0b252ec 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -178,8 +178,11 @@ void cpu_init_fp_statuses(CPUX86State *env)
      * "Fused-Multiply-ADD (FMA) Numeric Behavior" the NaN handling is
      * specified -- for 0 * inf + NaN the input NaN is selected, and if
      * there are multiple input NaNs they are selected in the order a, b, c.
+     * We also do not raise Invalid for the 0 * inf + (Q)NaN case.
      */
-    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never |
+                              float_infzeronan_suppress_invalid,
+                              &env->sse_status);
     set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
     /* Default NaN: sign bit set, most significant frac bit set */
     set_float_default_nan_pattern(0b11000000, &env->fp_status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index fee05d0a863..73621f4a970 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -126,7 +126,8 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
-    if (infzero) {
+    if (infzero &&
+        !(s->float_infzeronan_rule & float_infzeronan_suppress_invalid)) {
         /* This is (0 * inf) + NaN or (inf * 0) + NaN */
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
@@ -144,7 +145,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
          * Inf * 0 + NaN -- some implementations return the
          * default NaN here, and some return the input NaN.
          */
-        switch (s->float_infzeronan_rule) {
+        switch (s->float_infzeronan_rule & ~float_infzeronan_suppress_invalid) {
         case float_infzeronan_dnan_never:
             break;
         case float_infzeronan_dnan_always:
-- 
2.48.1



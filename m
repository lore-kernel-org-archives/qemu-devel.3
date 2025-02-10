Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD006C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwe-0002Nc-Qr; Mon, 10 Feb 2025 05:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwc-0002Ms-Ll
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwa-0000Lq-2X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33vv0LTRkoa8007dZV9o44ZqrRUf3Wofq/Zn2BVSNwk=;
 b=T3JMSs7y06pWc+B6D6ChFMDuSttz4QH25uOp5g8LIMIvoGgdv9HemvxA391959Q6zHPbSX
 dfFfijRAX3S4bddxCqGybs2Q8XR/KdV9zzOHtDyV3qcfc0r1unrB2xMpP1rML7pJYPRnre
 C78pdF5UU0K4zqojqW1IneTM3A5ywCc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-XSqTcDfbPyK4gejA6Z9-bA-1; Mon, 10 Feb 2025 05:23:08 -0500
X-MC-Unique: XSqTcDfbPyK4gejA6Z9-bA-1
X-Mimecast-MFC-AGG-ID: XSqTcDfbPyK4gejA6Z9-bA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5de4c781e00so2612824a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182987; x=1739787787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33vv0LTRkoa8007dZV9o44ZqrRUf3Wofq/Zn2BVSNwk=;
 b=kCfYkPL8OY54rKS/mxs/5kq8/F20nwZR8UrolkeJyye861vgyEodxkkHREwBk8DqqI
 uG+c+orZC4CSW9cEzvvqc8QH3L9527HZH+pkCg17WwO0SMhoW1sJtOuzHA8sQnGbL7QZ
 Wn3xGIGFSqsRmyjv+xRzk+r1aExNOkXDdSo/crjG8KcSImLaZ9KzDK/HUOhXWZldxsaF
 LYLkIT3c6t4NZo9llfdjcG9oPj1buG6D+0VHoH4GveJX/B5EmFoE0ip6mYXuFdVhDj/a
 NlZ6pzprq+YDraJlp4xrV+3qmXoM8u37r/sXgnHaHUINCsuOmE5gLS+zxxbrVectHk2k
 4JsA==
X-Gm-Message-State: AOJu0YxOrAUxo5F/E0T5tNgYYMaPSDlEuIy7mEuxrLicB1AQnWsgWJlY
 9l4SxC6pDjsF9TF1yDXNLjL8o1aR231k/OmJhY94xhVlxv0EN0zgmY17HBENXVkWDjB78JPxFOv
 rWPnwgnI7BJOFe7vf7wyU10wShH4p2iP2sgoPOiz1iLxXoN8GhVRKud6XiOW3gPrewfBn9yHoP0
 m+2BHoYswGbvV0dKRW+eneUsVJ6ZWbMjxjIJxgdvI=
X-Gm-Gg: ASbGnctwk0RGZ/7SSRkdbtWdw3bl7HbdjPccOv7fbqPxDNH6+W1TFjj3IcPETWo7+xI
 3SV3n8TsaNHh1T+v4uXwNn/dh0w8QscdZQLv/DHn3BkQaEJ7V+EqihrF1NNixOrJyloDBrcCnlV
 HT2f+66WhR5/vOZVV96CAp/s8NfGyMAWW9gGAhPkzq7OyJfUoKyq0jDF7fnGORU2XB4SPTmjNI1
 qoS/LZSGviKrsIAo4jcV312MDUhnNHGbmFYc67z18aB8FDLQcHDV3lxq7FcuulHW3bS/m3IaryH
 dSAaWw==
X-Received: by 2002:a05:6402:26cf:b0:5de:3c29:e82e with SMTP id
 4fb4d7f45d1cf-5de45070668mr15804250a12.18.1739182986603; 
 Mon, 10 Feb 2025 02:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4hg57/FyN8f0hF2Xs9hC0ipRFwFCwAaB0O7kI6bUrycwPXM552SFj2ZdML/VSQgVkb3W1Lw==
X-Received: by 2002:a05:6402:26cf:b0:5de:3c29:e82e with SMTP id
 4fb4d7f45d1cf-5de45070668mr15804214a12.18.1739182986000; 
 Mon, 10 Feb 2025 02:23:06 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de72da5ce6sm2531551a12.51.2025.02.10.02.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/9] target/i386: Do not raise Invalid for 0 * Inf + QNaN
Date: Mon, 10 Feb 2025 11:22:50 +0100
Message-ID: <20250210102255.2555097-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA43C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYg-0004Ij-7R; Fri, 24 Jan 2025 11:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYO-0003ui-O2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYK-0005UZ-6A
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:08 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso16860555e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736143; x=1738340943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yjfFM7NxtDggNO5IBBuH0wlbLUygYweJvaw+Q44Pxo4=;
 b=Hw0TzH0HySD0qd37gOeRKUmAO32bVE4Np8Q88M3dI+Lw+xSl+VTqEHZCv8V8yB2Skr
 sT9ID7AsWbSUXIzg5W8EurHVJzMAonTG3fL7WxqzdIYeCEbvUy3hoass5E/xT3XgNRMQ
 +SdhLpSxP1v2OSm8ZPRu8lmDdEjvgjLO/qNzv7frs9fVUvRbxb6XzESejHQsxRyrBgPa
 vTJ9t4UAGDfBx5uGyHgJi0gLSumegbPc/q8yINeS0ewV5jkQ3/1gT9k+ucPNuV0csemf
 R6CR5Lj4ZnGnd104rctp+GN2SRsbAI3lAgBqCuoevKhxX+8GyOA89JNznaAfanlu6xTb
 UVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736143; x=1738340943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjfFM7NxtDggNO5IBBuH0wlbLUygYweJvaw+Q44Pxo4=;
 b=p/oOn0Qd5md0dqlut/4Le4rNx6TGh1v3J68vAM2r9TVJC25KLA83G3ldRZJ7fTTVk3
 FrEHHFf1jlfskZ4hudQ19aFRVsWSmpaWD40h9auEvX1MbKbcJ5kZuICU9Dmevt4/hTyw
 cXducero+4+c7w0f5hL8Chw8suHd7pe1kvvJkUNn2HGbAPP4TtINP+ZLuKzg42NHsDOa
 uxNckYokh54XS21C83I/16cAd6bs7u/aRm+NJ7nPFyMjXnHDv9iL2L5q5GiL5iwu+YXq
 dcSe5KsXN3a99fztreriLSvQcdzLBWhu1K8MgYdW+egK+/ldAsMhBSmTjwwtWPWe9LNq
 GWUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNqya/0KQjT5hOWc4ZNp4hy/TLXo2U9E2huGJf7GjXgQpUw7LXHISIbqb+7Sbxcu5qRjsBJFHmjwdu@nongnu.org
X-Gm-Message-State: AOJu0Yy8y22XshOdRc3qUVnVFCj3cN4/Vy6/CEPCat4Jic5MIMxiaSS8
 /TYPIr1Fo2NKxsexsAc/5Kh9LcPSOFStEwASnX9otlZui4tSTMYTEt8gV8Q9ewg=
X-Gm-Gg: ASbGncsmOw4nKglUBTV3LMuddpz/YMJdbUg5iXszZmPF8XYoDkIPd31D4qWopneF2X9
 pVnfqHSO9qnd3XXKoehJITSS5WOugnVvGXP3YNFC+9J9FKo+u65Pyz8LRCbYd1xu2QoTs4V15+t
 k/zFuLkp5Zm8h1NZt7G002X68J85J5bgGHY+jywrqC5/StbZE8ww4T3d6avulnYK816pZUtNVxT
 tDJK7ydvvtfLsxzZc+CH+LMgxw9XYgRzJY836bBnqFHyKr6mM6OhTJ3+4+GC04RENWTMVQKt4GC
 /3nqNRUVu2M=
X-Google-Smtp-Source: AGHT+IE2ykshG0oR2RPFlQndxP94CTgKACK1e3yS4OOaN3UNRy/ixcXEFLsYz+/nfPhbBEU+lR2Q/g==
X-Received: by 2002:a05:600c:3b94:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-438913e02f8mr354713945e9.16.1737736142758; 
 Fri, 24 Jan 2025 08:29:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 20/76] fpu: Rename float_flag_output_denormal to
 float_flag_output_denormal_flushed
Date: Fri, 24 Jan 2025 16:27:40 +0000
Message-Id: <20250124162836.2332150-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Our float_flag_output_denormal exception flag is set when
the fpu code flushes an output denormal to zero. Rename
it to float_flag_output_denormal_flushed:
 * this keeps it parallel with the flag for flushing
   input denormals, which we just renamed
 * it makes it clearer that it doesn't mean "set when
   the output is a denormal"

Commit created with
 for f in `git grep -l float_flag_output_denormal`; do sed -i -e 's/float_flag_output_denormal/float_flag_output_denormal_flushed/' $f; done

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h | 3 ++-
 fpu/softfloat.c               | 2 +-
 target/arm/vfp_helper.c       | 2 +-
 target/i386/tcg/fpu_helper.c  | 2 +-
 target/m68k/fpu_helper.c      | 2 +-
 target/mips/tcg/msa_helper.c  | 2 +-
 target/rx/op_helper.c         | 2 +-
 target/tricore/fpu_helper.c   | 6 +++---
 fpu/softfloat-parts.c.inc     | 2 +-
 9 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 77bc172a074..4a806e3981a 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -156,7 +156,8 @@ enum {
     float_flag_inexact         = 0x0010,
     /* We flushed an input denormal to 0 (because of flush_inputs_to_zero) */
     float_flag_input_denormal_flushed = 0x0020,
-    float_flag_output_denormal = 0x0040,
+    /* We flushed an output denormal to 0 (because of flush_to_zero) */
+    float_flag_output_denormal_flushed = 0x0040,
     float_flag_invalid_isi     = 0x0080,  /* inf - inf */
     float_flag_invalid_imz     = 0x0100,  /* inf * 0 */
     float_flag_invalid_idi     = 0x0200,  /* inf / inf */
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 648050be6fb..26f3a8dc87e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5017,7 +5017,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
         }
         if ( zExp <= 0 ) {
             if (status->flush_to_zero) {
-                float_raise(float_flag_output_denormal, status);
+                float_raise(float_flag_output_denormal_flushed, status);
                 return packFloatx80(zSign, 0, 0);
             }
             isTiny = status->tininess_before_rounding
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 444702a4600..3c8f3e65887 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -47,7 +47,7 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
     if (host_bits & float_flag_overflow) {
         target_bits |= FPSR_OFC;
     }
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal_flushed)) {
         target_bits |= FPSR_UFC;
     }
     if (host_bits & float_flag_inexact) {
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 7151e809643..de6d0b252ec 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3271,7 +3271,7 @@ void update_mxcsr_from_sse_status(CPUX86State *env)
                    (flags & float_flag_overflow ? FPUS_OE : 0) |
                    (flags & float_flag_underflow ? FPUS_UE : 0) |
                    (flags & float_flag_inexact ? FPUS_PE : 0) |
-                   (flags & float_flag_output_denormal ? FPUS_UE | FPUS_PE :
+                   (flags & float_flag_output_denormal_flushed ? FPUS_UE | FPUS_PE :
                     0));
 }
 
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index e3f4a188501..339b73ad7dc 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -175,7 +175,7 @@ static int cpu_m68k_exceptbits_from_host(int host_bits)
     if (host_bits & float_flag_overflow) {
         target_bits |= 0x40;
     }
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal_flushed)) {
         target_bits |= 0x20;
     }
     if (host_bits & float_flag_divbyzero) {
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index aeab6a1d8b3..ec38d9fde5e 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -6241,7 +6241,7 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
     }
 
     /* Set Inexact (I) and Underflow (U) when flushing outputs to zero */
-    if ((ieee_exception_flags & float_flag_output_denormal) &&
+    if ((ieee_exception_flags & float_flag_output_denormal_flushed) &&
             (env->active_tc.msacsr & MSACSR_FS_MASK) != 0) {
         mips_exception_flags |= FP_INEXACT;
         if (action & CLEAR_FS_UNDERFLOW) {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 59dd1ae6128..b3ed822dd11 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -100,7 +100,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
             SET_FPSW(X);
         }
         if ((xcpt & (float_flag_input_denormal_flushed
-                     | float_flag_output_denormal))
+                     | float_flag_output_denormal_flushed))
             && !FIELD_EX32(env->fpsw, FPSW, DN)) {
             env->fpsw = FIELD_DP32(env->fpsw, FPSW, CE, 1);
         }
diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 5d38aea143a..1b72dcc5f5c 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -43,7 +43,7 @@ static inline uint8_t f_get_excp_flags(CPUTriCoreState *env)
            & (float_flag_invalid
               | float_flag_overflow
               | float_flag_underflow
-              | float_flag_output_denormal
+              | float_flag_output_denormal_flushed
               | float_flag_divbyzero
               | float_flag_inexact);
 }
@@ -99,7 +99,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
         some_excp = 1;
     }
 
-    if (flags & float_flag_underflow || flags & float_flag_output_denormal) {
+    if (flags & float_flag_underflow || flags & float_flag_output_denormal_flushed) {
         env->FPU_FU = 1 << 31;
         some_excp = 1;
     }
@@ -109,7 +109,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
         some_excp = 1;
     }
 
-    if (flags & float_flag_inexact || flags & float_flag_output_denormal) {
+    if (flags & float_flag_inexact || flags & float_flag_output_denormal_flushed) {
         env->PSW |= 1 << 26;
         some_excp = 1;
     }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ec2467e9fff..73621f4a970 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -335,7 +335,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         }
         frac_shr(p, frac_shift);
     } else if (s->flush_to_zero) {
-        flags |= float_flag_output_denormal;
+        flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
         exp = 0;
         frac_clear(p);
-- 
2.34.1



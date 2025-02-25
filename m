Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00800C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKS-0000ui-EW; Tue, 25 Feb 2025 13:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJG-0008Nr-LE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJC-0002Dy-BD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so57994845e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506727; x=1741111527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TAaeogw6RKMAjRuoPB+J8ccxwyd9NsxfEbAe4rMEEBo=;
 b=XAG4fdOG0vuV7tKGU80aWXOSH933rN3/q9yL++lRdWgRsBaIR38O0/othkYwMgvavs
 SSPc82rcTMmFStTfv6ttFc/SoqH1iSlj+reuEB/BbjKjrw4xZpGWIhmKkbebHASvsLAm
 opEZSduzH6qCpGRf9Mz8tm/jqnheV4eBj/dBqCgavSnkEnUVUL35Iixfe8EmCh5Vm/mh
 00f9SXfDWFFBgtB2xb7+6Xg/tXMvBbERv2kbG3JdPSGMPw4TcC2IX4lMkYzRBuByhMfV
 y8YtDUkxYZzQHGh/EI+YI5Gx30kCX7PTb5OwmbWGhQcTXvr2ue+7WYIZOrwtBN5dCy68
 amzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506727; x=1741111527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAaeogw6RKMAjRuoPB+J8ccxwyd9NsxfEbAe4rMEEBo=;
 b=ugAcJaewwPUWz9I3+pyWyfZL295eLzrniGFAHshyeKBDhUWUZy7vggqDdN4BqMpDfx
 P10JxTLJqGYKCUAkv+CwDo65+BQe6/onyeu6SLm8CXIuFjWYbZ3OMPHoVwwJkI0RDArv
 AJabrQZ6df34vxc9ZKy+OBFjBPeqf51lZkloeTyJat1RuzNbybYPHppXPoluwOaRAVpa
 RxZoCghEUHLVJTL5FGQuz7SEmtOyo5jNqbVvgvhaUEWtoWRP8qZBOUo55QzkbhcPfF1w
 FLqjVZ/HQXFZya2zsdNZmW0NVyMajcLehfAUQy3jRYrL1S4NHjjxIJR65vt+3WlEm6is
 czBg==
X-Gm-Message-State: AOJu0YwT8KqNJmMb1K6o8+foculK11lKIUwyqniGqgz9Ed+FZOajVr4o
 Yw0otT6s5Rk/asBhCrfvOMjiC5++3ZzvBJNH+hiSMv82py1lzNnSLdhjP0nXzuAhLI5Vc5oN4st
 1
X-Gm-Gg: ASbGnctuKtm8H2E3LNpNuGJ8ZU6qGlTBH08FuuH9P1GTX6xltrYVpuGt9vOuIt9QRs6
 sm1fWOzCoKlbfBCGJtx1TrYCvB2fe5h6ssxasigyVDCBQA89sk7cJcd4RtA7q7gkTFov9Ry5D2s
 f2yyiue6mY50LvgmwUd0szaZHFpgovD0tF8dTG2o+In3GyU3//R3QUOTpxvW74AT/F702dGrqXb
 B68rv+O4a8xo/jrqBWnr4bNEzU96xmkLMAYhzRh9YzW7k3zQIupgUGOteoXXgEbxaljQHxEeauL
 5DD2u8IpRuQsS9OLbv2ChdgxLyCLwxJB
X-Google-Smtp-Source: AGHT+IGR5W6QWC9QSAAA6xBkmVEWRcqzKp5/XDLMv4j5ihySqRKbssA9jSKataAbBvcHcUR1D3UPgA==
X-Received: by 2002:a05:600c:4755:b0:439:9b39:b31 with SMTP id
 5b1f17b1804b1-43ab0f2df0fmr40529875e9.8.1740506727486; 
 Tue, 25 Feb 2025 10:05:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/43] fpu: Pass float_status to floatx80_is_infinity()
Date: Tue, 25 Feb 2025 18:04:38 +0000
Message-ID: <20250225180510.1318207-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Unlike the other float formats, whether a floatx80 value is
considered to be an Infinity is target-dependent.  (On x86 if the
explicit integer bit is clear this is a "pseudo-infinity" and not a
valid infinity; m68k does not care about the value of the integer
bit.)

Currently we select this target-specific logic at compile time with
an ifdef.  We're going to want to do this at runtime, so change the
floatx80_is_infinity() function to take a float_status.

This commit doesn't change any logic; we'll do that in the
next commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250224111524.1101196-5-peter.maydell@linaro.org
---
 include/fpu/softfloat.h      |  2 +-
 target/i386/tcg/fpu_helper.c | 20 +++++++++++---------
 target/m68k/fpu_helper.c     |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index afae3906024..3c83d703baf 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -996,7 +996,7 @@ static inline floatx80 floatx80_chs(floatx80 a)
     return a;
 }
 
-static inline bool floatx80_is_infinity(floatx80 a)
+static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
 {
 #if defined(TARGET_M68K)
     return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 741af09f908..3b79bc049d1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1393,7 +1393,8 @@ void helper_fpatan(CPUX86State *env)
         /* Pass this NaN through.  */
     } else if (floatx80_is_zero(ST1) && !arg0_sign) {
         /* Pass this zero through.  */
-    } else if (((floatx80_is_infinity(ST0) && !floatx80_is_infinity(ST1)) ||
+    } else if (((floatx80_is_infinity(ST0, &env->fp_status) &&
+                 !floatx80_is_infinity(ST1, &env->fp_status)) ||
                  arg0_exp - arg1_exp >= 80) &&
                !arg0_sign) {
         /*
@@ -1442,8 +1443,8 @@ void helper_fpatan(CPUX86State *env)
             rexp = pi_exp;
             rsig0 = pi_sig_high;
             rsig1 = pi_sig_low;
-        } else if (floatx80_is_infinity(ST1)) {
-            if (floatx80_is_infinity(ST0)) {
+        } else if (floatx80_is_infinity(ST1, &env->fp_status)) {
+            if (floatx80_is_infinity(ST0, &env->fp_status)) {
                 if (arg0_sign) {
                     rexp = pi_34_exp;
                     rsig0 = pi_34_sig_high;
@@ -1462,7 +1463,8 @@ void helper_fpatan(CPUX86State *env)
             rexp = pi_2_exp;
             rsig0 = pi_2_sig_high;
             rsig1 = pi_2_sig_low;
-        } else if (floatx80_is_infinity(ST0) || arg0_exp - arg1_exp >= 80) {
+        } else if (floatx80_is_infinity(ST0, &env->fp_status) ||
+                   arg0_exp - arg1_exp >= 80) {
             /* ST0 is negative.  */
             rexp = pi_exp;
             rsig0 = pi_sig_high;
@@ -1829,7 +1831,7 @@ void helper_fxtract(CPUX86State *env)
         }
         fpush(env);
         ST0 = ST1;
-    } else if (floatx80_is_infinity(ST0)) {
+    } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
         fpush(env);
         ST0 = ST1;
         ST1 = floatx80_default_inf(0, &env->fp_status);
@@ -2173,7 +2175,7 @@ void helper_fyl2x(CPUX86State *env)
     } else if (arg0_sign && !floatx80_is_zero(ST0)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
-    } else if (floatx80_is_infinity(ST1)) {
+    } else if (floatx80_is_infinity(ST1, &env->fp_status)) {
         FloatRelation cmp = floatx80_compare(ST0, floatx80_one,
                                              &env->fp_status);
         switch (cmp) {
@@ -2188,7 +2190,7 @@ void helper_fyl2x(CPUX86State *env)
             ST1 = floatx80_default_nan(&env->fp_status);
             break;
         }
-    } else if (floatx80_is_infinity(ST0)) {
+    } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
         if (floatx80_is_zero(ST1)) {
             float_raise(float_flag_invalid, &env->fp_status);
             ST1 = floatx80_default_nan(&env->fp_status);
@@ -2341,11 +2343,11 @@ void helper_fscale(CPUX86State *env)
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
-    } else if (floatx80_is_infinity(ST1) &&
+    } else if (floatx80_is_infinity(ST1, &env->fp_status) &&
                !floatx80_invalid_encoding(ST0) &&
                !floatx80_is_any_nan(ST0)) {
         if (floatx80_is_neg(ST1)) {
-            if (floatx80_is_infinity(ST0)) {
+            if (floatx80_is_infinity(ST0, &env->fp_status)) {
                 float_raise(float_flag_invalid, &env->fp_status);
                 ST0 = floatx80_default_nan(&env->fp_status);
             } else {
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 339b73ad7dc..eb1cb8c6872 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -455,7 +455,7 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
 
     if (floatx80_is_any_nan(val->d)) {
         cc |= FPSR_CC_A;
-    } else if (floatx80_is_infinity(val->d)) {
+    } else if (floatx80_is_infinity(val->d, &env->fp_status)) {
         cc |= FPSR_CC_I;
     } else if (floatx80_is_zero(val->d)) {
         cc |= FPSR_CC_Z;
-- 
2.43.0



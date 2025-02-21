Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D70C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSj0-0004IH-K2; Fri, 21 Feb 2025 08:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlSiv-0004Hk-A8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:05:45 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlSit-0004Qg-2k
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:05:45 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f3ac22948so1059005f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740143136; x=1740747936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rBEAz91cT4zwETfCAofPC5Dxr6sRlmHQz0lKicsTSuU=;
 b=v1a0hykL325Q2KnVTjrdaRXUTjWahzkx8LB6gU9O/u8rsV6SVgzRmhhcMpP8K5T5fp
 5p91ydpbx+krNitbTTG0dnmBksXlazm9MmmE/HhoXVFaEBIpTxRArDSjUGgVSf1QS+Ya
 I15iOd0poGGFAq5zMNEX+n/j+kfUCXlT/KThO9lSibGxFSftIYSCaYnQzPtiDGGnGNQz
 qaWE74oYKbTSYTU1yLQKo8q22PUegsvoWBlZWGO4kXduGZBW2SMXFz2NSwPGq8ieaOQv
 OlMJGWMDnbJ31ziUHiibMLZcbl3xNYlnlywYlvnrx128+/FjasxrZI5c7atvpSUcRSQe
 fTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740143136; x=1740747936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBEAz91cT4zwETfCAofPC5Dxr6sRlmHQz0lKicsTSuU=;
 b=EeWEwWeo7YOtu8Ql8iR0QfrmQLG+MFI/1hktRnw0o9l0qJeW813AMlZyb3+pAs9m3m
 6PEV51fyXNLeI2tkU86OgqDMh6oX3XJrT8ObxjSManCQ5n9RztV1Mrw+Py2w9T0VV8D5
 +VBySyV/V3Ln0tCE2JS4k7J2TJEBpmlyFJYdK30lU9OrHfQe4K8WYcQDuJzJkijTRLlF
 9J0wKe63gzWGXaCv1OvSMxbZcis+Hm5NNlL6fGaB3tO3ByEFjHe4mSg4nCr6nGwW7MsL
 8PeDleJ70qjv7Q5kF2vpxSPRQs9os19EJom9uRsVniQiSjrgpof1dYS5FLj7B+ea6sXs
 CaIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyu4vcCaPxD7r1FS+VxVUtYTkeJVe+WmKHMGnMjK0pvvPsY16tJcKpRCT/S+PzjqqOfEHEXMTcr1vA@nongnu.org
X-Gm-Message-State: AOJu0YzwIAfOa3cpLD7Av3083TIdZkXXQJcl7dA1SGFomPgMzpdWJKiL
 Od2dls3VuPiBDMrYh96s9/sRRW0vPdJvAmuyyHABzqvhGyztnU8vXWDt469KJrk=
X-Gm-Gg: ASbGncsUnff9EbdXr/JLePfE1wMzy89cOwYogDoIfyCxXHVXxjBneHDuAfzBmccckjg
 2ft5/vC3ytqcEmF5mpJaigrlZ4yWRdcGieF/e0LRRdrS34oWQzTzm2AFJRJiBmOVXPzBvlNKxjd
 lAtdI91N/TJuF4dvV5bo1qQhnnW7klqwCW8X50iWpOJVR3yyNbd06dHykQ5LalcNxQnP0gzIs+6
 yKaNL36UdUrSL/ioC/J7Wv5cb1cm4im6YoP8BwWrr0Wm+UP2Gf/ff7QgM6ppn+nTSXE0qOPdJZD
 ++ksb7l+NFxHs9zsV/40UeJ+UJYc0CFdhFomMMuVwuzuFwuQ/uzxdNl3EHtQUszu6a9zgw==
X-Google-Smtp-Source: AGHT+IF/ieb9h19s8Fy2pO+2rUTjbkc65HM+w9pws8C+MQc4vsGGu0VJKX9CAEz6E6ER3U6BklTtKA==
X-Received: by 2002:a5d:47a7:0:b0:38f:2bd2:45d0 with SMTP id
 ffacd0b85a97d-38f6f0c3de8mr2979284f8f.51.1740143135912; 
 Fri, 21 Feb 2025 05:05:35 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25914d73sm23723568f8f.54.2025.02.21.05.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:05:35 -0800 (PST)
Message-ID: <8215abb1-6427-4cf0-8047-4f025e1ac8d5@linaro.org>
Date: Fri, 21 Feb 2025 14:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Peter,

On 17/2/25 13:50, Peter Maydell wrote:

> (1) floatx80 behaviours
> 
> Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
> use in the xsrqpxp round-to-80-bit-precision operation, and the
> Linux-user NWFPE emulation nominally supports it, but these are
> minor.) x86 and m68k disagree about some of the corner cases of
> floatx80 where the value has the explicit Integer bit wrongly set.  At
> the moment the fpu code defaults to "floatx80 behaves like x86", with
> TARGET_M68K ifdefs to get the other option.
> 
> The first six patches in this series remove those ifdefs, replacing
> them with a floatx80_behaviour field in float_status which can have
> various flags set to select the individual behaviours. The default is
> "like x86", which allows us to set these only for m68k and not worry
> about the minor "technically makes some use of floatx80" cases.


> Peter Maydell (10):
>    fpu: Make targets specify floatx80 default Inf at runtime
>    target/m68k: Avoid using floatx80_infinity global const
>    target/i386: Avoid using floatx80_infinity global const

Could you add a preparatory patch passing float_status argument
here? This eases the following patch review.

-- >8 --
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index afae3906024..3c83d703baf 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -999 +999 @@ static inline floatx80 floatx80_chs(floatx80 a)
-static inline bool floatx80_is_infinity(floatx80 a)
+static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 741af09f908..3b79bc049d1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1395,3 +1395,4 @@ void helper_fpatan(CPUX86State *env)
          /* Pass this zero through.  */
-    } else if (((floatx80_is_infinity(ST0) && 
!floatx80_is_infinity(ST1)) ||
+    } else if (((floatx80_is_infinity(ST0, &env->fp_status) &&
+                 !floatx80_is_infinity(ST1, &env->fp_status)) ||
                   arg0_exp - arg1_exp >= 80) &&
@@ -1444,4 +1445,4 @@ void helper_fpatan(CPUX86State *env)
              rsig1 = pi_sig_low;
-        } else if (floatx80_is_infinity(ST1)) {
-            if (floatx80_is_infinity(ST0)) {
+        } else if (floatx80_is_infinity(ST1, &env->fp_status)) {
+            if (floatx80_is_infinity(ST0, &env->fp_status)) {
                  if (arg0_sign) {
@@ -1464,3 +1465,4 @@ void helper_fpatan(CPUX86State *env)
              rsig1 = pi_2_sig_low;
-        } else if (floatx80_is_infinity(ST0) || arg0_exp - arg1_exp >= 
80) {
+        } else if (floatx80_is_infinity(ST0, &env->fp_status) ||
+                   arg0_exp - arg1_exp >= 80) {
              /* ST0 is negative.  */
@@ -1831,3 +1833,3 @@ void helper_fxtract(CPUX86State *env)
          ST0 = ST1;
-    } else if (floatx80_is_infinity(ST0)) {
+    } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
          fpush(env);
@@ -2175,3 +2177,3 @@ void helper_fyl2x(CPUX86State *env)
          ST1 = floatx80_default_nan(&env->fp_status);
-    } else if (floatx80_is_infinity(ST1)) {
+    } else if (floatx80_is_infinity(ST1, &env->fp_status)) {
          FloatRelation cmp = floatx80_compare(ST0, floatx80_one,
@@ -2190,3 +2192,3 @@ void helper_fyl2x(CPUX86State *env)
          }
-    } else if (floatx80_is_infinity(ST0)) {
+    } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
          if (floatx80_is_zero(ST1)) {
@@ -2343,3 +2345,3 @@ void helper_fscale(CPUX86State *env)
          }
-    } else if (floatx80_is_infinity(ST1) &&
+    } else if (floatx80_is_infinity(ST1, &env->fp_status) &&
                 !floatx80_invalid_encoding(ST0) &&
@@ -2347,3 +2349,3 @@ void helper_fscale(CPUX86State *env)
          if (floatx80_is_neg(ST1)) {
-            if (floatx80_is_infinity(ST0)) {
+            if (floatx80_is_infinity(ST0, &env->fp_status)) {
                  float_raise(float_flag_invalid, &env->fp_status);
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 339b73ad7dc..eb1cb8c6872 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -458 +458 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
-    } else if (floatx80_is_infinity(val->d)) {
+    } else if (floatx80_is_infinity(val->d, &env->fp_status)) {
---

>    fpu: Make targets specify whether floatx80 Inf can have Int bit clear

Ditto here:

-- >8 --
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 07259c59303..1c8f3cbb78d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1084 +1084 @@ static inline bool floatx80_unordered_quiet(floatx80 
a, floatx80 b,
-static inline bool floatx80_invalid_encoding(floatx80 a)
+static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b12ad2b42a9..2a20ae871eb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1813 +1813 @@ static bool floatx80_unpack_canonical(FloatParts128 
*p, floatx80 f,
-    if (unlikely(floatx80_invalid_encoding(f))) {
+    if (unlikely(floatx80_invalid_encoding(f, s))) {
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 3b79bc049d1..4858ae9a5fb 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1143,3 +1143,3 @@ void helper_f2xm1(CPUX86State *env)

-    if (floatx80_invalid_encoding(ST0)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
          float_raise(float_flag_invalid, &env->fp_status);
@@ -1385,4 +1385,4 @@ void helper_fpatan(CPUX86State *env)
          ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
          float_raise(float_flag_invalid, &env->fp_status);
@@ -1821,3 +1821,3 @@ void helper_fxtract(CPUX86State *env)
          ST0 = temp.d;
-    } else if (floatx80_invalid_encoding(ST0)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
          float_raise(float_flag_invalid, &env->fp_status);
@@ -1872,3 +1872,4 @@ static void helper_fprem_common(CPUX86State *env, 
bool mod)
          exp0 == 0x7fff || exp1 == 0x7fff ||
-        floatx80_invalid_encoding(ST0) || floatx80_invalid_encoding(ST1)) {
+        floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
          ST0 = floatx80_modrem(ST0, ST1, mod, &quotient, &env->fp_status);
@@ -2068,4 +2069,4 @@ void helper_fyl2xp1(CPUX86State *env)
          ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
          float_raise(float_flag_invalid, &env->fp_status);
@@ -2166,4 +2167,4 @@ void helper_fyl2x(CPUX86State *env)
          ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
          float_raise(float_flag_invalid, &env->fp_status);
@@ -2333,3 +2334,4 @@ void helper_fscale(CPUX86State *env)
      uint8_t old_flags = save_exception_flags(env);
-    if (floatx80_invalid_encoding(ST1) || floatx80_invalid_encoding(ST0)) {
+    if (floatx80_invalid_encoding(ST1, &env->fp_status) ||
+        floatx80_invalid_encoding(ST0, &env->fp_status)) {
          float_raise(float_flag_invalid, &env->fp_status);
@@ -2346,3 +2348,3 @@ void helper_fscale(CPUX86State *env)
      } else if (floatx80_is_infinity(ST1, &env->fp_status) &&
-               !floatx80_invalid_encoding(ST0) &&
+               !floatx80_invalid_encoding(ST0, &env->fp_status) &&
                 !floatx80_is_any_nan(ST0)) {
---

>    fpu: Make floatx80 invalid encoding settable at runtime
>    fpu: Move m68k_denormal fmt flag into floatx80_behaviour
>    fpu: Always decide no_signaling_nans() at runtime
>    fpu: Always decide snan_bit_is_one() at runtime
>    fpu: Don't compile-time disable hardfloat for PPC targets
>    fpu: Build only once

Thanks,

Phil.


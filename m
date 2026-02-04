Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877FE8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHP-0007Ql-Qb; Wed, 04 Feb 2026 00:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHO-0007QO-8Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:18 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHM-0007y3-O3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:18 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso3488690a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182295; x=1770787095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/dvFpuAgHW9LatoJl8ikUFTHhk3Jg3flnJ8ORHZmgw=;
 b=nI5TUchl+Xz6G84pwp+iZN+rYx0hnxRnCZbdloVBZkQZEwhBajcXtjhS2G+p/2kunH
 G/okrm+3jrqbc5MblxUT6fX0Bkkgdff9jUCrqV2dcaYOQoEv7NaCA0ljv7bXSURXLMpX
 jc7eVejs5yGTL7f4qohD+9Rl3iaR0SNq+4Ni8L7YlDAjYIdzraZ9Vd7dkQrtL401TUGC
 TWhGQ7QJ+1oTx+mwIVNo1z+YhW/eK2XlXQivJlEXRUUUNuH1+e61jdOS59XbVHHhXSkE
 AviiXz+ClNovFA+x+ueVsy4/a19gDeI0J/vfn9wPCVwOngdOBz0E80nC2FKnT2xr5oKA
 NmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182295; x=1770787095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I/dvFpuAgHW9LatoJl8ikUFTHhk3Jg3flnJ8ORHZmgw=;
 b=XLScBIXp96KIPOVGiUdKsgQF6XpQnJF8BEm8X4JwzMBvTphz4B7xYD2aJibKxgvkia
 XbDFyOH1bdwUQNJR6/ZYSdG6apQrb7IWSoqldtPkCin9uUbpZLh5Bp92rEAYAN6fQvdo
 8kHAlIthcVJDS7POWGRlX3/bQWuD+nquGj92P4NPuzro0emED38iFLMdLwky4ZnWXcKd
 BsQUE+g0qpFxhAcRAWoGxcxi4/WzvqTo8YoT1gaNFxABeqBnf7Jcc/hixrzaJVtjO+vx
 cQ6Ey05cS28L5b/YS+851tPrhkNpGZ3UqIAa0GGE3HPrEmYP6m9mOSIxio2lRT5HSjf4
 5t4w==
X-Gm-Message-State: AOJu0Ywe0xCVAJg1JmsBAUctmIfF6uu5k7Gjqyagi9mYMtbp2PlmS3Lh
 R9Ot967uYOZG+Ns9ula2bpjgw4XTlJIrAtSuXdxzeINVSAfdNwL81Xd9mlM845chJRWCbWjBLZC
 2XthJx9f1AjtYSyd5mpoBN/puZut4PIyBOyf09Zb3YgjcU2qSSA1U99WtOzQX6CaKeHTicGakHn
 EyGoDgvaFxS+DogrEaaxhX7NVVTgmfZddZyOMaO0gqlb2b
X-Gm-Gg: AZuq6aJYH5m3agDTtkbbBL7hyJCfReZoRXD2Qwa98JEt9nlA0b8qLZA8rpSPiYvgDRU
 WSD+V/XNQHWDWvM/IsG5eXtcV9iJdP8u9juemV/3T2Q7dQ2cudrwNTto/ZE62AfKpOujmxkFX5A
 8wb6YTXoI9NTpypiTLTxAsfqZemVN5bYToeQqSoS6ixCgjLiYQU5XgUuRtRmYOf5RIKvaI7aLij
 ELkpQx3zc/O1CE+jrr+BW4pKGA+Fth8gH+z3f3X47cAa9Dk4nGKIcN9Vwx7302sxN/Ggkc0X8IJ
 Q+ZTwBjY84OkJ8UzNKEJOoWsaMlGKyzw/qpbpzigOKsT3azcnqGYW2B+lzGmzVqsO0HQCfuCjlJ
 tM9g++OPOA1UmWt/FnqUMS5QWaGIqcAYAMAdXwmYGVreCQ1xAHbEdht7a+qnYnGyUNh2XtMszrp
 OCiXG0e79sSWrXBD7o87zy5QdJAJqaDZ+oMskVSi1mYLzCxn8/MKYmcnsC7jvpbxw0Ul5ohiUjf
 KXKwvM8+296NGIUSXiEsoShbQ==
X-Received: by 2002:a17:90b:57c5:b0:353:38c8:b612 with SMTP id
 98e67ed59e1d1-354870db3d6mr1547969a91.12.1770182295083; 
 Tue, 03 Feb 2026 21:18:15 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:14 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 04/19] target/i386: Fix pseudo-NaN handling in
 FPATAN/FYL2XP1/FYL2X helpers
Date: Wed,  4 Feb 2026 13:17:40 +0800
Message-ID: <20260204051756.667397-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to Intel's x87 FPU specification (Table 8-10, Vol. 1), arithmetic
operations on operands in unsupported formats (including pseudo-NaNs) must
return the QNaN floating-point indefinite value.

The helper functions for FPATAN, FYL2XP1, and FYL2X incorrectly check for
signaling NaN before checking for invalid encodings. This causes pseudo-NaNs
to be treated as valid signaling NaNs and silenced, rather than being
rejected as unsupported formats.

Reorder the checks to test floatx80_invalid_encoding before
floatx80_is_signaling_nan, matching the correct behavior already
implemented in helper_fscale.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/i386/tcg/fpu_helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b3b23823fd..37c83ded38 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1377,16 +1377,16 @@ void helper_fpatan(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2061,16 +2061,16 @@ void helper_fyl2xp1(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2159,16 +2159,16 @@ void helper_fyl2x(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
-- 
2.52.0



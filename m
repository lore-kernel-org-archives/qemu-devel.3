Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D32FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPf-0005xJ-9q; Wed, 29 Apr 2026 18:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPa-0005ZO-B5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:42 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPY-0006yw-P0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so72552a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501779; x=1778106579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEWBRKXT+wTqFRocOYKh1ix69RRmR5W8WvHkSkFeDvA=;
 b=hX/QORtSSRe1kQq3L+754t8FFq67VialxoKddTEXOJdYVonfy7/F94LWnHdnn2Hpyv
 8/DWX0hKA0t6hmkmWjYE+lIYorNiFkg156iwfm61ceJHqOP6W8HM4TzUNyGupAsj1U3D
 Ue5K1RHSLJbD+MV7DMr09RWU6zb7KXAFxl4q2qYH5Nl4DeuwokOt9ENU3Rk/jl8wFj91
 bVR9XFP+AYFJ+9FIJKkufoMn2Ddvag3gmUTfj6w98+vbD1nNIZJFuxOFZey6WpGBydNj
 YIlH1dl82VnSNZ4GeLiycsQe9/AaPA90sd8yAJ+W42upRmDg0OCvHyTwXAQSm5eOyBGT
 QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501779; x=1778106579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vEWBRKXT+wTqFRocOYKh1ix69RRmR5W8WvHkSkFeDvA=;
 b=kRzX9clawW+ZPmkhc8lC/o/czKGhrj62TcoFUSevcQizcgdAy+waEGkCbZUsn+Fbll
 7dFKlZTB4hXPDVgqPW2DB9Df97974zmc6HCHgeMMwvam6IMAgz1LmacPCzN7K7W4SSBk
 3lBUlWinVz8N5Ts2tyDfHuMFCQqoLwQhfcayQvx514kz345dPJ0il9kA8XqYiypEO67q
 MtuF8eAncsxFBfstPxuT2TccAlEvgYi63CsJZq2wU9P8zSD6akf6XZD6GMSUz0evgrfO
 A01W6FroCFmWl8cxojEnKLX7/8JCj8QNWv6FspkI66jQ8LipCG6Vsx4aWddIBfn1aFXI
 4AfA==
X-Gm-Message-State: AOJu0YwOtAwSxz16LU7ziZ18QjMFdnvBWoI6Z/S7gN1spv6lDt/9HDDP
 hOQuBc2bwnq3ZuMKVVz1FYSAXJt94nwwG9yKsEtXEaLfVun25XcgViPnE0xhtCFAcw+tcrBv7ro
 oqhR/c+o=
X-Gm-Gg: AeBDieu/+FJtHVxeN/qLqebehRFEGAgH9y9TnXVWWtIsE8f4VGbAGmCGTj/1Z6/FLQt
 jZI2Tnh0KuxcRRLvYXQQXmQ++CkZCAEmyLW+/tYtohZDr3IEs5GaMb/vlcmJ4Qa/E9qtkhzkNK2
 xFqoCTAlgAUANOmFUnUF6ZvLR8mImzobkjRL4sSQB7K8WZP7PAWeyMdhiDA2QXawLAelJMTWlb0
 Dz6t0hA1+yrQLYw216vesiA8hc4uSNFUqwfWsvX2dIGLZeMwEoaJP3AGi2m5wemyo4vp+SkzisV
 46CQji1mLfXbtZHg8p7Ydz1kQAIbGjAL61PA43HrtCxGK+T5/4rfwD+5aKhKtxrAO6FQRBKNRB+
 khdbLDH4qZLRIa71oXeS2F3pIomIcxpHskts0rBv7KXa73wsTdWtdMXk9LLJsBTYjSzYILI/W32
 E38qC3cDvNlOg5knz9WI9ZdFKKxGDtS3tGtQDG9mPF
X-Received: by 2002:a17:90b:3dc8:b0:35d:a4c0:a0ac with SMTP id
 98e67ed59e1d1-364c2f97d11mr183904a91.3.1777501779293; 
 Wed, 29 Apr 2026 15:29:39 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/48] fpu: Inline float32_unpack_raw into callers
Date: Thu, 30 Apr 2026 08:24:38 +1000
Message-ID: <20260429222445.26301-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 19cca8fb85..5e33eab8d5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
-{
-    *p = unpack_raw64(&float32_params, f);
-}
-
 static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
 {
     *p = unpack_raw64(&float64_params, f);
@@ -1529,7 +1524,7 @@ static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
 static void float32_unpack_canonical(FloatParts64 *p, float32 f,
                                      float_status *s)
 {
-    float32_unpack_raw(p, f);
+    *p = unpack_raw64(&float32_params, f);
     parts64_canonicalize(p, s, &float32_params);
 }
 
@@ -4913,9 +4908,8 @@ float16 float16_silence_nan(float16 a, float_status *status)
 
 float32 float32_silence_nan(float32 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = unpack_raw64(&float32_params, a);
 
-    float32_unpack_raw(&p, a);
     p.frac <<= float32_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
@@ -4984,9 +4978,8 @@ float16 float16_squash_input_denormal(float16 a, float_status *status)
 float32 float32_squash_input_denormal(float32 a, float_status *status)
 {
     if (status->flush_inputs_to_zero) {
-        FloatParts64 p;
+        FloatParts64 p = unpack_raw64(&float32_params, a);
 
-        float32_unpack_raw(&p, a);
         if (parts_squash_denormal(p, status)) {
             return float32_set_sign(float32_zero, p.sign);
         }
-- 
2.43.0



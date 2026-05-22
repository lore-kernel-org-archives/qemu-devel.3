Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774CECD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbG-0005We-EU; Fri, 22 May 2026 14:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbD-0005M0-DY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbB-0005bg-Gd
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b788a98557so49128275ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474472; x=1780079272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZFFZPDMpbzdsj37a9/p1FZxebig9+4EbrHozdK8lKs=;
 b=hMxgQxAIZOcyLcR5sH1NVa0U1g64Xyxu6D4YSdrgvz6HIKku+cAPcWYmOiJ+/aKY/o
 ihYkU3wxjcPrWS701KdmV/aCqfGY+rmnLlw1H56EEHVnyaJld+D/VUf3dDtty72UdlC0
 tMfbGwuTIffeere+VWs0+nKzk/ZMK2GeYGs9Xdy2juxZeehHibdYFaygEpwExzF61IJd
 eCyRmlluNSATSsn5YB6Au7F+aSKB/f9DfxMvHBG7xALKZI/1NwWyF1v1V3hY14Y49KCn
 cTbEKnMU0RmLQvi0QgBccaF1Cc9wasTfkMTZYIpt10CJYKuQ5pe9Cbrs5jwBtLzRKCHA
 YcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474472; x=1780079272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cZFFZPDMpbzdsj37a9/p1FZxebig9+4EbrHozdK8lKs=;
 b=ZYCMgDZN8KuVKqtD3kmkNfOTigrdVsi8QN3XoapXnICQKH+9Jd6s1OpXuhBib51Syd
 RZ2ykOyJx/kEKFg9moPOoXz6GmUk/eKARkulnE40UPBGAM5KqoT5MKrrBlcXVE32qkvk
 vrHBS+WAMg69GaFJS0HlObg0xXs3cp1/rVIt3KDvt22CSxn2a468M9fSh+CyqLoHD+Rb
 lb6nqsvWteGRKNf39cRhu14QQsN0i5v6SJAPhxXy/93MgS+MGKaAwoD3eux3CW4ZkhMb
 voRRX3SXvLDRRoZ6m06JvBSawpPjBHqhvnifNTPQW6n1hyI4R9tpXaxiTG5GJyOKV03o
 cxzQ==
X-Gm-Message-State: AOJu0YxEK6Oc2j8HISNJDbGcq0Zb9d5Dn05fGukKt6AadGDImS6jtXze
 j6Ki46hBgNvcOgn1Z0MbEk+r/dQcNSMQeuuEgRD2wOTY8zv/EereSh6e5bJ4UqfSVer2Wf5qVGi
 Ft6TP
X-Gm-Gg: Acq92OFHsWiNpotQW2r5PXS5Q1abtJdtmIZ4jQ0YommlOcsjvA346vsJIyp41y86m/p
 lPWzFoIr8qHjQ1Gv3qtN7GMVwxZMexgJh1ZccgB3e7V/1Lq+sMPjOD5HrOXvFxcdMkI+vpZr5xb
 ReiQ2k+47ftP9aecGWNAf5cS4SMS3ZHjaRQAX631BfWLvuqwAQ74x2WA+4Uhldku9lBYdiwMaOY
 1SPRmWN03u5VBFtGTtIPGL2Uy5myi0ScedfnsHJ+ae0Ho3YUEUTqGxa8HtbEAOh+PEJ74/8f+WV
 hZQJxXgPPoR+t04yZTktnYPQFSixNd4Qc6GNRntk1MX7BEgL/cAwmzIepRgIyU49tbX4EZWhpcJ
 /xK9B9ad+/E/zeySUOPlPK4Fp+bpyzXMZNArKdh26yCZiZNn9bXnXAoKWB+AWukpXR2TO49DvBK
 1IT9MRtFMjTxngaAWGww9huN2bND6X
X-Received: by 2002:a17:903:2bce:b0:2b7:a1ff:b239 with SMTP id
 d9443c01a7336-2beb0599ca0mr50716135ad.14.1779474471964; 
 Fri, 22 May 2026 11:27:51 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/30] fpu: Reorg float_status
Date: Fri, 22 May 2026 11:26:55 -0700
Message-ID: <20260522182658.184604-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use bitfields to compress float_status from 18 bytes down to 8 bytes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h | 53 ++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 67b7f38aef..c5a6684763 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -327,7 +327,7 @@ typedef enum __attribute__((__packed__)) {
      * This is a flag which can be ORed in with any of the above
      * DNaN behaviour options.
      */
-    float_infzeronan_suppress_invalid = (1 << 7),
+    float_infzeronan_suppress_invalid = (1 << 2),
 } FloatInfZeroNaNRule;
 
 /*
@@ -402,22 +402,39 @@ typedef enum __attribute__((__packed__)) {
  */
 
 typedef struct float_status {
-    FloatExceptionFlags float_exception_flags;
-    FloatRoundMode float_rounding_mode;
-    FloatX80RoundPrec floatx80_rounding_precision;
-    FloatX80Behaviour floatx80_behaviour;
-    Float2NaNPropRule float_2nan_prop_rule;
-    Float3NaNPropRule float_3nan_prop_rule;
-    FloatInfZeroNaNRule float_infzeronan_rule;
-    FloatSNaNRule float_snan_rule;
-    bool tininess_before_rounding;
+    FloatExceptionFlags float_exception_flags : 16;
+
+    /*
+     * Floating point status controls.
+     * Items that, in general, may be updated by writes to an architectural
+     * floating point control register.
+     */
+    FloatRoundMode float_rounding_mode : 3;
+    FloatX80RoundPrec floatx80_rounding_precision : 2;
     /* should denormalised results go to zero and set output_denormal_flushed? */
-    bool flush_to_zero;
-    /* do we detect and flush denormal results before or after rounding? */
-    bool ftz_before_rounding;
+    bool flush_to_zero : 1;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
-    bool flush_inputs_to_zero;
-    bool default_nan_mode;
+    bool flush_inputs_to_zero : 1;
+    /* should default nans be produced instead of propagating an input nan? */
+    bool default_nan_mode : 1;
+    /* should overflowed results subtract re_bias to its exponent? */
+    bool rebias_overflow : 1;
+    /* should underflowed results add re_bias to its exponent? */
+    bool rebias_underflow : 1;
+
+    /*
+     * Floating point behaviour controls.
+     * Items that, in general, will be set at cpu realization because
+     * the behaviour is baked into the specific hardware implementation.
+     */
+    bool tininess_before_rounding : 1;
+    /* do we detect and flush denormal results before or after rounding? */
+    bool ftz_before_rounding : 1;
+    FloatSNaNRule float_snan_rule : 2;
+    Float2NaNPropRule float_2nan_prop_rule : 3;
+    Float3NaNPropRule float_3nan_prop_rule : 7;
+    FloatInfZeroNaNRule float_infzeronan_rule: 3;
+    FloatX80Behaviour floatx80_behaviour : 5;
     /*
      * The pattern to use for the default NaN. Here the high bit specifies
      * the default NaN's sign bit, and bits 6..0 specify the high bits of the
@@ -427,11 +444,7 @@ typedef struct float_status {
      * this to the correct non-zero value, or we will assert when trying to
      * create a default NaN.
      */
-    uint8_t default_nan_pattern;
-    /* should overflowed results subtract re_bias to its exponent? */
-    bool rebias_overflow;
-    /* should underflowed results add re_bias to its exponent? */
-    bool rebias_underflow;
+    unsigned default_nan_pattern : 8;
 } float_status;
 
 #endif /* SOFTFLOAT_TYPES_H */
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA3BCD37AC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72R-0000vB-9Y; Thu, 07 May 2026 18:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72P-0000uj-OL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:45 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72N-0003GE-IC
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:45 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69489b43d66so493521eaf.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192261; x=1778797061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ql6IrJYv3xEXqYOspRQ/aUl8zlzTCfoV/nJUo5gvq8Y=;
 b=i74wCC1ru0QKwF7H4+Z5zmZ6HN3YdM9Uvprw706Lt5ES+x9mMK/5kyG276ANQzO9EP
 CP9a6IKZiGV1d8WwqT6jkZeUV9DoI+hVqKqHwRcLotYEKajbkHQrJOzihovirCNxy8DI
 lF+4rzalXDldeEbwsKsWi1YvEOkFqQMCEZpMIFw42O4IKTOzAcNSQL3Y4Rvw84bZZUyq
 lsSWUfNFzQSd2TlEynVvqQaUdlqY4S8wklS9B1kqmjFR/VvI4i12wvn3/rxLbqw6fXyW
 o3EJp50Y2hiE7o7A8KFOLsSPNEU4g+xoSK8h1t+Gqcq8Sh8FRF905yXDfZdQ6D2ZsPXm
 yLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192261; x=1778797061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ql6IrJYv3xEXqYOspRQ/aUl8zlzTCfoV/nJUo5gvq8Y=;
 b=fVzVnODR2wietO2jTb2cmC2dqHYF8wEAGQ1kayNSjaQ2abrx+5nKck/zbIBraZ+rd3
 +BvbeASwkwUyRqzJd1umMmAn+Pdd8UswjtIe13ubHMafKFcz1L1c5IPTjVBdkNNWqtBJ
 7rGiT+deGeVdt34WeXLGr84qNf17oa+n0oUTuQqjiKMgdG9wRuMPMX5Nxvqo0nAzEZ0d
 vvRnCiN+Qb3APb7L8W3A69fYntNmpaxdcgkM5ODtOLgccpFdYt4NEM2gxlEZHywDURF3
 D0mTV0gIIkvx4i1/a8sVhAKQz0xwxWVZwgi37JSmZ31L1YS3gsO1nnVVLQ4FrVfaSInK
 RIHw==
X-Gm-Message-State: AOJu0Yy49rRcxyKwxGobf8dVoupOs/0KnfzqGEj5+a0kFddD5GrHF0/L
 u4n2zTwiV4DpGlnxRD0KFV3VikmQazGfpwM/rGakl0Xg8LfH2Unm+z18d64ynFlTKCtzkfR2SwH
 XI/2H
X-Gm-Gg: AeBDieveCn2lFVgAZfdUssg/BG73pFL9FLQOUbThyXQOfzm2yvVmOv0JJUyqqTB3xCn
 8Mg/nZvbWuaunVZf9kawjYYOQ013A4AELcRxWqqScEDlBu+4P0wqDdcjjOLAFbsbhmcDWsnYcc/
 6R1mhckB+IHs98fTmMauBNkExkukp4bAVLwzeBECerR2juV1TDIqVmgwMtjB/Pit2+KmD5TeEyl
 AA0duO+7q3suSxGWvxb4jluGXQWgpjjFpQmZeR5owNqAcXQnuqykbsIE+ha255lq6mAZ7b+haa7
 O6P5OivZRm78a57WufLUEgtZkBHCFIqRqFD8tlycbWz1J2bCH+2bF6PojYE/xUPjjaCLKo/AkOr
 d9EmEkBtQThO69nIQKd9zTAuZWfBJglCOidFQHPsujW9AY7aWDS4qYEsWVYyU5/e5m5xayc5jGg
 SpZG1QCINdMhy+BhlsOuGqk5U+eg3X7swx96d1eRzKqh7RCA==
X-Received: by 2002:a05:6820:180e:b0:696:155e:cd49 with SMTP id
 006d021491bc7-69998d61d09mr5441497eaf.54.1778192261336; 
 Thu, 07 May 2026 15:17:41 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/18] fpu: Reorg float_status
Date: Thu,  7 May 2026 17:17:17 -0500
Message-ID: <20260507221717.486023-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h | 53 ++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b83f67defc..d77f48f6b0 100644
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



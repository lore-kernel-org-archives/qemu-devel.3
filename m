Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DDECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL726-0000o9-5J; Thu, 07 May 2026 18:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL725-0000nc-7T
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:25 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL723-00039T-Fp
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:24 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479f7e75a6bso558452b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192242; x=1778797042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/+31lNyXueXDBAFm1O2dQftBU8iJ7a4LsUCFtAoHuwI=;
 b=J5sdyAa6VuV+Y7n/I8rO1vzUd2VOneQeQ8/DH6jN6vKRvR7074FOJ/W7eykGj01UuE
 1vmDJK+VGDzKDfUeh5AgniepwCWMG8QOUxhXlD6u61ABl8m1nBGX/21VHY7Yte4RcJ6/
 z7pXYrS7X4FFKN+tAWtqCxcAO1wzOK02yGzMk7+4M+LVFGjNjWy8u/wM7B5hITAWy5Ss
 MxSXyXNlwYwp+fdjnZ6rt7DBs0Apu5NjsIbC3gRSkB1emg4DZapY+Xk3PLyd9Gjmsxrq
 uCuagRUJ9Ddm/9GtSJKztyZ4cuWECtxPEB4xCIJrweahENHkrB/CfTj4c+9Re4QOsqFS
 /7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192242; x=1778797042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/+31lNyXueXDBAFm1O2dQftBU8iJ7a4LsUCFtAoHuwI=;
 b=PyBg+Hgv2A9OMYjE/nEmg/9a1JWj3fSwqf+nxFO7uJNIklTdihF4qxrn9o5TpYnlSZ
 N49vjSzYWuPrRi/AWB8iUlkMz2qmgQp0ybjKYFVbBB5xQDedSq4Kp+5iZLJj54lWjgn2
 WKZ2klp7eXsTz2hh3OldZEkfMN4cfzs7HTSF6vH7F5jEp1MnmSg94jKOw7NMaaSmsl0w
 ZDMjB87Q8C+9vc9S6a6JWmvUMb45IcOKIxpAcmN0pEwS8Mq/dgho1rcPe2++IjadyzpI
 fp09+mdnKsrtm8BKNzwH8ch+XPPmjoaZzBfFBk15vn4Bujk3GfqjnRDcLYtx2yDzQK3S
 BEiw==
X-Gm-Message-State: AOJu0YyrR5iZzLmsnTFgeNml62KCK17hKC3zVlzkBDE3QxRirxZaA5B6
 lAJofB/O9Oh84VkBJvlkgb4/KnTcrwOsYG7uGO/QoYMROQELY4pPmlBk4sBUksuaSNUizH/QKmZ
 pXuZ6
X-Gm-Gg: AeBDievt4uv4Cp+u+vKSeE4Fuw93GTlC/kR8aqze4palylajkvuFrOAjlaWqhu2iO1w
 ihkB8toL5+5IuF52W8kMioWlHPzRY163jPO0kKnZCBV3cXq6Qdrl8wtP48xBo7HUtbi3ERY2xGl
 V9sDp+qmAUKO1gILoJ5pm9OaFlTTBEIOu4jwysFM2kWhz152Z5FAd9ZLeiyTI6SMx+d3EQeNCWh
 e4ZHVdEo/MFeYl6J/RbJhH1ouKfKafpIodpkUuY5qpKOay8c3mbr+I6aCo3ND0fGuotTxizu3K+
 9JJ4SG6/9z7lCJxcljYYz7NQPZsAkB7jnJDJkIuacO9f1YVio8zyO7q6v+mWEETZYB+3xTyFPzo
 XuMyYeh1RSgyQ0TMCfc06CG0HOdg6GqiXIuor5qslt4qDshCF/r37IzfaTYA3ZJfPNaE93siZOZ
 mw+8L2WiwsAgJ131e59lrIQsD6qp1JwcjWdqVqFT0wzX6AeYTSZd4wFuBi
X-Received: by 2002:a05:6808:2382:b0:46a:6d33:65a8 with SMTP id
 5614622812f47-480424ca04emr5988873b6e.32.1778192241700; 
 Thu, 07 May 2026 15:17:21 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/18] fpu: Introduce FloatExceptionFlags
Date: Thu,  7 May 2026 17:17:01 -0500
Message-ID: <20260507221717.486023-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

We have, in the past, used any of uint8_t, uint16_t or int
to hold the set of exception flags.  Use a typedef instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 6 ++++--
 include/fpu/softfloat-types.h   | 4 +++-
 include/fpu/softfloat.h         | 2 +-
 fpu/softfloat.c                 | 2 +-
 fpu/softfloat-parts.c.inc       | 7 ++++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 90862f5cd2..745a49f07a 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -64,7 +64,8 @@ static inline void set_float_rounding_mode(FloatRoundMode val,
     status->float_rounding_mode = val;
 }
 
-static inline void set_float_exception_flags(int val, float_status *status)
+static inline void
+set_float_exception_flags(FloatExceptionFlags val, float_status *status)
 {
     status->float_exception_flags = val;
 }
@@ -146,7 +147,8 @@ static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
     return status->float_rounding_mode;
 }
 
-static inline int get_float_exception_flags(const float_status *status)
+static inline FloatExceptionFlags
+get_float_exception_flags(const float_status *status)
 {
     return status->float_exception_flags;
 }
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index ead146c22d..5048faa76f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -181,6 +181,8 @@ enum {
     float_flag_input_denormal_used = 0x4000,
 };
 
+typedef uint16_t FloatExceptionFlags;
+
 /*
  * Rounding precision for floatx80.
  */
@@ -385,7 +387,7 @@ typedef enum __attribute__((__packed__)) {
  */
 
 typedef struct float_status {
-    uint16_t float_exception_flags;
+    FloatExceptionFlags float_exception_flags;
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
     FloatX80Behaviour floatx80_behaviour;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1580d956d5..4ae4ddc799 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -101,7 +101,7 @@ typedef enum {
 | Routine to raise any or all of the software IEC/IEEE floating-point
 | exception flags.
 *----------------------------------------------------------------------------*/
-static inline void float_raise(uint16_t flags, float_status *status)
+static inline void float_raise(FloatExceptionFlags flags, float_status *status)
 {
     status->float_exception_flags |= flags;
 }
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a6ab3ee0f8..9fc0b83cd1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2964,7 +2964,7 @@ static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
 static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
-    int flags = 0;
+    FloatExceptionFlags flags = 0;
     Int128 r;
     FloatParts128 p = float128_unpack_canonical(a, s);
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 789a41d24e..8253d480f5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -297,7 +297,8 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     const uint64_t roundeven_mask = round_mask | frac_lsb;
     uint64_t inc;
     bool overflow_norm = saturate;
-    int exp, flags = 0;
+    int exp;
+    FloatExceptionFlags flags = 0;
 
     switch (s->float_rounding_mode) {
     case float_round_nearest_even_max:
@@ -1265,7 +1266,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
                                      int scale, int64_t min, int64_t max,
                                      float_status *s)
 {
-    int flags = 0;
+    FloatExceptionFlags flags = 0;
     uint64_t r;
 
     switch (p->cls) {
@@ -1333,7 +1334,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
 static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
                                       int scale, uint64_t max, float_status *s)
 {
-    int flags = 0;
+    FloatExceptionFlags flags = 0;
     uint64_t r;
 
     switch (p->cls) {
-- 
2.43.0



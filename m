Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35285FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjH-0007Dd-TQ; Sun, 26 Apr 2026 09:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjF-00079E-0L
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjD-0008S5-0r
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b941cd869cso6860625ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210853; x=1777815653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOhr11zVvt44EpENvwVC0mN/CNtKtYPzWM2DbHLH1/I=;
 b=SChi2SEvFlIewVxbp7+As4pni2P0n9391p0PHsBh2FmSn1DM/DsocvFuwo+21UDK4z
 vP7+BPJ67nlpmuXgTFVAjfYNX91n/pCBbqglyG6myr43Qct3s+YaH/drfK7YAfFDA7gZ
 vA5xvtSXbprVfCRYDJYi04mcb7l4lbi8Ej6RFtC0caPVqKkKPwjk1FntFAmq54Szrrjv
 HYi6lmMtxYag5SMnEOd+T5vNzCilevX2irU1EyF7u3ZQGsh26nUBMS6ODt2rIErnUccI
 bohsLlZs+xbckKw9D78jg6L1hm2Zz5E3Yv17qQ/6VTl8zdpeQkY1BKWvPLQPr+BOW/jD
 n5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210853; x=1777815653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OOhr11zVvt44EpENvwVC0mN/CNtKtYPzWM2DbHLH1/I=;
 b=dUfOQrM+/0363zvHDP8f0RrG+nu9ICV6EVUwFraGBmCdQKAd4hgBUvyKLf7Na1a0uX
 2ejA22W7modKadjxnI23MwP3hIfttyYyYINdHF4u2mnwoJY105JRkidNJTk53YP3Rmjm
 wl1HLtd7OPZRzVjJYKI+e3hYSoZ0C6ONFkquaEG1JEAPj9uN1D6bxddhW8z9KVi1+ouX
 mZJds3PVakCdq1SjNp2fTDygaEVWuq2ECzwABSKKiE3vRhWOD3qG9vB2RClEZEMp+Edl
 TzA+cWhUaJbmgmq4NGVjP90swLiR88uAYAe0eiNyfoyXcq5UFuXunIqFFtwNntSYiVBS
 4Jng==
X-Gm-Message-State: AOJu0YwLZoJzIpEzxwlUmS0DUQEEwOZkqlXRWzWb+eqDzY14rn3l6k/g
 mZQ344ujT+ZXJNkvTptylm8/WII7O+QcsBxlxeA13ca3gPUXlky9O7XcB9w5KCECAiEfq8Y0q4X
 gMlnLFfg=
X-Gm-Gg: AeBDievwO5kzRT7tIJIR6PfqgIKri8XZOPunFTW+hpHFb6R26fk/SN1Fg5amy+Y1RYD
 aArXXaXpwhofTjxgRrDnm/520QerJT+Wt91hpv2kbXTGScuXB7qLEyxlZuK8j29l8GV8MCP/tu+
 CjmocQiQOBa5AqixFVe41ZB4nQxPxV+nAL0gPu0tEG9Yv7/kah10CZWNcK4WmBCTuThK5RfDLKX
 Pzivd6cPRu1+EBNp4J+/zxGAWoCbPJU/vAq+0/rpOCEpPBs/HTBrAwasduPHLpTqBtVzOl0QM7W
 d0fVvtERC9ThxsH3qRAJRwiycFgAQfjar8sIq5jh41KvLksWmi4e8YwPChfYvfpxRXG3J9lltB8
 eiDnF7yL6kwmOKS1U15L7LDL4d4UJ+uf+LTw81iGbD7Y6l8UBXtq+62FWxXms0VOQEzR8iwvWzv
 aLztgaQvN4nrXSMZGaGg0ATrX8Rh1ZBCQeVaN9CeIx
X-Received: by 2002:a17:903:37c4:b0:2b9:601e:da11 with SMTP id
 d9443c01a7336-2b9601edceemr13915595ad.35.1777210853342; 
 Sun, 26 Apr 2026 06:40:53 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 17/84] fpu: Drop parts_round_to_int_normal
Date: Sun, 26 Apr 2026 23:38:54 +1000
Message-ID: <20260426134002.865628-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 22 +++++++---------------
 fpu/softfloat-parts.c.inc | 10 +++++-----
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0a6bc6d580..1f03fcf687 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static bool parts64_round_to_int_normal(FloatParts64 *a, FloatRoundMode rm,
-                                        int scale, int frac_size);
-static bool parts128_round_to_int_normal(FloatParts128 *a, FloatRoundMode r,
-                                         int scale, int frac_size);
-
-#define parts_round_to_int_normal(A, R, C, F) \
-    PARTS_GENERIC_64_128(round_to_int_normal, A)(A, R, C, F)
-
 static void parts64_round_to_int(FloatParts64 *a, FloatRoundMode rm,
                                  int scale, float_status *s,
                                  const FloatFmt *fmt);
@@ -3365,7 +3357,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
 
     case float_class_normal:
     case float_class_denormal:
-        if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
+        if (parts128_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
         }
 
@@ -3793,7 +3785,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
 
     case float_class_normal:
     case float_class_denormal:
-        if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
+        if (parts128_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
             if (p.cls == float_class_zero) {
                 r = int128_zero();
@@ -5482,11 +5474,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
          * of distinguishing partial quotients, so ignore the exception.
          */
         *n = *q;
-        parts_round_to_int_normal(n,
-                                  is_q_smallish ?
-                                      final_quotient_rounding_mode :
-                                      float_round_to_zero,
-                                  0, fmt->frac_size);
+        parts64_round_to_int_normal(n,
+                                    is_q_smallish
+                                    ? final_quotient_rounding_mode
+                                    : float_round_to_zero,
+                                    0, fmt->frac_size);
 
         /* Compute precise remainder */
         r_precise_buf = *b;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6e1800b117..9b719ac5cf 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1127,7 +1127,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
  * according to the IEC/IEEE Standard for Binary Floating-Point
  * Arithmetic.
  *
- * parts_round_to_int_normal is an internal helper function for
+ * partsN(round_to_int_normal) is an internal helper function for
  * normal numbers only, returning true for inexact but not directly
  * raising float_flag_inexact.
  */
@@ -1270,7 +1270,7 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
         break;
     case float_class_normal:
     case float_class_denormal:
-        if (parts_round_to_int_normal(a, rmode, scale, fmt->frac_size)) {
+        if (partsN(round_to_int_normal)(a, rmode, scale, fmt->frac_size)) {
             float_raise(float_flag_inexact, s);
         }
         break;
@@ -1316,7 +1316,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
     case float_class_normal:
     case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
+        if (partsN(round_to_int_normal)(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
         }
 
@@ -1384,7 +1384,7 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
     case float_class_normal:
     case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
+        if (partsN(round_to_int_normal)(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
             if (p->cls == float_class_zero) {
                 r = 0;
@@ -1448,7 +1448,7 @@ static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
     case float_class_normal:
     case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (parts_round_to_int_normal(p, rmode, 0, N - 2)) {
+        if (partsN(round_to_int_normal)(p, rmode, 0, N - 2)) {
             flags = float_flag_inexact;
         }
 
-- 
2.43.0



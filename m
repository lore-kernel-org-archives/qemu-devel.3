Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6294CCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ES-0004aX-E6; Thu, 07 May 2026 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EM-0004WN-Am
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006mN-RJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:41 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d1872504cbso987180a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169931; x=1778774731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/DtA0bTg/+qbb2xEBeyZd976Nwj4hvFStm5Q31fGd4=;
 b=uZO3jhlRAEOp4qp30ZEBvtkNIFK27jo78psrQ9e17ZOHpYCPo3z1/AnxHb12yUHMrK
 8kzmy1f6bDK+RARQw7TZR6pEaHj2re+AFRGKkkdFzWAJJBOfausvQ2Gsa0tToPGd5rtd
 j18QVwv9tI3I8a0KXwkr77eAIe9pshI+anfqvC+kUxWBpoSFqF8jYTVZYOqmDYYulgDa
 xemjKu4EcFeXd5CrvUUP1AWBGTUTYawOf4vfGqEC21s6O9bWnAHa1vcMPXCNn5QFtQd6
 3pWfg6Ltz56cfeKGQTokrDwcOilG/qyCZ9+D9ThgXEcZnajUVq+SfyBmD7NE0HctKZWA
 va2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169931; x=1778774731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t/DtA0bTg/+qbb2xEBeyZd976Nwj4hvFStm5Q31fGd4=;
 b=WzL2preQgBHSdnpaKUt79MaGwb1IobUxXJ7PRayrUGUix+1VP7cIxjTw7n4wvR8VQl
 t4n9P8RO5myd53tShog+t2DCxqqVLvrGfRCUKQQEY9K10KrILrtf2J5UK0HaARP39Oay
 2Szd6bvF9YF97NKptyIgeeaKlHB2PxG2ceMeH9y7+aKyQX6iaABDYeo3FF4As2ubAbE9
 6i+4h6ASmV7Kiri9/4xdTU2eleA9bhCxuHtjq32zK8zTk7AiBMlErYy5lb9wQW0kjQm5
 cr3btWrmFZtoTc7xl1bbjzS3vG23KDmS34WXiHVU9hmauWdDJRvV9OM4wBgKitwJyZRh
 PIRA==
X-Gm-Message-State: AOJu0YwQ1e2hjzR1Fz5v4CuLDfNAlCc9bsKTiZllcOGUjcXuFcTGQJM2
 ZgcZvkREj7vDlbfHFpJTUOkNyBG94+HfMT+n6skLudU/iyugSm6rk0aSdPS+AuI6CKboLfzj7NF
 tOmXh
X-Gm-Gg: AeBDietXgxV7LvA9WwmUaTU5NaBi8UzG8d6k6lDpVfO4pLm634Z2uQ7zpwC4GUdhVxY
 /yVPpWknGjj80078vHMxVA/xgqOf4lFNL7BPQyxMibn+3rp2KqqDlfOExt6WSq2lEXQ/wFp43aA
 UZ16oJRV+3ydqSEO9cRbtp7mB5nNil7tOTptiSw1LvFEt1DRpg8bm9LdZzsv8swxCx+LlMdB8ir
 ltClZ0jBYjvrWJ9vfyhS7NAMVZVJSvIhkz2H3Qjxwkw8yaQIQOgA7anCbMSMMo3DR9mgwb81tlh
 pVWI78K2k6U25ev6Xx6+N1Sly3Pgu7oe0kcsAKkphePy006B39z9WjOG2hW0y8ZxpcVTtX8arx5
 LRtQAuJf4eDGw88MqQOhF9nmLvPAW0aeNsE0bCjyoqmPg3sWEwr61YeDzG5LXLTbfpkIpXou2o9
 w3NpDRofcBlHh1FEpsOw4TrU0Xt/j56s0vkkVQnjf+JxiK5g==
X-Received: by 2002:a05:6830:3806:b0:7dc:a51c:9197 with SMTP id
 46e09a7af769-7e1fd07120cmr1994535a34.7.1778169930962; 
 Thu, 07 May 2026 09:05:30 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/29] fpu: Split FloatParts{64,128} to softfloat-parts.h
Date: Thu,  7 May 2026 11:04:57 -0500
Message-ID: <20260507160518.444797-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Begin exposing the intermediate representation of softfloat.
Start with just the representation structures.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 88 +++++++++++++++++++++++++++++++++++
 fpu/softfloat.c               | 69 +--------------------------
 2 files changed, 90 insertions(+), 67 deletions(-)
 create mode 100644 include/fpu/softfloat-parts.h

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
new file mode 100644
index 0000000000..13c1f3d2d6
--- /dev/null
+++ b/include/fpu/softfloat-parts.h
@@ -0,0 +1,88 @@
+/*
+ * Floating point intermediate representation
+ *
+ * The code in this source file is derived from release 2a of the SoftFloat
+ * IEC/IEEE Floating-point Arithmetic Package. Those parts of the code (and
+ * some later contributions) are provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file after December 1st 2014 will be
+ * taken to be licensed under the Softfloat-2a license unless specifically
+ * indicated otherwise.
+ */
+
+#ifndef SOFTFLOAT_PARTS_H
+#define SOFTFLOAT_PARTS_H
+
+/*
+ * Classify a floating point number. Everything above float_class_qnan
+ * is a NaN so cls >= float_class_qnan is any NaN.
+ *
+ * Note that we canonicalize denormals, so most code should treat
+ * class_normal and class_denormal identically.
+ */
+
+typedef enum __attribute__ ((__packed__)) {
+    float_class_unclassified,
+    float_class_zero,
+    float_class_normal,
+    float_class_denormal, /* input was a non-squashed denormal */
+    float_class_inf,
+    float_class_qnan,  /* all NaNs from here */
+    float_class_snan,
+} FloatClass;
+
+#define float_cmask(bit)  (1u << (bit))
+
+enum {
+    float_cmask_zero    = float_cmask(float_class_zero),
+    float_cmask_normal  = float_cmask(float_class_normal),
+    float_cmask_denormal = float_cmask(float_class_denormal),
+    float_cmask_inf     = float_cmask(float_class_inf),
+    float_cmask_qnan    = float_cmask(float_class_qnan),
+    float_cmask_snan    = float_cmask(float_class_snan),
+
+    float_cmask_infzero = float_cmask_zero | float_cmask_inf,
+    float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
+    float_cmask_anynorm = float_cmask_normal | float_cmask_denormal,
+};
+
+/*
+ * Structure holding all of the decomposed parts of a float.
+ * The exponent is unbiased and the fraction is normalized.
+ *
+ * The fraction words are stored in big-endian word ordering,
+ * so that truncation from a larger format to a smaller format
+ * can be done simply by ignoring subsequent elements.
+ */
+
+typedef struct {
+    FloatClass cls;
+    bool sign;
+    int32_t exp;
+    union {
+        /* Routines that know the structure may reference the singular name. */
+        uint64_t frac;
+        /*
+         * Routines expanded with multiple structures reference "hi" and "lo"
+         * depending on the operation.  In FloatParts64, "hi" and "lo" are
+         * both the same word and aliased here.
+         */
+        uint64_t frac_hi;
+        uint64_t frac_lo;
+    };
+} FloatParts64;
+
+typedef struct {
+    FloatClass cls;
+    bool sign;
+    int32_t exp;
+    uint64_t frac_hi;
+    uint64_t frac_lo;
+} FloatParts128;
+
+#endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8c4263bfe6..cd75df3160 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,6 +83,7 @@ this code that are retained.
 #include <math.h>
 #include "qemu/bitops.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 
 /* We only need stdlib for abort() */
 
@@ -396,39 +397,6 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     return soft(ua.s, ub.s, s);
 }
 
-/*
- * Classify a floating point number. Everything above float_class_qnan
- * is a NaN so cls >= float_class_qnan is any NaN.
- *
- * Note that we canonicalize denormals, so most code should treat
- * class_normal and class_denormal identically.
- */
-
-typedef enum __attribute__ ((__packed__)) {
-    float_class_unclassified,
-    float_class_zero,
-    float_class_normal,
-    float_class_denormal, /* input was a non-squashed denormal */
-    float_class_inf,
-    float_class_qnan,  /* all NaNs from here */
-    float_class_snan,
-} FloatClass;
-
-#define float_cmask(bit)  (1u << (bit))
-
-enum {
-    float_cmask_zero    = float_cmask(float_class_zero),
-    float_cmask_normal  = float_cmask(float_class_normal),
-    float_cmask_denormal = float_cmask(float_class_denormal),
-    float_cmask_inf     = float_cmask(float_class_inf),
-    float_cmask_qnan    = float_cmask(float_class_qnan),
-    float_cmask_snan    = float_cmask(float_class_snan),
-
-    float_cmask_infzero = float_cmask_zero | float_cmask_inf,
-    float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
-    float_cmask_anynorm = float_cmask_normal | float_cmask_denormal,
-};
-
 /* Flags for parts_minmax. */
 enum {
     /* Set for minimum; clear for maximum. */
@@ -474,40 +442,7 @@ static inline bool is_anynorm(FloatClass c)
     return float_cmask(c) & float_cmask_anynorm;
 }
 
-/*
- * Structure holding all of the decomposed parts of a float.
- * The exponent is unbiased and the fraction is normalized.
- *
- * The fraction words are stored in big-endian word ordering,
- * so that truncation from a larger format to a smaller format
- * can be done simply by ignoring subsequent elements.
- */
-
-typedef struct {
-    FloatClass cls;
-    bool sign;
-    int32_t exp;
-    union {
-        /* Routines that know the structure may reference the singular name. */
-        uint64_t frac;
-        /*
-         * Routines expanded with multiple structures reference "hi" and "lo"
-         * depending on the operation.  In FloatParts64, "hi" and "lo" are
-         * both the same word and aliased here.
-         */
-        uint64_t frac_hi;
-        uint64_t frac_lo;
-    };
-} FloatParts64;
-
-typedef struct {
-    FloatClass cls;
-    bool sign;
-    int32_t exp;
-    uint64_t frac_hi;
-    uint64_t frac_lo;
-} FloatParts128;
-
+/* FloatParts256 is entirely internal, for parts128_mul* */
 typedef struct {
     FloatClass cls;
     bool sign;
-- 
2.43.0



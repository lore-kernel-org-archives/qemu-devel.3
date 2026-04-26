Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE3FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpg-0000R0-FP; Sun, 26 Apr 2026 09:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoW-00066e-8z
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoS-0001c8-4u
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so31865565ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211173; x=1777815973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GMWNSvP4+a2tsIwQ0vCb3/nsg3VFSARC/RvRT7Zej8=;
 b=OAGpptCybT/1mnTvThTfSF6pApZhBRNaEbCz60urCQwxxBZICn4zWrarSQFj+PrwzM
 8kcctc6EsKxnqe8Px5tHfcoFohQ55A8h+S68MufhlYtBTGqcfbzMJGccVxNcctWSvlme
 Y9MaiWqK3mvkWDnnNUESHhLftOvWdfeerXXp8vuLQdYjrxnijWoZHG4x3RnvGzNDg7iN
 AC1xhaXfeEvHSL0P5IkDHq3ZoBrHhQ423cujbDu5U6JTrFCSUoxAEi9JFAWtWviHBg2D
 FQcbPFk5W+sw14NAHb2/4DXMey97RjU0q2Ng8gr8kb2qp3RC7ZbviZQxZq5f9GK979NY
 BsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211173; x=1777815973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GMWNSvP4+a2tsIwQ0vCb3/nsg3VFSARC/RvRT7Zej8=;
 b=YbDoucvBVLKzLuSSXvOv3kKX6oEDyD9nqIDHNdBzM9iE5HvYMHXtYBKkHoMhgHVQI1
 iJbbeW+1EYMlbixZ4zpNm1SAQ5ALCeiVHI9iMVGikOKJobB3mrMZ5dNf/ur1Qf/p5/hC
 f6ZwIpaaHbZLUa6JKhOnZnWiG+HhSrDu2DposkgEzWZIZ3gwNlh7SXDRc/aMwxDmbMmh
 owg8tuWSU5yfV0bDOl+teB4grpz/8mwVh8DhAWh+B6Z4NnlBUVBIbsvlY/9QtZe9xWZ4
 NoKtLr+QwGd5i72pUIeA2Z8OGn2WWTyhIuUEB1WSYwyuxdbD4Em8uEO/+jXl/fEIqrLi
 zDog==
X-Gm-Message-State: AOJu0YxdFVC4c5fUYnoQDt2rNUKSYLGwCVIaRgpi0xVN/aseaZXWSc4N
 p5pzGxKsfjhf2JMUpAkK5EzqTg5MyC/q9pIyosiiwwS2gRdLzYRa00yy9af+uBaF8eKDtGaPxf9
 Tp8ag8QM=
X-Gm-Gg: AeBDieuYcbPuilyduhnD/lu0CtvmfAfgs9Ac5/q/r8aESsNll8WT/3s8U/JgsMmpgZZ
 N6QMqZnq5bAkiPzPB9twZir5jXpqiBPMq7sAk+5Q/v6fntF3PAE7eTF5CYu10brX7InLEaesjJs
 5tWzxl15XtNjICoYzfLeGOfaPyngZF2GiCc7LB1Rbun3mt3FnYz5BnKJdtl74xdjyMmo8x2fkNF
 ebmqv4rUDQW8NqTxCFYf8tjFgthc0n0p83KANyDxrqePqGEPahJY90NhCOB1clVD5dIastmqpQQ
 jUTVYxB9QlKpvwNWbWwk07hgXNZuYV/TiK55bgTTdHqtFfuHMERRmELBkbPtNxYum4pLlh+wmb9
 7oKd76xD1Bx76pfLaPsEBlyIYdePSAo55Cp3hsOSeZrGdlEkvIxk6JWqU9mGWs+/pe4AVF+tIX7
 yzJ3qEjhec72eu8WcUIGhQ/O5W+AjL5N1cu2G/H0G8
X-Received: by 2002:a17:903:1104:b0:2b4:6529:7b9f with SMTP id
 d9443c01a7336-2b5f9f37032mr427016705ad.26.1777211173108; 
 Sun, 26 Apr 2026 06:46:13 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 68/84] fpu: Export default_nan and pick_nan routines
Date: Sun, 26 Apr 2026 23:39:45 +1000
Message-ID: <20260426134002.865628-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 include/fpu/softfloat-parts.h  | 12 ++++++++++++
 fpu/softfloat-parts.c.inc      |  4 ++--
 fpu/softfloat-specialize.c.inc |  4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index f631c38c79..9f7ee34d6a 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -163,4 +163,16 @@ float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s);
 float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s);
 floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s);
 
+/*
+ * NaN handling
+ */
+
+FloatParts64 parts64_default_nan(float_status *status);
+FloatParts128 parts128_default_nan(float_status *status);
+
+FloatParts64 parts64_pick_nan(const FloatParts64 *, const FloatParts64 *,
+                              float_status *);
+FloatParts128 parts128_pick_nan(const FloatParts128 *, const FloatParts128 *,
+                                float_status *);
+
 #endif
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 642ad5dfb9..cdab18bf26 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -37,8 +37,8 @@ static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     return *a;
 }
 
-static FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
-                                    float_status *s)
+FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
+                             float_status *s)
 {
     bool have_snan = false;
     const FloatPartsN *ret;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2723bf5e61..485f082cf8 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -118,7 +118,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
 
-static FloatParts64 parts64_default_nan(float_status *status)
+FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
@@ -142,7 +142,7 @@ static FloatParts64 parts64_default_nan(float_status *status)
     };
 }
 
-static FloatParts128 parts128_default_nan(float_status *status)
+FloatParts128 parts128_default_nan(float_status *status)
 {
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
-- 
2.43.0



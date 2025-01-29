Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A1C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2z-0000ts-T9; Tue, 28 Jan 2025 20:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2x-0000sB-IE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2v-0003YA-SZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso112725335ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114752; x=1738719552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+pkMkDEsxn7pw+0PbiAtbEmIkmn9dqN7H6Z56c2eEc=;
 b=bbSjUq8af2rRjzdH1aETQgaI5NG7Lrn68nvedGo0iv3pWln4WTxkNK479i5o16bTe+
 ndrN20e0kiCzcTGbYnfRd4C5NNgK4ubq9Hn/pgHGk6RUDY3j5NoyZCer9V6iWYAWPRhH
 3/vt6dF1nLTnXnNy0mYeKKMYS5r2HTEKCz6Cj1Sg7jKp4kGLD2mEVMwz2DvXfndWW2S3
 +Er6YAiKjMjDBzJKKRCNl99LG6QEDuDisQNut/AYpbJ0fflFXV4TW16YzAYrWLoV7yTd
 9C6QFb5uZHkFh9xQm2q4LGSsiVWn93yZmQg9fxhLG/3DYYPu4RZzCpAJqcajZzddJBqm
 o0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114752; x=1738719552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+pkMkDEsxn7pw+0PbiAtbEmIkmn9dqN7H6Z56c2eEc=;
 b=QMpHv8keAd2+guDoPVZoH1hB7/65kaD0wj7d5yR1T+BzKGY9ANQMU0I1ew2ln586tG
 Mv62EhC/1g3LylbB0hcDWztvDVxH+KzCwQuKKBOvI5KsrEB5GCzab+GrfIrBpJI4Ws7h
 FwSJF17zHwJ6XULrveau5aBzF1nRKcX9MeEmMMcnSmm75gCl2u5hczjzuuRtH93M97Sa
 QhI2IXGF+0+oZK8FabRHyvGprAK/Npyw+bYyN9zt8ZGmlupSQwlRV+aDZSXo2gI4V2O5
 gq/XLOTBGGxtaexWTtksgkz32U+PobPmyEmhuGtGmsOg1E6BrSC4QLAPf2lj+RkjHNLk
 hRmg==
X-Gm-Message-State: AOJu0YyUtMqxKybahxWf/GqTgQV/xtTXGndL8HGZeFzO7M9t9QECZxH1
 8B0wkZ55pf56k8OJ6Cyte5n8uanQJOXeeVp0e0LuS1rLpEScBRWejc8rHmgpjSOOE8uVTpDsRXS
 8
X-Gm-Gg: ASbGncsV337MQ7KO7X5v416z/R2e5dLDBdXHlStKjk2kR+7G/mcCKroPflmuMuen6Lc
 cHosnx3tK6MdVpiv+rlU4jcT0rh4CaN2c1rnTR3r8oNFlGX50d5PXTm14xDpV0AIZYSxAVT5mF/
 H6ReBEFhqI2uUOGpBESt27pjto4utkHNDiJfAFK2qt+rbZ/BQY+7L68zphvy812v8L4ZrIJggpG
 vvM/Izke/6r+zCC+SLzvWPLqmDApcjIASOUfJeonFZynzTeaYfQLoJgoDN8drkxrJc11z6eDZfZ
 zHrsDH/2XJGTshIsyTkdplrPkNlEo9nzlw1pCxS5saml5Tbc4w==
X-Google-Smtp-Source: AGHT+IHqY2wM854R4WnaghZGZbiQ7JE0BMBxgYcTdbh6rxTWj2G9ePsZObQShSX6cX1HSq/Ls55zfg==
X-Received: by 2002:a17:902:ea12:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-21dd7d6e17bmr19882375ad.22.1738114752505; 
 Tue, 28 Jan 2025 17:39:12 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 20/34] target/arm: Use float*_maybe_ah_chs in sve_fcadd_*
Date: Tue, 28 Jan 2025 17:38:43 -0800
Message-ID: <20250129013857.135256-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The construction of neg_imag and neg_real were done to make it easy
to apply both in parallel with two simple logical operations.  This
changed with FPCR.AH, which is more complex than that.

Note that there was a naming issue with neg_imag and neg_real.
They were named backward, with neg_imag being non-zero for rot=1,
and vice versa.  This was combined with reversed usage within the
loop, so that the negation in the end turned out correct.

Using the rot variable introduced with fpcr_ah, it's easier to
match the pseudocode for the instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a2ff3b7f11..a1f7743221 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5226,8 +5226,6 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
     uint64_t *g = vg;
     bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    float16 neg_imag = float16_set_sign(0, rot);
-    float16 neg_real = float16_chs(neg_imag);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5243,11 +5241,10 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
             e2 = *(float16 *)(vn + H1_2(j));
             e3 = *(float16 *)(vm + H1_2(i));
 
-            if (neg_real && !(fpcr_ah && float16_is_any_nan(e1))) {
-                e1 ^= neg_real;
-            }
-            if (neg_imag && !(fpcr_ah && float16_is_any_nan(e3))) {
-                e3 ^= neg_imag;
+            if (rot) {
+                e3 = float16_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float16_maybe_ah_chs(e1, fpcr_ah);
             }
 
             if (likely((pg >> (i & 63)) & 1)) {
@@ -5267,8 +5264,6 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
     uint64_t *g = vg;
     bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    float32 neg_imag = float32_set_sign(0, rot);
-    float32 neg_real = float32_chs(neg_imag);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5284,11 +5279,10 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
             e2 = *(float32 *)(vn + H1_2(j));
             e3 = *(float32 *)(vm + H1_2(i));
 
-            if (neg_real && !(fpcr_ah && float32_is_any_nan(e1))) {
-                e1 ^= neg_real;
-            }
-            if (neg_imag && !(fpcr_ah && float32_is_any_nan(e3))) {
-                e3 ^= neg_imag;
+            if (rot) {
+                e3 = float32_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float32_maybe_ah_chs(e1, fpcr_ah);
             }
 
             if (likely((pg >> (i & 63)) & 1)) {
@@ -5308,8 +5302,6 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
     uint64_t *g = vg;
     bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    float64 neg_imag = float64_set_sign(0, rot);
-    float64 neg_real = float64_chs(neg_imag);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5325,11 +5317,10 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
             e2 = *(float64 *)(vn + H1_2(j));
             e3 = *(float64 *)(vm + H1_2(i));
 
-            if (neg_real && !(fpcr_ah && float64_is_any_nan(e1))) {
-                e1 ^= neg_real;
-            }
-            if (neg_imag && !(fpcr_ah && float64_is_any_nan(e3))) {
-                e3 ^= neg_imag;
+            if (rot) {
+                e3 = float64_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float64_maybe_ah_chs(e1, fpcr_ah);
             }
 
             if (likely((pg >> (i & 63)) & 1)) {
-- 
2.43.0



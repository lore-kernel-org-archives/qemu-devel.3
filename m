Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CECE6F07D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6woI-0007X5-Vp; Fri, 01 Nov 2024 14:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6woH-0007WM-4a
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:55:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6woF-0000Zb-Do
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:55:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so19287485e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730487345; x=1731092145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yDS9zlSiQ+PwoWX9xwv9cdCJ/JL5YOEq5jidXUjNycY=;
 b=kg1dqlL7w6b2GbwZUZOGuzBHKHiRlEdtMlCrouqdtJNifvWYG3DoLPL496FG1i6iAR
 QRfA+ANZsPwrRI+8+L5v6WcX+J/RN0ezb3xxn3/h0oWRem7Ih47OSeClM08YRUyl4gjH
 jzZK1kmC1K/3Y3Sj5x0w/a7vN9r7Vzb+Sjc8cW9F89XRS1VGNPNXhu6dNPYW93H5zjyU
 sm6nAOmdpD4WufCz1orao+7lVcgDPWdIMNVHvuDBnrEaNs0yyb1PntkcJIQCCXu7oVyW
 CdCzA/R77nKoU1pZUJxdQ4uodFi25Gm6S+i7PtfA+2FTgABHd5ZsNGodf5C3sfEE9o1/
 zKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730487345; x=1731092145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDS9zlSiQ+PwoWX9xwv9cdCJ/JL5YOEq5jidXUjNycY=;
 b=OVPB6KE3OQiAUXKkGImyozvOcqd2p/wamz5aVE5uFBZySfwfcWALmawxifUVlxJdeJ
 m+p5WH+yIRO0OGp7TwKcgeaxQof6Uj7KYEE7Vt8pE1MgL9RiBZeI5QrloBTjr21j4TvY
 I4lGzcv93pfrINWeBzaemc1C5HukZiehKFyJWRVSOYWotHsWE/PExtruCIbhAmnkUwtR
 +IFnKee/6ISFYt3S5KAUjJDYAv/QcienKr1uUmuwibJO99ElSXUN2RZTSetHx7n7RhOl
 oMjGWpiCBj30wPP0zYyvCgYHi+NXHcgaOK/S7yid0Zxd9iOjA9QVrW1Whxj4ARXyOSrv
 YTGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNDphB4jX3M6dEWkEbncXhsUqiolDWI++il30Dey2WNPxhmLIUBaCb1VN7P6sZt4szehU/lWneeiFE@nongnu.org
X-Gm-Message-State: AOJu0Yy+fYji1MbHCzK9ensRlRyvPVSJYTrd/2mFVasFO5vwoFoZeZQ6
 vNgNyUiUjdUeq6Qk37m+395YS7oxRzQhtrhPCOWW7t4zxf8ByPbQMgER3hI73os=
X-Google-Smtp-Source: AGHT+IEs1b+KGcp+q275Ooj5z7DC3Mkk9HnXFMAe3Mk3OL1/Cx16V5cL8RGqQj6tqOX7oDfmleNPHg==
X-Received: by 2002:a05:6000:d85:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-38061127842mr16292134f8f.17.1730487345321; 
 Fri, 01 Nov 2024 11:55:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e771sm5951292f8f.81.2024.11.01.11.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 11:55:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
Date: Fri,  1 Nov 2024 18:55:44 +0000
Message-Id: <20241101185544.2130972-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Our implementation of the indexed version of SVE SDOT/UDOT/USDOT got
the calculation of the inner loop terminator wrong.  Although we
correctly account for the element size when we calculate the
terminator for the first iteration:
   intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);
we don't do that when we move it forward after the first inner loop
completes.  The intention is that we process the vector in 128-bit
segments, which for a 64-bit element size should mean (1, 2), (3, 4),
(5, 6), etc.  This bug meant that we would iterate (1, 2), (3, 4, 5,
6), (7, 8, 9, 10) etc and apply the wrong indexed element to some of
the operations, and also index off the end of the vector.

You don't see this bug if the vector length is small enough that we
don't need to iterate the outer loop, i.e.  if it is only 128 bits,
or if it is the 64-bit special case from AA32/AA64 AdvSIMD.  If the
vector length is 256 bits then we calculate the right results for the
elements in the vector but do index off the end of the vector. Vector
lengths greater than 256 bits see wrong answers. The instructions
that produce 32-bit results behave correctly.

Fix the recalculation of 'segend' for subsequent iterations, and
restore a version of the comment that was lost in the refactor of
commit 7020ffd656a5 that explains why we only need to clamp segend to
opr_sz_n for the first iteration, not the later ones.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2595
Fixes: 7020ffd656a5 ("target/arm: Macroize helper_gvec_{s,u}dot_idx_{b,h}")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 22ddb968817..e825d501a22 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -836,6 +836,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
 {                                                                         \
     intptr_t i = 0, opr_sz = simd_oprsz(desc);                            \
     intptr_t opr_sz_n = opr_sz / sizeof(TYPED);                           \
+    /*                                                                    \
+     * Special case: opr_sz == 8 from AA64/AA32 advsimd means the         \
+     * first iteration might not be a full 16 byte segment. But           \
+     * for vector lengths beyond that this must be SVE and we know        \
+     * opr_sz is a multiple of 16, so we need not clamp segend            \
+     * to opr_sz_n when we advance it at the end of the loop.             \
+     */                                                                   \
     intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);                  \
     intptr_t index = simd_data(desc);                                     \
     TYPED *d = vd, *a = va;                                               \
@@ -853,7 +860,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
                     n[i * 4 + 2] * m2 +                                   \
                     n[i * 4 + 3] * m3);                                   \
         } while (++i < segend);                                           \
-        segend = i + 4;                                                   \
+        segend = i + (16 / sizeof(TYPED));                                \
     } while (i < opr_sz_n);                                               \
     clear_tail(d, opr_sz, simd_maxsz(desc));                              \
 }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9523CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwK-0004hc-AY; Thu, 19 Sep 2024 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwF-0004Tn-DC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwA-0000zn-Ht
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso7650085e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751468; x=1727356268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CW1Od08F73V7hTLa/GFIqEy9kNMCIX26bAK7DGcDQj4=;
 b=MvzsKQHnoF6PBzKpk7BUGGUwfAjY+p7whWg8zblxLAK6CvLz6Q34u8iOXzd7R7FRJy
 BVyFB0PwQXwaSgv93lhvOivg14+pRzbcwEY3KWHuxKFWLkdRzoQO9FhjIv2rSdhdnctn
 1wNvV6btZdDMQnmYd1YYxkC2B4ELyzhdRmWHhI0zGL1ns94CV2x3J/pKuBmOgVe/qNNk
 Y8x6vHFZjcWMPanZleVlD8oc7iR7ANohUDtgP4aP8tIb/lwSoHSchllpkDR48g9j9Nzk
 5n7aiumUcnr37Giyz1dynP+bJfKWpe+ssGW6Hno9W8UL+fHNO34N0SJYIOLPpqlg4hIC
 1lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751468; x=1727356268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CW1Od08F73V7hTLa/GFIqEy9kNMCIX26bAK7DGcDQj4=;
 b=KS53OKz0d7viqU+fnJgNbW2vT4qIFeSBaheq+e59xJPOagrSrpy6REF6gFVVOQ6boN
 hpA28p8pwZwzp39hNU/AbyVO3axDS7IorwurQYMEJSJyWU5keDx8+rC/sK/wYmkoUdIx
 AxdedFZrwqYagz7zr/SNXXNUzHUMUCwKNI53MzuDnZqtX4tBWnTmztZfdRNV5gKkBsrN
 sn4VhpaCopxmxRVAfom9UykbuSLV6kTnebGB4pA836AL+o8JxSPK2vJ7e4+lwKHAwBd/
 qSH8ATSHjYuK1zJfCBQG8HSJhnAQ6xSYLF7H5NrXUoX2l9rVwrLVnZD73I9bf0nC+P3a
 DyZw==
X-Gm-Message-State: AOJu0YwdZvTIkt+NGUTjsGac6LyYIB+RK2AT53MmOK4+OZNzzYmkGVSG
 /ycmgoRGCc4MSHPTPExWYBbm2xdxHgtmQmdcGuyCCQGm2mP7bvATWc/1wBUXlE4ALmBFx/1ycnM
 9
X-Google-Smtp-Source: AGHT+IH055lpNFjFOOqNMY4b9ZPTAXm21luQhOXdv+DgxH6afgLBOXdp6KcS6MsZt6O7ymFHud+SMQ==
X-Received: by 2002:a05:600c:3581:b0:42c:c8be:4217 with SMTP id
 5b1f17b1804b1-42cdb53192dmr178890215e9.11.1726751468328; 
 Thu, 19 Sep 2024 06:11:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/38] target/arm: Replace tcg_gen_dupi_vec with constants in
 gengvec.c
Date: Thu, 19 Sep 2024 14:10:29 +0100
Message-Id: <20240919131106.3362543-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Instead of copying a constant into a temporary with dupi,
use a vector constant directly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gengvec.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 56a1dc1f755..726a1383aed 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -297,10 +297,9 @@ void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
 static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_constant_vec_matching(d, vece, 1);
 
     tcg_gen_shri_vec(vece, t, a, sh - 1);
-    tcg_gen_dupi_vec(vece, ones, 1);
     tcg_gen_and_vec(vece, t, t, ones);
     tcg_gen_sari_vec(vece, d, a, sh);
     tcg_gen_add_vec(vece, d, d, t);
@@ -492,10 +491,9 @@ void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
 static void gen_urshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_constant_vec_matching(d, vece, 1);
 
     tcg_gen_shri_vec(vece, t, a, shift - 1);
-    tcg_gen_dupi_vec(vece, ones, 1);
     tcg_gen_and_vec(vece, t, t, ones);
     tcg_gen_shri_vec(vece, d, a, shift);
     tcg_gen_add_vec(vece, d, d, t);
@@ -685,9 +683,9 @@ static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
+    int64_t mi = MAKE_64BIT_MASK((8 << vece) - sh, sh);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, mi);
 
-    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
     tcg_gen_shri_vec(vece, t, a, sh);
     tcg_gen_and_vec(vece, d, d, m);
     tcg_gen_or_vec(vece, d, d, t);
@@ -773,10 +771,9 @@ static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, MAKE_64BIT_MASK(0, sh));
 
     tcg_gen_shli_vec(vece, t, a, sh);
-    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
     tcg_gen_and_vec(vece, d, d, m);
     tcg_gen_or_vec(vece, d, d, t);
 }
@@ -1044,14 +1041,13 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec rval = tcg_temp_new_vec_matching(dst);
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec msk, max;
+    TCGv_vec max;
 
     tcg_gen_neg_vec(vece, rsh, shift);
     if (vece == MO_8) {
         tcg_gen_mov_vec(lsh, shift);
     } else {
-        msk = tcg_temp_new_vec_matching(dst);
-        tcg_gen_dupi_vec(vece, msk, 0xff);
+        TCGv_vec msk = tcg_constant_vec_matching(dst, vece, 0xff);
         tcg_gen_and_vec(vece, lsh, shift, msk);
         tcg_gen_and_vec(vece, rsh, rsh, msk);
     }
@@ -1064,9 +1060,6 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     tcg_gen_shlv_vec(vece, lval, src, lsh);
     tcg_gen_shrv_vec(vece, rval, src, rsh);
 
-    max = tcg_temp_new_vec_matching(dst);
-    tcg_gen_dupi_vec(vece, max, 8 << vece);
-
     /*
      * The choice of LT (signed) and GEU (unsigned) are biased toward
      * the instructions of the x86_64 host.  For MO_8, the whole byte
@@ -1074,6 +1067,7 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
      * have already masked to a byte and so a signed compare works.
      * Other tcg hosts have a full set of comparisons and do not care.
      */
+    max = tcg_constant_vec_matching(dst, vece, 8 << vece);
     if (vece == MO_8) {
         tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
         tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
@@ -1170,6 +1164,7 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
+    TCGv_vec max, zero;
 
     /*
      * Rely on the TCG guarantee that out of range shifts produce
@@ -1180,15 +1175,15 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     if (vece == MO_8) {
         tcg_gen_mov_vec(lsh, shift);
     } else {
-        tcg_gen_dupi_vec(vece, tmp, 0xff);
-        tcg_gen_and_vec(vece, lsh, shift, tmp);
-        tcg_gen_and_vec(vece, rsh, rsh, tmp);
+        TCGv_vec msk = tcg_constant_vec_matching(dst, vece, 0xff);
+        tcg_gen_and_vec(vece, lsh, shift, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
     }
 
     /* Bound rsh so out of bound right shift gets -1.  */
-    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
-    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
-    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
+    max = tcg_constant_vec_matching(dst, vece, (8 << vece) - 1);
+    tcg_gen_umin_vec(vece, rsh, rsh, max);
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, max);
 
     tcg_gen_shlv_vec(vece, lval, src, lsh);
     tcg_gen_sarv_vec(vece, rval, src, rsh);
@@ -1197,12 +1192,12 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     tcg_gen_andc_vec(vece, lval, lval, tmp);
 
     /* Select between left and right shift.  */
+    zero = tcg_constant_vec_matching(dst, vece, 0);
     if (vece == MO_8) {
-        tcg_gen_dupi_vec(vece, tmp, 0);
-        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, rval, lval);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, zero, rval, lval);
     } else {
-        tcg_gen_dupi_vec(vece, tmp, 0x80);
-        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, lval, rval);
+        TCGv_vec sgn = tcg_constant_vec_matching(dst, vece, 0x80);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, sgn, lval, rval);
     }
 }
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E9AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjG5-0006y9-0h; Fri, 04 Jul 2025 12:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF5-0002RH-RM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF3-0006qD-Ot
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so821762f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646384; x=1752251184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3rc3urNrQq7/R3y5W7MW/LeqmxHvAPVulXlUwnI9qyk=;
 b=vUvcv41UFRdPFwLKTF1OGlOL13KkG7iXmL3zTHtEGQ5TfloEvJUvEH7vu7tGWxR2qQ
 vBMjFnA1R56LVPfVrDvXKpwdcyw4MPVeIEyv5one3F6A9ahFMBKKIUsKednsC3cCFqk6
 /VpSqf/ml/QOmZjWrC8ZkDTroJKv1SRTTGOaM2QyYKEOlIf0HYTBfanqj6e1uNg3D8vN
 ADSL08jY+8y9FKa9LW+teYygyHcJFQB/OOrFtbtxoeRp1KmIG4aQCKnggDwTJEZT5e8z
 t7MzAQJNn6blpMIs5Bj+G3EMhiKqGoSCcNeB5EbXOJrwkEQLnqwJRwr7bUcBRMxEN9L3
 hWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646384; x=1752251184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rc3urNrQq7/R3y5W7MW/LeqmxHvAPVulXlUwnI9qyk=;
 b=Tb8VKk6PoIwBu8njr5Olpj+zL6KfS0NOPmOL2aN3fqiqEiqbSjAm1S43Yh7dRK0cB+
 +O+Wlu4SCUJD2gDbZICtGjEvaalnDfPqPdx6HuLAtPHJPezUpZn8pSE508mLiIPYgLxt
 CN9gYPksoWnLAF5vaDxjDbXQj6FXnLqgn+ApL4+2jgO3KNGS3AM3/QtOMfwAtLaH/bS/
 koe+tD/FA8+v8JuQxkwoP5+8lYSsJ7vuhXEEvwJatmLhXwhCUCiEBQGuNzQ0gNZ0u5pT
 3S9CB1OCEnjD/YIoRmTQgpNgzgFk5NC1lEc7DzoCD2tfLCVtxhKZa1U5qvRyHdmg5FBs
 P6PA==
X-Gm-Message-State: AOJu0Yx2VcP3Xt9uOP3q+k3QIqNuj9aGzSARCmzBbKHK0zLgYxXF1eoJ
 Umo+Hk6um31GaOKD1YbMm8bXrjaonR4ZleoUFQeitce6putyCVo7fa5ejBWR8fVEc+BZkJ+Ov3v
 07Ejd
X-Gm-Gg: ASbGncv/09DJ8jZTrlIby7x+t81QXM5YxwDAEfF4eImZ2UBHMDcM87Cy9R0IEeGeayf
 tW7GX/gZ4I0R8EHkZGOYKV/sF8xIdDwMYO9roW0XDIDrVEEA94i0K5pfjwulaGoW1hw7QDQohAl
 fpcO2DLyRhT8a42rO9uqr68bG8MKCBuuNejgBegmsyGFVF22mczrhExGuz6vjSJpOS/S/xVf63K
 MfeeUDjUR9xxQO2tGISi5lm+oqqkKcCt2YPbn05BkXEeKuQfH1+GJsFimtDEGQS3cpTGViGPx6G
 XDtrkXg7PciA1tRQjxOWzyespCNRQnIgsBY/tF6mrXgoczl+0ZSieJPa0aR0Dqu8Oh2Q
X-Google-Smtp-Source: AGHT+IGK4Isyw5yqEMpOcKz83HWj3K6yCvmj333ut80y69A26nt9eVvQXDqJwBe+HrzzIWYevUr3kg==
X-Received: by 2002:a05:6000:4703:b0:3a5:2465:c0a4 with SMTP id
 ffacd0b85a97d-3b4964feceemr2676214f8f.20.1751646384211; 
 Fri, 04 Jul 2025 09:26:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 085/119] target/arm: Split out do_whilel from helper_sve_whilel
Date: Fri,  4 Jul 2025 17:24:25 +0100
Message-ID: <20250704162501.249138-86-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-74-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a62a647f3ae..741d04309c8 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4107,19 +4107,14 @@ static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
     return flags;
 }
 
-uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
+/* D must be cleared on entry. */
+static void do_whilel(ARMPredicateReg *d, uint64_t esz_mask,
+                      uint32_t count, uint32_t oprbits)
 {
-    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
-    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
-    uint64_t esz_mask = pred_esz_masks[esz];
-    ARMPredicateReg *d = vd;
-    intptr_t i, oprbits = oprsz * 8;
-
     tcg_debug_assert(count <= oprbits);
-
-    /* Begin with a zero predicate register.  */
-    memset(d, 0, sizeof(*d));
     if (count) {
+        uint32_t i;
+
         /* Set all of the requested bits.  */
         for (i = 0; i < count / 64; ++i) {
             d->p[i] = esz_mask;
@@ -4128,7 +4123,18 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
             d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
         }
     }
+}
 
+uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    memset(d, 0, sizeof(*d));
+    do_whilel(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, false);
 }
 
-- 
2.43.0



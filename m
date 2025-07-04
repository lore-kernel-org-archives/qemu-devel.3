Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F4AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUB-0002qF-HW; Fri, 04 Jul 2025 10:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMD-0004pS-F0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:47 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM4-0008AJ-Ev
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:40 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-610d87553b6so521572eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639131; x=1752243931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLxGKgXk0i72IBBIKzoJmYKjoJRmgOO7veT/d3JwQic=;
 b=ZsskRs2JeeCoTws/9vtWOyB3Q4ROGPXE2rBodtR1UrN9mD733DrI3X/53soPyW54uL
 3TTSfgKBIlLTKEGxZWsVvYLyrJOm5QhrdVg9nOaLOdkA1JmJKslbUeeMGPV2q4gPaN87
 Pfw8YG9ifab1a1mbve7wYOs/nHF4KUZckyTQ1khVNBJARqvvzV7wrGepfBkcL/cyoNRY
 DxNNy6e/oFpj58V1YFH+sCDC2A2LTjQZxLUD44U5DBUSyrw2NAG1RmOzukUcfbnvqXkH
 1jmnRMAcHi7rBTMd0IwadLNHfV7CznxFSNdLf3TKaiNTkN0GmVznhdKqO/fFoLk9IHct
 Bm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639131; x=1752243931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLxGKgXk0i72IBBIKzoJmYKjoJRmgOO7veT/d3JwQic=;
 b=wEVlDmG1c6CX4gDNnaYABjbne6QjPKXfn8W9R4zFxu9VqmJ8YD9s0uZkEg+nCsah/F
 JqaYCkVSXFWKJQOCPzBtpMEqK3axm5WeS0uODMIP2Gx0dn7Xpyx8X3W551P4LL31Xmlo
 rG5DKSafnTBvrcoV/dW/wI/wZKAQIW4jNjl71EpB8a/L4vgdmyAJlfKCOKMH2gxhjOpx
 B2jHeXym/70j84mbip6+IcU/+JdEeof4s5BSkWUz+C9sqd4KEoZVFyXJnk1qthB8KcHL
 LvcQLBchGBMA07keItILE/l7Nz0wbv2uOP8kLZWFzpykFY6KhzGzrNc2Q0KBZcj8xG7J
 zekQ==
X-Gm-Message-State: AOJu0YyOwtciKSsnE0OksfxXPCqLQ8H69s1ejDlQYKOBf0w6Sd777IqV
 UECT1a82PY8bLfqYj8FFXmIxpFmRE2ooa20OAceVQGxUNRC6QLZih69oNOCIQase2mrjbE+aJ8a
 CPpoWSL8=
X-Gm-Gg: ASbGncsqV0rqo6LYs2sH3wr9fU2IFuC2fL5Hryyh/wIsv27046qWKtEBC93pCBDXB7m
 pO4TkjQZsjqN4qg8UT6GLOlRIACPVl6Ss61IhPwFsEFq1Xeu6e977qF4Urq8OVuxTg+Sja7hiN5
 afK032e8k0WGZjxnRxIWj5LeoWq6Q2+s+cTbAxtAHfKV76tiX3wGYPNA4SjFyuqqiaEbok2i5eG
 BHa/k6ar86eiercn9dXmjw9lZT3z+mqZIer/vs1nNK+/OfcDbJ0FywwFK4FgcA7J7o0bP368Nf7
 je+g4cH5ssmxlnim/7viBTrdkDSmitujDmuMzhP0tYuNiriDg6Mh0nQBhGs0vx3Kx3TBWrXoV57
 ToHRMje8qyVAUW1BObxBHUhncE+TFoSQyCn4FilxQyHHKG2z6
X-Google-Smtp-Source: AGHT+IFWLiMqb36n7W69C9mVSUC3BMx487QaF9Z94zhZQnHJU0FnhDclxWxuTA6QSf2BGmrkh9OZXA==
X-Received: by 2002:a05:6808:2124:b0:401:e67c:b3be with SMTP id
 5614622812f47-40d04a2815fmr1945797b6e.4.1751639131031; 
 Fri, 04 Jul 2025 07:25:31 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 073/108] target/arm: Split out do_whilel from
 helper_sve_whilel
Date: Fri,  4 Jul 2025 08:20:36 -0600
Message-ID: <20250704142112.1018902-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a62a647f3a..741d04309c 100644
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



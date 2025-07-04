Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB01C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFa-0005kZ-8w; Fri, 04 Jul 2025 12:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF8-0002Xa-1x
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF5-0006qS-3B
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-454b1d0a115so3626745e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646385; x=1752251185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WifiZK9bF4RgBJmZsvME6bMbF5Ss9kw4tOUPKv9Vw+I=;
 b=szM43zckhdq5tLNhBEPx3M7u4anHBujfK/sT0ESqz+9yAuWQfcJ9Z1rbsaMc2/Qbv5
 cbixv34ad6qIieBCkryKcTDYRjSjsYI78OdvsLlDH6OlSlklQ619R51k+5G1wyyqFs3f
 QR1mNzsb/VFoGoR1dEX+QLofMrYcfu5suzSG59Fn5wl50m47ItFSbB0fy48ctTlmOdtq
 nRjG0YzPor/5YuC7bHcYJU24FtpBHjAHYQncSR8HJ6U4uugvupmmpM9SLytxm+tuDavX
 mPeDu+RPndUOa8fQSXNRDo+nsFyKEP3LcwzO/PNVfOyT7U0vt9QmIEq/9t3zJb39o3hi
 /zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646385; x=1752251185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WifiZK9bF4RgBJmZsvME6bMbF5Ss9kw4tOUPKv9Vw+I=;
 b=KTfFx6C3ZYKzSVQg8l71lKGSpgWPykPn0tp2Stq+ATnM5vYNn6P3985h/AifBd/QSr
 HyfDmzTayHh/HPiNyM6AaMoRgA3R9fk8mFJoLL9KtVNXl9A0/DWeQCD9AMlWWcloVs/U
 pFrzoK3Vw7lyfE/7RckILXtcRl/dnBJH6qQKsyThs0b5NaQl/Gs8iIXThLWtYKcR7PlW
 eYlnBk61kHYPSyRMfVb40FxwiZggqshSy/w4KICTGpohFsAo0kc+vVHFgu9aHlM/lyVc
 SDcSh8WQfpi7a++Yfa/tycseGncenJSJ2lBH2BNAwbOffH+BA/GY6s1rgorsL2L4L1VS
 HxGw==
X-Gm-Message-State: AOJu0YxEiFvMBO8LTeTCe8NVRPipuyUYE+z0zA0LS52wgh4uxaJmisGc
 4tLGJy6lbZyeuHtouk/kG7Ii09kEDmXZ2g9sQbOAPdAFf31bA5xftJ67RrUyXY9QREXvHhkqB9S
 Ns3To
X-Gm-Gg: ASbGncvN9D6/j4zOobdQpxrqkDXzkhL8zcRsjabEU5cxxQ2Cx2npIZ+9lo1Nd6tWq5O
 pjw96GgFhnrOroZ5RaH8qjLDWuQAHQfwt07+Wgh99MU1P+3eKq4siD3lnDvYQeOtftixIo/qy1R
 RCOVqiKSOmGTqfyOEauuoMRk6vYp5J9HVwXH8+tBZT0cJEIIdjjLYFZd0XAtEBx2dOVszSrIcI0
 Ij/y9uaDgYgafVbMLmpJ/VBHGS8HzSgl03UOBfjlJKdG0Qr3pa4C+HYqVlkX4dyUG7SnaybR8Ef
 qPlgfHTcUmrDKvIQ41T+/fS6CCiwbRTBzhlAZ8K8xnwZNAlggu+rXj/TdBQin6+c5xIU
X-Google-Smtp-Source: AGHT+IHX1vQ9E2pJa97e6E0odGNofit7W2nl8VXKmv9sVKEVfSMy+c7B77GYLxKJeRucEqjlxabSpQ==
X-Received: by 2002:a05:6000:41f8:b0:3a5:8a68:b81b with SMTP id
 ffacd0b85a97d-3b49703e3c0mr2452804f8f.44.1751646385097; 
 Fri, 04 Jul 2025 09:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 086/119] target/arm: Split out do_whileg from helper_sve_whileg
Date: Fri,  4 Jul 2025 17:24:26 +0100
Message-ID: <20250704162501.249138-87-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-75-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 39 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 741d04309c8..5e11e86e5e0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4138,34 +4138,35 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, false);
 }
 
-uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+/* D must be cleared on entry. */
+static void do_whileg(ARMPredicateReg *d, uint64_t esz_mask,
+                      uint32_t count, uint32_t oprbits)
 {
-    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
-    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
-    uint64_t esz_mask = pred_esz_masks[esz];
-    ARMPredicateReg *d = vd;
-    intptr_t i, invcount, oprbits = oprsz * 8;
-    uint64_t bits;
-
     tcg_debug_assert(count <= oprbits);
-
-    /* Begin with a zero predicate register.  */
-    memset(d, 0, sizeof(*d));
     if (count) {
-        /* Set all of the requested bits.  */
-        bits = esz_mask;
-        if (oprbits & 63) {
-            bits &= MAKE_64BIT_MASK(0, oprbits & 63);
-        }
+        uint32_t i, invcount = oprbits - count;
+        uint64_t bits = esz_mask & MAKE_64BIT_MASK(invcount & 63, 64);
 
-        invcount = oprbits - count;
-        for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
+        for (i = invcount / 64; i < oprbits / 64; ++i) {
             d->p[i] = bits;
             bits = esz_mask;
         }
-        d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
+        if (oprbits & 63) {
+            d->p[i] = bits & MAKE_64BIT_MASK(0, oprbits & 63);
+        }
     }
+}
 
+uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    memset(d, 0, sizeof(*d));
+    do_whileg(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, true);
 }
 
-- 
2.43.0



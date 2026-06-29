Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA34C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg3-00074J-PD; Mon, 29 Jun 2026 08:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfK-0006pY-7o
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfI-0007JI-J7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493a7bd27c2so11481885e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734439; x=1783339239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YqFJCC+KvfJZ0ogi6P9IwtcgoHH7mCUbydKh3+PQeEg=;
 b=Ax2tckQY8xq6biZfrqp+svkYfCOkwjbWdOdbtf0GLfhOFoidEJitjjBWigNHcAUnfs
 mNAe4eh1E3c0O52b35WtvUc6usMqnbrxuqTQ3LGNVbO84WcM+Ef4+mElVqsnDaKXd3gT
 PqS7eXac3p9hsg1vnU2Ikac3TS6XJXXFOS75QHwR3Xk5HN59Iq1K+KJBQnWadNkFphv3
 eZOrX9JOskOgAfVgSTkiT6+RqrKdWoHy9Cf0KopHE6wcdkFODuBoSbIJwBAiY3Q1T7Tt
 nv3D5JdaffCAUcI4kkRSF1j/chktTMAGf/mhIVnbCGIXJJXu8qsv83DkSU4aVxJtVx32
 ofZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734439; x=1783339239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YqFJCC+KvfJZ0ogi6P9IwtcgoHH7mCUbydKh3+PQeEg=;
 b=mT672glWN13MtsQ1vH3xejV/nplN4t2IiGy3AJw21zBoXsR2epPEy+Clrfj14q40Ax
 LQ+FzRXgf/iKu4L1bjBH1+gJoH8xi983D/TKbAg6blHn9JiI4gV4XW5K6ckIjq1WocrE
 m5z5s+t6+wxlyYbYiAMqfC+Q7CCmHIaxIJ4RAt1phv+3Jtwadb/uu0gtSfUiu2HUfSNY
 p/3+uvcDkzFAKGddf3vx8Zm4LlNIs55rYFOONK9ChNnDyf68HsvhNnt4FLcOQSuVSKDe
 Oc0FIwT4Pv1z23kyHPKwzBdZ/zfcM2mFEkh3Yn6gDuP1N+4T6RHX1xbZjcs83MWt+T9V
 Bu9Q==
X-Gm-Message-State: AOJu0YxDTjPj/f9w3JTw7Zi9sq5vSzQJ2SxzwhkrdEZlH3rSMkqVCRt5
 yo0uF4OlGxTzF9mjplYC0Snm4fNLoATNPpV2AFbjLVLHgU+UeNVx5R8WSLq9KZRJSTwm5OUqOyq
 FeNcR
X-Gm-Gg: AfdE7ckvEEYPq6MDDN0YDATeuotqWZsrw3JfXcfyoFJjyweZN7eY8jIl/aVXFM4YAUw
 zeWDRHRwgerPiV1uZj9kgcDeXR8MGhd0Rh4zM/UwNuNO033+lB9TLaISGVTPTNp4EM0ItjOM5YX
 aMMEB3toL5w65cxBHp9zTcIroUC2w52hjhoynZDqrGRkVhEtnx16sq9Vom6ABVaNJDQMNKI2LRE
 zMrqQFFx8Bfi2+JVOCi7thktXEK4lIYxjY0UsrO0ealQVrdG/TyHrPNjK9kDsTotl3/6kr0ChVT
 o61mTS3wz8mOcpRqfvFNf6hVsbQwUl+AZE9OMjNApiHwKXTeyW3WbQkgBbVmuLjvg39cADs75ky
 hr+tRzpBrvu4UGGGnEUDiQXE997iprx1NVL1jjxtMr262qymS4JrfDjj1OO3fgJbnLGYWlgfEcI
 SA829nUPfqbEOBPQ7g0yaFCGnebEO/XwiScfr0Qr7VzUZhUVGNkAYUSqMK4xbL6rJ/mfdKYEDmU
 AQ62vhawhB7wvYuMqanBQ==
X-Received: by 2002:a05:600c:34d2:b0:492:432b:d78b with SMTP id
 5b1f17b1804b1-493b71a983dmr8734325e9.15.1782734438833; 
 Mon, 29 Jun 2026 05:00:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/54] target/arm: Generalize sve_compact_[sd]
Date: Mon, 29 Jun 2026 12:59:42 +0100
Message-ID: <20260629120032.1645265-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Implement with a DO_COMPACT macro and general purpose
predicate handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260618040718.572950-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 51 +++++++++++++++----------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 2517362189..9b45b0d331 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3637,39 +3637,30 @@ DO_TRN(sve2_trn_q, Int128, )
 #undef DO_UZP
 #undef DO_TRN
 
-void HELPER(sve_compact_s)(void *vd, void *vn, void *vg, uint32_t desc)
-{
-    intptr_t i, j, opr_sz = simd_oprsz(desc) / 4;
-    uint32_t *d = vd, *n = vn;
-    uint8_t *pg = vg;
-
-    for (i = j = 0; i < opr_sz; i++) {
-        if (pg[H1(i / 2)] & (i & 1 ? 0x10 : 0x01)) {
-            d[H4(j)] = n[H4(i)];
-            j++;
-        }
-    }
-    for (; j < opr_sz; j++) {
-        d[H4(j)] = 0;
-    }
+#define DO_COMPACT(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
+{                                                                     \
+    intptr_t j = 0, oprsz = simd_oprsz(desc);                         \
+    for (intptr_t i = 0; i < oprsz; ) {                               \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
+        do {                                                          \
+            if (pg & 1) {                                             \
+                *(TYPE *)(vd + H(j)) = *(TYPE *)(vn + H(i));          \
+                j += sizeof(TYPE);                                    \
+            }                                                         \
+            i += sizeof(TYPE);                                        \
+            pg >>= sizeof(TYPE);                                      \
+        } while (i & 15);                                             \
+    }                                                                 \
+    for (; j < oprsz; j += sizeof(TYPE)) {                            \
+        *(TYPE *)(vd + H(j)) = 0;                                     \
+    }                                                                 \
 }
 
-void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
-{
-    intptr_t i, j, opr_sz = simd_oprsz(desc) / 8;
-    uint64_t *d = vd, *n = vn;
-    uint8_t *pg = vg;
+DO_COMPACT(sve_compact_s, uint32_t, H1_4)
+DO_COMPACT(sve_compact_d, uint64_t, H1_8)
 
-    for (i = j = 0; i < opr_sz; i++) {
-        if (pg[H1(i)] & 1) {
-            d[j] = n[i];
-            j++;
-        }
-    }
-    for (; j < opr_sz; j++) {
-        d[j] = 0;
-    }
-}
+#undef DO_COMPACT
 
 #define DO_EXPAND(NAME, TYPE, H)                                      \
 void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
-- 
2.43.0



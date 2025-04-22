Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F12C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIe-0002as-Fb; Tue, 22 Apr 2025 15:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIW-0002WG-RP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006DG-8N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so4197950a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350120; x=1745954920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR/Buc0tAK+dwpT4/jUuGVtANFEG+DcYq0rCH3hrxCg=;
 b=rc1yAO/FT/sL39Ru2U3JutPt3ep7xC3LeJZRwW/p+FsdigYfLsw+RMH4jQnctPuxTv
 IZiGIYe2yt1MtoAIoFWUIyAzZEmA+ItwwxaTiletgoCq2WeojkWTvxaRzvXCTlUqM64B
 beS/FEaclyuZeFGqlMcMBomNWd7HrJBP7NUylYe/7GJ/yL1cHCoonnvPs41c0y8RXQoj
 8dfPDHf6diue0HA1hXE4xLGmWcCYj/HFqgAtfhXE1fPDYOq5QWY5WwouLYIEb12O0B1J
 uPv6hiu6B4LXWVR1m8Oi4IeffmbLuHkzVjir9mu4in5cXcrTJkrR9ruh4kyxpk1sfAX6
 BwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350120; x=1745954920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oR/Buc0tAK+dwpT4/jUuGVtANFEG+DcYq0rCH3hrxCg=;
 b=W8IY3uLOlafhi1fWssu0Ln/u5H2j1jouh4txPyhjOQQp4Bh7Rkkwjgz5if65KVtilM
 kT0bT7RRrVpQXwQIhX1jx6HH9M3jmkDndQNIuv6Qi0TH0TwO5pjoI2XhMS3Q3pkmP8ZL
 liWeDJQUbUQ9qR5kD6mP6uMCyT+T0OJl9IokRd4Pds7mMmhjuU02KAqQWJPw8rW5dDeo
 oXxjj9nP8W1v49I24sTXfrUK+HvkYJf1mwT7UBxAHTpGhOspq9+adHRLPDhU4cPpAexH
 IIVY1lc2lSzlpg2zQ43F08bnqOdFqBORV1HoIcCOTQx/VnlVKovOcyG56aDHdkJ7wwcz
 VVGw==
X-Gm-Message-State: AOJu0YwK7z01iUXXxGPkn1L1Jrix8EbnFCwmLM02esr9scNyVru49wX1
 hkD4SGuu7nOTWh+6Mn0nIlhrsTOEkJV1JrH2KF3ujYY2npwKoynzNlHjweVQ/y9g0P1opMYUiUO
 g
X-Gm-Gg: ASbGncu3nm/YOU4PeUHFbySXTgHYoeNNIKFJg7NDowAid8UWMmrlQhWi3WHazAFLUFx
 jYjjdd2/KViwjDIwe0L0h1pTwH5cJeRgPHuwOBLP/UOoRiKM18JZdAatreJ1dnnXj6GvLpdRXLh
 ara8Y5z4gnk6heBZNNV+TAsPRp0/UHB/DPBcDvL5ckstxh/drJhP6MBC65+J3Y1LlUCFe88l9qz
 VR4cnb8OCgZp/EJygM+xNiUIdtiuuhwY17Sv9nzM3G4zMuzRyH3Svq1Rkr1xfkHfBSutnpIeNX/
 6p4dYy619HfGmqqeaV4b3hv5sUk2zAkjWuukJk49iELUApXdMOBamjivOGbzTfanYgx1oMh2U9E
 =
X-Google-Smtp-Source: AGHT+IEZrCzU6UJBCk/bM/WFbETYZWgd52yv1ydrjphKnTWBTQVI0h8AUgZx3MkJElGl87elnOB+4w==
X-Received: by 2002:a17:90b:1f90:b0:2fe:b937:2a51 with SMTP id
 98e67ed59e1d1-3087bccb23fmr25611431a91.33.1745350119559; 
 Tue, 22 Apr 2025 12:28:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 029/147] accel/tcg: Perform aligned atomic reads in
 translator_ld
Date: Tue, 22 Apr 2025 12:26:18 -0700
Message-ID: <20250422192819.302784-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Perform aligned atomic reads in translator_ld, if possible.
According to

https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.com/

this is required for RISC-V Ziccif.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ef1538b4fc..157be33bf6 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -265,12 +265,14 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
 
     if (likely(((base ^ last) & TARGET_PAGE_MASK) == 0)) {
         /* Entire read is from the first page. */
-        memcpy(dest, host + (pc - base), len);
-        return true;
+        goto do_read;
     }
 
     if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) == 0)) {
-        /* Read begins on the first page and extends to the second. */
+        /*
+         * Read begins on the first page and extends to the second.
+         * The unaligned read is never atomic.
+         */
         size_t len0 = -(pc | TARGET_PAGE_MASK);
         memcpy(dest, host + (pc - base), len0);
         pc += len0;
@@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
         host = db->host_addr[1];
     }
 
-    memcpy(dest, host + (pc - base), len);
+ do_read:
+    /*
+     * Assume aligned reads should be atomic, if possible.
+     * We're not in a position to jump out with EXCP_ATOMIC.
+     */
+    host += pc - base;
+    switch (len) {
+    case 2:
+        if (QEMU_IS_ALIGNED(pc, 2)) {
+            uint16_t t = qatomic_read((uint16_t *)host);
+            stw_he_p(dest, t);
+            return true;
+        }
+        break;
+    case 4:
+        if (QEMU_IS_ALIGNED(pc, 4)) {
+            uint32_t t = qatomic_read((uint32_t *)host);
+            stl_he_p(dest, t);
+            return true;
+        }
+        break;
+#ifdef CONFIG_ATOMIC64
+    case 8:
+        if (QEMU_IS_ALIGNED(pc, 8)) {
+            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
+            stq_he_p(dest, t);
+            return true;
+        }
+        break;
+#endif
+    }
+    /* Unaligned or partial read from the second page is not atomic. */
+    memcpy(dest, host, len);
     return true;
 }
 
-- 
2.43.0



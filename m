Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2482CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubG-0005kc-80; Fri, 03 May 2024 11:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubD-0005jR-0Y
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ub9-000756-SV
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f30f69a958so7969946b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749198; x=1715353998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=CjlG5xoRzjjZWNrf2vCCTMOh51jL3lWR8laZu8PMJMtwHTVdcyXcQ0pbkGsJB0C2pD
 IAj1rFj5xK0g3P9Uk41yj+JBUhIlAmFHZp1JVvu2Y7Q7i3LHc+HfuCJy2vQz9kSx2Y88
 jBkX0A9Q1taleDZDg8g0t8+Kuw4iqyztZpG+DKH43Ls4fAZymHHd0D9CXzoIz/dePJCf
 vjbT428k2IwuWjeb6cYJkj35DggeVV6v8P+EVVU0sr+cUI4aGYLZvW4abblMLoPqwI1Q
 sz83SnT4lCZ+66zbHZwo3eb7VWUx6appS/NBDVsfiTvb792nXNKGEti9OPJtIcxSo3n5
 fl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749198; x=1715353998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=MvMqges6aYRH1glEqP0f6eSYjlKy2urP4AbHl3jtuKtToLc91/XmGbFNh98Y6mJ/RI
 uyGun/57BxSC24TQYZ01QFPuI5/7oGwK0MLylfpIc34bkm23tyvXF5pZEVmiU8BFtH1K
 tefRJ7HxWnQKYbcQgI4Oz1Mib7I7wcD0DJ00wLEYv/k82tSQ6Hu3HwO3c98SNjauNoz3
 kGxt2a+uyT4dLbkOmc0QMuPMepEUrb+BXc/hTYKhvfsLUio/dypbYvkkr2yhr+5Fqi8B
 Xfk2qQ5sw0a2DpH2S7T+pJfS0aOik3DtvUDOX1FPQZqAPq7EYCt9G5EpruZXxLHxWNyW
 cfIg==
X-Gm-Message-State: AOJu0YyZd3RFJL4JotVqjt9qbD20jHIpqRLBVAxCToG/t4r+ZTnB1xOY
 oaCCfu3fINDHzhaB2O+DbUyMYR86I/FJY7cdnE1s7KDwcDpXt1Rm5XK9aiSd8UxjRCloq18GG61
 Q
X-Google-Smtp-Source: AGHT+IE1PqNWcIKl+viC8skosn3Kk/f+crV18Vg7p3lgi3UTlE1/w6zLl+chAmxrwpnTZs/4Dmp+Hw==
X-Received: by 2002:a17:903:110e:b0:1e4:342a:b351 with SMTP id
 n14-20020a170903110e00b001e4342ab351mr3211195plh.4.1714749198205; 
 Fri, 03 May 2024 08:13:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 02/10] util/bufferiszero: Remove AVX512 variant
Date: Fri,  3 May 2024 08:13:06 -0700
Message-Id: <20240503151314.336357-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Alexander Monakov <amonakov@ispras.ru>

Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
routines are invoked much more rarely in normal use when most buffers
are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
frequency and voltage transition periods during which the CPU operates
at reduced performance, as described in
https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html

Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-4-amonakov@ispras.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index f5a3634f9a..641d5f9b9e 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -64,7 +64,7 @@ buffer_zero_int(const void *buf, size_t len)
     }
 }
 
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
 /* Note that each of these vectorized functions require len >= 64.  */
@@ -128,41 +128,12 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
-#ifdef CONFIG_AVX512F_OPT
-static bool __attribute__((target("avx512f")))
-buffer_zero_avx512(const void *buf, size_t len)
-{
-    /* Begin with an unaligned head of 64 bytes.  */
-    __m512i t = _mm512_loadu_si512(buf);
-    __m512i *p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
-    __m512i *e = (__m512i *)(((uintptr_t)buf + len) & -64);
-
-    /* Loop over 64-byte aligned blocks of 256.  */
-    while (p <= e) {
-        __builtin_prefetch(p);
-        if (unlikely(_mm512_test_epi64_mask(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    t |= _mm512_loadu_si512(buf + len - 4 * 64);
-    t |= _mm512_loadu_si512(buf + len - 3 * 64);
-    t |= _mm512_loadu_si512(buf + len - 2 * 64);
-    t |= _mm512_loadu_si512(buf + len - 1 * 64);
-
-    return !_mm512_test_epi64_mask(t, t);
-
-}
-#endif /* CONFIG_AVX512F_OPT */
-
 /*
  * Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
  * too old to support CONFIG_AVX2_OPT.
  */
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
+#if defined(CONFIG_AVX2_OPT)
 # define INIT_USED     0
 # define INIT_LENGTH   0
 # define INIT_ACCEL    buffer_zero_int
@@ -188,9 +159,6 @@ select_accel_cpuinfo(unsigned info)
         unsigned len;
         bool (*fn)(const void *, size_t);
     } all[] = {
-#ifdef CONFIG_AVX512F_OPT
-        { CPUINFO_AVX512F, 256, buffer_zero_avx512 },
-#endif
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    128, buffer_zero_avx2 },
 #endif
@@ -208,7 +176,7 @@ select_accel_cpuinfo(unsigned info)
     return 0;
 }
 
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
+#if defined(CONFIG_AVX2_OPT)
 static void __attribute__((constructor)) init_accel(void)
 {
     used_accel = select_accel_cpuinfo(cpuinfo_init());
-- 
2.34.1



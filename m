Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14372CD129A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8O-00028z-RH; Mon, 08 Apr 2024 13:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8N-00027f-A1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:19 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8K-0003kP-Ey
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso3423963a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598615; x=1713203415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=O7hoOfOHJzJ5w+NZJNE4a0zu1/UrchsYwKQwKvRqlPq7XfKEssfOwEYfbCMAzaqxxZ
 y8iLiCXSr4Owdzr89LIYfoCp3phhzH7VZM1Hzg3U/3pke0/18xm2ArepAWY+lytW/bqB
 eHNLzaArlFYl2zdMTcAo5xtJcBYfanLt41UwAM5fWtpFtHjSBOz6ibQB6nfHRFOvuYsL
 lUhakiS+JhPDyeX/hr3+lge7fgHwNk48+YqCG6gvuNZt0DkOelILuicu8lF/ZKzE8Ekq
 fW1KGSElI5XOWFSR9VBsnHysa41BhIwPRParpqUQP2TfH0mPqtKO+N8dSWbYIcFDpeGp
 Sxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598615; x=1713203415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=wEEEBNIGVB9JsUs1EYrckd8C5LuWQDRKKfy5GktrZoAraK1xx1Sd/aFXKzD16onw+p
 5jRVMfACgeN5y2GD3Yaqjnf8MKMVxHfhm7CqvHEzujyG7ar1JYM548IFF7T/+60uumh8
 GDeoX7QItOazazX6bydjFXgsCBzCLzLcaQDfbq0BeAbE4pPxSuZMm3Lo0wR9SliEl9/F
 mnoVXcrtxjLjHU1xkNfxJWVlFjLgl9sJhMDx8W9s0Q9oVIhFrYIqbBeauWewKsinB7sU
 rGQTEPUzLyOpMfetzmhfbz+Zvi9IWQ8kMR23k2IFgB1MwFzueSeQH4O1XsYX9ZEsz9RP
 VDog==
X-Gm-Message-State: AOJu0Yx7JtOLBL0VPXQBt2jBaI3/cXqS9NJmMKIDP6hu2su2fPBNqfq0
 wx7WtdtP3a5jNGqUQspuCSMt5ZIkn3uaftbOhe3e9uJNjzbKKz0BiwtYXEl0QsomrzbsbauwY3a
 p
X-Google-Smtp-Source: AGHT+IHtBXRVI2LDVITXAMNNEh01NC++BzpjWVGop56nqwx2flUXzgu8qpgqo+KsLuauBf1LZM2zhg==
X-Received: by 2002:a17:90a:de89:b0:2a2:c2c4:9d28 with SMTP id
 n9-20020a17090ade8900b002a2c2c49d28mr7184354pjv.8.1712598615073; 
 Mon, 08 Apr 2024 10:50:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 29/35] util/bufferiszero: Remove AVX512 variant
Date: Mon,  8 Apr 2024 07:49:23 -1000
Message-Id: <20240408174929.862917-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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



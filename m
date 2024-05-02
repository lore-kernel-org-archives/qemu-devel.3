Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF90C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ziv-0001No-19; Thu, 02 May 2024 12:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zid-0000ws-RM
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zib-0005wV-O9
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso7521374b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668936; x=1715273736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SGeZv/4hYREHrq3/2i2w291gTT4MaAZ/Mhj+P3eA68=;
 b=g6UbyFPX9QAkgvfquYp7rJutN74RjLnOVpZoz1Ssw/4X9AFbp57Crz4y8E/z7jaKaz
 WG5GXtOnFldbAH0zf0dr21W9Ac26oa5wOEesIR9moQ76uZGyvQZoD19Ny9eSL9pdEIUy
 q7p18AQAZRzpCMoNsuvEwlB/e6VNjQPe/v09GWILIVJ2rimp7f1deACm8oPLrX42Be6Z
 TXTRAqbcbcHsQKWMJjoXdG17hBDJH8+oqaMlB4FvqflYFOD6t79TIiKLQKo3iPi0AjOQ
 W/W6qUIc9aI7t1KIEDQQhTl6BAsZku2VShuKE3elNJQGfnER/X4+VNE3Hg9WPH41b2l0
 z0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668936; x=1715273736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SGeZv/4hYREHrq3/2i2w291gTT4MaAZ/Mhj+P3eA68=;
 b=IIdm+w4XV10H4R/+UR6Jvj5w1X+T7TdXDS11x0JS2miDTLWJj2bV2iQomaEABEIetW
 1+/v6R8W2+xgmIVNsxEF6sZhNlsWfNpSIdInLplbf1Dcgrp8hwS+mFnYcHQ7gDO16Iw3
 nuCuUuU9Dur7RGmE5OuTHmibZUfEiW2wLOGjbBFcw1Qep6Oi949hQ879zLlPZN+NSyD7
 Nu2yivfDH2ZXKbC0o45di6i6Z+m0fP9IokbrHYc/vgom/vwXivYhYukkFNta6S/w/6sL
 gwmr6/WoXATeg5xJaJjQ3nXA0JNmP7O9ebFo3679qJMH9nprj4z7fX6dyrX+C0zuX5FX
 GEmw==
X-Gm-Message-State: AOJu0Yw564DE9JxsGQpEgWahtxrNtCdpBM8I8oz09eQNIWclAom9WqJZ
 2gY3/8BdevI6ZJfspO7f1ePytQj4xae1zH4Ks4u6tiPMdkSRW3Bm1nvGoSeIpX1JdX4XefkVe4m
 G
X-Google-Smtp-Source: AGHT+IHUioA94ZfHRxrQPpAAzlvoQ+Ve2+Pd5+gPNd88Eccf2Ig8YRtedZh2LRSL8/S6PXKaIIwTAg==
X-Received: by 2002:a05:6a00:1904:b0:6ed:d5f5:869 with SMTP id
 y4-20020a056a00190400b006edd5f50869mr153919pfi.3.1714668935866; 
 Thu, 02 May 2024 09:55:35 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 7/7] target/sparc: Split out do_ms16b
Date: Thu,  2 May 2024 09:55:28 -0700
Message-Id: <20240502165528.244004-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The unit operation for fmul8x16 and friends is described in the
manual as "MS16b".  Split that out for clarity.  Improve rounding
with an unconditional addition of 0.5 as a fixed-point integer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/vis_helper.c | 78 ++++++++++++---------------------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 14c665cad6..e15c6bb34e 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -44,6 +44,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 
 #if HOST_BIG_ENDIAN
 #define VIS_B64(n) b[7 - (n)]
+#define VIS_SB64(n) sb[7 - (n)]
 #define VIS_W64(n) w[3 - (n)]
 #define VIS_SW64(n) sw[3 - (n)]
 #define VIS_L64(n) l[1 - (n)]
@@ -51,6 +52,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 #define VIS_W32(n) w[1 - (n)]
 #else
 #define VIS_B64(n) b[n]
+#define VIS_SB64(n) sb[n]
 #define VIS_W64(n) w[n]
 #define VIS_SW64(n) sw[n]
 #define VIS_L64(n) l[n]
@@ -60,6 +62,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 
 typedef union {
     uint8_t b[8];
+    int8_t sb[8];
     uint16_t w[4];
     int16_t sw[4];
     uint32_t l[2];
@@ -95,27 +98,23 @@ uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
     return d.ll;
 }
 
+static inline int do_ms16b(int x, int y)
+{
+    return ((x * y) + 0x80) >> 8;
+}
+
 uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
 {
     VIS64 d;
     VIS32 s;
-    uint32_t tmp;
 
     s.l = src1;
     d.ll = src2;
 
-#define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B32(r);       \
-    if ((tmp & 0xff) > 0x7f) {                                  \
-        tmp += 0x100;                                           \
-    }                                                           \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_B32(0), d.VIS_SW64(0));
+    d.VIS_W64(1) = do_ms16b(s.VIS_B32(1), d.VIS_SW64(1));
+    d.VIS_W64(2) = do_ms16b(s.VIS_B32(2), d.VIS_SW64(2));
+    d.VIS_W64(3) = do_ms16b(s.VIS_B32(3), d.VIS_SW64(3));
 
     return d.ll;
 }
@@ -124,25 +123,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 {
     VIS32 s;
     VIS64 d;
-    uint32_t tmp;
 
     s.l = src1;
     d.ll = 0;
 
-#define PMUL(r)                                \
-    do {                                       \
-        tmp = src2 * (int32_t)s.VIS_B32(r);    \
-        if ((tmp & 0xff) > 0x7f) {             \
-            tmp += 0x100;                      \
-        }                                      \
-        d.VIS_W64(r) = tmp >> 8;               \
-    } while (0)
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_B32(0), src2);
+    d.VIS_W64(1) = do_ms16b(s.VIS_B32(1), src2);
+    d.VIS_W64(2) = do_ms16b(s.VIS_B32(2), src2);
+    d.VIS_W64(3) = do_ms16b(s.VIS_B32(3), src2);
 
     return d.ll;
 }
@@ -150,23 +138,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
 {
     VIS64 s, d;
-    uint32_t tmp;
 
     s.ll = src1;
     d.ll = src2;
 
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 8);       \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_SB64(1), d.VIS_SW64(0));
+    d.VIS_W64(1) = do_ms16b(s.VIS_SB64(3), d.VIS_SW64(1));
+    d.VIS_W64(2) = do_ms16b(s.VIS_SB64(5), d.VIS_SW64(2));
+    d.VIS_W64(3) = do_ms16b(s.VIS_SB64(7), d.VIS_SW64(3));
 
     return d.ll;
 }
@@ -174,23 +153,14 @@ uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
 uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
 {
     VIS64 s, d;
-    uint32_t tmp;
 
     s.ll = src1;
     d.ll = src2;
 
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_B64(0), d.VIS_SW64(0));
+    d.VIS_W64(1) = do_ms16b(s.VIS_B64(2), d.VIS_SW64(1));
+    d.VIS_W64(2) = do_ms16b(s.VIS_B64(4), d.VIS_SW64(2));
+    d.VIS_W64(3) = do_ms16b(s.VIS_B64(6), d.VIS_SW64(3));
 
     return d.ll;
 }
-- 
2.34.1



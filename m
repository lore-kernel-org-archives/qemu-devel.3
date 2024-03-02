Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC9EC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjT-0002PK-OU; Sat, 02 Mar 2024 00:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjQ-0002Og-5e
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:20 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjO-0007Ur-Cw
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:19 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5a11b231ec5so88110eaf.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356577; x=1709961377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjGfHOCM0m98uQm7bh3lP0qVKdngpnelcO2QCf7+7gs=;
 b=SFf7Ax3B32T/vYHXXk/SSkgpkl7W5+6V0L6XHlw0csaB5P32Xk5JSonglmkfcW7JaL
 q3RWB9sY18hehFe2qW7yxY5Af92DFko0f4DYbqccz8PCxdmpPnzriY5r8t+560vtkPNv
 x3Ks0eMtljeadOyL1EJMseKEo8jwYrqmkJhhHIv0yvoG1GSC6JGbctrdXjl0nCCPKPdN
 Moi5PVW9LvRlslVKxiKlYdVgYF89llKBIEiI7+GYpLe4ROls4WpKc43y9PDgl6CZbA01
 NFhOSbk1CVIYED3Z3MT5gLwiESfylwlUQOotjpx/NqVuPpA4VIfi9ffsujkvnKvAuLDa
 kEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356577; x=1709961377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjGfHOCM0m98uQm7bh3lP0qVKdngpnelcO2QCf7+7gs=;
 b=TriE+3n8VgNColcXcJZOPnR1JEplpsKmdzn0E/d+ini0xMwsghA4J6hmTUQFH9R8HT
 gbaHU1D0E0IR6DpcJqDZl1JEBJNqIWECt5GkIWc6DPOSbG4nljYiP7oKv7vUI0p5x4fX
 uINRtLEOH2yVMkX2SZoCrwr7J/RFHe8B8QDDT+PkLqzAjYXeUSA5PJAcQi2Pch9GFkcF
 Pu/VBI77zV8Y76ZUhLvgiDMt9qrvnJ65aA3XlDf3iMp5rMawMS2w8Rzwf1fFBu7fde7b
 +Xp1F0iJ8y2e9IqGqv2gEEB6gVx1judqp15J9WpgoT1w2YoBMrgaN4znIUwWI8CtTpOf
 SWCA==
X-Gm-Message-State: AOJu0YwuedgEsSEHObOySQakMT5B/6DLgB+27bxkHSHSxU5PJUkoNFcC
 GTJXq54UJJBtMPIb46RQE0eJt9OYn0aTIE0u2OVfZlIznCbkyxNpxbIEl0aUDGfRODjBQDabt81
 u
X-Google-Smtp-Source: AGHT+IH8ALO4HuoiPMu3nDWR/iYAOcNscg21uTm3lUpq2+S+m3fxbz6TOVdhvQTvA2kLeZX1CgxGzA==
X-Received: by 2002:a05:6808:1481:b0:3c1:5f09:b16f with SMTP id
 e1-20020a056808148100b003c15f09b16fmr4558767oiw.26.1709356577259; 
 Fri, 01 Mar 2024 21:16:17 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 07/41] target/sparc: Split out do_ms16b
Date: Fri,  1 Mar 2024 19:15:27 -1000
Message-Id: <20240302051601.53649-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/sparc/vis_helper.c | 76 +++++++++++++--------------------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 89eea05ddb..e15c6bb34e 100644
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
@@ -124,23 +123,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 {
     VIS32 s;
     VIS64 d;
-    uint32_t tmp;
 
     s.l = src1;
     d.ll = 0;
 
-#define PMUL(r)                                \
-    tmp = src2 * (int32_t)s.VIS_B64(r);        \
-    if ((tmp & 0xff) > 0x7f) {                 \
-        tmp += 0x100;                          \
-    }                                          \
-    d.VIS_W64(r) = tmp >> 8;
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
@@ -148,23 +138,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
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
@@ -172,23 +153,14 @@ uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
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



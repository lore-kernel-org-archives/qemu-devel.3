Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A8EC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHk9-00033K-J3; Sat, 02 Mar 2024 00:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk8-00032l-IA
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:04 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk6-0007c6-E8
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:04 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so2547359a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356621; x=1709961421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUmk5rTWWmBgxpLSOi0NCSmwuLbfYTbr59H0j9IrMyY=;
 b=ln2mdldYlVa8eOYYFN32sLL+cA4zlkyoHproV09TxHDzaKudOBVZorsdrLHhGu8OuV
 BOH1fogUaBE6Xz9NTapB9np/L5g1tIz8EkzqEyvaRypdEZcfpMQoCJh5rTq3oa2YUNuh
 m39qfuzSCeL37yAb1ZBhmFHM4Cim6IsUGLCQhf07YnzCU5EYrfL/P0Tobd+W8fD4LD1n
 TZ2KMpLDjMpRdX0y59rPG/lmv8Cbeo13T/D1cD3WJnRU8HfyRwhTi0NZRkprzuDN73/h
 vc/1lScr9xGm/Ecjgrrqh/JMe0KBRadDnheLRq5tXGFtx682ysIp+Vq84Es+GAg9+0VO
 3bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356621; x=1709961421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUmk5rTWWmBgxpLSOi0NCSmwuLbfYTbr59H0j9IrMyY=;
 b=JxWr4ZcC2ISJwquVE6wIJNzoUV9G5sjzzKqMbABq1ksWb2uWxq7ZuAXjTP9jlG+Ltu
 UW3K4tS8zaw2nlXs1dXX/tHq40Vk9Y76tmysGbvS4+dObwcMea6cVb/+jUZnm0dc+oHe
 +vJKUorSzrI7PdxGXBH2ZpnH6Lo7ne2ZtmL5dNDCCjcA+CW1/0tjFAY48UANu0omAr56
 mHD5Cz4xSmp+M0DTe0k2mDo7MH5HqUJRxTJkbGdxn0M0LYbHxpwojK/YgbiPHeRgzIDy
 qp1BycXCccIPuL0pVaEbfsgYEkhewFBO1pWsdra4EbPLlsgOHmhkoOWpVpTUUIdzYV7R
 HumQ==
X-Gm-Message-State: AOJu0YxghtlmKeLC14HQkxOrmtT0gfckki8ihfJneGQW+U/La8IYlCT8
 6x7cF019CMqZgGrDXQWJodltnUypT7W0MELAi4zgyeNcVWvQqsFtiPI8qN7YhwIibuVuNrrzAgx
 Z
X-Google-Smtp-Source: AGHT+IEt5bxjJZUil7dgemUHFdgjT4lTF/DALP1tfqdVuW1aTLK2Nj1O5q0IT1tor2Wo6dauhIHP/w==
X-Received: by 2002:a17:90b:23d0:b0:29a:c21c:674d with SMTP id
 md16-20020a17090b23d000b0029ac21c674dmr3387509pjb.14.1709356620903; 
 Fri, 01 Mar 2024 21:17:00 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:17:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 36/41] target/sparc: Implement VIS4 comparisons
Date: Fri,  1 Mar 2024 19:15:56 -1000
Message-Id: <20240302051601.53649-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

VIS4 completes the set, adding missing signed 8-bit ops
and missing unsigned 16 and 32-bit ops.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  12 +--
 target/sparc/translate.c  |  12 +++
 target/sparc/vis_helper.c | 170 +++++++++++++++++++++++++++++---------
 target/sparc/insns.decode |   6 ++
 4 files changed, 153 insertions(+), 47 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 9b642fd74b..15ed0a6af3 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -117,19 +117,19 @@ DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fslas16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fslas32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-#define VIS_CMPHELPER(name)                                              \
+#define VIS_CMPHELPER(name)                                  \
+    DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
+                       i64, i64, i64)                        \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
-                       i64, i64, i64)                                    \
+                       i64, i64, i64)                        \
     DEF_HELPER_FLAGS_2(f##name##32, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)
 VIS_CMPHELPER(cmpgt)
 VIS_CMPHELPER(cmpeq)
 VIS_CMPHELPER(cmple)
 VIS_CMPHELPER(cmpne)
-DEF_HELPER_FLAGS_2(fcmpeq8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fcmpne8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fcmpule8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fcmpugt8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+VIS_CMPHELPER(cmpugt)
+VIS_CMPHELPER(cmpule)
 DEF_HELPER_FLAGS_2(xmulx, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(xmulxhi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cb5d8c27ae..5f1982cecc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -68,15 +68,21 @@
 # define gen_helper_fcmpeq8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpgt8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmple8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmple16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmple32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpule8             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpule16            ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpule32            ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpugt8             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpugt16            ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpugt32            ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
@@ -5112,16 +5118,22 @@ TRANS(FPCMPLE16, VIS1, do_rdd, a, gen_helper_fcmple16)
 TRANS(FPCMPNE16, VIS1, do_rdd, a, gen_helper_fcmpne16)
 TRANS(FPCMPGT16, VIS1, do_rdd, a, gen_helper_fcmpgt16)
 TRANS(FPCMPEQ16, VIS1, do_rdd, a, gen_helper_fcmpeq16)
+TRANS(FPCMPULE16, VIS4, do_rdd, a, gen_helper_fcmpule16)
+TRANS(FPCMPUGT16, VIS4, do_rdd, a, gen_helper_fcmpugt16)
 
 TRANS(FPCMPLE32, VIS1, do_rdd, a, gen_helper_fcmple32)
 TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
 TRANS(FPCMPGT32, VIS1, do_rdd, a, gen_helper_fcmpgt32)
 TRANS(FPCMPEQ32, VIS1, do_rdd, a, gen_helper_fcmpeq32)
+TRANS(FPCMPULE32, VIS4, do_rdd, a, gen_helper_fcmpule32)
+TRANS(FPCMPUGT32, VIS4, do_rdd, a, gen_helper_fcmpugt32)
 
 TRANS(FPCMPEQ8, VIS3B, do_rdd, a, gen_helper_fcmpeq8)
 TRANS(FPCMPNE8, VIS3B, do_rdd, a, gen_helper_fcmpne8)
 TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
+TRANS(FPCMPLE8, VIS4, do_rdd, a, gen_helper_fcmple8)
+TRANS(FPCMPGT8, VIS4, do_rdd, a, gen_helper_fcmpgt8)
 
 TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
 TRANS(XMULX, VIS3, do_rdd, a, gen_helper_xmulx)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 387acb3855..c05f3e7b30 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -49,6 +49,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 #define VIS_W64(n) w[3 - (n)]
 #define VIS_SW64(n) sw[3 - (n)]
 #define VIS_L64(n) l[1 - (n)]
+#define VIS_SL64(n) sl[1 - (n)]
 #define VIS_B32(n) b[3 - (n)]
 #define VIS_W32(n) w[1 - (n)]
 #else
@@ -57,6 +58,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 #define VIS_W64(n) w[n]
 #define VIS_SW64(n) sw[n]
 #define VIS_L64(n) l[n]
+#define VIS_SL64(n) sl[n]
 #define VIS_B32(n) b[n]
 #define VIS_W32(n) w[n]
 #endif
@@ -67,6 +69,7 @@ typedef union {
     uint16_t w[4];
     int16_t sw[4];
     uint32_t l[2];
+    int32_t sl[2];
     uint64_t ll;
     float64 d;
 } VIS64;
@@ -181,47 +184,6 @@ uint64_t helper_fexpand(uint32_t src2)
     return d.ll;
 }
 
-#define VIS_CMPHELPER(name, F)                                    \
-    uint64_t name##16(uint64_t src1, uint64_t src2)               \
-    {                                                             \
-        VIS64 s, d;                                               \
-                                                                  \
-        s.ll = src1;                                              \
-        d.ll = src2;                                              \
-                                                                  \
-        d.VIS_W64(0) = F(s.VIS_W64(0), d.VIS_W64(0)) ? 1 : 0;     \
-        d.VIS_W64(0) |= F(s.VIS_W64(1), d.VIS_W64(1)) ? 2 : 0;    \
-        d.VIS_W64(0) |= F(s.VIS_W64(2), d.VIS_W64(2)) ? 4 : 0;    \
-        d.VIS_W64(0) |= F(s.VIS_W64(3), d.VIS_W64(3)) ? 8 : 0;    \
-        d.VIS_W64(1) = d.VIS_W64(2) = d.VIS_W64(3) = 0;           \
-                                                                  \
-        return d.ll;                                              \
-    }                                                             \
-                                                                  \
-    uint64_t name##32(uint64_t src1, uint64_t src2)               \
-    {                                                             \
-        VIS64 s, d;                                               \
-                                                                  \
-        s.ll = src1;                                              \
-        d.ll = src2;                                              \
-                                                                  \
-        d.VIS_L64(0) = F(s.VIS_L64(0), d.VIS_L64(0)) ? 1 : 0;     \
-        d.VIS_L64(0) |= F(s.VIS_L64(1), d.VIS_L64(1)) ? 2 : 0;    \
-        d.VIS_L64(1) = 0;                                         \
-                                                                  \
-        return d.ll;                                              \
-    }
-
-#define FCMPGT(a, b) ((a) > (b))
-#define FCMPEQ(a, b) ((a) == (b))
-#define FCMPLE(a, b) ((a) <= (b))
-#define FCMPNE(a, b) ((a) != (b))
-
-VIS_CMPHELPER(helper_fcmpgt, FCMPGT)
-VIS_CMPHELPER(helper_fcmpeq, FCMPEQ)
-VIS_CMPHELPER(helper_fcmple, FCMPLE)
-VIS_CMPHELPER(helper_fcmpne, FCMPNE)
-
 uint64_t helper_fcmpeq8(uint64_t src1, uint64_t src2)
 {
     uint64_t a = src1 ^ src2;
@@ -243,6 +205,25 @@ uint64_t helper_fcmpne8(uint64_t src1, uint64_t src2)
     return helper_fcmpeq8(src1, src2) ^ 0xff;
 }
 
+uint64_t helper_fcmple8(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 8; ++i) {
+        r |= (s1.VIS_SB64(i) <= s2.VIS_SB64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpgt8(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmple8(src1, src2) ^ 0xff;
+}
+
 uint64_t helper_fcmpule8(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
@@ -262,6 +243,113 @@ uint64_t helper_fcmpugt8(uint64_t src1, uint64_t src2)
     return helper_fcmpule8(src1, src2) ^ 0xff;
 }
 
+uint64_t helper_fcmpeq16(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    uint64_t m = 0x7fff7fff7fff7fffULL;
+    uint64_t c = ~(((a & m) + m) | a | m);
+
+    /* a...............b...............c...............d............... */
+    c |= c << 15;
+    /* ab..............bc..............cd..............d............... */
+    c |= c << 30;
+    /* abcd............bcd.............cd..............d............... */
+    return c >> 60;
+}
+
+uint64_t helper_fcmpne16(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpeq16(src1, src2) ^ 0xf;
+}
+
+uint64_t helper_fcmple16(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 4; ++i) {
+        r |= (s1.VIS_SW64(i) <= s2.VIS_SW64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpgt16(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmple16(src1, src2) ^ 0xf;
+}
+
+uint64_t helper_fcmpule16(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 4; ++i) {
+        r |= (s1.VIS_W64(i) <= s2.VIS_W64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpugt16(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpule16(src1, src2) ^ 0xf;
+}
+
+uint64_t helper_fcmpeq32(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    return ((uint32_t)a == 0) | (a >> 32 ? 0 : 2);
+}
+
+uint64_t helper_fcmpne32(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    return ((uint32_t)a != 0) | (a >> 32 ? 2 : 0);
+}
+
+uint64_t helper_fcmple32(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 2; ++i) {
+        r |= (s1.VIS_SL64(i) <= s2.VIS_SL64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpgt32(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmple32(src1, src2) ^ 3;
+}
+
+uint64_t helper_fcmpule32(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 2; ++i) {
+        r |= (s1.VIS_L64(i) <= s2.VIS_L64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpugt32(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpule32(src1, src2) ^ 3;
+}
+
 uint64_t helper_pdist(uint64_t sum, uint64_t src1, uint64_t src2)
 {
     int i;
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 52bacff126..3ff8708304 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -425,6 +425,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPCMPUGT8   10 ..... 110110 ..... 1 0010 1000 .....    @r_d_d
     FPCMPEQ8    10 ..... 110110 ..... 1 0010 0010 .....    @r_d_d
     FPCMPNE8    10 ..... 110110 ..... 1 0010 1010 .....    @r_d_d
+    FPCMPLE8    10 ..... 110110 ..... 0 0011 0100 .....    @r_d_d
+    FPCMPGT8    10 ..... 110110 ..... 0 0011 1100 .....    @r_d_d
+    FPCMPULE16  10 ..... 110110 ..... 1 0010 1110 .....    @r_d_d
+    FPCMPUGT16  10 ..... 110110 ..... 1 0010 1011 .....    @r_d_d
+    FPCMPULE32  10 ..... 110110 ..... 1 0010 1111 .....    @r_d_d
+    FPCMPUGT32  10 ..... 110110 ..... 1 0010 1100 .....    @r_d_d
 
     FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @d_r_d
     FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @d_r_r
-- 
2.34.1



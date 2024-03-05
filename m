Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1B7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXpN-0008JN-OU; Tue, 05 Mar 2024 11:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhXpL-0008Ih-Fu
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:39:39 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhXpJ-00009u-9D
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:39:39 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2995fa850ddso5244065a91.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709656774; x=1710261574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uGDboQdgatOQ/3wEUF/IZCqMlV4D3UaeoJrF99IpsFg=;
 b=nNuA1jmd9kjeGc+qE4GBLfxD3almI6GnTlDY6MVh+swbnF5u9dEfflS1MS6TXIG0Sy
 YBzF2nB0TuL29Gn3Tjxk/Were3paDBG+D2SJWN/XPyTCxUsREYY/ZhHxHJkkkE0C8ySU
 CCIx9UtMtehLFTjzdVzi63Vsne/6REqWqs9fPtISUI1vhX7sP6XhC+bQBNlYCNO4vOtX
 XA0ZedXzAn2SXzsYAVz0BelzqNqXYpcH6r8GrNBJkwCJDdi9O3yyoEXAVkBdeCc73waT
 56GbdHVGOpfZUq6NbOBx438BkPQr9A7fovPUY1YdcvXOvsiPXXWKDsORisl9E5zNP+Yg
 Tw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709656774; x=1710261574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uGDboQdgatOQ/3wEUF/IZCqMlV4D3UaeoJrF99IpsFg=;
 b=PbvaYnNEXqwFoLDfB3wUg3kG1VJ9wqfMnhTMv6vHlo0f7c+Hu8AFxgM8JCDCjxAfD2
 44qgTrg/HemaKVdOxiDet5/5bwNT6biMyGjHbkMaIuw2wBu+HeaCOTcIHM7pZSTjsngA
 KePWsVpfy7oykPfnoCeyxfu2o5qRvpt8ujrwYJQGHwtxka1FzJD8qyj8DsnyAA6flQ3m
 eZwAQfG3lGXI4rIksKDLekGso6uspMk/AfsuXi5jV4bZQ8o10noGKzP2IEEJrIf7pYMy
 qfs9FFuP3bxMUhjWelmnNmmi7ficf2Z4z7QGr+3rrTZP9riSR29o8ThAeHDRyo9VjIdK
 UucQ==
X-Gm-Message-State: AOJu0YyaHnxKm1tAW7JwV+ouaTCkW3eJ1B/yoPwAqZLKg4TNrAtHLTBi
 gZPEpkDwAtIBrrp+VOHiD15Z5WsjL3V/DYWJNb8d57MOoP+o7iJxurnif46IlNfZqlSXwp73N8w
 M
X-Google-Smtp-Source: AGHT+IEfE5i/TraOMlGbGApwTbJESf3Qf2CD1uuUqhzXWni88eZC9jSrNZNyWOThvjlx4LuzUA39WA==
X-Received: by 2002:a17:90a:c397:b0:29b:789:28d0 with SMTP id
 h23-20020a17090ac39700b0029b078928d0mr3800125pjt.22.1709656774566; 
 Tue, 05 Mar 2024 08:39:34 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a17090a714a00b0029ab460019asm9703542pjs.1.2024.03.05.08.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:39:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2] target/arm: Fix 32-bit SMOPA
Date: Tue,  5 Mar 2024 06:39:31 -1000
Message-Id: <20240305163931.242795-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

While the 8-bit input elements are sequential in the input vector,
the 32-bit output elements are not sequential in the output matrix.
Do not attempt to compute 2 32-bit outputs at the same time.

Cc: qemu-stable@nongnu.org
Fixes: 23a5e3859f5 ("target/arm: Implement SME integer outer product")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2083
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

v2: Fixed endian issue; double-checked on s390x.

---
 target/arm/tcg/sme_helper.c       | 77 ++++++++++++++++++-------------
 tests/tcg/aarch64/sme-smopa-1.c   | 47 +++++++++++++++++++
 tests/tcg/aarch64/sme-smopa-2.c   | 54 ++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 4 files changed, 147 insertions(+), 33 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-smopa-1.c
 create mode 100644 tests/tcg/aarch64/sme-smopa-2.c

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 904bfdac43..e2e0575039 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1083,11 +1083,32 @@ void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
-typedef uint64_t IMOPFn(uint64_t, uint64_t, uint64_t, uint8_t, bool);
+typedef uint32_t IMOPFn32(uint32_t, uint32_t, uint32_t, uint8_t, bool);
+static inline void do_imopa_s(uint32_t *za, uint32_t *zn, uint32_t *zm,
+                              uint8_t *pn, uint8_t *pm,
+                              uint32_t desc, IMOPFn32 *fn)
+{
+    intptr_t row, col, oprsz = simd_oprsz(desc) / 4;
+    bool neg = simd_data(desc);
 
-static inline void do_imopa(uint64_t *za, uint64_t *zn, uint64_t *zm,
-                            uint8_t *pn, uint8_t *pm,
-                            uint32_t desc, IMOPFn *fn)
+    for (row = 0; row < oprsz; ++row) {
+        uint8_t pa = (pn[H1(row >> 1)] >> ((row & 1) * 4)) & 0xf;
+        uint32_t *za_row = &za[tile_vslice_index(row)];
+        uint32_t n = zn[H4(row)];
+
+        for (col = 0; col < oprsz; ++col) {
+            uint8_t pb = pm[H1(col >> 1)] >> ((col & 1) * 4);
+            uint32_t *a = &za_row[H4(col)];
+
+            *a = fn(n, zm[H4(col)], *a, pa & pb, neg);
+        }
+    }
+}
+
+typedef uint64_t IMOPFn64(uint64_t, uint64_t, uint64_t, uint8_t, bool);
+static inline void do_imopa_d(uint64_t *za, uint64_t *zn, uint64_t *zm,
+                              uint8_t *pn, uint8_t *pm,
+                              uint32_t desc, IMOPFn64 *fn)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
     bool neg = simd_data(desc);
@@ -1107,25 +1128,16 @@ static inline void do_imopa(uint64_t *za, uint64_t *zn, uint64_t *zm,
 }
 
 #define DEF_IMOP_32(NAME, NTYPE, MTYPE) \
-static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
+static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
 {                                                                           \
-    uint32_t sum0 = 0, sum1 = 0;                                            \
+    uint32_t sum = 0;                                                       \
     /* Apply P to N as a mask, making the inactive elements 0. */           \
     n &= expand_pred_b(p);                                                  \
-    sum0 += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                              \
-    sum0 += (NTYPE)(n >> 8) * (MTYPE)(m >> 8);                              \
-    sum0 += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                            \
-    sum0 += (NTYPE)(n >> 24) * (MTYPE)(m >> 24);                            \
-    sum1 += (NTYPE)(n >> 32) * (MTYPE)(m >> 32);                            \
-    sum1 += (NTYPE)(n >> 40) * (MTYPE)(m >> 40);                            \
-    sum1 += (NTYPE)(n >> 48) * (MTYPE)(m >> 48);                            \
-    sum1 += (NTYPE)(n >> 56) * (MTYPE)(m >> 56);                            \
-    if (neg) {                                                              \
-        sum0 = (uint32_t)a - sum0, sum1 = (uint32_t)(a >> 32) - sum1;       \
-    } else {                                                                \
-        sum0 = (uint32_t)a + sum0, sum1 = (uint32_t)(a >> 32) + sum1;       \
-    }                                                                       \
-    return ((uint64_t)sum1 << 32) | sum0;                                   \
+    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
+    sum += (NTYPE)(n >> 8) * (MTYPE)(m >> 8);                               \
+    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
+    sum += (NTYPE)(n >> 24) * (MTYPE)(m >> 24);                             \
+    return neg ? a - sum : a + sum;                                         \
 }
 
 #define DEF_IMOP_64(NAME, NTYPE, MTYPE) \
@@ -1151,16 +1163,17 @@ DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
 DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
 DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
 
-#define DEF_IMOPH(NAME) \
-    void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, void *vpn,      \
-                            void *vpm, uint32_t desc)                        \
-    { do_imopa(vza, vzn, vzm, vpn, vpm, desc, NAME); }
+#define DEF_IMOPH(NAME, S) \
+    void HELPER(sme_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
+                                  void *vpn, void *vpm, uint32_t desc)      \
+    { do_imopa_##S(vza, vzn, vzm, vpn, vpm, desc, NAME##_##S); }
 
-DEF_IMOPH(smopa_s)
-DEF_IMOPH(umopa_s)
-DEF_IMOPH(sumopa_s)
-DEF_IMOPH(usmopa_s)
-DEF_IMOPH(smopa_d)
-DEF_IMOPH(umopa_d)
-DEF_IMOPH(sumopa_d)
-DEF_IMOPH(usmopa_d)
+DEF_IMOPH(smopa, s)
+DEF_IMOPH(umopa, s)
+DEF_IMOPH(sumopa, s)
+DEF_IMOPH(usmopa, s)
+
+DEF_IMOPH(smopa, d)
+DEF_IMOPH(umopa, d)
+DEF_IMOPH(sumopa, d)
+DEF_IMOPH(usmopa, d)
diff --git a/tests/tcg/aarch64/sme-smopa-1.c b/tests/tcg/aarch64/sme-smopa-1.c
new file mode 100644
index 0000000000..c62d5e0007
--- /dev/null
+++ b/tests/tcg/aarch64/sme-smopa-1.c
@@ -0,0 +1,47 @@
+#include <stdio.h>
+#include <string.h>
+
+int main()
+{
+    static const int cmp[4][4] = {
+        {  110,  134,  158,  182 },
+        {  390,  478,  566,  654 },
+        {  670,  822,  974, 1126 },
+        {  950, 1166, 1382, 1598 }
+    };
+    int dst[4][4];
+    int *tmp = &dst[0][0];
+
+    asm volatile(
+        ".arch armv8-r+sme\n\t"
+        "smstart\n\t"
+        "index z0.b, #0, #1\n\t"
+        "movprfx z1, z0\n\t"
+        "add z1.b, z1.b, #16\n\t"
+        "ptrue p0.b\n\t"
+        "smopa za0.s, p0/m, p0/m, z0.b, z1.b\n\t"
+        "ptrue p0.s, vl4\n\t"
+        "mov w12, #0\n\t"
+        "st1w { za0h.s[w12, #0] }, p0, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w { za0h.s[w12, #1] }, p0, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w { za0h.s[w12, #2] }, p0, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w { za0h.s[w12, #3] }, p0, [%0]\n\t"
+        "smstop"
+        : "+r"(tmp) : : "memory");
+
+    if (memcmp(cmp, dst, sizeof(dst)) == 0) {
+        return 0;
+    }
+
+    /* See above for correct results. */
+    for (int i = 0; i < 4; ++i) {
+        for (int j = 0; j < 4; ++j) {
+            printf("%6d", dst[i][j]);
+        }
+        printf("\n");
+    }
+    return 1;
+}
diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smopa-2.c
new file mode 100644
index 0000000000..c9f48c3bfc
--- /dev/null
+++ b/tests/tcg/aarch64/sme-smopa-2.c
@@ -0,0 +1,54 @@
+#include <stdio.h>
+#include <string.h>
+
+int main()
+{
+    static const long cmp[4][4] = {
+        {  110,  134,  158,  182 },
+        {  390,  478,  566,  654 },
+        {  670,  822,  974, 1126 },
+        {  950, 1166, 1382, 1598 }
+    };
+    long dst[4][4];
+    long *tmp = &dst[0][0];
+    long svl;
+
+    /* Validate that we have a wide enough vector for 4 elements. */
+    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=r"(svl));
+    if (svl < 32) {
+        return 0;
+    }
+
+    asm volatile(
+        "smstart\n\t"
+        "index z0.h, #0, #1\n\t"
+        "movprfx z1, z0\n\t"
+        "add z1.h, z1.h, #16\n\t"
+        "ptrue p0.b\n\t"
+        "smopa za0.d, p0/m, p0/m, z0.h, z1.h\n\t"
+        "ptrue p0.d, vl4\n\t"
+        "mov w12, #0\n\t"
+        "st1d { za0h.d[w12, #0] }, p0, [%0]\n\t"
+        "add %0, %0, #32\n\t"
+        "st1d { za0h.d[w12, #1] }, p0, [%0]\n\t"
+        "mov w12, #2\n\t"
+        "add %0, %0, #32\n\t"
+        "st1d { za0h.d[w12, #0] }, p0, [%0]\n\t"
+        "add %0, %0, #32\n\t"
+        "st1d { za0h.d[w12, #1] }, p0, [%0]\n\t"
+        "smstop"
+        : "+r"(tmp) : : "memory");
+
+    if (memcmp(cmp, dst, sizeof(dst)) == 0) {
+        return 0;
+    }
+
+    /* See above for correct results. */
+    for (int i = 0; i < 4; ++i) {
+        for (int j = 0; j < 4; ++j) {
+            printf("%6ld", dst[i][j]);
+        }
+        printf("\n");
+    }
+    return 1;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index cded1d01fc..ea3e232e65 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -67,7 +67,7 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1
+AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
 endif
 
 # System Registers Tests
-- 
2.34.1



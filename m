Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDBCD62618
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vish3-0002e9-K5; Thu, 22 Jan 2026 06:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vish1-0002dY-E2
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgz-0001cK-Q9
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so7377425e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769080656; x=1769685456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yfiGijTp32x1GznNHzbs/aN0TdplM4Fbe5gzLRZo9fM=;
 b=vyjqFWOLC6MuI900kSaTP+joSWxuRXkIVyOwndmauJuH6b2d7lClZy6dGMxqNaldDX
 qnuu0yauTgJdLQFV2msyOsWrxykJGg6JlwZR4EoLGrqB47p82aiML3tUNt4OLkgFvGcL
 GhuRR6iLasoOZrZFaxl7HqJhP2TUwRWoXwhH1aNfkcakWetCPiw5wpkKG0tHeVXbEtzN
 5bGSDMFQtLaQ4Y61/eR+YAEwAIFZA+Fr/x0cxs7ovToQN401GabyCf6bLVXvuu9vctv4
 u6Pc5LuH4czeWEyAfi85t+O+Q3mBAO4TQnTTD9+KhNYTgbqTxFPoiP+qmAyPGKb6kZLt
 nqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769080656; x=1769685456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yfiGijTp32x1GznNHzbs/aN0TdplM4Fbe5gzLRZo9fM=;
 b=cQP2PMGah0iViomHlNLpNt/tGlxIlKO4oxnEL3SV+03f5oaqfR4CMKIS6JWRsRl4Id
 kEZ5yvdD2cuY8flV2eJH/1nUvIwHiwn4Uscd2LOh5My0742PxkQfX7BoBjjs2Rfa9b8z
 O/5BvE8fmJ631Fx+c10dxZkFLZxARcjXBX5R3CGvAUX0yRSK+EM4m/XpCodd2LZi4niv
 bOOhi2G66aU+ok3Y9kJMfgVMA0fCAOE+XOnlFw6tChXE8cO3zdjyYzjKSrVlS63qQ8Ur
 XX95BHotu491EVuqJ8/MI4NmbkIkrNsMv/syZkCXcqhApeMA3Fa/B0gEb/lriihBMz8J
 fSCg==
X-Gm-Message-State: AOJu0Yy2QeAAAaD/t5KTaKFAAfXJyLyKzxzB3kiU3WMFF3GoT7Klu/9q
 EoQGQV0FrqU63PXPETEwM/UlmVhpMYMpqpA6CdBppQrNVMlLx4yLGXKaue738FkCFbU/lQSkCUx
 CnXk6BWI=
X-Gm-Gg: AZuq6aKPnQqPyKwYuTBqx+JEiRLXcx4E7sEPwFnN7eQon9wEMlMt0bmC2ANKl4E8I9+
 wBaQ77kI9N8bHVVW28mUP1xFH5wGLX/vDLQ9To5fH12cmvfN47VxHPp68y6whktM5PDtok5aBAK
 vMmOPW5IFF7pRc1/+k+oz7ixdFCMZTcLJvfNlkhJmDpN8eVs3udzilt3BHGqOuYOg5gbhoavWKL
 /04Acwbnkje9j6zSgLoebqnusCfM8WSny6rhjPaw1NAJNDpSIg+zifidQSlJgZMU/MSnZ9ikWui
 HAPQEccKCEX2GcOXKobtHte5B18ny5rOJn9+/4YtDKSx4cxg0O3Wby/miVslMgAL9Pdo+AHmFZV
 BqDCFfKHFgniCr/W3NcsDXiZH4t3Y3efoVbe10PueZvltxguzyAkUseBuLAvVTtUtkdoYhZSFzW
 JUeM8W1DO0VD6XplfXO8OK1FqJgfJggya6Br7yNHSocdjlKmDf7ROvjotREYFLpRUeuxypxH0=
X-Received: by 2002:a05:600c:8816:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-4801e8fd2e5mr189330885e9.2.1769080655732; 
 Thu, 22 Jan 2026 03:17:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c598b9sm48532555e9.18.2026.01.22.03.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 03:17:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/37] target/ppc: Simplify endianness handling in Altivec
 opcodes
Date: Thu, 22 Jan 2026 12:16:39 +0100
Message-ID: <20260122111639.32346-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111639.32346-1-philmd@linaro.org>
References: <20260122111639.32346-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Access the memory in big-endian order,
swap bytes when MSR.LE is set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251126202200.23100-22-philmd@linaro.org>
---
 target/ppc/mem_helper.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 6ab71a6fcb4..7318b02c46a 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -31,15 +31,6 @@
 
 /* #define DEBUG_OP */
 
-static inline bool needs_byteswap(const CPUPPCState *env)
-{
-#if TARGET_BIG_ENDIAN
-  return FIELD_EX64(env->msr, MSR, LE);
-#else
-  return !FIELD_EX64(env->msr, MSR, LE);
-#endif
-}
-
 /*****************************************************************************/
 /* Memory load and stores */
 
@@ -401,11 +392,10 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         int adjust = HI_IDX * (n_elems - 1);                    \
         int sh = sizeof(r->element[0]) >> 1;                    \
         int index = (addr & 0xf) >> sh;                         \
-        if (FIELD_EX64(env->msr, MSR, LE)) {                    \
-            index = n_elems - index - 1;                        \
-        }                                                       \
+        bool byteswap = FIELD_EX64(env->msr, MSR, LE);          \
                                                                 \
-        if (needs_byteswap(env)) {                              \
+        if (byteswap) {                                         \
+            index = n_elems - index - 1;                        \
             r->element[LO_IDX ? index : (adjust - index)] =     \
                 swap(access(env, addr, GETPC()));               \
         } else {                                                \
@@ -415,8 +405,8 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
     }
 #define I(x) (x)
 LVE(LVEBX, cpu_ldub_data_ra, I, u8)
-LVE(LVEHX, cpu_lduw_data_ra, bswap16, u16)
-LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
+LVE(LVEHX, cpu_lduw_be_data_ra, bswap16, u16)
+LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
@@ -428,11 +418,10 @@ LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
         int adjust = HI_IDX * (n_elems - 1);                            \
         int sh = sizeof(r->element[0]) >> 1;                            \
         int index = (addr & 0xf) >> sh;                                 \
-        if (FIELD_EX64(env->msr, MSR, LE)) {                            \
-            index = n_elems - index - 1;                                \
-        }                                                               \
+        bool byteswap = FIELD_EX64(env->msr, MSR, LE);                  \
                                                                         \
-        if (needs_byteswap(env)) {                                      \
+        if (byteswap) {                                                 \
+            index = n_elems - index - 1;                                \
             access(env, addr, swap(r->element[LO_IDX ? index :          \
                                               (adjust - index)]),       \
                         GETPC());                                       \
@@ -443,8 +432,8 @@ LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
     }
 #define I(x) (x)
 STVE(STVEBX, cpu_stb_data_ra, I, u8)
-STVE(STVEHX, cpu_stw_data_ra, bswap16, u16)
-STVE(STVEWX, cpu_stl_data_ra, bswap32, u32)
+STVE(STVEHX, cpu_stw_be_data_ra, bswap16, u16)
+STVE(STVEWX, cpu_stl_be_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
-- 
2.52.0



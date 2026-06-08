Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04D9CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD2-00015B-PF; Mon, 08 Jun 2026 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCq-0000z8-Hz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:18 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCk-0006bk-2b
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:16 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e6dcad6018so3898043a34.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945209; x=1781550009; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hZFh/GWoCgy0eFWMQ2wrLktcTwtzf8GnUsJ1AQOL9oc=;
 b=K/2SeT7RJbqsv+jK+zU7VVBFXSJarJ1QZRQqhVWqou1W5CXY7roK4gJpHCiQeiUgUM
 3z0xncpi11iq7TU3MI760wPEbBSIEHoPgdIDXUzebZiQmHCHY3rHMQwIsDX4mrPAagJL
 gtEgkNWW33fMSGL6Ei4co/Krbnc9k0kq3i16n8reifX3A/d+kz1dHECAJkIEp5+d+Z/m
 EYHlqRDD7B2BcjKQ/Rn2AhbixEdY2LiyuDiLsS74giHSB6W099tg0ayIQFwDSp2tL2Jt
 pmkt8rAO0i3TpYOf29mlviU4Y3OuFApcGyg7kKfaf8KnfvgC6GfixTBmqyeaSSSmB8la
 MZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945209; x=1781550009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hZFh/GWoCgy0eFWMQ2wrLktcTwtzf8GnUsJ1AQOL9oc=;
 b=Yd8bl3xDKB8r7FlK/YwWV2qFSbNc29+gDXPLfSFDTd0MR1pBzaFjZmqWLhNjYTJeEY
 diBJ5SN8Df4yHCsmt+euyxd5/vthQkrDo0JFqwkQS5AS8U+CvNcrb79vzglZgdUlU/BQ
 bpVR+vY3guiJfuQ2CpviDyo7GvA+dPAPVv3cOpPgu71VznuA5bdS63KqayS6wW/Q3VNB
 54VqsN/6WkLA+3bz6OE+YFOykTKzfDhM9NNgzI/NoL/wwjyLZAM57yCDI6IImXVibmv/
 JFsLLQDfT27JZhG8rQG+uXz8RWerRDGk8qW0xXjj7EKRIjmYDQ8YJdJem0F8wKXQeTAZ
 gh+A==
X-Gm-Message-State: AOJu0YyPCthNNL9W+E+uFGRkjw0t3mJgLDGWS4eE9A4b23+wAMDrmn0S
 SyPza4K5G5d3IM4KqetuEf5Pvq9YvrBUT2TXK/5UPsfkvsJjVlwp6KwHN9oWgbrLlxo=
X-Gm-Gg: Acq92OGMUyaEgdKMHsWXM85iOHLnpyUbufUUIr0LlqlW8hdGJwt7GoE8dkIn/NVgbJY
 XxJUugdxaIk/L383ihDmp6324omXYP3ffSMVQTgP//4VxMxOaQCNWysBcM5pyUDvtHz71ac+pVH
 kGWQxvRWEP4z2Qh5G9v9pLEUfu36F0U4HwsNup1B3HFpLYmVJsCHjX1eUEX2OcS0EgQ/xPmVy/7
 TIqS5VPH0MuqNXYRFjqCawNHef12is00X7SDgV4wuGfBUyDqlR6dDG0LvnSsbnrgzHw/ZTGUldh
 vjylFA3BiZIYZN8EFHFLrTvqAjUZcSEEo3xLEKCVIJnt9Ij2Vn8dO1LmSVCFg0FvyLJ263ZPmZE
 gzBLZx82s9cRuRuducSGqc+/YyCWoPcHhhB611OKD6Aj76sgWRIXsBcIZeXOw4l7PdOZHSCbGtK
 22hGbIFMFyRUparkvSV6KGEPD4py1T/Emdmr7Zvjsz5Hwsve82fMMjqGhW0UlR8Bcs6j3Ge17ZJ
 Z6oEo2+UgkVoYipn+YSCj1iTdPUOKLDzr5GghVMQyQ5OLd9cVqnvbF/KwIuIcxt3V4xNNQbELPf
 z9ypxJPoe0ZfwK8Lqd0n9LSsZgvyt1gJ
X-Received: by 2002:a05:6830:2b11:b0:7dc:c7aa:22d4 with SMTP id
 46e09a7af769-7e70c63de1bmr9622671a34.1.1780945208623; 
 Mon, 08 Jun 2026 12:00:08 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:29 -0600
Subject: [PATCH v16 04/21] target/mips: add Octeon GFM COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-4-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add helper support for the Octeon GFM carryless multiply selectors. This
models the normal and reflected multiplication paths, including the
XOR-and-multiply forms that update the result/input state used by Octeon
crypto code.

Reflected selectors operate on the architectural GFM register bank using
bit-reflected register transfers rather than a separate shadow state.
Keep the 64-bit UIA2 reduction path used by SNOW3G F9 and share that
shortcut between the normal and reflected XORMUL1 paths.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v14 -> v15:
  - Document the reflected-polynomial reduction form used by the GFM
    multiplier.
  - Share the 64-bit UIA2 shortcut between normal and reflected XORMUL1.
  - Inline the simple non-reflected GFM XOR selector in the translator.

Changes v10 -> v13:
  - Map reflected GFM selectors directly onto the architectural GFM state
    in this patch instead of adding temporary reflected shadow state.
  - Preserve the 64-bit UIA2 GFM reduction path used by SNOW3G F9.

Changes v8 -> v9:
  - Split GFM selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   9 +++
 target/mips/tcg/octeon_crypto.c | 142 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e802f50fd6..20ffbfb709 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,10 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -38,6 +42,11 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 811f36f46a..dc49986202 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -11,6 +11,7 @@
 #include "internal.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/clmul.h"
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
@@ -75,11 +76,152 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
     octeon_crc_set_state_reflect(crypto, crc);
 }
 
+static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
+                           uint16_t poly, uint64_t out[2])
+{
+    uint64_t zh = 0, zl = 0;
+    uint64_t vh = y[0], vl = y[1];
+    uint64_t rh = (uint64_t)poly << 48;
+    int i;
+
+    /*
+     * Keep the reflected-shift formulation used by Octeon software: the
+     * selector polynomial is already in reflected bit order, and the software
+     * view folds its 16 reduction bits from the top of the high word.
+     */
+    for (i = 0; i < 128; i++) {
+        bool bit;
+        bool lsb;
+
+        if (i < 64) {
+            bit = (x[0] >> (63 - i)) & 1;
+        } else {
+            bit = (x[1] >> (127 - i)) & 1;
+        }
+        if (bit) {
+            zh ^= vh;
+            zl ^= vl;
+        }
+
+        lsb = vl & 1;
+        vl = (vh << 63) | (vl >> 1);
+        vh >>= 1;
+        if (lsb) {
+            vh ^= rh;
+        }
+    }
+
+    out[0] = zh;
+    out[1] = zl;
+}
+
+static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
+{
+    uint64_t lo = int128_getlo(product);
+    uint64_t hi = int128_gethi(product);
+
+    while (hi) {
+        int bit = 63 - clz64(hi);
+
+        hi ^= 1ULL << bit;
+        lo ^= (uint64_t)poly << bit;
+        if (bit > 56) {
+            hi ^= (uint64_t)poly >> (64 - bit);
+        }
+    }
+
+    return lo;
+}
+
+static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
+                                  uint8_t poly, uint64_t out[2])
+{
+    /*
+     * SNOW3G UIA2 uses the GFM datapath as a reflected 64-bit multiply in
+     * the low half of the 128-bit register pair.  When RESINP[0], MUL[1],
+     * and the high polynomial byte are all zero, octeon_gfm_mul() observes
+     * only x[1], y[0], and the low 8-bit polynomial.  Reflect those operands
+     * into normal carryless-multiply order and reflect the reduced result
+     * back into RESINP[1].
+     */
+    uint64_t vx = revbit64(x[1]);
+    uint64_t vy = revbit64(y[0]);
+    Int128 product = clmul_64(vx, vy);
+    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
+
+    out[0] = 0;
+    out[1] = revbit64(res);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
+uint64_t helper_octeon_cp2_mf_gfm_mul_reflect0(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_mul[0]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_mul_reflect1(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_mul[1]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect0(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_resinp[0]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect1(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_resinp[1]);
+}
+
+void helper_octeon_cp2_mt_gfm_mul_reflect0(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_mul[0] = revbit64(value);
+}
+
+void helper_octeon_cp2_mt_gfm_mul_reflect1(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_mul[1] = revbit64(value);
+}
+
+void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_resinp[0] ^= revbit64(value);
+}
+
+static void octeon_gfm_xormul1_common(MIPSOcteonCryptoState *crypto,
+                                      uint64_t value)
+{
+    crypto->gfm_resinp[1] ^= value;
+    if (crypto->gfm_poly <= 0xff && crypto->gfm_mul[1] == 0 &&
+        crypto->gfm_resinp[0] == 0) {
+        octeon_gfm_mul64_uia2(crypto->gfm_resinp, crypto->gfm_mul,
+                              crypto->gfm_poly, crypto->gfm_resinp);
+    } else {
+        octeon_gfm_mul(crypto->gfm_resinp, crypto->gfm_mul, crypto->gfm_poly,
+                       crypto->gfm_resinp);
+    }
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
+                                              uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_gfm_xormul1_common(crypto, revbit64(value));
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_gfm_xormul1_common(crypto, value);
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



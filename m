Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B31CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJA-0002Xf-UU; Fri, 22 May 2026 01:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ6-0002T3-AP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:25 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ3-0001r6-FV
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:24 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4855562f32eso5091b6e.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427220; x=1780032020; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qd1JecVeUCnnJeorVMFX3xhJOlLs9zkGyq9ooA19Irc=;
 b=l98AEtRe1Wqb01YPlOaSgk9HzhbIDn4bczsyKsoqSsI28bD2S98WNqc+0im/yGDHqX
 3UUJ5eWgW2zqzjhddcGWZay+Fqi2fp8TYbbBq4ODpvoYUwjib7kYIe0Q0W4vq1FHmtWB
 I+cEDUnVs+u7EZHFlgStjQJf2lJy+OwcpAbJ4p3Jap97SqhSd5wGfLBDQLV9jS/lG48B
 Sp6QMoDJVGYhvCqFuWZw2b/MVSYHHFcbAKJkyvNoihXBYvGka31MlCFVC6UE6U7XsGJN
 G9Cuo6oVohlyhVOKYZEmEVZCD9JWMmw/YJ0OhuW4DzzjeeEYbSaWl+cEAc4UPlnhSYaE
 xOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427220; x=1780032020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qd1JecVeUCnnJeorVMFX3xhJOlLs9zkGyq9ooA19Irc=;
 b=OY8Eg9Qu83zXTvpA0txIWud+KddcgDfGgn1L5sUc1vNA53muF5bEA/7XheWYAGimHB
 ydhUK/ExandCWI+xJjiDE/nNamlXnRkfe69ca0eFl+E8GGKSvdUQkeubPrCOyv+76Hlc
 xEZnK6V7GLMKBA1iDO0VsedfEN0d7/O2gAo5hxKtQj6SKtSWhmdxigiHdhe7rxCtM7Eh
 LjxH8paAeGrGs1GpiehxlZodx7Eavnw92dOqJ2YU4n3vgkgi9oU+wVddhtu8prfsM4vo
 tmBrSh6gpwLVGCE3D/VEgy36cyC2cbDXFTfeJKfbiltuTFPGNTW6xN0RH2C3pF+UrKvI
 4J1Q==
X-Gm-Message-State: AOJu0Yx1fq+sSnspkQ446vrqCN0HBz0c/IgNvX2ZzrmdNYWb+gvui7NE
 +2H/9sS/hOst8Rk9c6LGMQPDN+iuYaFBI8y8/59Tu5Ui/p0I6qa77WEX
X-Gm-Gg: Acq92OFTnTA3DDkNeFexf/yZvo6wRSjxclOM6gRF7BMtSQo56kjWfl5b2rheVAaLL4w
 pptRGM+Y8o96u+i6LcEYAEIJwMiuuTywHaea+Dg39/l90brrT3o3fXKzejtqK8UWQBNHMY0IbyX
 B0vIuNXHS6kaRCbD+3yUHKwDPmg7TM1I62n7mfOZdDy2ELTrTcv0oJ7XwdjG8yC+s+pghuTNMtW
 TqXuBnn8IfmFfiV9i2qh6y6mogd4Ain6ddoIryx6R4uQB3AYeoxLL/9LuQ3nS4JK1MgAw6QOIp9
 BgRxTpWujTYg/OZMfdtrnxdt+SZy15EmyOGv/586Lai/n/EKTvvd4CmPGWEL5o3+k+4jn0Z/Ab+
 ZGpYy1Gbavxpe/N/sPCT2q1tc6GzYD9oBvgGKtjR3nVxbHv3V8mKJh3bJtBfd9v3rgjht+uib9O
 qDg7Yl3myEOji4WPjlkYtuszTIeClh7MbammPsrKFjfZOQlTkDCz+r9ARLo5RpaRJoV7CVuU8QB
 URbP+DPL82E6Q8lLZyxnic4hMA9qOPDJxpqpgdWF3tygYd5TcscgE4SqR38wuxTFHIVaRW6NoXd
 ZqE+4O6MVzxh2w==
X-Received: by 2002:a05:6808:1787:b0:485:542:f905 with SMTP id
 5614622812f47-4854a0dfaa5mr1093919b6e.16.1779427219854; 
 Thu, 21 May 2026 22:20:19 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:48 -0600
Subject: [PATCH v14 06/22] target/mips: add Octeon SHA3 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-6-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

Add the Octeon SHA3 register-window state and helper operations. Keep the
shared HSH/SHA3/SHA512 write path coherent, model the dedicated 25-lane
Keccak state, and implement the Keccak-f[1600] permutation for the
STARTOP selector.

The shared selector window still uses explicit selector-position
arithmetic internally because multiple COP2 engines alias the same numeric
window. Individual DMFC2/DMTC2 instruction decode stays outside the helper
implementation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split SHA3 selector operations into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SHA3 helpers.
  - Use helper-local selector constants for shared-window position logic.
  - Add matching helper.h declarations with the helper implementation.

Changes v5 -> v6:
  - Rename SHA3 DAT15 selector aliases with MF/MT direction suffixes.

Changes v1 -> v2:
  - Use switch ranges and g_assert_not_reached() for SHA3 selector
    position decoding.  (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/helper.h            |  22 +++++
 target/mips/tcg/octeon_crypto.c | 172 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 9a6702ff60..d1ec75eaff 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,7 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_sha3_dat24, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
@@ -48,6 +49,27 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xor0, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_dat24, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_dat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat8, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat9, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat10, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat11, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat12, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat13, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat14, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat16, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat17, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_startop, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index b22474574c..b3b88ce018 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -16,6 +16,8 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
+#define OCTEON_SHA3_DAT15 15
+
 static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
 {
     return bswap32(revbit32(v));
@@ -149,11 +151,129 @@ static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
     out[1] = revbit64(res);
 }
 
+static const uint64_t octeon_sha3_round_constants[24] = {
+    0x0000000000000001ULL, 0x0000000000008082ULL,
+    0x800000000000808aULL, 0x8000000080008000ULL,
+    0x000000000000808bULL, 0x0000000080000001ULL,
+    0x8000000080008081ULL, 0x8000000000008009ULL,
+    0x000000000000008aULL, 0x0000000000000088ULL,
+    0x0000000080008009ULL, 0x000000008000000aULL,
+    0x000000008000808bULL, 0x800000000000008bULL,
+    0x8000000000008089ULL, 0x8000000000008003ULL,
+    0x8000000000008002ULL, 0x8000000000000080ULL,
+    0x000000000000800aULL, 0x800000008000000aULL,
+    0x8000000080008081ULL, 0x8000000000008080ULL,
+    0x0000000080000001ULL, 0x8000000080008008ULL,
+};
+
+static const uint8_t octeon_sha3_rotation_constants[24] = {
+     1,  3,  6, 10, 15, 21, 28, 36, 45, 55,  2, 14,
+    27, 41, 56,  8, 25, 43, 62, 18, 39, 61, 20, 44,
+};
+
+static const uint8_t octeon_sha3_pi_lanes[24] = {
+    10,  7, 11, 17, 18,  3,  5, 16,  8, 21, 24,  4,
+    15, 23, 19, 13, 12,  2, 20, 14, 22,  9,  6,  1,
+};
+
+static uint64_t octeon_sha3_reg_to_lane(uint64_t value)
+{
+    /*
+     * The COP2 register interface is consumed by big-endian MIPS code as
+     * 64-bit register values, while Keccak lanes are byte-little-endian.
+     */
+    return bswap64(value);
+}
+
+static uint64_t octeon_sha3_lane_to_reg(uint64_t value)
+{
+    return bswap64(value);
+}
+
+static uint64_t octeon_sha3_get_lane(MIPSOcteonCryptoState *crypto,
+                                     unsigned int index)
+{
+    if (index < 16) {
+        return octeon_sha3_reg_to_lane(crypto->hsh_dat[index]);
+    }
+    if (index < 24) {
+        return octeon_sha3_reg_to_lane(crypto->hsh_iv[index - 16]);
+    }
+    return octeon_sha3_reg_to_lane(crypto->sha3_dat24);
+}
+
+static void octeon_sha3_set_lane(MIPSOcteonCryptoState *crypto,
+                                 unsigned int index, uint64_t value)
+{
+    value = octeon_sha3_lane_to_reg(value);
+    if (index < 16) {
+        crypto->hsh_dat[index] = value;
+    } else if (index < 24) {
+        crypto->hsh_iv[index - 16] = value;
+    } else {
+        crypto->sha3_dat24 = value;
+    }
+}
+
+static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t state[25];
+
+    for (int i = 0; i < 25; i++) {
+        state[i] = octeon_sha3_get_lane(crypto, i);
+    }
+
+    for (int round = 0; round < 24; round++) {
+        uint64_t bc[5];
+        uint64_t temp;
+
+        for (int x = 0; x < 5; x++) {
+            bc[x] = state[x] ^ state[5 + x] ^ state[10 + x] ^
+                    state[15 + x] ^ state[20 + x];
+        }
+        for (int x = 0; x < 5; x++) {
+            temp = bc[(x + 4) % 5] ^ rol64(bc[(x + 1) % 5], 1);
+            for (int y = 0; y < 25; y += 5) {
+                state[y + x] ^= temp;
+            }
+        }
+
+        temp = state[1];
+        for (int i = 0; i < 24; i++) {
+            uint64_t next = state[octeon_sha3_pi_lanes[i]];
+
+            state[octeon_sha3_pi_lanes[i]] =
+                rol64(temp, octeon_sha3_rotation_constants[i]);
+            temp = next;
+        }
+
+        for (int y = 0; y < 25; y += 5) {
+            for (int x = 0; x < 5; x++) {
+                bc[x] = state[y + x];
+            }
+            for (int x = 0; x < 5; x++) {
+                state[y + x] = bc[x] ^ ((~bc[(x + 1) % 5]) & bc[(x + 2) % 5]);
+            }
+        }
+
+        state[0] ^= octeon_sha3_round_constants[round];
+    }
+
+    for (int i = 0; i < 25; i++) {
+        octeon_sha3_set_lane(crypto, i, state[i]);
+    }
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
+uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
+{
+    return env->octeon_crypto.sha3_dat24;
+}
+
 uint64_t helper_octeon_cp2_mf_gfm_mul_reflect0(CPUMIPSState *env)
 {
     return revbit64(env->octeon_crypto.gfm_mul[0]);
@@ -219,6 +339,58 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     }
 }
 
+void helper_octeon_cp2_mt_sha3_dat24(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.sha3_dat24 = value;
+}
+
+void helper_octeon_cp2_mt_sha3_dat15(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[OCTEON_SHA3_DAT15] = value;
+}
+
+static void octeon_sha3_xordat(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint64_t value)
+{
+    uint64_t lane = octeon_sha3_get_lane(crypto, index);
+
+    octeon_sha3_set_lane(crypto, index,
+                         lane ^ octeon_sha3_reg_to_lane(value));
+}
+
+#define OCTEON_SHA3_XORDAT_HELPER(N) \
+void helper_octeon_cp2_mt_sha3_xordat ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_sha3_xordat(&env->octeon_crypto, N, value); \
+}
+OCTEON_SHA3_XORDAT_HELPER(0)
+OCTEON_SHA3_XORDAT_HELPER(1)
+OCTEON_SHA3_XORDAT_HELPER(2)
+OCTEON_SHA3_XORDAT_HELPER(3)
+OCTEON_SHA3_XORDAT_HELPER(4)
+OCTEON_SHA3_XORDAT_HELPER(5)
+OCTEON_SHA3_XORDAT_HELPER(6)
+OCTEON_SHA3_XORDAT_HELPER(7)
+OCTEON_SHA3_XORDAT_HELPER(8)
+OCTEON_SHA3_XORDAT_HELPER(9)
+OCTEON_SHA3_XORDAT_HELPER(10)
+OCTEON_SHA3_XORDAT_HELPER(11)
+OCTEON_SHA3_XORDAT_HELPER(12)
+OCTEON_SHA3_XORDAT_HELPER(13)
+OCTEON_SHA3_XORDAT_HELPER(14)
+OCTEON_SHA3_XORDAT_HELPER(15)
+OCTEON_SHA3_XORDAT_HELPER(16)
+OCTEON_SHA3_XORDAT_HELPER(17)
+#undef OCTEON_SHA3_XORDAT_HELPER
+
+void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    (void)value;
+    octeon_sha3_permute(crypto);
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



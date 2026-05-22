Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0124CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVg6-0001fO-TR; Fri, 22 May 2026 15:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVg3-0001ei-Ba
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:59 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfz-0000Ry-SX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:58 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-484df1dce93so4951558b6e.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478614; x=1780083414; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUsWVugpfboWufA01T7N7fDEWhoI7H7Jk0l86VW7Dxk=;
 b=oaSlcq2x4640nIqm56zNA94q4jAwdZfE2Bt1x0ATLmwM860ecfVmOt6bIgl55m+TxE
 73SiQIP6pRIVeKzjVxqUpobIUNP7n7vamzlEOaE9Rb0r+c8l/J1waHEIy4GBhOJRtpQ0
 Bmwxg9ldlDZ/abycFq1guZUl44G6XEl4z45GIyPHbUY/pkY6e7lI+adTgpo8gm2Vt3wZ
 naKY7yt2/DaGKherr1palfSSa8pFjsRyY+iOMdrIdFPEztmoL+hWoy2zkphO6lFv4BkE
 12PkMgHhG0Dq29PCKThihZh+Pic7Rl8VBY2YXwvZrx8lIk9Ch/lQse4vQJYiVA1wLr2u
 Iw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478614; x=1780083414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUsWVugpfboWufA01T7N7fDEWhoI7H7Jk0l86VW7Dxk=;
 b=VD1NyLuZw+bY/+XVm/x5M3B6l643z5PkHPwxL5L1pG9roUkwiyfCNpFntAyQJxLgm7
 nAGKL3N2k2vmCWQMCUCA280aFK6CbAtYolpcIL5HBwEIR/Ze9UiQq3F1WRA5YZuUOEdU
 gEs7KSsewFimVv3xpLxgz0GoD/Z/Wh+XSd9CBF2n52j5rANEAcrYbDodr1jGkQeogHBj
 04eKpsY8j9F2VLo6HiRm6t9dGy5csVJ4h6dWmZj3pf4MSN4vfYxJJNw6tGwg9y9FSm2v
 iPHegBGoGnpbtKvdc2h5IygFWHQQAeq/0RrcqGIjq55+UmNQiTLJh+3L4WSDfIOevR53
 XyVw==
X-Gm-Message-State: AOJu0YwYIKVp1fA52WjvJ3Hs3vyW+OMElfKXeEP3LdQHaA23dLbg6OsR
 2/Xkx6cMmQBU8Iq3xP7FUzh0f51/5KvsrQHxPogMGaX79JJaRDeCFM7X
X-Gm-Gg: Acq92OGH8nKJNQwbNFoR5KKDAJeLhCCIWyiatt/4ZL74fTBLaA6m7bcp2FCl4KvtlI8
 vHWuBbQM96Eg3Coqt6t1ECa9a+X+JpE4Cf+55L2sz0y1YQW96q/fAkGNdrL0eXCVyy5eNO8nODJ
 a01DuQIxvzItupG19Jan2Hcip+cOPurZVOloFE5NwzgjfpRD7ZwIJh4nak3ridAlNTZp+8A/hpd
 0ppJHshWSeiaja3G5ew90a1gU0me8Kse82ujOgLLmMvajUMZZBuhb8+bKh+Z/GBAeNoOikONzrz
 hk9+RxdS93ZjeZK0XwUyX4ut1OBoQni0r6AOewJZ1ZQgW+MSJyR5YqRTXtSTj2Uq/Bzm1PDuPgq
 AcYzCtZ6oF0bzOCNURxtXr6oyjy6JdC7F0h3omiLqkTQpfGu87HnnxEZLNu0samdmCYPlJK3vah
 aGTrAXgnkOQ2iBxpXRnmvohFJVK9H61KxA2ZvH0IyKxFiIuXkLlI+x9z4Z84iXP+W2KYg39EmYP
 pT67GC8BbkZ2IgGOyj2b5msFGw0eBXuKyH9jLHawR3bmGnY7tmMT+3bbFC5lnmGhIUm
X-Received: by 2002:a05:6808:120c:b0:482:ce3b:12e5 with SMTP id
 5614622812f47-4854a0eb6e0mr2960194b6e.14.1779478614342; 
 Fri, 22 May 2026 12:36:54 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:37 -0600
Subject: [PATCH v15 06/22] target/mips: add Octeon SHA3 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-6-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22a.google.com
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

Add the Octeon SHA3 helper operations for the architectural 25-lane
Keccak state view and implement the Keccak-f[1600] permutation used by
the STARTOP selector.

The simple SHA3 DAT register moves and XORDAT selectors are decoded as
direct TCG transfers in the selector decode patch. This helper patch only
keeps the side-effecting SHA3 operation support.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v14 -> v15:
  - Use the direct 25-lane architectural SHA3 state view from CPU state.
  - Move simple SHA3 DAT and XORDAT selector handling to direct TCG
    transfers in the decode patch.
  - Remove the unused STARTOP source operand from the helper ABI.

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
 target/mips/helper.h            |  1 +
 target/mips/tcg/octeon_crypto.c | 93 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 20ffbfb709..b887e05199 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -47,6 +47,7 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
+DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index dc49986202..74080ed2bd 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -153,6 +153,94 @@ static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
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
+static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t state[25];
+
+    for (int i = 0; i < 25; i++) {
+        state[i] = octeon_sha3_reg_to_lane(crypto->sha3_dat[i]);
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
+        crypto->sha3_dat[i] = octeon_sha3_lane_to_reg(state[i]);
+    }
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
@@ -222,6 +310,11 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     octeon_gfm_xormul1_common(crypto, value);
 }
 
+void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env)
+{
+    octeon_sha3_permute(&env->octeon_crypto);
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CBAE99058
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBSQu-0001bB-8k; Sat, 11 Apr 2026 03:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQt-0001aO-6L
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:07 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQr-00010U-2J
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:06 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4232323a7daso1595933fac.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775891224; x=1776496024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfUwVblsYiwbkfJcD68ywxdRtAmbn2hms1V2rUmc7wo=;
 b=PhJvETFWldyp5NIXnISTdXGKbP6K9TiVTYml96DCGUtAtrNzFMp6fw3eqA6Zc/mrBj
 pKI8Ad5irV3S+G3TiMVhZwhQoH1vojMn8htw+F6mL7o2cricp1NkcRF6NiIz0MQEJBmt
 /Cf3TAsFSD+GFMIq8/rob3QFeISsKBgk6ZlTyviIjNLf3h071RWf5naLFmWbVJP6pF82
 lmLUsqswISmo5yhyntBeStYu5J5ke1FITCOq3/nzP00fUef5Ttf17lou3UoT2Myt6vyd
 szhd8JP7DWwBK1JH428SVTg31Gmei1mIeadZRi0Q0JnyDXrQM2GyLAkrxc/r03cFLe0g
 wfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775891224; x=1776496024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfUwVblsYiwbkfJcD68ywxdRtAmbn2hms1V2rUmc7wo=;
 b=tKrsYVsf8XRTNuvMDk2/A/VQ732Iu48q8UwUq3NWb/+4pYN+nFMWuAY/7AsR8wJoQ+
 DEIBjLAKwAmcMv3ShXNRtctLoL6bnYIoh4bKAYU6YwqbVJYXV4VR6MUH41HAdLhLfyV4
 1k9zScxO1LXizvlxzCi/9cfYyPAxjXG51fUDUkXtnDvL6MjmOa4rKuaJ+YtK7gAX0bWM
 69hmnLyx8YJ28xQ4S5OMYIn2QPU3d/fYFSiJpnQdOp3blWhJ+DU8Y/ytAbneQBUGrDht
 PMPIKdEwyZK7GGDfzX7WA1gJVI+eKypt0fAUjgUlUhNRwZdcXHmpaL57XAgjhczXZTD9
 aV3w==
X-Gm-Message-State: AOJu0YyMXSIOQKgZESkUVl/4WRseWwC+5wfKYUdrtG8XUa373L3fi2a7
 y7UMKMynnTu7OahGVAkOdDez2RQ1pBlYByU6Jjv1BgLQijYCMxpVdgOEWIeKRn4H5o0=
X-Gm-Gg: AeBDievUgrMEIpLfxAzrSePtSvNa1G4On4ILMCLPVz9odPO47/nqRonl0lEddA7hXV9
 HVCuUsrnEFmvGE8ySOGQNlGpNxBqstfOMbjLLqUWqckdz8lOf2hDwaqX5rvUAK9D4zOLem6W5D2
 cL5SbPQCUWF4mS6JhM4OFefhT2yy9uw+rOMIJ11iZ6XQIxOBkJkCOB1PfjZXzbdynrrULV21mql
 9tBPq+MT2Kg9SOsiHvi+h4Pn7yM4f+vcS2TmSksuTLLGh1TZzznFKKMTIHyiVPmrM6/meKth4Zm
 SGrN858erzNnd9MG5luvFwW4bDrrNzx45pmstd9gACsndPq/nSl9Q7iOfcxrc79hoJ8CaDfeJNz
 Kq3yI+ppU/K2NOOkBXEEsSQwEfvqfxE+uIEwOAl5fH22A/GCV/UOGWg71wB7QlSUyiTKqkow8N+
 LA8JtW0b9Xy+6eRVGiJX+tWhhGYk9F7p84MaTJHbSsestw/f8viBWvJ6TcHEzUOImH0q0eM1WaG
 bbHM8IfrEz/CCtMsFII7lrMU8mH2IOphcPzIQjD+2AX7ddvgWKRXmep22rS/wb0440aDzQ=
X-Received: by 2002:a05:6808:4e83:b0:450:c602:751d with SMTP id
 5614622812f47-4789f30a117mr2439542b6e.21.1775891223632; 
 Sat, 11 Apr 2026 00:07:03 -0700 (PDT)
Received: from Mac.localdomain (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a0f1e841sm2651091b6e.5.2026.04.11.00.07.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 11 Apr 2026 00:07:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 6/9] target/mips: add Octeon SHA3 crypto support
Date: Sat, 11 Apr 2026 01:06:32 -0600
Message-ID: <20260411070637.72421-6-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411070637.72421-1-james.hilliard1@gmail.com>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2b.google.com
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

Add the Octeon SHA3 register window and STARTOP selector.

Model the dedicated 25-lane Keccak state and the Keccak-f[1600]
permutation so the COP2 SHA3 interface follows the hardware behaviour.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/cpu.h               |  22 +++++
 target/mips/tcg/octeon_crypto.c | 155 ++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c     |  30 +++++++
 3 files changed, 207 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 28b3e71793..dc5223e165 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -541,6 +541,7 @@ typedef enum MIPSOcteonSharedMode {
     OCTEON_SHARED_MODE_NONE = 0,
     OCTEON_SHARED_MODE_SHA512,
     OCTEON_SHARED_MODE_SNOW3G,
+    OCTEON_SHARED_MODE_SHA3,
 } MIPSOcteonSharedMode;
 
 typedef enum MIPSOcteonCop2Sel {
@@ -645,6 +646,7 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_HSH_DATW13,
     OCTEON_COP2_SEL_HSH_DATW14,
     OCTEON_COP2_SEL_HSH_DATW15,
+    OCTEON_COP2_SEL_SHA3_DAT15_READ = 0x024f,
     OCTEON_COP2_SEL_HSH_IVW0 = 0x0250,
     OCTEON_COP2_SEL_HSH_IVW1,
     OCTEON_COP2_SEL_HSH_IVW2,
@@ -671,6 +673,24 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_GFM_RESINP1,
     OCTEON_COP2_SEL_GFM_XOR0,
     OCTEON_COP2_SEL_GFM_POLY = 0x025e,
+    OCTEON_COP2_SEL_SHA3_XORDAT0 = 0x02c0,
+    OCTEON_COP2_SEL_SHA3_XORDAT1,
+    OCTEON_COP2_SEL_SHA3_XORDAT2,
+    OCTEON_COP2_SEL_SHA3_XORDAT3,
+    OCTEON_COP2_SEL_SHA3_XORDAT4,
+    OCTEON_COP2_SEL_SHA3_XORDAT5,
+    OCTEON_COP2_SEL_SHA3_XORDAT6,
+    OCTEON_COP2_SEL_SHA3_XORDAT7,
+    OCTEON_COP2_SEL_SHA3_XORDAT8,
+    OCTEON_COP2_SEL_SHA3_XORDAT9,
+    OCTEON_COP2_SEL_SHA3_XORDAT10,
+    OCTEON_COP2_SEL_SHA3_XORDAT11,
+    OCTEON_COP2_SEL_SHA3_XORDAT12,
+    OCTEON_COP2_SEL_SHA3_XORDAT13,
+    OCTEON_COP2_SEL_SHA3_XORDAT14,
+    OCTEON_COP2_SEL_SHA3_XORDAT15,
+    OCTEON_COP2_SEL_SHA3_XORDAT16,
+    OCTEON_COP2_SEL_SHA3_XORDAT17,
     OCTEON_COP2_SEL_AES_ENC_CBC1 = 0x3109,
     OCTEON_COP2_SEL_AES_ENC1 = 0x310b,
     OCTEON_COP2_SEL_AES_DEC_CBC1 = 0x310d,
@@ -683,6 +703,7 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_SNOW3G_START = 0x404d,
     OCTEON_COP2_SEL_SNOW3G_MORE = 0x404e,
     OCTEON_COP2_SEL_HSH_STARTSHA256 = 0x404f,
+    OCTEON_COP2_SEL_SHA3_STARTOP = 0x4052,
     OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT = 0x405d,
     OCTEON_COP2_SEL_HSH_STARTSHA1 = 0x4057,
     OCTEON_COP2_SEL_HSH_STARTSHA512 = 0x424f,
@@ -697,6 +718,7 @@ typedef struct MIPSOcteonCryptoState {
     uint64_t hash_block[8];
     uint64_t sha512_state[8];
     uint64_t sha512_block[16];
+    uint64_t sha3_state[25];
     uint64_t aes_iv[2];
     uint64_t aes_key[4];
     uint64_t aes_result[2];
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 976f6c7ddb..7dde536560 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -490,6 +490,107 @@ static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
     crypto->sha512_state[7] += h;
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
+static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t *state = crypto->sha3_state;
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
+}
+
+static int octeon_sha3_dat_pos_from_sel(uint32_t sel)
+{
+    if (sel >= OCTEON_COP2_SEL_HSH_DATW0 &&
+        sel <= OCTEON_COP2_SEL_HSH_DATW14) {
+        return sel - OCTEON_COP2_SEL_HSH_DATW0;
+    }
+    if (sel >= OCTEON_COP2_SEL_HSH_IVW0 &&
+        sel <= OCTEON_COP2_SEL_HSH_IVW7) {
+        return 16 + (sel - OCTEON_COP2_SEL_HSH_IVW0);
+    }
+
+    switch (sel) {
+    /*
+     * SHA3_DAT15_READ aliases HSH_DATW15 at 0x024f, so a single case covers
+     * both selector names.
+     */
+    case OCTEON_COP2_SEL_HSH_DATW15:
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
+        return 15;
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        return 24;
+    default:
+        return -1;
+    }
+}
+
+static int octeon_sha3_xordat_pos_from_sel(uint32_t sel)
+{
+    if (sel >= OCTEON_COP2_SEL_SHA3_XORDAT0 &&
+        sel <= OCTEON_COP2_SEL_SHA3_XORDAT17) {
+        return sel - OCTEON_COP2_SEL_SHA3_XORDAT0;
+    }
+    return -1;
+}
+
 static const uint8_t octeon_snow3g_sr[256] = {
     0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
     0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
@@ -1384,6 +1485,7 @@ static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
 target_ulong helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+    int sha3_pos;
 
     if (crypto->shared_mode == OCTEON_SHARED_MODE_SNOW3G) {
         if (sel >= OCTEON_COP2_SEL_SNOW3G_LFSR0 &&
@@ -1405,6 +1507,13 @@ target_ulong helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
         }
     }
 
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_SHA3) {
+        sha3_pos = octeon_sha3_dat_pos_from_sel(sel);
+        if (sha3_pos >= 0) {
+            return crypto->sha3_state[sha3_pos];
+        }
+    }
+
     switch (sel) {
     case OCTEON_COP2_SEL_3DES_KEY0:
     case OCTEON_COP2_SEL_3DES_KEY1:
@@ -1446,7 +1555,16 @@ target_ulong helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
     case OCTEON_COP2_SEL_HSH_DATW5:
     case OCTEON_COP2_SEL_HSH_DATW6:
     case OCTEON_COP2_SEL_HSH_DATW7:
+    case OCTEON_COP2_SEL_HSH_DATW8:
+    case OCTEON_COP2_SEL_HSH_DATW9:
+    case OCTEON_COP2_SEL_HSH_DATW10:
+    case OCTEON_COP2_SEL_HSH_DATW11:
+    case OCTEON_COP2_SEL_HSH_DATW12:
+    case OCTEON_COP2_SEL_HSH_DATW13:
+    case OCTEON_COP2_SEL_HSH_DATW14:
         return crypto->sha512_block[sel - OCTEON_COP2_SEL_HSH_DATW0];
+    case OCTEON_COP2_SEL_HSH_DATW15:
+        return crypto->sha512_block[15];
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -1486,6 +1604,7 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
     uint64_t q = (uint64_t)value;
+    int sha3_pos;
 
     switch (sel) {
     case OCTEON_COP2_SEL_3DES_KEY0:
@@ -1600,6 +1719,7 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
     case OCTEON_COP2_SEL_HSH_DATW13:
     case OCTEON_COP2_SEL_HSH_DATW14:
         crypto->sha512_block[sel - OCTEON_COP2_SEL_HSH_DATW0] = q;
+        crypto->sha3_state[sel - OCTEON_COP2_SEL_HSH_DATW0] = q;
         break;
     case OCTEON_COP2_SEL_HSH_DATW15:
     case OCTEON_COP2_SEL_HSH_STARTSHA512:
@@ -1607,6 +1727,14 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
         octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA512);
         octeon_sha512_transform(crypto);
         break;
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        crypto->sha3_state[15] = q;
+        break;
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        crypto->sha3_state[24] = q;
+        break;
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -1616,6 +1744,7 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
     case OCTEON_COP2_SEL_HSH_IVW6:
     case OCTEON_COP2_SEL_HSH_IVW7:
         crypto->sha512_state[sel - OCTEON_COP2_SEL_HSH_IVW0] = q;
+        crypto->sha3_state[16 + (sel - OCTEON_COP2_SEL_HSH_IVW0)] = q;
         break;
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT0:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT1:
@@ -1667,6 +1796,32 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
         crypto->hash_block[7] = q;
         octeon_sha1_transform(crypto);
         break;
+    case OCTEON_COP2_SEL_SHA3_XORDAT0:
+    case OCTEON_COP2_SEL_SHA3_XORDAT1:
+    case OCTEON_COP2_SEL_SHA3_XORDAT2:
+    case OCTEON_COP2_SEL_SHA3_XORDAT3:
+    case OCTEON_COP2_SEL_SHA3_XORDAT4:
+    case OCTEON_COP2_SEL_SHA3_XORDAT5:
+    case OCTEON_COP2_SEL_SHA3_XORDAT6:
+    case OCTEON_COP2_SEL_SHA3_XORDAT7:
+    case OCTEON_COP2_SEL_SHA3_XORDAT8:
+    case OCTEON_COP2_SEL_SHA3_XORDAT9:
+    case OCTEON_COP2_SEL_SHA3_XORDAT10:
+    case OCTEON_COP2_SEL_SHA3_XORDAT11:
+    case OCTEON_COP2_SEL_SHA3_XORDAT12:
+    case OCTEON_COP2_SEL_SHA3_XORDAT13:
+    case OCTEON_COP2_SEL_SHA3_XORDAT14:
+    case OCTEON_COP2_SEL_SHA3_XORDAT15:
+    case OCTEON_COP2_SEL_SHA3_XORDAT16:
+    case OCTEON_COP2_SEL_SHA3_XORDAT17:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        sha3_pos = octeon_sha3_xordat_pos_from_sel(sel);
+        crypto->sha3_state[sha3_pos] ^= q;
+        break;
+    case OCTEON_COP2_SEL_SHA3_STARTOP:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_sha3_permute(crypto);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
         octeon_gfm_mul_reflect(crypto, q);
         break;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c66cb63cfc..be380cab11 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -9154,6 +9154,14 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_DATW5:
     case OCTEON_COP2_SEL_HSH_DATW6:
     case OCTEON_COP2_SEL_HSH_DATW7:
+    case OCTEON_COP2_SEL_HSH_DATW8:
+    case OCTEON_COP2_SEL_HSH_DATW9:
+    case OCTEON_COP2_SEL_HSH_DATW10:
+    case OCTEON_COP2_SEL_HSH_DATW11:
+    case OCTEON_COP2_SEL_HSH_DATW12:
+    case OCTEON_COP2_SEL_HSH_DATW13:
+    case OCTEON_COP2_SEL_HSH_DATW14:
+    case OCTEON_COP2_SEL_SHA3_DAT15_READ:
     case OCTEON_COP2_SEL_HSH_IV0:
     case OCTEON_COP2_SEL_HSH_IV1:
     case OCTEON_COP2_SEL_HSH_IV2:
@@ -9167,6 +9175,7 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_IVW6:
     case OCTEON_COP2_SEL_HSH_IVW7:
     case OCTEON_COP2_SEL_AES_DAT0:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT0:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT1:
     case OCTEON_COP2_SEL_GFM_RESINP_REFLECT0:
@@ -9251,6 +9260,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_DATW13:
     case OCTEON_COP2_SEL_HSH_DATW14:
     case OCTEON_COP2_SEL_HSH_DATW15:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -9268,11 +9279,30 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_GFM_RESINP1:
     case OCTEON_COP2_SEL_GFM_XOR0:
     case OCTEON_COP2_SEL_GFM_POLY:
+    case OCTEON_COP2_SEL_SHA3_XORDAT0:
+    case OCTEON_COP2_SEL_SHA3_XORDAT1:
+    case OCTEON_COP2_SEL_SHA3_XORDAT2:
+    case OCTEON_COP2_SEL_SHA3_XORDAT3:
+    case OCTEON_COP2_SEL_SHA3_XORDAT4:
+    case OCTEON_COP2_SEL_SHA3_XORDAT5:
+    case OCTEON_COP2_SEL_SHA3_XORDAT6:
+    case OCTEON_COP2_SEL_SHA3_XORDAT7:
+    case OCTEON_COP2_SEL_SHA3_XORDAT8:
+    case OCTEON_COP2_SEL_SHA3_XORDAT9:
+    case OCTEON_COP2_SEL_SHA3_XORDAT10:
+    case OCTEON_COP2_SEL_SHA3_XORDAT11:
+    case OCTEON_COP2_SEL_SHA3_XORDAT12:
+    case OCTEON_COP2_SEL_SHA3_XORDAT13:
+    case OCTEON_COP2_SEL_SHA3_XORDAT14:
+    case OCTEON_COP2_SEL_SHA3_XORDAT15:
+    case OCTEON_COP2_SEL_SHA3_XORDAT16:
+    case OCTEON_COP2_SEL_SHA3_XORDAT17:
     case OCTEON_COP2_SEL_HSH_STARTSHA1_COMPAT:
     case OCTEON_COP2_SEL_HSH_STARTMD5:
     case OCTEON_COP2_SEL_SNOW3G_START:
     case OCTEON_COP2_SEL_SNOW3G_MORE:
     case OCTEON_COP2_SEL_HSH_STARTSHA256:
+    case OCTEON_COP2_SEL_SHA3_STARTOP:
     case OCTEON_COP2_SEL_HSH_STARTSHA1:
     case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
     case OCTEON_COP2_SEL_HSH_STARTSHA512:
-- 
2.53.0



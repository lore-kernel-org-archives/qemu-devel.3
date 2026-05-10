Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4871CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAxA-0005EB-L7; Sun, 10 May 2026 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx5-0005Ag-9b
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:40 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx1-00048P-S6
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:38 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4756e74f8edso2707978b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445635; x=1779050435; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FtmE+HTfu0Jd1amaLGVvzWsxbPUPcsHmiPQV+pgdSQk=;
 b=rwt5mMtCtomVFcdcaDO1u8wR/VKqfWNY2rd6Z7pZx/MYPlpK5dpBym5pxpLF99aHF6
 riXZS5eBUDRYOYIHMa9UvKttrx1k/r0RsVT87+mFrroPssG6t0T98TcaFzAmuPdG8H4a
 wwGQvpx7y/7YlbIXHEzm+JQg+p9Uh2aWVnKbJn9RPXTWqGj8JcqZrNkBhQz9B0Hou38A
 p2Eis0ub/m4k339kBLawUabCVmUEcZciD9I/uZ6sJ85FmE9rBgPkySPa4UpzFgmGfPeP
 1MHyDO4z4tY4rwroXBKjhbBoQ/GxB/vVSstfFHSQ5o/lJ3uixWqDcoKKug5A7EQLsHXk
 0Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445635; x=1779050435;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FtmE+HTfu0Jd1amaLGVvzWsxbPUPcsHmiPQV+pgdSQk=;
 b=SENytytzxzEEtYT/mQIDpM+ZkPPa2ryazCXnHfN1cKqHi7yBSicap7nzvPb/+Al7Jh
 pdmkGnI5KnXfhOqnKLtQXS/8bOUP/pruNV9OMEyhgxbZUxHUrA6ifF7skIduGwxKhJqv
 Iz1qZZR1IrO/jE/UiRCbUOugXW7IUS/XzCfzouyM3/A6/xInT++cT9ipsAHww+dyer4W
 K4LM0U8fvXksDZdLxbUWbbt3bu1MsmKbadMcc9gDa17mcb+pXlcytURI8MKZY8lGz8DX
 hbk46aAW/VSdmXAxZ7SZGvsVpm1yferT8nz2YnoYf1ApxU8SrfGgkDQN0mbXitVUIcIS
 BqaQ==
X-Gm-Message-State: AOJu0YwITyhtcZJoTgf3ct6szx/QHH/ZsHB/xANHYNkIa3FvaWRn2eIH
 i89VTntd4Yj4hiZntiAIqQfANM40zdvb9aAjivESFNcqdOefpxrIYGahDfD1O6bL
X-Gm-Gg: Acq92OHGgX5qEeIcjGEAZdMYgz4o83uTISn7nMU5rypszQrDmA4qiH4MzIOSxWQUOXw
 67NdhmWGgjeRCpAvQwcUqh/3EGXPj0K3YLe/Rcf/V2drxiDSBwc2hNHr56aj7ZEww8CrRmv99rO
 v8Bp3dO+oSVPiaKGFzyEBDFA/iUobDFcxtEz7OqUGCoassuZb63eG511u2okhlzKdxexV+NODJy
 fMUuoHp/3NDBfMY/InH+zJSe7tKWdhFeetpns2POjlr4HZJH18UrdHQdo05B5tnC3MXBfI9XUjY
 4UAx4Xg+nhMgPRglYemdMX0DyjTQC/YMPuRT7/Qi9jgVP2mqddHqCSdgdP1QGI1EsU6/3wmMvCS
 IbhG/4fRpDIJbuGMSP5lUA62mAudMhUBiSJR1ee3OfYZyZ/Mp0n+p/1dBPMdq/AVnrfTyxq/ICH
 cdR8NRYPi+XPPK/3xaE1IHT+RN62Mjv/z7nna6g60vyNNQkB4uHUCHzdy0NqNd/q0n4GHsYEaPx
 9EW+Nsya1BhFMxgHNEAJ8BC/vIQCJ0RT2aoj/BGeUY=
X-Received: by 2002:a05:6808:1441:b0:474:28c1:4877 with SMTP id
 5614622812f47-48042503b27mr12162160b6e.39.1778445634757; 
 Sun, 10 May 2026 13:40:34 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:58 -0600
Subject: [PATCH v5 28/32] target/mips: add Octeon SHA3 crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-28-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x234.google.com
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

Keep the shared HSH/SHA3/SHA512 write path coherent, then model the
dedicated 25-lane Keccak state and the Keccak-f[1600] permutation so the
COP2 SHA3 interface follows the hardware behaviour.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Use switch ranges and g_assert_not_reached() for SHA3 selector
    position decoding.  (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/cpu.h                  |  22 +++++
 target/mips/system/machine.c       |   1 +
 target/mips/tcg/octeon_crypto.c    | 171 +++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c |  22 +++++
 4 files changed, 216 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6994925d50..3192bc2c5d 100644
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
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 45577d5495..b888793d27 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -292,6 +292,7 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hash_block, MIPSCPU, 8),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.sha512_state, MIPSCPU, 8),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.sha512_block, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.sha3_state, MIPSCPU, 25),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_result, MIPSCPU, 2),
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 177d112483..d9e66f3dc8 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -487,21 +487,150 @@ static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
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
+static bool octeon_sha3_is_dat_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW15:
+    case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW7:
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static int octeon_sha3_dat_pos_from_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW14:
+        return sel - OCTEON_COP2_SEL_HSH_DATW0;
+    case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW7:
+        return 16 + (sel - OCTEON_COP2_SEL_HSH_IVW0);
+    case OCTEON_COP2_SEL_HSH_DATW15:
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
+        return 15;
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        return 24;
+    default:
+        g_assert_not_reached();
+    }
+}
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
 static void octeon_store_shared_hash_dat(MIPSOcteonCryptoState *crypto,
                                          uint32_t sel, uint64_t value)
 {
     switch (sel) {
     case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW14:
         crypto->sha512_block[sel - OCTEON_COP2_SEL_HSH_DATW0] = value;
+        crypto->sha3_state[sel - OCTEON_COP2_SEL_HSH_DATW0] =
+            octeon_sha3_reg_to_lane(value);
         break;
     case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW7:
         crypto->sha512_state[sel - OCTEON_COP2_SEL_HSH_IVW0] = value;
+        crypto->sha3_state[16 + (sel - OCTEON_COP2_SEL_HSH_IVW0)] =
+            octeon_sha3_reg_to_lane(value);
+        break;
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
+        crypto->sha3_state[15] = octeon_sha3_reg_to_lane(value);
+        break;
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        crypto->sha3_state[24] = octeon_sha3_reg_to_lane(value);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
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
@@ -1396,6 +1525,7 @@ static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
 uint64_t helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+    int sha3_pos;
 
     if (crypto->shared_mode == OCTEON_SHARED_MODE_SNOW3G) {
         if (sel >= OCTEON_COP2_SEL_SNOW3G_LFSR0 &&
@@ -1417,6 +1547,12 @@ uint64_t helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
         }
     }
 
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_SHA3 &&
+        octeon_sha3_is_dat_sel(sel)) {
+        sha3_pos = octeon_sha3_dat_pos_from_sel(sel);
+        return octeon_sha3_lane_to_reg(crypto->sha3_state[sha3_pos]);
+    }
+
     switch (sel) {
     case OCTEON_COP2_SEL_3DES_KEY0:
     case OCTEON_COP2_SEL_3DES_KEY1:
@@ -1507,6 +1643,7 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
     uint64_t q = (uint64_t)value;
+    int sha3_pos;
 
     switch (sel) {
     case OCTEON_COP2_SEL_3DES_KEY0:
@@ -1628,6 +1765,14 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA512);
         octeon_sha512_transform(crypto);
         break;
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_store_shared_hash_dat(crypto, sel, q);
+        break;
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_store_shared_hash_dat(crypto, sel, q);
+        break;
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -1688,6 +1833,32 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
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
+        crypto->sha3_state[sha3_pos] ^= octeon_sha3_reg_to_lane(q);
+        break;
+    case OCTEON_COP2_SEL_SHA3_STARTOP:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_sha3_permute(crypto);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
         octeon_gfm_mul_reflect(crypto, q);
         break;
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 81042cfb5f..08091c12e3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -66,6 +66,7 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_IVW6:
     case OCTEON_COP2_SEL_HSH_IVW7:
     case OCTEON_COP2_SEL_AES_DAT0:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT0:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT1:
     case OCTEON_COP2_SEL_GFM_RESINP_REFLECT0:
@@ -150,6 +151,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_DATW13:
     case OCTEON_COP2_SEL_HSH_DATW14:
     case OCTEON_COP2_SEL_HSH_DATW15:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+    case OCTEON_COP2_SEL_SHA3_DAT15_WRITE:
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -167,11 +170,30 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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
2.54.0



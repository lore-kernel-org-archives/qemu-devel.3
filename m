Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B38CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI5-0005IE-Ka; Mon, 11 May 2026 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHo-0004s7-7e
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:25 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHk-0002v4-Er
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:23 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de46b8e432so4458169a34.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523799; x=1779128599; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2mDXfiI6vTFk1Nn7f3Jp1htp9eXh0i4alNjvCchTraA=;
 b=ocPFmpOzPh7tQVwkZTkTji2rFRsiu8A27Ja4iyjYpWHILXZp46uukuYUio9oQwPWji
 ZROkTDqVwGIJA09bWR8i+vdWTXDS+H+0aEa7bJ66czANvdOHG5g4nfpfGvHRyaNCQhQo
 Y5E786xYa1ZZyM6ConZpmGG5jl+RQ+1zrdAdcgqUPW3SvFEd5imN5EMpP3CMZqIVNP88
 J2YTpnlYiyGlX8zzjIxC1k2Rtfc28Dm+GWcAV2jrINiDmm7Nt9u7YE1sPsH1TkAPdDAI
 z5++lWs85/Pd+EbyAHr8742VFKApELbrH7z8GMPkhOaA/PSpteZIkKgyG21MAVYS0vTo
 VV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523799; x=1779128599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2mDXfiI6vTFk1Nn7f3Jp1htp9eXh0i4alNjvCchTraA=;
 b=muHWKRqESb76tgCFHn4tpPdX/fR7rkaWsdodzvZ0DnDqkq/Z1YBXFXKj53eZQGCRgK
 f3HbcqWwypynITh3wfvKQ3UyQMiwIso1Af9FoqbaWUGVzlRj4q8mwM30Iuuc9hI9UzMq
 SyOAJyx0nu+gXV3YBie1Jv02yi9bFUwM+riHbic8rs24gSx6ItEWhWg0s6eHPc9B0Xrn
 68W/Lihz22VS8s+i5r2LrQBkEGSnhrz205IL/c1b3PH9YzXgvSjQoN5CMsbawC/vhWO4
 /6Z1m9XLz7OEfxGxou6k60pQ2sC6SCGIwXGsUoK/kpJeFJC7vvGOtUP0+3gjH+Xu+/HF
 7NQA==
X-Gm-Message-State: AOJu0YwBzugKsrKqDLYqD4qbuBSrqoSkY3gDk26Liwql1YWA5b0zhm/k
 zinGO+D1+rjQVnArdpF+/No+YqkiUO0wLAmywhTpTAqMBHUqJcjxlDpB
X-Gm-Gg: Acq92OHDGks6CObVkacDBbb59Wq7qtR8MkDUyCZLhS3f4WKBbZwQQlZQUiGfiUNwg+k
 jNoHl10sYXKz83HEURSuphDlAQojf5tCzqPorp2X1AqjUHA5kURBFOYbpd8rYPxkPm+Lp/aJLv7
 eTbDmKmnEg2/UaiHGVRToyn8TxOMpbne4pM5od1Zc3hzl6OXMCpE2GBk/3NuLWeNO9/6+dab2WX
 fYUR1TbOdB2Igkd7XcOIAv7G7YspQCzYI7e5aKGpz8s8QQ5nmBMVo/LEPNGzS6Uv7248o95h2Hx
 dlwmwGf7tYTHpNCsyB75IbmI3x6OKayxrDZYBP08nhSgi3DN/8mSh3XX4a6tpPNJMeDjSyBq9xW
 Whd4M3CEsBBunqJz47DwBXL83ZV6ssWdxsCrj5GxlK/0wgpdC/NdDaWVLeNx7mmvOrQgqxFbocZ
 Npd5IjklG/I6iFKXStIJmPn+fIr/7WF5kwMcp5i4qrhCp5QA2eOkShVl5sKHs2WsJTmBjJsAuJa
 8q1J0svzQVYSV8FjNkSB6dnAVe789NMeCAJdv/5jSW4LLGACzk0ZnpZ0Ni47VkSNL9I
X-Received: by 2002:a05:6830:3697:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e1df16f04bmr15875744a34.24.1778523799022; 
 Mon, 11 May 2026 11:23:19 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:23:00 -0600
Subject: [PATCH v6 29/35] target/mips: add Octeon SHA3 crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-29-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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

Changes v5 -> v6:
  - Rename SHA3 DAT15 selector aliases with MF/MT direction suffixes.
---
 target/mips/cpu.h                  |  22 +++++
 target/mips/system/machine.c       |   1 +
 target/mips/tcg/octeon_crypto.c    | 171 +++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c |  22 +++++
 4 files changed, 216 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index dc883bfb4a..258db2babe 100644
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
+    OCTEON_COP2_SEL_SHA3_DAT15_MF = 0x024f,
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
     OCTEON_COP2_SEL_HSH_STARTSHA = 0x4057,
     OCTEON_COP2_SEL_HSH_STARTSHA512 = 0x424f,
@@ -697,6 +718,7 @@ typedef struct MIPSOcteonCryptoState {
     uint64_t hsh_dat[8];
     uint64_t hsh_ivw[8];
     uint64_t hsh_datw[16];
+    uint64_t sha3_state[25];
     uint64_t aes_iv[2];
     uint64_t aes_key[4];
     uint64_t aes_result[2];
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index ebfa0a9eb0..e6336534f4 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -292,6 +292,7 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 8),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_ivw, MIPSCPU, 8),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_datw, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.sha3_state, MIPSCPU, 25),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_result, MIPSCPU, 2),
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 2d2b19ad30..42e68f4205 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -487,21 +487,150 @@ static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
     crypto->hsh_ivw[7] += h;
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
+    case OCTEON_COP2_SEL_SHA3_DAT15_MT:
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
+    case OCTEON_COP2_SEL_SHA3_DAT15_MT:
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
 static void octeon_store_shared_hsh_window(MIPSOcteonCryptoState *crypto,
                                          uint32_t sel, uint64_t value)
 {
     switch (sel) {
     case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW14:
         crypto->hsh_datw[sel - OCTEON_COP2_SEL_HSH_DATW0] = value;
+        crypto->sha3_state[sel - OCTEON_COP2_SEL_HSH_DATW0] =
+            octeon_sha3_reg_to_lane(value);
         break;
     case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW7:
         crypto->hsh_ivw[sel - OCTEON_COP2_SEL_HSH_IVW0] = value;
+        crypto->sha3_state[16 + (sel - OCTEON_COP2_SEL_HSH_IVW0)] =
+            octeon_sha3_reg_to_lane(value);
+        break;
+    case OCTEON_COP2_SEL_SHA3_DAT15_MT:
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
     uint64_t data = value;
+    int sha3_pos;
 
     switch (sel) {
     case OCTEON_COP2_SEL_3DES_KEY0:
@@ -1628,6 +1765,14 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA512);
         octeon_sha512_transform(crypto);
         break;
+    case OCTEON_COP2_SEL_SHA3_DAT15_MT:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_store_shared_hsh_window(crypto, sel, data);
+        break;
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_store_shared_hsh_window(crypto, sel, data);
+        break;
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -1688,6 +1833,32 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         crypto->hsh_dat[7] = data;
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
+        crypto->sha3_state[sha3_pos] ^= octeon_sha3_reg_to_lane(data);
+        break;
+    case OCTEON_COP2_SEL_SHA3_STARTOP:
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+        octeon_sha3_permute(crypto);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
         octeon_gfm_mul_reflect(crypto, data);
         break;
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index fac7b8fa2e..5bb638147d 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -68,6 +68,7 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_IVW6:
     case OCTEON_COP2_SEL_HSH_IVW7:
     case OCTEON_COP2_SEL_AES_INP0:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT0:
     case OCTEON_COP2_SEL_GFM_MUL_REFLECT1:
     case OCTEON_COP2_SEL_GFM_RESINP_REFLECT0:
@@ -152,6 +153,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_HSH_DATW13:
     case OCTEON_COP2_SEL_HSH_DATW14:
     case OCTEON_COP2_SEL_HSH_DATW15:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+    case OCTEON_COP2_SEL_SHA3_DAT15_MT:
     case OCTEON_COP2_SEL_HSH_IVW0:
     case OCTEON_COP2_SEL_HSH_IVW1:
     case OCTEON_COP2_SEL_HSH_IVW2:
@@ -169,11 +172,30 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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
     case OCTEON_COP2_SEL_HSH_STARTSHA_COMPAT:
     case OCTEON_COP2_SEL_HSH_STARTMD5:
     case OCTEON_COP2_SEL_SNOW3G_START:
     case OCTEON_COP2_SEL_SNOW3G_MORE:
     case OCTEON_COP2_SEL_HSH_STARTSHA256:
+    case OCTEON_COP2_SEL_SHA3_STARTOP:
     case OCTEON_COP2_SEL_HSH_STARTSHA:
     case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
     case OCTEON_COP2_SEL_HSH_STARTSHA512:

-- 
2.54.0



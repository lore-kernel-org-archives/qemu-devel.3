Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A01CD37B5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAxB-0005EH-34; Sun, 10 May 2026 16:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx6-0005B5-Fg
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:40 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx4-00048k-33
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:40 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479ef2b7979so2696631b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445637; x=1779050437; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/WFIx4PETG6F5AWzWp9kzaHg2jL1aXKBIPuz4mZVDN4=;
 b=NZ03YAwqY55p7bLPoe2Uy9+iFoBa0+HwXKLXzeqpEAHvRAzZt3B3MEY8rrtyaGXe8U
 2sFSX6QgEFppw+dT7gbaQEudBKsc983wqVrlSUeJYWRrNZFtgF/ILZ18ArO7pfy4O7FT
 e5DxgCogn2Jdhk0dpDdg8SpH9gHIYSv/GZyz5J8gPuJITq1u0nbVX5FOtbgogSYs3rrR
 78RSvZv6lSjXN0pCtuH/Av/PSGWEahyXT9H+y3EQ+QQkxzDjnK/x72X5qaqM99FXCELH
 oLNHIc/5+/9X1h1L2cpDt8oE/kQWlpbjj5ILbWuvU/nA1/azR190ZqHWN1F2X898uGyT
 molQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445637; x=1779050437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/WFIx4PETG6F5AWzWp9kzaHg2jL1aXKBIPuz4mZVDN4=;
 b=sCuxg01d7OLA2v9GYFmJaYNUWI5FIaC4j/zHJdJMTE0lqvtoV4ChOR5fe02VgeFqT7
 iaCRMKxk23d9J1iT3DxqtRNWBEjKxcPbg6c43VUA5taKASCCXAKpyINQd50qxUn8IB8d
 0mrt890PFgmXYLlWwhfJVRpvQ8Ba1m1O6oRiM55FMZu9qTBng2dB3kH1okfOBn546pnY
 2boVTlqVlRBXLX2a2dxyu2+Dbwb53TN42qY6t7tnXA/0paL5jPYIM2ClEZ61d2Toge1/
 EtjiWVftThqGdlhfpo8fC2YGM6TEjKdTvmm3AMvHMzqgbSK+AShlf4YJHImfZn9qztYJ
 8VKg==
X-Gm-Message-State: AOJu0Yxk0GBDuCr+ONJKEm2nICOE9x2MToET0T1Uu5/leAcvz8nAPpOd
 yniYooixvNDKkTeJFLW10jcVvJ/lw6hzOyTNB4rC1nrLFPqbo8eDpWhV
X-Gm-Gg: Acq92OElqEUSDawrzRVdnQD6LQcr7RKPFDqqUEmeb7scrCWl+29seknVCNI4z1v7GGo
 uC1x7OoFUq5Y3W5xfMJOWyfl6zXwuEZMXYNVFd+7aBtT6+wTVdGOdrkB1JeIlnFg+vDu20MH7pu
 YsbNkFCgqQo5MZbnCUq2vZcdruhWqfe10vTRPlS8JeoYhAOc3abVA7wAkL/1Mmfsfu+FlLEv4bU
 tTnJijEDUtzDoqfAIXsf3vUkTOX99BBfeor6Lc18mInxuSBPpxjigkH12WXrZAxurRvjF6xKQ7C
 kkIJXop1qbLQ0a9oX1BD/RFKYptGzhYWTxXlirsTbgqlrLtLE/Fn9SQtPrWVu6peyztoufExmf3
 cNU8mqDNPLWWBN08yabjYxFu1nCuIRCvAqa0Y2gc4ziVwjF/98z7ZBk5WKSFNNWi+r7K0wJC716
 LczOgbVuIXvBb/RyzIc3bhlANuPVMJ5ycnuq7WRosCY8YWrufYoBflcRvzvcFA6BJgr/UsCnIty
 P6YsngG022yjIZsoUemkfaH+pOPRXaCUgSZjAfsb8c=
X-Received: by 2002:a05:6809:ca:20b0:482:6815:9d7 with SMTP id
 5614622812f47-48268154048mr1349448b6e.44.1778445637000; 
 Sun, 10 May 2026 13:40:37 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:40:00 -0600
Subject: [PATCH v5 30/32] target/mips: add Octeon Camellia crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-30-d5d2668d15ab@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x235.google.com
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

Add the Octeon Camellia ROUND, FL, and FLINV selectors and model the
round engine that reuses the AES RESULT/RESINP bank.

Implement the Camellia F-function and FL layers directly from RFC 3713
so guest-managed key schedules can drive the engine through the hardware
interface.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Drop the Octeon prefix from generic Camellia helper routines.
    (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/cpu.h                  |   9 +++
 target/mips/tcg/octeon_crypto.c    | 120 +++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c |   3 +
 3 files changed, 132 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 29ee662035..8d020d8967 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -595,6 +595,14 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
     OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
     OCTEON_COP2_SEL_AES_DAT0 = 0x0111,
+    /*
+     * Camellia reuses the AES RESULT/RESINP bank and adds per-round and
+     * diffusion-layer selectors for the guest-managed key schedule.
+     */
+    OCTEON_COP2_SEL_CAMELLIA_RESINP0 = OCTEON_COP2_SEL_AES_RESULT0,
+    OCTEON_COP2_SEL_CAMELLIA_RESINP1 = OCTEON_COP2_SEL_AES_RESULT1,
+    OCTEON_COP2_SEL_CAMELLIA_FL = 0x0115,
+    OCTEON_COP2_SEL_CAMELLIA_FLINV = 0x0116,
     /*
      * SMS4 reuses the AES result/input, IV, and key banks and only adds
      * operation selectors for ECB/CBC encrypt/decrypt.
@@ -696,6 +704,7 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_ENC1 = 0x310b,
     OCTEON_COP2_SEL_AES_DEC_CBC1 = 0x310d,
     OCTEON_COP2_SEL_AES_DEC1 = 0x310f,
+    OCTEON_COP2_SEL_CAMELLIA_ROUND = 0x3114,
     OCTEON_COP2_SEL_SMS4_ENC_CBC1 = 0x3119,
     OCTEON_COP2_SEL_SMS4_ENC1 = 0x311b,
     OCTEON_COP2_SEL_SMS4_DEC_CBC1 = 0x311d,
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 3ee56ef4c0..9c5f19f41d 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1650,6 +1650,117 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
     regs[1] = ldq_be_p(block + 8);
 }
 
+static const uint8_t camellia_sbox1[256] = {
+    112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12,
+    174,  65,  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,
+     29, 101, 146, 189, 134, 184, 175, 143, 124, 235,  31, 206,  62,  48,
+    220,  95,  94, 197,  11,  26, 166, 225,  57, 202, 213,  71,  93,  61,
+    217,   1,  90, 214,  81,  86, 108,  77, 139,  13, 154, 102, 251, 204,
+    176,  45, 116,  18,  43,  32, 240, 177, 132, 153, 223,  76, 203, 194,
+     52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215,  20,  88,
+     58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34,
+    254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252,
+    105,  80, 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149,
+    224, 255, 100, 210,  16, 196,   0,  72, 163, 247, 117, 219, 138,   3,
+    230, 218,   9,  63, 221, 148, 135,  92, 131,   2, 205,  74, 144,  51,
+    115, 103, 246, 243, 157, 127, 191, 226,  82, 155, 216,  38, 200,  55,
+    198,  59, 129, 150, 111,  75,  19, 190,  99,  46, 233, 121, 167, 140,
+    159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89, 120, 152,
+      6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250,
+    114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56,
+    241, 164,  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244,
+    119, 199, 128, 158,
+};
+
+static inline uint8_t camellia_rotl8(uint8_t v, unsigned int shift)
+{
+    return (v << shift) | (v >> (8 - shift));
+}
+
+static inline uint8_t camellia_sbox2(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 1);
+}
+
+static inline uint8_t camellia_sbox3(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 7);
+}
+
+static inline uint8_t camellia_sbox4(uint8_t x)
+{
+    return camellia_sbox1[camellia_rotl8(x, 1)];
+}
+
+static uint64_t camellia_f(uint64_t input, uint64_t key)
+{
+    uint64_t x = input ^ key;
+    uint8_t t1 = camellia_sbox1[x >> 56];
+    uint8_t t2 = camellia_sbox2((x >> 48) & 0xff);
+    uint8_t t3 = camellia_sbox3((x >> 40) & 0xff);
+    uint8_t t4 = camellia_sbox4((x >> 32) & 0xff);
+    uint8_t t5 = camellia_sbox2((x >> 24) & 0xff);
+    uint8_t t6 = camellia_sbox3((x >> 16) & 0xff);
+    uint8_t t7 = camellia_sbox4((x >> 8) & 0xff);
+    uint8_t t8 = camellia_sbox1[x & 0xff];
+    uint8_t y1 = t1 ^ t3 ^ t4 ^ t6 ^ t7 ^ t8;
+    uint8_t y2 = t1 ^ t2 ^ t4 ^ t5 ^ t7 ^ t8;
+    uint8_t y3 = t1 ^ t2 ^ t3 ^ t5 ^ t6 ^ t8;
+    uint8_t y4 = t2 ^ t3 ^ t4 ^ t5 ^ t6 ^ t7;
+    uint8_t y5 = t1 ^ t2 ^ t6 ^ t7 ^ t8;
+    uint8_t y6 = t2 ^ t3 ^ t5 ^ t7 ^ t8;
+    uint8_t y7 = t3 ^ t4 ^ t5 ^ t6 ^ t8;
+    uint8_t y8 = t1 ^ t4 ^ t5 ^ t6 ^ t7;
+
+    return ((uint64_t)y1 << 56) | ((uint64_t)y2 << 48) |
+           ((uint64_t)y3 << 40) | ((uint64_t)y4 << 32) |
+           ((uint64_t)y5 << 24) | ((uint64_t)y6 << 16) |
+           ((uint64_t)y7 << 8) | y8;
+}
+
+static uint64_t camellia_fl(uint64_t input, uint64_t key)
+{
+    uint32_t x1 = input >> 32;
+    uint32_t x2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    x2 ^= rol32(x1 & k1, 1);
+    x1 ^= x2 | k2;
+    return ((uint64_t)x1 << 32) | x2;
+}
+
+static uint64_t camellia_flinv(uint64_t input, uint64_t key)
+{
+    uint32_t y1 = input >> 32;
+    uint32_t y2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    y1 ^= y2 | k2;
+    y2 ^= rol32(y1 & k1, 1);
+    return ((uint64_t)y1 << 32) | y2;
+}
+
+static void octeon_camellia_round(MIPSOcteonCryptoState *crypto, uint64_t key)
+{
+    uint64_t left = crypto->aes_result[0];
+    uint64_t right = crypto->aes_result[1];
+
+    crypto->aes_result[0] = right ^ camellia_f(left, key);
+    crypto->aes_result[1] = left;
+}
+
+static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
+                                     uint64_t key, bool inverse)
+{
+    uint64_t state = crypto->aes_result[inverse ? 1 : 0];
+
+    crypto->aes_result[inverse ? 1 : 0] = inverse ?
+        camellia_flinv(state, key) :
+        camellia_fl(state, key);
+}
+
 static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
                                      bool encrypt, bool cbc)
 {
@@ -2046,6 +2157,12 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
         crypto->aes_keylen = q;
         break;
+    case OCTEON_COP2_SEL_CAMELLIA_FL:
+        octeon_camellia_fl_layer(crypto, q, false);
+        break;
+    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
+        octeon_camellia_fl_layer(crypto, q, true);
+        break;
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL_REFLECT:
         crypto->crc_poly = q;
@@ -2231,6 +2348,9 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         crypto->aes_input[1] = q;
         octeon_aes_decrypt_common(crypto, false);
         break;
+    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
+        octeon_camellia_round(crypto, q);
+        break;
     case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
         crypto->aes_input[1] = q;
         octeon_sms4_crypt_common(crypto, true, true);
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 6d031b5067..86814159f0 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -109,6 +109,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_DEC_CBC0:
     case OCTEON_COP2_SEL_AES_DEC0:
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
+    case OCTEON_COP2_SEL_CAMELLIA_FL:
+    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_IV:
     case OCTEON_COP2_SEL_CRC_WRITE_LEN:
@@ -204,6 +206,7 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_ENC1:
     case OCTEON_COP2_SEL_AES_DEC_CBC1:
     case OCTEON_COP2_SEL_AES_DEC1:
+    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
     case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
     case OCTEON_COP2_SEL_SMS4_ENC1:
     case OCTEON_COP2_SEL_SMS4_DEC_CBC1:

-- 
2.54.0



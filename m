Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB59CD4F51
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYz-0007yw-3U; Mon, 18 May 2026 01:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYG-0006wD-Sk
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0003Xf-IX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:00 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-47c941f6bdcso1185705b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082195; x=1779686995; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LcGLg3A64N0XlB35gvVGq/geAoYujp1c+lZZAr34ux4=;
 b=TJ5p3ojjtclXbY5Rj11SkUcg4teVCsKa7swf5u4Vb3MXyXTsxmfxo04xFrurCDJWBg
 vJXU5q2NqUSeEVYp3ARVOv9m6Yfc2U7BmyEP3H5mSea2siu2tTJBZxuW0IRTrHWCek3s
 D/2medmnR+9LItn/thsWbzC1+2TeMKYAiCrCN5VaPRkllUmlr6GKL6Td6C/5dE7QYRtm
 1paxt8wrBYY8suJRgArfnkyLWpjQhM+ubIyeOi/4j5jB0xo4JGYI8hS0wvuTciSuKTne
 127kKOjIfgj/WebtV7k5SeDyon38g8DE25OLWDuuxFri/SJcxIMieUcO+SlY9gQLIpeU
 sWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082195; x=1779686995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LcGLg3A64N0XlB35gvVGq/geAoYujp1c+lZZAr34ux4=;
 b=NAJnEpQF0iLrMYPQjZqEo0/yvsLEKYvb5USH5nzHRL8Ex6HuYC2z+Gy3JU9mrJiX6r
 S9JXBLX6mrX/yacPw73g0kvrtmX9epChL1aCcimMEbsrnMf0vdFhAabDzZVYWT7n0k2b
 byyNGs0S09LlEdMHHVDCE7kmm+tQb+w69/86bPAgULNMPbygzjGHxa2iT3IcYEwiCAoK
 nGwZ4debiJw2PzLbcCpncfePJR34h6XmEAeG2aL4qFhYisJ0FPrW+AnImeAPCO1xu92n
 T4Mzzm7Cj9Q//ulfMBEK7K72Mw9MU7POUM2AAsleKJ0M4XPe8a0ix3U39qtnS/qw5JCe
 iotg==
X-Gm-Message-State: AOJu0YwpGA9FGwJK9ZRO/+feDFJS2FAtrDnkSF9aAJPvtO2lqHPZBt2y
 VIW75KboFy2LcbPPtOzqhqst0qYDVudnhPBDlExQ5TPY/HNBnPVQBBA1
X-Gm-Gg: Acq92OG8GvME6ud5HOxbPkZW2MZdc7uYdYdnSA6fVl5JHpRJ6r8YSKlE+sTEmUdytZJ
 6Vlb2TiBOLo6wezonftrCO3h2f/8wFAnZ4bByUSSq/Rl1yToKBSMKq0V2O6rSyF/KfXtos2BWEo
 2tDktwzuOzTu1yoO5o9p5mBnoQ1rxLmjkNUYhRSE9AwRd2m+g496WHb1iOQI02jDgwHm9nkpId/
 T7LCsZYoogXQEvep9+Tq1eHe8CzM2xjjSsqft85h3M1nlVmBC8ajPJnbV6pL3PPYYFrNnewQYtC
 r0Hze4AZRvurL1kTXG08mHiZL4+zhWfdYk7TfZI9txyy6i+TgZ+uXR3P9Ygvez10PQXPo3Bh2Zl
 baut5RqLZus4OiAuABieZlE+i1iBgCXxuGLUP3EVRbPHG0wtZIt4e4OxVmban0w88wR4q8e5JuC
 /6W/DSwQJPOd84m1LkOVyLXFbDQKkwr3ZC0pj1ywBS6tyqbuiLd3cKcJ3yHF9UQwXqXTPg6ctv5
 eluytDTcY1ucZNE1pXIvDnfVytp8GnywewtPjgH8lB5lr5PFY8CktZD5dQhE1BIWXmc2+U=
X-Received: by 2002:a05:6808:2391:b0:479:fbe5:3a4a with SMTP id
 5614622812f47-482e57d18ecmr9911450b6e.46.1779082194774; 
 Sun, 17 May 2026 22:29:54 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:26 -0600
Subject: [PATCH v8 29/35] target/mips: add Octeon Camellia crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-29-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x233.google.com
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
round engine that reuses the AES RESINP bank.

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

Changes v5 -> v6:
  - Use RESINP wording for the Camellia shared selector aliases.
---
 target/mips/cpu.h               |   9 +++
 target/mips/tcg/octeon_crypto.c | 120 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 0b16382dd3..ba886735d5 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -595,6 +595,14 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
     OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
     OCTEON_COP2_SEL_AES_INP0 = 0x0111,
+    /*
+     * Camellia reuses the AES RESINP bank and adds per-round and
+     * diffusion-layer selectors for the guest-managed key schedule.
+     */
+    OCTEON_COP2_SEL_CAMELLIA_RESINP0 = OCTEON_COP2_SEL_AES_RESINP0,
+    OCTEON_COP2_SEL_CAMELLIA_RESINP1 = OCTEON_COP2_SEL_AES_RESINP1,
+    OCTEON_COP2_SEL_CAMELLIA_FL = 0x0115,
+    OCTEON_COP2_SEL_CAMELLIA_FLINV = 0x0116,
     /*
      * SMS4 reuses the AES RESINP, IV, and key banks and only adds
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
index 30df901e6b..27e34b7f43 100644
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
         crypto->aes_keylen = data;
         break;
+    case OCTEON_COP2_SEL_CAMELLIA_FL:
+        octeon_camellia_fl_layer(crypto, data, false);
+        break;
+    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
+        octeon_camellia_fl_layer(crypto, data, true);
+        break;
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL_REFLECT:
         crypto->crc_poly = data;
@@ -2231,6 +2348,9 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         crypto->aes_input[1] = data;
         octeon_aes_decrypt_common(crypto, false);
         break;
+    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
+        octeon_camellia_round(crypto, data);
+        break;
     case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
         crypto->aes_input[1] = data;
         octeon_sms4_crypt_common(crypto, true, true);

-- 
2.54.0



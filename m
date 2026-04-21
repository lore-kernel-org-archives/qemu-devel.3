Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B676F327D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtQ-00040n-2j; Tue, 21 Apr 2026 13:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEtC-0003nu-LT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:28:01 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt7-0006iF-3C
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:58 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-41708f6c3feso2904275fac.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792470; x=1777397270; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zy1jUHwquGXAF0/9oNRKMTQfF1h+MwqwETxxkbiCZYg=;
 b=nk9vIxntuQHLoWIZRFJDFb0dAWAq3F1ugXVwQhWqGQHJY5wqvuTb0g6nUBQ/L3KNTT
 yHs1APINjk++W/fJn2KLLMqZOjTx5DQD8lF+cJKv7Kh9PA9TsbBPQwZCOYLdRq8K1uTz
 HsRdm/k0C6/jyXeXCUSRz/BGmKr6rHYZOvwvDwG98+shbw79KMjDBZJ7LdwcNYSjrAWv
 YyceYoRm4DmKWBbSI9k7Gte2Pt9jaOTHuElwoQuRmf2beC0PEb22K+ZG5Y1CBE9GY7pd
 mzl9qek2Xuqt4/D9BwnDBg9wNlbzJs75hBV6pEozSLv3R7bqIM0slfj4J2cTKBPuEfAD
 D4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792470; x=1777397270;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zy1jUHwquGXAF0/9oNRKMTQfF1h+MwqwETxxkbiCZYg=;
 b=K0d6uckChXTiKk7qD/sWjrTRT+YA9ajpAjq84m6Z1CnCxPRziNxh+1SZQS5qo19e2z
 nEbgT81LrYpn7Dq3I2Ls2xg/e0hN96M/M7xjfqNTvTLNuTMkDzulERqMQmq4SVJMrrdF
 7aNSNPSqoWzHeGNMSMdvWzoie0pUEejtRTUf9BpN2Ynu26kBF0wPckz1cGsa/1rculVr
 om6gBceLjw+jqUaaw3RnP93t7hgB0cMbNOSpQYVZExcMYvB21lrePhXG9nzpNrkJtvpz
 Bw7aqD0dYSU9UHJZPtt9IdBmiKci3UgfgljDHJb7mG1yjfanlOgUmtCD8pm8JX4TSEeY
 kT6g==
X-Gm-Message-State: AOJu0YyJ2JMYmqnnjKdRcvM56qrWd2N7jP3TLS+w4HD5agsiaszgQEQS
 JKMBreNgg7c6sZvYPrQ12bKtJ2zlpEBOWNVXf8sMyHVayJZL9b+xlbs4
X-Gm-Gg: AeBDietntM4SFqxfJa0wQ8QKPoRVGpWGJzhZO5AIBZH0aCwyTX7OYq3PokFWhF1dMHL
 7glCCCFORvYhw6RDkCS1YJ6MzJpCayf5PaFUGYZKBc1FcLs/Wc8O2DsuPbhjtAbtDXU6Y9w+3JO
 1yDThoPDnVcyI+OVXkEQ9lOmBPJNe9r8lfYvpBpFuRvyy9/5ErmqM391Jo4mNy0HDxLKCDfTtj7
 dCqbEjI2yxEeq3WNMWNSxM2sC/FETEJj0CWyTBD+e3aYEwNowLY5FiGtgmKJN1SEj1N3uo7qB3Z
 Yor0179NHZHfa/qu3DdCdiv6NZT5hyhb0umtRx1Oq023VWPfyLMUQPX0GLNdar4nbGR9+EUZG2f
 w0f7MGVBSxJxsh3dnnag94cIepi0oKM11T/V360D5cbQVKt9R38S+Lx47fRN9EtIYvge90HXay/
 pnmKFWLtEC/Oh8jnaUwiN8BWe4QXvhgBybRq6t+qwdqRvqo1nt39g1N4hCGjqvBrECwzqS2S2PE
 jfIKdvXgA9Ob+GJedpNtb5lreCvQPYG76tFbE/px97nEywqXiFC0h0qg+eobEIsgz85Ze4i2PHt
 gwpolm4wjDdC8SQW
X-Received: by 2002:a05:6870:9d81:b0:42c:6ea:3227 with SMTP id
 586e51a60fabf-42c06ea5b06mr5790272fac.19.1776792469645; 
 Tue, 21 Apr 2026 10:27:49 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:38 -0600
Subject: [PATCH v2 11/13] target/mips: add Octeon Camellia crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-11-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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
index 437d43636b..8411ef7de4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -587,6 +587,14 @@ typedef enum MIPSOcteonCop2Sel {
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
@@ -688,6 +696,7 @@ typedef enum MIPSOcteonCop2Sel {
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
index 965dab1b34..004b937412 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -115,6 +115,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_DEC_CBC0:
     case OCTEON_COP2_SEL_AES_DEC0:
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
+    case OCTEON_COP2_SEL_CAMELLIA_FL:
+    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_IV:
     case OCTEON_COP2_SEL_CRC_WRITE_LEN:
@@ -210,6 +212,7 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_ENC1:
     case OCTEON_COP2_SEL_AES_DEC_CBC1:
     case OCTEON_COP2_SEL_AES_DEC1:
+    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
     case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
     case OCTEON_COP2_SEL_SMS4_ENC1:
     case OCTEON_COP2_SEL_SMS4_DEC_CBC1:

-- 
2.53.0



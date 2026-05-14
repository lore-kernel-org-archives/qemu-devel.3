Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966CECD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2g-00049p-4Z; Thu, 14 May 2026 13:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa16-0000sz-VN
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:39 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-00048y-SN
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:34 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de44ed7a11so6926376a34.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780305; x=1779385105; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqzucmkDfgJY2FI/ldPH+PQ95mYs2INNEAGhggFz078=;
 b=Fl2vsqfvT+aG2fx3fUjeLoBgS9CTrSEP/8vcErJVRdX/AHQXOna916yIpmb/HEg7Jh
 JW88HVzPwDK9GRiSi4JzfnaYF9UVlDI1KmUUty/emVEMln+5Eq9JkgG4j6E6cBdXpzrl
 zfmwWiwbROtNPjhPE5WvPFmDqD+Y3JtRH/a9pufLHqWQnE36peX+4jRXoRPVFk9dIcUF
 CU5TPUhB8ZImXZlE/P6O5h2SfTAbOMmyvYtg83c99hFLFgvBFk7LjceSA3Ij4ugxjVgC
 vh5VNehFpNlG5w4lGaprbgRf1pboih0g45XjzRNNYi9bjtwiKMQ8r4j84KpT+zu5Eg5s
 92aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780305; x=1779385105;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aqzucmkDfgJY2FI/ldPH+PQ95mYs2INNEAGhggFz078=;
 b=aAp93wJ8AxFbuGGTg3aRyWFDtZ3cbvjFVKSB5tSObJnc7ljsCVdsW5j+8WH8CjXgN2
 1XzNs1xaLaytxr3gGRfSLsnn2WxVBrkbGS2caVxgMz9M3Er20DqRilh8sVOWtnZlkE2+
 9EGc4KYsePdHP9Z6P2nNRv6LdgNK9lYlfkFrv8DCZyz1tpOdhGN4MG1esCz6AQ8WkChX
 IaYUxeKY+zwm/R1fe5TXLiXVYQ80kn7eN95J3dPaPrj/DXdTD1dQpMz5G6WbabkvRQCy
 DDS4Xqu2dsp2OgJbk3USmgwmnDdZg0dCr3Jqv7hWDxHrkv5c0w0vJRGnbReUqd8h6eYL
 cT9w==
X-Gm-Message-State: AOJu0YznA9q2UySrQj20DRZBlDh5DJgRRJjPzaCtL2ObPLUdNhhWXQ+R
 kaeicSXW3pPSlgwwwe2oMEWiXdBM4AEV3ajg5mxItYBBoxbyUf39dOX1
X-Gm-Gg: Acq92OE28EmPS5I4lbufdMbRdZKvDTLrI/YDBOqlp8zdQkqvMo9iEwcYp5VGo0euQeC
 1rx8EmYwbDcZAYUCjOWYmfCv/bNIrX932JQQT8S0KkXUhbG1h/k5EZuQA2BCSU5bXq+LMg45wSy
 VJMUkR8JGaEaErTZ1gPCbqjPguBCWvravu/Bk4uOtzcKvSFdmgH4/s7EO4SIbdm4l6Hwq4ThgYk
 +ZwyjQ49mLXOT3acxdKhmP1dfvs29RBoN41Oh/0zdcJugeSI4+8h1qGCy+vXokDENCThbmdWR69
 Mkr113Liy4alQ26DrRhU/uQOGfu4Xv1PVbHTPw8PpiiNTzljitPBcermDMGMWMGRrXtqZCn9kh9
 RgnQqJFq7LFGgp5JHf5G/rZMG0H+VSPiSemFTca/LQhl8daGVP7e6U12zUwOLk/aIGr9MPdwbsq
 /+ZMcOfkFmjngRa1yxI0KxI1e+gj3t7RkTE7QYRIA5F2cdGlrjIW1otKdVLvrcPCNW5U6VdmYNA
 PTZJjy+Xq5ZzG4SIeOLuuD+uN80+hJSwc9gTTkOh2Z0HJvFm3z2s/7rxjWINwaNV2KB9TAPbYq4
 trQ=
X-Received: by 2002:a05:6820:4c84:b0:68b:990a:8eb3 with SMTP id
 006d021491bc7-69c9437ce04mr246201eaf.34.1778780304781; 
 Thu, 14 May 2026 10:38:24 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:20 -0600
Subject: [PATCH v7 31/35] target/mips: add Octeon Camellia crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-31-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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
 target/mips/cpu.h                  |   9 +++
 target/mips/tcg/octeon_crypto.c    | 120 +++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c |   3 +
 3 files changed, 132 insertions(+)

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
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 9080d32223..a6ccdcb1df 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -111,6 +111,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_DEC_CBC0:
     case OCTEON_COP2_SEL_AES_DEC0:
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
+    case OCTEON_COP2_SEL_CAMELLIA_FL:
+    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_IV:
     case OCTEON_COP2_SEL_CRC_WRITE_LEN:
@@ -206,6 +208,7 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_ENC1:
     case OCTEON_COP2_SEL_AES_DEC_CBC1:
     case OCTEON_COP2_SEL_AES_DEC1:
+    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
     case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
     case OCTEON_COP2_SEL_SMS4_ENC1:
     case OCTEON_COP2_SEL_SMS4_DEC_CBC1:

-- 
2.54.0



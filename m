Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD0DE99058
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBSQs-0001aG-Kw; Sat, 11 Apr 2026 03:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQq-0001Zo-L9
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:04 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQo-00010E-RF
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:04 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4094b31a037so1949169fac.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775891221; x=1776496021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILzL3Jim9OA/Ssv/nVzqqnWJdD1VSRHtuqTQWWGsyRs=;
 b=JgSjoXFgePsMtm9+W9NZD1JcspVmgaktCZfUjgQeb7z+D0YCDOWVQEsPbp/HWods0s
 +l3WTY7uF9YY8FV9MYqV0JuqB6NVd9MWTER6VFub2vTOuXS9XX67y9L1CDnnMpEr9MmL
 C5BVyKSmH6W5EQlcrnER5l6/hw2ADr6gdNG9+D9dQ/B2cIOFJdxXdT2J6Fc9IVDMPGdm
 T44rNz6jAOTd/nFrqMzTNxxhG9x16wH5k1jP7AeHARYobBL2CLgVHGXJHyNBaHGIumJ4
 OQfrL2/7aE0/gpiyWsqzm35gbc79Pxg0gS0SHnf/v5UC5svIXjUaxgv38mooJH9v8yo5
 TTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775891221; x=1776496021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ILzL3Jim9OA/Ssv/nVzqqnWJdD1VSRHtuqTQWWGsyRs=;
 b=Q7do9lOZ5paOIOeQ7/J+p8+r27fDfVg1G15iZKfaO472LNkAVbvG6zFa7AnSoZOboe
 4yrf/iQd7fcg0asxnnNy9Aus4Pya7eVOIA6qjAV5iPmtvaJXz9h/4JGW/quj3DtdNN4v
 +fFodV7jnaYr3UmMwgJm4+JzE2mCx9i49u8oCK4udnZJzWj1tVZ7dKVMDQDIgD3ot4PO
 wAFHyQ6FGdVUN/9MTWitN+wuXJ8wTG2+vXX04ZVFeGyQbsXsM8rdWAfN9hPF5PO75kWS
 U1AdFiJa7DcCZlLzx1JrJP7x8RLpn67IEgHoH+NxMrkVmd2ZW8gp57Q5WEyj3SXnaKk8
 aPgQ==
X-Gm-Message-State: AOJu0YzfFh9/0WB4Y/57xZG8cqHpiIL9HWpS+M1SHLUBKqLNlr5VpDLU
 bVzKmMArqI3zPqjdMni1OeI3PLp1ryElySC4b1o4FEb1oRnmZHsvC+mrp/kwnQuK9Yo=
X-Gm-Gg: AeBDieuNmNG8zPBB/1WXd4wiGsViaNFMYcHMFTRiEDViZeDKgo1iWM1zaQ/qONCJLpH
 pveERJbs3ZainK1fqkyWyeULV6s4jBL13BNU0j8yab84dfjuN7yiR541/T89phzMDGnvQiZPrFA
 wif6SH7OadG4FvCEh0TgS0SY7YPbQTaHR3cQN8LLPKtv1TRxuTg63WpWWpMudsAWGipN41E24Xo
 U4dtXUK78Ds795z4UpMZL+HIx+9063K72e3TiZMpOKkCB9TU/7MMgeMddHnhxDa9CvR/B1waO+Z
 mLGK7cxxvB1O8aArvdcKtkldHgP8iihmG8f/8TlsNc5EGY2OVLG7RJ9yWXCcaD879OVA2Ot2x8/
 AUCXPN6+hrz1B5kvUEr5RORr960K9hSThTkJJZnp6cC/YsJSs50VhGPm6doZZF5hD6fM5/5a4Ps
 xVBbHt+GnVpegYPnqlrJwgu/LPEi08mE+QkpIYu/RH3wFADSJWJ6a5a3dVv4aFXOseDTOu/pdr4
 j6sHiGEQmO/vAK73LqrerZbcKIdFydS7MTxg6RnYsavR2DwA4Ec407YROnzh7wNmn5IalY0iDtw
 dDkkrg==
X-Received: by 2002:a05:6808:c2d9:b0:466:f3a2:dc34 with SMTP id
 5614622812f47-4789f209e29mr2873351b6e.36.1775891221402; 
 Sat, 11 Apr 2026 00:07:01 -0700 (PDT)
Received: from Mac.localdomain (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a0f1e841sm2651091b6e.5.2026.04.11.00.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 11 Apr 2026 00:07:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 5/9] target/mips: add Octeon SMS4 crypto support
Date: Sat, 11 Apr 2026 01:06:31 -0600
Message-ID: <20260411070637.72421-5-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411070637.72421-1-james.hilliard1@gmail.com>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x32.google.com
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

On Octeon, the SMS4 engine is exposed through selectors that alias the
AES register bank. Add the missing selectors and model the shared
RESULT, IV, and key state so the hardware interface matches the
processor behaviour.

Use the in-tree SM4 tables to implement the block operation without
adding a host crypto dependency.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/cpu.h               |  18 +++++
 target/mips/tcg/octeon_crypto.c | 114 ++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c     |   8 +++
 3 files changed, 140 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b4b7575ecb..28b3e71793 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -593,6 +593,20 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
     OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
     OCTEON_COP2_SEL_AES_DAT0 = 0x0111,
+    /*
+     * SMS4 reuses the AES result/input, IV, and key banks and only adds
+     * operation selectors for ECB/CBC encrypt/decrypt.
+     */
+    OCTEON_COP2_SEL_SMS4_RESINP0 = OCTEON_COP2_SEL_AES_RESULT0,
+    OCTEON_COP2_SEL_SMS4_RESINP1 = OCTEON_COP2_SEL_AES_RESULT1,
+    OCTEON_COP2_SEL_SMS4_IV0 = OCTEON_COP2_SEL_AES_IV0,
+    OCTEON_COP2_SEL_SMS4_IV1 = OCTEON_COP2_SEL_AES_IV1,
+    OCTEON_COP2_SEL_SMS4_KEY0 = OCTEON_COP2_SEL_AES_KEY0,
+    OCTEON_COP2_SEL_SMS4_KEY1 = OCTEON_COP2_SEL_AES_KEY1,
+    OCTEON_COP2_SEL_SMS4_ENC_CBC0 = OCTEON_COP2_SEL_AES_ENC_CBC0,
+    OCTEON_COP2_SEL_SMS4_ENC0 = OCTEON_COP2_SEL_AES_ENC0,
+    OCTEON_COP2_SEL_SMS4_DEC_CBC0 = OCTEON_COP2_SEL_AES_DEC_CBC0,
+    OCTEON_COP2_SEL_SMS4_DEC0 = OCTEON_COP2_SEL_AES_DEC0,
     OCTEON_COP2_SEL_CRC_POLYNOMIAL = 0x0200,
     OCTEON_COP2_SEL_CRC_IV = 0x0201,
     OCTEON_COP2_SEL_CRC_LEN = 0x0202,
@@ -661,6 +675,10 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_ENC1 = 0x310b,
     OCTEON_COP2_SEL_AES_DEC_CBC1 = 0x310d,
     OCTEON_COP2_SEL_AES_DEC1 = 0x310f,
+    OCTEON_COP2_SEL_SMS4_ENC_CBC1 = 0x3119,
+    OCTEON_COP2_SEL_SMS4_ENC1 = 0x311b,
+    OCTEON_COP2_SEL_SMS4_DEC_CBC1 = 0x311d,
+    OCTEON_COP2_SEL_SMS4_DEC1 = 0x311f,
     OCTEON_COP2_SEL_HSH_STARTMD5 = 0x4047,
     OCTEON_COP2_SEL_SNOW3G_START = 0x404d,
     OCTEON_COP2_SEL_SNOW3G_MORE = 0x404e,
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index a308c3957e..976f6c7ddb 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -12,6 +12,7 @@
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "crypto/aes.h"
+#include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
@@ -733,6 +734,57 @@ static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
     }
 }
 
+static inline uint32_t octeon_sms4_t(uint32_t x)
+{
+    x = sm4_subword(x);
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^
+           rol32(x, 18) ^ rol32(x, 24);
+}
+
+static inline uint32_t octeon_sms4_t_key(uint32_t x)
+{
+    x = sm4_subword(x);
+    return x ^ rol32(x, 13) ^ rol32(x, 23);
+}
+
+static void octeon_sms4_expand_key(const uint8_t *key, uint32_t round_keys[32])
+{
+    static const uint32_t fk[4] = {
+        0xa3b1bac6U, 0x56aa3350U, 0x677d9197U, 0xb27022dcU,
+    };
+    uint32_t k[36];
+
+    for (int i = 0; i < 4; i++) {
+        k[i] = ldl_be_p(key + i * 4) ^ fk[i];
+    }
+    for (int i = 0; i < 32; i++) {
+        k[i + 4] = k[i] ^ octeon_sms4_t_key(k[i + 1] ^ k[i + 2] ^
+                                            k[i + 3] ^ sm4_ck[i]);
+        round_keys[i] = k[i + 4];
+    }
+}
+
+static void octeon_sms4_crypt_block(const uint8_t *in, uint8_t *out,
+                                    const uint32_t round_keys[32],
+                                    bool encrypt)
+{
+    uint32_t x[36];
+
+    for (int i = 0; i < 4; i++) {
+        x[i] = ldl_be_p(in + i * 4);
+    }
+    for (int i = 0; i < 32; i++) {
+        uint32_t rk = round_keys[encrypt ? i : 31 - i];
+
+        x[i + 4] = x[i] ^ octeon_sms4_t(x[i + 1] ^ x[i + 2] ^
+                                        x[i + 3] ^ rk);
+    }
+    stl_be_p(out, x[35]);
+    stl_be_p(out + 4, x[34]);
+    stl_be_p(out + 8, x[33]);
+    stl_be_p(out + 12, x[32]);
+}
+
 static const uint8_t octeon_des_ip[64] = {
     58, 50, 42, 34, 26, 18, 10,  2,
     60, 52, 44, 36, 28, 20, 12,  4,
@@ -1186,6 +1238,47 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
     regs[1] = ldq_be_p(block + 8);
 }
 
+static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
+                                     bool encrypt, bool cbc)
+{
+    uint8_t key[16];
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint32_t round_keys[32];
+
+    /*
+     * SMS4 aliases the AES state onto the RESULT/RESINP, IV, and KEY banks,
+     * with only the operation selectors remaining distinct.
+     */
+    octeon_aes_load_key(crypto, key, sizeof(key));
+    octeon_aes_load_block(crypto->aes_input, in);
+    if (cbc) {
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        if (encrypt) {
+            for (int i = 0; i < sizeof(in); i++) {
+                in[i] ^= iv[i];
+            }
+        } else {
+            memcpy(next_iv, in, sizeof(next_iv));
+        }
+    }
+
+    octeon_sms4_expand_key(key, round_keys);
+    octeon_sms4_crypt_block(in, out, round_keys, encrypt);
+    if (cbc && !encrypt) {
+        for (int i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_result, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
+    }
+}
+
 static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
 {
     AES_KEY key;
@@ -1424,6 +1517,11 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
     case OCTEON_COP2_SEL_3DES_DEC:
         octeon_3des_crypt_common(crypto, q, false, false);
         break;
+    case OCTEON_COP2_SEL_AES_RESULT0:
+    case OCTEON_COP2_SEL_AES_RESULT1:
+        crypto->aes_input[sel - OCTEON_COP2_SEL_AES_RESULT0] = q;
+        crypto->aes_result[sel - OCTEON_COP2_SEL_AES_RESULT0] = q;
+        break;
     case OCTEON_COP2_SEL_AES_IV0:
     case OCTEON_COP2_SEL_AES_IV1:
         crypto->aes_iv[sel - OCTEON_COP2_SEL_AES_IV0] = q;
@@ -1588,6 +1686,22 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
         crypto->aes_input[1] = q;
         octeon_aes_decrypt_common(crypto, false);
         break;
+    case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
+        crypto->aes_input[1] = q;
+        octeon_sms4_crypt_common(crypto, true, true);
+        break;
+    case OCTEON_COP2_SEL_SMS4_ENC1:
+        crypto->aes_input[1] = q;
+        octeon_sms4_crypt_common(crypto, true, false);
+        break;
+    case OCTEON_COP2_SEL_SMS4_DEC_CBC1:
+        crypto->aes_input[1] = q;
+        octeon_sms4_crypt_common(crypto, false, true);
+        break;
+    case OCTEON_COP2_SEL_SMS4_DEC1:
+        crypto->aes_input[1] = q;
+        octeon_sms4_crypt_common(crypto, false, false);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1: {
         uint64_t in[2] = {
             crypto->gfm_result[0] ^ crypto->gfm_xor0,
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 42445e5526..c66cb63cfc 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -9138,6 +9138,8 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_3DES_RESULT_IN:
     case OCTEON_COP2_SEL_AES_RESULT0:
     case OCTEON_COP2_SEL_AES_RESULT1:
+    case OCTEON_COP2_SEL_AES_KEY0:
+    case OCTEON_COP2_SEL_AES_KEY1:
     case OCTEON_COP2_SEL_CRC_POLYNOMIAL:
     case OCTEON_COP2_SEL_AES_IV0:
     case OCTEON_COP2_SEL_AES_IV1:
@@ -9194,6 +9196,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_KAS_ENC:
     case OCTEON_COP2_SEL_3DES_DEC_CBC:
     case OCTEON_COP2_SEL_3DES_DEC:
+    case OCTEON_COP2_SEL_AES_RESULT0:
+    case OCTEON_COP2_SEL_AES_RESULT1:
     case OCTEON_COP2_SEL_AES_IV0:
     case OCTEON_COP2_SEL_AES_IV1:
     case OCTEON_COP2_SEL_AES_KEY0:
@@ -9277,6 +9281,10 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_ENC1:
     case OCTEON_COP2_SEL_AES_DEC_CBC1:
     case OCTEON_COP2_SEL_AES_DEC1:
+    case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
+    case OCTEON_COP2_SEL_SMS4_ENC1:
+    case OCTEON_COP2_SEL_SMS4_DEC_CBC1:
+    case OCTEON_COP2_SEL_SMS4_DEC1:
         return true;
     default:
         return false;
-- 
2.53.0



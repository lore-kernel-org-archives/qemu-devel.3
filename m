Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A3DCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx7-0005C4-Tw; Sun, 10 May 2026 16:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx3-00059k-81
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:37 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx0-00048F-Jy
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:37 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso2171775fac.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445633; x=1779050433; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8dcS161YO4yzbzrSMU2wdkumCMObSAwFm7ywTIhrQO8=;
 b=okJ/ti+bZWi+kMXAj+KPMehF3Dv5tO7OWUqG4rE1Z0SWiMKSn8yVW8kbq/uCrT8WDM
 SdQqA0dDbD3+DWajOKQJHmNXCR+7P+WsG+6uCYc24DukQ4NeZESiQSO9NIB/ZQAEQzn1
 vVS8XRGgYZIE9+CJ+xFfsEMsmIZzstg1tTMBifJ4HUb+nzj3a1ZcVGK0geRj0eAPmq/H
 jPjFQ1W6roOKGqpkFUevzFhUVLjVHli8GtKBXIlvtAphijbwO/Bou/1/ZHBLcUlmRFz3
 lxHMed6IpQ0T6uj8o93F+AV5H0RdVB9DMtLJsWY/HbYdSqb9MBfOnigOrt4P1AZpCJ/N
 S8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445633; x=1779050433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8dcS161YO4yzbzrSMU2wdkumCMObSAwFm7ywTIhrQO8=;
 b=Ei9MRQdS1HWRwAaBTyMWnYyhSJg/4bOmOt8fD1309L0ZtKN+YojXSBygu/c1t4yffX
 X4p8A4OIGCQsswC3yvzZZdBFrcw9+CgY6qkkrJKTFD8Rc5Wy9cn2zaiwjxFhG5bbOhyD
 tqpnNdWQjm9e4v59sLjt++3oBs4PzCZpLZyyU9kLNvzCyyLeS7FFvrvJCbqHt9VdAaIN
 2OGeLQ5tyElXygqUR8RPmP6VVFWF0mnbC0Xq/Lxr+5CrjuA5fhdsymUKFzVsf6rXRnTf
 Nd+qeBOjaOpjfhlCQmmAwbagrmTsR+JfcCMXkOhomLtn4TaL0SNZBanj2NZ2MaEUo65v
 McyA==
X-Gm-Message-State: AOJu0YzTV3LdzxIchSeU1jVCT6e9qZevzjZ1kxb2D4GpJbbkb4C5siwH
 QrSm9NOTxFiW5LmvafgHPDxf1xK/ILmu6VSHXH9klUmzWj/SpUcVRgoT
X-Gm-Gg: Acq92OE9rW0DxfBFH3+JWPtUYcZhUvvTNRyzZR5wnPRwpZKUpxk8PnMjMbApigcuiZK
 qoBTgv1lRVUU2hsUd23va770ub2J3ML9x+cm7e1epkyzHM/rMtoauvJ/IxOq/53RU+ki3a7P6kN
 +80Wq+zoTjGi1uzErhw25xdSay3XIR7KPjGNtOpGtpIcC6mYGZdrgFJK84yuh6A7Rs6tPGHWR5D
 PGUvNQRXCGfM+2z5+92+HUjfj9r3vmE7TUx17fie/rREV0UF7XXjVoVNQGHP7PM5zNcfhrSpWVQ
 vqOaa3AZbrgMQeqGS1unfb4AVr+rZxVHh9dh+sk/+0P5oIXRpLsuuxB0Q2kIOIUd0AGLS6PgRL+
 6/dMpgvPJeLgiehJxiC0XBhN2BX9xD8iFGmaf1qDIoLTDpDY9shTxCip/xSTW5pm6OVGMjFQz+n
 KvSanzusIqHOGbCjX9w4Sxl0oiiZCEj2kqqmItIgb5x4WW98gjitdso55AKJFJMUcV+N0FPHXXx
 vvKVIDPLXf8y7Ow+vJjKbzX6lIbBIRsN0RIsgrdIiY=
X-Received: by 2002:a05:6808:16a9:b0:467:880:7441 with SMTP id
 5614622812f47-480420c5348mr13477502b6e.18.1778445633508; 
 Sun, 10 May 2026 13:40:33 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:57 -0600
Subject: [PATCH v5 27/32] target/mips: add Octeon SMS4 crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-27-d5d2668d15ab@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
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
Changes v1 -> v2:
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/cpu.h                  |  18 ++++++
 target/mips/tcg/octeon_crypto.c    | 109 +++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c |   4 ++
 3 files changed, 131 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index afe5126564..6994925d50 100644
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
index 43012ff027..177d112483 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -12,6 +12,7 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "crypto/clmul.h"
+#include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
@@ -745,6 +746,57 @@ static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
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
@@ -1198,6 +1250,47 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
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
@@ -1614,6 +1707,22 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
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
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 800468038c..81042cfb5f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -180,6 +180,10 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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
2.54.0



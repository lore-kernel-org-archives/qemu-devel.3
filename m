Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12156CD484D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI4-0005Ef-R0; Mon, 11 May 2026 14:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHo-0004re-1Q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:25 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHj-0002ur-04
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:21 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4527323a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523798; x=1779128598; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0/032vP99ATvHkoU5QiV4MqnvzFbStDIRBlCxBkHCSo=;
 b=A9seZpXJvVpokoMD8o2DYLGwwUYiXkB1De+OBs94/lZmqRTw38KyNesST12PqvDKHr
 R/MZuATsb6ZhQuEJH1MWlWTpgN0j+0bxPLyA+xLLCm6Tden5XZVJkKt7ArRedVNrPdnW
 GJ9+Fi6WfSNakMeuE7MZuQaumwTpgmI5gSIP2ZWbME5Nubgt3nH7LLaI5VOYvLFlxYWI
 rDk1EviCFw8/DK1hfWf29hjfX3OFlz1paiP37hwa/5wQ4w658JFFqZejdPoQfpmNJSSf
 bvDEsTfTldnPsXdVVq6PksGLDyu/Wh6oni23Fh2H7wU/EJEuY8LEXCV68WU/ZqZWaDsS
 guZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523798; x=1779128598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0/032vP99ATvHkoU5QiV4MqnvzFbStDIRBlCxBkHCSo=;
 b=r+mzTZ82p7vHvmqKdiy0LHSV6ZHFq26mm39kKqI5ra5GDUSQAfffqOfBj2lbnyMKxC
 q9MDb1t3Ehnp3H6NXzsa5IfEEHQ3CYeGkcz/9/9zK1R7/XaOLOe27rKNLcLyqZIGHx4C
 9kKcyXwcwDm7GFyeoJzDbEiv6B/03MG3lFiVbui5D3r+d0E5hD7oFcE3/BCR3DcM2NbF
 Nne5TfA6I88xT2VhOJUV9Utmtg0Ym/iVKAfRjUjx7KAr6wG7/vNShUXqpeRDNx7gAF8U
 E4XE0zGmjOqSRqPehIXfdFirdteUFBkqkqrzBo+8fcNakbncdGXVQ0r6sVKLjk3XPN+f
 xTDw==
X-Gm-Message-State: AOJu0YwcK8BFIw/T4TZzKAmW0GfCCYPmDb1vT7JiOWsg5h4mLRxISRuK
 t9Bl0h+ej1yAEYLLFlcfcEq8vhlNyhmcJWGTVWvFNxLWTLBC9PFyaKhd
X-Gm-Gg: Acq92OFOY/4JscAb5J3+n71LWOpwK0gZ1kZMM8GjRgm27f6VbiEJIFenMUoKfraWL1P
 EoHJ3mLdxgYW2NXO9CfyiTjVYXaPP2Mu2dqz84iQ+wGcbR3XNTmirhw8dRax0u8TI/YluBYgKNA
 McEk+bS9masofHHUnIMqW9OyV/SmTATXJBoHRkG0yP68HZEncgv2fgrXh3L07B92aJ7qLGdkwcF
 c5efYNsn4qn2gDN6SV+2JtudtjuPfR2hIDgW+U9g77IAM4S1PgpIIY5DkkadAWqMLLG1JJqvmhe
 4mLlg+cGjqNowlN8C9hO0lLS2p9quWpDf+nsFihPOWkU/pJ+o8vAwDtsSccALo1U/BzpU76doto
 Ogs6Q6q+Cgd9fIVUxY3HV6D6IBLNPa7WT2AadKDZ2tMB9tMatto8TEGK4X/NKZvTxkEgTqOZjM/
 GqrBmdscYLEyZnd5OHoJJITaTK7CxVnrilTPOIN31BeNOAzr6VpxMU+2Os2CxEi2Fsfrw5zcAhb
 +Ou6f3fhnJ3P+cZhvIPiJdPCxpa6kKyUcTtzgTapASLh06EGqBZXZZ+1fXOWWfa/XuvfAf0J6TQ
 188=
X-Received: by 2002:a05:6830:6218:b0:7dd:e032:3ce5 with SMTP id
 46e09a7af769-7e3820e2712mr7224927a34.17.1778523797868; 
 Mon, 11 May 2026 11:23:17 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:59 -0600
Subject: [PATCH v6 28/35] target/mips: add Octeon SMS4 crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-28-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x330.google.com
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
RESINP, IV, and key state so the hardware interface matches the
processor behaviour.

Use the in-tree SM4 tables to implement the block operation without
adding a host crypto dependency.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Use RESINP wording for the SMS4 shared selector aliases.
---
 target/mips/cpu.h                  |  18 ++++++
 target/mips/tcg/octeon_crypto.c    | 109 +++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c |   4 ++
 3 files changed, 131 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e16f0f6e98..dc883bfb4a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -593,6 +593,20 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
     OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
     OCTEON_COP2_SEL_AES_INP0 = 0x0111,
+    /*
+     * SMS4 reuses the AES RESINP, IV, and key banks and only adds
+     * operation selectors for ECB/CBC encrypt/decrypt.
+     */
+    OCTEON_COP2_SEL_SMS4_RESINP0 = OCTEON_COP2_SEL_AES_RESINP0,
+    OCTEON_COP2_SEL_SMS4_RESINP1 = OCTEON_COP2_SEL_AES_RESINP1,
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
index 8b3260c4d6..2d2b19ad30 100644
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
+     * SMS4 aliases the AES state onto the RESINP, IV, and KEY banks,
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
         crypto->aes_input[1] = data;
         octeon_aes_decrypt_common(crypto, false);
         break;
+    case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, true, true);
+        break;
+    case OCTEON_COP2_SEL_SMS4_ENC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, true, false);
+        break;
+    case OCTEON_COP2_SEL_SMS4_DEC_CBC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, false, true);
+        break;
+    case OCTEON_COP2_SEL_SMS4_DEC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, false, false);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1: {
         uint64_t in[2] = {
             crypto->gfm_resinp[0] ^ crypto->gfm_xor0,
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 86e8c4b93d..fac7b8fa2e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -182,6 +182,10 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D618F8FA9E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtP-00040Q-GR; Tue, 21 Apr 2026 13:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt8-0003mh-EB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:56 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt5-0006hy-84
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:53 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so3007810fac.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792467; x=1777397267; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ME6KoWLBE0ODBY+GKyHQ9Gtlam6/znsLV6zes+dXvhw=;
 b=VEoAT0og+jfMiX3JRX/S5JoT1y29FBpJ5UUfGZ68aMARqu19Joz3m8vhlj5DCvYoag
 jyDfpxbHxk2e1lNA2ycqjFDAnJby3mQevoDgs3ZpIpAr4E4izBQpYcnOLLsh9vGq3oee
 jgYdPWvXca3RhDidkcVlyr5Lo02pY1an7lw+BLmcTet66k2AIGw6eZaZTEr0j9rbID1F
 zkJSIWeCYl61Pdgwe0Iq7hRIJu4qgBpsCD7rpbvcREb72dhL/FcuSGfme1REKWf2BixS
 PAU04TSqoznPXMpfoKB4yLqR6yOrOqN7xem3mKnA1t4XzrVseX2INSb6rKSSEzMbdnHM
 b/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792467; x=1777397267;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ME6KoWLBE0ODBY+GKyHQ9Gtlam6/znsLV6zes+dXvhw=;
 b=k+mRRn5OKF2tJZeBJWWk4b15iuYiB0b4Ft0ZSX333WIwSOn5Iu2y2Jiqv7xFpFmZ9L
 0YKlQFkbXS1Ke9iqmbBeKlafjH0IQ1j+4Vna3bxjnhEwyYzP0Glah3DLgNzleTtx1/s1
 Sj94yVJeWlL+PHl20qo/a/+i+XLqJFv4txGg+RvKj3oDQXj9y+34Xg9pWW3nGC0dVQwR
 jKCVIoRxAPL2qa9yg/b6oLY5VgVjhrqulcKFNdlLAoSupIi2+vGj9hCFI908/4axjEoY
 nDhp41BwePXAS9aPcM/dakyq90Ovf6MmEZ+/VDeTucOJP1ParKmTUacRgenXwCr7UsWF
 IrUg==
X-Gm-Message-State: AOJu0Ywolkdjfgq73vBBR7vCTKx54E1AstRCUijme+7j2tUwj2F10ktZ
 mbNYAHESPw87XPY3XtdYnTQMkS+hCuVO9z0Lw56IURtGypAM0sa1F+nW
X-Gm-Gg: AeBDieukyWyPsNcIcNgB6J4kWuot9wkEk66dKRWFljOjPz9YwimaYmQlHmB4AE3BiZU
 eoopAAWgUBt3csez2uL078VJV4664OFjK+1PXJr6dIXOBS1MVj2I+B/XxQI1nTef/RxJPPkcYfh
 HdXTRXVlnw+YS/urvsndOVsPDSEWNhy2Mz6D4KrdtcaIC78pTl7VXhKNT1PfchuDedVGoB39NMc
 w3vzS6L0aywUgfh0xsXinEqyn0uJ5HErBJ0vL3ECI+iPa6PKNs2Rj/UW/5PzajI2xZM2AVfZeHA
 IzTkklCdLJN/GchxYcOXrqWny61rZ2D8XDQ+EvXOXUHax4GLmSQU9Tz5hxPvAkE7iAtGHkfZ26Y
 dgF1I9Q8ywDv4kqW910YaGflyz6KwovUSx5un4/hCghSnbTESLFWpGNdg2tS4npYS7zPV4dyyqX
 kNpVcisS3SQL4iWrnYxaW8/JM5khCVCcG8ajcyRjn9k7SnRT0LsHsYhNu3BDlq7IucCKnyZiJBb
 7NLyJqdPzHVi4Pq6I36oibP87iRGc+uZ9rb6r9bnMhivBBfNV1nfrfXUXyfh3chllGoVJrnw7aq
 cNJOaQ==
X-Received: by 2002:a05:6870:e997:b0:42c:24f6:f190 with SMTP id
 586e51a60fabf-42c24f724d4mr2765105fac.17.1776792466585; 
 Tue, 21 Apr 2026 10:27:46 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:35 -0600
Subject: [PATCH v2 08/13] target/mips: add Octeon SMS4 crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-8-a0791df188c9@gmail.com>
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
index 9e398e1ce5..887aeff12d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -585,6 +585,20 @@ typedef enum MIPSOcteonCop2Sel {
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
@@ -653,6 +667,10 @@ typedef enum MIPSOcteonCop2Sel {
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
index ac5065398d..84fe3b38d0 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -186,6 +186,10 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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



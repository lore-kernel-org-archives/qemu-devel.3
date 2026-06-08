Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05228CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCw-00010h-1P; Mon, 08 Jun 2026 15:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCr-0000zA-Ri
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:18 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCp-0006f6-FL
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:17 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6ec655c80so2525570a34.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945212; x=1781550012; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XC3KOmfiBf3uOHhOBkXrSekokX1Dg+EUGg6cXmaFlII=;
 b=Gybhdxxc612HK7ZDVc4QRSZpNJkQKvUyWhM6gHmFHbarwnCoN5CHaEdLuww6kUkoUb
 0rqC84UQSa2PsDklZ0PrxdixoTSEpeFiEy8DOSRPP1x0rKPBSaw+jzGRh9bBdSJayyuf
 xgNPtQJKM0jDDzqkWDgs9uiNRvqZ0PDYb6spD5RDKf5muzDcOUq/0ljsBzoLtHuY/Wuq
 ULGBhM1vmMwW8OkksQXcK5weU5ii2SuIFkCr1LtJEsdO5BgIWI9DABgoRO/OkOPjkEz6
 Tush4kUCaJ2oox0pJ8J2cjeE5d5mIRBcknI4/B0Zan+oqxP5x6qyRUZmidbjwsgZcJC9
 oiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945212; x=1781550012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XC3KOmfiBf3uOHhOBkXrSekokX1Dg+EUGg6cXmaFlII=;
 b=H+jwMSfkamtCbQmW2DBzoViVoF2bhRfb/hteSIa25JO3aeXnKvY9oj+FQrcY7hYy2E
 eMMotUijf5pZ4Hx6YRaccVQB3pjRsLnQBNJ2P1eWA46LxURGPNaVs8meMBJbM2GNzt4h
 1sMidumeYTVgXFuXPx3BKa2QW2MnCNPGdPjJLaNxPlKf9HVLLU25vbsCZhZ53nJn/z8/
 PUifD3u5pbKgGHJVko1lU+RvgduEHl2GtGMlZtZ+XJa6pRI/AjcwER0OY45xzXIWYimV
 ZcOE0vzzEgQmXem1sGS/+VCC/y4t0wIZY4nZaTf4UcM9wMpIxa3TW/dPeN2EnoSa/7yf
 W9vA==
X-Gm-Message-State: AOJu0YxQvBDspGSseaSXMdA31vl7D5zSyKT61MDxvCZrjOcwWYqvXPzn
 NSCtIZNhpuSqM+TAfP/59WkXBhf+gioQWrSbFyWrHTpCnJqQ/DJpa6XNZGKxVn+4tjA=
X-Gm-Gg: Acq92OHpGiHF6ZdXRnUcq966xyN9yoLa3BWFuu6lx3cJVMPtadYH5t9Vb9b72PcNm7D
 uYsoUtEFyKQ3PAlLOmrICcj/D222xcw7eQptCOfbsj/nseOU3jmpXz5pz0BdrvssUiZ7R/zc7xA
 A20JbjL5D2JKDJvw6eRCHCQXLNMVrl2Mo2YPb+0io6GzhaISuS/QN0uAT5xO37osatgxzV+j4ZZ
 4T2mOZMSJs27SDAJcPDNxxeJ1FrrBbNDoGuWxcbVKpzEASK5OCqAEUqreGGjMpvdVT5mtuGfESd
 hpIOr62XGnfdaQ/w3cs9+5RFUtkjBwI+wF1m42HKm/5IiZ9yIgivG0lAk0OmVLZsTsUyfCr97z/
 wvXtQv/3LoRpUzwnab8vxV7iawV/vxbGK91xKGJ5GmDgnkSBs4pJUK3gdpmgp837vj8aQbo7dQK
 daBJyIGtaz81qXShMOUziUuQIezerVku4Fu1NUXvXje21Tg5C2UCYPLCBQ2PP/GqVAOMd+U1Cdr
 NV2uybKZyTOEg552Z1T5p4eh1g7w+l8rjPfNMPYnVE2B413AX4BxCTFSnucOlNzSWJHHq42IKP/
 mADc7s1gO0g+DlDhgGmX7gRwmaooz4JY
X-Received: by 2002:a05:6830:2b0b:b0:7e6:e349:539a with SMTP id
 46e09a7af769-7e70ca9cb5fmr10197266a34.21.1780945211896; 
 Mon, 08 Jun 2026 12:00:11 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:33 -0600
Subject: [PATCH v16 08/21] target/mips: add Octeon AES COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-8-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x333.google.com
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

Add helper support for the Octeon AES operation selectors. Direct
register-transfer selectors do not need helpers; the ECB/CBC encrypt and
decrypt operations consume the AES input, key, IV, and key-length state.

AESRESINP is modeled as one architectural register bank; operation
helpers consume the current AESRESINP block and write the result back to
the same bank.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Drop the non-architectural AES input/result split.
  - Model AESRESINP as a single architectural input/result bank.

Changes v8 -> v9:
  - Split AES operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation AES helpers.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 145 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index c4e7693df6..39c226ded9 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -52,6 +52,10 @@ DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_snow3g_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_snow3g_more, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_enc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_dec_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_dec1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index b8157c9a8e..3de7ad31bf 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -841,6 +841,151 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
     octeon_snow3g_queue_result(crypto);
 }
 
+static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
+{
+    enum {
+        OCTEON_AES_KEYLEN_128 = 1,
+        OCTEON_AES_KEYLEN_192 = 2,
+        OCTEON_AES_KEYLEN_256 = 3,
+    };
+
+    switch (crypto->aes_keylen) {
+    case OCTEON_AES_KEYLEN_128:
+        return 128;
+    case OCTEON_AES_KEYLEN_192:
+        return 192;
+    case OCTEON_AES_KEYLEN_256:
+        return 256;
+    default:
+        return 0;
+    }
+}
+
+static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
+                                uint8_t *key, size_t keylen)
+{
+    stq_be_p(key, crypto->aes_key[0]);
+    stq_be_p(key + 8, crypto->aes_key[1]);
+    if (keylen > 16) {
+        stq_be_p(key + 16, crypto->aes_key[2]);
+    }
+    if (keylen > 24) {
+        stq_be_p(key + 24, crypto->aes_key[3]);
+    }
+}
+
+static void octeon_aes_load_block(const uint64_t regs[2], uint8_t *block)
+{
+    stq_be_p(block, regs[0]);
+    stq_be_p(block + 8, regs[1]);
+}
+
+static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
+{
+    regs[0] = ldq_be_p(block);
+    regs[1] = ldq_be_p(block + 8);
+}
+
+static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+{
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        int i;
+
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        for (i = 0; i < sizeof(in); i++) {
+            in[i] ^= iv[i];
+        }
+    }
+
+    AES_set_encrypt_key(raw_key, bits, &key);
+    AES_encrypt(in, out, &key);
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, out);
+    }
+}
+
+static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+{
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+    int i;
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        memcpy(next_iv, in, sizeof(next_iv));
+        octeon_aes_load_block(crypto->aes_iv, iv);
+    }
+
+    AES_set_decrypt_key(raw_key, bits, &key);
+    AES_decrypt(in, out, &key);
+    if (cbc) {
+        for (i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, next_iv);
+    }
+}
+
+void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, false);
+}
+
+void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0



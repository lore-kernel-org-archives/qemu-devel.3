Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13709CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJC-0002YX-69; Fri, 22 May 2026 01:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJA-0002WU-Di
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:28 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ8-0001wY-Gx
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:28 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-485433a6889so377142b6e.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427225; x=1780032025; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W92ESlapdyO9qH3x4Uam7jTzjBzkYRQhK1ViYpc9r4U=;
 b=g0kFnEtICc68hndhfnAOTp76m+as6uNmiIA3puVLLgLgAOmAQhqHxjXvOeJJZaDea2
 WF96R7hn9t+pisfpucAIue9eZ4PyVGtUByOp8IE/IXYMcUtwv1pbE+KsbDn7J/M3MIEC
 YiYQ+jhhtiylIUuNnzjPRWuaTeEG03w/etg/Y8TttrdIA/nNgbR8fTwBWwE+zP2UCk14
 MVvzxrs6eEc9WOMG54t08XhLIShb+w7a+OIBngt8R0r+ThbV6m5Hb0NrrrrAIY5mXv+T
 v71poduD466wfg5XqRy1FDvsKv0gik/3ihPlY+oC1QJp70Dwmkp8InoNc18Jy1RpsWaz
 h3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427225; x=1780032025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W92ESlapdyO9qH3x4Uam7jTzjBzkYRQhK1ViYpc9r4U=;
 b=rsLXYH1NqG4+EXbnROF2tdoUhLp9qN1N40Rj46Ud/z+pMKNhTMAaliYz3VB4Mebg0B
 BC8hIsgw4lSUpVUubfHYwGOKmL9ZXsqSI9KOmh35DtmqmnBVKljFPHZ+/BYp0Jp/0LC1
 l3mxkT3zlP2jyt6BRxHloMkK1/sPyC054o8fiDZukCC9jPDFEQfY1DNkOZFp1KzAMpRo
 eU0sjjLr6e3seXQnbBR8KGm9Fg+S7Vk+Mdd5lKPwU3t1jOW0/f3MAvoLIFGd5AW5P9UZ
 /tX86dG4LBxhkKP7Y/MfR3kpQwD/FKNZfMETmwViCHsXZi2dkhsFs4WYdWwjENAifgPW
 lD5Q==
X-Gm-Message-State: AOJu0YzW8kItxx4hUEcp+xRLewIPyCgQhCOqQS1b7CALK35y7O9yT3C6
 riGc5mJeru87/RNFC0sgxJZklt/avXNsxn0beubA8Ot9JUN4GIJzMFc6
X-Gm-Gg: Acq92OEYNdCAZJxo4o4TF6IAsBz3fDK35vKjeY2+HjDEYF5mlHBWzyEGzfA/JU0UDWx
 ngGsn6SSKiW5b67Pd/VqStd0SNbtVPmWfq+qcq5X9fhCZJsp4oXlixx6X0fwfhnKRTit5ydeYqV
 X6TmmB2+IPC9JNTSa1u+k56g1JoxsLOx3DWNQB7GEpM5qb7Iy86Fq4JUn5kevdwVS7NaZ+gjHVo
 H11qSb0Ym4bKOvj2Rw7JOqwde0WFO0IyRAcgKQnBH54bTwoR+t0DWVJ0aKu0vjujfIp95anflUk
 PMurDkkJIz4GN4kq0xaisWjZbYQ3fTvVgZG8oNnkO7Jy8IqpM9uWwqrT41csGTsxNNgmGqMg3NB
 qS2uDGAIPoTrNGiUBVX5ha5iHBsC6U258y/Cb6bosPy1yTBUpFVEhGPn30A5hq/GQcydr5yu7R6
 mFDfjlIK50G8UUhussQDO+D+xx9T2BHWm+99LgsB/zDzrVNbuaKIE0QUdWbB60SeV9ecFqfNT4a
 w34FCiCm4Gay/rkFLW9sEHtRbxioXpXLwgd8o3uPRe5FpSyTBqp6MhRiq6Xr5wyv1E6
X-Received: by 2002:a05:6808:30a6:b0:479:dcb1:dce3 with SMTP id
 5614622812f47-4854994df1emr1133049b6e.0.1779427225327; 
 Thu, 21 May 2026 22:20:25 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:52 -0600
Subject: [PATCH v14 10/22] target/mips: add Octeon SMS4 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-10-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22b.google.com
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

Add helper support for the Octeon SMS4 operation selectors. SMS4 reuses
the AES RESINP, IV, and key banks, so the helpers share the existing AES
state while implementing the SMS4 ECB/CBC encrypt and decrypt operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split SMS4 operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SMS4 helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v5 -> v6:
  - Use RESINP wording for the SMS4 shared selector aliases.

Changes v1 -> v2:
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 124 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 1ab644bab5..64bb3ff8a5 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -78,6 +78,10 @@ DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_enc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_dec_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_dec1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_enc_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_enc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_dec_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_dec1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 419f65bd29..64b553392a 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1032,6 +1032,130 @@ void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
     octeon_aes_decrypt_common(crypto, false);
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
+    octeon_aes_load_block(crypto->aes_resinp, in);
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
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
+    }
+}
+
+void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, true);
+}
+
+void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, false);
+}
+
+void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, true);
+}
+
+void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0



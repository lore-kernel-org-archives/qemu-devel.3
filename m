Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C55CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJC-0002Yu-U2; Fri, 22 May 2026 01:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ9-0002VB-If
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:27 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ7-0001uS-Hh
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:27 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479f7e75a6bso2647061b6e.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427224; x=1780032024; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kquL+4fEmdOa1jgdWKrGP/ZTDBa1OlSfyNf7ARwi0dk=;
 b=WmyL18/ul9YCtJVpR1fnkcQJ3w6dNA7zUa1pF/3AC+u8dsRQ2bte6Gll2NT+yZUKAQ
 l2CYvAiQJ5YarSCGLuxUKyb7Q2dj/q5Km4IT8fsoEZCvCTnqn8ot0rEuaJKJpHd5hrcT
 t/aBOVPjcaGUqWEHaXvf4ID9UjQlyoR4Fy4S2oyBvaGIKKJon+cMMnTCILs4Cso/hAXK
 tZ6dx1gQlirPZvwSArRuae4fC3O6QRmyL8nCSdm16EArHnL1YOrhsmkeBFPgzlRaFjbJ
 1DU8ck9DH+boIySDUDaTvknbyfxgmP6+n1Jqxx2p6bOEMYzrNzt9w1LB6Mbq4F67l0Wr
 Ng7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427224; x=1780032024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kquL+4fEmdOa1jgdWKrGP/ZTDBa1OlSfyNf7ARwi0dk=;
 b=kdWZ9VH5Jwfmep5OULKmVlPETMriLb+GzgD0SeN3jhwt/hRWncu8805MeYV/WTanFd
 P9ohTJQ79odYJxhKdeuCjUrF3gDrABXV7pf2U1uSiPOariaKcuXJ4AvzeVX5YyrNags4
 WvVkPx+bB805NsKBPXCpK2S9vW9pH5eDywDaiNvhSgc/6SaoAuZz0CCu9T5IGRFR4BBf
 ZOuEQbqvCZBhK06oDlDYmTwkDAq4hwcu4KKffreMAJ4dTBqHcDpUIIZ/mPWuEgXxzjnz
 P49X4Iggo+HBKa5UOod2ON1GWlUyfRLZKyku3fRuCKL62/68mF7OSMj+5RLsGmxYCf7M
 CFWg==
X-Gm-Message-State: AOJu0Yyc98YqPI+BsPzZmpaCiAzzzqh/Wyf26tDZ4G1guyPpcr0wqorC
 kDoSHNMsV1J3szR1IZ55or3jP6hHJteWTCTR+2MikvVNcM5NRoAQL4lp
X-Gm-Gg: Acq92OGUpktLnx4csxUJvOvJ4FTQZctVPyGzI0Y1GLZE/2CH5Y2o1DCRf86/Uq35Qlc
 yn0bE64pnv7WsXa8qGYzrAEX9I1rOfx4kuDEd9LVaBwCerbM+RAyNdMx4pJHQTdAhC1TRSPoONO
 c6RqtrjC00SASziWhF4jc/Wct9Mwf2F4avx0WOh5iEqU7DTAgRPXZTdXw9PnrRt4uWwdPtw8rKx
 iV3aRm8jTXTgsit7kbmI0GLcb6/HQ8PAvunv9XKyVGHDBLKve5EGuDXHh0AGISRO2AZdafdnfCf
 l2B91kQrGvcMECElY4/ZowAZPkTMkkPWl5VgYNYof5exJNlLsyCK2j4PSq9bIdV/LdkY3Zdhex8
 l0EFpBRTYbls4SDhqb+0rtZZceln0UQm0KIP4xoMgd/98xuiOJyHVKTklW3Le6uz7/ifWDNk+YY
 K3/+Gduzxb37KRKzJ9tA3rxHktLtJdhVPJzIrG84wx3lMnwwiKq8CFU+Po6Jf15AY4gntGKLhBr
 F0wB0I77YLH15PdoiW6jTvMxpJMCT3I4/BuditWGmWfgaxKV1/Iq4hiChM1tfaGuJkE
X-Received: by 2002:a05:6808:6f91:b0:482:4741:5f57 with SMTP id
 5614622812f47-4854a28a7c1mr1153869b6e.40.1779427224074; 
 Thu, 21 May 2026 22:20:24 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:51 -0600
Subject: [PATCH v14 09/22] target/mips: add Octeon AES COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-9-fbf08e164830@gmail.com>
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
index 7985083e6f..1ab644bab5 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -74,6 +74,10 @@ DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
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
index 2610f7224a..419f65bd29 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -887,6 +887,151 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
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



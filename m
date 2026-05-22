Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF76CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgK-0001jJ-8P; Fri, 22 May 2026 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVg8-0001ft-VP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:05 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVg4-0000TH-LX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:02 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-47cacb4ed99so4889678b6e.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478619; x=1780083419; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4cvv9uFzIlix0aHZHW7IXUB7h+HGXq8FdmHAt2uF7zY=;
 b=Rih0xTkcNaGcIiZdYXZs2xnBB6DEo1t//3SrtfTl7C9t/dIwmCW03VOEoY1p69+loN
 LE+vUHnHePEoz7fhC+KaQUt7kWGNvA0BaF+1NCje2VpamSpr7y2V6Zs5uZwhd0Q5horB
 YPeWIRr37Z7UM/YkyrqP67NrxnFD/0VHUNAB+vbGCiI2bHFV7q6w0lF2MxfLRAs0/O7D
 ileNZ/1mip1XFXSMsRsq8DypL0eAo9B/+o+v2zHVwxlY7oMl/+kEG1TyQcpJx7TqWmnq
 lvpW3RtOQiqWwhtau8txrugLVXgl4NrHQ+oUttJ7NoP6ov5QPYzm/F1AKIa9WvV3YvPB
 4ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478619; x=1780083419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4cvv9uFzIlix0aHZHW7IXUB7h+HGXq8FdmHAt2uF7zY=;
 b=fwR/HhRj888MfnuhI6jQGVfWgJ3fVya8XRPWb1HKGqFdLrJQmAz0wHDkzI2ia0+hbp
 1tWCegSa2Vz2LGYbYEZmGj6GuYEyjDAPFkztUZcAEc/efqaq3ZCpFy8vPlgQ2k53uTCk
 yjzWWXg8t8OXue67mDH7km5j8JJii9OPpWFczE3iaOahjY8vicMyb8NkL+WElUTqzuYQ
 WEeRChjp1ScACOFCDLEb14YU9Bzi+ku3Tsy9prWacj1zdT1nrGIdLUX/XU8x7IUsmx3B
 JDmn+gB363mom5NO7r2A0v718CoPZA9GjyhY8hBJP2Ptb8nQ+W/aoN2aJZewQgG5rFA4
 33pQ==
X-Gm-Message-State: AOJu0YzIIBZ/si8uskoBHt5PBPtA8bhsyS/Kw2C7M6wwiZ6ufdiwiwLv
 oZPhgj9/+BkxXoWkmmNceNliuAwK1r1D5E4Fj2PV4cv9hzX5+1i85zJp
X-Gm-Gg: Acq92OEIOC3hKdX7yPq5JSdVolYLJgw8t5Bom1cAVsW15jsLNyaOIoI01H5N1jauSbB
 +x63nCVhgtVd+G3DSq7Y+HbY1+TJa7aC+Wz1g6lMZfUN8yxyPWoUVizZZIgFcdRfS09TzhC/qRg
 RFjSZNslHQP59TVxuP+SlxorCh2hCvSYy3z7it7K+4170eLByLnzebXdAyLTrEtIs5mi3jLCEpb
 4ckFneoXerFDq/bbeu+MVqxwdnEkqgRz93KkRR41ux4wF3jsSG8JQNuk5/t7fvSkc7toNlWs2fq
 dTv/Pc8OmDG6uVTcT2NBHf6KPMNv2flUz6Y4YQwuVOZVTsiZ4hB4KZrtgRmLgt0fmmVyQdhAt5V
 e62kACeTWRLoj78i6wxNc1TK/hLTJUX3WjchPej7VqgeiIBA4e+IUTSbmCO9B4wWkDvu0CSM7iD
 P+3EGM7IXIyEfOq9p/roFZ9m1RUgwMOxn9Od7AHpN6SeVxpMM5oBdBqYH64JJvfItcZKNirx7vL
 HitRkYsTE3o7L56GloNBOASJdyfw3FxmPEYVyphdMe+2hApIPKGSZbEF8QhKZxwcnAp
X-Received: by 2002:a05:6808:4f53:b0:485:4396:91a3 with SMTP id
 5614622812f47-4854a3b9ed3mr2821796b6e.30.1779478619114; 
 Fri, 22 May 2026 12:36:59 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:41 -0600
Subject: [PATCH v15 10/22] target/mips: add Octeon SMS4 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-10-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22a.google.com
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
index 39c226ded9..4949b94657 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -56,6 +56,10 @@ DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
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
index 3de7ad31bf..abc16754e0 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -986,6 +986,130 @@ void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
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



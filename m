Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D77CD5BAB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDn-0006lQ-AJ; Tue, 19 May 2026 12:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDk-0006js-DD
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:04 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDi-0000my-If
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:04 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69b94acd958so1926119eaf.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207781; x=1779812581; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bPx+cOwWltjcaeaYn7JciuYK27ATvwskbHY6d5rI1oE=;
 b=T4hSiv4ZlV+8XLBIIO/VvmDtJ5eaEqomU0RFR9zjHucYLJFNPhyAehTv4KSq/STyEO
 zdySz9PYP1aXWksJvDBd16e2XFq2/TTF7Wfz3rnVVw3JgSizDXAuyR3wXbqTtRme+SCL
 iVkXHkwhNIQG3WMGzY/ABtE1FJxKGQIdHvp7c0c3FPVSC9wR9n04pxw4MFIautas6Uhn
 gml1KLN/8YzDrV46PTNQn959+AZA3KngVFiMBxrO0U4NnVMWV2Pa0wXn57gXyLQSBK4o
 2G2humWKDNyOsKpLclVCSTGz3FkKLPIivcvBDSF8e78YwnI4hHJQ7Dm6nR8nZVYLnd9Q
 2osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207781; x=1779812581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bPx+cOwWltjcaeaYn7JciuYK27ATvwskbHY6d5rI1oE=;
 b=kXiNd9ifdkczJ8uDmfENyMjZecz4lNwMrBMugV41jlqTe/jfk3DT7A/FUl4kX9XaqG
 pnOG+Uun+DoiyG+eefMsPNE5eXSv+gTd2ZBAOxFJAj0RoLod3ig+T6nvWcjUsdnAac3D
 FQkSHc66BYRcUAd1HeviW706bq/Lu6NHy7yT9GHtlgstSWpBe009q9oua1smEbteKHl5
 M/fSEEFzzsMDp3f6dwlar08+UTurZkawkEwx40q6r17g1WqNaxOh2JlOopW1Jv/25ZBw
 LmLwrfAUiMXQGoLLpZACSKUIGU3e5pNzH8JlXZYgTbPbjcH4QhCkuZ6Bi+2WOqDhUh1V
 RU4g==
X-Gm-Message-State: AOJu0YyzCpf2vSLvthamanVzvzjLllQ7L8QQSB3wOnWQ1JU87Yyh2dkY
 NM80zTnTvXcIPyCKjBTsKV2EBf8FZ98wMLmD+MCy7cn25bZoLbsKSTPJ
X-Gm-Gg: Acq92OFgQHVL7dy2yL9Z7lyNAVoE04d49Lfx0ad3C3KMbHZO7BspmGE1xcPoeMuwd1L
 jHTDHUTHzSUiuB+PIvXlFMgKL2NUus/V+CEJThCsKjFyY0K9qIVrmcfne9hPwudCyKicAAuTtFT
 QSJYYZ4ZB0KD1u/H89QJ/IzmTpBpyWq2O56wL2nv/N5ViZCVyJ6r5b3zY4cLPN7iq0XT28i0lP7
 v0IvwbGbSyhIZPyUW1YX8lZ/5cfDg08BmH/JsjnOdhMlgUwv6CviWgKjHSjrrC9LVzXpKr+ceMF
 P+XMreE/rSyXnqo1moGqSQPHhWS3iWU7smnnEAFHPYLyj/SaIj2j0OVi8Cg2xEFw9z4Ho6DD6sV
 X2jqh8HCKgt7Z9nZFE+rxEFlTQF9TWCGIuTuKYlsrVspZvwxC54k1XxuGeHSTt/G+CE8xUz5wOa
 BD8AulgdkA7lT8hjEW6QgxJcVUVbTj04SghvyUe3UqPx0ybI6uq71iYJ0wsoSN/0B9hYqOOic0Y
 CleXAymfSqqlKnuFfj3CNcaQ8QMBFYOmO2o5aPUNNMkkGY+32BxuLmyv4YFU3TwCunY
X-Received: by 2002:a05:6820:81c7:b0:69b:8c27:8a0 with SMTP id
 006d021491bc7-69c9bfcae95mr13374879eaf.55.1779207781119; 
 Tue, 19 May 2026 09:23:01 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:28 -0600
Subject: [PATCH v9 26/40] target/mips: add Octeon CRC COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-26-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2f.google.com
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

Add helper support for the Octeon COP2 CRC register interface. This
covers normal and reflected CRC state handling, byte/halfword/word/
doubleword/variable-width update selectors, and the reflected IV readback
operation.

The register moves that can be represented as direct TCG loads/stores are
left to the later explicit selector decode patch. This patch only adds the
side-effecting CRC helper implementation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split CRC selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  14 +++++
 target/mips/tcg/octeon_crypto.c | 128 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e2b83a1d19..e802f50fd6 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,20 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
+/* Octeon COP2 selector operation helpers. */
+DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_word, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_byte_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_half_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_word_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
 DEF_HELPER_4(swm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index f9b54f7017..b79ccdd162 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -35,3 +35,131 @@ static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
 {
     crypto->shared_mode = mode;
 }
+static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
+{
+    return bswap32(revbit32(v));
+}
+
+static uint32_t octeon_crc_state_reflect(const MIPSOcteonCryptoState *crypto)
+{
+    return octeon_crc_reflect32_by_byte(crypto->crc_iv);
+}
+
+static void octeon_crc_set_state_reflect(MIPSOcteonCryptoState *crypto,
+                                         uint32_t state)
+{
+    crypto->crc_iv = octeon_crc_reflect32_by_byte(state);
+}
+
+static void octeon_crc_update_normal(MIPSOcteonCryptoState *crypto,
+                                     uint64_t value, unsigned int bytes)
+{
+    uint32_t crc = crypto->crc_iv;
+    uint32_t poly = crypto->crc_poly;
+
+    for (unsigned int i = 0; i < bytes; i++) {
+        uint8_t byte = value >> ((bytes - 1 - i) * 8);
+
+        crc ^= (uint32_t)byte << 24;
+        for (int bit = 0; bit < 8; bit++) {
+            if (crc & 0x80000000U) {
+                crc = (crc << 1) ^ poly;
+            } else {
+                crc <<= 1;
+            }
+        }
+    }
+
+    crypto->crc_iv = crc;
+}
+
+static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
+                                      uint64_t value, unsigned int bytes)
+{
+    uint32_t crc = octeon_crc_state_reflect(crypto);
+    uint32_t poly = bswap32(crypto->crc_poly);
+
+    for (unsigned int i = 0; i < bytes; i++) {
+        uint8_t byte = value >> ((bytes - 1 - i) * 8);
+
+        crc ^= byte;
+        for (int bit = 0; bit < 8; bit++) {
+            if (crc & 1U) {
+                crc = (crc >> 1) ^ poly;
+            } else {
+                crc >>= 1;
+            }
+        }
+    }
+
+    octeon_crc_set_state_reflect(crypto, crc);
+}
+uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+{
+    return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
+}
+void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
+                                               uint64_t value)
+{
+    env->octeon_crypto.crc_iv =
+        octeon_crc_reflect32_by_byte((uint32_t)value);
+}
+
+void helper_octeon_cp2_mt_crc_write_byte(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 1);
+}
+
+void helper_octeon_cp2_mt_crc_write_half(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 2);
+}
+
+void helper_octeon_cp2_mt_crc_write_word(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 4);
+}
+
+void helper_octeon_cp2_mt_crc_write_dword(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 8);
+}
+
+void helper_octeon_cp2_mt_crc_write_var(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_crc_update_normal(crypto, value, MIN(8U, crypto->crc_len));
+}
+
+void helper_octeon_cp2_mt_crc_write_byte_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 1);
+}
+
+void helper_octeon_cp2_mt_crc_write_half_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 2);
+}
+
+void helper_octeon_cp2_mt_crc_write_word_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 4);
+}
+
+void helper_octeon_cp2_mt_crc_write_dword_reflect(CPUMIPSState *env,
+                                                  uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 8);
+}
+
+void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
+                                                uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len));
+}

-- 
2.54.0



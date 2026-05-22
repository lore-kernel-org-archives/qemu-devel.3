Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E109CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVg2-0001eK-R2; Fri, 22 May 2026 15:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVg0-0001db-FZ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:56 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfx-0000RS-2w
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:55 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479d593a0c3so6511240b6e.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478611; x=1780083411; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=99YbXwU+QZjVpPSGzU0gdv9rBjyJynqi/nBLawDCdQk=;
 b=BQeuwOV+JcFv948Vg11IgDjUo8dFxa/MSqWGZKAdYqmlIynAQjkUbE+vNnzQ2CBdv2
 rNIQxbcmLPG8RHe0E6OGOJotNoTIpdVp+P1ne1UgAMphlhsnF8/YWIVvxn5BBmXeXfYm
 M73XFxNZWfbc4fgj9302B2BLolg8VKksVlsI+hf0T6wbrWP0QNx6SprNRxC5B/0YHS2O
 OdW/hZozQ7Fjpq4Xf4sGVw8mtRwllbqP/f1iSNhrwN51B8ty2ZADPMsUoAJadIoGsqmK
 OVJah7lGX5R1vg+wwnuUKvGlrLnFz3j7/znx8xU/ehT7mcwKjrHxx8TSYLq8bio3jFGg
 9zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478611; x=1780083411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=99YbXwU+QZjVpPSGzU0gdv9rBjyJynqi/nBLawDCdQk=;
 b=G1i5euFtdWLkadA5c19eQAzzdOj4xZqBRrymZrVniOcrRMaLjgTTBpKHtL+zvzFhZ2
 GJGTleDkAV4U74FZVSddp8hF41HOzv9QOTZYDljlq2skftPNzZUr1EmXuV2RmHswQoX8
 JW1AoRgZCT4ZQtqKCigDM2pZlcLhTNV8a9UfqdyEWLHUTop1Md+WWynfFIJGVJqBPh+V
 o/kwvio3dL0AVAPoddsLqN4QMSGwCRuk3cDzVLguwUJMw2U1HaxVAlXqK3Q6LvfOaGDy
 nnQJ5DgiTV8nZRzt/oJuNU6E4EZQ0h7xP6sU5gmyfBY5PeZdQQRB2NcY5dl2U8H3ipdG
 koaw==
X-Gm-Message-State: AOJu0YwvVla9Lj7IDQOIzVIqAjnhsKWa/uZwXdNSPYH7gAKooBOvwi/t
 MboZmbibSMNHnGK2Q9pMpMkFVX55d845sZlb2dt9oqvPvIDpaS1txWmT
X-Gm-Gg: Acq92OHlcBqkCaBjVFfmEz2wXvhDTWtbTTd9C8YjOEu+ztLhFMi4yLLNGAYRV06/bJI
 6j3zzCgf1bGiGwTno/S5o1KLxDwidA656yFX4kyqBeJDD0CAEbkEEDzB6zrTTqZq/8YkkFuGGNF
 b27izmrBe9jPX0l7f9ldyH3Pq2lHXYejfaEzFOMZkGYRILPS/6Q4eW5eOTuaYosQk9yqWF0VvOl
 z41WK2+yx3g3eX7AcF/syTado34v7t3wf17gZfjmZ4weCMPDxMmJlOd89aYLHbVXL3IUR0P9rKV
 PkMeE+oETaq1/eMN2tcEUdLEtwx6KNSb93yEUXaLx8KgMnNfhA3l6Dp00QVPIsNtlbrpalM5by2
 hJhSPTYCGy5H1N/8xF+G/oo4miCFBip18LRws0PLJihpXc8D6wZmvrEuT4VtkNu4VA28laVFl22
 7PMboT2qNhH6HwcK//WQAas8aeZJJH3s2bK4cy0VZDXHWz4bSO/8zVRsVZ1paUsxdRIU4rnkBV5
 y1Gly/DSH3lVogYK/QrrOawYkulDfnnZpar5lTnhqGyACdZqQYk4rzu+SIpZlauYR9V5SQf56dT
 +Zk=
X-Received: by 2002:a05:6808:c2ab:b0:467:e3d5:8389 with SMTP id
 5614622812f47-4854af1067fmr2179458b6e.20.1779478611548; 
 Fri, 22 May 2026 12:36:51 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:35 -0600
Subject: [PATCH v15 04/22] target/mips: add Octeon CRC COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-4-f8731a588dc2@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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

Register moves that can be represented as direct TCG loads/stores do not
need helpers. Add only the side-effecting CRC helper implementation here.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v9 -> v10:
  - Mask variable-length CRC writes to CRCLEN<3:0>.
  - Add Richard's Reviewed-by tag.

Changes v8 -> v9:
  - Split CRC selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  14 +++++
 target/mips/tcg/octeon_crypto.c | 131 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

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
index df5b0449ae..811f36f46a 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -14,3 +14,134 @@
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
+
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
+
+uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+{
+    return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
+}
+
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
+    octeon_crc_update_normal(crypto, value, MIN(8U, crypto->crc_len & 0xf));
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
+    octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len & 0xf));
+}

-- 
2.54.0



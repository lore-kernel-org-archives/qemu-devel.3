Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE80ECD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDq-0006oo-Tn; Tue, 19 May 2026 12:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDn-0006l7-0l
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:07 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDk-0000nI-Pi
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:06 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7df05fc49e5so3961421a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207783; x=1779812583; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+LF/w6vZJJy8YuU4QSMXlfWK8+cL6bD/zaog2spGsqk=;
 b=HDB4/joB+cQB69aAQ4zTEDc7daL5ffJurGiWXlTTzqsBpDFn2Anu7MHasQkRUH2zh+
 FJKZz8vyjlCeJMnlDDWzzqFCi9Uqn1mPFzy3nS1/ZbLBaK6AM+p9jhPRrBrJtLPRQWbK
 NRn4mDw6RUY9qJgEZ2FSiACqYA9qjsVxxS8PqfKcEPeCqO/msIZPTz2QJkj7b5kr+orB
 TfVOze0K9T68izOp6bVjwMarx/H6a4Pkv9I2IJC4wF9sTooUcvYAsITe+SPsY4MuOEha
 0oIf/Tb0DBC8rVjBY1y+R4zP9Pxwk75soi6v8S/acxh3fXz1vzks1WjGFXDWILPFz21N
 lVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207783; x=1779812583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+LF/w6vZJJy8YuU4QSMXlfWK8+cL6bD/zaog2spGsqk=;
 b=MQIoq3UQSUqTQpw5dtDalTGunyKrDhwPUxYrucXqMzReDQJoxD6gtsnQQpbe96AHzu
 ht/BGrK4db5F1i9KGKeUWidWrpzG6krAsy6J4LdKdRaXuSFR3rGZd8rNtYaFbfx6KUF5
 Y+jUNVjYBAkaUu0bxRKDTcIvc1HYGaQ+GPnSqjIMOCE2M9RFD+8fyW92NCaDy3KFf9fb
 hvYcJBPdgD3qvt8jOyyq6r8tcjGZJdM9bEqplG1289QC8OlP+nwz3ECCpRXvrV5nQ9qO
 15erPa+EboR5YJ+MKEL8vIEqTOUwiGIYVzEKcaGbsJCzu+PBBa3mJ2erCCzMaD8Dgh02
 3QVQ==
X-Gm-Message-State: AOJu0YzcoPeL6fR57Dsvs6CPFqBYgwlpfgVUhP75uBPccyGPxvXfhBBy
 KSm9+6S7/Tv1VONJyxz2HFm/ElH8D0gZZ+fw/7EaXMTXzkLYRg/0onoZvogdbw==
X-Gm-Gg: Acq92OH64t//MfDnrkZFo5UNAHKw/q20OP8rA1gJ11KpXeXikRDPllQTVhY8qLxM7kz
 8+AGnstk++YOJGbvBpcfaogIEQq0WFHMS3SmuV26x4i8grTMpySVzzgarhsQfikOkHfUnJszBil
 L+UunTUzxZqel4c0Chg1LuuoUtMQJfCW9LliWF8/KHes1eucTixn0XP3I8GrbS1SpK44jiguGQu
 Z+Rk/l42UgevYdibIA4KkU/9NcGwLVo6rsky6rq8A5+AEmgpQS7dP+DLWDcPJcITgnCTG8Fy6zm
 qdnnKF8AALtN5/EAKBj7aKMPHjyhO2Y/35wdMXuig52uoZrHkDszUar/2oYkulkGAJBIsQfzMBm
 +flL9dXDEACr5qRDF3itcr2UY7L8YXCWedp6fdhtK22eV2PGYqAjkfW2Fn93tA+tyFlLPjShLZq
 TtT7G+4gBUO/1u39O0ycTRoNlzki6pvIfw4qXBUwi/VWd5EAFHJaxxJOJhMGhqOF7LLEmHEfsPD
 GHHCGU/kzphvq2y8o08GzyHcmQ+eq9VnjmOFkhGwCcTuNcxazKulnyt+8SjnOqT1AIP
X-Received: by 2002:a05:6820:2e81:b0:69d:5149:e6b7 with SMTP id
 006d021491bc7-69d5149e8cbmr994347eaf.5.1779207783427; 
 Tue, 19 May 2026 09:23:03 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:30 -0600
Subject: [PATCH v9 28/40] target/mips: add Octeon SHA3 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-28-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32f.google.com
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

Add the Octeon SHA3 register-window state and helper operations. Keep the
shared HSH/SHA3/SHA512 write path coherent, model the dedicated 25-lane
Keccak state, and implement the Keccak-f[1600] permutation for the
STARTOP selector.

The shared selector window still uses explicit selector-position
arithmetic internally because multiple COP2 engines alias the same numeric
window. Decode of the individual DMFC2/DMTC2 instructions remains in the
later decodetree patch.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split SHA3 selector operations into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SHA3 helpers.
  - Use helper-local selector constants for shared-window position logic.
  - Add matching helper.h declarations with the helper implementation.

Changes v1 -> v2:
  - Use switch ranges and g_assert_not_reached() for SHA3 selector
    position decoding.  (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Rename SHA3 DAT15 selector aliases with MF/MT direction suffixes.
---
 target/mips/cpu.h               |   2 +
 target/mips/helper.h            |  22 +++++
 target/mips/system/machine.c    |   1 +
 target/mips/tcg/octeon_crypto.c | 208 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 66c8653211..a061a86658 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -541,6 +541,7 @@ typedef enum MIPSOcteonSharedMode {
     OCTEON_SHARED_MODE_NONE = 0,
     OCTEON_SHARED_MODE_SHA512,
     OCTEON_SHARED_MODE_SNOW3G,
+    OCTEON_SHARED_MODE_SHA3,
 } MIPSOcteonSharedMode;
 
 typedef struct MIPSOcteonCryptoState {
@@ -551,6 +552,7 @@ typedef struct MIPSOcteonCryptoState {
     uint64_t hsh_dat[8];
     uint64_t hsh_ivw[8];
     uint64_t hsh_datw[16];
+    uint64_t sha3_state[25];
     uint64_t aes_iv[2];
     uint64_t aes_key[4];
     uint64_t aes_result[2];
diff --git a/target/mips/helper.h b/target/mips/helper.h
index dac9dd8755..c0aa361ad8 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,7 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_sha3_dat24, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -40,6 +41,27 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_dat24, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_dat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat8, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat9, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat10, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat11, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat12, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat13, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat14, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat16, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat17, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_startop, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index ebfa0a9eb0..e6336534f4 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -292,6 +292,7 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 8),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_ivw, MIPSCPU, 8),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_datw, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.sha3_state, MIPSCPU, 25),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_result, MIPSCPU, 2),
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 7394108c54..caad685cde 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -136,6 +136,140 @@ static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto, uint64_t data)
                           crypto->gfm_poly, crypto->gfm_reflect_resinp);
     crypto->gfm_reflect_xor0 = 0;
 }
+static const uint64_t octeon_sha3_round_constants[24] = {
+    0x0000000000000001ULL, 0x0000000000008082ULL,
+    0x800000000000808aULL, 0x8000000080008000ULL,
+    0x000000000000808bULL, 0x0000000080000001ULL,
+    0x8000000080008081ULL, 0x8000000000008009ULL,
+    0x000000000000008aULL, 0x0000000000000088ULL,
+    0x0000000080008009ULL, 0x000000008000000aULL,
+    0x000000008000808bULL, 0x800000000000008bULL,
+    0x8000000000008089ULL, 0x8000000000008003ULL,
+    0x8000000000008002ULL, 0x8000000000000080ULL,
+    0x000000000000800aULL, 0x800000008000000aULL,
+    0x8000000080008081ULL, 0x8000000000008080ULL,
+    0x0000000080000001ULL, 0x8000000080008008ULL,
+};
+
+static const uint8_t octeon_sha3_rotation_constants[24] = {
+     1,  3,  6, 10, 15, 21, 28, 36, 45, 55,  2, 14,
+    27, 41, 56,  8, 25, 43, 62, 18, 39, 61, 20, 44,
+};
+
+static const uint8_t octeon_sha3_pi_lanes[24] = {
+    10,  7, 11, 17, 18,  3,  5, 16,  8, 21, 24,  4,
+    15, 23, 19, 13, 12,  2, 20, 14, 22,  9,  6,  1,
+};
+
+static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t *state = crypto->sha3_state;
+
+    for (int round = 0; round < 24; round++) {
+        uint64_t bc[5];
+        uint64_t temp;
+
+        for (int x = 0; x < 5; x++) {
+            bc[x] = state[x] ^ state[5 + x] ^ state[10 + x] ^
+                    state[15 + x] ^ state[20 + x];
+        }
+        for (int x = 0; x < 5; x++) {
+            temp = bc[(x + 4) % 5] ^ rol64(bc[(x + 1) % 5], 1);
+            for (int y = 0; y < 25; y += 5) {
+                state[y + x] ^= temp;
+            }
+        }
+
+        temp = state[1];
+        for (int i = 0; i < 24; i++) {
+            uint64_t next = state[octeon_sha3_pi_lanes[i]];
+
+            state[octeon_sha3_pi_lanes[i]] =
+                rol64(temp, octeon_sha3_rotation_constants[i]);
+            temp = next;
+        }
+
+        for (int y = 0; y < 25; y += 5) {
+            for (int x = 0; x < 5; x++) {
+                bc[x] = state[y + x];
+            }
+            for (int x = 0; x < 5; x++) {
+                state[y + x] = bc[x] ^ ((~bc[(x + 1) % 5]) & bc[(x + 2) % 5]);
+            }
+        }
+
+        state[0] ^= octeon_sha3_round_constants[round];
+    }
+}
+
+static bool octeon_sha3_is_dat_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_HSH_DATW(0) ... OCTEON_HSH_DATW(15):
+    case OCTEON_HSH_IVW(0) ... OCTEON_HSH_IVW(7):
+    case OCTEON_SHA3_DAT15_MT_SEL:
+    case OCTEON_SHA3_DAT24_SEL:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static int octeon_sha3_dat_pos_from_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_HSH_DATW(0) ... OCTEON_HSH_DATW(14):
+        return sel - OCTEON_HSH_DATW(0);
+    case OCTEON_HSH_IVW(0) ... OCTEON_HSH_IVW(7):
+        return 16 + (sel - OCTEON_HSH_IVW(0));
+    case OCTEON_HSH_DATW(15):
+    case OCTEON_SHA3_DAT15_MT_SEL:
+        return 15;
+    case OCTEON_SHA3_DAT24_SEL:
+        return 24;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t octeon_sha3_reg_to_lane(uint64_t value)
+{
+    /*
+     * The COP2 register interface is consumed by big-endian MIPS code as
+     * 64-bit register values, while Keccak lanes are byte-little-endian.
+     */
+    return bswap64(value);
+}
+
+static uint64_t octeon_sha3_lane_to_reg(uint64_t value)
+{
+    return bswap64(value);
+}
+
+static void octeon_store_shared_hsh_window(MIPSOcteonCryptoState *crypto,
+                                           uint32_t sel, uint64_t value)
+{
+    switch (sel) {
+    case OCTEON_HSH_DATW(0) ... OCTEON_HSH_DATW(14):
+        crypto->hsh_datw[sel - OCTEON_HSH_DATW(0)] = value;
+        crypto->sha3_state[sel - OCTEON_HSH_DATW(0)] =
+            octeon_sha3_reg_to_lane(value);
+        break;
+    case OCTEON_HSH_IVW(0) ... OCTEON_HSH_IVW(7):
+        crypto->hsh_ivw[sel - OCTEON_HSH_IVW(0)] = value;
+        crypto->sha3_state[16 + (sel - OCTEON_HSH_IVW(0))] =
+            octeon_sha3_reg_to_lane(value);
+        break;
+    case OCTEON_SHA3_DAT15_MT_SEL:
+        crypto->sha3_state[15] = octeon_sha3_reg_to_lane(value);
+        break;
+    case OCTEON_SHA3_DAT24_SEL:
+        crypto->sha3_state[24] = octeon_sha3_reg_to_lane(value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
 static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
                            uint16_t poly, uint64_t out[2])
 {
@@ -169,10 +303,84 @@ static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
     out[0] = zh;
     out[1] = zl;
 }
+uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_SHA3) {
+        return octeon_sha3_lane_to_reg(crypto->sha3_state[24]);
+    }
+    return 0;
+}
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
+static void octeon_sha3_mt_dat(MIPSOcteonCryptoState *crypto,
+                               uint32_t sel, uint64_t value)
+{
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_ZUC &&
+        octeon_zuc_is_shared_dmtc2_sel(sel)) {
+        octeon_store_shared_hsh_window(crypto, sel, value);
+        return;
+    }
+
+    octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+    octeon_store_shared_hsh_window(crypto, sel, value);
+}
+
+void helper_octeon_cp2_mt_sha3_dat24(CPUMIPSState *env, uint64_t value)
+{
+    octeon_sha3_mt_dat(&env->octeon_crypto, OCTEON_SHA3_DAT24_SEL,
+                       value);
+}
+
+void helper_octeon_cp2_mt_sha3_dat15(CPUMIPSState *env, uint64_t value)
+{
+    octeon_sha3_mt_dat(&env->octeon_crypto, OCTEON_SHA3_DAT15_MT_SEL,
+                       value);
+}
+
+static void octeon_sha3_xordat(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint64_t value)
+{
+    octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+    crypto->sha3_state[index] ^= octeon_sha3_reg_to_lane(value);
+}
+
+#define OCTEON_SHA3_XORDAT_HELPER(N) \
+void helper_octeon_cp2_mt_sha3_xordat ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_sha3_xordat(&env->octeon_crypto, N, value); \
+}
+OCTEON_SHA3_XORDAT_HELPER(0)
+OCTEON_SHA3_XORDAT_HELPER(1)
+OCTEON_SHA3_XORDAT_HELPER(2)
+OCTEON_SHA3_XORDAT_HELPER(3)
+OCTEON_SHA3_XORDAT_HELPER(4)
+OCTEON_SHA3_XORDAT_HELPER(5)
+OCTEON_SHA3_XORDAT_HELPER(6)
+OCTEON_SHA3_XORDAT_HELPER(7)
+OCTEON_SHA3_XORDAT_HELPER(8)
+OCTEON_SHA3_XORDAT_HELPER(9)
+OCTEON_SHA3_XORDAT_HELPER(10)
+OCTEON_SHA3_XORDAT_HELPER(11)
+OCTEON_SHA3_XORDAT_HELPER(12)
+OCTEON_SHA3_XORDAT_HELPER(13)
+OCTEON_SHA3_XORDAT_HELPER(14)
+OCTEON_SHA3_XORDAT_HELPER(15)
+OCTEON_SHA3_XORDAT_HELPER(16)
+OCTEON_SHA3_XORDAT_HELPER(17)
+#undef OCTEON_SHA3_XORDAT_HELPER
+
+void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    (void)value;
+    octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
+    octeon_sha3_permute(crypto);
+}
 void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
                                               uint64_t value)
 {

-- 
2.54.0



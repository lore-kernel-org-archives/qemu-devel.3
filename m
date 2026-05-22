Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37166CD5BB6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgP-0001lE-G9; Fri, 22 May 2026 15:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgJ-0001jL-8t
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgD-0000Yj-D8
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:12 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4855e69a5a4so370132b6e.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478628; x=1780083428; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dbskrzgvKScbHAmKPwkiyfQ5HhDAS/G7M42ypREWm+c=;
 b=Ai4AW7kGr7rxG8KzLAstBTB+LFY/vgjVF6KIhLHOcIKilrXvCd1w3Iy0Kx86SmKLN2
 ixQ+zUUmUk2hN8osJVpp4XN2Wvh7NH36/bEpk+L+j55MjQBqEjcl5iqnrEMj4OTlDc9r
 jwCB8Mp4XLF16R4Ac5ODAtVYIpEIf/+BPk3+Ucwkf+JAtIPSAXh3KNxfMtly57iWDFLa
 q1FZc58I0G35WmQLwKTCHrhq/AETNLljX+bld1PYesZo8uhc6E6oOVOkjkjjbUNkLwrq
 n0ikyxJ8SBKdiptymGcX8R48OpdfL6Pnl5qXZFuhLLYq7XJm1eJ9BI1veEXNC2HDh+0z
 X7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478628; x=1780083428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dbskrzgvKScbHAmKPwkiyfQ5HhDAS/G7M42ypREWm+c=;
 b=WlpT7ik1EZzRyzTOzMvkzp3eQRPgWxFd636ALlBadhfpwFibiXn81mUde5pe71Rl+z
 Nb5prMS0KOYnPfkJIr0boKGu46u9OsvRODrxwVa/Er/+d56uCarNEi08gbZUKo7cE1S/
 gG6KAH1I6X+8mSOK0c3npRf4LRJjWY5xh8xSm43H/B73zD2toub9bQwpB9wgxgW4Tt3e
 j6iZn8R2tIMllffBvb4jY/FhzceE2UnoAEN/2Skl6hY0xkqfRpvqmrytwsrHGy8udbHG
 J/DrRCAMNV2KiWQua7gr621TfQKvExM6QlN3rAg8DWL9YQfLZx06icW91SfcBOTs301j
 KW4w==
X-Gm-Message-State: AOJu0YwyxkCeJ0pHbKIbsNqYu1gmJHcFf3Df6SBsV1iQMohw9/PNZEnZ
 +F1eNtnxPFhJCczz7PiuGMVXI+LVc/Ellkm0gcLtHmoxRUoJjJrKnspi
X-Gm-Gg: Acq92OFVqzs8cs2FE5AX/pTwpbDOa6nXfpEQt82OACOrjoJTvlWXm2cTELI045+Yzqr
 aXAFgWw4frDG51JAK9APJK5CNx8AQ76jSCMyahVTNPkQa8ZXVAa+J26+f2dnxscZ4BF36yVbqxW
 ZB0Q+GhNslh8Uaep5zebLG9sR2wNBjUYgnzs2YAKfZX4xCi4JcMee9S4g9Qi8ZzVrXEcuvgJLGq
 b0wMVjyWwyazDL7+gC0sq8AiJVkYhM85mpJk2ScPyaAkBydXt1dj1BMV6x0iKKTYw+O5cZXDByf
 sMDtCBujMD03ZFLDPPBcxjShH6n3Ge6Y/m7idsk7beE6s6zCFtuOYtXvuLD+v/btwf98Jjp9iRM
 XmpZmt4I4qTxJNlP9USrxDs+mgHEZ0ce1e7nP9gMvVIRqRbZS4aJiABsw6QAV8QTJ/awZIKbarI
 Wx6vtSfpLfnKav1xAgmYjvN1Z41cZ4rjuxQOjazoTYTzpCSkBUeZMgKu7R/jnStqVAjqzJ53RBt
 MUJx0Czi/w4u8rsYqm+vy6U9dybirq61SkeLxkAfKLQSoS411HSFDlE/P6pHR8PmH5n
X-Received: by 2002:a05:6808:1383:b0:466:f60b:19d5 with SMTP id
 5614622812f47-48549cfcbc6mr3503960b6e.8.1779478628030; 
 Fri, 22 May 2026 12:37:08 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:37:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:47 -0600
Subject: [PATCH v15 16/22] target/mips: decode Octeon CRC and GFM COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-16-f8731a588dc2@gmail.com>
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

Add explicit decodetree entries and translator bindings for the Octeon
CRC and GFM COP2 operation selectors. Unlike simple register moves,
these selectors update CRC or Galois-field state and therefore remain
per-operation helper calls.

Keep CRC/GFM decode next to the helpers that implement these side
effects while avoiding a monolithic selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v10 -> v13:
  - Split simple register-transfer selectors into a separate COP2 register
    selector patch.
  - Use final CRC selector names in this patch instead of renaming them
    later in the series.
  - Route reflected GFM selectors through helpers immediately so no
    non-architectural reflected GFM state is introduced.
  - Add the reflected CRC polynomial helper with the selector decode that
    uses it.
---
 target/mips/helper.h                          |  1 +
 target/mips/tcg/octeon.decode                 | 22 +++++++++
 target/mips/tcg/octeon_crypto.c               |  7 +++
 target/mips/tcg/octeon_translate.c            | 50 +++++++++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 70 +++++++++++++++++++++++++++
 5 files changed, 150 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e210e406f9..141350e80a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -32,6 +32,7 @@ DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_polynomial_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_word, void, env, i64)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 09fbc6c1e3..70e02d0b0e 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -132,6 +132,11 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_CRC_POLYNOMIAL                010010 00001 rt:5 0000 0010 0000 0000 &cp2
     CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
     CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
+    CVM_MF_CRC_IV_REFLECT                010010 00001 rt:5 0000 0010 0000 0011 &cp2
+    CVM_MF_GFM_MUL_REFLECT0              010010 00001 rt:5 0000 0000 0101 1000 &cp2
+    CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
+    CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -148,6 +153,9 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
     CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
+    CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
     CVM_MT_3DES_KEY0                     010010 00101 rt:5 0000 0000 1000 0000 &cp2
     CVM_MT_3DES_KEY1                     010010 00101 rt:5 0000 0000 1000 0001 &cp2
     CVM_MT_3DES_KEY2                     010010 00101 rt:5 0000 0000 1000 0010 &cp2
@@ -167,13 +175,27 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_CRC_IV_REFLECT                010010 00101 rt:5 0000 0010 0001 0001 &cp2
+    CVM_MT_CRC_BYTE                      010010 00101 rt:5 0000 0010 0000 0100 &cp2
+    CVM_MT_CRC_HALF                      010010 00101 rt:5 0000 0010 0000 0101 &cp2
+    CVM_MT_CRC_WORD                      010010 00101 rt:5 0000 0010 0000 0110 &cp2
+    CVM_MT_CRC_BYTE_REFLECT              010010 00101 rt:5 0000 0010 0001 0100 &cp2
+    CVM_MT_CRC_HALF_REFLECT              010010 00101 rt:5 0000 0010 0001 0101 &cp2
+    CVM_MT_CRC_WORD_REFLECT              010010 00101 rt:5 0000 0010 0001 0110 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
+    CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
+    CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
+    CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
+    CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
   CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
 }
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 29b661d47f..1f97b8193c 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -2207,6 +2207,13 @@ void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
         octeon_crc_reflect32_by_byte((uint32_t)value);
 }
 
+void helper_octeon_cp2_mt_crc_write_polynomial_reflect(CPUMIPSState *env,
+                                                       uint64_t value)
+{
+    env->octeon_crypto.crc_poly =
+        octeon_crc_reflect32_by_byte((uint32_t)value);
+}
+
 void helper_octeon_cp2_mt_crc_write_byte(CPUMIPSState *env, uint64_t value)
 {
     octeon_crc_update_normal(&env->octeon_crypto, value, 1);
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b33252dd1f..ce4cfcb3f3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -28,6 +28,9 @@
     TRANS(NAME, trans_octeon_cp2_mf_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MF_HELPER(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mf_helper, \
+          gen_helper_octeon_cp2_mf_ ## SUFFIX)
 #define CP2_MT_I64(NAME, FIELD) \
     TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
 #define CP2_MT_U32(NAME, FIELD) \
@@ -41,6 +44,9 @@
     TRANS(NAME, trans_octeon_cp2_mt_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MT_HELPER(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mt_helper, \
+          gen_helper_octeon_cp2_mt_ ## SUFFIX)
 
 #define OCTEON_LO32_OFFSET (HOST_BIG_ENDIAN ? 4 : 0)
 
@@ -99,6 +105,16 @@ static bool trans_octeon_cp2_mf_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mf_helper(DisasContext *ctx, arg_cp2 *a,
+                                       void (*gen_helper)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_helper(value, tcg_env);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
 static bool trans_octeon_cp2_mt_i64(DisasContext *ctx, arg_cp2 *a, int offset)
 {
     TCGv_i64 value = tcg_temp_new_i64();
@@ -149,6 +165,16 @@ static bool trans_octeon_cp2_mt_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
+                                       void (*gen_helper)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    gen_helper(tcg_env, value);
+    return true;
+}
+
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
@@ -185,6 +211,12 @@ CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
+CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
+CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
+CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
+CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT0, hsh_dat, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT1, hsh_dat, 1);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT2, hsh_dat, 2);
@@ -196,6 +228,9 @@ CP2_MT_HSH_PAIR(CVM_MT_HSH_IV0, hsh_iv, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV1, hsh_iv, 1);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV2, hsh_iv, 2);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV3, hsh_iv, 3);
+CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT0, gfm_mul_reflect0);
+CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT1, gfm_mul_reflect1);
+CP2_MT_HELPER(CVM_MT_GFM_XOR0_REFLECT, gfm_xor0_reflect);
 CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
 CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
 CP2_MT_I64(CVM_MT_3DES_KEY2, des3_key[2]);
@@ -223,6 +258,21 @@ CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
+CP2_MT_HELPER(CVM_MT_CRC_POLYNOMIAL_REFLECT, crc_write_polynomial_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_IV_REFLECT, crc_write_iv_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_BYTE, crc_write_byte);
+CP2_MT_HELPER(CVM_MT_CRC_HALF, crc_write_half);
+CP2_MT_HELPER(CVM_MT_CRC_WORD, crc_write_word);
+CP2_MT_HELPER(CVM_MT_CRC_BYTE_REFLECT, crc_write_byte_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_HALF_REFLECT, crc_write_half_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WORD_REFLECT, crc_write_word_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_DWORD, crc_write_dword);
+CP2_MT_HELPER(CVM_MT_CRC_VAR, crc_write_var);
+CP2_MT_HELPER(CVM_MT_CRC_DWORD_REFLECT, crc_write_dword_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_VAR_REFLECT, crc_write_var_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 7a7445c40a..f3c52d7829 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -266,6 +266,70 @@ static uint64_t octeon_cop2_hsh_dat0_readback(uint64_t value)
     return rd;
 }
 
+static uint64_t octeon_cop2_crc_len_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a81202\n\t" /* dmtc2 $8, CRC_LEN selector */
+        ".word 0x482a0202\n\t" /* dmfc2 $10, CRC_LEN selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_crc_poly_reflect_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a84210\n\t" /* dmtc2 $8, CRC_POLYNOMIAL_REFLECT selector */
+        ".word 0x482a0200\n\t" /* dmfc2 $10, CRC_POLYNOMIAL selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_gfm_mul_reflect_write_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80058\n\t" /* dmtc2 $8, GFM_MUL_REFLECT0 selector */
+        ".word 0x482a0258\n\t" /* dmfc2 $10, GFM_MUL0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_gfm_mul_reflect_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80258\n\t" /* dmtc2 $8, GFM_MUL0 selector */
+        ".word 0x482a0058\n\t" /* dmfc2 $10, GFM_MUL_REFLECT0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -288,6 +352,12 @@ int main(void)
     assert(octeon_cop2_keylength_readback(0xa5) == 1);
     assert(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
            0x0102030405060708ULL);
+    assert(octeon_cop2_crc_len_readback(0xb5) == 5);
+    assert(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
+    assert(octeon_cop2_gfm_mul_reflect_write_readback(
+               0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
+    assert(octeon_cop2_gfm_mul_reflect_readback(
+               0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
 
     return 0;
 }

-- 
2.54.0



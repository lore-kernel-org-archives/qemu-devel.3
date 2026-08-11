Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38FDC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXD-0005PW-5d; Tue, 11 Aug 2026 00:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX9-0005Mq-UF
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX7-0002mD-SG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:15 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1904475a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424172; x=1787028972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZpPOKytJxm4lwxbTGWqFKnd4UF37njKhCHk600PrmQ=;
 b=G7hfo8JTpoMMpNxI6CCQY3PFkFXP/Et1y+k44rsMMKJEUVFgZfFWXSS4BK7ggJ+rcS
 ts+n+xxA6xFysDawDpZOfHCuhQXmhAd8xJCScvSXqgekzAcipYL6SH/xrSHvtrwPBLlQ
 fTutibzGqnzoY/0Xc+HM9pahrmRb9eoeJC1EoLgzzH3TCTIGr86JxWK/S300dKUWlEAl
 w2jskap/TzsfMbsFBjLEUR4DioFNHAM8j41F52esxA75q9/m7ziit9A/HvC2InkaG7ja
 aTKeJp+O/jN0BElMqexNYF8eNwA8z27uxihQJC9MYLdvlfEHwxcGT6hUlPU37gmRYayr
 aGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424172; x=1787028972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sZpPOKytJxm4lwxbTGWqFKnd4UF37njKhCHk600PrmQ=;
 b=UYIkMXl9477ikW1jg7kO+NacmS0pZ+uAq6PbtD45suESm02MGmZgEEACutN4dciR7U
 AzU3+b4QKnhzfhCpP/cdjqFPLTopEr+t94FAEGXp/xOYSZlUzlIii+o3ImoZEz1KyYOg
 LzqlyYcOck2CIncm4gcloPUMvDPkguV2qo74SaWIex79epQSql1oMTxfXkhljspWxqnO
 4jrD4P1lagE0lbAnjdzsUL96aG8dDHYvhS/v+hYbvP6QeBjjBM0QxOlu0n+qpl8LMNJp
 KwAb07gM8oWC7bJFt8FdewTTJ2qDodcnkvvU22a5Z3uvJ3W2VfzHaXYsRhmVFdGyEHhj
 Lftg==
X-Gm-Message-State: AOJu0Yyl0YwiYSmsL0SxJHSyFHylMUtjlMQCvJN3JvU1FtpXEh/8oG9h
 mHZMk5oC6S1daCBqm6X6VXHpWLscW0ZlcDtjVYl5wyZGfN/zQz0dlGDU93R2szwZoNMHM6mk/lC
 ssz02
X-Gm-Gg: AR+sD11auiflwDsRwx/x0j5W+TmbU+s26PxxCvWnyT7oZcZN20PR52a3eeH3/CTxpI2
 4mj59Taz6NL+/k2NiXmMiWvnZDjUZDPGSh5JXkeHKOq039+lz7O1r20Ir85LVTh2JImFH83buWO
 KQksOl7pFIw1NRcqzglMLIlkw8lpnrDlkVgdkaC0gnMkdSxnxOgpsP6zRmJZyn2Z/qEn3wgfcVO
 u9Ut0UEDGnMMLxdpWcOPEl/hi2q7UX6vw4BkzSyHXdvzGbn/VzxzWX8YUkzEkmXTRKVx56hQro1
 7BcKVUMONdZgwMJeBEPc867l89Cp4UZipr570O9JdIqlG/AKsok8w8S1L8TjTnlz52903N8IzFN
 l6AKTw6FiIvZ67M+CcdEpGj/yao396uTUjmzvzHOJ15RtAyklskNghPCH82UNgHBsb0XcBhWaus
 ruS7ZQBTYzxC/ZR0bCmqqGGHS9rcc/f4ZuyKfGnyBX6frxZZa6GFEJyuy/sgrwPZjGlo30lL6Ew
 t4FKhiyWrMrPGUYo7GX
X-Received: by 2002:a17:90b:4cca:b0:38e:ad9d:1151 with SMTP id
 98e67ed59e1d1-392ec39335amr698962a91.4.1786424172291; 
 Mon, 10 Aug 2026 21:56:12 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 06/16] target/mips: Expand octeon reflections inline
Date: Mon, 10 Aug 2026 21:55:55 -0700
Message-ID: <20260811045605.1246543-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use tcg_gen_revbit64_i64 instead of out-of-line helpers.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/helper.h               |  7 -----
 target/mips/tcg/octeon_crypto.c    | 35 ---------------------
 target/mips/tcg/octeon_translate.c | 49 ++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 786117813a..779b87101d 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,10 +27,6 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_polynomial_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
@@ -43,9 +39,6 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
-DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect0, void, env, i64)
-DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
-DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index fbf80be2a5..118397e632 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -2127,41 +2127,6 @@ uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
-uint64_t helper_octeon_cp2_mf_gfm_mul_reflect0(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_mul[0]);
-}
-
-uint64_t helper_octeon_cp2_mf_gfm_mul_reflect1(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_mul[1]);
-}
-
-uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect0(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_resinp[0]);
-}
-
-uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect1(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_resinp[1]);
-}
-
-void helper_octeon_cp2_mt_gfm_mul_reflect0(CPUMIPSState *env, uint64_t value)
-{
-    env->octeon_crypto.gfm_mul[0] = revbit64(value);
-}
-
-void helper_octeon_cp2_mt_gfm_mul_reflect1(CPUMIPSState *env, uint64_t value)
-{
-    env->octeon_crypto.gfm_mul[1] = revbit64(value);
-}
-
-void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
-{
-    env->octeon_crypto.gfm_resinp[0] ^= revbit64(value);
-}
-
 static void octeon_gfm_xormul1_common(MIPSOcteonCryptoState *crypto,
                                       uint64_t value)
 {
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index a0db6630c7..b689adb46b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -28,6 +28,8 @@
     TRANS(NAME, trans_octeon_cp2_mf_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MF_REFLECT(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_reflect, OCTEON_CRYPTO_OFFSET(FIELD))
 #define CP2_MF_HELPER(NAME, SUFFIX) \
     TRANS(NAME, trans_octeon_cp2_mf_helper, \
           gen_helper_octeon_cp2_mf_ ## SUFFIX)
@@ -44,6 +46,8 @@
     TRANS(NAME, trans_octeon_cp2_mt_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MT_REFLECT(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_reflect, OCTEON_CRYPTO_OFFSET(FIELD))
 #define CP2_MT_HELPER(NAME, SUFFIX) \
     TRANS(NAME, trans_octeon_cp2_mt_helper, \
           gen_helper_octeon_cp2_mt_ ## SUFFIX)
@@ -110,6 +114,17 @@ static bool trans_octeon_cp2_mf_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mf_reflect(DisasContext *ctx, arg_cp2 *a,
+                                        int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(value, tcg_env, offset);
+    tcg_gen_revbit64_i64(value, value);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
 static bool trans_octeon_cp2_mf_helper(DisasContext *ctx, arg_cp2 *a,
                                        void (*gen_helper)(TCGv_i64, TCGv_env))
 {
@@ -183,6 +198,17 @@ static bool trans_octeon_cp2_mt_xor_i64(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_reflect(DisasContext *ctx, arg_cp2 *a,
+                                        int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_revbit64_i64(value, value);
+    tcg_gen_st_i64(value, tcg_env, offset);
+    return true;
+}
+
 static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
                                        void (*gen_helper)(TCGv_env, TCGv_i64))
 {
@@ -200,6 +226,17 @@ static bool trans_octeon_cp2_mt_helper_env(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static void gen_helper_octeon_cp2_mt_gfm_xor0_reflect(TCGv_env t_env,
+                                                      TCGv_i64 value)
+{
+    TCGv_i64 resinp = tcg_temp_new_i64();
+
+    tcg_gen_revbit64_i64(value, value);
+    tcg_gen_ld_i64(resinp, t_env, OCTEON_CRYPTO_OFFSET(gfm_resinp[0]));
+    tcg_gen_xor_i64(resinp, resinp, value);
+    tcg_gen_st_i64(resinp, t_env, OCTEON_CRYPTO_OFFSET(gfm_resinp[0]));
+}
+
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
@@ -241,10 +278,10 @@ CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 CP2_MF_I64(CVM_MF_SHA3_DAT24, sha3_dat24);
-CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
-CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
-CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
-CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+CP2_MF_REFLECT(CVM_MF_GFM_MUL_REFLECT0, gfm_mul[0])
+CP2_MF_REFLECT(CVM_MF_GFM_MUL_REFLECT1, gfm_mul[1])
+CP2_MF_REFLECT(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp[0])
+CP2_MF_REFLECT(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp[1])
 CP2_MF_I64(CVM_MF_HSH_DATW0, hsh_dat[0]);
 CP2_MF_I64(CVM_MF_HSH_DATW1, hsh_dat[1]);
 CP2_MF_I64(CVM_MF_HSH_DATW2, hsh_dat[2]);
@@ -281,8 +318,8 @@ CP2_MT_HSH_PAIR(CVM_MT_HSH_IV0, hsh_iv, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV1, hsh_iv, 1);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV2, hsh_iv, 2);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV3, hsh_iv, 3);
-CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT0, gfm_mul_reflect0);
-CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT1, gfm_mul_reflect1);
+CP2_MT_REFLECT(CVM_MT_GFM_MUL_REFLECT0, gfm_mul[0]);
+CP2_MT_REFLECT(CVM_MT_GFM_MUL_REFLECT1, gfm_mul[1]);
 CP2_MT_HELPER(CVM_MT_GFM_XOR0_REFLECT, gfm_xor0_reflect);
 CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
 CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
-- 
2.43.0



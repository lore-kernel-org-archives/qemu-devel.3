Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48217F428E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6jX-0005mR-VJ; Wed, 15 Apr 2026 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jT-0005lJ-Ae
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jO-00020t-2j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so96088325e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284454; x=1776889254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spGxmOhOSsGGCE7d6Xa2sLvNfzB1VyOj40S+qP0AZgw=;
 b=By+R9G4IWKBjhevZeceZuzzheXwN1KSk1ZvFrVS10N54+dDv9NK9t3umSw9Kzb/68m
 QZSnPCNQcE2SJFNgg9a7lYZzgdooLIwvtRYbbkljSnSvS4zFOd42wwvVQiXGh1vRkGZj
 0N6Zsm7QGfqm7EoAEc02iVeS30aQj9+746pz/VtQUY2eoUiOr4LKD/l6+wgGOqBqeqym
 QBmC65IWWiiXNTPDBcKKjB8i30UHweG0dLLhUTfeXg2NxpS0ApMniVZxsXtsuTuvQEQh
 rwXLqWuKGMqBf2WRQ4j9fzUqQh/lXGqpg6wae75c+eDDywCXSTAc9t0y4rChwcAp+B22
 2T3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284454; x=1776889254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=spGxmOhOSsGGCE7d6Xa2sLvNfzB1VyOj40S+qP0AZgw=;
 b=etPGKG3IwAkbBhOVZAboTcC4VpfI3HmuXr9Jdeu07YvOSdzHJp35dZhB9gMz2NUiVt
 j6U6aFp/pMhYK6rMX72zFDkp1OkVeRzOsDjmBlNTMYdbkdndrdUL0Xehtlq17CagyqZB
 Y4msnaHlWhfntN/qH4iGVvwH4tzXFfOkTl8l/y9hGFnpPh9WgojfxkFvd9NFLflxRMdv
 772K7D8Tbwoz2vIVnUZnt0DZIvjKfEZUTkfVUqN5ptEgTihWbCVvd7bk6JrgDo9q0h9z
 CunnOb1PdJ8VeeaQKV3aqXETl9DXxds4Tea1o0klU2V8pkJJXAQlmop+7//NkbzYqFJb
 FPtQ==
X-Gm-Message-State: AOJu0YzRdEYBTskTYHTlJYU3WTpaKQNPVY70Aar8feMZWIfJPQjwExUB
 suh4b7fH8GpW/pfGi5hFOdO5p5FmHAyITqekz4qmYLeChstbE3JNB1XWbIf9JOqPUWcIHs8Aea/
 IgboGp20=
X-Gm-Gg: AeBDietshFEF3QCCMlFFYBGlWO4xXEo3vd2BLDk68UQLefIQBuA4hwq+dU1pJItXwFq
 ALXTxfsRSlGxM7s3ygYNK/WxWuN9cELy1BcJfcO6jt8npPLAe12lYKkqWL+Phy3fHwNGp3kQFcl
 D3lb2DhxZoaXV2TZ/VZOya/gbkgTPD39r6X0EShcElD5ctk5C5WzstwEWU6EBh2Sx8yD/VTH15I
 NR10SKKO1eNc3iKGQgblb+CItmzjOcNCCT6Wp3ZP5Ie/oqERej89HGYfrHx4hG9z99qtZKeIx5E
 kd9acTKatnHdxL0DFnCbH53V5cgcuRQax+NYychvOuubMEXaVCjj2Vn8SaKlu34UYNXxfU+4D1w
 q+ZeyTQ+7khS579xXz7WpZguzjbTDrh9p8zO52+REs+ty1i34wAlpdULEzAKiNAv4ymqPiGYIuB
 ZUAO0Mr7AR87fP4SRXJLs4ZHzjJW2PN8A51/jHMvATljtEiJSWWWwsmtj+DxOLzyY7ENd3bqAF
X-Received: by 2002:a05:600c:a404:b0:488:bfc3:ef3 with SMTP id
 5b1f17b1804b1-488d6671271mr285797805e9.0.1776284453909; 
 Wed, 15 Apr 2026 13:20:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f208451bsm62746255e9.14.2026.04.15.13.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:20:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 3/6] target/mips: Convert MSA LD/ST.H (Halfword Vector)
Date: Wed, 15 Apr 2026 22:20:23 +0200
Message-ID: <20260415202027.83008-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202027.83008-1-philmd@linaro.org>
References: <20260415202027.83008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Replace runtime helpers by translation.

Replace the legacy cpu_ld/st*_data_ra() calls by
tcg_gen_qemu_ld/st() which allow to respect atomicity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 48 --------------------------------
 target/mips/tcg/msa_translate.c  | 32 +++++++++++++++++----
 3 files changed, 26 insertions(+), 55 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 50a2732e916..86a79bf804c 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -436,7 +436,6 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 #define MSALDST_PROTO(type)                         \
 DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(h)
 MSALDST_PROTO(w)
 MSALDST_PROTO(d)
 #undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index d9f35fca657..5489d8830dd 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8212,38 +8212,11 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-static inline uint64_t bswap16x4(uint64_t x)
-{
-    uint64_t m = 0x00ff00ff00ff00ffull;
-    return ((x & m) << 8) | ((x >> 8) & m);
-}
-
 static inline uint64_t bswap32x2(uint64_t x)
 {
     return ror64(bswap64(x), 32);
 }
 
-void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /*
-     * Load 8 bytes at a time.  Use little-endian load, then for
-     * big-endian target, we must then swap the four halfwords.
-     */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap16x4(d0);
-        d1 = bswap16x4(d1);
-    }
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
@@ -8296,27 +8269,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  See helper_msa_ld_h. */
-    d0 = pwd->d[0];
-    d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap16x4(d0);
-        d1 = bswap16x4(d1);
-    }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
-}
-
 void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 340a0a14aaf..111d9eedd11 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -754,10 +754,27 @@ TRANS(FTINT_U,  trans_msa_2rf, gen_helper_msa_ftint_u_df);
 TRANS(FFINT_S,  trans_msa_2rf, gen_helper_msa_ffint_s_df);
 TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
+/*
+ * Byte pattern: ab.cd.ef.gh -> ba.dc.fe.bg
+ */
+static void gen_bswap16x4_i64(TCGv_i64 dst, TCGv_i64 src)
+{
+    uint64_t m = 0x00ff00ff00ff00ffull;
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+                                        /* src = abcdefgh */
+    tcg_gen_andi_i64(t0, src, m);       /*  t0 = .b.d.f.h */
+    tcg_gen_shli_i64(t0, t0, 8);        /*  t0 = b.d.f.h. */
+    tcg_gen_shri_i64(t1, src, 8);       /*  t1 = habcdefg */
+    tcg_gen_andi_i64(t1, t1, m);        /*  t1 = .a.c.e.g */
+    tcg_gen_or_i64(dst, t0, t1);        /* dst = badcfebg */
+}
+
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
     static const MemOp mo_atom_df[4] = {
         MO_ATOM_NONE,
+        MO_ATOM_SUBALIGN, /* Slightly stronger than required */
     };
     TCGv_i32 wd;
     TCGv_i128 t16;
@@ -778,9 +795,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 
     if (is_load) {
         switch (a->df) {
-        case 1:
-            gen_helper_msa_ld_h(tcg_env, wd, addr);
-            return true;
         case 2:
             gen_helper_msa_ld_w(tcg_env, wd, addr);
             return true;
@@ -790,9 +804,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         }
     } else {
         switch (a->df) {
-        case 1:
-            gen_helper_msa_st_h(tcg_env, wd, addr);
-            return true;
         case 2:
             gen_helper_msa_st_w(tcg_env, wd, addr);
             return true;
@@ -813,6 +824,15 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         tcg_gen_extr_i128_i64(d0, d1, t16);
     }
 
+    if (mo_endian(ctx) != MO_LE) {
+        switch (a->df) {
+        case 1:
+            gen_bswap16x4_i64(d0, d0);
+            gen_bswap16x4_i64(d1, d1);
+            break;
+        }
+    }
+
     if (!is_load) {
         tcg_gen_concat_i64_i128(t16, d0, d1);
         tcg_gen_qemu_st_i128(t16, addr, ctx->mem_idx, mop);
-- 
2.53.0



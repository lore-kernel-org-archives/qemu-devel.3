Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA726F428DA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6jT-0005lK-7E; Wed, 15 Apr 2026 16:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jO-0005kd-93
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jC-0001pc-LR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:20:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so4899894f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284446; x=1776889246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LXW55SWZ5i76XTZpCWe3HLcWznDOC4tq1zgusBrG7Y=;
 b=QEG68PCbr8IT1dHvlyLwElGynUyja8fbahApNZpSU7kUmdP0UTOJHKA/BZPRASBaat
 jGRXLpS9H3Z1MbCnOQ8WXlvJeHsy/UaeeXbg9n2f0lkU0KiyU0dQxW46HrE3vKptI7OQ
 XEQ+ImwvqBW2Mcu0ZpDzJ0fuZD1zPNzhkm2/1mL7s1Jb9bcK0Wz4SqnB703p3+oC4spe
 7Hr/gObiPWUnyvxbq3Du2WlN87Nr6UYaEhqjd1TO3CdQ8JR7smI2TnYlLdHxiTbTIDDp
 RhdkTds4Sd6IBLtq5I+QyMG/hRsUyeBVrRd6OXvqhCHK0jBHhr+BY//mMfVB/SXKKodw
 IfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284446; x=1776889246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4LXW55SWZ5i76XTZpCWe3HLcWznDOC4tq1zgusBrG7Y=;
 b=AGVE9mjCOABVUbQywq4A2ULtuKXsnz0iKTNFnBgxHI0et/vRyfOkNAzmSIyh66mxAE
 4GaoDTahIVgU21/cyDNzIXISVqWqDM03QmN8sbVNsM8GCJZG8c2woKh3LbdlaI/5KP8Y
 7GBuvrSKwDJctQGcJjyQpRy88c5YgrOEqdDH56HpDj3HbzA2PP1l/SnGuLpgccEYgwDp
 +fOiXZwoASYBh/2lL1rkNX80QdDRwcZ7NB3MmsfefzJV4AVvP+R6HmlqqbWaBFIg/u5P
 CkiQ83bXwGMQTquSDUfecq4OYUglhR6FjXch9tKXwHZS9MFoUkifR6cWG4YMUaBhp2yt
 hlWw==
X-Gm-Message-State: AOJu0Ywm1w5Xhw9sS+IU5wCzbDREr7tfBH+UfqiggSim7ZYO1q4uiSoj
 NXaYVPX4O9LNArGiHjgXCz98PJFQ2581OoQqXXxr7eff23RfofekynNNpZVr9b0YIWEuO47vFG0
 lu6fDsIo=
X-Gm-Gg: AeBDietI2thyp4X1YtoR+l04lSkjhNNHPIhNHpX1EUUEw0y8gNNN7YpeCgnxqh78ISH
 psWKegN1n5sID6b8jKUosQy/c3Im4nsxJUolHFLFhXWtXZZOaUjGLdB5VCXey0gM3qXnbh/2tNY
 iP6fGwUtF5dpgf6ZNMhLs/DutkTQ1/dE/Bc8ny+HKx9rpzf19Zvebmtq+F7strbom05dkWy/LCF
 8DyIAJdKIDUeZOoiUEIP+0FecOuEmf+tjKeQnxaWRUEUuww/yV+mXhe97Q8QYWy96q7DgYLlXZh
 wn7JucLBPVUBs0OrO++Y2qyAEx3yvzedfQbyM5/vYG0E2j+XXd533VOJhP8OBW9DH33pI3uyYoz
 YuNvSXRJ2OdVEvQ9vNhLrjY3Vm5ZE49IsuxWTVDHAV9DJ99CRyQlz9fkgvC5CUR1zdhNbU4yyDv
 1zU25juSv7yUZforx3vwSDsg8ppFmLndM91D+fZSftQoWtm8FdCtlDaEccKPtfOwkXg38zMKp2
X-Received: by 2002:a05:6000:60f:b0:43e:a69b:d814 with SMTP id
 ffacd0b85a97d-43ea69bd9fcmr12554190f8f.28.1776284446287; 
 Wed, 15 Apr 2026 13:20:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d6e9sm7792609f8f.1.2026.04.15.13.20.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:20:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 2/6] target/mips: Convert MSA LD/ST.B (Byte Vector)
Date: Wed, 15 Apr 2026 22:20:22 +0200
Message-ID: <20260415202027.83008-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202027.83008-1-philmd@linaro.org>
References: <20260415202027.83008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Consider the host endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 28 ----------------------------
 target/mips/tcg/msa_translate.c  | 30 ++++++++++++++++++++++++------
 3 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 4963d1553a0..50a2732e916 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -436,7 +436,6 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 #define MSALDST_PROTO(type)                         \
 DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(b)
 MSALDST_PROTO(h)
 MSALDST_PROTO(w)
 MSALDST_PROTO(d)
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index f554b3d10ee..d9f35fca657 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8223,20 +8223,6 @@ static inline uint64_t bswap32x2(uint64_t x)
     return ror64(bswap64(x), 32);
 }
 
-void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /* Load 8 bytes at a time.  Vector element ordering makes this LE.  */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
@@ -8310,20 +8296,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  Vector element ordering makes this LE.  */
-    cpu_stq_le_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
-}
-
 void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 2e1a769e032..340a0a14aaf 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -756,8 +756,16 @@ TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
+    static const MemOp mo_atom_df[4] = {
+        MO_ATOM_NONE,
+    };
     TCGv_i32 wd;
+    TCGv_i128 t16;
     TCGv_va addr;
+    MemOp mop;
+    int idx = a->wd << 1;
+    TCGv_i64 d0 = msa_wr_d[idx +  FP_ENDIAN_IDX];
+    TCGv_i64 d1 = msa_wr_d[idx + !FP_ENDIAN_IDX];
 
     if (!check_msa_enabled(ctx)) {
         return true;
@@ -770,9 +778,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 
     if (is_load) {
         switch (a->df) {
-        case 0:
-            gen_helper_msa_ld_b(tcg_env, wd, addr);
-            return true;
         case 1:
             gen_helper_msa_ld_h(tcg_env, wd, addr);
             return true;
@@ -785,9 +790,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         }
     } else {
         switch (a->df) {
-        case 0:
-            gen_helper_msa_st_b(tcg_env, wd, addr);
-            return true;
         case 1:
             gen_helper_msa_st_h(tcg_env, wd, addr);
             return true;
@@ -800,6 +802,22 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         }
     }
 
+    t16 = tcg_temp_new_i128();
+
+    mop = MO_128 | MO_LE;
+    mop |= a->df << MO_ASHIFT; /* MO_ALIGN */
+    mop |= mo_atom_df[a->df];
+
+    if (is_load) {
+        tcg_gen_qemu_ld_i128(t16, addr, ctx->mem_idx, mop);
+        tcg_gen_extr_i128_i64(d0, d1, t16);
+    }
+
+    if (!is_load) {
+        tcg_gen_concat_i64_i128(t16, d0, d1);
+        tcg_gen_qemu_st_i128(t16, addr, ctx->mem_idx, mop);
+    }
+
     return true;
 }
 
-- 
2.53.0



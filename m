Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E39C48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXY3C-0003Gy-2n; Tue, 06 Feb 2024 21:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY3A-0003GL-Pl
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:36 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY39-0000gi-1x
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:36 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5dc13cbce45so88846a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274354; x=1707879154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlUygCHtFk0VaXGDrmWE40VfWYD6mSX0y7BA0niY71c=;
 b=IagH4IMqplzV8gqZxZ0mhSTTUHci8Pyd8447gHyM9VkpSSgCDL3JwzyaKedowLHEB4
 MkAYq02dmTj2S8U6WhxhVXZyyTGe13rGqIinS5hq9GdtrztZTxDR8Upk3rMb+0b2M0vV
 fCjhLbfaM7sx2f0ckvsgYAiZumg0rQJ/Xi7fTpd9xueDswMM2sx93DzaJT5i+r1UJ5uT
 plHTKEieIp7G/gePhNd9jI5lfh0nTo1UMA7u66umqJhlONEROdqzARbrcmMGkSJiZNVe
 UkxHum/n+XJsXgtqz6XT927/8EBhfDPR65ZjJ2V4prvkuMyck0ErdxfGSpsHgohvn4MZ
 7okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274354; x=1707879154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlUygCHtFk0VaXGDrmWE40VfWYD6mSX0y7BA0niY71c=;
 b=IEPDtoWapXDC2n/supTdGXf2EMDjyGiNTT751++8xTg+yJ9LNmnLLBwWUmCABLbxcJ
 aYi971JI5XAMq+TCjWuKk9w71VtKUyHWmCXVW96yzneW9MIauSzDJSh0BgBDefqQLLX4
 oL9UhqViZ323K/Kl+uZraiD5kMyJuAB5C3wh3ujQWM+u/i5xBr93sCK1y9aUkQPMbMx7
 8SV7vRYMUdiayrzYfacguCpTPCiqEAcjzS4PqIRsNWZuNwrScH81na2w+fxpuHUlVi8L
 Xu6l44/ijNF1Bns/Q1f79tYupMlt700cdAlWYh/6piU2P+oF+xORiQCiH1p70U7NlDOj
 jjJQ==
X-Gm-Message-State: AOJu0YyEmECbLYxcvtnlsIA1y1a5P42/NmdX47YsU11fISiDrdZ/X73j
 rTnpD5MTB/YSX4fTLd/TM81aI7i4COi6H94vuVqhGFEt349MCNS0rVFHAJbdnuAJpbavUNSEA9l
 dvYU=
X-Google-Smtp-Source: AGHT+IHeA9p7rQupASz1q2Wa0a+evIiNetkJ7Ftt/JzrqA3EAvzUNJzw4r2R5o1F6C/DtSlXAJCtVA==
X-Received: by 2002:a05:6a21:3948:b0:19c:b40a:d8ab with SMTP id
 ac8-20020a056a21394800b0019cb40ad8abmr4454865pzc.4.1707274353797; 
 Tue, 06 Feb 2024 18:52:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV68Ib8Izz4Y9ko/GumheyKwEgJMGYR4RGQzLHj7EvEz/hDDNQoNq6WXm8Ji5hXz+PxXUdsAUGgUpF/q2mKVxSw/TH8a+aXX4zqpvSFzi3ur78MJmmxZR2sU9zDx7nmBwiOP5y466GCgPeDOHJH4IcydSl55qPcKMP4Cg0=
Received: from stoup.. (60-242-98-186.static.tpgi.com.au. [60.242.98.186])
 by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d8ef97de4asm255435plb.38.2024.02.06.18.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:52:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 4/6] target/arm: Split out make_svemte_desc
Date: Wed,  7 Feb 2024 12:52:08 +1000
Message-Id: <20240207025210.8837-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
References: <20240207025210.8837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Share code that creates mtedesc and embeds within simd_desc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  2 ++
 target/arm/tcg/translate-sme.c | 15 +++--------
 target/arm/tcg/translate-sve.c | 47 ++++++++++++++++++----------------
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 96ba39b37e..7b811b8ac5 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -28,6 +28,8 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
 bool sve_access_check(DisasContext *s);
 bool sme_enabled_check(DisasContext *s);
 bool sme_enabled_check_with_svcr(DisasContext *s, unsigned);
+uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+                          uint32_t msz, bool is_write, uint32_t data);
 
 /* This function corresponds to CheckStreamingSVEEnabled. */
 static inline bool sme_sm_enabled_check(DisasContext *s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8f0dfc884e..46c7fce8b4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -206,7 +206,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     TCGv_ptr t_za, t_pg;
     TCGv_i64 addr;
-    int svl, desc = 0;
+    uint32_t desc;
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
@@ -224,18 +224,11 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->esz);
     tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
 
-    if (mte) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, a->st);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << a->esz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
-    } else {
+    if (!mte) {
         addr = clean_data_tbi(s, addr);
     }
-    svl = streaming_vec_reg_size(s);
-    desc = simd_desc(svl, svl, desc);
+
+    desc = make_svemte_desc(s, streaming_vec_reg_size(s), 1, a->esz, a->st, 0);
 
     fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
                                       tcg_constant_i32(desc));
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a88e523cba..508f7b6bbd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4437,18 +4437,18 @@ static const uint8_t dtype_esz[16] = {
     3, 2, 1, 3
 };
 
-static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
-                       int dtype, uint32_t mte_n, bool is_write,
-                       gen_helper_gvec_mem *fn)
+uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+                          uint32_t msz, bool is_write, uint32_t data)
 {
-    unsigned vsz = vec_full_reg_size(s);
-    TCGv_ptr t_pg;
     uint32_t sizem1;
-    int desc = 0;
+    uint32_t desc = 0;
 
-    assert(mte_n >= 1 && mte_n <= 4);
-    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
+    /* Assert all of the data fits, with or without MTE enabled. */
+    assert(nregs >= 1 && nregs <= 4);
+    sizem1 = (nregs << msz) - 1;
     assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
+    assert(data < 1u << SVE_MTEDESC_SHIFT);
+
     if (s->mte_active[0]) {
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
@@ -4456,7 +4456,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
         desc <<= SVE_MTEDESC_SHIFT;
-    } else {
+    }
+    return simd_desc(vsz, vsz, desc | data);
+}
+
+static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
+                       int dtype, uint32_t nregs, bool is_write,
+                       gen_helper_gvec_mem *fn)
+{
+    TCGv_ptr t_pg;
+    uint32_t desc;
+
+    if (!s->mte_active[0]) {
         addr = clean_data_tbi(s, addr);
     }
 
@@ -4465,7 +4476,8 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
      */
-    desc = simd_desc(vsz, vsz, zt | desc);
+    desc = make_svemte_desc(s, vec_full_reg_size(s), nregs,
+                            dtype_msz(dtype), is_write, zt);
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
@@ -5224,25 +5236,16 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
                        int scale, TCGv_i64 scalar, int msz, bool is_write,
                        gen_helper_gvec_mem_scatter *fn)
 {
-    unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_zm = tcg_temp_new_ptr();
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
-    int desc = 0;
-
-    if (s->mte_active[0]) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << msz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
-    }
-    desc = simd_desc(vsz, vsz, desc | scale);
+    uint32_t desc;
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
     tcg_gen_addi_ptr(t_zm, tcg_env, vec_full_reg_offset(s, zm));
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
+
+    desc = make_svemte_desc(s, vec_full_reg_size(s), 1, msz, is_write, scale);
     fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i32(desc));
 }
 
-- 
2.34.1



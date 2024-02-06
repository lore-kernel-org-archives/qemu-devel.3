Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28DDC4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmW-0006wY-4x; Mon, 05 Feb 2024 22:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmU-0006v4-Iw
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:54 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmQ-0003J3-Al
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:54 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-59927972125so2840780eaf.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188744; x=1707793544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvbHuxgxiU+JJoqA2yzeDB/PI/mathl0ihpskMBLoOU=;
 b=ivHz2GOgI4FJbXTidQ5s/YjjzEHAqUrpzOJQZBRdOuC5U0s6EcGjJvYMxtaMhZdT53
 KsTbXf4LDjqPeHD/PS/2n8q1lJ8jOyYBNTxWi3gf8Hk0egwFfyoYTQmxMiDzI084axQ8
 ETqsv6Okrxtj2EwnSCyuJHt2McAtZs9wH/8TLEVI/foOaWDMvonVnLRiPeug8o5lhue+
 aofqRa9GWFpi6lPqLmTr2/9tstR1vz9S3kun5LBEYBrk1ySfDnebWgMxI8apjxA/dToi
 xk+WZfhH96XmP1IQaX5V7qCN/NSBFG1OKL0Aw+1CZ7bgBJWR3Iq/m279kBO4eDc3yhiN
 K+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188744; x=1707793544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvbHuxgxiU+JJoqA2yzeDB/PI/mathl0ihpskMBLoOU=;
 b=Tje0RPSKd5LwMDFWUZIRCrQiqfPPNcLA025UvjeyJYkh/JW2ylFwsm1g6FeWtxt/4W
 hz7aK0SF2FLn9vmlAVRpL671lP5Dx2DOaPxtmlVJB8/6hT2504ku0ZicvI/pD6z7JQvb
 PuWEk+VTiQa0OZOfbkxYBAS18JPCU9NXVoxZD9kD0kdceNWj0EWkt9jkyl34w9NFsf8g
 4twPZ6E3IxpjkNSrlrA4PgicpvYW8LIjkHrHn/7Xb9oY8jOZr3xvayGZpM/h/mRJ7TJq
 3nFVrfgPsRn7dDSqEApNnM4pKU3QPvRmLkocz3VJhsquj5VzO6Eu4W5Zeico7oj/mKWP
 9QPA==
X-Gm-Message-State: AOJu0YwcNKUp5FsCur0TLQQtZIjvpJLa6Ew5SIsvi3/7C5CnYkukKFV6
 61bDFgeVZvg5r3LXs+t/EEaxfQXlYhZ155+MZsn6zFVBtpwjyx7QYlBRY7u7U4eF8IKZaf/aMQO
 2+aE=
X-Google-Smtp-Source: AGHT+IHgrdfUGxExfmeiVZFJz49YxyReBV+x2bLXB1dRKgM/0EF0wFR9DWXWgk6GHGRjO1XDlfFsDQ==
X-Received: by 2002:a05:6359:b93:b0:176:5a5e:4bf9 with SMTP id
 gf19-20020a0563590b9300b001765a5e4bf9mr1230177rwb.22.1707188743897; 
 Mon, 05 Feb 2024 19:05:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV8WDuLcy4YJ10lfwrUivAW5mQgGHmLvFuRKxi2q0Uy0aRurPqA1UpePfHngacFr0IO37zemgKtAo5HkyL6Bk5LpbKSFbH3Ovaz
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 4/6] target/arm: Split out make_svemte_desc
Date: Tue,  6 Feb 2024 13:05:25 +1000
Message-Id: <20240206030527.169147-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
References: <20240206030527.169147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 2628ac2840..8868aae5ac 100644
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
@@ -5225,25 +5237,16 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
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



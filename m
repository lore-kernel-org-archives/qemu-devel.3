Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC536C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObv-0004a5-U5; Fri, 09 Feb 2024 06:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObr-0004Cc-Kk
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:56 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObp-0000Kx-2a
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:55 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso208865b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476391; x=1708081191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2utYexfR0ld2jhiypN58zhvarosVBjZyxtkY8l6/4uU=;
 b=P61HhbD+3mQVD8rqq5L/+konONKqLiIUxjlX/r2qOSjZRbjq1luXVM0tGFz6xmVNMv
 WKQsJpvvOKafLo3nt/rMLLbA/8wxP8aoE0ZVCBCQlDwBfSbmNnQevE3mLMM7W5IkFt4q
 64G2Mhc4ig4ez2pBHRM+cqoB6Fe5SbnFubRSuih+NloS6UCr6h7zIBk9asOgeCc/xtFV
 EDnYxHy5bdqrrl0K6AUeseus7CM4qqia7lnj5nGffN1lpKpQGeegDs6ojrRvN6XuRsAV
 j2Uzkwdhxald0M08xOPwRylnQJuBxDdkvPkKhMwtlHxLuDVrEryO1O0Xx2untVa4xS4g
 F4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476391; x=1708081191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2utYexfR0ld2jhiypN58zhvarosVBjZyxtkY8l6/4uU=;
 b=Pn8GjdZfbtXoM95pOqi9Yiz9YC25N56ixsB0fGSiHRQQJEMTiV9vdr7kdwgwwOz3dB
 AsT322hHTJDY7IPz3i4veQSH8JvVNPu4/gUqySmvQ7LB84Ku82YsAEMvIoK0PZWLMNlV
 IkPBl35QKEQYDlQuxMaBw9scTYSwltZCv5Ndx6idbuxzL+q2PtpcHvkele0WEhlrkenW
 Ah+Mb7VUxtvBYrnIJ/TLurR71gfjDFV7OTTWb80kxYNkVIYBnkLqu2bxoSDvLyBlEVPV
 nruDMHYvd6ryxq1Y3GPksTNiRSVwr39DbdV1zaL/QkiFMs3RfMRyXFOI0MtvLbcKJDr0
 aEdg==
X-Gm-Message-State: AOJu0YwoKV41eCT5D3MBJ/G0l19rCiYKCbk7cBBaIt8LfJqTxJdgNUo5
 c89X+JyaK8F//ik8jqWp5vbWVMmxJagMdOj+09gC64laytHgZT46lRmqLUxdAXl41Q==
X-Google-Smtp-Source: AGHT+IG/ZJ69umGjvzNwIi4us0bHnSE+hSTAur0cnvDAToCxc2OkZ03+VIAfQQu/9wjrjPEUtx5dCA==
X-Received: by 2002:a05:6a20:94cd:b0:19e:a23f:2979 with SMTP id
 ht13-20020a056a2094cd00b0019ea23f2979mr1685978pzb.28.1707476391440; 
 Fri, 09 Feb 2024 02:59:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUqRZuNsr9H8frcafYUhEmY7ZT/pPVeBWOjIltYcfXhmKr45uVSCkqw095VF0jbVnxME9eXDTb/d0dfSKzqO9+c5hRAxi3yCZcujMNRUgecTlEW+LwwS5GJDEeZexD5bR5jv7BnsQlnbvv6+eYsezJ7EChAJIP2XCssFIBPSKw1Rjs=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:50 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/61] target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb'
Date: Fri,  9 Feb 2024 20:57:38 +1000
Message-ID: <20240209105813.3590056-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Use s->cfg_ptr->vlenb instead of "s->cfg_ptr->vlen / 8"  and
"s->cfg_ptr->vlen >> 3".

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 140 ++++++++++++------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3871f0ea73..d743675262 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -217,7 +217,7 @@ static bool trans_vsetivli(DisasContext *s, arg_vsetivli *a)
 /* vector register offset from env */
 static uint32_t vreg_ofs(DisasContext *s, int reg)
 {
-    return offsetof(CPURISCVState, vreg) + reg * s->cfg_ptr->vlen / 8;
+    return offsetof(CPURISCVState, vreg) + reg * s->cfg_ptr->vlenb;
 }
 
 /* check functions */
@@ -627,11 +627,11 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
      * As simd_desc supports at most 2048 bytes, and in this implementation,
      * the max vector group length is 4096 bytes. So split it into two parts.
      *
-     * The first part is vlen in bytes, encoded in maxsz of simd_desc.
+     * The first part is vlen in bytes (vlenb), encoded in maxsz of simd_desc.
      * The second part is lmul, encoded in data of simd_desc.
      */
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
@@ -791,8 +791,8 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
     stride = get_gpr(s, rs2, EXT_NONE);
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
@@ -897,8 +897,8 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     mask = tcg_temp_new_ptr();
     index = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
@@ -1036,8 +1036,8 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
@@ -1086,7 +1086,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
                              DisasContext *s, bool is_store)
 {
-    uint32_t evl = (s->cfg_ptr->vlen / 8) * nf / width;
+    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
     TCGLabel *over = gen_new_label();
     tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
 
@@ -1096,8 +1096,8 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
     dest = tcg_temp_new_ptr();
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     base = get_gpr(s, rs1, EXT_NONE);
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
@@ -1199,8 +1199,8 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
         data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
-                           tcg_env, s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8, data, fn);
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fn);
     }
     mark_vs_dirty(s);
     gen_set_label(over);
@@ -1248,8 +1248,8 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, vs2));
@@ -1410,8 +1410,8 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, vs2));
@@ -1492,8 +1492,8 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
-                           tcg_env, s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8,
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb,
                            data, fn);
         mark_vs_dirty(s);
         gen_set_label(over);
@@ -1568,8 +1568,8 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
-                           tcg_env, s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8, data, fn);
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
         gen_set_label(over);
         return true;
@@ -1639,8 +1639,8 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
     data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
     tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0), vreg_ofs(s, vs1),
-                       vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlen / 8,
-                       s->cfg_ptr->vlen / 8, data, fn);
+                       vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
+                       s->cfg_ptr->vlenb, data, fn);
     mark_vs_dirty(s);
     gen_set_label(over);
     return true;
@@ -1831,8 +1831,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -2036,8 +2036,8 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
             tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
-                               tcg_env, s->cfg_ptr->vlen / 8,
-                               s->cfg_ptr->vlen / 8, data,
+                               tcg_env, s->cfg_ptr->vlenb,
+                               s->cfg_ptr->vlenb, data,
                                fns[s->sew]);
             gen_set_label(over);
         }
@@ -2082,8 +2082,8 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             };
 
             tcg_gen_ext_tl_i64(s1_i64, s1);
-            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                              s->cfg_ptr->vlen / 8, data));
+            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1_i64, tcg_env, desc);
         }
@@ -2121,8 +2121,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
 
             s1 = tcg_constant_i64(simm);
             dest = tcg_temp_new_ptr();
-            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                              s->cfg_ptr->vlen / 8, data));
+            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
 
@@ -2275,8 +2275,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -2303,8 +2303,8 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                      s->cfg_ptr->vlen / 8, data));
+    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                      s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, vs2));
@@ -2391,8 +2391,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
                            vreg_ofs(s, a->rs1),                  \
                            vreg_ofs(s, a->rs2), tcg_env,         \
-                           s->cfg_ptr->vlen / 8,                 \
-                           s->cfg_ptr->vlen / 8, data,           \
+                           s->cfg_ptr->vlenb,                    \
+                           s->cfg_ptr->vlenb, data,              \
                            fns[s->sew - 1]);                     \
         mark_vs_dirty(s);                                        \
         gen_set_label(over);                                     \
@@ -2465,8 +2465,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -2581,8 +2581,8 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
         data = FIELD_DP32(data, VDATA, VMA, s->vma);
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs2), tcg_env,
-                           s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8, data, fn);
+                           s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
         gen_set_label(over);
         return true;
@@ -2691,8 +2691,8 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             do_nanbox(s, t1, cpu_fpr[a->rs1]);
 
             dest = tcg_temp_new_ptr();
-            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                              s->cfg_ptr->vlen / 8, data));
+            desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
@@ -2770,8 +2770,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -2821,8 +2821,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -2888,8 +2888,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -2937,8 +2937,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -3027,8 +3027,8 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data, fn);        \
+                           s->cfg_ptr->vlenb,                      \
+                           s->cfg_ptr->vlenb, data, fn);           \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
@@ -3061,8 +3061,8 @@ static bool trans_vcpop_m(DisasContext *s, arg_rmr *a)
         mask = tcg_temp_new_ptr();
         src2 = tcg_temp_new_ptr();
         dst = dest_gpr(s, a->rd);
-        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                          s->cfg_ptr->vlen / 8, data));
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                          s->cfg_ptr->vlenb, data));
 
         tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));
         tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
@@ -3090,8 +3090,8 @@ static bool trans_vfirst_m(DisasContext *s, arg_rmr *a)
         mask = tcg_temp_new_ptr();
         src2 = tcg_temp_new_ptr();
         dst = dest_gpr(s, a->rd);
-        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlen / 8,
-                                          s->cfg_ptr->vlen / 8, data));
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                          s->cfg_ptr->vlenb, data));
 
         tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));
         tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
@@ -3128,8 +3128,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
                            vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
-                           tcg_env, s->cfg_ptr->vlen / 8,          \
-                           s->cfg_ptr->vlen / 8,                   \
+                           tcg_env, s->cfg_ptr->vlenb,             \
+                           s->cfg_ptr->vlenb,                      \
                            data, fn);                              \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
@@ -3171,8 +3171,8 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         };
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs2), tcg_env,
-                           s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8, data, fns[s->sew]);
+                           s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data, fns[s->sew]);
         mark_vs_dirty(s);
         gen_set_label(over);
         return true;
@@ -3200,8 +3200,8 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
             gen_helper_vid_v_w, gen_helper_vid_v_d,
         };
         tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
-                           tcg_env, s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8,
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb,
                            data, fns[s->sew]);
         mark_vs_dirty(s);
         gen_set_label(over);
@@ -3620,8 +3620,8 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
         data = FIELD_DP32(data, VDATA, VTA, s->vta);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
-                           tcg_env, s->cfg_ptr->vlen / 8,
-                           s->cfg_ptr->vlen / 8, data,
+                           tcg_env, s->cfg_ptr->vlenb,
+                           s->cfg_ptr->vlenb, data,
                            fns[s->sew]);
         mark_vs_dirty(s);
         gen_set_label(over);
@@ -3641,7 +3641,7 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
         vext_check_isa_ill(s) &&                                        \
         QEMU_IS_ALIGNED(a->rd, LEN) &&                                  \
         QEMU_IS_ALIGNED(a->rs2, LEN)) {                                 \
-        uint32_t maxsz = (s->cfg_ptr->vlen >> 3) * LEN;                 \
+        uint32_t maxsz = s->cfg_ptr->vlenb * LEN;                       \
         if (s->vstart_eq_zero) {                                        \
             tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
@@ -3723,8 +3723,8 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
 
     tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                        vreg_ofs(s, a->rs2), tcg_env,
-                       s->cfg_ptr->vlen / 8,
-                       s->cfg_ptr->vlen / 8, data, fn);
+                       s->cfg_ptr->vlenb,
+                       s->cfg_ptr->vlenb, data, fn);
 
     mark_vs_dirty(s);
     gen_set_label(over);
-- 
2.43.0



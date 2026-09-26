Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B17C98335
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMVs-0001XA-8h; Sat, 26 Sep 2026 03:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRO-0004Ti-G9
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:22 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRM-0000cQ-JZ
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:22 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e62211987so1752506eec.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406199; x=1791010999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mzk09wMbsBzxAEmjnfDm9veq+liYVS/t1qc3bHMs1F0=;
 b=h+mI2LJPI3oic+I1abmEHubcZggE3ROj6hbmrGOnwe507fY2+D3lf+wJoFt8W7WrnX
 EQ+8exmu1nkG/BwRJTGXUJC8UfMUOiOcL8/sbOkL3jZIKecorEKwUKhtVuw9146Q67oC
 V44EesJXHinZuPchPOaJa0MfULBdB6VzCahXBlTaOsS2RjfZWeuFNSPa7MItTcgCspCo
 Ph9/DCKyG/EaY/SclOvnAkbpWDE0d7Yd/dj0eaytOhqq2+WfA85vJf0g2rVKoYevLoyk
 KVLZ7KxPYiuL5Xex9RRyYmCaF7wUunLXBXuik3sFsBK7bsruzd42hYQ/8KKV00bAwrPG
 QX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406199; x=1791010999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mzk09wMbsBzxAEmjnfDm9veq+liYVS/t1qc3bHMs1F0=;
 b=w448zeGs6seaCaYCYtHHvUOGojT0JkpmDbDIWjsAzwg3wzCrdxsVf8UVFJuXpzdQWv
 7cgrTnjZxuLwOPRh/wPVTCqRVRJZhuioRDvWKOcCsVfY0spPyYOU4HPvhIgmSIiTIdLu
 hYaLQpWcXtWqc6hDLdkCQxSPp3ZGsBRxkYrGL0KaZ8ZNdw34qHIr8phpE//HaOpStBYD
 pEPyXt9AHorPDBMJNieJdKpiWrkb2/uEXyC/4bGUZFLb6KVrJCDK7jdqb86yhhSg7LwS
 U11CMtb+0OQtsArjv9NOftkCP11xvzB8a7nwjZwIByUddO9HmbmRxcG793FQl9dKnRP/
 nyeA==
X-Gm-Message-State: AFuF++nq2yR/hTC3VfVsi5JshGFkGHHqWdSV8icMqKFB0wOOTDAdG1i1
 SLRmUn0tzX8hbvg3+417EoPL0GZis7EXGr5s1Hs0to0stqH2EGEkggJJXEJl3hWG
X-Gm-Gg: AYBFou33Y/FPN+Wcd6ff3GbRz3wXa9CLB7hqTa5JXodbI8lAGI30W9jyn/DwRk0P6Tb
 vX/wJVuxQSELXdoP9eS7MVijQ3m6qpYtG7JRIl/gRVi4wvdPUF7wEo54CnYeqvpjGFdfCWzJPbY
 fEczLCH1W7daqgwBUABTof2UaUbbmKt6kDNl/gaaCjHeVrOuBtipJzdXEXZkzN4RIdQl1RU00r1
 kvQs8JsuPt4id/0WWNEi+E6gT8gpVSCq/LMNTaDIcyUQO5xF6fl2pSCtGGF2Sfr6vzfcwWkMCJn
 2DfJ5INPQSe+vA4JG3DTsOJfz4NvQkRh22WElbpPl8chHefjfstcyH6a5JV5HZVssrXdjiE5B6Y
 Px4fjRmzgaAs2wBWC2U/sCNKnJ8x9TsilmrMx8rEYPbekcejo/7pmTsxWCCei9fEpfom1jPy1IL
 wNEDwjgVe1TkEKk/4hPYLiFwGslV7jgf2siCkDbe5F1QDg9GhpAfVR9lNxO5SIz9Qcc7pNKX15C
 DLC48kIquhsn3nQkNxi7zvA3b69kMw=
X-Received: by 2002:a05:7301:1506:b0:33b:e529:4446 with SMTP id
 5a478bee46e88-3426febb75bmr2204414eec.5.1790406199112; 
 Sat, 26 Sep 2026 00:03:19 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 34/55] target/arm: pass tl temps into SVE and SME helpers
Date: Sat, 26 Sep 2026 15:00:33 +0800
Message-ID: <20260926070057.1234-35-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SVE and SME helpers take tl, which is TCGv. A64 addresses and
cpu_reg() are TCGv_i64, so convert with tcg_tl_from_i64. Truncate the
SME tile index with extrl_i64_i32.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/translate-sme.c |  5 +++--
 target/arm/tcg/translate-sve.c | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 08b25b0be9d..e34e7d8744f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -64,7 +64,7 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
 
     /* Compute the final index, which is Rs+imm. */
     tmp = tcg_temp_new_i32();
-    tcg_gen_trunc_tl_i32(tmp, cpu_reg(s, rs));
+    tcg_gen_extrl_i64_i32(tmp, cpu_reg(s, rs));
     /*
      * Round the vector index down to a multiple of vec_mod if necessary.
      * We do this before adding the offset, to handle cases like
@@ -469,7 +469,8 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     desc = make_svemte_desc(s, streaming_vec_reg_size(s), 1, a->esz, a->st, 0);
 
-    fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
+    fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg,
+                                      tcg_tl_from_i64(addr),
                                       tcg_constant_i64(desc));
     return true;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 10375577b1e..9fd10168876 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -36,9 +36,9 @@ typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
-typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i64);
+typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv, TCGv_i64);
 typedef void gen_helper_gvec_mem_scatter(TCGv_env, TCGv_ptr, TCGv_ptr,
-                                         TCGv_ptr, TCGv_i64, TCGv_i64);
+                                         TCGv_ptr, TCGv, TCGv_i64);
 
 /*
  * Helpers for extracting complex instruction fields.
@@ -5378,7 +5378,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
-    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
+    fn(tcg_env, t_pg, tcg_tl_from_i64(addr), tcg_constant_i64(desc));
 }
 
 /* Indexed by [mte][be][dtype][nreg] */
@@ -5861,7 +5861,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
     desc = make_svemte_desc(s, 16, 1, dtype_msz(dtype), false, zt);
-    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
+    fn(tcg_env, t_pg, tcg_tl_from_i64(addr), tcg_constant_i64(desc));
 
     /* Replicate that first quadword.  */
     if (vsz > 16) {
@@ -5945,7 +5945,7 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
     desc = make_svemte_desc(s, 32, 1, dtype_msz(dtype), false, zt);
-    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
+    fn(tcg_env, t_pg, tcg_tl_from_i64(addr), tcg_constant_i64(desc));
 
     /*
      * Replicate that first octaword.
@@ -6286,7 +6286,8 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
 
     desc = make_svemte_desc(s, vec_full_reg_size(s), 1, msz, is_write, scale);
-    fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i64(desc));
+    fn(tcg_env, t_zt, t_pg, t_zm, tcg_tl_from_i64(scalar),
+       tcg_constant_i64(desc));
 }
 
 /* Indexed by [mte][be][ff][xs][u][msz].  */
@@ -8682,7 +8683,7 @@ TRANS_FEAT(SQCVTUN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
 static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
                        MemOp esz, bool is_write, int n, bool strided)
 {
-    typedef void ldst_c_fn(TCGv_env, TCGv_ptr, TCGv_i64,
+    typedef void ldst_c_fn(TCGv_env, TCGv_ptr, TCGv,
                            TCGv_i32, TCGv_i64);
     static ldst_c_fn * const f_ldst[2][2][4] = {
         { { gen_helper_sve2p1_ld1bb_c,
@@ -8747,7 +8748,8 @@ static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
     t_zd = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_zd, tcg_env, vec_full_reg_offset(s, zd));
 
-    f_ldst[is_write][be][esz](tcg_env, t_zd, addr, t_png, t_desc);
+    f_ldst[is_write][be][esz](tcg_env, t_zd, tcg_tl_from_i64(addr),
+                              t_png, t_desc);
     return true;
 }
 
-- 
2.52.0.windows.1



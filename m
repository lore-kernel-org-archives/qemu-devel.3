Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B32CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKl7-0002Zy-Vn; Fri, 29 Mar 2024 18:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl4-0002YU-BS
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl2-0003Wz-De
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso26332425ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751491; x=1712356291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMxM9BbQqKkbLwVKQwHtbDKmzoAaG7uKsKCnvfYND6Q=;
 b=J/oSCaGfW2OYnQUJcirGJ1b4ue8Bih9nmdnjRKzAK724ru8KDKkzs+IYrHHBFu70IM
 uhTRd1G8AZGRyLaInYAuz8t3fV+axxfZ9p4XaeqT4tx5IVH6+/1ekxa1nH8UHBLJ5KC+
 7z+XnXmZP13AHzPbhYMZTpV8Gf600maHwltVKfTnXkppzKnso4ZWSZb/yB8gl8+xip0M
 yeoS06YMR/64kLwGAz+nJPwvUwJONKpvXzp70e1be0eF5ZL5EC5EP3M75/o2zLjYi8HI
 THHsjSl5/XYpm61v73FOyXY7jvLim1edcNXsplY5CUC+NPb0oUEbnAXuGwksXDrqpV9t
 zsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751491; x=1712356291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMxM9BbQqKkbLwVKQwHtbDKmzoAaG7uKsKCnvfYND6Q=;
 b=lQytqXXMZnT9RVbdTkfkh5yYx+p+NHb1ReVLcXSdcOCeW6J81jcpZHULSekVSZXnjp
 RCq/z3bmrJdASR6Vuu2JwIu6cr+BcdAD20qZYGtHnOctISr8ZtAEvJeYvx5Cy5lr1Fhh
 FRuLd/5DOeKAlqoE7qDaQnogbZVHoK496oXgDgKLRWvb/DbJCIbn8soRCWIf/T/ZXJtL
 X5XWWXdd1k6i+dQ1G6kxhXBnTfjq0cAbV4trQAGeOYFnYmfSpLVYcn7b9DA3O7FsnZFv
 wj+JE/Edkd45Laav1/qaB5EGTyiJpLlg++jRm+3X7gOF+jtsyGonyKfOnTmSS6ZQMs6I
 OqCw==
X-Gm-Message-State: AOJu0YyaWMOOrmkpPKEBWfId9GpfUyXkpKHtORV1oNG8+QRI1ziXNu8a
 ETY2cJRPLVaKNOHrUS3ZajnLEQMm6zhl4/sBcXYaGsbqMr7mrPOYBl/qdNAj2GvCVw2rWkKE9bf
 e
X-Google-Smtp-Source: AGHT+IGOChND8cuZHt2ATEb6NXlBQvDebMm4JrDdHpX7MexxftbguuBFGFCgvew70H8gn09f4hgVcg==
X-Received: by 2002:a17:902:e5d0:b0:1e0:c88f:654f with SMTP id
 u16-20020a170902e5d000b001e0c88f654fmr9713486plf.33.1711751490945; 
 Fri, 29 Mar 2024 15:31:30 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 12/18] target/hppa: Squash d for pa1.x during decode
Date: Fri, 29 Mar 2024 12:31:05 -1000
Message-Id: <20240329223111.1735826-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The cond_need_ext predicate was created while we still had a
32-bit compilation mode.  It now makes more sense to treat D
as an absolute indicator of a 64-bit operation.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 20 +++++++++++++-------
 target/hppa/translate.c  | 38 ++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f58455dfdb..6a74cf23cd 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -57,6 +57,9 @@
 %neg_to_m       0:1      !function=neg_to_m
 %a_to_m         2:1      !function=neg_to_m
 %cmpbid_c       13:2     !function=cmpbid_c
+%d_5            5:1      !function=pa20_d
+%d_11           11:1     !function=pa20_d
+%d_13           13:1     !function=pa20_d
 
 ####
 # Argument set definitions
@@ -84,15 +87,16 @@
 # Format definitions
 ####
 
-@rr_cf_d        ...... r:5 ..... cf:4 ...... d:1 t:5    &rr_cf_d
+@rr_cf_d        ...... r:5 ..... cf:4 ...... . t:5      &rr_cf_d d=%d_5
 @rrr            ...... r2:5 r1:5 .... ....... t:5       &rrr
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
-@rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
+@rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... . t:5      &rrr_cf_d d=%d_5
 @rrr_sh         ...... r2:5 r1:5 ........ sh:2 . t:5    &rrr_sh
-@rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 d:1 t:5 &rrr_cf_d_sh
-@rrr_cf_d_sh0   ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d_sh sh=0
+@rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_d_sh d=%d_5
+@rrr_cf_d_sh0   ...... r2:5 r1:5 cf:4 ...... . t:5      &rrr_cf_d_sh d=%d_5 sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
-@rri_cf_d       ...... r:5  t:5  cf:4 d:1 ...........   &rri_cf_d i=%lowsign_11
+@rri_cf_d       ...... r:5  t:5  cf:4 . ...........     \
+                &rri_cf_d d=%d_11 i=%lowsign_11
 
 @rrb_cf         ...... r2:5 r1:5 c:3 ........... n:1 .  \
                 &rrb_c_f disp=%assemble_12
@@ -368,8 +372,10 @@ fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
 # Conditional Branches
 ####
 
-bb_sar          110000 00000 r:5 c:1 1 d:1 ........... n:1 . disp=%assemble_12
-bb_imm          110001 p:5   r:5 c:1 1 d:1 ........... n:1 . disp=%assemble_12
+bb_sar          110000 00000 r:5 c:1 1 . ........... n:1 . \
+                disp=%assemble_12 d=%d_13
+bb_imm          110001 p:5   r:5 c:1 1 . ........... n:1 . \
+                disp=%assemble_12 d=%d_13
 
 movb            110010 ..... ..... ... ........... . .  @rrb_cf f=0
 movbi           110011 ..... ..... ... ........... . .  @rib_cf f=0
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 99c5c4cbca..a70d644c0b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -200,6 +200,14 @@ static int cmpbid_c(DisasContext *ctx, int val)
     return val ? val : 4; /* 0 == "*<<" */
 }
 
+/*
+ * In many places pa1.x did not decode the bit that later became
+ * the pa2.0 D bit.  Suppress D unless the cpu is pa2.0.
+ */
+static int pa20_d(DisasContext *ctx, int val)
+{
+    return ctx->is_pa20 & val;
+}
 
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
@@ -693,12 +701,6 @@ static bool cond_need_cb(int c)
     return c == 4 || c == 5;
 }
 
-/* Need extensions from TCGv_i32 to TCGv_i64. */
-static bool cond_need_ext(DisasContext *ctx, bool d)
-{
-    return !(ctx->is_pa20 && d);
-}
-
 /*
  * Compute conditional for arithmetic.  See Page 5-3, Table 5-1, of
  * the Parisc 1.1 Architecture Reference Manual for details.
@@ -715,7 +717,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         cond = cond_make_f();
         break;
     case 1: /* = / <>        (Z / !Z) */
-        if (cond_need_ext(ctx, d)) {
+        if (!d) {
             tmp = tcg_temp_new_i64();
             tcg_gen_ext32u_i64(tmp, res);
             res = tmp;
@@ -725,7 +727,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new_i64();
         tcg_gen_xor_i64(tmp, res, sv);
-        if (cond_need_ext(ctx, d)) {
+        if (!d) {
             tcg_gen_ext32s_i64(tmp, tmp);
         }
         cond = cond_make_0_tmp(TCG_COND_LT, tmp);
@@ -742,7 +744,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
          */
         tmp = tcg_temp_new_i64();
         tcg_gen_eqv_i64(tmp, res, sv);
-        if (cond_need_ext(ctx, d)) {
+        if (!d) {
             tcg_gen_sextract_i64(tmp, tmp, 31, 1);
             tcg_gen_and_i64(tmp, tmp, res);
             tcg_gen_ext32u_i64(tmp, tmp);
@@ -760,13 +762,13 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         tmp = tcg_temp_new_i64();
         tcg_gen_neg_i64(tmp, cb_msb);
         tcg_gen_and_i64(tmp, tmp, res);
-        if (cond_need_ext(ctx, d)) {
+        if (!d) {
             tcg_gen_ext32u_i64(tmp, tmp);
         }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
     case 6: /* SV / NSV      (V / !V) */
-        if (cond_need_ext(ctx, d)) {
+        if (!d) {
             tmp = tcg_temp_new_i64();
             tcg_gen_ext32s_i64(tmp, sv);
             sv = tmp;
@@ -827,7 +829,7 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
     if (cf & 1) {
         tc = tcg_invert_cond(tc);
     }
-    if (cond_need_ext(ctx, d)) {
+    if (!d) {
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -904,7 +906,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
         g_assert_not_reached();
     }
 
-    if (cond_need_ext(ctx, d)) {
+    if (!d) {
         TCGv_i64 tmp = tcg_temp_new_i64();
 
         if (ext_uns) {
@@ -979,7 +981,7 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
                           TCGv_i64 cb, TCGv_i64 cb_msb)
 {
-    if (cond_need_ext(ctx, d)) {
+    if (!d) {
         TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_extract_i64(t, cb, 32, 1);
         return t;
@@ -3448,12 +3450,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
     tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
-    if (cond_need_ext(ctx, a->d)) {
+    if (a->d) {
+        tcg_gen_shl_i64(tmp, tcg_r, cpu_sar);
+    } else {
         /* Force shift into [32,63] */
         tcg_gen_ori_i64(tmp, cpu_sar, 32);
         tcg_gen_shl_i64(tmp, tcg_r, tmp);
-    } else {
-        tcg_gen_shl_i64(tmp, tcg_r, cpu_sar);
     }
 
     cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
@@ -3470,7 +3472,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 
     tmp = tcg_temp_new_i64();
     tcg_r = load_gpr(ctx, a->r);
-    p = a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
+    p = a->p | (a->d ? 0 : 32);
     tcg_gen_shli_i64(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
-- 
2.34.1



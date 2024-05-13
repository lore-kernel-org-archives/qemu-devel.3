Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAB0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPc-00031E-6r; Mon, 13 May 2024 03:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPI-0002q9-1e
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPG-0001N0-3N
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41fc5645bb1so30505765e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586453; x=1716191253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgExMg673JAx2cq5L5XNhe8VfWiBmskFq1MitzRUfrY=;
 b=TMPO7lsqoLJn4EcjGPKXwK+eqkDFIWwPbc1Q4MwC4vt251XtQ58Wg2i9QsIUxv/VZT
 QAwTOhrIpzjgUCILWBiLYogpMiNNaFqt3MjWDeQPIBQpO1wOL3k+UXLRIlI0igdvtpmo
 D5bmo5b5ugOfhh1O4LLsTVQgztS24ohrJiFgk3UlnADQeWMqdt4nNZHiIOLRz8EzDeia
 ponZTjalW8dhzXnlc1kiOh7T5b5+pW9WJS37HyFl7ugyfEdJYXdXTivB+4uF1YKp4ujX
 3T6Jm5/NkDFjGe39vBmtjC0GQnbKYoS731JXd27xwZ9kXQIgK/z3aSObZ5mLhZrH4g8Z
 uV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586453; x=1716191253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgExMg673JAx2cq5L5XNhe8VfWiBmskFq1MitzRUfrY=;
 b=R8dH01BreP7V0p5DKazWiXeJFaPhwpM9BVCyUdVO/Ban9bWJbZB13XJJvcSr/Y+df7
 lP6gWwCeK3kO10yLDM3Rl6oMPmEOHndQOhhrNB87e8Zw6GZb5S82+VlrznLRc0bjOE4j
 TRv4pjBV4utWnEnXZ5UoGV5Nt2KxAAg3AVQOHDq3Kuby4NvKmuUL9trZyCFG8dbMzDN0
 PLjdAKHJLu5gLU59ZdWDXZfoAyibmmjm9rLU10h2muRTnZkZSnQNvHUCKhVGdt3TaF5c
 ujlG1fIF3Ocpg3Ahzhyr47ZT51bMag8sUvvWmDBq/Ehv8QbNwKlP1E1w0AYZKFvWrfd8
 mb2Q==
X-Gm-Message-State: AOJu0YwGCfxctxWKTbQ+2os3Zq5HyFOq0ZuRyBLClFRzG4P/YMBCveU1
 o45Oz8efe5iC+22ysHBlYyor7DE4RJWaA0jGFvVQ4GVm2AzipUzUsXNrO7vLueqQmQUXb3A8W3I
 qumk=
X-Google-Smtp-Source: AGHT+IGwnpDU2OZy7V9x7Fnoo7ALYTPmXigXTchhdFsqm8lOFYWVlPNsEGP/njDEtXaaljW8IWAPrQ==
X-Received: by 2002:a05:600c:4688:b0:420:e63:5b2b with SMTP id
 5b1f17b1804b1-4200e635cdbmr45513355e9.18.1715586452679; 
 Mon, 13 May 2024 00:47:32 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 19/45] target/hppa: Rename cond_make_* helpers
Date: Mon, 13 May 2024 09:46:51 +0200
Message-Id: <20240513074717.130949-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Use 'v' for a variable that needs copying, 't' for a temp that
doesn't need copying, and 'i' for an immediate, and use this
naming for both arguments of the comparison.  So:

   cond_make_tmp -> cond_make_tt
   cond_make_0_tmp -> cond_make_ti
   cond_make_0 -> cond_make_vi
   cond_make -> cond_make_vv

Pass 0 explictly, rather than implicitly in the function name.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 196297422b..5e32d985c9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -345,32 +345,32 @@ static DisasCond cond_make_n(void)
     };
 }
 
-static DisasCond cond_make_tmp(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
+static DisasCond cond_make_tt(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     return (DisasCond){ .c = c, .a0 = a0, .a1 = a1 };
 }
 
-static DisasCond cond_make_0_tmp(TCGCond c, TCGv_i64 a0)
+static DisasCond cond_make_ti(TCGCond c, TCGv_i64 a0, uint64_t imm)
 {
-    return cond_make_tmp(c, a0, tcg_constant_i64(0));
+    return cond_make_tt(c, a0, tcg_constant_i64(imm));
 }
 
-static DisasCond cond_make_0(TCGCond c, TCGv_i64 a0)
+static DisasCond cond_make_vi(TCGCond c, TCGv_i64 a0, uint64_t imm)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
     tcg_gen_mov_i64(tmp, a0);
-    return cond_make_0_tmp(c, tmp);
+    return cond_make_ti(c, tmp, imm);
 }
 
-static DisasCond cond_make(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
+static DisasCond cond_make_vv(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
 
     tcg_gen_mov_i64(t0, a0);
     tcg_gen_mov_i64(t1, a1);
-    return cond_make_tmp(c, t0, t1);
+    return cond_make_tt(c, t0, t1);
 }
 
 static void cond_free(DisasCond *cond)
@@ -788,7 +788,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32u_i64(tmp, res);
             res = tmp;
         }
-        cond = cond_make_0(TCG_COND_EQ, res);
+        cond = cond_make_vi(TCG_COND_EQ, res, 0);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new_i64();
@@ -796,7 +796,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         if (!d) {
             tcg_gen_ext32s_i64(tmp, tmp);
         }
-        cond = cond_make_0_tmp(TCG_COND_LT, tmp);
+        cond = cond_make_ti(TCG_COND_LT, tmp, 0);
         break;
     case 3: /* <= / >        (N ^ V) | Z / !((N ^ V) | Z) */
         /*
@@ -818,10 +818,10 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_sari_i64(tmp, tmp, 63);
             tcg_gen_and_i64(tmp, tmp, res);
         }
-        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
+        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
         break;
     case 4: /* NUV / UV      (!UV / UV) */
-        cond = cond_make_0(TCG_COND_EQ, uv);
+        cond = cond_make_vi(TCG_COND_EQ, uv, 0);
         break;
     case 5: /* ZNV / VNZ     (!UV | Z / UV & !Z) */
         tmp = tcg_temp_new_i64();
@@ -829,7 +829,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         if (!d) {
             tcg_gen_ext32u_i64(tmp, tmp);
         }
-        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
+        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
         break;
     case 6: /* SV / NSV      (V / !V) */
         if (!d) {
@@ -837,12 +837,12 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32s_i64(tmp, sv);
             sv = tmp;
         }
-        cond = cond_make_0(TCG_COND_LT, sv);
+        cond = cond_make_ti(TCG_COND_LT, sv, 0);
         break;
     case 7: /* OD / EV */
         tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, res, 1);
-        cond = cond_make_0_tmp(TCG_COND_NE, tmp);
+        cond = cond_make_ti(TCG_COND_NE, tmp, 0);
         break;
     default:
         g_assert_not_reached();
@@ -904,9 +904,9 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32s_i64(t1, in1);
             tcg_gen_ext32s_i64(t2, in2);
         }
-        return cond_make_tmp(tc, t1, t2);
+        return cond_make_tt(tc, t1, t2);
     }
-    return cond_make(tc, in1, in2);
+    return cond_make_vv(tc, in1, in2);
 }
 
 /*
@@ -978,9 +978,9 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
         } else {
             tcg_gen_ext32s_i64(tmp, res);
         }
-        return cond_make_0_tmp(tc, tmp);
+        return cond_make_ti(tc, tmp, 0);
     }
-    return cond_make_0(tc, res);
+    return cond_make_vi(tc, res, 0);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
@@ -1039,7 +1039,7 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     tcg_gen_andc_i64(tmp, tmp, res);
     tcg_gen_andi_i64(tmp, tmp, sgns);
 
-    return cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp);
+    return cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp, 0);
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
@@ -1453,7 +1453,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         }
 
         tcg_gen_andi_i64(cb, cb, test_cb);
-        cond = cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb);
+        cond = cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb, 0);
     }
 
     if (is_tc) {
@@ -3542,7 +3542,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
         tcg_gen_shl_i64(tmp, tcg_r, tmp);
     }
 
-    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3559,7 +3559,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
     p = a->p | (a->d ? 0 : 32);
     tcg_gen_shli_i64(tmp, tcg_r, p);
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -4363,7 +4363,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         switch (a->c) {
         case 0: /* simple */
             tcg_gen_andi_i64(t, t, 0x4000000);
-            ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+            ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
             goto done;
         case 2: /* rej */
             inv = true;
@@ -4393,16 +4393,16 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         if (inv) {
             TCGv_i64 c = tcg_constant_i64(mask);
             tcg_gen_or_i64(t, t, c);
-            ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
+            ctx->null_cond = cond_make_tt(TCG_COND_EQ, t, c);
         } else {
             tcg_gen_andi_i64(t, t, mask);
-            ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
+            ctx->null_cond = cond_make_ti(TCG_COND_EQ, t, 0);
         }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
 
         tcg_gen_extract_i64(t, t, 21 - cbit, 1);
-        ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+        ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
     }
 
  done:
-- 
2.34.1



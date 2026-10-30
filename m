Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rEw/eD2u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsVk-00065J-5T; Fri, 30 Oct 2026 15:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVe-00062T-G4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:30 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVa-00008e-MO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:30 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8446af403b5so724462a34.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389405; x=1793994205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bTT5vtAAIxx2d8smbIu/wyEaPE7+A17JEsJOBrWBYkE=;
 b=rEw/eD2u2Q6dwYHvJ5SkDjvDJuOiMeaNBudoeBRYislirtINKzFce96rMy9ED2PRHU
 3H2sYbvNpbx/cgAG2VdezNAzgxllkL+erxVMpIqeejXwXT2akzzy70fJjuyi21F7Ru0M
 wwGYRs4PWI9rQ55Ij0g/JGL6J1Wy7KpAs96f13rnkf1XyM2K4AYdPIFUB0rkgDiTz918
 dyQ4TYvjfZ8Yt2WSi5v9dzXZb1xH+BpD9gHmbM2MqQKcglIG87RpniZKd8WPpUfNwS+1
 KnPYZz1inbjuMItxe8eLYsOn2xc72bdj3OgEPpY2Jcr3KGVPPaXlSH5WpOduWDAE74IO
 X8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389405; x=1793994205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bTT5vtAAIxx2d8smbIu/wyEaPE7+A17JEsJOBrWBYkE=;
 b=zRO72fiKKNprHpjyuCBPY82JRw1SolM4Swd87Y4q3K+0WqleRhkp0kujsva8yoja3f
 fxB6Sbd6hLNnk+9veEaD+e4huQnAWxnjkxzWINWIw5KWhq0BDW4YiFEjwJ2dn3XcxMQA
 jbM+XE1u9F15bagFRNDNOImDh163nPnvOgrBOjtfv9V6UYedewaHsA3ju0cS5IsdKujy
 4IVFwmoo3RD4ORliE9MHU7g9GLz0NS9l6RQHRwyLyZJ+n9XWUk2MUqjM2w+v45pJo9o1
 SxEYkgykTgzvvDNgJYMBs3NIHxPQ61B6wuKfRVfxh6GzURwcBedcN0ItvMaSbX/+ro+O
 K2mA==
X-Gm-Message-State: AFq9FYJkm97BAJE4zFH0UvdWxfRUiuYBYGqATlMtZ6LiUp9WzPZmPnia
 fuFRQeBzSk6ty6ijedRp620cJBEqgjeOZDMfwZjs1PKK0X2uls8Ax4yiiNbz0jSYbAmupIVGJGQ
 sxLIu
X-Gm-Gg: AYBFou1s28vv5ho4WaimIfx1tKKw+UGvaxpImyy0I9r8wUwKmeiV2LOjB/Wawpchw7s
 JJr5Ad/BN5eMvB+TlkNGzDA2bDwsV0S9M8DXZQjahV+i3jgtQPxlwmBKF4XQxb1afmSo0TEmdSo
 oMPYE+4AsKltdaSlgT88am6s7pnQl/bWOuX/Of9aylYJMkhCGk5fTd8rMyviyzB3QRtPO6wTUvq
 3Y0uQDyEf1+9DCJR6WzKrnomAGvwmZIZ9bFqSem/CVLWmEBbxlpLXummke7RupgzWMf6waM0/6A
 T6y2Q67d2KIFf3sofgxUZspii5OFoyaSaBwInfDIMcD6DNTrhHtMMIg3qNC9nSEiib0Ev5uhWoq
 AM/5oBlL73QY4vJIExtCa4YjBCDNHIU18AOl0WnJdTmwevPKBx9ZYBwmP4bJkmlnATY+YQ3ISe6
 5hA3Mks0W5T4PMT1ArGWlKxvf+wkJrm4Qvpn5ULQ4wSiAIXI53l45JEMBZRbXhWIzzhOFAVzuFY
 Kj+ezxQMrDQhWtAy1rUf2cyNic41cfafAsFHzN4y0GtqZzP/HwBsMQMbn4WXhTPeggy7gcBNPGa
 iNiDpJfOMvu0amJhnQsI0tYRJUHPz/nZXy0=
X-Received: by 2002:a05:6830:25d6:b0:829:9992:20e7 with SMTP id
 46e09a7af769-85d366454f8mr2695887a34.30.1793389405050; 
 Fri, 30 Oct 2026 12:43:25 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/9] target/arm: Add second value to DisasCompare64
Date: Fri, 30 Oct 2026 14:43:12 -0500
Message-ID: <20261030194318.319310-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do not assume zero for the second value.
But do set it to zero in a64_test_cc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 64e28a089a..884b7d78e2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -477,7 +477,8 @@ static void gen_load_check_gcs_record(DisasContext *s, TCGv_i64 target,
 
 typedef struct DisasCompare64 {
     TCGCond cond;
-    TCGv_i64 value;
+    TCGv_i64 v1;
+    TCGv_i64 v2;
 } DisasCompare64;
 
 static void a64_test_cc(DisasCompare64 *c64, int cc)
@@ -491,8 +492,9 @@ static void a64_test_cc(DisasCompare64 *c64, int cc)
      * properly.  The NE/EQ comparisons are also fine with this choice.
       */
     c64->cond = c32.cond;
-    c64->value = tcg_temp_new_i64();
-    tcg_gen_ext_i32_i64(c64->value, c32.value);
+    c64->v1 = tcg_temp_new_i64();
+    tcg_gen_ext_i32_i64(c64->v1, c32.value);
+    c64->v2 = tcg_constant_i64(0);
 }
 
 static void gen_rebuild_hflags(DisasContext *s)
@@ -7803,8 +7805,7 @@ static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
     read_vec_element(s, t_false, a->rm, 0, a->esz);
 
     a64_test_cc(&c, a->cond);
-    tcg_gen_movcond_i64(c.cond, t_true, c.value, tcg_constant_i64(0),
-                        t_true, t_false);
+    tcg_gen_movcond_i64(c.cond, t_true, c.v1, c.v2, t_true, t_false);
 
     /*
      * Note that sregs & hregs write back zeros to the high bits,
@@ -9485,7 +9486,6 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
 static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
     TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
-    TCGv_i64 zero = tcg_constant_i64(0);
     DisasCompare64 c;
 
     a64_test_cc(&c, a->cond);
@@ -9493,11 +9493,9 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     if (a->rn == 31 && a->rm == 31 && (a->else_inc ^ a->else_inv)) {
         /* CSET & CSETM.  */
         if (a->else_inv) {
-            tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond),
-                                   tcg_rd, c.value, zero);
+            tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond), tcg_rd, c.v1, c.v2);
         } else {
-            tcg_gen_setcond_i64(tcg_invert_cond(c.cond),
-                                tcg_rd, c.value, zero);
+            tcg_gen_setcond_i64(tcg_invert_cond(c.cond), tcg_rd, c.v1, c.v2);
         }
     } else {
         TCGv_i64 t_true = cpu_reg(s, a->rn);
@@ -9510,7 +9508,7 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
         } else if (a->else_inc) {
             tcg_gen_addi_i64(t_false, t_false, 1);
         }
-        tcg_gen_movcond_i64(c.cond, tcg_rd, c.value, zero, t_true, t_false);
+        tcg_gen_movcond_i64(c.cond, tcg_rd, c.v1, c.v2, t_true, t_false);
     }
 
     if (!a->sf) {
-- 
2.53.0



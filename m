Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C77C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjV-0002Q6-ME; Sat, 02 Mar 2024 00:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjU-0002PS-3R
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:24 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjS-0007VF-CL
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:23 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so2715095b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356581; x=1709961381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UUMLLXsAT9hxWNYnOEqNqemxeKUB6s4UmOAyXwA2RU=;
 b=KvKu9Bjn6be6Zv7DCJKCbG7z6wGHWl0J306qYYK3ZLeJ0m+KnQVXuwvq0ziJ5QCEP5
 k6vS6lk0KosdLlZTH9k8zZFmX5zGFZFyjXr9RSoh21pJAyHLjoZqZG6PfuiNF6UuzqI4
 NmMi/KfhoPdufhu0SwdRHZ7aPW6iI1xT1s/ZHJwMrhaBdEGPRr3asv6e/eKswQEqZnx7
 NoR8U05d6sfBIS7OfjymgRi41nknyxsQnhWy18E+MF3Iye4JE6q6RlfOc3iwqKj3mONW
 hT2GRwMiRT3QhgOBx05OnJMOo0np4Ep6theBRlwEwP1Uf059gK2NUi108VUMsdBRkF00
 XMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356581; x=1709961381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UUMLLXsAT9hxWNYnOEqNqemxeKUB6s4UmOAyXwA2RU=;
 b=m5xiVZ2NWPfw6bCj+/IBUXVgtCZBy+QhsH7u6f8nZxHnuO3QAUy3S/ttsOQhtOvUFL
 O82ObQatS18mj0eTE4wHE8O/Brj7c8zNauJJxyXrnZ5J0d4+ivXxUNBG7iF4m0rU6aS1
 BKxWDo29GkCmk2HKWf7c1qtOsbT2aUsVflbMsMoG4FIytH6jQuAh3LWTYI4CPMqoKsQS
 OjdSkSV51y+UI+16Zy8P+T20MSHFj0dEANpIonGekMjJO9ll9DuuAIYhORa60pRkmeYt
 q7Z1Df3dn/IdF8bxs09doeDlPA4w76VtsO3lDhmw5hR6XPLB8pARotYQysNuuPGr0mUT
 dblg==
X-Gm-Message-State: AOJu0Yy8mStaR9EixwDXwDwBpRfD3Gp1SkMnW3QrgCrXnGvOGhREymOL
 B2v5S3Iu3/tiIqkbO0eM/qw5KncCmqePboEmm/Mu8iTkgyTbA74nAVP55pyjIUC1pZFADMjzog/
 c
X-Google-Smtp-Source: AGHT+IHiLaxnjaXHxxFYZ/xUlTdbUjiTZ4Trr+JMV5bddvjPov1of5bd29pJX5wxoUL2oRlYggRcTg==
X-Received: by 2002:a05:6a20:af11:b0:1a0:ff4d:eb2d with SMTP id
 dr17-20020a056a20af1100b001a0ff4deb2dmr3034169pzb.54.1709356580840; 
 Fri, 01 Mar 2024 21:16:20 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 09/41] target/sparc: Remove gen_dest_fpr_D
Date: Fri,  1 Mar 2024 19:15:29 -1000
Message-Id: <20240302051601.53649-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Replace with tcg_temp_new_i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 97a5c636d2..ddceb25b08 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -250,11 +250,6 @@ static void gen_store_fpr_D(DisasContext *dc, unsigned int dst, TCGv_i64 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
-{
-    return cpu_fpr[dst / 2];
-}
-
 static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
 {
     TCGv_i128 ret = tcg_temp_new_i128();
@@ -1985,7 +1980,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
-    TCGv_i64 dst = gen_dest_fpr_D(dc, rd);
+    TCGv_i64 dst = tcg_temp_new_i64();
     tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, tcg_constant_tl(cmp->c2),
                         gen_load_fpr_D(dc, rs),
                         gen_load_fpr_D(dc, rd));
@@ -4326,7 +4321,7 @@ static bool do_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4348,7 +4343,7 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4388,7 +4383,7 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_F(dc, a->rs);
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4479,7 +4474,7 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     }
 
     src = gen_load_fpr_Q(dc, a->rs);
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
@@ -4594,7 +4589,7 @@ static bool do_dff(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     func(dst, src1, src2);
@@ -4618,7 +4613,7 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, src1, src2);
@@ -4637,7 +4632,7 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, src1, src2);
@@ -4702,7 +4697,7 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, tcg_env, src1, src2);
@@ -4727,7 +4722,7 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
         return raise_unimpfpop(dc);
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     gen_helper_fsmuld(dst, tcg_env, src1, src2);
@@ -4744,7 +4739,7 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst  = gen_dest_fpr_D(dc, a->rd);
+    dst  = tcg_temp_new_i64();
     src0 = gen_load_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-- 
2.34.1



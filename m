Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4DC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmTA-00034Z-TH; Fri, 02 Feb 2024 00:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT7-00033T-QU
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:52:05 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT6-00029R-CS
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:52:05 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bbb4806f67so1238114b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853123; x=1707457923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYTSRpCGethKLnoY2fpF4KOBgpBDTTihXu+DADLRFZw=;
 b=SxbBIAnh+mEUJfXX2oqKYBbyLGbvAW+0NnQIVH9c3VpmCsvcov3R7SzXdDjB1B9kZI
 19w2NzjMGcVknhgAyWTJnfHVt6q1eiAT5ds7LySd0unjZWX8MOhsnXT6M2XLexo2mUg+
 L0Z+XzDx6PQpXRS716I0w5y7woHfowNl94B8SRmAfEEpD+1dQD6C1KlVrfik/dEKFlG5
 A+i7dmqYd3yrcWZVb98CuiVn+fo35iiOieT7yVzlNXIVf1ehFsSHFV6oGcpGbrc9r5oe
 CnmpmtJt+JaWJz22RDHvrH1W11c6hPnY+MCwkEyPAKAWV8dtw++l2LM9HpL46NPBOuh2
 11xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853123; x=1707457923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYTSRpCGethKLnoY2fpF4KOBgpBDTTihXu+DADLRFZw=;
 b=d8VNViicoa+2O+Ch5IhACgueXmBlRVBsSadQxOS0RZlAk/Ihx8AO0ou0U2VZwMFNRV
 CCFjhvGYRfn5/k1+XDJc4/J1l4ss4TwwgUYpDRXwwVf4fxfweh3bbGiiHT6+9RVdNsEh
 /z6Z3/8C6KgB9koVxYq8nioUjqZvusv/qoPUwWCP9JN22WgekMbaHJvzAy3XI6COO2Y2
 7zaSXRTuOj9DxTsu5Tn/GUvhWJdhdvBBlLqnDZm96ppVLyRyzgJnorJx2LJsDk5Kx+6J
 rwhc/IOsDx/uLwhldAFEdCQYgnu4Tc06cCBwo/6AyK2NlmxUHns0o9YEJtzOHPG45A5W
 dh8w==
X-Gm-Message-State: AOJu0YwlUO/azNgNqLDT2G88Mak+KAY1Iu9SBo68Np+1y/sFW6Kk23Fj
 76KDA4iR52aHSlvB3ooshr/YvWmWcTLEhZR3mrB2/MF5qkvJXC+FX6L+3HU6nyny7LziHxsiP4v
 +xi4=
X-Google-Smtp-Source: AGHT+IHNLNOvT7g2SZcmtcnLr1nMOTxMbyrvCp1UgsHd1DFD2mecBtm35Bmq7TrYGzxKUmteoR764w==
X-Received: by 2002:a05:6808:3089:b0:3bf:be81:923f with SMTP id
 bl9-20020a056808308900b003bfbe81923fmr1122993oib.24.1706853123218; 
 Thu, 01 Feb 2024 21:52:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW4syu0BZIlc+TjlkGmv7yZ5hSe9DZKQ16WLTrqXy1Nk4iXOJx97MF/uN8v52uJ2sb94CZoXXyvPpeMEGShj28XxTsm9wBdCQ+WTjLCug==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:52:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 38/57] target/sparc: Remove gen_dest_fpr_F
Date: Fri,  2 Feb 2024 15:50:17 +1000
Message-Id: <20240202055036.684176-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Replace with tcg_temp_new_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-4-richard.henderson@linaro.org>
---
 target/sparc/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3a59262c9a..6824b5d835 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -246,11 +246,6 @@ static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static TCGv_i32 gen_dest_fpr_F(DisasContext *dc)
-{
-    return tcg_temp_new_i32();
-}
-
 static TCGv_i64 gen_load_fpr_D(DisasContext *dc, unsigned int src)
 {
     src = DFPREG(src);
@@ -1873,7 +1868,7 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
         memop |= MO_ALIGN_4;
         switch (size) {
         case MO_32:
-            d32 = gen_dest_fpr_F(dc);
+            d32 = tcg_temp_new_i32();
             tcg_gen_qemu_ld_i32(d32, addr, da->mem_idx, memop);
             gen_store_fpr_F(dc, rd, d32);
             break;
@@ -1938,7 +1933,7 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
             case MO_32:
                 d64 = tcg_temp_new_i64();
                 gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
-                d32 = gen_dest_fpr_F(dc);
+                d32 = tcg_temp_new_i32();
                 tcg_gen_extrl_i64_i32(d32, d64);
                 gen_store_fpr_F(dc, rd, d32);
                 break;
@@ -2228,7 +2223,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 
     s1 = gen_load_fpr_F(dc, rs);
     s2 = gen_load_fpr_F(dc, rd);
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     zero = tcg_constant_i32(0);
 
     tcg_gen_movcond_i32(TCG_COND_NE, dst, c32, zero, s1, s2);
@@ -4497,7 +4492,7 @@ static bool do_fd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, src);
     gen_store_fpr_F(dc, a->rd, dst);
@@ -4539,7 +4534,7 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
@@ -4697,7 +4692,7 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 
     gen_op_clear_ieee_excp_and_FTT();
     gen_op_load_fpr_QT1(QFPREG(a->rs));
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     func(dst, tcg_env);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, dst);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C40C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Ug-00046v-FI; Thu, 17 Sep 2026 05:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ua-00042z-FC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:20 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UY-00018B-Im
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:20 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so522056a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637597; x=1790242397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NJ/JA2pxOKPZz3qGUxEN1RSxQYKHeWKLy62SE7IZXS4=;
 b=tLKvFYDj1OCFb5joTPzGay+suInQYat6sLp9DrP9pKURozDL0eXFu3HT3KrXc6c5ik
 1kssAyTHfj7Gp30qiHDKsRbTyqqR9+BWXN8hLVUynXbPg07sYsFT+J9T6ySS5eQDFOJn
 Jo58jC6ZTy8eFvKnAG0IE+L3BEkUx5CH5xQbMSa25DKf0lY+glxOSjVxT9TzXxnhsFJn
 NE3WRozWUDkdJO9Et8/jgQOB0a/lMFrv067PU4wrOHAJvNVlwPeOP+SwVZP6y3Zi/VRz
 WyHX09So0BtISgSVwUL0yyTo4GFtcrXkMzGdUy2TNYWvTeCL9BXAJ94Fxb+lt42qWleU
 AV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637597; x=1790242397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NJ/JA2pxOKPZz3qGUxEN1RSxQYKHeWKLy62SE7IZXS4=;
 b=ne1E/PHnLLgDG0O4zfH1OCFFsrrXZYwJLpeOlcCNWFTxg3SURCFkJQyu5FffJACkiV
 2Gusk4dYFAzJIsv+sqibhhkOhtSUXjW/uwKuR+TuWoh2fRxxQlGn6eYr2eEg7mMsA3ea
 BrsPfsMzeeuN14NRLLnhKS6diYATeZ0nwu/PHCkENRUvKH2qUbXhhRCBRjNnmLTJZL2s
 Fzah+Z/J1zSuhI6rSzGzwf+DXP3PY2jsyiXNQ6St6b0a3cPpZcJLsbTmVaQO8F+DLMjs
 uysLAXWU6UGwhVH1dHw2r+0b0dJPULWVioUxYn6lkVD/ROLKCdpEESq8Uhp0VoyuGnOr
 JN5Q==
X-Gm-Message-State: AFuF++lliAE049FXzc+7HVpZ1yD4vlwshgIJY9Nzab++LhdV4yBoB4yW
 +ypDRDu/Wr0vsW21oYsZnq1Sgx8lLFMBUyUTKxkg9Kv6P/b03VvEi/psy6ktsZ2ink3IyouB1HX
 s8O3EdEc=
X-Gm-Gg: AYBFou3npHVe1I2ypbR8qxvm5l6jeyUHxjmiKb4Q6oLMTZq6D1Uoncb3YT+09JjpLen
 11wAxlxQEllLZ+QTxdIvkSZJpbYzUHupBIRdVG1Lh2dHFeXppVWn+jxqRQPW9UqWYbqkTS15HPb
 TE5axuTx51rhv4LwL15h6ybEwQHHhoUfT9d+W/WKqGCQIvwOy705u2Vp4e+KMNX1UP4wdJaoiox
 DA4+M9GdAdVx5LVgmZ3mSE4UecPOaKhUgAAEXslqIQktf4U0lF2wXLMlPKno9kF3DecTWyDupmk
 Ymq037dy/Q7vXFw7Oy3G/RPu3aEJHkHbpsDfQyGw9KKXzTIziVhrytNw6+uIZeWwsokYV1XnVnA
 je5Gwp4euQVesVp3Tyy6WimzEnz+AZdQJusSDH3yOHpgDnPC1ihthCKO/bB0c7r3qOxCDI091On
 7pw3mkAn8TVBhWDaXPCfR0B+01bOc+PnBPCyNO1Us7AOCPEtniXTwXZfnV7CbEuhzY32AEkKlei
 eCpfmYSn+hzWl57NQ==
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id
 98e67ed59e1d1-39e1e504f3fmr20726882a91.20.1789637597135; 
 Thu, 17 Sep 2026 02:33:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 06/13] target/s390x/tcg: Use tcg_gen_goto_jc3_i64 for
 branches
Date: Wed, 16 Sep 2026 23:33:00 -1000
Message-ID: <20260917093307.1092084-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Introduce gen_goto_jc as a helper.  Use it instead of
DISAS_PC_CC_UPDATED or tcg_gen_lookup_and_goto_ptr
within help_goto_direct, help_goto_indirect, and help_branch.
Always return DISAS_NORETURN from those functions.

Do not use goto_jc elsewhere as yet.
At least op_ex, op_sacf, op_sam require other updates;
icount and PER_IFETCH want to use goto_tb not goto_jc.
and PER_IFETCH needs some TLC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 991df67a419..2f3e7b36824 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -638,6 +638,15 @@ static bool use_goto_tb(DisasContext *s, uint64_t dest)
     return translator_use_goto_tb(&s->base, dest);
 }
 
+static void gen_goto_jc(DisasContext *s)
+{
+    /*
+     * ex_value, aka cs_base, is only ever live at the start of a TB
+     * and is immediately cleared.  It is only ever set by op_ex().
+     */
+    tcg_gen_goto_jc3_i64(psw_addr, tcg_constant_i64(0), s->base.tb->flags);
+}
+
 static void account_noninline_branch(DisasContext *s, int cc_op)
 {
 #ifdef DEBUG_INLINE_BRANCHES
@@ -1082,11 +1091,11 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
         tcg_gen_exit_tb(s->base.tb, 0);
-        return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(psw_addr, dest);
-        return DISAS_PC_CC_UPDATED;
+        gen_goto_jc(s);
     }
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
@@ -1095,7 +1104,8 @@ static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
     per_breaking_event(s);
     tcg_gen_mov_i64(psw_addr, dest);
     per_branch(s, psw_addr);
-    return DISAS_PC_CC_UPDATED;
+    gen_goto_jc(s);
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
@@ -1157,7 +1167,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         tcg_gen_goto_tb(0);
         tcg_gen_exit_tb(s->base.tb, 0);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        gen_goto_jc(s);
     }
 
     gen_set_label(lab);
@@ -1167,9 +1177,10 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
     if (use_goto_tb(s, s->pc_tmp)) {
         tcg_gen_goto_tb(1);
         tcg_gen_exit_tb(s->base.tb, 1);
-        return DISAS_NORETURN;
+    } else {
+        gen_goto_jc(s);
     }
-    return DISAS_PC_CC_UPDATED;
+    return DISAS_NORETURN;
 }
 
 /* ====================================================================== */
-- 
2.53.0



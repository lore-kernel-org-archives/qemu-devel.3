Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12762606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iacgTs0l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrm6-0006xw-KM; Fri, 30 Oct 2026 14:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrln-0006s9-5l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:09 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrll-0004oJ-O3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:06 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ae8607e8afso8576697b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386564; x=1793991364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=snPje9eTvXO8WBl9g3A/YZtenSR0D0gyFjZLY0cCXkA=;
 b=iacgTs0lnxo0ClmV0QWQ/QeVxa3zvHS8pIUjKT+46noTDd7D/qlsOFiYx6fi6UXTqy
 M7/xFQycRwgA7ySMKQ87PP2itsXZj0zKI4PPHN1rJ5L3I/UH8D0pVE2DKdV0O6q/BFkR
 QTbfI1v/q/qKTyii+4F2GwPOz+kbuwIfb3qapYiQ8U7PkYQj36sSH7dmLMEMwdlLCeai
 mhNizt8EOtk7c/Exgdgc3IOtJjormsUg3EYo4lGmcfV1CPa6dfgMsE6SzrQaEZH9khS0
 kkyMKiuvo4kcQobOraNC3M32AE49n52ytJTcsmRer5aYH5HMI+vxCmlY4fP+Am2F6xAb
 afIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386564; x=1793991364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=snPje9eTvXO8WBl9g3A/YZtenSR0D0gyFjZLY0cCXkA=;
 b=AMfDTvMlWqRpnIvdeWc96+LqadpPda4bASmjXffuSP2e/hK7iiwLLtyzI4e71oyjN+
 xzXfbYpOZ6vzy17dt12sC2raeIizRc0lqt+zvVZzzX3jIcG5O/gHepJaqBDyRkdiUjRa
 qmRnKZP7RJ9UHe2SAzrR9S8INtj2FAig0/A2AaBJLT8IT8jRdQ0AUPV//8ni2A6s0ISK
 Np+JxBAk/ArjO1dtxp0H5zmh80mXFus7ELqbf867E2ud3athbT52J65veBhFBRrJ/FXD
 BWKQkLIIN3nABzzF76gUE0wYsogZLIZOt1oJ9KZA9iY+sufCInr3Whr9zqK5QHZ6nnOq
 0DIQ==
X-Gm-Message-State: AFq9FYKBY5fwSK9cqHGoDWoqBW7oiakb8nC2vzYVPv2qXAnKjTq/Xrj4
 QvIkwnSAn82kv43ec9KUyiPFSg4HQCIgzL461bIsEv5tf4PPwz0GIDE3mokEcUvG6YPmN0XwNxu
 JQkug
X-Gm-Gg: AYBFou1/8mm1TwDyx2GgcXJw1irKqOSx84E1/DsoQmOvSgeMOoMpy0bRZSXAvYhpqW+
 nrNGp6bNQxoCIFoZqdolBCbunwwG3fHT6Bn1lYJ973K51Q8QE8NerM+w/UXSwz4qjWrDfudOAVn
 roeZ977t/Vq9uivq2GvLztHTPxk+ISs7JqDqkOSqX1fpF8epjd+xZfFomwbdJnvzn+MWQx1pWT+
 hdBB+bIH8i7qMycdzvTdwSb2fyvl/s5Zy+hnR3+YV/485yMBdBseOhVlmYVyOON5qlA3eBV/Vss
 giUP5jxQ/koDmXugfOjJ0lyExmMvJrTAzAp7ybH7LOOm3HqKrKDNA+1UKkOAmWiroDvXcne36hA
 7yWWH/npi9C6INAGmG1Qnp4XRHef2/WOzfHkML4m0W5ssMYy0/rlVVYwd9gO6hpX8esOLYXztJ9
 5z8phGNQ09i8BjtyQ+IEY1ABnfCt0Bo4haJHt2xLHdOoOzYT5T2T57gznIizqpp6oW2cU8jNTg2
 wy4x1D+0T1LImEKxNeWoZadKz840XQyZSJlu7ryD23vj3czKbd5AagmeZ6A2y053k9z8Vtp6dCx
 YUecCgqzbxzAWggt4KbTh85mZV0AIYzf/34=
X-Received: by 2002:a05:690c:289:b0:871:bc3:9856 with SMTP id
 00721157ae682-8b2b672fd3bmr15544327b3.33.1793386564590; 
 Fri, 30 Oct 2026 11:56:04 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 06/14] target/s390x/tcg: Use tcg_gen_goto_jc3_i64 for
 branches
Date: Fri, 30 Oct 2026 13:55:43 -0500
Message-ID: <20261030185551.193092-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1136.google.com
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
index 3a29555605..685628789f 100644
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



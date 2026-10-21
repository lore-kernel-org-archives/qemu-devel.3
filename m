Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A9606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YnZsB+sc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIS-0000NA-Fb; Wed, 21 Oct 2026 10:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGh-0006c9-LY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGf-0002Yz-Ms
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso531489f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592772; x=1793197572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QEwhlDRyi8Ke5RlKELTb6AB3Mv2yvChgDRF8GEJIWxg=;
 b=YnZsB+scmloOpVeKo8I65Cq/U1BcqZ40GWfZi/9KFZczzJ7nCKncC48FgubDAsOycg
 SoJUXQNje5ZTm8VW2+bqjLifL+SkO90vbsOlijVVFgUVQp7+swzKbS6ERFuts+4WIhhV
 CzXF5jlqcVxp0HeDkLQakf29/bb0WDM5fIXvYih6YctZ2xpYhbovPp9Gsj71nPsuCtyT
 RR+1+DKHLjErEgXWVtlm2K5bVTQDCjibmFlB2pCshyUxl0/4hdvZ7b8sXHuwH2Px2kK1
 QTcaQc5jdWAL5VN71dkclDxcavunxAdZ+LNNw2VxeoRxW/1PiYU7t27ocRwIoMafPAox
 XdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592772; x=1793197572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QEwhlDRyi8Ke5RlKELTb6AB3Mv2yvChgDRF8GEJIWxg=;
 b=tZPj4RIz+qLpe2YI+/rB3PwHtxiGGc38ciGJBrjVZJjxnDlfWVUjpQJO5TTrArFDB/
 TrDVMvh18edNh6XN3jOo02/jskosL1DO9UFYigzXtDOL0OMMyMmSxPgtKvptbeYqa+DN
 ZROP5bSqzPNPiceL8HvUVsOByg6DcXHnE8yhsV+fgvEBKZx5aOw6r2AQBd4PaDuE6h9c
 Vdk34HCFiq2e1LvxAoSrZJW301sdAuOh7zrofwnPkGZaCELuTav0YRv3VGnrjlugOvpo
 KWMVtiOSl9X5aZrisVs7I+EzAR6cZ6/IQAelRMi927jzpmSacHbVe6YBkG5FVaQnt2Da
 hvtA==
X-Gm-Message-State: AFq9FYJ+4phPlN9o7qt9swTjrzfn2BkXLMb9mROZ1VCBTrpMiTmcCqKZ
 l/bt9zmUFi1QE245jFJqjsgTOWdvyijTLqw78nDhaVQO3vQ8QFYyCLccMnOjf8aDyabiPdnJDHL
 MwV2TPSQ=
X-Gm-Gg: AYBFou3FckHwsv6th+svz9kbnTyjjUv22OEgNUKd+3QnQgenmYgpESm8z7G55DJFSda
 VFPs+sG6e2mf43nhAANT0eF9iN617CxWlLoNNp7QoDpx9XkGhVcEMc28ZFRzQT3XXvfs/iSCUqL
 DOeVv1rvtpMIqoJWtPA8WqV7lbD0S9+FXx4BrxcK3wYXOZxjOMAuI92tbp7bfIdU93sV71siFZw
 fJ09AjwtnJwH0scsbgVvCxbBPW/c0FtLm7BPkcetN0hzjqwHL7YoAZtFcN42W40eBCBd4zTjz7J
 +WSOJ3cndeqLjpPhMrz42zvlP6lLMj0X1dpwkJz4KCBIo4pxJ5MerSpjXFHkvp09GayCWWjpXqi
 /AsMtua6fAkFZ+JPQs7+VXD/D+Kk+nsZxl/w+nkVqI/Ik1MWhlEk2Br4z0WhbkmpfbP/aHnvvmB
 5XXTgP2oSuYX++qJEtU/Uik0oB8+Ure64N8g1xN8BRVKUQ8v0wLDs8i21hLQ/jhzMehbyyJrHso
 0sZQ/bbKrfA0ZQMjxGDI0TjigM+/72jpN4VHHOa7MDpcE4AOg77cPL0ZSj+1NzSqE+rU4BcrtDP
 frCVmAjNXBAcIbTHmot4B0CPyDU=
X-Received: by 2002:a05:6000:61e:b0:488:83f7:6352 with SMTP id
 ffacd0b85a97d-48e26423b70mr5170942f8f.4.1792592772111; 
 Wed, 21 Oct 2026 07:26:12 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 091/100] tcg: Generic expansion of tcg_gen_ld16u_*
Date: Wed, 21 Oct 2026 16:16:43 +0200
Message-ID: <20261021141652.363109-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c12217f68e..d0d508ced6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -166,7 +164,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 785c417a74..98a07a70f0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 73dba6a15d..f1c33afc02 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -792,6 +792,12 @@ void tcg_gen_ld16s(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
 }
 
+void tcg_gen_ld16u(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1396,11 +1402,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1419,11 +1420,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0



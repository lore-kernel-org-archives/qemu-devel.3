Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA904606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xRakQqG6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFb-00040V-5q; Wed, 21 Oct 2026 10:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDZ-0001p7-Bo
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:23:01 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDX-0002EV-7F
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:23:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e04773687so295884f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592577; x=1793197377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWWaq0Cq0AIE8tV8J4ZTwObJwnA971Q01BWEJa/S5GM=;
 b=xRakQqG6U7dQm3u3OAGMcipdUHrhLNAZl0HAKy2DHTcKHe9A1ZYORhYsWV/yvJjPRN
 ycvkte5IOrUhRk83M3ngxe/unZwJQezIMRY48ytWlBMc/aW00y8HCBmr2p1A2dEjHBzO
 X8BZgBHWyt2qV5ggWu8xg5XTHVKug/bgRpeffRgwvcZd3sdHLDdvYnx7e/Oru1DHs/ni
 WlJSfTOKmbWOfg2nAn4VZ8EI4JJysCK3GoB5tma78m49E8qjOn3LwtCOnMTtpGhPTzea
 UDe7ECNRUSkoCPnSeunZBhGjxe9/CVLVl7DE4oZmD0nuhYgLs6HfJ/BnDFDA0CNGi2y0
 4pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592577; x=1793197377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AWWaq0Cq0AIE8tV8J4ZTwObJwnA971Q01BWEJa/S5GM=;
 b=btgkbuCTM7fK6r27P9bCP2S32pBzE3nAMVUbdgFzT9t9Bxe/WBKf17kjp/RdIe9kNL
 V8N+dHIwZ7ZZzif+rjRulDfrrvNJcJmKqnT6TSgMsGqtuoVyt8bQQX/VkTpZrYP83TsF
 dNWKXP3hrkRQZL4zdoC5CQw2d+BLnkST6QoYG9jJXiVAH913JbrF7Gy/qLiK551z6iL4
 Fy0Pt8c391mw8P1CTSpLkJJNYdCgRp8v7nhDdJNWntjUYIy9exou9kZi1d6Mj2B1hWrY
 n9TMiKoKyifNAdGmBmOQvxmkBhC9cEqwNZ6XynJu5ZJ1ENKSA21Ejm37ZepL4rvT8fIE
 7TXQ==
X-Gm-Message-State: AFq9FYIHgniV22igxaxE4S3+gVv47S1p5gfeE3VF52t+9Od7HQmFaHa9
 3LfvvlYGo5L3lQCwGFL0q4NHH/H7/ElbRP8fH71cBQVH9utKjLdd324YbIpvheIAJoiPI3Q2SHo
 Gwv7uilQ=
X-Gm-Gg: AYBFou1V/PldJNE2/SuLMeOayrOuDnEw49nSgcv/Jheu/f3KJH01fydZG0XopVEgWpg
 /+APsOiQMkskqwIzYLhD6YCl2qI2hLiDLxIo6VFgAs9TMuhuc3LDTSkEXDB8OhSWpgXx1mXg48X
 fk9b94Lr0LNcaWBRKRMnAaGm+1nipFyHtsxcJI2hL9TnkyYuTAsUY1WYVKuCkY9m7buEd2/yqLc
 Q4ZhEqfYocultPZQjQ2CRYb/qtmXG+gxg3S6cdqWqDtJQ8IRkgODz7kstxA9RmZLUbCF3futGJO
 Suh5FVCs0IlzMmMKoqMFDwQnaMGCpxj8SMvGoq/25NO82GoIt3H4HyYywZ/sK6ulC1zDnjHYAZJ
 6ZRiuO1ahD5otKqHTiMf2scYtEYnhIqgg6nrUBFx1QTYDNotsOtuIxrz4Co+JnLr4ZOmQBaxr7J
 ZPXLuQwCpujPXA8lY8ehYc5CITGy2JzfafhjrqOeAlD5R2T//IV+cZqoDnhiaoerDfvSWPJ6uZj
 /6dfFzPDzQkl3kTvp5bLOsWe7LzfgYkrZty5UQtNUJOZyQ2XUsizENoNucHyGm7DjdKG2lVlm9R
 QNuCJign/Mk53ixUdnO65AJRpovI
X-Received: by 2002:a05:6000:2504:b0:489:bc38:9438 with SMTP id
 ffacd0b85a97d-48e26494161mr4776957f8f.29.1792592577017; 
 Wed, 21 Oct 2026 07:22:57 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 078/100] tcg: Generic expansion of tcg_gen_addcio_*
Date: Wed, 21 Oct 2026 16:16:30 +0200
Message-ID: <20261021141652.363109-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
 include/tcg/tcg-op-common.h  |  4 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 77 +++++++++++-------------------------
 3 files changed, 24 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c1c41a03f3..84fdadc63b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -136,8 +136,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -166,8 +164,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a237ccd0c5..003384b65d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 712536cfc2..51d5f70ebb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -345,6 +345,29 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
+                    TCGTemp *a, TCGTemp *b, TCGTemp *ci)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        TCGTemp *mone = tcg_constant_internal(type, -1);
+
+        tcg_gen_op_ttt(INDEX_op_addco, type, t0, ci, mone);
+        tcg_gen_op_ttt(INDEX_op_addcio, type, r, a, b);
+        tcg_gen_op_ttt(INDEX_op_addci, type, co, zero, zero);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_add(type, t0, a, b);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, t0, a);
+        tcg_gen_add(type, r, t0, ci);
+        tcg_gen_setcond(type, TCG_COND_LTU, t0, r, t0);
+        tcg_gen_or(type, co, t0, t1);
+    }
+}
+
 void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
@@ -1144,33 +1167,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        TCGv_i32 mone = tcg_constant_i32(-1);
-
-        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
-        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-        tcg_gen_add_i32(t0, a, b);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i32(r, t0, ci);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i32(co, t0, t1);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1681,33 +1677,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
-        TCGv_i64 discard = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        TCGv_i64 mone = tcg_constant_i64(-1);
-
-        tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
-        tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i64(discard);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_add_i64(t0, a, b);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i64(r, t0, ci);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i64(co, t0, t1);
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0



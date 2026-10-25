Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB93606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UIpOy2XK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsdg-0000ds-Co; Sun, 25 Oct 2026 03:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd2-0008ST-2Z
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscz-0004bF-HV
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so2134385e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913208; x=1793518008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dij8wAHYojpToNGfc0WzJj5V4KEAvnWYrtwOAPm25Wk=;
 b=UIpOy2XKvom+N/LQiTsIIJczu6ddY9Hd86hn+r2c8/LHoGMKAH1Sa5ezm4VRF37Tg0
 wu24wfd/HrJ14KZo2ok58D9OgNUEod45jRVfoY7LFEKtEkqk/mzAqEqq3DyqxM7CkhZj
 P7kefM4DsJzjQaGk48hk3I/5Wu0MPMjHMKP0qP/S2AeNDsw8aNMhya6xQg8OHm1qKD0b
 qQkJar2bUYXSlOz53GVDg2Akkr6Webyof4RRxf9LifrNmQDkkuWuDUL73EyNeB63KpEi
 ec7wkC0zsgTHzL6YTpyer+Y9du+7OUtUlQCj2oxXfu9MvcL0PoBsK+IIEGcsmceVymI+
 nP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913208; x=1793518008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dij8wAHYojpToNGfc0WzJj5V4KEAvnWYrtwOAPm25Wk=;
 b=1/NHpaW0wCKKRiiOrT2a+hr0Bd4O4e7vTvEfnJVnnmuJXhozIe5DtNPQky7FEKqvMr
 /KGjfLVO2YLSYBYjmUTEFriMRDNvbie90vzgvQ8uynfelMnsviJr5wGPqTaVMUvinBKo
 kMPGrIHLEWRZcL3RXym72tkJ3O5kivLxP5xWDYXS1f6DZfOw3nxE6fWzYtuQenbVdB1R
 39C9yA9XP9Oxz1tsKltX/b5NvlBxt+fY6t3aSkRC/oxvXR4C1aKnyqnHMy4qIvdqp3Q5
 ANps9477hBXahzWE97gdgXJd6EXrqWzmfLzI15AyXYHMkqHo/PqzTA40wS93qmw5OYF4
 /xuw==
X-Gm-Message-State: AFq9FYKf721ZwJk+FIDsZRjKmBnKjEq+SS2hNs/xOblAv1z5OcXJswvk
 KPO4YK0TWKkLIGLU9dH/tSTwxrv6iLrw28MMm9VepCYeQ1yPgEgogVY92FpoTwXkJXqNvIln27W
 a1i+liS4=
X-Gm-Gg: AYBFou1xio4hofiYEStYdx1wL6XewlReSValYC7gYFgReba6+Ymm1bIpVipUp3Y6LFS
 42qowy5yHscN1sawQMBmccS9ub1e4o1X4bIEnBwqD9lBgfC0DqqpL/Clh7nbn1BxCmm6MOrteya
 rVrjEkgJMHY8FS+ksIkQSipKsob7jpoUuBneKT4YvT8YAVQfOUYew+ry8oHaTrp9r4hKcCO1rOe
 Xw3jVKxL/2HJzn1XwWNVdSoKitCyzIg8g4wNnCJGw0WPwmTXpiJwIx+TJ9/RihBLdl7GDLY55Zt
 X7YBBnWOuhNoy/b5Hs1BSXpc7H5m/Yc+XSxvG8bbgVLNlxN+MxowI5Qc6d6RrVKqcD967oXBJal
 OqXAp2LU+nK2MeYxG044MmodEJkuTfmPau7zXFVgYXkjx+5M5ssPBDLuJbDQzz8lpyeeQn2b1f/
 lzA2CbBEIMr9Q6lWR1WJfMh81ufPuleKQKeTKHH/7hozpxaDfUsupIGsUTJYUHQlWLAhkZkyabg
 QvrhhzGRsDKfCofqH/kdhJSILsGuCx3JseIIcGsABq5pFJU6F8Wkcrp8k7mb6ZMeIxXGyAK3HSW
 8s8z
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a35ac7f0d2mr51123175e9.9.1792913208206; 
 Sun, 25 Oct 2026 00:26:48 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 088/100] tcg: Generic expansion of tcg_gen_ld8s_*
Date: Sun, 25 Oct 2026 08:19:03 +0100
Message-ID: <20261025071915.1123867-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 697de0e1f0..32128ad997 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -170,7 +169,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6284358a13..a110e64510 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -32,6 +32,7 @@ DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4f33caa735..9ace671729 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -775,6 +775,12 @@ void tcg_gen_ld(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
 }
 
+void tcg_gen_ld8s(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1384,11 +1390,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1422,11 +1423,6 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D12606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c7E1raVx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsew-0003g6-Di; Sun, 25 Oct 2026 03:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd2-0008SS-2e
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd0-0004bK-BZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so14075425e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913209; x=1793518009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0KO7MrK9mp2eIxSzGlkFlXjS1ZxVNCXw8Y1gn6lL7Y=;
 b=c7E1raVx1P8A7Rq8XNqass4eaXeL/KH2KMlLhrbIH0bmt8oMO258L3A9uBg9C1WdY2
 lq+ESEArX2JtrgIMWGUo6IRhwFnUrlQbpv43AivySIgK+XvtVb1fJKf1DZR+nlaL1dSX
 8UdCLHYVqPxTbQr5+EUbzjGTa+X0xLrKeRz86WUlr/9+ymBRfjN8qwB5AvRQWp55uFKQ
 0r+jxGFLE+EmrNzmLYmS6BIzWePulqUdgAQaEygAdz3fFO4+BbyUolw9vnD159hGJJIM
 HMub0ga9NjgdkZyu3EDDMvLEsJRXUJlJsNpUibDBFzhX2eIvbNcxvtcGuYFVxKktRj+E
 nzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913209; x=1793518009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b0KO7MrK9mp2eIxSzGlkFlXjS1ZxVNCXw8Y1gn6lL7Y=;
 b=yhxorbcUT2/7js/nru6eAxacExI9rsjNFBtQ3OVHSS6saCyu688GtyHCmTvmElDcsQ
 yEBdJZfWJTbr8tf/52yNL1dfNgN9kbEJm1p4yNFaOG9yNufrPJnXa5EEMeFCAXQ9J1ag
 92rnpUiJd9Npp751UM0abvvKC5KAO7hIq7kNHXEfGXfwj5xGAiamY1lxRfyPGtdeNKlC
 xezVqHrFQGLQffQndz4obZXFa08q5LyeGFgKcQU/G0VE54l3N0waDKAv+1lxingHmj/6
 3ZNcOa1RG70YWxS8XvOw0BlCtIoFUrev5ayoLUSXhb9jKc02pqARJE3LguppRxfbawot
 kW3Q==
X-Gm-Message-State: AFq9FYJXU1ex2zy5bS/rfwWlXvWfsEp0oz15YDDSCK+7w9jCGFt6oXW2
 4H4D8LcHZ1QcQkqJG/XLEO9vRY8Yo3p4o4CNKmw5iwqea+sy1c94CUh5IotGt29l49VJbZ6Boe0
 Sg1BiLCI=
X-Gm-Gg: AYBFou1ogl59OgjywwSJkXgG71cYpoT2qK+kUIOZFp2beUzmjxmHYCtqQAF0hRvLfG/
 +DM1wj0a6asNs1AOfgEPwwhuYnij8tM47iQ3V3w/PJvOS7iTFx69eqyHQ3E2pjMP3sl5aac0Hn5
 L99cHDJMtaR7ygcwuMb20rgbKtuPMLkgR2eO2iEVprDZj/dbCTKnTXi48Icwd908hF5kK2gfxPp
 gHGiGeyjfRI+DtL3ZsNDe+ZbPHdtyoNFpYIjOdZ4xmSntBFYYMAziUEQ11/TbgL9E5+zR625Vpb
 /TsHKk/fZp5xJVf/Ub+SI4RyKKAUSZqLgfazrScbXyBYc+5SufDjY1FkWZdy1pkaJTD9hC6M7jL
 OCpBvXNtsPhJcrSIHJ9U/w/Dl1ljgYCYGe337cjxK2R+ptx9ytFubmgDdFrMNUfQMUjNY0PPwH5
 futoKI8TMCinolB28ig2AopMueJNc7KBY8nheTZAKp/lAzeppt/h9PxZ+6x62gW+Az7LwCrN/h9
 PBBvfN4FGPryPLYVY8dGahQYKPE5wwYxfkbv4bUHB2gNRxym5q0bX/oUro=
X-Received: by 2002:a05:600c:a306:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4a4fc8cd1edmr19805315e9.25.1792913209012; 
 Sun, 25 Oct 2026 00:26:49 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 089/100] tcg: Generic expansion of tcg_gen_ld8u_*
Date: Sun, 25 Oct 2026 08:19:04 +0100
Message-ID: <20261025071915.1123867-90-richard.henderson@linaro.org>
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
index 32128ad997..744211c4c6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -168,7 +167,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a110e64510..75bb38a07e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -33,6 +33,7 @@ DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9ace671729..06d0aa3fff 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -781,6 +781,12 @@ void tcg_gen_ld8s(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
 }
 
+void tcg_gen_ld8u(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1385,11 +1391,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1418,11 +1419,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB3606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R2nTkMjp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsen-0003Ut-1p; Sun, 25 Oct 2026 03:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd3-0008U8-OD
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd2-0004bd-5A
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so22925795e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913211; x=1793518011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T3u5iUDcP0oAdeSFuJwX9Yg0TqbECTxbbV9jBC1izQ0=;
 b=R2nTkMjppV17H8p3NtQnYCliWDzSNSnQPNClDTzSmg0/yPr9DXF0iUeU8kUAyIqjyr
 75xqeNZHWVpGg99yC4+M47TjQq3fidMCj/sAs8IVDhW18+R03KFbAgNfUccENXRAGVIU
 YFL2AH6fmnEgyXU39slvdVszmpSzCwca1d7yuwVMsLjxTHq7Su4Kn7x+bNxA9Nlvl4PD
 cPiQfUP7O7ldvxCKJxdap3/uh6/gRl/MrzEZBQCavZJy6ura8aOVMngfHnVBZN4mr/gb
 hx2sje/dsn1XYjOqetvwDYMl1k+Uzbn3KX8h0OpaUs+6BsgpYdlNfKoLR0KAfR9wNSDd
 qsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913211; x=1793518011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T3u5iUDcP0oAdeSFuJwX9Yg0TqbECTxbbV9jBC1izQ0=;
 b=QiSLKhHyVFyX7QdYArl948+5iaaAW47RPuXX12K4SHNfUPSEVd/G9ibazMzMHWgMW0
 /438A11DioMAy0PkgByYD6n0B5MZ4pqvjAoscyhJW3NjCQ3+Yb10M8ATfGTWji+qAuZN
 eOIps8zYUvOuGOG5YCQPOdDI4ZEQLlVLuXBug5Yhrn7ADYcLXforR+7N+P8StiNW/LLU
 lY3HfFuq+jktzhtGnEQ2XFs1dAZNOz1KTuCzX7ukNKk6Pd3eeDiHh70uKo8GEOmasaLW
 wF1IIHpq9rMwtwNmf/uwiYZpksG5SrIhDW5O4EpJSH/AVLv2Rq1eMsXSB0MIPY5Ecbgv
 XA2Q==
X-Gm-Message-State: AFq9FYJTOwicDTYqSioyi1GblptRAq41DZ5oZjoqdg46CGaPTGAIvsy5
 Ih4GjMzs12HpZfCzxhjJq3Rebz+upnQ7Y6y6ih/QN+t9n1bXE83jxg1ttY6z4EXvGGFnxxKoWkU
 SaEHf91I=
X-Gm-Gg: AYBFou36faxHftmLyTCX6Unj9dewjDWeLjRsjI+Puo63ywqv/a8JPvwXzA3X3gjBaEX
 QnP2CEwKAX22x2lSSq96xZnenkagoGww/xpsagaSFxnK4AD3mIzk7S5kX6Xg/mWYx2TyiFFBqPv
 dAjVCph3puuQQyywMGYX1rE1S7qpG9YfVzJYQ4RskJaqIxTeNSyMnBnKv1bKhcTgmdFwOs8BAML
 Bhdsq3uymG6fl038+ucDaDPes87PvfsekNgXfhmpoKaczLoMN1YIzlgg9rdimXTYOnvZky4ILoT
 xmjUAUgMQowfr7JlQ7VXsmaFtPvL8ekK3XyaAvg17jiKfZg//nuqQMrpPRAWBHfbwW9KLrGxC3p
 sFbq1WpiSyw/Pf/8p3bfoVFd3kE5cELO9MTNbRIPOr1kmLUVrqOo5F7LfQPsjbTy3mP65s8BveT
 4lmo1GI5QzoVSg1use+UjLY6qGiULBh3hNhVJL/8wO8N8EwyIRD+/6Xld6LPoXeGi2I096TtLzB
 52Be0wif3IU5jtPXkSgo8dxbHc8DbJz/xQm1rEn4Izn7wd6qaen37X07xM=
X-Received: by 2002:a05:600c:5307:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4a35acc41a6mr52661355e9.35.1792913210680; 
 Sun, 25 Oct 2026 00:26:50 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 091/100] tcg: Generic expansion of tcg_gen_ld16u_*
Date: Sun, 25 Oct 2026 08:19:06 +0100
Message-ID: <20261025071915.1123867-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
index 1bcf119ca6..c8b42cc74c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -793,6 +793,12 @@ void tcg_gen_ld16s(TCGType type, TCGTemp *dst,
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
@@ -1397,11 +1403,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1420,11 +1421,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
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



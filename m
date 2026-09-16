Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607D3C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNb-0007AI-Kq; Wed, 16 Sep 2026 09:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN9-0006ju-U7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:30 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN7-0001Ow-Bs
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:23 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so703381a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564099; x=1790168899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nzAneHqRTA+05iXMXqGEs1fC0iACCWL3/z45R0WCK3w=;
 b=HVb6w9xIM9eFxOMceAcczoHfgRRulTgC0+LhGnLUFtxNrHQnnmgEiWzCTW/NJ4pp4Y
 SSeLZx0Zxnd2uMiu672zFeGgT325mItFTdUzRb19BTnOX47e1WXlCI8honIwKdQLSSRv
 1E2F0VOrwOOXYe5GInunLHZMsS7e8n1gCCutrZxjICY9CEXp3mUnGyftjzv08cTqLlOQ
 Vd+tZLUS+s+yGfrBtfPBsIswZYCdg+6v2b7qcaqwOUU7WOsFSw5S466Yud91UtQW/9sD
 lYszidb4MmUPK/fjQiVXGhjWaLydTX87eByJI8uDkqG3x7ZEw19BTWRV5TAkUk8VRLra
 YdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564099; x=1790168899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nzAneHqRTA+05iXMXqGEs1fC0iACCWL3/z45R0WCK3w=;
 b=TLAhKxR4TVY3G1pqP7KA+ewmO8++mFZY1haX7wTUoLN76OJyMOg0Pkv8EADBWd+jaa
 /wkK2BmUr99ETDyWpKYYmH5Rd/7j+sgu31i8jazznwg9YM98GKfqYF6AjK5IH7b5YGcl
 n2UdVBQ6yMKCOXmsd9DqUDSanNg5rQfhIlg1W2JdnRtkpiJvC+ZoAjj5boA848Caeicq
 xRxe17flfnUWLU/hdQZDvolekQTKy2SXe/ksS5qu/fZDSfRRZs3V6XbQbcL0zF87bSSP
 2GsvZF1odOonEKINE3goD3caqD0GLOD8oBs6wg9Mnl9k9PAkKZ8yeHTjGmGgbsIu0ccr
 ytOQ==
X-Gm-Message-State: AFuF++kRtINRe/zUhc92INl4IkHT3CsW6pSHahMwgX9RqEmEp51WNem9
 UOta1w7DqurzaPDjnuRLICg1p6pK+TkI1qOEyjQxRV02FVgCpH9XcCeGI8FIqoqcOjcrlsKe60u
 j9nSnngc=
X-Gm-Gg: AYBFou3X1KpH8y8PYDVfECJKoqoAbtvDZ9I+rPpxkGNghCxKlFltEvfxnaRa6YMUUND
 Ne3C6CQilsk9kK5o8daRrjUl5cBArI61ib8+oC196gsAP1fUdvE5l21ea+JdYbqcF1B41NpClH8
 I1jqRsV9aEzP1E27kz/wXoqfSe2ykgyYdgkZVehvEQ/07DTewWRCt3HGk0uNfTmawoWl8M455U4
 tujRXOQgijhXsUJ3/2o1FSBpp+iuNP3H7gNQ8wle7qJm1PYeHX/5rDQBaX9PGQZ+fqXCi7LNwU4
 54KZrsuDwlKyAI8BzRNFXAqSMJsm+ZF4Di1HDWYUbBMj1XaIJAxyljr1GGKe12vSLB08cSbqGra
 4W+6kv+ALV9YdTUzOdl3YnFQleQnSNmEoDekfn5y4No40yguxrKRs+As6ZOjenwaWH8bJ5LdV5R
 /gdB3AulMSy/2Qg/NBe+od/SpxZwAyK3iNgtaB/eo4MFK9ZwNk2fM5romTJSgPG2kidti0pkccc
 ssqvfI=
X-Received: by 2002:a17:90b:5281:b0:39d:f050:a010 with SMTP id
 98e67ed59e1d1-39e1e263d08mr7547606a91.1.1789564098862; 
 Wed, 16 Sep 2026 06:08:18 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 45/92] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Wed, 16 Sep 2026 03:03:20 -1000
Message-ID: <20260916130409.3382710-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6ec53bd7a15..9834a70cac9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -211,8 +209,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8bbbf39f13a..a620c8ad69a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(negsetcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2799d4abce9..ed746fe13b8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -590,6 +590,12 @@ static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_negsetcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                            TCGTemp *src1, int64_t src2)
+{
+    gen_negsetcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -783,12 +789,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1543,12 +1543,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0



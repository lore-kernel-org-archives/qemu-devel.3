Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E5BC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TiG-0001Ur-Jr; Wed, 23 Sep 2026 16:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgA-0008B1-PK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:35:00 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg9-00051D-03
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:58 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso811609b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195695; x=1790800495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iw6NmWPUmuvdUzCnsYRZeVRMe166tP0/X361NQb/yjU=;
 b=Ox/F2EukL3d9G+izHyLPT6SwweElwAPL0bDcqMSyCYOQtVOJfJ2dqjC9n2W44Ypa4Z
 eTBJHqQ+C4OlCm1xsUxUZtDNDTvvQglqD1xO05qgaXVtkaU6yFcfdnamU/rlweDk/Lp/
 QxO6voQ5FRE/YlCjD51aMyOEkNoRCXGem0mWnZCeyKsV50D7RsDXgL4GkFqFgHFNx35m
 n/ObJp/KHD4YWZIb6S2guAnKfqX5fSIWAlvgWK46LTRy6GAb5/6H4gEZkW9bjaa8Gf8U
 vwCX0I+S5e19UVAziD+4W09h60DLZWbn/zXf998YGN4WG+BbOn1AsEM5E2hClLmmnDcs
 +5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195695; x=1790800495;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iw6NmWPUmuvdUzCnsYRZeVRMe166tP0/X361NQb/yjU=;
 b=UAK1RZ2uh29sm6jysK7x0990a/8tVhqa+pcVIZnIuYHjA8glfnga/hB71t5zZQ03Xn
 YR7NLxaOfe750z2ULtzYp2fmLI1DW3CMlreQ6RB1u30ysIJW5xu5nP6eUeekpPP9zCau
 ylrfLtrSqpdz1rlCV7LheFuKYMj2CHC11IrCZscE+d5Wir4LkPe5RYDTvS7Shbk3Gjlv
 lepjX637KUkATaJmoe1STZT0LZ/X0WjOLRE5k7YU2cLAtV2KuXyRNKVOo8s8rEEgNRwb
 RRaMDX/ussH7w47vK46sr3/QURVQ5zo2hBiimm/5Eq9CU9T14WDRBK6rzQI8jDCHz817
 0MPA==
X-Gm-Message-State: AFuF++nTIRNnQKweisqUNpS2FiE04+iMJ9e2bjc15yp1C1MWmJjEtB5F
 P4MoRRD8oRbGR6s9iYfGgFNA+dW4hokAqnORQrxEHSkYnvJI7y+7R3B6TkkBBO5a5NWdIn0zvfO
 v+7zC
X-Gm-Gg: AYBFou01c9ALYzuRPvyrYHBea1fB5BnDXMiI1NYdhchvesJjjya6xB5Z5pliifhpFed
 +zrnlJTduZd1QJrcXwKTLjwiWY98bCKEeTPkxS2fg/6dcSmpAPdXexTiyLZMFv0efHjSYgrauHA
 g8/aScMZHf6WbwQXYNXStQXAy9ZcuX6XzZvEhF97a5abnJ4FBvzntizRnNlsPRajHC+AresoNXl
 0QRjjfLyWXiM6unYIE9+NjDSCtDwCGReCpshYu5TqMPQgPFvYBFKGH68dXibZjPKwPOOaarnqXy
 gUP8Nx+x+nMx0is8J4lFzzabHkmHeu+qDE50LgYWNPv3HQMBi74t0/EX1absgKKUDFAzdhuiFyn
 /cU7+7GpWeMjR5NslgUYMHIQ1sqYTH+x5kYcF2X8PbEeU5KcFAmJz8Ol50Fl7WuPJQwQxME97Pt
 de5Cr3a2TbXfo8JjizGg25Yvsx4t+p1y7caZi3eYNnsj79HM4Cu+AvL1duxBWni8/m53EEZ70YD
 +rtdgDVOuWy3sQgZlCKbkmr2/EC5Q==
X-Received: by 2002:a05:6a00:4fd5:b0:87c:9094:b72d with SMTP id
 d2e1a72fcca58-87e98994aa5mr236145b3a.6.1790195694536; 
 Wed, 23 Sep 2026 13:34:54 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 12/16] tcg: Sort all_outop[] by INDEX name
Date: Wed, 23 Sep 2026 13:34:37 -0700
Message-ID: <20260923203441.31276-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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

Most of the opcodes were already sorted, but then there were
a set at the bottom that were left over from the split
between 32 and 64-bit hosts.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 489df0e7386..ecc1f54c1bf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1158,32 +1158,39 @@ static const TCGOutOpLoad outop_ld = {
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
+    /* addc1o is implemented with set_carry + addcio */
+    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_addci, TCGOutOpAddSubCarry, outop_addci),
     OUTOP(INDEX_op_addcio, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_addco, TCGOutOpBinary, outop_addco),
-    /* addc1o is implemented with set_carry + addcio */
-    OUTOP(INDEX_op_addc1o, TCGOutOpBinary, outop_addcio),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
     OUTOP(INDEX_op_bswap16, TCGOutOpBswap, outop_bswap16),
     OUTOP(INDEX_op_bswap32, TCGOutOpBswap, outop_bswap32),
+    OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_deposit, TCGOutOpDeposit, outop_deposit),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
     OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
-    OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
-    OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
-    OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
-    OUTOP(INDEX_op_ld16s, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
+    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
+    OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
+    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
     OUTOP(INDEX_op_ld, TCGOutOpLoad, outop_ld),
+    OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
+    OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
+    OUTOP(INDEX_op_ld16s, TCGOutOpLoad, outop_ld16s),
+    OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
+    OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
+    OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -1203,7 +1210,9 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_qemu_st2, TCGOutOpQemuLdSt2, outop_qemu_st2),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_revbit8, TCGOutOpUnary, outop_revbit8),
     OUTOP(INDEX_op_revbit32, TCGOutOpBswap, outop_revbit32),
+    OUTOP(INDEX_op_revbit64, TCGOutOpUnary, outop_revbit64),
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
@@ -1216,28 +1225,18 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_st, TCGOutOpStore, outop_st),
     OUTOP(INDEX_op_st8, TCGOutOpStore, outop_st8),
     OUTOP(INDEX_op_st16, TCGOutOpStore, outop_st16),
+    OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
+    /* subb1o is implemented with set_borrow + subbio */
+    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
     OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_subbo, TCGOutOpAddSubCarry, outop_subbo),
-    /* subb1o is implemented with set_borrow + subbio */
-    OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_umax, TCGOutOpBinary, outop_umax),
     OUTOP(INDEX_op_umin, TCGOutOpBinary, outop_umin),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 
     [INDEX_op_goto_ptr] = &outop_goto_ptr,
-
-    OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
-    OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
-    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
-    OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
-    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
-    OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
-    OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
-    OUTOP(INDEX_op_revbit8, TCGOutOpUnary, outop_revbit8),
-    OUTOP(INDEX_op_revbit64, TCGOutOpUnary, outop_revbit64),
-    OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
 };
 
 #undef OUTOP
-- 
2.53.0



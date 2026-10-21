Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A46606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T+Qriy05
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXE0-0002a8-RC; Wed, 21 Oct 2026 10:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0001eH-I5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002Ax-Ir
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so645981f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592565; x=1793197365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yEVjY/yN41n71T4rTuCw2clvDk0oXze4X41F9Id5JZA=;
 b=T+Qriy05mIeMmwlBbgdZsOqU3HiWrBQL1O2Z3TCLuB0X9ljg3Lw9dXVbkmavuK9UJm
 +1yPutXHwpOg06+m7PNFciA64hWscsvrPaq2M90XVDIF9RxzStd9b99UtrWz9T69EX6g
 dhal1o0h2f+2+dhMBUzpn3bPhOr6/9/4aZhWIMfpSYx8YYGoz/JOGwNS7GW+u+a18pLx
 afhu1M89JzGrMzigAFtGb3VSuq0x93t7R4+gT5hOefQNdTfqrc4hyWMw4/ZwNzPQBtz0
 pMUfPcNEUwUg9H5y5QpeY3ji469XBa/K8HnyyBhqrxuw2eX6oc8x6w+oK+pFfqQHkaeA
 jM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592565; x=1793197365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yEVjY/yN41n71T4rTuCw2clvDk0oXze4X41F9Id5JZA=;
 b=Cxq5lExotBauyGLsVhOWB1lEQ9tFGHqe2rHun8Q+T0yQ2848sFkmD36UKjfGku9ksP
 sSUw7X2BbGYsStellml/MtzQHsVkzB4rf00XsD5yS1Mm22l7RBp0Zq0O9OHV5uU4cScd
 BrWC5hc34c5J7+CTyIkRB53iGWl7DX7jDt8gp2oSacH9Dv4FtaVs7SXfCx/CzmX+rvqD
 Htnxdj4R1uAqbpl6xkV9HXqmufY2K/Tkfxb/HSdCxA7t8PTdu+OxIcgzYLjQH/TLenwu
 moL2hP9XV0sXHiSeOoHTs7eG64laqVi8nA7bLVxEGiS8QqLDi3FMu4qS56VqUsWMsVrj
 1B/Q==
X-Gm-Message-State: AFq9FYJxCaL7sGVlB2gL01xousYVu7MofmQ3COlkl4FA4FYxbHdqExnp
 oevm0GzOsw4xzZ80H3iAsP43E8V4+0AEw0dbK9eHWuHxZjVRFCPtNiGB8W7hsIJiLAlT/2ZWezr
 o7hgOFs0=
X-Gm-Gg: AYBFou2wu4HLvFpsp2Q2XAh0GWSwX/gzruoClMA6bvzi/tSU4kJ1znzUmbrHZPmEvwe
 U3tFufmo9ApzgNKlrgR3+o82BA93Bvat8au1dBWwbgYcCzMRDzBmWxYFq33iZwF4YjC3ND20SJN
 QwgbB9n4UtptQLSfFwl6crue97zU4ej+8lJ9XwQUZ4aL5wQD7Bv5epGgmVuDgE7c5CSQm/DZt9z
 f65hM+wrMg/TVt0SiBSwrs3tEce7d9YRICEOfXEEGtzYkjbQSQ9clnyqcDkV5xwve5pIrT7vGlN
 JegST56HdsgHz9q+va411h1bACuyQS7O+VesBr4DOLvkbQAawVQK03+/noznPPbTilhzXOL0tcK
 9IzxQ56/Ef2qwatdRofS9jWisxiPnG0byNNroPWX2EXuXckzK5a+7hOr/YWxTCAjqOasf0XEeFt
 1KgUj9TT3ZaT7xgnajZ7PgiuQJ+ZApRH6IistHQiWwNyb2iiy+59DAmNRr7SWbLdV4gcPjAxvnD
 is8Di39lD+wVAkZpHSLOWQwA3Z2gs1AtzBxbm1Y1Wj/K2pRHXs5SqCeKPRzI4cxMIKXtZ3plexY
 CsIXo5T9KMMdh+waiNgKY9U/34I=
X-Received: by 2002:a05:6000:25c6:b0:48d:f1b3:7e67 with SMTP id
 ffacd0b85a97d-48e1e7cc1ffmr13222356f8f.18.1792592563517; 
 Wed, 21 Oct 2026 07:22:43 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 064/100] tcg: Generic expansion of tcg_gen_deposit_z_*
Date: Wed, 21 Oct 2026 16:16:16 +0200
Message-ID: <20261021141652.363109-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 70 +++++++++++-------------------------
 3 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 34a79c5818..85af0d4b6c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -177,8 +175,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 338ecce6fc..88e87ebc2f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
 DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
+DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f2928ae8e7..1d154fc12d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -197,20 +197,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGv_i32 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4, a5);
-}
-
-static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                  TCGv_i64 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4, a5);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -550,6 +536,26 @@ void tcg_gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
     }
 }
 
+void tcg_gen_deposit_z(TCGType type, TCGTemp *dst, TCGTemp *src,
+                       unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_bits(type);
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (ofs + len == width) {
+        tcg_gen_shli(type, dst, src, ofs);
+    } else if (ofs == 0) {
+        tcg_gen_extract(type, dst, src, 0, len);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        tcg_gen_op_tttii(INDEX_op_deposit, type, dst, zero, src, ofs, len);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1012,24 +1018,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (ofs + len == 32) {
-        tcg_gen_shli_i32(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_extract_i32(ret, arg, 0, len);
-    } else {
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1681,24 +1669,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (ofs + len == 64) {
-        tcg_gen_shli_i64(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else {
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0



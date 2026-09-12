Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5BFC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5H-0001nQ-2G; Sat, 12 Sep 2026 06:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L54-0000XJ-3R
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:34 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L50-0008Q1-HM
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:33 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so250389a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209329; x=1789814129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NGow9khTMJdJyNb7w/1VSQnYYbdDLJ0wD4pOXXQLE7Q=;
 b=G2RsCjFTWoHlPv1vZj42wtSWT4gOqCPBTbKVMXh68+955TSBppoNSfImzK6u6kwOV6
 TnRqHoSvITl3yaU5vKTdd0jcHOMDTCf4uLBZTpEA51XQbFgNqaNtzHTRYCpz8nqzmlWt
 ZSR7nm+/WyjHh6Fo/g6EfLw5sVsWXl6zA40fejEBafDiLpPi+xei1sXxDyO4lOGjal3U
 AA3pzqYMWJuZz3sPckuTGycTY3X2O63S1hoqkKAfZ7QLmMTn633h0JTHnCvgl1hlWUHe
 32txMn8gGmU0FUynrX/EiQY12a+G2dF7dEetUIRihSzg3u0ssAqbqMCZ2NJ/vWGVqAQ4
 U0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209329; x=1789814129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NGow9khTMJdJyNb7w/1VSQnYYbdDLJ0wD4pOXXQLE7Q=;
 b=EP41gKPO3jMsFLpmTVvnPUI2gk0+AMWj6H4tZQ8RhJl2jbs0LdRqGYlkh/jawiCYAG
 2WEcgOtwGOJC87/VS3f7a3IRzxGm6Wjrfq76m2MXEUQW5zA79+E8YnUcOASGsEk5NRMc
 ta9YoWTGA3eDWocWjo3YTIzT17ZOXd3aofSCjzdPIGvLazNW25puMjkhqFMZcLauNcmp
 UD0PPRu4StQ0LYcZLoz0+zeTu2+Eibo4MMr8EvCsa0VTqlcJtGzPE+o7UGB4HZOEbOZy
 kFLNSNxMjhYPVptAsEVRYUItBekaXsjo10JNf4txu7FXOjkYu1h2BX4L9hWp5ccHJuTL
 jtIg==
X-Gm-Message-State: AFuF++n7JhyhxsIu5kjV1n2A14asmm6oU02pzj4Pc5LOZelRDZkaHZ0r
 BjzEXK9oC2NeqjME5rdpL91wmofielsJajSHwoDoypzYGfMXgS0Wl+ttAdj1AuPMRhroW+pLcQK
 AxE10neM=
X-Gm-Gg: AYBFou3aCBpI8aOykUIZsqmndIG9otK7Lqf/O9cua9MJD32NA2+xM/dvMGow2t3IYu7
 q8hOtxJ91VVrAXweCCsSdWkMAFOO50ODC+8ao7KL1XNWVG/y6f5/5v2zelzfjE56dQoZkwaYuiA
 +wUDrVWqagLSRUVRCGsGXUlY8xvYnu7mAuWUwL6+xohaHrJSIfZmOqisospeze+4C5cyhcKW/pn
 V4YXPJx/wHj6M3G36v4i+MI7BtLvfV20pXaF1pw6d5LKZaAUSjM/D7Pb17qyPxyCDXuwcZS62GQ
 ChUrVO28PISf2ChOt4kYWTBLlXL8yn8EWT42BMeqYtOh5lietaUy4OIrsjPlwlE+foIKJCkxbYg
 bkx+52zZBV5q4soHRyFuBy1Ik+5P+RRrsCSy0lxvLw9r7yIFTpfoyG6CTuy+KcrrNXBoE5gO01G
 7p9kQk+KlLuI3sOZ/ZRQTW9cVfRDeYhHlGNAhJBzvPaRo7ndtNyQW+g8ejkcKtPKvk+RzuaD/Rb
 8m0qt4=
X-Received: by 2002:a17:90b:52cd:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-39dbc699006mr4356644a91.14.1789209328976; 
 Sat, 12 Sep 2026 03:35:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/82] tcg: Generic expansion of tcg_gen_deposit_z_*
Date: Sat, 12 Sep 2026 00:31:06 -1000
Message-ID: <20260912103126.598030-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  4 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 70 ++++++++++-------------------------
 3 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7c6421f692c..bd98d2bec41 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -151,8 +151,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -196,8 +194,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 5cbdf39b3e6..15d20872088 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -51,5 +51,6 @@ DEF_RRR(shr)
 DEF_RRR(sub)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
+DEF_RRUU(deposit_z)
 DEF_RRUU(extract)
 DEF_RRUU(sextract)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2a31ae17f4d..b19244e6de4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -244,20 +244,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
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
@@ -596,6 +582,26 @@ static void gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
     }
 }
 
+static void gen_deposit_z(TCGType type, TCGTemp *dst, TCGTemp *src,
+                          unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (ofs + len == width) {
+        gen_shli(type, dst, src, ofs);
+    } else if (ofs == 0) {
+        gen_extract(type, dst, src, 0, len);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        gen_op_tttii(INDEX_op_deposit, type, dst, zero, src, ofs, len);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1162,24 +1168,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1831,24 +1819,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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



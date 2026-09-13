Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C579FC88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBD-0003U4-Sg; Sat, 12 Sep 2026 22:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB8-00032I-8B
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:50 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB6-0001wC-0x
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:49 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1638659a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267366; x=1789872166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Oy9bCvHArQs4ugjbs/nGpRpNCb0+Oy2RGuwcgoWjDtA=;
 b=xkaLFzX/LjJB89LrjkqtASqTZ1eTVMFiJ/QnbvhhCDJHtoYNeb9tMBm5/MFqDtnyCe
 5bxVsmTrwmZP4+7dFzKkYvfUhISvdxAhF8iN/vpIkx7WNDI6eXXvSDxoyyjEsIvB9xQM
 Z5nWlmkhFxMHjpFI70O8ik90ad8lf3WdqwmQSHc5PFA822+4go4OWHc1Ty8mdgqFsaEa
 qle/5o03JXepnEjlolzzwiB1VxbxCKN0MO5cmZTeF2AXlsSaOUcg/WtkiI8pKbW8NGzJ
 j67KukC0RS484fedZeRRRJMERfJnIcpWA/tZTIKQOriIo7/2ogUHQ/t9uF9Qs5VJf2TV
 A3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267366; x=1789872166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Oy9bCvHArQs4ugjbs/nGpRpNCb0+Oy2RGuwcgoWjDtA=;
 b=fGmLW1CWSxA9RPGLt0jNs1I6F16uMU/9Bsyhwz3XIJKNJfNO9S1n4+vkicCnBpfXWu
 YYyLYS/ZiezNho1oTlds6RT1dt+RUk+L5ywk5XcZRn5hvnbtMxBij4ZWB0mXdzdxgefl
 JuU7JYvxrH0BWA6RRjDlKpacv6mCT1/4G6JclxZN4VwZIQYzLKuPXe9kB1gXxapVv+VJ
 EcG/ZghHKHnzhSsr5I43hNxkGlOefsYXOhRqT1w56o8udnp2WqHYeVxswdsJHKKRilC/
 VQbMvvgnfGuXe75gz14ndggMgzFBy39S6GGTX20PnnjVLw0ZEAkzN15zEr3qnzWIg8gj
 VTfA==
X-Gm-Message-State: AFuF++mYWnS1VDmkDr+1PcxuS7qrq4yQA1Ozi/oDqsk9wO5JSpJ7YAmy
 tV2cHMwvMbisZkp10rCdfrtYy0s4BhVoM91TrTQH88DUVxlB+ShwqpujtK1W3jnQ8lf4FQ0gDdh
 24LV6/Vs=
X-Gm-Gg: AYBFou1lLga9/Uo4R7x/4EGfq8wIw427Dawy2b9nsFNKVNPTfYgPUGt7MsiUxVl/Dem
 jbTeG9yZwSfseSEETae8bSUbOjFe7ZENNSOATCkZZ1C0PyxJ3yH6xfTJ3Q9s+O75i5FG+GNx1A5
 BLQMS2xOMlOQ0TEAeWgCa4ul+0VCKWNbdxg+8DW5hFl95af0DQix8U/vfNnJXrwJV3TatbvLcXx
 diNz1Pna1W8uA2dEsybctO2RQwOj1eONXPBCDacK0uKu0sriUPz18igSI0ix7RGtxfU9ato37AN
 LPhu4RB/hXjIeksKrAQvVjmjCXukqbuK4Z2Cl8KevkgwSkcELd65MdgNXOstQkFrJ7zXiBcwYZV
 Hg86vWJjwpfSBWHtteOA4Jm2dI0qFWfV8/ys6G3T5OFzkCUg1CMlWRd3akrIZ6qtlaJfGXlZCNT
 CU6o8WL5iiY3LwKOnEcysqiHS5OhVGX4c/E0Gk6hkPteJcaqyifwUUDDKgf6mb6wInbJa8N1dsg
 kqFVww=
X-Received: by 2002:a05:6a20:6a1c:b0:3c3:a20f:f729 with SMTP id
 adf61e73a8af0-3daed4bb928mr20220922637.7.1789267366454; 
 Sat, 12 Sep 2026 19:42:46 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 60/86] tcg: Generic expansion of tcg_gen_extract_*
Date: Sat, 12 Sep 2026 16:38:11 -1000
Message-ID: <20260913023837.741866-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 ++++++++++++-----------------------
 3 files changed, 46 insertions(+), 90 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d3c7e0e12b9..f31ad085208 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
@@ -183,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a2244bedeb2..856338aa0d4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a6f3b4bfefe..e8d07764861 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -702,6 +702,51 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                        unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+    uint64_t mask;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        gen_shri(type, dst, src, ofs);
+        return;
+    }
+
+    if (TCG_TARGET_extract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_extract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, 0, ofs + len);
+        gen_shri(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_extract_valid(type, 0, len)) {
+        gen_shri(type, dst, dst, ofs);
+        gen_op_ttii(INDEX_op_extract, type, dst, src, 0, len);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(0, len);
+    if (tcg_op_imm_match(INDEX_op_and, type, mask)) {
+        gen_shri(type, dst, src, ofs);
+        /* Do not recurse with gen_andi. */
+        gen_and(type, dst, dst, tcg_constant_internal(type, mask));
+    } else {
+        gen_shli(type, dst, src, width - len - ofs);
+        gen_shri(type, dst, dst, width - len);
+    }
+}
+
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
@@ -1082,49 +1127,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint32_t mask;
-
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_shri_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i32(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-        tcg_gen_shri_i32(ret, ret, 32 - len);
-    }
-}
-
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len)
 {
@@ -1829,49 +1831,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint64_t mask;
-
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_shri_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i64(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-        tcg_gen_shri_i64(ret, ret, 64 - len);
-    }
-}
-
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len)
 {
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D962C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ox-0004fa-1V; Thu, 17 Sep 2026 00:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nW-0001et-2s
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:40 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nT-0007Hz-T8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:33 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso272347b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619550; x=1790224350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=njQniPnliW9sEpThVZMXTUSLOcFL2q/oSYc8/Avza8U=;
 b=DJm1xbxrOYZGOZcllxsppLZoR5/TIUugAT/RB3kXceBrR1MGYyyazV3YdeuFwcvutG
 1ciFWKWGd+Wk6TYBy/jmmVcIFf+9YaINrDz1djxl7Xng1oPsPepqEtGGmFkIRVqBDJUO
 VdvHfKPNZmYLMY5zUTS4bibPqsthiAWgTkUPVX+k16ekX15ZkBf0NQ+mNn5oP6oKbCfC
 lzDVgk/kvh49qz1PxnHKvTFekySxubc+IioZ74JwIJOtMDrNkORLDnb4/nRz+DCLghlu
 iQtL4fSlt0DW5vNqeXNisQYKlb953yXJ4LAtEF8tJsKgYrW4a430dxem44Fj4NiaTCGb
 F6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619550; x=1790224350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=njQniPnliW9sEpThVZMXTUSLOcFL2q/oSYc8/Avza8U=;
 b=x7chyWTbyryokbry9gdHeQqzwXDZ4bhMJYOso969eInuOrvzGa/xYMlLmrzwZlyX7k
 4AufiNyc198/FRkhy6DJ3l9tRUeOKUiL4sNoZd76XXjxpMA6fDUbMlYylzzjvyEzMhYG
 eZ44djA+Cl90RNbPW5AKyL6l+Sh45IKeK7PT8mQ7hKsIyhV5XWShoflntxflWboYBA5o
 KVgpI0roWPBQ8IblE4JmfJCQOLCHjTJM4sDbX2Qry9w/mdWt4eTwALaukOtCIhEkqWtE
 PBpPGs+N76wZOWuj4XuR52lpRMuYB0YdgNGAe34FjGkMncFMawAv/tmDGodRoFasIsu5
 3Zew==
X-Gm-Message-State: AFuF++l0Vb3L6YnFP7pnngDmTLtfDaVToFDwnxYMxvOvgvvUzuXTQ95W
 MytdFHRhb/WTN9RPSboi+bMuJDQSMPzdjOkVQmd3i4XJ5K6kdEXg1ujSFGIW0tUY0WhcHKvmzPw
 LgtK9bak=
X-Gm-Gg: AYBFou2sVW/ScTYiU1lLdcZVk58mIaPaOEcFPlS7z+q+BKtOKjsZNXxIhYSVUmFSTxD
 MO9gYsAV31DcUYQwzmpI/g1J2ItavzwDm8SFRUYOIfiwjKk8d36mgsr9UVGkeiT9EX5a/5cdr+R
 VjCZUS3+6/F8+eudm+eYZbKANIpD80R2oIJjtuutW+x3RRsYwrtURm4tgPZkK6mrcaHJEMTvkpF
 BUC07cqKa9O6E1mVtmIy7GMJOVq952hlV3ar8R0Y3vF6nW3axSoAieaIwHK+LdxEsnAm0iVcILh
 KW//Rc7qigLbpbosOJCQc4GGoDYOyiFlQ3w7vqOPo7MS+P9aa+JHI4JxU050P6AB0OudTrQ/I75
 4SNXlrfqo/gHCwyM69HhN76y7zJTxQsh9Y09W9MeqW+oEcuObqp6/dlW2fZ1bZkvJ0T4b+7o0or
 bJHdj0TdvfTeg+spH1j+NrflqZy0uK6xAnrn/qfbMPeS9LFBkJbuaVz3+aQEh3S0JLpEVDCwPX3
 E7dpoYkNA4/ZffclA==
X-Received: by 2002:a05:6a20:d43:b0:3d1:c99f:efbf with SMTP id
 adf61e73a8af0-3dd5f5d8819mr14197312637.14.1789619550515; 
 Wed, 16 Sep 2026 21:32:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 062/101] tcg: Generic expansion of tcg_gen_rotr_*
Date: Wed, 16 Sep 2026 18:27:44 -1000
Message-ID: <20260917042823.542588-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 62 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bd1c76d9556..a1c32214723 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3b2b0b76454..35542e003ef 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6a34798ad79..925ef8244b7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -858,6 +858,26 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, tmp);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        gen_shr(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shl(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -971,27 +991,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shl_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1781,27 +1780,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shl_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4E606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uSgVDQ2H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaW-0000UA-TA; Sun, 25 Oct 2026 03:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZc-0006Us-Nh
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZZ-00046I-I5
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso7381045e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912996; x=1793517796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uFlpjriV1K2dxD0UPeknvCd7c09O7s0ROHicU1IUnJ4=;
 b=uSgVDQ2HdBirm+f4T7dX5EHRCoqEY55oHs+m1y3TRRoQjHvVtdsVFSRIfRDc40bfxn
 i4fWQMYCfGIEq2AZUFA0lBVEk+313kflso/tSE20U4v3C/qKr9ykErOIblgz7eP2izx3
 JPispOfr6MQpYF7E/wK+yvd1M+4cH1g3SlKSSVkz6/tVfzMi3S9yUWevJAemsXGeYYFZ
 4oPET3SIbDooNlB+7yykcqfsWSxaueMg8MRtFq2IzrsTDkLMiyLmXtUC6FprrUt6X2us
 h65qIsc7HpcHavv6ww5jejbrbUY1ytUNhSDtndquu42PsXlR7LK8gFUyZaKUv66Mf1wD
 7GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912996; x=1793517796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uFlpjriV1K2dxD0UPeknvCd7c09O7s0ROHicU1IUnJ4=;
 b=eKRaaB5ymmruX1jWuhq5WkDtBTnHMgpJlWmRUeFADBdow7SWKog70/cILTRylu+elS
 a5d+UJmS+TQ5Sb94qCVBQhC02NNKB8yJoqz9ulMpPvRtjs+ddr+XgFZ8YNnZVMDBrxXR
 ovgGaRibp4fnyiHJdeJLuke9n9R5XAVPx+91e2B2Ky2C1sj4nen4I1pCCcLohQw9aMA5
 Q+KqYpXK71ymTv41MYeyTsiOoy7HmcFa4uPsS0yY3JfRW5sf85Nw5qOBYnIkte7bvypL
 OrYl2F3N0/+4RxpSYv2eECU+UHxD3//Ay/IWxtvkRDWQue2oqicj/aEIcHSLTXubVFok
 84/g==
X-Gm-Message-State: AFq9FYLTlAQNMhSb1Isb//1I6dHqSmpI1nZRCUpj3tYgKZfTqUQTXxlK
 EY0ugFpYveVIC+7PDS7K/POb+sohLe8cuzpgEmzCDg3YzLCaTBiuFXuE8xEJUYlQOCvenkifXl0
 uVolW8FU=
X-Gm-Gg: AYBFou2Tksj5wxGFyDJQv4VHRj0qqBA5D8ZlRYxSSfoWjzudK/GJhSvpa4je8fKx1Fk
 GVs+7wCNkj0BLKQ3m4UQEU7WZaDAK3nucIHDhhmgHGmlsc07ZSXLX5v2bpd+Gt9tKtPSsZP7YU6
 y/ncwdFALU4Q/+nWVYixweN9YRi2LA17R5ah2rSUiUMPyP4/6B2oLTddH5IyNAg46Oob5SMIw9e
 KUEOF+JcqFpe0kfrs7Xv+8TLSZAxQlFQ2hZzIL2e8+8eufYMHeCz3CMwwk4y+iK/1GyyzrwblXw
 WeSlPAG6mc1s3OJibbib0CNvk6JnKbINCGHNK4wp8H9UNUWQD7FDgsCu/QE/Wt/jBigBZy3xOlH
 n2uVFAD2fsQfq++hSvGqKXODVUQkh5sVqbnLGhG1gbE4bnwb2TD1jgq+/Z6n+v0vNOqAbnO1IIb
 nwZa55X5MQaTiikoUKrQDll/SiSYlyVPt+Ll6aPMNQHkn4vlunbUo49ziBFz9qQzK3XdSGuRYFh
 wxQihp6Zx2g6nL/qpv99Vkb1y5TiZKcPI4y0/NpWarCT2DirIktrICdYzBh
X-Received: by 2002:a05:600c:3493:b0:4a2:a6e:80f5 with SMTP id
 5b1f17b1804b1-4a35ac9d0e8mr60449835e9.11.1792912996036; 
 Sun, 25 Oct 2026 00:23:16 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 055/100] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Sun, 25 Oct 2026 08:18:30 +0100
Message-ID: <20261025071915.1123867-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
 tcg/tcg-op.c                 | 45 +++++++++---------------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4c8ef80474..b1a66149b5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -186,7 +185,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2436fea04d..7ee00c9d53 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,6 +12,7 @@ DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
+DEF3(ctzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 730962f052..476b8bbdfa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -470,6 +470,7 @@ void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) t1 = NULL;
+    int width = tcg_type_bits(type);
 
     if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
         tcg_gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
@@ -479,10 +480,13 @@ void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
         t1 = tcg_temp_new_ebb(type);
         tcg_gen_addi(type, t1, src1, -1);
         tcg_gen_andc(type, t1, t1, src1);
+        if (src2->kind == TEMP_CONST && src2->val == width) {
+            /* No fixup required. */
+            tcg_gen_ctpop(type, dst, t1);
+            return;
+        }
         tcg_gen_ctpop(type, t1, t1);
     } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
-        int width = tcg_type_bits(type);
-
         t1 = tcg_temp_new_ebb(type);
         tcg_gen_neg(type, t1, src1);
         tcg_gen_and(type, t1, t1, src1);
@@ -513,6 +517,11 @@ void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
                     tcg_constant_internal(type, 0), src2, t1);
 }
 
+void tcg_gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -819,22 +828,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 32
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(ret, t);
-        tcg_temp_free_i32(t);
-    } else {
-        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1680,22 +1673,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 64
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0



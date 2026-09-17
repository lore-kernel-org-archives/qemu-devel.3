Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEADC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73oF-0003hB-Q2; Thu, 17 Sep 2026 00:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nE-0001Jc-TP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:18 -0400
Received: from mail-pz2-x1d.google.com ([2607:f8b0:4864:3b::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nD-0007Cv-50
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:16 -0400
Received: by mail-pz2-x1d.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso260148a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619534; x=1790224334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I5pqQ2J6SFFdXsE26NRLc74uPP3a3FI6aFrdRYK2Cbo=;
 b=NpdoJv8GKVGwc2lHe0o5Yo0M63SacJsS9CZoPbxYSph0A6DA2icAnoB7dpfLPd4i+S
 LRCufAdO0bST4duYPnC1WpI30WdsU0gEBQCtzDXdpm8L6CRQn01r9V5pRWsdomP/2NAK
 NRCHVHZmr30y69O2XnudxMxEmBBecBPVSt4kQNopNxOxWW2AITckPphZsKMybWSULuOD
 jD0sZj1+Qb9KcimVKpMMYjlrDqi3gxunWoEyqOYDTkajfLa/ouqmOFa1bJkGuYSIgshN
 eluWg0Oxc4Val7xqREYRyZbDarIl107yPnp/BwDIQyVWoSkGeOaBDzPK1D3z8yJMBYz6
 UlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619534; x=1790224334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I5pqQ2J6SFFdXsE26NRLc74uPP3a3FI6aFrdRYK2Cbo=;
 b=qSMET3cBGiLetKe0vX3+Nn+BZ/qd129kRMOdFYEg8ODzdrTV9bsG2oIYzdhBhUb31N
 bCOKwuRsTR3I50NLWuk90IeJ9tBiIDlsCXtKQfQixqSvrcNxklq4Vsu06JpuYo0nQW/8
 tFLXy3vpYeyeA19Uvlrh3Qoim9Qea+kn9xXMMO77+OzJIV69UAtxiTdEzFcUPzL0K5av
 BZmdWWQug+8eMOJ2Qwnc5sd9E3EMZzrDi78UBX/bV8zygjSxFnjO4GgFYT8iqMtHI/uV
 eCQCRAELfVnQxRtGq/hv2o0cKi3IJzkPSUeIEtgMzu+J0rE0RfKqFcvp96Crr4gljhOy
 zpbg==
X-Gm-Message-State: AFuF++m6yWrwjVT2MBSh66AXAQ20DNxncHWOKfve7wWwwFQjZaz8YtQq
 31G0NKw+4yX4vUovU3daHVLBwj1tx/RKbj86SvzMAX/kkQt9ptvnVuiYdqou+MJNBiHgT3dpOUy
 7gPFgHzA=
X-Gm-Gg: AYBFou0uR8dGJYn/w4fp+al9BGHKeH53fLOe6L6vWm0S2DnNNXuc15bsPhzyOomAeu4
 gNi3b6qg1AX/wLtlOmGcDMNXxDTlDSCX2waIuDR06+trSy3vzppJBmkQ8Uqapqz/d1GOMQ74Z1c
 A1w8fbMJzkLZ8ulbbXHSltUwWk5JC31snOukOEKXj1s51Nz5l0Yr3YN6xXcf3w44M1zU7bWBlt1
 dqerMbzMPf3JzVHz9QHjBTpeGku/oZO8ZG1Mj5Qu/EU7o+yQTNO62tp5GNL9sNMdRn+Hw2Ggo3h
 tpjNL2fEe0m6eRDsMrx8YzGJU7ZQXXFdz9w9nJt5IOselIKQLwGow68Wt5smVaRWxwTNmQecQgM
 qSs8eGYgCz9r7xW4d27gceBD3PybVURRjxY0HBaGtKaE3Q97c/3mt7KR48EhCGGScVGh+QhZJJk
 Xu80g4w1ZhUjQHxRsyhZRKdA95YQoMkpoQkhDWpiA25+nOs0QG9ZFlZPyqyNMCbKdv0XiukAlg9
 B/EVLw=
X-Received: by 2002:a17:90b:3b51:b0:39d:f95d:bd08 with SMTP id
 98e67ed59e1d1-39e1e47ac09mr15006313a91.14.1789619533425; 
 Wed, 16 Sep 2026 21:32:13 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 044/101] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Wed, 16 Sep 2026 18:27:26 -1000
Message-ID: <20260917042823.542588-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x1d.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++--------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 31d35780739..006f668aa5f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -218,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index d2bbf9ba017..63e87c8313b 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
+DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34e85f91095..abb37a6d623 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -476,6 +476,12 @@ static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                        int64_t src2, TCGLabel *l)
+{
+    gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -735,15 +741,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1534,11 +1531,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.53.0



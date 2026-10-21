Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03027606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qQmqL3kb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAR-0007FN-Fk; Wed, 21 Oct 2026 10:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9y-0005Gi-GA
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9u-0001jr-Jd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso7964065e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592353; x=1793197153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gd0IL4hIdOIcaPXVJ7h8nVHsWhA1uajw2N2WhYB9YSs=;
 b=qQmqL3kbhq7h8+JyUTtKFmZkpB4tpEbXFZwD4yBihM8U9ByChZCzIf6SEEvMxxHUPw
 LDRhAvRuvzoHM/VlwUlytOD5meeE827tn79MCsemPas8qHKwalyRKfD8M2WthJYEnFaR
 /rlcAl7G6MHa6PXepDmp152nUFL9ZprATZqzZXa8lZqCSzO+WGCnkaQmL49WWBYzifCT
 OIV/bTrSRpMI0CoNzOL44PqWNXO3WuTtMhwOIu/jiWcm9HCDU/lDKRH5OnOG4hdYPs13
 sbq2Ck8YwXQbyGjou43oCwi5qYPbwkaM9w9KqB7shz63jhZSvZh3neoyU4mw+Kn0czHk
 iEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592353; x=1793197153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gd0IL4hIdOIcaPXVJ7h8nVHsWhA1uajw2N2WhYB9YSs=;
 b=QUUyEVKK7M4jIb12LARoJ1hOTcACiIGhtvxVhZ8KlxRGUmuZGlTyvFo260rwJ74Ge+
 fN6SaJA28D3F1Xc/Kgw842NP+g6cgy1aAtr1i2EKNvPvpa6EWMuXiTa0nSEtVV7QvvqS
 7Q1GZE8Vn6Pv1bw18UE1Q11eGLAMW/y0pXtobTzz33ceQHcCD7TT/FNF6yrThFz6qJL1
 cC0HLjEdvHMTEL4ef+O+DvHG5z9oDd9AKb1qPd/HVDwEVtvoCTQaN9TsjKGfjLfk3C7u
 uC4+k8avlSZFeGcl5Iy+f/p8ZyHX9UdFDqigPrU87LvzI8Lvcg/iZHdX9/TOThhFohXM
 YX+w==
X-Gm-Message-State: AFq9FYIwnnHY8Xkcuah1SHHaY5+meRPDm0WtRr44VWWGi9Gtbsh/rG2v
 sxHlLcMDFmjRiqqnPtsTgFGt1GsXsti2eOFhQaxtSEfGEXvjlzB4ZTN3Hj3CgZB9ULPaW8n4U1t
 KoSFx424=
X-Gm-Gg: AYBFou21ntuP6EUhVWbbiXXVYc+5PqE3cEj+xHnQLE3OMy6ACrZgTafilnsVRidd5F3
 N1V524rX64gtJTYO0I9IyW80+0jcCL0TfG9H7UEd+pePihesPzIZcPCD2CTR2kk3uH2kRT5WgfH
 mDan4pOeXreHNKGI6MF7rtpkwll0aTde7ePOgd8/liiLrwsiidUwKsWkNDaMT1RNcrqNqbVr+04
 ove1tkOSWsm6jU+yZI/5rL6dIL9McD8f2jVuL+02SokgbvwEUJ4wbXRUKjK52oI8c5YwZzn+glI
 pHz+F6SJmbwLmJQNEwMbYu0Nnxd9ztTkQD3n8xCNl/R6iWe7jiYVZSDFkEqVv6+EM7orzBSOnJb
 fBOZOLiiLSAUUNkIwToG1OfWZ5Gk5VW42mdnG8kSuPi69LHd7qHLfpEox0NEjiFbCVo5VtPBQ63
 P0jj14refqW1J6N68DHQY7Z0ghwOWgGRCO+5bicHPSrDLfv7ZrqBHiKt0CsznPYBqLq+yG/gVLk
 DL3qQcuGnf5KqBks2oVibkUlugFx4wTwkrkKD85gAqpVeTlrtZGmxlZKCcOPDE0DGJj/sQadPGr
 rBi3f3M6AlmszXQwPzNVbZJ+ckE=
X-Received: by 2002:a05:600c:8b41:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a1fd8a7c32mr47637045e9.2.1792592353132; 
 Wed, 21 Oct 2026 07:19:13 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 037/100] tcg: Generic expansion of tcg_gen_eqv_*
Date: Wed, 21 Oct 2026 16:15:49 +0200
Message-ID: <20261021141652.363109-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 70d5b991b3..4eb35775a0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7386332658..6a4d726b79 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 860c9678f9..c38accac75 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -437,6 +437,16 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        tcg_gen_xor(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -675,16 +685,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
@@ -1722,16 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-- 
2.53.0



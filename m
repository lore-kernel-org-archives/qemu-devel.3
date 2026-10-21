Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E319606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HGG5FQsT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAw-0007sG-46; Wed, 21 Oct 2026 10:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9u-0005Et-HE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9s-0001iE-E9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so4839415e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592351; x=1793197151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iD4PP19o2tgLL9o1wrZ4QYSBTk+KcRlchQ9tj/UxXtg=;
 b=HGG5FQsTA16Ryg4L5hxnnZOdV2CfxROgflsIvtY6/duSAcfi4MtYff9tZRWoYa9u0l
 AdPM2msHSCXBrmWiewQ0DXz1H4yPue+3oDi5D/zlATswj9q0mH9ZqMXmEYMf/4s9hKE8
 b3W93EvAFbo8aluf95lABNCfo0Oa0nj8ZARNlJGOvp4quenWHfGs6L3u0t7OGHA7i+gD
 ReN5Osie5UwZ8X35lXP8tnY+xLv9zX5C6GWPL4w8jOt7hEKcj/d4qR5tUa90sq/aDsmx
 jYUSP0L1j4fMAnXDAExzqXystSplFl7jTWhBjOMr792oUn6+tIsBrXwGqOlCN3Lkrgi8
 DBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592351; x=1793197151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iD4PP19o2tgLL9o1wrZ4QYSBTk+KcRlchQ9tj/UxXtg=;
 b=jBrxlT/oUgCxzlVAJ8iaqljqMMjgB4eV7wm7Krennk+SL+aR1aJIABvXHSdkB87sV8
 iQLdmMR8kIDidsMHc+/mdyRlE8sIebilcGyExORBBfJ1xz6Gm/A9ivKe/+5FNo5Nshet
 98WHXDli2DSOU5MEJV2MZYQijRjACXcWWcU3Bs4TfsIBG+Pi3htwmYLA5aLm0MEpe+2f
 wxl0MpmAQPmrNwipUTHdebhPO08R5+HyFJatVNVG7/jxRlFoD9H/Zfsj0Vj76qtXJZO+
 RI7r6Z5QA7E/mY2O1x3T1aMMPuTVI/VPXkHVawLLdcDO1FiTOEhsrKBP/Z/y5ezNOaYL
 2Psg==
X-Gm-Message-State: AFq9FYKOv4PttbLMi7Nw/30/j3WjFVEeax4dSHQPIt/hvYmsTwxbo6e3
 63ZMws8TXQBcCFIHEDsHTv5+sk89QEuelmmxlVOS6Yz0a0mMIGQeqiSS8aK6G4jTL7QScwiqV2c
 9INJxsdI=
X-Gm-Gg: AYBFou1KwXXVS1HIiseNKPBoY2zvKcBLcY2LBXNkkAaytzIkvyHSYw1Ho2K2re2Jhbn
 eUQZirWOeHEYMWfRgjOeXume/UTpEx7g0jxiavRUpr/U/t0GlaM4SFTRLEH+ddeLL2CxFHEl1zf
 NMt4l7InjC110+twfFMqNYya/b6PbtXAqND+EX3LNdJ6f5kdZisYQpvrMRPVFl7/4VZ/YLw5mFa
 0x0abZfSAEqse6VkmJ9O3DyEdE86xmCcGz0A3inIFWfEvkSwGx4bYMApCMn5cZqnLr7QnU8V4KG
 iMzwX78sR4k6DryOhJtefWvdOQANUZw6mTklTpS4U1Pj+ChFXlsblAssfg6SdTG5i2Zyk5p6qHf
 DjLXYorI397is736dVECs8vIJlSL3pghdbZkEqzNicx5dROorKXRqYmvYUKk0Oy9CrLft6CeCMP
 JD1+pKy0FFZxj+/Yqnq3RrfLL75NzoRnCr9XJ/nQkLa1kNTYZ4FUEkOjv/F2kEVJ8xYDNOXUncL
 PzoJpMM/UJfFbW1a+c5ThMnq4doBcRKtKAKKlEnpopYAjVR6qJLtUziwG/XYx3gHnDD56O+6+FN
 GvCPOJpd56rjJLkaI2cgzy/bVUk=
X-Received: by 2002:a05:600c:4f87:b0:4a1:e0b7:ff09 with SMTP id
 5b1f17b1804b1-4a1fdd62fbdmr44747285e9.33.1792592350938; 
 Wed, 21 Oct 2026 07:19:10 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 035/100] tcg: Generic expansion of tcg_gen_remu_*
Date: Wed, 21 Oct 2026 16:15:47 +0200
Message-ID: <20261021141652.363109-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 74 ++++++++++--------------------------
 3 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9024963c06..d4d670dfed 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -202,7 +201,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1b108d9f14..cfa19a0a81 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(rem, TCGV, TCGV, TCGV)
+DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1bfefb9d65..fa6c152164 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -211,20 +211,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                        tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
-}
-
-static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -518,6 +504,26 @@ void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            tcg_gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            tcg_gen_mul(type, tmp, tmp, src2);
+            tcg_gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            tcg_gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1,
+                             tcg_constant_internal(type, 0), src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -657,26 +663,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
@@ -1537,26 +1523,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0



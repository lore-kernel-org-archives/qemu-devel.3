Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB026C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8C-0001Qy-2p; Sat, 12 Sep 2026 22:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7p-0008Va-DS
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:25 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7l-00015s-Dn
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:23 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ed1368so7877075ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267159; x=1789871959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=haxqP9S2xV2D/fL0cuYt4FDZpyartSHm0IfAR3HWzeA=;
 b=dpbnVsiVR0O068MwvwiDjuL3/cJMBfAjWbId9Xzrijv2gXR3CTdOHnKZNjGNNotDXx
 KChx+CfJXYm2IJ44PMH94Ve6jBN09upeOe6/K7jVu+wlzQD1RW+IWZpZ3GL+3Ts36uPk
 GFfsSxVh7p+so9Aw18wPxiO3PdjjozL5ZJTuy0irPaZdo7AFRVFVGECzpYJ2aPPuLOYy
 sBdzZFsl3Zz9vbXAVY197X57xjXA0HHrsPgFTFygNXREhhnd7x+EzrbNHdhemrsOHCct
 iomAMdj7OKhGeIC7FgwH0d8ZDQnbbWmUOG1vdv0M36EJa2QgR1KCDT0NfX3jw3IHBrmm
 3ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267159; x=1789871959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=haxqP9S2xV2D/fL0cuYt4FDZpyartSHm0IfAR3HWzeA=;
 b=BFmsJ8j5QTadYVNVDyskYOWG6/vRBTRj3unnV99jC8gvx4o6WZWLjo5+gqrivWa1HK
 6SwQLMNS81IRQwFvKjiUdPPGiGQOSkJzK6UO7KYA54qFfQMTZESYwTWishxZ6cEcDviq
 qzGXbxSw6tKOXD6FJ1Q8MPZE9jsC/O+OyVhlb6xzR0ICxeB/Z/uysAFIpkwt+myPB4MC
 14d9jZxjQNC8xxzc1GvIVBwnTAb6vt9bp4At3puYrG/1ONiMBEcGj/qJmlAM8AyKaFhW
 u/QtuVvwzSbsmJmUwDKVeesyw46RjKlVuBYi4O3RnfH8X5hGaIF1sHFXLnBAH/ca/C98
 oCXA==
X-Gm-Message-State: AFuF++nOkwUlYpXg/AExfplZoksgXGAJSdkPtFdTzDXhdOQgHkJJNXE3
 OX74PgnR0LUw6UCOVnLrP+Vi439/af3VrBWGrbQiyjFAk7AXoeKe4HON8ThnF2o4IwbmY9YMuhm
 Z/+PVfhY=
X-Gm-Gg: AYBFou2rWS9GrmDsglvVun3PpGAhCCAFjsjph6P4nzB8NqiqIVblgOiwYmBfndnziyD
 usQFjr3f9ECury8l8TB90F3nvQH2ffIc0D52TAHjAtdJCGqj4QOqOK7+6QugUQiJ7V1zBz9MUzd
 Wm3IQ1dAP1E2C4s6jQ3/22iE6G96ZGmeEr6Ys848ZvhC1b++acjY13aGNGv65keUOP53rARBlkq
 fOWWkcnVJ11Jjdff4L9rIH/LYJZML9qx6f05IjVUSMPArf+D3D2TA1zOA+7HnY4dEHlEeDxntc3
 ECre2MSifmC6qsw0TxMBz1mhfcyH1djK9B05QIfd/BRkQ6u2GrequGgszXtyIuse6FmgGwKa1tn
 3NvVaQ8YPECHDVshOlKO50wsk4KyySCYcxS9d3lR8Xf+epjvSqbuWr38EE5j+X2I3OXoSalaI+U
 Ng2V8jXQMmu2vYelXjNSLr666sfG8k6jKOfZCOMPE2+flc43JrTQGestOMqzIBdV64KcSjznXYo
 MIWdBA=
X-Received: by 2002:a05:6a20:72a4:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3db0e485bb5mr9936244637.21.1789267159267; 
 Sat, 12 Sep 2026 19:39:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/86] tcg: Generic expansion of tcg_gen_nand_*
Date: Sat, 12 Sep 2026 16:37:45 -1000
Message-ID: <20260913023837.741866-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c71eff07f77..621839a3b82 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c1b99a280ac..80d174a6cb1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b06d6f1455b..89362b597f4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -527,6 +527,16 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        gen_and(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -740,16 +750,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
@@ -1777,16 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-- 
2.53.0



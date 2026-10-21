Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCA606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tdNmtyq7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAG-00062C-Lx; Wed, 21 Oct 2026 10:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9p-0005CI-Hr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9m-0001gk-UD
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso7220015e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592345; x=1793197145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y4TDPW9DuKv1G+48PxQeaVi8ngNpOTF31IXPU43EPXM=;
 b=tdNmtyq785evte5kt5ffs7NeVh/8BrErineq+pKTm4M6pFTe2skUHNV6ONIOUtygpg
 bLYDbG/CIei27Z2mcbWkGTzaLJrhxsba7Rj1Wm0SSHjgzvrJkss642Sy8F2Pv68j8UuB
 KpuHWUmDT57oyRwA1jSVG1C430ntPLTegcMY3rWicPkwh6bYvlrn+QQBt7Vwf8JAqpmZ
 +DCVCf4nvcG25Q9rdPJ3aith1v7FLLzu7zXXnStA8B5C1l3hhOlAgMMAmMAEcisBGoxe
 n0i05hLXmLMqKCHiJnCQKUpfnQJSucI4S/8/VO4cV3+nRpAQzvMuZi5D0emK3AIawNi8
 ag+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592345; x=1793197145;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y4TDPW9DuKv1G+48PxQeaVi8ngNpOTF31IXPU43EPXM=;
 b=IAGEk3SQEPDEmaeL2XyQQ88h2j/DuV2zRnKij2XLcA8xXEz+dDBpCZUslZgccz3VmH
 WMYjcbaJwHyIXXo5100V4P3D8cBBsqonnYmMzU+Wxb5m5CXXvDM4a2lvXDSYX60XJvtv
 ZtI/YmgkKjCRcU3jCC+Mj4011oLDJcsdzzlcSrZAN1GqmNr5hGY44Kk6h0sqoMPyd8MT
 JKKeQoWHHSKPsl4TfSTBl8NBt59ekMoiytlZB5/SsX/zEjg/FGtogILK/0i1Y8wXrhCo
 eFMoBoqFa2244h5aOC5KLr5fahV46Sk/o9Sn6vfdGRMIaHx5NDmAARudkfpVb7/zqenI
 Fh5Q==
X-Gm-Message-State: AFq9FYKgwy+r1tys9REcoyTquhkeEkPM7Wn88uaVmVTls71EnhkCKPYV
 vSmt/5PIc+AXHvhJJIe6l0WTf24WIbKxy4y3b6My0wqjBKRrFodZHgrS6UsxzmQcVYyPAxyt/7b
 wSCwXidg=
X-Gm-Gg: AYBFou2Rz1ZFQ7zwdKRYRDFAoZT0VTTo0gG6b5g/DU3WqDDJbEijCQiFwPLP67F0zQp
 0LKT7Rdqj4IKRpv6DirfytjQqEmAJyeaEI1r3jQ+zJtkt4O0EiOGqmlHpfmjtEACPUSYPLDIf4y
 etp7GDTg/rfNlD01m/5lwaSrzZYxy9NRyEs9bKJE3d/fpa3ESfjH+CqwrPhXru08mzPtcsC5oI3
 86l8ShWnlH/1+3SYgRGihfDDKPYKU1/hoG+Eajs1+u8HYhTdfj1CnhfflSSAmFR8ynNJLVXhUk8
 3fFiX8154/nEIXBULw4Si382r9S5SbMm15nbvOCYyIjudKZELeE5RykX46s7u52AZmZlvbaxiT1
 6NP5vXjvrv+1FbiJdjFQARnDCg8LFkiaafSF2KeqV2irrzKyFTThQByvNc2S0Ahnag6H4YUJooR
 WPkAONm6zFV+F9oFVKT9aiTGm/+zIWYBQ/DteCuxQ7nSZVlntICsbvmULV5jCV9FdAIy/r1Kl82
 PksvwFccMJdLbbuXA9r6wrX0+cU+1ZjwnSfIgJg2LKYOiSYqpbzOpY2v7LMHWnKA9O7Uo8XJlN8
 YLyxwQT/PFx4bApIKcTQoM8ln4Q=
X-Received: by 2002:a05:600c:1c1a:b0:4a1:bc6e:2f4 with SMTP id
 5b1f17b1804b1-4a1fd72acf3mr45492955e9.0.1792592345447; 
 Wed, 21 Oct 2026 07:19:05 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 030/100] tcg: Generic expansion of tcg_gen_not_*
Date: Wed, 21 Oct 2026 16:15:42 +0200
Message-ID: <20261021141652.363109-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 28 ++++++++++------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2b2653d07c..df6563af9b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -203,8 +203,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
-
 /* 64 bit ops */
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -258,7 +256,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index abea00e7e0..8c9d3d99c4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 23aeea8026..9b3974fb8a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -444,6 +444,16 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_not, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_not, type, dst, src);
+    } else {
+        /* Do not recurse with gen_xori. */
+        tcg_gen_xor(type, dst, src, tcg_constant_internal(type, -1));
+    }
+}
+
 void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -543,15 +553,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1803,15 +1804,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i64(ret, arg, -1);
-    }
-}
-
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-- 
2.53.0



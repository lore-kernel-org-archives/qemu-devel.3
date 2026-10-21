Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D97606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CwjbtFHD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIL-00086P-Ik; Wed, 21 Oct 2026 10:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGd-0006Q7-Dt
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGb-0002Y1-Cl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4956869750eso6084435e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592768; x=1793197568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/6i8urWUvVZmg+YUAVnzyb1BjLS3+t5BSXz60TIc2JM=;
 b=CwjbtFHDrWFTfwIKzdCdrLcSa64tYuDugD6kwOLCv/GflkXI9B/a6i0mI9Jz21bbvx
 1JbYo4lZMRoMZ/sYxc1SdGa45KdbWWG1RZLVtoJuKT6Mja5W/+nN84SvfD1ee6JKfhEY
 ULm/TJTMnUhbm/sXPj+fza1suCizkdBSFbLckKlenJgoHajnXofoa+zY8xU8WeKUDn89
 ZzieVVverEX5o/bkCYa8lVTFZ12nLWzIr29te6Str7v69ijVnbDPJT/p5eBQa51SNMd7
 tDht80GhXLdJpubKI3dDzPVZWfBA16slAocZ1FT9Cbt4uyV2DlIftJZQet3OaTtaXaLR
 UGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592768; x=1793197568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6i8urWUvVZmg+YUAVnzyb1BjLS3+t5BSXz60TIc2JM=;
 b=h8Zxgpks+yvIhUfnDqS9GFD5X8INM2xdReD+b2eszUTr8S+L5kcd6YYEhXfOtrXImW
 6UuVpHUALotOjfhqXFlJz/0BDCNSYyYTNhH3ZmBvDoNuQ8QbT9TvWSpgZSoPTPtzITBU
 0GuYHwxJEnPYL63BpG+3HLQyqXguuprx7t3t3EVgKpIuKAlbCV+T191Cx3bxMIT3v5I7
 x/ZkcBgZcrp4CF7py4J8TNIGrEPwkLJrMSbm1erjQsQNSShLKRAmi9xDCtBpis9bTamq
 I1hgRBxekE/dQEmm7sXLFhHuh0YqMN5iqRWYPAJ7lbQ/XoDfrNf7pV7JS7LoKoMQFkC2
 FojQ==
X-Gm-Message-State: AFq9FYLuzdOcTKEm+ewhfUjE7fAQJRH+EZQUnbVzRXUh2+uvnLg6Bf9L
 FrdD/Roicm6PDssHudaI0S3CQSXL6BieZVbViSYK5qkgkzXUPV9H4Srr8ovLBl55mh21Xxko7uP
 IZzGfjCo=
X-Gm-Gg: AYBFou2kSs5xcwipuWurNYJdM1ayKAyr3MkAQOonNXmAubul1pMcEWskPrc8FT/LUW6
 cMDPQwDliyyX/GFjTC7lPWTiVTJETUXERj8RFcObLcllVDlbI1Axuhqusq57/h8vAN9Toaozdpc
 H2gQ7hL3V9EXNo3nHTHtWjl6Ifr2aX7nYq2KwqJKM73EPCl637vYbz5t9TKojQ8kFjFfNn72UF6
 aGXBQTBx8fPYMcTcEb9bxBGAJPjFf7D95/Y00GWRjpKChE873OHA/0YGcr3m+WMxPgVEHty2IYr
 oPgcebHtcB1Ryci9q5cjDY/GjHSEvUf6AtN6kkz9BED5RZay7bHzqm3o8Gptr2G30l9BArep4AP
 XQRxM3nB5xOI8v1YV+reVsDFSJSKcvHwSUlkJ3ybxuPNIhD53uQbGE7iy2Gw9XaAKxOViAbTM0A
 9JYJidqk4rhFNn/nvywMh9XwV+1Rg8hsQMIJr6DrvXtRfp5bPIFb8P6UqdS23uGhjl/P0aIpJsf
 vZrSO5rZKmT0osuzEPVWNhkaDXW7LenyT5iR7VlfbWerfrpgfHbg/3m7htJe+D9IBP+RdK/woAe
 ZNTkkXj5LA00fJu9vYoj3SnznBI=
X-Received: by 2002:a05:600c:3e1b:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4a20059f587mr32688375e9.14.1792592767588; 
 Wed, 21 Oct 2026 07:26:07 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 087/100] tcg: Generic expansion of tcg_gen_ld_*
Date: Wed, 21 Oct 2026 16:16:39 +0200
Message-ID: <20261021141652.363109-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
 include/tcg/tcg-op-common.h  |  7 +------
 tcg/tcg-internal.h           |  6 ++++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 24 ++++++++++++++----------
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3a577beef4..697de0e1f0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -176,7 +175,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
@@ -374,10 +372,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
-}
+QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
 static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
 {
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d6ea11d8fc..bfd34905ee 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -191,13 +191,15 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
-#define TCGV  TCGTemp *
-#define TINT  int64_t
+#define TCGV      TCGTemp *
+#define TINT      int64_t
+#define TCGv_ptr  TCGTemp *
 
 #include "tcg/tcg-op-def.h.inc"
 
 #undef TINT
 #undef TCGV
+#undef TCGv_ptr
 
 #undef DEF1
 #undef DEF2
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ab1bf25929..6284358a13 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -31,6 +31,7 @@ DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
+DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7bb0bceaef..a329ed79a6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -240,11 +240,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
+#define C_TCGv_ptr      tcgv_ptr_temp
 #define C_int32_t
 #define C_int64_t
 #define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_tcg_target_long
 #define C_unsigned
 
 #define TCGV  glue(TCGv,TExt)
@@ -271,11 +273,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef C_TCGv_i32
 #undef C_TCGv_i64
+#undef C_TCGv_ptr
 #undef C_int32_t
 #undef C_int64_t
 #undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_tcg_target_long
 #undef C_unsigned
 
 #undef DEF1
@@ -765,6 +769,11 @@ void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
     }
 }
 
+void tcg_gen_ld(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1389,11 +1398,6 @@ void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1442,11 +1446,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
@@ -1864,6 +1863,11 @@ void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
     tcg_gen_movi(TCG_TYPE_PTR, tcgv_ptr_temp(d), s);
 }
 
+void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    tcg_gen_ld(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), o);
+}
+
 void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_i64_temp(a));
-- 
2.53.0



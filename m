Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0304606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a5V/Q2S8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8F-000387-Kr; Wed, 21 Oct 2026 10:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX87-00035j-4U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX85-0001VW-5q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso10370605e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592239; x=1793197039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wTv5aJ+MHtTn5QsJ+b2+/WmHfKzz63YG9RFY7LzxBxs=;
 b=a5V/Q2S8h3NzWfhNv2FQ+cA3kulzXy533MWi9eV4zKlUea96izHP2qzooUaOExSGha
 Qp8dTAKOLeoOfvWh0YPjLdl9IO4KkeBRmGQ2we/MygvezKOpPr/CVScQHdnP2KSFL+5A
 Q3iAnaJHdLCIWuddtHXRrSF2ua7zSsK+4ikLGGArUfInUjjmm7Hmpm9/UdhxN0s3ba98
 QaI/3ZYLeItRwfpor8qMU2xGyQQrBtOrUHjlPeOsLl7rEm594XJJjEV22L8ItyjSYn04
 jPVd/EjeKzsI86wVvOCNk65YlB9PU5UXhPFShb6CklDTD2lfxnpbmTAtBN18keaTYE6V
 Wzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592239; x=1793197039;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wTv5aJ+MHtTn5QsJ+b2+/WmHfKzz63YG9RFY7LzxBxs=;
 b=ehf3t21NqqvnXp8uPDWfgZ8dhPRQEL0zhcl/8KN2uTB9hSrQav3CDY3yoJjyxkOlP0
 rUBwRDmgsJq8JmBpVubs0gtAliRVjpVMpS2WsvBEKhu0k/trcsBK0Q50phIwNMdKJmRG
 +3XUmi4h3GXoYNbFa0ZEpUa5C+EPAUaOk34RZ3TNqx2ODFV2T4Ca/SXfB7iynJ+mYJNf
 TcioJYK+bNFn606pYtlP+7Tdai/qepE7tBXHFghH9dT5ldmaTvUIPmtE1+lg8UCF8ehT
 rJ+yLpDumqOw8wIvRnvUd2MHc0NEXa2a1Rzok8bEqX8Aa5PeOWww32yF5mMlveiqcvJ+
 0Ubg==
X-Gm-Message-State: AFq9FYJ3hWkn/mhvN91v0awIzNpA+IUZ7lzDoMnLk+dEyMndFHKs1aB+
 5qALIYXacOgNMNvu16aYcQa8X0potcybj9zH/8kRSUYOMeFCTMuMy8Yx0gDH3dGnZRG05CES2Ye
 fTsry24k=
X-Gm-Gg: AYBFou27B9l3cgodXcHyebjNQJblmBQhRFpM/ud8MV+HT1L6IgYDVNQHURtmpMpdUjZ
 g1fFGEG0oO8gXBaEb34EK+9F13d6EVveg4UoUysx+t2IqtQnO+LKiUeqWVye5GAeYNba0sQPzgL
 /s3R3/Bu/7/FAwYWlVt9PmK2DTLGf6nqJ72oT/JnM/hkvA9B00hAUIC5yVIpfrI9GJwr/6ws4t+
 txvBET5yYl2LbVVyINBz8HmZYIJHzFGC0ifp5VG95JbgmHP5YTX6MLO+7W0KnxNUABH8Krcoaub
 9uz5pUrerivnKJXs/g0MBEShvrS0gW8s+8F16EFRvrcMlIYR86OL7Jef2d2tPgmhQ83MF8+4blP
 Qvb76HRYovd1lRNdc6EwV85yFtVLn7Gm7c5zS8Tzqu2x94+WtP+FsC3Xvq9NSSqdTEtTe7Hqgxa
 9CmTBAUxrL2gewIo5U4EQAaclUdYklZVpKwfSzB6hLauV/nyKLLXtmuSGze1WyghvH2rvJOmp44
 5X3HRSDh8bJ3pe5Ph0huxy6LcwPGCigIN57JSirtVsHg0PpkXOXBMe7360WKFjieVSnSdl3ln4W
 GZRemNadrma1lywetpeLeEvYKv2V
X-Received: by 2002:a05:600c:3b17:b0:4a1:fb2f:eff with SMTP id
 5b1f17b1804b1-4a1fdd3a0abmr51532025e9.18.1792592239482; 
 Wed, 21 Oct 2026 07:17:19 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 009/100] tcg: Generic expansion of tcg_gen_discard_*
Date: Wed, 21 Oct 2026 16:15:21 +0200
Message-ID: <20261021141652.363109-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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
 include/tcg/tcg-op-common.h  | 11 ++++-------
 tcg/tcg-internal.h           |  3 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 35 +++++++++++++++--------------------
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9dc05cc7b7..6168af878a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -92,6 +92,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
  * Construct operations from templates.
  */
 
+#define DEF1(NAME, T1) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
 
@@ -113,6 +115,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 /* 32 bit ops */
@@ -197,8 +200,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_discard_i32(TCGv_i32 arg);
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -317,7 +318,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
-void tcg_gen_discard_i64(TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -541,10 +541,7 @@ static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_st_, PTR)((NAT)r, a, o);
 }
 
-static inline void tcg_gen_discard_ptr(TCGv_ptr a)
-{
-    glue(tcg_gen_discard_,PTR)((NAT)a);
-}
+QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
 
 static inline void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
 {
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 3568157ebb..ed1f5f20f8 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -124,6 +124,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
  * Declarations of templated TCGv_i32 and TCGv_i64 operations.
  */
 
+#define DEF1(NAME, T1) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
 
@@ -135,6 +137,7 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e55a9f9993..8c61a75cd0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d7272b08cd..ffddb3c19d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -114,16 +114,6 @@ TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
 # define DNI
 #endif
 
-static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGType type, TCGv_i32 a1)
-{
-    tcg_gen_op1(opc, type, tcgv_i32_arg(a1));
-}
-
-static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGType type, TCGv_i64 a1)
-{
-    tcg_gen_op1(opc, type, tcgv_i64_arg(a1));
-}
-
 static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
 {
     return tcg_gen_op1(opc, type, a1);
@@ -319,6 +309,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * Templated TCGv_i32 and TCGv_i64 operations.
  */
 
+#define DEF1(NAME, T1)                                                  \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a)                           \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a)); }
+
 #define DEF2(NAME, T1, T2)                                              \
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b)                     \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
@@ -355,6 +349,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int32_t
 #undef C_int64_t
 
+#undef DEF1
 #undef DEF2
 
 /*
@@ -363,6 +358,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_discard(TCGType type, TCGTemp *src)
+{
+    tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -377,11 +377,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_discard_i32(TCGv_i32 arg)
-{
-    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1439,11 +1434,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_discard_i64(TCGv_i64 arg)
-{
-    tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
@@ -2769,6 +2759,11 @@ void tcg_gen_lookup_and_goto_ptr(void)
 
 /* Host pointer operations */
 
+void tcg_gen_discard_ptr(TCGv_ptr s)
+{
+    tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
+}
+
 void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(d), tcgv_ptr_temp(s));
-- 
2.53.0



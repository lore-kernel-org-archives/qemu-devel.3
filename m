Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB42606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JGJSAK36
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsZn-0006XS-B3; Sun, 25 Oct 2026 03:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZP-0006FM-D2
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZM-00043l-DD
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so2126345e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912983; x=1793517783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOC8OGudM/7EvLzoqNr5p6WEyNqJj6tXrDhZ4XQD+oI=;
 b=JGJSAK36NAzyJ1xY5sOiZYGiCzVJRCejkYtf+glszVsvtu4w8vhF1n7hlq7sMfe3pC
 n0z6RGYAXCjmLcYtOfY6j/Yx9rayhVt/5nYWKrEcdHt4rD+NgLp22wMBvqTSCiacSwZ+
 OvLxj7nHOkBuDgddUfv3tSQqIO5Ke2fQUV3RVFpnXTyJ37FFoll5eIZaoCKErSf0vF0D
 +P2uKTSLXOamA1BuC6/ay6IkAvpjNyoLZEj3+pSwYutuRkkSePARMRqAuJrkeg/8tQfZ
 6AbPdcTzEzFEcrzrrO8M4EsciOqqhJ+Bt4WIukrtB0Xd7Ntl93ld/J+sTnXgazVODtPv
 bw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912983; x=1793517783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bOC8OGudM/7EvLzoqNr5p6WEyNqJj6tXrDhZ4XQD+oI=;
 b=uRNYZuQNEf5nBPt1oNJgQufmJbiJ6cD8J3cQlYtoqbVceHRqlZLZOGhcbEMxXIAuti
 a5OxIdOu4m3w0izj81IJElrY/BerjkjAC9DvwR7EHsB+2T+x3dfdVFgNZzhiD/jtfXXS
 +rdXrvnBDz7IlwVU1bOW+DnzqBtnLigM5w/PpTkEZJmzpI02rCaIb6k5roZIlQt5coYi
 iDhNOWFbPMYYzT4D6oRct6IQr/JAAqecadMvblWCIBkYfRql4DGHY7E68lUkCG+nOrRR
 wrWNQHTycRP25tGa4Z7inNzGzEMTPJcjiFt494A7jXNdp3nlWvgWTkaU4LG7Qma3WHUE
 p1xw==
X-Gm-Message-State: AFq9FYI9H7mzKpYSZSyFjYX5bfz3mCVy9oEYJKOfejF+t4G3n/3F5Wiw
 2PetevZ4a0RzP1pDLOkt02TBoRGY5l7MijROZPYtJwdiZYZgNXeEHceriO/Wuyh62yuxe7S5YTs
 RbADNltI=
X-Gm-Gg: AYBFou3SoWj5AVlAkVUcOHIzzMgEMkxKxinKJ1A5eeqKe+DGXtAe5w5cXIqgZ6OrqGx
 yUV6XVEE6Mc8lvNAQ1gK684yOmk2t67EX/QykhtMrT/rh9EPSEvD73QfUsNpxvlzF4GxBnJOAiq
 wmVIRpZuIggvc5qkJPRLJDHIckRnEbsSThOs9+diB5mhKZ+IfLIo0Z9FcBRKbuKLt836XUrPXQ6
 S1z++JZIx9H9c3aiZbK6mogvzVIGC2yY9KjEUxzDlATSOZz1ciPxK/drJcUdEjALGDR4E5cV5LG
 cUxnNAPgqk1ld2gGm6E2U6avoCGjr0PTtr238em6XOTBQh/23WtrpKivjisehrDADVhYd7VIj5p
 /8HEMTxWPms19Qr5PyFhuL1EkJg6Nbw4+y7Gjyf1JUco8Cb0EemzRwDfNi38AYQS7U4KsDIoTtK
 jzjlDnLjUxs+xyYESahN3cuB87kwPc0+lzRe0TKYB3uY4emy57+J0L/iWrCxps71eUaf02HSSyT
 nNuDeyMSLIUzC4TDmoSNVXQMsDh8uFY1Ql0FVs+V+XKmlYZh5sFsEK9ltQ=
X-Received: by 2002:a05:600c:46c5:b0:4a2:1364:252b with SMTP id
 5b1f17b1804b1-4a35acba20dmr60470855e9.35.1792912982670; 
 Sun, 25 Oct 2026 00:23:02 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 040/100] tcg: Generic expansion of tcg_gen_orc_*
Date: Sun, 25 Oct 2026 08:18:15 +0100
Message-ID: <20261025071915.1123867-41-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f959f82e08..e62459b5f0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d94e0cdfe..fa33d41e3d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1ec1cc1e97..8fb04d3c6e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -526,6 +526,18 @@ void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_not(type, tmp, src2);
+        tcg_gen_or(type, dst, src1, tmp);
+    }
+}
+
 void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -705,18 +717,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1722,18 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0



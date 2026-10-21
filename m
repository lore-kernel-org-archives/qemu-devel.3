Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03763606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qz5c9Ywh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIW-0000af-RI; Wed, 21 Oct 2026 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGj-0006ch-LO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGh-0002ZK-IZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so509671f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592774; x=1793197574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c886W/vA5gqCuR6LvN/pYXokwuBiMEAZElqBLc8Svyw=;
 b=qz5c9Ywhj4jzPA1WjbqqDEu+7RmBZV1Uaq5sT+KlgvxtfxOd/HANWOlHOMzqYTCUtM
 gTGMiiZXAhOUJnJjMueL24KB6VChADbIxxU/KHQPw2maK9rmiAzgD36ZhuZocbDIDdvK
 wb2gSa6H5OSwo/hKbGWD8Xp1n3nFx3viv4pluwyULL43LsIVMbX/7GzdGOec2zFbgrwV
 NXfzKZrC2100qB4IdwpQm++SXseHzYOvJ/lwqwh9Yd5On14uPekESc8QTpGESXIa0M2R
 6WTRC1RK31e28k99k3F3dVjwQDwBwzduw1o4qAQTtBXXNhgd3cCevUkcTGy7gxFPLwKD
 Xjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592774; x=1793197574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c886W/vA5gqCuR6LvN/pYXokwuBiMEAZElqBLc8Svyw=;
 b=EYxEI3pUzzrJxBCFv5FXwGCUvnebGPvo9YHvo6ltKfV+1b9LXaf3vjyOOyjsD/G4PP
 22MZ07mnjVHOsOr45xa/NpJR5vj3IWpsntWywZDOZgRU+hNVFfx2fo2T9oo5+dCcBkfp
 OeiRCbSv03GPyzO278K7/47QJ+y066tt8u/9Se//9+lyHRxy4Q9cYkvVdZBoik7DI7oo
 q9GAmLfWfSKB7GR7Qz93DxD25kXWDC7h7mkkadQEjz9gemGlUZGpEN/0x3NLPT5BFpxN
 wjUgRCywKfk/H3ievD3jsw9/K18vLwBQ+dRfBqGMcLl77K/Lkqexg16xFKgAx/XJ5s3+
 u2FQ==
X-Gm-Message-State: AFq9FYJI+kL7cGwjlyz5T9ba6N8KFicK5ffCbzZ4vGM+oHIQk8r7pwvr
 MmIC6OZv7JrQGfO/2s5g6CxodZ1JWwPbA7IMthFtF2nc3u3dySjvF3gMpOXbAzCbgcwUyrjisDS
 0VfhitpI=
X-Gm-Gg: AYBFou3QbU9fa4E3ILETtzQ8+vMZLDYAJyI3wr70oAHYHJGSdaDnZmEklQjnSxQEVUr
 Swn71l21LL2reAkS7JiwuIYo8P9CYewfvgrBR7eqryeQWHPmtUXDUKMr0oT31LhZr18rdYx7U+L
 lgiSvWDDmt0rM2W5SA4tvnjASqdxT4sRjnIogI2pBAYCXVnvukOVH55w3PfkqusNWeqifHAmdnk
 l+awYZrsLOoEgstfdZtnSXLcAFBsfLs2E04L1QMuesIW/WKJ3EcY+XFl+B7xB9hmeeX+RzXEd08
 KlqQtx1xJqesavwoOwod6zLI45XLv7mTXESmZfk+3zyb3RLY51nxaq+MkOfHbu7SoqhV3RKN4Lh
 slo3RkkdjQ6LNagP4UqU2TAc/W8aw702d9ujpa5S72sCnXg8fVcxskm1+5ssco95t0z4c41XnzK
 yyU0AJNb3GgV843mQDZU5IboJ3eutDFX9OHH4NO93fyHjLHA0XJSAeBM0ysgewgpTLbcpqfn7J5
 +TgzwkRVi1dXBQCfLBy6ja5dJZSerDl6DCt8ywHEiQczLUeLmCdNo//L85k9Zor7U2pQcPrwoZW
 HExfhNBNgO7ZbpT1UlTIloYHQGU=
X-Received: by 2002:a05:6000:4552:b0:48c:7306:18e9 with SMTP id
 ffacd0b85a97d-48e264ce798mr3166125f8f.43.1792592773866; 
 Wed, 21 Oct 2026 07:26:13 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 093/100] tcg: Generic expansion of tcg_gen_st8_*
Date: Wed, 21 Oct 2026 16:16:45 +0200
Message-ID: <20261021141652.363109-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 469b925fe0..cd66b0d7de 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
@@ -159,7 +158,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 514967f91d..90bcf9e5ab 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -71,6 +71,7 @@ DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 68e31fe5ca..cc70c03b1f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1256,6 +1256,11 @@ void tcg_gen_st(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_st, type, dst, base, ofs);
 }
 
+void tcg_gen_st8(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1407,11 +1412,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
@@ -1429,11 +1429,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-- 
2.53.0



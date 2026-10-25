Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37105606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bhZ8xrCH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaa-0000rX-8g; Sun, 25 Oct 2026 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZY-0006PX-Q1
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZW-00045U-TR
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1203514f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912993; x=1793517793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M16an36QGeBw2UQoUHlukJphj1p1Y01TON4heoSfRV4=;
 b=bhZ8xrCHfc/mjoqEf7xEryZfrQLKgoRhgMMTjtner9znSQQvY7FDdg8wahdtfEworD
 4l3mUjLxSJKfivAa9g5ZbCOPglZG2B1wRGFCKqd6qYWLarink3n2QpvkNslow+nlOQRu
 YACXDIbbJOFnRpfmaOPFLM2qO5XhOWlnAAYjEhX6A8qsHsTW9StAdIxffRO7eMzt/C05
 +zrgwTHA2qCB0MMC1Cc0NDntvrsBHp6m6pRp8Jj4KTqfQb1LXOumcy36ujpCkrf7j8jC
 YbPzUWPxMoi1Uqav9O28kJWTl1n+IswFScA+qne+6IPzenELwsLz8XboIZbw6h+FzhUz
 1Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912993; x=1793517793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M16an36QGeBw2UQoUHlukJphj1p1Y01TON4heoSfRV4=;
 b=1cXS7McKmU71A3z3orCZYCbbJBxMCub1Bpc0n7LykDTv7DiinEInji2W6ezVp9rP2Q
 w0QIs93U1nG+yjAvNA7bZ6s7bufTfN2cyjZIhsu2shgR9dIXBk7latTSNq4EUK2j7c7l
 OGMohrmtldAMjXYJCS/S8evHrK47KGkSnUDeWpE+FQjDVyuuc1w17ePU7aiyB0WyeZMk
 mgmycAHu7i27RAWjaXxUTUEuqx5HkUTjxyRl7WO33eKp8b3qV/LZof4IFh7OLwgBZV+d
 zVk9brqvApvQQHPqWuSqnHbS4PiUcSZ0wGqfcI7XxWieIY0ibjPMJesVOBT70jCjCqe/
 qrJA==
X-Gm-Message-State: AFq9FYKEEXsB6Imk//raPWmiZPSctRjT0SDlrCaKNJb4ePh4I0Cah0x7
 JH/Pz0pWjAZBQUqXn81dHZD4n8BxSEJe7XsFnDA544KAd78Vu7z6hBwY9j9jUV0P7bufVfQRSOd
 an/Ytvus=
X-Gm-Gg: AYBFou1SxZEG/yBUlEOfztRXJOcX3c7PjFGgCaiy9vKVrIHcC7RZ4agXREBVtyz/DlH
 eTFjQOyERqt7w+A3MKlD0HENO/swBQAKCoL6IRndbdjy1Y60U65FqezWPAxVSt6L1aEjUfNYwWR
 gEy9XH0EE6C4Fo3mxUXkEP10dwtOOwooylhj131jCUw0eJ1xnErmNny74Jb6UJQunR1BTzUNGQH
 eUS+sBBRXxTuhh4sJRDJSp/yGjcSsiDUZRqdBR43bheKPb+ambY0jRE7cGkjuvv7Vf8RE1flFJ3
 RSonb411aWTRpzv9FVboKMB1manL3NDEUTFO3fIe3c/UdsLeFXjjHEz73is4xSYlQkoKyp/w6N1
 hjk1srvxSzZ8IvgWD4CKQX5qJ65xqmhPAHGYBJiQQHnw06X+H4C8G+g0cUG9oUK2NxfEbcgsQxV
 PH/nfHGPIAR197OU22SOlFUETMC37jNGOtB7Aq6ujTfRuWP4FE1DDRvMG2F7HFltIa464ixHsej
 oM6DOrD1ST7UefbT5TdxytN9NBMfu9aJht8RE70JN6okoLSuXFYFH7NeTU=
X-Received: by 2002:a05:600c:6098:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4a35aae5dccmr60652205e9.0.1792912992779; 
 Sun, 25 Oct 2026 00:23:12 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 052/100] tcg: Generic expansion of tcg_gen_clzi_*
Date: Sun, 25 Oct 2026 08:18:27 +0100
Message-ID: <20261025071915.1123867-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b5575647d3..d68362fd02 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 74c68f46b7..cf832a6dc0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
+DEF3(clzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e623f9bbc7..efbbe4d8a1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -445,6 +445,11 @@ void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -751,11 +756,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
@@ -1672,11 +1672,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
-- 
2.53.0



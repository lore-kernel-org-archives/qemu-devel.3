Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C9606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NQUwvqTa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGF-0005Wq-LN; Wed, 21 Oct 2026 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDT-0001eX-Ag
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDO-0002Bg-Oa
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso448849f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592569; x=1793197369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+80amZZW2gqt15j56GErI9T8k1sGRMIkuvmF69qJcWU=;
 b=NQUwvqTayfmhqj7WfkMER/2iDztFkQ+bVJy+ro4Q15WoAUpMfzm1wyUW8X5LyEeUpD
 bfVpuqwh7BbhYEuSrKXqR5+PlvI7SIs7xPljA1tFkPOdkxtu0R9iNtH01gAEow6Jg1wc
 yvb1H64sXkTXqn0fOeDIU62mrG2ysSLxDJ/Xd7roVhVzrg9ZXMUvWNA/1CvhCHFbhK1F
 SNeFyX5gzRsRG0DHfo1/vJ38CRQLMJsEjfKtl+7vmmJ4NoxEfTP3Sx6yFUljWDAfr4Xa
 l7Dx85TYsNUo1KQDQx0cYQv5tkWyk28FCoYH2179d36mQ2q5p/OZjgT3thMfDflbdys8
 wYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592569; x=1793197369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+80amZZW2gqt15j56GErI9T8k1sGRMIkuvmF69qJcWU=;
 b=yLWuCJJ9OYbXHRxvEJLjBkCjGdxSES6tweZXiXsZhH4dA0ioVB4hMk6Zh5b1lP9Tis
 qyc6XE9FDoNdZsSVxA4f2pSfdw+JSnhaFhaXP50DX6+UPWf2Y6wCQrVEM7Eb6bcYvMSt
 DndCjL6ULiToB2FVgT80ifIlplg3GPwIT+ti2G99euOZQuA7Sxm0vufNhKDMCrwtjfHc
 UV/PUKCgu3RKeTsnbspJJBOg0fU4Myy/YkytSFtv2wb6CWxu6lZkgtFHODQR/93/v4jt
 KxAkA5oGyiP4jZbubLLhBeMHnPlKte1VzcOnkkJ8f1efz8TZiPIdJyzLIzDku1XHKSSL
 +5Aw==
X-Gm-Message-State: AFq9FYLvYZfi7FRiwoRwUxtUmMubjcAH9w0Mp4ca07O1KLRe4aV2fNcB
 qnvgDOwxLEpmhBmrq5RPFi4ccUIz/c6zvoslN/EIhjVMVX+EyTrCEDpHibz+OA8ZbpNCBDPiaRA
 ttsn9MqI=
X-Gm-Gg: AYBFou2L9QTUS/xyLtJvzgcVLbY4nrgdbIIclwYoVUwKtmwbhWxjAfHh6paWkzTYc6j
 z0EZmO1oIlBfUl48BvCHNyHjuP4tny6lIVM2PLErbE9hFq/adBRo+IAEel5OXWESYDBSNHLz9ZO
 wDBvqD9BiCiIhT0sZ3f/jeQRyGUGx5k9EqcJ+dat1nsF8wap4zglvq1yO5G6OWtjYHGRb2P3no7
 I67GvUoz6ltpMwzAK3x53FnMFkrjawJxFPA1OxL/+jApMhTKsa70VT5kGERkZG0RjkLwJvFz2Hz
 BQ3kE9fseU8eVgnD1q97BuOPekvX1XFbXfr1gfRS6qbsaothbHHgqMrMgWgZ5EzxK+KPo67Rnbs
 TPZF2S12shU/7bjjOrtpRfvzfIYQr3KZLmhFvCl9ZKV0YOiaSmkPrNejUj247d71EwDfFM/90Xi
 3+VTUJGm50TE/9nbjE8X3CXOv4VdEUhkWGmERuzumBQNZIQzfvj84eXrXIdGSWlW2pjPVcrdUky
 Z5wixfu/31+oma5+Kjhynb550q9qSsvSZVfDHYisTiAmwIuu6I17FVh2+DxfSTOi9ZWJ+q4RN2S
 qDw04yjgNBoO6EVd0ghdc6eB3sQ=
X-Received: by 2002:a5d:5f44:0:b0:48e:2bdc:5e5e with SMTP id
 ffacd0b85a97d-48e2bdc5ea3mr69176f8f.29.1792592568850; 
 Wed, 21 Oct 2026 07:22:48 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 070/100] tcg: Generic expansion of tcg_gen_smin_*
Date: Wed, 21 Oct 2026 16:16:22 +0200
Message-ID: <20261021141652.363109-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 911b94f9c4..54ad54b0da 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -189,7 +188,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f9812c1f88..1486066728 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -55,6 +55,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 11676eff30..24e7d6da50 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1013,6 +1013,15 @@ void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1329,15 +1338,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
@@ -1869,15 +1869,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-- 
2.53.0



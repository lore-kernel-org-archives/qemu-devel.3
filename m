Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D84606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R1lzzan+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8g-0003dN-Pz; Wed, 21 Oct 2026 10:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8B-00036t-Ks
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX89-0001WS-Th
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so5254955e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592244; x=1793197044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfrfWHD9jbdup4fKj/87ebi4L3c7sWxlHODUrYabDak=;
 b=R1lzzan+VzI3LIT+JD7iMfWhCsJH74Bs2e80g61Uq0U3CwDDDmTycg4+PlzAn5KYjx
 7aTB2l6EzlxAF32u7PkGSoaYNrBHpXjw1nDkjrykuLUCyrZGOrRrj71bweO3ftzKiXay
 epHfPzK6bLP/1j1x4H8WcxPJtIREBq/WhHNzIk9HuPZePrL90BgXkWX1m7d5DRJOBosh
 Q1fr16OmqTZ1kuQtInf/rnD+zfct7Jfs0BgGh1++IBmCLC02mSDS09UvoWKZt/OI+I9L
 65Jowus7KWPxhUdC+k3NRMbnwXyA6MJQWeRmJHPnGcT1F05ngA6AV6aQLmCp79YUM0Oh
 oN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592244; x=1793197044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfrfWHD9jbdup4fKj/87ebi4L3c7sWxlHODUrYabDak=;
 b=0kL+NeVGeb/wL4txi8vQt4uiULhtg8Da4rQ9WLmbnhJjYF3EC2udOKf/NFK9A9FdWG
 vYn4HWSNvMPxKrVc7PoPN+8TErZuJBPRUr5EoEj94FCjcDD0Qyqx5dp/jGUcpnZF0RTM
 M/9QfzEBbBdx7Q4m60uvzAcP1a0KoltOExUsD6hy5VWiL2SZizeCsNWDblahFxk7KODo
 s1315Ol2qYVld6ljVz021o8USx6IZOQQjX3cEJnVniVRM85ePGj2sLo6KQdSenD1pATC
 PbRe3uVzFLJCRnmtvvwlOjdD1eXBj48u8BNSuiPAsUVjbKssEVXh9H9aDc+oCLjtRKcA
 lvlg==
X-Gm-Message-State: AFq9FYLl/OYtDUuy6r56RbE+oqnniiZTv6N5TZ04brBVF6+1PRzyMi9m
 Uz69jRAL07xPDuYUEc4RptdLFKcBIIrACQnhoFuzVSkvc5BP/dCh76S0VAdk3xJl0FzxpiEtKLg
 +xGmby3Y=
X-Gm-Gg: AYBFou1gKnQ0v4ipPaMq7udx43TNDqWX1f4i8sNAFuc07Mql+blFEyOubjaWBT/gFMC
 HSy256Wg4SGZARIwE1t0jfjqATS21coCmkdsf+riNEyG+SI5ZrkTzFKgd2rJymNV1Yzpciur87t
 eY8nsQEq++r19jIwTGp9KlcWfVmXXIbQcEwSXFA+Z4MT2avbyZdT5wd3qYs3MFd18mCwTgjtjtf
 ha/uU0I74A6vc4IgSz7acv6jz9CVpdd9+T43avrvanh+bKNQryfOsrkl27y2+0wJAjdeyJX/nsW
 Cor2A8aTJ3M1s72N1izPrtfV26s2+nf9DNzwOuO1YY4xbCri2tG7ZUWPc7vm24vHPZxsEdzrLnP
 BbFF8EJuvcrvlJSlJwI8nRVzhIYVuxNfq64hlR6nzcFBegV7gWYiD0l85KxCB8ls8pOKqbTwbyh
 urNCZO534P5R6ip66CD2cKvEfZJ717ppbu3EgmGxx+otURtU9pqC7XsbqPH/ePrj5H6MMdHhC2w
 dqtP31u9xe9GOKeLNd4zxI8xBGgHur0rf+6f9Ilo/laBo/N8o351qwjB9NeBh5+aeTfVwNHkELm
 a7VvwrtzsWC9vylCWhAQmzD6roE=
X-Received: by 2002:a05:600c:620a:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a1fdd2e41emr41827575e9.15.1792592244350; 
 Wed, 21 Oct 2026 07:17:24 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 014/100] tcg: Generic expansion of tcg_gen_neg_*
Date: Wed, 21 Oct 2026 16:15:26 +0200
Message-ID: <20261021141652.363109-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 372be70504..d7b40e6705 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -218,7 +218,6 @@ void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -327,8 +326,6 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
-
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 55249c4dd6..b5ede94511 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,5 +6,6 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4239219279..bb34f883e8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,6 +394,11 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -415,11 +420,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0



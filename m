Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ACBC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbJ-00055F-H4; Mon, 24 Aug 2026 01:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNat-0004b6-AH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNak-0002jw-R7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso2069017a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550689; x=1788155489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1FqkdWKLgfc+vRbBEL6zlKNDsJP//dgcnuZl45GUXZM=;
 b=HOmgf2IIAV4HZRxuAdY/qpuJ+h3qoQxoRFwvFNUXLxrpGoY4CRdd52F4NBmwWDQPpY
 wxrQLvFOVCIQOQ+mbs0E1c8KK9FtdI0uao+XFs+622mBGbMKpo8a/SHhokOViwG6I512
 oi3vMMj8BHnRdw/fk5dycWbX8wg9TBWzKr0+wkQz7LMlz2j0xYxA4vIxSl4ilDtWrNXd
 Y84vXdPON+zNNOJ9iKb5NmoyhA67iIvitm18v5ZXU7IBI2TnrrFEu3lLXxbNbs2h2BNr
 vD7e9uSjuUPSQ3b1WPOq5r+orNSpX/dQ8u5UULsqz2wnzvI2qhByq7lkEAgIPS73YRYL
 YfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550689; x=1788155489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1FqkdWKLgfc+vRbBEL6zlKNDsJP//dgcnuZl45GUXZM=;
 b=Cxtfa39osD+/inUvEDjLcN424zFD4FudJQ3MIEX5yVHEKND54aft1cRUOYKbdfwjVp
 zESiYyaJwl9HFC2LRFj77uw/K1eN8U9ZGFurgB8YSap004BklpcHeLVKMl9OjyYcHpBs
 NqPqTnxQu0ri+jhdiSVXFx//p2fSdsu7FqfZg/9xbAkvvixl2W+CRyc8aJ5awH9dGfug
 kUbwJl7OuCmzE+Pw7bEEHfln3+78hHCfXBSJn/u/ivaZaR23tJSCQ4xIK99oz1hFICmk
 hbRzbErqVQ4D8gXs6W0pjkHtc6W3VVqwQ2nHfRcNv2PpPju+DLMhnHNYV28FB+9FezPb
 rKOA==
X-Gm-Message-State: AFuF++lS7W3tak4QBqa6sn5cZTm7m5lpX36KwxQJ+wrZXlNEBx3EGQoK
 FehgWIcrwR1HemVjzP3tBqL7/APYcPn0hlufJZY+aeK/T7QSiATa+ZuhuvDuoQ==
X-Gm-Gg: AR+sD11AzVCeugi5Khhah04prQgrpy7NkzO7Wp3CaIP5pDwcAiUEpGmcDIQMnLVCGDJ
 Hwa1w2qVMxZ3ScHeTxbY1YjCODyv4FgbHEbC4qFke8jaif56C9xglOhg0yhrkd7IPD9fPt/5u/G
 dygJBQlg5mEmnPkV5KA7hKdGJAovFwchkCDNPRoG8y+3OfNplvf77WCl3eiyVCmncREExh7/iLg
 gkXivbU+nZ2CSL0GJm/6fE+G5jJkxs96imwy8POtKt369UkXsd45CRObuOS6aGNi7GWQVPcooSN
 M4uFsSY7dmBCScg+I51PYrmxd1tM+S2cZs2YIqwe+at+XxYN0IQ78iEMrzu0goGRfzNSnKlP8pl
 JAxyIX+dPgAPwzqzpt7x6twdFTAwoQJqFIyn77gnE2Z+EOWLwPO1OjHbRJKg4Dd33OuVxIeison
 24rdv3Rd2R4EhESWIkU8VHTvXt+rDb+FoBJ6gGaHX8QaZms+BglBgfgwdg8Xv0pRZCrAbxX2NFp
 m8pug==
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-395c3a06ffcmr39932225a91.12.1787550689280; 
 Sun, 23 Aug 2026 22:51:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 63/96] disas/riscv: Chain "ret" pseudo off "jr" pseudo
Date: Mon, 24 Aug 2026 15:47:33 +1000
Message-ID: <20260824054806.2790041-64-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

"jr" has already checked two conditions that apply to "ret".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-31-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index f3c9213fd1..91f6d9e4af 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1061,8 +1061,7 @@ static const rvc_constraint rvcc_bgez[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bltz[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgtz[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
-static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
-                                           rvc_end };
+static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
 static const rvc_constraint rvcc_true[] = { rvc_end };
@@ -1076,12 +1075,16 @@ static const rv_comp_data rvcp_jal[] = {
 };
 
 static const rv_comp_data rvcp_jalr[] = {
-    { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
     { rv_op_jalr_ra, rvcc_jalr_ra },
     { },
 };
 
+static const rv_comp_data rvcp_jr[] = {
+    { rv_op_ret, rvcc_ret },
+    { },
+};
+
 static const rv_comp_data rvcp_beq[] = {
     { rv_op_beqz, rvcc_beqz },
     { },
@@ -1896,7 +1899,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { },
     { "j", rv_codec_uj, rv_fmt_offset },
     { "ret", rv_codec_i, rv_fmt_none },
-    { "jr", rv_codec_i, rv_fmt_rs1 },
+    { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
     { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
     { "rdtime", rv_codec_i_csr, rv_fmt_rd },
     { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C273BC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtl2-0005rB-76; Wed, 19 Aug 2026 23:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl1-0005ol-8k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:59 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkz-0004LX-LX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:58 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1562241a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197676; x=1787802476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hk5GZbBPE9k/cD83hwQyRHgA+R2YMqa9HODNXp3uV+Q=;
 b=ZSY7lgOcMLE56jlMKONpiqc2SmhccSeTs8GB3FrrGvH2JTwXbk/91XIozXMcqqgD+m
 UZkZRD1y8R43jkpOtUCcArn9lJkW/DOrR41szsXmrv7QVnbgZ/TRqH9XUggBCB4UOhHU
 Ze9Z8dBns72kSYgEYi/XjWoevUsOOU8IlA2QcPY2PdkMqZLQcL8Lo1/yexB5bNRfnn46
 m4fLpBgB3QU3+QTACns9KbDcFmVjlqr/dEVqY3+B+fGRdyUzmeCv3qF4DmReCV7RhpSD
 39gZdKwIbnOmrl/Pi2lFB85FKRQfoQ5ry1r4kiG01c8D866/4NFOH3U3nLeMUYwnLsGE
 ZojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197676; x=1787802476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hk5GZbBPE9k/cD83hwQyRHgA+R2YMqa9HODNXp3uV+Q=;
 b=ssEPJvac7nqW+9tN4HCYHHDElyZRYmMPOjzoubGrTxMT64IFukGPzxX1jwNnAYn93P
 3Toh66yL1hfv+OOYzYtV9hDqumxoIxRYNoZvXlkik9Lcu3729xwFVLq12iJGmfDSeowl
 /PEtvb29AO+JS69JxPh5eeVth5Tj2kKwdY8YIJl+SFaC/ksZWutkZ/sd+tP7JSvWsu67
 jjNHjERiYRBc2gVWIbNXCMj4SAVzmgxCsdfUSx6kMQ1aJWYp1dfoWwY5QKODG/nqLQRJ
 5BoPut+1X4l70HLd1Dx5yLdtVPi4r0EhCwAdJsmz8jus58vndSMVjglHWolTM3+BTueK
 i2Vg==
X-Gm-Message-State: AFuF++mUORKlsM5zTf4gEGV9FnNmewQbDEqaJVmcrsejYRBkjRv7JimI
 oifw4hj8oFnQAgfNuHNFzZcdCu0av/vpV6YV58bepZ/DyFaExJAJaA5YmrZL6A==
X-Gm-Gg: AR+sD12FIYi/7IR8ba+QjZaEb8u/y5msJX7S94hyHT3BkFrYp8bz9hT4+mctFXwWsr3
 tEOvAzJsEKq5JzgkMvvKyCGlcpdNQL8Dmmk82kVG3BX8TF8xkUsNB272uldDN/q8NOkRU3RgX4M
 XIGSe7m9EJuNfyvTSoJJwBYDRZIVw4cOl56zx/PpdI8SYq1Og2WKY6t6Lf3z7/ExYi317zdQSxJ
 RSCg20aPEcxswY2i9uOa79xmvMiYoPXLlssSJ+Fm2MHRu5snSGUatYOZy24pZnCSK34TRCWDzPB
 25ch6q+ytZKVM8dpjgYT7W1YmxTkQ0L2ovZRnFmbRZ8Jo5ge2DqSDtR8qU23LvoMlrJFYPCwsqX
 vpX3QRAXYYUaJBXdydyvQrnEC34yZWP++j/8OdlU0NOVJy41bumgPwvxg6WJOpUYraTcbnE2Hz3
 HJXZNvUZ+IGARLbF9c6VagFN1Si63vEFd9JuQ/taSwbGbb5QOSGpfpAzblKhCyf0GCAGp0ebO6Q
 XWZBQ==
X-Received: by 2002:a17:90b:2d05:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39581470f03mr18247322a91.14.1787197676348; 
 Wed, 19 Aug 2026 20:47:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 67/93] disas/riscv: Chain "nop" pseudo off "mv" pseudo
Date: Thu, 20 Aug 2026 13:44:04 +1000
Message-ID: <20260820034430.1186695-68-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

"mv" has already checked a condition that applies to "nop".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-32-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 91f6d9e4af..7fa76b2d15 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1035,7 +1035,7 @@ static const rvc_constraint rvcc_jal_ra[] = { rvc_rd_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jalr_ra[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
                                                rvc_end };
 static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
-                                           rvc_imm_eq_zero, rvc_end };
+                                           rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_not[] = { rvc_imm_eq_n1, rvc_end };
 static const rvc_constraint rvcc_neg[] = { rvc_rs1_eq_x0, rvc_end };
@@ -1108,11 +1108,15 @@ static const rv_comp_data rvcp_bge[] = {
 };
 
 static const rv_comp_data rvcp_addi[] = {
-    { rv_op_nop, rvcc_nop },
     { rv_op_mv, rvcc_mv },
     { },
 };
 
+static const rv_comp_data rvcp_mv[] = {
+    { rv_op_nop, rvcc_nop },
+    { },
+};
+
 static const rv_comp_data rvcp_sltiu[] = {
     { rv_op_seqz, rvcc_seqz },
     { },
@@ -1869,7 +1873,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
     { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
     { "nop", rv_codec_i, rv_fmt_none },
-    { "mv", rv_codec_i, rv_fmt_rd_rs1 },
+    { "mv", rv_codec_i, rv_fmt_rd_rs1, rvcp_mv },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
     { "neg", rv_codec_r, rv_fmt_rd_rs2 },
     { "negw", rv_codec_r, rv_fmt_rd_rs2 },
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DFC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp8f-0004uq-W8; Tue, 25 Aug 2026 07:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp8N-0004NV-B8; Tue, 25 Aug 2026 07:16:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp8L-0000m7-49; Tue, 25 Aug 2026 07:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=DW/cil9IxDNlgOKbC6bXT0bjUdikN8CxO4edvgtDNR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D2H3hR6ZnBOgBOCSrrHAwDEmsrUYSWG6ZumOgk0qioTWU3JkhGF0NHBY3zqrmKbrD
 PDWV3TrmKfiqkZCGc6JJ+P+OcCiCK39K5UW3angJBhJNrDdtCJe71dJ8J+cGJMdPBL
 AHiUKxZbNyW1lh7uAhl833yqEfXLIoxE8T98LnucpzfRaf7gspuywLpzclyNQuFEoG
 68Bs177464AhMpdhfZqPfEfvHVnnSN2leQZE4elGT/o9saz8Qj/t9moZj8XUaTRpF5
 lTmdN/5ZUQv4x+aX3mDFUA80+oHQAdWVtCL/V2R65FEhlAzFqiNju0D38BGaCJdIka
 GqLlPbUH961PA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8661B1CE4BE;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9F44A41628A;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B3AB9325BF; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 162/166] disas/riscv: Fix typo in th.lbib format
Date: Tue, 25 Aug 2026 14:11:58 +0300
Message-ID: <20260825111206.482723-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

th.lbib should format the same as th.lbia, and the other
increment insns, with the address register in parenthesis.

Cc: qemu-stable@nongnu.org
Fixes: 318df7238b9 ("disas/riscv: Add support for XThead* instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-41-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ecbd3a031f12669da98cdf929cbc7dbb88d3450f)
(Mjt: fix-up across v11.1.0-496-g7de6afd53186 "disas/riscv: Drop explicit zero of rv_opcode_data fields")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 2f2ddb8dd9a..1df92313669 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -189,7 +189,7 @@ const rv_opcode_data xthead_opcode_data[] = {
     { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     /* XTheadMemIdx */
     { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
-    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml, NULL, 0, 0, 0 },
+    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
     { "th.lbuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
     { "th.lbuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
     { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
-- 
2.47.3



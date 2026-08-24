Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCA0C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbI-00054L-JT; Mon, 24 Aug 2026 01:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZg-0002ow-AN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:25 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZe-0002Qa-M5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so3373097a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550621; x=1788155421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WGgzdLMhBzqqG5u7HPy4pNvhAXusg8bxQ2Tn3SIcnEE=;
 b=jH+B9g9lOvNNL2kkb6dcHS24OT/yi6K33eCpvFlyNCNpiGqYg0FV31WC4MIE8oTYO2
 RtYUsk4nW5YF2VZVM6J/sov/21eHE4XCP7FS0vULnngxQhZa2LDBv+xyO2goZsD0QgJB
 UEMKxugSJJyX8sytIPo+517u50gWooX2ekUAf9kRSLcjKaVZMJFh1j/oOeK73O+bOEKe
 B6EexUNEPSheWCR4SJ+9z6onwgF+IQOVqUcOrcCzl2VNZ5M2bMCVAStRHtEjs3/cJhYP
 lDLhsxUX8YqDn2RRFMyaSnpFKA2jlwjJ35275k/t3Ctjrn+xFXw8mOZt7T8DvMgCTqwP
 Jw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550621; x=1788155421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WGgzdLMhBzqqG5u7HPy4pNvhAXusg8bxQ2Tn3SIcnEE=;
 b=WGLGSIebp/QRPMNIPLcL9TXL6RZuq7tAMb9OvWc6wEXZcTbkasLK20QAJ6Z11RfsW1
 u6tg0o9T2a1PlfPwk0GCohJlSda9Un5gWPzclv1W0jBaTkhvrOPs1AUM1S4FtxcrybBB
 c7q3VpGdk8ci0NwRdHUkWyIrnqGthb2OzpYRaJ/9MIKpO5cWpXUJRy6Ehazn+0rZcZGo
 RD1leT7q2JVlnYP531S5wIgW2G4ZJ23ov4gIVliJHD05YhCe6izIsWPOksZiDEtMMeJE
 Jq+9HUedyeiLMlx7U2sPDCNi94npkEbu6OLwKhhVWSx/omu+86MmOqSmzVtq3kaqE7Dn
 Z0/A==
X-Gm-Message-State: AFuF++noaIpc3yeNdUn2Iao4Ffz/49dgrpDNLb9zXkeotnEU/jL7Y4yS
 2gR02/QWheMUcVTOEA/iCLyreRqS6Gvi173EOeLTV7Yft71CU3ux8hhx/cagZw==
X-Gm-Gg: AR+sD13g+2czGrt1IjC/Web5uZtbAeie1P763XVi+nIUH5ONhiy/gr4IkLNjFpj9U1V
 C7iqaTond99B3FLvIXq1GVPp83y2oXNeuoCrBCTGFECf9apPK3QX/qqlo0RfTdUqKXp9saSVUQ+
 de7yHNLaGA/8pO233F3Z/s0h8+RLZREegWAbeK9CW4ziAOQDwiNhPyhQo+k35lqHLQG2IssRnkX
 IsFfDtF5hgDZbHtm7ipBag9RZQ0/OFMtGo5Ws+EwQSr5lpwhGvE1GpnTzyHdlJmEWS+XUKPwuN8
 YpJ1/Ts1q77kbwANcPdd1rq+MoeKrnw8mSR1boInMwgReIyzAoFCks+m4eDvmaGpImAxAE3Ix5U
 255QKnB2zk8bAgEBexqF+rv9p33VqQ3dOwcrKIsDOTzpMuJenMfMfpO2ji2EKzmHTwggB2FR+PC
 CPxbukPrJ1pOeJqmzDMWiw9WB3JHuC+LUj8LT81IxYqzXzFtn7YC6QxOQ2zFkwQoeKiby3eTkhc
 LbvCQ==
X-Received: by 2002:a17:90a:d404:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-395decde369mr29789090a91.0.1787550621213; 
 Sun, 23 Aug 2026 22:50:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 39/96] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_lift_pseudo
Date: Mon, 24 Aug 2026 15:47:09 +1000
Message-ID: <20260824054806.2790041-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-7-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 47fae7316c..0be2f07612 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5358,21 +5358,22 @@ static GString *format_inst(size_t tab, rv_decode *dec)
 
 /* lift instruction to pseudo-instruction */
 
-static void decode_inst_lift_pseudo(rv_decode *dec)
+static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
+                                                     const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    const rv_comp_data *comp_data = opcode_data[dec->op].pseudo;
-    if (!comp_data) {
-        return;
-    }
-    while (comp_data->constraints) {
-        if (check_constraints(dec, comp_data->constraints)) {
-            dec->op = comp_data->op;
-            dec->codec = opcode_data[dec->op].codec;
-            return;
+    const rv_comp_data *comp_data = op->pseudo;
+    if (comp_data) {
+        while (comp_data->constraints) {
+            if (check_constraints(dec, comp_data->constraints)) {
+                dec->op = comp_data->op;
+                op = &dec->opcode_data[dec->op];
+                dec->codec = op->codec;
+                break;
+            }
+            comp_data++;
         }
-        comp_data++;
     }
+    return op;
 }
 
 /* decompress instruction */
@@ -5464,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
-    decode_inst_lift_pseudo(&dec);
+    op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec);
 }
 
-- 
2.54.0



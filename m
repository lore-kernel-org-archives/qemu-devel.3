Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F066C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbg-0005zf-Jy; Mon, 24 Aug 2026 01:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbI-00054M-Fv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbG-00031f-SN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cf452def93so28800495ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550721; x=1788155521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6cxpb598ZC5YQS9pQsz8M+jshSqMrf/FVzGuyNPyanY=;
 b=JJI/0GdX0e4+Z3dLyq/3TwfGUJL69jO9V4FhcrE18dS6oCBPdOZ5nm7KkRTf+RQ+pC
 RZRBN/OwVr7ufEjw3Y0JKWV3clSMqUed2JHscZ2VpH0lZpNypNyRxB8LKBTLiggZXy/h
 ljMSFiAuaJLqQ14ZGEX/+tCOvtJN4I8/utbVCAghQCl8RIgAxHT2bnDQ0P1GmUPRobVw
 9OhtF0C0eS8MAGzVztWLFLbUWcilAv91iRzZFIQGTd+EiW5Ffnj2xGBkctFWBm/dNz4g
 pwHXfL34MeB+XY8d9wyTsFDYQI4kEX3QFoIfXkUkmCVet/AjSfaxURu9ymzPbEN5SYlX
 5aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550721; x=1788155521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6cxpb598ZC5YQS9pQsz8M+jshSqMrf/FVzGuyNPyanY=;
 b=QeITLPJfhcyivD4ZnnChr+NQ71xC6KRDUwIry32zl+0aHOjVLcwJjOfbsPcDOG+h2V
 W95Uny0BEv5AiOpkvSo0ebXJxXn6efRP/xUyxYHXUfkTU8+g1duFiQADLol/OLHwdWGN
 4dmhSi588dT2XYpQ4+QCRkGcvakacTBKgemghIqBfK/C0bH0LPw4Etpm7waSo9dSwd3u
 lJdscHIUwF5PS57m4GA+Oj8UOdZqUsJttMgLaykSjyGijZgFsS1+gxEmJs3KhHc5LvFj
 YWcfOJIofmqiGibDimui3JgEfQw0O1rIj2oTbFnA6McSq90CIBYu9wqh2fpFk0VHscTI
 I/pg==
X-Gm-Message-State: AFuF++m19+aItW+OO51mm2rYjAXnRjG2qnvp0trFiDzJwS0pa20gdE9H
 5/rzRaMDvxn/TAcBTVWS5tD5JMk8gUlxd83m04fCksdQVPG2RzCOFUZ04UIQ+A==
X-Gm-Gg: AR+sD13kUrIIzEYr13Bi6uVKBEAYb+PpUT8q8GJcb7b9Ng6QM5vjSg+pxYmfZWMCrMG
 L8+vo+j0suZ9zpVB9xa8PJaqeG05d7rCUXq6yiASwXpXq1Zbt/gpb/EUuIgcYxObD/9kg+XLKyb
 hKZfoEPmpYw5y4eMBs+i5yoJoIJ/3PdJ5XYdGAvMcW0G3XHcPqn9opBZkbwwAkEOaxVIjHc7aXZ
 7zrJV5mjuIrNQUSXUTz7M/BO36aqmDjsRzQB7jIefoOIfQdNGqd6GjqpwWQFLbHkHVTIqPD1ZEy
 ASn2nHwjidIfu0fDiAsBmEJ11zCTD+xvgSc7S+ZeM0QJr30Ow7PqC3e+G6Zj4zmJ75a1/pB/3hd
 uKPg6UCAq9Mv3Tf0SIgqucUV6sCslvmA2Akb+WvNCLuyEmjS2B1KfrEavkPvoObmd8ROl1YLYoZ
 uonJL9pLuYMGEAb7n8i/lQZwIOEjP2qTR6Gpi4liQ8pKH6rYjkABSveBpdN7+HhqGoAYmCImwT6
 4bzQg==
X-Received: by 2002:a17:90b:5823:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395c4bde19amr22159625a91.2.1787550721491; 
 Sun, 23 Aug 2026 22:52:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 74/96] disas/riscv: Split ventana_opcode_data
Date: Mon, 24 Aug 2026 15:47:44 +1000
Message-ID: <20260824054806.2790041-75-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

Move the table to riscv-xventana-op.c.inc and massage
the lines into OP() form.  Drop vt.illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-42-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xventana.c        | 21 ++++++---------------
 disas/riscv-xventana-op.c.inc |  2 ++
 2 files changed, 8 insertions(+), 15 deletions(-)
 create mode 100644 disas/riscv-xventana-op.c.inc

diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index a4e59312d0..5d2e07865f 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -8,35 +8,26 @@
 #include "disas/riscv.h"
 #include "disas/riscv-xventana.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    ventana_op_vt_maskc = 1,
-    ventana_op_vt_maskcn = 2,
-} rv_ventana_op;
-
-static const rv_opcode_data ventana_opcode_data[] = {
-    { "vt.illegal", rv_codec_illegal, rv_fmt_none },
-    { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xventana-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
         switch (((inst >> 2) & 0b11111)) {
         case 30:
             switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
-            case 6: op = ventana_op_vt_maskc; break;
-            case 7: op = ventana_op_vt_maskcn; break;
+            case 6: return &op_vt_maskc;
+            case 7: return &op_vt_maskcn;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &ventana_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xventana-op.c.inc b/disas/riscv-xventana-op.c.inc
new file mode 100644
index 0000000000..0fe4666aee
--- /dev/null
+++ b/disas/riscv-xventana-op.c.inc
@@ -0,0 +1,2 @@
+OP(vt_maskc, "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(vt_maskcn, "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2)
-- 
2.54.0



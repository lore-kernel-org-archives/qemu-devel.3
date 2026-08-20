Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BACC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlE-0006Xj-GV; Wed, 19 Aug 2026 23:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlC-0006Wl-Pa
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:10 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlA-0004Mu-K5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1503804a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197687; x=1787802487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/WS1ThPg/b8x1LURw7MtOxUb9AQkwpijsnjQjcKpe2o=;
 b=tHodWPZToHtdkCe964Y7y2RzVWHKXVmzBiQ96LL/zb60mlvjJkqKqhV7TAOcbA6UKI
 2v50XKEbTgJ04gDZnBnnP6Je4BeMzQzLhTRLAtAWjCuVg4OAs8WWzq9WuJ+kXlcrGrFu
 JDV8XkJd9nQeq+LLG1USw0XrlxQQVBXE2WSv/mYDw3TG5HqU9kvSn7aWULzbnvcpdZg8
 hVccPfoNawVru+1jKjnd7Masefe3tA3IqRyeZ1VV49yKmqa9eNXyUbxUhHZ8yiueuzvh
 TUcYAxks9Y0mezVJYG6sAyj2vlcY00BoWmoPBRYtwBZIvreXWRvhYGr/OYCRsL6YeUUB
 C/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197687; x=1787802487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/WS1ThPg/b8x1LURw7MtOxUb9AQkwpijsnjQjcKpe2o=;
 b=SuSfe1QCJjgue5RzgSYooGJVMHYZtTHx2XdLdEYVv9gPe9t9VMF8/Z3Z4w8gzl0R9T
 YVzSbK8yRkAy6NNfVxtLVM9Hv5hv+iDGUfvI5HG1+YrMdvdWy8LOhLXp3wZV2+IapLGl
 S8qgmQQtZvjtxJvHJPipgHnlnkWSLqb7vhgrGHS+sTXG2xvnrI5+lJQ1I2ao2ChXr4XR
 kJzkCIOhPary8cuE0Fj92Sk82IFip72/XZVjJpB+j8+Esk15ILcU9QOo57yBnqssDCSY
 S9WzX/noGs7jM6Vr72E/OFKo1kYzfNPZgQmmm65OPyz/1U45iPWu40gJXbgHlbOQy0xs
 dwPw==
X-Gm-Message-State: AFuF++lx5aWdYO7Cx2Y+31mHZWFF3wqX+YMtvgIRUu6a2QGtOVOGNNRh
 hMB1WF5NsMPTf4BQi2MxYq8spIOBaPAgGHUgn7CjP44xvgvc83BTbNw26wYe4w==
X-Gm-Gg: AR+sD101iWZ25ElcaI3SfpzuPR21idU+1LRe/ax1oUU4ipEo6W1XUUc6WoMxDekpvLI
 SoPCTnndpXTlCHWu8ER1qWlxqdRGh9Y1siO4r2vER+8bAYJqQ+UbtuNAKAjI9tPoFypJinfgykP
 S5xVA4C+USBJ04iAZS25P10Nni0EuYZmK7Xd74hI/72U9HOfkw791ntz2AV/JvbSVZkC9eFdFp4
 ewBXMPCzjWPwxS4v+DmgZt1/FeFXsyVFzU4UINKfZ9So/t1mjEA0IK8stcDDeZ7C89Y0aDNz2l8
 lKVxXTx/pK/t8FNvpq7yoSyZbHguOAIAeyJpfSarr1BhQUkDWSIrOqrwoKYD414IsrdIoq4UB6z
 EDQ32S+YoXWz+cXI4K4ncXYIxUZMlzVTZ3e7Uj79VnkaYiIjoGwoNFx84C8yi7RB0s0W4wbFwos
 LeI9jneyG/PM76uGTPOwqABrrNTRjcYi5uVuyAccECIrD+hbKdKpk8jdQS1USy+1/3+uwfxR92v
 wDpAA==
X-Received: by 2002:a17:90b:258b:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-395810e9837mr18953010a91.14.1787197687177; 
 Wed, 19 Aug 2026 20:48:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 71/93] disas/riscv: Return rv_opcode_data pointer from decoders
Date: Thu, 20 Aug 2026 13:44:08 +1000
Message-ID: <20260820034430.1186695-72-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

Rather than putting array + index into rv_decode,
return the pointer to the object directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-36-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xlrbr.h    |  2 +-
 disas/riscv-xthead.h   | 22 ++++++++---------
 disas/riscv-xventana.h |  2 +-
 disas/riscv.h          |  2 --
 disas/riscv-xlrbr.c    |  5 ++--
 disas/riscv-xthead.c   | 55 +++++++++++++++++-------------------------
 disas/riscv-xventana.c |  5 ++--
 disas/riscv.c          | 23 +++++++-----------
 8 files changed, 48 insertions(+), 68 deletions(-)

diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
index ebf3d4c133..da14f1b340 100644
--- a/disas/riscv-xlrbr.h
+++ b/disas/riscv-xlrbr.h
@@ -12,6 +12,6 @@
 
 #include "disas/riscv.h"
 
-void decode_xlrbr(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xlrbr(rv_decode *, rv_isa);
 
 #endif /* DISAS_RISCV_XLRBR_H */
diff --git a/disas/riscv-xthead.h b/disas/riscv-xthead.h
index 0c65c8e0af..f2160be8a4 100644
--- a/disas/riscv-xthead.h
+++ b/disas/riscv-xthead.h
@@ -11,16 +11,16 @@
 
 #include "disas/riscv.h"
 
-void decode_xtheadba(rv_decode *, rv_isa);
-void decode_xtheadbb(rv_decode *, rv_isa);
-void decode_xtheadbs(rv_decode *, rv_isa);
-void decode_xtheadcmo(rv_decode *, rv_isa);
-void decode_xtheadcondmov(rv_decode *, rv_isa);
-void decode_xtheadfmemidx(rv_decode *, rv_isa);
-void decode_xtheadfmv(rv_decode *, rv_isa);
-void decode_xtheadmac(rv_decode *, rv_isa);
-void decode_xtheadmemidx(rv_decode *, rv_isa);
-void decode_xtheadmempair(rv_decode *, rv_isa);
-void decode_xtheadsync(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadba(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadbb(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadbs(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadcmo(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadcondmov(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadfmemidx(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadfmv(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadmac(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadmemidx(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadmempair(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadsync(rv_decode *, rv_isa);
 
 #endif /* DISAS_RISCV_XTHEAD_H */
diff --git a/disas/riscv-xventana.h b/disas/riscv-xventana.h
index 1006c3be00..d28e84c7e4 100644
--- a/disas/riscv-xventana.h
+++ b/disas/riscv-xventana.h
@@ -11,6 +11,6 @@
 
 #include "disas/riscv.h"
 
-void decode_xventanacondops(rv_decode*, rv_isa);
+const rv_opcode_data *decode_xventanacondops(rv_decode*, rv_isa);
 
 #endif /* DISAS_RISCV_XVENTANA_H */
diff --git a/disas/riscv.h b/disas/riscv.h
index ab62c0db94..241dd47d7f 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -182,10 +182,8 @@ typedef struct {
     const RISCVCPUConfig *cfg;
     uint64_t  pc;
     uint64_t  inst;
-    const rv_opcode_data *opcode_data;
     int32_t   imm;
     int32_t   imm1;
-    uint16_t  op;
     uint8_t   rd;
     uint8_t   rs1;
     uint8_t   rs2;
diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
index d0092e9edd..b12916c9da 100644
--- a/disas/riscv-xlrbr.c
+++ b/disas/riscv-xlrbr.c
@@ -36,7 +36,7 @@ static const rv_opcode_data xlrbr_opcode_data[] = {
     { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1 },
 };
 
-void decode_xlrbr(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -76,6 +76,5 @@ void decode_xlrbr(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xlrbr_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xlrbr_opcode_data[op];
 }
diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 757d6ff39f..428a6380e9 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -246,7 +246,7 @@ static const rv_opcode_data xthead_opcode_data[] = {
     { "th.sync.s", rv_codec_none, rv_fmt_none },
 };
 
-void decode_xtheadba(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadba(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -272,11 +272,10 @@ void decode_xtheadba(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadbb(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadbb(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -331,11 +330,10 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadbs(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadbs(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -358,11 +356,10 @@ void decode_xtheadbs(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadcmo(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -437,11 +434,10 @@ void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -465,11 +461,10 @@ void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -503,11 +498,10 @@ void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadfmv(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -539,11 +533,10 @@ void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadmac(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadmac(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -571,11 +564,10 @@ void decode_xtheadmac(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -646,11 +638,10 @@ void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadmempair(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -681,11 +672,10 @@ void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadsync(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadsync(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -716,6 +706,5 @@ void decode_xtheadsync(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index 4fb9a29d0b..a4e59312d0 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -20,7 +20,7 @@ static const rv_opcode_data ventana_opcode_data[] = {
     { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
 };
 
-void decode_xventanacondops(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -38,6 +38,5 @@ void decode_xventanacondops(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = ventana_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &ventana_opcode_data[op];
 }
diff --git a/disas/riscv.c b/disas/riscv.c
index 9d05e86c09..bc86cb866a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2846,7 +2846,7 @@ static const char *csr_name(int csrno)
 
 /* decode opcode */
 
-static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
+static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -4541,8 +4541,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = rvi_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &rvi_opcode_data[op];
 }
 
 /* decode operands */
@@ -5291,14 +5290,12 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         .inst = inst,
         .cfg = cfg,
     };
-    const rv_opcode_data *op;
+    const rv_opcode_data *op = decode_inst_opcode(&dec, isa);
 
-    decode_inst_opcode(&dec, isa);
-
-    if (dec.op == rv_op_illegal && cfg) {
+    if (!op && cfg) {
         static const struct {
             bool (*guard_func)(const RISCVCPUConfig *);
-            void (*decode_func)(rv_decode *, rv_isa);
+            const rv_opcode_data *(*decode_func)(rv_decode *, rv_isa);
         } decoders[] = {
             { has_xtheadba_p, decode_xtheadba },
             { has_xtheadbb_p, decode_xtheadbb },
@@ -5317,19 +5314,17 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
             if (decoders[i].guard_func(cfg)) {
-                decoders[i].decode_func(&dec, isa);
-                if (dec.op != rv_op_illegal) {
+                op = decoders[i].decode_func(&dec, isa);
+                if (op) {
                     break;
                 }
             }
         }
     }
-
-    if (dec.op == rv_op_illegal) {
-        dec.opcode_data = rvi_opcode_data;
+    if (!op) {
+        op = &rvi_opcode_data[rv_op_illegal];
     }
 
-    op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec, op);
-- 
2.54.0



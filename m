Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2266C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbL-00057L-0w; Mon, 24 Aug 2026 01:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNb8-0004pq-4U
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNb3-0002t1-HE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:53 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3590164a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550704; x=1788155504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/WS1ThPg/b8x1LURw7MtOxUb9AQkwpijsnjQjcKpe2o=;
 b=DnVkpXJ/xHBlQuEfPTkgWzd3+0A/kAWm7cnHXN7RBSmJOMLXx4jLxndbnSLx2B5g0y
 lmUc9MB012KZGQVHJ7RXvIVBNa3+kWNMN+kkIt+3bzlcih6Kc2r7/WfeV0qWDufpcTFn
 2MEQfoi9JoBp+QajTVHvSvWQGT09fa6YuJCz2X4H6PRhdcLJCtnffMxGdTsvrtDcWDlX
 hxJ4MUvNSNzoQ8gfLA/SQZ8WcO+i+HEhIosOWtWH+nKzsJgDZDCWH1o+r0xW0WTtGHXT
 eaNUagFrPSfTqjHNHASeYcwfzKB7aVM5umB3eGmuCuOdIa0bvP2CnTyWV2RMswhYGKct
 VMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550704; x=1788155504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/WS1ThPg/b8x1LURw7MtOxUb9AQkwpijsnjQjcKpe2o=;
 b=lXtFHeKYJbKbTpp/l6A3aqS7waCy+pEkhSf835EmEZa+i/n4dCh5TDJSW+XT1m4Hhk
 eBpxZiIJZch7TxJVlK+bIylyKTcAHwUHOxcakZje3cXR1OHqInCVVOGf1Mcd2Lnxsq7C
 RYXAFOeJ1q3i8owUHlLLaUAQ9usVssIzqZhHRXtj6kguAObKso7xQqhLZq/N0+JUGLyP
 UOyB+KgBPjm8nkbZa4BD52XJ2Y3m0A4IQ3Ayiy7cjnyMQWajjE4qNwvK4qxuTR+AOesC
 L6BVdgNgyaO9en6wTtTvI463IC8UUHNZZRQHRdX5CffA1NsREjVQJa9tsSo9pQtbnrN4
 vzOA==
X-Gm-Message-State: AFuF++lY4r2d54iBgNRMpkLiBD6FtvrSomA+VzqSE5A+4f3uEg4Y/l5O
 sH/j9Lw8BKR06Q1hwSwlb5YxJMyjTC7AFzOaq4T71j8Hmeqx3dm4bAF2eV/AoQ==
X-Gm-Gg: AR+sD122sVwk1y1BKnJsEQm7HEhQlfe5a/kQk8p8vpNc0EE5Emh2ZbahlRtg0ueiO0x
 sWGsu9wKbCG53RcoFoeX+tZhCzi4HACsM5OFqyEWEeznCeT+QZtshCeeypeMboAiCNVRSu2H7cd
 K0PQb7vuIijUPZiVUpdYyNLOE9eUt0iaTcL98/JbrfkIkxjKbF88HN+bkmC+pE5DrfchBJuaHQn
 TRmSKeKjPQ6nLw/sncUIC9SoPHlc+k/4fHCZ4t4JZb3Z4/PuVBSH0p9Q1QNhz0r10xc5oi7tsdV
 TgWj69OLpoACzPkJNz9R2tkAFLCj6KrmS3JYvBJno2DNxLrZsvbzkr0u9znocaWM3E6YAOMhexN
 pk4uq1D/C9LrNZ8XMJ9mQQZAEwCKjZRo3UVYiOipKAVoZWWu9z/NTW+ErcjJLJvrwPVjdLkLylo
 WuqU673H6IRKKpJ+DfEETrS04ckrRnZCmiOGecviFf+x+d8cHJt/lvbHeJ23CJJl1Cwt7cJRgbZ
 Qrx6kDDIplkFq7L
X-Received: by 2002:a17:90b:4b02:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395df2595femr25850835a91.10.1787550703861; 
 Sun, 23 Aug 2026 22:51:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 68/96] disas/riscv: Return rv_opcode_data pointer from
 decoders
Date: Mon, 24 Aug 2026 15:47:38 +1000
Message-ID: <20260824054806.2790041-69-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
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



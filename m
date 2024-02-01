Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0414AC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUOH-0003iq-1d; Thu, 01 Feb 2024 05:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUOF-0003iZ-Vp
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:51 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUOA-0004qK-TW
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:51 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-363890b20dfso2893795ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706783625; x=1707388425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTuHT8nGre4SRDBRGT6LudOskfwJpEk8HMeGg8Vl3lo=;
 b=jqDpieGHg4u4ttRd5fygZ4had6RhSr1cJbxB9SpSImrnOJL1/9V1vjnOjorNofi78w
 DSqJZXh2DhM6X1Ig5NTXV+RMWDT7LEU3JVWd+cbRoM27fDzbQ1Yf2KQlzsmPhnJkxVVK
 oI/MFvN+v8++d93+M2tHdeB71bGV9bRzfkPhd+hiw58PZLR9T5jAjjoTjZsyE8z0BsxQ
 Tkec+cITaLHDrDbHBdDJqHTwDhacLskQgekf0RLZrXGgm58ha4dCfUP1IprEIde6vSdx
 Hq96I6wAHDw3nrAyBpc9Qh6QQUgyDZiRM8WahtSmBwSuSLDaHbxnOtkdhNtajhqx/e0n
 KCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783625; x=1707388425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTuHT8nGre4SRDBRGT6LudOskfwJpEk8HMeGg8Vl3lo=;
 b=qn+Y1EOtltCEroFWrLqPaf7oYCIZjt1YXwnTIvnJ2QuEhXGAzbpclYUq8UFUd5KjV1
 mEbLJ4ymS0+GT5AlB3rUJVXyQX85xmWPbOazX/8R6QZ+t07XY9zi1ZJmjUsuCYaBr1fg
 qVKDKpMOHfI1gzRw2vazUtk6Sa3pSPDcznF2kKQxsX/IjQ4yKxzDXR0xcxu8wP+R8LEe
 ZbWQ06POfSwU/u0wenfsu6495rtSswKKTvbfQ+E+iEfKOfwHMm6FZFjkiA2nm3+hDnB8
 03R9JawK5cB3N9ubURQ5nJwrhpBk8ADgy41AnzETEBPzvRYSiCeBiaSU+tGyD+jqPBwv
 3REg==
X-Gm-Message-State: AOJu0Yy2FOHpT87Qse5zMUh8FCvikxqiZz2np2zmUbDFD2TOoFnMWomX
 XTTmV9VWlZEJauobanU5SnI/B+upIwpwQ3BBT7I3UJmTVRterK5SVpqr3tRjodo=
X-Google-Smtp-Source: AGHT+IFnfjPPshBYl1m+ZOlvilNoqzPoAwlPPGzLZTX1s5isTwb0g+S1pB1gIO1SSNQkOlbyrzHzVQ==
X-Received: by 2002:a05:6e02:4a8:b0:363:9cd7:5b51 with SMTP id
 e8-20020a056e0204a800b003639cd75b51mr3354979ils.2.1706783624941; 
 Thu, 01 Feb 2024 02:33:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX5+bUQRIXkMBKz0l8WDQ3AL3Eg3ffNZEDQuJnV9KbICWotZoRr8fVZq1N8oi34Mx0t0DZUYiJeQ4tOliqYCQAXp1EgfRJ+HvFsD677W5OPL2wMSQaL1qocgj8kewYAfbUohk2pMFcVLIJAPApamQYPZvGVTQtrn4njcd6L6CtVt6dh4mjiqle9K7PPURydzkrcAUGHsmWiIE4eXHzREPytm/d2PwlUA85owEbJ1Ua83+lvparUiJwX6xk/ihcQRusryMl6EU3NqA8x+4DRVmwN79Ib5mXF1W2ecwZm
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a92c003000000b00361b6a1e6aasm3152089ild.87.2024.02.01.02.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:33:43 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 2/3] Hexagon (target/hexagon) Enable more short-circuit
 packets (scalar core)
Date: Thu,  1 Feb 2024 03:33:39 -0700
Message-Id: <20240201103340.119081-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
References: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Look for read-after-write instead of overlap of reads and writes

Here is an example with overalp but no read-after-write:
0x000200fc:  0x38103876	{	R0 = add(R0,R1); R6 = add(R6,R7) }

BEFORE:
 ---- 00000000000200fc
 mov_i32 loc2,$0x0
 mov_i32 loc2,r0
 add_i32 loc3,loc2,r1
 mov_i32 loc2,loc3
 mov_i32 loc4,$0x0
 mov_i32 loc4,r6
 add_i32 loc5,loc4,r7
 mov_i32 loc4,loc5
 mov_i32 r0,loc2
 mov_i32 r6,loc4

AFTER:
 ---- 00000000000200fc
 add_i32 loc2,r0,r1
 mov_i32 r0,loc2
 add_i32 loc3,r6,r7
 mov_i32 r6,loc3

We can also short-circuit packets with .new values by reading from the
real destination instead of the temporary.
0x00020100:  0x78005ff3	{	R19 = #0xff
0x00020104:  0x2002e204		if (cmp.eq(N19.new,R2)) jump:t PC+8 }

BEFORE:
 ---- 0000000000020100
 mov_i32 pc,$0x20108
 mov_i32 loc8,$0x0
 mov_i32 loc8,$0xff
 setcond_i32 loc10,loc8,r2,eq
 mov_i32 loc6,loc10
 mov_i32 r19,loc8
 add_i32 pkt_cnt,pkt_cnt,$0x2
 add_i32 insn_cnt,insn_cnt,$0x4
 brcond_i32 loc6,$0x0,eq,$L1
 goto_tb $0x0
 mov_i32 pc,$0x20108
 exit_tb $0x7fbb54000040
 set_label $L1
 goto_tb $0x1
 exit_tb $0x7fbb54000041
 set_label $L0
 exit_tb $0x7fbb54000043

AFTER:
 ---- 0000000000020100
 mov_i32 pc,$0x20108
 mov_i32 r19,$0xff
 setcond_i32 loc7,r19,r2,eq
 mov_i32 loc4,loc7
 add_i32 pkt_cnt,pkt_cnt,$0x2
 add_i32 insn_cnt,insn_cnt,$0x4
 brcond_i32 loc4,$0x0,eq,$L1
 goto_tb $0x0
 mov_i32 pc,$0x20108
 exit_tb $0x7f9764000040
 set_label $L1
 goto_tb $0x1
 exit_tb $0x7f9764000041
 set_label $L0
 exit_tb $0x7f9764000043

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 13 +++++++------
 target/hexagon/translate.c | 21 ++++-----------------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index f06d71fc53..d5e7f49ad8 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -38,12 +38,10 @@ typedef struct DisasContext {
     int reg_log[REG_WRITES_MAX];
     int reg_log_idx;
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
-    DECLARE_BITMAP(regs_read, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
     DECLARE_BITMAP(pregs_written, NUM_PREGS);
-    DECLARE_BITMAP(pregs_read, NUM_PREGS);
     uint8_t store_width[STORES_MAX];
     bool s1_store_processed;
     int future_vregs_idx;
@@ -68,6 +66,7 @@ typedef struct DisasContext {
     bool is_tight_loop;
     bool short_circuit;
     bool has_hvx_helper;
+    bool read_after_write;
     TCGv new_value[TOTAL_PER_THREAD_REGS];
     TCGv new_pred_value[NUM_PREGS];
     TCGv pred_written;
@@ -88,13 +87,14 @@ static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
 
 static inline void ctx_log_pred_read(DisasContext *ctx, int pnum)
 {
-    set_bit(pnum, ctx->pregs_read);
+    if (test_bit(pnum, ctx->pregs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
 static inline void ctx_log_pred_read_new(DisasContext *ctx, int pnum)
 {
     g_assert(test_bit(pnum, ctx->pregs_written));
-    set_bit(pnum, ctx->pregs_read);
 }
 
 static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
@@ -125,13 +125,14 @@ static inline void ctx_log_reg_write_pair(DisasContext *ctx, int rnum,
 
 static inline void ctx_log_reg_read(DisasContext *ctx, int rnum)
 {
-    set_bit(rnum, ctx->regs_read);
+    if (test_bit(rnum, ctx->regs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
 static inline void ctx_log_reg_read_new(DisasContext *ctx, int rnum)
 {
     g_assert(test_bit(rnum, ctx->regs_written));
-    set_bit(rnum, ctx->regs_read);
 }
 
 static inline void ctx_log_reg_read_pair(DisasContext *ctx, int rnum)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 95579ae243..751ca71790 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -394,20 +394,8 @@ static bool need_commit(DisasContext *ctx)
         }
     }
 
-    /* Check for overlap between register reads and writes */
-    for (int i = 0; i < ctx->reg_log_idx; i++) {
-        int rnum = ctx->reg_log[i];
-        if (test_bit(rnum, ctx->regs_read)) {
-            return true;
-        }
-    }
-
-    /* Check for overlap between predicate reads and writes */
-    for (int i = 0; i < ctx->preg_log_idx; i++) {
-        int pnum = ctx->preg_log[i];
-        if (test_bit(pnum, ctx->pregs_read)) {
-            return true;
-        }
+    if (ctx->read_after_write) {
+        return true;
     }
 
     /* Check for overlap between HVX reads and writes */
@@ -466,6 +454,7 @@ static void analyze_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
     ctx->has_hvx_helper = false;
+    ctx->read_after_write = false;
     for (int i = 0; i < pkt->num_insns; i++) {
         Insn *insn = &pkt->insn[i];
         ctx->insn = insn;
@@ -490,11 +479,9 @@ static void gen_start_packet(DisasContext *ctx)
     ctx->next_PC = next_PC;
     ctx->reg_log_idx = 0;
     bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
-    bitmap_zero(ctx->regs_read, TOTAL_PER_THREAD_REGS);
     bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
     ctx->preg_log_idx = 0;
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
-    bitmap_zero(ctx->pregs_read, NUM_PREGS);
     ctx->future_vregs_idx = 0;
     ctx->tmp_vregs_idx = 0;
     ctx->vreg_log_idx = 0;
-- 
2.34.1



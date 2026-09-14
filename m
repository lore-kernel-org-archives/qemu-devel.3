Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFACC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZc-0003sa-7E; Mon, 14 Sep 2026 17:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZZ-0003sG-Iy
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:45 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZY-00019H-05
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:45 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4bf948737e1so1934602b6e.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422643; x=1790027443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q9I2gXZP1++Dyfy9s2C51+2Zm93jbhIJWJtLFNa8axY=;
 b=CcNT93/HG/SHoO96nbElhkTrBPNeL9MIs1RKMlzEfUsX+HMwLPAS/3K9jtCV8Dd15f
 V0BDzNsGFcqJBS0RMo08g1Cw3+XvxdDPlqljCKIpupCH205M3wAoP7KAeTSMZdN3BAvH
 fpCljNC7zOH4MsY9J8vivxoYm66VOlnQcdRK/WVr7uURRrQDIuSD4mByQYCX9PbiBzoO
 41vjuQcLg1+mHLYgHd/CQNKJoK/OVr9j4F+USabs1KlgQS4qfuuz5ERW7Z0q0h8h0VPv
 CuH8OjSVkNkLMFtbpXuSTAFBkP638zlnkHJWfwteZ/cAx0QCDA5k1PLBjrVrrLhmUeKs
 PAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422643; x=1790027443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q9I2gXZP1++Dyfy9s2C51+2Zm93jbhIJWJtLFNa8axY=;
 b=P2HuNRMHEkxgj3HaLLhljZc8ZgMVCbKe8mhCGTrYyLTXl+7+4TJoLkQEeP4ycrwpuk
 fUfJP012e6gUbmSTZXJ89vQcFqZP23EZzUTUg0xlzCT4ixWOzJ1SRFidmGPf+TpQhRNI
 6ubAM/fHeLmZAltX1chSGiU0AlBYs/1ooSr6n5ztJkpoELvaxQzjmEXmFNopT9CGKVxi
 Vr5g0Cpinp2ohCDHKFEMK7sJBiysJ+/T/2o6LvauosPACYFDcmLEbMZXDn9np3aUcugX
 MjNQ2GHRdAMA9imPZenYPli6pV8UOcMuG0EqRDWQGt6KavBXIIDR1cOwF0+JrZMihFf1
 wVaw==
X-Gm-Message-State: AFuF++kDr1af6CjEj2ASQ4e+MUdqI73/TKLwTZGHrSvhNjQT//kWtE+N
 FFS3Jl0wggDAe2632z7JBiwiTj/SzzfcQrIFx8Aw6FHZf6qwQ4fI3oKOwNXAKx8S
X-Gm-Gg: AYBFou3YMpGgzxM57bimnxsGYsin/ynLgM/0h22PmK0PAF9d148H4pqi0gF5uNMm90s
 WvPOmeGfy3T37IJ69X0KrUNBmLJUfFKffECAMRtRcRSE/vRC7GLMxlL4ZpZXDlOv55/FwVTypEX
 OEyRu7Jcfn1wv6PV9SvhHY/ZVRN/94r4qLDBuUDsjiOr2AjK/147oG7hcjLGfzMRY+g1mOG6yvZ
 MaHvT2pJjVcfBmhyxhrsIsfc+yyEdb+17SKsgzLnr8eoaG1kIu0XaCepXnF64FjhqNIwRGdB1HM
 pwyy1Xs3N6Bk4q+bSYQIHkloFyPuAM8Setwaxj2ZoUvXCPwavLBB/sYEo3fvNPjlmi+qUp1CbW/
 tJxeVN40TJIk1fhkMZsf1lFa84Et49lLapPLVS43Sd4wyTyh6NJSqaUQPFBNIEjMrVXCDFwo/WE
 ujA3SOg6iCCT0j/kbWm5eST5TvFCp8zt1P8BRV4IECXhsCMGKB7qBwGQ7Mcrl48XZdcjWr8Mhr8
 8bexGSwqPm4XQY2a6e4hNKKIKQLsnLLAKQEC3zxBgdrRRrYRbq3sd0LIiiMlbGt
X-Received: by 2002:a05:6808:528e:b0:4c2:a362:13b2 with SMTP id
 5614622812f47-4c7b665e156mr4907533b6e.21.1789422642878; 
 Mon, 14 Sep 2026 14:50:42 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:42 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 01/10] Hexagon (target/hexagon) Move code out of
 gen_start_packet
Date: Mon, 14 Sep 2026 15:50:27 -0600
Message-ID: <20260914215037.157879-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move clear_pkt_ctx and analyze_packet out of gen_start_packet
Precursor to adding packet validity checks to analyze_packet

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.c | 45 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 5d3d67e5d3..52dd1f0266 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -562,28 +562,13 @@ static void mark_implicit_writes(DisasContext *ctx)
     mark_implicit_pred_writes(ctx);
 }
 
-static void analyze_packet(DisasContext *ctx)
-{
-    ctx->read_after_write = false;
-    ctx->has_hvx_overlap = false;
-    for (int i = 0; i < ctx->pkt.num_insns; i++) {
-        Insn *insn = &ctx->pkt.insn[i];
-        ctx->insn = insn;
-        if (opcode_analyze[insn->opcode]) {
-            opcode_analyze[insn->opcode](ctx);
-        }
-    }
-
-    ctx->need_commit = need_commit(ctx);
-}
-
-static void gen_start_packet(DisasContext *ctx)
+/* Clear out the disassembly context */
+static void clear_pkt_ctx(DisasContext *ctx)
 {
     Packet *pkt = &ctx->pkt;
     target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
     int i;
 
-    /* Clear out the disassembly context */
     ctx->next_PC = next_PC;
     ctx->reg_log_idx = 0;
     bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
@@ -616,8 +601,26 @@ static void gen_start_packet(DisasContext *ctx)
     for (i = 0; i < NUM_PREGS; i++) {
         ctx->new_pred_value[i] = NULL;
     }
+}
 
-    analyze_packet(ctx);
+static void analyze_packet(DisasContext *ctx)
+{
+    ctx->read_after_write = false;
+    ctx->has_hvx_overlap = false;
+    for (int i = 0; i < ctx->pkt.num_insns; i++) {
+        Insn *insn = &ctx->pkt.insn[i];
+        ctx->insn = insn;
+        if (opcode_analyze[insn->opcode]) {
+            opcode_analyze[insn->opcode](ctx);
+        }
+    }
+
+    ctx->need_commit = need_commit(ctx);
+}
+
+static void gen_start_packet(DisasContext *ctx)
+{
+    int i;
 
     /*
      * pregs_written is used both in the analyze phase as well as the code
@@ -659,7 +662,7 @@ static void gen_start_packet(DisasContext *ctx)
     ctx->pkt_ends_tb = pkt_ends_tb(&ctx->pkt);
     ctx->need_next_pc = need_next_PC(ctx);
     if (ctx->need_next_pc) {
-        tcg_gen_movi_tl(hex_next_PC, next_PC);
+        tcg_gen_movi_tl(hex_next_PC, ctx->next_PC);
     }
 
     /* Preload the predicated registers into get_result_gpr(ctx, i) */
@@ -1199,6 +1202,10 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
     words_read = decode_packet(ctx, nwords, words, &ctx->pkt, false);
     if (words_read > 0) {
         ctx->pkt.pc = ctx->base.pc_next;
+
+        clear_pkt_ctx(ctx);
+        analyze_packet(ctx);
+
         if (ctx->pkt.pkt_has_write_conflict) {
             gen_exception_decode_fail(ctx, words_read,
                                       HEX_CAUSE_REG_WRITE_CONFLICT);
-- 
2.43.0



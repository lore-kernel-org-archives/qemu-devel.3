Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDCCC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59Q9-00035e-7y; Fri, 11 Sep 2026 18:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q8-00035S-7e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:32 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q6-0002GC-OC
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:31 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6f1635so39215eaf.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164509; x=1789769309; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cbKC5Q3V9Z1CtGwVDb9xOEbdoQRexHod/M4ELvXdfDM=;
 b=PzgN1kSGBkYB4tsQmL4BYL0LMxDAcmoez8DrzqPYPR38Gsk0oRCe/chjRc4Vgf5nOI
 IeD4Z9hJERGCtQRJYna96b8/yopxY9Tf79uv9g9eHeW7mODTvZi6Kc7lYZHr8630Q+/k
 DzZs61gV7Yz5AxB+1x2n/wp/vX6jDf2c1x5ouiYxHJ01AMOhR94qgj8IgEeJNiPBn/Xx
 G7bF7aLks5zUBE3xlO+2xMbFDzgJeikEL7VcJbTc2mgAW2IPKA7x1ZzdC35kOCQf5xNl
 2S/lGpONhNUsO6AV32eHK4vr8ASNx7ZFG3fp6IEpdKRCHlGI3kCYVxHZBzJu5RjrtFLd
 7rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164509; x=1789769309;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cbKC5Q3V9Z1CtGwVDb9xOEbdoQRexHod/M4ELvXdfDM=;
 b=Va1+4bve3LUDjNUksPClkAuUx7ANVEla86EDLBJuJUf/6ruifCQJTIHw7on/Kt4Bv1
 P9O4PunP3g0p7xftH5qIYMOP7YbRZ4YubL9K1szL1SklHJTWh2ugn7Eo8OtuRQLDu4o2
 FlKDCnWIQouzrxT/ii5sOypg4zSCfI1PRlgKppFf1caokSdP9asTAV6WTA6NZJ5NtyRQ
 PdD5Qp3pkUDHhBXN245fo5blswmERS1rQfTUpDuynkttnENfhc9Aczuhl2ek7ZOUcAKK
 Gq7ghjfBV61FYuLJxwuF8IFGk5VRN86Ygyj6HlTBRO3Gm8FFxZ5S1UMUJkz/5SsV0zO3
 ZOHw==
X-Gm-Message-State: AFuF++lYT2iPp/agNIVrgL3ElMRfl/bT1pJpcAymWJyhweGNQkUrtTrV
 mvzHKbcSpD8A3LbcCRMUtu/22+kiIYaGlM9L3Mub0fYuYh76ssCul5IKmao+D2qg
X-Gm-Gg: AYBFou2Xd3hILD+RfAuOUpopNyGZ26G8m8wTKRIfueblGVBxcf4yG29jEUoMxeeSwEo
 itwiIO1pX0uhZoo2MnDUCT0dLY6fdHf3kUUu6cow5Mlzxd0qTdu2VtCJxa7XR8DgS2gmzIB5csZ
 7aPoAgdXnlY+JU1qRqU+uvone4+uvedTXnFWklbsL0kZDAiaYTP/7jEY5iZ2zibUeq2uqHS5Fl/
 geqX+PX82G4Mmi3xnTGeiE8v2nUPEFZ1EMw30MTTyUAQPzoDz+96VHMN8MN3nU88UGJiV57BAbo
 o7OeeNbpfgd9CMEp/jQTtT1mOfrC3XiU3S2aCGSaCYzLAKHvSBIjGkWlin+x43oNXybfMTv16AK
 kN35wRrKJtmAmSXcD4qcuU/Gvm069LpC0TsOcaV/FsaGT9vcSL90i1KGcPmTH4aplBPLC7az8JD
 Cc7ffAisu/u+OIMCX3xW3+OPI2u1TunXrXp0XM483HeFVOrq6yWZhXmT54Sme2YcHdUn0KTSuar
 AcIJOE/kIEQBCuh/JXq7RWyeFYPXDczACbXf5RlLuBpYfwQkeimum4s4d7hA+OD
X-Received: by 2002:a05:6820:2d04:b0:6c1:f832:9b6a with SMTP id
 006d021491bc7-6c24e671d43mr288826eaf.33.1789164509123; 
 Fri, 11 Sep 2026 15:08:29 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:28 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 01/10] Hexagon (target/hexagon) Move code out of
 gen_start_packet
Date: Fri, 11 Sep 2026 16:08:16 -0600
Message-ID: <20260911220825.143115-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo2-x0d.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D63EEC1130
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyx-0006cF-D9; Mon, 23 Feb 2026 15:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyv-0006bE-Ac
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:41 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyt-00081c-7D
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso4720277a34.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880198; x=1772484998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EmF9OpunbnhRanJDS843zSLdQ1syEQoQBF13qfTD/g=;
 b=XPxtfr28r97zDbxqE4R/rGns41Oz4CHkJjkz9Oni6S4/wvFQXWLiIITE79L9PTAobq
 y2v76ACFhCBNeEeEJtHie85x+ndl0U+R7BeteO2CKzKKh1ijSulC6dBjseY0O+44iAKS
 YVBLOl/nETuPEkiQEyo/ISOCV4Icl1FgK2KFeDr0k4rwOwmIZccObmGCD4OjKqAz80q7
 cVkEjMQg2Wce5S+H4dKbm1gYfebPnDkDqZE/8K1sMBeze/H8eOlwpkBM5Mvq7YxsOvVz
 0bx4ivt3YAhk+NTFTE9S409/pCPmKtfZ/UkHqP1gQhyTBHKhqu/xY+e/8YrWO6TZqdr1
 uh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880198; x=1772484998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1EmF9OpunbnhRanJDS843zSLdQ1syEQoQBF13qfTD/g=;
 b=ogfwxNz6CHNQG3VLVKtuGJNml7L3EXARCMFaH1cV1+NganlnruxaCOWk7ym+F64CNz
 VPqBsoMEC1LiGAXBa705FYQsZpRqE8P2s+J/AGGGCTKBQiUOw/JXReLhqDfCxZMm5LmE
 omSnTv03IZ7d/QqjhZrtQ6kbQRX1UN8t5SDquF5UnqztXDeyJxdoR5DiuHhQ1gMSB202
 ovM4scpJwaWCq9muBLY/i2oO4SFS4bne3vg34D6icvdCPLEGrIx8Qf2C83VSR2CV96mv
 ArzX9Yjk53iW6G5nKhUd4LExr5Qbp1ucE1VZXduRwVjzyO1LJH6aW9jf3R7AFAy4qR5u
 X3Aw==
X-Gm-Message-State: AOJu0YxMlVNdWsPILfCeWUPgDN1vBWH9bKMmEv2tC7CF1iwawa2bAeVx
 uq/G9w5+LSBo8tHqpZBno23Ny4auuM85RZJXSa7CGF377zonw1eMPDH8ncFn1gxS
X-Gm-Gg: AZuq6aJFta42aQ9ma4aDUL7lpMwu58Pq0PdqQ+rT0DLE5Su576Sssv+6+VMpbQc+Cui
 jnd5UlUJiJIxyF6lTtbwE8A6pPPX/8xIylLRClRJtfNI4oVhKRezPSRdWHHJz4YscsKhvziuXvY
 1LiJeBHya7nrw5CO74x/9cLj54LsgxsxOQOefAnLFX0uQjx2eruVTZgmlo2Sf6gDP1JbUVqThT+
 frVR0qsyEgPaTvyqa+D+SYl4MdJQ19kWApDBDJlDe+Zx+QqvbkaSZYT3eR6deMfl3424loofq8b
 KLQjFkxO2Z0qs5uX7uOYnAFhJxrwBRHSbk+9hhh0atEerqvfgYpzgjTedFkdV32xxkT7jiLNouU
 7C5L3oB111wdqDJ2o0jFeRNqO2bjgFswIYQ1V0fOzhSlZiopxG7XLIh6Lvpc/H0tNXpxQoQxLeX
 SjgcMUOlNpRrChSKSHO2ZmG4oCVXK/ouoXEBTWxsIZ73MkrMShWoZBwFMcBSsEila8CbCLTxkKR
 Ll6SgI71/r+9GqCAMB5vSja28bvnM2c2Wsa6Q==
X-Received: by 2002:a05:6830:388d:b0:7c7:1e8a:c9d8 with SMTP id
 46e09a7af769-7d52bf7d4d0mr6371102a34.36.1771880197933; 
 Mon, 23 Feb 2026 12:56:37 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:37 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 4/8] Hexagon (target/hexagon) Check for vreg multiwrite in
 analyze_packet
Date: Mon, 23 Feb 2026 13:56:28 -0700
Message-ID: <20260223205632.223714-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 12 +++++++++++-
 target/hexagon/translate.c |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 54276fb9d0..4ef9357aad 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -60,6 +60,8 @@ typedef struct DisasContext {
     DECLARE_BITMAP(vregs_select, NUM_VREGS);
     DECLARE_BITMAP(predicated_future_vregs, NUM_VREGS);
     DECLARE_BITMAP(predicated_tmp_vregs, NUM_VREGS);
+    DECLARE_BITMAP(vregs_multi_write, NUM_VREGS);
+    DECLARE_BITMAP(vregs_uncond, NUM_VREGS);
     DECLARE_BITMAP(insn_vregs_read, NUM_VREGS);
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
@@ -174,7 +176,11 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
             ctx->has_hvx_overlap = true;
         }
     }
-    set_bit(rnum, ctx->vregs_written);
+    if (!test_bit(rnum, ctx->vregs_written)) {
+        set_bit(rnum, ctx->vregs_written);
+    } else {
+        set_bit(rnum, ctx->vregs_multi_write);
+    }
     if (type != EXT_TMP) {
         if (!test_bit(rnum, ctx->vregs_updated)) {
             ctx->vreg_log[ctx->vreg_log_idx] = rnum;
@@ -185,6 +191,8 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
         set_bit(rnum, ctx->vregs_updated);
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_future_vregs);
+        } else {
+            set_bit(rnum, ctx->vregs_uncond);
         }
     }
     if (type == EXT_NEW) {
@@ -194,6 +202,8 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
         set_bit(rnum, ctx->vregs_updated_tmp);
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_tmp_vregs);
+        } else {
+            set_bit(rnum, ctx->vregs_uncond);
         }
     }
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index c5d161745e..9aea3e7ae4 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -430,6 +430,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->vregs_select, NUM_VREGS);
     bitmap_zero(ctx->predicated_future_vregs, NUM_VREGS);
     bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
+    bitmap_zero(ctx->vregs_multi_write, NUM_VREGS);
+    bitmap_zero(ctx->vregs_uncond, NUM_VREGS);
     bitmap_zero(ctx->qregs_written, NUM_QREGS);
     ctx->qreg_log_idx = 0;
     for (i = 0; i < STORES_MAX; i++) {
@@ -448,6 +450,7 @@ static void clear_pkt_ctx(DisasContext *ctx)
 static bool pkt_has_write_conflict(DisasContext *ctx)
 {
     DECLARE_BITMAP(gpr_conflict, TOTAL_PER_THREAD_REGS);
+    DECLARE_BITMAP(vregs_conflict, NUM_VREGS);
 
     bitmap_and(gpr_conflict, ctx->gpr_multi_write, ctx->gpr_uncond,
                TOTAL_PER_THREAD_REGS);
@@ -455,6 +458,12 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
         return true;
     }
 
+    bitmap_and(vregs_conflict, ctx->vregs_multi_write, ctx->vregs_uncond,
+               NUM_VREGS);
+    if (!bitmap_empty(vregs_conflict, NUM_VREGS)) {
+        return true;
+    }
+
     return false;
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE996C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZe-0003th-DQ; Mon, 14 Sep 2026 17:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZb-0003sT-G7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:47 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZZ-00019W-Td
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:47 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4af173320f9so2954135b6e.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422644; x=1790027444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cFTiMog4hJei3+rgly/bhDU4tyKHPjUWScPp1aB72h0=;
 b=l+2ndd3AKFCEyA6x4ZNiaDBkUlqzvk5QHC4Wqdpviwv/J4rEShsgDhXsiiAIeSdC1b
 RDRE0h6sqzvIqVT1euHYIE4HKe4XgYO4k8KziMB2RwhpR7sUAa+UZc4ebGEjpEb67cH/
 PvVh1/n/Txym+O+3rN1yH84vsTzMjpqcWRSVsAbchLL4ZIxQFsNrRZBkHAr1Gpbkgc8P
 RPcodxmjC6tL0LJhIbPe0ThSMB6UcIhdUZJvbBhIjGqp45T03kt/gQr4xhprYsHhuiVA
 L5bBmxWuVz8AvbjlnwXZtNSpxpT563x0UXRiTn3asq6DPQaELdISVA94MTytfCH8y7K9
 WHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422644; x=1790027444;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cFTiMog4hJei3+rgly/bhDU4tyKHPjUWScPp1aB72h0=;
 b=XBbbyQZ1EhOBv8WG+DFKQwKBzAmX4QFp3fLcDhmnJUyMMzZGgtOx1TqhGnbpsbf4jm
 /P5eX09ZM69dAva9wNis0YOldtsjOAhFQTuKuaAm95UivC5tcY1DJIJ9GouIEQVJIMCf
 JB5Yo58tAdpAm2j7iXTPbQ6AbYYee4KNJzGGVlhCK7GUpDcUB55/D19aOmmHxw2lzX1s
 /H+Olnp8W3hbkqO3Vy/zOY4v02AFVrpqgMSxJqFvS1Jgvm09MkXwGCAUTli4xxXo1EVz
 xNTufD1NihX5NGrY1KGzbWLbmszHpDGPzjtApD51lFhp5x+4fWerz9svHRG+JBSpLnm/
 wcxg==
X-Gm-Message-State: AFuF++mEGhFyNZ6mEbk2tQl73qWi64YO6H0xikklJS15hZpsLyFzsXus
 SW83whmDEtDr1jPBe2Z0XYBUwW7+QS2nwNXNLNa3Ae7uPY1MjvHVWPDatb+IvF8e
X-Gm-Gg: AYBFou06PtpaBkFuXWPZI90DVsvtmXijQwgA1b9xVWQ1sAh/BhHrjfuXx2QRC6HWcqw
 vnIVlrer5dMFZ/wTdPWPAY0HOBaGz5IjmxPf2lbxOslbZTKk04cIv/t7d8/FpHZpW1a+QNZyY7a
 94TJvZnUFiHhx8tTY69FF9X/q7R1BfU027lJXvv7RR7KOct7CcLjlzt8Qw/2IS+4CYqcSdvbWQV
 yG2Bv5U1aP19B/eVkLGYngA72yyEtEz2J2Rbfw3oRNeyygQTR22B48TQCfqvKnl+5yW1xbilcig
 WbQQo6mI0vn9hHcfeOHX8ZEfs21crer1T9gFbVQeOlNxwf/WNb6jU6TVCDATCV1UwA3HMFeoscM
 t6HUg8CiWazax8YQbUExRvrLA4cVUzxWIf/Atjs2k2acFUGADH7Rh1EcN9MyYNX5rKqWvjkH6ih
 YJ2zarA6vpZeeNMb1ufpLeET/MDW49Qov3yZstOnLJkszLmdCgELnfdjEeGWyb1jXLYn4TTLe98
 HQA+g36nH2x6kXyyH/wRXN3ltb1VlD/HmEffSHzSBEQuUuWmfbV/i7FqLQiE1hp
X-Received: by 2002:a05:6808:144a:b0:4b9:e5fa:8907 with SMTP id
 5614622812f47-4c7b6369370mr3065699b6e.26.1789422644307; 
 Mon, 14 Sep 2026 14:50:44 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:43 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 02/10] Hexagon (target/hexagon) Check for GPR multiwrite in
 analyze_packet
Date: Mon, 14 Sep 2026 15:50:28 -0600
Message-ID: <20260914215037.157879-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x230.google.com
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

For now, assert the new method is a superset of the old method
We'll remove the old method in a subsequent patch

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h |  6 ++++++
 target/hexagon/translate.c | 23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index d8628383f1..964e6ce0b7 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -41,6 +41,8 @@ typedef struct DisasContext {
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
     bool pkt_ends_tb;
+    DECLARE_BITMAP(gpr_multi_write, TOTAL_PER_THREAD_REGS);
+    DECLARE_BITMAP(gpr_uncond, TOTAL_PER_THREAD_REGS);
     bool implicit_usr_write;
 #ifndef CONFIG_USER_ONLY
     int greg_log[GREG_WRITES_MAX];
@@ -157,9 +159,13 @@ static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
             ctx->reg_log[ctx->reg_log_idx] = rnum;
             ctx->reg_log_idx++;
             set_bit(rnum, ctx->regs_written);
+        } else {
+            set_bit(rnum, ctx->gpr_multi_write);
         }
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_regs);
+        } else {
+            set_bit(rnum, ctx->gpr_uncond);
         }
     }
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 52dd1f0266..60441dc309 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -577,6 +577,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     ctx->greg_log_idx = 0;
     ctx->sreg_log_idx = 0;
 #endif
+    bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
+    bitmap_zero(ctx->gpr_uncond, TOTAL_PER_THREAD_REGS);
     ctx->preg_log_idx = 0;
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
     ctx->future_vregs_idx = 0;
@@ -603,6 +605,19 @@ static void clear_pkt_ctx(DisasContext *ctx)
     }
 }
 
+static bool pkt_has_write_conflict(DisasContext *ctx)
+{
+    DECLARE_BITMAP(gpr_conflict, TOTAL_PER_THREAD_REGS);
+
+    bitmap_and(gpr_conflict, ctx->gpr_multi_write, ctx->gpr_uncond,
+               TOTAL_PER_THREAD_REGS);
+    if (!bitmap_empty(gpr_conflict, TOTAL_PER_THREAD_REGS)) {
+        return true;
+    }
+
+    return false;
+}
+
 static void analyze_packet(DisasContext *ctx)
 {
     ctx->read_after_write = false;
@@ -1206,7 +1221,13 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         clear_pkt_ctx(ctx);
         analyze_packet(ctx);
 
-        if (ctx->pkt.pkt_has_write_conflict) {
+        /*
+         * Check that the new method is a superset of the old methond
+         * Remove in a later patch
+         */
+        g_assert(!ctx->pkt.pkt_has_write_conflict ||
+                 pkt_has_write_conflict(ctx));
+        if (pkt_has_write_conflict(ctx)) {
             gen_exception_decode_fail(ctx, words_read,
                                       HEX_CAUSE_REG_WRITE_CONFLICT);
             return;
-- 
2.43.0



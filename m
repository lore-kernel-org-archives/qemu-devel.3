Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78786C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QB-00036K-74; Fri, 11 Sep 2026 18:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q9-00035h-OW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:33 -0400
Received: from mail-oo2-x26.google.com ([2607:f8b0:4864:31::26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q8-0002GI-7G
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:33 -0400
Received: by mail-oo2-x26.google.com with SMTP id
 46e09a7af769-80032c08611so209757a34.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164510; x=1789769310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6IZiCLmQxbchZtGStZBNSVoBHqkeceFSXfyikMt3syM=;
 b=jTvKH+dUKo9mZ2SEcSlzdfmGlfpBnK2FP7lyqAO0jqNpKZNGZBAAGJmdV5pTzFlnmj
 B+5YIt1oBQXrcup8PJWtdcLYFaeAEMg6YVWc7AufKx8CDamTuyLjzuQg4i/rUxE+sZa2
 sV//9g1lrjI+DbPD/ZoW9zBCtPYRdKs91Zbi4v7npII8omh5WdqGk9kW5dLtw4U6Lbpn
 XpaPYb3J+kO8UMpJuU8btEls8uKspdBdHTVW0iQTWmyh3EBO1e2seKAFmCVSP4LhuqZ9
 B0h38BQAk+KDUPNeEdi8b0/ie25QjjmBN6lTinEYHBbPxjrmEnZHo2cT8d7g+U8GGVv7
 CWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164510; x=1789769310;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6IZiCLmQxbchZtGStZBNSVoBHqkeceFSXfyikMt3syM=;
 b=O3LYK8GUeTLCxe0rRvVE8x7SrqmnmGkv+xiVSEmd0wA6b3sOl771AzZ1sEuYIDov3b
 bkuVoGt27jzMfgaO7a/9L//lDsQhx37i8XlkK6jTAuv2GRO8Kr1CKdJnjfdW4WhhVj5U
 4hlROL5Z9XlbFtJULrDU9p9s56tRHFQdIxdKeLzd4WaaCACDz6B1mx3uLwAPTd+sSz4O
 2ZRjUnJTqNLb9VKmXmOg92nmrTAtUdVIV3k3TEihOwU4tBU8HW4oQwdMimWV4/fNrjZY
 Qxlw+sDsZPmmw8zpHQ9BjSXc+KGpHvlMA5S7+lwFxFSxTyjxkBjMhALUsRqF03npQEOA
 oiHw==
X-Gm-Message-State: AFuF++l0r+KZDZZUihP2HJUmme85j/4N4q+lXSziigQkgMGHyQRepXsm
 koN1csJn/pxF2mWKl2vpbJP76jJoqkG8Oz2QwGpqkYTKSRP3ocST/S95zxc7B5pM
X-Gm-Gg: AYBFou3yyJv9dxdqQYBm3J1ocSWqztNOc7ZaVuxO0U9DBYgKRoiPlHQWYRjIUDGdm/A
 G2pw1V+k5yIn4gu8syiJHtay0p20IKqrAQteFwBKG9YSQC+1909ulALywUCxBXyJ8P3Kbw/QlKt
 3hl5sQbVOwPK6Ja8Nv6CjgVyehRbTgS3/2TXgUeLiJPnl/yKUHXCd+cAMxBDY0X+alfXyaFn/eY
 sA7w+eW7T4YmqvfGuNNq2rfF4SI3aW/1Np7Iw1xdmdfRUyoAelSbFsMW75pbbR8ttItH1WnrxU+
 Da+tZlyIAb9cixbAicwhs67HENl46vUF8IpBjtlmsIc+JuCYkVqZ2xs0WBIDQyHPnInMRRNU2kg
 hEkAPUOpMAV/FcQayE5r9vXBQ1f+4H4v0X4QekpJ17ybjqMwXzMi4aU1eJheb2cObZqpuu9ZXSc
 ij7Sr7sVT6+bZh++ptTsQ6MHws23ygfOEdThAB+ybFQx4tJomyIz9dZbru8dd1LbeoTqKhmBq7X
 +cAPc99dp7g9kwPJKGNT2ll0Wdh1b5krTVvM+rGlNqXkxzaCCP+gtrftcp1zyBU
X-Received: by 2002:a05:6830:6d0a:b0:7e6:fa37:9797 with SMTP id
 46e09a7af769-803fcc18462mr11141681a34.6.1789164510238; 
 Fri, 11 Sep 2026 15:08:30 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:29 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 02/10] Hexagon (target/hexagon) Check for GPR multiwrite in
 analyze_packet
Date: Fri, 11 Sep 2026 16:08:17 -0600
Message-ID: <20260911220825.143115-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::26;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo2-x26.google.com
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

For now, assert the new method is a superset of the old method
We'll remove the old method in a subsequent patch

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



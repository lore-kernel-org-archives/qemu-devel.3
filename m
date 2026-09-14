Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EAAC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZv-0003wf-3A; Mon, 14 Sep 2026 17:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZj-0003vM-WF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:56 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZi-0001B2-Gw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:55 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c206dc8adcso1055788b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422653; x=1790027453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=unC5f1RheMFwN5jVnuAZPd0KH8jKxp8hq2mS/5VGK2c=;
 b=bWoeW+CtWwrp1J18IXWQsQXolWlEUdzpMyFebiFM2x6DHfbPT3jEQTaw7FBmbm1mhY
 Efsqx56GeRyL0/vKvrRuxXjH7iiTBEHPLx1bZh0wEgFtvmFWTLzT/+NL1apzV3YwFfSy
 /HNliat3/AxvVJYpvmbACg5rM81/VP2uMxZnhJD328Nl65MNfGuHDyZODm/Bg5Ug7r8Y
 Xj6UtR3gqwmG4XYyswKKhdarDudMgB4Wdw/yO9eAM8n3vQ+cwXITOIaMCfrD1PA+zLll
 ZtrpAHgpmEZd/rCkQuCGTlmajNZ3zDKe29Oe1g5FgBHgjyzmojpgyhHW9CPemSb2y6ha
 BGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422653; x=1790027453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=unC5f1RheMFwN5jVnuAZPd0KH8jKxp8hq2mS/5VGK2c=;
 b=qUcEG8mFnHlJSPD5dAtQUQ++oA6/PUreBlCdtib5YusxWzuUYkXcQpwTaOxIrsy4+h
 xwvc5DKmKCCIhSQZ4LMuPrNPCkGR9D/Chx+zGLp6/IJSqV7WaMzHz1yCr9CHXcB57ZWt
 pb0uAYJSLMHHOQDQw0MBLfJfuxga7f5LViyhHL602vl0qQZ5Z/F2YSPegOpvr1ozviJS
 Ep7eRORC4+oIhg8l4WASAtbPyzXd2+GzRwgx+ELmSNKQMppta87J/VzzjC07EnWffseh
 qsEXMJrrjd/kNRw+QEZBqX7VUYNOdNA06ViNm61/dbCqHPyiLlup8pTZ2BACrjEJ8oMo
 KBpA==
X-Gm-Message-State: AFuF++lB+erq4faXAGfqNrJx7vZYamFDBdxYr+mYebLclr2zcFwmoAQh
 d6V2uaWXMhh8MpXdNvZoBAkoIprrnT/whpSV0XX9Zs2zDr1eehKtIaqKhC5jtofX
X-Gm-Gg: AYBFou02UcVjxP33/I93Q2VxM0mFkBx5rdzpJHLJAUj9kIn5fwagNXM+eTqL5/v2cHK
 PmEeab6IUETdPvSLrPlPmsk+jxmwNlhaNqA1h7bR9WPW4jWrN/y2A6/5J8wtnPq8tQp+P7BxvVS
 3S2ZKeGRqJmEEZ3lFE8OvoPOoMhXS25zxRmq9fXAn/M3REXRWOrge0v3CvtGo3UvHmlkgg3xEZs
 OfcDaXc5GXHXQITx2ozdeygC27S1r6/yH622mGYqnUtc0EFE3MofNQnMlHdd3aU9lGfssms9rI2
 pwqKTsSsnJhUuYXE3rn4duuuVyt2JvXuDOgL7xRoQ85KpvnIO7UVuQpwJnVH3ANH8+0weWkGBq5
 qDfeePSPPP+P3TdWpkzXR876xKZNH0jvsgx9fD785PvqWSNPuvbCe763h+PoyT0SRhTUXGuhgue
 lABgqAHK7rALei23+CeDe7cAtqjN2qaE6dVQHPhrn2tZTPyfwDQMhqHqr/tKcUFGaI1/TQqcPdK
 B366ptfmNg2EV7VdNPyGkVqPwU/uzKjvBei3cUOQGQ8UTjMFIxcjm2abtggdZWj
X-Received: by 2002:a05:6808:14c6:b0:4bd:1fd5:9595 with SMTP id
 5614622812f47-4c7b5e81595mr2908733b6e.39.1789422653437; 
 Mon, 14 Sep 2026 14:50:53 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:52 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 09/10] Hexagon (target/hexagon) Check for sreg multiwrite
 in analyze_packet
Date: Mon, 14 Sep 2026 15:50:35 -0600
Message-ID: <20260914215037.157879-10-ltaylorsimpson@gmail.com>
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 11 +++++++++--
 target/hexagon/translate.c |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index eb0d10d686..b90f7fff1c 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -51,6 +51,8 @@ typedef struct DisasContext {
     DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);
     int sreg_log[SREG_WRITES_MAX];
     int sreg_log_idx;
+    DECLARE_BITMAP(sregs_written, NUM_SREGS);
+    DECLARE_BITMAP(sregs_multi_write, NUM_SREGS);
     TCGv_i32 t_sreg_new_value[HEX_SREG_GLB_START];
     TCGv_i32 greg_new_value[NUM_GREGS];
 #endif
@@ -125,8 +127,13 @@ static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
 
 static inline void ctx_log_sreg_write(DisasContext *ctx, int rnum)
 {
-    ctx->sreg_log[ctx->sreg_log_idx] = rnum;
-    ctx->sreg_log_idx++;
+    if (!test_bit(rnum, ctx->sregs_written)) {
+        set_bit(rnum, ctx->sregs_written);
+        ctx->sreg_log[ctx->sreg_log_idx] = rnum;
+        ctx->sreg_log_idx++;
+    } else {
+        set_bit(rnum, ctx->sregs_multi_write);
+    }
 }
 
 static inline void ctx_log_sreg_write_pair(DisasContext *ctx, int rnum)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 19585a108c..a35c6c6835 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -578,6 +578,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->gregs_written, NUM_GREGS);
     bitmap_zero(ctx->gregs_multi_write, NUM_GREGS);
     ctx->sreg_log_idx = 0;
+    bitmap_zero(ctx->sregs_written, NUM_SREGS);
+    bitmap_zero(ctx->sregs_multi_write, NUM_SREGS);
 #endif
     bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
     bitmap_zero(ctx->gpr_uncond, TOTAL_PER_THREAD_REGS);
@@ -635,6 +637,10 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
     if (!bitmap_empty(ctx->gregs_multi_write, NUM_GREGS)) {
         return true;
     }
+
+    if (!bitmap_empty(ctx->sregs_multi_write, NUM_SREGS)) {
+        return true;
+    }
 #endif
 
     return false;
-- 
2.43.0



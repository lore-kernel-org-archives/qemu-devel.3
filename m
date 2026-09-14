Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2ACC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZq-0003vv-3h; Mon, 14 Sep 2026 17:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZi-0003uu-0f
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZg-0001Aj-II
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:53 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4c5373b1138so2068469b6e.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422651; x=1790027451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wCd2cA/LUpQyass9ePvoTKJyyqXKS4xxE9bzNRBwVwk=;
 b=KNh7kbsp1SOUmllpH3hqlvvAUtOqbALuLY9Ew3pD79hRBWsVmuRLjUSdiErK6PEKke
 KdfsmepGm1oEegVu0A2f2HrZY3XKNI9h7QbLGYvj9WFCBKzyRrdXcd98Nt7AnnpRgHiY
 89e+X61P8NM1xuLsvFqa/d0ZTUfusE90bWwu88M5n8fonDUInrg+NISzO4W2AcGYiwwA
 TMxhMtkyRGrR/q4u1+6qx71DP0ciyD2XcmGgeAM2XC4HHZmI5KUMwvmWIbOf7Weuhx5S
 BaWPZ7UrgDVszXuE9MgWgY6PZ0syW4xUu9z/4L7uJWgbE8y+4fnrnikb/OY3yJ1CB9QD
 mt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422651; x=1790027451;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wCd2cA/LUpQyass9ePvoTKJyyqXKS4xxE9bzNRBwVwk=;
 b=nAJC2o1rEaK4AZpu0ICBORUr/G86eEPtCUW6IOcNXDpOMbI30IgumTlw6sEtAQDOwW
 z6IFtY0tfImmVgxTTkbYX8N8LdOcaEn8MRgr5JVykD/zMlwNH/gHRCKCJ5pPKPSLxnQm
 hOWrfH3zJQf297WHXguYBgYmNUIjdIfoNkGBLqY0DhTUoWgFaPzcISOcq7S+2HUp6X7x
 byb4n/yCGxXzPg3xr12t43Qx01mmWK3xelcIrLl61RL+YTjDQCKIlVZQ9Estw3Fmr/1J
 tJkDmflnQbTH7J943F83g2pklJJ462QaiJFGYsAwddZ+yeOswfJ+NeCDLa7ZHTxMIT/z
 GKKA==
X-Gm-Message-State: AFuF++mBTWIXt69z+DxYo/oai/2o8l/PnLfEvMJczNJ1BQoUamVlUW3M
 8wWKc4e8BgMZ0GSF+so+/U/zrzw8pXbiewfqWwSmNlljQwUhq0IiP43Ul6A0XMYR
X-Gm-Gg: AYBFou2L2+rvlRojnU0pAuE16GAV7vUqO/mUz6eiEYFd740Bq4QXpcQllczrluius5T
 aWCjXj40xLwNwBWAWlBZnrNlmffHUYoWAZVhe0FnsQoefD4HmKtiO1W1BvIZ7Bgbmmoq7P2Ol8D
 atW4sqSqsrK+pcresFg8JVWhNYM1crGynYVxEwwDSbAYVXlKOf88jYeMCfeFaDtEECSAC0iC/oh
 b1q5h7p7x774xQfCzx13b9fvbfXROdv8tBsv91IAWZ66gd+Lklvd951NTC4RcBXSrB09GFLzpFU
 yq13XCHjd29xe/QTa99VhkBdmoc329AjLGDIa7kBJB8+IJp3b6mf01Zm380WfBO8AK4Xc1+XePk
 s7Q/Vg99VPAEBAzwCqhwrGTSu1T0zjaKvbBvIIT2ZRmkQ5NhpLzJqLgjDUy5ay6mIZ/lI/g4hRs
 e4+2szSE9EIAekWkwr+0t3h5U/aSDsoV+zzyVOQ4x2ceEB74XcXxknsyxDjm0fhBXXuqM8166q2
 +x/VM5TLD5Uj8rHlOegURHDbZFqfufsaMnOWObnr8TRH9dDyB/z/zE9CE0oURRX
X-Received: by 2002:a05:6808:179e:b0:4c4:79b8:8ad0 with SMTP id
 5614622812f47-4c7b37da5a2mr2721130b6e.11.1789422651325; 
 Mon, 14 Sep 2026 14:50:51 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:50 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 08/10] Hexagon (target/hexagon) Check for greg multiwrite
 in analyze_packet
Date: Mon, 14 Sep 2026 15:50:34 -0600
Message-ID: <20260914215037.157879-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x233.google.com
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
 target/hexagon/translate.h | 11 +++++++++--
 target/hexagon/translate.c |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b6cdf51c20..eb0d10d686 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -47,6 +47,8 @@ typedef struct DisasContext {
 #ifndef CONFIG_USER_ONLY
     int greg_log[GREG_WRITES_MAX];
     int greg_log_idx;
+    DECLARE_BITMAP(gregs_written, NUM_GREGS);
+    DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);
     int sreg_log[SREG_WRITES_MAX];
     int sreg_log_idx;
     TCGv_i32 t_sreg_new_value[HEX_SREG_GLB_START];
@@ -105,8 +107,13 @@ static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
     if (rnum > HEX_GREG_G3) {
         return;
     }
-    ctx->greg_log[ctx->greg_log_idx] = rnum;
-    ctx->greg_log_idx++;
+    if (!test_bit(rnum, ctx->gregs_written)) {
+        set_bit(rnum, ctx->gregs_written);
+        ctx->greg_log[ctx->greg_log_idx] = rnum;
+        ctx->greg_log_idx++;
+    } else {
+        set_bit(rnum, ctx->gregs_multi_write);
+    }
 }
 
 static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 815eecb60a..19585a108c 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -575,6 +575,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
 #ifndef CONFIG_USER_ONLY
     ctx->greg_log_idx = 0;
+    bitmap_zero(ctx->gregs_written, NUM_GREGS);
+    bitmap_zero(ctx->gregs_multi_write, NUM_GREGS);
     ctx->sreg_log_idx = 0;
 #endif
     bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
@@ -629,6 +631,12 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
         return true;
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (!bitmap_empty(ctx->gregs_multi_write, NUM_GREGS)) {
+        return true;
+    }
+#endif
+
     return false;
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08964C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QL-0003GG-Vu; Fri, 11 Sep 2026 18:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QK-00038y-HC
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:44 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QJ-0002I1-2V
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:44 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ee4399c3abso1692337a34.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164522; x=1789769322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XfPLMrWBdlBpzdnXiPC8LRdPUDQloqBBgHF7cxEjtlg=;
 b=A9VCP08U4n4HajepqPxn+qODm0EIVlvundJVZyjPVocSk/qD8OJRoRCVGO4fFDLu5b
 2htQFzxC0hUVB+pj9QAgVwmIpnA5AfbrkKD4ZoREre23rxvcl+79DrEoVyV0jm+hGtYz
 zvBh285LhlbVnyTHWtuZ7Lo4gRHtdbt6pgY3qlwlET/TliUNGKE2FXjrb8lwomEilp4T
 +HQvyFE9M2T3Z/FyGDrGFKZrOHxwaWizlgcW9N/2O0od2ijn9125zSRZA1rMKTxaxcow
 dqx5D3EBhQmorTWEUACaeW1YpobXQ6Wcj1Uqz8/g2297hdMJFj0bDxrDgcZgPxA/n94c
 Jdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164522; x=1789769322;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XfPLMrWBdlBpzdnXiPC8LRdPUDQloqBBgHF7cxEjtlg=;
 b=SRhXygISk7+PXwstNeQ5uYVFy63aMaenuBk1XXdyER1X7fp/djJQx3kEHj4us+Bo1X
 Tbg55Px9DGBMxyd5FvMqAVGkMZRM9Ls0uQWlnO+NdKQug8SDCXK4HvPgGkcCQfUIQVOa
 qnBDkzLQqDs9wZBduCCjOx+7LCuV59IK0Yxzsgg36wQhv1PXuwHQVqpxTDYfmO8MjyrT
 /RSkMxw354dwMGteira2N+TuhbJ9v5xSCCPffzCvlYcfZpZueMtZpe36AwqyKGAbpJ9v
 trlMNFjLTeNTr4Efgtzxsoj7+qtcngawwvepmKIc/c6e1IE7eVsQFgLpjfPZmNzPqmdL
 wcPQ==
X-Gm-Message-State: AFuF++nAiKumfYgFMsvNMwEB2aYusXzjjYNTqGY8q6O5M73araexojRW
 FNO2KyKKS6SWCRALHZUc+hm1sSQFlPCFee/whtc1+a/3HMsYe29jFF/CrSr2XJUT
X-Gm-Gg: AYBFou1YSqTjxbw3LpeaqTiz7qWlCF8qYv/188UwvrvpSte8yZvEiGVFy+fGVleA7gn
 TynIm6tcVM1nlFRyK/JB1eg5LShzGDtsTd8mEj30OznRLl7/Uq/ILo7GfMWSKcz92ArcrNdUeEB
 /XDD2Rvt5HpahegVywifQ8x0YPbQcqJLzUCubBmewTn/CgktFXjfKfVkNkpWbEgkaEM5CSISWe1
 0eSsS2moSnTPJHfPg/kRZaUNMj7PL51pX5VpaGKj32M1LC1UOoqCCO3psvJ3a+PlYW2b8KVLXGq
 t9NwQnITq+2LJN92Z5D/Tmfrlvj+nHZgzT2r8ofPhYHks6oWFgflURIG2O62tqb5FbNDi6OMhoc
 gLmtBIXTgcFrnozSgkVgB9nJIRCzpLUSDAxHBXCL0tk5us7/yDcCrY7rB2r6gRL5XulG0DX+Y+m
 Ho5CZurx0k3uZ5V0QJaYz0qtfCBHvScAiHVPx35vRaThohkhHQi+UpP1LTmnJdOP1+Xn95t7j1L
 zYvamet+DpycJ7UOXxvSk/0gqxtVapjsaYArK58l7NYsq31jwAYpWKm6Ymb0Zw7
X-Received: by 2002:a05:6830:2585:b0:7fc:bd37:c5b3 with SMTP id
 46e09a7af769-80400a16e6cmr5613306a34.18.1789164521888; 
 Fri, 11 Sep 2026 15:08:41 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:41 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 09/10] Hexagon (target/hexagon) Check for sreg multiwrite
 in analyze_packet
Date: Fri, 11 Sep 2026 16:08:24 -0600
Message-ID: <20260911220825.143115-10-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x333.google.com
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
 target/hexagon/translate.c |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index f469452daa..c40ca86810 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -635,6 +635,10 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
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



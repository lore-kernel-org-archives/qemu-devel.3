Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBEFC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QH-00038B-2D; Fri, 11 Sep 2026 18:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QF-00037i-RF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:39 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QE-0002HB-Es
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:39 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-805453b1c0cso458821a34.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164517; x=1789769317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=++rid+1Xx+Qp8w0gKQKJDj1SBpbPWKwyO/KL9Co2uPw=;
 b=Ma89fOH7PQFSpvwLks+j6eaOzHsqU/flvu+y/9Yomwa1mp9Mlo4lmtTgzeiu9HQ1q4
 ZjxRuxIAKYLHl8Yxu9hNRZeW0ZnM46mxfMZlEt68z+9y6oTr+ZYL0sKkWZd3UxSlOJ7i
 ofLSqHGntHKYlgU5ioMpB5be44yQRfYekNiG+VOHiO5tddcEkBXjhZ6bwYdcJd56jgp4
 xH/MDt/pIPi/vdir7GNBC6QVUeS/OCFswJudG55VuTrcZLBmm5Czeegw9nPhTiTD8pWP
 J8EviJdhH1Oq4p+Z9BKW/FVQlH0mOHBjd5UC3dIeU00drRzTGI3kfeLDrok53/qXP+zS
 ADLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164517; x=1789769317;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=++rid+1Xx+Qp8w0gKQKJDj1SBpbPWKwyO/KL9Co2uPw=;
 b=cR3YVN18zuF8bcNFNo+yqIoVeHjsKDi3g5bFiHuxdH6XZEFiMWqfEd7fQdwIPONecW
 uwKocvEEpguw+Tcgk8/+bfqA+LZAP2aT84ZavuoUIjgrQTs0vgx0WCbq+yp8cgqm8MLJ
 yQJe+KQAVxipkM0107gGGCyhVY24tCwBrtMzKXnW8s4KaIlAklu0vr5sArLC2ggfrlQw
 WjOtaZENqdQSCMdo0E0K0YxSAq/ktX9HWB0q/GnTgJDb8baMOOKw7PsnTfWStQaJfHxu
 /weY2ik9+X6KIq7Q+MnydEyWfl/uzSDsXui7++UvB3CwA0zWbQRWAtdSiTjAxUPX7J64
 ze7w==
X-Gm-Message-State: AFuF++nDZJe/6ZGZ5fpxZxgTcvNBlkIeiTvA/6+59GkEI7d7ZF7r8HMR
 RuAceWrm9rPbgVVC8KF9XlN7yd4EHhFIaktEts+8g09vv4fIqEP2LADn0x0xw9Ef
X-Gm-Gg: AYBFou0ZBxDGNmerL9QDEL/na7+5z298ioIkYtJnclBOOC9A0X2/LEBwz13PtZzP0sW
 px1MryCPmPg8vEgFLJGN9DPQaMcAH5KBfBHQ/CKuroMYeMXeoAGrSnQUfpliy9RATQPXrgU6YIz
 RfFV7DoBlGUxdodngEfN25KoWKTx7zS7ShyWBRaOeJP4bfb3YVz4KO42sCAdkLGmeP90VQYkXbN
 fggkoUNH9stao/jDMaEnTrZGnHjFXwASWsL7iSmRPLXv5cC/2EIxSycaGjvLChuGqjG3jHREvEZ
 wI5HV+iyAy0EcvXD1kUoDfXXfKwfxs7RU8tm//qQ7L1uzZOZ265vxJS/qJvrbS5MLPu9zZ8yCEC
 LeHQiSiO6C2ITDCLEcLrqmZdsxeCfQEoD29hd1cp6deZQEJKjq0Y/kERojSbxoI6Uon3qdQAVhY
 Xklu+EeozFJeiPKT3KFAHT/eM/SdRSBVyBTIX6PGHQGq7w+/JJHmCVAqjhRjxD6OdS4OEaRULsU
 Ko2lyqJZLBTeegcKtZGbYMBjLGgi7d51Io5diIySZUujw61TAoQAqkJpQnTr2L5HnJ+oie+TV0=
X-Received: by 2002:a05:6830:4129:b0:7e6:f2dd:93c3 with SMTP id
 46e09a7af769-803ff328f8dmr5408711a34.15.1789164517147; 
 Fri, 11 Sep 2026 15:08:37 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:36 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 06/10] Hexagon (target/hexagon) Check for qreg multiwrite
 in analyze_packet
Date: Fri, 11 Sep 2026 16:08:21 -0600
Message-ID: <20260911220825.143115-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x330.google.com
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
 target/hexagon/translate.h | 7 ++++++-
 target/hexagon/translate.c | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 9ee5f25365..b6cdf51c20 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -76,6 +76,7 @@ typedef struct DisasContext {
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
     DECLARE_BITMAP(qregs_written, NUM_QREGS);
+    DECLARE_BITMAP(qregs_multi_write, NUM_QREGS);
     DECLARE_BITMAP(insn_qregs_written, NUM_QREGS);
     DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
     bool pre_commit;
@@ -308,7 +309,11 @@ static inline void ctx_log_qreg_write(DisasContext *ctx,
             ctx->has_hvx_overlap = true;
         }
     }
-    set_bit(rnum, ctx->qregs_written);
+    if (!test_bit(rnum, ctx->qregs_written)) {
+        set_bit(rnum, ctx->qregs_written);
+    } else {
+        set_bit(rnum, ctx->qregs_multi_write);
+    }
     ctx->qreg_log[ctx->qreg_log_idx] = rnum;
     ctx->qreg_log_idx++;
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index ca22bae28f..815eecb60a 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -593,6 +593,7 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->vregs_uncond, NUM_VREGS);
     bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
     bitmap_zero(ctx->qregs_written, NUM_QREGS);
+    bitmap_zero(ctx->qregs_multi_write, NUM_QREGS);
     ctx->qreg_log_idx = 0;
     for (i = 0; i < STORES_MAX; i++) {
         ctx->store_width[i] = 0;
@@ -624,6 +625,10 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
         return true;
     }
 
+    if (!bitmap_empty(ctx->qregs_multi_write, NUM_QREGS)) {
+        return true;
+    }
+
     return false;
 }
 
-- 
2.43.0



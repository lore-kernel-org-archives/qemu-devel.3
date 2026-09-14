Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED4C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZo-0003vZ-4I; Mon, 14 Sep 2026 17:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZf-0003uI-KN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:51 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZe-0001AI-2c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:51 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c206dc8adcso1055758b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422649; x=1790027449; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fLsa//+XZ9+Xsn4gbcnm6ZGz+g+Rhrde2dTMeiCZzGI=;
 b=CxWkmyAWZ9httHIlT16DpiUMgH1UhrvIPqP/TU12ncj1F31rvHwSbU9J+syvbCLEpt
 /Th1c/LBgfBj7TWDmgCGTl8vEYCXi2b3xInT49QcjtF3JHEzydvugTTPuUqzATu4H01y
 XxSv0gluccZlubKfmJwAtTKPQOWnmj/zXzguzyufCm2FtaTAwiaiv9V5rouMfGRKXVNj
 eXU8CauQUZ1uwH7yURbTrInMvyTaKvd45jbWA5r1Dva8ScAC9gk9fw8/M4L9K6TjKY2t
 wDWdRqAyxLhMPlpV5FxzwxYY2hB2Jvm1H2EowKOClBubKn9/GcATauhLzt8HGjuJx2DQ
 XOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422649; x=1790027449;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLsa//+XZ9+Xsn4gbcnm6ZGz+g+Rhrde2dTMeiCZzGI=;
 b=mMUlsd4GPL0FKzcWrQ2M6gLKKQAnSH/xcdHpqUuRzoGO7C3ubp7e+TizCtj15n2iTq
 odr4P+kEGLLHvrVLMY0gDt5ZiBMsi2jtvxtDk0fBvZ4D+3SZPLhjoHq9HUnW0VJec17G
 rjI/loL41cEiEE2VY85NDo4lSHqmBorX2fKLbgk+hB0Iv7w8m/1D3/uCnjoDXfWBNPMl
 fM/XI0XUFW1oNCK5EH915nCK+lQXGliFZ8SAQz9V9oe3ASj7ydZjHrursd5nMTQIL5jw
 X4eVdNRR2Ejsb81z0k9UklW4GW5rM9RMxomrtuvLLKnduVX0+D0bodez94Jj/Qs4GVs9
 P7Sg==
X-Gm-Message-State: AFuF++km5M5O8BJdcnhnrhgYEALd4pbXgS7gEUBmF0V0KtClPfEYBmxm
 E+Ob4qYy3h8+zB5HiapvjzXOOA9XiTCA/9XoF8k85gRy3ePQhUWpjiu+2M2rkk+D
X-Gm-Gg: AYBFou3q0c6QmR4Kzik3/4e94Us7ctMK9DcKR46sjQJTgnIjjsx12RM+4bCRMhu9+Jw
 PSb7EP4a388UjzGOsj6ieh7SOJiuMgdtHPJ9ORg85JmCr9h9fccwkWog7xvSGFYjOki9SmF432U
 BnZPrDAyu0KRHN3qWvpgCEdCRF+LRj7YQH/f1hjmlCWSV7MQLv3DW/Ak6fJECZ/E7GXF3PXSin1
 uwvDnE/BhpNOVDIvuFnIjceHbeAB/ZqlZRfyxiI4HQwjYWfRC1TR01h6G8dmgK6LaIEZWVQenjm
 7xLeBFRl5LvhMyatBe1T6mCdT8PLc550KKgf78XwX8jo9ZQBo7IkJu9m6mji2WhygTKXK7yREpb
 9YhBjT1QixZYYwKpV4BzrzGOZg0XqgQ1ZteepNPwcTFxKElqhOWOLSOXfBpDRFmXteU8HcMUOtR
 YeTDYU07bGa7NDui/52Xvibv7EUqHcZfAS2Uag0vVdrH//PaNpKdC4hLYSHNsJSEtFVwsLAkCj3
 pPnC6r3XZYX/TeVGM4xodGi9I6AndyJgEwa5ObaksHRbH9AAfIM9CPtg/eQQDvp
X-Received: by 2002:a05:6808:1709:b0:4c2:d7e8:cedb with SMTP id
 5614622812f47-4c7b3ad6320mr3044082b6e.11.1789422648944; 
 Mon, 14 Sep 2026 14:50:48 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:48 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 06/10] Hexagon (target/hexagon) Check for qreg multiwrite
 in analyze_packet
Date: Mon, 14 Sep 2026 15:50:32 -0600
Message-ID: <20260914215037.157879-7-ltaylorsimpson@gmail.com>
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

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
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



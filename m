Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246EDC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QD-00037H-L0; Fri, 11 Sep 2026 18:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QC-00036r-RK
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:36 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QB-0002Gn-AW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:36 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-7f4f0c89e33so312549a34.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164514; x=1789769314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HfXY7kMR5L2dlHzZE3BfJREi3HVnjp+rTkjSxFORXAg=;
 b=YE02eFRXdilnMrnjN+Knk+HtFITSP8u8Zw2hDzDNk06UXCKA2dC2Q/FivLyAdiwKxx
 ACWYL9W4rd8LrNrRp3HHHoCD2tb1sm34IOvJfn//YgIWeoxI81t7atDBXwOhKwjeD2VC
 A5ik+FLEBBSpRktGATSdarCBQS1meJGXmeueUWYVYpplE50lAmR2rp7hnqrVNii1KyHh
 fhZWoVKeCSs1uBkwGW2oeHOiIEOkC+vY4Xb0MnHhXTIb0odvDTseWIw7/CYXswpLFifm
 abNyheZGrOedAO22H9XEx/nV0R1oisUO+J6nzkuBLdRhc9YP5KjJbvHNZqtbISkXzVT/
 phVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164514; x=1789769314;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HfXY7kMR5L2dlHzZE3BfJREi3HVnjp+rTkjSxFORXAg=;
 b=XGZyTq0GCThxXHHj8y6Ty4ArjmfGWhtbQIhKpZBm7KcPj8DDpYfznYtO38kZWO3t13
 MglB35ypQtX+N6HtFNSrfqzzBWzuEHcmGk9hjaNrdTmXgimSclc51d2nBVJgz/g5Q3k9
 i2BsaYMp7bl5p8l3/KwUg/DeZA5Igxb1FjeBPoy9EqFgGuTyrPsHoZxlHI8ftQXGRoWI
 3t0dBcpyAW2RbfwMODkRuNcJ4K+wuVw892axnveqjaILcXmWQ5d+oENlkqxwuEdPxPiQ
 Hg+b/tbMHh+bfVEDGW1gImwu9/m+wn3Xj5bB7WNNIhn6EtMNdL2BGDQZ7IG1iUg927v2
 zCDQ==
X-Gm-Message-State: AFuF++mFwlskXcBIaRVDVhdkJl30BTB4Cg+EHfC+HyFgLhJAQkRxX/EV
 50aDxuPxSCvxP86QbgZ9hppnHukqN6O/S5YkSY9lbAbxh7SMdEMlG0ZZPcRmyNOE
X-Gm-Gg: AYBFou0tCkoxRq8mkfplbpBRJ9T8yUX5kBWG8oBexRuw8VbWWVjQbIdd1h2QxZyfGZd
 Cs103/osvBijEOHBHWDww9fuaQ+EeWm1L6JKsswme3UPb1xsI5GlWpk7GKVEgrMvJCXjMCbPM/1
 hfhalhYfNYldkUfFf+To2Uk6x9giLwfcpxkBH0bJHZEdP5AYQFru6yWi/+ua6Wdak+4ovQBGmCw
 fatbEynfGx/sY2t7AaEqd8BaUxMua49DYIRbRXnTznaw7lcf3rHFEkp0YavBJRNQ2uMOZcRYHbY
 h0DJMPHXrsU/jAZwBcb6WVwUf6gpC7orAGvywVSp/9/kLWIQRiGcmKw6tJ6IG13N/iX0OblOKAw
 mU6nW6oBPmq/GrRDi2VZtvC/Svq8chdhP8+YDIzQ3Zc2UMn+1VFXh4OFjAGQ7qWkueC80WOf4M/
 i80yBAR0FWWazPp3d9SwknZztew5IyVjdouUWj+SiS/c0QyEUmOk93W+diH7u1Uv/Me7hwb8ims
 a8ogCk6JIslQNtpKe7K8FNcEyX9FP5Ih68FqYV6z8/HN3ohbYn7bgTCCiHknxpy
X-Received: by 2002:a05:6830:6d0e:b0:802:4cf7:ea46 with SMTP id
 46e09a7af769-80401977040mr4919457a34.20.1789164514007; 
 Fri, 11 Sep 2026 15:08:34 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:33 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 04/10] Hexagon (target/hexagon) Check for vreg multiwrite
 in analyze_packet
Date: Fri, 11 Sep 2026 16:08:19 -0600
Message-ID: <20260911220825.143115-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo2-x0e.google.com
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
index 964e6ce0b7..9ee5f25365 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -70,6 +70,8 @@ typedef struct DisasContext {
     DECLARE_BITMAP(vregs_select, NUM_VREGS);
     DECLARE_BITMAP(predicated_future_vregs, NUM_VREGS);
     DECLARE_BITMAP(predicated_tmp_vregs, NUM_VREGS);
+    DECLARE_BITMAP(vregs_multi_write, NUM_VREGS);
+    DECLARE_BITMAP(vregs_uncond, NUM_VREGS);
     DECLARE_BITMAP(insn_vregs_read, NUM_VREGS);
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
@@ -218,7 +220,11 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
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
@@ -229,6 +235,8 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
         set_bit(rnum, ctx->vregs_updated);
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_future_vregs);
+        } else {
+            set_bit(rnum, ctx->vregs_uncond);
         }
     }
     if (type == EXT_NEW) {
@@ -238,6 +246,8 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
         set_bit(rnum, ctx->vregs_updated_tmp);
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_tmp_vregs);
+        } else {
+            set_bit(rnum, ctx->vregs_uncond);
         }
     }
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 60441dc309..ca22bae28f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -589,6 +589,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->vregs_updated, NUM_VREGS);
     bitmap_zero(ctx->vregs_select, NUM_VREGS);
     bitmap_zero(ctx->predicated_future_vregs, NUM_VREGS);
+    bitmap_zero(ctx->vregs_multi_write, NUM_VREGS);
+    bitmap_zero(ctx->vregs_uncond, NUM_VREGS);
     bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
     bitmap_zero(ctx->qregs_written, NUM_QREGS);
     ctx->qreg_log_idx = 0;
@@ -608,6 +610,7 @@ static void clear_pkt_ctx(DisasContext *ctx)
 static bool pkt_has_write_conflict(DisasContext *ctx)
 {
     DECLARE_BITMAP(gpr_conflict, TOTAL_PER_THREAD_REGS);
+    DECLARE_BITMAP(vregs_conflict, NUM_VREGS);
 
     bitmap_and(gpr_conflict, ctx->gpr_multi_write, ctx->gpr_uncond,
                TOTAL_PER_THREAD_REGS);
@@ -615,6 +618,12 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
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



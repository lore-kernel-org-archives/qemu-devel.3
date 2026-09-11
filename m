Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B14FC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QL-0003DZ-GF; Fri, 11 Sep 2026 18:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QJ-00038b-Eh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:43 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QI-0002HZ-2r
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:43 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-7fc4034841cso345238a34.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164521; x=1789769321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8zh+0+D/pnKMLt2g+JzInoJ6qXMZMaTiOcn0hMCXDRY=;
 b=hEQFBNDa9EhwT2eKpvNRAELL6DCrhPjpyF+dM3oTqekCQ2+HBikrXcdVt+xVC0Z4UD
 m4JrqKhIwNVRKKXik8qwi2K3Q/UbIJsv/ERgSiisovw2UecPdK6w+KRzBvuNBNoBOCU+
 0yKt5/kzkFFc2W2AzlBHltYIHp46860sZp73Wv+nXNHlN6Cp+pqiIUEUm1+07C4j0CSo
 5TNHpY6ebL5vRSTTZ73n3yfRtT1PimkE8g1sHCd9pVDmOsK7z37OC0PSmUl+YbOYWNEP
 OYAm5HO7x1Cw8Dwi5QDI94svwEX/2D5TCtVmm1MxOVSp3U0XQQxBtBuDNVl3ZnSpKI7d
 Diiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164521; x=1789769321;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8zh+0+D/pnKMLt2g+JzInoJ6qXMZMaTiOcn0hMCXDRY=;
 b=HMaH0Nu0Kl7qax3CmKZlqBGd+wVxb6aHFCnisLHSHgAWsXSWO3sEUFtAml53yCmZ9F
 2B8Q4tleI6UhzfYQ7xKjfFcTzFA4Ok+EQTt/BdS4DTdD7S/cTHIO0olrAyEHPOAPs+74
 FoIr9P2Wcly5jlHdyfiLe8UFFEfBiCUztzWGy3pToSrSEi7WE0DyoZ05aarE0DWUlecC
 pl0h9d3vN8hRvE3chn5q6KgeSGtTF3sankRewtSFwM8vn8y7C3kCCrVWDyfxYbuoa/cM
 BiDYUdYBLbdOHHs5EWytzH2jiSugVZVW6AhX86sRWlvxiupbGouwlzAJD2CIWKXZUYkF
 Ca+Q==
X-Gm-Message-State: AFuF++n4JSNAMMdrsVCuJmNrfZV33dfWYCUEgEFdlabd65rBWryLbj3Y
 6PJ0/5yhAIPh9Vh6sTl7uxrSzENO1sVKHcg2AOnaabdnGMDYVjv00uqix97UROxC
X-Gm-Gg: AYBFou3IUgAmINjmODSyE35g7MQCgekU5HAQuLnM+cPLgm6en+GdDsMt05OWGNLJq8Z
 12WJPpz4XCU1g9sMy/MKAUsd2mQs0JmxR4OiKSuBXtDIcRmGjPuYfcNnsk3jeg+ABCfszMVAyWV
 soUqh2smWQV9pAlFIplIMFOTTvv5sw4KID8TlWTt3brzONoYXLDrJszULPZE9496XwcYbnYNx2x
 4K9PZx7bQsFu6y/VATfRE70I4bqd+t7MUSUVEdO2SOJuCLkYcvgF3lDySoLsNne3xo9xnSfFG5f
 xFP5UTLEuUWmLOpqdjgbLMVEE1Fg0c7Vvf4ps+4cCsfYoFq21BGrMbTQkwGbnsu23mu2HYToqRg
 YBR4AI0Wi+HzwbgzR+N0G3gWQEd3GXWDU8h2tSuVhtqZm7VFMV4jf1OD4OwstBAVDmyy0EybU7l
 BuHDXoZkFDKTOcP9Ojz2rJkow2XWol0d4O55uHzFwBNJbiGsAHJyvWekC6TJjlO7ggiqc6b4nVr
 W/UP8GCblgKeW/Zd386nTaR8lTM/kCNQl3NmVtkTDUWU4fpSX/ivUxnq/T/Gv17
X-Received: by 2002:a05:6830:6ae8:b0:7fa:5c49:5237 with SMTP id
 46e09a7af769-804013516a7mr5912276a34.16.1789164520858; 
 Fri, 11 Sep 2026 15:08:40 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:40 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 08/10] Hexagon (target/hexagon) Check for greg multiwrite
 in analyze_packet
Date: Fri, 11 Sep 2026 16:08:23 -0600
Message-ID: <20260911220825.143115-9-ltaylorsimpson@gmail.com>
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
index 815eecb60a..f469452daa 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -575,6 +575,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
 #ifndef CONFIG_USER_ONLY
     ctx->greg_log_idx = 0;
+    bitmap_zero(ctx->gregs_written, NUM_GREGS);
+    bitmap_zero(ctx->qregs_multi_write, NUM_GREGS);
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBC3C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ziu-0001Mm-NW; Thu, 02 May 2024 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zib-0000v4-Pg
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ZiY-0005va-6M
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f44881ad9eso137556b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668932; x=1715273732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJIohk8gDQsUtWfZD6O/rKhQO02QyqWEocuP7xflwZc=;
 b=g1ZAHCCIwa/+S5xgikjaoA9LLxIIklzgdOBm0ef0Z1IFhquytgD/wntaT7snt1SzSA
 g8X6XXPqT9EVi60a3KS6eWWgYMhyJZ8ZRj+XryNFzhQ6fHOzLArZGUThZb/jCjJst3xG
 S9ZVvY/dU8nnpoL/h44v1lYmFPw9QLrkrHkMuBqnynZ9EcHFlQlkiVwoOQ4qLBmU992r
 f9nQ6Q1Q1fpnOHo/lNewC0KGWj1IE8VtRNlKLBCNMnQ9EVe+UK+tsKL3SPBHOXJCMeFH
 mauaxQ+hP1yORzaQj/ZzpdyFwqZ0WLxc3hwet+PwWmDEdU1KDJgfdeDQ0KEVnw99Pl3v
 A/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668932; x=1715273732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJIohk8gDQsUtWfZD6O/rKhQO02QyqWEocuP7xflwZc=;
 b=Jb0tHozbqrOP1G6/cy4NzU12d4UetdSU3wmmp8cIAGErjWx0yBrndMmq24Rl4n/E7l
 zZzDAcn/07xC4G/bt5J5OWxmRByaGtiwez6jRDKzv2x3kRvGKWaZBT0clMOUqwcuOxOO
 GNKn9toUgijbv/OWH6xx/MHXbveUMP76KIPewvZ32OADwRZT4DQ/0BtG8ohSrTu+jPR+
 U1RppTuYNG4yUsLoF1eUxrf4QSZV+Go50zhuTfxL2/5LA29RppSsE0I3Fx4fJeVb7tAd
 03ppXGhpxAER+3lJovwpDTN9FZxITFcogwCKMeUwo5c9J6+K2I3hwX1WKjU73ohzOk1V
 b5Fw==
X-Gm-Message-State: AOJu0YwrpVHmfEtWb76M/0fMOPHttZDMH7EfSGBAP5HZEFVZDhEMunOT
 o8dr3SjStYNNYeaelmMh065H2su+aHvyTAHalppyEyw+Gem1YmH4HOolrnx7GqvP484uhJ5krj8
 H
X-Google-Smtp-Source: AGHT+IERLgFvOn5triLKvxUnmZpWfW6ihYdh+s/lhxPX1OkJfkasevb1CF4xYSFWGNXR2FHjdWRnJw==
X-Received: by 2002:a05:6a20:d428:b0:1a7:427b:8216 with SMTP id
 il40-20020a056a20d42800b001a7427b8216mr217697pzb.55.1714668932275; 
 Thu, 02 May 2024 09:55:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 3/7] target/sparc: Fix FMUL8x16
Date: Thu,  2 May 2024 09:55:24 -0700
Message-Id: <20240502165528.244004-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This instruction has f32 as source1, which alters the
decoding of the register number, which means we've been
passing the wrong data for odd register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  | 21 ++++++++++++++++++++-
 target/sparc/vis_helper.c |  9 +++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 57ab755ffd..27dc604cac 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -95,7 +95,7 @@ DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dfcfe855a1..c4adc148d2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4583,6 +4583,26 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
 
+static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
+{
+    TCGv_i64 dst, src2;
+    TCGv_i32 src1;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4600,7 +4620,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
     return advance_pc(dc);
 }
 
-TRANS(FMUL8x16, VIS1, do_ddd, a, gen_helper_fmul8x16)
 TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index db2e6dd6c1..7728ffe9c6 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -94,16 +94,17 @@ uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
 {
-    VIS64 s, d;
+    VIS64 d;
+    VIS32 s;
     uint32_t tmp;
 
-    s.ll = src1;
+    s.l = src1;
     d.ll = src2;
 
 #define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B64(r);       \
+    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B32(r);       \
     if ((tmp & 0xff) > 0x7f) {                                  \
         tmp += 0x100;                                           \
     }                                                           \
-- 
2.34.1



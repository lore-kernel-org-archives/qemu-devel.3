Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960E9C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ok-00048V-Eo; Thu, 17 Sep 2026 00:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nQ-0001dV-DD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:37 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nN-0007Fc-HH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:27 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4c7a0so194798a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619544; x=1790224344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3uuZmAeqlgzyZJWRBhaPb6V68dYdvaWjqdouNKupj7I=;
 b=pd65mQoae7Ro2S/xl7xNSL+vfzatypwZWuJJ+2gkH4wp0kqncR1F/RT+TRUlf29J0s
 UeKdh5z0w/DkT1x1/9F35rt4B61NER1hoMTjRO5LV975Fj9/ifogTeeBuDZSuZT2bYWG
 nUs3z6QkHop2J7Z9Z/POOpRY3f71v5X3OTzF5f0Spa6dzNR3BYvVee7RPJJcs42Z/agJ
 IwuSRiDZmtWt/DtIgXzqROY0KfeVKG25es5fCLJa/vD/uJIRsFTG4oUPlLvfuOlqDQ/z
 IJh0RhVJ2fyTf1NiEnt6DK06uFNahQ1Ol9Pf2vyZWh14MmHobCt1pY4ohxdK33tYF4R6
 xOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619544; x=1790224344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3uuZmAeqlgzyZJWRBhaPb6V68dYdvaWjqdouNKupj7I=;
 b=ZjpVdgttX9P8W00n8GBCzPH+BIwcrKw2ikC8CUBnRbRVuHD2PdDB4+fTvsCmrvGOJq
 4+l7qP9hTfuqTICH6KlFAgobNrZ6xxHxUoWkHfCZMT0H7jG08vii6DDzRoTfZPGwRnK6
 2UqXU0WU5ly9FRjXIX+eLW6+0Z2BJ7cuBUqziviNF/GKoT0HY3bdwj56jUHHvQ1QQpOK
 wwvhUoF51Dha2pwOJ+lQKEXOviRFi+u/beQfb3je4XnAxg7bZn6gZi+7GOWJ0x/mbPx9
 x/yYMe3XBVw+1V16YVxBEAKLNWYidbqCBL3g6YoP8KxPigYn39z4emCT6hXpmZukjNQv
 wwjg==
X-Gm-Message-State: AFuF++lhsSzU76mr12qESiWM87EIjDoXphWIeXqqGmS0r6ZWJTpaSyBx
 8vrGgq/wIbrgtuf/vte8GDErZsGIAYHT0YOLse3W5MXqWpqpkJc2CVTqFQoyNyIEe6EBMDcN65J
 +Kyb3Hl8=
X-Gm-Gg: AYBFou2Aj6apbY8T2bJS5xTFftcGsSgXRtQQVK70MpJ725dZtHZxYqB+YO8cvsoqf13
 pFNu5VvnCLUhApaSk2lwWDH9IQIaDdJTZHjOmQJbSI4NY9aNKNdHS+F5qqgaVVMNSdp453pE55S
 RXmYmJO1sIOHBxHfXFHVpEK24CDiC+WAFVI302sXcJLEWUcB4VgZoBmF59qo02E4HW1Jr6ActSu
 l/EUD7iRJ0Hg4eJuvglhOcQj22Xz1NzFiqFDNj9qTGlnl1/G0dLlAS3bfHhya/RNoBw8Z2ezC/A
 W6IhnmsLuHfmqFV1hnatjfhuSYP3IugGCJ1ZizuvgrmEOPHDq3jfuH6HFBYbiM0hmgUQ4VfSJLo
 7lwEObYuFNiRKyTHupW/qAKG9+yI2STjTGkhP7LWU2h1bTpGDeZ9VSsHC5Sdj7Wi4IgvExMYvbe
 RU2jR1MKsL6fZ6Uq9iPlrQL4jw/HblYpKAxBLmXTQulN/RtVUoYwNYRWGp1uCnqM13ILWb5w6eI
 Fmdhx0MmDSHhtEmFA==
X-Received: by 2002:a17:90b:280a:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-39e1e2659a8mr12800414a91.1.1789619544040; 
 Wed, 16 Sep 2026 21:32:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 055/101] tcg: Use signed integer for tcg_gen_{clz,
 ctz}i_{i32, i64}
Date: Wed, 16 Sep 2026 18:27:37 -1000
Message-ID: <20260917042823.542588-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

We use signed integers for all other functions, and the
sign of the second source is not meaningful here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h                | 8 ++++----
 tcg/tcg-op.c                               | 8 ++++----
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d882bf5d0fc..0e8203fd836 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,8 +130,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -190,8 +190,8 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 50d1b07d667..425a7e90e5d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -845,7 +845,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
@@ -890,7 +890,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
@@ -1766,7 +1766,7 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
@@ -1800,7 +1800,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf2670..4e521e44bb5 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1551,7 +1551,7 @@ static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 }
 
 static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i32, TCGv_i32, uint32_t))
+                     void (*helper)(TCGv_i32, TCGv_i32, int32_t))
 {
     TCGv_i32 t = tcg_temp_new_i32();
 
@@ -1567,7 +1567,7 @@ static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
 
 #if defined(TARGET_PPC64)
 static bool do_cntzd(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i64, TCGv_i64, uint64_t))
+                    void (*helper)(TCGv_i64, TCGv_i64, int64_t))
 {
     helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
     if (unlikely(a->rc)) {
-- 
2.53.0



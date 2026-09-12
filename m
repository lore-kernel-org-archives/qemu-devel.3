Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA79C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L58-0000vd-GY; Sat, 12 Sep 2026 06:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4x-0008U7-0F
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4r-0008KP-1i
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2db3305f94fso25829235ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209318; x=1789814118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kw7QVvGf0qytBZY5yO/jheIKQcZigTRvvdCo5Ik5gTc=;
 b=wGhnEnTjsWVSKoGT4/sfNLfG5dlcpZKTVhBe+WkhWmTbPKmc13FakUv4RlvjCyp41A
 iAOnjqhNt+CbTgoP45uKN7xBSslbnK4ufX3HtsK/t2M4XmLfMKHUNBUm+z8kPJMpzt0O
 wj4C7kry3qfD6/zTQ8Iw2wgR/ewiBZJTf3IgBZOBccYvhj+DAn6xiUS26GuN5svdZE5p
 Y+4J9BbT3JsDIjCIyUeT9U6KhExrO/O12Gozon+FQ3UKnv77HTXvTHNu5X+o8LtgXoim
 EriugKdu8cY5vuFD0Rza6i+asCFHf0PPs1iGjCrs/EIS+GA7hu8AXy7MbRzZSUEKyjLz
 ARew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209318; x=1789814118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kw7QVvGf0qytBZY5yO/jheIKQcZigTRvvdCo5Ik5gTc=;
 b=TQ+96rCgUT1wBh1kqgEpHRVYOcrbaTMfDXY7NZBATttwYb0nNQMl9pJEfPVdAAUVt7
 72fPptyNee2uMGoBKvdWGISyrWa8SaOzxfVuICbmF9PnPeUEyeGGGKb9miYD5ohzmce+
 sW2aF5lOlK22+/H57T0wJ9MK3Hg+0AOsAoXmCbZPwy4ZLhhcv9z6VYkozFrgUNL4IXiZ
 EwlBNfAz3gZ65J1nHdCj6lEKZBVrhFF56n36ffqJYRJQcGTPiHOHHJU75RUOhSnD30pb
 1U/4SLWh5fXEHuxOJnFYR3SfAO3haCWYhRNBwH5WErFZFkMWKQQYWe5Isx+UEkGIuKRW
 aEQQ==
X-Gm-Message-State: AFuF++kQqv5YG2iugz8GCn6vNNCEGExr5w70U5J1GJHkWKlH2h35zY/i
 GuqPtoymRwL2FXmjLPYN1G8ZaFSOgk8mLg6Z4cU9tg0JZJSNflWr4gkDfFH4WC31EyDv/jkcjpo
 ENPnzyzY=
X-Gm-Gg: AYBFou0sdTxHOsaZbvep+Az+sUCGjwO07NJbXijvX7LGTfOWIRQhfolzQid4D01Aoij
 itRKDnyM+Qp6IdfkLemRcitB3XUBHkKlp4MTkHplOkGKs2ddOLKZJGSRmpivbM8OaUqV0O/mrNl
 TimOUFnhhr7Z394HgJmxgw6XLBVEmoc8WhB5shR/JAYpcUYdRcI+vFhDD9IF14glDW1ABJ28uRM
 qtxzBpjDEnP/IO1pBt1zq7YORcXxVGsmTna8irtWvvUxTPl0dJzCJM9LKh4/+Vlx2FQK2MMbSas
 CEvqQIHDHgYd0CG7e/qsODp+CjvF+PDgpjnTwHaz/5PQQDbYKF3rDPUyzCksCHWC6R7xEpILqsx
 ylZrK/G6nvM2g62ghgO1MAXQn+t+XSqEjlkkh5sREZ+NZnB/J2cd4jYSzXQNzsWJpMS+MLBNTd+
 E8eqh4BY2AJ3p/f2j8RhM6mrICmraUTK5tXaz+jgOLOz2ZM8oLBASc5Zr4vp9uC0JpsjgXbJW5A
 D5NJVQ=
X-Received: by 2002:a17:903:b87:b0:2dd:278c:5eb with SMTP id
 d9443c01a7336-2dd2a336a18mr129376965ad.14.1789209317842; 
 Sat, 12 Sep 2026 03:35:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/82] tcg: Generic expansion of tcg_gen_clzi_*
Date: Sat, 12 Sep 2026 00:30:54 -1000
Message-ID: <20260912103126.598030-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1a58971d211..86922380019 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 8538f7350aa..30288a01327 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -15,6 +15,7 @@ DEF_RR(neg)
 DEF_RR(not)
 DEF_RRI(addi)
 DEF_RRI(andi)
+DEF_RRI(clzi)
 DEF_RRI(muli)
 DEF_RRI(ori)
 DEF_RRI(sari)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index beaa9024369..fd8f93f4bde 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -476,6 +476,11 @@ static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -873,11 +878,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
@@ -1794,11 +1794,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
-- 
2.53.0



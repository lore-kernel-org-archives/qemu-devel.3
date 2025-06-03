Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9A0C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMim-0000yn-1c; Tue, 03 Jun 2025 04:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMik-0000y5-BQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMih-0005VJ-Gj
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450dd065828so24906785e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938201; x=1749543001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EduPdK0hs3KdPLN5zRRNqJ+RcugXH4jp/mLgIRGtCBk=;
 b=YQDduJ3FL2O1SvhlfuMwNt7L/R32/BgD6G9ns5+5Denx5G6cmrnngZT3RB7RPcN+XH
 jUc9Est95P9Tbqz8Q9mRTIejoPEAihYn49otrYNNQ6zVBpCAYq8z0+/q40trzndMAKd8
 erqoFlDGhl0zvZqH/m0WW+4+zf5paUxAEMW3Hc1jP8xs/eh3QyeHbZahtEjiBPg4E0fg
 Cntd18Glhqh8z9hGu6feDsSOmydkhPmbOUGpFkLItW50Fi3pFVDW3gIAhQibTzmdhiJR
 V60Ss5KEeirdYHgGQ6MNphCrSPCKpUeC0PVgj/e3lT4k/A19T2Nj0cKvZvIKzyld5KUG
 okXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938201; x=1749543001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EduPdK0hs3KdPLN5zRRNqJ+RcugXH4jp/mLgIRGtCBk=;
 b=nQcrXJkFlzsVBo9e4HHRciaaF+BR82HrAluxxjzu60ufHlyUQj6Fk0wq0+zojRoFqX
 UytBAfOFNL5nJScF4nj32Yd5uZoFScs8M4wAf3YaKbfK6Qqki4ZcSVAEOoTqZIhB3Fb0
 tK+BBHk5P+AGk4oCtUxYeUt5lQb5lFgxOUEsjrZphSl5f/JSTYKNdf9UT0LCD+JO6mxF
 KF6k+wWBdzYAf4EF0aJE1QvFamMT2ydIFYUa/wQ8nrqRihAGiDaCvi8Bf+Oh8AKN1WnY
 hL9pfUnW/8sd9QDjH2e/ybywDQrJkYPjjrYuUkKGhFBXGbWxPPgkA4Lzh5BkzIJ2BUPx
 3faQ==
X-Gm-Message-State: AOJu0YwffBFnWhHkAg6vaa9pJTdwbBbh5lhbhe1wKRhcsP5/yQnXuGZT
 nz/r6Q1i5D9OweohbIn4HcK5KtonvRcBCFcAaJZLyDrCWvBulSKx3nCkjNH99gfDABIZD5GtM6/
 JYXynQnw=
X-Gm-Gg: ASbGncv5PZDtTvuUCstlwwAR24MhqyNOpqL+y5IHwOIJn7XMWsKQUfdWifdpMQ390Pr
 JQLtmLxYgq03Ww0/w4FHl1hX5lIT+ptJNo8f0AbdvbZ/sbmK951V//R6R+nHMkvVhXR4jUB2NBt
 ZzhxzcT/ZLnMZ4Av3LENPf+7atG2E5VuYNiwUWFh1FRplepYsBlB7HQbOqr1Auv0HybAuWP+ijF
 IUx0lf1V1SeEleDz5TL6ftEE5tMQmBliE8a3mE8Zss5C+ia4Nyba2UGtB9jPllBBslaykqP9QxB
 /y+od7zeSvltrpVKX0FNmOpqArnhaVy4LOU6YCqZAHEy4oswsgJJZZGlZD7CXBAaasi8zZFa9BU
 aRHt5gn+qKCLp
X-Google-Smtp-Source: AGHT+IErwip+41mrFPPjsBM+FQ6xzfhDo70Db7vAonu4lMT43MxRHRcUW/Lucpq6qN/QxJPIxLhkSg==
X-Received: by 2002:a05:600c:468e:b0:450:d00d:588b with SMTP id
 5b1f17b1804b1-450d8819daamr157569765e9.9.1748938201604; 
 Tue, 03 Jun 2025 01:10:01 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 06/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_eqv
Date: Tue,  3 Jun 2025 09:08:47 +0100
Message-ID: <20250603080908.559594-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 123734b167..6d35a2e58b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1093,6 +1093,12 @@ static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
     return true;
 }
 
+static bool fold_masks_zos(OptContext *ctx, TCGOp *op,
+                           uint64_t z_mask, uint64_t o_mask, uint64_t s_mask)
+{
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, -1);
+}
+
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
@@ -1916,7 +1922,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -1946,8 +1952,12 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
     }
 
     t1 = arg_info(op->args[1]);
+
+    z_mask = (t1->z_mask | ~t2->o_mask) & (t2->z_mask | ~t1->o_mask);
+    o_mask = ~(t1->z_mask | t2->z_mask) | (t1->o_mask & t2->o_mask);
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0



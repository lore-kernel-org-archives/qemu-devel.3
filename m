Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084A9E8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVOF-0000g8-2h; Wed, 04 Feb 2026 00:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVOC-0000fc-Qx
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:20 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVOB-0003In-8i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a90055b9e9so1775815ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182718; x=1770787518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxW6ZiuEeW+vZBq1IBt0ZaD6GqcKeynApzi+LWFfJmc=;
 b=SFS8+4BvJied8Tyl6kazA6sLAZui7cmkoUv03SlfqgY8XfHqFLUifBOgMj5UE/Ig/T
 SkgGFqsVr2bkamf1btuk3hubQynOTEld1TLOugIfkUsN+CQmXOKa+btUWYuX3ZmhBYmA
 iw87b7fICt35phx1nBkV8IGX0qL9xPJm7JEumE5J6trq09v3y5/qHE0db6uMvuqOVErV
 DpCkrBFrLwQBrscAMEWrAezCdwoSd0WNV2SMLx73aCXs18fqIqY+UnKL9uZ0vCg9QpmM
 a3odpmc0ltLtzMEYrLECt3elDLBJGXp4tP91u64L1VliKIA5zBPE2SBuroFHC5xfKPnb
 6xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182718; x=1770787518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxW6ZiuEeW+vZBq1IBt0ZaD6GqcKeynApzi+LWFfJmc=;
 b=bfp7HDtlDAwPif8gKBW/t1el19uHfZRYDLdHkvvDAC+xJlL7ZrcxsnXcH06A9ewdvB
 pexjD7KTZPiNyhNv6ynW9ORPIagUaPTClwvaIIU5jKDNP99Ra4vHdBY9YW0NaF4m5ns7
 lSVRCCXA6+kwp3dK5IZO2NMxm7UF8Mja8ql4uuFux3UF38r9urin4Cw3APuGt0iI1VE2
 7ibrJduutZn3ujsoTRLXPua7tuJ00O31jyNheNUb7av3pEZQCdT/7wjZ8BPQ6x/a2RXx
 K4bn/R6VihR7O/9NyB8spiqjhWS5Qbbos7N0UBxt9AU2ImO51ZykAdmidJY5eA4xVHnn
 iSWw==
X-Gm-Message-State: AOJu0YzDrlfEb1BVQ3Na9BDPAK7UOKN+DqCDNpqnB88D7WvmUBgPUJYF
 VSGTKm0ddZ0PjKaDjPxuml9qFeeHi3shJr0M8BKLMqIxZmfNwNV4W3aSWlYdU2MXJRDgZlVe+cP
 oN8wPuR4=
X-Gm-Gg: AZuq6aJvwPz2hNwwcDpcroo8NfuHLsU8Ir2/BJoUvZGGd8sf9Dsczn2ghKoTn75TRZ8
 w0JBmHfvXQoEYITMU6+A2rJ+4dUFjZUkwJz0Wtq1w/aNKetGmpjIfmR1qL7ldFRtw2cX6FxqlPY
 XbpebR/M26MQQB6z3JApUYXln52lWufDDWqUgTvi5ETNjjxUSHyPALvQgyWWsSXg6MVwIqWN1Ky
 b1p4hS/QrVeRd1o8daDGllGH7HtKxNiPilK+uMm2KhcxUz0ObdhpQN8arKSIvXKnxEWSeTa1CUR
 xxuWSETRC274g1owOU7BbqdVVDXfrfAA3AF9jYbo6m7GmqLS+1t91nRmH6EFs3qXOTBbdEsDnds
 V7NR3c0sRgUf5eEVLMY2ltAwk1UzK/mdy2nrps4lNWt8goECQsjAKHSvxeHXBDpN/+yJc8HMnKt
 LOBEqlEv8MEEOqkHZGhWml+U+tIrAnJUNzdFKOkxdnkhM2ft7MqFd2BxycS9I=
X-Received: by 2002:a17:903:b47:b0:2a7:c340:4c3d with SMTP id
 d9443c01a7336-2a933bb8b15mr18895755ad.13.1770182717772; 
 Tue, 03 Feb 2026 21:25:17 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero with
 shifts
Date: Wed,  4 Feb 2026 15:24:56 +1000
Message-ID: <20260204052456.970605-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204052456.970605-1-richard.henderson@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
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

Use tcg_op_imm_match to choose between expanding with AND+SHL vs SHL+SHR.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e6a16921c9..2944c5a748 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1743,10 +1743,17 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
             goto done;
         }
 
-        /* Lower invalid deposit into zero as AND + SHL or SHL + AND. */
+        /* Lower invalid deposit into zero. */
         if (!valid) {
-            if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len) &&
-                !TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+            if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+                /* EXTRACT (at 0) + SHL */
+                op2 = opt_insert_before(ctx, op, INDEX_op_extract, 4);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = 0;
+                op2->args[3] = len;
+            } else if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len)) {
+                /* SHL + EXTRACT (at 0) */
                 op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
                 op2->args[0] = ret;
                 op2->args[1] = arg2;
@@ -1757,14 +1764,29 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                 op->args[2] = 0;
                 op->args[3] = ofs + len;
                 goto done;
+            } else if (tcg_op_imm_match(INDEX_op_and, ctx->type, len_mask)) {
+                /* AND + SHL */
+                op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, len_mask);
+            } else {
+                /* SHL + SHR */
+                int shl = width - len;
+                int shr = width - len - ofs;
+
+                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, shl);
+
+                op->opc = INDEX_op_shr;
+                op->args[1] = ret;
+                op->args[2] = arg_new_constant(ctx, shr);
+                goto done;
             }
 
-            op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
-            op2->args[0] = ret;
-            op2->args[1] = arg2;
-            op2->args[2] = arg_new_constant(ctx, len_mask);
-            fold_and(ctx, op2);
-
+            /* Finish the (EXTRACT|AND) + SHL cases. */
             op->opc = INDEX_op_shl;
             op->args[1] = ret;
             op->args[2] = arg_new_constant(ctx, ofs);
-- 
2.43.0



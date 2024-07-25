Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D783DC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MJ-0001GH-QO; Thu, 25 Jul 2024 19:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M8-0000oI-Jj; Thu, 25 Jul 2024 19:58:46 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M6-0001cv-L8; Thu, 25 Jul 2024 19:58:44 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so293892a91.2; 
 Thu, 25 Jul 2024 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951921; x=1722556721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naPSdzkvhaTRmj8A7vk/OXZ43J641gE5v9nRWII2ceA=;
 b=jiy2EChE6dl1DnocL7pyLFnbFsRz4/vKVd9xrIFvPSpOfam+WkJsNhV00siyFMbhQd
 x4lCWvlVferxbYmurmrI/tOEjCDBfrmnMqel8QhTn3mv0ryn6X1W6G1sOI7mGQfQezxe
 PteVhxgmGue2lxtr/BF5sJj6Me23Lr43KFxJJLA0SS0Ppnqxue09DwfRg7ZuYjX445Pk
 2cn15Rpo1LCI0FJvv5QODhssjrlG01yrurfmI2RuhRz7i8pYRubSkx+sbmF//Zesz1PN
 nkvsG0IKZ79psoHOLQ9N2UDFyCLCKZs8UGRyN7yvEGN/yMnUq8ViVuOgEQoYmLRSqTDp
 I9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951921; x=1722556721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naPSdzkvhaTRmj8A7vk/OXZ43J641gE5v9nRWII2ceA=;
 b=X0WtWbWk+nTZZthNkUVlT/9ITkZVeC7yOTN3JFVbVP5S7uNo/w+sMCGph/nrsAhl2M
 Ku+msYmxrLQvX/mN4nIftIXzKtm3qFQCr8w8BkBltYsO6trHQxNeasd2Pe8XaLEejlam
 07jM6d1Y55FjpI0lxAQbjYDCwwidoOV63g5f+6rrYhB70OxvJe1KdnGZU/24T9wAgHEO
 2YrMW/Pr3ihPdXxdKbAdbeYEaa8OTH29jDZ80nF5Mu7YOfQMjbLy2sYc1VuOhFQktoMf
 tYh05yW8OGRsWjw48D9DqCVY0kDMmjxTTGhZFJqADSV85pNVrUl2DLx8QAlsTGTPrfId
 0OIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzBEqAox2CtSMWmrWco7MoAaI2FAhCFXpUACsGCWNI51JC24shqurAJz6/uGd3T55iPhEtQjBdDJFnMDSC5ifBw+lE
X-Gm-Message-State: AOJu0Yz+OpwTzeUiJSQgDsvza82YcriUNv0Du9nbal+cFCfGeI+FZogw
 wFzuHYc2PCWpftG90+XCim7GYmF1yxnHsYp47DLoxcB7v8xzvVlhD731WQ==
X-Google-Smtp-Source: AGHT+IGsdHXyKvc4JaMOAPSIZZAGsFpNqTRZeoXJs061Jo0nZWDInFpXlDvfJMX7vv6FuT34xu/XkQ==
X-Received: by 2002:a17:90a:520a:b0:2c9:6aae:ac08 with SMTP id
 98e67ed59e1d1-2cf237a29f6mr5536545a91.17.1721951920648; 
 Thu, 25 Jul 2024 16:58:40 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 72/96] target/ppc/mmu_common.c: Simplify ppc6xx_tlb_pte_check()
Date: Fri, 26 Jul 2024 09:53:45 +1000
Message-ID: <20240725235410.451624-73-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Invert conditions to avoid deep nested ifs and return early instead.
Remove some obvious comments that don't add more clarity.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 43 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a5ae11394d..28adb3ca10 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -99,31 +99,26 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 MMUAccessType access_type)
 {
     /* Check validity and table match */
-    if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
-        /* Check vsid & api */
-        if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
-            if (ctx->raddr != (hwaddr)-1ULL) {
-                /* all matches should have equal RPN, WIMG & PP */
-                if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
-                    qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
-                    return -3;
-                }
-            }
-            /* Keep the matching PTE information */
-            ctx->raddr = pte1;
-            ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
-            if (check_prot_access_type(ctx->prot, access_type)) {
-                /* Access granted */
-                qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-                return 0;
-            } else {
-                /* Access right violation */
-                qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-                return -2;
-            }
-        }
+    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
+        (pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+        return -1;
+    }
+    /* all matches should have equal RPN, WIMG & PP */
+    if (ctx->raddr != (hwaddr)-1ULL &&
+        (ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
+        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
+        return -3;
+    }
+    /* Keep the matching PTE information */
+    ctx->raddr = pte1;
+    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
+    if (check_prot_access_type(ctx->prot, access_type)) {
+        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
+        return 0;
+    } else {
+        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+        return -2;
     }
-    return -1;
 }
 
 static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC129C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8M4-0000Yx-8t; Thu, 25 Jul 2024 19:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M2-0000TI-3C; Thu, 25 Jul 2024 19:58:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M0-0001c0-Bs; Thu, 25 Jul 2024 19:58:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70ea93aa9bdso354338b3a.0; 
 Thu, 25 Jul 2024 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951914; x=1722556714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYJbTtKocMlV5G6K8YUjMXMGEB4/lAQjLTAOrmm/oIg=;
 b=kzgpI+PYNoro24mtI1l3XIZsIfoX/lzzDe6i4AjZOvW2aiynlhWZqV0q/bFmQh9tfJ
 bht0wRGk/EZ+VWuuhl6ompXEaPiGBpcGOdVa+Lnm9/5ZgoQVuekR+Y/etqkpKmRRy/bn
 lWanS2msbP4QYxbz+MQel4x+EyOVS8CuMMsaZIIaJz3ifY9M6HDcQTtXdr937kbkXjP7
 fucrE+i6I1wvQr0lK+sLayP1vjHrOxHV4LAd9QdRBTp3bzMgLbMMk+/iMp9EtO+nq7H4
 2l80oeLsYgB1T/ee+dAS6E0BO77ylWknHwoyzsKotWzhKOcYFsoPX9QyTi72tTKuGU4/
 Rt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951914; x=1722556714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYJbTtKocMlV5G6K8YUjMXMGEB4/lAQjLTAOrmm/oIg=;
 b=vxdNuHOrPEvbkRgO2ZXtUl9k0Mkiina7bjzSGDJDkZpHIUwVTcoXOHypWw/aUOaz28
 E1HTzvfB2NOnCo4ZSrc19C/Tx4KWrKKKaNr3zUS+uiNObq/+wa1baFyz7ePn4qXR9vDD
 N2nH6XzfVTeE047gp/XnyEgsUAJSggp95VinWV8a8GHWqcMBOum6YOJRBEZl8ouxnhcU
 1hZm+pZsCyiX+z3NtZLYmviTXU6b8UyWWKRSSFf5yJH5B64jfl7ob2I93gdRxcMwwhsV
 AfITGQz4vA0K16nvvdwvIF1mG3qZKvnCSH3ZBGyVCIHNOTw3lJZBWI3yc5oKcbq4VgOP
 Wj+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVByklHXvRiLlKCM4DViVw1mDkyM21V1YZ1U8ugtTkasuDv+0WI+k08FsstbW+z2OK559iABy0OnQVsj0IhTCCiw3mr
X-Gm-Message-State: AOJu0Yz0I3iWsHlf34p33y7GVRsedV11lgBCV50whGTcb6PHA0h2Vrx7
 lcGWwZDFk6nhQGTJQQ4Rqu0IyrygoxAQBsaX0vmkri9lgBrar3EA2CqJMA==
X-Google-Smtp-Source: AGHT+IFyXw1QVaMBVI9N3UFxuWxBZliXGdJcPrjMORoMPpBQAIAxDvpl5c/dwWxSXwD6YrzGBBHAhQ==
X-Received: by 2002:a05:6a20:c70b:b0:1bd:2cea:f6ee with SMTP id
 adf61e73a8af0-1c47285e3e7mr4912600637.27.1721951914344; 
 Thu, 25 Jul 2024 16:58:34 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 70/96] target/ppc/mmu_common.c: Remove yet another single use
 local variable
Date: Fri, 26 Jul 2024 09:53:43 +1000
Message-ID: <20240725235410.451624-71-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

In ppc6xx_tlb_pte_check() the pp variable is used only once to pass it
to a function parameter with the same name. Remove the local and
inline the value. Also use named constant for the hex value to make it
clearer.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b21f52290f..799d2ced9b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,13 +98,12 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int pteh,
                                 MMUAccessType access_type)
 {
-    int ret, pp;
+    int ret;
 
     ret = -1;
     /* Check validity and table match */
     if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
         /* Check vsid & api */
-        pp = pte1 & 0x00000003;
         if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
             if (ctx->raddr != (hwaddr)-1ULL) {
                 /* all matches should have equal RPN, WIMG & PP */
@@ -115,7 +114,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             }
             /* Keep the matching PTE information */
             ctx->raddr = pte1;
-            ctx->prot = ppc_hash32_prot(ctx->key, pp, ctx->nx);
+            ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx);
             if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-- 
2.45.2



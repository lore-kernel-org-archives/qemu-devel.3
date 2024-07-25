Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEEFC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MN-0001UC-SC; Thu, 25 Jul 2024 19:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M5-0000cz-55; Thu, 25 Jul 2024 19:58:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M3-0001cT-AS; Thu, 25 Jul 2024 19:58:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso364619b3a.2; 
 Thu, 25 Jul 2024 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951917; x=1722556717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6nfklDGVUqP2PKA9q1wSbyX8COk61f+cykQLu5kMNo=;
 b=DpB//t5vgRVJldHv/vYL8aFvE6Uv3Oa8NMU0GRPFGITCwneISRsli1LTjkwc6Um7vi
 15VH8H5yrZoh6vt8+9srdCLbn2ES7b0AWxei94RVK0d5U2R6ylH6UaLDpJfNiFWSNxlc
 PAIgVdXod5bctVYBI/vM4Di7158vYh2+n0kCMefUT/N3XKnXqV30BhteIgSwcbjRZTCP
 Ss5niNtHm7a3bA7lmNjzuG0oEluZJw/uXMi/0qMPserZBoNxQZuoLHfmzvCM+cHyVWSm
 qLtrysNi4N5elba4E7VsEJOCw/LAJHPgf2ELOHCByrN8fdx1iB6h2tOmVaZbvlKRZMvF
 JDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951917; x=1722556717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6nfklDGVUqP2PKA9q1wSbyX8COk61f+cykQLu5kMNo=;
 b=ap0X3SeI3DIxvmG9Jme0gkNGETF/v5aL/RO/03pSf36SMJYXZT4Ff5IocSP4Ti9SRa
 3+vy1M6rtuuKN7CZVjh435kS1l0kreXXp85HjMKWLR6Xcd8x8eJ3G2TVOYxtSqrXACPY
 RYlEPbUSVtuUuqUBtrsAPUOv068aJnInong2XN/UX1k6xVMH/HXjXKhClie0i89YCHw6
 SiXSrOm911k+R5eB+Uy34OnrdejYPwLgWI/+rpZmrlBdkjUhc2524qcdvMVaBX2dXQd4
 6/gT/uaqQc4DeyiGrxqllWpyqaPZveQPnb/uGFLB+aE/h4AiwaGHu+wpsi26H6YCumsB
 3KZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJ3PgrVMrmsXAVAAythsi2DiHRHCNscNwB8w9Ww8Syzmd9wyjjre5UdU00lnbFptfHiVwU0Jfdru4i6gW0rDYHcqw
X-Gm-Message-State: AOJu0YwY8dGtsy8FdsC6vZpR13NIOVd024muAefSJb0c5Mwmd68+QtOG
 bYVL/87M6NDaTWC90nau3O4DF6SWUGgXcTU0CKEp8KTcyHky6mzE5ON5yA==
X-Google-Smtp-Source: AGHT+IHgI13AP/6EllF6THwIjrrYi7Nc4BoP6eYYuJmI734Zn+KMAFh9ubv/cFZT53LdKyBocwAp9w==
X-Received: by 2002:a05:6a21:32a3:b0:1c0:e54b:5651 with SMTP id
 adf61e73a8af0-1c47289f004mr5468833637.24.1721951917423; 
 Thu, 25 Jul 2024 16:58:37 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 71/96] target/ppc/mmu_common.c: Return directly in
 ppc6xx_tlb_pte_check()
Date: Fri, 26 Jul 2024 09:53:44 +1000
Message-ID: <20240725235410.451624-72-npiggin@gmail.com>
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

Instead of using a local ret variable return directly and remove the
local.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 799d2ced9b..a5ae11394d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,9 +98,6 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int pteh,
                                 MMUAccessType access_type)
 {
-    int ret;
-
-    ret = -1;
     /* Check validity and table match */
     if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
         /* Check vsid & api */
@@ -118,16 +115,15 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-                ret = 0;
+                return 0;
             } else {
                 /* Access right violation */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-                ret = -2;
+                return -2;
             }
         }
     }
-
-    return ret;
+    return -1;
 }
 
 static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
-- 
2.45.2



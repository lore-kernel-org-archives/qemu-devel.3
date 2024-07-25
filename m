Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387A0C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nd-00081d-Jg; Thu, 25 Jul 2024 20:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N8-0005np-Fj; Thu, 25 Jul 2024 19:59:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N6-0001wc-W9; Thu, 25 Jul 2024 19:59:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so315615a91.0; 
 Thu, 25 Jul 2024 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951982; x=1722556782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PetIsmnUlhClflxRVIROa6IgPnq0DtxeztGXxhCMqKs=;
 b=H5hzl4qaRCbVVkn/CBb2EgyOjw8hfgxpEw9Hnt/olSbizjA4WoZvJW3vczrOwsfbYQ
 Qf4YmYnYvbfQ2r434muN06e7ZI7RoK6fXgPPcVuZJSbxc7sDDq8XHFmJQjyKGaUI2Qbm
 5Nw2zUGBOS7FijFipHKs5nFFlmvxUw2elGxNRPVCzauewT1GmhyxGxg73aUr+Z611n/x
 jwlUmi91YAoHMPEgqyp/FpTdKQWSArchKjtrIfqrAShU4g95XZknFILsMpSXvehwDUIe
 BrSU8PSlZUdkjOi4CYkLlt+zzTixaZ6wjgy7DlVtQPGXeLKTsLXXGRZk5vhvWaHhWZhX
 Wt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951982; x=1722556782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PetIsmnUlhClflxRVIROa6IgPnq0DtxeztGXxhCMqKs=;
 b=rXVsD/g1lcvaEY2sgVY2CgmLHH0yXAi8NWVDJEDRkOwFzflCtFzeAojoh1evxjKJ2b
 LzytbjfmUo5AKFDoTtYcRsFW6I5kn5pKgyyDwMGQmRRnDRFdG+hFbHPPsvmDpQfm3BsM
 58a0PJ7iyUJ9zGzm6aDbQaHU88MkMHhgLT8ocs0/+FYKDdLXxHwK2zmrr8YUaouu1tit
 6sZXFLFFw3kxbLkEXXbCt+ug+W87J4ht314tUYXBLD3RiycFsgaPMAZNMdunvDbWfamZ
 R+yjCqpBtb3wItmOPCpd+JqIJm7x82oecSMWnHg4t9Dk9Ah6ekF1eWEIFy+vLHD+QMie
 cc9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIFgBijyMZaG4XpGJpNhGS10rQsvoqWRZ4PKMi0kMKhHYGK1hm1aNkGxauoSngQ/mIaeKbF5J5X8Bjte/WcDSlhNVw
X-Gm-Message-State: AOJu0YwyNwfP/KekkWox/rAjwSWDC1gBvZ6vEuodkz6Z+MZDto2lxQQP
 KsfXObYJxMUdvlGLuin3lficTTFLWpZuGMub5FYbsWarOkw6Wt7BSeRR9A==
X-Google-Smtp-Source: AGHT+IEbpVOquXCFhabAd8DgtnCFKfDXM789Vwyh0Og/oVtWzUrJNzrctXZkteUSHF+gsFtZejslyw==
X-Received: by 2002:a17:90a:ac05:b0:2c9:6514:39ff with SMTP id
 98e67ed59e1d1-2cf238ebb83mr4776722a91.33.1721951982157; 
 Thu, 25 Jul 2024 16:59:42 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 92/96] target/ppc/mmu-hash32.c: Inline and remove
 ppc_hash32_pte_raddr()
Date: Fri, 26 Jul 2024 09:54:05 +1000
Message-ID: <20240725235410.451624-93-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

This function is used only once and does not add more clarity than
doing it inline.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 6f0f0bbb00..c4de1647e2 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -298,15 +298,6 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
     return pte_offset;
 }
 
-static hwaddr ppc_hash32_pte_raddr(target_ulong sr, ppc_hash_pte32_t pte,
-                                   target_ulong eaddr)
-{
-    hwaddr rpn = pte.pte1 & HPTE32_R_RPN;
-    hwaddr mask = ~TARGET_PAGE_MASK;
-
-    return (rpn & ~mask) | (eaddr & mask);
-}
-
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible)
@@ -440,11 +431,12 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
              */
             prot &= ~PAGE_WRITE;
         }
-     }
+    }
+    *protp = prot;
 
     /* 9. Determine the real address from the PTE */
-
-    *raddrp = ppc_hash32_pte_raddr(sr, pte, eaddr);
-    *protp = prot;
+    *raddrp = pte.pte1 & HPTE32_R_RPN;
+    *raddrp &= TARGET_PAGE_MASK;
+    *raddrp |= eaddr & ~TARGET_PAGE_MASK;
     return true;
 }
-- 
2.45.2



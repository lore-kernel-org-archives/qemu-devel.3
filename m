Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FF0C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHaK-0005f6-Dz; Thu, 23 May 2024 19:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZb-0002Tr-5n; Thu, 23 May 2024 19:10:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZV-0005sQ-HW; Thu, 23 May 2024 19:10:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso1994092b3a.1; 
 Thu, 23 May 2024 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505801; x=1717110601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYRG8Z61ePU1sJn12EJuSOfM6DkBZ12r+JDVk0W/peM=;
 b=dA2SXOnd1ELdh2FB1MyiDJYvvaFEw5H09lNHLQVEf1iv3gM4fe4yUf5M6ODzJ9ktAP
 Dc5iZ5Dp1SU/HwgfvvKRrLUx+/ehL6RV8/R8o6yxv+DNDd/ZsK3OTZOTCZurK1U+fvEY
 QoGXb2IomI77dfDRdnG0N8SWl3bABf9hGrbAbwhxAgOaMnEyr4vfy7tN2qxQo+BWF5eP
 FPKmcHm9JthNnKg2T+Yk6U7W/OA4UHHBbUy15zAZySp+L18mkMuvaQdb2yhFAEA85zLp
 IB8Ma5SBDHgb3sZivUVrdYXoyVpIf1bofXCjlfrfs2f5/aLkzJTDnS9oIPFcn/Y7zoOG
 nO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505801; x=1717110601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYRG8Z61ePU1sJn12EJuSOfM6DkBZ12r+JDVk0W/peM=;
 b=DM4Dbq3mMyTqDAZPvg2aSvF70t9q5S4l+bSz5VOSM7k2ewRi1zKHCPVCqfIpTBeV4g
 vvFkVHIaQgD7/Xuovpgdo7ubtWLaPkJ/HXT1DQxPFBiY8EwJdU43X9HU7VE0HL/K2UXy
 tfi/V+LOlcEaZCp/CC9g/9UjOWFq7q3Xgv6QyG50zpY/uspecfvybotMdLo4YNFhxZa2
 zAX48xJWCQyLVODI4pAGSjcKtASjZjN6l5AOy4dqkCTFjwoLSj5YdMDP6GDVC/XOdsvS
 P/6NjLSvJJrdm70OFZCW/q0YTSmVo+7z+rSwMg7MLceJmhBLuAOZo40tElFWoOxYGFD/
 f/uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi5dxtVWu2OI1BFzzWNjTASxZuGRldSpWew33cl/m2RvQ5OjmBdQcNlylHpyNyfAV7iqrwbdy3j0pDqkPY20yB9u4r
X-Gm-Message-State: AOJu0YwpfRO5rcLoGnazswulOVZ3X1H2WzApDDhuTUbMTh8B7y5trPzn
 5iVEKgKSnOEQWfrcSrew9hTFgfMnCPlDnX9XA5zv6mZ+8TuYRD9dC25qMw==
X-Google-Smtp-Source: AGHT+IEZlhSNLRp9ntx3ik3LGgiSoVfOHd+yLVqIntWj+hTepdSr+qCBxgN9hpC71kH663vq7VVuyw==
X-Received: by 2002:a05:6a00:2911:b0:6ea:ed87:1348 with SMTP id
 d2e1a72fcca58-6f8e9fc03a7mr969939b3a.13.1716505801627; 
 Thu, 23 May 2024 16:10:01 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 40/72] target/ppc: Remove unused helper
Date: Fri, 24 May 2024 09:07:13 +1000
Message-ID: <20240523230747.45703-41-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The helper_rac function is defined but not used, remove it.

Fixes: 005b69fdcc (target/ppc: Remove PowerPC 601 CPUs)
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h     |  2 --
 target/ppc/mmu_helper.c | 24 ------------------------
 2 files changed, 26 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index dd92c6a937..76b8f25c77 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -701,8 +701,6 @@ DEF_HELPER_2(book3s_msgclr, void, env, tl)
 
 DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
 #if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_2(rac, tl, env, tl)
-
 DEF_HELPER_2(load_dcr, tl, env, tl)
 DEF_HELPER_3(store_dcr, void, env, tl, tl)
 #endif
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index d9d950e220..d4388e66be 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -596,30 +596,6 @@ void helper_6xx_tlbi(CPUPPCState *env, target_ulong EPN)
     do_6xx_tlb(env, EPN, 1);
 }
 
-/*****************************************************************************/
-/* PowerPC 601 specific instructions (POWER bridge) */
-
-target_ulong helper_rac(CPUPPCState *env, target_ulong addr)
-{
-    mmu_ctx_t ctx;
-    int nb_BATs;
-    target_ulong ret = 0;
-
-    /*
-     * We don't have to generate many instances of this instruction,
-     * as rac is supervisor only.
-     *
-     * XXX: FIX THIS: Pretend we have no BAT
-     */
-    nb_BATs = env->nb_BATs;
-    env->nb_BATs = 0;
-    if (get_physical_address_wtlb(env, &ctx, addr, 0, ACCESS_INT, 0) == 0) {
-        ret = ctx.raddr;
-    }
-    env->nb_BATs = nb_BATs;
-    return ret;
-}
-
 static inline target_ulong booke_tlb_to_page_size(int size)
 {
     return 1024 << (2 * size);
-- 
2.43.0



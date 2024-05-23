Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DECC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb1-00089v-5C; Thu, 23 May 2024 19:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaG-0005Yo-G2; Thu, 23 May 2024 19:10:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaE-0006Fj-RN; Thu, 23 May 2024 19:10:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so3424728b3a.0; 
 Thu, 23 May 2024 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505849; x=1717110649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/djUxjESZd+LBg4jTRVR14hXFqJadJg1ng6qqnC0kE=;
 b=X7D86bO18+D+GHRaeIY8um8C+Met49VdWxubJbci0W6VJLAUHBmSF2j+KoSxRRBHIb
 iMFATgpeecSfZMD7RvHfL4TuwlR/gtl09Xu7BAn2HunSpHIiFx7ygC67BAm42oR9IN1f
 gbvQcgXuo2XpoNwVLFozdDvBON8fmxoC5DZ0e2K94L+oozcXseX2H0GEc2h714swWw60
 PjtRqrPnEFxXiMyQsxcLMlu5cUkQjgKRTRUXrvM3bKdP7guOk+lG+NrSInf1ad694R6P
 pXe3pQnzsag/5WgZ6GT47xxyO3EiL9ztF2oKdxj/tYqIM5Z3gc6HaC2lvnOZnDU0ijny
 XS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505849; x=1717110649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/djUxjESZd+LBg4jTRVR14hXFqJadJg1ng6qqnC0kE=;
 b=C7+V/o8Kt8ORC+56jn4dylhV3Gbu9XLJH+ZTjIQTT5ZYDZMZCeUrJc500SwKiMrW8D
 VLur0sIxpUdvYuiB247Z7cL0AiDipAxcYMGQ/uhDpV6qbNeEldsD511Ok6AdxupjCgE9
 HG+Re5ccvDxWLCP+vXbb/+WphEOtExtIyxscop3sTCBW2+2pufDAESbm+rrkxhTuk2eq
 096Ltj4kS2dSpCtkRSx8yG8NqNgB3/5V5nHrwku2SLPAUl2HK7TbT/viFQEHP/oLkV7Z
 za5VWyAGV70Z/Tis3n+bS6hYwMgEGMOLmIQdr/rR7cdWkLqQrBVcIfcVVUcrJPyA0EuS
 L/8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZYqqYVIf5LTlLei8/RERVNwvtrLGW08udab5PC3Q1Bo5uDZ7wLMyjrmdmNeYzfnq04GT+pJjcYlIHA0N33GNKdovL
X-Gm-Message-State: AOJu0YyHCMwjLYn6U58B8gFUD5Su7GjNWROnkcAa9Hy5Wfn2ZQMU4+Zw
 +IvdsYzJCXplJxsad5yd5LP+Qom9XncIlPvjB+ujs1ks9Qps3kF58cg84g==
X-Google-Smtp-Source: AGHT+IEq2g7BlIUY/0cfLhvirIObbQhTII1YM9P8SkbqPcRalBvEC3DUf44Eqh33r9tgu0AKLM/XGQ==
X-Received: by 2002:a05:6a20:734a:b0:1af:cb65:1407 with SMTP id
 adf61e73a8af0-1b212cc7385mr1134177637.6.1716505848913; 
 Thu, 23 May 2024 16:10:48 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 56/72] target/ppc/mmu_common.c: Don't use mmu_ctx_t in
 mmubooke_get_physical_address()
Date: Fri, 24 May 2024 09:07:29 +1000
Message-ID: <20240523230747.45703-57-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

mmubooke_get_physical_address() only uses the raddr and prot fields
from mmu_ctx_t. Pass these directly instead of using a ctx struct.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index adce6cceb8..12dac9e63a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -634,36 +634,25 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                         target_ulong address,
+static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                         int *prot, target_ulong address,
                                          MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
-    hwaddr raddr;
-    int i, ret;
+    int i, ret = -1;
 
-    ret = -1;
-    raddr = (hwaddr)-1ULL;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address,
+        ret = mmubooke_check_tlb(env, tlb, raddr, prot, address,
                                  access_type, i);
         if (ret != -1) {
             break;
         }
     }
-
-    if (ret >= 0) {
-        ctx->raddr = raddr;
-        qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                      " => " HWADDR_FMT_plx " %d %d\n", __func__,
-                      address, ctx->raddr, ctx->prot, ret);
-    } else {
-         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__,
-                       address, raddr, ctx->prot, ret);
-    }
-
+    qemu_log_mask(CPU_LOG_MMU,
+                  "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
+                  " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
+                  address, ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
     return ret;
 }
 
@@ -1143,7 +1132,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     bool real_mode;
 
     if (env->mmu_model == POWERPC_MMU_BOOKE) {
-        return mmubooke_get_physical_address(env, ctx, eaddr, access_type);
+        return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->prot,
+                                             eaddr, access_type);
     } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
         return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
                                                 mmu_idx);
-- 
2.43.0



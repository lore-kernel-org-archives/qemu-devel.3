Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A45C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb7-0000mk-IB; Thu, 23 May 2024 19:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaL-0005kz-ES; Thu, 23 May 2024 19:10:57 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaJ-0006Fy-Bu; Thu, 23 May 2024 19:10:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so314748b3a.0; 
 Thu, 23 May 2024 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505852; x=1717110652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6on8KkNvLlSJ7meAIjkMbKmqaGGjZh9vPDI2kgcgiE=;
 b=IbmoKGLXCs/k34SwW7Coz9CH+YepSYi4jWLFiAxfPeMzngPO4mrVaY35PyFSIMI6YJ
 ghw45QIYo+vwCI8DtjC3aM9BS5QGL7vHaxFjImBl9Q/u8uKjfuTx2fF+/XSBmuZViXGQ
 PuC9nwfb6mDKuXT2YlJhVmWmKH/RPG471vREbF76hEV4g5cT6DLQmq57sXoXUb18x3R5
 29jcnTrCPeqVtI6VBh+DUiOLv18EPlDlHpB2LtL7jkz7IOZgVhDM6fLiXh+HrcwqWRZV
 HTxsu5eCjIGjbMtTqB0gm+XKtV1glT1s+nFSw6py/RMkIyOoQOVk64qlrgwWalLrfh+p
 5Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505852; x=1717110652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6on8KkNvLlSJ7meAIjkMbKmqaGGjZh9vPDI2kgcgiE=;
 b=RLfPH7c3cOgmpa3538fhXivmmlUvU3mcotB3EaHkha9ohAtuSn7DYjlgJJxxaQGaSn
 paqZD/RA4bIOhVPRZ0RbkVtUhUd9DjmlqKpDUwCcBM19XSGOgULDi+9JQIvJaRsb+ZBc
 o2BJDg21VL5QAI72c0H+S6GYIydWZvbP41ov+/LWuskhfufNEqln2TyC2t40U3taeupe
 kfRxXXdlXuAhfNxzLbMjgRVcm6fDCVDAF0cS43hskHSiuq+aVV4eNOXGzXqCN6GOZ9WD
 4h5oLnC1+wF4S7ZhxjXxcSHvmc2KR5mdnO8pHD4iLAYGour0FDZ4jcfaWB9y1Qhz5Y5P
 Js9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL/e20q/cWCmv07xEQQAfRjWeaiht5tnjpCD6iZLwinubD4GZVbFjWovHiFUCUOxXXWCCpr5X0mhgtKVh/MPEVT4oR
X-Gm-Message-State: AOJu0YxBMr1ADVmbamMn84WHC1LQ6MuJ+nL5qxoek2GVHYo4MPagKppF
 xaSYNrY8GDKgRzRlTqy7FmbrmkNKUyiwg/c/dU+x+EzmcMAeb926j3zKeA==
X-Google-Smtp-Source: AGHT+IE3yO+xbp1GYea5w7jjGECcitQKZu+2nEQipBu3ixHVCywgTI/Etm19F/RkQsGT/TnlJfXtqw==
X-Received: by 2002:a05:6a20:2448:b0:1af:dd56:76f0 with SMTP id
 adf61e73a8af0-1b212d003edmr1152255637.22.1716505851735; 
 Thu, 23 May 2024 16:10:51 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 57/72] target/ppc/mmu_common.c: Don't use mmu_ctx_t in
 mmubooke206_get_physical_address()
Date: Fri, 24 May 2024 09:07:30 +1000
Message-ID: <20240523230747.45703-58-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

mmubooke206_get_physical_address() only uses the raddr and prot fields
from mmu_ctx_t. Pass these directly instead of using a ctx struct.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 12dac9e63a..004ea2111d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -836,27 +836,22 @@ found_tlb:
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                            target_ulong address,
+static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                            int *prot, target_ulong address,
                                             MMUAccessType access_type,
                                             int mmu_idx)
 {
     ppcmas_tlb_t *tlb;
-    hwaddr raddr;
-    int i, j, ret;
-
-    ret = -1;
-    raddr = (hwaddr)-1ULL;
+    int i, j, ret = -1;
 
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
         int ways = booke206_tlb_ways(env, i);
-
         for (j = 0; j < ways; j++) {
             tlb = booke206_get_tlbm(env, i, address, j);
             if (!tlb) {
                 continue;
             }
-            ret = mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, address,
+            ret = mmubooke206_check_tlb(env, tlb, raddr, prot, address,
                                         access_type, mmu_idx);
             if (ret != -1) {
                 goto found_tlb;
@@ -866,17 +861,10 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
 found_tlb:
 
-    if (ret >= 0) {
-        ctx->raddr = raddr;
-         qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__, address,
-                       ctx->raddr, ctx->prot, ret);
-    } else {
-         qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                       " => " HWADDR_FMT_plx " %d %d\n", __func__, address,
-                       raddr, ctx->prot, ret);
-    }
-
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n", __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
     return ret;
 }
 
@@ -1135,8 +1123,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->prot,
                                              eaddr, access_type);
     } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
-                                                mmu_idx);
+        return mmubooke206_get_physical_address(env, &ctx->raddr, &ctx->prot,
+                                                eaddr, access_type, mmu_idx);
     }
 
     real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-- 
2.43.0



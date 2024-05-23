Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C410C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHax-0007pd-Rc; Thu, 23 May 2024 19:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaD-0005Xe-FT; Thu, 23 May 2024 19:10:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaB-0006FN-N5; Thu, 23 May 2024 19:10:49 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8edde1013so258920b3a.2; 
 Thu, 23 May 2024 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505846; x=1717110646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAxrxjwyYY9D2jjF7FQG/jdYTTdYZ36wPx1zu+CIhCw=;
 b=l1vtOpBzngotU2XZ3sHIFqhoZKSLHeIlpOAghdBgNmtGFhKOXtwrjY+x/odvu739Fe
 U6qRYG9+l6RtyIcdPyNQd1xa9x7rMP7Ay4CMm1urrSisZ0rYjKE7Bol5zRZAeEhCaqdZ
 c8r5MfoELh/pAyhOxWotZbteZPPB8TcYZy0xFhJ88WH/J12g88lzQwNSGcDSSpf3osw7
 oO6qrP1turhbwL6qd0WX26wEQfpz1O/X0Qljzz3nBE2nh49BxkVUZwumEhofT1cb74F1
 OiAt5Dp8iZbNy+xncDsKhXUdg3blhjnsCHbxSjqxmTmzdq3ylESuBAIv46kEVMVDmioc
 e1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505846; x=1717110646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAxrxjwyYY9D2jjF7FQG/jdYTTdYZ36wPx1zu+CIhCw=;
 b=L5IEwB1shL5CWVzUk3+fPfq3HD9D2207ab61hL/Qz5Ijr4Fv7ODg2VxGPAYv86xaiU
 W30PYTGU05chA2B3X6VBtONPOL5XgPoBMmD+dmB+atEG3o+WruslXnZuF+W64zTut3PP
 MhPCOoAmH0yIBD6v1fJ/8zMzVjv8Lbelm6mDtDvktnD+4Bnj8FUklP0X8bJqL8udLAGX
 MDrC24E/iBhRNR9jPztEW43F+cfkR9z3AGCg1w8Qr177lEloAHnLpAZ4DiumfYcSbS5X
 0vYQhrW3aJIQZMl6sx/V/nBO3oCdRO5KdqFQb0Ayca0UP5pPxjJawjLfQpE5Cr0+Idcg
 uhAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWubuPcnnCPi0BwsnOmyYBkZrs7Rpfi6CBi/50UsQrfXFF9YtXm9L6nzzjLX7dXdHrQxmNbHhdnyJd8FGaqFxLwgqQS
X-Gm-Message-State: AOJu0Ywqlyw0BdLv7SmjYl9Ws8hatGuJiUCU2ExGqN3VGe9a20Ywf8oC
 ufFeQNlwDbJ/uosDaEPPclHDbtim/1VFXVnl13RybmY22dd7lhl5na7CKQ==
X-Google-Smtp-Source: AGHT+IFQvjWFTm9xKZ1N5glGkhWXnNoCUq07jlT3l+RqsR1K8tzQ6VAakJL05fMcf8cqYr3Ce0bSvQ==
X-Received: by 2002:a05:6a20:9751:b0:1af:41d1:732e with SMTP id
 adf61e73a8af0-1b212dfe669mr819073637.46.1716505845839; 
 Thu, 23 May 2024 16:10:45 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 55/72] target/ppc/mmu_common.c: Don't use mmu_ctx_t for
 mmu40x_get_physical_address()
Date: Fri, 24 May 2024 09:07:28 +1000
Message-ID: <20240523230747.45703-56-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

mmu40x_get_physical_address() only uses the raddr and prot fields from
mmu_ctx_t. Pass these directly instead of using a ctx struct.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6570b280ca..adce6cceb8 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -519,20 +519,18 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
     return -1;
 }
 
-static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong address,
+static int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                       int *prot, target_ulong address,
                                        MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
-    hwaddr raddr;
     int i, ret, zsel, zpr, pr;
 
     ret = -1;
-    raddr = (hwaddr)-1ULL;
     pr = FIELD_EX64(env->msr, MSR, PR);
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
+        if (!ppcemb_tlb_check(env, tlb, raddr, address,
                               env->spr[SPR_40x_PID], i)) {
             continue;
         }
@@ -550,40 +548,34 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             /* fall through */
         case 0x3:
             /* All accesses granted */
-            ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            *prot = PAGE_RWX;
             ret = 0;
             break;
+
         case 0x0:
             if (pr != 0) {
                 /* Raise Zone protection fault.  */
                 env->spr[SPR_40x_ESR] = 1 << 22;
-                ctx->prot = 0;
+                *prot = 0;
                 ret = -2;
                 break;
             }
             /* fall through */
         case 0x1:
-        check_perms:
+check_perms:
             /* Check from TLB entry */
-            ctx->prot = tlb->prot;
-            ret = check_prot(ctx->prot, access_type);
+            *prot = tlb->prot;
+            ret = check_prot(*prot, access_type);
             if (ret == -2) {
                 env->spr[SPR_40x_ESR] = 0;
             }
             break;
         }
-        if (ret >= 0) {
-            ctx->raddr = raddr;
-            qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
-                          " => " HWADDR_FMT_plx
-                          " %d %d\n", __func__, address, ctx->raddr, ctx->prot,
-                          ret);
-            return 0;
-        }
     }
-    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                  " => " HWADDR_FMT_plx " %d %d\n",
-                  __func__, address, raddr, ctx->prot, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
+                  HWADDR_FMT_plx " %d %d\n",  __func__,
+                  ret < 0 ? "refused" : "granted", address,
+                  ret < 0 ? 0 : *raddr, *prot, ret);
 
     return ret;
 }
@@ -1171,7 +1163,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     case POWERPC_MMU_SOFT_6xx:
         return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
-        return mmu40x_get_physical_address(env, ctx, eaddr, access_type);
+        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
+                                           access_type);
     case POWERPC_MMU_REAL:
         cpu_abort(env_cpu(env),
                   "PowerPC in real mode do not do any translation\n");
-- 
2.43.0



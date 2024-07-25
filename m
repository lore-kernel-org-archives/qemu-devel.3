Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A7C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MV-0002DA-0W; Thu, 25 Jul 2024 19:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MQ-0001tY-TO; Thu, 25 Jul 2024 19:59:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MP-0001gB-4W; Thu, 25 Jul 2024 19:59:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-79b530ba612so306180a12.2; 
 Thu, 25 Jul 2024 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951939; x=1722556739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvEcGFZAGDXWXM6HhPAakoKCy+wJeKuiyNBUWGVQaIs=;
 b=VahSnGRg9lr/BJKFPYEeOy1DhGF73be94W/r4fWkTjjXinuW/hDXVn8bcA2YjV1L6h
 cMidadcyJykglxyXBf9pi3zXJ88fEWqZyaViVKaR+TQvfbQqUohDbf3tHBSRamAWpkOY
 tgfZ6VqVFlFtWzET+3NA0D15D+W91VN7kAYBgoVhY3o8Q5Quns1JMwYRkdsCfhYCHJ3Q
 JjPwa+zQ1a8wf9bbVQrDZJNs5E4smwmnGwAmswFQRfElLLVi4Ca7LAiL45qfycRNT4OE
 un7yKZwrAo34orCuVEHNVt0bVc8VaMJ2BSdlb+kZVgxflKbhaORtrf17mdHpFrurcmr+
 ptNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951939; x=1722556739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvEcGFZAGDXWXM6HhPAakoKCy+wJeKuiyNBUWGVQaIs=;
 b=h0PBJXlghjUx8eETGJy1DF2MHB4tZxGMgVB3Zamx0Pq3l5Fet8iwRPAZpIH240jonN
 NH5KpGlKTrKBtCWF0b/xO5Zh+nNx4CZ0Y55Kk0fl3EYDuD3jNavF6e72kqTjlMWlYuKm
 kRDIAaofriBnUl/q4RfCNxlRzfZsQTCMxWF+PS1Bm7h9RyX3qY/Bs0Kx8MU//pDBTV9P
 QVgCs7TsGPjrm/YfASYNmBs6VGHH2lEImu58r8c4dfIJspfn3wqYQguekITGExvEmQwc
 r8h0ZXUBBr6FOk/NPEItXjklJPn4N+SiT5PuK8Zgf287V9SrFi9HM25P7PLhCCIZc8CR
 XXcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6ddJNccLT/u+E95PWsTN+c2MX2LXXoIzgEn9RnEW3mBFR4HGC3kYVcpBTtSoOcHPLps+cFXR3T3BII3hbNAem81S6
X-Gm-Message-State: AOJu0YwglklI2iTx2iaKdHKXBXWrKLu/jMix+jhOiElKybZOGHsHa/xQ
 rY1ka/0eOv6PWjqvWDHb1U/BWnROOGJ/bdU2Xya5Wg0WzHhzf4BVz8C4xA==
X-Google-Smtp-Source: AGHT+IGGfC8Yy349KUC16neTDSktLWG0ivCWnXP70g3qdNYZYLQs8tsMHz/YLxRm87wVgJD9ApMV6w==
X-Received: by 2002:a17:90a:bcf:b0:2c9:9b16:e004 with SMTP id
 98e67ed59e1d1-2cf2ec35e56mr3318035a91.43.1721951938799; 
 Thu, 25 Jul 2024 16:58:58 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 78/96] target/ppc/mmu_common.c: Remove single use local variable
Date: Fri, 26 Jul 2024 09:53:51 +1000
Message-ID: <20240725235410.451624-79-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

In mmu6xx_get_physical_address() tagtet_page_bits local is declared
only to use TARGET_PAGE_BITS once. Drop the unneeded variable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 5145bde7f9..0152e8d875 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -321,7 +321,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx;
-    int target_page_bits;
     bool pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
@@ -338,7 +337,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
-    target_page_bits = TARGET_PAGE_BITS;
     qemu_log_mask(CPU_LOG_MMU,
                   "Check segment v=" TARGET_FMT_lx " %d " TARGET_FMT_lx
                   " nip=" TARGET_FMT_lx " lr=" TARGET_FMT_lx
@@ -347,7 +345,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                   (int)FIELD_EX64(env->msr, MSR, IR),
                   (int)FIELD_EX64(env->msr, MSR, DR), pr ? 1 : 0,
                   access_type == MMU_DATA_STORE, type);
-    pgidx = (eaddr & ~SEGMENT_MASK_256M) >> target_page_bits;
+    pgidx = (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
     hash = vsid ^ pgidx;
     ctx->ptem = (vsid << 7) | (pgidx >> 10);
 
-- 
2.45.2



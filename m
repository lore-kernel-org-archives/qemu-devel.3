Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D5BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHat-0007Pg-9y; Thu, 23 May 2024 19:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHa5-0005DM-Iu; Thu, 23 May 2024 19:10:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHa3-0006El-M9; Thu, 23 May 2024 19:10:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f8ea5e3812so296629b3a.2; 
 Thu, 23 May 2024 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505837; x=1717110637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ykLYRaAUuZPqjPv/nLn0tlp5QJYWGIXICGEIpmjRgg=;
 b=eB5zW1oKHftLivc+z4viSo09Wa22eEgbux9xeWmlHgX2L8yUfgH9B4O1822HZK9MaZ
 /Os9GcFg5t588v4xgBrqD3Y4pZJIFuUBkSof7HOsOucESLI8Zf75SpbXyT3mHWbLezOj
 v7AJgvG3b2vZyyYg364GAA2FqNwvII/x18hZ2phd1YxYnm338WLedJw9d0KNGEBSJ8Og
 j1N7HNkLw+UEBZs0zCS3Q2AGDRPdsrMv1yWz4ugmj2tBEt8SNo3ulLCNGfsBaQ/hHtAg
 E9voR4jB7CxBaZv+3bI+MKZgg34jY3VyJmIrgQ3JEptaOsufhgmjTZXrw/GPZWxMmJWz
 YzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505837; x=1717110637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ykLYRaAUuZPqjPv/nLn0tlp5QJYWGIXICGEIpmjRgg=;
 b=g3Dyou0Z2xra/+CQhDm8oPjgD/+D0X9YZ3Du2nFZmu4/Q1NauLYdR9IK13gAg+Ssje
 wO5MlMzUeLJhXbuPIW8EcOugHnR6mWw14m5Zvqn/aNEo28Agd0eAUlqpDa1zAOjWXmXy
 WHNXzxW0KId4Cd0DZZ34UfBcZQ6GmhqDBYl1masCYymX2aAjq+/ediKoAqycqnk07LIO
 AhliYYGhN6h0+t+9PgO1w8KHuL4BV37TRbahyqyg9viOg0RbjMkXOv4/hZo4pT/ZkrdZ
 tYvtyOEe9LeKitVS/ZEF2KgvXyZjuTvOs81bT2ZmAwoYlY3xgKt/55I7r4ZA3CNVFvo9
 UdKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs+O4Aaq1mO8ScEIS8017tlFit3At7+gG5Jz2Yy2rifIj5qh7u608359XfFieXssH/hUudMHqTqLJ9OFY4pgvlnXVr
X-Gm-Message-State: AOJu0YwYkw462MIjlsavhgviBxDjtAsuhqNwaevHxQjn7CiPYckL4A0t
 vyrBGXnBJ0/wAhmf3HGN9pEOxcaU3LjwG+Eokleu623RM/QnkL3FCYMOHA==
X-Google-Smtp-Source: AGHT+IEtfw16KTPbpsafNshYTpmhc5DnMtFKazPo8sE0apXN/2DtB/7zFl2MpxgfnwkibSH9ua+nEQ==
X-Received: by 2002:a05:6a21:9997:b0:1af:ccfd:529d with SMTP id
 adf61e73a8af0-1b212d36314mr973114637.27.1716505836880; 
 Thu, 23 May 2024 16:10:36 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 52/72] target/ppc/mmu_common.c: Fix misindented qemu_log_mask()
 calls
Date: Fri, 24 May 2024 09:07:25 +1000
Message-ID: <20240523230747.45703-53-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

Fix several qemu_log_mask() calls that are misindented.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2f412dd7c5..124148b3da 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -315,8 +315,8 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     int ret = -1;
     bool ifetch = access_type == MMU_INST_FETCH;
 
-     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
-             ifetch ? 'I' : 'D', virtual);
+    qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
+                  ifetch ? 'I' : 'D', virtual);
     if (ifetch) {
         BATlt = env->IBAT[1];
         BATut = env->IBAT[0];
@@ -330,9 +330,9 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
         BEPIu = *BATu & 0xF0000000;
         BEPIl = *BATu & 0x0FFE0000;
         bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
-         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
-                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
-                       ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
+        qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
+                      TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
+                      ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
         if ((virtual & 0xF0000000) == BEPIu &&
             ((virtual & 0x0FFE0000) & ~bl) == BEPIl) {
             /* BAT matches */
@@ -364,12 +364,11 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
                 BEPIu = *BATu & 0xF0000000;
                 BEPIl = *BATu & 0x0FFE0000;
                 bl = (*BATu & 0x00001FFC) << 15;
-                 qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v "
-                               TARGET_FMT_lx " BATu " TARGET_FMT_lx
-                               " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
-                               TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-                               __func__, ifetch ? 'I' : 'D', i, virtual,
-                               *BATu, *BATl, BEPIu, BEPIl, bl);
+                qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx
+                              " BATu " TARGET_FMT_lx " BATl " TARGET_FMT_lx
+                              "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
+                              TARGET_FMT_lx "\n", __func__, ifetch ? 'I' : 'D',
+                              i, virtual, *BATu, *BATl, BEPIu, BEPIl, bl);
             }
         }
     }
@@ -415,9 +414,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     hash = vsid ^ pgidx;
     ctx->ptem = (vsid << 7) | (pgidx >> 10);
 
-    qemu_log_mask(CPU_LOG_MMU,
-            "pte segment: key=%d ds %d nx %d vsid " TARGET_FMT_lx "\n",
-            ctx->key, ds, ctx->nx, vsid);
+    qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
+                  TARGET_FMT_lx "\n", ctx->key, ds, ctx->nx, vsid);
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
         if (type == ACCESS_CODE && ctx->nx) {
@@ -583,9 +581,9 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             return 0;
         }
     }
-     qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
-                   " => " HWADDR_FMT_plx
-                   " %d %d\n", __func__, address, raddr, ctx->prot, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
+                  " => " HWADDR_FMT_plx " %d %d\n",
+                  __func__, address, raddr, ctx->prot, ret);
 
     return ret;
 }
@@ -704,11 +702,11 @@ int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
     }
 
     mask = ~(booke206_tlb_to_page_size(env, tlb) - 1);
-     qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=0x" TARGET_FMT_lx
-                   " PID=0x%x MAS1=0x%x MAS2=0x%" PRIx64 " mask=0x%"
-                   HWADDR_PRIx " MAS7_3=0x%" PRIx64 " MAS8=0x%" PRIx32 "\n",
-                   __func__, address, pid, tlb->mas1, tlb->mas2, mask,
-                   tlb->mas7_3, tlb->mas8);
+    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=0x" TARGET_FMT_lx
+                  " PID=0x%x MAS1=0x%x MAS2=0x%" PRIx64 " mask=0x%"
+                  HWADDR_PRIx " MAS7_3=0x%" PRIx64 " MAS8=0x%" PRIx32 "\n",
+                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
+                  tlb->mas7_3, tlb->mas8);
 
     /* Check PID */
     tlb_pid = (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;
-- 
2.43.0



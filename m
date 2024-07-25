Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B911DC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MP-0001pb-VV; Thu, 25 Jul 2024 19:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8ME-0001A3-JE; Thu, 25 Jul 2024 19:58:51 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MC-0001du-Lt; Thu, 25 Jul 2024 19:58:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a1215dd114so299019a12.1; 
 Thu, 25 Jul 2024 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951926; x=1722556726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FppMjKWB5CNi7jd6+gJtRO0TPQTmv92BzmEfDPZo8Z4=;
 b=nR1iu17Vj1yfumYCSi8dpCs+OIyiyJr6IB64u3QGdEap8k3/gveLYNGpIXT2fLMq3J
 WGqKqtoDn0/NhhMWfPLf0l3j0a33PLieS2PmxjvzWmbf5Am5rm/muMmZWRZ9zaxHzUSO
 +8KXW7jZAvkavZgt6j03FiufI6wG+xwJjMlpr/m+8HvqVBQ8sFRXpP6aBUDt0At+gCOe
 xY0xr56N2cSrvx28/JyGz2AVtP5RXVuOu121i+rs0xdF4NzAEPaYm169t67C+2Zk3Zcz
 T9fOlm41DZmAG2iaDvM9fVArXS5E2zNlkkI7p5Q9eVV5SnAYqFHL86t0EwfuS9Pa7eER
 IRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951926; x=1722556726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FppMjKWB5CNi7jd6+gJtRO0TPQTmv92BzmEfDPZo8Z4=;
 b=vPlg4yNQ2vQ85dmMf2moRWbtGzbntROPZghZ6m7WQsX0EseMhZA4np7sD/G/HYgw4S
 OUYp9ZK3RM1YXGjNKehk8jHdxKf7kKfbZNK5hF8PLSlryYuy0ibneoQVEMWbP6REQYTh
 lXgPkuuy0UfX2FC75M7YPTbpxrv1htEFeahpm3tm6Vj7grYsj2XwdbIi+O6SD9wo/nMc
 mVK7+q1PobNTlsSN8qdv/7KYekfUEc9OygrxBG8n5A60UfYaWUUFCt36ea+cz3CUTcpA
 wabgbGeFg5KzAI4mVzWkLY/b6/DLx4hfkhkecOGCJf1/ueaJcvDbn45eJGZan9yjPazY
 b9FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6ho/hxi0eyViGe3b0CyPSkRH/1KSMc1iIBE3Eh3BECSzl7nI+b+tc55g3gyTK7XF12FXVUUXRdNT7S5TceyBZapo1
X-Gm-Message-State: AOJu0YzWvcPeh1fDSm+13vKnucrNaxp1ELVuH2gsnpNCjD6DPVw+plNx
 qQ4aUqHu4R0ggwKQ5VskQV4J8NHBcb5PPd+1kBHjgV19Nhm1ngtrZfNWQQ==
X-Google-Smtp-Source: AGHT+IEXL3ar8oZfC/uobBc88tdU5bEfjcXxpHGkF7WgIWhH0KOIIUdOy2S3i7GTNN2r38Znvkvgsg==
X-Received: by 2002:a17:90a:9ab:b0:2c9:731b:8561 with SMTP id
 98e67ed59e1d1-2cf2e9d336amr4210393a91.8.1721951926606; 
 Thu, 25 Jul 2024 16:58:46 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 74/96] target/ppc/mmu_common.c: Remove hash field from mmu_ctx_t
Date: Fri, 26 Jul 2024 09:53:47 +1000
Message-ID: <20240725235410.451624-75-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

Return hash value via a parameter and remove it from mmu_ctx.t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 0a07023f48..e3537c63c0 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -41,7 +41,6 @@
 typedef struct {
     hwaddr raddr;      /* Real address             */
     int prot;          /* Protection bits          */
-    hwaddr hash[2];    /* Pagetable hash values    */
     target_ulong ptem; /* Virtual segment ID | API */
     int key;           /* Access key               */
     int nx;            /* Non-execute area         */
@@ -331,7 +330,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong eaddr,
+                                       target_ulong eaddr, hwaddr *hashp,
                                        MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -379,8 +378,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
                       HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
                       ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
-        ctx->hash[0] = hash;
-        ctx->hash[1] = ~hash;
+        *hashp = hash;
 
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
@@ -761,8 +759,8 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     mmu_ctx_t ctx;
-    int type;
-    int ret;
+    hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
+    int type, ret;
 
     if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
         return true;
@@ -779,9 +777,8 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     ctx.prot = 0;
-    ctx.hash[0] = 0;
-    ctx.hash[1] = 0;
-    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, type);
+    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash,
+                                      access_type, type);
     if (ret == 0) {
         *raddrp = ctx.raddr;
         *protp = ctx.prot;
@@ -834,9 +831,9 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
 tlb_miss:
             env->error_code |= ctx.key << 19;
             env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                                  get_pteg_offset32(cpu, ctx.hash[0]);
+                                  get_pteg_offset32(cpu, hash);
             env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                                  get_pteg_offset32(cpu, ctx.hash[1]);
+                                  get_pteg_offset32(cpu, ~hash);
             break;
         case -2:
             /* Access rights violation */
-- 
2.45.2



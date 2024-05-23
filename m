Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CDFC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHat-0007Sy-Hv; Thu, 23 May 2024 19:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZn-0003Ht-Et; Thu, 23 May 2024 19:10:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZl-00069i-67; Thu, 23 May 2024 19:10:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso294244b3a.1; 
 Thu, 23 May 2024 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505819; x=1717110619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EaHAd1VEjGNrQj/hLueMBN/H6aC/VxSDZI3s/nISqI=;
 b=TeT9MTxBL6OKZUtjOgGEE6oYu9mecNhioyvDJjJwHT9TpxDwOacT0Av/wRyUcOxOgv
 mGTXY1w7qSgp23umSvHI+lvQctdrfBgeBDRu5sqwpFJdtLWLPC5t8AyJ5Pw7Xqc27KoB
 5Qe7vZacjziId2sbCkezEqyDHqFLiY+dIxPrSDPj6TKpvYXzgwttH6Enx+94UMA+rCmW
 dCN3f56HhVWGP9JOJII9fxUjwlZUukIaFBr96auLcHu1B8z5yR04+b72nHThCoi9P9pn
 E6MIaaQzfnd6k3zkhBcqHiIYL5g1mrxDv1u//Tnubfdng3+l4qc51dYMB2B/xYJI+o14
 SlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505819; x=1717110619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EaHAd1VEjGNrQj/hLueMBN/H6aC/VxSDZI3s/nISqI=;
 b=fAkHteP/nioxzzq4BoWpAIL4Y4BL37hsem0AQYJGjdJJ6A0OhCu2A5aX+6eKczwWM7
 Xr8GVBfzxRAgyIUEJ87ydUlJaFEwRLenbr2ftdbDWqJyY4oTbXb/Nc5tX8GqbzNKuoWm
 zVm0JpMLBJk8l4rqF4XnxtlvK2Mz/sosAH9Twb590YQCP0pSsheKpuwEKLbNQyRvthSe
 qYGY1ECH7Jrc7D/5JyIRgl3wYIJYTqTn+VuwIZnu+4Cr4wPBqzyBhOyp3NB2AhjIQ1JJ
 /nQsKhmWQYi6Q23J7DjgPctKiAiSjIYrlNtjT40hsoGbcHjo2HkXYf+ZGawobU6PUvwZ
 MpPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzQCi82XOicJXXNsBHE3FMfwgJNuh5Q41lK7w8CLuaKnrqu5VFrDfQ29o/oRJSVR8nQsSIH2EyA1647cYDNoXQj19h
X-Gm-Message-State: AOJu0YwXGq2JwriR2ciiK1JUWrvmAFVOimiJLNbEIbOwTiIoSvGz8x+3
 hSwxk2zfsovefcwpEVVYmSsMkH64YcWUar/gw4IUw5xtMVzUrs4FzM8SCg==
X-Google-Smtp-Source: AGHT+IG3XPiBjXTdOau+XFqZmwzf+j9tFNm9b4AOklbMxsJgeh7FCGcwpAPIuLRKmZQKA9OTOhiwRA==
X-Received: by 2002:a05:6a21:6d81:b0:1af:cd4a:212a with SMTP id
 adf61e73a8af0-1b212cbcee3mr1230933637.1.1716505819042; 
 Thu, 23 May 2024 16:10:19 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 46/72] target/ppc/mmu_common.c: Move else branch to avoid large
 if block
Date: Fri, 24 May 2024 09:07:19 +1000
Message-ID: <20240523230747.45703-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

In mmu6xx_get_physical_address() we have a large if block with a two
line else branch that effectively returns. Invert the condition and
move the else there to allow deindenting the large if block to make
the flow easier to follow.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 71 ++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b7c07cf515..ba60b4902b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -405,47 +405,44 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ret = -1;
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
-        if (type != ACCESS_CODE || ctx->nx == 0) {
-            /* Page address translation */
-            qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx
-                    " htab_mask " HWADDR_FMT_plx
-                    " hash " HWADDR_FMT_plx "\n",
-                    ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
-            ctx->hash[0] = hash;
-            ctx->hash[1] = ~hash;
-
-            /* Initialize real address with an invalid value */
-            ctx->raddr = (hwaddr)-1ULL;
-            /* Software TLB search */
-            ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
+        if (type == ACCESS_CODE && ctx->nx) {
+            qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
+            return -3;
+        }
+        /* Page address translation */
+        qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
+                      HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
+                      ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
+        ctx->hash[0] = hash;
+        ctx->hash[1] = ~hash;
+
+        /* Initialize real address with an invalid value */
+        ctx->raddr = (hwaddr)-1ULL;
+        /* Software TLB search */
+        ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
 #if defined(DUMP_PAGE_TABLES)
-            if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-                CPUState *cs = env_cpu(env);
-                hwaddr curaddr;
-                uint32_t a0, a1, a2, a3;
-
-                qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx
-                         "\n", ppc_hash32_hpt_base(cpu),
-                         ppc_hash32_hpt_mask(cpu) + 0x80);
-                for (curaddr = ppc_hash32_hpt_base(cpu);
-                     curaddr < (ppc_hash32_hpt_base(cpu)
-                                + ppc_hash32_hpt_mask(cpu) + 0x80);
-                     curaddr += 16) {
-                    a0 = ldl_phys(cs->as, curaddr);
-                    a1 = ldl_phys(cs->as, curaddr + 4);
-                    a2 = ldl_phys(cs->as, curaddr + 8);
-                    a3 = ldl_phys(cs->as, curaddr + 12);
-                    if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
-                        qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
-                                 curaddr, a0, a1, a2, a3);
-                    }
+        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+            CPUState *cs = env_cpu(env);
+            hwaddr curaddr;
+            uint32_t a0, a1, a2, a3;
+
+            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
+                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) + 0x80);
+            for (curaddr = ppc_hash32_hpt_base(cpu);
+                 curaddr < (ppc_hash32_hpt_base(cpu)
+                            + ppc_hash32_hpt_mask(cpu) + 0x80);
+                 curaddr += 16) {
+                a0 = ldl_phys(cs->as, curaddr);
+                a1 = ldl_phys(cs->as, curaddr + 4);
+                a2 = ldl_phys(cs->as, curaddr + 8);
+                a3 = ldl_phys(cs->as, curaddr + 12);
+                if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
+                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
+                             curaddr, a0, a1, a2, a3);
                 }
             }
-#endif
-        } else {
-            qemu_log_mask(CPU_LOG_MMU, "No access allowed\n");
-            ret = -3;
         }
+#endif
     } else {
         qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
         /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.43.0



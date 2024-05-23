Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D297C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZx-00044B-Fp; Thu, 23 May 2024 19:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZp-0003SX-Gr; Thu, 23 May 2024 19:10:25 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZn-0006B4-OB; Thu, 23 May 2024 19:10:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f850ff30c0so996372b3a.0; 
 Thu, 23 May 2024 16:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505822; x=1717110622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQWRp59r1pbxpEIyw2cnR8S/5ui2zOUvMXW+Yp409dk=;
 b=AYuzjGxO7Wg1E8s0wcXkNoLu21SbDgjW0T1j2nTlnpkWf2JYwOCcQkcuLtdMLT1O4j
 sftpR2/kdAbCxNFMj6pMRydJI7EKUhmRwKacXrsjZvg6wMVEd0AtPOfWGU01gn4bh5Yk
 IrAnDOO8rP93zqarcseLAodFm5egiVTotl9UoKMi1Tkopkrv/uBKM77hzUidHAdfreLh
 wRjErgFnng7T2UflVmFhWP5HrsdlUg35WmRj31zQ9e99ZrdeSX6sUhBWhaUsYjQvKTzd
 a+dZmU2GOiGUtqxLCvA5iOIqYJFpO/rxO56JPQC69jTLQJRWGUG36yQpOVU/YEMuzIC1
 zlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505822; x=1717110622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQWRp59r1pbxpEIyw2cnR8S/5ui2zOUvMXW+Yp409dk=;
 b=ReLjEHuraYw8mQ6TdKsvcoWpM6KB37weSG7V2xog2E557ufQ4zU1Cq1Q/5ibmYszyx
 ay74B478ONuyFUUfG7GxJtTGkA0p0SjT67IESZf4PA2cjYtMImvwwF5ySQLxJWLCc0ma
 GPIQhgFfatrNvvRg6YoO79OQeSTT6rATU2KqOw9t4ONQZG9N5Gq88OVTKLRbi0Ih1pTG
 geWSI7zkZwQNuBmauqm1UCN0yfFv2DS58gmjez6w4klDR1/AmWP5Rc+DIfeRXrxUy0YU
 m7DixivQUJcv/PfVJ9Vgm7/wF3HNor9mRMVZw+WLJYB9SEsUjaR8tCsoButTwIwitESL
 d4gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXydMaVvNDLvXXA/9KEgUlxGVpQDs8jXxePeB3f0ptEWhKM9RdxUsbK07YXtNveXUJdtO9RGKdvTxD8g/hob31wEnRU
X-Gm-Message-State: AOJu0Yy7KfRpoqtSDTwEQJB8lZQVdkXZXmiLycz+fjtM3Rsl2TE8zm92
 nHFngA9CnKUm9SEDHip9GPsJTe2RRBfomF4rPEQT5bLdnbauHLPsCvv4rQ==
X-Google-Smtp-Source: AGHT+IFrx4oOndtMfcKaWdaDlvAe7nU8QIdk3/BYFqDSSGihIjmQqUh5ygupOv0/+Xml+P9CCNUm7Q==
X-Received: by 2002:a05:6a20:8406:b0:1af:cdd4:9bf3 with SMTP id
 adf61e73a8af0-1b212d4919bmr909651637.32.1716505821860; 
 Thu, 23 May 2024 16:10:21 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 47/72] target/ppc/mmu_common.c: Move some debug logging
Date: Fri, 24 May 2024 09:07:20 +1000
Message-ID: <20240523230747.45703-48-npiggin@gmail.com>
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

Move the debug logging within ppc6xx_tlb_check() from after its only
call to simplify the caller.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 54 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ba60b4902b..89bfd9aa45 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -225,17 +225,14 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
                                      0, access_type)) {
-        case -3:
-            /* TLB inconsistency */
-            return -1;
         case -2:
             /* Access violation */
             ret = -2;
             best = nr;
             break;
-        case -1:
+        case -1: /* No match */
+        case -3: /* TLB inconsistency */
         default:
-            /* No match */
             break;
         case 0:
             /* access granted */
@@ -251,14 +248,34 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
         }
     }
     if (best != -1) {
-    done:
+done:
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
         /* Update page flags */
         pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_type);
     }
-
+#if defined(DUMP_PAGE_TABLES)
+    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+        CPUState *cs = env_cpu(env);
+        hwaddr base = ppc_hash32_hpt_base(env_archcpu(env));
+        hwaddr len = ppc_hash32_hpt_mask(env_archcpu(env)) + 0x80;
+        uint32_t a0, a1, a2, a3;
+
+        qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
+                 base, len);
+        for (hwaddr curaddr = base; curaddr < base + len; curaddr += 16) {
+            a0 = ldl_phys(cs->as, curaddr);
+            a1 = ldl_phys(cs->as, curaddr + 4);
+            a2 = ldl_phys(cs->as, curaddr + 8);
+            a3 = ldl_phys(cs->as, curaddr + 12);
+            if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
+                qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
+                         curaddr, a0, a1, a2, a3);
+            }
+        }
+    }
+#endif
     return ret;
 }
 
@@ -420,29 +437,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
         ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
-#if defined(DUMP_PAGE_TABLES)
-        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-            CPUState *cs = env_cpu(env);
-            hwaddr curaddr;
-            uint32_t a0, a1, a2, a3;
-
-            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
-                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) + 0x80);
-            for (curaddr = ppc_hash32_hpt_base(cpu);
-                 curaddr < (ppc_hash32_hpt_base(cpu)
-                            + ppc_hash32_hpt_mask(cpu) + 0x80);
-                 curaddr += 16) {
-                a0 = ldl_phys(cs->as, curaddr);
-                a1 = ldl_phys(cs->as, curaddr + 4);
-                a2 = ldl_phys(cs->as, curaddr + 8);
-                a3 = ldl_phys(cs->as, curaddr + 12);
-                if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
-                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
-                             curaddr, a0, a1, a2, a3);
-                }
-            }
-        }
-#endif
     } else {
         qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
         /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.43.0



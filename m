Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7760BC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY16-0005tr-GE; Fri, 23 Feb 2024 11:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkV-0007nR-21; Fri, 23 Feb 2024 10:46:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkT-0006js-Hq; Fri, 23 Feb 2024 10:46:06 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc49afb495so3570335ad.2; 
 Fri, 23 Feb 2024 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703163; x=1709307963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m7BhFt0ST6ChSL1LESi22LcAsHCg1BKFvnmGi1yDfU=;
 b=kqNI7win+Pj4cAfCUDspBpW4KJd1lJVY7219H/Ho/SRFdBhIOaetQSOjw5PlJtNSMW
 5u5a3G/vxxgJ9VFJ3ObGnL8/cuztETJbLPLKqHf0db4XrvW5MLgC4im1qSN5D3Xht2fT
 smh/Ub2pJvB0UgDGeEr5tObIJGAtUqTol+pamqdOkpYoFFvTtKTZx/MBA1SZhcKom0L8
 EPBif7WIALMNhcnt0ev4LP2Lx3PS00dp+Ir7sa9Q7WK1Lly341y5ksR1FZ6SCPQQGZmY
 xYL+Stz+rGqgloue2Gk5mFfcxKANKwbvJ6fziu5jOt+ZI/MG4uljJ0uZgzRZJRr9TXRW
 4jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703163; x=1709307963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1m7BhFt0ST6ChSL1LESi22LcAsHCg1BKFvnmGi1yDfU=;
 b=f+Xc6KUnAsM8gubB4oDqQBePpHusJTIlL0e69gzHqrTMlmJTUGLtQqA7BZ2ANQ/YvM
 a6ZnXHAYiUGvM8PkxjuaWILsUQH3EbqlHNai9fRaT25mO5WNV9ldI9Afu7sN5J7/QeSq
 4CG0ZtF0geBqT07pVnpru2uqDkMEFXO5lZ8NT9AAPpkXRrNzyYoANiLoBiWPLxdCiswT
 IxABeplpQOtB/SbnKTS5/k3l+kkkq1uzOn1bA73N9xwjGHW22JC4E+R7Oz+8QVtIT2wi
 u9HfSpBUeAUpsl3pd+l6BVA5kjFpPM0Z5tEgtslXWJwnvUNiI2zExfUfHmvgaBft0yLp
 DWpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW64+jotbUeLp6Z1In81lUgAVkxj1Xrppsx+tli/NRpnfWWYquK8EsGZGJFJIksVc/acY3fwi6CGReipDWlD8R/ZqnA
X-Gm-Message-State: AOJu0Yzk/JEliLl8MQLQZmp+5mDLrQerMX003HE8eSA6ncmWwWDwjLR/
 u8AthEZhijueXyL1DWAGt/8K9eXiU09NifI7xGEKBIeqF4y2ZU0VK0KIEMoF
X-Google-Smtp-Source: AGHT+IGlqQmeuqHm+6kfYl/G2FXJDLgmgsy9PKc6nMQUsKjs1iZm+RwTQr1PuMFSdE/t0xcc6L4vAQ==
X-Received: by 2002:a17:902:db0e:b0:1dc:6af:65e with SMTP id
 m14-20020a170902db0e00b001dc06af065emr186545plx.59.1708703163461; 
 Fri, 23 Feb 2024 07:46:03 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:46:03 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 45/47] target/ppc: 4xx optimise tlbwe_lo TLB flushing
Date: Sat, 24 Feb 2024 01:42:04 +1000
Message-ID: <20240223154211.1001692-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rather than tlbwe_lo always flushing all TCG TLBs, have it flush just
those corresponding to the old software TLB, and only if it was valid.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 68632bf54e..923779d052 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -813,12 +813,20 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
 void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
+    CPUState *cs = env_cpu(env);
     ppcemb_tlb_t *tlb;
 
     qemu_log_mask(CPU_LOG_MMU, "%s entry %i val " TARGET_FMT_lx "\n",
                   __func__, (int)entry, val);
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
+    /* Invalidate previous TLB (if it's valid) */
+    if (tlb->prot & PAGE_VALID) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
+                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
+    }
     tlb->attr = val & PPC4XX_TLBLO_ATTR_MASK;
     tlb->RPN = val & PPC4XX_TLBLO_RPN_MASK;
     tlb->prot = PAGE_READ;
@@ -836,8 +844,6 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_WRITE ? 'w' : '-',
                   tlb->prot & PAGE_EXEC ? 'x' : '-',
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
-
-    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
 }
 
 target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
-- 
2.42.0



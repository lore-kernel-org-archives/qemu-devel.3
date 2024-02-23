Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E729C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY2E-0000QJ-Q3; Fri, 23 Feb 2024 11:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkP-0007Ws-Hq; Fri, 23 Feb 2024 10:46:02 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkM-0006iu-Nb; Fri, 23 Feb 2024 10:46:00 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e4751b97eeso350219b3a.1; 
 Fri, 23 Feb 2024 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703156; x=1709307956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFqipXJsXEnafgLcmtHeug1c4B0ygbUJpknek1Zmhr0=;
 b=AFcProYWLJTJUZBvcZ2ZiXmP4zTcDw9Z3G18HW2T8AEmaNfhUrp47amUxkwi9tR3AO
 pS1Lk72zQ+s6RBUlAPMusmb5DF1UshXPsLzg2cgmWoFJ2BXUlY3+8ral7gwz/nNBPdrr
 nHykWgDwtsuRdFCMni+JhUxbeKwwsj+vUctWmPUfZZgQWZ/C9mo/uNW1V5RQX53WeP37
 PNAZgFgYYj5EaMYbThqyrm4zTnFt26Fmu7FjgvqkYZkAccDpvG46qnphOoFvWYv91Y0z
 of4mczUU3wCHXqF3o4oXIn4KgmpTabjIY7WIg1FEfq08aQAtP+LFwWDIeB6rUqAdcyOj
 PArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703156; x=1709307956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFqipXJsXEnafgLcmtHeug1c4B0ygbUJpknek1Zmhr0=;
 b=c+v+xUrI4Pe2hImFu4USjCof/QeQRZtfhnB/OBwkDgmdXjdBZD1ZKE39n3q/pSSpBh
 cLxFk3xpL0JyQuTkfcywxgmpteMoPfMRCUHDerZFjeMFIDsNu1x95eQ8ZfyQ4X0lRtd9
 92qHTt2PiIpAN391esvqxnUl9iItyCtTvKyJLxbuSHEyuFbn/6l31BULsGkFkxVqeSb6
 inEsuSPbwbjBid0m2EtR4z3+mLf4tUuPFvTt29SNEoRiDV3AdXlf0RHk3KruscUvlRmm
 qMfa7XksvANYia9za4bGnYPeKxYO2Nr4PwYXcmukUzm6u0MClEwJMej/OMyNvDOegEG7
 3I0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfLMSiDUC0uvd8EWHNUIF2jqJK9Cw+zDABmfCJru+G/0SvZG/oOWizQ33KoDoXG8o2RrL8ZXar22MW4C6cMfBVRzUU
X-Gm-Message-State: AOJu0YzF4ZIf42PeklVpbtefNmnADStcbAA9YUg9NpT2BUSM2DwSry8k
 QIDuJEoHDQcfJeKvMwnxya+0D68L8knuxljYx0QgVkIhHHui6rgHGxy4/UGZ
X-Google-Smtp-Source: AGHT+IEPl8WYQOgACvDQm+IPNmPrWo8ntElGxRCpDHP8/r8ec/O/c5tu+zirT2oL/vFhsi6fSkz7mg==
X-Received: by 2002:a05:6a20:9c8d:b0:1a0:cd54:6d9f with SMTP id
 mj13-20020a056a209c8d00b001a0cd546d9fmr109732pzb.23.1708703155726; 
 Fri, 23 Feb 2024 07:45:55 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 43/47] target/ppc: Factor out 4xx ppcemb_tlb_t flushing
Date: Sat, 24 Feb 2024 01:42:02 +1000
Message-ID: <20240223154211.1001692-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Flushing the TCG TLB pages that cache a software TLB is a common
operation, factor it into its own function.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c140f3c96d..949ae87f4f 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -749,12 +749,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
     return ret;
 }
 
+static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
+{
+    target_ulong ea;
+
+    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
+        tlb_flush_page(cs, ea);
+    }
+}
+
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     ppcemb_tlb_t *tlb;
-    target_ulong page, end;
 
     qemu_log_mask(CPU_LOG_MMU, "%s entry %d val " TARGET_FMT_lx "\n",
                   __func__, (int)entry,
@@ -763,13 +771,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
     if (tlb->prot & PAGE_VALID) {
-        end = tlb->EPN + tlb->size;
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, end);
-        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
-            tlb_flush_page(cs, page);
-        }
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
     }
     tlb->size = booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
                                        & PPC4XX_TLBHI_SIZE_MASK);
@@ -805,13 +810,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
     /* Invalidate new TLB (if valid) */
     if (tlb->prot & PAGE_VALID) {
-        end = tlb->EPN + tlb->size;
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, end);
-        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
-            tlb_flush_page(cs, page);
-        }
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
     }
 }
 
-- 
2.42.0



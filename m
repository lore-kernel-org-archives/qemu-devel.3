Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3ECC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl14-0006DQ-3T; Tue, 16 Jul 2024 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0f-0005rz-CG; Tue, 16 Jul 2024 12:26:38 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0a-0006FP-G8; Tue, 16 Jul 2024 12:26:37 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-25e076f79d5so2781190fac.2; 
 Tue, 16 Jul 2024 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147190; x=1721751990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5y4TKaDDHvMsX8pNSb4QjcSx4fOTcaEPBO+qYDjTJY=;
 b=RD3ZFyuKvDlRFYef+Mn/zBkdvonkqGM0awJ6crQQ71fuR8RmW7QpbbnKUVMFOhMPb7
 jQumXnQh7UueZnxB1ByPZNJ2GxjXwyf0cxk6jwplR9bG91Q19wkpovkA2yKPp+qzpQ5X
 RMJvlT/KVwLA/7SOzRYdJfg4pIilQHTGi4oDf6jEMFA51XeuSVXhCQPBHnaXn+xTIq6p
 1PoLV+6rY+vqd1REh6koQAO5Ga8Kw5ZbthBGxyNFLWkM63WFJ8saNdTH6T5Is/Kl741X
 eTeBam6wFrp6iV0QjrNBWWNNiiqvGQY985ge3DUsh+CgcOh1Gypnm+8zETOw7Ka2wiTN
 YZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147190; x=1721751990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5y4TKaDDHvMsX8pNSb4QjcSx4fOTcaEPBO+qYDjTJY=;
 b=Bkb8ulTweBWFC4O9485Xri/d4EGifIrMPF4eA87upRa2ORK8GM5OD8DP3CHWg/zBHn
 5rUAsF7asCU9uQTYSj2d88CIHxmZ2unGuUf4HeZ3y3bdGkpRR8fgzhjgnGSxS+ouAYWW
 cwxnE1FDF3AQ6YUM0s7xfXB+h30bCyMeG2k9OU4OEMoNcKP6+mlBayerz2flQCb+2EUX
 sD+quXOnHebw9q8RNaOgdkJvdHO2CCqhrMT46L/EpC0ALG5EgclZjxJLngjJztYTsRf6
 bHuZqIbizfUXmvfhbE4q7keWNpBYqkH5FOvyGzmw6atMAqT1E/KH1Zm7xGbfSbBs6OTc
 0UuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDhq+pTMGB884A3WxqVDWL/c7g4B4gpwXsH1Djt6v95ILZvUAKHLV8c412LFCNjXfQ8e6X8cFP2zR0LAET7CUYGgDko30=
X-Gm-Message-State: AOJu0YyW6Tw98tVSk6u5QYafCSWvVfj9Jmjyisub8U5g2HvAAxqnJb4S
 Uw4T812vX+eRWQt1A7aHRp4fayCIobNRQvu5JiiDG3os/GWe/WoNDPGMVg==
X-Google-Smtp-Source: AGHT+IEmdV6pxq49/eBFovU3BVZllefi3rIf7h6Ct84ZQxNwQmPJhQRXPrOOVfgnK/cQEwpfTnXFxw==
X-Received: by 2002:a05:6870:c6a1:b0:25d:efdb:ae23 with SMTP id
 586e51a60fabf-260bddd9905mr2117907fac.27.1721147189865; 
 Tue, 16 Jul 2024 09:26:29 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:26:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 01/19] target/ppc: Fix msgsnd for POWER8
Date: Wed, 17 Jul 2024 02:25:57 +1000
Message-ID: <20240716162617.32161-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2e.google.com
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

POWER8 (ISA v2.07S) introduced the doorbell facility, the msgsnd
instruction behaved mostly like msgsndp, it was addressed by TIR
and could only send interrupts between threads on the core.

ISA v3.0 changed msgsnd to be addressed by PIR and can interrupt
any thread in the system.

msgsnd only implements the v3.0 semantics, which can make
multi-threaded POWER8 hang when booting Linux (due to IPIs
failing). This change adds v2.07 semantics.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0a9e8539a4..5368bf2ff3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3007,6 +3007,41 @@ static inline bool dbell_bcast_subproc(target_ulong rb)
     return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
 }
 
+/*
+ * Send an interrupt to a thread in the same core as env).
+ */
+static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
+    }
+
+    if (target_tir >= nr_threads) {
+        return;
+    }
+
+    if (nr_threads == 1) {
+        ppc_set_irq(cpu, irq, 1);
+    } else {
+        CPUState *ccs;
+
+        /* Does iothread need to be locked for walking CPU list? */
+        bql_lock();
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+            if (target_tir == ppc_cpu_tir(ccpu)) {
+                ppc_set_irq(ccpu, irq, 1);
+                break;
+            }
+        }
+        bql_unlock();
+    }
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
@@ -3027,6 +3062,13 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
         return;
     }
 
+    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
+    if (!(env->insns_flags2 & PPC2_ISA300)) {
+        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
+        return;
+    }
+
+    /* POWER9 and later msgsnd is a global (targets any thread) */
     cpu = ppc_get_vcpu_by_pir(pir);
     if (!cpu) {
         return;
@@ -3073,41 +3115,13 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
  */
 void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 {
-    CPUState *cs = env_cpu(env);
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
-    int ttir = rb & PPC_BITMASK(57, 63);
-
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
-    }
-
-    if (!dbell_type_server(rb) || ttir >= nr_threads) {
-        return;
-    }
-
-    if (nr_threads == 1) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
+    if (!dbell_type_server(rb)) {
         return;
     }
 
-    /* Does iothread need to be locked for walking CPU list? */
-    bql_lock();
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
-        uint32_t thread_id = ppc_cpu_tir(ccpu);
-
-        if (ttir == thread_id) {
-            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
-            bql_unlock();
-            return;
-        }
-    }
-
-    g_assert_not_reached();
+    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
 }
 #endif /* TARGET_PPC64 */
 
-- 
2.45.1



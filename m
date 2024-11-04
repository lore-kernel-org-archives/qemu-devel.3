Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E01FD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krJ-0006Ct-Kk; Sun, 03 Nov 2024 19:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kql-00057I-Ok; Sun, 03 Nov 2024 19:21:47 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqk-0002iY-3O; Sun, 03 Nov 2024 19:21:43 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-720be27db74so2257968b3a.1; 
 Sun, 03 Nov 2024 16:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679700; x=1731284500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCfumsfeR659JXcMhCorHoT31nU4A6AzelGgtvxhjxA=;
 b=N7gE1cM2iOGHSTSIIV9fX63US+xl35UTuG95HcZls9jDV2GtsJfKtxcJrtRN6O/TS+
 Fagzi5Qbt389vs0AN+9PP1yOfvOuSlCjRHmGd7f7wIoq1bCDmEHfMAA3t8Pvxx8OaS9r
 sGxjS5Nb38ggy/9KksmmDoXKlhfXGYelC9Z2Sm7mmzPEj6dZjP7JqfOnRDaHYCqR1DD/
 TTCL733qH0SGzyZLBfSIU/OFAuLMH6VBEU4hAUTb9VHD6WpAfByVL/cO6mGspdb8lH+o
 mE3EUdaw5Cv0BXE4vvWAs/spvWfDgMDyz0s2J8CTbA0/f97OUAzULjEpw7tqjDYCNZMR
 KUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679700; x=1731284500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCfumsfeR659JXcMhCorHoT31nU4A6AzelGgtvxhjxA=;
 b=FfA7qx8B4PVlRxEL2Dh8rg2mwUoe8VmIWSJpaxKpmtQQKc/YngdC4/MaKC3TTPTsoB
 iOGp8RxI6csv4WMZkRne1B5jJ/N73zytPwF1R3Y2Iqlpizk+qTkn/azjlodBKZiIZ8WT
 tOGX6IA5XPYVZbp7B6KA4k4uq7y9vCZhC+ncwameVxj5JW2huKO3cKbELsvikJYoMV9w
 DpueZOpz8ERGUZMoVopUL9NErDBoHAte2wQkMlxDsYgyao3wiKTS6PnkZSgAvDDsJZft
 CviXvfi9GTisD+dolxYCitggG+YsrdxSXbTAc1y9VVma96XCNjc/uVEfBiyZtO91AV7L
 nH0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWB4JpNd1kGM/AnMICpNa1YR8RMhwCjf9+27WCogW/fsQ4ODP8tmMQ6EZ7u6o8qgptMCc+zU5/Gg==@nongnu.org
X-Gm-Message-State: AOJu0Yw4xbqq4F6AIzVNvDbvml2jDX2DT8CnvTM044kk6I/2/Iq2IOZx
 vubRlgRaDOW0by6azlo987RkeuMLcinKvlmGH7szvXEhcLWrLRa7c1pvag==
X-Google-Smtp-Source: AGHT+IG6kU+8d3s292f2uId2xCRTILJ0itd9pMnyTC0Jk+8n8Vs+W9ldeq2zSdSX4VzIIIwxZR5+Qg==
X-Received: by 2002:a05:6a00:1d14:b0:71e:6f09:c0a8 with SMTP id
 d2e1a72fcca58-720c97f58e4mr20829191b3a.10.1730679700105; 
 Sun, 03 Nov 2024 16:21:40 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 41/67] target/ppc: simplify var usage in
 ppc_next_unmasked_interrupt
Date: Mon,  4 Nov 2024 10:18:30 +1000
Message-ID: <20241104001900.682660-42-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

As previously done for arch specific handlers, simplify var usage in
ppc_next_unmasked_interrupt by caching the env->pending_interrupts and
env->spr[SPR_LPCR] in local vars and using it later at multiple places.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8d2e880c83..2806afd9bd 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2022,31 +2022,31 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
 
 static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
+    uint32_t pending_interrupts = env->pending_interrupts;
+    target_ulong lpcr = env->spr[SPR_LPCR];
+    bool async_deliver;
+
 #ifdef TARGET_PPC64
     switch (env->excp_model) {
     case POWERPC_EXCP_POWER7:
-        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
-                                          env->spr[SPR_LPCR]);
+        return p7_next_unmasked_interrupt(env, pending_interrupts, lpcr);
     case POWERPC_EXCP_POWER8:
-        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
-                                          env->spr[SPR_LPCR]);
+        return p8_next_unmasked_interrupt(env, pending_interrupts, lpcr);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
     case POWERPC_EXCP_POWER11:
-        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
-                                          env->spr[SPR_LPCR]);
+        return p9_next_unmasked_interrupt(env, pending_interrupts, lpcr);
     default:
         break;
     }
 #endif
-    bool async_deliver;
 
     /* External reset */
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     /* Machine check exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (pending_interrupts & PPC_INTERRUPT_MCK) {
         return PPC_INTERRUPT_MCK;
     }
 #if 0 /* TODO */
@@ -2065,9 +2065,9 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     async_deliver = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
     /* Hypervisor decrementer exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
+    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
-        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
+        bool hdice = !!(lpcr & LPCR_HDICE);
         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hdice) {
             /* HDEC clears on delivery */
             return PPC_INTERRUPT_HDECR;
@@ -2075,18 +2075,18 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* Hypervisor virtualization interrupt */
-    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
+    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
-        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        bool hvice = !!(lpcr & LPCR_HVICE);
         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hvice) {
             return PPC_INTERRUPT_HVIRT;
         }
     }
 
     /* External interrupt can ignore MSR:EE under some circumstances */
-    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
-        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+    if (pending_interrupts & PPC_INTERRUPT_EXT) {
+        bool lpes0 = !!(lpcr & LPCR_LPES0);
+        bool heic = !!(lpcr & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
         if ((async_deliver && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -2096,45 +2096,45 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     }
     if (FIELD_EX64(env->msr, MSR, CE)) {
         /* External critical interrupt */
-        if (env->pending_interrupts & PPC_INTERRUPT_CEXT) {
+        if (pending_interrupts & PPC_INTERRUPT_CEXT) {
             return PPC_INTERRUPT_CEXT;
         }
     }
     if (async_deliver != 0) {
         /* Watchdog timer on embedded PowerPC */
-        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
+        if (pending_interrupts & PPC_INTERRUPT_WDT) {
             return PPC_INTERRUPT_WDT;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
             return PPC_INTERRUPT_CDOORBELL;
         }
         /* Fixed interval timer on embedded PowerPC */
-        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
+        if (pending_interrupts & PPC_INTERRUPT_FIT) {
             return PPC_INTERRUPT_FIT;
         }
         /* Programmable interval timer on embedded PowerPC */
-        if (env->pending_interrupts & PPC_INTERRUPT_PIT) {
+        if (pending_interrupts & PPC_INTERRUPT_PIT) {
             return PPC_INTERRUPT_PIT;
         }
         /* Decrementer exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+        if (pending_interrupts & PPC_INTERRUPT_DECR) {
             return PPC_INTERRUPT_DECR;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
             return PPC_INTERRUPT_DOORBELL;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
             return PPC_INTERRUPT_HDOORBELL;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
+        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
             return PPC_INTERRUPT_PERFM;
         }
         /* Thermal interrupt */
-        if (env->pending_interrupts & PPC_INTERRUPT_THERM) {
+        if (pending_interrupts & PPC_INTERRUPT_THERM) {
             return PPC_INTERRUPT_THERM;
         }
         /* EBB exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
+        if (pending_interrupts & PPC_INTERRUPT_EBB) {
             /*
              * EBB exception must be taken in problem state and
              * with BESCR_GE set.
-- 
2.45.2



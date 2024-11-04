Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7E6D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kr9-0005Nk-Fx; Sun, 03 Nov 2024 19:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqi-00052b-LW; Sun, 03 Nov 2024 19:21:42 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqh-0002iJ-1x; Sun, 03 Nov 2024 19:21:40 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso35963195ad.2; 
 Sun, 03 Nov 2024 16:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679697; x=1731284497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YJeTidwt3a7o0gdkzG7N4NysCiSAz4U4rS7VO7/kD8=;
 b=ljQA1SJQJ9Ivl+WGja5ccuzQCtpUnCY5NloSHHjlHbqzuYRx7c/jZe8/TR+Xoxc0mG
 sSms3sPR3MccS3pL4AqTffcn0HIqFDwUIn4A5AQsqHSGfXNGAnZNzuqGgxH2WgeecRkV
 5aQziuYFlq71MXGJGxnNo+ebi5jOGein4cNebSSVM+hJNmSoZVa1D6VYU1K6vL/M/PDA
 sfhnBCpR/wcZXbZ0SZsZZxn+0ULZ2dWLmyI13pxCJO6WnXEJiWCi0aFvDNPCgKX/JJKH
 98JOA6rmIyrjhMOEynL64tLsDMUB1M/nvSJxm/fgvJ0ggKfLtXWt8MQLAyUIoqqu8Ta6
 Tk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679697; x=1731284497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YJeTidwt3a7o0gdkzG7N4NysCiSAz4U4rS7VO7/kD8=;
 b=KXhyAWe3z8GmRWpcnnfS53jgwyrDa9tk+IYTzezMN/atAvvav45VeXjpybbIQuGOn4
 2C10IL6yajF3TanfXQWZ2xqQxR7uf1qfJsoxhuHeTd79nNfodKnd4xC1nFkFsUUKwoz1
 uy6rowloNA7bkh9ixrBRrRkE5eVj7l11Id4H3feY9RGTACzWrbi1VRkszotw2FZdHFzb
 98WeszNRN2lqsqH523KKgvThGEF7KuoGN7frCMKBAnI1RdJ0U+P+QLVHwpTzb15sc+RD
 hHD2UghUn/VJ94TxS9BuyMaUcKFBUGBv6Jknywa+9NnQMi8Phut63BklZBy8ydYOQUCk
 bTiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtzPZPNMpg4ndIDXLtQgHNvnKIyReVgbHQSa52P7kBuYO0sqGztKhhKh8HZZ3tgvSvKp6FkB5vBQ==@nongnu.org
X-Gm-Message-State: AOJu0YyJSUjqBDSisVwnSQCIxWmDKgf6c0AfuUl4pdsuwthQvnNEojnF
 nNsZDiZcKmnYh9UckRPj9dQQAQXL1zWn1DFGseQ8LWrOkegE2ad6EueXjQ==
X-Google-Smtp-Source: AGHT+IHwKJY0GNtZBXaPTS/n/GLZTHM9Jh1Mz4P/1c2CVWw4NB0ZbY1yhoDQQBb7IpNcVueAFiNVvQ==
X-Received: by 2002:a17:902:f543:b0:20c:e875:12c2 with SMTP id
 d9443c01a7336-2111b0028edmr134234495ad.51.1730679696837; 
 Sun, 03 Nov 2024 16:21:36 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 40/67] target/ppc: optimize p7 exception handling routines
Date: Mon,  4 Nov 2024 10:18:29 +1000
Message-ID: <20241104001900.682660-41-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Like p8 and p9, simplifying p7 exception handling rotuines to avoid
un-necessary multiple indirect accesses to env->pending_interrupts and
env->spr[SPR_LPCR].

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 38733b7521..8d2e880c83 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1683,51 +1683,54 @@ void ppc_cpu_do_interrupt(CPUState *cs)
      PPC_INTERRUPT_PIT | PPC_INTERRUPT_DOORBELL | PPC_INTERRUPT_HDOORBELL | \
      PPC_INTERRUPT_THERM | PPC_INTERRUPT_EBB)
 
-static int p7_interrupt_powersave(CPUPPCState *env)
+static int p7_interrupt_powersave(uint32_t pending_interrupts,
+                                  target_ulong lpcr)
 {
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE0)) {
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
+        (lpcr & LPCR_P7_PECE0)) {
         return PPC_INTERRUPT_EXT;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE1)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
+        (lpcr & LPCR_P7_PECE1)) {
         return PPC_INTERRUPT_DECR;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_MCK) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
+    if ((pending_interrupts & PPC_INTERRUPT_MCK) &&
+        (lpcr & LPCR_P7_PECE2)) {
         return PPC_INTERRUPT_MCK;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_HMI) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HMI) &&
+        (lpcr & LPCR_P7_PECE2)) {
         return PPC_INTERRUPT_HMI;
     }
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     return 0;
 }
 
-static int p7_next_unmasked_interrupt(CPUPPCState *env)
+static int p7_next_unmasked_interrupt(CPUPPCState *env,
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
-    assert((env->pending_interrupts & P7_UNUSED_INTERRUPTS) == 0);
+    assert((pending_interrupts & P7_UNUSED_INTERRUPTS) == 0);
 
     if (cs->halted) {
         /* LPCR[PECE] controls which interrupts can exit power-saving mode */
-        return p7_interrupt_powersave(env);
+        return p7_interrupt_powersave(pending_interrupts, lpcr);
     }
 
     /* Machine check exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (pending_interrupts & PPC_INTERRUPT_MCK) {
         return PPC_INTERRUPT_MCK;
     }
 
     /* Hypervisor decrementer exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
+    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
         bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
@@ -1737,9 +1740,9 @@ static int p7_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* External interrupt can ignore MSR:EE under some circumstances */
-    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
-        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+    if (pending_interrupts & PPC_INTERRUPT_EXT) {
+        bool lpes0 = !!(lpcr & LPCR_LPES0);
+        bool heic = !!(lpcr & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
         if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -1749,10 +1752,10 @@ static int p7_next_unmasked_interrupt(CPUPPCState *env)
     }
     if (msr_ee != 0) {
         /* Decrementer exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+        if (pending_interrupts & PPC_INTERRUPT_DECR) {
             return PPC_INTERRUPT_DECR;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
+        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
             return PPC_INTERRUPT_PERFM;
         }
     }
@@ -2022,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 #ifdef TARGET_PPC64
     switch (env->excp_model) {
     case POWERPC_EXCP_POWER7:
-        return p7_next_unmasked_interrupt(env);
+        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
+                                          env->spr[SPR_LPCR]);
     case POWERPC_EXCP_POWER8:
         return p8_next_unmasked_interrupt(env, env->pending_interrupts,
                                           env->spr[SPR_LPCR]);
-- 
2.45.2



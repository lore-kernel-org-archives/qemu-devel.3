Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A382C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5VW-0007sG-E4; Tue, 12 Mar 2024 13:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5U9-0005Yq-W8; Tue, 12 Mar 2024 13:00:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5U6-0008HC-Mk; Tue, 12 Mar 2024 13:00:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so28154b3a.1; 
 Tue, 12 Mar 2024 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262811; x=1710867611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3JKe0TJbmxuyIYttlWu8sUSbcX+C6UWX04Pn1Totdg=;
 b=YUkF6fRgFuvcprAOxKP7clKp0Wn1IhpLZsveWbqsz8ITNQ4WNtqgeTyL0PqGhlC7Vn
 htzoCXPqjT5YkIhBFX9og7n+UbU9qU6kSJOhv+1wxLRp6awTfejYdIp8wvQp1Mdd3bG1
 thfO52TT/t7bKxq9wPDBxXZILSr4MSRf6y04j+1vU4CxPfS6CSMjEw8ECJdAp57+jVO4
 BXA4xfRXn9xEFgjHjd4xkh0bKxjWBGFBeGItmU7UIW/bbfTm7Ge+t4cAl2An3TBJaPki
 bsxFcjcvddWS4RrjDSFtRUrU7nL8I40Xxqu/ZoXqq9Y1dHTSafPrLE0n9seDkhSNr9KE
 Fdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262811; x=1710867611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3JKe0TJbmxuyIYttlWu8sUSbcX+C6UWX04Pn1Totdg=;
 b=FVmq2TjolZ5WVhnqXWUHv4vQNDfzAoLcyhrAVFlpMf0Q+50bX1+ePRxWJCP+z6XlGu
 Z2UHcSl+/1p1kXwQde+i1x2V+ZUq2Sscv+i/V3mUPBZgrVp2pdtEfV/U6eU2H6QnkdwS
 ZxT2XPXMNXKPIwYXMq6VfedCTh2NK28pCGR24EFIm8CP17OS8HLjiotRFvJLnrY/MYL9
 mpgwSuENhGuk5oZq1fDeLXzo2WZJknB0fqXgVCdaz3Da73xQx3kiJ8aXm1ZqD91Ev1J5
 EWfbgNloI9KsakAsUpyHuAamQ6cNLpHSZsamFIgkSx0K5MDzATS7OTFKESP0L/qP7cfk
 JReg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXRcBGBNK9R30H0YL8MlvJcEqr4+P7F5Co3Ux7dRm67SY7O01yHfL5AesjplhxvuN/S7umVLAxleW4bGefAZDCkUgL
X-Gm-Message-State: AOJu0YwVEN3sT73yn99fX+WbSw+CXM5kfhuFFZ2l6HdZGacCtK97C0UQ
 TCCP7RC1d4rs+fUTZGzzZryAx1O8hW70S0X/Wr+BQxjnNPA1XZdeS7bV4NiXozg=
X-Google-Smtp-Source: AGHT+IEskltlhsoxre2zLCNOSsty/tDCmNGkmRYkwQWp2Co+ZSeQm8B2eJeRIa9THswOKBTAgdSGlQ==
X-Received: by 2002:a05:6a00:a0c:b0:6e6:75d8:3d19 with SMTP id
 p12-20020a056a000a0c00b006e675d83d19mr30954pfh.8.1710262811212; 
 Tue, 12 Mar 2024 10:00:11 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 19/38] target/ppc: Readability improvements in exception
 handlers
Date: Wed, 13 Mar 2024 02:58:30 +1000
Message-ID: <20240312165851.2240242-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Improve readability by shortening some long comments, removing
comments that state the obvious and dropping some empty lines so they
don't distract when reading the code.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |   1 +
 target/ppc/excp_helper.c | 179 +++++++--------------------------------
 2 files changed, 33 insertions(+), 147 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ed04351f27..7c48b2eadb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2954,6 +2954,7 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+/* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
 static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 56a5fe7f3b..c15cd904d1 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -403,9 +403,8 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
      * We don't use hreg_store_msr here as already have treated any
      * special case that could occur. Just store MSR and update hflags
      *
-     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
-     * will prevent setting of the HV bit which some exceptions might need
-     * to do.
+     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it will
+     * prevent setting of the HV bit which some exceptions might need to do.
      */
     env->nip = vector;
     env->msr = msr;
@@ -447,25 +446,15 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1;
+    int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overridden.
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overridden */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME));
 
-    /* target registers */
-    srr0 = SPR_SRR0;
-    srr1 = SPR_SRR1;
-
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -475,7 +464,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -487,7 +475,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         srr0 = SPR_40x_SRR2;
         srr1 = SPR_40x_SRR3;
         break;
@@ -558,12 +545,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /* Save PC */
     env->spr[srr0] = env->nip;
-
-    /* Save MSR */
     env->spr[srr1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -575,16 +558,10 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overridden
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overridden */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -594,7 +571,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -604,7 +580,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -632,11 +607,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -712,20 +685,11 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
-    /* Save PC */
     env->spr[SPR_SRR0] = env->nip;
-
-    /* Save MSR */
     env->spr[SPR_SRR1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -737,16 +701,10 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overridden
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overridden */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -756,7 +714,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -764,7 +721,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -792,11 +748,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -865,12 +819,10 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_DLTLB:     /* Data load TLB miss                       */
     case POWERPC_EXCP_DSTLB:     /* Data store TLB miss                      */
         ppc_excp_debug_sw_tlb(env, excp);
-
         msr |= env->crf[0] << 28;
         msr |= env->error_code; /* key, D/I, S/L bits */
         /* Set way using a LRU mechanism */
         msr |= ((env->last_way + 1) & (env->nb_ways - 1)) << 17;
-
         break;
     case POWERPC_EXCP_IABR:      /* Instruction address breakpoint           */
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
@@ -885,20 +837,11 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
-    /* Save PC */
     env->spr[SPR_SRR0] = env->nip;
-
-    /* Save MSR */
     env->spr[SPR_SRR1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -910,16 +853,10 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
-    /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overridden
-     */
+    /* new interrupt handler msr preserves ME unless explicitly overridden */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -929,7 +866,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -937,7 +873,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
-
         break;
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
@@ -965,11 +900,9 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -1050,20 +983,11 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
-    /* Save PC */
     env->spr[SPR_SRR0] = env->nip;
-
-    /* Save MSR */
     env->spr[SPR_SRR1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -1071,24 +995,18 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1;
-
-    msr = env->msr;
+    int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
 
     /*
-     * new interrupt handler msr preserves existing ME unless
-     * explicitly overridden
+     * Book E does not play games with certain bits of xSRR1 being MSR save
+     * bits and others being error status. xSRR1 is the old MSR, period.
      */
-    new_msr = env->msr & ((target_ulong)1 << MSR_ME);
+    msr = env->msr;
 
-    /* target registers */
-    srr0 = SPR_SRR0;
-    srr1 = SPR_SRR1;
+    /* new interrupt handler msr preserves ME unless explicitly overridden */
+    new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
-    /*
-     * Hypervisor emulation assistance interrupt only exists on server
-     * arch 2.05 server or later.
-     */
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
     if (excp == POWERPC_EXCP_HV_EMU) {
         excp = POWERPC_EXCP_PROGRAM;
     }
@@ -1108,7 +1026,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     switch (excp) {
@@ -1152,11 +1069,9 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             env->spr[SPR_BOOKE_ESR] = ESR_FP;
@@ -1257,12 +1172,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     }
 #endif
 
-    /* Save PC */
     env->spr[srr0] = env->nip;
-
-    /* Save MSR */
     env->spr[srr1] = msr;
-
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -1384,21 +1295,17 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1, lev = -1;
+    int srr0 = SPR_SRR0, srr1 = SPR_SRR1, lev = -1;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
     /*
-     * new interrupt handler msr preserves existing HV and ME unless
-     * explicitly overridden
+     * new interrupt handler msr preserves HV and ME unless explicitly
+     * overridden
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME) | MSR_HVB);
 
-    /* target registers */
-    srr0 = SPR_SRR0;
-    srr1 = SPR_SRR1;
-
     /*
      * check for special resume at 0x100 from doze/nap/sleep/winkle on
      * P7/P8/P9
@@ -1423,7 +1330,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         cpu_abort(env_cpu(env),
                   "Raised an exception without defined vector %d\n", excp);
     }
-
     vector |= env->excp_prefix;
 
     if (is_prefix_insn_excp(cpu, excp)) {
@@ -1440,7 +1346,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
              */
             new_msr |= (target_ulong)MSR_HVB;
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1458,23 +1363,17 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     {
         bool lpes0;
 
-        /*
-         * LPES0 is only taken into consideration if we support HV
-         * mode for this CPU.
-         */
+        /* LPES0 is only taken into consideration if we support HV mode */
         if (!env->has_hv_mode) {
             break;
         }
-
         lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-
         if (!lpes0) {
             new_msr |= (target_ulong)MSR_HVB;
             new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
             srr0 = SPR_HSRR0;
             srr1 = SPR_HSRR1;
         }
-
         break;
     }
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
@@ -1497,11 +1396,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
                 powerpc_reset_excp_state(cpu);
                 return;
             }
-
             /*
-             * FP exceptions always have NIP pointing to the faulting
-             * instruction, so always use store_next and claim we are
-             * precise in the MSR.
+             * NIP always points to the faulting instruction for FP exceptions,
+             * so always use store_next and claim we are precise in the MSR.
              */
             msr |= 0x00100000;
             break;
@@ -1665,21 +1562,13 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         break;
     }
 
-    /*
-     * Sort out endianness of interrupt, this differs depending on the
-     * CPU, the HV mode, etc...
-     */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
-
     new_msr |= (target_ulong)1 << MSR_SF;
 
     if (excp != POWERPC_EXCP_SYSCALL_VECTORED) {
-        /* Save PC */
         env->spr[srr0] = env->nip;
-
-        /* Save MSR */
         env->spr[srr1] = msr;
     }
 
@@ -1688,19 +1577,15 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED call */
         vhc->deliver_hv_excp(cpu, excp);
-
         powerpc_reset_excp_state(cpu);
-
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
             cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
                       "with no HV support\n", excp);
         }
-
         /* This can update new_msr and vector if AIL applies */
         ppc_excp_apply_ail(cpu, excp, msr, &new_msr, &vector);
-
         powerpc_set_excp_state(cpu, vector, new_msr);
     }
 }
-- 
2.42.0



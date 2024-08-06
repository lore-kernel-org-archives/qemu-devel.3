Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A9DC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK14-0005d3-Gt; Tue, 06 Aug 2024 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0c-0003mM-Dp; Tue, 06 Aug 2024 09:13:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0Z-0003Vz-MJ; Tue, 06 Aug 2024 09:13:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ff67158052so4288115ad.0; 
 Tue, 06 Aug 2024 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950023; x=1723554823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIbYNlJMBEsCqBxxwTzqQf1JhWU8VE32ZNkapVqS6C8=;
 b=TG0Ak+TFPK95pY1TGuao6kTrQZBVYdxngiItFJSN9P/vW4dUCfFwduHkmWv2SbgWp1
 jdXvk0BH6iDr8XmJlhpZ65ppMZbIajCpCplAC1c77epjzWUsZCZMWI7L5/x4R1qt3RUw
 yRKraRvO/IjTXqhxtoxDW+Eq+l5Osqq1Y0oWBDldB8qwjmjg1rq2Q/5V1OmTeIOPZEcF
 sqQYDuWPXOgjLEwICzis/6hbLZCBMHVSSWrjjzcHZ3sHudTm0XlFXXtCsqVvdzBwTIc+
 Eh5SoMQVp3DGNOz5mvPH8ZsXB7xWk4ZryVxFxVQbjPFjtaMOBd6z2AcgiE3XT3y+43Ln
 VkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950023; x=1723554823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIbYNlJMBEsCqBxxwTzqQf1JhWU8VE32ZNkapVqS6C8=;
 b=Wpw1cbAAdu7Y9RTkwXTPtgulDMkTNyvU3Xurbjgf/9SXqj9BWcQ8yDdLuaH5jnhSm+
 jlwRhaQCwEu3gpNEAf5AP0A7mS6BTxm2SGNAu1dStK+pFJf32gEbv0J36ORxwWmvWxYp
 ENcoSwXKBReuJUIdCmFvrWnXYNRKag/BubRfW2VBSQFWevgeXOFG/fJwVQOI4JmTyXdi
 UKnb6l6aR7auFsO5ImzLVauAd+fPEMyJxxuYWcevZN5AA7IPCmg2jAFycFQN0O4bjwUd
 dHxvYXcgwoYwq7jjMPGb3pmD8gTMibZSHJaRF8n9ltPnZAsE9beCwAqA+30yo53gC0CW
 bUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgHPj+oDtFGAD03fCvjiTnCa528V5TuBRuqnzMgtAD8VxGVyTs2l5JjeARgKbA0wMxPYhF332vPeiTxGue3IQpHFYctcc=
X-Gm-Message-State: AOJu0YwnuHBO95NlLMuknh373uql1dp2SBKfzStctgXjxslZdmC06S/s
 iZsEUHt/rXVlZKegLQ1XvxFomHc53mNAPcd/R2a4XRn9VqH45L/TtZw4RCvl
X-Google-Smtp-Source: AGHT+IE/Wm7PJAZf+CMGRmjGZndGLRL+exg55KjpuAvnXHRI1c1l4AVKIwxy63x1NWJH+DgwRbecCQ==
X-Received: by 2002:a17:902:b192:b0:1fb:5574:7554 with SMTP id
 d9443c01a7336-1ff572b97cfmr110012275ad.28.1722950022804; 
 Tue, 06 Aug 2024 06:13:42 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/7] target/ppc: PMIs are level triggered
Date: Tue,  6 Aug 2024 23:13:14 +1000
Message-ID: <20240806131318.275109-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

In Book-S / Power processors, the performance monitor interrupts are
driven by the MMCR0[PMAO] bit, which is level triggered and not cleared
by the interrupt.

Others may have different performance monitor architecture, but none of
those are implemented by QEMU.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f33fc36db2..701abe1b6d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2187,7 +2187,6 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_DECR);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case 0:
@@ -2250,7 +2249,6 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case PPC_INTERRUPT_EBB: /* EBB exception */
@@ -2330,7 +2328,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case PPC_INTERRUPT_EBB: /* EBB exception */
@@ -2444,7 +2441,6 @@ static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case PPC_INTERRUPT_THERM:  /* Thermal interrupt */
-- 
2.45.2



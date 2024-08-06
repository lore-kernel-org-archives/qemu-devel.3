Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD4C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK15-0005lO-O7; Tue, 06 Aug 2024 09:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0f-0003xY-CF; Tue, 06 Aug 2024 09:13:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0c-0003WJ-OG; Tue, 06 Aug 2024 09:13:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ff1cd07f56so4580175ad.2; 
 Tue, 06 Aug 2024 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950027; x=1723554827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgU6iYZFKP//e6ctrVy6nGUeFbSjKaYt4cFTsJDS7Pk=;
 b=FyHCiPNnja+NxFlaUOeKYN7nSG6dow1PJa1Ea2FuAMCwtW4cv5pnJ1FSmcEhU6v3sa
 SQFsItugNC9G/DNaCKlu+jR0idZy2lTS24XyGUzaWC0OS3QloHIzJ1vHfkDmgcfUoIxe
 MietkRSSVDL+p6BkaKjk5QSn/I1XvIpXjQ2mJvxRicu+BE42rqbDWNgmXY840/iDMCYJ
 w2clRyW/3JsDKIw9MarnZVCJiXDgrg/GTUiGwXEtGXkqrhOCI0z6x29nlIyWOHjPfukI
 PUmYbzhu7o2tktTMVmtLbMyAdhTa/8HjyV697dLKYVqmf1iP+xydnsfhG8w9YAB64Zyg
 fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950027; x=1723554827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgU6iYZFKP//e6ctrVy6nGUeFbSjKaYt4cFTsJDS7Pk=;
 b=g5zX7nM32dHULLBT3AEmT4PZvsB7GQRvMlQ9G/VGMdsfNCdwdeG6tbom8scaQL4smD
 QinPe4+ZHxNSwTcG/gVt/CijsFePf8T0qV4l181ByM1wfw5mltw1xXV/lVRpw9s+6E8h
 jbmixSiWNmq/NplebWBsOjqC0r/CZSM6tG1ZHvF2Gowq8WP79CUpcmoPU0IZLBIx5N3B
 Okze60yHD0rzb01tu5fF3/xEyIGUBZlbkLREsmy3iPLvb/4Th7/sEbq/HalSkahg4iKD
 86h+Kwzwu8aZQveHV0+r1YJ7CrsucqUbnBwmqs9SXr4dTrwJr6+C0ynOeKlQRJ6yDPJx
 LHOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbTlEg1tVtACvkP8I1Z7WGliuKIRsFUIvfTozIu0ZHQlFMYQf3FsVGP0suz6pMQ8MoHg1Y/LrHmWGDhbxp3oFw6zdiqbI=
X-Gm-Message-State: AOJu0YxJD1e3GZQxlwFZ7X8tLKpozIlEWjZPczos6DSLTMzFucQFgLFP
 Ry0COZAPNeUGpfGYAV8j2wAsdXFWUtJjNuaTBI9BFL3Tl0LWI83Y+59cIWXR
X-Google-Smtp-Source: AGHT+IFyCslNNQAAnyRF6xqwhi48lWAoBkiYAnZdvs7xgmOQvYGMOR9NCFGJ0uOaUhwTxi5NXh5h3g==
X-Received: by 2002:a17:902:d505:b0:1fa:8f64:8b0d with SMTP id
 d9443c01a7336-1ff5722e795mr213538905ad.4.1722950027271; 
 Tue, 06 Aug 2024 06:13:47 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/ppc: Fix doorbell delivery to threads in powersave
Date: Tue,  6 Aug 2024 23:13:15 +1000
Message-ID: <20240806131318.275109-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

Doorbell exceptions are not not cleared when they cause a wake from
powersave state, only when they take the corresponding interrupt.
The sreset-on-wake logic must avoid clearing the interrupt in this
case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 701abe1b6d..b619a6adde 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2237,7 +2237,9 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_DECR);
         break;
     case PPC_INTERRUPT_DOORBELL:
-        env->pending_interrupts &= ~PPC_INTERRUPT_DOORBELL;
+        if (!env->resume_as_sreset) {
+            env->pending_interrupts &= ~PPC_INTERRUPT_DOORBELL;
+        }
         if (is_book3s_arch2x(env)) {
             powerpc_excp(cpu, POWERPC_EXCP_SDOOR);
         } else {
@@ -2245,7 +2247,9 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         }
         break;
     case PPC_INTERRUPT_HDOORBELL:
-        env->pending_interrupts &= ~PPC_INTERRUPT_HDOORBELL;
+        if (!env->resume_as_sreset) {
+            env->pending_interrupts &= ~PPC_INTERRUPT_HDOORBELL;
+        }
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
@@ -2301,6 +2305,7 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 
     case PPC_INTERRUPT_HDECR: /* Hypervisor decrementer exception */
         /* HDEC clears on delivery */
+        /* XXX: should not see an HDEC if resume_as_sreset. assert? */
         env->pending_interrupts &= ~PPC_INTERRUPT_HDECR;
         powerpc_excp(cpu, POWERPC_EXCP_HDECR);
         break;
@@ -2320,11 +2325,15 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_DECR);
         break;
     case PPC_INTERRUPT_DOORBELL:
-        env->pending_interrupts &= ~PPC_INTERRUPT_DOORBELL;
+        if (!env->resume_as_sreset) {
+            env->pending_interrupts &= ~PPC_INTERRUPT_DOORBELL;
+        }
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR);
         break;
     case PPC_INTERRUPT_HDOORBELL:
-        env->pending_interrupts &= ~PPC_INTERRUPT_HDOORBELL;
+        if (!env->resume_as_sreset) {
+            env->pending_interrupts &= ~PPC_INTERRUPT_HDOORBELL;
+        }
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-- 
2.45.2



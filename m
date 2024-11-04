Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EFD11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7koq-0007BZ-8f; Sun, 03 Nov 2024 19:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kon-0007Ag-Mo; Sun, 03 Nov 2024 19:19:41 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kol-0002HI-Bw; Sun, 03 Nov 2024 19:19:41 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso2831471b3a.3; 
 Sun, 03 Nov 2024 16:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679577; x=1731284377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1xac5W5zKwCyt+Affs+nBDH85dTqE+Fj+UGOQD6hfU=;
 b=E8E5I7/C7EKp9MtANFskQdcq9eUInc1v8z8V0YbbObyDPAub3lMJXtzP9i+oTCGlV9
 o1O1+ZMrI6ZclHHiL1PPfqSAEzLqspbpuPSmc3xA4s0KuPKeb39UT79FUWSYDCnMSuvx
 qFdyvvTdmsTPrS+xsWKta10ofqh6BWtOIiv5aBILySJPKVtBZPeDqyXZxyYRtnpYrNwH
 lde/sOentJwsrPon53Yl1Mp+RXMTS9Gvn6f9D2sygvcCwPCX280w8fwIIBmgqj5KwTTf
 cnRAR6i/dnHnW/cBQ7C5olsviwT6u5tlOvSOMGxrhRJUi3A4FWHmeU4oP+KEBboCUOrQ
 ifFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679577; x=1731284377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1xac5W5zKwCyt+Affs+nBDH85dTqE+Fj+UGOQD6hfU=;
 b=m1+gSmrg4zDhU+Id2uSrnhMKIKIlmUrejC5M9abvBQgJs/oAMpbIXoO1lArb8q3H6f
 7iIYrC0OYTcv/cELZMCL9eUOKhfLe2JRdEZVysHWQENE1Nsi2mcWVUpmEyZz+FmfB/Ct
 Oc26ciTshJ+Zyv1DypAORN8xRtpH017iWTcmLDPpRCl1OTSCCIsIDFnxDAqgAvxhea5N
 w/sSyWjl54n7RHQfRvYMcFH1gMHUucfvsYsEXxb9x16BP4FWpS0DNfLJlBdiavaPgGU7
 b851s2CW8RMnoyeiAyDTtRUP/jt0kE3/QdOsKhrEmG8gKAQCDMJC0UxQRiBGUeJtbYx6
 sFNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyOrgBqDW6IHp+ibsSM+IJmJSpdvvF2XdVt9/ixX8owNF3SQXJQq4LP0Oo06G5XV+p7ybO2HVEjA==@nongnu.org
X-Gm-Message-State: AOJu0YzB+dRoeEFdBx8parjmhkxp0rzevVAU6kz82Uy1VwT8bsMAVpnf
 KiXBmG2dhzbkTHz537ubpo2kdXwECN366ppoDFYF/1Mmx0cZHp0EdxxYuw==
X-Google-Smtp-Source: AGHT+IH5cHPj72ksc9koh0cETtaxNbETBrj+9kfbgW9UZ2hzjdvV39jCmtTagZVgromXuWKTVmjQXg==
X-Received: by 2002:a05:6a00:3d4d:b0:71e:108e:9c16 with SMTP id
 d2e1a72fcca58-720c98d51ffmr16913733b3a.12.1730679577430; 
 Sun, 03 Nov 2024 16:19:37 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/67] target/ppc: Fix doorbell delivery to threads in powersave
Date: Mon,  4 Nov 2024 10:17:56 +1000
Message-ID: <20241104001900.682660-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



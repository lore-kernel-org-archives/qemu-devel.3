Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C086CC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 05:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnBO5-0000Rp-Fy; Thu, 21 Mar 2024 01:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rnBNs-0000Qq-6q; Thu, 21 Mar 2024 01:54:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rnBNq-0003ig-Kh; Thu, 21 Mar 2024 01:54:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e04ac200a6so4998385ad.1; 
 Wed, 20 Mar 2024 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711000466; x=1711605266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CRYxNjknx8CxsqzEeMCvnpqao4+OAfW/6TkG7xx3pL0=;
 b=fu/xHSI1lN2w04K3JV+tLg6wfGgNyi8OxoXlC32IGdTFbkq4xuibn4DPo5SKNsqChj
 mZPITKJVTkNW3fiBKIFdmjOu0an1WOQDeBea8rcbVsFlfJhyKMCSSSEIo5Sw5o3j2ZPX
 hsz/8+k4esrungJ+DP2+lMKrNuiWLuT1EMAt1VNUlx760gaa47cr69C8RfngnnQKIb9D
 vqObrmEMPrpShTfexWkuv18xLN+/9RX9Ls+Ut9xGKaZAuFDyA68tUF3/vXPUYqS9bnzj
 guNG6SlBkFfRXnl/neDDPEDsgI6AENPny8QvlXX7Rmi1nxxgwNjelhCOp6HDJyxUEC1L
 wJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711000466; x=1711605266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRYxNjknx8CxsqzEeMCvnpqao4+OAfW/6TkG7xx3pL0=;
 b=kZNDSGpT4aklw2M5GWCoomzEM+AhoTSYmYgyJCP11+H9MchM8Hp+E9UslpvlBuOoFy
 gbxspYd6OL6tuUolsGyprfc10QnxQbHfqfVPvZwksUDQ3OmRan4MSdLuV6Fek1OXrcr4
 Qb8JkB5entXg7FVefMme+iID5jAvVm0VtRSKdAFYT3OzrROnr09pO2SlgjP8CL+hY1v7
 74NKYZsX5hpJvW9tPsL/NQnSnS9qGdoqntBvfnoiHSqJb9zP1bP7zRDkGHfJPVZytZlh
 ekte3TdwzM5X9y5iaeNc/ARDKDmIxRSxXL0HusKE+ArBcKu9nVquujDgdn1f8kBBMoJF
 Eglg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnMY2CJYGfcD/tYFPCDqu5Ps719V52KYNVV20pb7nZ3p0ryhrRNRU6B0oHzl4CsHEo1q7OXwtPv4T8dlVeU/Opc6e+fRw=
X-Gm-Message-State: AOJu0YwYnUhW1walhFcjDCA3z2TadSZV8cVml7VauWF344NDrTCQq5j5
 fnkOcHDhr5FSqsBY1zDFVknR/U6KPqGFuUXCqPtgIRN3aJ2+mPqTh123xe8S
X-Google-Smtp-Source: AGHT+IF4OqeRqZOzMvADblKHNgBFcUKu7jQUCzks74MR8DAfaTA+KS7fDZpnJJJ/7dchKR3Hfd7Wzg==
X-Received: by 2002:a17:903:32d1:b0:1e0:188c:ad4f with SMTP id
 i17-20020a17090332d100b001e0188cad4fmr2813429plr.26.1711000466216; 
 Wed, 20 Mar 2024 22:54:26 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.241])
 by smtp.gmail.com with ESMTPSA id
 lh6-20020a170903290600b001d94678a76csm14746454plb.117.2024.03.20.22.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 22:54:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH] target/ppc: Do not clear MSR[ME] on MCE interrupts to
 supervisor
Date: Thu, 21 Mar 2024 15:54:15 +1000
Message-ID: <20240321055415.2441812-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

Hardware clears the MSR[ME] bit when delivering a machine check
interrupt, so that is what QEMU does.

The spapr environment runs in supervisor mode though, and receives
machine check interrupts after they are processed by the hypervisor,
and MSR[ME] must always be enabled in supervisor mode (otherwise it
could checkstop the system). So MSR[ME] must not be cleared when
delivering machine checks to the supervisor.

The fix to prevent supervisor mode from modifying MSR[ME] also
prevented it from re-enabling the incorrectly cleared MSR[ME] bit
when returning from handling the interrupt. Before that fix, the
problem was not very noticable with well-behaved code. So the
Fixes tag is not strictly correct, but practically they go together.

Found by kvm-unit-tests machine check tests (not yet upstream).

Fixes: 678b6f1af75ef ("target/ppc: Prevent supervisor from modifying MSR[ME]")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 80f584f933..674c05a2ce 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1345,9 +1345,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
              * clear (e.g., see FWNMI in PAPR).
              */
             new_msr |= (target_ulong)MSR_HVB;
+
+            /* HV machine check exceptions don't have ME set */
+            new_msr &= ~((target_ulong)1 << MSR_ME);
         }
-        /* machine check exceptions don't have ME set */
-        new_msr &= ~((target_ulong)1 << MSR_ME);
 
         msr |= env->error_code;
         break;
-- 
2.42.0



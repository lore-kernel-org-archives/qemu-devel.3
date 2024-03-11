Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE650C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklA-00054N-W7; Mon, 11 Mar 2024 14:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl3-0004yD-P4; Mon, 11 Mar 2024 14:52:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl0-0004ym-4O; Mon, 11 Mar 2024 14:52:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e68bab3e4cso1414821b3a.0; 
 Mon, 11 Mar 2024 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183135; x=1710787935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWEvA/D4WyZmP6kLaipe4fEneiVN5g7kT/C/fgmaO8U=;
 b=WdY74lqsWQz8BW4A5pmHFlKQG1FhrdLdGmvQNeXN1OrNmVDssRkvwXovIQEYVYHoPl
 tPUE/DYZxwEOr7tLIDeMpNqGD+mpT9CF/4reXyW0Lq8dl5zLKxqsaBV3XVynGPYAfY0Y
 nQ7s9G2BNF9kK+1+ylSVc3K4nS8ss4pvLF8fEnPUu3QdIxYzA6sIq671uLVEhqvdBVAD
 yWlmmW5pkIihhbtsm+bv6pipBd2AiYFezUVIfZgNzPjdJzOZkIYZqthIa1E3BCOvpjYF
 PjTFWhPOnR2jIha79tg+bWZ/yTKZwvnqNnPDxnXd/ODDGKBmPPHPqgkm24g+kFdMCJ2c
 evag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183135; x=1710787935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWEvA/D4WyZmP6kLaipe4fEneiVN5g7kT/C/fgmaO8U=;
 b=raFZJhNYYbesptkDGwcFvy1ZLt+nYXRu1FAAQc7nJXJGm1PmPX37uMKUNS5tdnRUHB
 drdi5BZQqYa6PW4D+w5PgGE373hN5sjJIuAuYr2hs8IcEVMv8T16hB5ukAyNzkjOKcKP
 uszM/THEAaE54e9qcVw15YMipiKhe0cXSfLhNc3qPye7fC6yxzrK7wtQapRYBmqhsTuz
 M9jRqOf6O2N0Tx73W0aT/5ahqpm1R3rtqinfIVqa5MMnmJ9eG6Et8sJM74L3N/85UYlU
 xP7ywyN/2jZmYIorjw8XWvc2a6HFH8QZ/sy1+/sXZeo5uEouLoySWnF1PTyj/RJokrTI
 uG/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWmLioLhbNlJZZFF9+BDajrAjHc7ToN1XRwyz4ngXzbodzeobIKgyrWb/cJeRYd2uSXHYo6mF8din+qYyAF3FB3UTgBCs=
X-Gm-Message-State: AOJu0YyxUARgmomSvQAX7NUolPBaX1OyumStEeOsGeCi3dN3c1YQI+WJ
 rSx8RL86urLh9JGhdIHtMrY8TvQCUW/dAgmlZXC82nn5TzRuRvfONlREsks0CGM=
X-Google-Smtp-Source: AGHT+IHXeoVZHLxUNp4UYs+6n1lqgNdsK/0N+Rz2eRmeTFGsLeRrofgNPJDfUJbhqqoGqcftl9TV7A==
X-Received: by 2002:a05:6a20:8411:b0:1a3:15e8:7e93 with SMTP id
 c17-20020a056a20841100b001a315e87e93mr4206489pzd.56.1710183134791; 
 Mon, 11 Mar 2024 11:52:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 02/13] target/ppc: POWER10 does not have transactional memory
Date: Tue, 12 Mar 2024 04:51:44 +1000
Message-ID: <20240311185200.2185753-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

POWER10 hardware implements a degenerate transactional memory facility
in POWER8/9 PCR compatibility modes to permit migration from older
CPUs, but POWER10 / ISA v3.1 mode does not support it so the CPU model
should not support it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 572cbdf25f..d7e84a2f40 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6573,7 +6573,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
+                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
                         PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
@@ -6617,7 +6617,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
-- 
2.42.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0CCD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqpi0-0002yM-9B; Sun, 31 Mar 2024 03:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphy-0002x0-Pq; Sun, 31 Mar 2024 03:34:26 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphx-0002FK-0u; Sun, 31 Mar 2024 03:34:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6b6f86975so2090779b3a.1; 
 Sun, 31 Mar 2024 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870463; x=1712475263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYXhV2tdfrK37fGeW/EVruixzcxS6jD0MeBRq3dZyY0=;
 b=V0yGoDh/L4RDA5hKBxpTZb/4Rwpb8nQZkP/2uOPjHJ8a0LkfPgk4eg7N38dX9j1rz8
 LMPGi78tX+V/Si5OhsD4JHXtNYJ/YDD3vj5eV0J+/rAWCmbxzLu6+coHzLmvqDj2/rcs
 Byu8WDoSaQdlERNfbqkARJ/O9xnLta3uKp2ObTmBiZEK02+sscH5iDoh4r5HyFl/TuA/
 9MT7FxhoMPgVkAwT+KlhW11jxehyed1rO3NzkBfsZdqbl/xglPmbuRRbhFQBnGooFe4J
 KyqkWEe1HpEq0TMsAfRyQSgnuW/LmwuqDa/OKtBaRFjuHn9mZ3LEZut1kZi/ZLAdGWIp
 P2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870463; x=1712475263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYXhV2tdfrK37fGeW/EVruixzcxS6jD0MeBRq3dZyY0=;
 b=BM8E7Ptg7diyy8K7EIgyQZsTzX+bRiqs1zNsxrg4v5F7Qxg30CK8DeeAFlGsD+ijN8
 HkKg3yi3M4neAo7ACrAgyxneZUaRlaDMXt1buQ5NWOa6Kvw87pyGc594aeCLQiloXmIQ
 wBbkSZ7HGc/ES/dQ1x83hZ8IBip8LcUXeg2qMLTYPRGSWyZsQuw0eZ3Febfkgk1Bk29t
 BO2MP29ONkwTPHc4881sBbZajy0gO/LifDVs6+obJjKCjiK0NcaeRLcAjaDc6hwwtWx0
 m07/qTZVOvkh1/gvazVi8VcD7VnDsaBiWYw1wXifqpTz+xoUa3gZADgPKPjpmR3qby3R
 UfRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGnzIm5EXpa3go7gbaqtUPXKna9B2Y+h8zturvWsQDFjuDc/NVeuCmuigEPmWK0+DwFDc4oNpgpdlQr4opiIqFgT7X
X-Gm-Message-State: AOJu0YwXV5tRCWtMmVfJRaZjzzidxXG/OyeE5F/6evHMXUnNQ8beS6Uw
 fgx2lVnAyIaFOdU98zuHIBs4L8rH55flU/IkaGYbFPlTYwcHnJI2cbeGj7OA2tY=
X-Google-Smtp-Source: AGHT+IGYCaa9jKETcIxs3FJpEFekUjX8IY1krLhvPXCEDvoTnXYxHb48Pw31nGlsAY6BNQiwHvNWOw==
X-Received: by 2002:a05:6a00:234b:b0:6ea:f369:f20f with SMTP id
 j11-20020a056a00234b00b006eaf369f20fmr5096673pfj.1.1711870462993; 
 Sun, 31 Mar 2024 00:34:22 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 6/8] target/ppc: Do not clear MSR[ME] on MCE interrupts to
 supervisor
Date: Sun, 31 Mar 2024 17:33:43 +1000
Message-ID: <20240331073349.88324-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
2.43.0



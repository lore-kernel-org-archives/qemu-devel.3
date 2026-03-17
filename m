Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CCCFEDA0D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aSO-00046E-GP; Tue, 17 Mar 2026 15:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSL-00045c-7j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:57 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSJ-0006Qv-Se
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BBD8A6132E;
 Tue, 17 Mar 2026 19:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A31C2BC86;
 Tue, 17 Mar 2026 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773777114;
 bh=5QpdIoSwsa33hR70/3MF/nBPFADPqiqC0KgaCFxH+0k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r8ihLwGGrWX/Z8F/rg9Ml+1gtfOFgwk+wdpgx/7RvxSPRTkYFApLFJkjzmDLvxoFo
 ezjxLqhJhs8vgIWoNyr+TIuhbHtwN6xS8dyWVnoDQ2H8A5Snhi4x9C8zhRbz6HGaR4
 F/51VPsvYpJPvKYvsJDqx74deLebru88CaIYctg2dtGpp4G1T8qThQv75GqBOfGkOy
 nIg7DHCcl9CUTsLEdpo6AbRiICEAOBc1k3Zhe1NPMnm2LU7pFubzE++4EfYOrVThM1
 8FvZoPkS8e7gG7KZWbL4tRi4SxHOLD9Y0U0kv5vwSs0apYU49DCLthB8RL4qkhtBQs
 wfb/P6ITDoGLA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 1/6] hw/hppa: Fix description of the HP A400-44 server
Date: Tue, 17 Mar 2026 20:51:44 +0100
Message-ID: <20260317195149.8386-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317195149.8386-1-deller@kernel.org>
References: <20260317195149.8386-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The HP A400-44 machine has a height of 2U and is a noisy server machine
which was usually running in the datacenter.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index ec63dc1297..e72dda2a68 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -840,7 +840,7 @@ static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
     };
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "HP A400-44 workstation";
+    mc->desc = "HP A400-44 server";
     mc->default_cpu_type = TYPE_HPPA_CPU_PA_8500;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_A400_init;
-- 
2.53.0



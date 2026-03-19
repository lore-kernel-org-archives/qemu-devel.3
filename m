Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55581091924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Kg2-0001e8-Sc; Thu, 19 Mar 2026 17:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfo-0001WA-Cl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:57 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfl-0003g7-ST
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F2CAE60053;
 Thu, 19 Mar 2026 21:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3C4C2BCAF;
 Thu, 19 Mar 2026 21:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773954764;
 bh=2hQQS3u8dFbtjaj1kNF4Ik9RF7v9bbbh6veMRrYN0NE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UG090AmNYJeb+jyRp+vRbnDI5fT1XxhM9jPc3uD/7uAE9EkxUoklPw2imGjLdjNYL
 3QqSSqlrINvkLkdsg5S37NaZxGwBYcg/Yjcgyq7dEMSNmlQ26qiWIKppuJQ/WyPhYs
 nSWgK9Jb26Pi0h3BGsGC+TeE/cNJ6sjiKctOKKI8AT//1OKyfmAtpc0o16zBPhjcCM
 LjCZ6oCDOL/hWpN93414Mku9Xuj1GQDMK1EnFrzPC0D/LDxaLGZc4LoS1Q1Qj5FJcR
 g+TKq5fEFT0lR9dc8femBjD7e6GgBGt8ygBgOu9WOqPIzxMtQZjKyIOIoaWhhTcIFA
 SAdFWyZcPjVXg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 1/6] hw/hppa: Fix description of the HP A400-44 server
Date: Thu, 19 Mar 2026 22:12:34 +0100
Message-ID: <20260319211239.7902-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319211239.7902-1-deller@kernel.org>
References: <20260319211239.7902-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Anton Johansson <anjo@rev.ng>
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



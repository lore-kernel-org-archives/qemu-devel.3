Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA1CD5BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgf5-0004or-9C; Wed, 20 May 2026 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgf0-0004jg-Ct; Wed, 20 May 2026 09:08:30 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgez-00013q-11; Wed, 20 May 2026 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=KBr+eThmA+MBGaQyD4UVjgIvKfhp9tToxz5pvwR4N+s=; b=C58IsVrLO1b9Ztk
 4jwR8HhZNod+ISI7fgec12AGpZMXiWNZP0lVVBFAXJKmk/tXocIX+idZf6inBYyhPX3Njj2l+xNXO
 wAuH3xGoR/i+Ye3nh9+ajagVX/DyXOmIybiM6gemIZEOapCtI8ltG2qDZA0XfRhhXde2Qkc1ghhZz
 7Q=;
Date: Wed, 20 May 2026 15:12:56 +0200
Subject: [PATCH v3 04/14] hw/core: Add riscv[32|64] to "none" machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-4-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=1009;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=8f6I0VnvVGlvMvWpcxdVl8U3hc8+tzDWCh8MK76yqVs=;
 b=qxt5jGc6HUsKkbQ7MrMwS1jk35BCB62HzQjP0HpbaGj5ITDu50D3dtSePkkrbC0IS7yA89g7K
 aA59oNBTEyQA+lr28pnGJfFdp/5BTR8tJMlLeqbbm+4lBtBoVTwVB2F
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/core/null-machine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index c52b022d3a..f132a7b89b 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,7 @@
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/riscv/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -59,4 +60,6 @@ static void machine_none_machine_init(MachineClass *mc)
 DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
                                { TYPE_TARGET_AARCH64_MACHINE },
                                { TYPE_TARGET_ARM_MACHINE },
+                               { TYPE_TARGET_RISCV32_MACHINE },
+                               { TYPE_TARGET_RISCV64_MACHINE },
                                { })

-- 
2.52.0



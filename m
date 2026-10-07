Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9486CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwb-0004et-Gd; Wed, 07 Oct 2026 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAR-0004g4-Sk; Wed, 07 Oct 2026 04:38:28 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAQ-0006Yn-A1; Wed, 07 Oct 2026 04:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=BcvmsCfkhW/JCWkB8esYJ31ggAsLPtPnupvcj2f63fE=; b=HaWaBIp6Gw/qPuM
 JFzHqCQda7ahQptn7B64WdWa2FPtrnTiMXNkJWyD4Yi5vJYSuMieREFvxOEaJLDvXAYkd3V8z3oRp
 8Clwd2X6UG4rkg9fqW5qvhnpI85usQhVomiiBxq3E2swzIEyMzzuU/q3K9o5OURp4ReyZ/bvVM4WY
 A4=;
Date: Wed, 07 Oct 2026 10:43:23 +0200
Subject: [PATCH v2 17/18] target/riscv: Compile time_helper.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-17-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=796;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=ctxRfoae721M8Ea7yyh/3oyq7HR57rqRvax3PHXxBhQ=;
 b=mIIMLFg5r+O3aZhOb529Snn9lN1eEgR2L1MNjlVE5gou/JKWo3ZD+xtIOKpRm4SJ+13qqYNMJ
 ljyR/sEojsUBHvEJZzTK/oWmnxNSHcTIeDqEKv7vK8NLqmVo+X4vRRm
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

File is already agnostic to target specifics at this point.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index b5ec6cdcd8..d20eaa2269 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -23,7 +23,6 @@ riscv_stubs_ss = ss.source_set()
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'monitor.c',
-  'time_helper.c',
 ))
 
 riscv_user_ss = ss.source_set()
@@ -38,6 +37,7 @@ riscv_common_system_ss.add(files(
   'cpu.c',
   'machine.c',
   'riscv-qmp-cmds.c',
+  'time_helper.c',
 ))
 
 subdir('tcg')

-- 
2.52.0



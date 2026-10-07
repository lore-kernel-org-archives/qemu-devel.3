Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E9CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsG-0003xS-Mv; Wed, 07 Oct 2026 05:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAQ-0004ZW-TT; Wed, 07 Oct 2026 04:38:26 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAP-0006Yh-9J; Wed, 07 Oct 2026 04:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=hJAXKPO1GZMKOhLEQ5kzX/DppAyvRoYENfTXOao/lD8=; b=uNdveiiLu34+D8T
 MjgDunkABOhc6GYfp95av8w0+SgzGgu0/72pKLItWdswuw3fR2oMYKBTT5eWrlWvD7A92k5yJmabQ
 SlscFOkPyw1kk892ny3GTvr3SEGt1V/sbkCQ6qgxwuXR9OKka8/RjXXvkztonz53EpRsuZrHwsZJm
 nQ=;
Date: Wed, 07 Oct 2026 10:43:22 +0200
Subject: [PATCH v2 16/18] target/riscv: Compile machine.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-16-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=2448;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=2bAoYSvQaNcTmGOQfwCUHA19jbVkCNWNZVmrqC+7MM8=;
 b=QHpbBbmtTfwnnlnJ1QGqMBWZwkt+NMC1pVOo4kWe/jcdO73FErN0rCBlqIt55vtD7CZvIXy4v
 8aAqtiNyBArCIiFLcSJTRcXrU/+Mnigr3bPwOUaw7z0GtzOZBCTqqlQ
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

There's now also no change in migration stream between KVM/non-KVM
configurations, KVM fields are filtered out via .is_needed().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/machine.c   | 10 +---------
 target/riscv/meson.build |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffce..ddcab8a667 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -21,12 +21,10 @@
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
-#include "migration/cpu.h"
+#include "migration/vmstate.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
-#ifdef CONFIG_KVM
 #include "kvm/kvm_riscv.h"
-#endif
 
 static bool pmp_needed(void *opaque)
 {
@@ -196,7 +194,6 @@ static const VMStateDescription vmstate_rv128 = {
     }
 };
 
-#ifdef CONFIG_KVM
 static bool kvmtimer_needed(void *opaque)
 {
     return kvm_enabled();
@@ -262,7 +259,6 @@ static const VMStateDescription vmstate_kvm_mp_state = {
         VMSTATE_END_OF_LIST()
     }
 };
-#endif
 
 static bool debug_needed(void *opaque)
 {
@@ -499,9 +495,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 12,
     .minimum_version_id = 12,
-#ifdef CONFIG_KVM
     .pre_load = riscv_cpu_kvm_pre_load,
-#endif
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
@@ -563,10 +557,8 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_vector,
         &vmstate_pointermasking,
         &vmstate_rv128,
-#ifdef CONFIG_KVM
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
-#endif
         &vmstate_envcfg,
         &vmstate_debug,
         &vmstate_smstateen,
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 28a6ff8553..b5ec6cdcd8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -23,7 +23,6 @@ riscv_stubs_ss = ss.source_set()
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'monitor.c',
-  'machine.c',
   'time_helper.c',
 ))
 
@@ -37,6 +36,7 @@ riscv_user_ss.add(files(
 riscv_common_system_ss.add(files(
   'arch_dump.c',
   'cpu.c',
+  'machine.c',
   'riscv-qmp-cmds.c',
 ))
 

-- 
2.52.0



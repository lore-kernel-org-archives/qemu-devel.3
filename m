Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0279CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJ81-0005PX-4s; Thu, 01 Oct 2026 11:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ6y-0004is-HM; Thu, 01 Oct 2026 11:54:23 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ6x-0005ZW-1W; Thu, 01 Oct 2026 11:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=fipokf+dZ8LL58inWteQV8PJfvPScbi7IgelDYDKFWA=; b=nqjBmalVLRFZOXB
 6Q7QNjwY/LRbxrQuO39mBaTy5RGRgP8jbtodzpklOSNBLTPoRgdLXk8eix3t9rFxewRkIwt65azQj
 fG7k7ldlojymXX2aZsdeJg0xODp9z5bnuZP6lst4v+4zd+3INb3hlHxTQR7qPRrVGdF3hYS8rHPhz
 iA=;
Date: Thu, 01 Oct 2026 17:59:32 +0200
Subject: [PATCH 09/18] target/riscv: Stub KVM functions for
 machines.c/cpu.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-rv-dedup-v1-9-ea69b07afd31@rev.ng>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
In-Reply-To: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790870392; l=1035;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=sreVpsJzfcKpemRaaeFAzglIDW3RLuPUMSsHIYzpG1g=;
 b=X5NOrphjy5tX1jrR19kixciGCU+atF8X75FQjZkvfJgsFgPO4O1BqDPvAAY41IXbHDMmLN6S0
 BabWHcV0AhgDGozlLT1rw3dUYSNVknqsI0oBC9Fcakk/yzmGv4UpubB
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

In order to compile cpu.c and machine.c once for system mode and keep
the linker happy in a single binary setting, we need to stub out some
required functions otherwise only available under CONFIG_KVM.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/kvm/kvm-stub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 64e39c96d8..5dc91b9265 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -21,3 +21,24 @@ uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    g_assert_not_reached();
+}
+
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_riscv_has_mp_state(void)
+{
+    g_assert_not_reached();
+}
+

-- 
2.52.0



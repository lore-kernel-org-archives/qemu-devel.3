Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820ABCD98E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUbO-0008A8-5i; Sat, 13 Jun 2026 16:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbJ-00087O-Pi; Sat, 13 Jun 2026 16:05:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbH-0008MA-QZ; Sat, 13 Jun 2026 16:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381067; bh=6ihxfYXP3fuUJ0eR2tjhR/1P86781N2QdMQNSeeBnjI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WVGtfCQ64q1QmpE5IiaK8ulO4EoSaUfLbEOrdhwx+LnB+pONz4lPCb0bXpcNYFRkZ
 byKtbiGGUeiofA0hj+kW2myHXcxLbAy1DeomaeDaZemlXuMzcC5lVPWgvsUBVeeMHj
 Qat32OFJlehS9jap+Nm5DzKfzvcl+78XWZKqZUVZyZ7XqMPm4ysYlLsLVToQsAK7sU
 Wnr6KioyaHbD4xMApo/iyS2LkXyXtaZq0CLwuhZAmqtGxCwWlY0p0XCkwhvo2HmeEH
 fJ4+NdREprD/oFGEM4kas2ex7fF59ggPIOVF1gpG+8b8ebMPgZ/K7JUo4x4aZcBqGu
 phnWzo0Je3O6A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88CAB1B6E71;
 Sat, 13 Jun 2026 23:04:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4ADC3CE8D4;
 Sat, 13 Jun 2026 23:04:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 10/61] target/riscv: Add mseccfg to VMStateDescription
Date: Sat, 13 Jun 2026 23:02:53 +0300
Message-ID: <20260613200411.1808021-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zishun Yi <vulab@iscas.ac.cn>

Currently, the Machine Security Configuration Register (mseccfg) was
missing from the live migration state. This omission causes the register
to be reset to zero on the destination host after migration.

Fixed by adding vmstate_mseccfg subsection

This vulnerability was discovered and reported by SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/a22e4459cd026ae970791dfbd9cfe5d110fbd46b/output/riscv-isa-manual/pr-1879/qemu.txt#L121
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260511124828.3210477-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit eccb1d6940256668109dc6dc42450ced9f324134)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18d790af0d..72d0668622 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -425,6 +425,25 @@ static const VMStateDescription vmstate_sstc = {
     }
 };
 
+static bool mseccfg_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_smepmp || cpu->cfg.ext_zkr
+        || cpu->cfg.ext_smmpm || cpu->cfg.ext_zicfilp;
+}
+
+static const VMStateDescription vmstate_mseccfg = {
+    .name = "cpu/mseccfg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mseccfg_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -502,6 +521,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ssp,
         &vmstate_ctr,
         &vmstate_sstc,
+        &vmstate_mseccfg,
         NULL
     }
 };
-- 
2.47.3



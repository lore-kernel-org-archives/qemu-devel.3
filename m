Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C30E112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLf-0007qV-Q4; Wed, 11 Mar 2026 15:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PLY-0007lZ-IR; Wed, 11 Mar 2026 15:35:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PLW-0000CI-Qo; Wed, 11 Mar 2026 15:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257667; bh=pUGIMTWA4e1w1FD3KpoHramUOpN7AwMoUPPLi4R07Ls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BJUIl0vhXi2dKmo+/yQSsplMqbBpZThU1HQzvK7RV28hC3G/Sf35Hk8o5CpMJ+R9V
 7MlcF/EDjDHX6NLXEjOV1PzCx9yU38TY2g2SRZhpKjbF3fDS+0enaIG3Su6d+IkdAp
 xZhFpd3ObHJ40HycqmJWfS4Qe9Gxo8YvXOnt2qm2pVq/pDAWPYszkiscfN0rJ5mufu
 AEFxRqKmBL/wjchwWR7QaGyFknsoauIEI3rKjee+PhVdhcXAhuo5dlc743/gXKJEZv
 sz6I4HCJlh62BojeuEw0rP3R0ZSoVQpmUPrct8lxt0dJ9UZLHdllf/vjeuwFYSP9e6
 ySw4Y9J7jmHvw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 487661920F7;
 Wed, 11 Mar 2026 22:34:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 81E0A37C45C;
 Wed, 11 Mar 2026 22:35:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 15/53] hw/hppa: Add BMC on 64-bit machines only
Date: Wed, 11 Mar 2026 22:34:08 +0300
Message-ID: <20260311193449.1096110-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Prevent adding the BMC with it's serial ports on 32-bit machines, even
if they have a PCI bus like the B160L. This fixes boot problems with
HP-UX on B160L.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 557bc5260cfd ("hw/hppa: PCI devices depend on availability of PCI bus")
Cc: qemu-stable@nongnu.org
Reviewed-by: Anton Johansson <anjo@rev.ng>
(cherry picked from commit 16786eb7bf8644398707e64fff12e4c9564ec131)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8c66eed5a2..1a0b8c7648 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -376,7 +376,9 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
+    }
 
+    if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
         dev = qdev_new("diva-gsp");
         if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
-- 
2.47.3



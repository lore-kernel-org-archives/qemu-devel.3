Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7C6CAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqiv0-0001CY-Dd; Tue, 17 Sep 2024 20:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqiuy-0001Bz-1k
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:51:40 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqiuw-0002to-FZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=rh35z3M1x/AoX8xMUxtDK+qI3N/rePVmEEJoVlO8WSw=; b=At9i12n++1J1AFg1
 FoB551v9pweKdIyljCeIXVsXx61aUWyTmV34iRtMtamrAVEGppMar2cSNXiESPMMmj/ThF7MQwk1U
 NEb9iB5gAfaO4TCVg4kprnQN3OOd0Y4ylYE7SrSQIF+qjHbOfKcOSki0rkl077ZbkvZ37IXMgJUPN
 L2wy1dkX+mLu7XqPzpSZ1oU7uFoIqmGSB4DmpaQlnzMsJswxaX7Lpm1NANkP+Z7etBdxJRHoK17ea
 go6pUmuvjl15XADLHv36U8+MCc9/Yh8hKb82yyRokVlI7l2+zB3wdMk8WswjgUARMhQFocptN/QKU
 yzWSq3FaN6Wx+Xf5/g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqiur-006DsL-1P;
 Wed, 18 Sep 2024 00:51:33 +0000
From: dave@treblig.org
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] q35: Remove unused mch_mcfg_base
Date: Wed, 18 Sep 2024 01:51:32 +0100
Message-ID: <20240918005132.187517-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

mch_mcfg_base has been unused since it was added by
  6f1426ab0f ("ich9: APIs for pc guest info")
back in 2013.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/pci-host/q35.c         | 10 ----------
 include/hw/pci-host/q35.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index d5a657a02a..f3e713318e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -662,16 +662,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
                                    OBJECT(&mch->smram));
 }
 
-uint64_t mch_mcfg_base(void)
-{
-    bool ambiguous;
-    Object *o = object_resolve_path_type("", TYPE_MCH_PCI_DEVICE, &ambiguous);
-    if (!o) {
-        return 0;
-    }
-    return MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT;
-}
-
 static Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
                        16),
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 22fadfa3ed..ddafc3f2e3 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -181,8 +181,6 @@ struct Q35PCIHost {
 #define MCH_PCIE_DEV                           1
 #define MCH_PCIE_FUNC                          0
 
-uint64_t mch_mcfg_base(void);
-
 /*
  * Arbitrary but unique BNF number for IOAPIC device.
  *
-- 
2.46.0



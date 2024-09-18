Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21E5CDD560
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr4Ou-0006RC-Tl; Wed, 18 Sep 2024 19:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr4Or-0006QW-B3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:47:57 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr4Om-0001Hh-VB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=/qxtQNwrCivo4dN/OR1fR2NDTLzSIFs2epv7qFvwD9Q=; b=dSDe+Ltc2JSJ9luq
 pCUbePx7f1fEsV8iMz3u1ZcWzyFJRhg7gpGfOnSXkl2Yj2OaJHNXM0Ews/tSSWle0QDKYL047XyY2
 YGbyyWtHWak/uBUvEixozBtAcRR1PfBVxkHLjOob/iwtgBsE61a+fgFL8hVxC+K1Lj/Kr6n9Nhu0v
 td0odHgSoUBOCmSWDMhTolsxG5axBCukFARGG741LjCpJXUtRnEEVwXyw3NeRU/tjBe0NE755t1Dj
 Af8stsDAoCuNt9Zu6wIFTph5dfraLzRJWqZawnR+tjqNSJh9FxRizAKWOGL/T2IUEv8B5lDyCiRyH
 4qXNV47+CPb0RNy7Mg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr4Oj-006M1t-0R;
 Wed, 18 Sep 2024 23:47:49 +0000
From: dave@treblig.org
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hw/pci: Remove unused pcie_chassis_find_slot
Date: Thu, 19 Sep 2024 00:47:48 +0100
Message-ID: <20240918234748.468148-1-dave@treblig.org>
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

pcie_chassis_find_slot has been unused since it was added.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/pci/pcie_port.c         | 10 ----------
 include/hw/pci/pcie_port.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 20ff2b39e8..9f978ba164 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -92,16 +92,6 @@ static PCIESlot *pcie_chassis_find_slot_with_chassis(struct PCIEChassis *c,
     return s;
 }
 
-PCIESlot *pcie_chassis_find_slot(uint8_t chassis_number, uint16_t slot)
-{
-    struct PCIEChassis *c;
-    c = pcie_chassis_find(chassis_number);
-    if (!c) {
-        return NULL;
-    }
-    return pcie_chassis_find_slot_with_chassis(c, slot);
-}
-
 int pcie_chassis_add_slot(struct PCIESlot *slot)
 {
     struct PCIEChassis *c;
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 90e6cf45b8..7cd7af8cfa 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -72,7 +72,6 @@ struct PCIESlot {
 };
 
 void pcie_chassis_create(uint8_t chassis_number);
-PCIESlot *pcie_chassis_find_slot(uint8_t chassis, uint16_t slot);
 int pcie_chassis_add_slot(struct PCIESlot *slot);
 void pcie_chassis_del_slot(PCIESlot *s);
 
-- 
2.46.0



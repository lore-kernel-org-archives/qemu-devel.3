Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C350AC3ABBA
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbmf-0004wr-LF; Sun, 04 May 2025 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmb-0004ow-FS; Sun, 04 May 2025 12:01:37 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmY-0004Ad-CY; Sun, 04 May 2025 12:01:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B404155D237;
 Sun, 04 May 2025 18:01:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rDJsTQnawBZ5; Sun,  4 May 2025 18:01:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C935E55D230; Sun, 04 May 2025 18:01:30 +0200 (CEST)
Message-ID: <04bbdb7bcec7a4f1f88a903d782fd8737c7b8036.1746374076.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746374076.git.balaton@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 04/16] hw/pci-host/raven: Simplify host bridge type declaration
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 04 May 2025 18:01:30 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Use OBJECT_DECLARE_SIMPLE_TYPE macro instead of open coding it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 172f01694c..878c915de5 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -39,11 +39,9 @@
 #define TYPE_RAVEN_PCI_DEVICE "raven"
 #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
 
-typedef struct PRePPCIState PREPPCIState;
-DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
-                         TYPE_RAVEN_PCI_HOST_BRIDGE)
+OBJECT_DECLARE_SIMPLE_TYPE(PREPPCIState, RAVEN_PCI_HOST_BRIDGE)
 
-struct PRePPCIState {
+struct PREPPCIState {
     PCIHostState parent_obj;
 
     OrIRQState *or_irq;
-- 
2.41.3



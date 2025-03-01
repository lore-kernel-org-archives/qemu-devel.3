Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9044CC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 14:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toNxB-0001TG-6M; Sat, 01 Mar 2025 09:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwL-00019k-0W
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toNwH-00017g-CF
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 09:35:39 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 160C54E60F7;
 Sat, 01 Mar 2025 15:35:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Y9hyjc1MESdb; Sat,  1 Mar 2025 15:35:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3966F4E6067; Sat, 01 Mar 2025 15:35:33 +0100 (CET)
Message-Id: <08d9900af04789ede485942c8072eaa58bf52f80.1740839457.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740839457.git.balaton@eik.bme.hu>
References: <cover.1740839457.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/4] hw/nvram/eeprom_at24c: Use OBJECT_DECLARE_SIMPLE_TYPE
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sat, 01 Mar 2025 15:35:33 +0100 (CET)
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

No need to open code it so use the simple object type declaration.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/nvram/eeprom_at24c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index a40cc5dd15..2ae03935d4 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -30,9 +30,7 @@
                             ## __VA_ARGS__)
 
 #define TYPE_AT24C_EE "at24c-eeprom"
-typedef struct EEPROMState EEPROMState;
-DECLARE_INSTANCE_CHECKER(EEPROMState, AT24C_EE,
-                         TYPE_AT24C_EE)
+OBJECT_DECLARE_SIMPLE_TYPE(EEPROMState, AT24C_EE)
 
 struct EEPROMState {
     I2CSlave parent_obj;
-- 
2.30.9



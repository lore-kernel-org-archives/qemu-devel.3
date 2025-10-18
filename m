Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC974CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 14:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA7Yo-0000Ec-ET; Sat, 18 Oct 2025 10:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA7YO-0008LT-Va; Sat, 18 Oct 2025 10:05:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA7YM-0006zD-J6; Sat, 18 Oct 2025 10:05:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ED7F95972FB;
 Sat, 18 Oct 2025 16:05:00 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Wuu03SvqJFsv; Sat, 18 Oct 2025 16:04:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0129D5972F8; Sat, 18 Oct 2025 16:04:59 +0200 (CEST)
Message-ID: <b5b0150b6c579b10682f6482e7832cf381ffb759.1760795082.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1760795082.git.balaton@eik.bme.hu>
References: <cover.1760795082.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 14/16] hw/ppc/prep: Always create prep-systemio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Sat, 18 Oct 2025 16:04:59 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The prep-systemio device models the system control ports of the 40p
machine which is not an optional pluggable device but part of the
system so it should not be disabled by -nodefaults but always created.

Additionally remove some line breaks to make lines related to one
device appear in one block for logical separation from other devices.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/prep.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index ead91ec851..973d2fb7eb 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -317,6 +317,13 @@ static void ibm_40p_init(MachineState *machine)
     sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
+    /* system control ports */
+    isa_dev = isa_new("prep-systemio");
+    dev = DEVICE(isa_dev);
+    qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
+    qdev_prop_set_uint32(dev, "equipment", 0xc0);
+    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+
     /* Memory controller */
     isa_dev = isa_new("rs6000-mc");
     dev = DEVICE(isa_dev);
@@ -342,7 +349,6 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
-
         if (machine->audiodev) {
             qdev_prop_set_string(dev, "audiodev", machine->audiodev);
         }
@@ -353,14 +359,7 @@ static void ibm_40p_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "config", 12);
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
-        isa_dev = isa_new("prep-systemio");
-        dev = DEVICE(isa_dev);
-        qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
-        qdev_prop_set_uint32(dev, "equipment", 0xc0);
-        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
-
-        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
-                                       "lsi53c810"));
+        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810"));
         lsi53c8xx_handle_legacy_cmdline(dev);
         qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
-- 
2.41.3



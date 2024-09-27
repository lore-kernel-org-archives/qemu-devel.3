Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01619CEBF8A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su6i7-0005M8-Af; Fri, 27 Sep 2024 04:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1su6i5-0005KY-R5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 04:52:21 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1su6hz-0005od-PJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 04:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=9ZoQa
 4iIChW1XyvkqEYZejNvmSqeCMWROLPSRnxYNwM=; b=B3l+3loBQ3PR01hrXosAS
 8NMf0hxeb6v8mSukZEB+AWhmF7NVwj/+nayLIwvZkl9uTGiQG6wi0zI0NQp/xyqw
 NSdnP3JWlku7iAsziDyQBhohda1Cu92naBmSFn1APQUH6FnLeryjZ/ML3uf58tRT
 fZr8Gsbdnt6Ud1TkOC/4gU=
Received: from localhost.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgD31KoOcvZmhEQ4AQ--.49283S3;
 Fri, 27 Sep 2024 16:51:26 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v2 1/2] xilink_zynq: Add various missing unimplemented devices
Date: Fri, 27 Sep 2024 16:51:18 +0800
Message-ID: <e908ac801a37947a8efa02cf87c06578b5212ac7.1727425255.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727425255.git.chao.liu@yeah.net>
References: <cover.1727425255.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgD31KoOcvZmhEQ4AQ--.49283S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF45Kr13Aw1UtF45AFWfAFb_yoW5uFy8pF
 45CFW5KrW8JrZrZ3yfXrn2qFyaqws5Cas8J34Iy348uFZ2kr1kAr4vq3Z3JFWrXayDt3W3
 XFyayF15Kr1jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6uWJUUUUU=
X-Originating-IP: [117.173.247.123]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCQ1nKGb2J2jWFAAAsW
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add PMU, CAN, GPIO, I2C, and other as unimplemented devices.

Remove a ignore_memory_transaction_failures concurrently.

This allows operating systems such as Linux to run emulations such as xilinx_zynq-7000

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 hw/arm/xilinx_zynq.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 37c234f5ab..535e1b35a2 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -34,6 +34,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
 #include "sysemu/reset.h"
 #include "qom/object.h"
 #include "exec/tswap.h"
@@ -232,6 +233,50 @@ static void zynq_init(MachineState *machine)
     /* DDR remapped to address zero.  */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
+    /* Compatible RAZ/WI behavior for accessing memory */
+    create_unimplemented_device("znyq.unimp", 0, 4 * GiB);
+
+    /* PMU */
+    create_unimplemented_device("pmu.region0", 0xf8891000, 0x1000);
+    create_unimplemented_device("pmu.region1", 0xf8893000, 0x1000);
+
+    /* CAN */
+    create_unimplemented_device("amba.can0", 0xe0008000, 0x1000);
+    create_unimplemented_device("amba.can1", 0xe0009000, 0x1000);
+
+    /* GPIO */
+    create_unimplemented_device("amba.gpio0", 0xe000a000, 0x1000);
+
+    /* I2C */
+    create_unimplemented_device("amba.i2c0", 0xe0004000, 0x1000);
+    create_unimplemented_device("amba.i2c1", 0xe0005000, 0x1000);
+
+    /* Interrupt-Controller */
+    create_unimplemented_device("amba.intc.region0", 0xf8f00100, 0x100);
+    create_unimplemented_device("amba.intc.region1", 0xf8f01000, 0x1000);
+
+    /* Memory-Controller */
+    create_unimplemented_device("amba.mc", 0xf8006000, 0x1000);
+
+    /* SMCC */
+    create_unimplemented_device("amba.smcc", 0xe000e000, 0x1000);
+    create_unimplemented_device("amba.smcc.nand0", 0xe1000000, 0x1000000);
+
+    /* Timer */
+    create_unimplemented_device("amba.global_timer", 0xf8f00200, 0x20);
+    create_unimplemented_device("amba.scutimer", 0xf8f00600, 0x20);
+
+    /* WatchDog */
+    create_unimplemented_device("amba.watchdog0", 0xf8005000, 0x1000);
+
+    /* Other */
+    create_unimplemented_device("amba.efuse", 0xf800d000, 0x20);
+    create_unimplemented_device("amba.etb", 0xf8801000, 0x1000);
+    create_unimplemented_device("amba.tpiu", 0xf8803000, 0x1000);
+    create_unimplemented_device("amba.funnel", 0xf8804000, 0x1000);
+    create_unimplemented_device("amba.ptm.region0", 0xf889c000, 0x1000);
+    create_unimplemented_device("amba.ptm.region1", 0xf889d000, 0x1000);
+
     /* 256K of on-chip memory */
     memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
                            &error_fatal);
@@ -394,7 +439,6 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
     mc->no_sdcard = 1;
-    mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
     prop = object_class_property_add_str(oc, "boot-mode", NULL,
-- 
2.46.1



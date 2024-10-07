Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C40DCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlrg-0007KQ-OF; Mon, 07 Oct 2024 07:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1sxlrd-0007Ja-6P
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:21 -0400
Received: from mail-m16.yeah.net ([1.95.21.15])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1sxlra-00017V-Ev
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=j9pJU
 IL6fKrBSqTBFRkUPOcDY6roUesYrjXNJwRS7xc=; b=o7ecrapbAByWxyvgPVqQw
 rJyjCClbj4NuQu5KVUIZ3tM65wP55IG3J/sugXR9mxufgY/O53jglfY3LQe1BN6+
 +1O3pYsizM4PP1ct4BKVBmJE91YTNs9oUalyZW823dJUl8lOLkG5MsWWjV/bnGbh
 hdEhLb4eWA2/vGI2Be8/QY=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgAnSOcMxQNnGGjGAQ--.32547S3;
 Mon, 07 Oct 2024 19:25:00 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v4 1/3] xilink_zynq: Add various missing unimplemented devices
Date: Mon,  7 Oct 2024 19:24:53 +0800
Message-ID: <211e7645ae2c04c361345514655c1ba0d4e10488.1728299530.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728299530.git.chao.liu@yeah.net>
References: <cover.1728299530.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgAnSOcMxQNnGGjGAQ--.32547S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw15Xr48Kw17KryUKry3urg_yoWruF15pF
 4rCFZ8KrW8KrsrZ3yIgrn7XFyaqw1rAas8uw1fA3yUWFWqkr93WrnYy3WfJF9xXayqq3W3
 Xw17AF45Gw1UKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8wIDUUUUU=
X-Originating-IP: [112.19.146.115]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEQpxKGcDw+gCTwABsB
Received-SPF: pass client-ip=1.95.21.15; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add xilinx zynq board memory mapping is implemented in the device.

Remove a ignore_memory_transaction_failures concurrently.

See: ug585-Zynq-7000-TRM manual B.3 (Module Summary)
Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 hw/arm/xilinx_zynq.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 37c234f5ab..ca21b313b7 100644
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
@@ -373,6 +374,75 @@ static void zynq_init(MachineState *machine)
     sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
+    /*
+     * Refer to the ug585-Zynq-7000-TRM manual B.3 (Module Summary) and
+     * the zynq-7000.dtsi. Add placeholders for unimplemented devices.
+     */
+    create_unimplemented_device("zynq.i2c0", 0xE0004000, 4 * KiB);
+    create_unimplemented_device("zynq.i2c1", 0xE0005000, 4 * KiB);
+    create_unimplemented_device("zynq.can0", 0xE0008000, 4 * KiB);
+    create_unimplemented_device("zynq.can1", 0xE0009000, 4 * KiB);
+    create_unimplemented_device("zynq.gpio", 0xE000A000, 4 * KiB);
+    create_unimplemented_device("zynq.smcc", 0xE000E000, 4 * KiB);
+
+    /* Direct Memory Access Controller, PL330, Non-Secure Mode */
+    create_unimplemented_device("zynq.dma_ns", 0xF8004000, 4 * KiB);
+
+    /* System Watchdog Timer Registers */
+    create_unimplemented_device("zynq.swdt", 0xF8005000, 4 * KiB);
+
+    /* DDR memory controller */
+    create_unimplemented_device("zynq.ddrc", 0xF8006000, 4 * KiB);
+
+    /* AXI_HP Interface (AFI) */
+    create_unimplemented_device("zynq.axi_hp0", 0xF8008000, 0x28);
+    create_unimplemented_device("zynq.axi_hp1", 0xF8009000, 0x28);
+    create_unimplemented_device("zynq.axi_hp2", 0xF800A000, 0x28);
+    create_unimplemented_device("zynq.axi_hp3", 0xF800B000, 0x28);
+
+    create_unimplemented_device("zynq.efuse", 0xF800d000, 0x20);
+
+    /* Embedded Trace Buffer */
+    create_unimplemented_device("zynq.etb", 0xF8801000, 4 * KiB);
+
+    /* Cross Trigger Interface, ETB and TPIU */
+    create_unimplemented_device("zynq.cti_etb_tpiu", 0xF8802000, 4 * KiB);
+
+    /* Trace Port Interface Unit */
+    create_unimplemented_device("zynq.tpiu", 0xF8803000, 4 * KiB);
+
+    /* CoreSight Trace Funnel */
+    create_unimplemented_device("zynq.funnel", 0xF8804000, 4 * KiB);
+
+    /* Instrumentation Trace Macrocell */
+    create_unimplemented_device("zynq.itm", 0xF8805000, 4 * KiB);
+
+    /* Cross Trigger Interface, FTM */
+    create_unimplemented_device("zynq.cti_ftm", 0xF8809000, 4 * KiB);
+
+    /* Fabric Trace Macrocell */
+    create_unimplemented_device("zynq.ftm", 0xF880B000, 4 * KiB);
+
+    /* Cortex A9 Performance Monitoring Unit, CPU */
+    create_unimplemented_device("cortex-a9.pmu0", 0xF8891000, 4 * KiB);
+    create_unimplemented_device("cortex-a9.pmu1", 0xF8893000, 4 * KiB);
+
+    /* Cross Trigger Interface, CPU */
+    create_unimplemented_device("zynq.cpu_cti0", 0xF8898000, 4 * KiB);
+    create_unimplemented_device("zynq.cpu_cti1", 0xF8899000, 4 * KiB);
+
+    /* CoreSight PTM-A9, CPU */
+    create_unimplemented_device("cortex-a9.ptm0", 0xF889c000, 4 * KiB);
+    create_unimplemented_device("cortex-a9.ptm1", 0xF889d000, 4 * KiB);
+
+    /* AMBA NIC301 TrustZone */
+    create_unimplemented_device("zynq.trustZone", 0xF8900000, 0x20);
+
+    /* AMBA Network Interconnect Advanced Quality of Service (QoS-301) */
+    create_unimplemented_device("zynq.qos301_cpu", 0xF8946000, 0x130);
+    create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
+    create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
+
     zynq_binfo.ram_size = machine->ram_size;
     zynq_binfo.board_id = 0xd32;
     zynq_binfo.loader_start = 0;
@@ -394,7 +464,6 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
     mc->no_sdcard = 1;
-    mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
     prop = object_class_property_add_str(oc, "boot-mode", NULL,
-- 
2.46.1



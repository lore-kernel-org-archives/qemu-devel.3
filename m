Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F653CF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 16:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx7JE-0008JI-8L; Sat, 05 Oct 2024 12:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1sx7JC-0008Iu-Bp
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:07:06 -0400
Received: from mail-m16.yeah.net ([1.95.21.14])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1sx7JA-0002aJ-9p
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Xla+E
 A8qRYrB7ivezOYRniSwbMZHRHRQUQ/0GUXCzao=; b=ctDV65rYI/669GNWfYdPn
 gO9xuflqFgPBw25/dW74pE/Iao0DReCo4r+p7NhiwW/H5ooueaz2rrh4BtuuDNOT
 hvJHYJFJXP4lehrhj5xVeqgY64VaN885pYt7KwNMf/HRd8H0DkPe5ueKfki3G66i
 w37dPtkkfyn/HHWWFX75YA=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgCnyun1YwFnyEiwAQ--.25016S3;
 Sun, 06 Oct 2024 00:06:17 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v3 1/2] xilink_zynq: Add various missing unimplemented devices
Date: Sun,  6 Oct 2024 00:06:05 +0800
Message-ID: <1193cf07fbfa67f94ebad9bd897358f248f703cb.1728141040.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728141040.git.chao.liu@yeah.net>
References: <cover.1728141040.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgCnyun1YwFnyEiwAQ--.25016S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4DAry3Wr4DJF48Zr1kZrb_yoW8CryxpF
 s8CrZxWrWrtFZrA397WrnFqF1Ygws7Ca4UGrW3C393uFsakr1DJF4vq3Z5KFyrGr4qvw13
 XF43tFn5Kr12y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfuciUUUUU=
X-Originating-IP: [112.19.146.115]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCRFvKGcBHYV+OAABsm
Received-SPF: pass client-ip=1.95.21.14; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Source: Zynq-7000 SoC Data Sheet: Overview, Chapter: Memory Map

See: https://www.mouser.com/datasheet/2/903/ds190_Zynq_7000_Overview-1595492.pdf
Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 hw/arm/xilinx_zynq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 37c234f5ab..77010bebeb 100644
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
@@ -229,6 +230,16 @@ static void zynq_init(MachineState *machine)
         zynq_machine->cpu[n] = ARM_CPU(cpuobj);
     }
 
+    /* PL AXI */
+    create_unimplemented_device("zynq.pl-axi.port0", 0x40000000, 1 * GiB);
+    create_unimplemented_device("zynq.pl-axi.port1", 0x80000000, 1 * GiB);
+
+    /* IOP devices */
+    create_unimplemented_device("zynq.iop-devices", 0xE0000000, 256 * MiB);
+
+    /* Programmable register access via AMBA APB bus */
+    create_unimplemented_device("zynq.amba", 0xF8000000, 32 * MiB);
+
     /* DDR remapped to address zero.  */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
@@ -394,7 +405,6 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
     mc->no_sdcard = 1;
-    mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
     prop = object_class_property_add_str(oc, "boot-mode", NULL,
-- 
2.46.1



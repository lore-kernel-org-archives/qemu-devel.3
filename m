Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778F9C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpUV-0005dG-RP; Tue, 02 Jul 2024 22:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOpUT-0005cQ-1Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:13:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOpUM-0001lw-AR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:13:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxbeufs4Rm3FwAAA--.1022S3;
 Wed, 03 Jul 2024 10:12:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMWds4RmPSQ5AA--.57057S5; 
 Wed, 03 Jul 2024 10:12:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/loongarch/virt: Replace loongson ipi with loongarch ipi
Date: Wed,  3 Jul 2024 10:12:45 +0800
Message-Id: <20240703021245.3752786-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703021245.3752786-1-maobibo@loongson.cn>
References: <20240703021245.3752786-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJMWds4RmPSQ5AA--.57057S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

Loongarch ipi inherits from class LoongsonIPICommonClass, and it only
contains Loongarch 3A5000 virt machine specific interfaces, rather than
mix different machine implementations together.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/Kconfig             | 3 +++
 hw/intc/meson.build         | 1 +
 hw/loongarch/Kconfig        | 2 +-
 hw/loongarch/virt.c         | 4 ++--
 include/hw/loongarch/virt.h | 1 -
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 58b6d3a710..870f537236 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -90,6 +90,9 @@ config M68K_IRQC
 config LOONGSON_IPI
     bool
 
+config LOONGARCH_IPI
+    bool
+
 config LOONGARCH_PCH_PIC
     bool
     select UNIMP
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index afd1aa51ee..b7fce2f375 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -70,6 +70,7 @@ specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c', 'loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 90a0dba9d5..830cfef72d 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -11,7 +11,7 @@ config LOONGARCH_VIRT
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-    select LOONGSON_IPI
+    select LOONGARCH_IPI
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 8be2d2ff6a..6bef2f1165 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -23,7 +23,7 @@
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/intc/loongson_ipi.h"
+#include "hw/intc/loongarch_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
@@ -788,7 +788,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGSON_IPI);
+    ipi = qdev_new(TYPE_LOONGARCH_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8fdfacf268..91216418c8 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -11,7 +11,6 @@
 #include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
-#include "hw/intc/loongson_ipi.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
-- 
2.39.3



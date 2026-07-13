Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DBC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjB8D-0003vK-Q6; Mon, 13 Jul 2026 03:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjB8B-0003uq-G1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:31:11 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjB89-0001Xb-Dt
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzDDbVJsp5psbvX4YNflroCqTvdZ0TPot1VWicq7F4KvU+IerEJHSnppx1ZfHrIY6R9+V+ocr9SrOSgUMFzFFNLFr2M8XP5Xjfeub3tlU24m8XZ0nJCg/fR3bN8EZRrMAMsFeQY9pnmC8+L5kBMY2MN7rtImXRGTOydu//8u9Tba3kbRckf8gv3oxDfod3EEqAVMWrx5jDMXVnyR8lurk0XrUef1YwPbW1bsMUuYNKXId8tYUgvRjg6EUkz62W5R9ag7njmC9xetqoCtlHTlayx0IqsM/wl8jnV+J5KBMxnJW5y3QX64Li2Gu2JAoACIU+Sa5qDASLUkuz/o/Hp0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rCvyZC9CiPRzq/VaxUCeDnVE1jLRxMuo+cx/T/p2Lc=;
 b=uSAgxptNMgIZMfH9pkUXTl1Bx5W/Ez6FZdrqOx19sEDY61wxETP/5tUZckSFxQKyh8vwtFyqyW5b0UA+rhuPCTYnpQ8tuciJtVnXhYXqf2WsggjEpwYlW3qGBKI7Fp8/knNIXPQGe1NvAVTkVm3Wop2peoQ56Ao9DyBrWRj3XIrcH12pg+3fCefmCQfBj/fzJAR55yMBtQRSJQW2KXmgzOv2oO+aXHat9wDBaXM4f7NBJ2dLBKoHtiyyTHiAsyyInKyuPa0vcpoZR2gKZkMdh+Fx5luqZGhHhvo+rrko6n0n6CO3b1+egzc6TOFFv02sP7oYhujzRmiJbeOzuD+Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rCvyZC9CiPRzq/VaxUCeDnVE1jLRxMuo+cx/T/p2Lc=;
 b=GhjYrD5bF4ebogsl/HJh2KGW0DpNzrn2lUFRp9DSH0iyb5JEkscZnLQHEaKAx1s33kFp6R7cjDbmi2m669lN9hmO+MReo0kFWhU/jNBX7FaimXvRzlaaw8ki2+DeV5T7JG2eNTHWByosY/Wk7/KiE77eINQF1CCZt90x4L3XuSUAKkrPJGWDn8C66mUSI9FTusRausgSwmHDQe+8x8HBXK2DdQ7ZTFZ/r1Us8TjjVQqxmV8jXi+w3jktUUm5DFjfhY9/zJCbaEw5jVq9I3DeyTormLnRpYN+HpBqV0xeLlJZGcOQAfcPIRxZSSrfIE/DGmSGreorHPBNcRmoWWxfzw==
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by SA1PR18MB6418.namprd18.prod.outlook.com (2603:10b6:806:468::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:31:00 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1c) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 07:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:30:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7B22340BFE0E;
 Mon, 13 Jul 2026 00:30:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 4/8] hw/sd: Add Axiado SD host controller with eMMC PHY
Date: Mon, 13 Jul 2026 00:30:29 -0700
Message-Id: <20260713073033.3883619-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SA1PR18MB6418:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 171a9552-d813-442f-f445-08dee0b0af99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 263sUSkF+EHPvFkgikqsTUq1+FF4u3ZCpb8C1Y/WbAMOoTd0rzucnaKejTpNQwDWvgg+HfdCzwLf262/WR1SBBQ+fVekl0CwOl17MsbSWTaGIex5un++NkuDihAtZ3M7Pi66hAUnbmQnpEdOq+dLk1Nu3QuHxl1sdRmKUdmeQcLf4jHMQtjUYzOuflNfBYPXMPunIBDdoATGrctFtmf4fzgib4+k1JL8EEQkznkYPpq79IWAK3NvkZoOYa/d4/kDiwlLO7+CCcwldNb/NOzOIV45BHMbiolwKkyc0Dwga9+jHQkpLUI1WV2zUIxnutNp2LLYlYSD6tePO5s+5FIQOKHtNWkeyhoMr3zOKdQIwxsTO8aRldkFKuUCc+lOAcyXmAzdC6XpfzCFE4/t9JJZE/A3vM99tlqE6E14MIdohJBtdWa0iKV9HwyT2RIqk7Z6mH+J936iKksSXu8tttqYFq9Kja4H4pJfVpoPg+8Inucs+HsLfzdLNDVKV7eKw6abf+y0feY77FFaYnpbH2t5C4pB9AeBP3mTWU7gQjsWYAF/2LczXCDqAv/k59KSvxSM6o7i2k8wxfzyOOcF0ZhUAqh3bFnHHHyxYDQ3Y3TEQUDyOoQC5S72iU5G2xumuDYgAUT/GQr2cAfc8P+GEp/+Rf3H9RdPFIfiRUYKQ4KhkCb0SL3XXsZIk1UQXUfzHepaXi6RoXdyn2jjVfrNUHrcaw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CQvJt9kdED0jckbZ4ih91zjou1oaPUfhtEl2P6P1DySwnzLvAOSkBO5gQV3yNfPzxtEYhs5w5zG22wMGdnxJb+XrrAXBqh4e9511HwfhbxwF0nZdid7UmFO666h2BnlEOv+t/AMyBe68ADJpxHerpsUTHNBThECeJtW6btRnqCLOO5LzRnCXWiakDDAoPtkorP8JiQv5ocotAkRZcXCiHh7Ku/stUKCHtJmJDPK3l5uVESFsgt+ud/EU+jsNNxLhvCZ3qQplO4zHX9aTW8552ab1XcWPYhdhk6Hth6G8+cvmriyJbXU0HLe4l3Osfc0mKx4zxQBzYaULifTRRm1NqPrP0T0Ln2g3wep2HAr23UhvijSBI+I1ghfq1+8/cmukreXXQy6w5lubv8rH4NYii6MIvJW0vHjC9YnXeDLS+62Y83R7xUybg07IIl7mxdve
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:30:59.7701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a9552-d813-442f-f445-08dee0b0af99
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6418
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

This patch add a new model for Axiado SD host controller which is compatible
with SDHCI 3.0 spec

This device model also includes a eMMC PHY which helps to control SD/eMMC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                  |   2 +
 hw/sd/Kconfig                |   4 ++
 hw/sd/axiado_sdhci.c         | 117 +++++++++++++++++++++++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/sd/axiado_sdhci.h |  21 +++++++
 5 files changed, 145 insertions(+)
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 809d7b7a53..0766cd0130 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1303,7 +1303,9 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/ax3000*.c
+F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
+F: include/hw/*/axiado*.h
 
 AVR Machines
 -------------
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9afec9..c69bf24f8d 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -23,3 +23,7 @@ config SDHCI_PCI
 config CADENCE_SDHCI
     bool
     select SDHCI
+
+config AXIADO_SDHCI
+    bool
+    select SDHCI
diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
new file mode 100644
index 0000000000..94c2e04409
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,117 @@
+/*
+ * Axiado SD Host Controller with embedded PHY
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/axiado_sdhci.h"
+#include "sdhci-internal.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "qemu/log.h"
+
+#define EMMC_PHY_ID     0x00
+#define EMMC_PHY_STATUS 0x50
+
+#define DLL_RDY  (1u << 0)
+#define CAL_DONE (1u << 6)
+
+static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t val = 0x00;
+
+    switch (offset) {
+    case EMMC_PHY_ID:
+        val = 0x3dff6870;
+        break;
+    case EMMC_PHY_STATUS:
+        val = DLL_RDY | CAL_DONE;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Register 0x%lx not implemented\n", offset);
+        break;
+    }
+
+    return val;
+}
+
+static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "Register 0x%lx not implemented\n", offset);
+}
+
+static const MemoryRegionOps emmc_phy_ops = {
+    .read = emmc_phy_read,
+    .write = emmc_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *sdhci_sbd;
+
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
+
+    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
+    if (!sysbus_realize(sdhci_sbd, errp)) {
+        return;
+    }
+
+    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
+
+    /* Propagate IRQ from SDHCI and SD bus  */
+    sysbus_pass_irq(sbd, sdhci_sbd);
+    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
+
+    /* Initialize eMMC PHY MMIO */
+    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
+                          "axiado.emmc-phy", 0x1000);
+
+    sysbus_init_mmio(sbd, &s->emmc_phy);
+}
+
+static void axiado_sdhci_instance_init(Object *obj)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(obj);
+
+    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
+                            TYPE_SYSBUS_SDHCI);
+}
+
+static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = axiado_sdhci_realize;
+    dc->desc = "Axiado SD Host Controller with eMMC PHY";
+}
+
+static const TypeInfo axiado_sdhci_info = {
+    .name          = TYPE_AXIADO_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AxiadoSDHCIState),
+    .instance_init = axiado_sdhci_instance_init,
+    .class_init    = axiado_sdhci_class_init,
+};
+
+static void axiado_sdhci_register_types(void)
+{
+    type_register_static(&axiado_sdhci_info);
+}
+
+type_init(axiado_sdhci_register_types);
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43d45bc56..ebf09e30a4 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_AXIADO_SDHCI', if_true: files('axiado_sdhci.c'))
diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
new file mode 100644
index 0000000000..85afebad93
--- /dev/null
+++ b/include/hw/sd/axiado_sdhci.h
@@ -0,0 +1,21 @@
+/*
+ * Axiado SD Host Controller
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/sd/sdhci.h"
+#include "qom/object.h"
+
+#define TYPE_AXIADO_SDHCI "axiado-sdhci"
+OBJECT_DECLARE_SIMPLE_TYPE(AxiadoSDHCIState, AXIADO_SDHCI)
+
+typedef struct AxiadoSDHCIState {
+    SysBusDevice parent;
+
+    SDHCIState sdhci;
+    MemoryRegion emmc_phy;
+    BusState *sd_bus;
+} AxiadoSDHCIState;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16338CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9kQ-0005ex-Ll; Thu, 18 Jun 2026 06:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kO-0005d2-7A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:20 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kF-0006C9-4t
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l52wjO1Uz7hdg15ElyBP5KF+d3Ccu9BBz2qBlKOr7cjqBRqH2hPVbf/3Ki7FANEhKbnHG56hz1EmKH3w0I5g8PkeSJ4cmVO5xypdO2HIPxQ/y419hrTIOzf1bcqlxazAp6RNuS8zOv+VKdIYsa9FBgjEcSTc5Xy3csq8JYtdQgPEqYdfaPNAGQvEvCBbsN7ceXUhIHlshJR/DYOyc82mIV/AN3mGEQbTk0Qo6JOqUaPsGeLOd0bQ2zZxTTKVZ2Giu7mqfKfLIiaooZ9BkVmyBhPLTEISbgmEH797U7U/EJv/GVy5ITAcPoRxmK4rAmRqPFPYZnB7dVZK+kjZTDJx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVF/2c4l7mfAZ0+2WLPI18Mif1JED++gwGXq9AXJvQQ=;
 b=oPGU5jFGgve04wFLcSRamSbxCn5Ev2SP+nGg8XrQprStWDNf8VqucopPrZ8BwIFeCaAt2z+MPrU4kOzJlBE3P+7g6PBN6pzmN2V3bfh205f7BMnZptaizCNAeePGVXd+rh8V/ASJGErYwUCH3AmTLlN1wW7pfjeHuvJ6r0d0B47Y/w7ayg6r/bvYaVnr/NmZca5zH2/PxmTidP3ppTj7z9libAT07qZxlOFYD1wCZTcddBNZqkbC2wM16VJQ3RMyRDcRMbk3GGLoR2RkOjOir3TBJVm6BOr2YKiB8cWnXi1lVl0BN1Q8syVEa5ol8nCYdZ1aWenpXLpt7X1FC9q8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVF/2c4l7mfAZ0+2WLPI18Mif1JED++gwGXq9AXJvQQ=;
 b=eGbrPBmAZzeNA8OcSrAhgNoXYQhMDRoe4FT1wMrvyPaghYC9/gj9R/OmJppwDgYGTy3AHEZjdsNC8Nac8sJM48feNjvZtPzFHfXl1x1UGXVf8FRrVslFTZOqWLNW++jDvAIKoGsFiZ5YbPtm8NLl5ziTUl5DcyO2ID1wZh7oU90BO9drPAVluqwn3h/my1cgCaaK8QQKm6o6JNkinkihWk+B7KFAiY1mCcKcCi9wQTQsa61F6zLB9E2M7PpIrmOkHX4AqLJ/6vFsXtTl/gRGOsO3NefhqHQ82WdFvdnXe3sG4dwfvjgomxy0vOJu6aYJVGVBAwUDqIof6/abDSTIzQ==
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by BL1PR18MB4327.namprd18.prod.outlook.com (2603:10b6:208:315::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 10:13:05 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::2c) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 10:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 10:13:04 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 517FB40BFE07;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 4/8] hw/sd: Add Axiado SD host controller with eMMC PHY
Date: Thu, 18 Jun 2026 03:12:45 -0700
Message-Id: <20260618101249.2926976-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|BL1PR18MB4327:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ddd5458-6a4d-4a61-58c3-08decd222f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NmGKIHk4PNNFXqFzq3JZIbgZ7PbqPacGApDV2+DQHw3lEl/Q+ipAksd0CCY6VflQuuyScwr0XKD96H9DP2+aCKtl+IjIfBxov6K9edDT4h1OIW3tszFTdEXg1Ivi6RkZgCyoIPiJgmwj9Iq1wfk7P3SC9ORqPd9a+JDmbP3E0tetsNZwPLWdA6OwunVvSdttgbmXq/B8EfySdiZGbdxwvp4as+RiucAB9mwYMnAyNGrenuHf9Q2hHsUCl5E1/qYfY7V1kr+APvcpFvWEQw4S3U0N3CKJgO435MMZUL7g3ByecYi0PstQhL7IMZ1DBY1mssUEcRdPrZrwO9BHJYabhpR45T/LJgO+PAWYsut1dDoReN6App/dJedVB1yCPv81lBovQGOfGnnrVwQ/x1x4c8AENxdYw3FOM/dsnKKYmJx8zVajTzpAz0KQlRCh5uhPpEqR1HhDibM9NfMUjv5+aumuWjJY9i+Yj7R56tCNTFh6TRKz6BLXSuf5Ay+VhQMWZPfuUyR118pbNgOD/NO+AbpFP2u/c7Rmhtzlqzh10IWvbg4l5mmHPmUEdjizBfGfI/BFIql3AzVQZonyxiC8TqMbjhWFFA58X8hcfkg/7cE6IvW5S2D08MJm2cTHWe8puloWZaIGtlLeg0BQ84g/qsem5kRIBvaYOInUj+u9D7TaDoo7Ue6lah0C6+PCldR1dxo7qUvUvtYuDkHA7BSZPtno4pgzLkVE7b1VglyWKCE=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P+NkCioTzUbNYM2x84Hy9Azg++fMhKCUC0/RVPDI1H2MdI0HQjhpFPL+39Wk67eZjmiGDnAEM7rYSqNV4tqruivRZNWng1QER6MIAQXmY8JHU2R3ZD6Y7AumFL9nh9+Z0mV8Qng9ebGVkPxEbhi3NBWXP2lAzY6QHZZbkWDzZ5ylp3qv/k0IcP41ZlIeo4kPhSCNMt6iT7grbLhPNYXGjPJWCslhF+aQJq0bcLlj3gD8s04Nwj0oDgwf7lAa3QZVL0mWEK9LvZDHMZoSiJ5YRRWYLMqP/oQk2qA/VJp/dgRl5zZ0/p+xToDig/DflkLq8Xrd6gd4UagNwh5sQbbkPC0/hdZSnMKX6SvoQ+mBbxql8sdl2DL9hlFuNeAMihyrcYlmmV4lW5Sc+1Q6QOXBMg3Am1AanSntDA7hH2dlWBQQ6cA9S43o0GexEUVyMIne
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:04.0487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddd5458-6a4d-4a61-58c3-08decd222f79
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4327
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
 hw/sd/axiado_sdhci.c         | 114 +++++++++++++++++++++++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/sd/axiado_sdhci.h |  21 +++++++
 5 files changed, 142 insertions(+)
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 340428cda55..0c112890818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1299,7 +1299,9 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/ax3000*.c
+F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
+F: include/hw/*/axiado*.h
 
 AVR Machines
 -------------
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9afec91..c69bf24f8de 100644
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
index 00000000000..e1a76b80a67
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,114 @@
+/*
+ * Axiado SD Host Controller
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
+        break;
+    }
+
+    return val;
+}
+
+static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+}
+
+static const MemoryRegionOps emmc_phy_ops = {
+    .read = emmc_phy_read,
+    .write = emmc_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 2,
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
index b43d45bc564..ebf09e30a48 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_AXIADO_SDHCI', if_true: files('axiado_sdhci.c'))
diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
new file mode 100644
index 00000000000..85afebad931
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



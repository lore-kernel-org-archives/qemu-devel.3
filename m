Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C1CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhZ-0005ku-9t; Tue, 02 Jun 2026 02:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhR-0005fi-MK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:05 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUIhO-0004c0-B3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQuZHgFulNyLKlJV6d7wtng+dJjTGQm5WG67Mz2M9WhlYmEDXGGLTUJ6YfHnVxRZl50YdHGmHur2od5LbVxbG5fDrmrNdMU2NI3PuwnJ0kyU+XaCLLCnpoMLRcH48+F55VKTPAjDU014JSwEK2rhSrpVngino4VAh+CJrhJMCoQOzGxawOgHnfaDUyLE311HOJV8iKj5cWve9BNGnRP3fkIBXCKdYLMFZRis2rC/tv391LdUU9BKD5a8rA/2SK040yNr78BLm7jubNo6lMzu1LBsinQSDPorY8//u9KbRF7ThQ9UYlRE4bUQzUixmVyps+eUpnPPjihSYPwTkDX9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF08zCjMnCLWTRtKoPVETzfY9I7HF+uryP52JMgnxGM=;
 b=ZkOuKAgrlAFnVXB/WYcgEsZx4+q5urnVmpaGqTsKntcpZq+JaqoMeUzF6h3tWCbXU6Z0cMn3mM01U6jnLAab8ObY0snt17IKDaUxAO1dyROE1kkjgaPx5ZThXvD8zTsUb54B7MEFWbwYEXstW/cIqHqkq/nuaI57eenyHUI0dEvwASe4chzLHVn2+4XMkoN5vY5JDNUUrV0juPG6GunFxbIewZSU2W142vaGufZ/LKo8Rr5N5wkXLIJ0xkg7KIlFbyY8O0I80ZlcWCngtQTW7YPRFQR8gbsFh3dAJKbXPlVL6k2dH6OGhCyvpc/DUIN5KJMXBGPHeNXQCpHAyd7bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF08zCjMnCLWTRtKoPVETzfY9I7HF+uryP52JMgnxGM=;
 b=VwdlSW4hY9BXWtFypJImsOyKvkG2AjdQ7TQmoJ7PsaJsXboter70gZdtHDOMqKCbzTIGgf9OHi7DfetD67zxig68EznJk34sb3wpeC7rfPC8k1HQl7SdCRKudH5ov7ZIcZ9OK5z9M4+JZwPpFIUKdCDVKeMBq7HN3yaJXcXddk2lLlcIBDzZCUzG2VOta3AlLAfqMuqa0Pyxdt5r13Hf5Cif3dwxAXcpAwMmccVUoAxDEJkO+wmQBSbzgOj5Y6w0DlCz5ZhEzqBcWvctF1LZVN+KlKvmw5AVb16WGzWVdUIbjWctf0JbUGZmpJ+mG09nkNI5PDloJoOKcMLL9vzCGA==
Received: from MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10)
 by SJ0PR18MB5054.namprd18.prod.outlook.com (2603:10b6:a03:43d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 06:33:56 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::97) by MN2PR06CA0005.outlook.office365.com
 (2603:10b6:208:23d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 06:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:56 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7E25B4186B5A;
 Mon,  1 Jun 2026 23:31:31 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 2/6] hw/sd: Add Axiado SD host controller with eMMC PHY
Date: Mon,  1 Jun 2026 23:33:46 -0700
Message-Id: <20260602063350.3623723-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602063350.3623723-1-kchiu@axiado.com>
References: <20260602063350.3623723-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ0PR18MB5054:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87ecb350-b412-44e6-eb9a-08dec070ec32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|34020700016|376014|1800799024|82310400026|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: sLturhLsfCKk1g3kdTKhd1shhKd9+mPFloUvKQt38/F++RkOZUt+qvjwHKr57OEBPC9FIINjMprwdG1scK9vA5AS/KaVFSF+V7MFjlQ7Mkia8TMb2dcTqpMtP7F9VTCvSpA27AyqZFNzon2n29EWjW0mT53T74wCwKRepfoO3GTWa4+kRFJ7QTaZuZsdBAqG0G7hs48LAHFyyd+4s/3ZXoHLl4CWirV4l9FFRg8WZGQ3wfqP2i+IteVUZuR19RQYcNYQiIawNnnxsFCFTeqmgUGWaBaNMWkWe5JcnRw5oRzHUVHa6aWdgV2PPfwTHrurPAsN8BKyPE91/U2G08QdqMt52XFrd09AUBuV6gKlofvKdAbjWQcE6rE6SX1YZ9KH+EIPt6+1mNrRmb7ErNBjJE1omGy9cscNeSSdE8g2qXiNjrZQ7bF4/z1Bk2f5b1Ec9aeXBovw9MydTwforlZASUFkhq1s4ACwfNQiOtbi6ZUGektGdI2yt54F/WQqSd61YNlXBvcaxN+tXr6YPoPu5MYFCT7MpFTl6hINlixF+ufKMYT/ylgCy+eg923J34DRy3nlgO3xSpmVsTtTyVMGp87xp5CpvtodnVIYofJhhKyUThNQd1FvaDB/Na47fBNO4EBm9O0rRjzDiwdadvu0Zd/xLsT62D3rnoTA62Jhqf9JQRuhVe9/roNt0Fv1s9yD0O6dXFXfNV1UMnTSOSqbD44qyZux+dFOCtYu9B+QfEU=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(34020700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EblrxPHSlcAeAU0/LXYuG2RkubEGeM6P60obXrrNQZNbQnR6kzy+7o9j/8t8FLc69Bxdtt+OnJLldM7vv4E/NKdeStXZ9NhECIoZMPmyeWkATpO4KSKYBA0Ego3Q9kPuIbDeiT2JYf6nM5BYQXY8dHP5RGKCWZvdHgmcSIJdM4NJIK25yUw9ojIrX5vKQO3zT05tUtu/0ScPt86eWfYn5begoyUg4ioVZQjuctaGIjUgUxtVtZ6T6P0ug1hp4KyTQqCytkRLqCzIchNksL9LKblMy4hoMI7WdNjcbUoFOt2PsdsFksWZ7TTjxxatQskFR0E7TfT6OWUwI6HHpRav2jzYeLqTTNisjUAgmkxT05XRIKH7Fyu2Krd/MjWUMq6lZ5HX34Y+jCwGwJfl3AmeTqtLUD9GoaxzkeW4upA3Q8ll9p3Fsy3feVcUPS4/xJtq
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:56.3071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ecb350-b412-44e6-eb9a-08dec070ec32
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5054
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
---
 MAINTAINERS                  |   2 +
 hw/sd/Kconfig                |   4 ++
 hw/sd/axiado_sdhci.c         | 115 +++++++++++++++++++++++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/sd/axiado_sdhci.h |  21 +++++++
 5 files changed, 143 insertions(+)
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3782c83738a..0a3b26c5417 100644
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
index 00000000000..245b11ac3e5
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,115 @@
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
+    sysbus_realize(sdhci_sbd, errp);
+    if (*errp) {
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



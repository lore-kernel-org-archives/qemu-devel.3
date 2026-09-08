Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFF5C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tID-0000K9-9K; Tue, 08 Sep 2026 06:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIA-0000E7-AS; Tue, 08 Sep 2026 06:43:07 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI7-0006ZW-LX; Tue, 08 Sep 2026 06:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdQdAfQpEGx8BmR0YDopgbRAl7pf2dWgsmxIJE+nbqIjQUXCBEzGSpP8765iH9dBQ2Byh4qf5VTfEHZFHDr7NaaoKRv85vPuLSjNAeEOaWWunqk1TQzbtP1TKBSODRV2ztyN3e0WtwX+8zg0evL6XSw9SRtGEJJdQOdfwsuv9+nOVFWeqov6PZZ0lvTvqC77gW/EoI4iFhNRf/UnADGXMAYVxWvRmUF+VyFBWTh7M51SOdsRuaXFB+nJreepzkU//3HuxEOCkznTqk4wnKD5ioxg5LDLTUea9P65CE5dnMHSwbTnFLd05c2poKNyVVJcK+SrnD9c1BRJuGwqtctLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aaed7a6/kzb93HTo6Soz2lqs4sI6k/ricjNWSyhbVOA=;
 b=LS9gtoGYSvyRXwejOgoleFNFravDfLfqZovd7Cusec0pCPqnZUDzsbTg9JYZxlemqYuyQyAnQ0cxxHVfsyimrblA0nDE5heTFy0RzTei60W/MpI8YEYXLBqd+x3LG0T55YZhwAG8DTfJwTMz0tEdQBIlh1SA/Jd8bfqf82NAYrJa/NX8CaslG590sv+jM0SYa9gydLMz97SxV+ubD8STAJk5IYWyBIJ6aJPjcEz7yLXaVVLQ8TrB61AdMBABHItPO5xAGkilA7/QXLyg09bXOw3P+q0Si/YlWL+PV1dl45lDOAWxLbu633zsap41YzK9n9KqTqWrNg0o/ipTBpmWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aaed7a6/kzb93HTo6Soz2lqs4sI6k/ricjNWSyhbVOA=;
 b=sRNklKeTUOj/YT/ypQZrQNqIJd7xGlaM4p7jCokOtCVKGRX+vcmD9FsDxKTyIHMoLdAnFnF3z/Vq+j8A9bShtrAT3K75cc22hPFafxTL2GYDkLZzczVI0BpsSepMTIVCeI/eoK+Y0pjSHpT/DM5yLp5Rtm8jeILgbHQLhD0FRuSNR/5BvZ2SAxNViL83FaGNsbLVUJFi304aQYNvH5xeqoMRRUDijB4Job62qytsjPPmrSEj3wBmiNOJJ6DCYDzQjSp7UuLSNVrAihuLFCNqbPJqxqgp9RWKsG6OhYGtEdVk5Ml1Lx1+dF4WeftrwYNj8ivsSNGz2zUvyfTwy4fspQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:47 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 19/32] hw/arm: phytium: Connect the Phytium E2000 I2C
 controller
Date: Tue,  8 Sep 2026 18:41:28 +0800
Message-ID: <20260908104159.1621764-20-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f07eb3c-b7f2-46c9-958c-08df0d95ec62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2NIX49XauDmxJ3ETSh5SUsrWGg/2vMkKi8Db6RUCD95Bav7THM4ARsG7DtaajuyEiQr8JTKe468QszWibNnBQmHC+fNmQ1zCb4gabObTmk9q/25IUWY/IhwRDqYTiJC/YxPOFHJKpRDeFQNZTE8ILCATUoBFeUr/iV1/m7uPYq3CBVunNSRSBauXESK6Q0Go7R/ivsxWHTg17Bl4P5rpkqlnoQam9uKCbj4nPr9erCzISke/MMcpGsXjcExdPmNZmxc5SRJQKGKdmI4G8Q/1c1tiD7fCwLHON3/n6kL5PWody9SJHw5JAyBx+oCsVD+fbaBpBnzfUtXkeT8/7Xx90J8es+DwHc/drVc1PHh6jhNIyhr9vOgTpMXQ9eE44NvbKkU3Zh7r7/gP0hzZzZqXsfdHe0YgMZAnr4k+Maq9J61PJsf0DwXjmpfch+b4jWALEHgtJcNDzea94gUR1LoDBBdugB2RTEmBluEHhZbT3yrqbSh1KvepKjs/M84zTqAkt+8PCsIi2WIhVBXZ8hX25JOWcPfPYKWPvGKhjr2FvdmTT+6RqPrT+/rbIiTNUh2Wgw+/mTanh+uhiOfo1AfTVXixrR/Ki4NIlfYJfmu8bggKVaOro+gMJ3rXjEEmodc/8U7NC3UR8xxAX/QcaYHULXlfPECjuv0PHwXnrxUh9jQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lMLWXFh3HwE5ptBPyafNVBTxYuZYNXTObcGb9SfjbxXBIX+CaAc2lu0RTnB6?=
 =?us-ascii?Q?qc/iseMx5Yb7FiFPPPA0aJx50DQxWONzSK11n2P1e3G6bXPVx/1YLXYmppcj?=
 =?us-ascii?Q?ajvNLfOBSIclIDfUzHhOQTyoQ5FHmah+OgiOq3yygHMrYIXaEozcWCZ1fm2g?=
 =?us-ascii?Q?RVAXsKljXGWWW6Cz1lD2rN8uyGNe9+yxeMBsqCUnEa7T84CUb4xUT/3Gff7j?=
 =?us-ascii?Q?NQOBxeVzJAG2LngiUg7SMseS6RNKD/GbEEUxuNw+voPt5fbUliRAoBBua0vO?=
 =?us-ascii?Q?7QxkwvZj1huTCC4emgTnyyBOxPywPrLmuAXT26XwHe5jA+dVNMPPYh5tSANY?=
 =?us-ascii?Q?PshEmmt/M6YYdpa+4Uwakv5e6J+PCsvWthBNPxghIDGG2LwzljkyrNAYvMOz?=
 =?us-ascii?Q?TOLAxvLPQEHTtmAnZHzV14NyeX0RMO0HcMzci23N/CJJYe3CWGYlRPWgdFDn?=
 =?us-ascii?Q?w+EcejSW+U693TE+fVsPITJ6L4gQEOxUO2raWuETFmelV3Gv7RmHF8qMYBZT?=
 =?us-ascii?Q?Km4oqci5fRr0mw7Xmsr1JriiIllr0JzD/+H3gVIizOqU5ElHGcyxh74KMIX6?=
 =?us-ascii?Q?BR8X5ZkD3ip0zx1LeeatV8hIL3KviyI/Fvt5ooASBDoyxWJsxTJSDy4VNxGo?=
 =?us-ascii?Q?akcLsZ6Nu1BZeqhV0xijhBLppOIcSVWMIr2PceAaX/+CknraJhsR8Oi60cYr?=
 =?us-ascii?Q?wGOq59KZyVrsFveF0FcyIlCmpEQgGZzsJ1tH7M6ZW25CYhs4K2culQU74rg1?=
 =?us-ascii?Q?gEmR+q4J5Vs3PP49FwBR/tL3OwCZmiE8I0s5MzqVWnyW8bLu7JlPivF/fU2j?=
 =?us-ascii?Q?xT11He7yzRzUyrRMK5wtSX7x7XDY738N0zlVFgqUqqPCmYUU+04JfiHryvTf?=
 =?us-ascii?Q?1BIPZNu+wFtj2E21LQU71TbOIeqFYCC50BPqR2FFmxkSrunA4PqfkScyJn92?=
 =?us-ascii?Q?k8tCq8ULGmQ8779nP7HC9VZhzMm4lYEgKE11zoB6hqqq8ZnEt8GJnxVOqWiM?=
 =?us-ascii?Q?lFDl6kFK0ANJ+/0PdjdJ5LM66PeAPva6RZ3li4FJGsMJZROHTrJifIXMmdG7?=
 =?us-ascii?Q?qp0u7nUGkW0++il4UGCmk2lkPGuVqqc2jIgxVbEnKvWPOTcp7G1sR0KdEq5E?=
 =?us-ascii?Q?BIvqyaquOLcUWu/Z6xyXt4TJT2pWcD1FWFs5yQP+PhpnkqmAndl6zNIest6J?=
 =?us-ascii?Q?nmiV03c7rF2hnZQV0YwraBLdDGvGUB9DBsA3DpRdqJyHj4hPnxM2m5OqVEdu?=
 =?us-ascii?Q?t8szim1He7Tg+mTexZA7wRUM11HfBbGBFrXynV2VRbe52TR/zmY20jnFInpw?=
 =?us-ascii?Q?/ni7g7sGVcSXMUg48EWdkoHl7VUgjC+AjqHSHOmfcjQlkOZ09CDvotbFde1f?=
 =?us-ascii?Q?NO47BxlE9tQ1FdCd57W8w+V8c5qT3BcrVwvGFVLOJG7/3fm18HiSDzFk4S8g?=
 =?us-ascii?Q?GmXaorgUA5HQKyw4j0hFs12UDwp+8MqTTTzcHIe27vW1p0N5BOM7A22Vs3gk?=
 =?us-ascii?Q?RhK3/HnRAoD5728rf29DribNmgg57yxna22IYafrjPAhsEcYKtx4uwBQAMya?=
 =?us-ascii?Q?aBpUOaih6Wvp+DBIPslvQvqeIHQn/9qGgwlwDx2WoB0oLhhBpoHdxsblISmZ?=
 =?us-ascii?Q?fh3jq1f2OaDzHY9zBK1tm6ONIQm4XZiHPthwQBu/JFkf6dSwQ3ttRm5wCsXa?=
 =?us-ascii?Q?pyzkyPQEYwUCDAK4hkPA2YYyVeUZh3YdOXycjiSQmb7Bca8iN33mj3PkWtiL?=
 =?us-ascii?Q?Q5383esd/RK8wDQKtgNfAwQlHPJXIic=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f07eb3c-b7f2-46c9-958c-08df0d95ec62
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:47.7811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upaO8IzolHx2GIUEw8AOKep1+CMZm97kDqbyB4nbvrkvciU/nIwZXi3/ufWizfENxLFFsixJcPnHUxg2YcnXSdty1G85DSwtt6wvZPwQE04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Instantiate the DesignWare-compatible I2C controller during E2000 SoC
realization and wire its documented interrupt.

Leave board-specific I2C slave devices unmodeled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move the I2C controller into the E2000 SoC

 include/hw/arm/phytium_e2000.h |  1 +
 hw/arm/phytium_e2000.c         | 18 ++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 3 files changed, 20 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 15aa1cddd1..228d1ecab0 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -40,6 +40,7 @@ enum {
     PHYTIUM_E2000_UART3,
     PHYTIUM_E2000_UART4,
     PHYTIUM_E2000_UART5,
+    PHYTIUM_E2000_I2C,
     PHYTIUM_E2000_UART6,
     PHYTIUM_E2000_CLK_CTRL,
     PHYTIUM_E2000_SYSTEM_CTRL,
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index e3fea5ada1..c282de7088 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -21,6 +21,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/i2c/designware_i2c.h"
 #include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/phytium_e2000_mhu.h"
 #include "hw/misc/phytium_e2000_pbr.h"
@@ -67,6 +68,7 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_UART3] =          { 0x2800f000, 0x00001000 },
     [PHYTIUM_E2000_UART4] =          { 0x28014000, 0x00001000 },
     [PHYTIUM_E2000_UART5] =          { 0x2802a000, 0x00001000 },
+    [PHYTIUM_E2000_I2C] =            { 0x28030000, 0x00001000 },
     [PHYTIUM_E2000_UART6] =          { 0x28032000, 0x00001000 },
     [PHYTIUM_E2000_CLK_CTRL] =       { 0x28100000, 0x00001000 },
     [PHYTIUM_E2000_SYSTEM_CTRL] =    { 0x30000000, 0x00001000 },
@@ -108,6 +110,8 @@ static const int phytium_e2000_uart_irqmap[] = {
     [6] = 107,
 };
 
+static const int phytium_e2000_i2c_irq = 106;
+
 static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
 
 static const int
@@ -341,6 +345,19 @@ static void phytium_e2000_create_unimplemented_region(
                             phytium_e2000_memmap[map_idx].base, -1000);
 }
 
+static void phytium_e2000_create_i2c(PhytiumE2000SoCState *s)
+{
+    DeviceState *dev = qdev_new(TYPE_DESIGNWARE_I2C);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(s), "i2c", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_I2C].base, 1);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_i2c_irq));
+}
+
 static void phytium_e2000_create_gem(PhytiumE2000SoCState *s, int index)
 {
     DeviceState *dev = qdev_new(TYPE_CADENCE_GEM);
@@ -774,6 +791,7 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
+    phytium_e2000_create_i2c(s);
     for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
         phytium_e2000_create_gem(s, i);
     }
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e4111eaec2..a77a4c2a09 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -133,6 +133,7 @@ config PHYTIUM_E2000
     imply PCI_DEVICES
     select ARM_GIC
     select CADENCE
+    select DESIGNWARE_I2C
     select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
-- 
2.53.0



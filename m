Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A9BC5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxuD-00088D-2p; Tue, 11 Aug 2026 21:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu9-00085L-Sc; Tue, 11 Aug 2026 21:37:17 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu8-0001Wg-7a; Tue, 11 Aug 2026 21:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwzZV9Y8miUQEzJGvjqSviuoFv8KT7LdJlVExe/GbomCY55BtxAhGTbvDJ/Ps0Q6/LY7g/XmD2Cg8aRjyxFqvTSmd5m00aNn7lBDa5QdRwKLhpJ5RoJYfSu5Us8R2bcRB1LU+SLR+ay4jEEd6t+wLvI253wAmUm5ylb5yNNIu2hdXlD62V9so9xKvX8iM3fycJXBDaA5wOvbvmoZ1OjoS1A40CDOv2SSp2nalBLLyYKrrBn/GTWWS4fqQ+vutQJhjudB95e1UMb0hDXwixglGGuvzCiT9nzUO3o6X1A3aZ48Fc5zPkFNEMcg996i1V8LBJgjrYoxMZnxn9sWb86/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbjC7noZwOcavLJY7SubZs3BAtJZjklwnhbqWV3Bv5A=;
 b=JJY19etzb+4R8MclyPqKrwFO55OQ3W8MrXZTRetBBMfM8HcHZ1p8OWA3iXX5jzJ0Nr1Naqel28emmnY6Itgu7ACWICSC+e08AO8djsFV6vCo33B0jvqBlQDn7cStYyMXSNSxzBXDfoLYaeJVyg2imUy4/jHRUOSujXkXkSahGRESXX0ngN1w+m+fzkzyHK5mebpc+m4qYCNOSwF+tMnyIDWKX2bD+2hChV7bQw/u22cupOferh+YohgYsLgdxvuBzILbEo0PY50zruTRFNIkuWIdzgtXQo0SxwOhxw3dBJJcgR/LGXbljDCcaAHvZJuLKEALT3iFt58K4No2zLFwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbjC7noZwOcavLJY7SubZs3BAtJZjklwnhbqWV3Bv5A=;
 b=f23EfBwBjrqKVvepsxa6sawBxCOWLR5CoQtV1IvvcEFhIaKj7qh+0ONogKB5onE7ac/wsaM3or6jXxMKMYCw8OcJAwKv9goreTAgEP+vkfyoQLdCSMVMuoFFILd/5h0sTLecySlfp8iF5E0PuvtAp4+ScUSbMtuURmecWSyduHeG1QGLw/shE8i0C2kwT6x770ndGnK2o5kfKNZ/EA5heQwMZMyoPTT/tdXq+g/4BqN0xUCY3sUU42HkROsEPDSxoEDe2fKtnC376pCbnANa+hm6X1YB5T4VejJbrF+U87NhxZKFdL9tg+SYIriiOzPkhDyMwelmL+/HKEHYwBwZ6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9309.apcprd02.prod.outlook.com (2603:1096:d10:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 01:36:58 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:36:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 04/10] hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
Date: Wed, 12 Aug 2026 09:36:07 +0800
Message-ID: <20260812013619.2134092-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: c13def69-40ab-4a03-3a1a-08def8123347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VyWePN7T0vp+RpJq8s5It658YkZaIrF9E/Dxr7iF9neHJnSTCnR3RRqDAMuF5Zx2Pzl3cc7XS86KzBwfVgOgZ+LNVVntYBxKlHAhsVfGcUIwsOv0T+Q0JP0a/tO9R+znice4b94wqSbqsC1kKdGkeq/JlSt+C15Om5PGj2R/SCzBAtBqX9Hy+vN0J5+hedgQEVJS6wUYt+LLIaXlmcl+qAt1d057o6bxAcBCLUNqLO+KmK5OBDamDM2eGuY1UHJM8j3eTff0rJMrMUPDkYTp/QfnzCEM1lj2eMJPPSGjnyRM7Q7okDCLVhzHGML8XgEu8AFdQizncQyWmdQqmNPX/sRUxkWfKQEy+K5jrMU1rvNhfKEIXKuqqviGlnNExfip+l3uspzsX1CyPWB4fYGgq4j9B/+sT0loKsZXTEuJizZxe1bpmN0LBVtdJT8M0qSfhRp3JtexAyF78roiTaRCHMWm0mNlVsQiPKTPoQiQJsGnA9NT5DUUphCmiRfjjmFOvo6Ock/j3Q8c/mSoVv8SvAT2c6DEuqYI/mLLBj8gGr7b8jjJWAHyY772gXMdaxbZ7BMFfI+Cs5Pr4tB1pN+OUvWDmDEulhVAQQMLnNd32IKfezbWtivkqlK9hBTRu1SAKXu8KULI38sVFcE0FCst4wWZNVfzP7xdM0pSzFwqvOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvGMjx7XiWmdbTvcb+TOcyd9/QnppZ1fGfIOhB4GsEd3ilyxiC+b2ZolQnVQ?=
 =?us-ascii?Q?kuLYmOSyhDZR/BmfZbNiJX64lkkT2zqxCEXQFgTDIA906kenKq+Vl7fGbaS9?=
 =?us-ascii?Q?3p4ANesdS0Niyvdanr6rLcqzeM4eCKmwTmdHfzGKsXBD8QCVr3/xYy4/xTbD?=
 =?us-ascii?Q?rowiImINfGn/MJ+5QYKVCjKkBDn+LN+jISNu5YCYcfNjhxzn2vwNPmLpjZEP?=
 =?us-ascii?Q?o18h4kLWFPjRX0g85j3c2Y/ZezecDFy2STgySF8Fv6ROev6OeOpdeO/FuBUL?=
 =?us-ascii?Q?YnuHZ3L60WjmDlXTpED5TLpUXnP8ulx5kqkCVt39E6tdFmqmXKvES/qSxN53?=
 =?us-ascii?Q?00CCOaUjgW26h+vkg7kuzf/Mpl38pEF6tGUD1ZS8XsvLRHpWd4XdIk7HQnwB?=
 =?us-ascii?Q?LSIfTWE4ajzQwHh5mOtgoLrnZJFiEEiPmPNcLcQ1i9bbUtICz5m7JL60jjvK?=
 =?us-ascii?Q?OjT9Sdz+2wQ4QC7huZqRwCwkWBITkbslc5PEFYeW91oR6JYPc/5x0LROAznD?=
 =?us-ascii?Q?Z9hpPxH0VHb9zrWqoGZ+EtlUcHFdni2bTEy45n1IyswI1Y+4h7KJ0a5ZvlJ5?=
 =?us-ascii?Q?8lLQYTUstiX9uLh/bl4I2knC8OidHOuGWGpv+hU5JEc16PUZ6clFBn4FjUV5?=
 =?us-ascii?Q?PypCQrcX8QIZh4JXjX6dxi2rB0XYB0TXdj399Mi/PXq68MkrF6zxbE+Cdjeg?=
 =?us-ascii?Q?+DOgg8723pRDoWnf8AEbEbSnkXroKngq7wtOx+lOxmSMFQNlAiHgeyi19dOC?=
 =?us-ascii?Q?xgzs/WGX8D6r4vVoSFbcOsLfYqvNZQ/yKZw6IrUTGBP1p0wvBck01j9WmobA?=
 =?us-ascii?Q?g2E2aX3jqdERVtfq5RwL5WELysgiwa8udO95Tdz96qT7F5hJ8PUooldycT2F?=
 =?us-ascii?Q?9Mwrs8TJDnxGx7pAxx/r0bIvJehP05bssaZbv7UBRgbOiF5nOh8wOLJ7cC62?=
 =?us-ascii?Q?2HoQDTXTV/gpz9FfRq62wqEHJPO7STfFO90eNgznK2tRG8qVMpOgZun1r06M?=
 =?us-ascii?Q?0+pnGVl+xHP5ruH7h7nKJTgFnvOLNWLriN8uLBycj6Su6/RfK9jwDmMnmn5O?=
 =?us-ascii?Q?vX82odJwbs6kgYBLQtbVBwj8aYr6UsXbrAPoGJFkrLn0FVLSvkZIN3u1+Pe2?=
 =?us-ascii?Q?G+ZGK4VUlx1b0l4FOKdBDRoONpkEdVJTrigb5OJTNJp9zfQqLr843LtkuCa0?=
 =?us-ascii?Q?GIqtGnGdnK/xCSBdEj2le8TERMcUT4qf547zNkjBn7Bs1WjCQsq2PzIGamch?=
 =?us-ascii?Q?jTIrPhnbcJ0uD/dri9kUmBwXbL/ppFV58ckQQ8RfC+Z9dk67j6+DXO9wsJI6?=
 =?us-ascii?Q?fU8P8oXhV1QLW3wGkplBY4iWofO7sLn5T1ziyDKRPzFQfm13Kkwvs45jYM/W?=
 =?us-ascii?Q?KPSRJnqHFHjpacgLgDzzU9PArTF23lbBieaYwK6l0ZxQv9Clwnf/V64dyQwY?=
 =?us-ascii?Q?vrOU0slY3zxEKKUhzlwNWe5JhxkAtLjcsUw//pJzDPrK3GSoTDsrC+brstGo?=
 =?us-ascii?Q?VkusW/3X5hnjTz5+p3yzKyX4ZrQtLTRJImynIWOiH9lSPNWOe4YkK0WBiywD?=
 =?us-ascii?Q?hb7bpTjtduRRrzqF+7axHMWIZssOFCmh8Svl0UvneG0TgkvovHaxzy5d9aVw?=
 =?us-ascii?Q?9pl3vukjvRyURirzdwUI4wdOqYHHqRM+nNe6tCZBpv/9k2V9uaqa2OsMwZiX?=
 =?us-ascii?Q?ha3MCk5XtdOvAcdxT6X0haWDzVVoOJHrdymjrr/14jcqdOcTZ8iPPXW+SsWd?=
 =?us-ascii?Q?WICKNaT7MT1SrSHaWJhZvjyuLkWEzAk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13def69-40ab-4a03-3a1a-08def8123347
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:36:58.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jka6HHkWNroHXsTmK0sKVw3U2Oo0AiKMp32vUJncPqBPjUIXJSAsHJMj31XjYyu/TXKh2wsxk6PaTu5n/9CGuKgkm856lxMBJ7sXLW+3EAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9309
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

U-Boot probes DRAM size from the MMDC MDCTL and MDMISC registers.
The existing unimplemented region returns zero, so U-Boot cannot
derive a geometry matching the RAM mapped by the machine.

Replace the placeholder with a small read-only model. Use the
8-bank, 16-bit DDR3 layout of the EVK and derive the row count
from the machine RAM size.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/fsl-imx6ul.c         | 63 +++++++++++++++++++++++++++++++++++--
 hw/arm/mcimx6ul-evk.c       |  2 ++
 include/hw/arm/fsl-imx6ul.h |  2 ++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 74c1a30959..473269fcea 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -25,17 +25,75 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "target/arm/cpu-qom.h"
 
 #define NAME_SIZE 20
 
+#define MMDC_MDCTL  0x00
+#define MMDC_MDMISC 0x18
+
+static uint32_t fsl_imx6ul_mmdc_mdctl(uint64_t ram_size)
+{
+    unsigned int size_bits;
+    unsigned int row;
+
+    /*
+     * Use the EVK's 8-bank, 16-bit DDR3 geometry and vary the row count
+     * so firmware observes no more memory than QEMU mapped
+     */
+    ram_size = pow2floor(MAX(ram_size, 16 * MiB));
+    size_bits = 63 - clz64(ram_size);
+
+    if (size_bits == 24) {
+        return BIT(31) | BIT(19);
+    }
+
+    row = MIN(size_bits - 25, 7);
+    return BIT(31) | (row << 24) | BIT(20) | BIT(19);
+}
+
+static uint64_t fsl_imx6ul_mmdc_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    FslIMX6ULState *s = opaque;
+
+    switch (offset) {
+    case MMDC_MDCTL:
+        return fsl_imx6ul_mmdc_mdctl(s->ram_size);
+    case MMDC_MDMISC:
+        /* EVK reset geometry: 8 banks, bank interleaving and RALAT 5 */
+        return 0x1740;
+    default:
+        return 0;
+    }
+}
+
+static void fsl_imx6ul_mmdc_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps fsl_imx6ul_mmdc_ops = {
+    .read = fsl_imx6ul_mmdc_read,
+    .write = fsl_imx6ul_mmdc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void fsl_imx6ul_init(Object *obj)
 {
     FslIMX6ULState *s = FSL_IMX6UL(obj);
     char name[NAME_SIZE];
     int i;
 
+    memory_region_init_io(&s->mmdc, obj, &fsl_imx6ul_mmdc_ops, s,
+                          "imx6ul.mmdc", FSL_IMX6UL_MMDC_CFG_SIZE);
+
     object_initialize_child(obj, "cpu0", &s->cpu,
                             ARM_CPU_TYPE_NAME("cortex-a7"));
 
@@ -228,8 +286,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * MMDC
      */
-    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
-                                FSL_IMX6UL_MMDC_CFG_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX6UL_MMDC_CFG_ADDR, &s->mmdc);
 
     /*
      * OCOTP
@@ -745,6 +803,7 @@ static const Property fsl_imx6ul_properties[] = {
                      true),
     DEFINE_PROP_BOOL("fec2-phy-connected", FslIMX6ULState, phy_connected[1],
                      true),
+    DEFINE_PROP_UINT64("ram-size", FslIMX6ULState, ram_size, 128 * MiB),
 };
 
 static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 6e9d92b1f1..3f5acae57e 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -45,6 +45,8 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
+    object_property_set_uint(OBJECT(s), "ram-size", machine->ram_size,
+                             &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b77..bc0baca721 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -90,9 +90,11 @@ struct FslIMX6ULState {
     MemoryRegion       caam;
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
+    MemoryRegion       mmdc;
 
     uint32_t           phy_num[FSL_IMX6UL_NUM_ETHS];
     bool               phy_connected[FSL_IMX6UL_NUM_ETHS];
+    uint64_t           ram_size;
 };
 
 enum FslIMX6ULMemoryMap {
-- 
2.53.0



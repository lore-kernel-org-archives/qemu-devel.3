Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E554EC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ag-0005qF-0D; Thu, 03 Sep 2026 07:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ae-0005o5-8P; Thu, 03 Sep 2026 07:26:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ac-0006ne-I1; Thu, 03 Sep 2026 07:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anSo4uDfRNhXjVKq7a7fbkithXby4rSw5IlU/CAs4FxhsQMXi87Z8y85FzbcNSz5crkRB9+5pK+Z1andEd7xY1GYxpxDx1wGM7txS0eZRKwic4qKmkGwVgrfTU8Lq0SKMY1PEWva1DuH8yZJH5yACMVrTbGvvr+lpY7WiadAN3j14X87P7d26occz1tWjDdLk3eygQ1WXOQJFGUIjOyiRoAFgnI0XtBgVflIF8XsoQEF+5ksT6Ys8J0ocPHH3T90ld8lyt5bIy2U9i7PdhEInBDa1XYLjVE8Sc9aDnhU5V+tp5oumts8SqjMOrd/1b3UHHwId1yv8zJ3qaqLrAgPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5rAlg5kq1K/uWNykaNfDWmw8e6W9VCj3KofUs9LswI=;
 b=UYfdb0v8+6+syv6XtQRXuZ3jfj3kCl5RjzmJNJ6dyi15sOvv4m5CPO5htI/RyN9QyUZgljZc7omUod4cFJbWLtA87yWbBTby0uQQTxa/h28bjs/rNB15nHFI3l9/qeHkQsJbnZ7wC5AaEi2vSbzsI9hLONnG0InmrF+BY2Ti2wabD1OzELhoyx3gHqrjBCg6wcddyNlanEcFwzSTdPPyUKNJMd/kzh4ytfyB+GLJZ0ZGU7W28rhW8iH5VC8+yutZrRD8RGKTTXZswWI2/rzTvwPYSj0tKtDWkeIJUMYuLCrCEJXfHq9e88ulsy4uy4gEj6jnpjqBfgOsyNFIweT3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5rAlg5kq1K/uWNykaNfDWmw8e6W9VCj3KofUs9LswI=;
 b=P2JGIp/o6Q6V4vdLddfbuzRGjtTV+K25dS0+JdEAsHXJpH2HWKufiITzB9XwbWeWYSxCzW5HWD7iTYSV8qsjnRJdH6cf/3C/bCrHxIowKdg/49UJl2S+pM7rh7lu8Pom/XYVuq37ss8PIAj+vwxm2rW8Tck7rSOkcDGDyS6+0AQPSj4AxftcV4AtE/5KIRdMadj51V8adtFTi6sCgAZ0Srhb976uqCKhifgu3hJopotn8RAtdPF4sDVfNsYoWUD9ltYf/X13bNqSHD0ofsYiKfPzAUf8T6vm3EI9xiL5WPZS7AAuwgjFV08/DDkgCYsOEs5DEWEfmg3CTbkZwhzVxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:31 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 21/33] hw/arm: phytium: Add Phytium E2000 xHCI controllers
Date: Thu,  3 Sep 2026 19:25:01 +0800
Message-ID: <20260903112532.3276678-22-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bcb4e8-c180-47cb-9ad6-08df09ae3452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6J2YSx2837OcEsnCnAeTgTn3qEyTEMVXQYZTtBM6L2FOSSgI+LGnny5+Q2tn8cQqwS1y710Y90sN3yuCoiLsxxSnEF3jGg2EPtNHifNJDoJhbR/2wQOQ2Db9a42YHpwYsiiJ6BfAcAm74RzlZ+grzuZFw8e6iSGTj+uAmyTTEvsh81aNmuOpNaITNvwQQaJSw09WJT61bJZP2Dd1M+IEs9C15CrR8kSBgE7WbpnGC8YtYvww7BmvovNWzQBTsEAVrxpbRM4T+KkoWEUjvxGK2qv2RUntsgXwHg00bfKtlw6E1Hpt8eiIdjCUEmyi7BUAbclXq8ZjrBhcGAaTHTIScztFiqOKlv5q5gp76N4ocvkSR3P9kz7ayus/DsiuA4gxCShxBUQI15Yhp9HUPbtWsvU5lX0/JPM/+y4IrpArbnvWo1YMh7XYERpIYcpP75qHQTt57YC1oXYFM6BB+y57U4YQf5nYcbfIzsImlIAbd9YplPfCvpeJ8L73i/giZMj2WIhK6/mFwh7yCeoQ+MlPBenxwaRnHH4SN7TPUnr60h78Z8T+d6ueIaQUQXZyKW1KAOlvFuz0Zs971JXLh8rp/d1/roj4xKI/L0N06ri7ZOWbOxCoXrbaXjI0kmq3+g7bbs//tmoqnU32hbylOZLSADsWWFhkx3TBYOfLzBqM1E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ahqpaeNDY//lqNeiOLkEtuhcGIKsBWOvcNs2wgd7xHFYlaebcFjgB4ND77x?=
 =?us-ascii?Q?tfLs//8optximCIaV31fXFGM0oy1/dpUjiD/IDyJJjdx78ZaPuHEEPOsAzfZ?=
 =?us-ascii?Q?GGCQ7AJxg0xj/cIOSZ0PF40oMyB4xGZe5jd/UwDTq8HxZWRJPO8GHV3ObLrI?=
 =?us-ascii?Q?vxD983lfkwyBm7Z4AhDxCzTQVHrO7A/9qh80FzgOgL0nwlynaRayNgDwV3dZ?=
 =?us-ascii?Q?JNOLXdhvaZnwuL3u2lyWnqfZxhnFUO3YI/iBSaBJgGDWKEy6cp6Rc4c5oFgM?=
 =?us-ascii?Q?JzPrmqdnPSzZ1LIr8rfM6NccjSdld+O2TXGl9GdHM8fOevuAZvQNIc/O2FOI?=
 =?us-ascii?Q?7bIufBLFKTZCh733ZdQLugmLuAsjqOnAjbUnWAJbXY1TbQ8bBTb5/v8Dfdwg?=
 =?us-ascii?Q?p5HWbVU9CMCY3+F+bP+veb7Z2VVwiWbgyJjelp4dK5BebXA+RvDAxNg0OkYF?=
 =?us-ascii?Q?85luGIFgrQ5mOmOOlYHwwBvEVROjiwejjfM/SOTLMFVGc3G6TkZNZGlKfs/7?=
 =?us-ascii?Q?04kSy76eNaxhkh+B3oZfb30RKnN1/eCIjS1OugY0gVLPt/kjXAFkJMJ7ERsy?=
 =?us-ascii?Q?U7krM8D9D9tcscFKWwNWL9Xd8a7vleiiRaVh2fhyMzEhGMh5noQHsmEcNXgL?=
 =?us-ascii?Q?G66MwnM0ubB9WNy3Z2E1wS6S9hTDmBZTCQHc7io9SCXqZwT98k+yTk5UuuqU?=
 =?us-ascii?Q?GXM8v/+PYAjhXMgWE/u/05bndvkuFS5EcsCY6xuGUnhlctLh5sYL1iykbX4a?=
 =?us-ascii?Q?iE4/4OrTZ6dAWXeky2r7F32GrKlaNJpfmRNXu/hrAo2vzNi3lg5SMWEZorSi?=
 =?us-ascii?Q?owQMjLFVYNHIJj5+EDFvrbQQD+td+vNgRyF2DnyATuA4gOdQJYW/gATzMlUB?=
 =?us-ascii?Q?bnhmqbUHauXqgnd5nfK536vol9BtCo1ARKN5OzWaFDBe0tAQfTLHvHsfGlaS?=
 =?us-ascii?Q?ounKnfWKwIgCtsIPLXB2tqSvhp7NiYrM0L+xLtaP1MSarjKgE40xUAAe5sSw?=
 =?us-ascii?Q?7A8b2KeZVYFptU8za723C76Revi1RN/tndabjq4wV9rCAiXMeEEhnA65wsIZ?=
 =?us-ascii?Q?JnQ0PBuJmRT3X/7G41oxgLunAuz5l17RAATV4eaNsBVB8BjU5WNkmQktmnmB?=
 =?us-ascii?Q?PztnBVjBMix2nlp7TdppBzzxKlDDFLaKQswMp5Ld08GK8kAxrE/DhTI7ZOJL?=
 =?us-ascii?Q?/1R8EUKdtlCUoWsb036WP5ZAlvqWwvrv/R2UIEY9oOap6pdNoDwkNO4m2fxu?=
 =?us-ascii?Q?sRwy4HNliVTM/nEO/4uFZr2YQgwVNFyGSouQnQEQY8huVSIFBKvaBYxkFRyx?=
 =?us-ascii?Q?Oc8C13u7LDndl9Ev3xFa7xZfbuDX4hoRMVP/excuSrgOn0PQA8IvCrZGku/V?=
 =?us-ascii?Q?pwyr/R9hWR/+nbqR6J0XSWgzHAsGjgxEeCfFdHZqTTTsiV5bVeGLb9imWCEN?=
 =?us-ascii?Q?lMdAWMRZEXFKxVENAms6knWFBdVio79REZFNHtYsAJPkUpLYWmSMOOchjcZS?=
 =?us-ascii?Q?rDDGilOBIEUU3EMbO6zwTnPy/GoDWgnciLz9Gn2rQw0hhyZvj9a5FIarRTE4?=
 =?us-ascii?Q?GcC+v0snoQJCtdBZkzxGtZIeFI+L9EXCqpTCOuyR8csIKVdcO3xtj/1CnjZS?=
 =?us-ascii?Q?CB8tfDxm/YX3dTCgH0RcAZ7UHXt/Em7VQGUoiXzAQNL+D/ZCfteOkUEffduX?=
 =?us-ascii?Q?mxq+BukesDVbkRKdrtSjCccK7BJcHG2Qin2WrBdIZQt9XGuLwwr4+kyxE3ns?=
 =?us-ascii?Q?fGH7ej2VlVzP8RQVQNNqUnjB4fddjgY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bcb4e8-c180-47cb-9ad6-08df09ae3452
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:31.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSahe+Ck8RvHsHFTf63ARjGzunVjtjhVTfC3LEmxQVcooT4Wmvqz+U9MR0I9qbwqrAkN2HRN8VO936vfCjS+/xZQFhrj7xRt95b2NvSivYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Instantiate two sysbus xHCI controllers at the documented addresses
and wire their single interrupts to the GIC. Match the platform quirk
by disabling streams and expose one paired USB 2.0/3.0 root port per
controller.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7edf1bcb21..61b9ca021f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -141,6 +141,7 @@ config PHYTIUM_E2000
     select PL011
     select SD
     select UNIMP
+    select USB_XHCI_SYSBUS
 
 config REALVIEW
     bool
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 8194afb6c3..32c2f23443 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -38,6 +38,7 @@
 #include "hw/sd/phytium_e2000_mci.h"
 #include "hw/sd/sd.h"
 #include "hw/ssi/phytium_qspi.h"
+#include "hw/usb/xhci.h"
 #include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
@@ -57,6 +58,7 @@ OBJECT_DECLARE_TYPE(PhytiumE2000State, PhytiumE2000MachineClass,
 
 #define PHYTIUM_E2000_NUM_MCIS        2
 #define PHYTIUM_E2000_NUM_UARTS       7
+#define PHYTIUM_E2000_NUM_XHCIS       2
 #define PHYTIUM_E2000_NUM_GEMS        4
 
 #define PHYTIUM_E2000_MHU_BASE        0x32a00000
@@ -89,6 +91,8 @@ enum {
     PHYTIUM_E2000_PCIE_CTRL,
     PHYTIUM_E2000_PCIE_PHY_CTRL,
     PHYTIUM_E2000_BOARD_CTRL,
+    PHYTIUM_E2000_XHCI0,
+    PHYTIUM_E2000_XHCI1,
     PHYTIUM_E2000_GEM0,
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
@@ -154,6 +158,8 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_PCIE_CTRL] =      { 0x31000000, 0x00200000 },
     [PHYTIUM_E2000_PCIE_PHY_CTRL] =  { 0x31500000, 0x00001000 },
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
+    [PHYTIUM_E2000_XHCI0] =          { 0x31a08000, 0x00018000 },
+    [PHYTIUM_E2000_XHCI1] =          { 0x31a28000, 0x00018000 },
     [PHYTIUM_E2000_GEM0] =           { 0x3200c000, 0x00002000 },
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
@@ -187,6 +193,11 @@ static const int phytium_e2000_uart_irqmap[] = {
 
 static const int phytium_e2000_i2c_irq = 106;
 
+static const int phytium_e2000_xhci_irqmap[] = {
+    [0] = 16,
+    [1] = 17,
+};
+
 static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
 
 static const int phytium_e2000_gem_irqmap[PHYTIUM_E2000_NUM_GEMS]
@@ -383,6 +394,26 @@ static void phytium_e2000_create_gem(PhytiumE2000State *s, int index)
     }
 }
 
+static void phytium_e2000_create_xhci(PhytiumE2000State *s, int index)
+{
+    int map_idx = PHYTIUM_E2000_XHCI0 + index;
+    DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *name = g_strdup_printf("xhci%d", index);
+
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    qdev_prop_set_uint32(dev, "intrs", 1);
+    qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
+    qdev_prop_set_uint32(dev, "p2", 1);
+    qdev_prop_set_uint32(dev, "p3", 1);
+    qdev_prop_set_bit(dev, "streams", false);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(
+        sbd, 0, phytium_e2000_memmap[map_idx].base, 2);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_xhci_irqmap[index]));
+}
+
 /* The vendor DT maps root-bus INTx solely by pin */
 static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
 {
@@ -820,6 +851,9 @@ static void phytium_e2000_init(MachineState *ms)
         phytium_e2000_create_uart(s, i);
     }
     phytium_e2000_create_i2c(s);
+    for (i = 0; i < PHYTIUM_E2000_NUM_XHCIS; i++) {
+        phytium_e2000_create_xhci(s, i);
+    }
     for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
         phytium_e2000_create_gem(s, i);
     }
-- 
2.53.0



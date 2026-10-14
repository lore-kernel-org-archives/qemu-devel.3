Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9182CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr2x-0006bf-2t; Wed, 14 Oct 2026 00:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2f-0006ZK-Ra; Wed, 14 Oct 2026 00:56:43 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2e-0008Iu-8L; Wed, 14 Oct 2026 00:56:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0EvqwFoldTzq8KtJZKZbfiOPsm3qrRvlroCjYXeGFjQ6YyTIMI2OEMxQUIRZZN+GlrzWcHVJQ6bK8xE4Hm8JA8ffkbZslebxkZ1SJpgZG2ajbMI+JJ/fnjsS0R0EKhLjEbQEK7UFAx1FnCu8nlGluGRQF8bBV7EAF0boA2Cw/qGcXu+F6N7qiP0gBY2kOT07MUmbBfdLr2Q2gFV5vgqWO9hRXaNpew2rwBtm17DoIua80BQ+B99MVgD/S6tbBhUZq+Ll4ZrM2YEaLa4h/ZBStxlQg39PKtMIei4Kqox81dlkIUTT0MhqMyOBtZswfgkzaXcUqLlitLnXy5C0ZOJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++h65M+p6ahosBIhJRpGF/xg7UyzNStDZDNhoL/BVtU=;
 b=V8QtoGCiu6Byny85PO3bDeRvqOurPsqoyq8SMSezuyhv3LeLifglVgqLg64GuhaOfHLvNmGuFni1cR3f/gQ/cewpFVvgGSngLOw2rbYef3ej3X8OyIWKQbJiIKH2GdMwylDA14+CrnxxBOPUT8jSLg31n9fDPvIG9AiMnTY3OgHZKRm5DuA0wxzbCay3n3anEY9ivaYeqO8uF0vjT644MOodgxqSGxDXsxB1lEzPJl0iaptsyVPLMa3etiTbdmln/xS336Xp64xb8jWm+Tza7cyj5uv00Exs3uF7016gKp07DInShewstxDYHaboFIEX9uGzFRazUeetL8FcL5qQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++h65M+p6ahosBIhJRpGF/xg7UyzNStDZDNhoL/BVtU=;
 b=rFfsMJ4cZ2zVVVGon3QXU72rdNkDr2TJEwb5VGkxvTowhFPk7k4GYWOZYBZwN+hZdfRaaR/S5MI/feE/3etE+ZA7pnEoRpcI8YW982yjCWvhrazKtcHzsi2RDDJpsm+51wEQvwnm8n+mjIFRGRKLou2TLGa1/LM1W9lAhIzo6RiYdRZAQbc3EfVlbaDLltP0BSCnZSOShmXUJxzO9YFQFf+nC7amAmwkpOuq+BYSv5iTHvoDCX8BGdluq7v42k+raJP9yqdcfA3DarzVzIrg9uPLEMeaRD7FTA+6aV5PiqF/LTKPK+uBDyqo793MnGu16j+t3F5I/MEs2+p0UIY8AQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:27 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v4 01/10] hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
Date: Wed, 14 Oct 2026 12:55:51 +0800
Message-ID: <20261014045605.399684-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 677e7dc9-68ea-421f-7382-08df29af813f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Oa9+uthWNKysVWI9oup8KKduhkWrundIO65oLCahxiiaxPCHSgxw6zep4HOThJ3v2Jw3B6VrFlRd4qxbdlkYRRZUEeY76vZ4wB6BMO84UuuswBu7Td+UW/WTSzWgIYxvECU9HMNk/raxmxVExn4+0qhdGXtcfOSR8PcOXNNr3RgOlRKR5fSk0yIJV6t4Wi8l4rycGft3+AZYM8dgzINRrWZ+4BulB5+xdAwSeYqw00gdSQKp86J6zpH5IuEb6Fy7yVEnsogKGKbmn++ymGvQu+KoW8y2H10Qa0o/f0HJzan/Qf7dy95h6aQ9lLkDcMUt/d4GYSlUh7n9Jw3GdzcTsya6B3GZQ5CZCl6jISzi1HxP3j4TeAou66+lkq2lSnFtLEQ/vpJmQav0VUKc7ykPn7LRPYnQ0HoG3w+OE7qY57obIV0db5GpX5+j8S9DtjZQsBWMH1CgW7iRE9RkD8dngPDwiCvTqTLM2CafQFBQOcI/qxAM3sHnFYJDdzsSTKG6WnoDh3hiL9mz2eS9APQigSP5aCyhj/eyUaxQkqlP/M44FKszhHcRipDzQFnVqiSgMEc+dF9Z42H1Qy04DiaqGH7sajLFi7wREhDk7IjfP3hXJqv+TgTOX0UE0gTZMD/D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ll3dpdA5Jibv0ZrPpPj4cNAjQqbfKkaNWaFYICw7bPHHA+ujzgDc9xmXg1HA?=
 =?us-ascii?Q?ixnnepiuaCQxkXw/B9kzmL+V7gEEeYiaYNgfGh1zkiWXYb+bTDGfPZzfyHFD?=
 =?us-ascii?Q?+uhpwSzSaU1OJSZhdQxlUjkWm8m6fV4aj83KFcKK74v3Aw7lyQ9BiyPR/eAl?=
 =?us-ascii?Q?x3RpPkTjWnn/6MUVyVl5K10sq6KSgpE99dxmDYDdN3akiDLexmxEqhvTm5R2?=
 =?us-ascii?Q?26M71td9EZb90ZIVOAwUfaUNOfZGde3qby8b6Sn3108HGmpSrsXa7xizx+Ds?=
 =?us-ascii?Q?AlTN3WMyFeu2ScdY7XnZ8jE0bkrmb2gK/p9Ww+kCjLJz4s/AhQ5n3ZL85Cj5?=
 =?us-ascii?Q?ZDahMPJJESgpiaot1CDzhZhCnRHZuEah/9wpCsQB5aoSmmrnTOJ4/+LJsfqV?=
 =?us-ascii?Q?Gs5x4vCUdFg4S94v8C/6BmAsWJiXcCKsWLpYGHqabVgG+u8TVrfBZ8bV5EqV?=
 =?us-ascii?Q?Nl9LuaMMT2VlLMk6Y2sN2eWuXAPY6wTNehwMiN0CIPvlEidIwnMbjZP3I5qR?=
 =?us-ascii?Q?hoZMGo+A/3bvKiAFvBa9XCKiYf4ygaLpE8nMACc2AHzzAV/MdHX6cUqUbigQ?=
 =?us-ascii?Q?5V1ViXpydfYNZuuRgGAENVEVQqH/+R6iDBW1BesaeRE8LCySPDElrnBGWvxa?=
 =?us-ascii?Q?xUiEQOjB7/ca5wj3XPAW98Yjg+jumA9r1EAQ74ROXX9ZOPNBcW6qEF57ySC+?=
 =?us-ascii?Q?cauqKbrvoEPo3OscsZ660SkxWKydBoQIo+TDRgQwCriLVGuOFkS0YsAQzhC7?=
 =?us-ascii?Q?51YLr+LA/DqtM7Spy0ZMWd9aRZSimjL7hP0gEe9PmMI6VCkr2+lVvF5K4kDZ?=
 =?us-ascii?Q?cg3UEx2ThZHVWnDljOe9ZpsXL9g7Nb5TLvG9HbHzUg4NJ0M/e5jLUp56nfDC?=
 =?us-ascii?Q?EbSgnJqXRUbgTsX8w/+zXqCNP9c7mKZvL/8JQVqR4V2wnYCpXXx8yQuqIXlW?=
 =?us-ascii?Q?ca9SJdYRJocUVUdMN63sHTulNo1TgHn5dX4Y6piGWR4YwczCNxwOQLferzZy?=
 =?us-ascii?Q?ILDmF7Jqx1uqdCcNDhZAsDfXqjvxV3cy2z3f2qe2oe8J08+1u4wHoe9+wZE8?=
 =?us-ascii?Q?cuI81HkmaoLDoX6xEn76UU6qKmHPL8QQGAfcKMIFZJ4Op81O8Q0KtWi7OyDq?=
 =?us-ascii?Q?b2htFLIMm7tih31UGBY6K6uO0MQp4L4RgF/7JPHJZTnKH7S+hQMFtxja4K/F?=
 =?us-ascii?Q?mSasHamr8eRSeMeg1ij6OoT/cCZcgZlhkFDWflTlgp3WU624jeAoALWDlf9u?=
 =?us-ascii?Q?W5uLs+JKM2NfcxTZ5OT65AmsgVxn9wpSZ2ivN17GCuZpAeIxgJaNGCRxqN7+?=
 =?us-ascii?Q?5HL6IwyqtW6l+nimShG9KhZENMGlFZmJkoV+nYFdkQP41ZrJ9N3TIDxxoIo6?=
 =?us-ascii?Q?XUzJrFGepzQ8uA0RikgClwIc9Xpj669dWWtrF+XfD0NN4jpnejnvVUhM0/t9?=
 =?us-ascii?Q?+71Bq95GiDfBwRgOf3Ll2I/4XG50U48RQqINZE9wFamkjpfddTdx4CuPLqNG?=
 =?us-ascii?Q?GIFOXrAUxpSUoUxd9AXbqTx7XDt5jyog2IjepdSafV9K3Luo0BdX8nv7hJjl?=
 =?us-ascii?Q?CaD9uNPMyupTiAXDljBiOiwGRpU/HhlCfzyU4Yd8omisuxLcWBp/U0vyFkB8?=
 =?us-ascii?Q?oaJG1P9zrgB9KgJxdtE6f3Mz0LGCJZKuJFkYzZ3QKo4tkTIUwl5/Al9z1EVE?=
 =?us-ascii?Q?1tclARnC3jViBe75J3WNKOaV/cR28l7TACuAofw02X3uzvFpZaIhsl7k2LN1?=
 =?us-ascii?Q?sSHcdZvJqqjupIgaIb3T03CS1NUhWag=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e7dc9-68ea-421f-7382-08df29af813f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:27.6012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/D7bX/e2c6jn6xQn6dgRgkJbXxC5MBUeyfzJ55iZjmNr7Jem7n/xfMuC6mvJY9NoDQyEvejOaw84rIvlGXs/O/Ds9zNU+qO5Vby2/Wv6Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
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

U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
so that access causes a data abort before the console is ready.

The Cortex-A15 and Cortex-A7 TRMs describe errors for reserved
accesses, while the related GIC-400 TRM documents RAZ/WI. Follow
the behaviour relied on by existing U-Boot on i.MX6 boards and
log these accesses as guest errors. Keep the reserved page in the
private peripheral device.

A U-Boot fix has been posted:
<20261013232700.289717-1-bin.meng@processmission.com>

Reference: GIC-400 TRM (ARM DDI 0471B), section 3.1 and 3.2
https://documentation-service.arm.com/static/5e8f15e27100066a414f7424

Signed-off-by: Bin Meng <bin.meng@processmission.com>


---

Changes in v4:
- Replace the reserved-page child device with a MemoryRegion
- Log reserved reads and writes as guest errors
- Explain the RAZ/WI compatibility choice and reference the U-Boot fix

Changes in v3:
- New

 include/hw/cpu/a15mpcore.h |  1 +
 hw/cpu/a15mpcore.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/cpu/a15mpcore.h b/include/hw/cpu/a15mpcore.h
index 138f491c22..7b5269d626 100644
--- a/include/hw/cpu/a15mpcore.h
+++ b/include/hw/cpu/a15mpcore.h
@@ -38,6 +38,7 @@ struct A15MPPrivState {
     uint32_t num_irq;
     MemoryRegion container;
 
+    MemoryRegion reserved;
     GICState gic;
 };
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 28cda55ccf..f0e8b276b3 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/core/cpu.h"
@@ -28,6 +29,28 @@
 #include "system/kvm.h"
 #include "target/arm/gtimer.h"
 
+static uint64_t a15mp_reserved_read(void *opaque, hwaddr offset, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: read from reserved offset 0x%" HWADDR_PRIx "\n",
+                  __func__, offset);
+    return 0;
+}
+
+static void a15mp_reserved_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: write to reserved offset 0x%" HWADDR_PRIx "\n",
+                  __func__, offset);
+}
+
+static const MemoryRegionOps a15mp_reserved_ops = {
+    .read = a15mp_reserved_read,
+    .write = a15mp_reserved_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void a15mp_priv_set_irq(void *opaque, int irq, int level)
 {
     A15MPPrivState *s = (A15MPPrivState *)opaque;
@@ -43,6 +66,8 @@ static void a15mp_priv_initfn(Object *obj)
     memory_region_init(&s->container, obj, "a15mp-priv-container", 0x8000);
     sysbus_init_mmio(sbd, &s->container);
 
+    memory_region_init_io(&s->reserved, obj, &a15mp_reserved_ops, s,
+                          "a15mp-reserved", 0x1000);
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
 }
@@ -130,7 +155,14 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
      *  0x5400-0x55ff -- GIC virtual interface control for CPU 2
      *  0x5600-0x57ff -- GIC virtual interface control for CPU 3
      *  0x6000-0x7fff -- GIC virtual CPU interface
+     *
+     * The Cortex-A15 TRM specifies a bus error for reserved accesses, and
+     * the Cortex-A7 TRM says they can abort. The GIC-400 TRM instead
+     * specifies RAZ/WI. Existing U-Boot code on i.MX6 boards relies on
+     * these accesses completing without an abort, so use RAZ/WI here
+     * for compatibility and log the invalid guest accesses.
      */
+    memory_region_add_subregion(&s->container, 0, &s->reserved);
     memory_region_add_subregion(&s->container, 0x1000,
                                 sysbus_mmio_get_region(busdev, 0));
     memory_region_add_subregion(&s->container, 0x2000,
-- 
2.53.0



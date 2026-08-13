Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F46C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXiF-0000X5-Kw; Thu, 13 Aug 2026 11:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXiD-0000P7-Ur; Thu, 13 Aug 2026 11:51:21 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXiC-00023y-FG; Thu, 13 Aug 2026 11:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1SsSbIzFXEVzccjSkqUpIS3+RaD5Ie1LuQPQIKlwdhKSeIsR0H7tkQyaQKlT1nwn6wNmzQeUwEpiwQFrODjjtPNF55tMlIVYwe+vZn1GFhMJSbJRFAM9H1g80vNKtoDIUUYasumpPB7Sg3nnfD7gIjaKRCbX88+gml3JPbuid3sWF+lloMH+u98a6FVNBVSFPugF5Lr7VGWsxzZcm9KtkKnRwabqK5uEUqv03PM0xSlTBfWNRZGg+fe2gW0NAquljjqpaQerky4FpkXJUcn77VXSUEJIiuAL67mjFUGwJZAz/2RCN3jHlhx86d/kOMP8i2+4VZzLVYblNeydIPpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5Um5TfOnfDwsQ8j3tk5u72odNM7zqEpRE//RsJuFbI=;
 b=BO5xi8z/Rkh9T2rSqqG/cxoiuPP5FgGjF2EJfHL1l6Q4518cS38Czk2wsd/KAiVhyygci6Q/z0wVBGLg2RYxguZNxdj0/dsgiS9ik2rL2PifTXPruyJLZheUotO7I1ghnWnmm5s5tXde7AZjcQZ6uMkuGL+uXDm7WES5GjQIAdKjmXX5gYaBwvqw8HBD0idUs44G0TS/qzkWj1p0JEoow5kjCF/jpjBgqxa4vbIXNDgNCKhSVy14KJL9yJ5EaR1jcyTSpLwyxEvucBac8e5oRLd2zWL8NuvKL1qMZxbV/67ZTJOI5kEkzLScBelk+V9EpRKhscooQvz6FEmf1HuL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Um5TfOnfDwsQ8j3tk5u72odNM7zqEpRE//RsJuFbI=;
 b=HDFm/4anbUGc1U3cq/VrIEoD8O3EkA+RXIopS7gwx0SaXNZ0uqF0yFyPLCd5eelmEmQOkN8SuLK6Jtzcv88B5PQr4fMEjEWBOXI73D+avU40kSMG6YXYulVes+VEdHWv5+wwXCESCJTf4VN3p+Tu+ALepOwosYojC9Zt9riYGakm+VwU8mLJfYiw9Rce8BRNygtkaU4ML5LfVb9AadsdQ4DBNLtdT2HAr1ewl+jqWucLGHZvrbhFdOmxzEbdt7H8V2LYl9pEBUZ0cVUO6kNT+cijBQGhq7yI8N3gj3HU8QG7PORuAcMZLq53TWhryZY//Y/ksu84GGEOeMdyQduuRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:51:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:51:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 20/20] hw/arm: xilinx_zynq: Store boot info in the machine
 state
Date: Thu, 13 Aug 2026 23:49:08 +0800
Message-ID: <20260813154918.996812-21-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc52ecc-9cdf-4580-b442-08def952b6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MNs03MZ9ShyV039A5ngP/b0XYQeakDFuP4ZVKP4crCCsSX5dvEe8m+oqvmVAI42EWMXSq7s8yF9HG4+QgDYAdbL0sRArJ9ep2OSiIP8GH/2xL0DEmu/1EQfOawAEzuSAmltvEi0AapzjeQWQWwX8S0DyrFurj8z4QHC8uU/lMBgC0x0PPdMcpH7UVncnRuy2m6UyIsgOQSwcBMRAYM/OSxTsYYHMrUM4VRjYD0qhpbaZcsXVPG6LsQCbjEDiKXCV0uU7Y1Ld4LHfGu6ASSd9EIQt/Tx8H9dnqgxbTixwzptdbqwH6JnPsm6TAcQnsedR7+o/xIgw861ynNa9klV8fP70GnihLNm6/WvWSYmfQ93CrlXLnwcoako6SKuPbW1w/p99uejhVDeVuFsB2xJWv9j1PQ8TqMKry1g7t0nxuRVuSON7mA9pH7aZa/qXEhdSkHjvl/GUZt4wAsXvimBLxjSVE1WreSdvGa0c7RjvLATUsrUi9+J7KU38hqcuTWKgYsihH6A6SRlORBFdXWfti5/oG15w8heBdxeynT78oztPvihZbB6YM53+dYCtj836MnNGsj++4e58SOzDBjyxE9KGCZXjRo/GoOQqaQnmnfkihBxhTz8dXXDPWlTzG+B0LK9viekzxFSTkdPqZndxjFPhTidJCjp9sYzCZvMERfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmsZQyp/6NVXLpMcjjXxlfCQyLWMSjqYHJkeoUF7tmsbr+BjtxHx9D4VyyMT?=
 =?us-ascii?Q?BvT2JK+O8JW/mXZ8cTO5nEdYSVRicbtsSHmVZMRd3OEG6lYDB2gSY4mSm8RR?=
 =?us-ascii?Q?7/ua6Oli/hDx917u56Bx3TYOM3fQA6MHUNTco1BSBkTyh2c1Tio5D8OsVTmj?=
 =?us-ascii?Q?kHIE41gRlpHEB/Ff9Ugiy13WZH16W6/7uLJy78punZOMZIyUGAnlWtwNRb+6?=
 =?us-ascii?Q?MMhRnLN15RRKAHgBAbjt5yQBW96EFl+6eBavfCqn1NhrTbFQgTiDPsNBhgF8?=
 =?us-ascii?Q?xghYDMVPbRUAhBsAXWY5X9DQ0iVNXbJ7E5MNNFJgWhWwF8NCHodMcnZatKfb?=
 =?us-ascii?Q?1cVv6rtGKx6SAclo0T8t3bZ/N+HCqEoyuEG66qTS/ZaYnTmMcvf5tEcMvQHC?=
 =?us-ascii?Q?HWfd/C4pdSTpdlL7r53dDYl18e9vzuVGiqRaKOqXSA7UASlsbQLbcfHQN+C3?=
 =?us-ascii?Q?XPp250tdkhT+HHtRC2gd/KzQtB7wcL4IDypJOUa9QenHb1v0ajkPjrjSTiHi?=
 =?us-ascii?Q?LoMa2TQR+HflbAtJ1ollZjLrOng+1GrPG2sjEon352aqY3hhJO+kUZXyi/5W?=
 =?us-ascii?Q?ozNgqhj9xl61Ap7IeFzkGBkNvpGc1O+GMn1zjlNv4jBmaBBq5cy6ufKTin92?=
 =?us-ascii?Q?0Pc+43xQcZie1ik5zxFY2/3/lCQMeO3gNmfJx0qis5ksKjsEVBzhLwJTABVK?=
 =?us-ascii?Q?uNU25opmYpg1PjXkHzz4Mdo4am1AJSZCo071d+ikLaLPPO/gT5xlClbmfOik?=
 =?us-ascii?Q?F+nMtA9MWebRi41Q/s45wFsF9UwPAJlV82Yqojv0+vU3wVrYS7YHLeMkaGBz?=
 =?us-ascii?Q?SZ0m0ikOXi2CNj+iJYzxh1/9eGD08frVRMoxuRyUIjN3SLUDTiJ7nrhJPH80?=
 =?us-ascii?Q?LpEBMA6rsWOqNUPfUEGMlaVCCiBhI+zFY3cyUuo52tgysxW90J7jPPbeDVj5?=
 =?us-ascii?Q?4kmxYTy8j+k9KyEGqIbQpg31PJqirl5+S78cUuOUkeqOiSHTamlR3GW8K8Ss?=
 =?us-ascii?Q?V1ktACPRTt/O2EMh2gBPx9mzI8y2FkTZzvrDi52AUA+9lXuQ2oo4xsblEg3F?=
 =?us-ascii?Q?pnZQS6FeMBKbT2+8z07G9Bwey2tKrjCjVnvt0bC2V5IeMYMTCvrPE1aJ+DzA?=
 =?us-ascii?Q?crmGc0pCEXfavIGOAbeLUzWfEpCzU6K3Yu81i0Q/9vXzdh+xAAGQlbuFWfkd?=
 =?us-ascii?Q?4XQX7UKWg97AbzfPon/Nei96kzlrOWJvdolKw/K1aDpXn0vYxhw/FCxSnLl3?=
 =?us-ascii?Q?m/hTTnNKuBJ2+f6aaA/H3thoSNUuyRq4irvOezynwA8HCVIhQE2omuHlcufB?=
 =?us-ascii?Q?U9iM4ekwcootdumhN0ht7gFxqKeAxak8FdkcYLq1Qvr6rljH5D3yYN2O5tAZ?=
 =?us-ascii?Q?1VuKOBU7XV+RC/JgbMY3x/QJKyxdsQWdo3Hsw6nx4su1lRYiAZ+Np1QyJUWC?=
 =?us-ascii?Q?iVZ00F09yaZCN6/2y4aS1W0ulOgcahvzas0QSYE8iQPBka+vgT4KYevNJzSG?=
 =?us-ascii?Q?V5fZqUBcbcSZ5+jJEw9F6RkJ9qTy/YmctJwckBZi0bCvzeHPsRZvdkyTcQg2?=
 =?us-ascii?Q?84633kvJTefK8yAHWYMPXDA1dKezBD9mGeMcGb8fUy0gWwi4liOtJ9bVvS2a?=
 =?us-ascii?Q?Jthif8qHDxwg466lT3QHUMLD05T0tbf7J8pn0KRbkIquoHOa7RuXdl2DguOg?=
 =?us-ascii?Q?zR/OBAch3+f/0bPLV8sxsQCxhXBZqGI3PUv94EhDEcoPNhfhTWmq+EetumRf?=
 =?us-ascii?Q?UnIvhRmtQnJonGSKxMRL94+P+tIrOvM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc52ecc-9cdf-4580-b442-08def952b6cc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:51:18.3841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDkmRr4yoKyw2XKQdM3hPakwbXQVVBhX6dVt0Z8N8QeeKGvA22egC1p44p6sE/FkxzJL1u/M4SnCzT4oy6Ik/jSUANtb5EASauWRl8oSfAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7537
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing ZynqMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 hw/arm/xilinx_zynq.c         | 17 ++++++++---------
 include/hw/arm/xilinx_zynq.h |  2 ++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c83439017..f314897540 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -103,8 +103,6 @@ static void zynq_write_board_setup(ARMCPU *cpu,
                        sizeof(board_setup_blob), BOARD_SETUP_ADDR);
 }
 
-static struct arm_boot_info zynq_binfo = {};
-
 static void gem_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
@@ -268,7 +266,7 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
-    zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
+    zynq_machine->bootinfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
     sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
     for (n = 0; n < smp_cpus; n++) {
         /* See "hw/intc/arm_gic.h" for the IRQ line association */
@@ -444,13 +442,14 @@ static void zynq_init(MachineState *machine)
     create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
     create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
 
-    zynq_binfo.ram_size = machine->ram_size;
-    zynq_binfo.board_id = 0xd32;
-    zynq_binfo.loader_start = 0;
-    zynq_binfo.board_setup_addr = BOARD_SETUP_ADDR;
-    zynq_binfo.write_board_setup = zynq_write_board_setup;
+    zynq_machine->bootinfo.ram_size = machine->ram_size;
+    zynq_machine->bootinfo.board_id = 0xd32;
+    zynq_machine->bootinfo.loader_start = 0;
+    zynq_machine->bootinfo.board_setup_addr = BOARD_SETUP_ADDR;
+    zynq_machine->bootinfo.write_board_setup = zynq_write_board_setup;
 
-    arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
+    arm_load_kernel(zynq_machine->cpu[0], machine,
+                    &zynq_machine->bootinfo);
 }
 
 static void zynq_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index cefb7789ff..669c516ad1 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -14,6 +14,7 @@
 
 #include "target/arm/cpu-qom.h"
 #include "hw/core/qdev-clock.h"
+#include "hw/arm/boot.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
@@ -25,6 +26,7 @@ struct ZynqMachineState {
     Clock *ps_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
     uint8_t boot_mode;
+    struct arm_boot_info bootinfo;
 };
 
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.53.0



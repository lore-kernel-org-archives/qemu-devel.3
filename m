Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA54CA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD39k-0007Yb-MB; Sat, 03 Oct 2026 13:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39C-0007G6-Bm; Sat, 03 Oct 2026 13:03:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39A-0007CD-NF; Sat, 03 Oct 2026 13:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPgwm7lqVxllPCm/2+Cqk4EVfNBMtS3SXoYStYVFO9FhNkmT+KwmDyBnflJDLOj/iCMbjY8/hxwl7p2gIf2V4js1uJNs2HKoxq6li2Frtd3gb1TAj4Cp2unfBM5abn8+BFCPfDhKLhSRtq4m1LnRHzdgzHDNadiEBW7U4CUKGp62W4NN+gDzK7fFlW7FveriYDpVCBO9lEGF2RZAmBrXPcVTxnMp1lp0ZBuVLk5CYicV1XU9dmlSQz1h3EMiNYdm7OJIA2YIRbx4Q6ToGO8PiHmz4g4mRtCubOASyiK5RDbmZHITW5bXLDAHyYMomLUe7blSjcAHrU8gBFQihEVg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbK/xFYqBx2zz+pg2/pvA8+teOyhsvn6HFeT0BCNWGY=;
 b=Tvj7s//2q2GXcH0smBo5B19i8apJqg9VlqBBwvf5jupMWBxUbvGjsCa2i1+Ad8/dFexXG73HrSGm6AMVW7QaU07NxL3PG1UfMXlWxUXiGLz6PdKsRnld95UkthxSgB5okPDPgcU/0HPZjWwLulHLE8OQPO/oiyDLq2PWknB3Wvc2LQycHmIL3rZjdarSIf2VKYvDokZUx6MhdpGGhxmRaxYntdqILGQeuNYQyFvTzTFssnXf++pG2TpkIfanwrKWqrhF0N1Dk9zK9BUQIjj+rGwTcCPJIV3+7zXI65xV0UDBj5FDcbk7TlYniKp07lEpWBxafWDaUjPnBiH74uRQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbK/xFYqBx2zz+pg2/pvA8+teOyhsvn6HFeT0BCNWGY=;
 b=DxG9R5qt6iZo/5tdmykii0X2SO+aH179DWKTDJZ3+ji3E+rLdVgQcmMe7eq7LXMVwXsOczGuqHeyZmwdU/qMXJqdSgqTAyB/0J4KpYE7j63kUMivN4mcYmGhNZDvlAM+W3YxsN7S/vAoERw6uP78E7BMQFLbu8ZkcVdVAyEM+vbc1LmOz3Zm8LGUk9lZJpZAkOiJJETteImmCbWn7VaV0tBm3Lf16aXAbN44VZp43IE+X3PaCKiWh3gSmSs/KWi5XQSLeBMmo1Eu1lidYd+PCCqp932JGax4okcg2KkbS0GifQ90VpxxslExbbd8V1ZDVCY5juRq+wVWgfP/RkuQ0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB5788.apcprd02.prod.outlook.com (2603:1096:400:1d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:35 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:35 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 15/27] hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
Date: Sun,  4 Oct 2026 01:02:05 +0800
Message-ID: <20261003170232.2450916-16-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba94bc3-11a8-453c-ba85-08df21704324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|5023799004|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: b5+My0KLs8hNs0Tq4ir65BYpCBtEfv3O2CGDsAhVCpK5c/yNgKmon538V+xqnv5Tw3v14U/Zsn4/28cxXnZWCjvpa6MGnzBrE/LefZx+BLXOVIQavVJAWkT59J4xcu7gn3+oh1PZA306LeWQb9tXEX35r3ZImrwU9alUIx+MooxlVVDmGLYJXoWO0vqNjiDhQ9vkSbeAL9e6WJXPVlfMPwRENBo+Wj5kJb1ccDaWjLG4kC+XeUS53XMukB/ghLszc52d3rveOdfkTnc38u/rGohjMv3gKAZ2McyvtoP1Z5YXsreIOLwBjf1+xaYwtQyYbNBs2ZFgR7DIo5jO1BCpW7XDp5xHOwoeEquNIO+I+uZIpMWS5JnPjjMdhGtSbzC5WvTakBw5lj+OnYfvcdUOtLG4vmxrtjrO8GRDuwsh+vIXirRlrSqLnawV5rFrqZRM4KudKkSGi/E8YBu1+ts4JKexy59vwsGDkiMLvCvrgbhPNiktPTNfMW4M859b+/RD90Yucrlqpg8L4JphzlnkbUKe9DTGEBi8wzYRPpfpkdr2u7quaaKF8/BVYBEkb6oS7KdQ1+d2g4N6gmwdOcRGuUsxDbwsxiycODr+IWeVqbWKR3QtHzyDiT2WSsSlus3b/kOrl4lZY/dUHOz3EANVdWm6baEIPSspMpOOfvLgxNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5we3/wA2xXPH88UE0iUWUY1JFPEmB5purP0fhayC/Q3qfL+raVRFJYH4caGd?=
 =?us-ascii?Q?RWkKhJRLb6QofT/0hUqGjKmQhNLv2gmy/8fEdr0/igzNKEVxoPP5b2m+BEUp?=
 =?us-ascii?Q?kLw9o406bZyuwvFECRE51FFgvVFqf6HyUPto4UPN9/uiIu/v99i0eiP6Pe9U?=
 =?us-ascii?Q?6dtydt+Ak8iLneeVzXcV2NYSvo3SiTyrqbAbC9me/miXFqqWhcK3as6Sv2L0?=
 =?us-ascii?Q?FZ3l9/ZoINAeBA26tEl2yuq59SlEavA0w5aXZdQDTYBo9u926lLsgMHulEU2?=
 =?us-ascii?Q?JEvWwLaEypTh1PGAE5F/XLxCUL6rxJ1F4GRRYVtBz4Zdxm9dJWngYpIoMqot?=
 =?us-ascii?Q?Nowa2BBscg7VERkDUCnMYn91TajNAJsPDF1oNZpvOJ/818vDyMx/tKmBcUB6?=
 =?us-ascii?Q?vCfoPIrO8+iAuiFygo8OEyRk3+lLkEywC9g7hMGm2QA3IfYghxalCxXLbPu7?=
 =?us-ascii?Q?BYLfwsbWowuFihA8EHq5AXZPAUDRBmpKA8rse994yLejfueYds2A5OSMTF7B?=
 =?us-ascii?Q?1IfMZk7PhSaVPJGsnLBB55/8Y3BVRHYSP6SRdTLnrUN0ymX5pO7A4c3XGUc1?=
 =?us-ascii?Q?iM1RX1YFfGxMq9P0S0naGXq8AKH7gVDz5GT++EhhHjW3ZFHr7RxJc1B+Wv/p?=
 =?us-ascii?Q?rZKjxs+zNgykkO0qoMy+iJKnzBBKjIpdQfDuLHE2+GdO/hQrYFZse/bq8hMz?=
 =?us-ascii?Q?zcUq594ydS9pU4GcvScLkdYzpA4qefMIxpVExncUsbeuUknzSm4SHx/j0o1s?=
 =?us-ascii?Q?Z8M2uHE4sT+AZFHzVIZtUx1WylWf+9OhEB/xAyNkV9Cl1QbKW0BD4gkKYAWL?=
 =?us-ascii?Q?dqjrhHAKXIv9cKGqadmlTGMQhq9ddB7NwC6aVaLvx2G45UJHLZSskdkifCDw?=
 =?us-ascii?Q?TAdR7TC5/4t8rOAaZqG52b3+N0O6FFBxLBVu/K95i0ytiNCZCyRZS7VIT7+E?=
 =?us-ascii?Q?l1vOzNJbMTZTxVu7UyAMP2pVXfyuDBKo3C4yj279QgVaoFBorQV9VB5QgwJX?=
 =?us-ascii?Q?7sxdvHg/NmVJJ0c0saXNjTzGm14fu8BeO/0mWxEf3QgKfOFaiAjpYFiLMt0S?=
 =?us-ascii?Q?m0CUGDB0PdfysgOh+E+CgWzfo4hz+iQxFi9Hcs9LI/uaxdxOdSiKkETN6E2W?=
 =?us-ascii?Q?z/xjupebX7MDR0y7XDlCSsfpqqKtvMHoEB5pJJGSCMSQhGVnd0HFcnaJGci9?=
 =?us-ascii?Q?tGDXXcqCXkkFO9e84AK9KdvKTy5yzzHKhdTVh0mRK6MNsIK3OKkyYnheLxBE?=
 =?us-ascii?Q?MNRdsOONUgjvINbNDx23n70RiN8Tz/lHMYqlw0sRiI4WnMpm81/GLeuFUcQD?=
 =?us-ascii?Q?5VO3QFDVrCDa25v+bsdP9Rvo/bdIdrYPXV7oGUTyN2LIFOr3KcP4EYlVPQUj?=
 =?us-ascii?Q?xw/pv8qAPLk3xSHNMX0EwBiFgSbDe93t7uJrpQxogQjjULlBtjQBAeushaAn?=
 =?us-ascii?Q?DbIAB+Daa9GBjEyCypeVx16Klx9kKHahLfBZX6+nOHtZvuzAM7mlc2HVnpdu?=
 =?us-ascii?Q?Lz7gzRlD56np+orwUBi79DKC4MOlqhIjDTKPqmuX1lwAyjxgV9MMzNuaVvJg?=
 =?us-ascii?Q?eZxAp7MsjqwSj0a3GMRR990gJ1YJvw9qEuYYLTh6JLtxgLmhtscZd9Z2mj+G?=
 =?us-ascii?Q?dDjSExJJpap2LNvI80gevL8bRQRUXvLXWo0CkYb5svfc5jIAxgS5wu3irIr/?=
 =?us-ascii?Q?sQk5F1usdjtNOQACKiZER4nyQPpY6s/y7wvudNKxhPpfK1R/+4+4qi0HdLgs?=
 =?us-ascii?Q?QIvjN5lepn93R1PPUB2dty/EMRcZFP0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba94bc3-11a8-453c-ba85-08df21704324
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:35.7761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GCwKVvwa2o1M3rttDJ2uDkpjd/glB77w7C61KnMixuwgjBD4vOVnqk/LSErbBEqHPxHLP85R/nh/CdRaG4VO94hZmlRadtkpc5eGm3icfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5788
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

The Icicle Kit memory map advertises the PolarFire RTC, but the
machine leaves its MMIO range unmapped. Linux faults when it
programs the RTC prescaler during boot.

Select and instantiate the RTC, map it at the documented address,
and wire its wakeup and match outputs to PLIC interrupts 80 and 81.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 hw/riscv/microchip_pfsoc.c         | 11 +++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 18f5003850..5827d6be2f 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -31,6 +31,7 @@
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/rtc/mchp_pfsoc_rtc.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "hw/riscv/riscv_hart.h"
 
@@ -53,6 +54,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCRtcState rtc;
     MchpPfSoCSysregState sysreg;
     SiFivePDMAState dma;
     CadenceGEMState gem0;
@@ -148,6 +150,8 @@ enum {
     MICROCHIP_PFSOC_DMA_IRQ7 = 12,
     MICROCHIP_PFSOC_GEM0_IRQ = 64,
     MICROCHIP_PFSOC_GEM1_IRQ = 70,
+    MICROCHIP_PFSOC_RTC_WAKEUP_IRQ = 80,
+    MICROCHIP_PFSOC_RTC_MATCH_IRQ = 81,
     MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
     MICROCHIP_PFSOC_MMUART0_IRQ = 90,
     MICROCHIP_PFSOC_MMUART1_IRQ = 91,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 3d1b3246db..36c894b677 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -183,6 +183,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MCHP_PFSOC_RTC);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -293,6 +295,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_PLIC].size);
     g_free(plic_hart_config);
 
+    /* RTC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0,
+                    memmap[MICROCHIP_PFSOC_RTC].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_WAKEUP_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 1,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_MATCH_IRQ));
+
     /* DMA */
     sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b2b816de6a..877c020052 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -19,6 +19,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_RTC
     select MCHP_PFSOC_SYSREG
     select RISCV_ACLINT
     select SIFIVE_L2CC
-- 
2.53.0



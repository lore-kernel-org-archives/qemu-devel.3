Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA1606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=vmx7DKPA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8T-0001Xs-Qo; Wed, 04 Nov 2026 10:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8P-0001Uy-3m; Wed, 04 Nov 2026 10:42:46 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8M-0001E6-Jo; Wed, 04 Nov 2026 10:42:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7Cdresnq0GVdeSODNbQtkjdNHngIPvrSC7hZYKaCWlY9AMpiOJt41dActJovcHdWHwjzMWa++3KWQFxqiHzG8N7xtoCMHZ1WfWuTzm3v4gAIES/ictYptb3Ko13H9JRe5fOn5kvB4kLzW/3M6c40a2SleXnj1W+jgIED5EriWdyEis6waYbEximDDgUpshVSiXW+tJ98lh0KOE+FuMFdHTdwCn0Ftf9+M1AnMVY8hiRSmUydMBjWNEZggH4x9y3kUsXFEBOswP8R48sGyFCNGmAlbOCWZPj8bSB0TTR0CId2kfJrZ6eFFIQ4Czy28IukVa8I6EMG8MzlV6LuGjhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgOg1SeUFNyFz0MaHsS02cHwZx1U+Ia7KQ95lh8G358=;
 b=b0F9h+2F6QkrKj4v7sWXBHOZUrTCPLwIJUD3wvUuLZLugdDY9OF3gEfVwMXlx9YPDzN8p27TB2yfTwazei+1k6+9wufBVafDZc4DqcSvL7enihWG+E0VxhpXETwlHuu0YEfYb6niiA/UltanE8nbdCnQingH7sRngj5+m0I4X0XpBK76aEexJwZkvqBsJHtvHYoJv1RkYuv6g2K7B+q/r7zyJPdcq0k49jmUOn19GeFJmO+RhlhiyeI/kLagv5IRvIJZ5anE1XAyUUKeQUKLT4n/Xmzo6+XNMdYa3sPa6asvezJLWAEmGuK++FnWSHfcYHI9VkExodS5eEFmYb/Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgOg1SeUFNyFz0MaHsS02cHwZx1U+Ia7KQ95lh8G358=;
 b=vmx7DKPAQrlA1LHs8pIvZkfUD/TfJe/Sm2t5LtWEPLtGWhuJGladUHOJ4R8ic3JbeycUjSU5nmqXGNuKtLXdQHhas1l69cxpnZU0Ll4AbAFH6yh0HQs1pd1c2KV0zvrdz/YL7PeHJOSwZEuge35ZjpIesfY+I5f1l4DXZ/28TluToEM7E9TMwI/4RGO3HtX6eTGdTDhYAjPceaosX4j6tyvIVMXzRwC9lR2/9FNmLgqBTjQtOR4Vy4fwtiyD22dJZmOaG+/zwvEfshjxipp4rS22T65mZXZTywVe2Jvs1vlt0evAyG5as/ZYvNKUwope8AaOuRd6N+WezoyUE50maA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:29 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 02/26] hw/riscv: pfsoc: Map the L2 zero device window
Date: Wed,  4 Nov 2026 23:41:29 +0800
Message-ID: <20261104154207.641511-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7784c848-751e-45ae-774a-08df3a8a3b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|261022115727099003|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: aJMtkAtZCIYCrmSEkun99qxfW4ne3dbGM0lqCRGRQgdLtzjuQuBG+mSBQbHoEcT+9P0YFbqTeT1RpQ8YJat+V900PJEXJ5JQQ6n2GHl0ihIkQYngl6Cu1C4yYbL8Igw4wLvY8o/4C5vaLGJx4AcTPSOVXU8HMrgN+R0xflkF+WD7gBZL16dRJm9KUpmF3QcsH/pgBGStxi8qfKVHif4H/j3R5FLoQ1e5aAmbCAsvQsLlScJ2JORIUBo9N8/POUD+SeSUjKyF7Z7ntYTlvLkNOsI2yr83i+8n2vSH35oOOmiR6MI5qj7gq5Vd8EBtBHpl+YYY2J6FHfSPf0rKvTLVkkebub8Ufed+vXZXy26I9mLbAH3efY8xV3P8jrVkqqSCrdMOXNIAE6Kbx7Fu0PZLjU8gEsmR7PKbxqfaK1Nn7ogvb1EtlHnk7s/avSsk2QZA8E2L9JcEecJ1v9koYNtdh9UapFoZhNjm9R28FdpMOl7Mk0JfHCROM12o/b2IEw842XVbhenSKZzH3mWa8jUOhB5+fWNoTy8NaOBqwZytVNiTIpLTcq8rGColhQv3IphWdDHO6kJcczS0u4yJKjybFHUyN3FVKtQ3i+sWN5kY0nsg3JmQIhiHXJ5TVLPJUr6g62Q5m3p28rncyMpekREBzxkHZJZ5BExNvdms0vuYTDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(261022115727099003)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUJ912Q/P3YQjhgabVvjfXutMBzUGHX1EuBx3BLKpSEwz94ZD75oyhlqRrPp?=
 =?us-ascii?Q?Ts94quVMwMihGvgQeluY82IsVU1Rvie6sleEjL/BfpzdCgMgk2QBVfMH9Equ?=
 =?us-ascii?Q?v/izjTY0Idl8ZEP716vEmZ5pBSecImNyIyOhmj7bHchYx5bVVLRAVp/mXuRo?=
 =?us-ascii?Q?3o85pjBpfLn7rEG2FgTMr0yOWWeFA324s3C0c48XTFKXvvB/y7RUe8OHpxam?=
 =?us-ascii?Q?4AuA+Ztio+ovRSArMzZuh5QC4pYuM1dRjYt+VGTRCHgV3mhBatk+N+rPCv4Q?=
 =?us-ascii?Q?n9DxbIdteD83tnzImDlmQ7APchE4TS2LM+JFLsXzbYu/P+e2uz30nyjAqMtN?=
 =?us-ascii?Q?kx3K+AsICxxJ25pL1ncJcTrd5JhNL62pqvnq5Rb3zCmR4H4GlijucnzD8+g6?=
 =?us-ascii?Q?8thAFaZVFavtFE5I3D6dnTq4JQjdjJZ64O71q+eg8ZOVXmiNIEsp94NiEvlx?=
 =?us-ascii?Q?pUNtEnbZHlf9BU2MhqHf9qnUgzxAhcxKcIZKpt3HnKTOShZWq/N86Hh+OEbG?=
 =?us-ascii?Q?OsDKS8wk75EcpzRNubbnzJd0o9A0VvV+eoJDdk7Fo1jh+2N3rg9Pu2cbHpRA?=
 =?us-ascii?Q?Br1iN9WW1BEUAh4eqtvQSVGHIPKljBDqn2CUYQwwl3iZmuI7PkTZgesoo9SA?=
 =?us-ascii?Q?O/pUoSD30leMHDimceSMEI+HvNixIY0vdJpbsaa3qVov15oagW/fFyomt6Ii?=
 =?us-ascii?Q?nLms1PqDLVAw1CvRQ71RFiOx0Qr6VrYnWS5L0Ujl5gsoiN4lqVExvzZN/vqJ?=
 =?us-ascii?Q?34JcIDb9xbtctNg78Q92EUcoNjFGkqyLl71011ch9aVxTKj6ILtxynQupWhd?=
 =?us-ascii?Q?rRcp2JzmbzdOE9/n2vSbmYJRzzyv2lK2p5yFTeRlYiOYBfraTLTWzETJWkmc?=
 =?us-ascii?Q?7qZxcY0yJcQ42GpC7eQUoCh6d8tsTOCDV2KxHmUcuBcm+GTBsH+MShmwmwuq?=
 =?us-ascii?Q?OIwhEyOaXQUgB0xFdNbBFqN3E11o746JHP5PoQ9MjHT6578lmcnExynjXeHp?=
 =?us-ascii?Q?Ozs7cdOJ5ouC+tO+TSxfbUozAybONsMIB3QZxTegqAPw/st54wotxRRA7OzH?=
 =?us-ascii?Q?CLo3v6VFhgOvJ/x6AbRRXmGx80gEVMVhg/Z/xn4qvPf7ib2s5oxT38o3pozZ?=
 =?us-ascii?Q?YbhI6xO2o2/rSoWHPd0J3Nii9QcpLnSlBCfM9XO+0EaU7JB5r230mCyj6kxM?=
 =?us-ascii?Q?VFIdfZTL9KhBkDnP3F3Jjef7Le/gXnaN6If+fWiVUHc0ljsb76VosnGo5pMr?=
 =?us-ascii?Q?RduBR8PmfGYJQ1aJzQDj9fg7L6/MTIUMJ8qfWbqUw3o9VouDt4EnMtCbO5Ay?=
 =?us-ascii?Q?LM8EIvU8UyqnR9W0jq7RGcKxrFI5N0PkvrUF4GIRLsSCj5CiXPIHCJbdS7NA?=
 =?us-ascii?Q?EJemlGrYl7OmuGjug7a/E49Z2lsJAmnG1RfWlmq+AgPG20tftnlCNxCFhtxM?=
 =?us-ascii?Q?S8N5iB/pi2h9SGVvi+t8OeOLcGdT+nynsv7FllvW3/EtNV6Op71xt7ibvv3s?=
 =?us-ascii?Q?uTwiDvv+NoHmXAPYOTTaU9XGxRj58LplI6OqZUOKt5NuLIiwMwP+FKa9RpH0?=
 =?us-ascii?Q?AnjMxypT2ggQWb5hu8GljkK/MphW4+06Uh7Fg3IwVglMgzmIO7pAQg4X1LdH?=
 =?us-ascii?Q?ea+FRVM2ACmkvjU7xykc2fcz/V+iVdmNUb9RywvzRQnS7ET38DwkDzJX/wIU?=
 =?us-ascii?Q?k34IQBj0MEuVdvgxr5u08LVve4Uu0SekOUOQhCsIJIzmqpj6ENCRfbTKuR3v?=
 =?us-ascii?Q?AheqxDbI6dE0P3z5VnI+HFDBu4GEDIU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7784c848-751e-45ae-774a-08df3a8a3b72
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:28.9181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRyUvvTGxeyZI6CPg8t2qOpIvA/TA70bfkALCOF8FLdnwNjtFAILhEc91kcsXldKUagyy35AQeeUKkwKpi5Zcmmd+mPSO/reIay17LOwIYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HSS uses a window at 0x0a000000 while setting up the L2 cache,
decompressing its runtime image, and executing that image.
The missing mapping causes the E51 to trap before firmware can
initialize its UART.

Represent the window with RAM to provide its persistent read,
write, and execute effects without claiming to model the L2
cache itself.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h |  1 +
 hw/riscv/microchip_pfsoc.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a30b944afa..612fd2b69c 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -90,6 +90,7 @@ enum {
     MICROCHIP_PFSOC_L2CC,
     MICROCHIP_PFSOC_DMA,
     MICROCHIP_PFSOC_L2LIM,
+    MICROCHIP_PFSOC_L2ZERO,
     MICROCHIP_PFSOC_PLIC,
     MICROCHIP_PFSOC_MMUART0,
     MICROCHIP_PFSOC_WDOG0,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index c6b76fa3c2..a91ca951de 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -97,6 +97,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
+    [MICROCHIP_PFSOC_L2ZERO] =          {  0xa000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
@@ -201,6 +202,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
     MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
@@ -278,6 +280,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 memmap[MICROCHIP_PFSOC_L2LIM].base,
                                 l2lim_mem);
 
+    /*
+     * HSS decompresses into the L2 zero-device window and executes there.
+     * Model it as RAM because QEMU does not model the backing L2 cache.
+     */
+    memory_region_init_ram(l2zero_mem, NULL, "microchip.pfsoc.l2zero",
+                           memmap[MICROCHIP_PFSOC_L2ZERO].size,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_L2ZERO].base,
+                                l2zero_mem);
+
     /* create PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
-- 
2.53.0



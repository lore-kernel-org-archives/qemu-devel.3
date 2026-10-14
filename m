Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31B3CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnis-0005QU-Tz; Tue, 13 Oct 2026 21:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnir-0005Q8-Sj; Tue, 13 Oct 2026 21:24:01 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnip-0006ql-To; Tue, 13 Oct 2026 21:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmTJfcyXVg4VJjXno7mZXZI0pAHYwVBADoeIfQ3rzBfLZOdzWH+L71WZEc/jyb49ExGHQgjT4VR+wBRyGmpUEQU6RAgZ6MzleG1TKk10WKDfhM9vdQfmhdZ4dVAwtuofidQk9ZtM7t6YwaSqnHTz9CfUkhSnsUSulLjQV443kKvuHYDsdE+Mw/h4yZ3VsGZs7u71qI9JzUcE/5Iq3Gm7JZRi+5HLMmNXE9kpKus5hWYVJDanCgtwSSnpXZreC5mRzXR2HEc79UFSP0l9+VZHKVC1OQVtgXxrqsh+AUB49AkPyajwTMfbGAPclgFUlkBvSdJBWRi+Ni4ISMSMfxaVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X04d1Y5zXY9Ua13B5X9ucFSmKTma+YENWiR6QgqEIMk=;
 b=juVFHBJ8Kd96/Fy/bMuEDSE4HLvdNR3fS09XT66tSblWOG9pOALWMnBJg7kEH0p10TWgE+2+E27TX1nzY7ZMUoUHs5Np2JVwWkiNwbCfKSxFr2arcF99GeOenUqlDPxA7SkTHc6kNvkrlb7QgZQuZa4h19ogzAZYeJVuVBTzcE/AvpbKkM+4xOHm4qBH9vMmimtt/iIvNLWc9ecxyWMSGnpo/olvKouKz5lkgdZ4ejaF4D1iaAoU2ERqSM9lb0SvWXE/9KjHqVkqRp2128enji+tQtgd5/sUzwonVPCqoqwvz0QIBt1RXl2h7BAoMo1bssUwxhY/L9J1yUqYa5VBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X04d1Y5zXY9Ua13B5X9ucFSmKTma+YENWiR6QgqEIMk=;
 b=BLrCimMvLRVe/PV8aXv51dm8GO4BbbpbSDMxY0TpxvRftvcxQwVec99S1TlLH/vKMFD1Gy4DMrNrfPE8higu3ukFr/FCCRR3+TzPLmYzX7NkZ5LogaJNJ3yaC+1fXi0u0JRHZ6O2jTYvAIw9yIgBKZLn3ep63bJ6qI0YXfs2ICpqrA3cZr9JaZoFzyvTZHhzbhnNa0LZRUjJrcWQsQs0+C/7ZdDBbv1mtT9avaBf1toKkd3Hx6NrHgZtAQZWS5usFblUJMyc7CsrOzGqhzCmnn+vCf4Dd/7Z5mJMuJ9Fj6eebxh4gk5vSW29DZVtwaX0LUoGqQo6qLuWpzJHpF5Agw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:23:51 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:23:51 +0000
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
Subject: [PATCH v4 02/27] hw/riscv: pfsoc: Map the L2 zero device window
Date: Wed, 14 Oct 2026 09:22:42 +0800
Message-ID: <20261014012323.322790-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: eccc0916-809a-438f-3ba7-08df2991cdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 60Nm+Gg17Yz3bQJQwX1+2KNUEfW6ZWHYhcthRxV167RmQlJoASdYPdtXBeE2q9VBLFpVm2DzosVLrU+vCeAZNxvEH9wRIfowUdMluBXZXxDjCComBPE1/Z2cUk0dF5Ff1Bs9wgSMaDxZnMED2jzCQWd2KAb7qouPz44c8XBVv3XHqirtTBazcNNckxOYHDiZ26A+uI/70RAIp1FuWdg6WB4Q2lx8/eBEonz+g8uLuadsC4Nr4fz2FFSFf4Ed4QQe+SY/GMzwlkADHhs9535BguJ2o97VnMRGHENqX540Jat6zWYFtJfxmNm5NEQL3yTEBZ7ZWfunsVN78vFcte6jZtInB+NKqZkPiv8yvIeoJsdvj0vy/u38yii//neMH5r8nBzs7BhQYTYUKAeymHA0Ircd6IdOeQPGSRgL9wlV402Apfbeijefzpk2h4q2YY2hh478qH76ApuqyFITgYle8/bZiBmtGgRFJ3tczyp4l447grOprsNT6y0XijM94CTIX/evTn73Dzj1ZF7vfUDOvVD3kd9dKb4e/2GXyUq7CUJwmHhfyeejABrUt76NdXXjDu+DPNk8RqHU3jYC3PhI8YF6oNnBtZyGBkAUkuJtAwMzN4pRRVCWYOBKIeYdrMnUEMGeCjTVsUu3BIT5bENTw9bhkME4d4pO2tIx2qmkfjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8WL8JPZYlXWHgaX/pFCMgkeC2qOYlLC/HNtDZmCcLaZy2PlES1HtGfTEW//q?=
 =?us-ascii?Q?ucxldx/vRGQp4zi43Z1XyrO1a5F1HbWjXsAUgz6SnJpq2BlTuyWqLRenBiGS?=
 =?us-ascii?Q?v1eZNk7tSm+W8h404PhujNwanlnuXGLGTGjDOb0Rfnz55w2UzLLK5BrybDHK?=
 =?us-ascii?Q?dnYfT8h8ZCu/FfrC37aL3O0WMbyXUO1pRB0gC1oikQkUz05ijNI8KpeQfvV1?=
 =?us-ascii?Q?qZ2acD64fRJHhVLuUqJbWgSAbr9qNUoJ1CfeW2wVWQZQ9e1q8EtVNksYVkw/?=
 =?us-ascii?Q?YyyaftZQPgLlv+1r7bI0xAY7+dcNUo267xEREJo4ez0flWh3iQb/XfFmZ1b5?=
 =?us-ascii?Q?v5yE2/o0o7R6R6pIuuoD6MQ64QvGikC5pNvODdSNGlrdkY/yThPgUZqWJTSq?=
 =?us-ascii?Q?GSo7YiA4NMYfQlpjw+WGRWJsRVuxwgwZB7VDFC6UpiM622KKY4Gbm81IsD3F?=
 =?us-ascii?Q?B3XXu7JYmdJJRyZcd9BmJRdGNfHu1lHyKHcBZ4PkT1a/o1+uSYeqTxCbekiO?=
 =?us-ascii?Q?L+BSwJafWU1j+40FbnS5RvuRGb+v9CyDfskg9RDj+j6fcWyyzNVsOBZKsHLG?=
 =?us-ascii?Q?4ROHMOhNk46WcU0ldcOXAdZFy/3UHZemTRw/Gle/eg3rufgxgiK2Od5VDtiJ?=
 =?us-ascii?Q?j5o1zRsmfantUxKlkDpsiz7Ilh/fpVha3KZ9kbLygI+cAUiebqrXAz0BG9dp?=
 =?us-ascii?Q?mY2TSPUG9AhXAfScQNYs0+wJBT+YMIePwlkDfXvHUdGDAlbuCF2qe14/wKlZ?=
 =?us-ascii?Q?hdZDuwf/eQoeDLViE4o+DADTIPI1HvKtgV5qX91ecdTVin1EK/Ba8YfcchnD?=
 =?us-ascii?Q?T65GBUXPkcNh/g3xMx8I3aKd9f1gmahJ9w2umCmIDXpe2cehUIx42lGjEs8s?=
 =?us-ascii?Q?Ip9c+V1lMjkxWfBi1phWkmORRAXzB52hxYF5FQOT5BrdCGNU5bL1p3H804xU?=
 =?us-ascii?Q?O1ENAA50mfQ3Yd/fTJbF/gjHRFG5BTQKanYHWmzqQbc1mwH9KO9x2UL2jI7M?=
 =?us-ascii?Q?LnNv4cNjuy/TjFU2lP3tEaySHxnGn3r/ESL8VO7K2MmKja2UyJipfIDcLHMS?=
 =?us-ascii?Q?w8T77XQmZhSscdi74vPObzB63hs0TA1y6btVFd2UR8fdSJDxdlOBqrGSBYvv?=
 =?us-ascii?Q?K0O06q2Al3b96+/MuC35Kal05TADcZEol0cunKotoFI5dEDgW9erC5Qh1L3K?=
 =?us-ascii?Q?vGz05tgiIiqaaVSSOm2c0yWpL9G+tlPVQuOhtyhq7Ztes+tnGs/e74dTBzBd?=
 =?us-ascii?Q?2jUk62wmeK/FdaZuwdePstvuynhKke7R6Dg62Uk4MjDkKgGhFEymwovsIwdD?=
 =?us-ascii?Q?L7YxIL9dzvuMsynZ2Vx30Zl5PSjByB7MSesVPTZxGyBT7GTz+qkPpLGDkWYt?=
 =?us-ascii?Q?1Vf6Y1US18pXQfusx0UZoGrwr931VAXGZXJLvDZlYvXIlGna3qpvhhNUytre?=
 =?us-ascii?Q?KO4H1qCxsdkwJAIIvI3x+2jvmF9xXMDDCNQGCCjqDsa+K49tWpKuHWGI8faE?=
 =?us-ascii?Q?LpEc+ZyZVAEsnmvS7ZHq7OYQLqzk8Rg9/tsK6Nyq75PBGyn7s8dY8VaR2s7v?=
 =?us-ascii?Q?n2clvSz2w7LAaAh4R8iPxFNS2VMOQlap7KUxwm/JwCy+uWFLY/s2GhCbLoQS?=
 =?us-ascii?Q?Sh6aV3rGfDEy7HzYwdbYapriUAOYCNB+ZKfLh+ecYD9HSyvuWE8cREkkbWVZ?=
 =?us-ascii?Q?aejiKBVINyTAP7L8Zwv3WgZBvHpTRZYXaVr7+4NYh9RQ1adAnCR6ign8iIwE?=
 =?us-ascii?Q?Sdi00jP3ok3xf7vGNhVDwlsrkVIANds=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccc0916-809a-438f-3ba7-08df2991cdec
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:23:51.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7B3QwsPpI1eFjJYIQrRJZPK7Aa4vrO/qA/98F8XL5NINl454+WN4qHfJDWds8UPFeBNzOEhAtzAyz7Z9bQcfWcpPcpRqNMKpDO1BEDiPHqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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
index cfba2990b6..8106dbb3ad 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -96,6 +96,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
+    [MICROCHIP_PFSOC_L2ZERO] =          {  0xa000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
@@ -200,6 +201,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
     MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
@@ -277,6 +279,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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



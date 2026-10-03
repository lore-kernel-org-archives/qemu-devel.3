Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0D8CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD38h-000765-HQ; Sat, 03 Oct 2026 13:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38f-00075M-6t; Sat, 03 Oct 2026 13:03:09 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38d-00075o-KH; Sat, 03 Oct 2026 13:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO4/SmR4ImXIOk2/rJU3CERlC8+OPRxmGmfcQFhxIgpH6pm9qLSGnIP8KJZPX1LNSQc5+gSMbVB11SntAxVwyR5oGtMEMharTSYGJX+AEZgD4qs5F1KDJFaTUdOI94n4+335gjyfgGtOsNk5Gn8jJJeNY6icNi8PXHabOLEq+NyVpBQY5b8xAgSS8Ftp8vnxsjtL+gf6EIJqFZ66jRZnGe854rdX5nvBbzQF2rlSxnDWzXNPmxZQBdQW8pO0x2QJCwQ/9xs8MLY0v+L2Al21RpJNbOguZoYDwQW8bfl1DpNJayASxvZAS8Rx6ykfw0K/1mut3EniQ2EG8pIVd9BnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEsWQYphQK4WAq3lkx14st3oXtaoyagMGjEfpUxvuos=;
 b=yC4P5q6m4MfLiuSaSbRrlkrdhBkxxmFn3SlABZcTVh3o5DMEdXCgvtywyri4Qni7w5XA1TqU1E12qSUYsRs0in21/Y/AZY9o+tKjALGM7twFN++uy09FXXjgF0xTP5gOIyV0BifNgZG2MBeJrlbUENDw1N3gmyBLKe5yNpUxZFp5bCGI4eliNL9sLpHVZC8AElotHYUSANS1zP/MdhnycfN6nOWetTHoX7TiIbBDR7VJXnugb93e6fVBq4x5D9TabrtPR8aijBjhQo7b2uarYFlyY59lLcGkh87/QjEINV4OM2CD1UAfERDVSOgwZVlMBBfGvFZlRYeHQX8I72iI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEsWQYphQK4WAq3lkx14st3oXtaoyagMGjEfpUxvuos=;
 b=ua8+0d4pGAW6/q5DCeFGxR/+QHBVb+4CkJO80BrxzRIncEFWKUqEjCFZp6GwfZKb7LYwf66VxRvm4Ac2kVM4MFHqkZMSJG8TYoiGd5QGtlfOKQVhKZXINfPDpekaVwZwf9HYi9bAA2JpaBi+3iegvzRfO+l05QNKqNJXIhv2ZC5BupPW/659N7hwyLBcbZMxhjlg/Ora76KDgkrCGBe6+VaulPqHDbXRzcTaYSBtQv7PvZba8sXs2+GOt5u6vq1qkj8sQKUM0Tq+QwdE5KijIOl5hiZ7bvxznYiUsQlY/rGRD1yP0MhaIBn8fVXFF1MYyBSE06RyFmAgGPu2fCXF2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:02:59 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:02:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 02/27] hw/riscv: pfsoc: Map the L2 zero device window
Date: Sun,  4 Oct 2026 01:01:52 +0800
Message-ID: <20261003170232.2450916-3-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb5a7fe-c8a0-4303-2bc6-08df21702d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: C1qvqjkgWUDp04SIBcDx8MKENpNLPA9IaStEY5EnjMMBq9zN70Ae5KPcBGy7rowiin+y1SHj6KNckEKYMtNjua4FzFZj35vldfUgRddQ45hOrIDm0ytwhNk3iRG8u/gkmQOpQ2CxZq9XvDyjV6pmtvCK3Mzwiy0MtV2hTYxI/BGFL++Xb1aFJm5z1oPQL5hUx8xjD2Q+jFkndwqLz/fsAanFADVZ52IKS1mzXvsVOtj9XFLlBgH8+Psw2l4jYvdrwXAqxf7q8UtdtjiPnhJe6sPOUxWYOtxpaLwzqYlPlrcwiV2JQnX8o2+wEqLxV/ekfpDjXMS5GEHHQVgjacWg2yWq+zvGrzwcsEe3RaQhXpjcbl4Mq//gyouzXsZtp4COYbrtq7PPxvZ9CVIk3ueZXo+Wu/qJZxHrgNxZ2wJnGYg/HmDcAZQ1civb/R2q6Nw5VEHDrueWwFH1xloUo3emPYEhEusIGv7yOwa4CpD33Npe2ujhsuB4EulsbqN1bgy3EQEHI8yDJPwlyrH/016aXW4D8LZAM8GY5BjwdJkMl9gTe9baHKVhQwzc/DUuWfhKjKOhiJTDwBrC+aHF0V81ZWFrzKbYHgvxJGLRzdJyNitOjkjuFCIdG4EOEAK7uYtTEtoptor5QRrnzoGNhgCynenMwMe1/ki7748ZJn2a26A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvGWXjSv6xfNRSyQaQf6pfWaUQX1q+u7BXgukfxZWS1g10bsnkiqqQtz4Xpr?=
 =?us-ascii?Q?d4PgdNLwc7I5y5oj52lfgipQkSaZM2fBLQFD/qtrUmQnY8VXnrTGQ5gvD8KA?=
 =?us-ascii?Q?aDaTYXqDkiKi0CeSQfVMRn92riwNjMh5lVtMurg1sel6m7hJmj43F7a5WHjh?=
 =?us-ascii?Q?ofSiVoKtDsn0khA9AyqmJ7i9vFsT2a+DrO/kuCnLspspy0ErcBOqd5Kd3pxQ?=
 =?us-ascii?Q?Klm0OC9cXT+NGn7QgWMFKFc3NCIQiDcXJUFFIrOp7+MDGUVdhJ5SY9QbSbsP?=
 =?us-ascii?Q?lIGjl+LVkQ7PSjyaL2fdKCDAcEabM4LgTWS8AAX4CDxCWZ4+WR6pb41/O8j8?=
 =?us-ascii?Q?vT/8TLa/vViymGJXHw/rC9bChOYGE7QAh2x6T7xWs9nvRhJ1BvxulrSymWUu?=
 =?us-ascii?Q?0WT6yKDB1iCO0bMV/4dQLzbDqsOjTEUEp1QEWFP5/6khxDONuyoc1JyZprAT?=
 =?us-ascii?Q?7mjSiGKkA+wZawK2FvsOEveGuB3XlvkXE4AEp54r/Uxw8H970okcOtJ6Iz1w?=
 =?us-ascii?Q?2iM1r1IfAlEv5OkCh3WQXVbcNqb3E3THrL47w9RiK7DVn0WzEF5QR68mFNt6?=
 =?us-ascii?Q?Ruc14ajDUqhHD1mpH+j6mRPNvBeUZ8EbXFKsgHtz4e4+4pAb2uLioi18okOc?=
 =?us-ascii?Q?o4496ut+48vTqs8OP5FDdvTGwB6h9186+OpYfJavgS4yRt45idyFqlNet8uJ?=
 =?us-ascii?Q?zo+h8zcA+zGiMilmAXjm6+j4P1zcz3R6Ax+OqdboiDA5i8RdpecCUFqIXrOc?=
 =?us-ascii?Q?X2WG1sef5wyf6NoiSML1dHe9cj4fVlKZ+Fempqu/lcgUKF+cA3+h9Jx++0xG?=
 =?us-ascii?Q?kh5OHZ/njNg1lpzBiZFiT1jJFtGfLjFxHd+o/cPap+8PWMmte2QwBB9j3qIj?=
 =?us-ascii?Q?kDr0POSHu3V7SPHn7tBYm75KaycV7HQs/O1Dow8GGnuhuSHBt4vOJUHlsPGq?=
 =?us-ascii?Q?9oDVri7ScafXcQXbbrdhPayGTJF5NVWGRnpebtxGO5Z6jvCEYuYFWo8ODrQg?=
 =?us-ascii?Q?GQqhSWyEtjTIwN5j1e0nPlSYhkH5TCN+QrfzyogSn57cchxPcIhXZb8Ysz9A?=
 =?us-ascii?Q?KeW07ciS+d12kLBJRf/aSpHiv/PEI5jknZ352I9tkHEupK+7Ncuil4E/LaVW?=
 =?us-ascii?Q?WqtYLUA8Yc0YpQ5WtR3WUlebTcS9FHE66zPkGJ/QTgi2g/kRpjtvL25TlLP+?=
 =?us-ascii?Q?U8GkenMeaSaPFtSBxM342nqTNDROjtLpdFpYAa3oCNGZFBCdYekxbBS+jmuk?=
 =?us-ascii?Q?3hjcOm142OtOvjV51Lt3W/hN1m/dE/8nNbuIx43FPK9Ewx8LzjhnVyRXVfAK?=
 =?us-ascii?Q?yKOCPHHY0oXxyWUgismOIt/kNa8DKh5kTqJJ6OncEe4gdE3wIkXGxxK09mxL?=
 =?us-ascii?Q?DfrCDRfNFMzKiBvtV0+2LjfaE3E2+Lr134+NXXwLYJnVEhp61HAikWdr2xmL?=
 =?us-ascii?Q?ApGfnPIpQIHEA/jwmvFWQGL5lfPl7nMdKujUR5YIHHRgLhUIzUsGXOpy64qi?=
 =?us-ascii?Q?pWjeUVCiDtkrVG5pkUhs8FZBXfSTw8OBQc5nnPNLynl4YnZE7OqISJOaSSOx?=
 =?us-ascii?Q?wmRHIn4WOYHngjTGlVSqB6Chh2g4XHKZBuSscRHhlte0ikU0HGoAgGTFHnLZ?=
 =?us-ascii?Q?X+UIBtxFSTP77IVvlAzIa2WRxeKS3uJ1Qo6C7YTtaAKclTe1zqgH3FuEO+7h?=
 =?us-ascii?Q?fMbfGHDlj4nQ353NLVnzD7b/FZzt5E8jGwt0cXm2NZDyob5wElv4IuLy8Tyg?=
 =?us-ascii?Q?G2xzbfKeMQiKT+7SJb7FWkv70jtHqD4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb5a7fe-c8a0-4303-2bc6-08df21702d5b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:02:59.1581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SshSZXrtY2w6ncnQRdt/rFP9ehdKz07UdfgqDP34fLOjnX4sfNIb7LnHW+kIY3JtW8y1N8yMY6FK96g6PSDMjs/Nmf1vgZ8jLgwJZ53wxiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
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



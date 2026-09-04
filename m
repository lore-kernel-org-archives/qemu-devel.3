Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6564C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKI-0006SL-JG; Fri, 04 Sep 2026 11:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKG-0006FT-Io; Fri, 04 Sep 2026 11:59:36 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKE-0004Wv-Tb; Fri, 04 Sep 2026 11:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwsQ6Z3BCMRZEXIKoNuLtChky5PHmVDmubdfOLpZ532LnNKEfgXgTtSbumvuHqMIvnOD+GQynCoIcdBgyvza/yqx3QXx5DcXt0/9C1aVfhV6qavnP8Vqslvf9fOgczU5+YKH74/eNQBgSZx0gBNVwPvaDf7z8dyRei1SUogqzkSC6vE00AwskHhjYm2q9HzLbww33l9YZCVtW52SKbHD+o5VEfxhio9/8uesbwzCnReSLLNlCHJk8zIWQJb7y59xvCuljsSfnLeBYTaPThMuR1fcl1GhCCSSCVJu5gQrbpMW+J1gJ8EKmbcAlshAr4nPpSa92ABHov6wuUIco4b02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/9G2H5V6Xd+jVmdQ3rnM0+HzKfd9EBQiGXQ2FLqH6k=;
 b=m1GHyIT6QcdxK/q2I8mXBOk+6y33qjgwbYDdxiKQVayaXZNzKZGtd8Yqg2x+TxzVzKtftw/7leb9kqsFkiHqwn9ANz8TBr4E0YPKxrm+etoSw+jBDTRTm0vdXI0yJ6eruKBtbSxsaXYlk/zQMrgBqGyG5e4mgmI8I0LL7VXRoMKDVQyD7Ct/v9gPM5mvXoENtkBoFWp2lafOftcVOUrWZdLzY/N/ezlJ5zazAAol4BBtJ8XmxfjKSNJC/k+n3rGq6wb4JXRN/YsAu0OkCd1PTJ/9f8yj0y6U6+XYhr5RKzvsXWM3Jfiq+XTknGj91uEwq+AKxUI08+KNQeJEL1uBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/9G2H5V6Xd+jVmdQ3rnM0+HzKfd9EBQiGXQ2FLqH6k=;
 b=X4E6Y3TWzrTDrWlKx+w1wqTN1vESEyOBsd6D6BhH75sGo17sKfSbhlPzsyHOIR6E4dt2AUnYFXPbbTwT7VX8BzAVxJsM7QsryDx4QKfeaGGdl2/BGH5DbfHZUBQNKtnB2alTYNOVuT7LQjnOFPkpvGoe+/pNfSWRsRlAlBP3Hyf9z6wbWw/Ehf9EhreIpA90c+Sf8GT+otT4jwe9S6jn9h+WsH8NJysP9X55ijgbvx+ksj88m/gfLDe5JPkrc3370vsoDGSgnaVcibJifWiBJ7WemvkEmFIa2xmnYiPZ90RWoKes82MhVZ80liCFdMPNhk4CRa5+3jmvGMwUmf9jZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:05 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:05 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 18/24] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Date: Fri,  4 Sep 2026 23:57:37 +0800
Message-ID: <20260904155758.3833179-19-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a57bd61-e9b5-4d9a-9be8-08df0a9d7277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: TrFoxSRAxEeyeakqI59CW+GFCnfzc9OPEkanmNHWetm4S4UCYK4ka5vpiHZQM1n9HzhwTfm8hX8mo5z3ls9/cTsU+CGWzd5dhxhnIxchLMO2JYIbhALFnhItG5gf3/K3PQgB/s7ja9yuMUeJoXc0WVJyivlfTNi64qBNldQ8CIkm7YN4q+Iz1rpFyT3jqlMPWKoxOwHNX7OLWFCCcrIo/yWEJpQXoMKRpZWMMnmL2nZP8Qbi9x+GSvqavwx3qU38KwJx0E4fBQ+ButXgPfSghjFfCStCumXk0Z+s1qee8ylF0IFF6NUerFRKym7wbawzLei6/7yp18zB8Nal5T8LKkYW4W8cT0Yq7so9LI0RfcOFyuVT4q3pHsWSeyieQBuRESnLpcw28V97Ypc29hJ966c2XxrOrmTaZDZSXYEAK38eaZ7lQA8cCwwGeSe2O0/UUYB0tIrNoE8bmlQvJnnhsIMuxHWvkZqccPIR01mO8AxJKjMx+vGEuLRhbvXvkb/8TMOOLvScOAQ3EYpm6XxjV8ILbEJBTwKh09k/2mP9kvVP9g03uWz8JXjhJDxhdSqL7Zu12gqxsbUUUba5ialtiAtYZtUzcjrFrtt6b8Ntqm4TelrdLjjmfAUdECRAv4MWwjAdJR5MTlUwgNkIUgncO71kQVmvgLTNF/HaQgY9yJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+EsKGLEOLq1c0wuJ8fee74lpUiwWjBKPe5PIRbTNpA+IKzwq/eDcQ+7urxY?=
 =?us-ascii?Q?qbamUvl8Py/SfSftSut0qYsWsgGSLB0G+KY0Q/62W3qKFJX6ek7p15dvEqRv?=
 =?us-ascii?Q?cVR1/vtGYvT32KmaT6FSUJ+zPwJ5hforEmiLx+36G0H8EKKuv8pOUTdpNV7L?=
 =?us-ascii?Q?+s9GVuO6AFnoD2ziLrhARJ/PdELVtBS+teMJ1PriCDPCDtzj5VRye2xiWwMe?=
 =?us-ascii?Q?1bXyytRnfl8Za9gmm224syIYeBBTSApAxOpnDRc+jy8GmGy3V+6aO2U1R3B5?=
 =?us-ascii?Q?ghgTSKoQWxzblPbHTqogiHoTkWxU2G964kJAIZZnCUP4UTw1J9t1qDSB72me?=
 =?us-ascii?Q?Jo2n20efFwY6heIL06fbXkc0Svh/Qi7lAJkLuyP97kPNAwiyJl4ICwGnV67b?=
 =?us-ascii?Q?i6QzPisZO3Qq8vW6gN80uAwKffqKTVUZRI1/bAKgE8c/plTqdhgsGWk5Dt2b?=
 =?us-ascii?Q?t/xcXHM5AKD9zVNWusk+LCEFbvcGv2rSlORnIEcG5idLtJBtCDy4E7D5n3ZM?=
 =?us-ascii?Q?+F2K0Ckr1CeB7Wc92bcT9PBjNZWAW1ICCyvWbP0FD6gy7lJQBwlT8x4hfPP+?=
 =?us-ascii?Q?9DjDdpCkH9SdrZDxQElvOU/dyjqaQWw9Dh3+sxUqMr0qogPiXNq36KgLmMvB?=
 =?us-ascii?Q?IAoHk+I0ABZ2d5nkN9Ac0i2jOm8ZVif2tMrFNq6qCRT0QBJnpniD6R8LvZOt?=
 =?us-ascii?Q?ckW/9T5KIEpMUEa1WRjgLbSD4+z3J5rwQ3tOD8kgsAFTDFqLqbgqb1ZgoibB?=
 =?us-ascii?Q?zFyb6+NBuZmf3nBSf9CRIEaV4JW9Tw1kxAhv1X4Kerlj8NlqJKO/xtbC2Fgh?=
 =?us-ascii?Q?TKADr2sYeqbXwY1BLxAK0gpMI7+HGa8l2OzxDPeNGDFKvnL4rsf9nthC3SLl?=
 =?us-ascii?Q?Z5mdhcHl83pF7w3XwLtaxcOi96Q5EoIdce0w1FDIHesBD5ih0ayA+fRXqt6u?=
 =?us-ascii?Q?4rYiM10KhrqLZK2IqBxdeslnG2XiFGL9heHz60yCr3CFNjQKvnhRpJyEiJyH?=
 =?us-ascii?Q?z86WGzTSXQEts5KJG2YEgNvsQc7wzGEpSmnysrXdr9IH3Q8eMoxRXygXn3Wr?=
 =?us-ascii?Q?jc5yIJi9/eKERE5Z5DdmTK1xZvu3U8HE9OYdrdiUPnL+YEpx1g8lcsHfsf93?=
 =?us-ascii?Q?Re0YItaUIGaoLAoIwvzv/q1iTQMjly8xWLM2h0jADFm+g9eO6/p8SRbc/uzh?=
 =?us-ascii?Q?W37PX+yzpBOl3XL63ayt+7HeFJ4JvupYN8l48BHxPbxakbp+k6FO2EcBIpZi?=
 =?us-ascii?Q?e+zv91JlsNMCdaNgikWFGpBYogZ4tSkrnW4eAp38TSkI0L1MKB1erhTVEl04?=
 =?us-ascii?Q?UTEjgyftQV9Yb3jfivtjGkI4+AMuDGBC+GIX7yRlZO5q2c3BNjaw7v3qkwJi?=
 =?us-ascii?Q?KwhsumDTpnwxRcqQyB4K6xdJB0ikCF7mCK8Kf4gIZxsQXVgRs3pFMddt1TjH?=
 =?us-ascii?Q?m6+eKCYFa39Ohl7Xo5W0PZ11ZyoysMmwc6G4ReJKkyehI4jnO5ilwW6t/qQP?=
 =?us-ascii?Q?V/K1zo9OpXmWVRmkhYtpza+1Y3AcRAJwWX+OAssiI30HYm2czLYBC79OMDmm?=
 =?us-ascii?Q?myaAzabozTEjR1gIPEpQ5F0ieI4VEfnoYC6CrMfhQKTMdWPwhd7dOaQtzJaR?=
 =?us-ascii?Q?Uc3/3f36D0O2WoAPKVM6ufG9N6lH1L6x7LO4lUp0beUPXGtTrm/t9BVy97TM?=
 =?us-ascii?Q?rjqNXrTlrQs5FTzpngtYzKNB6rAH3GmMHIWYek4/kuK9G+SEE1sqHBdPBEtQ?=
 =?us-ascii?Q?8PUSVFJsLJ0tG61419RxIbMY1BlbMEI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a57bd61-e9b5-4d9a-9be8-08df0a9d7277
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:05.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtLoq6I4hDZG3Nft1qxD9vkSwRAFd8OJEzCaaNxd2dEKSypfr4IK73TDMAahlh8rX9C/bl2BRyC1JLQ5wsc+2qU7NgJI+ECw5SZm9trpQSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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

The Icicle Kit has 2 GiB of RAM, and its firmware device tree
describes that fixed capacity. The model currently defaults to
1537 MiB and accepts any larger size, allowing configurations
that do not match the board.

Set the default to 2 GiB and reject every other size. Update the
documentation and L2CC qtest command line accordingly.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 docs/system/riscv/microchip-icicle-kit.rst |  4 +---
 hw/riscv/microchip_pfsoc.c                 | 15 ++++-----------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 9809e94b84..3db2b3c7e3 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -26,9 +26,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
 
-The memory is set to 1537 MiB by default.  A sanity check on RAM size is
-performed in the machine init routine to prompt user to increase the RAM size
-to > 1537 MiB when less than 1537 MiB RAM is detected.
+The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 83ac352c1e..11403a6087 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -560,10 +560,10 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
     RISCVBootInfo boot_info;
 
-    /* Sanity check on RAM size */
-    if (machine->ram_size < mc->default_ram_size) {
+    /* The board has a fixed RAM size */
+    if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
-        error_report("Invalid RAM size, should be bigger than %s", sz);
+        error_report("Invalid RAM size, should be %s", sz);
         g_free(sz);
         exit(EXIT_FAILURE);
     }
@@ -773,14 +773,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-    /*
-     * Map 513 MiB high memory, the minimum required high memory size, because
-     * HSS will do memory test against the high memory address range regardless
-     * of physical memory installed.
-     *
-     * See memory_tests() in mss_ddr.c in the HSS source code.
-     */
-    mc->default_ram_size = 1537 * MiB;
+    mc->default_ram_size = 2 * GiB;
 
     object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
                               microchip_icicle_kit_get_clint_timebase_freq,
-- 
2.53.0



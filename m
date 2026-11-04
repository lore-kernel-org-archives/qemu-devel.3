Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144C606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=MTk5cK6y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9O-0002ET-TS; Wed, 04 Nov 2026 10:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9B-000249-EA; Wed, 04 Nov 2026 10:43:34 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd99-0001Gk-Fd; Wed, 04 Nov 2026 10:43:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1S3CnG+QVgen+Xmvy/LN7tFPUGC8TZXLIROr2ydnkEc0AF+/rczQZqznBJnNfayN3qLg942TdDqGTYNLkLtvgzsg5BjcAIPvodyCoHIcevK98QqqgJJWWI0xXRHulmzAPcJkP9lpKu/6ZJ/3k23KYTBQI69Wh6MwaZ5vzPzNBxyPzq6ycSFmNuJi+t+tLH8MJjjpM+knp2s5mHTV6IIRJZhtkscah6QuJbrtrXpfTg462Wi4sHADE5DABX68Lns/aipfJ9iO6fPopV8UqKCkI8uAODERM5XFUA8AQcND/XcWX3PHDcpVAaQbVTxuVU06XF6gXRz7XXqtn0Sd6mMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/oddsVJj3jRJdDROEk9A8ibmvg1jLZ9AgFD7A0ZAho=;
 b=nWSTPGbZNdCl3InllWhce/5LtSHaEeF0jHZeYyFI8QRy4Kl1wn09pWSMdgNLFVeAsGLGabMQqyoAj3MeGIpuE9mvJHWtOsUgLisl6/BJg/IhWxE0pQyDQH1T/kAJ9auPAYS0I3O/hlZKkhGrZpDCRDvuiCPrHm84TIgTO9XSD2lCgtfEe1qCPCdZwCYVGY9nnlTqJ1mmrXaBgoicZXCdySiF1eByBsoLHhhAv7BkdmgAhNF4nPqH/eV7IKIhN/z+z9bb0Cx4uQS5HRIWFuTMfUUIbBA5xlPdUdVlm+d44guXx14zyzyYNiG0Wu0IpLxi5HI3CbZkTdKxpZrHxYAlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/oddsVJj3jRJdDROEk9A8ibmvg1jLZ9AgFD7A0ZAho=;
 b=MTk5cK6yV8xaH056kYezrH3dYWfqEnNuNmogBUX5H+ynFmos9olzOcvsqPGKUpqF7u2StthabRKhTiHuiLKuCFfsopm0zj3wucES4RXzjOGWyD6oh2N3vh1xOV5dYCSgWIfi8LtDKTZNvUfo3zUCspWoKZS9+1CEeQ2FACCxf1tOxVzeQT/pw5738GOKKT87DKAFprvCy4j7aZfJe05JLMjucVnfW6fwZrr3i1JUBDSX1mIOayIzZo8Zpm9Yl6lG1dEtLrDRpkZhGHQBrJPsN0maYFNMnLqf9Ge5tY1GX6EkQvgefUVhiNDKflFygYK/LobFcAFTeqfH1aaPcMHd4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:01 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:00 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 19/26] hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
Date: Wed,  4 Nov 2026 23:41:46 +0800
Message-ID: <20261104154207.641511-20-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: e53445e6-7da0-4797-cb91-08df3a8a4e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|260925021311599003|260925021911599003|260925022911599003|56012099006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261022115727099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: sdilEJeQAQZ3iXXskU1JilC3ebdigjrDg+sKg5vBEokaqV6B8H0ZZIsvShGQ5+lF13X++bk5e23FUiSHBGMPQQPJlUafZQRU0qm2fVlhdKgcfuYMms4vWoxQkrqz6oHJ6IXaCAxd/UIFoIBhn05QqwissAbleKa32OM772ZxkMLzDf9M6P9uzfCR3pJzFr0SyPRti/5dJOdMaCXrpTCjiOMQaOxVlHObRTem69cWEQVI9JRxS0JeVdg3h2HfQtUWBx/5Qr5hjzbLrA34mnmGfbu50sirz7hPBAQvNz4F5ij8DPYA0mlzaUWHjNANu9gwFbaWhxfFcJ8jpuxo77Nc9sDx1aWu6aSRA6LGNzdRtgeYVFT6OFneB8i5n4e707qDJ9s+e1Pnu6L92hG2FIb6A5TF/F20FJ9OdpqMidQt1X36brZ3m0GUJu8vsT34AnEI7ihCxSUX1ANh9R/hJWY8sETm4vS7qxXw0fev/Yi5YYWcsGxGTMWEDnMsB/u+kb59OYMGLsG8OYuwTleL0dxUluukNMfDGfzbxObhEaanKsnDYoQbyLCC/q3ZfVzDwJSIRY4zBKevgGWaVWYV+Ud0hzUj/HVIiwTy+eMYu+pkQMlfuCo+FETWCVajV4mjHP/wErFC/cIji4+h6MbypQaqEFvC5mz3gO6e+3iM3Z3VnGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261022115727099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItARgZbtJB4+fqjGhC2xL0v5GPrsgdeUGKC4LYibYQdTCElpUzdoVsT2mqoA?=
 =?us-ascii?Q?PSMbousbeLHaiQPQYiO3LViQMLx893V8uJkJxYCkiuuABeIZww14mVpHBIAd?=
 =?us-ascii?Q?aBS+dMoC9DrW698XDA0Kr1jbVjE/hOSUIjNFrbDuy7UiUTj5V1kYM7y0hQHp?=
 =?us-ascii?Q?ccBPL/h30ildXFVmnJSZhJjT7quj1FT+s80sLIL5zWGnOXv4J/IJRWDccgMp?=
 =?us-ascii?Q?6qQH6me8sdaloQzYVBjXfOjbBtnqEc35aRz/b0imU4wccWLGjURX5e44SxC8?=
 =?us-ascii?Q?WsTrDxl+tJh7U+2LWLLq0LlcED1ejgv1U51kf8GSlwgcLWPxErlO7gyMXfSe?=
 =?us-ascii?Q?98ZQxZs4lF+oCG5FA1aWGlneCyWXmBHlS5W7+6iFb7vdvr6szSW454sodf8K?=
 =?us-ascii?Q?c5d07yXi/16F7tFb51COiaveLzNODziXcDrkrYs0OtKggLsLi48rmoAC7NPy?=
 =?us-ascii?Q?lGhVLI+5pWL9haxii4OH+C3JHtEBjeIL+gdYx0t/Xz+tSAV4Ncql+YGHW0hQ?=
 =?us-ascii?Q?a4wyH0FtwY0iDOglII/12AegZss9BDF5SsxAa+vIfpwda/d1dGuH6NqvTK8L?=
 =?us-ascii?Q?kwZjwEbZUGh+su6zwGidETB5kjQpMjVVn/BnsbS0S6PxnfdNMXjvVj2cjEUj?=
 =?us-ascii?Q?RFv55N9ZmeMa83P8NmFvYzejPCxYjjwW3U+4HlI/azs6m9XoHmirzn1OFhsN?=
 =?us-ascii?Q?xNXt0qEVb/gOm5BacMijOvceCrvfy3QAj5gfzJsscXNhjzcFddpuSgtSxy/+?=
 =?us-ascii?Q?FbiktSVnUuGG/JaS4EzMtPxJHtKH04dAvbp220EyPPCka5e5Qs7stKfQDMPf?=
 =?us-ascii?Q?HJVmUMSRnCV81z3dMJ5hy4wBj64AYRK/9QUE+p8LYsQMtVzyZdGXNOLNXsLN?=
 =?us-ascii?Q?4x0MoOYMcBb2wkY1Q1t7PQAPMgloiSwQsEed5UqD4RTnAG83VA46sunjgHQK?=
 =?us-ascii?Q?uqEAaJgaGimBEe4UrsuS7bg/gczAKYOtpuwysYrWYgk+0FNmYdVR8ec4ZSRO?=
 =?us-ascii?Q?2HyGc8XILag8lZagM7Npab3wRQfdNrdb6nlfzDOz3weqaugHF7Gj/JwAS9OS?=
 =?us-ascii?Q?BqtoM/TBagjCF/x6UGaS86U5cRar3IMNmAJMB8drvCl3lny5Lj1nGmrsnwjA?=
 =?us-ascii?Q?sJCCRXdu4hTN2GLwihkkeJDhbqU95Sn7mP3gHm/pZ3GFCKI1AJZMMY1F4wdH?=
 =?us-ascii?Q?7YRQj9/cIc6tvEoRxW+HQR6O4GKT2lWkPn2ufbWaX5z76oM4uXoZF/3bEHTc?=
 =?us-ascii?Q?B2toAcj7nKj9MNjLMRDmyR8pZ23ESC/zN8e2/dNJgXrA+CHjeIYjUkloaJ1S?=
 =?us-ascii?Q?8sXr/nig1qCuKZH3zWlD1hX6UdICI19mA41xcLOrwNNh4CuZy1Pi++zW7Hs+?=
 =?us-ascii?Q?rYLeKkY6QjBx9oyzeUpmWaaZ7VjweQCRa+ZDL1kgdYiqVnZehybPl3N/WFqz?=
 =?us-ascii?Q?G1lVIoPXNeSbgOhViOTQteDaCAc1Eo7C+iOQ+a98Kbx4sGvCs7xRxS655yPp?=
 =?us-ascii?Q?ehJUsIpdsQPP8Ddmp0nBokKQ4h1RHTnws9iRvWzWHufkVNV3sSMFgoGQ9CO2?=
 =?us-ascii?Q?KdLKW6nrX+jN1Fk0SlK7S//pBBVcK4E8vfGbRaoOBHF6+W29PIbCbdwI0rDi?=
 =?us-ascii?Q?fgSXcqmayA2ylRL/0mKj9UIpWMsy/ZC2O14cYkeRlpD1F9SfZ46dV5vAXVRN?=
 =?us-ascii?Q?uJRDZf+vyPNM0QVNcY0yoweyqExkymJmcfwBHL6gvm2mJx20c8tCKV1FlHbX?=
 =?us-ascii?Q?wQZr0R/17k49zXuZvk9fsbTeuc5cdRs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53445e6-7da0-4797-cb91-08df3a8a4e89
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:00.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBqTpDFby64vGDMsUFH773hGNAf++/4FDI7buwuRqeLUrGm8cyS1xb0eh6CN2p0+kBQ+HzIFKkgPCS+nKU4Wq3CrrSI2jsvZNTTT+4CXlw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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

The Icicle Kit reference design maps the 32-bit cached and non-cached
windows and both 64-bit windows to the same physical DDR from offset
zero. The MSS Configurator User Guide describes configurable physical
DDR offsets, so other FPGA designs can instead arrange these regions
sequentially when their device trees describe that layout.

QEMU models the reference design used by the tested HSS and Linux
images. Treating the high windows as only the portion above 1 GiB
leaves their valid memory nodes unbacked with the board's 2 GiB of DDR.
Map both high windows over the full machine RAM and qualify the source
comment to describe this reference-design configuration.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Update commit message to mention the DDR aliases is modeled following
  the Icicle Kit reference design

 hw/riscv/microchip_pfsoc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 63cec48f43..55ce1ac7da 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -555,15 +555,29 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
                             TYPE_MICROCHIP_PFSOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
-    /* Split RAM into low and high regions using aliases to machine->ram */
+    /*
+     * Model the Icicle Kit reference design, whose four CPU-visible windows
+     * alias the same physical DDR from offset zero. With 2 GiB of DDR, they
+     * map as follows:
+     *
+     * CPU address     Attribute           Visible size   DDR range
+     * 0x0080000000    32-bit cached       1 GiB          [0, 1 GiB)
+     * 0x00c0000000    32-bit non-cached   1 GiB          [0, 1 GiB)
+     * 0x1000000000    64-bit cached       2 GiB          [0, 2 GiB)
+     * 0x1400000000    64-bit non-cached   2 GiB          [0, 2 GiB)
+     *
+     * "Low" and "high" describe the CPU address windows, not the lower and
+     * upper portions of physical DDR. Other FPGA designs can configure
+     * different physical offsets through the MSS segmentation registers.
+     */
     mem_low_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
-    mem_high_size = machine->ram_size - mem_low_size;
+    mem_high_size = machine->ram_size;
     memory_region_init_alias(mem_low, NULL,
                              "microchip.icicle.kit.ram_low", machine->ram,
                              0, mem_low_size);
     memory_region_init_alias(mem_high, NULL,
                              "microchip.icicle.kit.ram_high", machine->ram,
-                             mem_low_size, mem_high_size);
+                             0, mem_high_size);
 
     /* Register RAM */
     memory_region_add_subregion(system_memory,
-- 
2.53.0



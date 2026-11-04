Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DB606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=IatsdtdX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9Q-0002GX-H8; Wed, 04 Nov 2026 10:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9F-000261-IH; Wed, 04 Nov 2026 10:43:39 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9C-0001Gk-C9; Wed, 04 Nov 2026 10:43:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW9EsPfN+PtKzvEhSWpZSYK5GJts6m3PsCEln3Vfi7zfn+unkTepg3h0JXzYQn+pbFsDHX9PlhQLBzFdKf7E/4khyDVWbIprHhREkcLfLC4oShnXkvnwgpWN1u2L74ZQwnSqLKIpEfDujvVpRRDZgBBHV/9deBlpcDJ3XDBCGA2ArhA6erqgLn8wKGVWlIBpvvV6zKygVi8T6uL1vX5AplICk8ahQvZIoA0BX4WEbA694y4nJ4QsGIZ8zpgMpQA3ojnNT08UX+eTSZo57nmfIm/VNnv+xLZtuk9RZbK9cHZGjXXSTuMZUbJDExcwkLAEpKm+LsesjlIaqOzr+ga9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7GWXsB6jvzXGz7iz3uLNWGXzo31Keh47ap8FyPil08=;
 b=CqdVTOvN2xhCVc9bhw4I4jberUMlRQdjMMFghnEloisS4U5AGB1ZotJoURsFKBOMV00vQDUBN0qLnZ0+s6k6IZ4UasNokCvDenGMOuYpTRjYkX+dOzs829F3EwPS8RqhBvn+nvE2X4ShqWvm/AULtxlYDenUiFbtmF8bf0HGWasQxfeE6M4O6tYZoPV2+D5aq3JZs5tdyIJECrF0U4hfWcrd8/zHGLbcIE/SNej+QMXErt3Z92i5Aic4aYMGJTc3Nrm02S5QJ3+/hjHNeRdUdWMGPihOGP0cWomXRGucmKKxL28NiofwgdNQG+JilJePQ5DnrhAhSQDKWGmJY4CT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7GWXsB6jvzXGz7iz3uLNWGXzo31Keh47ap8FyPil08=;
 b=IatsdtdXp9HRxf7mSd/HFp1Qu4HzXaPANy+pbQ/A7tq+3cE3NYb1w90NwHiD9E9Kd+h9gN1m4DnIxZenyPFSvXgoXRmYz14Di0ynuAHnF8uWUvbcMbRk62K+uzECfXEkS5kG7CsdKu5DNT0MUbl6rmBEzne1ShmXorZvWHFKOtHJkMp9iJ0lrEz34ZkVRkBK3cKVG5/IBf8l5BhKRDAqf0xlySCKWAMnTyXSKzldbZloTw4H8+uwuq4pwc1VZTowhSrYJQ9FJLdMXxgQeE74EFpyctaL2mlZ9jYe+TYc1haItMW9nJHkF2XKjS+9ShiGVfCCdJIELx9C/lP7QkbQSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:03 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 20/26] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Date: Wed,  4 Nov 2026 23:41:47 +0800
Message-ID: <20261104154207.641511-21-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8660fdcd-dc3a-4fd9-82b3-08df3a8a4ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|261022105027099003|261009221227099003|261021121427099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|261021123027099003|261022075727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: t/OYwk7YYAeNhBYRapYKgbM+myyj5jIOIlvB6nY/Z0jUvKqEd+qlG9MRQlU/Slo7vC5Q2uDyX4xpPQMl68eXPRzk5mxaSqB25LisKpff4CTmO/k7Rvf+rnVAKgr2jnJe6+ZCfIKgXrdk4+VwpvOnvYkYFGvEyvYRwbetfcIttBN1TDdUcejCA+E2vcTakQT9HXnalONTEmrGLSOpMNOa4pCb4JTBsBL9MxIzUELp4IjRk2EZRjwXqqC0YHTzWkcqP1QMo87BoeJnxHkVZyvJk1B4G43yDjyTWvRZMt6GaY0jAZ4dUOsxO4aAd6d6ocnK9ymVxq/c10eGnqC0hVJ6cRmpbFVx7/w7IVcLoF3U0gARRLx1vFQW3jjioz8ldcscyR1k4237IbMOE3ooj5yATZkTxbWJPXuz122hf9jyiSBeyGLj2xRwX0/o2XzyXS066aHwN6Fi/g22A5xB9Qia5TlN82IX0v46Z9p/9MGeetiEk2pZOk2uGAAniTW0Sg+hvUBky8/lFvsGgISZOJgPYh1G6Vd9FVA1Z2NFXdhQ2kiaW48gG0RGhif+7o9/pqSrXAezQQQnFn1lXNJcEwVW9vLdmCuNUCaQA3PNx/Yt0ZqAKoZ2krr2aYv5SMVnjHkm7F/W1B59HePc/gkyN4NLWcoEZi8R794yVRTD4IBL0cQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(261022105027099003)(261009221227099003)(261021121427099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(261021123027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnoWjyksBBU3xXiPyApmkQzqdj6DzD7WwbDnwN+V1pKa0r4sqGK4wRgvA0xW?=
 =?us-ascii?Q?ZtEEbU2m3Y0Pse0cq7wavFLsdwyhvuFduutOyLBZtlRjrK6CtenMoNzrKaMD?=
 =?us-ascii?Q?YuOzEha9CvXK0h0m6javrwGCtJpQRLuDh8LOUw4Bc3c1MhSnlxqniV9zKJUg?=
 =?us-ascii?Q?a/AtuDCVU7apiUm1hs/yHCj+dBOiSGRw+lg8EXedjRJmAXv/rBgj3zU6RMdK?=
 =?us-ascii?Q?v4rXj5MPDGsiRmTkXTWDGatlytnm/5ablXtvHQ4GMk4hGRkSdbIFaZ2gtULJ?=
 =?us-ascii?Q?sNK/zgpzm0JPMiv7ZzZh7fyQvPhWumn5y2O3QLJ8brbDukn7QHPSBylY4D8M?=
 =?us-ascii?Q?UydNtf18cR7gCSERbV4m0fdt6Y1KGClSpcxnm03paNEUBRoFYXseTVjDm1WS?=
 =?us-ascii?Q?XmC9NvxKmv3kkDW3mDgxkx2plH50E8/ME7sauUZfGK4NrPI5WSERm/d6x8SJ?=
 =?us-ascii?Q?+OUQ1QbsfI44WVfcMQ7sOHNXOL0sz/InPCCLbOhGnuWNWmwwIEFiSFmfwu6b?=
 =?us-ascii?Q?iDTM4x2/FD1CD3ZU16Idokj+de+2FWb1Q8iZhpVh1enTTgJySzlYVh2P8pta?=
 =?us-ascii?Q?L0lQR0kQxOkmw/pdK0TzNvVc+tYe50m/+cd0YUpG6+Uyp2nKBrNNVIA/EDmS?=
 =?us-ascii?Q?6nM5pfqWKeVzdVoGM7ybG7NPPATodRd/fthsthyYuLxDE130qivbS66nfHSR?=
 =?us-ascii?Q?otuYRpPefw0x8XpPWVo7Oh2pdHriBAt2ZFbqSl3jO9XSNDaOOO0i6vgKtRjg?=
 =?us-ascii?Q?V2f5EQq0LRsqkRwqbLx6tZb/Z5PH4VRtZ70oC6lQtciQWcOO/r6TfEP8AoX9?=
 =?us-ascii?Q?NPvJeoXVHQVrYYn4QjbH0e15SyWzaJgPTJUgZsBp1LbZHahDJ1RA9SeKkoe3?=
 =?us-ascii?Q?1fQMkijNprgLRDAF7Yo/uY+c1a1EuQwhRhrkOHnTSe6JpJsVRI/++mI6+cXj?=
 =?us-ascii?Q?4ixUUfjHAxSbETgXGWdbLVBrAmZxNH33th1E6CehtBwUbtJ4S1hdtxdMqMoX?=
 =?us-ascii?Q?tdkPN0I5WhZqRkQFg6IIBDFi+5dSIiH9hmr1zJxZsDt4WsfFnkxO5znGl97j?=
 =?us-ascii?Q?U6GYbntRDFbVSIyyEqa21ped3S2NGt4DIgtnXznEalfW2JQMuFfJu7OyulMa?=
 =?us-ascii?Q?XU9PyhPia2PJApf8FAgRQOn502Ee0kRee1uD74gcwFlNqhaopzu2D7P0Cxo5?=
 =?us-ascii?Q?OvJwDMuGa+D/lzPlhHIW5b/tXseaH5Ph17LiOv2rZSnCqGHxjJf2XBwq0nL+?=
 =?us-ascii?Q?HdTY1StGLtMR6cViooxBsE7xYRiWmAlGLtxxYgg2fqKBSpT4zKVcYiBHlFp5?=
 =?us-ascii?Q?xN9dw2p+nnzZouwuUJk7HQokyiZz7+QlyM0fU72IZ0xFsOaS/EgD2yuSLGmb?=
 =?us-ascii?Q?DWCRUvkEmpPbW5gbs9/m+/EfdpXRGdcsLACEpiXZ2UsA5cmBWg3sSfdkfKFM?=
 =?us-ascii?Q?srrsHkzrbRUB/4BtGDZyhm02VonhqmYqYWKaniGcASVMli+LqanhHy3Tetc2?=
 =?us-ascii?Q?m54foxwIsSDhjoLpVcHqMCbh5qDKavYqYz81drBp6gchEJTgy11/P2Ub5L6i?=
 =?us-ascii?Q?sb7M8NA/MrBxJ3SA572uxJu165Engbth/cOjkTLKwq+FgxI6grU99ggkaLe9?=
 =?us-ascii?Q?bpjxqHW2TbcHunVeeEXcxmgIfVFAb1gFEP1SLjCCBHkSuwoJSm9t7n3Pm1/1?=
 =?us-ascii?Q?TVB1ngpDbpKOvVLbLSxaKIrrdgi/LNjmS5zvaZ23GICEDsrGW5eLUihW5pAu?=
 =?us-ascii?Q?/n/hMDubHDJSPUa5W9dNAnPK4J/16v4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8660fdcd-dc3a-4fd9-82b3-08df3a8a4ff4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:03.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSEY3M0vnbGvKbg30bHrhP92vnPLgchqHpwn3G4so2LpQRMvDEfspB6aOklSAgFcEQWc7KvVG4ZNFJ1OVepK9a/q+Y1zFC5Glk8kZdLPKh0=
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

The Icicle Kit has 2 GiB of RAM, and its firmware device tree
describes that fixed capacity. The model currently defaults to
1537 MiB and accepts any larger size, allowing configurations
that do not match the board.

Set the default to 2 GiB and reject every other size. Update the
documentation and L2CC qtest command line accordingly.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 docs/system/riscv/microchip-icicle-kit.rst |  4 +---
 hw/riscv/microchip_pfsoc.c                 | 15 ++++-----------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 7fdb96601a..b0ad24f174 100644
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
index 55ce1ac7da..f2a838be13 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -542,10 +542,10 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
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
@@ -757,14 +757,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
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
                               &uint32_type_info,
-- 
2.53.0



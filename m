Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057F606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=pW2LQWHf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOdA3-0003j1-8G; Wed, 04 Nov 2026 10:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9h-0002fP-5K; Wed, 04 Nov 2026 10:44:06 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9e-0001Gk-1n; Wed, 04 Nov 2026 10:44:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxNMaWFpXf2EpDmdmk9vCcOmyuspN0QX0BOxdv8ketll42CHCNyGDZ6XXZCEMZD9I12bunW9HvMlJHjAVK0NGs8TJEPIbUdqkUfjIVKM/wIdIH8RWzEGOc55ICcTckxzVpvNNIgxl1QwZEs2ZctRAA+edWrh0/v4niqZh7Z9hAtf/gC7Z1vjlfBPkUNvS2yNdAlFDrTQMM0E3+ZMJndeRc1nyOoC+zR3Kt9atOqwictGDhIDSxBcDz7MdB/NNUJ1YOn+XgDyFxCqYvuais8X7LdzsmECe3KnLnkX2Ucfcp9rTB7tSHqlQXzVDpjFeh1O69hDYxDyNNRoFY+hoWcIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqrNxcG+wqF2z8lAmIRfm/NaeEmRQx+GIR6lMwLNkAE=;
 b=Cgzw+/kfj/BnrNQf8UzkUtQYqmzvsd0k05GQDxzWW3bvhRRsPMPWYS1p5tDhLY28twLEgarQH6yDd9eOM8Pt/w899yR1f6PBSR00IER9AWm2GH++wgbJLiXDvrkc1J1jYGfMkulDgdEt+rJyJs1IOFIkKh1ecmOMlXcfTrlfkSFKz5zPemF2O+b5nqJAQQtGsmsw205sx/6c8HzHhjYh9AkrPcmWW+eMpmqoBARj+d9t/J6Mu4QjX/EgyZSj81dCNIc0tsRFDrwSX84mDHx3cC/Yx6c1Nt6WqLyW80uEu0mRywfs3ZweZFDtfKwCFFMWVQyrhzHrQO32+zK8yJwCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqrNxcG+wqF2z8lAmIRfm/NaeEmRQx+GIR6lMwLNkAE=;
 b=pW2LQWHfUPBOWjYos39n68bb59Gjo9WaK8mK53VefrMK9Z/u1ke4z9kBPEwdMLbY3lGwf8kgkisqPCGgFNw2IVEtjiil9dIw4sbleXxCSjkdRfMLyis/ntmVw1YBFAvVW9AeovgQQFOOyIMCLLAilNq2W87dJ+T0iKM2aPTXyztTbfG7jtqtdVMkSl+PEiL3Q49N6LZTwYy0aeyff4RKJwzLYYPm4cke7Z64YJF8yPc19NWXGflPpeUa914Aq43OnB+smlKR6iT8co+IhevvEsrnDH2Ndf7pUn3newey8xN0HWYLE7TNlEcubvHymdpJryxVHM3JSoj2UQ+/55HGgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:10 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:10 +0000
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
Subject: [PATCH v5 24/26] tests/functional/riscv64: Add Icicle Kit firmware
 boot test
Date: Wed,  4 Nov 2026 23:41:51 +0800
Message-ID: <20261104154207.641511-25-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e3bc89f-2ff7-482c-f984-08df3a8a545f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|260925021311599003|260925021911599003|260925022911599003|5023799004|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261022115727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: nfHNWpOKdKmcxJO2w5dJ0luy4cRzwTVpu8OW+1rakOyFbtagCRuQon6xoewZna4gfqgcjv7AzEv+Y0XAXB1Zpi09tSLtoq4/0k0n2Yj6eNeIdbvv2/aMTNhuQumCMjVY3P2VjGebT5qljiKg3d2djKOVkmBklU+EJCIqgxi0EGxBmzF4nJx3mAE6YjSZ9OarDBYq9HlhTClDvF8K/mKmP/bWOJU1gmY2J/Z+HBXCQiEMuzvMd7XV08ga0FLG5YDvgOpQjjYRoBPo0aXNXfsFzW64zCTAlTgTfQ8gjrsPT/GdWJlkkdK4kDLwvIDaxjsDoIOGX90LxoCGEkdmP1fY7B+e87KCnlzEoreFfiadHvcWxpJfGI6g3rrWAsV4L0hf+9E1PN6jCN5Qx5EvXgiVji+cOndeU3POVhdl2uUkAAgVRdrLd8yM+Cd2ZHNVW0r2eXcZ3SUOf5NYE5XAeCcUFb7ItbmcZeOI+EyXypX0bot3b6FFPG0pzmGDZ6nWYlRTG9ztzgN3UXlQFJD8VIEfYv1pcc5VA+764B5K616sfR2Kxfp0AyAF+zSLi2EjLijlZrDyIkkvGE2/xNb00azWOHVgO147AGRVoW3DTAB31+V/YxlBdV8TdNI5kYw5fe8Fqm0c7ssya2G1gvkQ3vfDIuZEMIyuSpBNQjbViT/1BDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261022115727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1g7AyXhFWcic4yqQDqXYiM8gtDCHx/6D5ez4oJtvv5E/MdjihsKwyKg9x5pM?=
 =?us-ascii?Q?qyanjCn3NJsQUGpCGMVKxj0vnDOKyDy+Lz9D9h5+ZWwKcajKLjWgFHQFuaeZ?=
 =?us-ascii?Q?jjCpjPQhLE8QsEzmhUJl2F4lgL+Am9Rcfeo/FiNjS26cVWbXMf3xcTXsfhay?=
 =?us-ascii?Q?IwcYOly0vY4ntL+/yojVO+1G/Dxeg19KI1Gno8GA5eyCmm/DfVO2bbqv91za?=
 =?us-ascii?Q?46NVLCKWmcCEqRaaWrcPPYHp4xlwijPuQekHBjhB7SRSXM7uqBRqSs+SgIP7?=
 =?us-ascii?Q?GdqAn3HLj5xFZ593NDEVqHR5uUCYGMkLC2mn7KxFkX5kOQUK2g8jyIXBcwVV?=
 =?us-ascii?Q?XIh72zNViNH1fwVLobuwCNJF8YXJRrN6Ljwyuu2uOp2Fq+htVvTD+yKiMrNq?=
 =?us-ascii?Q?pbldcZNiCknVXISa9GEZA4muc25awvZI0KhB3GRzrCJvmXfUQbL+osUMsF6M?=
 =?us-ascii?Q?EcKjOqT6Aj2STueqxQxwxOanA0z3iOCwJvAJJUE+1v6FhcgkGLjktfWSYXT8?=
 =?us-ascii?Q?9RVux8yfMGQqZRAg84eihld9aUyY8mMGr2QWpDKL83Myq3juhPGqQepgLE/O?=
 =?us-ascii?Q?/EsOaqUfM5GKLKdI56479aK6LDXMyFax8MFyjWJoJi7HL+XcB9eXn3DtZkZd?=
 =?us-ascii?Q?Qr+NHxI914pear/VDmlxkYj99tLziozyI2LLKVXQv+FqI1U9CBEUtgKEk5Li?=
 =?us-ascii?Q?e49DEU++m9OaOyRMFB7bZ0lyXMKyuMvhFDCuVnUMRHOxSqzG4mtIMcb3GRFY?=
 =?us-ascii?Q?aLqpp2nbDzQFmP/ggpNvKJckY/1gKvgbYOjl8b4zw4m3aRhNwRyfuJmqm9mV?=
 =?us-ascii?Q?Sf8LxsMH0GoKNcYuvJ59xubnmho85kS4bRfvYRIwwSxiuWdLbAum9AS3pUqk?=
 =?us-ascii?Q?KqekjBy1yLnSns5H7peLgwRmF/K5QzVg8kHOAP5a0gQ4giiOLa5HTeovpDWQ?=
 =?us-ascii?Q?b5n+tTyeDD5mFKc3fv2nhKe3r3pSN7tXmA/gPVggUqYm3XRCfEyvMXXjdZgl?=
 =?us-ascii?Q?8iFX4IcgZ/eLtY6otCSO+w4l2GDdwrysadtf+diMqKSxodyoDFYnmslOi/7u?=
 =?us-ascii?Q?kBCezoZWpd9YrfbTx1Z5efLORc8XQ73SjtYD1aYwcWc1hJbDW90oZEmOfF+y?=
 =?us-ascii?Q?9sFaUthTrpZREOFTtLxpPTmcRhqlSdai5xA3BAJFJGMB3tWMs9xvGMRnzLWk?=
 =?us-ascii?Q?jzXZ5BnCqrPVkWUQwS12gT4g1itKr9Mn7iBAsw6LQ3+o7TJyXjvRGpThMfT+?=
 =?us-ascii?Q?eCR8dmo9PM73BWv1epeFUb+PXxSDM3jGbcHvDFfzakZahZmt3AcAFF+Ggre+?=
 =?us-ascii?Q?mqEOnwy2grZKJI+wLpBU9SWFhERV4b/zhMpdIxw5U42usne7VTh5uwD7eMDj?=
 =?us-ascii?Q?mWvyVc726inFyYjdo0VK9Nw+1ZNWbT2ViQgxQ0D7/mmBCPNR0fkvgUrEXsGs?=
 =?us-ascii?Q?ikflj8MCiDTWS1qwCKpGuN1bCGnARV1/18U8cbH11QRHMCXiboTg6QEs0AGN?=
 =?us-ascii?Q?yEw0AbAARDRvdZl7QTR4zMsFVfOtTvCIrK8h9yCXf7qvISUuhRTDEHyiwq7g?=
 =?us-ascii?Q?n8aZBy7hCtrdB7CAYh7SSi43RhlhxVVOnlF2JJw/qHljrUHxb8zqg1PmpfzK?=
 =?us-ascii?Q?S2tDVisTG2nXdDaNCokUnaKT/o+8z2hWavKX+bpoy95i5BZ/74PgbMDkJwDe?=
 =?us-ascii?Q?myViu/R3nW5TqOeKjBj8KvazCoykieXSKh9m1StlbJk6Am087n/VyhVP4sXJ?=
 =?us-ascii?Q?icIC3XlJBFNZZCtzU8pGPqg5oP82AMw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3bc89f-2ff7-482c-f984-08df3a8a545f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:10.6569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdutZTvVgpwoegjmE/sJwlCGkM1/5HOS8hTrFs/9DtS0J8dQMZB4eT83F4AMWbng00c66DRlxG2Wfr53Ql2R9pP+uwFamwP3C+ZOA0JZUkM=
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add functional coverage using the v1.1.1 HSS and SD card images.

Boot HSS v2026.04.1 and U-Boot with five harts and 2 GiB of RAM. Connect
the test console to MMUART1 and let U-Boot start Linux.

The complete boot exercises the SDHCI controller in the DMA modes
used at each stage. HSS uses Version 4 64-bit SDMA to load U-Boot.
U-Boot uses ADMA2-64 to read the boot script and the large FIT
image. Linux then selects 64-bit ADMA for SD card and rootfs I/O.

Check the machine identity, kernel ADMA initialization, root
filesystem mount, and login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

---

(no changes since v4)

Changes in v4:
- Use the v1.1.1 test images with HSS v2026.04.1
- Add the execution bit to the python script

 MAINTAINERS                                   |  1 +
 tests/functional/riscv64/meson.build          |  2 +
 .../riscv64/test_microchip_icicle_kit.py      | 56 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100755 tests/functional/riscv64/test_microchip_icicle_kit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a8343e3d55..6c7437f8a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1834,6 +1834,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
+F: tests/functional/riscv64/test_microchip_icicle_kit.py
 F: tests/qtest/mchp_pfsoc_rtc_test.c
 
 Shakti C class SoC
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 211ea9acfc..231a1e49f6 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -3,6 +3,7 @@
 test_riscv64_timeouts = {
   'boston' : 120,
   'k230' : 120,
+  'microchip_icicle_kit' : 180,
   'server_ref' : 120,
   'tuxrun' : 120,
 }
@@ -16,6 +17,7 @@ tests_riscv64_system_thorough = [
   'endianness',
   'boston',
   'k230',
+  'microchip_icicle_kit',
   'server_ref',
   'sifive_u',
   'tt_atlantis',
diff --git a/tests/functional/riscv64/test_microchip_icicle_kit.py b/tests/functional/riscv64/test_microchip_icicle_kit.py
new file mode 100755
index 0000000000..ee627a87a8
--- /dev/null
+++ b/tests/functional/riscv64/test_microchip_icicle_kit.py
@@ -0,0 +1,56 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots HSS, U-Boot, and Linux on an Icicle Kit.
+#
+# Copyright (c) 2026 Process Mission
+#
+# Author:
+#   Bin Meng <bin.meng@processmission.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest, skipIfMissingCommands
+
+
+class MicrochipIcicleKitMachine(LinuxKernelTest):
+
+    ASSET_IMAGES = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.1.1/'
+         'riscv64-microchip-icicle-kit-v1.1.1.tar.zst'),
+        '226e4322e5ec53513eccdf16e4e967cdef7d57a0ba19431470ca68b883457538')
+
+    @skipIfMissingCommands('zstd')
+    def test_microchip_icicle_kit_boot(self):
+        self.set_machine('microchip-icicle-kit')
+
+        archive_path = self.uncompress(
+            self.ASSET_IMAGES,
+            target='microchip_icicle_kit_images.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+        firmware_path = self.scratch_file('images', 'hss.bin')
+        sdcard_path = self.scratch_file('images', 'sdcard.img')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args(
+            '-smp', '5',
+            '-m', '2G',
+            '-display', 'none',
+            '-bios', firmware_path,
+            '-snapshot',
+            '-drive', f'file={sdcard_path},format=raw,if=sd,index=0',
+            '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot ')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern(
+            'Machine model: Microchip PolarFire-SoC Icicle Kit')
+        self.wait_for_console_pattern('using ADMA 64-bit')
+        self.wait_for_console_pattern('VFS: Mounted root')
+        self.wait_for_console_pattern('mpfs_icicle login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0



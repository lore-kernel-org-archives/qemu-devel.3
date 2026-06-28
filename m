Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A08CC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdo1S-0004Dt-Ee; Sun, 28 Jun 2026 07:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdo1L-0004DU-1d; Sun, 28 Jun 2026 07:49:56 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdo1J-0002FB-AA; Sun, 28 Jun 2026 07:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XusvkmqK2TgzTjyMldprSC5yUiYqMZzktLoCjghKmhzlauxJSpi3soZN+e+5B0AtxvXrNu30JjtrFM+8psma50hLP27UqvWDF+pZlr+/x/T6bWzs9x90tvPaoZEtUrvYXudfEGx+aeQAqwz8qc9zIBXG7XYLa2JZRzm1e9RU+cMYe7DPB1xRiVqevXsA+H2ew/jjaH5PrW6SkHhnEB+RIgSIMKFZsa4KHDoyQiBzD8LDBYSEWoVT76gR797x3Qi+8qs16gF5/RonC6mgi2L8GQYsl56Bob2RQi2KdfK0fm7XQJpuI2rwR3vzmQZK3K2tSiw6Tcn5wm5extL/6TS/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNBfjqk9kAAtTL+Uj89JQ3UWzPpvM9/+QH51/uYA9bk=;
 b=csTZQLSy0xXOc4j4uqv8MF6wHEvagaqIqTKmiyERujkfXw+01rx+7s1OXv041YafQFwmN+zpljvKmDHkFTswvh0JFHYzQP/o2Um8QD6d8oMLHCl2/+U9jLOjdYEKFm/jWv+XGRg0IzcqjLsqFi6IIaskcxPMI9R1MKajxsO6e8d7W2tJytt9DZdIt16Or0CXeyg++G9zAYgNe/Yxo3SASgDoPBG15aOiImYiWiYx+MMx9DRphVMi8t0RyJCpdXRuDaB/e8CEOFMSsFvg0GQt6QDgdlH8q1bvXYJOaEib2M1C7QBvnTygWSzBnYFaIoMvnlyTHqG3EPlb9KdG9OnncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNBfjqk9kAAtTL+Uj89JQ3UWzPpvM9/+QH51/uYA9bk=;
 b=XWFr9E9erxvC9+XPpXY0tmZ+HvVJyGYHQQxSoohbzpcvyEkRIChBypDD9eI1SJfb9HvNIzqVyYB5/HAymhof7TTiNLvPQnmtQVLKSQrei73ClmA1rwQ27NthB91rv9bq3BcXIJL662+kRLJTcNeGfYFnZOf6mV5dYfHc2SfaEmiNnVZFZJHmoWNZykcF6w79ebxSnyuZjkDJywkBK7fSUSFBfzGsYCPtd6AR9s+OEyehxwtSZI4ExwBTi+U4RhVE/Cx4rvC+K0dbOu9o3gQtFcbuvlX7TO0+jKRNztwoG8PCVcwiH/JdgRHsOl66DlVLJDjFBiZbOX2qHbhZaXmw6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB9158.apcprd02.prod.outlook.com (2603:1096:101:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 11:49:43 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 11:49:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH] docs/system/arm: Document Zynq Buildroot boot
Date: Sun, 28 Jun 2026 19:49:25 +0800
Message-Id: <20260628114925.418293-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0164.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::16) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d0e14c-8b1c-4d59-55ae-08ded50b5758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|366016|23010399003|586017|376014|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 5+V/OTNaAOFs16r2SHtgvnKSr7kJjHojl4ZpOamuE0TDOr+nOBqGnDeFGaFz+ieGUAnXxNyYGX3O3iFXwytgg79HUpfGuudjkLUHtXGzzttlcuFBE7FhRxoKtdSCx8tJyAXi1Y/7V3eARZVqKL/azIl0jFYwpX6DPBK4ByydTaud2NqgT9uOdFzhouAaFbZ7CDIhaJav8a4HA5xel82gjFv+sixfjAHIHfdZbIF7bTGasz0KUMkWBGp68RBYOElVN/Sr8ox+oAMsIe6kyA37mvHMhBdjcqy+Q0qu0mdG0WHopiSYX+5fVHbR5vYDpEaVzyDBadRrmGadidcT9WJH22xmSD8ZGaB3dcWEFLWzPqL2mC85l5kOuhvDBHwoR5YW0oZ7Lb0zdHn7VZVOQO8bkUzLeAQt77eTZy0uLU4AgV6gwm4dzJlKS4hwCb5OE8Fv9Sb1zK9C9KbCeCET9SxWlG+73QLBKdEw7vU3OvV8Vizd5UrF91a3La1Isw6Pj2HxoTl69tZnVkObruhVbqbW2o6VlwhrVGK6WbO4q2PXeKZTh1aDvNV0IYQcIn0KDJR0vwp+pS8wZOE/CBTSbKGVDcx6GFRluGeDHVpeOfFgG4NTMxQVJLnBGRTlaIu1z9qn75ZXj3CseQvYbAz4x4Dt6m/of7SpZSdN1xMBTxRt5B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(366016)(23010399003)(586017)(376014)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Tm4GTSS/atsqK6nj9VdJU9dg/39Oy2a5f7faroU2rY9oqW/pbjIfdBixLoU?=
 =?us-ascii?Q?0WMOUrJopkG4Q9wiTdHf7RANvUWRbmtczXQ9N9JjPCNW9yPeB9Z7q5l4rSqi?=
 =?us-ascii?Q?HJYvxSwb79q/mW/d7C6wBUL+D9NhSHZ5nc8qWVhuIABPLosqcrIn4l2vDJcU?=
 =?us-ascii?Q?eF8h+XR0PWnA436reeYKEKrsPf/9m5D6fkDNonzDP3J088XHzXBaLIvXzBVE?=
 =?us-ascii?Q?4gjLCR42Bl0b0toCrSBlmliYC0ms0dDsSrKUyEhUGMkxi5XkbmmDF5qY3oRh?=
 =?us-ascii?Q?PoDWKZnKTWVS2Ny9R5BLWXhzTPEFRnON1+6GUiBYkmXNuXDaI/CjhY96X5RO?=
 =?us-ascii?Q?xoSRdMVHEvRkd8aHt5SELDdyUBs4Pg5pLfR848DuN/ZSaq/2sxk+Ygfae7Bm?=
 =?us-ascii?Q?jFV7OMPPz7R5/02ufqYlxAZjc8GRNgL+Q38mxYoyHUJXQgAASGhIHaz7Qv8i?=
 =?us-ascii?Q?kmhkLkaIDwCicHN5ArkZnHcmofIP3sKsccZNluPlPnGSzMwdH5wEo5iGWJMH?=
 =?us-ascii?Q?KtSe9FBzjyCroL8KNFfMQh12Mi7pi5Ro0DkSmGSPEwB+v9TRRGydDLa+vNx6?=
 =?us-ascii?Q?GxUQeZ8FWPV/60Z4jphQ5zEyfg9Uf9DtYcRSKaEOAs3ltOX1VNEDQq9aJISw?=
 =?us-ascii?Q?P9lkH7QyUrrEtF9LBakvRcQKNixD92wxYO39ibUymR3BY6cP8Kyn10NetAYU?=
 =?us-ascii?Q?PFCzledLDooXGOPtdRztw5ixamM+7TE3y3uVE+GErfB2V9yp6sdlcuI/JtEy?=
 =?us-ascii?Q?XzSkS32wo3/3kFHrJBhBCu4IoTaXAS8xE7k2Gh5Di44zGzhGkVWmCMCT4I1Y?=
 =?us-ascii?Q?srsqS8He0RoUPGRjLDLkUOfNL4erun6jZe0Q/xwNZG4Ynz1/1xb8Eb/Gsk2M?=
 =?us-ascii?Q?jBqEsslnaTYBWTICfUzkpUp1Fq0H0Ht6VfEfvzq8H1HmqvjolGrKUDcQGBpB?=
 =?us-ascii?Q?B0TheYqfjlvZ1aDzJj83BXCy/AJ5s/3Oxx4DbKvCKlZU3+1n9bbHJzuJ4UYw?=
 =?us-ascii?Q?D/A+u69XOAFp4GZ2PrRqIUmDO6THmURT0cdojt+Dw5Rt+L58MISkFHjcl3Kr?=
 =?us-ascii?Q?LI/5qXA0t+dellqODN/StPJsEzAd0pJyCv13cCGdI+e2zmLJiLIo9eDC/EFl?=
 =?us-ascii?Q?DDtoleR5vC5M3kUGkHCGAby1O+wQSqsTVj89ppXLPm4nboKj5saVvkkRqGKB?=
 =?us-ascii?Q?D9yeb4mkFgByT82HOFHp6ynmjBh+Fo+iJyZwHPHMNxQhwzb/f+1cI15kVo2O?=
 =?us-ascii?Q?BxBEvIlaQDnKxO1l1qVtu4sY0YuEwzxV3Cd6yMG5ct0cla/EWAHIZOWV9dvY?=
 =?us-ascii?Q?1mmefO/GIz6giUIEUB8Y93dBl3rkkYVSHxjTnvaiNGV94avAZSOv8pj5jIgx?=
 =?us-ascii?Q?YQx3BhtNiTzxIW2W6zGkkubKiD4Dy4w/DmA8Dwe+RiTNn3JmcgywriPjydg4?=
 =?us-ascii?Q?qaaqfB9lMWds0p9bIr1IGMy1hP26mDF8uivxWagI+SAhG5muPPnLS176d2H9?=
 =?us-ascii?Q?4osQHIhngYAb0P0UOe0F0q+hFJryAgfwWlMi2QYvDN0Oc7x8r06ulZOW+QIR?=
 =?us-ascii?Q?7ZGYBxcL73gjaVn9L+BDB9BxvgXQMi2uGTnZc6deQ+9l6mIDUY/mItK/690O?=
 =?us-ascii?Q?LWqR0EP5m1uqQGjnyZ+XnmTV4yMBcBGitYdTPsc1qg8dub0jzbpukmb2HDcS?=
 =?us-ascii?Q?L42mt2KSgq/xg4gXkiZ79iow3qVjvVIa9KF45n+FeMmxaFpAyAElkP/7ghIS?=
 =?us-ascii?Q?7FhhDQnqnY+obC8ETAr7P8+obaBX81A=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d0e14c-8b1c-4d59-55ae-08ded50b5758
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 11:49:42.2754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5SouhXArSSdy6bykPV03XH/J+HURsPMHmoI/MjLMZY8DiXs6BbrYJtE5oW1rmYk6dgfBFCaumRnunENg7pHcfGbtbkkwo+Hi01MDVFd4hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9158
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

The Zynq board documentation only showed a generic direct kernel
boot command.

Add Buildroot ZC702 commands for booting through U-Boot proper
with the generic loader and for direct Linux boot from the
generated SD image.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 docs/system/arm/xlnx-zynq.rst | 54 ++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
index aa37df2926..95538cd32f 100644
--- a/docs/system/arm/xlnx-zynq.rst
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -30,16 +30,56 @@ The QEMU xilinx-zynq-a9 board supports the following devices:
 - DDR Memory
 - USB 2.0 x2
 
-Running
-"""""""
-Direct Linux boot of a generic Arm upstream Linux kernel:
+Running Buildroot ZC702 Images
+""""""""""""""""""""""""""""""
+
+Buildroot has a ZC702 defconfig. Buildroot 2026.05 release is tested at the
+time of writing. From the Buildroot source tree:
+
+.. code-block:: bash
+
+  $ make zynq_zc702_defconfig
+  $ make
+
+The generated files are in ``output/images/``. The examples below use:
+
+ * ``u-boot.bin``
+ * ``uImage``
+ * ``sdcard.img``
+
+QEMU's SD card model requires a power-of-two image size. Work on a copy
+of the Buildroot SD image and resize the copy, not the original output:
+
+.. code-block:: bash
+
+  $ cp output/images/sdcard.img sdcard-qemu.img
+  $ qemu-img resize -f raw sdcard-qemu.img 128M
+
+To boot through the U-Boot image generated by Buildroot, use the generic
+loader device to place the raw ``u-boot.bin`` at the address it was linked
+for and start the CPU there.  The ``zynq_zc702_defconfig`` U-Boot image is
+U-Boot proper, not a Zynq boot ROM image, and is linked at ``0x04000000``:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
+      -machine boot-mode=sd \
+      -display none -serial null -serial mon:stdio \
+      -device loader,file=output/images/u-boot.bin,addr=0x04000000,cpu-num=0 \
+      -drive file=sdcard-qemu.img,if=sd,format=raw
+
+Direct Linux boot of the generated Buildroot image is also supported. The Zynq
+ZC702 DTB is generated by Buildroot and is located in
+``output/images/zynq-zc702.dtb``. The kernel image is generated as a uImage:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
-        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
-        -display none  -m 1024 \
-        -initrd rootfs.cpio.gz -kernel zImage
+  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
+      -display none -serial null -serial mon:stdio \
+      -kernel output/images/uImage \
+      -dtb output/images/zynq-zc702.dtb \
+      -append "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw rootwait" \
+      -drive file=sdcard-qemu.img,if=sd,format=raw
 
 For configuring the boot-mode provide the following on the command line:
 
-- 
2.34.1



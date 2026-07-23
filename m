Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF1C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDl-00056F-4S; Thu, 23 Jul 2026 11:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDS-0004VR-Cd; Thu, 23 Jul 2026 11:20:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDP-00084Z-0H; Thu, 23 Jul 2026 11:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDrqu3AB2zJOr6HS0/2sK80jT1pmB58MU7cirXvWgY7WW4jLMvdS1fBAPvL78dOrxOfPt+X4UkPgDisnetM9fPnlkuXPV6FLEHsoEo9KfiklXzpPJX8Rr4+im/PApvtHnv1aX5g+u9qWsksDw7wwH8KIkiezE3B+Sm9cVup16CiuveoAwqL2mUNCOkO35l+dexOtyBYwYGiumFg1E5kWF/kKfAWLTnsqkxvCZ4Ew074ljlMHG0Rq8hYgzVeeTeS6BLfxZ6kDAnvqLO4dTGAcyS1+cCnT05kCpKdmDEPYM7HqoXoILTaJMgBMZAFBW85TJ8BYzyiMiH0ZT/w68AwPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHkXJTsS6CKeKU6sx3voHDxoOVQbTgDL32LbiiK2H2E=;
 b=tc0v4tFNM07q6t7BetSW99tDfTL/8y8aLPEkeHAmNsNNtOosc+r2crGraH5hwPoGOiZW64rWlTBZibGiCI7wKJCvQooT5kLt7qDzFfVMatwk4flthVpntTMaUA7FbRYshy74ZEDlDEB5qgljOXCzFBOgDa1nAWe//1s1JRuQp9zl5X4S1XL8yoXKy8tobZkjV5jvyOBRrXN7MqRhdYZ42Wh+DbInac36QNKjOjEslgHm4S7OJa+SNWOSjuEinjnaXGKcwFKGbyu6qFQf2vkYhGHBxoCL8OduBc+kwbqlCorMK1gQGcGR4zrlI9AOIxMOnMCP0XsJRIPagL9IJf0wEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHkXJTsS6CKeKU6sx3voHDxoOVQbTgDL32LbiiK2H2E=;
 b=i+ciWbcx5iITM1w8mH7pURDPOxCdQE8nN98NPWYI5ieJsuqkFc3XDKCwhUWBJAQcmm5Ue3zfRl3DZK2zpA/gUW915ySievcCGGIJSCiGWREEnxpKt4VWm4NMleWGI5IQjlgrqfmylmCa7OUhUHFZcMbvxcPS2Bce5Um/ZJfooE7WWqEkfXRAJ9OPskdM1QSGzWU135qE2zCIfDoftEsrZs8IGxQzOj1Pn6ItAItxe/P/mja0OeXoyzBiddG31iOssBJSy56fb0LePco4P+rFedSxWXzKTQGDvWR6E/409FgCFYPy3YbkIPTRn6/ZW5iEgxWqJJUAkTcifNBT4P/r7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:46 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 23/26] docs/system/riscv: Document Icicle Kit HSS boot
Date: Thu, 23 Jul 2026 23:18:50 +0800
Message-Id: <20260723151853.2143177-24-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 6430c38e-fef5-4edb-df09-08dee8cdd410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|5023799004|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: RkZMrHXtwtSnDxe9zVugalo4euMLioGoFzAbviV5MpRj0lODIW5lhGR6LzSfHSwuwIkKnaMpzAFvO33cdtDruvxMuqExpx720wsocRgcLndggwzCl640Ph3Gb45z2C3jjZbCceSLqtzAItYz/wodUzZ9NU1gI485xeTHMOIdbv220dY+xcYGsgRPsN/yehLYQi+isrf3rCMNciWAzqiVhYZcRwvf3y/vySl6DHdnRfG9pkXMrsSihWkfwHUShtZVjqlzY8LBIGHoTStUGQgd23CPfxR0j5ghpqFapKrzQmL5I2OorJcRJF9qRCyo2ych5zg95gCgrn1Kofz3rooKTGqTJisQU1Q7yhf7lSVww/55dhxqdlDsyUWDdR7ShILrvfEsd38HMyQPUearqoikuJXk1MzpycVNozyIw7gjyaDE+jq9nsE4t4FUA1dTnsLetLaiVm4YvMQkt257owYf376QEju6jsBurtskxfPf//kq5A3gfyEYj4OxgnxzDwGJfV+D0wvYmKY0aM4iGu+lBi4vcIyKo6ApTEKP7CWI2LmbLn8vrQcMC+gvL0ZesyFJ3CjLdjAMzR0WHyjPkKcPezL/BjD9Or0A5ZGJaBq6NWW5G2M0KycSKTq8Ud3G0mT7uV0n0JCFTsgHcC3c8vbV3BfF/RqmM/aBPh7h6i4IDtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(5023799004)(10067099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WB8o+Klil6QmMLc9iAmBtK1wc4OkaCvZJOy7niOejaLpcrr7PKj0s3COPTH2?=
 =?us-ascii?Q?y6o3E2owzKeNSZxmCiJBpiJjPZAP/KJ0XU/t1kZf8zjV0HiSp4cw+yEdH9Ra?=
 =?us-ascii?Q?nk5bwfvnZt18c7iI4i6ZdzSax3QMmgBRJLFje64I3jv1RM5GROiKQFYsxQr7?=
 =?us-ascii?Q?V8U/EDM8EXKOxvn8J9nGN/+cvHYM3xXncr8Pz0TcaxUwp8YxSH32rPqkbCqF?=
 =?us-ascii?Q?yJ72vUJpH9NQU5r27Cl4bpnZ9EHzy0QppgnRbYhBfnnOYmK9Ngsbl5h7Lw3F?=
 =?us-ascii?Q?SaDpivbYykFO6QckV6B4YXGVyHqoVVIIzzNrhCcc492Ii60tTsxn6D964Fji?=
 =?us-ascii?Q?Yv4yi7/m7I5rlWLHEzoDnzG4QM1IQl4TdZSU4lSmoDwCW0v43gB2s6bxyA5J?=
 =?us-ascii?Q?zzstKQPZN68xGNZsSg4t34nxexyKDWzOBaKXJOM67S83tFRfxsxi+4ITSBTm?=
 =?us-ascii?Q?LTstKTcSTpX/8jeP44DX6AyGjaoGmIJDeFRHNmKRWqWo501bmg4UBXpsHDM7?=
 =?us-ascii?Q?NFTVswGxnqz4OiBiH6+AWbJpcY/XS4MvAA+nhUciwFSvFAfLdtuE9KJrn05E?=
 =?us-ascii?Q?LGOKScJPmt/HxCPvYk0/iQiQTDiv2Ca3rNh/xa0JrRiEG2IHYfmSloLlpQnY?=
 =?us-ascii?Q?lzCTeWM3CN4dMfkgTqI3alOdkJM3ZwX0YBCx9DFgcffIapBDHpQ5TsoAc0Mj?=
 =?us-ascii?Q?HeJlNaRA7Zs6EuKYJ7TSfRmU51fRqL7y0/+u9hjg96SYmgp9fYqmK4MXtihR?=
 =?us-ascii?Q?CPAq/0idufmXvGBNs3W0ej3pkFTNG/FpUqZVFWMiDEuWWY4mCp4/xVm8CRtI?=
 =?us-ascii?Q?0ySk5Gbn6FIK9FJTTP9ek8On3NIsxkwuqJhbRpEWmQNuHs8b2r2iPtwuMOs3?=
 =?us-ascii?Q?y5IITlm8Tb9YVESGbrDCTRnV9ZJ/qmcC7rjjdsAPI9jPkq/ae6eOc/iD4GTu?=
 =?us-ascii?Q?/WUm0vdnw4LCHV95tfs363mrvvjY/MUvfUctJpgG3JzdlCkcOHjcsbhqGb9v?=
 =?us-ascii?Q?jhtAIzM2w4r+X0PPOsNC7PGD23sjiVDwmg876zzGrBNT7GRYPlB6KBg4utq2?=
 =?us-ascii?Q?NfCLleEsMSNo7qbdvFRnIej0AdpjAGgHIECQqCfMqkyK9cptrI7Y2n1O7HfD?=
 =?us-ascii?Q?XUaH0EBoCXVmHDBnvHDZDg/deY1NXMWk6fZH4HG+pIzQyoNk+6s1p4AORySr?=
 =?us-ascii?Q?U5nH2+h5Tro8Wtf4SuG7Va2hv1nt4LLjSJ7SJBS89hmIJ2v4L6WDNsMVzFVw?=
 =?us-ascii?Q?KdemM7U4yFMzNUht+f7Qrn/nZ4R0hiA1HC7tyiIk+pqKcvkNtT+a6Lm448+S?=
 =?us-ascii?Q?nhjKIMN+O255nRQM808JyeJKnEt3xY/+O93OkR+Zq/zTKHNV8gLfjWke8c4a?=
 =?us-ascii?Q?8FCGIpSgL0ycB4mp7hhNlII88jLlx7SkN++qd4Shzy6hKM6JMSkEfZCpIsj1?=
 =?us-ascii?Q?oPogfPJ7rH/ZmZC/s1W99Xgo65QX2Elb/UnuFd2fDVmQD3T5StpNLNCMW/3i?=
 =?us-ascii?Q?WqUCrbEGNjrbIiB/DSWXOCnX8nSKFmPxqWCmKx7GOSn86R5tZtmSFUIDx6t5?=
 =?us-ascii?Q?2r8LQH5oi+UGGooonamtGA8107FWuhNAe9gZaFaPg5GsTagaMaH/hLia6e8v?=
 =?us-ascii?Q?iHMeJ9/Th6Wl94zxJaL44oYS7sduWgdO318NrdchU83MPQQ7U0iw9UbhYUC5?=
 =?us-ascii?Q?Ft+kelUa7A/ZoNnBC1ZAR6He8I0lEKAKHAZZGi+U1id3eSjVGdesB5E1aK+y?=
 =?us-ascii?Q?ehvUirAGkf7y8Vy/PDPCwp5SgTOqFIM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6430c38e-fef5-4edb-df09-08dee8cdd410
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:45.8643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+n/etsPnoeONrHIqQuLUwTYx0xDKEDj61hVOkPZM5Mx6NmPizhxfwNpS0witS0GOhJgvAezAO/QVPvcefz5TXjthqjhOqeS+5jXofEDdmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With all previous changes, the Icicle Kit model is now able to boot
HSS v2024.06 through a Buildroot 2026.05 SD image to U-Boot and Linux.

Document the tested source versions and exact commands to build HSS
and Buildroot. Include the sparse resize and GPT relocation steps
needed to make the generated SD image usable by QEMU.

Also describe the RAM and serial setup, boot stages, and remaining
model limitations.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 docs/system/riscv/microchip-icicle-kit.rst | 101 +++++++++++++++++++--
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 38352cc62b..eeb4ff938c 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -19,12 +19,15 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 4 U54 cores
 * Core Level Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
-* L2 Loosely Integrated Memory (L2-LIM)
+* Loosely Integrated Memory (L2-LIM)
+* L2 cache controller (L2CC)
 * DDR memory controller
+* System controller and system services mailbox
 * 5 MMUARTs
 * 1 DMA controller
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
+* 1 Real-Time Clock
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
 The machine always exposes all five harts. Other CPU counts are rejected.
@@ -101,10 +104,96 @@ CAVEATS:
 Running HSS
 -----------
 
-The machine ``microchip-icicle-kit`` used to run the Hart Software Services
-(HSS_), however, the HSS development progressed and the QEMU machine
-implementation lacks behind.  Currently, running the HSS no longer works.
-There is missing support in the clock and memory controller devices.  In
-particular, reading from the SD card does not work.
+The ``microchip-icicle-kit`` machine can boot the Hart Software Services
+(HSS_), which then loads an HSS payload containing U-Boot from an SD card.
+The following flow was tested with HSS v2024.06 and Buildroot 2026.05.
+
+Configure HSS for the ``mpfs-icicle-kit-es`` board using its default
+configuration. QEMU provides the software-visible registers and deterministic
+status consumed by the HSS v2024.06 DDR initialization and training flow;
+it does not model the electrical properties of DDR training. HSS requires
+the RISC-V bare-metal toolchain supplied by Microchip SoftConsole to be
+available in ``PATH``.  Build the tested HSS version with:
+
+.. code-block:: bash
+
+  $ git clone https://github.com/polarfire-soc/hart-software-services.git
+  $ cd hart-software-services
+  $ git checkout v2024.06
+  $ make BOARD=mpfs-icicle-kit-es defconfig
+  $ make -j$(nproc) BOARD=mpfs-icicle-kit-es
+
+The HSS build creates both the raw wrapper and an eNVM programming image.  QEMU
+needs the complete eNVM image, including the 256-byte boot header added by the
+Microchip boot mode programmer. Convert the generated Intel HEX file to a raw
+binary image, for example:
+
+.. code-block:: bash
+
+  $ riscv64-unknown-elf-objcopy -I ihex -O binary \
+      build/hss-envm-wrapper.mpfs-icicle-kit-es.hex build/hss.bin
+
+Do not pass ``build/hss-envm-wrapper.bin`` directly to QEMU. That file starts
+at eNVM offset 0x100 and does not contain the boot header with the image size
+and per-hart reset vectors.
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make microchip_mpfs_icicle_defconfig
+  $ make
+
+This produces ``output/images/sdcard.img`` with three GPT partitions:
+
+* An HSS ``payload.bin`` containing U-Boot.
+* A FAT partition containing ``boot.scr`` and the kernel FIT image.
+* An ext4 Linux root filesystem.
+
+The QEMU SD card model requires a power-of-two image size. Make a sparse
+4 GiB working copy and relocate its backup GPT to the new end of the image:
+
+.. code-block:: bash
+
+  $ cp --reflink=auto output/images/sdcard.img sdcard.img
+  $ truncate -s 4G sdcard.img
+  $ sgdisk -e sdcard.img
+  $ sgdisk -v sdcard.img
+
+The Icicle Kit firmware device tree in the FIT image describes 2 GiB of RAM,
+matching the machine's fixed RAM size. The command below keeps ``-m 2G``
+explicit.  Attach the image as an SD card and route both board serial ports:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+      -M microchip-icicle-kit -smp 5 -m 2G \
+      -bios path/to/hss/build/hss.bin \
+      -drive if=sd,file=path/to/sdcard.img,format=raw \
+      -display none \
+      -serial file:hss.log \
+      -serial stdio \
+      -no-reboot
+
+HSS writes to MMUART0, which the command records in ``hss.log``. U-Boot and
+Linux use MMUART1, which remains connected to the terminal. A successful
+boot proceeds through HSS payload loading, U-Boot, the Linux kernel, and the
+login prompt from the root filesystem on the third partition.
+
+Known limitations
+-----------------
+
+* The tested HSS v2024.06 flow contains 2 separate multi-hart startup races
+  issues which is still not fixed as of the latest v2026.04 release. A boot
+  may therefore stall at the very beginning or after successful DDR training
+  during the OpenSBI/U-Boot handoff.
+* The SD card model requires the raw image size to be a power of two. Keep
+  the backup GPT header at the end when resizing the image.
+* The machine does not generate an Icicle Kit device tree. Firmware boot must
+  provide one in its payload or FIT image; direct kernel boot must use
+  ``-dtb`` as described above.
 
 .. _HSS: https://github.com/polarfire-soc/hart-software-services
-- 
2.34.1



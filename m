Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FB5C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKH-0006NE-OM; Fri, 04 Sep 2026 11:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKE-000694-CY; Fri, 04 Sep 2026 11:59:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKB-0004ae-Cc; Fri, 04 Sep 2026 11:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMO3iiheF6HETtzUMa0AqajVJ7TdjDV8NebmS/SY+ayaBhLbVPyyBLG8Ws3hMcs9dKstKmPb9KhQqWJbvjOh1E+EPVXaH6b7qO3Zs5kYNOcuvstmjwRPayVfujQf+cTQq0cqIN1Wiq2TnaKAIDS81TFVHj4JK1vGSVGTacsSUH4RpRGZtby95hsJ8HYQeVpmXdCSUEZ1WftEbuJ5xAh9US2kpmIR9cNmqM34AVK/X34zMAgdHkFDUGgSzolDQjMlL1FFUmp/CJOvgnfwj3wkgcf5sevfCJ+nyUKK+gueeXqz7NKPKuYvR5Ai91iK/0XeDir/ylEN0+szj0MkPSF0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9DlW+mhkz9wRxX08rVtM8n4IvfQ8P6qcF0rkrjVNUs=;
 b=tqeZ03MVldjX9lG/ACsi8RfoerJDgZuacZ+/SMYaxM/aSZsmJEGiYeooXwa2mV+QrbW5wmChmMAbeArTWdko5c+xU6ahWlYDMV9QBXBCG/oD9dMattrpStnbMYQgMQj3ERxCNQAaLpTgWCt04plWOMf1jDbOs6BbPWnNK83zTBjzvN37mh8icb4oNlSZoLBELmHUTJmpjn6XWCRwzHUzh4Bz9rv/t7jKG9EnCvfGeC+ieAIOCMnO7lXY4SfkQV/h5S03pzyir2IXrwrKTUEzmxe6P24/E8TpfaV/l/+mkbV81A8ESobfuyAm4HDJ55Ngx8N9BZd+hpovH+UX0ZktnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9DlW+mhkz9wRxX08rVtM8n4IvfQ8P6qcF0rkrjVNUs=;
 b=sZ/Fs0BDxlEKmd7gZdLLqJTG0ehB3P31EwNV0I3upOVTn/1/GteozRwmiI8X05mWz1VC4CFNt3iFm0Ls+316vJp9qTF7u2HT3bZLrYgdiEeRHBfQPJfw8OexlEgz4Nu7KaNTrI98G3kvjnpFGrxacCNT/UuwPvKv2mdhP1XwInzU3FozOkYeSRB8P0dSXuwGGTvyIWu/0f4CcSqc2MS6vNo7UQRGDlI4j4T/NiCsNFbiePtOfnmd1gifUA+Z25o1ZJ3dRLz3nBHS3Bvku0lH9vciU4/D/6JEzMSN6Pj0973Ge0ap80qtDhdYvt7kQ5ZD745JM51VinSWdg0Li2UQyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:11 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 20/24] docs/system/riscv: Document Icicle Kit HSS boot
Date: Fri,  4 Sep 2026 23:57:39 +0800
Message-ID: <20260904155758.3833179-21-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 285e121f-219b-4905-44f1-08df0a9d759a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|6133799003|10067099003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Kqu1rKtMYTr+uk5DYPgtnFjx9wqcJQ9NkhS+lUU4YbDefb6s8z+QFIfOzervNJjRNneXz3pF+lPKTNdFCTfMPKQSXnF3EQpWnJvZg3m+zXYau+//QFfwG+uCC19G2oiw5GtKhYi/xfgHzYTcCsmYtdh8GIHF+cbm2CTjXylusX4rEAYjDw63lZmHx3tepB1PJvJ5hncWu5E1McUF/amj2TotofhIfnrmMf930QT4a3ZTuo2fcBVdCcy9UWe4OLSiJv66bVZK8tKztFJZMGmgj7vHOECmwvwjdedLXT+DmS4OYmR2xK7ND7wTp86JAFEBkNExurpJCVUdoCEKCMFkMOk9d+6ErjTMaCDNkmPMFVNqsvVR2yEsbVInV5EyKgZD64qfZD3P0smkQBxoP6GVMCABBbQ+HLqTzlOzyXEpNEwcoH3IfEskhFh1v+WkIabHN1VDNE7ppXCPwPbLYHPuCmuLuj4r4zsVRN9KFRz0f6UGCtjAFFYC4KWWNRA7+GUvmzAIksFmBG5e2JJfzMBj3fCbPxpNEEiyIMCTXgnuV+M7h88ndnwaVhTH+bBzcraWrVL/Vm+mnUPNiW7vFQYQge2oTgjzDVb/fgkWecwsI4nK4jd7a/rv/AIuvnNxiCboPGf1H+Qxaa9/MOovU4zOrbnjdONwrv6qWBVYEuR+GJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4l/unHDdFWsXAdttwDqMyCo2P+gR1ul+TDyNmq0eACOKx+/89XULCVTFSFP?=
 =?us-ascii?Q?VhZYYJFXPKlHpeZoWM/CgMQGfdkR7YuN/dHZmRU7mwl2I/xjtuDghWV6bpDt?=
 =?us-ascii?Q?RcUWq+ZqZNIHrUz4W6lZPaXSNDldDznHmOgBFvNSFtrQjl/iH5Rrrc45r1tJ?=
 =?us-ascii?Q?24FYI95TubVKaLIDXRKVOmRAfw6tkXdEZn0TLH9dEmOiXypT5dCi/wxI2o1H?=
 =?us-ascii?Q?d6tHnftoNBx5PabkARIfBx1e5CpEVLkhswKH0+4OsX2SWnhEZzjj7/Ru9ovn?=
 =?us-ascii?Q?BEiUTZMbukCIE1uHbDKLM7s5LWKxLcFlCcHx7qYkj3oWlqfJTI6d65n2I0tA?=
 =?us-ascii?Q?MG1g6GMxaON4aNGM1dqPK25WMg4+CDokYdDHr6DdE8LXL26lAblzjWdHnNUR?=
 =?us-ascii?Q?AUd/mHcKGbl+un7n4Z2ks12Abv6fwUJEHymETUSq1jQeiAI2kEBS2THVzMWB?=
 =?us-ascii?Q?bfi+hJMtYcSmLUvKe6h+d7LlhjmfekSnTk1Jcn6OpYGV27WRxxDPbFGq0nU3?=
 =?us-ascii?Q?a1xzJW3q81lXUQKBlTRm49V9Wzx8ugDNmHndxYQqWZO6/O+1kd0ptfMb3U8S?=
 =?us-ascii?Q?RUW8PkIk6yG0hpUGsuleJTgu7ev6KxGOrOjZVX0EpWsBgooHk4wRHvp9/msr?=
 =?us-ascii?Q?++GRuxWw0u3KP4DKEiZuAYesOjlB/uXm1Q4lILEdtZ+0Elmp97GlMvo++XjX?=
 =?us-ascii?Q?RkihCfEafCiOkGjFtZ+tO4pNMyLZ1a/Nlz3UYT8W3OgWIV4ZBdsCVXZSdfzm?=
 =?us-ascii?Q?L/Nuvx7dVs+0Ommuysfcbe6pbYPB2KVKt1r1dTUMm4GEuHza142LU8GMIzA0?=
 =?us-ascii?Q?nUzAkVB6JpFuidi/mkXxW1UI/qwuumQNKajXh/dz0Mf1vS8L3foWK9Kab2+X?=
 =?us-ascii?Q?RsMvumiAWWpuPdVvF7fhUbEYuVhoyJgGfy/dY974850pnTR8MOCUk828YRKd?=
 =?us-ascii?Q?8NADjkphy/lDmrfLh+8wfhovuTdkXxzu6MvMdKtS3J//6dXiz9NqG2VBOvi6?=
 =?us-ascii?Q?q2ve1CFGkIIyjHwPLHKvL2SfmVN3VcvKdV4aUrJDhxtbyM2UeO7X6t927O2I?=
 =?us-ascii?Q?VJ9VQmXUHYcMsyDl2szwAGKDdCAqtb1Yh07iAnkhlfzg5cLjRHUh8QLZObS+?=
 =?us-ascii?Q?ZTmw/TEVpdxBh10oNEScSxsjkrfIA0EPu0ETBPHpIV1ESoZKJSth/xu35HwV?=
 =?us-ascii?Q?cZ2Q17jDXPh2rzsoLAgrm3FB2rTGg6vbf0l+X+CdzVaB256xtXdgGzrOSqB3?=
 =?us-ascii?Q?M5H5/mDhuRfvEkyAw4p79PJkBGf9QSEM9TaAScUMBiY7c3z9l3qQ2ib4qCKE?=
 =?us-ascii?Q?mkrbAYZzGNeIsmiYjggzvfxeigl1oiMxQAwIUIyVcMJ1qslGQj1G7P+pFs9R?=
 =?us-ascii?Q?KCb3CPQdyQqfEEVA6NhdQNuW4RhwPZWv8BU/e/yuKqHzHreG//1gvdF2wlDy?=
 =?us-ascii?Q?k5i6EHCMDEYi062KwRDD103+xK2u9M7x1JLRK1e0tQdVruRRwr138+PHu7MM?=
 =?us-ascii?Q?7lue09gD2ANwjZ5ijBCGwnU4r4iwvLQNrxHHt/dCDMvAGAcyC88KOfKJbwsS?=
 =?us-ascii?Q?8ZKGRRnRkBpIJW14DQPJ4ALO6+z1aAb5592uMhXD4g228OwkomcmCN1uH6bI?=
 =?us-ascii?Q?YDJTlXRoJKwH63ZH9mbZ+F4Ovz7oixdb4qhFrFq4FjVtrhP5Mju4ERxfleiz?=
 =?us-ascii?Q?lqxV5XhVWft+ZSuEeO2GsrG17mAzTmffvQonhXsvMY9rCNGvlzpcn60pp8Nr?=
 =?us-ascii?Q?JQzi9EVRisJPUlCNU2ToRJGyPEOT6DM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285e121f-219b-4905-44f1-08df0a9d759a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:11.0366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7zLfD9ctwRqn55lTgHjfV9QR6DYrgiHq+0TsJWuoOjEeGSEa8J5hN+mdKJnsRDPiXp0x9sBa04wH1tqn733BuN1KrVwHl0wxhFJG9zMbz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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

With all previous changes, the Icicle Kit model is now able to boot
HSS v2024.06 through a Buildroot 2026.05 SD image to U-Boot and Linux.

Document the tested source versions and exact commands to build HSS
and Buildroot. Include the sparse resize and GPT relocation steps
needed to make the generated SD image usable by QEMU.

Also describe the RAM and serial setup, boot stages, and remaining
model limitations.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

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
2.53.0



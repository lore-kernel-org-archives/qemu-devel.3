Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC46CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnlJ-0000A4-Gn; Tue, 13 Oct 2026 21:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjn-0005ru-V3; Tue, 13 Oct 2026 21:25:05 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjl-0006wT-OC; Tue, 13 Oct 2026 21:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBvic1KsQRUt8yYN38qEpe+WOXizwfVdl/Dh+R8QkMkzrzNC76AqG5Ky8+SWZyTdbIvUJLF499nV1ieY5LhOBXASYzhB/S8/DeGQN4exFI895FB9Z7Wj5OdbvbgdZKZn98PD/YbISbvpKRvsuANTsNcLlybAp2HLz12T4A/eqg3Z/WzXrjIY9K0pHyr9En6IqXv0dPRR/d7eW6FvtqwqBHHRQl+ZNEK0dno/oprAzTg25fouotDvfZW23PUGrBQXOtxW6OjF+HyjqD58sVdOM3flFjpY+gizVEztGMs2FpRNIQHiyroB4YgvKo2ESaeE41jKeUYKZo+k63NhOiEIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNdTMIwK2VNhp4ZslhvE6xspt86iyoxLwlth1kQGMdM=;
 b=yn7WXaXJmWXq7W1AkRHS3bhs8aIHmN/+/kIvCfGh2XvhsqN91AP/sGE0p0HUaXdzzO1+IWch4G5SIYKHBaYH8iC1Ljna2I/t7XGT+p74g2LLkcGukgBonoMUuQD6DXPxpXD3pIzO4FMgaROd65nHKbOUNpRpq8PTgyh1nJOkQevAMGHxRY3b7SjfLOPPjwp9anBGXJpia7JjjeOm9a7WC/7YlJOTOYf90DJHE+thY455VHO0WKSjFz+5ce92IHn0cMlfBbM5RNsZQplh5nieY53mWXUPysvFFsZGaN2qxj9B6cbcd0wyHYh0FoRiShSYTs8bFHjOYn02mVm74yF6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNdTMIwK2VNhp4ZslhvE6xspt86iyoxLwlth1kQGMdM=;
 b=LNNy4W+oBSEtQazU/wtErjEx8QeBLKBNOaravy+4NmM7UYoqri1Ah3TOFpFlcGqhIG89M47iwexehUGxiznCZz8gVXGfpVH7QsSwTKAFIVW7xeRk9FU/gWfk1s7EvYxHjC8KSSKTGYNVPMxSwjZQ2VgtuKxn46QYNAxzeL/92g1nTckoD0puPcQ7OXhl2iKYNaMeGeLw4vg0bvlwiiL2RNeK6ikQIsmpG+z6QXFLpQ9ONvWFW+Z+rElg7fjZOCgRssbCj+VbfuL1Lx9Z0c1WSx9riknMHEmpnJ8ZuWFfuapeHeQxZsQyKTpc3NDAfXwpPLYvjWH6qixihjy2Ctegmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:24:50 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:49 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v4 23/27] docs/system/riscv: Document Icicle Kit HSS boot
Date: Wed, 14 Oct 2026 09:23:03 +0800
Message-ID: <20261014012323.322790-24-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 663274d9-22b2-404f-4851-08df2991f0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|3023799007|5023799004|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GSBZXUFzbcyopocudi5Ut1vTNPyVHtku2iuVJlZ94EyMUQv0M4IeIlTubAEuxBZfa5c2Prwowwk4BUSZoEnaz3YORMaS3YiO56/UiniqNp3VjtFvQ2LWpekDum7P/5dikK5b/h1FpOO8KYNq7R+AGd/1MyswbiicgcJWBSL1cMRUsfIv6iZuAH0iF4npulljJ/GKTcMcT0XVN0L8aic3+XKO2r0nWYhGQpA9VAfy5tAka+zlEafC+LvplBXfW9me6aRHZwZ59PmduQd3PoEHSVZH8/KDK/ZpVdIXdcixDJkmgjBMKaahmYmqM7vKg0cijLVx5caZ+ZS9ei/oBsl39fZD7t8YtzsxqJE+suTEhJ5N+K0H0NzPF2w0oDRXMrsZ+ScDlcX2Gk6YfFVXNp7+plsKrw+swzHLAMjaVp4t3v//v380unelvY2lWjJOasPBdGFv04oajF0EElZeTlr3WFXhovG4iWrdmVpklhpCF+gwQvF6i4ew5p262VeJZJT2xNU9tUzV21va5LT5QC1Rs2/I0NPW6sdayYZ8zDGQB2ZOBAYWNImjenUEjyxB4eyv/fdwGFX12N3GJBhvJOW9XDfVxsAB3jDibKbjen9f3zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(3023799007)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zSP1tSyByYyYCY5zCElhchO1gZ4JftBu7a7pYPO20qNU4SNz+wogBVy/Pwg?=
 =?us-ascii?Q?hKLjVylNgRjnkUqHf8rWaHbV8p3ar2dn1Zfp7gzNKwRc6vuKI3UYaO+rNK8L?=
 =?us-ascii?Q?SS9RlMZZuhl1wIfAHRMnJllr7Zir8jv0JgwJ/qxEKvysBaqi0gqtUyDH60aI?=
 =?us-ascii?Q?wxzgy4oaa8SyKRXc68MhGjIm6pCuIh/7jLlHqPCi5xvDtrnKJu7Ws68M5alA?=
 =?us-ascii?Q?ALJEZuJftdD00DtQLkX27tzoH45ly0hIlNcx47FDB2yosWhH8o6iQVFHfc5A?=
 =?us-ascii?Q?dQG3a211T3ihJ9P1pt0Oh02n3z24TaQmeOP3MwHCcrEZ1ZKuWZY5Iu7K7N8v?=
 =?us-ascii?Q?HWr75FAsT1geJPGOu/cVCiNtEk24XZhndNMHbWqBxPElY7hzMuAMMgO8QxYc?=
 =?us-ascii?Q?ORswLox60t6t3MRYSigXDxQYtVIT+0QMbJ1OgUOGqanCIVWo16HukezTOqJm?=
 =?us-ascii?Q?GF/2wCL2e1NIkcGDN0ks8C1V/Z3YMkgCBLB7SikvwWaf3wE3pR4m/Ii9L38h?=
 =?us-ascii?Q?Ao0oGpQRxcUs/C+3ATSEN4ptXsZ4kUTH31J4qJ9tbGhDyc7DkARCc2nuj9nw?=
 =?us-ascii?Q?9s87FXGNfccORxvMKSSIc3X9NlL/Mb5qzXfEVKXEax2JfX/+68qQjlrsCpT8?=
 =?us-ascii?Q?FFy9FMWY4rI1jEY44GGKXy6HNFZxXx4cWV9x38Bzo4wBC7/qyvfYXb1/G8Ls?=
 =?us-ascii?Q?k3Ci2RYPz80QVFYi9ckUyfDjOVvlaVQ9LDUZuMYAXCExvu92O7LchwrkDhW9?=
 =?us-ascii?Q?UJoGZ7vYV+tJnH6XZ4WcrClab6aIVttmxtjZ1y1rfuP2n0wH3IGkrqAFdGDs?=
 =?us-ascii?Q?JqUVcjAFzFirlX5E2DSvkEZ6p/EbGb3wt1TdTyj64sO8lWA5GO/F8XI8WjBT?=
 =?us-ascii?Q?dlfMjmVg4REdACDP9pXr7n/Jkk15sF/FcoKmayvGfZbkM/4c/GouS28/YEXG?=
 =?us-ascii?Q?h0njUUU/8lSTSOHD7DeMWsj6VPRJKQjLR3JGLurr+GlD6CYTste9dGmTSIMX?=
 =?us-ascii?Q?dvvsZXwItt7MhQAGSd1U30XOD1VpXtk7yg+Xt+9EIUlzRMxRBRn+X034ZdFd?=
 =?us-ascii?Q?bKC1Sg6I66auFm2AcFZzzwt47e2hVstUx7je1LyXjv2Oy+3BabEVO4BgQNKs?=
 =?us-ascii?Q?dDf1pITEl1PoaYX52SczlcrW/AjcOvTlxhtGV7cKfn3jJgwOQyq0s0vFfMct?=
 =?us-ascii?Q?oeUYDKHtb0znvRoEq0LqkM5KGL1t92hAVXFYEaUJ6Ul6KuB0LjccVTJ7pplq?=
 =?us-ascii?Q?Bd9WcIlUsFjh73Tv/HcyTVcPASIBHJb3KtMLH3VR7dyN+nnhSmbM8WFS4Cxy?=
 =?us-ascii?Q?PdpH2v9FQ0Xctj1FO7cXm6FMSGdHk0V2xSeL9jfW4UwcVV8Mf0njtPJtxqPn?=
 =?us-ascii?Q?Q/BB36IKMyMGXU9WVZ+49b3BNi3CetLCx7cOjEWspchIDUBrCSer4sdXq0ut?=
 =?us-ascii?Q?Ja4CbMuV6iBKRGVmoICIrKXPF8UlltrwMeoiuflsDkof1VS4L+3VQO+SxK1J?=
 =?us-ascii?Q?8uKAi80DslvYSbxFkrIFF3+bxHWCNul7FIcCGKGZsbE7b9wqPL/1802DoOWj?=
 =?us-ascii?Q?V29qlsAZjswGalr1QoTwPVSTyKbpJeYDbbL0jKdEzaeULckxhFxiTLLf9zDr?=
 =?us-ascii?Q?SYJCEUmE+bgK2C4GpdLsXBpqAIJDqwcghfaednWHGFDoeKrzsVI7JI5an8cB?=
 =?us-ascii?Q?DtDiSgPH2yK1GBJgP8EvMaY1xetYG+aMbjINcq9CvCRxfWaBz84xPBybI6SF?=
 =?us-ascii?Q?9iYhk/f8XWbOW4/mfE/E/rrDVIK8nbQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663274d9-22b2-404f-4851-08df2991f0ce
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:49.8721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyoOT4MJNMbT1xn6e2CLEK4Wg/FB0muDnrFaFKT6g/t35jOL9ufBXdjvqotrEQV/SSA9hcIcHOPBJSoegJZus+XLXOrS8S0Ew/Srb28tbk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6222
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
HSS v2026.04.1 through a Buildroot 2026.05 SD image to U-Boot and Linux.

Document the tested source versions and exact commands to build HSS
and Buildroot. Include the sparse resize and GPT relocation steps
needed to make the generated SD image usable by QEMU.

Explain the pinned firmware baseline and include the DDR pattern-test
patch used by the versioned test image. Document the tool check needed
for image-only builds and distinguish the DDR training failure from
the two investigated multi-hart startup races. Describe their visible
symptoms, affected source versions, and all three DTB supply paths.

Also describe the RAM and serial setup, boot stages, and remaining
model limitations.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v4:
- Use HSS v2026.04.1 and the v1.1.1 test-image recipe
- Select the SoftConsole toolchain explicitly
- Use the generated complete boot-mode-1 eNVM binary

Changes in v3:
- Include the DDR pattern-test patch used by the functional-test image
- Document the image-only FPGA programming tool check
- Describe startup-race symptoms and link the firmware investigations

 docs/system/riscv/microchip-icicle-kit.rst | 129 ++++++++++++++++++++-
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 138289a913..2159e8e461 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -19,12 +19,14 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 4 U54 cores
 * Core Level Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
-* L2 Loosely Integrated Memory (L2-LIM)
+* L2 cache controller, including L2-LIM and L2-Zero windows
 * DDR memory controller
+* System controller and system services mailbox
 * 5 MMUARTs
 * 1 DMA controller
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
+* 1 Real-Time Clock
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
 The machine defaults to all five harts. ``-smp`` may select two to five harts,
@@ -103,10 +105,125 @@ CAVEATS:
 Running HSS
 -----------
 
-The machine ``microchip-icicle-kit`` used to run the Hart Software Services
-(HSS_), however, the HSS development progressed and the QEMU machine
-implementation lacks behind.  Currently, running the HSS no longer works.
-There is missing support in the clock and memory controller devices.  In
-particular, reading from the SD card does not work.
+The ``microchip-icicle-kit`` machine can boot the Hart Software Services
+(HSS_), which then loads an HSS payload containing U-Boot from an SD card.
+The following flow was tested with HSS v2026.04.1 and Buildroot 2026.05.
+These versions reproduce the firmware and SD card images used by the
+functional test.
+
+Configure HSS for the ``mpfs-icicle-kit-es`` board using its default
+configuration. QEMU provides the software-visible registers and deterministic
+status consumed by the HSS v2026.04.1 DDR initialization and training flow;
+it does not model the electrical properties of DDR training. HSS requires
+the RISC-V bare-metal toolchain supplied by Microchip SoftConsole to be
+available in ``PATH``.
+
+The versioned test image applies the `DDR pattern-test fix`_ before building
+HSS. Without this fix, the DDR state machine can reuse uninitialized
+pattern-test parameters across calls, particularly with the SoftConsole
+GCC 8.3.0 toolchain. Apply the same patch when reproducing the test image:
+
+.. code-block:: bash
+
+  $ git clone https://github.com/polarfire-soc/hart-software-services.git
+  $ cd hart-software-services
+  $ git checkout v2026.04.1
+  $ curl -L -o ddr-pattern-test.patch \
+      https://raw.githubusercontent.com/processmission/qemu-machine-images/v1.1.1/machine/riscv64/microchip-icicle-kit/0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch
+  $ git apply ddr-pattern-test.patch
+  $ cp boards/mpfs-icicle-kit-es/def_config .config
+  $ echo CONFIG_CC_USE_SOFTCONSOLE=y >> .config
+  $ FPGENPROG=/bin/true make -j$(nproc) BOARD=mpfs-icicle-kit-es
+
+``FPGENPROG=/bin/true`` satisfies the boot-mode programmer's FPGA programming
+tool check when generating an image for QEMU; no physical device is programmed.
+
+The HSS build creates the complete eNVM image, including the 256-byte
+boot header with the image size and per-hart reset vectors. Copy it to
+``build/hss.bin`` for the QEMU command below:
+
+.. code-block:: bash
+
+  $ cp build/bootmode1/hss-envm-wrapper-bm1-p0.bin build/hss.bin
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
+* Two potential multi-hart startup races were reproduced with HSS v2024.06
+  under QEMU. The affected code paths are also present in the inspected
+  HSS v2026.04.1 sources; they have not been reproduced on physical hardware.
+  See `HSS startup races`_ for the investigation and affected source versions.
+
+  * In the eNVM wrapper, a late U54 can clear the decompression completion
+    flag after E51 has set it. A boot can stop before all harts enter HSS,
+    with the affected U54s waiting in ``wait_for_decompress_done``.
+  * After DDR training and payload loading, a U54 other than the configured
+    payload owner can win the OpenSBI coldboot lottery. With the minimal DTB
+    describing only ``cpu@1``, U-Boot on another hart can repeatedly print
+    ``Could not initialize timer (err -19)`` and ``resetting ...``.
+
+* Without the DDR pattern-test fix above, some GCC 8.3.0 builds remain at
+  60% DDR training progress while QEMU keeps running. This is a separate
+  firmware parameter-lifetime issue; see `DDR pattern-test issue`_.
+* The SD card model requires the raw image size to be a power of two. Keep
+  the backup GPT header at the end when resizing the image.
+* The machine does not generate an Icicle Kit device tree. Firmware boot can
+  obtain a DTB built into HSS, included in an HSS payload, or supplied by
+  subsequent software, such as U-Boot or a kernel FIT image. The DTB must
+  describe the selected hart topology and the modeled reference-design DDR
+  windows. Direct kernel boot must use ``-dtb`` as described above.
 
 .. _HSS: https://github.com/polarfire-soc/hart-software-services
+.. _DDR pattern-test fix: https://github.com/processmission/qemu-machine-images/blob/v1.1.1/machine/riscv64/microchip-icicle-kit/0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch
+.. _DDR pattern-test issue: https://github.com/polarfire-soc/platform/issues/36
+.. _HSS startup races: https://github.com/polarfire-soc/hart-software-services/issues/106
-- 
2.53.0



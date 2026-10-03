Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9E4CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3BH-0001z5-Sd; Sat, 03 Oct 2026 13:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39c-0007UG-RY; Sat, 03 Oct 2026 13:04:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39a-0007Ds-6Y; Sat, 03 Oct 2026 13:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbXwIeZNOeZZr3Iy5wENkKlqEh+U0u8GyFfwsDWaiutCo2rn6xy6jd/LCUelHzNwK2SRb0bX0XwjGhblirZ2J2qG4MB00C9L4eft9imJOBNS9ECtdwxlauZ8YWS/Ocr9PgCVmDED6zvo4FKhCek/qdNCv2UnANvIg2x67pY8FiuBwrDQX9QaHfXfR44rWURTWIixKwETsgiQ2n/oQlICs2hyn3l5hNQkHvLVt1qKwr9XDQDrjWhaucw6yL7L1oTevAsXtHhjf0viKuCnj2+/yjYsWSLYgugcRLGe+1SCOG4MKtbAsTl+/fsqcj1IBjXAvz8tl+oDVAiugCa+s3Kczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gi5fhtXxuBlWkuMhj99VtW6LR9Y/HUIRLtkEPdAXcw=;
 b=SPO/S5Yygj7mAmvTb8UqyMLzuYgFKcQcWjauFHITlg9xJ5tzCKmbCVO/99Icu/w6qq9709kpkin4zyT1Mg/4Rc4vvWIdVycWPo7zOZ7VbmNHrbNoIt0iEjsLHpM/0JJ5nqUZVowXt4axWtnHz0SFwksNN1XmYyHKEFrFIAfCxxr3o1PoGxk9l+tvziV46WVFet6pSHrqN7yvcCLAwEAEJlWxrobzeXtBCgbrKEViUi5la6vN9uOcf7vZju7Yk3U3C50adZ+4uQ73yJcXgypXpX/ukeUvIRw69vhdaa2jhpJ4sHDTp6yznwgLOnnpt0/7NOHF5mOBDb8NnRP1HtuUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gi5fhtXxuBlWkuMhj99VtW6LR9Y/HUIRLtkEPdAXcw=;
 b=PBCBJoNX0i48FhR1vLiMawcOU27jtGwHbsTjDhj/cDUAA29Ui93UtIHPPGH5SFOhwe6+UorXTtwFRMb8aA8EiDirxwbRhf8NtcOSq8VMCyidRx3sCYj+2sG/Gz0RDvEeQ2oEgPvprSvbpa0o6tQ2QBipblrUpYOv7TEIS6nmCUQV7HqGeZzXuzEHtxn34vgm4xCZ+gW+u3KDZSgY/+8m8M0ctDOk5iP2pZPWNSdMruBbA97ipksSitagE0DVGf9hJHVFvFxtJYGWcUW8xllzI+Z+nFttSZJQD/BaPT4FMh1/NN5NfiqZhLujNQPZ2FCcCmbfI53025ZQyLaTUmBqYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:59 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 23/27] docs/system/riscv: Document Icicle Kit HSS boot
Date: Sun,  4 Oct 2026 01:02:13 +0800
Message-ID: <20261003170232.2450916-24-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: a0554d08-cc5e-4802-85e4-08df2170517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|3023799007|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: Y6uMu2OuvpdTR4J1oBRK1DsqVSEEjthdkhQ/Bg6b0/cRDSl4iDo9sZQePTtn8bM61Vce5Edfyb4VPB84nYaO6MoBN/T29lhHggPpXzrlmtRNw3uSZEinenb5sKfyz3NnJUY/F0kk9vmAI79KLgEc1oV7qTb3M92yiDqXmvWyLXqAbjGScvnpVncpU82x6ryrrB2TBGDbfAG8C+Q3yz+1QVPAGfin7/D3KltYKCS2jjc2S+2XgqPVqLafLDxwPR3z232WHtGnsnGcVhM+nLA3/H4vKs6x01kLbUWzdYZ/FO877J3e39S0Imudns8b91TFvzCXq5sc11wDw0dxiJxq2rpRArP+mNwou5b/2N/opJVXt8c3NyljCsTGysAHKCtLykPISsKAsZf07eWBgqhjzSKZauNRb0CLlGNbEl9edULDoUahpwjUzmEYPwkZpk3G1oJlxpOJWhaCjoJKAJsX0Wj7N1PcZycPU17PnIL6aBvdlhz9fnSbEuDPgdCvcc9v2mJ85uPzfoMT9Pe+q3KGnohPQzQhwdTvS4kdzTUFrKoFmb7KW59cEFwG3RiNtF7Bpvc/giYmcFg9lRA4DTbVo4xB61KPj146HsFoXo1uUdX4VnzXTO7Nf8gm77MF5mJe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ix/z5khcW6CKTq8n+8qgNI/9TqkVZXSgSsyS0SwjOkOkuy6g2orIHUCWlofs?=
 =?us-ascii?Q?hPmp5tPCAhdK4mK1AJBNU3gUHsQ9xJ+yCzCeaosVswwr2M4qMfUlyrQ1QddO?=
 =?us-ascii?Q?qlUd8mF0K372NTHdulzjip2Qoqp8V8AogsKCl/wu4PZ9fRGVQXqCE5XnkogW?=
 =?us-ascii?Q?3Q4qIX3n8Vp3XUo3BMirfuzcwq/qCmpGhtVk2KQYf4ST3GD29+kb29iy6el3?=
 =?us-ascii?Q?8H/krvLjmGOgL4jfickQR05iUpqV+bXhSBWVqvKZ0Q3F5rhEqUNpBw8X59QW?=
 =?us-ascii?Q?Q2M7fCAB0c+3zxX/sftLNWEVv4dUXXMqIchybnByB8atC1/DeY+kZvGslcmq?=
 =?us-ascii?Q?THLyAQD7yaBHzraGlsTedoL9eCvgvzfnPwkmqKy71VddYEsT/kz5mDC4e701?=
 =?us-ascii?Q?nogloIPKoQhHL+ZGGCVG8y02hMuLfjccw5gI3Sa3dQG2ER0NuM4NIWc6Jptf?=
 =?us-ascii?Q?oxVKAPgurHQTV9BuZMca2EDJokCL+dw6jkCxxURo2oR1LqfuZfBZokATa28n?=
 =?us-ascii?Q?zVrDyN+Zj0kkX0OLAlmFSUjZeVOo3gdlrJ5T2L5QtoVNqru1Hlc2QCFmzhHO?=
 =?us-ascii?Q?vcUCld1JqgLfEaEZmt9kBZZo45y/v1/f3ESCG+NlXejtuXW3cseUh1/dyapE?=
 =?us-ascii?Q?LHHKKarBghoO5/jEyKxUkfhRQn1olWsyNVsAmTaMFRDwhhXkImz2iE/RnFQq?=
 =?us-ascii?Q?xhgikCbwBu0HBltclP33gJMUT9akmvZED/MlnO4jSRcI9gngvILZhUf2s8ZM?=
 =?us-ascii?Q?3KFB4rjMEY7lJQpJ0jvh/Ph5tmgkojGHg/VnBUTMAefKpI6j3XLD0nnxyV4X?=
 =?us-ascii?Q?+A3VH/YLZ9xtyVHa8pFbjXPyFr+uOTZjvjAGR6vLUxvsSQs+U9t/PS2Mh2Jx?=
 =?us-ascii?Q?QVsWvBlCZweU2vfrENzJjZCvR2kdu2n+aEIxhq0ydhNxlUDsoKoh1d7NIKuH?=
 =?us-ascii?Q?ftw0I8B9ybe9WQFqTEYhFvnzfUMVUIIB21pjNFGbEZE0++76kJRX9P8J+NZf?=
 =?us-ascii?Q?55KY0tlhqKdBtMDG2bEmk6NimLSx7VJk28jafaooyT4u9jwuT0Ab2aqRUUvc?=
 =?us-ascii?Q?tNDxLDSTSJ2SycL+jBOZgL59vHtS1+y+EDaIDxFJv6DejMbKtElMTQBto8SZ?=
 =?us-ascii?Q?El1lfdLV2uPppRSVFFCyhtlqUmFtuVravuy3cBPsdpWYKWmkQFpH6fz1TFaq?=
 =?us-ascii?Q?DEy902cdehKQSR+Y0xIrOMc5g2FNTyJPYtPcrx+qdhWFrjyGKZB4GbiyYeqf?=
 =?us-ascii?Q?Z7hZ4VXK/AA4ojUWwJmRIlSErFCTgE3Ll5/jRbmpKyB6Cp8fGKxzcG45j/aB?=
 =?us-ascii?Q?zewMmJIOmziV7mwzwX3RA0gEI1sqUiy0QXWQW9GXAvWe3dyUJqAab7Q4/2ot?=
 =?us-ascii?Q?o5KZRhWZPIptIip1hV0SyOosQ6gsijw3LqkDvbQxZDWGs1VBRGL3J6qrZ26J?=
 =?us-ascii?Q?stMycn/llCn07shDakq618HkAGdwk8u9+lczRDXMeiNcrIflyI/MMQ4VXvF7?=
 =?us-ascii?Q?QtcuiisgMbhwIMzMI9xFkDSsmw6mW06URYycFn2IRNyHHiyG0ny06Zpf5zWq?=
 =?us-ascii?Q?4Cxkw97EGJCULSy70E25cwfAj6xsDlfEFY3F9V1PisgF62hxXx9BX0pTCa4A?=
 =?us-ascii?Q?h8tMBlYze1zxvhTBJgkG01VeF0Behf1JbIjRQvhnaXZN2yX8yhBHRuId8MiC?=
 =?us-ascii?Q?mqyODmyBfRpd1sLZAYIwUDyoE8k9LrtEInukD/XZSm/jLFR6ij9AMTzjb8XH?=
 =?us-ascii?Q?u5cZF7d/T/HR8V7OkDA0ZyN/jfotddQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0554d08-cc5e-4802-85e4-08df2170517a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:59.8212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osLONJG4N0JZKwHX0EDZbPB3Aa33pk2GKrQDRkJmQbAapF8R45W1s37+jLZ6ho5tti11OrZNp2g5PWfa44gmDURVxzCwk9qN9ATNRRSaeCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
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

Explain the pinned firmware baseline and include the DDR pattern-test
patch used by the versioned test image. Document the tool check needed
for image-only builds and distinguish the DDR training failure from
the two investigated multi-hart startup races. Describe their visible
symptoms, affected source versions, and all three DTB supply paths.

Also describe the RAM and serial setup, boot stages, and remaining
model limitations. The official HSS v2026.04.1 eNVM image was
also verified to reach the Linux login prompt with the same SD
image, while the functional test keeps its versioned baseline.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Include the DDR pattern-test patch used by the functional-test image
- Document the image-only FPGA programming tool check
- Describe startup-race symptoms and link the firmware investigations

 docs/system/riscv/microchip-icicle-kit.rst | 130 ++++++++++++++++++++-
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 138289a913..9fde3f1073 100644
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
@@ -103,10 +105,126 @@ CAVEATS:
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
+These versions reproduce the firmware and SD card images used by the
+functional test.
+
+Configure HSS for the ``mpfs-icicle-kit-es`` board using its default
+configuration. QEMU provides the software-visible registers and deterministic
+status consumed by the HSS v2024.06 DDR initialization and training flow;
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
+  $ git checkout v2024.06
+  $ curl -L -o ddr-pattern-test.patch \
+      https://raw.githubusercontent.com/processmission/qemu-machine-images/v1.0.0/machine/riscv64/microchip-icicle-kit/0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch
+  $ git apply ddr-pattern-test.patch
+  $ make BOARD=mpfs-icicle-kit-es defconfig
+  $ FPGENPROG=/bin/true make -j$(nproc) BOARD=mpfs-icicle-kit-es
+
+``FPGENPROG=/bin/true`` satisfies the boot-mode programmer's FPGA programming
+tool check when generating an image for QEMU; no physical device is programmed.
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
+.. _DDR pattern-test fix: https://github.com/processmission/qemu-machine-images/blob/v1.0.0/machine/riscv64/microchip-icicle-kit/0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch
+.. _DDR pattern-test issue: https://github.com/polarfire-soc/platform/issues/36
+.. _HSS startup races: https://github.com/polarfire-soc/hart-software-services/issues/106
-- 
2.53.0



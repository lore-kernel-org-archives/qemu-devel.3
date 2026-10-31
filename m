Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7F606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=aK4xcqNk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN3vi-0002mY-S5; Sat, 31 Oct 2026 03:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xN3vf-0002hu-Hd; Sat, 31 Oct 2026 03:55:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xN3vd-0007eR-RZ; Sat, 31 Oct 2026 03:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+W3a+FHMVAOjZWDuUwz4IY3E5THjuTJCplZoPQUn+gVYvH0048XenFurUv5dTsxR9kuJQat9TOtUQxy0mhueO7IrTm7gOBmILWujq41zGjipqQSiFkRrq0G7n0i1VcF88Zo6YSuAJOrhAOGrpg8lrKVWVFI02EnSLmRp8lh73FcO2Gfp7v9dwauGKnzpt6ggXPumKx5q5R5J5ywGULQ+ZigYCL8Qeu7Qz/RwiET5hshRSShEhg6fAAVPb7gHhNmW+795Xu882Mt18Y6ytCWUuiGmP5GnCFo76UF8l5XBXSl0uQPU0p4J6t2Riw5/KfPyUnyjPuT/xPkXk4EMQdM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzwiYbX+w9aAtUCkoTzRe59HHqeg9V4PajJJCMymMsc=;
 b=pPWhvy0tn6TzRQsCmssVXF1eqXXPb7mkUDfTtrQENUW8vxFOIiXo31gkkOsYlpwONUTYCKxwY1Uqtv681yDkKEWMa9yp38yHNEyVrpiRb4y+z4Pxcz1HYXYdAtTgZWRhsucNU5Ii+CD4XLaOWfgcPQy+q3pGg+evV6MajhzTrR4U6UruJYxwMmmkZ4PnxgpCwqNtnGhMwDMypjc88MPZhQIxPaXsU12lTamgQfgV0vOXQJtMM5C41TZdd5vdkQ4uIDaItEfRJXKRPhR0K4kvvc9+93vGbqE+KdPHu5etMsmKY5TtjtCTktbMM3vFxI7CFi6+dk0t51loJ+7UsvGqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzwiYbX+w9aAtUCkoTzRe59HHqeg9V4PajJJCMymMsc=;
 b=aK4xcqNkI97fwAAahZNns3/SN6ShcNe65LUvMyiPJvM4Iat5SYEJsar2GmlUwVC2kTaSjBaCce0Qpl9Gi7bBysvuoWP2VGW2kDpuKxboVqG8DHUvoI2ipzaI54gly+Qk0HdoFEhKmn3IszqcEOSGIIDoQK0EUmRq7hkRaZ40MoL1wgZp0YFY+wEQoViXGKq/p3k7QIS2mc4GbNBqE7i5Kfikr8/nqfWt9DRuVy1yowytT4UK5+Ia7+sYD8bSzP02iKU4yacqMRrT/TCH5Tw0H+g9uaPLnhRQm+T4rTlYP4y2V3B5We/8wDh7lo89T+dJXyKlpEU9a6t8itdR9TPaOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB9051.apcprd02.prod.outlook.com (2603:1096:405:39a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 07:54:57 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 07:54:57 +0000
From: Chao Liu <chao.liu@processmission.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 2/2] docs/system/riscv: simplify the K230 U-Boot boot flow
Date: Sat, 31 Oct 2026 15:54:33 +0800
Message-ID: <be072504dde1626cc88a489805be5a988580bff3.1793433265.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793433265.git.chao.liu@processmission.com>
References: <cover.1793433265.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: d52c7172-26ad-494e-756e-08df372441f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|3023799007|6133799003|10067099003|18002099003|22082099003|56012099006|261021121427099003|261026140227099003|261028144727099003|261022115727099003|261022075727099003|261026121527099003|261021123027099003|261022105027099003|261009221227099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: bwK0knIxy9qFOpk1WODxmI4brSSlxNa3ATIlsHmRe962/wOuGZicn7yprc9oU/DDkk490fPrRsO+th2Rp8ovZyllophuFO0ioFNgzc/aLEpP/hVGmMSWs1etPH0Hiobgrr69n7SmC34O4bzfyh+8q1y+0+2Wq0sW92K7/gQR8WiwSaI7JMVy4o/7M3CHFOb7bBMPzim3jgemOrOBOjbgVrrrFAmw40bTWGqe4DlU52Xe+3Ro8KPjcV39fvZERGb6Cv6SOSIQcDHgaNeeK6p1AEBZPU26yMrXpL6hFlYkaBM4+iX6+sa+TNSpyBiwSKMV83t2H76uCur8LWXjPD3vQFyqvTq43jA4AOA3osL48Jfjchlbf1OworzpU3LtQjDPDkiB9g2c1ZURv4H8lsYJWV3k6rj0wb/hh5EkWM3hGXaKTeqgDPARsUJi9ftwrRKGBYuTVodKMtNbhdZ4nwRaeBeHimV7sSdMghkpXNgWv4txtUevJGVFqoeaAgzboysK2s8Nx299vstWYwWngSQP6TF9BGedsJL5WNYs8OySo1vMH124z70s9pbqzshl9NfMbA7H8P/4WESNPD/j/48X1gwuiFeVxX28HLF2/4xkAU9vk5DADGk1aw+02XDSkGsHtR/Hil0+fgbjXUnSXpn3zACFT/CPV6FlEiGj7+7M95A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261021121427099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022075727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULFYlakbeZJH2JSfMOF1e/Pb5+mk0JGMi9KDDQ+frnQQP8kP3GwmUN8phtZS?=
 =?us-ascii?Q?VZ2L1JQhLQk6A6TQuA2kyQMf4P7Wl0cbAbgUoouklEfu0FEdEwAwPlRIrlUB?=
 =?us-ascii?Q?jaCxRfitIcqqu8b4xIP1bndeKur0qrK+i6daxSS3Kvz7kfOLRQD+jmt3LpxV?=
 =?us-ascii?Q?LSIl0xlpH8X74Zla9umK5Yl2MaXSeNqIBKSbLSkU2L9rGvVQtuBXcvxTLjKW?=
 =?us-ascii?Q?BWndvi/MrbyvQRYUmlpAZCDjT2kU4BO0zX+fFEi6EZOaMDBsj9XvJ1QBRYC2?=
 =?us-ascii?Q?wjP19y4T2/hywvv/dQKHj1ZTixnl5P2uD/nTJ+gMse6+FI61jmuxp3CQR9aV?=
 =?us-ascii?Q?CSoQkooTCmE9t3u8JUt7vn4KFOA1kU6s2q46hecZxFn1EJ/hf2ucI2uoLs39?=
 =?us-ascii?Q?X7H9G7TvUYHHjzpCgEG/6yEfv5WBiU3dAbZi8M5kN+1ETJK3eV+LqsvKjdjr?=
 =?us-ascii?Q?/1bHhVBYmLD7O6mjVHzdKqo229aOoQU+m0/048EugP15eq6FivR0Hh8NNcQs?=
 =?us-ascii?Q?9n2IqJIqMRju7LrrRAoPkXvjbtErTv3jiHmhkgGkFENh/O9esOWl67gVp98H?=
 =?us-ascii?Q?Huk9lfyzYDYQJmxr9CSimPUXSZfdAGXas+knPtmZvKA7XVaz0DWc4/1+3gGh?=
 =?us-ascii?Q?JywOTAs06DkQHxXjSMEsMX5xxHjb3fS1iuEumbkyybj/2UTCR2ZQVennOWgX?=
 =?us-ascii?Q?0J7c+qj/ZsEhtW9t9DH6vDS0gC4bjJEPYJg05gOiT/Xd8uoCyKmE9023Sa3j?=
 =?us-ascii?Q?0HeZ9JPK6V8q8lN5caSLFGnY5huAUDTS/INuJa5FQVD9wEtbVQvAiPMV6mzl?=
 =?us-ascii?Q?HizW6c5y2zn1hiOjgxZSxsqMBrzX6+jIt6fifTpW6CIz2uKuQ0OMu1uf6jOs?=
 =?us-ascii?Q?CMcmfpVZwIEr0mqfJFb3VMnI1Br08YpaTi3HWZp9p+Wj6tNmScP/ZqXVuF+N?=
 =?us-ascii?Q?2XV6yRkFFUn24+2Cq6qfo9o3Jgs20sKu7Rtr1l3SnIgWknaWqHIKWFSGbD83?=
 =?us-ascii?Q?smiXJhnPGQPbWPGCKMfDULV44UsvjSyCFmGcMjSXcYNu/zUJk89zedXT7gOb?=
 =?us-ascii?Q?+9AvBsUctRcT7Na4uUWo07MMlWBoV0id7TAj0mqG32L1JD92ob8TCj29nVPe?=
 =?us-ascii?Q?Jmaq1N5zNwavLoxKpxX9Z6n9tjMqtyIUjD3I1O1TMeW4pOPimTtKH0WNaA91?=
 =?us-ascii?Q?Wu5liwzLgNqSnqTjqiKhkNsGZcLDVbZFMmPj7RWWHfTXpvY5WnbDnaVCf4mS?=
 =?us-ascii?Q?Gh1LFQznXDV+Q7UHjc7vVrWwrEKbiGDDcYlk86nxNC6/goUuB6eYly+IcPe6?=
 =?us-ascii?Q?oNICBqciWubNbKEtG/+68gZ2hzlazwxbOI2GamT/u87XnFSMYVOFBqRmgV2Q?=
 =?us-ascii?Q?UO4JLyvpV5tgVjI9pTIG3Ee6tKleyDcnPf3jy2aVR545p6enBwsCbDS5g2Sp?=
 =?us-ascii?Q?wmoShUw3Vyc305B8rfVA656kd8O3DONnBTLK88mRmSF+v++z7bXQb9xdEAuN?=
 =?us-ascii?Q?cGz5atJV0L3Edf+Glzx1Euu26l4jFegj6yAmptcVr7qXmNeEGmmLNTkJOX7u?=
 =?us-ascii?Q?UjcGEJkfmOXQCYkNCpuCUFr3nKm3hlmilf+X2wuXthsgFJ/nk1wyjAItSLvA?=
 =?us-ascii?Q?uQW3R3Cp2ytNKqhdwJsSW7frhmTJoYkmVNCNlqkrPrG2+/fUmUWhAc2UNtKX?=
 =?us-ascii?Q?+/LmscIzDwnreJqydEPrlHt1X3e5YiGUQXVwveb0wDv1TS+1E1yteps6r/qd?=
 =?us-ascii?Q?zqr87tuWN/Prcu6XtfDH0BQThyeyNg4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52c7172-26ad-494e-756e-08df372441f8
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 07:54:57.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7W4ULzkM0aTXnmPugbtEEWz0O8HNPreEs/JQ+ClWUcXuHwyxoeij3B7QwyEc14Y518NxwEvY3sc/kEttOT0oIxERC4muIaDQ0Kdhdf4CWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB9051
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
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

Update the firmware booting description in the documentation, and add
the QEMU boot arguments for the K230 images built with Buildroot.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
---
 docs/system/riscv/k230.rst | 60 +++++++++-----------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index 237611eddf..a65cf02932 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -26,8 +26,8 @@ The ``k230`` machine supports the following devices:
 
 Boot options
 ------------
-The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
-starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
+The ``k230`` machine boots the Buildroot based K230 SDK Linux images through
+M-mode U-Boot. It also supports direct Linux boot.
 
 The DDRC CFG and DDR PHY models allow the K230 SDK U-Boot SPL to complete DDR
 initialization before loading the next boot stage.
@@ -67,53 +67,21 @@ not emulated by this machine.
 U-Boot boot
 ~~~~~~~~~~~
 
-This flow starts SDK U-Boot in M-mode with ``-bios``. Until the SDK storage
-path is modeled, place OpenSBI, Linux, initrd, and DTB in RAM with loader
-devices and run ``bootm`` manually. The Linux Image must be rebuilt with
-standard RISC-V PTE bits before running under QEMU.
+The K230 SDK build is based on Buildroot and provides the Xuantie toolchain
+that builds Linux for this machine. The images can also be built with the
+standard Buildroot flow while reusing that toolchain. The machine boots both
+the images produced by the K230 SDK build and the images produced by the
+Buildroot build.
+
+Start SDK U-Boot in M-mode with ``-bios`` and preload the OpenSBI and Linux
+FIT image with a loader device:
 
 .. code-block:: bash
 
-   $ SDK=k230_sdk/output/k230_canmv_defconfig
-   $ IMAGE=$SDK/images/little-core/Image
-   $ INITRD=$SDK/images/little-core/rootfs.cpio.gz
-   $ DTB=$SDK/images/little-core/k230.dtb
-   $ FWJUMP_UIMAGE=/tmp/k230-fw-jump.uImage
-   $ INITRD_END=$(printf "0x%x" $((0x0a100000 + $(stat -c %s "$INITRD"))))
-   $ "$SDK/little/buildroot-ext/host/bin/mkimage" \
-      -A riscv -O linux -T kernel -C none \
-      -a 0x8000000 -e 0x8000000 -n opensbi \
-      -d "$SDK/images/little-core/fw_jump.bin" "$FWJUMP_UIMAGE"
    $ qemu-system-riscv64 -machine k230 \
-      -bios "$SDK/little/uboot/u-boot" \
-      -device loader,file="$FWJUMP_UIMAGE",addr=0xc100000,force-raw=on \
-      -device loader,file="$IMAGE",addr=0x8200000,force-raw=on \
-      -device loader,file="$INITRD",addr=0xa100000,force-raw=on \
-      -device loader,file="$DTB",addr=0xa000000,force-raw=on \
+      -bios u-boot \
+      -device loader,file=boot.itb,addr=0xc100000,force-raw=on \
       -nographic
 
-The loader addresses mirror the SDK ``k230_canmv_defconfig`` output. Read the
-U-Boot addresses from the generated environment, and read the Linux RAM base
-from the generated ``hw/k230.dts.txt``. This replaces the SDK storage and
-decompression steps.
-
-Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
-
-.. code-block:: bash
-
-   K230# setenv bootargs console=ttyS0,115200 earlycon=sbi cma=0
-   K230# fdt addr 0xa000000
-   K230# fdt resize 8192
-   K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
-   K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
-   K230# fdt set /soc/sdhci0@91580000 status disabled
-   K230# fdt set /soc/sdhci1@91581000 status disabled
-   K230# bootm 0xc100000 - 0xa000000
-
-Use ``setenv`` so ``bootm`` writes the kernel command line into
-``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add space for
-edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes because
-this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
-with the host-calculated value above when typing the command. ``cma=0`` avoids
-the SDK kernel reserving too much of the little-core memory window for initramfs
-boot.
+The FIT image carries OpenSBI, Linux, the device tree, and the initramfs, so
+``-dtb`` and ``-append`` cannot be used with this flow.
-- 
2.56.0



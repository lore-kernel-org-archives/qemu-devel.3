Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6B5C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxuH-0008AY-OX; Tue, 11 Aug 2026 21:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxuE-00089i-VW; Tue, 11 Aug 2026 21:37:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxuD-0001Yf-Cz; Tue, 11 Aug 2026 21:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPTF9h3AojocmoYinddO1CQIJQXI4m42UcVbOjdrjEthPIGA8FrwJtI9OeVo9muaEuPgK7o414if247Oke3kTpXBCDiinTFv7NHmFg6rclivbDmAptExilA4aSimJQYOmQFQvwni1tsrOo0FLSKsfsoD3WUnG8cHRxAovyoJftfdGUOQa1SsFBab+WVd4OV1TaGHdjfovvw95zYKh0CoiJIf3b+TaoBEdmmHedjBP0SSJV5yf3cKgqpEkUSIdK3uGw3K8tmwdSEblQzj8M/aECGMVn9zovrv1ui+IDdlNBpFxMH8U7vEOqbG3aeO/T3JVktp6u7n5Kaufg//G4lO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d185kItsfbgobAEvR/yfkfZbZLYw+WyIAkzn3qxAYCk=;
 b=K0g/I3iwFC4UwrdU0cVN6ts/BXTaaRoFvoEAVg2qRWX7MdYZ4wKXx9gUoP33v9BGGKX3CCS8kC7byilH3oED96ia2GhRIqmeYgXZj93T2iuFdXRcqw+7zVpdbS75Bfcmlr/iOuGc1kj7pAV+hAOMhpAmuVEgPsXU0J1OHc3Wj1/ZofcKnDJkLHJ3jGDp8cj209UoCTWTIsTRVJNOraqezOG0Cl5f4ku4G2b6yweM0aXXebtN9u06aTBwCt8yUrRVn3bY4WhYcFxa1xJw/wRf9Pe0wVUCO8cv2jZyKRdV3dVfbFDS9SFQ9nO4o3ipza/9eXxy4LJexKGtQolYaOerxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d185kItsfbgobAEvR/yfkfZbZLYw+WyIAkzn3qxAYCk=;
 b=rqN1WQAnx9L3cYcTPVaIr1ezMJmCzme1XXNGfuicSBerrx5+DCZlbVgTErTF7yokj1dz1tlpmpQEBwpTS5A0Ugis1wfUjPT6XWTgApiqf78WTEsqb/oco+vyOk4+hcwoGvRl+/eqcpHVko0R1BVMST6+lHseVsD2jinP9vq4k4uSPUHh461sYhpoqM6xFnTLE4hVl/eSgxP7kzgKe46ZEv5CUoss1U4P1jZHfB8p0vHsjAq3vwdewBEUi1LgZQCY+YZZIbXTc9yZT0A7FOF99k2qnVx69al366RlNETBu2pbyy5zL4f+klhfsHfhdDD1oel1zTD+RsJYbgG42E5JZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:37:17 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:37:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH 09/10] docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
Date: Wed, 12 Aug 2026 09:36:12 +0800
Message-ID: <20260812013619.2134092-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f3d9ab-cb6f-4635-29a4-08def8123e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: VhjriSkaeTWKYZHSw+c4veZc7pNRdBJ1EaiGunwWpO3JIs2+TKiSCMMHvRGtq4sm2udm06W/ReKBCZDDkXdHWUicszl5zE18X6JT/s43ZBjBX6MrZPhjySemEkkD28ADvDI1Dutqv6p6Sh9XHSzp5ufyn/BUAVFO9UCpy/6NDHb6yEw2yTC7Nw08hQfmmPc7/z+F++zidZ0sCZwWP3spqE9UFFFT2WcySB23vqWjwQpkVEWmzsIq3j8wS48iv3nI2Uyh7Y+uLfpQR/nRv7VBDnpUtZDnzRWnIz8sK7eZVbR+EygnFLA1AUWGN36m5/n+EyG5F6R6ssudbGwqD5WcUnUxRP4xf6noMEy5izgXr6O2Skir65TVjAErkY1jfHa5s3Pzn8fSL5LC5yPoX2GTtqMxvXpGgIM0smV5Ja0UrtWljjUhVRaFiG76G0crQUxi5qbdlRjeCszTRHLWlclQRKgNkhQ039YbMS9vQmMstbKPyoeStKXbCE6n1fkR1GgCLOfQqimF4JJySDDxrXwo+t1ML9C/i2DfcmcuqpZ2NBAMPr0wOoZSnopfZZnUI/ZNwwvVykfHwjHUBGUD5ZZ+UA57U0ljjCt7PzyxyZAdCEfKszHlDbIxFsBO3xe2jjxdmbGAn9woKP5p3/pQ+yv6KYbUAPQ7xOn7DbYoUTk4iPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7d2Rk6tDXuhx3WJgZ2KA7r+7UEz5omKeROfFCWVtKXrkkCLNbo4NM1/KVryL?=
 =?us-ascii?Q?JQhoCKJWhrKrGHINa5NcEb/cRVyShmYt1v9RlbZgBsj4LupmaaQ/r027Phsv?=
 =?us-ascii?Q?bI3urU3rk0vxkedPe+pZPMG0N+kB+9J3JyyL8jTj/pPp+HHfrjQsxmMFQgLN?=
 =?us-ascii?Q?qJcZANFh9NEB6umyVCEIjV9xtnVXlTnh1wtb/XKTRovBMGLltgY804ikw3aa?=
 =?us-ascii?Q?ahfVYvTLevu0IwBBObPqFt9reG/7/ww+Bpl8fEkxGa1huXV6XHxeEYNA5dtm?=
 =?us-ascii?Q?ylrnWr4VIG0k4LC+ZakqG+iLaNlfA2Q72goxsywRBVZOi4mlKr0+x5OtSApL?=
 =?us-ascii?Q?sKznxxmVyyFon2cIidxdeCsG0Ul1I9TQ+J+6/Xfs8GmOs+tBPYHKwXyP2vhE?=
 =?us-ascii?Q?ExJKZifsOr4nT2h7CP3Jj/Wbt52QB3eJnVAKRJXe0qi4n8HF9bcxPTJyEC3j?=
 =?us-ascii?Q?+q+2+z1NV1EmYBWkc61Ay224ubgY7RJMDK+Asei1mPMd7zVXMIWE5QFQkIcM?=
 =?us-ascii?Q?D2PeL7obAZsL/rTpuaT0z54MevS/X/wewGD+4lk00UK7rNioq3mvYgznZ3kt?=
 =?us-ascii?Q?jXd8uigKw8VXr3SIG/p6YqoyDBqnlEEnPsNTsEO806PkepoqOvYKRzCOQiS/?=
 =?us-ascii?Q?HwX4XwPAW5yJjnG4/1dvJLfWj9DGNld90U0+WR4UGrTOUXDxmYMGIFssOc6a?=
 =?us-ascii?Q?X0HlblGokt/sCpdd45OdehF2Yh0h0NDcDWXzszZ3HCMvUzzoEw5n3Fzoc4J3?=
 =?us-ascii?Q?kydyuqiwsbuRkJV/icYX6b0Y/31Ux60yoNFiQLpZ1+Pq+Hipldl3FiEStOMN?=
 =?us-ascii?Q?SLeip57Kmu1iM19BwUA+Vx1Uo2BBjwsM7tOJYZexl/zuqFWhXf/JVw+e9Srm?=
 =?us-ascii?Q?LUBgLXbfgz+OZIupBRYRmCM3IhhVrX+yW/29BGhmjNwdQHMQoK31Vq6XrHYa?=
 =?us-ascii?Q?DnmX4EAFAjV1FDVUCnIFI8YLbV6PmDPF5J98g5+Hlg3Oar2DphQx9PGjyV1r?=
 =?us-ascii?Q?FSU3/wwvdWwWk6mo5pKNhXdnLtrTy0tEMTIuWKu760lR/T5d+taBQ9BJeooX?=
 =?us-ascii?Q?p5TyTUFYv6SmqccW5yJdXYatfY2/BNnKQTxd9bWiLWxiEcOhqcxdyRH7uwQA?=
 =?us-ascii?Q?kBOUCY3P0QrgWNsbUItNULbY82R0QwFnIp+drvJ7mZZZMZ8JWN0aTk6OSxmn?=
 =?us-ascii?Q?VKRghWW6t1+3ayfYUPlwKKyfwGyS8vQeAk/GIB+E/IZDsq9PEdfSjumIghid?=
 =?us-ascii?Q?p2lQ2Qicxk9uaT0AUig1FJK2bzeeWHtyoU+q8yN/DdMiVcAU2t9HpGW4xBJX?=
 =?us-ascii?Q?2B70YWRXA4Msm4y7CLwdX+NzswM0cqW4leWPLhD6eljn96lxxd1x5MM+KDZr?=
 =?us-ascii?Q?GY1B0hKiSIlvcRn7X4a6pooUwI63QRP3soyM/n+FYQXUwhYPMppEznG3QPS/?=
 =?us-ascii?Q?+hCA4b8hHPPNIIYoPeZqxROhbmgw47jy1kpRbDaKxgyk+GoWRjfNe9jQ8/OK?=
 =?us-ascii?Q?UZnUxTUPhjiwm4i3cPzUuNYzUmi/IihdxjMAVVRxR2RFr2WT8CkDQ254A9mJ?=
 =?us-ascii?Q?cilUZGdqld5G1jEQ8mWJT9gVtQ9gw5GazTvUOJVVfoCpPntkOv+DXn+4p0x5?=
 =?us-ascii?Q?Mq+GUta1y8OJmwjdzglqXOoyo9awQg0KvFGq3KYNW1PBhNpfyorXVTSTSU39?=
 =?us-ascii?Q?podvJt9+ImjDGLInAWwJy9Ee4KI9/EN/BlwJB1Am7kmr+SOHI0Zhp0dgo2Pj?=
 =?us-ascii?Q?+4UoIHiK3Y2zE73uHfa0JoUVbOUgm2E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f3d9ab-cb6f-4635-29a4-08def8123e9a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:37:17.7316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txyq+O1MJZ9ZhYjbzyJjcOzkqDMtjEGgMSYZFVBKYxT8BJfVtwAG4Qd/QnGsglYgy4WQgLw+WU4c3cu72zlfyXjrOQCSJs+VR51ZnOTwmPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7871
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Provide verified instructions for U-Boot and direct Linux boot using
Buildroot images.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 docs/system/arm/mcimx6ul-evk.rst | 67 ++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
index 8871138ab3..84331b734d 100644
--- a/docs/system/arm/mcimx6ul-evk.rst
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -3,3 +3,70 @@ NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
 
 The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
 MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
+
+Booting Buildroot images
+------------------------
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make imx6ulevk_defconfig
+  $ make
+
+The following examples use images generated by Buildroot::
+
+  IMAGES=/path/to/buildroot/output/images
+  QEMU_BUILD=/path/to/qemu/build
+
+The generated raw ``sdcard.img`` is about 84 MiB, which is not a capacity
+supported by QEMU's SD card model. Resize the image in place to 128 MiB::
+
+  "$QEMU_BUILD/qemu-img" resize -f raw "$IMAGES/sdcard.img" 128M
+
+This modifies the Buildroot output image; rebuilding the image restores its
+original size.
+
+The SD card must be attached to USDHC2 with ``index=1``. It is consequently
+named ``mmc1`` by U-Boot and ``mmcblk1`` by Linux. The first partition contains
+the kernel and device tree, while the second partition contains the root file
+system.
+
+U-Boot boot
+~~~~~~~~~~~
+
+The machine does not model the i.MX6UL Boot ROM or its SPL loading sequence.
+Load U-Boot proper at its linked address::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -device loader,file="$IMAGES/u-boot.bin",addr=0x87800000,cpu-num=0 \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
+
+The default Buildroot U-Boot environment selects ``mmc1``, loads ``zImage``
+and ``imx6ul-14x14-evk.dtb`` from the first partition, and starts Linux with
+``/dev/mmcblk1p2`` as the root file system. A ``bad CRC`` warning while loading
+an uninitialized persistent U-Boot environment is expected; U-Boot continues
+with its compiled-in defaults.
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+QEMU can load the Buildroot kernel and device tree directly. The kernel then
+mounts the second SD card partition as its root file system::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -kernel "$IMAGES/zImage" \
+      -dtb "$IMAGES/imx6ul-14x14-evk.dtb" \
+      -append "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw" \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
-- 
2.53.0



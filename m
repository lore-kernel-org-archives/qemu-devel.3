Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A6C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxu6-00082M-28; Tue, 11 Aug 2026 21:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxtx-000821-AC; Tue, 11 Aug 2026 21:37:05 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxtr-0001Wg-42; Tue, 11 Aug 2026 21:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NphtXcFLOlJWvVguC74WChEp9xDiSevVxuKG9UDn6Paan6QZFNg8hOo4I+CZ+C3NlLxZ2q9hjj5Fe14PhoJ7N6o28hLkTSlmeKfVYlzilu1PtSZ/hHfyhQqZW6cFr0Q84ZofUD4p73t6gq+1mRwK1crF69QdhS7uSzSY9HF7kPiK8i2mn4/JVBnO2ntdZRPcnGl/A+PY62ArECSVKV1TC3l2h0/CpQWEILL+WaIPpzX8dqo2s7++QAleLdHgXt8xpQnqqFawgogoLYrKxuZxveMctNicWhshrLbEAGTtiptRNY/tOg7A+YDI5zmfXgur0x5sFJDGI7O6bgyxxrxoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iborxq8amUwMZjFLJ+VkQN7n3BXXlTHzwKY6CEq1c+w=;
 b=tfFXhfu5WgtTtnoabEWJFA24QfA+f6snBUXpWqD7dmIvoASjaolgK0HcrS3/KebfXfuoFPYizrAz3J9/b2+PTNAfV91o11olrcd0GyLOrmZHtQymEPT3ndwbcTlO9NMKWmuB11c0/gYGlD37xdQ2PhdTlDbCd1Dwyf2EsIg6D/xy1rGGVdFxqFdASD7Ij1KlJzhlTnNhylpejQxrTsYFXDBw491DSbxe+Bji+bhYtjilb6DXrAZfquaefJRGs+WtABXDpeWUJ82xVvs+HUKBLtIocjWD7biKjlv9i7YdrwSWPTzxmjnVSwWOWSDuj7l/orfdOmTJkombwWwMUdc5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iborxq8amUwMZjFLJ+VkQN7n3BXXlTHzwKY6CEq1c+w=;
 b=EDwLOCIZYbyx07oiVXYCsAli4YvbVDKnU1hSof+QVC0rpAxkR2BTaIzWtE93x8a6BzFzXxS5Ou489hJlQqD3N8SpNH3K90aVJmqSmHxDAAqL0+C/mJctl5HnkTnnyyXq0GpAeT3vHdF8ujFIGhxFXmJU+NPlFFl5xAxdfqQkUNpoMuoiZtxpAJ7sThDeMaykr9WXvdvK+bpdUdDMHtUDA0F4gWPUC73e1LqTfXxhz00sd0jWDJOB+dV4294L11/Yxi62yLfRf2E2AkB6MHMYH/cZXm2YjE74zEc8M/6Usq/PeAkmdTxjJyA87+9t3Pq3lvG+qe9cksF/IkiId+teWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9309.apcprd02.prod.outlook.com (2603:1096:d10:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 01:36:44 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:36:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
Date: Wed, 12 Aug 2026 09:36:03 +0800
Message-ID: <20260812013619.2134092-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cd3c56-dcdd-4765-5fc6-08def8122a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: rmgMlep/gUn3es+Mf9Yj9+AR+ku9OnWdiSLBS/RKXO6CI1KVcAcPKahRyTHiWw9m5NvGRjCF6AJO9KneFVISK06yYrAH8os2IZlN2lX4RNKi9Kug/LVSivjDgqyJEiKX6BkPrT+eU9/WWBeJYudqQHFk9Fqn39AW5gCoz3q9YUEXgHicXBzwQqWMkp91UdYHLzToHDxDUWx0BJjJS8zXEk5G1/pQBoyZLnRILjGMdj//oYzOvNZ1d4g+pr0zeiypJVHnv9WQgMCIWnxvk4FXT7VBAiBxNU3HsvM9u2lAEFyyaHPr/MkljXWrPqRtdr+i+3jYoaNHCCvml02RGY6svQ5DLQVYP8DEzCv5iev5ngL3eoKpN9BOmtm4+2T3sX4Jv+H2eW3ocKwYbWd9twts8tIiCOhauh1+aMUdIaF+Y5oenvq+DmvvHVSDehIgDOMN88zsh+Uo8bhanMc0BCNvEl5cxZ4TW41TRT7hiCO0624DVEFgX3Ko4jpUvGa1aBszD7e8czfNdu00oR9AFCxjF3tBl0jHkl4MT1xI1cJTfuBVVWORvcgCvW6xmqTKeIpXnvPd24+qOxu9DCfQ4nb+iru9LxQJ0MeedEYLdMKfPIm6g7GEnKwrE7rbVcR3QXDSCEpGCSmmh8CZly5PDBOls5kPMhR5ZbEBsxOUp5QX8Gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?viQgZ3IKD30/ajQCBDQgKr9OAFaZR5+rYDf8gXXMEkXz38XlJimR0L4VldzI?=
 =?us-ascii?Q?4S0pVv6fp45YTPQL9CyQ969K/1q1yuaNVj285h0P+LXdyo7FpVeh4eKwFt2x?=
 =?us-ascii?Q?kPgfmKhMppyLr4nAPG1OgA+/Pul6L6WKimpefQmAzyDJ/KtG8G7sZgvQN0qB?=
 =?us-ascii?Q?EWSsX5vbzH7zud5U3iEewqnURBtt13pem+TYZCup1qnlXbmTiqpImD4jRoxP?=
 =?us-ascii?Q?cQQRpCaZnc4udD3pZ0f6lFZ3VL93xNWh2/plD33gZmDE/AWLi48kKqkMWwfR?=
 =?us-ascii?Q?SPxCkhnPiWJU5idqsKlJqSg1CzzXAWREkXLasB34fKnEhuj21sWKnKzKFNRd?=
 =?us-ascii?Q?AtDp6WECYSh2wSEbyb1gYkJ7xge5a0XL7aoixmP5p0JPeJBEj7oRtBjtXRHs?=
 =?us-ascii?Q?IpeTjXNoFCUn+OcydSODRZnibYQDB4QLKc4wzY5wErrI252LYn8aL5wSP3Qb?=
 =?us-ascii?Q?ghXlbYQEhv6dBxQa+AHJz0B/6aaqbj1KK8MxDgRf0vLECUbaUzCGgn4x6aB5?=
 =?us-ascii?Q?DKZaErfwhWHl7i/DktOhTdL2IIFFjl+LvKCEbAs/00sLht41o3/x1oLF8mui?=
 =?us-ascii?Q?i2sAtC8TVzQbXD2Sg5rkkiueFMuHVEpjilcvw0x6IIHpfKKzDKAARR6Teh4v?=
 =?us-ascii?Q?LoZBUVmPCYPSEAeQm99GdorVIyOG3qJz1Rv3IMrcVANtBgGKJS+cFqIPL3FF?=
 =?us-ascii?Q?PRYOKEv4KyX2Gz0VeGjKJKNPa0TphUzYdLuQSD+gPglx8VgzOYlPdMjfsuQ6?=
 =?us-ascii?Q?k2M5S50UnlorY+VWtd1TXRizj03IGnP/ZGU/7ZnJhWN6wcLe11il2hvaIhWj?=
 =?us-ascii?Q?zHH4hQbh8Sn2OMcszdKU3WOFFq5ZifP8cP3IhtT2Jq1UqleohhhEdzKUlTFK?=
 =?us-ascii?Q?KfsEefOG5lVE95e5HFHj53ODcTz2zjpOME08unZix4pIy3XV0g/AHAmEtNqp?=
 =?us-ascii?Q?FLGlOXifdlUXWnRlX40+rZB50W7tDh+kAAegyLcJgxHibP7qh6RaBsE0DyVH?=
 =?us-ascii?Q?9Pgryy4+zQVOXdzrutG4PP8QkEj07MvfDBmMuZjT8fygNavrHEAL4P6uGImd?=
 =?us-ascii?Q?RgHcvJxcGOT0bpYffj5qYvAJFQ0WEs/cbhkxectcGRF6s2pwl2s2OOHfsOw6?=
 =?us-ascii?Q?HolkYDrfw2wpNGrgISLAfBGtJlY0ZLy5bEvs/25+QH//t2l6LGn98T1X7Lp2?=
 =?us-ascii?Q?DSfZwLmiI6hVgFRaQW4572wymOUnfcN19SOpOdin1vxlUluLDd6+zFsxFKzd?=
 =?us-ascii?Q?FBo1Z+NxXizq5ghX1DJ32fzzV3DZgW9jop+LZxSu6/aF9McXlHBUIXxTMYRb?=
 =?us-ascii?Q?3pB6vLgFxMQNC+7va0gz36Vvo4+MiAzoZb6VE5aOuCk8q9ZAoqCUt2kSBXgt?=
 =?us-ascii?Q?fnFFb+epPA2OR6cDrYn1sKYDDNPojkq4i3KBxkbhctjYKbRCJ+Idqz/5UgpW?=
 =?us-ascii?Q?csLMxqW01WBJb/qNS2CW5K8sqcAIi7GQtRHca6cqHYm4zPyr/Mnepm1Bx5W7?=
 =?us-ascii?Q?Ovc69qbtY8k7UOgRXMpqUruYG3Nr88/8MDiKLNFnvunNu2fjBkesCq1b2wZl?=
 =?us-ascii?Q?zOp2Qgh88oq3se/P4XcODmViMFuKSzMijKAKejz0sTnEfvYjx9QhOHMl3nN+?=
 =?us-ascii?Q?a7Q0DwW4X+usHyrRzII6OY96o7JaZ6c2HeqwQx29bCo8k7OcdpouaWzn6Kks?=
 =?us-ascii?Q?DyXKRAan7z5fSEMiEIIoklvS+4LmFTgFMxj1CFDI+AAOzLFrhU2Xde2h8G2F?=
 =?us-ascii?Q?lxnedUpLR6bmLewtnFVs/SsEqeJCNEs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cd3c56-dcdd-4765-5fc6-08def8122a31
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:36:43.7195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sjSel4MRibio2Dcib2QXIRMqlvFL5WcCwp6lKnsp5yTqrmCPpznQTFJttne5cgazP0PMO+4juVIzfR75fS914ls6q3cYG7LrSB4N+0pUP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9309
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


The mcimx6ul-evk machine can boot Linux directly, but it cannot run the
U-Boot proper produced by Buildroot far enough to load a kernel from its
SD card. Early U-Boot boot test accesses currently abort or observe
placeholder values, and the i.MX uSDHC model exposes several issues.

This series lets an unmodified Buildroot 2026.05 U-Boot 2024.07 image
run on mcimx6ul-evk, load zImage and imx6ul-14x14-evk.dtb from USDHC2,
start Linux, mount the SD card root file system, and reach the Buildroot
login prompt. It also documents and tests the existing direct Linux boot
path.

Patches 1 through 4 provide the minimum early-firmware-visible state.
Patches 5 through 8 address i.MX uSDHC behavior needed by U-Boot. The
last two patches document both boot paths and add functional tests for
U-Boot and direct Linux boot.


Bin Meng (10):
  hw/arm: fsl-imx6ul: Add SCU compatibility window
  hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
  hw/arm: fsl-imx6ul: Map early firmware register placeholders
  hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
  hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
  hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
  hw/sd: sdhci: Preserve uSDHC status enables for U-Boot
  hw/sd: sdhci: Skip SDMA boundary stops for i.MX uSDHC
  docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
  tests/functional/arm: Add MCIMX6UL-EVK boot tests

 MAINTAINERS                               |  1 +
 docs/system/arm/mcimx6ul-evk.rst          | 67 +++++++++++++++++
 hw/arm/fsl-imx6ul.c                       | 87 +++++++++++++++++++++-
 hw/arm/mcimx6ul-evk.c                     |  2 +
 hw/misc/imx6ul_ccm.c                      |  2 +-
 hw/sd/sdhci.c                             | 89 +++++++++++++++++++----
 include/hw/arm/fsl-imx6ul.h               |  2 +
 include/hw/sd/sdhci.h                     | 15 +++-
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 70 ++++++++++++++++++
 10 files changed, 315 insertions(+), 22 deletions(-)
 create mode 100644 tests/functional/arm/test_mcimx6ul_evk.py

---
base-commit: e8d693e12af9cbb89d724baadfcc08559669e279
branch: imx6ul-evk

-- 
2.53.0



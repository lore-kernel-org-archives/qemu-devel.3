Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EFAC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 15:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdVG8-0007BH-V6; Sat, 27 Jun 2026 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdVG5-0007Ax-5J; Sat, 27 Jun 2026 11:47:54 -0400
Received: from mail-japaneastazon11023096.outbound.protection.outlook.com
 ([52.101.127.96] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wdVG3-0006ta-ER; Sat, 27 Jun 2026 11:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vczRgXiqFfVdkFvRtjJwo4hAzx2tVtcldLYeGGyMSjxwOy2cQ7NsvQ2lXYNht0B8khhFT6PjOl5tjBkz24bmI50mfutL4yUuXH7Dew0G3evXneFQ0ZCB3+jXolQkSV4mB4slB0sS/NZp7d/KAtLhQNQSUN9ta0jklad40yC+VKv6I9+3c4uvZG5V38hB2TuswIs4CfbPe2/3errR+zPDFG57uBMbs0IpHdwBUBAINAoX2b3l9W0Qx8qk0y0ZnpOx5QfAwEPciroUd1Ft57+A97nPGPYvHsDH1ERw1jybRAf8LRfNShIBAkzqOg5Lb4VXXQY4Z1W3AqpXChS6QyfYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1A6ooFDxDsmDBVl7x4X1GLMztYUV7EixW2j1kKSpqM=;
 b=TelS9Hq+p/r7GLzjd0wM4iwaPt1+JzNS+F2fbVSiN4Y1cELByWfYYpHcNdEAo9pJvB+5RKn73edTix7rGoz3UgQMMrAvHM9oo9f5OWN28Mn5GTeBt1Yo9Z4UQWd/9+Lxi4Rz6noKZ0yDJEn8eGGGdqV8CsrrWZwxwgHVqLuZ6lEejUknmqRSx+ZjeB2rxi6ts40Q75XhD+NskZr1Gp9WRRMRbHvpN+BRqVpIfiuL+Iy03AiUD+1l7cPxf/Th5so2YsHahIop/0KNe5gJhbePCQ+M4jfFM7JU5+FsmWGE/Tss1IAAJ9VleQHnTlzxBc9tT79jNFkhMW+5A1l4U3xkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1A6ooFDxDsmDBVl7x4X1GLMztYUV7EixW2j1kKSpqM=;
 b=mXsiX+jp83rlbHhKqHwjxXvjhwukWFDnDbveotMCynwIPBbdc7+0jhMn1QMBaYCA0F6n7o+vY4XbpNxiv65rJInpsvhXqtehaNe9W1SqRSqZfoSm7759/Dd0p02IKV/ng4cuNHeZcmfs/Q+Vmv8dsChN8uC0wDdsFsGZD6FibhzDYtn0AsEsnxz5OL0FrsPQ/9faVrvqMacPaD2vOlrbnTCaRAuf/BybwPKI9EpUu23yhw6fb7x/Rg78TFLAuhanhb08Knd4C5tS2ufTiNJy99MtaUTBtjxwyPT3iGfaunaugArt41gFwtwnGWG8qz2woRuILWhdnsprU6dE0AuokQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSQPR02MB8797.apcprd02.prod.outlook.com (2603:1096:604:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 15:42:43 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 15:42:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH 0/1] hw/arm: Make xlnx-zcu102 direct Linux boot usable
Date: Sat, 27 Jun 2026 23:42:24 +0800
Message-Id: <20260627154225.863984-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:4:297::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSQPR02MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b6110c-8c48-4ee3-ad91-08ded462b98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|23010399003|366016|586017|376014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: PdD8XZBwJEyrnVV0fP5g6CyF4HypNi5oO2904ziDffaoi2Mehy8k5BRX/UZMIPlpwY50+8CPbGygJjEaQNcY+mbViZvlPiHipJI5eECTrrYjMf5Sg3r+ZUlUpkgWA0DHW3BxX3r7DmX6L3V98mOYzYfgZFvJfA+UpK3LGU8ggmURaZyfoenmfNfioZDPq7ciquMr1Ejl/AIN7uAScdNS4kyar4Fw0+imffRKGljHfd7odsvxqwNooCNC1Y7fQiIjL+2E8kGFoyJb5Tfx1yxpyL7lgomc7fkfibGGSBNIqJcF+Pu9q8OYpUJ7TB/zxiI/Ltq5urUpgBAJKPNxlCFbo18epOOc9z/Gl7yjnmjTWeIpZ5REg6XEsYQHX+/RqrlBBmtqACgaNWXAWIpBs2+W4pd2YsxQlsKLu6gOpjE8xz0eLXbeSFXF+wNgs1cNX7ArJ1G8KadDFohWMX8l8lHF2ua8ufEKMySHMVqwwr2BVelWwnWpr3pXWvlk9PMx91/4ANPkVWXAipvhdw7TjPJzN+bPUryMNp/jFOYreqIxK6J3BVxB9akCFGjgUy4X3Licn1lNRmjvDAWEH/F4UCiqaU1NTMGZfDwcAb4JZW54I+9A/zw/70Uj0peTVrNRmU5Nr1YlzVrXEVePGFAANyJopq7H2M3GLr/G9u/U7FeC5go=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(23010399003)(366016)(586017)(376014)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z67VScpOS/ogUXAqR7qxjp/Q5uK2TOhjyJq0JPbuJnYLrGKalWfSrRFGL5Ob?=
 =?us-ascii?Q?yHJDrtduJ1RtfzWYsW9Vgn0WCuBzX/UntPHxFYzxgRFpvVr9ECXCYGWxevbq?=
 =?us-ascii?Q?qav/hRN2niA0K9rlz/VGFjgwR8+xzH7QSdQyyINu5f1ckUlcMsdq79d3X5yB?=
 =?us-ascii?Q?13/UI3YvMziAOCRxqfyp3Lp6+ZRl6gjvAaWOHgk+16o8bHld9Qdf3lYqJ9tq?=
 =?us-ascii?Q?tGquXAiSc/QF53J1Qq6G96tJKjuJySKf6w+BMq17RRaUiH8osxuU0opcsjbj?=
 =?us-ascii?Q?BAkQJ/ymAlJB/mFpMx7IkIhO60R7J3wCuoho6ohHKxxOZI9O7P0gpY0uA40r?=
 =?us-ascii?Q?F1+tXDR/QKcKWFoUsSCMsk4NX66nNHdQQf4zhKxxCe4KtKnR1y9EkLJVFQeP?=
 =?us-ascii?Q?7S1V32EtnO07eH79WsEGdsSRYcU/7iARziCGNSk9FO3GXLkC9fRqYWhTHr3B?=
 =?us-ascii?Q?tdLqjA084nmIjgkAa60TqaA7kFz0mZkVSDCuIL2DbcU3eMCzXoZ6ysoVqUSC?=
 =?us-ascii?Q?zEmf0YvZ3rOCGFzWqXMp4tlGWS0CHituv79NX9I6AeGA72FgEAUeOatz2HaZ?=
 =?us-ascii?Q?TSq4FiNrSoDFk9lkxJLR4Mh5MazoSZKUWHqkfoGooeJcJTYJCyptTSdu3ZBl?=
 =?us-ascii?Q?TvmFWidkZ14vXe9pB4QB7VtBUtuYu6k/lA4raaK7uZYpiV07yVY0aUw2C3SQ?=
 =?us-ascii?Q?AVYIwxqwMPJNCERRKRbgYqq6h1/6XLCBt9WBT1S/9Fc7HeItUoauEySgtflr?=
 =?us-ascii?Q?3uq1po/lHST4c0DHSRNTONEfZA2E9AMR+fOLB5tv1WT4H2hKERiRZL3HceZf?=
 =?us-ascii?Q?viI3cH7rPNVyv4vNxu17NMrTLFa1vkqqf+mrnBjBxAw3hn2RpLlil9mEMpPe?=
 =?us-ascii?Q?/0xhHTzX+UGwr8R+WYtq5XXmXCBitAPO8T8ONZVR5qCzoMIEZn7DuoCMBjAz?=
 =?us-ascii?Q?n8oM8D1/d5tGM+jNRNO1y+BavuhEbsGtkHWoEFUTWtelaxplurWxurpX4IBa?=
 =?us-ascii?Q?uL2SAtRxNOjBHh7pbq9+LXbSPz23Jjdizmgy2Rg8pAY42cpK0M3L1S8roIxd?=
 =?us-ascii?Q?9hDiYLKeKx8juEm2UkWLzNwHbQoprhAzG0V7NleNJCPI2cE50xTZhnpziAoj?=
 =?us-ascii?Q?hT2AgwJNaQJwAf2oz3i9no3k1CCE6DEnHjVc9IFd+BZOv2NnLZ4m1oP3PxmT?=
 =?us-ascii?Q?cXknbC62DnytTm1aFCYDLfTAp/eL3RhQn2Gn0+PBVM0cR+AijOY5pyL07e0M?=
 =?us-ascii?Q?ZdedRTAVGrambrbPdHewpwogSi7pLVuJugGs4qtJbxcaD37wVVqZCi0S07I0?=
 =?us-ascii?Q?HE8jdIbIfiYANAkfvCPTW4W+Q5X/eURAjFXMCIW9ktdsL/a8d0R2SACSyxn3?=
 =?us-ascii?Q?30uG6QLgIDviaY2JqhS/rbI5qT+nECTlNNYZnDes5/0twCeZuU4UXSMvJxgY?=
 =?us-ascii?Q?po58fQ3bo+qNIBmU51w/nz33BLJ+IAHint8mg1V0j3n2jEqC8ys4Hp13pJCa?=
 =?us-ascii?Q?ZkhttjegfKu9WUu9x3GbZBVDdz3BHHIQ1313Qu0/Jl2pd9V5mR7DOPCPccGM?=
 =?us-ascii?Q?JNbIaMPMvfxkJHwZ43stmFXzbp3lUOkifo1sJFOLZCDQ4kpa5WeMLLonR+wu?=
 =?us-ascii?Q?VoqbqWxI1RBmSuB3yDgKCFZgazLPScp9Lw8KqrLR+9kFh27eH5bp6FRwh5Fh?=
 =?us-ascii?Q?+JLISj23cyamzOV1994IrFs3ytz7vZCB895nk+3MCkzBMTm5CAia0DjC9KAT?=
 =?us-ascii?Q?UAxhr6gWbzBfNQGGvclqvWxT6QAMT94=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6110c-8c48-4ee3-ad91-08ded462b98d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 15:42:42.0425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL//lI56zX255o4F4GfE5FIWuVlrsBrMDRf9CiglV2a/GjSfhu8u9d0c32cuurWKLjPn/sHH3UmPlPjCV/OL77Dinxjfx1NOdQrZC1YmX3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB8797
Received-SPF: pass client-ip=52.101.127.96;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


The current xlnx-zcu102 system documentation does not provide a practical
way to boot a real Linux image on the machine. That makes the board hard
to use as a regression target, especially for changes in devices that are
already modelled by QEMU but normally depend on the ZynqMP firmware stack
when described by a real-board DTB.

This patch documents a direct Linux boot flow using Buildroot's ZCU102
defconfig, the generated kernel Image, the generated real-board DTB, an
SD root filesystem image, and an optional QSPI flash image. It also adds
a small DTB fix-up for direct kernel boot so that the boot-critical UART,
SDHCI, and GQSPI nodes do not require the runtime ZynqMP PM firmware
providers for clocks, resets, power domains, or pin control.

The main motivation is to have a reproducible way to validate future
changes to the ZynqMP GQSPI model. With this flow, Linux can probe the
GQSPI controller and discover the SPI NOR flash and its fixed partitions
without requiring a full FSBL/PMUFW/TF-A/U-Boot boot chain. The same
boot also verifies that the UART console and SD root filesystem path still
work with the real-board DTB.

This is intentionally not a complete emulation of the ZynqMP firmware
environment. Non-boot devices in the ZCU102 DTB may still depend on
board peripherals, external clock chips, firmware services, or power and
pin-control providers that QEMU does not model. The fix-up is limited to
the devices needed for the documented direct boot and GQSPI validation
path.

Tested with Buildroot 2026.05 release. The guest reaches the Buildroot
login prompt, probes the SD root filesystem, and detects the GQSPI SPI
NOR flash and its fixed partitions.


Bin Meng (1):
  hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot

 docs/system/arm/xlnx-zcu102.rst | 139 +++++++++++++++++++++++++++++++-
 hw/arm/xlnx-zcu102.c            | 109 +++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 1 deletion(-)

-- 
2.34.1



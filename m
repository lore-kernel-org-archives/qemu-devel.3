Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BE9CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD38u-00077x-JR; Sat, 03 Oct 2026 13:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38i-00076T-VU; Sat, 03 Oct 2026 13:03:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38f-00075o-V0; Sat, 03 Oct 2026 13:03:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6rtouMwkTGEFYOENsethBcTrNtcNWTYkWX9j6jGxEVByK0qaOq1XAsUwn+BdSYVVcHh4NyNsmtCzS399Kpa8dbTGHZzrNRJolOrEqTUlpmpbvg53KK3f3tYMQBbkbFTZIXpkRf3aANjogkRJRAg2XZVyCzFdxEA3eDAhjtrlfw7PZIuK9BHkANtCyP0Tx+5zAim7nWy0P3qTfMdNAH+pCiaOce2GSWB+7mVABQJIJTubfSPVq5x9nrwcsrK5caXC0PnJaDWXv7xwnOwoQdWRsgdjH2lHztD2LqJiVum6Kc13V7xhCUfcmqYAtbbzvkpKOBsAqfeRgQPqqZsRPQ4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcZzfHViAZnY7p0YOBTnBsYh9c9CLIcbM/sMSkdYeWI=;
 b=QNrifDuq7BiND+jUXEfVayR0VMnyfH/VDPzQBD990gySGc0Y0BzB0SvQy1ZNTuWbrUBw9hvZzmjh3jMXYVlcTQ2oxAB3UFxWp47z0SorouVh3WxBtZ2vpKhNMsUomwVqwRcZYgDo52freaDGp+AqAe+zHX6VCgYFaiI3m5l+NmwuaXqjLfQ4KFrk8of40RCtGJfUEKC5dtDYTy+W/Et0ekTN4MIaixzaod8FvfzhsLSPnvdmke3+JBfFNLPtj5oIckYKyzzqQdQgulgmnxtwlS/l051bfI7SoyzWkJvGmirpPCY3wxb3b5232TlvcW1NXc8YNegIWoLZ+qRm/uKYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcZzfHViAZnY7p0YOBTnBsYh9c9CLIcbM/sMSkdYeWI=;
 b=JBV+lfl0Gvtxs5D3ZFWP+xOrm3+VllDTZ25r1nJRS8HQu3uuwEoodom86be0KYV7V7AxiwsfYuzlj+hmk50yZ3dqX/ofrzIl8Jqox2GnmsOQTHlzbT6VaoIVIeiT7JpemzXcQdL5Z3r73KDmt+ZScDepeCiBMJUuO0nOxXaJdyC6R7AvzExDrVZ64++/fWMokrdo6m9S3VlASPMfSUEeiZd2VHh0Iz9vvH58DfnH3DIGR+ju8v8oQVfrfCizlHYeq5GYme6xPmL9+RuYLP618A/jZIsqHuHdnBhtq3AGmcdCoKNLWohyMRgsf7rf+rgfASTxezGfbmyswfdrJ+HWBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:02 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 03/27] hw/misc: pfsoc: Support DDR training with newer HSS
Date: Sun,  4 Oct 2026 01:01:53 +0800
Message-ID: <20261003170232.2450916-4-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fb1745-9bc4-4298-b27c-08df21702eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: avVTbRcCB5husJH9k1i1HeYqOXp7BF41qQ3GXgTt+4yxL/rjmQAwJH2ZmhqoxS7Qx5+YcaRfhXnuZzPlIvPoallt6R6WoOBy+ssdFwsKuTiI3L3T+NsEoCm/eXG7hvBJrywNsTaN3Aw9AgZhaZZ+xzFw+dXOtntaz3kjAcjFNhz/hMYQlkY8q9DGN99RFB1fLMlXp4bVYlTWhxwTjTiss9Dnr0wPgvbTycyn/8GelDVOUWD43YykTQ069mQF5L8vPRV2M4jJapow7cXrE9XWo34Fb+HGW1e6oZ725xQdmdIazP20nZhwt1UyNwLjfdKr0J8Dr6WPHdULd1DdEPtGtPYaNA63UYPP1UdoVGF2DWgrWx5dqpn3hQS8HfV9BtruaaWYNX6KGivJJWajfmpJ0BHC22GqO+I6VzZDsiicgBXtIU06J/xkV5QLi8TKEPRg1VP1jSAZYboj8xm5IN9Cwbq/FNKgd6guAMEyn3TqihWbt/sw2C08qF2UChW+o81GG6I05L8b0vgB/m/AdBQe2ON9MTCALMcPWKx38Lh0oY1c+vtA8Xyn3crlF/0PkHM508AplE2VCSoyEIvmOzO53X5XebiRCX9Dnl3zn1t4B/4ee9hl5i5aUpr56D76WgYei75Rl/F/2JgGby1ZNTPkyi7N1N7vIogrUVYZFHJLfWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6tcoe8rpnlamDEmmrH9gFUUlL6nfQi4s7sMdsVt/+tYHkrMiHXk63FH6nLm?=
 =?us-ascii?Q?cUwaRbj1sPH1FUvpe78h8NYNp915CBPjza1z/Q9shdk/rYIDw+OBPUKrW78u?=
 =?us-ascii?Q?cJanBz/2KmFitTLh/YpPp5rEru01vsKX7XFFCmhpXaVj8DyZO5ZJeGXPZtTc?=
 =?us-ascii?Q?FV9ZpJH0BMegHp/yl/vKRwuOVC6gY4zm4ezhEAfwr6ZYpFGCI3HN4BpHrg3t?=
 =?us-ascii?Q?hvoViYDZpgBinWRaBeug4iUujaF2YOyd24tQUPbif/UTV6Dh8xuiGrC3HUQW?=
 =?us-ascii?Q?9wWQ9d2jvD51frI6SU80m/rQSYM+1mDFwO22bnuHnA31eGNW9D4TkykIDDJx?=
 =?us-ascii?Q?Kb2VZmOG4YH4bCWNxAyCJgUIF6wkzo8Z+59rT8fHDFWRlZ+apLzC1ICH3J4B?=
 =?us-ascii?Q?/5JjU53pEXj1gMk2DUcGSvLTXzHM3riMGlJ1B5Xbh17P8104VT4DaLcBYag5?=
 =?us-ascii?Q?JtpxmgQMD3GDUTLw/opHT4mj6pbrP2KlCGMq4s4e+5LBaTALLKhY8VykPrXT?=
 =?us-ascii?Q?KcBtTU+hQJbO4cb1s4zg52S8OQJ9sUvsPwPJa0FrY/VCejzOdUUIOvgzDaF7?=
 =?us-ascii?Q?ZIsCM+XjX0Yxf7THHE+6uN82nyEnWjLT8xY4YD+rCi4TN3FJ+HGZBdhvfOrq?=
 =?us-ascii?Q?S6TjbD5ZgVHCG3FYqYB1xA3OB3bpSPuFx5dk+SPsuu13fj0rW6aOyrgl4Pqu?=
 =?us-ascii?Q?nqor91XS7Kxskv/wm5t//Ut58J5VUcijp8RE2H1kFlkmWsuQ0pcokBgqdand?=
 =?us-ascii?Q?d33ZCPSi3NiChnzvspTKQ9kgWoBhBGfh6ZFYxhIxCTli2F4B0cmu+SaGT6/z?=
 =?us-ascii?Q?3EimP+n0V7QmpcjFMvooR5p4B+FcsQuhkn4GH1kFoG83SFvqVoVbiEdnQ3NU?=
 =?us-ascii?Q?5XmwWLpYtmruw4z068rNbTbi1EdAwHVOyoETL91WhI5uZT4tJZr5NwTLDMfq?=
 =?us-ascii?Q?0P40SqEwR9HnYhqCJSZzHjfk41S75b4ezYAskNbeanx/q/6soxLGkIQdRJ+3?=
 =?us-ascii?Q?m0qJzjBJJ81ia2m7lBRIblUdIYEkCvJt3TAOGlkM2qXLqBuRT0lpgFgPnbBT?=
 =?us-ascii?Q?xdg1YkJ1PGUu41F7ezZswnbALDeOr17V5mPaCrjEX2SsiT8/dL2WUVU1Ygkm?=
 =?us-ascii?Q?aQuWkWzG7Ji58dOcMHBTBIq73wejGTea6R5XC42iH61Kk85I2nHGtEo5jxgC?=
 =?us-ascii?Q?NEZfb1LhWgUKTwFd7/9KuKyn15uH4Eyj0ZL8zFLsRYDFVq0IlVUW+B859X7r?=
 =?us-ascii?Q?X+yVqdiBxZCJudPyccXLLuSL03HHBh+0NDXOkoSVvpE2SiQisgYZ4mbntrtY?=
 =?us-ascii?Q?p4wZvchfF22Bn8vc6FIwRHA859qDmflL4Z7zyIwbd+mYYR/dL/xXODVAdr1X?=
 =?us-ascii?Q?x+2PU+qr5WelahE/l6e+RGzd/HJcumNPFTMKQy07KCM1NxcWUUT0vwTwzwtG?=
 =?us-ascii?Q?bQNwe2zOE3PgMxXmWtvdr1piuE7OdCDGOmurkNc9LYlIYSDvUGHjuMqbuOIb?=
 =?us-ascii?Q?YHkCYOKSsBTkE2kKgGG8nE+NprLL+r1sTkbGvRjHBb0YLcSGfqn6az8imTHM?=
 =?us-ascii?Q?maSsA+8TE4832s71e8N58BvxX7UKrLsU5/8wnR5zRzjm4xqR34E6dsvRbzad?=
 =?us-ascii?Q?3VPukqJwCTgvCEtzqPlNkqjMFKZGYe7gRVYT/+iG+VFKOxidI49G8LzWFmCj?=
 =?us-ascii?Q?Z5WmKhdaqIFaZbZZ9/EkkizV+vwO14EBZ5HGgs4JOPsGVqzyNv6heL0AmwQS?=
 =?us-ascii?Q?GxyPiU50FJMSG/NhlfUaW27s+Rd3MMQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fb1745-9bc4-4298-b27c-08df21702eec
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:01.8689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkVAzqY0nLLhHUX0LabGKuL6H0svtxPsEMqn5L5vc4evEquGl79L5OgN79KJRdQI9+taQv29QwTdpLgjRpayFg+MjZ1KrGp2SLYBtYqrFT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
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

HSS v2024.06 performs DDR and SGMII initialization through the DMC
register window before it can complete platform startup. The existing
model, which was validated against older version HSS in the early days,
exposes only a few fixed training results, so newer version HSS stalls
while waiting for PVT, PLL, DLL, ADDCMD, and verification status.

Update the DMC model by adding the minimum state and status behavior
needed by that firmware flow. Model the SGMII control registers,
main DDR PLL lock, deterministic ADDCMD transitions, and successful
gate and DQ/DQS verification. Keep training progress and writable
controls per device and clear them on reset.

These values are compatibility responses for HSS v2024.06 rather than
a cycle-accurate description of the DDR PHY. Document that limitation
in the source.

While we are here, update the license text to use the SPDX format.

Note at the time being there is an HSS bug [1] that consistenly blocks
the DDR traning from succeed when using an HSS image built from certain
version compiler like GCC 8.3.0. A patch [2] was proposed and verified
against HSS v2024.06.

[1] https://github.com/polarfire-soc/platform/issues/36
[2] https://github.com/processmission/qemu-machine-images/blob/main/
    machine/riscv64/microchip-icicle-kit/
    0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v2)

Changes in v2:
- Use the Resettable API instead of a legacy reset handler

 include/hw/misc/mchp_pfsoc_dmc.h |   6 +
 hw/misc/mchp_pfsoc_dmc.c         | 273 ++++++++++++++++++++++++++++---
 2 files changed, 255 insertions(+), 24 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_dmc.h b/include/hw/misc/mchp_pfsoc_dmc.h
index 2ed582fb8c..6a1986c2c2 100644
--- a/include/hw/misc/mchp_pfsoc_dmc.h
+++ b/include/hw/misc/mchp_pfsoc_dmc.h
@@ -28,10 +28,16 @@
 /* DDR SGMII PHY module */
 
 #define MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE   0x1000
+#define MCHP_PFSOC_DDR_SGMII_PHY_REG_NUM \
+    (MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE / sizeof(uint32_t))
 
 typedef struct MchpPfSoCDdrSgmiiPhyState {
     SysBusDevice parent;
     MemoryRegion sgmii_phy;
+    uint32_t regs[MCHP_PFSOC_DDR_SGMII_PHY_REG_NUM];
+    uint8_t training_status_bit;
+    uint8_t addcmd_tap;
+    bool addcmd_move_active;
 } MchpPfSoCDdrSgmiiPhyState;
 
 #define TYPE_MCHP_PFSOC_DDR_SGMII_PHY "mchp.pfsoc.ddr_sgmii_phy"
diff --git a/hw/misc/mchp_pfsoc_dmc.c b/hw/misc/mchp_pfsoc_dmc.c
index 1fe4535464..96440dac62 100644
--- a/hw/misc/mchp_pfsoc_dmc.c
+++ b/hw/misc/mchp_pfsoc_dmc.c
@@ -2,22 +2,20 @@
  * Microchip PolarFire SoC DDR Memory Controller module emulation
  *
  * Copyright (c) 2020 Wind River Systems, Inc.
+ * Copyright (c) 2026 Process Mission
  *
  * Author:
  *   Bin Meng <bin.meng@windriver.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
+ * Updated by Bin Meng <bin.meng@processmission.com> to support DDR
+ * training emulation for with newer version Hart Software Services,
+ * aka HSS.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * The DMC register model is based on HSS v2024.06. Its read/write
+ * behavior is the minimum needed for DDR training to complete and
+ * may not reflect actual hardware register behavior.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -29,17 +27,56 @@
 
 /* DDR SGMII PHY module */
 
-#define SGMII_PHY_IOC_REG1              0x208
-#define SGMII_PHY_TRAINING_STATUS       0x814
-#define SGMII_PHY_DQ_DQS_ERR_DONE       0x834
-#define SGMII_PHY_DQDQS_STATUS1         0x84c
-#define SGMII_PHY_PVT_STAT              0xc20
+#define PHY_ADDCMD_CK_TRANSITION_TAP              12
+#define PHY_ADDCMD_A5_TRANSITION_TAP              20
+#define PHY_ADDCMD_CK_READBACK                    5
+#define PHY_ADDCMD_A5_READBACK                    (3 << 8)
+#define PHY_GT_TXDLY_VALUE                        0x01010101
+#define PHY_DQDQS_STATUS2_VALUE                   5
+
+#define SGMII_PHY_PLL_CTRL_MAIN                   0x084
+#define SGMII_PHY_PLL_CTRL_MAIN_CONTROL_LO_MASK   0x0000007f
+#define SGMII_PHY_PLL_CTRL_MAIN_LP_REQUIRES_LOCK  BIT(24)
+#define SGMII_PHY_PLL_CTRL_MAIN_LOCK              BIT(25)
+#define SGMII_PHY_IOC_REG1                        0x208
+#define SGMII_PHY_TRAINING_STATUS                 0x814
+#define SGMII_PHY_GT_ERR_COMB                     0x81c
+#define SGMII_PHY_GT_CLK_SEL                      0x820
+#define SGMII_PHY_GT_TXDLY                        0x824
+#define SGMII_PHY_DQ_DQS_ERR_DONE                 0x834
+#define SGMII_PHY_DQDQS_STATUS1                   0x84c
+#define SGMII_PHY_DQDQS_STATUS2                   0x850
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1         0x880
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_CONTROL_MASK 0x001fffff
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_ADDCMD_MASK  0x00180000
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1         0x890
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_CONTROL_MASK 0x001fffff
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_ADDCMD_MASK  0x00180000
+#define SGMII_PHY_EXPERT_ADDCMD_LN_READBACK       0x8ac
+#define SGMII_PHY_SOFT_RESET_SGMII                0xc00
+#define SGMII_PHY_SGMII_MODE                      0xc04
+#define SGMII_PHY_PLL_CNTL                        0xc08
+#define SGMII_PHY_PLL_CNTL_LOCK                   BIT(7)
+#define SGMII_PHY_CH0_CNTL                        0xc0c
+#define SGMII_PHY_CH1_CNTL                        0xc10
+#define SGMII_PHY_RECAL_CNTL                      0xc14
+#define SGMII_PHY_RECAL_CNTL_STATUS_MASK          0xffff0000
+#define SGMII_PHY_RECAL_CNTL_LOCK                 BIT(23)
+#define SGMII_PHY_CLK_CNTL                        0xc18
+#define SGMII_PHY_DYN_CNTL                        0xc1c
+#define SGMII_PHY_PVT_STAT                        0xc20
+#define SGMII_PHY_PVT_STAT_IO_ENABLE              BIT(6)
+#define SGMII_PHY_PVT_STAT_CALIBRATED             BIT(14)
+#define SGMII_PHY_PVT_STAT_GUEST_CTRL_MASK        0xc0000000
+#define SGMII_PHY_SPARE_CNTL                      0xc24
+#define SGMII_PHY_SPARE_STAT                      0xc28
 
 static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     uint32_t val = 0;
-    static int training_status_bit;
+    MchpPfSoCDdrSgmiiPhyState *s = opaque;
+    uint32_t index = offset / sizeof(uint32_t);
 
     switch (offset) {
     case SGMII_PHY_IOC_REG1:
@@ -53,8 +90,8 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
          *
          * See ddr_setup() in mss_ddr.c in the HSS source codes.
          */
-        val = 1 << training_status_bit;
-        training_status_bit = (training_status_bit + 1) % 5;
+        val = BIT(s->training_status_bit);
+        s->training_status_bit = (s->training_status_bit + 1) % 5;
         break;
     case SGMII_PHY_DQ_DQS_ERR_DONE:
         /*
@@ -71,8 +108,106 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
         val = 0xff;
         break;
     case SGMII_PHY_PVT_STAT:
-        /* See sgmii_channel_setup() in HSS */
-        val = BIT(14) | BIT(6);
+        /*
+         * HSS polls IO enable and calibration status, then writes the
+         * calibration lock. The HSS register definitions mark bits 31:30
+         * as writable controls.
+         *
+         * See sgmii_channel_setup() in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PVT_STAT_IO_ENABLE |
+              SGMII_PHY_PVT_STAT_CALIBRATED;
+        break;
+    case SGMII_PHY_PLL_CTRL_MAIN:
+        /*
+         * HSS programs the main DDR PLL controls and polls LOCK after
+         * changing the PLL dividers during LPDDR4 manual training. The
+         * HSS register definitions mark bits 6:0 and 24 as writable.
+         *
+         * See ddr_pll_config() in mss_pll.c and
+         * lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PLL_CTRL_MAIN_LOCK;
+        break;
+    case SGMII_PHY_PLL_CNTL:
+        /*
+         * HSS programs the SGMII PLL controls and polls aro_pll0_lock.
+         *
+         * See setup_sgmii_rpc_per_config() and sgmii_channel_setup()
+         * in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PLL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_RECAL_CNTL:
+        /*
+         * HSS programs the low control half, polls sro_dll_lock, and
+         * reads sro_dll_90_code from the read-only status half.
+         *
+         * See setup_sgmii_rpc_per_config() and sgmii_channel_setup()
+         * in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_RECAL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_EXPERT_ADDCMD_LN_READBACK:
+        /*
+         * HSS pulses the ADDCMD move controls while sampling CK from
+         * bits 3:0 and A5 from bits 9:8. The transition tap positions
+         * below are deterministic QEMU model choices.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        if (s->addcmd_tap >= PHY_ADDCMD_CK_TRANSITION_TAP) {
+            val |= PHY_ADDCMD_CK_READBACK;
+        }
+        if (s->addcmd_tap >= PHY_ADDCMD_A5_TRANSITION_TAP) {
+            val |= PHY_ADDCMD_A5_READBACK;
+        }
+        break;
+    case SGMII_PHY_GT_ERR_COMB:
+    case SGMII_PHY_GT_CLK_SEL:
+        /*
+         * HSS fails DDR verification on any gate error, a zero delay
+         * selected by gt_clk_sel, or more than one zero delay byte.
+         * Model no gate errors; the all-nonzero delay below makes the
+         * deterministic clock selection immaterial.
+         *
+         * See DDR_TRAINING_IP_SM_VERIFY in ddr_setup() in mss_ddr.c
+         * in HSS.
+         */
+        val = 0;
+        break;
+    case SGMII_PHY_GT_TXDLY:
+        val = PHY_GT_TXDLY_VALUE;
+        break;
+    case SGMII_PHY_DQDQS_STATUS2:
+        /*
+         * HSS requires the calculated DQ/DQS window to be at least
+         * DQ_DQS_NUM_TAPS, which is 5. Return the minimum pass value.
+         *
+         * See DDR_TRAINING_IP_SM_VERIFY in ddr_setup() and the
+         * DQ_DQS_NUM_TAPS definition in mss_ddr.h in HSS.
+         */
+        val = PHY_DQDQS_STATUS2_VALUE;
+        break;
+    case SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1:
+    case SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1:
+    case SGMII_PHY_SOFT_RESET_SGMII:
+    case SGMII_PHY_SGMII_MODE:
+    case SGMII_PHY_CH0_CNTL:
+    case SGMII_PHY_CH1_CNTL:
+    case SGMII_PHY_CLK_CNTL:
+    case SGMII_PHY_DYN_CNTL:
+    case SGMII_PHY_SPARE_CNTL:
+    case SGMII_PHY_SPARE_STAT:
+        /*
+         * HSS programs the ADDCMD and SGMII controls and reads
+         * SPARE_STAT to classify the silicon and select eye-width
+         * thresholds.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c and the SGMII setup
+         * functions in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index];
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
@@ -87,10 +222,88 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
 static void mchp_pfsoc_ddr_sgmii_phy_write(void *opaque, hwaddr offset,
                                            uint64_t value, unsigned size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, value 0x%" PRIx64
-                  ", offset 0x%" HWADDR_PRIx ")\n",
-                  __func__, size, value, offset);
+    MchpPfSoCDdrSgmiiPhyState *s = opaque;
+    uint32_t index = offset / sizeof(uint32_t);
+
+    switch (offset) {
+    case SGMII_PHY_IOC_REG1:
+    case SGMII_PHY_TRAINING_STATUS:
+    case SGMII_PHY_GT_ERR_COMB:
+    case SGMII_PHY_GT_CLK_SEL:
+    case SGMII_PHY_GT_TXDLY:
+    case SGMII_PHY_DQ_DQS_ERR_DONE:
+    case SGMII_PHY_DQDQS_STATUS1:
+    case SGMII_PHY_DQDQS_STATUS2:
+    case SGMII_PHY_EXPERT_ADDCMD_LN_READBACK:
+    case SGMII_PHY_SPARE_STAT:
+        /*
+         * The HSS register definitions declare these status and
+         * readback registers read-only.
+         *
+         * See mss_ddr_sgmii_phy_defs.h in HSS.
+         */
+        return;
+    case SGMII_PHY_PLL_CTRL_MAIN:
+        value &= SGMII_PHY_PLL_CTRL_MAIN_CONTROL_LO_MASK |
+                 SGMII_PHY_PLL_CTRL_MAIN_LP_REQUIRES_LOCK;
+        break;
+    case SGMII_PHY_PLL_CNTL:
+        value &= ~SGMII_PHY_PLL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_RECAL_CNTL:
+        value &= ~SGMII_PHY_RECAL_CNTL_STATUS_MASK;
+        break;
+    case SGMII_PHY_PVT_STAT:
+        value &= SGMII_PHY_PVT_STAT_GUEST_CTRL_MASK;
+        break;
+    case SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1: {
+        bool active;
+
+        /*
+         * HSS pulses 0 -> 0x180000 -> 0 while scanning the ADDCMD eye.
+         * Count each rising pulse as one abstract delay tap.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        value &= SGMII_PHY_EXPERT_DLYCNT_MOVE_CONTROL_MASK;
+        active = value & SGMII_PHY_EXPERT_DLYCNT_MOVE_ADDCMD_MASK;
+        if (active && !s->addcmd_move_active &&
+            s->addcmd_tap != UINT8_MAX) {
+            s->addcmd_tap++;
+        }
+        s->addcmd_move_active = active;
+        break;
+    }
+    case SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1:
+        /*
+         * HSS pulses 0x180000 before each ADDCMD scan. Restart the
+         * abstract QEMU tap position when that load pulse is asserted.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        value &= SGMII_PHY_EXPERT_DLYCNT_LOAD_CONTROL_MASK;
+        if (value & SGMII_PHY_EXPERT_DLYCNT_LOAD_ADDCMD_MASK) {
+            s->addcmd_tap = 0;
+            s->addcmd_move_active = false;
+        }
+        break;
+    case SGMII_PHY_SOFT_RESET_SGMII:
+    case SGMII_PHY_SGMII_MODE:
+    case SGMII_PHY_CH0_CNTL:
+    case SGMII_PHY_CH1_CNTL:
+    case SGMII_PHY_CLK_CNTL:
+    case SGMII_PHY_DYN_CNTL:
+    case SGMII_PHY_SPARE_CNTL:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                      "(size %d, value 0x%" PRIx64
+                      ", offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, value, offset);
+        return;
+    }
+
+    s->regs[index] = value;
 }
 
 static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
@@ -99,6 +312,16 @@ static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void mchp_pfsoc_ddr_sgmii_phy_reset_hold(Object *obj, ResetType type)
+{
+    MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->training_status_bit = 0;
+    s->addcmd_tap = 0;
+    s->addcmd_move_active = false;
+}
+
 static void mchp_pfsoc_ddr_sgmii_phy_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(dev);
@@ -114,9 +337,11 @@ static void mchp_pfsoc_ddr_sgmii_phy_class_init(ObjectClass *klass,
                                                 const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "Microchip PolarFire SoC DDR SGMII PHY module";
     dc->realize = mchp_pfsoc_ddr_sgmii_phy_realize;
+    rc->phases.hold = mchp_pfsoc_ddr_sgmii_phy_reset_hold;
 }
 
 static const TypeInfo mchp_pfsoc_ddr_sgmii_phy_info = {
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C73DC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJO-0004JW-4l; Fri, 04 Sep 2026 11:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJN-0004Iq-0r; Fri, 04 Sep 2026 11:58:41 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJK-0004Pg-EB; Fri, 04 Sep 2026 11:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1p2pBcWIrannlefsCYSapKTbJ9ri3ZbpCrUBYM/zR1W1gwabifpeEoQOHoC2+nw06aCrVg8tK1CuhUrEI7A+ZXMaPsn8Dfxnpchhhn3c+we7eQB5Hpl6PC1gy17da7I/4rr1/ew3mT5kJcrmGsdIoCR/UPbafB58S9t4l18+T2flrQdd30N/UXS662UiyCQglLAOgoSNTXHhrWcAbuz7D4ewMlGpa/AqXnp2hwSiswkuUJcgpGZ2KFI0mHfCF+9bz7Pn8jh42n0/npGWsKmjZN6IJiWfxgGDRKvKpkef+XVzjHmEFNlqAoHN065macVxrpoN922SsByx4voJlVKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKKsDowtaLLrguYw+putM6JvNElrhXTAJy5eVxEFPHA=;
 b=T9xCynH4C8wIbsBC97qoD+wUWBR9A0k7u8YB5dVZmD5Eg9nSvmD60wRtgS/7Uutxw1GIXbn3k7yjnFUtVPVXaN9SZuwiiPUJNMF9mit8UAMhgcCopnXJ6XsgpwwpmiAVsPo/VJamiq0fOHuGc606Y6Z/F7igQsy/VnJLJBoNwzUCMOeUsdHFMNhq+9oR/1ixr/qq2lgnFMjxTDWoEqhEFE+Nnbg70gyahf7EFpATRS3xbSEPoAvLFM18Fx3CSsisxLR9Oij/ZHX/N50ll+go4lrN0FLCwz5bqMHKmzJYXETHma6bViX46q0BXRlSBV5R9gGe73pC+21lOoTlJs/eRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKKsDowtaLLrguYw+putM6JvNElrhXTAJy5eVxEFPHA=;
 b=uVH8royCIrNma3+Z0cNLkWjlRYz4p9a8kTp4Qx7KLYM22q1sQwp+X5dGQuUN7TFRq0c3tSc/4a7E58DQtIxwJNprir9/FHeTIO1x2SFnPClcU8T8GX9BL0xqUSjop62Bo9yjPydi9o1NH8fE/q9QC4Kc+2MtlrtNO7gr8IAfK0Qiby8axfr0HDvM8mOkZ2gftjKcdrsrnSpsX89qdrBfvnrhoN2dXILMrwnV2rgdoaGc0ucNH9dMNPisnM4icR5HaO/djKTtx9F8c/oyr8tamiRCsucxm5z45vhtyr17cXDTTxdbeTA4U/ZoSJVOzEtAXUuN7eRNiOQ2npDs9tK17Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:27 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 03/24] hw/misc: pfsoc: Support DDR training with newer HSS
Date: Fri,  4 Sep 2026 23:57:22 +0800
Message-ID: <20260904155758.3833179-4-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: b9198bb5-1ba1-4bc7-c64b-08df0a9d5b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|5023799004|56012099006|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: z9eIUv71EcbaxJvhfFbSVqDDP7XIKPgHTsDsvKMgfnL4ydRX9qAI0xPm23C44VJIDFjQN9/8Uk4WIpV4dUWCcvplBds9wXQ73VEwtuCsjVwxVZwn3hZS12qRYcxL1qiJYy283yeW0E2IJEdlbkHRNa0jkKMJaSISX7TO9gBqylZ9gDPLGh+kjrocKPSlH00nO25lA3KqYHlUmFC8EIISE3w+nYCh/OUg8TThtmdLXgOpxxA0PmYKns+MIlTHrd3DnBjfsTiN5yn0ducS3+75VEBwzADWcEUFNukfI9TbUJOvvg/olOsF0X7o+6Weq9C4p1TErPjTqu+SD2vfKOfHOKWVLISL2fyr71pWVhurX3qoyIWoPB1epbkP8NJ2qBSfwyLicOGiOpma+8NUbb0mOrjK3urfEh+7bKEvCl9tr0R/+Dmi/vzX20dFrbGsnAIcBI5GoVqArUCXhhJ+3y5H/OPGB4Cm+tYi+VCJ8PskpLJZQJtOwaooLr1cFsNodcPc/GHHVQbjLlxuzZy9SVNYJT+UonTvi9dSJVb6EKIN5P/itpavJqL35EbdIQOZllj9tWHvXYZ1ekoF8BsoYoJyW+e5ctM9Ata0Fgy+mB0XaoJbewV8kOYLyuBKp8JtdZAV8JtEF88WAIy5cd8kbNMMXE+OAwXxRzKwgo6x24V1GKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SPcQP7L4hNTrQ/2inMYCYRg2gfKJ88hUlnZAN9n/pK+UEozJvM5EMahZ1wvG?=
 =?us-ascii?Q?9D921IS/iY/7ipRJnuSIBcoFpXqIteSEX8qiM7FHawIjRpCwCNWONbIhwkbJ?=
 =?us-ascii?Q?otbCCd5Cagx41lzeu8yXhsb3S7+F5m0zdQAy9d/WBnCMpLr2MLSauoNCSpLV?=
 =?us-ascii?Q?wZDUYh4e+5oPTKPVWDZBEYhq1ZkkngdqFtF0rfeMl8ZCCsD5h30xhDxxD7PD?=
 =?us-ascii?Q?ummM4lT4lTu3eUPl3xR+J3dzd5MsTZbkLXhS69oG7CndExUBep2I0uBoB38/?=
 =?us-ascii?Q?sDcCCtISq0/h/DxPy3+39dVDkT28IUVI+vfBxheccQbWk1aZe0VSL95l/3/X?=
 =?us-ascii?Q?oJKBVcS34B5lDh+kboedxrLlxQwW+Epb1DGkYv47bqYksFYVZyKt5k6GqzES?=
 =?us-ascii?Q?11INHtCLST+FVr9xWtExrHo696xPFxNYk6l1XKaWSHl50zMIEpH5tcakP2UJ?=
 =?us-ascii?Q?eakTowDXJQjto/hzf9xIBW9SWdX9erqVY/DCBlQSwwwgMKfhEbDAwa7no9vb?=
 =?us-ascii?Q?BE57pqum+biWt+oNMwLISvGjzgd72g+mTfbrA0SJTqZQkLW8LiXXWSXOKDmd?=
 =?us-ascii?Q?42BbnznWiAJJDM1bMk+KbxA5NiFrjRc+k5ynQ6OOTiUjj9BBuP4IVkNLg5fT?=
 =?us-ascii?Q?WcpXzV13Hluwu6hYc9DbilOpHSu8KcCsKoM1BG37LT/x/RCK+N7aPJ0mPX08?=
 =?us-ascii?Q?UUISRm3VJlYx5O8FA2VpxrPQLm6F/9qOXULq682cPhUP8M9P/b1B1BlLxRLK?=
 =?us-ascii?Q?pHuqbo3STF+qhOp0J5h8jk6cCHqagfVHJtbP4doEQiBBQP2PXQwkNzAG0aTy?=
 =?us-ascii?Q?yw/8t3kIAthBqJ8WsQMFOjDvlooZiIPVR0MQQc16EJJLtMhsUQnj7lVC353x?=
 =?us-ascii?Q?ZIFNE6gAOXkVHfrQEuS/rgkYYvmJW1Wemomr/p6Ls6Uuh8eqTD7+sMv0Z51z?=
 =?us-ascii?Q?rvOGQuaVkK+czxMa2TQp3Z9YbrqzL/DV3Uig9Y7oB3xOdux9v81QPhz/gP4t?=
 =?us-ascii?Q?VrmE/aKt9p4ZALlv+TX+1JKXuWgJvnF5Bhucz5ElTQRzGQBArna08HhkDDKw?=
 =?us-ascii?Q?t3ndExH4GeXsk3icPOKrO0ouTN1pMI3fhSnRjMHxmqswEyGqEkPPMCtlrhlX?=
 =?us-ascii?Q?HedJYrKgS+sAuuT/VR5ihiG5IPo1FoXhy4Moc2F0M8cnujSAOtwoUoLOQz9L?=
 =?us-ascii?Q?LncAp2+FH4OtFAuM+UNTGrwSzdoRmKiia/nAYjbSNZxO05kgVmFZJKscpaRI?=
 =?us-ascii?Q?F8gnw6N+2WRSXfcKIRXki29iiihfJeV3J5H1nTHWvo9L8VYG54sgnkUnTG2q?=
 =?us-ascii?Q?KxOvNjGEkAoahabLlqZuM/JNQ92R7AaPDfYhDKF0HTHoN3p53E+sAUGbFBlk?=
 =?us-ascii?Q?awNqdNgjSp0psYJW9aBiJ1U4rEQHnyncjiXtsqs2etmkXF8/ZzbnqnptEtjY?=
 =?us-ascii?Q?9mzml+6E+tx3vWo5vway6/UsuS1y3GsPXtT25iGgslS1eoCDSAKfFwMekXPo?=
 =?us-ascii?Q?26nHBlWmbfNV/bITrZmq1NV+726bl+9te2PZpOuHjF4KaL8BHLLBkOiwZYXd?=
 =?us-ascii?Q?EZLJIrctP3yKXl0JcZXzjWZOWxO//9plDuYP9RZctPFuv7ecWsMmSxOTRzrj?=
 =?us-ascii?Q?zdv9e9ewTMHujMO+usg3/R//8FqOrvz8uI22jT0Z9EnYNhBzE34TAe/ooG8v?=
 =?us-ascii?Q?Y4sHlGe0Bxz/UtuiiGO7d+63ucqWDLVIZkmo/of9ut+m282jhzKAPZCufxwn?=
 =?us-ascii?Q?7MwprgxpdtD+lyrp7maN4Dx7EkpHqlQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9198bb5-1ba1-4bc7-c64b-08df0a9d5b4c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:26.9442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n41KXoCoeO1DB7jSnu4/YX8t7/Tm/XItpJ4PA+Kg6CHhToOe4DaAAhJAAQXeh3pdjzfDMuoGL64R1hXQnexb8VftU9lLTRlWVGJ9KlVWVUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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



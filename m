Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A3606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=QB0sIGnb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8S-0001Wt-PS; Wed, 04 Nov 2026 10:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8M-0001TQ-Fd; Wed, 04 Nov 2026 10:42:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8J-0001DQ-To; Wed, 04 Nov 2026 10:42:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IikTbvnnDBCduEEF5u2ISCyanrO+MUGT+00z1Mgmd4C5yvG5nqBfIFsmXgJ+PIwXismTbufFcE8HkpoB4h9U7gQwQH/jfkgwdbdyW9gpcShL1FQBPREOvV4A8zNaSnBukoYDtqDejoSnanFr+sMVLQFquBVxtNoOCp/8lGU+T3jHFe6mAvWtQ7QJXKF/hHjRZC0V99LcZpiz9oUxrZU2GmWzAviXHVRic5jvrNmo7N6sfWUsf7zlJgKhzWpIKf1QWlhQBqlAvfnjlnow45zZMerzqzH7jP30UmU7lW4exMeal0TS3fsdnpXYDHduUjGpJIx6fpA8oubXY9I/CoTcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZcf0Vx30rYLIbNhznbrNOSJq8qXI8aJpgHs2i5GndU=;
 b=tFDfUT2k2G+DXxg87/7owKKAX1aPQbU4SqzLca2cV1XDRy3oy3LoKh/8df3g3F7/sVacKNR67hFh8GPHfqZlK5kLsKz6Zre3gTrDZ9LNYAROqhkatdQHprbQL7o1DSuI5K5gTGzBny/54Whe860B6KnWgZM3g/ZlVqDlSyCONOMqBTi8J+DsoP8FKnRPuxe4JWfMFkcXhq0DJHR/ebhqz+p50gi3HTSc4Si7w7yutbzuQ77HpbMHVoLJYqrnlXa6SwlvTzx8BHhjgfaaQ/ay/E5ZVZJhV/Q3lLfKyqYtBhz2RzkiNBpDnglmiqPbP/NjtBEt6LrNt/biZiPg0o3WtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZcf0Vx30rYLIbNhznbrNOSJq8qXI8aJpgHs2i5GndU=;
 b=QB0sIGnbpit1w8GDRCICVqpcqAo3fm7b0to4FDVQTWVopT9lfh/w3Rc2o+7TnG927sPV6U+WJgTZHmaY7Bf5YgTlHp3rOevYvmXqqHXvE8N1rZhLKw/OebiZ+sWdsi3LOX88Ew/IWczYa1AQcocMlXw7TrSzFEl6vuw+lmM19SsAlIE3tdfnuzpWpnfiaQkjDxUQzqhENGRv9PTOtEVSYJKUV0Znp4uACy8PEtpMNFcPDkguj5TNj+wdTgiA5IxbTxfFvdvj8SWLL0cSnec1OaQLY2eR9Dk65Mn0pvexfoOSrijpxw+xtief2BFXD9t+YthDoSdpG1Acjf/zYWUX4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:30 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 03/26] hw/misc: pfsoc: Support DDR training with newer HSS
Date: Wed,  4 Nov 2026 23:41:30 +0800
Message-ID: <20261104154207.641511-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 570fb5bb-31a5-4ddf-b16b-08df3a8a3c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261022115727099003|5023799004|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ZaphWO9wz4pX1pdMD8+lYW858Jd6ickihJQjhPLh/wv5yedOX6BjVMKdx97lZloFHxM8NcikuNULXkIF6sVQSilGxqIk32mpmWKX09ahi/GZ8YJQj6+bUyBriezaCwNOy9uV6L8EaUoTXHR9dIY9DCGHBxsmlijO7WhDFJhENEJ2j7CtDYlrZ1AdVVAQ2BilH7QP2wHIOkbLlG7ucN9k5tc9eK08SXu8jl/8bqA3Ca79Fu4Yg07D6x6CQ7C8oXf2SPPo5T1Uh3ZukHpXrWM7v6fvC6/JiizFwr4utlfP7xCB5b1EKKih21Iz4CIYdp52rQCe+1lKnSRxy+AMKGV995AIOiHvOBkiVXS9sjCRLexR8h05vg5vVqe0KIm+wO85EJmSi5JHzxaJxbDvvWbjHaki1oZhNCjJp/7Y//FDvkWDoa1hI/bxuNJXCe5G395J+2pOUWBxhXQy0zMx/2Cll6QXm3DWOlNHs3YbODF7iZwgjXLc9oBLwLnCuyO/vt1RfPdr8QUHwRMeo2JdkJK2ucJRQSfzSf7Q3BNx1wMFSdC/QCDwdcvEW0LF2z/wIasFGDUKqmdI8/VTp1QrNFfdKACwcmswvozblGjMVQgJKi1G0w8AMH94g4yxAFWKbTpJgWrLTeLYecIYZiPA7trBYUdNwbt43aOgA6AZIsLEJ7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261022115727099003)(5023799004)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H+4mA1HzmdKfCRmQ4HGyha9DzHAhm72d2sUXYOJ09GEjTZ46gHvK3/Zi9zl9?=
 =?us-ascii?Q?cncpXcKSYArOmHzUmKUVaS1g5rhoIw8FpTlrlSUZaAO+QsMbZQG5+gl6MMDp?=
 =?us-ascii?Q?V4H+myDxfPKgOGqcCY4rC4beP5JyXRxTwiD121dSpeXoCuVFY5M3omaYNfa9?=
 =?us-ascii?Q?Ri17iJoRGMG5S+QbpzrnsISiiHS+8PzBh3443wyMvePF5qD/u5S/hNyrg34+?=
 =?us-ascii?Q?B+U5hizWds8/vWzE7NAqKRQ8g99T4dkxk9zrBgoXmpgqXRbF86cTgjsXaTYD?=
 =?us-ascii?Q?ArPg7hI/Qfo8bO8jGWYg4NPlhEQLd/57GuB/olmEYs0zB3uUqts8/law7XDO?=
 =?us-ascii?Q?Y57FQWxv8s5mEIs7ohVkiOsBiA8KiWCb1xoiYMwJ0sp4WnFMg5uC3J8dpJLv?=
 =?us-ascii?Q?8/ibSSkbXv5WRKY89FVfL89ybM1w/QoKoz7xlAUt9NNayh0GfjIREyLuQGuF?=
 =?us-ascii?Q?sk6IIpUQwNbl/FHitl+m3HdbZMdkAg/XL0kczyIw69HxZR6bHsP5DkOOX0ih?=
 =?us-ascii?Q?sp/M9LIBmb8gKZvkqM5T/diShvfznXXIPNdFw0Lcn6DdNU6BcrYMoAs3P/6z?=
 =?us-ascii?Q?W3vJ+DXq+cY2L/4whiPi0EibBV2R9IFHsDrdU0L2A4hz/NOYDfW1snUw93w7?=
 =?us-ascii?Q?jqMpivjCwOtAlqIOV7KNTwar17vyODKSznZM5pLRcn1oxJFfk0txxZfgj9/4?=
 =?us-ascii?Q?TCffbYHq1sF2UsrkCf/165V82bYYnulCS36260NrFp5OCqnzAK3aYlV2cJmU?=
 =?us-ascii?Q?7svfsYje6qb8SEiglq1ks50GReB7T5kdTguzz25cNkJtSiVLZ4yPhW45nU6A?=
 =?us-ascii?Q?vp86PTAXEdkHnpMf7ZK0SwBNV81I6NRpIHxKsylDAMaX9N5xqIRlQRM9fLYK?=
 =?us-ascii?Q?dch2TDmcRUA+s2y6+AUaOmojVBSQqLAOVc2rKJtpMstc81vj6MJ1xTD60pm+?=
 =?us-ascii?Q?vEGle/SOEeDY19mvBhWjWieu5mBg+RnXZc3tnhoITl34M6LZ5h2I3AVDuUJi?=
 =?us-ascii?Q?b96NYyDmJkbmo2hNkCcF2D9gHqQrtVG88xGYH1nhuD8HMAseh+E9/QZ1lZNF?=
 =?us-ascii?Q?NuU0joGLdeu7CjuhV3JairpDu1yfd8EGxrGzrRGC2QOXEihoQHFaMBTiHrT3?=
 =?us-ascii?Q?LXQ7kiHGowLnOVaKPu9KyOsnLpK4IP9Zt7iZd826XgBaS/v2a5F3aPWKq0jc?=
 =?us-ascii?Q?+MYtk1NkKpfflGVmCAeF3uHr/FN5CaIukQX8Y+Wqoya/+GSRUMevK8Tk8Pgs?=
 =?us-ascii?Q?hskngsIK4Qga2+8mpqQzgVAmQHn5V2+mU2XdjE6gyepogufNi0iSMN5ZhDPc?=
 =?us-ascii?Q?I7NfsfzPvPcxhL0jW1mgEcVQlUQSkjUPPRzAbVYK1eZe2aDZN7zZ0knKFl31?=
 =?us-ascii?Q?PB7wT1Pt+peslX3bTV8yuY2LIeO6yrBds1LojsVzy9ybWukgf31kYRDFx/gF?=
 =?us-ascii?Q?QVsVexzuMwyHunk7LYGOBJVPWCcq0oqHWJQZv3O5f984EcKuTfdrrLtivFSk?=
 =?us-ascii?Q?osY4BTl/1c/wFtouCWhP7lZXrrQT5pPL0sbx/rviURbePpW9gqlqC550mi0A?=
 =?us-ascii?Q?4k8fvUe+lf9jY0L9PhaT/6LPeKvWTqvQk8BW3pVzZASTDHCTwIGJrCf9L3NJ?=
 =?us-ascii?Q?Dhbmgih1Oh8SoyXIGaAIRMPFP8W6ZIziG26n6HsfHscbPwo8OwaX+BC1KENk?=
 =?us-ascii?Q?FfmyIODFjtWStY29YHW1rvBKzkMvMtb2GJ16B4Oun5ZPMw55P9IGIDMsW/zm?=
 =?us-ascii?Q?MNvHW0HX5aQ6aeJYo5VoJmj2QQ5Lm+U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570fb5bb-31a5-4ddf-b16b-08df3a8a3c78
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:30.5778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YX4Z4zBZAZ35nGuus+ddztiYLD9AYV1/XImM73qlVrunqBBXnvaIo4ws0Qo3/SXBmiQiz99A95Uks612+P5JZZngYwHslN9JQPhQb0/z8AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Tested-by: Conor Dooley <conor.dooley@microchip.com>

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



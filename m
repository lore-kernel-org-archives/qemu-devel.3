Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAA606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=XR3gTpGj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9Q-0002Hi-RW; Wed, 04 Nov 2026 10:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9D-000258-OM; Wed, 04 Nov 2026 10:43:37 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9B-0001J5-G4; Wed, 04 Nov 2026 10:43:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbwAnIzLH7s2GhGYaHWuEUTCgUDHd5Zr4Fpc53gEZrE+yRB84AEdUM+LKZz6BS7yIcxiIfehcSG4KiZdSen0OAZ4qyGi1pINVtgwKLQ4raJwyS5Yo6Vn6eMfSzJ2iid/a9WE3yCvyZ9SC4QyiBjV7PGaIoAAFNp751PWFodTd0TaCYtoOc99V7RkJggblEBeeubmtd5kq7SQFAwj7Mxu56UlbXZvYbE15M0hkJ1rsPXRKXn4sV/69ER94rPV2DX7oGDacLm+/c9z2w8+4bFRRVfdjTX/AAzkvXYd7m7BABxk0Ds+J8k1mn9ZRMkY4XrZjUyd4DH7xg8zqPBzmIJjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pczTZ2gTx5YErovgu6Kg+7RfDn14aCw04vwhcXVLPw=;
 b=A+4jDXJXm0TuKWZfn/grO9qmucfDsVNM+z+5Po6uo/1wEe/JItX+RTbOfzpMqjITwVHdr2ALu08gb4AQU7WnfoboR4QVqKGrJt/NTeqzZv8vbu+6pe9UXVNlkqrjdBWF4x+j1bPqiI+qDHWSbCnwLonNmDHysbPXlbMf0euXsQ90DDZz31g/hyfDOlEawo+7oRgsSX39o6F4evn0TL4+CgRww6NZrJvh7Azpppob7gK1xvfTyGdyKBk/iiPIlWRAC74AglnsS+fl1RBdP3XYJsC6rMBA5/OcdsgECNf/2jmDSmfyyVtKX7YrjfgRCDyHzAYy2d/MOV7YrLtIRBMH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pczTZ2gTx5YErovgu6Kg+7RfDn14aCw04vwhcXVLPw=;
 b=XR3gTpGj7I0SY4F+arTLlHOaOaNiAe7lkiwEWrSGZz8vuLUkXZfYkNRRkq61elrf6mOI+o2wx3MxnFufltiAUaK0pJBbB11hV7YnSOF1Tlsb30erGCu2htc5f5Z4wXWUwR2LapAdpjjVrf49XFd1lafbp6yXL7XvCHX6KUF476PxLKVmy+otdzVNKvF97l1uZaWeWdWmdy+psOC2aAkRsCsLFqgpBww7ojn25CW5ts+TUR3eHw5bH1gRtrDtipDQkMzS3cG574WaGyzngr5UDWltVqJ+reU2quV1wrG0beLEWJZs/ueZyby1MfHIlEvo4Myl4al2RnJmHVcA2aoeHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:42:58 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 18/26] hw/misc: pfsoc: Let IOSCB own service interrupt state
Date: Wed,  4 Nov 2026 23:41:45 +0800
Message-ID: <20261104154207.641511-19-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 738a513e-0249-43e9-faac-08df3a8a4d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: pdaI3tv0SR+K2EL6YqfophO/TFoXmMcCMmMYjLo8NTb1DdLzhgg+hWxhMbEwAzH7ocgPz6H3rWibNBSkxuL3je624h+1XkTlL+a7177OvQzkYX+uOpZtLmb+yBMy3/Og5NW38BjW1893lIKJsXLyuNj/T1Dpa+sUolebG986L82T/GAj6drXJ1h3WggE/VnDVui462umxya0M6PkfWCa022W+//791wi9DWQSx8YV83jN4fkb1cWRC7Rm3Iy+gY+hoUU++ijRn7l0d1+VxWneVy8Ob6kDRU4qEb1KdOXAB5i6FZL15sm8JlscF+0cfyLjhKTffjZQiMW/yfMxJxg9xB/ZGgLYYPbb/4NcITOwAr9IxkRY86y6wM66H+ZVaPlC0Hv6n47EDMAdhcSMh6NtEYgGmbpdLhrQyUuFUei61OjWQJClXrFLz3zkw9e3URxcVzxT3RrypiYWBZ02Zm1EjTq8SBpF5xem051hcflJpgHcgT8un5h5kNZI5JZa2cKlsHI+QSkulvYqkJibIcYaH1HMiPZTgJT3kg//HwF2gc5izUaDfccQIQK/Y3Zhf7zr/Pm8qs70sKiSvuKK15OSdlYwi2GkXjzuD41sB6OnlQPy0OURpyCV+TR789mjUj91s/qH5GbEx6XTic6qjVvVV6nH2sOVmdkfZex280GKvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikzXS4lgEe1M/Wp7LO1j+TvINhxdGvOYAXY4s2/zW84nRV486k5j/P++UOPb?=
 =?us-ascii?Q?LXoAnHV04cEEKF26kMCe6xfjqJngtp6+ulWinEZ91ImJgYtPqcx7CLoSgk3S?=
 =?us-ascii?Q?zKyW/ZedKC6woMRxHBwu51GW77m0taP9+NC8a+5T/VhoO71lfH8UOXAO2xnb?=
 =?us-ascii?Q?gm5KRPPU8AortXabPV6tU1wF4Fka5Q7rQlBlB1RB+OS9agXc/m48KpsP3ihJ?=
 =?us-ascii?Q?orN8m/e2ZvLeuWttCc+NwM4C3c2Mo5Qq6UuE5tAryKYhYWTiLxB534cV02OP?=
 =?us-ascii?Q?Sk4WE4JOkGQS8WSAYu/BlL0LPSab0DzbflfgggXUIX3Y4Ar3CdabD7+Hj2zm?=
 =?us-ascii?Q?e79zEJXJEAXZQB1PQ2e2gmhDYWbt/pzE0NgB/sC8KnM7n7QdNHPowB/kdZCL?=
 =?us-ascii?Q?pLxMrp4MxCUri32RFUANBxJ0mxJ2UHa0nBImq7Aftu37RZhOQ5l2Nj5ObrCT?=
 =?us-ascii?Q?2TtVaeJepFBmFN8ZE+84XOEiJDEEqqZfLx4NBv7fuVScifU/17WZUovHkK72?=
 =?us-ascii?Q?xXrNZz17zATKZ2WkR8zMPHjEQfHPBKL8g4yObrptINlN8+11c/3HfR/kGFpV?=
 =?us-ascii?Q?L+tFI5u/rQ6E6usMdJcAGLg/+R1nD8RiEaQxye+1EaTUv4BuwrWriL0FsOSe?=
 =?us-ascii?Q?SnRm368WIb8IrnisjktuzaRNKh4T8xcyd95xjvsUWj5mTk25/25r25L3mVI+?=
 =?us-ascii?Q?XVw6smtzANo4yUjeUeoKcsinNg/G2XmGN1WQTPlRtE7kvxSSFC4rBDqkubmA?=
 =?us-ascii?Q?CqgEa+gmNrIoEi00zd1MdACkXpCBjt7awkyjxyLbHOZWM4qS43prVxUAbbks?=
 =?us-ascii?Q?UAqcTPU8snf5ZO7dj8321HtuEkiuqxoM6OdsM6pQoW00sadb/hPjyTjM/Xbm?=
 =?us-ascii?Q?RBPhB3Wjvb25gxNKdwNphvkPVWj8oX0/J5lHhOrRQEcsBhR8F9CW/9UCtzjh?=
 =?us-ascii?Q?oibUwkuqAKVRoKsqOqOX72PaUj2CI2KIeZQGgYtmMo28hrXkF4aiReOFEZVt?=
 =?us-ascii?Q?csUUKnJdfL30W/HQHcO3x9uiOixdF1iSUcwbfgKf5rbsYK7mkBEFEO8BASJ+?=
 =?us-ascii?Q?2Z/vaXU9KcG6S8X9uQG4Rp8rtZZ+i2scuenwWYFIKjWjSXEZ+qD7i7B3vimz?=
 =?us-ascii?Q?o3oRfjEWGqJTg+hnIS0fs9MoDkNPx/t37NccinGBhgELjdXVkEZDQt/TqCPe?=
 =?us-ascii?Q?j3lAk05+tGW3igKLuRPqfBada5PTbJPPrp8415whSS7ZFKBQ73zKIJnBQ/eT?=
 =?us-ascii?Q?KXSgTCLiQkdlyY3TNlMJByxu80najJsKTMdLng7ziuIji1jkyIfIqjDUDmdK?=
 =?us-ascii?Q?05AInRnfJDlCVyZt0KwkIhXTwLPqaPjxoKLWprxbYA6/JA5tzPzWmX4x7aht?=
 =?us-ascii?Q?XjmSvYOjDBeR8ocG9SPov0BIIhI21KdEHA6ea+N1YHCbOW99QJTHIi/sxuqo?=
 =?us-ascii?Q?PxNeM3xws643VGtzTMXwpas1zyufo6gILGrXv7Y823Y9lvmYD0pY5ZcV4qPN?=
 =?us-ascii?Q?9sOUcQpRB7xQOr5lCFMLAGlfseLraRDBxf/yZiJGt34ljWr6+/d/qcx2M/dg?=
 =?us-ascii?Q?LNOXSxTTaIfL5tBy/h0PBplsM169huMETFtFqSd3/1gPKKYnHtCTFwwPUSrl?=
 =?us-ascii?Q?QiWZOVOEE8YlBQyfF4atcQuf0qGg9vdlem+Eg/aDcwZS0qFz7FI6HODBLjbI?=
 =?us-ascii?Q?c7F54pdPFTkTeyKtgBj0l/bpgOXAKsnKuYDX455ozPc0BfknbDZDnvt8OuoN?=
 =?us-ascii?Q?VzAp8EE3wcy9QxSOf6Y0GOzkEVbTA2U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738a513e-0249-43e9-faac-08df3a8a4d3f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:58.6758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwY36tZtZn8hIFvIC082hKBJkNM1h+5Vv/UQFkf5p9E2qIVqtqsAbF8ZyqyNr7C2grqxmfRgbXIYqGMdpF1RjBFuZTxDZ9CGZIvKeovXA2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

System service completion raises PLIC source 96 from IOSCB, while
software accesses MESSAGE_INT through SYSREG. The MESSAGE_INT pending
bit is not modelled explicitly, so reads return zero even when a
service interrupt is active. Model the bit so service completion and
register accesses use the same state.

Keep the pending state and PLIC output in IOSCB. Link SYSREG to IOSCB
so MESSAGE_INT reads the current pending bit and writes update the
same state.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

---

(no changes since v3)

Changes in v3:
- Separate interrupt state ownership from the NOTIFY fix
- Link SYSREG to IOSCB for MESSAGE_INT reads and writes
- Support both clearing and setting the MESSAGE_INT pending bit

 include/hw/misc/mchp_pfsoc_ioscb.h  |  4 ++++
 include/hw/misc/mchp_pfsoc_sysreg.h |  3 ++-
 hw/misc/mchp_pfsoc_ioscb.c          | 20 ++++++++++++++--
 hw/misc/mchp_pfsoc_sysreg.c         | 37 ++++++++++++++++++++++-------
 hw/riscv/microchip_pfsoc.c          |  5 ++--
 5 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index aa108d2d88..e8386f9794 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -53,6 +53,7 @@ typedef struct MchpPfSoCIoscbState {
     uint32_t services_sr;
     uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
     char *serial_number;
+    bool irq_pending;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
@@ -61,4 +62,7 @@ typedef struct MchpPfSoCIoscbState {
 #define MCHP_PFSOC_IOSCB(obj) \
     OBJECT_CHECK(MchpPfSoCIoscbState, (obj), TYPE_MCHP_PFSOC_IOSCB)
 
+bool mchp_pfsoc_ioscb_get_irq_pending(MchpPfSoCIoscbState *s);
+void mchp_pfsoc_ioscb_set_irq_pending(MchpPfSoCIoscbState *s, bool pending);
+
 #endif /* MCHP_PFSOC_IOSCB_H */
diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
index c2b3688a94..d6c9027f2d 100644
--- a/include/hw/misc/mchp_pfsoc_sysreg.h
+++ b/include/hw/misc/mchp_pfsoc_sysreg.h
@@ -24,13 +24,14 @@
 #define MCHP_PFSOC_SYSREG_H
 
 #include "hw/core/sysbus.h"
+#include "hw/misc/mchp_pfsoc_ioscb.h"
 
 #define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
 
 typedef struct MchpPfSoCSysregState {
     SysBusDevice parent;
     MemoryRegion sysreg;
-    qemu_irq irq;
+    MchpPfSoCIoscbState *ioscb;
 } MchpPfSoCSysregState;
 
 #define TYPE_MCHP_PFSOC_SYSREG "mchp.pfsoc.sysreg"
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index bde1917c10..1f77da6852 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -209,6 +209,22 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
 #define SERVICES_STATUS_SUCCESS             0
 #define SERVICES_STATUS_FAILED              1
 
+static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
+{
+    qemu_set_irq(s->irq, s->irq_pending);
+}
+
+bool mchp_pfsoc_ioscb_get_irq_pending(MchpPfSoCIoscbState *s)
+{
+    return s->irq_pending;
+}
+
+void mchp_pfsoc_ioscb_set_irq_pending(MchpPfSoCIoscbState *s, bool pending)
+{
+    s->irq_pending = pending;
+    mchp_pfsoc_ioscb_update_irq(s);
+}
+
 static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
 {
     uint32_t command;
@@ -248,7 +264,7 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
 
     s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
     if (value & SERVICES_CR_NOTIFY) {
-        qemu_irq_raise(s->irq);
+        mchp_pfsoc_ioscb_set_irq_pending(s, true);
     }
 }
 
@@ -339,7 +355,7 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
     s->services_cr = 0;
     s->services_sr = 0;
     memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
-    qemu_irq_lower(s->irq);
+    mchp_pfsoc_ioscb_set_irq_pending(s, false);
 }
 
 static const Property mchp_pfsoc_ioscb_properties[] = {
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index 1d9154280a..4c52338c8a 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -24,20 +24,22 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "system/runstate.h"
 
-#define CLOCK_CONFIG_CR 0x8
-#define RTC_CLOCK_CR    0xc
-#define MSS_RESET_CR    0x18
-#define ENVM_CR         0xb8
-#define MESSAGE_INT     0x118c
+#define CLOCK_CONFIG_CR     0x8
+#define RTC_CLOCK_CR        0xc
+#define MSS_RESET_CR        0x18
+#define ENVM_CR             0xb8
+#define MESSAGE_INT         0x118c
+#define MESSAGE_INT_PENDING BIT(0)
 
 static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
                                        unsigned size)
 {
+    MchpPfSoCSysregState *s = opaque;
     uint32_t val = 0;
 
     switch (offset) {
@@ -56,6 +58,10 @@ static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
         /* Indicate the eNVM is running at the configured divider rate */
         val = BIT(6);
         break;
+    case MESSAGE_INT:
+        val = mchp_pfsoc_ioscb_get_irq_pending(s->ioscb) ?
+              MESSAGE_INT_PENDING : 0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
@@ -77,7 +83,12 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
         }
         break;
     case MESSAGE_INT:
-        qemu_irq_lower(s->irq);
+        /*
+         * MESSAGE_INT bit 0 is read/write: writing zero clears the interrupt
+         * and writing one sets it. IOSCB owns the state and PLIC output.
+         */
+        mchp_pfsoc_ioscb_set_irq_pending(s->ioscb,
+                                        value & MESSAGE_INT_PENDING);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
@@ -97,20 +108,30 @@ static void mchp_pfsoc_sysreg_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCSysregState *s = MCHP_PFSOC_SYSREG(dev);
 
+    if (!s->ioscb) {
+        error_setg(errp, "The 'ioscb' link must be set");
+        return;
+    }
+
     memory_region_init_io(&s->sysreg, OBJECT(dev),
                           &mchp_pfsoc_sysreg_ops, s,
                           "mchp.pfsoc.sysreg",
                           MCHP_PFSOC_SYSREG_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sysreg);
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
 
+static const Property mchp_pfsoc_sysreg_properties[] = {
+    DEFINE_PROP_LINK("ioscb", MchpPfSoCSysregState, ioscb,
+                     TYPE_MCHP_PFSOC_IOSCB, MchpPfSoCIoscbState *),
+};
+
 static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "Microchip PolarFire SoC SYSREG module";
     dc->realize = mchp_pfsoc_sysreg_realize;
+    device_class_set_props(dc, mchp_pfsoc_sysreg_properties);
 }
 
 static const TypeInfo mchp_pfsoc_sysreg_info = {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 55ca8a244a..63cec48f43 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -316,12 +316,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SYSREG */
+    object_property_set_link(OBJECT(&s->sysreg), "ioscb", OBJECT(&s->ioscb),
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
                     memmap[MICROCHIP_PFSOC_SYSREG].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
-                       qdev_get_gpio_in(DEVICE(s->plic),
-                       MICROCHIP_PFSOC_MAILBOX_IRQ));
 
     /* AXISW */
     create_unimplemented_device("microchip.pfsoc.axisw",
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE7ACA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Bq-0003Fu-RH; Sat, 03 Oct 2026 13:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39P-0007Jb-VX; Sat, 03 Oct 2026 13:03:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39N-0007Ds-2J; Sat, 03 Oct 2026 13:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2fpgDmlhDxtqEVCOdPe9hBEqjYJB/lf01y7nEdpZhlux8b1L9GPPo5pzGGs9+3MhLPxW+75BNqZb2wfpqAyrG+NwXbT0gbUJwPw6zdxpC32Dm6x+ID0Z87gZJvyQNKpZK2VVcbUW9ZPekucGenV0Qc+Ttk1Fj/FqZRxiFPrAvPVIgee4RWh9q7eW7IuSWTM5K7zWinhbW1s+gaxNxc9ntrnsMiQiOrOTh0pgOTYk3jVg18kstsfhSoEC9FWcvsvHpec4HdLL3i1isz5FwbApF0ckMj5WK4eDfRrzaIJa720h3mDSEjqPWYeyMdzHrsBsLaQxjPyaULIqZWt9sHkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p386u667LW7V5ngsZMQKQqdHQ/cpH9RAnnLB+TBow9s=;
 b=InuOu7w4O9Ujvv/wC04AQl93qq03wOhImKxgLBx/ZCIfRXVXPydbzDrlmrAD5TPM1pIMtB1nr6azegzmcBsPjY/9n5jtxoMOql3BnKSCYxpsoCa1IqqarnnWfr9g+VBDdJyDeMo+PxIRJs4Chs40NwB+x1A24UROJmgW72BngCrd9LtKSA1A3ULE1xvXnZfAiiGgmE2b2i4OnyJEs1xw1AJTxmHoteNsITgHneUqZ/mZ6O64cE+hzZdU4sZnohBJp3c6R99Z5zCAYF7mJ30iyE/3Q/E3zm6DeML7X/dLHzJ+kG6q4ACGTk++ehaIfXD4F+6f6wt2onuQv7QQOdV0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p386u667LW7V5ngsZMQKQqdHQ/cpH9RAnnLB+TBow9s=;
 b=Dy4yRNb7ypL7ItIJP5SgV0fwgWnNjoK0YXwZ+zA1mHzHJZJQC00einQx9+stAWIfUKY73dobPSKS8TFuowuB4sh1OCqYtbagqSsLwgZiAvsvtROvWRQGEtsVQ7XyFxbqs9qiGqBFeWoYyqQJZwqFJHsCW7b3ZBlOub00mtx9XvMl5CLlsSfh4I47dCBdGQwDPQmOtW4OTV6lL34nEtDDZix40aPaAC67She1FEdpk2+6DPyx33LpOoxZse2nn2boP4xezAhb/OOtTEUQCDmN6mkRAcm3q+NQlhVX0/8yqpdJIjEltySGZMBccxvYyR9DafXR9Ya6cGdEl2WZMN3eiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:46 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:46 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 19/27] hw/misc: pfsoc: Let IOSCB own service interrupt state
Date: Sun,  4 Oct 2026 01:02:09 +0800
Message-ID: <20261003170232.2450916-20-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28e87229-58b8-465d-9b8e-08df21704957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: v3scGBTG8CIcTY9UqCAYgK1brB+rPQY1CDwCXI78jG8PKxpD3u13jYu819fv9C1RgEwBo0c6EkpjCLtr+UpKctW08pAsvtYz6nceVcdLSgx9zSvjvmTT4i8Z1PXexuLxKWrkuJ7548Fh9gCQ2b08SA+Vj21ox4b0n/cUeTZ7wxs8QGPWOoj7qsddZCKrAIVquh4RwGKY8YHMEpRpPUTI5UO5r/nAz44RkZ0q06Fb5gTgbZBOLBlw8nyHRR62q4JPxFcIJwr99PAl9B4mvUkUiHKzWcudyfvPSSTqwFckuqm+r1x7l1DcF3n+Z4HgayNdVCE6nCQZpy5VTMt26CVcpf57GMzyMYezGMQmqxKTu0Q0artP9e/EGxx2oo5BLgSB1bSOMIwkb4mCpBk5q1L4PUCJuWG3/r21tvxLhRBrpcWE59TcK5tMiFkYo8B30LJsCN0s7Agbcvd7CjCI8IdO32tEra9OIfPQdlMGBAWNhR3XXw3u3EJbwEA3ovA8LBETQ9Xt1HBiLljZIooRIqBvylAuVR1tOPYXuqhK2oqNbwnq+MpCYtQXyCztNs9qlzpyygToFer7jsUs4yvDchwmcXrEeyrgZbPw9sYX9zNB+YQc1dmvISa1VhrHCQFTDU/OBf7dBn/TmRo8JYDj8CisZBPzVi5LrsM1RVtpgPrJZjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l58FZvqo+11BuDmc3tsNIcyR5Ur15wmfOsqQr5GiFc2L3UyCkhRlD65zdE73?=
 =?us-ascii?Q?Thb1rBVxSSpbTVZusj35LZTF8S7fpNeg1v8QFGoosZWQlw1GBuOx1WARICq0?=
 =?us-ascii?Q?cSB/UTeUmAwgU0whYqTjx3bvZ3jWAZsitdyo/oRir6zkGlnGrLpe2wtYLKZZ?=
 =?us-ascii?Q?L7QYWKOaej2ZBrA774VUqjMtuz+7rBYuWvmHVhs5QeUfcLh/59npoW4KtbPr?=
 =?us-ascii?Q?twkroK6b+c7MG8SImSz2ebW6u0AqnPGF1e9302zp+dj0Lq8gbkZiwozuzJRG?=
 =?us-ascii?Q?LmaocL5CJjkhmj/fGcM8rTyrAc63g5TGidGMgYt0c0QlqIa6UkItsDp8jRbn?=
 =?us-ascii?Q?6TQXxLV71Hil7pQzthslYcXiQXnB18N7r6RRGGpZCDmR+agE2ttoNzm6G0+5?=
 =?us-ascii?Q?MjmgWzBbE+M7xS5QSweWwQlOhgGQYe4Fj9lnmDo/lU/7kZ81Bgs9wukKZ8kW?=
 =?us-ascii?Q?vc0vs2YJcXeGILqwTwboqqYEuJr24e3WFYryWTKWWufCAMCgvyZhAfZDR/1l?=
 =?us-ascii?Q?3K94f6e2reZyNT/LoON8SzxE87ouvgwkragS39QfCq91knzr9JHaVIur1F2s?=
 =?us-ascii?Q?gjjMKiDNMy9OnFtV78v1xpfzMtWEQUGzJu1oDvRJ435mGP9X1TCbP9lMrEYs?=
 =?us-ascii?Q?zJ/KUh+5ApQctVqK/8nieMAFmJbsNjEBkJF4+8JF6snUyhrKyJdYwVQBHD1g?=
 =?us-ascii?Q?0OoSRKjblqkDvrnsQx7hlxLII7smJFbM4+4glZ7J6idWdCKPdgUdR1wnWstl?=
 =?us-ascii?Q?3sYe9uiOmYuHLfG/XP3xyT+8edIV+/CpXu/gUA1lMbW4MSi3h95HyDePkozY?=
 =?us-ascii?Q?yHAigQ9CSwQoQg/BH5XMlpKnoma3CDFxcDILrJyJMorLZLwM6fo1wAeRmhSl?=
 =?us-ascii?Q?P16Jzalr/fqtnMr0YofErLroRip0LvHi+evMetZaDSnfrj33+C6+uirf5z0v?=
 =?us-ascii?Q?qRLdFvdWMQkxzk6AsGv8jdRyzYfaW91CgddFhdYJpqk09VFSEYsJrHXOc6zW?=
 =?us-ascii?Q?ruo41sMOZt/Wcb3yxNY/q8KRiUCGAsjWUNeDC99s856WgFOMTLtiMQWvdJkY?=
 =?us-ascii?Q?h/6qldYG8N1oGPjvRqVfSrlFU8+bdsCuCzncn5W3tuBvit7BRVA+T1h6XwiH?=
 =?us-ascii?Q?VwQnStV98+pu+4fw0rlLucCRzH/QzXQ7zh0NHqfhsoHomi35ZSoYdT2m3fcB?=
 =?us-ascii?Q?Rd7KJD98S1ferbJTTQWDC+nLyP21VA1v6F4+oli27poP1/FxzJoaSkxozxoB?=
 =?us-ascii?Q?yxbvVLlD+F8tg2lmY2tFypbNnDGeWpIpbO7MoH4D8xawDcLGwL3K3dkq0b5b?=
 =?us-ascii?Q?uprSx1crH0twMXq04LCAhT6kNypiMwCBijKo/FBW6wnInTdFpgs33vvc39Mc?=
 =?us-ascii?Q?8tzTBPP42xHjPJ9hlvaKCBxVd9wPoCihGnFX/4agddX5Jf8pg3g7Tp+PPd2t?=
 =?us-ascii?Q?zFkQ3XXx2t8Vxz8e6fl0QD4yAaAtVS+CD6H3Ce5LCNFhO/GBTtzWfMb6Lmfg?=
 =?us-ascii?Q?KnvyUI7cbtMQK/r5TphrhBl6OKXC8KYuX30XEVdfCG6DWQYkGrsmanGlJi3e?=
 =?us-ascii?Q?sG9ExWUvFjn/YQMaMsEoccAidvPR6inCECNPQallaPHm4Rhu4ghBNp0G95+W?=
 =?us-ascii?Q?X1xbff147fLbAHWexgV/DeWFZ5Nn5Pek2Vj3MKN9cuQwzXSiNIyRZa29LLXb?=
 =?us-ascii?Q?r9f/3TXch3YYGJm+YFI7byiqUb5e1orpxhJbPUkhZcJb7WSKvV/eo4JGvOdh?=
 =?us-ascii?Q?nVidEDNLCsoZ4OsWiW6vLDDj9+49eXE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e87229-58b8-465d-9b8e-08df21704957
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:46.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyJUK4dGJqRNkNg48N4yLpmqfIBQdXBu8jAJiDw7ZzLCHfFJVC7ogiynJ5FZKt7kr6iYLz8DSinhC4i27Op/DPOU8lVj7YTfl57JsQXJ+Qs=
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

System service completion raises PLIC source 96 from IOSCB, while
software accesses MESSAGE_INT through SYSREG. The MESSAGE_INT pending
bit is not modelled explicitly, so reads return zero even when a
service interrupt is active. Model the bit so service completion and
register accesses use the same state.

Keep the pending state and PLIC output in IOSCB. Link SYSREG to IOSCB
so MESSAGE_INT reads the current pending bit and writes update the
same state.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

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
index 36c894b677..38f4e7d799 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -315,12 +315,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5DCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnj9-0005Vk-Fq; Tue, 13 Oct 2026 21:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnj6-0005Uw-V2; Tue, 13 Oct 2026 21:24:16 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnj5-0006ql-2P; Tue, 13 Oct 2026 21:24:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grS001Eecz1MyJv3luewO7KsmbVl09kf1HOVaJ9WmnThpMMWrst201Tg/8F1Q3eXi52NAbx08HzpnSs1pJagJY44u0KvrGyYTHlnaJuFmS7w8o/SCQeBYw9f1mGvP8HZSWct/VNJMQqSyFkmuxlXS0OA14RcFDYNjr7+mMxmGjPH/q4bVeCJe2yVdTbFKmRpxajzx1iVyuWd3VVvK+XZWhlxk4oVBnY1M04TgPDlvjAmlTheaYLwG8AVMckV/qOH0dPepyk5lwJZzP4gq9mId58Q4n3ePUvOpgzwd/NYMFOUHxkwNlptZudylktLGOycygorf0YYPmzyB8/Yr6SfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvkHcr8hS0+bnqE/H9CWz/3tBSdtruHcHCOrtDKbu1U=;
 b=vVjqNjBZCPYKSWUAY26OSo5gYLxTilow2dHGVYC7x1rGbhijuO1rKVf2ezvvBYJgqhHNZooPFmLgiwOGML5WFXXlI7ScNgAau+w9z8UZqGSz4XfW3FJyfpNn0Sx3gMutcNUjh6icslN4940dqe4/rD3dTl/7dWmxyO1SRWIaVoju94tFTtx71q4xDkqBnyi7cw8hLVHF6kmc1glnteSQleLZu5Y4Rt8cHs8NEji7MDv6M/EFkoLCc5NKKl3Gg8+nuIggzZR9TlVa4nBURWVO59NjYYOgt89iDVMCugbpdqehB33zkkgcI06n/VN8MyshmqvlyMSsR+WsQNLb7AUnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvkHcr8hS0+bnqE/H9CWz/3tBSdtruHcHCOrtDKbu1U=;
 b=tJlBFSt+so5V+ONEyjhJk3M1yYOvgPN2xOGYh+Hb70c3FSwGyErO0evr6q4APKyfhgi7ER5SBFIXVbYW43o+hxr8Et1XxUo5wFWq/AVmT/lydROVVBm6FvQBoom9/M+2BVvRQzVdjNg3+GoQ49qSs5NzKoRLmpxnbfgP/+nSqiUbbgXBZ70qb92TYwn8KXXxPWiNa2TCArFVdw+sMj5bwZ2LC2WBPB4ise+/aXrRxzv7yUik2Oq9Tv+S2sZJ2YP+b0JdYYq7JU+JuvrcXKvvFpX7OgHgi6/rdS6h5f0nhIOdvN5IasUh1BUom1oGhMGxPZt+wzBXz5yK0Bmud4wulg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:05 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:05 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 07/27] hw/riscv: sifive_u: Use the shared SiFive L2 cache
 controller
Date: Wed, 14 Oct 2026 09:22:47 +0800
Message-ID: <20261014012323.322790-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 074bfedf-40c1-414f-300a-08df2991d65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: mDZHngOYCXcs6Y1NNK2+v+ewzMqoJGCsrMOTV8AdegJt0keQJnn9X1YdScSm9U+au+On8X4CDHitgQa/xE4mM+e2l1VTX5SXXGEGXum7w7JFMHh2/YmIL2XJzAa+LM2Q9Vmm4ECzVjQkzAXlF8EinLIvD2BXDKidDucbBrtvjJXdsK2x0o/LRIDS5kTAOX24hiKhUGEuBkjvjr/lmmReCC2rRFUHtM7qU4tqSs94vcolQtWBkBNbR0CHrciBMAb/L6yfvLpWH9jHlhDFksDIHYMoi56hrmDHo5F3Np/lQPj26aP8+QItugh9selY1khB/QMIcysRst8UV9jJk6p5QCR4VdaR3waBu9YnP1U9RwP3fL7c/8jKIvMApNLeQz36kUp4p/3zIkdv/3TxlnGi2fMpXskuLGOQp2MYnFj7Q4LDaZ3K7rdGVT1DwbZEVZndqucqS0HMAi8xAQtvn+GqzLO7gWelb3L9zd+m0o/YF2mDH0gowWTkmoWXF8zXScaAVPtIOdKk26V/5czo/M5sw1iKjLMcdMyfi3fjzh+WUpxBl9y9+WO1xvrwZVG7KeM26bM/WLBR97aWQPpBsh5CK2zhmWV1j/55hHLCfk+WenTGBfRTu7aGbZtHIglOcA2Q730Sy0IXn3VpAM0Vy9oepITwurM4eUJD1Ww8JtgDQbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORXIZ4qWXttAppXqCIfxBd/Uk4By6Gu9o06Md9DHg7pDm/E131JMt3cPrx75?=
 =?us-ascii?Q?dCSdYqIXBQlvU3bnkpurjkDrzRjglamKbTx02yaF7KJtvxcrNrMRVPMkHHnz?=
 =?us-ascii?Q?Cb2lYYg2VUhmfaAxD0SRg4SKdKQmWInPEAXiyU5gV5LMq9mprrKOJ/U1l1Lu?=
 =?us-ascii?Q?CbvNiDG0F9nkk3wwYFGLeW6YkKaOQGF/5kTyNdDsR+VWGq4JurUqR0nTCXOV?=
 =?us-ascii?Q?OD7V6ly8oZETCouui7GVu9UQJrOWSXDKW03/YlskxRlOGQyelXtIxWzkedWx?=
 =?us-ascii?Q?7XB/hG9fFgzHwUHZIvkB0VcqsTAb/Ew4x35tPiib8i3R5zKfXnX/0BACF2EK?=
 =?us-ascii?Q?nEkE2V4vHeYYidRKix0snRlxbiMZyloU2kJdf1Xy3bFTNJzprP2tgHnnb9WO?=
 =?us-ascii?Q?cNRWKdn/wg5humqS8o68Kj0hZDx3Hpt+Q6PIeKMGVmKFgAuGHNw+hD3zOQMq?=
 =?us-ascii?Q?GNwVbwlHSyNEGC3QbQGhT+bp3AT8ctKyLeSXr4NzPq+bBERvZVziFWfhknJc?=
 =?us-ascii?Q?UM/r1FtdS+n2I+ZqTVzb+T3bsyQbS//D7WKieOVW8cs/sZbf3QISCAdJoslQ?=
 =?us-ascii?Q?Ss53xGRv4NGfJZz8BgY8ypMD2rdU+19/4HC1EFsqFg08wif8G6GMRHRpwDMs?=
 =?us-ascii?Q?yVvBuzxVsRfPpDdIEVREAAquXLfajNNm8gw/Z12rqySvmNjQN2/M0abyA+3a?=
 =?us-ascii?Q?8LMNqKzc86TmtPz37Xn5Moc1wD+/efrtHmExqfmmleqTc8RuJlFTvT5fmQoG?=
 =?us-ascii?Q?FdWgCB7g3euDu6k0w+UmfRzu0SzNdTZz0Yw/rK/R3+5gWMnJrX7RLyepk4TR?=
 =?us-ascii?Q?S7Du4VH3IrRSRxw0iVzVTEbOAHdcIvMzCnAcC10GmG04OSFmHhev3GOD/6wk?=
 =?us-ascii?Q?Egy61kEEEGyuKzTH37I7GYHLFef2AfPLi+r74S5A2M2G1SDBGwXSiwP+QAt2?=
 =?us-ascii?Q?5Copydsz5SDdxyVXhmk3l0hksAX7vlB0K/rrhiS3XV1iDazfdY2hJ6kiB9UI?=
 =?us-ascii?Q?50RcQWltEYoIrGPrGWb7OpRqbdD7L+t+TD0LSLH/dxQJh8aTnqkMgexXOXZ/?=
 =?us-ascii?Q?kTXQ99IlO9kOOA5v2Jyn0HDY4ReXyywW+erZX6gsb349lt9LSsbI6DD12l1U?=
 =?us-ascii?Q?ClA0BmK6jrazKbxRZkDOVSlPgpZUAPNFdlfJwbsufOdwEU8LF0KFCxkXaq6U?=
 =?us-ascii?Q?BB3NAfh9fpWZG6uOaNaZLEJFEem7ENUo4NxdCLalls/o4CHZse2jUkUP0r4+?=
 =?us-ascii?Q?Z59HrqVmK57z0urEopISpiQJgvHSdbARu6MPQjiEE0aescMHaQ47sQ4Dsel2?=
 =?us-ascii?Q?lBPmwUcw2GaFThpl6Vj6R+s6RA3h7LcBKA0l8wCnHw7Gz+RAxmb2Rtr8fiNO?=
 =?us-ascii?Q?IloaHkcjx4kAUxR04Jgv33wvRhUsPN9RVWEELqj3+vyFcBzY3GpZV8r9hSv1?=
 =?us-ascii?Q?ZUW1MBG47fOpKjU6eWBDYKTfguDnn3FDok0u4OoWp8CMkxS4c9YQu0z+IHJz?=
 =?us-ascii?Q?JwBXzZqPPzgOzFrZ2eFMQ6k3JPa1r827k1p1UIrm0NxhfmGDzi2aRxw1meKL?=
 =?us-ascii?Q?ni6/E+zL4TmUfqZMN3ijYfRyvqfOGGhzVjI/lsNKWvwlvIP/fj+iib0lpugR?=
 =?us-ascii?Q?18ymnUcQgXUDaW+A/c8fhKeBBm1D9v69ooaA3sjlrTVl59Oa162YFLGCBU0P?=
 =?us-ascii?Q?g6bE1WjmDJCuYQaUQaX9RN9ciCY//LFJQ2s52x4cpsmGTiengHLtp1NTcKq5?=
 =?us-ascii?Q?rDhf0tZDwHkGwMnXBGX7DvxgV0Dn19o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074bfedf-40c1-414f-300a-08df2991d65c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:05.5150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PyjekMs6cSrp0FXLk3+IkyEPyMqsRaW4uIR+l0rhQpjG4qtyooJwHOhlciKgzIE36ztYrrxpodSq8T5GOZiyvYcTD/z9jVVl3c3wpxc9Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

FU540 and PolarFire use the same L2 configuration and way-control
interface, with different master counts. The `sifive_u` machine
currently leaves L2CC unimplemented and exposes L2-LIM as fixed
RAM without WayEnable control.

Instantiate the shared SiFive L2CC with 21 masters and a modeled
2 MiB Zero window.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

Changes in v3:
- New

 docs/system/riscv/sifive_u.rst |  2 +-
 include/hw/riscv/sifive_u.h    |  3 +++
 hw/riscv/sifive_u.c            | 30 +++++++++++++-----------------
 hw/riscv/Kconfig               |  1 +
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/docs/system/riscv/sifive_u.rst b/docs/system/riscv/sifive_u.rst
index 0e4dcf3e70..e91853ffe2 100644
--- a/docs/system/riscv/sifive_u.rst
+++ b/docs/system/riscv/sifive_u.rst
@@ -14,7 +14,7 @@ The ``sifive_u`` machine supports the following devices:
 * Core Local Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
 * Power, Reset, Clock, Interrupt (PRCI)
-* L2 Loosely Integrated Memory (L2-LIM)
+* L2 cache controller, including L2-LIM and L2-Zero windows
 * DDR memory controller
 * 2 UARTs
 * 1 GEM Ethernet controller
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index aed966a62d..be5e6232ce 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -28,6 +28,7 @@
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_u_otp.h"
 #include "hw/misc/sifive_u_prci.h"
+#include "hw/misc/sifive_l2cc.h"
 #include "hw/ssi/sifive_spi.h"
 #include "hw/timer/sifive_pwm.h"
 
@@ -45,6 +46,7 @@ typedef struct SiFiveUSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    SiFiveL2CCState l2cc;
     SiFiveUPRCIState prci;
     SIFIVEGPIOState gpio;
     SiFiveUOTPState otp;
@@ -82,6 +84,7 @@ enum {
     SIFIVE_U_DEV_L2CC,
     SIFIVE_U_DEV_PDMA,
     SIFIVE_U_DEV_L2LIM,
+    SIFIVE_U_DEV_L2ZERO,
     SIFIVE_U_DEV_PLIC,
     SIFIVE_U_DEV_PRCI,
     SIFIVE_U_DEV_UART0,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1ac0d1bbd9..3603cc2aa2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -73,6 +73,7 @@ static const MemMapEntry sifive_u_memmap[] = {
     [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
     [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
     [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,   0x200000 },
+    [SIFIVE_U_DEV_L2ZERO] =   {  0xa000000,   0x200000 },
     [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },
@@ -715,6 +716,10 @@ static void sifive_u_soc_instance_init(Object *obj)
     object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_SIFIVE_GPIO);
     object_initialize_child(obj, "pdma", &s->dma, TYPE_SIFIVE_PDMA);
+    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
+                            TYPE_SIFIVE_L2CC);
+    qdev_prop_set_uint64(DEVICE(&s->l2cc), "zero-size",
+                         sifive_u_memmap[SIFIVE_U_DEV_L2ZERO].size);
     object_initialize_child(obj, "spi0", &s->spi0, TYPE_SIFIVE_SPI);
     object_initialize_child(obj, "spi2", &s->spi2, TYPE_SIFIVE_SPI);
     object_initialize_child(obj, "pwm0", &s->pwm[0], TYPE_SIFIVE_PWM);
@@ -728,7 +733,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     const MemMapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     int i, j;
 
@@ -754,19 +758,14 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_MROM].base,
                                 mask_rom);
 
-    /*
-     * Add L2-LIM at reset size.
-     * This should be reduced in size as the L2 Cache Controller WayEnable
-     * register is incremented. Unfortunately I don't see a nice (or any) way
-     * to handle reducing or blocking out the L2 LIM while still allowing it
-     * be re returned to all enabled after a reset. For the time being, just
-     * leave it enabled all the time. This won't break anything, but will be
-     * too generous to misbehaving guests.
-     */
-    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
-                           memmap[SIFIVE_U_DEV_L2LIM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_L2LIM].base,
-                                l2lim_mem);
+    /* L2 cache controller, LIM, and Zero windows */
+    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_REGS,
+                    memmap[SIFIVE_U_DEV_L2CC].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_LIM,
+                    memmap[SIFIVE_U_DEV_L2LIM].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_ZERO,
+                    memmap[SIFIVE_U_DEV_L2ZERO].base);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
@@ -868,9 +867,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("riscv.sifive.u.dmc",
         memmap[SIFIVE_U_DEV_DMC].base, memmap[SIFIVE_U_DEV_DMC].size);
 
-    create_unimplemented_device("riscv.sifive.u.l2cc",
-        memmap[SIFIVE_U_DEV_L2CC].base, memmap[SIFIVE_U_DEV_L2CC].size);
-
     sysbus_realize(SYS_BUS_DEVICE(&s->spi0), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi0), 0,
                     memmap[SIFIVE_U_DEV_QSPI0].base);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 46a499f70f..b2b816de6a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -99,6 +99,7 @@ config SIFIVE_U
     select CPU_CLUSTER
     select DEVICE_TREE
     select RISCV_ACLINT
+    select SIFIVE_L2CC
     select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_PLIC
-- 
2.53.0



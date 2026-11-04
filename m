Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCD606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=AlihkQk/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8X-0001dS-5s; Wed, 04 Nov 2026 10:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8U-0001Yf-87; Wed, 04 Nov 2026 10:42:50 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8S-0001E6-Ch; Wed, 04 Nov 2026 10:42:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apYO44ahDu2XUs31gXT/i8krma6AvXWrzLXuPV0kGYz7rZngVHSw/xRQEmDOW1mgBgDiSLWiJFpnmQ/OkzPgWoCCh6RdFpEoX/P0gmOBMfTKAw0LU81ceNWc71rqnzHTC1TmQ7mqFwG/uzU7wci0ucOHXoNQQIlvCwpXp9YScaIg1bKsFon6nAA3ex661Rr4MNxmTk4jCCU4QfsLHgCheb9pmroIcD29LH19yt+cwteZjG+20/fBwwh6mjzvYlpM0brgghKERhlqjkFtG9twUwQ72elPjULYBVGNCZ3N79IQcr9JPtW6XEUBPKK1Snn+XK09aduXnIs+1Fkc0TecAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE5xUZzx3GKVTIbONK7WAUfpA8XM/onDKhJRe54N6Q4=;
 b=EcbxSEIioSkzKT9rry7N2TQlJ5/dhD/OyirKyNXOiP7ix2ysDlpDuxu113srOiqqAPNHXvhQ60w/eoH/jH7tFS4Dns/sQBIETEXAtI8aDVvLhkE84cvjYikISA6/okrhKZf/Cp6JiendqydIOyIxYU6uIOc2yo2c7+1pdb+1HPawVb9qmdew+x7JKPUIk0u9P7sB8on7sjOLfdnWd43Ub2ShQQRHw+AyC9fA+PV4T3XjTCCX4hrr3E6eSwbQ/9XWaCh3SnTqznm2EkTRTYolwKRwd2Y2LI/meaRj9uPJPWLVsqx1hlr0Cl9hqMlPK3/F8GcCjC7KMXw2UKKHuz6HSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE5xUZzx3GKVTIbONK7WAUfpA8XM/onDKhJRe54N6Q4=;
 b=AlihkQk/47l7pz8XIa5cXjczp7xnj7ACBubPUObrnrLp8NiTNN9TuQxPrcQ/VnXMRW3klDVIJeQ4Pk/0OtBIBCrH+r2skdEQVwO3FjzLImsKTP9uMIbGFd3nTtbxLEO60+S/FhAGkv/OOj5R24/LFTV5M3K068rxvnVtOWojhNvtqFh1NOqWP6C3l4NV17IAwWDEWSvezq5BloU2mKD+g3xcg+ZqbikUqVxBdlskO+6Pnr1opAutgruoSVA4BOWnZ4HSao5nIUvMDwEtxwLhjKQGEu7i+IdanD3cLvybdXAOIWVwuT2KiIVBkVbpGRcUscgzqi360lLpuhWRARZxiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:38 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:38 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 07/26] hw/riscv: sifive_u: Use the shared SiFive L2 cache
 controller
Date: Wed,  4 Nov 2026 23:41:34 +0800
Message-ID: <20261104154207.641511-8-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f305a4d-38fd-4bea-071a-08df3a8a413c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261021135927099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: IzLuV33uWbRxOUXMkLdaAsi6zIg1K+T6Rw5acLdxEv19886sKuhXfVQdpVKjnju/O1tXlKndtAF+cCRbVLQRg8vcCQjxfXnMhZqSOmbNuPZVtgbkOmUM/qu9Ovt3HVYx/db8aKQOYKhOjo+4XoGACBAAz5wSc1FD8dxcrye10gH9LYjcWVKWm4rPT9tUaywVx/nc8kh6NEl+MIl6Jk2tja0e9aiUJimoGviD1BneUameMswm8ulpiZSnJgH68QWLDqhNlwPM9kyIxaUPCNFSWzEh4ze4icxoc4PSLJwuv0eQPedwgfb/wbtIH7IVxRNxS9PYDaVwOHT3v8I/uGv8H2HUIV4K6wkANGyULYj6Vv3un7fuUokmQu929qzjcd/nI+24lb68nG5HGxNMeTwfi2hF4YDF/1m7znpA4uGMw82L0rku1Zv/WLZgqESXwQUV0fcpcTgCqxERHDHrdUzVP5osgfP2xIjQrGe2u6C4qWpkPGlg/62Gbxnkm1+2W4H0AhmgfAnv4yPWTTZkGxuxW74/zik7991K/SSi5IGQhL8YLb4m884aTSML7xc+rakMpX/vdg44RjfmEPg36Y0Tz/SfJogi3Ps4EJr0AGyg2yOMD0bP+melz/f5xEtylH9EdsOBIjZsSLXraxOoAgZhjmnJGwex5PC/vAPZPt9M5uI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261021135927099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1O1xbnawsq6u2om0pg3iWe+0126i45O5H0DDmoK8ZXa6L5ml+J+5tE3UKj2?=
 =?us-ascii?Q?ZIIr/YzFuFNloqzllEZaa+y0WJUe0xqnvUhz5ons6MdwMnAnKtwiYU1xZuzJ?=
 =?us-ascii?Q?o7/X+Nka0+Ng+Hk1+A0vdhGaL+1HHMC47ja9zewsof1ADVi+b2Yw7NOGzZmk?=
 =?us-ascii?Q?s0bZ2iiRhmRVEZmmUfLrdtXmV+IY2l3SmBPjrAELYWykT0HZULa1T3AALm65?=
 =?us-ascii?Q?RThSrAhoIIqUwamTAUj7BShGU3vPIqmovnyLCW3TdmADVLTflOPggaNKKfgz?=
 =?us-ascii?Q?8HIqlMtRNbCo2srtLSbvc2X7Y1jc0lsgykbBWQrSmmWGa1i7zm1WxL6aTFja?=
 =?us-ascii?Q?oZBLykxowo3PxvMi5FyQOxdp6Pdvl3QlAJq2PHeWyy6fXcbbqSDdqkcJMMUt?=
 =?us-ascii?Q?lG63SswFUsWP7sBHPnZvrVs8qdxqX6ePLxe4Uii1o1nqGBRS9J+6jp2VtcJr?=
 =?us-ascii?Q?vluBnoY4DCocUNUbR8V0v406sNVZw1d8HSROASElSPLwS2oDm2TfOBOHRBmV?=
 =?us-ascii?Q?n7QUathpowXO2/n3sYaUndKS/GJEBHhCjUCmCJWzX/B+7hzVp1e1t3B+9t4L?=
 =?us-ascii?Q?gGF7kL+pGvEzvwqrdbELlkhn2XnKojFwirn51kkiGSSNiVwtYQ0MbZ2Qg4Kk?=
 =?us-ascii?Q?l+EkCaFi1hXTc7nCHmv86RdwyuH9Fi6VTUnkuZKz+hwl913/kObv259FxnWX?=
 =?us-ascii?Q?fb3eFF48JvQLpCEWxihGMFrlx+1766d5SKwZAA9Uqft6PbsK4VX772BL8Z9p?=
 =?us-ascii?Q?mWhPMsSen09MHrbyj9pmaPO95xZIQmg0F5WlOeRiFsTm2O/OFiyoFtshvMj0?=
 =?us-ascii?Q?RmUaRNWP3bnEghcnnfPi3YChuS/ZgjQeCBebKzJjinVvz/xBNcjviSR1bCL7?=
 =?us-ascii?Q?oXEG73KhCHUMa/9QSLfYGqs1lHiAZ7jjZfRvtfNbgvtMTVkJqhwhcH4zLFsx?=
 =?us-ascii?Q?PF3PHEU0Tw0l3XBpaPrcOQ+P1NT6bhSAJuPrOr8ONHSvs+1Nj+Od/F5NzKJR?=
 =?us-ascii?Q?B2rCcwsaRZoRZSY5C56WLUr6lnLGlyoWE0WKJlou9GeWUkt99zL3LQfXv11E?=
 =?us-ascii?Q?+SBcc+dxPINkGhTEN74e5RbVufMdQsDStIXuO9bhKeZDSe5XXclQftYVU7kQ?=
 =?us-ascii?Q?Znz/fEIxRYodALe93DJRwmm19vJ1fS2hSbPwjm4MVjC8Xd8tsMJMot0JnU+8?=
 =?us-ascii?Q?wYzd6+Zw2oOK6RVMobPL+I6qJVdVQ6083yTsr49j8UGwV51myzXUkYTi3ADx?=
 =?us-ascii?Q?myjq5fWH2DSatSNFQqcFlCJrNDJKH9ylC8zKvyEa9FRDgQMKZYCcIEPblBEW?=
 =?us-ascii?Q?HMdfE+Jm60/Cc9IzCYiaKUk3tjC9yRwr+ryVNUUQVdwCmJLCTXyxG1dasv63?=
 =?us-ascii?Q?/lYVrhQP68yMJAeGdRvQSUFYRONelgdFnblXhWwdXWveGaybr/M7OTOmFzWt?=
 =?us-ascii?Q?xhd34JnhOiGogAw2qjVOlcKTamBOxoLzOAftnWrfGN1TPt40l5J/yWOKagcI?=
 =?us-ascii?Q?i0KkYzXNNqOTt+EbG4sPFHZHxQUNq4LXehuxiwBkAHFuWcU38bccKJPWb7kf?=
 =?us-ascii?Q?haqMnFCtvjuxjkSu3vePhK4Sm7l8d8PUgu4T90oUXw1KXsDl2Xy2Kc+yUt5Y?=
 =?us-ascii?Q?oswNmImkzqjRbs6RQ7rcT+DG5G1E//2zWAiAft5BWlLn9aZ/JWf6LQf2iCIC?=
 =?us-ascii?Q?Dr22ThdCzBz1sBprr53A5nfNvoOmHlK2lvQ7ez29oYn5i3QHHXTXuJ8GP20Y?=
 =?us-ascii?Q?1bprNRN3/FalxtnHFQBrPLts6ZsY4IA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f305a4d-38fd-4bea-071a-08df3a8a413c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:38.5345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzZhpDohJmI/d5J/A3V4hyxdLDnjMM6E3gpjLBrHKMedEE5gkWrMAwgSnVQuzRAAlEQPQ9Oh/ENElHCWpSfOdYLrzzEnn49oAOVZfVf8Zb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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

FU540 and PolarFire use the same L2 configuration and way-control
interface, with different master counts. The `sifive_u` machine
currently leaves L2CC unimplemented and exposes L2-LIM as fixed
RAM without WayEnable control.

Instantiate the shared SiFive L2CC with 21 masters and a modeled
2 MiB Zero window.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

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
index a22ef994eb..19c6667ed6 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -116,6 +116,7 @@ config SIFIVE_U
     select CPU_CLUSTER
     select DEVICE_TREE
     select RISCV_ACLINT
+    select SIFIVE_L2CC
     select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_PLIC
-- 
2.53.0



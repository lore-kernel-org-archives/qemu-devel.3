Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA673CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD393-0007CE-62; Sat, 03 Oct 2026 13:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38w-00078q-DH; Sat, 03 Oct 2026 13:03:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38u-00075o-Mb; Sat, 03 Oct 2026 13:03:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k19x63vqDM8FHB7Ep+euim+VeXaszzPr4CjP0MjkMqwfKU6+0lmnYF1OGfoD3eLKoihZqtpyUz1puAQyqB3c443o2Iyct6Wv7gZ/pM+xEvD5qaIeQpG8W/4KzcyJrw8XJGztpjZGaanw8TWX5i1BJWn+QjKGXAKSaqCcsYZBVENUOJiD9sNb5trF4WtpWmQpf6GfHZExnbT7xa/wxpvQhthtBT0IQjkUZw1id+dD2V7DjZ6KMjHDgJ2f/tm08/NZvVfksMLolCLvPbunaecNc2dvRaUTdbb9ZyYToiTpOOmmgGbLrVXvgBEGTUmzW5Mc4fFmAdq69xwGnLqU7UxXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI+Kqi6huIG8VzcBiEHiYT6alcNO0Gh/0qs9SHx1bro=;
 b=wGXZoyEQaFQv1zuVFZF/55GPdnMP9FCPqrKSNVd6zhNtu0odPAhIun5aUYVskMjjTq8QQQn/knno0Ib1JakYBjAFrBZ4Gss4ZdUfm3qTbC8A55BA473by3VymPN38MuD9pAV+F4awBgpvHgl70IiRtang5Dq1Fcc/Lc9Z8QzyJlfQsHjsOYpcPwocoI7JrWMaKMYc8D+TzA3pk//vD/B167UQz38QUW+2gAmWIgQe8ZNG58D5wa3cJwtie2uRvClZrWaX/zJOt9ScEwhnb4hZwbd94UUtLqC5/dzHL2YHIdT+TVYfi3D3QA4VkAMAJqWlN03ooFoSMJZvCtCU0ox3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI+Kqi6huIG8VzcBiEHiYT6alcNO0Gh/0qs9SHx1bro=;
 b=Ag/KklUkWix0ilHdcrgkWD3JJ/+g1/IeJBjU5Cj63xkVMnNwK5wrDPbh5sjAWd0DC6/hQZlRPUGsOuvxaZ/+p/1mFrTWCMT7mvPB5NDOOBPm+8i3AWPjrDbNQkZggFlDWHZrUqHvhrJMrxsHNwp38f96yBEDEs8Eth2/xMRST3v+rX6H+7qIkheo7Pedb8XA0fU4xtTnu1BpsnFuakV5ONeUxDQK2akwwoXplLKNZWfOX0f5YbNabcgP1MYt0qu3xPolWTAvRPxmAV4Y4iudGkWKIwyyvp/IMqqZqI80Lx8XrXIALznuKJNZoALWe99C4wvFNGi42iEjP9XpBCcAfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:13 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 07/27] hw/riscv: sifive_u: Use the shared SiFive L2 cache
 controller
Date: Sun,  4 Oct 2026 01:01:57 +0800
Message-ID: <20261003170232.2450916-8-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7cd70b4-c14d-4a21-3e77-08df21703600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: R3THpwE/GNeuskM5ZPpfK2z6J3ZIzFmUXLKP+T61ggXMGVpSHCN86iZeCCfwJq2eG2eIfKYt03qxhlmhDXIIPMZIX8T3Rgn1ypeqvQay2M8+vohY7HFQq+jJrouVZPMD66EWlE4iiuvaA3IVU53yRPqWtoogShyOtvrsQ72YGJnjDGiIkFZfwRmorujY3/MqQEBuRjphrYshch2eYHY1OGEZWrNOpsbr1XbGkRzryoWQl+i66irEqaWWZT9ASj+R1/ZHc1v+DOQv+EknIW68aEgPuG0cdoQIjW9QTH7xZ41+3Pa8wg/tjCp0rMJi0IaDlUFwCRrooyQLdKy6KbXrQg8WgMW2gLKcewV1PVY+4sOU3uNwzNUZ+3GfiKp5IwzBK3Ggi86lDSewrZLgFbwBdxzelEmH28HrvbnSx50NrwAa2AeNvsUVx2ntbE4eQ74F4s3U6cKeaEP7WK3uwGrlz798DcR39CbgUsuHbkl7S+h/iM+2kjHFDD42kQiOSIJXTGcRp8a44+uStTKgj0/mLPhiVQk0lG3gms7lEABhTwHxo9bIQCKObZl6iOjWiIV3Nj1aLq3Q7IckFM9LBkhQ3t1z9TnSEch6aLQg/tYgiGZl7El6EgSEKKbyWkrmKMnQnm4koGxHe2oocBhs/y9T2mp7wF5OEM6ssio8/KBbRRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cr99dUoEgTlQKM1e9V/gnjkTRnITiB7/TNJ0KCjn7FYRyvMEo7zegKl4B8yR?=
 =?us-ascii?Q?42rCoylSJS2pMnmsBpFol3pNmXRoCJAjAbGpIRN5Tbp9cI3ur/U4Ay0lzX9W?=
 =?us-ascii?Q?LXGiG2Lv3WIquHlQRk1b03qzP1X4oXwkOEs3garQTymd+j03jVV3z7K9/Nyx?=
 =?us-ascii?Q?QMxmK8pPd5PeKBQoXdeIDcXrkP/XBAVMphcR3dcR+5muefz4rnSdOnLFqbYa?=
 =?us-ascii?Q?ymQHFb5rS0WF7q2Pfhfw9Bvs/Ke9X4HKNPmeYqKswmU37IDHv2Y3emyFg/St?=
 =?us-ascii?Q?l9mH47GSXBUWTe2Kbul9K5GuOs7HqOJYYWCVKk8qCEhabOItH76HYW+hwO5o?=
 =?us-ascii?Q?kXxbF4Jaoi2H+VC6lIzkhf2yXgowD6yxR8VydS1f5jbU5HS4KuuZ+piPuYzs?=
 =?us-ascii?Q?APJCwCF0FRAqLEdj2JGh1zYKnF4RvKUQCRSQkKVt/40Prh/Dzo6+fZy8+/VK?=
 =?us-ascii?Q?Rvcm7iP6xPQZ1A0/VQ9QN7N/w80LLraHmeU2BiH56Rl5FuaKoHVOMa8figbd?=
 =?us-ascii?Q?nD0VGl9M9XolGrqewRD9MY2twGAMBkQTfMOjrcB7bdFdFgDACxoIuVuvx6xQ?=
 =?us-ascii?Q?9kzmNaY8VJaT4yvCiAxQzoE7PHqn+fEmiFQqUbzfnmf9riMtvvCj8JzopRhr?=
 =?us-ascii?Q?pdzoHPrZGZ93nG/HvZky5vUKbY2b5O+4yW/JYAq062sRbpwnh5WpL+3foAHs?=
 =?us-ascii?Q?vqLvWMfjZMcmd24o3lFtxi9XgN/f+0hzQqTb1REIver4DcGZmmBlAY1f8Z8R?=
 =?us-ascii?Q?JBG/hLw3+H+YPCgbBXZmU+Z21+nJ1R6Nj1ojHa2m0sOiFUMOks8BDt1E56WK?=
 =?us-ascii?Q?N+Q3ft5BC5nydhasjIY9JIzMr588LG83DqfRIczB5FNjRWqsUrO3hVhj8JGn?=
 =?us-ascii?Q?fU3GCKXO3B6SekQ8pGYfazBdIsV/5TtGjKfMtcwUZPeJxMWyq6tHVYHv8cGm?=
 =?us-ascii?Q?lowuegZTJXsN6wPdNkE2gFNVGQD28MfNOJpbGCNsSQwUGVXXL00RUKWIPufQ?=
 =?us-ascii?Q?wU/q7qDT27rIQB53jnGBnjcZZeHQqBQLbgNPSXKFvht5RJIFuYzO3J+N6NJR?=
 =?us-ascii?Q?ZI1gMPrjGihSXru5TB3tOMZr2EGCZAZanDTIsXa/VmeQT8YbjDUmN9yjX3Pn?=
 =?us-ascii?Q?VcuwtpRA1Mr8XlFJDDy+4LK43Mx2RibHimq5sx0vl3X5MTojrd93U9zIbgL0?=
 =?us-ascii?Q?MCwD8JbQ1lt+GtgJFW0lN0rpidOPKkFtK8QCYN/sspfes+0vto8VhzPpFmPU?=
 =?us-ascii?Q?y7nEjWJmyVwIa41e8ewl2HWxZQNmWMedz7wiGmR81F7UtAQijw9dKSAbhLup?=
 =?us-ascii?Q?BJcx7AO/xey35ITQvxkpqADdDTS6cbcxwiiGOAsllvJdrSx/WxpVdBte2MIC?=
 =?us-ascii?Q?KHg9M/ADGX15tzigvI46KUKcGg+6f+Obaagx3OOmBqqK08+sFFB5m7fOuIa2?=
 =?us-ascii?Q?yaZjDUG0FwioyB0ryEiF6tRny6AJZC6kucFCG5KU8yvqTvSGMqKWcrLDA+5W?=
 =?us-ascii?Q?p2DNssXJ8ceW4EprMQXu+qK5BDvsBgj4jwImImNgYG0MZMhthJ19o9zfYYH0?=
 =?us-ascii?Q?6KUR7STjBeRbgOovv0+EZWbaJtXK75pp6cMVy7UJWQODTtbPOAoVcXBnoSdP?=
 =?us-ascii?Q?NTy3TKI9k3p95LeXtuy/FnL3zVE84FKuiq2TvnNPzP07ZOjlfYhKhKKtHA1C?=
 =?us-ascii?Q?pjhPZ/m7tDSe+IjEvZX+Xu8QcTNLbJwgTPIqUuksbsXZJzFz30S+DlX8CuS2?=
 =?us-ascii?Q?7o7JeVriW/O/VjuAyi3OG5fM+LoQCXI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cd70b4-c14d-4a21-3e77-08df21703600
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:13.7228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T45jIxFQiwzC+DFM4xCp+fKeJArrCbbunJqiqGxx+dLnqX7isUw2jhQvRSu35vi2s5qWIrCvyCiz/4vXza06gcJx/PDRtJwQwXLg22biumo=
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

FU540 and PolarFire use the same L2 configuration and way-control
interface, with different master counts. The `sifive_u` machine
currently leaves L2CC unimplemented and exposes L2-LIM as fixed
RAM without WayEnable control.

Instantiate the shared SiFive L2CC with 21 masters and a modeled
2 MiB Zero window.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

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



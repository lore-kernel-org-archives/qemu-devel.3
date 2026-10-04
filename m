Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC61CA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAU-000615-Ex; Sun, 04 Oct 2026 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA6-0005tn-Fz; Sun, 04 Oct 2026 05:05:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA4-0005jQ-B1; Sun, 04 Oct 2026 05:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjq6VWDuzyf9TqvHLW0j3lKYblEmNNxckr+HFeD+LV4+8CvySqouIykNyIZj6cABo3pLwee0FVcF1igM8c67bxEJlyqmClgNLvWI8uzbi0ImZwCdr4SsxL/A3Hy5v3YBurccaM/K8+eSt/5cDbLXSHifASnQTevQOwCiQjC6sgJ4E1Js4IbaD0k2n+k4isBvnDhmyNbhXLMJZjQtIReaOySdww7sKLz/+J/Cdu7lSh+eoPikXJ+PkefJ1xtw5W2VqI/YzGonLQv/N/Hh1nADhYSiGYcojr3WmV5fdHXw5ugqzWIdN+rVmC4tCl3oE6nm+SI8TTjTv8jQ8a1kRTPM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVm2jxbwNek6DrJWHY2h636wQ2gzor3ZJLKJvuHnaMY=;
 b=DxtfnxcbxGzMKDJIvhgseFjGfYknoaPG4rbLu8FNpfPh3JV3s6WMo1VSx70zQr0ACieCplpX0OI1Vggjg4BNjJ38QqeGuLDqu9unlrbmOGgu9nPwO+aHfHsqykIppBxvIk4yoVdD99SUSLovh3yf6AZP9VV0N+2zmc5pD6tVbBjgbOkcQX/4+yS/Vi4tO7MV/fvK6xoqSwN6y1LWF+6NVGZqsFDSE+MEQ7kdw7e1RqhY4cYzhc7rpmaelUALM1BVozJjn65Hm385MYTWNJj/DzxYlQVoQLF/eB+T/f1PGOwdolGPu2HCXAbt97kOR/2Rj/l5s0H6RPzZMmiQabALwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVm2jxbwNek6DrJWHY2h636wQ2gzor3ZJLKJvuHnaMY=;
 b=OBxarEf8DhSFGhJEo4h1Qs37HQ6XGRCLUGCZbtFA3de42+TTYLgD/3TLoW2njjSy5jIPec25epuUxiIM+sj5QYQ7kUiAtvPBldmDmLR1Okr0Z1Syu8w1IfuXs63UEex2BybZhbsu3MUvWcy+oZ1e7MsdxUB/ArUf1hinpI6xUsB+RDGU7JK6QZVoa4A5SI7svJLXjq+a0z6Pn+3Z1Lp5ABXE2Lb7pQsL8bMI1QNGu2BcrQ2WoWpRjubBUqhRvTAe4Nv9EeNMUuSgOwq6+08US3B+f4TI2vt7k/iw+hahM7MMp6zDiM+y0JlFaHM6dqHz8kjpNI3zvVOlbh96Me6V9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:25 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 04/10] hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
Date: Sun,  4 Oct 2026 17:04:49 +0800
Message-ID: <20261004090500.3082641-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f75a20-037a-450a-ae94-08df21f6a0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZY/E4x0FDPWVkqwzzlc6EKw+pOvVnpYFlGOklOTi3RW9egRS/XajDOMH22WTaRX4Du4ggHTVIxFDXIcJKdB+xJyya7N0VaS45yD5gS7oAi6naubsQH92jsl/UH1bdBILvbAtTJ44YsGn8+FB8Fvejp8TDPY/TwUyf4wTh3hdyU7pQ9YkVDjxn+y9pow1reKr0/XlzfBvoVcSNhDIMjvgn+zLxxAYe72jM/P47523nePkFm+s2T696TGQVcb/8eJBnXBpeY0ans2xDR7M6SvxP8THWW9MVrKx5qihsi5X0HEXQhxR2+jpSa+SPs9YQ9zNjw+DO80zzE+HKhI/GF4izq3LwTB8cx3bqPvQF0Efoy5aRZkbpoAi82Vm+k5Uk7i5ldiYzhvCWejd1vcnpaWNW+MjubGPE2hHbokMJC4a8emsxLXKWCNU/Em5KqsCq1Avdy/Ccu3SYToNcvkS4+GjrDnHF4rp63nhj8QUv9EpJdJ3EYYi/X43jopAWg8Hzwom+L11mHBg15SIXG2qDXWTkAnvi9fjE7+x9tPAOHCY/NArHgIhRxg4nFvyzQk3pYJS/AedjYZtoh076ABP73VZSD0NHQMoV0Vol8Y2Yo3zoHz+evcOQm1RAZ1w+dzqXWGliJzZytAb/4Qt+IpluovVQHOOuKCNb8W++zv/FLtjzy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGa5WRNI7IB9bUJztd+kNvZa8toEyqXbngLl9ADv55ZOFlFAXRT/iptQvvdE?=
 =?us-ascii?Q?5QjOdoxY/q+gQDciB4tFACGVAeOw2fIIs9vXRXAia9tvBTR02GrWZ3jB5Ce2?=
 =?us-ascii?Q?3vKMTjm9dC9RdACP56DRuFsKx6R9XFbu6r4V3mbubBwpSv2GZpQEqMRmzYvF?=
 =?us-ascii?Q?nxAY3V9wc/zDoEJcTNfrKfQYfRe3t0TR2WRAhapu3/M1t8kJBRo9Mex2p/w7?=
 =?us-ascii?Q?QJTVZEsiHljkXTxNni4KwRIPGkRF8rgsu7yDjYiIxDnLxo96HOxKc4z1dwI5?=
 =?us-ascii?Q?ECzENF+VaxTWexxubS4X/SKA6IC99q63uoJtXVcaXOHwQO63oX7IcEHBbSpB?=
 =?us-ascii?Q?5HNPZNnzHXOamKEQQHUmsHrUCV0jpbbiByxSOg2ezUhW53FRK0KlujWxKzL8?=
 =?us-ascii?Q?sdlgWBUwCX8jjA/hzoy/UhaMECFBe081HED4KWh80jKbvDcyrmQRbENcQmJp?=
 =?us-ascii?Q?dpntuoWpPoZPkGg1mq7j3a8UC06sRyFAVlDkiBqVG8RnSCpF5AIc2sTyCKWH?=
 =?us-ascii?Q?sroRP0XO5fgZHbqLxwuogI2biS6ouTO4IvXSGoT56V+3OuzTjud5+cFQiR2w?=
 =?us-ascii?Q?cG+anJR8CliMB0zghGMQLvN6vl108fmsxchuW42Wm7gmGgDomc0vZD0E9bws?=
 =?us-ascii?Q?4piqpagE5TGBI5RtFCTnujOuU0ALBXlUoOBasNO1G0ryGF7dAHpOWXU4vv2s?=
 =?us-ascii?Q?r7rUrXucP8htgm9FqWtL1I+Z3nAS+UssKjqPs0OkPjk5Rw2ozzFd88B+mOdw?=
 =?us-ascii?Q?Z3YpQE6NcXNB76zWcpS6VbA9G4VX3EhKWk0JiaRgNMz/oDnIoa7xZ3AmZI5H?=
 =?us-ascii?Q?64caMPpqVrcs3Jiisk0w+Q+us6l/e7Ls2md5TR/1oPsST9eJ84WH2olC0Nnf?=
 =?us-ascii?Q?BXXmiSZa0ET3/wcRd+enRCHn2Pt4a+Bjru/j8zOUatycTIiRIkFqDJfKuUbs?=
 =?us-ascii?Q?NGm+kX0hnrWjLzIPfH+bUcu05nNjRMpozLXFonMWpETeeQG/HVy6uv+ZfG+0?=
 =?us-ascii?Q?mL29YNuKl5BzPAxzHE73kGDZlQEluylOvxL5g6izSk+Osu2M2OaysrAoh6IT?=
 =?us-ascii?Q?2XuFKDit1aKHDkOtMrs6bEoxeIZkP2nv6uGLOmH75WqyX1MJuYUjSnyDRsb1?=
 =?us-ascii?Q?c4siTuCvtjwaS2gsSEY7Zq66nenaKypnfdj9AAvFx4gI4KOU9NXmKsZeC5R1?=
 =?us-ascii?Q?vg8hb2gnazl/qw84HAzaedDed4G7RJSDWGvf8QsMeMeGHnAmsOTtwW738VYH?=
 =?us-ascii?Q?RQnHYHWtgvlXXVfIQzuz6TTN1BOeW24UAcvXwx4wRergqH3zKiamPdSPD9uG?=
 =?us-ascii?Q?pC0Gi+cvk9A92zUyEKC29bflgFgUIXpPPdFSalaprZI/Fqp6UKGCPeMOSnS6?=
 =?us-ascii?Q?RDvzNLdXQkVBQnPBB4Fbvmep5rKB/xFKfAbmtkMr4sGWjBnTyTe4mm9QX+ED?=
 =?us-ascii?Q?GXoQfsigTJKDKcXCuCEsLDCyTm6weP37dLc3AAsJ+s9NU8FnxE3haxvjIcoJ?=
 =?us-ascii?Q?GDV0NF9Lq+9J/chxDo7mkMoz0VEbZ+Kn4BlLbNQKzmr7YQ3hUWW9MQs7gTVH?=
 =?us-ascii?Q?QgMDrS7N8gH7MGczIcgFZ1J//DB/wBY5mPAUkDFw+VUZHz0ouM8Jv2ShirTK?=
 =?us-ascii?Q?cv8UbUEO505jcS2tUC3Omkm7Xn24Qs4sDR1bgclR5P6E2idzECCkAjFWGaHq?=
 =?us-ascii?Q?FSLecFqCYqNecsISsH12Yas8Df71p3iweN4HZJVqIAjw5uuhSBrizeZo47Gm?=
 =?us-ascii?Q?Mbsajj47wb/WZ+qylLtZV/89H+6xziM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f75a20-037a-450a-ae94-08df21f6a0aa
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:25.2319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOlrHS0a7aSGURgcsI/l/xkr/J1Y2+6inNYrvynbAbEDVzVtxLP3y8X0l/vH3GOr919sC6SeAnDlWQC/cK9EgGkh62BWW7ivOEGzGthC8jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
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

U-Boot probes DRAM size from the MMDC MDCTL and MDMISC registers.
The existing unimplemented region returns zero, so U-Boot cannot
derive a geometry matching the RAM mapped by the machine.

Replace the placeholder with a small read-only model. Use the
8-bank, 16-bit DDR3 layout of the EVK and derive the row and column
counts from the machine RAM size.

The MMDC permits 11 to 16 row bits; ROW encodings 6 and 7 are reserved.
Preserve the existing layouts through 1 GiB. For 2 GiB, use 16 row
bits and 11 column bits instead of an invalid 17-bit row.

Reference: IMX6ULRM (Rev. 2), section 33.12.1
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Reject RAM below 16 MiB instead of advertising unmapped memory
- Keep power-of-two geometry bounded by the configured RAM size
- Use 11 column bits to represent 2 GiB with a valid geometry

 include/hw/arm/fsl-imx6ul.h |  2 ++
 hw/arm/fsl-imx6ul.c         | 72 +++++++++++++++++++++++++++++++++++--
 hw/arm/mcimx6ul-evk.c       |  2 ++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b77..bc0baca721 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -90,9 +90,11 @@ struct FslIMX6ULState {
     MemoryRegion       caam;
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
+    MemoryRegion       mmdc;
 
     uint32_t           phy_num[FSL_IMX6UL_NUM_ETHS];
     bool               phy_connected[FSL_IMX6UL_NUM_ETHS];
+    uint64_t           ram_size;
 };
 
 enum FslIMX6ULMemoryMap {
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 92f8e4b4b2..1452193be3 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -25,17 +25,78 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "target/arm/cpu-qom.h"
 
 #define NAME_SIZE 20
 
+#define MMDC_MDCTL  0x00
+#define MMDC_MDMISC 0x18
+
+static uint32_t fsl_imx6ul_mmdc_mdctl(uint64_t ram_size)
+{
+    unsigned int size_bits;
+    unsigned int row;
+    unsigned int col;
+
+    /*
+     * Use the EVK's 8-bank, 16-bit DDR3 geometry and vary the row and
+     * column counts so firmware observes no more memory than QEMU mapped
+     */
+    ram_size = pow2floor(ram_size);
+    size_bits = 63 - clz64(ram_size);
+
+    if (size_bits == 24) {
+        return BIT(31) | BIT(19);
+    }
+
+    /* ROW supports up to 16 bits; use 11 column bits for 2 GiB */
+    row = MIN(size_bits - 25, 5);
+    col = size_bits - row - 24;
+    return BIT(31) | (row << 24) | (col << 20) | BIT(19);
+}
+
+static uint64_t fsl_imx6ul_mmdc_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    FslIMX6ULState *s = opaque;
+
+    switch (offset) {
+    case MMDC_MDCTL:
+        return fsl_imx6ul_mmdc_mdctl(s->ram_size);
+    case MMDC_MDMISC:
+        /* EVK reset geometry: 8 banks, bank interleaving and RALAT 5 */
+        return 0x1740;
+    default:
+        return 0;
+    }
+}
+
+static void fsl_imx6ul_mmdc_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps fsl_imx6ul_mmdc_ops = {
+    .read = fsl_imx6ul_mmdc_read,
+    .write = fsl_imx6ul_mmdc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void fsl_imx6ul_init(Object *obj)
 {
     FslIMX6ULState *s = FSL_IMX6UL(obj);
     char name[NAME_SIZE];
     int i;
 
+    memory_region_init_io(&s->mmdc, obj, &fsl_imx6ul_mmdc_ops, s,
+                          "imx6ul.mmdc", FSL_IMX6UL_MMDC_CFG_SIZE);
+
     object_initialize_child(obj, "cpu0", &s->cpu,
                             ARM_CPU_TYPE_NAME("cortex-a7"));
 
@@ -176,6 +237,12 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->ram_size < 16 * MiB) {
+        error_setg(errp, "%s: RAM size must be at least 16 MiB",
+                   TYPE_FSL_IMX6UL);
+        return;
+    }
+
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
 
     /*
@@ -219,8 +286,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * MMDC
      */
-    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
-                                FSL_IMX6UL_MMDC_CFG_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX6UL_MMDC_CFG_ADDR, &s->mmdc);
 
     /*
      * OCOTP
@@ -736,6 +803,7 @@ static const Property fsl_imx6ul_properties[] = {
                      true),
     DEFINE_PROP_BOOL("fec2-phy-connected", FslIMX6ULState, phy_connected[1],
                      true),
+    DEFINE_PROP_UINT64("ram-size", FslIMX6ULState, ram_size, 128 * MiB),
 };
 
 static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b..bbc964a3f7 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,6 +44,8 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
+    object_property_set_uint(OBJECT(s), "ram-size", machine->ram_size,
+                             &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
-- 
2.53.0



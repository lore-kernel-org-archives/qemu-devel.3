Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD7BCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr2t-0006bb-LI; Wed, 14 Oct 2026 00:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2m-0006aS-1U; Wed, 14 Oct 2026 00:56:48 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2k-0008Iu-49; Wed, 14 Oct 2026 00:56:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qClNCdk+C0sdpih0kDmzxa0uDUnDYAEgLKQY8UxSxzwB7rRCa0y4UUVhxKGQLrKixaTX5zm+m1M31SbYcp10Cq4Wmbsota49a0ef+WRqUkukgKvl622EstMy0x5cEuIirUXsbof0cKGvCy4cO5N3KJzqTIXuRj38pF5wt/8IFVxROzOeJHUZy9t9jGbeON//w93Bz8ptc9H5sRVIK+BCusHTwl2S2IFE6fI4saA/AaRCtBNQbqXNdbDTetV8tYWkNL3o7/LtcjxaT/Pu7jMI3wwW+wiNFd6kiDMIz887gUaBiOCgpBZHDSfhDd/FKU44/Pqu3hV/l5TfHKYgcrMzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vh0nl26NCz1GHdVSGzHUTwZgwsmnchdFqz58xR8ziM=;
 b=pZSZgnKjjy4Av8VxX0Tx5UBfSFHoaHADzVVLdG5Y61jnZ/8CQCBtnP7LrCe7KK1BipsO/7hT94kAy9beXnwM+nLp1pEPD2O99O4d+awUm1cjP7T41mnahgwDoPFjUOrNlqe2QyRh6VLuSl4pYl99WKW6YR4N5ZkDoe2jfJ2Es6UJTbboD9sCi8si1TBQoiXQltZ9Yxbo7uOAz73ZemaVzhlbbVCgPJknYR57nLJU68iICU6dAHFqqn5iasRj9ayhdjZ1jKHBdlwCuqgNXSfpx09eV3DSuy2PJr3LJK9o1oQ9TfI3p0WyElMvPXdsmoIkSh56VBlE9InTbJif6AWoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vh0nl26NCz1GHdVSGzHUTwZgwsmnchdFqz58xR8ziM=;
 b=fvyyd0B7jrOypCTo7Lv2AInwO4RmNcH5B5tHqYjIUmI99ffS2D+H+EUG3gDauJtHWp5tWAISIpJh0NyirsD6ik+QE6HxeKjr5GBoUO26udVFNx4a0xdNTAkkTHtyUzpJVTjIJZ9xWxCJmG1Pg49YDce+8xZfmI1ZyaKzYSnrxY9qAw+cyveXtmydEPE0AHiuIcOPQiPyMeHOMZY8u2mnptlm+lkOuBZspDQWBY6/XYWdYMRwQkFeYcWEQlVA2JQygY8r97M0y79+lmLR9ktmekPqBsao1WtKmmY5D4kakfDls4bt1mqopcPpR9z2/2QsZCwNVZvLQGhs0Gw/la5BIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:34 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 04/10] hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
Date: Wed, 14 Oct 2026 12:55:54 +0800
Message-ID: <20261014045605.399684-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b93d1e-23b2-4176-24c9-08df29af854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: IH/kG6Qsdfdf+HqVOafvvsnRqy/9F5d6qHRauvfozGvHsMb9RSygMXhfq1JTMPJrhgggQvsNCtpOhVM6iN6QiHnxHiGTBDY0VwMfWoq05X7RcboX9m8UJTBzLD+otnu/2UXgtiZhrGaDppkXomH+AHrVg5uZGzf0eatdWxI8NB0d5LhWTYOJt1wyITBSkP8wnsqFU0Ub2WVUuytevnIaBnwi8Tu5Mqhp9buu3xhsl8HLmWTD95gC3HEVjUrdPB2lol0XE2lUZsWkvVAUko90XyfivGd9UlNKi8e68aNxOzK1az05RwnKaXhi37CFwWH2cf91o5mgzx85u4CS+efKl/aL0HefJ5G5e9kd2EU4EddKzNJUpywvPZQj84SGfzsaMCBIrZ6NSrEewyhgH2TdZEHD2hminp08gH+QpEYP5ClnnLrsBmDyih537A0+E54qUfjhwsBxtLTjrHem6fYOTkeRlKB7Ef1Tb7YCM6jyMao62Yu9xaEaovp5ywfIoZDl+S8Yjb4o46XPIu+Cg4aWrx/OwEMufKKc+SXnTm8vNvzefbypQIWvHagH1A2xQeRPgitjm17n5BgsAmKYva8aHSj4SXm8fFWk9UEtVGvj7IqSl8j6ssvKYwx5OMb+CG2AJmuF/1K9IzX7aAX5/xyuqdc4ZJr80ExbICEGR/S09tA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EuNY0NRa3sKUvPYMKAARlXDFT7DH+S657tJdGmn6s8EGiB8y0TXs5Y/xSTjm?=
 =?us-ascii?Q?muxKeh1tp/Rl+nz18dWp+xZMkytc7UDl8v8QNqRjiXJS9GcifM0yJ/Du9ZvI?=
 =?us-ascii?Q?FMj8GCkji0xvE4bUWDjkHmOnypjRv7OeQz9Wwvnhq0jql2M0C5UKi4J4Av57?=
 =?us-ascii?Q?/4lzipX3P3GEhIoq1TAZDk2MsK6c1zjpr6t+/qD11Yw7/sjsCCJOcon3MuBo?=
 =?us-ascii?Q?CL24hTc3lytx74UYF+tEc39JlrouS8G03mXj23KNsBhEPu45ht04AA9oeknb?=
 =?us-ascii?Q?5tWUW2c20zRAsQs76ypPc8woOvvgh6DAtIjcV26Yn+a+LTaBWBVvbmk7E2lq?=
 =?us-ascii?Q?TDQiYanZlutZK3JHR1T0a0fTen0YNLEIf121bVJpxSGnSlE4dYLMyjbdXqgA?=
 =?us-ascii?Q?sf7HY6wwkDg1Q+13R86oPJtr8wxEv9N/mmcm/8H5UAJxbGvsTKJ2L+uV/yGC?=
 =?us-ascii?Q?yzz82UuoLHv1QsbVLlvUCRIXsjDi4EshDlSPXjP9SzaNh8bIHtjiJ2wPEuiC?=
 =?us-ascii?Q?m1SI+A+AXYQjeHaHyWmBNuK6diriQiWvMtU4+SJz796KKKGdpOw1LzHTcMtj?=
 =?us-ascii?Q?930y5kEVPUYGcSNnubAINbrAbZMA9+fFIgIIrHOn1BDpqdLmsQAEq1kS39by?=
 =?us-ascii?Q?M81D3AeBEeqsD2/ml6GItHE41v0Iyi1YrMPYtbhqh3RKxEPzUsfrvfq86HfR?=
 =?us-ascii?Q?ZIf2Zo5Y+p4x0T4AT5nu2x22HdyZdq8T6L8gYh5nLqN0uV9QmL+T8ncj/6yk?=
 =?us-ascii?Q?YNarQKKMo9Ggygga/VLiFvETTvpSGoXbREfdyAZUSnz2qNGD24WosCDwaFWc?=
 =?us-ascii?Q?13KBsk1dF6+XDYYIcHykHDvpimovQKx3RXk4v8j+ALlI8zd2KVU4ojimKKpZ?=
 =?us-ascii?Q?cuDd0czmR4NhGo0EXpLSSe4eTzFlITcEaIazHRlwmdtTVeV/MaT79RTzbps7?=
 =?us-ascii?Q?jvLAxZr6K5RObWscZWGNSda2CQp5JRpTwwCugTVVSmw3NOA0ymZY4npIg/Cp?=
 =?us-ascii?Q?PHBd51LHx9EROhiyU6qkNAG5rSbfF7kJhJvLzCFjnr+Yw83NPjxiYpFA2ZUf?=
 =?us-ascii?Q?gR8r5DcWkJ/K0ip+sY32UesbboWgvY2hZInRYqtF9yaALnAJY2pnlyQVxKfR?=
 =?us-ascii?Q?k5na0HgslE1ndqfuTHjyjlSjRo3blIRrJRfJDjFKhqqUE8jU9y1aJemoftRk?=
 =?us-ascii?Q?rW9BSi/Mt582js7akxukk8yrpYPb0qVYbYzQ8elikiBT6GFrvOFzKidImSCR?=
 =?us-ascii?Q?zXzm8MT2LSFSytt9xhL8/g/3j+YYxSjoxH+LhejB0G15PXm8HJxcy3c0M7ig?=
 =?us-ascii?Q?sWVCFNuYBDoscSsCfjxt+oca3pBonvh43HDyJaM7ANmQ58pljitoTgz+FVuY?=
 =?us-ascii?Q?bbdHwShjMsEjAqH3vPAGvdRCYlJ5qH96hTmACrALKeXlqImyB4TBL7r7JRHw?=
 =?us-ascii?Q?VaQjGD2xniFzOpx0EWL9JoPHKG/Acr+UPrgCi1aw6hwZ5iDlyM460WquFZmS?=
 =?us-ascii?Q?Z33hgErbIUdEgaSa7d/IPnusuVLileW4C/B8DdtnhqUdgm4zC++B7Qc0DtIY?=
 =?us-ascii?Q?WOh59w3u1dR11wO0mtOB5re3Y/w029I2qVJIr5flqC+F0MMTc1lHj2Yn0Mvp?=
 =?us-ascii?Q?J4AvaChAktREP4i/2EYG7ik4C+PMba6DYQFDdFyrsxs7nNgeFpUyygfshQwY?=
 =?us-ascii?Q?g4sWKGJw2r7V0iU7swjMREj+UB7BlZBKZB0EOJkszXOuwGc7lwH456nH1AQX?=
 =?us-ascii?Q?hZsmmN0KqzR7AYpALeV1uA3TyTu2Y/8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b93d1e-23b2-4176-24c9-08df29af854d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:34.4015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yDUrqBAi7Qs+Yw8FaOImfQaXCPF4AEy8q3/2Wjg+zU0CLwAI23rVBsFb6ElQI5uQeVXUmPtw+xdZNJ2zLueeDknXCMvxROIDHbjwSzvh7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
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

U-Boot probes DRAM size from the MMDC MDCTL and MDMISC registers.
The existing unimplemented region returns zero, so U-Boot cannot
derive a geometry matching the RAM mapped by the machine.

Replace the placeholder with a small read-only model. Use the
8-bank, 16-bit DDR3 layout of the EVK and derive the row and column
counts from the machine RAM size.

The MMDC permits 11 to 16 row bits; ROW encodings 6 and 7 are reserved.
Preserve the existing layouts through 1 GiB. For 2 GiB, use 16 row
bits and 11 column bits instead of an invalid 17-bit row.

Reference: IMX6ULRM (Rev.2), section 33.12.1
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

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



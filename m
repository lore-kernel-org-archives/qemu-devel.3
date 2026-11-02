Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7DD606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gdHB2HQI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwXN-0004wN-0m; Mon, 02 Nov 2026 13:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwX6-0004u8-FD; Mon, 02 Nov 2026 13:13:25 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwX4-0003Yr-3P; Mon, 02 Nov 2026 13:13:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8Aa5yzjs/7hZMmV5QAHZW0byDH+7dxPhJFtKyD2Q3ZTB9hBe1J5YlzYRrAjfd6ddP0yIa7P/OfwCWSk21YAeIBG8vG0G2j/m2QLUO0cztWCV0q/9RJpZpd7mHssXLgfrkaz5y4suP9jT26W6Ba+cX/BTZwDRkbPStZmHX2ZOzD9xxqajexhIu9bUqKfTW6dUK7XoWjHhErCkzDJmaE1OSAf8+Sj0BAXJ8d3yxBynIuJGuoejbiqXCQfzxRLoWSGLyRcZvB1TRobjd8W9YwlX2poa2xeK8U8UbfOIO7y75QfJJPVf3W66HaHenjSucjT8PaACsuZYqwTQeQLGYkdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU7Thv1/lEOXmAbC7QqHSlICafqpjGDvpVz29Sva7f8=;
 b=GjLvh4/oWxrXgj4wN8Eb3OJxPDjPHmkw44jNDLdeFccLUwfZuSlIOJZE//6qBkq9K2Vf/m1FeC2stl0TDsBHQpxdxzxIA0ni5IuuVKhFJjf2SEJq1CUM+39FeJGeBjno1gGM2XBEktKqayC+7RpMFr7AvtthPpEqT+5mEmAi1mlKYr1x8go6CCv4lPqVm4y4iNGunaL/qxB5TJoh2ZjF49INAxkAIcYzSJEjItOZ3pSrXv7hgKsrD+JLso+22rmOr7BLfKvH1KF7EEZ80DIVC5onFh1JxqPnYRi9FYnnS0CtYz/OtgpFVJ68rLOrH5e6MnygVzKw5LLdaMr2yqmZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU7Thv1/lEOXmAbC7QqHSlICafqpjGDvpVz29Sva7f8=;
 b=gdHB2HQIB4eHvcoexDCC1nFVnvnw/a7U1h14I6HB+AoO3brC8VcS7nO4LvyJA5ylMcWSoAT/GbyZS+IYe6+875rKf0Df29/jgFi6sY24iLoXlFw0k0v4u6l4K0lv3ZqPCw7hy63MvEJrTxvqP8o9z37o6a5OtA9hJSycOA+U7zpw+47J6wLrY98XDl15SXX5zqN4qVanhfzAIKGxxfNsCaNiKqpVNF+kTlWfOk3ngOh1mUVm7rl8nb2lHc+miKWKPQl3GvfpW/Owg2qNhQYYcj8GSKI9I7qH0bZnUSxwrk3mSCqHzIwQLyjDlvCW39XfqFHvBgIwB+RWIRNu7BhpnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by BL1PR12MB5993.namprd12.prod.outlook.com
 (2603:10b6:208:399::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:13:05 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:13:05 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, tdave@nvidia.com
Subject: [PATCH v2 5/5] hw/arm/virt: add highmem-mmio-base property
Date: Mon,  2 Nov 2026 12:12:41 -0600
Message-Id: <20261102181241.3077981-6-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102181241.3077981-1-tdave@nvidia.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::11) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd80238-8f12-4a03-2ea4-08df390cf07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|11063799006|56012099006|261009223027099003|261021121427099003|261026121527099003|10067099003|22082099003|18002099003|261102123227099003|3023799007;
X-Microsoft-Antispam-Message-Info: S3EyFKnzQwTK32otn4x2Cyrtrv50Kb+fVwhKpvlF9MtBMRm0Xk9fAO4DG5k6CXN1Il4b/y/wIq3CeCSrx4Utj73f5ct7T2o2OaZtYDZgQQZSFw8Dp0fnv/8xFlUl4KSpjRQlauvqb2K9OyCynv1IWU8qyKzyboEYG/mZjnRyDMvLDTL3d0iiSfP3y+TDi9fynqT0HkPvfVXuyHN5iushOO52jQOwzEE4vVYsNeq8lo8e+QgpQJlrYxA32ocTqKhDdiR9+SknH41exoordcvAU8Zf/6rn+LfBfhzTPgAtQD8e6wpT1CFdndypr7cVJJFeVS0pwsfSBm1+04rDBncv6Pe3cIiXnsj9EqgUrHCK0MGiOvQPs5takRNXPDFrUPOdFgIAzF83O7+hPWhX/yBG/MbfxuGVAJzqXsmKLIJJJyeaDI6C3F2mm/BUYM9rg/Rwl0ji033qiOw3ciaaCZN5EPyG3R/ymr2FiYvsLG9n4B3e9r0Nw/jxlQ3i2jTg2TtlIGjyEGQTiME4EDH4MV1m0xrjBqnkqR1FRNulWPPwwcUIUjP67jPOlc0j6aOTROefb6md0ZessmdT5+8RJN0sfc8MVJjGTjmIehFCV/tlUypcvRugPWMtnFhv/v+ygadKEHiD4I9laXoj92SO+KEAM2QKsdoGNj5TzDLA6HoEDz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/OsAzjrCWBO5lwxhLN+fag9+32fYjM1YI7peq0DFW48h22q4gxYRCd3LLoI?=
 =?us-ascii?Q?rrS6KLFAjs5BPfMy+XvEPrq4mrD3ywsXtA4FTuVnDuNEsxpCdeOSCqoBB3Zx?=
 =?us-ascii?Q?/dwlNklcIf/pQnMTKOUzxcbUkVtc8t7ZK6Hnt6xOWphmWo+1OTulExBWeliW?=
 =?us-ascii?Q?QEkLvJFQ12RCLbS1UBcZZi0YHchnvrkm4iOHbvDhha0RwmrQuLR5c5t/gcny?=
 =?us-ascii?Q?NwgWUeJaKlYaAn/jQrsWqer/tr41a/yw08iGfJfFz2YJq5HtDiUy5hWQGcXz?=
 =?us-ascii?Q?nQiOiWn17/UTjkldp+sKzNSvap56e7cTCtAmI0fg4SxijNbUN+4qJu+oBIy2?=
 =?us-ascii?Q?vWsczOe7+sbJKDhq3TgWmsltyzKXUoDCbqWsJmnxgHLe1vMwIHmJeAo0ZPvh?=
 =?us-ascii?Q?EqBs0X3K7fdCj1lfrwtxRgdgS7KjxaxWL+nIefvaakhZivp1lxDHDdVaHuSg?=
 =?us-ascii?Q?7X6KdjwuSHJPzadcgvDAoIkn95JWIGB7hnwiMUpX2DasNULiGnaZnlNTcKRb?=
 =?us-ascii?Q?+7lhGLD15/h6oSdfygFvQ5E46V7AVF/wmNu1+BlNOiULpj+vesYlb2jJc9gR?=
 =?us-ascii?Q?gxvNEzEIfFdWyBNzNgU/24TV+tOBM4WPzWeF6ilQhKb2u6uPTnMXzPNsnqaW?=
 =?us-ascii?Q?m4JkxxNrSWEN4l99BDvhiyvMxc1iLhKlvRX0vZEoPYUGy69dFV2Horuamws2?=
 =?us-ascii?Q?XuQzs6WEfUiJsrtSAGW1tv4gdiPf5VMRA+CQxAqtH8sJpWyjoamsjUUy7GT5?=
 =?us-ascii?Q?lBk5KC8ke2trHwmvdPQLf9DhMPkJuhj/aDSn/KJh5Q0u4y9tQ1wvM1UQU38G?=
 =?us-ascii?Q?XZa9dAHoU5NkBAki25eoybQk9NDqKcMG2I5ATGMoj0TWwR2MpelieHQbgd0b?=
 =?us-ascii?Q?0aOmfOcmPV0dzcE9wknpS9HoMBGVcV+/bvV/+SPHjNKuGZgRI58j5PmZ3QN6?=
 =?us-ascii?Q?LlUtU6FxDI2yOW35fuxLb31hW2aIqwqNUwxCyBb1eYiDL5ZXpT8OQ4NHthFN?=
 =?us-ascii?Q?58iNNTe+jx61Reujts0zqd/b3+XEuGCVFIxWsXmLYx9ADzDrgMKL5+qgO7lw?=
 =?us-ascii?Q?B4rsMAauk31IekKNqc3FY6KmoSIPyNJlmRN2TY7giIZ4U5EUPcIuZ/QFJSFw?=
 =?us-ascii?Q?0eX+JtebMv5L2b2HNnud11iIpf+tvbQ9clLph7Xr2oVyMP/STQBcP0F9jSFE?=
 =?us-ascii?Q?E9oaKjllpJg4TDSLkHHcnTlLTuGiiy5QqPmmPuM/4IQhlMBO/BHtU+mgDDmA?=
 =?us-ascii?Q?649MZo7qNjOen4Z2ArfHAhwT8XMM+iN44Let/hEJo//4hNSInQcaMPC4BaIp?=
 =?us-ascii?Q?LUCZykZfrIF2FlnJzuLgWbxjljj+9p8v7ZJHXhRVc5wtNDZM+Pogpm4a9j/B?=
 =?us-ascii?Q?r7bdOkDdnS7yAbAKLwKUO91na/2JfVh05/zZJyVMRTdrPohmA8ns4tMqWT0X?=
 =?us-ascii?Q?ymid3/5xNY7rY4eProM/TfZRop6SIUQvNTg/SUZladMTATGs3t4nmdcmkzDa?=
 =?us-ascii?Q?uu1rb+tKn72WhkouIr/QRk3pw9WaBhZ7PLOQEYXkJa7L2CSVcaq6qqA87scs?=
 =?us-ascii?Q?zvu1W6vtDI9Mlwl59tktUjSu1RKNVBLxmZN/J2Lm25eupf80V5Kz7w9pgAR+?=
 =?us-ascii?Q?T6aMYXCy/uiQXsxFJfoLYFf1/LxseMgoaHpHZzcx4tsJxscZHolmAHzo3gLs?=
 =?us-ascii?Q?6sfL/TFz4ei1InFUx3FJQfwmhiTOUxvTPAAu0DP4qWgHjA3I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd80238-8f12-4a03-2ea4-08df390cf07b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:13:04.7503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wKOwHmFnbSS/g+sgfPEGebwvpr2lda93zylrzLwICbG9DFQNszKM3N8z4qkYwGHIRPD5FWQB70Rss4/Kw1cnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=tdave@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a highmem-mmio-base property to override the base of the virt
machine's high PCIe MMIO window, alongside the existing
highmem-mmio-size:

  -machine virt,highmem-mmio-base=<addr>,highmem-mmio-size=<size>

Some PCI devices require MMIO resources to be placed within a
specific address range that cannot be satisfied by the default
placement. The configured base is validated to be non-zero, aligned
to highmem-mmio-size, non-overlapping with the existing high memory
layout, and within the configured physical address space.

Document the property in docs/system/arm/virt.rst.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 docs/system/arm/virt.rst |  4 +++
 hw/arm/virt.c            | 63 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd17978..7ae51bee13 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -152,6 +152,10 @@ highmem-mmio-size
   Set the high memory region size for PCI MMIO. Must be a power of 2 and
   greater than or equal to the default size (512G).
 
+highmem-mmio-base
+  Set the high memory region base for PCI MMIO. Must be non-zero and
+  aligned to ``highmem-mmio-size``.
+
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
   Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4bacb57770..c04aadb92f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2507,14 +2507,40 @@ static void virt_set_high_memmap(VirtMachineState *vms,
                                  hwaddr base, int pa_bits)
 {
     hwaddr region_base, region_size;
+    hwaddr pa_limit = BIT_ULL(pa_bits);
     bool *region_enabled, fits;
     int i;
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         region_enabled = virt_get_high_memmap_enabled(vms, i);
-        region_base = ROUND_UP(base, extended_memmap[i].size);
         region_size = extended_memmap[i].size;
 
+        if (i == VIRT_HIGH_PCIE_MMIO && extended_memmap[i].base) {
+            region_base = extended_memmap[i].base;
+
+            if (region_base < base) {
+                error_report("highmem-mmio-base 0x%"PRIx64" overlaps prior "
+                             "high memory layout (must be >= 0x%"PRIx64")",
+                             region_base, base);
+                exit(1);
+            }
+            if (region_base % region_size != 0) {
+                error_report("highmem-mmio-base 0x%"PRIx64" must be "
+                             "aligned to highmem-mmio-size 0x%"PRIx64,
+                             region_base, region_size);
+                exit(1);
+            }
+            if (region_base >= pa_limit ||
+                region_size > pa_limit - region_base) {
+                error_report("highmem-mmio-base 0x%"PRIx64" + "
+                             "highmem-mmio-size 0x%"PRIx64" exceeds %d-bit "
+                             "PA space", region_base, region_size, pa_bits);
+                exit(1);
+            }
+        } else {
+            region_base = ROUND_UP(base, region_size);
+        }
+
         vms->memmap[i].base = region_base;
         vms->memmap[i].size = region_size;
 
@@ -3415,6 +3441,33 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
+static void virt_get_highmem_mmio_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t base = extended_memmap[VIRT_HIGH_PCIE_MMIO].base;
+
+    visit_type_size(v, name, &base, errp);
+}
+
+static void virt_set_highmem_mmio_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t base;
+
+    if (!visit_type_size(v, name, &base, errp)) {
+        return;
+    }
+
+    if (base == 0) {
+        error_setg(errp, "highmem-mmio-base cannot be 0");
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].base = base;
+}
+
 static char *virt_get_msi(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4286,6 +4339,14 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-base", "size",
+                                   virt_get_highmem_mmio_base,
+                                   virt_set_highmem_mmio_base,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-base",
+                                          "Set the high memory region base "
+                                          "for PCI MMIO");
+
     object_class_property_add(oc, "virtio-mmio-transports", "uint8",
                                    virt_get_virtio_transports,
                                    virt_set_virtio_transports,
-- 
2.34.1



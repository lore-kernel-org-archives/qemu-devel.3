Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8797606A326
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r56qqHMq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcGx-0005kW-TS; Mon, 23 Nov 2026 17:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGJ-0005YC-LZ; Mon, 23 Nov 2026 17:11:48 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGI-0007D7-12; Mon, 23 Nov 2026 17:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj7kh9xRhKCEj6RBj6Ns8RG61rgXoJuTE03pY0yY2H6toorwQKvtMc/8ZcSWU+sTWV8zhhJQcYIj1yiVxIPzOq87zuO7M1rzXfdYm0ck4Q4a9h4J1F/G3HG5oa3HE0JUVTNCYnoPYraY6AaJcbk3NXLEojl4JpnacoanNjRMAveK+ba6e+ZbIe1WWxCKIoS7MeMs5DtJInNVxU8ijivYxNriafYqi3LKM+2cJ4YlkVQEi3ZisGPfvuDxPs3+3ZqQsVd1/QtsD75vES++Pv/ADay9MNrGItyoqRWN4+UqxDgaCoz+4xW3GK+M9HvzCgr6ALcTxOGkGws8J4vOQD2r+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5TAvpHtOWGhDfeArOo5YuAZYKOYiQwmh5XewpgjfNA=;
 b=Y2r0u1N0VfBBrg+hOZTnbGfn+txKqcduc7fRAPB23W159EbMri9EIUvwBkohYWdgRuUaMewKef8mx5CeJ0mlnPsWaqE66ZJwUcf1EqTzCWC+l9nkfAlZaPnbknzb53hlskXv0SBxSPLCyRsfpOmmi64bsUGU+A1jrGuUsAGwdKdqkvIo24ZVaY/u9ETDfrjUyRTpIOM/PDxrNViwyLrb883sMpooA4fPlNJ1wou1wJtTnnqr4k1pTcCfOFVk2fPO7PpgbW7Ho4R02CPpf3EQ2KUxD1aHKAWUwSR9uF131/6Ab69eA/PcNp0/mlBkb0hZdJV/Dt2Tza79B+IIIa9rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5TAvpHtOWGhDfeArOo5YuAZYKOYiQwmh5XewpgjfNA=;
 b=r56qqHMq4DyOpLUq+9wBGrlx1OUFZkJf0Ru/533VbrE1sAcCL/TJuW4k6GIjBOzajQT6PwLEga3bYMl61lnrMOh0uPzyebjOhVG6U97iKv+2wCCIozv/SyQmgj7XDu1cnl4QyFqxURcDeMxR8HL09LaNYvo4iNzVvn2O4UDYPpG+DjaQQZBBaihqYfh4sUJ+5K47Dpp0FMAzhlrDJKBRUEu2gYHXl11b3/3x7KbNoLIzgWc4ruRqDdgxLxSsbZwuzTpuw1mSsG8WeRL2x+jkxQtFRN/RRxCJ+yZemo0gXvymHGzjTVYF2aSvy8paMiUrQ3gEjNNgcla+DNSli/T8yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY5PR12MB6551.namprd12.prod.outlook.com
 (2603:10b6:930:41::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:11:27 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:11:27 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, clg@redhat.com, tdave@nvidia.com
Subject: [PATCH v3 5/5] hw/arm/virt: add highmem-mmio-base property
Date: Mon, 23 Nov 2026 16:11:05 -0600
Message-Id: <20261123221105.37029-6-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123221105.37029-1-tdave@nvidia.com>
References: <20261123221105.37029-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:130::18) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: b9086217-0830-4d05-f6c5-08df49aeb862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261026121527099003|10067099003|11063799006|261102123227099003|56012099006|261021123027099003|261021121427099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: jt8eEGy4JMACyFc7nPmaMAWBHmcxkx8ad3ZdqWv2WGCzkDxyx162ymcnC8fCGucCyGR0FpLFmbh47mGbBz6tIbnNWSqhAQ0Na8e/qW7ENSJKbmAhfvbfZhj6txMTOHZD1l+sB0iaXwDu8DEKGT7RFoLUtm3vPREsRmB5nIOX9ZRXhxvjL+x6kRw4xZcEiaP6wL38GmBjWXspg/VGuPyDtWx/a8KNL4qhQ1MhtcdSmlZuisyUKhFUQjh2yG8fJZsf8sqjsEWrLAT1kano7yxHKtcAZ3kgZirULAsjn6gjZBiPybnxy/RoQaQnJcbuV62azdcMLei7uQLS9tJGOBrNwdh6baZmJSnI1AQSvFNZ9bRSNOpy9zxbIaxL835M8EpmjLpfP06G7jGcZOMkaZNZLPcjl5vVsYTgxONF6dDPVoNo27yaDj3OdJv6hIDushmxcigcyhJvG3Hi58LiefwLAwCFSNU7/8qaIbFJrBoBII14yCqk1KUWMaMkUWu672NXjuVBXg/MDIcJCljTegUrp1Era5H/dhnprIrwXCEa5mUUIEeOZoyJ3WFlDInGXG/04oUy9QHEobVYGiYQi9R1SM5b/uZc8AvPiIdzNvmDk/8Stzm1iEtG+zgRkKmF55SRTtktoC0d9nDUSewfeUDZgJ/Y4vH/3/KUhzcKL1DU7ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026121527099003)(10067099003)(11063799006)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPNRzzeMiv/R5+wyQ4UVULO4dLd8aRALG2JJtX7JGc3yfaCruoVZWEDZBIqx?=
 =?us-ascii?Q?h4/FmgRAKm0jUSjAxY/l6ckoJ6+Pi/bjf0yhcg/CISIA9yP4ia5A9134OjJg?=
 =?us-ascii?Q?DX2Ju3hJd5IYcoBnlXebRmGUW8AKNb61JtPmS18O2/WWvxZQLklJ2pvmYsMJ?=
 =?us-ascii?Q?H7a39w+Zxx2cBtUeya6gR0vm0BBeUfY+00DADL2dp/9OqmIifdv9ip496j0u?=
 =?us-ascii?Q?QXjg54YqbJanaTlz3W1WAe3hPp/1imwI539EresrpreyX+mQLEp/Mjia+GiX?=
 =?us-ascii?Q?tET3P8dTaJVeql09r4pI20AKoCIErfa27kqll5fYTgSp5wQIeUNHYiN5oT71?=
 =?us-ascii?Q?9NDbTCjN0HNd6QgPT/lcMyM2fIkZ32wcL6kKgtOTV5RTYqtNdpJHXHE59jsf?=
 =?us-ascii?Q?09UA1AqN+ZqOHvDUa76h/3Zeqb4WPXH+okXkDoBzS1T8t6k20GDMGWKophyQ?=
 =?us-ascii?Q?N1QoDcink96K5MyJF5YMvzs9TW8STCh/jpUS/cOPZdiaoISNUG7eV3gSW1Av?=
 =?us-ascii?Q?Ve8XGhctQxyet38S2pz2GiHt/yC445mvDGTkZRNR7WZKbIoSCr5Rpek2to3Y?=
 =?us-ascii?Q?wg5lPv9nSrOEk9eHnmncn6aCTNL5HJlBUXKWd3Loir3AXjK19lkbq+Uhbnh9?=
 =?us-ascii?Q?s5b5zv48DIrqVzuJBDoXtLs++JlbNslNi+kP1OnvXFALJ01jurkb9UewwcNu?=
 =?us-ascii?Q?0yaqpd493l94rm9MIpTmm9CGkEYevkJ+EZ7T+T46pP+qaGp8i5s5EcvC9ipD?=
 =?us-ascii?Q?UrSY6UphAsCMfMs85Kcm30p2dIjfiPNJF1NQAuyHkvwcGEkMbSEKKhuKDL3Q?=
 =?us-ascii?Q?GfXLi760PXyW1ord8hhXS6JqFd0S6gisqjIySK3eB6bxXtfaS0z0DLB5X8wD?=
 =?us-ascii?Q?EtxQHY7fm9PZut0IReC+O/nIrC4e9R73AEDatkxnGoWcEyMyI8CUhYUJvG1W?=
 =?us-ascii?Q?m49cgP4BTevpM30kW9YOAGA6J6Ft13F9X8iRoy8l4+sJ0+QRMpxItJ4CGSms?=
 =?us-ascii?Q?H6/kPVev+tIiWo9sJanED3TdcWSAJu5iJz18NFfeYpKW8Rhzm5HOpYVmrjr7?=
 =?us-ascii?Q?ph29ducLXWLuSq3zgdBHtLX2BpQ8/FC+3horgXTmsTwD+X0y29jhj5RD/RxF?=
 =?us-ascii?Q?EvlpB4ntruswivCe0bFkjGN2diuEwHHcjnWzjBiWzC7FgPKB0BJahDJGPxHC?=
 =?us-ascii?Q?9p5VY9pVBq6ma5OMiJvMtLKKC4HWBA+qaJO5NIcNO/Jno3hkGJic5hjiGeSM?=
 =?us-ascii?Q?BS0DDyzpo5TyfBozyewQl1zhxIUrl2cp6hvlAbWrr+ZugW9nc6hl8woI0OET?=
 =?us-ascii?Q?v2hB0Nhn78ZKYZ1WtP12SJ2O+CrEa98ioXfYnZHNU8Fr50I5UyBqHfH0FECv?=
 =?us-ascii?Q?vZsgiYfKxIUNxCql+idJRJLrcb54L9En4uY1BmfoORu5ui4Zz6O8eS8AZ8C/?=
 =?us-ascii?Q?4ZlzgTqF1n3UfLicYrSxhWnSK0hTHbM3/nlhs8wZITga+3YyL594bU+/wKnP?=
 =?us-ascii?Q?CaFdaRlz2FyIamY9B4KmxbCWL7X28xBp7G2Bfjhsmmop+AG6tWTH13hvOtGK?=
 =?us-ascii?Q?KNkI1zef+jFIXUiEdZPcrBX15FbIP/OGYNKVHmPf0uIRnvNnRydERJfA4yRy?=
 =?us-ascii?Q?M3hriieV7nRK67QYg19f1LnqIy72pwMXNtPJbf1vaK4v1L47WoEaWCLW4rhu?=
 =?us-ascii?Q?Z12z9Uq97g/I0C6tAq44GQvmgCJSN3/Hgp9V+UYP1vrRO8iH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9086217-0830-4d05-f6c5-08df49aeb862
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:11:27.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L89hUXk/Hn3eQkrpkGvD4Pl/5pCbLmiWzEk7z+QBP82na3exXE0j+SMzna60pZQwE/45w0T9iqmxGJFWwLp1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
 hw/arm/virt.c            | 64 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

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
index dc487f9ea0..ab34d1ab05 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2522,14 +2522,40 @@ static void virt_set_high_memmap(VirtMachineState *vms,
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
 
@@ -3430,6 +3456,33 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
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
@@ -4297,6 +4350,15 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-base", "size",
+                              &size_type_info,
+                              virt_get_highmem_mmio_base,
+                              virt_set_highmem_mmio_base,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-base",
+                                          "Set the high memory region base "
+                                          "for PCI MMIO");
+
     object_class_property_add(oc, "virtio-mmio-transports", "uint8",
                               &uint8_type_info,
                               virt_get_virtio_transports,
-- 
2.34.1



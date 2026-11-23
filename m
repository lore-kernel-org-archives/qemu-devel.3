Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193A606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sF4GN0Hw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcGM-0005Y8-2Y; Mon, 23 Nov 2026 17:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGC-0005W3-JN; Mon, 23 Nov 2026 17:11:41 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGB-0007DL-3i; Mon, 23 Nov 2026 17:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy/JhkeZGUEDQtB02f7hm/oqPsSc4/EuC32vQA5Y1Dtw8bIMJJPChz8jsChIyfeTg9j1WEsa4VhFVGOtQqlD/om8Ue8qnihl0ygWh579DhMdjj3Sahn7uTd/oe8PGeVDFDtgZ2Iw9QtiJSOuKj06l5xC1Ilif6ewKfLWfpCRGdm6m91j+WzGPc9H4nb+LAp8aphu6iGBp0BCyi1mvOOFlyAjTiGpKfy0KuUW/dgMWJTDd0rqO4xkKbQ86lCxggqgVkglCjTNeBSyfeu3ImaBnCBwLhuwQnUuTpQcY8oFsnkh4GulbJFNwu3mWExwwrk6EI8nNOJlghBEbVirQD20BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSgvQ2w07wxzQrLlImdhnd6dLimUHhsuxkZmF2ru1CU=;
 b=cBFTQFUTg4a6z44Ksk38WIPA5KCR052H9tzj1UWoMsUmK9fCC7fC0lAHkT4DSkIPP/cO9tAo2n6NsHNfp/lyjM8h1e8nVIj5KsV0Bug3RLFS6ZItxjPTFjswmWGrVSMRmaddHljE3cIRIc6fIQOCbcXOs4HDQNsi31O4wpyGk57GkxGeUMR84trUsMzoo92KyoYtEmtnwSHJ9yGyXDn1QKRSokAswdmJfTayjk6/H6sykZOVN23hYT8EkOzbCsFVotZx4W3aKU74GWGbOBdz5XV6pI3UNE9rte+VspXS0rMsz31yzjwp9Hnl7EXdRFHAI/eQj1U6ppM2CrD95XRJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSgvQ2w07wxzQrLlImdhnd6dLimUHhsuxkZmF2ru1CU=;
 b=sF4GN0HwMPWkGrS8gF8IKrPrtyytikM4s+0DvdUfPXcvKIhaafqppMMP6YX/u9RYKe6OlE81f1VhcIi0V4FujbCQ9jXjgPKZUHd7iLLzPx6yiHgvX10TUXfIm5NHIloQEpbnqWW0E7y4HdTbbKtZu0ZWW7bIkyY/H73kVw1uI6QaBisHjPdN6SQzPOTRXbmd9XEPWhQYY5WGNedUdDn/uWykFkFaKnKUojVTpCPRs3LqyJOQbBoKWVFfBgW7fsYd5hkpYaH74L/nNPLQkVEMqynAxnkb7S/XlzAitfH6CrvE69sUsNN4gnkwk5VBf+Xx8nKHYwGDcdtRuJriQoPJ2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH7PR12MB6979.namprd12.prod.outlook.com
 (2603:10b6:510:1b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:11:26 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:11:26 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, clg@redhat.com, tdave@nvidia.com
Subject: [PATCH v3 4/5] hw/arm/virt: validate fixed BARs and preserve the PCI
 configuration
Date: Mon, 23 Nov 2026 16:11:04 -0600
Message-Id: <20261123221105.37029-5-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123221105.37029-1-tdave@nvidia.com>
References: <20261123221105.37029-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:806:125::24) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 04368468-78c4-4acf-e086-08df49aeb7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261022075727099003|11063799006|56012099006|261021121427099003|261102123227099003|10067099003|261009223027099003|261026121527099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: lGr5TIhxDmg4nN8orJdc8hm2NZGjocForFNDxKiuTFp+koDTxOUnr9Kr8zrVGBqzXVrmRv2tcqkQBF3QoOJl5ECeAy0guH4XRrAauhdySzx0mXLaWr7/CpITLTXq1HBs/tLvXh9TpFIG4zOkzaA5Gj/B+T5OC1WfrsAWJt5DDkAP2XpNEx60nqYr5wOqouqU/9lJSzxc7qebPw1kC/aPumV9EaaFilde6ghbH1S5QOo1rjsPEboTRQCkdxxjDV5i1cb+kV9JsjpmTAUe/Qa8mYxc63xPAI3WJ0TlVdTP3RllOFEtOPX6UiiK9CYa+DOa5Ni8fh05M8HlPwpUqx1OfNB1k+cCEiyaAk3aiHCJHlwhZmN4ZW/a5432MN6X2LkvxLVEb/TbFeoKHKqBzPDZEfddHfKKDR242VmIBvI45INS2uWCMA1998H7mcZyGNUjd3kRJd7F37woq1m/eMlhLot9aeypp76BI2a3NS50YrQga7EW0767SMCedCQf3r1LuQgwrFCRGxLHTmhRXoQMc2s7ICXrmOhs+KKdvp8vbqTgj1WtkR/9bhOVxHuGXL8ZhTmShTVHQJilFRSOKMIa+ysBYSnvf0+MhXtq16B5P9dAxsmCzGgIHuwFQCrm6ylnp4Nwu/5kZW19zReW4pB9nGUGpmWIke5w1/MI88j85Uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022075727099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(10067099003)(261009223027099003)(261026121527099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lyPVsH+vPsUb4JqOmuSO772AJWOQX5vAJ5GQyq2H8MNlXUEELo0nzCz5gCkX?=
 =?us-ascii?Q?rcTAYqp3s4FKGtyg4ZiW5uNvV3zr64Ai1H56+PkbvMwwAbBv/xw3FOCHdm2m?=
 =?us-ascii?Q?gdIT+Jl3trFo37ieMRey4pw0Zdo9HpuFBND+KDGfRhV0BsOXaUHD0LytpOv/?=
 =?us-ascii?Q?yzAMEeWq6zsv1Wj/sL/DvV8aBBG3CTgxf3/b/vSmA4G8/IiGqd36rkIb36vy?=
 =?us-ascii?Q?+AZCbj1ZNtLBlMvpC0gDb0u/8lmifypMYW6xxOo25YzOYVD1s5sH6s2r1WIU?=
 =?us-ascii?Q?+xiJvS+OYV9iEvyLutWonhif0ji2BqCKwPjmbDEc5g6yCFQjdbkqeKpNH49Q?=
 =?us-ascii?Q?UH+8L6j7BvPsBu86v3bf4hp3CEAAliXsxSeQCN2/IA1D+KQMJJS/FucdX9Yf?=
 =?us-ascii?Q?8pBnKyY5GMrToRYnZthlowx4drgV9FcKfR75IL0WvyOo3R0ULUkKwZTlEyPb?=
 =?us-ascii?Q?49AeMnuGsU6gjhezm9daONY07uOEzSzbUj2bN8lEkzYBlUrqn+EtjwJptabc?=
 =?us-ascii?Q?JhWbfJLgwj4mbUUdD44T4wvv6J35/5K4fwXMpTzqXs4aFpm1S/00s4+v10P2?=
 =?us-ascii?Q?04BpO/xKt0Fmqe5fMXEKAiNZI+JLTTt+GFzhaMy/V/g103McDDut5cHFELAO?=
 =?us-ascii?Q?HyfNyz8eEpM7E/AH/hlmm4/WvqNIXVU4RboChxNooOzxaAXG8ZJiDgQIprji?=
 =?us-ascii?Q?vCu1wIXQWi+CLHEzelfBKOEZz6b4jk577+mWW5onczOuASal3apkLY81fQa7?=
 =?us-ascii?Q?rvGuMMxlurX4bJBZD1TDCjjWUHwRij7ftAUoOX6R4WWyCRySF4jkdK1+z0e4?=
 =?us-ascii?Q?d7JYGnxs5vcRo839Vi5lUymC9xTVZEO8gTLjZyr1qX2PZvtDKBNh13wx5LNx?=
 =?us-ascii?Q?sfXlGsdZZV+506qVTyEKZ5GLKnGg8UyDLA7XefJUWbrtZZ7ovds+TjBpOncu?=
 =?us-ascii?Q?jpyzs0hIC/9nlyiQehURJ94KsG0stgzjUSuEOeD3HBUoLvGfEqyaRQfB218Z?=
 =?us-ascii?Q?ID9OG80WKEeY22yWlSROD8/jvHgY7y+SIxCywPMOq1ZnSJ5j+K7waj7S87ee?=
 =?us-ascii?Q?IFr7pqcaHI/KpEzhvnFpT3P67cC5rO6kaAnCSjPGPLxmGNwjIfMpDvVGMrdJ?=
 =?us-ascii?Q?Bb2/XCg9gaSjsna7rgfL/1cOcRr/nKD9rJrO5dmF0rRoeurZeJwGyr/V9knt?=
 =?us-ascii?Q?3nkIWjXzNrNttYnajlK+OuhAveoA99HWA9IGkLGW5eWvrym+QI0qe7oBKnf2?=
 =?us-ascii?Q?OBMXeGyOTYwsh4S+gNULa3mf/eslpQ91kHqUP0U+kTXFRE1ik04z3Y2H2KfG?=
 =?us-ascii?Q?heqOjlTJTeuLqpif71hOG55m0Mya5vlqJ2Hcr1MKE3IqMZ5ML1WnMyILATAm?=
 =?us-ascii?Q?Lr8yWRcbZfH10XW1CqdH7QpGWGy120SC3JItrdqFg5uhfGx5PDZpuCReCjb7?=
 =?us-ascii?Q?yj1PBWQbktg1RmYfHoM7iR4DMnnlu8UlJBcIw7jbWrbxCRwdLOi8kQBZPSpD?=
 =?us-ascii?Q?+gMIWEmQ+g0WxcCfHDRNN7VxBJBvcGYaFcCCxfTofITxDp0h1hbqOBjyeLQv?=
 =?us-ascii?Q?bZhqAhBBjuII6uK1ZqGvpGOdiL34jOgn607/xSSRj2udKvCWTSVH+RaB00aG?=
 =?us-ascii?Q?mC42fDPFHJLGuqrBJP/8wAafn1W27r8+vUNHOGZ9NIzyCwDS1W0eOVnut9sO?=
 =?us-ascii?Q?u85mI3GOaBZhUShQKdSg3zxiXn3JaY8rbjI+3qLIjZhncL0Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04368468-78c4-4acf-e086-08df49aeb7bd
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:11:26.6439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qCptQOR5zIniKwuTBIXzZCzkwfmTXaYe4kiFtE2YjHEzAb9PDEu+ZtYWPp4DYhXk0xu8inYl0EfW9irD1J1tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=tdave@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Validate the fixed BAR configuration with fixed_bars_check() and set
pci_fixed_bar_supported to allow the fixed-bar-N properties on the virt
machine.

Fixed BAR placement requires the guest to preserve the PCI resource
configuration established by firmware, preventing the fixed BAR
addresses from being reassigned during guest boot. ACPI provides
this through the PCI boot configuration preservation mechanism
(_DSM function 5).

Reject fixed BAR configuration if firmware is not loaded or ACPI
is disabled, since PCI boot configuration preservation cannot
otherwise be guaranteed.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328..dc487f9ea0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,6 +94,7 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/pci/pci-fixed-bar.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -2451,6 +2452,22 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
+    if (fixed_bars_check(vms->memmap[VIRT_PCIE_MMIO].base,
+                         vms->memmap[VIRT_PCIE_MMIO].size,
+                         vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
+                         vms->highmem_mmio ?
+                         vms->memmap[VIRT_HIGH_PCIE_MMIO].size : 0,
+                         &error_fatal)) {
+        if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))) {
+            error_report("fixed-bar: fixed BAR placement requires firmware "
+                         "and ACPI to preserve the PCI boot configuration, "
+                         "otherwise these BAR assignments could be "
+                         "reassigned later with no protection");
+            exit(1);
+        }
+        vms->pci_preserve_config = true;
+    }
+
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
@@ -4203,6 +4220,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
+    mc->pci_fixed_bar_supported = true;
     mc->smp_props.clusters_supported = true;
 
     /* Supported caches */
-- 
2.34.1



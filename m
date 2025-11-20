Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC946CFA446
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMC6k-00027w-Jg; Thu, 20 Nov 2025 16:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMC6h-00027X-VI; Thu, 20 Nov 2025 16:22:24 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMC6e-0007zj-Gw; Thu, 20 Nov 2025 16:22:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkh3r9t6VFTpZa4qogDasXnJFsHcLXCX4XRIHdeBKjQCuM7xnAA2sYGEINpS/UzoGXL6ZVdVGrJRZsr2c9dRRCWZnRwrbnOky+i/BogSnE1LRKX91p1zav1LFSElqbebwkL75lSmMsPkhbwMlGjrVSneDSEbJ9JaNiXNmi+b1VIIEYvfpEW3QES2FNKeJXrO5bgo9yf1bJjavnDUJMXXsxErgq5VBIAgMosx2G92Y3TtMRS3XIzaIufkXxUZCbBekfVuoKU5RWVweWJbIVGWTXsGlRldv5u6YQV0L799IXIIpoNs0PIK2jmImBhFAp1lGsRip/1t/+KTatC2KL6mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmpV3qVY+gb4PFt8pugDX8msfCGyBzl3rKxa+f1iGvo=;
 b=PsBRTUe9w7StOokbyuLvK0DBygcAzn+xzbCmUEHFMt0kYs8tXXiYkPmE/W7cRCFe93IH6aZCjpGL5wO2sMnNhPMa+P2sAVoyt7qw1tvyszESB7n+5kjl/kVwyMeKRF5F4OLJpbeqrjwx3T3x238438dIJS2W2zExDcMnizV0+FDBuEUiDYHR4qqimNVxv0eGMQjMRWzk1Wm/9I+5VeBUyJRqj2Ea5Vmct1qyCFz/BStA2V9GzkILy2yc7Z5soFRLj3PzWrq4GydIggKkYwkIjHTPHQjkHVXnGEe6RxmOyFsK2p9yMTez1vpMX1l1o7erlh1647ZHJbcfPI1HemqwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmpV3qVY+gb4PFt8pugDX8msfCGyBzl3rKxa+f1iGvo=;
 b=LeMcCJ3IAAcNA5IgQznSJPBsRG+gOpiKyTX3AAnV6nmrx1t1jV2UkN6Cs6B7f2s9TeiQcOCn+6t00ZouXQy5C6/PyBdVi8MbFe4Y2fEzfWKah3NbKV6/r+Z/S3PUwAoIhxpSKxpQ5UiL3ImUFrafHE7rUGkBsMbmObJVcLTffl90/lnGEI1QQS28YlCfwdEn2Mbz7CHxyQvy/+hJ2YtI2TpsdZehKgjE3R8DVZUz/tBv5RbB8rajrhHH0nOkxsEG1IMoh2ZPpeU5aKTwoWcJtzhSOJY2DfsuWI4Q903CBSPFhMDGOxC+G647kSNZCSKdqcFHy7XmNgtUGqBuivoJHQ==
Received: from BYAPR11CA0079.namprd11.prod.outlook.com (2603:10b6:a03:f4::20)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:22:14 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::30) by BYAPR11CA0079.outlook.office365.com
 (2603:10b6:a03:f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 21:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:22:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:21:50 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:21:49 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:21:48 -0800
Date: Thu, 20 Nov 2025 13:21:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Message-ID: <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120132213.56581-18-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dd8fdd-9423-4fd4-65e1-08de287ae006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzJGNXJ6VEJPVmtvdFV4OG9UMk91R3EweWxabVZzTWlwR1FmcWd5ZDY2RU1q?=
 =?utf-8?B?a1BoZ3YrTTBsM0p4bjFKazBVcnNMN0NMVXh6YkNRUnpwdDNFRWNDZE9lZmJw?=
 =?utf-8?B?TDUvbnMya1hIMVp2KzhEdHE2NzkrM0V5eGlOdjNqMHIxVFVDQldHRHB4OGhV?=
 =?utf-8?B?eG5BdGdCTnNPRDhPVTlhQ1QzQzdwbENYTXRjN1FDeWxDbUt3akdndnkwQnVX?=
 =?utf-8?B?V0ZXZkFGMVEvSEZGNC9jZVpkaDdGdS8rUm9iQk1JdlE3eTY1RU05QWtWNWsx?=
 =?utf-8?B?c0grcUpSVVNHd0doUENHdTBRV0dwMFVQN0pRUndTb2VrdDVGQ3NvRDBiK0VW?=
 =?utf-8?B?ckhocDdNWjMzRDdnc2xlUCtiMGw2TTBiTkx1YmNaMVVxejBGVXR0TC81emVL?=
 =?utf-8?B?MGJ5eDJxcmtzcysvdkNXalYva0ZZcHFZaGZDVS9zaTdxN1lvRG94YmF4WGxE?=
 =?utf-8?B?NjV5QlI2WWxSdnlsUTBJaWxQVHBHOTBDeVZBcWtQbVFORTRrY3pEWURucXVM?=
 =?utf-8?B?VjYyVk1aVmU5dkhVWWk0dU14ZlVKdVVwRHJLOUhwZGV5SlRITmxFb1ZMd0Mw?=
 =?utf-8?B?eExrWWxNNUhONWJ5cGVya0hlMGlLeTJHSk1GeFZtUnpCZnRqZUFhdnFubGxz?=
 =?utf-8?B?K0Nhb1lZc1g1enBRQ0xTbkhYYkZDMGt4UmxmZkdBUUViOTI2NTBRd0Z3SmF0?=
 =?utf-8?B?VHZ3K1c4R2lUZE9DOVMxYUE5UTExMXYveCtqaTNvdUVUbGNJWmozM0dwYk9o?=
 =?utf-8?B?N1lzTFo0MU4xOE5UbUJSelNTNnNMMXN0Mzhla3dlVDFOaXByOThza2Y2UDNl?=
 =?utf-8?B?QmFpMEtpYVlNMDNrUlFDaXN2K1dWdjNoNUZJaktOZWZPcmUrN2J1cy9FY3R4?=
 =?utf-8?B?eU01b2dTSXNBa0F5Rlc0SVZCbTgrV3l2ek1OaHpDdU1nZWtTdTYxUEdXcXhY?=
 =?utf-8?B?T3BkVy9KZkw2OC9HT2xZTWZiL2VzS2VBSmlnY09sdEpmeVdzWGQ4cWdPY2c5?=
 =?utf-8?B?c3VvcmZsWkJXaFBZalcyV1RHRmxaRXRTdlhxZmdaaSt1cHMydjVSeTlXRVk2?=
 =?utf-8?B?aFl5YVNIVENHTFVhenVuTyttbWd0QXVnWWp6a2JsR05laitpS3E3K2tCTmdF?=
 =?utf-8?B?YVIwTW5WZGxRa0lQc3UyOVYxMlY4ZnlKMlMycTlwVmx1R1dJY1FNRXUvYjE0?=
 =?utf-8?B?dSt0MFZkMDhOWS8xUUlyWjFpOTZmL3RyRUNPWmVicmNoSnhuR0dYNkpRQ2p5?=
 =?utf-8?B?dmZTMUR3bHZtQTNEcStnLzJyMlZCelhjbjVYR3o5Tm9IWll4YVBLQmVnd09z?=
 =?utf-8?B?Mmt0cVVCS3ZOa0dGdGlQZEdaOVViYTBrOVk5VkVsWXY2ZytmYVdQblpoM3Yr?=
 =?utf-8?B?N3cxSlFyVVM2VG94TDJlU1FzZkh2TEg2N2dTRHEzcU8wRldXejZoWW9VTUJI?=
 =?utf-8?B?VDliTTVsODcvcnVlZ3JNcVRQL29XeGZTc0hLYlFES2FLQWFYOVJhV1JlTWFO?=
 =?utf-8?B?RGpKUnppMUt4L0VBdHpJc2NNMTQvQ2FuNjM4NWxxRXpZd2UrUXlUb0RLZDZq?=
 =?utf-8?B?anl5VG45c09sa29PTjdiVG9BajhkeVY2TWxORnJqU3orNytIMHB0VjVTTzRL?=
 =?utf-8?B?OTAxM2FMQkRCbkpid2t5V3loUjNHNTJScTVvRmlGc2hNME84Ry9ZNFZnSGVK?=
 =?utf-8?B?TDRTUm85NmRGaUcyeHo5ZjYwRU9aQldwYkFhM2dCWFA4c29CMnVUZXNwV3Rq?=
 =?utf-8?B?N2k3Rkg4TCtiaVNBYk1rREF3YUdpdXVSMEVPVUNDNlh6dFVOU2daTi9ZeWdx?=
 =?utf-8?B?bWJLTkNCUzVTa2hibno2QmU0RXYzWEZZOW5MeDhjSTlnK2pnNG5aaDc0YU9p?=
 =?utf-8?B?dE92RE5xd2I4QUdKUGRDdGZpYks1TXNjUDAvV0M2aDlkSjNxd2V4bFpBcFBG?=
 =?utf-8?B?Rm5WNU9FNkNQaEx0SmFBL1lJVlVwZXVLZWd3aXg4dUVqK05hNGRaM0VaRzZr?=
 =?utf-8?B?SEJ0MlEzZk96WHI1Qk5XSjB5TTNraGFjNFRJV1c5L0x4c1I0MXRUcmMyYXcw?=
 =?utf-8?B?STFFSHRld2tNajBoa25KWjR5MTAzcGpyOHdYY1BEZTBkbmt2ZGNvaGxKMUZI?=
 =?utf-8?Q?p1oU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:22:14.1459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dd8fdd-9423-4fd4-65e1-08de287ae006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 20, 2025 at 01:21:57PM +0000, Shameer Kolothum wrote:
> Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
> translation (Guest Stage-1, Host Stage-2). In this mode the guest’s
> Stage-1 tables are programmed directly into hardware, and QEMU should
> not attempt to walk them for translation since doing so is not reliably
> safe. For vfio-pci endpoints behind such a vSMMU, the only translation
> QEMU is responsible for is the MSI doorbell used during KVM MSI setup.
> 
> Add a device property to carry the MSI doorbell GPA from the virt
> machine, and expose it through a new get_msi_direct_gpa PCIIOMMUOp.
> kvm_arch_fixup_msi_route() can then use this GPA directly instead of
> attempting a software walk of guest translation tables.
> 
> This enables correct MSI routing with accelerated SMMUv3 while avoiding
> unsafe accesses to page tables.
> 
> For meaningful use of vfio-pci devices with accelerated SMMUv3, both KVM
> and a kernel irqchip are required. Enforce this requirement when accel=on
> is selected.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Nits:

> +++ b/hw/arm/virt.c
> @@ -3052,6 +3052,14 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>              /* The new SMMUv3 device is specific to the PCI bus */
>              object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
>          }
> +        if (object_property_find(OBJECT(dev), "accel") &&
> +            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {

Do we need object_property_find()? A later patch seems to drop it.
Perhaps we shouldn't add it in the first place?


> @@ -3088,6 +3096,20 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>              }
>  
>              create_smmuv3_dev_dtb(vms, dev, bus);
> +            if (object_property_find(OBJECT(dev), "accel") &&
> +                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {

Ditto


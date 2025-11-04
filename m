Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70417CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL8l-0004HO-BB; Tue, 04 Nov 2025 12:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGL8P-0004GZ-Fs; Tue, 04 Nov 2025 12:47:58 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGL8N-0005fF-BG; Tue, 04 Nov 2025 12:47:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZTQzmVH4rUaeB4V7q3FnrFpGNPeRDt56eyufsv5vfjwoXFIK5nAg1CrMrhFXa7prF7tsQyq4zQwimApSTSqeFof1C+hMEV7aejawRRbCdetBLv6gw9Og37+6RcSFWD054jaVflCExSJ7oMXEAJsX1LWk/5a+Gpt7G9y3SCSr0dFCgNT7tkUtwV3RA8W7YvIsaoyWVjpuhIJdqDThWAHdiK7ht/8MxfuHz4PpNRKuXjGv4wX1Q6PB/kRtESV3WcyMST0xRdRGS/1QUs/vChtH9QP5RGzCFlmxJYh39VBDbw060Bwi1fVSwugy/h9w6/M+filXuzv0GENFf5ug1mh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/2DVVwZ4ejt9foNMpWj92mYVr+xQCtC67rbsAkzzww=;
 b=npaOlNwFZgyzSgKuyNyHRkJ74WKGrVeAuABW25LZ0IqKye03ELl7MJBcD45bJi1XOWi0F4xFM9ggfIKzCV3N5zjJUqUBQLNLbUnW4bxmYSLTjQRctD1kVxUPZkfZQy5Dt6SCWZ4T+WOUzlUvdaYJI8sEwX4rDBaRuHY/r3escY5YbrtyHlFDK5XoQG5tjISO9vvFKdsbZBIq2fpB4pIW+no6dqknhR+h5R8sZRTb/HEGrjY4ifGZ/9ORw+eaY9X4SU43M9Lyn4l1vmWeWo2S19zaxt8th3bL+hAhukNo1/JvmQpcQfKo+bEYwxrn02h2Hyjc3aAJJeNb5k0fLEsvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/2DVVwZ4ejt9foNMpWj92mYVr+xQCtC67rbsAkzzww=;
 b=Je1keBlj+JpS32hng5spLDpcJvV4WvUrTW3O1QuKK7VxO1wtS1bcalN114Wgt2BNlmYI0vB1Y36yFvYorh/JzWijDTqIomVvKK6YsTHI3t2MkXd+odhlRStnVgLw3muGBHKJIz9SDuBYyphfnoF03z8X5sfjKwCAe/xmA20rP7+CHMu5OlTak87/hSHyrrjuJ46vgQwXT/xtnlatUf0iwR8llT5M3/jojH4q6o/YAnzFX7hBTq7/jKwW8LrKWPnO3E8BPIBlUauHv8hK2W/KLdyIZSIkvoP8JOgHRoonn/+sg5XiEMfFdxa4pxa5HoCZeTFuvBXmLGSfZDFja/nq0g==
Received: from SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::27)
 by BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:47:48 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b7) by SJ0P220CA0017.outlook.office365.com
 (2603:10b6:a03:41b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 09:47:30 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 09:47:29 -0800
Date: Tue, 4 Nov 2025 09:47:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aQo8MPCrr82wh3LI@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <3c9e00f5-de9e-4e5c-8312-75eb4fcef81b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c9e00f5-de9e-4e5c-8312-75eb4fcef81b@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|BN5PR12MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: af3990cc-c2ab-484f-4321-08de1bca4417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkZMTVByUDY4aGZIOTduQUpZWGlxeWxPODllbUlKckxCSjRQZjhPSEp6dnVj?=
 =?utf-8?B?Zk8yL3ZmajQ5OXRvWlFJNXZ4L1d4d1VDUzhUSUNmT3k2Qmp6NlhHa21CMmZT?=
 =?utf-8?B?STFUTzFqZ3lPeHdMYjhTZkVocVNZMm9tSXlVSE83b3FIWGZRclhUMzgxTTN3?=
 =?utf-8?B?L1FhTUFlajZwdkZtajdaTU1IVWxqTEZCK1lTTXFJWlRackc5S3EzaWJ2K1E4?=
 =?utf-8?B?NWZkVEZwdWJpcU1hcXZHQStYZEdwUW00d0VwNVNYcTd3WGtxL0JIY1VOcXRD?=
 =?utf-8?B?QnlOZGpkL2Z4ZVk4YVNLSnkyRDVaUG95ZzJ2STdaTFJQMnNTamlESElkRmtN?=
 =?utf-8?B?TjhLaTZmTTdVcmJnVGUyTVA4UXFJbjRDZ1dhdWFNUStqbDBiWGx5S08vUGtK?=
 =?utf-8?B?SXZDcTdIem9ZQy9UQ0huVXRVWWZLK09ZRndiWFh1cXdyVDhSUW8xSUNNUWxF?=
 =?utf-8?B?L1FWWUlWbEdxd3JsTUlyL0hlbC9MSG9RV2RKeiswanBnZVp5dkkwWjJqT1Zv?=
 =?utf-8?B?SWtTUEYxVmt5bFU2dlY2VnJqZ2t5TThUaHZBOEdndmZVbmhEUDltRjhiYm94?=
 =?utf-8?B?UDJyRTRwbFpUZ3FyTExDUkVhY0ZPb29vcm83MHNhUkxnZkxMVXRQY0ZrZXAv?=
 =?utf-8?B?Q0hZd3JTVzVHeHFnL0dWT3lIMk94ZVgvMWkxeFAycHA2RHQ5R29oanFxRFNo?=
 =?utf-8?B?eEJBcW0yNVQ5WGJhWFpZS2IwS0FMSzcxVEZ2VlhYVlBSNm5wUk54SDJkbFFy?=
 =?utf-8?B?U1M4Yk8yTDdHTVdGcHV2UzIyalU0bzRjMmVqRXdpbEl4UWh4TnpTdWJkTy8r?=
 =?utf-8?B?b3FBUDZ3MEtqTTlxYlprTER1YzlCemlTcFZUbU5mLzB2L3h3SHM0cC9HUW9I?=
 =?utf-8?B?QURQODIwNHltVDNBZzZRUFhhSmVacDMvNnZjZjZLUXJVcDBIRWE2V0g1K2wz?=
 =?utf-8?B?SktDdDgzR0VONGwzT3JLVldRVm11L1lCS3k5dW5KaWVWMGM5THc5SGEyaXpl?=
 =?utf-8?B?OXBFcW5DL1ZKU1ZlRVJybldBMU1EMXorSGxpMlUyM0tZMXdrb3cvWkpTRkh0?=
 =?utf-8?B?VlFYVzJoT3pzdE1UK2xlNTkwVlA0THBjeWpNZHdZLytENjBvYWZvOEpPcUd2?=
 =?utf-8?B?L29udzFWZkpxbHFaZ3ZVWUZsUGJWNmlsQ1dXUVArUEZHZHBtMWlWV01ZdTh2?=
 =?utf-8?B?QVdtT0J2Rm1nMVlpUHRkaHV6MkwwKzE2T2NpZWFpRUF6VytLN3JPb2twRDVQ?=
 =?utf-8?B?cFFzQkRXNUFOU3BXelBMLzFwRElnOFFPRGdVdXBuRXdFbmdBaVJ0SngyOTRQ?=
 =?utf-8?B?QUlYNFdpVFoyNW1NdUxXTC93QnhHZEVYTGMrek5JOFRXWCtrd0NBcmRqVzl2?=
 =?utf-8?B?SzBSTURRVUFaS3o1MGNoanBOZk1QYlpFb0dEK1UvU0VNaEtYTEF2c0hDQ2tQ?=
 =?utf-8?B?cVhMSHRBRllraEdNMkc1L3JjV3N5VXl4MnRGYjFzTUJCWUNNNE4ySUlkYWVW?=
 =?utf-8?B?aWpHSVViTnNZL2FFVjdUUXBNSmRYZFVCZjZ6VFZTQlJxUDM4Q1VrbnRNSFNa?=
 =?utf-8?B?aTdoZVZCWDBKNERoZmZHak9ZZk05NkZZOVdKazd5ekdZTkdsNmdoVnd2blVW?=
 =?utf-8?B?WWZveTdxVkFDN0FvM2tXaGkrb0RvTGV5UG5vRU1GVWc5SHFLaWsxYjgzMUM2?=
 =?utf-8?B?NUt2cEtteXJUdVRLcmwzeDlNZ2NwbmMyNmN0QzI2S3haN3VBaFhFQUFjbUht?=
 =?utf-8?B?eC9VQnNxR05EWDdQRzMrUTR2dElsRGFWeThzUmZWSE5VTVJhK3AvRmNCQWNH?=
 =?utf-8?B?N2xvd2Q1bGRYSHpuNEtGNXdqaGNRTUc2N1BrN1Y5dGM3cXluNmRDUlk0WXVD?=
 =?utf-8?B?c2FIQzBROGVVQVE2R0RrdHd5WVJ2STlTa3FqYkNZd3g1b3Y0V0tKc1NkYVFh?=
 =?utf-8?B?K1RPYXRBcFlDRjVvK0lIZmt4MFVDVE5YN2ZHcHNFT3FBdnhvVGlleXUwTFNp?=
 =?utf-8?B?ZkdqdEVhQ1lsVU5aVFlzZ2dUcmdrN3BHWVJIejZhd0lrc0Q4RmNBdEpITDNl?=
 =?utf-8?B?N2VkeER0T0J0cnc3RHJHVmhEc2M4N0N1QmVOaEh2dXI0VjRXbC9Fb1ZvRnRK?=
 =?utf-8?Q?jvT0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:47.2680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3990cc-c2ab-484f-4321-08de1bca4417
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 05:01:57PM +0100, Eric Auger wrote:
> >>>> On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> >>>>> On ARM, devices behind an IOMMU have their MSI doorbell addresses
> >>>>> translated by the IOMMU. In nested mode, this translation happens in
> >>>>> two stages (gIOVA → gPA → ITS page).
> >>>>>
> >>>>> In accelerated SMMUv3 mode, both stages are handled by hardware, so
> >>>>> get_address_space() returns the system address space so that VFIO
> >>>>> can setup stage-2 mappings for system address space.
> >>>> Sorry but I still don't catch the above. Can you explain (most probably
> >>>> again) why this is a requirement to return the system as so that VFIO
> >>>> can setup stage-2 mappings for system address space. I am sorry for
> >>>> insisting (at the risk of being stubborn or dumb) but I fail to
> >>>> understand the requirement. As far as I remember the way I integrated it
> >>>> at the old times did not require that change:
> >>>> https://lore.kernel.org/all/20210411120912.15770-1-
> >>>> eric.auger@redhat.com/
> >>>> I used a vfio_prereg_listener to force the S2 mapping.
> >>> Yes I remember that.
> >>>
> >>>> What has changed that forces us now to have this gym
> >>> This approach achieves the same outcome, but through a
> >>> different mechanism. Returning the system address space
> >>> here ensures that VFIO sets up the Stage-2 mappings for
> >>> devices behind the accelerated SMMUv3.
> >>>
> >>> I think, this makes sense because, in the accelerated case, the
> >>> device is no longer managed by QEMU’s SMMUv3 model. The
> >> On the other hand, as we discussed on v4 by returning system as you
> >> pretend there is no translation in place which is not true. Now we use
> >> an alias for it but it has not really removed its usage. Also it forces
> >> use to hack around the MSI mapping and introduce new PCIIOMMUOps.
> >> Have
> >> you assessed the feasability of using vfio_prereg_listener to force the
> >> S2 mapping. Is it simply not relevant anymore or could it be used also
> >> with the iommufd be integration? Eric
> > IIUC, the prereg_listener mechanism just enables us to setup the s2
> > mappings. For MSI, In your version, I see that smmu_find_add_as()
> > always returns IOMMU as. How is that supposed to work if the Guest
> > has s1 bypass mode STE for the device?
> 
> I need to delve into it again as I forgot the details. Will come back to
> you ...

We aligned with Intel previously about this system address space.
You might know these very well, yet here are the breakdowns:

1. VFIO core has a container that manages an HWPT. By default, it
   allocates a stage-1 normal HWPT, unless vIOMMU requests for a
   nesting parent HWPT for accelerated cases.
2. VFIO core adds a listener for that HWPT and sets up a handler
   vfio_container_region_add() where it checks the memory region
   whether it is iommu or not.
   a. In case of !IOMMU as (i.e. system address space), it treats
      the address space as a RAM region, and handles all stage-2
      mappings for the core allocated nesting parent HWPT.
   b. In case of IOMMU as (i.e. a translation type) it sets up
      the IOTLB notifier and translation replay while bypassing
      the listener for RAM region.

In an accelerated case, we need stage-2 mappings to match with the
nesting parent HWPT. So, returning system address space or an alias
of that notifies the vfio core to take the 2.a path.

If we take 2.b path by returning IOMMU as in smmu_find_add_as, the
VFIO core would no longer listen to the RAM region for us, i.e. no
stage-2 HWPT nor mappings. vIOMMU would have to allocate a nesting
parent and manage the stage-2 mappings by adding a listener in its
own code, which is largely duplicated with the core code.

-------------- so far this works for Intel and ARM--------------

3. On ARM, vPCI device is programmed with gIOVA, so KVM has to
   follow what the vPCI is told to inject vIRQs. This requires
   a translation at the nested stage-1 address space. Note that
   vSMMU in this case doesn't manage translation as it doesn't
   need to. But there is no other sane way for KVM to know the
   vITS page corresponding to the given gIOVA. So, we invented
   the get_msi_address_space op.

(3) makes sense because there is a complication in the MSI that
does a 2-stage translation on ARM and KVM must follow the stage-1
input address, leaving us no choice to have two address spaces.

Thanks
Nicolin


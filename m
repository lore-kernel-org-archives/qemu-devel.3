Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED95FEE4992
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeCG-0007LH-RZ; Tue, 30 Dec 2025 13:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaeBy-0007HK-Cb; Tue, 30 Dec 2025 13:11:35 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaeBv-0004Ou-U3; Tue, 30 Dec 2025 13:11:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rH3WnODISOzvKaGRgzkB9r40GeaepcKsPIiP7fJD53BnnAyAG7az9NoprJZrcRKZSVEj5eNzQ1CRXC6CyBG7JjO1z4xHSqM5hpS/eDeluSsJz7N4ifk71Aug2hqGndBrrbPeXbg8oB8Sg3WSv53hl0pvvgKbEinl794TNcu5S9lyKvhbsXVb1bX3hi9EqwChA9yy6W+Fg0W2bKyZQgGILS1ZBPnMxu20bJ8P7HIA5nyliepSXzk6Dbw1nor54+xVp2V1avord1E4KKotiBLZyg1brb0eOhlnV5WXyEWEhLj+ajJY4nsH2qrebAtqB7vak9cW4sH7QLMRNkRYgGfuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrmh4kTnkjJJOXKYMJghZ1ebt4SBh7Rr4U2ff0Mb0B0=;
 b=ND7fJTp6dZIx8qEjlQoJ7VLH15QG2JGophBOt5kCjUfEZqyyTTh3ZJJjRHxRC6myp9KO9vQSAkX5CPTmG8af6BZ3PMvrDsbaaJo2uAyfvsHxy2BY6zMpzwddkQqD4GM2uusiq26WsR6L4QL9v1zQZeYhKzXX5CB5m3XdNhiH0MGTxd4KfQIfuzRMqQaCu3lGQiW2bB1EHruSV+vMf2ThaaM4cAGz5w6BUj23V6RF2KljWVyKCRzDSonPKaV8r4xpi4YrA1FxVrbreMy9BeUvpAL1NkJhNvLtrfaJ5QdqFX3+2UnvAwXfOf+oQ6HbajB584TG8X58o6qC1Tv5Ukm1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrmh4kTnkjJJOXKYMJghZ1ebt4SBh7Rr4U2ff0Mb0B0=;
 b=ksWDBp4I12jhT+EH1V2q1H6DFmRD/kVmiHcdi+nUnrWf8h88UAJ8QZg/0Rrbi4MUmZIHrxJq9q/VRrNHwqD2mehd2HX4uJi4dQ58SeAiglbgphq0FGQU3xlLKg3L38fTZlBCILAvQNY6oqGjaZZjjSEA/oOKXbeCTx1TsIeUhQI7azNqyw+ZazKNBYfakAgYHqxd19y32QJELvipf/48SCvJmwiv36Gqtvr11xekUY3Fy02zoSXtjwL72GH78c2hcUhZutie63roNkfKOA7Z5zMnmdm+udW6zITGymekkrE+f/mN3eHC/i+Rl768LC9C6Cl2SLw/Nydb8RjtYTGAeQ==
Received: from SJ0PR05CA0189.namprd05.prod.outlook.com (2603:10b6:a03:330::14)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 18:11:25 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::60) by SJ0PR05CA0189.outlook.office365.com
 (2603:10b6:a03:330::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 18:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 18:11:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 10:11:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 30 Dec 2025 10:11:21 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Dec 2025 10:11:20 -0800
Date: Tue, 30 Dec 2025 10:11:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Message-ID: <aVQVxrGenUgN7MNS@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
 <aVLgV+kscNVlHjIq@Asurada-Nvidia>
 <CH3PR12MB7548E7EC8F2C1FD748BCAA65ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548E7EC8F2C1FD748BCAA65ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: fe770547-d378-45dc-d5dd-08de47ced832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnpoZnFDNEtMT1U0Mk1iSXpNRE5pRjd1bXFKeHRrSUYzWEFWcmVvRlJjQUhQ?=
 =?utf-8?B?S3QzbGVUTExEWTQwcng3TTVFL054RVlPSklsRTRsODNhWFlnVE5IZFRZZkRv?=
 =?utf-8?B?RG5taDY5Y3FVS0paZEt1djFzNVF0bnR0aTg0QnNIZmp3Nm5YMm5vQTBkYXdm?=
 =?utf-8?B?V2FhU216QUNhZklDME9ZdHJOWVNra3BISmFMaXVNZlhNYWdOMGJGTGExNEVG?=
 =?utf-8?B?eTNIMFR1NlJ3b1J1Tkk0QW43UklqMmVvSFFvU21ONUw0RklZNU5sd0hLNWZQ?=
 =?utf-8?B?V2c2alR1WXFTUVQvZldwRVBzdGJMOW83a2VYQjU2RmpTM2wrMzlwWDE3Skhj?=
 =?utf-8?B?bU5KVGdRV0hIelJvM2tjL3JPT1ptcG12ZGkyOW9jM0V2MTFYalFVRWU2azJ6?=
 =?utf-8?B?SjNmZkRpMlZ0QnJwRnFkZUhJUFFpVG9zbDhzMGR4a1dkLzlKTHZsZHZJdEJH?=
 =?utf-8?B?Zk15ZGIwcmMzUklHTW9YZ1hSOVBYNkJ6VDdmcGx0ZXNmaHRYU1o1NnlpRW9y?=
 =?utf-8?B?K3lJeVBiWUM4UkkvaSs4QlZBWUkyMTcrQVIwdmdFeHFTSkRZa1BYQ00rZTBz?=
 =?utf-8?B?b2hmeTBRZFZlMFlvbnh6bjBMOFVxTU56TUNmeU5WVWNzQStFL2svOGxGVU5h?=
 =?utf-8?B?YStEenRWamVmMWJQUXlWaDMrWTlUVVBDazJQWkVRZXRaZUN2a0FkdzRaeGRE?=
 =?utf-8?B?NzFvanMwa3hUb1AwWDhqOUpmSDdheUI4b1NsdlR4N3FiZ1lLQlpWZWxXOHgw?=
 =?utf-8?B?YVp3N2F5blhSb2pqRHYzbHVqUnJxakVyV24wbG9kWGFjMGR3WjBnSU42cnAr?=
 =?utf-8?B?QnBnVVVXeTlnNFhVQ0RFVTZwamQ5eTFPYU9kRUpSQjYzR1dsNEFBZVZXVkpZ?=
 =?utf-8?B?OFpJWmF1QkxGUC9sOWJqRGQrdVgxcnVkeXZ1RlBDTVlzTHJTd3NRSXFqbTNj?=
 =?utf-8?B?ZkI2ang1WHBHUVFsN29wRWxjMzdJRStiWHN6UEFGSlgxS0Rjd1BnWVg5bXZ3?=
 =?utf-8?B?YzFlcUIrTzFMVWRUUmR4RVpGeUllTzl3NGc3aFBtUUpPY0prN0FiMThTZENZ?=
 =?utf-8?B?SGVQMFk2M2s1dGVEblN0c1RjcUo0Q3lVY0kraTQ0WENRNmNrbTR3YThIUERn?=
 =?utf-8?B?OTdQK2ZQa1hkOEJDNkZaNzVqazFiVk1PcEdDQ201Y1pTem0vVjFuVVpGdERa?=
 =?utf-8?B?UFVBbVJ4OUFqTVdXeWNFVnVkc1pTZkZPYVVtYUhsSzFtODBsUHRxenNvTW8v?=
 =?utf-8?B?Ry9zaFFsMWNza3k0aDRmdHArMEk4VlFwQ05PQTRUMG5ya3RyTlRyV1NSdjBJ?=
 =?utf-8?B?blRIdk9tTVpkQ2NPR2JHcWdEUXBSQllFWnNwcExNZnFBdWZGYWhhSXBlQTFk?=
 =?utf-8?B?T1pJOEExTDhmWWFwVlJQRFZBSUdVWU5XMFk0RmJPWHkwVk9YUHdoc004eS9B?=
 =?utf-8?B?QVdJSjVIY3Y4OFNtQ2dDbzlhaFNIWTNKbENmb0E2cEFkVHBReDJ2WUhnclJE?=
 =?utf-8?B?cExmTlFkYnFIU1dnN0VrWkVhZnlSbnVXMkdVYVkrSU5WQzdrVTFHR0g0eXpJ?=
 =?utf-8?B?dloxcHloQk8yTkJvTlJhQk83eVBZV1VHWFU4YnZXYThkWWx6WG80Wlp0VURv?=
 =?utf-8?B?Z2ZRTlJicHo5TElNdWJPNmpqUWhXTEFRTGJRS2pNdXMrWmREK1lzMUpYTjlw?=
 =?utf-8?B?OGNGZDN1THlTVEFaVjVsdUxSU0NDVFA1VXJvMldzUHA2ZEVOMHBhRk1scmRI?=
 =?utf-8?B?VS9UeDN1VC9xYVA2VW5kRHFmeHFiVnU5ckQ5Ti93WC9MNkJTenNQT28wMmpr?=
 =?utf-8?B?ZVNocGhIVzY3YkNGMEtDb0RXYnQzSm1peUZNemwxYTg5QmZDOEpYbVhGVk1p?=
 =?utf-8?B?OStIY0J1cFVqQ2VBTm8xcFI3SDFDVU9KekRodi9xNGM5cFRDREpQRGFOSi8y?=
 =?utf-8?B?TzJyZWxLTGowN1lNZ05lcStEeGZ5dEJ5YUl3dTF2dzNnWDBYcFZaOTY1WlN5?=
 =?utf-8?B?a1R5UDdYWnF6eUxyTU5JKzdueWxQWmtKMVZYTjhQYTgzVUd2Wk1Hd2JkMnZs?=
 =?utf-8?B?dUVSY0lnQWdHWW5aU0ZyTzZrS2xpVzEvQ1d0bFdUSGVuaDNLeFVYN1lKSUtX?=
 =?utf-8?Q?ClQ0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 18:11:24.9057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe770547-d378-45dc-d5dd-08de47ced832
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

On Tue, Dec 30, 2025 at 02:13:12AM -0800, Shameer Kolothum wrote:
> 
> 
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 29 December 2025 20:11
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241
> > CMDQV nodes in DSDT
> > 
> > On Wed, Dec 10, 2025 at 01:37:36PM +0000, Shameer Kolothum wrote:
> > > +static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
> > > +{
> > > +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> > > +    GArray *sdev_blob = opaque;
> > > +    PlatformBusDevice *pbus;
> > > +    AcpiSMMUv3Dev sdev;
> > > +    SysBusDevice *sbdev;
> > > +
> > > +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > > +    sbdev = SYS_BUS_DEVICE(obj);
> > > +    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> > > +    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> > > +    sdev.irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
> > > +    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> > > +    sdev.irq += ARM_SPI_BASE;
> > > +    g_array_append_val(sdev_blob, sdev);
> > > +    return 0;
> > 
> > This is pre-building SMMU's IORT nodes right? Maybe a different
> > naming? And can be shared with the existing iort_smmuv3_devices?
> 
> Not really, if you are referring about this patch here,
> https://github.com/NVIDIA/QEMU/commit/cc3b65e6a49a9b7addf44b377d4ef1de99bfee3f

Yes. I am talking about this. But you are actually pre-building an
ACPI SMMU device array here. So, my question wasn't accurate..
 
> I didn’t find a clean way to store the pre-built smmuv3_devs other than
> placing them in struct AcpiBuildTables. It’s not clear we gain much by
> restructuring things to populate and store them separately. At best,
> it might slightly improve boot time, and if that becomes important we
> can always add it as an optimization later.
> 
> This patch enumerates SMMUv3 accel instances with CMDQV separately, uses
> that information to build the DSDT, and then frees the device array.

Oh, I missed the g_array_free() in acpi_dsdt_add_tegra241_cmdqv().

Let's have a note inline and copy to the commit message too.

> > We do so, because we need to link CMDQV's DSDT node to the SMMU's
> > IORT node but it is created in build_iort() that is called after
> > build_dsdt().
> 
> Hmm..not sure I get that. Does this mean IORT has a link to DSDT? I can't find one..
> Maybe I missed. Please let me know.

The _UID field of the DSDT node links to the Identifier field of an
SMMU's IORT node. E.g.

[DSDT] // Qemu builds DSDT first
CMDQV0 {
    _UID = 0;
}

[IORT] // Then builds IORT
SMMU0 {
    Identifier = 0;
}

If we are sure that the SMMU sequence is fixed every time we rebuild
the sdev array so that IORT.Identifier matches with DSDT._UID, we'd
be fine. That being said, we should probably make a node inline too.

Otherwise, it would be safer to pre-build the sdev array and use the
same array in both DSDT and IORT.

Thanks
Nicolin


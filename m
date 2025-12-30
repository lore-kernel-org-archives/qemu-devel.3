Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D62EE4997
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeOd-0004Wa-4o; Tue, 30 Dec 2025 13:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaeOI-0004MV-0S; Tue, 30 Dec 2025 13:24:21 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaeOB-0007Nh-Bl; Tue, 30 Dec 2025 13:24:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiaf14c0FIjrwwoFlg8EzHLl1gqRAP6Q+UwTrzoaT02+NDGRMrFP8F63bKo4B2N+FXKOpJEYkfip5MnlhLoRJ0O8YxE7e/ZIeDi5V44zSAeAFWERmO+dl3DHrCS9356JZS25p9f92ZLN2XQul8Lfu8w1SuDC0jHR/2FPGeSGdoAd+p8gIlklxBHB1Cd+mENT70lT6R58EO12UvfG7/1lZ/j2LARr+bXw2BvMhF0nZlVFniDmP6TQHwMRGpBgI9fzHulnsSmPITVTvOFN9XJ2SN2iMybra9jS/3D4jgEHpvDUBubmpppLBo+IvB1LfHPb7ewSZz4DM5tkNqu/YaoZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=536Zi39F4QWm1Zk4Am1AuEaXWcZ7rSZb8h8uWftO6Mw=;
 b=on5hoMZev2zykzNm8tH0m3txn52hJOkpJEUjOenF/xVI5qglwR/QJrLCUWu25sY2pex0ZEfD4fz6S7M51zz2WCkbeE3D/s+EZbh1JrIeicbETquFFW/nYHQIjFUKhJuXMdZSUtePaI/F/wRiZfTEXKaXpRtVo9soKtYd42J6i6SG3unUlBmLGjM/nepTbsXrqqhywGb1XK4TxQ08CPa3h44fpcCHl/EDYpVS4ZBQnNnscz2kv/wQTi7UlMXeS/IcbWBGAbJjtJgkn+3VmTd0kouT0BtBYylxiMKTFxN6NhxKfTCyFpw7I2vt1AZ6lTfYFFkPvEg8u8qhZtcf54wIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=536Zi39F4QWm1Zk4Am1AuEaXWcZ7rSZb8h8uWftO6Mw=;
 b=lywdbSG7TCLs6C6R9tc4gJPzC1/L1NHRSvLPOpoFwED4PjbwmEwTfmz01I5vUp8DmR1sLF92PdacAoH7LX4fC8grO8igaZ8JegAv4i9MaLkhDRHrXCCqrbAs/or3A9hjQqi6ruzCGU5LNJPVjm1ERMrsh1LBueJ/716AhAq012CfrGcPZ9pgu22+yDqBC8+QmbT+v4RlAcnuIp7l2mNYOmx5tYuxY++WT6DgrQTouK54YTsSfC3ki8eJptLa+X4AzF6u3dTUdIK60ry8yHM9x13BfvNmMQWMr3RugAF0PnzkINOQ6BDE6wFmXvJuAWp9doGEv3e2HOjMAvojzz7wmQ==
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 18:24:04 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::32) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 18:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 18:24:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 10:23:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 10:23:48 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Dec 2025 10:23:47 -0800
Date: Tue, 30 Dec 2025 10:23:45 -0800
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
Message-ID: <aVQYsTJPNmYPY3VH@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
 <aVLgV+kscNVlHjIq@Asurada-Nvidia>
 <CH3PR12MB7548E7EC8F2C1FD748BCAA65ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aVQVxrGenUgN7MNS@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVQVxrGenUgN7MNS@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c8abdc-be62-4831-2118-08de47d09c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkZ5TmlFWG9IdkNYNmR0WFpqKy9kRWpMNEhHQ1hyVThCUVpxSGJIQ2hYMTJ6?=
 =?utf-8?B?cGZqQUZMMUNkT2FwamthTm5PQ3AydnpqbGNZTFc2M0NTTE5JTWM3aWU4RWZr?=
 =?utf-8?B?bUdUVEQ3ZDlhV1FOWU1RWGNMak0raW00SytDNTU4akF3RW03eS82bUdVdEd6?=
 =?utf-8?B?aDVlbmttRTdvSENHV3ZSd01jMVZUY0RyeE9hN2RNSjVYcmhEdi9yTWVQTGt6?=
 =?utf-8?B?bmZkRGx4Um5wcmhoWVRFK2tRR29kRkY3UktsSEY4b2JDS0Q5TVBvcGxLQnd5?=
 =?utf-8?B?Mk9qUGRmVkd6Ni8rTExaRHVPTXlKTDR3NG5RMUVDSWpyZ0ozbU03MmphSTBl?=
 =?utf-8?B?SEZ1NEhkYWVKcDhRS3R2WXBudXRvMkFQT0p5Uy9tczdyOXRBZVhwMmpHKzFy?=
 =?utf-8?B?S3V2TW8xVkgzZXR3STBOQUY0R1BDM05WMTNCS0dLTFlFQXVSdW8rZmRhSjlU?=
 =?utf-8?B?dER5dmp1WDZCUEUrc1ZZYjBnd1RzcEFpV0VtaVl5aHpsNXNtelFLU2NPSjRx?=
 =?utf-8?B?VWEzS2FjY2Q1bFlMcjF4a3hoNGlHV0V3OUdaV0ZqQ0VmdUlGeUlGMVYxZWMr?=
 =?utf-8?B?bVBWYytCZmFVN0VmbmxlYkExVms5THV1bnc3M3hWZ09pNGRHdzJOTlNTR1E4?=
 =?utf-8?B?UkoycW1uU1EzSHpmZGZMUEsyMGN5Rk9xT2xTS1pPd1crUHFEYUptUHZGOUEy?=
 =?utf-8?B?aGxCMzU1ckJGZjlROHVRWGs4RGI0NFpUSVdHb0luQUpQNmJYZ0NSK20vbGIv?=
 =?utf-8?B?VllsY0wxWWZBNWszQzUwN1EweTVRV2MxZHB2d2NuQWNsWithUHBtZldIZFdX?=
 =?utf-8?B?WFRZektrN0dmYWdBRUJ1ak1nZjRXclpZanpqdWgxWnN2akdVdk9WVmJOdk8x?=
 =?utf-8?B?TnBJVjBLQkFMQmhOV0R2UTlNOWkra2dndzZVeDdwcmQwODRuc2NHcFFaZHBX?=
 =?utf-8?B?Q2Q0SVIrZXZkUm95TmliTlBOR1dEd282KzBrM1p1RnQzdWlVNkJmZVhwaE15?=
 =?utf-8?B?MFNPNUhzbmlQWDdINW9NdWgvclpxaXloWmVXU21GL3dBSUppOUQvVm9CRHo4?=
 =?utf-8?B?bmlINUxRbytYQnBqZE54Z1l3NEFjZmNIQ0c2RzNjMUgwcXVBaCsveW5qQ1dh?=
 =?utf-8?B?VEZIbWJpVTZGZHlnM3FoVWFoL1orcDJ4YmhaR3BhVlV4OG1WWlFTL2hJbW51?=
 =?utf-8?B?Z1ZJZVY0NTc4eXZ1dkJTMk9WaHROVGk1UDA1dm9lcWZuanBEdTFSbmpjMXhn?=
 =?utf-8?B?WXRhdkc5T0VBT1dNTUNvV2pQdG9ZNWhjYjdvVTRVRUZibjF3L09zNkVLYzI1?=
 =?utf-8?B?YTRHMnREWGRPdnZsRTlnaEd6RXVOcExabXBkbnROV1N3N254QmMvWjRBcmdC?=
 =?utf-8?B?Mlc4Sm9oK0xxMWpJbjc3WTA3d3R1U3MxVVN0bExXVmhvcnJRbDRCMElIUjgy?=
 =?utf-8?B?dnRnNS84SVJmSHBvRDUxS2VSN3doV0lYb2ZaeUgzVnExQ3FEUFRPd0ZjdUZy?=
 =?utf-8?B?ckYrV3p2SDR1cjk2cDllZXBnWlJ4WU41NjgvYzRWcS9ua0FVbVZST1Erb0h3?=
 =?utf-8?B?NGVaOG1TRnVsalp3c1ZlN0ZXWVZXLzdsS0xsWEtDMk5POUV5cjVWUTZNOHYw?=
 =?utf-8?B?dHpTNEsxMjZKWlVlU2g1eTAwbWdxZEdpT0FwMEVzME9IV0lBKzJWbmd6WFdZ?=
 =?utf-8?B?Smg1RzZCQUFsWmZYaUhQdXlvU1B0alRMWWJhK1o4VVFqQW5sblh1OHo3OWxh?=
 =?utf-8?B?TjhzTmgwN0ZLZWl4OVg1ZDcxQ0c1Z3c5WUhndDNNdEZSZWdlNmhxM3dkWGVD?=
 =?utf-8?B?d091ek1PZ0FCT29oU3UzS2NMTVhmTUVjLy96YzlIWUhvMUhqNm5lNVJJRm1X?=
 =?utf-8?B?aHA0dEdYR0JHOXQwYm9vYlorUDBIemIwU3RuZ1VUK3VSalhFTkVQZVNSL252?=
 =?utf-8?B?TFhkMURXMHk5SG50OHllOTJrSGVSS3FxSGQ1RS9BeUJEd2d5UlNHTzQ3VWpP?=
 =?utf-8?B?b2M0a1V0TnREUDljcDlsOFQ3YlkvanBXMFZ4UGZqRnR0cGxJN21ZZE5tZDJt?=
 =?utf-8?B?Sk50U3ZDMjR1NVFwMDJNekFLUm5KOFpLSW9PTzhKbVFsT0hpdXhYa0R2RmVw?=
 =?utf-8?Q?vypI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 18:24:03.4209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c8abdc-be62-4831-2118-08de47d09c58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nicolinc@nvidia.com;
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

On Tue, Dec 30, 2025 at 10:11:20AM -0800, Nicolin Chen wrote:
> On Tue, Dec 30, 2025 at 02:13:12AM -0800, Shameer Kolothum wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: 29 December 2025 20:11
> > > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> > > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> > > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > > <kjaju@nvidia.com>
> > > Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241
> > > CMDQV nodes in DSDT
> > > 
> > > On Wed, Dec 10, 2025 at 01:37:36PM +0000, Shameer Kolothum wrote:
> > > > +static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
> > > > +{
> > > > +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> > > > +    GArray *sdev_blob = opaque;
> > > > +    PlatformBusDevice *pbus;
> > > > +    AcpiSMMUv3Dev sdev;
> > > > +    SysBusDevice *sbdev;
> > > > +
> > > > +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > > > +    sbdev = SYS_BUS_DEVICE(obj);
> > > > +    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> > > > +    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> > > > +    sdev.irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
> > > > +    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> > > > +    sdev.irq += ARM_SPI_BASE;
> > > > +    g_array_append_val(sdev_blob, sdev);
> > > > +    return 0;
> > > 
> > > This is pre-building SMMU's IORT nodes right? Maybe a different
> > > naming? And can be shared with the existing iort_smmuv3_devices?
> > 
> > Not really, if you are referring about this patch here,
> > https://github.com/NVIDIA/QEMU/commit/cc3b65e6a49a9b7addf44b377d4ef1de99bfee3f
> 
> Yes. I am talking about this. But you are actually pre-building an
> ACPI SMMU device array here. So, my question wasn't accurate..
>  
> > I didn’t find a clean way to store the pre-built smmuv3_devs other than
> > placing them in struct AcpiBuildTables. It’s not clear we gain much by
> > restructuring things to populate and store them separately. At best,
> > it might slightly improve boot time, and if that becomes important we
> > can always add it as an optimization later.
> > 
> > This patch enumerates SMMUv3 accel instances with CMDQV separately, uses
> > that information to build the DSDT, and then frees the device array.
> 
> Oh, I missed the g_array_free() in acpi_dsdt_add_tegra241_cmdqv().
> 
> Let's have a note inline and copy to the commit message too.
> 
> > > We do so, because we need to link CMDQV's DSDT node to the SMMU's
> > > IORT node but it is created in build_iort() that is called after
> > > build_dsdt().
> > 
> > Hmm..not sure I get that. Does this mean IORT has a link to DSDT? I can't find one..
> > Maybe I missed. Please let me know.
> 
> The _UID field of the DSDT node links to the Identifier field of an
> SMMU's IORT node. E.g.
> 
> [DSDT] // Qemu builds DSDT first
> CMDQV0 {
>     _UID = 0;
> }
> 
> [IORT] // Then builds IORT
> SMMU0 {
>     Identifier = 0;
> }
> 
> If we are sure that the SMMU sequence is fixed every time we rebuild
> the sdev array so that IORT.Identifier matches with DSDT._UID, we'd
> be fine. That being said, we should probably make a node inline too.

Typo: node->note

> Otherwise, it would be safer to pre-build the sdev array and use the
> same array in both DSDT and IORT.
> 
> Thanks
> Nicolin


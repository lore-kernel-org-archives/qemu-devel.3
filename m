Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5743DCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyJc-0001u8-Bm; Mon, 04 May 2026 14:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyJZ-0001tc-CO; Mon, 04 May 2026 14:46:45 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyJX-0001Y5-R0; Mon, 04 May 2026 14:46:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofZO6iI1QB8ztw5ygqr5ZMsfgEWL1pgZM2GsZK8o7C7fkC08TCxc4SJXzXNiDWsrhaZcBfM3RGr84962E2OgLFU5rIaHRpFFPP/+Epi/3si+8KRpXVvSJlnV1dTKGfPLWAp2Be5FaDKkxH13rcNYMVGSXCiIZ4WhpBJE5AfkrKALmuMFCpdjcNRQyva9QBbPlWTLhVH8Kd+OgSJtVP5LiZEnDbRqXETZPpsQj++Iij4r/c3koQJ6dRSavsRyS7gLyR4EqgMHwQyDqKpKQ69VhqroV0Gb7K3Xno/cw2SWX7QXeq4Q1T5GpOGe4vNAXVMzds0jDv0oXRaD708deCkXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFXxIsn9sNGyExp8eXBi5IiX9vjHDzF4iamLxQU+uSE=;
 b=b9Z5Vy96nEWXKvLT6rk/2l8sAInO2phIqh8JinYjAwtYwmTgb6iaZRM62wnjVyAnSkVx09L6dSHXYVT3J9tyIX1ZvANnJsE1KduLOW/lpslgBssKvfDiecAJ8S4WEjdldlgvgSXTE0qGtrcDr54i+GH+jEHzY4ItkVhjPSD04inJ0dup9Nzz+ErYkdcNjuOrieFfbdeh49iiDE1gyVw7Y6+YYByLIPTluBHaLLRRMLvlmimCJI0aTdbT6EuwOWVUtpT8EfsreRsH9WHXA06ApvUDJKRSUWWdE/TqoUw4T/EQkuEW5+tLX3RyHYe3gpXU5AVuBNyQMxdPcBPWTIyuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFXxIsn9sNGyExp8eXBi5IiX9vjHDzF4iamLxQU+uSE=;
 b=gND8GoT+FwGsIB8ouwetNQ/yckI40nyDQqdh8HmsJRtQ9KUFEhZ/u4A/YbWt39xikPiXCfRePsfR5DEBVToVXKXegj0i82Zr8iyyMHnFiGoJR6nbHVEiTLvmNIWH7cD7ZbALvAwmxvu/+QO5oBCWHFFQ+WCxwSsEkkAoDWjQ/autA3bI6y3nRAGM8WxZROkpcRZPcjepJDfPRyW4kGMLEcJr5QsyQ5xsOdxlAcBFrx9hhQRog0j3iiphzBwfXd6eZTrGdJkMronnWEucGEjAn40fYkuXdhi3IViQ8ONCxTrv4A5LTS9y0kDezooq/iCTZ5SFg8a5oAfmcYPmenT87Q==
Received: from PH1PEPF00013311.namprd07.prod.outlook.com (2603:10b6:518:1::c)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:46:37 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH1PEPF00013311.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:46:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:46:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:46:13 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:46:10 -0700
Date: Mon, 4 May 2026 11:46:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 09/31] hw/arm/virt: Use stored SMMUv3 device list for
 IORT build
Message-ID: <afjpcIeIJyOVsikV@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-10-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-10-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f010370-e493-416a-b446-08deaa0d78b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9hxh6ibnNwKrv5noaGK9KHxwqYdwMir5UTkbhFI54s7/Y+tL4+ouYHaIh75A9MGcwFcN/oosTYEgsOqe0n/S5bf9Alj1rrSvSQuXcqGTcPaF2qGvP38M5F8X+gPiPPk6VH/KKulESQIhxXEDx9DyCoNFtOZUXsfRkKN3bpkRy7g+gWCtNUV43ThBhmvevzj0Vf0Oss3+CJ7y1QGQocMOjmzaeJDWNTijWj4QW3DIEwyuyC+VwRNec8LNWZIDlZTjUFipCra/Ccqxss2vJZwUJiviHiWAx+eEClRTMkNoKNV/wIoD/a4OO2O4uLZIq3FSFOg+jyFoUVje4K1QIPmEKWqS/q4YkPBWMAYzrVtmvriZ4Q6clFuaAwEuo96Z8TucU0NaAZ7aiz1kd1wIG23mcIlIMjxjCxRjJuj8JLJxOGi8WwyTro9spDx7M+BtDQnMU9qZG9L7TzjgMtreP4E1HqS5cvHHV1i1twfsp9gNC4t9LnZfo2xb0b1DsGx28WY7+YFbapJmM7a6qB1RhyTTMVyG1X6X9k+3csHTnWJIoo4lzIegIkn6FOWivL+kDmbtl05IbS3K8EnJG77zUt2NeSkwPOpU3iEzdipCI2yQnjXTC8HF1p8Q6lTXaEtPio9ECcxzMBqUG35u0ioxOs8pKpM5Pth2ZiztWH5iYlTpIt7DKOYZkofOrVvjA+rthzg6uepPOTONKX4hmu6Ns8D7qv63vL8tC0eytP8pUH5++uE=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: laFFUbEDGRbKxrk+UJJ2ncUuLmWp0LugJRj+2A50nuvk2D9zkDeCEuRO76DzMVWTDTvnrAl18H+/Ck+1HGPHELZ+tM2bIuJi9XaonigTRCoNXlvG+f1d4fEwKG1gJMmbcbEA2UbFuDg5JKUhmUo5IoxQxZObPKyDvwPzSu3GUWNek6nvyO6d0TMJBKPU8NgGs3XzsuQ4oHoth+tDy1qKyK8sGI+IJ/Yj4b3yhnwIY0v791/5m+BVKM5Uy5Oqk7Yg0/1I8UpcrhF1H+FnNfkWYpfzBKMjUsk659aofWV3DQVK7AUTntfkVgSsMytrXRzbKY26P7smScL+9lRIAiYlwadrrg6GRVAUIc2jNQt5pjYBuUtGhqk18y1twi+Wqdueh1Yx/teNbGeUSp2yhMfDrq51ykHS0ISMz08sS+LCe28kc3pS3zkcyx/iszlLUHHz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:46:36.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f010370-e493-416a-b446-08deaa0d78b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 15, 2026 at 11:55:30AM +0100, Shameer Kolothum wrote:
> -static int iort_smmuv3_devices(Object *obj, void *opaque)
> -{
> -    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> -    AcpiIortSMMUv3Dev sdev = {0};
> -    GArray *sdev_blob = opaque;
> -    AcpiIortIdMapping idmap;
> -    PlatformBusDevice *pbus;
> -    int min_bus, max_bus;
> -    SysBusDevice *sbdev;
> -    PCIBus *bus;
> -
> -    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> -        return 0;
> -    }
> -
> -    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
> -    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
> -    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
> -    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> -    sbdev = SYS_BUS_DEVICE(obj);
> -    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> -    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> -    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
> -    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> -    sdev.irq += ARM_SPI_BASE;
> -
> -    pci_bus_range(bus, &min_bus, &max_bus);
> -    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> -    idmap.input_base = min_bus << 8,
> -    idmap.id_count = (max_bus - min_bus + 1) << 8,
> -    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
> -    g_array_append_val(sdev_blob, sdev);
> -    return 0;
> -}

This could just stay as:

static int __populate_smmuv3_dev(VirtMachineState *vms, GArray *sdev_blob)

?

Either way,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>


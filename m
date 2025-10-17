Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9802CCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dnY-0007PP-DB; Fri, 17 Oct 2025 02:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9dnW-0007OV-TJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:18:42 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9dnT-0000St-6Y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKxYtk9Xa3ivljZHi82BGtWpDR+fsASVweUEqlKKEwFA4Zu5FM6aO1mPtdNv8cBo1iJnwvRo+Adr+7rGmfBEesPPlkv+9X/yEnG3+BH0lMynN4HVX7/7Eqq+6iJvdgiOV4s4UJPW0jYLfIfbZX/BGKYdumzbY6tF0XelPkSlFOcX1WKAl7olvINtlLcE5Ohna3QBrEftOkeTLv1nMYvt20zSu272T9JJkvO7ckMjk5YFODTkQoJRcwHKcKxoPjbI03dTloMf2gqHoDtatgP77spU+O8I30B7mUKi5sSkJMxyPub/wxi9su/BZnyRUSpcaiECVYaePcsbqf+k4Jq6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZwM131nG2IqGmMIricq8uWHqKa0RaeYquKKvFxq+Ss=;
 b=Hba+sE75Q4nH4LcYmTtKYFsL6dz8qNWiUDiUa0h2nmcUjC+WFoopmQb5qnPyyIMXUAhzqAiEyZc0+6eb7o38UiYtn4jm+PEhLOSR6FIj+DP/DfwgJN+mBw1tkCoGNjtmoAKEigUAuxfgPwXh4kwPejzeSafVNpo5o/XZ1AOwH00e+SUZZ8MJB5AIJjYcK61CP9dx+i3JuKbcUpTebSS6EjteUS2RLmKIdl6AdjbaBZNtSmoV9GWicJJzhNF9FBCyTcvDmjieggL43Q9OM0P5Q+3Byjf+6iO8jCeP6Gg5y1qBUXIMqjckZm9nMpyN911feQilhCw+p5m7Fkm8YVFVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZwM131nG2IqGmMIricq8uWHqKa0RaeYquKKvFxq+Ss=;
 b=kfgL/OSADFFUHvUB7M3xul/DcR63BGYPCj+XPBqC2BMJelGgZsc7EGV0zOcf/xY6DL/EdtQHKEuiWdtHXcc3dI/y1bL+emZ+xdKB08GZnrColDxDooPrsHsqQ9ovXZluGfTafLFwiynDR6U7bvIqmGnkfkB9e+sCFhS3UAuC3Ck=
Received: from CH5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610:1f0::10)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 06:18:31 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1f0:cafe::df) by CH5PR05CA0012.outlook.office365.com
 (2603:10b6:610:1f0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.6 via Frontend Transport; Fri,
 17 Oct 2025 06:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Fri, 17 Oct 2025 06:18:31 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:18:27 -0700
Message-ID: <72b0a089-9148-4257-a0f7-fa9824a97c17@amd.com>
Date: Fri, 17 Oct 2025 11:48:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] amd_iommu: Cleanups and fixes (PART 2)
Content-Language: en-US
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>
References: <20251017061322.1584-1-sarunkod@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251017061322.1584-1-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: acf8e306-a107-4e45-f674-08de0d44feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajNqZWM0WlJuM3lqeTErK2FnSG1QQWlmVmdaWHIrVkJzd0p1Z0Y2M3YzMi9O?=
 =?utf-8?B?N1pQRUUrY2tpbnpYQlFnc2lqQXF0c2pGb2U2YUtZVnZCYU0rUi84WnBWdXNQ?=
 =?utf-8?B?dWJjb3doTDlOZ0ttWFlxU0pQaGMyeTBVc0VZb1hveHp2T1o2WS9UVHJ4Y3U3?=
 =?utf-8?B?YTliODN3SzhueERtTDRncjd5NTVGWHFEdS9WTjZ0TGVOcUFWNWtoMXhZR2NC?=
 =?utf-8?B?VnhOWkZ0YVhDQjIxV0xiZUQ0dWhkTXpKWEtYT243ODlZdm50N0NWbTQ5emRw?=
 =?utf-8?B?Sm1FdDl2bnBoQUV4MHhaNEdaUUhJUEpBTXZHa2F4UTBjZFNEWG1jUVFyVlF5?=
 =?utf-8?B?OGQ5SnBuRHBoVzQzRTJkaVJGQVRxbHk0WCtQUGFlS0FMeTJ0R1hDU0hqTGFt?=
 =?utf-8?B?bTk3aG1lMnFXeG9acjhHL2RDVXRPL0JNc0c3Y3ZCNEZoSitsN1FDZzNBYVlV?=
 =?utf-8?B?WGx2dHYxSU5RMXd0ODl6SlFkR0NjRDZWMytERVk5ZzNUcHQyZ0xVMU5LRkxl?=
 =?utf-8?B?Y2o3dUVlZEJ4NFBzUnNqcldER1d5VFpjSVlVS1BWaU04RjRSVElqZUM2c21K?=
 =?utf-8?B?MnVKR05PVWlZcm4vMkZXak5DVUJlVHdiQ21zd1o3MnFWd3l1bEdSUUx6WTY5?=
 =?utf-8?B?cnIvSko3OEc1RWpHSHNqREV4ZFlOVWlXclJiaXRHR1RtWE1iSksxV0crbHFu?=
 =?utf-8?B?cGprS3hNcU5OZkZ4RTU0bmRDVnFaZThaZVhoNVZ3NWxsbVAxak1vVGVlREhC?=
 =?utf-8?B?dW1JdnQwYW45OEJ1Y1ZGdWtIaldjZXAxMnFWY3ZhazI4SmpyYzlNeFF4Um9M?=
 =?utf-8?B?UCtIKzJVZHFIa093WGFYSFVFOXg2RGRGcElYZ2FySE9vQkdrMVNiZWFIMnpa?=
 =?utf-8?B?U3oxd3VFTkVLS3ROSm1nSElHVXlpQ2RGemJjeVVBdVpiMSsvSW5BZWVhbTBP?=
 =?utf-8?B?c25sZE1hSmg1WEdkL0pOd2Y3cy9nRld2ZFpNVUNQSFRJN2cyVDVTeERYYi9h?=
 =?utf-8?B?MTJvTisyM2hTZHV6ZzEzYW5DZ3JKZXh3b2MzY3JYS2N2ME1GMDF5ZndTMTcv?=
 =?utf-8?B?aHRQME5UMjhLK3ZRNFVnY296c1BtbHAwM1RYZFRJQ0VZSUduNzhueVBEemNl?=
 =?utf-8?B?WTEyanlnejMrbzZNS0UrYkZrZlY1encrMEkrVHordks5R0JaWlZsejcvc0VJ?=
 =?utf-8?B?dEFoOXJQdFBkY0tMTnM2S09YcWRRd29FcTJNVUQ5cW5oQ3ErRlFVWUNESEYx?=
 =?utf-8?B?aTVWWnJCc29Qa2Rac3JheVhkbjcvUkV3K1NvdXJ0N2RYcTFPL1RWTENoU2U2?=
 =?utf-8?B?S1JoTWcwY1BXN3pkYWxNZWtrc1BaMzlpRCtwbDVFbndaTUJUTjd6OWZUTFNi?=
 =?utf-8?B?L1g1ZkM3anJmaWVVOXF4N0VBVjBITE54a1hkS0VBbVNXcCtUaW1aSW1wOVRG?=
 =?utf-8?B?ZjIyR2gzUVZOL1lremw4aDU4eWhpT1ZiemhvRnppYkFXeVpOOWJ5a3plR0xC?=
 =?utf-8?B?eG5renM4QWZlUUh6ZmJERi94VGxXNFJVblU3eWpYbWpYZ3dBZ2swbGtTZXQ1?=
 =?utf-8?B?aks0VWZKYU96QndqbEJ2S2paNVcxaUlJMWo3QWMvRW9DUVdlclh2K2tqZnRI?=
 =?utf-8?B?WWZ2Wlp4Z2dVSVhWMWw5L0t5Rm5ZTUNwUVZGMmk4VUp3YUxvV3FpaU5RU2Jv?=
 =?utf-8?B?b01RanNWaU43eE5rUlVxNUU1ZVNuS3ZrVmNOMFFQUFlUZnNtUnl6MjJPcW5Q?=
 =?utf-8?B?MUd3cXJ3NjVMbm5sTVhteEEvd3JXa3BDT1pLckhVdDVjQWVRRE1BSFRVT01R?=
 =?utf-8?B?TVY2UDVBZGRwQ3Zad2RMZVgxcEEyV3BZNE9QM2hiVldnb2x3MURxTnlpM0Vh?=
 =?utf-8?B?T0dLYjluK2J3RDJSTTdnSmhQN3plYmpuVnAyZU1DdTJlNEhQYm5hZ0l2Zjhn?=
 =?utf-8?B?dnc5anNSbCtrYmE4MHU5K0FZejZMSS91bTJWZVNaLys0bWt1TE1uWmFCQWxr?=
 =?utf-8?B?aXlzeDhoWURlQzBZYkZ4NUc0NGNITTlLUUE4Q0Z0UFlLdUdEQmJvWXdHU3c5?=
 =?utf-8?B?Y0o1VHJOa083cG1UbHVickw5SWJxYisrTnNvNlJsYUJNa2tMV1FTY0x5OE5K?=
 =?utf-8?Q?J4EM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:18:31.4875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf8e306-a107-4e45-f674-08de0d44feb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/17/2025 11:43 AM, Sairaj Kodilkar wrote:
> This series provide fixes for following two issues:
>
> 1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
>     bus id != 0.
>     e.g. With following command line, dhclient command fails inside the guest
>
>      -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
>      -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>      -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \
>
> 2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
>     setting up the devices when guest is booted with command line
>     "iommu.forcedac=1".
>
>     One example of the failure is when there are two virtio ethernet devices
>     attached to the guest with command line
>     
>         -netdev user,id=USER0 \
>         -netdev user,id=USER1 \
>         -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
>         -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \
>     
>     In this case dhclient fails for second device with following dmesg
>     
>     [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
>     [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
>     [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago
>
> -------------------------------------------------------------------------------
>
> Change log:
> ----------
>
> * Changes since V2:
> https://lore.kernel.org/qemu-devel/20251013050046.393-1-sarunkod@amd.com/
> P1:
>   - Remove cast from the pointer assignment [MST]
>   - Rename struct amdvi_as_key to AMDViAsKey [Alejandro, MST]
>   - Fix compilation error due to missing 'static' [Alejandro]
>
> P2:
>   - Rename struct amdvi_iotlb_key to AMDViIOTLBKey [Alejandro, MST]
>   - Fix compilation error [Alejandro]
>
Correction...
This is AMDVIAskey and AMDVIIOTLBKey, not AMDViAsKey and AMDViIOTLBKey

Thanks
Sairaj


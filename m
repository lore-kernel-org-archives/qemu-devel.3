Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894B2C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 05:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgGT8-0006Md-PF; Thu, 06 Feb 2025 23:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGT7-0006Jm-JS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:59:57 -0500
Received: from mail-bn8nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2418::619]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGT4-0007Wr-O8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijhxWtEQvVBBOAJ+liduaka7Z74p/I5MJASahs8VskJO31gPdsl7wsXFzrQ8haASfUveJlMkd+7FHEAN73jrAkisS+cN5TxBLLvC7eflHXTKEcLAN67ZQe9tBBFePfAAznQsxHRooyKptNOaTGk2uYLeZfMQw295KXw/7Z7M/AjSIwpFhhwCcBTA1BX6ZrbwoLE2EGNNjvYkcVRZYh6yk5qWNVmDHonfzIN4n7CDbWqWkGCFTwrr9mHeYH+OtwnQ0uMZV/dXL6ElJdMdQjAZW9yVGbTZUN/+oMtU36Ooh+OiYvIUozBhAFQWtjDcd0z75zpou3VKOmUllwfTqmOi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a8xeds9S148YABwdwqZntHjFQYXoHWht1q9ake5F3A=;
 b=FTHZiymgBibbSdmDh5Q9zN24VUklWyFyk6cMFiImpM6eexF5wKtbqDrtNZwg0kKShjiMejdT5D8Eh45AVQyGcv6z5k23/JQGT7dVjT/qT7LsyAp8h2Yi4Par//UT1gUYMzDtVbfTTV6xhRa356zQIPZWr/X67OBJ7B1BdkqDnG2QNB2uVsLVQ+EKuj773+blYBKf7yzojtINWtoU4u0bxfTfNode9CZ4rpUAIjayQ6ejX2wc3f9W9YFD25Qm2jdLxgl3Z0mFL271nmOWcduJ7aGeFlL+QGdeaNjG09yHvU2WLo8PAQIdBsmjj/Nz6SHCxQVh8A+Be6Gu2rrs1Iq6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a8xeds9S148YABwdwqZntHjFQYXoHWht1q9ake5F3A=;
 b=Ic6295Ezpy79vDSfDW29iek9OZXotgqrq4O9OLqQT4VIlEHa/Y/6aDG0RAGQEOt2yT8CDjHj2jNPZ7vCU7BKeHaPucE5GVu8bmRAZCNqhMEe1goQzK38CnUi5fr+5A45F8U0D4iKJ7UhvJOSGBJEpLbjJiWV2QTRQpRnqmdKt/E=
Received: from MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 04:59:50 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::c0) by MN2PR05CA0044.outlook.office365.com
 (2603:10b6:208:236::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Fri,
 7 Feb 2025 04:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Fri, 7 Feb 2025 04:59:49 +0000
Received: from [10.136.46.27] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 22:59:47 -0600
Message-ID: <c513b084-2646-4a41-972d-02c4672a2341@amd.com>
Date: Fri, 7 Feb 2025 10:29:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Emulated AMD IOMMU cleanup and fixes
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
References: <20250207045354.27329-1-sarunkod@amd.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <20250207045354.27329-1-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2615e20a-5bff-4841-f88f-08dd4734403a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3JEeFZOV2RNT1VMZ3RWTWVBdGtjOFVPM1Y1YzR6c21GOVEvd3ZGL1AwcUZh?=
 =?utf-8?B?bFY0RVNGL05RRTVoNzE0bFM4RjdUVDFENEhzb0J0S3FZS2Y5VEdvSGtsZkJ3?=
 =?utf-8?B?MUdFdUdTQXpLQjFKdWFZeEpST0d0WlJDS3RoaWkrenhMa210Zi9mOXlYMFdU?=
 =?utf-8?B?QVlsamNuMUg2SjdEMGFrNE1BeWxqd21IOENZeXNpcC96aHFqVHNqWU1helRD?=
 =?utf-8?B?YXM1OHFndFkzWXh6TnNmbWVvZDY5dFh0U0xyRFg4Z3BKcmVzRmwwMWNUbmlR?=
 =?utf-8?B?TFM2TFJYeWVOOXl4cU9ERkVsNXhwbDdnaVc5Ui9PZUVSMWtQaE56T3NQTnpp?=
 =?utf-8?B?RlVIS0Rpa2M1TElyMHlhQlBHc1lmMW9rbnhEeVBFQzZtS3RnQ0hnNnZRa1cv?=
 =?utf-8?B?YVlYZmpPQyt4anZHWUZrYmoxRkMybitRbkxEdWxONUt0cmlhdDNFNEcvWWNi?=
 =?utf-8?B?ZUtYZUFySXVFSXltYnA0Yml3Ymw4S09IVVRvRU0rc0NWRUluSDVzcnlWUDJo?=
 =?utf-8?B?UjJmS3J1Q1pUdFJISy9xTW90cHExWnpXVzFkVjFjbWFPQWNEcHY1T0N5NmVt?=
 =?utf-8?B?bi9kSHNRZ09ObzNFODE0cks3TmJHQWYvMUdTc1oydmY5MVRkYVYyTWdNVnR1?=
 =?utf-8?B?LzZxeFBxYzdwWVdBeTNWQW05cTY5MWdLb1RhYTJYWXZUMk4zUjVrR3hKbktC?=
 =?utf-8?B?VWJWZHZCekNhaGEwNDkvWVMzNTJqcXFoNVNuc1V6VWVuRFpuTDYwUk9BOFN3?=
 =?utf-8?B?ZTJCaURGc0ZKQVJzRDVtY2dwUnAxc3FnWGRlZXRWRTcrLzlqTFUydSt1MXYr?=
 =?utf-8?B?bTZxNks4b0JSVHp4RzV3OUdWdnV0Tm9wSUxLUzlKOUZ3eTdoVStyaDVQbkZ4?=
 =?utf-8?B?cm9tZHZ4NEhHRmRoOFJrVVhGTnA1dGNqOStycDBGVEo2Y0RVbnFJM09rbDRm?=
 =?utf-8?B?N1B4ZG83OFZ5clAyeUlDSGVJdEo5TTFEanY3OTBET3R2RWJWbUNJK2lXZWtn?=
 =?utf-8?B?end4cmxHT1NxWG1DbGJueGVybnBPcXNrRmxPemtwTVBIOTh2S0h6ZWFGaUk0?=
 =?utf-8?B?ZC9QSVNoVXY2cjFhbENSaFBjMDZtS0dpWEMvcUVEM2FTKzk1MHhHZmVrc25x?=
 =?utf-8?B?RjZtejVKL1BqSEtJQVh2QThDaDNSTkM2WXFTM1VtbGo1VHpsVXNtOUZMbnVK?=
 =?utf-8?B?Z0tHbzExTVJVNkdsSndGN0FjM0R5RGpYWmxJS1N6cDhPdGY2cHp0dDJjM05l?=
 =?utf-8?B?cGtkRE1ndUZOQThnOTV3L3FrSFZSTUJUaXEwd0lMZm5hZVJkZ2dBOGphYUY3?=
 =?utf-8?B?d3VzV3pKSXhiZk1pMDloNjhaUVBmWnhFV25nNHQxOWE5b0gvSUFicnVqNjZU?=
 =?utf-8?B?VmZEOFRKQ0szSXJ5TGNWZk9YVXd5Tkw0V1llOC85K1lqbkFoZjh5QVVOUmpk?=
 =?utf-8?B?MlV0UzVhYmNDcTFINjBWUlpCYUwzUjVkTzNvTGp0SVJtV0FLYTM2MmhlUFk5?=
 =?utf-8?B?c1BHSW9CeWZDUzNaMVJNTmRDZ211bjB6UWJWYXJqc1FSaEF6akE5SGozVFZk?=
 =?utf-8?B?aWRUOERoTWtKYnhQZVJxMHhsSzg3ekE1Y0xUVUlZZHBPTzZreDczaFNQdFh4?=
 =?utf-8?B?YUUvUUhNbmF6WnpweGI2S1A3WlJGejg3d05aOWh6UHc4alhvT2RTa3Y3UTRu?=
 =?utf-8?B?RlVhZVdwT0hlK0NHUHNwYldiU3pHeU4reFhSNWRSQnBIV2ptdUlpWDFacERN?=
 =?utf-8?B?QjcreGFiQklGRFR0a1VrVmNoWStIVUthdE5OSHVlK00va1JqQk9DQWh3SFhk?=
 =?utf-8?B?enloazF2WlBQZ0lNWmJ0TzhLVHFMbHR6cTd4Y3JYYUxqRGpaZFhQcDEvNnRL?=
 =?utf-8?B?b1dHb3ZFWG45N216ZEMyQVk2blNFanZZYStYRWZYTGQxclJpNUlOdEk5ZW5t?=
 =?utf-8?B?UWtFTHFuaTVKalVsL1dMbTBYVW5qaXhvdk5rVFhheUdEbHRLYjdFZnZ5d1Zj?=
 =?utf-8?Q?zQObQbcbxJFF+mIHCGgFfitpNlR+Vo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 04:59:49.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2615e20a-5bff-4841-f88f-08dd4734403a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
Received-SPF: permerror client-ip=2a01:111:f403:2418::619;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Hi all,

Accidentally added v2 tag. Please ignore it, this is version 1.

On 2/7/2025 10:23 AM, Sairaj Kodilkar wrote:
> This series provides few bug fixes for emulated AMD IOMMU. The series is based
> on top of qemu upstream master commit d922088eb4ba.
> 
> Patch 1: The code was using wrong DTE field to determine interrupt passthrough.
>           Hence replaced it with correct field according to [1].
> 
> Patch 2: Current code sets the PCI capability BAR low and high to the
>           lower and upper 16 bits of AMDVI_BASE_ADDR respectively, which is
>           wrong. Instead use 32 bit mask to set the PCI capability BAR low and
>           high.
>           The guest IOMMU driver works with current qemu code because it uses
>           base address from the IVRS table and not the one provided by
>           PCI capability.
> 
> Sairaj Kodilkar (2):
>    amd_iommu: Use correct DTE field for interrupt passthrough
>    amd_iommu: Use correct bitmask to set capability BAR
> 
>   hw/i386/amd_iommu.c | 10 +++++-----
>   hw/i386/amd_iommu.h |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 



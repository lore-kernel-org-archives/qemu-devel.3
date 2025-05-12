Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD15EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMLg-0003ls-VA; Mon, 12 May 2025 02:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEMLc-0003la-Q1
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:09:08 -0400
Received: from mail-bn8nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2418::613]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEMLZ-0007ze-02
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWMNj2DqyFWKrZris7qMgmK/I+qrKomqPIN7D+Rmi9roVNuryHHFqf77jitRrH9G8t2AAOgsd7SU7uedDjAaVYcfIgOUBkUeAloP0eBITy2NknHx1oMYv+Hd21byHPK1Ql0LqSQgUdOZoJ2qfbTXDIz0iI4JXuGCG3gPrqF76rYKo5z8ZicaMPIhpinEVaSz98fA3eE4dgPWI3aAjbx++7l+WBWtox703Q96bHIUCjmTA+GCQz9oMPGTGHgtwJ+IkcxEqkob5AeVJDkm6cEdeSke/A3CvhYtxqxWQRcfNs/ajN5g6xyfP7T8psAy7We774hdvRXzyirzTOUy0NqyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyL/e4vVx3gUGo6gOsX91JD9YfY/iscJR7ZT14LSXlw=;
 b=W6UU742T/UKdGpLmO6p71572hChxNWeZ5PG9pzvJc4eGPAB0GhRpB7YoHCP2Afrd9l+Gr78Weu6GExQ5dg6nZEKVr7s332iiu98C9iqzN8q215CGrB7SItZ/gaHNvPgzgQoiEhiSFUM8C15Pmi+j6p13W0MSx+GXjGvPHBlsRCbsPPY5ZswhTsQDFmE+HNZPt/PCkTePryGFHZ4TtM8UUivaCetXcXpqPSCtOiiKMWMiM0QDOfNvu5Y/zdYoW4hBxGOe/GLozAoKlyXaym7KDu7uJPU71V0ISvP7d82FPrVmJf6lARjqiJY+URiZOHdPfEN3aNNFe05IRLb5D5oBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyL/e4vVx3gUGo6gOsX91JD9YfY/iscJR7ZT14LSXlw=;
 b=AEPC4r8ZvvQjuLiqItHQPDlNnyVug/9nEdZ9ghOHfBoqMQW4MFfvLVO45+ay4Nb7WhFyuExsDdjH9IKJbDwqVQv0nFBCCa2Ee0PQt/LE1ObI6oqWmKwdu99mndN6N8WfpHc8GZ9Hpb7HKD5BjozzkzKFFrTSR2BTIOC8MhmnpE4=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 06:08:59 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::ec) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Mon,
 12 May 2025 06:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Mon, 12 May 2025 06:08:58 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:08:56 -0500
Message-ID: <349aa614-5275-4f27-9804-37c45506e863@amd.com>
Date: Mon, 12 May 2025 11:38:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] amd_iommu: Fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <marcel.apfelbaum@gmail.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>
References: <20250509064526.15500-1-sarunkod@amd.com>
 <20250511135031-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250511135031-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3844a580-46b5-421d-8c21-08dd911b7c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzRTQ0w0Sm1SMWVodHN1N3FKOWxuNTF6dXdnbk85OWhJYlBpV1hMZmsyQTV1?=
 =?utf-8?B?a0ZOdm9ML0Ryd1lwa2ZTTGtKaU9rZmR1Unc2amx4bWEvVnBNK2JSSjY2dzZD?=
 =?utf-8?B?YlBmVzdPcmszWHZhN1Jxazd0SzMzeE5hQk5RWVdVTldoaFg1d3dNRVRTTm41?=
 =?utf-8?B?a0x5bGRrS0xDakZNRWV3b2RkcGdHbDFSQUw1Vlp6dzFieG4rWG55UUVXcnFM?=
 =?utf-8?B?RVE4ZFplMDZZUnBrRUNLNS9xOHhKWjRHSE9iSHA5TUR6UjYxV01EWnBqMG10?=
 =?utf-8?B?RlNqTmdhbXJnUnRwS21mQXBxazJDeXhGUkp5R0daU0I2WUE3V3krUFBmOEFN?=
 =?utf-8?B?SmhlcnRWR0t2Wjk2enVPUEgrQkM1anlWNGlqVDBnemYxZ2NMZlZhanMzSFdG?=
 =?utf-8?B?cGdjUWJicEhjTmlDQml6c0U0L1gzeDViMmtlMS9oNkhmQUsyREZVZ3MwWHFU?=
 =?utf-8?B?WHNhM1dVbmVEUnNRUk1vRlkyY3JwTVVPY2NTakI1SCtYT0d4UmM5dEJ1dGl6?=
 =?utf-8?B?anZabjFESkhsS1NLUkxiV2kxTVZ4QnZYR2luNVEvZjlqYzhqeGQwSjdaS3Ey?=
 =?utf-8?B?RS90Mk52M2VadFNYRDg4cFNrYXlaMVVwTGdXVGhSN3NUQjZSRFphMlVHenZJ?=
 =?utf-8?B?NWN0cFBhT0ZtbHFXSTNlV29PYXRlYW1JbWUzNDJZVEtCcjRMR2RqVUZTR2hr?=
 =?utf-8?B?am9EdEx2d0lYVGpvN2Foa2gvZnRPU2t5WXVJNFhYajlGTDAvcmYwT20wQ29l?=
 =?utf-8?B?T1pVbmFnYzVxdEQvM1k1UnQ2Q2VhSDduSEF4aHZXVVIyczZWV3FPNVFCR0VF?=
 =?utf-8?B?VVBibVpKbEcxb0ZtU3NvQytuT0JLQ3M3OFhwTmN5TVdOdzBTZXd3V2ZhUmlZ?=
 =?utf-8?B?bldwSm9Mc1h2OW1vMnl3NitpVEt0bDlQWWlqSThyMysydFcyQ2pMdWsrbnhD?=
 =?utf-8?B?dHFLS3pZZ01sbkFjMDY0RktQemIxZUpyWXNQa3Y5aHJ5UURPbzR0T1E2T3RS?=
 =?utf-8?B?MFlRUjVTZjJNa1lkZk4vMkRaRXFPczIvdHF2Z3FLb3I5TjlBZTFQeERnVElq?=
 =?utf-8?B?YnVBL29aTCtQTmZXbmE5T1NIeTY0R1p1aTBnZVNyWHZSWlJ5aHJ4MloxYzN1?=
 =?utf-8?B?ajhYMW8zMDZxUmd3R1JuVTlmMzJmVk5KcmJ6MmpodVZjZEVVSWNZTFM4N1lr?=
 =?utf-8?B?TW1Fc3kwYVZ1Q0hZb0xlM1hzSFZwSVdZY2lMdHVkVTVUVG5FM3pBNEZ1d3E5?=
 =?utf-8?B?dWV3bzI5TG41dVpLNFNxVWRMeGQ4QTUrcXNDNW5vcEN2OXNaZmtCMUxpN1R4?=
 =?utf-8?B?b2tEVjVaMy9LY0lrbzNNVUpwWVVycUlRVVF6eGtLYjNGRlVFTmNaNXdQMEpp?=
 =?utf-8?B?dDNUU2UvWmhmck9sUkhJd0pUNTc4Z2d6NHFJcXdGTjJJWENzdXBaNVJFWHdF?=
 =?utf-8?B?WWhRRkI4emxtcGNPd0NsdktiSmhkTEx5am9xMGZKeVdBcmVCU2V3bXpDZ2t4?=
 =?utf-8?B?SDBhNCsyZFpuZExCVzhROFY1UjE2SVdnckFMWGdGRDVtU2ZsVnZyRGNIZ1BQ?=
 =?utf-8?B?dUxVSVVHQkxLU2FFUmVTOVdIdEltQS9KcUN4ODVXazRpRFZlQ1RIeDRrYzdN?=
 =?utf-8?B?RElqMklqQ2tyYjBuQUxLUFZIZDdHMFJrdXYrejN0M0p5ZTRQOFBNakcxRmJp?=
 =?utf-8?B?NThsVXJYKzk5U2dUNE9NMGllOWt0NkxDREw3d0RMbmtmOGNFTkZDNTZRblFE?=
 =?utf-8?B?ZTltUHhnZVAxT0VGNHBUcktTZVpIeFA0SU9DLzVRM1FVMlFpRzNvQzVEM0I5?=
 =?utf-8?B?ZXFPZWllbUF4b0xSZWNRamR0K0lkZFRpTlVQN3Y0Uy9wQk82KzBtMWxEcWY5?=
 =?utf-8?B?Q0JQTjZnYXNPcnNWQTV6TFBrdm5DSnpIS2NvRXFyV054QSt3TXhIV3YzTWRU?=
 =?utf-8?B?d01qT2tqUWRtenZIR3FwVTRwaE9zUUxLTzY2eS9pcm41M25kOVJIMGxaKzFo?=
 =?utf-8?B?MHNoOXJkbC9TZ2pIekk5elFQQndMZjlQYlcyVWVMMEs1bXRPQkJpRCs0bHlU?=
 =?utf-8?Q?2dcscw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:08:58.9944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3844a580-46b5-421d-8c21-08dd911b7c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
Received-SPF: permerror client-ip=2a01:111:f403:2418::613;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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



On 5/11/2025 11:22 PM, Michael S. Tsirkin wrote:
> On Fri, May 09, 2025 at 12:15:24PM +0530, Sairaj Kodilkar wrote:
>> Fix following two issues in the amd viommu
>> 1. The guest fails to setup the passthrough device when for following setup
>>     because amd iommu enables the no DMA memory region even when guest is
>>     using DMA remapping mode.
>>
>>      -device amd-iommu,intremap=on,xtsup=on,pt=on \
>>      -device vfio-pci,host=<DEVID> \
>>
>>      and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
>>
>>      which will cause failures from QEMU:
>>
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>>
>>
>> 2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because amd_iommu
>>     does not enable x2apic mode.
>>
>> base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)
>>
>> Sairaj Kodilkar (1):
>>    hw/i386/amd_iommu: Fix device setup failure when PT is on.
>>
>> Vasant Hegde (1):
>>    hw/i386/amd_iommu: Fix xtsup when vcpus < 255
>>
>>   hw/i386/amd_iommu.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> Patches themselves were not posted to list.
> Only the cover letter.

Sorry, messed up SMTP settings for git. Sent the remaining patches

> 
>> -- 
>> 2.34.1
> 



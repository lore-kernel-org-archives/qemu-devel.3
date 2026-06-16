Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A820CCD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZKX-0006Ys-Mz; Tue, 16 Jun 2026 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZZJv-0005t2-Pz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:19:39 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZZJt-0005QE-FP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwcMV2tT6+sjIU71Yrr3LHX9l7gAcJVFffIvq21bJFjOy9gpBjrG3EwE5/DNISfeGyliX0TLVUtyVy08eCF8qoo7vhxNEQF+6L4KcYfyelXRtJ+SSttqMK5cHYcluXSDiVNvhBQ0mqkDG9r0qmNMeG4SHdUihkHjlbL0LGUvhG5Oi/F0A0fqTxJYG1rwFBRsYJFqgtkN4p5P/Y09u2ZHw1PR/+1Ny182a1Hbfxn4ECpfiOzz5VMKsTpdXrYlqiW4SVy6mF5KaedUamix3x/9Dsv/S+SG/uiCfnzylSd9K9BoYyKPY8zXCiGHQ2oXk/S+4NjSFr8Ce/L2Nge+ts7djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYd3Fnlu5jtAMzjYdXx3t2M7YcfEUT3XAfcR60eJpVM=;
 b=KOAYLD5F4wKJyGmti9MO46a8TTi4skVyI9s0b+Vu3Li7kz0Ju0lQMaoVIE6hI3n0i/8vovE0lEZ0K5QogUyVu+IuhAxPTIdKvZBzQy2u3tsBbwCR5EeElPv46A7KqgfofgM3ZWRe1GJNm/roj+jHub8QYbE/UmF5xIr59H+Hvc4wfD5ppqTBcpjdYNjZDTkytuAKqoH0Jf7ADf5aH00n3FUUaDQd6MIS1ap8FHIpmCSGWT2S8606zz20+6DGEhQQYerOjQMwruD3ksBL7ZhskzC8utF3p+1so7I5uR0qtLYY06h5PBUWjawJdPNdRcobuU2AuKGVt7MJyAThDVv4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYd3Fnlu5jtAMzjYdXx3t2M7YcfEUT3XAfcR60eJpVM=;
 b=WeHHu2+E/Pi/CtS98r7NIpx9u4OxdDq7LZZWHSXjxu+6/oaBy9ILpBo/pndNP+bPThrafoECc1ap6ASBdnpbKOyyQltM3Sw+RLUjRxdOyjzaRDvBT0+6WajkjLUkk3taP/WuDXgtlkxAgZUR31gdWdaIbnLsXKxWFJmZ93LHQKdHIDi3qljs7xGOZJivV+362krzhiBNoh2ueePdEju4pNJGT3ldL5YLAyy+Cw+QtK/EbQGHfjitkSUHRdO1/mMOJTen5gRYlDYwafjPgdisKdgU0OwPGNUHbmpHKVGY9qZB3riIxHuMbXRWPtxGSB+cF9fB1kYevEveAwuRBYjCUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Tue, 16 Jun
 2026 19:19:25 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 19:19:25 +0000
Message-ID: <bc80fc18-79ba-42e3-8e5d-751a32ef00c5@nvidia.com>
Date: Tue, 16 Jun 2026 12:19:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/pci: Add ats property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-3-nathanc@nvidia.com>
 <363ad338-7ae3-4dd1-a5ed-c87d76abce52@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <363ad338-7ae3-4dd1-a5ed-c87d76abce52@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:805:f2::21) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0e95e2-764d-4afb-6bee-08decbdc2d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Iac/jusFnQkFvwYbgOOzLYJkh1fhgdPeQyOh7wH+DjeFWfP9QEveFjthsA/381TwaH+O9Ehl6jfgQIbbBjYn73/zygXwoAg8bBnYlJumg1wTiY0sgFRNk3/7GNcJ9O1oy+16/LLWKg2wE1IjHubfUQ44Bl9xt5x5dpdBcO9SKHxkD8jQRJ3rvn7d1vspDREh3rduBr7nYNqseUS6sHrApvNB+2X1lIV6wj8FQWKhaT/InyVkwfxfDihHov/zgi6fJ7983IR3N23dhEbgGVP8mrYGPM6cysKa11YkmGiWALh+gdXe3MIo9Lbm8MlKQ7LZQTfzBif0SoowMMAJYF/BibltRilGG94Vx8WPjqcaBBG6FErDb5EBkY0+3Vq5pyK0YxaROU6lm7YfscQnxKUdKVxyB1Dnv31B/dKgiu82ts7FrZokiadmcp1J6VZP5FAtvtznwqgM5ef+V9a0vibL6D9juF0zkqi+xnHCuH4tHdnPsqebK25g5yzNQZSoclj99c51pGXL3/0pMYKWZkMZ0A/bZFKIGpZX0qTs5gP3X6/0embaPcwFumekesvqRMciK76DQv74sHJN353AS5jaBmEOuSbQ46+lEqvXAiPG4PCOwuzRkey0lakTd3kt4D2rVU6sL8Zyaha8uf8OOykPLig1WynvVysL1+lc2D3MadvlkeRG3UyM+Moydn6wZx0e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVSVHdPMTFSYWhrVFNjNldneFErcmdmMFpHeHZnL2V2RzRGeFEycmtyQXo0?=
 =?utf-8?B?QUNCMFQzOFZyVHhmMm1sOVpzTUVWdkxLODhzVExKaHhPM3g5OHMzN1ZTbjA3?=
 =?utf-8?B?bElySGg2enRORmFkazB6ZDQzWVVHZUFSYWliWkVEUGVlWklsS1NoNjhWSWNh?=
 =?utf-8?B?ZjBER3BoVkdVV3REOXRZY0tzVlpTUWtlWXNMSTk1YmE5RzNxWXR1SmhCWTBM?=
 =?utf-8?B?K1VGN0x4djNtM0xIVWdJaSthd0o1cDYvUzllZ0ZlaVlVMndMcGs4SUM3TGd3?=
 =?utf-8?B?dVdDSkxvY3E3QnJwUUJnN3AzOTFSTkNZT0Z2MzJINVdFbE9wR1VKYWMyK0ht?=
 =?utf-8?B?KzFINHJXd3ZtckhDVXppKzY5VE9xdVF5bHdzK081TDF1amJJUVFLWS9TQ0FE?=
 =?utf-8?B?SmJWQldOYXVVN2l6SXV5b25CZnVFZ3dGNm1xZEtkR3RQdTBIYkFOVFNnNVhN?=
 =?utf-8?B?M0U1YUFyUmhHbW5WUTJJZXlqVzZoSDFCOWRLOWd3ZTNSR0ZONTdISkZWQUxM?=
 =?utf-8?B?Zi9LN2hXWFd3dTNVNVRhcVlVV1B3dkxjK0ZWTFRVYW5DK1FoUWtKcThRTDJV?=
 =?utf-8?B?eHdjUmFLbDUyOVFlVGRhenhEcHpPS0hqZEk1ZXI4MWhhSkRzS2RjMWVkTW9l?=
 =?utf-8?B?d1VKVForSmVhOEswS3Z3cGY1Rnk2cWZZeDROaS9jY3BQN1VaV3RKSUpYKzJK?=
 =?utf-8?B?ZmQwUFFFZzFsSmhra3hRSGhIckIvUnQ3cjhGQkoySG91VEMySWFmQStUblM1?=
 =?utf-8?B?Mm1lYjRMaEROLzFENHExZU9PMjBTLzcvVEtydDNxUzZ4MXQrTElTQittUHc3?=
 =?utf-8?B?aW42dXY1U29hQk41U3JlT1ljNXViVktRS1MzcDRkM3BCUGxjYUJ6V3FjV1F2?=
 =?utf-8?B?ZzF0eGZYeThKY1YrR1lCQXNTa3Vndm9qUGJKbk5nQUU3RStIdnBHOElLR0Va?=
 =?utf-8?B?a1kydXpiRFdwTk1sU05TQmJiYzExY3FudkNQb3pQUVdWZFptMlZOY0YrcDc5?=
 =?utf-8?B?MzdmN3FtZjJJdERCMy9GdWxGdDFLV2Z0Y3JvKzZORWROMDU4VUdZWVZyb0xv?=
 =?utf-8?B?bFZmZUsxQUx0TW0rK2RZS0tRRGdGQ3JUNVo1YnYyMGlXZHlCdGVUUEdCZ0Zt?=
 =?utf-8?B?VXBnYmtGK29ya21BU0FmQ1ExRlQ5allSSVpIVE5XaUZoN0t4Z1ZXNTdoVmow?=
 =?utf-8?B?TVhTc0F1Uys0M1RGMURCd1k3OWFveE9vR2Z5Y2tVbCtpOGtub3EzQjIrNmwy?=
 =?utf-8?B?SFpuRFhGU0xvUU9UTDFwS04yS2lWSWZOR0JWVGN3cXR1WXpBN2NqcUcrcFBx?=
 =?utf-8?B?b1BNUndMaWMwNnVEdXhFSXhDVDJUNFZJU1puKzFzSFJtTnZxekZlZUh5UTZW?=
 =?utf-8?B?OW5BRkI2ZXVLTTdtOW52MzhuVzBoUFNsV1hSVkphM2U4UVhkN09kSUxNZVhP?=
 =?utf-8?B?NTBDemNNRmlRZmZWZk10bVpFYTFpWXplVExuN1NQWnE5M2JobVcxT0tVbnBw?=
 =?utf-8?B?eDdQcTI3dU5meWNrK09qSXZMRk1wekQ3bzk5OUFUM3djaitVQ3hrMEl4VVox?=
 =?utf-8?B?U2x0c3BrMEpJMGQrcUwvcllNOXp3cWwrKzlVSk81OWR4K0ZablB4dmJPTHNq?=
 =?utf-8?B?N2grODM2UUx4SkQyZFdtRnAzd04wdHkwQUxpME1lOEhEZ2lnN0N3Qzdtd2pH?=
 =?utf-8?B?TFhPK1g5a25EdFg2YnJDekFWK2Y0aEc0cy8wZ0l0b2RoN3BHWWdBOGxhM2Q3?=
 =?utf-8?B?eVNWLzd0czNGV2JIb29HWWN5QkJrR2U1bVBTalRhZmpaZEtOWUhiY3kzMEwz?=
 =?utf-8?B?Z2hOUk40OGpPVHpmQjhLbkJDaklYalVzUTBGTXF1RFpucXRYNTdoWjczUGlW?=
 =?utf-8?B?aXZpTmZpc1JLRlRFcUk2VmwxL1NEaWgwTCthZmlLaE5HRXpwY2h5MGRTSWM4?=
 =?utf-8?B?TVdyVzU4Ukhxb3h6Snk5eWpuRDh5dnRRSnc5NnhKVVZuaGhjNGJrRHg1bUJh?=
 =?utf-8?B?c3N2c2sxMGlTWGtXcVBYa0NxVG1ZeDd2MmV3NDZvdjg0VmJ5ejNheGM1R2Ux?=
 =?utf-8?B?NTgyNTllbHZMNlB6K0JhUjlZZ3REcUxpakhFNnFhb0tId3FCUndQeG5LUnB6?=
 =?utf-8?B?NlpIaDRLb2NOazdoNVowYkFuSG12T1BWUjBzMXdraGsxQjFIbHNXNkRFRFI5?=
 =?utf-8?B?QlRsY2tBWkx3Nm8yd29YS0ZEZEE1Q1pEamg1ZkNINlJjbnE0ZTNWbmNscVEr?=
 =?utf-8?B?a0VHRnd0ZVlsMFFReTlXRDU0MTgyeGdsc2puR05YeWVUMUFNZWU0T3BJemFQ?=
 =?utf-8?B?bmJKc0QrV2dHOTRBRFNESFZEZDBzTVpJUGdBQWZlQW5lNHE4Ritadz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0e95e2-764d-4afb-6bee-08decbdc2d62
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 19:19:24.9265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgC4eiNziF0xO2pcT94PjCV8KVh3NGdNqSuQpAYOQbiLzTR6L4JQf2iduAjm3pFCfjMrlmVrFFvc+dXdywJvPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 6/16/2026 5:47 AM, Cédric Le Goater wrote:
> On 6/15/26 22:48, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>> extended capability in config space but we should not expose it (ats=off,
>> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>> the capability so the guest does not see it.
>>
>> If ATS is explicitly requested but not supported by the kernel, fail
>> device realize.
>>
>> This aligns with the kernel's per-device effective ATS reporting and 
>> allows
>> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>>
>> Introduce a new compat for the changed default for vfio-pci device ATS
>> property, from "on" to "auto".
>>
>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/vfio/pci.h     |  1 +
>>   hw/core/machine.c |  1 +
>>   hw/vfio/pci.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 73 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c3a1f53d35..f2934f2d84 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>>       bool clear_parent_atomics_on_exit;
>>       bool skip_vsc_check;
>>       uint16_t vpasid_cap_offset;
>> +    OnOffAuto ats;
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>>       VFIOPCICPR cpr;
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 4d8b15d99e..c0cdf7c9da 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>>       { "tpm-crb", "cap-chunk", "off" },
>>       { "tpm-crb", "x-allow-chunk-migration", "off" },
>> +    { "vfio-pci", "ats", "on" },
> 
> 
> This compat "ats=on" for old machine types (11.0 and below) should preserve
> the old guest-visible behavior : ATS is always advertised regardless of
> kernel capability.
> 
> Now, if the kernel is upgraded and reports 
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED,
> the VM will now fail to realize the vfio-pci device, fail to boot and the
> backward compatibility across machine types is broken ... Tough.
> 
> We could argue that the previous behavior was wrong but should be "bug"
> compatible too.
> 
> 
> So, we could  :
> 
> 1. ignore,
> 2. use a compat "ats=auto", which would hide ATS reported unsupported
>     in new kernels,
> 3. add a legacy compat "x-ats-strict=off" property to warn but not fail
>     realize, and keep ATS enabled.
> 
> In any case, we need a warning at start time.
> 
> Ideas ?
> 
I agree with Shameer on choosing option 2 to avoid the device realize 
failure. I will use a compat "ats=auto" and emit an additional warning 
indicating kernel does not support ATS when vdev->ats == ON_OFF_AUTO_AUTO>
> 
>>   };
>>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9c06b25e63..0f592ada89 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2546,7 +2546,49 @@ static bool 
>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>       return true;
>>   }
>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>> +/*
>> + * Determine whether ATS capability should be advertised for @vdev, 
>> based on
>> + * whether it was enabled on the command line and whether it is 
>> supported
>> + * according to the kernel.
>> + *
>> + * Store whether ATS capability should be advertised in @ats_needed.
>> + *
>> + * Returns false only when ats=on is explicitly requested but the kernel
>> + * reports it is not supported. Returns true in all other cases.
>> + */
>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>> +                                                 bool *ats_needed, 
>> Error **errp)
>> +{
>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>> +    HostIOMMUDeviceClass *hiodc;
>> +    bool ats_supported;
>> +    *ats_needed = false;
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>> +        return true;
>> +    }
>> +
>> +    *ats_needed = true;
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>> +    if (!hiodc || !hiodc->support_ats) {
>> +        return true;
>> +    }
>> +
>> +    ats_supported = hiodc->support_ats(hiod);
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>> +        error_setg(errp, "vfio-pci: ATS requested but not supported 
>> by kernel");
>> +        *ats_needed = false;
>> +        return false;
>> +    }
>> +
>> +    *ats_needed = ats_supported;
>> +    return true;
>> +}
>> +
>> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> @@ -2635,7 +2677,18 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>            */
>>           case PCI_EXT_CAP_ID_PASID:
>>               pasid_cap_added = true;
>> -            /* fallthrough */
>> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            break;
>> +        case PCI_EXT_CAP_ID_ATS:
>> +            /*
>> +             * If ATS is requested and supported according to the 
>> kernel, add
>> +             * the ATS capability. If not supported according to the 
>> kernel or
>> +             * disabled on the qemu command line, omit the ATS cap.
>> +             */
>> +            if (ats_needed) {
>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            }
>> +            break;
>>           default:
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>           }
>> @@ -2657,6 +2710,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>> +    bool ats_needed = false;
>>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>>           !pdev->config[PCI_CAPABILITY_LIST]) {
>> @@ -2667,7 +2721,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice 
>> *vdev, Error **errp)
>>           return false;
>>       }
>> -    vfio_add_ext_cap(vdev);
>> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, 
>> errp)) {
>> +        return false;
>> +    }
>> +
>> +    vfio_add_ext_cap(vdev, ats_needed);
>>       return true;
>>   }
>> @@ -3815,6 +3873,7 @@ static const Property vfio_pci_properties[] = {
>>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, 
>> skip_vsc_check, true),
>>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>>                          vpasid_cap_offset, 0),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, 
>> ON_OFF_AUTO_AUTO),
>>   };
>>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>> @@ -3973,6 +4032,15 @@ static void vfio_pci_class_init(ObjectClass 
>> *klass, const void *data)
>>                                             "a vIOMMU. A value of 0 
>> (default) places the capability at the "
>>                                             "end of the extended 
>> configuration space. The offset must be "
>>                                             "4-byte aligned and within 
>> the PCIe extended configuration space");
>> +   object_class_property_set_description(klass, /* 11.1 */
>> +                                          "ats",
>> +                                          "Control guest visibility 
>> of the ATS PCIe extended capability. "
>> +                                          "Valid values are on, off, 
>> and auto (default). "
>> +                                          "'off' always masks ATS. "
>> +                                          "'on' requires ATS support 
>> for the device and fails realize if the "
>> +                                          "host kernel reports ATS as 
>> unavailable for this device. "
>> +                                          "'auto' masks ATS only when 
>> the host kernel reports "
>> +                                          "ATS as unavailable");
> 
> if you resend, could you please fix the alignment of the two
> object_class_property_set_description block() above.

Yes, I'll fix this in the next refresh.

Thanks,
Nathan


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2DFC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 08:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJEa-0002vN-0b; Mon, 28 Jul 2025 04:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ugJD3-00023H-Lm
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:27:56 -0400
Received: from mail-bn7nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ugJD1-0002GC-6X
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:27:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBq68BnAe+rTT3PLuvQvEQAeRoIg25/5i9LfNUhczRgDvzPKfh0qwoMn0IhzdF8vY50gfdGfbJNEXFwEDhf7qchupl80wciSZwVwIggC2cvN1551HXFKhcQ7FaEvoxrrMyPOSCAmZDFThmSgxKaub45xdCj/MhHPml3PdkJg5bG9LagaFPutXebTOlB2mD5yj36ZmrIA60AYllsaMeBrKQpnlQYyb5ZsWCbTNx2Ht6tOMBjT76DgXTyGRjIQMPeUuPlt+rTg6vJeUPchDvG5Gxhq/nVu96uYtdUL56SioEHTn7I4ikBvis6J7ZR+/liQhywnq+hHKHfS2t49pWe+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmDQ47Gh5gEfTJ3txitReZoZrLIc0eJkweBtLwm4MmY=;
 b=RPHZuWyi1drHFE8EhvpbWA/R0CUO9qh5NqMeFQ1OcTVFV+DaubDmiGsLud8pi/jqNVAIVXbKsVYlOd2F49jBEXaliZzzYBwGV59DYOzCCkWd00ZeMtkOOLVAqZYhtSr494Go07wusp+XfgwiSV105ArInOA3J3LnxOOilyeNK7jkzXsT5/YWYjoRreo5mecMXxLkyew1ql3Yi2MUuoPzb4uSAo28UXCeBdeFWXmdVlBfmNGJCnnOnGlP7OJJ3LOASOaPvPbnmv+eCGh6CrGr9aVbjjxbZCXZykCanStR5RHTD/fDnxXuLWF7zp0SQRNyXvTDTgRCb/eG0LDzRcOl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmDQ47Gh5gEfTJ3txitReZoZrLIc0eJkweBtLwm4MmY=;
 b=NCvJgkrEdI/gluh3f3dnRXF3N9s7l9Ror08iqiqEucdNEE0sHSW7Ja9ClyCaxLsxMiXhxmoW/opYQCFI7ENi6vzdJxjfXcgOeQkWFxKShxKwdYiM50yjiKqc3OgUsoMvvUzu+7oQXPklKGBsp6Z0bPAj2kTmAD4f2IYMUw9QidQ=
Received: from DM6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:40::19) by
 BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:27:39 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::79) by DM6PR03CA0006.outlook.office365.com
 (2603:10b6:5:40::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 08:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 08:27:38 +0000
Received: from [10.85.34.242] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 03:27:35 -0500
Message-ID: <2e8f2b72-8fb5-474f-9844-61f306efeb2b@amd.com>
Date: Mon, 28 Jul 2025 13:57:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/i386/amd_iommu: Support MMIO writes to the
 status register
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
 <20250724064745.4091-6-sarunkod@amd.com>
 <c6891bd3-eee9-425a-a785-f503284145af@linaro.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <c6891bd3-eee9-425a-a785-f503284145af@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 719ac060-2106-4159-d2f4-08ddcdb09cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW85YlkyWVQzdnNEc2RxUUlaejBucDBXMDlmQTJzdGs5TS9qYWtlYUtkSisx?=
 =?utf-8?B?NDZOOWM0VU0zV1l5SWFZaFZLQXNnckFzN3lTWDM2L0IwdHdVYmhUb2JnVUY2?=
 =?utf-8?B?eWFwYlpEVlFoM2dhS3lsYTdGVVF0WkVVZGhWMTg3YStSK2UwRTRHQmIzSUdp?=
 =?utf-8?B?Q2Zjeng5K1NQOTR2T3BLcm91Ky82NWhHOVV4RkdzRlZhOWh0RVRPdXJSWUhp?=
 =?utf-8?B?UHhheHpuZkNzVmEwaDJFcjgzSWdJdjV5dENSeFlHMXdnaHNqa3FPTVdDaTRI?=
 =?utf-8?B?VnkxRnY5eXRmS2MxVERxYUZmVFhNTFczY0JwUVBKbWlwUDVvMjR6RkdhaWpR?=
 =?utf-8?B?NG1meDZNU2MvMFZwZE5yd2VJM3hMVm83VzEzYjVIYXA0Y0JHd2VBSlJzd3dM?=
 =?utf-8?B?N2UrUUtHTzJ1dzl1K1ZYOE1hektuS0JnVWlCTTJURUJLVjFUaEg5OW42YUtx?=
 =?utf-8?B?bWsvaUxTYkR6R1lWQVV3SVpIcDBXZUNvMGxaRjQzdUs3L0pTeE9QRnRzYXZi?=
 =?utf-8?B?S1JwbVNuelJTSTBiMlVSc1JkSGZCZTl5QmFFWFAzNG1IdzIrVHZFV05IamNR?=
 =?utf-8?B?QzVSVlZPQVRnN0haMVE2WmJlaG5uUGFvS2xmRGVWU0FVN1RBaGowNGpNWWFo?=
 =?utf-8?B?N0p1T0piM2VNcmtlTVEycllpYVcvdXdSYjk2NVhSSDlIeko3TGttakQxV251?=
 =?utf-8?B?RUxONjRLaGU2bWt6aU1xeCtUMjhOWDc4UENIMGJJeG9PMVFnaTlBUU9yMDF5?=
 =?utf-8?B?QXNQTU9kT2JkaStoSmE2VU5Hdy9GQnhCcGY4K2RJdkdSa2pYYkNxOWcwWWFV?=
 =?utf-8?B?ais2cTFLM2lOQlk3anBsdmRaNnBYTzhQQ0htZFZCUkcwbW40Tm9IZHBWWnIr?=
 =?utf-8?B?emsyS0JwUzdORUxkRkpvZUl0M2dwYUFaTStEazllRG93MjM3N1Y5em5IUTQw?=
 =?utf-8?B?Q3NBclBFWFl0L2gxcnhOZm82UXNpQS8rQjRYbmRaRlhUSlp0QUhtZHBXUTFL?=
 =?utf-8?B?QXJmZHpacUNzcFVYUlJUdEpxZTN3VzZpaENNYUpDUEx5c2NFWURQNWlmT1VK?=
 =?utf-8?B?bkNGL2FSUVVodGk5UFNTR2dGZ1lkWklQdXliaVZuT0Y5bkZhRW5kWmxXMUll?=
 =?utf-8?B?R2lOeVRBdGJ2V3VCOWwxd2xqeUhiVktLK1NSYUdFQVh4YiszcTl1SWx6NGJY?=
 =?utf-8?B?VS9tYVF2ME1ObkZpN2laRktCS1RQeklKeXR4dDYyRE41WjNadkw1UTJRaTh0?=
 =?utf-8?B?SW9XRGZWeU5KOG1mT0FsVXRFSWMwZGJPbWQzS2tUclZPSnEyUFJDQTN5WVZm?=
 =?utf-8?B?NnNxWmJXenFQdVhWWjQrL2lzWnVBOUpWM3ZMTjZtVjB4bFJYZFo1QUQ0K3pt?=
 =?utf-8?B?czdKUHZUSHdLSU5kU0ZiWEszZTQ0REtITGhHaFI5dnpxN3Y4VmJDZmU0TkV1?=
 =?utf-8?B?cWZHU1RMVnE4VGova2hNNThkZHNQRzcrL20xMm94emo4QlNGUVZxOUJVQ2ZJ?=
 =?utf-8?B?N2p6dTl6UjQyenhoNzZyQVIrYkhWNm1qdkpqdEtOSGUza29QWW1OcG1uT09S?=
 =?utf-8?B?b2dUWFBnU1pJSitNNjBoSzl5M1BIaW5nWHVrblMrUkZnMHNYamtLbEtrMm9z?=
 =?utf-8?B?djA0WnFUL0RnNE1IQ2JYRTU3Y2VnVC9tU1dVMjhPa2FuYmNSVkRxYmxNbWto?=
 =?utf-8?B?Ny9yS1lteTF5S3haS3VUQUxTdW5mZjhiQTM4R3F2YlpTSVlFQzFTdVVzUU5t?=
 =?utf-8?B?MUphZ2xnMVVXZDBOM0srUzFaOXR1RWJtQSswM2lpRS9ma3ZHZXpEUzhoVUpU?=
 =?utf-8?B?dU5DUUVaTCtQV1NySGM5NnNPZEcyVHlmblQ4QXZHM0VDRWU3RUM5OEViTGF4?=
 =?utf-8?B?TWNlMzRQVTg3QkZkUU9jd3FIS3dDaTZvSVZCY1VpZFdKNnVNQlFSSmg2NlBQ?=
 =?utf-8?B?SDFOSVNJelZuSlFQL3ZDZElEZ1dGa01sWlVDbHVOVDZ2SEpuZ3ZvN1lPMmYx?=
 =?utf-8?B?VGJTc25iWk5YbFBaNVFSVTdWVVhkb1cvMnFmZVd2SXNRMUNJWEhxcmdvUXBI?=
 =?utf-8?Q?MM9MWh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:27:38.2107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ac060-2106-4159-d2f4-08ddcdb09cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
Received-SPF: permerror client-ip=2a01:111:f403:2009::60c;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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



On 7/24/2025 2:22 PM, Philippe Mathieu-Daudé wrote:
> On 24/7/25 08:47, Sairaj Kodilkar wrote:
>> Support the writes to the status register so that guest can reset the
>> EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
>> respective interrupt.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index bbffd07b4e48..7c2fa80d14ff 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -850,6 +850,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr 
>> addr, uint64_t val,
>>           amdvi_mmio_reg_write(s, size, val, addr);
>>           amdvi_handle_pprtail_write(s);
>>           break;
>> +    case AMDVI_MMIO_STATUS:
>> +        amdvi_mmio_reg_write(s, size, val, addr);
>> +        break;
> 
> Should we add:
> 
>          default:
>              g_assert_not_reached();

I am against adding a failure here. Because when xtsup=on, linux tries
to write all the XT registers ( which we dont support yet, because of
which event logging does not work in this mode). Although future cleanup
patches will add this support, I dont want to break things now.

I think amdvi_mmio_trace_write() is sufficient for debugging purpose,
which prints "UNHANDLED" for unsupported registers.

Thanks
Sairaj

> 
> to catch unimplemented cases?
> 
>>       }
>>   }
> 



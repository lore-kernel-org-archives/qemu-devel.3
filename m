Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D68CCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcKW-0006Jn-OE; Thu, 14 May 2026 16:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNcKU-0006JS-QM; Thu, 14 May 2026 16:06:46 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNcKS-0007KS-9v; Thu, 14 May 2026 16:06:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEOd2MnbWDeRGTj7lcvSv+mvcFN7jQ+M+l4rnuy5KW+C+4dV3O7tuuOGMAcojgkLJENYb2xeSLqVr/ZVX7mdGPVRX1rIbsXVad42HDGAxKVaXpTpObLy6vKYscb5FCDVwhHjBv6j3CJO61xkUlGUSJR6iFrWXEZIL9ZrF0sOeVMFFRgNf56c8dsSzifeV/pKM3+c5mmTh64NwLA+N1dckXgkiu7rxYPwKItU0c6SykTETbiBdzzPuu3Fd3niWYQ5fDXIX8JA5f9xZHXsy2Yn4NU1q3a/djoX3xALF7l3q4tgP8bssRpk8CjuDRGwvLZ5ehJLXK3pge+qzvtT1eBc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wh8hOK/QAeDibAVcNvfYbhZr1C38GGKQpdhVFe8IKU=;
 b=yOQVpOsSpi2uB8ZmDTiDvdbVfiDKpDSeOqkKld3LIVoonqsl/W9wVwYozWV94I0O5LV8jmI/7GLQSXRZxQwuHzAqDuUPFECeLPUgjOovtSNwzrG4GjMrXyoQcRaoVE9LkfGH++m3ZJNhAnW5CAGLW4+h3F7uGVEpNaFl1suK251pIjXY0wdhg8kmMrwTHojtAummmgfhx956u5xv0N7cRHSi/jZmkl8gsJweq/+wJNMUlxbwxd51OH09c/O4FFqGT0A1BjCwDP5irfDiDJOdlggFEfk53homkMhv4NPxAEJLBCcg9wALFSSbbDH8ledf4xRrT7w8TfidH/xVe/+NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wh8hOK/QAeDibAVcNvfYbhZr1C38GGKQpdhVFe8IKU=;
 b=XMtA4n9BpUXDFsXO23tto5m8mNMZBW29loFk/CA0TlND1cNF4/xl/0KJqqlVwrKIM8iYIrBdI9CD7Lzv3tdcfvk7HUwKGN+hZYsoiV4+sBqWtDrZzedpxbtfhRrntVB65t24EPF5HPi8MYyMF1qvdGTuH+rBQM2RaVywKUNUg3a4VeTVv9L+OCtJhWt+h8ZwneFsjdNxIdfhB+IWjuP/S8VW08/2ijy/QYHqvY4hLOpi4mPqCUxIv9r1OV4ZTP6/CZeaXAuCDRDI5Hs2IJi2ufYpInHTVqgLNvilhMa15oT2yerL41uJDW3y5ae6TJswf6Cgax3UpFu+UetalgDk6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 20:06:34 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 20:06:34 +0000
Message-ID: <cb3f2ace-be0d-4b5a-ad3e-9de541a2444a@nvidia.com>
Date: Thu, 14 May 2026 13:06:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-3-nathanc@nvidia.com>
 <CH3PR12MB75488C9306659D939ACEE203AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB75488C9306659D939ACEE203AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: f93cb746-afa8-41f5-8e1c-08deb1f44c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|4143699003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: ytyQ1RU3m2eSBzgHOSx9dLmtZ+3dPcxXWfutHJxh3+UaYQjnztsBHdqr5iS400kIEFAsBclAVI2DZeKGC9EOxdCTABcyH9Yp8MiCz5xlcQ3npOVQXr/IPzd/Y/a+VJet4FKRaVk/vYZdSwTPuO2EOIt0KY6n2Lz6+MPZDiEbr5jRbvmF3qanfXtmugk2hoSZokPIK+EGK0Frc2AK/oI+k5nD2TrN8a9Vu8vfxYGKobsMici6nwq4S7ZqUCcgAR+f153k99ZzMzQDJXljf+civKo6BqcLto3zEKtG4wHOnW2gkgsT3qWV5M8mxU9JW7V4J2r96FR2VN9eoHfE1TCsiA9cKlj0G/CPAcTnUVziQvjQ/2tqjgwZzgjeZdHPr5pH8K44Os+Q//mZ1hXnLz6tlJtM1oNO9pBhGKrMiJoAofEcwb/5cR22nCXT3RHkIP+5Ne4BbqIgfQHsGgaFaBbIFKIgIvSMOJWwyeoeq4Bf1dAYng4sSA8a0AJo4X7ufdxEPmv+3zIgou1e5RiuU1bpGwQ+sfKAGjV3mNQMTdKDJCHjyNGm3rB8fdb7jExssQf8+44vWh9+mCNh2oqN0p+UXRwu9Z/n+OpRi09xYplZM+/06D7hggiPxTmcziGLetewzlvfAekPoLmT746dEi8mVxdN5CdYFJKWhLQ72qUlYAnRfeU9TZ2Z57iZUluWnDdN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZoVmh3S0Y1dmlLOEZUVVN4ME44bG1TS0xpUWM0MytsK3JCK1NLSm54TXU4?=
 =?utf-8?B?RTBBdDRYNWJTODV2eTBJWkpVdkNUVlN2VVJIRklYdW1XUEVqUHRqSVZvbmFu?=
 =?utf-8?B?dmZSeTZpcktpbjhZNzBUSjltWmRDc0p6OTdraVRQNjdqN3lpYml5S202QXJ2?=
 =?utf-8?B?YllyQWtMN2hIN0JTZThocUUvSW5ySjd3czNJS0pDdkI4clFnRlRmbDdVbmxx?=
 =?utf-8?B?WUU1dDVoTzJ4ejkvQTgwOEtpRlhsd2U4UldQSk9YOHdMS3JkMVVVK1VaRWFZ?=
 =?utf-8?B?MFJEK1Z2am12TW5DYUJnWHhLSEkyRk9nejN0cUxTU0t5VEdha2t4RDNnSnpu?=
 =?utf-8?B?cDZFMDdnNkZKWHdESC9rd3JVRG4xQUgvN0tIY0dpRHN6OHBQa2tIWTRHak01?=
 =?utf-8?B?Mzk0ZDlzYUJrdzEzeDhDNmUyMnhRQXh4V1dIT3hJbWpFVXJGSDhpMmRhQ3A4?=
 =?utf-8?B?bytNaUtvNmUvOVAyNXMxVjJQcFFhNk5JS01rQkVmYjFGZmIvbjQreVBOdHZ0?=
 =?utf-8?B?RXZFeG40ZGpLckw1bW85S0FPS05pcld1dXlUWnRPait4a2RXMW0rUkh6cGRK?=
 =?utf-8?B?ak5WMnIyLzhBQlhrbGM5UkdQejZYS2M3akJvYmNXZlpBQlY2dVE0WUVsQjVI?=
 =?utf-8?B?V3Y3dmIxRFU1RUYyVnFLWk1GZ2FrRklIQnptRmx3MU9BazZ1S3RxQW1UUmZB?=
 =?utf-8?B?MGtsdUdQQlRSRlN2L2pjakZIM29LemJCZzZ5Sm8wZVRVVklYL3V5d09aS2xJ?=
 =?utf-8?B?MncwUDJBWUVVV3Q3eHVVRmQ0emtPdFZLaWJMNk5pSmpaMXFqRW9PemRocHVJ?=
 =?utf-8?B?bkNHVitabnhLL3E1Nko3aG01L1FEc2wyU21vQ2FQRjdRaXhjT2FHNytlS0lx?=
 =?utf-8?B?UmJ0alU0MWFyWU1icTFyc0pFdHhTb0lBK3FmV0EvbGFPY3V0V205YThmVHMv?=
 =?utf-8?B?dDJLc0xVWHVJTWh0bGUzU01VTTRkVSt3STZWVHJRVHhYdUowaVpDQmJMSjlz?=
 =?utf-8?B?TU5DbllDck1VbzhsNUUyYkVWZWx2N3d1V0ZTaGxYcFlrdFVkWVEydk5rSTls?=
 =?utf-8?B?QXJtMElOVlROaThUaEpna0IweFAzUVV3dmQrWVNsUVYxMXR0dUU3aDhiS3hk?=
 =?utf-8?B?M3V4UUl5Vmd5QmpIeGNwcjhuS1ZKS3kxN2tjY1M0ckZwczd0d1pzUHVmU1ZL?=
 =?utf-8?B?ZndmOE9ucWEwOElvUVU5VXZsNURyZk0zd3ZmUU1UendGMkhuczZkQU9qa2Va?=
 =?utf-8?B?TlAvajZrNHZGSitXTDRoWGh1QnZ3bjZjcS92R1g4OUtBTlJCSFVyNkJVU3ZT?=
 =?utf-8?B?QkhhL3hVb3pVT21mSWwzUnhDRzgxKzBBcnpKTy9aVFFJUngwNlJpQVFodGdQ?=
 =?utf-8?B?a3UzSWZWZ2w3c2tzd3VXcll0MjIwOW5tazdOdi83QmV5TDVWYVJxMU5DSFNC?=
 =?utf-8?B?Z3ZJbGZuNFRPYjNGelZDbUpmdldJTDJyQVl4d3V1Z2UrSjZBZGppRS9seEc2?=
 =?utf-8?B?OVJrOTVXTmFBK3JUWW5iekdoTExpV3hmaTdvdXNEMkoydzkwNW5FeXp5L2Z0?=
 =?utf-8?B?V0NMcmhKdzFjNDNLN2FDOFgvVWRIOWYyYUhMVnRNUGdNSlhLWVI5aXFOQ2l0?=
 =?utf-8?B?YWt5ZnRGME9FbDR4K3J0L0lUbUFVblJMdzVzNllYTk50Q3FKaFRKZUxuNDB6?=
 =?utf-8?B?d21kZXJTMDJiTnowdTI0MGlqcXhBMlZIN25kUzdOUVlqUjIvbEVFaEcyYkhS?=
 =?utf-8?B?WkI4cXhlemNzREJRajNONFMzeXF0Uit0SXZ1TzFSdWhmTEtRaU9LVU1aTzBZ?=
 =?utf-8?B?Nk5LcllNbWc3b2c1LzdYcTErbkNLZFQ4cUxEb3d0M0NwaW5nWDZVRlI1YW1R?=
 =?utf-8?B?bEdhWUx4aGMvSWVGRWxaNGNjN0htdjM0dk1NekxBYXlqejhnZzhQZHR4TUpL?=
 =?utf-8?B?SW5NVmxVMEJsaXN4dGl1dVRXRmswVVJDdTlJdytaL2J5RjhkNnpIbkoxck9N?=
 =?utf-8?B?ZU05Z1paY0ZhMjhmU3FJdjVSS1B5elZZVS8vSzNOeElOVVU1RDkzYk9PTlVB?=
 =?utf-8?B?QUlyWXgvZ2ttOFpvT3p1Z1hoY05Yc01ydmxURFdMWWtZd2FDSDNmSDNXT0Ey?=
 =?utf-8?B?WWx5d1A4NGd6anVWVDdlR01ZM2NybTJsN1o3dWFFQ0krOGM0RDliTVdwMWdu?=
 =?utf-8?B?UUVVeHR6ZGlDYy90MVZ3WlhBUTNyTWRobm1FcnBIUW1WN3hCb1B2eEVxNmZy?=
 =?utf-8?B?R0FYaGF6d2RqUzc5dkJYMnlHakxoVGtVeUJnb3ZvdlQyYUZpTXAzZXpXa05O?=
 =?utf-8?B?WGJ0cXpyWnU5QURoVTBGL01URWNYV0dzMjJrVkhSNVV2djF4Z1hpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93cb746-afa8-41f5-8e1c-08deb1f44c48
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 20:06:34.5171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItrPmAyzmx/2eIO61AS2NWfWScSOFviWJcvqFUA3cnEq0byXWdSTiXxUFCzltnDQcNp2STIF4Ec3z9Z6CNDNNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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



On 5/14/2026 7:11 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 May 2026 20:35
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Philippe Mathieu-Daudé<philmd@linaro.org>;
>> Zhao Liu<zhao1.liu@intel.com>; Matt Ochs<mochs@nvidia.com>; Nicolin
>> Chen<nicolinc@nvidia.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
>> "ats"
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Address Translation Services support property
>> to be derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>
>> Reviewed-by: Eric Auger<eric.auger@redhat.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c |  9 +++++++++
>>   hw/arm/smmuv3.c       | 11 ++++-------
>>   2 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 82c0800f4d..9fbd13c438 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -52,6 +52,11 @@ static void
>> smmuv3_accel_auto_finalise(SMMUv3State *s,
>>           return;
>>       }
>>
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>
>> @@ -964,6 +969,10 @@ bool smmuv3_accel_init(SMMUv3State *s, Error
>> **errp)
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>>
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->s_accel->auto_mode = true;
>> +    }
>> +
>>       if (s->s_accel->auto_mode) {
>>           s->machine_done.notify = smmuv3_machine_done;
>>           qemu_add_machine_init_done_notifier(&s->machine_done);
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 5c2855c377..e558f09652 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj,
>> ResetType type)
>>
>>   static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>   {
>> -    if (s->ats == ON_OFF_AUTO_AUTO) {
>> -        error_setg(errp, "ats auto mode is not supported");
>> -        return false;
>> -    }
>>       if (s->ril == ON_OFF_AUTO_AUTO) {
>>           error_setg(errp, "ril auto mode is not supported");
>>           return false;
>> @@ -2170,9 +2166,10 @@ static void smmuv3_class_init(ObjectClass *klass,
>> const void *data)
>>           "Disable range invalidation support (for accel=on). ril=auto "
>>           "is not supported.");
>>       object_class_property_set_description(klass, "ats",
>> -        "Enable/disable ATS support (for accel=on). Please ensure host "
>> -        "platform has ATS support before enabling this. ats=auto is not "
>> -        "supported.");
>> +        "Enable/disable ATS support (for accel=on). "
>> +        "Valid values are on, off, and auto. Defaults to off. "
>> +        "Please ensure host platform supports ATS before setting it "
>> +        "to on.");
>>       object_class_property_set_description(klass, "oas",
>>           "Specify Output Address Size (for accel=on). Supported values "
>>           "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
> In smmuv3.c we have;
> 
> case SMMU_CMD_ATC_INV:
>          {
>              SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
> 
>              if (!sdev || !s->ats) {
>                  trace_smmuv3_unhandled_cmd(type);
>                  break;
>              }
> 
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
>              break;
>          }
> 
> The above !s->ats will be true for AUTO case, right? I think
> we should change the above check with smmuv3_ats_enabled().
> 
> Also, since we modified the ats to OnOffAuto in the previous
> series, I am not sure the above should be a fix patch or not.
I see, I will use smmuv3_ats_enabled() here to account for the AUTO 
case. I am not sure if it should have the Fixes tag either but let's see 
if we can get any guidance on that point.

Thanks,
Nathan


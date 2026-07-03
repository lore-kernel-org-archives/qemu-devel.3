Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10556C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZ20-000810-KP; Fri, 03 Jul 2026 04:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfZ1z-00080l-Dg
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:13:51 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfZ1x-0005Ub-Q6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqSXqSRVkr5L7yaidi8VfHt/SbhLU545CTjr/wmuEVkxg+kU4shLId+HQr53Sg72HXEXy1j/YnvMa/Laddw8Ljh0KPivgPzFsjPm8C2LHH/ze6a4AqaX2Mssvsz8yYHEDu7ir9hFJxtrLJ5y0w53GsSrmkO0Z0jX/nVQdkTtTVrVvzNyKg8Vaq8NCQ77SP7Gye08H6mCstl91swanvbzY9W/0tDLEbJFbQyE8/54jxFbktTudQJowgIvvQC1ZcpROm0sFCOTIw+dqS6pfn5IzWIXVvTTMscg12x5+rPvbr82Ib2LCoqgTLq09vt1fEG3TNVsHz4gwgVXNHTSS7Wf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EISBPc3oJJlZJCMyDkSp9Uin3qDxsYqbuXGHdY349Hw=;
 b=enFBoQjr1F9x/ZzIq0nLLYMHYV+S0Zhkdr3CA0hW3SPHqWqQKHUameiC+DJ2EmXMNczvVRbQiBHpPGpaMLfieX7IXzG7hDfZW9TBR3XynPQnHCcJCxEWdLzmc8Iw1St5bzrE+CxicavHbIC/U3LpFF4T7Y2Ga8w4AxVrjSf4clyoLWxlYWugMQmX7kj5TZ8Zj4PDQJUsTnsZ0ALifAQ5NnpR60Y5gj4Rrr4Xs7P8ozzcBmBe9JsRwy4hycjSq5L1gkPiZuU8r8YlXsYH4sNb1Ol94bie+ecad2TZXDTjVVrJKtr5MnljvBwaeAvFV8Aej78WoFaJWcCxw/lvz2MDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EISBPc3oJJlZJCMyDkSp9Uin3qDxsYqbuXGHdY349Hw=;
 b=LW+fodzu2XJ9OztT7I2jjIRbO60rON8r1MZGIszkG8Q5TxpbWAaRaA4wE6PcL4imTlXxNHHNv4Xe2FqK7OD7AgxtfmQXJfDCpdP9qrvYqyj9EsbmUvFz39PwH43RDI6xkQ9uj00H9OQNC2QGf9pxWc+zu5H1QHJKDTgFrALpR18rUTyamL3hghogKVIsyGVCvlXREMxE/j0AaONubi1JSjCQTA/whoVzU8zn1RbTX+WD7x8wIMFYZdHqRtw87nthThdMH35fAn49QZhs3hS5050YWVf2Xlzq8sHcqGUu2AIOhyNaAVG2T2YMwstH4hC3ZEixdVCSTDzKkO5YjzDJbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:13:41 +0000
Received: from DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56]) by DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 08:13:41 +0000
Message-ID: <30a8d3d6-bfdb-49fc-b891-ab09c0a3a692@nvidia.com>
Date: Fri, 3 Jul 2026 11:13:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/23] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-18-clg@redhat.com>
 <28c14e21-9382-4d4b-bde0-622d4dca9bf9@oss.qualcomm.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <28c14e21-9382-4d4b-bde0-622d4dca9bf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b06f89-5b0d-4cee-3539-08ded8dafe1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QUB26iWeinE59PZKYQvZ6rVKnGBMBA+NDbxMBZj4vg9dmsrt8fgN4poG0zW8jLjkHyEpAhzTVUVGfcp+DFB9JGmsz4DykWeM+Of303rzlZHQETIo743QGpzn2NEMDF3WsIHZQkMMzfTmE2EEvh4IXWJxNo3H8H7Tt8I4jM2hzZHI0+OEME7DuIQNVZAR6Dn9RVN2ea8GDY3Ct7CxHAeYsd9Eafqu1LJpSeqZMAFE8PuWwdZLYpRmZ0Xz27+oLAbun7DikkgLmbFyVVYqnw2/HL0kgkZvGiriwEx+hXElP+nXD9lin8PqK7R7qZxmlZH6wHZnEocf6zNz+jNDP1YV5LC7uN8JkJLGCQJ5rvfbfLtBX0IKQu7IuvHIEPUAu4vjAW1TkAynfjUg/O+gZrCJ+eQYH77lkUDbFO8LZ/EJguqIm8AHVA3b1aXWUCrpz9lt7Ko//j2/MOTPyaiKGkGYH2VEYSH6WD3FCKwOvMc7Nm/9kGu2fyU8FhmZJ31VxO4u01csxKywfXtQBQLTltCnYkjxXyk9KAZz83PESFOZywrOXWoyMtXJr6KEe73+YxNm/Rc714UB721NOTHTqbg8hNEcUCE/EmE9t0dj8yp3uCAasrarRmCGB5zGNGULcIXbq/KTgjwyxi8Y0i3nEhDqc1X2x2+RHjdRPWbsZctosxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdhc3Q2QVpJdUtvaFpFUkczWktlb1g5ODc2MzNMU1dBYks3NkxQM0VnZVQx?=
 =?utf-8?B?Tms4VFhVUVNQQk94OVp1VXlxSTZVQ1V2K2JvMjZhOVh2WWZXczUvZjhjWkNl?=
 =?utf-8?B?ZTR4S3g4ajdiMmwxbXFHMXlJa1BjOVRXRE1HRExhaXNMU3I0ck5NWG5vNVAv?=
 =?utf-8?B?VW1xNmlwRWpuNWhHOENtdDg2YWFqWGUvbjlROURVbDQyODRLaUZMNDZNMUh3?=
 =?utf-8?B?TGRLVUVtR2I5L2VRdzQ1bjQzdkVIZ3lmVHA1dUNkV1M0cVZ0N1RSOVlDbXdv?=
 =?utf-8?B?blZoL2dQS3lnUm8yRTdKL055WnB0bGdTNFpwSXVoY3JpWC9XWFM5V1FlOVFO?=
 =?utf-8?B?b0dMblEvTkorRnVHN2RUcEhtRlVLWU45elZyOG10YUNDdHE0cFR5aGgrRytl?=
 =?utf-8?B?VTM0Q1BldlVXbGhFdkx0Wm5zcXVGaGNEbUpab2tYaUkzajArejJWSVdlK3FY?=
 =?utf-8?B?dUJKblgxRWs5bVQyVmVuaXhxQm5kVUlXYVBUL0pJUzBtN2Fmek9tMFhWNTBN?=
 =?utf-8?B?L2JwbmkrOW9jN0ZQZlhhVXZEOUEwdGx6alNSZ2tBS3k1Q3ZNcGVVYnMxRE5T?=
 =?utf-8?B?YlNlbEI3bGZlK1E2VEZzOW0xQ29xK2hzR1ZwQnh4WUEyODJmUDVmSkVvTjly?=
 =?utf-8?B?NlB3KzdCR0RtMm5vdGpsUk1Lbi8yTENvclFKYU81UitKaVpIZ3FMZU1zMWpo?=
 =?utf-8?B?eW5sOHhxbGZtRFYzY05yMVFTdlJaejVyUnFraGFrUWxqeDBPamN6VnZsVGN0?=
 =?utf-8?B?U2dJQzNIZU9BMVNSNW9qS0VFOE5CQUZsUTdhMkNlWGRnZ3hDdjZPdzdPcUJU?=
 =?utf-8?B?TmRBL3lDbkRQOE5XUmpJUyt4aUtMY0UvbGVoeUI1NEowSUZkMHRwaFJyeVF0?=
 =?utf-8?B?VVpqMFVCbk84NkorTUUvaWQ2bk5xOHRjU2FjeGVpOElOUzNHRnlXK29JSTRC?=
 =?utf-8?B?MENWQXpZVlBXbWxMTENzZ0tac29UektHUENvTVZPMTI1V2xnOE52Tlh3WXJa?=
 =?utf-8?B?TkF4TSt0TGJRUFhtOWRLdmY2ZnVMVmd1eG42R0ZSYzNqdzRlelVIditmSjQ2?=
 =?utf-8?B?T016dFZuRW1Nc2xhTm53a29XRTROZWZYYThEQTEvakVqS1BjKzcrSDBub2Vq?=
 =?utf-8?B?TDlTVUYyUmZYeFZyeEZ5d04yY1JteU5OVVdxRmdtRVNpaTMzclV2bUE1WEVF?=
 =?utf-8?B?bVV3WnkvWnZBYkVoNHFWbUF1bHN1MTQ3bytNdDI3UlFOSUVGUGxldW9wRFZj?=
 =?utf-8?B?QXJuMEUzcXhGa1RPVnBBQitwdzA2YUhNTDVWd285dGtPRGppL0VIRkxsaW9U?=
 =?utf-8?B?bHMvNk1RaWxFa3FOcmp2bzBSVms1OXorSmFpeXFRRExQZVBKN1c1ZzBHZW01?=
 =?utf-8?B?dUh3SnFPN1htZDZHd0w5WHpneU5SK1czY0M1WUF1Z0RLSnJZTGtFekRrK1N2?=
 =?utf-8?B?WXZpTEJwcUV6Q0JJTzJ4bVNXVWZVYmZ4QmFyck9UWEVkMEI4M0ZQcisvdWZx?=
 =?utf-8?B?SDBVNHRUQkpPRUhHcHJBcDk3anZuNFROT1hNMDNCZmE4QUsyblFJU3hjeEZT?=
 =?utf-8?B?SHp3TnFERW1COElZR0FaOW9TSDlocUJXbzVpSmZDV0ZqNDNKVUlZMDI3bjho?=
 =?utf-8?B?U2pxM0hvdTdEWkZib25uanpRVm1RV051QzdqY1hYZEo0UGVuYUZLWkVqdlJv?=
 =?utf-8?B?a04zUGlGMFJXejh5VzZFYkE1Wis2NEo4aDcyZXQwS1JadWg2SysxeW4wZFNM?=
 =?utf-8?B?djJvODdRcnAySkg1aEVJVW5MWGRLVWFpZ0libzdyNUcxb1NqSnd0aXdoZVlK?=
 =?utf-8?B?L28wQ21QSHFVOWtvZENhNitZdncvV0hodkZCUVhVaUd4T296OFhPNWpEWERJ?=
 =?utf-8?B?ZWZDbHRFWXlkZXNMVlgzSjRRaXBuYlJZb2dsajl1djRWb1VORkpISlpSd3Q1?=
 =?utf-8?B?RjdUSEdlZWgxRTBYWm1JMWdWZmtvOVNVUHZWWklLRFUrYy9McGlXdk44cFlr?=
 =?utf-8?B?amdqK01GZnlmMWlXSDlJUG0vY3VzR1FYd3A5UlZaMTFMQTlHM2E1QkIyaTM1?=
 =?utf-8?B?RGZtRWRhUG9LVDZsUEpWclJ6VllSZHNBdlUvb0J2ODhUcTJBVWdtTWw4LzB6?=
 =?utf-8?B?Y0U3SVR0bERxVXVLYzVRYzkvbE5vT0dkUXhra0Y4ZHlubEluNVNBZmNIQTZI?=
 =?utf-8?B?bXVCcUFROHRYcDZDTnBjZFFmRUFGYzNSOVFKdkZBQ0U5QktuTTdUZmpHK1d0?=
 =?utf-8?B?SkluYzZ4TldnYmxoNk83Ukg5Z1Rnb05IeklnK1JlMmJaZjRqMmdLRktyTHBY?=
 =?utf-8?B?dDRLeWN3UVJkb2dzK3BYdVhZMUpsbXNVaGJTZWZNMUNxUm5NbXNNdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b06f89-5b0d-4cee-3539-08ded8dafe1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:13:41.3393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQP6KajCclttzBX4bJCPLamxIXLZQ5v5v/VarSRi0fkOpOup9MSxPl5t9U6oMJ6Bgv3YXZ7K/TbBPlBuQs+9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=avihaih@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 7/3/2026 5:07 AM, Philippe Mathieu-Daudé wrote:
> External email: Use caution opening links or attachments
>
>
> On 30/6/26 06:31, CÃ©dric Le Goater wrote:
>> From: Avihai Horon <avihaih@nvidia.com>
>>
>> According to VFIO uAPI, precopy initial_bytes is considered as critical
>> data that should be transferred and loaded prior to moving to STOP_COPY
>> state to ensure precopy phase would be effective.
>>
>> As currently defined, initial_bytes can only decrease as it's being read
>> from the data fd. However, there are cases where a new chunk of
>> initial_bytes should be transferred during precopy.
>>
>> The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
>> reporting a new value for initial_bytes regardless of any previously
>> reported values.
>>
>> Implement VFIO_PRECOPY_INFO_REINIT feature:
>> 1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
>>     VFIO_PRECOPY_INFO_REINIT available.
>> 2. Request a new switchover ACK if initial_bytes increases post of a
>>     previous switchover ACK. This ensures the device is not moved to
>>     STOP_COPY before initial_bytes has reached zero again.
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Link: 
>> https://lore.kernel.org/qemu-devel/20260622101214.25770-13-avihaih@nvidia.com
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   docs/devel/migration/vfio.rst     | 14 +++++++
>>   hw/vfio/vfio-migration-internal.h |  1 +
>>   hw/vfio/migration.c               | 68 ++++++++++++++++++++++++++++---
>>   hw/vfio/trace-events              |  4 +-
>>   4 files changed, 80 insertions(+), 7 deletions(-)
>
>
>> +/* Returns 1 on success, 0 if not supported and negative errno on 
>> failure */
>> +static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
>> +{
>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>> +                              sizeof(uint64_t))] = {};
>
> What is the point of using uint64_t[] here?

Since there is no data payload in this case, it's mainly for consistency 
with other VFIO_DEVICE_FEATURE ioctl call sites.

Thanks.

>
>> +    struct vfio_device_feature *feature = (struct 
>> vfio_device_feature *)buf;
>> +
>> +    feature->argsz = sizeof(buf);
>> +    feature->flags =
>> +        VFIO_DEVICE_FEATURE_SET | 
>> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
>> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>> +        if (errno == ENOTTY) {
>> +            return 0;
>> +        }
>> +
>> +        return -errno;
>> +    }
>> +
>> +    return 1;
>> +}
>


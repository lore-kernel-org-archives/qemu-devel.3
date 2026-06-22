Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EF7CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbYPJ-0006il-Rb; Mon, 22 Jun 2026 02:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbYPH-0006hs-8D
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:45:19 -0400
Received: from mail-westus3azon11010055.outbound.protection.outlook.com
 ([52.101.201.55] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbYPF-0007Ab-GO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:45:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vG1ISLA3QJL/ttEt1XqpFr6wPvgSsott7RP6Pkunt4f4dvh3/UCP0IqiC+0OvugRDoDSzxTmKgMFtsLD6PRQ3ph0b77CGCYuH0GO+cSe7A4GUDrps1AKwhlucRH9FuPOcKV0jZUXCT6CDGyNFS207Mz5llyh/uUndSGVtLo91pjknFT4nH7cErpch6uc/bzpehu3y4ik1f3ieF5H6qgEIL/NU/fR8PN3ltD/qGvIuKHXrvKekR3ixig0C9EDHyZ/+0gjb0GpvDFI2Tybk48vdNCUkWlLCrrrabF903xJjYCYJ5K62QMJiJstOREjKhukRT/pXzy0ZWaK5tgGgFj8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6pjHcyNMbcexbag3yP9/Zs+vFbXp93ZIqh92/3tMjQ=;
 b=aMc1NaNUc+hT5Kdtqd5qS68BbC1dCSafV/n3Ow+WqsvjWMMutS1L7ZWPjBSgH6aodzmVp5G5BBW90P7u2OGaLEs8V6ykDam8JnYNHs17yEdKsxfF8BzPeuYO2x7FYVD7JpihXsLsYgCsnxJf48/5pguU1sMDUoDwaIgSM38Q+eqAcmmEEhd3EgOTfR7NiUvLdBPMn6Uli7gbuZoXQuNsyBJ3HIO5aryo7Um2WgvfYa8bxMitCGrQQT9/ZI01sGcZUrTmeqZS0noM4qwo+1yM2v5PUqWO7MPYzYzKXYSkwxbiCTRbpJzEp5Wd9vz6KjYeaMch1D6CAYspbq05A1ctMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6pjHcyNMbcexbag3yP9/Zs+vFbXp93ZIqh92/3tMjQ=;
 b=E03AWyQlcsZGVn4KHwJDA/toxppq0gjt+inQ7X4aEflBCO7rtSSVNqBBkkl383do5x9bNcKTig2t9mLtnJAulWd5jRA1FfiACVvqbT73m7zCp/mS2Xa/4vLOWmkynwjFdtVXKDnPUWL3aHOESLtdGdTt/fNUQMpOvcF3a/siNSTfyYxLvnXzd6CaU8m7cATGQeGtXmsmBa5Dhv1ERw4bOtDic05kAqlLoF8Lq/2F51f8riosDdkPpkXNNbXoGM9bvPe6XHUsomVW0LOPewfd91Wz+Q5z7wj+y79ZI7x4q13KILHlAUvPyG3OfaeNTwogUilLOP5rHVvi2ge1WXH5yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:40:09 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:40:09 +0000
Message-ID: <62aad5f0-eab9-4c93-b521-4a112ac8867b@nvidia.com>
Date: Mon, 22 Jun 2026 09:39:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] migration: Make switchover-ack re-usable
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-8-avihaih@nvidia.com> <aiww8tN6dRLA3t_R@x1.local>
 <e4d00894-990b-44b3-b89c-7cd1b0398a0a@nvidia.com> <ai__gjsVcZs_ecLc@x1.local>
 <9605d542-f797-4ac4-bb62-966a77ffd361@nvidia.com>
 <61fefad6-af44-42db-8913-14bd274b4833@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <61fefad6-af44-42db-8913-14bd274b4833@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: f98f3b25-55ca-44b0-8fd8-08ded0291a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tW9htJY5knDE8SqeqVu4jPDeQIIv+VTM+fnWS7KtJvmkrJXuyTRU+iR9b6J9m4aXBLyvWk9yxdFsXseVoHDp3VhCOQfnPSpC2L3Q/CjlyGiv1zLdYkHVsQCRikpmqEBcYRPDeYMbkUGR1XpO18LAG09vBr4BJX/+G6pw1dzMhyWrfQrBLYg/XBh3gHqLlu8f7N3dNwQXfjuazc2XUM2K6VBu3GYWwGjaJ2Yk+XO8+BBSnNtHgWqW5dusI6SUYa02hZPnFsXvjqvWb57u8+HoBAIkKOF0uH7lqkSvG3ytKQhPmMvuy3FKYpnrFg/2+qF2quXiOk1A1+Ncj6X7JECFHzMMxDbdBqEhLycNfotSOmWOZ5YamFTfl0ryS7VIix2CkHsuycrNZ2L3gW5bcORxY3E/oD41MQvh4ES1TDUQfZRy/i/WRkdmioHpkIJqxRlUtENnM7IpQIYvObq4hwoIXDXaNcfqpnp9cPDXcO578j1lWJmscUJyFpaSs/a+ujK0up56tNOFH4fy1LDMoX8GGFffSoZlB5DdhPk4bxdaeGubuf4wjHS1tp6mSGUNVdzrNlpiNmkwhzX0bMJT1xttJtbrEoYXWqgPKmLoHvgpqJs3Fb6Nxm+pLnPTJcgjIQGTlAuj7HWovNUx4TYJ9bmihe7hWuBoUQXk7Zo0teGhPGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlCSmZDNFdCMy9pc29yRW9EbnpSTXVoaE5OMEgybXVxM2VrblJabFVOMXhS?=
 =?utf-8?B?TUR0R0RGdVRld0dqZEwreXhaOTM5WG10VW5yMzlYSDBxVmFmVFhoYUR2MGV6?=
 =?utf-8?B?Wjd4OFVQSU5Cak0yVVpBU1B0RTBuK091RjFMSm9BenNFcHAxblh4NHA3cXBo?=
 =?utf-8?B?MElmaFFOa3IyRGt0eVl3eEZTSGd2dUtZWW1jcnFRQkw4YzBMQkFoNGk4V1Uz?=
 =?utf-8?B?bktrbCtoblVyYlg0SE50ODNLWFdGeVU4Ymg1WmxUUDBwanRJNTdIZmN0WjBT?=
 =?utf-8?B?aUVHYmFucE40QTNnUGpaK0pIOHVTOUFDa292TGsyR1VidUcwOGE0NHFWc1FG?=
 =?utf-8?B?eDV3VHkrQUJTZFBKVWZhMXRXdk9ranZSTm1XVWlLdEZXM3Ewb3Evb1E1NFM4?=
 =?utf-8?B?Z3V6VERUbXRNL0hsdXRJaG9VczJXbWNVd0t0NEswOGx5clRMTDl3bFU5Ym5i?=
 =?utf-8?B?VGNUYUdWVDZvNmdHeHhnQ1FFOVZTOUhvSHJEZnN2elRXcmZNOUUxbm9BQkRH?=
 =?utf-8?B?K2dJSHdpNDJaYlNOWksxaGdNYUoyMXZLd3VaNmVwWDRFK0hoYS9kN1NnQndp?=
 =?utf-8?B?SlNCOEVYMFUzY3JTVmhxTDhudlFUMzh2NWtMdWlzQS8yaXdTTW9XdmYvS1hQ?=
 =?utf-8?B?c2NlYlNVWUpuVmZzaWUrMVNVeDhwb0VXdU5NZnhJbkRoTUV6bEhsaGcvRFIy?=
 =?utf-8?B?OFVlMnF6UTRXUlh2aVk4NDJZZnJZNDIyWUdTdzkzcHdLMzBEeTVyazZ4WU9Q?=
 =?utf-8?B?cHBONzhQcjJLS3FkWVp0U1FmeERKWDZSbjQzSTE1eDcyNG9qZW9lUERHckh1?=
 =?utf-8?B?TFFLc0ZYb1hzVk5md1lScjdBcUZhbmovcEZFM3ZRcHdRVVJRMHh4NkIxbW53?=
 =?utf-8?B?K0QxNkVCazdvTjlkRjdJVysrT3U0SDE3Ylk2R01LckV0TVFKUVhabUkyNUQ3?=
 =?utf-8?B?ZzJ1Qit3UzllR2lvejF4NmJJUWhCTmFDcUFYYWFKUWltM1gycFZJb0c4cVhX?=
 =?utf-8?B?MmJKOEUydWY1cGxyWXBlWFEyTnBUZS9TbW42d2o0b0pUN0ZKWlNtOStueVFK?=
 =?utf-8?B?cCsrTnhDUzdSc0dOSXNqWjE5MmxaMzMyM0xJb2dUVlRZSjBLL2czeXJ3QitH?=
 =?utf-8?B?Qm1DRWVXalQ0c2xTQVZOVXZsS3RhYmZtRDBTTXpXQmtpOGl2MSszRmVFQUJO?=
 =?utf-8?B?TTR5aUdhRUJXMXJmYVFKOXhyS1VZVU9LK0t1c1EvcFQ3Uks1WEJMSDNFditS?=
 =?utf-8?B?S0UzNmlqNms1dExlcHhaVkFQNkpsZzhsTnhXdTNEdys0R2NaaDRMb2xKUXZF?=
 =?utf-8?B?QUdMbXVTL08xUWQvTmlIc0hvZDc0RTBrR0ttOUY3Wk0wZ0RNUjI4VndyL1VK?=
 =?utf-8?B?RFByQUxhb2w1d3NYUjBHNEsvQlFUa1diblUrN0dCVHlEeDFHajlsbE93R2Mv?=
 =?utf-8?B?dVVvYUxnRTU3eUJ2Y0hlTkdJaG0ySFBLM204UFBVcXAxRVF3R2VueldBM3Fu?=
 =?utf-8?B?N2VYUWJaYnR5RVlDMWplUjRSa1dudzZ6eGRXYi8yY1ZKdXJ0RWtPbTBCTjBD?=
 =?utf-8?B?VXNkUmI1UDZGZDdnckluRGl1MGxrb2JRSnZ1cmZyZ2VTOVlta0pxcW90VHBM?=
 =?utf-8?B?OWFpbzNKR21pNEpzdDR6ZFUwZWxGTDh1b1l2d25zaEFlcWJBem1vSEY4MW5L?=
 =?utf-8?B?a1d4eS82QXZCUGpjSzI2Z08vMmhndGlKek9aUEJCcTZRWEpXU015TVEvL1Nx?=
 =?utf-8?B?Qm1KcCtEbUt1U09KUytDMzdLVmZKU1dIVzZBaTdveEtibks3U1ZxbWQ4QUdX?=
 =?utf-8?B?bEY2L0tJSXozSGswb2N1SVlWYUJ4RlZVYlplejA4M3NxYWVaclhXY3NhYlZN?=
 =?utf-8?B?aVNmbVlUN3F6UWt4am5kS1dNMkF1YzlING9FZWY3UHVQZSs3bSsxUkY0bnpm?=
 =?utf-8?B?eTJUb3Z1dUhNdG1tRXFXbytXOStJVWxRbnVSRFcrY3h0aWhMN1NZYVpSS3Fs?=
 =?utf-8?B?bzJBL3F1QmIzVmJpTk9aVk40U2MvUlFUUTFvRDFSVWVERnY4TUEwczk2YXlk?=
 =?utf-8?B?cG5mdjlZN3Q3U1MybzFpRUhZMlo5N0ZHZ3R1RE4wZ0tNWnI0S3RzK1Y1SmVz?=
 =?utf-8?B?VmRuNGoyTGVSd2FBbzBManlQemZVVm1sUVFBLzJtWDBWcnZ5SGttY3lYclFa?=
 =?utf-8?B?MFV5QmdKejVCNmpOOFdKZ2pvY1FlT2o5Y1IvYVUzbFJPZXVXd0FCdmh0VTRr?=
 =?utf-8?B?M01SaWk1bEFFVkxSSlRuZXZmOGpaVWh1L25hQlBEd09KMS9EN0l4R0c5M21q?=
 =?utf-8?B?SWl5d3pJbUdoQXcwWUFMOGNGMWRUTDZvanNYTHFNU2VzZHk4eUNhQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98f3b25-55ca-44b0-8fd8-08ded0291a71
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:40:09.1121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0SGHPLORm+GXN29eNRpaS83hSkoowpNEWDAvPtO2gwERJywt9rwyTIctnebz751e3EepvXXlgUfmyCanIfkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
Received-SPF: permerror client-ip=52.101.201.55;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/18/2026 11:38 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>> index 4d8b15d99e..8219f13779 100644
>>>>>> --- a/hw/core/machine.c
>>>>>> +++ b/hw/core/machine.c
>>>>>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>>>>>        { "chardev-vc", "encoding", "cp437" },
>>>>>>        { "tpm-crb", "cap-chunk", "off" },
>>>>>>        { "tpm-crb", "x-allow-chunk-migration", "off" },
>>>>>> +    { "migration", "switchover-ack-legacy", "on" },
>>>>>>    };
>>>>> This line needs to be moved to the last patch, or people will get 
>>>>> very
>>>>> confused on last patch flipping default without caring about old 
>>>>> behavior..
>>>> This patch Implements the compatibility flows for legacy 
>>>> switchover-ack
>>>> which use this property, so moving this line to last patch sounds 
>>>> even more
>>>> confusing IMHO.
>>> My comment only applies to this one line to change hw_compat_11_0[], 
>>> not
>>> the property itself.  It won't affect this patch.  It's common 
>>> pattern to
>>> do this in one patch to "update default value, but let's keep the old
>>> machines unaffected".
>>>
>>> Btw, since this value still has a default value ON in this patch, 
>>> moving
>>> this line to the last patch won't change anything except making last 
>>> patch
>>> clearer.
>>
>> Alright, I'll move it to last patch.
>>
>> Cedric, would you like me to send v4 for this?
>
> Yes please.
>
> I think this series is ready for merge. So I have asked our QE
> to test it a bit. Should be done next week. Once done, I will
> send a vfio MR.

Thanks, Cedric. I will send v4 shortly.



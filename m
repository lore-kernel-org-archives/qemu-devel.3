Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89795CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLL9c-00073m-Kr; Fri, 08 May 2026 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLL9a-000734-PK
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:22:06 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLL9Y-0001Tn-Ti
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbjWnO7FFeI1xvgcq26j4PYx/d/k01TAKJOeislmJ+kdA48snFkf+t5s6F95ocdCEWsBKkTCh4l1PxORtYdnp8/6tVU9fE5DXQAdIUjpWXrE2ZLP90WTlDP7Xw6D1i0992jDIMAFYnhYjjvWVHRsvFl7eem6CYoA+KNfGhqQ8rjAdmKRbKyPlYMaJNRkLwjLj100y8LGKTXEHrMP9OHBEAZ18J0qpvzQo4Yj4IX4eZXgw2ycrjwN8rNsQMTeZ6vompTo0453xlgg32F5NQCOEgXpKKyZPo+z5Kw6RkDsEe+carPomzmy/iNlPrObpElsAhbUcDGeZbfR/343ijHeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+7Hvh5WoqWh7WV+PG78J9j7O9Bq2SyhfVrdTD7c6LM=;
 b=MQBcw9hZMsQzDDepizhSQ0jVkVNHUmMXiR/d0OXwrWtxKr6XIgeFXA7DdOy+HVbwlibF4WPoJgqPDBwz6G0OJ7oljiAMiKm1xqgSL5YGH+gbRkfl8xIhuuA9L4R+2gSdHJhUYiF9RewGvFRjLJwHgz7g6dPSTkcHoRHbb7boyD+QIMq8VSlH4cpE6i0OUH7RIfK/nAJRxHGsq9GKcWVqhiWg3X3Zggfo/czUYpFr3v+DjElS9xBwkDtwO/a34WxTrK2d1eu7LJAEUT0CVicxgqzAjgKF47HP14zlKSpFlY2lPsrQizMESXksU77E2jDLFJFyu36zFz1hiiQSFXltYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+7Hvh5WoqWh7WV+PG78J9j7O9Bq2SyhfVrdTD7c6LM=;
 b=Oh7lRdUBq+qN86vYUoyyVnuQKDBv3o6OqO2PIGl+9PUMvMM3a3vQHmmq3Il++aqzJaXCkEG5yv8+1OZluyw8lXsHYoN5h3wJp1gG4Y68lMcadYmx5o4ULsxZmK8QRPPAdDK8pX78ZDEdQu3VOa1gxfC1NVtsU3Io6SWJe4LqXeTqQxbt4Yv/Uw67ylR49nuC+bosg9omNdp9ADGEWHjb4y+PX49q0DL3CD5RsmhfYBhM/qQRUfrQ1ku2PqrZ9WrNCK/a9A0XEAMpsSiNu9DDudzzvemPubUfaICUgfI22XEA+Zuz3e3aGVngDdzSz/fgnoe1xEmkPvMJMli31v1giA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 13:21:53 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Fri, 8 May 2026
 13:21:52 +0000
Message-ID: <63236bb4-bfcb-4f80-b034-3baefad0e58b@nvidia.com>
Date: Fri, 8 May 2026 16:21:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
From: Avihai Horon <avihaih@nvidia.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-11-avihaih@nvidia.com>
 <7653a2e9-b747-4c29-a5db-d231130e383a@redhat.com>
 <d3ca15b3-899d-43e9-b754-e48fc6e89923@nvidia.com>
Content-Language: en-US
In-Reply-To: <d3ca15b3-899d-43e9-b754-e48fc6e89923@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dbb0a7-8584-4a3e-095d-08dead04c4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pousCWxFhiykjpAP0t+cLDe58canw3waZSRraUCgwq3zlnw3aqCbs4T2cYnVJ8XrLc5y/d1CDl62zmK2tJWPOtEbefzxhpX37KVEm4H73W2PxQ4KNAR2sellTN3Z1cMX8l7qbY4omKk/wntu2/WtK+6k4oTynmxKhwVVYxI8Y+lUZGKSbFI+U5LR+CE4oycwj8ESyylYzimadE47GtTmeQEfMt5WoC8CuKtt9GWKW/+xMk19px4V1nMFyDeqVLrwuk6Pc42u8RQLZQRCUlkJDM53YAabx7c3BaoBbDS0ytJ+pYNSPOkv9zMydCP6RjZeG9lq1boLDmCwd+vPEdre0bzhcYFJ4XlFpgcGS6e2m6ntBvCmvTiC0A2nwVAViklGhxF85BNC/1AqpWDK089rur1PVVqcuCl9n1sWesq28hQPlNRivzlJRl1OpZ7C7vHY9hqOOU05DClaGiJb04EmvMHrD58ZGZE2JcGvGUw92qEc4DzUO4SW27H31xDTrhwYUFaVnjJwn1kYYYNJNM+kxFGuoa/m1lE3COdR9FTtoyP+PR9PbUnKCVLn5kNNhTdMWGLTsH9XKT7yupYRdfJHsdlgxZBE1rRDUcQg4jV+awZD5ZHZlXZBA2zXaOYDeB+rXe9GAMyeKsSg5ndBWcnOBUPDaPWV6hFjv90bl/BUNCUv/9eXO9v4LGDuRSIdojYu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZiVUdVSkE1OFFBOXZkT1JWNEFUdlI3NFU4VmhoSDNTQU0zTEI4MlozbXRP?=
 =?utf-8?B?UVZVWVFHQS9Zb3Yzcmxab1prYWU3U1ZkcjdPN3hrczVCUVI2djJsUWRiNFVM?=
 =?utf-8?B?T3VYcittS2E2TzAzYTIySGV1ZElXK3c4dEdYZVUrSXVTdmsvOFFyMGhweEFz?=
 =?utf-8?B?U0dBL2pwYjRWYk5rOEEwRCtlMDNYckhJYVh0dGw1eGN3OXZ2SVVSMUFVOE5S?=
 =?utf-8?B?andORlJIRkJYaEFlL2dBcFgxVDVjYy96UU10aEJvbnRPYUliVXRSNDh2cUlQ?=
 =?utf-8?B?SkpsdEtvZjQ3RERSYXZRdTVuZmMyZGs4QVc2THhZUll4TGJmaDE5b0ZseG51?=
 =?utf-8?B?T3k0L2l5QXoyNklHcXJOdjZZYzNBMFF2UnhqZFE5VnpFRmc5WVpnZWIzdnVY?=
 =?utf-8?B?M1B1eFJZdWV3ZUN5eVNmVE5RTWVhbzFtVkp0cVRYUExMaDk0ZVZmczhldXJK?=
 =?utf-8?B?WGd2UGJ4RHJXTXpRU25POGNNdlAwcFBuZ1c5cy9WOHR2dzl4ZEU0cC9JMldP?=
 =?utf-8?B?dk1lTmVsTmpESWwrMllBNC9jY096dmFGWnhSR3FXWVREQ2JrM3hjS1lrelVz?=
 =?utf-8?B?T1hIR1NqVTJsVVc0RGRuQjFFSWtIV21zZ1plN0ZHd1lORE52ZHA1eFZDTWdi?=
 =?utf-8?B?b05KeDQ0S0VtYVlTV2ZGRnloVEErVWZzaUh3cWlFNW10Y2NOMmw2M2JoTHZO?=
 =?utf-8?B?alNFTkFRTGc0Yjh1ZlBpdERSRzNHTkVDM3ZNL1VzbmtYK01neEIwaG1Cb0RS?=
 =?utf-8?B?b0lnZzZVTVlNWVlyT1pBU2VBMXhhWEdoNDVtZ1Q4TlcybS9aRHZMSGR2eTVi?=
 =?utf-8?B?OXdxa0lGQ2dDWDB2ZVI1dzY5aTFGRGFzbVBNODRYMmZsSjBVMldBVW5kMHUz?=
 =?utf-8?B?SlhPdXVCdHdPNlZpVDBvSXJmSUVVdGtzcng0U1JsUHZOVWdZU1I5R083UlRB?=
 =?utf-8?B?MjdnM2xTVCttdFMwMnowRmk1eGwzK284dkRZeUFKM0k5OHU3QVdIVWN5Vjh5?=
 =?utf-8?B?UUI3S01kM3dBQUlNdGczVEFBMkw4QUp1Mzd5SGhwSHYxSjdkYWdhL3QxYzJO?=
 =?utf-8?B?a0d1d2U2T1M4UDN6MjgyTW9YV2REcEpmQ2h4SUE0OWZvbWdBazZJdnZqZjRO?=
 =?utf-8?B?RjJiaER4UVgvL1FGcVNsS28vWkNlYnhoRkQxYlVudGU1b0UyTThBV0NzZ1Vp?=
 =?utf-8?B?amRTU1pva1FjZzlzeW9NL2x0WlZnZEhRL3E4dzdacGlwWlZNcWE4Mm1wZjl2?=
 =?utf-8?B?ZUpNajBRR09ZcUlKaCtxOUNqeldnOXQ3UTBBUWFZMC84ZUNJMXBib1NnUTJv?=
 =?utf-8?B?c3hEUnd0WXdTWWtwVytFaElEYWZIc2NhZVpFOEloR2Y4MlRmb25kUXRzM1Bi?=
 =?utf-8?B?cFlUZzNsUkUreHNXTmtnOTUzQnFQNXpnOHdxa2cvME5VOFRSOFhpUXliY2Mr?=
 =?utf-8?B?bGxJNlFSc203Zm1LWENBYk5tQW1uT0x1ZWtGRjFpSmswVVFDd3I5NmZrd1l1?=
 =?utf-8?B?ZDFTSEp6eXQ0M014MzdiVzZlS0FnQjZ3Z2RBMVl4N1FMVjZkTWJQSFZmcDdz?=
 =?utf-8?B?eEFGRWVESkpSNjhXam84WVByeFRUNGt5T05rL2JCeXNiRi9XZ2RvQlFuMkV0?=
 =?utf-8?B?SitxQm9YSlQ2bGdGVUZmMjJzODl2R1JHTlBkTzV0cWFVbDdPd3VlMEE1My9X?=
 =?utf-8?B?VmtCV1hqRkJvYmxyKzI0VjNuTjJRTDYrc05Qam1YbVBXRXM1QzAralVCQW0x?=
 =?utf-8?B?eU9lKzFFTm1pYUNjaTYxR1paV0FPM2dmeFIwMDhKVDFGUUpYc2NOajBKU3E0?=
 =?utf-8?B?T0twRmpvQjFKU1NIaEdMc2JSYUNGZUZabWlxQi80SS9FL1hXeFNzWFVnekUr?=
 =?utf-8?B?bUZ4bmNTaERzQ2xEa2NvbmUzTHY2eS83Y292SzNSYy92QXZNL1FKa3d4bnB0?=
 =?utf-8?B?eDZ1cldKbUQ2Z1RYK1liaG9pMEdhRDZDc0Ryb2xHK1RHQ1o1SnE4ZmxYdUtq?=
 =?utf-8?B?WTkvQVRxUUFMRExMdktwcWdGdmJUMlBjUit2NXFqMlNHSExPZHdCb1lidnpY?=
 =?utf-8?B?WFoxaXNXZ0tPMWVsTGxWZkdhK3ZQemJYWU9KS2lhK1ZUb2YvdkZra1JoVUE0?=
 =?utf-8?B?cEptVmdpcXRmSkhRa1o3WkhscWx2ZUo4RGtyU0hSL1ZUbFNaTldvNlFlQmx3?=
 =?utf-8?B?d3lYZTNwU1hzbXJ2QkZqdlpKOXFlV2ZOMVRyK1VpdER5OGQ1YWFsc3dtRWgv?=
 =?utf-8?B?SWxxTStVZFlTMXpJSXhtam0yWlY5NStiSkp5R3piRjZBTUx2aGozTXJveGhr?=
 =?utf-8?B?WlY5MlFPYlN4RDRvU0hIQnJ4RWhIL0QrVVNtWGpSQlZ2TWVBdHB5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dbb0a7-8584-4a3e-095d-08dead04c4d0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:21:52.8458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPa30d0oQLrPuiiFKBORYyo8UNgYfXv9vV9f2uLBbsmR/J2NFwp4vyYneHmwTTqhe/S7h6ZcRf/JXv/kfYz4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=avihaih@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/8/2026 4:18 PM, Avihai Horon wrote:
>
> On 5/7/2026 10:59 AM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Avihai,
>>
>> On 5/5/26 10:14, Avihai Horon wrote:
>>> vfio_migration_init() already has many failure points and a new one 
>>> will
>>> be added in next patch.
>>>
>>> Add Error ** parameter to vfio_migration_init() to report a detailed
>>> error message through it.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   hw/vfio/migration.c | 29 +++++++++++++++++------------
>>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 243624b5fe..b7e929274a 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -1038,7 +1038,7 @@ static bool 
>>> vfio_dma_logging_supported(VFIODevice *vbasedev)
>>>       return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>>>   }
>>>
>>> -static int vfio_migration_init(VFIODevice *vbasedev)
>>> +static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
>>>   {
>>>       int ret;
>>>       Object *obj;
>>> @@ -1047,23 +1047,38 @@ static int vfio_migration_init(VFIODevice 
>>> *vbasedev)
>>>       g_autofree char *path = NULL, *oid = NULL;
>>>       uint64_t mig_flags = 0;
>>>       VMChangeStateHandler *prepare_cb;
>>> +    g_autofree char *error_prefix =
>>> +        g_strdup_printf("%s: VFIO migration init failed:", 
>>> vbasedev->name);
>>
>> We have error_prepend() for this purpose.
>
> Right.
> I was trying to avoid duplicating the prefix on each fail branch.
>
> Do you suggest to add a common "err:" goto label at the bottom and put 
> there a single:
>
>   error_prepend(errp, "%s: VFIO migration init failed:", vbasedev->name);
>
> ?

Or alternatively, put it in vfio_migration_realize():

     ret = vfio_migration_init(vbasedev, &err);
     if (ret) {
         error_prepend(err, "%s: VFIO migration init failed:", 
vbasedev->name);
         return !vfio_block_migration(vbasedev, err, errp);
     }

?

>
>
> Thanks.
>
>>
>>
>>>
>>>       if (!vbasedev->ops->vfio_get_object) {
>>> +        error_setg(errp, "%s no vfio_get_object handler", 
>>> error_prefix);
>>>           return -EINVAL;
>>>       }
>>>
>>>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>>>       if (!obj) {
>>> +        error_setg(errp, "%s failed to get object", error_prefix);
>>>           return -EINVAL;
>>>       }
>>>
>>>       ret = vfio_migration_query_flags(vbasedev, &mig_flags);
>>>       if (ret) {
>>> +        if (ret == -ENOTTY) {
>>> +            error_setg_errno(errp, -ret,
>>> +                             "%s migration is not supported in 
>>> kernel",
>>> +                             error_prefix);
>>> +        } else {
>>> +            error_setg_errno(errp, -ret, "%s failed to query 
>>> migration flags",
>>> +                             error_prefix);
>>> +        }
>>> +
>>>           return ret;
>>>       }
>>>
>>>       /* Basic migration functionality must be supported */
>>>       if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
>>> +        error_setg(errp, "%s VFIO_MIGRATION_STOP_COPY is not 
>>> supported",
>>> +                   error_prefix);
>>>           return -EOPNOTSUPP;
>>>       }
>>>
>>> @@ -1261,18 +1276,8 @@ bool vfio_migration_realize(VFIODevice 
>>> *vbasedev, Error **errp)
>>>           return !vfio_block_migration(vbasedev, err, errp);
>>>       }
>>>
>>> -    ret = vfio_migration_init(vbasedev);
>>> +    ret = vfio_migration_init(vbasedev, &err);
>>>       if (ret) {
>>> -        if (ret == -ENOTTY) {
>>> -            error_setg(&err, "%s: VFIO migration is not supported 
>>> in kernel",
>>> -                       vbasedev->name);
>>> -        } else {
>>> -            error_setg(&err,
>>> -                       "%s: Migration couldn't be initialized for 
>>> VFIO device, "
>>> -                       "err: %d (%s)",
>>> -                       vbasedev->name, ret, strerror(-ret));
>>> -        }
>>> -
>>>           return !vfio_block_migration(vbasedev, err, errp);
>>>       }
>>>
>>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2D0CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLL6B-00063L-Ro; Fri, 08 May 2026 09:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLL67-000634-Pi
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:18:31 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLL65-0008WG-QX
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdTP8rMg9ldXUOM5gaS/rwhuSbWzARaNP/hNQfjxiVTSQo23Jfbvgs58dbgaoMQTQo5sMI8KvE7QQdE7duRWkxIUYl51bIb/6LNB0trHuvh0UBIkiA57Pgh1QJmEdc16ZL3QZyjmPHK5gqi0cvudn/aQS9b0gt2cvmWR+y4KxSAoJurAOs5xffOwQybx7mVRfju/uGK83OI7wPvF73I5PJ3he6b4bSL3lhYbKH2gKNabOBltXMV0te+O7akOTjl7YE2WS/xF1hPIiCcaYP/s6M0HltVWe3GQZemaMhTSes7jBIcengbFNlUIpV9Rz/P8d3dTW0tm2SkljG7+60+cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jUazCBUMhF81+hD5jUi8xlSyD+Ic1z0THBsUAxsZyI=;
 b=sREe4kYbX4Ws6v0agIDNHG+fQ1aqgDAvDkk7580u20Z12xF1V4kHx2aoGf9XeRsQodjeP/oZim8y/HgIeu1VKR4H/BeSJASD1HAWT1SCRlWZOpkurOQXPvxsCjOmhrlGgvKyg/vHnnFRgAbKQ5XSvN97Y42hW8UDN7mhesdx5ap4fvMb9nYbGosK1twmz4pYuhxBeT+ddgqoPjPj3kAGHDnMvBZEOkjQDnk6jBjxlz0VaYJUyZg6fB2D8OJhd9jPJXfnyqQuuZlh/wEMflRSN3hnD8QwgxLZneyKLmiiMssDnQhB+QCAkiv0T3Pn7KkAVWNfvG4HEcoiQH/YkzWmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jUazCBUMhF81+hD5jUi8xlSyD+Ic1z0THBsUAxsZyI=;
 b=kejgOOEAUB7v6JOUTRFnjlAE68giEeQORXNHQzHGv5oFPkP/eCx8i06Q+Lt1U8tivYTtscq9vxZ1H8HXWtKVfa8BtamCbbWsj0T/VCwD3ITbGoSHAa8nmGtSFSm1wFmQmci6w8O0Mh6PmGiQFQNnMxgZJG7KeNFRcfTYgnPLzyWqcKOHrDLzGf45QBlCvGlvgnRG54g1sKJQJdztKxLbfKW47uWlQN5pjaOi9LEOiV88qgNkd+J/1R9lkOce0NNAuGrNOgiBx59b9hqUESbEO2uLMoeJvgWYyGYORyVNciNMQZgcQayBd1Od3qRGHXVatHj3xWtVrLiziH+W/4zw1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 13:18:19 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Fri, 8 May 2026
 13:18:19 +0000
Message-ID: <d3ca15b3-899d-43e9-b754-e48fc6e89923@nvidia.com>
Date: Fri, 8 May 2026 16:18:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
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
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <7653a2e9-b747-4c29-a5db-d231130e383a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1937f4-7fd7-4e92-647a-08dead04459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yEbc04vhqTPiJs+/dTAIxCsQeMQTRPxVtE9W+EmRmljrJcmfb8gOkj73jrJTCiO/KqbV7wMDcRQfPUyUKErg+zbY6KtgO0/QY+PScyFwVLhF9zszRHDmecchyn66LpsqclYI5N6WhlyZExsGP4bwySQ3uUEF16e2LpO6b3PGkq9g0ylUlC/dWLP4RV79ANXtzX/fMdc351+iIabsK/uasqQigyz3HP9WTobGd4NkOpnGpM4h6VX3hEC113tpSwygkvGnrknYJpxOgFhAe9vTh+qCFnL3FmxiNCK6TroE/pFE3mKxOcBJ848QvgTn/jFUk8IXLkSus6eA1hnX2QNh95WMHbOKyCYw2xB7D7bkefQtKmXSGqtsN7Gq5mQsmJ/VT6+FYRcvqZ851kTVZRefWReaRpiDX738u78CutkuFkLgK0YzzwJKvBcXBp+hLQETRA1k6I2wIZPAp7nuiq6XgWSl6agLmMnUMJVXX5/qcXy4aXKHyy7N22pczFtFdq3wtY7j6mI3Axdiny6inOhomoQd/0eYcCQp8N9/9r8YKne6NijCSj4tVhArxZQ8uIFoaKZ6x0NL3SCB7GV41xbX7vIfCHhyX2aMBOPIOj6qjsDzw1L1yFd1DYJrIaomzG3fpxGFUW7k+b7C7Vwu6IuLwLrhjMd5yH2VUD8AtEB81pENF7TweKAxZIRBWKs5d9fD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZWS0JKUW52YTBoMXE5L2cyRkFqVjZNTThyTmovQ3hRR2t5VEtoU0pvU2Vk?=
 =?utf-8?B?cEwzZ2dQb0lCc2drcHBTMDhsb0t6ZGhmL0txNjJmMjA0Q2FwWVlka2M5Mjhp?=
 =?utf-8?B?cFQ1NnAwb2k1Rlk2V01KTmJJYis1aU1MRVNYZnBaMHFJWWxCbUNISnpJVi9B?=
 =?utf-8?B?TUtUSGVTNytLaDkyM0lEb2xWbXF1UFR4ZjhlenRHS0hCUmpJMjVOdFIrOGNi?=
 =?utf-8?B?OW9xb2MvVVpvRWVOL0VRT3hVc20vVzhua05rdEtwMWxLSTdwOWFDQkttQ1lK?=
 =?utf-8?B?dDRFbWZzL0o3ODhFMCs5cGxGOFNubTQ2ZWF5TnJYUHBEVFVkOE11Vnh2Vk55?=
 =?utf-8?B?Nno1M1hiMWtCc3ZIWS8wQUVGcEZ3Y0RGRk9pRS9zeVJDNzNod0RYanE4aXM3?=
 =?utf-8?B?OGIwNzMwN1ptRWRaYzZseHpnTmtFRzA4Z05TOFdnWndXRVZ6YkE0MWx3Z0FO?=
 =?utf-8?B?NjRGak05OWpNYks1c3VHaFhTSmxWSTRvT2NUMlBheHRZTlNKUDNCMTVmL3Q0?=
 =?utf-8?B?dEZYYmNvWVAxZGJkK3NLeFB4aW4rSGRHZm5nLzZHeXVaaC9QSkJyVVU0V3Mv?=
 =?utf-8?B?SE9FUlh1WlhPbUJrUWtpY3ZrS3U0cTNXVnlrYlV6SXhiR3V6emdwaDVVN216?=
 =?utf-8?B?c0dqZDhKejR2dE55M1AvRkQ0R3B5QVFCbU5ZQmhjek95dmtaQ3hYbXEyMUV3?=
 =?utf-8?B?azJkeGFJd2VJTjRZcnl0b3ZZa1pqKzZyeHBTOG1zZnljTlgzVUpyQlJNL0tS?=
 =?utf-8?B?WE9CR0U4Ky9kcU5VaVZtSk14dVU1eWljT21TMzZuV2FLeldKRGVUK3pQS0ov?=
 =?utf-8?B?QzZ0andtaDlYZmhZcmNmTkExbTlaS08yRlFmMzIyaVpJaUJseEdIY3RjV2Vt?=
 =?utf-8?B?UHdWbWhQNnhqQTdUOUFjSVFOOHZTZXdNcVZRZ3IwTzRoRWJGcTRKK2c5c1Br?=
 =?utf-8?B?M3NZQU9tZXloSXRPZGxlY0d5b1ZmNTJuOGhUVGNZeEsvaCsxdkM1bXpBb2tE?=
 =?utf-8?B?eWRVTWlYaHlwUGRQUW9UUHovcGdXUjVaT1hZU0ttWUcwSGlGOURiYmdTbXhQ?=
 =?utf-8?B?OUgwSERmQ2NDQUE4VmpibU9qSWl3VmlvcUl3cDBsMCtuRXoybHpKaU90eGVu?=
 =?utf-8?B?ZjVNbnNjYlBHVE1RaU12L0ZzRS80cHFKcnJLY0htdmhHeGlESUFlcTZjRTBO?=
 =?utf-8?B?Qm9Zck95MzhEZnZ5aHpGZlc1UXZNWjRpVWVyTTdObnVwaHMwVkY5Y3pFNk9M?=
 =?utf-8?B?ekR1bXU4K1MyWVRlREViZjFVcDBDZlcxaVlmL3Z2VTZ4OTRxQysvMmlYTFly?=
 =?utf-8?B?dW5IdE1nd2JwSDBFOW5SUGhVT25zbGlxdVYzb25xcTlROUMyQUcxWFRoT1Ur?=
 =?utf-8?B?VExsNm5ZR1pQNm0vRnBCQjcwZnhaTDJZOERra3RVTDg0QUFhU0xNbG1DMnBG?=
 =?utf-8?B?d1REdjJtU2VQSHBab2V4d2ZKVFNydkxQNE1oZEk4d3lyUzRrTmhIOTdha1Zu?=
 =?utf-8?B?Y09MQXhzQkxNNkZmQ2llRGNDWTMwQkpiVlRYMVhVbXVXVUVERXJVWjBjZWRr?=
 =?utf-8?B?Mm1DejE0ZFlGdGJ5dDJEbUFQcWNaMFUwUUhVUE1DYXMvY3BBTmg2VzQyRXBY?=
 =?utf-8?B?YndHd2xybVhlMWFtMXFwMXI1ekdsaFh6ckdFbXJBSVBFdUxrUTQydlZjYWV2?=
 =?utf-8?B?MHhtY283UGowb3c4VDNJVU5RMWFYZGU2TTVzNExJcUptU0sxd1grWkFhUXlE?=
 =?utf-8?B?U0NFN1JmMnNTb3BZaFhGcWZxczZKSjRZV0xxL294Y2tqVlJQTkltSjJHWU5j?=
 =?utf-8?B?Q3BZMzR5WCtvaWdCdUZPR2tyZHZDS2llTWR4NUR0MENtZ29Cb1BRRW55Y1RK?=
 =?utf-8?B?dTc1L05yaGpCejd5VTd0Q3dYUlh6bnhtZlJHYkwwUUNUWGV4UG1xVG1NdytJ?=
 =?utf-8?B?ZHZUU3Rzc1JrSUlpRExBUUFuZ3RtZk96bVdLc2dTSEcxYmkvWkpJdW80TTEy?=
 =?utf-8?B?ekFWa1NZV3FRMjluNVc0dW5lOWNpTk1EMnZ1RmdNVGtRTkdCRzNOY0NLZFQ0?=
 =?utf-8?B?ZUhQUzZGa3pBNXQ4QUVpZmlZenJleTM1dVRKQ3h4VFdKbWF2L3lpQ0Z1bXNB?=
 =?utf-8?B?S3VDa0E1eVdaVEhGMVUwYkFlOHl2bUNVZ2EvTTVHbTI0YStyZUZ3eklmb3VU?=
 =?utf-8?B?c1VjMUNiK0J3amVPbXVjL29QK3lQNzRPdFdFMGNJYXp2NnB6ZC85Ym9Td3B5?=
 =?utf-8?B?VU5OM29tNEE5SHM0ZityZXZNYWNtWmNvb0lvOU95QkwrUlc0VFg5Lzg3MU9k?=
 =?utf-8?B?NzZwWjJmdVJZTTlXTEtoc0gyN0VQc1pyK0VjU2UzYTlwUXlEL3U5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1937f4-7fd7-4e92-647a-08dead04459d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:18:19.3772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjT8nWhdJ7L/VL/Zhi+f/BGee2zTbu7XyD18RJhLtmtUTxA8M9Sf0Dr7Kzg4FMaY0ZzNHr3UOohx7tJ8mbp4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=avihaih@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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


On 5/7/2026 10:59 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 5/5/26 10:14, Avihai Horon wrote:
>> vfio_migration_init() already has many failure points and a new one will
>> be added in next patch.
>>
>> Add Error ** parameter to vfio_migration_init() to report a detailed
>> error message through it.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 243624b5fe..b7e929274a 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1038,7 +1038,7 @@ static bool 
>> vfio_dma_logging_supported(VFIODevice *vbasedev)
>>       return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>>   }
>>
>> -static int vfio_migration_init(VFIODevice *vbasedev)
>> +static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
>>   {
>>       int ret;
>>       Object *obj;
>> @@ -1047,23 +1047,38 @@ static int vfio_migration_init(VFIODevice 
>> *vbasedev)
>>       g_autofree char *path = NULL, *oid = NULL;
>>       uint64_t mig_flags = 0;
>>       VMChangeStateHandler *prepare_cb;
>> +    g_autofree char *error_prefix =
>> +        g_strdup_printf("%s: VFIO migration init failed:", 
>> vbasedev->name);
>
> We have error_prepend() for this purpose.

Right.
I was trying to avoid duplicating the prefix on each fail branch.

Do you suggest to add a common "err:" goto label at the bottom and put 
there a single:

   error_prepend(errp, "%s: VFIO migration init failed:", vbasedev->name);

?

Thanks.

>
>
>>
>>       if (!vbasedev->ops->vfio_get_object) {
>> +        error_setg(errp, "%s no vfio_get_object handler", 
>> error_prefix);
>>           return -EINVAL;
>>       }
>>
>>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>>       if (!obj) {
>> +        error_setg(errp, "%s failed to get object", error_prefix);
>>           return -EINVAL;
>>       }
>>
>>       ret = vfio_migration_query_flags(vbasedev, &mig_flags);
>>       if (ret) {
>> +        if (ret == -ENOTTY) {
>> +            error_setg_errno(errp, -ret,
>> +                             "%s migration is not supported in kernel",
>> +                             error_prefix);
>> +        } else {
>> +            error_setg_errno(errp, -ret, "%s failed to query 
>> migration flags",
>> +                             error_prefix);
>> +        }
>> +
>>           return ret;
>>       }
>>
>>       /* Basic migration functionality must be supported */
>>       if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
>> +        error_setg(errp, "%s VFIO_MIGRATION_STOP_COPY is not 
>> supported",
>> +                   error_prefix);
>>           return -EOPNOTSUPP;
>>       }
>>
>> @@ -1261,18 +1276,8 @@ bool vfio_migration_realize(VFIODevice 
>> *vbasedev, Error **errp)
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>
>> -    ret = vfio_migration_init(vbasedev);
>> +    ret = vfio_migration_init(vbasedev, &err);
>>       if (ret) {
>> -        if (ret == -ENOTTY) {
>> -            error_setg(&err, "%s: VFIO migration is not supported in 
>> kernel",
>> -                       vbasedev->name);
>> -        } else {
>> -            error_setg(&err,
>> -                       "%s: Migration couldn't be initialized for 
>> VFIO device, "
>> -                       "err: %d (%s)",
>> -                       vbasedev->name, ret, strerror(-ret));
>> -        }
>> -
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>
>


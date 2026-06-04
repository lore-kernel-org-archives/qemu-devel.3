Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55435CD6E78
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV9f8-0006PP-N3; Thu, 04 Jun 2026 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wV9f6-0006P9-Mw
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:07:12 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wV9f4-0002ws-QN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd5SuEMrcbpNgbTHeGS+jM3kbI5dnlL6dbKGnJ2YelcU13D0Iqe1EaIj9+ec7ANx4uT15FFHdX3m4yyxpR54kl1UaJkEH2mCGFeR1sDQ3MH7TbQ5c5EVr1fkBR5jQBiiJD4tOegxZlRMEdee15yOCa9MSH6y8UtZEwBAr6xGed2OeW4VY9001QeYR1H+6YlpDVx8eMHdypfNFAYb3XHyFqs6UIs+AXpMjKc8JfEAXHlSPZQ4O107B6X8sftrvSQ7MBrTusSbehlQlt+ud3p9NygWCvTeQcSEkwwdsm5phZVAgeDizuF1PzpvYRlw8zkpqJaNzjpxIyn5QZqTaHDfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXfxv/nxoyJa929hkOVOEErWV2W+uhxjY0xcdl4jvgQ=;
 b=RT3/Q0qJ/NN2BFOUfZccTX1p1Es3D9UJSdOfy1Km0CMWTAJaqmiXySCGRNAhSyG+iT5EHMXyJiBrpUSm28N4R6nm3nTsctmBO6H0dBuIQds7ISjQ7B0iB8pcnEdgPnv1B+3ZTfZEI1ZZZ+0t8kRZTZMNcngkC4EpsgLg/faFESBsX24YnOD9vQ5oO4DRIB0/tkjZmDiPFtOJNLfP6ZdIGfgBpiYAPGQpkjBNAePWNyF0/d08enfygfm4rnszQD13SFjm8vuYI3uVIUpsfLTvNDcEilU6WaHFuMJcDz8RQ1K/bNgOYuDhKgk0Zr6Dux4U7zn+HzbByPqefzQ2RtonXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXfxv/nxoyJa929hkOVOEErWV2W+uhxjY0xcdl4jvgQ=;
 b=cofJDJzTAHSgdUdqsqYB5QYhngrJVN7I9yXUaSrfwGxmqQoaUHgqIzMg25Y//IOhI7yjinLGHEhCsV1RU097xbgMrL9auwhsFeL/YDih4/qggX183M56EgJizExivu/d2rNylPfm0EzMg3v6rVr2k/VZc7YWNlil+DaIAzRQbv2aRVoLvUg1bQc8uDw0kgLPM0dstp4OE20m8l7pGrIgJTm5iEzHp90yDohE7VFLv2cQEyj+28no+gqFyS6cOsbwTeAY9TGOizBOet6SkThPeNXcs7C9750erA6ZAKa0dBovYHt5a9u7K4yytR0MXqrnonBVPkC2iMe9M/FcKw898A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:07:00 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:07:00 +0000
Message-ID: <9561c413-8ff7-4ca0-9623-0846469dafd2@nvidia.com>
Date: Thu, 4 Jun 2026 18:06:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-10-avihaih@nvidia.com>
 <708d5809-89f3-418c-8bd1-4ec7f9ebdaf7@mailo.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <708d5809-89f3-418c-8bd1-4ec7f9ebdaf7@mailo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 84878044-0a2a-4fc1-ca02-08dec24aed94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: /HKmYVq3FI+G1A8ZiCqSKR0zhhkMi1YgpnzKYMaqRHTZUn17/mLv6F2LJqHzJHxtWWayvHl/EfDofUv0UMFCbmV/c3RimvYEinxPie1Cxjo9Ql4Mw1YwHtHhPTN8XdSfTo9HfA2NmK7I79SvAE0W48gIavhdc32daQOULfVjft+kDejQaNjxsjDPwJjzYXBpm21lLu7T6jM4NpclJy62YXIye910X8b0J7/GbpenVbwfQj+F5phNO3UmmvLucAv7ziFS8MA3pXhlJu+mqT3CWDXmWVn4Eauwsh9+Q+vukA3p8fNVz/RXkmJHTNO4WcnH/hq5x5xXU0RBb5LKS0D4C/jN0y7gwGdgdQhgZeKXR6gHh8GalS/ZSiHfqUs5/xasUq567CY3JKNXlfuMHvjuj6Zj2VDcuEdI92ohDvr9/5PceWdxjL5GMiAICG9Qk1T8RPpI2nD+/umdZpt+By1RFWqe5LrrFSFfrxzoQ22kCqraKdv0aGB0SO4SX2AqVRYFHlWcCF0lRQgdVmwXUtASHNCJ5Rn3pnFDb5ZOynEOGV0cfJ21sNR/f1ktrP55gI8hddQH/IYhX/OlVysyIkmyvR5EGdx3y+2mkRuPN5WtiWFRnzp2wGs7qA6lkDwMj6LJ8sTFFW78lF32s7vqaAWuN+Jc6O/UzAESEykVASyT2kJofFWXE4zwYh08ZpqxjZxe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elVxTkwvd2dDZHYyUlBXYzdlZmR6Ty9ZSFRDeC81eG04NzE1alQ4bWEzY0ky?=
 =?utf-8?B?aSt4aXZWT1BFK3RMMk9qOEtiZW9ORlV5cGdLdkRrTzJ6YWtTbkQ2bTdJZWE2?=
 =?utf-8?B?dWdqeXdIRDBGQVE2SjV4K2xBdDZDU2JmTG1CVlZIekZ0NHZNelJieThQT3J5?=
 =?utf-8?B?WlFNUEhRK3VFeHhEbTZ1WmhWd3Q4OFRKbjdrUUc2NFdXY0p3UnpMam9UVjdG?=
 =?utf-8?B?R00zWWhvSzJGaUJQSU5sQ3lsL2ZCRjBhTXFsT0ZGYUxDSEJuTVI2R3U4aXRH?=
 =?utf-8?B?SkUxUHlSYlAxNmhjQW9mT0pIVmg0bzhXeXJRNi80ekVtVm9HNlFwNmdxNHQ5?=
 =?utf-8?B?Z3BVMlEyUHl4dTI4eXJWdy9FaGF6WU1NVVc5emJZelM4SVlrYVc1U25HdzdK?=
 =?utf-8?B?QTNMQmRrd1FCOXZhK2psNGFFS2FtcnlySUxydkxHRzBhNTBhSndCL3BObmdW?=
 =?utf-8?B?NTdXRUpVNWNwejVJeWZSRjVUeDBXUURZZGFLY3FQVDFLcWlSZTR5d010UXRs?=
 =?utf-8?B?ZnU4blBtbC91L0x1VGdnbHdwRXpYTzhhL2YxRGp2NmkyNGNKZm9zQ2ZVUnJL?=
 =?utf-8?B?YTYzZnUzU1U2K3R2Zit6MEIzbktxUmd1YTg2S0xNMXZ3aldQTXVFTFdvaTdo?=
 =?utf-8?B?LzVJSGZQTHB1NGErb1dyQTN2MGJDZGlSOTN6QThJQ3cwaUJCLzM0TlNpc3lo?=
 =?utf-8?B?ZkVOckZPMXJIWS9JNTNDS3NaR3hQK3g2NXhlRHZxTGdlbHd2NEdUQ1U5cnpS?=
 =?utf-8?B?WmF0QXRVV2tBeU84bVZtS2YzanRhL1c2ZHN2MUdLQkJZMzk3MGtWdVZQTTFP?=
 =?utf-8?B?ckhZbEUrQi9hWTFmdkFVbzJubHl1aldzc0RqSTVLM3JKd1EycjdYS3E3WHJZ?=
 =?utf-8?B?VCtoWlZrVlpZVmttcDhGWUNRVFNhSmxLYUF5NEdpMTF0TXMyZkk2bUJndThq?=
 =?utf-8?B?a1FzdjdRb3ozK2s0Y3JTQ0NXcDNzVC9Ic25DK3pXSWhsT0t1YmhBQVhXb1NT?=
 =?utf-8?B?UmJ3OFp6ekhIY0szOG54SGl5eVpnQlF1T3h0WUU1TnhxVytTU2kvenh4WWNP?=
 =?utf-8?B?cjUrZ0NmQkFzMnBkbjUwb1dlVGtvTzgydFhjNVlzak9VQ29iTEZrZXdpbE5E?=
 =?utf-8?B?emhZai82eHJ4ZC9zZ2JHQjJYVmVpUDJKcEE4SzlqVTc0TVMyVURPdlNVNUpL?=
 =?utf-8?B?UUo0WlkwZ1JUODM1bm5WRU5yUkx4YUJ0WVJIMTlzNkpicGViYUtTM21uT0c3?=
 =?utf-8?B?VzhXaThuUVJpUWJHL1JsKzJrK2t4MkVGWXdMeXdveXdMQi9jNkNOUmNxYXJm?=
 =?utf-8?B?TmJPK1dYU1hleUhiVlpoVlh2amdqZ2RJRWVWajhqSWFOOTJZNnB2OWUvYm5h?=
 =?utf-8?B?Q2h0N1J3SC9iQ0VCdDlGcFl3Y1V3Q003Y29CQ1BsTVdnaERleVd6ZUtua1BW?=
 =?utf-8?B?SUlQSGxrQmpTMnJ3S0hKbEZRc0RPNjNITEZ0NGlHdXQ4dk9kazl3ZkVxOFdh?=
 =?utf-8?B?KzhyejVUVWFJRnBMc3I3MWtJTjR1S0FQWG4zczFZenBrdUx2MnFKWFdzeXF6?=
 =?utf-8?B?OGE3VVV0L2ZhR3BqS1FOUUNFbEtHSEZTY3RrWHVvRXZ6SElpRDFuaHhDNSt5?=
 =?utf-8?B?OUJmM0tnNUNEZHJsVFNNK2VqSFp6V2txNFUzMFBZS3IwVWovT0d6cTJSLy82?=
 =?utf-8?B?djB5clk1OG9UcFduL1lqN0RBaUVsRzhVUTUzZnVmeFRNL0ViT1JOUHNMeUhP?=
 =?utf-8?B?Ukt5VUVGUXVvdnhxQklqK2x4aVkyMFJ4WkxIbU5RcXZidnRXMXdxK1NiWEt0?=
 =?utf-8?B?SGtrNitCQTBLVGd2NWVVY21PcDR5V3dOaWxWcnZxUHJheTJnWmo0cmZsUkd4?=
 =?utf-8?B?VTVtbHAzZXRqV3BOMkY3eGJQY05nYTUzT3VZdUtJUGlldzU0YVN3eHY5WmND?=
 =?utf-8?B?cmJXR3JpTW5KNW9pSkQzTHpxRlYzT3lHQ1htTTRnUlZkQ3hEalpQVmxsQ2dT?=
 =?utf-8?B?WU1QVEFXcEtFckFjb1hEMm9IWE5kZUxlR1J3RHhzMEp0QVZwcitXakNkQzFw?=
 =?utf-8?B?eGtWUXdTNStJL0xhd0pXZWZ4TW9BN28ySzM1THdtTXRwZ3ZjZTh3b3pmcDk2?=
 =?utf-8?B?NnBXYWw1RXp1L0lNUEVPcEErMUlIQnFqOWhZQXBKSjdqMnZpUTdGMHRWNFNZ?=
 =?utf-8?B?UmJHb0wyQi9HNHBJSzIvYTR3WUs2bms1UG5DRHpSSGhpU05SL3RpV29nN2di?=
 =?utf-8?B?OFFROWxFcEVYN3p3K0pFSVRHeHI1cWlOOEU0SHN4YS94ZlI4K1BjMmhHUWtY?=
 =?utf-8?B?WWRzajJrS2x3RElRY0kvbVQ5QThXUlRheFM3MVRlRDBVaTBDZEFYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84878044-0a2a-4fc1-ca02-08dec24aed94
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:07:00.5218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNKMllNWVw9feefF8n+onhYdXTd3raWnv0s6VCAmsdBzL+CZoJGBGHqlVdytWsa/QkZgkUAcRCqlEMYc2WGoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


On 6/3/2026 2:38 PM, Philippe Mathieu-Daudé wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Avihai,
>
> On 2/6/26 11:26, Avihai Horon wrote:
>> vfio_migration_init() already has many failure points and a new one will
>> be added in next patch.
>>
>> Add Error ** parameter to vfio_migration_init() to report a detailed
>> error message through it.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 25 +++++++++++++------------
>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index a15e877fd3..02ef216712 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1055,7 +1055,7 @@ static bool 
>> vfio_dma_logging_supported(VFIODevice *vbasedev)
>>       return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>>   }
>>
>> -static int vfio_migration_init(VFIODevice *vbasedev)
>> +static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
>>   {
>>       int ret;
>>       Object *obj;
>> @@ -1066,21 +1066,31 @@ static int vfio_migration_init(VFIODevice 
>> *vbasedev)
>>       VMChangeStateHandler *prepare_cb;
>>
>>       if (!vbasedev->ops->vfio_get_object) {
>> +        error_setg(errp, "no vfio_get_object handler");
>>           return -EINVAL;
>>       }
>>
>>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>>       if (!obj) {
>> +        error_setg(errp, "failed to get object");
>>           return -EINVAL;
>>       }
>>
>>       ret = vfio_migration_query_flags(vbasedev, &mig_flags);
>>       if (ret) {
>> +        if (ret == -ENOTTY) {
>> +            error_setg_errno(errp, -ret,
>> +                             "migration is not supported in kernel");
>> +        } else {
>> +            error_setg_errno(errp, -ret, "failed to query migration 
>> flags");
>> +        }
>> +
>>           return ret;
>>       }
>>
>>       /* Basic migration functionality must be supported */
>>       if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
>> +        error_setg(errp, "VFIO_MIGRATION_STOP_COPY is not supported");
>>           return -EOPNOTSUPP;
>>       }
>>
>> @@ -1278,18 +1288,9 @@ bool vfio_migration_realize(VFIODevice 
>> *vbasedev, Error **errp)
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>
>> -    ret = vfio_migration_init(vbasedev);
>> +    ret = vfio_migration_init(vbasedev, &err);
>>       if (ret) {
>
> Only 'ret' boolean part is used now, have the method return a boolean
> instead, like other methods with Error **errp last param?

Sure, I will change it.

Thanks.

>
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
>> +        error_prepend(&err, "%s: VFIO migration init failed: ", 
>> vbasedev->name);
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>
>
>


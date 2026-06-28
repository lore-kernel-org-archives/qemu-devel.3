Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BB4C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 08:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdklw-0003x2-4e; Sun, 28 Jun 2026 04:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wdklt-0003wh-M4
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 04:21:45 -0400
Received: from mail-westusazon11010017.outbound.protection.outlook.com
 ([52.101.85.17] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wdklr-0004nh-78
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 04:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6AGjD5y13VWJNP7q0wIpTYlbX4i/ELg/+evLXOeJUwfY3sxBPhSUIHU7UO/rUml8be/1Gdulx9l9kN5Fho5mng7dpXybtW2FG4BgYCNzSj2qAv821rViVAZFRfAL333Y0F6/cKY4YZ16SXGfKZEbHpBVcR467hWG1RShHfSKudw/ZEof2C/LYqx3f302i1oOd3Vv0+IkVVnsDExllo/B2wWeoUPgky2bgDdMl1lLBd9EZqNhpHiWCPJzYYZS0lnaVxN8rUeQUsqpc6TopXmvw4V34Y0GF5BcLf6OovY0UpyQ2nx+CzHvkfhO6n8xflcd4ypZDbt9MzboetxP2YTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQbwMRhWuuNmW2A/MLJV0I9zY3mwvmV/h2oh0zNhiT8=;
 b=FDZPUa15F2ZrR0FVVeyq1rY34Fg0R5ofa+Y4EvGU1KuEdUgFIiqyIDQDoC2usVGmPKVLJ8jT1lHv4B2OGhBp+MP+YAOGLdUiZ/Oa1s1YSnnO7OlsNti5W8fitTZQ+PQs7ZP/b90wsD/JmbRQi09kj0a6pqtKOwTQy8NCMJcGkXUgyPPalagC09UeBoxxjwVJSx6q5aGwTPL/QvGBoyINc9FPdxG3DfQ0p71fxGp0im5JgDx9/n+fUtyWd5BgOPBkNW0Ncm0SgmpfqnAmfV2es9z+BvZeBtcIL7r/mWrlQbbOvNFmoD68wURlOvmmPS4VwqJClAuKlrBL34pZAYukqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQbwMRhWuuNmW2A/MLJV0I9zY3mwvmV/h2oh0zNhiT8=;
 b=at3xCTM232K6Eghr9OaMHmirIzgiVMsPhk/Hsbpsxw/WNvBpjfl0ZPw4kPyHMJuNts6Mv7lqEQL4cDKgjEZXEAhh37dvIdOVmxBo9oxlPVEvMAB7xiYZZI4mX4htpe3sH9B8ce0fqEXu5zV87HSvUYFWTkDTMShk03zAebHXUWarMIoOEIxau8RGVUJnfJlS6wuHVb9eCQofH+e+EngS1duKT8UnB/LFWau5RN7NlfI825A7igTgNCef5mHXTjLzPohEflypCVHglvAoYNZucmCxLWJhPtWD3Uu5szxgWIrPox3/YymoZglOLIOLkTiJTUFKxuLWttARxhoIV6NgZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sun, 28 Jun
 2026 08:16:32 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0159.015; Sun, 28 Jun 2026
 08:16:32 +0000
Message-ID: <b997b3f7-0a95-4c21-bf18-c19bf8754936@nvidia.com>
Date: Sun, 28 Jun 2026 11:16:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
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
 John Snow <jsnow@redhat.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-8-avihaih@nvidia.com> <87v7b520uo.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87v7b520uo.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2670c664-94b9-4649-4d45-08ded4ed8fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eQ45DwzkZWR4eoRhtWp1E6k1rRrke/9At/GL7AXeXuEa7mig4vbjcEmoBmE07UwCla8fktPDY4NGGvZHh6mqoeKvXJzvufcamJQJNUbwDYe1PnQb2AxP+5rLge73zRo5r9S9DMt1yB/Js4LlYc6gA20upzPzl8wy19JJDcSDORJZxry+AJJNITOXsvlwQhj8eVTl+EjH8wuKXJ5/DDRETG6VvVGBRX6Ks2hzuMPJLMhXdcFqKsZWltMA/spW11FZPtsroL79Fx92avHqwW+OG6JLsFhlnLXEvqFS4QP6p3Z2dmIS06d/0K5WGHYdvYaRkuoJo1xXVlqsmmQmi0UZX6BT1ccOa+kEtnWxpBDyMAatpVrSHHWgMDyUFzeX9AB05n1bpAsWCnAXIcmq7VPc/38tSj5MDLFJ4FRCHNygucreLKn/3Of43V+7fL0vbVoFSl8+pH1C49jsG9stcZOg736EiPS99PO2uFcVwzjNCbzzPVGleeQEUIzzwdaZ8EiHvh/sApPjHSdO1yGKC3CVL+lfUUwo/cvggTIXact43xjgw3N8Z5Nerfp3dHK9mkPLtlp5T0xCQ/tyDW/SMNMjf5OE++Wu+JvAfeuC+rMwrjKNAx7S2UEkqDh75ROuJWKWY1scbHwSksnvn514252yros2xY/iUXlzIgcthcqfYFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lpdGFpalZLTC82d2UxeVp3a1duYXZJekFVa3RBenhEYVo4UE5kTUNhTWN3?=
 =?utf-8?B?R29BaFhLdXJQWUFlNVo0SVJYWityMktEZnBEd2tpek4xdUFxOE9CUEc2OGls?=
 =?utf-8?B?K0VOaHljRGdRUVNsRTJ2M3NOVitlRUllTnRUWXBTRnp5Smx5SnM4NGJqaC9B?=
 =?utf-8?B?dVEwUVFNb2o3bTNETm5RRlU3dTF4SkJEUEZPMXJpMkVYL1V5djV6eW5ZTFpr?=
 =?utf-8?B?Y0tVSExGM254akI4N1l5bEtLOVYybzZoSk1IQ01vSllVMzU4KzhVWVcyNFdR?=
 =?utf-8?B?TitOdXpZVVFmUEJKTDNlSXRGaDdCakRwQ1RkOHEzQTBCRGxuYUZ2UFlDWTBk?=
 =?utf-8?B?ZXRZL2U4MWcrRWVDZUR6Y3ErTmQxeUt0T1VRSE16Rms4OGdzbXdpQU1JVUs5?=
 =?utf-8?B?VHZ1ZDdtTWhVdXNVY2hsTnRMZ2FDTGJlenpGN1NocWFDcVJxN25TZlNTbWZX?=
 =?utf-8?B?aTZjRW9aT1c5UUw3NFU3NWg2M2MxS0gzMHo5M1hpNllsbnhEZzdFQm5xYUI3?=
 =?utf-8?B?S0dEMkZNMlZ2ZDJUcjViVm9USjIyUjJKTHMxb05ZTGJHVE5tOERvb24wc1FD?=
 =?utf-8?B?YjZIbmpIZHBKV2o5bVZpYzNnWEVZMDR1MHZEWEI0QlhhZWM1ZjVpK2V4dWVw?=
 =?utf-8?B?OU1TWkY1bkhzcUdlZStleUlMOTFVTUQ1SmIraDJoYjd3akpFeG5NN0U4cXUy?=
 =?utf-8?B?bnoyRkNuandiY0hiRjVzc3I5M1F0QjJvbGZ6bllQa25kc0NwbFdlMlBoTnVz?=
 =?utf-8?B?VFpuYnBJRU0xcWlBRHpPNzRBeDRSMmxyMFFvSS8wdU9MRi8yMnRzUjAwTnhx?=
 =?utf-8?B?SVB1YXgvZTExUnpNbk04NUd5bFNLYjU0MDZTeTFxbmhxT1RqVE1SUVlTRlhD?=
 =?utf-8?B?V0x1a0xUQ3lvcThJYTAydzFTMnhTeEU3UFhMODUrNDUzUXR4Wno4a2JjWlp2?=
 =?utf-8?B?SE9RTXVQR28zc2g5Y2ltT1BFTTNlWWdYZDBqNFhQMnF0UC9VRCtXNldDTUlL?=
 =?utf-8?B?U2RuanhMWWY3MDEyancrUWg1NDVURUZ3dURzb1Vzd1EzU085N0huZ2tDek1v?=
 =?utf-8?B?d0VhendqZlZHNFpadUxCbm1sR2E0ZDJjUEJOTFZDR0RKcm9RbWxBZTVJdFUv?=
 =?utf-8?B?UHpwWElLUjRYWDhUSzVKWm95c2s2cXNnUUwrTjM5VXVrSko1UDh4SGNGTnpy?=
 =?utf-8?B?N2RESXlTQlVYcFpvV3gzTjVOT25uaU5TN2wzVVFzMEZVTGdJRkVMMlV2cUdh?=
 =?utf-8?B?ZHZVTVpOUSsvQzVFK3dKM0k4QThseWJ6eUQ2ZmNZTFNtbmFnUWxWY1M0Q2xk?=
 =?utf-8?B?WmVHN2lSdmlWaFlOVllSMEdQVnM5NW5PR0k5K0xObHBjZVJwZ01lTlhnQkZK?=
 =?utf-8?B?UUg1Y2MwR0FFZld4SEREQU1RenV5TXNYL0tGdkM3bFVsOGNEbU1tRjIzZ0w2?=
 =?utf-8?B?UW9oTUtJZFp2c2xxSnorSSs1NUd0L0FhZTdnUnd4bU54Uy9DZXZReTFjaXNV?=
 =?utf-8?B?cnk5Q2NXYlA5K09WQ3JiZ3YxTVBORjNsOEE2cmE5V3g2dGhBOWUwdEZucHUv?=
 =?utf-8?B?QitaS1JvRDBIR1hZTENUZWtnTCtzL2d4bXBXVHdBYVFvekljVzNiTjF6QnRY?=
 =?utf-8?B?YU9Cb3lqNmdmZ1daUzZZaDU5cHRiOTIxT1U2aUYxZFQ3cHMvbm1oVjdoSGJu?=
 =?utf-8?B?R3JTWTJ1OW54SERsTm8wYU5wNlBJcCsyYTRYeC8xS0M4d3pteU1mR0ZnWWVO?=
 =?utf-8?B?aEV3ZjQ1VXJBUEN6eHJjMUhWUThNOWhvcnhVMVRYYktiNTk0bHJTNXZpRVBK?=
 =?utf-8?B?Yk5qYmFtL0tPMC9QVjJPb0NON1dXYU9FSmhObEFNTnZFc3RqazgwbHlJVDNS?=
 =?utf-8?B?bmxua3ZrTFpEMSt4S1d6RVQvWUQ2WG9ETUVEMTUzKzZRRmF4U1VoUVVHSU1B?=
 =?utf-8?B?WVRqdk5GQ09XS3RZODc4eDZRcWhNb2dvK3h4TExJUURLUGtveVF5aWsxcURG?=
 =?utf-8?B?SDYwdGxkVlB1aUVxVlAvREUyUGJadnNRYys1cUcvSE1FMkIzTVhZN3dmYnQ3?=
 =?utf-8?B?NFo3cEo1dVJHaWVlZk80b2FPRmxpL1FjTVNabENybHFKdmRxc0FNT2ZHbGll?=
 =?utf-8?B?WitoNnRSVFVtYXpaWXVWS0VKMkxQdkN2eit1Q3FjYTdnZHVrTU8yTUxkbE9K?=
 =?utf-8?B?MTZjZnZMbzNKZ1pOa0ZEd0o0ZDB5L2xPb0xoK2ttRGVlZnBOMlljK0J4UStQ?=
 =?utf-8?B?bHRaTllVTU1LYWJFcVhlR3F3eTI3UHRyZEZrN3J0ekltM3Q5M0trUW9kcFEx?=
 =?utf-8?B?RjhodDdYZVhQbXh0a3dTNEZQb1ZFRVAxZzVjTGhLOWgwbGZIWDZ4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2670c664-94b9-4649-4d45-08ded4ed8fd3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 08:16:32.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWYnIOeHKQczQOc0WKPiSf4gvWUxwDSXJuG7tHZLug7YsRgw/nsH//vMuGQIP/pdiU/X1bQVlJ1jrB3o8SVnhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
Received-SPF: permerror client-ip=52.101.85.17;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 6/26/2026 10:54 AM, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Just spelling nitpickery this time.
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> Switchover-ack is a mechanism to synchronize between source and
>> destination QEMU during migration to prevent the source from switching
>> over prematurely.
>>
>> VFIO uses switchover-ack to ensure switchover happens only after
>> destination side has loaded the precopy initial bytes. This is important
>> for VFIO, as otherwise downtime could be impacted and be higher.
>>
>> In its current state, switchover-ack is a one-time mechanism, meaning
>> that switchover is acked only once and past that another ACK cannot be
>> requested again. This was sufficient until now, as VFIO precopy initial
>> bytes was defined to be monotonically decreasing. Thus, when precopy
>> initial bytes reached zero for all VFIO devices, a single ACK would be
>> sent and its validity would hold.
>>
>> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
>> initial bytes to be re-initialized during precopy. Specifically, it
>> means that initial bytes can grow after reaching zero, which would
>> invalidate a previously sent switchover ACK.
>>
>> To solve this, make switchover-ack reusable and allow devices to request
>> switchover ACKs when needed via the save_query_pending SaveVMHandler.
>>
>> Since now switchover ACK can be requested for a specific device and in
>> different times, make switchover ACK per-device (instead of a single ACK
>> for all devices) and let source side do the pending ACKs accounting.
>>
>> Keep the legacy switchover-ack mechanism for backward compatibility and
>> turn it on by a compatibility property for older machines. Enable the
>> property until VFIO implements the new switchover-ack.
>>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   qapi/migration.json                | 14 ++++----
>>   include/migration/client-options.h |  1 +
>>   include/migration/register.h       |  2 ++
>>   migration/migration.h              | 32 ++++++++++++++++--
>>   migration/savevm.h                 |  6 ++--
>>   migration/migration.c              | 37 ++++++++++++++-------
>>   migration/options.c                | 10 ++++++
>>   migration/savevm.c                 | 53 +++++++++++++++++++++++-------
>>   migration/trace-events             |  5 +--
>>   9 files changed, 123 insertions(+), 37 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 27a7970556..9b3070e494 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -508,14 +508,12 @@
>>   #     (since 7.1)
>>   #
>>   # @switchover-ack: If enabled, migration will not stop the source VM
>> -#     and complete the migration until an ACK is received from the
>> -#     destination that it's OK to do so.  Exactly when this ACK is
>> -#     sent depends on the migrated devices that use this feature.  For
>> -#     example, a device can use it to make sure some of its data is
>> -#     sent and loaded in the destination before doing switchover.
> Here, "switchover" is used as noun.  My dictionary is happy with that.
>
>> -#     This can reduce downtime if devices that support this capability
>> -#     are present.  'return-path' capability must be enabled to use
>> -#     it.  (since 8.1)
>> +#     and complete the migration until the destination has
>> +#     acknowledged that it is OK to switchover.  The acknowledgement
>
> Here, it's used as verb.  I think it needs to be spelled "to switch
> over".
>
> Same for code comments etc.

Sure, I can send a patch to fix those.

Thanks.

>
>> +#     may depend, for example, on some device's data being loaded in
>> +#     the destination before doing switchover.  This can reduce
>> +#     downtime if devices that support this capability are present.
>> +#     Capability @return-path must be enabled to use it.  (since 8.1)
>>   #
>>   # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>>   #     keep their dirty page rate within @vcpu-dirty-limit.  This can
> [...]
>


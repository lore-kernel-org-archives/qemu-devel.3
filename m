Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3813FCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnof-0002Ra-TN; Tue, 26 May 2026 05:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wRnod-0002RI-GU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:11:11 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wRnob-0003eZ-Lo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJwevtaOG/4QRcB0slnewUZBEE9Kj9BEcoLiav0o07LUre3t0eLXv/9u2Pa7BoQJl83tJagSqXkYAnrgdplWQIB9yyLj+btIzh9g1HC75CO1L92ICyZiX44umGCqdKmL6dQ2P4sSntM++Iha7FQ2XU9JAJvYt4nlHvLgmWbcvl7ggSR2vAqGflm6Cw+SJqfiNWXqkzbqQVSDDm7oHMVUr8sAOkZBlbcq94++t7Uk3+tXU1j7dY4L9C97Wu/QnU8Y988tpUicEmejMBRMV5BCfO82N4wl1EMYPlWw+9HvaYlM91TvQShcO7buBAStESDIg28ibytlR0HoYxTEPdYIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY/HUqEhCuJ2MM0xTxJoFxxzOhawa/lwoMjgKtTFiyo=;
 b=UBkxwqsSm/NZ7YaZ0XDdc5fHeMsZKjjza/4GjQMyEKGRM9D2OEzGpbaEB/OiYqBvzZTq1K+ME3eDKwENPD9F5fonb3YE+UIo7yDVyHPuvOPlHK6H/WHXcJCUw0oo4qe/kDHU8QncdG2gXxs21dPY2ytFD8+mvdK6m6BZfySpCBy7r805HxkkOioL8FBvBVSqDvp9RR9S/KDe6W7T3h/CcXO2bFc/WVn4N1wO85zYeFdtXjt/QQViquofGFkQRqOIbA3MuLvY7NBQFDbIdGzoG+RIPNUhan2lXU3vj8slaCGqhyZAfSEDuw3eGAJHGvT+RIj/EtAxombtK23WM4I+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY/HUqEhCuJ2MM0xTxJoFxxzOhawa/lwoMjgKtTFiyo=;
 b=dGficblYk8deGan4byKgGfuSeMP5mhTKg4YoDX2Zeoh0lDS6E58Yi34Z4ZH3nhMmMLEY4M42wbiU5u5qFoImv2AwBu9j2d5DFMg9s2/6A+Itc+XikUsdZcIV+2/NWrkbesv3fh11E3O8a+qeLK3OsSZch76OcHZ28ZOWWuNsPdH4zb6w6qPsPvDY4oVOf15U/Bcl/kPh90GFaP+gWs3oPjhjzCLRvKK3TYVzXs9A5UUah60dsMbr32WuzsqMpTq/ce9L05loqceyTb5Ld0ao57MaaU+Ld5Ihi6veGR+pb0VHfDtTV3gOa8L3UbK71aoWusQCeKV0MbyUx3osF6I2qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:10:33 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:10:33 +0000
Message-ID: <8389845c-aa25-4e32-a20a-978f3ed1d118@nvidia.com>
Date: Tue, 26 May 2026 12:10:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <agzDdH5vClAqwjAs@x1.local> <3a1d0bc7-7656-43f4-b763-5114d9dc57a0@nvidia.com>
 <ag8iwiwMz5IapU5i@x1.local> <2756b13a-498a-4e2d-a218-10b756e0bf5b@nvidia.com>
 <ahRnp0Q18iTZZJ0H@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ahRnp0Q18iTZZJ0H@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c7aaa6-bc1f-4060-2199-08debb06a411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|6133799003|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ukUQD1gBmgqxtPWX9RB6q6kdsuDzLB2t+YlNJATxhDfOa2hnnGxscAceMZDFzQBUD4J4WiD1iEiUR4AD9ND60ciTow8UyoJnSlYE+NheO1wUD1W0++nnNbuDBZb6XJbDJt8zLyCtwR/NKrwsYGKhaiSG1eTdPKWBXvb1zyDztZ3/Oqt1BzHNSlIeisqChKMbvfwcAjvm18Z9ReUNEcGoL0ZJ99+op/X1hiR/KPrvfPdYTbyy9rBHDuUp8g0w6rwWm90+YHhkbEkTaYDEx295dhm3E512BPGGE6pGf/aqvnrSJg1HjmUiHla9ItQRYL+oxWMeVabvmwSXCJsOSijOJKbzexx5y435WViiOgruuNyb/KrZHa67gQQ0FAXNjxMRaBRb2dXCkSQuTrKXxIj+kGpBfMR9YkNKm80mbwX99MSoDjzRy2c5jze5X484dTtPSULto8RRebJuQn5IHortySTJ1cOmwxcWKbMGpUaTHJTZ61qAUL4wOSkAkiu21s4XQ5pRt0ZTD0XpDHnuY9SIxarLs6iMf2pfdUtTLpF8n+UWhUkSSYsB9kIQuodLxysHFfVVOh0GRorBf2LhejyupMQ3f4qljkZ7FCjHKthD8qbuPclm9Nr1TaCnBDOWCcCN0JxKHqm8oxM3wX63zTtuLf0Eb17uF/nNuiGrP+oxFzDdSQuE1LHlxPl1Ww44tXMh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVR0Zy9udjZ1dkNrS1cyblZueW03ejVFV2NUa3RtNDN0MGFoNTFnWG5wVG1l?=
 =?utf-8?B?Z2R6MFFmZzN0cjRjdGFPNzdCZGJ0dkZ0NDh1KzRoQnhtdlJOcGF5L0JhTjlK?=
 =?utf-8?B?Wk90emFFeFFQV3QyZVQvSUNQeWdXZFIvVDZUQ1FUUjdmNzNLQW9BSmZJdGV4?=
 =?utf-8?B?MUg5TGcwS1I4TDRDS2pEMVErdnZ3L3lsTnU5eVFJeWRiQkxqV21RMVRjQVhV?=
 =?utf-8?B?WlRTM2RJdGFBTmZKNDloRmZQUEJoT0JHbXcybjJTSE9OY1RBaEIyeTVpY0k5?=
 =?utf-8?B?UzlmSlM3T2dSZmZnUnNacFdmK3RuT3NWUzF2WTZrOC9ET1h3VkZWRnQ5ZFdh?=
 =?utf-8?B?c3pha01aNXRRS2pVV3hoNDhwT1I4NlBCRzM0S1ZxQytkaW9DdzN6TWl6MDNV?=
 =?utf-8?B?QWM4cEVOQWc4UGllRE1FL3pVbjhYZk9wNjhIQURaZzdNU3ZHZmkrVGVlTk5s?=
 =?utf-8?B?QlpXN1hyMzRUWTh6NEJVYk5lZzVRUVQ1TkowUjBIVzlnMUVPcGdaZFVnQ1F4?=
 =?utf-8?B?dVlhRHBSZGtVNUtETHVHS2kzZzVDd2RxbCtQY3QxWUxDUWVOOGZRUTZaNGl5?=
 =?utf-8?B?NGkwZUtOUGlvRUdDTnZsVmZ6UlN1dVhqaUdaa0FFZ2xHNkp4ZWVNVFVLc3cy?=
 =?utf-8?B?TUdMZGhMSy9BVjd4V3NOb2lkVld1cCtvL292ZkR4aHI4WFhtTHloVEFZUXJ1?=
 =?utf-8?B?MkpNNG1uRlN2NCt5RWtJUGZmaTJEbWQrK0h1YzdCN1J0emFhdm5XQlNlSyt4?=
 =?utf-8?B?TXJxL2RaeXM3V3g3d0pmeGFGenc2akVwTHByZkQ1ei9aa0cwR0cvWDBMc3BV?=
 =?utf-8?B?NTBueVNBLzJoSnhZNytSREg0ZXRkUzBlOVpGMGtxVHcycjA1MkZjckFjaHp0?=
 =?utf-8?B?KzFlNXZwRFUrNW4wL2kxKzVoamFsbTlwUFhnb2JPL3lkTFFjaXFZYS91Qncz?=
 =?utf-8?B?ZUNlbkV4SHQ2d1BtQXJQNEYzd3FNdTFqYXVSRHcxblo4VloydnhrU3FDUDNt?=
 =?utf-8?B?dWdvSXhqVnV6Mm5oaEV1QjJ0MHZLTlR5TzFMT2NoKzlZZ3hNVktIYmJZZDVK?=
 =?utf-8?B?UksxYkVmdWJCZTVmMkVYTGxBUU51Y09TS3lmOVFnN0ZEZU94akhlYVJML21x?=
 =?utf-8?B?NEcySmJHV3N1UGNmRG9wVWYyMG8yU0dlNSsvZnc2elcrMDQwZmwzL01GZjhE?=
 =?utf-8?B?ZVF2bTdjVTVJTldoVjMra3Zib2paZ0hQT2hreUZ5QzAzc1BOQ2pXcllRMlZy?=
 =?utf-8?B?Z2pPbEUzeFFGNTNPYjN2OEphWUlzeC9mNFZ1WVVrNkJWWnBBVHlQR3h1cWE4?=
 =?utf-8?B?RXpyR1RHWnhBQU5FSmlFMXgweW1WMUZibTYvWXBFYzJlelN3YzEwWlJFM2ZC?=
 =?utf-8?B?OG1nN2haVGQzTkNOV1h3SVVqMm1IWldqVm5tOVZVclQ4bFdmQURWUXFDYmVm?=
 =?utf-8?B?TEd2RjNQSmM0a2J4a1BXZ1N4eUJYN3lta3d4WktlbERxSEdFRUw1QXhDN2Z0?=
 =?utf-8?B?Y3VBdkQvU1VwN29lK3Z3S0VZWHgxY0w1c2xGVVMwTGYrdzMvc3dZM3FmVjRj?=
 =?utf-8?B?RjBOR1BUa1pwcThDMDdBclR6ZzA2U09XL1JFSDlNbTl0TC9sREpQckRKZWVo?=
 =?utf-8?B?QXlOQ0tEQkNuZ1YvWHl5TitUZTNBUW14YmNwSWVhbnBSVjQzV1FtUklNaDZF?=
 =?utf-8?B?MHUxd2tJakxVM0N1S1dnd2dNMXBTcVdmQ0pFME9wZ3VDRlhYRVV2dWxUbWJU?=
 =?utf-8?B?RE9taGxYcFhaejcrZTJOWXNSaDh1OEt0c1FnSzgwbGVVaWVjS1BGaDlYYStz?=
 =?utf-8?B?RXBMY3NBL2lXUzVndDlxSEc2SEk5OFhDSDNMV0VWTEQ3L3VTWDFySm9lMUxx?=
 =?utf-8?B?OXdXU1hDdEFsUkxhTGxuazhoYTRFenpJdXludWNKQ3dtMUlITjZzZ2NZUmJo?=
 =?utf-8?B?NGs3VDZBVEJsSTMveGZEUGl4V3RGUTFUUHhNY2RKQnJ1SER6amZlanI4WWNB?=
 =?utf-8?B?TFplYVZJSjB3SWRaSEt1aFZnNUh2ZUo4ajRrRnRYaVpPWXNtK29RMkpXUjM2?=
 =?utf-8?B?K0RHT0dKMWpEM1hwUFdQQjQxK2JKaHhBc040d3VReDh4WDd2Y2JFTHE1ells?=
 =?utf-8?B?VkpybGoxSS9MWjQ3dkJTMGh0UHBUL1BaT3N0NmRnSy9hMWtjcEtoUnNiWjVF?=
 =?utf-8?B?Mk1ENzFDbGFvejRWK2VQS3RPZDFWQ1BlSzdsc2I1cXkxUVVqZGsrTThLTTVL?=
 =?utf-8?B?TDVtelJ6MXphOW9UdHJtcFg2R1VGK3NDYTRHWE1lNHZLZzdOUzZuVFZPVnhK?=
 =?utf-8?B?aVY5Nm1NUUE2d3J6RzkydVhNTGdWUnJ0VlhGS2doTGhGbU5vK2lzdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c7aaa6-bc1f-4060-2199-08debb06a411
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:10:33.0916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4hh5x/WZWggWi223QqKqFIZV2XHRyBMz1qbl3ZMyRqPs9egxJLTmtpr/fkY0m0d/gq9gq9MHreq1Y92Xj1VGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=avihaih@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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


On 5/25/2026 6:15 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, May 24, 2026 at 09:58:57AM +0300, Avihai Horon wrote:
>> On 5/21/2026 6:20 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, May 21, 2026 at 04:53:54PM +0300, Avihai Horon wrote:
>>>> On 5/19/2026 11:09 PM, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Tue, May 05, 2026 at 11:14:09AM +0300, Avihai Horon wrote:
>>>>>> Performance tests were done by migrating a single VM with:
>>>>>> * 8 GB RAM
>>>>>> * 4 mlx5 VFIO devices:
>>>>>>      - One device with 1GB of device data (stopcopy data) that runs
>>>>>>        workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
>>>>>>        (generate new initial_bytes chunks during precopy).
>>>>> Could you elaborate a bit more on what workload is executed, and how that
>>>>> will affect REINIT reportings (e.g. is only one REINIT generated, or it
>>>>> keeps generating)?
>>>> Basically, I create and destroy RDMA resources (MRs, QPs, CQs, etc.) on the
>>>> VFIO device in a loop for several iterations.
>>>> This generates several REINITs.
>>>>
>>>>> Can I understand it in this way: without REINIT, device is forced to put
>>>>> those data into stopcopy size; then with REINIT, some stopcopy size is
>>>>> essentially moved back to precopy phase?
>>>> Almost:
>>>> Without REINIT, the device is forced to put this data in precopy
>>>> dirty_bytes.
>>>> With REINIT, this data can be put in precopy init_bytes (and do the
>>>> switchover-ack dance again).
>>> Hmm, then I don't understand why moving some chunk of data from
>>> precopy_bytes to init_bytes helps downtime.
>>>
>>> Essentially, QEMU makes the switchover decision based on the math of:
>>>
>>>      init+dirty+stop
>>>      --------------- <= downtime_limit
>>>            bw
>>>
>>> The possible min of above is:
>>>
>>>           stop
>>>      ---------------
>>>            bw
>>>
>>> Here whether some data would be in init or precopy portion shouldn't matter
>>> for a min downtime, since both portions are allowed to be moved during
>>> precopy phase.
>>>
>>> OTOH, if stop_bytes unchanged, min downtime is still the same before /
>>> after supporting REINIT, if we try harder.
>>>
>>> Say, with below testing results:
>>>
>>> With VFIO_PRECOPY_INFO_REINIT:
>>>     1335ms total (~520ms from the VFIO device running the workload).
>>>
>>> Without VFIO_PRECOPY_INFO_REINIT:
>>>     2352ms total (~1600ms from the VFIO device running the workload).
>>>
>>> What is the downtime_limit you specified for both cases?  Have you tried to
>>> specify lower downtime_limit than what you specified, so that both results
>>> will become even closer (until they become, statistically, identical)?
>>>
>>> In general, I can understand the REINIT will stop converging too early, but
>>> it'll be the same IIUC just to turn the downtime_limit smaller..  IOW, I
>>> may still miss some important piece of info that how this REINIT feature
>>> helps downtime..
>> The init_bytes are special in the sense that it's crucial that they are
>> transferred before switching over. Otherwise, VFIO precopy may not have full
>> effect which could make VFIO migration slower.
>> Accordingly, their contribution to downtime may not be just the time it
>> takes to transfer them.
>>
>> Specifically for mlx5, init_bytes hold a small portion of metadata used for
>> time consuming pre-allocations on destination side. So, we may have 10MB of
>> init_bytes which would take a fraction of a second to transfer, but once
>> reached destination, it could take even a few seconds to load them.
>>
>> When moving this data from dirty_bytes to init_bytes along with
>> switchover-ack, we guarantee that this long pre-allocation doesn't happen
>> during downtime. This is the time difference you see in the test results.
> I see, yes that's what I missed and this makes a lot sense, thanks.
>
> Could you put above example into some vfio.rst doc when repost, when
> describing REINIT feature?

Yes, sure.
I will extend the section discussing switchover-ack in 
docs/devel/migration/vfio.rst.

Thanks.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ABAEF4ECA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9iXQ-00040p-EG; Mon, 06 Apr 2026 07:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9iXK-0003sN-TS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:54:35 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9iXI-0002jq-8c
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juvBXijURfYJkWF89SSK30uZzyKsJmKplCsobZGLek8xk87BVDD8H/BHVG/30HMI0nIzbLGOAGA7n55MQDPdcgCdpcq/TlAgiujlDzg+4JqvmYHQwaCum75HK2r2ZIUXoRo9NqWNDLguDyP2eMR7zWeYNBOAcDPimiNC7ABgxPdgtSKjkTy/DzDOHCMB1pCP9cwPAlJqvdjSXRB7mTN3NwOJ7KXLxjf7w0RqcHBC48fOZTHdlVHVjHGPVhyIkUY7I2u9MdZrsghiSV1L5H2x2RUb08nRC+n7DzqvCnxacs+HGxjG2AO7k1lnFC+KQ9okswqfB7LnUfpqvksNu5O6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hLSxAi6HR1AATMXDfiifF5/ZaIBdQs44OhZbZTF3Ls=;
 b=f6BC+Ln2jnwoOdrkcQJYDLj4SVqTpKAL/7c/ENeqYlnV/ABtAE1GYLh4vwijZHiEZ9sdkw8cryw5VK2o9KhvAx3y3nsOjSWcm2wH3AUCq2ooJluwj2KW0rg9GwI1Vy9iiigI3vAI9pxhNUN7eK/ewuSK6RfUjlCbO6JUWF23NzLZQYDz23TwIcpOCUUyhAlgSSgE+REb7tOlB6494Kh90qYimza4c6rtRHdeQIi4ZhRHr7XV+d3FfIpLasNHV34gdSSwLJe3PTDEGTbFO77PbNWRAM3YQn260+09N6KBctU5Ftkm8KsXNtf5rPZtI9yIafIhNRXdhvmb4YTn5ul/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hLSxAi6HR1AATMXDfiifF5/ZaIBdQs44OhZbZTF3Ls=;
 b=QdSaMLcxYE9em9rYQNGqxsdOoLxWdeUJ25Jx/KxmuariYganD/9Lt/iCIva0pgoL1rgRw14ViD5TAE/KJZpsUbCY16W2uH9UjFcAHe/V4u0Xs4Y3VNlo6jRazqFy9+UKxoDgX40MgMwEAlOuhdcyeRWlEDBvWzcVIwhf5Use1lSGi+NS4oAdOztjf5ahyzlgtLLjHTgXowe5ga7ECiMlvz8WFPx9HYRU33hw1OI50zKn2kvg8MXYgFxTQRdiGrlyWtD8h3sFRW2tgnOoc74Kg9br9meq81vA+wFyIE5EELYL3V1vUX0QYQSuiVi1FSI742hJylkIgePzSv93pZ6Msg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 11:54:25 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 11:54:25 +0000
Message-ID: <84a7f6bc-99c3-469d-abb5-b5e05697325d@nvidia.com>
Date: Mon, 6 Apr 2026 14:54:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/12] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-6-peterx@redhat.com>
 <b957ae39-12e0-40d2-b0b3-8f09bff10bf0@nvidia.com> <ac2MitFie3jXyiRk@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ac2MitFie3jXyiRk@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 821e8317-44ba-408e-676e-08de93d33fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xRMRJhD+Q/fzaZH5fuwurwEY8TJP9OjSbiSnChUQJvdfujLl0U5BYnPjV7JRkG6Dt9O9qOehHHn3qI7Zu5DU4mRxxgN40xTp2v50dwme3sbxqhoO3Iskz+zan2HXJ0pR4k3TvSoCOjSlZWNW6GFl7d8Zi/6CpZt/6TwgW6dtwTKPogR2S+MkmNHCg5wENVzqjZ6bFI4uj400J/qHMKSb+rrLNPFWTwdD1eJeEEO78jcRhdipUq5xpB+tqhiQL6Yr1G+SQdisVZkugeTVlsq9P/RBAXTgQiM1c6Be1cg4AUhlboTVzKuihVx9mYMomXykshmFdQRk0bnPwzWflBYj8nQiMe3bxtriQhxsoFq+INcsxyaRLcNJhUP1D56IaB9lCS0jZaNhU44GpVUebBbJQnPMcksJf/h7u3oJsTjYbNYHk/Cl29S4V2L1Tc1ZbKXRtm27VeG/YvMVIqY+1OD1HsLFUf9HANPwVJmBSX9iDRjKoMhK5YAnE29yKhlxAI82BU2Q/QC7Eyx668j0nQfo8bVxDSvnjAKxE3sFkA7/BdArE/SdAi8GY8B/50E7gcan1Q+x6pa6ofILOMJhvlC5wDwSpdrtfY22b4nGaL6NIe1ATkakHpzzDbUhRQ5c5tb73Zg8ncLRMnN3hE6Vl3tTNpRXV0nrOr6TjPJ7csaSB1kIYdZiU8juwdWXD9BcIE3NGJdRQjkT1hr4TQPBg0ldAQwl/2XpJ4KPHPQ+jgfrhCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3cxWnlFNnpJcnp5MGlZREpHOVNWT21SSmpZTWtiWXZHQ29aZGt4OXJIaVZS?=
 =?utf-8?B?dlVaMDluWm5ubnJzL2VROEVNK3JKNmRidkQwL0FXU2REZ0ZYS1ZNc1BCS3No?=
 =?utf-8?B?aXo1VFpjdE5jeFJ0a09qNEFaakQ1OTBlNUJ1QnNBRVE0Rk1SS3NNT21BNllw?=
 =?utf-8?B?dmhlZ0ZaejlpeW9MZDlrcDBNMDJ3LzhUS2I4bGoyQnE2UEpCMDh2RVhJWFox?=
 =?utf-8?B?TmhCeERDOG1veFZuVTlScFArK1lWbUJ3MWtKd2NDc3lLYXdFd05ldEw0b2xL?=
 =?utf-8?B?ZnE2Y25oUzl2UVVsTHJnTFlJQmlSMzFhOHNPc1hMMGlPSXNZQXlJZmRVenBP?=
 =?utf-8?B?Nk9UamxhdFlmQmtidG5xc0tHUHFiU1ZxaXRvSFM1MU8rMmNDdHdML1Vtc0pZ?=
 =?utf-8?B?M3U3OXlZdjJDZUJ4Qzhndmg0SGZwaFFMZVl4cXRvNmxRN1gwL2d4alB4S0hr?=
 =?utf-8?B?T09nQ0NtRy8rYlFaMmhHQzgySTNyWFBWbjdjdy94aHpjYmZOZGFRbENqWVBG?=
 =?utf-8?B?SVFtWGdkdWpnNTA3SjAvek8wdk9XSkNQSzg5cUZ0cGVvK1c4M1JMeVBkdXFD?=
 =?utf-8?B?ODRPNUh0dXdkTzRUOXliTmNGeGw2VXFCNm8raGptOWN5RklNdTJmcXVJOW1W?=
 =?utf-8?B?Nm5oV3FUeGtJMnZuVGRFQUdVYStHb3FhN0I4ZEgzcGxJejYzRHZHczlrdkQr?=
 =?utf-8?B?OGd1VDlVVjFtL3lyZ1poWHVwWjd3QVFOV09hZUhpdENvcXB0RVZYekxOb2N3?=
 =?utf-8?B?K2ZSOVhLRngvTVRvUVVJYUhLaEhsWitETE1BRElWMHU2TEZESG15dVJ4K0F0?=
 =?utf-8?B?Vmdxc3FhRitQalNpdmFma2lHQ0s0KzdpdWxBQjViamhRTnF3c2FwUVZ1SEZN?=
 =?utf-8?B?eFdyNEw3cU02OHVjVCsyS0Y1ZmdqbTZENlhBV2tobmpNZkJ5QTR6WDFtc1BD?=
 =?utf-8?B?TE9Mc1dKS0VJREdWLzE2MzU5NkxDZ0tCSVBCL2F3bzNkZkhVaFpndmFuNmd1?=
 =?utf-8?B?T1ZBbFdmaGNvYStEVnF6b0llc0phSS9WRytZUDJzQXhNaDlFQ2kvU2JmVXo3?=
 =?utf-8?B?N25WQk5sUS90T3Z0amc5cTBSeEVwK3p1R3RQZi9OekFKdFUyeWN2RVBoT1NB?=
 =?utf-8?B?UzcveCtLaElCVkFNeEViR09IeUN5MlI0K1hJREMxRmNoV213eDNBQzVzL2pn?=
 =?utf-8?B?eGZWWUNvbGZKQjIzNDBnbEZzREUzUk44QmV2Y1I5VzNmOTVseXlJUVJjcURm?=
 =?utf-8?B?bDNaaVp3N1kwYnhhRDNFTDhUV3VHVEpIQy9qeU81R3RrQVdGVkpsdXQ1eHpo?=
 =?utf-8?B?Wm1WMGtFY2Z6U1FoRFJMQnkwS2RJVUdEUE5tdVR0ZjFPYVVSeFkxT29JaU9j?=
 =?utf-8?B?Z3pORFRJb1U4ZnRXSy9nUjdPMDYyWXVpNU5lcDNOd0F5UnRxRHF4UUxCVUFk?=
 =?utf-8?B?Nzd5M2RtdkhkeFIxSFI5VDFPd1BjMGNOc1lMRXZ4NG1WK3dvWTNmUHZCMUlO?=
 =?utf-8?B?L2dBOVk3WkpwVGlLaWtRNGFuVWlEeGhzSUdYN1B2Q2d0QnI0THdFVHdMZGFC?=
 =?utf-8?B?dnF1Nm11Z2hZblhJRWtKQi90MUE5d05lOWpoTlZkb3M5VzhQUWgzUm5LK2FH?=
 =?utf-8?B?WS9OVlByb0VFbFdiRDhKSmQ2OVpiZUJES21QNE4zYklGZk44N3FxREV3K2Fk?=
 =?utf-8?B?REYxK1NzSlJTNmw2bzRHOS9KaU5XRGxUSlRnY01qNGJZQXphOWdiS014UjdC?=
 =?utf-8?B?QlBmL3M0N2VnTU9NcTBZVkkwUHpjV08yeW9jNGFoOFIrMGhsVGQzdUVST0E2?=
 =?utf-8?B?NENIVG9GaG04eTRnQlpMdUh1aEx3a2J1NW55eXViRnRERW1IbnVXVDM3clo3?=
 =?utf-8?B?WGEzMFRaL2lsQ0VwWFJhcmprdVpGN3hkc3FjR2hZaHBMd2ZEL3BMV0o5Mk9i?=
 =?utf-8?B?SWNJOWpNbnFiVGdnWVM3QnhjeVVZWlQ5akNVblREQk1jdk5TU1lPN0tHa3pM?=
 =?utf-8?B?S0l6Mkc4ZUJyQ2ZIRjhUU0phQ2tJZy80TUE2TnBFVk56czhyUDNva1NuSkJX?=
 =?utf-8?B?UHBCL1JEVVI2SmpiY3VtRExETHJvd2R0YlloR0xlM3F5dithSzRNVE1nR25B?=
 =?utf-8?B?UFVBOGNCVUFrYnpVQkFneVMyT2phOXowdVEvdHJ4NzVxUnltaysyZEpjWjR6?=
 =?utf-8?B?OTNId0RoZkVIenZZbjdXaGx5S09IZWJua1IzS3FCYmVMMFVlZG1qY1JWejA3?=
 =?utf-8?B?Y0ZpZlpLWkdMdUtVMXBROWdwVzEvd0trWXI3aDMxRDh0clc3bGVMY3FkK3Vs?=
 =?utf-8?B?SHdtdnRwZ3ppc2dlMENsM245RXp5dWFCdTdYR2x5cllpbERaNnAwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e8317-44ba-408e-676e-08de93d33fd8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 11:54:25.4063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYxwDXCgscRUyeRfowWrnOUsu9J1rVH3alv5m/WZpXjsxWVTgf1x/rgbQgQDH5Pu5xuwHWs9UfSM584xpe4VJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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


On 4/2/2026 12:22 AM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Mar 25, 2026 at 05:20:41PM +0200, Avihai Horon wrote:
>> On 3/20/2026 1:12 AM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> These two APIs are a slight duplication.  For example, there're a few users
>>> that directly pass in the same function.
>>>
>>> It might also be slightly error prone to provide two hooks, so that it's
>>> easier to happen that one module report different things via the two
>>> hooks. In reality they should always report the same thing, only about
>>> whether we should use a fast-path when the slow path might be too slow, and
>>> even if we need to pay with some less accuracy.
>>>
>>> Let's just merge it into one API, but instead provide a bool showing if the
>>> query is a fast query or not.
>>>
>>> No functional change intended.
>>>
>>> Export qemu_savevm_query_pending().  We should likely directly use the new
>>> API here provided when there're new users to do the query.  This will
>>> happen very soon.
>>>
>>> Cc: Halil Pasic <pasic@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Cc: Jason Herne <jjherne@linux.ibm.com>
>>> Cc: Eric Farman <farman@linux.ibm.com>
>>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Cornelia Huck <cohuck@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    docs/devel/migration/main.rst  |  5 ++-
>>>    docs/devel/migration/vfio.rst  |  9 ++----
>>>    include/migration/register.h   | 52 ++++++++++--------------------
>>>    migration/savevm.h             |  3 ++
>>>    hw/s390x/s390-stattrib.c       |  8 ++---
>>>    hw/vfio/migration.c            | 58 +++++++++++++++++++---------------
>>>    migration/block-dirty-bitmap.c |  9 ++----
>>>    migration/ram.c                | 32 ++++++-------------
>>>    migration/savevm.c             | 43 ++++++++++++-------------
>>>    hw/vfio/trace-events           |  3 +-
>>>    10 files changed, 93 insertions(+), 129 deletions(-)
>>>
>>> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
>>> index 234d280249..22c5910d5c 100644
>>> --- a/docs/devel/migration/main.rst
>>> +++ b/docs/devel/migration/main.rst
>>> @@ -519,9 +519,8 @@ An iterative device must provide:
>>>        data we must save.  The core migration code will use this to
>>>        determine when to pause the CPUs and complete the migration.
>> We should also remove the state_pending_exact section above.
> Ah yes, will do.
>
>>> -  - A ``state_pending_estimate`` function that indicates how much more
>>> -    data we must save.  When the estimated amount is smaller than the
>>> -    threshold, we call ``state_pending_exact``.
>>> +  - A ``save_query_pending`` function that indicates how much more
>>> +    data we must save.
>>>
>>>      - A ``save_live_iterate`` function should send a chunk of data until
>>>        the point that stream bandwidth limits tell it to stop.  Each call
>>> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
>>> index 0790e5031d..33768c877c 100644
>>> --- a/docs/devel/migration/vfio.rst
>>> +++ b/docs/devel/migration/vfio.rst
>>> @@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
>>>    * A ``load_setup`` function that sets the VFIO device on the destination in
>>>      _RESUMING state.
>>>
>>> -* A ``state_pending_estimate`` function that reports an estimate of the
>>> -  remaining pre-copy data that the vendor driver has yet to save for the VFIO
>>> -  device.
>>> -
>>> -* A ``state_pending_exact`` function that reads pending_bytes from the vendor
>>> -  driver, which indicates the amount of data that the vendor driver has yet to
>>> -  save for the VFIO device.
>>> +* A ``save_query_pending`` function that reports the remaining pre-copy
>>> +  data that the vendor driver has yet to save for the VFIO device.
>>>
>>>    * An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
>>>      active only when the VFIO device is in pre-copy states.
>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>> index d0f37f5f43..2320c3a981 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -16,6 +16,15 @@
>>>
>>>    #include "hw/core/vmstate-if.h"
>>>
>>> +typedef struct MigPendingData {
>>> +    /* How many bytes are pending for precopy / stopcopy? */
>>> +    uint64_t precopy_bytes;
>>> +    /* How many bytes are pending that can be transferred in postcopy? */
>>> +    uint64_t postcopy_bytes;
>>> +    /* Is this a fastpath query (which can be inaccurate)? */
>>> +    bool fastpath;
>>> +} MigPendingData ;
>> Extra space before semicolon.
> Fixed.
>
>>> +
>>>    /**
>>>     * struct SaveVMHandlers: handler structure to finely control
>>>     * migration of complex subsystems and devices, such as RAM, block and
>>> @@ -197,46 +206,17 @@ typedef struct SaveVMHandlers {
>>>        bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>>>
>>>        /**
>>> -     * @state_pending_estimate
>>> -     *
>>> -     * This estimates the remaining data to transfer
>>> -     *
>>> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
>>> -     * pending data.
>>> -     *
>>> -     * @opaque: data pointer passed to register_savevm_live()
>>> -     * @must_precopy: amount of data that must be migrated in precopy
>>> -     *                or in stopped state, i.e. that must be migrated
>>> -     *                before target start.
>>> -     * @can_postcopy: amount of data that can be migrated in postcopy
>>> -     *                or in stopped state, i.e. after target start.
>>> -     *                Some can also be migrated during precopy (RAM).
>>> -     *                Some must be migrated after source stops
>>> -     *                (block-dirty-bitmap)
>>> -     */
>>> -    void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
>>> -                                   uint64_t *can_postcopy);
>>> -
>>> -    /**
>>> -     * @state_pending_exact
>>> -     *
>>> -     * This calculates the exact remaining data to transfer
>>> +     * @save_query_pending
>>>         *
>>> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
>>> -     * pending data.
>>> +     * This estimates the remaining data to transfer on the source side.
>>> +     * It's highly suggested that the module should implement both fastpath
>>> +     * and slowpath version of it when it can be slow (for more information
>>> +     * please check pending->fastpath field).
>>>         *
>>>         * @opaque: data pointer passed to register_savevm_live()
>>> -     * @must_precopy: amount of data that must be migrated in precopy
>>> -     *                or in stopped state, i.e. that must be migrated
>>> -     *                before target start.
>>> -     * @can_postcopy: amount of data that can be migrated in postcopy
>>> -     *                or in stopped state, i.e. after target start.
>>> -     *                Some can also be migrated during precopy (RAM).
>>> -     *                Some must be migrated after source stops
>>> -     *                (block-dirty-bitmap)
>>> +     * @pending: pointer to a MigPendingData struct
>>>         */
>>> -    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>>> -                                uint64_t *can_postcopy);
>>> +    void (*save_query_pending)(void *opaque, MigPendingData *pending);
>>>
>>>        /**
>>>         * @load_state
>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>> index b3d1e8a13c..b116933bce 100644
>>> --- a/migration/savevm.h
>>> +++ b/migration/savevm.h
>>> @@ -14,6 +14,8 @@
>>>    #ifndef MIGRATION_SAVEVM_H
>>>    #define MIGRATION_SAVEVM_H
>>>
>>> +#include "migration/register.h"
>>> +
>>>    #define QEMU_VM_FILE_MAGIC           0x5145564d
>>>    #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
>>>    #define QEMU_VM_FILE_VERSION         0x00000003
>>> @@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>>>    void qemu_savevm_state_cleanup(void);
>>>    void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>>    int qemu_savevm_state_complete_precopy(MigrationState *s);
>>> +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
>>>    void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>>>                                         uint64_t *can_postcopy);
>>>    void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>>> index d808ece3b9..b1ec51c77a 100644
>>> --- a/hw/s390x/s390-stattrib.c
>>> +++ b/hw/s390x/s390-stattrib.c
>>> @@ -187,15 +187,14 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>        return 0;
>>>    }
>>>
>>> -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
>>> -                               uint64_t *can_postcopy)
>>> +static void cmma_state_pending(void *opaque, MigPendingData *pending)
>>>    {
>>>        S390StAttribState *sas = S390_STATTRIB(opaque);
>>>        S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>>        long long res = sac->get_dirtycount(sas);
>>>
>>>        if (res >= 0) {
>>> -        *must_precopy += res;
>>> +        pending->precopy_bytes += res;
>>>        }
>>>    }
>>>
>>> @@ -340,8 +339,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
>>>        .save_setup = cmma_save_setup,
>>>        .save_live_iterate = cmma_save_iterate,
>>>        .save_complete = cmma_save_complete,
>>> -    .state_pending_exact = cmma_state_pending,
>>> -    .state_pending_estimate = cmma_state_pending,
>>> +    .save_query_pending = cmma_state_pending,
>>>        .save_cleanup = cmma_save_cleanup,
>>>        .load_state = cmma_load,
>>>        .is_active = cmma_active,
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 827d3ded63..c054c749b0 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -570,42 +570,51 @@ static void vfio_save_cleanup(void *opaque)
>>>        trace_vfio_save_cleanup(vbasedev->name);
>>>    }
>>>
>>> -static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
>>> -                                        uint64_t *can_postcopy)
>>> +static void vfio_state_pending_sync(VFIODevice *vbasedev)
>>>    {
>>> -    VFIODevice *vbasedev = opaque;
>>>        VFIOMigration *migration = vbasedev->migration;
>>>
>>> -    if (!vfio_device_state_is_precopy(vbasedev)) {
>>> -        return;
>>> -    }
>>> +    vfio_query_stop_copy_size(vbasedev);
>>>
>>> -    *must_precopy +=
>>> -        migration->precopy_init_size + migration->precopy_dirty_size;
>>> +    if (vfio_device_state_is_precopy(vbasedev)) {
>>> +        vfio_query_precopy_size(migration);
>>> +    }
>>>
>>> -    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
>>> -                                      *can_postcopy,
>>> -                                      migration->precopy_init_size,
>>> -                                      migration->precopy_dirty_size);
>>> +    /*
>>> +     * In all cases, all PRECOPY data should be no more than STOPCOPY data.
>>> +     * Otherwise we have a problem.  So far, only dump some errors.
>>> +     */
>> I'm not sure that must be true, as stopcopy and precopy queries are not
>> atomic, so device state size can change between the queries.
> I believe I wrote this only based on my (proven wrong) understanding of
> stopcopy size, which I thought was an upper bound. It looks not..  If so,
> yes, atomicity will be a problem..

I think you can view it as an upper bound, in the sense that if you 
issue VFIO_DEVICE_FEATURE_MIG_DATA_SIZE and VFIO_MIG_GET_PRECOPY_INFO 
ioctls in the exact same time you should see stopcopy size >= precopy 
size. But here it's not the case, because they are not called in the 
same time.

> Is below all the doc I can find regarding to this ioctl?  vfio.h has:
>
> /*
>   * Upon VFIO_DEVICE_FEATURE_GET read back the estimated data length that will
>   * be required to complete stop copy.
>   *
>   * Note: Can be called on each device state.
>   */
>
> struct vfio_device_feature_mig_data_size {
>          __aligned_u64 stop_copy_length;
> };
>
> #define VFIO_DEVICE_FEATURE_MIG_DATA_SIZE 9
>
> I understand all driver authors want to be flexible, but I wonder if I'm
> the only person keep getting confused by the VFIO migration API on
> providing estimated results all over the places, and it'll be definitely
> more confusing if it can shrink.  We can leave this part of discussion in
> the other thread.
>
> I don't think this check is a must; I can simply remove it, however please
> help me to understand better on this interface.

Yes, that's all the docs.
Nothing much to add, as they say, it returns an estimate of the amount 
of data remaining to complete the migration for the VFIO device.
IIRC, it was introduced as a complementary for VFIO_MIG_GET_PRECOPY_INFO 
because not all VFIO devices support precopy or have all their data 
precopy-able.

>
> Another note is that the goal of this series is to provide any way so the
> mgmt can query pending information when VFIO is involved during migration.
>
> This series only exposed (hopefully, much more accurate) expected_downtime.
>
> When repost, I plan to add a system-wise remaining data field so the mgmt
> can fetch for each of the iterations to predict any possible unconvergence,
> for example, query remaining data and if it stops shrinking for a while it
> is a simple sign of possible not converging.  It means either downtime
> needs adjustments or something else (cancellation is also an option).
>
> Avihai, if you think this goal will also be part of what you or your team
> will be looking for, please let me know.  I am always open if you or
> someone from your team thinks it easier to take this over as you know
> better on this area.  Otherwise I'll respin after I figure out the rest
> puzzles with your help.

I think this series is good, just need to sort out the subtle VFIO parts.

Thanks.



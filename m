Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4393DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 10:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdmMj-00051z-5l; Sun, 28 Jun 2026 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wdmMR-000510-DY
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 06:03:37 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wdmMO-0007an-3O
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 06:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVYRbzO/0YF+crcAIglt9j9Td6er51dTmk1gdl74g/eXeYiPpAWGBdk0kGwe42STcwV5N7FngJbHRe9lZxYMILodikqOGvGQCk6BtuIxWvSfEhqEmFkTqaynjbGCX+ms1gE8KE0z8DqaVjjjZfLcHr4w16DVbT1zmiAymypbvqjZm7nAJXgxcRVDWR8LNs+k/aaDa3i4sVBY8VyIkLu2CTVLp4OzVnoCBV6qs78G14kflYwVC1Kh8YWTE+nYCtzZ46K6NlFx1cXo3e+pHfnj7C81nRWmCMNnLpnt7bgPBFQCmqe9lWqjhN7rPkr6i2ww3AME8lxJZHahgZQrREVqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tjr6qUW7jOn0C75+3QyaV+kNOmReyVdpt+7wLC9uO4=;
 b=vOf/kFJBVlP7AoZfIOFR44UbockN3u1CvVCYFTksRqkALxN/OJ8OVzI6HMAlQeOaMZFig/OQtUGvyQwEC4VV8H2KJ0dsNRUIwzqJZRLl9AwmBVUhgxZtxhPL2S6JwBMpCphHeCezBW6T5CjW92xsXgE7A/xXBGAF8ECgXEHfTJiqsydfgjkAaxma4P7adhLg8aKgRvc1k79aKbC6waINA4b5WF8CeFBLwTcq4U3SO4ze/n3IuvelFvCfJlwSnKhYntCRevEjOZ5p1CJB30NTlt0vkANUJA/IPizK8JRwfA7m/A1J2gzDIAVt3CcEe4iP9Jy9NNkvVUf3y+B5SGk3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tjr6qUW7jOn0C75+3QyaV+kNOmReyVdpt+7wLC9uO4=;
 b=SIRKU/7b2k+GD9eZEIyze/RUEnIb7hz8HWNSArTNEroVuxdM0M70Yn7hSgkV3NWhU/DAx6y0hEqprrCeYe9kklNeenSCdM0Hw1QUgWRBDxjWR2w0PeMfxJ7Vt6UI80xhB4Aki9JIy3q+/9SfkMhR2tfg68c0+jO3AadCwoUH/n96cwRxoULWB8LcTsbkeE4tnRvbos7UL2mqTHnmtih35WEZGOXgafPRwV0HfC3Q2HI1f7IZ4EXB23KLcxFr4ExWTQOoj7ILaHZP+7fZP0fpA7MJ7xQIFTCOI4JTPwmnTP5+TnjAJtJNhg7OeD75LHJGKSBngUqSxxC2YMSOF5fGtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 28 Jun
 2026 10:03:25 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0159.015; Sun, 28 Jun 2026
 10:03:25 +0000
Message-ID: <675f8d2f-ca22-4b04-bc30-8fa7b6d3a6dd@nvidia.com>
Date: Sun, 28 Jun 2026 13:03:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
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
 <b997b3f7-0a95-4c21-bf18-c19bf8754936@nvidia.com>
 <9fa2038d-f75b-4d6a-a2fc-1bc871878b74@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9fa2038d-f75b-4d6a-a2fc-1bc871878b74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3733bef5-4eb6-41f1-60b7-08ded4fc7e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TfsvcnVw5JPvxuaZVhmiT9QdCnXm/dQ/gb2k2Kq3qAxMqp0qGc38Xt1itI5J1+brZ6nhwS441COp1OC6LMljjJiIityTetglpcq0Gsoy6MK6prUtSBzmFgQKowVppoUudBtKZ0hShK43TXpq1v0cLMhfevrDQHkkaAEXEnN4yBwDxOX8A41aq2+XJrAkrYgn6cbzb3jcAQnXWlMob7QiSp2+2sT39IKefmuiPXUdl6ihyU8ooiZ2Q1DvXfIMwWoUR82jOAwpBRp8QsSz7nbN4NhYaHPIniTkc/7h5x53rzqUxMPjqJamJ6BJSo0fy4JOFZ+6WK0rbYzb8KuIHKb0JH2Hu+UggYwmnxtHq0wXIvfGAobecailzWIjmcD44hOl0A1jFdGOJi23kbjYwqYIFTffwKf+KU60FnWddWNU9OL0oZ4RzmEdj9O0t1yV9A0EauEgN0FBMHNF2VhEAWxAGkDq7uetB+7kuOJPaA2IH63JqR8sk9oXo+3z68zKYdscfpicUzgXlRDv67Z/TUZrkP7At3ThGMRGGnqDga+fziBfGCkJ/pbWiVFNxD9Xaua9r1qmS95trTLWdZp3kIiD6KUbrn0cWK4Kd02apKUCKVjW8XvIJnvd48qT4UjdtJCYVOZGShwnm9WMq1/WA6a7+XrpK1s41JlXra/LXiFAaBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZTUEQzV2wxc2Z4aUFEMTFpc1BFTG14c2F1QjJrNDFJL2p2cWkvN2YwRWtx?=
 =?utf-8?B?RlI5YXdReE1QdWNVUnZxVU9SejdFVWFRaEFHNjl6SmRkYnpGSHc1N0VmR255?=
 =?utf-8?B?bDBFNTRCaCswWjNYNDQvWUVGS3NsRUt5WWhQeC9KOXhRakl5blBUOE9rODI0?=
 =?utf-8?B?RFpUOFVSSXY4THV1YXk1VUlqTlgweFlhMHErVVhYYkVxWDJUMmdiY0lyOGZ4?=
 =?utf-8?B?eHhuZDR5OFZ3eWEweERPcG44cmlOeGFQZDdYTWNKN3dJRDhOK3JOUVpIUUJF?=
 =?utf-8?B?bC9qUjRhczc4SnE4TDNIVDl6QjVkMlIzQXhud3g1NTgycUU4NXp5MWlwTFVz?=
 =?utf-8?B?eVB0dUdocnFiTWZFOGQrWVFNZ2J5LzhJc3kyKytITGhoS3h3ZjJ3ODM5OHBP?=
 =?utf-8?B?U0pqWHhKTm9NUUtpVzdneU14NHJ1VkZlSXlveUlBN21oRkRNbkl6NUJxVE5p?=
 =?utf-8?B?RENKbmtxbzVRaGNpVy85ZGpCVWJZS0tUKzVudVFjYk5vT1llM09TY1FMMWlE?=
 =?utf-8?B?OHpoWldFOFNRMWFuNGZNOHNvdkY0Z3NURW83TFFhY1RDYWlXc3l1K0Mzd245?=
 =?utf-8?B?L09lYWxGVnNOT3hHaVVYVWxwZmZFWVM4eW8yRkNERi80Z1hWZndVd1FRTkto?=
 =?utf-8?B?U1dvRWZuRG1TY1Evck5sWmhVSlFTZXcxblhCb3pDaEYvM2lTQU1SYjRDMUUx?=
 =?utf-8?B?R2Q5aUhXOHNrVFVvUU5nQnZIUGx5RGhWRFlDSXlHYmRTMVVCd3ZkTjF0MHQx?=
 =?utf-8?B?K3BFVGhYV3cwODdlS0RTcnU3M0ZrUzJFSURzUXVKOXhZZ3BOT0RuR2ZTRHR2?=
 =?utf-8?B?TkVHYVVSZjdOSmpsczg4cm10STdGc2dQdTI0bnkvbXhvUUNobTdUaUdRRXEx?=
 =?utf-8?B?VjlQdG9XZDN1NEJ0VmpXbHNUdDJ3R3BkdXZITDZ5YmZOMXhvNmhqZGh2VC9t?=
 =?utf-8?B?R25tWlMzVjVnVDhaa2h6TDJRbGdaTXpVeEo4TkRSNnRyMHlKem9hay82TlVm?=
 =?utf-8?B?bDBwRW8vMEh0V2RZSnVtUzVHZUc0cVFEak9OTnA4bUx5eFdubkdkODBpd0wz?=
 =?utf-8?B?c2crdWxsOW4zKzhlci9CektXTmpLcDZwRDYwcEhxUTNIQlJvVkxBTnlEYlZp?=
 =?utf-8?B?alljTHNiT1NPU05UWWdKWmxOWmVQMTVxQ1J5Y29QMHlIR3ZSMjBBK2d3VzEr?=
 =?utf-8?B?YlVLZXVlVitSdkh6Y3d1WVMrV0M3SzVidld1UnVFTHVMUER3M2lkMFEwZUc1?=
 =?utf-8?B?czREdnE4b2JqY2xWclJPVWNhbGFaTHIwU2htYllJUjhleTVxNmhtc3cvVFdn?=
 =?utf-8?B?aWpsVnhRM2Z4UkdieDlNNGVoNVZmMkZaaWd4OGVpYlkvQ2dQSnZ1YU1QcWRO?=
 =?utf-8?B?d0FvUjVaR1RPY1hZY2YvRnpIY0RGNWQzZmJSWHhFdFMrK01lb1RCY2MwZkRj?=
 =?utf-8?B?aTExd2V0aGhNeXg5amYwRStqQkFnc2t0bkFVYnkxU01GZXE5K1Y1WVcwRFFo?=
 =?utf-8?B?RFZHdUk4eHp5aURaNmpIb1poRERMMHI2TnF3WHkzN1pZeUExYmFLdllYOGVK?=
 =?utf-8?B?OFoyc09wK2xDVm5MOWQ3YTJJdCtFRnphL0c2KzRTNTE5aDBFT0x3aHJiNk1Y?=
 =?utf-8?B?cmdiS2tpc2lUNFpkODZpZGxPMG14emgyeHVwTXdmdVM2WFVKckx1Y04vb3BG?=
 =?utf-8?B?VGU3Nkk0ZG5TcmJ6bjg3bEdlMVNzUWNDdllzNGNWMjNJRUEzQlBqdjI2QVZq?=
 =?utf-8?B?cHJYYzhSdVRjY24ra3V2K3hubzF1Z0dQbEtneEs1WVFYQ1lUZDdscU9WSGF5?=
 =?utf-8?B?bUJ2VTQycUkwUTJCeWcrSTRaWTZXbTFYNThJdk1SeFRVTnhBL3BuMi9TbFpN?=
 =?utf-8?B?UXA5ajNMSWZNZjgxa1Z2aG9veW9VSTdSUFZMcmpWWkV0RmMrQXZSTVd0blQ0?=
 =?utf-8?B?R256NjJaUkhOZXNhMCtSQlZELy9BbExxOHpLWHBkcGVqZy9LZUt0TTlhakdq?=
 =?utf-8?B?aFdHQ3dJSGF5YWRBODBveGZIYkpwOGdHMnNaR2tIU3hMdTN2aS9Rb2JCMEt2?=
 =?utf-8?B?WDJEc0E2QmJRVEFQRkVxczhuc1laMUF6SGU4ZUl5UVIrNS8yckZsL0l4Nlg0?=
 =?utf-8?B?V2F0RjBTWmF1SkplY0pKZ1hmdEgyU2F1cUtJZHUyblAzenNWOVMrRTVEYWlD?=
 =?utf-8?B?cHFnd2Y3NERzYWNITjF3OHg5eEo2bWc5czlwdHltR2QzSkdSOWFicTg0RHpO?=
 =?utf-8?B?T1ZnbkRRNmlLYmt6Mkpockkza3pkTGlJT1ZqNndNRkJaRVRFQTJOY3ZLVzFI?=
 =?utf-8?B?R2lHUFZEUEV6WnNhdndNeUlDbTcrSCsvMVczOHVYbG5TVUN6MmpHQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3733bef5-4eb6-41f1-60b7-08ded4fc7e46
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 10:03:25.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGv+K/raNLnHA8l9jvEpc2C2aGjrH6I6/o4JyHJWJPQD2xw9+tPmEz98NkE43beoPqcX6p3TuF312LuKALpO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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


On 6/28/2026 12:00 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/28/26 10:16, Avihai Horon wrote:
>>
>> On 6/26/2026 10:54 AM, Markus Armbruster wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Just spelling nitpickery this time.
>>>
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> Switchover-ack is a mechanism to synchronize between source and
>>>> destination QEMU during migration to prevent the source from switching
>>>> over prematurely.
>>>>
>>>> VFIO uses switchover-ack to ensure switchover happens only after
>>>> destination side has loaded the precopy initial bytes. This is 
>>>> important
>>>> for VFIO, as otherwise downtime could be impacted and be higher.
>>>>
>>>> In its current state, switchover-ack is a one-time mechanism, meaning
>>>> that switchover is acked only once and past that another ACK cannot be
>>>> requested again. This was sufficient until now, as VFIO precopy 
>>>> initial
>>>> bytes was defined to be monotonically decreasing. Thus, when precopy
>>>> initial bytes reached zero for all VFIO devices, a single ACK would be
>>>> sent and its validity would hold.
>>>>
>>>> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
>>>> initial bytes to be re-initialized during precopy. Specifically, it
>>>> means that initial bytes can grow after reaching zero, which would
>>>> invalidate a previously sent switchover ACK.
>>>>
>>>> To solve this, make switchover-ack reusable and allow devices to 
>>>> request
>>>> switchover ACKs when needed via the save_query_pending SaveVMHandler.
>>>>
>>>> Since now switchover ACK can be requested for a specific device and in
>>>> different times, make switchover ACK per-device (instead of a 
>>>> single ACK
>>>> for all devices) and let source side do the pending ACKs accounting.
>>>>
>>>> Keep the legacy switchover-ack mechanism for backward compatibility 
>>>> and
>>>> turn it on by a compatibility property for older machines. Enable the
>>>> property until VFIO implements the new switchover-ack.
>>>>
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>   qapi/migration.json                | 14 ++++----
>>>>   include/migration/client-options.h |  1 +
>>>>   include/migration/register.h       |  2 ++
>>>>   migration/migration.h              | 32 ++++++++++++++++--
>>>>   migration/savevm.h                 |  6 ++--
>>>>   migration/migration.c              | 37 ++++++++++++++-------
>>>>   migration/options.c                | 10 ++++++
>>>>   migration/savevm.c                 | 53 
>>>> +++++++++++++++++++++++-------
>>>>   migration/trace-events             |  5 +--
>>>>   9 files changed, 123 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 27a7970556..9b3070e494 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -508,14 +508,12 @@
>>>>   #     (since 7.1)
>>>>   #
>>>>   # @switchover-ack: If enabled, migration will not stop the source VM
>>>> -#     and complete the migration until an ACK is received from the
>>>> -#     destination that it's OK to do so.  Exactly when this ACK is
>>>> -#     sent depends on the migrated devices that use this feature.  
>>>> For
>>>> -#     example, a device can use it to make sure some of its data is
>>>> -#     sent and loaded in the destination before doing switchover.
>>> Here, "switchover" is used as noun.  My dictionary is happy with that.
>>>
>>>> -#     This can reduce downtime if devices that support this 
>>>> capability
>>>> -#     are present.  'return-path' capability must be enabled to use
>>>> -#     it.  (since 8.1)
>>>> +#     and complete the migration until the destination has
>>>> +#     acknowledged that it is OK to switchover.  The acknowledgement
>>>
>>> Here, it's used as verb.  I think it needs to be spelled "to switch
>>> over".
>>>
>>> Same for code comments etc.
>>
>> Sure, I can send a patch to fix those.
>
> Can you please send the update as a follow up patch ?

I was planning to send it along with the bool return value refactor in 
patch #1. Would that be fine?

Thanks.


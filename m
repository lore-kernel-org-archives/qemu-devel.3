Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67952C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEO6-0002SN-26; Mon, 29 Jun 2026 11:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1weEO4-0002S3-F5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:59:08 -0400
Received: from mail-westus3azon11010048.outbound.protection.outlook.com
 ([52.101.201.48] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1weEO2-00029V-6h
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgMO5D1v9YHDI1LWxD5CBFQQzcUqhpb+yssOZ8ocF5QVw9DE50GukyTH/UTGEJlhpfMlcEpwaOuw3UmETsvtD9aEqvxeYEzmASHH1ySOetWjJtyCDLBisl5yACWu38YFxZz8RoGASSjiqBdJTu33BW65QraqZGGSNQvMQdmTkXUUI0NF7Xkl8oA02+MpNCTGJO4VHeTmvpoM7EO9NcO2fCJWZQmEQud/vtbmwL5EfqHcGorYTLzdaOvvXMaCKcDWDNyZHhOLvHGYlvEfnPrMvtc0Jvh9+qsLT/M+vkMZAGXKFLybvOKwm17mvQO6+vTBC77qQr0+s0gq8/GKJ6Fe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBo+q9L6hmBeapd9vfgdlawx8SpuEKEhErPDtF7W+Ok=;
 b=JCEkDcFWI3pXlDrctj5yUXzYRt4Ndh6N0DiRbItPIvNVA6ojHm7NFD29JWXXEifnyTuXH7iwpGl64Rs+v9/mrcl6QWkNN4uut1PY6WVNKRsMHTNHN6q2plMcSblhAzjtfYDW/oMz7eZxM1YCZcD55l+4UTOBpeG324gg5XwayKSSyj4aLA2gve2mIstqfoa/wgpGCh3/tXNV0AIgoHrwgQzZPyzU/gR3m5n/7Zot28NBersP3yIlN+RFZw8xmP2x4mQISDnGWjw4jpYA9wDOX2g6TbqLjBvK5xSA3f/sg5ewOjppJb99JdrtS+dFRnjyKtUDSoWjBjDkEJFEuGsU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBo+q9L6hmBeapd9vfgdlawx8SpuEKEhErPDtF7W+Ok=;
 b=cwTqWFRsie7mswg28+llknS0zRi/HnGUtR2rJkHTaVssrmJJygpwBhdO/+wwMDdYM47Zg9S81tFjadkQjhyiN+GMukthEXocXojAfvuMYeC0/7+jn46+tVzKxnzjIyx5uvuAlaZNMJS0uFSI7xOTrKM2seR/ZWisRfuaKnb2Y7MR7zYdjeENRGpSEMbHSAaGEVqJ358JSJM40zhktvUybCR6Jw9+tOcmmZPNj9RDZplzhNMk08hB7hi8O5a2IDEcYFYTV4l8IRnfdo/aPDJxuhdOEoeRnWJSJzJhLa4FgS/Zs8/rVPpaDll5dK4+5kZAxZEiUVZfq6ZA1BooD8SSXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:53:55 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0159.015; Mon, 29 Jun 2026
 15:53:55 +0000
Message-ID: <64207c96-affd-4895-a6ab-2cee7ac4347e@nvidia.com>
Date: Mon, 29 Jun 2026 18:53:48 +0300
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
 <675f8d2f-ca22-4b04-bc30-8fa7b6d3a6dd@nvidia.com>
 <4a3457d3-d892-494b-b8a9-556ad9a7912a@redhat.com>
 <59fa369a-b5a1-4484-bcb0-93b663fb0c44@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <59fa369a-b5a1-4484-bcb0-93b663fb0c44@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d392ef-8e29-4c39-37cc-08ded5f69f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|23010399003|1800799024|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1S+RFaK2GzzghWo1QUKZ1X5zpWk34cgyk32RwMU8wnhN/dzDT6EUzF8/T86h22O/J+K5hvuovnehR/jACvonR2yuS56Q2gBcWf+A9oJYf3JHa2R+vCytah5kQcJS0suEsHz5F08QAwAJDmQzwJEmfZXQQrhmwdc/I5Lm77vrfwOX/Crrho34LLlUJt6bZspOodCgRFw4hqv4QLGA5Zj/yN6vEhs0LbU7IOAbmXFmI+0HGEkveFRyoy2GyZGgvjQblgVDvcPUTgNsn0vNyJfoVF+R687rN4ifAUoCWmQUSVSZnpY51UiF34aAgWqHpfHz1LlpQ8EAde5WM3Twp7j9mFD2QhYgPe9h0lQ7/ek8Ij+PEQl6DXpZIEEp2ZnaiVviSAabD8WH26T83ihAF2kyIdfomeAn8oh07MYVoNkSFCyR4P2KlBj8oThUbxgdI8s8BUKk7pJVjnBx7uVS/5an3QBveqaoxDFEpsA2rch5RokhTsY5dSAAj0B5nXu7Un2WEhqJ8JI3+ZwHJg9VNsPI6ZMcF+xcTRFyBn3vJW2IwvdQkK8Fe05cWZqvUziahxU2o7cGnHwfI/TziPqsxJsAa2Z96JhdpRHR2DH9sMkCP5X6vSn0NFA8ro9+kNkBFuoSZt3hVLDPpRGklwAy8Cc2eiScq4BPjvPc9uMF4P2IjKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3JjalF2ZmQyYXFnci96WjluM2Z4MDRoSlBzZVhNeWoyb09IZ3Uvb2JnbWlQ?=
 =?utf-8?B?aDZWOVBDRWUyRzVCRjU2RGszWHJ1dmdkSmgwM1J0ZWdzcXpnM3F5Qk1zQWJm?=
 =?utf-8?B?TTFEZ3FIVSt5Y3NEWENCNmhFcmhLZzhaRnBIczBuR21YZTY2Rm9MdDNXWVpK?=
 =?utf-8?B?VHFVOUNxak5UZjBOSmdpL2tJSksyOWd6bDNxZFhXMDRXalVlTEVOTXBUcmJ5?=
 =?utf-8?B?QThXQmo4dWlwdERiT01HdlRjVnRUV1JLMEhwVlBzaStrUkQvMmI3RGs3Yk8w?=
 =?utf-8?B?RW4wMGEra0oyT0NLd3ZVajAwSThMR3pnZ21WaWRGeVpiemVPZmtsaVdzWnlT?=
 =?utf-8?B?V1RudDZOeVl6djdjNTVBZ0V6ME1KWGhONnI5OXB5eVdrbFg4YWpuaUNXem84?=
 =?utf-8?B?VUluVW92K1NMU2w0MTRNdkJDSENSbVNyV3daQjFRdUU3N2g4M1ZoSy8xa1pW?=
 =?utf-8?B?RlRSWGZPNTNjdnI5UjhwbnNySzY5Ym8rVFZMZUUwalNTeTZ4UERlYU1tYTV4?=
 =?utf-8?B?VmZqTHl4VGtlVm95SnlpWVVRbVI3bnQ4bDE3Z3NLZWRvNDE2M1FVL3hZNGZj?=
 =?utf-8?B?OCs2TmNsaG1PSWNXVncwNjB4Ri9hN2tvWXgzaVllZHJHYXptdVAzQ2dYVmhy?=
 =?utf-8?B?K0lJUisxWTczSE41djNiQ1hTRzdnVklIVGVzWWRuYkVtbjlOZ1kwUEpmdXJ3?=
 =?utf-8?B?U05oZVdjN3lKL0xad2wvYWxDMUw4czVKOWY4SkpJVExmQmJZMkcxSTNseFRW?=
 =?utf-8?B?bmxUUWwzZTVNbE5KR1dBWUFMNXoxQzg5OXloZWFReGxrN1ovcnpmYTM2bHJp?=
 =?utf-8?B?SkhhTHVZOGZ6cE9xbjVja0JFQW84OFZpL29YVHZhdHRwbFUvZW80Z2ZJZFpq?=
 =?utf-8?B?TXM0UVFJQlZVTjNaVmlrdlpzeHNQb291Q25DeHZFSlZkQ2JzRVVaRkpBQUZH?=
 =?utf-8?B?UlhnKzBpVjE5NDNISFcvek9GaDFVbkQ5djd4dUZHSkdBTmlNbDdmWERHQVBs?=
 =?utf-8?B?ZFZOSm9kWHN2Z0dIQmF3QkJodERoK0hmNG1OcmUySUFCS1U3OFBPV0ozdTN0?=
 =?utf-8?B?c2VaNXZFTEtrVVFsejI0anZPemxvcVhYMmRTWDNHTDRIS21UdVIzdHFPT3lj?=
 =?utf-8?B?amV3QVE4QkRsYWhNdzZSdXBMVjQvc2tWYURZdnlXdnZnN1Rjd2RqOU1PNmpw?=
 =?utf-8?B?UnJ4djMvcDVST2kzeVhVK1Q3d0pnTlNYQmJncWZ5WnpUTk8xQTFYMTVIaXRN?=
 =?utf-8?B?UEFXZmNwbVNYZ0xrNVJCN1ZKWnV2YzVQRElIdXJtblFGQ20wUWdlWU92bm0v?=
 =?utf-8?B?blpqSlRSWEZQRUx6ZFNRN3FjNkc1TExiaXJEd1dJZ2VJZGNCU3BOdkRudjE3?=
 =?utf-8?B?b1NTVXVGZTltbVBKMGZTdWoySEZVM3JMcXlUSVVDZkVBWjlmb25ZVmVDMGlm?=
 =?utf-8?B?UERBRWl3aW5ndW9XRmxSVGJPNlVBRlJxT25RU0w0R0Q0d01KSHhCcE90RUdV?=
 =?utf-8?B?OGFFQ2wySkxaTmx2TnlyN3dEdVFvK2xWZ0Ura1hGUG44Q2pHQjRZcC9nT0tt?=
 =?utf-8?B?ZU82ZnhRS3Yvci9GWTV1UWx4YkdZdURST3g4TjFRbUk4SXNyUitMRTE0d3p5?=
 =?utf-8?B?RmpBRUVzbVRhbDM5OTRiQy9hTm5mcXJFcUJtTXpxM3AyVnJxUWZ1dnduMm5m?=
 =?utf-8?B?TG9sdXNPUUZ2SWlmU1lwR0kwdGNuLzdCYm04KytuZVE0YkRJdWpCS2dST2hl?=
 =?utf-8?B?Z1k3NWtuTmtvQVptNjJscWNVQXRDcE5DTnhLOXArM2cxd2NPQ0lqMmkvcnEy?=
 =?utf-8?B?UFVMME9KSGlCNXJOR0REZlBNUWtKcGJQV2hoYlY0UGsrLzNuWGw0ZHlwWThY?=
 =?utf-8?B?NVk2NUJ5NWxzdFhRWk9sZ2xaODdTbnVhY1ZNREp1V1psVjhnL2tsTXVsNG9n?=
 =?utf-8?B?cGZqdi9sVDMyOURNWU9mS0dFUk1BVUl3T3hja1FEeGJnaFJERUsrT05pS3lG?=
 =?utf-8?B?KzdLUzRQelRLUTZTdEhtZUVkWGUwOTdTQ0NtV1ZUdURQazBjL1JWRjMxSUVR?=
 =?utf-8?B?L2xTQk01UEZZV2VnQ1NjMVR6eEY1MEdyNnkwOXlxZHprYzZvL0FWTk9XWlJ0?=
 =?utf-8?B?c3pvcEZOWDNOVzNTY3JDRXVJYUpxV1hzbmZ2Z2VsMklJQnBPSWVCOEk4bWpF?=
 =?utf-8?B?R3d1aWtFcEJWTktyeDQvMzZjR3c0VmZmRWpzU3AvWXpUNEUrRjYrbUhXL3dD?=
 =?utf-8?B?eHRub1g2azkxd0dpNXprTUZxejFReGF0cW9BaWRTVmF5TDJic3liamhJNytv?=
 =?utf-8?B?TjF0MDJ6czU0YThZY0s5eGZNakpXc2NJQU50OTFrdDdkN0tKcTQydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d392ef-8e29-4c39-37cc-08ded5f69f73
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:53:54.9705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rf5cE264FOalsvQbaIAgmfZLNnYMwelfSvzLoGyWrkgpvJhtcdtgGcVczdjp7fpsWr/6keHxIuMolmPID70gkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
Received-SPF: permerror client-ip=52.101.201.48;
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


On 6/29/2026 5:57 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai
>
> On 6/28/26 18:29, Cédric Le Goater wrote:
>> On 6/28/26 12:03, Avihai Horon wrote:
>>>
>>> On 6/28/2026 12:00 PM, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 6/28/26 10:16, Avihai Horon wrote:
>>>>>
>>>>> On 6/26/2026 10:54 AM, Markus Armbruster wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> Just spelling nitpickery this time.
>>>>>>
>>>>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>>>>
>>>>>>> Switchover-ack is a mechanism to synchronize between source and
>>>>>>> destination QEMU during migration to prevent the source from 
>>>>>>> switching
>>>>>>> over prematurely.
>>>>>>>
>>>>>>> VFIO uses switchover-ack to ensure switchover happens only after
>>>>>>> destination side has loaded the precopy initial bytes. This is 
>>>>>>> important
>>>>>>> for VFIO, as otherwise downtime could be impacted and be higher.
>>>>>>>
>>>>>>> In its current state, switchover-ack is a one-time mechanism, 
>>>>>>> meaning
>>>>>>> that switchover is acked only once and past that another ACK 
>>>>>>> cannot be
>>>>>>> requested again. This was sufficient until now, as VFIO precopy 
>>>>>>> initial
>>>>>>> bytes was defined to be monotonically decreasing. Thus, when 
>>>>>>> precopy
>>>>>>> initial bytes reached zero for all VFIO devices, a single ACK 
>>>>>>> would be
>>>>>>> sent and its validity would hold.
>>>>>>>
>>>>>>> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows 
>>>>>>> precopy
>>>>>>> initial bytes to be re-initialized during precopy. Specifically, it
>>>>>>> means that initial bytes can grow after reaching zero, which would
>>>>>>> invalidate a previously sent switchover ACK.
>>>>>>>
>>>>>>> To solve this, make switchover-ack reusable and allow devices to 
>>>>>>> request
>>>>>>> switchover ACKs when needed via the save_query_pending 
>>>>>>> SaveVMHandler.
>>>>>>>
>>>>>>> Since now switchover ACK can be requested for a specific device 
>>>>>>> and in
>>>>>>> different times, make switchover ACK per-device (instead of a 
>>>>>>> single ACK
>>>>>>> for all devices) and let source side do the pending ACKs 
>>>>>>> accounting.
>>>>>>>
>>>>>>> Keep the legacy switchover-ack mechanism for backward 
>>>>>>> compatibility and
>>>>>>> turn it on by a compatibility property for older machines. 
>>>>>>> Enable the
>>>>>>> property until VFIO implements the new switchover-ack.
>>>>>>>
>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>>>> ---
>>>>>>>   qapi/migration.json                | 14 ++++----
>>>>>>>   include/migration/client-options.h |  1 +
>>>>>>>   include/migration/register.h       |  2 ++
>>>>>>>   migration/migration.h              | 32 ++++++++++++++++--
>>>>>>>   migration/savevm.h                 |  6 ++--
>>>>>>>   migration/migration.c              | 37 ++++++++++++++-------
>>>>>>>   migration/options.c                | 10 ++++++
>>>>>>>   migration/savevm.c                 | 53 
>>>>>>> +++++++++++++++++++++++-------
>>>>>>>   migration/trace-events             |  5 +--
>>>>>>>   9 files changed, 123 insertions(+), 37 deletions(-)
>>>>>>>
>>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>>> index 27a7970556..9b3070e494 100644
>>>>>>> --- a/qapi/migration.json
>>>>>>> +++ b/qapi/migration.json
>>>>>>> @@ -508,14 +508,12 @@
>>>>>>>   #     (since 7.1)
>>>>>>>   #
>>>>>>>   # @switchover-ack: If enabled, migration will not stop the 
>>>>>>> source VM
>>>>>>> -#     and complete the migration until an ACK is received from the
>>>>>>> -#     destination that it's OK to do so.  Exactly when this ACK is
>>>>>>> -#     sent depends on the migrated devices that use this 
>>>>>>> feature. For
>>>>>>> -#     example, a device can use it to make sure some of its 
>>>>>>> data is
>>>>>>> -#     sent and loaded in the destination before doing switchover.
>>>>>> Here, "switchover" is used as noun.  My dictionary is happy with 
>>>>>> that.
>>>>>>
>>>>>>> -#     This can reduce downtime if devices that support this 
>>>>>>> capability
>>>>>>> -#     are present.  'return-path' capability must be enabled to 
>>>>>>> use
>>>>>>> -#     it.  (since 8.1)
>>>>>>> +#     and complete the migration until the destination has
>>>>>>> +#     acknowledged that it is OK to switchover.  The 
>>>>>>> acknowledgement
>>>>>>
>>>>>> Here, it's used as verb.  I think it needs to be spelled "to switch
>>>>>> over".
>>>>>>
>>>>>> Same for code comments etc.
>>>>>
>>>>> Sure, I can send a patch to fix those.
>>>>
>>>> Can you please send the update as a follow up patch ?
>>>
>>> I was planning to send it along with the bool return value refactor 
>>> in patch #1. Would that be fine?
>>
>> OK. Nothing merged yet. Let's have a v5.
>
> FYI, I plan to send vfio-next before the end the week. Initial plan was
> tomorrow.

Hi Cedric,

Actually, I have plenty of things on my plate right now and I'm not sure 
if I'll be able to send it this week.

Would it be OK if you merge the series as is and I send those two 
patches separately early next week?
(They are actually more related to migration core, so this question 
should be addressed to Peter/Fabiano I guess...)

Thanks.



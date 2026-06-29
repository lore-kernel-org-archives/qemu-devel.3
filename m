Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DDEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weIxj-0007aV-PR; Mon, 29 Jun 2026 16:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1weIxi-0007aM-Jk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 16:52:14 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1weIxg-0003fz-Mk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 16:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1mtNO6+KYebWNdK82KE8bke+TRgiFqXiOqW+tOs8/xPqpIhRei84QjsxzEka9XxaK2PjWZudwe0dUUQzuWZfspqtrhzUZmxtwj9EFG0bPw1PC8ZYZOvp1YLu9xxU/0Bv5gdLOD23LbaxwVqizgQNmLlnrptrq8Rjz+v0foFAa6SmMr+n4H8wg1P386HLyRu1NLBxqd9uMQMuWy953aDbzcniwqVPBF1UVQmWKC7BWVqI3ebLVr07Fo++Uk7dsil40e2xflf+1pQt/J0hczx4Qy6aJmUqTvcDU3aMLsaMldXMwK4pLf4jff/rh0Bo+RCbAppFrcShgSoDSMOLW59pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZsnAg+K4aOg1BfCdipaagEU42ohmfm35OzkgM/HvGg=;
 b=IwVwpw83ZUMZ5trE089VhatUUP4QGfUHnJCS3nI39nS+tl4knKq+6XwhmZQdmZq8Yo54bUT3rDBgai+lshB60ROD33VlPAyNGzYx1MzRHuuP4IM7TDbLkuyrbvN9ai7/yOrv5ci0yZ9fCC86Uq5kAQMLImlMYDSjVmah32JxQPSG3nOw6tHBvDtIskNRtWxTaE5UoNGlRm+oRisggY38ElshpXCf404BJ8w0rSo1ZBaW5Wyw5GCGQYPucaLnevsinmXbrIKlowRqtbW2iwMshW5h7tqGTioNXlFprfZ8pyYQ3SPrLwh3YK7CqyZ7Hd0yA3kkH5Gkshet9E6x7fe1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZsnAg+K4aOg1BfCdipaagEU42ohmfm35OzkgM/HvGg=;
 b=QLVUmCvb5uX2MeXAF16g1dhfguPrf7Pl+5SN+aD1wkNNdBlCL4Uk76hUFQ1nbxADgGObalkPuOw6agVTP/rRLBwpyrET2jwi1yIDeavQna/kDULAkW0ALXFtmg8TmS8IaTF23z9K+kYxaUrcg+eoWWF6pbjROgv8BLA1IPexwIm4lfZk6k9iDToFbMRPIDvkjeGjB7We+OuozVBB7h5lP/M4x0reJIqvdriCfUz3uDuigG7ZO3mLDdStEni8kIjQ3yU1DbB4EZjNJqfigcK7E/fBRkTmwIFjj1+5dnf2qFUo23nzMW0Uc2DRL+TfAhJdmlMOcIZsea7tH+tXZNwGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:52:00 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0159.015; Mon, 29 Jun 2026
 20:52:00 +0000
Message-ID: <09215014-c4bd-4122-83b1-923ab1f83675@nvidia.com>
Date: Mon, 29 Jun 2026 23:51:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
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
 <64207c96-affd-4895-a6ab-2cee7ac4347e@nvidia.com> <akKdDU7VOmPz-QFT@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <akKdDU7VOmPz-QFT@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f5945e-96a3-4848-2834-08ded6204430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|22082099003|5023799004|11063799006|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: WlGeGFpxTUOYhnYPbkj+fGBK1ZwBaeTQ0yd31UzOT0K78YWfhl/DF9wpT7ssnPEP4z+VTkU5oeyIDC88CMk3aGq1HFk7mzFD+kXvUExJGWAMkVwW0StlS3Np2/QR9Ddj9jvPZg17Qjqev/b/A2gqX1V4om2gKun6JKum3nkacmAJpDskURAJ+vCDbvMFcoSm9jF86wBSoFcNSvxAHPlz8rWi65Qg3QAiOLf1oc9eIGJusBX2HHR1B5vB2KdKf43VBMZ72eoc3SAQxHhZKow+Kavf7y5PIw9V8RRXrbA/Ywp5j9mvRR015GOavDN+ruVFmHTB8kPoksw+ctE9luuRPRNyCTFQOnni79Fy5+pjvT8I/y5wi3HmNRVr9rFq3M3js/BxHtcO9gZEISWPhFkuu03eNMGGpJUdm+AhyTnF40EJ0I+xArEeYSCXBAR+fmq2/puFSbx5T7iKfkVTfgxBfcSHw7sHOajAsGBYyowK+N7QfcPv6+u+T638C4PZHZZYEAb+vuCSRfvQ+hDu1fjj1UD8aTmNji6Ic1Z/lsKAiwcZUCvQqYy7zzeNDl3YqCN0E3TDdqcloKZog6GGbKXxScV3J6kSb/4r0nkhDH7TVvIzJNpcMosDrmu6+reGj/Aa1WzCVXNzzroG2IgZKfrVRPBT55YouDQKvGnHoRcbmS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(22082099003)(5023799004)(11063799006)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmhnblp0dDhlL2RmbjAwZ254ZnJUNjBVTDdzTUZuMmFWa3R0MFZheFNxc3dv?=
 =?utf-8?B?bWFXRm94UjRIL0djb1lGMCtld0R4TThaTUdaOS9MeTdlMThDOEhRV3lXcDdC?=
 =?utf-8?B?bFphNkdoeWhGampNNlBUdnpjZHByb0tUSkN3U2ZmbW5zKzVUMEdLcHRpcTRY?=
 =?utf-8?B?YThBeHJ1WmpGUlZYQmFsdDRwRlk4Q25uS0wwWW10ay9SNFZOTE1WTWJ5MXdw?=
 =?utf-8?B?MzBkbWNmTDFHcjJBMDNSSlRDajZzSXJtVVBiSmRBY2dzd0Z3ZjlXdzllT0sy?=
 =?utf-8?B?VjZLNDlzS2RnRi9WblJxaDNaWHp5VU5QQmlydXM5VmVUdWhtM3pxVGx0K052?=
 =?utf-8?B?Ykx1V0dpODVqWHRrM0VBMXBBZncvSFRUMnpFS083T2NOMVk3V3k4UjFMOGxI?=
 =?utf-8?B?cnE1OTVoa1BkcmZpeTBQc0VGZ20yUzIrdzVoNVYya216dEVUN04zdWRhRjI0?=
 =?utf-8?B?djBwUUpnUWtLZW85WGFTVStoWkRSRmJzcXA4Lzk5SHM5VTdTRzdiWlgvTytx?=
 =?utf-8?B?bjVrVGxFeG5YREVDZmtheHlLNVBQb3NVcHVXZDdVNGVaT09qeVJkTG9EUGk2?=
 =?utf-8?B?OHBMQVNwU3BER1ZBcGhtdFh4Z2JvNXlmUEx2VVdJMVl1aW9HQXdjNW82SGsx?=
 =?utf-8?B?WjYrWHpqVG1aU0czaUZQUkJtZk1pNllKRExNQ2tNYjJuU1RHVlhKZmc4cDFm?=
 =?utf-8?B?TzNxck1ZQ09PWjFDWUxNVGVyTWl5dWxNZEVtUTAwTkZadzdvOWdrVXZ4c25h?=
 =?utf-8?B?RTB6T0x1V2VwWTZqbWg1OTRZQnlxQjdUalVPSW9ZV3NSRlpLTy9rZkVhdWNm?=
 =?utf-8?B?NWpyS0dvd2xrY0F5ZjdzZEJENnN1UmNJWWFSb0p4ZGFodE1xamJvUEo2cXpm?=
 =?utf-8?B?Q0xYUEZkZkJYbEJvb2dlREtLbEJhc1hJMzU5d1F0RFY4S0xNbVRlT2FSZXhy?=
 =?utf-8?B?cjEvTGNWL3hXK3Q1UXZ6b1BMRlRNdWhQZ1J2ZXB5QjByMS8xVWxRbE5UUExK?=
 =?utf-8?B?RGV4M2JVVmt1bmJkVHBjVFBySXMzcGJTdlNJeUlLTzVrMllEVVllR2ZlMnRM?=
 =?utf-8?B?Tll1bSt6dGpWTHArQ0lMdUdoemNUd3dTWTZRdUhnNFlMa3ZPVlNzZHhBcTNW?=
 =?utf-8?B?M0NiQnAzc1FPVzhEbUhFTDhkb2EwWVJaRG5iNVpQa011UFZ1Mk1rb2M3QSt5?=
 =?utf-8?B?M0g0SHF2SURHTmhmdlVMMjFJczFrdVFTYVVkNXNWOVdZSXBCcFlBNUVJOExL?=
 =?utf-8?B?UWdheW91MXhTMUxlUzhBL3dvK240YitZVUl3M21yRjFZVXRKZTVOWGtMSENZ?=
 =?utf-8?B?NjdwQ3FabWoxbzRWc1BlNUhLZGZnNTNsS0tnVE0rMmt0aHcxVmxQWVFEZkRT?=
 =?utf-8?B?R1ovRU5hTVZ5QmdZRFFEblo3U3h4cEVqZzFhNit4SFhhank0MmtsZjJaSjJ1?=
 =?utf-8?B?bm9od0Y3cDJYdnNESzNxMndqditpMk01d0ZyUGs2dElXMC9EOHJRWUZsQUZB?=
 =?utf-8?B?MUtoaFQwS3ZmREZLZFBINUg5a2UxenAweDhFbEswc3EzUEp0YWJUVUJmbXlF?=
 =?utf-8?B?NmVqcXVGdG1TQlZ4bUpkdFVQbUtvU3BXbm0zdWQvcEVPa3VTRWJ0aUFHVG9V?=
 =?utf-8?B?cTZZUkJhV1luM05nVXRmYWx0cThsRjYwT1BWeExoc3NBYVIwRk1SeHpaMFQv?=
 =?utf-8?B?VGVRZzRneUJlRm8zYmlNSkpScjB6eVQrSmtZdGVOZnAycS9wK3BESTdoSVQ0?=
 =?utf-8?B?RkM3dVFqTTB2ckN5S25HckJYU1p4Uk96akdncko5TEwxWnlUczdVZ2lOSWxM?=
 =?utf-8?B?c0VYWEVGaS96cUtUVHo2bEJXS0Q5anU3d1NsWjJzU1B4V3JUZldhUXNKeHcz?=
 =?utf-8?B?eHRBYmRYaDMzRjNycVA2SFRabm9zUEMwcGFXQXFzMlQzbVdtMEVDUVhyWXpM?=
 =?utf-8?B?YlNIamJMNTZ5NnJydnNRblovYUI2T1Y0ZWdOSktrRUNrR0kwWDJPNml6ai8z?=
 =?utf-8?B?OFZ1KzBDdHY3T1hsRkJjMVRMSElaNmZLd0daOHliQVpWK3ZoQ1hJcUhacWZm?=
 =?utf-8?B?dUgyZTV2YklkWWtFc0hpbm9ONk11Z2MzMlBNQ0FkQTBCZkVCdkorS0N6dTQw?=
 =?utf-8?B?NERwbUV6b2xvd3luWStjYjFYTjdQTlE2Lzc0Z0hCWWFNNlJpWVFWaG9hMWt5?=
 =?utf-8?B?bmVYSTZ6Y3M0OWtDQXJoSmtERXBsam9YNVdxenh0Y0FrVjhndVhxb0hHaEc2?=
 =?utf-8?B?VldzakxsRW5BYnZsNElpTXV2OGNvRTlySEVMWWluVTFrSU9kVyt6NHFuVDNM?=
 =?utf-8?B?ZE4vcGxYbEdObFBWelFmZm4vc1loc1dHVTg5TVBmWVNrL05GWDhyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f5945e-96a3-4848-2834-08ded6204430
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:52:00.6489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdv3P7I/PmpZ4vC1+mXWZV8zzVRfaFDcg5n74BRVddYaEXDSOdPTusxRfE1KOfsbXds6myB1tXXreCo2IPnvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=avihaih@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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


On 6/29/2026 7:27 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Jun 29, 2026 at 06:53:48PM +0300, Avihai Horon wrote:
>> On 6/29/2026 5:57 PM, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Avihai
>>>
>>> On 6/28/26 18:29, Cédric Le Goater wrote:
>>>> On 6/28/26 12:03, Avihai Horon wrote:
>>>>> On 6/28/2026 12:00 PM, Cédric Le Goater wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On 6/28/26 10:16, Avihai Horon wrote:
>>>>>>> On 6/26/2026 10:54 AM, Markus Armbruster wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>
>>>>>>>>
>>>>>>>> Just spelling nitpickery this time.
>>>>>>>>
>>>>>>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>>>>>>
>>>>>>>>> Switchover-ack is a mechanism to synchronize between source and
>>>>>>>>> destination QEMU during migration to prevent the
>>>>>>>>> source from switching
>>>>>>>>> over prematurely.
>>>>>>>>>
>>>>>>>>> VFIO uses switchover-ack to ensure switchover happens only after
>>>>>>>>> destination side has loaded the precopy initial
>>>>>>>>> bytes. This is important
>>>>>>>>> for VFIO, as otherwise downtime could be impacted and be higher.
>>>>>>>>>
>>>>>>>>> In its current state, switchover-ack is a
>>>>>>>>> one-time mechanism, meaning
>>>>>>>>> that switchover is acked only once and past that
>>>>>>>>> another ACK cannot be
>>>>>>>>> requested again. This was sufficient until now,
>>>>>>>>> as VFIO precopy initial
>>>>>>>>> bytes was defined to be monotonically
>>>>>>>>> decreasing. Thus, when precopy
>>>>>>>>> initial bytes reached zero for all VFIO devices,
>>>>>>>>> a single ACK would be
>>>>>>>>> sent and its validity would hold.
>>>>>>>>>
>>>>>>>>> However, now the new VFIO_PRECOPY_INFO_REINIT
>>>>>>>>> feature allows precopy
>>>>>>>>> initial bytes to be re-initialized during precopy. Specifically, it
>>>>>>>>> means that initial bytes can grow after reaching zero, which would
>>>>>>>>> invalidate a previously sent switchover ACK.
>>>>>>>>>
>>>>>>>>> To solve this, make switchover-ack reusable and
>>>>>>>>> allow devices to request
>>>>>>>>> switchover ACKs when needed via the
>>>>>>>>> save_query_pending SaveVMHandler.
>>>>>>>>>
>>>>>>>>> Since now switchover ACK can be requested for a
>>>>>>>>> specific device and in
>>>>>>>>> different times, make switchover ACK per-device
>>>>>>>>> (instead of a single ACK
>>>>>>>>> for all devices) and let source side do the
>>>>>>>>> pending ACKs accounting.
>>>>>>>>>
>>>>>>>>> Keep the legacy switchover-ack mechanism for
>>>>>>>>> backward compatibility and
>>>>>>>>> turn it on by a compatibility property for older
>>>>>>>>> machines. Enable the
>>>>>>>>> property until VFIO implements the new switchover-ack.
>>>>>>>>>
>>>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>>>>>> ---
>>>>>>>>>    qapi/migration.json                | 14 ++++----
>>>>>>>>>    include/migration/client-options.h |  1 +
>>>>>>>>>    include/migration/register.h       |  2 ++
>>>>>>>>>    migration/migration.h              | 32 ++++++++++++++++--
>>>>>>>>>    migration/savevm.h                 |  6 ++--
>>>>>>>>>    migration/migration.c              | 37 ++++++++++++++-------
>>>>>>>>>    migration/options.c                | 10 ++++++
>>>>>>>>>    migration/savevm.c                 | 53
>>>>>>>>> +++++++++++++++++++++++-------
>>>>>>>>>    migration/trace-events             |  5 +--
>>>>>>>>>    9 files changed, 123 insertions(+), 37 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>>>>> index 27a7970556..9b3070e494 100644
>>>>>>>>> --- a/qapi/migration.json
>>>>>>>>> +++ b/qapi/migration.json
>>>>>>>>> @@ -508,14 +508,12 @@
>>>>>>>>>    #     (since 7.1)
>>>>>>>>>    #
>>>>>>>>>    # @switchover-ack: If enabled, migration will
>>>>>>>>> not stop the source VM
>>>>>>>>> -#     and complete the migration until an ACK is received from the
>>>>>>>>> -#     destination that it's OK to do so.  Exactly when this ACK is
>>>>>>>>> -#     sent depends on the migrated devices that
>>>>>>>>> use this feature. For
>>>>>>>>> -#     example, a device can use it to make sure
>>>>>>>>> some of its data is
>>>>>>>>> -#     sent and loaded in the destination before doing switchover.
>>>>>>>> Here, "switchover" is used as noun.  My dictionary
>>>>>>>> is happy with that.
>>>>>>>>
>>>>>>>>> -#     This can reduce downtime if devices that
>>>>>>>>> support this capability
>>>>>>>>> -#     are present.  'return-path' capability
>>>>>>>>> must be enabled to use
>>>>>>>>> -#     it.  (since 8.1)
>>>>>>>>> +#     and complete the migration until the destination has
>>>>>>>>> +#     acknowledged that it is OK to
>>>>>>>>> switchover.  The acknowledgement
>>>>>>>> Here, it's used as verb.  I think it needs to be spelled "to switch
>>>>>>>> over".
>>>>>>>>
>>>>>>>> Same for code comments etc.
>>>>>>> Sure, I can send a patch to fix those.
>>>>>> Can you please send the update as a follow up patch ?
>>>>> I was planning to send it along with the bool return value
>>>>> refactor in patch #1. Would that be fine?
>>>> OK. Nothing merged yet. Let's have a v5.
>>> FYI, I plan to send vfio-next before the end the week. Initial plan was
>>> tomorrow.
>> Hi Cedric,
>>
>> Actually, I have plenty of things on my plate right now and I'm not sure if
>> I'll be able to send it this week.
>>
>> Would it be OK if you merge the series as is and I send those two patches
>> separately early next week?
>> (They are actually more related to migration core, so this question should
>> be addressed to Peter/Fabiano I guess...)
> I'm OK either way.
>
> The simplest to me is you can provide a small fixup for Cédric to pick up
> and squash into this patch (if it's only wording changes to doc and
> comments, IMHO no re-test needed), as long as Cédric is comfortable with
> it, then you can send a separate patch (or patches) if that'll be on
> migration.

I think I'll send those two patches separately later (since the wording 
patch fixes a few other places too).

Thank you both.



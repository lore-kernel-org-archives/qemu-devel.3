Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20686CD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVA7Z-0008OP-Ey; Thu, 04 Jun 2026 11:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wVA7Y-0008OA-7x
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:36:36 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wVA7W-0007Jc-0T
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRT2ZX0frOz+0d0bHQ1SNLliOrH47FyAbVlEf2K7pOqEQC33+CXFn2j4zkckNq6FE+G/0ZGhCKpkHYQqE1Fh507oucZCo5g9DCNlaOxjXJZIDvddgSRsEWAd5z+/zF4BC4r0hBLAsYjsukCH8HR/5n7Epe+DEuf+YLBZH+ZruDdBhzzhEnJR1cslQ/g6kgZphDp3U2WgxUwPUbrBWw099KTHmfEJubf+bBEJWd76apG/Qu0kuqFHWHr6ZoQ3SdU0VC5vEpKhHM/auZ22s5vyh6VcGOuN1HILXv+L8n3DuHbFYIfSzX7wF8zO5tTeNAThvQArxYy2JW+61ATVcEtz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hHNCYitx1HW6PhSpMqwXLAVvByPiS4E+T+47gIIsrM=;
 b=qOLtUGUZG61xeA6zbRTFvg0OuDTUj1QTRafqcTBF/b/PJtdhD1PmmCmxuCGam8zucapxvEtnlvbxO8XVX3ypSFuIC93sAkdf/q7c9+mWpmrffDqjqbB91iagkJPf7AcDe0BIjQ/oEZ7Xxy6WyQYiK0v78CSNISOGQLvKd7V+QFFK2Ca/3Rp2fi5SiTEKJRNlrpalow7/Ng4JP2hoWMA6Qm7l0K9Xare4B1tZoA7kzWPdc4yEBTQPxKPWKocu9vakJ3rCqSEkQQaC+Thmv5B42FuvD03bdtDWiYVTn1AHam7XyVX9w1QSLWy7cycyQoULcBRxlbHyN9vXkprP04M3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hHNCYitx1HW6PhSpMqwXLAVvByPiS4E+T+47gIIsrM=;
 b=nOtrd1yDyzvpL3gPriCfKz8YLfN/bxqgqLA6lTAmk4VitfprMkK7hPxdv7j7jhDuHQ96A46GwA9+F/g/hi4YOek6L5g3qSlGDnpc0lFCYf9eGP1hBfBMmTz7vPiw8xKD21sbGkYC+UO2tOxu0f+rJOCIaDn6+IQfq3QHzw0RRGTb7Fm2STJIKdvPylr/hu+fzsW1CWP6UTWM1EQNris3YsGmruEWnCRO0SoVysTzfXfxSzSMO9oEC6JC58c2BQtHgd4WTsJljfMLScpWpwgSRHZgayi4HRdO/vfq0o5+2w9tbkSrCmOtCNvnZiLYtU5UHqJnhRQlgDLtnlNQ83GO2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:36:21 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:36:21 +0000
Message-ID: <a4e5178d-2102-48e8-861c-232266f8da9e@nvidia.com>
Date: Thu, 4 Jun 2026 18:36:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] migration: Fail migration if switchover-ack is
 requested after switchover decision
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
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
 <20260602092621.382-8-avihaih@nvidia.com> <aiCRwvoVl_Z7J3bL@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiCRwvoVl_Z7J3bL@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 3958b113-978b-4c0f-f0f7-08dec24f06cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tkhnDXjZ3GcmbadJAlZIrkePebUC+mEg7ppa+uEXll2ZKs4gV5sUXx0unJI9am3xfrUTWrdtU/XjxJLsMlm9oUrDY8VkqJW25RPsfXJg2dwTQ3VtgqnElIWcNp5V4WwYNr50v9s19xHyIpPjFuDmqEzH/vF80W1HvzNFx6gbyFye1TQLG6555xsMz0TfLSkQ9NkzIZp+ucxT3amzN+SV7PSMQS7IzBCGrUeOnxSsSwcZTbY8og/vB3eyrKGsn8PDWUhn2z6i03jN8656WGgr2ic2VhZbSROIrYFVYmkNAYA0oFC26Jnq8VzEhwgmja8MgSXMUhDx/hh2ZHyAhW2EPCE963eSaApEGr9IYBlW4nYaVooGHMsdYMnjt7kx1qbVETd1hfm0EToSRZIuEPm2nnG47rVxK6yDsK4rAnkEkupO1/cfzf9PwA4CTfgYT2mf2O/SvQ5ENJUxcJwiKxH5ZYDODJZIu0IDJOOieINosPcneDIl3WeQSZqcZs9WP7GDJsdi//5Jvq+SuRy4Hk++70/9Sr7/VBJ7TaDaWBIHnmuNKjB8XNK+U7YVHI98V3YTWx89RRgejMKj0mukJlz7W1axUceX5Wb01maERDm91SwBJe2KftBmtWZatgFQnBNj7LapHNC1Wa1nxYlx4dGMoy6oO2WyCLH/+NaorN421rWAhizVLTYFra8Tw1KaLEiY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTBTejNqRVYxNmowWEZGYXpSRHBsSTUvdGlTalNCc09Kak9SOXZ3WlJSR2dx?=
 =?utf-8?B?MSt1MnRPYlZKWW4yVXJLbnVEU3NtYnpZR1Z1c0V0c3JpWERwUVJwYVd1Ujdq?=
 =?utf-8?B?WlFSV2trbUQvNGVJWThVajVKZXZnNVJPTXhIQjlKY0k4SlhTNlZTbVpSalJw?=
 =?utf-8?B?bFdHMHJwT3RxL2NMRTEySXJOMDhLbVhxMDhMZWE4ZEFqL1FNNlRxZ2tBTisw?=
 =?utf-8?B?M1VucjBTNGZzRWUvN2Q3dVJNV2VEMTdReGVZMHZFMTNFVVRsQ0tSNEd6MWpT?=
 =?utf-8?B?VzN4aVlIRjBPN1NIZzdpZmRJMmJORGQ2M0dIWmFwa3o0VXNvVEFCOWUwTDl3?=
 =?utf-8?B?TjFmK3dLSk02dUkrK1ZXd1Z4bzNDRCs1UkxwMU11QllTRzYvZnVkSXplTktX?=
 =?utf-8?B?eGoveWR4UEpqQlpjeVg4b1hYajlZcjAzQXFjTzc1SWZLTUtYMENZdWxhVURj?=
 =?utf-8?B?K1pMSklVT3ZRZXdnNTZNQVRJSFJRMnVXQnd3WStKZmk5aVRLeHlXM3NlMHIy?=
 =?utf-8?B?RWgxNlJsbzc0M210dlZ1MHVwdEVFblZHMVFNOTV6OThBTnkxcWpBdFBoRkpu?=
 =?utf-8?B?TW5Qa3FyRzNEd1RwaGY5L2N2c3dOaWdOdFhqOVovVzFDbDFTOFU0VDYxWkdv?=
 =?utf-8?B?QmxrTHg4K3B1K3g1ZUxYYWNxNWRtMHVoNnFhRkw3WlZTNjlTMG9sUnp1ZHJH?=
 =?utf-8?B?cEw0T2RFa1JERVhVU3ZHTTZBREFMZWtKZERkZitZcEhPUzRNT21rUHhMeEVW?=
 =?utf-8?B?QzlvZWk3Q1AwM0JZOHZJTWVqSWJBK0lUc0xxSmJkNVo4K1JHTjA3emU2clBC?=
 =?utf-8?B?bGk2SFM0MzVzWjFCVlk2Z2dieXprUnNrb0NjVzVaSFFZN05hMnkxNUNXTVNS?=
 =?utf-8?B?YWc2ei9Jd0QydmdFRGlSQnFQK1piQ1NnOTVONnJkMDBCbGZtdDlWOGkyMzJI?=
 =?utf-8?B?aUtlM0tFSnJzcW1RV1F5bW9sWkRBaDBIcSs5L3NSalhWR0lsQlF0Zy9odnd4?=
 =?utf-8?B?WTdWSXlaWi85dExzdTRPRE0yb2pNbnhpY1FQcWZMM2dVVkx6U2RnYktqV3NV?=
 =?utf-8?B?eUFZRUJUOHBobC9nZzdya2kxRWFLcFVqVjFRSkdtOEFCMjkwaG1PYndwb2oy?=
 =?utf-8?B?U2tkKzhySjJrc2syZmNWR0pHWGpJWFgwWUd6K08ySXA3WWlvMHBpdUZBL1RS?=
 =?utf-8?B?TFRGSlo1ODVvQzQraUIzbEtsR3VsNDdWNGp1SjZZTU41ZUpHdFZCbmdTMm1o?=
 =?utf-8?B?cEZXdDVRd0h4ZHdNbCtnNEs3cEJ4NHU2VWY0RjBpSFRhOU5EU3RtTFJ0b1VP?=
 =?utf-8?B?Z2hOeStmenYrYkJYdkFtWGJZcUlqR3JrekFLTGNvUnUrMm96bitpdWFhYVAv?=
 =?utf-8?B?Z1czWFN5SVhPcVJMaHRsRHl2OTJZVXp3QmorbW1yWHRuTVZxTTRzd1lsdDI5?=
 =?utf-8?B?eWQ5M0l5dng0cW1CczBJTFJQQ3Q1bTJSVFhaUTVEVGNvVk0zOW5mclV3OG1q?=
 =?utf-8?B?WStiVFkyZHludjgrMWpBb2RvZExscExWeEFib0dyVXJmSTJMYWUyNjlBdEhQ?=
 =?utf-8?B?cTRXUE9KQmxuR1ZCSFRLUEZmSW9HZHNYRzArU1BDcnRhcS9tQzlDWnJ3L2Jr?=
 =?utf-8?B?WUxqRUlUZ0M3a21SRENRVTJYYWQwQmNEaTR1UXZybFNSSWhEY0pidkJQUWlU?=
 =?utf-8?B?NDNMTFkxZUVmYWNWci9OTDY4VHZBZGJ6RTd0WCtvZmplNlJieXhVOXphNVlu?=
 =?utf-8?B?NFdaNm9NMGYvR296cWg1SkFmM1dVaU5kaXNqcDkydjhVeEYzZXI4KzBJMXM5?=
 =?utf-8?B?YU56TXZaTTd0L0xadFE3ZDV0ZXZ2SW9DM3NXbEo1ejNkVEdaa2YrMTVETVFh?=
 =?utf-8?B?aHRoajlldmtoRDkxTStjeksxNmV2OGNFUXVLbDdHVjJKRDd5SU56aG05VU4x?=
 =?utf-8?B?S0lRbklHRTJ2bjJyc2grUTZURDJWd1dudDlJZ211d21DQjlOMnpwSkVWU284?=
 =?utf-8?B?WVY5a0VOYnFKSHJ2VVc2NktEay9kbXM5K0VYUGZkU1NTL0lzV01oZUJGYkZO?=
 =?utf-8?B?RTlUY1k2cU5WT1ljZHRjQU93VUdBL245aEtuRWRMMXdPZC92RmdpeDF5aDdH?=
 =?utf-8?B?WWdTeTlyU1FmaXB6b2o4WUJiNWc3OTUweW41bG16dWpBYnU5Z1ZmdGtLY01S?=
 =?utf-8?B?VDdOOXpCOWgyeEsxYWhvdk5UTXNtRkxPK3B1eUl4UExaUFpUZ1dVMkErRTJG?=
 =?utf-8?B?U2Fnak9uN3h5YVY3OGZ0WjQvRmVIYzBRdVRkT0UrWldBbHN1UDVFMkNqN1JO?=
 =?utf-8?B?MDFsZnE5b2RmZnpJdko1ZGpaakFYTFV3VUpmOEg3eC9wTlByUVEzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3958b113-978b-4c0f-f0f7-08dec24f06cc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:36:21.0253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyuMzoolnWu+7HtitXSRSucvg5n8T3l0qJn6qOXAFmWDgqU4oZlguOqgsfn1MLOsGgw1YGHFU2kA0u0M5tKWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 6/3/2026 11:42 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jun 02, 2026 at 12:26:15PM +0300, Avihai Horon wrote:
>> Switchover ACK is checked only during precopy while the guest is still
>> running. The last migration_can_switchover() decision and guest stop are
>> not atomic, so a device may want to request another switchover ACK in
>> the gap after switchover decision has been made but before the guest is
>> stopped. Migration would then miss that request, which can increase
>> downtime.
>>
>> Cover this case by failing the migration if a switchover-ack was
>> requested during that time.
>>
>> Ideally, precopy iterations should be resumed in this case, however,
>> VFIO doesn't support going back to precopy after being stopped, so
>> implementing such logic would require non-trivial changes to the guest
>> start/stop flow. Given the above and that this case should be rare,
>> failing the migration seems reasonable.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One nit:
>
>> ---
>>   migration/migration.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 4bb649a467..6ee1c795ff 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2810,6 +2810,27 @@ static bool migration_switchover_prepare(MigrationState *s)
>>       return s->state == MIGRATION_STATUS_DEVICE;
>>   }
>>
>> +static bool migration_switchover_check_switchover_ack_pending(MigrationState *s,
> The name is slightly confusing.  It says "check if there is pending ack"
> but then it returns true if there's no pending ACK..
>
> Maybe migration_switchover_is_acknowledged()?

Sure, or maybe migration_have_new_switchover_ack_pending()?

I just noticed that I overlooked one corner case:
If guest is stopped during precopy and source has pending acks > 0 
(e.g., virsh migrate with --timeout param), then we will fail in this 
check and unnecessarily abort migration.

I thought about doing the change below. It's not as clean as I'd want it 
to be, but I have no other ideas.

===========8<===========
diff --git a/migration/migration.c b/migration/migration.c
index 6ee1c795ff..6054453b18 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2810,37 +2810,47 @@ static bool 
migration_switchover_prepare(MigrationState *s)
      return s->state == MIGRATION_STATUS_DEVICE;
  }

-static bool 
migration_switchover_check_switchover_ack_pending(MigrationState *s,
- Error **errp)
+static bool migration_have_new_switchover_ack_pending(
+    MigrationState *s, uint32_t old_switchover_ack_pending_num, Error 
**errp)
  {
      uint32_t pending_num;

      if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
-        return true;
+        return false;
      }

      pending_num = qatomic_read(&s->switchover_ack_pending_num);
-    if (pending_num > 0) {
+    if (pending_num > old_switchover_ack_pending_num) {
          error_setg(errp,
                     "Switchover ACK was requested by %" PRIu32
                     " devices during switchover",
-                   pending_num);
-        return false;
+                   pending_num - old_switchover_ack_pending_num);
+        return true;
      }

-    return true;
+    return false;
  }

  static bool migration_switchover_start(MigrationState *s, Error **errp)
  {
      ERRP_GUARD();
      MigPendingData pending = {};
+    uint32_t old_switchover_ack_pending_num;

      if (!migration_switchover_prepare(s)) {
          error_setg(errp, "Switchover is interrupted");
          return false;
      }

+    /*
+     * If the guest was stopped during precopy (e.g., by management), 
we may get
+     * here with switchover_ack_pending_num > 0. Store the current
+     * switchover_ack_pending_num value before the final pending query to
+     * distinguish between existing pending ACKs and new ones.
+     */
+    old_switchover_ack_pending_num =
+        qatomic_read(&s->switchover_ack_pending_num);
+
      qemu_savevm_query_pending_final(s, &pending);

      /*
@@ -2848,7 +2858,8 @@ static bool 
migration_switchover_start(MigrationState *s, Error **errp)
       * Fail the migration in this case since we currently don't 
support going
       * back to precopy.
       */
-    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
+    if (migration_have_new_switchover_ack_pending(
+            s, old_switchover_ack_pending_num, errp)) {
          return false;
      }

===========8<===========

Thanks.

>
>> +                                                              Error **errp)
>> +{
>> +    uint32_t pending_num;
>> +
>> +    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
>> +        return true;
>> +    }
>> +
>> +    pending_num = qatomic_read(&s->switchover_ack_pending_num);
>> +    if (pending_num > 0) {
>> +        error_setg(errp,
>> +                   "Switchover ACK was requested by %" PRIu32
>> +                   " devices during switchover",
>> +                   pending_num);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static bool migration_switchover_start(MigrationState *s, Error **errp)
>>   {
>>       ERRP_GUARD();
>> @@ -2822,6 +2843,15 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>>
>>       qemu_savevm_query_pending_final(s, &pending);
>>
>> +    /*
>> +     * Switchover-ack requests done after switchover decision, are not allowed.
>> +     * Fail the migration in this case since we currently don't support going
>> +     * back to precopy.
>> +     */
>> +    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
>> +        return false;
>> +    }
>> +
>>       /* Inactivate disks except in COLO */
>>       if (!migrate_colo()) {
>>           /*
>> --
>> 2.40.1
>>
> --
> Peter Xu
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93120CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVA0V-0006Aw-KP; Thu, 04 Jun 2026 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wVA0U-0006Al-3l
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:29:18 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wVA0R-0004ZS-FE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyV9rmIaztvoQPRP/6FPkK4bmv+EVlxSJaZfOKmC0a35F7joTZDyzORMRQKdu51uDfUQ/wvVFnjlUGzKdmn8lu5/7lulo0Fg7rpmX5D45ubxjDP1jwgUYk9ehvk2BZf/5g2vkfMlE0JqB66qI2M5jY0Zq5AJi7utT1obS6meo0FlvbgBbvSZReejOYUjelrzOtIgx874vnhaN8g1l1dKmn9lHiRDVtzl3invBCjN47JnptlZWOZBk39kvnsdMEjrBUVyxNQVfxVEEATqvBeqVYum9ew0epPXM1QamkWh5qNl+459hDANS3I41Ci9fQxPgVT8YtQtTJ0ntAF998raOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Ym4NMiZnNJsnLsA5HI48w3o55OTy6G2YjviZYOATw=;
 b=HDLP3X1wGwQSHuddQAyJ0dXXgHZVUsGW6Ra8w9nUkjZwPWGMYQWzXpveEa6Pa0rbaIjyVgTmFgpH4/YGBQOE7EWxtPnCKHAfy/H3UVDpmL0ikeScaKU5ZyKyOX7HP4DXmZ5gxL3NwhW8EgGODaSMPiLyV2l4oRFWKp4AYKktxFpUQMl5DA0ORt0G8dkG/mf0nq4dxEb7lebDGwAYM1x3GlpUQwparNiJGMgNr3SkcDpCXwOd21AhoO4+SkWP2EUf4vIBjKGxpeJKctqwGIQX6PCzOWhW/cE8Vt9Uhuih1L8C9UVsglci7H9TAJi2bbbLaaUuPwLGLNGzJ/EVnYcK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5Ym4NMiZnNJsnLsA5HI48w3o55OTy6G2YjviZYOATw=;
 b=CQkOk7m5gk77UGgtC7ZSzyPXuFctO80pK8NZaZVyP7rIHjqOdcT/IL0lr24sCjyBnFBFSvCQcYTxCc/qiThwgrC4W+LobelE2SATh8UX8hCMfqtrbtp3n7H5gx7K4EE4jIglEL782NjRPjlVJYkk+kKG5bbSNEsgC1STJAcfZd3IJpVE6iPM0VY6sPiGhINUxl42CtmXXuYQP7jFPVHfQQwrdo5+uMQLFIZ4oM/tyeAYPD8rzirUMzveL1lg3GkI5ZtemceiNfT70WYwTYbzmLXHaFybTTCKdHORWgPQYSxMNqBavbcH+w4Zeo5LpdWwKBt3MdimQoGcMUQiI5bIbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:29:07 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:29:07 +0000
Message-ID: <722fb01a-988b-4b21-9cca-aca1de2858db@nvidia.com>
Date: Thu, 4 Jun 2026 18:29:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] migration: Run final save_query_pending at
 switchover
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
 <20260602092621.382-3-avihaih@nvidia.com> <aiCJHa-lT9Ycf6jq@x1.local>
 <aiCWynDFLoxtcctK@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiCWynDFLoxtcctK@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef75c1f-5256-4b64-d8cf-08dec24e0455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|4143699003|56012099006|6133799003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4EUCD7AptEkm1JMxR7n7ZOL4DL6AjTlNiVWnXSgz4I/VOeSyKzuSfKlgFehoWR1mNtCTfSC+LDjoQN19q4nyHrg7YdwlLIux6r5Ofv0Hi7jf2BloZZ2LkpAGQj1iCyjL3WvZ4Mfipo0eRrTIFnvoANMDF8mVnDFCQdMjoSTTkfoQlZrzDSrwPvcf017dEgafdt2E4yGIZBhmMvCRD6EKc6A31+0SDHzxWicAu9wh2Fi7J9YKmJfeytrw8mluiy8437+QBAMRRsDslxD1My5qEey7wmtlC1XLj2tMTF85dbDXellp9fCAmNR76kqCZJJh3teRu5GFVCMDmREztQI6vWG6HEXqNJIrAz7WwyOac+pC0hbP3VxHzW+RGebNZQ4f2Ztiaa1XV6rgPUAvkKes9yuUK2f3i6bgz1qz4/tZWOPk9rNd2rOcNrGCcyEKQL9H+CPcXCKut53LxCSrPH9r4HN8RE/DixFZIL6toyb4JhF0F8VcpyI78MiwyU5BzXiyxLZxuCQy70IYw+ain3NK6Sq60WfgoxbEffqplUEZdl++swX0BQmaGPFLDMts0kdJjtLHhFqPrin8upZ10B3VNJfp3xl5g1SaI1GAfsY+mT58sS2u4es2OEZRFP3doxpWeZ/9gHQmspF0aW5gUJAxu36L3iWC4f2+scosEPZPWnJ2HluSqYihqyTNvuGrGxko
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(56012099006)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtZNkJaY3J5S21iS1NkMm40WEZ0TE9SeVQzOGMvVm9CUjJNRDJxMVpCdEZH?=
 =?utf-8?B?UllnaTNqSHpTN1Z0VWJTSjFCd3NwTHFLWTJsUDRncWJzVGE1R2U2YWp6UHN0?=
 =?utf-8?B?YkZ6VFplMXRTZlA0Z3ZrTmdmT1Y5czBnZUxhZVRJOHNBQjNQOC9OTlhaSVh5?=
 =?utf-8?B?M1V5R0h4WnNPb0NJbmFMMVhJWVlYUk95SktKN0M5REpMbzBrcUErUzd4S2pz?=
 =?utf-8?B?Tko5aE5Odk96eU45ZW1oWnlvcm5CVTRuSnp1Wnk1MEF1bFllTnZpTlRuVGVm?=
 =?utf-8?B?dVBBV0ZaQWVRVmJnWWFFSEF3VzRpVFFSWmI4VythamczcFpkdjRrbzJ3aFJx?=
 =?utf-8?B?ZFRrZ2h3blBwVVRLU0pKa1lvMjFqT2NsMDRadVVTM05sU3BzMHNYOUJPY1dz?=
 =?utf-8?B?Q205VkZEN1hpRW9RV3FPSGZnTHhKWHN2V3lNSy9GK1A4bW12ZngwYXpmSzlQ?=
 =?utf-8?B?T2w2SG0rOU84MCtYWEh6S0pITjRmUXIyRmtiVGQzYXNQejZ1OFhiaUZtYURt?=
 =?utf-8?B?a3RwY1VOVkt0OFRNODBRYXhOaitaVTVNWGNDRlBWK01VQkQ5MHg2dWJrK3Fl?=
 =?utf-8?B?SXV0TU9aUmdjOWNsbHoxbUFuTWM2TDlDY240T2tzaDVsUktCN2tLaFlKUzVQ?=
 =?utf-8?B?ck5FaFluNEE5YnptTldxV0hKSk5qZHlFVTM4OUc3em1JUjR3UG9iVG5Yd0JY?=
 =?utf-8?B?ZExqbUtQclRwN1A2MXBnTDh6WWRxY1JMVWZPU3MvSEVBZ3BOTE1CUHVRTXB5?=
 =?utf-8?B?S0pKeC9IenZrdGJVaHUwYTJmUEhuekt2bG1PQ2trSWFHUFFXVFpWaFV6aGwv?=
 =?utf-8?B?cjVacENHWEMrMS9PVjVKMGp2VnAwblppa2U0ODBWN0lvcDdZMTBCRy8wY21p?=
 =?utf-8?B?KzZ1MzdOQ0NsQkNobTFpOEh4OGZuMkJVZXhpZWJ0Z0V5c2VIWE5NblZBekQy?=
 =?utf-8?B?RE85c1RUYy9SYldVbkZ4RzRyY2xrT1ptNUtqK1FqUFF6RlZYYjVDQ1pVcFNQ?=
 =?utf-8?B?YUl0ekhtVTZ3enlyaVdTZVhhbVJtL0Fmd2JOcjk2Q1QrNVdkcUMzdlRQZ1JX?=
 =?utf-8?B?SjJleURtQml0aTlpdDZHVzVYdERvV1pMVkd5SjYxeGt1ZWw4Y1h2TGFXWGhW?=
 =?utf-8?B?WExUdW1iMFB2UUxGMktoMWs2czZRM3hrSjBNRWJRTzVTakdsT09rd3hYODRH?=
 =?utf-8?B?eDJaVHUxNEd4c0Iwa0ptSlB5Lzc5UmZWL1grcVlqdmJUakhiWmhENU5uSDBq?=
 =?utf-8?B?ekJ3UTBvN29mRHZIcTlZYWQ4alRKTUp5dkJiZFRMeHNMMUo3NVgvbDJ3bitS?=
 =?utf-8?B?ckloR3dNNDNiUHYyRmV2TXF5ZUprZEZNRnFWMDViVXhZQWpNc2I1V1piZnAv?=
 =?utf-8?B?MDZqTHJZbDBWWDFDa2ZmV2oxQzYzdTdwNzA5OTAzZlJXME44cjM5cEhsOVFi?=
 =?utf-8?B?KzhIaHA0TkJIdDNJN2lrN2w4ZVBxbnVpL2djbDZES29vanJpckxEOFU5UzRr?=
 =?utf-8?B?dXlxeEVDNExTUDlpc0xsc0lqWmkrTnVmYjJKaTdmM2RkTEIwU05BNDVHcThv?=
 =?utf-8?B?MTk3NmpacFF4czkzWU15d1EyTngzZlhwcVpkYXBsdWthVFlhNklHTXNNaWlC?=
 =?utf-8?B?cUJaS05tUkFONDRjYzRMOUpmcVVJY242clBONnlPSEdmM2xDSDRpS2svWG03?=
 =?utf-8?B?aHBOTWxqVm51MzNJLzBEMkhzdlhvL3VvS251NnZ3cmJpM3hINjV6T1daVURW?=
 =?utf-8?B?eUFjeVRMcjlUak9LYURZY1FCWWJ1N25PcEd2R2k3UkVuOTV5TGsrVGNEZlFm?=
 =?utf-8?B?WHpPZ0dBSmhmY2luTndWQ3JGSGdtYkh5bi9iY29pc25INUNNSG9waVdyZEpn?=
 =?utf-8?B?a0RZRUxTY1hyL1BBRTJlS25HaHJOM3dlQ3RXeWtOVXJFeDNqUm5mV0h2OVJz?=
 =?utf-8?B?N2JVckI0amducUdqcUdVbi9IcCtrbXMvQ3dvUUlVdHhFQ2dQYXc5ZnpZWm8y?=
 =?utf-8?B?QlpHRWs3b2lqRWhHMFFtejRHNmxhUHE4V3BCMFRrOHhnTitkQWliUEg3N2Ew?=
 =?utf-8?B?QXNad1NUY0d2K0IrdW03SmdsczVteHZ6QXg4VjJubUNzZU1tVDdwd2pNSmdV?=
 =?utf-8?B?c1JRZjBWajI5YWYwTG1CY3lQU1NXOUdUaVlLcTQ1aFA5d2RCeFVGc0I3UWFk?=
 =?utf-8?B?NXZ3NjdtYXI1SzJ0enQ2M054RnFyMEliOWhBNldBTDNPdTdTRTV2Z20xUWEz?=
 =?utf-8?B?RzlkRWJCL1I1LzNSeXhYZkkyRG45VWVWOXpJWisxV1prSXhYOFdPRDdyVTI3?=
 =?utf-8?B?aSs5c2FyY1ptejV6ejVSWmpreXF5dUt1SGhqSEMyYkNBSWo1ZlJOQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef75c1f-5256-4b64-d8cf-08dec24e0455
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:29:07.1116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAu2UsMSmDq6l9e5hW4y6x4pEh2lVF9+NDNmnwmkZw5594vWJlluz6K7h5VvFm0LbKUxCa4iJf0mCYIb3anGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


On 6/4/2026 12:04 AM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jun 03, 2026 at 04:05:49PM -0400, Peter Xu wrote:
>> On Tue, Jun 02, 2026 at 12:26:10PM +0300, Avihai Horon wrote:
>>> Before switchover, the source needs one last exact pending query so
>>> modules can flush dirty state. This is currently done ad hoc in modules
>>> handlers. For example, RAM syncs its dirty bitmap in its save_complete
>>> handler.
>>>
>>> This should be a general concept relevant for any module, so extract it
>>> to migration core instead by running a final save_query_pending before
>>> switchover.
>>>
>>> The final query requires special handling by modules (e.g., it's called
>>> with BQL locked, during VM stop), so extend save_query_pending
>>> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
>>> flag so migration modules can tell the last pending query during
>>> switchover from periodic iteration queries.
>>>
>>> Not all modules need the final query; skip it for those who don't need.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   include/migration/register.h   | 41 ++++++++++++++++++----------------
>>>   migration/savevm.h             |  3 ++-
>>>   hw/s390x/s390-stattrib.c       |  9 ++++++--
>>>   hw/vfio/migration.c            |  6 ++++-
>>>   migration/block-dirty-bitmap.c |  6 ++++-
>>>   migration/migration.c          |  7 ++++--
>>>   migration/ram.c                | 37 ++++++++++++++++++------------
>>>   migration/savevm.c             | 27 +++++++++++++++++-----
>>>   migration/trace-events         |  2 +-
>>>   9 files changed, 91 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>> index 5e5e0ee432..6f632123f1 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>>>        */
>>>       bool (*is_active_iterate)(void *opaque);
>>>
>>> +    /**
>>> +     * @save_query_pending
>>> +     *
>>> +     * This estimates the remaining data to transfer on the source side.
>>> +     *
>>> +     * When @exact is true, a module must report accurate results.  When
>>> +     * @exact is false, a module may report estimates.
>>> +     *
>>> +     * It's highly recommended that modules implement a faster version of
>>> +     * the query path (for example, by proper caching on the counters) if
>>> +     * an accurate query will be time-consuming.
>>> +     *
>>> +     * @opaque: data pointer passed to register_savevm_live()
>>> +     * @pending: pointer to a MigPendingData struct
>>> +     * @exact: set to true for an accurate (slow) query
>>> +     * @final: set to true for the final query during switchover. When final is
>>> +     * true, the query is called with BQL locked. Otherwise, it's called with
>>> +     * BQL unlocked.
>>> +     */
>>> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>>> +                               bool exact, bool final);
>>> +
>>>       /* This runs outside the BQL in the migration case, and
>>>        * within the lock in the savevm case.  The callback had better only
>>>        * use data that is local to the migration thread or protected
>>> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>>>        */
>>>       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>>>
>>> -    /**
>>> -     * @save_query_pending
>>> -     *
>>> -     * This estimates the remaining data to transfer on the source side.
>>> -     *
>>> -     * When @exact is true, a module must report accurate results.  When
>>> -     * @exact is false, a module may report estimates.
>>> -     *
>>> -     * It's highly recommended that modules implement a faster version of
>>> -     * the query path (for example, by proper caching on the counters) if
>>> -     * an accurate query will be time-consuming.
>>> -     *
>>> -     * @opaque: data pointer passed to register_savevm_live()
>>> -     * @pending: pointer to a MigPendingData struct
>>> -     * @exact: set to true for an accurate (slow) query
>>> -     */
>>> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>>> -                               bool exact);
>>> -
>>>       /**
>>>        * @load_state
>>>        *
>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>> index 96fdf96d4e..10b3d78a5f 100644
>>> --- a/migration/savevm.h
>>> +++ b/migration/savevm.h
>>> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>>>   void qemu_savevm_state_cleanup(void);
>>>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>>   int qemu_savevm_state_complete_precopy(MigrationState *s);
>>> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>>> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
>>> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>>>   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>>>   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>>>   void qemu_savevm_state_end(QEMUFile *f);
>>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>>> index c334714b31..aed0c6844d 100644
>>> --- a/hw/s390x/s390-stattrib.c
>>> +++ b/hw/s390x/s390-stattrib.c
>>> @@ -190,12 +190,17 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   }
>>>
>>>   static void cmma_state_pending(void *opaque, MigPendingData *pending,
>>> -                               bool exact)
>>> +                               bool exact, bool final)
>>>   {
>>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>> -    long long res = sac->get_dirtycount(sas);
>>> +    long long res;
>>>
>>> +    if (final) {
>>> +        return;
>>> +    }
>>> +
>>> +    res = sac->get_dirtycount(sas);
>>>       if (res >= 0) {
>>>           pending->precopy_bytes += res;
>>>       }
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index fb12b9717f..95072d6664 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -622,12 +622,16 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>>>   }
>>>
>>>   static void vfio_state_pending(void *opaque, MigPendingData *pending,
>>> -                               bool exact)
>>> +                               bool exact, bool final)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>>       VFIOMigration *migration = vbasedev->migration;
>>>       uint64_t precopy_size, stopcopy_size;
>>>
>>> +    if (final) {
>>> +        return;
>>> +    }
>>> +
>>>       if (exact) {
>>>           vfio_state_pending_sync(vbasedev);
>>>       }
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 7ef3759e53..66ed91de03 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -767,12 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>>>   }
>>>
>>>   static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
>>> -                                       bool exact)
>>> +                                       bool exact, bool final)
>>>   {
>>>       DBMSaveState *s = &((DBMState *)opaque)->save;
>>>       SaveBitmapState *dbms;
>>>       uint64_t pending = 0;
>>>
>>> +    if (final) {
>>> +        return;
>>> +    }
>>> +
>>>       bql_lock();
>>>
>>>       QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 7488a94206..df8ed3a9fd 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2787,12 +2787,15 @@ static bool migration_switchover_prepare(MigrationState *s)
>>>   static bool migration_switchover_start(MigrationState *s, Error **errp)
>>>   {
>>>       ERRP_GUARD();
>>> +    MigPendingData pending = {};
>>>
>>>       if (!migration_switchover_prepare(s)) {
>>>           error_setg(errp, "Switchover is interrupted");
>>>           return false;
>>>       }
>>>
>>> +    qemu_savevm_query_pending_final(&pending);
>> Not needed for postcopy, we can move it to migration_completion_precopy().

While currently not needed (because VFIO isn't compatible with 
postcopy), AFAIU, generally it is needed because we have here a 
switchover similar to precopy case -- the switchover decision and VM 
stop at stopcopy_start() are not atomic, so theoretically a device may 
want to request an ACK in this gap.

But that's all theoretical and not necessary currently.

> A better idea is.. we can drop migration_bitmap_sync() in
> ram_postcopy_send_discard_bitmap() too, then we can keep this one.
>
> But then, let's properly document this, both for precopy and postcopy
> cases.  One example:
>
>      /*
>       * The final query to the whole system on dirty data to make sure we
>       * collect the latest status of the VM.  For precopy, source QEMU will
>       * dump all the dirty data during switchover.  For postcopy, this will
>       * properly update all the dirty bitmaps to finally generate the
>       * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
>       */

The last dirty sync is done a bit differently for postcopy case:
   postcopy_start()
     ram_postcopy_send_discard_bitmap()
       migration_bitmap_sync(rs, false);

1. The last_stage parameter of migration_bitmap_sync() is false 
(shouldn't it be true here as well?).
2. It calls migration_bitmap_sync and not migration_bitmap_sync_precopy, 
i.e., without precopy_notify calls.

If we need to keep the above differences for postcopy then I guess we'd 
need to introduce different final query flow for it. It may be cumbersome.
Do you think we should do this extra effort to support it, or, as you 
suggested, we can drop the final switchover ack check for postcopy for now?

>> I'd also appreciate a short comment explaining why the final query is
>> needed.
>>
>>> +
>>>       /* Inactivate disks except in COLO */
>>>       if (!migrate_colo()) {
>>>           /*
>>> @@ -3285,7 +3288,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
>>>       /*
>>>        * Do a slow sync first before boosting the iteration count.
>>>        */
>>> -    qemu_savevm_query_pending(pending, true);
>>> +    qemu_savevm_query_pending_iter(pending, true);
>>>
>>>       /*
>>>        * Update the dirty information for the whole system for this
>>> @@ -3336,7 +3339,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>>       bool complete_ready;
>>>
>>>       /* Fast path - get the estimated amount of pending data */
>>> -    qemu_savevm_query_pending(&pending, false);
>>> +    qemu_savevm_query_pending_iter(&pending, false);
>>>
>>>       if (in_postcopy) {
>>>           /*
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index fc38ffbf8a..4e3f442593 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -3376,10 +3376,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>>       rs->last_stage = !migration_in_colo_state();
>>>
>>>       WITH_RCU_READ_LOCK_GUARD() {
>>> -        if (!migration_in_postcopy()) {
>>> -            migration_bitmap_sync_precopy(true);
>>> -        }
>>> -
>>>           ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>>>           if (ret < 0) {
>>>               qemu_file_set_error(f, ret);
>>> @@ -3442,25 +3438,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>>       return qemu_fflush(f);
>>>   }
>>>
>>> -static void ram_state_pending(void *opaque, MigPendingData *pending,
>>> -                              bool exact)
>>> +static void ram_state_pending_sync(bool exact, bool final)
>>>   {
>>> -    RAMState **temp = opaque;
>>> -    RAMState *rs = *temp;
>>> -    uint64_t remaining_size;
>>> -
>>>       /*
>>>        * Sync is not needed either with: (1) a fast query, or (2) after
>>>        * postcopy has started (no new dirty will generate anymore).
>>>        */
>>> -    if (exact && !migration_in_postcopy()) {
>>> +    if (!exact || migration_in_postcopy()) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Final pending query is called with BQL locked */
>>> +    if (!final) {
>>>           bql_lock();
>>> -        WITH_RCU_READ_LOCK_GUARD() {
>>> -            migration_bitmap_sync_precopy(false);
>>> -        }
>>> +    }
>>> +
>>> +    WITH_RCU_READ_LOCK_GUARD() {
>>> +        migration_bitmap_sync_precopy(final);
>>> +    }
>>> +
>>> +    if (!final) {
>>>           bql_unlock();
>>>       }
>>> +}
>>> +
>>> +static void ram_state_pending(void *opaque, MigPendingData *pending,
>>> +                              bool exact, bool final)
>>> +{
>>> +    RAMState **temp = opaque;
>>> +    RAMState *rs = *temp;
>>> +    uint64_t remaining_size;
>>>
>>> +    ram_state_pending_sync(exact, final);
>>>       remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>>>
>>>       if (migrate_postcopy_ram()) {
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 23adaf9dd9..22cb6a15c6 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1795,7 +1795,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>>>       return qemu_fflush(f);
>>>   }
>>>
>>> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>> +static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
>>> +                                      bool final)
>>>   {
>>>       SaveStateEntry *se;
>>>
>>> @@ -1808,7 +1809,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>>           if (!qemu_savevm_state_active(se)) {
>>>               continue;
>>>           }
>>> -        se->ops->save_query_pending(se->opaque, pending, exact);
>>> +        se->ops->save_query_pending(se->opaque, pending, exact, final);
>>>       }
>>>
>>>       pending->total_bytes = pending->precopy_bytes +
>>> @@ -1817,16 +1818,30 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>>       /*
>>>        * Update system remaining dirty bytes whenever QEMU queries.  It will
>>>        * make the value to be not as accurate, but should still be pretty
>>> -     * close to reality when this got invoked frequently while iterating.
>>> +     * close to reality when this got invoked frequently while iterating.  Don't
>>> +     * update in final query as some modules may skip it if not needed.
>> IMHO this specialty isn't needed.  We can just make all modules report and
>> making sure we don't deadlock on bql.  AFAIU, CMMA never takes BQL, while
>> dirty-bitmap should conditionally take it now.

I didn't want to add unnecessary work for the critical downtime path, 
i.e., unnecessary exact queries.
I am not familiar with the other devices, but if you think it's 
negligible for them then we can drop this specialty (in VFIO I'd still 
like to skip the stopcopy size query; using the cached value is good 
enough IMHO).

Thanks.

>>
>>>        */
>>> -    mig_stats.dirty_bytes_total = pending->total_bytes;
>>> -
>>> -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
>>> +    if (!final) {
>>> +        mig_stats.dirty_bytes_total = pending->total_bytes;
>>> +    }
>> Then we remove this too which is counter-intuitive..
>>
>> The rest looks all reasonable.
>>
>> Thanks,
>>
>>> +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
>>>                                       pending->stopcopy_bytes,
>>>                                       pending->postcopy_bytes,
>>>                                       pending->total_bytes);
>>>   }
>>>
>>> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
>>> +{
>>> +    qemu_savevm_query_pending(pending, exact, false);
>>> +}
>>> +
>>> +void qemu_savevm_query_pending_final(MigPendingData *pending)
>>> +{
>>> +    g_assert(bql_locked());
>>> +
>>> +    qemu_savevm_query_pending(pending, true, true);
>>> +}
>>> +
>>>   void qemu_savevm_state_cleanup(void)
>>>   {
>>>       SaveStateEntry *se;
>>> diff --git a/migration/trace-events b/migration/trace-events
>>> index de99d976ab..1c9212d3e2 100644
>>> --- a/migration/trace-events
>>> +++ b/migration/trace-events
>>> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>>>   qemu_loadvm_state_post_main(int ret) "%d"
>>>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>>>   qemu_savevm_send_packaged(void) ""
>>> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>>> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>>>   loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>>>   loadvm_state_setup(void) ""
>>>   loadvm_state_cleanup(void) ""
>>> --
>>> 2.40.1
>>>
>> --
>> Peter Xu
> --
> Peter Xu
>


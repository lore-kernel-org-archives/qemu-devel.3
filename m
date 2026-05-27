Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52606CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9Tc-0005yI-1g; Wed, 27 May 2026 04:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wS9Ta-0005xm-Ka
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:18:54 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wS9TG-0007dW-Ov
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgElVHVXcMXOt1YkYt+oKmCnMmZ6MCJCXHQjjkUY3YBhuk62iI4gODT59WHqlKXj21zasdDg9oxxdiDVfli2o18B4UOvwXNS6sWh6kI2+dTPrJ1GFSHMDNQuny7lRbD+F7U8Bp974wHiMrPO/4sy25G3VpEgAJDKHrV09u1+FsRWEF8PkInJPM+Skbwieup0tA64CTNchbX/mrgubp0rV5opBSRuj4/tzfxVQAR9M3poJpEFfm0rfff7CErTBHsDT7OloWI7JlnwHXB2YKXtS/LjgNTLdIyn0aN7eV3CL6Ki7tdUb7WxqKemfROG2VsZEUEscJO6Dz3x4gvbvUL+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzWCqX1L3/tUC7hAFVgLwldrZlxHni9HNNQtftpUyZ0=;
 b=pFmOqxYyG4pL4iBc4639UF1LcG1S6wtTAcs+Q0NmTI6NJ83btxWXGaNQ9CCjdMJZCr3UMT5mDUQhbASLtcMx9VEkMrNgJBNi6IGhNXINsaJeRBGr1+PVuC+qDSxwQE2zO5VZiNSeQqljklomHnJwjrbcyAhMl1s8Hw5CKA2dIZ2r1g/l3K4faKQ2tcWK+st47i5szVbLRrT7RzEix/HLCES8K0hwoITcp4JNO2WtfILrEbE7rbufAiFSEzGg4LJSbniFxjBjHnGJTPy/06QUyjPoF41sAqsSBVMaBOwfsdKXkZhu/x7XwbJAFu40CtXGLOBa3ghDPRT552F8n9/TlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzWCqX1L3/tUC7hAFVgLwldrZlxHni9HNNQtftpUyZ0=;
 b=TTt/5vJakBTG1sSASDkkecKO+G3eKv6ypJqDRkGByN2vV1Laa2eDPZvljf1ZIupXTSGtrm03ETTtioHo6+4Cg5YiNaS0tHopcRsBx3IxwmflbMe4YDPLaZTOor0nmj4NUqhNXjTBBG5T2NlQcxPzSGbUYA/3ZnwnAT+nCrna/G6JfNDepYOnAiRE6LQWp32paP8qCj3+b3VVfLKUyNFK75uz83Y4Nkx1qrnytNelDcVn3dqxYxoqryFJHC+0bKSeRWregh5bD1woK5Vn+XiWIUZ6bd3XaelnHKkcE/6KPb5m/8VsdGsQu0+awHeJdJ8ZbRVFtKkVABvkHOOud9nrjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:17:52 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:17:52 +0000
Message-ID: <c450e363-22f5-4bf8-9c04-896ccb02938b@nvidia.com>
Date: Wed, 27 May 2026 11:17:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
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
 <20260505081423.28326-8-avihaih@nvidia.com> <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com> <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com> <ahRkT19AVwi4SQA9@x1.local>
 <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com> <ahXJD6QkXccf60Cn@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ahXJD6QkXccf60Cn@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe07740-baab-4c12-b624-08debbc8723a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: PrKH1wdBH4qBIIhJ5VdvlB7MBRnfGKl67Sb8DjV81tq7JqOmyRAKDIEcma9RTAL7hr/SOreaPjfxPwi7332gOnxIy0wmO11XgT2ROKmo76SHvw7RH5knwNKUdef2V/Fx7IMmwywu6IrzIDOHD0cb/Fd3M8f3ibRmKh+6uvljayJDdiwSJvU2w+uOv0uNl117kC9nblbzt/UrPt0956G8E99OPvpP9MM2SCVzBTSjNsu/EjkRK0e82Eo1NTwAwni1RWjmzD7ymlGottVoDImAOgYlZJbZJO+PF0HiqAVe8P2MJZLYOxkKBT1IaM/n5TGdDSUDb6XPeopgWP5moYCCRTEkyGuosUgrFz5d841I03l8Vkd00v78bReGUSeBTDlzLyY1hZGzHdRsm3TzdvvI20O8kgZbxjoKwpL0FEsJH1wOw6PAhdWzNcg6xByP0FpUZREXdEmDNK7AM3s0f2J2TcO23+sqaWtQN5bXSJCuB3lutFTF4ctcN57+zhwKq7oMcqKwaXLmV4s05kMp3vkWp08JhnrdFvd/MWN9uZJKKy89N3qRrShU+xNHCckrJ6prVb4wMlilVPBm+v4zvboR2H7smRI53/CDD4HlP5wABv+dSFtz5ZeyIDi7DQzuOioQ8gwkwOcS0F1eqXubW9xhZTiokNlaRJ96CP7VifJ4FmolshvtGJDQE043838q2u06
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJSNVpGZ2xCM1kzMDRtU1lTc3ZVOW5MdnloMGpVc2NGQVBZallZZzB3VUt2?=
 =?utf-8?B?UjcyQ01qclBWZk9qckpNZE9pam5QRzBMV0ZSTXhYdExLSGt6Qi9MMXJPRzJa?=
 =?utf-8?B?bHFiWmI2UUdPdmlzRDV0d3V2N0xwbFJEd0JQS052SHVOS3BKcUhKU216WG9X?=
 =?utf-8?B?NU5PbUdFR0llQWdwS3lGQWphSjhERjJwTHVUYk1JN2Q2S0pDTTFSblRmSTRt?=
 =?utf-8?B?UFRvTkJvNHZlSk53MVpPVXNQeHQzbEM5TCtta25nTlZpTTg2djk0VGczdi9x?=
 =?utf-8?B?V2V1WU45N25mVm9OSlBRMVVOVDJha29nRnRXb2pmajYwWTZBcld4K00yMzhK?=
 =?utf-8?B?V2ZhaXhweEFRM0htSlNVMk5tUHRwT0lIdVVZckNVOHZIY253QzdqQllYK0Vm?=
 =?utf-8?B?VUxRR1R1UHptdTEwZmVKdHI1QjRsZGVNSHJKOW9ETmVjSUdLWVgrb3RHM01M?=
 =?utf-8?B?RnBEenE5cGdJMVYrM3BnUXBOWjB3Y3VWa0Q2c3J6V2dybjhZaFphWFdhb0hQ?=
 =?utf-8?B?dU1UQ0xUSmVFbHdYT3FlTXlXUzNHOTkwdm1mSUJpdTR1VGliSmEraWczTW94?=
 =?utf-8?B?c0dHY085clJoYWhZT05YeENvdFJwakRoV3phT0taWlFGbHllQk9DTjVxekIv?=
 =?utf-8?B?SXFCTXRHVys2dDNQTXpncFpaRHdtdVR1MWpEeEFuYUw0KytIMHlqbENlRURN?=
 =?utf-8?B?ZlgvUFZpakV5aUJta0gzb2xNd1NYYzlxblNUMGpwbG5Za0tyT2tIQkw3TWNO?=
 =?utf-8?B?L1ZxUUYxa2o1cGxNSE94NWRmMVljZTdJek10WmRMZHhIWXVkZ2xudkRhQ2VH?=
 =?utf-8?B?ZnNKNHFnZmE5SUM1YlIrNC9RTGNPbnVJSzRGT3ZYeGNWdXN1bkVydEhoVlZj?=
 =?utf-8?B?b0IyZmswemVQU09Fa0x4OTNQeExiblphUC9KOE9EVUFGT05YZU1jT0JIK2h4?=
 =?utf-8?B?ODg0bmhrYU9QNmEraHlacVpHTWFYSmRJN2NURVp3TjBhMU5xSHpvelpIcUp6?=
 =?utf-8?B?bUZzRUgxWEhnSUpPbnEybHR4R255Vm9qZ3VUeEI5SXBhbWp0QnA0a3VaSjBN?=
 =?utf-8?B?ZDdwR0NxdzBhVHA5UE92M0w3R0x4a0M3WC9EckltZkl4U2pZL2JTWE90djBT?=
 =?utf-8?B?aDdLbDBOOFR0Qk8yaHpHQWVPTjNrT3k5MTBqa2hCd3g2TFJ3MHJRNzhnMldC?=
 =?utf-8?B?bmJPWVZOZngvWFNDaXVTbm0wQzVxa2kzL3RwL1VxangzM0ZVdGpNSW02SGIy?=
 =?utf-8?B?OTMzT04zZnluZm81V3l4STZVZlZRd050eFN0UGFiWSs4dmlpUmJLRXlyVGNJ?=
 =?utf-8?B?TEpxV1Y3WmlNVTkzQmtxaGQvQmFKcndTS3JIdGFLWGx0emFYVWYvNTVCb1V0?=
 =?utf-8?B?OEttbmFGbTZvMFNMQTh4TnF4VFlzaCsyTUdOM0JKRFBjQkk1bGxMdnd6bEpB?=
 =?utf-8?B?MmNmbks0Y1NCTEpmc29GTzBucE85QU1XazRSb2JPd0Fya2pVMkJxMXdjN0ha?=
 =?utf-8?B?ZkpSZFZLQlFWQTZFZWJUaUdHczdOb3dvUEFrRTZ2UVpMTldlU0p3M1gwRnBv?=
 =?utf-8?B?SDZvc3MvSldiY0VZaHVUZjlhMTEzaXo5dzVPdGRDZDZEQ3BpWElVTlZUZGI4?=
 =?utf-8?B?WDR1ZzJ2LzhtV0FEWjZnVW9PRXNLTVdiWEhSdFI3bFdLUXhSelA3VEtYUmVO?=
 =?utf-8?B?dzZOZEk2eGFBYzRONGxZdGZtaXdQODgrcFhiQlpVSWNjZk5vNTFyUXAyZndO?=
 =?utf-8?B?U2hHcjIvRVdkOHNpRmJmc29BNGJSMkxhc0NBNml6RUtMVTFRdDIwcE5YY0xQ?=
 =?utf-8?B?dEpZVENuczM5U0h3YXVSSXhUOWV4TWRBNVdBWjV2dHMwTzNqM0JLWjJ2eHE1?=
 =?utf-8?B?c3pMNTE4NXRSa1U2cjBESjB3L1hqR3kxYS9KdmVMRTVMdjZKZGNQSGVTSGhp?=
 =?utf-8?B?akFNTzAya1V0ZVFINHVoVmlSeS9BWEg5SXV5RUtTYzBDcU5CZm54QXlvYmdN?=
 =?utf-8?B?ZTFpWFlsMHZoMmZEQWtWaGM3SjVDQXp4U3NENEJpTk9oN01MNDVZMWZRd01T?=
 =?utf-8?B?L01GbEYvZUw2c0RwOWxXNlRsL0g0Nm5icFZkSGQ1eE04cElFSXRZMkZBZm5K?=
 =?utf-8?B?cTR4Y1ZBYnl3STlGdHRHN0NtcHkwOXNURDd4S0tMQjV0d0xnTWZMTTltNXpX?=
 =?utf-8?B?QXJBcmZOWklwNXk0RnJkaWM3aFFxOUhOeTJscWlxemVuWm16eU44TGYySGpl?=
 =?utf-8?B?L0o1MUxocUNpN3hJZGpvdWQxcm1wd2xibkhkVDNkcXhWTmJkV2hFcnJxaDJN?=
 =?utf-8?B?bGZEdmozMUlZd0IrdTV4d0JlKzl6Z3dOc2pWbnVoaWpRSmp1akNuZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe07740-baab-4c12-b624-08debbc8723a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:17:52.0900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzaGh9dtbq/zOwaq0DeecM2SmXaADTXwq64foNMppAnylfO2398Ld17WAqHK65NjmM/l0cYxJq+7xxN4LLoafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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


On 5/26/2026 7:23 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, May 26, 2026 at 12:08:34PM +0300, Avihai Horon wrote:
>> On 5/25/2026 6:01 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Sun, May 24, 2026 at 09:34:48AM +0300, Avihai Horon wrote:
>>>> Yes I think so.
>>>>
>>>> We just need to indicate modules that it’s the last query during switchover
>>>> so they can handle it properly.
>>>> Do you think it would be reasonable to add a "bool final" param to
>>>> save_query_pending handler?
>>>>
>>>> For RAM it will be used to indicate we are running under the BQL (since
>>>> currently save_query_pending runs only outside BQL) and to pass the proper
>>>> last_stage param into migration_bitmap_sync_precopy().
>>>> For VFIO it will indicate we should not do a query precopy info ioctl (which
>>>> is only valid in VFIO precopy states, not while VM is stopped).
>>> Yes, a final boolean sounds reasonable, implying both (1) last sync before
>>> switchover, VM stopped, (2) BQL held.
>>>
>>> For VFIO, I double checked the complete() that does not depend on the
>>> precopy_bytes fetched, then it should be fine indeed,
>>>
>>> vfio_save_complete_precopy():
>>>       do {
>>>           data_size = vfio_save_block(f, vbasedev->migration);
>>>           if (data_size < 0) {
>>>               return data_size;
>>>           }
>>>       } while (data_size);
>>>
>>> It's just werid to see that it doesn't depend on either precopy_bytes or
>>> initial_bytes, even if logically it should.. this will be confusing to
>>> whoever start reading this code.. but I understand not much we can do with
>>> the current kernel API.
>>>
>>> Side note: should we still better update these fields to make sure they'll
>>> be zero after migration? That means vfio_update_estimated_pending_data() in
>>> vfio_save_complete_precopy() too, with/without further sanity checks.  That
>>> seems to be missing right now.  I'm not sure if it's intentional.
>> Yes, it's intentional, since we don't use these values after calling
>> vfio_save_complete_precopy() -- they are only used for downtime estimation
>> prior switchover.
>> Precopy_init/dirty sizes are zeroed in vfio_save_cleanup() though, but not
>> stopcopy_size (however, that's benign, since upon new migration it will be
>> reset before used).
>>
>> So calling vfio_update_estimated_pending_data() here seems redundant to me.
> Logically migration can still fail during complete():
>
> qemu_savevm_state_complete_precopy():
>      ret = qemu_savevm_state_complete_precopy_iterable(f, false);
>      if (ret) {
>          return ret;
>      }
>
> If vfio_update_estimated_pending_data() has the safe guard for any form of
> overflow, then IMHO we should try to maintain those counters if possible.

Yes, we can call vfio_update_estimated_pending_data() in 
vfio_save_complete_precopy(), but I am not sure I see what's the benefit 
of it?

If it's to ensure these counters are zero post of migration, then even 
if migration fails the .save_cleanup handler will be called and zero 
them (I can add a patch that zeroes stopcopy_size as well).

Thanks.



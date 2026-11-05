Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53587606B442
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=JC8OTOxS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOztA-0003IZ-33; Thu, 05 Nov 2026 11:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xOzsu-0003H4-BP; Thu, 05 Nov 2026 11:00:20 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xOzss-0004DW-LC; Thu, 05 Nov 2026 11:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOOzTTo9DiXVW7Ii/GkYU+GJ5l77GF+7SFfe8xRbi/YOgSGzvZqLLLJPbECEVVwYfzNQ8yteOz3lAK+VbQp4sX18gZabq5lroXRYG7jqVDTXNk/I4EaeBEaDavTz6vMr1PfXNyuQ94wyQlVan00ipXNNQCxGhPYP5eZqVGn0g5uisNuBS2+mB/sDLg4aTXJVdfd4gLHBzSykC/dC29SLMrI1IAUcaVXCg0KSIuX92iKHG8rfJHIZju79eHJucoEjet3wKCl96vBsYBtZvLvNQyQMDzQqv8hdYHjorZnHGcjT+ta954WxNkDpRcxwMjBEzG+6t4LQ37n5OolRctwDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brYorzOSagSxwZc/0B0IG4Ci64FtD4RmSeI/VM9TISY=;
 b=oVr03BLV2UX/dbyMCucgiqTnllL6IvTzzc44bMaysfCpS3UF9lmn7qAJyy7Nth6ELmad5twUj6HfEenXU2bwBmrkKOXU6lFTI6fudfmbkfWw2E9ta1lti4LWmz7t7r6iHw6Cje3P3+E9obnBP5NbnyQ1oi6QQHP0hFvEpr5FBHTDqc8iuGKwFq+/ZF5qjYznevnE+a+gbAePjCej4JCYZtGVIZ+hpl88HyMiOivNZwXd+zGGJkxBcX/6UWPge03oZUO+TqECkC56hexPUmP/OKNYwwLzOb4HYpbxSzGsZxZcDaxBPYN7xt8IvW1IC2TRAyIAJIjXpJpgQ4YZXSF33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brYorzOSagSxwZc/0B0IG4Ci64FtD4RmSeI/VM9TISY=;
 b=JC8OTOxSJPmYUKo/6WT9HjTOFSdRtHfbxcZTVgNGkWekCSXVGmvLRhdt83UPLlBv8HcP2qNn6X8JBKCiQ7XVA13NeNqkQlfGvrgJmr/CAsqVc/0vVvhnQHVHSyp8aX/3uPBetU1wYJuBN+RDHl65MK2YPI8lu4BZSZFxHAWCbTMNzaWKBnS6oM4kcrrkzE5zZG8OKbeEWo1hM77NSNoGz93BKTQDgwG+dGBA5llEyKki8Sag5mDy2b5vQVp/bo9RZ/WusWDjRSw61F3udrMyHzR6dkTXGZSLThZtTH8fig3Rl9F0Pz2Mqsj2gdu+CO9PeuUmcFQuHv0c3Cp7Um9e/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9443.eurprd08.prod.outlook.com
 (2603:10a6:10:45b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:00:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:00:08 +0000
Message-ID: <0c640688-0282-482a-9994-98fedff1b58a@virtuozzo.com>
Date: Thu, 5 Nov 2026 18:00:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] qcow2: fix snapshot data corruption with
 discard-no-unref=on
To: Kevin Wolf <kwolf@redhat.com>, Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 den@openvz.org
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-3-andrey.drobyshev@virtuozzo.com>
 <713e8c49-5a9c-4d42-9038-8b6f9cc70260@dupond.be>
 <auoGkJ_RCxFRjh3U@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <auoGkJ_RCxFRjh3U@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0932aaf8-8426-478a-ec52-08df3b55dd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|4143699003|56012099006|5023799004|261026121527099003|261028144727099003|261022105027099003|261022115727099003|261009223027099003|261022075727099003|261102123227099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 7xCf/L+hhHPyZkAEqE6qJ0GdkDzbRAwhrJ+6/a+cEipEXilv9WtfBSbXxXtuxy+3ULNJ+22ULDCqGeCXdIkXai9xMhHujRJy7wWPzbvMMM6jjivwk3Z1S3QfZYjB7JXJ0dbVlNxkzUfXs62HlcNcqXyB8tKkYlsPYPSO5+8Mbc8St02O+LD74+HH+Hqydy/GCvZQ4fLsZcOil8FnVp0uveEncw/nJ0csQl6sdw9tQTeM8aRbIuMUNZiMEXqLYObb8TXaSlG8kxapFHynBAdVoGn0ajUARqZY4gwgYG8HoYvuKfI9KflnwLW3joelUfyIE4Qj1VnApVkMrB9ctgcbGsFLA4V91DpNlv64OLwuEsFFAycWdbPpu0cHZvuhRN4g9IkdCk54CKqY8SbONniTMnLzbZ7jUW0sn23XTOJ/WPo2GwLkVIt954fBgqc4zS7EtF9U5it9+sQkqCz4txKytiFKzEmAPseKJZzZrW54JG3L3+f28+LNTiy4HvnvHQrXYx15xLr2bGRSWlL6DjfVQ9/I78xz3i7k93cBCOwnSMDnOD2SFZMQOFz7L4Nwfj2a1tufArcHTPG8mN6cFOLEHucVroQprQ+4wmyC/RzcCP9Nl84uDS8N9TlkbKS9eibqFgsrcBFqwmkGoMMQ36pgI0tPb4v9wEkwznPSZboo4xQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(5023799004)(261026121527099003)(261028144727099003)(261022105027099003)(261022115727099003)(261009223027099003)(261022075727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhUazFhMzRJTFYxL1g4Wjh2UXZYZFlGdG5WNDV3THFYOU4yZm0vV3NHNXFR?=
 =?utf-8?B?TlUxSUw1ejFHUXFiQWtBQzQwb2ZrTGNmMTVtZE5iWnZ4d281dUxnT1hNRHFn?=
 =?utf-8?B?V1BhUWhzRnhkelZkaUdZTXgxQUpEanVyTWNUUjNSZ2hjbEZuUk5mZForYUh6?=
 =?utf-8?B?NUN1WlJTQTdKNVh3NEQrS2tTMytkK2xrQWpzemg3Y29nRXh0d2NOZWwxaU1v?=
 =?utf-8?B?NC96YklDQVhNdWh5Z29Obm11YkV2Ylk5cGJYMEVmUEw0c0JjYjYvN0Y1S3ll?=
 =?utf-8?B?T2Q5d0xBZWhiU2xtNlpHdTdKdU5QZEd2TTN1Skg4TWtVaER4dEk3Q2V6djZq?=
 =?utf-8?B?VTZCYng3eENnL3FSMUZRVy9kdzZmbEFGMjBjSWxQSlpvUkFoVmNJSTk5dGJ4?=
 =?utf-8?B?dWMyaTlrdVFGK2ZvN1AybklVUUJkOUMzbFRZZ0hpWEQzYmNWc1ZZN3c2dmxr?=
 =?utf-8?B?eS9tV1BFRVhZRGE5VzJKUHJ4b1E1VnBGbjdIMFRSQWIvK3pEdkdFbUdiUjZt?=
 =?utf-8?B?YVdNTzZKQkVQSjlLaXBZZFg0Nks4OGMxcXhPSndsWDVJWFBWc2hHWi9vYml2?=
 =?utf-8?B?QjJycFh3V2tDc09ObERPOGRKRi9QZ3BUSGNGaTBQazF5Q0Fjd1cvSjJPUEpv?=
 =?utf-8?B?UlhDa1MwV3k3Lzdqc0R6LzRaQnhrY2E3Z3h4SGtueUxMOFBFejhPRmJMRWlT?=
 =?utf-8?B?R2xTWmY3TnpDcnNWM202THhhVHp2M3JBYXlJSzBGTGowQkVTdlVMRFB5dHd3?=
 =?utf-8?B?YWFDSm9wQ3JyWGc1ZjQyYnIxYlViRGtLSDE2M2VOenZpUyt6VUJNRUZ6bFQr?=
 =?utf-8?B?YXUrQ3ZWNzZseWdlQmN1dnd6YmJGM1l2WUNzWjh6b2ZIOXNxdjlRNHN3QmFx?=
 =?utf-8?B?TzVSaWpSSDFxZ3VBeURzYldaWVhacEdDQ3d1KzN0UFhneFRUajYwR2p5Tk85?=
 =?utf-8?B?SHVqNjk2Q0s4SmJmdHBIZjIzOUcwQ28xRTRtVE5mYVpKcU9NY3FoMDk5UGlq?=
 =?utf-8?B?SWs5cERlUU51WG5XMkJYWjJEOUdlWjlDQkcrUkxyZWkyVFMwUUtkeE8zZkNO?=
 =?utf-8?B?RHIvM3dOb28rRnZ3bS9qeXFVcnh2TXc3S3ZRYWRXeEF6WWFra1lra1JZakhC?=
 =?utf-8?B?WXdsUWZpUGFRL0wwNGNGa3Bkd21qdEJvQUFFY1R6NVB4ZFBzNDZSb0VOQmFT?=
 =?utf-8?B?STBxdHlmVjFodlNKSGVGWjdDODcraEZ5T0tyM0cxOGVjdnVBQkdFVHlPdHFR?=
 =?utf-8?B?QlB1M3c4YzRjaW8wQUJ1UGE5QzFseitDd2JhZzlSeFcybnlVUk5HY0hKMUIy?=
 =?utf-8?B?SUxGTVArZ2lUTTRNZkFncDFmQ3RvdHh2QmRmZ0tiamRIY3VteHVyc0pNYjFR?=
 =?utf-8?B?bW1QeEpadXZ3TXA5KzlGNEY1ZFBydXBQL3BndW5rSVgwM25PSVd3VEhMQmZI?=
 =?utf-8?B?T0JkSTdaK0VkL0FBbW5LV0RhZXhhQjZCMU10anN4UVpqV0N3cTBBMXhZeHZ2?=
 =?utf-8?B?c2RSZGhnNE5Wb2VMUlNUTGtKaW9pcGR2WkwxckIrZEVvZ0dIZkx5TFBSVkNt?=
 =?utf-8?B?VjNLVTE2R3hDN0czN240TVRRWkdjQTgwalFPS040UGJBZGtUcmJ0OUxzZkVC?=
 =?utf-8?B?SUQwMUQ1RmZlNENWcDZtTytidTNsdkJBS2dQNkozMHpROFJLN2UvTExGck1n?=
 =?utf-8?B?elBDd3VDdnZnYlVMODdjZ3dwNjFjOEI3YmM4Vkl3QmUvSzc1TFNkQ2FEZFlw?=
 =?utf-8?B?eXFxWWlYOTd5d1NlNGN1S0piMnhrSjUyV1ZocW81c3FmRXQzQmpSemxBbE1o?=
 =?utf-8?B?SlRtQlV4NU4xRUhOaGtJL0Y0YUxlclhrcmUrbDNqMWJsbDVhRUQrc01ZVURw?=
 =?utf-8?B?UU90aVlFNUNLQ2RrR3c0SXhqSUZwT0hDQXVWV05hQlR4bmd3TXczaUZGZS9Y?=
 =?utf-8?B?VTh4WmNRdHB1NnNMSTA5MXp0VXNnMUNiRmcwK1FVbmwwK2RNcXFibXYvVW8r?=
 =?utf-8?B?RW9TUmxCUE0vZ0tqd2xocWIyeE9yc04vRGk4UERrR1poWmxFMGNnbmxTYXA1?=
 =?utf-8?B?blh2Yi9oeU9FZGdLZCtjVkRZVk41MUkyOFdFd2JXRkFBcm9HQy9QU21oREUw?=
 =?utf-8?B?cm5BVm5aRDVjSEY3cStvd0tnREZRRU5FSjFmMHZrbGgrQUdaQ2dhQlhacGRZ?=
 =?utf-8?B?U1hWNzJRaGZEbm1SUEJTcHhiVHF0cUloSmlNWlpWS3p0SEhISlNiRjNwdVRT?=
 =?utf-8?B?blNTa0ttSzhWWm8rT05oTjlOV3NuT3pxSUFWWEhuUkQ2NnhkcWJTS2U4bGN5?=
 =?utf-8?B?NUdmN1JpNmZzWE9EQzR3ZWZmZDhwc1ZUSWhNZldIK01kazl1VFRjeEd3YVNU?=
 =?utf-8?Q?xCHV7fQ7mQGq+IDM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0932aaf8-8426-478a-ec52-08df3b55dd17
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:00:08.3147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQV0/1/kYEb53aq5FMaprvDfHu3l6LGA84V1r3G3qbbLjrwNyG+beSp707kcYkYoHy1Zi80ZodAo33aULFWBOyemavrcNTDeFsVYghj6kuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9443
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 6:06 PM, Kevin Wolf wrote:
> Am 29.10.2026 um 15:58 hat Jean-Louis Dupond geschrieben:
>>
>> On 27/10/2026 11:44, Andrey Drobyshev wrote:
>>> Whenever option discard-no-unref=on is enabled, we bypass refcount
>>> machinery and unconditionally punch hole in the data on 'discard' and
>>> 'write -z -u' paths.  However, when this same cluster is also referenced
>>> by an internal snapshot, such operations lead to problems.  The active L2
>>> table is copied before it is changed, so the snapshot metadata stays
>>> correct, but the host range under it is punched out and the snapshot reads
>>> zeroes there afterwards. qemu-img check finds nothing wrong.
>>>
>>> Fix this by guarding the 'keep_reference' flag by the presence of the
>>> QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
>>> punching if we own this cluster exclusively.
>>>
>>> Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   block/qcow2-cluster.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index e02fae6a0c6..cc473c7c796 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>>>           QCow2ClusterType cluster_type =
>>>               qcow2_get_cluster_type(bs, old_l2_entry);
>>>           bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
>>> +                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
>>>                                 !full_discard &&
>>>                                 (s->discard_no_unref &&
>>>                                  type == QCOW2_DISCARD_REQUEST);
>>
>> Wouldn't it be better to gate only qcow2_discard_cluster when the cluster is
>> QCOW_OFLAG_COPIED?
>> Cause with the above change, we fully clear/remove the offset of the
>> cluster, causing fragmentation again in the image afterwards.
>> And that was just the goal for discard-no-unref :)
> 
> I thought of this, too, but merely because it seems to be a closer match
> for the expectation the name "discard-no-unref" sets.
> 
> In practice, I don't expect that you'd see any advantage from it.
> Writing again to this cluster will cause COW, so you'll get
> fragmentation either way.
> 
> Kevin

I agree with Kevin here, because for clusters whose refcount > 1 keeping
the offset gains us nothing.  Any subsequent write to such cluster will
go through handle_alloc() and allocating a new one.

So I'll keep this patch as-is, if there're no further objections.

Thanks,
Andrey


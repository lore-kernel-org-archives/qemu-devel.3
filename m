Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D47CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaUZ-0007UW-MN; Fri, 02 Oct 2026 06:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCaUW-0007UD-BO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:27:49 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCaUU-0004Kh-7o
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:27:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hceELEJOJLB8r+Yw32gJPuoJ4vaT4rqnWqGCZtR6pRYhheTPC4bGvV2WZkPiFw8fNR5Qgn3DD7QERtG2ghvYUWDHoU0tvuQBJk7eqhtB+l7+XcBesub6RWtsZCXz49iRYChQpv8N2nOPUqcdt+oQzso+xM/NyWZXIw72JXnKVtw9aeXk7iBpFV6r5ESnrpXMqwoxgwBz4Fc6mwtZI9UQbLt1hLeXieTVsOtlPZyN7sYy6/Go8rBdP7qLgVtFEDdPbke654kEZMOWBCiD0cUHytH22fqQa8uUA1xG9InIQAt+efHiHFImgwTzgL/Bo3z0Pt0ORoH/j8VO16/7Wgd1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg7ngdfT/RzmVBgNg5e0P83/28X8bRsfnoWI7DgnLjo=;
 b=QD2FsuYHj5RL4q+E/q63eccmsQxFWtC8VxSKPWDF7P6nug0kegqrHUL87U69jq08Q0wQPQeOlt9TjFYn/c2wnweZTxgNyu+Mt0WzD8EhLqBJodeWDAqLRyDjtdl0fL2vtgp3oSZOqOow6DGBY1yX7hyHxCUJB6U7fCjeA1oZHoBimGkiY6L6HHpo47ePzz8VYVJGxIQ6dzx1KMdELoFE2I6mS3zYxXtjfDPj+d9cjB0qFu17dMP57QQrLoY2gt1y4EogSdfCC5w3VdkkMlHSGLoTdPnM22aiTSWb/t6yRGAGG8bwJpAVj2zO1yUBppO4zOROpiPvOLXOpi6aULjWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg7ngdfT/RzmVBgNg5e0P83/28X8bRsfnoWI7DgnLjo=;
 b=tyJjKR6I/Wrw3WSkOQfUBdmfZADtYat+yB/4gZ48iTt1sCD47UIGwEiZJR2DdLiYAdMZHjHpt5CjFlNMWt4OxL+0LAoRPu/gzl79c5Nmp3iOgSq6y0t6Frc1nSFIgd9crWe8cl63j7tR6gyf+MpDcrez2x7beRepDjZ0qCRbH71LHWzZT0pJPISW8FvhCBlci8T8Wk65xbO8KhVjdMCOLtpRJ6ok+mi7cGsbBlgCkLP5+VHNKXHCTts3b1U5Uo1p7VGBFDrYNKfRn4cHs75Cx6+ujOgsqN0DY/DTypEmV92kh0SvjNLgOFa4msf/Ny39/CyiFPV8NBJSBqCZr+orYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7585.eurprd08.prod.outlook.com
 (2603:10a6:20b:471::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Fri, 2 Oct
 2026 10:27:06 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 10:27:06 +0000
Message-ID: <806532f4-5240-4683-9a65-68fab6fd6d58@virtuozzo.com>
Date: Fri, 2 Oct 2026 13:27:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/18] vhost-vsock: hand off device ownership across
 CPR
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: den@openvz.org, dwmw2@infradead.org, peterx@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, vsementsov@yandex-team.ru, farosas@suse.de,
 mark.kanda@oracle.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
 <20261001-up-vsock-vhost-v5-v10-16-8c094843e98b@virtuozzo.com>
 <8599ac70-7443-4dc9-975c-ee59166354ac@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <8599ac70-7443-4dc9-975c-ee59166354ac@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbb54dc-0b89-4884-cd9a-08df206fb547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QCD1NfMPcuy7PWYS5xZWw6PtoKdo3zWMOgUROryqJeyTMekYLT8L1qpoKb8PKsK6mwwjFFL04rqfDSu407NNXS1gz0DV9MzL8TCfU5nlfCOciO6ct1qm28XwPBRjrf5/zyzGyHrazzBnaFhvdMy9FaBhv0m54KkMYk9tonyPjlpXsW/clBLwkIkM4JGTVjuxRdfD4B8UFGXa0gr2WB9RekPJWC6HXXZ5XcyvGzuPTUoZgtyvI/rMZgqnRB6Mh0aOUiWXZq1ITjbLRG4h5IyMdOplCXgIZ2hn6b+IJWKq24E0UTGZpdK5abhmJWvkSVrev62x2WWAXLenoneXyguUkRnUFD5o+/FFkZgAbfU4waeB1VxfVSNt8qYgbow5HIuWQEU7tVIvpjeL/jp4JHt1CmKRjqXU9wRNn4JB232YkEdqo91Gu7AVM/8YMtrWJopoF/FXVRghfQh/oalWcCYJYxDfcgJoWBPFXpb5TCoschljPYazbjb9qqhTnzaea8PnTTylGua5HNajxRvE3G1T8YBGshVVVqvnRXnFOrlaV/dK1X373Gx2WFbI+D5wEK9Ox+Gp5F6z0Lt3qubGzeqNYAatQ3o8GBuorkuwj4jmzVyQ49ho/3SHBr18MLMQYayKsO+o0grRdAHcv4SJucp18+oJDUHIj+YFgnsA9goozNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NWZ1hua3hEV2lveGNJMGY2NHpKblMxOVdXM05DKzllY0JxclkzcWFrWSs1?=
 =?utf-8?B?a1dMUEdndk1aSVNlRjJLQ1RKd2dFYXMzMFQxV0RpN0J1blpwZ3BpclhRT0Z6?=
 =?utf-8?B?YkR5S0lQVHdpcWY1SXdaWCsxN3FHekJyQVNYQnZVSGoxb1JKSFVVS203VC9J?=
 =?utf-8?B?WGZtL0NJZWdDbWRMcWhROVl5R3hydjlXeDZBMWhZVE1uWHo0cjh1cUI4S1ZX?=
 =?utf-8?B?WFBDcEhaZk1RVktVUmFzQmRuZXppVExxQmxBemN2SUN2T2tCY1lnUHlRd2Yz?=
 =?utf-8?B?bjBBZVNYMWRETFhJV0MrQ0NwNEFyVjY5R1JLR2p3VlhNR3U3cU4yRCtXUStr?=
 =?utf-8?B?eDl0RmRUbWtPczZteWEycHBFcExaNkJHaG5sRFBaUnlDSUtqYXBONURKVVVK?=
 =?utf-8?B?S2RQSURjaXR2aFA0dkUveFdtaFZqZmRzL0ZkNlVZK2REbktMMkd6VDlKeEc4?=
 =?utf-8?B?WVdCSXNvRU5YTHA2OVpIVzRDOU1lbVFkVkE1U1V3dnBRZWIwWXYrdEhDQ0Mw?=
 =?utf-8?B?OGllQ3ZLZ2pBSEZ5Sy93TExhc2p1aExMSGl4ZVBFRlRtTXZiUE0rTEowckh0?=
 =?utf-8?B?KzErWUtBckF3NTd5dkMvTXRBSmZEdnV0dCtSSnBXUlZyUzhvRG9JNDlWNjRJ?=
 =?utf-8?B?OHd3b2ZOeVlkWEkvNXAwY0R3MDhJbEpwcUMrZzl1dmdXYmt2SmF3cktnb0pU?=
 =?utf-8?B?eUpoSnV6b1UzakVMaG90Q0MyeFBBUG1nb0ExM3ZsOUcrcitxRWNRYVc4OVEr?=
 =?utf-8?B?Q3h6RHpCM0RFaTlHM21GbnJ5elFyWUh2dTRib21pOUVVUzY2U2tPbG9saUN3?=
 =?utf-8?B?T0ZDVzNMb3lsYmlLZStTVXh1cmR2d045bjZFaEFveCs2bTlNdlZoUU9yRytj?=
 =?utf-8?B?RnRsYm9DUWRObDRnU3VibGVCbHVTOGdCNjJlSGxoVVlzUFlZc2o3MkZ5WUtm?=
 =?utf-8?B?TkkwSGNybnMvYXFrSDJQb1pQMklOTGZIK3oyY2U4cFZSUk9PWEVpVk85ZFhy?=
 =?utf-8?B?TlZPWUZleDFTWE5kdit3RG5uT05vZlVoTXlSY2E1bkVkZGt6RW9maWNSOXl5?=
 =?utf-8?B?anJDNExjOFYzbzQ0eURlS3p1OTdYcG8rVkhZUnU5aUY5Y1Joelh3ZkwyS2lp?=
 =?utf-8?B?c2JUOEQ3NUVLdXlUR3V6OWp5cEh5Q090bGluZWw0andzUDU5TkVNTW5KLzlQ?=
 =?utf-8?B?azBONjBZRmt0OGpXQ0tNNzdSZFJwUnJpdTZqOXJOWTdqMjhNbno3RVhuUkFj?=
 =?utf-8?B?ZUZ3QUt0KzlpcDJ2ZVdzTzluVk1XUFQ2MUIyd2tZTW5aUDd3MS9HbjNESU9G?=
 =?utf-8?B?djRWV3RjY2o1WTZ3eE83YXU5S2x6M1lQUzNHS2FXV1hyNk1RMGpNdVkyUkNZ?=
 =?utf-8?B?bHFmQjVmNVVyci9Mc2RDQzRXL01vQnBtKzNYenFjaHVpV0FhSjN1MFlSaVJq?=
 =?utf-8?B?QVJZOVpuWmFDRjZ1YUVzczFGQmVKc29oeGZaN1JSQXhYMHJrb0dBREVqUSs3?=
 =?utf-8?B?TkNmTDkvQ2crWE9hZk85TUlkblk0STZvVURhMEp3MWs1Q05SRFUxaU5GT0M5?=
 =?utf-8?B?NngyZU5Oc2IvSHZITGFvSGRveEREdnJTQUZqZTh2UHcrREhKajhQSnF2UW5i?=
 =?utf-8?B?MElielVlcDZmczRaTXFmY0V5OEFndW5xRUp0dFRHa2VhT3lIUno2WkdvSnB0?=
 =?utf-8?B?WnNKd0hVbXdnVHl6VnlERlFramJ3RFcyQVZaWHJlZmRQWHpLdVZWRGxQZGhv?=
 =?utf-8?B?Q1IyZlU4SmhKL1RLcC9hMnJRVzhpc21WcVQwRnB6Wk5RZ0xGaEtjenNhQVJW?=
 =?utf-8?B?cVJFbXZUbitVb2lEVEViSVc3VHprQmV4WUY3TXlDbU1nK01DZzA5SktEVkRY?=
 =?utf-8?B?OTNFOTZnTk9oQVE5dmNSSHdjNGZscWRINHVFRXNTUUJOUU1qM0hKMEtqWVdh?=
 =?utf-8?B?VlRDWC8ydGNpdG9pSGNyaEhaaEt2a0c0OWtLVmJFVW5DOW5meVJibko1Y1c4?=
 =?utf-8?B?Nlg5WDlpcXBCS0ZpVjc5VDl3bWNLVEZGbHA1UE44TnNjUW4ybU56cGZ0OFVH?=
 =?utf-8?B?dEtQS1RtRmc1dkxqY21kWndvR0NlZ09iTWxTbFcxd0k1aXdtOG8zU20xa1Fp?=
 =?utf-8?B?Q1BhdWtQVllYUUQyazliSWxpRmxpZWc1OHFDYWZkVUZyWGlnU0xNa0s3TmIv?=
 =?utf-8?B?eXVrL1ZIbmc3Mlo3azRjUFVWdGVxRjB5SkQ3SmpOWjhqSU9XYnVtSTB1S1Nz?=
 =?utf-8?B?T3gwcFUzcGUwYzhZVDl3Z1Z0cENFRlRrVG5TUDQzc0FxbzlldnljTmZjaGd6?=
 =?utf-8?B?SE91MlBUZ3B4N0FYZmtnVW5BNG9jMVFQN0RBY1MwWFpYNEh3NTNIaGhKNWww?=
 =?utf-8?Q?dn9BJR5iaSA2U3uQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbb54dc-0b89-4884-cd9a-08df206fb547
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:27:06.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bh2RU4vRG70kME/z82eu0yE0FFPIEjrnaTI3n3LuG8Tu6lxlSciYaGmCOYnO/y1OwIK7iuR28ts2dT/YQPHNlk/SuZikAHq06hYQuN436M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7585
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/2/26 6:33 AM, Akihiko Odaki wrote:
> On 2026/10/01 17:25, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>
>>    - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>      the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>      cpr-exec).
>>
>>    - .realize(), for an incoming CPR, only sets up the virtio device and
>>      queries the backend features by calling vhost_dev_init_backend().
>>      It doesn't take device ownership and doesn't touch the VQs which
>>      still-running source might use.  The full init is deferred to
>>      .post_load().
>>
>>    - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>      (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>      the device is started at vm_start.
>>
>>    - .set_status() refuses to start a device whose init hasn't completed
>>      yet (incoming CPR before post_load).
>>
>>    - .set_status() re-acquires ownership before starting the device if
>>      pre_save released it and this QEMU is about to run the guest again:
>>      the migration failed, or it completed and the management resumed the
>>      source (e.g. cpr-transfer target died).
>>
>> With the handoff in place, lift the CPR blocker.
>>
>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
>>   include/hw/virtio/vhost-vsock.h |   2 +-
>>   2 files changed, 128 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 6e89007b2ce..65ba573da4d 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -21,7 +21,6 @@
>>   #include "hw/virtio/vhost-vsock.h"
>>   #include "monitor/monitor.h"
>>   #include "migration/cpr.h"
>> -#include "migration/blocker.h"
>>   #include "migration/misc.h"
>>   
>>   static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>> @@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
>>   static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>   {
>>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>       bool should_start = virtio_device_should_start(vdev, status);
>>       int ret;
>>   
>> +    /*
>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>> +     * post_load.  Refuse to start a half-initialised device rather than
>> +     * issue vhost ioctls on it.
>> +     */
>> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
>> +    }
>> +
>>       if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>           return 0;
>>       }
>>   
>>       if (should_start) {
>> +        /*
>> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
>> +         * source, after a successful RESET_OWNER op.  If we end up here
>> +         * with this flag set - that means that either CPR migration failed,
>> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>> +         * target died).  In either case, we need to re-acquire device
>> +         * ownership.
> 
> I'm not requesting changes to this patch, but there is a case where
> the source cannot reacquire ownership:
> 
> 1. The destination successfully completes vhost_vsock_post_load().
> 
> 2. A subsequent load error, such as a truncated VMState section
>     footer, causes the destination to call exit() without reaching
>     vhost_dev_cleanup().
> 
> 3. The source still holds an FD for the same open file, so closing
>     the destination's FD does not destroy the kernel backend or
>     release its retained owner.
> 
> 4. Resuming the source with cont calls VHOST_SET_OWNER, which fails
>     with -EBUSY. Repeated attempts do not resolve the stale ownership.
> 
> An atexit() hook could cover this exit() path, but would not run after 
> SIGKILL or abort(). This appears to be a broader limitation of the 
> kernel vhost UAPI when sharing an open file between processes: recovery 
> cannot rely solely on the destination releasing ownership before it exits.
> 
> Regards,
> Akihiko Odaki
That's an interesting finding.  True that we can't do much for SIGKILL
or abort().  However a truncated migstream footer with a subsequent
exit() is a legitimate case which we should cover.  So if I add the
ownership flag into 'struct vhost_dev' as discussed under the previous
patch - this should become really easy: we just loop over the vhost_dev
instances and issue RESET_OWNER for those which hold the ownership.

Thanks,
Andrey


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B7BCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDihP-0006ot-E3; Mon, 05 Oct 2026 09:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDihF-0006el-Av
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:25:40 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDihC-0004ll-LE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaX7wsIivyxV1FVSDcLpFnxQOXZ3F6c/ZPS/lJVwWCRfQpGfgabBPIkqmj8k8veGtVjs/cyiBvpnr9pq1UIPJqbrEgWf5VxDCHNFdy7zSFy+ST63EIIQX0j8EnzbUmwqj1Pwv+xlPwE1AK716aZa528NVE2LTjpkN9cz8DsppPFqXgRkaLaOJ6QJWH2mNY3zbpWojVxNAPQaP+9iWpCN0RpGnrPewD+O1YWAC+Sku1urTOdBvmVQnKfIGlcbtO/5vHmdWEDlqWiUnIWi0wbM3t0DsyBlID/ZyAHvlEY2v9kxTrr9ZPSxEy+Z41DG81EA2R3v+H2bZo71hnjsyaBcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/eB2Tq0b58fLXcEYjPBxgsy7soUWcYU/xkKo9gIoRU=;
 b=uNLvKfnQzkbVNpWqByiyc+eySyRnSL7yzlArxgRcX0H2WPY79T7iAFT1kqRV7wVyxMERohCfE5IQnoZWWlrFxdxjq/JWZZCMx+NDWzHYqvPkkP+KeJTUJl3zua27zo2v6966TpgzHUOQ+IcX2/R0s91kG+lhdWnWSEAEji9eNoZGB9YGZ2gmt3MBaPg7Cm/1BhXbnF65MHNN23Knm8euuFAcpwXHi64oN90EW0W7kVEipDYMsNGmxhoWM3RFgPjDsFrQWvN73bMtlzgSKfbtz0+uvGfwE5NKg6/AJLRYecivlVhsP3AoTZ7cB4gbQr0jU4IZqcL7gwBcFmAxGPqi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/eB2Tq0b58fLXcEYjPBxgsy7soUWcYU/xkKo9gIoRU=;
 b=H14ZWlwNlHb3dlVK979Y1A2Gc3sEcXmJwNi2gki2jpu5iifaM4gJ3gr16N6bf2rLEKqImGz79AzGuyDoUmI2a4XXjevSY9rYiu2TWnOU/Ig54f56XpCJO9TbSDzEaTGqWQiyx/EXStfxCMc7zy+k3v75sNN9twgwl9u3fohHtBTrBnYyGpkevjM47xC/2DlMqQ/nFkix5uYFTm1qI6pRPdR/drcsViX307joCvu1rpqoXh0InpW7ggY5ZDPmZVEjwnwsLeJg7EPokj+sx0JhCocI4KYbnyKWLR7zxOrKRvhV1GJjwjMDJVBWrCY9BFAVpPZX+GAAynvCNv0E1i4vnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB8215.eurprd08.prod.outlook.com
 (2603:10a6:150:5e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 13:25:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 13:25:24 +0000
Message-ID: <2188391b-5123-4aea-8679-ce87e1eafab0@virtuozzo.com>
Date: Mon, 5 Oct 2026 16:25:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 16/19] vhost: release ownership on exit
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, dongli.zhang@oracle.com,
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org,
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org,
 peterx@redhat.com, clg@redhat.com
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
 <20261002-up-vsock-vhost-v5-v11-16-18fa09d8273d@virtuozzo.com>
 <674e4907-1065-42a3-838e-400d369ed28e@rsg.ci.i.u-tokyo.ac.jp>
 <8d680749-7032-4276-afe5-5b81184641d7@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <8d680749-7032-4276-afe5-5b81184641d7@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e516c2-e45a-477b-171b-08df22e41cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: EKSaV90oXMxPCs5cff1NCcXwXghslb+KkFZbMyMH364j6lUcLEGXO/P/v2jcLVFXCRar2opy4Z2WGpD0kM/1SkkEy2alzBBCkmtHfxxvcGpItzRRcPNpcMuWK8yOUne/QgVV5a7nkppymkNyXljCY/bg+XmIBuDE9jmjh8l63pha9iSl+HjepW+/cKUIckWl1qcZ6EmqVQx3Fp7U8C1nYP/MQ81HhfADYcycy1jrGDhBrZF80WXPjJUaTS7RZpz+5ZNQFwJbuOddGgNXJZNSlq5TJ0k8LlU+y38U+d2s32doud7PJx0S1KeHmlWCwjWGGqIiB570339Zsy8RzPXrujonzUOiTDMUY+EiNmxY6YoOwnyGOYapw7ORAeRvvWzEMEx3TogNRj15iNUdEtZneiANyqJ0fsiqGkoDm7xiujOZtzXXLdrThxaAcUmJ/FevSpchwp0Cn9f1mYORjW+C0Sk193WadFkxav0QI9x51WMYt//BAiSH6vwo+xQEJX7PC9cYxUphh45mBvUyamBGnKwWXBMbvkP5QtzFWMzlvAquykIk5RVwb75DGaKzUnbCjjBM3HpP08RgGo5+dlRLFWmYSnoNbGlooOyENrDAJ3c71HpqiPtsw8KZYs4hGvx0ZN+4otqmLXv7W3KSX71jfs0pNFtyLJY0pxDStI7hx4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC96TFlPVm1ZVURLSHQ4TkJLMVFMeStqM251SVNDTGVVeVB5aW4xOVp1MXNQ?=
 =?utf-8?B?UklnWWxaa2l6N0dVVzV2STJUZ1NuRUVLN1VnMjNIZko4eThHY1Nvb0k2OCtQ?=
 =?utf-8?B?WTRtYm1wdzRBdVpJZ0JDZDVlMjNCdUpzWGlUOUdtZGk5c3dmcjRHQWIvb2la?=
 =?utf-8?B?SnBtdm4xdW5vRVhJSUdxcmRBT2drcktYbWtOYUJTMXZhYkVPVTJzR1A0MWdT?=
 =?utf-8?B?aTZqMWxGNUdVSEdZOGhGMEFaSlgxUnR3ZVZ3WXFKVUl0aUpVWXN6MThya2px?=
 =?utf-8?B?UXNKTER0SFU0Uk1CYW9ZdWU0TG5KdFJmTzJhOFhNWjh4Y1Mya0MvL21Gd3dY?=
 =?utf-8?B?RlFGUnBzQ0FkTUpRRVcwMkVGcHF0R0JUU2VRMWYvWTA0Z2NoV1BkdTFOMmt4?=
 =?utf-8?B?MXlIKytaQ3FOTklZQWdjVFZTenhLU3BRWjdidXh1dllBWlVNQW05RGlzaTRX?=
 =?utf-8?B?Zk4zNUt6cFlSd3hWbWxnTzZnMS9md2RzSTVXZnlpNlg2WXJWYzI2UGQ3c3hX?=
 =?utf-8?B?RHl1QitkSnpYYWVGRkh4SURGNXh5c3hwdnhpRFhLUnpqRHN1b0dJbmwxRTFP?=
 =?utf-8?B?RE5uWDIrY3BiSG1iTFdOVFpUOE9jTm1MMnQwdEpzSGw2RGdMRGpWRTZXM3JE?=
 =?utf-8?B?NUhhRGFodGNQdC9vQjFObVU2VVNiQzJlUjBUU1VEV3MrSkNrempURDNtSldN?=
 =?utf-8?B?ak81MGg2VDhZZXU3QUxRakFlaUhyQ0dBb3R2blZQVmRIRC9zS0RiLy9JM29U?=
 =?utf-8?B?eDZob1FCTWRLYVlwSDNoWDdpc3A4MU9JZG1JRUFPcnMza0ZBVERPemNmbkpP?=
 =?utf-8?B?TEgwbzRsVEM3Z2pkNm5OdDlxSFZMeFpGK2xaNWEyN21nbFN6WUZqdlRyQ0d2?=
 =?utf-8?B?OTVBQzVIODJ5YjJobTl3YndWZmNwVkQ0azJjcHBTbjNXZmo5V3dZTkIzaHJP?=
 =?utf-8?B?L2pQWGkvR1hhUHhNNGtYSE4xYU5xaExVaEZYY1lWWjZLc3FCWURxUVRwK0lN?=
 =?utf-8?B?S3Y2UnlzWTZMclljWlM1cFhEejdCL2J0NU1OeXZ4TzJwMEtzTDNzZXc2NG16?=
 =?utf-8?B?Y25TRUVPV3h3QmlieDMzYWxoc1VIWCtHVU9IeEk1R3k1TnBBUzA4eTZ5SnBv?=
 =?utf-8?B?L3hWYUVGUlFJYktTRWl6MTZmb1BrenRDa1NjZFZRaUpNL2p4NzVqSHB6Rlhp?=
 =?utf-8?B?YkQrSndlU0VJNFVuVzdaR05tc3NVN2pWSWc4MU9OSkx1Y3BwYlBaYmNYK1E5?=
 =?utf-8?B?T0phRXJ4OHpXTDlnN01IMGdIL1ZUZzFPdTFBMUhISktsU1VhaVF0M2RjU05J?=
 =?utf-8?B?L3JtUkhiU09iM0lLQVpZcWN2dENVWXhjM1A5UU9VTEZPa20waGMyR3JkcWlh?=
 =?utf-8?B?eldvUC9yTld2LzlVREtMQk9VZVk1OTJTUzl5SHVEMzJkY0lobEw0L1VocU85?=
 =?utf-8?B?RWxVM0lFdUhhVkJEYzF1RzJlbTVvbzBOSXQrcis4MVB6RUdWNVcweEk3Vndo?=
 =?utf-8?B?ZGdmRFpJOTQzckZOWjNsS1FwbisvZklBYjJIMGJ4M2h6SjYxY3k3eW5yb0w0?=
 =?utf-8?B?SjhYWk8ybzNTRVg2bFM5aVpXL0lZcU9PL1pyU29Zd0NxYkFHb1lLZXl0NWlC?=
 =?utf-8?B?bWZJOXpPZWY3WU1vS3BoS0NFelMxYjdBZlBYWTB1bFZhdnhUSjhNT2UvSWNY?=
 =?utf-8?B?OUdDeDJZaFRieDJZSW8wMWtMMURZR0tOczlqZnk1RGJkL2lDbXF5eGZWcjZT?=
 =?utf-8?B?QkRRNGU1bzVmeHAwd1F3djI2dmNqRFZYRitxQzdHZ3lSSEt1eDBSdEl0RzBL?=
 =?utf-8?B?emR5dWIxNk9OY3dleDhRV25wSE9XTDlXQ25JSXdQVkJENWp3U0lxOWJhVzZ1?=
 =?utf-8?B?czh4N3B3TUF6enVZZitKZ0JKZm8zM1lJbjdwVGZnOUxGaXhNR2xjeVl1cmp3?=
 =?utf-8?B?cDQ0R3pLRTNPYjAyYnoyTEttOFo4ZFVHQVI5blcwbmxERkxkVW9PWS9hcVFU?=
 =?utf-8?B?eUF4WUxwcVNJdzMxSWRFTGdmZGhTaXhqUGhGMStySTdBOC9hMVR5ZWVTNkhu?=
 =?utf-8?B?OWkzU3ovR0tjNFJSU2ZyNklCQ2xiQ3BxZXptclJmN0ZyZldkcGRCUm9WYXlo?=
 =?utf-8?B?RWVWM0NsLzY3eVdUbi9EOHJOZTJOVTZhbEJnNUNTa0RPSTJ5UTVsL3FoMTdo?=
 =?utf-8?B?NVNUTnNYNEVMMkZoZjEzalc3NXpCWldZblBidytRUEUwUC9iZEpTVGFvME14?=
 =?utf-8?B?VHovRHRrclU0SDB6cUVuOWNpeTZrZC9UQ3ZBZ1lYQlluWkwxaDFVWGRVdjdt?=
 =?utf-8?B?U3hsV3l5RnJkRmU4TVNRWlhSS3hHYmd1S2J6Zm51TXdyTHVxaXVDYUdSYTky?=
 =?utf-8?Q?2ZeCl3RRV4xzo4Pk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e516c2-e45a-477b-171b-08df22e41cb8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:25:24.0642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNH9xL0yVa9sNQtiG4eji4f/b82Tl7ga6fYdoi7Rb0vmYbBQxwD9lcc7NMoCK9cTLFrZQMpsWNwC9PY0F9jed3RDBdeDsXUV0BecUfdPpHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8215
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/5/26 4:17 PM, Andrey Drobyshev wrote:
> On 10/2/26 5:53 PM, Akihiko Odaki wrote:
>> On 2026/10/02 22:02, Andrey Drobyshev wrote:
>>> A CPR target that has taken the device ownership in post_load() doesn't
>>> always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
>>> truncated migration stream footer, makes QEMU exit() right away, and the
>>> ownership stays with the dead process.  The source still holds the FD,
>>> so the kernel never releases the device, and the source can't take it
>>> back after being resumed -> SET_OWNER fails with EBUSY.
>>>
>>> Add an exit notifier to each vhost_dev, registered for its lifetime,
>>> that releases the ownership if still held.  This covers every orderly
>>> exit, which is every failure QEMU detects itself.  A target killed with
>>> SIGKILL or crashing still leaves the device unrecoverable.
>>
>> With return-path enabled, incoming failure first sends "SHUT" with 
>> migrate_send_rp_shut(). The source can automatically resume before the 
>> notifier runs, receive EBUSY, and leave vsock stopped while the guest runs.
>>
>> Regards,
>> Akihiko Odaki
> 
> I don't think using 'return-path' buys us much when used with CPR
> migration.  However I agree the gap is real.  The way I see it, we might
> just register a failure notifier on the target side with
> migration_incoming_add_failure_notifier().

Sorry, I meant to say with notifier_list_add(...).  Have already started
implementing it and mentioned a helper instead.

Andrey

That notifier runs before
> the exit() path we're fixing in this patch.  And therefore we'll close
> both the exit() hole and the 'return-path' hole in one go.
> 
> I'll send a respin with this if you don't have any objections.
> 
> Thanks,
> Andrey



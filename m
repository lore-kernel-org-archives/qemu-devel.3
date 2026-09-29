Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC66CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXtI-0000xU-Pu; Tue, 29 Sep 2026 09:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBXtG-0000xE-2H
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:29:02 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBXtE-0003j4-9O
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U951LqU69k7jBM4qVd0Krw5aOWNL+I5cXBhXCDTLmgZba8xIxhwY7GA9eaJ3X6FlzG7IA6gy/q0GJfT9HUzXDsNl+9oomXinkFNJXjuOCGmHeLBlXEbPW6aKJwt8xdJKiJ9iP0Ky/kfJyaw8Kzc7W9nK/4ON+jRRUrmUuEBOoOVww0Mqp2ORaWNrpMon5fUbeZ7q0UkkRqNWgXhzudm2V5eW+Ls3VUqOdBONZlPFzfsSWuUpBpBtc5gAuWZ1+S33PtAfSoaDQzOp6dsAZ+Fd1YaJ9+eG0XwsA3pLpMZZn3kZOPZjH1P3rOiQdnWuzJ0ZSGffAmTrfhaZrxBAzW66jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUdoCFnBCcbyqFQb5i8eYDLyNG0BDeDJERehZUNDu6k=;
 b=a5ghziz5oU6RZFISleljLXYhJtwUBqbNnu9dhzD5Efd0QXu05uWjFquPlCXOk3nd637bRleYX5iU1N8rV6BJ/JM4u8LHLym0oCKmES3JCjiSE5BtSe8X2TIew8elIrGGWooA+L9Dg8uk4j9Fttq57Hs8rv/SqrOstAVVitO1Jl4ZFlOugCbwXLGADIGgsI1rsn7jwkhU+aRYX2Vi+omkgqN44phL/ZbVOhOtTuYKMk/BhrJO2VKhPIQdEHPszXxds+9JMwixZcH0m0hS6WVdv7/auDXy2KHnd5+NwRnod7KdGqkbhp3wrFxbroDeyWDzP7JYckAKTDzgurEtzFH5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUdoCFnBCcbyqFQb5i8eYDLyNG0BDeDJERehZUNDu6k=;
 b=CTQjvvVGOj41OoqgZqrPkNEZGCIgdBDFv1osNgWD68wmA/oUf3lRuAuA7JJDJjUQCk6Tfzoaz42H4LSrlxXYx9Z2p/tjjcrRuObajkzzWeUqQYJ1IhpZ3qVcak6pl7SAi12jcou+VBE9w4N1a9JaCddf2j6brjWwUifa0Su3cIRI5xTbsEkbnSQu+YeRxA6jO4oARA79H4hv/xB0gPsTnxj+PtrcVd7bzXBTGwAK2smX7Pr9gCAZrRlMtUVzg3jlmpD2ohbKRzXY8vEo/M9HVy9oMdG5SgWiptYn0jauq9UesFaPwEJ3nfN2d1ar5b2yyr4dSGyM6LkjRjt8jV89tA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8280.eurprd08.prod.outlook.com
 (2603:10a6:10:40c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 13:28:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 13:28:25 +0000
Message-ID: <f2e0fcd0-7640-4aad-bad4-07fdb5a80ce2@virtuozzo.com>
Date: Tue, 29 Sep 2026 16:28:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] migration: forbid snapshots in CPR migration
 modes
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com,
 den@openvz.org, sgarzare@redhat.com
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
 <87fqyt8lze.fsf@suse.de>
 <c5ebc7b7-63f0-4c1a-ad56-df27782c53ce@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <c5ebc7b7-63f0-4c1a-ad56-df27782c53ce@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: f118e095-7f0f-412f-9035-08df1e2d8a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|5023799004|56012099006|4143699003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ohMItR7MVM0e19YTWuQ1ovyq8VGuX0jiMByCNlK2yZ2qbf6+RmYFNjZ8+7f0dmMA0Ve4vtYNqgcYS5sGH19kkEJILu1LWL/fqJmKw23z/n21fqjUxig5/HIbL52HzYyqng6PTDDOq1Wjw+j3VWJ0lqTbB+q/bHk8wmTrOhJh7DpnodnoYRrD78g8ue0MDsB0t4ca2zJH4PQQzX1dYdUtPvgfN3yhy29nTwba7EqRDQ+KgJZBeBgV+hxpZHgfTZvQj9C29jWtYMnhjs392JQDezvo65Shdsn9K1O4xhUEkdGYocbO46eDzCPCNJehgKepvHPqSJ7jhZTeVTRVKc19+ckLXePSs2I8c08sYHO7k3Jmeo/CWD4uesH1xR0xdJo1Ow0ybvcb/uWVYg1csNfxPo8Dt4vy0zgiS9H9bjxGg451cVaaUaJkY4hqXN/vrTORofF/lXiyKW5HFlIy7DR5eKqtfj+PYwz3up4OJCmntDljwLkDfMwgWacBNDpf4CR7uDxjs8zcbO9XbrDC+D5tvFnWcDwKw+fYoT77ktiQvc/AuyQkdsdRA6dc4j02CYev9nnnRXN/kblOCRGeKh5X8h+qHk52b4hrAJKTh7/XPMJ2PzHP1TNVnHeUvhRfDiRpqCBo70qCo8uHKsNjBitOoNhoN5l4oEE8oiMOs/blv90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(5023799004)(56012099006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M005ZzdzTndtS2xpTjNNeUIwTk8zZVlRTlU2NU1BN2s5WnBqRVYwS3NMQVpN?=
 =?utf-8?B?L1pmNG40SmlSSTdOYXhudHd2dDF0a09kN0cwMjdsK0hHUjFhOUdUejlaVW5h?=
 =?utf-8?B?bmI1aDBkNFhOVmNYYi8zaWk3K05NWXZWVitlbmNHL002RTRjUmVXK3B2T0xR?=
 =?utf-8?B?MExTR3RuNldnblhWQzRwRjVnK3ZYclRxQURIQWlLQXU1YWlRa3BPenk3QlFn?=
 =?utf-8?B?ZkFnUHVIOWcwNXE2bGlJVkFrZitEcStOdjEySnVtcUVGMUYzVWI5OWJkazgr?=
 =?utf-8?B?U2o4VVlnYXZLZG5OUHBmY3pidmdnS2MyYzhvdHoyN0JlMzZybTFpUEFVRTJy?=
 =?utf-8?B?V0dzUnYwSHgyRS9VTUlqZGRuREZmUG40SXRtTlIyREw5RHl1VlBCNXVwTVpv?=
 =?utf-8?B?OHZyc0xsV2ptVGVCSGdGL3dsNEVmUVVEWHpxY0RzbExSaUk4QXhQc2pQVDRC?=
 =?utf-8?B?M211L21WVnBTTlFxR1ZkZHQzZ1JBV2pQejNlRGJFRXBnbzJGRGVDSUtPbEpR?=
 =?utf-8?B?eTlvMVhwLy9jR2xoUFJwZGlvd3RoSTBZYXQ0cU1PVEZxRE0wTTcvMVBUcEM5?=
 =?utf-8?B?SHBkT1dkSXlYK3R1enE5WFU4UlZYc2pKUlVmVEc1b0hWU1JEVUhlSk1XdmJI?=
 =?utf-8?B?QmZ2ZzhuTVZGczZ2bllFOU1nSS82Z3ZmN0FqUnJ0S1JzcnU5dGMrU2dyNGpz?=
 =?utf-8?B?VUhLQzhOSERKeXBFNHJUQktXQjhPYUhWS1dUNFVaYVJoMkt5a3FPdjdVS1da?=
 =?utf-8?B?VytZbHBGNnF1RkdxN29wcUhhL2NGdldRRlBSYUtEZUZEMzZuajRxd1hiajEz?=
 =?utf-8?B?M3BuY1NIWkZRQngxNDk1Ri9rT0JpN0JkazdiTmFreGhjSWJYNmdKeVNBNlJr?=
 =?utf-8?B?UWFMSjVpSUFGOVpiZDRMeDlZOWhWU0thVDlxRUhxZklRRzVJZVExdlZnN3RD?=
 =?utf-8?B?M3ZKZUZyS01lNCtZOVgvdDl2cjBOYWthb2I3cnE2SjdlQ3NnN3IybDNEK1BE?=
 =?utf-8?B?RU1ueG1KQkt3NmJvK2dMTGFDSDVxSlIzSXI2UlJmQWoweUx6OEEvaDdkSy9O?=
 =?utf-8?B?MmpxQUF4cDl2T0RnMmFsUU8wREJVYk9OU1JZTUpBbWJhL1VFNmZiN255d3Jt?=
 =?utf-8?B?VEpYNWxXRkYzK3EyencrYlJLUXhaS1l0NktYSFBEL09TeUVqV1dXSE1lRklF?=
 =?utf-8?B?a0RpclgxL2xnRmFCUGtTWUgwNHFkTDRtZXcvYXRQbjJIVzZXelZjbUF4NHFy?=
 =?utf-8?B?R3hYb2l6U2hUeFMvUjdXVi9wdzgwQkRNN295a1Z2eU1kb0xMbEdVdFZVZGM2?=
 =?utf-8?B?QmR4RTkrQ1JBdnBTMXUvZ3l4V1Vpd1pZMVU4U1lTRUlKK3ZiMmFwWVZtR1hw?=
 =?utf-8?B?RlFITElmbHRlZHc4MzlwU3RQVXExS0gxVDdNdENIQlh3L3h1bmYrQmUvaEFn?=
 =?utf-8?B?QVc5MzNDRDUyZXNmcVVOUEVaekxYV1l0eFl4c3BWbzd0eVZZTHNvcVhOZTJZ?=
 =?utf-8?B?U2VzREpFL0VxSVdFR0d2ek9jeVUxOUZuNWl0VW5JSEtUNTQwTll6NW4zaHhQ?=
 =?utf-8?B?bENpQkQyMk9rU1EvL2VBbktlVFVOcUphYk1Ycjg1QVA0RUl4YUlLcC9OaDBS?=
 =?utf-8?B?enlhc0ZrZGNaLzdEdDRoSnlOSGFkcGRJYjhRRlduRlhmbU5Cck05OWVyNnN1?=
 =?utf-8?B?TE12THJkZkNRMnFsT1E0dlh2dFBocVZHVkEzTXdZaWVXbW14TDh6T204ekQv?=
 =?utf-8?B?RHRqY0dMZkN4S2xudUlaK2FyaERZVGhCNVdwRXhwL2gya3NvUEFGcXJyZVkv?=
 =?utf-8?B?bkRKdU9CMUl2ZFBiT0FsYmdZeS85bm9LcEZEbnRpbHBnZk5uNmx3enpaQnFY?=
 =?utf-8?B?MTZqWEdFa0xQZ3dScm80YzVaNFluVTc3ZkpibkF3VjVJOUNaZnJqUG54VldK?=
 =?utf-8?B?R2x2VTFqaE50eS91SnZFSEE4Ujdpdk5tckVab1I5eFV2U0toOVRUYXJtTGxq?=
 =?utf-8?B?RFBiTTI2dUZlWjlvK05iNkgrbkc0Y1g0bzJCME50Ym12ZXNuYXl4a3ptMUcw?=
 =?utf-8?B?VllHc0lrOWcvVjZoZmN2RFFwNXBnS0ZnbGlOSkJtRTVGT28wNmtRT1VneWVy?=
 =?utf-8?B?N3pQQ3FOanByRFhqVGNTM0pITDZNcVNUYUpTRkRHYTRLazc5ZlhRbERBSEti?=
 =?utf-8?B?VzBFZVdlWkRCUEkycndDQWNwdHphUHJua3I3anBWOUpRWjlRQWl5bEtuQ2lZ?=
 =?utf-8?B?NjJ0Ykwxb2hGVlpMMTRoU0dvNU5ZZVVJUWQ4VlpnVzVFYSs4RGV2Y25JWHZz?=
 =?utf-8?B?UXB5WU1MNmppYXNoa3MvTDZIc3lZYW9QL1ZrM2V2cXRNMXJab25SenFyU0dQ?=
 =?utf-8?Q?GTwW9ok3jADf8W+s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f118e095-7f0f-412f-9035-08df1e2d8a7c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:28:25.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je4r8+NHzmwiqBGMKltA5L7GIJiIbeyW91pnnazBWmbnGVCtwxM+rab35drUJIjM+RqTvdV6JvnOFhBfiaWrh5z7VoyvvQQwPGUMLVDKaA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8280
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 9/28/26 8:39 PM, Akihiko Odaki wrote:
> On 2026/09/28 23:54, Fabiano Rosas wrote:
>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:
>>
>>> The savevm/loadvm operation doesn't make any sense in any of the CPR
>>> modes.  Saving VM state implies saving its RAM entirely, while the whole
>>> point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
>>> preserved in place and never put into the migration stream (see
>>> migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
>>> taken with such a mode set has no RAM in it, and loading a snapshot with
>>> such a mode set fails in the RAM loader.
>>>
>>> Currently nothing stops these operations from firing with a CPR mode
>>> still set, e.g. after an earlier CPR attempt.  Reject them early in
>>> migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
>>> well as 'snapshot-save'/'snapshot-load' QMP commands.
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   migration/options.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/migration/options.c b/migration/options.c
>>> index 05b026f4bf2..f648be1302b 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -555,8 +555,15 @@ static bool migrate_incoming_started(void)
>>>   bool migrate_can_snapshot(Error **errp)
>>>   {
>>>       MigrationState *s = migrate_get_current();
>>> +    MigMode mode = migrate_mode();
>>>       int i;
>>>   
>>> +    if (mode != MIG_MODE_NORMAL) {
>>> +        error_setg(errp, "Snapshots are not compatible with migration mode %s",
>>> +                   MigMode_str(mode));
>>> +        return false;
>>> +    }
>>> +
>>>       for (i = 0; i < check_caps_savevm.size; i++) {
>>>           int incomp_cap = check_caps_savevm.caps[i];
>>
>> +CC Akihiko Odaki
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Thanks for CCing me. This is also relevant to my recent work on Xen
> migration. The snapshot RAM-saving path does not support Xen's memory
> mappings, so migrate_can_snapshot() should reject Xen as well.
> 
> If you send another revision, could you include that check? This is a
> pre-existing issue, though, so it need not hold up this patch.
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> Regards,
> Akihiko Odaki

Hello Akihiko,

Sure, I can add the check.  It's of course slightly beyond the scope of
this series, but since the patch is trivial there shouldn't be any
problems.  IIUC adding this should be enough:

  if (xen_enabled()) {
      error_setg(errp, "Snapshots are not compatible with Xen");
      return false;
  }

I'll make it a separate patch on the next respin.

Thanks,
Andrey


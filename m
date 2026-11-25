Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67897606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=GRobHiKO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGKz-0004jj-Fv; Wed, 25 Nov 2026 11:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xWGKn-0004fp-Uz; Wed, 25 Nov 2026 11:59:07 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xWGKl-0002LK-2o; Wed, 25 Nov 2026 11:59:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQlfZkJugAhEQcdCbxPs012bw4H8I+Uyhcjl6rdJIYj3Iq4ISuH6LukXiI8sZauh+gUzbqWMe43N2EEe0r4DYZaKxENrwEaRgdwZZ0SIG9Mq6OvnWBvlLXFvefNhhRNpNzwzkLQ3eSWVhEMbNl+KsW8KYLF6P+FVdGUJ6p3dpRxl0CPbnEw1JOrC2nwLkuome6qE8rolkJcgHz89dbeZSE8QC/KFTEUlh+bEN4ZLn0aCtH42ofNg5v9bA78Hs6IWT+q1n6hSkdDcq0JOGdXPptiq21+nMSzzZSgRjzaxu/g4GKY94IcYWWuWZHJBtA+Qd13DJSGuEU4G1b5lpfFUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSDrf2PHeoKslF2a2kWCEUD+CEdYmw3hz1nGN22y/vE=;
 b=kOeiR2mLKxyScNGcDE2T2cz8q0OlQnGnmTHeCxT9OzS3y2j8aA/qEna69EQ0aQZ+eGq+FJhe9jj5R2wIx0SaA1EQy8d0xNQiqi9FA31ZLMkdyTD7sUqlfDTTa04cM54b0O/8wzZvySSsg+FO6TiyQ+B2dvTx6rCu4E6v/4UwRI/fmYqV6Bqy5/wzB9sfyAn13+75spj0SQfzE4MUh3SEtUofme07QZ5HFCWkMPlmiQD1Z0Z58MeIhfvxNGKDxGxc189hbZ3qQabZTNzaztfqkknkiHJLStppErl9YINmTH7qOzoc2PaLRr8HmAkilKLVp7Iq0pbJ61wlpt15KPB/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSDrf2PHeoKslF2a2kWCEUD+CEdYmw3hz1nGN22y/vE=;
 b=GRobHiKOHA46S4yFpoxYq8Cvp78P6j2KTFWTFFVSr1RHXJButiO7RI9n1BBGd7cWcLvSAFIDd2UDQs62y+y3AcJBuLZFgG0lNfG0mi+lQBMLw55vOnJ+5VDoUnzC+ZoOBME0lj4j5csjs9oZ/e2r/UU581Jezq/AClyXDW2dW7/fnNtSSxpdNPJK9oBeJUu9bA+E2egV5pWY8XwZokVvLsLqdiuC6KWsv5JB4aTEeQ2iCu+5GUzbDT9NM3XFh3pwBJ3yecZbfOtjtVc7ruq34sGUxo2uAlmRdEnMlf+W45JaBnQkbHahniP0IkdF4YYREobCXLb0hwHZJpLgBvoLwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB7493.eurprd08.prod.outlook.com (2603:10a6:10:36e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:58:56 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:58:56 +0000
Message-ID: <5b13cf6f-0222-4029-96de-0464299f6bab@virtuozzo.com>
Date: Wed, 25 Nov 2026 17:58:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix abort when a rate-limited event races with
 its timer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@pond.sub.org>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-stable@nongnu.org
References: <20261123212957.242482-1-den@openvz.org>
 <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
 <87o6be4o8f.fsf@pond.sub.org>
 <d9137705-39f0-4a72-bafc-ea483183cecf@oss.qualcomm.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <d9137705-39f0-4a72-bafc-ea483183cecf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0023.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::6) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ad7e92-22ec-4fff-31dd-08df4b15643b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|5023799004|261022105027099003|261022113327099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Ok7/CuG/zdj2+0HJ1uX4JKNB809dFImKIhEL/arf2zuCc6Aj/RKRVXOPnRIAXRjzlc8Hx9R6ZzNs/Z3a5XoSglg2v8zH8hEGT2D40IOVxzFgp9idQsyjdlfqfpEj6cL93iInrvrLyapUO6gDbOc6q/E7jFCWsq4tpkKGksm89ygL/SM5Wt6kX42wt05WlWQS2AAtIGjbHdwfp0ncE5JrTxfPKWSY4WUdAdManE4e4A1ajg74Yg3CY68IAVqoh99TXKWXPmDzkpfmqz5KVLyfoPVCTR/G6M3GOUuaBQjDOozTHnc+25cW5zAj1WKTJaUy1sLSTIq0gi3Vwy1HVthEb8wECJiHL6g34CuklCGw2A0T9F91FKFJN1NMBPKBKe4PAZGRwipj/IufLWOTzFLb9sKAaHNzY7c0jFzQv7H2umnrqqwAFulnhXW9AxmNQRbSPMQPeBXrRBEZtlCKyZz01jMimQTkPieQPjsmNBPS4YhnKVl5UDPn8qOffaw5g5vHjsdZyRWTf/9dmqwXIB9+9Rz5FGcPfWObChiSncFeC8X5YKNhOHH72n6meERfmp7J9ew836oBvYgBWWwpCShbQdpTGkS7FJvJ+QouWwnl/AGgRjrO023PSJ1uFmoulHMx488k9gjSDcxGJZhc7JBIeNrhgGJS3/oQTf3lY+Z9Zk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(261022105027099003)(261022113327099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNua2hEQVFXbm1Qb2NndXdaM0ViTU1yQStEbmJkU0VCRkZoVkl1QkIzMFNJ?=
 =?utf-8?B?SDBCTWkySWJEdDBEZklpbW83K2tOUmJEMktXSXlqOXBkVktBdkltU0ZuZDY1?=
 =?utf-8?B?bFBmTGszSnJscW9BclFTdFhYRDRlUDNrVmIyR2xIWUJkenlybDVZMjVMYVFY?=
 =?utf-8?B?VlF0blJiQWpTSWpyTEFWOVNRRWZ4UHd6K1prNWhvNW5NaytQOW1RQlBIVXdL?=
 =?utf-8?B?b29UbFJaN1I1Rzg2eEdxTndQekx1Tm12dUErMFFXZVdTVGRyOUc0R0d0Rk5F?=
 =?utf-8?B?ZjJDTFVITXh0RitoVTBOdThVTklxeUZQT0N2UXVpYXMyeS8rNU9RT3NIWDJO?=
 =?utf-8?B?MmN4MGUwdlFEQS9ka3AreU4xV3BUYWVNbnN5S0pXaHpUdmllWnFWcFhDcDlQ?=
 =?utf-8?B?M2V1WlR0enlIVHppTDNvSk5VMzQyUXBlWHZabGdOalRVNjBhYnVzaDVGanZ5?=
 =?utf-8?B?WnB1dk94V0JXSDJ6N2h5QmlwdWNvYXVMdUIrWFNpeUs1UjdkSEVvdlZ2QXRH?=
 =?utf-8?B?TXBZTlVSQmZld2FSL1F4QURGam85UEZYVndDOWJWaHMyS3daYnQ0VXBObWlF?=
 =?utf-8?B?SVJqRmJnNWxLeFBMN01uNThra0lmSVBLeFpURUVEVFBsOFhERTRRcnRKUEgw?=
 =?utf-8?B?TzU0Q1ZKOWJ1M2V2ekNlaVFlL0s1ZXhSVkw4a3RoYWNpSUJldmN1eUFjUG9k?=
 =?utf-8?B?eG1LaUNCL0pYdmUzTlR1ajg1UmREd2N6eldNYmpzSHF6djBaOVVQaUxIQVZ3?=
 =?utf-8?B?T1FRblBaT2tZVWpaMzBuUFRYdlNDZmk0cEtoVmVmRm1ZdG15aDd1d3BQWDhK?=
 =?utf-8?B?cjQrUS9pa2U4N2ZWbWo3WmtPcURBS0ppNHRXdzl0Q0lmdWlWRjNIUmhWelYx?=
 =?utf-8?B?RGhxeVEwaDNUVXZVRmlCVUdWaGYyREgvOEMyYmUrU1B1ZURtQnB3eEJYNWs0?=
 =?utf-8?B?VHBOT2lpWkhFTUNLaTZDOWdDL2poNllJcUdMM294MGo2RC9oL1k1ektwNWxN?=
 =?utf-8?B?aDFaK2xEZVVySi9NblhmZjAzNmltY3VuRmtTWTduTlc0a3N0RDhjdXowRE9D?=
 =?utf-8?B?S09QQldYb3ZrcFVEZkl1Uks0bm1Nd0N3enEycFlxVWltSUFleGVNNkhYeTd5?=
 =?utf-8?B?NTNhT1d0dzN2Vmh2SE0vRStIUTNLWmNNWXBjTlVrSDdoV29VS2JTUkdTaWJk?=
 =?utf-8?B?Uk5tTWR3SVFhMnRNMC9oMVF1RlErb012eXVBVTBtRTFZVklyU09FSnc4Mjhh?=
 =?utf-8?B?TkFrZ0ZJeTR1V2hMYmpIMlh5RnMrM2FjcVBWc1BTbTZiSE55T1hoeUIvbUFH?=
 =?utf-8?B?b01xTVVza0RtWkdMZld0ZTlyVjhXT295Y2o2VnhrU3l6VXpXcktMbWxnekFn?=
 =?utf-8?B?Y3FDdlBMZm84cnB1b2QwMHBnM1RFUzVOb2VLY0tPK0dXTWhpOHZLK0R1UFNo?=
 =?utf-8?B?cWtaZDJyc3ZKS0RVMEhobUJoVkNTTnMxMXE1NlBhRDBkOUlSOENraW1pckg1?=
 =?utf-8?B?YzFvSWFGQUdON2hJR3VnQkNkcURYRXpxNUgrYzk1ajhKY3ptOXVvdzlaTGZN?=
 =?utf-8?B?YnBCcFk4L2FoeVQwMDlNYzNXWDRnd0FJY0lxSEJZalFSdHVKa0M5WTROVG5W?=
 =?utf-8?B?ZThLUE55MjhVck5VNnprNmNiNU5abEF5alNjdmM4MjMvc3hLREVGblZ5eG1s?=
 =?utf-8?B?N1VpY3c3bjEvWU93TXFia29ZOVlrRHFpQktXM2E1VktjUjlJVzBBeml1SkRl?=
 =?utf-8?B?U1hwNDZSNCtqS1JkVlBOTUlIU1N0MFNDYWJMNUk5U3VlKzlONnVtc1FOSDZT?=
 =?utf-8?B?Uk9QYVpDZTJ2Yzl0R0Z4ZWExaFVxOGwxNmwyYThNRk9hWW56ZkhlTSs3VlUx?=
 =?utf-8?B?c3kvbmJ0QVdtSVZ6M1lYY1drOVlmaFdSRUo3aThmRTd3dTlSakNYMTFlK3JH?=
 =?utf-8?B?WUFGcjVGT3duOWNTSFlwdnQ1emJibnlYcFIzMGdqNzhQVktvMS9zZENpVGRo?=
 =?utf-8?B?cGlZazVsYTdUdXpqSkNBWDlPSGFGditybkgzWE1LTVJZbEwwNTVOVXVWdXR4?=
 =?utf-8?B?T3VvN0lvdmNlRFRMV1R5MEdlLzNwcHE4M0c4WXdRenBzR3ZHN1dpMGpqMEJt?=
 =?utf-8?B?QWxyM1ZvWTl1OUdxK3pONCs4N09tRHM3TjZZQXBsUU16RG1ibXhhdWRCblM3?=
 =?utf-8?B?UkIyVERnbTFZOEM2ZFROWUlHVjBtakt2UjFqa2V5WDY4ZUlwUVJuZGZmRDli?=
 =?utf-8?B?V203ekttVi9zdklsaU9aTnJ1WWplOUp6c2dVQUhVbTZyaWRYZ1dvSTUwbG9w?=
 =?utf-8?B?eWdVUHJqUWhZSnBTMlRWbVJjb05pVDM1VlhKZnNCdDNwcEhaMUVEOFRleDAz?=
 =?utf-8?Q?5VOd5HFcLXlpZvgaxVBHr+N2Cc/E6PcU+HZc8XDmLMGtg?=
X-MS-Exchange-AntiSpam-MessageData-1: Tl1obz4HZJBE/Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ad7e92-22ec-4fff-31dd-08df4b15643b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:58:55.9623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxRHx8ZPuWPelg7xhk6aemlkUyAYzNAigmpN75yS+PNOx8OA5+Q8tTwPm/tK4T3BryTWVcFYniACHWztcaPJqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7493
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
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

On 11/24/26 10:57, Philippe Mathieu-Daudé wrote:
> On 24/11/26 09:39, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
>>
>>> On 23/11/26 22:29, Denis V. Lunev wrote:
>>>> From: Denis V. Lunev <den@openvz.org>
>>>> Rate-limited events can be raised from iothreads, outside the BQL.
>>>> QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
>>>> rate limited too, and any disk on an iothread raises it.
>>>> The rate-limit timer runs in the main loop. timerlist_run_timers()
>>>> takes it off the active list before it calls the handler, and only then
>>>> does the handler take monitor_lock. An iothread raising the same event
>>>> for the same device in between finds the rate-limit entry with a timer
>>>> that is no longer pending, and QEMU aborts with:
>>>>     Assertion `!evstate || timer_pending(evstate->timer)' failed.
>>>> This hits virtio-blk on an iothread with an error policy other than
>>>> stop when the storage goes away and every guest request fails.
>>>> The state is fine, the assert is wrong. Once the timer has fired, the
>>>> handler is committed to run: it takes the lock as soon as the iothread
>>>> drops it, sends the stored event and re-arms the timer, exactly as for
>>>> an event stored while the timer was pending. The event goes out at the
>>>> same moment it would have had the iothread come in after the handler.
>>>> The entry is only created, re-armed and freed under monitor_lock, so it
>>>> cannot go away under the iothread. Drop the assert.
>>>> Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a hash table")
>>>> Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_ERROR reports")
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>>>> Cc: qemu-stable@nongnu.org
>>>> ---
>>>>    monitor/monitor.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>> index 2654b81890..22c00b6195 100644
>>>> --- a/monitor/monitor.c
>>>> +++ b/monitor/monitor.c
>>>> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>>>>           MonitorQAPIEventState key = { .event = event, .data = data };
>>>>
>>>>           evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
>>>> -        assert(!evstate || timer_pending(evstate->timer));
>>>>
>>>>           if (evstate) {
>>>>               /*
>>>>                * Timer is pending for (at least) evconf->rate ns after
>>>> -             * last send.  Store event for sending when timer fires,
>>>> -             * replacing a prior stored event if any.
>>>> +             * last send, or it has expired and its handler has not
>>>> +             * taken monitor_lock yet. Either way the handler will
>>>> +             * send what is stored here. Store event for sending
>>>> +             * then, replacing a prior stored event if any.
>>> How about:
>>>
>>>   +             * last send, or its handler has not taken monitor_lock
>>>   +             * yet (the timer may have fired, or not been armed yet).
>>>   +             * Either way the handler will send what is stored here.
>>>   +             * Store event for sending then, replacing a prior stored
>>>   +             * event if any.
>>>
>>> ?
>> I find this version harder to understand.  What scenario exactly is
>> missing from Denis's version?  And is it important here?
> The issue Denis fixed also exists in the gap before the first
> timer_mod_ns() under monitor_lock and between timer_mod_ns() calls
> after later sends, now described as "or has not been armed yet":
>
> "the timer has fired [, or has not been armed yet], and its handler has 
> not taken monitor_lock."
We hold monitor_lock from the hash insertion through the first
timer_mod_ns(), so another thread can't see the entry before the timer is
armed. The handler holds the same lock while it sends the event and rearms
the timer.

Another thread can see the entry with the timer no longer pending only after
the timer fires and before the handler takes monitor_lock. I'd keep the
posted wording.

Den


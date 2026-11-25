Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D97606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=0E/VrpuW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGRd-0001PP-PM; Wed, 25 Nov 2026 12:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xWGRc-0001OD-OT; Wed, 25 Nov 2026 12:06:08 -0500
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xWGRZ-0006jn-FN; Wed, 25 Nov 2026 12:06:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbWOBxaWZV7YCSJBa5MG0Jg2fcgR2QE5isGhx2GfzRORED1WjoZ4zra/V5yQ/9IU0SwLWdZ/SgSGzfANaDzqBb1jkQiL/nauA1gtvEzSOgCt+tHuNIOoGNGJEqmocKmkgWrP0xmDzVd/moVurlF3dTsceSDM26LoCPC1t0g1iwOu/3bN9VyrvPzAjfHFqV75tApMPGt3v1IvH7H9q5fotEtDOVmCPVuZqOAH3i80SFUiXo4eQ3bZnKirUlRZ0SBQcLLA2N2CYuxbm53tVxgLue9QPg6juduZdNNVfgjRke58SdbF5zIZjdZ4OkM9ezzYW/uIX5OeH5skgFspCi2XXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCVmQ8CnMDp/l7hC1PCU+p26FYU5W8f/cHIVlH22NJk=;
 b=xY1CJKoc6/L5F0jcH0a01fTLcBZnjh8uB41oLxBv867E09c6CghmKUwCNYB+CxMo0ixY+hXmWoqC6caf4A71XLqmcPXpzVfFcGksyVidAfoZTB5Oyr5qtjuBG+sW3A87nd5l4y9SXEpfgcXE6bYz4LO/JwOcajkLQvtNWCndm82NSFD/0Kr7YN85vQnHOK4i3XohDka5IMfrZYRONLJ0mwP7kZPu+RsClMWv7GFE+zr+nEJ0Cpb3X0zK/NxSLrNMQZ+ZXvuwFfDYpZ8OkLI1pxKMV5caMNFkwzMOj8Y4rUIatLTJ823m9tPUKIewBLc//CI59Kl2Ya3f9H6+ItwS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCVmQ8CnMDp/l7hC1PCU+p26FYU5W8f/cHIVlH22NJk=;
 b=0E/VrpuWe5NJNoSovyxqE4KmGvgekS8cekzYhyySWk5Y460RccNCRAQzUiseSLs+UQ28+3oruiz8J5RajL/zzjAbvZ34zXChlbQFAfiORHlhdjySuhr+hpllO0lbKmFY6Yd7icjnippJtPPZt6UAvpeVnnOTUajx1wZsbBKbCTGVHOOo1r+dhEur8HDIRHypT9HhaMdWuMfV36PBVxDsji1iXKUcPlcJ8ogE60/UMOWbi/7+dZk9Vouk/2+6+B2vWJhsT50f4tLXaHf7ZvKxlFMZuXfrs5UQClcMo7Jd0xD0mJRflCtbDpnnjUO4yX1KDBHLYJ6G1BEUBDIgtgn33Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AM9PR08MB6242.eurprd08.prod.outlook.com (2603:10a6:20b:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 17:06:00 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:06:00 +0000
Message-ID: <a835b7d9-9e9f-4dc3-a1e3-ef86e94e6aa6@virtuozzo.com>
Date: Wed, 25 Nov 2026 18:05:59 +0100
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
 <5b13cf6f-0222-4029-96de-0464299f6bab@virtuozzo.com>
 <b1190b25-f3a6-4c2c-afa6-e44041d5eef5@oss.qualcomm.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <b1190b25-f3a6-4c2c-afa6-e44041d5eef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0020.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::9) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AM9PR08MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7a277c-afd6-4897-f70d-08df4b166194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|10067099003|4143699003|261028144727099003|56012099006|261026140227099003|261022105027099003|261022113327099003|261021121427099003|261022075727099003|261026121527099003|5023799004|261009223027099003|261021123027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P64BUDB4gL0iZKiZSPfijNOmObGDDwAjuXIli8RjDKAn6G0LyhY6JR7vOQz41ntR0hhqdHeb8wbZmSv8RD2UGgRHK+p5CbE+q8LFAzhQ3D3TyMjLCdykDHrT4UK7kxGmQcukQPIXCHNGUMaydo1tNRBoouIatnXXVTGShmJVyMEhe6ymLx0D7/odNoEOPjnFDit2HkIld/IR/kWNmgbZ6U+vOfkNtWeiWcLw0+ytjcQfG5JZuBuvgTrLNW9JtGoMKstn8Ewf1MT4nMbiwcCdKqsD/a03oWDFTclHIR1hjXC8xtTgdjzD0GsnUXjlOLsC+k/jPeSDsDBmPqOypptUKJvNZl3w69wDsvKIdE7V0q5+g8EsIJ8oIF3kV3dcNS5b7HK7kXAJBpQAYbsHQXxJkrZdvu0bfyga2igduZs8AlIYvTdq0YcynFp5om+qXlc11M1vqhaR9GQQdHpRfl6vKJGZ4BsbBJGWM02xxO001g3ffIpXpkV9n5cKl9ftEoFnN7HvkWhatJbpoztNkJY/PbaFXLAjzFzU1YoFOXzWu5HH4E8ho/Yt53P9JmhS4PgXBwSNmqGwZHFt3ch9pNGvmBqTPTjoe9xbrQqsk4iDMsscz5NHS79qEZnqGcoJzoMOTLBrBx57zrS6bdqW9uLmSaEF3FsWUCeTpu/L+PzkRUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(261028144727099003)(56012099006)(261026140227099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022075727099003)(261026121527099003)(5023799004)(261009223027099003)(261021123027099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNNbGxuWFFQWjJsR0l6Y2pReE5wMmxhWTYzc1FxN1BCOENETzZHTFhuREND?=
 =?utf-8?B?Sm5HUWdQS2krTWpQVmFPWkhjOWhxQmVaTVNiZDFyazBKV1NxQzE5THU4YTZq?=
 =?utf-8?B?RTh0WVhGQldhK3RQOUNVUHJSTXdZMVVBMFU5RUFncEZKbTZTaWFJSFEvS2Zk?=
 =?utf-8?B?ZnBZbU5rbUUySjNtSThMVVJxT04xREZETGZmL21LNk9maEQrSlppaWs5SDVH?=
 =?utf-8?B?MEpYY1I4ZEVuYkZkWXZidEE3dHFlZEF2eFNFZ3h1cGRTR1cwWjVzRUlydzdI?=
 =?utf-8?B?SmtGbThBSWV4MmdrMTI0Yk1wSjNkL0pCdjVvVm1yOW5jVksyckJZWCtSSlhO?=
 =?utf-8?B?TDdiWEJoN25TbnRFTDc5dlA3eFBXaFM2QmxrNFg0TTJnUTZWSVlBVnlVZVFy?=
 =?utf-8?B?SUpGb28yT2lKM3FpKzdOMWNSeDM4TmFkL1VrUHFNMUVkSERwYjVPM0E3eXhK?=
 =?utf-8?B?eVgxZ3VzeWxSYkJvY29pc3pBa1FIQWl0bmVOeHp5WFVSbkJBeGFkUCs5azli?=
 =?utf-8?B?S0FTWFFYd29UNWZYSnhGcmQwSGRMTUF1TEJITWUxdzBid0tlOGlVTXZicnox?=
 =?utf-8?B?eW9XOVh2ay84Szlna0xSTFFHOFlzbkM0ampKR3FEaGd0ZGlCcjI0eDJ4R2Nz?=
 =?utf-8?B?algrYTRvUzBTSC9GRmoraFdsZDcxR21LK3cvcEZNZmV2dStkOE83bi9neWFi?=
 =?utf-8?B?S2s1cVhYaFpWazJHNUZWMXJ6QnQyMXROVlhFMGNOTWlhcVlUd1VRVE5GNXlr?=
 =?utf-8?B?Rlg2ODkzZHFaMVJBaTBzUkxrTUlJT3g1UnF2d0FVVW5RNDRkdWhqU1E4Y1JL?=
 =?utf-8?B?dFpvN1NPUmdWeStlMURncEh5M0VJTDB4VzRDWGJDOW1Kak1hODAvZnBBczkz?=
 =?utf-8?B?dlR4UmVmL0Q2cGdPWnBGU1ZUVENZZmE4WHhzMDI5TWRJTVo4SDAxQzZpcjNk?=
 =?utf-8?B?UnlXRGhyT3lFYm5oWnMwMEtPMVJTM2g1TW0zd0FNczJrTXoyWjRjTTMxdnNS?=
 =?utf-8?B?UW5pelpSakFpUm1MWVdmbUlCaGhuSVhUSk0xN0x4NmJ6M2VYcFFoNldDaSto?=
 =?utf-8?B?Z0I2Rkg0eThudkV4TnQrdFRVUE9SeUN2MlNqY3ZZbTczYUxTcjNRTHRTMHcz?=
 =?utf-8?B?SjZ1SWFzbktkTURVK094dlB6MHZGcFZWQkhwN0d5WHlJRTlLTHlMNjBrSkZW?=
 =?utf-8?B?Q3lRMTVJUE0wZGNGSlBHYnBCd2RjUmNrUXNZVGRTMVExczlGQVJtTU1HWC9F?=
 =?utf-8?B?d09hdXpPTzZVaW5YZ3QveDBaeTBaU1J4QkFmYkYyUU51aFZlOW00cUllVzBn?=
 =?utf-8?B?U2hhaTB5WVd4M1M1QlJEaGxOdGhvOFRDbjVhdHp5NXJ2ckZqdkgzS25Cem0w?=
 =?utf-8?B?NzNxNE95N2Z4bXdQaUdHRUQyUUxnd0d1ZFllamVLZDV4MkVLNmVBY3U5b2Za?=
 =?utf-8?B?cE4rNmg0N3BYcjZ0MWppdE9YQzljcmNRWnFSVG01ZnRZNzVCK3B3RHVoTlVv?=
 =?utf-8?B?NTFOcGxGbmlQYXR2LzVYOG1lTU90Y0xOemxLaWhrNm5WL3ppUis3dHFQUGw1?=
 =?utf-8?B?d2N4bmxlRnpTSk1DS0RHZ1ExdW1JT2lueWxteFh1Mm5hOGZON1paNkYwM044?=
 =?utf-8?B?Z3pSc2taZ2JxSElma1pjN1V6RDZyQXFXTGQzSW5oTkRVT2JnQnRiekR5S0RU?=
 =?utf-8?B?RnZVN2ExTExmOUFXMjAvc21qT0FIbXE3YjBadkFmNm9COHJxMStOVVhnZ1VP?=
 =?utf-8?B?WlhmVmRHREZGRENkMFdFcTd1OWRubC9TaURxd1ZQUFFLV3RyT2tUeVlJYURX?=
 =?utf-8?B?RTI4dkFkdGlXUEtSQk1WaFRXMVBlWmRxN3UybXh0cDMrRmFQR281aVE4SVZ2?=
 =?utf-8?B?SWhkTjAwMXBKc0I5ZjBDbmlYcXZCRWhrV2hMeDM2WlBxalcrdlpiTDBaOFIy?=
 =?utf-8?B?RHE5V0o5cGtpK1dlNUx4TWRqNWY2RDZKZXBFM0Z0OHZ3YXN4N0MzVyticTQx?=
 =?utf-8?B?bm9zUytXSlNoMFAvdkZlcWlRUkdmV2M2Q2pCMk54NTM0WWFzZjRpUWdwZWVL?=
 =?utf-8?B?WDY1YzNLREF1UXJrMTV3OFI1UkxmczVnRFN3SityZHpNWVlvU3VpYW5nS1dt?=
 =?utf-8?B?czNlNnpiVW5oTHEveG9vTnBSTTVrdEJBRytvQXh2MjFveUhFQ0cvd00rd21S?=
 =?utf-8?B?ZTB0Q3dmYWJ4Rk5yNmVOdGdXVkVsSXg3M2N0YjBxaUIyYjY5dmFGbVJadkhi?=
 =?utf-8?B?bmYxYmhmYkxCLzM1WUpEU2hnMm1EbXhJOXpnM3F2UGpVL3I5WTVYSFdXQ1VR?=
 =?utf-8?B?R0dheHdCTWo1bElRcDYvcFFnMDV4L2VydlYzL3R1S09NcEpwb1pvS1pQRVF1?=
 =?utf-8?Q?G75S07G3yetzj+MXNpGuFTFWIVizbKwKTbINaoLvs5K6j?=
X-MS-Exchange-AntiSpam-MessageData-1: 7BKpAVou4NdI2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a277c-afd6-4897-f70d-08df4b166194
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:06:00.9146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1diFBRxFWGpVOzVoBWrxxdT9vMdhq0WNUksS1fE+2zZkP1XXEfnadBCbGArnaFoN6I5gB4PBSsh2OCTrmgGxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6242
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 11/25/26 18:04, Philippe Mathieu-Daudé wrote:
> On 25/11/26 17:58, Denis V. Lunev wrote:
>> On 11/24/26 10:57, Philippe Mathieu-Daudé wrote:
>>> On 24/11/26 09:39, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
>>>>
>>>>> On 23/11/26 22:29, Denis V. Lunev wrote:
>>>>>> From: Denis V. Lunev <den@openvz.org>
>>>>>> Rate-limited events can be raised from iothreads, outside the BQL.
>>>>>> QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
>>>>>> rate limited too, and any disk on an iothread raises it.
>>>>>> The rate-limit timer runs in the main loop. timerlist_run_timers()
>>>>>> takes it off the active list before it calls the handler, and only then
>>>>>> does the handler take monitor_lock. An iothread raising the same event
>>>>>> for the same device in between finds the rate-limit entry with a timer
>>>>>> that is no longer pending, and QEMU aborts with:
>>>>>>      Assertion `!evstate || timer_pending(evstate->timer)' failed.
>>>>>> This hits virtio-blk on an iothread with an error policy other than
>>>>>> stop when the storage goes away and every guest request fails.
>>>>>> The state is fine, the assert is wrong. Once the timer has fired, the
>>>>>> handler is committed to run: it takes the lock as soon as the iothread
>>>>>> drops it, sends the stored event and re-arms the timer, exactly as for
>>>>>> an event stored while the timer was pending. The event goes out at the
>>>>>> same moment it would have had the iothread come in after the handler.
>>>>>> The entry is only created, re-armed and freed under monitor_lock, so it
>>>>>> cannot go away under the iothread. Drop the assert.
>>>>>> Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a hash table")
>>>>>> Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_ERROR reports")
>>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> ---
>>>>>>     monitor/monitor.c | 7 ++++---
>>>>>>     1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>>>> index 2654b81890..22c00b6195 100644
>>>>>> --- a/monitor/monitor.c
>>>>>> +++ b/monitor/monitor.c
>>>>>> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>>>>>>            MonitorQAPIEventState key = { .event = event, .data = data };
>>>>>>
>>>>>>            evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
>>>>>> -        assert(!evstate || timer_pending(evstate->timer));
>>>>>>
>>>>>>            if (evstate) {
>>>>>>                /*
>>>>>>                 * Timer is pending for (at least) evconf->rate ns after
>>>>>> -             * last send.  Store event for sending when timer fires,
>>>>>> -             * replacing a prior stored event if any.
>>>>>> +             * last send, or it has expired and its handler has not
>>>>>> +             * taken monitor_lock yet. Either way the handler will
>>>>>> +             * send what is stored here. Store event for sending
>>>>>> +             * then, replacing a prior stored event if any.
>>>>> How about:
>>>>>
>>>>>    +             * last send, or its handler has not taken monitor_lock
>>>>>    +             * yet (the timer may have fired, or not been armed yet).
>>>>>    +             * Either way the handler will send what is stored here.
>>>>>    +             * Store event for sending then, replacing a prior stored
>>>>>    +             * event if any.
>>>>>
>>>>> ?
>>>> I find this version harder to understand.  What scenario exactly is
>>>> missing from Denis's version?  And is it important here?
>>> The issue Denis fixed also exists in the gap before the first
>>> timer_mod_ns() under monitor_lock and between timer_mod_ns() calls
>>> after later sends, now described as "or has not been armed yet":
>>>
>>> "the timer has fired [, or has not been armed yet], and its handler has
>>> not taken monitor_lock."
>> We hold monitor_lock from the hash insertion through the first
>> timer_mod_ns(), so another thread can't see the entry before the timer is
>> armed. The handler holds the same lock while it sends the event and rearms
>> the timer.
>>
>> Another thread can see the entry with the timer no longer pending only after
>> the timer fires and before the handler takes monitor_lock. I'd keep the
>> posted wording.
> Fine by me.
Thanks a lot for review :-)

Den


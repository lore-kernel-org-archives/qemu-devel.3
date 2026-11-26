Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E4606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=iG6MJ2p9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWa85-0000Fs-PH; Thu, 26 Nov 2026 09:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xWa84-0000Fb-0k
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:07:16 -0500
Received: from mail-northeuropeazon11022118.outbound.protection.outlook.com
 ([52.101.66.118] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xWa81-0000Dd-K0
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:07:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQnJPwaC5iNY2Jf/J4sC9Wn0xx9zut+7cJ9h597LAI6VQjx6FhYd4L1wbCYD8y8HGwgXLf7dyWJYQjd+G3mDSgibI1hZbZNv7QmqicPCFNG6yy8w2i9Q3m8XtaykT2NIXZaQ0nH5+kTaqlY86+5n7D6AOqptGHIr5oWKfPZyMG2febRwurnFxW7+Yr9wse69zIwAlja2+oKOStmoPvdcuI+FfX5u0OK/Lfo7SwmIgkSUPAzAFj2xE8VPwrql8yeYgaLzIX5eqch73AHLoD/vXoVmIclPq77BUQY/2GBGktBGH+SVBmpYBTQRrb1s02eqfR6GZmUcagn+gvv8+UXP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqZtLx78DzWT09bdn87AKOEThenYN3vPs/FLto5lp0Q=;
 b=lbfC2WiYx9JEpr0oUMhcgcy9cTLqpytebtLOjAUb6vASrYS8+xmtbZFSe1YcStW4z6X3HKLXfFNpML17ZzeTm3PkB2ZiieIp+CL6HFA1vhTdNbxOB8FzNgf2daynI4XD3J7rxj3Ncm+3Fb1UkSmtosQK0de0i4Ju8vvWX39w+xtMe/vWbv4Kh5XJNrygrxTj74ic3ZW+R35mV/i4mqNneASdEWEtHfA1Qa2N1hcQPNahXtTYQykImr7EpxC0uPfNN2F7txV2DnGkTFNR5GV95vwWp0GIjfxcJzcKHrZjnNtjwWeEpOt6Y4IF+zg+Ph11td4EgUrYw6/I20Nw2YsgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqZtLx78DzWT09bdn87AKOEThenYN3vPs/FLto5lp0Q=;
 b=iG6MJ2p9lBlZUFza7yraES2lvMTLwj7P9UT2mF5Od59DFkmmwQEiU6OxsZRUO+DHcEZjloNRLZX7SCt902u/B3g/rbEGqo8VOr6Cpkj9QINSh0nrShakSjCQ38MMxR1ce9C8vOSMgo9htB7Yk2B0UYkULQp5+LI0k6L6zvp0QwEIxxnGWwywAz8pmt7P5DlEr5g/GIopcpNwGHea+9dE6NHSmTWrJxItZxDq8DRiVDQb/yCtZsFeR3oxLpmiT2j7apUzjvohTaZKn2ocj7NPtDG54I287rqbh6iPsX8RxxBW2ZJkLE8pM6sJoRXPRdmH9lhsVKB4B5RnzNmD+WhI0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB9660.eurprd08.prod.outlook.com (2603:10a6:10:45c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 14:02:07 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:02:07 +0000
Message-ID: <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
Date: Thu, 26 Nov 2026 15:02:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
To: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <878q2gsdak.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0097.eurprd09.prod.outlook.com
 (2603:10a6:803:78::20) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: b0838ff9-4e53-420b-a8aa-08df4bc5db86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|10067099003|56012099006|5023799004|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info: X/BJL+R2ift5W/XSe3kMMNoUamVm//neD2hXiFv3Hu/hFH1VfBOmgbGY7TCJ//FxJGncC0/ritlr7Sp8ScNkofftjJXOUTrwdL3YI1DHRN1k15jlbwHhnnP66uC7rfSp8FuYvc+hSNaK8RFMOZyXbxQ/jypR7jgvd4MN8r71jYlO5CI/XSVpn4v7xCk8vxBAAXx5zjIQ1m8+ZgGD4JFXK70eYOgLtVdPM7HvBjebFnA+a04PBnh7aO112QRZBf/ZmkwCO9Jo3XOyINfkWz6dAyjQdF2tVOCCbW3NJ5LSDRQH1++at2Tb0YMsmQsVv460QZaE286MBPrYTenIoRbtQguA2vHQQa0GmU5u/bu/soI8I1/uaybp9ldPLyhQGLrqeyiOeB3zA0nbRA5kwhKPyFZP+3mnk2MMPiCmy8sBcpubUgQqNUqk+WyG9E2pfec+KQ0z+uhsZ0WrWfq9RCmULDivw7LzYnL1LzADOBUlbG87rk+Z0w4LrffjoQ/FqG9N2USLTaLj164g3Aja4w1isZSsFCLE9KVewfW4/auqG7Hnmc9N4KY24ko3oj7k5NHz1w/7LOHCb73UdlKG0dr/0XgPrDFMXTW2KlGMk8VIonehlOO+T5LHCs8ECYZfZWlX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(10067099003)(56012099006)(5023799004)(261102123227099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVFFbnJPaGtzOXBhQ2N2Y3RTckNsN3RhNDAyNTd2Yk9OMXJWWldCY2t3MUI4?=
 =?utf-8?B?K2p4SEdETVpYR0x3bXFEWEZuSnppeTlYNitJRnd0RUprRzRpalFtZ05LOXM1?=
 =?utf-8?B?emVna3ZkQW1PTzR0eHJsUFlLOEUvaXlMZ0V5TzBIMExwYnJGdWVOeHV5SHpj?=
 =?utf-8?B?ZFZEblNUT0pOWG9YVmxtV1B2V0pLNjc5OEREejBNR1VIaWNJRkhiMUhqM3pK?=
 =?utf-8?B?WmE2bHBWbVpQVkU1bjlyTTNiM2Z4bDllcUJ3bTVlUWRGRlJKWTBmUHozcjV2?=
 =?utf-8?B?aVJLTkRYN0R2bE5xaGY4eUZVUFY1SDJUUVdMTWhjMGN1ZTV2S2IrOU0zVi8x?=
 =?utf-8?B?cnVTVnNNdnExSkNXQmtKakR6YmNqSUhMSnlXVmtscHZ4OWVWWkVzb01sV2Nm?=
 =?utf-8?B?aHAzaXlqZmhpNHpVUW5nbUNrVUF6RnhSaGNWb1pqYnAwNUkxTDZiR1NQbXpy?=
 =?utf-8?B?b1BOTnE2Q2dqQndnUmZtMkNOZVppMWFZdVpNQnFrREJpT0xuT3Z1OGo3aVNC?=
 =?utf-8?B?WlVueDhUWWo3WWs5NTR4UnB5WXFaNXFITGtzc01icG1GYTd4eE9QZFZFLy9C?=
 =?utf-8?B?RVRmT25ncmJObkFwaGp4bTdpRjNVbHF2Z29WcGhMRTl0M1dHVUxScjZYUm91?=
 =?utf-8?B?ajgzbUtnVnN0MTBnVXcvcmVWbHFaa3pFVWYxSW5FM3REV1hKZ3VZUERaMjls?=
 =?utf-8?B?QmI4ckRiMEswbWQ2MVF6UnNHTE9aZDQrbnRnME0ramlLSlZ1L1BmRWhWR3d5?=
 =?utf-8?B?dVJjVWhDVjVZZUNubWUvcGFVUUo4d3EwMjJ3R1NZS0ZKUERPNEVVRkpYZGEy?=
 =?utf-8?B?NFFscjdZYTVOT3ZHVjA3QkJXWEw2QTY2djduSDNSMmdDNDN2TGJmVVNscS80?=
 =?utf-8?B?U2IrTjdWSUcyK3ZHd2FhVEMwRzI0RDNLUHFvZlB6aHlXTUw5VEpUT1ZBa3Y3?=
 =?utf-8?B?b2lDWjZjR3AyaEpYb0Frd1dQdjZpaC9HR1lCUnZpSFM3YTZuMnJnbEhRL1pw?=
 =?utf-8?B?ajZlSUkvN0NGMmo5UzZ3MEVrWjBPUHZmMmM2MHNFQ2dxUk1LU0JnQzFmQUh1?=
 =?utf-8?B?dmlLY2FoN0lKMlJTdXltNXd5NE9kdk5zN1NJb21QSTM5TlZ2c3FLdElEUGNw?=
 =?utf-8?B?Njg5bkJTV3FFUTQ0WDM3NlRSM3pXNU9CWFYzQlFlYUtvVVU1MkVVekpuK0w0?=
 =?utf-8?B?UXpPenhONXVudkhJanQ4cDFOYkpyNEp5cHI2YkhtMVlKYXM2Z1JHdmZVeG54?=
 =?utf-8?B?OVh4MHhDaGZxdFgrbi84WXpNdmhDS2c3WVBhb2Mralg0YzA4bjMrMFMvYzBG?=
 =?utf-8?B?Z1ZSL1RFL055TEQwTS9qTFQ3MS9UWXRqM21MT2ZRMGpoQWtYUWhHUlE4WVhs?=
 =?utf-8?B?elo1RkJEUnAzUFJYQTdvRGVzV3N5d3p1SE9qbkxqT2VrOEN6eS8yVDMvTXNo?=
 =?utf-8?B?K2JJN0xZemZpV2RvR0VpWFZveFVDS1kvd09vS3NyWWdIQ2NpTVZ3OU1MekRD?=
 =?utf-8?B?SHYyK1F0TWx1VmlPbXNWNEthVzJJeERJNXBFdm94a0FzaW1ISitheWZmbzB0?=
 =?utf-8?B?OUJzOGdVNFJHOHZWWWtGMXlkN0x6ek5URXR6SGRhR0o4OTRxNlQzdGxpaXNu?=
 =?utf-8?B?eThLUGJXemwrS0xpLzNUN2xnVEhFWllnVkxYRUIycnV6czVpRkJubDgveldm?=
 =?utf-8?B?cXhLamdVY3ovOWNLakUyWnpoc2lXSXFNVGZhcVZEeHBBU3pkK0tHK0NYa0FR?=
 =?utf-8?B?NDVrVVBJcXhFUHgrN25pd0lCdzI5YmU4aUJqWE5KTS9nWUlVV2dHWExnNDJY?=
 =?utf-8?B?WE9hWWVHemF0L2RJNkttcUhPRXdCTFhvdWJtOC9iK1FDQ05oSERYSXkzMElr?=
 =?utf-8?B?MEIvYUxRRlZlSjJiTGF4U2c2M0lHK3JOTE1heHhSWUdudXp0aEd1UllTSmlS?=
 =?utf-8?B?RkE2dFJkM3FlOUg3U2I2d2lkbFJIdXBDODZiNzM0Y3J1WDdRRUhMUWdETkxk?=
 =?utf-8?B?UGRZZyt3MXpEeGJ1cW41NE4wS3B3Z1VvS3BBOExhdGJZaE9DQW1mU09Ha29J?=
 =?utf-8?B?WHRLRW5BZ09oSWpJcHZ4RkRodVFqK3ZiNjhNMGMzV2k5SXlGZUNxVVF0Mkgy?=
 =?utf-8?B?U1hTUXluWW1XeUNmcW1GUmxWOGFDc0ZHcHFJdWZueEl4VEVJemVwZzBYbENE?=
 =?utf-8?B?ZU9Bd0lWN05yWE1kemFNQWtLeHc4cThQR3dwd3RCK2EreWdDRHUxL0I2TXpj?=
 =?utf-8?B?U3NtSzloL0lkQnB2NzVQbVdGejg2Z2pXYXZOUjNRbk5XRXNoUjJjTnZpdU1Z?=
 =?utf-8?B?YnVmTTAxM3pKSWdoVXVNYmwyWUsvZkUrZmQ0N3prejhacFhKYUdYQTdCWm15?=
 =?utf-8?Q?Jj9wJAF2ItNFITXtP4B16j5qFknlG1Mje1MfYYFMvtZkN?=
X-MS-Exchange-AntiSpam-MessageData-1: XgF9+jxaNCBtzg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0838ff9-4e53-420b-a8aa-08df4bc5db86
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:02:07.5096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jvLSDveqVxItAMiS7w3vVpupTRL6wdZr7bgIRR+c5cshgrZtdABIgwfOyNVKIYjeQWGQkRinjzgwWBpX4bhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9660
Received-SPF: pass client-ip=52.101.66.118; envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 11/26/26 00:26, Fabiano Rosas wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
> What a coincidence, I just spent the afternoon fixing this. 
>
>> Cancelling a migration right after starting it can hang the source
>> QEMU forever. This happens when the cancel arrives while the source is
>> still connecting to the destination and the connection then succeeds.
>> The source goes on as if nothing was cancelled, then waits for a reply
>> from the destination that never comes. It waits with the BQL held, so
>> the monitor stops answering too, and the only way out is to kill the
>> source. We hit this in an automated test that aborts a live migration
>> right after starting it.
> How does this test look like? I'm thinking that instead of writing a new
> test for this bug (haven't read your patch 2 yet), what we need it to
> remove the usage of migrate_wait_for_dirty_mem from the multifd cancel
> test. I think that's an artificial delay that's there for no good reason
> in this case. If your CI manages to hit the issue on a real-ish
> scenario, that's even more reason to remove that code.
This is old fashioned product testing over OpenStack cluster
which specifically performing cancels in a row. Tests are run
inside VMs inside the product and thus L0 host delays comes
as a bit of fuzzing.

Tests are running non-stop inside development cycle :-)

That is why I am coming with this or that problems on paths
like that. But this is not very good in terms of QEMU level
specific tests and that is why patch 2 comes with a pointing
tests.

NOTE: both your are my patches are fixed the problem as stated
and the test passes without both your and my variants.

>> Patch 2 adds a qtest for this window, which Peter left for later when
>> fixing the early-cancel crash in 4f08b870f8 [1].
>>
>> [1] https://lore.kernel.org/r/20260421175820.302795-1-peterx@redhat.com
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>>
>> Denis V. Lunev (2):
>>   migration: fix source hang on cancel before the channel connects
> Here's my version. It's very opinionated due to my long-standing grudge
> with this code.
> https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency
>
> -- >8 --
> From a27909503af9749f2cf6d8b901d675ee24c66d2c Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Wed, 25 Nov 2026 18:43:57 -0300
> Subject: [PATCH 1/2] migration: Avoid early cancel causing a hang
>
> If migration is cancelled at just the right moment when the main
> channel transport has finished connecting, it's possible that the
> shutdown()s issued by migrate_cancel() miss the (unset) QEMUFiles
> entirely. A moment later, migration_channel_connect_outgoing() carries
> along with the migration and initializes the QEMUFiles for the first
> time.
>
> Migration then hangs because the source goes into migration_cleanup()
> due to its state being CANCELLING and hangs waiting for the return
> path thread to join, which never happens because the destination is
> unaware and never sends any SHUT message. The cleanup itself also
> doesn't kick the RP thread because commit 64763e8ca61 ("migration:
> Keep s->rp_state.from_dst_file open until migration ends") has changed
> the code to keep the QEMUFile until after the RP thread exits. The
> only other way to kick it would be from
> stop_return_path_thread_on_source() if an error had occurred, but no
> error has occurred.
>
> This situation is not surprising because the migration cancelling has
> never had any synchronization mechanism aside from the BQL, which in
> this case is not enough to protect from the race. It has also never
> had a way to inform the rest of the code in a thread safe manner about
> the cancellation.
>
> To start moving in the correct direction, make the qmp_migrate_cancel
> command (under BQL) set the migration error, which is protected by the
> error_mutex and suitable to be used as a way to inform the other
> threads of the cancellation. This avoids the need to check the
> MigrationStatus which is already fragile in terms of concurrency.
>
> Note that the QMP handler for migrate_cancel is used instead of the
> internal function because the latter is used from other parts of the
> code that might have set s->error already.
>
> In the case where qmp_migrate_cancel() sets s->error and some other
> code hits an error due to the shutdown()s, the
> migrate_error_propagate() call chain will simply ignore the error set
> for last. This is the correct behavior because errors after cancelling
> are very likely to be caused by the cancellation itself. This has the
> extra benefit that the migration cancellation now shows up in the
> logs, which solves a confusing situation when the user sees "Broken
> pipe" and thinks it's due to an error.
>
> For this specific bug, check that the asynchronous entry to
> migration_channel_connect_outgoing() doesn't bring an already set
> s->error and call migration_connect_error_propagate() under the BQL if
> that's the case. We need the whole migration_connect_error_propagate()
> here to handle the postcopy resume case as well as making sure
> migration_cleanup() is reached.
>
> Reproduced with /x86_64/migration/multifd+postcopy/tcp/plain/cancel
> and my stress branch, which basically skips
> migrate_wait_for_dirty_mem().
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   | 5 +++++
>  migration/migration.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 1aeb8814858..12ff68fc38c 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -563,6 +563,11 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
>  {
>      trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
>  
> +    if (migrate_has_error(s)) {
> +        migration_connect_error_propagate(s, error_copy(s->error));
> +        return;
> +    }
> +
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          Error *local_err = NULL;
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 5686209ab11..40c3f21d520 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1890,6 +1890,8 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    migrate_error_free(migrate_get_current());
> +
>      if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
>          return;
>      }
> @@ -2218,6 +2220,9 @@ out:
>  
>  void qmp_migrate_cancel(Error **errp)
>  {
> +    MigrationState *s = migrate_get_current();
> +    Error *local_err = NULL;
> +
>      /*
>       * After postcopy migration has started, the source machine is not
>       * recoverable in case of a migration error. This also means the
> @@ -2229,6 +2234,9 @@ void qmp_migrate_cancel(Error **errp)
>          return;
>      }
>  
> +    error_setg(&local_err, "Migration was cancelled by the user.");
> +    migrate_error_propagate(s, local_err);
> +
>      migration_cancel();
>  }
>  
I have spend a bit of time trying to weight against the approaches
and the only item I found is that "cancel" is actually not a error
while we are reusing field as a error state.

Both are working. If you will take your one - pls consider

Tested-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Denis V. Lunev <den@openvz.org>

I would say - up to you :-)

Regards,
    Den


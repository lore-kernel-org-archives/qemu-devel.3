Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BB606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=aPncBlpO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4dj-0003i0-MD; Wed, 28 Oct 2026 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xM4dd-0003hI-J4; Wed, 28 Oct 2026 10:28:28 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xM4da-0003sf-4X; Wed, 28 Oct 2026 10:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCmITqZdXHUSOuR4FNMA0fv1yO86Pi1+DDliTNbN8PEc6qx171z9wsnxdnC1QpmH7+OvDb4aZYdH2R9SfJNa6HU2PQhof11xB/1IkLzzkRKxibJMYiYi3W3olNMcKXDx2XNASObSOPH9cmSMHHT7jPPUDPDlwxuV4bIGT+2vxyd/XbkyD5Vm2wYz3LI3z+VFlsYCukShPrZaIgJjOnMbYbypWZqot5t/nPRSAB5RZFX71g87XUqXjWGEQaWiXuNUNSuagOjuBAUR+T5dCkuknRR/2hcpu7f5lL0BWdCTIF+tKILtiysvV+1sDfWzEMoaOsx3hyPNdt5UBpXBVWwr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gdK0FIoSy01mcsk5nXXDdpBVNV4qiw3OyHF7APAWUI=;
 b=JjI1ep5lW3Sz2+a3zWfI2Em5i+vLBLe1aopfHXshPIGVDeqTWxhdw8prco3kLGDvCRQflDSjT5AwnVc+vJ8yoDfV8/FPejZAZwfp+vvDc43hEbpkymlA0TMJCm78rFvnYLUtdZ3jIvXcEATqikJbkWIH9h+TcsECryxiIB036vikxelbgrjlqR8LqGXkD8SA0bBEMvDCpb8RQFgL1NS+oLf0/Q1hYS/gTiI4fp8C8J1+fnuauEhXi/bFsIM/cRcZftl1K9DBI0vP3uFCDLGQ7ysr+dmdgf4fq3nDVzIDt8xq1iTEuUlI5yD3kwK7EfWZG58x24QAaAEkc4fRE92/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gdK0FIoSy01mcsk5nXXDdpBVNV4qiw3OyHF7APAWUI=;
 b=aPncBlpO6EAh/FG31CLQs1/AMctUJ7aXodXoP9YEI2IRmNWSCrf6urL6VxJu0mDgu2JBPgC9vO8GjqQsvM4xBKMzYOdW4v2sDWeUlZvE1RH3lw0l9beBEvwaQjFLClDfjFybgLWTy2pjFv0/99e2z91Blc7yhwyGq5uaRfm/uwDA6nliqKAfnLBpZCVMHPXaD9z1hnvbaVFsLQeNe0Wmj70UqEBuFlcH+FwKiMmwE+L8YLAweM6iKJGkRwpLmVOW0hMVhneOqQ6QtnFXDe9RsSVPMOaLB3WUrx0RoNtF1JEFc8At4rmLCdW4aZFBoDM+S/ND72lPXIp1nq7o5pDR5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by BR0PR08MB834407.eurprd08.prod.outlook.com (2603:10a6:2c8:5c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:28:14 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:28:13 +0000
Message-ID: <48b94efd-02fe-451c-a10e-2585c653e4e2@virtuozzo.com>
Date: Wed, 28 Oct 2026 15:28:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] block: cheaper zero handling in backup and commit
To: Eric Blake <eblake@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <127bf797-defd-46bf-9aa2-063f15152cfc@virtuozzo.com>
 <asQeay3yVze-ELxa@redhat.com> <auIEdrOAXTdGM-TM@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <auIEdrOAXTdGM-TM@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0034.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|BR0PR08MB834407:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f4270d-f3c8-43c9-9e3c-08df34ffb335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|23010399003|261026140227099003|4143699003|56012099006|261022075727099003|261022115727099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: e+QaFB5Fd6nsT68zct91bPKnDDLtMKAxnVP4YGXS/CF4MHQoE3QiKuaH8CQZG/kUVTEfqMq8B8SZtiOMpk134153Zcu4ZArXbRmclYx+phwQOd3dtkitAg+8oYKm81DUhoEw1cPA0oIJcteZ69URly4FUrMp7SBepDHv/eNZFWCIQWHGN2bWRkCHzFv8s2yKej4Z3s4W+Tjk6KUJTsx7BD3mSXBvZ5zUjJIRyi84DctV+TMO/1/9dc2fQVzSCZ2a7AuuBm7iylKvSOZrc8P+mxYA9X8VokDpU9/BS3hwaF8Wy7GzZOxsufncIz8y9gkTwaC2QSmPCG27v/XXsLOxqB48UknghhkWxIp+3DD+d4vdWIwdv89LoMDZqX62MUteiA5Ch7mn1WkUrLM17acVJiJpTZErVO5Uj7Zws9gWuWJzvv48P6vVLVrX+LrlYSTubTE+DdgKOQxKZBgFTVZQDQZAJwEoywGu+6zVNjbUvT9ZCX4EBxE+NuSgER7A5vWcj265AuR3Go/iJVKacBG+EHYFBmHqlqhi8uRoUELAGieqqMoyIH/u41yurcKZiHoxps+AMn7cor2kKSMjDNgPD/iW3PWe4XgDT3XOEAjPsEQ7F4DfCkDZ5PirYPoyq/B1vwmyoSX+JrkqfT/8BuDOr0WP7wHMPOC8vEh7Q+Zu/V4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(261026140227099003)(4143699003)(56012099006)(261022075727099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hpQldCcmVaQU8rWDNhUUoxRlgwWmRnNjcwRDZWZ0RhaW9qUEd0djVjSm02?=
 =?utf-8?B?SDlFaFJpNVl2QWdOVHVkeC9IQnlXSngyVit0K211MXNhbGRFZnFaWjZaZmhP?=
 =?utf-8?B?RXFqNWJFWm0wTlVMTmt6K0JvYUFsVTg1K2JIQ2hqL2Zld1FZaWVDZk9kc3Er?=
 =?utf-8?B?bUxmdm50c1ZnU1dJRTNqQ3NXeVpKcUZHc0RxM3dDTEo5QlNQSkphbTZBQThD?=
 =?utf-8?B?K0RaejRZQTNRZ3JxTlFwbW9nL0UySTYvRnV1T1JrR0VVeDdEcDhiTDNVaGdM?=
 =?utf-8?B?RTNnYXhFNzNEcVFueHYxNTByaGxYd3JvVlEvaEtMVlV2dkVMaGVMdWhkYVRk?=
 =?utf-8?B?d3B1c0dYKytldk9iR1dnVFNVVEdZUlRQbDBzaE9QbGdXVGs5NXhvUWUrbzBE?=
 =?utf-8?B?Q2FXYTVXT24rKzF1VW1CT2hKY3I0YlhoK25qTWNhRW04cTJWdk9qMDRNaUZI?=
 =?utf-8?B?SjVSenB3LzZXU3lIblBKN2NYeW1HdnhNL3lPUXVrMEl5bzhIeUo4MVVWakY0?=
 =?utf-8?B?aktNRDRqZWFOcDhKK0R4U2g4WDc5dGdvb3Q0ei9KMmR1MDVNNmVPc2w0RVRZ?=
 =?utf-8?B?bkgvYnhadW5RUm9wUjhrM3FuK2FqV3FGdStWbVc1ZGZxb0xENXB4YmJOQXRr?=
 =?utf-8?B?aVEwVzlVTDZlcGR2aGhhRmwxNWxqV2MzbHZNRitBbGJzL2pGbmRjQjMxREtl?=
 =?utf-8?B?RzNaSGhMT1g3STR3OXhFMHcrTWtNcjN6V0hKZU5YYVBrMGNKYWxzQVdieXJj?=
 =?utf-8?B?N0VIc3ZqWXVxaHJROXduYU5XcDJqMVZJYUtIZnBaLzJ2UmE4SElxZ0xtSExM?=
 =?utf-8?B?Zzd4ZXpCa2RhcERuVkd1cXNGRXVPemNJTGxZZWg4TGFFRGZzSitrY3V5em1U?=
 =?utf-8?B?aW9ZQ0diZWFGTUdpNklaUkgrb3poSVp5aFUrc2E5M1V2RW03ajBwQi8xVHNS?=
 =?utf-8?B?QkRUcWFaU21Bd1FvVHMwMXE5ZlE3SllZRXJnMDd2RUVjcHhzcTNkd2oyZ1FY?=
 =?utf-8?B?blFDcS9LdEYySFk3TkRHVS9aOUlaVCtiaGRiS25YaWRkVCtGc0ZXamQvRm5H?=
 =?utf-8?B?YlN3dzhQL0krNFlWMFlHQzhvcVRvdE9NNUNlMUZNZXNTSVpMN2dYWERvc21R?=
 =?utf-8?B?T1RoZ29pc2t5TjMrM0wwM1FncWlYTkxlNnVPNmV2K3VHbS9pUFgwYzVZU3pN?=
 =?utf-8?B?UzN5aS9DOXdOVGZCdFZJSVlFczFreTV5d2ltWHJFVzF3SkJubE03TS9KSUdV?=
 =?utf-8?B?ZnF0b2FIS0xYZllwUkJ4RUV4RnJoY3A3cTBiTkttakpxeG9aUkkyTlVTOTZQ?=
 =?utf-8?B?em9UeUxpZDdKTWR3MU1jUndZdTkvMllPOUxsN1B0bGJPUWtNcXIwclRTdEhy?=
 =?utf-8?B?cGdJaTU0U1AxQUI3dUlkMDZINVVCV2dyLytXZkRuWlRHdDlhTWhRSU1rS2RH?=
 =?utf-8?B?UmM1VjFBSFA5Y0tGVGltelQyd3VTaStXUUpITzVwRkIzd3d2K21FeC9saVlO?=
 =?utf-8?B?UVpYU1ZSbU1zY29ERjBBSDVacWNpalZCc3ZJaWtSN1RYV3dGVFZ1YjRkMVJi?=
 =?utf-8?B?NnNLOWNEVjMzbndodU05MFBYeXZ0YWxYTmJkZ080akpWaloyVE9qTUt5YzRZ?=
 =?utf-8?B?K1BFMFZyNU0yZ3B5M3dtZFk1RFdiTzdlTnpySzJ6cnBmbXFuUFR0SW5vbnFW?=
 =?utf-8?B?TVZqeit2OVVjYWh5c21Wak1KV2NXYktmWjNMRGhhaXpOMUQzVUo2ZldzWXZF?=
 =?utf-8?B?cU9CblFlcDVqbUNaUUJZTkNLQlNQSGdDdEgvaFhqeENMUU1INks5ZXBsSE9q?=
 =?utf-8?B?RGhyallIQkROWGZ3RkRVTzJ1OFcreGFISXpiTUkyT2k1czRydDgrOXd5M2RR?=
 =?utf-8?B?dUNWdlVmdlY2WC9RUllleTYxcWhwM2dVYmtaZkxNYTlWNXNvMUhhVytkMVFs?=
 =?utf-8?B?allxZ1cyQXRJS2x3RTIyL2FjRDcrbE5ndlE3aTMzT0dZQmROcU5VMUNrWVVL?=
 =?utf-8?B?ZFZjNXJYY2J0Z09JenZsUnA4U1l2YlF4TWVoNHh5bzI5Unl3YXdLbCtEVE5O?=
 =?utf-8?B?d2NLcXJGVEY0aTFETEVJdmtLVTMxc3FZMmR5THVKbC9JR2VjYllYeHB5dTVI?=
 =?utf-8?B?VElVTzFtUnRZMkdLYm9UMnFXVWdQWjBlSG81UDZCbDFrNGU3S3Y3Ym16ampi?=
 =?utf-8?B?S05odU5xbmZ3elRZOTZ0MHQ3MHBqRERKcHhxVkRsOHJkSFp2ZlRoY21pbGFY?=
 =?utf-8?B?bnhJWFdmRDVmM0txclgvRjRSdkJVWWJldVhVU0VFdWY4ejgzTDBsN3VXU2tH?=
 =?utf-8?B?U3V5NzhlZ3J3b2xPMWhQME5UM2toRkM3dGt2Mm9jMGxoSjc0RFh3TkdEQlVY?=
 =?utf-8?Q?oei6lnSwfQWbhkX3F7W1O/tU5E/0rBAaE3cG6?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f4270d-f3c8-43c9-9e3c-08df34ffb335
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:28:13.8675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKoaTwDWU38pyXIVCdR0UAcm3lvWMxSUamnalDkChgcSceXF6BeU+DQWdg/giha0DUAvKR91HMIlCa9VjXxZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB834407
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 15:20, Eric Blake wrote:
> On Mon, Oct 05, 2026 at 05:04:22PM -0500, Eric Blake wrote:
>> On Mon, Oct 05, 2026 at 10:59:11AM +0200, Denis V. Lunev wrote:
>>> On 9/29/26 17:51, Denis V. Lunev wrote:
>>>> This email originated from an IP that might not be authorized by the domain it was sent from.
>>>> Do not click links or open attachments unless it is an email you expected to receive.
>>>> Backup and commit re-query the source block status for every task and
>>>> size a task by the copy buffer, so a long run of zeroes turns into a
>>>> crowd of small write-zeroes requests. This series reuses what the
>>>> up-front scan already learned and lets one write-zeroes task cover a
>>>> whole run.
>>>>
>>>> Backup of a 16G qcow2 image holding 1G of data, the rest never
>>>> allocated, sync=full to a raw target on ext4:
>>>>
>>>>                tasks    time
>>>>     before     16384    1.6s
>>>>     after       1088    1.0s
>>>>
>>>> Such an image is the normal case rather than a corner one: a guest with
>>>> discard enabled on a disk which is mostly free leaves exactly this
>>>> shape behind.
>>> ping
>> It looks like this series is fully reviewed; I also took a look at it
>> and didn't spot anything to add. I plan on queueing into a pull
>> request shortly.
> After I posted this, Vladimir mentioned some possible changes. Should
> I do a pull request with this series as-is, or should I wait for a v4
> and/or followup patches?
>
I'd go with v4. Hope tomorrow.

Sorry for delay - we are trying to kick out new release :(

Den


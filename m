Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E11AD49206
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCyeJ-0002o7-5y; Mon, 18 Nov 2024 05:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tCye6-0002jT-1O
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:06:14 -0500
Received: from mail-me3aus01olkn2054.outbound.protection.outlook.com
 ([40.92.63.54] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tCye4-0007Is-Fu
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:06:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaesoDyLXSpGE4la4MaekYk9/fNgr+3MdN9muf8lNu9IOqnFaThVY/T5jS4loqNKvy+nEakuqxpdP+BO2PqihJ1Vb3wkcSS5ElKpe7ybRicC1f4Lh/sWi+FD9qYoU/ul1EVBCQA2Ne0STfna5IRa9fR0xqYEgs9gGsq3kQqijzOnm/2rk9ssu5r1ieJfUM/jxRDnN3W4l9ZF09eI4oOWgl35HJ5w+hQm6FIZCKrqqSZXEL8IubtGwljYhXhRN1l/y8H6O7wMTcw6WYbP3klj6SOzaRwq6n192bX86xchvI9quCimhXcjFlWtf1o8MGCrYTIgc4lJ3/KLqTgoMZyCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HkmAmuH0VeXaaJyr4+HqZRlLYWqxwu85my8j4nAg80=;
 b=HbbLMQCfOp33nDla/UKSUbjmIoVGZ1GJdevOR4VDU5IE7chOCfI9kqW/fzDwrOVqJNyijDPNwSEJGGKXsYrMREvk+q+jrejzZRtNSx5D/NcMRjiWlqIPThJBrz2SxiBoHywEV+sI2UJBR1Ug68qMtedoDGoKflNl/w+9Z72ZuqClxNyybmixGNd+u1XqAYeDzmHftPkihLQtu4prgZOiKe+RhhwFsaDLNIbWfDEmcwrA/gXeD6RWeXpf8AoM251sFx61ApcUFLgqEwzq/A9J5XJqR7RiQO+IIh64kR+zpGhoWbdvOJgxbwgolUO1HtC8ws5navdu31hIQPVlPh01ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HkmAmuH0VeXaaJyr4+HqZRlLYWqxwu85my8j4nAg80=;
 b=iw6mZEehSlxLBKSM0ul5mjE0UURP50Pc+ZPDs05jZtOe1l0xWL0mAiZ5Xs1J3GmG5EYzFFgxXKk0AuE7a/q4eJf5h8PE3qZHssHbTBtbj9mjmhQuVDk+IIMp02BNceMrkhVOf4pKj8ZfW14H9OSScnOdjcZOrSvsDMuR2k/bBQJ1AoeiSQbRNMhrK/x1SbGNghZFluaVK2HJXi65OMNliBAK/vnkmQBHdU0tJVMBG7rzZT1qPGNBmpvFL/bRl8DbOxJSoSXW5z4nQ9DIBpzFQ+ycCd5X5BIjwajWcu9zsWac35FF6AeIB9E1b9inuCe5LeVi6XzxyUP0g9M1uYFO8Q==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB1515.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 10:01:00 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 10:01:00 +0000
References: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <87seroubaw.fsf@draig.linaro.org>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust/pl011: Fix range checks for device ID accesses
Date: Mon, 18 Nov 2024 17:54:29 +0800
In-reply-to: <87seroubaw.fsf@draig.linaro.org>
Message-ID: <SY0P300MB10265E91E369AB15B611018D95272@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87bjyc3lpr.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB1515:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4101c3-132b-48dd-ff81-08dd07b7e74c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|7092599003|19110799003|15080799006|5072599009|6090799003|461199028|440099028|4302099013|3412199025|1602099012|10035399004;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXVmcFZLV3lqMHJZODA0OUVxV1p3TmVxQkVjbVp3VHdUamJLUnBJYjYwMDhw?=
 =?utf-8?B?eEw5OHlVZW1MUzA2SXljd3VoVWtrRjk0eHlBTTlPSzk0NWQ4RE10VDhSWEs0?=
 =?utf-8?B?QzF4ZzZubzRWaVZyTEhqQnJBajNnYnpFa0ZtWWM3RkJFcEFYdDhoUXVyS2Nl?=
 =?utf-8?B?Vll0OVp0SGJXa2dTaElqOFplQ255NXMyVitSa002YWlxaUw2azJDU1lMZ1d2?=
 =?utf-8?B?c2pFU3Z1NmoxazhZOXJVVjNUanZ3WTAwbHVOSEpTMEZUMnMxWVhRakdBTkJF?=
 =?utf-8?B?dHZ1RFFmN0N4WENBVzU2L3hjbHJLbDdOMXBrYUNTMTJMa1M4a3FZZnp4R1Bv?=
 =?utf-8?B?aDZTbDhXWnB3eWJDdUZSMEJBY2s4aitZaDQvbU1DbmxGbFRRSlp1TW56WFB4?=
 =?utf-8?B?MDZjYzAzQVN4bkx6R0dOWm5XUmVoSzREQVV0VXg3UjIxVnJ1bVdtNWxxNkZE?=
 =?utf-8?B?Q3FDWG92cDZEQU5BcU1uaWF6bnZnVmtIR3gycHRrMWNyOENBOXZHWGhYV1hu?=
 =?utf-8?B?dFNnZGVDQndRNHRBcFVZaU1FZkg1SUZtYkNnTVJ3ZW5oZ2V3a0NRaW14KzVQ?=
 =?utf-8?B?cWxJRWxKbWVaV0pnclViOUZwNkxsLzZrMUd1WFZwYU1WSW5LSUh1czhCUkRO?=
 =?utf-8?B?QVVLVDZDTCt0c2VTeXdQNFptMjJWZHBVU0JBWlpXZlBtUUVDVmZ2WVV1U1lx?=
 =?utf-8?B?d29KbWhFckpaSDBId1BjMGtSd21pTEdsbEtoTDdMeXhBeWl5ZjZ0RFhvcEZ2?=
 =?utf-8?B?eXp1VzVVS3h0cXBoeHhmakthT3ptNjVtR2ZIdmRlaER1dVE2ZmRPbWxCK05n?=
 =?utf-8?B?dXZ2akZZMDBGWi8waWJyb2RmQTg2ZUI0cGhycEU4bTNySUxkeDBRV2hyT0tQ?=
 =?utf-8?B?UWwycFBITldxeGZiZTRXd2VYY1JIN0ZHN0gzYlF4Mi8rdnIxZ2NjeGxZaVZa?=
 =?utf-8?B?THJKWkt2YUhaamFETTlZWksreDAvRmNobDZDWmRKTTBHa2lrL09hdnhRcEpV?=
 =?utf-8?B?d0k1bERKZEs5cVBpL3k1aEwreldmaEhabEZRL3p0SHExK2VGOVo1YUtZclBl?=
 =?utf-8?B?eHEvN0tmYjUyem00LytnWGpUVDVSb1RUUVBtMTdvL3dFbkNnR0hqYzhMUkNN?=
 =?utf-8?B?K0JCdXZQazNkZ2tMR282OGYxQUxzVHh5UjlibHRoOFhkVzZkQjdueU9uRG9T?=
 =?utf-8?B?MzZlZkR1dzV3RWMveEI4enFKUVZJK2pUU3V1VXJXRk1JUWNEMDcyL1J1VmtH?=
 =?utf-8?B?NnB0aVMxdGY0SHZOdlNHZ2gzYTJwQ2tWYlppYU4xV0Y3NEVQS0tEMXI0MnJy?=
 =?utf-8?B?cjAvUlg5VEoyazlGZ3lFMDB3NnpObW1JYUR1dXhZZmU1WXBhVzBhWm82Wjc0?=
 =?utf-8?B?YVYvRFJzL1BibEhLYkVIWURMRWFNZFJLT2dVK2JoV2YwQVFkSGJON2pHS2cv?=
 =?utf-8?B?NTMvUEhNc0dUMWltQ1gyM0dKMkVjRHhWQnJGYktxVTZzd2pYRzlEcTZzRzBu?=
 =?utf-8?B?eWRKYWVBRkdjTlFlbW1EUXFXMDRERU9IWWpUeWVwSFg5U3RHZ2JvbU5mWDRF?=
 =?utf-8?B?Q09LaGZZSlhuZ2JDa0Y5MzlGcHh5UW8rT04yTFVpVUMxVzFNbW9jZE5oc05k?=
 =?utf-8?Q?f/oDVLCFj+YH47h/mwbfJx3esoEI1YKCa0iLbEP9JIr4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnYwTExrd0ZsRSttL0h3am9SZVk1b3lyRUhwWVQ3aXArRU1xbzExRndScGNn?=
 =?utf-8?B?UEh2Nnp2NmlrbG01WEs1bS9rZVp5MFFPZXhKWDBNMHlJUlV6WHVNWUlzWUJ3?=
 =?utf-8?B?YUp2NFZ0ZURRTWVaVTkyQVlsSEdmVmJyVGY1UVM4QUh6R21BdnQrUnVPWWVi?=
 =?utf-8?B?cGUrR2VjTElxS0xDV011Umdnc20yQm9hOUp0cGdvNFM1OU5EMHhsT21SQlBk?=
 =?utf-8?B?ZW1lZFJ5TzlZanZucUZjRWVicDBGdEV1eG5lODBGYW81OEdEUWRwMVdBSW5I?=
 =?utf-8?B?Z2hnYmQ5aHBLZkdXNVNPMzBBTVdtbjhGYUJ5MHhvcEFOZ3pjakNSbG1FaVkz?=
 =?utf-8?B?K1lNclVHeEFVUXErMGx3MlBHcGNhTmVJVmJWa0hPanozNTNKVlNHSUFiSFdQ?=
 =?utf-8?B?RDN5OS9Qbkk4MHBVaFhtVTNJOVZkVnc4RThPbU85aUZaS1gxWmNLck8zYncy?=
 =?utf-8?B?VllBTFA4cGI2YUZQMXZaTjFaa3Aza3phazVJS2JOMWtFaGpuWWo4QlhXN1pU?=
 =?utf-8?B?MDlNTkFpQUlGTjNFeUcySVNMMTJCSDkrWFJJcnplN1N1TGVUeUd3MjN1L0xy?=
 =?utf-8?B?eU9yZjVDSWtNYnRwaFpQM0FnMld5cWM5ajVtaHV4VzV3b0wzZ2k4L0xZOXNs?=
 =?utf-8?B?OHllbjl3Zms5OWxkdkxwSTJqOHhWL0pWYjBFS0VrY0hjbnN3eGhLSHlsSWpM?=
 =?utf-8?B?RVFacEFxTVRISE12aFNnakd5Sm9ya29xOWRacGJzYVgwRVVJZE5XQ3FUT2ZY?=
 =?utf-8?B?N0tCbk16WmhuS0xVdE5YUnRRRGZvNjFBZ1RxaTM5K3FEdENRc3NHd0hYVDZm?=
 =?utf-8?B?UVhVWjFVNlJjTSttSkEvWjd1TkkyY0JubkFUWWwzM2NQNkhtNkxwOWFscmVK?=
 =?utf-8?B?OTR5dFJWUUVOczM0eWJNZ2J4bkdLRFpQdjBxYjh4Q2RMYkM5Y0FxZEo1YzYr?=
 =?utf-8?B?dm1iVVhIM2pydXFkeXozdFhOUUE2ank1eDVrN1pjemZpQTA5QjZHNENRWVhU?=
 =?utf-8?B?ZGZHT0VPRGpVemsxUFRQdUpnSGt0bXBVVnNIaFIrbUowZlNpTXA0SG81ZGZn?=
 =?utf-8?B?SnVlNzc5VWs5MHlSa1hXSk1acVBLSVI0OGgxNnE5QVd6UGtSUTU4VUpvSU5x?=
 =?utf-8?B?KzcyN3BTeUJ5c0JWZ2NiR0FZQmMrZ1A5Q1JxcHpjUHFBd3ZvTDdvTEVDYU5q?=
 =?utf-8?B?aHV3Q0ZuZW9XK0syUnloc04ycGk1Mjh3ZE5HUGI5bC9zdFpVTDM4WmtmNEFL?=
 =?utf-8?B?WUpyanNmUm1zRGQySEdnTmovUDRHZy94a0pIeCtLUUVuTWU3MEQ2emxUbTFV?=
 =?utf-8?B?bm9CR2lpWFpMaUJNU0REOS9WSGhRdmNGYWdMY0htUHBLaVp6UEx4KzI0akRa?=
 =?utf-8?B?N05FRHJuMjJZMUF5STBMM2F5UVlmbHp0M2F1UCtoYXdJWEhIa3dZc1dHNEVU?=
 =?utf-8?B?d2dzQS9Yc202a2FyNHJFOWs5eGdTNEhhK29hS3RGRVVncW5CUnpuTGRGTkZD?=
 =?utf-8?B?WERzdURqdkFuYkxMc3lGMSt1elpkTW50eWxDcFJEM2cvRnJwWXhhQjhCTFAv?=
 =?utf-8?B?cUpod2lCTE43bVZBaUJhdWw4NjRHT2tteFA4MThTdHhlQkp5VnhVMnUzcGlF?=
 =?utf-8?Q?+CFg8Qh2SZHcCfYd1LZ9WKNs7neqd8njCVc/q6MtJsSc=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4101c3-132b-48dd-ff81-08dd07b7e74c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:01:00.0846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1515
Received-SPF: pass client-ip=40.92.63.54; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Junjie Mao <junjie.mao@hotmail.com> writes:
>
>> The peripheral and PrimeCell identification registers of pl011 are locat=
ed at
>> offset 0xFE0 - 0xFFC. To check if a read falls to such registers, the C
>> implementation checks if the offset-shifted-by-2 (not the offset itself)=
 is in
>> the range 0x3F8 - 0x3FF.
>>
>> Use the same check in the Rust implementation.
>>
>> This fixes the timeout of the following avocado tests:
>>
>>   * tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt
>>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt
>>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpressa=
9
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
>
> This certainly fixes the avocado failures.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Thanks for reviewing and testing, Alex!

Meanwhile, Manos has submitted another fix [1] which also replaces
arrays of constant register values with more explicit register
getters. His change may supercedes mine.

[1] https://lore.kernel.org/qemu-devel/20241117161039.3758840-1-manos.pitsi=
dianakis@linaro.org

--
Best Regards
Junjie Mao


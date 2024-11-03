Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B4E6781B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 10:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7XYc-0004dp-OA; Sun, 03 Nov 2024 05:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t7XYb-0004dc-Df
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 05:10:05 -0500
Received: from mail-sy4aus01olkn2081.outbound.protection.outlook.com
 ([40.92.62.81] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t7XYZ-0003fQ-IX
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 05:10:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwO2Jr7XwKi1xfK6mnf+22KHXFt9TNu0HrWJqEy25hYv6ktlnm8t7MpgRS+v1B/jVkkKI8oSdUAnYu6N+lYjRdo9tBPRqoB3RX9oHc/WJvGKj1LHi+NF2tImMLM/RBChLQ9T91V4GYym0JBOv4YDbMZkwPfGZDi9HT0qHI1kb8Jcbbx+5UJwO9zp2GT55OLy+GuunuJp3kWiNYbnpSddb0BCUkkvRZzzqmi8bJ4tIvAMu4jxOIchQYskT0JjllrDwCQdpRb+jYGeJR6DbXQYUhFHYpvisKEf0WN9HXJXatzm9iNNHUgqF+4ouRB5XQ5DCSUPFtMSxSbvmByfS6oxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIijpt0ZyRwM42idmBrb9TC2V4qPMeVaRzn9nvMnngQ=;
 b=ov1bh1mtqj8n9jjJjf+vQIaZ8P5nyKrgmT5wVgJgqGSx9y1OXpcmq2DiE7J84UFKlT4yy3GlyskQ1p1fUpM9JOzLx4qLJdaNHF+V7p1UqTuiA8vlUzhd0QmkKCft4aEKaMiH/EHlNLZcBp9gTaXyXBV9pNQC0y0HmPrmb7EIcmUYKzL6g3u400ego23dOVVfTeJ2sCht03Qd4xw5ZuBkc9M0eTXprDQgK/oyZUSxnO0FHOIXCGGxGnepgaPsejWwcRXtpur7Ezukr9UAPpwgM6zGwVpA/2Ft6we9oFjg+wY5fVvoiYFlJByUa4EH5FiIUEUtc1GdVYJnTIp2KOzTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIijpt0ZyRwM42idmBrb9TC2V4qPMeVaRzn9nvMnngQ=;
 b=kneE99Q0WrQIHESopoifmXzun/aQEkFhGtgBcZn/Tk/1l6XFFlk/ysrLu32/O4yC0X7aVar4o6ilnBLkhLSNGHqI8bFoNmTybm3DglDXC4996Yt46QZXXSVXOnlSuX4ylHLVv/M+GbpVvAxzE2IkxRRfL0nTepdO2G4ogZurlGfP1QHrSJlSH8QClR9oCTiB2w2SI1huRfHdd99KNF0OLU/yHTDDSc4pCpToMlvofU48o4QuwKVkdCaiZb+cpgNJAo6qt/+8nyAtoD0rBK2VlBSdCNqPAjxqCottLKVYYNt5hwno3LpzcwjwGJ5sFFmwgfkmvGVugX7ogHg8qw6Eog==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB1307.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 10:04:53 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 10:04:53 +0000
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-16-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, berrange@redhat.com
Subject: Re: [PATCH 15/23] rust: introduce alternative implementation of
 offset_of!
Date: Sun, 03 Nov 2024 17:54:41 +0800
In-reply-to: <20241025160209.194307-16-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026D525F3022164941671B895502@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ikt463b9.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB1307:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ea34f9-acb3-4127-1d87-08dcfbeef631
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|19110799003|5072599009|461199028|6090799003|7092599003|15080799006|4302099013|3412199025|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG85bUR0dVZQbWM5bE4xbW1PalRwY0s4dlpCaVVRQ1pya3BoSXI0bjZwQUtu?=
 =?utf-8?B?eWJqRE9aK3I0ZWdOSDRhRXBpWitVWHA3ci93QjhnUXlseFRsVTdhanpWZFQ1?=
 =?utf-8?B?TW9nOG9IQXJadXN1QzlaN0Zkd1JCTnJBSGs1NVptWnhmczE5clkzNTUyTGp1?=
 =?utf-8?B?eWN2cklkcWlkMGlDaDNaMXNTdlZHbFRwNmEwMS9YSThwVWg1c3JMZy9BUGQ3?=
 =?utf-8?B?amczZFRlSy9qSGpwN2RXZE5GVHdoaUIydmxUYTYrMURmL2F3SFF5b1IwTmtW?=
 =?utf-8?B?ZmlJdi9Yc1NWT25HL1hDUCtIZWF4VEtCNlhFZ3NjTk9WRWR5aXRvU3JuRGs4?=
 =?utf-8?B?VWVLbkw1ZUE1Y3RUTjJhNER4cDBPdkxYYjd0WkJJbkVpekhHZFhmYTR6bjRz?=
 =?utf-8?B?RmxvcFFBK0tGdThNMU96dkhiY250NW1RdlJINDIyZkJGQkNobTlGYlFwOU9Z?=
 =?utf-8?B?cmplS2NsWkdIck16MXdnQjEyUVViczliVndIUWsvZFpDVGkrRERxd3VrbVI3?=
 =?utf-8?B?Nmd6UHN4NTFKVE45NnZ0a0VaYi9abTNYTmRUNTQzVEF3YitGaEZvY3dSL0lJ?=
 =?utf-8?B?WDRUc1o1M0dtSDJLdVFKYnEzcmhSRkI0WWZPa3pEcVlMSDZrR05EZXlNNmxx?=
 =?utf-8?B?cm4wTDNOd28rVlZhL2FxZXMyeFBGbVI4Nmt3MlEzaWtyUFlIZHJwelM4QzBy?=
 =?utf-8?B?T2JLVmVsU0VMZy80b2NBZ2RzOVk0dkdWL0xITUZjY1RlRTdZNllFMitMSlFy?=
 =?utf-8?B?RWNtT2dzcmcxT2tqVzlYYzkva0R3UzBJWHdnb1RBeTlQRW1wTFBQeVN5ck9E?=
 =?utf-8?B?aXc1YWpXQXZaT2NhYVhsaGNLajBRS3F0TkI2LzBYNndvY3F4K3NKcmVvNUlm?=
 =?utf-8?B?YXV2TXE5cEZrNmgwcE1SRDgzRStHdjVuM21tdHQyU09LRzNPeU9YelJROHZy?=
 =?utf-8?B?a2Y0aUo1WXVTNEpvYXNzWUVtbGt6b2dMR1BrVU9tQzlxZ3dtMkpUTHYrNk02?=
 =?utf-8?B?Ymc5YlphbGs0aHlTN3hqc2NWSHVaMk1jejlkZ3UydVgwM280cllqbkVEaUxy?=
 =?utf-8?B?N20zZy9odXdpK1ZsbGpFKzlWZ1VwYlltNHlsVmw2T1gxVWNkWXJvYTR4cWtG?=
 =?utf-8?B?VUcxelcvaDFQUk16eXRyMnNzNnhLTnNteWw2OS8yMHo0MTFVMGdZSE1keU5v?=
 =?utf-8?B?MGZQeGVxODRmcytWTUd4Wm9KdkJlUzdRTW9QQm11VWQ1WCtnTlhBOEVhc2s3?=
 =?utf-8?B?aFBGUWJ5ZExwZ01WVnZjUWtLYnNwdVFtbGhuM0FtbzlyblJVdVBCYzVrZTRL?=
 =?utf-8?B?dHFNN0FjMExnL2ViREF6UFh6UUFPRXlxdm41cnJLaUR4cUpXWDdGTi9uTnY4?=
 =?utf-8?B?WW1GVXgvMFJad3VJcnpJSGRvcnp1Vjg0VmlRRWZsSjNISk1JNjU1UzdML05p?=
 =?utf-8?B?WnFRVHMyUC9PbW0rYkY2TE5Hb1hKVVB3MzdremVrMUJVOVhqb0FDYTBVTEQ3?=
 =?utf-8?B?Y0ZZUHh5ajcxMXBCYjArMmZCc2YweExzNGV3QjJUVVg0a1lIeW9rc3NsclVi?=
 =?utf-8?Q?rVr0hCGiGDA/dA9XWSY1QeePgK6QhByKxJOyZyXWkZl1/d?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlBNDY0TXdDbjhmTjVCTjBQT3lwS2JlT2lnMzVDRGJFdnpiQmR5QTRsVG5Q?=
 =?utf-8?B?Vll4TzMyTVF4SFd2VWlqWjlicXpBaE5YUTlOSmtYUzcwN0laM0RZZ0pNTzhE?=
 =?utf-8?B?SkI0Tm4rSUJWd0praUJmWkI3eThRTjB6cUE2SmpNVnd5ekVOS0lZUUJTMjN0?=
 =?utf-8?B?SXRMMEFjN0ZWQ1IvK0NMVVJOdVRoR0w0eXhXMldFKy9rajQrZHdER2hjcXpO?=
 =?utf-8?B?cXQ1ZkVBQkxmSUNjQndQNnNuMi9YbmVMVSsrYnJDcmZSQjMwR3NYeWRwbVNk?=
 =?utf-8?B?b1lYZ1E5SmtWa3BPTERMUnVyYSs2R1BKcUVHaHZuWXhycFUvQk5uQ005ZEJO?=
 =?utf-8?B?Zmk4TDREbG11MjAzNHpJdVQ1aU4zS2VaTzhrUkxNbXk2UHFUVTc3QjNHTy9p?=
 =?utf-8?B?NGtydVdkQk0rdEYzaU1iYmdmYW1FamxGek8wSW53VGlJOVhKUW5sd0JYY2VR?=
 =?utf-8?B?Vk5oWjhCOWF6ZVZsTHJzbXp4RXN1VWpOS0pFaTk3akp2eGhaZEFWSnJKNHYy?=
 =?utf-8?B?elVqRFkramh6QXZ1bHNtWFh3ZmpyNHRnREE4ekVNSTF3d1hIOFJXTG5WNnpr?=
 =?utf-8?B?Wk5HSjFpTlpFdzZmWFZZSVdDNlBvVEt1clVqY0dBbDJvN2phak5IdmR1c3FF?=
 =?utf-8?B?TFZmR0gwNWpUMVJJcngzazRnVFRTdmZhRU5rbEFwUHV2NmlwTG51V0pEUUVs?=
 =?utf-8?B?bVZsR2xVbmphSHNZbGFkRTJ0RS94Q2YrTllMS2J1dTdvODc3SXo4ME90RGRm?=
 =?utf-8?B?aVE1NEVUa21ZVm15SVNiVDNrUitDZllsdDhmSFBYRHc2ZW1aTHNQQjBXSmdn?=
 =?utf-8?B?aDhDNFFzN3IxWTI5RWJEeU5jdEgyMGt5ZHRyS1dLSWlKL1liNkRJNTBSZHpy?=
 =?utf-8?B?K09Cbk44RnB4OUlTbHJLeHExaUhpTDVUNEV3cmxWQk9ROEpLaUlneUJ0Skxs?=
 =?utf-8?B?TmVUMDNwMi9Jb0hLbVVsczZ6YWprbGZmTkIxcDQreklrZjlOZHhLRGZnTlo2?=
 =?utf-8?B?ZVFJS0YwMDNEN1dVV0x5R0J5aWQ0Z3Jlc2FPWUF0V05iTUpqNVQxYWNlVCs2?=
 =?utf-8?B?aXNuSlRMcFdPekgyYlFQL3NyZVJDSVgyV0pDME8vK2U0dlZVLzBnem5wbGJs?=
 =?utf-8?B?QWRpWFN2TEVqTzBpTFJ6Y0hOZEI5NzNibmpEQUNKOHFUR3AvSVpWQllPSkFD?=
 =?utf-8?B?dFQrRDlFbVhlWjdsVXpoSmpXbmNoaFZyeURJMXhFbHhiZ0dyRTAyUFFwV215?=
 =?utf-8?B?RUE5ZzZ3eHI0ZHMvTWhWWUlwd2piTkJuY0RrbzlsRUtZai80K281YmlxRUxO?=
 =?utf-8?B?ZTkvRzU5SWFWREtjOWgvaXBBOXZROHFVeWNEZy9uaWx4d3p6TEhNUXI0SEpR?=
 =?utf-8?B?bjFXWmJ5YWppQXp6Nlk0SnlhdU1MUXJSUWEvWlF6cjQ1djNEdHpXWUducjdX?=
 =?utf-8?B?RGUyZi9UVk4vdU1uMkFaQTJkWTgzanVuNWt3NDhsVW1KTFZralVjNG03QXl2?=
 =?utf-8?B?L1pIWm1JNUEyNlV5REowZzFtMUV5b20zaThPSWpKTlNwNTU0TFJqWko5TEtn?=
 =?utf-8?B?aHhHb2h2UU5STjZpTUI5YTJjL2xMZURyRlZURk1WM0VPS2RPUFArVC9JcEl5?=
 =?utf-8?Q?VHuDyYRtYIipkYeQkqe3VJltzVZIpXKLPbwWsQ8gLg3I=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ea34f9-acb3-4127-1d87-08dcfbeef631
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 10:04:53.4170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1307
Received-SPF: pass client-ip=40.92.62.81; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Junjie Mao <junjie.mao@hotmail.com>
>
> offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemenati=
on
> that was found on the Rust forums, and whose author agreed to license as
> MIT for use in QEMU.
>
> The alternative allows only one level of field access, but apart
> from this can be used just by replacing core::mem::offset_of! with
> qemu_api::offset_of!.
>
> The actual implementation of offset_of! is done in a declarative macro,
> but for simplicity and to avoid introducing an extra level of indentation=
,
> the trigger is a procedural macro #[derive(offsets)].
>
> The procedural macro is perhaps a bit overengineered, but it helps
> introducing some idioms that will be useful in the future as well.
>
> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Generally looks good to me. Thanks for integrating this!

It seems Rust does not have builtin support for unit tests expecting
compilation failures. There is a crate (named trybuild [1]) for that
purpose but it requires introducing a dozen of new dependencies (see
below). Do you think it worth the effort? If so, I can take a closer
look and cook something for initial review (probably post 9.2).

    trybuild v1.0.101
    =E2=94=9C=E2=94=80=E2=94=80 glob v0.3.1
    =E2=94=9C=E2=94=80=E2=94=80 serde v1.0.210
    =E2=94=9C=E2=94=80=E2=94=80 serde_derive v1.0.210 (proc-macro)
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 proc-macro2 v1.0.84 (*)
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 quote v1.0.36 (*)
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 syn v2.0.66 (*)
    =E2=94=9C=E2=94=80=E2=94=80 serde_json v1.0.132
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 itoa v1.0.11
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 memchr v2.7.4
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 ryu v1.0.18
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 serde v1.0.210
    =E2=94=9C=E2=94=80=E2=94=80 target-triple v0.1.3
    =E2=94=9C=E2=94=80=E2=94=80 termcolor v1.4.1
    =E2=94=94=E2=94=80=E2=94=80 toml v0.8.19
        =E2=94=9C=E2=94=80=E2=94=80 serde v1.0.210
        =E2=94=9C=E2=94=80=E2=94=80 serde_spanned v0.6.8
        =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 serde v1.0.210
        =E2=94=9C=E2=94=80=E2=94=80 toml_datetime v0.6.8
        =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 serde v1.0.210
        =E2=94=94=E2=94=80=E2=94=80 toml_edit v0.22.22
            =E2=94=9C=E2=94=80=E2=94=80 indexmap v2.6.0
            =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 equivalent v1.0.1
            =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 hashbrown v0.15.0
            =E2=94=9C=E2=94=80=E2=94=80 serde v1.0.210
            =E2=94=9C=E2=94=80=E2=94=80 serde_spanned v0.6.8 (*)
            =E2=94=9C=E2=94=80=E2=94=80 toml_datetime v0.6.8 (*)
            =E2=94=94=E2=94=80=E2=94=80 winnow v0.6.20

[1] https://docs.rs/trybuild/latest/trybuild/

[snip]
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/l=
ib.rs
> index a4bc5d01ee8..c2ea22101e4 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -3,8 +3,34 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>
>  use proc_macro::TokenStream;
> -use quote::quote;
> -use syn::{parse_macro_input, DeriveInput};
> +use proc_macro2::Span;
> +use quote::{quote, quote_spanned};
> +use syn::{
> +    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma=
, Data, DeriveInput, Field,
> +    Fields, Ident, Type, Visibility,
> +};
> +
> +struct CompileError(String, Span);
> +
> +impl From<CompileError> for proc_macro2::TokenStream {
> +    fn from(err: CompileError) -> Self {
> +        let CompileError(msg, span) =3D err;
> +        quote_spanned! { span =3D> compile_error!(#msg); }

The documentation [2] says "there should be no space before the =3D>
token" and that is by intention to tell that `span` is "evaluated in the
context of proc macro" while those after the arm "in the generated
code". Should we follow that convention (even though the extra white
space does not impact building)?

[2] https://docs.rs/quote/latest/quote/macro.quote_spanned.html

--
Best Regards
Junjie Mao


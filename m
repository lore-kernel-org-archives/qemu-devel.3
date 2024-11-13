Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CA4D41C0C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 07:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7gp-0005CU-8O; Wed, 13 Nov 2024 02:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7gm-0005CB-EG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:21:20 -0500
Received: from mail-sy4aus01olkn20831.outbound.protection.outlook.com
 ([2a01:111:f403:2819::831]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7gl-0006MF-2m
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:21:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+Mx+0xL8VPBCuqN0CFgaRIWrMcbyxCJfGumha/V5WjipIN9rlTRfXzQ7Z9K5RPLhJgPjjP+OjoB1OWvJuYJLBFPqdHxQ9C7Ut2ZRkKJ9kXhmo/9nxQi94C9mqaVBEyUXaMkpjgNuXc5YjN02vbAfTpXfM0h5j3JeNZcfZ12EqY3tpbYE1Hw1KDZ/QG9jrxawrTzT4pUI+SnwQ1GGXuSeSdkfYV9JIoS54sBqHJ31/acq+AIbLP+yP5bTzUjgJIxExhXJ0Z9B7F7HjsJZCQhItIgcz7WqmYmIZn/KnHwCRwQdHDDfUpzyrL4ZtMZ3KMKxq50fXs/NM7SIYSrxfNh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqiDyJdlmpyNZBp6geiDGviZ8bTd4zHTIKXFSGl7Es4=;
 b=xCP2kTLQung3dGbmrWVb8oDWeiwBBfMUGrVTe8J8xcC+erSGZjMJsX+KjwPoUSEMqjmAU/3P+e7+HYtd4i2QKX8Rmj15Y8gkDEfs++U5wr3PK8ShlDldLzTPmrQqDYdmvgh7YChgWC3H7zYPaB0lhB+H4pYZCmldwviif99stUUhDtY11rAb6mN6yfJHWSoYFVacbbXoOkv8tqls0O/NcSoZCYBgFvvKh9YI1YSYVSX7Rhrci7W1Uuzuu+CT8l6w2JUIBQeyndGVbWIM0gbB+89rSsVnSQ+7rwct9cRltwKCeGnJRS1Gf9yXIMeNaS3T9ftvEOhGSKcKS317Y8j7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqiDyJdlmpyNZBp6geiDGviZ8bTd4zHTIKXFSGl7Es4=;
 b=IPcikW+myKU4kzTB9forCZskIR+8oPXJy64vj4AkqFW6NXmnqF0rsnhGTgxx/g9pU843I4Wlp39yCUFBKP685009oR9XrFhlun/9VbKlAEHHcW1Ht9USnzMQ0MJgodPSmfG9pzX7AFbFWPWZQOm7L6hRNdZhGoEyDDIEjrHSLpDzx0JH11DYTh8UKqpgmuXLNab3SrURzAJw69PWY0U4jaljccCTDDtzKqjK2L+ZFcd/0PDwTXEcicsSrEj2WBC1jO7IdfDT7Zh6bDJVV9yEpEpYlqkB1ZHl72XyKAmwaXU10pV5EvIMXHD3WkGdTgGOyFpAT9zScxSKEJA/vYMn0A==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 07:21:14 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 07:21:14 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-10-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 09/11] rust: build: add "make clippy", "make rustfmt"
Date: Wed, 13 Nov 2024 15:20:24 +0800
In-reply-to: <20241108180139.117112-10-pbonzini@redhat.com>
Message-ID: <ME0P300MB10405EB94F91F46BD7537948955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <874j4bfvkv.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|ME0P300MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: da7a5d0d-d757-4963-3ba0-08dd03b3c203
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|5072599009|19110799003|461199028|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WSMSOEXzEs/C96g4BbLSjYmPWTLcSFV++YH7S11czFOBpkpkIhOAijmbcjJj?=
 =?us-ascii?Q?FTt4qxPy/cFURx25X/CmJ52Nimz75iAJPXZN+t+f8jQiy9shSxYTpSLDHmEr?=
 =?us-ascii?Q?9ij2JMlShxCBvYFSAM3fY4GzmSaE2zddQyCtqxNR4uLu4fGppEqNRhymLuGK?=
 =?us-ascii?Q?iN0P6CWTL9WfDOHVZonHvU8C6dtoAWNQAANnoa0PP8UZk0iA+y+R7jlLDogz?=
 =?us-ascii?Q?SSSWk2zwOqS5uaYRGKfeYuMJEp1UjAnlU0Lsxu51IFOaHbq/cj8yYsMwOP2P?=
 =?us-ascii?Q?flHBKEe8EpyMMAdMIVNkbvi3xw/6lzd+tETtoZBQhA4sjme0ghSJCja5TOtw?=
 =?us-ascii?Q?AsMVZrNt45G2cqX4OYQwfgKNYNLm1KnVujzl2DSjVsabGvP8qI+BCeP5YDqv?=
 =?us-ascii?Q?iuIDu+LoaLvMVp7ZbhkYoAYhJVdnVDd+t5WpiYON4K+PLaATcq+/4i5BWSe9?=
 =?us-ascii?Q?yo3VuMw3w3pyyJYJLA0eejJcIbK/TEB5eeUKknm07ZNiFzSGkBdan6yz46ec?=
 =?us-ascii?Q?KTxwoDnQs0lq5t9Nj2rVstd6CdP3vqIFsLhhcy4fpqbqnycinfzaCvLbOVG6?=
 =?us-ascii?Q?8p9QMCaiej51MeoU3boYOxINQDPo2FwgMKVIv9x+aETW+SZumTdQgE1ht1Cw?=
 =?us-ascii?Q?Mz6ePdalep1DIRfc0iCIkRjmW3LqRerscABWbaPOhoHPTn4ejvLpdW235IDW?=
 =?us-ascii?Q?weZQBVuIE08LeUELGs7nZwMSh1T9lk15kgXhWOTTEuIV93FYWJ6fifGJ9g9F?=
 =?us-ascii?Q?PNJDLh3/WaISUwjH0rpCdggVMFC82+q+UewdNxcMBnoyghOerYnBKFrn/LzT?=
 =?us-ascii?Q?GQnZ7Li/HIAj66kIcISx8NAXSzWb823YW2FRQEYPUTGRHUykZPMtIvlgU+Nf?=
 =?us-ascii?Q?x8BA+biKIX/RtesERz4XrKqhmeqzzBvBVnm3DSwvN5boPITWqym5BwwwxFbk?=
 =?us-ascii?Q?Hptxq28MK9Aunz7wALEFUhAoY/jpOFlfurtMnLrYb2Y7lauXbWSVZoevHWeu?=
 =?us-ascii?Q?nnTxB44wtHNLQk+DAK4hSPrhkbvKf+ZKwBF7M7BqJnnxe6c=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+rVZmlTr9Geg0OUIS+zSEoSLD7aLs5+vzjGlgpHzoPgxtHOpn9LegwO/ukdg?=
 =?us-ascii?Q?3GgEof0CVI03Nh4dSZpSW+IsxLpT+YjbkVeuh+7eBBd9ZKHczj7BxIyC9s+f?=
 =?us-ascii?Q?cARWjyiv0Vh+H4+JOEe1tMsupfFixie1SEJZ6O2sgFDhCkaBJ6ekQx0of/kl?=
 =?us-ascii?Q?WNXn8y36WtkeuVDEE1Q9k/zHIKgKYN8ue7s2R9RENjEHaZHOH2IxACLyvRG+?=
 =?us-ascii?Q?DcHJ9qAh9PyDQn8KXYo/NuS2CNz5wk/Y1/qVGi/GfE1f3kNZ6TrzxgFA50LE?=
 =?us-ascii?Q?XcyzqY2KtHDyn8yD+C0sqzeZpsfKPqFDG1mq1wAVTQl7VFc2lTdNYUBqieOR?=
 =?us-ascii?Q?pOnupE3nzh+Mr6HDbtLptl4PAZ6O8UXebY5FzFp34Qlq2lUX/uSwlRQ8QVeH?=
 =?us-ascii?Q?czWMbRQmUV3UZEXs9pjRlU7VBUAc9eLWxHz9a8U6KHIF14OjU+djXBGYPfuq?=
 =?us-ascii?Q?JGjv3HwZcM5g6MCYXSIo5s5n3mlD9bHpmjHFrN2b+Gu95Z55D2l2VWm+XLDB?=
 =?us-ascii?Q?CSql1Lrc1651ZmCDP7uqXS8sIz+B+jiw+2LF23lgyudubTpGSmA8ESvETRAT?=
 =?us-ascii?Q?gIdJu5boZn9gKOZkQlhZubjkpSxi+ZHk0V8xkD861hiqTzzphoUXAfrgu8OP?=
 =?us-ascii?Q?DTzmjtJE9H8PKeRfBkoAfP1TnjBwd+ny5kDlr4rYONzNhIxzigU/MulYQaC4?=
 =?us-ascii?Q?25yF7feM/tZTn8LSKdBdX7Nru5gmVyTYXxepBgAmrIRNAzdJJQu6Z8WPc2R8?=
 =?us-ascii?Q?TJlsOWSBjDWuyK0zCheb4ZNhChjTRA0ckV+RHyihgclm+PZPHK4R3uF5fsmI?=
 =?us-ascii?Q?BetF4SNfN7ESMAra8MmYrzI27PsAZDxAluCCjkw788aLQ7LoE2jXZ2OPVA4f?=
 =?us-ascii?Q?YJoJCzgKVdQ24prK9k5S32UIm/d8F/mgvVUFpBmlvA3jmIrZYCY7Lh0d5fV1?=
 =?us-ascii?Q?bhK+E4Tjek6iMXmnFeXSsPRs6oKm/ZfWoO0mUg6p3k3qp+dBpFuL5tfuQTCq?=
 =?us-ascii?Q?e3UmeIO8da2NogeAepY3KikO5e80V/5SjLubEltdIxZ51rVJgtyKAsqebqtL?=
 =?us-ascii?Q?ZRKXSsAfXuHNleSma89QMqVs8GxzxsmLca3Wuf50VQvlg0B6SiB1V8CIgAOj?=
 =?us-ascii?Q?xtw+KmtgUHN4fk1XWTHW5gj8y9lqTK7Q/zU01hQtfYI2J8GmLamiSYmPSuzJ?=
 =?us-ascii?Q?Kr0xQK6gwwwfBnpE7TWQOWJeqkytV1w2wMXuOoNfv6OZ0WV7FGW7kiRSLlw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: da7a5d0d-d757-4963-3ba0-08dd03b3c203
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:21:14.7350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1309
Received-SPF: pass client-ip=2a01:111:f403:2819::831;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> Abstract common invocations of "cargo", that do not require copying
> the generated bindgen file or setting up MESON_BUILD_ROOT.
>
> In the future these could also do completely without cargo and invoke
> the underlying programs directly.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao


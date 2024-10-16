Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD8D2069F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 06:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0xX4-0000mN-C1; Wed, 16 Oct 2024 02:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0xX3-0000mE-6V
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:29:17 -0400
Received: from mail-sy4aus01olkn20806.outbound.protection.outlook.com
 ([2a01:111:f403:2819::806]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0xX1-0007Yu-Og
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:29:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKcfWQjGMwcYRw280SagEEYff/vIhn9ashoqdMiJehxsuWL4i0i7YWWw32u1AjeE7qVYksHkgA3pjEmFgBg1uvAGjSSCpaVCUbT81TR/6bm1UjesvPeuIib/rNSWhS3RjvYr5SJZIgDSmwaCYcrDZShIQUwekuGTGlpX/IoIaekKS7MVBuQM4Yu+zSDSkzaRZgI72ft8afu6gY7nI8edoM8u1DwmREbo/C2OLNs5509s67BahuYrdTE1CAMY7wSjfk1NE9nlcU3ZLcCRWixgMvNg2coOnYHXeNlmdPAjzprxPl+W212UMZFhdpcDUTEQPdx1jYRISkrau3ZDBZ1Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJhb6dj4QLGGSTnxRxqe5tXVnlF+R2wKU2FrusyEy2o=;
 b=DWEwfut0nTVQS2wIoteXm32o+cCTSFZN3jeukYbZRukGKMxLcGaOjc51Lgq0kj5NqXJW9Q+xXdfpxtXhZhnT0OTVpn1d6vFpEWVtCPfXiehVbjd1b4s7U2/GdXSUe8Het3OKxmjyrimQv3tXFCYiye+dmJ/7mS1c/P/yuORfLSYdGV9T9jxFhj9BY2kZmZsUMdqI79WopnVyLqJaKzvidtSX8H5Ceok+VGxLdZps/NX/1NhCCdqKYT8ttOHoCCSYCpF5hVNwRMXNv0bl3P2fpwyVkpvSwxIxYg/edp4knHi+ldJX6OstiPEuuVjKt0bSYRXFh+/mayiYRfXTJBE99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJhb6dj4QLGGSTnxRxqe5tXVnlF+R2wKU2FrusyEy2o=;
 b=Ez2QynmvwLf4DNIofBKmSEVTx8KQbsuAc0cOdrjqKUj7rIkqGporINbmV8oaMr/PI0riHmOF2cGuS9SN91e6lHy20aL4syXIeBR9YvR9EpZAPRR1x45Wup70prxOHHrfxMvAJLwDszS7t/vfl3VvXORUdKdzch7X7zXdswAWLa+r0GeUZfHp5rEYr5JJ+zNAv+D9iJwtqeXnW35ZekFhcoDWoJEeUE8qI9mN7UXJCAKrEmWOQaLMLHoWUnkNttUmMfKlBzqs3/18mfNeOJwj/G9+U63JssR/+SYnuEW3DeXKn2tUvsh54YDjXc2oOjgX/pmxV/1oeNef/aTXJzGcnA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by MEUP300MB0318.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 06:29:10 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 06:29:10 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-17-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 16/16] rust: allow older version of bindgen
Date: Wed, 16 Oct 2024 14:15:05 +0800
In-reply-to: <20241015131735.518771-17-pbonzini@redhat.com>
Message-ID: <SY0P300MB10263F19AD3FEB043D3D47A195462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87a5f4r26r.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|MEUP300MB0318:EE_
X-MS-Office365-Filtering-Correlation-Id: a611b7bc-8c55-4477-60d1-08dcedabd831
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|5072599009|461199028|15080799006|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: xA8efb0yVhD3sFjmNrqKgnaAiYX26BYnoWC09paStw9wwl/7adua2bWb9+NCFDcPee8Ad5UXa9S0PGd3CWOlQ9WWw7B6LNol/7dZ2/dMWegSC4BfiuZZJXaL4D5M9pZCAh2hll3ZiEhGanMhffIgGqsDQfciE1RU6ldbV4j23n3ykJTVr9tZZpjaaWId7qk0U0gEJZ9fqdy8v9zAo0zINIZh8CKK9b2OQPGcOwnQ0jjtrelEpMA1VQo7PIyczv0ql+oOE0sGCNzNUVNVgMfZTcRWxmLtxk3e2Cx+cEYx/DSjMrWUaB6YGaqiTpE5n/UbGdXw3j5EXGG0hAmuccRGQmuZDrNYSpcSW13HrWaXQU+orhDtasbMoXncQGUSZZMc0Wy1mYywUnlwfYARN/Ns1hyPjYb9pbGJIZMEdaxyk+KLtNCQkhyqpG9olXHGrURbkM3qxL5gCFhIPttrm1+6r0X6crEJU0g21Cb3SzEXpn2iwEwXOQSvMjvAc6DZbLHasJkG1ydMHuKw8TobSJSo9TxYUAcJ6m+ulJwJ821hQQoCbpLOrRs4fJngO07DKfAtr66+R088egpHmz2SvJsNEMd9nzutHuAtrI6wmy15Ej+lBD+4QgLfTT4M8r6drb5QoQWGjeVUGAOizrK/N7fGGKgTSmmkbB1q2M6QZrNyJ7BMtukgRcGSia+/eZk3XMWmqYwaCJM/ewBWcgf9jUq/UPVsC+YOjgpw/eDM6z03NNE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1zZNiCcOsg5CcfKvQ55lHFF1VqKMq5Eg9EiX6jc30/ClDVkL1gKJQkvZBBP?=
 =?us-ascii?Q?0qYsKBfYd9/z9FYryx0tFv5TyflqEVKHJj7Gr8IwPtURg9uYZ+rQqIj4cW0W?=
 =?us-ascii?Q?j2jPuEJEkvSqegH5OtOzeoPY9Xj8uDM/3GyQx2RYL2ireaR9k+98I9tM05GJ?=
 =?us-ascii?Q?bAt+74AYYx3mJJb+AIGSHQshSudIMmUFtz3AHGiP/pMS1sRog5QlTAIT+18z?=
 =?us-ascii?Q?cuFqE1pHDJOJK0AfcniR3aouOFKNCRkEI95NfDJFpQOaRa0p0LVZWQHhGZOD?=
 =?us-ascii?Q?CVD7gLgx9/I+vlzSQBCSZxleOYgpC+dMx/7rHSLWefPOywJyYa9YYMm4BaTm?=
 =?us-ascii?Q?YwAar5V3WexE/Q60kvE1DNpKP0jvRN5KVKfJ3NY8dIsAxw7KqWUBbq/P92cA?=
 =?us-ascii?Q?mP6P9doN59lwafo2LNa/9l6cSiMubz4qxXwQ2QkhxADD/n63baEyoHSbSuz2?=
 =?us-ascii?Q?fxLRClKzIj59OA5rDCWmSXjfHMnx9zQLohu4P3lrj1t25Guut5903lW87DTK?=
 =?us-ascii?Q?J9CJcIHHbTjSyOtZ587Vb6MRpSKvh4/UyWMRRr9JF7EUEr0ARot1f9FoVNO5?=
 =?us-ascii?Q?ov7eQe0Ad8FVULo5nRi9czSAGh2idoBYg13BGw+YTkKHHGOy+wf4rEvyf03Y?=
 =?us-ascii?Q?OO9e+VVvBbCuIEla77U4ew5BOQQBeDXxJSPfeTi5DDPxULk/2CVSPAGBUX2l?=
 =?us-ascii?Q?rCtbERHpHoDix6vbt++RA5eAtYpopbB2ql5871pc4HyGQV42EN7eNKFmvear?=
 =?us-ascii?Q?00p0wzKr8nCzbfrzSPRyg7vQPPiPB/jWh75AOdruIBB5bkgQr8I/Odq8q1Lc?=
 =?us-ascii?Q?czIC3OpS3ZUIpi+N0jL2hLEiYJFD6/24sFErBUN80t4adQafEXPTgUHTDX0x?=
 =?us-ascii?Q?ON6/OekTyV3cUVUBETQyoE5rxb+qNnW8ctnIlg5uuLSOxUwYc0HFqEYngt0t?=
 =?us-ascii?Q?IzUxj605DVJtfgWzEcDDlcEerTpSLcJ7ExFT/VnccZ4KE5ZaFSkGdTlW3we0?=
 =?us-ascii?Q?B9xWT77Zjh/0XAVbIBWHxm4dLe8cmqdDVoq8cy87O4zxOGrepOlLR36jLblh?=
 =?us-ascii?Q?JA4aIGxkxc/IyO2YhQ14MA//jVlSMD569eN6i8cnpaWNMcfG7Jcm4jml5bCC?=
 =?us-ascii?Q?B8Qc5vqezI9UuQ3EfzraX06gfQLLjbb3yNaI2Kdrk+8GxBibpeMd+ftZspqV?=
 =?us-ascii?Q?eIh5ADbw8YT+reGFUZcYLb9Y5ZJd1CNU0gAotyaA4Vqc2pKT7+24oHhJZ68?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a611b7bc-8c55-4477-60d1-08dcedabd831
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:29:10.3709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0318
Received-SPF: pass client-ip=2a01:111:f403:2819::806;
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

> Cope with the old version that is provided in Debian 12 and Ubuntu 22.04.
> --size_t-is-usize is needed on bindgen <0.61.0 (Debian 12, Ubuntu 22.04),
> and it was removed in bindgen 0.65.0, so check for it in meson.build.

The bindgen 0.59.1 installed from Ubuntu 22.04 apt source does not
support the following args:

    '--formatter', 'rustfmt',
    '--merge-extern-blocks',
    '--allowlist-file', meson.project_source_root() + '/include/.*',
    '--allowlist-file', meson.project_source_root() + '/.*',
    '--allowlist-file', meson.project_build_root() + '/.*'

The first two args are cosmetic and should not hurt if removed (but I
need to double check).

Removing the allowlist-file, however, causes IPPORT_RESERVED to be
generated twice using different types and thus break the
build. Allowlists for bindgen 0.59.1 can only be specified as regex on
function, type or var. I don't find (yet) an equivalent way of
--allowlist-file. A dirty trick is `--blocklist-item IPPORT_RESERVED`,
which works but is so ad-hoc.

--
Best Regards
Junjie Mao


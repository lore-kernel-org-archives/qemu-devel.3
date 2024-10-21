Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66B4D0E6D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pKo-0004ds-VE; Mon, 21 Oct 2024 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pKn-0004dc-16
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:08:21 -0400
Received: from mail-sy4aus01olkn20817.outbound.protection.outlook.com
 ([2a01:111:f403:2819::817]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pKl-00072W-DD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNDwH3s3wzm8uB83aFssz5ARaQId1px9Wv6VkgcYCa/g0dXIroiyL2vBVyl/0AL277bVWAB6h0iawuWOMsK8EuEqd+WcgqRI/VYDRzSZYc7m/hr+YjmnV/yhiN1nUUeUMqo8H/5rRDbTv7NLlg/Ai/BirZ3s+NRgEticaaXN7lz9rOPecQFoUhX2yKdGZ9tOg8/FNKiv4xpbKpV59qjSs03XSfXdqztwbVFf/Co73qCBcAkwmzNXNWQVGh/rGbUDaykn4ROjncT/rzBi1JPvhI90oIou5VjVCnMYTBaMQX8vyCt/y/boedpLWTVq1HMXqAYQbbnYsR1nytRKDHB8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBvlHKm/uYJM4K281Iyugtfdw+E8MTJ6prSpd0jBcGI=;
 b=X50TSz+m27STpOCu8jh7GrkZqq89qmDGX9fdPvg9r9lIDyknOsHAmzGaSAxWIy/WjaoSVFiMDYX5mos/tIL7lqXvalhH/LFPj5bEbDai/xSTJ9e16K4Ov6N04rof2vChvx2zFCzIRhwlsqAGFEqfKp/kU8Ou17QB1ILA2gc03blPzPHb4TMPCjQqUAgHb4TyI7K0wjkoOnwsp+lpfQStanlDUb2xovrk1YXUFAzV042Oo4Xjn8DatrSkLtpAtmI/UuGvbw0gIekKROpVWriDoLgz3lSwCaYkl+Gonxh0h1lxCZ+TeBHR4CqG6mhUFT3KxW9nxNjS4Mv1xOP58M3heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBvlHKm/uYJM4K281Iyugtfdw+E8MTJ6prSpd0jBcGI=;
 b=WtwgN9Dryt+5X42xhUm4RABomU6k6+OdqfYjz71WZGpGssP3rVitE34ZRx63R1ZjBpa1LAxE4RHmUNAu2jhJBmoYQ1zg7TYO5+C6b+au3/4GMhE/g1/28dc1keZt5FH2+qTwQoZTpOe7WZX5scd3p4OkkfPmRfjaQ9GtQ7knje+E4Tlcy62mU1LlCddkfe41qDK42QGuQkrrKjWqQgijmBeGm14+HUZmTnhos8xwEU3V6HmMcEvZCCCgmvdMwTuMonyOeL1G8J8FTTsRCFXSkB7LoFnjW5eKsZqdtsTCYXYFcUWx72KglIKhFAQ0NOxEbZT+kER62efnCVYNQUgCwg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0693.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:08:12 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:08:12 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-6-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 05/13] rust: remove uses of #[no_mangle]
Date: Mon, 21 Oct 2024 18:07:21 +0800
In-reply-to: <20241018144306.954716-6-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026F135EC012952069BBC4795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <877ca1u5tp.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0693:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d86444b-091d-4caa-6f1e-08dcf1b8457e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|8060799006|19110799003|15080799006|461199028|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: KQae0Yfmk7D3IBnJ32xEYyzQqOQAKv3DNnox3N1kP0SrXc3sw69yGzDvrxIvJcX3Ms+jOjZNNDyGX5ulG2SRN8RlBL18NurM90ikiks5nea/1/r4WTkiyEbykVpoz5QpDPXedJjR1K/akj06bwBs62mqqEQ66toKK6s7lgo4QI1QQzYrmfwu6jnMHXPqyCAhgQn/kcuUko93lKmORCemQQew/onh8vhgQKrlXQmE/SRyZlTE7qdgXy9toxglSAaIkfoNDCeEbI6Hi2EB78kyjZPSfxincFOGhIto3o7u2xlDufuP+yM6s5oHFH2dwI50hCBBUvW3+AdVsTkjWGx6ewSe70AbCCBehulVme3nukI2CHrOZnZFO7O/YO5xm4IvWH/dvuIwCtioEyzthGPUR9SiVK3D8rqjfTuKiTDHzQrybwAMjeKHpUYrJptKuDR01sL110lr1GoT21rEbgJTi40GDxco3kSSvlkluHrmXmEfHRQdjJr6fnmz5p/taWklHhO3xFJH/nDwkZ6/2TMZOSjuFutjLvc4ZqePs5A+pp37xxOpnIE39aO/G7dtmTSuBwMoFdtj2lVLsc7oKTctYkeXQvJlk6f2UQFQ/Wm/IdxQPHk3P0NDp4pcDTIIT1vgApZ3lPrzCRWh6TWEnzlaXQAOdClhujgAoMy1xiTAyHTUwF7fK6KJYLVu38ZKLPEbOrP9vVfkL6gtIStZ0eVkyCFVTVtxzpi4jBOk1/3blVQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jC2UloVvwbnKPwZUqjrq5a8LzheaegybNg4sdGoDL+H+WjCw4HMlNU8CvBcc?=
 =?us-ascii?Q?csWDEneM3Bo+C0ATFxD4HQINQuAa11rAgXNCTa21fvsIvd4tMG1/i7uPxLsi?=
 =?us-ascii?Q?YqZ1EPShRxPKElGR8bDR5vDYsV3095dq/oojqqRbtboWqmTlguoy7HDIdBXV?=
 =?us-ascii?Q?YT8E1j2adRQOJjoYtUEdTZDiGygfW7sNNoe8LNT8df8+6Dq8OJvUXylrJ4Nh?=
 =?us-ascii?Q?XbmlB2Nfs1DtZA7hAmYVa6tI8vzOZ/Flh9BAYTwx9eOS/ZlIK/s1epiEZcYz?=
 =?us-ascii?Q?xdxuG+IlojBknS8oUaS+6q+5IXfueuQBBFNRChShVaZeM73bu52GPXw7d69/?=
 =?us-ascii?Q?kSUN6KNXwIj8tJhVSRvKoFS053nM4Z8kYT8erqPofNm+nihU7zhG8fMjtNQK?=
 =?us-ascii?Q?qRgULoGo49MtXOFFJ0Vu5C20DAU7EnZl3drnbTPf1iv9iu6M2gs56aMpFEM9?=
 =?us-ascii?Q?7sFjq+dYy3CVVPFfje6aaoJiHyXRVSDKW7pmjDCOWHofgis3e5ElknBqmzeE?=
 =?us-ascii?Q?G3fnKosUzPU2F/8QfASWL4EI60BRAsQ5zsr+lovySLqil/6/iKloe+kcnsR4?=
 =?us-ascii?Q?UDn7ReccM6eYGhNfnk0hOLfv7XP1kfz7Tx0w1z9KioR8sT4YpfMYewGtNrFw?=
 =?us-ascii?Q?EuIdhQz4V49OwnbV0Tx0ymAV0DMA6Wcq1k5DwezOgP1qwJCrSP9Yco/hnw++?=
 =?us-ascii?Q?USdEdrWr65g4ixWplNeiGtmJmTWmSxXRhBCk8NtoTtipqiZ1D6AN9ulEGbC1?=
 =?us-ascii?Q?vJ0s7zY/1jzMt1XMXfNyw7JRi9zZ6jrMpwpe27XQsmRvoVc6SJ6UtlkidWOL?=
 =?us-ascii?Q?uvrouU/CSG15GTRZg+wTcy0+KGYS3p5pu8dAwzXFCJrjDE8SpFuninJ3OTK4?=
 =?us-ascii?Q?pXAubwi2uwsNDKfcBcAACX3QY16KJs9KQ2X7MzGgmm1OYTRFsTRL+Y9vYLmV?=
 =?us-ascii?Q?e1bUjMW9lM+/4VVhjwbDJtvBVMqCa9bxxxM32Mi/T1UDOibWFoIXCE3R6dY6?=
 =?us-ascii?Q?UEc7SW7/Y16xF9hZ+3sl+TH2FPPMr9rZfwNt8vDFM71waubRxZ3oqX8Q2DVu?=
 =?us-ascii?Q?eFM+TloFj6Ajw4UOGCqCWAB4NtJYG2AX+VEwJXDjE+U3ahV6mNXI5WhGBgMz?=
 =?us-ascii?Q?6Sk4l74thGnGIBj+L3AELopabAXE8WzIovnagP8ZksSCjdW/QNtzhlfUj/KZ?=
 =?us-ascii?Q?qN2L64xu5Uzx3faDc8rCnGc2micVhBtLar8iBAUks6MJWpBsyTPOxeVvP00?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d86444b-091d-4caa-6f1e-08dcf1b8457e
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:08:12.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0693
Received-SPF: pass client-ip=2a01:111:f403:2819::817;
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

> Mangled symbols do not cause any issue; disabling mangling is only useful if
> C headers reference the Rust function, which is not the case here.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao


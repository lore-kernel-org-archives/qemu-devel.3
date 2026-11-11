Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14042606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=RAH7n+Px
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR539-0007kr-Ey; Wed, 11 Nov 2026 04:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR536-0007jp-NE; Wed, 11 Nov 2026 04:55:24 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR534-00062q-0m; Wed, 11 Nov 2026 04:55:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyxRFJOKUg6N6eJybh+9unalbXwtt+KfmkGgEvA8YlOkI27VuZWdVtNxda2fMLoR7D9MqHcZZFi+mZfA7FSqDcntMEAHmJEOkg6M4TsvfTgageJ/wHqH7cce/TJx74Iz7YNGxwpQK+Z+k8mYUdDoedCcHfTBS87l3vV4TjpxAEjyVVgLKXoy0irsAosR22wIc5OIuK10+oZ5uHSEY+BQOQ6ajTa6TsvPVN4xv2zFKyn7z5+i1waYUn0v9+GtH5l3aMU52eGI4HAS7q337uTxT+Blblu6u2LtlnPwn6/mCnyJpt5CFHoH6n8qNkJBaKoj7jwkcM38x/yEc2O/0kCNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+y20pIwbPw3w7UDWW/1D1t84ulExrCGD432MElUDdE=;
 b=KjIHXzCgk6y3VM+KWAOnpOpSS36TYy6nlPuge9rH42a4cc5W3dwwNSW6goLrTCdY8JCqKi/0iw8LNJZJq1aYM+nzOO31ZJOV+K+7mmKoFLipV9bySl0MX1J2jadjWCVDBmlRUk8WF+urouyNCgBBgLnbl2SHw0XRZnraZqPfDbEJty1tMZ3o8wGv/HyfO9jb06dWGW4eFIB0GpO2S3WQ9Ul7atQ68SaeKNkyuLcIxI+HnERSphX4wyPHJdl+FOWs3yhiE0GxH9S/NXZxXO6sarlj8xrry3g8yYbI/svzOPLtaa5CUTVmhtucJLR+WoU0kmTI3JBGpuq/EE3TM51KCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+y20pIwbPw3w7UDWW/1D1t84ulExrCGD432MElUDdE=;
 b=RAH7n+PxJotWWW4hfc9YuHImRmYhZKG8zQBXzN9+Brh1cvyKyovznaobqEt32zk7HWTwu5qTfN8bzvKsxDnssa38031eIOuH0v30/Jh1aGk3QLEegUbsS4V7Ru3bF0XuYnSRtScRdEIzHXl2FQ6wPAktjgie3yOARQG4u9fjJxx3xZ7PRMaOY0rS6lVh4w6Vhfkoqbxg2lq3f+LN6lRTKUvNAN7+lJ6aGuPQIpqafXBOOTOPpqrnud7FQc9IDZA50Hv1c2dfYuGjWfaE8ZSkb7Q+kfi8tZ6xDEFdnYXvdXiiEDXphfZILO6X7VfoOjmAZrAJV5AUw3n7LNdL62umzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE2PPF56423118C.apcprd02.prod.outlook.com (2603:1096:108:1::811)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:55:13 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:55:11 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC PATCH 38/38] tests/tcg/riscv64: Add test for Zvdota/Zvbdota
 extensions
Date: Wed, 11 Nov 2026 17:54:52 +0800
Message-ID: <20261111095454.89907-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-39-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE2PPF56423118C:EE_
X-MS-Office365-Filtering-Correlation-Id: 2343f921-5293-4774-6b76-08df3fd9e06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261102124527099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mUehjZPlEgiltKFpWRPENlLso+zoCGw4cSXDzvH0zFepjk2hVoOTUXaVUpwbZ5JRhY5XWS3uZVF/6+XDzfvweFYPB4Arg1wroXZbGB1zR8UA+WFtZVLvYSi4fHmjRVl7WjADQwE4L3fBb9iBXOWOVC4P0IX0OEzDcvNY0FtQ8rsBHFigxN/x8MefTBRRFGW2u9MSRodVI4tH2xqP1eclNdrGbDhPDxIBagMGLz/qmczIqIVnnLney4VR7K/6QbEHsBeoF2JFZLoK9EXjDiS7doQN7wboBL5zL6Z8KAglvBZ1nXL4BKmE/BJBTB3uBA0lKo+PRXokGoAJkNlOvwg+ogHtHei3+65wBg1Y+euy3InuhSWy03pqp7PSTNcxjo6Jy/pT7y9ciz32yS/Ed7SkX6KpGRFUq882Neto2PNaLJpgYWb/hFy9X660USf8Xz30wQfLCl5sfXXQ4/CgBPm5eM7L2KBWdLSHUvIzPRkppBuBW3foo44SaExIoC3uzzqVRMGYJWFGoZoARhPmMxrmM7HPHZmDNn3PI+H/b7dDqiMhWO4ausGcFtgg/DBzW8fBPRBB5lQEc7HOBQXyvsPjfy6y5qeaOu5lORoitqO/69X58ZY1rb7fXGVu0VgrI7dh0xskdb9az4Suy57cvVUjpn/KFeEqQgYlUsDgrUhaHII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261102124527099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQcU4i9lMtE7qT3PqdGn/gyWjDJZssn3FnhnHxHUGI2GXA0Woc0WDvXDrwUf?=
 =?us-ascii?Q?ZKBc/2RV/jIJV4Cvs/GDkkuKi262inpg1G5vZWmMzzQrwVk1ZA1kj9pLiOZN?=
 =?us-ascii?Q?m4oQo3AudmMJf1VcqmtTwR5FoPaD6eQsvrfk9C44ZejV9f9+N2+UB1aaBlL3?=
 =?us-ascii?Q?Q50Cy//f10lVm7BNwZJgQpyI4FGZ+iIPfjMOc+ajCP79q80gmzT0X95qdAf0?=
 =?us-ascii?Q?GBdiMI19YrAnmajdj5qaMjCqI6Wy3PUTywqcCzFJ9sgWTXh9GgVnXuXkDt96?=
 =?us-ascii?Q?LD5EV6SWTn8AHGH9HL5O8Ai/bTHiFnfhtIlQxV5kV++R1uiy3XWSvf3RTIjm?=
 =?us-ascii?Q?EpJNR1ElLwHT7EKQO3hwJUwdYtVpNu4IC6cPOLaJl+riLssJAPvAVpWfETFP?=
 =?us-ascii?Q?7oCwIyCq/UL6t0fR2xfLY91UfKSdoiqWOonrY3bt4izzNp8Y/uS2/RtlTF1S?=
 =?us-ascii?Q?KvoEGDm432v1wD05rO1aDVKSe4yytsu8ODqroIMD6jOQ5VGa1XUmFYMPCCPm?=
 =?us-ascii?Q?54dhfYL7jhazxoiCVgAfymLHCZXmN0UgPuIhgXmYYROXzT9U2CdLho0dTpqa?=
 =?us-ascii?Q?eHmS9TolZ/EBHUGLrfp6HZkNsl5rqLae6ra9Qh5u9ch4LIDVbSE9xkSpOL7E?=
 =?us-ascii?Q?dTEJsID8ohotw7oNBG39p6v6qGwN595i/1D7LlKKf7ME7bBpAZVrvk4kj/w4?=
 =?us-ascii?Q?SPHsRgBtG0J5mWjMpxvFFrvB9BDTAlW6GnOCTcvQ7wE7pfeI1niaZLew/+ve?=
 =?us-ascii?Q?tTqrxDQyRarRiUoAFE0d78AGZ2l+qzkDvKKzUpk3u7mfuA2PNrTzfjh8XO4Q?=
 =?us-ascii?Q?qWP1Vy/L0fqWMpsm/YFcqLHQKAP6Y75FhIPi/mTiTrhTObqKqoVRrnZ6lSJw?=
 =?us-ascii?Q?o4g2OUgMzll12GABACZUb+GLTNfyMnJH/P/Z12jVIQEPb+zgO94myZWNrRUK?=
 =?us-ascii?Q?pGzo1l2NLaDNanfyGnqKznaw3/c/fkszsZnQppqM1MEjG6eW6Pdb555wlo5g?=
 =?us-ascii?Q?1A1SICVTOEHk7TfsZFam027Njpdw5eePk954Z7a5ErxsQquynu+M9h0hUbRe?=
 =?us-ascii?Q?0Fu6l1n/4iY/i/9fyQ7tg7aKkN9XU7rH7nUuSW0JgjUa0MLbXEtXAtgwnizH?=
 =?us-ascii?Q?GR11HnmLUJ9IRUMyjFYyCeXSWBkT+jqsts/j6IQ5diS6z8vNyktVDr3cvHxX?=
 =?us-ascii?Q?2T3O1BzyyfWAhYXaAZYj4oy8uxKgv727sW3m2G2NrWAGrEuSU7yXq9Gk4d7C?=
 =?us-ascii?Q?R4RoP9wm/iDvBLJBEpjikZsBOZYS/BAdvC3HZ3ZsM/+hqAfh05RGBTZPV6lc?=
 =?us-ascii?Q?12e7pUsjw9vIuha7/W+E89OS0Boh8Dnx+/fktqEsLbiXca8pfoJnr1XBKbMP?=
 =?us-ascii?Q?D6HpXQcdJLCU4Bp6zE9K+SCEbD5JzWWhEf+8l3pttl7PuQgFhOLmXLCxmtKx?=
 =?us-ascii?Q?jlvma2nmHTvrDeeLCkEINfo1KqdV65qcQhBh9Ho7xi5RIbsvXyenlBr/crWV?=
 =?us-ascii?Q?rHkEQCkn4QZBIHYnkH+leZTj7t2MAHKAn9yWTPK3H8823sI7DxY8gLuFrCe2?=
 =?us-ascii?Q?UZY4rqxigCUAtboi5oRQIYu+WGEQ9hPNfaer+5+u+1R3pMNB5ng26hoGAZKP?=
 =?us-ascii?Q?YCYmiPK2YoJyVsBy6fff9l7bInY7uJby49CpIdUVu7YxN4RG8BvvHkuESp38?=
 =?us-ascii?Q?tmLkOxdTonvgS0Bkuc5Cy+ZqAq6EwuJBvyUSpPYDLF5dpq0394r5NSkBqnL5?=
 =?us-ascii?Q?Q5tsQGUv5pl73gtBG9OmGnC/OEZBGXU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2343f921-5293-4774-6b76-08df3fd9e06d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:55:11.7709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGGo+Dm6ZxKqErC+JoLmCK4c8U2MwUouLL1TeuQyLQS3tW52qJh8PqG8ua4t23A5q+I/HOb8po7qacVWECi4q/ncCP0o2SZdbJy8onbDvcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF56423118C
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:53 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add a test that exercises the RISC-V Zvdota/Zvbdota instructions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  tests/tcg/riscv64/system/meson.build |  12 +
>  tests/tcg/riscv64/test-zvdota.S      | 343 +++++++++++++++++++++++++++
>  2 files changed, 355 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-zvdota.S
> 
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 3c8b018d9e9..01370badb0d 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -89,6 +89,18 @@ tests += {
>    }
>  }
>  
> +dot_cpu = ('rv64,v=true,vlen=512' +
> +           ',x-zvqwdota8i=true,x-zvqwdota16i=true' +
> +           ',x-zvqwbdota8i=true,x-zvqwbdota16i=true' +
> +           ',x-zvfwdota16bf=true,x-zvfwbdota16bf=true' +
> +           ',x-zvfqwdota8f=true,x-zvfqwbdota8f=true,x-zvfbdota32f=true')
> +tests += {
> +  'test-zvdota.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', dot_cpu, qemu_args],
> +  }
> +}
> +
>  if 'qemu-system-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-softmmu': {
> diff --git a/tests/tcg/riscv64/test-zvdota.S b/tests/tcg/riscv64/test-zvdota.S
> new file mode 100644
> index 00000000000..eefb615088f
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-zvdota.S
> @@ -0,0 +1,343 @@
> +/*
> + * Test the Zvdota/Zvbdota extensions
> + *
> + * Each dot has four input pairs. Integer inputs distinguish all four
> + * signedness combinations; the -7 accumulator also exercises wraparound.
> + * Floating inputs represent A = [1, -2, 0.5, 4] and column n of B =
> + * [n + 1, -2, 3, 0.5]. With accumulator 1.5, C[n] = n + 10 exactly.
> + * Separate BF16 cases check round-to-odd in the final accumulator addition.
> + *
> + * Poisoned source tails must not contribute. Destination prestart/tail
> + * elements and masked-off batched outputs must remain undisturbed (tu/mu).
> + * The test requires VLEN 512, which also exercises ci = 8.
> + *
> + * Exit status is zero on success or the numbered check on failure, including
> + * unexpected traps.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option arch, +v
> +	.option norvc
> +	.option norelax
> +
> +/* ci is an element index; its encoding is the index divided by eight. */
> +#define DOT(f6, f3, vm, ci) \
> +    (((f6) << 26) | ((vm) << 25) | ((8 | ((ci) / 8)) << 20) | \
> +     (1 << 15) | ((f3) << 12) | (16 << 7) | 0x77)
> +
> +	.text
> +
> +/* Load four elements per source, leaving all remaining elements poisoned. */
> +.macro LOAD_INPUT sew, a, b
> +	vsetvli t0, zero, e\sew, m1, tu, mu
> +	vmv.v.i v1, -1
> +	.irp reg, 8, 9, 10, 11, 12, 13, 14, 15
> +	vmv.v.i v\reg, -1
> +	.endr
> +	li	t0, 4
> +	vsetvli t0, t0, e\sew, m1, tu, mu
> +	la	t1, \a
> +	vle\sew\().v v1, (t1)
> +	la	t1, \b
> +	.irp reg, 8, 9, 10, 11, 12, 13, 14, 15
> +	vle\sew\().v v\reg, (t1)
> +	addi	t1, t1, \sew / 2
> +	.endr
> +.endm
> +
> +/*
> + * Initialize an m4 destination at its output width, execute with the input
> + * vtype, and compare the whole m4 group (including untouched registers).
> + * v0 contains repeating 0xaa55: scalar dots mask inputs, batched dots outputs.
> + * Nonzero-ci cases give prestart elements a different accumulator seed.
> + */
> +.macro RUN id, f6, f3, type, eew, exp, batch=0, vm=1, vl=4, ci=0
> +	li	t6, \id
> +	vsetvli s0, zero, e\eew, m4, tu, mu
> +	.if \f3
> +	li	s1, 0x3fc00000	/* FP32 accumulator = 1.5. */
> +	.else
> +	li	s1, -7
> +	.endif
> +	vmv.v.x v16, s1
> +	.if \ci
> +	li	t0, \ci
> +	vsetvli t0, t0, e\eew, m4, tu, mu
> +	addi	t0, s1, 1
> +	vmv.v.x v16, t0
> +	.endif
> +	li	t1, \vl
> +	li	t2, \type
> +	vsetvl	t0, t1, t2
> +	bne	t0, t1, fail
> +	.word	DOT(\f6, \f3, \vm, \ci)
> +	csrr	t0, vstart
> +	bnez	t0, fail
> +	csrr	t0, fflags
> +	bnez	t0, fail
> +	vsetvli t0, zero, e\eew, m4, tu, mu
> +	la	a0, result
> +	vse\eew\().v v16, (a0)
> +	la	a1, \exp
> +	mv	a2, s0
> +	li	a3, \ci
> +	.if \vl == 0
> +	li	a4, 0
> +	.elseif \batch
> +	li	a4, 8
> +	.else
> +	li	a4, 1
> +	.endif
> +	li	a5, \eew / 8
> +	mv	a6, s1
> +	.if \batch && !\vm
> +	li	a7, (0xaa55 >> \ci) & 0xff
> +	.else
> +	li	a7, 0xff
> +	.endif
> +	call	check_result
> +.endm
> +
> +/* The trap handler verifies the cause, faulting PC and instruction bits. */
> +.macro ILLEGAL id, f6, f3, type, start=0
> +	li	t6, \id
> +	li	t1, 4
> +	li	t2, \type
> +	vsetvl	t0, t1, t2
> +	li	t0, \start
> +	csrw	vstart, t0
> +	la	s2, 1f
> +	li	s3, DOT(\f6, \f3, 1, 0)
> +1:	.word	DOT(\f6, \f3, 1, 0)
> +	bnez	s2, fail	/* Must have taken the expected trap. */
> +.endm
> +
> +	.global _start
> +_start:
> +	li	t6, 44		/* Setup failure. */
> +	li	s2, 0		/* No trap expected outside ILLEGAL. */
> +	la	t0, trap_handler
> +	csrw	mtvec, t0
> +	li	t0, (1 << 9) | (1 << 13)
> +	csrs	mstatus, t0
> +	csrw	fcsr, zero
> +	csrr	t0, vlenb
> +	li	t1, 64		/* VLEN 512 only. */
> +	bne	t0, t1, fail
> +	vsetvli t0, zero, e16, m1, tu, mu
> +	li	t0, 0xaa55
> +	vmv.v.x v0, t0
> +
> +	/* Integer scalar dots: vs2 signedness in opcode, vs1 in altfmt. */
> +	LOAD_INPUT 8, a_i8, b_i8
> +	RUN	1, 0x26, 0, 0x000, 32, exp_i8_uu
> +	RUN	2, 0x27, 0, 0x000, 32, exp_i8_us
> +	RUN	3, 0x26, 0, 0x100, 32, exp_i8_su
> +	RUN	4, 0x27, 0, 0x100, 32, exp_i8_ss
> +	RUN	5, 0x26, 0, 0x000, 32, exp_i8_mask, vm=0
> +	RUN	6, 0x26, 0, 0x000, 32, exp_i8_uu, vl=0
> +	LOAD_INPUT 16, a_i16, b_i16
> +	RUN	7, 0x26, 0, 0x008, 64, exp_i16_uu
> +	RUN	8, 0x27, 0, 0x008, 64, exp_i16_us
> +	RUN	9, 0x26, 0, 0x108, 64, exp_i16_su
> +	RUN	10, 0x27, 0, 0x108, 64, exp_i16_ss
> +
> +	/* Batched dots use all eight columns, even though vl is only four. */
> +	LOAD_INPUT 8, a_i8, b_i8
> +	RUN	11, 0x2e, 0, 0x000, 32, exp_i8_uu, batch=1
> +	RUN	12, 0x2f, 0, 0x000, 32, exp_i8_us, batch=1
> +	RUN	13, 0x2e, 0, 0x100, 32, exp_i8_su, batch=1
> +	RUN	14, 0x2f, 0, 0x100, 32, exp_i8_ss, batch=1
> +	RUN	15, 0x2e, 0, 0x000, 32, exp_i8_uu, batch=1, vm=0
> +	RUN	16, 0x2e, 0, 0x000, 32, exp_i8_uu, batch=1, vl=0
> +	LOAD_INPUT 16, a_i16, b_i16
> +	RUN	17, 0x2e, 0, 0x008, 64, exp_i16_uu, batch=1
> +	RUN	18, 0x2f, 0, 0x008, 64, exp_i16_us, batch=1
> +	RUN	19, 0x2e, 0, 0x108, 64, exp_i16_su, batch=1
> +	RUN	20, 0x2f, 0, 0x108, 64, exp_i16_ss, batch=1
> +
> +	/* BF16 requires SEW=16, altfmt=1. */
> +	LOAD_INPUT 16, a_bf16, b_bf16
> +	RUN	21, 0x24, 1, 0x108, 32, exp_fp
> +	RUN	22, 0x24, 1, 0x108, 32, exp_fp_mask, vm=0
> +	RUN	23, 0x2c, 1, 0x108, 32, exp_fp, batch=1
> +	RUN	24, 0x2c, 1, 0x108, 32, exp_fp, batch=1, vm=0
> +
> +	/* OFP8: ordinary/alt opcode selects vs2, altfmt selects vs1. */
> +	LOAD_INPUT 8, a_e4m3, b_e4m3
> +	RUN	25, 0x26, 1, 0x000, 32, exp_fp
> +	RUN	29, 0x26, 1, 0x000, 32, exp_fp_mask, vm=0
> +	RUN	30, 0x2e, 1, 0x000, 32, exp_fp, batch=1
> +	RUN	34, 0x2e, 1, 0x000, 32, exp_fp, batch=1, vm=0
> +	LOAD_INPUT 8, a_e4m3, b_e5m2
> +	RUN	26, 0x27, 1, 0x000, 32, exp_fp
> +	RUN	31, 0x2f, 1, 0x000, 32, exp_fp, batch=1
> +	LOAD_INPUT 8, a_e5m2, b_e4m3
> +	RUN	27, 0x26, 1, 0x100, 32, exp_fp
> +	RUN	32, 0x2e, 1, 0x100, 32, exp_fp, batch=1
> +	LOAD_INPUT 8, a_e5m2, b_e5m2
> +	RUN	28, 0x27, 1, 0x100, 32, exp_fp
> +	RUN	33, 0x2f, 1, 0x100, 32, exp_fp, batch=1
> +
> +	LOAD_INPUT 32, a_fp32, b_fp32
> +	RUN	35, 0x2b, 1, 0x010, 32, exp_fp, batch=1
> +	RUN	36, 0x2b, 1, 0x010, 32, exp_fp, batch=1, vm=0
> +
> +	/* 1.5 + 2^-24 rounds to odd (0x3fc00001), without setting NX. */
> +	LOAD_INPUT 16, a_tiny, b_tiny
> +	RUN	37, 0x24, 1, 0x108, 32, exp_odd
> +	RUN	38, 0x2c, 1, 0x108, 32, exp_odd, batch=1
> +
> +	LOAD_INPUT 8, a_i8, b_i8
> +	RUN	39, 0x2e, 0, 0x000, 32, exp_i8_uu, batch=1, ci=8
> +	RUN	40, 0x2e, 0, 0x000, 32, exp_i8_uu, batch=1, vm=0, ci=8
> +	ILLEGAL 41, 0x26, 0, 0x000, start=1	/* Nonzero vstart. */
> +	ILLEGAL 42, 0x2e, 0, 0x001		/* Batched LMUL=2. */
> +	ILLEGAL 43, 0x24, 1, 0x008		/* BF16 altfmt=0. */
> +	li	a0, 0
> +	j	_exit
> +
> +	.balign 4
> +trap_handler:
> +	beqz	s2, fail
> +	csrr	t0, mcause
> +	li	t1, 2		/* Illegal instruction. */
> +	bne	t0, t1, fail
> +	csrr	t0, mtval
> +	bne	t0, s3, fail
> +	csrr	t0, mepc
> +	bne	t0, s2, fail
> +	addi	t0, t0, 4
> +	csrw	mepc, t0
> +	csrw	vstart, zero
> +	li	s2, 0
> +	mret
> +
> +/*
> + * a0=result, a1=expected body, a2=total elements, a3=first body element,
> + * a4=body count, a5=element bytes, a6=seed, a7=active body mask.
> + * Prestart elements use seed + 1; masked-off body and tail elements use seed.
> + */
> +check_result:
> +	li	t0, 0
> +1:	mv	t3, a6
> +	bltu	t0, a3, 6f
> +	sub	t1, t0, a3
> +	bgeu	t1, a4, 3f
> +	srl	t2, a7, t1
> +	andi	t2, t2, 1
> +	beqz	t2, 3f
> +	mul	t2, t1, a5
> +	add	t2, a1, t2
> +	li	t3, 8
> +	beq	a5, t3, 2f
> +	lw	t3, 0(t2)
> +	j	3f
> +2:	ld	t3, 0(t2)
> +3:	li	t2, 8
> +	beq	a5, t2, 4f
> +	lw	t2, 0(a0)
> +	j	5f
> +4:	ld	t2, 0(a0)
> +5:	bne	t2, t3, fail
> +	add	a0, a0, a5
> +	addi	t0, t0, 1
> +	bltu	t0, a2, 1b
> +	ret
> +6:	addi	t3, a6, 1
> +	j	3b
> +
> +fail:
> +	mv	a0, t6
> +_exit:
> +	la	a1, semiargs
> +	li	t0, 0x20026
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20
> +	.balign 16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign 8
> +semiargs:
> +	.space 16
> +result:
> +	.space 256	/* m4 at VLEN 512. */
> +
> +a_i8:
> +	.byte 0xfe, 0x82, 2, 3
> +b_i8:
> +	.irp n, 0, 1, 2, 3, 4, 5, 6, 7
> +	.byte 0xff - \n, 0x80 + \n, 3, 7
> +	.endr
> +	.balign 2
> +a_i16:
> +	.half 0xfffe, 0x8002, 2, 3
> +b_i16:
> +	.irp n, 0, 1, 2, 3, 4, 5, 6, 7
> +	.half 0xffff - \n, 0x8000 + \n, 3, 7
> +	.endr
> +
> +a_bf16:
> +	.half 0x3f80, 0xc000, 0x3f00, 0x4080
> +b_bf16:
> +	.irp bits,0x3f80,0x4000,0x4040,0x4080,0x40a0,0x40c0,0x40e0,0x4100
> +	.half \bits, 0xc000, 0x4040, 0x3f00
> +	.endr
> +a_e4m3:
> +	.byte 0x38, 0xc0, 0x30, 0x48
> +b_e4m3:
> +	.irp bits, 0x38, 0x40, 0x44, 0x48, 0x4a, 0x4c, 0x4e, 0x50
> +	.byte \bits, 0xc0, 0x44, 0x30
> +	.endr
> +a_e5m2:
> +	.byte 0x3c, 0xc0, 0x38, 0x44
> +b_e5m2:
> +	.irp bits, 0x3c, 0x40, 0x42, 0x44, 0x45, 0x46, 0x47, 0x48
> +	.byte \bits, 0xc0, 0x42, 0x38
> +	.endr
> +	.balign 4
> +a_fp32:
> +	.float 1.0, -2.0, 0.5, 4.0
> +b_fp32:
> +	.irp n, 1, 2, 3, 4, 5, 6, 7, 8
> +	.float \n, -2.0, 3.0, 0.5
> +	.endr
> +a_tiny:
> +	.half 0x3f80, 0, 0, 0
> +b_tiny:
> +	.rept 8
> +	.half 0x3380, 0, 0, 0
> +	.endr
> +
> +/* Suffixes describe vs1 then vs2; -7 + A dot B, modulo output width. */
> +.macro EXPECT_INT name, width, a0, a1, b0, b1
> +\name:
> +	.irp n, 0, 1, 2, 3, 4, 5, 6, 7
> +	.\width -7 + (\a0) * ((\b0) - \n) + (\a1) * ((\b1) + \n) + 2 * 3 + 3 * 7
> +	.endr
> +.endm
> +	.balign 8
> +	EXPECT_INT exp_i8_uu, word, 254, 130, 255, 128
> +	EXPECT_INT exp_i8_us, word, 254, 130, -1, -128
> +	EXPECT_INT exp_i8_su, word, -2, -126, 255, 128
> +	EXPECT_INT exp_i8_ss, word, -2, -126, -1, -128
> +	EXPECT_INT exp_i16_uu, dword, 65534, 32770, 65535, 32768
> +	EXPECT_INT exp_i16_us, dword, 65534, 32770, -1, -32768
> +	EXPECT_INT exp_i16_su, dword, -2, -32766, 65535, 32768
> +	EXPECT_INT exp_i16_ss, dword, -2, -32766, -1, -32768
> +exp_i8_mask:
> +	.word -7 + 254 * 255 + 2 * 3
> +exp_fp:
> +	.float 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0
> +exp_fp_mask:
> +	.float 4.0
> +exp_odd:
> +	.rept 8
> +	.word 0x3fc00001
> +	.endr
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


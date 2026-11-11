Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C20606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=GoRh35oy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1Gs-0006eg-7L; Wed, 11 Nov 2026 00:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR1Gq-0006eJ-Bo; Wed, 11 Nov 2026 00:53:20 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR1Go-0003TR-J1; Wed, 11 Nov 2026 00:53:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPBqxqOjzRItOys+60qnTlbltM6qwSVQiDUIkfOyTV3w2E29o6xWzCr5O+kZ6sgGCFTM/pcoVc6OTK2zXPPQNAbif9Pxx12p9QnPyrike9FZivM7VccN87nkLltXkPV83JIbYymQkn52JPhiUQvRWR+vX4EK6zYF0FGOAnSJrR8pnUtdTDsKxAns7FoEr+jqYLJq8MKmx2YkfhA92GgkDiNXL4i509uHwx1BIetRbtw+lI/sA6A0+xzG61ora96oJ5zoSaLGLlRGn7qPF7vN7Td6HNHORuJTxoalyVHsosFJl0uxbYWcsqoO7Ao9BEUO3QS19hLTv6mX8UNmGwj50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJwIByUYUTGhj+o4zDJV+H+aL7mwl81eUy37eHG1V4w=;
 b=YV4SNMonMP/P6HaeZ6Ie7iJ44QLoF2MDcy/tNm4s3EFZO1w6BfwUUBKyQxeiikYySmfOOoJBOEeRpOXk874X2nx5OR6Gm6h2ccWZlZrfX5/N1LMglKHikSvsCT+NS+blz2ceD+bKUkS2Hw13q3knWDAefj3ZUVQXxKmK1r7YfPXO00pK/4LvZsk7mxIghTJ1EcucKqvj161pXsOrXlGQsaZl5rw3C2PbSg9DoXS3IWa71nyiSkPa/Hrtzi5y2Zuzb6+DyJSws797tWArtsONPwNP42lMUM0j1AMfmA+iBIL3CK7PoBjNoQc8j5x4EM5WGngUIKulB9lDjwTOrjHz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJwIByUYUTGhj+o4zDJV+H+aL7mwl81eUy37eHG1V4w=;
 b=GoRh35oyPjfc+Q3lp0mtjaeUsCq2rR3eSf86NQuM3RXMm6qF7WkdDetrA2EpSjxd+wHpXcuGCz2GdYKG5OxHqEVSOMSlGJtB84rF8EdHGu1Y2a1bo0WWlzER/GI+Z6qQdP+d2G8ud+eRLYrZLlLkIV68HAJNk9RiOBTbPn1+bSP9RbN9oErN+paHkunO0hPOVFmJgGC557mQGeQ+g7/FvnIy5MBpOd/76u7b1lTeJ+Cp4s7IZ87Q9FmvM6j0UYe9vARYtb4qnfYpkhOE9Oft6AB8YZ7Yermoxu4nJPP76KkqBCKI49YRDauJFXoRLyuwKUcreBhKqamYWjnUb/AtFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB7237.apcprd02.prod.outlook.com (2603:1096:820:128::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:53:10 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 05:53:10 +0000
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
Subject: Re: [RFC PATCH 16/38] target/riscv: Add implied rules for Zvfqwdota8f
 extension
Date: Wed, 11 Nov 2026 13:52:50 +0800
Message-ID: <20261111055253.31405-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-17-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::35) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c560c8-114b-4f36-1e2c-08df3fb81106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261009223027099003|10067099003|261028144727099003|261102123227099003|261102124527099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mrc2+pmeSSq62mi9RlRfjuP/+vhuPL1szqQlr3JW1huygwtMEtlIbSD+WaaPbQ8HEO2dzdJzW/dEWyaXtX5oYaMv9AWoB/5jPTt0YN+ULCWSi8g92Ywk5lMXnG+vrXnJlpEPIF2hvtDEN3ScvzhpSEYTHygpq4Oy2C9iaqmYtQbW2RNNSEdTrACLwrs4Ej+CvQtC2ihZhOcPAS15N9rUD67thYXYbl+Qwcnh89WsLekfOraf277aenD0FOlom6Ec2FpVcg00b31PCpIp0wyKjxzK8Z8FiaxW+lVF0E29Ug+0mdL930k1j079n+wGW8QHyL2XJf1wO4GFQbjVvL7Ir+5OFSb6bllrddBiD4Sc2u942hSxJ7aIqwDnUEv8dNT1u4+xvxdaUGJigxfepOuUVjVvP6LGpfQsMx/6rxPW1p3yoTaL+UPGKb47Ld4IoHFW1BnUbStvtGcM8fZJfkzlbdT7rxaXLGCzvbLzUljwKOrruQ0mmcwKR/BUTieMMNxlT3gjya3B5nTtXsoVOZL5tXgCOnDv5Nb2NznbFbVJap4l5gKU2fIaiYoYI5an58C2hscaHe/h5v6OWBgWHSmb0bCrfvPqD7FICZ3UW0gFSKS1mM5TkJ7f15tdOQMClHctQJFSxoQ8xoVdPDe4jrX06Ebo54/ELBMeWuDXbKjjM6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261102124527099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcdNmA7vqtsHmWwZCQteCLgzHkC+5mwfeYAeV/d1rCjLWB4tTjnyXlZFx+Ee?=
 =?us-ascii?Q?FzNnXvevFbzl3CURJtTVjsI7tojiaKTe1XFWK0hQmOczYTEoMU+5gC3PufLG?=
 =?us-ascii?Q?gGJqYcSUcY4tU5GhFIgI6YRTwnqbfF9wpmwlHvXQM/L6iIQ+VSNwUZPeyIkh?=
 =?us-ascii?Q?zNlKcFDTME6vChJTwQNmwL27YY7OwTjBouaKXflnKFIjcf9XJYnCusAQbg5H?=
 =?us-ascii?Q?1bKCOp9NDyfEOer99rQK6BNM+yBcWlc8nKgR6x4dhbwrvvjxgOmFO7QrT0FI?=
 =?us-ascii?Q?WvNHFQrI3HjxhLOgw6xBUGF1kpYFK3MNyLfWMBM8uVU0SZy4eLrqeC312zeM?=
 =?us-ascii?Q?5ky3wWikiw3Jy8wYs+VG0JRSQWCg6vA8vG92+cXHX1n5M6s531JGTJuGCeqY?=
 =?us-ascii?Q?QsQMCdx2TWj5EX+hJoGquumtcrXb4GXTtsDzyl9pbi7x8CtWOTCPYcJVN90z?=
 =?us-ascii?Q?bAzqRZSBGEluHbiJymmnU2B0rXQuJnV0Qu/iNJbTKlpAYeP4BPTRbFprVE+z?=
 =?us-ascii?Q?9WKo5490rsVkUofoMcIUssVb2voZTBsg7y9FoHCDwktbXJh9+o0H/N0SOCTl?=
 =?us-ascii?Q?KUCEv5ujNmEQpCwp9UBSGsAJfjqg6uOTeQnuQ+oIsHTRtEEhP3UFfX598rZV?=
 =?us-ascii?Q?n+Rl7OfB3zZ7mHqCtCXUdiLxamy6FuCYoE/pmlcPZpiyhZBNTjk6y+YrmRvw?=
 =?us-ascii?Q?fvKA5dYcijmi0/bw7g7x31j9flw5j5taVe8iOVlX4K+ZZyhCkPPzR4LL0SN1?=
 =?us-ascii?Q?Bkfjmz9WqLQ8pTpXDA5GjcIyURQ2NMvRq/PVSH7HHMn7RoB3aGrVdsVkDAHr?=
 =?us-ascii?Q?LkJ2BaeZkVVm30eS2bzmknJregddsngAiu66ECnn/x+VYzBmql9wIVx29XPA?=
 =?us-ascii?Q?5ilDEJ+i6lE8/VpYJTDxk/++b7A89olg6TYctOHY05+EqR6OPs1rpMwprBAE?=
 =?us-ascii?Q?A7J7+8NIAaG4med8ELGL5yArdPB0WocsLtm7vupgyJzZWx069FU6B162iAdu?=
 =?us-ascii?Q?Oza7LwSWgAG8s2DIiEVnTHb/34EAUkWxm6qrQg+kJJ+ndsP8zCwYVq/Cy0YJ?=
 =?us-ascii?Q?4+/Eotq+Uqw8e/VoCr1yPxgPK8KjKwd6vSp208JV0HUFj4jkFmS5cyYCqDNI?=
 =?us-ascii?Q?IVIrsK4vSyKJUs7cxjX2rUmYTMoumqDZx9JPPwVAEl5CNH9mkyNtUUXi327M?=
 =?us-ascii?Q?uGouW1OrtEiw+m2Fi7HKJVDH5NWC2sgBwygBOn8Z1PMRfgHIYIvlOGQ9FdUR?=
 =?us-ascii?Q?8oE3aQBwLjB6BYRggkOTpDPAYbD+QyZ4/zZHceNsW8pZ/VhaGrqAd90zmcKO?=
 =?us-ascii?Q?MJTkMxVlNSzUZ7m5uEZeI/l+tH3coOMM9QenHziyPIDdnAXg1rS/ryjkuANH?=
 =?us-ascii?Q?WXwoVGsnreE6YSuxjD/R9pnv9HINMMknvEx9V8pZzUcw0V0nO02QdWoLsCSY?=
 =?us-ascii?Q?yHmMawxSpkzlGm+82KhOUD/7rlUd9K5/XtXPljMQdH5qKDpFyLur1bdne8Ve?=
 =?us-ascii?Q?KY+nREwa9C0/4G451+9MpaJ9GGCyNKe5C4UFo3fegSeqONiWa13ORRhanB1w?=
 =?us-ascii?Q?gdelh+5NxBv3Mf4rp7uX2m1jWmhNdSq6WD8/XfVEy6NSAqtMhM4LRBK5P8W4?=
 =?us-ascii?Q?QhI7Q7f6izklGXpfx6kMYf6r82wYaBcCrkcH5hzC3NU+IiNXmnze0lZMZnjH?=
 =?us-ascii?Q?Fn7D1bju93gn4e74BqvMaPCOusw+hN0Z+Xji1zBKlgw8gPi5USAvH+++g047?=
 =?us-ascii?Q?M/0UEBAItVwcxrfX7OH3maluhBrgZOM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c560c8-114b-4f36-1e2c-08df3fb81106
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 05:53:10.2966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFhSfaLAC/D6T0R0pJXlS9mSK2+98gd59Ey5Z8mPCO7FaLgVrplTUIPEnsslZYLBMci0eYU5zk2al+IHSs6VKVavSL9G6Mf4+AOtCmCe4zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7237
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu,  5 Nov 2026 03:41:31 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvfqwdota8f
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4f2e7a8faa9..6c09685bd4b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2875,6 +2875,15 @@ static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfqwdota8f),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
>      .implied_multi_exts = {
> @@ -3081,6 +3090,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED,
>      &ZVFHMIN_IMPLIED,
> +    &ZVFQWDOTA8F_IMPLIED,
>      &ZVFWDOTA16BF_IMPLIED,
>      &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


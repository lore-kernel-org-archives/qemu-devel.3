Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C160A2602
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=BRb7lFOT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpAR-0004sl-NF; Thu, 22 Oct 2026 05:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xJpAM-0004rm-PV; Thu, 22 Oct 2026 05:32:55 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xJpAK-0001Fr-5r; Thu, 22 Oct 2026 05:32:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEHkHbtM3MDw0yLM1Eq+hfbIfhwfZ5k3Fbg+xl5HGswmSAn8SLVxLrU/tiVDJ7z5ZHDYeA5cUpGL5NBR5788NkBZ9zoxYDxXmHS+A9DTbFk+xqq/w2IWZV8nKLWB8mM+X1dJPPJmmOZ43osARv1NO0m5gikhbVidYlb8dFd23IDRFfigi2gSu7eTpdLrXmG3gGvpLLrg5WnhV1xYUY0cTlSQKt9cF0e/QUSCnqk9kCBEJ3r1nxzK+xedC3iiybbM8orLroCB1R1HFRWn+CTZ+enXis3fa6FpKZoREIr4B2uI9yU6p+EvX1XdEWktNSmLHsDdgeHakJPfbpnax4BgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssMzrygU/mzixi0AqfdN4qsdf8eaCvvClbPAo2KPrbA=;
 b=pcgigvYUmczZitmBlnt00zhk1h2wgNiy1EEFdtGHS4otfzCPvjR0788Q7yWd/qa+bkNAkr/E4tzfKlOXLgi7htVWhb+VDWCbrTiHP4o87vjIFVL8nSpguAnUnOEI5jbUHaimsunmwJp4uCV03s6FZoO9rneFN44sVFxYFHsU+2GQLU+on5GGIGxkyvvN9lE1Y9i3ULCWr4gJhP+77rrRvpGeYDmOxplLFrWKiS9QNM90FjgIDyiX8bG5WJLbEuLRukGN1YZX40cEPwxOSle56Q0uIuX3SuL5dsHDv/NL/Ijc167WnxPgRpzUw0O1U7GyFwVNworJOtjwD+WTX/JiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssMzrygU/mzixi0AqfdN4qsdf8eaCvvClbPAo2KPrbA=;
 b=BRb7lFOTQ7fsGqFlrpwO5fjyzulPJj333zQudh9JD55SSX67+tbPgcwGsv7U/LRMk5TwLWojR6W5ON0l6spNhoNDlQULGm4hi6Qn4XLXaen0I9C0jTTn2gez8ErVfSXXi/TYKB/V4qBtkkraGclQa6bPQfaldJtkHQJ84S+lutL2llDtMnI4np9QeWXSzjUab0Ku/548xv8dTbZoe7yqm5sTbw68BIG7pfJf95RB43jUYqBqwc5ii0bVcvDjPyjyxQrg+Oqd9v3/03/n5/cmvcU2FE2Msy1CIBuIc/aCvR1cWuJgF6oaV9s1rkTT074rNtDElTIBEH59gt3CqVCeTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7849.apcprd02.prod.outlook.com (2603:1096:101:223::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 09:32:40 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 09:32:39 +0000
Date: Thu, 22 Oct 2026 17:32:32 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Harshit Mukhedkar <harshit007k@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/riscv: make sstateen1-3 reserved bits read-only
 zero
Message-ID: <atnYIbqQiFB_iswA@MacBook-Pro-4.local>
References: <20261021193538.80383-1-harshit007k@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021193538.80383-1-harshit007k@gmail.com>
X-ClientProxiedBy: PH7P220CA0173.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db301f6-e521-48a4-940a-08df301f6a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261021121427099003|56012099006|261009223027099003|10067099003|18002099003|22082099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: SG72QEMw61I8z3NKuO4T48PSoDbOI0ykh+ZmKJ7nMrO3D21hVt9IRYy6XwiiRcIqDyo8pKYVmkjRu8dbCJRS4mm0ttG+iLZhc9DXwBasfIIdv9WADFHJIU+SSjo9JX7FpLj5rn6PSM+Yzzy+wuZnv3rDGYwc2MJrIwO2zq/iS+Kp3WqUh6BA83p7OO5DTHrJgo4AsrJUZBfdRQwXWq0PS+z5EJQrqdp6i4niG7/+FRkbOeugG2fBoIZK3uCFNz+No3b8ADFiaOCZLl0gS3qwvnMujc6XmjlaMEQ9aIocS5lBUoQqAyIN1xE01Kmxa0UzYwVnRACju2lSrGp82YevkqaYUdlC1XKuAf1ifQzHJMylsxhhre05FHDG55iOx9MPet+7G+iQr/v1b/y7OvSZUX12oSgC59LHQsWiU8195Nz0fznE3+5AAyI/mpZ+UKQJlF9PNr8JRzOjQnWmN4FgJ2kDVMEm0ZMcg69DyEQuFr2CdmQVEytKnxyvr/pB72GtqP0fnx2BtyjxU6bZmvRetztIOpZ5d1s9byI8iRAbf5eCZQS6gnr2HL5W5iNnrJCwL73iEcgHTPAPrylRh6GYyuCU7mShrWUG9R9Wm4NifdM7FCQe2YE9rlJ5ht43sludTSEsEIcfcukjqreBDUZ/Yi2ip5SAFfXbi75mvFAVmxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261021121427099003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EAavmd6uWfUYcGYKhrbbcv+jVHQpmD6bjtsE7CNTJm36p+kiUiy0lNfmyvvE?=
 =?us-ascii?Q?swmRtw6QM5DDDyMcSmAt8OX209/qwrK5uRuBuECLpx6yHU+isAQTncTao6E0?=
 =?us-ascii?Q?qmJ6UKHfQIGSuaiUs3xzPA8FYA8Y+uu5UTmOHefou2HBw1v/MAH/mYds1G5b?=
 =?us-ascii?Q?NlNyl8u0YP4fE+5hwaB7D3yezhOCdHGr7wc+yeA14qWP6ARlrL8Ea2GZE0+T?=
 =?us-ascii?Q?O8IkOR/hGTbJYywgBZszYkgWtuMMu9EtWiqzrKAthNGMR96T6xYK0lV3zQRT?=
 =?us-ascii?Q?CiutYFh90BKpLDZNf3nkojv5NtioUeB7/qn5w6UI7aOiKh+iX8KX8LSINPwn?=
 =?us-ascii?Q?0OV7sI4YSxTFsv+bnGYFKNnp9OwxW+b9D4r99tWgnpdwtY3hDEbdbdLnTVaR?=
 =?us-ascii?Q?hYdt8pQLuqjgunTpNJ8GVTmyfsUoBHQVTQAinMM0CerImLUHoto8nYv4G7S8?=
 =?us-ascii?Q?uMPNJrfPdQQuUfGZkfpBI6THLh9hBlmRgeBjhlOCq1Buh225gdUAR7ZEoNiL?=
 =?us-ascii?Q?VZvnMDmN8olHPsT7tMgFVIhk64XIeJB3ObROb6mZTXtW5vsi0kWdOc9uyQ2H?=
 =?us-ascii?Q?CnG3Y6Ix2H8sZQrjdDXFCicPgKvXtYJKf4f324ppx08//0G2FP50AaxaK1aC?=
 =?us-ascii?Q?7a3dkmgsjTH1DuU4D4M3Ktu6LTgNrIPeulPwR3iYmprcNbFNYnREYYCrsE9n?=
 =?us-ascii?Q?E3xZNnFwlTDNU/PbCTzGtwfUGzwIACBUVKfJxoMd4NLQsTq0Hmks/miDjl5L?=
 =?us-ascii?Q?2cQE6YjDTT75HNBcjd5Y54Y/QQnD9/HIvsxwy25+SRrer2UTYxnKQ/8koVtb?=
 =?us-ascii?Q?Viyl/K/bOFyqF1iIiS0wecHt97UqS++VzZc/iWmgHdI0KpU24dk626nzda0f?=
 =?us-ascii?Q?gXao+bfldNlmJIryP6iwgMVB9dyKkcQNwBDLh3EhR/blLb/occ28MbcZzJWg?=
 =?us-ascii?Q?ltSkhtOyh7Qc7Sh64DqqHJCKLrloG8WSa6zeCugss2kqbJSNUti0QzxZsHkd?=
 =?us-ascii?Q?+fnlf5Xr5pusnfF0T7iwkxf/a528ezKlq9VcRD3vF4qwcKMxfk+1cKzaJVog?=
 =?us-ascii?Q?fGxbIaxIAurVGjMEI5O81iQGnKvkzS+yl7n2Xg3nlNQ7iY7D0yF/Ef1Z4OS1?=
 =?us-ascii?Q?h0D1wxYQfccFqPWPt0RIy2qJrWsaFzC6kDix0AD53Qbvmt5G3wvMEk61EpJ4?=
 =?us-ascii?Q?Q7Xet6UcO9ShJLjYt4Dc3N9slEb6+Mu6HM6G18vDQ/fBoFD2uYq7pfCni0Ay?=
 =?us-ascii?Q?gv4XYO+aulbCw7bfKMNsh65MIINv92HzAOEIQiO9pkY64Sv1Y2ykHLDdfp+K?=
 =?us-ascii?Q?A0DYDM+LZzbM3s39BC9AW/bsdrR8PSxeWRxDOV/ibngUKX5UI5PvkqDXCylE?=
 =?us-ascii?Q?qOaLfLZGV8sx0VFg0sk9ZwKSI4uBGv9rBSavTcgUDQ3PCXW4L5mXHrt9WlWT?=
 =?us-ascii?Q?MZsXqxCCbO5U4POTlVCbrIGUiCnNRp/0Uyw3HHDQ1InLAQ6HBbZJzqlfo8Zg?=
 =?us-ascii?Q?nWRDFgtKzJbsETrs99N5iXOCXu/3nH3RFMuJM9xy28t6vDkhkrytnr0DZ89R?=
 =?us-ascii?Q?/aGuoE1twEw8ouBlaZOJY9R7UaZTxb0QZx3kR/nQJFHhcQ9hiOXw0wIdeOY3?=
 =?us-ascii?Q?WHgBLTeEVquuNW3aeQTlyBRm/SvpZJBI7zrEhFmDtEb0Yao9eI8zuEkcYpdD?=
 =?us-ascii?Q?wQaCGRW2cZeyYZW0uI1MHF23CXtVT6fNq6iTb/8wQAJBKj+MDspqt0W0WBEr?=
 =?us-ascii?Q?s881IlL/1wxCRhM/kgHbrRanFsGPQTo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db301f6-e521-48a4-940a-08df301f6a65
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:32:39.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KSawknkMomtK94SmkeMy/d0wn2FX/cUxydfdKv1kR79q9dzUxM2+WujgpgbpBkt6xw3G8dWHsnsBCTDuwomBhg9YtNfHyuK0hNB1WwqfCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7849
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 01:05:38AM +0800, Harshit Mukhedkar wrote:
> write_sstateen_1_3() passes SMSTATEEN_STATEEN (bit 63) as the write
> mask to write_sstateen(). That bit is the SE control bit only in
> mstateenN/hstateenN, where it gates access to sstateenN. The sstateen1-3
> CSRs have no defined bits, and reserved bits must be read-only zero, so
> bit 63 must not be writable on RV64.
> 
> Use a write mask of 0 for sstateen1-3 until bits are defined there.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4726
> Fixes: 3bee0e40106d ("target/riscv: Add smstateen support")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 063590f56a..d9731421af 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3941,7 +3941,12 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
>  static RISCVException write_sstateen_1_3(CPURISCVState *env, int csrno,
>                                           target_ulong new_val, uintptr_t ra)
>  {
> -    return write_sstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
> +    /*
> +     * sstateen1-3 have no defined bits yet, so they are read only zero.
> +     * Bit 63 is the SE bit only in mstateenN/hstateenN, where it gates
> +     * access to sstateenN.
> +     */
> +    return write_sstateen(env, csrno, 0, new_val);
>  }
>  
>  static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
> -- 
> 2.56.0
> 


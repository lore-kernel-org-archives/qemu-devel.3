Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=awOYx8LP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2c9-00073q-FA; Wed, 11 Nov 2026 02:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2c5-00070c-GF; Wed, 11 Nov 2026 02:19:21 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2c2-0002tu-3h; Wed, 11 Nov 2026 02:19:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ9Cml8pE4g3tUgFhQGCjRvg7BV2W3QITeV8qhYootFHvBnEQ1rtFw8Fj4sZLRHbHfBptbtZRwcE5T8jtAG/1+DMojrOlPDWu+gkaBDUwdGAurEP3Tlo7fj9baFJnF3utj1vCwY8xK/UcXhHTiSwcQXxhcLmPjswjoSapsQ/ivIpngUYPsLAaq/8leilwzR+0VGva9w7ldapBxbYne7D2TD6xbeDhxfezuYMJQHuzsiBZXO4Fcwvmwnuir+nqWKLpCexyAF/NFkBtZC07HGpOQxOzP0pJDpmV8IdNXkgsI1sZOc5FNxZg1KI9Y28yzFMAAjivCpQTD32g0jsdtZoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ikO1iUb4YBJmU9A/eKW1OHYAPqy69YsbkuJAqaLFRE=;
 b=XUrrvcIxhJ9sqQQwTeCiV4EP5Fp1ucNo4UHotpOLKLxDF8ZZxBtGX3zrRlRjcZM9mxOZOKD5zni1kAG8QFoLMxhajvABTg9Pis3EgZsCa23ARXBoF3Te+ku8r62n+56bUKBPHCfdhUJKsjjFLfUHlszBm7KjvcEjJBHbpIKpTt48LgOKYXMN2Wr+BuQZZ+4lixVJwcvJ4W68kgFJpTBUXqmhkoqSYu1pYgRnnZ+Ym7QlxZvxrI9fIuPQjS7Uf9WUEmyFaRdftL3b8IQSx0RVnyk43UypYJ5GGUy+jOHKRVisBejQJDsKyjNBKkU3nCymbgDdxRBKrEgdoIEY7Q+4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ikO1iUb4YBJmU9A/eKW1OHYAPqy69YsbkuJAqaLFRE=;
 b=awOYx8LP/2eK2beMigbRbHCq1ZRPQD773G04FR2uBFfxldYTpsoZ1laptdROMkMnEq4v5IGHHdjhxaIyz3YujTOJs0Nh61GMTxLjP2oc3o4E5wVcp6J8W/EORwuUzgjJ6AAiP4WQILYAfnXu9cK5gDlm6EutbHGrVesXn3q1BBLCUhXmalppwEb15KvZ0gXyY1H0Oi52zAaSYDyEdmoipWUSy1zlldWUfrmNO3vGxgbL6Q0iCV0r2zpBj7ELznRimMV1mRj+Q977bRZItcTXdAjWlTOgv112siNEauUmewDnvzVTTQ6shCtL12x91barJDmTmr4/nW+sQlgQN8YNmQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9455.apcprd02.prod.outlook.com (2603:1096:d10:9d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:19:10 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:19:09 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 1/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Date: Wed, 11 Nov 2026 15:18:51 +0800
Message-ID: <20261111071852.40971-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:510:23c::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b94211-e0e0-4b08-f75c-08df3fc413df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|5023799004|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021135927099003|261022105027099003|56012099006|261102123227099003|261009223027099003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: ZU0z0c11Tk6DNcd7R07utXgiiKUKhqfyv5i+DLIbrVpDB0bDL54Jl6E1uvAwkBX/B/9BNOFeyi1995QlQIjEKYV7K93k2IBsiSXDLucIzLyoAMz9XkKnZLjfAn+OC8yzTQ212NeyrzUafu1V3vv1HpnWWf4NOZq8X0wm9/Z8ribaScaQqdxytOWa+HT4Uxk/DO3vKHuW8DoRsIrSxeWpeoOXSX9OiWkpfPcLA6KmTnOOIMclM79C4ILMrcmGqmB0hvOx6g1I6v4pyBCZVL0qWcUK/tyD6TnKCu+YEAIkBeZbtMA7uppFbohFHnOq3yBt2Q4cjoUkif0XYqOvwFo6Lud/rAySo8guvyRYjKs/AyE5dLocna9hkrLovL1QTl7NAIatTw+Q67Ww57OWmKfO/ikFV6ubijGrp2hdh2+i7DbHclb69xNnKiiadCV1bVetN83rB1XrG+mzP5USAiYRGdFM3MaoMQGLOSXfXFdozK8zjXXroJrD5daLLqHCqjNCMR0KwjvBjjZzOpclJhYGYj7gaoLovVS9lVPZAyK6ZLpkLLtVfkF95EUC+vlJvsUT0MHqLCE6/sqktp44N78TxWvNvu8Hm7P30dwuVghhDIAhj22yXNKM6ZUVwXKMbzJuIbMSgfoYiXFR7TGVeKRWiS/TOu+0TDOHME5/2yMnFaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(5023799004)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021135927099003)(261022105027099003)(56012099006)(261102123227099003)(261009223027099003)(10067099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UeU4HFMqbmZ/RfSKpXSpmOBVX23tvXI9dnh5X5scoQEka774RvJQ3qF0/XS5?=
 =?us-ascii?Q?qO+4NtVn4W1N+SUbHR0fl+A7Y3WAnAP00wuFeSFX87p8sd4KtmfhpTVqQy2N?=
 =?us-ascii?Q?Hpf62DqAbKpIb1ObK4drIctFrv+mNbso5pzZGCXGLF0xV4CctSogOrzKwZiQ?=
 =?us-ascii?Q?e4z5Q1V+KuOI+0vfhVmBEz0dDPFCD7cvhLal+JszbqVNBcQVxSzjiVJVyNYI?=
 =?us-ascii?Q?sllQK8TjPrlaFkkQZvoiLPaC2hrEvIFL/Zy7tIgN0tEsVfDjd0fvmE/Ykq7O?=
 =?us-ascii?Q?jaaokUGKqv8pFOfAcry/4HAhaqQ8T0auIY9KMylLe8keetvNc7oL/xXwcu/4?=
 =?us-ascii?Q?CLWzMrJ/K3YKWW6waG9bOAfxNJlDq8dKSfnhkIyAd5C1LxkLwmXrAb4QjkEi?=
 =?us-ascii?Q?8xPcsM9ZApyy9VI34ZxInOlRm8+tpZ0W2ZGWwAU90X7bsbgO6kvHOoG/TuAP?=
 =?us-ascii?Q?E2jB+f7TE6IGjIGkRt1yYNVlAZ8DiQSJ0uNA6/P/pdSranTvZh6ZJ91tUa6W?=
 =?us-ascii?Q?UMQZPKKuU2w/i/zkyt1aZhKAUa0lMDzF4rtfWVXcvqntzUwPHogimBYMsWyA?=
 =?us-ascii?Q?wG0uxHk7CjtT12Ex6OQrvsaqn7YlJbyjgbkzjkADweUE9ZhKul6NKHGfLvZz?=
 =?us-ascii?Q?QrYHHn+F3E9/P2dVrJPX518qMBC9dCq/GiaxbVzPdn/9PIrvVKuz0/T88o9U?=
 =?us-ascii?Q?6or2q6Ss4tTApvI+stg25DRs0+m+Wqi+ExpC/7FRu2yRBCxGzYHqk5SNni6a?=
 =?us-ascii?Q?ZHkzBYmEDDI4W7WT5ONfSgC/8vxq7GiKKPJuW6vsdRmGzxCLbP7cn+aluFT+?=
 =?us-ascii?Q?Ew42Kx2Za33LP/8K/f88qqeqk59ymwGgePW5OAGeDo0y8dHnIyA5Bp/i2/R+?=
 =?us-ascii?Q?ZhUhWaQePL1AIFeIwTWkRCFAc2E3DcWNj60w4ZdIb37mcsk+Y8PQJKRFWbLX?=
 =?us-ascii?Q?LCR/E2v8sf3wJiC361sH9prDOgeS6MQ6KUe7UYmTO6yA26dzUI324en+nlA8?=
 =?us-ascii?Q?7SHoq7E1LSCUPVAgfYIlWtbnzGiqyInm6UhGS95DccTW5UtOLUTvTZ8qgCDh?=
 =?us-ascii?Q?6/3R5uQRvDYqIQ4pvV5YDAvVrd4F2EgX902UDEUE7T0ZJyHPfA+yxsV/7UIt?=
 =?us-ascii?Q?EkeZimRQCLKt+ExXRvLuC9NCB9Iv/rhqt+D1EBzCucSEjGCs+NhqpX5OdKgt?=
 =?us-ascii?Q?Xpeg04G6TM1CKd/Ug6niYPwgaFlIWzmCtmpKPCu8+tlzu38VQfQCxoW1tQrv?=
 =?us-ascii?Q?zG0pONyQrEWvtREvRYKKU+SVOZxsg9WpPjtIQkHWjhIthvt5DSLNoXVjIfzB?=
 =?us-ascii?Q?Vc9kCosr2rpW0qmqBzw9g35MOoB15KU7Mdv3ZGrrgv9KshIU+9pIgV569IuW?=
 =?us-ascii?Q?yWyrRwKaVdUSNumHC1YmZIArib0MwxhMcLsjCNNnnQc5VqbKcYhtnz7Jk5os?=
 =?us-ascii?Q?sFi7Jt6a828wQVte8oO21WMYaUI+Rf8gkPF/vcR7Ha7RKrH7BVYx7laR/Asi?=
 =?us-ascii?Q?O8vY03zKAVnVBUs9K6OC5tbaoqwtQtTmik9X5hSq8ZW46QecJJyCyvalmrbp?=
 =?us-ascii?Q?vTLY+qxH/Ua9oLW6mLVaVAVdvjscge+XApRYwRFB5zZgMaAlVol9xrGp84oA?=
 =?us-ascii?Q?i1UAubEZ71Y7al33MoDhUOrll16wPhA3oOS6j4FvptXKJq7E2fIX4GCF3QdO?=
 =?us-ascii?Q?oRfUxygDyMg4XcBk4TC8vVexQtTN1brgmlgOGIhUlnZEk0pXGe6mjJTkZqDX?=
 =?us-ascii?Q?k4FUwGRBiphTGK+haOlDpFtY3EhVC5c=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b94211-e0e0-4b08-f75c-08df3fc413df
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:19:09.1146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIkyJVcvGCzoxnY1s9xWBHYt1Xwwdk1wnRnfQnJGVGdzugu8XcahpW8gsJHtwCSvF0XR2gRotG5Rs6nB/vMY4TVAPjjAf4Zall05o8VeWu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9455
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

On Wed, 11 Nov 2026 04:06:00 -0300 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> wrote:

> We're leaving env->itrigger_enabled untouched during reset() while at
> the same time resetting triggers to AD_MATCH (type 2).
> 
> So, in case we reset the CPU during an itrigger session, translation
> code will enter itrigger_match helper every time (via ctx->itrigger),
> and the helper will do nothing since there's no type 3 triggers set.
> And we'll keep doing that until something else clears
> env->itrigger_enabled.  This is a niche case that it's a bit hard to hit
> but it will cost a bit of performance for no good reason.
> 
> Found while reviewing an itrigger related patch.
> 
> Fixes: 577f02869488 ("target/riscv: Add itrigger_enabled field to CPURISCVState").
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/tcg/debug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 8b58cbd07a..988bc815d7 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -1213,4 +1213,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>      }
>  
>      env->mcontext = 0;
> +    env->itrigger_enabled = false;
>  }
> -- 
> 2.43.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


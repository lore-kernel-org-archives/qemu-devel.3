Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8077606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=kheEqqh7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4Sq-0007Yz-JQ; Wed, 11 Nov 2026 04:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR4Sj-0007YG-H7; Wed, 11 Nov 2026 04:17:51 -0500
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR4Sg-0002dy-Sk; Wed, 11 Nov 2026 04:17:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjDzO/xWQ3/4PSNzFhQ8WV3675DXyelWP+ad0ZbrHAJNaCF/7RXUuzCPxcTXFlgyWmEqg3wzEfPV2XVQO8mll4yWWIH6Ox3FVKfP6v91v5PNB6FAfW46ETi6CxLZ9O1cuVgX8sx6ZehLrbe1TGsWwv1nNz1B6VOVQIOYNbnezq5/JgCzmmdEYafj79H0UTmtxcUCzULp8KYo7X2C8kxg8V6k7cTn69y7ZoDHUo3x/UHJueHkRYE8mXDVEAEuj8wZNZYd/7Zq7Xtoz5fyi0ZHsyNt0lmRcSBQrD0F0tjIgh/0RyOf3EF7N6nOSklGcXOCmSZYoBb82XQKLQXx4FJ+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QupsLmLk9iuH9ObLkiI5nA4F6ThOAGMJIOppdlZEikg=;
 b=jrrKoaYeK/MmFY5vCOud5QeSZgPKhg93rRWeXxXwapux80ZE+vbGniI1b80yyqRSy3d6DqixA2nlyzhlUajiQuIYjxhay3BeFIKPjIeC2w96zcziEuilABnds9fhdSl+fqdsK+LiaNrzxhyiI+Q6K31fypI5m/WQyCk6qwPYkLABoRCtgnb4y1rzP/GMSH8GyDtKoQnl+sMdKqcN+AeFMBp1KXLrIOqSHGGDAXgudr0/c/YKmLWBrQrZSS7ERqNG9IjXyb+ZpW6nnSR1i+LuRBuQ+0rN9DwJZWXx5DW9zqluoDLovpGUT5kduHscKhIX1ChLXx4oZ3iPTC5uibD0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QupsLmLk9iuH9ObLkiI5nA4F6ThOAGMJIOppdlZEikg=;
 b=kheEqqh73Vpdvminz/sFrq+f+GHjsKcBxpitehZ3KHRIne8TvCtjPo10y9xHNSegMYot2PiCxK+16gtX4QRmtFUot1FxZdwhAbHEKB9tILfRBMs5dE7zyxm8cGplGx3p1eRB/imthbeFt8KdQ3bXlqQao+EzEuMA0nnKQ3wrwH/xnRCP5uJCY8JyLKp06cE47SZgTGQG7uy+AmO0MsYsunB7G/jcnTVTGhPXNgjYpMTtEccB2Jb7sVvawYKr9UprMzUIwLqioPbhFArskF6ofptYkhgIVOOhhAauzWf1y6BiGPI2QEd2FKUS4Pwp32rslNZIHc5DmvmCv1K+ajPC5A==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by PUZPR04MB6383.apcprd04.prod.outlook.com (2603:1096:301:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:17:38 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 09:17:38 +0000
Message-ID: <TYZPR04MB7491C5D665C4A922EDCD5A05F3712@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 11 Nov 2026 17:17:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
 <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0041.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::20) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <467614bd-413c-4b17-809a-ee8393e09eae@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|PUZPR04MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f05292d-df0e-423f-d4dd-08df3fd4a0fb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|24121999003|15080799012|19101099003|19110799012|8060799015|21061999006|51005399006|22091999003|55001999006|25010399006|4140399003|5072599009|6090799003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZExvOHFLcVNxUXhXNzFZR2pYTjZWTTRlK1dhdzZpTHA4Yk83TmVNT2VuMlZK?=
 =?utf-8?B?TSsvYi8xMUZaLzlhY1NTTjBrV3pHRDAxdi9xL0VPazlYbHZmVlJtOU5UeTln?=
 =?utf-8?B?clEyazZjei82SU1jUFZySXR2QTNZRlVEVWw2S0VKbjRrRWZlWUhzald4Z2Yz?=
 =?utf-8?B?a0M1TVM4TWlHbFBwa3hqWEI5RUZOOE1VSVNPeU8yZEczVWV3UmpRSzRoeXdk?=
 =?utf-8?B?bXc0SXhNeklFYU45VjY4V2pzRGZ3RUhvQ2hyQXZvM2ZsWXFBTnJzN0tDbjRn?=
 =?utf-8?B?ZkltRUkwTk1pSlhwNzY0NEMxTVJXamZOQkh4UHpPenJHbnlrQ3VCbXRrY2xG?=
 =?utf-8?B?eGRLTUhWMWJQZW4xNHczbytyZFFrWEw1SjR2WGJ4dzVLd0FkTG1YZmRpNWgv?=
 =?utf-8?B?WVlLbm5xb3BwaGJndHhqYUlqajVoaGVNYUc4K0Z0dUVVeHhEREpEVVY2cmgv?=
 =?utf-8?B?Y3BsUThvcElyeWJyN0lTVTRrekkxUnFwVEcrdHNtVjlaTml2ZDFaWGF0eUJ1?=
 =?utf-8?B?ZjFYWjk1L3VjSVlKWGtvS3hkWXVXQVJCSEZNUkxyS3ArUVRiaEh0N05Sd01Y?=
 =?utf-8?B?eU9rckNpajRYYnhIUVZJMG4rVFUwWllYRnJQdFl6R0dTbDE2ZDdMRjRkdW1l?=
 =?utf-8?B?Y1Z1My9lZGFBc3dYUUpwalFDTUxLTkJKVW00TTFBUlNCbHhSdmNYd2ViYlVU?=
 =?utf-8?B?aWdHeEw0K2Y1Nm10SlJCRXNlckx2VytIcUNSemJxelN3djY4WGRyUFRmWkQy?=
 =?utf-8?B?N2QzQUVHdmNzc2MvMGlLYVlUYkUyOXdpNEZZN0JxK3BZb1ArN3FkcUJiZFV2?=
 =?utf-8?B?TWJ4Zmh2S0xpQ2t6U3VaSmlpNGVFcEY5QnlKb3BJYVJ1MU9hN0FvOW1YV3Yz?=
 =?utf-8?B?TlZyeDlrMjYwWHdjNTFwRXBBblpnK0Z4NEV0YUJLMHVLbUJselAwOU84ZVli?=
 =?utf-8?B?d2p5WXl1bHc4cS92N3BSNGlQM1RLdFo2SEkxcjZ3amx4bk1mQXBLTjNQNDhS?=
 =?utf-8?B?RUdQMk43TzJ6UkVhUTg1NTliMGtLYVpNN2g2aXdxc2c5eWhMT2xMUXZHR0Qv?=
 =?utf-8?B?T0hFY3FVYUxrOFBUWmh0dTY2WFRiRnU4UlZlYlhWUjRTcHlhanl4d0h6UUVB?=
 =?utf-8?B?cEpuUVF2M2p4eWJ4OUx3d3JUbUkzVHZQV3d3YVNpRk1WdHNQUk5QSU5QeGha?=
 =?utf-8?B?c3p4VkVUSzZ2WnYveU5DSGNoWXIrT0c3bkFwV1dZZVNYVTVEcUlta1FWMUw2?=
 =?utf-8?B?NExkcjF0a1Jia2JLVS9aWTJUSTRyQlUvTGlZU0ZBaFFtWlBIMU5EdHFjNXJ1?=
 =?utf-8?B?eEhBSkcrei9IS2ZvNXU0WVNrVThnamU5QVdoSWJBektNT29Xeml0UlBpR0ZZ?=
 =?utf-8?B?bzNqa3FPbStxcW8vRUh6d2d1MVRXZlNHTEN0Z1l0YWdNQzZqVVYvOHhOWk1u?=
 =?utf-8?B?elNPUFUyQkM5bnhEUGJ4RUVHcmwvMlM1dGhuZGFVKzhrbVBORStPZThvRXBJ?=
 =?utf-8?Q?woQ7/o=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdVZHBJZjhGc0JFSWpHZVQxbzRjVE1jUUdrZ2xaU2lvZWpEeTk4TXFjN2M3?=
 =?utf-8?B?VEtTRnVjV3JaeDFEWVJyaDhLczJBRWJ0dnVQbkNzZENsUUJIN1EwT0RDNFda?=
 =?utf-8?B?Q0dhOWJGK0pyTVRSTmNaUHgrek9OWkNVeWN2YUUyN3ZPMm1LUnlQK0x0VHor?=
 =?utf-8?B?WCtqaTBJNmw4bjlPN0ltMXNMSytpM0VJaU44elo2d01hdmZGbzd0dzVRUzhj?=
 =?utf-8?B?VFJ3TkdlTkxXL3JwaWc1UUFFYnZpdU85aDBtZTVxMGNWRTlFSVFVYXg0Zm1Z?=
 =?utf-8?B?Kzk5K3R3b29rZWc2NEdqN09GdTY0bGdhTWE3QzVOaDhDS2wrYWV5VldRRXRV?=
 =?utf-8?B?dktMSnhZbmMxZlEwNVA1R2VlY0lDRytMSjdUcEFSa3VVQ0FUUmp5ZDdwQk9H?=
 =?utf-8?B?b3pldlkvdWRKQUluZENHaEQwSUZ6aWNNcit6ZWxSdkVSU1dyb2xiMldRWUUr?=
 =?utf-8?B?RTVPc3ZyTzZyYnJpSnBqd2ZudWtlczBzTXlCZytEZWZJQVNXMmdoSTBTWjdu?=
 =?utf-8?B?L0lwbWJFaVR4NnlCSloxMnlBanZpcTBqUVVhQnFCVENucGJScWRjN0R0TmlJ?=
 =?utf-8?B?UlNER3F6TjYyL0F1YTBnQ1N2OUZnM281S2JpWDlIdTJRRi9kQXV6YXVKZkdt?=
 =?utf-8?B?a2dab1RxVlNORWdnZWI1MEpYdWMzM3pSRng1MVgyNHNrSlJRU1V1NHNOTVZ3?=
 =?utf-8?B?STFvU3NmdE5jV2VyalY2b0tVa2tEV0xPWWJMcTcvVVVRTFBvZzRtWG9PR3Vs?=
 =?utf-8?B?Nm5hbFUrejRobmNqUytJQk4yZjRycGJIZHdDMDViRzI0K2tJL3dIZEtXc05E?=
 =?utf-8?B?cUs1aXNtYXVuSk9jaEhqc2c0TFNRUVVySllBU3NUK2VXa1lXbmN5ZzAyTjVI?=
 =?utf-8?B?QitrdWZDVjYxU2ZjZjNDZGh2dU16ZGdwaStvdE9mek9Qd1FHeGpjWXpFYTZh?=
 =?utf-8?B?ZXJJNlpNM0dXVUpZNFlZd295cWJxUUswQitxUlVBSDNDOGliRFd4MFBIazhi?=
 =?utf-8?B?MkZvTWI2UmQwblZwVU80c0xDQVhqNm8yUXBEUkpCMHB0YnA1WXZLTVlPMmp5?=
 =?utf-8?B?SmZ2Q01icW4yOU5EM1lnanhoMTJYQklPN0NYQVZGYUVaOUxMeTNIWlNZdjRE?=
 =?utf-8?B?Q1RLRE5NdlJUc0YyUmZmbWY1WVFBUStiWmRKR1VVditPWkVpS3luTWtuZGRH?=
 =?utf-8?B?VVpKNUNWL2s4azZPVENadmhUeUpXNk5KVzJqUGpOOXRqYnlVZzl0RkNxb1pY?=
 =?utf-8?B?S0FxWUc2Y1R2TmtHZ0RJQkprSmxGZVR4d3EvTUZsNGFHR1E4MU04NWVGYmMr?=
 =?utf-8?B?c1dYaklWK0duVXh4M0Y1d3ZkSEhtSitVVTZOWS9GSFhOalQrZXhnUHdqMUNk?=
 =?utf-8?B?MnJWYVRhdGFGK3hWKzVZdm4wWUhKWUt2cTE4V3d2cE1uZEhOc01FS1gwYU5O?=
 =?utf-8?B?K0wwQ0o5V3lzcitEL1dUWnpJazJDNUVPZi96ZUs2WFVPeXpyVWpudEIzdHd1?=
 =?utf-8?B?Z1YzdjkzbHkxYWRlU0ltOVJ5Z3cwSFlaUjdQOTUwMGV2bUtQN2gwWnBPaWdR?=
 =?utf-8?B?S292Q3lZMnRjckhKOXpOcnIvNm9KUFpmaFg0NnpKejlpbDNoZmxVSDVEQkNx?=
 =?utf-8?B?U2JBaFBxN2dMSDdHYUFJckRCMXliRlVOdDUwRnlEVzdROXAyNkN5NmgyVHI3?=
 =?utf-8?B?WVNQaVVZdUl3dGJhVzJNRE50SUViOE1OM1lYdkV2MGhjL1NHbHZzZldNUlR3?=
 =?utf-8?B?UXJzYkwvRGdabzc4QS9DK3ZJWlBGdGMyR0JlL2Y1aTZ5RnBKc0FDTnZ6U054?=
 =?utf-8?B?L0MzcG15MXFiSzJMbml1NG1ncFBKczc1Rk1BVWpLSXZ4citoK2FHOU9uaHZj?=
 =?utf-8?Q?x1IFOpsSTFgxQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f05292d-df0e-423f-d4dd-08df3fd4a0fb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:17:38.3960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6383
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/2026 3:06 PM, Daniel Henrique Barboza wrote:
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
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/tcg/debug.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 8b58cbd07a..988bc815d7 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -1213,4 +1213,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>       }
>   
>       env->mcontext = 0;
> +    env->itrigger_enabled = false;
>   }


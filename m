Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A57606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=A2yUF/IM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3bu-0008KJ-VJ; Wed, 11 Nov 2026 03:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3bt-0008JR-P1; Wed, 11 Nov 2026 03:23:13 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3bs-0006k1-3Q; Wed, 11 Nov 2026 03:23:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbqX+OY3AyatUUUvdvNi0KkkK8/4Z9heN67/kWhmYRgdUASTmiScDJxAFt6urU4kMxwoVv2qoSexivp6WfHcep5ZWxPO6rsBGjx+rcCw2jpr+8ItedfKxUBe6eXU29kQfo2Ais8R4zsXGZ0UeQcCz44GC5iObpJ5u7uMIxmEs7cidDs0p3nAn5eKeh5w7tu2oOuqh7L7mxC6l4ZuRiQX/1rWSIfUo0bK+WwrsJduU55si1sIHVm+cC5nvi44wlW2XcWPOIjrFMIRUDU2/0TGY8qqYuGdDDQWHvoH7uCAqWOvwBfbrZCBcoDLoyYzT7iMIneiBFplOmdZZKk0GQ7x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmiVf7P9cxcF4Juc/upyB3SslwjpGVxR18ZUqjm5Aqc=;
 b=IpwTjhhWyC31tLmKp3ENmYPmEo9JLuSHpo4aFwISKj2K6d1qIgWOSzFAJ1j1au6N4y37Z8Lfl+qtPavNJqQayts68pyhPnBRVb63tpbIBxDfmTpNhiQOn4FUNoPjjZ5c2sSxL9lfgbT3hIHaBuQkCSTXM1u4VoSc72MKTg9lCKv9hsJTYco8a+Nh5UhjeL8iH8Z8HqIyqrzKwtBE0KDwol+YrShqO52W1nQoyuZsuRnhb/MSavxN7n6/w/8jFfYV5QJo9Cg0pPi5/H8DI7fH0W9zvKPEYqySyJj0Wej3wbxQG9W8LJBzXzVf9A8Q3WVSChP/w2I//cydw5j7a47pSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmiVf7P9cxcF4Juc/upyB3SslwjpGVxR18ZUqjm5Aqc=;
 b=A2yUF/IMoqyt0nHEIEUBIWUtUax1O0s+D/xboNuvKXUrpyt+tbEFk+F7UMM8KLoUMHGhD4JndufphOp2iz3UmKSys8cQxGfDC+JSFK8p6Q6LCz2K1+dSPVgSjCbwe3QVLB1eGJWCQ2/aHY3b8dTq4Gexw/M8j51RLXbRVNjVmQEaVCU7/El7SA9ApuwFicvmY194u3/Y0wEF1ei6caI0CiBOL1JqLNNcdo77w3ZWlqz7zpzeqMDgfEgHaX3JpYvnLQuFc8vctAjGoh+dFMRaxD3Z7IiVBpZvyQ0Pj27RyeEWccKUmjhrkRyL5bo4X35fX5VZxgvunb9QiSBPj2EJxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB7487.apcprd02.prod.outlook.com (2603:1096:101:1df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:23:06 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:23:06 +0000
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
Subject: Re: [RFC PATCH 31/38] target/riscv: Add implied rules for
 Zvfqwbdota8f extension
Date: Wed, 11 Nov 2026 16:22:48 +0800
Message-ID: <20261111082248.59282-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-32-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: b28ed4d5-0643-40f3-d980-08df3fcd0309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102124527099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6ZsUbla2uINIKLjoyJnAtDsqk1p2VAO+macJAqAWMbw2yevEL5miGbTvu+uQhWK8xVGZdRaeq209Gaf77yUVGooE/l9q/URNLLCbcwYoKZz5cT61HdAv/TKwV7G6ZoKnPIQYIsKZXSr0O1ZC6Lhr4TKMw3QbLxYlCKq5biIN83Qq0LsbgZJ7t36oaN6pWlByiKRSQKA3ie0IpRVoVEaA9AZQMuqAOQ20WpUPjqf22iVA4pT6VhT5mJCWaeUb4ZJ8gstCEp6GJI5yoj8N/Daaw2FWwZwiL/w3u1Wj5soqeQDQkUquTUJCfLycV8ydJ5R1yrpF41fOjo0ykhQQ74nhr6FovbiZH54/xSuWZaULeJBdyx9o/KSujq8u+ENfLWJvLbW/f8SScUFpcH4oOGS9kWIlq7xi5Vo0n6X+kwRbUUC4dOphfLXMVIQDas6CgED090Gmi0OGQeytQ8vbs7HLLVmvp9QTBfmz9nZfkH0aaDOF79qhPly+Q9WKyULhw7PSMqjYiw23RhuGpXnpGBWITUkXQVPSNBeRshIl/yV+8dx/oCp1WTBfKUMZd8/Au52gmU6EcEicV7DDTTawi/eTBUpxK1BDBeTn2Hc9XOe7/jr/YcsyWZjfUqYGezASccfcW2JN5bs0wl3W8GO1xlp7q6X+cd+n24PcDAqR4L6q2m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102124527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZcCfZ6gRGxLXul+j0wfV+EEcVrYaFdy2Kc4wRTzTgLGHOkb+fAjZOif7iDv?=
 =?us-ascii?Q?Z/2uUnGgpesE1JSc3jPpB6KQq4BOT91DhMI/Fp3whPi+qd/g1ZTvoPXNt6bm?=
 =?us-ascii?Q?Zj7AqR+0eb0W7QTa4+PfU62CWnHahONBSAp+AYortBVRrTJt9PrxR461NVVq?=
 =?us-ascii?Q?8gbNWwm+L0yPLZIJgdAGSflRNy3CfHbH4tuQZzTK/4xK6PzNKp0vLIFGTRa2?=
 =?us-ascii?Q?IliqAHeJvwG1qICKvUUHlfbc1A9hpHOyr37bItLgWKYTGyGsry5wytmZDrPw?=
 =?us-ascii?Q?atxRDmHtsLxl3Aq+hx+a47sgCwO/DEFOREpt/0VzCn5m6SNnmtBuGsn8V1Zi?=
 =?us-ascii?Q?D99OJhD9GdUT9/iipIjqNKy0J6bRkPdPuHSHiPY4nwquHBLCvIJd85pIxSrb?=
 =?us-ascii?Q?6U90B+Hc9ojTtz8QKG0x+wphizcqSY6aMJhTBHouVETUKlFkMlInWSl4Tdxd?=
 =?us-ascii?Q?/zAS1Kkd9iwqdKLxV3LFMc6nykzhgIoKtMGSYJex3uIwtkYOtCDc/XfwbI5N?=
 =?us-ascii?Q?tbMeVHFrmrT/O0uTG6PYSwek3ilpnccoo9EqiKnKekX3itGtmXqGq/rBYaAk?=
 =?us-ascii?Q?s5oDt3k3W3UUo80Zew8D1NnPjm96ADrQkVaivuJhz3bNmmGjyVlmFJKcSgPu?=
 =?us-ascii?Q?8nBlm0SGEF2eA6J5o0g+i6ewZM2Vrk7AJc+duf0v/tlvz+vAGEp655Fm4h8v?=
 =?us-ascii?Q?Q8kR8lBHxyIfbsT4iiVokvMqGF8l+gYwPmJUOX6K7qPYQY72mRMqS5KGyEh/?=
 =?us-ascii?Q?AGMpNLN0ayLWoxONJL6Yd9xzmqHCFmZf0MtOrZcjc6GO/NrpIkPUg6iUmh2J?=
 =?us-ascii?Q?3o3IyCJ4Svi2nUEjskTkidmmhEQoseXAbjaomd8W/ElLFMKscFqXveTdgfLf?=
 =?us-ascii?Q?TUcX57mq+Y7a85sMivFF+OLFexdvTojlXg+g+MZT73XWO1pfPUaosDPnQEZx?=
 =?us-ascii?Q?vi02iLss8urpf8LZoOoN5NWOEV8/ht2cOo6qKsAOFnF1Gh3usI8N5/nicVIG?=
 =?us-ascii?Q?hNH5LQdw5dgVuuCFmWmg06tEvq6LgKNQvYG42BMSI3kZC5fDpzxAvaSlGOKH?=
 =?us-ascii?Q?IPgh2DC1sF6U7FTaCNTN7GwEJ2dW63yJdASQZelgPxA+l1/+xeQyUlRi3+qj?=
 =?us-ascii?Q?O3A2SvbDGAvfcTiHlnBrob1lpF0IfzY1Zr7jecD2TlRlMjXmdpH+H4Qptt2W?=
 =?us-ascii?Q?gLGij6VtyxEeZ/qWF9xFPGedQLGpZWo4jRuYZGb8JE9PxjZ14zGP7XgM6EUH?=
 =?us-ascii?Q?17qM6sQxfeh3XXyAr2OKvSxsT1HktCr/5UVH8V221sBdgxkytdhUH6b0sUHx?=
 =?us-ascii?Q?xntbODxU5OZqSpNobZbnWv/5wdwgIn/HJO12/3RKfoR28z7LRQscPzqjc14f?=
 =?us-ascii?Q?AiMMLmN+VIWiAmzmglJcO4pf0u+UNEDEJg4LoSBV2UpSVFAbf5pVRjMaW0tY?=
 =?us-ascii?Q?bR5Rg+d6mFxAI0W/Syt/IyF56Ly6f9M2CnMGtQY/mYZ96zAVu1N6D4eFLMsO?=
 =?us-ascii?Q?wJeTYaxwty2ubAKX5IYGs54QnJKvWKkK9BWD+xmdPwzkw/VfDKuaQocx1oAG?=
 =?us-ascii?Q?/P78aYhsBa85rLUUBT3JoAeVWLSWeR5k8A13jr6UTmEQgtan5J2WTIePQ1L7?=
 =?us-ascii?Q?XangolnD+q+VZQwDTJMrB+83kMs3FR0ZuCzoan7l/rhkgZgtQwH2YLeTUyDP?=
 =?us-ascii?Q?dJMgf2qT58Ng4UkukoHZg9Hp5JJX9fVlWLaZVLFNM/4Do9ATFCqnF5kUZ1rs?=
 =?us-ascii?Q?fxdKUIhzJxi32tFsdFNN9zg8vW4gO1U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28ed4d5-0643-40f3-d980-08df3fcd0309
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:23:06.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD4LlaRmko66/DfCXz9JIGVGbFhIv/HIJ6xHjoyByujocGyy/Elm1wabG4I10+ULNG1/Uk8yI8IKr9aUJ5j3rJyOR9yH9KueYJ40IlePUUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7487
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

On Thu,  5 Nov 2026 03:41:46 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvfqwbdota8f
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
> index b4a9f2c3e30..0a35bc7c416 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2892,6 +2892,15 @@ static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFQWBDOTA8F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfqwbdota8f),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
>      .implied_multi_exts = {
> @@ -3125,6 +3134,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED,
>      &ZVFHMIN_IMPLIED,
> +    &ZVFQWBDOTA8F_IMPLIED,
>      &ZVFQWDOTA8F_IMPLIED,
>      &ZVFWBDOTA16BF_IMPLIED,
>      &ZVFWDOTA16BF_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


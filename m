Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7487606C940
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=j7MyuE0n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Gx-000145-L7; Wed, 11 Nov 2026 01:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Gt-0000yl-7X; Wed, 11 Nov 2026 01:57:28 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Gr-0007pY-9c; Wed, 11 Nov 2026 01:57:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1fJESulJMFt6JGbeHFCEDYPSh54ASk6U0RTPTP6zSoEWA8vJV7z1zj3qLSt6oUnlz7wdznq2ASQ14rdCe5bTQUkTLzlMZQMKhCrnHFsLgJJKOk5Rjx60V/7LTi92soTgKE9AbLh66RDsTAlq/XqAHQpplI511CupP0tuuu9QcsTgiR+VyDW4oZo0qsWtN3hLiapzC+gvyJEu10WsD3T0LnwFBCykaflfPtuKronB4E/prRIDK6zsihS1jNCEWIgIOtr8ApGmhWU+iL5pgeJCqQnoCG8E8vMx1FBFhqpmsGTKBO10UiVIRWapZJZJB2HTB5rNEpQel/eXIhS7psusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8IpI53kbG5F6cccJYTkNI6pV57kBdM73sQIQli+3Xw=;
 b=lI1A04CJzYtJA43ZBAHPVHmRt/SmLQ+fXCBkB2VbXGIuINohaYTTMPkdP9YFi36ixZMAO/xvqI6w7UvLkAEQJcj7ui5E1XBhMlwTiEaOgS5XjAMJzA8/PRTcHNYK86rhK4yMT6+0sqWYu+Ly+ofghS9g2Eo4iWjOyctXSa+0KViGH5j0seWSSKLmvNn88MV1i+RVJEb9WcT5ReLTCFpCsW7erMOIUGira8MKruc4RhvteHPNLdVj6/KyNwBnFqhNPfNQMjr5fIs4W1/Oz0U0jrLItPoObwhYRaW5hf4YSD8Ut08okzvXHr0kKi/p2Bpibb1E9n4tT1OIFDL8wQZJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8IpI53kbG5F6cccJYTkNI6pV57kBdM73sQIQli+3Xw=;
 b=j7MyuE0nrgIa1HSqiOi2MqLRkTqT4yYdY5xMKINmJw3tIGT8V8dHUWJKHHAlnXVhAkCkmAsnRSdDJlMDiYU+P43ErE3quzKaoyCFIDFOoyD0T8oce3ewSS9jN6HTMX/pg4+/SHxGEjI8LsJDmCxvrvD9hbiQEpHtDy2HLtizz+3MsS1G36bijIvGh1fnURxCHvCJxInUHCAQXpp7fdO+cRF6mOip4Sev8tqAocqGsI0W94mtqVZrLeyryuayZW3//yJT7HGpFe61MyZLIXU60VrnVl4h7gKJroY5PTZHAJbSCwBcyVVPJ/22qpCbxHuyTxOPzax1lck7K9obnEGYHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by OSNPR02MB9875.apcprd02.prod.outlook.com (2603:1096:604:484::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:57:19 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:57:19 +0000
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
Subject: Re: [RFC PATCH 20/38] target/riscv: Add implied rules for Zvqwbdota8i
 extension
Date: Wed, 11 Nov 2026 14:57:02 +0800
Message-ID: <20261111065702.37658-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-21-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|OSNPR02MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: fad0b2ba-56e1-4864-357c-08df3fc10709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|261102123227099003|261102124527099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1PsPRbEAR5itfgcahjeJGHksP++7GvKENXlsAAmINV1ibqriXsWQ+riurwrn9ojf9AnS8B2lENHvFQF/h4O0hspEyMDiytxTzp0rZWh63wzJ2W0XiHUR/PERfBGBMdKTruCkt2E6auAZvv+fH/Mr+JCHb2Fkk7p3hUpgDZYaw+4SWxEF+Ah/bs2feMJupo2kw8BXZIkpWEyKt9ihNzd0dOcdpD7judnvfZ7AFIJgNyF/j5ViIdtO3og3brZ8lSTCF8tnXWQhjqL0W4KS0rfhHAWtIJUpGJ/7yuoT/NmpWzN8iCQJuvpQ4UlyhHkurFyqNyR0C96PY9JX0C4L6+k5Jfy7Jq9iFerd6p4d3H5DrCRRI0loM0qB4A0RJaIR0+oLlexQMnJooKU+WT68x5XemBakrfFTgh5C2/6rYVZsxek32VJocQrMPDKQbKI34onl38PvMYmh1dVwNNzHl4L+uWMgqzIGKVb2p44jWM3iJhCxMYxr4ERdYyata5nhNsH+j88d30x86gKShSbyvtVQZzOU99PTxII8RKke9MDMbWxPT5A9R20caIAv+v9FEGHpBTNh7LW0gsEgbPZOvxsrWY48htfto27UpioJOEzmxp5cav4LwN8lKmwmNGhScDz/4jNuW4KIfgDTOlAtTQ5dSN9x7/H/mGd3RbqbpC+Vv7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(261102123227099003)(261102124527099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cI1xby9k0v79P6sfMO9asCWXnD1ujwUTcWsSEBs4eZBI+8qwrgm+SIuiiHHi?=
 =?us-ascii?Q?k5JWvcEJd6xjDCF0dsXZ9Al275x1JWKbK/G85317DlNAtKTokOqCjs/AtQIp?=
 =?us-ascii?Q?7Lo0xyLwBUJyUlJmMDjPNiblpPIa7REmJyNX+eX89qY4CeAXk/NO0YpW06un?=
 =?us-ascii?Q?WvZjq7MC79UUmgms3u0XZ+YUydB1BqhdaLYrRz2sy3O8vZiYxzjKWuHhY01z?=
 =?us-ascii?Q?V40ZBflsHfEr8MVn9Clr/MCai85sjTqVqwf6v4CUy3X+k9Lb1+Z2RJ5xUocP?=
 =?us-ascii?Q?OV8B3mW0h2B8hrJSxwIyH97KzvyDc2JvMy9rQZWl2SI4x4IdxANlKNnyVjEy?=
 =?us-ascii?Q?3KAnB4JOCkZIIaCh1Gi8ztFquDQKJ2Of00XfTglRpI28306xxENtcseJ6kGS?=
 =?us-ascii?Q?H4qDXUgVG4eSGzrTZtApaba6sgnqGT+aQVVt6nsnJ5w0eEBgUPwbIAIkV+gG?=
 =?us-ascii?Q?CHGTeT4xbsX0a5Bf5cqEB6DJ8BwpKpArCGcW0mrYOPdy+SFcwBMwrOQB8nm/?=
 =?us-ascii?Q?KMDwAvGoGGpvLDJiLAxmUy79qGBIkoGaugeBSdumLYRCEmJYx2iHvCKM8EfM?=
 =?us-ascii?Q?hctoMZIS3/NaEJyG/RnZwd5X6q21QmwttjqbImBnbgUhs4Sy9rB9dgF1Noua?=
 =?us-ascii?Q?lLkmq8Aag1L8p4oBAm5gLCmUTL2A8V/nACJRSUXufZSPQ70HXXlNBNhRek9B?=
 =?us-ascii?Q?WqBSmNafkXZYuBxKZd/bq4ZrR+fiJxHLb97VXDo62xCXNKlwo9AyH+cSI9+5?=
 =?us-ascii?Q?8m3Lktnzu4Tjwix+G68bzOq6ZH38rx6QemBffxFwAg0IvI0GzsZKoFgmxeHC?=
 =?us-ascii?Q?T4tc6fR/YDbTACB12U+eHE3667Z6uUiNxVzZaTieOg/FUGDqulCZ2si9rdn4?=
 =?us-ascii?Q?SnbfRQPYqZ07joWk3JibvxD9YWuTb363yg9cJUl/g3Z1r6bEI1SDjNQxs1fU?=
 =?us-ascii?Q?LHOPRjKAthsQDn74y/hpVIaPNIEENftEuEFUvA7Ibf0fN8iXKmBta0d6r342?=
 =?us-ascii?Q?WhLaufuKg/knAxMszdvSJKNhlCSWQDmcJSaqViAyIe+Y/nq3mnzAiItb4ffX?=
 =?us-ascii?Q?yXk5trRvvmU9WfbPpzuZme73xfdhVAeQMfGZPnBpwyXo0M3gSx6ZULQXG4Wl?=
 =?us-ascii?Q?93mFTIluLYe0MPiDXTkBRZ9tT9Tf03bHGdciAj99h8da+vzlfmaVhtC6l4TB?=
 =?us-ascii?Q?/VPbXfIhwSy/nUGbbKRWXfNhxU2wO2qx5ovPdWG8Tk+ShRft0cmk4FAYsnim?=
 =?us-ascii?Q?Fy7cwZCB6aIjOXPyh78qEAHVviMt7aDqkaxRiy/O9/AeJsiFFOKsjBO79ta0?=
 =?us-ascii?Q?VcfSFUQw48akjBqwQ7Yo56HSE3fMlVSxZ16S3mEQG2YxWkYwJGMW//bqJ2l4?=
 =?us-ascii?Q?GprrfdLhf/dvf0Suh+4kSlAu4ZAfQseuzvPCpEE109pRte4rsJbvruqxfdMr?=
 =?us-ascii?Q?rLIzcVxnUWkXDeIb6HsyKKkCLzBEftUtLGDnTTAjOEcE8Ic7ZbunbDiZhmk1?=
 =?us-ascii?Q?51DvPBRAug6dpIyeJtgXXnZQT4UEG4FHnZg8tgY+dsX259s1gXTddhu5B6l5?=
 =?us-ascii?Q?UpByiO6ylrc5okmaDKusCS0rUocJxduwziKojxl/WDJKv2d/lbofPRlpEsmS?=
 =?us-ascii?Q?szBZkeIxCTjqV+7gFqOYrRf90aoE71yAGPHIn4KNMy0b5fPJMXQnQwZSuTKm?=
 =?us-ascii?Q?kH9HkLbHDxLrsudsMz5aD6Lj5Fyn8x2f61lLSxjZvTmwMgAV2X7IR9Rr315O?=
 =?us-ascii?Q?V2L3u3ZSZaj+uu1G+aVvt8lUv0kkj0E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad0b2ba-56e1-4864-357c-08df3fc10709
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:57:18.9805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjOySwssV6jLmMcb0sU7McPo+jRGHO+lVPL5uj1DS+TmljF9mDuRHt6pXS69x+Gg4Qp9hvaTDvuePOsKh4k5wVIRHbnD1Hyc2nG0P2KtHQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB9875
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

On Thu,  5 Nov 2026 03:41:35 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvqwbdota8i
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
> index 9271f79d1b6..26d5ac69c75 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2895,6 +2895,15 @@ static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVQWBDOTA8I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwbdota8i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvkn),
>      .implied_multi_exts = {
> @@ -3101,6 +3110,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVKS_IMPLIED,
>      &ZVKSC_IMPLIED,
>      &ZVKSG_IMPLIED,
> +    &ZVQWBDOTA8I_IMPLIED,
>      &ZVQWDOTA16I_IMPLIED,
>      &ZVQWDOTA8I_IMPLIED,
>      &SHA_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


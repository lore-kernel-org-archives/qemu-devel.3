Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A7606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=F9VYdW9W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3pd-0006Oc-2U; Wed, 11 Nov 2026 03:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3pb-0006Js-Rl; Wed, 11 Nov 2026 03:37:23 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3pZ-0007Ww-WC; Wed, 11 Nov 2026 03:37:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EacCODFeJtUWWxXAuRxZM2x5Ep1f3h7Z4CmQHU1HUCnBHOo950AiQyvqb+6W953IeYcoYkiPo1gkg9vjia6r9ydyhN9kyM/icX7RvawbVpar+dkDxll6rAB/zWzRAl30HJgrNHw1EnKBBWt3Gm1DD4s4JNf3CKS79+kpRMcXeM93z41oCou+egyyDxy3As24WB68JnBu788z0S3M1IRf5cp7zz/uIVPOScsMNomL7vg4z2Q+TBWcOMGcUrVXFmoJjzHNj/Mo6BU3XI8GdLVGP0yIN3VWlqdxRzcif9tA46+FQVQmNEXmF+7ybE+xmFLR2qbse4cpiW9VJYiqHio05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZG+1gcU5s7I9LvqIW6rX8ywwzSwlD5rJZ2eR1DQhkk=;
 b=io3VMaXbC6O3gkVPMYT9TgQiB1+tpQ+srKasYBApXNim+IgfYWy7nrzvKXgWzNPj6knHNB9vE8jNjDRUHnjuO/hAfxPjPPVuTPLyfdnKcwEKHGeVjpnPD6osywZ+qc5NVZ898dgB5TSnFHCYG3zJUIqQK9AY0G2xQ7AG9ww7k3Ffbh8Xao5Hq6s5/xUtQHnOuo4s37z3zD7DGAUN5CLkn9OpMAu150wSLR1yVfvU7hI/IBJCwObwY2jXYJohuZ2Me5u0GTM+xhbcSnFEPJchVgqr+CLRBT+igLXKKsDifZSGPEpNjTCYmHCyIs7tk0ODN5HzeJls53qLiIBPfuRCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZG+1gcU5s7I9LvqIW6rX8ywwzSwlD5rJZ2eR1DQhkk=;
 b=F9VYdW9WO7dH8XV4IsQDUXnr2ofpKSqDlnc34LREZETJwda6fw1mc9Q24Ac1vxjC2XZcxJU9UZjp74xuQAq93iO/etrI5irlHZhukPKjmunSEGihnE/QXw7ZpyoSnfI8YO+sK18fN/HSa8oei/QkfHPPXlUqASWwaLbHlUTbph5wEpLkL++Yki2/6ux/ZMa9ZrPbALeoBB1nWZBKZGNYYdIIAr5XtObZJbgLfS/cz9eEIyblTNJBPbN7uojzVNDHisvcb7Ft1Z6oGiP6hvZ2fyyPGI3bHLvjKPT08IjEJKmCU5WdYiHqyIkKwZF9Yyn26v2l9k2scmZjc0rXP7rvGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUYPR02MB9402.apcprd02.prod.outlook.com (2603:1096:d10:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:37:17 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:37:16 +0000
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
Subject: Re: [RFC PATCH 35/38] target/riscv: Add implied rules for Zvfbdota32f
 extension
Date: Wed, 11 Nov 2026 16:36:59 +0800
Message-ID: <20261111083700.64142-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-36-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUYPR02MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d083d3-c0c1-43d4-6fbe-08df3fcefe15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261022075727099003|261102124527099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h0wC3N6rSpZGVR2oZDOlt3569974qTrX4ldnZeAbWaSj+QBs+udX26KlBQLrZ89X7IjPxgNwdp5EELSd6wpctVkmCE4UII+BIVZb8KTox070Opb1yaamlHjY6+oUS1/OF/qoU6QY2zG5wrjxDhOa3xXYJDVkVqVQckzvLYNgflNHSTWz3IOwoje9ifINLiPGI+O7oh9rwEqmfGNdLQznAHloBmyOF3lmN30oaJcId5eLCdXFmAuzWWhU/IpWe0WB/ZDzfaTAJ+qok68NFQlfB1k3hQGhINWgyb5AH/A1LJyteTuXodLck8sm24CeXrpMRj4Y1dADQWUgVF06fl8REeQofbJutx/L6e7UjMQVr7wfIzoM4rNBokKZmaBOu02FwI4Y2KgX7GYu4lxF32V30tLx/GgbWdPjUKb6zY+4fjQG+sL8uQxOZTBed23/RAW+8QIV6Q5leS9Y71Rgds1j//ZeJC5sKPVKWOCqQY8WNR2gUDBGeOETLR+o7ZlHplupNZkbrPKrvLWakxgixWufnqKLy+Y4IzqoU1dGtlFRZPq8kypGP5hnGSmD3YbbRUVNkCM+qkbeeYIuBzZ6bjF7abKYH1e2WspEq//9RNtE+0bN3Lz/Lj1CM6VmKX5fADHzf5prx0gOIobxejAjPzmfnaZoSM8JWGSHDfQoJirvw3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102124527099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0VhY5G54TMybP3YjhXzv+RnrgOoWDuxVSCQIviADsFddUqMlFjvGuzqiudo?=
 =?us-ascii?Q?fWZ5osVh8Z1GmAmY7Yw/kdWBuJmFUa0iS3FjaAVbDevGZpQnYoMSmmRej6j2?=
 =?us-ascii?Q?fyqF+XqMu65oFGJ6rIYChy/BNFYhe1czCWLrzOB9/jRutU0GCQAY3eMr2H+l?=
 =?us-ascii?Q?bRk7e+dsd9Xn00ve5jyg9T1xDOYoQenf6PvUNgyP9ABtbrI/yRWs0Os3z/Xg?=
 =?us-ascii?Q?bEaGmMJQ9OIfbKrv2kpVVU0m8BMYG9JHgdPanXeURucA9UXviBX9huCJciOp?=
 =?us-ascii?Q?HU4ADtZ5qCIgEaNATO3rBVsjubHmsvxVDrSLSyQ9x/oFXJKpIktsQoad8XyT?=
 =?us-ascii?Q?C/ztH6hPknytBsRN4zdisF8P2vw7npFN+EziRNRVyItK7xxKZc4Paclv7+wv?=
 =?us-ascii?Q?knR+Vc8t0TgEsHQSU8CZyVkmIYgLb4DX59pN4BpWuqivs1/xX4nKpNCw5c1/?=
 =?us-ascii?Q?tbV34uebTA7DbsMUtzyLNtmamyOzVTwQyOPe3vhybIAK6ZQdk/+TNQ8I51HR?=
 =?us-ascii?Q?sJOs9KYP3PyMGv9btyygbufiwGUGsKxRBiRiIw6TJKo+EJXnuF1EXxUbE/p6?=
 =?us-ascii?Q?X75yGH6giJF3hwb3zCbYLkXMw2EmprlRxGbX2MeAlATZupaJ1yIvuMuNrtIO?=
 =?us-ascii?Q?CvFY0ICEGjfDBAAflOw7T6Li/48/6grODXggZX2STb8CG6S7a7eYuNGH8njl?=
 =?us-ascii?Q?D9Ot1PWaeM2U/zidjHULX8bMpdY3U32MjUFlacNaW0QQjlIAnsLfhvRn8+qp?=
 =?us-ascii?Q?YvIgfX3bTWzBtYSDEPf9p4R/HopGKNUJtyMfPadlxYbmRQYT8xBCMkdH9z2x?=
 =?us-ascii?Q?slcT9YSkJbC03eYFbZjtX4N2I5VaeUBbpxNfMJNf8QLx+MBC+Ss9H98XGJDk?=
 =?us-ascii?Q?53kuq6zvS9gpHPkDIJ3LabXu0r5ismPjqiB1nISY9H5gthWEbJo8/DS6VeRt?=
 =?us-ascii?Q?8e0DNI1sCsoZTmg8BP+7k8e1hAAYP2u+sw8CGaLydRDo3hgnyqxHFF6lNtW/?=
 =?us-ascii?Q?ynO0+70jblyJkwDJaGDTKWY2TYGPQyljjILRfoK9YkBiqsRZ17oBA1xZEi79?=
 =?us-ascii?Q?qja9x/uWu48EqJ4waaD8Yrj0nD+kJtxvW7eYa3nsfxm5nUbJ4fIQKfoo5dgH?=
 =?us-ascii?Q?8YTo0X8vjPXd2INPaql20SaUG+hExCHLmDvFJZfF+3ti9Lo8bLiF3ytC3m1F?=
 =?us-ascii?Q?9vPrFOrI9uzfoOgDmuUYBB9M+P/1nHkuPp+udDIOhst2hqFSh4QWVgVvz2xV?=
 =?us-ascii?Q?bHTH1JscWVH0WCG1vP3viGn5XOjYU/lNC2Q6eRiX3FhlvQVz6JgW3BxXMgdV?=
 =?us-ascii?Q?82nd7/Gfnrb9ex6TwNnGoiGGLPXZ0Ebv9oTtiCAVA2FQpx+zsbL/JTL3uHP7?=
 =?us-ascii?Q?FHxGvMcXXbka8t8XXbIjNh0QaAmvIRPTGtxhH951pc98gEGnaFhADYUNqylw?=
 =?us-ascii?Q?64PobhaJaxIfNftPs9R2+8wB7LN9LJB0OPFK9WBPylw7b3+d1JpseuVn8BOA?=
 =?us-ascii?Q?36qiyqKGygw2WGKTlAXUivwZ14Gv1N/BJU+eUwdc9XEgjaM8Ci3Xs9+rqnPx?=
 =?us-ascii?Q?HSqnPGkmoakmI2Vti///p8cB1NotnFlUOuUOC/AyNyt6OvplGfVdtVNqASlV?=
 =?us-ascii?Q?5ftJz5RLkuU4WXyURJpHCaix2TbFZ0MXujPeAtvn6vteieCQ8TZGk6LezC0f?=
 =?us-ascii?Q?/ka8shIrk08t/hAjtsKrr0m4xxnQBTCWmWsgA9OiE/tS8zKvdGDQ9r0FQlGT?=
 =?us-ascii?Q?jMd+dB3K05R675dqQ8wqHWtuxNWoOAI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d083d3-c0c1-43d4-6fbe-08df3fcefe15
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:37:16.9121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epbD50b3xc4taNbBb8G26x6NkhTXdzJk0rzPPRJ9YR+f37AJV0Je4ldXusjgBXkFt0bN6/cOoUgosFF9DR4/ex+BA+vrLg97/eVhnBlyKzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9402
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

On Thu,  5 Nov 2026 03:41:50 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvfbdota32f
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
> index ed0f5ed976a..ff09bafe667 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2903,6 +2903,15 @@ static RISCVCPUImpliedExtsRule ZVFQWBDOTA8F_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFBDOTA32F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbdota32f),
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
> @@ -3131,6 +3140,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVE64D_IMPLIED,
>      &ZVE64F_IMPLIED,
>      &ZVE64X_IMPLIED,
> +    &ZVFBDOTA32F_IMPLIED,
>      &ZVFBFA_IMPLIED,
>      &ZVFBFMIN_IMPLIED,
>      &ZVFBFWMA_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


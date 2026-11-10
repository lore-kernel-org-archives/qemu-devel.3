Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036D60A2625
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=ZrlAE6jT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmWG-0001TU-G6; Tue, 10 Nov 2026 09:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQmW6-0001Pg-VO; Tue, 10 Nov 2026 09:08:07 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQmW4-0001pO-W8; Tue, 10 Nov 2026 09:08:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/Vli6CvV7gIQIIHdH31rGXnDFspnQED6HA2G/iemMdgDbWMlq27J4BQ9a/v0zU1Vuz623bGx2Kh5OO/mkQCC+Z/rXh8XmFHHYFSOt/7e8Vz2nFxyEuMM1D2mlGkF0GZJlH6ptxf1bMQkE7STYl2pqzWAA0Ncj06O7aq/uP8ES/T6fWU0CNIK9I4qbLc2n/i77Xn2yOH4OnfZoLK/gIAUl8WskitdNm1Q3+3YIq4prykD/feclkwRoXzUAFJEaTy8878q7KZW0SoazBclV4FEvz/e9+J/Kb8ImXd8JjKXV4POQkLcK9ZuWeF777Ur+NZZ5UW6iwL4aQhjA7Migeqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAtu74sRKwgUAS5PhRrT6rFZilaZWOIo3tiExfc3RJk=;
 b=HdacCfJxrb61ZwMAG3/Z7jBMzukqUoqWZIQNoL4x1xB6w5sxd5aTKJt9ytH7NJtIKn8Qzq0GWiIxk9kDXij3dQoTCDKFiCIp1a/rPd2KAy2E2FfUI/Fh8aO85kglDK3j07F73GZaFnOlpA5Tm86D7/6rsbGL/QwqA+TWNgNHqK2Wwa/KH9JUwV7tVT80a3OceCDWnSyIVKSusT9KOzlcZ72XM+VRJ56fQrsg85mZY1fQb6yZDEAQjTaR2iSjxzWk/JhbrD6g2IyBow87eIfeqsu8lQRnqiZ7Foyq5MMTVBhXe1dD20i2zSXEVQxT6onVRhUfHfGULicFTsTSh47fQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAtu74sRKwgUAS5PhRrT6rFZilaZWOIo3tiExfc3RJk=;
 b=ZrlAE6jTaiSxM3kkWSnV8EYQZUogDt225aWGrwNgi7yFWDn0iubulG8ydskG7fBn5TcMJowK8YGF//TNNWZDEnDgOuZZj30s3OP9xt6SkcSCQtHTh+1YgdhDngdtCwnqv+jWFfw46m1MUiCjC472zdPAgdgIqfsnPQROkVYlti9SlhaH4poSDeSjOg1A9fJXjFYCqNb9IqjM5xhl2S+d6cMZ0Po9FyPQ9ix8amfudQG7fctK65OfpQFnOd/pNwwoNXkR+5kYmVk7FXtTzCKyVF3oDGaDlLY0m2JYzvKHesCm3+vBWFfGCSTshMN95H/38W1HcWPuVV2YA/1TbsUHSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUZPR02MB8968.apcprd02.prod.outlook.com (2603:1096:d10:57::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:07:58 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:07:57 +0000
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
Subject: Re: [RFC PATCH 02/38] target/riscv: Introduce riscv_init_fp_status
Date: Tue, 10 Nov 2026 22:07:38 +0800
Message-ID: <20261110140740.36743-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-3-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:510:f::30) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUZPR02MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e87d7d-e19f-486c-b9d5-08df3f34055e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|10067099003|56012099006|261102123227099003|261028144727099003|261102124527099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: fc/YAoEePmWK2HSwmz90mcwBFeRn1I0kbsJrgWqLHdVKNkFfHAN4778wwCCZpgjM2R5QqQhHQUDgiqrzMAMS7Z/3laY0h2QJ6lghSOs5Igjbrv0HPh7h5RDE9ISTgg3wAbaf4VxRAbtF/Ppgma3gMGtpU/qbtCt6KwpnXhphCUmiljeaQ4WthETv+LOC9kpGDZ76nTZNrFcrVM2IM+8uJtbVQ077TLW2JwbkbB9/mrPfbzY9JmM0UFTx7eCVtvikKv6y/hXeLrKps87NLzabuOtH8CpShYgzuZJXj8WEs3pZHd4y7SoOOZSkpKi3eMfNK7TSr5LS7o2s4OJ2tDRMnF6Ut4IjHy+uNixkjM6nUM4U7CFsBKba2wODsZWMCIRvQNdE4r1FnY4fCr1jm4MSQenve3klJqH7y4fCtJyDj2hiiNFdjVipgJ+X/CBUFyPihFoSsjCxokoC93i1r3RyhyZeSKE36gN05LCCDY4ZZGUnRYvGQ1qzTJAzcrRzBfgk8Fm5bnH5hNxxFULumgdhgv1gh1szKuLPrRD8h1aVj/yIVQTbB/cxe9hl0zDbxVo3+bz+7y4djRTLrppq9YG2jdNbJSf7E3mXKJpjsVskpTISwC0agWx0RIO2Zjzl5LGGtLTVPugkj2QfPDNQZ8onKCxNoI8Go8lmRn1hD+84VPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261102124527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhomnbp2CCQ82x/VfccddcXhLSmnJocAnnbzwMsGCiPrL6PLY7+zzCZRIdsq?=
 =?us-ascii?Q?SxmtdmOtvgZELPDNTzUZclWa2Jnxs2rdx/0kY2+2COFCpvZ1O9l7qhAKImFG?=
 =?us-ascii?Q?5f3oh9laC/n8Z5naUztaXasxbZElY19mx2iDZSethRPjDWwc87Z8CR3TIDx3?=
 =?us-ascii?Q?sNKJ4zbY2RzSPfe7cDjKO6WcUuby6o9+FFTz3ozthELBOWwf2wR2Bm+S5kAg?=
 =?us-ascii?Q?zxpdhSDeb33j9s9tBL+fXLmw7kz1jpTHU95342KSWsdX3L1JAHLLeH0Z6XPX?=
 =?us-ascii?Q?6IKbruWGICs+BOS0cnPPmzuITPR4iW6kGxvuMIwp2D2lJNlFvtvlH8W9G03Q?=
 =?us-ascii?Q?xu7Cfqge5LasmICv3Zk3rPr8m0Xpb7dgHA2iWc8sMqedy2rvd/hbOvQ+yIp4?=
 =?us-ascii?Q?ypZC8qcwQsp0C7UV69sk2z2pv1lBRhCNTZZodA0WTbt+0z5HBUdkaGWDy86N?=
 =?us-ascii?Q?0MaeqYWPXQQpY0ZtHC9xru7TjVWnSwf64rmuhN2ci9+ITqN1DqYRLQCTrNOX?=
 =?us-ascii?Q?GsXNe/tvhFFujOy+khPpxxTfX4ewRhqr52KGiFObeuS1NHINKWPwfsnqzzNX?=
 =?us-ascii?Q?10X7Va2lRXdwymWkDGkMssFjw6igOA7Pt37lvhGLCtYlg+zzDVTzqk3h7viN?=
 =?us-ascii?Q?TEac1QPWCjcNM62Ksv8uCkb33leKbi6mPNTK9FQTFN85vcNVYZ3sSZeiANj2?=
 =?us-ascii?Q?KQCtjQaBmkQuIAfcAPU7FTFPqWeyMkyDeWsvwdqRgyf1+2RcUIOLfBmEvrkL?=
 =?us-ascii?Q?rfXKVtMn57RokTpLk41Lg8aIsSkalpP1RtR70Hao7IwJPQvLlgx4W6Uu3/tP?=
 =?us-ascii?Q?doc4fgta/BjA8xHM6nfzeDVg9e7kqO6qXidTwgONWIzypap0cvBueL211fKH?=
 =?us-ascii?Q?MzJkArRazfc0MBEvEWBMa2hpDjSDARETlb2a52dRS5eLYicKFOOQKD8nGYV4?=
 =?us-ascii?Q?SVIsLgjG/TkHg021PypU7qh0eLlryFrkHIyEN92EFTK/9YZXtXPuoebfIgXs?=
 =?us-ascii?Q?m1qL3W+kcUP50svHBZHHQfL037TU6Pi1N/R+KYzG0xTJoCb/pbVHm8jAsw6X?=
 =?us-ascii?Q?Y+bHbclsv/Kn0W7n70sy+VhpZpeoeI8FBWlu4IT/si5jHZx7H/jidjheGWXe?=
 =?us-ascii?Q?1zYTvZ53njF+lBVUzFEVdvOlfZgFRtWr/Ldy3/Et4XuZTatKm8wSK/7kS35a?=
 =?us-ascii?Q?xvMG28HzbztGh6X/kmgxegXzT1Sj6wqND3VDZmae3tu0uHTKX+v2OikfpSx7?=
 =?us-ascii?Q?0Prqz4nv35bydNpfwVs1HMoqPsy6YeADL74ekJ7+TocqF6wCd+lqhN7DW7BT?=
 =?us-ascii?Q?pjeDrpqh2CLf6UBQS4nnLYQK2E70TuQHddvd11BN9WbH3D/F0jtDS/5lJyXy?=
 =?us-ascii?Q?NFGX6EwbVpdJYUdjDRWZovY5vpQHRgTWHr3rXdEWJJYz/cdk+QBOIqRGxiVl?=
 =?us-ascii?Q?SrpR9WjPmS8hLeFR2hIbztU6+7CclQxqm3G/Hn+/5gb4E8VzrWjjHz/Z9Ut8?=
 =?us-ascii?Q?3HILApbjMSmMlu0yoV/rpAI6HERz1jQcmr1EC645uWZtTO7eiWrwTUnCZLTq?=
 =?us-ascii?Q?qD732sPBiS+6uFBtJew3xQyjM1sdFhiVZcsANmPYUErd/+HzNr3tqoSMWYaq?=
 =?us-ascii?Q?gEe5+GPwn3x8nomK+T1EQxSSEk6z+tfHbY6y8FUKQxj5VWtfXNypWirFliUP?=
 =?us-ascii?Q?2ksEJnV2RnvsHes8APKZK1FticQdZijkiRVtROpvPTke6PPVnMD2a1t0F3Oz?=
 =?us-ascii?Q?tUUKzWm3/ewqUAJT+vGK1aCe58k4ERs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e87d7d-e19f-486c-b9d5-08df3f34055e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:07:57.2463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tugwKxn6M/6ZOattFJ3kk26TXNPa9DweyNXRglw149gCuD+97J9LnD2oWhE3QaeN0mGATa9md2yiwnZSSVZlBh+3OOoA86lQKpZvBqCvy/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB8968
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

On Thu,  5 Nov 2026 03:41:17 +0800 Max Chou <max.chou@sifive.com> wrote:

> Create a function to set all default controls for the float_status.
> And set e4m3_nan_is_snan to false to follow the RISC-V isa extensions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 362e5618091..53ecce8c398 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -978,6 +978,14 @@ static bool riscv_cpu_has_work(CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> +static void riscv_init_fp_status(float_status *s)
> +{
> +    set_default_nan_mode(1, s);
> +    /* Default NaN value: sign bit clear, frac msb set */
> +    set_float_default_nan_pattern(0b01000000, s);
> +    set_float_e4m3_nan_is_snan(false, s);
> +}
> +
>  static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>  {
>      CPUState *cs = CPU(obj);
> @@ -1095,11 +1103,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      env->xl = riscv_cpu_mxl(env);
>      cs->exception_index = RISCV_EXCP_NONE;
>      env->load_res = -1;
> -    set_default_nan_mode(1, &env->fp_status);
> -    /* Default NaN value: sign bit clear, frac msb set */
> -    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>      env->vill = true;
>  
> +    riscv_init_fp_status(&env->fp_status);
> +
>  #ifndef CONFIG_USER_ONLY
>  #ifdef CONFIG_TCG
>      env->debug_mode = false;
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


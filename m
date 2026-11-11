Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B2606C943
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=DpmnLaVZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Fu-00005x-Cr; Wed, 11 Nov 2026 01:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Fl-00004z-Rp; Wed, 11 Nov 2026 01:56:18 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Fk-0007kL-27; Wed, 11 Nov 2026 01:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvn3TzKlDZg8v1LAConEn9c4ac5mpi/Jbwp0F0MVHLvShY1N80j48taA9FuJHXdMaI11vqp5r9OWvcC1E/2Hf56mQu42ttSnNvMEuFha2Ue8tmTOU9qz/9fqZyVLIrOSXZV/gCbMq2lVapZPMrjl1cM795+VIKC6MXMVBU6hZJuXw5YJn/ikRS/ueEVD9oknvOT5mh5ViXf+4XYdE4GDRbuNFT07DVY9Lo2xmaoX5+y/H93VBJNMe0W2jMNEv1+BiPkr2Bf2gZffnhP8+IbG2yDP9yDyRLZlwFYpbBFMgEmXGtrgLH5Gq03SIB6CmWR/z2wqKZEK3MF/U4LL8C8qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZnbe6BmEI5IoyY4DMkMisHTuyvS2rf5yQ4na0XIX38=;
 b=xJLsq22pqNjFw4kG+U7x6ZxTZyvbNwdG+gJbh7LSacsXn3y3/++05f3b+emJF/xYgjSNekiDQ/LlrtkcgfabaQQiiePqgo1lb61fWy+/vESm2utT3Eg/5OUVhE42rt+xeA7XYhhtiSETgZ7uv5IdtGWLlgRTsHJ7Tro/bRvc0LTl6Xsft8KbtNKkC5OL8raga9llIkSgAtqxShm0EZpDChgBd9Xi+gnbMN0lVnKcu+4AIe+Hp7i2RsSgPdnOihsejyvfZsth/4JeC/Bhl760IW0tnDIW0LUxuOnrw2OL4b+aJgBkKlk/IHwQ3foeTvJBuGua5YLXUzdCmpleRxTVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZnbe6BmEI5IoyY4DMkMisHTuyvS2rf5yQ4na0XIX38=;
 b=DpmnLaVZbURIarCE3hc0qgNvILMfWPkRMMN4kjx4wim9KvH0u1qHhYg8k/eFK3byePSBGA25fD5JeOzuyaFLWOdE6/rRh5F0XmKN6cjzfL6m12JXLjnLUMywdNSsxTjQz+Ng6sSiRZgZg+M2NBe35iShqBR9GJ+qReW9e8cMddccbmsLhWMoyqfV3yDBAtCtCQcHKZ/FKIs7F54SdcxRmPRYssC0CvWAa6uODshk9myUgg/aulWi91Ewz21g+PnrdvsChiwTYd1EFXYRbSe50+30os5uexusGmYB2CaY5H4VeFSHCmPJqWjk3/FBHb9meUxxuN6WQHIXNnzmv/UYOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB6707.apcprd02.prod.outlook.com (2603:1096:990:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:56:06 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:56:06 +0000
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
Subject: Re: [RFC PATCH 19/38] target/riscv: Add cfg property for Zvqwbdota8i
 extension
Date: Wed, 11 Nov 2026 14:55:48 +0800
Message-ID: <20261111065549.37396-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-20-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df85ae5-d3be-4fbf-a6b2-08df3fc0db95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|261009223027099003|10067099003|261028144727099003|261026140227099003|261102123227099003|261102124527099003|261021121427099003|261022075727099003|261026121527099003|261022105027099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mWVRLXvF4uiqoPpD0mLp3Y67fLaCIeNJ2pLWQPdPoLlEFgTq+bSk7phKlz9nlhM1umQS+13i4Oe6yVgvrClcnvSSztL6nLGCvrzREn+f0W/P8ilsqfHFTL05tVwLemc6MayMvR4y6JSfQQ9ig200/+zYdxudXnFBpF2MjTS+h/ew010dpbJw8u7Y6is3eMjKFIpvDfjMfipJ87cq/ZdT8th9CAIfr5zncdEpOp2vMmDvr4XlkxhLaSBfJM9OalRZrVZuH7L0XsbbfwgXHPt0mvZFT8fa5Ig+6VMxFU0nr3mcrFMWp2jUdVnB4bqcGdrQuw+pqirg7O1Mqk+95mbyva3znIE8YGPXjOD7H+rNAJWHacHPNGhak/llmsHyFs0hQGAi6cnPoTlUd+uqKyuGG16ucUi2D1MNfcCYolWVc3W9MuqGyuZCNLkaCuZuZyP7rVxmWUcsm3+mq7rKQ2tiv3Zp/LJ41gk4Q0q0AYprv2iH77vVpAWddkrP5WvvyNfYOBeDL9itYXVWW/eG6/j99JgJuluKKkGnH2Ik78T5goK3SpTWmBcccREtNtyEwCAHMTnAguI94RfnOPjtZ2tWcQw8naZ6mwz6Iw42lo6SZfqV2TWXNBJlvnFSsDNniZMbrXxW105Ku/CrBMhKm2GKgkDepIrT60npZiU/MtE5VGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(261009223027099003)(10067099003)(261028144727099003)(261026140227099003)(261102123227099003)(261102124527099003)(261021121427099003)(261022075727099003)(261026121527099003)(261022105027099003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARAxfp0fLMg1caM6Cxc3Klv2xAfNqApty9itwR2reJ5cqaFVYWwYXdzH37cr?=
 =?us-ascii?Q?rIJ3UiWJN2SZNp5oxG7mnjnVoZjydt4z3U0rziJ2mUmRJFnw34F/4OeuHouz?=
 =?us-ascii?Q?0ODb1k0onUZlFRQOoQzt5t8b3wT2QE+tH9KiYdIXtgjWYtmxKe/l0HhTexlO?=
 =?us-ascii?Q?NnoLqsSnkl96Vfnp9DpJFosa6k51Na0jjR3CDHtyFBZY7mID+S38qpqT6S8H?=
 =?us-ascii?Q?NWIu/U9t+RU2iRE6WA6MuDfZYN2VfWHUezN02V/+qyB/sPQdSprXRc12h/ms?=
 =?us-ascii?Q?LxrDeXw7j/5M+B+owI462FMuz/NUvXhu4drv5lyJPrCAaZp8FPCmXolbgneR?=
 =?us-ascii?Q?5K1U2UmMk6w+HWNmajEIyhyA1mBWMwJqBzV92Gt3kizxmYWp021KWEG8PqTq?=
 =?us-ascii?Q?e614PjCHlj3fT0KVD4GI2wrdD0NwoiS9hXg3Lqhcph3LG0nfH6zMleRKG6c1?=
 =?us-ascii?Q?vy8xNX8tZfHyubch2BKzE/JmJzOqnR6yGhnAbI0BQqycKf2+YRz0BFbBSKhG?=
 =?us-ascii?Q?BDI0myecQySj690HTZYE+YkJibV0bvoR0XLXFKfcPrBNx9N/SFhE0ZT+ozTb?=
 =?us-ascii?Q?sZpWMGnYD2eRAafUtFpokbMbhC3fKXJTyRehqIIqCcOP3hAIxYV3qkwMCTWN?=
 =?us-ascii?Q?Sak001bRYOXDSfhopqNZtG0eWIPij3c+sThDNdtGBFolcKeoq+p9M97SfJue?=
 =?us-ascii?Q?ATUEhqObkp7+ioXOkfVq2qb6Y6udxyKcSGgcEUzbxwBwsitYISMKg056Xygp?=
 =?us-ascii?Q?y0YFl4LTOG+K9IKj4giWsxpIGLFuAUMmq7VYvqvMG8cnM0xH3ecuq8pnJ3NQ?=
 =?us-ascii?Q?IuXmpJkqqeaUqa5/yXV/q8z3Ge9KwYAcuCkBZr6d2ngIdDh4chmc5DFm7nV6?=
 =?us-ascii?Q?Gar6Bc1DtJBV1TqMj+aAZ/QawUiWnJAnsB/bhfWvwmEPRwOOef1JP73NIBqh?=
 =?us-ascii?Q?k6a97EuIGW4oTbgEGqfr9es9EN7YbttpR5osi1kj/b6yT/FExv8iig61sk1p?=
 =?us-ascii?Q?1AhLC05HvFqHzwiI9nbgCLMy5Yn3N+tjw6CqmttMvZS4Ka5YLY9zS2y64yX6?=
 =?us-ascii?Q?ESGT5oQ6jqzjq78Eggo0er/OiQLfLx1Ml+hLsVs+99hcZ3T5XeD3rcp7LACn?=
 =?us-ascii?Q?cZo/ssKTJNYpm+xJOBCj+hZovACe2TuYK2rL5Z5f55HDivjF1GI+A+rs7Wog?=
 =?us-ascii?Q?LoFyMAwpcs/ZDVtBnG6NP5gcqy3i7XoDCkaj7konMUVfT6/UPM9UZZKMuJeM?=
 =?us-ascii?Q?yXjCN2M4RvsBXYdJSEn/+REU2CHodMugDyL4Ap7sQb+ftQiJtkILHcJkQDu5?=
 =?us-ascii?Q?uuXYh85CchX1AacXd1JoMbbRojB5tRvV/BvzOHJ9rtYN0okjTgVL/UIhq3Fp?=
 =?us-ascii?Q?P6rcPogI0al/C8ceRGecbR/Z8q7RAt+57nUYvDkP14RtclPAPn4Se3qGES2v?=
 =?us-ascii?Q?M8XbmBO2vR3ZtFIq7s3HkCvkKQ0gw2Ox2HqtS7UIQgS3iwVeqsugbRPx9Cer?=
 =?us-ascii?Q?UkJ2vcp8iTCnwW7sMSiV6vuoMRXayIsj93JN10WBXPVRUSZtXAQaX3gFbJEu?=
 =?us-ascii?Q?SMtfXLccoVDpTn/en7dRHvQHHLRC4ZYbcV/TbCTF1E0bsznhZ5iKeyaau5jk?=
 =?us-ascii?Q?K2fzq81MA4MW+chTtP86pVoVBYS+CISyWILIiw2+JQt2kpuTz1gq71m+o3dI?=
 =?us-ascii?Q?kDpWNiiVPhUQ4w9PntGh0yTodQto8h59j2tJkiwPY4m+CU2qre4a0AY6LNf7?=
 =?us-ascii?Q?c++TT0emDVW48UFY08srvy22RqyWMvk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df85ae5-d3be-4fbf-a6b2-08df3fc0db95
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:56:06.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uavUyBsSEVqL2BlSV99HR60gbtU2OKB9yE0ufGaAdCGbqnf0nfQV6sBJkPUdTCTw9djWqMe6wbuY6v+Is8aqZM9yLiWqPZOLrgLHBT+II6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6707
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:34 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration for the Zvqwbdota8i extension which depends on the
> Zve32x extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c                | 2 ++
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/tcg/vector_helper.c  | 2 ++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6c09685bd4b..9271f79d1b6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -254,6 +254,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>      ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwbdota8i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwbdota8i),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
>                                      ext_zvqwdota16i),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index b18abdd8b9b..3d822432d48 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -108,6 +108,7 @@ BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
>  BOOL_FIELD(ext_zvfqwdota8f)
>  BOOL_FIELD(ext_zvfwdota16bf)
> +BOOL_FIELD(ext_zvqwbdota8i)
>  BOOL_FIELD(ext_zvqwdota16i)
>  BOOL_FIELD(ext_zvqwdota8i)
>  BOOL_FIELD(ext_sdext)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 72ce0b4fbd0..782e38b608e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -711,6 +711,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvqwbdota8i && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Zvqwbdota8i extension depends on Zve32x extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 5cb44326200..b1ca584f9ef 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -42,6 +42,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
>          riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>          riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
> +        riscv_cpu_cfg(env)->ext_zvqwbdota8i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>          reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> @@ -94,6 +95,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      case MO_8:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
>                          cpu->cfg.ext_zvfqwdota8f ||
> +                        cpu->cfg.ext_zvqwbdota8i ||
>                          cpu->cfg.ext_zvqwdota8i);
>          break;
>      case MO_16:
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


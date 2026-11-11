Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD9606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=VGl9yLx0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0K9-00058K-Av; Tue, 10 Nov 2026 23:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0K5-00055m-RQ; Tue, 10 Nov 2026 23:52:38 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0K3-0001g1-5O; Tue, 10 Nov 2026 23:52:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz1lXDwVUFMwnSudKmKOiHYKcHI3GnyR5nBIpdicxvX0N1EzCeb+BN/DRdi6VNWvYViYzmXPEBYoGBhHdeVpMVC4J5l2MrXGBf1bbGkZTEkZ7eJG2+ELJ1lU6B+9NmmUDEj112N7OylYfuX/JdGCpwWEW080RTsfjN8bQ/ngeCDQy7ZVhoEGkuzrl0TeYzlt8PDXH0d/eAzrynr7vQXrWE5DnEaVpxsBBeQTERm0AAI3N0zaEUKTd1mB6KdE6amcidQ3zYW3PRv3Y3EvzVsv2zUd/9rfeillRqKNLjo+fmoNB3gcooAwKorhjs/wKOKjrsUaP0MPM6ClyM5A6VeXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHyb+D7jEWjvhWRFhOnn2xMDpILyEkoHBfgS4lXkMVI=;
 b=LpXujnY+PthGSDmshubCLbuYUiL/uaxLj8TFgpeU4WWsUrmciBhgvhAdHjJppgiXAozTZdFHwPvxq0QQXyvMBkJjc0Mhnpxebc4TRK1PnMrE2NIKXVk5AyS+DkmXJ1bE3nb/pnV0NDMu47SQf0DgyCRpK7Db/6pVWaKVi6a/CozU5phT9IDGDUWh7yB0TXmIKlnBBm5+jwg6ENfecoRgEK5J+x/45M/7oRgeck9+Dd82OHQ8S7SE7W6JmHB5jfPvTYStPe++g1xuUt50MB91D0pMLhjo3z9sbSknEEnp+mDFm0Cm2dOr57aTC+GEoet9IkUF/vW34faw5D+7LwBpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHyb+D7jEWjvhWRFhOnn2xMDpILyEkoHBfgS4lXkMVI=;
 b=VGl9yLx00LcvnzyAIU3hbyYJBftZWFXiLRedAHP81nF9ge2L3H5Qta6M9Q9N80Eshp4TYUrNb1iQqZ728d++WIWwp8iC3ct3uj8gnZ/yYDkAiZH5U4HjbSz7NRcGwR9T9sBsCVdylGFiXemQhWDWvIKwqVcjF1maC89TuM3g98i5A8NVxgLag2ZQLoCRYZLaHV+0PsEspnCywaaVYwU/Ad77+EY5MpUbUfUHgzGGJr5oN/mptRU7g1y9fw1Vq5UhQld5Frd9pu39vgho0cfHz3LRrt3I0n7RPCjCLtRWqwRZokLhkvreVWOpirKsyhgD3+5ox1mJKe8FBIUBdL7nxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB6289.apcprd02.prod.outlook.com (2603:1096:400:264::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:52:28 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 04:52:28 +0000
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
Subject: Re: [RFC PATCH 11/38] target/riscv: Add cfg property for Zvfwdota16bf
 extension
Date: Wed, 11 Nov 2026 12:51:51 +0800
Message-ID: <20261111045210.78572-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-12-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040A0.namprd05.prod.outlook.com
 (2603:10b6:518:1::51) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 049c7abe-b214-48ca-8eb4-08df3faf964d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|261009223027099003|10067099003|261026121527099003|261026140227099003|261102124527099003|261102123227099003|261021121427099003|261028144727099003|261022075727099003|261022105027099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SEfkYWJ7fYjf/GiZyZyTKcugWs+PAndD0lVyRtTCMqd5djOMxYSHZ24WOW7nr8xyUp9ZOwtDPx7tFARbUn0bVOw1qYeCa06XoPiZ5S/Uzm2vifkjy2jb4q34h2X9ZaXgs76mSrqyNtKM57Actt8StBSp8ZIDatgIbVkC6ioDIwfgf7LvX+hz+VK9PdFpAMlQSsWv7F80jiFgGdnkbp3hOkNeQbmZk5+09YzZmv9V/rlXy7R3xlC1TIfMLVQBxXykRm2AmW+dqXq30fpdFCMvzLf84iZtd19ivvIWnP6JNSDKm9qADTSOja5lPT0UBwnDBsatFCUc15TlHISOgB+mOOcE95WoYe4EsV0RSJvWbADfEdO3pnB6jixMcH5rYpv+NQGfJGCm5kLTyc/ZNcH9Ej7KfJQxwXDkhU87y/sRlQ7REg7b5rXy0Y1AVaxpSw0e/5wlXNGA9ZSuY61eV1SJm4ITjb1w9P8zcjNpmMYi663ZtVYwbPAF6nVYZZJHcaqpFL30jAP8X3yTuNoevrSFUzmXARDDFf3fNxGOvSVxML3KPrrOqgTYQlKtDDex7BUK1I1mbIa9R8j8wgFckmorXVSzJGiCZcXPgjuOgZr+T40rj3P63N9ttISQH5N8o+8l2XjuMJlOD4v16y8jjSxE5nlpgmnkkAC8IptF/7ymQ5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(10067099003)(261026121527099003)(261026140227099003)(261102124527099003)(261102123227099003)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?En/sQUuMTDvIwUx79RhlZAhfhctnWnYADKqd5DjyIEJulaH5ExK20yL4n36U?=
 =?us-ascii?Q?9jaJlA/slxlNcgM6cNHVGVRi5zs47ONnNJ1DjC7/REHZWdfKAcp6jLaMjk58?=
 =?us-ascii?Q?/MvEP3rnKjBaNiR/6//SEGsbwRUs+AMCMF/7oGXlmCRWZDh0Dn8b7GDK5qB9?=
 =?us-ascii?Q?9R46/Dsvl/JjcN89HprLUNiw6FD2HYYE4xNP6wXYJKwTd8Xin6GSUhZ1LQHb?=
 =?us-ascii?Q?YBPQC3eq4hIZ6YN1qSQL2Cl+wAlhHEtJ0ZuggCVoLli5hRc7otttpzx9dJIO?=
 =?us-ascii?Q?oWZuSyC+GbN1LIfSI1no53g1KqBX/ngzdJ2+Fvgwe8bzHTje0jaBsW7D3Uum?=
 =?us-ascii?Q?ujzHNKCvXpz1fPYLvISG3jd0Cdonq4S56DwUi960OkQ/vY5bC6oytLkCBRgZ?=
 =?us-ascii?Q?o2euBYMTcQwqPt4HOzZAZa26taucNMh2USErcVrDZxXPd/r8PzYzekAHu12R?=
 =?us-ascii?Q?o6RaypgVsLuTdt2BYHryq4aDOgeKssjAv46uCE41xThs8dujOXGoOSoM/W6z?=
 =?us-ascii?Q?b386thF/hSdyRtTf+8EXGT5uUK0XDO2z//RExYhv6J4awu/KA4dUL75S5MmA?=
 =?us-ascii?Q?M7i7GxvImVTnjaYdIwGX2BHmqKYpdj/+Ag1B+utVBC7FY6d+KKxlNeKLU5Tl?=
 =?us-ascii?Q?1NdB8LNa92TSRPYXdM1Soxd/hS/LlX/r01kyA//La4bI2zlivZwCEY+b9NBH?=
 =?us-ascii?Q?NWmnwtFwSUKH845CFJncxS3qQIi6SGXRQI1v1CC5HgGSU80AWcH+lHtqNDIT?=
 =?us-ascii?Q?+NJwPNokTUZt70oRqowTJTpN4R+YX5HURF3COGkay6lRIqVZ02gWq8Yw/s3m?=
 =?us-ascii?Q?5BeqkojZbBiIC8mH04ErWiaofElNe9L7eqM9cPDbmUnXycoiPCUt/wGwccOA?=
 =?us-ascii?Q?l/SfZw14Y+hKKlLnl6toTjTqS0MFgQ94UtmUZTNTO2gnOcVTfO5z0WawwbsE?=
 =?us-ascii?Q?3tMBcMVNKhXeTlVha7hKon3nAc2p+LirFJ387OB33CdT0iVy9j4jhGYPlZuT?=
 =?us-ascii?Q?pIWD9guHNRhf3jGR7L83kKDkU6/3Cwe1F8iQsK5Gl8yJwK4ML2BELM0GpX7n?=
 =?us-ascii?Q?JPWCL3feOWFgGIjNiQk8DeEoxBgy83uEhNqxp4UWYRsP+8heAOmgtD0SCEDg?=
 =?us-ascii?Q?vJRNQ5SwuOsaLSYhkNw45gEmLlDSxGUiQW2+35/NtT0TbK/V0Opte3P08He/?=
 =?us-ascii?Q?fDsxkUyWjV2zAYXRj1U08TSkHl0uLyxdEjgIBZ+IckxRRCiydOn4OUcZYOzL?=
 =?us-ascii?Q?YpUagvhxsKYX1K9PqDqI+oskzcrnz1isQdS/aROdTpWoyeKbi+buvcnu/KvX?=
 =?us-ascii?Q?dun0LpaTRb9PbSXeqCwRjTW/0sSznY4RrsiqgHTvsrSc6hH5jenM4uSJ7AJf?=
 =?us-ascii?Q?kiUKEXeiotRBPlCFUHtun+vE18RTZSSXnrDnzaTMfi5Wb8jrBFBT/N+tiCxZ?=
 =?us-ascii?Q?CoN4Tovq3dgRqu9MmGlN08eqknIB+yOEIG7MckmI4Y/F2LuKxyEnoqm7Ch6R?=
 =?us-ascii?Q?Vz0ef34pVA8SsSfHMpLVPbgaoz1JPHNwGov0maOMcvP7AW4BNpmF4XXYVwOq?=
 =?us-ascii?Q?TLub4PfkRzVrt2tX1qkMDjR1hjkCt1scZFC+LFSTYiOyJVzbC+iKnJIncATo?=
 =?us-ascii?Q?s3s7P382KykE8FV19gvwL1nJ7U3a/NOeTwPTSIAIgL6tyLTRfNVjbHVY6lm9?=
 =?us-ascii?Q?SN/H2BS2uFW4XaT9r1yaZYr9y2kP0Iuh0TF/SIGuOVIm/lEvN3LJ7AyaBxac?=
 =?us-ascii?Q?jhFMD6hwelmtIZZVqJiUn25g/fygRmQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049c7abe-b214-48ca-8eb4-08df3faf964d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:52:28.3981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWTzqKf3St/BTIDT6CnHvg2sveFwSQDso9XYFpG6lWD+kCMsNOdT/2v7iK9MWEaRssV/bznprOssXzvycfm2YIvb4vqM5B+EIl4EH9B4CEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6289
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

On Thu,  5 Nov 2026 03:41:26 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvfwdota16bf extension which depends on
> the Zve32f extension per the specification.
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
> index ae859128d30..d6e2b07c401 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
> +                                    ext_zvfwdota16bf),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>      ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 8bac69a17f7..30c404863c8 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfwdota16bf)
>  BOOL_FIELD(ext_zvqwdota16i)
>  BOOL_FIELD(ext_zvqwdota8i)
>  BOOL_FIELD(ext_sdext)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 54749125acf..91e009072e6 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -701,6 +701,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfwdota16bf && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfwdota16bf extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 57a381098f6..41b526d25ef 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      target_ulong reserved = 0;
>  
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
>          riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>          reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> @@ -95,6 +96,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>          break;
>      case MO_16:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfwdota16bf ||
>                          cpu->cfg.ext_zvqwdota16i);
>          break;
>      default:
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


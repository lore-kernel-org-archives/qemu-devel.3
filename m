Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63174606A33E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Hbp45Uvb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3Mx-0000m6-4z; Wed, 11 Nov 2026 03:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3Mu-0000j3-DV; Wed, 11 Nov 2026 03:07:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3Ms-0005R1-8z; Wed, 11 Nov 2026 03:07:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE6HAaYUGh3E6KE585jEu0nRem1i8FgkFIc3hwaJOH7yatG+ji+5VmfcQDtG12Wme8qpk7SHCcaPn6X2TeByl3tW6X9O/RNZoUYL7fmNoyt0A48naFMkyC7pGeQjNAjwe2fuLS6DZ+cN74ZuXHZEDamhTE5IXa8wRauwj2N6W7g7shIQeSKCF0YLv2k4PZJ+0E/p8Frt095TFhXKE+NODHWq76eZ4zWxnES17Ecl7ji/CpaU0lCXnEHR1mpbwPARJo4jxc/ZTluh87MvGW0FMK+seBSHHIaIVRUhnPuoS9zsD1AhtRMACleM2fVznZjz7zZWUtsrX2fyRnLwJdK+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D65FkJMgNQgTXNMvHlozR4kjqBBo+qjWaNrLiFyuP84=;
 b=rGpyqXGua5/tZ3FcIO27yNffA7sZtOMoSH8l5G7Zv0HIGrbVIWESGJ84ig4M+X1DPR2LUoygbp/EXrri0yBPFLlxHJv9NsYPUUr02he47lxbwcnPQcC3bm3RDOfXlohE5oKWjS5MOf8iJvFAj0NBOmQxCcgLspGw+qbGyqZblAK+aWT0Ugry248kBFoqCZdTnW9v9i5nt+QV11dInGtRLNdmPw7QfGSpjAkWF+Dm9520T/X/E8JnXMYF8pt/pSQZFpg9bDcDtRQyQda92m/bN0DeMBiKyu3fRaB1TQ8Ki58Gr6wM19FvoZVGV3t2h8t5o9/QaUeBZv7fYgTfObmcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D65FkJMgNQgTXNMvHlozR4kjqBBo+qjWaNrLiFyuP84=;
 b=Hbp45Uvba/AfBWYAGdmiHUlf7pu/g9VpwOx/juiLH7IsDUJVpmWI4W4kpdsQvBInv+GsWsPF6tiK/38dUogfecZlf9YUqK/E3UkMWvMeD/jXVzlokg16MQ8BR/LIc2pPb98/HbGJORcysrCU3IG7UY4RH/mySrGbaYvrCdi9H9tVs1/U0giG8YACLxLoNHdV4N0nYDmYtMb5FYYf82LPNm/+d5HC+qUoOI4M6NCBInNujyzIiRfRtymAYgyMblQgBI7BgTKvDUDJJwuVlSR+UPFpd8SeUNO4/XdCvQL6d+Wlzh+vYADDbyiVL1lcdQwWAhrlHDD9YkBkKQrwLrXlnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7258.apcprd02.prod.outlook.com (2603:1096:101:1ef::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 08:07:34 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:07:33 +0000
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
Subject: Re: [RFC PATCH 26/38] target/riscv: Add cfg property for
 Zvfwbdota16bf extension
Date: Wed, 11 Nov 2026 16:07:14 +0800
Message-ID: <20261111080716.48960-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-27-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::10) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3b8d83-374a-4b29-eea9-08df3fcad718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|261028144727099003|261009223027099003|261102124527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|56012099006|261026121527099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: B31mKbqTKFTLsefNI4vXCKl+rszlJlojtOvv4HN9T/m82IrZsghBFAVQFHZhPqTBzGTYobnKuc7oSHX8E0w0Y/7h+fjmWolwPAB2pNdlIerZP/wo4BA1ysWtp/JCS+JvZ2FQE5U1ZXTZSM/LvutNBF+16Jo0W4h2zXPzBl+ZVsJ/nTKL16W5ClTxIH2PV2v6ZZdJ16vFfABdwD44SBuvUmM0p0/moI8n8zFikeEpsXJZIa5ETANtvMiw8jd9J6WFj575XKdvl/iGZmZelOzwP9APZpZZ7nOS9Z86y3wkpq0rzi6jxOUMSIWEv6U1m1JnvzEhcxvqfPRg6g1uDxtT9Q0crNHLRQm9/yO7qSLENHfmUelbSktMKPUwLolKceK3CjTa5heuRDeM6XtuDl/gHaF7xHEu0OlFeTtHybhwmyhJe1o+2nNUZ+MDq3IpehO2L9a9YNz7XHjVcD8UOUbG0LoCMOtBxhwNxLDRXspoiXp4TFH3O9QITKrZukMRFwcqrNtY59B9Ksmy/nRWEIs72jP18QHudoBJXTucWzlHpQcVTZR2cmbVMen9z/9faSL4qJOsnP/v+F/lnq7FrJEHuIAcZg1Th9vih64dNa/6Yar9Xjd3VaSCLayxEfc6LyFw/rfUJ47uQPNfJrLLJZW1ZCiewVNJpZq0MoToGXOgnO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(261028144727099003)(261009223027099003)(261102124527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(56012099006)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DU1ADxum2QgwcgfKSkNIQ67fSq28Z5CSNfhiYJazgXHb/SJ/XfcRWyk0L8Jk?=
 =?us-ascii?Q?gNjeKEpxIS2a6rApOeohIiwMaoZ3FDTUe4KEnwtGcqOT0cIRpGX2sD/4qu03?=
 =?us-ascii?Q?40DILKIWLYuYLuBCQiCTyuPWVXUlS3Z09m4U0tTpQU2I/chGaO+ntJcs20HS?=
 =?us-ascii?Q?wZq8dB+W0rjKwQrWUFKlsigNeCtauJysZGjqNraFJkNvn/AAXV52nPICTtD2?=
 =?us-ascii?Q?ayG84ds8ESLMzA/hTDP1zilOgUHv7XGYPOJQrvMciSLAp3ZugQCz2QY9joDP?=
 =?us-ascii?Q?NiUvREMyOfHI2t/7KCbRltet4HJ0TIWPzSOsvdLB/DUm4VIXseCQtufFsWwu?=
 =?us-ascii?Q?vonFVx3mHRXRdOqV9DWP9P0N8FEoI/kFFo8x4X6VQDpf+Ak7KLjB0mOv88OO?=
 =?us-ascii?Q?mDz6HSF6e3J0MxyzSpvwL6SSaN3hw+jNspChoz9mbrJSTotjGLcPTrWgvofY?=
 =?us-ascii?Q?t8GUkCn09TQBdA8sSxpACN6bqtSTg23KOTZDXQL0F+SU1qvkwkzZUvjNdl7v?=
 =?us-ascii?Q?mW5xnIMNN5kzG80bPFJVovNngdsb2CtuHakJFdGIWT+hM7xXPn6TI7dMYT+D?=
 =?us-ascii?Q?hddch3vMc5a9o53V3bKQUtvIcmV81KtozDlVBGjSvCvfZQ6Z7kIGaz8QYQLx?=
 =?us-ascii?Q?7do7PyAjR1zFyQCC/+QBMxrw7HQdYUqQuUgkx/BVaAJqd54IKri1sJms53vt?=
 =?us-ascii?Q?XI0/F42MxMXrTxkkiDCsJS3mas8wMHFi0tWw48k2jnBPKQZwVc8MHhi2r7pB?=
 =?us-ascii?Q?uFMDTB7BuCubDItKMUWb61c82Vr5rZh2M7pQclY817zKkB3aJvr7Z7k36r9p?=
 =?us-ascii?Q?pPW00+9TzCv6K1teNvIR3r6G8Hb6imksn5JbB3oeccZwo64H63rS+TFVoqgA?=
 =?us-ascii?Q?SfA/1boETaaz9R+hd1OIU71viTGntw38QNfmJLs2rwx4+NGFudk5RbcYcUnY?=
 =?us-ascii?Q?AktPQw/OGavccj7dsFIu2bBSgZbAPKQUsFg+s1OVCTZTaeOVlFJGV+nZXHrc?=
 =?us-ascii?Q?K66Caw9yF7/Oeb0E6T68AOsUrlKATvvQIWAdJuMp0A455ZYRq+4xswvhHBQe?=
 =?us-ascii?Q?uDwCJWY9+83pj+gyPFQ9m/Z+klgeILo/otc3dnTiDlKGjwlKSUnOoPSp7Rwl?=
 =?us-ascii?Q?WVHEK4LIp/I8jEfEHWGMFEQPg9PHJmzreSWEheuKcIdgMKSqitG7zmRFRxZF?=
 =?us-ascii?Q?URfmO92KZCQ2v+3F209Q24itoQvV9GpU9zej/bgODD3/0pxzYsz2lwqUgS9U?=
 =?us-ascii?Q?FyxzpcmsEjjMVEjA5mt6iILtg1ncmAsbJcypNGe1LU/KZyuO69/3YhxfTN0v?=
 =?us-ascii?Q?RYyg6qLm21hNryAYzQgib90VwzDMGd3KgyzLudeMbocnaYdDkE9ra+lkpr8m?=
 =?us-ascii?Q?rgtdXkRHcA1oyZZvzIALWlxtdEPBqxxTXmlswM+jh1Fkrd4fCUKzmEbL2Qb5?=
 =?us-ascii?Q?BpVt3X2a3E/KuXwGtmd/AJkl4FYrIKzBEG+Iz6DfpFdqWcydECCoCLebdETD?=
 =?us-ascii?Q?fmBca/Pjb7BPXSrSJVcjiIuyQIqGEEeidh78D/GNuvuN0ApNiBCv1MtGse72?=
 =?us-ascii?Q?Uvq+ne6Z19djJAfGHu3ZiNWyylf/eRg+dtpfIXCtQsKVIW4btZ/4LVEE0YfC?=
 =?us-ascii?Q?+s7OM3qao5+fWYi0mh14GS0rgSZo8kxPbk8DsO2gBAjXYFolfE7kPGmV9eaz?=
 =?us-ascii?Q?i+hp1PBfdt83PZEigGlJQYFQ8p+LeWifV34iV6FQD4jM3EN1Tr1EuZQnykOm?=
 =?us-ascii?Q?eGL/qbkJ/Pbre1EUFk+EjmmTtBeLCkE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3b8d83-374a-4b29-eea9-08df3fcad718
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:07:33.6350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2J4glfmgleAm70vedTMVJgdGIFlXCimiA/YrQYK6ucywS1a5VQ/a7sZLk7YSNQMyaHd0aM5PTRz83jNpvJ51tWAYb63bkyDeQvVNr/QPjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7258
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu,  5 Nov 2026 03:41:41 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvfwbdota16bf extension which depends on
> the Zve32f extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
r ---
>  target/riscv/cpu.c                | 2 ++
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/tcg/vector_helper.c  | 2 ++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 95bba330e06..c33885542f5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -238,6 +238,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
>                                      ext_zvfqwdota8f),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwbdota16bf, PRIV_VERSION_1_13_0,
> +                                    ext_zvfwbdota16bf),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
>                                      ext_zvfwdota16bf),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 83a3d8a7f9d..80750db1ccd 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -107,6 +107,7 @@ BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
>  BOOL_FIELD(ext_zvfqwdota8f)
> +BOOL_FIELD(ext_zvfwbdota16bf)
>  BOOL_FIELD(ext_zvfwdota16bf)
>  BOOL_FIELD(ext_zvqwbdota16i)
>  BOOL_FIELD(ext_zvqwbdota8i)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8735cf94f35..8684e4c709c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -721,6 +721,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfwbdota16bf && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfwbdota16bf extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 683b14f28f3..873adf4d7a6 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -41,6 +41,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>  
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
>          riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
> +        riscv_cpu_cfg(env)->ext_zvfwbdota16bf ||
>          riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
>          riscv_cpu_cfg(env)->ext_zvqwbdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwbdota8i ||
> @@ -101,6 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>          break;
>      case MO_16:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfwbdota16bf ||
>                          cpu->cfg.ext_zvfwdota16bf ||
>                          cpu->cfg.ext_zvqwbdota16i ||
>                          cpu->cfg.ext_zvqwdota16i);
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


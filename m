Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6C606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=AwY8OIHv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnTY-0006Gv-D8; Tue, 10 Nov 2026 10:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnTW-0006Gg-NX; Tue, 10 Nov 2026 10:09:30 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnTU-0000lE-QV; Tue, 10 Nov 2026 10:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsO52yjygyDm8tVcpSQK/w4i2Ym1yH8QtQxYThqiRHe0BKta1uHYss53Q+sRDtWGh4QVkslquQAxHmRr0kw3TQUueZHHWYjX6gUWHlHuQXgl6TG7ZisiaM6TuFFsi3mfT4LU/eb/omrsfX8Zz0MiL5Gk+kxUs96B9tRJp6n0XHASaWZZ/ICd4szLLfO+hz5nh+7xCXBDSb+w/YN3UmC6sEmKLx7cmqWpyTB5IROUkSvg9Obn6sLAp4oDZYKhnkK6iu4sPRXF2TFxxjJ6yrnn3NKV60f+vwnD4bFAtEmvETr8BRDMhwSKjRnHk5M5UKr9iZm9DglUC92eC45sg/SAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRuNO7mkgq5yS6Itz5gVACGArBZYXhnosO1/iqwQnQM=;
 b=bVKTLYtB8YW6+W8Xb6uCVN8fpNskOW0RI/tyJ4WCG9XpJ8LvM6Zw4QdMjB0jWpiDAsA6v1whvW+aM2xIB5IiahV8n7JLjSdSyO99fvX5Db1MbXgOB3dT2rpzSOLnSZGa97xm1N+Gyc6h31hjI6uE/GuZC4Yae+i2hZtNqP0aCogGbcNLwGkATVUmO7I9wqaF9corY9DfE4oYZdc7yRbi+cOIpD/x73c6MwFKgd75Za4A/+WLaQyYAL5kEBIqomcIUK2x4s0U60xhuhSL+ducD0vSJ5lDoFHC5pJvCUmME7qsnBzio5f8tTEBns+T76xaD79M7b2H/lloOrM3azz9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRuNO7mkgq5yS6Itz5gVACGArBZYXhnosO1/iqwQnQM=;
 b=AwY8OIHvGXYnTcfaUWzDqvI7gLwmnhYjEKKs3skBFleLvOt/SyVhiXZbe7N3qeZ2KXP3e6boR3rNciAdxx6s/FYp4Fwn+WbR8C5X6xvcUkihS+rTPF/J8Lk0kTNAxIDk6XYUJ9DEOGWjLPPVc9w4s79dJmxo1unMMgo7rldNg7WrjiQJbUZIG5ndo8+nz+3IZBplQOJ9ps6D3hts5JAV+RmSHTfs58AIke2t4uBaJ365Z+JCuQHUUBNVfbWVgz6uJGUAnygx4jGKP1nP4aap7K3E2BEndXo/x5ZrKOB+4ate72g6jc5PnklJgcrd0aPK64onVRRfe8F51IACs0JuCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB7396.apcprd02.prod.outlook.com (2603:1096:405:49::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:09:23 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:09:23 +0000
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
Subject: Re: [RFC PATCH 08/38] target/riscv: Add Zvqwdota16i cpu property
Date: Tue, 10 Nov 2026 23:09:03 +0800
Message-ID: <20261110150905.9871-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-9-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a600177-c71c-4c55-e564-08df3f3c9a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|10067099003|56012099006|261028144727099003|261102124527099003|261026140227099003|261102123227099003|261009223027099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Wk5RURZSOKQZpCb/sW4vqNaFTfyL7GSfn30/R/LuV/Fw6aGkxh87wWQvnZJ9UXAKVnZjeUP/eDLeV0ixt//Jf82vNXKalhwc/ocV1dYndZN9DIT+9NGTKKVyn/dXzW01YuU63R94BrG/VUJyIDMH4GZ5hgdTEtWSJ5aHv1e/EGM4dNU5j54OYq1edKNIuIDVVPgr+j2qgkS7KquDgwL/3yMwwGgsCRU2ao2Iy4QdmDU4DsXGrBpieVW6R7Oh8dWSGpFU3KGCcvPTASgbXQ/hIp+T+AU80ZWwxn1en1kly3zDrWqw+6MogMK15MgHxBCGlpD4ZkI3hIUR2Ny7Y0oUty10M35aKk76sy5l+IgDVMb7XVYynVDIGaktBu/fz2NA2WLCrOCDXPGPHgANiObT+YDJVIyCoQXn4fCGMSUIIje6y3iKOEXJeG0v3GHAQ3To3t1C2qbgYHJgBReDjVHEvNpTMPPw7mLpS/MfdmkQrJHCqazJNItsG0fxYUt5kzIEHYCHU0Tgn2k7PFlU082KVsxm+QiACvBwJQyhp7FTE+g3QtNxp79k5CX6UVc3bnaHe9+oCJUusPymetWRT+DP2cqi6nuyYHKtFj1E5JSZQhpG+ATxq6DgHb0iLX1mraXPhAXmCtGevKCi3MgUzzCqKqklYSCiy4m7sw78NUH0Wpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(261028144727099003)(261102124527099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IwlJxtacmyHuuo+gke6sfT+76AyvszCgXiDlJwfu6IZ3fOmRl4EaietIXTnm?=
 =?us-ascii?Q?uvnWYbTWFDkK2L3ruYHPtLYuTgML3Qt+Qgp2oDzT1iRP3/Tj04t8uuFD2Kqu?=
 =?us-ascii?Q?N7s9DiEp12q/aI14wLLmb5nxh434KL+SgczNC7wJdz2FTUGGE0C5ZbctwDa2?=
 =?us-ascii?Q?R3mmVRUFnexOQ30zcrhMUp2ZFevz2tmGVGtVgG4NV7REsU7C3WXWn+xZdBc3?=
 =?us-ascii?Q?s7LQcxdGIsKAoUST+k0JVoJ1/r9g1k7YMqrjcmL5br2+AtHeBDAzg28puVmO?=
 =?us-ascii?Q?WMKakwzPBzJdns/luxNV/skTx8cJT/uVdSE4sXEOh/Omjp016l3nDeLN5hIW?=
 =?us-ascii?Q?qvEurvkzIYBeSDS1NhFRqPQKgT6OVnuErej7u2I/NaX2vuEsLsBIFqMqqzlL?=
 =?us-ascii?Q?FqEixqChF7fet4SnzlupQyreby/+AUyW+tH9dwUsxqbyDpllxlN0niN1cH6n?=
 =?us-ascii?Q?fOSoNWYT6JxmSQRbIeXsQ+zinL4ooJXpJFeujT8D2TyVUbOJlT3tqRciZMSk?=
 =?us-ascii?Q?TqfwW47vWOXvQF8ZoVqIi35FcCgLG2BsBF6bEFXlW7MFr4ORxzeyWXFC1MYz?=
 =?us-ascii?Q?pGaiXhD4GeDUZRYXA+xCJ+77p1q8HdkRhRxLpf7lfwZ2FOul9MA2PBy+13u9?=
 =?us-ascii?Q?xarMnU07ANBFZt+9HvfIWTAX+fsbyjrS6SqUw9/d3W7tzMhs1jKEI51LYOQd?=
 =?us-ascii?Q?yXbt+5CTHQJ+DhsSjUTzulDMYTXPAMJU29szM05fnYbtZSNGlzl92pGYrvQC?=
 =?us-ascii?Q?TWUj/wfznsnNk3ynrbuawVOA8mCYcvoyxdpwZqfSJt4TJWsKPN5b8hnGFYLK?=
 =?us-ascii?Q?cf3Uky1KiXQPw4npIGX9TDJXdjGFMDeFBlgVVzFJkKFelYFJ11Wi+XHKY0Ry?=
 =?us-ascii?Q?xDn3+Z7K8CcwFBKJHK3ccurLFB5iGi9FFVCiXaqg628vS/nARoAYGceC7xL6?=
 =?us-ascii?Q?IGfQzpeknhwoLUXD/WbhU8aaC8eRe+XXMuL/UjEJYTiDrSa0kKfWOm13vb9w?=
 =?us-ascii?Q?aG9zA3pTphIwjiCMm5FnHehNJMyo3zBcEpupkOvndPoeFFPtZEWDMn3eGkvN?=
 =?us-ascii?Q?ds/TihNvzGnAodiSQtraVu+m8+4Jo8J/cFNyv5NRcukvnwRbEa+Bpn1JEESl?=
 =?us-ascii?Q?FAb+13UeNBMXdDU5ZwTj2+rAXoO2Qe/iANChLBi+N3Ql7agwryviT2hZYYCL?=
 =?us-ascii?Q?bEBrxTQCymSmsu2UairCVT4DTCpSNd437L2Uynj0MEsVUCD6XH5DfHrnenOL?=
 =?us-ascii?Q?p0tmZPGEG6wWX7YzWcG1e3NZhlwij638YaCaVA7Yc2cFzltRskstD4DCLJsg?=
 =?us-ascii?Q?EcQPE55lV+Odpj1+WAseAtZF/MvYICX+xE1Y/iDCcQZbQcIoaZWF3ytq+q2R?=
 =?us-ascii?Q?vH1nXSTKcX3ZKHuxdiMUZ68Ihainn+U8ZJVW1SR1BjHWYl/EdTB07H8LiaYl?=
 =?us-ascii?Q?acz09ZVvnJ2nytXAzl4cLuM8bg7S8yXiITb9wmcwcXCp01Us90o1gYffCvkj?=
 =?us-ascii?Q?XN3MvEhj6OYRoqgiavD6m0J8d9KfcfWyPSe3k+nSWrKoI7o3mmg6Y3ynXLcK?=
 =?us-ascii?Q?lsF0Za554naqaZELSElxo4mzlj/X0/cJ8Ph04VnfuHzFc6AQ02xoFvr1sGlC?=
 =?us-ascii?Q?HZyOceVo0urAXU1IqyvokZYWHGOKBLpKXg56bqeaMWxJW6CI8wmHq8CmDX6z?=
 =?us-ascii?Q?IHZ5lnHoiFpkk7TmHwgWjaD8Sjud91TEMlXKnCIAf5ZcqMmNtSsGFyNi4bH/?=
 =?us-ascii?Q?oF4yL1nsBHv2T7VErbuOkTSGXctUWEg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a600177-c71c-4c55-e564-08df3f3c9a54
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:09:23.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmdcqCgGcrk1BbsIb9n7bs1neLO5D6yyIYdJebZVGoHNt2QSXOz+fXu8fRh4YjoZ3VIIfz0jtOiBgwNn+U8k6IsjCWuYaEp1VqtYLhV60x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7396
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:23 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvqwdota16i extension which depends on
> the Zve64x extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c                | 2 ++
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/tcg/vector_helper.c  | 4 +++-
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08b14782451..7873e67c053 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -250,6 +250,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>      ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwdota16i),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
>                                      ext_zvqwdota8i),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 0c08d688ac1..8bac69a17f7 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvqwdota16i)
>  BOOL_FIELD(ext_zvqwdota8i)
>  BOOL_FIELD(ext_sdext)
>  BOOL_FIELD(ext_sdtrig)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1c51ea94489..54749125acf 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -696,6 +696,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvqwdota16i && !cpu->cfg.ext_zve64x) {
> +        error_setg(errp, "Zvqwdota16i extension depends on Zve64x extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 6abcf522648..6d79fb5d299 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      target_ulong reserved = 0;
>  
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>          reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> @@ -93,7 +94,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                          cpu->cfg.ext_zvqwdota8i);
>          break;
>      case MO_16:
> -        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvqwdota16i);
>          break;
>      default:
>          break;
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D0606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=A6hahhXx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3p1-0005nR-M6; Wed, 11 Nov 2026 03:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3oy-0005n2-1N; Wed, 11 Nov 2026 03:36:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3ow-0007Qz-4p; Wed, 11 Nov 2026 03:36:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acu1f9D1F6u7T3+pWg+g65RmmVoVjIgNZOC26W02RfA8zIhopl/wwQj5PPGSH4rlM2gNJvB8g65j08T3O6EYmzpKMvh/MegR7vNN4C4ZHMesfwepux2DRJLDatT0QuWPKKLheijwCL7GCglK4uJPDxIQ9nGUpzFqe1m54yFcmgtgNFI3fNPtrTtqyokBkmlR7JaLijJEiN1b74t4PQxlBp0h5QBeZoFBBKBRue1OeQN8FtirLH+ysBtkYO2uKSH8XMI9eyJN5lXHd8wesurxQtw7Ib9STzXH44/d0AMqDRbs5e8aqJ/2Ms3H3CvEFUiVl7lv/Kpdh9Ce0HC5TGRujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUGDRKVDe8heDgWPzd24loPXx0I5Ll18Sy5053QL3F4=;
 b=ekds9C1uLwBOKpv3uN3+of9OnZNJVw6XdCweyEWIQ2f/ZBLaPj7tAxEe2iLG4301SKdj+sRVWLXZpRBluWQEUB5u0SGO0uLJVhDm9hH/Gg9AFP3rzVMQ6KwY9XXzas2KRvlVCFZdxtFSR7fk0TXTHpyot/PYOvUGTfDqgO1pJzgSwB1MZU/sxIn97y3AvhImXFKiIEIleU/0suPNdDkn+sEI4S3wKJiUihPGpcDnc40+H/DoWgu50IJh5vPEiOpy8siZKynoPXwIkvtonljmWT9JnMqZ4HataO8hsuyp548pEtPtyQkDULclK7OoVJZqdTzE+pYPhbyUvYUfB4lTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUGDRKVDe8heDgWPzd24loPXx0I5Ll18Sy5053QL3F4=;
 b=A6hahhXx/3EFiLXGQYOpiCOCfy1wCPiYXbFtC0gTXuVuJiia01K4+FJUg0ZksRX/hRIrVRjR3RqiqNCB5JXTS4DC+1B7EK2FKt2oZ9fadD8SADTlPvnu3G6fHMYNKCCb28rziIcSWGVuDUfjS7iV+ZhM4BH0i50UEIBx8A/1vTC4BBQsTi4GlPWKkg+ePuJhomev9yE8NxM5ZbyX4AArxM1/BXtaVk3yy4KiIKDiFs1hx/4EHzFfCtTHOMSCdgcId95xZ5maUBxUqHY0c7YC7TOY4sWdzti5/VTh+F82MzdbRYSXGaSza7jJUrAuQmJbueUC7evtyoQ+p1bW2oWimw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUYPR02MB9402.apcprd02.prod.outlook.com (2603:1096:d10:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:36:37 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:36:37 +0000
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
Subject: Re: [RFC PATCH 34/38] target/riscv: Add cfg property for Zvfbdota32f
 extension
Date: Wed, 11 Nov 2026 16:36:19 +0800
Message-ID: <20261111083620.63876-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-35-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0035.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::28) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUYPR02MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e2a96b-65dd-40f6-84d9-08df3fcee68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261022075727099003|261102124527099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: yd0C+1+YwywR3rOzoOspQe8eMzxkjOkDGVoivkUdQgNqUnnK0P7HVRCJtUNMfJNs9ISGXPXxCYxprEWtn9ZXPw2nokZXczgAhmMdIpZFdQ9MgzWbvuwekvy+FLuNdhwfLVpietqY+yJM1vtl2QFCB+/JjKfhr6kN9p4o25UG/yCOtsrV9/PW9iPN28ijkuor5gROhiRtjK/c7T1EsbU57lvdwifqidJmxc8qYSeCuU0IgfX7SQUR5l0QGX3FBT8UO0dxrWttb6r4wNMPTVqGHVAuWQk1Ya+6l2hTDxXmExljze/eV5nheu/cNkfuqXgC6Vu5TMcWRe0oYh9lQLiTaHGFlt3FnrR9UMNWd5Jes67TfEE2cvyExnEGNuAwtqlGQFvanW5kyKuOOQLYeErDnS9tsuc7cLkcBWx5VT0o4439RcxL1ZIzmQ53pDyGQ2wlYbkrpdT6unq22Z9Jb89EpGeHKlQaAo1aUz0TiAd9tDbib8EHM4Hhv31wgssgzCk2ThOfuWQfbayO8HgG/PyWbnyrX1pfexCeSlorKhQuyW1HKcnjSACpmwTwBUFgznDQpV3gqsxYheBSokVcsPoizJQ51jQYZEjKKPljoJsQ5ISLGBM3/AeNrCTWS3xrWbVj+BhQgtpfFziUcEBKdO5LQ3NtMfVTcUfSUvxBgx4paCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102124527099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3iHtri1yNkxV0En/qEdUN39NVBgdWfLwMUrtdv8gdBAiX9HuTkS1rui1YpW?=
 =?us-ascii?Q?NY8IerHaPoIGWKDdwumYNmWIY7X4DWJ8YwTR6kyn2bBkNX1wC9vHSPN7T7Z/?=
 =?us-ascii?Q?Ms03Yfd8CSVma7+gOopg7sEdAyFLfqf7ynWxCqRgOscc/8fkVZVpCqeEKJfs?=
 =?us-ascii?Q?1RlHzZ5EUmfEjwGZUbkN/GdXfR8FH4J08ZXhdcfhjeryqlGtEiJGULqpqZg6?=
 =?us-ascii?Q?7Xy/Zi5ZNJPrLN5NxFVzmu6OI6fRdPzX1Pr1BVXgDTnveEyORGjh91snKVVO?=
 =?us-ascii?Q?8s3N/azb05UGBDOn2aIa5Zxg3cgn6M3IAC1/M/B+sH+/2a22FrzQZqGKGG7Z?=
 =?us-ascii?Q?joslGmwRVsYz543cX6AtpjmFa7j+wo3O3q7nOUJzkMl+27/as9Kt686RHz5q?=
 =?us-ascii?Q?Fm3sBqGzz6QXXds0ZmvPb2JmxGSFlKX7ju+8gSlIlnbonR2MAVRZEewHn1zD?=
 =?us-ascii?Q?knn8K+OxNho9DMwEfa5AOeSiUnfW0H4eYFb1bIIa/ZdS8gUXlbw4OAm/USba?=
 =?us-ascii?Q?OQSOOZrkh0cw4aeGynMhaq/2RTnNgiyueHO0mor3hoCyqZ5E8NpeAyd8m5Vr?=
 =?us-ascii?Q?SUtssVeX9E5CC4g8Y7oVph3q6hj1PiJtwCDNeCubzHXkwVztisOamdROkRQg?=
 =?us-ascii?Q?+u5YmAqIRGKo3CXM+Vl1tSgfRouSKBLP3sxiMHr8/t8kH9KfrvIxXMVSr09r?=
 =?us-ascii?Q?svTKlrt8Zixv1Ni2XGX/O0+fL0Y35g5j32Y/HM8TKugBsjN8ZJ5pTtxdNECV?=
 =?us-ascii?Q?5+phzZXzAkNGa8UnH7rbD9CO2GQkHXzYuulh1P/VaFKJO0T4G42pKdskL62N?=
 =?us-ascii?Q?deLMhpwKIZrq4dIu1VUFhcsMtnJtmvLRtiG0EQ8/xvDO1isuFRgcFa8eTjrh?=
 =?us-ascii?Q?+9JGRJNuzgssRyWPONaP+5L1JluU0COHeQfiCcPoITtf8kQK3JPAfMXTW2eC?=
 =?us-ascii?Q?VZB1TkP+j5mW+AH0ISatXzbNiY0zJLmHoeNMwKUBAN1ucJUsTDNIUCy4ZK+T?=
 =?us-ascii?Q?P4rddKrqUqoP2MfFlOdXP1Hxv8k1dVPfMPxjFhW8MfFtF8w6ZhjG02ruHGmU?=
 =?us-ascii?Q?7Ev/FUwAg/5ffXapdfUi2HklocplNwWUG5HsiSacYKWkUvQa2Y28VPBlTNQn?=
 =?us-ascii?Q?dU6s9CwPnB1IyXK/QTviTG6m/QkxIkX5axfipsToglBsKij0ULziMCn9S1n4?=
 =?us-ascii?Q?fL+PMT2t1Q3NFyIjBCqCSmX/QHyPoNhXDKrhhGXfzxkQqLx9loGy8bjiR5hG?=
 =?us-ascii?Q?p9DVgMa5sADrF7fSF9bNSOhPbHm1IgkLw/JjAXcExlLywOlk7KKJR2Lq0gvh?=
 =?us-ascii?Q?7ZJg/2UBRITVtLGQP3VsylZTEbveb0wgnl7O8TU7YoCbYLEZwqhmWX2Qiafc?=
 =?us-ascii?Q?+ed7H+63YFbR9GXdlML8ySLMzVI7OOCBvv9DWC7sYIYEhP2qqhhK9ct7QRNz?=
 =?us-ascii?Q?tM5Vd3gq+wbF3cOJWxp5+Rlqu4qaIHOHGw+/XspTEpUcBHBh1bvkVUitIAjq?=
 =?us-ascii?Q?HqBqUq/0kiBEU3hlBr4klJiiZ8B6550s0rdoctl1FhC6qyUYYKtR1ZbyP/K7?=
 =?us-ascii?Q?QRZ2poyUAngd7fstK4I0N/xV7J5ocHQiczBtVRuCO6m5R9KwWfceNvcnUNkb?=
 =?us-ascii?Q?gO3rur0otOuRYSNFjwAtrrE1KxxNhBXwbKiWlmdytTSrHeygaoKpdO2UzHvv?=
 =?us-ascii?Q?jqgBIEZejeDcOCPyHNB45hv6BamQFnS5aa6KtKjZNgobKrqxsJu0JuoJZoCU?=
 =?us-ascii?Q?EJ4oywy2440+JV95EF5FcUpBakjjoRw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e2a96b-65dd-40f6-84d9-08df3fcee68a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:36:37.5207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgCcg7hpkNkLkJJTnUqbA78rfGrQX+6CsjFs5TJdEqiB9wOIPNwsEfhDf51AJaACAMLAH0cPXXsV8fSNuMMMN6eTgD4SgxWnjSMYWzCDIk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9402
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:49 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvfbdota32f extension which depends on
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
>  3 files changed, 8 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0a35bc7c416..ed0f5ed976a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -231,6 +231,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>      ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>      ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfbdota32f, PRIV_VERSION_1_13_0,
> +                                    ext_zvfbdota32f),
>      ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
>      ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 0385b58de0a..d85dd2cfd53 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -101,6 +101,7 @@ BOOL_FIELD(ext_zvks)
>  BOOL_FIELD(ext_zvksc)
>  BOOL_FIELD(ext_zvksg)
>  BOOL_FIELD(ext_zmmul)
> +BOOL_FIELD(ext_zvfbdota32f)
>  BOOL_FIELD(ext_zvfbfa)
>  BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a52637f5ca9..32b6f9894fc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -731,6 +731,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfbdota32f && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfbdota32f extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


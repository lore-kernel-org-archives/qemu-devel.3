Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF29606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=TKumd/1T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Pm-0006GT-UE; Wed, 11 Nov 2026 02:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Pj-0006Fb-6t; Wed, 11 Nov 2026 02:06:36 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Pg-0002Ae-7M; Wed, 11 Nov 2026 02:06:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e141ysol6Ht2/EzqkJXTYVLmP+DoIKalzDG+ZZNgGyhUlSKKYKwsdSxZ8DmtgJTdnJfm9sej1h4hrKzNX9nDmstIgywZHbSX0Nc3EABeW2q4edYr7ahPD/0BWnFwyNYO3/qYw0B0+V8dk5q3goiVOrz2wLmP3zk8YLec1jCMpLiS1sE4ftG8oNx55UEmixPLXPQQQnMNSWk7MTJs0JXrZpEvwBGQt6swHoKDqumIcBOs/NQ0CWotQH6yQMnkfvRNkIxfAkFI48Rzu+SuBXXLvGsj/9LxwY4ogt+81oVY43Tw8gv0eZ+20rHpQyhjeqZS/UyLDtcSQNmXS7nijfwHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWsEEHRQGGhwlnAThr8QuX2tXhXmZ8JhFwO9vHy8dCg=;
 b=kl52jhtspv4OW0G8BIe6KH4DQiLBoz/e+I4Quh47wtrMepMgHqDHyGf/KUOg4jm536Zz4UVzl/EsRDjvDXvz6jMRFRdZhMJOiS4kP7t/VZ9PxVEfAX9dUWZ6h+rSr2PfEEeOUy1v4DrsqJ+Q6Vs8JR24/Gey1plZ02mU0djF8emKxWLRa0VGmInJSOP+aLTp6oUdfVazf4rvI1VRrCo7K6a/bSXGY3qfiXK1gvYvPjwc2ervlSlJq5PoIsHTI1+N+He6+SHKrOkRXkufihqVjo7Vf0UB/McNBpOkaFruuNWhjjSoqYeFpvu7SLp/RhWDa+HWUOsGue/e0n9VowncHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWsEEHRQGGhwlnAThr8QuX2tXhXmZ8JhFwO9vHy8dCg=;
 b=TKumd/1T8t9dv14mk8X0Z6ceDTFrAimOGHuf1vn6AxVF199U+hpY9g84myqRAajvWzFhab5Fd/fqSun/E5uGk9GodFgmx53DLBftRfmJXbx9/VR42HbQjW2onOjRSjGrXEm8D13Zfu2Dqzjyruf/W1+KQjcfvKjx52Y4k7DQz8RzLGBjUmDegAR+VyaF5/jGdvfUubI7WApCS7UbnP5dGLaUDWUh6OpkKstJJWZGBUGFLPCe9kPMNlsBcywBsfQhO9f3cUwVw1MMkjxH2rdGaCWZSZ37f+xdbfBMJpuq7hkHzwT1RS+08fEBZ0Bq9qOPFTmG3Qa1vwvrUugsIv81Dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9600.apcprd02.prod.outlook.com (2603:1096:d10:a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:06:19 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:06:18 +0000
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
Subject: Re: [RFC PATCH 23/38] target/riscv: Add cfg property for Zvqwbdota16i
 extension
Date: Wed, 11 Nov 2026 15:06:00 +0800
Message-ID: <20261111070601.39495-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-24-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f0c89c-ba37-470f-a916-08df3fc2485a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|56012099006|261028144727099003|261022075727099003|261102123227099003|261026121527099003|261102124527099003|261026140227099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: LOJ8q0XArRVp+9VZCPbMCIJiq8Q0Ucs225iqCcrbpzkAb7Ww3GplgKJhE8Qv2OKBpM1bpXBs4ME8OJ/jziqQTMedaUTOfaDjwOr1iapGgzQOiIa+PrEWAeCNeqnvsKmRCRMokjoUgcV+JB6uAsL6yHyUaJ5TqWKQHRbxbLl2zo/neBKlLl12k4BVXxF402y+mlOCxgocykZRG8sFaeLpWYggCwY0XTKhVRsTJVRUuHcWQVf/EsFq/jz3b88zyONQQeydwj2vt2kzR+aaewr2CSNZz5aNou7j2uVTelDlcdiOvwqTnus7xtMJBnRv0homUt3vs84mapbauwoqTEf30/yVLq+75v37Yx9NIDqftty8WfxF2qJgrAny3+srIsywptqztkaNDL04nChacbnUylhdrV5nSC/4o3RLwBaBSx4lnOnemy16tYQwAncXwLekNMGYxrj6OeD4HWm+Iz2nd2D3XwQV1PDjkVTJmyjIHlsMaB62vMbH9Jc551eYnfYK273ESGpCM7k7YsXq0Da2i+UtrKB7G3I2rD+VI01xO/BEdgeLLdsuDfu/iEMYiB7FkcVKGKdhQpJ3GQowkyxSDJDvepY69CPoU03zkrMueJs8gYkL3T/P60TZu1xY7zWmIsFtOPmi6csSA8RY1jGTFBNSbUM3O6PetTL2gjgU4/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(261028144727099003)(261022075727099003)(261102123227099003)(261026121527099003)(261102124527099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9Syf+cw4N/XXS7Eql+XorqBRbBNnVR850JoYYiu4GEfokkx53dFUN+fTZ/+?=
 =?us-ascii?Q?ktnJIzNUVNIvASBEknwUyh67YcpnoC6uUVSMh3fYm/xB1RZKyC0j40RcDOrs?=
 =?us-ascii?Q?cZOXmpBw7q5eipsSgUL3N5ZL2Q8IDaOwEnhQISODFZIJ7YBf3VlF1fRLW/gP?=
 =?us-ascii?Q?tgGXl7wjvPvYffo6mFWIgxE79CXa+2EXRt52Zvvy7cUxkCV14Chh8eBdDxMO?=
 =?us-ascii?Q?RjH16oXvYX/0w/HycqltPbXATtvaLNrjhFCtJE6s/uQ9qRkz8y3vvlm9+e8C?=
 =?us-ascii?Q?x5lF1ZGuJaZxXj8udYE0mDGEW/fMvEDQgq6CReEsHm1iXlD+gymve3VbiYV1?=
 =?us-ascii?Q?S9ujsQ/XLyyASD3kR00JRR7Gi7SSWGSVUjzK/fz1R6RHKunvzQJJwJCGS29i?=
 =?us-ascii?Q?7IuMMQRzIDTxoBladVYDNkdSA3biE5Uv+fGYdGXZ+IJihW/DR4P75cEYObw8?=
 =?us-ascii?Q?M/pdEsKGW/O2JXnnzI5XA7Ax4ISiRlBt64YTbaxr29Rm/mmDncn330wQ5C6Y?=
 =?us-ascii?Q?B1+hbzktECoDSu3gtzOvgb7dM5PRveFf+cLNTod3GMMMWXT8P3BLTC/vODkZ?=
 =?us-ascii?Q?vG0/YzEOkPNpu08XSMjiQdNo7yQqmsq2cZoXylsI3XzaZFOOcIhkt+Bt1dAs?=
 =?us-ascii?Q?4raHbAZIjmrtIgX+cFrwQoDEv4wDQ6hpHLlDyeDYKZ9JzsmhsDhJ2/7pgJON?=
 =?us-ascii?Q?4U5Zfn87UoKomnFmEE34C+JBZmbrpdqCnEg8aOVJ1enZUmh5XyCkz2twPxD0?=
 =?us-ascii?Q?aRKb//zIhNRsadA/5P7DwjOQlMUAJBeIqRMec6mrVEowLO4NRoui4ekVWnTd?=
 =?us-ascii?Q?p6vD/Xyovon9KZyawcvMkG0CSNI/Ltzn1uCA6EuTwLZ3c47NRphzPYa4Xx7Z?=
 =?us-ascii?Q?vANj0tamYC3+NwTEsQlfy07ABpFdOZThuKRqynVPPJP2X6pebKEbim0cnHHZ?=
 =?us-ascii?Q?gTostfHMr9G/UkVG3vT3nh0a5WImBs2IMesW/p03+xAqRZZOsjw8XIxwqzBt?=
 =?us-ascii?Q?/6LWv71jDpLWw7MpAeESViNUbicwtYZdWWDjFHhCb7l3C8Jw0f1jKoE9IT6C?=
 =?us-ascii?Q?rrklcnLYMztmhh+ZEfYfvqQgHCBFONc+3fXnNyHDLigyMCL0UKi3SI749sm3?=
 =?us-ascii?Q?FzKLQzc/lBnqWvioQ0UQsFb7YOZsoT+D1N1VZJz9UxQNbnV3xRcy+nIyQvlI?=
 =?us-ascii?Q?4fZNB5tw7wRDfUC+DOx/GagXIdGx+xuHRobhE2ndNNQZy49HHrIdiIXmbG5G?=
 =?us-ascii?Q?TFjyu7ZW76LFbJyRlPvCtd8QN7ZtFBGIhhKYMhtCE26omcD59VudlrMSKY7R?=
 =?us-ascii?Q?Y3BLEbCjoZBFJ+u3ZSZlMKrvfc1Id+wwy+ApNVv5fKvJgW1MI9okn9+6Cw+Q?=
 =?us-ascii?Q?CMPnGwEkvdgNyhesaclVjDdLXtnf1SlEV6Zi7HmBcdZ83Wo9ScE03fcbKCWu?=
 =?us-ascii?Q?FRTFIrWxbB2wKj66edYbemIp8cikSGfLySo19a/zxsR4pBrWZfwy5aKxlNc3?=
 =?us-ascii?Q?lWi2ABN2QD7Extx/c4ASbUkoDLbtT3cYC3zc6Xz7ygl3xFUyHbxq2tBc9HKU?=
 =?us-ascii?Q?r5mY4g6HIx+pKFizCoQJQToP0TbbUeT9xQPO1UaLhz9/DSTBCn8FKVh65g1u?=
 =?us-ascii?Q?iPw31LhEGDvPpxjgiGMiJaFTwYKyBsFG5EFAUxW8w7ENKCtISvkv4+rMZ3A8?=
 =?us-ascii?Q?xXorthf1lbD27YCCIqdjcrC5PwKhW4Mgcq7Flkrie/JiBuIUsJHvcsa+b32u?=
 =?us-ascii?Q?DmMqPowumsAPA+26e2M74D+lapXCowE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f0c89c-ba37-470f-a916-08df3fc2485a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:06:18.1702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq2BRytogkxUAjAosgtLeSHXwnZwI64oT25I4kP2zUs94/8h9AWtJF6moBotHfOFfUMGW7TaqagIDay1rEIOF34pHKSCRNVh5wJEyrOjZKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9600
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

On Thu,  5 Nov 2026 03:41:38 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration property of Zvqwbdota16i extension which depends on
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
>  target/riscv/tcg/vector_helper.c  | 2 ++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 26d5ac69c75..99c82b898f0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -254,6 +254,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>      ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwbdota16i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwbdota16i),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwbdota8i, PRIV_VERSION_1_13_0,
>                                      ext_zvqwbdota8i),
>      ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 3d822432d48..83a3d8a7f9d 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -108,6 +108,7 @@ BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
>  BOOL_FIELD(ext_zvfqwdota8f)
>  BOOL_FIELD(ext_zvfwdota16bf)
> +BOOL_FIELD(ext_zvqwbdota16i)
>  BOOL_FIELD(ext_zvqwbdota8i)
>  BOOL_FIELD(ext_zvqwdota16i)
>  BOOL_FIELD(ext_zvqwdota8i)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 782e38b608e..8735cf94f35 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -716,6 +716,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvqwbdota16i && !cpu->cfg.ext_zve64x) {
> +        error_setg(errp, "Zvqwbdota16i extension depends on Zve64x extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 9e872eccaeb..5ea073b6d76 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -42,6 +42,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      if (riscv_cpu_cfg(env)->ext_zvfbfa ||
>          riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>          riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
> +        riscv_cpu_cfg(env)->ext_zvqwbdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwbdota8i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>          riscv_cpu_cfg(env)->ext_zvqwdota8i) {
> @@ -101,6 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      case MO_16:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
>                          cpu->cfg.ext_zvfwdota16bf ||
> +                        cpu->cfg.ext_zvqwbdota16i ||
>                          cpu->cfg.ext_zvqwdota16i);
>          break;
>      default:
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


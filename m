Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B745606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=cQGiQUeH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnJ9-0001wF-FJ; Tue, 10 Nov 2026 09:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnJ7-0001vk-Nz; Tue, 10 Nov 2026 09:58:46 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnJ5-0007zw-LB; Tue, 10 Nov 2026 09:58:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzne5AZ9/53m3dKGuIe+0WJJF2jydXYMjVa4lnQWuCARYFzajp11+kN+A3LIKnk7BCiy3ViVMcqGFN09lOErVYZkEtRnmiSxSZYTy4zUDgINd26El0aD19tJ/WagjiUIXwimCnu7LxnzpNnAu2GQ0lKoLVml3oaFgAahf6NZSFRmjJ+syWR4wYalOMy1VQSH1896NBuPaW+8izxGQib99L6K/ybB0QcxH08sTSPhphvcXEulwmswJfIn4YVzv4WIjelJnKvv4P0+0Fw8fFgd1wwBrWPJ15YQQ6KNWzypNaZPdcrTJEP+tphs/5M+NvBUj9PoKulc6P+eSUxbI6t0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzuYe09Y0ODgswSww3AoPJInL/PbJHkNCMq2MR6msd8=;
 b=QagnQ9WGto+xB4Cc/sm8bDHhvpMJYT5S7pZfgdBavE2vYAeM6S/FJVq84f1Vmn9Wn7sdv+MrBL1xsZCrE3bjCuw5YeKhDPUC32416QkJ90x77cAXvZ9gWRRydpT7Sn6uYlRSHRByv5tZhqqUhcXVLqvwLhPWHNrxEakJ0Cb5OaUyjHtrSaAvTeCyBlYPzGZZBOgp+M85GU+a7qbfVntzyDX/9CdKi4EDCrYXU6aQCBY5aM6nNItDI0EDsT/FORGOYN2r42pbWC8hlGaE6RA8sD75FTt7VjrduvJs2hpX1OgiuI7DkBod1pxXq9xozRlRigMq/unpkht2w9VHd6WQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzuYe09Y0ODgswSww3AoPJInL/PbJHkNCMq2MR6msd8=;
 b=cQGiQUeHs4zMHcoKQgtmsW/V1eWw8NAUT5zgsIl/j+bD44NbLzCEzQThsAip1PygvMPM06AHMeEN4VA6kK8xR1ga9M+XRheahw0CQrqI6meJOsCQO8gepAm5x4R+oP6OnYHo8z4DTyquZoUHPqOd0jUGXZh9NlYsgRL688ntJMIAVxjNxEvPCxW+HtU3BPdBDHfD3BYjrnk0erNrCUU1vDWYj3z4P+l034BSDnDt6v6i0VHcV1e80WjEEo/W5907QVTtl8evISLNIgPjnAgmg/BngeVwtUbIoTVQimjQisbiy8KMKAUWwiZ0zBAcjgV6m+28qmDQHtTP+y7A9x9faA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB6901.apcprd02.prod.outlook.com (2603:1096:990:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:58:05 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:58:05 +0000
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
Subject: Re: [RFC PATCH 04/38] target/riscv: Add cfg property for Zvqwdota8i
 extension
Date: Tue, 10 Nov 2026 22:57:44 +0800
Message-ID: <20261110145745.97732-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-5-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: b03acd06-4474-4064-2180-08df3f3b0550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|6133799003|10067099003|261009223027099003|261102123227099003|261102124527099003|261026121527099003|261028144727099003|261022105027099003|56012099006|261022075727099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: MbpBP4EIW6pC62/prFpOSQ6xvgr7sNDVQNOo9Ua1fK05N9DklVpHGWRNdtDw4sf9Rklnu7z2hFsaFtXt8P3V8ad9V0eREe2JDLd/u6C0jZstLtcLc4IoAZxxdVB0WdNHllKTHHMWzNt3xExoxI+In3ZkrQARVE7guJcvMJV1DeqVpLTzp/JMORTwN513HLLoSnLtsN4tXNCKDPB3wOZMS4B2pXqJLgyUobm9d7L4hZknKsOU9pa+WAmb/S9jYnsusgLSZHA1GjvOFVx+mAmMNpB5Zr23fDcr+W7+VngXegV1mZFcY/Q9s9BbHvTotVWkak8R6eakH0l9qq69M7vPv5PGCmC1S2SAxbCLHNTdC2iHWwA2xA/UZOZQSWdLqyIkRcnOELuAOOSsL3JJFZ6uXtEkgolMYSXP17SqNgLt3tJZEZmV3nZRETC3Tl7q4vBR+V0nqMZiJAu6B8SK8ElhQyZKMgU6GEBbuz9MinVE3M7q5HE+R36CjK3krpwM37MxgvHhbjRKZLQlzVsrCUpMufytn2IVWiLzQ/AoK4By1TUi0hKmY9tJsP0sMy3iJeRlou5rtY/TEFSFpvK48IXEOqZ+Wq+e4NWnAF2v+fUamyUSv/MdCGg8mWmiZ91l0u1uqWgejWJRgtF2Cz3M74StaZIK+65xr0Q9KsJFTGtyNrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(261102123227099003)(261102124527099003)(261026121527099003)(261028144727099003)(261022105027099003)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNFc13HW7G/H2/AEpTDLfapHX6mgBux+6IwXS5lSVVkpa0oEiZNGfbBRwDAj?=
 =?us-ascii?Q?ZqdVs0U+mQS2yoKUbF2j3L1Far0tr9L/oyxXYG7JOqBKgVgKAPZukQ/tDanb?=
 =?us-ascii?Q?gJVdXsa75DQ7uJddwKJ0DBij3mHZ/yYoyUFsc653LAqbueQ5agZcbl99th5r?=
 =?us-ascii?Q?ycEI7Hwi5uAKzVL785PxIj8sz/uCAHXXqk3C1y9FOtFhOvXlFzdckUeL1Xri?=
 =?us-ascii?Q?4hbwIt6mssBm6RuPYw9pkd46zXXv24E9c5CKGim4DcvBYHk4Suza5HtDqS6o?=
 =?us-ascii?Q?dKtM3NabXR39RQjQemNfQBeVj6ntra9Vor27ubRHdeMTBT5KPPA+3skAAHmG?=
 =?us-ascii?Q?2D1MY6MKEZljqh+Lmk0t1yqECpKND54i4usIDH6+cgvJtB7Pvetg8gmJIODa?=
 =?us-ascii?Q?8thoTtGRT/6njPBmLiJ7SwEcfWUKldve9nyTrNP33LDj9QtlhZN/bAt5CzfY?=
 =?us-ascii?Q?c2iK4O5G+j6Wi4Zjy11VNVqj3x/Na2BMoKo+dCo7Zoj18ctVssNjmlYcdB0l?=
 =?us-ascii?Q?IxDO577KYWUjJ4ehDy84/fOxBEn6RW24xWKRKyaQacE4xjtkb2FGv24skqyy?=
 =?us-ascii?Q?fFQNfOnNnqI1uXzyFUeI4+awVY4Hpg9jWh9pC6zSgttGxBqU3cUrpI1PF5e3?=
 =?us-ascii?Q?096oTZdVa/h4zpMHnLbDrbd0QlvWCUNqFlCMJhrQDM/wWF7GcquvLiHVgwr+?=
 =?us-ascii?Q?Qvcu5Co77226kD67w1mmciQLMAFueISKyxmFH/TaOUekKPeEGMDaUpc2WnJ5?=
 =?us-ascii?Q?w4MR+rnISCXHuBgjWrOJy++B5cbttFPnOEvr0NiNKWxI8KZSD/o4sAVs25+A?=
 =?us-ascii?Q?NkyBC3BCCyrzUBaqgmYJCmSegFKzNYnbcM40bzIv1K73w89OE1OU7uGYtEpt?=
 =?us-ascii?Q?HALHKg4nzhTh9tRqU81vBJoA5/1KjYrQy8IcgcTmCqzOfu/kLd43CvaMG9oy?=
 =?us-ascii?Q?wF61ReYWgSK/EuAxNnAYfzO73782kps0XqW/Zw79hhXArsuPKbHRWF/3+UEL?=
 =?us-ascii?Q?MU5tFwt8kx8L4mzN+hrC0aPbVXNylo+ICAbnxDzOT/Ub+ExJZkHCXHPnSxSq?=
 =?us-ascii?Q?Vh8BXsuok8O6eKDQnwbt0Pxun6nbZc4GOv6NqUP7sQgAYhPdfBPgkyRP+YOS?=
 =?us-ascii?Q?bUvInJcOWBWGYOmyWcU+cSAMb1IP0Z2eWu3kSX9Ydx93avXY21ZzHgQp7Ll6?=
 =?us-ascii?Q?Unn88hthbG1QBBeBdvBpzU8DDW85xn+pn7F7u+Obq4rg9aJe2LmbODrb99No?=
 =?us-ascii?Q?2cCW1PLU631JtMAF8lo8XzvsXvUVZ6QiK9C0ykBeaIY2bD6FT1cCQzvHEBVL?=
 =?us-ascii?Q?K5biCfvNVYqtMdtQnHM7Rb3T34kI9hqd/1FFS0q5P0hDBCHd+0vBCrGH5kED?=
 =?us-ascii?Q?Cu4ZyTLLWiFjb0I31wjSX/00XGOe5O2c1ooRGvw0mlIOhKlQjxsDkUGKNxwP?=
 =?us-ascii?Q?mZAft0WZJmWuPS0eV/jOl7ZMaNiWgTtSeY5FHMNre5oLgUTFFcivytVyFZXB?=
 =?us-ascii?Q?Ew5Xq6M1loXR1sanEsDK2v07U0SYShsZB68mBmk+YFR226B1t9TP7HcSv8uu?=
 =?us-ascii?Q?9Us7U4nthb70cb7LPY99+2bZoa4RzTVlAqpO3GhwLQ1KtyN386oQttQsEFVY?=
 =?us-ascii?Q?znaCZXba0wyoMdVlp1ti42WJ4yZQedbZCNuzKV5QCDlb+zwjB8XytoNqV9lV?=
 =?us-ascii?Q?WddCxkmcM7MBtlOQOu4MGAJMF3DNdzn4Zddt0yqiPX507IDC3ZlFCTGWB66A?=
 =?us-ascii?Q?ssPzw05P0x0PXCyb91UnlRZISEosBcI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03acd06-4474-4064-2180-08df3f3b0550
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:58:05.2490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63oCk1tAO+x+UWahgt0o2srOh5zKFJeVkFIykaM0gxYHRiuq8LT2Q93hx3MPRvOTKqBIfdWOO1oyDJKp3YGOq4eOKUY3oUOoSU+Z3d4jPo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6901
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:19 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add CPU configuration for the Zvqwdota8i extension which depends on the
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
>  target/riscv/tcg/vector_helper.c  | 6 ++++--
>  4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 53ecce8c398..96a1d76c5a2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -250,6 +250,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>      ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwdota8i),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 85fc3ad8bb8..0c08d688ac1 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvqwdota8i)
>  BOOL_FIELD(ext_sdext)
>  BOOL_FIELD(ext_sdtrig)
>  BOOL_FIELD(ext_smaia)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5834ec1524f..1c51ea94489 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -691,6 +691,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          }
>      }
>  
> +    if (cpu->cfg.ext_zvqwdota8i && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Zvqwdota8i extension depends on Zve32x extension");
> +        return;
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 172ae0f11dc..4ba0a89f4b5 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -39,7 +39,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      int xlen = riscv_cpu_xlen(env);
>      target_ulong reserved = 0;
>  
> -    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>          reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>      } else {
> @@ -88,7 +89,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>  
>      switch (vsew) {
>      case MO_8:
> -        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvqwdota8i);
>          break;
>      case MO_16:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


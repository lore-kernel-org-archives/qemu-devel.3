Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE3606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=I28jhzQ3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmax-0005s9-Kf; Tue, 10 Nov 2026 09:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQmat-0005oQ-J5; Tue, 10 Nov 2026 09:13:03 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQmar-0002Xv-Km; Tue, 10 Nov 2026 09:13:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plOTK1AUAv+k6Xpk6cpMEgW/8b0mkp1d8X3jjGg6LsMFErbEX89kHcxhckhdFueZVe5ZrE8fbH991rTjYUAxjWQJXN/rIjHuPeAlmQ8KSS0kaDabt7Vk/VPtETBaUfwuncAbe3tmF81fvN4+z2uGvd9XlVzVQl5gVnLBfCRdpn11wLohrblhKAHp3rhfTmn++9WeV3D+UrhalAGQQe2kgGinwj38c63u23Zgk9F7US7IcRVE90QKfjygdwBHFmsmIlrR43e9fJORybXwrSYuMZH6027nRb0nURiJotnaDLDwaBIIbhQ+p8g6++2rN499ytaFXGsDqQvNuICgo6kEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQUf1FWcHoP8geyC5ZSPmi9wtU48e/PBvA2xyVKYBUs=;
 b=AUK9NAsx8pMxu7AdJ2A1elDzNEKStdTbYiT6BFGOiAGisQbktVGfOlpVPdgJqv1nnhmNu4D4bi6hsHrO3cgxj+VGgOugfzfUJH/2s+PDzVnolqsI2Q4S3fNmbYpiPAQeq8Q+JMXBU+CHxZ8Jq5ymcw7IcsLzDq5Z7kTXiAX1EoEG36IKK7ZuDaMgvU7j8fPoRZIukUB5ny5JBHPE3JqdtuJ5zDLsNYgBJA+v+tgI6RpahDEvmieaVliH4FwMQWJcDQkjAmpguaLGm9ta7BsZsem5OprdbeI2bZdyCAWN88bwxjue0ELaEeLDSWpOn7ogZF/roewJHdz2lccCO6orEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQUf1FWcHoP8geyC5ZSPmi9wtU48e/PBvA2xyVKYBUs=;
 b=I28jhzQ3n0kryLGzYK3NlPKCtaS01t3u+GvZlT0SYhaBvzxiPq81k30PxP1n9awNPB6yeA+UeeEKoxAunz64HzPcslJ+ImnpXxzLHssIJuqoRFlBkjjvDjIdqs3elVyv0xpCbd6A2ljRbdYNOqYGA9kC6qba8rk4noSFQZHPJCwDkftOw7Y6GVkM4KaSrOnNTwW2JDZguxY557IVlVsmeD8a2N3X0jx+q4PwYj1JvCJQxuoJQ+OEiAWkwd/TUkWdtC4OZfWF8gWWqi/AyvPRlX9W8mdMrm22+IG0rLqRxMqeSwt+MXdu28lv4immZLKSz7X2fxC2uJYhi0C92sUH5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9477.apcprd02.prod.outlook.com (2603:1096:d10:a6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:12:55 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:12:55 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC PATCH 00/38] target/riscv: Add Zvdota/Zvbdota families of
 dot-product extensions
Date: Tue, 10 Nov 2026 22:12:35 +0800
Message-ID: <20261110141239.46244-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: c6758f66-cbd0-4f72-2a73-08df3f34b71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261102124527099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: bEk2iNpKUeXE3buvVs7QMIR3Pst0TdLbikKK6VjYw3nZuOwAtBeJW/eC2lH5VSrfo5OKnemkFrrAogIT8EN/JxIQ3wUce4sZmxiBPlSSVuQs3r7e7KUKpa4sxhhYCHs5u4bLU/8Jn+zd765TZ+2czpE3vx7dxnMkXb9hyEnpqJZ9VNhBOzQTxS5CQ8wDW9x6YNtITUC9zzgGp8oApJSNtU7+8G80HrxMU6JJOSVPLT7g45wIGihPGTbyQ6v8K6AWX+JdMs1ztcKxLY4McEkX+a/2R9KmCgfmu9a0cwb/XCWZGKkkLOTMsJAA47KgsD8FVQSLeiofIUzQSgfoWw4aI70ve4VZXfo44k1ZaeRVsyP76CPP5b7THXE9h6K3j4Xnc4H3oBazp96bjzoqzGpiU6xEJRHIrg2kTdX/1p5KVxmJNGSM4Mk+cxQA1EgXGeeadVGApVNVSwFk+j/16qveFCk3un0Cpb42jZZ9/Rj+3TNRc0V6EOZ7FhOvmYRnurp+TUAsZxY+d/6/IoxSEag8K/1uLlQVQZcRDM3uHJ+m5522kC1Z5ooZuOGEHLUkdgkLrummYogtsfwG6QILsPR0dLhucZSFHkxjlO6/vdZJkTLHOw2rm5howUG2QW3l8vXf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261102124527099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ub8bDRunkekuwHkV0V2tKdjvsA2ptzzFVDtKwBXD4UE8FSgaKhyh+omtdrb?=
 =?us-ascii?Q?BPj/SyBgB4weQDQgc71Eil6X5l5N9ZNR97D52ani9ESC6AaM8rycl5dj7FSO?=
 =?us-ascii?Q?8amOGS1y9w78rTTJZaWrigqavdozb3SmaS9wSEWufRUxSdKhzYWHFgcDvQNP?=
 =?us-ascii?Q?HhHfDgpt6UGO1VG3b9x0ltjfEbKeolLFYdmNkoF5sqJTOPMc03/kx4As1tLe?=
 =?us-ascii?Q?6cACYO16AzWFx6ZHviyGOSP7P6aW9K2ERmziKlDRTRikvU5n/fxkU1NS/MKF?=
 =?us-ascii?Q?QBITpu8o55TSym/0Jc4c83xs8+jxexLvcm8BV9SJLZip7rm8QledBOvpIg54?=
 =?us-ascii?Q?wlx2DnDumx64/a5rWM4vYPSAy1Tlag0GGKGYOmzxCg2WdquY74NofiBz1nxa?=
 =?us-ascii?Q?+AYNNlkJfFWRzjiv6JAA2zwvVmrSKVyQDEOyRsWchedu4JpPZ7V3jbRQ8Vu/?=
 =?us-ascii?Q?zS2CY3zBbm2Xk18dzeArpTMLd4PPl9DcHQ6oVPPC5aRnRh8wRB/l53WMbxdB?=
 =?us-ascii?Q?QijOfSQ7sJA5hjyTITOQdO7PZ+kCA27nqX1ZrIDZEeCNb5Zr8VHvtnAJkd3D?=
 =?us-ascii?Q?knXFuzqf7JKXpUdT8XvTJIqweJ3gGTz03ilm3BlwmZEkujVzjXvi+X8KncQe?=
 =?us-ascii?Q?nPgKg2O+44Jf/1MiJjsJvhwSeSlbpTiQW/ZZ080ZadDq+mZAHus4r7YZveWZ?=
 =?us-ascii?Q?ax5xQy4YChgEL6VSXve/Y/ekas5VrBJaWNzM8CjRifhsHB8SQ9I6UAenRy/z?=
 =?us-ascii?Q?zE34kwkf3qhMrTrXG3QbHSHMSLd2I2nPD+T5ovO1DGP/qxvkVoeCgESupmhA?=
 =?us-ascii?Q?eHSUn4fLlGlybiKzLm4hxKxXILEZo7kjdnaN63FkMAyAsQKSVbe9+BJRR8OS?=
 =?us-ascii?Q?wYatWwlt+xtSjixpKm6Sr/LZhLThhG9mSsTWCo/qg/7Wssgl01M7tP0EkN5v?=
 =?us-ascii?Q?IfR9NpVDkEpui6r1xwX3FvGzFalnlb9W7JHJWaBBZf9eDDO9TZYL4T9B7mbf?=
 =?us-ascii?Q?SyfPs6BnrLigak4Y5uOQNyQi6I9cabtiJ4Z/fheYaDiXJgipod/7tuTwIww4?=
 =?us-ascii?Q?EZDgXNS+SxlQinYdCwMNsTeuNj6rEQwWaxrUjz8pQdtxUlrzlkazvisIDFsK?=
 =?us-ascii?Q?Ak4sHkAKOeGg/TNyyS3Nb9ljfdkaUVjGxkZVQiK5NdShy6PC7voNRMbC1oVP?=
 =?us-ascii?Q?u7rU6MPXRnwKyi1u5M4K2RhvWpbZTY5zIb3eFgS6zTehFTzl0XlOJmi7HujS?=
 =?us-ascii?Q?8GDaOZiOM9xYDCkCrKmqGjX4n3z2hM+kAVglYbLf7VsWbgCA/W/SIwQUi23O?=
 =?us-ascii?Q?U2gnbwvzEuwHd/gmf7ZBQTuxBdv4gL484T389A1N6XhS2iC6FbCv0+aFPgBH?=
 =?us-ascii?Q?fIZJL10KA3zsykoNI6+xzZZyWEYGZR/7kZKi3fRCnbnx8+x+q8nOFg1D8Jom?=
 =?us-ascii?Q?VQRd5LtPJ9t+A3RksTAgjgHvDh7WWIeqRD+QAnzff+JtibDbM0YmFKWEfKTk?=
 =?us-ascii?Q?NdmUO7QZlC6fD+TbIrDEtEM8g9ImlSMdY1wgd7I6ZnVBHkT+z94Z3i4/AO/C?=
 =?us-ascii?Q?0VlGHRBytr33ZOELbbD+msw3a7Q7GnP3SeGnOIfLAu8DiOKF+KkA6oVnDKNx?=
 =?us-ascii?Q?GipVBTyTrT+1e/O/knTwon2KJxl6EMNnN59rCYI8k+mE768jNsMb2skxQwfz?=
 =?us-ascii?Q?t3YCv01f2PDjtkGbtWIerh9/JeZB7WzMZXYGN1I1lN8LvDhV9u8gXJWCa5r4?=
 =?us-ascii?Q?PqjR7DTJtUSBVeUzkijzrHumCndGxsA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6758f66-cbd0-4f72-2a73-08df3f34b71d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:12:55.3644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZr7oFe076VRKg8g4WjBNf/jl3+z4YKzqLSl0qUs0TIVJthxzp2lm7hPM0TmJwSfOV0/HGPC6frPpMCsNQihjQKwVtH/HteFOyeNGyP27d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9477
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

On Thu,  5 Nov 2026 03:41:15 +0800 Max Chou <max.chou@sifive.com> wrote:

> This RFC patchset introduces the Zvdota/Zvbdota families of dot-product
> extensions based on the ISA specification
> (https://github.com/riscv/riscv-isa-manual/pull/2618 v1.0 commit: 570e32e)
> - Zvdota: Zvqwdota8i/Zvqwdota16i/Zvfwdota16bf/Zvfqwdota8f
> - Zvbdota: Zvqwbdota8i/Zvqwbdota16i/Zvfwbdota16bf/Zvfqwbdota8f/Zvfbdota32f
> 
> This RFC patchset assigns the Zvdota/Zvbdota cpu properties as the
> experimental cpu isa extension properties. These experimental cpu isa
> extension properties will be replaced after the Zvdota/Zvbdota isa
> specification is ratified.
> 
> The toolchains support Zvdota/Zvbdota families extensions:
>  - LLVM (after 23.1.0)
>    - Support v0.2 Zvdota/Zvbdota extensions
>      - https://releases.llvm.org/23.1.0/docs/RISCVUsage.html
>    - llvm/llvm-project#196467, commit d25ec4b84487, merged 2026-05-27.
>      - https://github.com/llvm/llvm-project/pull/196467
>  - GCC (reviewing)
>    - Upstream patchset: <20261014093604.829234-3-jiawei@iscas.ac.cn>
> 
> References:
>  - riscv-isa-manual PR: https://github.com/riscv/riscv-isa-manual/pull/2618
> 
I've run cross-validation tests based on fp-conv tools [1], and I haven't
found any issues so far. Looks good to me.

Link:
[1]: https://sw23.github.io/fp-conv/

Tested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> rnax
> 
> Max Chou (38):
>   fpu/softfloat: Support OCP(Open Compute Project) OFP8 checking
>     functions
>   target/riscv: Introduce riscv_init_fp_status
>   target/riscv: rvv: Introduce RVBNA algorithm for Zvdota/Zvbdota
>     extensions
>   target/riscv: Add cfg property for Zvqwdota8i extension
>   target/riscv: Add implied rules for Zvqwdota8i extension
>   target/riscv: rvv: Implement Zvqwdota8i instructions
>   disas/riscv: Support Zvqwdota8i extension
>   target/riscv: Add Zvqwdota16i cpu property
>   target/riscv: Add Zvqwdota16i dependency imply rule
>   target/riscv: rvv: Implement Zvqwdota16i instructions
>   target/riscv: Add cfg property for Zvfwdota16bf extension
>   target/riscv: Add implied rules for Zvfwdota16bf extension
>   target/riscv: rvv: Implement Zvfwdota16bf instruction
>   disas/riscv: Support Zvfwdota16bf extension
>   target/riscv: Add cfg property for Zvfqwdota8f extension
>   target/riscv: Add implied rules for Zvfqwdota8f extension
>   target/riscv: rvv: Implement Zvfqwdota8f instructions
>   disas/riscv: Support Zvfqwdota8f extension
>   target/riscv: Add cfg property for Zvqwbdota8i extension
>   target/riscv: Add implied rules for Zvqwbdota8i extension
>   target/riscv: rvv: Implement Zvqwbdota8i instructions
>   disas/riscv: Support Zvqwbdota8i extension
>   target/riscv: Add cfg property for Zvqwbdota16i extension
>   target/riscv: Add implied rules for Zvqwbdota16i extension
>   target/riscv: rvv: Implement Zvqwbdota16i instructions
>   target/riscv: Add cfg property for Zvfwbdota16bf extension
>   target/riscv: Add implied rules for Zvfwbdota16bf extension
>   target/riscv: rvv: Implement Zvfwbdota16bf instruction
>   disas/riscv: Support Zvfwbdota16bf extension
>   target/riscv: Add cfg property for Zvfqwbdota8f extension
>   target/riscv: Add implied rules for Zvfqwbdota8f extension
>   target/riscv: rvv: Implement Zvfqwbdota8f instructions
>   disas/riscv: Support Zvfqwbdota8f extension
>   target/riscv: Add cfg property for Zvfbdota32f extension
>   target/riscv: Add implied rules for Zvfbdota32f extension
>   target/riscv: rvv: Implement Zvfbdota32f instructions
>   disas/riscv: Support Zvfbdota32f extension
>   tests/tcg/riscv64: Add test for Zvdota/Zvbdota extensions
> 
>  MAINTAINERS                                 |   6 +
>  disas/riscv-op.c.inc                        |  12 +
>  disas/riscv.c                               |  26 ++
>  disas/riscv.h                               |   2 +
>  fpu/softfloat-specialize.c.inc              |  55 +++
>  include/fpu/softfloat.h                     |  70 ++++
>  target/riscv/cpu.c                          | 121 +++++-
>  target/riscv/cpu_cfg_fields.h.inc           |   9 +
>  target/riscv/helper.h                       |  28 ++
>  target/riscv/insn32.decode                  |  25 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 305 ++++++++++++++
>  target/riscv/tcg/meson.build                |   2 +-
>  target/riscv/tcg/rvbna.c                    | 185 +++++++++
>  target/riscv/tcg/rvbna.h                    |  40 ++
>  target/riscv/tcg/tcg-cpu.c                  |  45 +++
>  target/riscv/tcg/vector_helper.c            | 424 +++++++++++++++++++-
>  tests/tcg/riscv64/system/meson.build        |  12 +
>  tests/tcg/riscv64/test-zvdota.S             | 343 ++++++++++++++++
>  18 files changed, 1703 insertions(+), 7 deletions(-)
>  create mode 100644 target/riscv/tcg/rvbna.c
>  create mode 100644 target/riscv/tcg/rvbna.h
>  create mode 100644 tests/tcg/riscv64/test-zvdota.S
> 
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A7606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=UpF+nT9T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3Z7-0005LO-RC; Wed, 11 Nov 2026 03:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3Z6-0005KM-6V; Wed, 11 Nov 2026 03:20:20 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3Z3-00059l-Ua; Wed, 11 Nov 2026 03:20:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wF6TwHTOvix2l0HkF+8Ek29Yx7xu2044rHB5/7PtwCBcKBu+UAf/UXKG/WQZCZVSQZWF/Rvz9cAmKuLWlXRZQyPbrJisB3yEmcRWNX2cVC3YYOIymr6EOz8xs8Gkyoy7iZDQq030x1TclrFlFtdG4b6cpp2/5uRqgcszCvG5wan0/AQyUwTwjolTHqua9+Kv1OF2yamLAjHA3SfWU/HGaaNzTY1acjGDj/baPul/qbqa/XMlWgFHtPDX4bvzVjl1Z8iDFvFmNvy9y55VkPIlEi2DCMIrGhAZUZOFi1e8UL0HibNqXHag88MX6Z8H/G4QXwPCfLHizyO9ZjEdWN/aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2pbf1Fpwggx6yO0uaKDuU/Wa1Sq5L1feBkR2nuUtmo=;
 b=n+/Kezdek9s6Qkx1fwDiPxLV2HobjQxMT8DxBFFkrU1R+zaevUIcTR/27IVYFWTgM97bgmmT4xnCnTXmBhPg5oCEKwmHJna35yp+t4uqewFVF7IQ8ghLuDKa+QRamJS06kmwZ0jFMEntaQYB3J7FL3rvvdCTqwyw2H4gklZ7/aVgBhMOgTQQY3Zfnx4ax3k8b2wgtwbaaPPrBODh11lt73nAPXottsa0Il2hqN2AsF7NHUtTPHf+3NdgmbN6q+hZVoAlPuexiA4d9sJuxK+rYaRlbNnMIlBE2wE0dgw35mEVqfy2DvwqBVhQw6aIKXpp3rmy3hV62VhgY1/AISJYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2pbf1Fpwggx6yO0uaKDuU/Wa1Sq5L1feBkR2nuUtmo=;
 b=UpF+nT9Tk5ofYLq2GIuxnR2LGTjeYVbuqYcuwPAdCZmXN4qKtkikyfI37CsJtL4HkmLcYZGZsEYGsjIHVmNohDXkeEcMyD4LdhnR7A2m3nKvLHZQGNSGxxByS2xk+LjvNGg9IOcZ8dgIMUWlSG2bQh9cxa99mnfmAEa55skBuT0dPBRh2ykhQD3dSolb1QaiCOfopCSWLQ826afADI5/Rx9w6qtn84acd96ol0EFEPusZ0fT2U49JNiaZXEpZ23mHVZxfkp0//YNhjjc4S4wSbsvJslkO0qaJ9+n4uj0B+RLFmUh5yoa87a4+f1iWVRlYZ/s9oO7XDfAWnMigH4d0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB7810.apcprd02.prod.outlook.com (2603:1096:101:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:20:12 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:20:12 +0000
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
Subject: Re: [RFC PATCH 28/38] target/riscv: rvv: Implement Zvfwbdota16bf
 instruction
Date: Wed, 11 Nov 2026 16:19:54 +0800
Message-ID: <20261111081956.57896-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-29-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: f761fe39-a790-4f20-6eea-08df3fcc9b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 441f3DvRi0OLAsS//BQxvrC3OaCZvyuxF61WBdfMv1tmbsnXPDxFt3lTeT3aVsi53qPaZDQCeyNtqk+FrjS5hmi6RhcDx3w+c0p3nOCBiLXdaePhYacd3pQUPlFtvEutyNBHVpbG7pZg3nL161i0RXJZDHumJZfEZU1dTlV0hUiwCAhKzThaNjGxYhv18EuzDCyneKqBjGnX8sJCoHOKD9vcR8brNVSqGXzyC/MnNEPX54oVojCaomqcRLxRKpUHVyYyveTEBHuv7CAlMiFGe1r3JDHT7gt5bRClrqrQDIX9J8X4oIPLYOuOORBIR9G02ksD6cVJJE6CzhUvXI5uHSpX8u+gLQINem7CJX67lEkKJi9RFRhAlgtD/KF1plw+C+9+jfjShdizcOfSYjfWBjOpIubPJ637nYlkehyzxYLgY/uvDGFgX1sLRl0ME7mVxVVc48DGb6SNjGQ8rVDXh4ENEZCdW/gImUTTY/RKe1A5xeh+Mjzx8Sbw7B7KcDSdNqSXBROg43fkbtiwuAvUCmEil0u9+cNnko6JJ9taxRAjipYxN0rxY0aiXmwPHC0Kb1evJ36Jgd+WPlGIOQcXK86qs/ioq6GxdQ10U349rRuYmiDbVi02lQEHGFpUv8p3ORml9+VuIiowJCKr3Hg9q2xsSBhvvImRHBuTig+wsKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pea2ITfQn7x33XejNS0375OOkR+FDmjAhpdeO62kJvC9/KZHjaXQ2l9/fVgq?=
 =?us-ascii?Q?jfv4z2UNDeD9qDWot2+hcv2m9OuMgD5iqx2Re+dbs4GzY1123k2Kedkhs4Pw?=
 =?us-ascii?Q?ohdWX8WFNrtt6INDuvqg2UcjUdr3s4t4HvcdEcm2Ky21Tz6Q1ImHIjJZA6A+?=
 =?us-ascii?Q?MpwIjxReFrhDVSiyTGjj8dWHYp6+c7tMPQAlnCHp4thQzbAoXeloOWwPf1lk?=
 =?us-ascii?Q?1h8KVFF9tII+z9Cl2z2ZtKgKUt1rlPeffA2cpwcL1gPjEFxf68MowZNmSuMa?=
 =?us-ascii?Q?EQvJkdX4Y7frGjiqSGUaZMkKxhuk7ayhA/nWkzfk5mE+hemkzRL6Ad8FC4Qj?=
 =?us-ascii?Q?UNCDnIfTfgbOIsAw1FFd9h3BCD2e4mpboKKnSGACrvc/STL/xMRGjYcfp+NY?=
 =?us-ascii?Q?HNnNiQiCSfuzemJbYIzNmb9Vor20YbTsmEFOkrwg0Id7CZaIvRfUOF5zN5ER?=
 =?us-ascii?Q?e/ZcTchIY0u9d6I79UOSd9VXXnoyg5woCDCpiBRQYxaQ8X7FcS0W0Wrz7hMb?=
 =?us-ascii?Q?PslAkkZWXHBE/hEK0I0AacYlZiG63rwRsr7tEzOSts/z4991UhlKCH4B+CUH?=
 =?us-ascii?Q?b3esaUajsq0eMkgfnT9s5i8/kBt+AqMbcRDdsbeZLwCXgt7LaC6i3RJ57wpY?=
 =?us-ascii?Q?6AzWiGVhVGusD19w1LcLuRxEa1qcNKNM6fFf+quU2E/d/1Dl+XUFLU8dpdYY?=
 =?us-ascii?Q?eV0f0ab5WGqqiWCMYDr4rso7HgsUtnX+UYSm+mFM/sRkVIFvRMekUrzDLVsH?=
 =?us-ascii?Q?8VV6d6i8Ox3tSsULbsm+8ckCoFw+5QYnNj7gQuAWZUV9JL0s3475+x5IsEGF?=
 =?us-ascii?Q?1hv+9OLrmlrQXWKD00aJ+1Hn7KieG8Ic0C1PuDQcOR7WFyD6TmdK+pplgSZb?=
 =?us-ascii?Q?RthPTMiqjtvpObdCsyhwBhs7ybEvEXY8+J1h0wWGjK9JqoeUlhs6waYexBGi?=
 =?us-ascii?Q?/Q+IwZu2sSYQlRfWD8ThHOhOfrM3QsVpCqespy9P4fBV3lGexLPtIGQRYhtU?=
 =?us-ascii?Q?+6L3sw32V3dNmiVKw++XtB+ytXMXhWawF9+LnTSxCmPu923TyKxGR5Kt5jLZ?=
 =?us-ascii?Q?HaWqw3/ZpQEYT68uWWKq9uz8W0aYgNRSu+yepYFCABr+AZmeUt3MIXbn5dVw?=
 =?us-ascii?Q?vmqNZg3H+eM+RzvBr9UkL5jbp2a+C9fk/ztq+FF/S/uslRr+KlTo3gOXp/u8?=
 =?us-ascii?Q?lsc5A4Ja5CHW3wgpHjTEMY4BK8HPFlUL0rJhTO5Ed6Tevr6UbZEoGRUwlEDi?=
 =?us-ascii?Q?pzZLuyKBvWf1T1EmaP0hjkY4yjhfPCUI432RgUyIj9C4mQCdy0WtheYocyin?=
 =?us-ascii?Q?zP7GkGUvpRu9d9f7E1XhvfrOqAaeIbVyjl+/o6ywb7C3VycBYnpT5Rp+z98V?=
 =?us-ascii?Q?4H/I82zqz1pGltWeRKOMUNqmE5uNER+jKYxhXXD5YRjPnnG1s6obj1TVYWmF?=
 =?us-ascii?Q?mzmrd0/9hbF8SdWvv+AzcWlIAwywwQGaoumAZpkP8VQP8XDpveoLHdUhvZTd?=
 =?us-ascii?Q?hutFJx45Kfb/gImd2RpbOC2toJS6yLRrqsV77m3vLDWqgqBIezgx6k+Xckkz?=
 =?us-ascii?Q?RpJ/B1slmQZfWkz0eWh99Z8/oRlxacX/JYOKmV9hr9UgU0bnP8ofVKgGexZ0?=
 =?us-ascii?Q?nfFXIZJnZqrr73GeLxlbzatoCuothbRffPrqP5AZb4RquKKk4j44SbPI+3Bz?=
 =?us-ascii?Q?oQvfzOy51eW57ZyH+e0A/DLbD2fb4xHDmuPr6R1aQI72Lc5I+TnmaL1bB/+E?=
 =?us-ascii?Q?j09eVzshga8tPX00RSF98xgGjh5nyHw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f761fe39-a790-4f20-6eea-08df3fcc9b49
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:20:12.1905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTlitR9EW4ACcKBIgErQmVbRk4VY3djqnzvIyTpCVOZZNo+NFHFxtm+B9Lwzs3prY9b66+WU47x30qmMsNlWZurZe8IkpeYx09Morq7XFAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7810
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:43 +0800 Max Chou <max.chou@sifive.com> wrote:

> Implement the vfwbdota.vv instruction from the Zvfwbdota16bf
> extension.
> This instruction performs a batched dot-product operation on BF16
> vectors, accumulating into FP32
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/helper.h                       |  2 +
>  target/riscv/insn32.decode                  |  3 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 52 +++++++++++++++++++
>  target/riscv/tcg/vector_helper.c            | 55 +++++++++++++++++++++
>  4 files changed, 112 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 84571a999f4..1f2dfd6d557 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1395,6 +1395,8 @@ DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>  
>  /* Zvfwdota16bf - BF16 Dot Product */
>  DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +/* Zvfwbdota16bf - BF16 Batched Dot Product */
> +DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
>  
>  /* Zvfqwdota8f - OCP FP8 Dot Product */
>  DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 8a06547a570..00ed64b73fd 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1105,6 +1105,9 @@ vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
>  # *** Zvfwdota16bf BF16 Dot-Product Extension ***
>  vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
>  
> +# *** Zvfwbdota16bf BF16 Batched Dot-Product Extension ***
> +vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
> +
>  # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
>  vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>  vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 650affc045b..d4678171ac5 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4365,3 +4365,55 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>  
>  GEN_ZVBDOTA_INT_TRANS(vqwbdotau_vv, vext_vqwbdota_check)
>  GEN_ZVBDOTA_INT_TRANS(vqwbdotas_vv, vext_vqwbdota_check)
> +
> +/* Zvfwbdota16bf BF16 Batched Dot-Product Extension */
> +static bool vext_vfwbdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    int32_t sew = s->sew;
> +    int32_t vd_eew = sew + 1;
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvbdota_base_check(s, a, vd_eew) &&
> +           (s->cfg_ptr->ext_zvfwbdota16bf && s->sew == MO_16 && s->altfmt == 1);
Please use s->altfmt replace `s->altfmy == 1` as well.

Otherwise, LGTM.

Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> +}
> +
> +#define GEN_ZVBDOTA_FP_TRANS(NAME, CHECK, EEW_VD)                       \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr * a)                 \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        TCGv_ptr dest, src1, src2, mask;                                \
> +        TCGv_i32 ci, desc;                                              \
> +        uint32_t data = 0;                                              \
> +        uint32_t vlenb = s->cfg_ptr->vlenb;                             \
> +        int32_t vd_emul = MAX(0, EEW_VD + 3 - ctzl(vlenb));             \
> +                                                                        \
> +        gen_set_rm(s, RISCV_FRM_DYN);                                   \
> +                                                                        \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
> +        data = FIELD_DP32(data, VDATA, LMUL, vd_emul);                  \
> +        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
> +                                                                        \
> +        dest = tcg_temp_new_ptr();                                      \
> +        mask = tcg_temp_new_ptr();                                      \
> +        src1 = tcg_temp_new_ptr();                                      \
> +        src2 = tcg_temp_new_ptr();                                      \
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
> +                                          s->cfg_ptr->vlenb, data));    \
> +        ci = tcg_constant_i32((a->rs2 & 0x7) << 3);                     \
> +                                                                        \
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));           \
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2 & ~0x7));    \
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
> +                                                                        \
> +        gen_helper_##NAME(dest, mask, src1, src2, ci, tcg_env, desc);   \
> +                                                                        \
> +        finalize_rvv_inst(s);                                           \
> +                                                                        \
> +        return true;                                                    \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ZVBDOTA_FP_TRANS(vfwbdota_vv, vext_vfwbdota_check, MO_32)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 873adf4d7a6..51170625aad 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6201,3 +6201,58 @@ GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
>  GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
>  GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_h, 64, 16, uint16_t, H8, H2)
>  GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_h, 64, 16, int16_t, H8, H2)
> +
> +/*
> + * Zvfwbdota16bf: BF16 Batched Dot Product with Accumulation
> + */
> +void HELPER(vfwbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
> +                         CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);
> +    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
> +    uint32_t vd_emul = vext_lmul(desc);
> +    uint32_t log_esz = 2;
> +    uint32_t total_elems = (vlenb << vd_emul) >> log_esz;
> +    uint32_t vlmax = vlenb >> MO_16;
> +    uint32_t n, k;
> +    bfloat16 *a_vec, *b_vec;
> +    float32 acc, dot_result;
> +
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
> +    a_vec = g_new0(bfloat16, vlmax);
> +    b_vec = g_new0(bfloat16, vlmax);
> +
> +    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
> +    for (n = 0; n < 8; n++) {
> +        if (!vm && !vext_elem_mask(v0, ci + n)) {
> +            continue;
> +        }
> +
> +        for (k = 0; k < vl; k++) {
> +            a_vec[k] = *((bfloat16 *)vs2 + n * vlmax + H2(k));
> +            b_vec[k] = *((bfloat16 *)vs1 + H2(k));
> +        }
> +
> +        dot_result = rvbna_dot_bfloat16_bfloat16(a_vec, b_vec, vlmax,
> +                                                 &env->fp_status);
> +        acc = *((float32 *)vd + H4(ci + n));
> +        *((float32 *)vd + H4(ci + n)) = rvbna_final_f32_add(dot_result, acc,
> +                                                            &env->fp_status);
> +    }
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +
> +    g_free(a_vec);
> +    g_free(b_vec);
> +
> +    env->vstart = 0;
> +
> +    if (ci + 8 < total_elems) {
> +        if (vta_all_1s) {
> +            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);
> +        }
> +    }
> +}
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


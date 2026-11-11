Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA07606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=WO8XmBFX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0ui-00055M-Kp; Wed, 11 Nov 2026 00:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0ud-00053m-VB; Wed, 11 Nov 2026 00:30:25 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0ub-0001TG-Jv; Wed, 11 Nov 2026 00:30:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlGi0ORkfRMbNIIHPBTVC374jgnf6RaJvCAsoycuKCJno8FYXFTPdC3XcmK+aVMEcjbHsit+PdCVvAhjnEauvm0YhEFLTYxl6Y7sRgezAXn38Gz2AkqCfpUUjs0ItbNZ7lQl/m6DaoYFCP7BZX5l04UOTTFf+T5WvHBffqudxtRCJ+2WaiUnf7n5zO4VN2hj0C964eECCnJqmI3cCbeQvLscHYs3mEtpgXUxCOIaCw9vQvj6i/y4RzVvJV4v+2VsgrzymaYH2qXBHvSMdxlutS4RiYgINjBwML4FCkYaW7xPBvtu4Lp9OecgIua3GKCrmr6vzCOHZT3mGl5Zus0O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rkj37blrBVDEQcf/l7Nz0O4eHPc5kw2DIPvC9KilkM=;
 b=Qo+0XMw47M4IOUb6fo2tq8ODk9y0vEg+mbdckMCStbqNNEahgAZ8NWnHv0tl9l1BBAUPwZYXfmkcyJH+ZV1+/UZAS9dBneyl9kw/RPIaA2jzUo5URlO3cf6nZBiVvO5pAr1293x4gdksolOJ370iygTDn65IhM/ldXP0SaTchAD7Qyt9s0VvQuy4OW3j00eBN9D7pV6QsvAUYDHHm+PMKpPbZC3fr/24JOFscMWjtmjVgSRTq+UesPe9SLk8jpnd04W7Zhv/W+DPL47/Uh03dK548hc67s5ngpsnguYpwMz6eYc4ySGbaL1YUJvhXbxh3WZsG3645l1IzXFwISHHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rkj37blrBVDEQcf/l7Nz0O4eHPc5kw2DIPvC9KilkM=;
 b=WO8XmBFXz55sj3G5PoNAbgGH4I7LuXfwblQCBHcYqizdbUuKACTX325La4D29jhirJrepBC80oXmmwpaHnVgchRvGzVoDRKSDoaCPuPjnQ1L/qh3z7N/JIKNPdMpE/Bvw8surhW/ir2SyqVR/41akSD7yNxQePlIktQ+Cw4PubAeGPYhtGCZr0ArYHg4J73ZkCRtBL/xzyIxcleep4VZRhReABAkTMQL+CvON2HHvBh0HIv7ZRH8EolqpFL0qXmT+erg9uHA8ENit+vAplepvz8i6iPZjBKKll03Kf9w4UtJDRklrTF52IrkZszX+EjmWbJxoiXKmPpr8cAxV79j6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6168.apcprd02.prod.outlook.com (2603:1096:820:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:30:06 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 05:30:05 +0000
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
Subject: Re: [RFC PATCH 13/38] target/riscv: rvv: Implement Zvfwdota16bf
 instruction
Date: Wed, 11 Nov 2026 13:29:46 +0800
Message-ID: <20261111052948.71746-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-14-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f10a553-0ccc-4796-503a-08df3fb4d7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|261009223027099003|3023799007|56012099006|10067099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: h54yScil5W9Zxi2wlVAN9l8acn9p72BrInPstv0FZYyXm4dwGlhn9rkJoPXJ7TJ4IBMUPKk/tdbhvkEuJgs/7cREQ33G3Ofws4KJ/uTqbFB0xoZ4jHWj07b7G7uUIZtJG/qhE3n5YXZlmKf0rJkFfWRFhE/OFA/grqyW7Wv0T8gTwqdDbpFf/fijylt513SJnfsOQyqxL8XNNCxfhOInGu1ZInyShjPMv/Ireb1atUjZJDh445sBdffNg+A/RQTRh5WcdurvH0/mP4KV+8pYtnC7BqHi4fZuQ/ne41M4MPFEdhBoflM0Uzxc94hdu0JMDjD70dYl/oDdUyQ/HwwUBsGRkxF9ZH7Slhk1jvSKXvlQmuzD3L215mGI1ujQslOnHMyuq4STUAneRd/axe6SRjggwRJBdoEDTPpNNgmE9M/KavucuoA9+o82M3y/4CnUKKwVujO5WMVSK3jNB/+Mvnl9hzK/e+uMTykflQ5eBTST6HdE1rXcgzpO6wrn4kcuI3KCE+FJ2QQwm0WYD6MrvK1ijU+wKVYdZZIpMu7RJxP/xTBpZ0OPZbvwVGQOp4f5ngfXvDmvDXBJEzDOWvTgM9VHGxqmm75mIQlZKeD7OCaxR7Py69pbmlM5lG5n6bDjzAzTnRE2Brv8mfAe1ocE31+j2xbwNKo08IBg7iZu1KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(261009223027099003)(3023799007)(56012099006)(10067099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/y8GJRBVXYwnX6k2uwHwXqgiZUTUkVzXGT/QJIU082hnCJTaZGAM6oYKARA?=
 =?us-ascii?Q?dYNCrIqWJTxC67vVC9rtfSFScGTYYR6Ai2CMjoLFyxOIdm/xZ/B8i6ZGKf0D?=
 =?us-ascii?Q?YB0ucL/Nas2uXuqFQ+bqbIGMdcSuXVufOuVnX2WyLRHQn5SbtziAYavIe1Tj?=
 =?us-ascii?Q?qx+fMJd1+ElmKd4fAWA49i8tX9Kgc/islIgLn+YgOfBOzqHRPzPT1Gwj/yNT?=
 =?us-ascii?Q?XAvU/0PyxTv4FZIR+j/RD3m2a79Q4Z83J0FOHEzcWUSrZ5mTTM7F22NtFQkV?=
 =?us-ascii?Q?3Dit+XxRlqc4/Tw/BGH/4A68s9xe9+ahzO+wx0pu6TUoBwbYwMcO8lyNqph1?=
 =?us-ascii?Q?TB0TonQXgD+CotswhmlzSCR70Oi1/ABSH6wE+WdIF6YbbdLOBPsFQ/gJoViZ?=
 =?us-ascii?Q?abX1QN6MO68g7Qm71m4u9jQW5x+bc8/uT1cDx6FfiQ2NPIvpXYX0Fx8noXXB?=
 =?us-ascii?Q?5Rwsp2k7IjiyV5Ny/DYdORtC0G+naCbddi6R7yoyVc+WEbFeGCEciJdxkZoQ?=
 =?us-ascii?Q?d+SpxbjlUkj5vcKhj8AhNkeozK0ShCaspEIcOZ4QQuKog8y0Vh9P+f7EGV4A?=
 =?us-ascii?Q?DJDILuzC9Tb8LkCfrWbU08TcKU+f8vfZ12QGNzsFueBYhXQrFcv3cWb0hCAA?=
 =?us-ascii?Q?8l4QtA4grNJfhKBtJI26bTsJcnMjc7AC/xxxBY97YDaGUIZ3bz2j1i3FcpIF?=
 =?us-ascii?Q?bUgdNp00miyqEHQgO0hXWLBIsIaAeF8Fy4IF8OcWVLS/h4EB7pMfHqCKN9UV?=
 =?us-ascii?Q?S4LyGL8AZxSG9nb87g8n/5TAicmOilg/NgwTh5dHEBR9tv/bq8G0usBsMfhG?=
 =?us-ascii?Q?vcENA6QnDeMiG9yRI2mKasj8VlSbHxJmKEmkPSQFuJWPZ8YXRU97CUGWfz1z?=
 =?us-ascii?Q?o33gQn4W/NugjUxmsasdGByEhQLbPCgRONX+CG5qOMRBfoqEWN+hHHhLVXSw?=
 =?us-ascii?Q?BHH3vR5EzOb9WY6b0Kqg3UpEkswSys19D0oHskBDu/lwh3IsoxZuNA/tl6Vg?=
 =?us-ascii?Q?AoDDT1F2EHIwe8l5FHMHwEZXBNH1Tp7WuaZn2jcxVoESEiSNwrsnam+8ZwHB?=
 =?us-ascii?Q?kg9bnjduaZwJk8slwxOe6DytPp98WHOjToUZlte2XBd7ui/5xrTHV0xLnJFB?=
 =?us-ascii?Q?k6tOiDVG8EyDB6jsmRDKVXVYwuK4iMg9DXi07PKXocoOlrhZ2vjRbQcDS8GJ?=
 =?us-ascii?Q?VDUn95UrNdOljBca9irAlacLCGfXeZKExLk9+kiGIRq576G6QXOIXUpDZPRk?=
 =?us-ascii?Q?kYofQT3zHNoT+lQFB/mchhiYkoA1cYeRxOIqF8GkBqJ9zh0Ah7vsVEOSB6mL?=
 =?us-ascii?Q?JNgrvt1WDE8PrqV3VGcIhkK+pFdnJHuj6qpBZ+N01ykZl7jbMXwmMosB8uSH?=
 =?us-ascii?Q?zdENzU1hRZoWVHNcimSeAl+GDJ8NsvlDtlNqrSM6etBlVClm4zC/bAAwnRlA?=
 =?us-ascii?Q?u5cjHGTkEIKK0yyENU8RiG+4Ooyf8rfw8yge/9q9VRdC1PVNag6dycNbD1pj?=
 =?us-ascii?Q?Hk1icFfbfQ4Xz2iRm6g6+suE/jTfyDz5WX8rIiKRfX3h7B5Nd0JLSDFJkXh8?=
 =?us-ascii?Q?+4RxP9rT7o9SIXQkVpUJGwazbwubV6N7zaCY8nrr1lWnRpDIphO9YavxlwSk?=
 =?us-ascii?Q?Bb+aCV8Glu7KC67APNhsDM/EA8XUeFVocJEjXzVYPZBwzSz8ZgJoPnqzICYH?=
 =?us-ascii?Q?pm/z4UtrzsKWQ2PFIJ+9uTNO4wxTblDKLJPheFnN9lN8cyrvaaVpgy5cfXlC?=
 =?us-ascii?Q?/nr7zKNX0zHVtBZDxCq5GemglvgM+RM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f10a553-0ccc-4796-503a-08df3fb4d7c6
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 05:30:05.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcJDgxyRggbCSq5+873gTAuBfWdT0znB32s6tMv0ul5lEy9NEU8EFgZywFBqAklvuS7TnZpFkseo3tCA+4bhB7+sRCjcasSPVlSD+a39PFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6168
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:28 +0800 Max Chou <max.chou@sifive.com> wrote:

> Implement the vfwdota.vv instruction from the Zvfwdota16bf extension.
> This instruction computes a dot product between two BF16 vectors,
> accumulating into an FP32 scalar in vd[0].
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/helper.h                       |  2 +
>  target/riscv/insn32.decode                  |  3 ++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++++
>  target/riscv/tcg/vector_helper.c            | 48 +++++++++++++++++++++
>  4 files changed, 95 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 23d3e9b3c43..918ff21b3e2 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1393,6 +1393,8 @@ DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vqwdotau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>  
> +/* Zvfwdota16bf - BF16 Dot Product */
> +DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  /* SiFive Custom int8 Matrix-Multiply */
>  DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index b8a5d0567b1..d800ad99451 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1101,3 +1101,6 @@ vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>  # *** Zvqwdota8i/Zvqwdota16i Integer Dot-Product Extension ***
>  vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
>  vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
> +
> +# *** Zvfwdota16bf BF16 Dot-Product Extension ***
> +vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index fcff472a2ea..c50f863ea0b 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4200,3 +4200,45 @@ GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
>  
>  GEN_ZVDOTA_INT_TRANS(vqwdotau_vv, vext_vqwdota_check)
>  GEN_ZVDOTA_INT_TRANS(vqwdotas_vv, vext_vqwdota_check)
> +
> +static bool vext_vfwdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvdota_base_check(s, a) &&
> +           (s->cfg_ptr->ext_zvfwdota16bf && s->sew == MO_16 && s->altfmt == 1);

altfmt is bool type, Just `&& s->altfmt` is enough.

Otherwise, LGTM.


Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> +}
> +
> +static bool trans_vfwdota_vv(DisasContext *s, arg_rmrr * a)
> +{
> +    if (vext_vfwdota_check(s, a)) {
> +        TCGv_ptr dest, src1, src2, mask;
> +        TCGv_i32 desc;
> +        uint32_t data = 0;
> +
> +        gen_set_rm(s, RISCV_FRM_DYN);
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
> +
> +        dest = tcg_temp_new_ptr();
> +        mask = tcg_temp_new_ptr();
> +        src1 = tcg_temp_new_ptr();
> +        src2 = tcg_temp_new_ptr();
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,
> +                                          data));
> +
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
> +
> +        gen_helper_vfwdota_vv(dest, mask, src1, src2, tcg_env, desc);
> +
> +        finalize_rvv_inst(s);
> +
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 41b526d25ef..5947427b6b4 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6025,3 +6025,51 @@ GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
>  GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
>  GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_h, 64, 16, uint16_t, H8, H2)
>  GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_h, 64, 16, int16_t, H8, H2)
> +
> +/*
> + * Zvfwdota16bf: BF16 Dot Product with Accumulation
> + */
> +void HELPER(vfwdota_vv)(void *vd, void *v0, void *vs1, void *vs2,
> +                        CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t vlmax = vext_max_elems(desc, 1);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);
> +    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb >> 2;
> +    uint32_t i;
> +    bfloat16 *a_vec, *b_vec;
> +    uint32_t dot_result, acc;
> +
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
> +    a_vec = g_new0(bfloat16, vlmax);
> +    b_vec = g_new0(bfloat16, vlmax);
> +
> +    for (i = 0; i < vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, i)) {
> +            continue;
> +        }
> +        a_vec[i] = *((uint16_t *)vs1 + H2(i));
> +        b_vec[i] = *((uint16_t *)vs2 + H2(i));
> +    }
> +
> +    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
> +    dot_result = rvbna_dot_bfloat16_bfloat16(a_vec, b_vec, vlmax,
> +                                             &env->fp_status);
> +
> +    acc = *((uint32_t *)vd + H4(0));
> +    *((uint32_t *)vd + H4(0)) = rvbna_final_f32_add(dot_result, acc,
> +                                                    &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +
> +    g_free(a_vec);
> +    g_free(b_vec);
> +
> +    env->vstart = 0;
> +
> +    if (vta_all_1s) {
> +        vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);
> +    }
> +}
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


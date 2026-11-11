Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AA606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=pS13PdnM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3oc-0005kG-No; Wed, 11 Nov 2026 03:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3oP-0005jf-HM; Wed, 11 Nov 2026 03:36:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3oM-0006aY-Cf; Wed, 11 Nov 2026 03:36:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fff4HJYwjDyo1bJL0iPi989OirTxMdl7okecpWr4UnOMG9ILR4ZvONzee95UbKuQ+2Kbj6qCFG8YvvN8t4Pl67aQrdRnSjROUCdeQNeuh4sfzbGd3nadjFwD5wKCyJ1XOUokU1H5cVUAJyzHMyyZF0ad4BW3760dxgGr6EP7q6aFFpweLv24vlGBsmoJAaHlkjj6nqh78+mZV8P/1HbZ96LjHb9FIQXa463dYSRwiLIxoSgmyTR9zYWAKEsirSvB6G97T3ONOYU7ZBxXv30s9GjdZYMFfXQ0yqB3gMtWGJwQasl9CcQqOmCHrKM8LPZXo6SuUiYu370NLluIv8FTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdu2KTXo/9V/I+2OryBhO+Ypyg3yVxZeVsJlrYpN+pE=;
 b=KeBgEKSMS/WThhEp24pK8fpzW53F18W8TPCI2v1TIUH4k2yDyCwd39ENFYCiznO/1j/iZ37NpKpixAVjNeJYvgeN5uwWpObi896erywEtcUDk0rmBO9GHa3dTYijAmLiSagiNM8IGDlZhVwhGHmT8gtugAE5CpwCxpx4PaYtSKIXwixbFOw3+eEHj6oAbxp8yJbCu2YLNTHadadO9DFTvCv5ph7sxVR1ZmJffCNckUgoNW8wnDPhSEI7Lp12Z6nXNMpSUFHNnxTT1kobm+VWdHPX8d8ijADNWtlTeEYlCXCiD8kpFhnyOPE5L8YQMkBe3wnjm5j0Kq/w1D1Y/sxjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdu2KTXo/9V/I+2OryBhO+Ypyg3yVxZeVsJlrYpN+pE=;
 b=pS13PdnMo0YS2TKpOjdj7n8xW+guX789STBpFZZ31mPXtAtcNup7tmcSF45BZI9wIEbXXOqdckJcQuirf8fFLNMnACZbGXW5A+Zl1dQjGO9OePZF51JZ+wzc9ovgnt3c0N7kcYLYhWgmPphgBKO1Lwhw4OCWuFsFRyQ5t85vxTS+g7meuTBpGwNeXf3ImTukRvCnnPIghm8JeMIN6YUsaWvEczBcBQZCCUC0s4cERh7ubTn6L/9X2D/1NY/6bCr06hASrd4uRd7hkXqrFyktYLwUyyRlw5HJu4nbaUS9U7pCWvc6eiti6wzBjSPKpOFT1SV+DoTTYniuw7hKJPWHQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUYPR02MB9402.apcprd02.prod.outlook.com (2603:1096:d10:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:35:58 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:35:58 +0000
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
Subject: Re: [RFC PATCH 33/38] disas/riscv: Support Zvfqwbdota8f extension
Date: Wed, 11 Nov 2026 16:35:40 +0800
Message-ID: <20261111083542.63655-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-34-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::14) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUYPR02MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: c44dd9ba-c11d-49a3-b97c-08df3fcecf61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261022075727099003|261102123227099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: KSUeMygRuz0EZcVROehTwkhRvtPs/AtuWBTAiYozGXPZHf1b5gKWVX/KXZoVlaBHcaCUssTckdN7UxwNpoXuUZ+tVPvcUUi688mEVYWywbxS027sp5aCzGuJps2geTXrKFKpmJqfeheZ4W+iRPXseoJYVzQ2/hLfVtu2x+ijIqwXqZMc00eJlzpl+UZuLsM6+JkR+/4SjvOXn4mFjC3GFeYmHGDYvdlWYtLH8HHaeSRiO/n52duqURN7rV/i6n6RsiMWec6NMZZPOu/U5iGk5h4YV2BvRtBqPXo54AuvmAR3zwmiDTaltSSU8VfSboxcTAt1reNoNWeaNHAaFdr15wvylFCO96IygEDFh0Dh3XqYExWKNtp5yXE+FA+G9L8ay7g49l4IDdT60ftauUImLkPDs812u6LUxuOD6GDTpgBfJ1gTGS9R1uuDDThLvElJWHfYsNkn797S1YxJ6dFMzDgAFL40Qa9OxU4iZcBTolV+Nrqd8l6xggEQ7oBzdaeULyHGm5KBtGIbX1YLevOw7ZSzkUNC0VIB0pHTuCbbIh1S/rRcamMYwOds8AKovPR/dp4z20eRvuV/P57kvV1SOkP+Eg3CrLGtvs+YaeSu6OvuCRk0Krwc9iGRX1hsTjniBMa4jRexmzd9H+5MeXGv/3AIU7H8irrJDm2E8Xdg5zQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/rUzwYIO9ha2Ezsp0sEM4dbsfj768YtaKtIJ5/l0uZfAbM4tDWX9o8TavkjQ?=
 =?us-ascii?Q?hNg+VZnWPDcCtf61eUGP5N/hLiG6a0xFIt+GpYoWYcPkV6NwAJ5xU3lx0NYX?=
 =?us-ascii?Q?OP2vsxIGFAFaG4T0JRZFWHxiTIOvcgNPUM+njcBmaCr1AdToY9YEtegF7Hgd?=
 =?us-ascii?Q?VtMZkBeIFLIJLQR9Wu7HJB7Q6Sx6tuT3PRQu1WFO5zenxwiBPirCfmsUc4cv?=
 =?us-ascii?Q?IVcN1x/Z+u/Nlp9rS3ym/pVFkPsmZNaTohydn0ha38QnfIm5UYbJlBSDVm60?=
 =?us-ascii?Q?jGsv2++AVmvB2qUnGi+tgP9FMV5tkLgNKjmpXwE14/4fR18tKewe3qxNmrMk?=
 =?us-ascii?Q?lUQ9Y5IVwa81WN1j8sRjVCopXKIWWYvNZw7kO2JcYKxamnHchsRO6KdFBIcl?=
 =?us-ascii?Q?sV+6f6ojjDJgMxHYAPSvOcMoLqvVmPmyzXPqFumg2io5B2/uFTwwwaz56IHJ?=
 =?us-ascii?Q?ZCMAyrGLB3oXPbr0xHZMCDkhQnE8oNCPYKsn0x0/FTk6sJ33rK1Qu0U0olNr?=
 =?us-ascii?Q?egKhvmA6JmhwChmSM/UhNy4FpDkZPC/F23YG3PsbBjRyAfSv0rIdt/EbMxi/?=
 =?us-ascii?Q?BhmBL25eyRp0gyn6PYPJygY/abdlaiUtmJugn6Qv2dKfS3VxWK+MWj9A/5np?=
 =?us-ascii?Q?YCvGTmqbTGjRuZ3Dp/halsnxN9HdBk76pt0YX4Qp2GH/JJepH42UR8OPkLC9?=
 =?us-ascii?Q?Fi6MIB75n7FkSHmMc+cfUpRxz6kc4MzvAAeNkbG4NyytTI7niyyW27qucGmG?=
 =?us-ascii?Q?SB3Ts3PZU5SS1TyuwRKMRAA2zWZsJkVKkE+bipxkb1g9oFhSDN1wUG6gIuRF?=
 =?us-ascii?Q?XUXWJgJhHyMRGVAmZlXr8Mf+7d2udgMFx1ALT92Tm/vuFZIi4kAcSZJRr4wu?=
 =?us-ascii?Q?evjfwSWc949yezr96LrKStLY2ig/G4mv5gBmyGakhSTOScukMM4dDVIw11Fd?=
 =?us-ascii?Q?87DtziAuwEdX1nrxZYf8xY8mx56TDwzdgPNxnjahof6dNeCC8sjth/midaz2?=
 =?us-ascii?Q?hqTJwu6/DjCdWaNxNcngxkgwvpdtNUo8M3JX5YBDoOIsYff2wyO79Rzfq2BR?=
 =?us-ascii?Q?gcVnzaUSfD/XbRH9H0goRe+ZRlxdExiRPPwflMb9lfOKyb36PMA86mjP+5+k?=
 =?us-ascii?Q?q1LTKDIAedWUZ0du0h2MVYTfPcDlMP/2zl+J5m6eR9bP6oGOZrnBwu+8GvVM?=
 =?us-ascii?Q?+/JtFYYOIugmDIq4xo+/WtcVAol1ujVmf9UM+JA7mQFsIAR5eO8++A2o9LHd?=
 =?us-ascii?Q?VGIqRdO56QbjrmJ8J44VRkQmBmzxCj7R2+bo3WMIUgDhWoMpQo/7Mf47rMPF?=
 =?us-ascii?Q?HYUkBeWxmG9M6xliu1IDzwF2tcCFHgX7SbK0EhSMPnU9xd4dAsgpraHVm1fn?=
 =?us-ascii?Q?LJ/tzRIMVHUda5XDeIHCbgBeUIOgFKeLZyN1VaXYX0MpCyyyJKLFYtWaM3iR?=
 =?us-ascii?Q?MgEec7+Ug8ZyRq1VzIuL3p+X9fZSuCpW5i3mSlBxjT5mTnx58XHJAefq+KnJ?=
 =?us-ascii?Q?lTqActP7rVHQdHlMvT6XSodPs4DU72xFRN0I1atwtS9r2mBPLnCyOl1C58/W?=
 =?us-ascii?Q?7UnXjMGH8RR4oZN0pXc9pZTEABfxyGAlt4LIik372NkFZntTKXxLDZV5xOLd?=
 =?us-ascii?Q?X0nNQ0+r6lcvd2/VeAUHVbWuYZyZPtfryQOwS+E7y48ffP0rmguHVF33vXes?=
 =?us-ascii?Q?LuD/j5rIt102QyXAu48ZAUmV3afiRB7SYqjmTBsFhlCjml1tFL+XL9K3ou8P?=
 =?us-ascii?Q?ylaOlTNA4DKuhyUqETacv3klTgQrWK0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44dd9ba-c11d-49a3-b97c-08df3fcecf61
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:35:58.6715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGr7LByhptVsOgP3FxxoNBSaq9JhitaL5upMOdswaA9btFFN6C0gLUNM32Pfi+j7Tp0osmjomNLB3+NNzZCVvCd2dz9RG18Kh+E4E5inhfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9402
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

On Thu,  5 Nov 2026 03:41:48 +0800 Max Chou <max.chou@sifive.com> wrote:

> Adds support to disassemble Zvfqwbdota8f instructions.
> - vfqwbdota.vv
> - vfqwbdota.alt.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  disas/riscv-op.c.inc | 3 +++
>  disas/riscv.c        | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index b24ffb45d8e..58f6ddac35a 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -583,6 +583,9 @@ OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>  OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
>  OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>  OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfqwbdota_alt_vv, "vfqwbdota.alt.vv", rv_codec_v_r_ci,
> +   rv_fmt_vd_vs2_vs1_ci_vm)
> +OP(vfqwbdota_vv, "vfqwbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
>  OP(vfqwdota_alt_vv, "vfqwdota.alt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vfqwdota_vv, "vfqwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index af41c2204f5..a124cbb4bbe 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2648,6 +2648,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 38: return &op_vfqwdota_vv;
>                  case 39: return &op_vfqwdota_alt_vv;
>                  case 44: return &op_vfwbdota_vv;
> +                case 46: return &op_vfqwbdota_vv;
> +                case 47: return &op_vfqwbdota_alt_vv;
>                  }
>              }
>              if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


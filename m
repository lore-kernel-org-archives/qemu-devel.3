Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA3606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=XaxINkmC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3Zu-0006LL-SR; Wed, 11 Nov 2026 03:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3Zs-0006IM-4a; Wed, 11 Nov 2026 03:21:08 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR3Zq-0005GI-8k; Wed, 11 Nov 2026 03:21:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD75y+qWRMkfFXY7mPD8foL+WHHjsLtHDyzjCMuhhxOakOXxUK85ZZOyq2pIGDnUFbzXyOeBd/3wG3vso4kmMV7Sixn1NvpvQwz67WUgxr0k9Np+1u9I5apxvtyaTPOk/LHZAtw49zaL28Hv8KQjNumZK53uDTqRc9Ltjx2dDcEee1SdJguKIb+JsdP6xFLbOUvItKaSQ0grlu3WmDyBW4qem6qq93MnKgk73H4pfTCxUs0Ho8hYmj2aW8xW4KU1mfThE22NXzkWm3x+OAwVsnI7/Js1+Zit5qTShpNwWbWwVEAuT6n6S8oghLX7wAJQP0s+hIVhLisCXEeRn4EKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbbPjk2xx9gwiy1rnoY/i4q8+LNBJcL3jRLUXmE+FvE=;
 b=dKoDmn/jzCQfWBBacwQtQQ+YDOpf3NPLcj6iQV3LPIedez/3TDCQ1p157VzT6dTj+Fdbjttg6VOdDSrg8Mu9T5W0oEkn5RYkdce6Mr3Q4yA7BYhYyhdDZusDzFKi9xdLh23CNNAqZmyWlxZC5IZLBLlkdcSN30ix36K3AkrSMnHcTOZZToPh1yru32UPSdPLhh71pR+yFdbbIABfwLb2eFSI3PQ4t28eHAY7W/MDHDVV8GbaM19efq1WdM20UPpeDaCak+TPChY081vGRZ1+9dBYIp/xzcwWXX5goYHiUUDheqQM3LyQdfBzkeHpeevpbfej5+6S48QcnOD5bu9XrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbbPjk2xx9gwiy1rnoY/i4q8+LNBJcL3jRLUXmE+FvE=;
 b=XaxINkmCCDc1ZoebWRlpDxnbA+6C2jz06M1/7a6gQgEONi0na2UfqKICynN0k2+DntRG0xUWhkTOuQxOhwlHTofBQ7X6Lou/QP8Hdq/LdnimTIcblRnFVTeUkYkmhbGw3ZvD4cJgtMEmhfKBMMf9++BCgw044CgSl0okQuMBCewsT7P98SMzODdgsN4XM1142dzNBbot4rCZg+8sV1bhKCvm7rUuBbYFbephthadgleBb99OCu0HgOFI54WGHF0Ktqjk2ww9qyVYbySD8qBlaihdAdyrgYF04iAhA57mmzw8FNDv8j5bB6jC4Q3Xupv27LlJtbfOjL9azNcKABnxFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by PUZPR02MB6114.apcprd02.prod.outlook.com (2603:1096:301:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:21:00 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:21:00 +0000
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
Subject: Re: [RFC PATCH 29/38] disas/riscv: Support Zvfwbdota16bf extension
Date: Wed, 11 Nov 2026 16:20:42 +0800
Message-ID: <20261111082043.58158-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-30-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::25) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|PUZPR02MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e0510-4cf3-4f6d-0379-08df3fccb7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|3023799007|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261102123227099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1JBBA9gyOLSRJBmwWDu6e2x77juttSTAOL+OuXPZwQP7g9oaUYr8TAxK50UdIt4QCIW1HnXWPrVgV9JvQp2O5R0jh7TbwTDkSq+TnrVkurwLSGWVKf/lWUDSsPn+MDexPePt9HsTQMfL8RzoxTNmpbY7nvaIvy9FCjOiMO3Oo7LKD0F647rA7GlRZRxm342o09v35Wko2Kr3uzwSqPEzK7EF8Its2ATHtWDDsqyPDK0RX9Pk++rffVyQKRRNMHECjZQJOMERzW/TRE0ZtLlGRXyniYrM1G7yAJh0yyYaPSv+IKKmWrWn7nyrfzPHte/L0xuEGC6qJLETTKik10l+PmIwnwIy5aQEEZssoTjsTPziXGEO8ZPm3yoD48G9gCw0YExnBn68b5uhczi6N9vNB9AuKJcfa8q0cnikxiaF2vl34oQfADqOmzYfGidjA4gugaCcdHx92OkXsLPFx1FFyJsRuUZC3+Kf70eAVCb8Jbva/E42r4bdt5UGSEDWkaCa3PUrrhcKHHPKofuvzZ+PL0Q7Vigo3G4icbCWtIW51i9VlONuLMl/0N3TlEz0iWklaoHbnWL0HtorSobpvMng2fvyH4OOxpmrIoMPgQ4uGDuPTnoPeDTkNbdRcC/Ea11VSF8JFfhGTsniqZ3X3PHjaaa+PfMVq4iBSPr6GgRlGSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(3023799007)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vx8TMahzdVGuuCiu30D9DccquVDsbRZPGc4J0MuYDKLXyIeu+NcehaljXz16?=
 =?us-ascii?Q?jmUhh59pJR4XggC+7vNZIw/XJa6e3uI9gqIBbhlnE9laicsqqIgdGcsU2Yj5?=
 =?us-ascii?Q?Pl8wTTuLRlsSg9KtfIRljbCKuQw/rPGLQHydhrYZWKnf3Y9UVTtvbfaG677L?=
 =?us-ascii?Q?4OkPGBQJd+/Gbmak1AMG5+/6dGDJtEbffaH1TK44lX771v8qaynru17Ui92R?=
 =?us-ascii?Q?Gmg8xhnr76UbWuLtFd9EnkLebugxMv7bpj19qdPYcqVwkvE7NdTFcnGC8udf?=
 =?us-ascii?Q?KJ1jQYgzNo9Zy0rSKSxkgcx2Xx3wayX1m7vZYnDTOBkYoBPU2nYZwmOfjQ6W?=
 =?us-ascii?Q?3jyaGJQrFPjPgrUODQ8cWKT7S/wyaU7xe/4Tw+cQEHM13PvaLuNQz+TxoE0Q?=
 =?us-ascii?Q?WkiReJNqAYzhndeYALE9sNN/l3rjaLEay94uHZPrx7s3ikx9ynIquuSjZOhw?=
 =?us-ascii?Q?IeCzYSxweJIv4K1GJHwwjpzjI3NZ7b9wLhUmDkRfKZN8HS5GLK4WdfEQCrEf?=
 =?us-ascii?Q?xxt8PapZhBhM5PAWOAoNsBkERQevR1/278egVCilbojsbbbB6EuK4RH0SMNC?=
 =?us-ascii?Q?J7TJ9o3ZEIWVR/sQom9zulb6Ac3njhzz57KsX/X1Gg2PBrLG9mzSV5BW0fOL?=
 =?us-ascii?Q?6+WJWidovIoIKT+zEjFV2tf7C/ahV0qAD7Q8J49ZZuQXGvfnVsC16B/VuA91?=
 =?us-ascii?Q?WsBkKggcDc60WFPJY78Z6wb9WZyk5ZMzUg4r/iCkNlgra2pe9JfTMppDf2jE?=
 =?us-ascii?Q?B/m3yA+hoH+gf/9fi82QPASqzUF/p8qldpsKdEqbMQ5tI4l+otiptzvd4Qgz?=
 =?us-ascii?Q?v4/bHO1Fbu0dWUusxyUkPBrTquxcZjsjoeQq9sA6cD0X0mjaoPo7sxjFFXYf?=
 =?us-ascii?Q?XYrUiaX9k0MKlFsinpeIc0+F1dZYSvDREL4RZQhQaqLQiSIncsskljyvr5bA?=
 =?us-ascii?Q?wSCmxijWDhlvLb+AXbO7Fri/55VhXRN8leUjh8ZsmzLa2g3vnyJjXpa5bjbU?=
 =?us-ascii?Q?4WwixDmj3ZRn9EKYctUhKApJugK5DeKc5mRPQrV+jMxhKI/tKNL7uJ1aTGBL?=
 =?us-ascii?Q?CavzTaJzddCbgktQp97VYVyWm0qBfZvUdFXdZGRwFXWQumOVfuZzWvQNfe/l?=
 =?us-ascii?Q?Umu2EdGBR/veGvFUVtE5mD8oXsMYi/OImHToSIalkGXGPdCyRTqKDRWTfvaR?=
 =?us-ascii?Q?ejsfM/5WfEmn2CxIHW17E0/hpm2cyCmmGhnYXSpDFsQaXkok7zXdQlbLFdmV?=
 =?us-ascii?Q?KJ11FWZJroUHHwvJuv5bS2SYOKVVKLlBNnQHgF77+apxCMYEqt22SmUtxWd5?=
 =?us-ascii?Q?0QZNAUoCKIf9PidkooPMcX5MRPSweC8P3Et/J/fdeU903ljvGudy1XJoPOjl?=
 =?us-ascii?Q?UnBVPVPMuBgf6zaIDOzmabMLs5jRRXoO+rQK38DrYZArQpo6bjn6vI+8D2Um?=
 =?us-ascii?Q?Zbp/sIn56PV0CsJDkYnJAdZpR0sBNrOt82/Rn2OwG2OBPh1g0mmYUtXd2gsQ?=
 =?us-ascii?Q?xMHDhcgn0F02DscHm+phB3QIc4xDKqo1tRASYs0rfTDuY+R6nrdYycjVhhDw?=
 =?us-ascii?Q?j3CveADgCxzmOu1GcAURFp8GYF2s4CwGXy3WkAbdGxmqhw1cVjdHxps+gQWX?=
 =?us-ascii?Q?fOYhiJ22xJIuGp5W3oTey07tHJaL6FOXbtJkVfGnHTxwrvvtcvjTQKwy85Sh?=
 =?us-ascii?Q?MTGglecxlWQ9k23J/5Cpq+pfT5KYDVYl518Zswu8p0SjaSAnAoiPkaSWtImo?=
 =?us-ascii?Q?AUXcoE4aAkImTV048Qma51paESAf8bw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e0510-4cf3-4f6d-0379-08df3fccb7d2
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:21:00.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKIgStTWgAAkC7S6NbgSz199koPwsHrkesRI+9Z+vKpBhBPyD3eTqisp1vuilDJE86+SPOeFA0Kftcr5u+hEnKlTf0pT4fi78SvAeuNWccs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6114
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

On Thu,  5 Nov 2026 03:41:44 +0800 Max Chou <max.chou@sifive.com> wrote:

> Adds support to disassemble Zvfwbdota16bf instructions.
> - vfwbdota.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  disas/riscv-op.c.inc | 1 +
>  disas/riscv.c        | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index bb01ebb8a6c..b24ffb45d8e 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -608,6 +608,7 @@ OP(vfwadd_vf, "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
>  OP(vfwadd_vv, "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vfwadd_wf, "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
>  OP(vfwadd_wv, "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwbdota_vv, "vfwbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
>  OP(vfwcvt_f_f_v, "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfwcvt_f_x_v, "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfwcvt_f_xu_v, "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 0534b8f4d64..af41c2204f5 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2647,6 +2647,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 36: return &op_vfwdota_vv;
>                  case 38: return &op_vfqwdota_vv;
>                  case 39: return &op_vfqwdota_alt_vv;
> +                case 44: return &op_vfwbdota_vv;
>                  }
>              }
>              if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


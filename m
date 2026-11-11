Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EDC606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=haavuzmS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Ov-0005f7-72; Wed, 11 Nov 2026 02:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Ok-0005XU-OR; Wed, 11 Nov 2026 02:05:35 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Oi-00025g-1g; Wed, 11 Nov 2026 02:05:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnmG8e1wOB/MXzqmRmuk5Kyx/28TWvUarX6GYHqrvlKqI/bANIAuq5BcSgyuPcfd7OCUSR/UiJq7tWerrXVvtNczCLKzRzgr5Col4jCZDz9tr1AvtczCTG7I/gPfaWqudO02NRyNcd31G4VnjPlSnROcJCPc+6EZY42K8yh8qIhcJeZHK5Nq2C9jfmh0ZDZbBFaw2QzwMm6bIn7hClZGBK902X1G99drgBuCDAM50651xH8OyngjSUb2oT05x5KR3gzRyYluJfX0x+3oV0pCuqNHjvhREScDmtQ5qjLdFIPTVU5GhKjmG3LUIQfEjukUuCh05QG5Zv5BpVd8aoXMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4rExYZWPOJvf+cDAlUII8F+0SnEo8K0omcNjCciT0Y=;
 b=nW7/ExTkrVozrlgDqU1OxkT7Gt06LZJG5TZNR5UFYxz6tU/49HhNwKBfh+QGcN116y497J57fHhYYqQMZmL1Gpi3zuUzDeApz5wOqJ6Atx/FSJcDOTwb1juOGr/7I4zLKPVpChz8CK4UewS53d3obqCnRkzsXqo1TP0S7AyYtUN4L0UzS7NJQKNoT+JbHBvd6+JXkTlzO0TL93lWtziykDi8HD+yeeUGugonHvAI/bZug3rMbPQg6E2XRH+VwKlVAfQPANjOO+F5sXEVN8fMrAnZ6sFC8yDvqRNkSpCSr6ZX7RW34YJCD4MDfPVMOTqxPsj8WDCNqEvWioZkZTFGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4rExYZWPOJvf+cDAlUII8F+0SnEo8K0omcNjCciT0Y=;
 b=haavuzmSQd19L9XB4FJn+jz3xsr6M5pajNrpA5XSqMztlbtviBAKzzeyp25bg97V8M7mJXrNszO99Z/k0Nqj6ftp0ulu+eF54ii1kvP9AxXuT+HJgwK9RuovcQy133NN6/bieuTpw0Ttq+ohfygLYRg1YuTlBnTVlmxAicbE4hX9CsxwervOxEPfRKqVOxo3Ij30JotRXunfJxcWwvHU+Y1ZWBcp6X01dW3HjoHDGsOj6UAKQxQu1XeolEgsu39aCW8OxExVm3u1a/Os0NEmX3+CEhj/bheQYZUjnuoYhuXZrytijClMzgFCwfrD11AeV/pdbmx9IbeDlpI4rJL9Fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB7237.apcprd02.prod.outlook.com (2603:1096:820:128::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:05:24 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:05:24 +0000
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
Subject: Re: [RFC PATCH 22/38] disas/riscv: Support Zvqwbdota8i extension
Date: Wed, 11 Nov 2026 15:05:06 +0800
Message-ID: <20261111070508.39129-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-23-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5b8f75-fb4f-4dc6-802d-08df3fc2286e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KJWWS2KrdyQX0jVsRRQnCuWvyN8wJ0wzIiwF1P5LvRbDrvY9RWR0NbZNhmt6PXE4I86YLrYlNZ4ndvOEXqtGAAgaU9uwzB1qCSbMa/zgcLMMiFSLnWCtaTdsMFjJMhYhAVdOi1C9/SpG5UwaoCXO+iSGEs4LWrOW/StExl1cipQd4m0vF2TIrKG3Nk1Gv1xHNw0DVbimfvVlXQrClHtH3FEhdgo1JLDbUO5Y1KVHUdmLm8rceWoOvSHz7DxNWLGMvvgdC641hT5dH+GzV+KoIqMNkzEXtnQo/3hv8SxR6QzkZWvY4tBpOD5BD34Ha+NKuzzWXBer5tJNfFI57j0hVyywdFCypivOpa99XcBI+/SP87J/BitoNfqRgstZAJHdgHXgT+fud8WaRCXi6YW/zHJ5EcuOeHU/yMemwa/vaSoKfcqu1M1eZxheW4G9xeTQnhvIgRBVh3OCHJcT1dt3qMsUw0F3cl9W/caPCGSFQtb7igCtqk3RE2j0sjx6Nnx6Af4UE/+gUNHt7AHuT3cCyJFUSkOAmltXsTygGbeE0UdytLh0vgXl7jB6Zxt5djgWHuEx8XOpvj5XLvH4diUpz2I02h459IpYy1yznJkO9/62joJ7N+E27vZKVl/+Mb2G12H1WIEYbMn1m6V7/e8X4/F1R3dxPmesPk8+s5X0DwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/hJl52QgYQk0j0nS7XvNjU+D4T7OutXYOVyvHx+mOPuz2qWxmeHoV3u33az?=
 =?us-ascii?Q?eRqmJf5FB00QiL+LgXCbmjNDz8riC5YOZaxlWFtYeGyBw0qZT8g8fqMzfIjo?=
 =?us-ascii?Q?GO75T0u0WJt/g7U/NHnsJ+xVL0asL7MNR43bt3UMrufkH9LAXPosyNAzrO0m?=
 =?us-ascii?Q?OXw9C8VeOb/SnRm7nnIAxJMNjQeqIVuuxzNQOp/ayOzdIpQwUQUjJejaD0uq?=
 =?us-ascii?Q?pqBrVvchIqGXKEPAayenqRsvOYUX68BivGZePe1ZsBd65lQVLiDxj69QKKCi?=
 =?us-ascii?Q?TjrRnSR2MFg7BGlaJv0aZe2naVScTz1D4H4q0E9chVlZpgI3Vo+vUw3Wcqmj?=
 =?us-ascii?Q?cunDnN/MekQi2as1DHm+gMhhR2D7MLWLLPuTCDiBzG8RJNtSiG0jtvpe9LQy?=
 =?us-ascii?Q?AkeSm+w5YaroWEsM7rFQK02PaSsi7bL0CyJJlkrLoHbGfbYVLjrB18iO0KAJ?=
 =?us-ascii?Q?Kt0CtcXfT83BMZDwH3wQ6WZMQtYk6mlTnuRFjt2nRDwEk1itiw54M+d97FJ5?=
 =?us-ascii?Q?Wix87F04M4mUsE4NijztxNoM+XBDwUKxwiUu75cQjv/aua5zhyCmCyEDCYjD?=
 =?us-ascii?Q?Mfi5WCbOO4nCbO7KXCY4runSNVlgshbsgQskgNsXHEcl7R3VgqrHKs4hTYD4?=
 =?us-ascii?Q?EXasQmBJylOU0qo/ltcIMIjGoGOEiuc/+q7BGSQ+813wV7w2lqElme0USt6I?=
 =?us-ascii?Q?quVYFzYeMkZ6jS4gqPdjuxd2FVdpOpZpeQoo29oWMCsfiEL09YwSkswC3ZuV?=
 =?us-ascii?Q?fj54RWdFx+6/tm0srtXGMJqcO1jbuazj0rSJ/G7NhaFfGlDF6SUfsoxFzDdb?=
 =?us-ascii?Q?y3apMPT/X8LxVOyCVW4K0lecXdycIVIeByJyXdOVdlHwY/BQOK8pfucI/fT1?=
 =?us-ascii?Q?GFjxjp3JBcnCzZpFb5kvY6t4ma6cpNw50o0kCNYv69hXl6MXpY6bPCIDdleH?=
 =?us-ascii?Q?ORfNHa0T7rZomVzjNvLueKaWsoLAU1ILP/+O8nsrr+crAJkdyxtmaQh+5CGB?=
 =?us-ascii?Q?8lw0atlfLd30ZQxy9f/OvRceQVicADw+CztHkPhXLwnbgzylVdN+Vn2kMY6N?=
 =?us-ascii?Q?eh1JVhNu3CWsRffgFLFt5kJ1U4yamG2icWiY8y7JuuylSov07bfYIBzvICWQ?=
 =?us-ascii?Q?zt3GpWUIvaA9vZDyl9Q4y1tZsaS9ixROhTmsJ3jH45Bc74nTS0oMhWAk54D+?=
 =?us-ascii?Q?1SlTIgpxyQlwc5Uj3EBWoC96sQoY9YGrSMfd/jquyzsRq+pD2brNjM7RT8Po?=
 =?us-ascii?Q?a1kfCIZ7OXlu3O9AVs8snkEGjgEaU9e8llNaOTFRCtuGDiA35HDbgrtLe3XY?=
 =?us-ascii?Q?cY3rv9edKzpywNdUvyzQr4M1QpzcEvIusyJRCsNk88K07Jgg8XX50FEp0BN8?=
 =?us-ascii?Q?8wzE21H+FyhnYVeXwA8Bt4GX+IEuZG5VNYXj9uEnBIyQyf3aw8pkZVkImYEi?=
 =?us-ascii?Q?2i3aoyGXL9DZMPhSKeX2fJbisNYPhfq66Uso2aAnmhUy+srxWIg4aq8OFjiv?=
 =?us-ascii?Q?mBPCU8qEAOP5frRBIbk39anEzK1GGHBF03mhI+yopjnHOIBsoJFcT60G4HPo?=
 =?us-ascii?Q?j4ubYgjzJ11WBnSDUVq3iR652Es+bvFtRBeTH00XqsNew5K18pGNlC8l1rEN?=
 =?us-ascii?Q?d2i+qJCd8vdOCGqdBUXpU53We5Lw03BI91DWLKrc92ZSb5EK0FcWZ6lD41CG?=
 =?us-ascii?Q?AJzW8w6kjx6IeS8DHh2g35lHnasLDdVLoyKorZIrJMkTTSnAaB88WDI+e0w5?=
 =?us-ascii?Q?vK3A2pnXdiVp5to7Nx+OH2pTzJG9G80=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5b8f75-fb4f-4dc6-802d-08df3fc2286e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:05:24.6025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QtuP2cqLsQSyl9t71/OXmqbTCBjU/5eriu+hv6CetbMgSn8bEH5Kt6HmRv3cuwVfTC3xXC3ouogb+BtfG3iPqKBCgdIFCvHIWGMPU1IskI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7237
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

On Thu,  5 Nov 2026 03:41:37 +0800 Max Chou <max.chou@sifive.com> wrote:

> Adds support to disassemble Zvqwbdota8i instructions.
> - vqwbdotau.vv
> - vqwbdotas.vv
> 
> Zvbdota instructions encode the batch-column immediate (ci) in rs2[2:0]
> and the vs2 base-register group in rs2[7:3].
> Add rv_codec_v_r_ci that splits rs2 into dec->rs2 (base register) and
> dec->imm (ci), and add rv_fmt_vd_vs2_vs1_ci_vm to print them separately.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  disas/riscv-op.c.inc | 2 ++
>  disas/riscv.c        | 9 +++++++++
>  disas/riscv.h        | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 5ba29f52976..bb01ebb8a6c 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -773,6 +773,8 @@ OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
>  OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vqwbdotas_vv, "vqwbdotas.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
> +OP(vqwbdotau_vv, "vqwbdotau.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
>  OP(vqwdotas_vv, "vqwdotas.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vqwdotau_vv, "vqwdotau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 0f609cc06b4..0534b8f4d64 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2638,6 +2638,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  switch ((inst >> 26) & 0b111111) {
>                  case 38: return &op_vqwdotau_vv;
>                  case 39: return &op_vqwdotas_vv;
> +                case 46: return &op_vqwbdotau_vv;
> +                case 47: return &op_vqwbdotas_vv;
>                  }
>              }
>              if (((inst >> 12) & 0b111) == 1) {
> @@ -2999,6 +3001,13 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
>          dec->rs2 = operand_rs2(inst);
>          dec->vm = operand_vm(inst);
>          break;
> +    case rv_codec_v_r_ci:
> +        dec->rd = operand_rd(inst);
> +        dec->rs1 = operand_rs1(inst);
> +        dec->rs2 = operand_rs2(inst) & ~0x7;
> +        dec->imm = (operand_rs2(inst) & 0x7) << 3;
> +        dec->vm = operand_vm(inst);
> +        break;
>      case rv_codec_v_ldst:
>          dec->rd = operand_rd(inst);
>          dec->rs1 = operand_rs1(inst);
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 4f1ffc4ae02..34050583c96 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -138,6 +138,7 @@ typedef enum {
>      rv_codec_k_bs,
>      rv_codec_k_rnum,
>      rv_codec_v_r,
> +    rv_codec_v_r_ci,
>      rv_codec_v_ldst,
>      rv_codec_v_i,
>      rv_codec_v_i_u,
> @@ -254,6 +255,7 @@ typedef struct {
>  #define rv_fmt_vd_vs2_vs1             "O\tD,F,E"
>  #define rv_fmt_vd_vs2_vs1_vl          "O\tD,F,El"
>  #define rv_fmt_vd_vs2_vs1_vm          "O\tD,F,Em"
> +#define rv_fmt_vd_vs2_vs1_ci_vm       "O\tD,F,E,im"
>  #define rv_fmt_vd_vs2_rs1_vl          "O\tD,F,1l"
>  #define rv_fmt_vd_vs2_fs1_vl          "O\tD,F,4l"
>  #define rv_fmt_vd_vs2_rs1_vm          "O\tD,F,1m"
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


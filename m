Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF287606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=NGeKkL/A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Tl-0000Hl-EK; Wed, 11 Nov 2026 02:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Tg-0000H4-62; Wed, 11 Nov 2026 02:10:40 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2Td-0006S1-0Y; Wed, 11 Nov 2026 02:10:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbrkQ4QkZAbF/3R3Lot6zM1qRZYmLhgn7WnVstr222jG086iBlUpQMZiKcA7N4P5TDneu2o1V9TUCXBVcNU5rkX/HLywEKRcfX6XzejzVqRDci2klKJ6ZpZMwZ01FhSMCN2hD57ts+QiiwsLDdwZRKHJ8yJJwy7hwZ1Pkol1877q51cGLfXUybuGMX1xjnloU/8sWLuw2sCXRfiWt0mZVXAFUiSfYI5Mlu6A+atBnRp3UdFXOhq8eUVCwTGf+gUVqgexUVyeMSGVzvvM/TY0af3vlqMRf1G2+4lUhQFhh3inqgyt5592UbnXF7j3XSBCTsbNU73jexduWuGTAyY2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/FqYHJVnl192BCVD8NP8juxNhpw/U1f6Tn4+rA44IE=;
 b=LAF5gfcOwpizcKU+1aFcEqKch4OwDkyfNhbm3Cd3XNupoX30ipTM150iJta8Fe+nmMIGpEPqvpiL1n+UtRTtkeZxjQqZn827jQPVZVMXG0fQBbHBgQZs5rRMKBrL+rGbj0B7yw1SfSRm9p/cj2RQFbJ2iOX355XUqKSMEmwMwB38kxLE2XNko3BBMSwu8q0PbSE6KSBVzcwsJinkz3BFuQrFE1OSbhgQyndm0GBthmcpXJVJliVpRsqnnnfEELjzr4bxbh/u09JicBimGoV0zvS8cizSn3BkB+H8JYapKm1BySD4aiX4R+pJQR9fiKHpEOdhNmQfJ32ctK9k8PZJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/FqYHJVnl192BCVD8NP8juxNhpw/U1f6Tn4+rA44IE=;
 b=NGeKkL/AX7TpNUMCVi6a5w/OLQHvUYmIts7nQ4754j7WNeJB0GbMlZkrNqxlDNIdNVOD832R1MGg/XmZ1GII+0Ed8S+LW1SeSwfq+tSSxMAG4DnHIiilVDKS5SDOkXIfmtg4ct3cYERonfYDhqn4CJhcB+uA+kkGX1RXG/tLimTVAApKFCj8RoKbbNNVTdUZ44TK7YHYS58RHz598/uY6i2I24xD1n+llYlq044bJlKbq6uHpA0xpnAwWDobo/3IPoSsOAzx1ITggq6P0cs0XEuzXrgqmIzo9u1BqZxT3ilqJ7WdB0iP8QLRQvbokMoYUGUrWGDWEYHwbTasx7x3Nw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB7237.apcprd02.prod.outlook.com (2603:1096:820:128::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:10:32 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:10:32 +0000
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
Subject: Re: [RFC PATCH 24/38] target/riscv: Add implied rules for
 Zvqwbdota16i extension
Date: Wed, 11 Nov 2026 15:10:14 +0800
Message-ID: <20261111071015.39933-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-25-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 27699e5e-7dd4-4769-d97a-08df3fc2dfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261009223027099003|10067099003|261028144727099003|261102123227099003|261102124527099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jSQX98t88925t093VZzrjiwcJ68yr2zEKdQQeLp1H8LkhOQ+tjnYXUKDIHS/fHtEvwC424/+rv+8hI5DeJn6brm0zh7pUXm9UuqnvQKLkMAlZhZ6ZNUyi6JU6POc9wLzsWQ1t6CfCB/GPeGTB6ZXFQzbY0i+Nnq8HefxUmKk2z/2SfMpI2LdqSHa/Fz1hiU4HNszetgm9dECp5UaEhGxSLgkYSx+dcZf5zupojLYaISrhg4E/uMCS846t5VxuYuy15Xx7d946VFIlfQWulXr/y1pNX0fbf0chwg2c3s1/Q7r7H0iX9BwR5Qtw91FRgNiuSKhFSlEjXwhvwWq/r0NvuSOpRqPFICb8TUZINFFSLo0NkI3oTKkQNV/yWtNcUII4LIf3y5Y6lvAbxTRmkbbOj3c5yFaOws6XG6bbOpPlUWbLnrD+IQ68ZmxDhcqLem33s0gV4Ci68MW568fO8ytGVzaMNfyH5nmzvoe3MiPVTVfCcjkFykxy6ayeL01r7uTOQ3ReZg1y7HBVIwpfptoTuAzw1nB9pSbjl2X6FCCu3g8Mk87OqPnXNYBJwrAtp21JJ0yGnJW0SkIWk+69sFloW6NEACsOg+5D9RSvqKSezt7Bqmg8+FyUR6LsyxzbAJp8zy5alq2HH53fxN6kfRmoNXNQ+7QHf6y93c/1CCGZ6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261102124527099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?okO7WWQor7VfkmYqdISUrmrrQ/u0uh0ReNNUJkIKivRpmkauS6lX2Gp9hmla?=
 =?us-ascii?Q?M8T63RkVHq64z/48MCnWdbTcApbzkLr5EJIPl80ta18DgHa0k9iKQMil2mC5?=
 =?us-ascii?Q?6ABB6AGvRUDPt4kEwDf9cN4uAIbwbeOWUNTsHQaLNul3Bp3g3g7FtOcUCIV9?=
 =?us-ascii?Q?gcD3VFcI9dLxvxUmZIsQsFwNJcv+HDlAbkLRcu9TI7mBtx9UJ/JlQqvff2Xo?=
 =?us-ascii?Q?0vSnWyv7sTbNizbaya8snr3FuDfaQjkA5VZJU5yOnnx1cmeOeIfh1ZxYLIeR?=
 =?us-ascii?Q?PVAUUYiyb+XR/qY1ECTBpJq3UFmWKuB3bzVICqDnYgeZXepo0533w2KVsJil?=
 =?us-ascii?Q?867yakSaf3WdFKd6eCtw4prE/GWJoQ0ir5S3PfrUHpI/HW4fQGluUR9DlxdO?=
 =?us-ascii?Q?NdQ24ePffS7pBfOXfv3fkUQ+Z4oy0xMtjuFo/Llt8d3UF4jGO97F2lLv58nc?=
 =?us-ascii?Q?NNHqW/wDdrns8hj8P/NsSOUCqFdjZ0/Q8XPTBHVUtU4R1Mn0J6COoMxDbt0o?=
 =?us-ascii?Q?ctlJlk5oS6UP7Gtpht62Tasq0YxbPtRiQl9zW3v3VJ8sQ2a5slcXJmZgTv9D?=
 =?us-ascii?Q?FsVcOw4D36tunAa0m3O06McXA6jNsa8NbIa3+SFV9Msx22IKcAUYjAxsA722?=
 =?us-ascii?Q?UAW5CIcdGbTg4ZkVkAgrdzSnTFwURl0dYui1m4Y94nUtAqLt4phAecIRrFCN?=
 =?us-ascii?Q?u7pJ2dnvhWkOAAV1udIJP+1MsNCyaO7exAocFzCTdEwZGnmXO33fyzTmScH2?=
 =?us-ascii?Q?Kcu4Yd8AxMLvqhn8Gkdb09Jr5fFxcsY9EULFoxz+r/xCnZxl8XQl9Qs1XjS4?=
 =?us-ascii?Q?lwVwkx7FUZ8O7Hhbd2r/9R2NBwb/2EJ02sqxFMlTlACQhik4ZJRPn3rwdB/V?=
 =?us-ascii?Q?aBgZN9ksQELEShJd3aJJEom8MOtE481Vhf3z4VOOrQgSEHKvmBhH1O9r5shV?=
 =?us-ascii?Q?rxiFbQgDexvKEOi2u8yKUpIhCzQTT37Hdo3mMeUHyuei3duJfE+cxxpZPtWb?=
 =?us-ascii?Q?dortIaiQ7wCmVutcA3BFNe7BcAK+c0CD11R5QmirtEWWjHoPa14UJ+pp6Y3S?=
 =?us-ascii?Q?lmNQxydLralxPrXfyT/pz16avxwXniNWBU6eIb/RJdLl/l3iJU2MHa6WMNKS?=
 =?us-ascii?Q?zZQ7HNR0qwVwu+mGuLgolXtriKcOcV0tq4KDZYMpepm+yCWFyVuMP14bXyjF?=
 =?us-ascii?Q?+EnTDCJjId44c9N/k96Sh/fEiaMbxLSBDHOEBUQeUgdVitTzCX80XzsM65C4?=
 =?us-ascii?Q?7AnIH+HmFRQ/j1jorNoAtBi08cDbbsoywRc6fIF8WaZPGmREHSv9LQJEZ5xB?=
 =?us-ascii?Q?e4Zvj1NTqsxJfE8xqdOzZphywyRGbK34a2pfiR/jdnMRFcYDq2PYGg7e+42u?=
 =?us-ascii?Q?HhTAiJtabHH1Y5GSQ2wDyyHosOhBsPYg30qlXf0rQs55VAB2DwtJxJBrFdbU?=
 =?us-ascii?Q?kr6Yj/CH3QImSuqOPsY/DapBhKdreu8PW6HOROoF8mL9L0oHvQUjF6hGaeKQ?=
 =?us-ascii?Q?gynhsc+u8vRh/FJgjI3QAWdRbGS3zh1EK42jZSFrYOd63a1bnLNQ5HlcuLxk?=
 =?us-ascii?Q?GPIAss76CyP3p0H1dPc1jn9OlOn/zUvoRmve9A77qRL3YowIhrqgUNmyC0Hd?=
 =?us-ascii?Q?lezZgTX3o7imOVVVVXHXvwcFRh/AoBDjlVy4hqJ/t/6Ts0sVe2dF5FkHiE2I?=
 =?us-ascii?Q?L/Ubt6tXB/CKq+JPbWps8W4FJOVvatVDbsJ6BxXsx0cRnQ6feK7uRXAQsE2d?=
 =?us-ascii?Q?en6fu76VVwj5ASIwhhDTHpNHyKFoHVc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27699e5e-7dd4-4769-d97a-08df3fc2dfaf
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:10:31.9540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EWKc3wH6xC8mSh0nbv5EKxhKnEbA5w3fKVajM0scaL+aN1Ytsf30xN1htiTkllvjbkJl8O5ZssWskS89VCg3kVdzRI3otdfs9BFpNy0osA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7237
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

On Thu,  5 Nov 2026 03:41:39 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvqwbdota16i
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 99c82b898f0..95bba330e06 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2906,6 +2906,15 @@ static RISCVCPUImpliedExtsRule ZVQWBDOTA8I_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVQWBDOTA16I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwbdota16i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvkn),
>      .implied_multi_exts = {
> @@ -3112,6 +3121,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVKS_IMPLIED,
>      &ZVKSC_IMPLIED,
>      &ZVKSG_IMPLIED,
> +    &ZVQWBDOTA16I_IMPLIED,
>      &ZVQWBDOTA8I_IMPLIED,
>      &ZVQWDOTA16I_IMPLIED,
>      &ZVQWDOTA8I_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


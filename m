Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2039606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=IrNAvMfg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR52A-0007Ha-AQ; Wed, 11 Nov 2026 04:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR528-0007HF-Pg; Wed, 11 Nov 2026 04:54:24 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR526-0004V9-LT; Wed, 11 Nov 2026 04:54:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv9+O0yoiIEKO/P22L4JUPEbOyL/6SyqQW+ldXu+XDRcYH/k4WQ9P7lALHRXcStIe82D5Eu1Ry3uyTlZM+sbdWwYs+xv8q9ElNz6NOJS5Xto2kwnMhjyN90Gou4W+PGC+T9a0qIzabTQGHJ0FxZX6OEtAoY7BcQj4KvJOOggxpdXtzN7szEqTatApYhAC2la7KWJCkvDy2lqGTErXEPJ5+6vE2KdAUftOuw3oSOYvFbOsHgFjaJpWRkITr/60TazCUpaqiZggdTdCzWk9kzDT5doJMw96EnRDwfEPhErySPbnSpUEuPrybm4iTVa6TIlPixHMLVV5Ylg09qyClC3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9FNuaSFI7MIXfPU8ZsugeUEzCFUXAH6pou5l2wlB1M=;
 b=f5J2SJEJKfinF18iOYyNW+DW28r2pNrfJScCCn+qzldZIbzWHz2QZ73you8cDvJuMmgT/C3De1XpzZDCsdbKXbNm1/YWWiqt9NzLWTJVLzISfbYJZSlIfVxfzWGes3r4RPabzMAWXuvJPCdDvlq/KeGtgqGzOjnXfTH0y6OB4mJBGRg+3rQsE8yxEff7dtQHwx4hOo8HntXHQUeg1MqbThKG4p7aJpEXqAuEcz05EPFxFl+bCSq8Q4E2a96NhnFQ92/oea9gZDqsBD31D3XCnCVitOpEllIHRgaw6UsOjE+7JTQ3oJtNyvY0EFqDeexFfLPHz5W4N6lZMuASoNIlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9FNuaSFI7MIXfPU8ZsugeUEzCFUXAH6pou5l2wlB1M=;
 b=IrNAvMfgX1sjRNkjBNlheSZBUixDHnRYmmeLhPUfUg/+tXsrkfkMC263IB3Yc5YSqVnu6GHtC9UV5bCaWLGl+BSn4WVEXt+iu2nGhB93jhjUiJyrU3E4pnM7aAKJG7kDKidV+osW8iS44magsNiKwTYPsTgGpW7Z2ayM6QqH8RVsaOOVBaJEnOyz/bUs3Jh8F8Mxh6d5hm4AjK2yw8Ef3XRs6ju2zm3TbrAs61v9iDcXaacz+QZQdd7nucK0dq9CQit7Li5NwMmToWSNXYPOiA+1bR6inctyVF0w99kdiaxZUnXz/hoCiMoX2HIsLwOAOKcqAXLlLnl1PO2UM9mUjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUYPR02MB9618.apcprd02.prod.outlook.com (2603:1096:d10:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:54:15 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:54:15 +0000
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
Subject: Re: [RFC PATCH 37/38] disas/riscv: Support Zvfbdota32f extension
Date: Wed, 11 Nov 2026 17:53:56 +0800
Message-ID: <20261111095357.89601-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-38-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUYPR02MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e21713-d906-4c16-b7fc-08df3fd9beba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|3023799007|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261026140227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: qUduiKGMEO2SM9sF9g65l1TVZ/pvzZGCZQHsaUB1LVP86lNqY8V34o/YpiIQCvuT6M8OqOCbu6t7E2amGHVKsrvuOeydQa7vxR9/wXnSMrPv3AoLZk7ul5MCM6wwc8/FZ6Gf9jJLZiLYxrTNcGz4BejAdCuQt+9qwNKGJsJdSEuqMbsDo5tciielM9Hw71gz45VUGMRDYgKjDJY4mNu0U/VnXct2AJjzJHqMlS7qDuJmFGtxX9BBOANg29KoXNVk9TmMB/cMBjiNG9vZUTX9XiU5FUtC/Nc9VJakbdMRPmGrrlIP5LnQywhvBbOs3iq4drmQIg1QcI1hf/4zqshelWitf815Sx1YSAvMBbzVR1eYaDmUxlehY7GyQzH7dWaaYhvL1IPLHbUhj2B0KqCBEIbBx7L8NjT/BpB9BVPhgMfaFDmvzxFO+BLdxSs1Wfv+PW1PgWSpIvS5SysxGHMnidh7uOnV/nKNgzhDfY7CtNdLlV97UVC3hgVtIw5GNyKdQrsgqH8R2o0LxAcWVzXuXEvfD26ZWjIUwlvK0jULR2T7PSNCItMGzjPBgGQrSTOWAb0t3R/v0zDSRzWKNm2NCqMygfW20Or+4K3YGyR7hGCLXjM0LzzK6Psk8lLPzp/58lCdf9bKLocQG5vWq7wv+hWYyQ0BcO6GE44AXRui7Mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6plUv7jdUxt9DeSoMyurp0zfSTtUJ4lSUqJUw8xH+/dg7h/UjR++WsJO0KE?=
 =?us-ascii?Q?ESRh7otim7moKBrFoLC8pmrNy6NnUiZwOyP3mp+J1owmGrSwGLF3qlG98j8C?=
 =?us-ascii?Q?X1bNnAmjForZy+K6wAlUWAoKJE9w7m611PJXrl1Wv8ycLPpUUAIsqLvANkju?=
 =?us-ascii?Q?PlEOSeyOJpTUgCqa8STJtkp8e3ejqYuZzUker/0CdKV5dytLZPo38RCARWyW?=
 =?us-ascii?Q?Sll74EQ0xTGnF9RizBbipy8SzM9ws/J0+RVCIK2NmHGPaJXOLEbMzCH0DDwB?=
 =?us-ascii?Q?ucgk+ckwgKA/F8UXP6PSetglO5+97bfqLtCqqz/sDOiKKJWIwDV6bokJc9iS?=
 =?us-ascii?Q?4x4dHN2yRibHHzRa+SenFy4q8qHBbZGw9sWqlZPHvKbhM8nsbn1cE8e+y2HH?=
 =?us-ascii?Q?T4VIYBgSOgFKSXPG1wPNz8yG9D2a/iMQ7UN1utih68kdRVVTo+AQdXSiqvpx?=
 =?us-ascii?Q?0UPtDCvpQ2yMHk4wwqHxrBPpP0FqFS9gJ+eNeutESXE/u4JUW3pptaegl6k/?=
 =?us-ascii?Q?9aH0ZM0vd1y7xjf6kZqt8moosoGXOTWoE5elx9tTMCFzsw1Hzi6M5HjaoXbS?=
 =?us-ascii?Q?bSELE7HEv5kFGFRvMguje/xY64NXlhCdKOn0k8pWQN90VfWOgCqKWlzISANR?=
 =?us-ascii?Q?upcBvGfgxsqZRGECFT9Sxx4Oh+tpxJghRDtga/H/tKHLu7R93UWV/H7k0fAJ?=
 =?us-ascii?Q?6+xIMXtCgE9G4RXcwocV1bW1IIMvewyKxowIQdw79hbAr0ioaIjznn5AZFuQ?=
 =?us-ascii?Q?ULClaPf0NuD+4rIYLXLJ2w6l6RS1Ugd2Lma65q0Mhw4I08OexrPqYK90xthd?=
 =?us-ascii?Q?b2e+3LPCKxWghyQHFYTHHWQeO7U2Bjfs4p6t5LE/jQSIYtu6EupYrmOhtvcz?=
 =?us-ascii?Q?+CBZhQVdAILtuhQDJhi9flda9t8b70ygP1yTOMrcto3NkqRdgMjhtw0sZE8m?=
 =?us-ascii?Q?WaStSddh7JYE+zYnPhqPr74QZrwIqQbeP0wvqiJFDhHJwSJdr0xGCGItdGwY?=
 =?us-ascii?Q?e7FvU1hKm2G4DTPPkHKwAvkqYFM/kM6c/ixhMziLAR4s/IDVPGyifKRp2ozu?=
 =?us-ascii?Q?VYE22jKnoOOVajMow0JUIEz0BKRegz67z17mEJCccjsc72e7WYZ0gJQp2zwg?=
 =?us-ascii?Q?4x4HUnu61xk/dhxnJFCCRr3MHLGK38sNQikGHCH8+QcQO63HJD+efuk3k3UP?=
 =?us-ascii?Q?EBvlxJRo5kD0d3Gi8T3uZeYg3pP7HIJRO6MHucc/YXSkiN9bXPfBTM5fURun?=
 =?us-ascii?Q?3g7d39RikDA68YK+Wx3hZC83qFXGCAkcAj7bdPXPsE1hzIP/wT5U9m+XI3tb?=
 =?us-ascii?Q?Oa5QitSif1nhsm7wVdkaaGcm/JsxivFTswdYoMuPQLl9oQWOOv0ktjbpBD1Y?=
 =?us-ascii?Q?0D2XtgbTWVC4rVicEbX5IH/168SzfoVds0csR5LbujE4ptl/8TyvHijW5o5e?=
 =?us-ascii?Q?OKeSp3v1qo1p3DOaqzh4bom28aRCJZJXODC2p9OeZ1Z6bZvu8iEkmPB9tkFj?=
 =?us-ascii?Q?TwVWzr7N/0DjqGXjzxZ4UOfRbqkBp4bWn0O5rP44vrZSalywvDeMoObBwxgZ?=
 =?us-ascii?Q?OVJV8y71unQQBKkaGKMjJBQJUN5xHxJTIyVV5ZIqPmrAegn6Q7dgNyU5NT/v?=
 =?us-ascii?Q?KVe1ulR6ANHfx7RU8GWBaLoJ5wioMyKy0aG36SU9+FEaMwIPM81p7ck7eUb2?=
 =?us-ascii?Q?h8EyquNKdxEp0nfe8LP8OkJPmQASuIcgpJcvuMADUonQikfsGpCjeAazpxDC?=
 =?us-ascii?Q?h23bc4SPraYRNKI1H4dI9ObH690JU28=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e21713-d906-4c16-b7fc-08df3fd9beba
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:54:15.1056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7DSZ0w7oRDOa+T2rGeVL4QEJ7D01yalcVFqLBYk1GWcHUfxdLu/HdKJaMzu36ssrLd6BFa+neVlBuMtueCWCfM54WmcKcy2/BVtritfytc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9618
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

On Thu,  5 Nov 2026 03:41:52 +0800 Max Chou <max.chou@sifive.com> wrote:

> Adds support to disassemble Zvfbdota32f instructions.
> - vfbdota.vv
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
> index 58f6ddac35a..779fc26a27c 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -538,6 +538,7 @@ OP(vdivu_vv, "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vdivu_vx, "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vfadd_vf, "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
>  OP(vfadd_vv, "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfbdota_vv, "vfbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
>  OP(vfclass_v, "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfcvt_f_x_v, "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
>  OP(vfcvt_f_xu_v, "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index a124cbb4bbe..8330ba34a30 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2647,6 +2647,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 36: return &op_vfwdota_vv;
>                  case 38: return &op_vfqwdota_vv;
>                  case 39: return &op_vfqwdota_alt_vv;
> +                case 43: return &op_vfbdota_vv;
>                  case 44: return &op_vfwbdota_vv;
>                  case 46: return &op_vfqwbdota_vv;
>                  case 47: return &op_vfqwbdota_alt_vv;
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


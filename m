Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C258606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=X3mPhnNm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnS6-0003WB-R8; Tue, 10 Nov 2026 10:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnS0-0003PT-C0; Tue, 10 Nov 2026 10:07:59 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnRw-0000du-Hc; Tue, 10 Nov 2026 10:07:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVB4ySdl2Z21qMPoNoUwimeNUr2cWbMvauYVUO4oZSTJJFipkZJkpHnlKG/f/gZGCPXyKnDAPAHmiAqhA4txvM6GS1gSGmFe3VX46lRUd9ZVGN7VG2sNXYT6mpbmeL62qimYmR7M5H3az6IJmLHDlOgts6m+5cp9P662asItj6HpGeacFu/9SpnWQRK++rnCxzPixIxaG0LopfgJuWXGNhGuhFBNDBt76MEj8o4iVOu3NNoEN8aUZ5auzVHtrt7F2CbEAsHNYtFD7ki380V0qzHKgQKc0tsR98SAfJeAVvpXZVHF5iHGcaYPGVGrkCxg1cNqYdqakIO/mBhxfrBXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgK/dXV+yVd2cCd7eTHo2L045YrtjebAebCgDaa1enY=;
 b=BjevomRvCW3CX1DorvFW6KFqCFuylQIZWCRcpSMk6LH7PuIh6kUGTl/wW2NyopL3W//McjgKHjCsgF+j5UeuzaNwfrn5f/2MZZxz0a6xdHjhMrDyNogtwhhfL/Phck+XCpxGx1OW4yUPJDoXTwdlI1X2nhst2bkpLh2PAFjrwNpiU1Z5/K2IIJENTZBC2fie+B2t/Olt1ZS3OMzTSplreeaRL045xfHsvCOHjWMXhuF5gWD5xUi4srZ1vPwgd22DabvA6PY9dAQPU3MWXnrkTItwcqab8zPs6K9THCPKD+cpG5gJW2YysVmRI5dYiv3iVgTEf0aQjynI4o5rD9btvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgK/dXV+yVd2cCd7eTHo2L045YrtjebAebCgDaa1enY=;
 b=X3mPhnNmhXNtdE6Qa/S/8CPhIcBFr8c/N6AM3p6NCsYAJLTovV8U6/W6OHnsnirb8CIZ0MQuHesdEHRtqntN1TzeUN62rCj52d0ZPvVSRX6s7Cj7aGoSilwP//1pTJyM+u4qlKwke7DgmfQ12qJtBFAL7NLY7vVfCaVQ9KZV/jamrIDMxQMYR4L5JiUN7qWvpHZX9YtD0+UmttOts2QCnWTQCtW1zCyfTZYXcD9ibo1nXiTaQGPjKANA+3orP2nE//rQdfALnXzF0/5txcehwSu4MrT5eR78KY4jdZ5S+9fNyIYaf2Gp15tRGxBC9MLpGyLc8VlVzyOEQwI5+oqtKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6728.apcprd02.prod.outlook.com (2603:1096:820:10c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:07:45 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:07:43 +0000
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
Subject: Re: [RFC PATCH 07/38] disas/riscv: Support Zvqwdota8i extension
Date: Tue, 10 Nov 2026 23:07:19 +0800
Message-ID: <20261110150726.8221-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-8-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:510:324::11) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 158cfd72-840e-4ff4-63be-08df3f3c5f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|10067099003|261028144727099003|261102124527099003|261026140227099003|261102123227099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: lBLXbu3X3uFMuKTYCNzRjZRKHiOlsfcDZHetplI0Z7YEx0sYq5CA/D27+79Q2yqMAEYgYrSRpLZ6KosbTINRhsWovc/k7RseGzi0fmMj7qlR+OwbKYZ3skGVXEMpWhWdkVXzmQk2rBsT660v5GgFfE4TPF0l6yzWlRmfsCSDPGIIqQhyWw1Nj2plaK56ZTymHmpsnyb2q1gWtysuolkq+ShjTQuMT+dMVwERHvEYFro8hCtEx8CSX1G60ouzpAswp77d9sQSzYNEJXV6QuHAA8YLeHDc+0kgWjFV9FAGTTIJmzAzjc+dYq6tWEfN8JQhA3wA6RARp6ZpAgM90KyzVFfhGYanCYgkf7M8JHqY8IkFmhar1QznOgBB9mgV/GzEKnNqLn9sOvouL6Jq0uccP3i3EbsiYKGvpt3aq6km320xQ13Gh4oy9d0sJpA9wN6r63FRKea0NhUwyHz3oE61iEALF9gW0DGj3sU/8F1wZkDzGOfcY2lJzz97WxBKIBSdgGowMhNtssXZ+7J27PSbSrqYRylZmmpe/yp2MzhjD1VFbzbUUow4WIAueLUFSVF06UpaYX2nK81pFMeRGY04ZbdE1seU2dbG9tdE0309KklqCW95VClAZX0jy9TAh+4BHblZpf8IZr6FiJF3cJbr9/7KVrzQ7L3ovnES87J4Yak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261028144727099003)(261102124527099003)(261026140227099003)(261102123227099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtmGwD9EUWl4oSKmOmVtx3VwGrL5etgsiitJR8jcbZgQVbFLqrX+KBxW+Qvt?=
 =?us-ascii?Q?LdvkKP7corAouyGQwxhiINwHfnHrMckRhNA9TgR5KHXHfoOHewxSmSgyn0CM?=
 =?us-ascii?Q?QGMQxWNmLjkBJCxm53ShoCDFXNyLU8NFBD2Qqq1iZUjY1E+j4sy80w6V63Mx?=
 =?us-ascii?Q?sGB54sZgt/9b5+4KhjMnX4JSU4BmWPhqWVii+m8jqCxHBgs5VEPvuY//TwTP?=
 =?us-ascii?Q?LHi8K8irj522X9lzZm/5260z8gkC/A10GuLqEFr3N3SqRkH8ehRsrRqer4c9?=
 =?us-ascii?Q?pNlnAj5PXaDhxleoT2ALbgl12OM+zXE+bqQA8pYMGjxMqTZ9GbRQ8x324gX+?=
 =?us-ascii?Q?AfHcn0fgzxzurApzJ7p8mLE+P98ydmTYwU5c3cu1RZyNulU/xHOUoEnitv3+?=
 =?us-ascii?Q?syybQwyUgFSzlWVpT/xY0vvuGZ8GSeZmNK25Z36h7EXXytzbtAUI0Gjq/Viw?=
 =?us-ascii?Q?ZnEKLNo1fpwqpEx4faHRFIKJt9m9s69oiktLsCrFu037FooX6YEnkgURLKun?=
 =?us-ascii?Q?bo7tChlk0ILvVhm/ktV3QC2QrwZIyVGbHAJIy7CdrQkW1o6ZHVLPWgZ0bAd6?=
 =?us-ascii?Q?KsZ84/jsiFufuzoE/v8w6O71NCge42GpCdOeSG0DetbfanlkiGzdS1yj3lYL?=
 =?us-ascii?Q?BpyGGHe5UgIlEMcowadQRo1Dn84wlFptzePLpDW/7aG89Ia8QocAofHwWDh7?=
 =?us-ascii?Q?vTCWco8EeDMXb/4tJYcPsgUcnvunBWP6DJOQjRFjouNodJ08/7xZ9THaK8Jq?=
 =?us-ascii?Q?p2/9Q1vzf7rL/WbFsjZGatFGhv5mXgwngAhDEEVjoFg8jZHHBozV8qfmEGij?=
 =?us-ascii?Q?hgXExwGRLZwxWIEINe1hX2iOHFuxzGSAZzZqgvSUNH3j4tTtln6vfvBzh26a?=
 =?us-ascii?Q?AILv7C+jZmz9Xpa6miQ/8wFWuBfTROVArv9/PNI00biEhsk2Q2VDckLFFIcc?=
 =?us-ascii?Q?Nhv1OehkPNewCR7CSOrj5b0sAksjmTZ79pNmJjOThhexQZGSMPqHe4FuBynl?=
 =?us-ascii?Q?r3FqfaEjjZATGbtsETmF2CtEVu36pYkOn+XP4gdeBw1V8Vmb6eYOyDKojptF?=
 =?us-ascii?Q?odjZ+69ZhIYRjEvVR2lzqXYaAzg07ouCH+tczmnDfQ8Ty94WyFdnWZVZNz/+?=
 =?us-ascii?Q?4KW/cBhOhYJ3OdFn5k42YgTlh+A+WAr5p3HjlgJZGAA6zn1stR2fEr7eIfbC?=
 =?us-ascii?Q?2icJQBgdyDBGzyNSFT/hlISrIn6cJ1GACHgdDRH2TCipMijBIgxW8APEXujE?=
 =?us-ascii?Q?seP/jKMyKE5WbANz0/9533CqQde0NLtkKQT/C0/nwBD5j3++awOOJOo6CZwf?=
 =?us-ascii?Q?yHKyhjQnv372f/9zkMD7Sl1AIibqqNoeIcbMY6YNnaDIxabgXeZqI61t9BMS?=
 =?us-ascii?Q?bRE78AYdJIeoIRbmDzPeoWBn4TG0j1sw47o5IsYiLNm9MbGLb/32M0pm7CRx?=
 =?us-ascii?Q?yB5Adbc66M88UJjhGSqkpMoe1PLcPL+RBTw1ApMzW5B4HEsATd0lU2CYA461?=
 =?us-ascii?Q?pwZjYPk3cXbuOnklitIJyer7vPNgJET4LpsS7RrRnB4aTRXwD4ASj95uyXbd?=
 =?us-ascii?Q?q1LePVyEplRBYSaqQUY3p/36PYv2Vdi6rTzi0U9ByACdA5aE33p8qkj3NkgR?=
 =?us-ascii?Q?fKvjV7AtKSf5Im4opZlh80H6j+bHDpLb7RCNN5fGFIdYFlMiKGl+yoHRH3L0?=
 =?us-ascii?Q?KGQoWRf9ui0HaadY82/HWy+GW60raG+V7h56tRrJ81YjICpm+QLQfWmUUXg8?=
 =?us-ascii?Q?Jxjycvva4MBPG01n1ztWBADhFTCq37w=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158cfd72-840e-4ff4-63be-08df3f3c5f1f
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:07:43.7981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i5CesxHJt50oPwhCFw9/C40qNfmyjIQXvCvRogqhkEllwVxzioX45W5JhlVnHjCptZEwUweQBrS2O3UUs8LCaXQrveOCVZcZBstqsKzNbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6728
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:22 +0800 Max Chou <max.chou@sifive.com> wrote:

> Adds support of Zvqwdota8i extensions:
> - vqwdotau.vv
> - vqwdotas.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  disas/riscv-op.c.inc | 2 ++
>  disas/riscv.c        | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 425473ee61b..ec767ccbf8b 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -770,6 +770,8 @@ OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
>  OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vqwdotas_vv, "vqwdotas.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vqwdotau_vv, "vqwdotau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vredmax_vs, "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vredmaxu_vs, "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index ca0d6e90b37..2acded0c915 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2634,6 +2634,12 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>              }
>              break;
>          case 29:
> +            if (((inst >> 12) & 0b111) == 0) {
> +                switch ((inst >> 26) & 0b111111) {
> +                case 38: return &op_vqwdotau_vv;
> +                case 39: return &op_vqwdotas_vv;
> +                }
> +            }
>              if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
>                  switch ((inst >> 26) & 0b111111) {
>                  case 32: return &op_vsm3me_vv;
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


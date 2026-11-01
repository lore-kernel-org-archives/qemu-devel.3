Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Q+AVxnzH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNPyy-0000K4-8P; Sun, 01 Nov 2026 02:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xNPyx-0000Jn-0k; Sun, 01 Nov 2026 02:27:59 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xNPyv-0004IY-K4; Sun, 01 Nov 2026 02:27:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu03cWAaR0VytIZxvwjDpLZnS7QTiUhN5vmyk1IjZXLVCj3aRNSOfyEMmflAWV6ihyHm+a/bjPnGG9OjvuDBFL6X9CbA9hddfu94+3iClf6Iv27LU21IxR3a0Sm82PakStDls203N/FUtIWCe1uHJY2k6vsOO4FRoDVZ6DzSL3x14rFlbOPVrjTKKDXo0B9QcqOzIESVnBUeaQMK6qpp8DHw5vmwrEZqnbaVPoIgLc3cdJccQFwLL2r3by8kcOATDhMZBZJaCKIfeu2JzUPK/4dofYJiewdJpTCaJQ5RDTcqLwYPZBeFREua5IbRZ3MRclI3978kKw/dTT+tG01bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYAy9u7gQrEPvqB9TBQOSNz4VcUTtOCEmgcP322n7KY=;
 b=m7m0L00uZ5QmT0LJ6mbT6O8IO6SAkNkL+z3IwzqfuE9UQXDvKTFPyeKrXFFudfFFRxqBpE5vZ8XYGUY6cq4SQxJ2jApJozy9A1+Kvi3pM1/+a5ALkTRZm6aGdgrCfs+X9PsXHOYcUmydWvit5vukOjNPa6ed4QFAcGnUIhTG2dMch3o9n5GWbcbZ9k8kfFFWfQXIns0SDGaDcigbfxkK5lbX7MfpQXU7kA/hkUV8/pFwENXEvd48UY34UEDKtldop1JRZlH64vdYpM2HyvCax5GVWUz9MYOecFUs3UoJJZxn+tsd/dUVXg6Y3NkoXBB8pCi1eJgcxJDwQwjD9s6l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYAy9u7gQrEPvqB9TBQOSNz4VcUTtOCEmgcP322n7KY=;
 b=Q+AVxnzHE7NNkhpi0owI3c2Q0hsXdfUpDN6CAO8O/SpIiTm7Yp057CYja3psALJAcVI9VvgSL7KFjunvIiVXEuyKXdOPnu2l0yFlMdiE/DpFayMGVelP+fNNZ0xjrFBvtTjku29tCUdUblTE6glNahUaM2dMHlxGGcCGWoqNv6Wi+fuZzI/aK9rgo4EOm255VIzXKaCAZ0+OHQOzriEcnT78sZD6CVigFHr+/xrW/ArjyFZilNhXu5S5HuLg2W29lnPJoqJdi3yEn+NnsyFr46kIe3OKD/Y+OwYBRM428W4Z2zECV3fQeZ9eSo+oeihYd4WuYPPdZiSfH+CufmiNfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KL1PR02MB7166.apcprd02.prod.outlook.com (2603:1096:820:110::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 07:27:51 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 07:27:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: chao.liu@processmission.com
Cc: alistair.francis@wdc.com, bin.meng@processmission.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, palmer@dabbelt.com,
 pierrick.bouvier@oss.qualcomm.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 2/2] docs/system/riscv: simplify the K230 U-Boot boot flow
Date: Sun,  1 Nov 2026 15:27:35 +0800
Message-ID: <20261101072735.3767623-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <be072504dde1626cc88a489805be5a988580bff3.1793433265.git.chao.liu@processmission.com>
References: <be072504dde1626cc88a489805be5a988580bff3.1793433265.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PUVP216CA0004.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16f::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KL1PR02MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 750ec74b-e91b-41a0-3d4e-08df37e9a264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|261009223027099003|261021121427099003|261021123027099003|261026121527099003|261022115727099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JtDMzh6aO1MYzTa7MawiNkwPJHKyIfU60Zk4lUnqaFM9pOzv4EHEwm7d1AKncUm8CZ2VHowaRp09L7B6cUuajnOfmFaQxabKc1FLDlVZRftGhaj8KzjnR9rS9FhnfVhS468WEYM/I7cGSOm/gwfChWwouij1VMotBsk161hQEgg9Wgf+tZ26N5mndIvAqJw1yj/+tww4Q9p+W4BPMFm/5Oe7rYc/c9FGJcvIvLyQf/ldGsn1QKbU8ZMixbgRNd1JuHFb+e1ems+N9o6TpNJwqYvbGcHIMmu4YUAgzZxeXkgHRgFB8Fur4N6+X6vM/hXuWBKtJ2q4vLZOAWa3CHQHqUn7psk3FQUTSZF4igJpNuYGAMxTEsw+HYAr38VG2qwXhQ6M4+Uo4ls6y0gGYwRbTvVHzFmEi0H0n15qXAkeR48xMW1StMZJ27r18/gqXT09ge1Vngw1kMHfrR1P2P95MLbX/KLo672NdOKYQRQg5mdBc8DKmW/ma3dm2diKcKuVJhCuXgsaFXYKIEiXcldItlhUMUXlRuzr9fKv6BatdlY59bllBU6BTlNVNg1dZxLmCM4DZu/hwGwRE16Aq38H8fwSaEt21n6Jpj7+I7K6jAii6v4lWZQQWZ8s+6a6qhWSy+LHb2IfS64nKiPHj/b+TE+dWGzGHXEh3JptmFgZSXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022115727099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpMOOAgnPBAGtjfwqYlHUph31Uud4JiCHYFWI6lLGIrP4vRwdHRSlREEYLam?=
 =?us-ascii?Q?6vXihqPRdXNRGBLTzreVJurO1nlpf9iFwLaVVysdUSgYXWS2Kx56/xPgdjxr?=
 =?us-ascii?Q?gyF9IBjuXq2lRJhSxw4JpoSHyD0rLZaQbplbZGMdC82+/uIB2Vm6RF34GLHq?=
 =?us-ascii?Q?UyU5i3Ee58XMcrVCD8DNn/toWvGLCZV2Uko+chdok1yKd3wCktedK7TxL0dg?=
 =?us-ascii?Q?bOQAhdBS9JK16SFHJJciQo4wy3RLgaYsm2V4SZRwvWSU7jhX7PD7JoJs5ytb?=
 =?us-ascii?Q?XsLYCzY5hxztdHwL/6AvSu8V4g4KZSueSXbGouTVhV7RdBB47gfwZUXXvrw7?=
 =?us-ascii?Q?gVqfWzE2Oe0Sk1BjGKbvhJf2dByM7I6vs4rfF8Z55I66p8neAPPnhEIsiO6J?=
 =?us-ascii?Q?WydNW+WTOZd3aHGh/Ul1K3j1MGmIPBeOXzeykSJcGn8r6DWS1CXYOq64mRQX?=
 =?us-ascii?Q?Q/qMMzVAt9+SY258GP/OOrYX1YUvdlGVqUAnRjZk2WgQg1/RZQZOQjaZ4GId?=
 =?us-ascii?Q?1v/hl2ZlPorz8gY74ZpoOFsFadUrYJc0kaOInUoqYUOeOllsMT1EWGnYEHA3?=
 =?us-ascii?Q?RBEvUprM90sc1guWXAQ610/yAbIHW276OOmR/UITao3XR44br1hC1GuVN/is?=
 =?us-ascii?Q?GqMnu9U/4W8KLXsdEaeaJn/zctQ0L4xDj/mS3N86cb6adgJUxtP4FBhgKxX/?=
 =?us-ascii?Q?uK/zR1MEnL+vsoNT595YvRVTCNl+hOuhdLzZUcW2CzoWzl0hu2HI6bGk54ZK?=
 =?us-ascii?Q?clCOhDFnIg6n3dLPhZAEi18CbjSv+/cmxKK3Etu4bx4cVTtiXeRFHg0m+YG6?=
 =?us-ascii?Q?IQkz3V/nMRXA3uqj4HOzhDEUBHwDQOK+GjxxSMd9L/wEMO7RxSzj0wGhGQks?=
 =?us-ascii?Q?rjMrB1ulVYfyfh0ZoZ2NEMLEwtqkfe0/O1YrJsaL0O7Tv2Co/iO793FuNkBI?=
 =?us-ascii?Q?nSWa//xjcg73Ql9ERY1/qkhgWcJRYEcKi3dtDP17Qo9ndHxGvfVVRYE17dxC?=
 =?us-ascii?Q?Oz+tagl6WVxqD5h9go4qxZQorbANgoCm8HEgwKqeFWy3yjPiADrt//qU/UpB?=
 =?us-ascii?Q?ZpK0MmvclOY/gFLEet6IZe/QbVSDk8CJlLXIdMSGX0kTS0UbXakkmLQ/WHul?=
 =?us-ascii?Q?yK5FjRpOqrx5CVplT1VxqzJlHU5FY3rYKaYg/o1SKHcBsaDgZ9SmE8xWdcwn?=
 =?us-ascii?Q?eWQiKOFEeqcVDgMCUJJt7bBmvKmrpPbo1A3IYQnmy/lmcuz9LNUAXpqFTDQl?=
 =?us-ascii?Q?J7GqzccHOqyDnLRTuHGrI1U+2iSHMrHN/mPEwkvkz0Lwb735B+/BCEb1FCvz?=
 =?us-ascii?Q?M9HgIm96YF4bks/UTOIy1hyiklS1Br78UFj1h6m0dhQ89LSOMfReX0OSixEd?=
 =?us-ascii?Q?LR220pEfUsvHlswyrMjv5aWV4+SCdrI3QE2h2nIwtu8SnJJQlnWuqNfTCT28?=
 =?us-ascii?Q?TPgG3wKeTbIEZaBExBcnGqjSz/1JmacPhs2mjOAE1eFg1fPlEp670f10Vtdu?=
 =?us-ascii?Q?/A10bWdOaKXz1BdcKQIJrPthAjp+yx8q/jRzkSQ8mIMI1OV27C2FwbU5mWsT?=
 =?us-ascii?Q?HKnb8TpSoQ2rA1aJi8Llp/V0O6Xzw+MFPs6LQg7cIMqwatB0OalMNVzf42j6?=
 =?us-ascii?Q?u2ThqANdvsHc9Z5u2B14nH1CZXrv8kbPA1MEqUI4bjAblRh6fS/5Dck/GzN0?=
 =?us-ascii?Q?jTmBMaC/2UZylqkIJL/3Dd1fVcw91RRbgwVjorXqZ3SPpFu7RxYvDyPV0lYO?=
 =?us-ascii?Q?UFMcegNxbk/E8wz7SElfyKaeFwI5dyk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750ec74b-e91b-41a0-3d4e-08df37e9a264
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 07:27:50.2777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2TjdtqIGF9cC/Wl4677a8VxlGDv5Pa/JykieBI7JoroibimB4+2j/Tt6qHqwk9yZHacOB21uku+KBJyegTUioDeUo4OZVCKCXYkgU+C0j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7166
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Chao Liu wrote:
> Update the firmware booting description in the documentation, and add
> the QEMU boot arguments for the K230 images built with Buildroot.
> 
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---
>  docs/system/riscv/k230.rst | 60 +++++++++-----------------------------
>  1 file changed, 14 insertions(+), 46 deletions(-)

Reviewed-by: Bin Meng <bin.meng@processmission.com>


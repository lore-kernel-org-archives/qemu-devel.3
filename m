Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEF606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=oD3IoOj9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4T2-0006mM-WC; Thu, 22 Oct 2026 21:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4Rz-0003Q0-OS; Thu, 22 Oct 2026 21:52:08 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4Rx-0006TH-E8; Thu, 22 Oct 2026 21:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzYVCNSDkSXjfDq5mzh5XvnydIKwWkOtKZeaNPOYAqZfG0TiX20FSG7pZbCkybikSBkg09kzwghfD710HHtWYW/o9t2dkwzTLcXjE/2YSC7uDVAB7kPPhCpG7e0BWcpEQOdPQBBeOPJDLPaMDTBYU1JHhliEnr+B0mUF5iySf6qkYH4C0wKoQPsi/AOWd+PKECsSttd4VjaRUec/vp1HeJ/nvQN6fyxwns0kk87+N+rn1yY/MkdaZc6t3FGtTDUXvq/WjtKa9WEdIsBc9JPlgTifFI7SrJesqD3FLFCSHJiWncXCRJdwoEL0xEGcBSC/E3RRzdpkhESRYFhzoqcvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuli3XI/RiEgt/hToFn8JFALxqA8HHpQbbI6lIj2sCI=;
 b=szw7K25AXrf/q5pEMxtmCGZzRY8gtCaBkTIojf+0rWhj3T11SRhGPYMYa1ft3GZJToorDQPLeH888Wl472y3prorO3We0oxBLpH1rXnCYqX0Or4XyQfyIxLawDWfmuBkXdiBq6OENphoAC2CVwuMPY8umcljG2pkhuvNlNVAFe5q8166X02gUyUHs0ss9w+LJAA+s6E/LATjrqcuT4mH6XoQ3gKbTGfvC6WBGPaSqWRb87BoJIcHu42v6VMMS1xoAFiD5+0H0yoGQtg8XBR/er9xfxRQlcQ2N0PLu8LTPPRKlfUFt2/8B12NdjrWbbzDIQggJnSNiorzhF5uG/4pBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuli3XI/RiEgt/hToFn8JFALxqA8HHpQbbI6lIj2sCI=;
 b=oD3IoOj9DaoW9sqCBP3RqJI/4oLa6YUF0Ue1MoMn2YXlbUtFbuFPJZHJ896rcj0yXAw8quoTEdXUn/cUuymyDgR8l7srDWUTKGbo8GJGKbjuJnMmYZlrJ6mTKehNIBFwjZQvWVsb5EbBgR0+clXNIYWiIqtUZiai+xXD1FS5HA2k+PV7ZNMuoNksJ2wuJDnMzOHjbUJBvEtmXckuQkYhNpIHHIfPsIm3/IAQA/rA0rLp13A9SBQxeksYWiJvr1yF+PaXwmEfhMPP5oBTWQhmAarYOmsJ/0RW/Wok+bXTNOEBv2rTjrHzziXmT+LWLbCv5ZQQ1e3Hrzu1NEU+7YiiKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB7544.apcprd02.prod.outlook.com (2603:1096:405:4b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 01:51:56 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 01:51:56 +0000
Date: Fri, 23 Oct 2026 09:51:50 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Use 1ULL for a value we're going to shift
 by 63
Message-ID: <atq9dL8HCwRuUpA-@MacBook-Pro-4.local>
References: <20261022201037.764619-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022201037.764619-1-peter.maydell@linaro.org>
X-ClientProxiedBy: PH3PEPF000040A9.namprd05.prod.outlook.com
 (2603:10b6:518:1::4b) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 4786bb22-34a2-4d11-f2c7-08df30a8380d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261021123027099003|261022105027099003|56012099006|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: wjFIeLQlcFjRkqGEgLPn2ddjXnKTtk0H7DsijIlSlmmFdIBCeQsGS2mdSRjmyqOUwhdC+6nGDWoZKoLQlIo291MAupk/Z31OVFaet87598tOYme3fgfBH991t3S+LnjC6g51Jex2t6LTndkC7LYLnC8gXYZdCJmLULZEdJMEd+YiCbiB8UPLxYvUZk/R2QSjRkhpfSYw9p6StYd21pF2qUDhiSbejz7MXw8jXziC5+rM8ZQfKjg4QONzJt7m27qpWJSQphRQ6vEYeoe1c8H2NiSvtC9YgN9yyG+6ZwjiytGTq2/fvMMmRtb4o1SYploPhkzl6dG33HM5cIbqJhYq46Q0sMND3JCsUlMBlD2tM64dBtdjxFTwdG9SeLCyxDVst/BHUnhuUhKCTa8ludxXqu21U4VM25R2vJmzvV0Q4VDiHdMwv0mHANG91DJDtuCuGtZKd0LJ0lN5lm2F6u39VhCDrYDItRy+xrHxU5ybH2/gp0uYINNRU91uoWhpo8sn/kyTWys2LrfPa3VGSTm4a26PNJujOCV/01IOXg/l7czujCTN7/Lf8gHqeARF3b63SIspdHv4PWOsUpQYuNz/igFSdOSEWGb5sg3cahPGySpDupkAFdOKGNZiXjyH2cYFVpXfurZ0HjNpXLspnm3s89A7MX0CpzEnW0JughbyZt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261021123027099003)(261022105027099003)(56012099006)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQGBvn3uofhRGRHWn1maaXFFrD8S9uOAyME7YU5fs0LJP2TbvRgYzfmpNjzR?=
 =?us-ascii?Q?wdOmM/C3rOL3M5Q5BcKx4m4zXAxQCPXfZMcNBo5LUi7VXlTkcMhD2QK9r5kX?=
 =?us-ascii?Q?aUkUOnvbaUYjJ/kBCFnX5mTBggVzEX7Ku5W2OSZXDExRRkDaWTfrapHhRKkM?=
 =?us-ascii?Q?++ZlkDOE5hIte/GM0ECrGWm0K0EaNTa7IYebArOrAVPSqkP5tcRWpuj5Eu/S?=
 =?us-ascii?Q?36qIfoRxrFzsg7Q7TvdL0xqkqxrwJrWVQWd/Xvp/lLbPq6uH0+Z495dq6CnS?=
 =?us-ascii?Q?t6SldW/exRdUSNwIUl++mDzZeSvyngAAuoEh2jIWcJ6BAOwDHybu811E0i3y?=
 =?us-ascii?Q?lqo+oNprabOpUmzQDidNsfB884ZyAG2+2DzUoMC/2krbUR0AwoOPd9o/wX2p?=
 =?us-ascii?Q?3mNqWSrB0OG+HdOgesl669C2klfIgZMCCN+6g2hIUCJiL9DODubVXMJ1CcTX?=
 =?us-ascii?Q?xBz8Ct8j5oNJCbtVhEpRmCFjj138554oIHP73LJ53kNZuno5NCWiTSOuE0su?=
 =?us-ascii?Q?gZPdDxsY8+RRnB/HrK7FlmkebDiLbwaWfNgZdE2w5XxE1e8Ksz+z+OSqa5jz?=
 =?us-ascii?Q?/7N4IoOhVO3I/pbUzGgQ7+boeJN1/VxURAyJh4rxzONhOFZuutn7PW5P30Nl?=
 =?us-ascii?Q?xWLAUYFmGoOysTcAKE4eTjTnF7cbdBoG2v62BXHq3qJ9rGT+8RiVbj7+9ALy?=
 =?us-ascii?Q?T4lCmtzjllPCaPEFkWVrCzRE7aaNvqkVDFxuonIZPdD1yAW88mJwfD0IYk0p?=
 =?us-ascii?Q?xTEhHlTTT0P8WIdiaGSkoxqtA31UVDF/a1KZvZEJpoxZq5hfhdTl55K9Y7bE?=
 =?us-ascii?Q?S1IZHWFNnsLxvNHMpfz9G0GLoziuzqG7p0MnT10uisJdnW8DfxI2aIOH1pAf?=
 =?us-ascii?Q?3cOo0tfT9qyxdD/bmKS6BXLTL1FirnfI7E/susabD1GkCNj0sTFLom+Dk+P/?=
 =?us-ascii?Q?UWZIo/yd50UElp9M3ZIEf6q1wh6m9YEzlbDpTUa1pZY+08HoJRRbmyO9n4z4?=
 =?us-ascii?Q?vBrVxZyDHXH9qSEhsCHJcZiaYRK3iUoH0CGISMxtNpRTGB7tlVVor6XWrIdw?=
 =?us-ascii?Q?PS6hqIj+VVm4b7d5R7vpmLCr7xXzC9ATje5/LvniZdKQF9uwDMMa9KDd5LEH?=
 =?us-ascii?Q?TeNFQ8Cog6HAPY2krlMctjOS/yuDbL5I6yt86e40YNf/uEF4YBy7O8hL/Bak?=
 =?us-ascii?Q?WYSUGJ+gOZKUzqp4aIDHHYrAgYqeobOISE2899Y0qOTITb2jyCwauS8mLCPq?=
 =?us-ascii?Q?QBplkzzSg+n35he4W9fLMprVKxqebeOhviedBbeNAPnNgzXBCF0dXAZxgdGz?=
 =?us-ascii?Q?tbvJGR2BbmmVZwQg7hcZ7UPsarOoaXfUBUJ1N2CHRIuDdDNRU8HtikYxtI6s?=
 =?us-ascii?Q?rZDuNmZ/pzG5NsL3hsjp9/b9AlxEA3TwSbY99bST2hb2qtc991rQMNNX6xwt?=
 =?us-ascii?Q?1LuGH6vHMI1fjK3BQddDoQxEDFwgOcvlWPaDOnv1bT15LmvY5Jb6Rum82s1y?=
 =?us-ascii?Q?afwASdahKW0iY2gZOfJ+5zQRfo+fKQhro+sG8ikvLDML1bN9LPVVpmGttHdb?=
 =?us-ascii?Q?gNEa4rq3DDo1ppk1Sx0IijLyNthplC2P0FT78PT0z65MzvU4WZ1Szluh18Yo?=
 =?us-ascii?Q?/J1qan1YjYJGCQQx8pj8WSWlCFHXgjyvukC8fWnaAO3r9pEUoNotbyufn/Nz?=
 =?us-ascii?Q?r3WYxXx3NLiPTAYmX0c28aRcA4GBAdUPqiLrCSRtKEjAcJ3sS85L1rE2dQSx?=
 =?us-ascii?Q?VIaGzXrzrwu6fjiz+Zgl7XabaBN8sEA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4786bb22-34a2-4d11-f2c7-08df30a8380d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 01:51:56.3801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPg1e3OJVV8f/yZ/VOkbnb+PQtNf4OT85SCI2Ah8mf7jbd/jZk6dH5RbHd2iJSWpQf9R0AaL2c2N/Cgc8zYCxKImgVj+Lvp530rqNEk06P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7544
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 09:10:37PM +0800, Peter Maydell wrote:
> In prop_marchid_set() we set mxlen to either 32 or 64, and then
> calculate
>  invalid_val = 1LL << (mxlen - 1);
> 
> which shifts the signed value 1LL up into its sign bit when mxlen is
> 64, which Coverity complains about.
> 
> This is not UB for QEMU because we use -fwrapv, but it makes more
> sense to use an explicitly unsigned 1ULL here when we clearly want to
> be treating it as an unsigned value and the 'invalid_val' variable is
> of type uint64_t.
> 
> Resolves: Coverity CID 1547552
> Fixes: d6a427e2c0b24 ("target/riscv/cpu.c: restrict 'marchid' value")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08a4d14ea1f..d47a69bea7d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2298,7 +2298,7 @@ static void prop_marchid_set(Object *obj, Visitor *v, const char *name,
>          g_assert_not_reached();
>      }
>  
> -    invalid_val = 1LL << (mxlen - 1);
> +    invalid_val = 1ULL << (mxlen - 1);
>  
>      if (value == invalid_val) {
>          error_setg(errp, "Unable to set marchid with MSB (%u) bit set "
> -- 
> 2.43.0
> 


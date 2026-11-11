Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=mG3fDzot
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0GR-0003Af-3U; Tue, 10 Nov 2026 23:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0GO-0003AA-8d; Tue, 10 Nov 2026 23:48:48 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0GM-0008Bc-6Q; Tue, 10 Nov 2026 23:48:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTgxDu+vKzCf6f/jdLATko43sI9mDm9eu06qpMY34cXRkH8HGiEXUY5N2CRvh7oVMh/jx/QC9XDfF4DloRYEsv63IZCeud7oWi+aYxzFVFuebs73isuQRlDKIcNYdIKADW1KsdIFc4fyBceybcRgH1vp6bm9euLGhH3uot5zUV/QZEl8ki8VbJEttL+So3+t9IhUoMlFspurFqm2vYRI15o8qgIRcTc/1KF66uAF1XPF+kuIxwDjGwtHwuElgsLP6ULdfb8arENuaqj0xAacUKmmFL/Ru36NuWx88HzBoL+XsOS/3veY2tr9r01Ojsf7SbfkYd3VIX1s1ZWa8zMAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKakcu38fxF+xw0bLWAds2ScFvaN6n1ZBlMw3fal1/o=;
 b=jVvmBa88OmIIyk5m5cfvL7q/6Iclb42MEEi7MJYtsn8DXW4uyQiX4l2Oqvea1FGyq3U+GCp9lxMmpzjNdIiXUL4CdqzyHOvUyC3Kk+aLIToTOxL+nnB7tbiWCKNyKOlrDz1G1qYS2WFsMn8u8uTZWpkQq0Qwu76XXUZzU9d1cHX4+RBn6Vsr2pHJxQRLEm3UmEdQc/kakELWt5cZG1sSp/4NkB1SiXGYVavfsMfaI108b7TJIiqvXbcgwnNkFdciBW3dtZ09pd5KppPZa/UtgME0ZazcvU7nS0etocGro4vQRK//e2EJEB/ibxhS7aqOVO3irS8cO5p8c7GXdN8eyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKakcu38fxF+xw0bLWAds2ScFvaN6n1ZBlMw3fal1/o=;
 b=mG3fDzotlBT2SmHl7cS8LzdnExeUruN5oJUJr1gXLMY8ZSkAFHX8DfNcUdFl7MtbudEcQVZt8wdU7Cy7RprmiYgOSdw+YfLRjDHVFd6yFvywz3UN6873S9Kao1134ldUIramAG2Sr5WzhetLKa6DDBcodapQ2+maVyu5vio0rbgp2bXyrP1ikClvTfYyCafsZfzusViIVmXVuwtZzQM9EOTJmlB9L0rS0fziuBjxyoG676d6w7rjPUP3gzTC9kJAE/VhGnxrZvNAPVqyr2J6BfqiB6M1zDFaXBVYiFC0gW5vhE66IEC58pbm5R8sAdOZfT5clOR+oh1L5uEUb4znWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9599.apcprd02.prod.outlook.com (2603:1096:d10:a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:48:36 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 04:48:36 +0000
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
Subject: Re: [RFC PATCH 10/38] target/riscv: rvv: Implement Zvqwdota16i
 instructions
Date: Wed, 11 Nov 2026 12:48:17 +0800
Message-ID: <20261111044818.75993-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-11-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bbd577-f008-4120-ddde-08df3faf0b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|10067099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5EBR5+M74QX/XUHrlHHRexeBpyL6090CRyB7VNoSWlhSvlmzWLeXutgluko+SgZC9Wene1q7ncQi8yMK3DZtqKNhx9aRmPyo2u77z5FQBYHBXiWfxapiDsM7JB2eHqNxJq3cSsXun8UAtPzT1lWnMTrYS/xgDOAVi1ydqCr8YUDAuxQzsct5ec7QNhiTdGyAbmQ07YHiLVidOkl7RuM5LOXiZni6mf8CEISV8ZrfMDDNyc2ceO+D7sqevOHLVzQPyTuIFA3y6gKP3/Rz4yr3SPMZOZtasXmSgJnlhE69vlPa5QqGSTVtH7nj9SbpjuOqquY9bUtMbpeeFHmBBH4oCIEX75JkdcbrwPQfmjUtRp7q/R8EWVLcY4VXfXjlMI7xUoBtkejZuHa7j++uzMg3ova4mshkzuq+idaw9TqlMGYvgPNm4cstVfssTAFJkgsPAb3KlU3DsP6S9P3o3/xsheYm0j18CJHfEeV4rXGUsrvcjket7iR5Mp9ebb92v1OiMclhObP0muS5AW8To9xQ8wPndnWv2JXDVnZxB9WYNceQiR63onc2Y7IE6AUWrmFwQ5xfea9uuk9Ebw8YFkYw/QW0umzdQsV8Ife3+mJ5kw1xvA8k6Uo7Y06wX40n4tDlT2Y4LoT2rULjPhKVp2ZNU2KN/0BiKsPeBoSwCWYSSDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mywfwY6kUEN4XWztG/FFQlpALX/awRrtZd4hG35yq7D2F0d23TcomOUyyHlO?=
 =?us-ascii?Q?Xg0XqM7TSeO3di6p6hybSEB2rDLXPIMa1OEONkGnfYRczG3XIWk+ld5gHJPX?=
 =?us-ascii?Q?7nJp3LQR0MYAgnYRTZkYVrEjQnaPZO9N8jZiiE1cBwcLLRLDTI4SQlr2tIxL?=
 =?us-ascii?Q?d0fbFW0md15JhTOQAiRFr/Hhbd/TjSg1Eyh9w45hTMpXJEFai8MNAJUKMRkk?=
 =?us-ascii?Q?+WZWhojemtrDRseeNjLSlcHe3s/LvQKzl0zJf3PhBswgwgTqY4p/ewFdQ4VL?=
 =?us-ascii?Q?xNQ8JCLYs5V/q7dl3XcrB8sHSnZltUkUjL1qwoYG6uJD3DeZnGQQVyZ/pHAT?=
 =?us-ascii?Q?458/XGsNpCF4mzHRnQMAS3ZfbA+C2u91MELn6OES+Omik9u9uzToRcWoFNsB?=
 =?us-ascii?Q?qqpsU4KvWZQ77gs3Yxz3wP/ubmJuxyLnSbYIpWp8aofo6aB/fVLlUwGiWHcp?=
 =?us-ascii?Q?O0WYOJ5DWCFcYrvrTirSGQmvB940AnvMBycD7Q1DMty7Z5ZhKSby1IZzHDDa?=
 =?us-ascii?Q?EvygsgTqbh+fsKFsRSAfU+OFQEc2Nvy3s8h4fWIE54Hx7cfDTZb3WMnUAFI/?=
 =?us-ascii?Q?8cPrELqk3DIQB2FiN9AZ9YYNYQnQFyOJqJPz6OYoOXj/wA1/I3j9ViK0W06N?=
 =?us-ascii?Q?2OWRZLtnOOnoR/ht7mYMO05TJ4Cx8soQifogh9iuOmUwiDcqx2OXDCLqJzBF?=
 =?us-ascii?Q?GDr45qldAczwLv7H+vlufkek2gQx1TkBSRjFub+5PACAK155CJttemYaIok5?=
 =?us-ascii?Q?CWU8hibduY9c6dy1LxGxG5c11bbdgNO7JrxwNco4DEasFWTDehWzO76uuxGg?=
 =?us-ascii?Q?N6v+7e5PRr3nQHkwv3VEmjXvAclsk1Q6kLhvQi9IFW0Jwfj2//2YofyhKswu?=
 =?us-ascii?Q?e4+83zmhjkCC0/aHsYPvw1kW3FNhqFKK6PINEsbETGdzleLrAZ7l6BfG7sF4?=
 =?us-ascii?Q?SPJ/SkoQN6aegKnkqA/hfRufqgzybd4byu+muTbmWjqpwZqZu5bwt7A/9W4b?=
 =?us-ascii?Q?AKfmJFxuV85SWWql6inEG70omeph4vPQujGQi5ol3dM+ULHmm77S1BTiejvO?=
 =?us-ascii?Q?bPsx72wqad2MhCQ2LROfKGCItDYsXsMEnxZzKViZlm/g1gbGFe9DpwHNDl4L?=
 =?us-ascii?Q?iepN381T1fr2rkU6jBInw+NcQ3hQGqUiyrVi5xIUcqJwX4WAkmK4LwfSI59V?=
 =?us-ascii?Q?VL+D8FGVeM+YUUzDm6/+dyYFV9lo7DzlP41PnpSZuNfsW3VtR5YjJhTIpZcW?=
 =?us-ascii?Q?CAiEO7r1o2JVGRIWQo1tCTL+igqZcmUqG/NmZOl26LbvGMwLhTu2WHPmV8hM?=
 =?us-ascii?Q?wPCmutHp7QljuLuYFVKwaLNxg3Wxy8i8Sj+m3ZMOAZMz4qXVi2LT03JgYKPN?=
 =?us-ascii?Q?BJV8CwnvxkkUiINh9w4IZomveX89WkvNSSmgDeQcSXmuw4pFFuL+Dwx+VO8q?=
 =?us-ascii?Q?4ZF93TnD/ibD2OqTv1T9NKOJ0yibbNSBepTSugtNNUteMMDtJCNnZUemAiKk?=
 =?us-ascii?Q?ofi3m+yEHxt+84qbF3YM+hXFPqOWsuvh+3qan1Zm4TWgjT65iJW6EOoRgE7o?=
 =?us-ascii?Q?CI7mz0LKJE0UcVtEJfLhdLFDsYheoAbtqCC9QrNU6cKt5TzNMVL/BwJ55kP6?=
 =?us-ascii?Q?2QkJ3jxj5HjN6zOUI3t+N768JfPjFjQNGMB+6mt1ZICoz1oJCXc5C5zH37OG?=
 =?us-ascii?Q?S/knSSdNS2MSVg51YbL/RO66KwFo2WleDWS1ofOvD9YQHuKDnwSbgkdydTYX?=
 =?us-ascii?Q?IZ9uG5CEdZP31ZmDKtFAWp5IWw6EmK8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bbd577-f008-4120-ddde-08df3faf0b7c
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:48:36.0135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXFyuxObcyPsP7TxHEU1GBkBX3ghWC+EkrclWXHeZLsfozIz+6ufjur9yWGpcRyAi0rO3RUhoFdi38FIiO7l0gE6qXXDB3GdUGdBAZlb29M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9599
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

On Thu,  5 Nov 2026 03:41:25 +0800 Max Chou <max.chou@sifive.com> wrote:

> Extend existing vqwdota* instructions to support both SEW=8
> (Zvqwdota8i) and SEW=16 (Zvqwdota16i).
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/helper.h                       | 4 +++-
>  target/riscv/insn32.decode                  | 2 +-
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 5 +++--
>  target/riscv/tcg/vector_helper.c            | 2 ++
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 767b04658b4..23d3e9b3c43 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1387,9 +1387,11 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>  /* Zalrsc SC write probe */
>  DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>  
> -/* Zvqwdota8i - 8-bit Integer Dot Product */
> +/* Zvqwdota8i/Zvqwdota16i - 8/16-bit Integer Dot Product */
>  DEF_HELPER_6(vqwdotau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vqwdotau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>  
>  /* SiFive Custom int8 Matrix-Multiply */
>  DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cc7d639ab73..b8a5d0567b1 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1098,6 +1098,6 @@ vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
>  vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>  vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>  
> -# *** Zvqwdota8i 8-bit Integer Dot-Product Extension ***
> +# *** Zvqwdota8i/Zvqwdota16i Integer Dot-Product Extension ***
>  vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
>  vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index befdbf273e5..fcff472a2ea 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4149,7 +4149,8 @@ static bool vext_zvdota_base_check(DisasContext *s, arg_rmrr * a)
>  static bool vext_vqwdota_check(DisasContext *s, arg_rmrr *a)
>  {
>      return vext_zvdota_base_check(s, a) &&
> -           (s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8);
> +           ((s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8) ||
> +            (s->cfg_ptr->ext_zvqwdota16i && s->sew == MO_16));
>  }
>  
>  typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> @@ -4159,7 +4160,7 @@ typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
>  static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>  {                                                                       \
>      static gen_helper_zvdota_int * const fns[2] = {                     \
> -        gen_helper_##NAME##_b, NULL,                                    \
> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
>      };                                                                  \
>      if (CHECK(s, a)) {                                                  \
>          TCGv_ptr dest, src1, src2, mask;                                \
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 6d79fb5d299..57a381098f6 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6021,3 +6021,5 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
>  
>  GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
>  GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
> +GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_h, 64, 16, uint16_t, H8, H2)
> +GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_h, 64, 16, int16_t, H8, H2)
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


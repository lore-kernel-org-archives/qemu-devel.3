Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589E606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=qUcxnXLd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2Br-0004ND-PZ; Tue, 24 Nov 2026 20:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xW2Bc-0004Kf-AF; Tue, 24 Nov 2026 20:52:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xW2BZ-00026B-8F; Tue, 24 Nov 2026 20:52:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBc1aZ3OpScIfmG22MKr00Cx8xSiquvD+LdLRbV2eqlksYz4dE4k3GTutu0AQIoQtEi/P5NN1NUtVNDxdBs+OYUWvMw0UjxS5kHepoyJLbfvA1gorrgsnxxFqKGr4T2RWWbqupYDsClTeZjko4jDUWeTA2aiBvQmztu91CWMbNxXotwbk4blsHj/r8z3u5KZTM35Hp80/9dMlrlOEd4XIJKVzRQPUDN7Zq1siAsON4w5B/cw2UqLk7k/f/wIoKbIb6LZP51Vk8babs9IH3Qqvf7f3F56H7D+3zoaJ3FAEXj6j/RBLpNBCTeDM1YAvmKE0bfZ++vYQEwgLBKhZDMk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcbagO+tkHSN7F35+7J4ES09swwkCN4skbJWRNGJ7JY=;
 b=FwHMU8cGrQSnjFB1qe0vB7RwaduvZZN79zl+5rdHhXaZHZbei3r6eQLC4bjju4TCJS00ta/Yx/bjldAofC9c2j9HTI6te4fzjzyeFDtICZ1XRnUSG8QyRxqJfz6vwE6O9OFLEtvlDI01U6T317Fg2Gkr3NOVgmS6RJ8+mqn088LaORFBJrrqIepRtWB0l2tgEm8/HJ9uiDAsst8sZmDFDbaIXOgAn0oH7Soq3SSaELL4ih2/AGGojkXhOfDjgFEXW4ogRNedH6JWWG0DcoCaxdhZflJ08U5x5xDGF523YsOf/DTqr9gjy38ScMvzbv+7A5Oo1pYmD+LovEa+7yekSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcbagO+tkHSN7F35+7J4ES09swwkCN4skbJWRNGJ7JY=;
 b=qUcxnXLdDKz7EX6ireLOZVlqwFiBaUNX5M2YRnBtnKbSH8IA/a3N7GCXQlrhR7d8OO0zWz2mjA8TvomyyIh1wd2O0eh3ynLMC2HRabz6tUcKX/G5ecCJHc1pAMlyGWEegIJhJe2C83W0CIIXa6anYrCQQy+etYO+sO8PgV385AZpsJGfUTMXWB5nX/HOTNXpocnU8m2vt9P4toFtETlwTbc+yWsrvWAJeHPpbBONg8osrQSxSo2/ucIk2GRfMePCJDq2SEHushPIvKMoY0ZOy7ShpNBskUokpSUsaQsB57kIp5DptHIt79oXsyXl3HNpqSQRbOd8RyGAnl9HomOGIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KL1PR02MB6900.apcprd02.prod.outlook.com (2603:1096:820:107::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 01:52:25 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 01:52:25 +0000
From: Chao Liu <chao.liu@processmission.com>
To: WX Chen <wxchen0913@gmail.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [PATCH] Provide weaker memory ordering for RISC-V guest FENCE
 instructions.
Date: Wed, 25 Nov 2026 09:52:05 +0800
Message-ID: <20261125015206.92299-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120-fix-riscv-fence-20261119-v1-1-aeb9ba142598@gmail.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0064.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::10) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KL1PR02MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3485c358-e401-4391-3715-08df4a96c0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|261009223027099003|22082099003|261102123227099003|56012099006|10067099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 2DawRWfpKBESq9jvkTGi5VokCkqBwjoBm/yq6GpI7quoEgGyHysK6QMvpUnYXBTvMUIkZj8fyG8onKvIzXKbcYrjzcSoeRAkvqFb/+g9eBn5A11l9Qt1TiGyQFqPJROVWEzk+sDgLwRjQ+SkFN9I3TYcFNghVHdMIYGoi4T4LhMWCA8fZLILld7UQUoYdd/FZqDlV2mgehZQ5fpgqWiB1nBNrTnXw6vdT3Wa41G/WxaKEKUeWdsDbz8EPk/HbIxX1SjdIfzH6dLavoXPh/NhrM4ABMTv2a7nH/+cDCKNUr1XKngKtdsouBFNHNb3gHVXAvy2/pu0t8sLFxrw0Xu+B4zvhgznCNy7kxPdvNtHhFP+jbuCb0Sa/P5GUvymx8NaBwDaNot43AWvBo1R+qtkJ0ODhv/sGa3YozkTUC7hgkwTbc+dLFhNRlQ57sl+ycqkBrsGGJmjAPyLPioGq546DEcSjxJTj8XaFcZESJvamVLUpjTlO9W1wDcui+WLFTDMACucZa4MROlTpm2cDXFm/0gf+34NLQB+lRmLROqKDEmD6HB5xoQOsPe8SCiKWZH98urnxb0uHFi1zk3GVXQALHOPV/w26DRwLHqQNIdzrp4VaRae9Iy9wT0BujdDLhE0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(261009223027099003)(22082099003)(261102123227099003)(56012099006)(10067099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?76DudV64MjLjLXyEhzrUvTUAlhSXOoEjyVYMaFHE0qxVzYVjfiOtYPMcMsJ1?=
 =?us-ascii?Q?fDzUxdTYOgHV23JmOLsPPD2NsPdj2G56qJJej99mjgP6vny+q7QhuE9N845l?=
 =?us-ascii?Q?WrGJh1bq5pPj5rEU49bSnKumFySKfn/ip78u0F7JBgv5SmGB5slkT3xw3OPk?=
 =?us-ascii?Q?sb9neeafxI/++UpNADfLoqOk/SeNzs08GuVeIUlMsnZj7sU+TwOHcpoOrmLR?=
 =?us-ascii?Q?1Sddd2TevGtahMeo+WRoVJyCq2WbdnZhzJLfyU2XSbWXE8WfB5IL0vRLLhHe?=
 =?us-ascii?Q?ZCTt9xMji7v76dcHOCk/3+cmDL6E5ybG68zVvw7hJ4iIXtLPVkHVMGhrZSdq?=
 =?us-ascii?Q?xn6+VbV6B+8ID4eSS9Fo7N3S8xqcvpgrw+g/BXblQdBSUQ/dfWQXgvaTse/x?=
 =?us-ascii?Q?Uy6DNhSgbTWnEOHXtsPfIRukeYaG8/9QR0hfeuF9J3XObC0n++Y7TaYNJHwY?=
 =?us-ascii?Q?ICs5eZQv1M4gcBIOnBWa20PTE5JN+/6xgaEG+Lh6Fdb4pVD0UyIuXvTAg7zs?=
 =?us-ascii?Q?R70RwuzJzhiWT07DLhUyUYT2rCT1hwqnwXf5SJN4N2Y8jjgKDxSp1TzUIh1M?=
 =?us-ascii?Q?px88B8vB4UVMPcL0Sra8rBgelHssPv8s0F/MFSBP+l/jfi2vtMvL1nN+Mi+9?=
 =?us-ascii?Q?dd5VGihvFGddi5Tzn3rDrp8BzrfYUiLqpVLEJ8f+6/GTb480dmdnE2HjvBH+?=
 =?us-ascii?Q?w9sFP8GwuxDr17bmEXc7VR0rcCEVmw18FTM2aM03DPXDcIsDgljkOewPXNKM?=
 =?us-ascii?Q?/paMQE2pHQiGPNd3KN8purJ55QVGWDntJy3zNQZUWAwx/UM+r1hGOkPM9BJz?=
 =?us-ascii?Q?LCtWLdHGEjITAFvjIiHbZV8PbMOB6MrvLWw67HlSRLAKaKMQn4/6SCnVJmur?=
 =?us-ascii?Q?5N7RUyr/iZC9lxdaSTFpN8W6VJxxDcySHLYaPIvO1US9FPD6sKLPFta64y5E?=
 =?us-ascii?Q?WbtPQ+hDX7xZovfj1b+QZVXgsIaUtH9z2MvYiWO3XWwzBvNe9rZDxT3BEqY7?=
 =?us-ascii?Q?xPGTGI4/F4KNE2U1hC5QPIrCZUehENmePIiiWFTy2XUmzt4n3nC240sv6/um?=
 =?us-ascii?Q?/hKPuQkf1VZcXt5DwbYFvLIH7ooTW/jqMEc9TQahX2GvYY0uc8aO/CearOl9?=
 =?us-ascii?Q?XrNtHBaFrcKS1xn0FkylfR/kbYn0yGhja+txrTEkZc6qJTmLxpEbWly2uyz3?=
 =?us-ascii?Q?WKaJR1LhuizjGEvnNRhFMGp0gr/9d7Bx1vxG66oe9lNhnR0cS9lv+twtPsqE?=
 =?us-ascii?Q?Yc1/+PBB5VTkpVdWDDxewodVISL4BzqGDA0x0LsLYHlg8nYiBaXz9o40XUqD?=
 =?us-ascii?Q?g0a+OKNQDfnEMZtrmpBOhROFuPwV8Ecq7dVYk72mcnJiN7OGMFIqfYcUfPbG?=
 =?us-ascii?Q?7tUcFpyNeYCFnlHSMZGhG5J2IWq7B2k+TnxVs53qgJRw5MV6u+gwLcwLWl3O?=
 =?us-ascii?Q?tTSzFIlr7sn2Sf2o4fRFM7x5QoYwqne0xItU02vGeR3YIpOzqxbeeGy3Uh5q?=
 =?us-ascii?Q?DFGlKlqNL1iqM+qh/7AePJ2cujsdX4doe8dJkdHuCO7Ko6CXkdXimcvVU6S1?=
 =?us-ascii?Q?xCHZuRrA5FzaZfg3SsT6C9eO/0gHc/1YQlaKRg8rvLHGlC9xfNL61W2P6Qce?=
 =?us-ascii?Q?c171h3f8pcZdZ4V2ixxzBuEOo2rL5hHulbhSQbn28o09NAAXf5AL4ph893aF?=
 =?us-ascii?Q?lwB7Nwd2VzjT8l9IhrmmHzMwMFYFtYa0ElONIk6F0e0C+kxy0Sdj5iBEIz8S?=
 =?us-ascii?Q?b3imJ9GSaPkHKA1XlZyQmZJ3a9g3clc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3485c358-e401-4391-3715-08df4a96c0f7
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 01:52:25.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLhFh8HNJhLqUECJqsqeN/387ziDvzGgD5QBSDe6hPhvA2/tMPHxYO+92Ahg2pE35aNzAAxKb+2EvRD7nQhsvkDY6Nxkfgq2xPwjax1BdaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6900
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 17:34:54 +0800 WX Chen <wxchen0913@gmail.com> wrote:

> Currently, they are implemented as full memory barriers, which may introduce stronger host barriers than the guest actually requires.

Please wrap the commit body at 76 columns.

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

Thanks
Chao
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
>  target/riscv/tcg/insn_trans/trans_rvi.c.inc | 36 +++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> index 4784ea1607e74eb5b0076425a732b5d3817b3482..6e094e5886360c2f9f7c187e82e6f60da36b84e4 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> @@ -968,8 +968,40 @@ static bool trans_pause(DisasContext *ctx, arg_pause *a)
>  
>  static bool trans_fence(DisasContext *ctx, arg_fence *a)
>  {
> -    /* FENCE is a full memory barrier. */
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    /*
> +     * FENCE.TSO orders all R/W pairs except W -> R.
> +     * For TSO, the pred and succ should all be RW,
> +     * otherwise it should be treated as normal FENCE.
> +     */
> +    if ((ctx->opcode & 0xf0000000) == 0x80000000 &&
> +        a->pred == 3 && a->succ == 3) {
> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_SC);
> +        return true;
> +    }
> +
> +    /* Reserved case, choose the strongest ordering.  */
> +    if (ctx->opcode & 0xf0000000) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +        return true;
> +    }
> +
> +    /* Normal FENCE. I/R for BIT 3/BIT 1, O/W for BIT 2/BIT 0 */
> +    TCGBar ordering = 0;
> +    if ((a->pred & 0xa) && (a->succ & 0xa)) {
> +        ordering |= TCG_MO_LD_LD;
> +    }
> +    if ((a->pred & 0xa) && (a->succ & 0x5)) {
> +        ordering |= TCG_MO_LD_ST;
> +    }
> +    if ((a->pred & 0x5) && (a->succ & 0xa)) {
> +        ordering |= TCG_MO_ST_LD;
> +    }
> +    if ((a->pred & 0x5) && (a->succ & 0x5)) {
> +        ordering |= TCG_MO_ST_ST;
> +    }
> +    if (ordering) {
> +        tcg_gen_mb(ordering | TCG_BAR_SC);
> +    }
>      return true;
>  }
>  
> 
> ---
> base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
> change-id: 20261120-fix-riscv-fence-20261119-10a425b78673
> 
> Best regards,
> -- 
> WX Chen <wxchen0913@gmail.com>
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


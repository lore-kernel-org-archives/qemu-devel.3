Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=JXUxQZPL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4k7-0002Bh-Vu; Thu, 22 Oct 2026 22:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4k6-0002BF-8E; Thu, 22 Oct 2026 22:10:50 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4k4-00005J-JP; Thu, 22 Oct 2026 22:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVaiaiE8K74CZAhJy1d74OQ9Ul/PcDZbMK9aPqJH0qCo2QXERJRi5rp0OfX5FSM/JPjjKifZc7s+m5PyHokOT53qDbv4iIqBu6A2N1YZQIKUIdDMn40+fdiXrkspz9cspDfNW6PHCAePSpZgG1CXuvnzJVvcbTbT89l7pZ0qdUqnn6pNepQ5iDEpe+59I5xBQEPUrZ0J+XqrPCBn52QhvJfe1lItsi/aHQFAcbBmGVhhJhsWSppn9FHZRl8R6ao5yKLwnms6TXRdr73Fj0FQXEDyJ37AU0YJlHYVuDA7jXrVPm3sSNYfhVs5lHuNvIsNuFnzXmX3/2l0Vz3dqYD8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bJP2VgXx+tH3povR+BoJwdrxB90/JhRKSIvSDtqgvk=;
 b=IQa4Ajbm1hZ85Gvg312B+u2BkjOh/Gyz3nDfbv7XOjjESygeuFqSagyU8RVjj6f1f4Tmgae5ADuAsB0BJezQhQbalLAmjASJzfRox3SG1So6GsWJy3r087xEyYrsu28D7GuFRJKMtEMe8LhcSwefxdQE5IDPwx9ddSWpOJCPmhdwk5WJ2mukc5zDyKOhDr6wqPzQ4q4OTV/sFQ6S4ceZUA/6mIWN9fr4GPWMIExLDbJPu9j5Pwd47OiNopjBGIQSj5DEiA6YcZlA290pJs8F5eJ0P+QrPkpdu8mv1Kao2KE3TJ3TEYi1gYxsLxLT8r9x1J8R9AWtviRWcZqa6b3NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bJP2VgXx+tH3povR+BoJwdrxB90/JhRKSIvSDtqgvk=;
 b=JXUxQZPLcAKxFTak0etBECc4rLQ9qDksG7yhqsfhVJ31RqBZcoCPL/sA0E0u3wCgEFC3nro+EPT7vnNXVBzHxG73t/pg0XPTIYtYbG+2Ml3XeGyThOGCl7FWG+eOY3JX2j8ozg81qypR1AaPjEzzc2OUrnZMCiskFzwcyIn56P8lkCr2l0t3Z62J5zXXcSgpwTkAF+7hY5zb5PuffQLDdpCMK5XrdCtUut8yvFGBhLC8HIXvp9bq2YH2rYhK2AdPyH00OcrUzXRCdB5ciGmG/AEAt2e7qNuH8ZICg8OH+CkxjPk1Wa4rqn0vd8OXL99+d7wyGRJHpa5VJZPri4Ei1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB7717.apcprd02.prod.outlook.com (2603:1096:820:119::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 02:10:41 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:10:41 +0000
Date: Fri, 23 Oct 2026 10:10:35 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH] include/hw/intc/riscv_imsic.h: remove unused macro
Message-ID: <atrCEsJasJULYzB4@MacBook-Pro-4.local>
References: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0b9c07-d637-4513-a3d6-08df30aad6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|22082099003|18002099003|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4OMqGCnG1gwYWvztey/iRSOz0jbr4pJpQI+nPWIZqsmKvk4WnSZUKW1mAsvDNpuRRp90/AKYh1/wdApfFPMk1KuHJXkt6z5FlA5ln2iahJPgFFU7eXzef23zKPVJa/KwNg+8+48XhNiQA5BZ1bftBx/Kgqhz1SoHLEBV/wjHlxJ4tzJ0/rl2THTuPEHneyLAuOmMuDjualwLVBZxf3ZQg0xx13jGlgzkfhPtBqgGDs8RTnlqFHb+M95BLQSz6kQ19lYu9nQ1i6dMlCCvgvcLi/8/WzI3J3Axcr+KaIbWUPb9szQ4iUiDVGc5rKrws28wnmltc4tZG5G/WLtmJ4LLve3Hy/4qsGLP+aPmGTUKCrZJRRTzYIxq/v7vtOjQm+BEI6VNJuKeGSnXdgr8dxjgk4U32dOUbMtXPDC574NoztjLujXEWde8UbDFMX1va6TFgHAWq624cjs9d+FIW5uyBgubNhhd9bV/jiYL1vFVNmAYT7Ruk7TNvusRkCBYdSxfc8zBU64+Nb3rPAXvczl/x5FTfUiEXjjf5vv6C1cj4aUwuDaBy53DzHdx9n+VcrZPEMJWSytJNMV3UX8jWwQV03ZfQzOiZ2yHF++w6gCWownXce0D0gXVxxnDwmrMDQ2V8InXGXytiQUyPX7NgIRH21+cWfm44CHOWLoJLaaYDN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(10067099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCg9duuJpHyGkqZpaBIkJVqseZNSsBj2z4zAZI4gE9qNwJV2PVB5TIa7z3OB?=
 =?us-ascii?Q?n+A3+9uC6aNy1M/NvP+LrdpvQxg7GqZirXs0dTIsisaPoVrbESFlVTn62iHN?=
 =?us-ascii?Q?yn7vLM24xm7kE6EP4ZGVljSKenv6eX1f12hXPIKVh5uQD2iPTTOjOnKJp0hm?=
 =?us-ascii?Q?5uWrTUHUI+0+5SK2KO98B3Leu9e2Cz7zDmZOff0/Ki+TVNHxb0s7/kVznzR0?=
 =?us-ascii?Q?dsLqOLLPrZKRFbXl7kmJewgQk2SqLSeEe+pLTIVCBq04yBB67qwBSZpP0aNV?=
 =?us-ascii?Q?t48N0/Wm2y8s57hSVQkFgJY8Urpc89cvQgvVFiM6dY3dTDvD+J3ZZtKQI7Er?=
 =?us-ascii?Q?G1+TvdJkE7Eav7ErrDsG6BUvtbZESbSQvwTpZI5ilg4y+3h6f3LT/rZdJp6I?=
 =?us-ascii?Q?fFdo410QmT9PQrfolq2B8csw7UcDOzV3nZE9oZnAWvHjDbOetOi3I5fww7v3?=
 =?us-ascii?Q?5qch3NR1bUOMb6pSb6ljaiy6+p0iAtR/oEEC3DCwNR0LQF+hLpoXVikb12bb?=
 =?us-ascii?Q?w5bdRv+BX5HaQKVnLWSXGS+jrEYzOW3DvsHDcQk3WTAaqAwxPks//EAeAbf5?=
 =?us-ascii?Q?Df6X0f3CGYG2q15QqX2CGi9wFUDNNnoJsPL11VZYUeTEO51Omr++9Le32ucO?=
 =?us-ascii?Q?4sCcZ1RVaQSv8yhKEiGAVXpE8FDCukUrht4sepf7yyh08SByYs4Pqb1tusG5?=
 =?us-ascii?Q?3pQst6DASFZ6LHvos9h6iu/mKqpqGEZ7rLxnm8ZMaCLA8nCKjZ1dNFNSgfg8?=
 =?us-ascii?Q?jtUlYjWrcAYitZJyCy5iWfofgc7ZnDxFapslDTLdT+37NbtzRAnaLWYYDnbv?=
 =?us-ascii?Q?MyDSetBVPYorEROoG3Ea/Y89x6txCjlAv8WKQG8bT9yGW/ZKHNlohtDVaUsG?=
 =?us-ascii?Q?yApGmP0jVf6BHao83eugk+NimK1EVxdJ2tLGVC38fEW7q+gNcqjJC42fDLAL?=
 =?us-ascii?Q?EORifOZ0yY3ucDuFMHQRiCKOCT3w55ypgp/aYVJLjvabCI9cS3Kb0C/h8IYg?=
 =?us-ascii?Q?hSjSP7z2BHz2TV+is98fBlYrYnYZ2BFuCP0b535i8nYyqLpVr0QQ+VSrulbM?=
 =?us-ascii?Q?AAy9ZQAjCMKbbI+3PCdgAFMH96n5NSQeXRWMBm71cPtoA/WgKbIUdl53zJOz?=
 =?us-ascii?Q?GBEFonKOubGTxCYyBx3Z88b8b+YGfaU0Pe2/6KrIB71rps2uKQvTRY+2UD50?=
 =?us-ascii?Q?aAB5BlFHPDGg6mUFmC0qxlKDxaJ+ZgOOzPa8X7ovdPRyxcjACyxbZd9F7o81?=
 =?us-ascii?Q?6qkoGgvVSCER0kh5vluV2mkS1x1FW/Oq04DeAZZhk7BeB3OeyUg0vZxAZM4V?=
 =?us-ascii?Q?XGYmvYGi2LZPMlh/qiPhOQV74HgZi9TdSVITVkP7It7nJZnkaERGvuBjTILG?=
 =?us-ascii?Q?1CqgXZrKl7B11P+YOnEflkS+rXwiNdQ63zMiLRACThEPVgR0FtLp5Ny97cc3?=
 =?us-ascii?Q?xG9nD7JZYG7oRYJsyeJMQrDqdQ/00Nf03GbeU2Ny7cXmnNBRbLUG0JD4oNZU?=
 =?us-ascii?Q?SGy+vbzKbb+nlun+3oMDVfQA4jQZtf/sdxI/eeNYW4MQ//BumqUDEq6lnbrd?=
 =?us-ascii?Q?rgRm36MJbqAm2pPp3FAQhTPRxZaWQYNoOD1X4CPokbAm7T16SpZZHQHi+Mh5?=
 =?us-ascii?Q?xSH8MJQ/xytJI2yQkAp3MWQ9uIVydQpkN2rXZFy+lpqlvlknbMQ6kjOLssAd?=
 =?us-ascii?Q?3OjBZ8G1XdP+CVIRQ6bSrlx2/VMuP0jmhN7/w63suKHlJyO77GCj2MTWi07n?=
 =?us-ascii?Q?iRguDr8X8FvnZTDIhYsjefmXmu8Tfok=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0b9c07-d637-4513-a3d6-08df30aad6a6
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 02:10:41.4230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cTFBpbBVaa4ubQ7Fgm80cLjJ6Yvyad8gVRMVb6qqrDBo6PfXnDxoRDUDbcplyCUtg8bqe48kAI12dETzNC57xKYhLyMxlNHcpeQqMWHO5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7717
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:19:57PM +0800, Daniel Henrique Barboza wrote:
> Found while reading IMSIC code.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  include/hw/intc/riscv_imsic.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
> index 0a1df1c2f8..c744836657 100644
> --- a/include/hw/intc/riscv_imsic.h
> +++ b/include/hw/intc/riscv_imsic.h
> @@ -31,7 +31,6 @@ DECLARE_INSTANCE_CHECKER(RISCVIMSICState, RISCV_IMSIC, TYPE_RISCV_IMSIC)
>  #define IMSIC_MMIO_PAGE_SZ             (1UL << IMSIC_MMIO_PAGE_SHIFT)
>  #define IMSIC_MMIO_SIZE(__num_pages)   ((__num_pages) * IMSIC_MMIO_PAGE_SZ)
>  
> -#define IMSIC_MMIO_HART_GUEST_MAX_BTIS 6
>  #define IMSIC_MMIO_GROUP_MIN_SHIFT     24
>  
>  #define IMSIC_HART_NUM_GUESTS(__guest_bits)           \
> -- 
> 2.43.0
> 


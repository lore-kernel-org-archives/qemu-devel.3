Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F839606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=HATDV1HW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnaF-0001vb-RA; Tue, 10 Nov 2026 10:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnZM-0001cJ-Cb; Tue, 10 Nov 2026 10:15:37 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnZH-0001o1-VG; Tue, 10 Nov 2026 10:15:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3uXjjjZS7mweSMX0R/My0ZZSE6b2qRlelwmBR7ql8aHbw4Cv+eOKSWuDKHDsgklAViQXAHD/HQuXWHtpykoIELIS24u89oIN4RbwhSV0LecRtvBnH/JdmpJeSdXVTaamlnWFaWF3jXvH1CrMChXXRuR749/wETFPoxWqjCatvoEX/U7bBma2VClHsLWYpAoARCknMwrWbKvlp2RY7z1rQA5KZ3PWEI1dRUtHzKk1+kNFrYvwx7ok+sy+aIpTGzWqvgVnd0sl5XUDoi6GwldX1rcRb1PPfjGQJPX6dFdmpg2QTkGsE1eQF5ADzP/QWfvuevffmfNum+pbZ9ZEf4T+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoW3UjHoV0rUoIKxQ7eNNcz4weagP1ZVmnZrgE/tJHo=;
 b=TMWVadUnjTiI0V5UR9UgFbm24RflUhyVjCM0Yr2lRNKRDQjp8sYdALJM98SWSC4mgPHsgic3cFXIwtRSsba6NsgtQfwqqv96rN3lBNiuqNKK4yQCZsVvdWdKMcnMg+vKpjahJF54P6Tp8K4XK0ZU/EX6kwHUuPiJHD/1POvE0waqSUSKksZuiWCAYOJPWHVH/h3kvgrNMLf7Cq1w03ff2hZ4Bvg7G7xQdBFRGCYOOWDNeNghgk40/JAbp2PpkfvtPNPMk9kg/RNVK6zVsci2m/aHV1+Ft7zhLSWQOGHRmgBELsgVmAso3VNC8HxO0QBUoyixcki1dBXZaKnG8roppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoW3UjHoV0rUoIKxQ7eNNcz4weagP1ZVmnZrgE/tJHo=;
 b=HATDV1HWN67kmnajB1ROF5sSF18IvmdfEtYhPFYWVP7dI0DavTHPQxPCuE7pOnPX8t4MXdWuSTd7BXXImOo+Utwxrc6XUl11z8scEgc1dPC1ulXUGLeoiVjrGDJmCbyDvuEaUmsnwIPGV2jv+EMh88likXGzAOyEPFxdUfwHUx3n9+5N/XMnXBRZffxqrh9gxwSK+I34amOvJ6jPaISn+Xj/64plSiQsTsWwgnfxWns+KofJvYio9v52tcLbYHF6TEYOC4TwSnwhdjzW1EdjPQ+1SyezCfAQjq3GvijHGzXRc3oJE0DZ1Wo18ThonKJpmOkKtf4W0sFaesC+t4MCXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7845.apcprd02.prod.outlook.com (2603:1096:405:61::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:15:20 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:15:19 +0000
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
Subject: Re: [RFC PATCH 09/38] target/riscv: Add Zvqwdota16i dependency imply
 rule
Date: Tue, 10 Nov 2026 23:15:02 +0800
Message-ID: <20261110151503.16857-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-10-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::16) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: a06bc55f-e686-4bfd-be3e-08df3f3d6ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|261009223027099003|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O2TYUU1kqWbozXiecFBTD8g2+W+XqX4yBCUfd7MJdNPxYkHOHnX4oDUz3hyot4jSVA++4txjvY8lWjcfFavbmRgLlnn0ayrvoZxM36OmwvzU9O3sISP3cXmZS+2M3ymKcN40knrkjX0UF7Oe4E9XrzxoG5MxQbPUM3yNmZHkD2IaMRm+lFVIJeSnmAYPowbkNYADx2giOOo9Vy+zf+x9iDA/v9+XGfozmuvSRQZ3ctLZsxnm/cPax135D6ZBW7b9Nq9jRdg1582aDckhKSjBJNSWIb3FZ+8s4SVIlJXRYKUy6USrLwVbv6m5x3fQHShG30Zq/cSSjDfAnb9AU79aXi6/TF7EPl/N7TCtzcRfWCKjCcHf/mT4a4tH+Y9vNEoGphLuLokDX0ny2vWnyvBkBsN7B3qNa04//Hl+IDd2e97+GBCCaU6Dq7bFkSGgAgVR5whhwsdSBT3355X34NdMkfc1Cn0ZZH7Ot+XXYfLjSpf+kj7UGV9qN/an8CEv2sQuGbxoL06Rc6mIwkxFCiHQsK4kC5tD841ID0j2F1G5k1CeE2pJdM02iv9dfQ14ex1xIyW5LpIfY6pfEssnjIf8nziQqW3utJTBGTbpslfQnkEzhU3K0lP4jsWggRsviWLDzlAtk6xQJKFXzEkKpETu3/Lo+vtDL78uqppz+aPICPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(261009223027099003)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2KT/8c6p7rlZdUf80GYxY+cqfQdw4kkhu58Yt57MvIQeIu0MDXII2i2uNnJ?=
 =?us-ascii?Q?3nh8sLYVMv/LIf3AJlyZvaGQ9tqOS6RZ713EuQeD/VTtJPUGb0xGLetpzNwH?=
 =?us-ascii?Q?q441LkH8bcsIOeRJiU2L9cxP0ecY5jinfRaVRzaaq5sgynvj7WFUTop31Mzh?=
 =?us-ascii?Q?fabWV72hOwgfbSw/Lqww8iKVqwjUrDWfTehYgGkIRDr4JDj2OrN72enll0J0?=
 =?us-ascii?Q?lHzzJ50nZxmZewSCBWU/k8okhaPrnQ13fcOtPeqcQ14YAtTvwo9aSuSitO9C?=
 =?us-ascii?Q?u1WHvRJjj7Wev+56PekrA5KDSWdkzwdYEWi/eu2VZoe5V9dk1cyanXFVd9Q6?=
 =?us-ascii?Q?wKDTLvWoYhRsPtZiWRI5lRbcYi2YWNnVvwE13kliug/4+w5fruX5Fkyu4Yqj?=
 =?us-ascii?Q?/+lZiiCKQM7fDMb9J9PaxWcuE8dpJEdVMOtluTIYEboI+PcsrmzvqQPBsu6W?=
 =?us-ascii?Q?AyBQTiCmSB73gYB4zI9dxmOuVdJrt38uO2T6NG4luVnrBU4llxlX6njvMdSV?=
 =?us-ascii?Q?PxEYUsRLrGhDDK/5jF8yryfcTgjPbMl3t9Wxfw5NalaDZeGzPOsTbKlVXvsV?=
 =?us-ascii?Q?VHzKQOg81quoCnnnzzcSRqSe9ClhQssD0N37Ia64c8cp4CkkM1WA6ukmBMFm?=
 =?us-ascii?Q?kVEwEddlCTrcn2ZchE+rPU7ZuV9Xwt7Q9IupO6QKy4997o0gn87RPxIJ5FCI?=
 =?us-ascii?Q?5TlrvDdml8WuNiKblVS+bG/9RPl1yfxmOxwh4mG8Eq/8HfpLBHkK2l5+5M0O?=
 =?us-ascii?Q?wF5qaJtddtDAZwmaha0x7SrcYnPZy44fKHIyMScWBLluFq9NWtK3fBbB1Sk3?=
 =?us-ascii?Q?5v5qdbg3T1cPGcgwop/W7vIKGxJ84s4fY9EWqxQ+ZtZkcrIhxCkcXejOcCsD?=
 =?us-ascii?Q?IZEvKsy0DCKNtOa20kp0kao7BZj1NRbB868TZ2H6goVbeCNmQaHw5b5gXJ8s?=
 =?us-ascii?Q?ukv4mVntFIonj8XyNo+6ifcq95Q5G0ShQ0xt7AwTWFLPwA5QMpZ9KOfC5317?=
 =?us-ascii?Q?j17YOeErzjGqw7GfzBMiZI3D17gi+wSZgry4ErZj2x/KBch4bwGtw00luVMM?=
 =?us-ascii?Q?FE/wOj69ObejHZo0rJ8Vfzh4TO765vyx1B49JOBC8bD3JFLtDT0K2yz24EDd?=
 =?us-ascii?Q?HJXk7MpAk+acCKCsONPInIvSMyHf6EgMsjfDcFO1rzKPScxFietu0nnQs8n/?=
 =?us-ascii?Q?DYsPDDTixU6QRINdlGOzgCW2dkiMNK5CLsXvn95417Z3Fq4VQFcA3u73dhlS?=
 =?us-ascii?Q?NxuEM9RQmGfekU/9izv8vHO60V8FXK0ogSl/XolLxpIvTFwmyElOy8K/pdrw?=
 =?us-ascii?Q?XJ1A6Q4exkKrKBxSqX4KHZru24NypvFb86e8W+57tEa1PaX4cL5ml+kKwyWR?=
 =?us-ascii?Q?3LBTANuxrRX4zpm0XBN+9G0iwuq5d5s0sy3j7Rg3gU9QzX+8tQc/FdvwDCQo?=
 =?us-ascii?Q?m50hn9WcGOzEKjnBHBQ4E4UC5rkNz7UyaN49TaaWRmaF0SOoMI+9q33MXpBD?=
 =?us-ascii?Q?SQ8Jm3I7LORtL9f0RuoSTo6Cm7UMZ5FNDwf34ZxVnJ2gBFbqx/hSb+BN9lrn?=
 =?us-ascii?Q?P2qisVQ2r6NCd3zgqAHbd+98F0pdnOCYIhtsd9r5Knb/ZUEOVZggZEk3Ns+E?=
 =?us-ascii?Q?VunDMD2kqQLxfZYs2/w+hyq7CEq/gGvgsc+KY+tagUdDpWL94L95GdjxghWS?=
 =?us-ascii?Q?6zY/9NZkzwTYwSrutScAj18yST3kOwKATqMqFhwXh04Be2NRHoDUMpPBVmu6?=
 =?us-ascii?Q?lWWBGJBtL4j06kuRiSmo8vuxJJazbw0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06bc55f-e686-4bfd-be3e-08df3f3d6ed4
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:15:19.7019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWD5MWO0RoqIVbRGKBeKd+acwSxXYCl/INTMoYy062gPumctfn1RabCcRgURmReQ34x+IGX242ntA3da6iiVIalDZO3bzYxQa1uho7zWAcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7845
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

On Thu,  5 Nov 2026 03:41:24 +0800 Max Chou <max.chou@sifive.com> wrote:

> According to the Zvbdota isa spec, Zvqwdota16i requires Zve64x.
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
> index 7873e67c053..ae859128d30 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2853,6 +2853,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVQWDOTA16I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwdota16i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvqwdota8i),
>      .implied_multi_exts = {
> @@ -3066,6 +3075,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVKS_IMPLIED,
>      &ZVKSC_IMPLIED,
>      &ZVKSG_IMPLIED,
> +    &ZVQWDOTA16I_IMPLIED,
>      &ZVQWDOTA8I_IMPLIED,
>      &SHA_IMPLIED,
>      &SSCFG_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


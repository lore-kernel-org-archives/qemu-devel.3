Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D090606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=jZnoQyME
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0Ni-0008Um-EP; Tue, 10 Nov 2026 23:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0Nc-0008Nf-I5; Tue, 10 Nov 2026 23:56:16 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR0Na-00036P-Sa; Tue, 10 Nov 2026 23:56:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiG6oLprkna3m0fDa9MwP+MtKmLM9qABXROpvEQn9193RtsDnBOa/HxQUPDnseEmx99VoPzLEr/jTjQJNmr5RXqBRyS0hOeUxneSxUCzShl09brg+hXmkOie0p9r0Lm0i/VJEltrUuDVcKGist4fc9mwF/sRnkh2gRqG+iCbYB4TYluBQ8URcbcU7xiQouZsivF75Azcx/AWGMxpeax7QgFtkgRiHVR7YOGfwF9i1z+io+Fb+iGNI2B/UqwUIn5To1HP6ur/DM5jaYkNPH/k14TvMN5GGwQLTPnyZ8+JLLr1b6TmtV0PFwF+g8nrPwJIbClDXz721fm8zXCmhcQaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMG5v3qER0paAb+zwN2GXpMtC32jFTxE3v2SCETisTo=;
 b=YX0v9CaUU3gi+3LzYUypdhlgjSeu0aco0jwEPKntDOWSj3bHq8TDArFA+epJbPQSh0OzGDWohc5je9nU+Rw4iZ2rvAbCfbbkwe7MADb+bt3ukm40Q4gkBeGQ1OzCR7SkPErOue+DOznENxqTYz6Sdka/lr2untIr73ZalzIHembiCxgHbxNiUoW3rXtjErD8WOya6WO2NiAmA3N1TycXH0HEnrI+aDGtLzHH0FnVibSbYdOeYpCY2gR6fpjmN3+Vw2ubIRs32Up1tMqC6eZ/o2+puW1C5SxLXgFqido0wCcNzfnqLqZO9K2NZuqXnGhGUyLW5BrKBgWPT2n3hV9ZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMG5v3qER0paAb+zwN2GXpMtC32jFTxE3v2SCETisTo=;
 b=jZnoQyMExyWAvm8qGOWLzEesMjHtn+oZhRqiRiUINtMXueYPNsv6QK1ZsBr99D+qsNymVCestQFcc6KuFENsUIywDxGbI9vmttsSqk1lZgVQ+nCWQDfVaukMJghf1TqkuTwhk+4ket5VBDiD4rlCRlRpAXFJtJ2yKG6d8WS40tsrA+9be3zQHSdMZa8ILMyXgFAMAm8w37VaWP4bPtGMQlvGpQir8qNtnzTO5CR1/Bx4rs73QY/5Mj17ZMpeu5vUpoqv3/Rass/Rq5yYWYKdDIcNn4CvBPW/SBG5jTLNOM9DWPFXEOtiCHCw9DoN1hpj6JA3aP5QTty+cxC7vNTaZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB6289.apcprd02.prod.outlook.com (2603:1096:400:264::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:56:08 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 04:56:08 +0000
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
Subject: Re: [RFC PATCH 12/38] target/riscv: Add implied rules for
 Zvfwdota16bf extension
Date: Wed, 11 Nov 2026 12:55:49 +0800
Message-ID: <20261111045551.81562-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-13-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0049.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::16) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 15230c2b-7392-465a-c3fd-08df3fb0191b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|261009223027099003|10067099003|261026121527099003|261026140227099003|261102124527099003|261102123227099003|261021121427099003|261028144727099003|261022075727099003|261022105027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d6pBQTnYlzUrHg5UC9VK2fsE13iVoQA24AOobHuG2XfiSvWum+3XNGg/DpAdMfVKVet5vz6WPh6rddC0FvkyA9t8Rs573ADaqTtDR6tcqPtUsRCWG7fqYxo0cobzsV+nkJNkoYK/gfeBxc5euXtPwcKSLHzMl600CnHEWkZOsaeRUavprD91rU0Leo5hU64Yxm/bMIYyqLy2IfDdCkbt6dshqkG5ThIqZq/NpbZlOwbkmNcLxiaxU8B7wPHtcSJqWz8InSj1u4IbvnrY4CpSCal7Xxv2IpALrgllIhsGtNGUwVL3B61ORHJHg9IPvh+8rh0U2UBCNdFHLjTsq6FUh0o+osSumkdNw2F20o8WJBIVfwI/y8rMqmnlIBuWV4fQNXojU1NdmFL6rHV8ODBeOSGUU03eCfRjSTCymc8VIoA828QOd37hUVxJ1n8mMy0AFkp4tnPPLOZkmxK0Rkmx7ku4/q+UGLtdTYT9ADVkAYj+oJ/I6Dc3mkPR5bMks7Sh660LSlSB/afil0/5j+jkkqGepcFQZ2K9hdlSB5Y1mOnpWJoSL1VopZj8kF0heEfjCQ2T7ySE8WBMNwXKK4NuDbhlVhveYG++Bybz7JiQ/zVRz1lypCH9ofCan3oZUkHKyLZmk4Tbi49xugh7nn1jiSzoAB3PHNXDfFWt0HEFHbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(10067099003)(261026121527099003)(261026140227099003)(261102124527099003)(261102123227099003)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhP8iUuxamhsYyuK6MTHUitJLp6ZN+UF/UBOuxvnlYnFjjJY4kuJMzVmbrGU?=
 =?us-ascii?Q?6aU6pC6OjXFj5L+TifY/m+/fKAtTI0WrprEDQNowMivy3eqjeFjHSeiF3fAb?=
 =?us-ascii?Q?i0KHjlm255zhGgvw4NkmCGiXPLOWAaZHGtw2N/ceN/7XEoNXRzlZXwPQEhHI?=
 =?us-ascii?Q?5fQ1yQEn9QGvwiRFPMwPimEwEpo8wFk+HpfbFtLOwVqboZDZV+27ugOLgpiO?=
 =?us-ascii?Q?LmisqpzPwsB/h4FN3RcX24q5Zeb4Dru8zBxd0Mlhr03CWx4tuFBcv6Hh7V/2?=
 =?us-ascii?Q?66oJCX21KXhUwdFdX+e/oMsUOJRCovgAcaS3hdr9dv6uUxIx6YccfcKzgK8w?=
 =?us-ascii?Q?OotqSXHDLM8sG3hGXyMZ/WDvqUNpprDj99OSSSXOF3dIfOyGW/bO1BIfu31l?=
 =?us-ascii?Q?Zr8pfIJ35OpRhSGN1SPpjCWDmu/i/79/sK+od/7xPQeam7Z5GB6HhmBW5+uL?=
 =?us-ascii?Q?jsbfxxHofSsTPSrfNJ5TKpiNu2MwAaQeUMu4/S4+vJ9Ngq20SXltgwmm/H4U?=
 =?us-ascii?Q?prBBYlfdB7f+Sjk1UQpVaYak9PIRdySGexcpiB4M89tNjxkqTam1Ik7wuRIa?=
 =?us-ascii?Q?Fss+IRJRAHntqIAUaxDmenAPPgjIoqyFXp5MGmJACSGgVaVkgpvdVjkcFhUi?=
 =?us-ascii?Q?go3aTd9W3rpYVnOosCKCppyacxEcL8pCpdvCWQs7Arlv7D+4UemWrKl4Jwt4?=
 =?us-ascii?Q?6aeaKnSHw4EQk1zxdBm2givtsAMv3BLA+W1dIpJOgD9ssVBKI1b/bBggYAfT?=
 =?us-ascii?Q?fkdOPYrBF5W/nezH7oorWDkRs6K74MqkA1X2nNWMlMmoKigIQAKyEcw/hluq?=
 =?us-ascii?Q?U2QLQ1D5CGLov1SECwZImjo+Jp5CXFdI80hMni6aAUlIHNlK+hX6WNyUBvt/?=
 =?us-ascii?Q?3Uarw6tBdF+q4cdD0Ogwhotv52x3UKO3O7FlpNxr63WEqz1UdNkx4nbajmNE?=
 =?us-ascii?Q?QlI65dGyO1CBchZ7OqLGPpBvfjoH5p2d0yfOupghvsCFHR85hK5kcz8v4I4b?=
 =?us-ascii?Q?Jq/eA3lDH7asnbHGpkk9XFOomUrS97HR4XMP6gjFzrowQPnC2DBE1cSrYhO1?=
 =?us-ascii?Q?whwILS42fg4isw9jKV5a7/k0N8yTRG4m7bNty4jiympAR2Hrru53LrDXtsjF?=
 =?us-ascii?Q?nA7SxSWVNBo/27KRnv+A45nxjyThja12eTdMtElvdZSBwMV89mnO+zKLB+RD?=
 =?us-ascii?Q?hWXSJSBUQ4J86yRyeDGnuECOPM+5EL0Z/N3WOjz2m93Fp9OPSkX/10yLsUnv?=
 =?us-ascii?Q?VjMlcAxLvV9+qL3x9Svr321d9pLsn3b5n9b8dq3Vo50Xp6azGAx0m1hgadl3?=
 =?us-ascii?Q?PYRkUs9Cv0dxZ4nSUXpWR/uiSC2c2HM2M/F0/Xtt70XJJ7ZvtHjxEcGLl8wa?=
 =?us-ascii?Q?9t7I9aqsykKvD3bLpW8tOz4qqRZGcKG1pGUpEORJEjES5J+5vM+uHMgdBj9u?=
 =?us-ascii?Q?xZc1q9pbQfI7o9xPNjmNSimvaFpHWSEfL543xG5DrUpzh0r5yrzWDWF2dcaY?=
 =?us-ascii?Q?Y9vCJ5GEHFNnlITmluZbigE56lA9E9ZpqPnkvFuEiiBw+L4uaY3633qu6tdh?=
 =?us-ascii?Q?kaVOtmzHrqwzZ04XhgkcEWlEVrgR1YbXqoK0vz/IkO/WwyBIkzJD7mjn22af?=
 =?us-ascii?Q?GklOHV0/3Z/7B/4af0LMlJ/70iRIveMIMGGsJ+2R5anGbd6LIKe89ZJ5ENMS?=
 =?us-ascii?Q?mYyPRdNIukbRQgBArjarpU/dK1Y5iw8DK9otiN3qljIwLNlObwwo9PeWVvLa?=
 =?us-ascii?Q?nNl3/vmhZQuCZlr/PZ8TBGRrTdANxHw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15230c2b-7392-465a-c3fd-08df3fb0191b
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:56:08.0099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qg2Sl/lDYnsQC4UzkLUNJx2ePVPhSp+eTe9HcmvKTmJMRaZa7SMnX6AcUUzyvK+Rgv3wqC8ghZ0ev/Q1Ba6nPLZ6kVJiZFzLyXF7rql+ajI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6289
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

On Thu,  5 Nov 2026 03:41:27 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvfwdota16bf
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
> index d6e2b07c401..2d905a99d68 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2873,6 +2873,15 @@ static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvkn),
>      .implied_multi_exts = {
> @@ -3070,6 +3079,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED,
>      &ZVFHMIN_IMPLIED,
> +    &ZVFWDOTA16BF_IMPLIED,
>      &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED,
>      &ZVKNG_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DB606D817
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=Mc3s3LPG;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=vQqWxQLV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOv7m-0002k0-Vn; Thu, 05 Nov 2026 05:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xOv7i-0002j6-4X
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:55:14 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xOv7f-0007BH-L3
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:55:13 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tX7I1357681
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 02:55:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2kjfyJck/GSnk9byvj28oNv/ZNMLp+2FvMGWT4x5Q
 vs=; b=Mc3s3LPGNJAqQsPFOXehiECvohvb5EMI6jYxwPFJWOsSF7UIj1j5VeYJp
 YOsV5tc9UYQbMP3STpNKQTI8yq3+oDukBdS0ueBD43fjeMSQ+riYheiyj1KaewvJ
 weeq5mc+mBvkcqfGIFzH6F+0jHnUtspYHmWc9WAZyuMnDqCxU/KhrL1MSvrMXGqd
 BbkuwuJFVHH2r5YJjOZrDnZFz3oknULCnqnYPnavQxoev5A7aLuJc8FLDVGoiy9H
 +QyrJK8pnIQ5aANcbS4N50ZbjgVJmaqVrRiYm5pU01Hh0PkcHEG1fIXzyk+AJc9p
 17ZTGm4WMARFmrouVf/+iGCNYCyqA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020106.outbound.protection.outlook.com [52.101.85.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hrq5cg607-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 02:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZaz069uxZMMuBPw0meuuDbqxXFRQaznTS+HezYZMG7Wdx2YVdlFGTPqL8H0pZNOrlhUNt/tBmHqUs2HOmWkIIetWK+sv3IIOBm5mO1Cq9M4nPZY2Y4mJ6UMf2TTNq55K2NiK9k+2im26uL148zs1g0QDJueb9PluR10/N9UPUgj8w195U/255tDMZz5Midh5LYvIj3nAKoD+Z5W9tkW1KAhNXNZ8Secb+ATjjYNB54rCjRq5LxN+vsHABbgqgXP2LEJiHQAaB/kP3W9ZaKUQj565A1yRgxARfCdDUdomh2RgXDQymtLD+e9pBp7tkbPyr0RaPd7i4PHNkfOyS4pKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kjfyJck/GSnk9byvj28oNv/ZNMLp+2FvMGWT4x5Qvs=;
 b=xuijmP8x/4zLq6/ueasD7hKMLx6qJg/rQ9Ywk1xyjoh2NLfcPVyJp8u732J2YWxOqaittJuvqZjq3uYhypLU3hYovOmJ0o8KCmgq7nSnNScVQD5xekX8F3nbhE5pJnQdha4MCBO+lJ1eQJ5fHrHnmfTZSSUEJp5HItdFuq+TQynlCHdB3SLNJuKxd7DSofkLj81dFq32M6vF8p7vKwVvzT+4VQg3sbcugzX9Syd37h9DAJafNcZSG/vAWaFEBxXvMrN1o6Q7dEQ/q7kWUErxoLJb1hn1GBncQqBKMQsKgnScK6dLJhWG2diMmyZCp7VYhUS+7PFbDdJWIz+C6vkosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kjfyJck/GSnk9byvj28oNv/ZNMLp+2FvMGWT4x5Qvs=;
 b=vQqWxQLV5mb9KHvCTo5Wy6zt2HWWOFGWE2/U+fK5EcbpcDAEVP6Nv0bAHSY3KTZW/y0u54nv7ORMJozW8qksnwUAWt6UJ0Bqvk8yrOmjK3iTjvFtJmEMQ0weuaRO2uGALQkfeZLoxe8Ax31oWpf9/mbMxyye24xmqyzbZ5nG5zIZCRp8+Qj2kKQYOtxp4i0b5KVsUHqJu/5dLJ2B6TaDBzFzOtN4FwL4WA9KBBQIB8bGXkegX7H32MX+FzpE/fyoNIfSanZ165EckRIxNHrE3MJDRMbkb5BYofIDV94GzP0dhPpDFcpxsLO0sAcNEeMcd4lZ6rThmV2xW+NM1dJzCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11574.namprd02.prod.outlook.com (2603:10b6:8:4e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 10:55:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 10:55:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] i8259.c: don't leak I8259_PIC output IRQ
Date: Thu,  5 Nov 2026 10:54:47 +0000
Message-ID: <20261105105502.1786431-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105105502.1786431-1-mark.caveayland@nutanix.com>
References: <20261105105502.1786431-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b35797-2171-4197-c86c-08df3b2b4219
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261022075727099003|56012099006|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: LgNxFt+W68IfjWW/vAIR7svZuzjz2FDc3OM0jSEDCP+DGEU/7ylGhmKHkrirrplPvM4UbAiEKZ7BOt0jmyRksVx/M7nZSkZ6+nztOqQEAIEbzBV6oGHQW220C+JXmE2Vq23d4ouq6inpVCrCWTHQjCTZt3FhyA8MHXmVdvr1TYOjUUixjJYoCfhEd79rtDJRoZcvBC1ZndyLUatc+1kFz2CJ59uXpZBaq5ofUt7zPNUatyrbou4kJI+ioYhNkbXCAkYdaHds4vrsXt+w5+077r8A1sxsr1ogRUhQqjKkI/xoRDADUiJMv5ZoivN96nBkuZtvgpdgmTZtLMMK8ZFPYWQ0vTsdXJ2UdLdOipzIjskzuvIiLs9Y2ia0x8tPcClKlJmEAarTEzxp4012trd7ttK9+6EUa+kIlR3TDxyeYCdUYzIzb1viXWRfF1b4MZod9F7VCLCpjf67qrRuMVXiTLjH4Dn/JVWZ4bxGkFxzmfZlQFH7Jsfeh2n9WrrYHOin4SaNhmWwZBMmu7Go1VDYd1vZm1kR01+oIt+PFomDxdatvSdfoqhfH7O4e1WZAAssWmeyLAcH4QbZiDQdHd9DDpPF7FgPOZUSUjGR9RPwuVHb4rQDyYnUTklc6/5QoNQ21128d21QXL2M4P5gqnqhDpfmKsZAvvLsEXuK8pVT4Ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kXyS5YwZDOyRVthB4agVOci3IBzWwmHcIYHIBCvcjGDjhWYqMD3v5D9mvlGy?=
 =?us-ascii?Q?LdU+XXrZ8gik+m3vtRMzaj5osctDEOohi0QkMToVhZnqVsZdf2HvB5FEvFYX?=
 =?us-ascii?Q?TUy9gi1QZNbQBvAinn4h6bVkqdKLwrPIMlmOnlnksQDjrA3oJXGR7AGXHcjf?=
 =?us-ascii?Q?tuXOUKq20VjFVNc44327x56+IqcKowplUb8h+dyw563mvlf33vjMf4K9z2Ex?=
 =?us-ascii?Q?AxAvTnjAfyU3IukUHzwBhclVLXK5dYLyyFJUmYtPAc1TxlbOFfbCDJtW16M/?=
 =?us-ascii?Q?uCfZpEHR92OgC0R3XNpmbkMsswwls8SfU5ySWL/sgGi6783AeItCxJbjajcD?=
 =?us-ascii?Q?JO7hm7M28hst+uVGikz6F3D0LGrrOtuLzPHsp+uSmIBoyi/ELh5lsBFfim/S?=
 =?us-ascii?Q?9n7FLfYQmcVaURZLehlFb+PtkIFaOM6oRFd4yXttRJSkb7Ct+/9YO9m6AMxY?=
 =?us-ascii?Q?lXPo4yDU19U7OfdUZ00mQc7yDyEVKs4tZIJaDW1Wq1PfosDW4u2hBVi6qPgh?=
 =?us-ascii?Q?QcLjsy8oEmMtmejFGESxWs0akjbNZN3YyPRXdPg70mlVqtrwr/J04MN45jVv?=
 =?us-ascii?Q?sr8rv1oAj/ZJahLyw9pdKsFSmuYiLqv6lbBSkSFbxgmfM2EP4fVh7p2+SOIY?=
 =?us-ascii?Q?DYjs/UjPR0Fke+yaExTtWTT4rl9k0rhM6uLjPUMdvpCi2Z6NmvEuthdHaaVZ?=
 =?us-ascii?Q?vxTl2vZlAB3/3/Yzajk0fsBvAinp3vu3ESjwZBTQexhHOYWSuCtnAsDl8iQz?=
 =?us-ascii?Q?Wv+W3LKGxHPNMoC5vsnouYvrx+HMsJR9IQrh5dB4H22wme8etMd/Cv97Fkti?=
 =?us-ascii?Q?6a14ngSxBFDHT5KLvn0VTaj7CNmtqKiGQbgIcyBsxY3qQIUCm5ty7/hvOidZ?=
 =?us-ascii?Q?96ZhIEhYI2clcqawCENChkBhm83599oERHE45kPv8WXMtIhUdvwykK33N4/j?=
 =?us-ascii?Q?T3GJjwQx7PaIzlpvb5Adj4gRxLwl5J/Uy3nDQQen8Xr9jgMv8Pie8BLoAeNn?=
 =?us-ascii?Q?o8vjVF8NMyO6H0Zk/fWIhXpWLDx1cvMrlTWEjpIMIjfFngzx9UQy69upSPTZ?=
 =?us-ascii?Q?va5P65l052RHvaZTdlawyWK3DP4a5ZnA6qyrOniox6yXjjzKXNlk5ChxhXc1?=
 =?us-ascii?Q?t7RztOA1oZBiTo9n9BWgntOkiLy5vLGN8htZqocM0BzCXw65USiFMygQrZAB?=
 =?us-ascii?Q?zuz8Hy/ARBbFOTD0IHcmncvD9s2EoBXGr832U1ifEP6RxlCqnFC3ylLl5Hpg?=
 =?us-ascii?Q?PDBBDFtUvz1VPWfA9ssElZBpAv6LwlGcwTKlQr4JFgnFOOp43b4VYjI44J24?=
 =?us-ascii?Q?ZTeh/2Xe4lGhYzFc25LswJnRnL+XsrOA2XnBSMJGoCcZZToiuzQrVwzuf/M/?=
 =?us-ascii?Q?Sb5rkYfN9TB4s8OsNdgBSPygy43vzg7O/L+2zJKPh/sRIC7McPwlLoBaU1j7?=
 =?us-ascii?Q?k4LLmBeGrNqt2oCtJnC4qygY6/44+E8dHN8DEWcA+q8WxKatCJrJgqv+NwH7?=
 =?us-ascii?Q?Sof/BVxA9JWWyO9vsxV5QT6662rvyYanmb0Lf253pxTKMPrpYCTikkEuZbGn?=
 =?us-ascii?Q?iNwXM7wKbmmcjntgcaxRhUjEsTnMlXx93XULaUOaljm3ckonBOO3bvh1kLac?=
 =?us-ascii?Q?SCgBJuGb5msrmGM2dewrVU1wsC+O3vrHdgZbDsQqB/EEIMp5q7KHArnq9NJx?=
 =?us-ascii?Q?y5/JA7RI6Ha+WaUxZgKr63E1FnqmcdWvig07J0Oc+IVmsJ0n0FMHVD/1oG8v?=
 =?us-ascii?Q?KQG3ssR8mEZ7DBt4RRvUD81TJjFMKVo=3D?=
X-Exchange-RoutingPolicyChecked: SlfyrMN5d92b1G7Nmc7Ns7KQ9Hpp77DfIllqpCho3Zy1fTBkvRmZQ7ltqsTY4sW88ItLZT8Df53nIbP4GH0zhraoqkRKS1g4ELcDqpYA/8915jrb5Yf9F5PUx4pwedfYIjr46m8dclkF/rKjQSxLNtIc71NxHnZ1qsYeyr0z1NeBpdisdJtotz2cZc2MkOzuUEuOlbV7ttEma8LXfBSYz5MsSkBT3dLeq59sBfMhnAVGv7ZML9yqcCGWKRO4dgGdy3bC+U3Cz6VsI2rpuy3CsHefeUnTOMantQERroDUqkyk+V+L1OtV3Cxcgvdey7CvS89Vwb7HnJUABW6JWdT7XA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b35797-2171-4197-c86c-08df3b2b4219
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:55:08.9662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9626/1hjONbWFOUZPDuuYQFPWTpuEHi9nF+qc+37PcxELo2cEmbeZj0IH4hq10XjRiNrm3jBGd47kaHAXBuIPSRe5NKsjByScBZ7EU4S9CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11574
X-Authority-Analysis: v=2.4 cv=BJQmP1QG c=1 sm=1 tr=0 ts=6aec608e cx=c_pps
 a=cFfp9J6W/iLkiH+l/RQb5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=Q0WNifg6QD6V5pTxgcMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rSiVWpp0WPdA_SX6v2lwFZcFxdsxX4lD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXzHi326U/FgtD
 QCgKEIF+m+OfmMNusFqTaM6i03efv0ourGEF/SVX+5kN09yZFbBylWk0v/rAM5aDfHgIRI7WjEi
 FJvBErDRghwXdCH3Gq7zKvZuMUDDGX+QYcfGJfOGSX35xdj7Ew2RAVaBrSL5vAUmP2ubPZorZAg
 slbyoG67kbbKSWDWrXWMnNjCC65IYKUzkMYWZpXmKKhsxs1c1qz2yfvPl74LYaq2nVwTwUzMRIo
 sxH8ZCN6ob6KUGHx4gVnevF/eB6GzaeG1lyVoSBh+ALbywwbs0XGrTF1qyYwaDAy3mgCi+sAXdK
 7d0jAABkWWAQQ4oS2gOJ2oJBlRyQQ1KOPFdsm4jde+HWUuZREzKhX+ukeGFEfMcOIcD50GcQ2mR
 I3UtBRLlIJHIhm7WOyzM8V29LSfS8mK1H+q+gDP3eyNrDsm+u4eVFJBlX9BcdyZnR7AssxH0yDg
 qtWSt4pQT4MojNTMwsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX9F8MBPWg1wTI
 eaW+UtQMZhKs+JD/gE2r0OTM+MOrZwcoGCt+6JW6OfFKsqnC9ZUapLAyYagQPLepY7Te8Vp9wKo
 VfGzHUaNsT40hc/EOUIYx0148C8YEv0=
X-Proofpoint-GUID: rSiVWpp0WPdA_SX6v2lwFZcFxdsxX4lD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 54fbbb30d44e ("i8259.c: introduce TYPE_I8259_PIC device") introduced a
separate output IRQ for a PIC representing a cascaded i8259 configuration, but
failed to free it afterwards. Use qemu_init_irq_child() so that the IRQ is
automatically freed when the PIC device is finalized.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 54fbbb30d44e ("i8259.c: introduce TYPE_I8259_PIC device")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103155018.1454989-1-mark.caveayland@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 79b5e603bc..6c784ef2a4 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -491,7 +491,8 @@ static void i8259_pic_init(Object *obj)
     object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
     object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
 
-    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
+    qemu_init_irq_child(obj, "output-irq", &s->i8259_primary_out_irq,
+                        i8259_primary_out_irq, s, 1);
 
     qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
     qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
-- 
2.43.0



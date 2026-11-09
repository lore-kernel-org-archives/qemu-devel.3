Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B004606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=SIGpMOny;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=f/52bsAj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLLE-00030a-U7; Mon, 09 Nov 2026 04:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLKl-0002XJ-Ob; Mon, 09 Nov 2026 04:06:37 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLKk-0002rU-2l; Mon, 09 Nov 2026 04:06:35 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96BAdv555340; Mon, 9 Nov 2026 01:06:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JMLTNI1c5ltRIWTF2nk2raRlRC/jgscHUeyfTq2bE
 x0=; b=SIGpMOnycgKwQaAE7P5eO+GmsNEQUHJ5ujeqO4j1iQKoAVX7K4ltZVqr1
 Tj2deoejQsdTTCkUIp008IzFRKunRJyRZ37Kl5IfRZLLxQmzNii0fGjO91Z0kyXh
 SWiQlBc1dmSKffVpHMV2CXMOOs6xnYDyWzZm+FKiUmjQ5NH+EXl9vTU7Go1wZUZj
 PVbcnWmzzNUdPxedMxqR72NDuM27rHnbaj3wz2k2nmbg9Kk8TvLQerV3/xEtUfOd
 sZhDlN+/L4tRvBEtLOluSqmohRlOSibUXUDgioP3bfp/0J2M44RL36VEeVx6XllT
 pkdG1paFbBr1rwoiL5Yjfsh/A1LYg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021118.outbound.protection.outlook.com
 [40.93.194.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht2d9jfgu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 01:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMnvXsY8RyDMx9Z0j1Wdyk8/069ZX2OQ0pD1vPDq/CaMSOR/edlOwtaqNa0lAfQpT4uXtqmbL8IiRrjIZ0A3pAy+ZQUoYzaRXw5GIVVDkYN6N0/rHUjilTCuVSzJBIhRS9tCKEm8leiwt0UyMLke5ERqTXhy0iPe9MnIR4oKe6Y7YFNV1bLWTaMuu2/+lzwcaLL9a7z5bufxO+1krdOuvZK6VWNeSZp0Dp7admCMK6TmABXerccE4YEzbcE0lUrBQ3AYbco/2eJUBWJrafK9uEyOSdHQ/iDBaNiIsYeswGD99XWTcrwjNwKY/utQGsSdhcz5XtsfSX6QS6UsIZjeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMLTNI1c5ltRIWTF2nk2raRlRC/jgscHUeyfTq2bEx0=;
 b=qaSB0oIZW/jJEBz98QWcJ2WGfSR5GMoy6n/H7LtICf0zsrmaDpArnHlT7g9bt4JYswmDQdsfmJmNEBvfp3hZUtsQc4oVYhs3mGABuCdGmGIjzJjYUTou/G5pqm8BOclUhYKUhAHCdYddSrWOhEMTBFij0ZHqopvcKKjaflxpPe/GtXi6tml7mhviKRm501Oz2spx2tPbxrsGGb7uXo8p22YaGF5sQMOjlVnJYlAdgeGZrUJGCyhcg2Gp0locFaaTHGBvYfFqZXhktA5YCyCJvqgjQFgLPi1Zb8o8rylHiofp2Lnc954rqH6Atz5QTnJ8PbCqsyfv3r+/t+my20S5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMLTNI1c5ltRIWTF2nk2raRlRC/jgscHUeyfTq2bEx0=;
 b=f/52bsAjWN83FpZJ4NtY0o3RDLnUFSyP2PItb3n9KVk8NHLSvqS3vFod0pefIM2/UolQF0D4wMMAKyEUg7CSpvhricNEXnHSG8sKD+T6FyR2bkTnuk2yJ6gjnuEGetLjn2h9fYLWI4lZPvylsPXmtY2Ovmr05vM24u9I5TrNz2OblUABeysjveQafG+Ndme/kba1dhSkH20F/WzdyhtDlWbn9un7OTwyFZNRUMv6E/aN1uofhVDUp/rN7oaTcWgt1GdNrvkmB3KuqJZ9Ocvv9TCrfnJ8rNh+1IiXffnntVAMVJyq9ziJO36lVLL4BBf7Iqb2HtMTMQAGrBcfmRtWTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by LY0PR02MB152650.namprd02.prod.outlook.com (2603:10b6:404:22d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:06:29 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:06:28 +0000
Message-ID: <a3f83db0-4292-4942-ba37-338e0d3c7142@nutanix.com>
Date: Mon, 9 Nov 2026 09:06:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/gpio/pca955x: Improve @qapi-type reported by
 qom-list etc.
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-8-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|LY0PR02MB152650:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff9eb67-8ee2-4427-7a37-08df3e40bd59
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|10067099003|4143699003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: iFdYluIJPwkaK6wWSpnvwZs1pGKP40kueSNBHZSyUorj5ZJaTjVEFygN3dM0Svdl3AXmGtCUx/myUdtSLjU1ba6jG00mb7ZHGn33vf8qYgYevWd+5USC2KXhplZtfYDEkF64j+8mFrPhQWTBDtD1BwW/jliSHo5MTQlibFw17R4OhYZ4lyHmxIMlfIWXRmUxzxfndMVZLMxm+DhvpMkZ3PKd/8mZkRkq6u07nrKtMp+2B1MS+tifrDYzyutseSgICelRjYe5ZkN30URH0nPQE0iWdPV7lPbG2XzuYcLpAIwA4/0n2moy1NLwGlgYE8OIGprXH6FZDEx5d0+SJKHGExMC2/+PPNgTyXkNvMXg0TKzdMZgSqqvgmAvWFHtaxuzdnF/GhZ5EDi9n7SlnCm1uzbjevc20mlY/qfwyWzgUZuqMN7so5/Auh7ieJ94cXue451bOqMo1+hRGuTvfD1y/G3qYHD8ugF2uA7BdqRy+h2OcMiLHtiT7r3VkT84+CmWVFnx71ZreG2Nad6ySpEz2R7dqmp36KtmPb+5o9flo5SLdsE2xksf44AJNbBS/w8qgk+pY5C9uzrnccHS63r7gv5jelFZ9T/AYi0I0NfDkglV8Qo8f716J8PcrNVB5H6MgMeN+3LBuwqrPXDSz1JPIHTb06BUdWSRM6PRqHjcBSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVTeHZHSDJndThMUlFkSWNaWTJPd2lxaThMZzRaQWhnbnY4WWRPMUhHMGZY?=
 =?utf-8?B?R2VpM2grRHJ4THFqYXdGZGJBNmJybDB0QXMwaWhXOCtXUU5CUlRib1R3T2o1?=
 =?utf-8?B?dVhEbW1JUFFJV1J6S2Z4aEZKbytoWTNvY2FUM095VERZb0Q1UjZZeFhIQUxa?=
 =?utf-8?B?aFNCZmlDVmIyelRTUmlrS2JaNWxnTm8rd0hMNTA0RXhaSVgvVjVtWksxaTEy?=
 =?utf-8?B?STRQMzZPK3hJSW5VaThYZ2NTRFgyVGErMGFTam5MOXp1Y0xvbXlDc3lEYU1i?=
 =?utf-8?B?eFdiVVNtTXl3MEhQejlOUGM5MzB0MzFia01pMmJDYzJ1bFN1SHF5U2kzZjFW?=
 =?utf-8?B?UTV2UWNqL2hZMXJTQ3lRdzhqUTYvZmVjZXBuUVd4T1I1eWh0Q3dENDhTeXdw?=
 =?utf-8?B?L1RseGw3NHp3ZUp0UEhBNG5IaG9vdXJaeCt2VEJrRGpkZ3k1bzVOWXF3VS81?=
 =?utf-8?B?Y3VIdkNlMFhieGo4SVgwMTZ6UWJDSHdISC9RSjdDdm5jNVFaV0wzMkpZNkwx?=
 =?utf-8?B?Slc4YWpWa0VQVE1xNlNBL1piWkVub0JhMWhQcTFJUjZad3VSR3ZZOUhDOHE0?=
 =?utf-8?B?M3ludm9UOUtNeVFkbGRFRjJjNDArSkhBdnFWSklqVXlsM0hkVDRDcGpiaElE?=
 =?utf-8?B?Vmg2eVYrQ3IxZWxxSkVMVWtVT2VrMysrUXducmVyQ1piMGJkSFNOQXZyZ0E4?=
 =?utf-8?B?MWk1c1hnQzd1VTY1WVJMa1h1akhHQWtLSkQ1MHdhYm11Z3V3WFpKOTlueWd6?=
 =?utf-8?B?V0RFcytZSkxsY0d3R2ozY2dScVFRbm83dGJkYTlLNUxxeC9JbWdWL2pzQlIr?=
 =?utf-8?B?aENRb3JiS3JkcWhPRnZxODFXQXJYakMwVjN3dXZsUmtoakdTUVl3eDdWdUli?=
 =?utf-8?B?a0F4b3B1LzgrMjdjMUxLU2dERnNnRjBoclF5TUI3TEI0b2hwbHVOVFpacEVY?=
 =?utf-8?B?UXMrMzV2dFNoYWc3MGZLT1hWQm9BZ29VOVRrZjBpSWJQSyszcjA0QiswekxL?=
 =?utf-8?B?QWZGTVF4a1RKVXA4a3lvNTZiRVVLSjV2QmpGT0pxQXVWc0JIU2w3ajJXT0ZV?=
 =?utf-8?B?MXVReDNQU1U0d2VKSHZNSnM4MVY5TWoyckFEVVpCQkdVK2xNV0p3bEhlcVZX?=
 =?utf-8?B?ZzA4Q2ExbFo4RTdudWtOeGpaV0FINE5FMmg1QTJEbWJNdWtoK2RPbHNqUG5x?=
 =?utf-8?B?S1prUStHa2Q3eU5TamREWXZNa3NDOEhhVTZxZ0c5bkRCOTZ4Q2dqMEtXUjds?=
 =?utf-8?B?bE8vdTl6T3h1Vms4VWpLNG03Y3A3VzJ4eUVHR2NRR0tYeUdIdnJGbmw4WVlB?=
 =?utf-8?B?bTBVOTVjazRJcmlGT21GeEh4WDlISEZZc0djNXVoUUdWb01pWXhoYkNsS1dR?=
 =?utf-8?B?VkxmeFB0Y3VkTzRqMGpaRkk4cEpkSGZPVUQ4ZW5rZ3RaRGFJek1xTjFrNk03?=
 =?utf-8?B?Y3MwT0o0cUJ5RTdnamNLYXRxbVQ3SEtSeUJmSWY3N1BOY1pVN09ZcXh2aFk5?=
 =?utf-8?B?U0tuZ2xJcmJiTzJZdFNVYWlVNk45RldSWFUra2JIZ3lZNjZ1VVpBdnFQd2VT?=
 =?utf-8?B?MkMvMDBmSjNQcHpBaHBPaEdadVhSb3BLN1hwaCswWTkwd0QwdklWQTNpN0dk?=
 =?utf-8?B?YXowZ2M3Mk9ZcmNoa2I3endqS3JXMi9qWSs5TkNjRHYzd21mMHU5QkYwb0Ix?=
 =?utf-8?B?Y0UvVDdpdmNINE5GVktRTTZIcmpxMkdhZWM2ZnFFQ3VBbUh5SDRmSEt6UGlr?=
 =?utf-8?B?WmdocUdla21XbkNuT0x6dXpucy9pMWxpQlpBbHp5cHBMWXVRK1dEUEpXcFpL?=
 =?utf-8?B?SFdObWpaMVBTTXpHbU9EM29BanY5R3RKTlM4TUYvWXM3NlkwcUs2SHphdFNu?=
 =?utf-8?B?bjZJU3hNZ1V1Y0NiUzRHQldhNE9WMjlaalNQWW1rSzFhdnU1RVk4STlVN09E?=
 =?utf-8?B?bXRuYmROd3A0d2YrRUNNWDk5KzAyME9LendWeThIY1dGOWZLUUVpNDVTWXRs?=
 =?utf-8?B?S1REUzJFSGRxejFZSDZVOXRyZ1NSOGo2NVZ1ZFgyeTkyZWhReWFtQVJ4ZzRs?=
 =?utf-8?B?M25mRlE1NlhhZDh3bmwrTmUzVkJlRGF2dFF6dHp6d3IvOTRzeEQvV2d6dXdv?=
 =?utf-8?B?SXdCUmNSVFJSQjNpamJReXZEQnpPa3ZOZkdTUUZYREpKWExMNWt6UldNZ3hs?=
 =?utf-8?B?dTYwR0gzbE4wdi9PemJzZ0xYRUF0RHo4OTZtWUJZTk9QOHRiQS8wUWRZMVNt?=
 =?utf-8?B?MElnY3l3SkxpbVpqRXZWWjgyVitkamZ0NzdaMUcweERmVjE2OEFXellPT0N5?=
 =?utf-8?B?cjFJQnR4RGZ6TjA5dEJ0QkxkSW5MMDhPRlRlOVg0dFZZOXhxc0RNalhxNUFi?=
 =?utf-8?Q?3+cEO8jjwjuTqTBY=3D?=
X-Exchange-RoutingPolicyChecked: ctgve+KySMPBrTJjlyXFqSOCPiPPfywaEw8Ztn7EWOE1Wzob5N/ihCblG2ayYxkT3soM0NsHcYBIYqfzyppBodf84V481HqaYTjKcu4NF5pBNlkfbvHLoXXJpNl64Y6x9K4z1iDp0Kf++DuVmzgeIvtnjer/5bxjiW+a/rB30YoTknZzyHra6g54kPBS5utuH+faoJSFGAKIq22/JZHnv2L1d4seapAVKPsMAw3DTU+L12Gcno/VhDTZwrBQOwE0Wskmsynz3DdTmxoaVMurxoPYtyjVLvy/+PTXEpjs/j03g7YQ6Qb9UUShXhk6e2afz04ERQiZerqiK9cO8gmh/w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff9eb67-8ee2-4427-7a37-08df3e40bd59
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:06:28.6736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP+BVUrHEi2zeRM/3EWPYluiwigaSddMGCI9J/BYKjbntDFMryN/9Y0O9a/pnyAvf7uyXjzyh/PrN34dpVbOO33ZFIAqinfmhD8we5rxess=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR02MB152650
X-Authority-Analysis: v=2.4 cv=U5IHnuru c=1 sm=1 tr=0 ts=6af18d16 cx=c_pps
 a=SIO/v8SSfaR8RXaXrLdUYg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=wXitVT-Yj4ahUWn2wikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX/VcY+aMg7qSd
 bATajWMh+0bdP2hHWI7augLVh9YF8pSdP1lxfIzZM/7MvczSwiVVRbk89pc0jXfn06w9ekYY0B/
 KM9X1djVwW1MxfEwAAd81NbEXB5TbD4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfXwce4JpZAwIoZ
 hmZoGjW1Emx+HDHmMaUXb5vz8Ec6sqA5Vshgfy3yyFeeEyoBXRvPAr2evNyXyftb908qZXkDj8L
 xctwTRfP9Iw0mZOIuEREEsRBXJj6VJhPQmbCb25yRhDNov1rv6MQ3YcsTezFbWARrtJzfFuwCkE
 fbwFy044Dt2uq51IriiRKzApaKTs9yNASh3IrWLgTV4y2PCm5bvRIwQu/+6Q2rfDNpC1ABHM9jr
 CElZ0PP+M8mlq9izM6IE02/kHsXliam+ZwuHkXaUR9hCkvTWkoDV0FjycnnBhIpc9eqdp4b3tg7
 q68kMVwNVlo/AXUZ8urzO44T45qc5jtKuUpo23NbH5ZgmG/pUig750NISlsX96L5rXVCH7z9DRc
 B19TSW0lFiATiNXlGJPSZqtrsWTxD7sx4IxOjg0ztVOfLjQb9J9cEuf91R3l98jsYd5siLh1WB6
 6y8jm7bwCMfsK++K+Lg==
X-Proofpoint-ORIG-GUID: V1mnJDpsK0We_FuXg8I3_YI2hSqI8pHA
X-Proofpoint-GUID: V1mnJDpsK0We_FuXg8I3_YI2hSqI8pHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 11:04, Markus Armbruster wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/gpio/pca9552.c | 6 +++---
>   hw/gpio/pca9554.c | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 99c4e0c0e2..f97ad6d083 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -23,7 +23,7 @@
>   #include "hw/core/irq.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> -#include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-type-infos-machine.h"
>   #include "qapi/qapi-visit-machine.h"
>   #include "qapi/visitor.h"
>   #include "trace.h"
> @@ -547,14 +547,14 @@ static void pca955x_pin_init(PCA955xClass *k)
>               /* LED variant: expose the LED selector state as led%d. */
>               name = g_strdup_printf("led%d", ix);
>               object_class_property_add(OBJECT_CLASS(k), name,
> -                                      "str", &str_type_info,
> +                                      "str", &Pca9552LedState_type_info,
>                                         pca955x_get_led, pca955x_set_led,
>                                         NULL, NULL);
>           } else {
>               /* GPIO variant: expose the pin logic level as pin%d. */
>               name = g_strdup_printf("pin%d", ix);
>               object_class_property_add(OBJECT_CLASS(k), name,
> -                                      "str", &str_type_info,
> +                                      "str", &GpioPinState_type_info,
>                                         pca955x_get_pin, pca955x_set_pin,
>                                         NULL, NULL);
>           }
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 7bbfd5ed5f..e2d481866f 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -17,7 +17,7 @@
>   #include "hw/core/irq.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> -#include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-type-infos-machine.h"
>   #include "qapi/qapi-visit-machine.h"
>   #include "qapi/visitor.h"
>   #include "trace.h"
> @@ -288,7 +288,7 @@ static void pca9554_pin_init(PCA9554Class *pc)
>   
>           name = g_strdup_printf("pin%d", pin);
>           object_class_property_add(OBJECT_CLASS(pc), name,
> -                                  "str", &str_type_info,
> +                                  "str", &GpioPinState_type_info,
>                                     pca9554_get_pin, pca9554_set_pin,
>                                     NULL, NULL);
>           g_free(name);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E70606A336
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=tJD01vya;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Hhgvj0wz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBZj-00060S-BG; Wed, 11 Nov 2026 11:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBZg-0005xy-6x
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:53:28 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBZe-000422-GI
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:53:27 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0MAn3767214; Wed, 11 Nov 2026 08:53:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=90FfEb1h6XdoK/RY7SBv85txnPt5658YUAW904+X8
 Ns=; b=tJD01vyaEUkC/jZbYS7H+H0G34/Z7XEVEzGRHORW2cI77koH+Ow311rRF
 Fi/mHTalhh2grAEYnRjLxhUY61x6Ia2Uu1pATfkZZNFbARj2sZ5tw8eEyhG7QjOk
 n/+JHPLQa0nGoxUr1bYqg1heFhkMjhH8zG/e92HYDtXNgoQypwT05BsMtTJQbJwD
 gpRUDBCDfLEwUOhSuPVigiXEmVYjGU6/iPXtykGzjcB6lXS/QPjZlG2kkDwMv66f
 OF93hkhdh15x43G5Q7MiNlkPXdLt90XZXw+dzBAoUp0px02MvjZRyXdTmPtZfl8W
 c145rpamn6F7y8h90jjOXWDcZk7Nw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021111.outbound.protection.outlook.com [52.101.62.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hupmrn76j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtP85UHONYn3X5UPUEvG21gldIAIo6T4i9lEBfq7Dq4kyv5KJ1q3HGQ1OUB3ZbGmIM5nTzzvmCxp+BxXLv8bFySXDKXrkYJxwCDEIgn9/HKKL5jVltFaTjczr1EQBOP8Q2uAzUHLfHFFD+jvqvrLEFMRaP7HSJ2dvDgz/S3eUlfSKb2uo/GiLoeaXyjylbtmuC/WgNdPsdxYEa/smf3vKlN8cDhZqATZd2yVt5u/kaS2I93WD6uPGrF+Jg5AhNmNwmCXgVH/8UsEOQG9ODMkC/e9H0YkAZVnrm8bu6MKKjJ0eVH9kGdEw9Q+ljczdrmgjKij5TjIQItazdK1WCUK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90FfEb1h6XdoK/RY7SBv85txnPt5658YUAW904+X8Ns=;
 b=XYenb8Fm8lect7+2ga3W+EBPAyLvRTUjKMWdvnbPQOCiRfENMFzU0kcFHjc4PJRn+9Wvfv9mIR00oHKocYRULqApD4QmdOcIv+mhqXMfQZNeSeX+5diCPO9nUoEj38+SEQQ/uNNRhv43FBa3JMUYdT2nXkRzqnQL/fTFewl80kwI5T1ULGMMbpSr3/En31TDvHphOAlyEP38WA5Xu/L086kcJFvGeJEJWh26xBG3H2cfp2xEeVyeK4kUxWOp6jHHlGPcJauK98SEjV4pai//WVq2nMv8n1MVUaxcg+dpcbGh9ahXIOqPAcCKpzA4plQNDZNilZMU/eCvqmqGQEFncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90FfEb1h6XdoK/RY7SBv85txnPt5658YUAW904+X8Ns=;
 b=Hhgvj0wz+gklLGdNvYDJvYmTh3ozJ9pvxUq/+TRPOgqfBMVoDLE6ABHLC3mrMn/jdjBb2cSPWrpMfMez0phwn7vJFN3HwMrTr8v6mPgj73iiXhhhtZ4Kxg/RBz6MsgMbH/URt1M6NOKlF/rjwuJfgV/IZ48/sdafxkNfbJko0OX9LVw6Cco6vAzpEyioAbgxQ8UPdNHPB19UEmbiQnbvJxY+T5yMzEOtVaUUpRV8lwTaJLKg3GtualMNzgTu1Pg/i7UJ1b9oqJ33xBYO+Rxe9zXWeHKfg3WxYTpmBIzrTqic5R7ZXWp7KZ1Vvjtr2VoPct99V3vdDgDgpxtBX4uaAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS6PR02MB369017.namprd02.prod.outlook.com (2603:10b6:8:4b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:53:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:53:14 +0000
Message-ID: <82e210ca-a782-4224-9a29-d9230799b9e9@nutanix.com>
Date: Wed, 11 Nov 2026 16:53:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] util/memfd: Improve error message when memfd_create()
 fails
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-7-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS6PR02MB369017:EE_
X-MS-Office365-Filtering-Correlation-Id: e40e8834-d2e5-48de-19fb-08df401446fd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|4143699003|56012099006|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: raBAeWrG1lqw+q+YmgqtoK5e3YTMZ5uN0/B+4TGvoGBiQ4GJTwV2zA07SQpo4ONaz8JhropAgmLEyfnaXR7XzIEG/G56LTK5la4ZGL/7JuEsg3FFMC7c6O+Od7UR7j/8Zq+tqvaQT+q5BaLxSrv+suMACsB/gynAICgD71jnrb9zDTsmO23eAwENSn1VMl4Ae0N/wKrQXlN9eOy+qIoNChcuH+n/ne0VVwdP7hxSWT0Egk5aM0qx9fzoJLqov3W1HK3OsNrYRoj2JfS7lJ+fEgmwT8h8GItUT28euml2VfIL3exmfaI552xsMXnzpDFVrJ5aGivbSZnY41pCra37xQahbW1O4x2zphcojy4U/9xiap0Ic4MKJDwwzL2lVHVyRcO0qZdQQqwYmFxJQeEfwwXbgGpeicnB9rPqZD0NxVuq3LuZesduMHFeh6/tszR92/dOz2J7xNyPNVtIAteSyGjuVbpcRl2dbK6dqmVSzCMHUZLBaxCyEFvFtRgjCdssyhRIVG5eWxvYye/8FzkWBEgDPp06Wl/V2llnaERWcTiB5M7WtIjQtJiqrvyDyJrm3exVV0z+bOMcK8Z8WRWBCYlf+oUm6014QAeNTfFcUeXOdHgQBCcEsNNgV7t9Dmwr0cCzUetZxR6N8jpBBuaHG6pCSIhbg4Oxq0uhEuFyhfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJaRXN6YTF3cmJQZDBVSDhzU2ZRRmdocmRCaHhLMGNKdXpmZGdTeDZOSk1a?=
 =?utf-8?B?Ky9CcEJZZERXSDF4MkVGT0hZQUNjT3FYNzRHRVpwTHlMWWFSeE0zOUNVejJN?=
 =?utf-8?B?YmxrWi9TVE5sVWM3M1huRHFRNFhRWG15bEQrcVpncU9KRzRVc2VXZXIwR0ty?=
 =?utf-8?B?WTdVWmhqb010N0drNmtHWEhGZHcvZlJmVG91d050bndqZTZxUWdVbkRmcnFI?=
 =?utf-8?B?VU1LbjloSjM1VnRyYTZtaDAwVW5QeXZYR1JSSGlwNy8rYjBTWlZ6UzFBMzI1?=
 =?utf-8?B?RWExMFd3RE03Yjl5Mk1zcHRJcDNrYURxQk9oVFVUdm9IZm9HelhrTExwR0sw?=
 =?utf-8?B?SS9zNmlSalZjOHNyTGhSU1RHampPVXhiYUIxM2d3MG5raHpaM0xVMXdQZEJT?=
 =?utf-8?B?Rm5zcVVsQ250bFhBZ1UyckEzclAwbWlRZnZaNEo1Q29kZVNnekRxa0I0YXk2?=
 =?utf-8?B?dEJ1cGRXR2NhWHVlVU8rZkhWc2ZaQzJPV21KNExiQ0lreDRacU9qZnhIL1ZJ?=
 =?utf-8?B?dldEcC95SzdWS1l3UG5zS01pd0pzazdaSS9lK0ZuR3U5QVVsSzAwWEhKS2Rh?=
 =?utf-8?B?N0dJMkRnU3RpRUZEZ1pEdUJVeHVlbEFhQzlOUlB6dVJMQnREWkxLZG1VNVBO?=
 =?utf-8?B?N3lHRVpaWUdRelJYWkZCWDVLUDZJN3hZREtnbUJuQ0ptTC9DWWUyL0ZiQ2xR?=
 =?utf-8?B?NFIzc3FrZEtGb2prOHp5MnNidlpPT1RrbnVndS9odGsxVXo0MDFEOHJZdEV6?=
 =?utf-8?B?cDE4WnlTQVdMVENNOHRjcFIwTWFnNTZNYk5hL0xwOGZBdTM4MUpoK09lQnpq?=
 =?utf-8?B?ZXVwVTVPcmRqdndFWkcwbkI1bHdKNVVWVmdRSWE1M0tkL0VaSnlNOXhJNmhI?=
 =?utf-8?B?dVRDaGx1MldIOVJxbldBQTBUYzFKRkl2ZFpZYzQ0czloUUI3dUx4eVFmVWlo?=
 =?utf-8?B?bzVYKzc3bmhJQmE3bE13MmtMZjRWSVFocnQyMUgrVGw1eHczN1ppNkdkZ2Zo?=
 =?utf-8?B?aFhIZmwvcnhtdmhsZHdyS0hXcGExSnUwaWdaZ2JBWGJsdDlLUEN3R0dhc0Mx?=
 =?utf-8?B?MGlZRVNreGhIblRMNFcrN2FCdXl0LzVmcUJEQmpsam10M3FwWk40c1F3R1pZ?=
 =?utf-8?B?clBRTmZqMm1NaFR4RTVVMzB1dkpLT1lraTR5cjBxSnowNnhhWFN2SHJtMlFw?=
 =?utf-8?B?VjRRdk54N3hWeGZwaUNESnpVWVU3QXFKbHlIV1lVcXl2VUhHQUhOU2pQRUdI?=
 =?utf-8?B?SkRUUkN4ODlXQ05GQzczbjFXakFsTm1CK09GSGh5RnJRNEFFYk9kWGVET3Ja?=
 =?utf-8?B?TjFtSXN2YXljbVFicGF6emhPQUVqdGhKMnVVZEJXWmphUk1zaGZCV0IrQjlG?=
 =?utf-8?B?Mm43RThvako1S01OZkkwWS9pcHF5OVpUdFdnZHhaZm5XNmdPL3RaVjBDV0gy?=
 =?utf-8?B?QkV0U3dnZy9KYXIrTkk1QkYvbDJQYllTOW93S2VNZ2x2UGtMMmJTZk9ta3JS?=
 =?utf-8?B?cnRXSXVEdFl4MHp2WWdsOFFMUTFGYXV3aXVkN1N3Wk52V2xzdGxMUC9USHMx?=
 =?utf-8?B?NjZtWDBPLzRhVEJwQjdNZWd3a0hWa0Nma2JkV0lNWVVGSmxWV21VUlpZRnZp?=
 =?utf-8?B?RWdCM2VjWjZ0K3V4NDlXWGVzQmYwNzB3ZnBzSVEvYlBpY1pURGRQRGhuZmVk?=
 =?utf-8?B?dTVFb1RtNlpSTThVZFdGdDFEdHJWeHlUUzdKV1ZTQ3FMYi9CTVQva0tTSHZR?=
 =?utf-8?B?eHA0eHYxaHFWdWZuMGdXdFgwb3VVU2FyVVh0N3p5NFFpL1U0bVNVMi84TzRn?=
 =?utf-8?B?dTJ6cmdUZHFWR29IZDFmekRUZEt4NDlQcUV1TDZwK3lKWithcGZsRFlvYk1D?=
 =?utf-8?B?TFgwWWpWWVpvMmh6ZGtlRk56QStpQWlKN0J2WC92bFBYZ1dwZUpBTFRwYW03?=
 =?utf-8?B?Wk5GWnNpQWhlOG4vRytCQ2hsOWttNzl0US84Q25UUlNCakxNSVVtZG1OL3JX?=
 =?utf-8?B?V2VyZG1jVTBGYllYc2JNOFpBSk9USm9MYllBVlROSUtyWUdBM2hzZlpwaEpW?=
 =?utf-8?B?WTVGMVpmOG92ek5WZVdVMlhRb0RqMjV4M2NkTnh5a29sOFFTODFYT3ZENGhk?=
 =?utf-8?B?R3FiRmlrcHhCUUpqeHlwZ3ZsNGVBVy92ZXF6L1EzYmc1RUlDMjN2d251cG1j?=
 =?utf-8?B?aEx3T2dpSFpjblRmd2FZM0d2YXNKRHVuNGFuWUlmeGNnS0I0cEJ6U3hYQjV0?=
 =?utf-8?B?RGhndWpsVitxaXUraFVldmVSdjdYbmpHODR2Qm1HMXB6andXYmoycWo0YlF5?=
 =?utf-8?B?bjFlRThTUGl5NnNmaDRZcnFYNlI3bEtjY1o3UHdSMU9XTk5mTWFkU0dYc0ZK?=
 =?utf-8?Q?3PzI9LwGfr4aBGzQ=3D?=
X-Exchange-RoutingPolicyChecked: F/X6mlvwm7iImcCOs2LJJYu71tWJMSv4zMrB3nTlHUTqm3g3o/IBhfajLkTHStKM2+3knbE5lgLiUr7LO7nkw6Vv0UyrS+CRq+cRhKQT3OSww60dT959OwZ1iICahZ5MIsaL2TSmVjKYpWrZDSJOwD7r7i1DlZXiW64XY5bmQWzBCpWcF0lC7kX0tkouRJq3PHnymV2CRSKc3/wAp2Xe8VzSqqt6vwuCMllWQ+g0w0/H9+5Wwm3G4pAyCs/TlnOynV2qLgS1PMYHGg24NfnGSzVojNPVytOKITbUTprOcULG8VtkTlcw09RRggOwvAjv5HM0egGYou+QxmwolommOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40e8834-d2e5-48de-19fb-08df401446fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:53:14.5348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /09PWH4yWDW0ATYnfqgiInGcwH5aDPqfK39xPlI4XMal8j7mvFSjjky/Ua6pUaCcvf96bbcCBF0MSRxRLnNja13XQxpuHz7TPATrGKZHsQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR02MB369017
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX5low0eY4N6kc
 BCWZ//ak5tHTCCKl92XhnGLEhQdBmGXB7wsIt9R1Q35eZ+BfdrqiU97m+wqsmyeLX1kK34sDYJq
 0Ae0xwPoKoE/hjMkBfQ+jO51QMFtlh+KTBzFYX6XHPnM3CJNkVE9lfZw+d64ai5SOQXybrKHTL+
 HFUyW5ifqhK1uAEBBEq2ZV+1TDbGDjc9peONRjJcOLwcvTNxCNqDUQBG2Y3ItG7eGGREhLmZBcw
 CC7YlgwqCB//HzA2KcLCSCC+iwfTPUDC615349mB2LjUCDe+wU9kwwzpttD/0bq0GoTzWa5N8aN
 2tyngmJPhriUSRe6a1rWlBVqtbi6e4QkRlTcRsJUm1BUt3wnZMwBgviRM8lvkxgaP946SyocQvx
 IaSlCEFyQniLuY3Dp9dI0GXFts7b1vaDmjij/Pm3GDFdNEVU5cJsaL3bvs2jSLixwEcMuAjxR/Z
 PuKZ9QMqhzgxQr2R6Ng==
X-Authority-Analysis: v=2.4 cv=fdU4WEQF c=1 sm=1 tr=0 ts=6af49d82 cx=c_pps
 a=pLVGl/zQNnluPJXkQhez9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=9DF22Gm2v1b-T0uyJSAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfXxPvK6wg0Th7s
 CVOwNbnuix7phBxIOjhEI3YxrI4lyVtjFiDno9u0ktTpmsm3cuVYm+nWoy1InW53nQg0UXZ7s1+
 3YwFDTbFK6Vb57nHmoySnlkyMPFfY5c=
X-Proofpoint-ORIG-GUID: x1GXNxd0_lYo1fZ2Z8byvNn2Cv3NdWL9
X-Proofpoint-GUID: x1GXNxd0_lYo1fZ2Z8byvNn2Cv3NdWL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:23, Markus Armbruster wrote:

> qemu_memfd_create() reports something like
> 
>      failed to create memfd with flags 0x3: Invalid argument
> 
> when memfd_create() fails.  To make sense of this, you have to
> understand what flags are, and how to decode them.
> 
> qemu_memfd_create() computes the flags from @seals and @hugetlb, so
> show these instead, like this:
> 
>      failed to create memfd with sealing and without huge pages: Invalid argument
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/memfd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/util/memfd.c b/util/memfd.c
> index 07beab174dc..a398b246600 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -73,7 +73,10 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>       mfd = memfd_create(name, flags);
>       if (mfd < 0) {
>           error_setg_errno(errp, errno,
> -                         "failed to create memfd with flags 0x%x", flags);
> +                         "failed to create memfd %s sealing"
> +                         " and %s huge pages",
> +                         seals ? "with" : "without",
> +                         hugetlb ? "with" : "without");
>           goto err;
>       }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.



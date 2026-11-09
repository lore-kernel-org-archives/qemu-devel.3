Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDC606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=JmJtGgxI;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=BcTEb7C7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLKF-0002Li-9n; Mon, 09 Nov 2026 04:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLKC-0002K8-GV; Mon, 09 Nov 2026 04:06:00 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLKA-0002nQ-2P; Mon, 09 Nov 2026 04:06:00 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96ADAv3271611; Mon, 9 Nov 2026 01:05:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kNYfByTG/HnZLXlcKmjqcurotShtwU5jF7IHaYi5x
 Qw=; b=JmJtGgxI1h5pWSV+TlpYC1UB2+dXdGtGY9WwQI7NVNPZlL8NRWgVDkNY3
 M1aqq4ovoHbiGq4KEn5xiisfsI9B95yHt2tjS8ubxuOB+a2lNFuZysToLbt9vHpq
 fBVHrKDDYcirxD8NX3yoLLpqykAiBoXnJ1/7ey3Ap2Cx0jvIayI9lbfo/vTNIzdt
 APqDUCESWGKGkR8LWaJ4fOKk7yIOE+lpBxJcXAuJGqBAE2brJL1imityikmiYz/e
 g0EKsD49wZmgfH+jf/xTag15FD3lV5HjcVCgEJLdgvdUm+r1jkTp6BDiF2DIs5zO
 S0T5jBOQ9nfbqkT2hBodlic7FL2Cg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023133.outbound.protection.outlook.com
 [40.107.201.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht46gjcdf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 01:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkjO8LZey6XnpPfhgQc0+3ONzL8pIKmdQvGFNC5rWSxA3l+UQ5rkQcyLeNG88b8Fr0Lz5bLeS1BfD17bYEVIt+dFTLhJH5czyvhHbyjJcKLvv9MXsIX0Ej+s12qEMVgEg/ZlFCZC6EyJiAYCnraTU09hMNawO3boiQKxmJ55gFUu4ZtaAESJJtpBYfmv7WxNZxvnhRqKBTVpq8MuzY2bEhB4+W0hCxbHcgujVh9ZSIkICB1x6WQgf++xcCk6GpwXmnm9H2gneWHql6nVDYt6iYB6W1KfHUVdGSEEhC2j6INcJhbpFwtQsQSozCBS1VSvgWo5O9J5fF1eMv9iSB9xQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNYfByTG/HnZLXlcKmjqcurotShtwU5jF7IHaYi5xQw=;
 b=tPkxcV7fZEjdYECxPvhhbcM0YqCXvss175NqvHxOWCG1LqeP1K4MOqjbS1FBGvvUvKlTMDjsnflBfFniMEb4M8BxGkR5ZsmZGUTNsLWi5M9NpOGG4znwqp+4s9QoHA1toWej6DetxkxdlyhPPSELNZc/obCPC39AVNhdSNGNsXUQwBr/zb3fjNtCrgcNRz83E7HTzNY/osvbYJn2u8NGPvOexu7ApwhgElPTzcOUqZfbnCMMIBWwzBrcgP487w8GJpY8IcBwGzNJ3W6s1c68Zdaa0EGGWRv1OlNohHScIB8o1+feSfrpPgUqSeGg4yeNR58b69ksOn1vyfxpa3OWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNYfByTG/HnZLXlcKmjqcurotShtwU5jF7IHaYi5xQw=;
 b=BcTEb7C7rD8neqcCyXzUpj3qElk6e/E6P1FYsgHoVkIhYbTlXAOwD2rs0LMjH2FwEDEUdxeyEtYLtzMYMmtxooKpGt6hIblS9IrwaULj2ammZt9Iw4D0LxNnYFDSlKLYtWcFZCmNvRDbLdcPSQt/LjsY1OIzvNy49hO5WiqnCP+vEGe15waqXuUcwWEkESveb3Kz8h/eg/jlLIicjbC/1j4Dvj8os7UHKp8uQoWvBdnaVDsFHEdTKdpyZz8A4jFWLSkZ1vzr6wuQhRlTezF0Fe6wH5Gitkuee3ZSsP/8+GRt1nj0ONgWUtsWshcPgTzwbETM9+4TpfS+j/GILzmTCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by BL3PR02MB7891.namprd02.prod.outlook.com (2603:10b6:208:352::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 09:05:52 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:05:50 +0000
Message-ID: <df5cde6a-2130-4d69-842e-32e6e705bb58@nutanix.com>
Date: Mon, 9 Nov 2026 09:05:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/gpio/pca955x: use QAPI enums for led and pin
 properties
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-7-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|BL3PR02MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a7dec8-bc27-4e0e-b111-08df3e40a6b1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 8joqnv301HUnGm1I3Yoo9jabte6251OTbh4Y2TY3x6uV0rks0LOB3XMByNOG8Okv59G7F2Lp/1hruNcRCKArLnSYqPtcnVUQh88LFXJ0kCq70r+0L3QWgAAMVkCoCOXA5q0EsBQwbTUTkk501ttKY65UgSQMV68fKhkrRP53sawNc89cl+7tvVuq+aCxSmE83gornHE5FL7+e7Gf+FvYMiMB0jSkNbhXwjlSIgerWPpIKCYWu6W2PA0hmNArK7kfaiiiFrzWoSyT9KL+0uxD6sI27fGJs80g0jT103+WjOXcYg/yQrRJHEgZBOWtlHrD67elWIyNmGUoTDPAmBgM4NgVVlb7hh7vvE3pDLCWRRavzw6gRbohJrTO7kG1SRqxsEEXX+FitfH4Yjg9o1g8SY+XmTqo8f0XCkz6fhdzd5aqTVCZjbGxNjoCS8s5RFW7A79HpTFsdQYa97MNQPKQhGsXnJaogS4SFiPzAVvKjppkctMa2pjL853XfJ4fm52kK3QtRu8FL14BHVsoyBgXdIBRgFVI2ASSpLNLHbop1LCgAs1lGgIYnYOuWm9RyFM3d1kJQk0+AHjttKVeAfV8Aatt8knzFrs4q+w6HKKLIjzMhqaOLKzgo59n/bV+DUNWt+rUZGzBHszpD/gB+S80ALkxjRN3soX7JXzvnpWTarQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdqU1dEN3hsdnFOemlqc01kNUVSOUxzOFU1ZHpwbUd0bXNMZ3FtK0tITjly?=
 =?utf-8?B?SGdWQkpla0VsSll0cjBLS09NZm5pejdLMFFZWlh3ZmhxVnY4Rk91RnVxVzVr?=
 =?utf-8?B?OUNmOUpKNitiOGx4Nk5OMWF1RE9IMjJSalNZbnEveGVTZHFUZ3ZXcWJqY2VP?=
 =?utf-8?B?d0dSNUtIY2pVVVBZTDVGeEZ6a1k2dEQxekY5VTRzUXNQQnZyVXhVZ2NCUmYr?=
 =?utf-8?B?bE9JdjV5enptblpNS3Z2cDZvNldLcS84VndUVU1iN3hibGEwbm5kNWZ4VHBu?=
 =?utf-8?B?WTR6RXhQNkYwU3BmeXg1aDQzaDk0amUxQVMyRnhHTzNLMGJsNm5ycWtVQUZS?=
 =?utf-8?B?d3lGRXJ1azArR0ZFb0lTNW94aW5TTGRQdzJZYmZqT0RJdkRWTDdYZG1NTFBM?=
 =?utf-8?B?eTh6MVJJVUpxbGY1b2pLNklDNGltenRyZ1lOV2NWYlF3Znd5MjVHL3MvNHZz?=
 =?utf-8?B?OGNWUlM1UktObDgxREJUdDVTbUIrV3BjYzdueUtUaUlPMEk4WkhJQkp1TVQz?=
 =?utf-8?B?QzgxeHZyeGllQlV0TU5TZCsxYzNTZnpQYXMxVk1DNURnVGFha3ZqK3VQZEtv?=
 =?utf-8?B?QVNGcTJybDl5emRZQXJzTTZlV2V4eTVoWGZGc2NzTzRjVnk4c2wzSmplUFNS?=
 =?utf-8?B?TkpFM1QvL1R5Q2RZcldacmQwdXdybzVWS05uSUpUaDhMU0VaYnc1dUdaMkoy?=
 =?utf-8?B?K3JQdmdVeVBwdnY5RW1zQXhIWFg3SW1EQkkrR2ZXMlhZbm9yVi8zZVZXam9l?=
 =?utf-8?B?Rkx3ZDZUd1NpUll1MjhKcy9Tc1JFVmNiYnJDQUc0THVmejdSNUpHbm8xQWFl?=
 =?utf-8?B?ZUk4ejFGdkJEaG1WN055MXl0SmZDNHZidXJKajF0OUVGcG91SkhoR3I3ZUFB?=
 =?utf-8?B?VFZNQTExT0NnWjNqL2tpemJCVXBVZWNNSTJnVFozN055UGpiYzBrOVFpU0xJ?=
 =?utf-8?B?cDRXRXhuUUhYQUljdlFwbDRUWUM3ZDRsYWlzbGtQb2ZKLzFZREREUmNsazZ1?=
 =?utf-8?B?TnNXVkNmU21neHVObm1sYlVyb2pwZ0U2MEhZa3ExZFMwdG9BK1lTM3BKZzZQ?=
 =?utf-8?B?TDNick1NVVMxUjI3Mm9vMkJSL2lPMjh0eHdpSVdBK0dMWU5TVFBNMHFNbU1x?=
 =?utf-8?B?dElzeldsZUx6c1lZVS9uMmlVMjdtM1ErRU5jdTQvMmo0S3gzYkc5cmR5ZDNn?=
 =?utf-8?B?Sk4rbzJYUFFjWkhOeXRuZklXTkU0WFJTNEhhRGpMa3l5SUNnQk5XZU5uQnVB?=
 =?utf-8?B?c3RPTVBDaytFYXc0VFBvRy9XYm9wVDlnd3VDNGFQbzZOcUIrMjZzeERYeHNP?=
 =?utf-8?B?WnRxeXBHTDRBbDdsUjVXcjdPTURWM0NXM1kwNk1DY1c4Y1J6RnlHbXVWLytG?=
 =?utf-8?B?bDVTL2tab1NoTmcrcEZwcGErM3NnSFBnOEFGRlhPYTdsWWNBRHp6TlJnd2NP?=
 =?utf-8?B?RmFWSU1mVWdJTHNNM3VXWWFQVW5XdVB0SHJvU3BvYTFMUk5BMHkvZk1hNzVO?=
 =?utf-8?B?UjlEKzRwd0xWRWJiRnh3a3Z6M3FXb09vYWpKTlZiKzJHbjZoYWNzNFppcCt3?=
 =?utf-8?B?bFVVUlY5RnZ5dFFkcmU1RE5lMWxKa0FTN1VwdEppNEhLVEZ3RW13NHRuUFhn?=
 =?utf-8?B?RnNsdWhKTTErWFh2S3FTQWVmWmtmL0RGNWQrclIrazhGVGUvRFk5WGFDM0pZ?=
 =?utf-8?B?UTZsYk9OUGNqOWwrZ3ljSHNQcVRMUkV2NlRBOEJyb2J5a2grRjF1YTlrcDh5?=
 =?utf-8?B?T1R6c0g0bjVZTmpKamh3V01ldzdVK2FyVTdxRzhJRmVXZ3AzMUVPZERXQ1g5?=
 =?utf-8?B?aWxxQWJyQWR2NXZMMHpWdGVMN3VFd0l3VEJJbHo0c1BjQ3h1QnRsQ2h5Wndj?=
 =?utf-8?B?YmN5SUMzeHRpZGxtOWlXOU1aWkthOU1idy9sN3hkK0d2a0dDM0MvU0xDbzBo?=
 =?utf-8?B?akZZdW1ES3FYSVZGNjBmWnRKMTJQUVJDZmpjVmk1R2hUWTlRWG1XaktFS1ll?=
 =?utf-8?B?bzRmdTdncVltZTNORUM2MFE1QUtCWXp1VmlHNWxFY2l1Y0p1bThqbW82Tmxi?=
 =?utf-8?B?bit4NHl4OENGbVBHMjYvbWxMNkJRMzM2bktwZVA3NDVjeUZFYmZzSlh1NGo0?=
 =?utf-8?B?Y1kvd3hNTkFpSzlHOVRWR3Fncm5mRXdkK29SV291N2d2QU9LMXVMWGFkWHZ2?=
 =?utf-8?B?ZkVyVm9pWS9QdnBjMVlSZHBBQXIydSt3WCt4b2Q4R3dYT2t3VklSS1ljeWdh?=
 =?utf-8?B?N3ZEL3p4V2NDWUN4aFM5bm9vRGZhMUk1S25QaVNwTnZWNTJsbHlvM05zaFg0?=
 =?utf-8?B?elA1VkFmR09zN2hPTW5Rd05vakw1QTNMakc5V3A4MkNOVWNCVHVjY3pPWTh1?=
 =?utf-8?Q?CaKT1kH06UvG/OHQ=3D?=
X-Exchange-RoutingPolicyChecked: eTnBV8RpCSYTGvNaOKQBBzvSTBWiaUPJqSq0t8rWPjw6JLjAiojsMQCIw1oAlo1tCexI+EKz24JilAGD0R7913cUGKbizjBO7ltMkO+IR0AgGsrt9GVAt84pLcw4Ga/EJkTUDwi5vhBeuyb2LkAIjqHvppZvFTR8ppm+Wbc7xrNoTGNbyhGLidm7oyvdqJmUSoDajrTMiwuV+Q7NSZs1cWsRMBwtEQrug62KLWp3bBGXZmYSYZ8e/59//+d304eL9Fnpt2PGk4WP31k8dROWnFroK5e4nJYNlF9jb7vs4XoBIsDDoWwxFmyjkj9715Rjeaa/DRgd1bSAJRWZ78U5Ow==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a7dec8-bc27-4e0e-b111-08df3e40a6b1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:05:50.8754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkhqx0pxzFqid65JEkdlBmGp1AX2e5WvM9Hnnli56yGX8TU99tfv4xqu+wVZDNSp4WUeZoRAVdjMoyyBcNWyBzSXN8fMvm9/lEMyplkAG+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7891
X-Proofpoint-ORIG-GUID: AbWQjldEcTCa3vTFGy1QbWdDtJrLrwrh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX6dfTHcKsksX0
 Emzn3qlFW6ApGVwr/Lv/7sABbIBUoUUYUz3SK6AiNQ8gO67M08apKBIs//bJDonVo+exQgCWw+D
 L5w3g/0cYsDcDONfIEhdQp/BEwRw5V0=
X-Proofpoint-GUID: AbWQjldEcTCa3vTFGy1QbWdDtJrLrwrh
X-Authority-Analysis: v=2.4 cv=YuSa1IYX c=1 sm=1 tr=0 ts=6af18cf2 cx=c_pps
 a=4JgRTaXVPfESfdVeiImlhw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=tejW8oXMRarZCxcndP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX+S72O3u1Ew9d
 Qijgi2zn3DGDr5b3t3U/ds0Z8oW6/xi5eKXo6mpaY/P0jfTZjkXO6VXTqjR/R+eCkQL/SDWDF6S
 562l7KeUvnzbJhd5OtvPxPv9oRe1rJlxrNWFyOKZxF2aXaXgPrR1Dvk6PqbfE+WrqEaXvEVsRjt
 8Kgv9LT2HyY+SWTmLMC/Rbk/x8jguTsbcd2aUnvMkISq9c2Mwk8Ld+YupUpq20cpYmqdC6SbsKC
 iSjT2C9uvyX+NxND8763V7o/ZBVK1Slj9rVjtxYIUweSQ5g8u7Hxs1GYVFq9OKoloBpg8BGbh+Z
 /4XTOr+ibT7s9CJoKYZTRho7f62GRikk5rONKI52yCLPg7mX/zsw7jSdq3/zUUZCO/azK33JYSO
 FONoeyJFiTe+YmwG0nBSgNnXyL4US1o61CTDwGMe3Yk1Fc/W1ajRKbGHtVl6m1JStczDhNiM2U9
 aAUypR5Ju3dpCANqwSA==
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

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace hand-rolled string lookup tables with QAPI enums
> Pca9552LedState and GpioPinState for the led%d and pin%d QOM
> properties. This lets QAPI handle string-to-enum conversion in the
> visitor, removing the manual string matching in the setters.
> 
> Add QEMU_BUILD_BUG_ON guards to ensure the QAPI-generated enum values
> stay in sync with the hardware register encoding.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/machine.json | 29 ++++++++++++++++++
>   hw/gpio/pca9552.c | 76 +++++++++++++++++------------------------------
>   hw/gpio/pca9554.c | 35 ++++++++--------------
>   3 files changed, 69 insertions(+), 71 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 18d9dce849..c4c8720909 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -416,6 +416,35 @@
>   { 'enum': 'LostTickPolicy',
>     'data': ['discard', 'delay', 'slew' ] }
>   
> +##
> +# @GpioPinState:
> +#
> +# @low: Pin low
> +#
> +# @high: Pin high
> +#
> +# Since: 12.0
> +##
> +{ 'enum': 'GpioPinState',
> +  'data': ['low', 'high'] }
> +
> +##
> +# @Pca9552LedState:
> +#     LED state for PCA9552.
> +#
> +# @on: LED on
> +#
> +# @off: LED off
> +#
> +# @pwm0: LED controlled by PWM0
> +#
> +# @pwm1: LED controlled by PWM1
> +#
> +# Since: 12.0
> +##
> +{ 'enum': 'Pca9552LedState',
> +  'data': ['on', 'off', 'pwm0', 'pwm1'] }
> +
>   ##
>   # @PCSouthBridgeOption:
>   #     South bridge chipset option for PC i440FX machines.
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 65a718ef31..99c4e0c0e2 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -24,6 +24,7 @@
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-visit-machine.h"
>   #include "qapi/visitor.h"
>   #include "trace.h"
>   #include "qom/object.h"
> @@ -60,16 +61,15 @@ struct PCA955xClass {
>   /*
>    * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
>    *        chips are the reverse of the PCA953X family of chips.
> + *
> + * The QAPI enums must match the hardware register values.
>    */
> -#define PCA9552_LED_ON   0x0
> -#define PCA9552_LED_OFF  0x1
> -#define PCA9552_LED_PWM0 0x2
> -#define PCA9552_LED_PWM1 0x3
> -#define PCA9552_PIN_LOW  0x0
> -#define PCA9552_PIN_HIZ  0x1
> -
> -static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
> -static const char *pin_state[] = {"low", "high"};
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_ON != 0x0);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_OFF != 0x1);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM0 != 0x2);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM1 != 0x3);
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_LOW != 0x0);
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_HIGH != 0x1);
>   
>   static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>   {
> @@ -143,24 +143,24 @@ static void pca955x_update_pin_input(PCA955xState *s)
>               uint8_t config = pca955x_pin_get_config(s, i);
>   
>               switch (config) {
> -            case PCA9552_LED_ON:
> +            case PCA9552_LED_STATE_ON:
>                   /* Pin is set to 0V to turn on LED */
>                   s->regs[input_reg] &= ~bit_mask;
>                   break;
> -            case PCA9552_LED_OFF:
> +            case PCA9552_LED_STATE_OFF:
>                   /*
>                    * Pin is set to Hi-Z to turn off LED and
>                    * pullup sets it to a logical 1 unless
>                    * external device drives it low.
>                    */
> -                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
>                       s->regs[input_reg] &= ~bit_mask;
>                   } else {
>                       s->regs[input_reg] |=  bit_mask;
>                   }
>                   break;
> -            case PCA9552_LED_PWM0:
> -            case PCA9552_LED_PWM1:
> +            case PCA9552_LED_STATE_PWM0:
> +            case PCA9552_LED_STATE_PWM1:
>                   /* TODO */
>               default:
>                   break;
> @@ -177,7 +177,7 @@ static void pca955x_update_pin_input(PCA955xState *s)
>                */
>               if (s->regs[config_reg] & bit_mask) {
>                   /* Input mode - reflect external state */
> -                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
>                       s->regs[input_reg] &= ~bit_mask;
>                   } else {
>                       s->regs[input_reg] |= bit_mask;
> @@ -361,7 +361,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
>       int led, rc, reg;
> -    uint8_t state;
> +    Pca9552LedState state;
>   
>       rc = sscanf(name, "led%2d", &led);
>       if (rc != 1) {
> @@ -379,7 +379,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>        */
>       reg = PCA9552_LS0 + led / 4;
>       state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
> -    visit_type_str(v, name, (char **)&led_state[state], errp);
> +    visit_type_Pca9552LedState(v, name, &state, errp);
>   }
>   
>   /*
> @@ -398,10 +398,9 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
>       int led, rc, reg, val;
> -    uint8_t state;
> -    g_autofree char *state_str = NULL;
> +    Pca9552LedState state;
>   
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
>           return;
>       }
>       rc = sscanf(name, "led%2d", &led);
> @@ -414,16 +413,6 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
> -        if (!strcmp(state_str, led_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(led_state)) {
> -        error_setg(errp, "%s invalid led state %s", __func__, state_str);
> -        return;
> -    }
> -
>       reg = PCA9552_LS0 + led / 4;
>       val = pca955x_read(s, reg);
>       val = pca955x_ledsel(val, led % 4, state);
> @@ -438,7 +427,8 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
>       int pin, rc;
> -    uint8_t input_reg, state;
> +    uint8_t input_reg;
> +    GpioPinState state;
>   
>       rc = sscanf(name, "pin%2d", &pin);
>       if (rc != 1) {
> @@ -456,7 +446,7 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>        */
>       input_reg = PCA9535_INPUT0 + (pin / 8);
>       state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
> -    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +    visit_type_GpioPinState(v, name, &state, errp);
>   }
>   
>   static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
> @@ -465,10 +455,10 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
>       int pin, rc;
> -    uint8_t state, config_reg;
> -    g_autofree char *state_str = NULL;
> +    GpioPinState state;
> +    uint8_t config_reg;
>   
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_GpioPinState(v, name, &state, errp)) {
>           return;
>       }
>       rc = sscanf(name, "pin%2d", &pin);
> @@ -481,16 +471,6 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> -        if (!strcmp(state_str, pin_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(pin_state)) {
> -        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> -        return;
> -    }
> -
>       /* Only input-configured pins can be driven by an external device. */
>       config_reg = PCA9535_CONFIG0 + (pin / 8);
>       if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
> @@ -500,7 +480,7 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
> +    pca955x_set_ext_state(s, pin, state != GPIO_PIN_STATE_LOW);
>   }
>   
>   static const VMStateDescription pca9552_vmstate = {
> @@ -530,7 +510,7 @@ static void pca9552_reset_hold(Object *obj, ResetType type)
>       s->regs[PCA9552_LS2] = 0x55;
>       s->regs[PCA9552_LS3] = 0x55;
>   
> -    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    memset(s->ext_state, GPIO_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
>       pca955x_update_pin_input(s);
>   
>       s->pointer = 0xFF;
> @@ -550,7 +530,7 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>       s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
>       s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
>   
> -    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    memset(s->ext_state, GPIO_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
>       pca955x_update_pin_input(s);
>   
>       s->pointer = 0xFF;
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index ed304e4639..7bbfd5ed5f 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -18,6 +18,7 @@
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-visit-machine.h"
>   #include "qapi/visitor.h"
>   #include "trace.h"
>   #include "qom/object.h"
> @@ -51,10 +52,8 @@ struct PCA9554Class {
>       uint8_t pin_count;
>   };
>   
> -#define PCA9554_PIN_LOW  0x0
> -#define PCA9554_PIN_HIZ  0x1
> -
> -static const char *pin_state[] = {"low", "high"};
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_LOW != 0x0);
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_HIGH != 0x1);
>   
>   static void pca9554_update_pin_input(PCA9554State *s)
>   {
> @@ -73,7 +72,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
>                * Input: the pin is Hi-Z with a pull-up, so it reads high
>                * unless an external device drives it low.
>                */
> -            if (s->ext_state[i] == PCA9554_PIN_LOW) {
> +            if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
>                   s->regs[PCA9554_INPUT] &= ~bit_mask;
>               } else {
>                   s->regs[PCA9554_INPUT] |= bit_mask;
> @@ -175,7 +174,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>   {
>       PCA9554State *s = PCA9554_BASE(obj);
>       int pin, rc;
> -    uint8_t state;
> +    GpioPinState state;
>   
>       rc = sscanf(name, "pin%2d", &pin);
>       if (rc != 1) {
> @@ -194,7 +193,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>        * holds the wire level regardless of the configured direction.
>        */
>       state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
> -    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +    visit_type_GpioPinState(v, name, &state, errp);
>   }
>   
>   static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
> @@ -202,10 +201,10 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>   {
>       PCA9554State *s = PCA9554_BASE(obj);
>       int pin, rc, val;
> -    uint8_t state, mask;
> -    g_autofree char *state_str = NULL;
> +    uint8_t mask;
> +    GpioPinState state;
>   
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_GpioPinState(v, name, &state, errp)) {
>           return;
>       }
>       rc = sscanf(name, "pin%2d", &pin);
> @@ -218,16 +217,6 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> -        if (!strcmp(state_str, pin_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(pin_state)) {
> -        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> -        return;
> -    }
> -
>       if (s->hw_dir) {
>           /* Warn and ignore if the guest has configured this pin as output */
>           if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
> @@ -238,13 +227,13 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>               return;
>           }
>           /* Drive the external input level */
> -        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
> +        pca9554_set_ext_state(s, pin, state != GPIO_PIN_STATE_LOW);
>       } else {
>           /* Legacy behavior: force output mode and drive */
>           /* First, modify the output register bit */
>           val = pca9554_read(s, PCA9554_OUTPUT);
>           mask = 0x1 << pin;
> -        if (state == PCA9554_PIN_LOW) {
> +        if (state == GPIO_PIN_STATE_LOW) {
>               val &= ~(mask);
>           } else {
>               val |= mask;
> @@ -283,7 +272,7 @@ static void pca9554_reset(DeviceState *dev)
>       s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
>       s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
>   
> -    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
> +    memset(s->ext_state, GPIO_PIN_STATE_HIGH, pc->pin_count);
>       pca9554_update_pin_input(s);
>   
>       s->pointer = 0x0;

I'm less confident with the QAPI side with all the recent changes to 
give an R-B, however it seems sensible to me. Perhaps an Acked-by if you 
feel you need it? Otherwise LGTM.


ATB,

Mark.



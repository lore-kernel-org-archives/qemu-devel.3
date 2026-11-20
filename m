Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F4606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=1P5i+FxJ;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=xmOvdHaX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUKns-0001fQ-BS; Fri, 20 Nov 2026 04:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xUKnq-0001f4-B5
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:21:06 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xUKno-0002rG-7u
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:21:06 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7fqmb1177149; Fri, 20 Nov 2026 01:20:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=E6z3wKu+Ix/gCFKZtKIezGs4SI4ND4hsKtPUd3QKL
 S4=; b=1P5i+FxJz7rLJvHUc8+Nic5hieNVXOzp35+QJtX9OCIKHt7X7CYOut7iQ
 SR5RHGwWoPha21BdZxKMFNA0StNTmdesq2zcrGMPytmvHbdbaBFT189ofF5FN058
 Zg/uK6Dli93cLDXC9r2ZB53jxLcgqUKtAX60VfTD/fBEyIUaJPVGxrL9ltvGtsuy
 /iRmFDX3iGzEwmye30YyMeLz3U0Ije+msZXK5t0WpiHRVUhaq4etKVE/Bz0HdgOB
 LgFyZYsSL0eFG+Ai4XS1oTQRFRayU4y6sEiAjhyGWkOEIMvN4lco59FjpGYVHQAc
 yIlv5maJNDY/nWpV8rEaGoDvTQIOQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021134.outbound.protection.outlook.com [40.107.208.134])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4j2498j544-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 01:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebXZhdpII7UEoHZ5cgsYcH7hWE/WR2YmUeEFnDuj/fEliO/2R58zLyf6ZSQd+UJzEds+IfU+WiMYOB8Md2cjFAaLAWP6pkVJrT7TKOhf8o8cSBLtEKODcqhc7LLpW8pjuRrgQb715yhiAEpE0KfnMhTs/pWFrQqRzgOe1F1Z46Cjnnb1DdV9nvvjtdid9o5KN1Li2UOi6QcElnEZOityYiOnlrgJGN7jffOO2hJuEKEl5Kx5iZC2uPz89eG/xcNYuS5K/pNjmE8UWFA/ga6FrUyOGt9j30EXr0e2Be9PvQMYFCoNPhBB0JHybjoTFqG3QNK6jeOzTnWUVi7qnSfqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6z3wKu+Ix/gCFKZtKIezGs4SI4ND4hsKtPUd3QKLS4=;
 b=cMjc10LtZXUnCzvPfdFppCYWD1vBE6a5kmCbL733Dd9C1giA5eW+mn5kqZkg+6q9wVspOuCV66FNDdVxEscjuvWRPCjN+AriWoRTZ+nAT6AQVIF3butvDbfYJcce3g9MihRpRSaXYcosdYK+SiahQW+HxDWpQl0yVOr3/9CqMCQ3OsFRXvudOgLmkKg7PI4DJ8Cj2ZdH4OM4fQWAB+wqFNkvZhYIx/ib/lMVy4jf5MhJ4RNop+qpXuA2xAqoes3Ht7hznxuvbVv7+ZXaWOc2CfapWyzjwfT2cyRoe+VFIzzQEyTGOFliKHYRHsSP/qEk21F3mS+rUgUa+BQqqbM3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6z3wKu+Ix/gCFKZtKIezGs4SI4ND4hsKtPUd3QKLS4=;
 b=xmOvdHaX5ZQRc8r00UwVQk5D1gtYVubmCAVVRTyKIVsbedaYGbWK0JEzJQPCsHmjFViXeDHKRGq4+0B2CwYW3749+xDa4ycd0DpYVctzqWktJul0+U9J+cvN7sCye9GVhswbyKqV9UL8sQisVKNkGGJf8kBfu/Sy2ChnArwoi22nggGSy0fQnfc9XHbtoMYPP4K6XBy2hvqKuiUXW/soMxhA/lNRhs8B7YyOCtTDB6hdG3oEpWuPLA1RVf0w8bD5D339Pi+k4C3wzAAMLTqIYuTa5tbX/V3HeOGLLZP0+XwmI6nfJi0zwea9WYXNLe1kvWlIhUx09AEjsHhYf86lgw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB11313.namprd02.prod.outlook.com (2603:10b6:806:4a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 09:20:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 09:20:55 +0000
Message-ID: <09c45745-553b-4acf-bb76-6b36df221764@nutanix.com>
Date: Fri, 20 Nov 2026 09:20:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: rust build dependency ?
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <f1471b2e-fcff-40a5-9bf8-077d3294cf6e@gmx.de>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <f1471b2e-fcff-40a5-9bf8-077d3294cf6e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB11313:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ddb35d-f1c5-44b7-e310-08df46e7948b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261021123027099003|56012099006|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|22082099003|18002099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: fmJey0lvRkJdXyMwMGsXWuKFoCj8vdfsoYk9U+LMRtAA32iFhWfYeKvRqXxBoyhxxTwlTEioo25PhI65I3x1YuS2kQncaMYohcX8xWAxdMopkeDh+vMGVGkTNPggA3sm+FT+zcsnS/YFnLhEUSnc1O5Dj10tkBTR7IKxh1cruy1LDDlmVP7t3aOuswtpse4OkYGpI5X/ssKUyb1q+O0W2OxMfIvAXtYuSOv9Abh1yU1dBIOGcu+QYK6ezdskpHlBz43EVnd9LLR/PMEOQgod3DO3KbVMVwaHxVLvlNSeUzNkt1XCrxUCd4vSGdJxHFgY7bT0koVnoytKVb2c/tOkN6odwawCFrtVTpPhyEsGcnhHGGCqhoxsGMnbs6glO0+PB4n/1duLlV+XIzjAn7l2kBX6pLpe3ewBT8gUr3OhagRjvfaZLMhTbc5tPG32M6R9XvUSzzuXVsafZ+KjOJhZAZ3wCIep9Gh7x9qgAcBXHiheBMYFNt6FkU4Kze4wwb54YuyvvpCEPAvodFy5I+LKpiIvgW2ofMSkea0T/G7SmFF+5rNTH1JRdkn912KgnkqNkJCrRkNQSKWF0W4NHDf0ZrW+rvoXKrkdKdwCKUcXXbNhYcWk9HD6PnXiyLlLoLw5qbI/MbMsewtYGdbx+8ljBXN65Ros12isbutxTedOXFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261021123027099003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(261009221227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXM3c0loQ2I5SU1WR3c1bkljN0tBd0I0UkVSTFc4WWlOcStkTVB1bTJ5TnVu?=
 =?utf-8?B?VTVicDJJNkdYUlEzSzVaZDBPRytIck5NbXlPZ25MaWJiME90NS9MYkR0YUl4?=
 =?utf-8?B?MUx1N2cxT2dFQjdyT0lqOXhRK25oWlppQWg2a3ZNTzIvYzZhdm5BT0drb0l0?=
 =?utf-8?B?V01GdmlwNFpEOHVNc0FEeEt6Q2lHSU1IMm02djg0WnZDMGVyM2h3TURQbVZN?=
 =?utf-8?B?M2pBelNsNThTMWxGS05OOG5wdjBvL2Fzb2w1cHNXM2Fzd0s2Q20vS3kyQWpw?=
 =?utf-8?B?aHJ4SFVHM1B4U1lweWRrbkNiSHYrL2hlM1JhME1tOVQwSGtzTmFmdFpJbkNY?=
 =?utf-8?B?Qk1UWjRnQmJINkhYV2NjVjZoTG4vb2F6TVd6SlNIbm9CeHV3MStBdlAyOHc4?=
 =?utf-8?B?cHR6dDFzM3J4dW5RblpuV05mQmRLMVdQRTVha2lqSm5GQXd6dmE0SWNjZ3NZ?=
 =?utf-8?B?a1dTTHBST3FDTHZ5d0E2aVllbzFsMGZZOTJtQ2hPMkV5c3Vlc1hoSUdoWW5l?=
 =?utf-8?B?MHR6b2ZsV2JCNTdVb0tLbXJhTTdqZzF4OFB4K2d1M3phZkh6RjM4VUtnTUEr?=
 =?utf-8?B?Qk1pYUtIWUpjbVZtWnZWSmYyR0ZLSWFUQTJQdVpjMzdpbVY2LzVkMmp0MnYv?=
 =?utf-8?B?aGFkaU5OeXRDMGY4cDhUQnVHUWY1U2ZiUHV4U0FzOWh6T0dUZHBZcHhiQXg3?=
 =?utf-8?B?VGpQOU5nV0RBT0UvOU04SFhwbFFhNUh3VDl6VVZ5M2RBSThiTHo1K2dEdlo2?=
 =?utf-8?B?bERKT1RqNk9CNXdiMzhDVWdPTVRjY0RleU15bXF2cFdhaUJOWGVGS240WCtZ?=
 =?utf-8?B?S3R1TExVbHVJaEZDTUVSa3dnaHdGUVNPQWMxZC8zNzVqSEVNcWRhNXBhYTJX?=
 =?utf-8?B?ZnpGSWNFRmVTTHhmUWo3ci9HZE42SDVUa2RFbWFoV1J4bmQ0dlVHekZaSjBy?=
 =?utf-8?B?ZUtlNVhIMThPcW50ZENQRlVxQjBYcXA5dXZYeWVCYXF0KzQvbmZIL0l2dFBW?=
 =?utf-8?B?SHF6cTF6bTZFMXdFb3NtV0NQanRSdk5qdkxBMFI1cXlBRFEvVGg0UGxsZmgw?=
 =?utf-8?B?TEZNZjk1VWhEelNoc0taczQ2akhJQ0hienRwY29BRE1RNXhRVVIxbTVFUDU4?=
 =?utf-8?B?dW9LbUZMbkh5WEZRSTI4cW0vay9RaHpFNndTN3NFcmJKQkJiK0MzOG9OSE5L?=
 =?utf-8?B?QUZXWTBnZ1pNQ05SQUVQY3BWcW43NUJzdVFwdHpveTd4Q2xJWE5zZkc1M2R1?=
 =?utf-8?B?SkFxMnNDay9UenFnb3dWKzFIQUdva1I5cm5TMytpS0ttMXlZTVlrbzdRcFZC?=
 =?utf-8?B?QjZzVE5FQnFLR2tJS210ZlE3amFqM1FXYkNQT3hnTlkxVkxKTXhBeVFBQm5K?=
 =?utf-8?B?YTY4YVkvb2hWV1NQbXpBb01XNUJ4MHkvWi9YazlMY2JFczFLQUZJYWJ0Q0lV?=
 =?utf-8?B?NHFZaVdpMHBDa3Vvbzl6WG80d05WL083ZzhMdGIyenRGZnZYbVZ3aElyTE8r?=
 =?utf-8?B?clBHQjBJYitjcGRuaFkxRnpINGVTR1RXbHJKWXJPZW5vT3d6eEhUekMxVEZI?=
 =?utf-8?B?MEJWVTM2UDlBKzVTbFBWcUk4cHJEbHpRdDRhOVZHWEhhY1o2Wnc4aE9CVzNL?=
 =?utf-8?B?T3I0TmQ2ZVhtbVhpMy9QS3I3Q0t3dDRKMnQzdHhkdE1wOGhQSmd1bWdwTk5r?=
 =?utf-8?B?QU41QWFnK3pWcHF1NzBHWmV5cDNHUVcrVFVmVFZaRjZDWUdIdGFuaDBTUnhD?=
 =?utf-8?B?cWRWR2xQQkpkZ1l3a3dQYXZPTktMQm9Od01aK0Ezb0JFS3FmRXFadHFYbG5q?=
 =?utf-8?B?MnhpQThDWUJsK29rNzBuY1hJd1Nza3JLeUVEMk53SU9UZGtCTG9pNXBwWjNP?=
 =?utf-8?B?M2RVd3JZd2JRbUlZVS91NVhXZjRSZFE0ZVNuSDE0azZvZDJtSTZqdmhPVVJZ?=
 =?utf-8?B?d2l6bDhwYTBVNkhhZHN3UXB0UExycjV2a1QxWmw4NDlrRElZb2pIdm5vcDJ6?=
 =?utf-8?B?L3NsWForM0J2eTNuSWRMUFBhY0FvSFMyK25TQWFTV2ZrSDhMVkN1Yzl1MitQ?=
 =?utf-8?B?NUpRZU5JT1U1eTZEUGt5M2JLRUx0SEFPUGs4Y2trYVFHTURUbHN2aFhzZ1hz?=
 =?utf-8?B?YWxQS1Z5V2xHaUtwYTVqMVIzdXpObWkzblRqdmtidjlQUXllNVpDLzdHbisy?=
 =?utf-8?B?QmxaMEh5SXVWYkVuR08rUVVWZU5pZ28yN1U2MjJCN3NzeGozZGdidVp5eUwz?=
 =?utf-8?B?SENCSk9mNEdRdUNzdWZTRzUydi9HRGRuRHRlSlBwRFZSUXVkRjg2N2lvUDdq?=
 =?utf-8?B?eHpVNk1GMnQ3cFBiMFFUVml6ZHVyZUUrMy9GQlVKSHJmejk0S2Z4Qnd2RlhV?=
 =?utf-8?Q?FIwSOhTlil88fYzs=3D?=
X-Exchange-RoutingPolicyChecked: GIlYsv0RCUSzjeGeg+57JLyOGnQH0JKQRslhOQjdYfsymIL/HpILIWxaMR1K7UXU8qm3OeHw76R2I7aiH+lh+bMk72D3C2EnR7tOLgshh71vbkaHlJ4yVhSmWJvq81X/q1jD5p0w5XgWS2qgRvgV7Mcwx4DMHa1duXZaBvhCifYe4RVLjgeppg8ksYEBUpu7+nWZqZtYsuALlHk7JRIq6VjW1QbhbHoZ7dBMDU4In/WKDtvOGYPhoJROCuSBAzatTPLkCWEGyz3cmRn/RdvP/QS5j6YHk4ecOL3n3nWkcIcSZKuvZiuHBNGlwkC9MN+nm5YJfXbeIY5aUZY70ctulA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ddb35d-f1c5-44b7-e310-08df46e7948b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:20:55.6819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xM7ymJU4P5zAI2wUCs3bS/CPOJGldW/8UtPA3YDOM3Hv5XXKqWMr8x+fqZUQCu4rxmgHAn88G4UZP2QXiN4/Z9G0XllOlLE1k9pHl4FbAFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11313
X-Proofpoint-GUID: fGJJUvoABKdHYslTn6cZa1wlthuHzXdY
X-Authority-Analysis: v=2.4 cv=DfOCOftW c=1 sm=1 tr=0 ts=6b0010f9 cx=c_pps
 a=FeeVHR8rqpo+Pf7fuAv9nw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=uqbHkgWhc80IMMAsui4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX3tND9osZSNCP
 CKZ0NwlbFkndLvMjIxkNuXIckx0OUvMrh4SKMZbC/oZ8ZqMuLB71CPtJugv6EO7So8WgOMJwknY
 jmc6YfWUT1X8rJsPLeChxrGKRNzmULbseN+S0fdJ1nZPPivSh6rRDLwDaF51aUFd8VvwqxZoEOM
 YFve5tVkXEJNxU2SkfW2zJooiYwDIimETzIwwIyzOH6kNmh8kHiE6Han8LeU8HXgqzY2Jl7uSPv
 X7BSHrpjIlZQfu2wVgupzKcbPm2Ah9a7I4BMxLu3y/gzl3u8NH4GUKhvKyvoGoszm+AqasxSL//
 aA0Y6853mTnw7IY/+CTj7D+3fGE+mlLqFT6+W/WWMETKARFyxLTz2p2n50rGDqr6aRJeKFnAH3r
 KN8xpavnAT48DrLrriuGNatQ5z+3oKUO2wA38XOX//GTNmRKuHalemC9oknuqKii/Na2UqYZ2bU
 H7dDK0FgHUUy/lcxZ9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX6rAFtpFR4L4/
 iFrYjq7C+xU9rDnW5ggtjX8kUJ8R0HRzpr0PInPYjRq7ytw1KQl42VnEXyDAKOfgDiQvPZ2AGnv
 uoVSLokFjVcS+xY4ZQ3JngvHoZTdD9E=
X-Proofpoint-ORIG-GUID: fGJJUvoABKdHYslTn6cZa1wlthuHzXdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/11/2026 22:25, Helge Deller wrote:

> With git head, I'm suddenly facing a dependency on rust, which wasn't 
> the case before.
> Am I doing something wrong, or was it somehow just added? I'm on Fedora 42.
> 
> deller@p100:/home/cvs/qemu/qemu-build$ make
> /home/cvs/qemu/qemu-build/pyvenv/bin/meson introspect --buildoptions / 
> home/cvs/qemu/qemu/meson.build | /home/cvs/qemu/qemu-build/pyvenv/bin/ 
> python3 -B \
>    scripts/meson-buildoptions.py > /home/cvs/qemu/qemu/scripts/meson- 
> buildoptions.sh.tmp && mv /home/cvs/qemu/qemu/scripts/meson- 
> buildoptions.sh.tmp /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh
> Failure in scripts/meson-buildoptions.py parsing stdin as json
> 
> ../qemu/meson.build:96:12: ERROR: Unknown compiler(s): [['rustc']]
> The following exception(s) were encountered:
> Running `rustc --version` gave "[Errno 2] No such file or directory: 
> 'rustc'"
> 
> make: *** [Makefile:134: /home/cvs/qemu/qemu/scripts/meson- 
> buildoptions.sh] Error 1

I had exactly this yesterday, even after destroying my build directory 
and re-running configure/make.

In the end to try and diagnose the issue I checked out a much older 
version of QEMU, attempted configure/make which worked but then aborted 
the build. I then checked master back out and it started working again...


ATB,

Mark.



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC48606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=yRmzkKlt;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=GGS9dzvQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULos-0000iX-TP; Fri, 20 Nov 2026 05:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xULon-0000ha-BF
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:26:09 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xULol-0000Y5-AI
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:26:09 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7g6b01177472; Fri, 20 Nov 2026 02:26:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ySGRahwBh8tNNwU/6eVKBe9S0+cSkCC4PtGhfxSh6
 HM=; b=yRmzkKltq2KzKXZF8e8+8twwCZZbeIWTKK2Ph8SKOqsGPg6n+SV0lJpdj
 UbNCjiLjCXuwmevBBWRxjAtx9cvALz36ewsEk4dNXpMKIdKf8Gelb9tNUJR0BAje
 JDZEzGHm25VFFtGDBlUwHWv2I8/Xa96QvK7B8JT6OKYJvGxXxkBKUnW2RkKupGgw
 gYKIAX0QnNiDOAegcEHGTjZWqS2yrOvv4woa2FbjpiJ9bzxJUyXw39VdSPXU4JHV
 1p4/ogpYTcK1p+Ke97pzUkUB069h13ATsUqUoxmQ+zsWQbYDWhXWz5cAtV4AZlRX
 xwFZTrieaO0Tp/CoyCIwjujrtMETg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022143.outbound.protection.outlook.com [52.101.53.143])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4j2498j9c6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 02:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J615K0dhHxATAikgVv3AMCzNpctLmrraMy0LTR5N8XZDbob4g8U1ZBVG5zNNHMjsi8K7NbDWxL5DT6JWV37mFu+IyLbnm/aTSKh/rKgtcmoub7COxuFnSw8X5qDnjLNdM0BMBZFco9P734C2HGQVdrFOrmpEEKP46T5VxPqz5g3nzLDvcYkim/rFlgRiz3JJZ5A36w5JzaFWEm0iYTumkdqDAorlWjRNuDGGkkfRZVm+KcYgdr5hb5VJtU86h3ZjrOvlv+0ZLaR1n1JbU6SOgB7S09pu5W4BkUlvbyi1hCo7k8vmLH+kKUsar0uv1dpCruZILeWB0geknj5rERw8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySGRahwBh8tNNwU/6eVKBe9S0+cSkCC4PtGhfxSh6HM=;
 b=Qg0pXucpr2ivyE4XPXAoHEKTSFhdwguwTBXq0OYAfLSE00abYyFiiHtQfqLQSkpxvKT0n3z/8XlL5PIPEj30TVWlJvQeOCivK9/Pq3Kxu5TPX7nkntvl/rRTBXpqZjKBmqcjhTShsMy+g6d6bgJHCvW1S0dsZPAwPsKizMHEjwbAYWP6nVCI1aGVj9jJoXQNyS+jyTY2aZ1/5v7Ugfzu7fvhQK0pWP17mmmvcnxb7Ic5AN8gFa536wKHUHR7Mh56Z0PdTZKpNwrAeGuvrmZIC8kFrllup/nsSE41QScca1AnZrWxnDnWzWzKcMe9tkNnOSHTdxjsTk65n3bLX9bwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySGRahwBh8tNNwU/6eVKBe9S0+cSkCC4PtGhfxSh6HM=;
 b=GGS9dzvQHGDAQ1K2OQPCX+FfE/xBPZ4Vzo1c2C8PluGNw1oF2bc8i1ByfMbb+WI77SNXksHanVUU+UDBrQSSkKoHHmOeK4c1shAL5BwWXzaayl9Ds9CJMkQJX2b1MUtZS/K+cYULD3M/C0IBPDGZPKVxwl50wrLppz17WqabOIaStRJYstG3x85yStKIWhkF9WD1TI8qMVpVCBtk2bJ27IReG5kxrQJ/+7oJFiyWiNcGk3a0N/Aith7tbNXSN3PtllrVNNxSmkeycbLDr4H9f2j/c8K/cmVMn3q4P8bxF2OL5Yc0foQ4pvPH7ia4SBlZR5QwAZoHUQWUZ8HIyGCGBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CC6PR02MB501100.namprd02.prod.outlook.com (2603:10b6:170:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 10:25:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 10:25:58 +0000
Message-ID: <6431a291-a22e-45a4-b707-ba1daf6c0eb0@nutanix.com>
Date: Fri, 20 Nov 2026 10:25:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: rust build dependency ?
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <f1471b2e-fcff-40a5-9bf8-077d3294cf6e@gmx.de>
 <09c45745-553b-4acf-bb76-6b36df221764@nutanix.com>
Content-Language: en-US
Cc: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <09c45745-553b-4acf-bb76-6b36df221764@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CC6PR02MB501100:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ef8950-b543-416a-0787-08df46f0aaa4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|261009221227099003|261009223027099003|56012099006|261026140227099003|261022075727099003|261028144727099003|261022105027099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CxlHwOdJZpIdTlWEIjB5hQ/SWeBTpAKI/QMmncNRhq37vbrsM6235ezOLkPYbnvAYAC0VA6jxaUaYqtnNIsTykX7h/kO2CYJRWRMCZnEzhlot1kT/yLnyz6UAlFc4uJibzqQ9U0mfXIlxqUPO2vM2KU7y/IpoPq/l8XT9HD4QznmizxQqd/A+dpZXEgoPFwI0J3DWPl1t82BkCq9bzFTdWK7dMoFNFq1o4ha27+BsYHKG29MYSd4t8HmY/fXcrU8z5h8DhIPGauO2iIUWfEpdTWl5nWxmh1KoUI0iPewdHj3uZRdEJJGMuJQ/n0ue2Ihk+gbukSGLtdjnFye/qbaEuJUi5qN2kpUXOfEMeGJu08/lDL20M1rKLd6xKfY+pIGci9MXTjGWIp1rJG8CSwMQRQyA1CuEeFzMVau5ihQrvKeHpnEv040Echk2ktJzt/xM68v9aVOoZcEIAnDbJ+NiejRZ+K0iA5W6URekZ8ZNvZ3ywnj5N8GVJNq9lB7uc3nuHbOvkTgQu7NaUjJ141vitYFzVXYEj/6WHHADCM23SBGe6ggu13ISc41gAHmOFovN1rPtqXP77C64cR0VK2g0OxuklYMX/QMpJ5Rknpq6Z/xkIpr1LmgBc9rEGuUHbpag8fxrcWSMHs9oCwi6FK6w5rmNRRRGyhyJ7QCYJnv1K0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(261009221227099003)(261009223027099003)(56012099006)(261026140227099003)(261022075727099003)(261028144727099003)(261022105027099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1c5SGljZDRTdWpXZUt1alVLQzcwVFlnelRUR3BGWU1wVU9rYktmRWtiUGFF?=
 =?utf-8?B?Sit1NWhoK1drR003dWd1M0Eva1E3TWFkRUt5cS9lczJZRzVzRkZITE1UMGdF?=
 =?utf-8?B?UmVzMGRYUjRrc01QN0Z4alFhTG9IWXZJaHlIK2hoQWFlUUd4bDJra2FMU3VR?=
 =?utf-8?B?UXVCaWFLR3E2ZzBNTCt6cFR5TGlGOFlkTmVzSUVDM2xzdUw2Y21WempCalFT?=
 =?utf-8?B?ektFeUJTcFVmWHFRRUNKZG53aXlkS1BWUVNrL0ZGRUlFdDBFL1VET1IwT1dD?=
 =?utf-8?B?RkdiNUxieW9DNEJ1eFNxNThDc3dyRktvVy80ZUZCcEtxTzFBOE5tRm14TS85?=
 =?utf-8?B?dW1xNzlQY041YlhWMDEyNWhRVmwyMG4xZmgyN2NKTlpnbmFGY3JEUDhzSkFL?=
 =?utf-8?B?YTllWFdteU5KZmltQW83R3VSRlNwa1hUUXM5bUhIR1RFalV0MnBuOVgvaG5S?=
 =?utf-8?B?MjFIZTZzVzZuV1M4STJDWHRnRHlaZnc0cmNoV2o1L0tlWkFlallGQmtsL1py?=
 =?utf-8?B?RVFNcFd4MzgwR1NvMS83NjhDampMVDlLNm96WTViaHFweGN5cGg1d1NPbnI4?=
 =?utf-8?B?T0xzQnY4MVo1aENnR01JQWhTb1pUY3BpV2NQbHBEN2xKV2sra3lsQTUyTENH?=
 =?utf-8?B?ZGE2TmVBN0lkRGVUeFEzYklRbksvYUFhUFR4QTZCdjN3N052Wi9ZRkNKL2JP?=
 =?utf-8?B?R0NEQmpENVpBR25XRWVJZ1EwRkdjbzRmZ1Q4a3A5NlN5ZU92c0p2MWU0aExM?=
 =?utf-8?B?RStGd3ZNS0pQb1ZVdnprK0pkZ2swMEs4WWwxNzBYMll1UnNIMTM2di8wM1JD?=
 =?utf-8?B?U094bWw0Z0xsQUZDQytHVVNZRjZEWS85aFdxdWZBUHN3R0U2dVV6TG95aVVy?=
 =?utf-8?B?azZXNEJaV2xNSEpzUExDczFNWlRteUNDWlk4eFRwSkRUa1huSkVlb0FjczJP?=
 =?utf-8?B?NUJORFg5UWJPKzROaFBEQnVqeDV0Y3BTZHFpQytTa1EzV21BcmN4OERYaXdp?=
 =?utf-8?B?bDg2MHcwTVZtRk45YW1VUWN0MS9IU2pLV081T2JpSGNuRVB6UStmRDUyUGVH?=
 =?utf-8?B?djRVV2lIZUZsTU5FMitIYlhNb0lvNytIVDVjMHNhRE5wcWl0QVV2cE9hSkl6?=
 =?utf-8?B?clRxWi81RWdodFdIYnIyMXFGR3RrZkJrMFNNRk90anllUjF5NW1MaWZXOFBl?=
 =?utf-8?B?SkVnYzQ3USsrNnBSS0l0Uk5EZmVUT2VUT2J2VTNqd1lLV3REQTlzV0xqSFcx?=
 =?utf-8?B?QkJBcStyNDAzTWo5Y0ZJdHdUMXZyK2NhckNNN1dueWd4ZHV1dGVncmt6cEVB?=
 =?utf-8?B?NWNmSzg5NWxVRUlJZTQyMjkxZUd3VE83UTdGSHRicTVsSlZPeG5LMmdZSVpD?=
 =?utf-8?B?ZlllNURvZ3NtcUt3NVNVOWIyTUdOaW9EZVNEZmVhQnNoajUrUHRJNVlnRFpw?=
 =?utf-8?B?QlZPbmZ4eVlQS0tiN0pwb3NnTDNzS1hHTDZNTURuRmFuLzVRUDRKdk0yY3ZX?=
 =?utf-8?B?U21NT1BZTVBuSmZka2U3RHpvOEpIV0VnNkdRMmNLdUxQSHhLVGlmd2FGQ2s5?=
 =?utf-8?B?TGE2eVcybEVZTVdQTlkrQ2dZdmNHUzJwckxLVWVMbUQ3M1JxNnJnSzNVVHB6?=
 =?utf-8?B?VDUvWjJSSmdOWUFNNEJKcE9uTmI5Mi9WT1NmTTRBdlNwYXVTNmJVWjJ6bTVG?=
 =?utf-8?B?c1Fsa25ycTJsUEF4TGhPV0k4Vm1kS0tXVGxrck4xdjZkS3RhOHlMUndhVlBj?=
 =?utf-8?B?aEEzRXhDZ1R0UVZ4bCtqekJjck1YUlBaTm93MHRMM0tlOUhvVUFFckFoek1H?=
 =?utf-8?B?ODJUT3YrcWNESGM0d3RLalBnVnIydHgxVm03cUpLQVhiVDJTUXEvMER5K2p6?=
 =?utf-8?B?UCt1bkU4ZllueDlMcE5IRDNRL2lkSkdKb0ZZVVRyVkJlSWxqejVGTmdXd1dk?=
 =?utf-8?B?N2NqclhIVUtnZCtMdDdQNDIxaFdjRnh0OHRxdEJ2YWxmVzhrYWlrQmRhajFp?=
 =?utf-8?B?NCtBbXRWNDM1b3Y5RjVOeEkxR1JZb0owRDJRV3p1RXdzNWJmT29xMTV1Ukwr?=
 =?utf-8?B?VWpLQWlZc0I5ek9iaWR5UUFsekZSYmlqSldsWlFVS3hUT29DYWl2QUV4VHVo?=
 =?utf-8?B?NElGOHlFRm5zNWRlMENaNHJrSUprUnJGQ0xBYkc4U2J5azd3bnhYVU9Ha0Jh?=
 =?utf-8?B?QnlFUzZUenVJZXMyOHFsZm9KT2pCVUVNWEN6VktGU3RoY2dnRE80dS8rSk5l?=
 =?utf-8?B?bXYxZWcwNXJJbWdQbG1HM0ZuODZvUUdLU3NLM2dkdkVKdEgwQVNJL25WUk9M?=
 =?utf-8?B?U2Q4c3UrSGdKckg1UnRmdER3R0xEUWduZnFPZTB0UnAyaWxoRExXVWErM3Jw?=
 =?utf-8?Q?prXPXs3qDuAerJH4=3D?=
X-Exchange-RoutingPolicyChecked: UHfYr/v06CcA15LHKZuTNFAjixv4EfjQ+Zw+dUTDiS/ucTeTnB36Su+egey7TgRiuq4wwBTwslorOXNTigH+CJuTNFfnRxKxHkMTlhzsLwYUTgMln1B/VADpfrSplkJlAW8h9DweLK9BPklMgA9gTwOTTNgZfGKFIKrHrFseoPAZuTFHjHpZVvHXQlBYrgjhN1xLQrNpCuMRgTKsc5nmIkKK/q9L3Ule8xxa9MNrGBfXnc2oD4OLfA7Z+TSBpgwWYZ+SqazllpvzG84lmZENgjWxliylxp/lWPVaWIcEQk9kIOsRqrpk0ldoEo04a5lbVE4joB4KLW7zHpszlTewwA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ef8950-b543-416a-0787-08df46f0aaa4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:25:58.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsP0gSYxGUPfxyIG41iRveDLhoo5QOjl4PRKColrULi3beWZZVB34SjRm8abY6IyYh7xcv2mCLN8dQKaGUq7A40UuKew0UM/l+lvpcmyVr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR02MB501100
X-Proofpoint-GUID: w_HFh_dq2Y8xcRZaroKSOjkytB3ckW8F
X-Authority-Analysis: v=2.4 cv=DfOCOftW c=1 sm=1 tr=0 ts=6b002039 cx=c_pps
 a=taCrSF+MhsyXuYDq+ZG44w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=TUyoIWao4XuEdTyYnvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX9SRvA5RwxXDf
 9wMZIYTJK5CRfFHxL0qe4kN7x7vg1ZYldd9KjOB3bxatQJ2rdsgrJNI6EXq5wLmZMjTQafBG3j1
 kDZ0WxkfSds5qNRZEa/71P/vcRQHZMOl8fPELOxa0lck8iwa/wWBJGFH8eH8D5DxsbzTFlr4vmm
 x+oyMK+Tc7vPnADv/18tllSDzt1rLvrepTfbresV1uua4bmAU0mEBjnBXa/Ryq6tQyeQ5U1ST+q
 OjRRoWFudWjaplbpUB+JuDrudoIkrXlwfTOI9x+a3PqL6zn2voCblodMIIKNss7Ln5ui1nYHQ50
 +gqhOkevil8mKynGO87A0dELpxL5wkqEcHu10Is48CClxL5RaKN81/g4xVYmh8poQ0CQTzEpeVg
 OjDYgTzjfddL7/vA5XgaNAwEZ7tVh5tU33vlZiYFnAwlLTSF/IS82l2itDYJldgY1qAtcMOw/nI
 Pvr6YBVt98q0D+8w5Fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX87i+o6TfuJPr
 L8PKDb3yJraHQ8L6qKaIouXu7j2EAGtP9NNMLdDCo5SLVa2HgpmaEzSVvPKq93KiJyeaYtfsIA3
 artmoBKLbGYhNF6XSVXMLgTLpBOyTyk=
X-Proofpoint-ORIG-GUID: w_HFh_dq2Y8xcRZaroKSOjkytB3ckW8F
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

On 20/11/2026 09:20, Mark Cave-Ayland wrote:

(added Paolo on CC)

> On 19/11/2026 22:25, Helge Deller wrote:
> 
>> With git head, I'm suddenly facing a dependency on rust, which wasn't 
>> the case before.
>> Am I doing something wrong, or was it somehow just added? I'm on 
>> Fedora 42.
>>
>> deller@p100:/home/cvs/qemu/qemu-build$ make
>> /home/cvs/qemu/qemu-build/pyvenv/bin/meson introspect --buildoptions / 
>> home/cvs/qemu/qemu/meson.build | /home/cvs/qemu/qemu-build/pyvenv/bin/ 
>> python3 -B \
>>    scripts/meson-buildoptions.py > /home/cvs/qemu/qemu/scripts/meson- 
>> buildoptions.sh.tmp && mv /home/cvs/qemu/qemu/scripts/meson- 
>> buildoptions.sh.tmp /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh
>> Failure in scripts/meson-buildoptions.py parsing stdin as json
>>
>> ../qemu/meson.build:96:12: ERROR: Unknown compiler(s): [['rustc']]
>> The following exception(s) were encountered:
>> Running `rustc --version` gave "[Errno 2] No such file or directory: 
>> 'rustc'"
>>
>> make: *** [Makefile:134: /home/cvs/qemu/qemu/scripts/meson- 
>> buildoptions.sh] Error 1
> 
> I had exactly this yesterday, even after destroying my build directory 
> and re-running configure/make.
> 
> In the end to try and diagnose the issue I checked out a much older 
> version of QEMU, attempted configure/make which worked but then aborted 
> the build. I then checked master back out and it started working again...
I can reproduce the same problem here again this morning on a Debian 13 
VM (meson 1.7.0) as below:

# Switch back to earlier checkout
rm -rf build/ && git checkout f71afb409a87c4ecd0f9d63a5963eb645dfab780 
&& ./configure --target-list=x86_64-softmmu && make

# Switch back to master
rm -rf build/ && git checkout 08c9bbb825148dec9669f5184ecf18823bb6d631 
&& ./configure --target-list=x86_64-softmmu && make

# Keep trying to rebuild master (as many times as you like)
./configure --target-list=x86_64-softmmu && make


ATB,

Mark.



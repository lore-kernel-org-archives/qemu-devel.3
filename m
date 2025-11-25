Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1A0D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 23:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO25B-0000VY-Lp; Tue, 25 Nov 2025 18:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vO25A-0000SR-6A
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 18:04:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vO257-00022L-Ew
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 18:04:23 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APMCAet636994; Tue, 25 Nov 2025 23:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=HfL0xXRmsqyYb3PMusRgm/25nTgSz7HNTWmgEIHzf20=; b=
 WyOt0EWlprEfgERUrsXNwKW/3fJDDgMEhJl22GJ7FCuINiaN1cD65st9Wgw9aDhz
 uddAjHSt81JS+3DqlRMJqQTb3jx283F29ELkfodkYcfPR/ADkm0w1pM8rbi+j3vl
 TdVQQ9tG9akBZ02RIEPnFQc1GXXURiEDZbiSu0CQKkcDS1bWDjHip27MDmpwEA1D
 /M9dq0X3CYVIeX4ACEXi+oz4q8+xDWJE7zv4KtI2wNCsdnRq8VYJGRYTiwVgziab
 t+b+BvSftAaEI1dvYejgI0RpTYnmsDZL1ZRzxXw3PhnwnB6Px1CpmsqF4WvK3h9F
 0supzVcQG17BYnGhpFWr7Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhryr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 23:04:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5APM96bw032704; Tue, 25 Nov 2025 23:04:11 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3ma6r8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 23:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ59bOk03aWt02raq+poDJ65jUftBqVDQKrZgvC18PogwngByovug0r7p16+NPbxy7vWAUhKsS0LGxkA7vH49tiOyJNV3rUy0zr90cB6rXKHrP/InejtzHa3ZUyB6/amaGgv1/0jqL2Hl0QtwaZ1CM9ksTRAcHBHLgzozrOpuv03Em5gqcWasKko19DkcmCIBGyuKJqNwWfb5kL/6/1TstJrBlhApQOMurMo8ra2KXLsw1mjfTiWi0+QHtc6v+6uro1uJU4WlCUciF/0pZOW4Ek+kUA5JuXH4yoa1Jh8D35mKAWkWGlLqg/maGVVLESfRFcFyIbGn4+zw6Gf67WTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfL0xXRmsqyYb3PMusRgm/25nTgSz7HNTWmgEIHzf20=;
 b=PzFTHBZhovg5qkJzhEXe6m7rHWlvhO/ZfvEmHkG0zSBArBYRxDjiZxvT5uGDMg9Zt7Gl8yY+RZgkNTzrs/xrK4yafFNYP2eAv0TIeC69dy3HF8vvxS+etUyyuKOWT61qcVvRwZ9yndt0Ie92CtcsB+SmwCM9fJl9hbK2sT93GdNIkJAX1SxTGa55Xmpg9LQzJkP8LVvHtHHeUIzX8vIUku3kjL7Rv6q0Ln20hJGDw2it491osNVhKdqzGTaBtHMSxhToXH+echWXjs8nOmZLMUUHE/VTed30NNTSmTKQsi2eSTYPljTWC5iZVKIJ58IsKGPEYM4n6j5jNpP58QQsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfL0xXRmsqyYb3PMusRgm/25nTgSz7HNTWmgEIHzf20=;
 b=KIM22DudECz1GeTBpHj0j3X9DZXnLwBKoTXlVvHoWw8ae0Tk7bm+10TAwCt5VDO2I8eQNA/QVshWO3cpkOwm1DCgXiL7IfuQNSjKB93cnBgpFgQGLbxzu+VG7LtETb7wq5hDWYQA2ivcWAYaJvYkSaW2CVduFJ1ne3UDGgTsrWM=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DM4PR10MB7451.namprd10.prod.outlook.com (2603:10b6:8:18e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 23:04:08 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 23:04:05 +0000
Message-ID: <40b36c5f-5e47-48a4-bd39-667040f53a05@oracle.com>
Date: Tue, 25 Nov 2025 18:04:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251118082403.3455-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH2PEPF0000385E.namprd17.prod.outlook.com
 (2603:10b6:518:1::6c) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DM4PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbca1e4-7a03-4f16-51ba-08de2c76ee5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWM2UVlZaVlKZE9wYU5VbGpSYW5oY3Q5VERXNnBSQ3lxbmRIWklJNFhkWkxG?=
 =?utf-8?B?N2NSdm44c2hnRzNtYUpLcmZ0MWwrQTNDekZIWXV4eTFFRDVNZkt0aTB4U3FC?=
 =?utf-8?B?NGU5RTdNclNsY09MbkJJY2RSdVFTcDhES3V4bEU0TnZIOTZWem1rS3g0dkg2?=
 =?utf-8?B?OVlYVCsvSjF5Q2tDWjZQSE9DYkZKdjZ0dnY1dHh0Q0ZoZXpMMlliODZBNmFy?=
 =?utf-8?B?RTNpWjZuNmVUWWZ2M1NIVjhzdmJORm9zWHRlQVNwaE5OYUVzQlVrS0ttZng3?=
 =?utf-8?B?c29JWW5kOVptcndNcVYvSjhvVklMZkxYRXc1UG1BUGtJeVduOWR2QlZ2eUVi?=
 =?utf-8?B?WkZsRTBiRUQ3QTMvZE52SXQrK2IwY2FiSWJQTnU0ZzBLWmZBbURCWldaYmpD?=
 =?utf-8?B?WkQwY0tocTRCZFZoUjVKamREd0VPV2paNnJhY3ZNNUwyRW5lYldhMWR5Vzl6?=
 =?utf-8?B?bTl3SkFycUhIUndTS2JHYW9mN092ZUIreStNZXRUVFVqT2NCVmNMNnhicXh4?=
 =?utf-8?B?dDRYaC8rSjVMQlVhditrSXNrZWpqTktFYnRlM3g0a1V3VGJVMEpObzNnQ2Y0?=
 =?utf-8?B?ZzFOZDBYYXB5OUVXd2k1SlcrZnFRM1pwNnJHWXoxYW5mRGFWUkJiQ1hDak5G?=
 =?utf-8?B?MDYrMDlLbVU5SjF6N20rWWQ4SWw3WE1BUVlVSFNhdEE3MUg3UzJRd1BRYUpr?=
 =?utf-8?B?Y0c3cXBtQ1p6MEFRS0lyNWp5dmNhL0JCamtBLzRLRWRZbVByM1RwaVZxK1Qv?=
 =?utf-8?B?dS92aDV1d3FpbUhGdUVQTWw5bGJSQ3hRY0JxaFRLSk1BSzRpQm1MVEpFc3Vu?=
 =?utf-8?B?ckwzN2JhNHFpV2NpaGQwdEhidEx4aU5EQThWYlZjRS9UdnBjUWlWejZiVnVm?=
 =?utf-8?B?a1krNWhrTVl6YzZ0QVp3U3JOdkNJT1lnZVJIMnAzZ0hmNTRNME4wTGYxc0p4?=
 =?utf-8?B?YWJ3VVhTa1owS21tcVJEc1FMTG1YY0N6UklybDFtSGNZR2VxSFdMN3hDWDlU?=
 =?utf-8?B?b3RmUzhiL1FtUzdnQlpsZjdQWER3MTFOeCtFWW9Jbnltb1dNUVFUUXJXQ1M1?=
 =?utf-8?B?ZnlldDhlTWJ1UGUxNU1KTTFtcGJyVEg2d1N5RkJwZVRtcjg2bkxUTjNGRi90?=
 =?utf-8?B?R3psMXNqWEdUWHdDUkhmbjJJcjN5UFV2eENCQmIvMUoyVTArd05tS3dpUXJD?=
 =?utf-8?B?bW1pdjBTSEdjQzl5aEZQdnBmY1RlNXdFRFo2ODNqcHcreWpveEVLR29xclBI?=
 =?utf-8?B?clNWblZLQWFxNU1sbnhmc1I2VWxzc0RzeXZSZnJVdzYzSkV6R0FwclZtZktu?=
 =?utf-8?B?NWFqM0FuYXFwSTVaQVR0em1Db2U0YjRLV280ZGx3RnBFaGxEdlJKaGg5U0tr?=
 =?utf-8?B?TWsvaHAyUW4vK05lV2FGUmVSdmI5WUFkTHhyUlFPVG56M0xiejJTcmVaazhC?=
 =?utf-8?B?WTFLZVNxa3JxNVBtTTZBZnRnampZME1HS3ZLVGJaZVpMMGlRMElnZUpWNVBv?=
 =?utf-8?B?d0piNldJdlpLbk04Vzg2a1FacERkM2p6NzJxUUlCT25Qc0RMTU1Pa0ZPcG0w?=
 =?utf-8?B?YXBCTDhRWDdmWUxPYW1sZUhLSTNuWXNNamJaemNGVlUyYVdTQjNxWm00VCto?=
 =?utf-8?B?bStOTXFORndZZDlrNTNOUm9RbUxUWldxalBDZXRvVlY4RUQ5a3V5dlNvclV3?=
 =?utf-8?B?NEZLSDRSa1o2QkxQSlppdDgybWxHRHpoUGthN2twRzhjSWtUYlRneTg4WFJL?=
 =?utf-8?B?WnUzVlFvaitjQmEvWUZuOVVQZnBySzdBVmkrMUFuYVlpWnk4UWxRY2NZdi9T?=
 =?utf-8?B?UG1lR1FkMXJxM1AxMGk4dURQeFhlbkVsNUVVaUl0bjJZc0k0NXRCTFMyc0JS?=
 =?utf-8?B?eHQ0RXRaNGE4bUVRSmNONWZCaDRFbkVCZm9MV1pCaDhNa2NpLzM1VUZHblZ6?=
 =?utf-8?Q?HX1M7i5dGdfO1llx/y1bBqQpNDFE9CuZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBLNnpreFd2MW9xdkovUVQrTC9qMjQyMEpkd0ZKOVpzMU9la1pFcGc1Zmlq?=
 =?utf-8?B?QktmK0cra0w4MjZDdDhISHkrRU1NN0hZaFAyUmNFUlhteml6aTNpOEU2T002?=
 =?utf-8?B?a1FDODU3NlM0blRSSmZtL2M4LzJpVW84dGZlcVRZVHJ0VVhHZWIxRHZBUVlU?=
 =?utf-8?B?NGFQMm51enBuVm1oellTZ2NXeGlqcG80eVo3T1hEbjYyK3RUSlFqL0JRZEpP?=
 =?utf-8?B?Z0l5VnhWWlVudVhrenhnaWJZdGJUcEFTL2M0QnhGNXJsK3ZFNy9rbktab0FP?=
 =?utf-8?B?SmcrQitrbXVERTRtWGxOdzF0NEZDMGRRZTNia0ljL1V4Y2hBMWxNL1hBZ3dP?=
 =?utf-8?B?YzdtM0RhbEZYakJLdGUzMFRDWUVjQjd3c2JTWTRNUlFHRHNUbkFwNzA2NUNQ?=
 =?utf-8?B?U0pOa3RnQ1JSazRWaDdRUUFpc2tXd3p6T0w1NE9lVkcwRXhtU2wzZ2hEZFJr?=
 =?utf-8?B?SDI2dGhaVUVlOTBZQmJ5QXJ5VFhoMkQ5SEN6TDdTTmJWcEJLajRYemVGTjlH?=
 =?utf-8?B?OTBtSXBGWHhNcTBSMVUrcHlqVU1JWjQ3UGlSQlBsSUdWczZiVmFyWXRObWJv?=
 =?utf-8?B?ZkNSaHdCMFVFVlR5ZHFBN1MzeUdUZWsyZmd5aGJvT1ZPSDdZaElGRndSQ1Az?=
 =?utf-8?B?K3pmSkNJQ2tSRFNhVFJBZmlzOElsVUR1YU1JWHJTREh1L2VlNmd4WVhTbHp6?=
 =?utf-8?B?bEVnZSt4bGsvUXpmSEJDaDQ5SkxGdTdzZXJiQS91ZW1HenNENzhDSDhMZXht?=
 =?utf-8?B?eG1RT2QyNElRN0hKVTA3M3hUakNSVDhJUWNCUHhNSnViekNja093bjQ2dERs?=
 =?utf-8?B?UXNmK1dTbTFHRC8zTGR0YUNmZ1RnL1VPdysrL1ozZTZKdHowQlRGS2pwSDd2?=
 =?utf-8?B?dUhSaXREVi9IZ3hVZjBlVWh4N29LTlh5ZGZFSjUrY3hJcXRPSXNLcHlQd2w4?=
 =?utf-8?B?WnJoRzVQSWhaQU94QU1ldEtHU25vbldqYVpHcXNMTHo1Z0wvR2pSaTlqK1FJ?=
 =?utf-8?B?VUVmNVdYYldUbWlIYXltaXRXTHovOFJpUFNpYk9MZ0JSYTkrdno1WXhzZWVD?=
 =?utf-8?B?WFJmOFlFWHBKWlFxcEIzRUY2ZDFVVFJ3cHVyUXpVVmROR2VpY3pWTW4yallC?=
 =?utf-8?B?a3Bsd3pOYWNaNVB3eVlQUlZnY0RKcUZtbURCME5YcW5BalpraExNbnQ3WEtO?=
 =?utf-8?B?amxOOEczWXVpWTJrWUYxZXhZaEJJTmZGMkZ1ZFdCU1VsUU9YczNYOWFsc2Zx?=
 =?utf-8?B?aitjdCtwZEM1Qmp4M2RuT0RTYW91NWZ1WEg4dmtKSlQ0SE16ZEM1bVY5Qi91?=
 =?utf-8?B?Sm1ua3o3K1dnZmgvSWhCOGJFY2ozMTN2d0pUMnRsODg2bUZlMjZYNTRKc2xZ?=
 =?utf-8?B?V3IyWk5WaHlWdFhna0hRcWExdjdJeEtPN09BQTA0Z3VrZ3N0WEdCZ21TanV4?=
 =?utf-8?B?RTVZSGtVR1JOTGdraE9XRDljR0ZhOFJhaXNpLzh1YmsvOVdES0xIUXZESXNJ?=
 =?utf-8?B?RWFUbVhnenhMRUlUY3JGUXh0UFNyT0N4VHRyS1pNdWJ4NzJ6b3lGWGRMZXNV?=
 =?utf-8?B?NGdLeE8wOGF2V1B2ejBhNW5pSWhKd1RQTVdlWlFBSlVvY0dFOWFNNjBpMTNt?=
 =?utf-8?B?dlNnRU5UekhKS2Z0MFg3cWtpOFFCUkxqOFVpREgwbjRTRUg3S0M1bHI2UWs2?=
 =?utf-8?B?c1F0UkQxVTNsV3hmWG5FS2ZvNExPaWRnRllGSnpWRU00VXFCNlhvNmNuR3ly?=
 =?utf-8?B?UUg3a0wyZTMyRkh6VmNNNE8vSDhnYVdiRW8xMkNSNWQwS3FIVWdwL0c4aXJJ?=
 =?utf-8?B?K2ZDN2lrOWtGRnpQcVNOSzAzK0l6ekc4Mno1U2RSSGJMWHhZVTZiK1FOQ3Qw?=
 =?utf-8?B?SGczVUhTYmdsemhva21nUG9zZVhvUzVMMjVjRHF5NEVmanNaQjAzR0hnTERE?=
 =?utf-8?B?YVFMRXRxYUJBb0orNnJIMjJZaTd4NDdnY2JjaDRjdlBTYjc2TGF2eXBTRjEz?=
 =?utf-8?B?T3JMbXRRY1lXS2lTNmloUXlTb2EvVk5qdXlGWlQ1YlRTcDE4cSt1Y2R0ZDNa?=
 =?utf-8?B?Nm9pazQxeVpGOHA2eldnNDQ2WkdXdWNLdVlIRDIwNmxJMGZoYXBVandpU1pP?=
 =?utf-8?B?NWpJZjZjVVc2cDRlSTB5MVhpN1VwTjI1YlRNcGFpUjlaNlBCSVphSklrUito?=
 =?utf-8?Q?wgSCw/20nhWT60drOkCPJtY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dlKdhvdD6IbD43JnHlguCidEjF9mglGBQkmhYIpk3MSFvscdFafcSZw3Zd4ik4xBQ0Z30Nhu8z3Mk9XstooYL0k7JJJHvOpTyGZwWWWmIqVEw6RY1ofwU1LRyvUVZf34na+OEsehETUJKrJrFjlGFfmIO5gTfhA8l9QPjL6bzl4K5x7X7Y5W75S3o4LiIPZzOv8WV4YEzjIaNYNQsLRlXdIAjff/7+6ZVUK52aOh2Zfn5zL9ovrjhib4Q2wZO48s9alFaC5eOCNsOMpZ77GgyrxpcYJrglQ9+nrbEwqq+5tdLSnHLhP8swTRuiA2q4axU2poTp0S3XgN9y8fG85XYxkmKNq5BBg01y+uhRxYkBGf1u9SkdY7W2KJX0TCV2sQEz3qKbI0R//DwXQJETSKiGKS9UbT7Qt4g25tHo3kHG2arf54NHQ/sHWX8B8x6JsY4whiiFzsavarg/rHPonvcnSZm08K7zJj/bDqfXyqCir34IhIvM49mX4mnevCEAQ2iY/hs1Dub+bjack5tnMctN2p1VRgq43snj3Vj+niX0zBKac4JSv0D4yUnlYXT0yBpbObKcN5MGE5GUIoc1/djNi19COqa750XnF3VuGZQvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbca1e4-7a03-4f16-51ba-08de2c76ee5b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 23:04:05.1647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywGv9gBDBPj009Ua2zSQq+AM/AWUyVs/9/zSnjQn8cJB8lHa8vFrSlyBakm/+qJ8CCOE4sdXrmDpZdHfHRjY9698oqpNUx3GUdZYvGCg8+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250192
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=692635ec cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=fElzPsjcvY0FRN3P01oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE5MiBTYWx0ZWRfX99sNvPqbdv/9
 hu1Jc1UuqslYZ4u/RvnZl1BPc3DNY15gI614z85DFc+Nfcz2rq8Bo07a6vKYLln3WQYSHq8ZOb2
 e17gz0m6YSXe81OzaOs6JwltKC19kme9k9XsLej6+Dp0Z8Cw0VYWp60OMeADNMBPibMDVH0QWb5
 bpyT2XVvM3t9yCGlcr3CUAR3Ltyop8kQLAiHUsf8EEFrLf3y2HUInMoFXxBE9rK6pkdEWqZIy4x
 i8LcbTeoR+77dwn75H8NEsHA80HZItc7nrxtOb+QlxrvdzYTL/CDLXoeobeoYCh3xnNcq29kJN+
 nIKfaq9iiQLekam10+luTNgczZ7uxAVPvXaODv+JfCEcChkmfACm8M2+OajJXZF6J9rtsAfRS5K
 NlX3/RPO5uq+OfBhj+js8X0BkG9wig==
X-Proofpoint-ORIG-GUID: Qlnma1GAbK_uUAumaOk3SLsEHr-wk3VZ
X-Proofpoint-GUID: Qlnma1GAbK_uUAumaOk3SLsEHr-wk3VZ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sairaj,

I have a couple of suggestions, and one addition I believe is needed in 
the code, but overall looks good.

On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
> Current code uses 32 bit cpu destination irrespective of the fact that

s/"32 bit cpu destination"/"32-bit destination ID"

I think it fits the language used by the spec slightly better.

> guest has enabled xt support through control register[XTEn] and

a guest has enabled x2APIC support ...

I think it is better to replace "xt" above with "x2APIC", which 
describes what the XT feature is/does.

> completely depends on command line parameter xtsup=on. This is not a
> correct hardware behaviour and can cause problems in the guest which has
> not enabled XT mode.
> 
> Introduce new flag "xten", which is enabled when guest writes 1 to the
> control register bit 50 (XTEn).
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 3 ++-
>   hw/i386/amd_iommu.h | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index a9ee7150ef17..7f08fc31111a 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1548,6 +1548,7 @@ static void amdvi_handle_control_write(AMDVIState *s)
>       s->cmdbuf_enabled = s->enabled && !!(control &
>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
>   

I think we should also include a new xten field in 
vmstate_amdvi_sysbus_migratable, to ensure the remapping behavior stays 
consistent after migration. i.e.

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9bf36ef608..5940011ef1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2452,6 +2452,7 @@ static const VMStateDescription 
vmstate_amdvi_sysbus_migratable = {
        /* Updated in  amdvi_handle_control_write() */
        VMSTATE_BOOL(enabled, AMDVIState),
        VMSTATE_BOOL(ga_enabled, AMDVIState),
+      VMSTATE_BOOL(xten, AMDVIState),
        /* bool ats_enabled is obsolete */
        VMSTATE_UNUSED(1), /* was ats_enabled */
        VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),

There is more work to do there, but this seems straightforward.

>       /* update the flags depending on the control register */
>       if (s->cmdbuf_enabled) {
> @@ -2020,7 +2021,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>       irq->vector = irte.hi.fields.vector;
>       irq->dest_mode = irte.lo.fields_remap.dm;
>       irq->redir_hint = irte.lo.fields_remap.rq_eoi;
> -    if (iommu->xtsup) {
> +    if (iommu->xten) {
>           irq->dest = irte.lo.fields_remap.destination |
>                       (irte.hi.fields.destination_hi << 24);
>       } else {
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca5121f..32467d0bc241 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -106,6 +106,7 @@
>   #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
>   #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
>   #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
> +#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
>   
>   /* MMIO status register bits */
>   #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
> @@ -418,7 +419,8 @@ struct AMDVIState {
>   
>       /* Interrupt remapping */
>       bool ga_enabled;
> -    bool xtsup;
> +    bool xtsup;     /* xtsup=on command line */
> +    bool xten;      /* Enable x2apic */
>   

I'd reword the comment to indicate this what the guest toggles for 
enabling x2apic. e.g.

bool xten;      /* guest controlled, x2apic mode enabled */

I am aware that other fields that are also "guest controlled" don't have 
similar comments. My idea is to highlight that the xten is "toggled" at 
runtime, and is different from xtsup, which is a capability inherent to 
the hardware being emulated and set during initialization.

Thank you,
Alejandro

>       /* DMA address translation */
>       bool dma_remap;




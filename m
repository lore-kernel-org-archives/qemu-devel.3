Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BA0E7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3G7-000151-7a; Mon, 02 Feb 2026 18:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vn3G3-00014g-MF
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:23:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vn3G1-0006HC-Fk
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:23:03 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 612J7ptU1114190; Mon, 2 Feb 2026 23:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=oox1SMyhuLLFHgqWGbMkYcN+qhT84LmToBXbtCsXmmI=; b=
 jyq2gdryKWL3rOSVs5s6+tnBBWS453XGRxOYdiVjbeD65LZ6fWDz5liLwJv8O4y5
 9KAoRfA/1pKP1EIB1//PT98VyLesPAYWH/nUMR/0ibJ5klJEr7ihzI3W3fa8aDNE
 79SSYOyh9R984WLZtsJBI9iVY4XHdPClZ3wdqPWJ5ywuW6SPLiwaPX7J1W4Fidqb
 ApCz8xkYToHKZzNpYvMXaMai4qIvgtCfu1CXQxgox+iuplAdIHMDOorgNgwCTDf8
 ZW9aVEZsaB+glTL5UzsS29PhESoPRHOPuUcU2N/tqVJb9Iw6H7XcSCN9Y18aiC1D
 gxeIqctc3FCtPI7wQvpChA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1avj36y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Feb 2026 23:22:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 612MR2td002127; Mon, 2 Feb 2026 23:22:52 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4c186kkbq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Feb 2026 23:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSscX998KVpirs72MSiyRiimUxvrKkRgDEcYg0vDHpNnLlDj5DGyFd+qM7sV172LOFXG3gpZomBfzYDqP0+0oAnSgTu3vABVHybpV172egeBEtz4wgPg2Itr9UTKG9M06XduWumlSuPQvl5zMemcJwLMdIlKmJgarap8FU3DMSRO7/cm9/Io4siX10een024zUGtPeTgf9qtqELCyVdsyzzi+Z+EHq2s5hA5d6z4HAbBzBfpHXO3k+H0W06Xju/HADGI4k5bLXssYfgsYYFgz5nSrNNl9gCG5BX9gFbhWJt5fJDsMyDajsTwwVZKszYaKRa+2xxOhjhU0onrD4XyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oox1SMyhuLLFHgqWGbMkYcN+qhT84LmToBXbtCsXmmI=;
 b=xCSi+3njxmMpOEIpTu6EMHOuLlkyAr86wJVN/9D4pbmHDiq0gqbXiZgJGo81Fi3q/4GcTP3abp2g/dBI7cvSiZgpGvJEFBMT+OEGN+ZZ+RcAVlbsC/qsNgOBeHj8W1wSN3upWqZTC84T3W2HNedZ17W5k+NyWH2t2blyMWsq/Ej5odKRkAIEi2WC3P/3qR3XIZURrvyc6u4x4UdMJZhwutcRJv2ho4XFh642pcdJeUtArP/M5HglomflWb71CY4DePMzxALzMXmLL9BqJ6ccgxt7M6cufRAMmb0h8A4VLvUKlFgilUpvkjXBc7j0yhDIMVsuNZgcIA+0DbUjZCP64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oox1SMyhuLLFHgqWGbMkYcN+qhT84LmToBXbtCsXmmI=;
 b=suxKiCoRP3sbbKcTWupDJdEWcAeYrv++3xsnPYNlPF4qVCndQA4H4/ntih80U6NOzbAm88ANslqZozG1221Xs1iVvByB1mA4Huoq8xsOtFK8rd7/iqIeDpcuDpiOPVgf1w4OqFY6XaRymiZYkrbyJtCKGVs3wvyIWn9EuRnymyg=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA1PR10MB997605.namprd10.prod.outlook.com (2603:10b6:806:4b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 23:22:49 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 23:22:49 +0000
Message-ID: <f96a16e5-c73b-41bf-8679-8129ad39cb98@oracle.com>
Date: Mon, 2 Feb 2026 18:22:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, vasant.hegde@amd.com
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260129102814.4488-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::17) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA1PR10MB997605:EE_
X-MS-Office365-Filtering-Correlation-Id: 071775f7-728d-425c-d058-08de62b1fb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0pUWGYzY1VVQisvaGZTcTNnb1JOVWZ0T2Nwd00zdm9qWGN2ek4xeVkzbWwx?=
 =?utf-8?B?OHEwWVlXUklaRDJ5WFhXRUQzckZFTXVYL2h6eHhJMW5VaDJOSUZnREF5RWt0?=
 =?utf-8?B?SkdHcW1LRGRrU01RQ1ZRczJWUFFBQWVDcTk1dzh0VmdQaU15a2dVdlRHN2tl?=
 =?utf-8?B?UFN1N2pFOXhKTzFNcEl0VVNWUktrK2tta2lVQUM4aEthL2IrTTlKbmNTL3Rl?=
 =?utf-8?B?akxwa2l5cjVLUkJzczl6Z2QwM2tOVWJXQlMyTWxkejZ0eWVOS0FJc2psZW0w?=
 =?utf-8?B?ZFJnVEExYzdsQ0pIbnNLeFRYTnhRNVA4MnhwWWRWL21EY1FiQWt1NWFBTUxC?=
 =?utf-8?B?bENzUVZWTXFoL1l1UVFsMktrbVQwWVZKOEtUTFZVb1RoNjg4VXZudXNKWmVB?=
 =?utf-8?B?UDl1dkZNZ2xhMFpnR0doUDJIOWJlSW9rTk9qRHJQcmNzN0RzYlBHTHozc1gy?=
 =?utf-8?B?MkovTy85dXFSYURmMWRIT1dTRXhTWGR4QlV4VDFDbGxnVEVHUVRNWE05czNR?=
 =?utf-8?B?a1haaGRLYlh0TytiWW5SbENnYVZ5YXZ3aEc2aTk0dkRSQ0gvdWFrYldRcnpz?=
 =?utf-8?B?cTlrV05KWXlBTVdGQTc3ZUpqNHBBVjZBelFiNDdlY3JjVmtBTm1tOGVSb2Iz?=
 =?utf-8?B?elZQczUrblR6VWRxV2x1UTN4N204M1FTOFhTb3QvMXBEOGNWZXBzVitjbjBr?=
 =?utf-8?B?L3VQZVNsL3ZhMnlaWVZLVkhMNmpUVHZXbDQ1V1dpTDJDVlJxZmZzYmF1WWt2?=
 =?utf-8?B?MkV6QjJIT3NGR0N4UnNHbk5lUHF5UnphT29ISUxNT0xVQ3hvYSs4UWRZUVln?=
 =?utf-8?B?T2RiZzN4aFcvaHd0TFY2b0hUSjZwZm5IVTA3N3ZZWXN6NmNOTGRYUXlMdUFs?=
 =?utf-8?B?MG5iUUVyT0I4UGZDbGdqY1oyeTA4NlBMNm9sM2x2MUhJNDlRRVpuSS9XZlVE?=
 =?utf-8?B?R2ZHZWVhRW9jcGV4c1dsMVc0NWt1R2s0dG90eFhDNXhudUIzcitkY1BDYUpk?=
 =?utf-8?B?dThTRXdLeUJQbTRYZlpwT2pvS0Z3d25XVXRCS2xuaFNHL1I3Y0JsQUtrOGdo?=
 =?utf-8?B?QVZ5b1BNNUU4L2dIYmN3aTlmaTJyaDFLRjdUZ21sMFd6YjhGOFhURVRvOWM2?=
 =?utf-8?B?N3VNdGdkbGtOZWdsVitqa1FDdWttMU5veUZkK2lYWVZidUxLQ2lMY25CN2Nw?=
 =?utf-8?B?eTExZ2llOXhER2kyVy8xWHlITjJhZXpTdTNGUFVsM2FWblB6ODVTNFo3Z3dR?=
 =?utf-8?B?ZWtPNVJUbWF4SU5mWGZnSmg3bHEzeFVXcjYrS0xXbVE0QTVmekRIZktsdHNV?=
 =?utf-8?B?dVBJcVFHdksyOVcybGZKZXZheXJHdGYzLzRxNXpnZTNEQUV5R2REUFJEdlFw?=
 =?utf-8?B?SFZNd3pzZHlyZUlBamgrMmpCY1NiM2d5cFRpUVh1dnc1MG5YTlo1OGgwaDlv?=
 =?utf-8?B?MGVrbElYTzlCWjRLclJWTnJmQk5zbXhWQmJkWXJyMHNVYnJTVmNvN2kzYTFK?=
 =?utf-8?B?RUFKRVo1WFZmdllmQnUrNVgzUDQzOXU1MGpjMHZneUl2U1U1S2o3N3g3eTRk?=
 =?utf-8?B?emNBSXlEaUZKU3A3S2xZOVZTNHlyMVRZVEpEcWZudU9SQlA1UVRXMGp6SmF4?=
 =?utf-8?B?R1RyeGowRTVJRDJqSDczc1NJRkNwV0V1S0lGWkxQb3F5aEFLNURrNnhWMzlD?=
 =?utf-8?B?MDdlVFVSdi8raTJZbG5OOFNleGZJd3lPMTZXSFZoRmxza1cxY3J6NUlZbTJ3?=
 =?utf-8?B?ZFdiNFBETDJ2MFpjaEpQN25qRStjdGcxQVVaL1hEcGwvN0MvTkJUTmpxQlVR?=
 =?utf-8?B?cmcxdGN2VjA0cTYvYTN2Z0dINlRhNXlqc3AvL3BaUUo3c2tvSnNnY0l3MDhz?=
 =?utf-8?B?OE55L05uN21ZSFhESkhibUc4NWRqTkJ0NndGbWpmVE5MdUFQOWY1TjBPa2Qz?=
 =?utf-8?B?bFdHUXBYOGx4ZXhGd2s4NTlueG1oT0tWV1pDeDRsTWFScGFpQ0ZBSWZmb2FV?=
 =?utf-8?B?eVV6TEp0YWVWazQ4RTZOL3A5YkVxdU1IZ1dTeWFpWU10OHhXL2tsOXdxVmZM?=
 =?utf-8?B?YmU3cWNlcnhHNUVBS09hNVFSN1dIanRBU210cmRTdFFtUlhvQUR6dnNudnRw?=
 =?utf-8?Q?6uiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmYySCtvc3hCazV6R1dmcURNajVoMTJnT3BxV3RNZEkzcmcweUFUOWdDcytP?=
 =?utf-8?B?dzJUbDQyRjNNU2FuWHZuZHlkaE92RjFQbktPcWttZ0NENDFoZWh1N01nVStF?=
 =?utf-8?B?OGRTcDNRN1dyQmUxNnpZcHZMNVNadlhKNGJrdmpnTml4cy9EZWovbmdMR1My?=
 =?utf-8?B?SUFEKytPTUlrRi9pTkVRd25Edm9GYVEraERFU3lzVGZjYlB1Z2FxazZMcktl?=
 =?utf-8?B?SkdVN0tmZ3NBOUlScERoeEdEcndXekp6T21VV1RQditGbkJZQkNtajJBTU1O?=
 =?utf-8?B?clRGSlppUXpvY1V3b2laZTYrRGt6L05JWTV1TWdyVVZuYVR0ekhBL1pOc1ND?=
 =?utf-8?B?blRxMjFENGh1d3FYRk9kWlNkbHFYM2RMUDlzckFmYUUyZ05JV1IrQ2RsSWV6?=
 =?utf-8?B?UkRKdExmL09vWTZoOFRRWStxTUNGUEZmWkk5eVlQTEZJbDN3NURGM0tIcXdT?=
 =?utf-8?B?UFVpQTFlZ0kzTGpXeG5lOEFaemk0L29oam1YemVuM24zZlVBa3llOU1wV2h1?=
 =?utf-8?B?MkltR216bVNmblBEUVZSSWFSM0Nia3RnY0lTT25rL1NxMy8yVmdKZUgxTFZD?=
 =?utf-8?B?ZXZEMCtpUHdYMm9JV3o1azl4WW9JSFkzaTVGeXBteXNuUHh6blBmK09IRlJH?=
 =?utf-8?B?Mm84dnREOXVxRzlhd1pKWVpSdEVFSHpSbS9GL1c5eVhlWjNDRjczTk8rdTVl?=
 =?utf-8?B?ODhiOTRFb0VqcExmQ0pyVFNWbTVYaXFzZmNUMzlWOUw5NWx1VkViTzA1bUpt?=
 =?utf-8?B?eXR5U3lNbWpuNmRKb1lrVERRMkhyWVR4RU5ZZUkyT1hvcEYrdEdBd0hwUVlk?=
 =?utf-8?B?YjB5WWdTbVdFbTk3SGFLWnlKSDdPTVc5Mmdkc2h0d3JUUjk1aXh1c0FZWXEw?=
 =?utf-8?B?eDdpY0VZOE12Q3pDc2ZBcUxrWjlsby9iRjNORmJVWTRsNjZsd1d5YnlaaW53?=
 =?utf-8?B?MnV2eGQvMjJLdi9GNjUyQkRPWFVyNFhZOE9HQzhldmRpZXlleEwxd1ZYMUFz?=
 =?utf-8?B?SDIyL0pIVmk2VjJUSWd4U1pYSHFzUUZGSW9HTm9qQWhlQ0lxaUExV2gxNWpR?=
 =?utf-8?B?dTVQYXBGZ3JRazB3cW8zZ1NtbUpzY3VpcExNbm53V0NYN0RIcjM2NjhnUEQ2?=
 =?utf-8?B?MS8vcFJpWWRwMWszZ2Q4MXUzY2VGNFNFRHVXQjJyNnFKU2ZrNjd6dmp0UVNY?=
 =?utf-8?B?akpOVXc5UG8rK3l4TDFRSlVJejZReXJlbXYvTE13ZlY2WGV6L3lRWWk1aVlp?=
 =?utf-8?B?dzNPVTZacmdvVVhwVER6YnA0NjBuS0NObDNqMFdyT05mckk2aVZNc0Z0eXpw?=
 =?utf-8?B?OGZIMGtNM3Y5QVdQWkpOWHREODNnY0ZObmh5ayt4K0U5cVpRSVBYbUl4eHJh?=
 =?utf-8?B?K1g1TVU3bkhKVzFBdjg3c0NsVVpFdmZBbEVyUncwTStLWnptTjlORTRlQ0R0?=
 =?utf-8?B?bUNNRVUwa0tYVXd4cEI3SWFFenBGVk5Fdnh0OTlTQ1FOaE5VVERna2Vic2NJ?=
 =?utf-8?B?Zllia25zbnlCN3UvTllOdXY2Y1Qyczd4VDZRSzRnMGM3THQyVXhzTGh4NHB6?=
 =?utf-8?B?dXVidUxNaS8rOXBNcnZ1QWlBYXpNc3lZRmpNK0d6NjNSV3J3dTZ1cDBnaXVK?=
 =?utf-8?B?V2cwMktRTUZwK2J5MUQ1K29GTFlIOUNUVU9uOHVUVlZqa3lEd1dpVW9Jb3ZC?=
 =?utf-8?B?djRLNTRYY3had2tuUDM2SUswenUwMkNPaTFlTENFWGVSZjE0RjlLdTlwRU83?=
 =?utf-8?B?R1hpdndZZncxNVhOYjRObUUwMnorQStkeGtKMit2TnhrVy9kUjZFZGpxYmlC?=
 =?utf-8?B?dXJ5ZmpxS0ViMDlacE42R3RsSDkzakh3K2xkdUhHQmJxRHE2RUZtc1RueWFC?=
 =?utf-8?B?MWZUQnlPWE1weEpiYXlCclRZVjZ3Q3JHdVNtSjBGalpNbmtueC9rUmdoUjJH?=
 =?utf-8?B?TkdFV3BBYURJRmpLTFZBRmZlVXc4cUJ1SXB5eXpQeFIzRk02dFJ5L0w2ckJP?=
 =?utf-8?B?eGg0YUNMcWRaK1lqNHdSa3ZGM2lzeUlEbEN4cUxqanlneExaS0NCZUVtSENM?=
 =?utf-8?B?RVNzcUJPZ3UrWTJ3b2FSWHFDa0NmOHM2aGE5WTJMSHVQQVQ3NU5QOE45L0Ju?=
 =?utf-8?B?aWt0Nm1RMzg2cTVRTjZqUVVUWmEvSWpwTnNVVWRiaTkrQ2FvUDZ2TTFkdkNw?=
 =?utf-8?B?L2RXQ3BodFd3dEFDK0t1ZHAzdEVlQzN4NnZBTmFZbExxSktWcVdaa2ZraFdy?=
 =?utf-8?B?VEk5SzFTSFJLbWRTeTNFcVkwV01NQy9FZjFaTU4ycVJKMWkxSXZ3b25CdGw5?=
 =?utf-8?B?YnRZSzhYZlpiSGw5bmFDbFFyaUlLblZSeUY4WFdZV3B3Nm85UGZ2anB1QjBL?=
 =?utf-8?Q?2FTqPYh8BM6DHLus=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I3nAcYEmeDgKlbbGKcpivUJQfWiH2pFQCHajXWcPxx0jkvMkAH9WUaDjs3ERVkzmXRgOmTigSo+FsTejTDWwyMZ8zwSE3wYyBlEG9/fHMADj2NRPO6yZkChe/WuY3ZS13z0Z1w3DLkqT21Pcb40GN61BgSzXxWXLXYWDpDKh+0GYQyTQRmgCX5MS7CK8hTlGk08mLv086kkFaNvdoOojwIiJnnk/o/AF1S0ITEAEp+YUstr0TlCsqUf0C0q9DcwmBUr7IrD8RUv8K1jDCVjtwF+5NqnTNr1HsX3Ww6bBM7wihnu4h++NllEjSyyS7LPBS7WblS3SSL0tBo8biEXzsjGMU4nKox3WjmmBi+P5hF9YIX3ngI53Ec/zVSpiX5TFBCAqTshXMiD+tOrjPW0bM+Gdui5kNQSQFnj65XWaHvxGqk1g65HZMxXB+GrnfqW1cYmO5I8PaBwL6I55guvbOMwnpcmlVc+eUojRoBTuNKZ/Avm6NpTarA7CHTQwt7CRXcynoZ5vlSgxUROJXmVBimo92fNnEP+2abTaJkCXNuU1wM5DNjC00LKUbWOE2hNcMXzWEoRs9pwhs6Eo4qlm4C279u6Pz6IVObhnWF8xC8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071775f7-728d-425c-d058-08de62b1fb00
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 23:22:49.5706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCVoCdDbtfDiNIkEkH1oMTO1Ou5Okl3VQijCP4MJ5y31WAsRkKqw/wTO2C5OKagf7irfzNwRrwV03V/SeMKxLWqungCXRucdXIa7uNgoguE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020184
X-Authority-Analysis: v=2.4 cv=C5DkCAP+ c=1 sm=1 tr=0 ts=698131cd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=X0HDZBQi2Z766fXn2HwA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE4NCBTYWx0ZWRfX8+gtlLgQGhBd
 54sY551bLtCT6be03nIA46hs+rnv8T2zsOVm6GNAvz3iKPQH+tPHU9uOw7j0CFjQU8zIVspbai5
 fjj7ze2qWDtxaV+4wbHW9Rn+yv+PfmjN8cb6/RlgWUKLKbSg4HiDf0OVQQEwQuKNzJQlbpXXRU3
 OUpUvpXHWnf1JhrKPe4EycsLQF+mHQX5xXxZ3a32BNQnMtrZa0PeAN7iId+nn7SzDigG7Q63qUs
 V/FBVQcrTn8P18RqsM2MUA3g4k4BlsTaaMf1nsyFrIYFNoL2WZYExf2ti6RLqPeeabPGKWtyI7d
 9GwqOmZTtCtPzYPszw6w+5uUvBAjFyhnJmH4Th5rJ8zo9NVn6MRoc3zegKArdywIBFNJsp7CuHY
 FNL7Hzxkn764bWVQfn9+pBQ0ZTb6SmPmKnzXxmhognihULccYnvGvhVlRoutDe0HG+bf5OwaXXe
 Y3b5Fdpl+9rkWaxJQT/Gk+6MGH6FGt3GKW/Q4GX8=
X-Proofpoint-GUID: WlPm0Q8YaH_20SURMJeWAdFwvvuMqvLK
X-Proofpoint-ORIG-GUID: WlPm0Q8YaH_20SURMJeWAdFwvvuMqvLK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

One minor nit that I mentioned on v1:

On 1/29/26 5:28 AM, Sairaj Kodilkar wrote:
> Current code uses 32 bit cpu destination irrespective of the fact that

s/"32 bit cpu destination"/"32-bit destination ID"

> guest has enabled x2APIC support through control register[XTEn] and
> completely depends on command line parameter xtsup=on. This is not a
> correct hardware behaviour and can cause problems in the guest which has
> not enabled XT mode.
> 
> Introduce new flag "xten", which is enabled when guest writes 1 to the
> control register bit 50 (XTEn). Also, add a new subsection in
> `VMStateDescription` for backward compatibility during vm migration.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
>  hw/i386/amd_iommu.c | 21 +++++++++++++++++++--
>  hw/i386/amd_iommu.h |  4 +++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 62175cc366ac..850d3920a76d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1535,6 +1535,8 @@ static void amdvi_handle_control_write(AMDVIState *s)
>      s->cmdbuf_enabled = s->enabled && !!(control &
>                          AMDVI_MMIO_CONTROL_CMDBUFLEN);
>      s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
> +              s->ga_enabled;
>  
>      /* update the flags depending on the control register */
>      if (s->cmdbuf_enabled) {
> @@ -2007,7 +2009,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>      irq->vector = irte.hi.fields.vector;
>      irq->dest_mode = irte.lo.fields_remap.dm;
>      irq->redir_hint = irte.lo.fields_remap.rq_eoi;
> -    if (iommu->xtsup) {
> +    if (iommu->xten) {
>          irq->dest = irte.lo.fields_remap.destination |
>                      (irte.hi.fields.destination_hi << 24);
>      } else {
> @@ -2390,6 +2392,7 @@ static void amdvi_init(AMDVIState *s)
>      s->mmio_enabled = false;
>      s->enabled = false;
>      s->cmdbuf_enabled = false;
> +    s->xten = false;
>  
>      /* reset MMIO */
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
> @@ -2454,6 +2457,16 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>      amdvi_reset_address_translation_all(s);
>  }
>  
> +static const VMStateDescription vmstate_xt = {
> +       .name = "amd-iommu-xt",
> +       .version_id = 1,
> +       .minimum_version_id = 1,
> +       .fields = (VMStateField[]) {
> +           VMSTATE_BOOL(xten, AMDVIState),
> +           VMSTATE_END_OF_LIST()
> +       }
> +};
> +
>  static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
>      .name = "amd-iommu",
>      .version_id = 1,
> @@ -2498,7 +2511,11 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
>        VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
>        VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
>        VMSTATE_END_OF_LIST()
> -    }
> +    },
> +    .subsections = (const VMStateDescription *const []) {
> +                    &vmstate_xt,
> +                    NULL
> +     }
>  };
>  
>  static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca5121f..e9401f3a5c27 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -106,6 +106,7 @@
>  #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
>  #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
>  #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
> +#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
>  
>  /* MMIO status register bits */
>  #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
> @@ -418,7 +419,8 @@ struct AMDVIState {
>  
>      /* Interrupt remapping */
>      bool ga_enabled;
> -    bool xtsup;
> +    bool xtsup;     /* xtsup=on command line */
> +    bool xten;      /* guest controlled, x2apic mode enabled */
>  
>      /* DMA address translation */
>      bool dma_remap;



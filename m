Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4461CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFPF-0004w6-TN; Wed, 27 May 2026 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wSFPA-0004vV-EA; Wed, 27 May 2026 10:38:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wSFP7-0000eo-Iy; Wed, 27 May 2026 10:38:44 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64REcGXI1933511; Wed, 27 May 2026 14:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=m3fNEiNBzKwNoz1e9aBpvTXP3FdMvf0w17X2Azt3CzY=; b=
 GNunZaDw7XKJsxaVzn+w5x/pvWzVqz74EMktZz9ixlo5Hl6hTZl1+UfF9lGIbAOs
 WrYk/WceZ4WPwrduM9Qtjn3yP+EV6AXRS0+KiFK97ol7Ol3QyhcgM+JgyHmsXNY+
 cxgyz8mDEtp02zWT+0LjOxL/jTQ5mDuOyF1gLIKIbaoai0RdS3IH2bUjiKSHSVg7
 ILRk2QKgh+T1j5e+ObtCLXrI/gFd/wYfw6wq0ljaQLNosdWkT2W8BDdoLvWD3wGw
 pjoZQ9XnTxSJcnj7qPs6YtLYUJHBeMJElmj/jGYUECS7QheRk7aNLi2+2tBGrHTD
 EpkuFdxefcrHifyBbHsQ5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb49cnq3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2026 14:38:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64REYvpV010725; Wed, 27 May 2026 14:38:26 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4edjwy4fst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2026 14:38:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBGr8KSvUQ9bsOMUSye1zp7nD0IyrSHz6RZrVo7cuRc1OXSbVZFTOwmS6eu22JSuA8m0uxg9EXwKxjQeBPO3STDwMWRnRO1IAOidTwOO3mWPh9YsOJD/BuvqCT4Kx4Ob1dxngsjWqz1SoxlbhqkwnCdFCvGmx4QamF81LOuWOaJt903T9t3U4nVO+ZUzNURY52g8PhFsG6l+ixTBZvapMVssC8Yo8OlqhHLfZd91ix/uVVj8rJT4oHsq1In+XmtNzQIermoftvx7TkJv+VWxQ4dP+Q0qHI7f+2lk45mb7oS8rXw5dXVAjBRn3tjyoW+l9rtDvVIBEFca2pfU8DXHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3fNEiNBzKwNoz1e9aBpvTXP3FdMvf0w17X2Azt3CzY=;
 b=Hjcd5ttj5nWUgH8+yqWAnYNE6Z6t6jDyhS468TV+lyPziDE7qBN6PC9uY7bb+jcFQcSVtOC8qdXvO+AsHJF6Jgm3g9K0KV9tjoe79X0v8SJ+NLX7/XVhxiAd4YR/nViRbgnx7Khd5k7gnXlITz3SaeznHLRMYdJuWHVpro5IXzlNVlUwxkt5IXGructISB6P2LJdZPXzx8paFwipy6XcEAT5lOokf7O7DTaxz6JxJK/QT0e8qv+XlU3luxYXfbV2hWB4gLkH8MS7iywDMVjiW3MoX67xVBmRYKAyfrJOmDQB6Pd/nR/XzIeuJazaxqQKdL8t/RATYfpHD9ne5eQeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3fNEiNBzKwNoz1e9aBpvTXP3FdMvf0w17X2Azt3CzY=;
 b=HkB3rERvbsXXLzaquEeq6qlN9K8bope2Jbf6S7s2AxUmjOljlJZYnonxYjhiKCu8LJ5BiHsAAWVdZT0G+g7c/4mnYXsPN+gHd8+w/nFZnGBd9c5PPX69qswkAkafdpZFpj5jxHqjDXczOJYZrxXEDZoU03Gh/B7Bz2ce7TMfH2s=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 14:38:21 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 14:38:20 +0000
Message-ID: <059db382-24bc-4d42-aed3-889223e9bbc1@oracle.com>
Date: Wed, 27 May 2026 10:38:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: fix infinite loop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, Yunhe Wang <yunhewwww@163.com>, qemu-stable@nongnu.org,
 "Arun Kodilkar, Sairaj" <sarunkod@amd.com>, costas.argyris@amd.com
References: <20260511113923.2478812-1-pbonzini@redhat.com>
 <57a965e5-5cbc-45c0-91ae-3c4c4e5a521f@oracle.com>
 <fe7a5935-fafc-40ff-89ce-58b92650447a@redhat.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <fe7a5935-fafc-40ff-89ce-58b92650447a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:610:33::23) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0fa449-78e3-46f1-f1de-08debbfd994d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 2qvjgwkgpegyrdOE7MamNhJ48QS8Gyj+Oq505njjQYM84MaqyFaOb3vMsPxisdjT5YBYXiqjCXDvbMLVjBOf9XjYOJ1sXzc3y+ugufSC/nA82fe0otHOjw1I/Tl1wxDjBBX9B8cJKiMXgrilq/qCztfMcwMSwm+cgTFVE3RU2I+b5UZDDPtpu6oYkKWFojH3slKUBHkM8RNncc8FsvAbfn5MMlL5Gw2dOOyZNE0uhNY0dRmWqutT/FVXO0fZnsEMCxLlEhy4rAkBfxjyVPC+c7MzadXeLI4PoumSk4dsm2f7Be37iMZbjIYv1DX+ne2nVWCLnAeuTSaUCmzrGLCUKgJr277TTZy8iqJem20n/Kr73joWmzBeoJ5wT1qbzt9pEt9WzwE5fjngBWg1usel5tZdzhl9cXgSPy8u5d26cDUjYdnvaknkq3KSuM1a98OTs9dV0a7vdg8uuAVTEHOFpufErD8nN+1VCrWSTPE0//LQPEJjvZ4E4wf+a24E3dNNqjoQ2OByadDr9Wz3kx0JWXkI1x76IFISbCk1aQsFc+JLpbgavaE3xIU9ISnGdlz/lpyE7IORbPR8EgOOklylnJPWFhzOrIH6Dn8Z2rod29wiSAhCPElz865vTfKaGZJNGDl62fdfGFi3h3zkVNhJcgZFx/A7xH7zyMyRsA+ZqWmivTN3DBrdR2f1Rfje3PuqJ5vztpUACHgsv1QcEik9iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmI1UGhCK2U2MU41OTNabnJTSEFSSXRsc1ZqOVJ2c2ZwQzJTN0ZQdFdDZXMv?=
 =?utf-8?B?WFM4Z2JtQjUwZjV3bmpkVGVXMUNiUjduaWdIUFBIY0dmdHdFdytES2pIVTVC?=
 =?utf-8?B?MlN3RFBvRGZvQWVNQ2d0cnFwa2FzOU55bWF3b1k4bUhpenJQT0VlVWxuUXdT?=
 =?utf-8?B?emFJNHhNR2t2Wis4REZRc0JQTTRoOUNjanN4MnAxT0ljUzRlZlYzY1UvMVA1?=
 =?utf-8?B?YWpzRnJGd0tUMy9iSThlTE00S01HcUcvQ242ekw3YzNDc1V2dXE0czJpTktE?=
 =?utf-8?B?a0prWXprQ1lHamdGM2RzNWFMeUNGeHlOQ2Z2Yk1KQXhDWkdzalIyODl6bGJO?=
 =?utf-8?B?dW5xSEFiV0lVaFVrQ3ZxenE2aFBpYkU2NVptODBtdEdsdk1ycEh3ZFE4VmxN?=
 =?utf-8?B?SlZLTjZHdXd4dW9HSVVhQW9hR3liRTUzZ1lMRWF1YXFwV0dXc2ZZcFo0eE53?=
 =?utf-8?B?TWpyNGVxSU9jc0p6RmJPT3BMSHRNc0h6TTJrRzQvOEZURytoQUhRRVBkWFli?=
 =?utf-8?B?bGdyeFVseEd3LzdQaEZJOEtrUms0TTdYMnJ2WnJrc1BXbUVteDcyZzZ6YzBv?=
 =?utf-8?B?RTB5UG4wV3Vxc1ZCV3dKV2dyUDEvSEdGZTVZYXlFckNwajZ3NkNrN0RGSHBo?=
 =?utf-8?B?UkdleGl0VVdpT3BUWjNORG55cFFQRXRuWGpHZHdmQlQ4K0hUWU5nVkFlNGh0?=
 =?utf-8?B?Wk03LzJEVGFzRXpSb0xYcU93YXhyRG94aWtWaENUQjFnT2ZmZEdOSENpVjRB?=
 =?utf-8?B?dU95bU9keUdMdlpiMkFmd1Vua1BnQkE1SGtZV1EvZkNuUmdOdFVVZ3V2KzY1?=
 =?utf-8?B?eXZzQWZuNG5MUFRBc21yeHg0NHNMcDdwTTRVWmplNWVRNGc5QnhjZFhUZFd3?=
 =?utf-8?B?WGxkcnd0NUZ2bGliazE1NG5MU1BjblNPSE5lYTJyQXQrM2R5NlJROWFCQjYw?=
 =?utf-8?B?RkVyMnU4Z2Y3M2xjOGpGWXBVQm14bHFvSU1PUzdXU0Jia1FWT29UdWx2ejJo?=
 =?utf-8?B?VFFBeWk3SzNZY0tYRHFJS0FIdGJ6UnMwRG1rUXU0bkphUnFZRGFZM3h0VXh2?=
 =?utf-8?B?SURoVW5ZeFhVQzV4OXNwUmFZVjJJRjlqRzAwMGp5NFB4QmhaVG1ScWp5S1FS?=
 =?utf-8?B?WEE2Uk4xaGZ6WlREODI2MkJ3ZUNPemdYV01HL0FsTVV3NkdndW9iTEk5R01w?=
 =?utf-8?B?WmhsUHoyWHJHTHlPZkpNdnZ4UTJySzFKVlhWVVNaVzc5SWIyWWpiREZxaGNn?=
 =?utf-8?B?aHNKL3BML1QzbTh1bXNTOEt4Rk03czJjMkVXNVpOclNWMldwUGNnc2wwUUlp?=
 =?utf-8?B?c3JUREZORDZtT2ozUmU0SURjb2tVMEh4YWxEVndNdXc0NXVhaGplVFpIeFpZ?=
 =?utf-8?B?cm00UU54YmZIcDM4NjdVckxMR1V6UlplZlZ6ZGd4eGl5VVI4OURMRTFBK2gr?=
 =?utf-8?B?K20yendEb2w1USt2eHJacmozU1dGZzVnYmQrRENHQTJtNkhsU2F2OVcvbkNp?=
 =?utf-8?B?N0x0bUljb2pEaW9BY2V5RGx0SGViRWRFbmsxbmpSQWZQMFR0Mm9oK1loOWxs?=
 =?utf-8?B?RU1pMHJQNHlSUnRJdm1OMjdmVkhJYVN3Z2lWSjZIcFp2RVBNcnZ2bzN6Nk1B?=
 =?utf-8?B?dWNMM2ptdWtQQy96TG9PbE1WWVlKL25uVDBTelBXWi9vR0M0UUl1eUJKOTVs?=
 =?utf-8?B?TnNQakhjSXJ0REMxbDZFTHZ0UlM2N1FSOUlqVFIxZ0N1QTg0dG1ZWjFONFZW?=
 =?utf-8?B?aHN1dEdmUDNydDRHVkJIMG9JMkFkQXhlYzlUa09IdDlDY3l6UHh2SEJIWkpp?=
 =?utf-8?B?aWNIVnRBT1UvTnZlN3RPT3pKUFZZWm9kcHRVTlhub2R5K2FFUUVQVFhoZDMy?=
 =?utf-8?B?MnpPRjFxTWMzSk93dFZ5ZUJBRS9Gc1c3dFkyOCt4d0YrelhHN2cxYnp5c1dK?=
 =?utf-8?B?ODVTcTlQcTRPSGwyS01CSGQzWXB5MTlpOHltdjBKVXVIVHdoOWxFcTRjckRC?=
 =?utf-8?B?SXI3bW9MbUlyUjNJRElhUGI5bVVsblBjdExONlFiNXNUTWlKY1dQeXVzQnpx?=
 =?utf-8?B?NWs1R3hjNldjblRKMGxNL0xxNEhPNGYzbjYwaEgvZ1pVb1R5SEp6K3lwTnBQ?=
 =?utf-8?B?dVRXUmNWblJBcDl0UmdHYjh5L2VsN1JxZVZLb1gvMS83MlVpS1dabmhMSHJL?=
 =?utf-8?B?cnRsdmoyUUNrS3Zab3pObCszN3BXaFRsTU1RVkYrbWFLZXRMNjJKVHo1bFdz?=
 =?utf-8?B?VkRKdGV4RUplbFpMblYyRWZ0REg3SVRxRGx5dXJkcnR6bXA0c3diVTcyOE9v?=
 =?utf-8?B?VVQ1T2w2emRnN0lneUxVUnExNGppTnkwMitQRXFrbmQwdGJVNGxtcEdwNlh6?=
 =?utf-8?Q?59IHqs1Ymi4AFjC0=3D?=
X-Exchange-RoutingPolicyChecked: HIWgUOw4eHtgeAFSN8YtLdofkr49ZAODoGLNet62Hn0PjqVEETI4lBUTbyp8OhF0uVBA5tAKHDYlwHh5WnXGn57n3x8ZaAwArUYWRnCYKCWSNo/GuGknLXRNSrWa7i2eGMy0I4XH2/Lvu9PCwYIpH1VH/Il9I6ez4/aXMQatzerJGQLQKvz4SwmApslidGisePVO8jk3tgcvjzeNfF4NywaeReqr6TPR3SuvA8wl82ZNA9seZuOWbtjMRrFIcjURwAE4A2Ol+oygqk/8MsB+99ikW3g2Ka4HaRpgvzOhdou7xp8xBf47UnQ4qzVtvnLNPbAU6QNj48CpApj2M9FvGw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SGA1OFxucnTPqlql9ZeTz6UyUVvm4d8mDjQwTCZ55klUSd7CFyLHVqAem6PfZU7QcTslrRUpzBJCVC3snht9zD2mEZWBhR/XuplEBKORhUucXMR5oJNbKixvLwVekCl2Gj9VQhYsFd3ncWA8AqJWwp/gXAn9ZRsqujG9kSxoV7uijK4VpnyHhGPtmzbFIwEoPh6bB0Vra4q98sVSg8LwIBSpTmeldNMFhuq/d5zeQcBX2fDHzPmszODN4YTxn9scCOtq4SWGOoUnrJyEvzbuEHjGvVR1DrOhVEChQursCnttu5s+PT5MyOQvgPUA0uZ9Fy+oCtV+UUsffdmaiYKIPhaVbnZkCGpJPiMHGznfnjRdAm6MTnnevmuJg4fIrBsCBAl13LTwnSh7XEchlZQS3mOioJg6UsGW7AAtEoZSBN2kOBaFaklJ27cxiv5TTTNqqLXWQC5nFjo+AoT2dn4gfBHjGg36Iy3w5zqHpwtEVAgFqmRJChtXwK//8PVlLazXbUKC6B7fwBUWO/VMugSqBNxmWbizuOQyBDwTNzK44ZtTIvtpxYdZlp9mFP2Ta21XnGRY6ql4jt50qvQH6h+NoOx+VVDTW6ouXdneT8LqsDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0fa449-78e3-46f1-f1de-08debbfd994d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:38:20.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxyQUOv7byVlSyPbCu0GXwftXzFtCQsI2ZWi3NXtqL3juJQo+QvANufPjd7VcXBHA08u3H2DV865dk9KjJXk08QbSZicGc3Ta4bJVme214k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605270144
X-Proofpoint-ORIG-GUID: oh-QPwxoz-ue4_fCGgX6Gd2GBWFxM8sN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NSBTYWx0ZWRfX+t2L72HeJ9m1
 JLxJ8cN68pKrjB33EL2JE+mKtRSJ+QehCIGqx0BxwtycsKJKbFzacKzuuBJVAk7t8n/n1JIUSlk
 255ki0F9fzh9QpRxDOcmzqfEM6P5naICNDMgkCm7seesOy0G7R1yK/wggklhY+hOhOkEY4Xo6uj
 /WxVgIzoOYVdXyjVugZr3j+5q5ozCgUAdOzshIi/bWNHaGPqxLnhQjmGzRvJ8/UU3gsDzXvKEvp
 dmSpxb2cmIw2mUqij+b6bC6r/m16Et9QZruLcheNusg0tsEHSW63BeASWJRTDsbpAFKAGb2IG5N
 y2U/iMQmIj+sLfFWh48A9paB5kR+n0hXLMgAuRwPYAGNwhEhz/otFJ3M8kv8LhNPEhZFYCWCR0F
 0RDiDb3oMwqAo0crItN5mtmRaeEphxQN8rsr2AytmxY0rYJy+IfvODjlaBGObMI/nB57s/UtP0E
 0RjO5hddalalaf51ykw==
X-Proofpoint-GUID: oh-QPwxoz-ue4_fCGgX6Gd2GBWFxM8sN
X-Authority-Analysis: v=2.4 cv=LYsMLDfi c=1 sm=1 tr=0 ts=6a1701e3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=Byx-y9mGAAAA:8 a=YR-Q50pjEDtUzzj6mMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/27/26 5:05 AM, Paolo Bonzini wrote:
> On 5/12/26 02:13, Alejandro Jimenez wrote:
>> Hi Paolo,
>>
>> A couple of comments/questions..
>>
>> I'd suggest replacing the "fix infinite loop" commit subject with something
>> a bit more informative e.g.
>> "restrict command buffer head/tail ranges to ring size"
> 
> Ok.
> 
>> On 5/11/26 7:39 AM, Paolo Bonzini wrote:
>>> The AMD IOMMU command buffer is a ring buffer of cmdbuf_len (a power
>>> of two) entries.  Each entries is 16 bytes and the head pointer cycles
>>> through the set:
>>>
>> Not sure if the ":" above meant the intention was to give an example here
>> with a series of offsets e.g.:
>> [0, 16, 32, ..., (cmdbuf_len - 1) * AMDVI_COMMAND_SIZE]
>>
>> or just end the sentence there. I can fix it either way.
> 
> Yes, listing the offsets would work.
> 

Sounds good. I'll make the changes in the commit message then.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

>>> The tail pointer is written by the guest through the COMMAND_TAIL MMIO
>>> register (offset 0x2008); the while loop in amdvi_cmdbuf_run() only
>>> terminates when head == tail.  If tail is set to a value higher than
>>> cmdbuf_len * 16, head will cycle through all the elements of the ring
>>> buffer indefinitely, without ever matching tail.  Fix this by further
>>> masking tail (and head, for consistency) against the size of the
>>> ring buffer.
>>>
>>> Reported-by: Yunhe Wang <yunhewwww@163.com>
>>
>> Was this reported in a public thread? I have not been able to find an
>> earlier discussion. I will send a follow up change patching an issue with
>> the head pointer handling in amdvi_cmdbuf_run(), so I'd like to check if I
>> missed any other similar issues.
> 
> No, it was sent to the QEMU security mailing list.
> 
> I haven't seen the patch yet so please let me know if you'd like me to
> merge anything first.
> 
There is no dependency. I sent the follow up a while back:

https://lore.kernel.org/qemu-devel/20260512150044.334867-1-alejandro.j.jimenez@oracle.com/

and it was reviewed already.

Then Costas (CC'd here) found and fixed the same issue a few days later:

https://lore.kernel.org/qemu-devel/20260517192314.355499-1-costas.argyris@amd.com/

but they also added a test which I am going to review hopefully by EOW,
then I will add the change to my tree.

Thank you,
Alejandro

> Thanks,
> 
> Paolo
> 



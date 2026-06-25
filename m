Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE79CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcYaG-0001PU-Jh; Wed, 24 Jun 2026 21:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcYaE-0001PK-Mb
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:08:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcYaC-0007Q2-S9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:08:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEXhIv2591771; Thu, 25 Jun 2026 01:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=CKgWPPHYz6afHAg7TBM6MFqb3W5pzZTVI2cSyJ7HEWE=; b=
 c2LXR2nebGF3TeYUipXA9UtXfk7F+2k52zISi9krujn6bDLOp6PExlgu2QDAUQA/
 wCB5B4fkgDTyPz0Sby50lcQjGRVvfD6cZ5VZMTrwwmaHWJB2yRu4aSaqH1rVHpLb
 xjQodF5rbJroKuHlT6LX5vzXNstp1+rbU789wK9rPIMXl4uF1lgWBqEPlB8Aeh0q
 eMjL7tcTguplLzjRm7X0ePuKhzBNSvQmJ9S74iqCoEb1D0vpz9LfoHp87p7qPrJ3
 xoEcWx17dpUQOZDI+NzmVXLDZ0rMdit15qHG9FY3jqkhu9RygWRBZeMAJasWbEkt
 czw8ysCizRlSTRyuh+juWA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1pge9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 01:08:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65P0wKq8009814; Thu, 25 Jun 2026 01:08:41 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhae66s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 01:08:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhxO3N9+zj5/7B+3hestbmd7rqF2XJTHsICbohbHeczK/roHgTXCv4CisGbLrWcvhhq+toyhxFhfp8jyQOWj3ALcLcySU1wXNmWFZA+4zwshwZtg3hSPlxlOPtWIBLAosGcm9ej3/O8xNpOKcQLDBbeiyas3/MPO+8mQpfmJo5uB5HxvH74ilJw64JhiF9QzxHaLrfLToVjcgRDj53Vwl2rGOPAB81dXyYvZZrV7W07ZSujXYTzv7SMWKjTLdvif4BxK3e1oDts/K+L0p6dIPSj/XyEJEnoj24o7SY90IyqBbOA7yYXG4u37e2pFk+3tYglB2X69t7azVw1goRPdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKgWPPHYz6afHAg7TBM6MFqb3W5pzZTVI2cSyJ7HEWE=;
 b=aI3dTN9765LFOIbD7EYC+CvpVlz8bhNGgor9bFtQ18gK4NtIk7BHQHmCbphEOup/O4w7AycsbXtaXw0W3PdX8TqorzZp2WRHiFQrW3GI3SgoFDT+jmKd8YhZ7ZuJamwb84jO4P9hTJvWV4XPy/EJpuRu42LxPkP0vhD1y/wD5AxrqwDbB3XSt8hNVC2fv8vWOtgIbl4ijkfQszAnWcS+rvyAQMZzy58h4NjvniU6IVUT3LVqUjM7hlyUfS4iaA+NUjyuT00EI9TMEiiWwIzpgYn0CBn5ayK7mtxbmoN0uiDQc6ZNn9K5UkPaJrZAwYOhBZu3KKD6zOl5hL5RchQAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKgWPPHYz6afHAg7TBM6MFqb3W5pzZTVI2cSyJ7HEWE=;
 b=GAC3jMffdpcUUJlSKh784TVJwfaL+//XqK+Y1VFpuB7KwNY/NYEpAs7VcZBtt9H1KA0ddZORmvU660DKXhNd6A/B6MZeVKZh76pFeE4GLH+xxYmpvclkRCbLMbVsdfaZRWnesYH2Ob7AbDqbKdSHfxwYzsuHInZ8xbkUEToZBRI=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 01:08:38 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0159.014; Thu, 25 Jun 2026
 01:08:38 +0000
Message-ID: <f188a24e-631e-45fa-9b0e-0b7fe3469369@oracle.com>
Date: Wed, 24 Jun 2026 18:08:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peterx@redhat.com, maciej.szmigiero@oracle.com,
 mark.kanda@oracle.com, bchaney@akamai.com
References: <20260621072646.517545-1-dongli.zhang@oracle.com>
 <87v7b8neml.fsf@suse.de>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87v7b8neml.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:610:e6::6) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b000f2-6cdb-40bc-39be-08ded25649c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|23010399003|3023799007|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: VIzJfgYpvzO/OExhETmc0CrgySgB5qO9gxZw58A4LdY10wWVTeh70xrxA77xnKWZxXnH1TaOMmTgajLQu1A5h0KWBcxBifkGvt230IshBi6UoGOdxM3/EbbC9JI3QPjjrvI60wnQYHVC5C1jfGfzXG77bHNDtKYepf7jCOZgmzln/qrUvgy96l8Qew9WmzwJXffQOaGE0HWBjbhbcpbWkiWOhyZPMU7bneXwAuyvV/GKlADrDbIQZ5O/GKDgDgUF4qN2AtWJnJB9nC8o0mPYXP/rDo8Q6cE57n5HohP9tQte9O+6EKeFRTTqJ2MfSXNy569zpwT7h3D5Oz1pPx+VRaOv2J40jIKc4rcoV82SSVTCOv3BkSX1WkZI40YDFveToiYnH7B7mPEP5N9XSnVU4wVt7wB+gWLBpvXpYR6okk78c9guxFWiHElt3mQMFV3R5zdWgWhcowqUFBcxsEi15BuLbv/grwQEM+N/tUIkVdcxzwGU/3TKfBVKDc1m99HrCo68RgjXJPMJtTPjtypmHLp5j72YuD0oGcD3Hlhrvr58oZaVoxDz36oqZwcM/e92lDF2vfp9u/33avC+9voHQGOSEm9LDT3bfANlf36fEGtBqM7XOe5jSU8lLEfbwsrvfqBmZ23DQ+YF5ZeG7aUK3T4fkPgK4AnjRGj2Bj8PzSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBubkJiZWxKRjhwS3BrdFNuR1VWS3lXZ3gwaFhaSU80NHNoL1I3MTIyMi8x?=
 =?utf-8?B?ZU11U1VQeDRsbWU5dERTSUc1R2oyMmRQRk1HaWF1Q0duaTAwZFVWemVveEdu?=
 =?utf-8?B?cU9WaGoySjdlaHFBaUs3ZVlER2ZzWWdNQXljaUlISzZQSzN4djdiM0dLRndY?=
 =?utf-8?B?ekw2Z1N5dmljaU8wZWsydG1wenY4YWpzOHE0NlhJYkt4alhPVzIxcWdzQWV4?=
 =?utf-8?B?bkVYVWJnTVdEbjdmcng4UlE5cU9nT3pEOGVvTzQraVdvUmxzV0JKV2ZLaGVx?=
 =?utf-8?B?bXcxMGpGU0tKUWxrUVF3SDdUWGVObHZVRnhsdUNSbG5WSytzMTNibDFQVStF?=
 =?utf-8?B?S3Q3RWNOOTJ4SkFWTmJMeCt3cmlQQTZxZ0F1V055czdLajlyVkx0cWFmVHlR?=
 =?utf-8?B?b2pJNXNqL214emJqS3UyaWJRRnhqaFdaMVI4NEkvZlJQQ2UrVTF2Z3cyTzc4?=
 =?utf-8?B?NXl4bGhSZCt0Tm9ReERIcW14aGJSTkJua0N0VlBjWFI3RVdNb1lUN2RXZFJY?=
 =?utf-8?B?eHlGdW5LL3Y2MW1mZXVRRk9CUFZsUytRaFlDaFRtRkVRVHZ4cjZWQnhmTkRs?=
 =?utf-8?B?Z3Ird2x2YzZDU2V1QXZGNno0ZXBHSDBUQ2RJNkFDRml6ckFKRTY1VkFrNHF2?=
 =?utf-8?B?dzRLSkJoMnFYRyt6ZDlXVjY0eHFaZ0w0V1hJVzd1eVl0TEkzY2lLc2RGVUo1?=
 =?utf-8?B?L1lJOUJRMUZibFJJUlJ6YldhbWJwU2loK0lnbEZORm9xUlV3b1FaMGErWndS?=
 =?utf-8?B?dzZWS256aWFPbUoxNVJlYmRvZ2tIeVB4TkQrLzJBMGk2UGZzaG5EN243d3Zv?=
 =?utf-8?B?UWpjM2sxNEJ1cC9sZ1NTMktkcDJvWWJOSWc5QUhjSVZKdVlhM0NzWiswdzAz?=
 =?utf-8?B?SlBQeDRtZWIvRzIzWnpjZTBCc3FGNmN6L3ovREQyQ0U0UnVPNDhGeFJ4SWVE?=
 =?utf-8?B?aXdWWGpxQ0F4bzRWNEF5L0ZvbWZ2ZG1TaE5yd09Sa1ZHNWgxbVFFU1RWakIw?=
 =?utf-8?B?TXllcytnU2pkcE5pb1J3ZWdpRk1UdWtBWjg2NzJJMWVsMWswMWhPQytxU2VS?=
 =?utf-8?B?WjgwMzQyb0hleFV6SjExbGF0Q0lRbGI1d2JlaDVsNGZHcnNnMU5pWFlwQml0?=
 =?utf-8?B?TkxxaWFUY3I3Ry9iVDNocmRrN3ROR29UdkpmUDkzelU4WGxyanZUQjdlbm9U?=
 =?utf-8?B?aVVCNG1MTWdiQk1TSkpGNGtsdHJBUjd5SjRDc1hTUTZOR09XNVVCa2J0Z0d5?=
 =?utf-8?B?QlR4YXpRbDYxMDVua2tZNXFZMUQ0Tkh1NkVYRHVPM3MycWkrcFhGck01eTRP?=
 =?utf-8?B?SFEyT01PM2FIK2Fib2RDUGJFbVNVTTY0cnJSQk16MFVlRUxGTmtZUkxSOTN6?=
 =?utf-8?B?M3l1NEE5dzcrK3RvNjM3ZU9UNzVocXpodDFhajdneU1raEp0aHVRNzZob0xr?=
 =?utf-8?B?bFJHUHpKdlBKWnYvcUs3WGgzMmxXVmtqbGtXZ0hJRDh2MWU0VFB0VUVnL1ky?=
 =?utf-8?B?eUg1TGVYa0pqK3FBTUwxbzZJeTlwNXpURXBuL2lEblFoaFd2aTlUdC9nUXZ6?=
 =?utf-8?B?TkhERjlDd0gyTnRNejhIcHBmKzVYMXhmRGhCVmlOUmRjZnlkMU5BemhiQWtS?=
 =?utf-8?B?OFhhdm05eWZiMkxjRW9vbGlOc1ZzczU4VURQbXphTGtwZzB2VU51dlBnQk54?=
 =?utf-8?B?MU40VlFvRStYTm1YYk01dU5kV1AvTGZ6MjZabkhKM3hCV2pLQjJGdEt6VHJD?=
 =?utf-8?B?dUJsQ3hoNkhyOU16NU54TVNsM2FlQ2RIM1Y3d0pyU1IrcklWQ1l0bXBMcXFw?=
 =?utf-8?B?dUR2M1RTNW9FT3JVZTZkUnhnUEVGdjM2SzF4VmdnMU5ScHNKVHhZeXhHY2E0?=
 =?utf-8?B?Snh6SkFLd2FIb2o1aklWbHl3bUlNRnBkOG1jazErbmY4M2pIaEtmakp6UWE4?=
 =?utf-8?B?a2Z6eHBSSlJkVWxXamZqdUIvalBxRlRGRVlYLzM0dFpjZUpUYWE2bE9UOTdv?=
 =?utf-8?B?SHR4MHlraW5LL05jalJUa1Q5eFg1SUY1cE04VEdVdmFUZkUySGdBbVludW8w?=
 =?utf-8?B?VzdSV25WZWdHbmJVOTFTaXVDN0dhaWx4REdudXo1d3h0Nk50YXZBQmdDeVpH?=
 =?utf-8?B?em5PL0ZTUTR2TE5pS1BzUWFiOERvZ1hNd2lCWmJucFAwSjlFWEZyb1ZCd0Vn?=
 =?utf-8?B?a2dLOWtIQUpobGVrMkdzZ2lrUmV1RjFGbTd4UWQ5QmdxUW1HYmFvSndROUxZ?=
 =?utf-8?B?K2pLNko2ajd1eUw0V2x6OEhHSHA3YkhKZ2RKUUNiam53YStWc3ViaDZCV055?=
 =?utf-8?B?dmNOQUFuRE5JcUdReTR1Zk1XRmFOYVBvMDM0OXd2U09HUEM0am1hUHo2ZG1U?=
 =?utf-8?Q?hpv/4tw7orQXvsSnIYICwaMxUhDMgkx1eB67b?=
X-Exchange-RoutingPolicyChecked: TQzCif3EJeWeFYbFnLC8mJLM91fRi2ECPr2lTYFDYfW8/S8zs5XA/PuPUNZNHd85WHwStJ+2rwcsY1Fqbp7Pv8Z7aWNdPCMHh4+kWNBqzgvwcie6nvTiprCnc1V2foxjXUcDJCBUedLIm6uwMQo+Z4UKXON8kN0cbxQApDFrPIdLtocQHOf97nlxOWYhAxpjWGO6DTOYvOz2qd3Otf80fz3/2nbg4ylmWWt+tj7KYZgqN1b6Tl49xZSxRcXrE6mNbnB8mXKRtJMMyz63ii/WvXf6XtcEb89KtFD6HztoGiUH5teJmj1qvi/IWSCHBXc1y47pYQlywmCda5sw4zixUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jTcCsnxqVGcOLRQ24N9THvrFgFPOvK6F1IcvOyDYMKTCsTehGnOHV8vynQn/3PHp+f2+lSxCEZty0FjdPeTIWcKixqQPYgDY82b49uvOxZot/yYjzvFzXeQCXWga1OHlQc1eo+Xmu2OStFY8sUzIYNqU6GZuq6z3spW/OQI+kPMhNRSPvQ69Lr5OzkmxQMHmL5d1LuIw3rRYpu2z1HHBA+JtJU4Pm8jx/gXLDLxnoKX5pdLZvQONOgDuACgN2cAby8YMZKkhy4Ydx3QrCXBzcKFSkJt1RW9Mwnc+fKxfmf9njqM+BHu8+S6Lqoj/tMrktwY2u+Usf2UNH5mHJ2Y9lwQ5x9vOJwVvCFkM833+CFJmnoz59+t5ChWSHuenkdJuocIMSHjYFaO8eFTq4l8I6XEyvJvA3Ep6McG6LGI6LEbJxQ5Ll0DLUH/037+qbsdF/XjkMPwgQySXX13VdqR9FqENICKqZ7c+B3+pEAiDgW1ElHbj5jaJUl9qD03X/fMH7J5vXExDQIlTYw5g3SK5df5IvFtbySLtl0tklxxQx1q5XBQLyIfkCIVJ03lagT/7QDWmpeE0ZASqKcAUcc3r1I5TPiw+99z26ZOuBkHP+gA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b000f2-6cdb-40bc-39be-08ded25649c4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 01:08:38.0853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMiLl0Qj6//AFSZhWkAQhOfuD/Fwdps/+nkpQ1Kz5g4nAK9EdVhykbnKDER+H2zg4Pk3hGKNb66Dl0c5wsReHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606250006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAwNyBTYWx0ZWRfXyxzXd4/95xxP
 UEQG5Im4eN1iw3rWONv0f1iPN5j+RsIUSwm0sIYgGBdL3BaktyuBt/TFn9be2MVaa7RG3AON7TG
 khnXMBnzzoEytejtnL0Ae8Qq50UPgH7k0Aif8kVcAzuLhj8ToWmvYcmk8MjMObqxFHYX2nThrBE
 UYiAqfBNVxtq+FcBIwYNncbVslFmqt+u+fPIz4lJKh+iwziaGYEvfD7zP3/Gto5/nKqm43Smt4I
 kdt4i3emPmTN00faV9WEa1Ob25KOD0RH7rl4pyAdKCByiuMhNXKB16bY24KhLl66iU0LbVJWw+y
 jGumUVOdUhIJT8YcDAHwlyLqcG/cPxzzVP+vPjdXfTIxl744aQULhzwkygNuAdQPJ3CEEuGnE45
 VOzCmIchUR24DzakHc4eWBB1WeqKYHOxKuG4zJ0aAzCnvfAt7hl6qhWF3/emKC+4BMMGvzpAkVT
 oV3YEcZbAGo53JAQwaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAwNyBTYWx0ZWRfX16c8+7g7bqfV
 dY4+93HVO/5wfcxRrDmWudFyI/RC8/J6pjG2BXrseDXJTyANKVSZDWpfzxRtP75zkfIn5/nZOrI
 JWwhot1tsCmAAOR2KugOnFOIUbKuwsYdHRBxlB7RqQ8hCd5egnkB
X-Proofpoint-ORIG-GUID: TKINkpQ198PWmDEn_szCM_mGzyt9a0XQ
X-Proofpoint-GUID: TKINkpQ198PWmDEn_szCM_mGzyt9a0XQ
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a3c7f99 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=xKc3MhhXwfuCKlhb9wgA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 2026-06-24 8:26 AM, Fabiano Rosas wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> Currently the cpr-transfer source QEMU instance cannot be driven entirely
>> via HMP.  The source must use QMP in order to specify both the
>> main migration channel and the CPR channel.
>>
>> Extend the HMP migrate command with an optional CPR channel URI. When the
>> migration mode is cpr-transfer, HMP uses this URI to build a
>> CPR MigrationChannel in addition to the main migration channel. The new
>> argument is rejected unless the migration mode is cpr-transfer, so existing
>> HMP migrate usage is unchanged.
>>
>> For example, source QEMU HMP commands can be something like below. The
>> "unix:/tmp/cpr.sock" is for CPR URI.
>>
>> (qemu) migrate_set_parameter mode cpr-transfer
>> (qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  hmp-commands.hx                | 11 +++++++----
>>  migration/migration-hmp-cmds.c | 18 ++++++++++++++++++
>>  2 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 7ae2468a3d..021e51b142 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -928,16 +928,17 @@ ERST
>>  
>>      {
>>          .name       = "migrate",
>> -        .args_type  = "detach:-d,resume:-r,uri:s",
>> -        .params     = "[-d] [-r] uri",
>> +        .args_type  = "detach:-d,resume:-r,uri:s,uri-cpr:s?",
>> +        .params     = "[-d] [-r] uri [uri-cpr]",
>>          .help       = "migrate to URI (using -d to not wait for completion)"
>> -		      "\n\t\t\t -r to resume a paused postcopy migration",
>> +		      "\n\t\t\t -r to resume a paused postcopy migration"
>> +		      "\n\t\t\t uri-cpr specifies CPR URI for cpr-transfer mode",
>>          .cmd        = hmp_migrate,
>>      },
>>  
>>  
>>  SRST
>> -``migrate [-d] [-r]`` *uri*
>> +``migrate [-d] [-r]`` *uri* [*uri-cpr*]
>>    Migrate the VM to *uri*.
>>  
>>    ``-d``
>> @@ -945,6 +946,8 @@ SRST
>>      query an ongoing migration process, use "info migrate".
>>    ``-r``
>>      Resume a paused postcopy migration.
>> +  ``uri-cpr``
>> +    Specify CPR URI for cpr-transfer mode. It must be a UNIX domain socket.
>>  ERST
>>  
>>      {
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 8b385f560e..42ca652bb3 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -836,9 +836,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>      bool detach = qdict_get_try_bool(qdict, "detach", false);
>>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>>      const char *uri = qdict_get_str(qdict, "uri");
>> +    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
>>      Error *err = NULL;
>>      g_autoptr(MigrationChannelList) caps = NULL;
>>      g_autoptr(MigrationChannel) channel = NULL;
>> +    g_autoptr(MigrationChannel) channel_cpr = NULL;
>>  
>>      if (!migrate_uri_parse(uri, &channel, &err)) {
>>          hmp_handle_error(mon, err);
>> @@ -846,6 +848,22 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>      }
>>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>>  
>> +    if (uri_cpr) {
>> +        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>> +            error_setg(&err, "uri-cpr requires cpr-transfer mode");
> 
> Most users probably won't know what an uri-cpr is. Maybe: "a second uri
> can only be used in cpr-transfer mode".
> 

Will do. Thank you very much for suggestion!

Dongli Zhang


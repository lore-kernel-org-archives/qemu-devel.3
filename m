Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB19CE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1Ce-0006cP-Il; Wed, 18 Dec 2024 16:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO1Cc-0006c4-JH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:03:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO1Ca-0004PL-OJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:03:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIbDt013072;
 Wed, 18 Dec 2024 21:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ppy+7nhrlpG0bBv25N7r1G8z3f2WuRTdN85AP8SNE8o=; b=
 a6C7lKv9RugBg2HnKwV1DvyduguNODiUVWy5a8Rg0+oQr8VLTGjm5NhfZHLAHYgk
 KsjXnL5MGUQhVGwDMhWOs2CyfwMb5Ipo5F5RzMG7msV3VEMXkaAjltAZBRreChEs
 nb5IDxsv5bYK41k1f38sVpPeO4etHdd1ZPKBkQiZUULus0WfUMCvyY7fZ/o+BCDn
 cpIJvzhrM94YC/GKnq90ERlMPwvVxcUFJhwSgmNyXYdmNFBb+l+xxKoi+mB8sAqg
 3XUk2mrsP3FDYa7iwzkC87TO62EOfIfZ8S6qbLWhHLnKMNCJEPM8RRoHalG9BOZi
 CU6/F4uvp1QU/RpgZNoksA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5fehy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 21:03:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIKAY2X010969; Wed, 18 Dec 2024 21:03:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fa7bve-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 21:03:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STCudG2szb0j3muWPGOdNXC+emECtS5Y1KINktuO7yDqMARqHndjGhj/PPEk0rSX7XAMESXDLYA0AOTFysC9TbsGU75DsJO11s5pNA4QAJlVp2mS+0IYd0RzgNPXgmNtHPbz9AZe5n3PMPSs5oSMiFClsyNDGq60zSsr1JQYDQpASX+NOWbcXvOhLuRPrNwUlj8ue9vpoGkpaXATsWatX1ifpesdnRqknAa+H1m5cMSakDrGuJdqSM/UCIEfm6frHCGAcmXLVkAKqYzQGMXzYhr/v/w1RVNcrugGG5Z37FILwYNF2JT2vdPbA4xwgYz/n2BnmlAXRrMd84f6L2hVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppy+7nhrlpG0bBv25N7r1G8z3f2WuRTdN85AP8SNE8o=;
 b=AkMxxJTIopW3S78LrNTwPidc8HnhR6ptCnLCJ6kOoTtlma+h6lejG5El5zYSbJZXISclmWgE0/+EwUcDkpEQXCnl7rKEhOlz7GNUSzTvylFEzfX8x2eHmk/7IDKtbQ5PwDmtEdL53VdwkVzW3yJqACW/KRrHfhaGhFURK2JRv8BEFvzxz4wufgOsckGPP043qUd9aqTYr3v/u4V017+iU40oywIgD4F3i+v/QEusn32pe3uDmAcKS0GujdmZcrpiMOylzXEZ/0uamea2/IIEvvtQB3XVOkTcaOf609AuDB1yYQgGA2ynUp1vDeY5TCzfYxkI0aoSEY9a20eF7PpDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppy+7nhrlpG0bBv25N7r1G8z3f2WuRTdN85AP8SNE8o=;
 b=CsdEALI+HtY1WqTahk4YKuDfHBMEPuNR7i4h3mgT4HqfPp88cR/bfEqocMBJYIGJL4EHVaAyXoAOnMH4ilvH29jped7AHMZoIkItH7Gz2LQiEp/GZ2JVkQUJ5p9g2WH5A6WXaVT4esR9RxQIIYzj/CWONunBXy4qVP0QYPMWjjM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB6763.namprd10.prod.outlook.com (2603:10b6:610:147::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Wed, 18 Dec
 2024 21:03:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 21:03:19 +0000
Message-ID: <dbc90629-194a-4461-89e7-2073a97dea6d@oracle.com>
Date: Wed, 18 Dec 2024 16:03:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 18/19] migration-test: cpr-transfer
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc0bc1c-b415-4a67-1441-08dd1fa76627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0F2M1E2RXR3bk1nTzVWaGI4VUxKTDc1OURkeE1qOHh5MEJOV2k2TjRwTjFo?=
 =?utf-8?B?ZGhmaTZlaE9lRHlCbklWYmJESzBVN3dIYk44bFl3OHJxZ2xndHRhQ1VGRTlh?=
 =?utf-8?B?REZPcGxua245S3FEMUlrL3FEakZNTWVLc3FzcEJ0ZVg4Q1VXNlgrNlVZNysv?=
 =?utf-8?B?SngyTE1FaVdwak1qR242dzhqTWo1cGpsUmtDakZXMEFZbkp5elVYTWdwdVAz?=
 =?utf-8?B?Q0RTWi94SC9GVWt3S3ZsT09hanNTVlc3T1hvTXhsNmFEMlVyc213NXlYYk9Q?=
 =?utf-8?B?OXdBV2lZVkZKSmU1Wm5YbUN1cDQ2UlVHMHNoeHNFaVNRemJ3emZGV0lLN1Zl?=
 =?utf-8?B?VGRsK0RoczNtTHJxbVFRaUErR2VEOUVvbHhzY2o5aTAvOE9EWm5PeFRDRytV?=
 =?utf-8?B?OWtFM3F4aHdKRXpiWUlYMU04cG91L202RHRaVFowMlRHZmF1Y2VYMURsNEZq?=
 =?utf-8?B?ZU9VK2F2dDZDRS94bXl6VVduaEo0aVEydWVhWVZ6Q0kyOFNUQVZZTU9NcU56?=
 =?utf-8?B?aTg3MzhJcUVjTUJ3TVBEOXByYnRQUTdSaUtQdWU5UGFjYnFpYUNRNlVCWndG?=
 =?utf-8?B?aXlaaWVOakxSR2lSQXFTQTlBT3E3YjNOQ1B3bTRqVUNBemlKdXpCaEJoQTJh?=
 =?utf-8?B?Q2p0THJ3emNMYVg2OXFicGJsN29VMTErbkhlNk5DcDBNL2xiSHZHalJMZUdy?=
 =?utf-8?B?UDQ0bWJvKzV2a0F0blJPR3h4ZGVFT2dydzlnTFBxekh1WWhvK3hEWmFaOThY?=
 =?utf-8?B?d1NVYXZaQm8rV3hBZXU5SkI1NWVCVUUvNmFCNUlxRmg2OVRpNmxGR3FibHZk?=
 =?utf-8?B?QVFrM3BpNEZwOG9xeUdrVWp2NGsvenhxZGJFM3Y1b3FISjhveHRWakplMEJi?=
 =?utf-8?B?ZnR4a3BncGQ3cmlNUGppbnJmOW03WVVIUFVIVmxnS2lvRlpTalN4UmZ5Ymdl?=
 =?utf-8?B?dkc3V0hJd0xXWHNKeGNCS0t4UlA2TDYvdlRlSGpRbUxUM0U3SXloRVpyemR3?=
 =?utf-8?B?czdFWlFGREVMTzNXZHBxdThva21JMEZ0LytZYzQ0a1Y2RzJLNGcwdTRZQlNX?=
 =?utf-8?B?TXFIYWIxbXg0bWliYkMvSEJ1NWcvR1YrallSTUQrUC9ZZ2lreC9XSGEySGZk?=
 =?utf-8?B?Q3YzcHFvUUFTcWpRUGk3aXFPQ0xyR0hTelA5S0VjblVubTJyZ3FibGlFL1Rp?=
 =?utf-8?B?SlQ5bDhBYThyTjRrczZVWStMNmRGckFCN3Y5YXRNclhycUMxYWtCOVhWbHV4?=
 =?utf-8?B?V1lobFlnTjBzeXEyT1FMRTcxWFdyakI4UTd2Y3ZDZEYvWFQyUnRmU3o3QmV1?=
 =?utf-8?B?Sm5xNkhQM0VwS2NJalE4empCQm9KK2FuRkk5NDM1emNnSEJnWCtYNmdUOFBU?=
 =?utf-8?B?a0VkRThtVkJ0WENJeThJa2kzWXVTazBQMUh0S09ubW9IckwxVUcxNU5VM3RG?=
 =?utf-8?B?MjNPWlg3Tm51eFNQaVlITkMxb0lwWjEwQjVXeEhNdlNidFFTRWlLQXlJNWpm?=
 =?utf-8?B?TTd5YUlCWjhoUHF5MVdzZFd2eHVNY3B5M3FTSGFVQ0tiVTFCeXduWkZLT0ZF?=
 =?utf-8?B?SGtURzFMNlFKT2V4eHJoY2pSRng5aU1YbFVTNGVzUnA5WFBVcFFiUFgvT1hu?=
 =?utf-8?B?Y2lsamk3NlFhUmRCNmh4dHFHMm4vcVVRYVBIMFRlVVNFVW5yR1RrMG5ETmRZ?=
 =?utf-8?B?KzVzbHFiNGtJdW5WUFI2T0VVZkJId0pIbVBhOEVtOWJ1OU5qTmlrRVRyaGxS?=
 =?utf-8?B?QjJWeElDWldkb0tiTEEvaFVaZDlLcnlHOCtVUGUxTys2M1UwSTZIR2FxVFhQ?=
 =?utf-8?B?RWR0WnVNakZrLzJ2Vkl5N0Jxa2VoK0JHNlc5WHMzaFpVeFpaR0xqYWdvdGZi?=
 =?utf-8?Q?dobQsBg0De0Ib?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGk3cFVUeDh5ZFFsR0hvK0wrRFZSUVJBL283Umdack9KbzFKSDYvTkVycERQ?=
 =?utf-8?B?Ky96anJxNFRTMG9yV3pPTjFpRWwwd2VHTkVEdjlOSzVmMGVWNE9tMGVCSzQv?=
 =?utf-8?B?Vmp5RzFQek5rRTdqMFI0aE9LVEd0dXJuUzd1b2R4Z1lXTzJpZUdKLzM4OGNi?=
 =?utf-8?B?NDNmaUFLZ3RvbWsxQXZVajF0M2Q4N3I1WDl1UHhNUThtckNJT1JQcWEwRS9V?=
 =?utf-8?B?V2craGxGQnBmYXAzUU9KMDE1VFFnN1VPTVA4elFKZzNTanNaK0N4UVFaYmFy?=
 =?utf-8?B?bVhwd2tsbHVWaHkvY3NTQ2hKRis3Zkp2NEk0Y045R3loODFPakZZd3NzMytZ?=
 =?utf-8?B?Zlcybk1wNi9GUlRSV25NTEJRZGVHSFRrb0UxdGY3V2k4N1BYMk9FUi9QUjI2?=
 =?utf-8?B?WmJLbHhCVGtuTkt6Mi9YeEwrYWorNEFabGxsWW92VGVPcWdrK2VmWkhaTml4?=
 =?utf-8?B?aSs3S2tzOUxHNDlIS2lOYllCVXFrYWhrd1cyNGZONGphYjZPT3ZKSVpqcUZI?=
 =?utf-8?B?dllMenpLVGlnVVA4NldBQ2loZFU3TlhCME9weDF3K3krQm1QVHBxY0lTN0h1?=
 =?utf-8?B?TEdCUXpKdFNpU29IUWswallCMUdOdjBQaUZJbWFibExMNjJMdmU4WDBqbFhy?=
 =?utf-8?B?Q2xMMURFWTN6Z3o0blcvOEw2SFM5Zm0ycnJJQ09qYW1pRXFhVEs3T3FUMUtt?=
 =?utf-8?B?dHZiRVFIK1c2VVZlcitaSWNEbmVwVUtISnJTVjlBSmlwTlVFV25ad1ZXVWJZ?=
 =?utf-8?B?R0hqbitGK0lIc1J4L3JtZVk0a3pKV21vYnJxdnRmZVdsZGNHcTdmWm9GSTA1?=
 =?utf-8?B?Y3BXRWY2RTdqU1N2SXpTTGsvbGoyUG1idFhlQnFKYTBsUXNnSVN3Zms1UnJO?=
 =?utf-8?B?Vm9LR1BXS1BVdGFnR21PRVZpZTVzcFVoQkNPbDN2c3FTcnZrSHRkZ1grUmRV?=
 =?utf-8?B?Y3VUTU4wZjVsR3ZoOU9IUmlLYXZzVVVMNmV4VlgzTW5PcnZrZkdYanUzTUtV?=
 =?utf-8?B?NVVxbWJqK1lUdE8wLzNmNzRwV2l3bEk1bTM2VzkycXpIR2lvSzhwNzRNZFF2?=
 =?utf-8?B?ZmQ0clZMN3JNYkFDNzVXWjBHc1ZJVXJvbU9HWEJNc3pSYlNSbkhlZmR1WU03?=
 =?utf-8?B?bTlPVSsrS2ZObHk2elhPMTBMd0ZCZ0ZSUUp1dG51d3EyU0lGUnN4cFl1R2Jj?=
 =?utf-8?B?SkwvcVZ3ZUNtZHFDMXUxTGozUkZnUEVnaG02N1BhSkZrbys3bE5UcnlEbFJn?=
 =?utf-8?B?NnYrdlF4eUhrN3JQVTdMNFdhalJDNENzOVlTQVZyRndHR3p6TzE0NEI5bEZF?=
 =?utf-8?B?bHBwNWg5K3hyMUt6VThHOXBCdnNtT085anl4U3JZVEhIOVU5dlJMQlduTWFt?=
 =?utf-8?B?OTNlclN0Q093aDY5OEwvU0Z5cm0xM3lCREFqSjdlcTZaSGd1VXpWbCtHUkJ1?=
 =?utf-8?B?TlFIRDB4SCs3WTVXRHk2ZVdmWUVmZ2JQanRlRkRBaWs0bkJ5cmFLTU54RE9s?=
 =?utf-8?B?d1R0WHlJQW9wMmhrSFdNSlIvSXlJU2FOSllyRVJQcDZDbmt1d09BenJMd05N?=
 =?utf-8?B?VE5KNEljM2dpK3gxN3V6YWlteitWdkpCN3JiTVgxWnpRYTJSWXJ2TU8vOVpn?=
 =?utf-8?B?OVMxczYvNGdSaW1GZ0RHT05aRGMzRjd4djZ5Y1R6R3NNK3M1UGhBVm56NDIw?=
 =?utf-8?B?MTVKdWFTemRQOVVyN0RZQStYNzhuUDE4d0x3VWVydVVsQnVUUHZienZlNnZD?=
 =?utf-8?B?SVo1QzJtUVFZUVhVdGxIYytWOFpLcC9vRjhNWXhucyt0WlE4L3pMc3hCT0p1?=
 =?utf-8?B?VndRODZGVU0raWpnQ1oyc0IxN0NtQjRtVmdBR1dxTDQ0dGdxK3U5bmhBOW1O?=
 =?utf-8?B?MEZ2Q0lnYVdOZ1pua3MvaWtVUjd2cW1JT1hOYm9EcWNjTjNybTcwbTQxaUU1?=
 =?utf-8?B?NlFva3JsOXArdEVRRHVDNnYxZEw5UklMcC9yaUhHUFFnSzI5c1ovazlLeFls?=
 =?utf-8?B?Z2NySjZJMm9CMjdhTmthQUl4Q2lVazhUNEl4SXlKK2poRStFcW9NWXc4MGJE?=
 =?utf-8?B?aDhPYmtOeFhtangvSmRlU1JRdDE4aUQrQVFvTW5XamZJa3BObUsyb3g0UlBt?=
 =?utf-8?B?WjAzanZxZndTK2V4dGNPV1lSRE1pYzEyWWZGUnhwQVFGWmhYYXVqUGxsSEM4?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VupyTBvInNJ6AdYMaxIH/bJ1emVZnpPqMMYSk7ua5988ERnn2BXfmQkHS4DIc5UqlWyv3CKrQjsbkCZI3BOule6UAMc41YRykKawFMvvelyaUSsR85zAxBwjkrvGpUhHJhNoZuwCOe8DscPjjpoR3u6+AL0o00eUuqg47S8SrV/iW2MaAURfjk6ZNLYzdpzOkvks+PsrEoZra0ggUR0UrtKFIZFcRnUyyoMmpNd+WIhy97zlLHKdllMgrLLR1gOIoKgK14JYuolRXNVM29dQJVfrq722cYuALSdmx/UJzHM8vYW5CLbjukyQ6y9iwltPeregU37pdJTByTUR/aJWvusGtMFumzp6I52RGUf09EPleR3YHrvll/Xb15raTJbwsRwdPTX1i/eGdgleJjx1wmdRAeaPexAjGL5WiWC7b6cwIMrgprDAeOcVnGAH2OziwcFuOshFgneT8VJt8btUURbhbdn0AvJfxkK0QkSKo/dn9C0DxzgtG3/pgk2gQnJQe8iRwI65Z+nN32bhxOOjOX2tW6OMY7a45VfuwGDq5MuJQmAqW2HLnCJI0FXJVS4sMbTnivNTDKZew3cRdy/stW4O/5f2N+wmJbbruaKP/UE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc0bc1c-b415-4a67-1441-08dd1fa76627
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 21:03:19.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vqsJZWIhx7DpWU1x/5uzMHl4CiJ8V9EEEM/dcU9hPXpr5tV8net0qrkYu05T05EyoGD9Jj3PI4VIGsmGBI6kWYTaYgRLGYdcV5eScShgrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180164
X-Proofpoint-GUID: MFHdvQPVolAO8V79Ahslt5M4RXhFVM9f
X-Proofpoint-ORIG-GUID: MFHdvQPVolAO8V79Ahslt5M4RXhFVM9f
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If someone is bored, this needs review, else let it ride until V5.

- Steve

On 12/2/2024 8:20 AM, Steve Sistare wrote:
> Add a migration test for cpr-transfer mode.  Defer the connection to the
> target monitor, else the test hangs because in cpr-transfer mode QEMU does
> not listen for monitor connections until we send the migrate command to
> source QEMU.
> 
> To test -incoming defer, send a migrate incoming command to the target,
> after sending the migrate command to the source, as required by
> cpr-transfer mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tests/qtest/migration-test.c | 72 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8bc665d..4eb641c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1729,6 +1729,7 @@ static void test_precopy_common(MigrateCommon *args)
>   {
>       QTestState *from, *to;
>       void *data_hook = NULL;
> +    const char *connect_uri;
>   
>       if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>           return;
> @@ -1766,11 +1767,16 @@ static void test_precopy_common(MigrateCommon *args)
>           goto finish;
>       }
>   
> -    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
> +    /* If has channels, then connect_uri is only used for listen defer */
> +    connect_uri = args->connect_channels ? NULL : args->connect_uri;
> +    migrate_qmp(from, to, connect_uri, args->connect_channels, "{}");
>   
>       if (args->start.defer_target_connect) {
>           qtest_connect_deferred(to);
>           qtest_qmp_handshake(to);
> +        if (!strcmp(args->listen_uri, "defer")) {
> +            migrate_incoming_qmp(to, args->connect_uri, "{}");
> +        }
>       }
>   
>       if (args->result != MIG_TEST_SUCCEED) {
> @@ -2415,6 +2421,66 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
>   }
>   #endif /* !_WIN32 */
>   
> +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
> +    return NULL;
> +}
> +
> +/*
> + * cpr-transfer mode cannot use the target monitor prior to starting the
> + * migration, and cannot connect synchronously to the monitor, so defer
> + * the target connection.
> + */
> +static void test_mode_transfer_common(bool incoming_defer)
> +{
> +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
> +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
> +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> +
> +    const char *opts = "-machine aux-ram-share=on -nodefaults";
> +    g_autofree char *opts_target = g_strdup_printf(
> +        "-incoming \\{\\\'channel-type\\\':\\\'cpr\\\',"
> +        "\\\'addr\\\':\\{\\\'transport\\\':\\\'socket\\\',"
> +        "\\\'type\\\':\\\'unix\\\',\\\'path\\\':\\\'%s\\\'\\}\\} %s",
> +        cpr_path, opts);
> +
> +    g_autofree char *channels = g_strdup_printf(
> +        "[ { 'channel-type': 'main',"
> +        "    'addr': { 'transport': 'socket',"
> +        "              'type': 'unix',"
> +        "              'path': '%s' } },"
> +        "  { 'channel-type': 'cpr',"
> +        "    'addr': { 'transport': 'socket',"
> +        "              'type': 'unix',"
> +        "              'path': '%s' } } ]",
> +        mig_path, cpr_path);
> +
> +    MigrateCommon args = {
> +        .start.opts_source = opts,
> +        .start.opts_target = opts_target,
> +        .start.defer_target_connect = true,
> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
> +                                " -machine memory-backend=pc.ram",
> +        .listen_uri = incoming_defer ? "defer" : uri,
> +        .connect_uri = incoming_defer ? uri : NULL,
> +        .connect_channels = channels,
> +        .start_hook = test_mode_transfer_start,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
> +static void test_mode_transfer(void)
> +{
> +    test_mode_transfer_common(NULL);
> +}
> +
> +static void test_mode_transfer_defer(void)
> +{
> +    test_mode_transfer_common(true);
> +}
> +
>   static void test_precopy_tcp_plain(void)
>   {
>       MigrateCommon args = {
> @@ -3905,6 +3971,10 @@ int main(int argc, char **argv)
>           migration_test_add("/migration/mode/reboot", test_mode_reboot);
>       }
>   
> +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
> +    migration_test_add("/migration/mode/transfer/defer",
> +                       test_mode_transfer_defer);
> +
>       migration_test_add("/migration/precopy/file/mapped-ram",
>                          test_precopy_file_mapped_ram);
>       migration_test_add("/migration/precopy/file/mapped-ram/live",



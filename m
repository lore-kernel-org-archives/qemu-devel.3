Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD090C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5aA-00085a-GR; Wed, 02 Jul 2025 18:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5a7-0007yC-Rp
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 18:05:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5a5-0004uQ-De
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 18:05:31 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQbmY012369;
 Wed, 2 Jul 2025 22:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=di9d0KelShwfa+07WwUj+RIpgiOQqDtd8nBrD5i+D88=; b=
 DqXhQK4QnL2BaHTwQENKbFNIuW/dAdbIQRXWT4blOYMqqzmsivQc211cXXNiuFPs
 tVbEjpkWSSI9kEWLfNbiEArjdnECXIJUi7G2+gNUR0o7Ghuzuc9f2A9d5TnqWskQ
 LlKazHMTg3UtHCMCNKILKSTGCJtfEiEoUhCVUB6XJ1FjogyP/cxcq/H3gMDZmmV3
 z7yyxh13RA+YmsvjhdNUFxHnEKzLVfZajXNxjpIAPQ2J9neMPhrzWUfnvLzCtdK5
 EV4TiIx/t244HWelFbRr0AyM6FUzZPOVSqVt8WKzWbphFwmk2yIMlcFkoMKH2oBt
 s6bYeS9EoPgFiN6QpU2uHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef80bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 22:05:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LXYJ1033693; Wed, 2 Jul 2025 22:05:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtmb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 22:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuGLoWERGM061HVgRPziE/aXOoSn3wz60mfOuHKxW+IdZ7Eed8uPjQ/M0r+kqwgY/1e0Jb4b4K4kJq238x1Ek1HlGBxTYi5LxH+7TQZrz7hBNFoZvVGIXLD33Wy9TChzpMegQOEl7thZTm3i1Ab6uVS4hlTLB8RLZdOhdQQyZYkcOBKaMz8HxU77JYb7TfVrt2Tvb4KkahDDNjS+0vlf3S8zTJouZZ6pobe5vT5FNqsRo79JdHORqCe8mChyLF3v0wOlBIY2jgJcVz6QgdGD6nWFkV5/f0Z8vBVeDlYNVu4kQ5A7M82Hp1hTR6yTkoHt4I4Iv/AZ64o06OQpbqBwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di9d0KelShwfa+07WwUj+RIpgiOQqDtd8nBrD5i+D88=;
 b=Lr2GFSsOkii1mD/wlbfdhDCom0882daKqcHkuLUThfxXMFwYeQP91FopDl9LFxLGcNRfJMlRnIww770RDwYyP3Cw2dtC540xTI2jatkgsPXCy9tjRnZO0jmssqv3znI+WHI/lRPDCmFPQhp3X25jRUdFTSCyBS+FM1ljl0HZoX2A1WTeCbYCYWsuUVFq/NyDcSO00Xj8OwM42Q84IZuIa/NpeehksdXzU0E4K8RwvuTpxJ2BMFwTn/iumU1SwJfpRlaVs7SOXvsXIE/+spay/onzvBraOcnbhFiKx2NdTe6j6Z8EsiQIUk7ZgC1lJte/qPXjBXBVYiXfunEFaE4WUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di9d0KelShwfa+07WwUj+RIpgiOQqDtd8nBrD5i+D88=;
 b=ACX14Mbk1oj7AB0SEjNDYGkhQQwJZ6wfv3d86058xj6ixW35ckNwxKnuU0X9/UDp1c2i/5T1Cqn1DsQF6GrbmAb/BDf7ZWSu/Suc2JJdS67PkWtB5TwwnGVLmQta+MSHSZFVZS6mAFbIvqR8NHXkWMykgFqkbwEtDpz0+pesuF8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7252.namprd10.prod.outlook.com (2603:10b6:8:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 22:05:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 22:05:19 +0000
Message-ID: <e51734be-8949-4856-9107-16acdb6a80da@oracle.com>
Date: Wed, 2 Jul 2025 18:05:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/21] migration: close kvm after cpr
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1751493538-202042-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0079.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: b0314790-f4f2-4108-b104-08ddb9b488bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2htQW1ONTZkRmlFeGZTTzFRRkRGNDJndXRBcjZRY0RPbkNMbEN4VU1MRmNC?=
 =?utf-8?B?SDJFSXpZckJNU0wyM1pVM0UvejlGMUhsSTFnSVF6b000T0t2YUtMS2I2S0R4?=
 =?utf-8?B?aEFTRllzd2JjemFpMS9Nc1hsWkNnWFJDL2FiTTlsS1YyR09pU2JzZ0tlOGUw?=
 =?utf-8?B?cVRTNnlpOVJJNnFGVU5WOFpjS2w1SnEwZ1JGcmljNGQwSU9yVlNhb3A1Z0Rw?=
 =?utf-8?B?azNmdVV2ZWdMVXBWdHVRSUx1NkFQK2pMWmpzQUNoNmNpalh4SzVoVW90TlFJ?=
 =?utf-8?B?UkZWMDJacVFrVDJOWVF0WmZTTGpMaDBnTkNuWDJ1ZWFNQktZNlV1Vk95Q0xu?=
 =?utf-8?B?Wm1UcWJWczFXaUxlN2NMZmQ2MzEvM2Z6OU9MYWMrZUpsWHJYWVpiOTg1cU8v?=
 =?utf-8?B?b3BoYWphelpJRHRHYzFONG54L001YjEyQ3ZYbXlSNmIxaVFSS2Y0bXYvaERL?=
 =?utf-8?B?bnZRcjlMUW55M3JxZzgzOG9UZzdnQ3RPQStqWlVubU9UaDVXTXVUMm9VYlpu?=
 =?utf-8?B?MHYxMWNoS0ViQWJ1QTRpM1JtOGtVNTgrc2dLTlN1UFVsbVJOMFg4MDlsSytG?=
 =?utf-8?B?c2NVRERYV1IxWUNHR05YVCtSM0lEcUFOc1BTVlpISUJJM2hkT2MwbHBnb0lZ?=
 =?utf-8?B?ZTVlTGJFdWt1UW9tdXJHZ3lpWlM4TFZHU2lFZXI4a1RCd2lNTGpQRFdtc3lI?=
 =?utf-8?B?SFNTb20zeEtIRktrQTRPelZjRGpiM0tiRUFydnF1dTJrU1VqYThiRUd2d2gy?=
 =?utf-8?B?eU1udHRMbE5ORXQ3UzlrNjlKN1diMmJsNnlOKzNvd3BQNzhIaWFxS3hWN2pZ?=
 =?utf-8?B?bE5GYzdZM2NQUW5NQVZGeWhucE1GWVNaVlJod3RoZ1VtcVJOVnV6ajZ4Y0x4?=
 =?utf-8?B?ZU1hTHRxT1FuQ2tIdHcyUE9rb3MzTG54ZTk2TkExL01GdC9scTYzK1VQOHd1?=
 =?utf-8?B?c1pDS00yZlU0ZEp5cWk3UGNHUEcvQWFPb25FUC9oSzQ0eHlKM09KRU12RHpI?=
 =?utf-8?B?N2JjTnFpMkozSjgxN2RoWE5sYldYKzdsN1c4T1hxa3NKTytKQTVVSG9LRHFN?=
 =?utf-8?B?c2NWTWk1aHFYaGppeTI1TEVKaDdvejhDck55UW5VUVk5UEdLT3VMK3JnTVph?=
 =?utf-8?B?Zm5yZEJ1d0tUZDd0Kzg4WEFQdWFSU0pjRkdkWEVnSXZCR3JBYzZ4eE5FaHBw?=
 =?utf-8?B?QWtMU2xSdUNRcHJ0YjBaaVdpSEhVdzIramVISUpBN2xGaldCUTh1dzdOUmwv?=
 =?utf-8?B?VUdZRkNTcDJNTHZiRVBXQlF1K3c5V1E2RUNzRG8rOGI1czU4enhPd1MvT0R3?=
 =?utf-8?B?a0hrdFVDdUxtOE0zbjVRVXBXMUdId0R2djdLaStCZHdQMVZVSERDTHFPMHIz?=
 =?utf-8?B?cFdzWXVNZHhoUGlYQXJsYXVGTTNNRjhtNVBNNlNlMUMyS2sxaEFkeEQzVmVz?=
 =?utf-8?B?aVhIVzZzUW9kalNKRWswWW5Xc3dJa3RCUUwyVm0wcloyRCtRcDhSZW00ODJ1?=
 =?utf-8?B?SmVqTnFRc1pTVHZNVm80bTJYU0t5UENLenJCNGZRcnkrdHlNcFgvZkZpMTFy?=
 =?utf-8?B?VFB0TEF3SE85UldUUVpSMHhmZFVCU3prUFRES0w4bGtqcWZsSVdlMUt4OUlx?=
 =?utf-8?B?ZjYwV2M1TmRMT0JwNm5wd0RtTFQ4YmF1Wm52SFA3WnBTTDM4UnNzN1YrRStG?=
 =?utf-8?B?bisza2RVZHl1d1pNdEtUa2pZZ0FhekFRQ01Yb0pIcXFWNGo0YjhjaDJQRkxQ?=
 =?utf-8?B?bE95QlFUaEhoYnZTMU1lNytnNUhQcXZzYWhDNGZaTkFXbU1saHNXcm5INkJ5?=
 =?utf-8?B?Wk40elRvY04wcDFiYWw4UUtlcld0L1o1enVZSTZwd2UrRlI5NkRpcUNValZB?=
 =?utf-8?B?aE9zbldoZFdHRnROU3dMZW15VXZpYWkzZFRKWmFVcDNDZklpQ1FWd0RPejdF?=
 =?utf-8?Q?LC7v1346cdk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZWVmhWYmlLVDBqa01BcHBmY2FHQlRYc0tzMkduYWxPaklHSnhvcTNPN3Rv?=
 =?utf-8?B?ckZ5NkRoOFhVR0RNeUtGclhWWmhkbWZpaU5OcVpJMkJYVGNkOS9ORklDSGVH?=
 =?utf-8?B?ZGVIdUJvdHNxaTc5ZjBzRy9MQ2wrZXBFZ1oxTVArU1ljdm14SkJscmJ0U1ZO?=
 =?utf-8?B?QnFvenBPNnVmVS8yREkvWTU2MHNRSnl4bk91SVhhRWhaSnhwZWF3Vlo5dWIy?=
 =?utf-8?B?b2NqSllIQkJOTk5WRlVRV1lkWGgyQk5NSjFwODRvU1p1UExaUG1JNnRCVFlS?=
 =?utf-8?B?dDVQZVBSUmhzZEk5aG5OT21xdXBmdlhkSFowZ1hReFVBU3JOWjh3eHI2Q1B6?=
 =?utf-8?B?QnB5TjZvc2E2Q1JNNTE0RlI3VDZFbWJTMytqUGFJZ0FKb3Irem1CTXo5ZXk4?=
 =?utf-8?B?TjBjL25uajZGclA4NjZSL0JCV0NSbTNJeFIvbUZUV1lNUVRkeE1ibmwweVRX?=
 =?utf-8?B?REZDZ2tuUzBVRy9ydjRtL0VOL0Ftc2EvZVpZRFpiQm5sbkoyaWlGcmplcG9p?=
 =?utf-8?B?eGpRRFZ6OVdHSGNTQWRFbWEveExoUldBYkl2QnA5UGh1am5JTVQ0dFhlenAw?=
 =?utf-8?B?dnVYcnhnbXFWTzk5WkhxbTlPdVV4WGYrcXVrK1pQTnFYcmhQSlJ5cG9CY3lt?=
 =?utf-8?B?a3ZaODRKUE5HdlIxa3lnWWpHMU05Z21HZUNqU0xxYmgzaWNJaXE1VlJKdVVH?=
 =?utf-8?B?cWo5amFYZlZyb2dvdXhyRklNdWw5UDJLRjI4RyswV0crWjdXWUlNa05pWFlP?=
 =?utf-8?B?MVBka0lLdy8rRXlaNVFZcWtHcGVYYXF5aEFqSEtDbk9TaXBFdDE2SThxY25l?=
 =?utf-8?B?N0grVTNlMGh5RVNjZ3pFZzg1cEptT2dmU2F0Wkk4Nkt0MmJLdXJwOWs0UDJN?=
 =?utf-8?B?eUhaby96d0JPZWorYUd4VlNCSzRNdDZFdkpEZzRQTy9oQVZOL2s5aEh6bjZ0?=
 =?utf-8?B?RDBJVE8wdVRCZXpLOFd2MFdKK2p6Wk10czBleUpweGNjbUUyeUt3aStXcCtS?=
 =?utf-8?B?THNLUjc4TGJCaU8wSzR2SDBoNElLUzFOVHA5OW9FTkU3b0EyYXgvNmwxRzJG?=
 =?utf-8?B?SFovUFVFbjFMcGoyQVVqQUVkN2w3Y2ZPK2FvUjVhUmxmcis1L1Vxc3VaWkVP?=
 =?utf-8?B?ZzBtM3pzNWVqYVdhVitOM1pVa0Y4Qk11UFZYWnBVQUc3bEZsUEhiWVp0WDFV?=
 =?utf-8?B?bDhLUTFWWXVxUDJCVHZkd1NFVng0bFphSG1EZ2tlQTBkNXVqNVVUa0dRSG9a?=
 =?utf-8?B?QWo3bDliTEYvbmNSWGJ1SU5UejlBRHoxekxVZnpobU9yMjZpQk5STnpObDFB?=
 =?utf-8?B?L1BlSEZ3RHJ6bUpLR1JjOU4xdEZ5R0ZZUGxmbkRGL1p5ODJ4TEw4REtCbXcy?=
 =?utf-8?B?b3prRnhrN1dobGNYK0t6c2NXTTZnN1dyZHlRaVh1NEZua3M1ckZLUDRpb3pq?=
 =?utf-8?B?VDA1WktGaGdGeUR4c29VNUlvZm9vMmw2TFdwa1JNdFg0UEJrWnlybDF5OFc1?=
 =?utf-8?B?MjlMQW9tOFFHTFZNcmU0Q2xCMTBMS1Q1OHlKVCtLclRYYU5lS3phNFZKZ2x1?=
 =?utf-8?B?QnJvOWFwemw4L211MDJ5M0dKc0hSaHZUM01ycEFkV3VHcGVTWkVBOGcrMGla?=
 =?utf-8?B?anBWSDdaV29YbzBoVEdvd3JDVFNmRS8zeThHRVlWYUtoVG1EcjBCSFMzVmhI?=
 =?utf-8?B?MEtDU1BIUVNLa292WmNqUjl4NXpPR292dFFkS2tDeWFjK0p5QmZ5dHJuYncv?=
 =?utf-8?B?NXJDVDF0a2dWdlZrZVVRK1JaZ0dCKzhIbFJudmhYYTV4VCtkWlJINEZUTFJz?=
 =?utf-8?B?YWlCYXpmcFgrVFJwazJKM2RMZ2ZhYjgyUy90RmlIck56b3p5U0dPaHprcUcy?=
 =?utf-8?B?MSsyME90THpQWGVNcW95QVV1cjBhNTRqMW9hc0NKcElLaXBSblJySUpaZ1B5?=
 =?utf-8?B?Q015VTh2T3lnc0g2U093NFZFcWhLM2N5aWJhNSs0cjFRQXFDVnVvc2JLcTl0?=
 =?utf-8?B?KzZlRkFOMlpyd2h2MlBVU3pUQml4LzZhc0FFZnYzVEFQR2Z4S2pEbllpN3Yx?=
 =?utf-8?B?eTQzZytnS2ZqVE1neEdlQ3lnTFVrTkJTdFlENktYcUJUWVRGVm9oYmtRL3Jv?=
 =?utf-8?B?c0kwSGgwSzN4NFlEM0RLZHk5ZU5nank0R1dHMFI2WWRxMXVzR2k0QkhkdlpH?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NqQE8q4Kp+v0sleikNIGKpAyokjJJmJpU/OKatxFhzMMzUEA3BYpehp8ydGsgfTJGJdcrGK8E/JL6QaH/2fV4lUOT3f/+ShLVKZz7t/ejZG9dJSDKvpNo6to1h/gUHLjhJSR5K5KvUm/zdap4GY5T5THcQH0qFGvWIW78PbJ7ojF6D3x/r+4leURMT07IJnZ1gzdUy973vq3BOx4NukFZbGqnT3Ng0yo2r2GLSEz+8gUJumfMmBjESWAtV5ApQXU3jMvcLlZ9CN489THeOFF5kKs1osOC8uVS/XchAOG85aLoCxJLppWNflgRxlGt/px1PBRVRLvtakKNiQLaCLeB3JLJT84ko1hrAweRAJz94A5kqrPuiFXlRY9wI26cnOQNGQWk+mkzN24qqU5yHbQk+kPz2OniiZUrlG1WQaJd7/AdiqdBHbOrLoJoFTnQDneILhimUeLEiNKxx6qZfzvzQ+KgLDKMwezTgTEyyiMNTDPNlwPM3dzZ6IgwnI7kHRadjVbWBK+mpeMItsr0cZYMa2ORf9awOZdrYpGR7z4HroefGWvBKNDNxcIDTfdwciAi26jjIcGsDGVoffQaKN/r0xOT2F4UxcePCIIpVi3DAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0314790-f4f2-4108-b104-08ddb9b488bb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 22:05:19.7457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8p6p1+iEdtN5fXcWPZfv3GIeHoyzkMuxzAvmJIwtQBQ8qlmlVFZhsAMVUfhpaEYgguiSlcuEoZeZYrWfSIV5U710Lt7yIO2sKZKR4B6NZCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020183
X-Proofpoint-GUID: VC-qJlG6gNWZq-Q4cwvnBC6dT_h2r3hS
X-Proofpoint-ORIG-GUID: VC-qJlG6gNWZq-Q4cwvnBC6dT_h2r3hS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MyBTYWx0ZWRfX39+12wMPhXCn
 LbXc7sQIB5z7rM5zZ92b7pIjz4UaSSoCjTVlTwLzf595ycrEiWJS+E4Aem3HoDShXIZbIzsuPxR
 ySMfByeYnmk5UEqQaHa0Eyp+Udm+RfegurJcF32zN9vbwxPYZZZWWzngUZivGO+6OcXUQEZVo1i
 VR6YvLpkBYEAbaDHU4ulsom6U3iw7ZTah6TzYh7hQNW2MZUC+uH6+ht8sDYOiQpt+oKA7p8wHFg
 7ytA7GxYIhjJxIzUw+C3c7lc6bWn/EJ4c9pZxz33uLCP1/AV9bmBwtcopoBE/sgn5MFcaaPTk0q
 jQx2hcO10YfOaOWYXJEAhMi74/ftbtTNBEQX6Wb1wN5JrsYM9UrWP1WDCXP91+12fUNkCXtWXB2
 viBnMEJgdhBs173FzCr19GTxagNZkjhyv/H41mePk9zC/DLN/dVX8EqpjYo+LlzWYiQvpe3A
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6865ad24 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=MLJ8A79VmOEvZXqrtSsA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

cc Paolo.

After incorporating Peter's feedback, IMO this version reads well:
   * kvm exports kvm_close
   * vfio exports vfio_kvm_device_close
   * vfio-cpr registers a notifier that calls vfio_kvm_device_close

- Steve

On 7/2/2025 5:58 PM, Steve Sistare wrote:
> cpr-transfer breaks vfio network connectivity to and from the guest, and
> the host system log shows:
>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
> which is EBUSY.  This occurs because KVM descriptors are still open in
> the old QEMU process.  Close them.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   include/hw/vfio/vfio-cpr.h    |  2 ++
>   include/hw/vfio/vfio-device.h |  2 ++
>   include/system/kvm.h          |  1 +
>   accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
>   hw/vfio/cpr-legacy.c          |  2 ++
>   hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
>   hw/vfio/helpers.c             | 11 +++++++++++
>   7 files changed, 71 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 25e74ee..099d54f 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -62,4 +62,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>   
>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>   
> +void vfio_cpr_add_kvm_notifier(void);
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index c616652..f503837 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -283,4 +283,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard);
>   int vfio_device_get_aw_bits(VFIODevice *vdev);
> +
> +void vfio_kvm_device_close(void);
>   #endif /* HW_VFIO_VFIO_COMMON_H */
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 7cc60d2..4896a3c 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
>   int kvm_has_vcpu_events(void);
>   int kvm_max_nested_state_length(void);
>   int kvm_has_gsi_routing(void);
> +void kvm_close(void);
>   
>   /**
>    * kvm_arm_supports_user_irq
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d095d1b..8141854 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           goto err;
>       }
>   
> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
> +        s->coalesced_mmio_ring = NULL;
> +    }
> +
>       ret = munmap(cpu->kvm_run, mmap_size);
>       if (ret < 0) {
>           goto err;
>       }
> +    cpu->kvm_run = NULL;
>   
>       if (cpu->kvm_dirty_gfns) {
>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>           if (ret < 0) {
>               goto err;
>           }
> +        cpu->kvm_dirty_gfns = NULL;
>       }
>   
>       kvm_park_vcpu(cpu);
> @@ -608,6 +615,31 @@ err:
>       return ret;
>   }
>   
> +void kvm_close(void)
> +{
> +    CPUState *cpu;
> +
> +    if (!kvm_state || kvm_state->fd == -1) {
> +        return;
> +    }
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_remove_sync(cpu);
> +        close(cpu->kvm_fd);
> +        cpu->kvm_fd = -1;
> +        close(cpu->kvm_vcpu_stats_fd);
> +        cpu->kvm_vcpu_stats_fd = -1;
> +    }
> +
> +    if (kvm_state && kvm_state->fd != -1) {
> +        close(kvm_state->vmfd);
> +        kvm_state->vmfd = -1;
> +        close(kvm_state->fd);
> +        kvm_state->fd = -1;
> +    }
> +    kvm_state = NULL;
> +}
> +
>   /*
>    * dirty pages logging control
>    */
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index a84c324..daa3523 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -177,6 +177,8 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>                                            MIG_MODE_CPR_TRANSFER, -1) == 0;
>       }
>   
> +    vfio_cpr_add_kvm_notifier();
> +
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
>       /* During incoming CPR, divert calls to dma_map. */
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index f5555ca..0e903cd 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -190,3 +190,24 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +
> +static NotifierWithReturn kvm_close_notifier;
> +
> +static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
> +                                       MigrationEvent *e,
> +                                       Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        vfio_kvm_device_close();
> +    }
> +    return 0;
> +}
> +
> +void vfio_cpr_add_kvm_notifier(void)
> +{
> +    if (!kvm_close_notifier.notify) {
> +        migration_add_notifier_mode(&kvm_close_notifier,
> +                                    vfio_cpr_kvm_close_notifier,
> +                                    MIG_MODE_CPR_TRANSFER);
> +    }
> +}
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index d0dbab1..9a5f621 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -117,6 +117,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>   int vfio_kvm_device_fd = -1;
>   #endif
>   
> +void vfio_kvm_device_close(void)
> +{
> +#ifdef CONFIG_KVM
> +    kvm_close();
> +    if (vfio_kvm_device_fd != -1) {
> +        close(vfio_kvm_device_fd);
> +        vfio_kvm_device_fd = -1;
> +    }
> +#endif
> +}
> +
>   int vfio_kvm_device_add_fd(int fd, Error **errp)
>   {
>   #ifdef CONFIG_KVM



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFACC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVont-0002lY-DH; Mon, 22 Jul 2024 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVonq-0002kY-7z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:53:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVonh-0002IZ-QE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:53:49 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cwq8021133;
 Mon, 22 Jul 2024 08:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=QUTEC2hj11sKEqHVDzXhTeByRwMjlQrRBpQXmsRLkIY=; b=
 FE8v4lBBGS/k/2ZggL7Ud6W4SbeVraHuYJLOe8oFWwvQ1RH899TlV2v7h8eeTpmh
 FFGLKSr20y+Anv3W3OQXV0uQijgbUYn2dJ7tactCvoMPpMbylH+mxZZVINyf0Ivv
 UI+eyq7HDOTDLAXFyO0Vl9FqbBVwrRYkpX+VY+iN2evPpKGyIbUopcaI69hX2L0W
 EoLg0WcCGbturdAFhkKgdVcumasEbL1xOHoS44Mpda2dB29QHI9do9QTZPgNIfM3
 /A0xFelR3Q+HcvlbMUKiEnjx0Se4yxfCiggRaBQOp/VE7xBu1DLojSu8Vi8rQqSt
 ywphZkk8kgi2sZxvBgtW+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt0t85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 08:53:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46M7uEa8022974; Mon, 22 Jul 2024 08:53:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29pdn5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 08:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar0YROZ6JOT0trLV9Xpg3c0cdqkBImkr6/WLWtCTkS0KAeeLwPy6twf5xwxZxk0Shv1VTMhtq4FV5ch81k4ji8mNrQhXg60N5vKyi78uuW6PhgvthfZYYDEdO30q0j5M5Ow+T+dw2bnPTm2ZbTVLXoGhiBEqCmjoKjp+9mXYjDvOGwOwD2V0izfyFepsPE89DPfosfOQH5UqMKLDxvkTcmiTRrj/A4v8n2DxveJdUPEP5l6WlTnEdzvPJfjn7FhXTRKDvwmYqy+8gO5Qn5Y1fQ6uCjDZF/GmnqYL6lIJAAsGpDEkZTiedvgXgpFz3LRisE7DztnKf5GomznivRFnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUTEC2hj11sKEqHVDzXhTeByRwMjlQrRBpQXmsRLkIY=;
 b=rGwRrpyerjGPGHBlQtoFhfT51zxO+ruwIoL0O51kM2g+L9alGe/nlQdUDhhvYqKdM9wBS0SupOsJGrYZZEVmJe1yFBnGp5+f9MziAMccLFiqCn7IL/GiCk86qlIDjAsD/YTOPaAlcHmuNfRaFxbVRGStcqm1PgrjbCM9Git6d5qqlo9L8rMiIcfD0dKJCqB5feEdA6tNc6i86DbHHiW/zZmrcABRboyVXOomZY4p+KBNo89KXbbYXa+FrKfqmoSfOc3HmecE9pw7EDASINOpp3exMZwcaewOQZuOHLYJ5t62fWELqoXqn8EuaOWcIdH/jG5Rh+8toI14n/wqdjvrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUTEC2hj11sKEqHVDzXhTeByRwMjlQrRBpQXmsRLkIY=;
 b=Se8LEvQcDTsVJfmtopCRNkIoPorFhNJvszKyOatIse/J4Ib1nChnEBW885U54P6ti3vS3gYeoRDJemkR5T54GfYJP+gLw9g4VsEpZRLxsAyzG/6HqLiMhOaBIdaqlkMEIiKVHX5QYRhvAdnCaXxEpqmSmvewdpKlAJzlMHXIH6Q=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 08:53:38 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 08:53:37 +0000
Message-ID: <3a6ca7d1-8ce1-488d-a3ca-64aa81870c8b@oracle.com>
Date: Mon, 22 Jul 2024 09:53:30 +0100
Subject: Re: [PATCH v5 06/13] vfio/{iommufd,container}: Remove caps::aw_bits
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-7-joao.m.martins@oracle.com>
 <SJ0PR11MB67448715600DF6E75BF9315292A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67448715600DF6E75BF9315292A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BN0PR10MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: c08b75bb-5e4d-42d2-e0a0-08dcaa2bc6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3dlVDJYUmVId1lUV1lWeC93Q2ZqQ2N1USs1eGZiQ1FLYWpralJXdmRQMlE3?=
 =?utf-8?B?THRyeGh0VkxBSlkzYkJPYXlGcUdLdmdlUFBDOGhONFZTeXB1aDFqUzduTFB5?=
 =?utf-8?B?YmV0TlZkNWM1QTVleWRqV3VkM3lMNEhoWlRXakROSzdXZGg4dm1WMEJLVDlL?=
 =?utf-8?B?aVpVZTVlVE04TjZablM1N2swa3Znc09OWTZQcWducDVCOWRxYWhZRTM5MUdR?=
 =?utf-8?B?YWFmbXZqNHprdmZjTmZPdnNDNU1od1Q3N1RIN3Fob3BPdUlKNlVOaEYxUm4r?=
 =?utf-8?B?b2dNUGF5V2Z4UW5LNFM0L2s5SU40bWo4elJmRDFtVEdYaXVjYmEzcHVLVVgv?=
 =?utf-8?B?WDJJR2RhVEw5ZVdRKzd4ZDd4ZjJWTGthWkFPcHMvbllxbXNlbjBFMDFPaWVJ?=
 =?utf-8?B?cXpmYytUblYzZ3lzMFI2dERxU2tieTFKZVhKb2hKb1FJVG5XSUx1QTc2MWFS?=
 =?utf-8?B?dERrYjdUcmxrSDBneDRIUlkxTWl4TFZ3OUsxbWViRjQrWkRSVTRZTFNHZ0R6?=
 =?utf-8?B?R1ZHSDVDWXpxM2tMMnpzbGplM1dmWnFlMjM2UHptTmFLaVhpMEpyOSsrTFgz?=
 =?utf-8?B?T0ZBQVFHdjE4czJHZDd2Q1lydGlHZURQWmliSzZsd1ZORzhlQzU3TWh0TEZT?=
 =?utf-8?B?TkRyNWQxOTR0SlVDZHlUYThoVWllMXN6SVpFdWNhTWxsTTlyTm1YZVcwUDVv?=
 =?utf-8?B?YWdNZHp4Q3NEa2NGSWVYQ0dEYUFsS2EyeHAyc3RVb3I0aHJYRGVZSHhlOGNO?=
 =?utf-8?B?c0tMWkZqRHhmNGEvZlFDejJEQ0hGRmJBckdNeDJLRERjY2VOWklvdmJueFdH?=
 =?utf-8?B?WFBSa1N0NmMybVZ1NUFUSkRCaHRldWliWWRoSG1kbXE1YXFYc3picXptb3ZN?=
 =?utf-8?B?S25Uc2I3MnMwWDd3RDl5eGJta2RvbXFPbGw0UTQvTTd5dDlFZGlqWW5UWVNR?=
 =?utf-8?B?ZU1OWFVzbkttM0xPUDQ2U1BXdzJuQWtSZlY0U0g2K3gvYlhOckVSRzdBTFIz?=
 =?utf-8?B?ZFRCTHNKc3dET3BuaE41MTNPME9EYVhYQURPdWNZRlVaTVNUY1BmcGNKcUN6?=
 =?utf-8?B?dnQ3VDVKWGNZNlNTd3FqcFU4VFlJRDJZa1hObDlRNjl2dU5heVJWWThvM3RW?=
 =?utf-8?B?UUQ1MWVvZ0lyZjBadjJyK3pLSHR4K2FvVlNzaDRYTjZZaVRPNlp3T09iZVI1?=
 =?utf-8?B?TU83STBueHlqaEx6UkZkZDJNRXFFdmdXcThoTWxKNHhmRjF2dkdjbEVxV0du?=
 =?utf-8?B?WkZxeHAycUJESm9rYjBZd3liTHF2WUZkbDNiRWZaUWtHOFpmTUdWK0k2d2k0?=
 =?utf-8?B?T2NKUmNmNzVLZll0SVQzK2JCWFZSdWJQQnpXQjBxd1RFZXVVQUZUVWZiY053?=
 =?utf-8?B?V3Fsa0FCZ2tLcG9hOXZlckFvTkcyRTB2aS82M3dYVVFiOWU5VXNaRm5TcHJj?=
 =?utf-8?B?THRpVmxBc1RLRWRUVk9PVmhXQkJLbUtXY0pjdnVCOG1DQlRwdEpEZ05JcjEy?=
 =?utf-8?B?dkNwVGt0dGg3SlUwYUpHakVIOWpEcWNMbUxNakwwQXdXVFBvc1A0WkRRcUJ2?=
 =?utf-8?B?dkNQSGthcWZJQjdwckl5V1hNdGlkMFFvZExnWFU3NDlEbjU4QmtlYXRJbnRt?=
 =?utf-8?B?Z3FqY0NJQTl3eHpmUkxoMWVKMFZyamZhOEJDZm5PS3FjQWx5emhXVUxDTGNT?=
 =?utf-8?B?SFNYNDBzeGNRYkk1eW8wZlJTVlVJMXZYc1FGY2YrRzVRcUxqdXU3U3Ntc0lj?=
 =?utf-8?B?TUV6VFZFYS9wbTBiVWxBeThKWC93VEhwWjhtc0JUR3pSMUZaVGZ2ZkcwaHlU?=
 =?utf-8?B?ZGRYck05WjRsQ2g1aFZtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVJZjB5NWdUMFIxUzZFU2VPNnRQVmJ5eVdMay96UFJKY1JKS1A0YVdIR3lY?=
 =?utf-8?B?blBTV2l5R3FLMDhkUjJFeExYeURHODNIaDFpVUE4OG5FSEdKVG0vdG03cWxz?=
 =?utf-8?B?RG5LR0t1UDJyNGNMdzd5cytQTWo2aHdNV1AwWUM3eWtkNnN0SVdhMk9PR2RS?=
 =?utf-8?B?TzBvZ21JeXM3bkE3MDZpZldPTWx4MUdrQytiY0ZrcGFYSUtCUk80cWxKajJS?=
 =?utf-8?B?WW13NytsRUFJSkR2ZHpXM2xFMnlBdS90Tk5NWWQ4R09KRUsxa0FNNmxuN0d0?=
 =?utf-8?B?aW5iYXFwRjVKdmNSeWdhVnA3RWV4TlB0VENnMEI5QUtBVUUwckZvL0Q1QVRU?=
 =?utf-8?B?REkrN1NUVWViRnQyQ1AzZzhieFd1S2MzVDhOVU5ZWmg4QVhjUDNwMGRreW5j?=
 =?utf-8?B?SU5CaDJyYnJKUkRGdTJJKzZuVG5BTnJnb3JqbTIrUGtvSU1nczQxcVB6Rk5U?=
 =?utf-8?B?MzA5MHV2Zmk4QmRELzRrcGpaVkw2RTg4blJ0R1VDTlBucXFBNjliVzFYUVpL?=
 =?utf-8?B?WlBidVZHTlROaEppb2V3RXpiOHdodlBLeXBHK2Nza0VOZXUwYWtab2VRbDRq?=
 =?utf-8?B?ZjdKcWRrSTJhNXVnMis0YnRQdlpiWUNPQ3ErTyt2dThVcEd6cVpxaTlpaDZZ?=
 =?utf-8?B?NC9sMVhkV1puTGcyUk1ja1p1dzJtMGhPUmUrMlB0WDZHbG4vYlZ5Tm1NdzdR?=
 =?utf-8?B?d25vWFdPT2h2eSt6WnNXNy9jOEt3RFFzODBNbE84M0RCdlc2OHcwdWhRV3lG?=
 =?utf-8?B?QUQ2ZzM2VElSVE5kYkhwanFUSWJHSXZrdnJxSkxYYmpLQ1NHUGVQUHJ4QmtF?=
 =?utf-8?B?LzRIWXVwNTlCSGJtYUxCcWtGM2JhQVFyeDRMSjBSVHdGWC9ML3ZhMXNtOXh3?=
 =?utf-8?B?NFI4VytHb0NOY05RUzNrdTg0WFFJMk9jYm1CbGExcnU0RlRrK3I1ZW1lRU1O?=
 =?utf-8?B?dXJaNndCN256dlVwbDB3Y2FtUmhZNGFOOWgzRzUwa3NKL3J1SUtibVN6U0o3?=
 =?utf-8?B?SkN5TUNCcDNralhGU2dlTGk2bXZNVSt6R2d3WEMxYVR5Q3I2TnVCTFp6Rm4v?=
 =?utf-8?B?ZTMvMUhkRlNRRGduWGRtbU0vazVpallvN056OUdkeDFjRDh0S1ljNnZaUG9B?=
 =?utf-8?B?dTZoM0hBM01yVXpuVkxxWCtPdkZDaTBianQwSFMvVHRmMTB3QWVhdENoVjQv?=
 =?utf-8?B?QjIzYlNocWpoMldRbHVoVU1ZT0xRc0NOSXBxRGJ5RlRwRDZnNlhCQnBZbCt0?=
 =?utf-8?B?dmhyYzVxdEtIUTlablA5T2dlMERhZjNMUG4xamI1NjM1Y0REM3hEL1kzYVFW?=
 =?utf-8?B?NVhFcXJ6TXNmQzN1VUM2OWRtOTJFeWlON2dqSUtmMjNUSUhucUl4VnA4Z0Rs?=
 =?utf-8?B?a3BuandCM3dvMFBxYmd4YjM3RFFjeFJ6Z1Y2N2t0UGRLcCtzL2xKc1ZaRlpJ?=
 =?utf-8?B?bXRuY3pHWEJjUTR1eWVhMzNscFM2TVRiNmhCMzlUUHU4SFRpdC91dlEycGRR?=
 =?utf-8?B?UHdaUWlXeVNHS0lPckQ2Z2RyeGY3QjN2NVE4ZWROYjkrVVRiT0NDTG9JazNI?=
 =?utf-8?B?VEJVbHV5MWdVY0JDR1pXRExob00vSmdLODlJSS9BRWV6WXM0TjZCRGlLRi9X?=
 =?utf-8?B?L1k1bHlZcTlyNXp2Znc2S1hxUzgyZDhnL3p4cDZmQXN3OWEvNmJBZWp1bmU5?=
 =?utf-8?B?MVVXUmxaQlYvQldGQVFUUU5yYlhqNmRMTVJCYWlLTkRwbHZNaVRxTExBZE0y?=
 =?utf-8?B?WjRtd0x5dWFzZ0tmUU1UbjdhbVR0bnhLOHhSWHJmVDRqN3p6OVBia3V3Q2hI?=
 =?utf-8?B?QkNhcWJ0RzZuTmFGaHloSzNSbTZTb3gyQWJWNVRMcmlTUEhrWE9XNkMyQ29E?=
 =?utf-8?B?cGFYcjNnRk5ZaCtqTTQwemlObHNscG9WbzVqd2Y3TGh0S0c3M3EzR2ozL3JB?=
 =?utf-8?B?SVRFL08wWWZjN2VUT3VYOHdwdnhmSkdEcjg5V2lrUVB6V0JHYURnNFN4UTRq?=
 =?utf-8?B?NFViblAwanZqZ0VPZXM5dnNGY3Q0aFdwWkMwdFIyeUFXQkhub1lGWEx0bkFk?=
 =?utf-8?B?NzhtaUFpeWVodjhOQWFMTDArMStHVVkwaTBsOUhzdDNEUnFCbGpWK25rK2dj?=
 =?utf-8?B?WG5nclhIV1BSclhwYzlIWDdna2NrSjhiamZ1aytnR0wyNlRkYTRYcitEUGFP?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BpqhUX4iJW/MGuqATTiWz6rwuIkLLrLu8hM+krnooIQWIqrUkINWWadOB0mCZb3ShsQMMtZdJHV3TYtiZ0kJ4646HQICccx6P4Y1T+6su23wzQj8fRyg3kWRpTwc5m9PpikLAxNEqBZPn0DE1r80znpTqWLWBtfpTvdDZuimffhn61JvX7yR8kw1q8ciW+x+dEPl3FtogYFxlvHDlWR7hhySDcyYZB1LHlq7MUhTZ+ms0hdp+Qp8uYNZBAmxOvA11m6oDlft4Q2nIpgFxa6LkXXHhYvvI4R9RqwUaJ/e4mtxixLB+Dpt3dNWIZsxRbKTaA21J/7RJ8fCVoYUPrZuazvq04eGM1ir9czBft/WOlGc3u5ZSTnm+cAzQJ0c5QFeSpJUgQsVMtqBGpVHZHw+2jqjs8PWFmx/Kvr5pKfzxkUximNiJgdffJaiSbMyhhZwSJLfZXdt6AwZ1cEwi4eIuKF5o+erlUAcRHI+J/M9D1VTd1KeOgRZddbfKBRL2/moF/3m+pyo5m7XKCe9qsFZCQ3ISeSt9/Rj9iCSg+4ZCdShLQD6RyGFcT8V/oZP4teSvkp396+Vn8+Uz+q5Dv3ozLzf68bThOyrO4uzLCGZMHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b75bb-5e4d-42d2-e0a0-08dcaa2bc6e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:53:37.8944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjdGIxyCNKmlrdH84KYTJOzhJNEPLDagKN86Pv39qN4dyChmyZgUACDkt1ynl+XmULz7RHzCDeyufcalFeop1J6JhGxu2l8vv142DO5Asx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220068
X-Proofpoint-GUID: ia5EVnPrsyXxEP_udEazc8nZQ6yAixEV
X-Proofpoint-ORIG-GUID: ia5EVnPrsyXxEP_udEazc8nZQ6yAixEV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/07/2024 06:22, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v5 06/13] vfio/{iommufd,container}: Remove caps::aw_bits
>>
>> Remove caps::aw_bits which requires the bcontainer::iova_ranges being
>> initialized after device is actually attached. Instead defer that to
>> .get_cap() and call vfio_device_get_aw_bits() directly.
>>
>> This is in preparation for HostIOMMUDevice::realize() being called early
>> during attach_device().
>>
>> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com
>> ---
>> include/sysemu/host_iommu_device.h | 3 ---
>> backends/iommufd.c                 | 3 ++-
>> hw/vfio/container.c                | 5 +----
>> hw/vfio/iommufd.c                  | 1 -
>> 4 files changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>> index ee6c813c8b22..cdeeccec7671 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -19,12 +19,9 @@
>>  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>>  *
>>  * @type: host platform IOMMU type.
>> - *
>> - * @aw_bits: host IOMMU address width. 0xff if no limitation.
>>  */
>> typedef struct HostIOMMUDeviceCaps {
>>     uint32_t type;
>> -    uint8_t aw_bits;
>> } HostIOMMUDeviceCaps;
>>
>> #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index a94d3b90c05c..58032e588f49 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -18,6 +18,7 @@
>> #include "qemu/error-report.h"
>> #include "monitor/monitor.h"
>> #include "trace.h"
>> +#include "hw/vfio/vfio-common.h"
>> #include <sys/ioctl.h>
>> #include <linux/iommufd.h>
>>
>> @@ -270,7 +271,7 @@ static int
>> hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>>     case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>>         return caps->type;
>>     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>> -        return caps->aw_bits;
>> +        return vfio_device_get_aw_bits(hiod->agent);
> 
> I just realized there is an open here. hiod->agent is not necessarily VFIO device, can be VDPA device.
> May need a bit more work on this.
> 

Broadly speaking I agree, that this needs some sort of IOMMUDevice structure
with a agent type that it needs to abstract from instead of an opaque object.

But feels unrelated to this patch exactly, as the existing code was already
making assumptions that ::opaque is a VFIODevice.

> Thanks
> Zhenzhong
> 
>>     default:
>>         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>         return -EINVAL;
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 88ede913d6f7..c27f448ba26e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -1144,7 +1144,6 @@ static bool
>> hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>     VFIODevice *vdev = opaque;
>>
>>     hiod->name = g_strdup(vdev->name);
>> -    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>>     hiod->agent = opaque;
>>
>>     return true;
>> @@ -1153,11 +1152,9 @@ static bool
>> hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>> static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>                                     Error **errp)
>> {
>> -    HostIOMMUDeviceCaps *caps = &hiod->caps;
>> -
>>     switch (cap) {
>>     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>> -        return caps->aw_bits;
>> +        return vfio_device_get_aw_bits(hiod->agent);
>>     default:
>>         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>         return -EINVAL;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 545f4a404125..028533bc39b9 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -724,7 +724,6 @@ static bool
>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>
>>     hiod->name = g_strdup(vdev->name);
>>     caps->type = type;
>> -    caps->aw_bits = vfio_device_get_aw_bits(vdev);
>>
>>     return true;
>> }
>> --
>> 2.17.2
> 



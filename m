Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA784C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 16:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU77Z-0000oA-TE; Wed, 17 Jul 2024 12:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU77U-0000RQ-Va
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 12:03:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU77S-0005gL-L3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 12:03:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFtfEY003759;
 Wed, 17 Jul 2024 16:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=EBn2vP53SM6lt9Zhm7J2pi627vnts66EJa3hqbfrhzI=; b=
 Ih4nDGqu/EQazOYyLNDQCG71bdtozYr9nSGQv1Nr4cSKW2wDeboB2c5wPT5Xyk5L
 5BSbKxzoaPEz+xTN/vnamjnZQQ4xG3006ME60KJ82yTuqSCiqQiTQD2Oz14Xdb2k
 xIosJIF5bM+BM0OAD7e+Y3NqQcHhHyzR5wafsuuzDUH75kRBYFP22s3qopUvqGkn
 A3gtj5lUImhV6dmCwHJEgAdMDa3Fq/WMC1hz08ltB+9x7g0+gQg5+66vfZd/9s7D
 Fc49EaBphtc5powOnGWNrYi73H/NtV/LFq02JrMMZaT0Sz7QHVlG3+HiQDxmYWkU
 KJs7MkraXIReF8jVcfzNEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eh15g0p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 16:03:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HEnIVk031714; Wed, 17 Jul 2024 16:03:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexjf1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 16:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW1VTDX2trXKhVwZ2DmabJdkEneGFohAp9dZ6bATdoEZOhOZFMItjZ7ixI8Eui46fieaoGpCAhQjLohibzxY/h/WZ09bHkzMhJ7aDg0AUvpND/BAPunWRW+5hYZ3KC8O3K5hUAmQKCsuotU71H2WIDzVmJD3fJJSOjXq85CICo8bW3o9hGvBX4a0vLbx5wrqgfEKWt1v01iFyj/oyLWGV6cRS7YaiRiRxLXnyeSooLWWvnIlBzZZUCusrYDXimgxECzdBWB/W95NPjc5o88NOpLtWI4lzE79dv9drq5ESpsG3sA4UUqDTGJhKvPRFbXwqt+hjEGVpLMmfTD1duTNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBn2vP53SM6lt9Zhm7J2pi627vnts66EJa3hqbfrhzI=;
 b=ofyZXIdmcLV+W5H/itYL4boUxqp0JEa3UWJI78AaiKL0Gmaelbjfzz63W0EUh9bE10cmXB/Pn4w+keFgRZgvgyvwyplAI9zmbpmRB0/jze3ccD7WumSLjh1z0pXjkoO6odubmCJJatyOLNZyfyHcWChu93YJJoXB8m/5bXpJATHrj1Kg/i1PTtG3/FHAQOrXlXCJX9cUdjdmt5OBMSmpzmaEq7mqBJU6j4Os93nW3vOOvCsyWWvkYT/UXk8GJiLs1DNHm4z+6cspTDi1ehn/RbmrAXEF5guCwFAXtUrm5laY7I3Cv38RdTveSP92V3yiG85SvNT6KyVh8Lj/VCUjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBn2vP53SM6lt9Zhm7J2pi627vnts66EJa3hqbfrhzI=;
 b=mlL7qHQuCKAzwlJNauYcvc5EstLGzVJjr2s2YE2QzPb2XS9iyV0/acP5UiTi75ZPkvj8Wi0xMnufJqviLHsPIO+FfrRzay1ZiylImQokv7JOaqyJ+hyGxgG91YSSnWL60UfYTWkx72R1xC/wz8zC4l0foj2SjDUQb+dgu1LFQuQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 16:02:57 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 16:02:57 +0000
Message-ID: <6f3ee3e3-8930-4677-9efa-462e2889fbf8@oracle.com>
Date: Wed, 17 Jul 2024 17:02:47 +0100
Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
 <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
 <4e69e717-04a6-482e-9cf6-da23a9dc80a4@oracle.com>
Content-Language: en-US
In-Reply-To: <4e69e717-04a6-482e-9cf6-da23a9dc80a4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0441.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8aa3c0-c279-44d6-3a7e-08dca679ecbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVdIb0ErNVVYWXROUTlMdjZESVZyaWFTOFZYZmpCNXY0cE00ajQ5aVNHTHo1?=
 =?utf-8?B?c0Z4bGpsaTAwc1V4clovMXZVZG9wMktHUXpyUm5pN0ZFb1hEWWVwTlBqUTNB?=
 =?utf-8?B?SWUwZFB6TU5MeXhiMXU3NzFhaHdtYTNEQ3JKVVVCWXVvb3NLTDlDVXI2NlJU?=
 =?utf-8?B?K2NVenVYd0l2c0lKTUYyeGtxbEtINEh1L25PdmhFUWt2ZjZvTkZqaS9QSnh1?=
 =?utf-8?B?eTEvZDU3d1RwWDF2NFpJKzU2b1NuMDMwMGxuSnhZc0JqTmN5STVWZFdlckIz?=
 =?utf-8?B?NUVmWjVpa1RFTUltRXpFWFFMbXI5cXpYdjl4MkJMWXprV1VMa0dMNTNBbCtj?=
 =?utf-8?B?WTA5NDVUaDVpYTkzbVgwM1dvQkE0L1hSQ08weGp5eW5GVEZwdmFHRzF0cko5?=
 =?utf-8?B?RXJBVG1FazRkQ2MrcWYwWjVxRjR3V014TzEyVVorZXloUUlyUVM3L3VDL3Vs?=
 =?utf-8?B?Skdtd3F3anRjeFBZbVY1M2lEdWNyb2lna2JKaUJtbkJ2SWJDWitrZUp6Znk0?=
 =?utf-8?B?YTJqVnZLMjV5NUhHRjNGMzhaaWFjV0dOYjNaV2NUZGJHMnVNeDk3ekNIUTJO?=
 =?utf-8?B?aVIvUWpKemxsT0dQZkZBZ09PVitEZi82VzRJRit5TUx3Y2hwN1Q2R3NTUmtl?=
 =?utf-8?B?T0xPQ3JjOEdqd1dJSU1rQUF5b1h2UGJFbW5SVzdDcVo5WEc4L0U3aVdWcXJW?=
 =?utf-8?B?dmYrcUJEb1ZiK1JIM3h5VDNkWStKajI5VGNwRTNZWnc0eDdMRzE0STZLM3M0?=
 =?utf-8?B?QW1HZForamhHWUk2ais4aDNMT2Z2NTNVYUFqVWtpeUcydFROdU9lbUZnelhm?=
 =?utf-8?B?QmFtVDIwTnhtRWNsTTNlREpwcVBoRGNkTVN6MTVDK2hxYzZ6V1hueTZnZnJY?=
 =?utf-8?B?WWROeGdEbExyL0x1UzlFZXpPR3dvTHd6MTMvOVNtV1JyaTlFS2hBV3QwNEp6?=
 =?utf-8?B?ZWJ4UWpEZmluWTdxWEtML1d6MXNia3EyNXFjR1FiR0FJNEtGb2xuMmVuWklT?=
 =?utf-8?B?K1lhMUtEOUdJNko4ZzVhWVY3d1E0cmVUM2FENHg3ZjBnd2daYVQwMzBuT3Fm?=
 =?utf-8?B?YkJEQnFPSWs0SURxbUt1SDJTS2xWTklaK1dOQ1R3RGRlaVVNRnM4Tm9KTmhv?=
 =?utf-8?B?bTlEdlRLUDJJN1pNOUgxcFVrR00zZnE2bnhEWjhZQ01Bbk8wYjVQamNGL1pN?=
 =?utf-8?B?Zyt3Q1hMSE9PNm1qQkJrYkhUSHRSQmJMRWd5R3FZbDUveE50OHNxdkJ4OEtO?=
 =?utf-8?B?L1M2RXhzTTlGKytYeEVYNVpYcWp2MFlrQlI0dkJ4TlQwRGU0OHcyWTJPZ1pz?=
 =?utf-8?B?Mm1aVXZFOUJDNmRNZkNialdMOWw3WkxyVmk3SU5ZWFExWTBJcWdoMjNJSHkw?=
 =?utf-8?B?S084M2tMM2hadGNXbzBwcStuRnJqRWxyb1RCUzdqb1ZZcm5hanhYVHhuVVMx?=
 =?utf-8?B?eGFxZHpEOU9mZHlhbVV0VG5pVEROREFRVU9ZVnBkVkpVaDdPV01SMmR2SHBr?=
 =?utf-8?B?MzNnODBzK0wwbGJBTjlkdGl3V2J1aUhURXlwQTUvS1dhU0dPYjhEejNRdmla?=
 =?utf-8?B?eW04QStUcVhPWk5aY1NPcTBKbEZFZ0ZwcFlyZ1NzT0RLeGZ5M2lNVEVGUUp0?=
 =?utf-8?B?aFNXcU5OTVpKeGtMS0IzeUJUcnhjUUFmNVZQNlY3NVR2QkROc05JWnI4MWtF?=
 =?utf-8?B?ZUZTMzdOaUNpajVCb2pGOE1xZUwrTDNhUTlGYzRBRTBtR3llUlJibjc2R084?=
 =?utf-8?B?ajM5ZXdOdjJJNDN2WGE2SkhoeXAwdGRvRW9BamtuV0N5elZSSGNaMkFpT2sr?=
 =?utf-8?B?Tis0ZEJHRXhUTERoWTJmQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ZQOXlVWTl6OWxNN3dWSEg3d2lKMGRTNFJuRnh1UU9qdlBWdUdVV3JmdnlU?=
 =?utf-8?B?YytXdnM0d2hTbUhkd01QSkVVMDVXenNiMDN6dDA5bXFKRmVDSTB4NituQzdH?=
 =?utf-8?B?VEwyemJVQW9CMnFQYlF6eXFwdTRNRFczeEQxMUN4dFFGbktCbkhsTGtaMC9J?=
 =?utf-8?B?ekgzQjJNUXEyeVlhZHhLT0RrTmhuVWE3Q2o0cVlRQnp1QVRJSVI1TXM0b0g3?=
 =?utf-8?B?NEE4TVJiaVA3Q2lhUzF4dmZ2QTBmUUd6OGpyVUNtOTJIVFdIYyt4TnE4MzVD?=
 =?utf-8?B?VmdGRlFuKzNxWWVaVEEzOWY2SFJBUzM4RGRYMDZUajdPaFpJc2w5YjRodFo4?=
 =?utf-8?B?N0F5bVlDUDhYUGxXd3ZRM2k2U0FPd1Y2QVRxWi9pQXFFTmZWL0RqNm1abmhs?=
 =?utf-8?B?bHhRcmJQSVpPSXMxQlE4RW9KVktrelg4Ni9MenJIL0pyTVY1d3NuNkZWb3pU?=
 =?utf-8?B?NXdqOFQwMjN6UVZObHN4ZVpPcUlPT2pBZ3Vnb1gzcnJMd2NXTTJNNjA1blhs?=
 =?utf-8?B?aHdXMHB4Nm9aREVJeTJLWVVWRld5ekZtK29qaTYraTVvcUdxK1FQd1dUVTZP?=
 =?utf-8?B?NS9ybXUrN2o1VzlQMnRzeWVwSmhXL25la3crZVZIU3orZXVrSFlnZ3FqcjhZ?=
 =?utf-8?B?d0lTbkhLcFlvRHgwUFMraHFMNVlya3dsUVpua09mQ0xxYXRmb216bGh6NVIw?=
 =?utf-8?B?WmdpYUxDWFZKbjVQcSs1OEZZa1lpMnozWmVodHZHYkpsbVBNYWpmWkZBUURk?=
 =?utf-8?B?STY1bHE0d1liZm5YczRQdTdvYkFCOW90TmZiOVo0L0szNjMrdVNzbklqOXNz?=
 =?utf-8?B?Q0puTURxeFhZZVIvWXFRTjVVUEVVbEtxWnNVQ2FkTGhvdTRtWXdyTFVIY1lF?=
 =?utf-8?B?ajROSWIwTktlblZvYjB6UlhuemRaWEhpazMweDlmNENCK3F3NUw4aFpsTlpZ?=
 =?utf-8?B?RlR3R01WTzZQRG53cmpJR1hRMlBZYTNDSmdLYzJlaVc4cWpHd2Vlbmx5TUhE?=
 =?utf-8?B?MFpheVc0L21VYVN6OE9xR2pDK2NDRXQwUy94bjJaeUFvWFNDVFh1TlNHdGh4?=
 =?utf-8?B?aHY2M2wxUFVETUdJVGgzU2M2T3JWN3BKN2JUNURDVndiay9OQ1Y5alhocTlI?=
 =?utf-8?B?OVpJNGJXdWRQT28rbEdVZjhITFI0MU5RRmNJL0poNnRneG9RQ1d5dXJLNXNq?=
 =?utf-8?B?aDI3WENIVzNUUTVaM0dHWDZLRGVuSFk1U0s5RmxWMFVBbUtJNklBcXJRbHhz?=
 =?utf-8?B?Wk1ycENqNGZmRDMvU1RxQ0J6bWNLVkFraUxuYlJKRjN4MW9EWEZxcWRTc1oy?=
 =?utf-8?B?OWJFbjBpMkhmQ2N2TWdlUnk3TENKS3dSS01WL3FJa25oZGdaaGZoN3c5Uno2?=
 =?utf-8?B?MnBJaWJOazNyQTQ5cVoyeDUzK1d1R1FDeDcwZXZEYno4dHVyK2wwaS95K29n?=
 =?utf-8?B?MGwyc2dxRUxuWTl3RGJaOHR5anErQlNFS1BVMmFPUnV0NUNTa1FKOStjZkl6?=
 =?utf-8?B?OGp4MnNqdXZDbTY2U2NkaE05eGxjWnlQekhjblFKQURKTmtCc2R0VlFkOXFs?=
 =?utf-8?B?TDhyay9GUVZQUTlZYXpZckxzRG5BUXFic1Njd0pkZHFyZDUvUXZoRlZHeld0?=
 =?utf-8?B?bm5ZalVnZGZKOVROQ0F2ZTlldWZkK1V4aFhxNUYrdEgrai9yVlFJa3NlVUxU?=
 =?utf-8?B?eVBrY1FFZWdQYXJUY242bnJOTDBNWGxGWENNaFJvUTIwV0VxSHA5SUZiMHdv?=
 =?utf-8?B?ejQ5Ty9Wd2tCL2NqZk1qQVp3Z0NhOFVCcTZoRUxOTzJlQ2JrRlJoSEZBRXcr?=
 =?utf-8?B?VGYvcEdwT015OXp0bmRvS1FQcDV3bk1ZT0pBZGt3cWpVN25pR0ZES21oVEl0?=
 =?utf-8?B?bmxNNmU5K2FhK3ZHSS9EWHd6VS91aG1Mc0psSlZTZ2FlNll3TzRzM09KQklJ?=
 =?utf-8?B?b1FTbDJrcStkNzdVQitWZml2MXpkeklsWFJuRk13enJycXFvaWNHbUUwTVRH?=
 =?utf-8?B?L2hjcm1tUnFZYTNYWlJXQi9oNHNkT01ZWGdKRUJrVXRPWVFKaEhLNWtnU0hw?=
 =?utf-8?B?b3c3TUFSTkxvUUcyL3R6cXZBRExyVmdOcm4vR29FcE9QamRQQ2w3M3Q2T3RZ?=
 =?utf-8?B?MXlmYTVUR20xM1dvOGhsTFRXQnJLbENOWWVJcklpZmNnbmkyVUNDVm45UXhh?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y+55UbJgBXc93jM+YWUy0vw0kN9lM3OksoSpPGIQL0+XtAXXr2Zz5aypB8AOG3D8UCOrSZJbAj/Ne9HBycWNPLuf8PgohwhKs7PKliQUgiVp+AHdhm0qml4mi5PNqnCwsTq9+qErJdie1qPca7sRfZ7arb46h2wZllvCkPEd6rK/sA1TteNeEuVq4thtWLoaEW9B1A7P+qz59JYTJOMruB1z8TvLy76hP6L3AWdHNfprHW7R8FE0VNtcbLASuf+JKas4yNGB69X8dtZ1xoo+/PE6ZeaJmFBdndvjIbNLGvZ5b3vGhSg5IZbIjSEiXyiHDkl53cf/nG2GuBnIazUkILcEU1QtQ7s52RJ2JBMXalpP5kLJiMgRzqnh+zEx/ZsPl3oY6jDxTrgiXXtkyzNv/1ExLo2aM/vKza0RQH8D9WsmPf/JSG/pTNDGvSENfoWewRGgMN5PuTabGkdxaPO97mKxaNkV3HeV9qCrrzWm4fNYzI7ugnZ6+Ax7TrJ6f+zhxq3tDsFQJTeY+E0Mj3CAP6lF7k6sr1Tg41N7lpMKBGGWf9XMUQH9X2HnYSJhrT68s1wuBRn7z8WljBI2sTHA2lzw1iMU3c/pmrC8fRk2E9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8aa3c0-c279-44d6-3a7e-08dca679ecbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 16:02:57.5292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzTUSkL0ReSle2+RvfTEwkcUnvnFVp8MmDsY+AJBIfDEunLwHa999sti2xbb+kVAtBuyaR7E0vLxCAyQsu36/5RrF2V0TURlfDQ7r7ViSPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_12,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170123
X-Proofpoint-GUID: D2GL00MoICQNRl09CQoN8yKZDsTt1wfT
X-Proofpoint-ORIG-GUID: D2GL00MoICQNRl09CQoN8yKZDsTt1wfT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 17/07/2024 16:35, Joao Martins wrote:
> On 17/07/2024 10:20, Joao Martins wrote:
>> On 17/07/2024 03:38, Duan, Zhenzhong wrote:
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 34d4be2ce1b1..ce3d1b6e9a25 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice
>>>> *vbasedev, Error **errp)
>>>>         return !vfio_block_migration(vbasedev, err, errp);
>>>>     }
>>>>
>>>> -    if (!vbasedev->dirty_pages_supported) {
>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>> +        !vbasedev->bcontainer->dirty_pages_supported) {
>>>>         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>>>             error_setg(&err,
>>>>                        "%s: VFIO device doesn't support device dirty tracking",
>>>
>>> I'm not sure if this message needs to be updated, " VFIO device doesn't support device and IOMMU dirty tracking"
>>>
>>> Same for the below:
>>>
>>> warn_report("%s: VFIO device doesn't support device dirty tracking"
>>
>>
>> Ah yes, good catch. Additionally I think I should check device hwpt rather than
>> container::dirty_pages_supported i.e.
>>
>> if (!vbasedev->dirty_pages_supported &&
>>     (vbasedev->hwpt && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)))
>>
>> This makes sure that migration is blocked with more accuracy
> 
> I retract this comment as I think it can all be easily detected by not OR-ing
> the setting of vbasedev->bcontainer->dirty_pages_supported. I should put a
> warn_report_once() there.

Something like this below.

To be clear: this is mostly a safe guard against a theoretic case that we don't
know it exists. For example on x86, this is homogeneous and I suspect server ARM
to be the case too. embedded ARM might be different as there's so many
incantations of it.

@@ -267,6 +282,13 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     vbasedev->hwpt = hwpt;
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+
+    if (container->bcontainer.dirty_pages_supported &&
+        !iommufd_hwpt_dirty_tracking(hwpt)) {
+        warn_report("%s: IOMMU dirty tracking not supported\n", vbasedev->name);
+    }
+    container->bcontainer.dirty_pages_supported =
+                              iommufd_hwpt_dirty_tracking(hwpt);
     return true;
 }




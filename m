Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2q7-0002dw-Q9; Mon, 19 May 2025 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2q6-0002ck-4L
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:55:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2pz-0000py-9B
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:55:41 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEP9St014776;
 Mon, 19 May 2025 15:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=op4NCVt1/I6mUFp6AmTHUwZEmlrWBdBcdH+w+Px4lxw=; b=
 gUpruzTbpH7PFKmF5bq2gIN9E6AiihEAtG+/qWzK2vBpAgWYAWTvyk5sVQmv5ore
 dS18FAHrFPUGBsEUK8N4f3ab98Q8+RtKmPq39+59gH0iCUsToadnwKW/sO5RmsT4
 gsDPq7FBqJMM+TwUh+pqt8YSHPNOOqiZSpC5oNITAU+s6KPE5B+dQWHI5xt/fn8s
 KhFnRDdh59ftUnjgLTqa5oGZ3ywXYjNLcvwF0DWfRflb2GaEBHLyvFCuDNFYX/uv
 CWmaXtxV51/1PdgIFPlE0aqvezBQFbzRgfcuC9tpjzf5sVbSrzxfMqJVRALMCXa1
 tApDOQPKh9ounBt2VbzOjw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge3djy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:55:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JFD1KJ016681; Mon, 19 May 2025 15:55:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6mga9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDpBhFnMTRKc9cRDSUpJ+5fmK3znotihtgDyv5HIyfRnnx9b/WiBuBHDTJu3tHnRnPW4BMrVjA55wGd9oIpSMXNZWK8sSdwK+/+4Mb/XeAglgoAskI0z9KinojTINmRWIGW/yAlK5SlnLbJd1j52YFFHAn8GwgkIcVFEEGJjTFDBRhLEzbB0b30qS/3TI1MKNLlYMLuivY8Rf5DkV0dtX2/BcqKlHKFNnN5GXGRSMEQaoxxBVUxiuYZGIPVmVgpVuGjef5U/yGKfWTnfrQk4jmNxz6+ZUVW5bLAd84Z75ndbiMkluWtV46BV4LLexPM1f8v+fgyCIg8Do0qVoSzZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op4NCVt1/I6mUFp6AmTHUwZEmlrWBdBcdH+w+Px4lxw=;
 b=In7/vY+vfgIztHUr3S6xKO4Kt9GKA6XK8EQOSAmWl78p388CZYoF+ZMbegYdqelgD+qUjfOn11a8vPLqVelpiV58Di2Ka142S2d55iSBBd8nD/OXeP864tS2bOFnwGtQnYDqrvDxfhyPykDO06AMnlD1GnOW9Enpd/jf68QH4wWSFIi/chn6iKuAjKVrZ0QTBakQrEtFN1cTOSUzF3RjZfTqrcS5MTY4/TxnNoLY3thd1+Xnxi/leSYyaNDLjpchUdiV2VeZ/yBaeFoyrALwIK952dJAxnHxYXrsBPU/ikkiInau8vccJqWrvu+wF1o/oiDsjqI4AFlplgiT6slHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op4NCVt1/I6mUFp6AmTHUwZEmlrWBdBcdH+w+Px4lxw=;
 b=ahjMdazvml31LokJRGeMBov9+C9U5kVzCEvpeAES6h2OREmhYlsGugQS2xLpFmj1CcHreL2KJYY4hhOUQYexwmu/pG+LOLZ35hwU/3C9AydbzMdRwrGKJhB9ecO4gtIH3KNtOtlQVomGSYiyQmDJCEHwwH0oivo1I5yDNeUqR3s=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:55:25 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:55:25 +0000
Message-ID: <f0a68359-399d-42fd-ae26-45b0324a9c93@oracle.com>
Date: Mon, 19 May 2025 11:55:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 147c1d36-abd2-4791-48f4-08dd96ed9197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0R2clFUWnpVKzdtNHVlbXFHK0hOaHpCZUtOMFJkMGNKaFE3d1FYaTBpcU5E?=
 =?utf-8?B?NnBCbGczMWRvMjRYU01SbzZieEwxWE1WdGdVbmtlR2JnK2ZSenJrekM5dDdY?=
 =?utf-8?B?UFJPdFFiUGF2SE9pRjhzTStwNlFCdFFTSGxsRkFLYTRQbXRpSWp3dFNxeWQ4?=
 =?utf-8?B?Nk1vM0IzN0RrN29WNjBuMzlac21GRTBqckdqMDh0dDRkNDQvcWlOQlhxdnV2?=
 =?utf-8?B?TitTL3pHbk1RWnBWNGpNK3ZLNm9ZNk56cEs2QVdmdGRLTmFxdXE1Q1dPdmk1?=
 =?utf-8?B?bDRaelQ0dWlYbkJ2ck1MbEZMSlVueFlIS01nazFmeVZ5ZUhyWjA2VVZKd0F3?=
 =?utf-8?B?bTNycUdYc1BCNUMvRVZvbVFmelp0TjdreWJHUHN3ZG0zU3Z1OFRsL3RkV1NM?=
 =?utf-8?B?dGZIUDcveDBoQUwwUjdGQm5zUEpJRXVMWlorZk9YMFQ4MVAvT1dZNVd2Nmh5?=
 =?utf-8?B?NW9lK014S1pRWGRhU3M0aE8vdk4rR0IrTG4zUGFDRHpiM2YxZG12Rm95VkVX?=
 =?utf-8?B?RkFabVhsM0Z4V2tIcnVzOXZLSWlReGQzUXM2Nnppd0JIVlhKVUE4MkxRck44?=
 =?utf-8?B?bDBQdlBheU9hWmg2cFQrTGpFUERwZ1pBK3ZqdUtZN1VkUmVDeTA2cW40MUQ2?=
 =?utf-8?B?eFRGeExGU2RWM010VlhpSDZJS1pOczB2VEpJM1lyTi8zT0JncWdlZTYyNGJp?=
 =?utf-8?B?QzMrTy9aeTBQQXVUSDZrQktsdDExbGJCMmxlNCtpRVQydHhVd2pDTE11dlZG?=
 =?utf-8?B?cWg2UFFwYmM0OVA3YWxQVFJVRXhpQnUrakhrSzFKc0pwQVFZMlJ2dHZJYlRj?=
 =?utf-8?B?cFJ1VTNDQzFZMGdDbTRMcm05K1c2Tnp6TGMrODVrcW9JV0RFWlpCU2hwakFx?=
 =?utf-8?B?NCtmc0RNS29hRWFTdmc2b2g1QWRkVWhCK1pZSmdHR25jSUxHQXZnMnRTNm9k?=
 =?utf-8?B?UnU3Vlk4RGFxTVFPWVpNSXBLQnVRZEZxTGRpV05lQlFPc0RNQnNiMU9DQ0Y5?=
 =?utf-8?B?WlY3WUROaHo1NGNzVm8xNVZIb1Ura3hObnZldTFZUE9Jb1Rlbzh2T1NtWU1u?=
 =?utf-8?B?RkdyNEdyN2pWd2FYZ2s1Z0FIbVZmYVF0TmM5UnZIdHVocjVrUU0zblBodWJa?=
 =?utf-8?B?ZDdVZHJCQnFqcGxvTkNNdGZJNG5mUkNFN01NYXpEN2MxSkhUK3E3SWpiZGFz?=
 =?utf-8?B?clBSeVdkZithVnFmUlZrOXRQR0N0T0J1dldUcTFaZ3FDYnpubldjS3AxeVZw?=
 =?utf-8?B?UTNZZUYyOFpEam9iUWtTeUtmVE0xM2NUTU1uOGl1aWoxaFFpcGJBVWRFUFRL?=
 =?utf-8?B?bk5LUEpqTGtZeFZodnp0aTR0RlJpTE9PNk5Yc1p6c0RZVTd0akN3OUJLaXR0?=
 =?utf-8?B?R1VvM3lRd0YyajQ0S3J4THNrdnRxTVQ5YzJIMGFQWjA3ZFNIbUt0OWQvZ3di?=
 =?utf-8?B?M0xxS3NKOEVlSnV6L2VSc2d6clNiL05FcStrT0tnRDJrRDQ5ZFBvbVdZcVNt?=
 =?utf-8?B?U01Ia1c0SGtDaEZQM2J0QU50K3ozTjB1RG1QcmF2c0pPUFF4b1YxMkVrWXM0?=
 =?utf-8?B?clRzMzVlM3pIVUVvRkZZV0NSZlRmd0wrUzZ0S0llTWlsb3pQYU1YSDAxcm5Y?=
 =?utf-8?B?bExuWkVLemJucVMyTllPZkF4K3A5NnhteEFxNmxXdFRUL1lhaGhFb0taaENq?=
 =?utf-8?B?TUorZkZDNFZiTThxN3FwWFNwTG9xRnU4WnRTMmdQN05PWmZGYzUvRWVFdlo1?=
 =?utf-8?B?WlJWU2JDZHZrbFMzblk2UG5aYUdidWxVN0t4MFFGWUl3NHRwdlE3VDRMMUpZ?=
 =?utf-8?B?L0RuZ1RhQUp0bW9qV0htRmVvK0tHK2Z0MmxMNW4wbnFNZURjS0xjWlpKUVRx?=
 =?utf-8?B?NEhjVytKZk5Ubzl1alBzalF2RFFBOEpnSUJmU0xqK2JFQTU0a2ovdzNaVGdj?=
 =?utf-8?Q?TuBdEQ/4Cck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlA4cjIwZHJXUFhBOU42MnR5NGJiNkNGVGpmeDZpc0ZEbmRBamdsTEJzSWdq?=
 =?utf-8?B?RENrbEFzRDVENHR4Z1BuTEl3cHJ0Z09ab0N3QzZXUDZCQndjckVNYUg3NnBD?=
 =?utf-8?B?VFg0QXZlT3ZNZnZxaDBYRGZmSVNqRTZDNVFZbVRFL1pDcEdpdmE3ZFY5NG4r?=
 =?utf-8?B?WTlLMXIvRURHTjlTRjJoM05QcEJGbHhHS29EakNBdlZMOUdPWjNOcGlFbEtF?=
 =?utf-8?B?enpkaTgycFZjTVdiYzV2aTFOZEZVbGkyQXJqc3VEM09hZ09FdFp1QVNUcDQ2?=
 =?utf-8?B?RnNaNnRZNUN4Q0JHMHI2TVdQQlV0RnNJVXJ1cWtzTmo4Tis2TE0zQ0ZDRzZB?=
 =?utf-8?B?SHlTRk5Qa2ZBY0R2THFkNmFRYXhnam5YbTg2RytzNnZCcGoybVB5bWxOZ1RN?=
 =?utf-8?B?VFRUalhkRWZGR1lTdGRoMUNwUFNPYlZCS2dJc0d6cFNYTWh3SlpVVVE0MG1k?=
 =?utf-8?B?L0pGdzBFbzVoYjNEMjN6WGxhSDI2UFpjSHU4TUtZMnMxajRoNm9WMnlrTlZa?=
 =?utf-8?B?bEJpYjlMeVJuNkNPRE93L25JZzNxdSsxWHNkb3dzaXFXNlhSWis5V0JvdEYx?=
 =?utf-8?B?MXJ5bXRvMXRmU3pXa3R5T2RNVjhsa1MzcysrQTNtbCtlUnNlRkduSHRERmsx?=
 =?utf-8?B?Q2VLUjdvSUxvNGtHaklkNnF5T3RKL05BdUVNZTBpS2Zyem1RTmZhdWhWZUo0?=
 =?utf-8?B?RHN2a0xFSEpoZzk4VjVVUERMSWhMdlkxNDZrR0tKTDYwalpPOGVQRVd2OHVi?=
 =?utf-8?B?QmRRVDFSdkNSdGEzTHk1TXpXSm1WeTlwZEcyS3dvZis3RThHcHlqSWdPSW9o?=
 =?utf-8?B?U3djQWlMMmJkNDN4M2JqSFhMRDlBVHlwUFY5NUc3UUdiVlF1SDdneW1JQ2tp?=
 =?utf-8?B?T3pYVG1qVXNSU0JhRktuWG5aMEpsYmZzaFB6Y01PWXBsQWt2TEZRZnRiejgw?=
 =?utf-8?B?azlNWFdmSVRFUDVJTFpRdGFiSDl2NWR0K051T1Y2Z1J6VTEvTVRVSzExRzJq?=
 =?utf-8?B?aWY3akQrT1RLbkFSYlZZM25RYnpOeldFQ3lNR3lrbU5WQVJRUlp1YzNnaTJ4?=
 =?utf-8?B?KzlOTEJnVDRuZjN3YlNnRElZYi9IdnVZUEMxZEt0TVdSSVlqSGhoYmhhZWV1?=
 =?utf-8?B?NDJVOTIzTm00cTZkbHFLVVBTTVRJejAwUWtja2g2cm5CRmdhdldnZkpNZUVT?=
 =?utf-8?B?bGRQOTB3bUZtNjYwM0VBRjkxTUk4a2hEN2NxZjFhNUh4ZURtQ3dSZlgzSzZ5?=
 =?utf-8?B?R05oakJIcUNtYWI3ZXJpZVdUTDlWeFRVak1NbE5qNm1OVkVxYW5hamdSaFV3?=
 =?utf-8?B?NVFKSmNoWmdZa1hvRmhLUDZ6dHFEdlI2eEJEZUpEVFQ5eU9uNERkL3hVTnZu?=
 =?utf-8?B?MW4xSEgzc1FmN1V5Vy81alR3TnpBc09BZ01YKzMxaHRERUovK0VFdCtTTWJq?=
 =?utf-8?B?RDZuSm1JcWlsbzhVZ2M2aWZGd1Fwc2pzeUc5S0hIenhRM0NpREtlMlg2OHJZ?=
 =?utf-8?B?cnJnWm9NV2ZYWi95MFROMWxZRkhoaGRFVFVxMkF1ZEFEWm0xZXlGQlEwMm90?=
 =?utf-8?B?K1hJK3IzckhYcjFQZkpnQjhZdHpYTGM5SEI1NlhnckpNVlJ2Wi80R1ZLdzFt?=
 =?utf-8?B?M3RTV0xZR3NTc3B2STVBUGpobVQ5aXRGYVd1dmRsWVlXU3d0VFNrZ3ZvNmlr?=
 =?utf-8?B?eks5MHc4dFNXcmkyR2QrUUtxRDhPS3NlWDJqUGZ3TWxJMGtjcXlJVHJMWkp6?=
 =?utf-8?B?bFhiU0tGdnFzbVErZDE3SWRVWndQMGNQWi9pT0VpdXZBZnZSZ2RqY2hQOTFL?=
 =?utf-8?B?dGhqQ2xRcVFLV0RkNTErMkIzZ0xhQ09TT1U3Vlp4cnREK0E0UndBT2ZHL3V3?=
 =?utf-8?B?eGFTcS9tRzZtVXhrRXkwLzdVWGV0ZEpHL1N6Ny8xMnhPWW05VGhUclByNjU4?=
 =?utf-8?B?ay9rT3BxbWNmN0hMcVBFM2hQTjNTcFFxTXptVlA4VEtDcDF4R3loOVA3ZVJQ?=
 =?utf-8?B?dDJXazNESFNWekwzckJHVUlvTlBvZ3NTRmc1UHBTVk1nSEtQYlRQMFFyL2pU?=
 =?utf-8?B?bEhML3hKbzkxMm5Ic0JnUHR1ZXJaNmxPalBDSUwxcmdxK09WL2lPL2xuU2FD?=
 =?utf-8?B?OXpJendFMmQyaEY3cTQ0UHpyeTd5TU9FM0pkMzZ0WUJpTGxpTEZZWHgwTGJn?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xzjm+wweCZs/RMLHi6MYWvoYWeEdpAFeN7xJVPlt2UPSGo1NMZlPvzLUm0nMKOv5CsDzDPImkleHxWnl34H5uWAPLS0QXxiIZeegW28L3fPImKyAU9UQmAPrmja1rcWxJZ4WP6EBHIO/io4j/r3Hyl8I7u7Hgc3QvZmMWb7PAdekDm/elDSYKI3IB9aBltQ7sbDM5HnqSouAJ1TyCIVhhTEU4CM2AFrq5ywv/UZrEl4NGTojjeFsIhILh3O7AR0gfZ0bsJ4iTFflWqriE5DvvHBSXRpkjV27UneRGTnlQrfkXLYC+O/O9cMD/8dGIE/TYrJ2QzFW+yzIrInCVzt7DUUvshyevCrr68c/NKJWZIaBdsJzCLRCk9/Hjsidm7Q/BcPCV88QQOXHZQFBzV7XREwhn/KkFaVwXoVRx94eD9ncSuFv2x1YN8DrXwClpZQGKClxf2XaseYOtT0DxgGka38vnZnD3EOtWNH/HPjXZRh3SoM8iLHRWCMN4/J0XBo2nhJwUzZFHZbmsqLzpR82PanCvMjFR7CvE4c3KiVv8RgLzwciAxXW62SRen1ELcq1TT/nn3ln+8c+W7aiJMsBxjlpqkb8aG9wXZK+QU9mI2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c1d36-abd2-4791-48f4-08dd96ed9197
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:55:25.2102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmJvTOdd/o+gVRXVgS3TY9f3qW+d4+mor1JMBxo0kb4bw1tD64dy56CwqGZoH8YkI/+5dR2nkRn1Qkog1C4Tgz+k/v4I2uyJsuZE7hUxn6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190148
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682b5474 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=WtupwYKIM8AIT5l_F-YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfX6RCsdlwjib9a
 c8FDucphXSSeoI94LXlVcxs8vorjoE76Fs5u4oAGV+c1WLbLlbDLB4U76uVBjI/1LzEtBOR0dvc
 Z7GfU7J8wtBPATzmsglLt3xr+79rKvZl0uYbxvaAcRuJpaoyzymawfz5/kYZkk5sR6EM8h/kJYR
 bJP3ELRwsnH7A+iSGa6UpiDPSoHZsG8ri+96AQ9CwEPeaWiQXLUXtHQiHl9QLonF155jvsJv4Qq
 fNgluiXIS6BygfLp2W1HFYvzZgouudWanXST59bbHEcGHW05HTfQZhnxKhNm0GojqGlziVrIvOm
 h/FNmWoCHUQVV4jJyS/xkQviMaUdJ7Oxx/xLMSRes4YW07lsyuHtjRZPbxelNURQtWuZjhkmIuJ
 xYlMCZxYtdDEQ/7Njua0pJj/Ge+MnWi4PL5m9q1wQxJmn2dsxhbvM1oXga5Y8qkv454irdjm
X-Proofpoint-ORIG-GUID: MVoA3QblPX8ljkc6-8IOjsNI0wLU8tbC
X-Proofpoint-GUID: MVoA3QblPX8ljkc6-8IOjsNI0wLU8tbC
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 4:55 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>>
>> Extract hwpt creation code from iommufd_cdev_autodomains_get into the
>> helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
>> be used by CPR in a subsequent patch.
>>
>> Call vfio_device_hiod_create_and_realize earlier so iommufd_cdev_make_hwpt
>> can use vbasedev->hiod hw_caps, avoiding an extra call to
>> iommufd_backend_get_device_info
> 
> We had made consensus to realize hiod after attachment,
> it's not a hot path so an extra call is acceptable per Cedric.

I'll rework it per the consensus, but I suspect the result will be less pretty --
code duplication, or more conditionals.

- Steve

>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/iommufd.c | 116 ++++++++++++++++++++++++++++++----------------------
>> --
>> 1 file changed, 65 insertions(+), 51 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index f645a62..8661947 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -310,16 +310,70 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>      return true;
>> }
>>
>> +static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>> *hwpt)
>> +{
>> +    vbasedev->hwpt = hwpt;
>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +}
>> +
>> +/*
>> + * iommufd_cdev_make_hwpt: If @alloc_id, allocate a hwpt_id, else use
>> @hwpt_id.
>> + * Create and add a hwpt struct to the container's list and to the device.
>> + * Always succeeds if !@alloc_id.
>> + */
>> +static bool iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
>> +                                   VFIOIOMMUFDContainer *container,
>> +                                   uint32_t hwpt_id, bool alloc_id,
>> +                                   Error **errp)
>> +{
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t flags = 0;
>> +
>> +    /*
>> +     * This is quite early and VFIO Migration state isn't yet fully
>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>> +     * whether IOMMU dirty tracking is going to be requested. Later
>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>> +     * instead.
>> +     */
>> +    g_assert(vbasedev->hiod);
>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>> +    if (alloc_id) {
>> +        if (!iommufd_backend_alloc_hwpt(vbasedev->iommufd, vbasedev->devid,
>> +                                        container->ioas_id, flags,
>> +                                        IOMMU_HWPT_DATA_NONE, 0, NULL,
>> +                                        &hwpt_id, errp)) {
>> +            return false;
>> +        }
>> +
>> +        if (iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp)) {
>> +            iommufd_backend_free_id(container->be, hwpt_id);
>> +            return false;
>> +        }
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported |=
>> +                                vbasedev->iommu_dirty_tracking;
>> +    iommufd_cdev_use_hwpt(vbasedev, hwpt);
>> +    return true;
>> +}
>> +
>> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>                                           VFIOIOMMUFDContainer *container,
>>                                           Error **errp)
>> {
>>      ERRP_GUARD();
>> -    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> -    uint32_t type, flags = 0;
>> -    uint64_t hw_caps;
>>      VFIOIOASHwpt *hwpt;
>> -    uint32_t hwpt_id;
>>      int ret;
>>
>>      /* Try to find a domain */
>> @@ -340,54 +394,14 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>
>>              return false;
>>          } else {
>> -            vbasedev->hwpt = hwpt;
>> -            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> -            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> +            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>>              return true;
>>          }
>>      }
>> -
>> -    /*
>> -     * This is quite early and VFIO Migration state isn't yet fully
>> -     * initialized, thus rely only on IOMMU hardware capabilities as to
>> -     * whether IOMMU dirty tracking is going to be requested. Later
>> -     * vfio_migration_realize() may decide to use VF dirty tracking
>> -     * instead.
>> -     */
>> -    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>> -                                         &type, NULL, 0, &hw_caps, errp)) {
>> -        return false;
>> -    }
>> -
>> -    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> -        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> -    }
>> -
>> -    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>> -                                    container->ioas_id, flags,
>> -                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>> -                                    &hwpt_id, errp)) {
>> -        return false;
>> -    }
>> -
>> -    hwpt = g_malloc0(sizeof(*hwpt));
>> -    hwpt->hwpt_id = hwpt_id;
>> -    hwpt->hwpt_flags = flags;
>> -    QLIST_INIT(&hwpt->device_list);
>> -
>> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> -    if (ret) {
>> -        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> -        g_free(hwpt);
>> +    if (!iommufd_cdev_make_hwpt(vbasedev, container, 0, true, errp)) {
>>          return false;
>>      }
>>
>> -    vbasedev->hwpt = hwpt;
>> -    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> -    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> -    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> -    container->bcontainer.dirty_pages_supported |=
>> -                                vbasedev->iommu_dirty_tracking;
>>      if (container->bcontainer.dirty_pages_supported &&
>>          !vbasedev->iommu_dirty_tracking) {
>>          warn_report("IOMMU instance for device %s doesn't support dirty tracking",
>> @@ -530,6 +544,11 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>
>>      space = vfio_address_space_get(as);
>>
>> +    if (!vfio_device_hiod_create_and_realize(vbasedev,
>> +            TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>> +        goto err_alloc_ioas;
>> +    }
>> +
>>      /* try to attach to an existing container in this space */
>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> @@ -604,11 +623,6 @@ found_container:
>>          goto err_listener_register;
>>      }
>>
>> -    if (!vfio_device_hiod_create_and_realize(vbasedev,
>> -                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>> -        goto err_listener_register;
>> -    }
>> -
>>      /*
>>       * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>>       * for discarding incompatibility check as well?
>> --
>> 1.8.3.1
> 



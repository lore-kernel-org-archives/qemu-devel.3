Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5EAC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7v5k-0002El-PD; Thu, 24 Apr 2025 07:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u7v5g-0002E5-R3
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:50:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u7v5d-0006wW-Tg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:50:04 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBGxIB022029;
 Thu, 24 Apr 2025 11:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=TAyy1zhGTTsehidckZ64/zMtBZpOdrsV35xrXIYwEo8=; b=
 VbFI/wL2j+BJDn8YLjIg1ldBkXv7Ny+i8UUdocu+bzoYerW6QdIH19G6cdjLqXa9
 jMuOXfoWl/yob+fTWy3UteJV7dmZfw7neu24PODCuVjItmuGwQQz3+h35GPcrMty
 Hm1rqY8nYblhEOrWFFUdFCGnfiS1Z+baY6gQWaaZ+kwO+z87jpliXQYnJm4xtDaQ
 GkZp0d2AAPmIWcFOKfl0+nnkP2ieWtMbEMzFUtClAkGKHaPSsY6/J2VTyeJogFdx
 2b+IOhApN2hGycuZlmSMxJX6nhkhmsXDpYOlURTIiQ94k+1jczmOzss9mgFlu9Mn
 NL8NDO40RhzAzCJHpMszHQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467m9n01gm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 11:49:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53OA7nmu030849; Thu, 24 Apr 2025 11:49:52 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 466k075955-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 11:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqzw8aK9IDv+AInlK6290Rn6jopjONZWXAWUaK0i+U2SI3YexOGGJOexYGQcBU1L5F5n+8210KJIiy43/5ZNsqf4Ifqzge3cULfjzkSCj8Xgql8xX3qFeYUjIRFTVvqV+eJtjuMfNnJqEsh+h3O7JBG3cgA4xTg+sTnU7Nba/tWHeNOhgPD5SIWAs5eoRQ3AJWq3cpKxCcuHMut7pnvaEyN7N5UeYWlhWIYQw7C8+iCTUNJ2oXgsrwO09GiPKr7L058BOhHm6L8iLKZm7B4om9HYO/2QLUaUEEn71AVa1ScVf3rJTHqFTY9qiKzTwhGw7gSZ+i5DDGZLQ0Pl8SPAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAyy1zhGTTsehidckZ64/zMtBZpOdrsV35xrXIYwEo8=;
 b=imipTrxp9cF+K2LCJ6QFgwTNt+VgK+6GBaT6g/L1fgrpvZ0K4DYF4WMNh4X2F+0+cQLKmy8Lq0aenwco/Oka9F9KOfstQPGxR0TxFHlNxcUQGIwzMiJj8xC+cOkCEIpOdJmJpYNOAANjxmdUQfJFH7xp/06+nkVZqSGJJlIWQGrB6DaYU4OMlQGEGCWJ/L5I1UfFicJqpZ114686aOgu/08ZXh1FyD9GXOlW8YQMq5KNYSMs/K38ItxwUD/pNAqEtcaatwFL/Yiru6KXq19v8GGPtqfOM9WejXGJrBFmqeh3XyDc4gWFKR8JorjHwsgMnuCE5LtWMWda0egAkuCKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAyy1zhGTTsehidckZ64/zMtBZpOdrsV35xrXIYwEo8=;
 b=dUcHYIZQ/dkNkWnvAIafwS2hhSzNU+PGDTL4WBb3li3S4VtjRJDRS5II4IeaqbLzvDEc3Nv/iLPE8Q54Gw0jOgPeOzPkMjsnzFXGMTpnKKoN8HJesdUwMUtOcfDG8obCIrPmGFYqzfP490nrWMg1LhlpSp/1zOM187S7ryl8ZkU=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by PH0PR10MB7063.namprd10.prod.outlook.com
 (2603:10b6:510:289::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 11:49:49 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 11:49:49 +0000
Message-ID: <6dce949e-8008-47ba-9e0b-74f0781a7757@oracle.com>
Date: Thu, 24 Apr 2025 12:49:42 +0100
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 00/18] AMD vIOMMU: DMA remapping support for VFIO devices
To: Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, boris.ostrovsky@oracle.com,
 qemu-devel@nongnu.org
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <cf8587fa-f6e7-44c0-a33f-fa118e0d806d@amd.com>
 <0de21fc6-72d7-43a8-ba03-6cd65b5eeedc@amd.com>
Content-Language: en-US
In-Reply-To: <0de21fc6-72d7-43a8-ba03-6cd65b5eeedc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::16) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9059b18a-cf74-49cf-5804-08dd83261dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3p1NUdhbmFrczZFQmhSdzJ1MDk2UXdrNENmYkpNR1FtZER2NmR0ZWJhWHNP?=
 =?utf-8?B?ZndwZEtnb1RhL3ZkV2IrV25NV1BaSHc5MlAvak1YMmp0M1p3UVBVWUplWFZi?=
 =?utf-8?B?SWpCWkF0MnNGS3QzYkF2OW9YUkpiT0pnSFJMNVpUWmZvTUxoYURrUFVDRHpt?=
 =?utf-8?B?d3V5VkgzeHIyR1VtekUrUitjcGwvd0JSaTgydlgvWXlwaHY0aUhMV3BrdFVF?=
 =?utf-8?B?cmJjeDRDb21jRkJhNHJacG00cmhpNVFuL0JUNDcwOEJDM3pldk1HeGUyYVpo?=
 =?utf-8?B?V21GMmRtd2VCUm0wclo3eHcrOHdnRFN0aWMvYWdlQ2ZHeXh3ajBDME94dWk4?=
 =?utf-8?B?WGVDUi9pOHRQZU4zUm5aSkEyQldmblVGMEpVUmtwdGwzTStiRWhvK0pYMTNT?=
 =?utf-8?B?RURhNGJGM0dFcjUreVdvbUJDRFFQQjhsVEk4NDJYY1crR3huOTBjbFY3cGVR?=
 =?utf-8?B?V01qTUo1SHFtYUxHYlQvWDZyZFNOZHlpY3ppUTV0eitCNVpIV3RhYVJMd3gv?=
 =?utf-8?B?ZXlLUDFSVDNlM2IrbVh5NityUDdQRjRrc3hLQ21NTDZPdndpTSs4NVRIM09j?=
 =?utf-8?B?VXhpczYyMEk3Zndrc2NMa2lHNGZ1Y1BrY3RNbzFKdXd3TnVJOVpoYmZLa2s3?=
 =?utf-8?B?TTFuQlJoNzZlM0pmWDFZclllUjR0VzduWjA4R29kZEFKaTBxcGE0SS9kdlc0?=
 =?utf-8?B?OU8zdjZHbVUycXR1em1zYTRFM0ppMllEYTBPYmJKN0RiWU85QkNyQVV6Y0dq?=
 =?utf-8?B?clY2WWhadkQ2WXF1OGRzNEYxZUw5b3M4VzJkL3N1OHJOcDIyb21HNkhuaCtE?=
 =?utf-8?B?TUtHZEdqV1Q2NUdQRnRXbHhXaWgvN0l5L3JsK1pzcVdGQUhrZXRzOWJ3RmZO?=
 =?utf-8?B?Qk4zT3FadVRkQnB2MlhWeDEzSDB1V05YL2g5MnQ3dlBiNWZPWDZWaVl3cmZz?=
 =?utf-8?B?bEYvdXVQeTNDU1BoYUMrWmhSd3FDVXhvREgzUTBXSFNNbnlMd3c0SXdXbzcw?=
 =?utf-8?B?VTA1Ri9HbUYwbzFJRXRLekp0YmptSUY5T3VGeU5aZkhWeHRraFhrNDlqZk81?=
 =?utf-8?B?MGpvYlAzVU5EQWlFbEJCNjdlU0R6MEVCRFgvak52SzYvWlZkWFEwdDNpeHp4?=
 =?utf-8?B?eE1mK2V0amVTbkI4ZGh4d0lYblJSOGtZRDJwRUl0blI2NzNuOWFPMmwvZ0pE?=
 =?utf-8?B?MmlxWEwwNXBYcVMxZFA2ODJGRldoOXRZK045YVFuR1hLQzlMT3grcXJBdHdF?=
 =?utf-8?B?cW5MZzVmRWE2SkRBczB2MDhIUmg2dVRZbTFweDFTdmF2YXpJMmpZZFJJQmFG?=
 =?utf-8?B?R2dKaWpLRDFDK0hmN3JUbTNVQnkxczJ2ZkhxclRkYnl0MU1kVS9EREdFZm9r?=
 =?utf-8?B?cTRpOVNtRThQTWFWVkRTeGIrRlZhNmtBY3dld3l2RkhQcmZzdWh3QjExdzZh?=
 =?utf-8?B?TWNyQTlXb2d1d3dOWUFaYWdxZzJRWHluWUpMT1lGMEh0cTM5QTNKVGJZcCtp?=
 =?utf-8?B?SzE3UU41czZUY3lLNHBKQjVLeVd6Zkt0c1Fta2kweDVveHJjam03RnJQc1cr?=
 =?utf-8?B?ZWh6ZE1TcEtiZG5wcHhEbmZBRnhYQllab240bTRpcWE3VWU0aGpSYU9xNmJi?=
 =?utf-8?B?SDVySXBnRm13VWFwUXpzUnFpY0NsSzRDYjdsUWt6a1RVTlpxUWYyZ1RnaWg4?=
 =?utf-8?B?OFI1VVJCMHZVaHFnS1J6MkJtNlpkbEZnczNxMGpQMWhxTkFVbGZ2b3dxcU9k?=
 =?utf-8?B?SVExOHpHNERXV2JLTDNObS9ybDZOZmU1M1pkdDBPMFQxaUlaMSswRDcwM3Ax?=
 =?utf-8?B?ME1GWkJ5YWJKdktCVUhoaXVvdHNxM29MNUxYckhPVXkxUXNYcmR1VXZ0TE15?=
 =?utf-8?B?Q3VIYm9kKzJDdzZ4TmVMQUpsZkNRYzBBU1V1U3U3VVNpYzg1ZUFyV1gzTXc4?=
 =?utf-8?Q?sI9IJC3OzQk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRCRDQvbnU0MFBLdmM1OVBUbmhUcFpzS2xNclRycW1CVGJ2M1ZPTnFOUDJX?=
 =?utf-8?B?MlVBMHBaeXBsanUxRnB1cGZtcVZlNjlIaE9sMUtNT2RPd2JqRzdxVVMrblBn?=
 =?utf-8?B?OHN6Y2tibFpSeDFQbXZ4bE1KOGExZW5DSDNWQ3dsdUQvZXZodVh5SkdDKzhQ?=
 =?utf-8?B?UGZHOTd1NDlST3Z2eG42dWx1R3VJZU1SaUtzSllZUk55UG5UZ2RjbmJNQWll?=
 =?utf-8?B?bnFoY2ZZOFRjNUhlQUxXUExibURGbUhETkNUc05ldEt0WHN3cjZ2YlY1SEdh?=
 =?utf-8?B?K0o2M0hHSFhHVlVRMWNVTE5hVnRIZ2Jqb2s5aHNPSFdna2FrdXI2aWJWcHFv?=
 =?utf-8?B?dWljd0F2M0kvZEVqRzVKWWpjbkJxaThON3ZmajltbCtleC9lSkM0RkRPeUha?=
 =?utf-8?B?bFBrMUx6RGtQOTRoK3g2N3grZlFTZHRpaHNYMU5yOVhGSUhpSCtHUDE2VXRi?=
 =?utf-8?B?QjEzb0pnMXBuNE96RHQ2bmxTeS84K3dzN3ZxQjJMU3U2MG5xSlZuSjdLelZt?=
 =?utf-8?B?NXA0UG5td1B6djJXTkc4azRBTXBmWEh1bHdNdXBiNHRwc3BQNi8rL3FsM3V5?=
 =?utf-8?B?MkdQNEFoekVrdUp5eDRsSHZPZ0dZK21FR1ZLTTlaNlNvRXJ6VXlqdG1QTVZV?=
 =?utf-8?B?cmNOc3hQRExLQ08xaW1IbGNnY0tnL2xDTm1TdnQzYVFPV0UxMTd5RitFTEhm?=
 =?utf-8?B?YUpvOUhTV1N2cDR1YS9GcSs0YkxVTkFmWHdESnVYTFV0cGV5bzI5VG9uQUdl?=
 =?utf-8?B?K2tUZWN6aE5XdzBmdHZBUkMyd0dpeVBxekYyaUhoWGE0MDM2em5zRVpUZW5r?=
 =?utf-8?B?dFdXWjhvRWNYazVxditFYTBZR1MwNVQzNlhYZ2hudFIyTXVUbTVWOWFJOGgy?=
 =?utf-8?B?aklSKytaVjBBMVY1aSs0Rm1Lc2NOQ2tIdmJEOEpkOVVhWTFMR2dxUW51Ulow?=
 =?utf-8?B?cnk3UjVhL0R2MXAra1pYWkcxVURkcGowSFdNWG5BNmEzRmc3WlNTNDZyd2Vi?=
 =?utf-8?B?OWRSVitmZHhoL21wd0h5T1NmcUZOSWpMVEJ0K2dhTlFXV1YzS1dHVVdjYVUv?=
 =?utf-8?B?dEhGd3BlVEFrV2FvbDRTSG0wMTltSzVzTFlVWnV3R2phUmZKSTVlYUNRbUg1?=
 =?utf-8?B?V2xTd0tDWVRqeFJtL3hVd0tDNTVFWTgyMlZzSWJTTWxIREQ0TDh6SUdIQ1cy?=
 =?utf-8?B?bjJhZ1RhNkZlT2FTT09CLzVqRFVCWCtXYzM3T3REQ0M4ZkxzcElhdzBNQldX?=
 =?utf-8?B?eldEY3o2bURzei9GUDdXODF2UGx1SlFWUUJnTVRlbTBHSzEzQWxuTUVpTUFq?=
 =?utf-8?B?YnY5SzJOOEFpaVZQeUVVK3BWSkxOT2VoNmswbDJxdWMvSitnNnh1TERpRytx?=
 =?utf-8?B?TjRBSENLR2xKQmhYQkdjNEpDQVo4N2E4K1BidEtnYldTSkMyOTl0Z1pIeUx1?=
 =?utf-8?B?OXQvd0doTnBmUi9RZi8zWWo3S29oSGlxbE1Oa3d6dURLbjIwZU9FVVNJY1BH?=
 =?utf-8?B?aXBidEVsUFNIM05GRURQNitVVURhTEVXSzdBWEp3NStpQ2tzVTRZRVl3L0lK?=
 =?utf-8?B?OHc4YWhpbTJEOWJOSzBOYkdybGZWQkttc1B3Tmd6Ym5Td3kxQ3NEdGpYdmNU?=
 =?utf-8?B?THYxcGp1eElEMXhFOW1DUGttcHhVS0toRUx1dWVIN2lDcGxucWlnVGlnM2FE?=
 =?utf-8?B?dUNITElKZ1ZnZTU2eHlRSkJSVWJkZWdLNGxsbm5TVWVWT2J0ZTJ0cFk2bWgy?=
 =?utf-8?B?NEhURjQrM2xCNlRhSEI1aHpTY2VYNkNIbHdSdFgrRUdhKzhTNlliWWFNU0ZV?=
 =?utf-8?B?QWhtMVZZNkdMQ25YYUlLWnVKNWtIS3dyb2JGdytkajdNU3IzZXR2VTNIOUd1?=
 =?utf-8?B?Vi9OWkdJblZvUTBqNkJuUWNBbUR3TkFxb2dIMUZqeVAvLzlaR0VyUWxTcnIr?=
 =?utf-8?B?Sm1KK1VPT3FPQUVTM3Y1NkdPTjh1WkpYMk1Da2ZpTzdyZllxcjBaUFBLbW8z?=
 =?utf-8?B?L0Q2Tk55MnBEQ2w3RTZPMkFaUkVLNWozZ3dHdFBJaGx4Q1VjT0xqb1A1UkVp?=
 =?utf-8?B?eGZTN1hBOVo2ZmpPdmp0N0dBeGlKSW9zeEdCVEp4eG1uUEYyak0yVkJVOVhB?=
 =?utf-8?B?SmJHWUxKS2U2MTEyMFZYb2pVSEhpdXlCY25GL3Urc0JiWmZzYlNCQnBWR1gr?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PLynmMXq096cww12jWJfCejEH0F70m1oWjeOBc/fj2nbD0HcBKtx5JpPgdTtKcbKfv35D5B8vPju2uJ0VwRSNNbq0owSbx1uzGa7pEYu5QSrTemjHqfHYV9pOl1Et7QGH7pIkA90H9Nw14Px3/j+LsRkWEAjsZ0I9XrJVOzt210Y5WrxvLMSv7lsw8awHcvWkAAIq6DgLMsIPpd5FH8AZrDLQ1Cd7v/ZE3CrNlEai26ktPi8cZrr8f1PZ5sePWgwOKzAYGJWuyRQ2B+V39VHxL3YFx0H9VM+fb7MBp8YjJGc+1/GiP4HCmkkMoqAgpXtAGH5Zdn2OlJVL1omeCcksVHy6XCfKd69T6vrP30mUdIWEwYGeV/r83c38EaXT8tqLUNMQO0VHFcRoZ1g2DvsD7ETODIAIs227l18VvV5Vce4ciwNPXNPze/B3b3qqQHnMwIbO3ffCcgeliUxJr7o6yEPwSXM1gYQGEZAKzaAqB24vcF0g0euF7q1+8qUr9jPTZY8R+uDYG7gWvio1lHRAPaTRPvKEUBffFZC4I9blz7W/8UYu3+cp7f2KiEO0QSARlSGAJdQJLunFJecwJai7a7BObYW/ZFGq5t5xxW5Lj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059b18a-cf74-49cf-5804-08dd83261dd6
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:49:49.3687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+oxUHZFn2TSD9dUnGc9gNQrF9zHMqBZ4e1MK2iVuTTLQIcX8ai7DTmNW4JkEiL69RVMsaNFO+JOLXFWJcSmA0zAPuBjkbRzDE2+XkMy0UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3OSBTYWx0ZWRfX+Tsjga4XXb80
 5KiZ2q/gHDf/5ykGkh8zQaSWQcKasYTkODbNOvKENmLFtgTolE2J9PuOuap0SvDFp5L2QBlXjET
 BUCEmRblO8S3grzv0H1furFhsWh9LyWKYxSP9HyVA27oxQhY8vK90sjFxxrN1ewJM3dC2n2jU7u
 XT0m4Oa4ooKH9ZHh0/uCH+pAmFIkU6GNoWjMhPp/iP34qo2SwxTzSieYTEWxNSe2seByUeZ8bcT
 yuotccEUkfiKRvybc4B5SO1/1WtT6xeQ0LM2SrXcIoAvhVBVfxan5pFZJ4OQI8n1KKePoMeBTAT
 A1ZCw3Ez5Q4Hilw1UY/cptSmXUqm2cBEupkwvvMkgXPZ5JrjrH3+79H3GQkMvQBv74QisZR+FME
 Od2YgzrD
X-Proofpoint-ORIG-GUID: 3zJ1z2dZq1K6A-eD4lXYPznpU0c2mTdT
X-Proofpoint-GUID: 3zJ1z2dZq1K6A-eD4lXYPznpU0c2mTdT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/04/2025 11:56, Sairaj Kodilkar wrote:
> On 4/23/2025 4:15 PM, Sairaj Kodilkar wrote:
>> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
>>> This series adds support for guests using the AMD vIOMMU to enable DMA
>>> remapping for VFIO devices. In addition to the currently supported
>>> passthrough (PT) mode, guest kernels are now able to to provide DMA
>>> address translation and access permission checking to VFs attached to
>>> paging domains, using the AMD v1 I/O page table format.
>>>
>>> These changes provide the essential emulation required to boot and
>>> support regular operation for a Linux guest enabling DMA remapping e.g.
>>> via kernel parameters "iommu=nopt" or "iommu.passthrough=0".
>>>
>>> A new amd-iommu device property "dma-remap" (default: off) is introduced
>>> to control whether the feature is available. See below for a full
>>> example of QEMU cmdline parameters used in testing.
>>>
>>> The patchset has been tested on an AMD EPYC Genoa host, with Linux 6.14
>>> host and guest kernels, launching guests with up to 256 vCPUs, 512G
>>> memory, and 16 CX6 VFs. Testing with IOMMU x2apic support enabled (i.e.
>>> xtsup=on) requires fix:
>>> https://lore.kernel.org/all/20250410064447.29583-3-sarunkod@amd.com/
>>>
>>> Although there is more work to do, I am sending this series as a patch
>>> and not an RFC since it provides a working implementation of the
>>> feature. With this basic infrastructure in place it becomes easier to
>>> add/verify enhancements and new functionality. Here are some items I am
>>> working to address in follow up patches:
>>>
>>> - Page Fault and error reporting
>>> - Add QEMU tracing and tests
>>> - Provide control over VA Size advertised to guests
>>> - Support hotplug/unplug of devices and other advanced features
>>>    (suggestions welcomed)
>>>
>>> Thank you,
>>> Alejandro
>>>
>>> ---
>>> Example QEMU command line:
>>>
>>> $QEMU \
>>> -nodefaults \
>>> -snapshot \
>>> -no-user-config \
>>> -display none \
>>> -serial mon:stdio -nographic \
>>> -machine q35,accel=kvm,kernel_irqchip=split \
>>> -cpu host,+topoext,+x2apic,-svm,-vmx,-kvm-msi-ext-dest-id \
>>> -smp 32 \
>>> -m 128G \
>>> -kernel $KERNEL \
>>> -initrd $INITRD \
>>> -append "console=tty0 console=ttyS0 root=/dev/mapper/ol-root ro rd.lvm.lv=ol/
>>> root rd.lvm.lv=ol/swap iommu.passthrough=0" \
>>> -device amd-iommu,intremap=on,xtsup=on,dma-remap=on \
>>> -blockdev node- name=drive0,driver=qcow2,file.driver=file,file.filename=./
>>> OracleLinux- uefi-x86_64.qcow2 \
>>> -device virtio-blk-pci,drive=drive0,id=virtio-disk0 \
>>> -drive if=pflash,format=raw,unit=0,file=/usr/share/edk2/ovmf/
>>> OVMF_CODE.fd,readonly=on \
>>> -drive if=pflash,format=raw,unit=1,file=./OVMF_VARS.fd \
>>> -device vfio-pci,host=0000:a1:00.1,id=net0
>>> ---
>>>
>>> Alejandro Jimenez (18):
>>>    memory: Adjust event ranges to fit within notifier boundaries
>>>    amd_iommu: Add helper function to extract the DTE
>>>    amd_iommu: Add support for IOMMU notifier
>>>    amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>>>    amd_iommu: Toggle memory regions based on address translation mode
>>>    amd_iommu: Set all address spaces to default translation mode on reset
>>>    amd_iommu: Return an error when unable to read PTE from guest memory
>>>    amd_iommu: Helper to decode size of page invalidation command
>>>    amd_iommu: Add helpers to walk AMD v1 Page Table format
>>>    amd_iommu: Add a page walker to sync shadow page tables on
>>>      invalidation
>>>    amd_iommu: Sync shadow page tables on page invalidation
>>>    amd_iommu: Add replay callback
>>>    amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>>>    amd_iommu: Toggle address translation on device table entry
>>>      invalidation
>>>    amd_iommu: Use iova_tree records to determine large page size on UNMAP
>>>    amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>>>    amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
>>>    amd_iommu: Do not emit I/O page fault events during replay()
>>>
>>>   hw/i386/amd_iommu.c | 856 ++++++++++++++++++++++++++++++++++++++++----
>>>   hw/i386/amd_iommu.h |  52 +++
>>>   system/memory.c     |  10 +-
>>>   3 files changed, 843 insertions(+), 75 deletions(-)
>>>
>>>
>>> base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
>>
>> Hi Alejandro,
>> I tested the patches with FIO and VFIO (using guest's /dev/vfio/vfio)
>> tests inside the guest. Everything looks good to me.
>>
>> I also compared the fio performance with following parameters on a
>> passthrough nvme inside the guest with 16 vcpus.
>>
>> [FIO PARAMETERS]
>> NVMEs     = 1
>> JOBS/NVME = 16
>> MODE      = RANDREAD
>> IOENGINE  = LIBAIO
>> IODEPTH   = 32
>> BLOCKSIZE = 4K
>> SIZE      = 100%
>>
>>         RESULTS
>> =====================
>> Guest
>> IOMMU          IOPS
>> mode          (kilo)
>> =====================
>> nopt           13.7
>> pt           1191.0
>> --------------------
>>
>> I see that nopt (emulate IOMMU) has a huge performance.
> This is suppose to be "huge performance penalty", sorry about the typo
>> I wonder if the DMA remapping is really useful with such performance
>> penalty.

This is not so much about performance but more about guest compatibility (or
just not breaking guests) once you expose amd-iommu device (old or new guests;
as you can’t control what your guests are running), together with Windows OSes
which so far only works on Intel -- so this series brings parity; There’s also
more niche features (Windows Credential Guard or Windows firmware DMA protection
which requires a vIOMMU); and finally general testing/development for (v)IOMMU
with real VFs to work.


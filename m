Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3944C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVol9-0006qQ-RM; Mon, 22 Jul 2024 04:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVol6-0006p8-25
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:51:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVol2-0001na-0K
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:51:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7dNSR018139;
 Mon, 22 Jul 2024 08:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=aypBjwu3L4cKo68ilvpXncSOtFayntL4uhvuhXnJRss=; b=
 i9EEosxXBT2O61p5ayZUKVJQ9C2M+eS1DuiFfawdjm4V5tqZyWmzXK+TKSSxt6da
 7PAw2ItbwPyksd0iEivDkTf4sVFkwqCZSQ6J9qvySZvqPVuYRgbU8EPRO/xSbMPK
 smM5tiQuDUj0HMAcP9b/GzLLQitCsRBwkT2a4VjrctPpWxTDqmOyhry7zA3gr8qe
 Jk9oVsZbYvA0XKKOxbQaz8ZAhZMAJ3fOuTjUMF6tvvxGGtL1bTcoF/485bHLvZ+c
 aShFsMOO/zhx+vcKHjg2jCvsWpdGwTtfLIOroWPdNE9Jq4uisbueeld2p22HdPp5
 uLD6JNK2ztyNRaZ+goBh8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe792tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 08:50:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46M7uExd040303; Mon, 22 Jul 2024 08:50:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h27ww783-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 08:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgoZIl7wbth3Ikn8tw4/MCvSG9o2qqmEy87UCk8fbSx/0WNLfPVJdJZNY1BuTGzv0Mdv69/2gVdntESpp54XqgCgCZICFZs2f5BjtXbGIoHVjaGB9NbzCbgnP1g2Vfv0myf5ZWYGjgS+5NBZFHDZfiYz6il1CJurwDbjn7Z/4BFH6CIZgU5WkXfpZt05UIH/2DNwPize53kWve/dqqx77vO1axSboihXp31ljuGgs1npeQw5oVZRWud4rWK0phM//Do5/hP+ATRMJuUpnqAWB4CfTdVZw+OuxGbA4fB8Evud6jGCYcK+fvb/uOWp5DtaDgTdDrfAW/fvXmbI55uW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aypBjwu3L4cKo68ilvpXncSOtFayntL4uhvuhXnJRss=;
 b=hww6/rVedkAFuMUwHrhP8802/pg8LYilBKpT9Zjuy39hPZ7RUzp2KhFEn3NgtlB58mtiMV+d53OqCvhSst764dwv3lGxG3QEereU/ACScM610mVZQ7//cw0Efh1Jx0bXcsDWbFB8VH2pupk5l6vBodjUIxCzC6jk8c7RABHlrB7JVV6o3R+qJPszOdptG/Pkm2HAZwP4WOrSejwSUWaFECEKRAB9dBhAdKkPrXQIbU4qaq9gkuFsf4Q14QTmFhNEjEyp+WPjyqhY8q22VaOQSDU+ot+c5NpYrvBesChmvbCUR53vBYR/f9Uh2WqvBEMiSzND83IWXYxluExLze7pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aypBjwu3L4cKo68ilvpXncSOtFayntL4uhvuhXnJRss=;
 b=uwKZKhe7r+sPPWAEjddsPbtuRya8MegqNsJmKwDJ8ygd32uiDSGdhsIpfWcuNkTF+lRv9GjsxBkTMe8z9VJ+G3KEVzRnV6EmSqSD7ytedBC2f810w0OZ2UYzDSCoxaO59mwJcE1OnU2hXC6gfTMK6AxBm0Rt1IPTUo6pkJO6Rg4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 08:50:51 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 08:50:51 +0000
Message-ID: <1f220462-6540-4a9a-8a29-5edfe836b9c3@oracle.com>
Date: Mon, 22 Jul 2024 09:50:44 +0100
Subject: Re: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-6-joao.m.martins@oracle.com>
 <SJ0PR11MB67447F437F8FCDC4F995737C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67447F437F8FCDC4F995737C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BN0PR10MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 130f71da-0d49-4a4c-51cb-08dcaa2b6367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2hqbGplVTVWTXRSTVNMSzdubXdveCt0cmtjemVDMVNlTTBqRzJld1ZPem0w?=
 =?utf-8?B?eWtZa0w4YXFGWDJHYkVyYnNKOGR3ZHRHdGROUVp5UFZDQ1VxMjBvNTVKd0Nr?=
 =?utf-8?B?YW5mU3hRZ1psbFJzNVlOMTJpOWNJWmNjOWpjZkNXV21aZHpZL1FXSUk4MUNN?=
 =?utf-8?B?STFUcW1JeUR2SUNDM0xpTWpDY0VNWkppSmVSZmFOT1I3VlhEZjNoNUFlck9t?=
 =?utf-8?B?ckNocFBlNTZVVDVHWit0Ynd3QWJnU3MvSWpTL0p3ampsQ1lwTjhsRHZBdGI3?=
 =?utf-8?B?b28yZEpUTlN6a085VmE2T0FnaDB5ZDdBdUNnSDg2T3ZoeTlnRTZ5ZE1LM3BY?=
 =?utf-8?B?S3o5c2Z6L2lsR0tLWTJTN21oQURNWUVReGpBSkFNTW1mcEtPbUdwNWcwYks0?=
 =?utf-8?B?YXZTVGhNd1dybDZUTlQ0c2kyUHdORnZ5aUJsYVNRUHk2bHBFaS92L0xLeHJk?=
 =?utf-8?B?YVhSQldGNXlLYmRtblBCalg5a0dNY0RucFRtU3ZMRjZScXRSUUgvYjZabUZk?=
 =?utf-8?B?cXh6bmJtMENJL0NCVU00aGpINU5FN3VuYWJNWi9Pd0lvbXZzTXV5T0FGcEpL?=
 =?utf-8?B?RGxBUm8yZ09RQlFJcFd4eTJnVEtta3hHNVhvUDhnWVg1cloxN2ljSVpnOUx0?=
 =?utf-8?B?NkF5b0lTNzBxRmlySjNWckd0QVJrN0g4eUFCRGpBZnorMks3ZFNISDlxZ2o1?=
 =?utf-8?B?NFhwNGM3dmt6MEZReC9md0VNdW1TbVVBVUZEOVZLbXY4RWZ4RXdodmZyeXEw?=
 =?utf-8?B?TjRQTjE5K3pMeGFtWkkzckdEeklQZTJqSjJVQjRQSW0vcUN3ZzFLa1dDTHQv?=
 =?utf-8?B?dU9wVFFFVjUwL0Y3aEUzUnhjT3Z0aWZjMk8vQnpPNU1PQmdGTW5ObWc5bFVx?=
 =?utf-8?B?NHJ1dmZuNm1mcHljLzdmS2RaeStNSXRzY05BOVJyNEpvVFdtYU1FYVRpODVT?=
 =?utf-8?B?WDQ2ZlVONHNXd2dqS3NzNGt4RGs5UWVCYy9CMEE1eUh5ZHJJRWFvT0t5ak5N?=
 =?utf-8?B?cnVyNllPN0F0YVlnN2lvd3psa1FKNmZYeHV3clo1dG5oT0l2SnhqYUJSaExM?=
 =?utf-8?B?MTh1TzRjQzI5dzBDT0xEajZCOXk5QitvM1lEdmxsWjFoZkkrN3pFWm1MUkkx?=
 =?utf-8?B?dGoxQUFCeEM1UkVYK3FHeENvZnRaTmtLL2MwOWhIV3JSWUtmSDBpV1pNcXJX?=
 =?utf-8?B?UXpndmZJMTAwbjNHQllwbndPODZKNnJsODFwbVE5ZExYMjFmUUd3SjZkZ2Rh?=
 =?utf-8?B?WjlEdlZWVVhzSjJPOC9EWVpJNm9NbHFrbTl1blZNN1NrTUtxV0t1cnN3VnFk?=
 =?utf-8?B?VlZDZ2pNTXRPUXNmUElYQVJXYzJoSUw0allJMlZTbkJpRGNxTlU5NEdIMXho?=
 =?utf-8?B?Z09iTGkvRDRrRlgzTmZyK1FsSXBXSmdlcXA3c3premU2SVlLazRFVWppWjlY?=
 =?utf-8?B?SDhHdkhYQ0dYajl6WVdDTHFyY3J2MTBibGEyb3NHVXBzQzJ0TFRxdUIxcjIw?=
 =?utf-8?B?YWNrRE16MHRCVnBiVHl0eDRwUU9tWFRsbFJrd0dicnA3L3lTTjE1THZlYjda?=
 =?utf-8?B?d2FSanJ4ZXRrMy9qRTY3aWg4THVqU0tiTkJPK2VFSDQreG1VYU5IS3c2RkVD?=
 =?utf-8?B?SUlaaElvWTVhUU5oK21oUjJJbGVsQ1M1QjdiZE5KS3dGZnY1eHc3NDAzdndj?=
 =?utf-8?B?NjFYbXRJOTQ0V1hEMTBuWHBRbHZkY3ZERks3N1llWHBkaHp2SGJrWUVhOXFh?=
 =?utf-8?B?TDB2ZWJNL0R1WW53cTZvdjRjanMrTzhhZVViaXNqdGFOSENjZ3RhS291TFNF?=
 =?utf-8?B?L2NrQmhyVHM4eTdvWTRYdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnpmek5ZdkxTdkUraWIrK2R2UFdvblFDSHV0andqRnN1NVFqWUtrMWM1UzVK?=
 =?utf-8?B?ek9lMmZzeXNudTF6LzBleG4zUkEwNW1KV3lKano1MW5rZmZTNGtFNVR4b3BK?=
 =?utf-8?B?ZEkzZGprUGFHK28wNC9BZ2FLOGZQZFJBOUhJeGxSUjZMZ0tIT2llZTFJSVI5?=
 =?utf-8?B?VStjQlY1cFpKOEc3YVlNL0RZK2QwM1QxclY3VnJXbnZCeml6aVV6d0V6SlVJ?=
 =?utf-8?B?TkNZYmRDV1Y2OUJ1NllncXlzUU9Wb2RHNk5hVGozTS8zZXk0OWozTHlkVFd0?=
 =?utf-8?B?SVhDUjRYM0plRjZ6bnN6ck1GTjVlZVpZcDBqeTNoTERPNzV6S2FRZnVaWW1l?=
 =?utf-8?B?bXpsTmZxZk4ycWFKN3lFVWVEU3d1WWcveHRZSUhFOFk0QjVaL2pDNmFUcUFU?=
 =?utf-8?B?SUZqOStEK0ZXM2wzaTFSdTlXc2lnRTlhS2hFQlp0TCs1N0lZdTczUHpGMkhs?=
 =?utf-8?B?UFBRVGFva2Rycm9iUU5ZWE1XMkNDcHlIZjZNYkdkWXBGakZBM3NSRUVIZzRR?=
 =?utf-8?B?MlFQSWs3NlVVdlkxR2tOZjVNRmFlbjJtakl0UGJjd0VwZS9BZDEyRCsrWmZK?=
 =?utf-8?B?UzV0ZUFiK2Y2TnRSU3pMVGFSOUp4dlVwNUVWZUprWkZxRHh1VVVCN0VOWVJr?=
 =?utf-8?B?MmFTWkJad0FvSXVnOElUZXVSOVR6OXM1QXhvNysrbERScGROL0VqT2lFdVMv?=
 =?utf-8?B?ZThxc2NGLzRWY1lyRk5mdVpXYmtETy8wWFpWN3NTZ2l1NlZwMStCakEvNjhG?=
 =?utf-8?B?dXkxUDBQUGU4cXZhZXFLMXFjU1RqQzNFRFQ2UzRtcXVGNXdNMlNUU0hCck1Q?=
 =?utf-8?B?eXMzUFFaUGVEcVhOVXlUSnhhYVhXYm14VitadEJWcHpGcTQ0eXcrZGsvY1ha?=
 =?utf-8?B?bWJrOEJqK25pSFQ2T3pQblNJN1JNMVJTcEUva08zNVJCOXo2b29IVFNvOHha?=
 =?utf-8?B?d29RMENxZHFUTEJoaXpTZ3RKK3BpSW8yN0FiSWI3MTJicGJ5dVFaL3h5TXR5?=
 =?utf-8?B?a3dtd0dObm1nOXl6YlY1NzBrRVg1QytIemxlbzl6WnNhMHJqSldGQ0F2NlR2?=
 =?utf-8?B?TTBQcHEwYzNnd0JweGVDaWljN2FNWXF0b0FjaWVERUMxakdTTnJKL1B4V3RN?=
 =?utf-8?B?Wno1aVhLQ21oN3RtdFNaYjZiQnRPMTdPd3RQeENjaFF4MnRkcVNWNDlaQWpR?=
 =?utf-8?B?ZjBHbjVRcFhwWEw3QTdOSkZFT1lmaWwrWTNtVUZ2UmVFUVRhelN3M1pZeEVZ?=
 =?utf-8?B?MStacCtMMTZ4RXRMejFsLzhURW9Zc3FpUGdFNTM4R2RxdFFJdkhyaWo3RmFh?=
 =?utf-8?B?cVNuWjlpZndSVU9pUkU1SEN2dVVoN3VvYTlzNDRpV09udHBtdGhVNUFSbWVx?=
 =?utf-8?B?TmxKK2g5OTUvQmpzNGY3KzRHaTQ4UDVCSVpkV2pjSG5FUk41dC9ycUcvSHIr?=
 =?utf-8?B?aWhwMGJWdTFsY3Bxa3lYZk1rc1ExRnZvUDg0bkh4MnVmbGRMM3Jjb2o4RUZO?=
 =?utf-8?B?VnBnRkZzUU1CL052U1pHTUdiQnY0cG1hSzVFNmhGTE5QdHNkK0NTOVJBcElB?=
 =?utf-8?B?ZVBjTldRUGN2ejd3WEYzOVJkNC8zNlpHWGZEZGdHMUttdFhNSi96VHliWi9D?=
 =?utf-8?B?U1drMXJkQTRpaVc5MmRhV0l1TVZxeGE4Zm9XR3ZZQXNLNmZ4Wm9UcDB5Q1VI?=
 =?utf-8?B?SGVkRnE5L2R3b00xa1NZRExzYnlwMDNoMC84UE9CSUdhZ214MzZVcE1qOGk5?=
 =?utf-8?B?UkZ1Y0VoRTZUZW9Va2lnT09xMm1YN3BjdU1ld3M3ajRsaGo1MHNML2F4eVVG?=
 =?utf-8?B?MklMeVluVkJLNEtzWmIyUmh4UG5yL0JRVXNzNGljbDIyTHdiMUg0ak9hZGVq?=
 =?utf-8?B?TVJ3TzN5c0VBMWNjdGU2SEI0WFRHYWNtMU1SWldJemVwUXNMSDdPUWFyWkFP?=
 =?utf-8?B?UXA1U1hkUTBia0NvWS9hKzA0QU5id0JXeVhzb3pvOTVla2daWlJvR3BjcUVB?=
 =?utf-8?B?djc0anlIY21TQ0djYXl5NDZ5YjVYaHRIejI3WGVYOUtyUlJJQ005Z1lOajRZ?=
 =?utf-8?B?bGJEV3VyODZqWWJRbmdmTW41K2s3YXZHQTRPWmphMFRnL3ZJbGZqSzVFT0k3?=
 =?utf-8?B?cGwybnYzWTVDYUNOUThkRnB1T1dCMm9LTFhrM01JMTBIb1FxT2wwQkRTT3h3?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5BgBEKkovg76N7eI4X6p4NRuEDHezf7sK/IouUHNv3Eu374i0RN62LHrs4nwh9g8aE0ClFIP1VrdH8PzGry/AbfDgRznQcryCYJgVTPUdiZ2n+e3TnISxMk0kpMBXxg+LTm556gDGgXjXMUzp3zF9hMMFcxBZlsUM2ObssnMZEKG0uFI2WCHDemBsKTNQKhYb8KzBa5QPSm36bpGM7Zy5Fw2ou2mdcyPI0aseFlf6VUSqRjHxQmOz6+NOIOMqZT+dog5TA94LGwV133VA0ffnfDKzJ+B6AwPEGHdl7V/rFwpoje6pEtqkGSHl1xrw6sMzhvvuHe05JHFgDfEkuAlmyfV7Etmv9R0PWLfGD1QB9tK9ujIf+gvEUZzzFzNb6N3jj/C4E3zg/NW5drW9DGvNsOeBw8xToYeyAkCNGps3UHhu5Zj6dfBi8rDovQyVIlnk70ZQDG/pJnhaUuqjxQj4+AbGpWEgMPJvmZH82tH8mW9RoVu1t4ze0n+ahW4rYqISYe1PCggSf44uFPUlr2eqPloPpjkPtV0nz+xAOasFFkbIymOkn5tIX3u3zF7u8z2YehNMTkOXQEUsrDUObyrGJUqqPfwPNUjewFTcuBveSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f71da-0d49-4a4c-51cb-08dcaa2b6367
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:50:51.0346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER1TOKS0blzX6o+LgcJoWy7z+AWZPPBJfKCgX9tloBMzexsxdlVVDWMvNSZwd/O34vBMc8v53Awr4tdCEMq3NqYizn/jtZbT5R3I86Znr5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407220068
X-Proofpoint-GUID: PeJ4Ln_nXpb_AYp74FyrJzH3xKcg7zok
X-Proofpoint-ORIG-GUID: PeJ4Ln_nXpb_AYp74FyrJzH3xKcg7zok
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 22/07/2024 06:16, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
>>
>> There's generally two modes of operation for IOMMUFD:
>>
>> 1) The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. The process generally creates an IOAS and attaches
>> to VFIO and mainly performs IOAS_MAP and UNMAP.
>>
>> 2) The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>> responsible for creating an IOMMU domain. This is contrast to the
>> 'simple API' where the IOMMU domain is created by IOMMUFD
>> automatically
>> when it attaches to VFIO (usually referred as autodomains) but it has
>> the needed handling for mdevs.
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimicking kernel
>> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU
>> domain
>> it falls back to IOAS attach.
>>
>> The auto domain logic allows different IOMMU domains to be created when
>> DMA dirty tracking is not desired (and VF can provide it), and others where
>> it is. Here it is not used in this way given how VFIODevice migration
>> state is initialized after the device attachment. But such mixed mode of
>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>> be added on. Keep the 'all of nothing' of type1 approach that we have
>> been using so far between container vs device dirty tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/hw/vfio/vfio-common.h |  9 ++++
>> include/sysemu/iommufd.h      |  5 +++
>> backends/iommufd.c            | 30 +++++++++++++
>> hw/vfio/iommufd.c             | 84
>> +++++++++++++++++++++++++++++++++++
>> backends/trace-events         |  1 +
>> 5 files changed, 129 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index 98acae8c1c97..1a96678f8c38 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>
>> typedef struct IOMMUFDBackend IOMMUFDBackend;
>>
>> +typedef struct VFIOIOASHwpt {
>> +    uint32_t hwpt_id;
>> +    QLIST_HEAD(, VFIODevice) device_list;
>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>> +} VFIOIOASHwpt;
>> +
>> typedef struct VFIOIOMMUFDContainer {
>>     VFIOContainerBase bcontainer;
>>     IOMMUFDBackend *be;
>>     uint32_t ioas_id;
>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>> } VFIOIOMMUFDContainer;
>>
>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>     HostIOMMUDevice *hiod;
>>     int devid;
>>     IOMMUFDBackend *iommufd;
>> +    VFIOIOASHwpt *hwpt;
>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>> } VFIODevice;
>>
>> struct VFIODeviceOps {
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 57d502a1c79a..e917e7591d05 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -50,6 +50,11 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp);
>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>> +                                uint32_t pt_id, uint32_t flags,
>> +                                uint32_t data_type, uint32_t data_len,
>> +                                void *data_ptr, uint32_t *out_hwpt,
>> +                                Error **errp);
>>
>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 2b3d51af26d2..a94d3b90c05c 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -208,6 +208,36 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>     return ret;
>> }
>>
>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>> +                                uint32_t pt_id, uint32_t flags,
>> +                                uint32_t data_type, uint32_t data_len,
>> +                                void *data_ptr, uint32_t *out_hwpt,
>> +                                Error **errp)
>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uintptr_t)data_ptr,
>> +    };
>> +
>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>> +                                     data_len, (uintptr_t)data_ptr,
>> +                                     alloc_hwpt.out_hwpt_id, ret);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>> +        return false;
>> +    }
>> +
>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>> +    return true;
>> +}
>> +
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 077dea8f1b64..545f4a404125 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -212,10 +212,88 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>     return true;
>> }
>>
>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> +    uint32_t flags = 0;
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t hwpt_id;
>> +    int ret;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>> errp);
>> +        if (ret) {
>> +            /* -EINVAL means the domain is incompatible with the device. */
>> +            if (ret == -EINVAL) {
>> +                /*
>> +                 * It is an expected failure and it just means we will try
>> +                 * another domain, or create one if no existing compatible
>> +                 * domain is found. Hence why the error is discarded below.
>> +                 */
>> +                error_free(*errp);
>> +                *errp = NULL;
>> +                continue;
>> +            }
>> +
>> +            return false;
>> +        } else {
>> +            vbasedev->hwpt = hwpt;
>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +            return true;
>> +        }
>> +    }
>> +
>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>> +                                    container->ioas_id, flags,
>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>> +                                    &hwpt_id, errp)) {
>> +        return false;
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> +    if (ret) {
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +        return false;
>> +    }
>> +
>> +    vbasedev->hwpt = hwpt;
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    return true;
>> +}
>> +
>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>> +
>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>> +    vbasedev->hwpt = NULL;
>> +
>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>> +        QLIST_REMOVE(hwpt, next);
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +    }
>> +}
> 
> Looks the detach flow is still missed?
> 


I don't think so. The iommufd_backend_free_id() pairs with alloc_hwpt call and
is there for when there's no device attached to the hwpt to actually free the
hwpt. Besides setting to NULL the device hwpt, the detach flow was fixed below (...)

>> +
>> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>                                           VFIOIOMMUFDContainer *container,
>>                                           Error **errp)
>> {
>> +    /* mdevs aren't physical devices and will fail with auto domains */
>> +    if (!vbasedev->mdev) {
>> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>> +    }
>> +
>>     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>> errp);
>> }
>>
>> @@ -227,6 +305,11 @@ static void
>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
> 
> Shouldn't we check mdev before calling this?
> 
(...) here. Detach needs to be called for both, and keep in mind that this
doesn't a pt_id, as the ioctl detaches from whatever domain or emulated idea of
it (for mdev) that it has previously been called IOMMUFD_ATTACH with.

We also call this with mdev we just don't call it with a hwpt_id but rather use
autodomains (and it doesn't actually allocate a hw domain)

>>         error_report_err(err);
>>     }
>> +
>> +    if (vbasedev->hwpt) {
>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>> +    }
>> +
>> }
>>
>> static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer
>> *container)
>> @@ -354,6 +437,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>     container =
>> VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>     container->be = vbasedev->iommufd;
>>     container->ioas_id = ioas_id;
>> +    QLIST_INIT(&container->hwpt_list);
> 
> This can be in ::instance_init().
> 
But there's no instance_init() for TYPE_VFIO_IOMMU_IOMMUFD. This is where all
IOMMUFD container stuff is taking place aiui.

> Thanks
> Zhenzhong
> 
>>
>>     bcontainer = &container->bcontainer;
>>     vfio_address_space_insert(space, bcontainer);
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 211e6f374adc..4d8ac02fe7d6 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>> ioas, uint64_t iova, uint64_t size
>> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>> uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>> iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64"
>> size=0x%"PRIx64" (%d)"
>> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d
>> ioas=%d"
>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>> pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr,
>> uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u
>> flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u
>> (%d)"
>> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
>> --
>> 2.17.2
> 



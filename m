Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71004CFA45C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fOY-0005if-Ou; Wed, 23 Oct 2024 13:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fOV-0005iK-C2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:43:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fOT-0001AU-Bs
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:43:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfgL0026652;
 Wed, 23 Oct 2024 17:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=KnLCHQMm/Ljvs0dlyPrU7WmrTYf844CMBlcmIESNK4g=; b=
 HT+mU71CkS1hn8Jdln7hVIVXXwU/tKrokRY6uh+/jDtiX+f0YW7gP/swtsUhx2yA
 LNBaOwqSykbuM9XZWeVqcHoa0ccJIAZhkZ5Sj2Etumf2lkoI7NEtnQceuW7Qn5H9
 c+3PNk9cTgfz+To9Nb4f/wjpcd8hZbn0YpvAquoXvZZ035aT8+R7YUg7r77VF7aU
 pL1pxjXIOhQzsmQ3rADIAYgDUvxga1V4w5AIJ2jaDTt4Czh6Z7YCMWtfvfh1Gv3P
 sBeV36tCAU91RiX/H8BwSx1ZMm8x6ASMt3577udvuLKHcaVyqFY/xLtZKYqq6wgT
 ar32ByiDRYbY8c2gUtjFgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55egmyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:43:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NGEdKK031001; Wed, 23 Oct 2024 17:43:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh1u7n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUCtgVF3/eXn7VZrcoS+p24G4Hb/6lZSVthcv6mtjIFQi2O2dMxknDq7q/jJn4LrDhKkyB9rQpJaEfvwBhqfmSlLVK8kFwfL1VCR6vjU2kRxfAykfsHuey36cwSEhh1Tn5VqzRy81ZNU7cNQ2X6R1kTj4IUWh8Axn4hekOeyEyfnh79wCYHzvJCLecbzEOABRPth1w5/DTFo07Hfo1q0DhSAmmf1HFRLQCrnR4zmPhliLisYeyyUOJL2Sw6G1wQJESsnm9+AOsQ3XKTd9xLbcQ+rxv2r2u8qba1ortC8fR58DW39aqhNarHZv4cwg2IeLoQJe+vZ0iMQUfanvcS9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnLCHQMm/Ljvs0dlyPrU7WmrTYf844CMBlcmIESNK4g=;
 b=kPCaExX8hFrKZtzj2FaMMGJgL0bFwOQjfNVDBWGiQZw83MJpYF8ZcuOmzEJoiCdoKBjS5lrT0C6TPnM3V0VjUo7rFxVVaUMUSrFBz+O+E0PM+ovlEx1CnQDADyyWvY+2kJyCU7W2pyDt+0XFz5I04A5Rm3C2fFa+Pl8WWaaVLsxTIVfgKnIItCbK2tunf29LI3lfK0sTcIvUsFwZpZgxbcHCH3P3g0vy9QDRDt5THfScTx7QgNqWa9CrtK1iuENGCi04NhP1NBlADxyXUp+pG2EzfylrcPgv8WAfp2hERV32VxtDliF8Md+RrOuAScBPkcvyfgbvfU6tAAWgew3TFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnLCHQMm/Ljvs0dlyPrU7WmrTYf844CMBlcmIESNK4g=;
 b=CpKRJamhZnFBYN3pUuvsw7OOLXZAnDnjDAtXI5HdrOktqO0OSo4dMN4qAVxa+TuCpqLK/pDfl8Q9BzVaC/XRlf80cRJlFZG6o2vNB0Nbm+NhD5gzZOape/HoMrCJg1gJokxyWUViXn6BrOl7aILjYER0PzSZ4UVAjjYNzcgnXek=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA0PR10MB7325.namprd10.prod.outlook.com (2603:10b6:208:407::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:43:26 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 17:43:26 +0000
Message-ID: <b6d398c5-7e80-4d63-9e5a-e14dcb723f5d@oracle.com>
Date: Wed, 23 Oct 2024 13:43:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 13/14] net: cleanup for precreate phase
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-14-git-send-email-steven.sistare@oracle.com>
 <ZxapaTo8D5VhnCd4@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxapaTo8D5VhnCd4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:408:142::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA0PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ce7777-a191-47a6-44ac-08dcf38a32bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFRCZzJWSkFDRlVxQk9iMWdoWjc5eTlqL3VscWhJeHBZYmN5ZXBxRzliTTFn?=
 =?utf-8?B?UitvQ05GTU9ML3JjNnV4c0E1dVcvSHdwOXM4Ujd4VGtRbWtUUmhvNTlRNm5i?=
 =?utf-8?B?aS9wSWVpUG1KOEVtMGdnMGRQSWFhUFBxUGEwUEF0TW15SXZxb3lHVTZLQ0wz?=
 =?utf-8?B?ckpIM3NOdTN5SmxuZnJNSTVtb252UjdXajBYTHVHUWc3dlBldVdDMFRRYndn?=
 =?utf-8?B?NE5MckNsYSs3YldBL1JJQ3JKVXJhdGJyQnJEUSt5M3pyOFdVRjFuY0E0aEVa?=
 =?utf-8?B?My9wZ2tCd2ZKNVluNExSNjR2MjNEK25GQ3NLaUpOYms2U3FubU11OHN6MFZq?=
 =?utf-8?B?MXZCNnU5VVZuejdxUHZWcng1Z0t4T0VXQ1djQzhjNE1zVkNheGZtWTV1cWF2?=
 =?utf-8?B?WlFjSU8rUXg3dGVWNU9DcFlOakhxcm8wd2JLZlhXR0dtaDNPdytSQkk2dkRO?=
 =?utf-8?B?OEVNb1ZsWTl4cEkzMGpxd3l3eHZ6b3VSajJXc21GYUJuck9xdHJBWnF5M0Y2?=
 =?utf-8?B?anp6T1djUUFhek5QbWpyU2g2L1NhN2IvRG94TmRRSXJ6YnB5RTFHYlRUUUEr?=
 =?utf-8?B?UEFtWGVPSXpKZUF6Z2JTUVIwajFwbG85cE9KcnRxMFo0T1RyMDV1MllHWDho?=
 =?utf-8?B?Z2dsSm1vYXdkd2p0TThnS3d6dkIvbC96TFdoMkc2ekJjUEJ1RmtCRHRQb3NC?=
 =?utf-8?B?amdCb0Zqbnc1eDFZdXJBbHBFR3FBUXRpRU5nREpIMkxUTTlSNXFkUlFZakNn?=
 =?utf-8?B?MEx4R29Hb1JRWkhqRmpBQXpmQ3R4K3d2MFhhRUpWODBUbDZkaHZwdU5zeEtq?=
 =?utf-8?B?dklwU3ZzYUcwUVBBY1dSdE9iNVlNK2dLbThZZk1WNWVDWnRUWXJXVkZwYi9M?=
 =?utf-8?B?Ylo0MUJNaHBYZmU1dGh1ZFN6REllbCtHcHJBN0ppZ0dmaW03WFdIY2U1VENJ?=
 =?utf-8?B?UU1HUXlKRHBBdGRPK2ZoK0hJYS9MVmlsV05NblpROTRqNzU1Q3Z0K0RQNzBW?=
 =?utf-8?B?a3RIR3NGMFJWSldtcENWYnRwNVp2dDM0a1htV3pGdmZRTENZeGVGS0J6d0VW?=
 =?utf-8?B?QWpNdWYxRGFUM1duLzJDZ0JVK3g4dHpmRUZtRHhBdXBSL1lGMFhIaGlIZWs2?=
 =?utf-8?B?MlJJZm1KVzlGWVA5WFRyWm5HaHNLMWdPN1NpUG1BcCsxOFptdGJPMlZzZDJC?=
 =?utf-8?B?T2g5c3gvYy90UC9vSFhRTTdwZUVsMjA2eFJZb0UzY21sMnkrN1BWd1BxeEFW?=
 =?utf-8?B?aFR0cS9zNDBCL3pXLy9TenhrM3puYUpjWmphUmFDQ0NGWTc5L1NMVFhqYkEx?=
 =?utf-8?B?Rm5BdHAvY1FtY2ZWaE5pelVRRzJRU0RhTDhnd0NTZEpZcHJQRUY0Yzh0VlBO?=
 =?utf-8?B?Y0JKdURBcmFqQVdLMGJaaXNNVjlxdFE2Mi80aHRDVkxZZGJaQkt3SUhzdWJ2?=
 =?utf-8?B?dFFnV2ovLzB2Uy8xMjJLRmlzQ05KVDFla0V2MENudjU1WnR6T0ZzVDJCYk5B?=
 =?utf-8?B?MkNBTEh4M1UzUngydXM1M3JGbEF0b2s1MVlad28vWUZoL0ZxM0dFMFlTRm5i?=
 =?utf-8?B?TndUdVpScWtmRndMdjhBNU9UK0IrMUxHaWpSc0FHcGtFa2JhcVBsY2dtSjRU?=
 =?utf-8?B?YzBuVFFtOE1MbmtIK3lxWVFUN1dld3lmeUVNa0RJRXpmUHp4eElpb3NxMVdW?=
 =?utf-8?B?VG1kV0dpNnhzUjdCUmFoY2xXZjI2ZHllS2pUc1NPWm9SdHBzU21QQXRNUWtl?=
 =?utf-8?Q?coxjfEpMj7Rr/tEikaB2Q9X2Pu7HVtZCvxrsb9t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3oxYWh3dnFRNklpNzdXdC8rRDFORWFmTUU2RjlCT3FZdGVYMU10cFFzSnJw?=
 =?utf-8?B?YzlCRmF2SFJhZFcrWW42TDhjTDlSYVFxYW9rbDVQdElsczBxbk04RGNWYTc5?=
 =?utf-8?B?Vlg5NzMrRGlQZnlERUtPOFNrUmVGeU1LVnRDZnBob0JpYWJ0RjlDYXJRdHhG?=
 =?utf-8?B?a1g5eTE0M1VmYmdrNTJQTkt5aDdWOHZwQ0luWW9pR1NMMDkyM1BleE90bVM3?=
 =?utf-8?B?R2VLQ3c3Sm8xOVJUa1FLSjYrL3VUbnovR2c1aFJmdmRuSXBiTm9IVXVTWDRn?=
 =?utf-8?B?RGhoRWY1L3BscEVJbllvcHF4anQ4eGppWEJXZmlydGFkSVZmSzMxVHErSWZ2?=
 =?utf-8?B?Yy82bVBJUzlKVmpvcWZZOUdzN0tqa0MxY3JobHFnRjZsd2tFblFweE9CK0cx?=
 =?utf-8?B?NmMvb2p3ZmtoNjZVR0YvaDdkTWx4WENNT1ZqWkljTEsxZzIrRjRYRWxFNDJr?=
 =?utf-8?B?T1VzRG1JSE1JYTlUb3VOam04eVExMTR6MDRuVEVyaTlTTE56T1BDM29tRkhS?=
 =?utf-8?B?aUkyd2lOSUFPcmhqWU1KcWYwUUFmODFyQk5wSkd3Rlg4cGcvMGl1akxZVjBX?=
 =?utf-8?B?dkFnQkdUSWM4UHZIUWJCU2VHRWxNRE5mSVB3aVdmK01ZazQzeStTOGtycDlp?=
 =?utf-8?B?Ulg5KzYrRCtDK0VQRWhMS2JOYWZuNkhLa2F3WkpsZGs3REg2dzNuMEd5Znd6?=
 =?utf-8?B?b3diMkZZTjdsSEpYa1dzQ25rbWhtQWk2L0pWM1lDS2doZFRVU3Jab1FzNG1k?=
 =?utf-8?B?UnhGRERDZG96YnNuZUd4OVhjQjJZQ2JsdC9KUW5Wd2diZVl1WGVFbk16NCs5?=
 =?utf-8?B?S0poRnhuNHRGajhIN3JTRkVwU0JUMndIbUJHSEF3KzNVc3NFR3Q3enBFT1dU?=
 =?utf-8?B?R0NyYUFXVU5FWEFoR0wyOU9BQ3hRbFFvbVRPbXRUUDNLWUFhaUZKWWJyU0Fh?=
 =?utf-8?B?SDZmaUxLc3U1R3YrTmxBNGE0RFp6VUg5NzFaVGJiZHh6dWJ4bHFJbDZvT1E5?=
 =?utf-8?B?eUZVTFowL0VVTHg3aGZ5a1BWTnF4ODFCRE14ZWtGV1Z4WnFqMWNwTHN3dXE2?=
 =?utf-8?B?cGgwcE9QNUVnMzBQa1UwR0MzT1FTdnYxZGh6blZnbDF1a3RROWxqcHJzV3N6?=
 =?utf-8?B?bVVCeHpxRVJxbFhuOHNuZE4ycE5jUkhYMWxIc2FpZzJyR29xSTFuZnQ0Qnc0?=
 =?utf-8?B?ZTMvNnlvNVMzRDQ0NXNPd205cVNraERLUmlhYkt4Zk9tR2owMjV5dFM0aFpx?=
 =?utf-8?B?aDRJM09EODZ2OWZwL2Z4eFk5OGlTcmI2Z0hhQXpIM1gvazh0Sm1RY29XelJ0?=
 =?utf-8?B?L2s2U244ZGJScFovSzBrNUNmR3Uyb0FtMHgvSlpjYlhvQVZEZjczaUlNTjdO?=
 =?utf-8?B?MjJMNVZxbWtWeHNaWHpjN2JUSTdBZ09RMnBFYk50V0ttSzNnU3NyQXg1Smpr?=
 =?utf-8?B?WGpIMTd3QzJ1N2VYU2hWTHlIWVBCS2l2dUtIWFRkclRzOFIxaGhjMi9DekhY?=
 =?utf-8?B?eUgxV0FmTSt6amtLZlhRbk52SkZQQTZSZUh0Tm84bG91M2IybDhOcU4xMUxy?=
 =?utf-8?B?dXJHNWJSUkdJOG4wYk1FaUd0VDRGVGpFYWoxbEs1aGVjVlpkTTQxQUd3Mjdo?=
 =?utf-8?B?d2ZWUWo0QTVYaHNpUGJJb1plUVlpV3Z5S0IxTmJyT09lZGdqRHFYYityOUxQ?=
 =?utf-8?B?MUg5WTRicnpIcXcrbkxBNFlzcVFtRnRhQlNLWjZKOWhROGdFNEZvcllocHVr?=
 =?utf-8?B?eC90Y0I0eEJLSnlVclB3WmpGbkFvTVd3akQrZUVKRUNxa0JrSE1ERXlQQkhx?=
 =?utf-8?B?a0wzK2FZL2hMT2F4eFA5cloxZk5ORnV1dXo4SGs2S0FDbGxlc2toUFI3UlJG?=
 =?utf-8?B?NTJpcDZOeHRlbEhJYllnaDR2ZE05V1o1VTVoNHdwV284ZEV6WHdvN1lVQ0FS?=
 =?utf-8?B?QWVjczZ4YWNDRzNTSW10bnVOQUlNSWYrck9mdVR1eXJJWW9rNFFadFlKU1V1?=
 =?utf-8?B?b2FNSE9TZk0wd2Y5bHE3QkNudVliOXpJcGJyUXA3bXhhTHF5VEQvZHpkMGF1?=
 =?utf-8?B?MWtCRXBlWkxIbThQcXg5UkxaYjBiM3RpNEFZaUM3ZHdXRUdRem5MRGY2ZW4y?=
 =?utf-8?B?ZFZqWmJybVBmcWMzc3JDSU55eG9OY1EvS3BEQ29NREk1UHNqandlVG9EaDc2?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KuuxnZfHX/EzsQo0sjou8eZ4eBxhu0/TnZSYR7qQM6Wq192VmQKgeV+hqCuL/rYOH4qD+YmF1B83Uqq1em88hNSW+pIvGWEJgEvTw1th+trofkL6qtTIINrgu2khr+aIx16e8WvsCinMhartEUKbdj8iUqEZYp/y9Cam8xrV5iVR04M0PgzoZgXwd3uFMC56QcQWHEUvEPP5TgIaiiqNJWB2PQD6CGHJNt89SVVx02opakYi3JCx7G7G4SFUVXhpQyAz5dMvLGlKS3kME6DiDDfdYtAHapawWV6Ie9/iVPUawmd1nb6iozGxZcvMaqB8t5tSxsTiKmin06T9mygF29DLKeiuJjketeDrD481dfcQlNEnZrwGzujqfwRd/arzLO0vW1OBe71UMj5V4rilkJ7RHlskiNDdwWm2cbnP1uJP0sEtutUr2XcqJY7kAzHjER8qUS1oy0bepBZRmLmmtyTWYLJAZaITykSDVLxzxx9kPPgy55OKfekAPV/hLmjGmVI6R5jtZS8LeoOXSVcGTaTIxPFtXM8tEj/NGKOkoDhAm3hHuPuPEcYIUsQ7A/8zhzI2+DvDaDpfC5EU6CNtyxHEWnbCeWwGkfIOi5BpkF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ce7777-a191-47a6-44ac-08dcf38a32bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:43:26.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eiljxb3e1O1mMOhHhT92pvO9ElyS1B6cL+KKXIEPZNw7LWHibsGtDA0gApQDvWSiZ6UMsfcJIwtfCm5eypHiViyWueMWQcSHfiCFSJ4EhB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230112
X-Proofpoint-ORIG-GUID: G1s_PsRU7qZnPU9rqWI8VAlL_w7RnV3G
X-Proofpoint-GUID: G1s_PsRU7qZnPU9rqWI8VAlL_w7RnV3G
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/21/2024 3:20 PM, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 08:14:14AM -0700, Steve Sistare wrote:
>> Guard against unconfigured state if cleanup is called early, such as
>> during the precreate phase.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One nitpick..
> 
>> ---
>>   net/net.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/net.c b/net/net.c
>> index d9b23a8..207fdb0 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1687,7 +1687,9 @@ void net_cleanup(void)
>>           }
>>       }
>>   
>> -    qemu_del_vm_change_state_handler(net_change_state_entry);
>> +    if (net_change_state_entry) {
>> +        qemu_del_vm_change_state_handler(net_change_state_entry);
> 
> Can also rest net_change_state_entry to NULL.

Definitely - steve



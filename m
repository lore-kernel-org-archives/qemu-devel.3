Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F130C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuh4p-00048P-SL; Tue, 18 Mar 2025 20:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1tuh4j-00047e-KM
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:14:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1tuh4f-00050Y-Ax
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:14:25 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52INrrZR019450;
 Wed, 19 Mar 2025 00:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=yZbvRX2uDf3y3ZgWKbRrEDoI3M7O3K8FvT+JX65Kj3Q=; b=
 iW6XR4GDsq11onmjzcaMFcUi19FV6Ti7TqKQr07fJ2LFNZKzDNbtJvLVDKrwYmrv
 Ky6rxquBTeJXTm5jteZWumdO8hlDGbc5CKZhYCMBkMrjuSQP9oDkMN600Co7+lBP
 OzNXg1bYghZnezS3K5LjMdeX0zlJZzkgBFyKFBGiOX4qP2nsJMAkdn/cH7rQ0Aw0
 zzepQheZ8GrkSKYW0+PfPjChoCiq29mpGsoToHr6YKBItYjYktiJtjl0blCesmyS
 l1UIrpNDjPsFRLjAEeV8HMhDaHfUOCjxPoZlQw2Tagq5DKvluERR79eeqytcZC6O
 sxAlLmgGl/Tq1r2TjGHjPA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8q7e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 00:14:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52INECrZ025057; Wed, 19 Mar 2025 00:14:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxbj4x3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 00:14:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjt+PnsnfhROYKrBvXdXJ3YshTBhVGjbg4uQGm8Zb/j1FOSTkAaK5WRvGPoSyLkIDC6YPC9kTsLUSNqlO3X7UgecUGCAEhNT7goyHkni/uaO7SgWt/NDdMbL3SzYEHSsHIAyBU1Da76chAVoLlPOgdR4YsfsvglVVuoSCguJgYQosg3l6J2WijRPJSiRH3lsHTStxB8dmF5LmXyGhywz0WEhnBFJ7uDWpNQ30B90kC4kpqJwa2D/4Aqa4QDlQUf+gHX2z664erScDhO2JZgpGVOYuC5kgbsR0pfq0+OZ2/MNwXoeg44D1nh0lg/PzCyTfUUjutTLtJ7kBBkF9/FEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZbvRX2uDf3y3ZgWKbRrEDoI3M7O3K8FvT+JX65Kj3Q=;
 b=vdGbNwfU9ljnVVLd6mUJesMjrsoviITKoEhSKaGyHqtZss6BV2XcZzjJD4VOBOECP3yrdZO/tqXp10jzNXMCsq+AEiFg/9g94vuvIeHc2jTYTyOBN2iQvUh4ufnnUiXtgPIN5CZxlWuh3MtoYkD+tl3x9MmudaDFb9YBytVOBaZpkTgZkKYNaxQ3dIobUhCdoy4c9oegbrfkeG4iq7aa1s8/Xjfe1Gw8P8k7xBx5DF0JoFn6I2JVaUW2S0xJjBWPKbVxIirHgUK5SOKhHqSP7/F2msKbbRbMqbFjtPcs9tK3IMMNPdm4TCbcavY4+dQwnUNCfT3i8khIGxwic1xOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZbvRX2uDf3y3ZgWKbRrEDoI3M7O3K8FvT+JX65Kj3Q=;
 b=zXAw8fndxhyV5YCOG2Ba5Ee+mwMF9RqMau3IMCtVzrTAfFOAq+P0vxeaZ2MLd2nOE/hze2SMltTb9njKO/j/5ZOlxVHpbaAm0z83HOSIB2y6np0Blv/d9xh9Kn8cYFimgBRVL7ErzIs+oYK3FiOLV5Yfi6h4hSM4K1rCu+ozcIY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 19 Mar
 2025 00:14:09 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 00:14:09 +0000
Message-ID: <fbf1cda7-8be3-472e-afc0-1a1aabf8d7cd@oracle.com>
Date: Tue, 18 Mar 2025 17:14:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Move memory listener register to vhost_vdpa_init
To: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowant@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
 <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
 <CACGkMEu6pNCJsd0BFcC4B0W68yMvaA3K-mv0KxTqbVdfS7-x8Q@mail.gmail.com>
 <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2a43cc-2fb3-4e06-f961-08dd667af7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTlVNWNKWUpPVXI2WUJ3cE83MXVHV0RYQmp2M05FN3crNWNzd1ZQSHd3UWg5?=
 =?utf-8?B?dFNDbUxXYmlIUjRiemdCc1hmMy9scVpaUGZ2UVZoTGxGa2tiWU5CR0JGRXpx?=
 =?utf-8?B?S20xaHQ5OEtKV083ZTJFZnhBdzFFR1UwT1hzM0dPN2JlRElGWjk4bzZVZlFW?=
 =?utf-8?B?MVZwcDYvQkJaNzU1TE1hc1E2ZEduNzJpdndBc1ZEck11OUFZVVhFd3lrYmNn?=
 =?utf-8?B?TVNUU1M5Z24vU2FVem1xWEQ3MDh5Q1FHSGY1MmhTajNZTCt1UklxN1EwRzNG?=
 =?utf-8?B?dDMyRnAwU3lqQVlXZ1RzbC96eVc2U3lNK0dIVDlkOWFQYVQyS09lUUxWTldZ?=
 =?utf-8?B?S0dzenZzQlR5ZU1nQmFodDBGOFRWelN4ZXd2V3ZJclFVeWJzb0MwVzAwdEt5?=
 =?utf-8?B?YjI1a1FYVEFEVHhZNzRoc1prVC9tY3F5c1RMVU5EaXMyMEM3Rks3OGp2YUxo?=
 =?utf-8?B?dWxrYm92K2tYV1JZOUdoelZ1eHpIM3V3SVNsZ2Q4ek56SDh4MDJDRVJtRGhi?=
 =?utf-8?B?a3haalFiTXZBQll6NC9iRUpsTWx1VnRNZGtNS01CWXVMR0RndU54Y2NGNTJJ?=
 =?utf-8?B?WkVPK0tXb0NzM3ZrcDJ5aHhJZVl1emZDNFUyZWlScnUwTXEyUXhreHg0anZh?=
 =?utf-8?B?cjdOWENKUFB1NE1xTEhQUFN3amhkZUdyTVJEaFRlY0IwUjBLNVF1ZStUb3ZL?=
 =?utf-8?B?L3dyQ1k4enMwdlVPWWlLbm9NbDJNb0pBU01NcFdMU2E1anV6alRNQmVLZjVO?=
 =?utf-8?B?TlNrdktXRW8xSXc3Ui9LcTF4Zmd6akFveFp5UC92bWdjVWZjSkkrZHNnVkZx?=
 =?utf-8?B?b0VULzlwNHk3dExyZjdGeVlIa3dPb3hraHhnM21KOVpqUDNGWjhYU1ZZVFYv?=
 =?utf-8?B?NjdhaVdpQnpjUHpjYjhad3hZQm53dE1KMnU4Uno1RzRBSjhiTENFVXVrTUUr?=
 =?utf-8?B?ZnN1L29JNDVUZ2NQbjRBQ0pvNTBmV1ZOcUh6d01hT09sdjBRVVRFeGFBS1Ns?=
 =?utf-8?B?ZFNjZVljT2I3bm9ibVVtNHZZeEwzV2FQTzl2WU1OWjF3SW44OHk4RzdlSFR5?=
 =?utf-8?B?SitxdGtrWTVaZTdDNUZKRWtmQmdka2MvbG05Q0xWSHEvbStTQ1JMNnhqaVph?=
 =?utf-8?B?LytobTI0Wkd6a3UzZWlsV0FBZk9LcGVjY2N1eUZYbDdIcXZGSFRPbS8raHVy?=
 =?utf-8?B?c3dkdmRpbFV6cTZpZmRYVUtnN2tydFFsOFpRRkVEd201NU1wb053SS85WlB1?=
 =?utf-8?B?UFlXbFh0bjIyS3FpOW9mekZsR2FPN0l2Z0NpN2wwZ1VKazVzR2twSFZXMkx5?=
 =?utf-8?B?cFl4YWlnS3ErWjExSmQ3bGszM3BDUWI3dkZlL0NBSUxkV0Q4Q2pSdXlZbFVa?=
 =?utf-8?B?a01aNURpYmd0L2JST0g2TUNUTTE4ajE5Mit3WS9qMWJiMTFWUytZdzNyVmc2?=
 =?utf-8?B?bm1RMTBRSk1WdDVsYUVHUjdyV040Y2IyUEMwYzBKTXRKdUVHZzJEWVZkSktv?=
 =?utf-8?B?UC9PZTJmaGtUTGtYanI0aE1oV0lobVQ2OUE3RVBqS3JQdEIyVHloSjhOeUhZ?=
 =?utf-8?B?VHczZjdsdmYyVXpUVlMvblNFTFZERm13TFlmRjE3TGcwcG9pT2hjV0FTUity?=
 =?utf-8?B?WElhL0ZTRzRMKzZmTllhTlJNdnZlZVRyM0hNby80WXdhZWlPWW9QVldBZitO?=
 =?utf-8?B?S3JPd1d0RkhwV0lORVhWS0xpMnQ3REhjdS9WRVdwNnM2Q1Q4endocS9wZnNG?=
 =?utf-8?B?ZEhLck1zTDFVYTRTa0lMQXdMRWJLQzNQbytFK3RUL1JCVG5sM1lNQnNJVUor?=
 =?utf-8?B?RXRuN2FZakVQV2N1dFZMMElSVDhRSVNmSnpDMjhKNUFnenJrTlQzOFZVMEVR?=
 =?utf-8?B?U3BEUHZITEFvdmNocUxYTzFtUHlwbTMwSTRoMFp2SkJsV0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lqN09TYW4wOTVBazFuTTEwMmRDZGxRd2QycE11MTNxZzhYa1hPa1VMN2hF?=
 =?utf-8?B?a2VoaGhsYnFybFFpZmF2eDhuRUR4VE5xbWtVblI2aVVMQ1J3czh6Rk9Oc253?=
 =?utf-8?B?N2F1VHJXelJNK0FwZTR2Z3dKNlV2VnFJZ2N6QVp1T0lrTFo1OTEvaitQbUZD?=
 =?utf-8?B?YUpaMk53bHZWbmZYS3FwbFpFdVRmZFQwKzhkMFNNYVB2aHV6Y2Q4SEJUSklp?=
 =?utf-8?B?alhVQmo0cjltcE5wZ1VRLzZLaXNhUlZqa2JaelpKbjRWOVBkV2JkOUtzY3pD?=
 =?utf-8?B?MHRSWjVwWGJPOXZERHBlMyt4NzIyUy9YcjhONW8xYmVDZzRQOGtwNnA2cDU4?=
 =?utf-8?B?NFVQU3dZcXZ3aUdEZWp5aVVLQ1lnK0djODdwRUpMWUFsc3VIdFlWMGlnd3VI?=
 =?utf-8?B?Sm9hZEF2MktvOHBoWWs5UTFQcjhndE1FdXBTUWYvRjdQRll4cnhSc1JYU3hR?=
 =?utf-8?B?eEtPbVF6RW1HMG1RUWNPSVVDQklBNDE3REJxV1pZQVpqMlVKdHFLYzhMWkhp?=
 =?utf-8?B?MnpRQXhTOS91aERBYnBDbGNOUFFRKzF3cEFoejNrMGFkbnlIVHBNTGN5bURT?=
 =?utf-8?B?N05YZktnNFlNNmZuNjhNcUVtbHo2c3hCZnRZMHZBN29nKzRXbld2SFRIRzZI?=
 =?utf-8?B?MzFDTHpqVkdGQm0yMzNmOUIxbkM1MjJveDdaWjgwTmpPZnJaaWZpWDNPaG5H?=
 =?utf-8?B?TERuTVE3cDJqTTYwdjhSZUQ4TWtIcWdyTlJ2VWpNWllqMnZDSTJlcFFORzhI?=
 =?utf-8?B?Zmp6SWRBMjVqM0pRbHcrRW9SM1RnWHRFWkVab2hxdUtFSUVld1FzVkZnUXNO?=
 =?utf-8?B?MitGemJHK0NNQ1NxeDREdDM4T05LcGpYLzNoZngzcFB0enY1dmY1WDhuRnU3?=
 =?utf-8?B?eWtnSFp4Y2xNSHE3elF3R1U1dkRQbGhiK0VFRUlEK3QyNm9wMGtmNXRtOTZq?=
 =?utf-8?B?dDFpTmZOZVFPcjVQRnAyUWhwWGo5RHZvWXR1Ty9TYzR3bXJmeGx6Y0k1NmJX?=
 =?utf-8?B?dlhwbnhScUo4c2U1TjljWlBpS1lJVkJxbkVzSFVIYWc0RG8xU0s0UnBKcDQ1?=
 =?utf-8?B?M25DQ3h1amVSTnpOZFdnQ210L2FmMDZhSU5LRVFJcG9udW1OL0d3Zk5veHZv?=
 =?utf-8?B?b3F5VXlGL0cxeDNXaE5KemlzRE9TeEZ2UzAyaWlzZkdCWWkxTG9hTURUYVdH?=
 =?utf-8?B?YzEvQ09kWjI5MUtueXlIdGRLNm5JNDRuZVB6NUc5UElWR05aMUZNVUZCMExJ?=
 =?utf-8?B?b2ZUUG5LdXplaTBBTHZtMmM1TzZ1VVNQVU9tSFh5Z3F5VVptZHVOcTQ5bW1Q?=
 =?utf-8?B?RHNuYkFtcjRSbmhlRzNiLzAvMjlyQ1lyTURteXpTL3RLN2RlQWFBT21ydVNV?=
 =?utf-8?B?Vy9DYXR3WjZPcjdTQWZoOExiWXlpRFh0SGpGOG14UUxUYytoQVpXLzQ4MkMr?=
 =?utf-8?B?Znl0NG1xWGM0bTV2OGltTFdLcUU2UUV5d1ZXQXJTT0p2cmhpVjVzcGlNRUpa?=
 =?utf-8?B?YzVHN2J6QklDdkl4Y0ZNN3dzbjZlUTZyUkJEQ1pPQXZLMUlRdlRZNTJFdktn?=
 =?utf-8?B?MEJTeU9xVG5zeWZHM3RUclFBelV0YWtUdWVoNkJtL0x2b3JHeTVHS0ZrRVg0?=
 =?utf-8?B?WjNDcTF3RVQyL3ZnMmlmU3haU1RLSkdhckU1VEtDdWhNZE4xZFRKWjNEUW1r?=
 =?utf-8?B?NkNTWU54MzBhZUl1NE9zT0RVUjBQdklYeFJxV3FFMnRPQ0JobFRucE8xbmx6?=
 =?utf-8?B?Wm55QlgzUXVxU0ZnNjIxVXdyVmVkeDRNVUYvZXlETStaVlNRWkN6TElYTUxK?=
 =?utf-8?B?OGRrS2szRkRKZ0UxL1lGWU9JL2JNOXdKOHZBZzRvRTd4c3UyT3R6amtIcnVj?=
 =?utf-8?B?S1Fqcis2cUZMVkpETVJqaCtodFM5cW91VFpuZHBJbUwvcXFLcU1qU2paM2RS?=
 =?utf-8?B?eGhrVCt6SzZIV05vSjVyV1oxTEhDYitKS0hhdXdsUTZXNEVkYVUwV29CNks5?=
 =?utf-8?B?bUExSk5kUWdjbWRZdDB1bkhhMzZZbEYyNStYNEdTY3RHTUxNS2ZjVm4raXpR?=
 =?utf-8?B?eDBmM0dHcEJOYlVnK1pvMlU4K0hDRU0yTU5QMnhxVjJIbUtCbGdIb0JvNEQy?=
 =?utf-8?Q?bDoQhpWeJ1e+lVXt5mKmX1eX+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q8muP7y9K4MeYQWf9TZFfacE0Kr8+xeR2qMz09QojVvUFoPHqTGrOn0Rv/0Fvd3yrW/++iVvmvGuhjNUevnsPsIUezasrPZt1RgmaF59efUwSD8bRIGks7p1aXJiq49GQvsLxyis2wNyEoM4411aJ/To2mj8lkf8b3bGx4SS1ZFCc4yGpVJyJ0DDw9v1JJbEgG9yK/2A3Ai/GOvHNIPN0+Cf4H6AONt1sXGBiaal1D/i5NrIUG/hV3fcTy3QhYVPRHrkmzz9D7IkZqOWNxTQFWJoicrLnS2yYpuTxRswtt/5tRabuwBefKra1xqPnVv0PSOghR8eONhU0MdCyY+agxo1cL9DInRLbQSBFAej1dbVy9Y2/OrNMydEhLfZS+NWvSGtyAijaVKc0T8Nka8kpaJjnAGB3ee+s2OvvQaWLiR/tjiH6twxzgRHwjpt4eXc+cquCg9D7pF+x0CByfUak8AwtNbVjOwjvR71E0d+pCmQx5mxqjK5A+hqZAw9JwRcrgpgNkknL0oUqTNGUe47VM1PY/yCDd3a7s87iWDpzJmGW9M09lslE9BZpHD1YRmCvUjCnDtYMdV35ZCer+RuuL4zmPcv57XPJuMTFK0DyHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a43cc-2fb3-4e06-f961-08dd667af7f2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 00:14:09.0088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FroRFyho4Hq6WTSfdLVmvgC6x/ws8QJ1JSXOwQhqkJJtwUn7MnDh+cpdZMkpAcsT7r5ppMycQR0B/Tjp7HHXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190000
X-Proofpoint-ORIG-GUID: Pz5-by_q9tWcae-fsbgtfcr7_zFEmvF8
X-Proofpoint-GUID: Pz5-by_q9tWcae-fsbgtfcr7_zFEmvF8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Lei,

On 3/18/2025 7:06 AM, Lei Yang wrote:
> On Tue, Mar 18, 2025 at 10:15 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Tue, Mar 18, 2025 at 9:55 AM Lei Yang <leiyang@redhat.com> wrote:
>>> Hi Jonah
>>>
>>> I tested this series with the vhost_vdpa device based on mellanox
>>> ConnectX-6 DX nic and hit the host kernel crash. This problem can be
>>> easier to reproduce under the hotplug/unplug device scenario.
>>> For the core dump messages please review the attachment.
>>> FW version:
>>> #  flint -d 0000:0d:00.0 q |grep Version
>>> FW Version:            22.44.1036
>>> Product Version:       22.44.1036
>> The trace looks more like a mlx5e driver bug other than vDPA?
>>
>> [ 3256.256707] Call Trace:
>> [ 3256.256708]  <IRQ>
>> [ 3256.256709]  ? show_trace_log_lvl+0x1c4/0x2df
>> [ 3256.256714]  ? show_trace_log_lvl+0x1c4/0x2df
>> [ 3256.256715]  ? __build_skb+0x4a/0x60
>> [ 3256.256719]  ? __die_body.cold+0x8/0xd
>> [ 3256.256720]  ? die_addr+0x39/0x60
>> [ 3256.256725]  ? exc_general_protection+0x1ec/0x420
>> [ 3256.256729]  ? asm_exc_general_protection+0x22/0x30
>> [ 3256.256736]  ? __build_skb_around+0x8c/0xf0
>> [ 3256.256738]  __build_skb+0x4a/0x60
>> [ 3256.256740]  build_skb+0x11/0xa0
>> [ 3256.256743]  mlx5e_skb_from_cqe_mpwrq_linear+0x156/0x280 [mlx5_core]
>> [ 3256.256872]  mlx5e_handle_rx_cqe_mpwrq_rep+0xcb/0x1e0 [mlx5_core]
>> [ 3256.256964]  mlx5e_rx_cq_process_basic_cqe_comp+0x39f/0x3c0 [mlx5_core]
>> [ 3256.257053]  mlx5e_poll_rx_cq+0x3a/0xc0 [mlx5_core]
>> [ 3256.257139]  mlx5e_napi_poll+0xe2/0x710 [mlx5_core]
>> [ 3256.257226]  __napi_poll+0x29/0x170
>> [ 3256.257229]  net_rx_action+0x29c/0x370
>> [ 3256.257231]  handle_softirqs+0xce/0x270
>> [ 3256.257236]  __irq_exit_rcu+0xa3/0xc0
>> [ 3256.257238]  common_interrupt+0x80/0xa0
>>
> Hi Jason
>
>> Which kernel tree did you use? Can you please try net.git?
> I used the latest 9.6 downstream kernel and upstream qemu (applied
> this series of patches) to test this scenario.
> First based on my test result this bug is related to this series of
> patches, the conclusions are based on the following test results(All
> test results are based on the above mentioned nic driver):
> Case 1: downstream kernel + downstream qemu-kvm  -  pass
> Case 2: downstream kernel + upstream qemu (doesn't included this
> series of patches)  -  pass
> Case 3: downstream kernel + upstream qemu (included this series of
> patches)  - failed, reproduce ratio 100%
Just as Dragos replied earlier, the firmware was already in a bogus 
state before the panic that I also suspect it has something to do with 
various bugs in the downstream kernel. You have to apply the 3 patches 
to the downstream kernel before you may kick of the relevant tests 
again. Please pay special attention to which specific command or step 
that triggers the unhealthy report from firmware, and let us know if you 
still run into any of them.

In addition, as you seem to be testing the device hot plug and unplug 
use cases, for which the latest qemu should have related fixes 
below[1][2], but in case they are missed somehow it might also end up 
with bad firmware state to some extend. Just fyi.

[1] db0d4017f9b9 ("net: parameterize the removing client from nc list")
[2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")

Thanks,
-Siwei
>
> Then I also tried to test it with the net.git tree, but it will hit
> the host kernel panic after compiling when rebooting the host. For the
> call trace info please review following messages:
> [    9.902851] No filesystem could mount root, tried:
> [    9.902851]
> [    9.909248] Kernel panic - not syncing: VFS: Unable to mount root
> fs on "/dev/mapper/rhel_dell--per760--12-root" or unknown-block(0,0)
> [    9.921335] CPU: 16 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6+ #3
> [    9.928398] Hardware name: Dell Inc. PowerEdge R760/0NH8MJ, BIOS
> 1.3.2 03/28/2023
> [    9.935876] Call Trace:
> [    9.938332]  <TASK>
> [    9.940436]  panic+0x356/0x380
> [    9.943513]  mount_root_generic+0x2e7/0x300
> [    9.947717]  prepare_namespace+0x65/0x270
> [    9.951731]  kernel_init_freeable+0x2e2/0x310
> [    9.956105]  ? __pfx_kernel_init+0x10/0x10
> [    9.960221]  kernel_init+0x16/0x1d0
> [    9.963715]  ret_from_fork+0x2d/0x50
> [    9.967303]  ? __pfx_kernel_init+0x10/0x10
> [    9.971404]  ret_from_fork_asm+0x1a/0x30
> [    9.975348]  </TASK>
> [    9.977555] Kernel Offset: 0xc00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   10.101881] ---[ end Kernel panic - not syncing: VFS: Unable to
> mount root fs on "/dev/mapper/rhel_dell--per760--12-root" or
> unknown-block(0,0) ]---
>
> # git log -1
> commit 4003c9e78778e93188a09d6043a74f7154449d43 (HEAD -> main,
> origin/main, origin/HEAD)
> Merge: 8f7617f45009 2409fa66e29a
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Mar 13 07:58:48 2025 -1000
>
>      Merge tag 'net-6.14-rc7' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>
>
> Thanks
>
> Lei
>> Thanks
>>
>>> Best Regards
>>> Lei
>>>
>>> On Fri, Mar 14, 2025 at 9:04 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>> Current memory operations like pinning may take a lot of time at the
>>>> destination.  Currently they are done after the source of the migration is
>>>> stopped, and before the workload is resumed at the destination.  This is a
>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>> (downtime).
>>>>
>>>> We can do better as we know the memory layout of the guest RAM at the
>>>> destination from the moment that all devices are initializaed.  So
>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>> while the workload is still running in the source, so Linux can start
>>>> mapping them.
>>>>
>>>> As a small drawback, there is a time in the initialization where QEMU
>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>> 0.2seconds.  This may be further reduced (or increased) depending on the
>>>> vdpa driver and the platform hardware, and it is dominated by the cost
>>>> of memory pinning.
>>>>
>>>> This matches the time that we move out of the called downtime window.
>>>> The downtime is measured as checking the trace timestamp from the moment
>>>> the source suspend the device to the moment the destination starts the
>>>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
>>>> secs to 2.0949.
>>>>
>>>> Future directions on top of this series may include to move more things ahead
>>>> of the migration time, like set DRIVER_OK or perform actual iterative migration
>>>> of virtio-net devices.
>>>>
>>>> Comments are welcome.
>>>>
>>>> This series is a different approach of series [1]. As the title does not
>>>> reflect the changes anymore, please refer to the previous one to know the
>>>> series history.
>>>>
>>>> This series is based on [2], it must be applied after it.
>>>>
>>>> [Jonah Palmer]
>>>> This series was rebased after [3] was pulled in, as [3] was a prerequisite
>>>> fix for this series.
>>>>
>>>> v3:
>>>> ---
>>>> * Rebase
>>>>
>>>> v2:
>>>> ---
>>>> * Move the memory listener registration to vhost_vdpa_set_owner function.
>>>> * Move the iova_tree allocation to net_vhost_vdpa_init.
>>>>
>>>> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
>>>>
>>>> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
>>>> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
>>>> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
>>>>
>>>> Eugenio Pérez (7):
>>>>    vdpa: check for iova tree initialized at net_client_start
>>>>    vdpa: reorder vhost_vdpa_set_backend_cap
>>>>    vdpa: set backend capabilities at vhost_vdpa_init
>>>>    vdpa: add listener_registered
>>>>    vdpa: reorder listener assignment
>>>>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
>>>>    vdpa: move memory listener register to vhost_vdpa_init
>>>>
>>>>   hw/virtio/vhost-vdpa.c         | 98 ++++++++++++++++++++++------------
>>>>   include/hw/virtio/vhost-vdpa.h | 22 +++++++-
>>>>   net/vhost-vdpa.c               | 34 ++----------
>>>>   3 files changed, 88 insertions(+), 66 deletions(-)
>>>>
>>>> --
>>>> 2.43.5
>>>>
>>>>



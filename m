Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC94C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 21:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn35X-0003R6-Lq; Wed, 20 Mar 2024 17:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rn35V-0003Qi-Tf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 17:03:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rn35S-0006n6-Uf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 17:03:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KITOiS025615; Wed, 20 Mar 2024 21:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ox7+KbubiQjDXgvr6oSN1xfnZ+4uA/RknnbC6FqTyP8=;
 b=H/kgef9TWHIleS8fIfpiPbGsvNkXb68/sM4aBxL2gCrXwBuu4JgnOajthqyHeOSIYpaS
 Ejm/cuZ9Z2/8LFO2fR3K1LrHkfduWiW1YNG2m/SoXhRwrZC/xcE79GnXXtyqcpA6Fv9G
 NDCrhMh0vc2+xiN9ZIDuxji1u5jImqMPxIAmSi+eTvPJ4teVHe+ZPoh7Gk4/gzKQNvYP
 dvtWxf5fJTocaQjnk633Fyk2ouTsqO9ySbplbNl/iM6G4CESy0fbc+2PUMQGGZi4zDLP
 uDIwfhCxVC13bIF8KYDjXPwxBAInD1tlHNJleFUVDZw/atgZ+ZhTxYDnRtuw/b6YlSxr 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww211950m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 21:02:55 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42KKhjFF006044; Wed, 20 Mar 2024 21:02:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v8kx03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 21:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgk2ECACr06ha9WwuHU5uFdrP5xSWArujvxsEX/LQgyhsq+jLQB1JRh0RHn50gG7cq+IWDeO+ziso2AbU5+dnkjBsKHvQiEvzR57a2Y89mPLdeu8bJXbNvpV1PXhTXr17nnIsi9NASm0S+24wNGKYeHOzGYsXogp4TImcFArq8L0ryxg4xQB1tTpHdKLQIwU04jZ3WfbkFtKwctXN6gHLjePioh56KCpeA2BN0zIDaqZ2tklJblekb0cGyQgt9NkL4z/etW6VAACxkCVG8gwAO+Or77kSXpJjbc8cG57Q7NMxGvlryF8b5SdR9MaPEanIzdMFic9VN1JXfGRFpnl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox7+KbubiQjDXgvr6oSN1xfnZ+4uA/RknnbC6FqTyP8=;
 b=GPHIeWjeMXzqh/7GLJshvEC/FAvl7fKfX2iE2zHMMOhMKHxXwSsYPugR5bJUa3RQXJ1PGnuSjVWqA/uYt59x1sEZDMO7cEk2TNaRx7cy67YVWuZu/XvI7jnWv4X5t0mKetM/Mj4XQnZ1jn6yMvea6HfRL4duaDdbhysX8IiriHSzk2mk3B4/eb32RnV3paD/VuqM/T+yXRkV3Wjo8xeWmextC8HV3UBCObOSmAJP9olImlPz9jCDAYxYAzxmVtr/bbP8G5FZrk5BGKT/TX35HpF/0FpD5jGhi3KqX5TM0MeUtKBC/b8QqZPp7jalp1q5Je2mz/CZ0/RL68RUYy9Tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox7+KbubiQjDXgvr6oSN1xfnZ+4uA/RknnbC6FqTyP8=;
 b=O6FSNPOMeSPZRJgOLpwDWb9bmUF1CeuNoZulHNPJQCzZuYQ9Na+odmo+wUzNdvR1RkFcqi1ytMQP4+E4MtL6N3pdrB7yUTMRh3zSU8/6JDuVFyVSCZiAp9YUXWaQlMtdQMzFv7Y/tw5+ZnRdi/v4xK3ff98FSqud19+DCjEexH4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 21:02:52 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 21:02:52 +0000
Message-ID: <35fc446d-61e3-49a3-b79d-c44aa2e65fea@oracle.com>
Date: Wed, 20 Mar 2024 14:02:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
 <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
 <CACGkMEtEtmOZB53xibp5G7ZeVdKpZogEnetfnfj1QCSX-RWY8w@mail.gmail.com>
 <0dec84ec-289b-4026-8098-010ec4c5c315@oracle.com>
 <CACGkMEtWe59mNWORwS=OMg3MXFRdkPwmjJu8wR2rTXBr4w2_MQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtWe59mNWORwS=OMg3MXFRdkPwmjJu8wR2rTXBr4w2_MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3450e42b-6d0e-416d-b492-08dc49211b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49BPFY0irlbQIsqC4I5jopMSe868V97gq3bBCc1FQ++RCf56DzoL5h1RFenEB3gnuqWEPLTdwInu/I9klEfB/JMO8xJn8Fkp0ll/N4eZCAWNgyN8cjwrivck1Avn0D0tWv/QrYEriamIh5SzEgAilP8L75ALtz16Azi6fpb/0dpNRWdc+shirUkq/1FYnO1oCUCvGf1/DNfrXCOLG9SBxA/FDI5CBWOh9p7iUQligIly7kvFaszUXYXr1zhYGMMk+22IVmmC3eyXoznr59b5NQl9b9JQXAo51PfifKTalkX6Xi/gXJgcGlB5bVUDBuhtmvZ90zHscNvbt4I1vQY7bhgqYzEjkp1bi9qLUZ4K9JB32BuHShFI1O55zdDy7XewRE7kFQSAyyWju9Zr1NbxqNlWlOtHd1bAiWxVf4KZokMDfUVtZ0SpNudk8kEnCEM27kWTcAPrGxFpBP8qc9v8m/BmhfQhTNqRu0mmlVDd3LAhySMoM1VQie9KBmaNrvOnjydtz9LGWm7CuGUs2LmADOkQf0MejOtWZHgjNV1cxaxFtC6o3/0eSVuwzBEBo9EWBcC81FMnkzStQi0q16k/Yd5Jefl6K89Cd7QWFBd+K2NOfKPnpc7lU4pCZHUQe4dKx/plo2LzEPnXKArPbO3VvoKR9vN8YzqgxA9Cl46I91U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHQxTUZJQ3BKamVzZWI5RG9iOTFJK1poNTJVQ1NnT2QxdEhRRU04dUExVDk5?=
 =?utf-8?B?QUtWUHJZd1JOR3Z3c1FYVXJ0eVV6RVZBekw1aG1rV1pEdytKR21mSkVxeXN0?=
 =?utf-8?B?SVc3OFZVZ2FFWXcyZDVWdjU5SHcwTzJTdUJndUd4QXJTM3c0SDFHZ1VxUTVQ?=
 =?utf-8?B?WCszbk90c3pPdTFPZ0g4Umt1MWhhVDh2aXR0dVpDK2h0N0xVUXcxZlpocDQw?=
 =?utf-8?B?RnBudlpneStwNzdLL0NMSGUzdkhSSjEyNXpJQXVCVlhoSlBzUkdHMmMrS1VJ?=
 =?utf-8?B?eWVQWU4vNDVjR1lMeFVjL1JDSEdMbjRVM2VNVkxST1h4bCtobUJFU01uT2Ri?=
 =?utf-8?B?a0M3STE2TGhEaWlxSzJLQnJCNCtMVS9jOTNhRFRoMnI5VENRbmxKaXI4NG52?=
 =?utf-8?B?MVdON1ltSXdzT0U1WnZkSnc0Mi9Fb3o0ZVh5T0hmaVY5dkNWcU9DblMyNll2?=
 =?utf-8?B?SC9LUExraDJQMnRQVjYrR2MxMngrZTZENk5EQngxbXFRSTdIdjN0UWlmbUQr?=
 =?utf-8?B?QVl5RUFvSDJad1F0dlhjLzROZEc3am8rbFl0dmliS1FpTTZCa0pnWHFsSjBX?=
 =?utf-8?B?QTBObk9SRlYyMm8xbXBTNGI3dmxlVXVpTXhDRVJQV1dKdGtQTnp6Mmtlclln?=
 =?utf-8?B?MmRNeVNzT0kyeXpCOVhpT1JzZTBKNlowVjAwaTRTeTNZV2pMVmhuWGJLS2hz?=
 =?utf-8?B?aFR5ZnkvZHFCV0lhclc5dE5qK0hoV21aWXZoU1F4STl1T0NuTXdCSkc2Tkc0?=
 =?utf-8?B?UytUUUNCWXkvajdNUWliQVJyYVBaRzRMNUlWVmNLVXhoUm5DLzNKR3pRcFcv?=
 =?utf-8?B?V0hucEtjZEZYOTJudWxna2dFWHJNbFJoYWhuakdlM2hXR29HVnVRQXRZWWdY?=
 =?utf-8?B?S21YaTZJUVllb3JtdzZjeE5RRjJKbmdXY1Y5KzFrd2Z6bk5kUlUybUhIdFBT?=
 =?utf-8?B?TTBMVEg4Wm1USXRidkNUU0ZOWThXSmloemMwbmtmQ29ENk81WE16RURXdUE5?=
 =?utf-8?B?Z3JXcWh5UHhpZWdJWkRkZ240ODg1b09YdkhHREEzclV1Q202MG5nSGlodW1k?=
 =?utf-8?B?UnMrS2REdEd2dTU4akZoYUxVNGJMR2p1RndYYlV0Tk5hZjV2UjFkVkVvUVJq?=
 =?utf-8?B?ZUJvQnVTWUlpYW5ydUcxQTcvWGNvUDFpcWZxZ0R0Y0Q0VDFORFV6WXZWcmlj?=
 =?utf-8?B?YzlrUzdsUVVKV2F1bDgwSk9LUzlnMURkMVZFaE5QTER6cldhSjdSM1hTS1NB?=
 =?utf-8?B?WmhMQ1pEalhOYnhBYTAxLzVsd1ZRU2ltZGVmU3VySnpEMmx6ZHpYemxSWHBt?=
 =?utf-8?B?RittMTJrL1RCQVpBWlNPak1lQ3BBU1V2S0FqSFRaQjEwU0xzaXoxUGVGdVB0?=
 =?utf-8?B?WEZyUnVxRnp0djhqNTFMY3FHU3hjbURybytaN0diV3czZ3dWMTNqc2M3M0lV?=
 =?utf-8?B?RjNPUTR0YlBBdGUxK0svMFNBZm0yWHdCRDZNSTlWeHBqN2tlbG9OY3BnZ0hm?=
 =?utf-8?B?TUw4dEIwa1ZldG5jWFkrcHZzWFN5TXRTRTE5Y0w1Z1Z6SytvQlUza3dwZXI2?=
 =?utf-8?B?dE5LaEZnMkhyMU5Ba3FiUU1rN3hMSTdQZ3lSVzRFVTNWN2Q1ckt4dkN3UTdV?=
 =?utf-8?B?VU8vMUhxaWVSYllxWmVoTHdVMWlVZitTWmZkRHgvaHorQ1UwazNaRER1T2pM?=
 =?utf-8?B?UFhoai9WbVRIaHc2NVlHWnM1emx1c09vOVRPU2NtY3EvU1U1Uko2cFZDV0hS?=
 =?utf-8?B?cTl1emhtMm1JaG1UbVhlTzQ2L0tiVkl4cEZ6a0cvT0JMbjVDY05peVpCRm1z?=
 =?utf-8?B?SUdaZEVibHZpQ0dGbitMTCtlcnhYcktHUHUwSVhFVkR1UFBoNlJEZGhFVXdR?=
 =?utf-8?B?VmIrTjZ2VE45aDJFTEsrS085S0FoOEd4ZXVIZ2p3ZU55cm0xOXFVLzdsTi9y?=
 =?utf-8?B?SW84ZUtzRGE4eEJWYWFGaFE4bHFyb1JTNzNxOWc0UE10Zk5mY3ZwLythRmty?=
 =?utf-8?B?N0dBSmpKaklIU29PaHJRZnFmdXpaSFJvQk9zQ1FjQ1NSYm1jRU5uZDNGR3Ba?=
 =?utf-8?B?aXZMbG9UNm5Gd1o2c3pYUW1LUkNqS2RqblVZQkxYamNMMnhFM09KZXB1c2Jx?=
 =?utf-8?Q?z1z9Z9/dfJZEq2EDMORhOE+eH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wt0E17EFeU9+N3/GTmF/ALigNV5Z1YcIWIubkxjmr4aDFcSX3jBP/1owxPXTDTvk1/RMOIUwZ0C7+Z/d9OsLKoN6dmK2SAGIF9t/HmOrF519ksZshwB88pygyvjzZUvUjIk3Q7s1FhqwfJJnHDwJqmppCZw9cX/NiC9sM6jD7gcImx081UeFSXNyWpqfy8dNWFC2kWsonm8fKaVEnZg7ScTUsNihRs9gZfSsv+xyWdlwjtBV+5VBQ4K1toMcR/uL3sZ554Xp1obeONS7yCizSKw8WAJ1sBfClbFLZzdJ7tD889wKPO8hWaormiEw6E6kPq+an6K5JRqg2OmhyBGp9y0G1QECRkbXDVesXg7mgYl4/v+2V5F98Lih6MEIHR6hfDkCEoH6DuI5FAu5ogVwKvvBNL0zRmS6vSZzNRBg7vhaWovQrUWWCXzmXa+I4kaeKzzVUslPtt27NkFykFmYykGpwZdUKMeAbp5Y9EPPCeYgIxfrSLxUSbsfk8SuPaqLqdx9qm+FqbyeRv3/pDEGR5GpzitooShS9ObZLHqzzk8J1hJeWKrEnDmfYEBeGx3e27AkuWBqT7ztA8Xz9lLGi3oEWJyqXkG7WPPI8tewqK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3450e42b-6d0e-416d-b492-08dc49211b4d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 21:02:52.2835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBs6/mu6Ky4yFXjZYWyxHnXr9C9vgwgJI89UIBVqvQ4+p9E+J3OVI2lvNyff/GChfXtTuFo+yX22h1KUghRZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_11,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200168
X-Proofpoint-GUID: 1aMjU4MSGz2jn9T_M1MCZg1i8VS8Shke
X-Proofpoint-ORIG-GUID: 1aMjU4MSGz2jn9T_M1MCZg1i8VS8Shke
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/19/2024 8:27 PM, Jason Wang wrote:
> On Tue, Mar 19, 2024 at 6:16 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/17/2024 8:22 PM, Jason Wang wrote:
>>> On Sat, Mar 16, 2024 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 3/14/2024 9:03 PM, Jason Wang wrote:
>>>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On setups with one or more virtio-net devices with vhost on,
>>>>>> dirty tracking iteration increases cost the bigger the number
>>>>>> amount of queues are set up e.g. on idle guests migration the
>>>>>> following is observed with virtio-net with vhost=on:
>>>>>>
>>>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>>>
>>>>>> With high memory rates the symptom is lack of convergence as soon
>>>>>> as it has a vhost device with a sufficiently high number of queues,
>>>>>> the sufficient number of vhost devices.
>>>>>>
>>>>>> On every migration iteration (every 100msecs) it will redundantly
>>>>>> query the *shared log* the number of queues configured with vhost
>>>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>>>> but not for the memory sections which are the same. So essentially
>>>>>> we end up scanning the dirty log too often.
>>>>>>
>>>>>> To fix that, select a vhost device responsible for scanning the
>>>>>> log with regards to memory sections dirty tracking. It is selected
>>>>>> when we enable the logger (during migration) and cleared when we
>>>>>> disable the logger. If the vhost logger device goes away for some
>>>>>> reason, the logger will be re-selected from the rest of vhost
>>>>>> devices.
>>>>>>
>>>>>> After making mem-section logger a singleton instance, constant cost
>>>>>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>>>>>> queues or how many vhost devices are configured:
>>>>>>
>>>>>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>>>>>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>>>>>
>>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>
>>>>>> ---
>>>>>> v3 -> v4:
>>>>>>      - add comment to clarify effect on cache locality and
>>>>>>        performance
>>>>>>
>>>>>> v2 -> v3:
>>>>>>      - add after-fix benchmark to commit log
>>>>>>      - rename vhost_log_dev_enabled to vhost_dev_should_log
>>>>>>      - remove unneeded comparisons for backend_type
>>>>>>      - use QLIST array instead of single flat list to store vhost
>>>>>>        logger devices
>>>>>>      - simplify logger election logic
>>>>>> ---
>>>>>>     hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>>>     include/hw/virtio/vhost.h |  1 +
>>>>>>     2 files changed, 62 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>> index 612f4db..58522f1 100644
>>>>>> --- a/hw/virtio/vhost.c
>>>>>> +++ b/hw/virtio/vhost.c
>>>>>> @@ -45,6 +45,7 @@
>>>>>>
>>>>>>     static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>>>>     static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>>>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>>>>>
>>>>>>     /* Memslots used by backends that support private memslots (without an fd). */
>>>>>>     static unsigned int used_memslots;
>>>>>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>>>>>         }
>>>>>>     }
>>>>>>
>>>>>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>>>>>> +{
>>>>>> +    assert(dev->vhost_ops);
>>>>>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>>>>>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>>>>>> +
>>>>>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
>>>>> A dumb question, why not simple check
>>>>>
>>>>> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
>>>> Because we are not sure if the logger comes from vhost_log_shm[] or
>>>> vhost_log[]. Don't want to complicate the check here by calling into
>>>> vhost_dev_log_is_shared() everytime when the .log_sync() is called.
>>> It has very low overhead, isn't it?
>> Whether this has low overhead will have to depend on the specific
>> backend's implementation for .vhost_requires_shm_log(), which the common
>> vhost layer should not assume upon or rely on the current implementation.
>>
>>> static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>>> {
>>>       return dev->vhost_ops->vhost_requires_shm_log &&
>>>              dev->vhost_ops->vhost_requires_shm_log(dev);
>>> }
> For example, if I understand the code correctly, the log type won't be
> changed during runtime, so we can endup with a boolean to record that
> instead of a query ops?
Right now the log type won't change during runtime, but I am not sure if 
this may prohibit future revisit to allow change at the runtime, then 
there'll be complex code involvled to maintain the state.

Other than this, I think it's insufficient to just check the shm log 
v.s. normal log. The logger device requires to identify a leading logger 
device that gets elected in vhost_dev_elect_mem_logger(), as all the 
dev->log points to the same logger that is refenerce counted, that we 
have to add extra field and complex logic to maintain the election 
status. I thought that Eugenio's previous suggestion tried to simplify 
the logic in vhost_dev_elect_mem_logger(), as the QLIST_FIRST macro that 
gets expanded to use the lh_first field for the QLIST would simply 
satisfy the basic need. Why extra logic to make the check ever more 
complex, is there any benefit by adding more fields to the vhost_dev?


Thanks,
-Siwei

>
>>> And it helps to simplify the logic.
>> Generally yes, but when it comes to hot path operations the performance
>> consideration could override this principle. I think there's no harm to
>> check against logger device cached in vhost layer itself, and the
>> current patch does not create a lot of complexity or performance side
>> effect (actually I think the conditional should be very straightforward
>> to turn into just a couple of assembly compare and branch instructions
>> rather than indirection through another jmp call).
> Thanks
>
>> -Siwei
>>
>>> Thanks
>>>
>>>> -Siwei
>>>>> ?
>>>>>
>>>>> Thanks
>>>>>



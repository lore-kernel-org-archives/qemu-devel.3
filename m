Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FCBC54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkU0J-0000ln-7u; Wed, 13 Mar 2024 15:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkU07-0000lT-Ic
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:10:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkTzt-0007Qh-6a
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:10:54 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42DHx2NT015075; Wed, 13 Mar 2024 19:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KAgeJKGlNWXTlSjfYGsoGa/6MN5mvyUgno/nc5X+peU=;
 b=mQyFVp47ZbIDU0Td5NIu+TSv+OUTNg12nJj3GFjTekxpEw1qXQGY0Ad+jzTc4QmSkwMX
 Rhb/qkCQ0UF2hEGiB8ePdHYjaHnQ3Uo1o00kWa6kDgnbTK8ByLVbAzMJsY0k172Td1gE
 1fV2nf4pm7T231KxxNsjejReY54vvtTpL+TXhaka3veLtoxp9IUSlv5G5N1oDztdZwDo
 9S/riO29RttEljIBE2Qi0A9HuLj9GRLt3Cmjw0akfseV/OVlhdBo04y16F/duilgCJCv
 oP8B/DmPvnpBZNzbz51P27RiJgZ1oyHUx3QmRBwgAxXQJxAFl2IZ1MCcxwz8Muuu6tLT zA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdhx4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 19:10:36 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DJ73jC004864; Wed, 13 Mar 2024 19:10:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre79kjj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 19:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu8RnMgiDpZj1tzR/RabDdY7mbWkKGr/EOe8kZ6CZuU1qYucx/JEcgP1mG6t3BHErXYaQNQGtH4jis9aCqyL71i2wvHIUykVpYUJtEvtZOTlEuZ3okC41u1irGE/8fWEUzCGcylIzcZFQGg9sEqJR2zS2wGU4O9qaC+LeuhrvmHWEIRsmIO5aYDeCdVF182vIH50e5wFKuTCSRfYAd+D8caXYNcyY9frx+DWhwwQEhuEIeUsEMBpD4ENeGUJKB0C3/4FyVe/vyT0K4hGYcmgQkBP11hca3PcGud0N95Nm3YqNb1psa77fHvIPjuujYS4X7bnpLh0TsfnX/ivi4NRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAgeJKGlNWXTlSjfYGsoGa/6MN5mvyUgno/nc5X+peU=;
 b=X0UoESKiNx8/KAiBrN6qTHsbUiX0m+ISLu/+pRZP2R64JUOoxLu50yFvnxwAgln4amRbqfFWGMZTM4IxNP1YVvLF9h5yoi9AkrawlDJBITort+raQOz9nzaE45JahZBj9oeMbwGlTweLqTMYRnouqeu8om9dAKzfaLFHYxrA1t88FkwBgOvjvSObsiay7JxNqCAc6GzczyYVa0zTLxAWKL/S6YJQhxfKQdLwHFA+W1Tp+8v5jrxlnsGq1B53prmGM+HJQAGAN9dCzb4zsOv2ws+9s+ncUQoCqDwx1LckdBdWi5wthZMt5VQHaOHmBbCRDJnG71aFV+mmQ9lOuEIz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAgeJKGlNWXTlSjfYGsoGa/6MN5mvyUgno/nc5X+peU=;
 b=mYznookYcPjHYf3wdynnS1rQNb5c79uDeeiPGKrDcCRI4aOW5yaK0W9WncfZ8btniZyaKwxPdYmoro9/C2Cm6WPuyQZs7IVv95OBxsAegrRTDyb/Mc2ELBq7FAPpG5Pdl5LCq/EFxXo+wwJuS4z6R9thQVmKz3GJgL8a+KpD3GE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 19:10:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 19:10:33 +0000
Message-ID: <d869db89-f39a-4358-9977-7d5c1a027d31@oracle.com>
Date: Wed, 13 Mar 2024 12:10:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] vdpa: fix network breakage after cancelling
 migration
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
 <41f0f7b4-ce3d-4e60-8567-1aa34a616b1a@tls.msk.ru>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <41f0f7b4-ce3d-4e60-8567-1aa34a616b1a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8d9c40-3b67-4e17-1fd3-08dc439141d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/2QeOhH93wwD7pfQOBvqLThMdsvacii5kuzngmf2dzaBck++n/UUk5nY3eP29nMKEo3zobu0jbNsU1PbdfBXVfcrZzOGD3iMaVtI06g6HvAVZmPN0mxV8jPb5ttz58zVuzOlSKOx+GJNz/RLQq+z3YCfBo03DFkBTEGAzwmMgOS1zy0wdinNCaVouUfd+v6kloQhyjKWzajGCbX3oOW35sNInXwSyBZauFRjmfbxsRk181+IUOvCbt9p8g+m2ExLIGKSMhZM1N+EQ348+ou0hr8SBJOd7/Mxw1z3rO0/NXcg6HbbPhPwTr5I0Ijc2GtFSjFSqFZtS4EZj2hqN/6ObP2jueTXEMEesUba+5rtDRtRFtQbVrr2edXkuPxZZbPd/d0Q/o4RWZfsCAkJi+jinzIzF0Mngq+ww7SVN+iataoqZA+BYLVqdsmei19JXhPHNKYtDP40XpA3pzWdXdkLGwsSEX1R3dPuFO89+MsxF1iT/shw7G0UfQ7SF8LyKOjbccmtr/Z8Y1A1LGdB3G+QIt6iX0bZ+IKpS+5MaNNCtPFBxzz++a/XGTV/5WJWo7KF8Ux4cxKx00OWKeFr1QIrBrjuyoYeiedZ1tsEUZIdQ0SQkb1mEK2glxoz0WAh4UH4KGDFKBuYjGN64KVLxFmh75F8RQktd0dNy+hedGpARI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhrRmtBeXhnanRPSU82ZU1iWmYyZjkyNSs1cThESW11TzM4dk4rRUFmaXp0?=
 =?utf-8?B?WERDQTY2RXpGb3NFSk1PdDE0dDhySW1ZajNLTXMrTUZJK3pEUHJoZG9lNXM4?=
 =?utf-8?B?UnVYRmRla005aDJ3WGhSdzYvK0x1UVdFQ20zYVlBcGdmQ1ZWbUFDTTlWYUFj?=
 =?utf-8?B?cE8vOXBOVzAvT3F2eHRBZktyaUpsTjhxYllJZklOOVVQZytWa241YkRLUjJm?=
 =?utf-8?B?L2Q2a3MwYUdZbkh2QVFtNVVLMzV1dXdvQ0ZYenZsay8yaFZyWFlMaTRVZVQ3?=
 =?utf-8?B?c1F5NHBZbVNnRmRUc3lrV0NBeUo1SE5oQWRUSHVZQmtsNE02bVY5d0lKbnAy?=
 =?utf-8?B?SFVObWd1YWp5REs0VkxqUmRSckdVYkQ5WUtDTVZTa2pDb0h4eEpsaC91bE15?=
 =?utf-8?B?QUg5ZmI1cTBCVi9YbmUxMysycHpXN0psWm94Rjh2UHZQTXJmNEtxOHNtcnhZ?=
 =?utf-8?B?bG1SRGZsRGFWcnpWV3Y4anlDY0d6ZlAyb3RKYTRtbzRBWWdHODJ3YTROdGtp?=
 =?utf-8?B?R21LMmIraEw2SFJsK1ZnVll1MnBzTVExR29pWmRyNkNQeDR3REtlbDdteVhu?=
 =?utf-8?B?cHFCNlQvanBObE5UYlB1VnA4YWI5eUZadzRWZkxwVXJPN0w4TnBXSnFJS1Ni?=
 =?utf-8?B?T1V5Wkl2aG83Ynl6elExMHFSeEdUcnRMbWdseVNVZ1FUL0dhMHpUYm9VNnhK?=
 =?utf-8?B?bW51cUtKektpb1J0clZaN1k4cGJucC9hNk92cEtvRnZackRpeHBpMDhDR0M3?=
 =?utf-8?B?WDdOQ1ZWSFVUVGtJUG1ZTVpRWWZ3L3dnMlplWXhQMWdvZDJLVS9KTndSVE5m?=
 =?utf-8?B?b20yM1dCZUVYL3pwRUZJc3l0SzJBZEpxT2FLZ2NMbEIrQVBJZUtSSUJSbzBX?=
 =?utf-8?B?UDZUcHNrV3VieTdBdHc5MGdNNmYyaUEwQmE5eUxOQk5PUGJlcUJwRXdwbzZ0?=
 =?utf-8?B?Slo0R1dvKzl2Z2NOTVk3VUVLNHdwRlRzTElUYlFhTUltWTZXOFlwMXJnUkFp?=
 =?utf-8?B?NE9BalBKZjdqTitNTUFkTGJiRkRqUlh2Z0xaRlZpSlBMSVo3bFZuWW90Wnpw?=
 =?utf-8?B?RzB6enVNNnMxRzJlODJWQkxWclR6UklZNG0reG1pZ2RjNm9kUk40N3E1eXVV?=
 =?utf-8?B?bFpzVkpJSStMZHl4b2lXTkFudkl3TzVjdTA2VWUxV2JGNnM0V1B6eSsxellj?=
 =?utf-8?B?bythVGZrekltMmpTcHZBaW1OYlJWazJtMTRlai9iT2ZpaDF4Ui9kQmtZR2tY?=
 =?utf-8?B?Ny9Ib3lWWmNxaGdtTUlXWlpMd3hmLzFzVllyR0xSU2tEWjNPOWNyTnBMRi9z?=
 =?utf-8?B?TVQvcStPdGZCbWhkRWdsc3N2NXNlTHJjbGhMMnlVV0RKcERiTUUxZ2Frcllk?=
 =?utf-8?B?L3pJYjVWN1l6M2xXU3AvK3NtSXJYWTg5M3NxdEdKOE5xN0tOc2pGQ0pldWtQ?=
 =?utf-8?B?TnVlKzcwdmtodlI2ZUxuVWJ2WDQ3Z2tPNGswYkF0ejUvZ1AxUjFGNnU5MVZ3?=
 =?utf-8?B?aCtjSHByWlNnY0U0V3Z2RTlJVFRITWRwNWl1TGg2eXZnc2tDalo3ck5qN3Uv?=
 =?utf-8?B?RWp5aDY3QndRZ3RqekdhUUZZWC8yUjRyWGR0LzFmTWdFUGN6OGhaZjl4aFVY?=
 =?utf-8?B?d280WGRxUEMrUno1NGU2YURZeXEzWDNIUC83V013T2JXWWhIZWdUZ1ZRbXVV?=
 =?utf-8?B?Z1VuWG56Zk45SU53K1hjbFprUU9NMUVtamI2VW9EQ0hBQVcvWEZTdXRwZHU3?=
 =?utf-8?B?OGh6STBwdmtNaXBVdjAvY2gyc1o2cU1UWjd1VVJhcmRYbytQVkhKSWt0YjFt?=
 =?utf-8?B?MEFnTVVmdG4reUhyZFRleHhGcm00dkVOZW8zNmpOV2JnNW1ISlI0U1dPbUto?=
 =?utf-8?B?dWJuQ3ZVODhEMHFHWTNzd3dKaVdzaUJrNmRpTUxYdWcxdkVxdS9LRTJYQkRF?=
 =?utf-8?B?dFE2VHkzRlNuQ0lVSWpvTHJRZ2o5eXdLL0EydUlPaEx3TDJQYmM5UnJkMVQ3?=
 =?utf-8?B?YWl6MzhvemhHaHNHbHNTR0I2ODZtOFhjNENacDJVL3VuU0dkbkNOWWlmeHMr?=
 =?utf-8?B?Rlp4d0NOZm1ma1g0NkNLcmJoV0hoQjQ5cHpLaFV3N2xZWUtSQkdVNTNIa2hm?=
 =?utf-8?Q?zWtSM8jtbJzOTy/D1836YAIOm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jNlZaYBHtv71Zj7+WgICPXKAmPND1S/xaf71HWIHeBSk0j/+RMZCOZr/rocVihrfjK6ZvH/DT72ZdLcUNSSz7MgMjT4HuHMFWqUGGKzrqiPzDbhv0jnEqD05HmK6u9A/8Vc/clzYaKVpyEqZ0eEaFXh5MaCX9cWkZ/xqxPP9S42ayvq0YCIhGfDvWrQFatUOyuAp61aBptxZLwH2SnGoZzK+tILNpCSIib1M+nylXJiPqELqdjmPJY/JfEbt9lu71aEGtFpJJC5xtmt6P2K21xt1vYhU4FbI47JYQ1HZVrOHJYPVBjV9tC4rRnA5pSUlpW1RuH47RYG3xnNAXOE9Kht+4BpABON9U9sYP6eQXmQwBipjIpo+FbHuyw3ijSwA8OVXXKzS//6UgW/SypmtAqtdbTBDdIOuKCGTHo6WhhVoBM851qzbNwc/RMRE1yyPO80D/o0bniygMY19yYXs4O+eahm9GQ1nJt/ILA8AvjO7nBj0fxfWNFw8WoXC/NeeM8b661RsXs+bIq4fo/kQf5P3qCnA2JWQUXEhiyn2N0Y++7MUqis/smjHKCCe/Ev9VGlH0p0Rb6mXr3VfgZ4VGh+8tPrpotbGJcEwiOtVI+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d9c40-3b67-4e17-1fd3-08dc439141d0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:10:33.6026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTlCb6v4t5bs/0MU1aUyti5ROmadkeSnZc4rA7W+G/9IDavHeAhh08pdfTc242sm6Y8Yk3tqJe+pMpjtXSNAMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130147
X-Proofpoint-ORIG-GUID: mceozs_8iRPE3ZZ-pESOTA2qUeGw30SQ
X-Proofpoint-GUID: mceozs_8iRPE3ZZ-pESOTA2qUeGw30SQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 3/13/2024 11:12 AM, Michael Tokarev wrote:
> 14.02.2024 14:28, Si-Wei Liu wrote:
>> Fix an issue where cancellation of ongoing migration ends up
>> with no network connectivity.
>>
>> When canceling migration, SVQ will be switched back to the
>> passthrough mode, but the right call fd is not programed to
>> the device and the svq's own call fd is still used. At the
>> point of this transitioning period, the shadow_vqs_enabled
>> hadn't been set back to false yet, causing the installation
>> of call fd inadvertently bypassed.
>>
>> Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding 
>> capabilities")
>> Cc: Eugenio Pérez <eperezma@redhat.com>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   hw/virtio/vhost-vdpa.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> Is this a -stable material?
Probably yes, the pre-requisites of this patch are PATCH #10 and #11 
from this series (where SVQ_TSTATE_DISABLING gets defined and set).

>
> If yes, is it also applicable for stable-7.2 (mentioned commit is in 
> 7.2.0),
> which lacks v7.2.0-2327-gb276524386 "vdpa: Remember last call fd set",
> or should this one also be picked up?
Eugenio can judge, but seems to me the relevant code path cannot be 
effectively called as the dynamic SVQ feature (switching over to SVQ 
dynamically when migration is started) is not supported from 7.2. Maybe 
not worth it to cherry-pick this one to 7.2. Cherry-pick to stable-8.0 
and above should be applicable though (it needs some tweaks on patch #10 
to move svq_switching from @struct VhostVDPAShared to @struct vhost_vdpa).

Regards,
-Siwei

>
> Thanks,
>
> /mjt
>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 004110f..dfeca8b 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -1468,7 +1468,15 @@ static int vhost_vdpa_set_vring_call(struct 
>> vhost_dev *dev,
>>         /* Remember last call fd because we can switch to SVQ 
>> anytime. */
>>       vhost_svq_set_svq_call_fd(svq, file->fd);
>> -    if (v->shadow_vqs_enabled) {
>> +    /*
>> +     * When SVQ is transitioning to off, shadow_vqs_enabled has
>> +     * not been set back to false yet, but the underlying call fd
>> +     * will have to switch back to the guest notifier to signal the
>> +     * passthrough virtqueues. In other situations, SVQ's own call
>> +     * fd shall be used to signal the device model.
>> +     */
>> +    if (v->shadow_vqs_enabled &&
>> +        v->shared->svq_switching != SVQ_TSTATE_DISABLING) {
>>           return 0;
>>       }
>



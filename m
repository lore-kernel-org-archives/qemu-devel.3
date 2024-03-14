Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FBEC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 18:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpvg-0003P3-GN; Thu, 14 Mar 2024 14:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkpvd-0003Js-LQ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 14:35:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkpva-0004Ur-VS
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 14:35:45 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42ECLuxu030013; Thu, 14 Mar 2024 18:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PBAJ+VwEhV2wwdzhed+qukBWdzc3hOR9n4CAFeJCh9w=;
 b=BK8JqX3vonqOb93gSZGVzWUEhDCT/fG/DvbhA1sExpXDdze2RYCBLgn/jO7tMzL3Jkqw
 g83rQSa+jI60FxLGiX5hH8vzUFjeVDjwMTQ321mZtneWa5w05KE9oy6mQb0tbJm327+Y
 SRoxb54/KS2tnSziZJ63ZsoIWK/KSYJCM0+5ZGDdQTu17xOVXuJkSjmCSYtkZBg3X/ax
 0z0EUQqkw0zpqN/hVnUPPaosTPoX5VMAedzFstREcLdNxOtVNTtY9Hafz7L8f2hjhG6U
 j3DhYNv03Sn5R/FKCE4fBO3Fn6608o2jpGY02aEbWrv+CspwD7wbk6aBYp+AAfqOdWJr vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ab10eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 18:35:40 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42EHhhgZ038057; Thu, 14 Mar 2024 18:35:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7atuyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 18:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUbo3ektSNPlLaHsem5rEN9x3lrWHjkJxQxZQIe19Blp4NabK77VVXveRiB4gS+OuyNzITOO1QLRb805U52i+dwiXUObvOnMW0mBeLDuXWQSjUP1FQ5seJiYDplPkwhUf6pHyKXMFueJvtmTqEyYys71qxiqe7WlYRDUcgXojQzAAOYkOlgc7ZCoV991GHchz+++jDk+W9+CwAUrBuATN5dfqElLEsoB4VqJCmnNQ0BuWutdOgQrVJfmY/XB4TaYc4RIXadZ2g2HovIh69draRwQX2RPvrla46mGFFwTI2XEZLgfitW12E2fFhD9MWEkX7Et4jL1bqalhrsM9qeViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBAJ+VwEhV2wwdzhed+qukBWdzc3hOR9n4CAFeJCh9w=;
 b=meo4RdGK3pIoZE7cxTLCgfyQs8qZUTA1DWwLnqj3tdOc9RZ8z2D7Job5Ex+GZBQtFwNLLKtnYMXQFGRqgBVF0KUp4X0b4j1qIM3yOLaMA8FhMxXv7TfWL1k61ifWTPEagz64rakXq6pKEAE1EmG8xMVMETBy8Z6gOLbQt+mWefZ3GZBGMEQnSpfvL9n5fJut8s1ZhB2Txn4TCPaG2rItkkNhUS+rfdmgALBfQFwaBbbBFsF7PlIToIIBE5ClBYX4Ofqh+xSZsIp6LT7RAisJzFmFL+irmW5BTb47iEB513vPVwpYqJIJlVBKwDo1AneBX95eDODM/6oX5IFJZBwanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBAJ+VwEhV2wwdzhed+qukBWdzc3hOR9n4CAFeJCh9w=;
 b=Y9wRmDJPZFyPAIkvB22VMlikTrBbjtVqUVORgaJvcwOFc8PN9/T6cPKNBVKSglCvLk6Di9IYeku6MtxtU/bN3fGZfu3jLu100ZfNJstLr4+ziL2xQE4N0vHSJW9+kkQsCsmYMzU4LyDykwuzf6slwCNyOLg1OfquVnPpxN1HAh4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 18:35:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:35:37 +0000
Message-ID: <0bfd835f-76ad-44e0-a468-bef217501b1b@oracle.com>
Date: Thu, 14 Mar 2024 11:35:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] vhost: dirty log should be per backend type
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 joao.m.martins@oracle.com
References: <1710401215-25490-1-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWfq7tSo-o4oqh=VMD26MKneGtOGsC6CMtaYe4C4Tc2CoA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfq7tSo-o4oqh=VMD26MKneGtOGsC6CMtaYe4C4Tc2CoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0934e4a7-419e-4a45-7e31-08dc44558b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7H41JzBHZPCvhL8GmyMQX0+Ln+DhJI1DSnQ7reiU1gFAztG3qoqTIwABO9WnwNjj8FYMWB3rv1K2+kfriWN1reVAVGLnVCaboSQLZ5J/OOTJdRSqdSnwzxUnJyuyOHx0Bo+SssbccuHjTcEUDJhXOyu9sQGhEIr7W2KxUh2Ys5fETmI2Jo8E9JVV9Rf5XNEWhmYpYa1pom+k2eBQKumh9JJJvNuYoo8jlG5K8JHFeYVNmh/TDmWpvM91mm2uxhi/DXA3SbZeKxFY24hpESCF1VhpBXrK3W0Q7r/+dZTIABip2+Lm2hj8o0JALCBQBJzKYI0HkAN6evg9A+eSsAzmfiwql8AZOIvJ3YmC6zKWuYaS9WtDD81sYmMZxdoZ+i4Qx3XEWR2ZdFiMPDuMY8fyEcR1OmuHHkLDAHN+0W6USrFBA/n1laMmzWeP5w734e+nHI106I31jWaq/wUZqv+TVyyofnRey5BSZ1Motf3t2exlFZ0lp/qvp8RdTE3/ok/UeWbS/hp4z+XK1iMv5EjCt9SJQfcl5AqmPY96EJ4oVXXdaqKYyPJ6V5+pC1i2TCGFWumQBkT0EtvK9yJWKziJuAwj5uk6lU0jtEqBQLA7w4y7lZrdpyG4r8zgAXEG5mNZvvLPmk7FWCCc009czjOi5wQB1G7g6WV7ewbp7vvHtUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWJ1S1RzdWFzVWJ3UWFjdmpRWjV6NkVtTTRmMUllcGNEdmVaQkRYQ1FLa3d4?=
 =?utf-8?B?NThVdFhPdVJWNnZBS2lKeGlPNnM0STJmOGR4NFQrK0toK3ZRdGJGM1dqR3hU?=
 =?utf-8?B?RHlld2p3dDNqUUJxT2EzMjVtUWdacHNzUFRWcE1sdTFIbUxmM1dXNEN0UEJE?=
 =?utf-8?B?eW1CelBhUTZhdTBJTXpRMzVjeUNaOHp6c0hMYW5Qb3N4YzhkOHUwNFVRM0sr?=
 =?utf-8?B?VUxQaUV1NGRHU2ErNUNCS0JzK05XU3NPQjJIZ0YrU3MxT09LUGFDMnNvayt0?=
 =?utf-8?B?ZFJ5N2gwK1NuKzgvdXBEaE16aWtlN3N1a2NoMUV3NklSRnhJS2FGZXdvQ3VN?=
 =?utf-8?B?YTRWM0hjYlNaR0RPdFgvdFdEZzZ2YlVJS0Q0bkxUT0RoU3M2Si9vdDZ4T0pM?=
 =?utf-8?B?T0lLaWZPRVpwcnJ4SmNVZHRXa0xDbTFRTEN2UjFBR3kxS0hEMVVPZlYxRlpR?=
 =?utf-8?B?dnhzTWVXRWU1Q2NQaTJHSG16djhNK3FHZzRoNGZDQkdRbC9XcVE0N01HRmtG?=
 =?utf-8?B?SmZkSFBXQnBsM0p1ZWY1OE9TdG85S1NLTDkxMzVSTXZuQXFJZHUzZ0N1QkJn?=
 =?utf-8?B?M0w1dE1lUk4vMGpkZC85MlllU2xzNS9QRC9vMUJMMnVoak9ybjNJeHJMSU1w?=
 =?utf-8?B?ZWxBRGgzaDVxTVZ1WmdxRGpBN2NvWFkvbCs4SDZDT2RralZyRWJCT0R4VzNO?=
 =?utf-8?B?YUcwdDVHVGlNS3hoMWZLbGh3RTFLdUNMdlEzSHc5a3VDblRDc3JiMEhhVjZG?=
 =?utf-8?B?MklvK0lIdVRNdzFkV3VUdlprQkJON1hOdnV6U0N2bG4rMi9hRUVxNkNnUG5x?=
 =?utf-8?B?VEtPN1BFUDdGb3dycTZGY05WbkRhbmEvSkQyNXBBNzdVYWxjR0N2dEFsdkVm?=
 =?utf-8?B?TzlidHRKM0VTa2N3Snk4aGRTdVpNOXNLdTBTcVF4WXFPa2J2QnlndlJPSkRP?=
 =?utf-8?B?L1h0dk5wU3p1Z0swOS9jaXN0WWVMN3NHUERiZlFnbDExTnlrSTU2eTRWZXJu?=
 =?utf-8?B?R1BhbjEyRXAxZjJ3SEVyejE5YlBJUkFxSVp6ampXY3d5M2Z2WXFlVnYwN3F1?=
 =?utf-8?B?VG9lZFNMcEFRU21iaWpzVFpyK01iVmpuV2g5MENBTi9wM2RaaW12OVYwU0My?=
 =?utf-8?B?cER1ZENSZzJLUUJ5eVMvU2NXb0FaRVhtSksxZ1hsayt4MFRORTlUU3FYeFB4?=
 =?utf-8?B?TWtXUXUxNTdad3ZVT1JTb0tyeDlkSGx6amEzQURudFJYSjhwUi9pN0xtbEdZ?=
 =?utf-8?B?bE93YjU3dGM0TExyWFJCeEpmZVV4UVUzMjVONDR5QmszWEZ3cGw5dllTbktO?=
 =?utf-8?B?L05OaU1hRHZDM1g1MTYrMm1wQnI2SUVhQ3pMcE94Y2w2NFNIWG9aY3pEbHhF?=
 =?utf-8?B?NHFnYUdOcWY3aGtuYTNUcGhJR1R6M3grZ2NaY0tQbTRpSG0wWjd4M2JZbmNq?=
 =?utf-8?B?SHRsUWJWOURKWkphNjNuWDI1dkF1MFlEY0NkeE9HRHNlKzczZTQxd0Vwam1r?=
 =?utf-8?B?RGM5YmZ2dFFxbDNUZ2x5UTNEdlZuc1QzY3BWRzl0RmJmYnF3bkhvNXMzRGZD?=
 =?utf-8?B?QzdJMWZWL2hvN1oyMmtnbU16Y2cwR3pZRHFmZmJGUCsrc1R2NHRSVGRGTWVo?=
 =?utf-8?B?YjlWVnE1WXY4WVBhVlBMZngvNjNFUDZwcHEwUGFFcnE5WDZkVjFmUTBPM2xJ?=
 =?utf-8?B?MkNwck5vdW1CNnpiejNjUVVJeVVoa29hWldEZnp4ZVV5RW1XdmYrSWJwNmVL?=
 =?utf-8?B?QjdyUllhUHo4Q25RSDlWeXhKdnpFM0dtenNiWFFpMS8vMlkrZ3JqeWZLMjd5?=
 =?utf-8?B?b2RwSkc5cm5zL3llbVlPT2N6QklGc2NHaGhrZjJxS2dmckRyUzRhbnNMWUZy?=
 =?utf-8?B?TzNVMVN4OStVMlYrZDhKM2pMME9SRFNoUDlHOGdLMUdrVVhET0hEQVlvdE55?=
 =?utf-8?B?bFdHaDdsM255T1M2R0RIREU5Z3ZwbU9NWGNNdTZoS3BnVlRjcUdCcE4xTzA0?=
 =?utf-8?B?bjRQNk9vZGhTdDVaeFpzOEhwVjNnb2c2clBoZ3JaYmswSEhoQlRHbUhxUkpr?=
 =?utf-8?B?ZFB2VjZqQUR6TnNDU1hKZmtVYTBNU2ZrVklNakZOQTNhcTNwaVhOWWhVS3cr?=
 =?utf-8?Q?X+wgpB2DnLMOtNnAs+WHu8eBw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WPBafBYH0AKODu0Ozbs4ZbSFXu4d8RiQhUdh3S8+SExVw6uPlOWx3K0TW1FBZVlgcEGwjTHCUhVft1E+wm2vhtwfcO1Y49rqUGxUSqboYIBKbbzCHUAgfypslJJ3O2v3eaBxPQTly9/5MPHzlvwVHakdSIqaVI0ZZlTlMa9D3EiBTFL1jRqxWAAWCe0IB6xw4ErDZ2Jna7Sptx2EZtS9QQJpUWgzqsvpx4Ortac7EBs1kle681puOSGSKBBQlWiegk/LlIpvH/1GBxeh6okcDU9neOGwtqHxlpeT9/pnYNowEX9BWJ7w2p500jBhUdTlD5VTeB1CV6rHpcSD+Dymiv3A9OPIXNSyIo6Z4KMI387EDmKWIsuojjIykL5YmcCcxp7qZ93DfBJ7xIZSELImDHB8xFfJLNT3J9QAYE1Mjn/t/m2uBJ+wIEUBe3ZtY/J5vPOcMPj/xIkNXYKrdsWHPdbW1lev6sjigNQqvfrfdMWVRtQfVPRUuMgQJq812biTBIO8qXLWXOkKP06XSKlya2WyEA7teGqDEkSMJb/7Jgdnw5ZVylshRajAYO1SeYZp4gKS7BdKFTZ2k+JakubpeZgG8ktmrwAB8zPvmGAt2Ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0934e4a7-419e-4a45-7e31-08dc44558b34
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:35:37.9286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jHeEhTYyWbMqpTfJWx3Yeb+pmDHP98kRDMyE3LCQl6UEp9EQwWUR5tar8cRuA40/5znMwcZt3EGFrDQELORDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140142
X-Proofpoint-ORIG-GUID: lBf11YoSsz7afieg5oqaTLMESA5zKlHM
X-Proofpoint-GUID: lBf11YoSsz7afieg5oqaTLMESA5zKlHM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/14/2024 8:25 AM, Eugenio Perez Martin wrote:
> On Thu, Mar 14, 2024 at 9:38 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> There could be a mix of both vhost-user and vhost-kernel clients
>> in the same QEMU process, where separate vhost loggers for the
>> specific vhost type have to be used. Make the vhost logger per
>> backend type, and have them properly reference counted.
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>> v2->v3:
>>    - remove non-effective assertion that never be reached
>>    - do not return NULL from vhost_log_get()
>>    - add neccessary assertions to vhost_log_get()
>>
>> ---
>>   hw/virtio/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 38 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 2c9ac79..efe2f74 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -43,8 +43,8 @@
>>       do { } while (0)
>>   #endif
>>
>> -static struct vhost_log *vhost_log;
>> -static struct vhost_log *vhost_log_shm;
>> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>
>>   /* Memslots used by backends that support private memslots (without an fd). */
>>   static unsigned int used_memslots;
>> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
>>           r = -1;
>>       }
>>
>> +    if (r == 0) {
>> +        assert(dev->vhost_ops->backend_type == backend_type);
>> +    }
>> +
>>       return r;
>>   }
>>
>> @@ -319,16 +323,22 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
>>       return log;
>>   }
>>
>> -static struct vhost_log *vhost_log_get(uint64_t size, bool share)
>> +static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
>> +                                       uint64_t size, bool share)
>>   {
>> -    struct vhost_log *log = share ? vhost_log_shm : vhost_log;
>> +    struct vhost_log *log;
>> +
>> +    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
>> +    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
>> +
>> +    log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];
>>
>>       if (!log || log->size != size) {
>>           log = vhost_log_alloc(size, share);
>>           if (share) {
>> -            vhost_log_shm = log;
>> +            vhost_log_shm[backend_type] = log;
>>           } else {
>> -            vhost_log = log;
>> +            vhost_log[backend_type] = log;
>>           }
>>       } else {
>>           ++log->refcnt;
>> @@ -340,11 +350,20 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
>>   static void vhost_log_put(struct vhost_dev *dev, bool sync)
>>   {
>>       struct vhost_log *log = dev->log;
>> +    VhostBackendType backend_type;
>>
>>       if (!log) {
>>           return;
>>       }
>>
>> +    assert(dev->vhost_ops);
>> +    backend_type = dev->vhost_ops->backend_type;
>> +
>> +    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
>> +        backend_type >= VHOST_BACKEND_TYPE_MAX) {
>> +        return;
>> +    }
>> +
>>       --log->refcnt;
>>       if (log->refcnt == 0) {
>>           /* Sync only the range covered by the old log */
>> @@ -352,13 +371,13 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
>>               vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
>>           }
>>
>> -        if (vhost_log == log) {
>> +        if (vhost_log[backend_type] == log) {
>>               g_free(log->log);
>> -            vhost_log = NULL;
>> -        } else if (vhost_log_shm == log) {
>> +            vhost_log[backend_type] = NULL;
>> +        } else if (vhost_log_shm[backend_type] == log) {
>>               qemu_memfd_free(log->log, log->size * sizeof(*(log->log)),
>>                               log->fd);
>> -            vhost_log_shm = NULL;
>> +            vhost_log_shm[backend_type] = NULL;
>>           }
>>
>>           g_free(log);
>> @@ -376,7 +395,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>>
>>   static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
>>   {
>> -    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
>> +    struct vhost_log *log = vhost_log_get(dev->vhost_ops->backend_type,
>> +                                          size, vhost_dev_log_is_shared(dev));
>>       uint64_t log_base = (uintptr_t)log->log;
>>       int r;
>>
>> @@ -2037,8 +2057,14 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>           uint64_t log_base;
>>
>>           hdev->log_size = vhost_get_log_size(hdev);
>> -        hdev->log = vhost_log_get(hdev->log_size,
>> +        hdev->log = vhost_log_get(hdev->vhost_ops->backend_type,
>> +                                  hdev->log_size,
>>                                     vhost_dev_log_is_shared(hdev));
>> +        if (!hdev->log) {
> I thought vhost_log_get couldn't return NULL :).
Sure, missed that. Will post a revised v4.

-Siwei
>
> Other than that,
>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
>
>> +            VHOST_OPS_DEBUG(r, "vhost_log_get failed");
>> +            goto fail_vq;
>> +        }
>> +
>>           log_base = (uintptr_t)hdev->log->log;
>>           r = hdev->vhost_ops->vhost_set_log_base(hdev,
>>                                                   hdev->log_size ? log_base : 0,
>> --
>> 1.8.3.1
>>



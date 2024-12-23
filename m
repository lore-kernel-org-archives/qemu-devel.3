Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C846E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 18:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPnPs-00065j-QF; Mon, 23 Dec 2024 13:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPnPk-00064p-T2
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 13:44:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPnPi-0004ms-0u
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 13:44:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNIBsM6026156;
 Mon, 23 Dec 2024 18:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=XgSnEQqyqClU+xNO1u3xZJ12UcIvplWNvba2GWYd2bw=; b=
 YzGmROpLAqSobamf64BrDRKeh/oru+VFT/RHyzvV53j42U19713ySpcENo3uAhcU
 vaUanIVeduFYzpq8mmaj9IJmffEJfJh7ZfJbcQwJ2Jy6p7Iv0uFuNquw8GpWiatq
 yztcorxhTf36UX2suDSoPIUPlNwfTNE4uKScwZN6wYAg2+OjAHZBBkJF89/PFWCD
 nOcs4lH1TJnxAWMDO85xkBbu+/MoO/H6anNvt/h5EPlaoEXL8HWv5SCDZJnPAujp
 xuuveKuAiL6sP6ClDj4I7oppxZYpfX4iwI6AeG7VFd6WgWWtq0/3QushQ7LTOCo8
 ym3yrj+4YR5vDqGpNAxnpQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq9yb2ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 18:44:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BNIf7cY029431; Mon, 23 Dec 2024 18:44:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm4dftew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 18:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpyAeo+VdySFmFFHJPM6FLQ3a2BW6GJm9l+zOQNo5eRuftxWqr8FYRhEHKmdDJBDH9vTkmy09K7gDjRWTHbf2hQBbCLcOd6acPqpWtIjZfgrK7l37vuJvm/IARSW4NHHLESlSepJGo92l/PDCJ4x/GxJPkAQiVZVJsAlfNyNXHeLdd/aV/MddShr05G4Wer6hUrrNWfvEisEEVwoMIOdZ/Ioy0fEq8WH5D/0UnUdnvxSodrUsI+0jwL2lIhCu7EvX8sBJMc26KSxex76wrkiHVE9dVMCYfZJL30yoGS2nfpCne3Ast9+tqOytHsI1TSBzmk0QXvtouDmK6ny5YAlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgSnEQqyqClU+xNO1u3xZJ12UcIvplWNvba2GWYd2bw=;
 b=SurqzUA/3GnMSsVtZKVUhN6mn1ZLEKOE1Qt9bqDZnJSa44tj7jTVhACX6r6ok8rlbNUm0C7ss7ldlfzLEss39eG+8DeWVc/qrvIKhVaCTcHBZlSNroQjdwtCXR6lzlIk+bOK+ZV+YteCQFNoncrEBzD3pMr7CfUgtOE7aL2XlSsJ4AYQYiCUu8B9RsM9GO+mZIXxN8hPdnVcWbyEI0MEtMq+n4KF8EjBDRRagEHCL8V7SgozxQRBKFiV3h+Ax0eRnGwKTVYaYJZf2dEkg9XIGYEf7yuhjKrUuovuhVHlPmMyIkwatu0eBKxMU/Wtsx3qac/OGxwxC71w1P9VPoQSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgSnEQqyqClU+xNO1u3xZJ12UcIvplWNvba2GWYd2bw=;
 b=HzNycOEmZx18+sSpO8QlJLwLEKd+FM3y/qq6dTSlHbfMaE3FCz7J4QeVOE+QGXrOp7JlxKZB0CHmtHWhF+Hak9vuPZzwKKYsH6d6kpIc8eiTmxd4aKNgFAOLw4JkGbBnsVKlRh0b+9kt4um0bPLuwTsqOQhDiB11cvkRxDLQMQ0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 18:44:06 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 18:44:06 +0000
Message-ID: <f7a9be5f-2925-450b-a97e-cbe4f3adfef6@oracle.com>
Date: Mon, 23 Dec 2024 18:43:57 +0000
Subject: Re: [PATCH v2 0/7] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
 <cc96d3e7-4362-461f-8398-bea956b22d73@oracle.com>
 <71295cc6-794d-4fed-a1c8-6c1a1ab98933@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <71295cc6-794d-4fed-a1c8-6c1a1ab98933@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0228.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: ad28ee7a-924d-4d96-11fa-08dd2381c741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGkyYlVkZ0lJNUh6N3dzRjE4SmpCQWxyRGhiMVgvZkx5bmFob1RKNlVHcDAw?=
 =?utf-8?B?ZkVqV2pSdUdOcTRlZlJzdTBWdFdtTmFXaTNRbGtKNjJQRGo4alhXOGZ4MmdW?=
 =?utf-8?B?WFNUN3ExdDk5MUJGVkw0TExIcE84a2FxajBHVzcrdVQ4alU0SFlpeDJFTm5w?=
 =?utf-8?B?WCs4amhGOC9HMXdSUEowOE1aOG1lNjAwUXNhOW1ZcHZ0bWNsWWx3ODVQZXpX?=
 =?utf-8?B?QnUxbWRYMGpIam5hNnVGZ0dYcEN3MlRZckMxcS9EbnAzSzdmamFVV3N6bFZD?=
 =?utf-8?B?VnJGbllnZHlTM0dURUpWUEpiUThrbFU5bVRYUmZrb2tQeEYxcmRzNzdjMWVo?=
 =?utf-8?B?Q29iNWtzV3FYZ3JJTUZyK3VXc0FLc2ZwVFNUa0FYdTd2c1pQS1RtMTRRdld3?=
 =?utf-8?B?YzdhUWg4MFlFNnp6bUxLc0x1ZTZyK0ZYMDIxbU03aTlId2FQTDJHV2pVWHJ1?=
 =?utf-8?B?WTdCNXppTUpIQUhRN2dPQURleWt3aHYrcVUwZ21MWHArall3RGszekNkT1Rq?=
 =?utf-8?B?eHAzNU5hVUsrMHJhZlpabis1ZWdmOUJhdFZpRGtUNGhGMHJiUmtZVmFCMGFF?=
 =?utf-8?B?bFFJWnYwcjZWQU1JalpOWmxFM3cydi9YU0Q3T1VxclJZUlJXYWlZTldKNjYw?=
 =?utf-8?B?N1VRZVhkcEVBMnVYbXRwdEFzaFdtOE5sdDRKazZlSElySlhDZnV3V3NrS01q?=
 =?utf-8?B?cGZVY1o1eTlTYkNMYzg1akE0ZitORGJDUzlSWTRSdFY4SmdzTlB2Q2ltNHp1?=
 =?utf-8?B?UDJBbStSUnJ5Vi9CWWdDSis5cWt0cFovbEFUMk1Xb1A1Q1NmNmsrZlVsaW93?=
 =?utf-8?B?VHZhWDF1c1REK0xDZlNRZWdERXk3elAzcG5TMnhvdkNFQjZ0dTRlK1FDVXA4?=
 =?utf-8?B?akJ4NTZzQzRGK2NsN3k5a3JyOGw5cnRHb3lSYnJpbWNRVEI0MDJGbDRTWkRr?=
 =?utf-8?B?a3FSMlBDUmZzSERuVFduVGVEZzVPbWczdkxGTUcrS3RBMkdEazZ3WmhpQm9w?=
 =?utf-8?B?MEZMaENIVm42MHEvdGFMajk2TnFjTkw4SllOcmh1MEpieThkUjkyQ2x4WDBW?=
 =?utf-8?B?a3pXUm02SFozY084VE94UHFva3lDWGF0TW5lKzF4RFlUYXhGcE1SYWYxNk1p?=
 =?utf-8?B?QWV5dU0yQjVkOHMzTXA4MmVWbmQ2d0FiSDY1VWROK2gvU2lWMWl3azZGYkxu?=
 =?utf-8?B?RlFlUGI5UUhtN2JTNXE1eUx0c24yeEUxRFAycDN0Ujl1QzZYcTJzcDA5VW5k?=
 =?utf-8?B?T3R3ZC8yZmtGa1htZ0dacnhadFFKekQzNGxJSWhaL1NxRStOZlhNM0tGekgz?=
 =?utf-8?B?RncwVHlwTE9adGlydW9veDZvNFRHWVp3WGZqRFdyN0FRYlM0MWkzdTN2aDho?=
 =?utf-8?B?eGZxNUVtNjVaUGM0cnpZamdmUllzM1VCaGVuR3BhZjFqZi9oenhPbnJGbGlO?=
 =?utf-8?B?MmdtT1RkMmhTKzU0NE04TEY1bUduUW5rREpDZVNZZWRYTlJ2OVBCZkRZY0Zr?=
 =?utf-8?B?SGNndDZhQnRLc2RJYXEzaTRNTStUYXV1Vis1YmZ5aXMyRTgxYlExc2U3WlJH?=
 =?utf-8?B?eFZET2RDTFFYQ1dIUkZVeGw2R3QrTWZ2d3REM0NVVHlBWFlESW5XWmZXaG1R?=
 =?utf-8?B?ZGtsbEQ4Y0Rwem1STVphUTRnT2pvM0crdVY0cjJscnM1WHlBZUVld3NqKytl?=
 =?utf-8?B?RVRjZWpUNXZkL1E3VytJdUV2Q2R5M2ZRZUJDNzUrVWNQNDZ3Q2RvdzVCRFBy?=
 =?utf-8?B?RHkvWFhzSm5yZWtaNS9HU1pUVWd6MFVYT3BzSU15Nm1ZbWFZcmtGSW1sSXRs?=
 =?utf-8?B?T2hWR0ErdGg1ZkJSM1JvVTJjWjBtVzRkdE9uanRVaDB2ajRCRzFKd3VzZjhF?=
 =?utf-8?Q?8qGq2y2edyoZQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZuRlp2MlhPRExBaGhaTkZFZUJ4KzJZaVlpakJrem5QZnlYTGlkNzdheFdm?=
 =?utf-8?B?M2JaRHBEMEhNb0J1eUEvTEZ5dUJWa0NVeWEzZm54VzF2VFkrU2E1aHZjdVRy?=
 =?utf-8?B?cjRMTU5XTmNLT0d5YitTVWRvOWdoZkd6bUx0NWpWeXRkaWpDVHFiRXRQQS9R?=
 =?utf-8?B?TnUvNEpnUjlXczlzY0pmU0JMUm8rMVhKRlMrY3lNdERPak1aanhjQzFmVGM4?=
 =?utf-8?B?ank1TEJmRXNBWnNRdFJtc1k1N3BNWXdtQkJrenV2bVVJK1AzQnB0TnYvQ3Y5?=
 =?utf-8?B?RDFiWVNVaWVZV29TaEdoTUd0a1VLSDVZOTlmRDdhRjAybjgrZ2wrMEtJaE5v?=
 =?utf-8?B?RnlRUkhBYmF1ZnQxWVVvWm9DdVNMQzJ3cjEzakVFS3hGT3NxZGtRa0hyQjky?=
 =?utf-8?B?akFBdnFjNnJXUHpCSVY5eEtacnBrMTJUdkc0clVodm96emlpZUwxdW5WZkdn?=
 =?utf-8?B?R3EvL2Q2bGZTbmVNbytBdklKQm9YNDYyQ1I2U3JzWjhzbEhrVlZLT0JpOXZV?=
 =?utf-8?B?dFZlYXN3RXpJVVduSE5GNWh6aXVHakQzcWhwQUlOSlJrZTNvdVBiNTZuU1ZF?=
 =?utf-8?B?bFIvRmR1YWVQbUJiVW0ra3ZTNmJhYWRSQlBxSTVjTFpINGZoVXZKZlVBaGpF?=
 =?utf-8?B?azhtN1BXYWdVR0dzNmYwd0EzVE16dW9KSHJPWm5sd3o2UUpUeXhwTmxNQXdW?=
 =?utf-8?B?eE5WTzhKdFZIQUxlSmxEUHNpell6WWc4Qk5jaDFnd0ZIODhUVHBYSUo4SkR3?=
 =?utf-8?B?b0hCMzAxaFB5Z1R3bk40QmYxcDdaRngzajBCNy92MERtSjlhTU11ZDl2R1lK?=
 =?utf-8?B?cVBwQ3FIN2syU0Fsc1VhdTZmd1lPUU9qTlNSYkEwUjRWcW5Ba3RKSkxKYW9l?=
 =?utf-8?B?UloyTjZVNm1UTVRHZUN1MjVDcWtBblVIMFpPQi9hdmU3QnB1UC9TeEEyNGpU?=
 =?utf-8?B?NGpLSXNXeXJZYytDbUVJT2JBZkRjM3dCWmsra3plNWd4eFZIdUVDRi9KUFBn?=
 =?utf-8?B?V2hmMzNYTk5oWWRDTWRUSGhvMnFsMVRwZTVnUEltYWJhMUxTakVJVkR4YkJ3?=
 =?utf-8?B?ZVZVbFZIeU1rZDRQK3ByME0wbGRTMmQvTzVXbUJEV0xKYmVQVmQySkFOa2NQ?=
 =?utf-8?B?ZEJyTDVlOVk2STgxNlV3YUNmMkZWWlU0NmJCQ1ZSdFVsRjFBTXVsZWZ0VEx4?=
 =?utf-8?B?bHRrdVRwRDR1TVcza3FlL1FSd3hFOUtHa2pkV0hhMFR3cHVBU0xNMkJFRm9a?=
 =?utf-8?B?d2RLaHEwNlRLSXRZRHdZOW00UjlFSUthRUhYcm5yWlBOanRTWm1pWGpYbmJq?=
 =?utf-8?B?MHNrOXFwQ3FMYnI1NjZUbi9hOGlqN2RGQ010aHJhNWhFaVlBR211RElzWTFN?=
 =?utf-8?B?RTY3WmlvbzV0ZVYzQXBpUTlEWityTUREWVFqOVBWcExiQkFnU3pwb1FzcmhT?=
 =?utf-8?B?Z3VvWEtEU1RNbFJTbllqbmxoNGR1UlpsQmE3Y01EbDAvSytHQ1NHckFjM0xp?=
 =?utf-8?B?NFhqeTdYakN4aUxZK01JMUk1cGhpUWpXUDU0U3pVSUVGRWRYcTYxNmNHZXRN?=
 =?utf-8?B?TDRwSCtlZXc1VmpkSTNGSSsraUJwMGtSZ3I2WGNBVGtXUWNBZGtGb1h5aXNz?=
 =?utf-8?B?SS9pTUFLT1RlU0JpUFVYM3dpc3lRUVdISEFjWHJRY3F5cmhUKzdaTEtDRmxT?=
 =?utf-8?B?TWgydjJITmRrU3ZtUlQvb2planNLeFNaSzVKR1AyN2JzTGF4NFdqTUdyTVdM?=
 =?utf-8?B?SnlwVTJIdWhWR3NqTVdjOXlpdmIvaXBLakZySFBOTklFeTNmMWh1RTRuQTdZ?=
 =?utf-8?B?VisvcHRhNTlJT0NsQlI0elp0VEZPc1NkZ2NBZi8rQWUyRnNsS2NQTFkyanht?=
 =?utf-8?B?UWtKM2JFMDdFRlNkenkyeStVV245R25RL1plZ1NLc291V0dZa3hUNW1uUHlE?=
 =?utf-8?B?TWZxY1lSUER2R0NBbU93SlFzeGlydkJ5YnA5OUp3M2kxUURXTmZjdWEzdE9t?=
 =?utf-8?B?WUlwR2FmSmp4SHVOempOMzkzeUhrOXZZRFhSM1NNbFBsdU5NcjYxbHdOZEpS?=
 =?utf-8?B?NzJQSlppZ3pjY2JZTDN4c2JjQTlsancrTTErcTVBMWUrMVl2Qm5FdGhXSk10?=
 =?utf-8?B?OEZzTDFFbWhqYjQ5T0RidFdDOEtyMkRORVlJV3AvVGdkem1rMjdPQ1l6UmdW?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hp1asapkr8N8oWuSePmpgdwzcU1UYypYUyx0LRKgxyMySIZAo3Nj1hjM+emWxtBFMsbJMJ9NIr//dugivpBwBzdHkJ9jvTPfHX+umQFsoJdOfFRicd5F3QOHTh1wbmV8RDMgFviB+xIYIIUmU56QqtFUeQrp19VME0XPNIr4tgIh3c6+gIe6c+1x4346Vn8Xap/Or7Y97qPdLupis+GdJ4F5KEN33dhvWyeXJAiqYtLM2RDuBHkH077SCVqXygHZkIjxes9H/RhIhw+kSURC7jXaeutlLRwMYuYnOWA/NrH/xAoU4Ae63PUhlge9wD9zPA2t00CvL5N5P3E4Uj6Ir2i03vRTa36O0nc4Mv2P6vXejgFnGPJeyhhrnNbFpBgXc/UbOAYe+pv3RlIfdqMcF8cUV3uQ4fYmTgVpcc3BYYKYzLQ/I3vPhjqacopEfuAjfe1iv10FGqWiDK5hE+dcPPHh8ugt3K6q2OIxS7N2QVSlpR+2U0mUTZbA3shBmD483PCnxHiQHCuETzqjmZsEHOwRR0sqBoAbOQh72xC/j871aG1kZ0hHUU9A8WQDn6GShUCYyDPG5qruytczhY9fPwzrMRO5FFTDZ9YDXhuc3Kc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28ee7a-924d-4d96-11fa-08dd2381c741
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 18:44:05.9540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFalCW3Sop4+RMVPg8qFeskfeFXLzmGqMC4X6K0nQHngwWRF813LR188Zp2WHT6rHmgQcNpLMx55FXPZlz8UzGGtUI+07DxmvS1VYQIQvBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_08,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230166
X-Proofpoint-GUID: UkgR-UB835R2BmLuzIOZnskd4n1IrRXw
X-Proofpoint-ORIG-GUID: UkgR-UB835R2BmLuzIOZnskd4n1IrRXw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23/12/2024 18:31, Cédric Le Goater wrote:
> On 12/23/24 18:55, Joao Martins wrote:
>> On 18/12/2024 13:40, Avihai Horon wrote:
>>> Hello,
>>>
>>> This follows up on Peter's series [1] to simplify migration status API
>>> to a single migration_is_running() function.
>>>
>>> Peter's series tried to drop migration_is_device() and
>>> migration_is_active(), however VFIO used them to check if dirty page
>>> tracking has been started in order to avoid errors in log sync, so they
>>> couldn't simply be dropped without some preliminary cleanups.
>>>
>>> This series handles these preliminary cleanups and eventually drops
>>> migration_is_device() and unexports migration_is_active().
>>>
>>> The series has been migration tested with the following:
>>> - VFIO device dirty tracking.
>>> - Legacy VFIO iommu dirty tracking.
>>> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>>>    currently blocked, so I used a patched QEMU to allow it).
>>>
>>> I also tested calc-dirty-rate as now VFIO dirty pages should be included
>>> in its report, and indeed they are.
>>>
>>> I didn't test it with iommu DPT as I don't have access to such HW.
>>> It would be great if someone with the proper HW could test it.
>>>
>> FWIW tested iommufd DPT (migration and calc-dirty-rate) on said compatible
>> hardware (Milan hardware). Things look to be working as expected.
> 
> Could we have a Tested-by tag then ?
> 

Yes:

	Tested-by: Joao Martins <joao.m.martins@oracle.com>

>> I deferred
>> vIOMMU IOMMUFD DPT testing to my own follow-up once I am back from vacation.
>>
>> Thanks for fixing calc-dirty-rate along the way your cleanup!
> 
> 
> Thanks,
> 
> C.
> 
> 



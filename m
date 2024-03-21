Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5018C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQBn-0003zS-Lo; Thu, 21 Mar 2024 17:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rnQBm-0003z5-1v
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:43:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rnQBj-0004PW-F6
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:43:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42LKYbJC032336; Thu, 21 Mar 2024 21:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U9f0kOzUjKxhhQ/iq1FOVzyfCxlpsyw/FdzN/MD1Qrg=;
 b=lXcG+5Hd+wnUO3dAFxFJmjmDnbMudX5qWPGsv3G/GxpcdH4xwx0g6XDFK7Zv65AEQ77d
 0M9jbVF0Eujz6l98txTFFKL38Ei9JU2NFiDmJudjcquTQRw0o0uqIj32ZLL0TkSJxxxS
 kyzUVobhcEEYc0GUe3NWUI38x88eGNVPd6xngveHOCQ/TYWz/slXGYDCDnnyJ2xxRyyd
 1n4rJlAk8XeigA9PzOVjpU5YIIAM+IOKx3wJc8Gi6dgNiR413PAlbOXF9furVjwSJ1gJ
 dK/vAT7xmEIF4wTWhEisDmjXLz5E6o3TWiTtbQG3a3y3CTltmEW3C3Br4pI8lLuHqymn 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww211bj4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 21:42:58 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42LJdqj8019642; Thu, 21 Mar 2024 21:42:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v9u7w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 21:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DebHlbkDLbwZAVDQF8bKNG3BetVrPnI2ILKwz219IOr4N8yST3pM96/3N0bIKzjn0hBlV0gK9ogXOdfDRD2H4G4hV91S/4uQCWfWefSA5OwKy8t9D0PSSRA3kHy4q2aufZO1o9px9c4sBCAnPtHcWBci6YdyfVUlXeXDCc4AKr3YEXD0VDGoBgTFDCNx+25CDLkPtShoInCBZBAdjm2ug46avEKnxN04PxPr0hWXBv6lIYBjAvfihtFSi+qie/SyU77t7vpYqtU66SCCsHNyA8d1Hd1ttyCpeGiz8QIPzcNY1otwM7I36tk+wFJ3fK3emjYODY0jv13HLWkI4QPyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9f0kOzUjKxhhQ/iq1FOVzyfCxlpsyw/FdzN/MD1Qrg=;
 b=mKYRU8KgSu8ee6XNtt/xVgGif78Mnd1LgW7a53NoKl+0pdoCpy4xDvMrANUwKn4irWB2EdONpQRVFvWXvlTBgMpI7QpnHQvFIDbuTztfSbeFwQJi3OLLRssfkmzwnV4NCEtrfVxV96lPnr5B3ZT0ulWxeVR8fpuOD1ejcOEMtADYFiD1RxwFFBkKygwCZf5lA9jz6dQu9HesQVBmCvOTyYfgNm5+XP9TeTNpv1DGObK6BzK4quQf4ax+GVDwjZoe8kXsBv6RYZmE7rLGBYPh2XBwGkIIKVnLFwZDWv4LCzUXAYKYlqd6XorwvzJESbdoowOViUL6lQsU1CWFLayloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9f0kOzUjKxhhQ/iq1FOVzyfCxlpsyw/FdzN/MD1Qrg=;
 b=yAkDhf8mfGY99H/UgWopOJOniQ0Tfd6h+2h+ueQO3r+5BqEVwN0+IMqXZVaBqt9rrFw4zpuRbx+DOCX1f6JBwCEflK3fyly2CT8nMjwfNGaCpiLYPJ/wCd8I/1NrG0Sb/Xlv2LLGFWXa90V/voVAUZOU9sOuSsMgLBfRBz67CBo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 21:42:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 21:42:54 +0000
Message-ID: <99ac7902-57ba-41b2-9f1b-368f4563fbc2@oracle.com>
Date: Thu, 21 Mar 2024 14:42:52 -0700
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
 <35fc446d-61e3-49a3-b79d-c44aa2e65fea@oracle.com>
 <CACGkMEsbsqpw4NLJkkoNh8xfbpKgz9Usm5YO_qjF3JyB2K0frw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsbsqpw4NLJkkoNh8xfbpKgz9Usm5YO_qjF3JyB2K0frw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f993c33-0fbb-409c-c8fd-08dc49efdd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BL1zdxVpL1UxUb6qKEAodUeoLv7hXbqqPUKsYe/ro83EdzFWQXXfqtZJ2gocEIF8xOCkBLLR1pEKNNoy5TDdIoZ58Glx73r9xofTNUUfQIiv/lUqAglRdoIecPvJhwErARQn6oo+cA0XPD5o5JRHfYvyxFIEQiIDxNHVGdoG/NtQhnyLyLTI4ODGQrUns3ycvU5M+BYZI/pkxbDRSl/WD5/Xnr8t34aOLxD6ZLln06j6ZAHsRhVGMiAaubIAFiqsrMCMr0l243zY+qmlFWW1RBv+W9pl/sTuzaJ770ZLwVv6U0eAVjjyJE37JESu+cO+0BvqnsRh6mEXXk1XizeLXyLfJF+kWg+EXBaqzZA62kHLNS6AlyInekOEHwm+EeVniRDbo+qra3DmmdC2jPtO+zpd8PKW6hmiAkN+ScEAoE1BUGGrnTD0IxOH4o5xOyrXhgIcxCy67e2dyD4cmvzvkNjE00Nspd0p99O7DoUrhvwNVp6wA3R87wzvXXXkn9wgLLQcuPS/VjjQ3wp4ycof12mp/ihTXUKogwHKN/OJHsfmc2C34Fn792Jb1rVwv+DMf61N/HT+2cF3SXOWEV4evRtU27H03w1/ELITFv4+pFncnkAvRXwzzh1qFf3oFHzXuV860FPtZreCy/1c+gJu7pk4uCCO4ZN7L1bUsilwfCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2Z4cWMxMDJ0T1FZejA3a1JWVStMclI5ODRmem83YTQ4S01wYmZEYkd0UkFY?=
 =?utf-8?B?ajFzaTdjek5HRHJVb1pOSTlDSFVyM3IwREM3WDUrL2lwdG1GTFNiZ1hHdG14?=
 =?utf-8?B?ekRqN1RXZzhSdjE0YmY1WWdnamF3UjV4WlJ6V2w4RzFCSDRPV0tZdk83Ny9i?=
 =?utf-8?B?RS9hZVRKcTRpQU0rNHFTa1JBaTYzMlBBRXI5NU4vN0hEOUlZWXdrdzNOb0Q0?=
 =?utf-8?B?eFVZVVVncVpKQVBBcmZIOGJHZlJWM0FDY2RCZ0RuczViTE5zaUpHcGVmTXRz?=
 =?utf-8?B?YUxBQ2R6UlpBei9XdlRJQlo2ZUR5Wk1mRDNQS1ZnMUYrMkRhMVg1Zkk1RGRK?=
 =?utf-8?B?NU40UXhxVW0zS3piWVJ4M1hGSEdXYmlWM1U5S3NlcFlkMnQvaHVycU93bWFX?=
 =?utf-8?B?MlZBanBPK1p5U2FIUlZCamdXYTg5UnlmenQ3Y3prNHVxUi9FSkR1cDlrRFJ1?=
 =?utf-8?B?ZmtnOHFjV2tibWllLzRxVDR1cWlhVVlDaC8yWVlzNkhMWWtqQmp5MHNyQ0ZT?=
 =?utf-8?B?SjhOd1BsT3QvZGtYUHZiUDI3dlV6aWEwc3FudEo2b2oxYmZMcFJ2Q2hpNzdT?=
 =?utf-8?B?bVdJK3BpV242QXlwSGFYWG14RjQ3MytIN29LVTkrelZFeEF2TTlxOU1PRFZa?=
 =?utf-8?B?Q1NNZ3lIVVNqVmVpMGFLV1hiYjdZd0k0azMyUlY1MWFkZ0xNc0Raa1pMQnE3?=
 =?utf-8?B?QjBCb3dJZVVrb0RZMGhlYVhsMkFpdjFnUmFBV0xhMWFTMStvSHBmSnJPVlV6?=
 =?utf-8?B?bkNhK09ydXJaOERDV1dDKzg0OWpTdU85TFBGelk4dmF4ZTBuNjEzZU4wcFdD?=
 =?utf-8?B?TjMxdkFVTnU1bnZtV0FoMG5xODJsamlaWWpqTElCaFg1YWRrbnNkM3NWVDZi?=
 =?utf-8?B?T2lOQ0lkbzE5RUVtWjg4K1FDWGc0MVc0V1hxNThJaWl1NUJvdVpxNFNwcHhG?=
 =?utf-8?B?dTNWMkN6K3FGZC8rcXRINW13Y0ZnUkl5WGpzY1dSLzc1aEhhS1N5U00yMktK?=
 =?utf-8?B?T291SmNIbEpyZTFVY2l5VGNIRlcxRWN3dThJQ1J5YkZnenNFeTVkRWtqWWwr?=
 =?utf-8?B?U3dLYUs4RjUvd3BCTTVmM0M4N0wrbTg2RGkwUWJxekNvZ25NVkZWVENJTklF?=
 =?utf-8?B?ZUpPazFjRU9KdGJQNnkreDJ1d0IrNWlFNGlGdlZ1RCt5UDNVY2RCV29mL29X?=
 =?utf-8?B?Mm1oWVp4MVhTSk1jNnZFNWF3SmwwSmZLWUJFRWpDSk85QWVNY1ZVYlZJK1Vn?=
 =?utf-8?B?WjNROHIxSW1sbmZGc00zUWdteEhhQ01PY0R0N0xzcVJvSDdYTHZrOVVORUVD?=
 =?utf-8?B?WEU0UGNmRWxoS3haQWozYk0zaElPMEIwYXd4dlNjeU92c0tnb3hxSTcxSFg4?=
 =?utf-8?B?MlRIZ0tUa2pZM3ArbGo4VzZJZWorQjV5dndGSXpUYWNYdUVSTkw2RnYzd240?=
 =?utf-8?B?ak1HVktnQ1pMdURGeFlaVE85MXB1cHprUWRtcUN5US9LdjVScHhBbHFSUHBr?=
 =?utf-8?B?K2EwQzVzeXZvVzhJWWdiRG1OUVNxK0pSYXVuS3RjU0cyeDl4Um51MzZ6Tmla?=
 =?utf-8?B?NjZVb3RORFdGNmZ3N1dpcFZDV0JtdmhyTHlHOWwzZ0I4R3E5UHdwYmRocEFF?=
 =?utf-8?B?aTVnWmdUTEh5alJCcTV1Lzg0NkpwYW54STdoaWN2SGFuSXRNSVJxOVk0QUV6?=
 =?utf-8?B?UWpLb1J3Nmxnc01rczZTcGl3dktXY21vZTE1eTg5QzBYZDJKZGlNVVlaYXh3?=
 =?utf-8?B?OS9kR2pQY3pjRUthTUZCR01LUi80Qmsxbjg3R0JkMkJac3FPdVcyOE44THhE?=
 =?utf-8?B?VUVuV0p6TnhJdlZIRlRDR2hrWkwrOEUxWVB2Y1VIaE5PMldSTENPUVJlN3Ju?=
 =?utf-8?B?WTR6K3hkRzlzei9nVjNzM1YzWXFna2NpbmFzeFBDL05oazIrRVcxTE9aKzJW?=
 =?utf-8?B?dlNGRzNmdG83YVhwVWdrcFdjUXYwT1lmYjBIb1p0TWJZb3hMUFJ4RFJHL0Rl?=
 =?utf-8?B?VVBOTFhQQnJ3ZDJ4Rnhoa3FxQ0ZaUlB4S2JhQzhDQkpBKzNmTFlBTk9FWW5p?=
 =?utf-8?B?OXdJWWZCc05jQkJicUFxei9Sbkx2QzZyTldFSjZ3NE56NDkxaENOR0NSREtY?=
 =?utf-8?Q?Uu5PnonExYX2NujEg7L5Gykv1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SPUg3KmrQcNRQFKBfVUYjxB0LxBhzqLtfB7aZ1p+NaAII6IJsqh6NE0HhxOQO4JjyhSspSvuC4oo26D6ZIdBMx+znUoqGzuo/jNtLaehVgwVnZeKgAjv5NYuXRSc8GBzJiZud9/gTLzw+9+TfA7KDKf8a2kj9t+tgDTwuU79vG+U0i/GMAD98xXPfNpkHMoHhsOspL5yLwyUJJV118CE9s+SvWV60OTgVg0XqpXoXKGfn9YW2WRs/NR1aWlJHkYnpGy9ILx0PWQ8bN19vf8ZhhWLQVViJQiwFhvXFNqbxOBDDOxp7rb2hRX5sL5cnHtq2KOXY+etBPs650qz64gOxy/ShQxm+ZrOXQcGnGhifDiiv0WZH57A2aFRaTZwn5w0KHaj6z1VD44oA6uiwzv0wxb6BptX65a1dOsYg489sGR+vqoXm7OH6bWbV3fjwrBf063MwbieTPGIJSZWlaW5vObQUjhlAemBSuzzgiIGm7e/PmMzAx5JOu46ngnumIh1lnf4XwubKZGmET4Ea/wESN0LIHq/8LkejGyRUdrQtmgUr6siJlPgPSMME2tP7DKDlZbhGtA77V/j7rKr8YyKZxnon6IeFYOj3XNIWcx2YrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f993c33-0fbb-409c-c8fd-08dc49efdd58
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 21:42:54.0360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTwJPFgz4mF2mztP2wk9vQ4nNrVUYDo+i0xiNpN7y7sQ+F08GwtapqzhS++wxP2LXUzLF6IUH7O6Ihhg1mWdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210163
X-Proofpoint-GUID: 3EDDFGeMOVQ3r1YYF76GjvJaW6-j6Jtu
X-Proofpoint-ORIG-GUID: 3EDDFGeMOVQ3r1YYF76GjvJaW6-j6Jtu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/20/2024 8:56 PM, Jason Wang wrote:
> On Thu, Mar 21, 2024 at 5:03 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/19/2024 8:27 PM, Jason Wang wrote:
>>> On Tue, Mar 19, 2024 at 6:16 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 3/17/2024 8:22 PM, Jason Wang wrote:
>>>>> On Sat, Mar 16, 2024 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 3/14/2024 9:03 PM, Jason Wang wrote:
>>>>>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On setups with one or more virtio-net devices with vhost on,
>>>>>>>> dirty tracking iteration increases cost the bigger the number
>>>>>>>> amount of queues are set up e.g. on idle guests migration the
>>>>>>>> following is observed with virtio-net with vhost=on:
>>>>>>>>
>>>>>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>>>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>>>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>>>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>>>>>
>>>>>>>> With high memory rates the symptom is lack of convergence as soon
>>>>>>>> as it has a vhost device with a sufficiently high number of queues,
>>>>>>>> the sufficient number of vhost devices.
>>>>>>>>
>>>>>>>> On every migration iteration (every 100msecs) it will redundantly
>>>>>>>> query the *shared log* the number of queues configured with vhost
>>>>>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>>>>>> but not for the memory sections which are the same. So essentially
>>>>>>>> we end up scanning the dirty log too often.
>>>>>>>>
>>>>>>>> To fix that, select a vhost device responsible for scanning the
>>>>>>>> log with regards to memory sections dirty tracking. It is selected
>>>>>>>> when we enable the logger (during migration) and cleared when we
>>>>>>>> disable the logger. If the vhost logger device goes away for some
>>>>>>>> reason, the logger will be re-selected from the rest of vhost
>>>>>>>> devices.
>>>>>>>>
>>>>>>>> After making mem-section logger a singleton instance, constant cost
>>>>>>>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>>>>>>>> queues or how many vhost devices are configured:
>>>>>>>>
>>>>>>>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>>>>>>>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>>>>>>>
>>>>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>>>
>>>>>>>> ---
>>>>>>>> v3 -> v4:
>>>>>>>>       - add comment to clarify effect on cache locality and
>>>>>>>>         performance
>>>>>>>>
>>>>>>>> v2 -> v3:
>>>>>>>>       - add after-fix benchmark to commit log
>>>>>>>>       - rename vhost_log_dev_enabled to vhost_dev_should_log
>>>>>>>>       - remove unneeded comparisons for backend_type
>>>>>>>>       - use QLIST array instead of single flat list to store vhost
>>>>>>>>         logger devices
>>>>>>>>       - simplify logger election logic
>>>>>>>> ---
>>>>>>>>      hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>>>>>      include/hw/virtio/vhost.h |  1 +
>>>>>>>>      2 files changed, 62 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>>>> index 612f4db..58522f1 100644
>>>>>>>> --- a/hw/virtio/vhost.c
>>>>>>>> +++ b/hw/virtio/vhost.c
>>>>>>>> @@ -45,6 +45,7 @@
>>>>>>>>
>>>>>>>>      static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>      static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>>>>>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>
>>>>>>>>      /* Memslots used by backends that support private memslots (without an fd). */
>>>>>>>>      static unsigned int used_memslots;
>>>>>>>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>>>>>>>          }
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>>>>>>>> +{
>>>>>>>> +    assert(dev->vhost_ops);
>>>>>>>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>>>>>>>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>>>>>>>> +
>>>>>>>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
>>>>>>> A dumb question, why not simple check
>>>>>>>
>>>>>>> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
>>>>>> Because we are not sure if the logger comes from vhost_log_shm[] or
>>>>>> vhost_log[]. Don't want to complicate the check here by calling into
>>>>>> vhost_dev_log_is_shared() everytime when the .log_sync() is called.
>>>>> It has very low overhead, isn't it?
>>>> Whether this has low overhead will have to depend on the specific
>>>> backend's implementation for .vhost_requires_shm_log(), which the common
>>>> vhost layer should not assume upon or rely on the current implementation.
>>>>
>>>>> static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>>>>> {
>>>>>        return dev->vhost_ops->vhost_requires_shm_log &&
>>>>>               dev->vhost_ops->vhost_requires_shm_log(dev);
>>>>> }
>>> For example, if I understand the code correctly, the log type won't be
>>> changed during runtime, so we can endup with a boolean to record that
>>> instead of a query ops?
>> Right now the log type won't change during runtime, but I am not sure if
>> this may prohibit future revisit to allow change at the runtime,
> We can be bothered when we have such a request then.
>
>> then
>> there'll be complex code involvled to maintain the state.
>>
>> Other than this, I think it's insufficient to just check the shm log
>> v.s. normal log. The logger device requires to identify a leading logger
>> device that gets elected in vhost_dev_elect_mem_logger(), as all the
>> dev->log points to the same logger that is refenerce counted, that we
>> have to add extra field and complex logic to maintain the election
>> status.
> One thing I don't understand here (and in the changelog) is why do we
> need an election here?

vhost_sync_dirty_bitmap() not just scans the guest memory sections but 
the specific one for virtqueues (used rings) also. To save more CPU 
cycles to the best extend, the guest memory must be scanned only once in 
each log iteration, though the logging for used rings would still have 
to use the specific vhost instance, so all vhost_device instance still 
keeps the dev->log pointer to the shared log as-is. Generally the shared 
memory logger can be picked from an arbitrary vhost_device instance, but 
to keep the code simple, performant and predictable, logger selection is 
made on the control path at the vhost add/remove time rather than be 
determined at the dirty log collection runtime, the latter of which is 
in the hotpath.

>
>> I thought that Eugenio's previous suggestion tried to simplify
>> the logic in vhost_dev_elect_mem_logger(), as the QLIST_FIRST macro that
>> gets expanded to use the lh_first field for the QLIST would simply
>> satisfy the basic need. Why extra logic to make the check ever more
>> complex, is there any benefit by adding more fields to the vhost_dev?
> I don't get here, the idea is to just pick one shared log which should
> be much more simpler than what is proposed here.
The code you showed earlier won't work as all vhost_device instance 
points to the same dev->log device...

Regards,
-Siwei
>
> Thanks
>
>>
>> Thanks,
>> -Siwei
>>
>>>>> And it helps to simplify the logic.
>>>> Generally yes, but when it comes to hot path operations the performance
>>>> consideration could override this principle. I think there's no harm to
>>>> check against logger device cached in vhost layer itself, and the
>>>> current patch does not create a lot of complexity or performance side
>>>> effect (actually I think the conditional should be very straightforward
>>>> to turn into just a couple of assembly compare and branch instructions
>>>> rather than indirection through another jmp call).
>>> Thanks
>>>
>>>> -Siwei
>>>>
>>>>> Thanks
>>>>>
>>>>>> -Siwei
>>>>>>> ?
>>>>>>>
>>>>>>> Thanks
>>>>>>>



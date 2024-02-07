Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9A3C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfzk-0000TR-Hr; Wed, 07 Feb 2024 06:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rXfzY-0000Sx-RO
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:21:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rXfzV-0005QW-Ri
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:21:24 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417AE1tA003043; Wed, 7 Feb 2024 11:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=//YKp1jae141N4ZXpHBgaZjI+C6BpvObtKNGxnA3zHA=;
 b=QCOkAy2EVnAxqBHNHWU8It11TsPd7WWCgT4T/PIvsFoWOLsnsUGPLwHISpQOT3U8HaRU
 w1FJiVJL8/KuKX3u3mc4BClS4XCPN8d1nx8lQRY4UuhEj+BbPvZ70Bfw8ycx2jGCzx61
 z79gZkvN/MKwFJ6dsC1JGzomDwx4HFv67tOpOdD1mwqr1kgFNF/VuwcOgLqW79YjXhFH
 5EbTbZVRfXhTF2ofoNEX1sA3uriF8frpmGtSlISfhGop9SuRZjuzncDW1CpPWPYIUlVP
 ecFhoin0z6aOblROdkKutD/b9qDMmNLLpevQG1HcODLeN9VYcXVWCimaCm1tDqyF68qq bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdhk6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Feb 2024 11:21:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 417AXYNd040219; Wed, 7 Feb 2024 11:21:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxf4r4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Feb 2024 11:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhOuvNS86MLLRuJ+143bpTNU2eosBZka68kBoSXZlI9jcOQ3x/R8UxJdaWCwTTDht2OfP+Zr7ER3b1vcJ4tvPKzDgviIrqc+X7GKzSUzx5s8aPmXsKVHDk4lf2e/Mw/Rn6C4hadBzDZDb3Mmt29Po5aLjNP8W5XKK+GWFQGKsOjOHlVJg8YCEhc2Hv4vMWWWbnocAMcah99TWn6/UqxXG3SnlFiiMptbJ8kASCT1lHTCOkOaqh3Yat2L75HDHflyB/ijJJ+IJF8GX7Ja0sW0Kj0L6FR63LjHEW6bYMbHJMX1b/qi0tNfsNabpQoyq3Y+HPWGjd7zqho4niOxuf6lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//YKp1jae141N4ZXpHBgaZjI+C6BpvObtKNGxnA3zHA=;
 b=dSjR4/od6tl7CVbBE1M3XEWrw3VLIARxoUUjGRMS7+q4xj5WggiXIZ9oHjHlI6Q7LQvd7Om5ub5o+E3kxJw6gaXNhee2pQN1UJzaL0Rfuh08L2rf60tt8eWF80LlazyqKywUvp6/lOZI7dt/BQ0D1XfhVOyNYkAwq1xSLzYwu7H+4DKYhV52Ufz6g9cP0/hBfomamJop6SXRPEvKeTngv8mMjY0+mmQt0ZEFzSolLd9uLRGLF4H4qe3yvJ+rBAYmqG1Rhp9OyJ9DJxUxp3j2jOgWRPXkf0tIiyrrauM7pAamXwHIm1aV9KfzI/8wdZYnqTR157qTzgmi7L0W9uNGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//YKp1jae141N4ZXpHBgaZjI+C6BpvObtKNGxnA3zHA=;
 b=G+VNMEN1DaQhjI25UcZg6JprvRfVvuHsRcEox2UHJfN9h3oyyiM/J3bwXRR4UVZrEbAoYnkxhkyxrOzXjpnRIG5xuva6AdMSQW8oWG1QXRNB31WRRO+CzPYBLeJHC9xpLAtAFM22sXitM3ipBS/V0D/OH1KHiGszjWLhlvzrZOc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA1PR10MB7855.namprd10.prod.outlook.com (2603:10b6:806:3a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 11:21:12 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 11:21:11 +0000
Message-ID: <afc99063-1916-4a0c-a763-f515a4595e73@oracle.com>
Date: Wed, 7 Feb 2024 11:21:05 +0000
Subject: Re: [PATCH v4 0/3] Fix MCE handling on AMD hosts
Content-Language: en-US
To: John Allen <john.allen@amd.com>, pbonzini@redhat.com,
 william.roche@oracle.com
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, "peterx@redhat.com" <peterx@redhat.com>
References: <20230912211824.90952-1-john.allen@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230912211824.90952-1-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0574.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA1PR10MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f4172a-4074-48a2-f4ee-08dc27cee398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vjqlev1TEct3QPxx4tsj5vNa8gW0mBzSU7aRv7PA4lR2ZA1KsNc5L5R+vdprLEzTll6t1ae8uDwxed5TUxzXKc4H0un2tZOjHvmKVmpQsqXf+qTxr5B50rhYK0qaGWt/+NWK0LDilj3yN9A6zBaahhCiU8ukKBtVfVOXKP6ENNlGeN3D1P1lnBqAWclfL9We5ajGK+T31075Zd0YeBr8gOA26phT7H4GMcErPYVfes+AeKXJQogOxlwqleFR0Zr6SdkCHaO/YONCaMbGNTC11xbqBMQFeNLrsPryTeftJa4FH33+GKEaJu3uG/HprrB0uZrxxnz9LgG9nWhBLu6zEc0SQ7azsYnxAzBp8ZKYA8ipaTieDY4AK+pvT8KxPSODhTbMLDJJTyvHje6vOfW+k2nFJ9fptfTO/n4LzrjhQsnVnqJsw4k3G/PdIYvUSPbRsBK5nA4UqsRWM+PMQsPlReKUBiOaZPZIyXd8i9kYW5e1vp+XE/9sWqPE53ys96lvXN2xtOlTXN1wZvjDi/XC0WPeySALLpBb07BaU0Y8PVTKNPHSx1VjhZMX/C9LuEs7c/1IDELMVSrGO3LhMUeWJl2m8Af1uMIE0dca/E8OvXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(38100700002)(83380400001)(6486002)(966005)(2616005)(86362001)(31696002)(6666004)(478600001)(6506007)(26005)(6512007)(53546011)(36756003)(66899024)(66946007)(316002)(6636002)(41300700001)(66476007)(66556008)(8676002)(4326008)(2906002)(8936002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RStUYTVYbkJFVjhxM3E3MksyR1dNMEdJUktEY1lDbzB5YjdBcFVYOEJyZ2lU?=
 =?utf-8?B?QzF0RVRNUXFZcmtXOG1sZGZOUDlkeUM1TWNRNWJTTS9FMjE1VTcrYUdVRC9B?=
 =?utf-8?B?QitoWFFYQmlFaFNzZjd2YmFEcVgwOEJxVUVnbVZPQUlyM1FWR1hrSzJXZkdR?=
 =?utf-8?B?MURUeHlDbmZrdTI5Zjd0QzJTS09TZFBsNE1tcFdYTUFYVUlaRVFSZ09aYXFp?=
 =?utf-8?B?L2UxU2lxZ3lJY0R3NHdRNHRROUVhUzdVSXdlMm1SVWNTak5Qa2lBcVh4SEVs?=
 =?utf-8?B?N3dlMThpdnl5ZkFGRHBjZEVkUUZ1ZU1QNEt5SG1RSEFZZFpjVzRJaUMxYnZj?=
 =?utf-8?B?YWV6T2tBSUEyYU8xUThyWkExZWZVQXpMUWM2ZXJMT1lQRUtob3JaZ3lPVFhK?=
 =?utf-8?B?L1J3ZTJIMnozakVuclByUHJkMy9PcmVVM3czeE1kWTN4Y2ZoZVhBOXFuSDZN?=
 =?utf-8?B?Znl0VkZxT0hUVnlhL0M1aU9IMFBZQml2SEtBVVJuc0VrVkdGWjU3SVFpOGJJ?=
 =?utf-8?B?OXduMXIvcW1EQ3dScnFsUjA5QnozLzJFWXdvTnUxL1M2aGUwTzVIYVhPL29J?=
 =?utf-8?B?UnRwZ0hYRXhoTks4MTRoZHJmQmRKcmRQSk9JbncxWm9kaUIzdFU1NXlyTVFr?=
 =?utf-8?B?ZU1rRy9RVkFiVHhaUHdIL3Jzc2Y4K3VxY2h1UFNGTnlTeGRXemVzTU82R0o0?=
 =?utf-8?B?Z2RwRUdsUjhEUGg2YVN1TFRuRFMzdDN6bGtGYUlnWWVmZFVrVHRZUWo2a2VU?=
 =?utf-8?B?eWxkbGJST3FuZTJUMlhDVlR2cVJQdHNmNlNmYjl6cU93SHlnSXY1L0VRViti?=
 =?utf-8?B?aVkzOGNpSURzd1BKcnM2cTJlWG9oVmxRc1N6YTBrNVJXRGhYUHZVTTRsVlcr?=
 =?utf-8?B?NVpmTnhNTDN5SGtoTVRuS3ZpbEJodG5QbXFoZXV1OGYxT3dXTWgzekV3aEFS?=
 =?utf-8?B?QjRBbzREU3prWmhBL0lMaWljOWRBTlZmVEJFNzUvTlhuUk5aS212QVMxNG90?=
 =?utf-8?B?WnlqZnZYeHRTQ3E4cjIvendWN0dlSUdzWDB0YmN2Vk04QzlhZDhhVGhQL3po?=
 =?utf-8?B?REIyTFpWdHNLK2tPU3hyMVNSRlVWSlRJcGpPZ2NRdzNwbU1FWjg4K203NXNR?=
 =?utf-8?B?bDNaaFlXRGV2UlR0UzlvZGdXNU5SVTRiaVJpMDdpYzNOVisxMTA1Q1ZVTjdF?=
 =?utf-8?B?anM2a29YbzVnY3BNTXZFY0pKVFExUVEvRlZaZDFUYW1MMXFUSWw0dTVsY2pp?=
 =?utf-8?B?a3JMSXQ4QmFSbVE1L0NuZS9aRjBaNks2TU9Jek9SWjBOYlFQeHJJcENkUFdL?=
 =?utf-8?B?YTBaS2dEbld4RndTZEJZNEEvWHRhbHlpYzVqNW9Ca0l0ZVNrSGE5My9lL25q?=
 =?utf-8?B?VnE1UjJ5S1VYSmtrUHYxcWF3ekhUdkFDMHZ4RGRGOFovNFBGNTFLVGFrU281?=
 =?utf-8?B?aDVvN2VJdE5raElHUmhGd0VaKzc0K1A3cEhYa2hLSlkydUlpZ24zUDZKUGMx?=
 =?utf-8?B?TGQ1WDUwNTBLU01JQkw2TS9Od1BNbERzQlFMbzNpQ1gxZ081VytFZHdwL3F5?=
 =?utf-8?B?U2w5dnJWTFdLZXlzejlpL1NRcE5HZHBocHR1bTdWZEh3YVcvUlFYbnNLUENk?=
 =?utf-8?B?MWlscU9ickl3SGtTbFFTNVFrK3N0c2FIdkdXQ2xMLzFnZXJnU3luRzAwRVZm?=
 =?utf-8?B?dEE2NlBpM2txSWFYWDBqTGNqZlNoaEY0QklndHRTR0tYaVhIcURydFJlWXF5?=
 =?utf-8?B?QXdxZkllSmJ0aDNwWnF4dm4rbXYyTnhiRTVyMzcrTVRaeHlqQTRDaXlnQytQ?=
 =?utf-8?B?K2xVOVdXcUhqeDNBRXQwM0xsWkd6SVhnR3ZhNlpGT0dpUVVzUkc0OXlFRVlZ?=
 =?utf-8?B?UW9EMEFRMUd2K1FsVWtzMzhBVjJSRUJsbE04NnZRZTE3SUZXYWhsV3UzTTVx?=
 =?utf-8?B?dEl5SnZiYlBvU0NQSGJua3BycnZERzU0Z3NkdWFrMlVlWTB0a3RtRXFhdldv?=
 =?utf-8?B?RjEyaytZZUdoeklyc0ZrVkx4Z1c5MzRQdkpxMzZtdFdjL09GOWYyVWNMMlZI?=
 =?utf-8?B?OW9yZ043b0NVQm9KT0prU3hoYWd5WFA2VGVkanpNeUxCTjFZU2RMSHVvVnAy?=
 =?utf-8?B?dFY2NjBETW55NGNIMkZRd3Y2dkdnMmdCQk1jUXZVeUtqZGUrVDBpVkpZZG1H?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IaeJhwTwjSQOx9ZviGV8HzTsTWnm7ASvwETn8HZHSn6ysPI7r8PxKOjQMfAAd0E/wEDs1ndm76FF1HQEjVDIj2cDetz6amuNHxzBtG7rc5pgXElkDyKXx8sWkQZGzBlvElmtB+FD3tY4TE7p8xpEfj4xeKQHOFZVkLPd4oJlD9hNK99iFj+45urY/QXt1ls5C+wqSlotWLU2aBYYreJ2KUUxU9bKd+BxLCHh1rbDVepU0DWDIAOpzdR5mREQldJTzxH/tn8Na/Wm92PzkibGLkm1WXh84SOovTeKwkkYM0MG1pb6Wkiaz1IzmI4pFWOuk3fRdZWNGtmQ5hgqtmfX1YdsH6kHgbR8fH+nKhyjEfrzcT0d75TVYwxHaQGpDSkpEPZU4viZxFVO9q1w74i1PPknkPv2VWN2KWhh7PWj8yBJfVOrADxWECbBtoRZu/OV1teCa8BTTlI9sSITUEhxvuV13kPikS7Jc7g4B8hUa+Z7AbwzHxtpAiz9Yzgor6p4Q7zQMb7ROJNtdMjYnVtRBErnuf3DAAY8HkyFZsZxJ3Jew80rewnYOqpGC8mABO/9E/WBLFwYJqVDnsRumoNfgBpOvorteH4j69B+TI/+9RY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f4172a-4074-48a2-f4ee-08dc27cee398
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 11:21:11.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmupHWSpuerFGOs1t3o9Hu9i0c/M9kx4VGad5CnkpbFJAjqygVxXBS8A9a5EbJClJED/r9FWEWQwfGrVvT2yBRBuAdchW4Qd0ITAhN8B95E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070084
X-Proofpoint-GUID: uMW62mc91SVmJhUEbZw-fYGMwV3cPp4z
X-Proofpoint-ORIG-GUID: uMW62mc91SVmJhUEbZw-fYGMwV3cPp4z
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/09/2023 22:18, John Allen wrote:
> In the event that a guest process attempts to access memory that has
> been poisoned in response to a deferred uncorrected MCE, an AMD system
> will currently generate a SIGBUS error which will result in the entire
> guest being shutdown. Ideally, we only want to kill the guest process
> that accessed poisoned memory in this case.
> 
> This support has been included in qemu for Intel hosts for a long time,
> but there are a couple of changes needed for AMD hosts. First, we will
> need to expose the SUCCOR cpuid bit to guests. Second, we need to modify
> the MCE injection code to avoid Intel specific behavior when we are
> running on an AMD host.
> 

Is there any update with respect to this series?

John's series should fix MCE injection on AMD; as today it is just crashing the
guest (sadly) when an MCE happens in the hypervisor.

William, Paolo, I think the sort-of-dependency(?) of this where we block
migration if there was a poisoned page on is already in Peter's migration
tree[1] (CC'ed). So perhaps this series just needs John to resend it given that
it's been a couple months since v4?

[1]
https://lore.kernel.org/qemu-devel/20240130190640.139364-2-william.roche@oracle.com/

> v2:
>   - Add "succor" feature word.
>   - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
> 
> v3:
>   - Reorder series. Only enable SUCCOR after bugs have been fixed.
>   - Introduce new patch ignoring AO errors.
> 
> v4:
>   - Remove redundant check for AO errors.
> 
> John Allen (2):
>   i386: Fix MCE support for AMD hosts
>   i386: Add support for SUCCOR feature
> 
> William Roche (1):
>   i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest
> 
>  target/i386/cpu.c     | 18 +++++++++++++++++-
>  target/i386/cpu.h     |  4 ++++
>  target/i386/helper.c  |  4 ++++
>  target/i386/kvm/kvm.c | 28 ++++++++++++++++++++--------
>  4 files changed, 45 insertions(+), 9 deletions(-)
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C825C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 10:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfL0-0002tg-2R; Wed, 07 Feb 2024 05:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rXfKx-0002tR-A9
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 05:39:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rXfKv-0002Kl-00
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 05:39:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417AE4q5014861; Wed, 7 Feb 2024 10:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q0tCrK/rtGI55XxRHNqmvqLtAqVI8u4tlIC/Pjusv0w=;
 b=koD9Av2U8IHvhzwvySweehjplpVOi3hha/HTC0y5UkrFFTNeY7EaV3lYS2l6lU/BkLf3
 icFgpORSaUYJzIV2zTymeum/pigAFYPK7od+JOcSO2cjd/Wj/410diX0UMKb1Nt1rdxc
 uYEGMaGOcxudLSIdARqC2PRQ5v9mp4Gdz89CwIEwLuhpzIJ4uFC0PB21TRl3F3bDzhSo
 ePF9RpiQn5ElJKWtN51108AL478K4eXUrz+JYfJ6Oc3v4E1vgaeFsoA+8guZK0m4WfdK
 UnjUndhHgHCvftclrnIuCefBPi8XuntROo9z86wVE8GO+3KCxssw8rDTazG3rAlhmFPa 9A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwesa7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Feb 2024 10:38:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4179V8o7038327; Wed, 7 Feb 2024 10:38:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bx8sq5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Feb 2024 10:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/8VcE8ZiZMmxaufy9r9SSS3Kkf3N+FnlVygvMCDng4GjInw/RdMnS/+X4SwagbfuGmtaXIslH7yuMzPhg7eDS5bQgfU8ecDByqJLL5IalSHslzDW86nIIxE5NmwhL6uFek8HbUtqXLkvTPifHF35FtPhxixfj6mHfgEWcjI4yJ/2MvEMFIRN+/2CmHhSFolXwWyB1JfYMR0UrD51W3zTcxkSofuY42hxJZiG1CChwS+mRw5L2tcQbCFo58o3QTkyZyWzNR/RMJfqLWnXM5VZWWmEs3VkPFsD4nOe8lWamW9cFHPYs/E9FqYBeNfHtvPUEnnl+6FF6IQt6RoTvEOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0tCrK/rtGI55XxRHNqmvqLtAqVI8u4tlIC/Pjusv0w=;
 b=DFO8zpL8Q1Ea6Ds6TVLZs+cJRE+d5v3hVTxwT+NFMOufXB4fLLDmm2Axz8l0L3cNIs6NBQwwd96+LDd1SLoOSWZPoeFQB04mmm4V1IOY5BDYuenEsywUqJCS+xpDwg4VcDnsdy9a34wOJ1hMdxEDBddjlFt+1Zgrz2X4Eu6V1JmvpIHEb0uDvoO9jDWRkjqDnEJ9tr2pI2rRuICDmA0gKMxqXrk23V0vc2iDyEln8IuIKWr1yolzWou4cn/8dr62BbvW15sTClY6gmMVnP5Ly4oHxKxI7AQ1MeteGhQEIQ5rxnWT+NtMtMysJ1YhNR3ATej8Ieu1XvD2clR4qgr15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0tCrK/rtGI55XxRHNqmvqLtAqVI8u4tlIC/Pjusv0w=;
 b=xaAkaIcKn2/1+rJhVJzoqkvjPZ677ZFDpqb9+D93wia3Gri73nls2cSdjobcLV0TJhApRYAzi7PK59ZvjZ1zLhuWToTxHhe8zBzPLQV5pNYQwJ/S1gv9tK4UMsE0FZfKQpPyr1tJmLf5YWwaftagawLX3N3CGsdhA+KLlQ3EJl8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB4836.namprd10.prod.outlook.com (2603:10b6:208:326::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 10:38:26 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 10:38:26 +0000
Message-ID: <04a57872-0101-43d1-bb18-dd73c7e7d363@oracle.com>
Date: Wed, 7 Feb 2024 10:38:20 +0000
Subject: Re: [PATCH v3 3/6] util/bufferiszero: remove AVX512 variant
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>,
 Elena Ufimtseva <ufimtseva@gmail.com>
Cc: qemu-devel@nongnu.org, Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-4-amonakov@ispras.ru>
 <CAEr7rXiMEm12YqUJ5r+Nur7iJxcvfxLKmasJKJ2QGmFhZL7-5Q@mail.gmail.com>
 <c0037199-a9c1-3d6b-4627-9d3cf49010d3@ispras.ru>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <c0037199-a9c1-3d6b-4627-9d3cf49010d3@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3aec65-255b-4944-033c-08dc27c8eab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHgqKJw5EoxeZy+H3DFhE2WwZihjKaOVpq9c1B/Ivf193YKaMov74ANpMKSh7F22VwarL5FpyMYg0bv43hSZZBdzyXY/NawRHSKNlXR6nBsaNhmntscIlgPEGdIbMRMF/4N/hHcoYanLo5CgaCBuW0r3x4muvGeznQOVMGWPMa4JBMrMOZOzehhD/7eMczZNsFpPfnhpL8jSoTx4Ydrht9NeUd4PsWecFSnvH8cg/KdTw0vfurAwk54ld2S3LRQaXCw1/upP1RXw/L3gQqW/Ch9GeIWn1p99Wmcj1axidVytdiF1tIL+lRa5MJo7FZl/UwOeWMrP3wNOYjOz0ulVSTHGIiV6CjnGQ/u9Siy0FBtXDg8YYEXk7eWf4afLvfJlp343bMQgzr3tuOKw2Gf1FDaSIYIKXVkvlyst01GuyCxavrNd9xejrDbxp8uTKWicwip45/mXOZVaiPy7J4IAQkfQwnYhMNH/Z1xbuRQ0eh1IDKIjLIlgl1jlucAjysmfrFTvzQlj6al3erOPZ/tXMx6OeDlvzfghXgQA4jkdu9MUuqfBJascNNmFVPkjC+p0yAP2PIdlVYE3bK3a9voE/PGTDW3X+zaRYJfa3gQvCog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(31696002)(316002)(110136005)(66946007)(54906003)(66476007)(66556008)(478600001)(4326008)(8936002)(8676002)(966005)(6486002)(5660300002)(2906002)(38100700002)(6512007)(2616005)(6666004)(53546011)(6506007)(83380400001)(26005)(36756003)(41300700001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjI5U2N1cUloZ2VnejMzclB4YlFNdFpONHV1cWVpMDVWL2dxUkVBNEd3ODJS?=
 =?utf-8?B?V1Jyc2JtMmh0clhhZnByWndVZlBDcXNDdTFKVFBVcDlla0dPTUVMVDNsazRE?=
 =?utf-8?B?MGZBRVlLZXBFWXpWMUFtQnVaOHFGWGVpckZRU2lrZWMvanRBbXg4TUhLMC9U?=
 =?utf-8?B?MHM1YWJReWM5TnFGdXVRSkJMangzTmYxS3JuVktpTHJRM2h4SmtML2NMb1RN?=
 =?utf-8?B?bEg5OUlJV0MvNjBVZlhnWW9TZTdFUE1NVGlERXNiWEcxblRnVDA0b2ZCUzF0?=
 =?utf-8?B?empZbDRCaGVrb1drSkxsL1FuWGtCMEJVLzRKcjdRMHcyN0MwY1Yrc2IwTTNm?=
 =?utf-8?B?TkFqamI2VlBYRk91Q2o4M2xYWVlxUXpoQnlJQzBDOGl6QmFheEM2SDE0eWFB?=
 =?utf-8?B?VzNuVUhsdCtQcTFqeEgxYUpWSXdJT05QYkpIUDhIK082VEtZdDBoUHpmY3Qr?=
 =?utf-8?B?MHloSDFneUhjV0VGOWhGUmFxMzB0eEdaSWlEekpnS0tQQ29uNzROTE9XS3FE?=
 =?utf-8?B?UjJpTSt2ankyaEZDS2xPaXNJV0h2ZFZzQTlYeTdsRVZ5ZUo2WTg5UlZIcGRw?=
 =?utf-8?B?MFU0NGRiSFRnUWtEcFFyZ2Z4cEhxYlFrYnJyNDhXR2hPQ3lkUWhkSXI1OEd4?=
 =?utf-8?B?MFkvcG9VZXBhVDFDUUdUSGd1QTRUcWZlZm9EUVcvVWN2OXd6QmZXMVI0RUhD?=
 =?utf-8?B?dTkxTUQrcUtZZUNsRTNoUGYyc05UbUhGKzk2Tkp4UVp3dHRpSElGZlpuUkx6?=
 =?utf-8?B?WWVoRmEwMWNucFpJRGFoaC9VTFlJZ3MzSk9hTmFsU2dYeVVYclBQUDgvMmdY?=
 =?utf-8?B?QlI2RDdrNTRBZjh6bnpmZkZPNkIrMkgzUVBzM2Mra0VTRk5OZzBXT2xQSnp4?=
 =?utf-8?B?dWZwL2RHOGR0WmFLRXBNTVVKQnkwMUM2TG5NSlZmYjgwK1haOTZ3WGpoMUNR?=
 =?utf-8?B?ZnZpWCtNdk02YlBGd1FXRjJ2SnRWeEJLM1prOUpjWTBuQ0h2RHgyTER3akUw?=
 =?utf-8?B?QTN4bFdnUFp0UWMzd0ptblBwVDR5NmFMc0JlWHkySmU1NkxEOVNia2thenZG?=
 =?utf-8?B?czNSOVNwc0owL1NBU1JtUTNLMGQ4emZrN3BCV0xUc2lGdUtURmVLeXFmTWVj?=
 =?utf-8?B?djJNS0d0OWdvYThDbWgvYmVISDhvdFRuVXdLWW9kVVZMK1ptcDNpNVlyTlpU?=
 =?utf-8?B?c09CSXNMVnJzd2dpT2RyR21yOGgyN1EyZ2pKVndyaU5rdWlnbDhBUTBmNWtJ?=
 =?utf-8?B?aCtYWFhZenBRM0JBUFFBUTlQTjA1cXZrSDVNRytTMG0rS01MTnR4UFJWWGx0?=
 =?utf-8?B?M1RQTi9Mcms5cVVNOGMwbFdHSjg4cXFCT2Y4OFpGaEJVUG1iM1VBNExVQlJa?=
 =?utf-8?B?cU5oeVdXYW1UWGdiSHo1OFVXU0VjbVdScHhEaWJTelB3VEw4dmRBb2pnNWR3?=
 =?utf-8?B?RS9HQlJnVUlJK2l0Y2lDelVER2IreUJJQUZNajlFc0NGWHl0eGppNDlrOTFv?=
 =?utf-8?B?VUhHQU1tTU1OdkZPL1R5UHUyejhTeXYrVVJqODBBNVRBMWtiKzJFSHpzY2gw?=
 =?utf-8?B?SlphZ202ekozaVpidTVRYVpxQ3AxWFg4Y0wxTmpoUXFBU0dsN2dtNEcwaFJu?=
 =?utf-8?B?U0JvODZiZWNHWndMeVVIK1FnVW9BQVdUNUVYL2FiWTkxVnA0OGR1cXgzWERx?=
 =?utf-8?B?Vlk5UzRHUXU1cUcxNUtDK2pzbW0vUXFaZ09SYlFoMUVZcTQ5bWpzSnFaemJv?=
 =?utf-8?B?WlFLVlNZMUNNb3lmYTJxNng2NkFtK3Y3S0VxclNza012cEVPdVFiZ3Y1SGl2?=
 =?utf-8?B?WHd6ZE9ITDhhS2pKeWdydWozSVJkYVIvY3dyRjlGQXU4N1VJVkxOR2xxMExE?=
 =?utf-8?B?L1V4d1JOcDVwWHpJejhsRDVhU0FlMzdsZFpFMDlMTzZCYkRwSDNzMElBU29r?=
 =?utf-8?B?cGlMc09QOHhiVVcrOVBBRlZCcVJ2VytCL3VxUjdDbExFWCs5NHplZ2JSM01r?=
 =?utf-8?B?YzQvN2E2L2lNZG9PTzRYNHRvbGdzSzhqbURmQXU4dksraXV0Z1AwU1c1cGdn?=
 =?utf-8?B?OEZjMWJsL0dKTUNBNGduNVJCK1BqN3pWYWxCU0NvZFJSU0lCVlNVOTR3bmgr?=
 =?utf-8?B?WEt6Y3RjeWpQbDIxZ1NTdGpoYi9vQ3dMcnhjbmRQYUZ0UUwvNFhoaytPcmJh?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 91peLKfECR0I1keTa1ox4j44eDbtJLE+/Wv3XabTVvUG4Or3xMI+SSuulA8C1vIbn02ohnVelKiJ3iOdZ8Ewe5pGrIEphSid2RXgyihkB+XZp09POII+X8SaMlGk6FP7uyTxIsHSSpJZYkWVCpTqGc5n05SFSFWVultMacR2GSuUleM3y7eN5sS/HmfZJbHagAG7McXTv8BSzveJALpTtNvycb8cr/2ge1vNu2355uKElDtUuh8MpFlQTMuQT6/inwzR0BCRRSXOWm5x3RkP8DKNW2xSa8yQV6+qT7eHYraAS+iy+f5PMpm4CkpuaV7JJDIMCKlfBJhhn7fGNGdm6sBJkyaS4MsEEryzUGYx2BmzjFqVeckvYtlRdCuwbWNZHjwHTCh2BL1t3agRMibYVEz5Ij7vwiUCfuYZwVwKX+2tSfyhDzR0iH8OIlovENu61lzcbr9XhvQXTSOT5u4qnCvcVE0RzrPbVymSRGuNgDsOTA4sslaCGZuoIWkG4OtxixVv4S8C4fmUuyus/dYqW4LRIZ5KdSgOtiBjjW5OOLtYuXxmTchmvyyvUmfZVSecsZ51tdMqB7yCaa2khUxYPFo3WKVGOBuqy2II0cotQrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3aec65-255b-4944-033c-08dc27c8eab2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:38:26.6689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJfRkHczZs7hoDH7+QLrqIow3eQc6oFisGrCMHM/Dx+dCaXhOi9t5Hc7jv7D5bzDgJhh/MnDbexC2u/ZCbrfItrZ0VRvusHfzM5rPvrS9M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070079
X-Proofpoint-ORIG-GUID: IY0Eb9o6mjokxGK-F65snBU0T1mfDD4n
X-Proofpoint-GUID: IY0Eb9o6mjokxGK-F65snBU0T1mfDD4n
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

On 07/02/2024 06:29, Alexander Monakov wrote:
> On Tue, 6 Feb 2024, Elena Ufimtseva wrote:
>> Hello Alexander
>>
>> On Tue, Feb 6, 2024 at 12:50 PM Alexander Monakov <amonakov@ispras.ru>
>> wrote:
>>
>>> Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
>>> routines are invoked much more rarely in normal use when most buffers
>>> are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
>>> frequency and voltage transition periods during which the CPU operates
>>> at reduced performance, as described in
>>> https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html
>>
>> I would like to point out that the frequency scaling is not currently an
>> issue on AMD Zen4 Genoa CPUs, for example.
>> And microcode architecture description here:
>> https://www.amd.com/system/files/documents/4th-gen-epyc-processor-architecture-white-paper.pdf
>> Although, the cpu frequency downscaling mentioned in the above document is
>> only in relation to floating point operations.
>> But from other online discussions I gather that the data path for the
>> integer registers in Zen4 is also 256 bits and it allows to avoid
>> frequency downscaling for FP and heavy instructions.
> 
> Yes, that's correct: in particular, on Zen 4 512-bit vector loads occupy load
> ports for two consecutive cycles, so from load throughput perspective there's
> no difference between 256-bit vectors and 512-bit vectors. Generally AVX-512
> still has benefits on Zen 4 since it's a richer instruction set (it also reduces
> pressure in the CPU front-end and is more power-efficient), but as the new AVX2
> buffer_is_zero is saturating load ports I would expect that AVX512 can exceed
> its performance only by a small margin if at all, not anywhere close to 2x.
> 
>> And looking at the optimizations for AVX2 in your other patch, would
>> unrolling the loop for AVX512 ops benefit from the speedup taken that the
>> data path has the same width?
> 
> No, 256-bit datapath on Zen 4 means that it's easier to saturate it with
> 512-bit loads than with 256-bit loads, so an AVX512 loop is roughly comparable
> to a similar AVX-256 loop unrolled twice.
> 
> Aside: AVX512 variant needs a little more thought to use VPTERNLOG properly.
> 
>> If the frequency downscaling is not observed on some of the CPUs, can
>> AVX512 be maintained and used selectively for some
>> of the CPUs?
> 
> Please note that a properly optimized buffer_is_zero is limited by load
> throughput, not ALUs. On Zen 4 AVX2 is sufficient to saturate L1 cache load
> bandwidth in buffer_is_zero. For data outside of L1 cache, the benefits
> of AVX-512 diminish more and more.
> 
> I don't have Zen 4 based machines at hand to see if AVX-512 is beneficial
> there for buffer_is_zero for reasons like reaching higher turbo clocks or
> higher memory parallelism.
> 

FWIW, this frequency downscaling problem that was more prominent in Skylake is
/supposedly/ no longer observed in Intel Sapphire Rapids either:

https://www.phoronix.com/review/intel-sapphirerapids-avx512/8


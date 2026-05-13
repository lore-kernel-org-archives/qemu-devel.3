Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69475CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAma-0000bc-E5; Wed, 13 May 2026 10:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wNAmR-0000Wn-KQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:41:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wNAmJ-00019i-T5
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:41:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D7On5A1161239; Wed, 13 May 2026 14:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=8dk3jcgmTtRrSV3SyQqBEpJeeRtkMfpMOa1zUJLImUw=; b=
 W+8cTx3GngU1qJncYt+2ZnhBHvravUKAFr57Cb1WsPRL4u0MMAIHuYQty0mhXFMv
 0VFjvoP6cHEoYDbYD0LHk6UM/7p9EE2/GcU/CYxn5Sh65B8umbOg4nmUTtgfPnfq
 lNMOlpQzQ9pwaRa6uEzRb5+8biBoDbkCUjpwOxw/lmeU/Rmsr9AVzo7dLJpO1i55
 DPadmx6fas/EyTseXeI5P1CptpJHDBWfF2lQ5JjWX23uwYFAuHKWyv46B+CtBle1
 NE33Xt3qIfaV/WFBDLFayiIipMr/b7WXpfO3u1kimiN+vnakmsqN99jOoqsYiGCg
 cX2eNq8wjVez0RS87ngwpA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c96sde0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2026 14:41:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64DEe2QR000632; Wed, 13 May 2026 14:41:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4e3neb1akx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2026 14:41:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjKLDBfjlhz72aQZvEhUGJ+3IiJ6mgW3kD/k6e2DA8S6I9SImtCz/l/MP2ZXk93mB9PlRDiSCYbXJ+A36ebRegOvqVDudwM4LRQhCZX1eLAV1VW5w648BHEwsDVTAvddS0jjHVq0+PTYUtBTyQEZdk/udDh5BlFl/A9OqaK/8x9Xt56lMLUfaKpt+AE6Hvi1KnpWL1D+uPl6lQ30smIKJiCzJgFVYv1SlKBHkFDB5HuAsl1PeFMKfKHTakgHg8BLFow0RnH7WShEBuxflBtE5kRTEwlFB/0aBaaTMPellXEa6SfyWPp01PZZnn71u3B/g6K63QC/a5/n30IVWfoTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dk3jcgmTtRrSV3SyQqBEpJeeRtkMfpMOa1zUJLImUw=;
 b=SBQvvWub29nSM5i82wOJn5Se2uo1ExFzKcPE5c5aFW8hG1K/sy0aan0IIMErw/cFLaTDzwFYnAwz4Jfb3q+sN8/DHkpnMkdblqub1gfHiK/xc/8ruohxnw3CxN4w+/SQLApXC4RC9N+OwZxUI+0rgRZFHHniqieuMlSOyvzvuN+MtciSgsY81VTg7vX+vocVrayC0KsO361KbBfgex0Oe2gdVLod1OKOo75mqiwKRXvoljqwP7hVrCTO8+D6x6rSPZ/rkIQHbwuPmULlfkZXl0P2NLVHCgw2byFmxBIhtp3NwDJFAo+T9tO7kdCmPUQMQHQ0+shZ7pChl7jAcH8vOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dk3jcgmTtRrSV3SyQqBEpJeeRtkMfpMOa1zUJLImUw=;
 b=LrRWyjn4wazt+6gHT2GSh6SIDj95hRLp7AjB5wND3pLSH7HXQJtggD95OGMFn4fBDJ8lvS7BymRlssLGLvrQgFFkXBWuYsXxq/KhiEZwoQideWuz0oLyc5SV7X23owjtHNwu7HSwjEeHLf1hdM0FYUgPgLvDPzZ2fBPXJR5H50s=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Wed, 13 May 2026 14:41:29 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:41:29 +0000
Message-ID: <a9c620a8-ebdf-496f-b9a3-fea046294989@oracle.com>
Date: Wed, 13 May 2026 10:41:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] amd_iommu: Update command buffer head ptr in MMIO
 region after wraparound
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, boris.ostrovsky@oracle.com
References: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
 <ddab5f5d-4f5f-42d0-a08f-c3e20ca20f84@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <ddab5f5d-4f5f-42d0-a08f-c3e20ca20f84@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:8:57::18) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 477f638b-de26-4145-3dd5-08deb0fdb7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RZeAgA1LCq+pPRbvMyrrAql5dWEqPx12y4xvRuv1JFDE2H5CjzQZraFDAfqJMClGhcQdAw3MX19zLaQkxLjAAJWaEm2xhc0j5K2CTUe3+NPCmORPPJUm9WkZfJCqnEe0S4BNU2EGOYyGogOMk346oHApZ3c6j/nYO0P8ocxUI00SRparCZw6Rq0/ySCvApr4+p6KP4IAZ4o26PTebrB86eja15Xp87a5QvOwWJsz4At1ZPSmoD7IdtrRqKiV1blRb7qNpSSHGsKwL9bQ5huT+0abcIIgQ/wrLBk2BYkLjvxNgy32iHAtXKG2PvzGse1XFtyz59FX4cxn14CzuifSBb6PQZZEQfZhk7Tq1/7Xbb4E1gO6ziA4CYcYMqQcHtIa3nzqBebQxktHfe4OTN+2R2YdS5z1AaTVj4f0Py9wed4vfjRn+9tUaUqzC+b7DH+JSYAtkM1cEGpxaM45RnVHRGw//qmHLvXIKjVk4QIHT5gT8zXQJLLs8l4Kq5nnTa7U1p7b4DFRemikDnylCz25TIgVIGlSLGipizMxJGST/ql9XEbvVpPDPyWENCVguDkgKPqLyZsjZsb0W53BNXPSo9rHAF2h0hm9CmsiXLWvEtnpFVR3Fr88+SVmjM37Jg8pqSExAa35UaiU8WnYb1oP1sS3ncfb9ROGgFsLeIyMYlWN7rMo3wumu1N5xsbacy+j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZQTUtKY1V3UDRLWTVjdlVsZHpTZnJqM2V3TEhmT2RVU3ROZ2tJM0VnTUg1?=
 =?utf-8?B?bFd3UVNMTFdUZ2FQTWxNbENsSXcrUzFaSHR2Q2M2aTZYUWxrdnZvZDlJd3RX?=
 =?utf-8?B?NUJCNDEwV0RST0JTMUNmVFd0REIrcE8xNUpSYzdSbXZzT3c4RGhVOUdPbGEr?=
 =?utf-8?B?WXl2aFl6cGw1YmVwZ3lmeVlJclIzaU5abUFNRG5DMGpLcENFR3F6bWpmKzRU?=
 =?utf-8?B?MWtaTXlISTRURXBObUJwUG1SWTlOOTBKL21CcHovN0JlZWlhejI3S3dINlM3?=
 =?utf-8?B?Q092VU5vU3VydzNmbEJLempaNDd0dXB4cVhkZDQ4N1JUbjZYZFBFS2pYV2h0?=
 =?utf-8?B?VHhWU1FSTVR1cHc5NGZYS1MwazNWNWdJSHNwYjBYS1RVUjNZNSthNXdVaHZj?=
 =?utf-8?B?SzljV0xiQkJOdFdrdWF0dUFwQkRMWno5MCtISnpaZGVxRW56YjRpS2dOcGZN?=
 =?utf-8?B?U3dmcTFJSE9FSFJUd3JmUlVTZm5yc2M5cmhtbVYyN1BjSHVIOGtTS3A1SFAy?=
 =?utf-8?B?a3VENHIvVVJVUmlRS0d4RHBMZFdCN2Y2TGhYKzZaZjFLbWhrNlVwSnpidk5j?=
 =?utf-8?B?RFczQTE4UEwrNTdkS1l4dHd4RnJWaHVxMU5PRmZTMzlDRzNSUTlOeGFBRGJ0?=
 =?utf-8?B?M0JvTGpNdlZILzErUXY5OWZiTGszMFdrYWhPdDVBMUhoak1wdStUbnNJbjNN?=
 =?utf-8?B?V1NUY0pXSzhYTlJWYS9vWGFwci9KSzFxc0xOWXFvQ1pLdU9wSzRJZFN5ZTkv?=
 =?utf-8?B?aGE5cnRMOWMrSVVHdmViUmVwbVZ2cWNxZWpueVJUN2E2NEpLTTRyemdsUkw1?=
 =?utf-8?B?RXREdXNDa3pjL2ZOY202Q25GUldXbW9rUXBvQnM0N0h1V3NCSkNBZnRzckNG?=
 =?utf-8?B?YThYc1V1eUFidTFKUVZaOUVoaFVCTzNFK3h6dG9uUy80Y2g1WUxHdzcvem1Z?=
 =?utf-8?B?QVBNdmtRNmxkRUtjcDFtZEJjS2JZZjRLSE84bE4wNVE3cE5hM1MwZkNhL1V6?=
 =?utf-8?B?UnpkaE1ZZ3pjS2M4ME1tcy9QbEd6bjVuREE4a0pEQXhEamdndE9GemhlTjV2?=
 =?utf-8?B?Tm9NeHNuaXpiZU9YN1JkQkF3NExneDJ1KzNxZ0t0NGdIdmQ0SEVlejZ3Mmgr?=
 =?utf-8?B?dWhiV1YwYkxVaFNrR0lnVFJRSUI0cjVneUswaE5HNGFCMjdHMk1rc1BnWmdX?=
 =?utf-8?B?YUJZVm9TLzlMd254Y285YnI0eml1NW82NVcvdnlyRnRCdkxxK0s0dkIvcXZW?=
 =?utf-8?B?a3dDYTcwU1U2TmpnOENwV1Q3QWpmcXFpTm1HaFo5RktJNUk1QzhsVi9sTjZY?=
 =?utf-8?B?UCtBanNsM0VzeDVyNDUrdCtpR0sxS0o1NFMwYXAwRDViOSt5bWF4Z2o1NUZa?=
 =?utf-8?B?UWhHVFBvZkZjWTVwVXhvVU55dWRmZ2xlN3B0NE1iU3lCRTVnRHZqWkdRdkFa?=
 =?utf-8?B?d0Z5dUpXUkVsK3AzbHlxT3F5Q2tYMHA4bXFERkxJcHQ4UTJ4czg5RTNEc1l3?=
 =?utf-8?B?am14dTI5Q2Q0Vysxc1BKWEV2ejE5VkZJWjlSem1DWnNFYmQzSzh6bnk0RlZn?=
 =?utf-8?B?UC91Q0E1bEdpNDlTZlkvZjdVL29OWTNXMWkvS3hOSlY3N2xrbm40NlZyMnkz?=
 =?utf-8?B?Y1Q1K2lFbjZnaldaQ2poaHUzU25KUklDZ1BwdmJZeGdKZVZuUmU1T3RUUWto?=
 =?utf-8?B?VGd5TWVVN29rS3JzZWRxdGdrSFg3K1RiZ29zRTZZQnJBSDJWNkRxNjdPK2NY?=
 =?utf-8?B?Mk5ibURLcGpHRmpVRU9OQTJ1WER1Wk00VTBkNFp3d0FqcHFvS3RqbnBqVGpC?=
 =?utf-8?B?RjZ1WUR6ZzNGbnNFdU5WTytGYmJhdUJHNDlUVXF4RjFSOEFxdDRxQjV6MHZl?=
 =?utf-8?B?eWYxVmVPMTkrdm81ZnM1eUE4dlJRYU4zRUdkWklScWxPZHB3eVBRZGpEY09L?=
 =?utf-8?B?cGJqOHFjOWNiU2lGWmR0eGcwUWZvTHdtWTdoTUR4SVF4cFV2RkVhUnVMaVJz?=
 =?utf-8?B?WHhNQisvTWVsRlFTOHViaGpBQXhSTUJjb0VWYnBnN3djWGtBVk5mVjUwbXdG?=
 =?utf-8?B?UG9VTWZHTDBjV01xcjIxcnRMaldubElCelJkbllvS3gwT2JpdHdHb2JJeHow?=
 =?utf-8?B?dDY3WllhNmJKUUdZc01obklrT1dtdkdsR2pmZWp0RjI1cGpWSDBpLzJrbjZX?=
 =?utf-8?B?NnlzdzYxdmxDSkYrakZlSTM1d3VhSmthQmNUU1hSclV0REkwK0JZeDQ4RS9j?=
 =?utf-8?B?OHJ6U3hnVys4ZGsrcDJKM3J0T2Yxcm1mN29aNko1cmJGejgxY3h3YW5jZ1kw?=
 =?utf-8?B?YUpEYkxYUkhPdXZaVGRIS3U5dHVJS2MxNzJtOUZRVHZBdVNuWU5ja3NObFlp?=
 =?utf-8?Q?IPWw7OGyUd8x1/TCaY/wUpDfQpBwvZR00TS9C?=
X-Exchange-RoutingPolicyChecked: pXH9IMUK9bYGcMpI2uIpYej0TFZA3ucXDSWQXvxQ4RE1rFN/bQCQ3I5ukNPvypBD3lfXgzrYvkP+5pcGDju5ZAmv6OFmW+K6PHEVJGIePtXG7yyB0neRDD4PPBsfS55DCdCGLN4+9ZlxkNVBo6fp3wgOwXS5ekozex1byjT7Hbl+UvohF9tbpuwIW2ThVMVM7I/K4v/H2lwYLJqi+UcA7sOsb659/XrdaKCKSc/VtLwlVOr2cFvd60tDqXpf488GE6GP7CyQgfzqXWAHJAdSQi33C4SMfsbaY0kLZfVDxPcSPQ2biEe1yWh4N/RnNocZgD4+2MwPSMbIpVYw3rCcLw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1IcWdVwXsdxIDTEobcDWiPsDmIG/Es9V3/k5MYX/HjpAENi+CTjmy6xs4yaYnXoJ0Y8jgQC1sfm5nWhlZwm8QQ2Bem4WxlNoVk+nTHgfzZfLLroXiry0nyYi5ctbyMDiX+D+A9ecfkuYk//i+L4MLC5Bit+BT8J90c03CAqWxSL3hM2ZcfhmJr//jf5HAQII6W5FgU5TDkfLndhQ0urmw1FAVbokjG/m2RTCRGII2msBlwnw1gLMPlkDkAy5MD7vAUUG1X3snU7ReELgCQe8dEil6eY7adiSvmGDsnXG5gUeKk3sb18Jmuob6sI93vhju/9ZGx8dDdyVhFuN2AvYYg+xg0TDPV2gxuLMlRtc+ECss9DE1qyIXlfqa6uYBGUSBBDD8xBMY08XrhJsIO2VkZ7BZg9ew3JfzjEJH7jtK39gitsZS1/O5BnVtTvqPL1gA6EYFlVzEB5mJ4Nyu/957qNOeYp3GkhbZnEexyAxhPuNUyioI9+oFaAuFKu5h29EVO0FH67gpbNJo42GriAjbF795BluKYyBklqsflPkXJawTgPPadYOqBY/GOyJptnM6+Q6slQdgAOEzGysIddMAumRP6ODL9uU5NK52tL6gVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477f638b-de26-4145-3dd5-08deb0fdb7c3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:41:29.0880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKoCqsfDL6IBha5PQ3i2RN4dDL34NyCAxpcS9t6grJyeAlC+bwgx5s0Q/Fc8VnCJk6RvJdjcgMLktMrwHWYuK38tQN90zVp57RwyjhIcJr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605130151
X-Authority-Analysis: v=2.4 cv=bbRbluPB c=1 sm=1 tr=0 ts=6a048d9d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=69wJf7TsAAAA:8
 a=yPCof4ZbAAAA:8 a=LnwIXhpDbUKNRIMPMa8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 7SojgWu2774ZiBp8ufSfZy5mGiwKi3ji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1MCBTYWx0ZWRfX5EF3OZkIzrUU
 2buiaHEBd2dNhiASb6s7W4pf6zoF8vvcND4FLWoZ8eDORUuTeLd/i0ki9NuoBhJzz0FkLtQnKhn
 F70brIxt+7pXHNeAXDYb51TTOwNMWpZsr2F5PO8ooSMkbwtF/faeioTiLqZV9PW6ClPiX69hNyG
 JVI5RMTd81Aeytl64VXskLfKvLnjNtZI59wbfkuoA2xVGlZ9zR6BuP0aWoexmdVW0+5DrhYl0Dr
 o7eUAaKaK2yYmRQaVAD/yUWKHVyb8BAue8qo3E6EsKgrDEA3ln8y8eDJJEKhd8Ek6eDLNBBSFxB
 YqQNNuPoYOXqUFlq3lLSI9Yrhn9P50XGJMaH4ZJkZoRhqefwTL+yOfMXxlgwKdyB+3yb+0/VRXO
 IHQ2hrRVnhUDvSJGFZmAKSJ4Aec8pJjOU50nvCTRvzoWEDQ+IQAweqP1+gI0kkK9f7WgeegbtyK
 kq+pqtF/lo9cC+x5MDA==
X-Proofpoint-ORIG-GUID: 7SojgWu2774ZiBp8ufSfZy5mGiwKi3ji
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/13/26 12:38 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/12/2026 8:30 PM, Alejandro Jimenez wrote:
>> When processing a command, amdvi_cmdbuf_run() increments cmdbuf_head and
>> writes it to the emulated MMIO register space before checking whether it
>> has reached the end of the command buffer.
>>
>> If the incremented value reaches the end of the buffer and the tail pointer
>> is zero, the loop exits and the COMMAND_HEAD offset still contains an
>> unwrapped value. There are no errors in command processing since internal
>> cmdbuf_head state is always correctly updated, but the spec defines the
>> CmdHeadPtr field in MMIO Offset 2000h Command Buffer Head Pointer Register
>> as RW i.e. guest-visible, so it should be kept consistent.
>>
>> Wrap cmdbuf_head before updating COMMAND_HEAD so the MMIO-visible register
>> always matches the internal command buffer head pointer position.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 197e452e3c..5d6a405263 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1475,12 +1475,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>           trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s-
>> >cmdbuf);
>>           amdvi_cmdbuf_exec(s);
>>           s->cmdbuf_head += AMDVI_COMMAND_SIZE;
>> -        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
>>             /* wrap head pointer */
>>           if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
>>               s->cmdbuf_head = 0;
>>           }
>> +        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
>>       }
>>   }
>>   
> 
> Hi Alejandro,
> 
> Maybe we can clean it a little bit by using modulo operation
> s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) % s->cmdbuf_len *
> AMDVI_COMMAND_SIZE; 

In short, I find the "if" code easier to understand.

It keeps it readable and avoids a number of potential issues. e.g. the
approach above using modulo is missing important parenthesis around the
second block:

s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) %
		(s->cmdbuf_len * AMDVI_COMMAND_SIZE);

even with that corrected, it could still break if changes in other code end
up setting invalid values in cmdbuf_head and/or cmdbuf_len e.g. if
cmdbuf_len is incorrectly set to 0 for some reason, then the modulo
operation has 0 as an operand which is undefined IIUC.

We could also use masking like Paolo's recent patch that inspired this change:

s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) &
		(s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);

but I think similar issues as with the modulo apply.

Out of curiosity I generated assembly for the two cases and for the "if" it
uses:

cmpq, cmovnb

while for the modulo code it uses:

divq

So I think division might actually be slower than the compare and
conditional move.

Alejandro

This will eliminate the if condition. Thanks Sairaj


>> base-commit: 8333dba7326d89ce180221c4d0c6d34826a9a4a3
>> prerequisite-patch-id: df656299f90e928acad39d99e3701c5641e972d5
> 



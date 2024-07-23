Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EAFC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGP4-00022v-Ip; Tue, 23 Jul 2024 10:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWGOy-0001eg-25
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:22:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWGOv-0008M8-9G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:22:03 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCGPcA007003;
 Tue, 23 Jul 2024 14:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=MfHktpcujIHHoVW7QDkGlY3y+pG0KL4QTq7EcPTDjrk=; b=
 hK0c/1IULK9kDgkTmeEQr+gAWfiKLiZFtqU6As0RwSgdTvPXc53JWhGrhwnGezjW
 q8PuZbv/mOP+vLQ+hWvX5KmYjjeJn5aR2RkWEbVBnsxf6L2aWyUNfXnKmxGdsi37
 0kvlEnVKrQFsWgAcPZ3/OHqRB4sDUaQyM34Do8c8wmb1Bz8M4NiT0qDvYRMCqGU+
 +77QBBzCXfCR+2iaFMfIxhbbJ25ZCY3tFS0a05W5oAZoBG/fC0v4q+M/DUzqa9b4
 Yx+kwT1jZXILyu1ix4Ys3NoOci7T2XJHI0WosnTzGiRmRpXZ9ejWSFIvUmc6mqd2
 UJBjJVK1OS022FTasLV9kA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7etqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 14:21:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46NE0Psi010965; Tue, 23 Jul 2024 14:21:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29r8rkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 14:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPdfNbmGzT0316gIesiNvzUlZwbWyDbefrCt+SwbShSBVQn+nRH+3u/7Fjs0slYvvq27qCgmAQeIObKpGngW8yhU/b0lvYXcJiEnIJNkHZOoDI2vyLr6U1hjLO5orbXa5U8VHeZe3iPfA4QSpYeoNmiuwnpiRNeEwLd8Z8cHk0Hw50nCPXrJ7z4IJmunOUCNY/Dkne4NkqyU+ZQq88Q4ytmBRCYlr+m4X+0+d1r8E+ZoQNpcuk7qA2+uv+TXRVPozwNIXlyFck+wFMXWSEZ6Gv21kaYNq96rOGpdgXGfWteQnFgcx49AcNWJ2ozLCba9YYNbYZtRMLnNGO0MZw4kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfHktpcujIHHoVW7QDkGlY3y+pG0KL4QTq7EcPTDjrk=;
 b=W52vsHEAPHkPQBQrURp0QYwaYgBCoNU2PNleLdU9a9NHFcGIixGGMy3E166PkAnLixG+xF0fFHMUVtYFFQluMwFXrBwoBpjrFEL6Ti364jahLnpWLri7jtDKjwpQYm3t22cdBxynroyhWH/DW+SZ3fy8LKiTE8vLhf3SPj5cZHovjj7yaucUsX695XPJAHlytiLgkVqHLjh+9EVXxH7ktbcGAAEjxAszJMdttHpbYj8lMLKT40Ff4lxO5fCLk1KlkGuCmxbAUadCIDZNd7Oe16gErLT80F65AI1E2wZ9SokNp8uaZyuVKQgUFtYPklLPOQr6kPaNg/xr4zo3cH7kvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfHktpcujIHHoVW7QDkGlY3y+pG0KL4QTq7EcPTDjrk=;
 b=Q/yJC343bHKjtNV5Vz9rx3bUM76pioPX/hkqFPKR3ZfPXukCtb9Ycb54u6AXAOMiJWWQ8GurYnorLzZg+v9k5TsMGChIKauxNiUki2cr8uHNN9Va2RVz06ZkdUGkGI/EiaQsm5EA1MuhNeD0gvdOzSJSXI0M5ZGh6DerIxFc7vc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY8PR10MB6682.namprd10.prod.outlook.com (2603:10b6:930:91::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 14:21:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 14:21:54 +0000
Message-ID: <8cc8f218-a304-45b5-ba95-c6e45115e135@oracle.com>
Date: Tue, 23 Jul 2024 15:21:46 +0100
Subject: Re: [PATCH v6 0/9] hw/iommufd: IOMMUFD Dirty Tracking
To: Yi Liu <yi.l.liu@intel.com>, qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <de5a8b4d-7a3f-4957-b76d-9bb11d8d3de1@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <de5a8b4d-7a3f-4957-b76d-9bb11d8d3de1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY8PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: fad1c848-06cb-4f95-7033-08dcab22cd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUlvQzBBcUw3WUdqUjl3V01MUHlsNmpheC9YL2lNaXpCZTVCUnhDcEF4cnp6?=
 =?utf-8?B?Uk5VWU9HY1NmY2Z1TTdDbkdDenQ3RGkyWTZ0NmRwcnVEbEVDKzd4RjJpK0Fa?=
 =?utf-8?B?MGdoV1lOTzdTZ2ZBakdlVzJNUFRwaHA3c2UxQXlwSEk5SkkvQVRXeVJoVlhm?=
 =?utf-8?B?R3ZBNHZLQVRDWXQwYmR4Qnk1cHdPdFM5TjlKdUhlYVVoL2dvRGYxVWcxWlhB?=
 =?utf-8?B?MkluUTFQNjJhYjI3NUVJaGswTDllZXdPYndMRERmUkJGVXQyaHRhRXB2WWdm?=
 =?utf-8?B?ZHMrVXpTZ0ZnWUNJWWFoNXF5SHBoYnVmb3MvdkJ1WUxRL2ZLL05XYXIwcTN3?=
 =?utf-8?B?VVNPT2x2d1hKWGY0VlRJNlIwVkxpdG9yUUVWdU5mNE12RXBqbXMyVlo0clhV?=
 =?utf-8?B?bitGblRwT2doWkI2eEVBckcrS2FMdWs5Y1o0dlA2bVFialRlZk1xcjdOUHgw?=
 =?utf-8?B?VTFJR3lPeGMxVzl6K094OGMvOGtJc3NNdUNGeUpmTzBhaDVHaTM5Tzl2Qlhj?=
 =?utf-8?B?TFZIQVgvKzJCdE0wTzEvazJRVjZ5VEJVdlhud01zRzViNVE0aURYWHRFckcx?=
 =?utf-8?B?RjE5cGdGOStnTzluSDg4SFNyQUlqUUs1L296bUxVdk56ZEJJamxZQlduVlll?=
 =?utf-8?B?KzdML0poZmxBMEhGbTBZbjA3ZW5CRldyRHk5THQxeEsyRlpKMFUyTXpta0la?=
 =?utf-8?B?WURpclFjVVN6UCtCa014MTZwVWhsRnJ1d0RJempEL1ZydndUbStOQktuelhN?=
 =?utf-8?B?dnN5UGMrempVVmQ3dy8yTENOaHdOcjN0a1U3L3RWS1ZxbHlWL1FVc1lKVFN2?=
 =?utf-8?B?S1hsNHB6M240NmhTNGJIQlNvUG1aeFRDRWt4blRXcWtkSzR0Q0tpMGpCRHNT?=
 =?utf-8?B?aGQ5eHdpK2xwV1ltdms4MkxiQWhQVmZjb0g2RnFpWUEwS1lVaEhac3M2V3Ft?=
 =?utf-8?B?RVI5MHRQTTdIY2d5REwvRGFmZ2NRcVN6WHUvbldhcHVKRzdoMnIwR09ZODlj?=
 =?utf-8?B?cGRYQkRocjJFMTB3cHJpQ3FURlVyOThjTDdTeHV3cHVUcnp1MmRCK25iWTlX?=
 =?utf-8?B?dDllT25mZncvVDZyUjR5UzFHMVMwM1l6THUvVlZlWTVpYXM1RHlNeldZSWFP?=
 =?utf-8?B?Y2pQalVMRy9scUtGVWlGT1ZkbVlZSUtTQzU1NGQ1VUk1bVdsY2xLcXM5VkJ2?=
 =?utf-8?B?MEQxMEM5SXY2MVZMalpPQ2pJNmt4MFR2VmRKMHRYV09hN3htb3pPdEgwTThL?=
 =?utf-8?B?Qnp5ZVVFTUVaOVBMbHE1L2FNcUVaWndFTEpYYjh1WmRJc2E4NWQ2SHVjL2t4?=
 =?utf-8?B?UUZTQjFtZlk1aUkzWjN4dHNMUjRidjRIejBOc1AzS2tXRGFwdjRPNzVaMkxR?=
 =?utf-8?B?THdRcjZSSjlWQmpOQXJaQmdFaHJadDhFSzVUc2dtNVFKUUJ5UnV2VE5aSmQy?=
 =?utf-8?B?NTUzblV0UUFPQU9JMEY4V0ovWmxhYUJZRkdRbU8xY2FuWjhHZC8vMzU4TDFj?=
 =?utf-8?B?Ulk1MXFKOVBCdjFUdnNuSHByUkZKUXVqQW1mbXZFM3pIZkVBVTIyTTJPa0RU?=
 =?utf-8?B?Y1VoZXhlMnhFNFZXQVdocEwvTHpVR1ZqZjhpNnFvMDZub3UvMFhERjg3TU9W?=
 =?utf-8?B?L2lNNmx0OFJsRGcyMnFzcXJ3UGQzMkMrV0hxYTVzMDRzZWpKbGFjWUtXZy9O?=
 =?utf-8?B?RkpQN1NPS0FLSWpsMGl6WHFZUFdJNlRGaHRjSUlPeFFiSUlnVkEzbDBBY0dO?=
 =?utf-8?Q?2OHHapcbVjTiZ+cV5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21KNy83U1J6NXJRc3VaYTE1UFVaUEU2NUY2U0RUQkhKTXkyS3VRYTI1S3JF?=
 =?utf-8?B?b1NkZFA0Y0t0MkJEZWxpM2hjU0NQRnlJV2JUUXo0aGtRYlVmb25wZldEZnBM?=
 =?utf-8?B?U1o5cGFucjd6V1l1QXhESjJTNkNwSUM3aVpLZXhOSC9ZV2J2VmZYY1Uwc2J6?=
 =?utf-8?B?WXhNNnY2LzlXVkIvejlUVGxleWRvYmZtUE9nV0IwMlJPcEx3U2hkZlBBOWtO?=
 =?utf-8?B?Ui9lN1J5Si9KMzhTcnFsYVBRKzJEU0RaS3ZQWjNZNE1FSUIzZTloLzI5SHJP?=
 =?utf-8?B?Um9XNzF3WFJzR2RUNktqQ2VvVE9mYTBuZkFhanZtc0pTOUpUTHg5UjV4SkZv?=
 =?utf-8?B?V3ZUL29vT2o3VlpoNmdxOW9tMDg0dXFLR2NySHBlamVaRzFtVDhmK1Z6M1Rj?=
 =?utf-8?B?TGtrNmoralJ0KzBuWWNlMTFFejRCeDd3bytGNlJOTDZENnlHbGl3MzErUVNS?=
 =?utf-8?B?L2pZcWd5M2I0SkRFWFJSeUwydDJUWWQrWFA1ZWVpYi94QnNGNXNIU1hEeDdo?=
 =?utf-8?B?aTBDZzRNUk9vYkJiTkRscHRMdHY3RmFvc3F4M0w4UTB2QXR5ZUNncW9meUVH?=
 =?utf-8?B?SUN2enBaMmFFTmJ0SStJeEh2Rzd5Y2xHOTVUelBiSDBWb1VqcEtDSC85d2Uz?=
 =?utf-8?B?L2ZmL0VzcEZCcVF5MHdBSDMxY0ZodXhLSmlHRm50SFZtSTdMME1VQm1ZcEhx?=
 =?utf-8?B?N1g0OGFRYTlZRjRCbXB3OWxqZTkrU29JalZ3c0VlamtFQk1wcnNTWVd0cGFU?=
 =?utf-8?B?TzNPbTFzUzQxR3pVU1Nlandxd2pQOHhVVXBqUlh0MkxWRnNnZUE4YmVqdG5l?=
 =?utf-8?B?YUtabUtlaTM2a3VGZk1naE5XZDVSRUhMcU04UVo0TTg2ZzdVU2daaEN1aUtw?=
 =?utf-8?B?ZVdxZFBXOXZMRmo4TXQxRCtOWWVDVXI1aE5KUGJnVGY4Y2lDa3FDeHNDblcv?=
 =?utf-8?B?blpVZHhvWGlSMVJtT09IMEpoZWpTT0s2TXBuai9ySDZnWXF4UXhGallTUFpv?=
 =?utf-8?B?eVhJVStFb0k4SllhbEJRRkZYZm5nbjNISGdXcWNkTXVMVS84L0ZsK0hENTBn?=
 =?utf-8?B?cmlOYk5RbG1qbDNtdmI1OStSNmVZVFpPZXFNQ3phYWpZVkRodG9WNzBUMTdH?=
 =?utf-8?B?c2o2V09yUWJUV2d6ZFFPTEhUQnBpWkhhdVRtd3dNVmpmTUkxVld2d2QwSVFT?=
 =?utf-8?B?MG80ZURydm13ODBMdDhSaVo4OW1VUEp5dHlUQjJKdUlpY0FnbkN4NlBIUmRx?=
 =?utf-8?B?RUl0TllBNjRSVDhJeWF1WHZObWxTbVF0WlFGcTBFN0FXdmJnRExlY2NWS3do?=
 =?utf-8?B?WWpxR1QyY0pIWEM4ZjE4N3ozWHBhL0lVUDVYVmIrYVpBK040YjZJb1VZZ2Ex?=
 =?utf-8?B?dzFVS3R6dGN0R1ZXajdEOStQSXFLWjFoK3FLdzNvRXpNSHduQWFka0oydlJs?=
 =?utf-8?B?TWlpZkZUVDNaazVSKzV4VkV0dkRTbVdkYmlaZitoWUpQZ1JPRUNzakUxQW5E?=
 =?utf-8?B?ZlpETDdJYjJ2S0sweHpsN1h0NUh1MUdhT3FhYi9SYStRTEYzMXJhUmZNVWN6?=
 =?utf-8?B?RVp4N0JaSGVod1hQS2Z6VGk3NHZSNGNHdTNaVVFXeklrREQ0VzQ5SVVNSnV1?=
 =?utf-8?B?aXEvWHltcVNMd0RwdnFPRXAwbG84S295aTE0S2pKOUhvWnFIODNJeHZ2Q1J1?=
 =?utf-8?B?S1RkUUlkd1NGZzRBU1JXL1BBOW5xWkpUc0JRQ1hCcithOEs0eUdGM25VRVdp?=
 =?utf-8?B?aDZtL0FUbjQrNS9ab1FlTXVRZ0QzZmYvenMxSXVXVHBkN0FSeXZ0bi9TSHNl?=
 =?utf-8?B?WGJBdFVwd29mS3JNbEhKWmdGa1hPa05tcWRDZ0FSVGlxVStacWphKzNmNHZ4?=
 =?utf-8?B?TkJ1WjR6MlJlK0dyRVZ3MjFUNXNlR3ptWkF1SUU1YWlxdldnZndYb2tRT3RE?=
 =?utf-8?B?Q1Z4OWFpOUZaV1g3cmhZU2NDSEs2VjU2dDlUcXdzY0ExZHhSY3pndi9Fd0pC?=
 =?utf-8?B?WkN4eHBHaTI3UHNnWndDZ042N0lHUU1ZMWVEcGw2YXRsaVNERmtRQUsxMGVL?=
 =?utf-8?B?QmhGSHR2V3BoVnpTcXlUY0Y3M1FxQXdpcU01dndWem92cmxhTmxoUTBXVmNV?=
 =?utf-8?B?UlF3ZzdMNkpOOVZrSE1UczVzQi9aQU5xOWFjUGdQRDJDUWprMGlyUS93SkZv?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sNDLoTOdnURMe16B3Cel7Y+lC4PFdxcfSMsJ26hKCxJaeTPL1cIZkTYLaV4VuaBCHu3YYgM5zvyx42xBgLg0r5np80o/2XZR6fF2iuYzUT43HYif+tnqKaFjWPBosQ4BsHoSUTQ8/6V/186UomnyDNdjZNqP96PvBh5cFl3db2v1MBx+eV02eQ82ZxnNruxUhspFB/chjGXY8VkkhwqI+D7DgQvPf5+EOadVP6EXrVNYxlIIn8PAIqNzN0e3JYpLf6fvj9tZAEA8yrFDVnq6xxql7szjZu4LaiCffSHJzF2hxjuOhidw64Xr6XFJuNMDcN52LYOB795uQ2QSeF5bVtlUYJ151EPzQlXOUX3SnOaBLqoMxEaNzEY+7ifP7nq7cwI+i4S2VAuFKse5M3OEeRK0UzLpmooSfBbtVE/FE6dmQ4DhxMGbvL23Dy2RAdSnTjJpO4dEFYm6k8WYJPQx2lLI9G27XGRb+JVE+wgfu7MFkSjSLVQ/fld6HcLWx9NQi0TPsH7MV9LMXM9ulOAbLw5wDulgZ1Y8hN1AEMdHx4/nSn4Tc+N1+BGq2AWwXKch1usX3uFoYFzBa+J/5gBXCH7qnYlbZbIPIXxdE7m5spA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad1c848-06cb-4f95-7033-08dcab22cd63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 14:21:54.5832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9YNOYVBFNPDztsmKa1+Vmj53rfbMxUl6d+3J3TyaTDxu5vGtgoWP7oGixN5zsQIR4Yd9Zvm3KLt0RcJILe178UUaZ8HspiINlDXHuMjf6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_03,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=985 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230101
X-Proofpoint-GUID: EeGgsXw1o-H6Pv4P6fsO7ERlVDDyxB-C
X-Proofpoint-ORIG-GUID: EeGgsXw1o-H6Pv4P6fsO7ERlVDDyxB-C
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 23/07/2024 15:23, Yi Liu wrote:
> On 2024/7/23 05:13, Joao Martins wrote:
>> This small series adds support for IOMMU dirty tracking support via the
>> IOMMUFD backend. The hardware capability is available on most recent x86
>> hardware (and these SMMUv3 in upcoming v6.11). The series is divided
>> organized as follows:
>>
>> * Patches 1 - 7: IOMMUFD backend support for dirty tracking;
>>
>> Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
>> we will find and attach a device to a compatible IOMMU domain, or allocate a new
>> hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
>> workflow is relatively simple:
>>
>> 1) Probe device and allow dirty tracking in the HWPT
>> 2) Toggling dirty tracking on/off
>> 3) Read-and-clear of Dirty IOVAs
>>
>> The heuristics selected for (1) were to always request the HWPT for
>> dirty tracking if supported, or rely on device dirty page tracking. This
>> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
>> tracking even if we ask during hwpt allocation.
>>
>> The unmap case is deferred until further vIOMMU support with migration
>> is added[3] which will then introduce the usage of
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>> dma unmap bitmap flow.
>>
>> * Patches 8 - 9: Don't block live migration where there's no VF dirty
>> tracker, considering that we have IOMMU dirty tracking.
>>
>> Comments and feedback appreciated (on patches 1, 5, 8, 9)
> 
> Hi Joao,
> 
> Do you have a github branch for this version? :)
> 

No, but you can probably use Cedric's vfio-next branch:

	https://github.com/legoater/qemu/tree/vfio-next

... Given that he has just submitted his PR with this series.

	Joao



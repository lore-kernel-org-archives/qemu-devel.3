Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9050CEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 19:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so6Z0-0005Xr-GA; Tue, 10 Sep 2024 15:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1so6Yy-0005WC-EX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:30:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1so6Yw-0007hz-2E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:30:08 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNaOJ023332;
 Tue, 10 Sep 2024 19:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=zQtcIUNOWuQa2H/Xf2I8rI+LuolBerwxWWSw5Zro6Y4=; b=
 IdJCaOG3yiYXgKALBZ9EN6j+YKxML6XUaJprJ1TYfcKJPzPrVjyTux7JRaPch6lh
 Ak+Jyc2YJZ+1E6h8XU6cpD+sGqrCvplLAaigiwqcLckLCg6M+QYrJ5LbwnX/nMp8
 rl157IuRiye0KOYO/aBvUjosyfEjembYaosOWCagHANhoyf1m93Lwes+IL00UcrQ
 jeIpemN32erwW4/HbInOlzHLM+DKrKrUuI5hhvw906ysezDBhlNtL5TUIpNAHwqs
 u1cnQL98DXY5FSuocLMFJx0+rk9k2U+LkGx+DaUJV0SaL99tePNN45IUKZ2pF1Nh
 GdE1bagqa9seMy27J4oggA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcpgpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 19:30:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48AI9G9C040796; Tue, 10 Sep 2024 19:30:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9agjkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 19:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nldwjKbdGwd3Vd9h/Nq3L2TdHlClKzGPE3p8jK5CWbCBAgN+r3qgeyWoRUJddhPRjXC7dbY0WsaFhY38Q8IM5CTMJFlwmUMJTcVHEFEpO0fh132nzf6eDiZbqHUsy87fcQ9lxwfL6ZMIp0eJLyN9uYmNPDPQ/tqP2dB8yZiUvOtcTfb7vH3cJz29RKe+yk1bZDyFTop1aP1CziUocrWn1sBmBETWDp6VkvHysqkYaQkTBSxuFYjaMiVy0twyrXOvmuYPr2TTLId4bUJ5g95b9dmyqaBVkU4ELWRkY2SI74Nh94PUMfj4mLmeH71hNSAKoKLbFZJFkzeeiA6vEhHJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQtcIUNOWuQa2H/Xf2I8rI+LuolBerwxWWSw5Zro6Y4=;
 b=LFht0k6aiyGO9U8T1fDsVM8301vWnSYNu9jYO0PTdMLFBnqRdx/votfiOUaTOE4OxRE9N3J6/tIajo3BqR3AdPeWYSZehtFHHqNLg2mESlOEQH4QZ5B8pb9NU34kGZ6NmQfYeAiz8PMu9+HRvdzOBGZ+VZ4TXyeK0bE2rZ5mRoSv3ALMrg9GoSM8Vn9PpZhXMlmQc86XLPD6uswgCSjevNPwf2VDy/+VcR1n9x7x1VIjCjEP6x0BmgMwoz79FAh7yssFoPlmx1JLE9QmYeH58yvSBS3cUyfq1p534xea/9BF69YdPRHjeIHO8hu7WUCPRKA1LdXVofBIj33vZuy4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQtcIUNOWuQa2H/Xf2I8rI+LuolBerwxWWSw5Zro6Y4=;
 b=NoXAXrGZt8ELlkpy+4m5ew0eJ4qlErnO9ImaneMf2IdOmC0/CvAovnAEHPCrsMrh5hF1pR2O8SbXsPXQGhddQcbmaA6o6HT5TbwUUdCbTPygqbD5pmZ4kx/lFAuweTW1kYLikbjdpjx071hZUGIGxxvuZh7oZp1xAln0p8FlFqc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV8PR10MB7990.namprd10.prod.outlook.com (2603:10b6:408:207::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 10 Sep
 2024 19:29:58 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7962.016; Tue, 10 Sep 2024
 19:29:58 +0000
Message-ID: <73f10bc0-5e3f-412d-8e2a-44d013c4b7ba@oracle.com>
Date: Tue, 10 Sep 2024 20:29:54 +0100
Subject: Re: [PATCH] vfio/iommufd: no hw_info for mediated devices
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
References: <1725990021-107183-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <1725990021-107183-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0016.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV8PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 2594d65b-4d73-45cd-5953-08dcd1cef4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzBxSVp4SjlNV0drVVYrMFJ1clJScUZBUlN1Nm90aGpBbXBjSnVRSDJMOURr?=
 =?utf-8?B?clpuTWxBSmF5bDZWUGhhay91eHhHZS9udFNPUElrbzYzUjliRjJoZlNmMGM5?=
 =?utf-8?B?dzEya05WYkJ1YzZjdUcwR1o1aXBKekp3ZEZCa3Q4Q1R5dG5ZT2d2cjc0Unpw?=
 =?utf-8?B?K3BSdzlCNzVORHZUdGVReUE4TVhqWVpPYmF2VGNCOGFNbWFjM21VRGZVaEcy?=
 =?utf-8?B?eHJYM0RYNG5JUkVINmlodVZ2ZTFlTFh3V2xJUVpNd0VVY21Oemc5U29oU2hl?=
 =?utf-8?B?Z1R4ZjBnVnErVzFvRHdiMVFUK2xLM1l6TS9UTjVEeEZkSis3bU92K2RSSkI0?=
 =?utf-8?B?SVl1L3dVRDR1ZVJJVGd6eVpBWlNJN2YzN1J2M2U3bzhZVnd5LzE5V00vd01D?=
 =?utf-8?B?dEFpM0YwdDZydlVwaVFUSThUZ3VURWp3dWN3c3JrRGZZbXBmMGNuUGVKSWdy?=
 =?utf-8?B?RUhLbllpcUgyQ1RLdmpTV0xMajYvUllyM2JZcXFpbzBsRFowYzJpWDlPcnBD?=
 =?utf-8?B?ZHBpdTV2UnNmUVd0S2QvY1FxMVljaGR3NzVhZUJ3N2JHenkxdnFLWVE5M2JY?=
 =?utf-8?B?M1dIOHprOTQxTmZSbExmZGFMdU1NQS85Nmd1ZkZGZWxGZE4wcVVjbUVDTFBy?=
 =?utf-8?B?Zk9sb0wxWm0zY05DYkJWelA2ZnZJdlJhVkRKdnVBVVJiVTdxQ29GeFRlRTF5?=
 =?utf-8?B?a05EajJsZnZScERUUGptZnRqa25ndlVmMjF4Z2d6a0oxUWJJbVB4dU9ET3pS?=
 =?utf-8?B?bVRhaWRDdzlLMW9mS3NaOHpmQnA0eWZXWm1qMzNFaGZiM201UXVOdlV0LzIy?=
 =?utf-8?B?MjlkQlplSnB4czVIc0ZJUUg2dndhL2tZQ3pjTDR5bnI4MU5qdDhuYnh5WVQx?=
 =?utf-8?B?ZzFsczZtRzFRejU5M0ZjSS9rNXRvc0sxSVNiU1E1L0l6OFB6NlVqVUdyYjlr?=
 =?utf-8?B?YkVDaXpvTkQ1azFYYmRVVXY0SFVteEttWjJlckZaRk1UV2Z1MHhSS2hISXJV?=
 =?utf-8?B?d21RdWxSTFpoRWJMQzVOVmI3Nzc5dVhWNmgySHY2UXUrb0VtbjRxOXFXRzd2?=
 =?utf-8?B?V1A3d3NLOVJBcmRVcHp2WUlKMThJa1RWZ2xzaGppdzlUdHdJQ3NtdjNJV0VU?=
 =?utf-8?B?eHJvMWgyZEY5am1yQ0IrY0tvV3d5RkV5NGs3UGxCSUZyakdCODB2TXp0R0ht?=
 =?utf-8?B?WitXV0pqSE1nNlV5ZVhiWVJkZnlEOGhNMExwTUJWWHVsSG9McVZLZnIrN0RE?=
 =?utf-8?B?ditGMWRYWXk3V1U1QytNRVNPYjJvd0YrT2hKMzZjZ3BmK0o3ekVUL283UGJt?=
 =?utf-8?B?V1BRNDNHZW1zTVhKK3FhV2NqdzhQcC92Zy85RkZOSHpIWGgxaFNHdExZaWZ5?=
 =?utf-8?B?citZTmFkTWMyZXVVZmVHZDV0ZnphNHVtbm1oaCtUdUpkc3VBWHBMbjhjQjBO?=
 =?utf-8?B?UWU0MkhpTFAxRmtEQS9PenYxK3NDdFFSYU5qbkd0WDNZYnZGNy9tZktKY1o3?=
 =?utf-8?B?NGs5a1orYmVWTXhpclBkUFBVckM2TklXQXB5Qkk5alBnV2NQT3BDYXRxY0I1?=
 =?utf-8?B?Q0YrbnpxRFhoRms5bUFhS3dUTlVlZkIrWnkyTlUrcnhpT0tCb25pczkySUhr?=
 =?utf-8?B?L0d1SkJZRGVCMUgrZ2g2RzNXOUVQdnNjbGYyQjhXZUg0UVZYaFFER0xZUDFH?=
 =?utf-8?B?WHk5MkNiMk9NdzlDUHpZM3prSmZjQ0hNaU1PMHA5djk3R1E4M0hVSndWdi92?=
 =?utf-8?B?RHY5RFUvQXV0Z2luL1dRYkVCL2RxL0p6dnVDbURsZ0t2R0RGV0NIN2NFUkxq?=
 =?utf-8?B?UlNJQmdvYWE4R2JsekJYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czV5eFVRbFQ2QUZUN0ZpeXhFTVNhOFdOQjc0L1R1Rm1ya0ZPWjlicVBQQUtz?=
 =?utf-8?B?MXZwUUlIUldCdnpCTVRWSG1EQktuU0lodjFUeTREM0MydXJ3ZUJPamhNQnRm?=
 =?utf-8?B?elA3WUc5QmgyL21ncTRnUE03djFUY3gycWl5OW0xVVhJRng0S0Njb25Ya1c3?=
 =?utf-8?B?K09QM3FWcDV4SmQ5MUs1bklBdjZIVjA2N2lyakRiV28wc0RBV3AwRiswMUdO?=
 =?utf-8?B?em8zamt0aHlxZnhKTklScDVDWHJuQXNDUWt2V2VSRFdHTlJZSUVxK21ucjRi?=
 =?utf-8?B?YWdBVDNqMXRXeXhZdVNtRSs4ajlwOGJWVkdKUFZVMUhBc2hoaFJKbGU5UXV6?=
 =?utf-8?B?Zyt2cFpKQ2sxT0xaakNTZWxRM0p4R3QvQmNTcWNtYmNqTTdFWEhsc3o3VlZp?=
 =?utf-8?B?K2lyUURpNDZQWXFFemlJZ0pRb3pUZ2VxWVZLT3NaN1NIZE1lQzNIbGRUWEhK?=
 =?utf-8?B?OHlxdTBJVy9ES3U2Szd5ZWdaQnNZTlBhek1zanBMaW9ZRUovV3h3OEtVZ2Jk?=
 =?utf-8?B?aWorU2VXcXAya3E2dk9HcFBNdmJhcnRlZjJVOHZOa29tU3U5SlM3LzZRd0xZ?=
 =?utf-8?B?Y1I4SGlRTHpFY0taRDBndjlBMVdHcDE4alphdWVCaVpuQ0QwT01OdVFQWDhp?=
 =?utf-8?B?WW9JVkpUQnZOTFRpbHdHQ0xjVmdTRXYrZE1NTWlJZWNDdnJQUFM2V1NzblpG?=
 =?utf-8?B?U1NkdXg5TmFEWC9hQWR6cDRUSjNVZk5DbndObXNhbWJpUVlVekR5VWVzVEhV?=
 =?utf-8?B?YWFiaFN2SVVCRGRqYWpPdk1jRkNLN3EwKzlFSlBLRElmQXJSWk5HUjJoVjdT?=
 =?utf-8?B?blQzVVAyYTlKWjljSDd5Mm5Iam9TVUtBSnlnRmM4VVlocG1zRnpiLzhHNlBo?=
 =?utf-8?B?djN3c1pFSWVZTjJ1S1huYlhXcjVCMU53WVpKdngreEk4WStDRFliMDBlQUJB?=
 =?utf-8?B?VnZvcXVJSnJsaW9ZZzJhVXhNZW0wMUhoL1FPMzdzZmRhbUZNWTIwTklFbjN0?=
 =?utf-8?B?RUdaOVJSa2pIWTNCNlRGbExnelJiRzNkaktnVGRxNVlaQVg3SzZTbHBvdkk4?=
 =?utf-8?B?YklsbGduT0JlWm9KZ3FXN240dGZMMytEUGh4RVFyT2tIaldsbFN5WXhIWTNB?=
 =?utf-8?B?R3V5K2c4SUROaG5oNy9oQVI5WEpIWWk2MmcwSWZLWTJmMDR1bGx6NStEeHFx?=
 =?utf-8?B?THpRck4xZkw5N3AzS20rU2x1L0lZdDc5WUJIa0V5UVA4UytabmorQnBaSy9j?=
 =?utf-8?B?Z1VHRW9kL2dQaFI2SEx2T2xwaXUzSUVpTFMrQ1B4aDhGa2twS3IwaGl5clJQ?=
 =?utf-8?B?UGhXeFVOZDlMOFFoODFPSTVKWDQrRGtRZVQzUEIyNVdSTTI2aEVyTHZGcE9w?=
 =?utf-8?B?SDlrVHRnazZGZlZGZ3I4Q2dzbGtMQm5lekZDZkk3RWU1UzdlVk1yTFlJUVNv?=
 =?utf-8?B?NUNMVHljY08zeTltVnMrZS9JQmxxYnhUYU5sNkRob0ZIdGxOc05YeHRjR2Yx?=
 =?utf-8?B?eE5kMUtxc1dScHdQLzRXbDZpazVQMktrQkdEWmh1Vm9kbzdPUzRHdWxCK0Fm?=
 =?utf-8?B?N1BVSFM0ZjhFZklaN0QzRm5HU0xhWVh1MWVIQUZWMll3TVNES3BOdFR2S0tT?=
 =?utf-8?B?ZHc0Z0QxaXNlMFNld2Y0a1BWbElvbXZZblFLMmZHYUJJQTdMMXd6M0M1dUVO?=
 =?utf-8?B?cXc0UEFKaC8yOHJVR3RwS2lwTHBtYTlCTXZRYWVPTXpJdkIwRHhCZWQ0c0tP?=
 =?utf-8?B?VVA3b3pWQktVcncyMG1yWE5ULzMxdlB2MWtiaUhJeGVPbWNXR2NKUVhjRUFq?=
 =?utf-8?B?eXZ4anMxK2tOVUtsL1U3SW1sOXJjZDN1MTBpZWNhalVQTnE4Wm84VEMwaENj?=
 =?utf-8?B?VkpXZGIvVVl3L0pOMGw2OC9qZlBtQ0ZGKzBJU1Fld1lXTkNzVlRpS1NYcGh1?=
 =?utf-8?B?MVZ6SHV0WUVwSTVIQlpRd05zNCtsdjhId3JlMzFhcXZKVXZoRUhKZHRZcE1i?=
 =?utf-8?B?V0VwQjR0d2RiOGlSTUpTTFdncXYvclRxWEdVR0hBM21rNEkwUTJ2TTZFYm05?=
 =?utf-8?B?N3MzY2tKWTZ3SW5nM1RHSStSZ2VqNXdCdm10ajRINlA3UDJJbFFJYTJYdlN1?=
 =?utf-8?B?aTBTOVlSTGRPZGoxZkJzZ1NDd2ZxNUNycTNJSHhvcEpMd2lzcGc5OHArSExs?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BrpEndQjAylo0SbXJJ9QeY0wdk83zkdnXOo5d0zk3oYQkROEyJCvOurObWg3rfz5FkGRfFH5TslJGfSbTzrrJ4vVV14tOeQQ6xbg9b5X9wjubIIijTQR5tZnp0PAB4XiETgb+IBKQdswjJt2Xzw38g1UTz/vnOXhUjVOfzKkdDXBbKVe6vutw6beljBKW7I8fmsJcjprLIT85i+/CRGTSuwbZVi6OTILS/f7a91a2yAjVUoGv/RDv/Vhm61VO8QCE5e0s5ImWK1xLa2PRCjxOUFyGJQFHChBJQ4aV5ATgTREMBH0xxhlAH9jgBFRIq49qd6RhV0LMfP34hpZS4NQvYnJiPNBS2jE04fQGP27LqCfhRhCAb8auHiAO6cyuEralX2w4hHlptmHF7uG32bCVly7DaoNeVZlwRMJJt9Iyfct+Ms3d40pVVSLxrzq1J4o5ntltIR4GR0qA5E2fXcGP31WLJ+0iGEZcyu7lkFfxSFoWtksvGKdNNGwhPxZSU96ct0PmKwt7OWo1KKtQIDbzb1V+MhGi47fFp7QLMhrV+vzY8S5gkdjFBO3eXVpPuxuQ7ZHDm8QFSh9YEzME9EBLV+fME2dVyE1CkE3hiCRqZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2594d65b-4d73-45cd-5953-08dcd1cef4e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:29:58.4518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clPYnrmUjpyGacKTYag2t/9GwHj5lk/vvFEl3iNhuK2Z+juFwsAS8hnPCzTNf1gxiR7P6CHNdo8G4dacnzSdVR3wiIyW/WCNMnTuved9D6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_06,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100144
X-Proofpoint-ORIG-GUID: DNoH95IbIebVEXSPQdPqwq71ZCi9pDtk
X-Proofpoint-GUID: DNoH95IbIebVEXSPQdPqwq71ZCi9pDtk
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

On 10/09/2024 18:40, Steve Sistare wrote:
> IOMMU_GET_HW_INFO fails for a vfio mediated device (aka mdev), because
> the devid is associated with kernel type IOMMUFD_OBJ_ACCESS, not
> IOMMUFD_OBJ_DEVICE.  Assume IOMMU_HW_INFO_TYPE_NONE and proceed.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

> ---
>  hw/vfio/iommufd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index cb7257b..d8928d4 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -635,6 +635,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>                                        Error **errp)
>  {
> +    Error *err = NULL;
>      VFIODevice *vdev = opaque;
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>      enum iommu_hw_info_type type;
> @@ -645,8 +646,9 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      hiod->agent = opaque;
>  
>      if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
> -                                         &type, &data, sizeof(data), errp)) {
> -        return false;
> +                                         &type, &data, sizeof(data), &err)) {
> +        warn_report_err(err);
> +        type = IOMMU_HW_INFO_TYPE_NONE;
>      }
>  
>      hiod->name = g_strdup(vdev->name);

At least we aren't supposed to call realize() on an mdev.

See commit 9f17604195c ("vfio/iommufd: Don't initialize nor set a
HOST_IOMMU_DEVICE with mdev"). There's another refactor later on in commit
83a4d596a93 ("vfio/{iommufd, container}: Invoke HostIOMMUDevice::realize()
during attach_device()") where we also don't realize() when vbasedev->hiod is NULL.

Unless the stty mdevs aren't matching examples, then this shouldn't be possible
(I didn't have one with real hw behind to test).

So if you are hitting this codepath then vbasedev::mdev is false, which I don't
understand how it's possible?




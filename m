Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09BC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQSi-0004RF-Qy; Wed, 26 Jun 2024 07:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMQSc-0004Pt-9y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:05:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMQSY-0004Ew-C0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:05:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sGeb017342;
 Wed, 26 Jun 2024 11:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=wwD7twHy5FX0EMTqyWtBD/L+QvHzLkPk9D0HukA7PCs=; b=
 fL6sqYUz0x11J/723tbsXMZeUov/SinNBiwokH9wNNuYdcBsnRaiXllfCF8eoZw6
 YrBYBH/2d2eCz3DqA95L7xmYgMwnZ+qfR62+UBu3yIMy8HV/097w7mikPjZgsams
 6RsHAwlTHkUvuihTeQZl00lvd/bKnjmHf0uZ2rt87C6JNF1XDoDBlUmJ1kskyRKA
 S4p5ybH9f/a3sIZJGzchZzyDxnSaIv42U3BGlirYbuABps3ROW0xuPDzxcsM9qlA
 avMFpg/cznTeaq08RxrqEThwukY2aqt3vB5AC/zom8a/Ig5PzvJh1wnPabnG6KtL
 f9T05CR13WECU447Q3TRfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sk09f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 11:04:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45Q9WoFF017779; Wed, 26 Jun 2024 11:04:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ywn28uefp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 11:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Quc+yJ6qk5chBFgOJ4p8C1E7syy3xDiybcc+gjrY2s7T1Ri0Sw1Fkw0tb5njdByVn3cnOVaboxRPNk/LzooBNxytEhzqcsF74z0yXn6zKa7e+lbTWmNMxDlmCLZF7G/J/gM1ohcKml8CkiPvANVh5jt2Yv36ebJgbO6E9tnQz9o3if9rmXLGpFDLtCnZmuijQlckT9mkUvxmnwnsH/ApBcPaujjy5sKlV8sn+WICsrDTmK17eHV7ihuMFq2Ce+hUacq92wat7RZSXyvce8fzOLKK8Rya677j6u3ovW9yTrXFBb8iUxTrAZLQV4hfMlJ2fvblHCF6unwXpebvkhAsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwD7twHy5FX0EMTqyWtBD/L+QvHzLkPk9D0HukA7PCs=;
 b=Cp5mbhopTiqwEWMZRgjiZYRJzQc4sggbjyBD49zeWotczO7UaWokh+AGldPgOh1rNBIMcicHcjLqSKbRW4ADsbG/dAuR/XpTO6qlAQa7q4pymOpXRfwYGMMQn2FtBXn2/4IzNVZmUyVu9ylB4KbtahAsQp2Av/E84h7rJM0Yr0b3mqLRhHY/8SdiRPt2dM7U92CUUTdGANjQjVlnlRclKXXecOUIL8WvjZUY8jSHHd3fQs5BGxDPNbMBTfe9+V49gJ0mAfhhnReLYM25yHTa3jzI/a6w8y+fZj2Azfj7LNwKQP2nuZEIBxkl94iff+Ld34dqXkBnYJOvNNjwwqchpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwD7twHy5FX0EMTqyWtBD/L+QvHzLkPk9D0HukA7PCs=;
 b=lQFucnVv80j3Zuu5o7K/IJeVvfsMyg/BxXlWyCsbjoqr9ZMWm8FMkNd8UG3s1uMFUj+6iV9Ygk8L3z0x9wjgt9sxFEt82vamH6oxCQu8tGk1MhFwPCc8JW//Zs9sLEFz49UB7UTBOGhbdY2ssdLC8ruuo54rMcGk+EBqfmaRTbc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:04:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:04:54 +0000
Message-ID: <3af67d66-075d-4162-916b-b407332042e2@oracle.com>
Date: Wed, 26 Jun 2024 12:04:43 +0100
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
To: Peter Xu <peterx@redhat.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com> <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com> <ZnrZ9W6WpvmDBpgv@x1n>
 <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com> <ZnsUnKZHtsMKQc_2@x1n>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZnsUnKZHtsMKQc_2@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: c14c5417-5af7-48d1-35fa-08dc95cfcefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1kvdnhtajNONU1qaUlQaVV6OGtQd1pMZFkxMWI1cDJGYjQ3R0lBa2w2NHFr?=
 =?utf-8?B?VWF5a09LRzVXcWJlU2ZjdmkxVzE3eS9YMFRMcStURW42SHJCc29xbm5WTWNl?=
 =?utf-8?B?VlJNak12M1BGQmx1MGp3TEJOcVN4MjE5bXBjUzJ3eFJzSVVmbk00cGNHVldU?=
 =?utf-8?B?OWUvTjlibVBEazFVeW5SNUJRTG5RMWV3RHd5aDQzY0VNT2t3OXhnZHBaS1Za?=
 =?utf-8?B?L3lTdlhCQ1UvaE93SkdHeW5TKzlsUUd6NzRGWGV4V3l3T2hjZkRVNzVUQmZk?=
 =?utf-8?B?ZEdoVW9XT29aWnorSFQ0WjZuYXZMQmlJTEUxL285Um1RSEppcHh0bEJtVHlP?=
 =?utf-8?B?OTlUcG5FVngzbG44cGkvc0J0S205K2tjRyt5WDFRK3RCZFZqZHFDekFwZVo4?=
 =?utf-8?B?enNmeXAyRGdYVWluZU8yVVVvNVphSWRXNVA4enNxSnNuU3hBM29ud3I1VDJG?=
 =?utf-8?B?MjAxY3NtWk1DTUxQQlNDZXNKckZsT2liV0J4VE5ibkVYNW1BM0lmY3ZLeGhL?=
 =?utf-8?B?STFCc2hKL1pvUlMyb280YU9UN1A1SzFKQXlpRmZNWHJWTGxzeUZDVGovSjFw?=
 =?utf-8?B?RzBGOXpUSHJ1VmtRK2g1VjRyd01yNTB6SGYvaTF3aDcyTmZlQTdMek4vM29s?=
 =?utf-8?B?T3JJRTk5SUV6OVRuWHp6eWN3UnZ0bFlBa2pQb1ZKUi9zbnBjSGdtVFVzYnVv?=
 =?utf-8?B?K25zNVQ3WHdWQ3NTK0J1SEpaRUpJUnIvRlozNGUvbG42bXF1K3hQaXIzNEp5?=
 =?utf-8?B?bjJuamdlMTl5T3o2a3lmd1Q4Mmd0Z0lZeVA4WGJHdXdXVmw5dm5yT0xMMUdH?=
 =?utf-8?B?T0c0azlwUVFtQjA0UlhMQ1dnYzE2U2FUNHJlRVJOYnJwYUx1Q0pUTXhscnRF?=
 =?utf-8?B?YlhrenFNd3Fkb2lEOTZ6Zy9tcnUrYURJS0JLY0h2eE9xcWI2N0wvdnAxZmlG?=
 =?utf-8?B?VU1Vd01XSm52TFdtQ0drOFZXRUd3ai9PVWQrL0E0KzB4Q1NObi9qM3dMVWRD?=
 =?utf-8?B?bmtsQlltc1FuL3hLOFBEY0UxR3Y2SUdQa3hIMms0dDVUY0I2VXllMDE1YkhO?=
 =?utf-8?B?dTUrQWJ5RXVHWU1Ob05HVFIzellwQThCMnFxM0tCVjJISnp5ZndsSkNZMkhv?=
 =?utf-8?B?ZGpKaFFuTHFSblMyUENjL2E3VTZ3dGRHZUx3ZGRIdDRKUWk1MDNEQ2RaeS8x?=
 =?utf-8?B?KzUwaktFWVlSUnExdlIvOGVBNkZrZEkzVis0UEkwbjIzcUQ3a2w1RnRjZy9P?=
 =?utf-8?B?YmswV2d0SUV2YURUNUlXRWt6UnkyZkxxWmtPWCswNy9BU0V1Q2YvQjBFVnRD?=
 =?utf-8?B?S2hlNkVXbFRjY3hIMjNKSitpNytFVUV0WU15YXFKaUZBREF5VzZ5UnRBRGtV?=
 =?utf-8?B?OVFpZ0swcS9WRjQ3LzlHbmZHR0RRek1TN0FXWFB3UDREVnNEMmRBaVYvYzM1?=
 =?utf-8?B?ZkNKQUFidWx1dDNBMmxBSVJvNUNtMXRaYkQvZGc3c1orZ3RoU0tYbnNWeVVC?=
 =?utf-8?B?V3pFTjFUTW9sVFhweFlHMENlb0lGUFUrTi9saXkwNjVCWG4vS0wwQ0taY2RH?=
 =?utf-8?B?YzZ4VjN3dkgydHFQbFc0dllxWTdselgrZUViZXRYblVScnZvMTNMeTRoVEk4?=
 =?utf-8?B?OWk1SVpkbWlMRExJTkw4WUdCaFVnMnRaem91T28wUFdMR1lhMHRaS3J1UWJ3?=
 =?utf-8?B?Q3dTUkFaUzl6MWc3STN1b3lVaTQ3ME5CZC83VDlSYlgyMTVBcy9Lc0syNjU0?=
 =?utf-8?B?a3p4WHhPSzZBay8rcUw2QW9jSjcyeG9yRlRxbkJXVkZCQjZ4emNsREJtNXBR?=
 =?utf-8?B?NjVaS3B3cmhYNlB3NUNldz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjlScmlNbTRGL0FaQnh1Z3dQK2hPTW1LZlVkU2ZIend3K3ozMTc2Qkl1aFFv?=
 =?utf-8?B?VHAyeFIvc0ZweHJTdEFqaDVOVWFrZjl4UHU1a29adE9veUN2TDVZWENqRGZI?=
 =?utf-8?B?b2ZqS2FQczFncSs4VWpYeHpEUmxnbkV3cGp2VklzdGVoMWNQMS8zektLS0g5?=
 =?utf-8?B?OVVvR0xzdHhVSUZWb3ExajhHUVpmSnVmdkovMlR6TVJHTzlObWhDVFBhT29I?=
 =?utf-8?B?Rnova09iYW1DWGpsNHM0VUpCK2lnQzBla3JZbHhISmZmMVBRcm9iMkVVTEdO?=
 =?utf-8?B?ZnFUTmVDTGlkdGxZK3o3RlFYaW5ISGNBaG82Y2JBdjV5RXBJUUtSdU9vTDBw?=
 =?utf-8?B?SHVLU3dsSittOFR5Ni96WVFnYUpMdTU5dG9UMGZMMHpUQWJnL3QyVHJCWDlN?=
 =?utf-8?B?QWdIMGhBUzdSckdTYzJpYW43b2k4Tm1hallSM2c3a0JidTFNUTBUaWtjajJS?=
 =?utf-8?B?emR3SEU0WXFHNUo5R1ZnTkliZi9QdHc4RUZUMXlRK2NubzJzTk8xdlZjaDNV?=
 =?utf-8?B?Q01EUFFUWDVRZTB1eG1KdE1hV1RQc1RhazhUMkcwd3BndlF0V2U3aS9rMzFr?=
 =?utf-8?B?a2VDM1pPOFNSc0hwcFRFZDlmUGNrOSsxamZUSk9iVUY3cHJ6Y0JKMzEwTVRK?=
 =?utf-8?B?Rkk3MCs3VFhHRWhQcWxrYTNlZTV4akJldGtNaStyUmMzdzZ2aVhRVUZPNXZH?=
 =?utf-8?B?aFllaFJQR214dHlxZlM4UnRHVzRTQ1BnUEh2UXk1dTA3ZE1ZbEQ2bkZZNUhy?=
 =?utf-8?B?WUtXbE0vS1FVTExhR2tTaldwdTcyU21iWHlJZnVWYU52UHFjTVJjNTRDNHB6?=
 =?utf-8?B?L0hmL1g4amg4SWlUazFjSExzN1MyY3kxNWpGQ2RzUmlheXFMSC9mQ2pKcEwx?=
 =?utf-8?B?M0NqaTVkaGJEcDJiYlY3Zm9VRHlLLy9uZzFVYzIvV2wzTW14NTRaQjdBUFBF?=
 =?utf-8?B?R0ZEa2I5ekNzalJZc0xxOVhKVUQxaklFVk53RmRWUTJlNEpDNFFuSGRnNmpt?=
 =?utf-8?B?VHJoUjU3T3RoZ2RPK0JCZzdNVUFkWm81RVVQNVJEWWdNRzQ5OGVTaUFhbWMw?=
 =?utf-8?B?ZlNlaFhmbUp0V2tXa0FCVHl4NndNdkIwUzYwY21oUlJpdVRIVFltUWlRYkV1?=
 =?utf-8?B?V09iUGRBRGFKNlNQL0pDZ1NMTnhROWREUXBKU2FMWU1IbmluY2gwbTFjNk0v?=
 =?utf-8?B?OTRXVnlwbGg4WlRDNENvT3VUVTR3YUFhMXU2MU1BSisrTjNDWWUyUEFMY3hl?=
 =?utf-8?B?UkNNUkxwa0R3cnErRnVhRXNDalMwaGdJZVhYNUlGaDZtZW9zclNJT2FYQkRL?=
 =?utf-8?B?L1BpeWtQVHROYjJ5aU56TlZDRy92ZXNxcDdVWnRnS0owM2tqSDc0cUc2UjFF?=
 =?utf-8?B?cjlTMHJ0aEs0Q2FsbDhRd05OT0REZXpiSzlmUmJjQTJFcVMvQjlnNWZaSXdm?=
 =?utf-8?B?RTBTSFkvZGdnWlBZWkFPWTVnV1JFRzY4bE5ydUkwRnNka0VtU0ttZThHa1Ro?=
 =?utf-8?B?ekN0ZHl1bFcwNHR6UVZGbC9xbjNiQkM2WFVYQWxkc2ZPNEg3V1AySjhUZnN6?=
 =?utf-8?B?RXVxYXFkMURnd0tWSmp4bExkMXk5M2xNRWR2dVZ0TnBTalkvWTlhM2VZYVR1?=
 =?utf-8?B?b3FwZnloN1dPOEF0TTZrdnZaYVhONzVSUlNsUENJSllod3o3eGdjUDhOOVJC?=
 =?utf-8?B?eFJmcURqQ1RxUWdueXZLTnhqWDJVTWpmZDFIdHB4b0FHbnBhelJWaW52bWxC?=
 =?utf-8?B?b0V2Q2p4OFpCNEs5SkZkNE0wWFlGajd4djVscnNTcHIwcjFsenJsdEFEazhQ?=
 =?utf-8?B?ZEVCMXhTWkZoM3pEb1JnOUdqajBpU0M2YWZjd0Ywd3ZGZzN5a1ZmVFpqa0lI?=
 =?utf-8?B?NW9KTmRicDdoV3VSNCtnYWNYL1BLMW1SY3NoeUJ0ampUa2s3RzJSN1Y2RTRm?=
 =?utf-8?B?ZmpYa2Vqb004Y2hqRm1rMkNpTU54UGtMRSt3SzJYcThTVmIyRHM5aEkwcGNN?=
 =?utf-8?B?UDFZUzZJWkhSRnhlNE5XRXFBYWFDeXFJWlVpeDV0Q1hVVG9wcndaRTRyeHBa?=
 =?utf-8?B?QkFoSFBncGZZWU1vcENPeUZhYTBSZlBpRFl4SlB2S2VxR3hWYjhtdzBLRklW?=
 =?utf-8?B?YjY3NE9FdENheC81VEtvaDF3Um9YWUVmWjJyMzNRUXdCSkxVYVNjQ2hGc2Js?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xVMu8SXpqq8I5r9XRiPN6qB4S4GPnmFMKNX4PlEaZjE2CGJwdeBZfhglSJI9ZEjRDGYviyq/3lYOux21TTCgP6nF/Kks8i/QgK/HI09Nx723mu5MYMaYUvYVaKxjMpGiYYbUVzgDSm5DsgWKUbWFnkdYqlTBhamwTtzmMW7GPoZVHMUy8OBpcs9q9Jgq2Jhc9P/Ytwj/cSsbE313rY7k62PNm4oj+9TFZXaFdGtXepPjBQpiJi4o0T3QbPRv0LS4BMJDrL1GVjvLhkGdYdjlXS7k55YQG6wMfOexgrBzx2127dPTsLsPJIvuCeF0iTj/KHW5/bbCSG4PWbTCxlaykaKjJk58cMqyN/n4Iy1toFJ7vxd1YWJXaPV2vKCkmc6hCcP3r4doaaXaEUar1zVJeloKVaRQNqXkbDwvOGpng/faorBGgDyHDsNWuWkEzWOwwbsy1dnRAqOdpCmPktQN1CJnucDpRBGrJt8ZjFvRTL6Yg9n1ZTWpRcSNrH5frY7hMTpb2NH7g9/dYpk3dIxdYbtjoJAYwaQ2m3/qntdWhc2IR7O8fu3kN0EKomb7E5HU0XrI+5AtT9MRx4NNAS4bkya4890daPoflFD/xrNWnZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14c5417-5af7-48d1-35fa-08dc95cfcefd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:04:54.6088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSo0znJKs/6Oy8nTawJiuOPS3OY51o4LCYqf3AZQNEjJ3ug64lULyKLmy5hjl0WourpMRWkUjB/VfzyLKRrFDivBYE2mQkUJxzvLaQSX0os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260083
X-Proofpoint-GUID: sOMkbF10DFP6sktTNzxgeZ-FI4ja-xII
X-Proofpoint-ORIG-GUID: sOMkbF10DFP6sktTNzxgeZ-FI4ja-xII
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

On 25/06/2024 20:03, Peter Xu wrote:
> On Tue, Jun 25, 2024 at 05:31:19PM +0100, Joao Martins wrote:
>> The device-state multifd scaling is a take on improving switchover phase,
>> and we will keep improving it whenever we find things... but the
> 
> That'll be helpful, thanks.  Just a quick note that "reducing downtime" is
> a separate issue comparing to "make downtime_limit accurate".
> 
I see those two separately too; it's just that right now that's the only work I
know we can make it better is decreasing/optimizing it (other lines of work
doing similar stuff inside vDPA too, by Si-Wei for example). Making
downtime_limit accurate not so sure what it entails right now from your PoV. But
it depends on what this question really was about, see at the end in case I am
understanding you correctly.

>> switchover itself can't be 'precomputed' into a downtime number equation
>> ahead of time to encompass all possible latencies/costs. Part of the
>> reason that at least we couldn't think of a way besides this proposal
>> here, which at the core it's meant to bounds check switchover. Even
>> without taking into account VFs/HW[0], it is simply not considered how
>> long it might take and giving some sort of downtime buffer coupled with
>> enforcement that can be enforced helps not violating migration SLAs.
> 
> I agree such enforcement alone can be useful in general to be able to
> fallback.  Said that, I think it would definitely be nice to attach more
> information on the downtime analysis when reposting this series, if there
> is any.
> 
> For example, irrelevant of whether QEMU can do proper predictions at all,
> there can be data / results to show what is the major parts that are
> missing besides the current calculations, aka an expectation on when the
> fallback can trigger, and some justification on why they can't be
> predicted.
> 

/me nods -- I think this might be a gap in the current cover letter.

I recall we have looked at quite a few downtime traces (thanks to the tracing
improvements made in the last dev cycle!), but it's also easy to reproduce these
problems with downtime-limit even without past data with relatively simple configs.

> IMHO the enforcement won't make much sense if it keeps triggering, in that
> case people will simply not use it as it stops migrations from happening.

Right -- The enforcement *alone* damages more than it fixes. Meaning enforcing
without having some way to give some headroom within downtime-limit for
switchover to be accounted. The latter is what allows the enforcement to be
placed, otherwise we would just be failing migrations left and right.

> Ultimately the work will still be needed to make downtime_limit accurate.
> The fallback should only be an last fence to guard the promise which should
> be the "corner cases".
> 

Are you thinking in something specifically?

Many "variables" affect this from the point we decide switchover, and at the
worst (likely) case it means having qemu subsystems declare empirical values on
how long it takes to suspend/resume/transfer-state to migration expected
downtime prediction equation. Part of the reason that having headroom within
downtime-limit was a simple 'catch-all' (from our PoV) in terms of
maintainability while giving user something to fallback for characterizing its
SLA. Personally, I think there's a tiny bit disconnect between what the user
desires when setting downtime-limit vs what it really does. downtime-limit right
now looks to be best viewed as 'precopy-ram-downtime-limit' :)

Unless the accuracy work you're thinking is just having a better migration
algorithm at obtaining the best possible downtime for outstanding-data/RAM *even
if* downtime-limit is set at a high limit, like giving 1) a grace period in the
beginning of migration post first dirty sync or 2) a measured value with
continually incrementing target downtime limit until max downtime-limit set by
user hits ... before defaulting to the current behaviour of migrating as soon as
expected downtime is within the downtime-limit. As discussed in the last
response, this could create the 'downtime headroom' for getting the
enforcement/SLA better honored. Is this maybe your line of thinking?


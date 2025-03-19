Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutQL-0006Bu-CF; Wed, 19 Mar 2025 09:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tutPm-00062W-A3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:25:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tutPj-0001zn-T4
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:24:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8fwR2004387;
 Wed, 19 Mar 2025 13:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tq10tAkAt8j4xhTFkkMuo2tgh26QOHWXKNyZCulUmFc=; b=
 bhDCRAUDbn8j5Tn7uUCALotSxLZ+Rp7v+ug7xP1+Je/5xVwIhRcqe4EHs2qa1RM0
 SqWKIoiTiC6A7kpWdlDhb0m6/Zpm7N45p9KM9JqT+eZ8nVdX8jVDRZVfaWlGT7gz
 eg+FBm6ec97y83BwBdXEsSFKnXgbiV9H889zYvEjoco8iFlidOKq4KCWktTa+Y88
 dYIdGc1Byz29hdXC8lyWn6gmTnOJ2pMowVVf/dPunJwnnFx/sccWrAELhoV3SYOj
 ku5J2/L1ObyEpJr2q1QoUrtID16jngknKQPwQ2mvPHXdBCdwijAAj2t01TwAg0oB
 4ZqZgsfQ6dVVsNvID4U+aA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m137cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 13:24:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JBUwB7009749; Wed, 19 Mar 2025 13:24:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxm164ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 13:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY7SIbzssRQ7A4TKiaY7xHDEbb/WeyGWIRCcKzMxIklgYxeGvyKfi18USchviZpG4odJcKEKwSlBwHm/7Rqq1NvowqQYfS/uQlhD+FJYPqtclBCowD22FVMlsnfSzX55X7hH/gJ142K/Z2JLsi9YWBrlsb6OFfW6abkcCgGZk1bnDsJcX9YjWf/tNKVH+KLbomz0hX8WC1XelNx/kf8bG7KN/0/qw8vQZmfejkksbQ5kMHgiKZktvbZqWeEh9VwMaC1BNDfzLyD4h11bf4ciF+mnfPXMxu3lfsYu0xDUAS+UFTYynGGxplbHbemsSSC5bmCPpnZvj6dcEjfcHEFEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq10tAkAt8j4xhTFkkMuo2tgh26QOHWXKNyZCulUmFc=;
 b=B22mcLDz1vVsSJlXzjohQD5py2nQPiAbo6wOEIo8OVKlb8fCS9cGD3eYPqzpfRhPn2uY3FGhcvkrFmV3fDO7lnsSlMH85ivKI/qO5wFbc8il5g2dUZV3ppJ+/3RgD81M8ah7Y3je4xxpD5pfPF7tO53c5Kv9b8IpxbuJvFr2VH+6age3UrAxdYAo7FHZ87Akueo64wnonNmFA6+QA4eJBq68jJ8O06G50r6rN6WI5ID7ZwKADK+rslvgLwWZYZ7grt8WdZqoMMduQikkrO8+2W6y0zvYBBEJU8KrAXpZR5zZJcyKSif8DPpEv2VABdT3ThZHTRKzTGBISt31T7P6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq10tAkAt8j4xhTFkkMuo2tgh26QOHWXKNyZCulUmFc=;
 b=L15dC/1Tu1xG4VTBaDbZza2mhF/Mrg8bP1q7TsXJHgsLtLTAi/bBBYHBMXOvaHXKGsK2gl8cX0zfHYF+B8KkY34a/FhbXI0m8pSWc9XnxoV01sCTtkk/JUAbZluifpoug1QmZKFlJ1Ozxet288VmTE38+BgmnxxIJM+m2KnQ0P4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 13:24:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 13:24:45 +0000
Message-ID: <7d333f19-4deb-45ab-8756-ffd7e4a6c98d@oracle.com>
Date: Wed, 19 Mar 2025 13:24:41 +0000
Subject: Re: [PATCH for-10.1 31/32] vfio: Introduce
 vfio_dirty_tracking_un/register() routines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-32-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250318095415.670319-32-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2f7e8a-e7a0-4029-c1dd-08dd66e96a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q042UDhJUEJDWFpkeUE2anZEYVZzbm1MMmpaanJreWE2eTVLSlhveVB1L1BM?=
 =?utf-8?B?dmtEVzRaTlRUb1UveHpKcm5PNmFkWEtSVHRsaGRMYlV5RU5DM01ncHd2ZUdy?=
 =?utf-8?B?S0x4WEtDYmptSlV3N2E4Tzg4MG1vZkczR01vNWdQZ3hGZXJ5WmFUTkE0OFRy?=
 =?utf-8?B?bXYvc2pUWk5tYjFtNWg0NkJ3RnhzdEJEWXdJT1h6K1JwSWJuU2M4WDRZeEZ4?=
 =?utf-8?B?RGFxL2Voek4vQytJRXRmcWhRZXhLekhKQVRuYzc4c0VrM25WT2VnaHRRTGtS?=
 =?utf-8?B?SDRmeWh1ejB3RnQvOTBXUzF5aEdPWE8xNys2KyszMy9vOXllVk9hZENxeUNF?=
 =?utf-8?B?MXpGbnh6SWFjblBCRDZsWXo5Y05XbjFVV0lZUjVoRG1rNC9aaTRNaWdYV1Ns?=
 =?utf-8?B?VUlLY0UwSktYYUFwd1hTQ0tMT3NrUDRPYXFWZUdFemoydnlFejJXZGZrRFov?=
 =?utf-8?B?cThTMjBRV282eGM5Q1VoNkdWQUllZnc0VzltSzRhZXVYZThxUjVUWnJFdGNt?=
 =?utf-8?B?Nm1pbWpycFdFQmRqbEs1SGdjOUUxaDRhalJHeDduMW1Tc084UHNTWGoxTWpk?=
 =?utf-8?B?L0JZUGxEeXdrZGgvYXZkaGFjZjlVMFFDeDA2THZCSmxjT2RBbjhPZjBNSkxL?=
 =?utf-8?B?dGhOcG9Xc0syREtYSFQveTJkR210THBLV1JhMTJGajNlNU5nK3h0OFA1SjJC?=
 =?utf-8?B?SUlYMWhNdS9QNjZ0eVRQODFIbEZ5Y3BYWVFSNnZFK0dCK3lQaG1LNHk5SlR0?=
 =?utf-8?B?TWpJV1o2TStjcEJUYk9ESVEzVW0yc3V0RlZlVW4xajhxa2hLK0N3bkdZNm9l?=
 =?utf-8?B?N3JpQ1hFa2V5TmtydDNpNlJMMU1abDRJSG4va0pOelE4V1NnSHpGWUprYTdB?=
 =?utf-8?B?RlpaRU5YZHRiS1ZpTzY2bjV1VHBzMm55OUJJUlI1bUF3cElESEZqL0hxSENO?=
 =?utf-8?B?dWdsNFZRNWdySXE0VzQ5SDU0RHBRWEhDWnlBRlo1RExYdnBqWmp0OEgyR0F1?=
 =?utf-8?B?MFVOL0ErOTRZUUxRMWN5d2FnM2tNZzF6bWU2dUJKYWRIcnUyUGhMYjl1THZB?=
 =?utf-8?B?SVFXUzF5UFhKV3VwSGFPUEZlblFYcmJwYkdRdUZMc0lUNTZkUDJOMEM5QnU0?=
 =?utf-8?B?TE9wd0gxVE1oTHRTT01QT2lhK2V2SDhkci92RW96T3VSTG95eDRPR1k5MUNt?=
 =?utf-8?B?TTVEODV6QXJMdHJYNDRrOHhTOWJvK25sazl3QnpTT2crSEw3REk4Yi9TYUFa?=
 =?utf-8?B?QUtTWEl2ektyV1VIeXBCN254NWFSMktHdUdyRkl1ZENGMmJRRWZZOFVYbWIv?=
 =?utf-8?B?dGhaOUJBc3ZGRFV4Rk1NVlhPZDN5L3NvVE9WaFU4T0I2T2lGdE15MHNTNVJn?=
 =?utf-8?B?NGFmSkR4Z09wbDFwRUoyeTJNNlJQVlNJQVcyWHQ3WHl6eDF6ZklzOWdSOTRK?=
 =?utf-8?B?QUQ4NEF2eWsvNnZOQTBNZ3doQUFlTDIxWnJWQ29ycDdYcE9sd3BpY0lWY3dv?=
 =?utf-8?B?SE5zVnp6N014SFFFVUxDbVgvZE50bTE4WWdSaE9yUzhURGkyak03dnhMT3Fn?=
 =?utf-8?B?dURrZEEvY0ZwTUtXOEYxRHdlRWlCSTkyaDdKbmNHRHhwVWRJektvdzUwdFNZ?=
 =?utf-8?B?RTFZRWEvTEs1SFJLQWVlUk5IcnRFbUxGSFRrUkZqVmlaSW1Dc3NESEhmMklG?=
 =?utf-8?B?bXVSVUhSeGVMQzZjK2pwQVFxbGtsWjFwMUM1TVMrMm05S1BSOUZGcVVHNFcr?=
 =?utf-8?B?SVhxdmt0SGVRM0ZTM3hpbTBybnZ6SHJZYjRGMWxkZDBsemR3eWxVYkZUNkNy?=
 =?utf-8?B?Uzd5cmU1QndESnZGSDIweUZ5U1JYbHJDREFRVUZoU21pMmVyZHNad2MwbGlv?=
 =?utf-8?Q?GRZD9da/mRWuU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJtSmltazJuLzlYa0s0TkZRYjhtLzRVQjBmekdvc08wVFQ3K2hjeCtxWjBU?=
 =?utf-8?B?OS8zdE90L1RwYm5ucTQwU2hmTXd0THF0UWFIN2trbUxHTmVvMGxPSm9HVWsy?=
 =?utf-8?B?YjMwUXY0R0dXZWJ1THh2Z3FZTlYzVCs0K1RDKzdnUVlYVjljb3NHTzlGelZp?=
 =?utf-8?B?WFpmY1c2WnJ3MVNzZnNMeUplTlQwMUtXZThEeU5JSjdKSW1xbFlPV2laa2cr?=
 =?utf-8?B?VXVDVkZYelNwWC9DTTJ5TGNSamFnV0dMQlBHNGJNWmNZTHFYMGJoK1ROWGR0?=
 =?utf-8?B?c21EYThRd2Nlc2NVU0NzdzVyRytZWHJKaWtiL0NBK2IzNjU0U25DWGxpN3pJ?=
 =?utf-8?B?TWprSml1TVZrS1dXSWl3MlBja1JMT2U5LzFZcUxHRWs5M3ZGNXo4YlEyNWlw?=
 =?utf-8?B?cWxNcFFTRjAwOWpIV1diTWQrQ3RMS2NKWHNEZnlqY0tZYmtkSlROdElCWHFj?=
 =?utf-8?B?UTBYaWVReDVCZHcwWDVYVFk0V25melYrZVpJa0g5VUlqWE5wU0E1VTUrY0Nm?=
 =?utf-8?B?N0tFL2RhamF5ZFJTVDc0aDdtRElsVkN4TnZPcU5HdmlZVmNtdzdaWVFvYkt0?=
 =?utf-8?B?b3lCR0U3VVA4ajZ0M1lYeG1WTHJPYmFCS2pNemhNSnpJeWtMZWVaY2lUQmNj?=
 =?utf-8?B?VTA2NVdXblJPM3YwT3ZoL3RpcEM2d204WnRtSHF2Vjh2TVFqZW9rblcwY20v?=
 =?utf-8?B?WUF3azhUM0EreUh5YThLMHRFWUoxcXI5ditaaWhvQ0NWamNEaU8vcG92SCtz?=
 =?utf-8?B?d0hmT2lnSEl0Qk5PUDV1Wmp6c2ZxZ1J3TGFDSVlwM0U2QlhrZlZhNDU2dkND?=
 =?utf-8?B?TktpcTV0RVMvQWNobFo2cDlRK09KTnJHSkNZdEl0WUNvZjhIbHFTa3J4NFlZ?=
 =?utf-8?B?SXUzZzhXKzdWMmRXQzA2RHgwVWFYV0ZGc2JON1UyUy91K1poZjRwMmZMSWVm?=
 =?utf-8?B?MGpnVjlkclZWaGdiU1luTEpBeEpFNFZvWTRYREM0dUdVV3ZXbEZwNm1hZDVw?=
 =?utf-8?B?eGdsbHhmUXphWU1aVlBHM0lIempsWTYxbUJ2UXl0VjdWQi94UVQwN2VTR0Iv?=
 =?utf-8?B?dkY4YUNNc3hsMzhmekdMRUt0KzBNYVJxWHY0Q3pLYSs2dGJ1R2RjWXdhNUoy?=
 =?utf-8?B?anZpeEpTaEFPSnhnV3IyRi9hV1dMb0RiT3g0b3JOdW1MdnUvcUVmcG1Eak4v?=
 =?utf-8?B?WktWTk9YY3pzeURRRmRJeVhsU1RoZVRoY2lCZkZrS2xDSXpjSk51eU5SNWkv?=
 =?utf-8?B?VVFVWklrTjdCeEhxK1VDYW5JQ1BueHloYmo5RzdHZmQ5QTVzMzdodTBMMEND?=
 =?utf-8?B?c0lNSDY1WXpXVHBRdFAvektDWk1XbWZKTG5LdXYxR2p3VUVpUzJtbWJZWlhn?=
 =?utf-8?B?Z0NkWmgyRHRHcDdUdHFMam83ckE4UGRudCtRMzkycmVRN0YzMW1sTWpvUkNQ?=
 =?utf-8?B?STNUbjE2Vkd3RndVMzBHazgzVWROL3dZVnNSMU90Mk4rT1pzOFVRcW05MzNy?=
 =?utf-8?B?alNnenN3QU04ZGxxRG5iejY5aWFWeml3Z0d5NW1NV3BGQTJaWDIrKzJManc3?=
 =?utf-8?B?ZVI4eW4yeGtUN1JKb09pMmhQMEpJams4RCtGSmc4YlBhTEh1a0pQSDdvTm14?=
 =?utf-8?B?MFBoUXpLQ2QzVHlKV0Z4RWM3cjIwK1F1aGdic3RmN0xSZ3g1bjJFY1RRSFpz?=
 =?utf-8?B?VkZjS3MrY0xZdkt5Slc2a0ZkdmMrTEZPVTVTdVJmaHlrM05CMmhMUzZmZVRT?=
 =?utf-8?B?dWIzTC8xNzgvMnBTUG1pNDdMcjVFWUF3Q3ArMlYvd1FsVHp2cE9udEpsUnVo?=
 =?utf-8?B?QXI1NmxlYWsveHRhTTA4cXMzSEh5Z1pJSWtDZDk1a2NDODlndzhScXdwK2xD?=
 =?utf-8?B?T0VGdDN6c25QTzQyWkhJeEdhOXI0ellVNEtSbmllanR3aUdHRGNrWlhVc2M1?=
 =?utf-8?B?OHdFVXFpTmRiRnN2alRqd3ZBRy9hTnMrQ1hxQVJZUDFKbTVHbTQ2bC9mUVNS?=
 =?utf-8?B?QVhRVTFPSVZVVmNuMStwRHNMcWNIUExGS1pXT28wVDNFSGkzekxMUndRam1U?=
 =?utf-8?B?YUtMbk00RzduNGtPUWlKK0xiQ0MyM0dpekI0SkoxV0NUeEY5K3F4YUlEWGZ1?=
 =?utf-8?B?Zm10cDJWdE9FOXpmRzdSWDRKMkZFVXRaeUx5eXNlVjVHNDRMREQ0aGxRdXhE?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m11HWB8y0K1rHyVUOtBdXJ5tw6vZ6lAtjA7c8ZYBaNg/XjRwr/fZhaWCcE3b9Plfwo6K/HXMLUUPZVe4+D7uqTIeYAbPr5wtzixO90W0Sx79F9pUmjgSTq3g8M81r0/EZwcZVHbNKw/fzYtJ/6Cb58+kp0D/4lhrrPLtMF7IWlXkG//LJVmJZp5wkCx38xR2BrlkK+1LaQCzouDi07gxZIhBLjZ76sA+jt52DCjFctMPVQA/BFYaNK5/Sq4NGOx3I6+RovGDPxNBVtttYSPq82/fqwdR+dzElTWPYhjm0OWjq6rTh9mDnDoBAsSxRNNoEEJGv7fiB82YA7BXmmqPLWFAfV/ep1qTltLZAXr/BJ7TDq+bnJXLjbAz0Dkzekh9W3VntdDCgJn3sXYfGRN5xsi+wmUM2CMETdV1QHYbqEUx3U+Vyjp8G2AAmN+1saxF9gD6Qbfxkb3Qy0S06iqE7+RWAjNrYGPTm8od2jQ1elyoF8RVAdEo4h1Kyi0nnRnMMTlFhj+qqxTk1CWIAemtvi3eWHcQg6jI09yrheGzmhUnB/OI9NsMPK31o1NFWn/23lyWIbS5FA6UBJhwHWhhvWuheXQo8KNrcIkRMwVtXqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2f7e8a-e7a0-4029-c1dd-08dd66e96a48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:24:45.6064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4u1VXYPXN7um9bZBSsWBzfSiO2g9/rMlUxhOiVc/tI9XTSwra0V2Dknh6lva3mDKqx9nw6f9IFJygRUUYcbSuqRby9QiPuwAgVd/W3IGPZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190092
X-Proofpoint-GUID: Gje2fEWgJL_yHXx_xWJBUF-nofe3SdT1
X-Proofpoint-ORIG-GUID: Gje2fEWgJL_yHXx_xWJBUF-nofe3SdT1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 18/03/2025 09:54, Cédric Le Goater wrote:
> This hides the MemoryListener implementation and makes the code common
> to both IOMMU backends, legacy and IOMMUFD.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/dirty-tracking.h |  4 ++--
>  hw/vfio/container.c      | 11 +++--------
>  hw/vfio/dirty-tracking.c | 21 ++++++++++++++++++++-
>  hw/vfio/iommufd.c        |  9 ++-------
>  4 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
> index db9494202a780108ce78b642950bfed78ba3f253..6d717f0e918e47e341114c82ffc2cf520fc7b079 100644
> --- a/hw/vfio/dirty-tracking.h
> +++ b/hw/vfio/dirty-tracking.h
> @@ -9,11 +9,11 @@
>  #ifndef HW_VFIO_DIRTY_TRACKING_H
>  #define HW_VFIO_DIRTY_TRACKING_H
>  
> -extern const MemoryListener vfio_memory_listener;
> -
>  bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer);
>  bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer);
>  int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp);
> +bool vfio_dirty_tracking_register(VFIOContainerBase *bcontainer, Error **errp);
> +void vfio_dirty_tracking_unregister(VFIOContainerBase *bcontainer);
>  
>  #endif /* HW_VFIO_DIRTY_TRACKING_H */
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7b3ec798a77052b8cb0b47d3dceaca1428cb50bd..1fcca75caba19353ad3063ae97b20c15f61564e9 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -616,12 +616,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>      group->container = container;
>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>  
> -    bcontainer->listener = vfio_memory_listener;
> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> -
> -    if (bcontainer->error) {
> -        error_propagate_prepend(errp, bcontainer->error,
> -            "memory listener initialization failed: ");
> +    if (!vfio_dirty_tracking_register(bcontainer, errp)) {
>          goto listener_release_exit;
>      }
>  
> @@ -631,7 +626,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>  listener_release_exit:
>      QLIST_REMOVE(group, container_next);
>      vfio_group_del_kvm_device(group);
> -    memory_listener_unregister(&bcontainer->listener);
> +    vfio_dirty_tracking_unregister(bcontainer);
>      if (vioc->release) {
>          vioc->release(bcontainer);
>      }
> @@ -669,7 +664,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>       * group.
>       */
>      if (QLIST_EMPTY(&container->group_list)) {
> -        memory_listener_unregister(&bcontainer->listener);
> +        vfio_dirty_tracking_unregister(bcontainer);
>          if (vioc->release) {
>              vioc->release(bcontainer);
>          }
> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
> index 8e47ccbb9aea748e57271508ddcd10e394abf16c..d7827f7b64adf3e2b41fafd59aab71e0b28c1567 100644
> --- a/hw/vfio/dirty-tracking.c
> +++ b/hw/vfio/dirty-tracking.c
> @@ -1267,7 +1267,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      }
>  }
>  
> -const MemoryListener vfio_memory_listener = {
> +static const MemoryListener vfio_memory_listener = {
>      .name = "vfio",
>      .region_add = vfio_listener_region_add,
>      .region_del = vfio_listener_region_del,
> @@ -1275,3 +1275,22 @@ const MemoryListener vfio_memory_listener = {
>      .log_global_stop = vfio_listener_log_global_stop,
>      .log_sync = vfio_listener_log_sync,
>  };
> +
> +bool vfio_dirty_tracking_register(VFIOContainerBase *bcontainer, Error **errp)
> +{
> +    bcontainer->listener = vfio_memory_listener;
> +    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> +
> +    if (bcontainer->error) {
> +        error_propagate_prepend(errp, bcontainer->error,
> +                                "memory listener initialization failed: ");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +void vfio_dirty_tracking_unregister(VFIOContainerBase *bcontainer)
> +{
> +    memory_listener_unregister(&bcontainer->listener);
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7f354d86cd14270a70dc990860ad5b69f0310719..7737d552f310c54ae2e035198a1a83da8c3199dd 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -411,7 +411,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>      if (!QLIST_EMPTY(&bcontainer->device_list)) {
>          return;
>      }
> -    memory_listener_unregister(&bcontainer->listener);
> +    vfio_dirty_tracking_unregister(bcontainer);
>      iommufd_backend_free_id(container->be, container->ioas_id);
>      object_unref(container);
>  }
> @@ -563,12 +563,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>          bcontainer->pgsizes = qemu_real_host_page_size();
>      }
>  
> -    bcontainer->listener = vfio_memory_listener;
> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> -
> -    if (bcontainer->error) {
> -        error_propagate_prepend(errp, bcontainer->error,
> -                                "memory listener initialization failed: ");
> +    if (!vfio_dirty_tracking_register(bcontainer, errp)) {
>          goto err_listener_register;
>      }
>  



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5099C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Vkr-0000cP-U2; Mon, 28 Apr 2025 17:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9Vko-0000bt-7s
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:11:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9Vki-00011z-37
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:11:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SL9E59030279;
 Mon, 28 Apr 2025 21:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=jook3DkN6ENNZdC1EbhgT9aeMYKoBx82AiYXAm2V5iI=; b=
 KKTHlnsPZAOfynKreWTORUENme1Zzd7i3A4J9pMS1KOVtixOPCIkJomLxFa9ayDp
 +VZ4F6lT3qoCLuP5by2Uqcjrm1CJkyKKL0r52ozsWRGtB7gOwncLZyp+mf4ubqgq
 IPmY0NXDW7+NwiAOcs6APO1hXxVCkgEGs2MAXyYtGQXFmnFG4FPogTTiaNWsp32L
 nyfGjsP2gUUakY6zkjR773gAm8laMHl9187TsaRaVfB5s30S4Y4SwBVZdV8YTaW9
 DT0TrgFEssAaB/ZSaDXAr950n5R97EO6clsXLj17oehYnxg9KwxAOn1u6yS17op2
 2MCNwQq2H3RmrEszbQncCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46agsur2sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 21:10:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53SKTQC8011420; Mon, 28 Apr 2025 21:10:48 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 468nx9g1et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 21:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gst4CPUbQ5ndl3SvWJ01zW8os6zIwiod9GU1KVf6AnROjOBOVSNEpsz/W9VoqEjqMxLkTCe/fLBvKZT8HB1RsPEr+pP8JgP1GFl+GI2VfxOxGlUQQlUlUq2aQiU9r5nF7NCasLjWGr7l7eZ6vCTDfiaExQs2KkbCwWRLYg1T4hPOkeb+vOiohy6UIh33kqE3OEnieGXSE6w8Zz156iwzf+zGXn1imHe1RR2x9sPph7qxNXrHJRiNpPOZj0nrf9HUiWqUUeRSFK0+RxMHJlEc9liUsm54ZquOVxeYOBKb5pvdEG0Gji0rkHrwBBXBuyuSWux88FovgOECDvwzQg2M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jook3DkN6ENNZdC1EbhgT9aeMYKoBx82AiYXAm2V5iI=;
 b=pzDKF4ZYcGGcqtF6no9XikPMnZ4U+VK4TNA4y+p0d4aZ8KrDcwqJG68OVbrPtd+io2tPHAUP0tngjQwNu4OuTzFUnyf5FoB+GSoFQk9vpjD0JlakNWvc+i5yCqXSqTrbAcAhb1MLCBfxS7Sr4pr4YjniVs9o7SKjCY9XJmkRMLrRpgW1ADvQkSKkbZwbpfM8KKrp08xaJoumr/qJlZueImpRuYND4kQw1hDa0iqFb5zWHGmP3r+EtpaVqbaqMFKi9RBE1vtMp/XYytiAcDfN6oLsihv+FtwRljui6Zbm1fkYe8iqoYcpPiTiS10ByR8A1ExxXXzqbwbbQyhhVb414g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jook3DkN6ENNZdC1EbhgT9aeMYKoBx82AiYXAm2V5iI=;
 b=apFTCxTP7kfPqwzxDGyVWwmJ4VLXyfNGb4ayMTgomu9icRP/DF5xtw1oq57CogzXEjXOm11v7+2YDtwzBs1h32ecaembROoV5k2xIS/NPTyAZRLKQmAg5RJcEev4Gfl1/9Uy6QA9fsiJdaBrW73nXJn5/UMr1toymMAEENG9+9g=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 21:10:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 21:10:45 +0000
Message-ID: <48170322-2934-44b9-a7b3-bb29d8523ade@oracle.com>
Date: Mon, 28 Apr 2025 17:10:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] amd_iommu: Toggle memory regions based on address
 translation mode
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-6-alejandro.j.jimenez@oracle.com>
 <328a5ac5-c025-4fe9-8efa-5f6185aadb40@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <328a5ac5-c025-4fe9-8efa-5f6185aadb40@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:208:32d::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: a05c36b1-e080-46a5-fb21-08dd86992433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODI5OStxVlkvS2ozd1NwUXRUWmxEdHU3V0RZS2pDdjVnU0JoVzNEdnhsdEJn?=
 =?utf-8?B?NGxSYjFFcG1od0dUczlldm9QNVN3RW0zYWRqeFlJTWlGMFBTOVA0bG5QMXIy?=
 =?utf-8?B?QVVSMGZxWjd4SUlFL29QZktrT0JtTmV3V2s3Vm03L0lua09hSkpwaVdVTW1X?=
 =?utf-8?B?REtFc0ZyUElQLzRwemwyM0tnTFNpOU4xbVlVSHhlTkpCOUFnejZSc0U0MnZT?=
 =?utf-8?B?YUpRcnUrQzltT1pyc3haVTl4NGQ0U0l6b3oyZzRoSW1XQW9Wd1J5VWRnalpR?=
 =?utf-8?B?enY2RUM3SnlvbC9NcDBwWXYvbk5leEppOVhtWEljTE5ETHBsR3VEbWZlT3pG?=
 =?utf-8?B?YzdTV1U0MXp4bWlHMnRxZ0hxUEpSWk55SW0xc3Z6elBidlNjUUk5V29QNEdl?=
 =?utf-8?B?aEdNQkFuYlRIbVR2bVQ1VkZkK0haS0lpcGpKbjFkbEFhd0p1UlpSbFhmdDFp?=
 =?utf-8?B?TUpZSnhEaTBxcWw2SkZ6ODdsM1c4eUVaSTZDZmtBeU5LVHJJaTNJd3NIYm5s?=
 =?utf-8?B?TVZudVVCV2JzVFdSbklJK1ZMU2xRT3RNME5LQ2tVZ0MzN0JOUlMwRFpwR0tz?=
 =?utf-8?B?aDEyVXJpSkw3S0JZVVAzRXRpQi9QeGtlWkNxZHE5QndGSkpVRlBSaUNlbUpz?=
 =?utf-8?B?QlV6aW9JUGpLd1NlOHA1Ty91VzBqU3FVTlhMSHA1TTlyWVhkUjVCb25Ia1Fj?=
 =?utf-8?B?MjZYVVdZWUZ5QWYycExleXVIOU1lVGZ4UHRaRmozeTVkOVhhQURFeE9TUGI5?=
 =?utf-8?B?QTdkMFpvRHVsWEJiWmJ6V1ptM3RFMkFNQkxEN05WMEQvc3pFdFpWWHZyRTQy?=
 =?utf-8?B?VXJ6c0VhbERuODJBMVdWNmFQTzc5RXlQd2Y0eGRNQ1M1VjdrUzJFR1VJUEti?=
 =?utf-8?B?M1JaMFl0T1p3Y2JHcmNiaWpwblZWRlorWUVYSUsvSENscTYvc0toRmpDVXJO?=
 =?utf-8?B?elNJSHNxQVFsY3dPT2hWNU9LRVdYNUFpczc2Y2VUQ2V6YnFubk5HTSszZldK?=
 =?utf-8?B?VGZLODRITC9wL2RXeUM1bFY5RHdxdGZFRk9oLzAzTlV3U0ptT0c3YjExQWtq?=
 =?utf-8?B?dmNxY3FVdTBPV2lKTGE3M0NRVnVlNmtyZElSaDRQb2xDekZnbVQzS1FtblY3?=
 =?utf-8?B?NjBZUDU2MlBnY0NZZDhnV3NDOU45YlhoMUZWRGhrVUZmdEI4clg1cGI4NG40?=
 =?utf-8?B?L2dtSXp3VFFMUXV5bVByS0J3b0FucW53Mi9USy9IUzlnOXpJeWhiWDFQdDRO?=
 =?utf-8?B?YmlNWXpQd3N0V2RIdEkrUjhyWXc1Q05mTzJxMGZWcUhiN0x6dThuaS9CVTRq?=
 =?utf-8?B?bFJBQVVXZWxxTzNQbDdCMWZ3cTl5MlFqM2p3cnpHMUFjYmFvMEtzVEQ0S2Zv?=
 =?utf-8?B?YitYVm1vZFZiZkJZSXNkcTRRTXo5eG83azdxZ1pEcnNzYm1NNUlGRmM0cGk5?=
 =?utf-8?B?OUNKZDBiR05tVWphUHNPMFpKd3BoN3YzL2R4TGRHUzlYd0JPR2lwZWZxcDRS?=
 =?utf-8?B?QkxGa0NWcnRhQ202NSswZGF3cXY4UnhnNzk0bmE3d29CUm5JaVRHaGt2N2J4?=
 =?utf-8?B?SzNPN3NpcGlQNDErU3lDOHl2WTBkSnYyVXhNWTM0MW1UR1JQcjllR3VNWE9C?=
 =?utf-8?B?Y1JaV2Q4c0tpdUhBM1hqUlpuVnJBMG9IVmE0aXdlSUxhUnFoMGF2K1dMeEp4?=
 =?utf-8?B?b2w3UDFLTkd1R1lCSGRuY1VCdnAyM1ROblhxNDBXNk1GNlJFMHZGMlJtb1o2?=
 =?utf-8?B?dTFxbG5kSVpac2F1NGloKys5d3JHaEdJNytrejJHQ3g2bndUMU52STdvb3p2?=
 =?utf-8?B?RlNrb0lKM0xHQ1NDL0ErUnl1Tks3RmorR3Ztb3hPc1RzaU5pSm4yS2orWXpu?=
 =?utf-8?B?cGY2Ty9PdDhMUkQ1Ykc4REx3MTRUajhvdTJSelFHMHEwTVFNajN5NW5DTXRK?=
 =?utf-8?Q?Bk23Sk0iP5s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5267.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1FT0NmZkd1aW1OUWtZbUVSQU1oL3JWK2RnRkFRR3prdjJzb2RJM1hLVkd2?=
 =?utf-8?B?Vmsyc1dWN3dROFQ3bm5EeEhnMEtnNVhPRDBEK0lPTWY4S1owSHlNejlyVjV5?=
 =?utf-8?B?R21WdWVLMGhCeVZpWEt2dUcweENOS3U3eW8xUG5jNXp6WlJMS2pmMHo4YmFL?=
 =?utf-8?B?SkRMSHBxT1dnT3hLaG9FNWVwRFRVQW5QYUhpQmZkZFdHOEhpVmlQRms2UGNw?=
 =?utf-8?B?U0VNcHI4TjRTby9CSk54bmxqQ3oxUFIxdTJXNzN4T1hIY1hEcEdWRm9uWEtQ?=
 =?utf-8?B?NUxMTGtyYnVtOUR1a01mM3NuelNXcTcwNTNIbklmL2tvNHlQd0lxekxDRlJJ?=
 =?utf-8?B?UEcvL3JBM1c3MmlCM0dnYnluU1hrbGc4N2c0SWw4UDZhYTVsWHVZSEVSOHk2?=
 =?utf-8?B?aUNZMVhKWU5odjQzOFpJZURPNzdQcjlLaloxRkhZdzE2SmYxSE9xWmZKYVdI?=
 =?utf-8?B?ak9tYTQrMDVCVEx5aUpxUlQ3MDhUZ1ltRVJNVkFTemJ0aFhXVW5qQkdienpC?=
 =?utf-8?B?RUhHU0ZOeTM0VEoyTm1EajNBc0s5SGhkYVNXUnlZS2VoZndhMFc4T1BrSDE2?=
 =?utf-8?B?dUZXMTBGUm9VYlFkWitvbi9MMVB5emRxMk5hQnN2WGtENHFpbjk2Y1B5WVNl?=
 =?utf-8?B?RkpvUmV1Q1lTamNaRVpjMXI1b21nQjFiMmc0T2pRNUZTTUlHY3ZYOXd1NDgx?=
 =?utf-8?B?cmN0S3NzYVYvSUFESWZwL0s5TzFUVjk2TVZvcVJQSDZvYXlEVlN4WlNmNGtr?=
 =?utf-8?B?czhOSE81L3p1Y1AwRzE0Tzc4OUoxZ1hmNFlkZFRYNVRSZkFsUllXZzJXRm13?=
 =?utf-8?B?amhDcW10Uk9iZnJuMldjbVM1eGQra2w4WFpSRlVSTHVNaXBycUhlaHRzdWQw?=
 =?utf-8?B?RDJxQUE0MUZxYXRld2JuS1ptbzdwOTQyaS9KcWYwaERoNFZhQS9kZk5LeVJ6?=
 =?utf-8?B?VWwraTF5ZExZN3EvYkc4Q0hyK05BbnhXaUE5V3d4WklYaUtHU2lFVnJaM09M?=
 =?utf-8?B?TmVuU1VXZXpQZHkzd09KeVpzRG1CTzdXeEc5eTNTS2xYdU4xaURId05maVNi?=
 =?utf-8?B?ajd5VXBuUEppNWRydDFwRDBERXdTS0xNS3JwZHhBQUhjZ01XZGZ2bW1iTndK?=
 =?utf-8?B?S29sWDU1R2M1dEpCZCtGN1dkL29hOTNBZDlaRGRnM1pSdFJ0ZVQ2anV2Sm9t?=
 =?utf-8?B?NExtdHEySXlPd3MyelZEZENwallkZjFNNk5MTkZYRTYxMkVodFBmbWcyVkJP?=
 =?utf-8?B?dVM1QVpiVnhnZFdzUnNiYUlKU1IwQUt3aFVOYktHSFBJY1huNmU2b1lyanZR?=
 =?utf-8?B?ZytuZTkwUHBTQmZENVR0V2lOTzBKOTZVNlJlaEU4R2tudW5xUGtVN1JzNGZp?=
 =?utf-8?B?SGluSmZiVVRacGVXVFF3RWxvN20xVkZ1TDZ4QnpwbHlKYjNwQzB6K3JQbE5v?=
 =?utf-8?B?UEszNk5GMmNGVEN5UU5ZRU5Qc1I4aGlTS1ZGdnUwK3FwOVIwN2ltNDBlQ0tO?=
 =?utf-8?B?TFkrYUZLVUtOSzlURkphNGhNMmlZWFp2Qnp1Y2tNQ3ZEUm1DdHFkbC9Ockhx?=
 =?utf-8?B?ZHI5V3lHK1lHcm9lb1kzTTJtOUVxeUlnY1NySjU4dnp0REI4OFRVcWJtOW9l?=
 =?utf-8?B?U1JQZzlBc1lIdmRkNTJWd05JSjZLc3FsNE9MZitwMFkwcGlrQVlpTndGSlNS?=
 =?utf-8?B?aExxRGRLU0RwQVNqQmZtdUYreFl3dVZKc0dLbW84YUw4WVQ1a1pYTXNDWFJn?=
 =?utf-8?B?Q1RvditOL0hBMmlQc01HdDRVL1A4b3ZuQmR4cUNmZmhrK0tKTkdnTDJtNHhy?=
 =?utf-8?B?MWE4MlJCUjFENGd6OFl1elVSTVRveWFaYTBlWnpVRU5NeEhVcGc0czRBRUNY?=
 =?utf-8?B?cTlLcExaTHV0eWl0UDRKUlJ5eGtHU1h1UUhsZ3lwdDRxMUJzTjhhTC9vOC9s?=
 =?utf-8?B?bEFTS0dsL3lSV2JTU3Y3UmZJVThmNEpVaE5JUjhaN0RTRnFqaXVQZlFic1Vx?=
 =?utf-8?B?aEp4eER5YVZuS3ZVT01jREpySDU5WW5RK3hrT3o2R0lwd2VyUmYvcEtEV3Nv?=
 =?utf-8?B?NlZoNkJJcG1aZ1VFMmk1d3BBaUZ1a1dWc1Rkd1NzeEh4amduRWx0L09jcDlu?=
 =?utf-8?B?RTdsbDVSbnp3NlBEK3ZraVNlVEpmaVRranVpNGplcitSa1JCREJoemFCa1Fr?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pcqqPBaUNJoRHXHslPwY3dQ6vy97dPueYQpvKfZrSLAaG+I45fhJctzAbuHUMe3DVqXMJl76e2LmfX9ThfKABeJk/YobfOdezb17NIXeYYwhgVqoTTtpQErop5+v1o4/aGekfOt8/moyMSx2iJ+CkHPXEFRj2kU7YXGqYLJABjGywg9qpZkLM4ljZPaIbe4cpgKyw5+R1HeC7PZio7PFdFKkxAuypxqUmxnignq+bThH4Vz80r2kyPlELXm4vDzBqtrpu/2A5tkV09qVunldQ/4qpFqDodpZZi9O19FP8qheeVX5c/TvqJ3Z4bJNgepZyZGr0DM7ueRFDOSzZblgA789spK13wBu5+M2OwoYpIXYBZwkMQ3s0mtkaCwMKAchS0iuvmsQKlkCYUdAQ8r/XjiXmvTaArPOA6ZRvHZJjFlnffxQAarsfb/oIUupUZh51OBswIYwI15s1Z9C71l0g+nOA6LXaVAT80ElSnS1KLpYcS85KEtvXEKfjSWgL9hDpQWoto8vNGKWWVOTjsgzNpx2OyPUEb4DoleOlACYFEjZ2tGI5CH8vtJjc6ubkjePs8EnwpIKxc3pe6roFpfVMF8IXZ3lTajDG+/q8XVeYPc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05c36b1-e080-46a5-fb21-08dd86992433
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:10:45.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcV+BG4+ullkuyogeb+wwAMFWBACIP8rgje0Oz7GPfVfk1EZepnnDV9QRthmU0RVwXSlku0Q9YGYOtc5qBmRRUqGSCWz76xcM1A1BUnnQCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280170
X-Proofpoint-GUID: C-U4eyvm8ZogknzWXVV8GzLRidw0x56g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE3MCBTYWx0ZWRfX1SBOcWtiK6u2
 ca7SQQO6c/8fofYcUUcddnPSeA315KNWSLqqznYByZAsUnvpCO+U/Dbp5Kj1l9XlMBY/E6j1s3A
 SHEIgvuwD9DNbGExFQj2EkJkUewxCwPn7RSZgGLMxRyDlj39ThWuOw4+DU6G6RO7RVK7ikfYYiB
 EYAi6TNNpiXchlNFwUwkQ6f6jWrVy65wKTQNQvWWrdX3u/V9Ez/db4mBtNL8geO3q2feaOJchiG
 xhT1bUrW2jilGL9FaA3YNRm8ALkEfnnqJMqle+jPfXLq972M+jv0Q6/ThlP/InGqcvX9K+Vkg/J
 LzBGHKj9k+7k4UghIGi3De/B2jJ8U9ueWKC+oZLxCysF/i2t+mGX3+HnOHaHzsR8wosG0ee62QI
 paxpbkkl
X-Proofpoint-ORIG-GUID: C-U4eyvm8ZogknzWXVV8GzLRidw0x56g
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/22/25 8:17 AM, Sairaj Kodilkar wrote:
> 
> 
> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
>> Enable the appropriate memory region for an address space depending on
>> the address translation mode selected for it. This is currently based on
>> a generic x86 IOMMMU property, and only done during the address space
>> initialization. Extract the code into a helper and toggle the regions
>> based on whether DMA remapping is available as a global capability, and
>> if the specific address space is using address translation.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index ad5869e72fdc..3f9aa2cc8d31 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1529,13 +1529,31 @@ static const MemoryRegionOps amdvi_ir_ops = {
>>       }
>>   };
>> +/*
>> + * Toggle between address translation and passthrough modes by 
>> enabling the
>> + * corresponding memory regions.
>> + */
>> +static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>> +{
>> +    AMDVIState *s = amdvi_as->iommu_state;
>> +
>> +    if (s->dma_remap && amdvi_as->addr_translation) {
> 
> Hi Alejandro,
> 
> I know gnew0 initializes addr_translation to 0. but should we explicitly
> initialize it to 0 ? in order to make it more readable.

I am generally in favor of making things more explicit, so I like this 
suggestion, and would also initialize the notifier_flags i.e.

@@ -2152,6 +2152,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus 
*bus, void *opaque, int devfn)
          iommu_as[devfn]->devfn = (uint8_t)devfn;
          iommu_as[devfn]->iommu_state = s;
          iommu_as[devfn]->iova_tree = iova_tree_new();
+        iommu_as[devfn]->addr_translation = false;
+        iommu_as[devfn]->notifier_flags = IOMMU_NONE;

          amdvi_dev_as = iommu_as[devfn];

It is possible that others consider these redundant or bad coding style, 
but unless there is pushback I'll include the changes in v2.

Thank you,
Alejandro
> 
> Regards
> Sairaj Kodilkar
> 
>> +        /* Enabling DMA region */
>> +        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
>> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), 
>> true);
>> +    } else {
>> +        /* Disabling DMA region, using passthrough */
>> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), 
>> false);
>> +        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
>> +    }
>> +}
>> +
>>   static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, 
>> int devfn)
>>   {
>>       char name[128];
>>       AMDVIState *s = opaque;
>>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>>       int bus_num = pci_bus_num(bus);
>> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>       iommu_as = s->address_spaces[bus_num];
>> @@ -1595,15 +1613,7 @@ static AddressSpace 
>> *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>                                               AMDVI_INT_ADDR_FIRST,
>>                                               &amdvi_dev_as->iommu_ir, 
>> 1);
>> -        if (!x86_iommu->pt_supported) {
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, 
>> false);
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu),
>> -                                      true);
>> -        } else {
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu),
>> -                                      false);
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
>> -        }
>> +        amdvi_switch_address_space(amdvi_dev_as);
>>       }
>>       return &iommu_as[devfn]->as;
>>   }
> 



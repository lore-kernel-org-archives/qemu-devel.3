Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E48C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5RAJ-0005Ts-OW; Thu, 17 Apr 2025 11:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5RAH-0005SO-PR
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:28:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5RAF-00044Y-03
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:28:33 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpXUO016516;
 Thu, 17 Apr 2025 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gkXVYI1l1zz8YItCZJDlFkVp0j8UlFppVeZNzbixHYw=; b=
 RUTjvh+tX1j3TAm4OC6R7Dl05dCv0qR3o31bOCv63Rl13CpWT25tEgC3lmBzCHes
 1yD3tKaZAv8+p9LSaN7e1nFR6JW1zi4Jkf5fM7aUfF1psYU1hwjP6WWxQ7zgOGIQ
 pu0bEzHcQgQXAKP2fzoKy5wT43PNE5X8qmOIH1NO57HKoy85/5312OKVJRW341u8
 QF56DdP+7kyDmRKPh8MwxljbJARoXpT2SziZc/dONzwaos8qTAgZ7sOZZlVcQ1at
 U2MAR5kgaNx+RKGzGFeBbt5TmedG4cGr6UHwJeqe+ryieHMKichafBRmhxXHAlNT
 yCq31hl1WEfmuKiNoaEQgA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180wetxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 15:28:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HFFENh008524; Thu, 17 Apr 2025 15:28:21 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011024.outbound.protection.outlook.com
 [40.93.14.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460d2te8wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 15:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAAf0oPz5ssOaOuKmD39Cy9fXvBCE7u9AD+MfzrFBmMTHZWyur4Y24K3M1pZ5LLESkaMwc8tLfBtw9euN9qYa8mlatNR9s96rPPv/58zPqGXI4FE2feKpd3iNWdq5uOmMqKfU8hQjmiog7eBqi8BaKRU8pIe0tA2gQ25gH5xSUh/sW9Q1y7rgDVJhxboGTKW7Q3AEySJSV/4apCCT2quTNKDT9JqH1PxDLtdPdYypHa7RnRNh1++PxYg5nObioSTadaKSY8NMkL5hdz/LRy7Vd6RdKU5qlJjSqaPut6hjbEAH4G2ZdmuhgSf5rgdsLtImhmYz0EIiQjuLmN5+D1OAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkXVYI1l1zz8YItCZJDlFkVp0j8UlFppVeZNzbixHYw=;
 b=B66rclowV9LeaghHqvfT0ia6lFZjUzMp+lYA4R0xgAeuRNavHdCPDbLtdVd2F3hCiPS4XWFXSfws25ag0ZmxjAMQf5r8tRrWXgv05aqykRG7GFFjh0E68kXrQuZtTZ9kCUWqyKaTiS8OxMN+awV5Jflrgomyf3qV/3mBRM5gUN7tdBm0VEFkPk/XYGBhw/+5evesuydIkEhGOUSqX5VBdrnZ0qHiOk7WkSKTtogswa4jBMGZfRWPwAG+++FwRzHIuHJqOJL5HEkEBeELE/aIJHN2w/Fa1xDHz6Y4yCoXE3iEnaQXfWTVSXcbVLfDiuwi6Kql8Erw5NwYetz8oRJpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkXVYI1l1zz8YItCZJDlFkVp0j8UlFppVeZNzbixHYw=;
 b=vGopgHTM/XrTZwhuWb9ZbpdRX8neZkKyM6ADxdXGHhUS2jUtgb1EtSQhJmntHzB202OfK1K/GhghhGPeMCjlf6/E6TWHTDnWHT2nnT0zfhIZF9G+gEWorHGpOVMYNim+Ze1PRE7jtqSvm/v3LyyxSwaUZYnUA9Q8vVBJfARrYXE=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS0PR10MB7270.namprd10.prod.outlook.com (2603:10b6:8:f4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 17 Apr 2025 15:27:51 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8655.024; Thu, 17 Apr 2025
 15:27:51 +0000
Message-ID: <4162f7d1-a4e3-47b7-8288-d8e320ed18b3@oracle.com>
Date: Thu, 17 Apr 2025 11:27:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] amd_iommu: Add helpers to walk AMD v1 Page Table
 format
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "peterx@redhat.com" <peterx@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "sarunkod@amd.com" <sarunkod@amd.com>,
 "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-10-alejandro.j.jimenez@oracle.com>
 <32609749-864c-4fe2-8c00-8dd8e0ab2efc@eviden.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <32609749-864c-4fe2-8c00-8dd8e0ab2efc@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:408:111::35) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS0PR10MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 37efa427-4dd3-43f0-a95e-08dd7dc46a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTR3WHg1N0hNUlpocHk2YWM1NWIyZWV5bVNyRTRwOWMxaXdvK0hZZWlPUis4?=
 =?utf-8?B?OTRwTmtJRlV0MTM0OWNZTFJjQUt3T1pXS1BUbU5LM2lhVEdyV2JzY2FGb2FF?=
 =?utf-8?B?ODBoeHYxdDdwalA5a21mV3pDamhIZlpEN2tCaGprbmFCZHYrOVhsT0dXZkJn?=
 =?utf-8?B?SlA1dVdGOXlEcitrWnI1eHZiMmIvbHdXalAzZmUyNHVrTlBQVW1oS3FlRm9I?=
 =?utf-8?B?a3ZRSVVsK1lTS05ZWm1KeUlSZCsweEZMemR6aHF5MWFlMGpyaytIY0FGb0xk?=
 =?utf-8?B?NENoTFRSMTFlV0hlb01qU1BmRWJQUjFvSXNjM2dLVUo5RFFnYTlJdWROSWo0?=
 =?utf-8?B?MUdYNWFsQmE4bTdnMVpSd04xL0hmengzckpuZDNOdlYyZFFVNnY3bGl0UVlN?=
 =?utf-8?B?alZzVnU5bXd6RE13NlNSN3F6eE9iZXU0QTJKQTFxbHZtaGdxRGNNaHRnRTFL?=
 =?utf-8?B?VTYvZU1NWVpnNjMvR3dFRS9BRG5UYUkvNURHNE5WU0ZqVlg2aEVQQUR5WlpX?=
 =?utf-8?B?R2gyU0ZNZms2bW0vcndXVG5HbGV5VzlYYzdjR25DZkVkQjBkU0NlZ2svSExO?=
 =?utf-8?B?djVHeDlKOVRJamVsQm93Z3YrTW5oZE8raG53WjRjRGF5NE1GMkp5aXMzdHh5?=
 =?utf-8?B?cE80UUNpUnovWEpSREFnQU55MnlHMVJQQXdLTVJnYXdOQVJNN0NXVXUwbHBJ?=
 =?utf-8?B?cG1ObXFJVnFJNGVzSGtDNisrM2hIbXlmTTRBampLREd2aVlTMW05ZVh3V0xF?=
 =?utf-8?B?UWlVRjFUWmREZEoyamNwUjVNaDU1eHBNc3lIckFRdWIrelFvYmdSWEJBM0Jj?=
 =?utf-8?B?dWtUOFFvYlI1WlNVSzNDTDZsWjJWKzRxMWdXOXNZZXZVNXRnVHRKTlBKZ3oy?=
 =?utf-8?B?VnJmZUJjdDRadjRvVE9RRktIM1k5MHY5SG5EbW9HalRPVzd0ODNUUHg0ZTFV?=
 =?utf-8?B?a2E5bHpKNFBTUGF1UGl6LzB4cUVmZHcyNVVRL0dpblRmVm5sTk5qelptUk1P?=
 =?utf-8?B?Z3A5Z1AyMHFHQUZzOFhjUFlWQkU5YTR6SXlnbXFFL0V3RCsrUXpuUnBXQ3lq?=
 =?utf-8?B?Zys0TUcyWVdBc2lGdGZRUVF4K0s1VCtnc0VCRW8rMGMzUGlOVDE3T1U2VmFT?=
 =?utf-8?B?cng4OG5LZXZlK3ZOY0xEWTFObEduMzFkRUgybGt3YUxVanVueW9ZNjI4V1Bj?=
 =?utf-8?B?dkl2eUF5ZEN4NGZjQ1plYjM1amJzME9SRk4xUFh2L0ZLaGtRYzhUbHQxVEJ1?=
 =?utf-8?B?cnVOajBOUGtRT3NKaTVOc2Q4b2hPbTc1SWIzTmU2Z1MzcXQ4TzBZc3I0S0M1?=
 =?utf-8?B?NnZFVlV3NW5qaVo4NEZPRTZsUEdCekdQYnI4dlhrUjBhY1ZpSUdSd1hsKzlv?=
 =?utf-8?B?SzQ0UnQvN0JpeHNIZHprWWhIdXBXaEEzSkhORnc4cEpVaU1SNWt3bnhUU1lL?=
 =?utf-8?B?NWtlbkxYMDhWWThuQU9pSTd6N1hjZndNOUZDNDhvcmJTMndtSFpEbThMSXBN?=
 =?utf-8?B?TnJKNlNLQzEyUSs3aFFUWUdjRjlGZXRLTHlDL0taQU5KWFBZb2xScWZoM3c4?=
 =?utf-8?B?YmZOL3FLclVhWUFJY1cxZm0zWXpMME9LU0xuR2I2b0xwWnFnNWdBR3NiTWZj?=
 =?utf-8?B?NjJaeDJBZUVNY0poeHp2ZHgrUnU2K0dld09yYkpocm1CbWZ1T3JRZjBHTHls?=
 =?utf-8?B?MGdWMjBJM1BKU3VIWmExQWtQOTRvZGV6TXhqYytCN0JKMTdoUVIvazNkNVNH?=
 =?utf-8?B?czRjTU1QUWNIYngwdGR3TlJXL2kvQWo3ejJSaWdUOUsvakhKbEVKeHNzdnBI?=
 =?utf-8?B?djFINE1udTVZc0NPaVlGdHFIMmN6WXplOWJ0R1pQQUlUenR5a05aZ2ZOTDFL?=
 =?utf-8?B?aEtNOVhvdWJGVFV2a1ZsNit2WG9aa0Q3TW5Oams4aldyeXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXc0bmlvbGZ6UWdDYk0zc2g3RkswV0hiSVUzL3VmWkFmKy9DTDZCV2ZlZXRx?=
 =?utf-8?B?QnZzeUZ0dFpvaWxxckpCWkxpbFBEOXpnV01lUURydkkrbTUwOTNZdHBtbG1O?=
 =?utf-8?B?TUhDN1VCNkE5MWtZYVhkblZtd1B1VXQvakFmYTE5UEF5M0pxK2lLTlQzZFUz?=
 =?utf-8?B?cGRnMGdZKzFYL1c4aHBHNmdmSUNIZzJSamFUZ1gvUXlsQ2NSYzh1akI5YnRT?=
 =?utf-8?B?YlpnRjJZV3NvamliaVdmK0hBZFU3SUw3WU93RllSd1AwSkxucGtFS2VsbFN5?=
 =?utf-8?B?YU9MK0Z2emZqa01QT2ViQVpMQk1mNlY1VmhBaXJFTEtHTEhtSkFLc25EU0NS?=
 =?utf-8?B?dDVueDZBQVNjUTBBTys0SEVCLzZHZ1FJZ2ZmMG5WTWRsNXZiaFpRcjUwYVhR?=
 =?utf-8?B?SktIdW12TFRjQmRxYkxhZXlzeXJEeWw0NDh1b0dIQkpwTUhNam1LZUlxbVox?=
 =?utf-8?B?bTd4TENBV0dvOTZRSHNjdDhFNDJFQllTeGNKOTZycTlMSVZRZzJ0M0drMDFl?=
 =?utf-8?B?TXlSSEZvZXViV1Z3YlE0ZVMxcWRLdEhzNStnblhHaXlYdmpkeDFhMEZTdFFH?=
 =?utf-8?B?dURtYXpuTkd4OGE3d0Q4V1o4Tk9LSTJjcmFrSHdod1JRQkRlUWtjd1poVGZv?=
 =?utf-8?B?NWhLbkdKQXdHRThuYVBMd0d6a3pEYmtQNXhjYndBY0g3NmRsNit3SUJEK2VM?=
 =?utf-8?B?bG81TEhrOWhWZGVBc3hRZXRCVk5BTThRVW5WUFMwVHJqWVlPUVlPcnlNeWdU?=
 =?utf-8?B?VnUyNHQ4NUsrRzNQYmJKTUI4UisvVzJ0Uzl6SGdad0RXVkViR1JtZ0RzZTZl?=
 =?utf-8?B?cnNVWWxab296KzJ2S1FGMWpHRkpiNm5PS1lpbVdZbWFxTDBsU0g3TW1pSXJW?=
 =?utf-8?B?c1pNOGNiQWpMRkU5WWVrR1l2RWFSVEZScUxOeHhTZEFFNEJWMnhyTUlzNEoy?=
 =?utf-8?B?cSs1WUsvbEphaWFtdDRrT3pFMDBrL1I5U2JuSEZPSTQ5Z1FOZG9DMXQrMWZL?=
 =?utf-8?B?RHdKOVNtKzd1S2o2MWpWRHlHdSswSllXeTUydlRPNWVIL3RTc0RWa2FtL1R5?=
 =?utf-8?B?OUcwUDgyK0lITFNrU0VkbWIwQ1lsemtZZGhUN1J0SGRLcTlnQXY5N2ROK0ZS?=
 =?utf-8?B?Skk2bWZSQm54T3ZOYVJIR1J0WGRYZ1dUcCthZEVzRWhzQkJ0T0JPd0xUN1Q5?=
 =?utf-8?B?b0hhU0pPNVo0VkpzU2doRHZvdUZ0cWV0aWRiTjZzMmhUUHNydERCcTI0T2lv?=
 =?utf-8?B?ZWVZSmVDZDc4WjZ1TkdCZEh5NlVKTjBuVmdnM1hranF2Sm9PR21hYk1qMk5u?=
 =?utf-8?B?Nmpac21oS0xjdDVVZGtMSUkxbDJ1MUkxSlloSFBEZnlIQU9NeFRDSFRwWFdZ?=
 =?utf-8?B?aThMdHpxK2xLQjVPVTQ1RGFKS01NOUJFNkxDT2RocnIyYzNQR2RsV2QwVWNi?=
 =?utf-8?B?Z3BSSytsMkZvMjBkWk1ReWdXQllaeDVCSlBPWUthckpqbTFtaFRKZ2dFNVYz?=
 =?utf-8?B?UFpPcVI1Vkg0TDRvMzJjdjVQSGFDdTNTYlRxOWhIanpJREJYZ3RoQUpvcWFa?=
 =?utf-8?B?SnMvYXV2QWNhUDB0azVsbnRNNTJjeXNqQWR4TEUyVVRmajJKaHpodTcyTGwz?=
 =?utf-8?B?YWNTeHl1ZURRNkQvZXlkSHRlYmMyME1JVmNKMUtLRU0rV21UVkh2QUMzOGFa?=
 =?utf-8?B?dThpZnJvVTFxMGRxYzVLb01xVGszRWhJczV4ZFFLMWFEYzRsM3RWRDNEMEZr?=
 =?utf-8?B?MVhiZ3Z3cTlsSTZuVUhISmZEa1VNcFc5R0hZbkdxYTJEVmlTMHhlTFdUZG1G?=
 =?utf-8?B?RnlQYk5kYXBYZmhxMnQ4WXIzd2NsZGtLM0J3YjFibG5NVEhMcFVXQWwrNE82?=
 =?utf-8?B?YjNyRW0rdm13bVErb2FsSHYwYWtlZGJNRjA0QnN1ZGJFM2VKbFZmblpiQUEx?=
 =?utf-8?B?VTM3V3JuZXIwNUQ2UUJKMGZnWnh3c3ZEblhyVkhQcVh5WDQ2RGErK3RaOElB?=
 =?utf-8?B?ZS90eXFYR2k0bzZCT0pMTkc2VWJvYnhwaEdNRzhZSnNyd2tHMVRRSE55RTNl?=
 =?utf-8?B?SE5FOVJlNkZrbmE5Q0h0cFBQUG1yc2VFSE56WWd2bU0zbXh5c1hxVElVbk1B?=
 =?utf-8?B?YWpuN2QwRHF3TVJtZHlMSEsxdklWanozaS9BcUx6MGp6UUQzM3lFTHUvT2I0?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tFABx6VYcuH4NcUgnC6GpzwFQxcRfxiG/tx16tE2LLyKIhkCjg69C/bmBcGFpyXgJSJ9xUhPuX6UUiB4qna7wF8D7y2wpZHBLLIsPCEZmqju9Mix8gVg+nd4A6KHRjPy63mjEcpaivhm+AP9qJtX6Fo20uj2sE4wcYcgDvfpNfddL7dnLkgw+Kw3NxWOVjXrAOhpOF/NkKu+HUfZWuy9aKnwc5h8ZU034VTetuRMigxB94uBWl0d1v1FU1BeUisEdCDAOlzdD6Hu4Xd5wYHR2omao+8EIfAYq2wB74MctqojZu2VxUI2VOOous/0w3QXTDl7cOlHXwFz8p5GAKb/JNFzIo/yGLkNhDoINq8b8E+cpaqn9DMpb5O15qfsRgFjETrMf6Bbvzai6koGlb7ryPC9dPQa46j3Sqjaa6B4SeiWTXI1BnXoyKX5G0c8LjB126R07Dd2R739H1MX3KD7oUqDyHawKxAQyXPBNiaQxzFZtFsVAqH/6DNjGJiebRudoqFTW5BaPQG/cBIAK4Ec9RMtSuxBcDJIKbi74ewV7H8n5fUOiFr1aPEV1Z97IxndM4mwM+HMAXCW5Rm10RbJrjhrVBgeeUcUVi7qv/of4Lo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37efa427-4dd3-43f0-a95e-08dd7dc46a86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 15:27:51.2358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPln6vMre2gwfnoqDUeC0+5rlvwCSeIzAo7P4oUlrWhBoGlpeREQzSFYcoF0I7hYetI99OC4QFH9JzeUtvIB39mIfFn4vf2tSle2c26aGKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170116
X-Proofpoint-ORIG-GUID: XMdfeHsO7wCfT7Y8aA-btuDrJ0IBOlaS
X-Proofpoint-GUID: XMdfeHsO7wCfT7Y8aA-btuDrJ0IBOlaS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/17/25 8:40 AM, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 14/04/2025 4:02 am, Alejandro Jimenez wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> The current amdvi_page_walk() is designed to be called by the replay()
>> method. Rather than drastically altering it, introduce helpers to fetch
>> guest PTEs that will be used by a page walker implementation.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>    hw/i386/amd_iommu.c | 125 ++++++++++++++++++++++++++++++++++++++++++++
>>    hw/i386/amd_iommu.h |  42 +++++++++++++++
>>    2 files changed, 167 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 0af873b66a31..d089fdc28ef1 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1563,6 +1563,131 @@ static const MemoryRegionOps amdvi_ir_ops = {
>>        }
>>    };
>>
>> +/*
>> + * For a PTE encoding a large page, return the page size it encodes as described
>> + * by the AMD IOMMU Specification Table 14: Example Page Size Encodings.
>> + * No need to adjust the value of the PTE to point to the first PTE in the large
>> + * page since the encoding guarantees all "base" PTEs in the large page are the
>> + * same.
>> + */
>> +static uint64_t large_pte_page_size(uint64_t pte)
>> +{
>> +    assert(PTE_NEXT_LEVEL(pte) == 7);
>> +
>> +    /* Determine size of the large/contiguous page encoded in the PTE */
>> +    return PTE_LARGE_PAGE_SIZE(pte);
>> +}
>> +
>> +/*
>> + * Helper function to fetch a PTE using AMD v1 pgtable format.
>> + * Returns:
>> + * -2:  The Page Table Root could not be read from DTE, or IOVA is larger than
>> + *      supported by current page table level encodedin DTE[Mode].
>> + * -1:  PTE could not be read from guest memory during a page table walk.
>> + *      This means that the DTE has valid data, and one of the lower level
>> + *      entries in the Page Table could not be read.
>> + *  0:  PTE is marked not present, or entry is 0.
>> + * >0:  Leaf PTE value resolved from walking Guest IO Page Table.
>> + */
> 
> This seems to be a bit error prone as any statement like "if (pte < 0)"
> might be completely removed by the compiler during optimization phases.

Yes, caller(s) of fetch_pte() must cast to uint64_t in any comparison to 
check for error values. Like it is the case in many of the patches, I am 
following the examples from the VTD implementations where they do the 
same thing in vtd_iova_to_slpte() to validate the return of vtd_get_pte().

When using fetch_pte() again in patch [17/18] I considered adding a 
helper to check if fetch_pte() returned a valid PTE, but seemed 
unnecessary given that there are only two errors to be checked.

Another choice was to make fetch_pte() return an int so the error check 
could be done simply via (pte < 0), since bit 63 is either Reserved 
(DTE) or Ignored (PDE/PTE), but that seemed more prone to confusion 
since you'd expect a PTE to be a 64-bit long value. Though I am aware 
the way error return/checking is implemented essentially relies on that 
behavior.

> If you want to reuse such "high" values, defines could help.

Sorry, I don't follow. Do you mean using defines as in still returning a 
uint64_t but giving -1 and -2 special definitions? That might make the 
code a somewhat more readable when checking the error values, but still 
requires casting to uint64_t on the check, and doesn't solve the problem 
of a careless caller using (pte < 0) to check for errors...

> Otherwise, pte could be an out parameter.

In general, I think we have to accept the caveat that callers of 
fetch_pte() must have some implementation specific knowledge to know 
they cannot check for errors using (pte < 0). Maybe with the aid of a 
strongly worded warning on the function header comment...

But if that argument doesn't convince you, and none of the alternatives 
above seem better, then I am leaning towards using the out parameter 
approach.

Thank you for the feedback.
Alejandro

> 
>> +static uint64_t __attribute__((unused))
>> +fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
>> +          hwaddr *page_size)
>> +{
>> +    IOMMUAccessFlags perms = amdvi_get_perms(dte);
>> +
>> +    uint8_t level, mode;
>> +    uint64_t pte = dte, pte_addr;
>> +
>> +    *page_size = 0;
>> +
>> +    if (perms == IOMMU_NONE) {
>> +        return (uint64_t)-2;
>> +    }
>> +
>> +    /*
>> +     * The Linux kernel driver initializes the default mode to 3, corresponding
>> +     * to a 39-bit GPA space, where each entry in the pagetable translates to a
>> +     * 1GB (2^30) page size.
>> +     */
>> +    level = mode = get_pte_translation_mode(dte);
>> +    assert(mode > 0 && mode < 7);
>> +
>> +    /*
>> +     * If IOVA is larger than the max supported by the current pgtable level,
>> +     * there is nothing to do. This signals that the pagetable level should be
>> +     * increased, or is an address meant to have special behavior like
>> +     * invalidating the entire cache.
>> +     */
>> +    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
>> +        /* IOVA too large for the current DTE */
>> +        return (uint64_t)-2;
>> +    }
>> +
>> +    do {
>> +        level -= 1;
>> +
>> +        /* Update the page_size */
>> +        *page_size = PTE_LEVEL_PAGE_SIZE(level);
>> +
>> +        /* Permission bits are ANDed at every level, including the DTE */
>> +        perms &= amdvi_get_perms(pte);
>> +        if (perms == IOMMU_NONE) {
>> +            return pte;
>> +        }
>> +
>> +        /* Not Present */
>> +        if (!IOMMU_PTE_PRESENT(pte)) {
>> +            return 0;
>> +        }
>> +
>> +        /* Large or Leaf PTE found */
>> +        if (PTE_NEXT_LEVEL(pte) == 7 || PTE_NEXT_LEVEL(pte) == 0) {
>> +            /* Leaf PTE found */
>> +            break;
>> +        }
>> +
>> +        /*
>> +         * Index the pgtable using the IOVA bits corresponding to current level
>> +         * and walk down to the lower level.
>> +         */
>> +        pte_addr = NEXT_PTE_ADDR(pte, level, address);
>> +        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
>> +
>> +        if (pte == (uint64_t)-1) {
>> +            /*
>> +             * A returned PTE of -1 indicates a failure to read the page table
>> +             * entry from guest memory.
>> +             */
>> +            if (level == mode - 1) {
>> +                /* Failure to retrieve the Page Table from Root Pointer */
>> +                *page_size = 0;
>> +                return (uint64_t)-2;
>> +            } else {
>> +                /* Failure to read PTE. Page walk skips a page_size chunk */
>> +                return pte;
>> +            }
>> +        }
>> +    } while (level > 0);
>> +
>> +    /*
>> +     * Page walk ends when Next Level field on PTE shows that either a leaf PTE
>> +     * or a series of large PTEs have been reached. In the latter case, return
>> +     * the pointer to the first PTE of the series.
>> +     */
>> +    assert(level == 0 || PTE_NEXT_LEVEL(pte) == 0 || PTE_NEXT_LEVEL(pte) == 7);
>> +
>> +    /*
>> +     * In case the range starts in the middle of a contiguous page, need to
>> +     * return the first PTE
>> +     */
>> +    if (PTE_NEXT_LEVEL(pte) == 7) {
>> +        /* Update page_size with the large PTE page size */
>> +        *page_size = large_pte_page_size(pte);
>> +    }
>> +
>> +    return pte;
>> +}
>> +
>>    /*
>>     * Toggle between address translation and passthrough modes by enabling the
>>     * corresponding memory regions.
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index c89e7dc9947d..fc4d2f7a4575 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -25,6 +25,8 @@
>>    #include "hw/i386/x86-iommu.h"
>>    #include "qom/object.h"
>>
>> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
>> +
>>    /* Capability registers */
>>    #define AMDVI_CAPAB_BAR_LOW           0x04
>>    #define AMDVI_CAPAB_BAR_HIGH          0x08
>> @@ -174,6 +176,46 @@
>>    #define AMDVI_GATS_MODE                 (2ULL <<  12)
>>    #define AMDVI_HATS_MODE                 (2ULL <<  10)
>>
>> +/* Page Table format */
>> +
>> +#define AMDVI_PTE_PR                    (1ULL << 0)
>> +#define AMDVI_PTE_NEXT_LEVEL_MASK       GENMASK64(11, 9)
>> +
>> +#define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
>> +
>> +/* Using level=0 for leaf PTE at 4K page size */
>> +#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
>> +
>> +/* Return IOVA bit group used to index the Page Table at specific level */
>> +#define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
>> +                                        GENMASK64(8, 0))
>> +
>> +/* Return the max address for a specified level i.e. max_oaddr */
>> +#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
>> +                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
>> +                                (~(0ULL)))
>> +
>> +/* Extract the NextLevel field from PTE/PDE */
>> +#define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)
>> +
>> +/* Take page table level and return default pagetable size for level */
>> +#define PTE_LEVEL_PAGE_SIZE(level)      (1ULL << (PT_LEVEL_SHIFT(level)))
>> +
>> +/*
>> + * Return address of lower level page table encoded in PTE and specified by
>> + * current level and corresponding IOVA bit group at such level.
>> + */
>> +#define NEXT_PTE_ADDR(pte, level, iova) (((pte) & AMDVI_DEV_PT_ROOT_MASK) + \
>> +                                        (PT_LEVEL_INDEX(level, iova) * 8))
>> +
>> +/*
>> + * Take a PTE value with mode=0x07 and return the page size it encodes.
>> + */
>> +#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
>> +
>> +/* Return number of PTEs to use for a given page size (expected power of 2) */
>> +#define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
>> +
>>    /* IOTLB */
>>    #define AMDVI_IOTLB_MAX_SIZE 1024
>>    #define AMDVI_DEVID_SHIFT    36
>> --
>> 2.43.5
>>
>>



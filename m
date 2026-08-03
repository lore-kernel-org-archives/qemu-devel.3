Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0970C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 21:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0KV-0002LR-8X; Mon, 03 Aug 2026 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wr0KO-0002L3-2C
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:36:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wr0KJ-0005tL-Ly
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:36:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673LSACV3098622; Mon, 3 Aug 2026 21:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Pahwi59v6Wjc4RyPkEtZgEAgN9iGXUGZUz+GFCVFcYs=; b=
 endaQK1otj3QTZ7jCu82+ukxFfHRnyeeh3cYiTakDvDmJ4ayH8BhsOXdhrEzBfvb
 CVeMVUfhyobFEzkJOVB7Jva7eyIwVy8TbAAjUObWSWowq1o5PNph9HJbniPJINQ1
 ylMS3Sbfvdc0+0VKNoQv/05OCI+5ChDLgRNMkobRwdF6J72NKd+QSryBem4ysF2H
 n1UDkfc3enZ68nf/RNlLj8fACVRlT0trk4TKqZoJyWWLVcwfNL5feeD7n7KF7QhI
 Wj8PmRvNMaSE2kq1DjDMqSMX5EBZcbrqxtqDERdmDEFMhvRyZYcMRHRkG2uFvEne
 NBrCWCh4GlB7IlWkbIfkdw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7qa4x8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Aug 2026 21:35:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 673LU5EC023486; Mon, 3 Aug 2026 21:35:52 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fs78b64d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 03 Aug 2026 21:35:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D28BC868krSaXx2WI24OzA5h2LUHDQlWSEyxedZSPytrlZS0VkK7mvKD+qfS4gJFSN7SS2SoTNrZGV72h7oWxgx8l2HUZ773y4YfZSzpcBByTVhY4XRHGOg+o7ey2CeJv+t4O6cdzjYSAHFwv+oM7LxjRwnWRRbK65bGw/Sx2XdIEv0hoCxo/oIo0Z9A3ZjFDCkpA/y/PKFNJSvyWEC1E/AjYRctHOuVt/qm/O0eR260Kd2pkIRahK7GSGgJmTS2jPB0G02pekib5JZimFpq4vFVSc831aSBPtURBj2DxYhWmeUT8IA+ZTKBYk80cqbQm7u5gSv+nYYb1TorRsYf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pahwi59v6Wjc4RyPkEtZgEAgN9iGXUGZUz+GFCVFcYs=;
 b=BvkR8T+hRvUBDeSip1+eODYHUUQM66zeK7rbMS9xv4Tjcwm/S1UQw6nkq1K1IoRRFYy/aEtcUbICJ8HobFALeux0vYzes7P6V2E7zU/7UXg2NTEQVnUcnWdpoUjS93ALfg+Dd8B2AlGHmbG4PDID4z88KaJrVz/+heLY3MhupWEthKjDWvUkNCTIQczMxFNY4eSK/uK3VvMi9C7GGQHt47G/miBcFTNSPDo3f7yzCfi3ft8Znx5AjYaejagwIRIni1aASxJPMy63FavVKfUhBDRiDJ4M6AJbT0wZnbgnmAolEeTfM4VkWM8c4DCS00O7eioDcrUC0JgUQqHvZgNOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pahwi59v6Wjc4RyPkEtZgEAgN9iGXUGZUz+GFCVFcYs=;
 b=C4VwcnZKAWlYKLSxosJ9eCfNSMeP1DUZkCjsbHkLYzoryzntsSGCOyVab+QbH/Jx8qbncBLjszWBlFGHHSQf7KSOAmEGTseE6ZytlVFsohf3WTpqbd7yTnnIiyoCUr+WjpLNllC4telmm9xOWC0S/uk3y4ZTneVppWEMDosTWQA=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH3PR10MB7777.namprd10.prod.outlook.com (2603:10b6:610:1ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 21:35:48 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 21:35:48 +0000
Message-ID: <be91fee5-0597-4374-b766-5096bceec43c@oracle.com>
Date: Mon, 3 Aug 2026 17:35:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] acpi_build: Introduce necessary macros and structs
 for AMD IOMMU IVRS
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-6-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260511123937.32743-6-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::15) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH3PR10MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c44dbf-ac0f-4430-a09a-08def1a72ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: mVXGA+u2M1uVLjy0iei6eCTQN6+IsqKQm67Ef2EYXXn5EsZ8t+ycHhbPQKb2OvPpkr2wgpLFY+sBRlpbJH0F/DNr9jJVbRDbNFxu4PQSmSDnzvnej8HAu0BafoV0cG40RVxlVnK4tYUZ0iu8QJTidAo7TK2PRwIKhA/pqwkCgAselrBD2o0VzIlNX7uZR1rohh78JhDlKuBdGTokSeoO09oUVE1C9C6inAYSFKkOkSHOWzCsvLya2YriSnGB4ebukQ/qDD7Xzpefkh3/ouakqOR68JYfZbyI/RKHAMCfaj3XVc/alU0PmNYqXOUOGBXihD4tx8Lig6ssKkSCkK1d/BN4CWS6LZwVmdKC5G0fOGX8rPfxfteuUjIvep5y5U9iDsB2JIA7jVaTjK3GNOpL6en9RmXwH2Ocuq5da7u6mH5x878uXQwz0a1u8V7ZG65O1EC8PUdq+LkHIIzSGstwiOIlVOo7LWJ7C89RqJRb3421RvBx/s+fodZEXIn8QtTawr/jpPCbOm/iyO5FGwgipF/A4/RO6Jk4mA1lAgYvsZ//Lql916lTtjQq7Qvtvjb/ojr+HeaOcKyznGNmWAUoD5cc1e9oQbeOZ6nRmPAwjNEu3fYv17aK9dZOREZi6mJ4W66x7LxxjtTxti/UbyKDJmwGt6iRenP69gLhtB88h7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNsMUhLZEhYekFPWjRQdXZISGRlV3RCMUQ3MmhhTHZCS0ljUXpNbzZPVk9P?=
 =?utf-8?B?a0pObFNoZVlPRlFkUzJVRkRnbTNWd1h5MWkrMXhkU21oOVd6OWNPU0t2VVlP?=
 =?utf-8?B?QVA2UlJiLzBTV0E2cGxrbTVDSis0cjYyejUweEtOa1FNaVB0enFRUFhSeW8z?=
 =?utf-8?B?M2JoM3R6eFp2eWtaSDZuVWFHS29ZWkozeDNRVXl2ZDI4NzhJZS8zaHN5STFN?=
 =?utf-8?B?dEZUY2dkMHVEUjZSL1FvU3h3MGZFdmw4bmM4bHBLcUxDV0daOUpHQ2NtejNU?=
 =?utf-8?B?b0djWm1RWTRYZXVjMGk4U3JUeHNRaWRieWNOVjJTRWdoQjkyRkdRdmErRVk3?=
 =?utf-8?B?YnY4c3lIdy92STY2MGtSVDhzZjJtcFV3TmxaWVNiRWJkVFZxY2NuUUppaVdn?=
 =?utf-8?B?WmMwbExrL2d6VnR5SndJYnIxY0trL0NvcGFYWkw3aEdDTHVkUlBVdGlOOXZi?=
 =?utf-8?B?WEloYW1XQ1g5Mlk4WXlIWGk1Ym81bkV4UXkvSUsxY2d0dytMQ3UwamRWeVZk?=
 =?utf-8?B?RzA5QmFlRzRCQzVZVWF2VVg2cU90V2Nxa2JqWDQ2dTZqMEdOa2JNZU1KQXRm?=
 =?utf-8?B?T1RaMXgya2pPMzVYSTRTd0laUlZDME5JMG5BUlZ5M0M2ZGNhNys0SnhWVEda?=
 =?utf-8?B?MGRPWGZVMzAxVDRNM3RpbXZLL0Q5ZDgycEtUSTI4NFFqcWx2UEZyTW5MRlhx?=
 =?utf-8?B?b3dLcmNlYUNFR0lZSVpqNVVxdzFJaFpBdkNwWkVwUURuUW9SdXRlNklZVkdO?=
 =?utf-8?B?SVNQQTJHNXBoczJWdTV3RHJPcWpmaU41YkNwdEVhczVqZlBsaElieU15Z3kw?=
 =?utf-8?B?TDdSU1hxdklRK24yZ0F3eUUxWWU1NHVDcGpERFNTckNDdU9DTlRMNDExQ1Nh?=
 =?utf-8?B?a3RzcTlFR3drYzdVbGh4NDJIcFFiTkpQakJ0WjlVM0FpK202R09pRlBrOUxC?=
 =?utf-8?B?d2prN0lBVHBEaUVsYUljY3JmcGtyS3FiR0d3ME9FOUQzYUV2TjJSbDNybHpN?=
 =?utf-8?B?Y29xSnZyNzY5TkVzZkp6cWdqNTR6cG1OQjVUVCtyKzdmOFF5S2czRUVVRGVk?=
 =?utf-8?B?R3M5NzFuVExDVm90ZFNHd1hjb0REMTBFYkg3MCs4cnl3RmFiRTJoQ0VTVmFN?=
 =?utf-8?B?M0lBS0pmcEZVN3dDU25jaGJyS2lXV09SaGVXSWdMNmNQYjJaaDhRSlVOdERK?=
 =?utf-8?B?ZjMrWDVndjF2cjVOUi9YUGhmbUx4ekwwd1hVbzMvYmlKUEZvYmxhODJJZzRr?=
 =?utf-8?B?VVZ1NHJOZTVRdnpCMGZmZG9yM0dUejBXQ0VmenovRFB3bXJ0MUREazVaRnJX?=
 =?utf-8?B?NTZRSFhreS9DVlJmSU9EcGtoUDZxSTh0aVZaZ2orNUg5R3owUUhQUjk2cGFm?=
 =?utf-8?B?TVpYbFVrTjhBQ0Z6Q0ViNFBVZW1oeVJ2NzdMVlc4VWJuWWJiMnpIVnM4NFUz?=
 =?utf-8?B?endwZ2ZsUmo0RkNQOE9XaEpxZDlySDBGZ2dTWDJqS0s5T0lYdzZXUDNyTHlG?=
 =?utf-8?B?c0ZoeUI5bDIzamZrVnFLVjVvLy9OOU5xUVMwcmwrMFpqRklVWk9IL0ZqOXpF?=
 =?utf-8?B?NUsxY3o4L0xnK25UbjJnSVJ6Ykx0RTJBTWY5anVtZjNROURiQ1lGR0hTeFFz?=
 =?utf-8?B?bXlYZllYQlozRzlINjJ4eEZJN1BVS0NGbXBJSUtURzkyZVpIdnBQTjJsVnQ4?=
 =?utf-8?B?cVJmeWxjT2pwbm8ySWYreWZGNDk0OWhQUzEvRDJHaFBQbG9sOGJ1MWZKZkEr?=
 =?utf-8?B?NHEweUZHb3ByRDJRVm50NVVnd1J3VDdBNUxaaUxXVmRmQ3RjRDRvMlhwb0Qv?=
 =?utf-8?B?VHAxeW12ZlJSd25Sa0tLeWtqYTdydFBYNmoxYXFjT0I1T0ZXYXJkOUVwcGVJ?=
 =?utf-8?B?bGZCcUR5SHg4TGFxQ0c4d2JUakxlYVFyOU0wL0JkRTFRRmJsbFpNYXVjTk0r?=
 =?utf-8?B?LzUwb1lGblRNenpNTms1cGx2cGkyV0Q0QlluaW9MRXdYRXYxRlhJR243UG1D?=
 =?utf-8?B?N0JzOFdwUEIvNTNkZXUyRjRSejNKbkZLaW9taW1iK1h2WjI1V3VBcDFUMURx?=
 =?utf-8?B?NWQrTHZuWDJkOVJkcHJNcUErUExJcFg3Ulp6Q0piR1dDN0hMbjlqYnQxNWpz?=
 =?utf-8?B?NUZWM3QzekVxei9UZXNjKytqR1VNUHQ0M0ZFeXFqdFd1WVlBOWpHU1NTMm1y?=
 =?utf-8?B?bTFwOFh1eGhHVXlxaDdDOHlXOXJwMjc5aE5FaDRCVGc3M0xwSWEvWW53WkRT?=
 =?utf-8?B?cW9HdzA0OGxCdVlTbFA2S244OHNVbDU1WUNrWlkvbzZlUWlqenh6SmxEb08y?=
 =?utf-8?B?V2JjbndHSVlsVUdFVjg4eWRnaHBqMHdTQjhZUlc4QVRmMENVd3QrWDUrQWZ3?=
 =?utf-8?Q?bUhjxH/BatFDPqH4=3D?=
X-Exchange-RoutingPolicyChecked: kvo07/ll5/r+WN2TYqyKhk6M9o31rsNK1rzkwNOOczTg9wFwdJtsz5XCG5Dh71C0qxK9AV2zgEWS1y2phHRhTlIVA7+/2lxyV73pa1wYUMRTtIbv1d6njOv6iBoGWpijddGnoMKV8TG8kKeVMiKslA6hYdmrePoHLbe/spzUphSjRLzCMKAGiH5bYJT4jsdOP9D2L55Gxzg2EFI78NguvqXicky+13emUttCug7gyM9F0G+cb8Ed0WhMLn3QkE+j2JEkj+VGmnmdwsDRNYD0esK3fgH5boXseDJrghduo/Hhqg2Wd2lHZKHju3p76uK5hmR+JBmyMYt+bquUysBjVw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HzUkukVy+nZZX8RllPIHAX7rkDspme68+l22sukQfL8OejuimcMQRJHdmFi8aQ5JvKOdlexd8+coc5oM1HmU1s0KK8odfzvsJFt4NUURkir6E/UlgY+fCk1NaIIWEe7CneUSAhGa+Vu0PQLOC2AwvqZY9xfwLL2IUzLpt1PMTL9ASzeqzOrZx6c2zLoNuZ9Y2+DSx9qENbPzuTDtu/rcR7rNWkFmSpualLL8FOiqq55bALU3kxtgOkExu2GH3dIkGHhIVULMDUdW2viqNdUAzMUZZr+UlRIAK5/pKxZ+nU+y6euWalKV4HGfBQdilUzeX22+MreAeto5OC838WAmk8RijbQOm+h3oUVAr9MDsrUPmi+1L4dsZNJjziYz5qmaGMJOE+dYsfn+cSIk0/0bY5BA0HT9wQ2kjXUenByaDRM3KHwlVBvlTN3/RxlM/C4+jwt0uVNJCUTWRqGnk0oJxqm2awy85z9oa13Apzu1uWsTb5qhbttsDldqc/UFTY9G9UjXG/7L3BjykYUPMELjkW1CtLJJ178lIuRZRC+v2uaWuIn0elt2FuZCAU7orJLRf1U2vJ38kSMbmF6ny+i1FRQAAnVsGE1sIN89DXddHJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c44dbf-ac0f-4430-a09a-08def1a72ecb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 21:35:48.1724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkdNa6CvXmFL28XiW5Rrhb0m/gBYgJYuffGUateTinHlksjuXk3utC5rzDm0XBQsfXEkWFOGjsAeigy4saMFMsg0frg9juq53V3mpRQ5RTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608030189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE4OSBTYWx0ZWRfX80960ukeREhs
 w996zAeaOcZ4xSIRSPcfhY/AZ4cOsLWwYpIl71JJXlEyHBcideeKJ++F6UpzIobyq7H+k87Bydo
 MR0a5Xt6JK3coN4e1QfRTxeGj+8hgLIQ4ZSczp8XJBlu/TLht36j9m1vueJ+ovFCvS3hZhzvYyR
 wksvQXpQavnAZ0/Hp/dTdfY3y7xKQOdYa2zJQmqeo3L3E0sR69ZPRkS8zzl4qB+zPssDQ63Czsj
 27TzmKWwzoaShZAY6AoecQbtgYz0zfJCintEtoRII2sDhaAoYFPGiBf7lJal2s7R2TZpwWSlYvD
 OkYDnSBm4QDHpLI4xVEsArK+MgDtPhHh9ve8nAUM4CZZFosNOeZA4+3eUzSsC5m0GuAP+e7nSTr
 +dTT2IStm1flKs/KJB3z5FBBhS62cr6e6ESlCPD5a7hqzYea5uC4CcFLF58KH10Gx3smDBCgWVx
 dkiu7h66X0F61j3JbFA==
X-Proofpoint-GUID: 79Rf68mvu6f1VoKbbQ-Wvp8W0Iem9hCt
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a7109b9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=zd2uoN0lAAAA:8
 a=3HAvP5dUHf8YdXa-9WoA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: 79Rf68mvu6f1VoKbbQ-Wvp8W0Iem9hCt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE4OSBTYWx0ZWRfX3HZXQ8HPJ0eS
 4CAMVb0FDobSTsi66Z+M+6Gvb3y0YfLYCtcMls1L8NEddcSUlAHRQ4Py4oylVT0Vb58vp3Z1HwN
 095ovURev27Ut66jPbP4Pxgn/o+Qh8NtLC1KdEWKfKzeeLdkFiGO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 5/11/26 8:39 AM, Sairaj Kodilkar wrote:
> Introduce necessary macros, along with packed structs which represents
> the AMD IVRS data structure, to hold the necessary information. This
> will improve readability of the current code.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  hw/i386/acpi-build.h | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/amd_iommu.h  |  6 +++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 8ba3c33e4831..9fd60a186db1 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h

acpi-build.h currently doesn't have any device specific definitions, and it
is included by several files that don't need AMD IOMMU information. I
initially thought about creating a new header just for these new
definitions, but I think the simplest approach is to put them in
amd_iommu.h (which is already included in acpi-build.c).


> @@ -2,10 +2,102 @@
>  #ifndef HW_I386_ACPI_BUILD_H
>  #define HW_I386_ACPI_BUILD_H
>  #include "hw/acpi/acpi-defs.h"
> +#include "qemu/bitops.h"
>  
>  extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>  
>  void acpi_setup(void);
>  Object *acpi_get_i386_pci_host(void);
>  
> +#define AMD_IVINFO_EFR_SUP       BIT(0)
> +
> +#define AMD_IVHD_FLAG_HT_TUN_EN    BIT(0)
> +#define AMD_IVHD_FLAG_IOTLB_SUP    BIT(4)
> +#define AMD_IVHD_FLAG_PREF_SUP     BIT(6)
> +#define AMD_IVHD_FLAG_PPR_SUP      BIT(7)
> +
> +#define AMD_IVHD_FEATURE_REPORT_XT_SUP_SHIFT      (0)
> +#define AMD_IVHD_FEATURE_REPORT_GT_SUP_SHIFT      (2)
> +#define AMD_IVHD_FEATURE_REPORT_GLX_SUP_SHIFT     (3)
> +#define AMD_IVHD_FEATURE_REPORT_GA_SUP_SHIFT      (6)
> +#define AMD_IVHD_FEATURE_REPORT_GATS_SHIFT        (28)
> +#define AMD_IVHD_FEATURE_REPORT_HATS_SHIFT        (30)
> +
> +#define AMD_IVHD_ATTRIBUTES_HATDIS_SHIFT        (0)
> +
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_RESERVED             (0)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_ALL                  (1)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_SELECT               (2)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_START_RANGE          (3)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE            (4)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_ALIAS_START_RANGE    (0x43)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_SPECIAL_DEVICE       (0x48)
> +
> +#define IVHD_VARIETY_IOAPIC (1)
> +#define IVHD_VARIETY_HPET   (2)
> +
> +/*
> + * Vendor(AMD) specific fields in the IVRS header
> + * Excludes fields in ACPI table header
> + */
> +typedef
> +struct AmdIvrsVendorHdr {
> +    uint32_t ivinfo;
> +    uint64_t reserved;
> +} __attribute__((packed)) AmdIvrsVendorHdr;
> +

nit: I think the preferred way to specify the packed attribute is to use
QEMU_PACKED like the FwCfgTPMConfig definition uses in acpi-build.c. I know
it is ultimately the same, but I think we should use project-specific
definitions when available/appropriate. Please change all the structs to
use QEMU_PACKED.

Thank you,
Alejandro

> +/* IVHD type 10h */
> +typedef
> +struct AmdIvhdHdr10 {
> +    uint8_t type;
> +    uint8_t flags;
> +    uint16_t length;
> +    uint16_t devid;
> +    uint16_t capab_offset;
> +    uint64_t base_addr;
> +    uint16_t pci_seg;
> +    uint16_t iommu_info;
> +    uint32_t iommu_feature_report;
> +} __attribute__((packed)) AmdIvhdHdr10;
> +
> +/* IVHD type 11h */
> +typedef
> +struct AmdIvhdHdr11 {
> +    uint8_t type;
> +    uint8_t flags;
> +    uint16_t length;
> +    uint16_t devid;
> +    uint16_t capab_offset;
> +    uint64_t base_addr;
> +    uint16_t pci_seg;
> +    uint16_t iommu_info;
> +    uint32_t iommu_attributes;
> +    uint64_t efr;
> +    uint64_t efr2;
> +} __attribute__((packed)) AmdIvhdHdr11;
> +
> +typedef
> +struct AmdIvhdDeviceEntry {
> +    uint8_t type;
> +    uint16_t devid;
> +    uint8_t dte_setting;
> +} __attribute__((packed)) AmdIvhdDeviceEntry;
> +
> +typedef
> +struct AmdIvhdDeviceEntryExt {
> +    uint8_t type;
> +    uint16_t devid_a;
> +    uint8_t dte_setting;
> +    union {
> +        struct {
> +            uint8_t handle;
> +            uint16_t devid_b;
> +            uint8_t variety;
> +        } __attribute__((packed));
> +        struct {
> +            uint32_t ext_dte_setting;
> +        } __attribute__((packed));
> +    };
> +} __attribute__((packed)) AmdIvhdDeviceEntryExt;
> +
>  #endif
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index fe8f4a6cdc74..d97ddbd612dc 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -175,9 +175,15 @@
>  #define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
>  
>  /* AMDVI paging mode */
> +#define AMDVI_GATS_MODE_SHIFT           (12)
> +#define AMDVI_GATS_MODE_MASK            (3ULL <<  12)
>  #define AMDVI_GATS_MODE                 (2ULL <<  12)
> +#define AMDVI_HATS_MODE_SHIFT           (10)
> +#define AMDVI_HATS_MODE_MASK            (3ULL <<  10)
>  #define AMDVI_HATS_MODE                 (2ULL <<  10)
>  #define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
> +#define AMDVI_GLX_SUP_SHIFT             (14)
> +#define AMDVI_GLX_SUP_MASK              (3ULL << 14)
>  
>  /* Page Table format */
>  



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3680C3601E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 00:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32gy-0003N6-CX; Thu, 10 Apr 2025 20:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u32gw-0003Mf-H0
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 20:56:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u32gu-0002bn-Eg
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 20:56:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B0q7Yg010461;
 Fri, 11 Apr 2025 00:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=xkTQyTqt1cfo88BWO5Z1aVk/gRRl85F6IvIPVeFJfVY=; b=
 kaRQDDRTbv3UFhOJABsAiG88TZO8Nhx7FUrjJ3WzAkfUZgjye5ygW/V/TqcRNKhC
 YdoMg3iNBxlbDIAhXdIXP31M8+zMiV+24ShHarNptVL2mN1pv6RMe6NVRsXr054m
 Uss8YO5UXaFK5Vkg2qdWBmQzU/XjdKx2zeMp96dwCgRVj+mLlIF2drC3/c6oV+95
 /EU6HVcdIV24oxU4QYPe3WzCXOQeCW/7hWWRwTNvgAb+mCfy1oOxDdRpfmsR9lRY
 nL8tyuK+EOJkgQCBYApmKHWjhiA1SMsOr5uQyZkUz+Rbynloc7W/+/tOBRw/VHzA
 tOiXO+89Gm4qhXVEWJQw2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xrwr80h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 00:56:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53ANoW7E023885; Fri, 11 Apr 2025 00:56:13 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttykby2c-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 00:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRDfU3vlx1LurQYDmUE5k+Wd3dzHXquk5NRqsn7igU9CZCXs0ehD36CkwkQkSk1MQMqwM42ywi6G4+Ya857PzL83FkWiBGA0gWTkgNbVMMDivJIXmXdHZfqesLsANMd3i7yW510w+pGOcSzWwRo6FuRpCX23b+zohMnzrSLGJFD0o+uxRn/qt63+U1WRUCAZfEcgePyKVajvNJWn/CrBiUve2HK92vXW6nkKC2DXives7OJoyEZxHcNolvlrPknFG8iiqhIghUN+cgS36Cq2yO8XnLnnnCgXU3Tmk4bcEfc+skZ4OZ6WMK6O3xjrAPnBkb1pVcYBDAZgYM7qEsGLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkTQyTqt1cfo88BWO5Z1aVk/gRRl85F6IvIPVeFJfVY=;
 b=csdyeKN7qzbZZBdNKDIIXeOntVvkGrTuVllDo0d0XzZsqk8oy3w06QQbZT1k/n++x9qdYrRyXPDCeqxQlRPHEnbL7xmiqjh7JF171D+catcU8rUDBywwA9sHdeBIXNb3DQJE4yTK3QhnqWwOKF++of8uF+HOwB9G3UqhqT47i+i7Jay3FXkkz+Re1goiHvEbUrIWsqTT+ntDmp7ZrgyUYUE5X2YvEP5EuqMAKG6vDqActENjKpwG0/JKFLMvKsrvBrbrkOAOf8a1fn3gkaBFmtjVJ0pK+UZDVyNGx9tCtopEtrAQpJCXvN8EtduV88ISNtG9vchxtlPldAch/pF+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkTQyTqt1cfo88BWO5Z1aVk/gRRl85F6IvIPVeFJfVY=;
 b=O4ZR75NKGYQ4JuBZIl2jCBM28EIoZwOLvyuL1SzLMTCXLyixaSUPTnVim63FvDdWKEUG2RTU/guRGhkbjt/DHTcKrmxBirui0WtLpQurgTqGaeDs7j7Wt4xLI7sPkYUNel6MiEEGKSHX+Nb6MuQgbjro5RbytnNxyN45bZSNUpg=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 00:56:10 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 00:56:10 +0000
Message-ID: <d18505f7-4004-4177-88f6-c80b8e362976@oracle.com>
Date: Thu, 10 Apr 2025 20:56:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: suravee.suthikulpanit@amd.com, joao.m.martins@oracle.com,
 philmd@linaro.org, vasant.hegde@amd.com
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250410064447.29583-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 496a2f44-39d1-4033-0c3e-08dd7893a611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTFxT3B1Nk8weUJpY0xFaU43OG9kUzVkTFBMcDRKTS91NkVwMVdoZkI0ejZi?=
 =?utf-8?B?alU4dlB0cFdzdmZYR0pTSnlXZFkzK3d3bklsN3BqQ3l6elluNnNVT1FMTTJI?=
 =?utf-8?B?Z0dTV0YxUnMwcGY0bEoyVXVIVVlWQllUK1FIQlFyeDBhRXJyS3FwR2lVNGFs?=
 =?utf-8?B?MkVZUWVXL09odXRCVlVpdS9mZEJNZVlKYSszMVlENEhTVEJtSFR5cTdEdmhu?=
 =?utf-8?B?dEtURTNOR0FPOTczMlFHWW03RmpBUlZjZkZQblJLVSs2ZjViSTh6cytieUZj?=
 =?utf-8?B?SU1aNHprOFVKdXA1b1Z2M1VSRndZVlg4VDdxV09uL3VDZlk4Wm90ZWFFRmxt?=
 =?utf-8?B?Vjl5Q2ExWmR5clBTc0ZRMlBEVUVlY3NSVWpXdzloMXZnODh4eUtpVjRFMUg5?=
 =?utf-8?B?SGxLZTJtTGg4dERSSk5TMFlLK0NhZEROeGVnbEdiN212ZlNLK0hOOEhrRyt0?=
 =?utf-8?B?dVY5aUpjRDdRdEw4U3BQcFhZQUNnTW91OVV0TmNqZ0ZSWXNxUGFCbGtuRnAy?=
 =?utf-8?B?VEZjT0JhRXBzblgzQkJXa05FNXBuZi91KzdWQ0NKenBNQ2djbHZOblloYVp0?=
 =?utf-8?B?djdFUEZtZ0M1bi9EYVBzT0xLVzZ4cW9vWURIOUVFOVBIWHZ6MDBJdGxiMUh5?=
 =?utf-8?B?TU54a3QxcHpxU1lIRkNTeWVSOGRkdGI5dUd5WFhmQmNUYlFHK2FsQ244WW82?=
 =?utf-8?B?TUkyb0FNVkFIdThTcEhiYTZFRnFSVnhRNEE3T2IybHlGZzQ0MUd6bmg1dlAx?=
 =?utf-8?B?SjB4MGRuVFcvYWVJbVVyY1dneU5nUVpoaTV3Yldob1hxU1EvNENmRWp1S3Vl?=
 =?utf-8?B?cng1VitQUVNya1dLTFVtOEg2cmhFQkpTWGYxSThrZXpvU1o4MzVJb0pYTmc5?=
 =?utf-8?B?QlAyc2NMSzl3RzRnZDV3ZDh6NlNKUnZtN2tNa3NBVkhhbWZ0T1haY29icFBo?=
 =?utf-8?B?RmJvQnJyWElYNlN1blUwTU5SWFlDWk5jQlBuL2I4RUhDNHRlU1dyU3ZER1dy?=
 =?utf-8?B?amRJRDUvaGNiR0pSSDl2OFdKUHpBZFM4Y0w1ZkFlR2MvU3ZFRnVYN0dFc1pR?=
 =?utf-8?B?cGdjNitucDdXWFlQUDRhYS9ycTRQTHdDVXpyeEVjRGxYZG9RMEFYRTZpbVZW?=
 =?utf-8?B?Q21uMmUvNGdvTWM1enRCYjVZVlo3ZGZFb0x4RmhNak11RkEzVlBLMDdSYzM3?=
 =?utf-8?B?bHYxMzkvVGdlVkZPenBiUmdHU1ZzelNpRDUyOGNhK2phUUVHUXVlL003MENH?=
 =?utf-8?B?T1NZaFpsT20rajFDeDEyVzRmSGpJSU1oS1RHclFYQzlDV01PRkZRb1NxSzRu?=
 =?utf-8?B?YUhIMGxWVm5FVnV4MzJueW5yUmt1ZUgyUDhDVlZXQUVzalY1b2tEMFpBbUR5?=
 =?utf-8?B?OWNZeGNFbXZkdGVIdlZpMllJV2dWUVJyc1g4MUZNNm14Ukk4QXQ0Z2dHMHBT?=
 =?utf-8?B?cldCNnY3YXdlUHA5bDYwMXNhS3R1QlpTLzRzdURzS0NDZFJSK3lubHRoZU0r?=
 =?utf-8?B?ek9lL1A5clZwRDlTYzd3ZE1rUVcrOGN0M25VNWdpUEIvcS9DL2JuR3U3b2pM?=
 =?utf-8?B?TTNjUHozVHRNeW9MN3hwTFRySFAwYy9VSkNOVlAyT3FFN2VEYzQvNVpVKzcx?=
 =?utf-8?B?ejZubXV5SFRQV1NhUmt2R1hxeWRGRzZWRk9qaHhxMTdJNXoyQUo3cytuR3BU?=
 =?utf-8?B?YjRPZWJuejhpNWptNVJPL1lwK29NQnFoM2NDcGsyZ2RBMENFcTlkMXZ6ZGJP?=
 =?utf-8?B?bE5hcHIydTBmNExPNGdHbE9Gdit5dDU2bnQzbWE0dFRrT2ZabFVxZnBNelY4?=
 =?utf-8?B?RzhZV3R3VDZTZ1dKTUNtVEdqYzNjUEE4dkJtRUM1dEswY082d0xNNGMxUFlB?=
 =?utf-8?B?NWI0dmNKL3hDOS9NYTcxQlZBNWpEV3JNY05WSE55WC9NaWYzTmNoVis4dlky?=
 =?utf-8?Q?dhKUfP76khw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTROdCtOMVErZUZRSVl5T3Y2ME9wTERhd0tvY1g5RjlMQ2lSN3pUbUlnTFlj?=
 =?utf-8?B?Zk96N044SDFQNUg4aWh4aUNrMHUyeHNaUjNvVk1LOWd5eVJmcjRaUjJJV1Nw?=
 =?utf-8?B?WFNNTFAzbjZlQWF6TVhTVU1VY0djSDdlbzcwUGNPeDZsOFFsV3BKVW9tQ09o?=
 =?utf-8?B?QlBoWlUyQmoxd1hGVTd2eEVmV3NCSmc4cWZmYk13MUV3a29ndmRkcHhibkxj?=
 =?utf-8?B?SjZQQUdORCtXZHBvN1hvK2l5N1Z4S2hTbURIajNJbVplTjFiYjhJWXk4TGQr?=
 =?utf-8?B?aTJXNkNTaWd3MHNlOXBqaGxoeDZGU3A2bVR0UzVzRjN3b0JIalhYeHA5OXJK?=
 =?utf-8?B?Z1hBclJvSFhKYmpBQUhCdlZVcm1QQi9HNGRSemxIL3d5L1lSY3NrSlMxRmJI?=
 =?utf-8?B?QXZJajlEUHdSN0dUcTBzSXFjRlVwejFKQWF1aHJLQTZsVHJOL2Z0aEhCT3ZY?=
 =?utf-8?B?MlZJMmVGZFdybjRkUXIyK2ExQmtPbnIrU043MHNVa1M5clI1dkJiYU9DbEpn?=
 =?utf-8?B?aVpKckwyZWV1TythNDFtOCtkQzIwNGRCclpEYmNEYWpIL3RxSkx2a1hGd0Iy?=
 =?utf-8?B?MkJSN1VMaGtqZUFwZ0ZlYVZHdzJZZGRQajVjYkZsVllNUEh3cmxJVkpwNVdQ?=
 =?utf-8?B?YThNSnhhOUVDTWhQdDRwZG8yTlJONkluTUxlUjhVZWE4UUEyY0FEUE8xbjBk?=
 =?utf-8?B?aG9SSkpwWUpGb1V4ZzU3eXNUOG5Tc0JyN3RJNEQ2NnJ6NytZUlJlQlM2Tzlu?=
 =?utf-8?B?RndlRXJMMFd6MjZNak11MmZHRnNKNDlKU0VvQ2FwVW5mc1NxOVZxTzRFN1R6?=
 =?utf-8?B?MU1wVWU1WW9VaFF4VDVhdktVZGVSMXJNcCtuNlhqRE4vWGpsbVVYazYxd2NG?=
 =?utf-8?B?QUxkRE96NkQ0ekFvRWNIaXNlWXBkS3JOdGZjWm1kb0p5ajJCbEpaM3JSK29L?=
 =?utf-8?B?YVVjZDVRTkFBVGc5d0hQL2d0dmtyWWJ5VE9VanUwcE1jRGlNUXB2UDZzUzVG?=
 =?utf-8?B?czJNeTdWZXd5SmVoRTdxTVY5N1NUNXVaSkwxSWZLVkJteHFHVk9XNFEvZkMx?=
 =?utf-8?B?VFlQTXpWRVVRdWdodDU2VnAxdzVYd25ZWnVtWit2aXB5RTBsc2o3UWgzUEFI?=
 =?utf-8?B?bzNIRkZmL1ZLMHBWdGdKdm1tUmVLZWpzVVhNbk0wUkVUUVNmcFRrd0RXUncy?=
 =?utf-8?B?a2MxWHROV1F5WDNLWnpiYUpNZG9wd2h6MzUzK00ySXVtUmVscGhMSWhrbXhW?=
 =?utf-8?B?R0N4bUNpNWZ6WmF6M2F3SGRmaS91ZUNHYWNvRjgxZWNDOWtCbEttdzBNY3JW?=
 =?utf-8?B?eTJMOEdLTEpxM1UxQVZTSmwzZkFnWDVpenNEMmdXR1c3TU1JTVFZaCtPMHNJ?=
 =?utf-8?B?YTNQMVU2a1pOeDljVWpHQ1QxYk0vMDR2Mjg3ZFllVmdMaXVoREd4ckM4MkZp?=
 =?utf-8?B?R0UvYmloVjJYb2ttQzQ1cXFic2xCb2dNY01WRHV4SnZGNXhXa3plWkJRRTJ6?=
 =?utf-8?B?MEkxMnVHMi85dHpRdFo0dXlMNTRYMVB1c3ZrU1F6RlNMZEE3Umx0eFVHMzhw?=
 =?utf-8?B?R1Mrb045bmljMEdleksrMU1CK0E1dE1qUlAzcWxqdHo1WmMvMWhhNExGODJJ?=
 =?utf-8?B?OWZJZ1pOTWg5dk1zQzZmVFhGUjFSeUFxUTRtQlpKQldFWjJwUEVJbFlZTzRT?=
 =?utf-8?B?OXM4SGUxcWhDQ3JPczJjd3JheWtFR0VkN2JFRzFQRnU5M0JicEl3YTJIRXlx?=
 =?utf-8?B?STBISWhLRnNZZ3RhYjkyeEQrQWc1S0NvWDUxU2lqYUdaamlRZGdDRDdFZ3hi?=
 =?utf-8?B?ZDdwYkhmU2k3TTNqUEtLN1dCWmVJeGpybkZhOVBiMDQydHBzc0JtSEJUQnVp?=
 =?utf-8?B?ZzNHSllITlpWblRjWGllRFpqSjlZT3l2cTJtd2xxaWd5ZkhwMkNDVzVpQStG?=
 =?utf-8?B?R0pkOWt2cDJmaCtVRzFOMzhxb29zd2xaK1BmWGVDdy9sMlVkZEtRZnpKUEZz?=
 =?utf-8?B?UjZvWXZvZWVjVHp0by9wb1dsTSs4ZHcrTW4rMmJ6bDFHYUN0ckFiN0RNZ0M1?=
 =?utf-8?B?SFcwTmE0OVdTblJBM3JwekF0bFo0UndRU0pmWVZGek5lb2JaUTFCL2NBNVBZ?=
 =?utf-8?B?ZzB5OE0ySUdTSVpUNlRiNU9EYkhiczBrcHFCZ1NUaDg4bXdGMmh2NFFFZUdI?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UZdyQp0pBuPDOOFjBZtNsjWXxIlDIRhdasEquewIsw3A7cg7MEXhtdlAAnqV03zArbqV82C1T8jCp9pEpcz8DLJlmy7OvLKlV163AJZLpvQRRNmGwztpxaiqGa9Ok/Pc5/m1i7tlBxqsaZaDoBY9hLz2pGm75ODnt1wOdOF3aD94WWWSGv2qmbrFBpS/L/E/gG40D99O/sXjbkbHbyro6EKkq83qIK2DvITrCeMGBA2wmphjuVwGxfoe29JCH3Pkf3/MAP47FvokHAp68V1FDb8c6PB84+9hYEftC2zQgn/f3bW6GziYdh9OU6tWxxC33tqKV1Avx+PKlPj605VRQow8y3GAUmSSbcWa/zXyzdeN3aLdaf3EbXJhu+ycEbBZ2LqVwYksZrKlR+kiuJfGYFjtL7yDlC0ImKdsmxVKhn20Fw1WqtH7ZSIBFP+C/UznEfLkvZJYxxV3G5spISUH200gqy9xlZ6YOaIEs8vZ8007xIAtBxFsf7yXzIRaTzLY7GkK+8JKU/mEp1JmeoqcmB3s9+iG5SPKGS3l1126uKq3/sSpuwmP6e5N1ExyNUCLdvSUqNl2BKwAb8e6fYkce/m3BfUNEIm7RJkYwzlr/jI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496a2f44-39d1-4033-0c3e-08dd7893a611
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:56:10.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR3agsqHzLIRHtbAFcd5O825knBumOJ6V1QN5Ejs+cDKureLiLkBi6wrtKcSzt1T7p8CngelWG9W5yizg29//00ATesiAEkRiXhpqc2au7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110005
X-Proofpoint-GUID: nwuEHj27DgNipRfF8YzkBbhU0fXcXZJO
X-Proofpoint-ORIG-GUID: nwuEHj27DgNipRfF8YzkBbhU0fXcXZJO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 4/10/25 2:44 AM, Sairaj Kodilkar wrote:
> From: Vasant Hegde <vasant.hegde@amd.com>
> 
> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
> But if vCPUs <= 255 then it won't call kvm_enable_x2apic().
> 
> Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is
> broken as it fails to call kvm_enable_x2apic().
> 
> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
> 
> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
>   hw/i386/amd_iommu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index df8ba5d39ada..af85706b8a0d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>           exit(EXIT_FAILURE);
>       }
>   
> +    if (s->xtsup) {
> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
> +                          "the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>       amdvi_init(s);
>   }



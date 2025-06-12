Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18DAC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPp1A-0001f7-Qo; Thu, 12 Jun 2025 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uPp18-0001di-Ax
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 16:59:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uPp13-0000jJ-6N
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 16:59:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJhbUY009858;
 Thu, 12 Jun 2025 20:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=aMNlRYV9/QY3v/snIRzyK9CwW2W/oMht5fPWQcMoZmc=; b=
 LjdMOKSgHXRzIBxUkmHCy+RktPerJm1WqXzStM+lJN92Id3OIxQwEROqSJgm0BTi
 zK/kozOBqWLSbZo0YA41IBpjbJ5vAPDkXcUBYcuGWrIYTBOgUv1mtyJoohI4ZY+7
 4TiRFNWgVKbGYvbMLusUoLMNuhMdm87niBUsNNiIC74XKomkGJVuROVIFXcqDan1
 wORcKH/0sr0HGN9aH58nlLdlujfeVQprT6nrxE07z5qqCMio5DfbpQv0JqBXZHth
 mZnrTuZ7rFTLuZm3Ifo/j214x0+GAshX5eKn1IunilRL9iVF/NHT95J0Rt1WY7VB
 4vTHRKW4hg9OtbCe1gHgSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14jj2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 20:59:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55CJierd013445; Thu, 12 Jun 2025 20:59:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvbuyc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 20:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRkCxZT9H730A2ZHIqgl8udHNpPQybMZ56TVRc97OQ8BGn0cGizMHpUO7HfLNaGEhGJOgK+GGuKS/dm2og65NO5I4mSrfaDhZlHaLDs4SvPeDf7sAwfSNUISVCfqXvacqtzJS9nLra4vVzZ56En5AQSTt50m2ddVyLgM0fdM4xY0lZ2TAqzABIbXDayRlK+0OO/+VQrDTLiI/LtgM5CNYHEwzSh5zdk+/L+dMtWmTCRtxgNsyew91WefKlv586uWJw7DrINbA6H0ZdO6e9TBSWaKHjrd6tGv/wbCBCjZtOusP8YJ4V6vjkpxhOU9N7ksX6CufyxheC7BftfqUd7I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMNlRYV9/QY3v/snIRzyK9CwW2W/oMht5fPWQcMoZmc=;
 b=LpD5r7+RXUVnRzVZK+tkAlvBGhxssZ+xQ40aPUAX2XYskU7+Ctn+79xJeNFYoIIcsdPiZi0ZDzYCAKDg4phth2sGd8VTtUkItPqxDx/8OsIozIV2I/6DDbdKV2pSaatvT4sniclE2JNTqDoAAlndv9c84onAUdzxGCglgClcIfnMU2WH++NVNMsy3zg2dKKM1A9Sjt15q52Mdzgbj+0qJTHTHCGP8yw1uoy8DIitMflGfbPDmasYB1KmzK+Ro4eqdKOJttaugPasK6WE6aAignZ4p3bg8lU7UTJLBTweT1MPFphjas5lHkILloAHxWf6FBE2tG7GBcj4xkb6uPqpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMNlRYV9/QY3v/snIRzyK9CwW2W/oMht5fPWQcMoZmc=;
 b=g05R73OKWhOjkXwJkTwnqtzlJ+ejdC6UD5MhTO2Azd0gTUZMQk3LYgEvrEWGvlYixe6bO9HwoeZBg4g5QSINxHoBuUgwOjFWVJBN2TK2pKyR+9rp+mi6w56Cvsu124rsV/4MYvj8gACvUB65+e8QVIbOSvcVzkIfEua3AffgZ10=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 IA0PR10MB7231.namprd10.prod.outlook.com (2603:10b6:208:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 20:59:04 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 20:59:04 +0000
Message-ID: <ca5c935f-adc7-4d9d-930b-b8a4e71003ab@oracle.com>
Date: Thu, 12 Jun 2025 16:59:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] amd_iommu: Fixes to align with AMDVi specification
To: Ethan MILON <ethan.milon@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
 <af1423ff-24ad-4a4c-8a42-eec5fe77a66c@eviden.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <af1423ff-24ad-4a4c-8a42-eec5fe77a66c@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|IA0PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b041d7f-4444-4e18-2b8d-08dda9f3f6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFVzZjRQUkxneS9DajFvaTU2Z0NtMUdnamlDYnNQa0V0amh3c0kzSzBMbjlE?=
 =?utf-8?B?Ui9Za0JhRk9qWkl1ZWlYeEovNEZVRWRodWJibHZyWjh0MVZMUU40SEFVVFF2?=
 =?utf-8?B?dGFua2VMdnMxTElHTHhpS05QVEQxYTRmS0tJMHROaGhGbGQrZ1V6enJlMkRI?=
 =?utf-8?B?c3pFN0haUzZ1Uk5uVDBLUWFNVkpMaWM4THN3U3FjSjRYc1EwMy9DMnFFVGxz?=
 =?utf-8?B?UWg4Ry9tcnVhcW1lRGI0bVExMlRiWVV3RjRBZWlJNVRLRkVMdFdza3E5K2or?=
 =?utf-8?B?KzI4dUo1VG5xeDhrTjVFSjlTSUNoVFBvOXU1TUREdWhNbW04VXp4WFVObnZ5?=
 =?utf-8?B?Qi9pcGhveUhzVVB1enRmQWdURzJLZDdRNDhlMEMyS09pRy9IVHlvNXBBSjZS?=
 =?utf-8?B?eXd6S3ZvR0pLNEpyc2pROHlSQTM3YUdyRmNGaS84a0xtUWNzN2ZGTmN3RHJP?=
 =?utf-8?B?ZU1PeFg1M3IwNERDSHJtRldlUWhSWEVaenV5Vk5BVkovMG5aaC94cWREOHRR?=
 =?utf-8?B?dGNYaXFmaDdvU2wzS0x4SFBkM1VZMlNTMU4wRXJxckpyQ2pUdlNkTk9VVnpu?=
 =?utf-8?B?WkQ0VlhGRGhTTFRiVEdpZEVwTDFteWpSSzU4Ui9DcnZvckVKMHJuL1pKL2Q0?=
 =?utf-8?B?Y0ZuQjY3RVl1NWZrSURhQUl5NkhDUFAzNXBTVjFnQVVNSnVaanpwN0FPWSt0?=
 =?utf-8?B?ZmgvYUNWNFJDSmhYZ0Z0cGlXNkxsWFRSb2tUb01Ndnp4U2QyMkV1bDQ2SFBx?=
 =?utf-8?B?dmczaW9PK0FqSU1mdHI4cEk2ZGQvMXdTUHZ2NmlqN3Q3cXBJMUc0V0tXYWdx?=
 =?utf-8?B?WXVBd0h2dWtLemNQWGU2RG4vMlFQMHF4bVRGc1FlMnkzdFNYVm4zbHF6SHZR?=
 =?utf-8?B?Y3U4L1VkRjg4MjducTIxcUZncVc1L3J5TmdBMCsrYXlDRVBFUTl2SG96Tm91?=
 =?utf-8?B?SlhqKzZBby9keU5Qb2VwbVRtSTlqUnl5MlNZQUJqUHFXVW9jVitXWmJ4dXh3?=
 =?utf-8?B?Lyt4SzNJYmd2ZUYwaVFRYkdleC9kM29McVB3bDNGRUtSOUdzMWxqSGNqeEpE?=
 =?utf-8?B?RzVBcFVCcmVTcXpnNlNJb293RUFWZjQydjFYQ2N6bkFzSzZlRmVJT1cwMFkw?=
 =?utf-8?B?TjlJRFZsWEpjaVlaa093VE5maGlUOXZuODJzdlFyU25SOERVV04rNnBKVy80?=
 =?utf-8?B?eHd6OU5NcW1qaUFrZEJ2bVR1eml1enZTVXlLZU9lYndRSlVvbnp1ZEFHSmdo?=
 =?utf-8?B?UWozbGVrUEhLVDRod2ZJNUVxNWZ2Mlpjb3VXZmhodXJSUUdzdEpmSTNmWHpl?=
 =?utf-8?B?bkt0UHM5TnBRUXBVMk5xeERVRjdoYVhQdGFiYmhvWXV6dllKaEhwdmRhakZp?=
 =?utf-8?B?TEV1NTNnSHdzRC9lNlMxWkludjJBbVN2RlFpZmJvZjNHM2hxODdPak5lallr?=
 =?utf-8?B?bzhNUGcxbGdLNzZMbUNmSFl4MDZkOUVEdisxb3BFclZkRTViaVZjRlhxQ0pP?=
 =?utf-8?B?eExxVTBNb21rd3VpVWRteW5JM0dwYy9CVmFUSEd2clh5Rnd5VXhPZWsyb25l?=
 =?utf-8?B?UXkyNXE1V3hwdjhaYURvK0poeko0amliY2krQzI2UzU1ZWxMbGNRbHBwb1Nn?=
 =?utf-8?B?aVZMNjZ3T2lubzg5eFVYZlZ5N1ZaQkhIMmJjSEF2OXJ4bll1cG40V1ZCaVI5?=
 =?utf-8?B?SXFONlFLdFNxaE1weVJnWk5vSWs1c0xlSU85V3pHWkZxNEJaWXZReTRRcm9G?=
 =?utf-8?B?SWZhOFBrdDZPK0dHUkJsSW9zNFd5d0x5ZXVsc3FCd1RZRVdoREdTTzN4YVQ4?=
 =?utf-8?B?Z01ZMUVNYmFvckt6MjBMOGRidDF5Nm1zZTVFVkpWdmxFbHc3ZWFVb2tNWG5i?=
 =?utf-8?B?cmpWdU1SM2MxL1RDbVNsUjFUZUtjNHk3ZTFFRWpPU053ZVVuM25Cc0VYWlBZ?=
 =?utf-8?Q?H+0CZa6KrM8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9JT1FCcEJpQU0ydTFSR2UyTjFMVm9qQlpqSVNoV1g2OUhvQ3czamtTVlY3?=
 =?utf-8?B?dnptd3dGbXRxT3Z2RWRlK2w2WEhKbTBrRmtaNEQ4QU5vbGtSK3RVbUZHWWNV?=
 =?utf-8?B?NDhVYTdKY3FSSm1jUUxIMkh0REwrOGpVVkNRNDg3MVZBa1BtcmdKZUd4U015?=
 =?utf-8?B?eUNBOVdmU3gwWk41V0x3M1FGTlgvdWMwNUpGT3VhWEwwZklQTGl5cno5ZStK?=
 =?utf-8?B?S1l6QjRmbVVxdFRkNjMyMmpFRzJ2NU1qWXlweHAzYzE0QzNFejJZWWdsQUdw?=
 =?utf-8?B?TEhucnlFTjNoQ3Q4bG9VQlpIM2E0RDhuWFovMGpFVWppaFg2US9lUTlqNE02?=
 =?utf-8?B?b000aVlNUTdWVVJpajdCRGxUYWhLQWErWmMxZHREV2JMaFZQODA0TE5DZGdB?=
 =?utf-8?B?V0dpQit4RGFVN3A5MDAvR2RxWncyRkY1Z1MxTXY1QUN3eHRJeTFpeGwvbFZC?=
 =?utf-8?B?bTBGQm5SNjdUMUNiWHZmaU9Xb0ZmdFdsQXpaSTlHM0ZLaWxjd3pMN25Hb3pR?=
 =?utf-8?B?YnA4MGxxVjR6SzdCZW1kY3A2RnRHSnhtSEd0RHRxNjRNNUljZysxdEJmWklS?=
 =?utf-8?B?cWNyT3d6cTJya0NFd1dBdWZHTldHeE1TcE5CY2ZFUHorWTNpSVRLK2NsTXJL?=
 =?utf-8?B?NnFlajk2UitjanJiVVM5bFg3MjI4QnZMUGxZRS9XWHJDV3cvOFdaeE11ZjlZ?=
 =?utf-8?B?QWNlVzdEeG1RTmpXL09LaFJhcVRlS2t5V0pWZkZ0SGhoald5T09aaGJ0RnNq?=
 =?utf-8?B?QzNkRU1sRHNZQ0VuR3ZiZllhRm1BcFE5Q2VrSnVDbC9IVDZtYVNXZVVBMjZP?=
 =?utf-8?B?SCtYb2RDU2NpQ0FsSi82TFBZQ3o0akh6SkZoV240Q2VSOFUrMTlCUzNuYWJa?=
 =?utf-8?B?amg3Q1NLSDM0OVUvL004UHlIQ1lpUXRSSEh2aUhkaXlPMHo0NTNoRXNSbEJ3?=
 =?utf-8?B?ZlBPOGludlkzUnJMRjVWWmpNYVN6c1NrWEU4ZHpydHZDcVJMRFhaWWtXNHVK?=
 =?utf-8?B?YTI3OWdYY0xNL0xFOGNJYVRyMlVObzhFbENPRkE0ZzR1ZW51KzFDVnk3UGta?=
 =?utf-8?B?cytwSEFpUlg0NjNuR3NnWEhyV3BDdkpSVW5lNldaditXZzlZeVc0cVFDSjNM?=
 =?utf-8?B?Tk1vMmp0MmY1cmNHd3htSkhDQ3QxajZLR0xVUDY5eVJwQSs4b3YyQUxhY0J1?=
 =?utf-8?B?QUlNZFJ3RlAzVHlrVlY0S1FSWHNDaEJHaFAwWXR3Z3dncVBwNFI1dEpsNUkw?=
 =?utf-8?B?WlhDVWRMRE1reGVnTE9oc0VVWW1RN3VnOTNXMFlNRHdOUzRPbTFyT2hTVWtS?=
 =?utf-8?B?S1VBOG91b29VRW1RMVR4YmxSVjFMQ2tFM2J0Y0NmLzRRQ0E2TFZEOXBkRGU1?=
 =?utf-8?B?RjBhbVdRUW5HOWhETlp3ZVQ1eWpsNVZ4ck80VEFGZkFCWUZ6NFBYY2YzZmRx?=
 =?utf-8?B?eVhyK0Y1S0ZlZk5VOTdqQlV5S0cyaHRFVGVRejYxNUdCSUIvcnJjNlBoajJ2?=
 =?utf-8?B?aEFvRUxQV0J3NG9BU3ROWUJkRy9iWVdEOUpTWldWRzhmMXpQSlROOFFXeGla?=
 =?utf-8?B?bExEYlVjdnRSeVdHV0RBVEN2bE95cFJaanMyd1B1WW9wOFZKOXFPdDdYQ2hs?=
 =?utf-8?B?Z1UvWDBuUm9mTmdtdDdvMm1CczVpWDNWanc4ZkVkbHJUWG1pTzd3WSsxYmRM?=
 =?utf-8?B?ZlFMK1FRL0RrUFVWSm1IenZKeHFMeGpoYnAxaVRwVE4zbWxUWTNXbW9BcVN2?=
 =?utf-8?B?UnN1aTUyZXBRL3d6TC9NUHZPSmlWTnlSeGUzSTVyLzd2bklzL282Tm9reTJn?=
 =?utf-8?B?alpZQ05rTFRFVk1sdlJqZ3dlWG1nN28zTUd0aVE5U0NmNUtWS3c2Y1AxRHJ4?=
 =?utf-8?B?dVI3VFo0ZUtBaFNVQmIzeHFaR1JMbzZCd2hZWTNNQkhwWjR4T1U1RGFMMmI1?=
 =?utf-8?B?KytXa0RTVnBDOGhyaW1TeWo1Mmx2TFkxQzRwU2x0MUl5RkxpditCQ3I3MUtG?=
 =?utf-8?B?Q2ZMU3FBb29YTWVSVzlvVUpvUW1lVXZlSHUvSlNjOEZRckIzcmxrQmJwMjRN?=
 =?utf-8?B?ZmFQQUV5MVIzUVBKMHcwR09PZ2xPdXF0U1NyeEJNVGdyMVUxNjh5MHJhdjVS?=
 =?utf-8?B?Q3BaeUtGQjI3VnIvYW0rL2xSa0gzUWxtODVnU05iL1lqdXVIVDY4Uy96eHlU?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZRgxPBW/0NzS2Vr22RjHJyAe+quWbCGvnU5rQwmBvrjeZomtbw71XqAmaSqXC3tdOB0bgjsLZXpbppbD4WE9oj52EA+lqX0ugeHjC1WcGjP+c4gQodR6ceZf5F3hDd0PdYHzvm1XTI0dPVGQrn0RoxAnkmFTdxHyttPMLmSSIpRLfn7CosBdv6OZ/fh//hEWi1v2sILV4VbU9+7o40Bfrh7Hs47+zqS5Lh8QQeni5jiM1WXmW2NpoW9xIXgjM3C4idGh7d/VbegXl58Kf/OsGNgZiFBdzSdFmqLtwm2b57MBzBd43lQifOgUULvt2MZYA4qY4LFcoLZ89YyGDivyK7EQKmwTAuk25yOuphwxfKItbkqj+x0OyC6StFKcn47aloUaQr5VTvPQHOJYZhv0Ua7lyScdpMt4KJwdfZJlQBcB7Vgd5RFeB4g7O0Plx7TQ2KRqVptXCfheH12uA8ifn6uvU69yjAgsK8KYiIXIAquHZ5mvsX5xDsD5GEuNtxZWwnwu/cd+bdz9befLBhmXmu+jd5tF2OfRrnh8T+PlpR7TlT5YbFOoCm10lx0hIRJjoSGja7a/JhqTE966ovxGkIwWLgnXdnIRCE3dNoGt0sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b041d7f-4444-4e18-2b8d-08dda9f3f6d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:59:04.3627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HZyZ4nJJDedu7Gu8KhD6iQYmOm6j/XqWVM4s1lh/3jv19t40tgiyNodUpUu52XUl4V5RqLlLu9Fdd5emb+bWwF3ElOmRpBSw9U40CtiFrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506120161
X-Proofpoint-GUID: phtvSYchynoLCVvwaTPHqt5WiWY8V-F4
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684b3f9d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=MozTD6wawY16Vvf1Dk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE2MSBTYWx0ZWRfX+p+uT36bpdlf
 2bhwlKmLgcFDu5WihkRwahM7vOVMp4TOf49QprDrZGGOEQXnmneAz034Mu3fZ/uG3Qn7XPoGtZi
 e0UL1TO99n1KWGHtsu3NABVLw2/628WfdHGvaf3dsU7IkgYRMKjHNdWlkwd6jw0tzTP7BNSGElA
 Vt77kmD2SZPTe86VBRRbFWeXG5DIqBvp8eSyhxbPzR0QHSwIvuf8hVMGsZGxEkYDjD/4MoOwEHE
 T5HoQS1lXOgx0M47YYQm8TTMgyMbuu0g+c6jlPGrELKffCE3Dv4goj4aDP5nvQPTiePYpCK7OiD
 A7CdJrqmxHXjiqtbynVWQPRCzcZu3KZamt2BAmK35SmN3axBq0iaQ5Cro7kM7WDekcXnM38Vp1J
 3KXiEd2FxGCvQ0uukUn9sFy3z7Faj/ZDKISRllIwjIMJq8jOmtqaSK8vtpP8St3JlhrUaRSM
X-Proofpoint-ORIG-GUID: phtvSYchynoLCVvwaTPHqt5WiWY8V-F4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Ethan,

On 6/12/25 4:36 AM, Ethan MILON wrote:
> Hi,
> 
> Is this series the right place to include the following minor fix?
> 

I would defer this change for two reasons:

1) This series has been reviewed and tested already. I was hoping it 
would be included on the Jun 1st pull but I sent v3 too late for that. I 
think it is ready so I would like to leave it as is unless there are any 
objections ...


> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 0775c..18d30e1 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -140,7 +140,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr,
> uint64_t val)
>   {
>       uint64_t romask = ldq_le_p(&s->romask[addr]);
>       uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
> -    uint32_t oldval = ldq_le_p(&s->mmior[addr]);
> +    uint64_t oldval = ldq_le_p(&s->mmior[addr]);
>       stq_le_p(&s->mmior[addr],
>               ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
>   }
> 
> This corrects the type of oldval to match the return type of ldq_le_p().
> 

2) This fix is needed, but it is likely better as part of additional 
changes that are needed to cleanup/fix the XTSup support. i.e. there are 
unhandled writes to the 0x170, 0x178, and 0x180 MMIO offsets, and those 
depend on MMIO 0x18[IntCapXTEn]=1. I think the truncation of oldval that 
you found is causing XTEn and IntCapXTEn bits on the control registers 
to be ignored, but ultimately things are not broken enough (yet). In 
other words, I think there is a lot more work to do in here, and it is 
something I am looking into.

I suspect Vasant might have spotted this problem already, so he might 
even have some fixes queued up...

That being said, if you want to send a patch with your S-b I'll add it 
to this series.

Alejandro

> Thanks,
> Ethan
> 
> On 5/29/25 9:30 PM, Alejandro Jimenez wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> The main reason for sending this new revision so soon is that v2 included a
>> duplicated [PATCH 5/7]. I fixed a typo in the commit subject and missed
>> removing the old patch. Apologies for the mistake.
>>
>> Additional changes in v3:
>> - Fixed typo on [PATCH 1/7] subject line (s/Miscellanous/Miscellaneous/).
>> - Added 'Fixes:' tag to [PATCH 5/7].
>> - Added Vasant's R-b to patches 4,5,7.
>>
>> Thank you,
>> Alejandro
>>
>> v2:
>> https://lore.kernel.org/qemu-devel/20250528221725.3554040-1-alejandro.j.jimenez@oracle.com/
>>
>> v1:
>> https://lore.kernel.org/all/20250311152446.45086-1-alejandro.j.jimenez@oracle.com/
>>
>>
>> Alejandro Jimenez (7):
>>    amd_iommu: Fix Miscellaneous Information Register 0 offsets
>>    amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>>    amd_iommu: Update bitmasks representing DTE reserved fields
>>    amd_iommu: Fix masks for various IOMMU MMIO Registers
>>    amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
>>    amd_iommu: Fix the calculation for Device Table size
>>    amd_iommu: Remove duplicated definitions
>>
>>   hw/i386/amd_iommu.c | 15 ++++++------
>>   hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
>>   2 files changed, 37 insertions(+), 37 deletions(-)
>>
>>
>> base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e
>> --
>> 2.43.5
>>
>>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7C0C7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 13:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUmHW-0000H9-GD; Thu, 26 Jun 2025 09:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uUmHU-0000Gn-8V
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 09:04:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uUmHR-00043X-E6
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 09:04:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCaZWZ012710;
 Thu, 26 Jun 2025 13:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uFQoa/oson/Eq35Cv4XK63/U80rlpwVhcS603K7cgiY=; b=
 qyrENTgo3O2pcETw1FFG/MLaR2nh2ArvBn3T9V7alKabcZ74JOruNfNJHiehe4GG
 Y5Q64D4ty75SP0DEpEHs79IFqyZH6cvU9V6pCjN71UeFrM/xPVLJ5HkMR8LLaIV2
 lcvIUmhnN/0RRFm+Tj2mq1wnEoNOQ6dK+/Hr6MD5p9CJMXKJxbMEq9uXYB9OLzny
 84H10mK3DY3+ONgSuP7LDYIoUygek1tiMW7FZcqmyaFQ7ZMnGo9BYJfgcjU1/M/Z
 drq9rTIy9WAJOZUY3FRvAkprdUSHoiG5MIIuwljEhStxlwUQJkfRSzZHJgTogUty
 V2Lv4Vz4BOCOEpsEiJ2JBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7v1v8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 13:04:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55QB1N5N002029; Thu, 26 Jun 2025 13:04:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehr7egq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 13:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjpt2hFpuDe1ZWZP8I1atCz0fuAOSnKxcPiYM8VspxisidQD3U3yUai1ySc5qYWSu+6lN2KLxx1pKDoRZTWmRwKXU6aaZO95PRfo2FK3ErObXzMFU9iXUdjaYbF8CBkAL+wXoKMWr3uBxPf8sByhpPFy1XOWVlVn+xyQah5dml4qz81kbzvDnxHnyMAJ+N89HA6W30nur5VmMllXTgZT6VEsR/uURa3Ap9/YTrQ8DTYb0PrksskXDTWX7+EaYjkqjjPy7gceRFGDOuBhyfze6WlfVqAN+w7EQphx8lAK5SW9dLgT+kjlHvK3B0e9S/5k/Gk/toh8a78aXtkfg6GUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFQoa/oson/Eq35Cv4XK63/U80rlpwVhcS603K7cgiY=;
 b=ApjUqRsutAQwy8afCF2ywRen3tHduCepY+Yf6kPDX2qYvqvrhqSHUqnYC5qMXVHTWc5vieo3IlCPlHpfLi7hDQLc0Qk9udfmRV27buh9NbmKbqimGPdtTkaimozWoANJHGcOIeysq7THoVQqYEvVWAed7iA7LHX90KkVDRVLvyYXfKB6OCXVeIUdJQhiCHHDCL6Ps4E/Nwmiz0iUWrpXjO/DlBkLaeNydc7q1xWymnBaNl8pQpcQnaxffpO/ttt5LhQsjX7KnnYMk2vf8i98jzPAsVwneVwWtXK1HlkJvkdsMf2IfDV7A2koCSySOqT4+aRwRf2rIjR1w0bu4oEc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFQoa/oson/Eq35Cv4XK63/U80rlpwVhcS603K7cgiY=;
 b=b0MSR4JWod16/V2lZNc+J45j2omeBjVvRff1PSRqkslojotBOQR0gXFJdaJfp9DAwTf7TyUd1d4YGI5HSdTROKQCoTztrF0Wmhw5ma+wUon8u4uQ/cwQEDulMb2AlGza26nj+hmGG4kzbMM7Qo8kNRmGVT2nQY4rIAS/j9c0LNQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4357.namprd10.prod.outlook.com (2603:10b6:610:a9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 13:04:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 13:04:31 +0000
Message-ID: <78c4fe63-357d-43ba-aae7-47bdfd4b6844@oracle.com>
Date: Thu, 26 Jun 2025 09:04:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/container: Fix potential SIGSEGV when recover
 from unmap-all-vaddr failure
From: Steven Sistare <steven.sistare@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-4-zhenzhong.duan@intel.com>
 <9479b426-c725-4b8c-baa9-246d0d7d1fa1@redhat.com>
 <82566d3e-edd9-4860-8fcf-c676fd112bbe@oracle.com>
Content-Language: en-US
In-Reply-To: <82566d3e-edd9-4860-8fcf-c676fd112bbe@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fe548c-07a1-44a2-882b-08ddb4b1fdb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEU3SkpIQXJscmJrUGdoeGxBRHd0Y1IxSGwrRGluYU81VitVUmFxL1o1cHF4?=
 =?utf-8?B?dEMydXg0K0lwdExqbEJKYmZWeE1CeTBjV296RmhOVnVWc3A0cFpFb0oyZVdN?=
 =?utf-8?B?OG9TVUhwbmhpUjBIYnpUNldBVWI1bjVTcE45OWE2U1RNbTJXcC9CdUUwZ3Zs?=
 =?utf-8?B?ZkZmc0lzNWNXOTMxemRxWHI1YnNnbGo3TllpaG5aRS9QNUR0aDlVTlUrSkE5?=
 =?utf-8?B?YkJvU1NHQkxBS0c0SzdoeUtDemc5RDkvRHVwTkZlV0dFalJRWUhVNWFrZ2xE?=
 =?utf-8?B?aWdsRk16ZVEyQ3c2QU1kNEY5SkZ2ZGNWelZSbS9pR0RVNHFWTGNqSXBEQzdi?=
 =?utf-8?B?MGlxWExLeDJoK21TOXNPOXg5aTc5am56Wmpyc1J3YWcvcTMyeDBDd3FNbUdU?=
 =?utf-8?B?VjR1SEJwbHNya0QxRlI1a0xuN1lSdzlxRDJRaTdsZ21POW9hWlNHVzk0VUFu?=
 =?utf-8?B?bTRJZVBrbVE4cW04UkdrQ05HdkphOWJ4RFN3MTlGSFhBcDdlU3hkUDllaGd3?=
 =?utf-8?B?NGFwWnZ5b1g3c1ArZ1FQR3NlN0NvVG5NK0QzeThLNFE1OE1TQlhQUGxSN3FI?=
 =?utf-8?B?a0JBeXdvU0xDM0VaR0VyajNSa25qVFBQdENBZjExVkdVQk42Y21TbmZxK0t0?=
 =?utf-8?B?aEZEb0hpWXNVaWVZMlhkcE1uTHEvcUZhSlN5QjM5bGxoV2g2VEtwQ1U4Tllz?=
 =?utf-8?B?bmZ4VXRMOFpjTGE4WHpIQ3VzN1Y5ZUZ6cTdHWVpJYWhxUWcrbDFXWTlURk5i?=
 =?utf-8?B?K2hZaGU0UE9lMndRdlB6QWpwOHRJWGxtUGZpTHN3cWEvSlBiSFpCSE54b2Rq?=
 =?utf-8?B?dW5OV21LTEJZR1lWeWlFekI1Z1dQdVVLMmlrbEJCK3dwMTJKMmowNitzYjhG?=
 =?utf-8?B?UFJtTVdmR0c1ZGJJeWdqYzZzckMrbk9JbFVRZkVsTHQzWVZaS0hPOEhZYWRw?=
 =?utf-8?B?NVFuUk04dG1WUm13VElDaHMvbllzVEp2ZTg4TEg5UlQ0RU1oVGVtK25wT0d3?=
 =?utf-8?B?WW81enpiWUpFaStHNllTSmMzYndxaFU0VFNMbHQzb25DMmZDQkRHN1d5Qzhl?=
 =?utf-8?B?MWxVRWZlUDZtVmZnWnZRcVVpc0NQVEtYcTU5bk8raHJyV0dXM0J0YS9HUWlw?=
 =?utf-8?B?SDFOZ1ROdm55Uy84T092M1QyVGhheldtbjJ3K1lsbGJ2dmt3aXIza1gyQUpn?=
 =?utf-8?B?L05jbTN2aEhHOGVBVEp4dmdieU1HaDgxcE9sN0hpcmJpV2doa3NYaTZBVk1o?=
 =?utf-8?B?WkdnTURTU3Nyckw1TXFoaXQwU1pmSUUzVnY3RUpqTVR3R3V4TDZaSUorbW5j?=
 =?utf-8?B?K0ZkNGlxengrTDdHTW9ENE1UTVFJM1NZZ2czY2pyeklyN0FmQ1RJR2NQYUdw?=
 =?utf-8?B?eUtaZFZFS3ozb1FxSFhicDZLdzR2VURhdlRldERjSWJyKytpWFhWMms2dHpl?=
 =?utf-8?B?QkFKb2t2bVMyYlo5VHJsQ1E5NWQ0UEFPSE9XT1ZvMUg1WDlIZFI1SkcwRGh1?=
 =?utf-8?B?RUNPVmZIK0RTeEh1UEdSTHFhdWt2Ym1sWDJxTkhRbnJSRm9Ra2ZtOTVjNmI2?=
 =?utf-8?B?MzRleDJwTldTVWpRS1MvbzdrMWp5RUYrSTdPbmVscCtKT1ZIVUtXRGpuVS9Z?=
 =?utf-8?B?WnpmYnplNFl2bDVRUndqVklpdEd0eVVNTmRKSWs0TVBQUml3ZnFYeFEweUlR?=
 =?utf-8?B?VzNtTnJjUEw0QzUzc2I5N3RUejBYSldCZmljZWpscDJWWUlmQXdGZGxWWVVU?=
 =?utf-8?B?T2Zqa2ZzWVphTGxzRTRNQWQ3akhEOCtwRG11ZWFxdm43VUFvdUVFSkdCQVZF?=
 =?utf-8?B?TGtaR1laVytRSFFhV2Foa2hadFpwTEE2V0JnVG9hVG5nY0xITVdqUEFVOFN6?=
 =?utf-8?B?alNtNlhMVWFRVVNUQXluOVdyR3llZDFiTEkvRFFBYlY3M2RkeTMrWFgxZ1Jh?=
 =?utf-8?Q?3PS4Gj1QWBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWQ0K1ZSZm1LYzgrK3lzQ2dsMmdUZUxXT3A3RXRKRG5GWFJyb3kwRE5Uc1lZ?=
 =?utf-8?B?b0wxVVZURmp4SEY0NW9abFFZNGUrdzhPRmIwTnNUeVFLNTlCb3g5cVkyZnNS?=
 =?utf-8?B?M0xXNXAwc3gyVU5vSUlEOHI5blE0QS9lTlBFUmloellESHZaU2p4TlUzUXNH?=
 =?utf-8?B?MGt5K2JocFllTm5YdXRqYnRzRjhkWmRNUHlremZoSTFFTURoRGdOekhXNlRM?=
 =?utf-8?B?d0xibXprUVpncGEvR25VdmNyMjl2L3Q4VTJXeUJCK2dkaW50eHlONVNPOXQv?=
 =?utf-8?B?ejlzRklOa2hJM3lROEZPbTRieDRWUG9aT090Mlo1SlBrN0FVeEI3UFlmUlFN?=
 =?utf-8?B?Njk5U0VvcVhIMkkrZlpjU09Pa3kvMTFKZHV4MitxV0hVWFZncGZRUGxBR1Fw?=
 =?utf-8?B?U2JvVHlTTWxOakFSOSszRWhJMkZrL0d6MWVGenJNZU9XMDhINUNUWkEweWlP?=
 =?utf-8?B?cE5yQkpBVW9WTDdFTDFXOWRsbkZqd2RGNXduaWt5b2hGWEE1bUpCbGE4YjV4?=
 =?utf-8?B?WWxjc0hpc0pMMHp0NnBzWWdJaUt1UDQ5bXFKc1dqYzN4OHBuWFR3K09XZWU1?=
 =?utf-8?B?dDNwS0M3V1U3SWFXU0VWNi9MNHMzbHZsc0tkSEhYM1dQWEJDT3VTQTlLbkZn?=
 =?utf-8?B?bElGei9YOWtrV21yVWlhSnlsOFlHRk5KUmxNdEpCQURWS0J1NGNJSEE1cStw?=
 =?utf-8?B?OEZGRWtQNFlwQmJUcjlaQU5welJiYkRJTHFIWWE0MTJRT2hiTVd1QmxTM2xk?=
 =?utf-8?B?U0ZON3IrbUZuV2d3SVZrQmNFZjdINXRuODFtYi9aT0hKdjhhaHAvNUphVDMx?=
 =?utf-8?B?SSt0TGduNFU5Z3hCNVBvMHI0Z2lGNDg0aHNhUFdnekRNWEloRit0Tmp2eDlU?=
 =?utf-8?B?UmtqUytIUnpza2xSdHZadlZvcktHQ3l5S3lVbXJoRlhjKytnbit6ZGUveG0v?=
 =?utf-8?B?VHdpZWV0ZW5oT210SVFLZmNua3VDYXgvRUU5aGFnUWc4eHFtV3RjOVpibnFt?=
 =?utf-8?B?cENLN2p6ejFNa2NxWnQ5cUxmN2pJWFRIZnpRanVSRXBCSG5YT1BROHduQWZQ?=
 =?utf-8?B?ZE9kZmRDdzJ3UHhhSzVnaVpxTzJHYnFoa1V6ZnMrZEFBQlpVeWhvRHRZeWt4?=
 =?utf-8?B?Z1JBbWpMR3VQU1NQV29qb0grOGt4RHY0TDVsa2syZnhRT2VrcmVGV3h1QlNL?=
 =?utf-8?B?T2M2cjJYUUxzaW1UL1BTSm5aK01nT0NPaEpKQXI2Q09SZGtOb1V2RjN4eExZ?=
 =?utf-8?B?WVgrZ0FrODNFWGMrMHlqYUFGWXlUU2hkMTJMNXNWZmN5Uk0zUFlyaXRMNWFD?=
 =?utf-8?B?LzlUMnNHOWUxaXJESzdhaVJ3SCtPdzJMN1B2Z1BpWVlyQ2NnWGR4MzlSV09V?=
 =?utf-8?B?RW1KWlZlR0JoZDJWSExXLzk5a1cvYzVrTklkS0hob1ZWWEsrcFZhd2Z2WkhN?=
 =?utf-8?B?YU8wMkxrYVVscWxQR1U1a1k2MG9ERzZrakhpRlgxTHpUbGZxcFF5bldrK0xP?=
 =?utf-8?B?Qm5PSlJSTjdLVlJsZzkvckxmcVREYkJOV0gzQmpIQWQ3U21Bd1lUSXpaQkFT?=
 =?utf-8?B?S1B5akRTL1hLazY5REdleFk3QkY2QUZmcXNZREI5L0tiZ3NyMDB3K2s1ZFF0?=
 =?utf-8?B?c0JyaEpyaG9odDFVaUlVSWhkNjd6d0tycTM5R3hYb0ZhZ0hFaU9rY3lwdkZB?=
 =?utf-8?B?STNkWitock04VUpSdlhQVmcyNWtRMHQrYzk4RmxyMG45TkhOM1VHK3pJenVX?=
 =?utf-8?B?N2FFU0VMbWFQaUFwREgvR0VGTWpsRDRrMEd6S3czYUNHQWg0b2dlQlI5ZGFG?=
 =?utf-8?B?Uk5KR1A0UUZCREVGWjNRVFFEZjZLRXpzV0lqcE5Dd3JPZmozRExVamVqQVp4?=
 =?utf-8?B?WHpJMm9ncnJYME4waHRHeVphK2Z5TUZ1OUQxU1gxREd0bnZxYk9uTWVOR3hI?=
 =?utf-8?B?ckNxRTlKdnYyOWNneXR5Y1RCellnNFJGVGZqb2Y1UmoxMmRpOXdkMU9xOXc0?=
 =?utf-8?B?aGVpT3FDQnVSenFRa2lZdUlCTDBqdHNQZGRxa2loYW84QWZzcWlRTm5iWEtE?=
 =?utf-8?B?ZW9LdjJLTjljN3dUMkNMSkJtUVc1a2NGTTg0dng4ckM2RFRjQ3VLM2RRZFRT?=
 =?utf-8?B?VklCV2tJSkNiMG41cjZOZXppTDI3VzhETlY3TEZZazB0bC9IeVpiL0ZrUEpr?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gAEaYN1jeHeOnW9d4rKgmJnplcsg46nopYMSZhlxE2GuEPwMi41bpeq12n6Mvz1dYk48Zckg1Az4t3XRuf5ontlELpUceLUVLAOq7oK6l8d7w47E055TfAJv9YCipEMvQmWYe0FD3OmxvZ5amY/PqSAJMmNBSsqkjFYxW3vHn/ycctY/0GHxzJP2cluWIUQ+ccgUs/TTTNgMG78KB5wxAeHD8eNgTcq2FUSySl4K0asv80BrvcvBwiYqEcXuEdcJcDnTscWu6nryphgp3+t8XGapf0FLatwuLPrPAZDHZSPjOVm3Ld4kPW8+mglpHkOhN1wRjd6W62l1oH1xQrDKECgBNmN/nDoQLHx98Gs76fe5Mt6kBVxCkry45t9PbUFW0cezaUr7FuqXe4LESiTiHXjwgb818fzM43pFP3EvdCSTqVKMPP8LHc3oBOvTB/IKj4685WCyZBj1VE/KNpUc3zBQTe78BLt7V6+WM7sWXv/7BG/aEwjgsUERbZd0ZgMUj2FbvlTvH6kAXE73xvW3+oSTmWI1fbuRcDswDUd8/uerCA5w3aDDF5ZSdkZqe6wwp708X3Ea2gpWoWJh6slznm98vGWkeV1ulCDf17JkOx0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fe548c-07a1-44a2-882b-08ddb4b1fdb1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:04:31.7219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFje2sX+ACoBTqfPOFYspbkGrRNEOk0v+vSCepVoC6YNZvNBgggIWInjB52xIhZU5IaCtlFnXl6ARgu0QO0eis4Ph/kMuaGWUaunp1hEIT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506260110
X-Proofpoint-GUID: tkR5vMOGQcWPnKkRnVNzFNa7ooCek_sL
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685d4564 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=6pcn12I9JqDR-FFcDIsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: tkR5vMOGQcWPnKkRnVNzFNa7ooCek_sL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDExMCBTYWx0ZWRfX5aHi/sE6UQOe
 XhnrXfw1UjpCuO8ejmN9/FB/be+fDXkwxosK+NYx5Wz2CmcP+DQHkZOxRVgYhfkXg892dSoSRbH
 wDSisiJNA0tMDWBxRKtNLGFpkIdy/VNcMafV25ANeFIlWeaFmcVbusiW1r5uaFv06/uULqcPFFZ
 zN0tGdZGKdp8d4cHK6wWgLbVqKzgeWWr/IMX5AAe6Fk3r8RiroIKWl6oH43u6Jr6iNcGh8qCAiL
 NhgIKeb/RyDfzeKPK7Vs5GFI64HqIQzzzgLU2emPz/uCqXvlZWx4Mz/DvkiuLJsxt5nVJYCBMga
 AfSHMiBMEhQyqIB830iJfl0LKpk5UbpBCSNeaBsSB+io9oklL71t0HLfettvzOnPQlTuXMxzSWm
 8ZOECcSdBLv8Vjfwwrk+eCQup8+/gk5mqWBM+Kejbn7JjOqT7csR3wLrHgi1DqyHFciLzxBC
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 6/26/2025 8:53 AM, Steven Sistare wrote:
> On 6/24/2025 12:54 PM, Cédric Le Goater wrote:
>> On 6/23/25 12:22, Zhenzhong Duan wrote:
>>> cpr.saved_dma_map isn't initialized in source qemu which lead to vioc->dma_map
>>> assigned a NULL value, this will trigger SIGSEGV.
>>
>> I don't understand the scenario. Could you please explain more ?
> 
> Thank you Zhenzhong, I see the bug.
> 
> CPR overrides then restores dma_map in both outgoing and incoming QEMU, for
> different reasons. But it only sets saved_dma_map in the target.
> 
> So, a more future-proof fix IMO is to always set saved_dma_map:
> 
> @@ -182,9 +182,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *conta
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
> 
>       /* During incoming CPR, divert calls to dma_map. */
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    container->cpr.saved_dma_map = vioc->dma_map;
>       if (cpr_is_incoming()) {
> -        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -        container->cpr.saved_dma_map = vioc->dma_map;
>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>       }

Now I see that patch 4 deletes saved_dma_map entirely, and looks fine.
I still think the above diff is the best fix for patch 3, and you
can move the "save and restore locally" parts of patch 3 to patch 4.

- Steve

>>> Fix it by save and restore vioc->dma_map locally.
>>
>> Steve, this is cpr territory. Is it still an issue with the rest
>> of the patches applied ?
>>
>> Thanks,
>>
>> C.
>>
>>> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   include/hw/vfio/vfio-cpr.h | 8 +++++---
>>>   hw/vfio/cpr-legacy.c       | 3 ++-
>>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index 8bf85b9f4e..aef542e93c 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -16,14 +16,16 @@ struct VFIOContainer;
>>>   struct VFIOContainerBase;
>>>   struct VFIOGroup;
>>> +typedef int (*DMA_MAP_FUNC)(const struct VFIOContainerBase *bcontainer,
>>> +                            hwaddr iova, ram_addr_t size, void *vaddr,
>>> +                            bool readonly, MemoryRegion *mr);
>>> +
>>>   typedef struct VFIOContainerCPR {
>>>       Error *blocker;
>>>       bool vaddr_unmapped;
>>>       NotifierWithReturn transfer_notifier;
>>>       MemoryListener remap_listener;
>>> -    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
>>> -                         hwaddr iova, ram_addr_t size,
>>> -                         void *vaddr, bool readonly, MemoryRegion *mr);
>>> +    DMA_MAP_FUNC saved_dma_map;
>>>   } VFIOContainerCPR;
>>>   typedef struct VFIODeviceCPR {
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> index a84c3247b7..100a8db74d 100644
>>> --- a/hw/vfio/cpr-legacy.c
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -148,6 +148,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>>>            */
>>>           VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>> +        DMA_MAP_FUNC saved_dma_map = vioc->dma_map;
>>>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>>>           container->cpr.remap_listener = (MemoryListener) {
>>> @@ -158,7 +159,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>>>                                    bcontainer->space->as);
>>>           memory_listener_unregister(&container->cpr.remap_listener);
>>>           container->cpr.vaddr_unmapped = false;
>>> -        vioc->dma_map = container->cpr.saved_dma_map;
>>> +        vioc->dma_map = saved_dma_map;
>>>       }
>>>       return 0;
>>>   }
>>
> 



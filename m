Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386E1C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuu8e-0001Cv-FF; Wed, 19 Mar 2025 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tuu8Q-0001Bn-MU
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:11:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tuu8L-0006ZE-U7
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:11:06 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE0qVC026901;
 Wed, 19 Mar 2025 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=6vx8/uMpfZEZUIBbuTd97ZQLQyStaooOC0vmrpLXMqI=; b=
 VydSihhAtziSdNNy3Y/Todp+L+qZVMkB8OLnbBdh6qne32x9BBDeTAkEWOHkmoi6
 g3zYFvklSec3X6P3/Z5emOasS4TNr/CR9W6ChAYBZSgVop/jsY+VZCiEsnZeTz7x
 tV7NaxhEeltda7RdRSuTDZsuSN4eG+IG7Osd/2wDNai+tBpQYUicaod6WmuKOkvP
 HQFdAtOISNql7waZmHkQBZ3hCwr41Y7YJ0aaajsy2mqPyAVWKIYhe1DjA2gNgt3/
 KiqRnSRMdEPogX8uFNcUs5sRGU3JKNRWUIjZPBqYoLJa9oYw+tdp+PYYOIU/Jo7l
 NXKs0LUp0w2aEka1++UmTA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s3h7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 14:10:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JDDgLD023554; Wed, 19 Mar 2025 14:10:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxegx1fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 14:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axgqtQJNJiLle0esQ6O2su6/cfLr2c5uYWqDXtPBoOZ/P+aWWIyZn+5PuaqS5DJzroSlQpNaPT/Yq6JAvolB9YTURgReMrAJxogQlX2AG3qPZ6bKBkwUwQUTh0IMOK9HY/w81I70Jp/gE+T3i7kVyTSIq724ftl74W1dIBnESwJHRGA99H3jaRp9hz/QVmXSajV5aE5ItXKpbjscacxYpmmzJO6glACPEfc21QLkbWsgzAERejzFroQM1ziig4xaHI5MN/NNvdcaMITDM/7dCG4O84hFPg4f8Vq7cZXfr+JGRF7yT2aCaRSzBQ4WDPlqU0uYhrc2/wEd2Xi/MgSvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vx8/uMpfZEZUIBbuTd97ZQLQyStaooOC0vmrpLXMqI=;
 b=flntvGw+GYsr8er5prS+g6KpO+3GT/wWQSDF6Zr527iOcktW8bNGkAtvmxj3uhMKcvBquUAaM3+JEPyCXNnLQsGDMD/h3K6anO74WUJB6YYH2IFO5thFrSEASHsn2tjF0pL2u3CEuoZZwD42ggmFkPxKD84P2FCYdlpJIrtIzGxFIZHe6fLN+l1ocEfIwOyJ+63IHEcnLW5wmcIK2eDSFgTWyg3jKe0kH4zSo64nZGJhpxOdl9nk+ABwbsqQyj74GQ3qkAiymF+LASGIceG3mE19SBNyJYIQx11jXOQpGyUpxRp0EDv6H5ZNXkiclWe9alJx8ld4ePyUc73AJqySLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vx8/uMpfZEZUIBbuTd97ZQLQyStaooOC0vmrpLXMqI=;
 b=Oftic3wsWxpqyJUaIfJF1U1T8eP/GtC6s+29a8134T/Q+W1b1TRntuwOagNQv16NNV6vYJr/A4oV49O/ACIFnRnfEDxqxkvGfZ+EOQv5A+9POJ+CCBxECRZxB0ybGmfWV90xszNelstJWl8mvviX2FEZxlIyI1aY1I47zA9AFZw=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 14:10:49 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:10:48 +0000
Message-ID: <fc9e7513-cf11-4cee-a27e-cab65bc27be1@oracle.com>
Date: Wed, 19 Mar 2025 10:10:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] amd_iommu: Do not assume passthrough translation for
 devices with DTE[TV]=0
To: Vasant Hegde <vasant.hegde@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
 <1c69c44f-6e94-4c44-8fae-8216c66f0a4d@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <1c69c44f-6e94-4c44-8fae-8216c66f0a4d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:208:120::19) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SJ0PR10MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9134a3-d419-405e-90fb-08dd66efd90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVljOFpaT0NtU0lBdnMwSm00TGlzV2FuVnRhNGc5RFZtY2xCbzZhZjRWUXpL?=
 =?utf-8?B?Q2YrT1JPaUJiQXBWR3NXNEMvb0MyR0Jub1ZEVTZwaWIyYVg5VUxwVC8vbVFV?=
 =?utf-8?B?Z0FocW14K0pDaHpld3l5ZEtUZGtNMVFycTBKWEliQVcwbk56NE45ZUt2aCtj?=
 =?utf-8?B?ZnNKbDU4N0pZYW1DLzREVDVDZjhYaXQ2d2JNOW4vMDNacERWRmhnMU9MbE1L?=
 =?utf-8?B?KzRwM05COEhIVjZUTXUzZWpFTHNzaUQwdFgwSUNBVW9nOVQvTGQ1VXlGUHF6?=
 =?utf-8?B?RTROQ0xzTTZ3YTBUV1B6MVFISER6TlF1RGVOaXZrYkt5Z1J4UFN2dDdyMWMy?=
 =?utf-8?B?VFErVVM4Z1dJNFJ3OUpGVkRtZkhaVUhKOTJMUDhtM3ZvdTNaUHpKZWdDZ3hR?=
 =?utf-8?B?cWMrRDY5eHlkODh5NG56ZDZTWUdDQUx3dWlNSW4zbjJhV1VMbSt6SittYWx5?=
 =?utf-8?B?S0NEdi9Wa2NtMExIOXlMNjd1bE9xQjRKSXBaeHNRMkJ2TjJ1RkJndDdoWnEz?=
 =?utf-8?B?YXlxTXFQbFNrOXRtZEhWYXpGQWNob0FKRGJsdHNvR0c4dlVvWUdMa2kvdy83?=
 =?utf-8?B?dk9LRk5OSy9kam8xWjhKTG9jTGtIOVJrclN6Y0FvQUpIVTVtMDdFSUszbVhC?=
 =?utf-8?B?c01zTW5JOXJkV29QdUwvdHdWUWpEZ1pwZGQvRWUvMklMTE0rcEl5ZHZqUzZQ?=
 =?utf-8?B?enRxeDBYU3lOK0NiZTdmaEZMb2FtN1RGaXlsalF2T2FsTGVmRk5VVFcvQVF1?=
 =?utf-8?B?SW1IS05HWWF6eU1LdDM3ek9kREdoUUxmU282azZ3UXpBekc2QWVrenFTWWJj?=
 =?utf-8?B?ZzE2cVZUQ0swS28rRWlwOXRQQUJxakc0R3F0YUdVYVQ4QXRQQUtHS3lUWUpR?=
 =?utf-8?B?YlRrakNWK1FKb2M2V1pkWmlKb2Y3QUpyMjZuZGxPeWJ1aHRFbG5EY0VNRkRu?=
 =?utf-8?B?SnlVVlhkekxSSEdKYUt4dmt2K1BMNlJzQlBJYUZ1MWlOV3ZXdGJwMHdOanln?=
 =?utf-8?B?MXNqU01OcHprU1FBVnJTR1hodHliZk8rcW5DRktWVTBSWlNBYXQ1WEUwUUNF?=
 =?utf-8?B?VnZpWGZrZVlPYXNRdHJNbHpQdVhvblAxTTBwL3dJYlp1TEdiV0M0TTZZdlRG?=
 =?utf-8?B?YzBwRzFIcVdVSVRnQ0I1SWswYkVVcEpkWTdXSGp0OGs1dGEvYnlTVVV5RjU3?=
 =?utf-8?B?dHlUNkRTNFVrdEdNVWRRUDdlQ1Q4dXlKMEVzVlNKanNMWlQxQUd0T2RYTDFZ?=
 =?utf-8?B?aUl4RzIxZmFDTEFyL2FVNzJDT3ZtV3BjWlJSaytVSjdGSU1qZWRLSGxGYzFu?=
 =?utf-8?B?T3NLV1hFWGtxcTJpY1ozRVZnVVdWTFdtMnd4R3Q5aWxadlZqdUI5SmhNdndH?=
 =?utf-8?B?elRISG1TNlErZ2YwOGRvVEVGd1hUTmIvS1JzeVMyRjkyL2l2SFQ4UzRYMWZq?=
 =?utf-8?B?MEF4Ym5TRVJDSkVuVlZBOUUydXc0bWZIMHFBZ09haEY3SFRHZTVwcUJCYXQx?=
 =?utf-8?B?bTJDTTMrZTRPV3ZoSFZTamx6N2RycU16V05GNnRkbG1meVlFK3hYZ3grdU0r?=
 =?utf-8?B?MVhhNiszOUxiWGpNdkVuQTMralR5WFhEYVE2V0UvQzl3aHl3RXFjdU1hVnY1?=
 =?utf-8?B?VTBJeTVia2ltMUtySHRyOEJvdHFJYzhOSUs1YjZpSFNJSGppVVM4TlNBMVlj?=
 =?utf-8?B?YjBscjdiVUoxbWdVOUlSZEQ3NWgxMnphcVRYQjI1SlJsMXJwOHY2WjlIV3ha?=
 =?utf-8?B?cFlIUExQWitXNVpTdHJBNUgvY2Ztd0pOMmtoVUorL3BPZnNsSklSMHp5RzFL?=
 =?utf-8?B?cnFwR043KzVUek1VWVZYU1d2OElXN2hmVWU0RFNPY3VVMnJiT1FnNS8zUDVO?=
 =?utf-8?Q?7DEdkqJS4Btm0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVBdytMbFBrVzJSaW91QjRJNzJTMDZ1SnMzOFVTSTMzM2JoWXhVY2k0aGhE?=
 =?utf-8?B?dmVzWTlibVFxeUI1dVN6aDI5REZ0ZDd1eWVuMXdRL0s3YVE3Y1pwQjVLN1Ns?=
 =?utf-8?B?N21ldEJLd3picExmYnNOMWpmUEc1K1VLRENYL0dTekQ2N0dTZENJNkhoOHZS?=
 =?utf-8?B?T3V6OUJlby9QTFZKVlRXSEtXNDNsSHdmVXBGOVZtTWs5RDhqUUVxNVY2eGp1?=
 =?utf-8?B?MVFnL3FhUWxLRTU1ZlRjWGR5elVvVVV1ZzdCeHB5b0E3dExKbzM1c09zS3hD?=
 =?utf-8?B?eUhTT3FId0ExL3hvbTJQVFFIN1g5RzNFd3FrVVVtN0J3Y1lMclhsUUJVUlhx?=
 =?utf-8?B?RE9Yajl1UllmWnhQdUprUGE4V28yb1UydHBHMnBhT0ZzaEJEbGVLV2xJWW16?=
 =?utf-8?B?YzZ0MlJoZndQWE5HUzZNNTE2Q0ZSQW93OWVoYURKTXJTamkwbXlMbXhoeWly?=
 =?utf-8?B?aFZISHBXbDlGUFc2b3NZdnlvS2lFZFdhcjVrRlFLemdIckNHVENkYUVuaUFr?=
 =?utf-8?B?NjVJMkxEL0FnTWozVkFyS2tUNDdxVUw0VEpRQ3RUaVNWSEVQWmZGdmtyUlo5?=
 =?utf-8?B?UzhwMmR3R0VXYWxiMFFNdzhMSWV4Z2E0WkNqSFZzNDNrRDFIYUVkdzhIYjd2?=
 =?utf-8?B?NkFIRXhGL3NwUWllakRXanZScVl2RDA3RS9TMCtXVjZhazN2Ui9sUDJtWG5z?=
 =?utf-8?B?KzBKRzRxNll3Vy9Wa1lEczJ6OGZlT29BNTFxb1VJbVJNbmhaS201em1QbEIw?=
 =?utf-8?B?TUxHYXIvUTY0QkUvMXdqczJSVXpneG5LbTJWeCtxeU1YVXE5MjhTZEVTa0Zu?=
 =?utf-8?B?U3FqVnVybWRtZXJ1M3A2VXhSVmhzWGd2L0hTc2xoSTNDSEhFU1FjMzk1cDJD?=
 =?utf-8?B?eHpCeEJUOWh3WHdxdytXelU5N00zVDBhLzVybmJvdVVZdlNod3luWENjSEh5?=
 =?utf-8?B?TlI0U2J1bkdsV2Rqd21EamgzWFZtRXZwSkpXTVgwYWkvdmczanA1STFNSEkz?=
 =?utf-8?B?eFdLOU14QklhUWI1WEx2U2c2TUZwaUZPdEMvMDJmZWplZ0RHb2JwOUYyNllI?=
 =?utf-8?B?ZVlJVzNJWnZkUnVrWXE3c25NU2hJbGtHOHVpUUpxNGVoQmJIdkx5M1BNaG0y?=
 =?utf-8?B?NU1lYlFLZGdoYjJWSGsrYjZXWHFxMVBHc3Vsck8xN0xzUFEwSXUvNkxXbEdU?=
 =?utf-8?B?MlBmRFZzT3hMT2R3WVN3ZVhWd1BBK3VsZzdjR2NMM1IvYzlteEdIUmdRdTIy?=
 =?utf-8?B?ekFvclpsaG1Da1VHZm9zMHNVeXNIaDJ1VFJyMDFteDY3akp2U1k4T3crc0No?=
 =?utf-8?B?ZE5td2JPMXl0MzJDL05WLyt3ZWhTOHNoTm1MdURjemVCK200L2EwcFc2eHBP?=
 =?utf-8?B?c1lJbDUvTm1KMXgwM1ZGRlA3b3lqUU9xb21rYmoycjkzM3k0aGppQ2VXU3hN?=
 =?utf-8?B?ekRsV3lwbklqd1JjUEtjWEJwbWtDUld4eloxZmx2SG5SdklDOG9jOW05R2tU?=
 =?utf-8?B?QVR5eXZ6M252K1E2NlEvdUxRckhETWJvVWg3b0RoVCtYRTFuY21mdjVSOGJz?=
 =?utf-8?B?UTgxUkNWVGQvV2dGNUc1d0lKK2UreDF3NTZ4TU8wVk94bi90dys1eHB5emZO?=
 =?utf-8?B?Si9XSGpXUFlmTE1wblZFS1ZoTFV0QVNNT2N0QTRXVlc0YlJ5eW9Mb21DQ1Vh?=
 =?utf-8?B?c0VUZXpIUlRkYTlCRVBxZVJHRCtiRHdVRC9hMnVITHJSSzBPTTBtYUpNWjRN?=
 =?utf-8?B?N3VVTE9zL2ZOZnFkZUlZYUlTYTFQTjNybVBFWDgxa2FPMUVNR05IQ1JMUmdN?=
 =?utf-8?B?VS9JRHU4cnZnK3dJWm9WemRsWGFLK01FYVlodEJENEJLa2htbEVJTEhET0l0?=
 =?utf-8?B?bU8ydzd3U05sRytYelV0bGhVaEdEckNSbGIrdkpPYmtIeVpLVWNtb2NmNnIr?=
 =?utf-8?B?d0FjdzRFR250STdqUUxqcTlBK0QrNWZZVDBiSGFSSkNsTS9ZeWJkRHhLUEVx?=
 =?utf-8?B?eGRqcU5lUmRyT0lidHYxOGNuTDFLU0N1SStIaWxtYmkxaXRSSW50cG1Rc1pV?=
 =?utf-8?B?RVdkV3NRTGNvRUpvNW13S0FSUnVGYms0UlNDOGdNSTN1ZUxjcER3N3djR2k4?=
 =?utf-8?B?WjlFakdiM3NyOUNXaGc1eUhCNG1BSUZDbDNyN2dXWStTRWR0VjhQREJGZmhT?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DZssy271gRXwNvI9ARWVayaQnlUMYaJxADdZVIDQDjMQOVAKenOczV/rAoXAI8KWlXHDMg9u1jo7zOdr2eSZxDbfRgOI0vmJFGSwD+43lQr9U8pZ0vJ+iNkTp6IliCd+kvN+Ltorr5TulwhnuN/rLpS2AVlbNy/IwfYkS2J/58FfD/c6QGHgcZ6maoH+QMvcU2OgHKQrRg45SFOOt7fOVv+f34mzUitFWixA5bEgamEWnwnaPhghIwk6GePT46XYLJa33rE3T1C9mSyDi9QEOpzdyx04/92Bd/mHSSRPez6s2jehHhU5uA27I5VYf65HSY2ffy0JPg475k1waqvByZXCIxTSGHIdF/MXk2GJOocO9Vb5wj5QaqfkWK34zUervLgdP+4mVlbe7hGDnLKV8T1O1R6iyJI+eoSHfQZ2B4ulbXpQGgOSA3qvanGmQjRLFhQE3RVT2uQH2ygrK0npX1TklkiB1W3lr1AkhugSaotBtpGQkQ7aTWQ+shUoga7vWD+MLe3ENRLx7lZYi1pSx9A2J9727nj4+7OqaUqTkVhh0dKZdbJC4pKaJN1f5uGFOiriLPOwSVsNB5ZqEVUTG2dXUNfWxlUkkapJS80B8Mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9134a3-d419-405e-90fb-08dd66efd90c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:10:48.3455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw9yTjtnQStkVFgdZNb0iHjcfoi/jHXigVRdAKFlnUfd0NMECQWBtf6UcEau/dG/DEgk/LSXf/+F24dbJ7UeKECb+e1RwbsLphmBio+fqVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190096
X-Proofpoint-GUID: UMIy7xQM8NXlU-scLaIb4pphowwHaRyS
X-Proofpoint-ORIG-GUID: UMIy7xQM8NXlU-scLaIb4pphowwHaRyS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 3/19/25 2:06 AM, Vasant Hegde wrote:
> Alejandro,
> 
> 
> On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
>> The AMD I/O Virtualization Technology (IOMMU) Specification (see Table 8: V,
>> TV, and GV Fields in Device Table Entry), specifies that a DTE with V=0,
>> TV=1 does not contain a valid address translation information.  If a request
>> requires a table walk, the walk is terminated when this condition is
>> encountered.
>>
>> Do not assume that addresses for a device with DTE[TV]=0 are passed through
>> (i.e. not remapped) and instead terminate the page table walk early.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> I did double check and I think this patch matches HW behaviour. I did run few
> tests w/ this series. It seems to work fine for me.

Thank you for confirming and reviewing.

My understanding from the Linux driver code is that the TV field is not 
really used to control behavior and DTE[V] ends up doing that job 
(though I need to take a closer look at the more involved scenarios with 
SNP enabled). So I have not seen the case with V=1,TV=0 in the basic 
scenarios I have run, but my intention is to adhere to the spec as 
closely as possible. So I appreciate the confirmation.


> 
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> 
> 

[...]


>> +        oldlevel = level;
>> +        level = get_pte_translation_mode(pte);
> 
> Unrelated to this patch.. We may want to add check to make sure level is
> decreasing. Something like
> 	if (oldlevel <= level)
> 		error out
> 
> Otherwise bad page table can cause the issue.

ACK. I have considered replacing this (amdvi_page_walk()) with code that 
more closely mimics the fetch_pte() algorithm in the Linux driver. I've 
been using it on my (coming soon) RFC for DMA remapping, and comparing 
against amdvi_page_walk() for verification. I put in assertions like the 
one you proposed in that new code. But if that approach is not taken, 
I'll add the safety checks you suggested here.

Thank you,
Alejandro

> 
> -Vasant
> 
> 
>> +    } while (level > 0 && level < 7);
>>   




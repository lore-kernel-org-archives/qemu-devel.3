Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C4CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 21:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8mZu-0005d7-NR; Tue, 14 Oct 2025 17:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mZs-0005cv-Ir
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:29:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mZq-000862-3g
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:29:04 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfKKs003762;
 Tue, 14 Oct 2025 21:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0PCH+Oh/pVUt+ZIDP1NFSbS0WdJdsbZEVVIHwTGT5U0=; b=
 bG2+y2XH97336SJNm34or1jMGRzvrvh1k6hCAQ4QReZ23fJ8wJjjjq0sTv6pzRaJ
 rw9EAz8uoDsa7yG3zfv3pVqCjDwu0W5OSF8Ik5BrrzYEhMnl+QeUrpUp0DF1JIpl
 ESzB82PqRH2xhJKgl+qsD9D6yJarjI6MnF3Izg4Wk9NXLc494IGkcScU2KtKjnmi
 55XbDKB8jWRufp98GK6FLVGRdDMRmVHHneO4XbHY14pPZVA6L0kiyJCLSJlR5oHy
 yZf1W47CpGMxJCPTqHhqMhREA3e+tUJjWT5XNPhJCUKGh/94BgvGNcbh1biMq6PY
 LMRSaAnmjzXH2WSV1FpEVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59dbx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:28:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59EKLpuD018292; Tue, 14 Oct 2025 21:28:52 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49qdp995rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFyBEfnMlVm5Km4K0aQAlyvmBVAQzrfiqie1ZSzto8Tf2vV2MvEACXyiKJakaC8psBg9MDarbHWpBS1OFvRBIxI9jfG0gqTbeRLZslOL7YJhYQntXSIqFxvUkQ2KtgsJzVwKl91vjE1+yXFRpez7FzoC85UEW1yxFoUVBhWbxoEuPqURUoEFbfD9iDGiuG2nj73BIkaqTNI7Fvr+IGnCxB7/isgiKusHVEw0cbIzjZnITg1Tlvlg7L4FgeX1d+eMorI/j2H0ufxgczYc9ZaguTGnaKVxtE+HZoCF2I5id/OkNM2AMF2AEQoYGJJUfBCMpeY40iC9dq/vrQapFQTbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PCH+Oh/pVUt+ZIDP1NFSbS0WdJdsbZEVVIHwTGT5U0=;
 b=bmK9Xu6YcE9plzy/Dqa67g2cd96qIwGLTJqKbNylQnmOMSi6GcPNiOpnYDH6oTaXbf/SWf3j+aFSdD5soCWeL0HFFmCOYekf51R5glKD74hlTcxtbjKHrsRBE079A0vKcwHrHKQROA3PKtUafOopdlI2lO5rjoaKxEAiLjp9wCA92ZOHyrc3mgwcJ6lywpAL3f4gT+ZEH0LvEqmMsiFRmHqGRQxxCnkYXnodIZ5A0tKm8xp41I1yuyfWGNBSJ9cv0ULikcBILm02v7cDFHEchT4vVnsM2Cavazh2baQgd1tfy6kECIhGTyMcr6TcDyX4sPfVB5LgLRgsmKB1f7SBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PCH+Oh/pVUt+ZIDP1NFSbS0WdJdsbZEVVIHwTGT5U0=;
 b=GWPvc8UrzpU7gqEUL67j/P8T/SInpUQX65erwzWRCuVCN0Rm6AJx36mqktpi30xLHfZddzTcmCEuic9GZ8GItOJDTWPMgPhhoE82nfd6TwXreMQhOjDrEA9SYjvc+QacWpWmQV/36hNwqMavWUsxkxPEsBu983pzjEyfPCZVeZ8=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA0PR10MB7157.namprd10.prod.outlook.com (2603:10b6:208:400::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 21:28:49 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 21:28:48 +0000
Message-ID: <3a9b6ddc-f885-47c1-8e15-91e0ef19aea3@oracle.com>
Date: Tue, 14 Oct 2025 17:28:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251013050046.393-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::21) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA0PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 072ff374-43ad-4289-73e4-08de0b68a9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUhpbTcxQ0VPMEtaVDJvamxNaUJ5K0g5SllnY05PV0V2WFIzWC8xL21aYklm?=
 =?utf-8?B?QVcza0hOQVRLaWFnNC9sTktVd2NSd3FEQlhIZVhvLzhtQk1lQ0YrZG9IWWNv?=
 =?utf-8?B?SmhuTlFtWDV4ODNwOWFtWHd4RUo4aWttS3JkWm41MTFwck9CeWtRRS8vR0dw?=
 =?utf-8?B?NmNBYnVyL0JNb3B0TnBBS3haaWw1NUxZYjVPY2ZUM3ZKMy9UOTV3ZTZyREZ4?=
 =?utf-8?B?K0NyeXo4dTlsUm1EQTJQc1BaT2ZFaTlGcmdvV2hIUXcxN1FFS1hrTm5ZWVBJ?=
 =?utf-8?B?Q0p2ZC9HL0RaS3J0MFFtSkNtQXN2STk1Yy9sTmhIUm91RHhMNFFnUkkvUDZN?=
 =?utf-8?B?aSs3ZXZFS21weHhDWkJ3T3RPaFFuYng2T3ZITFZBRTFWdERFM2ZwbHhKTExx?=
 =?utf-8?B?ZXhCUEZXSkVrUy9nNytsN0RKbXBvWHViZG50Ymx4VG5CeDhOdFYrUFQ3VkZk?=
 =?utf-8?B?c3g4T3lrbFQ1ZVMxWkl3Z1lRSnhIL0pRS3hieGd4MjJGVTgzb3kyS1phd2pl?=
 =?utf-8?B?bElvYm5INTlVS1pXc1B5ajd0cFlTczlrSkt4VnFZVzQrcTVCc3BWVms3QkFl?=
 =?utf-8?B?Y2hwdFRBOUtHUlJybERyVjZLamV6Uy8yNEVzOGp1d05KMmxGam02ZENIa0dm?=
 =?utf-8?B?V2x1NE9Dbzc1TWVCMm1iSGY1TkFVNkxRdUZFNU5WM1RsL3NCVmsrbWIwSSti?=
 =?utf-8?B?UkNXQnF3Q085cWhQUXRNclZ5SXA5ejNZQlJ2Q1ljbzQ2UXIwRFdDcUFRamln?=
 =?utf-8?B?V05QQmNkK3ZUcHFnbHF3MngvMzF4WHJTejZsYUJKVUNsR3FNU0FUOWh2dUZ3?=
 =?utf-8?B?djhBVE9zVC8vdXcvOHRWbEhSTzlHTGtkeGZkaTVGQTNtUURsaFRuTm9qeVJ0?=
 =?utf-8?B?dHYrYXR6Y0Q0cU9zTkVxUEZsSGRDekd1M1AzMUxxVnVqZ0QyU1I2bWV2NU4v?=
 =?utf-8?B?bFFBaGNxeVY4dVNLZDU5akxPZUcxZlY3alBJYVZ6NFEzZC9TVVlCREdZM0lX?=
 =?utf-8?B?T0dxK3p6SFN4SEJZWVl0NzBxeGpVVFVwLzZNdE9nM2JydUJMUy9yU1ZsNXda?=
 =?utf-8?B?MGQxT0VLWnhNVEJ1WVJPdGprT2diVWZ4ZFFIdDZzK1VEd09oVmxlMkJvcmtp?=
 =?utf-8?B?YnRaL2l1NGJXNDFaU0NJMzF6YzVIMUxZeEtNcExVeDhibXZpZkEyRnBKVzVC?=
 =?utf-8?B?M09mM0dlbUU2UDM2L3VuTDdWN0szaURhZ1RQVzg3NlRtSVJlblY2L1ZmTVJJ?=
 =?utf-8?B?QTUyVzFEZDR3WTFuM090M0h0aXQ5SkdFRVNYM1dZcmFtbkxZNS93ZkptSDNJ?=
 =?utf-8?B?dURZV0lzNGZPKzJxS0VocWpYcWNRRGtRbWNZOUplUjVYeDIyeGxWQXg3VmJU?=
 =?utf-8?B?TWN4L0w0NDRPNDlnaFM5WDdnUFV3dnQ2bjh1UEI1YkRBc0lTTVZqY0VGZzZC?=
 =?utf-8?B?dWQ0UFlCZzF0UVd1TjJhS0EzL1ZEVk5VL1o1b3J2T21zdXRFbUx5Y2hvSXRY?=
 =?utf-8?B?VVRQbWg2dUg2S29BbkQrT2JrekJjd1VsOWpCMTZKVUZXV3pPbG9OWUwwOUVT?=
 =?utf-8?B?YmpsWWl1YTdVNkdkWjh5RlBldjdzd1Rnc0dOMjlHeFhMRlV3RVlNbEtuZHRj?=
 =?utf-8?B?UHo0eVBDWEJ5Z0VPcDQ4WnBsTldHSWRic1Y4azRUQVcwb1kwZml0d3lBaWlh?=
 =?utf-8?B?bVNQZEI1endCbDZFM1liYUM2bjUvSEUrVVl5cmIzK1luUktHVWNKTEdWbW9j?=
 =?utf-8?B?M2xHcER1Z0daaHFMQ2dYclpVeVJwZU80WUxnVTVUaTBLNnZsTk9zcVptZjZq?=
 =?utf-8?B?VEN3TTZqbzJHeGRlNVF6Z0swR1VOd3hDQmI1SmtlTDIwZ1p3ZE16QVRsdjZ0?=
 =?utf-8?B?NjJURXNFaGZkc1QvWXdmcjlXVUdvOGFNSGh2UXZ2Ky9QVGVOWXBwWWhBaVFP?=
 =?utf-8?Q?ZIOIUrJLxENhjH+VMeGtYZWRUE+sg2F9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZkOHRuTVVEMFZsZ29BK1hwNmoxM1hQRGJlN0JxMlB5eGNveHpxSU4zaXQv?=
 =?utf-8?B?MVV4WG53MGhyWFc4QXdqeSt4dXplWWR3QUlDVWxXOTNZYzZvNjVRODJZR1Ey?=
 =?utf-8?B?Q0hRaHhvOVhlZG5GcTJITE5NN21hMVJDUk11VUs1aWY5b1NrTVJNaVBDNkRE?=
 =?utf-8?B?NHFsd1ZqVEZvL2JsczJCQmpZdWkyY1EvUDREcStRYjdTZzFFL0VlNTBjcGVp?=
 =?utf-8?B?Zk1HQ2Z3WVhEOWVIeUhVdjdoRDJmakpLR045ZTFhaVAxVng1QURjS2JreG1K?=
 =?utf-8?B?TXVKUkxtYjJZZjllOW5qNFA5NERyYlNZbjZWR2FiTk0vR3ZGbUIwbW4welBv?=
 =?utf-8?B?S1BWZk1VT2dMT3NQRmpDZzh3VHdFSUFwczk0b2ZjOVhKMTI1dzdoUkJWUGUr?=
 =?utf-8?B?RTFxRlRTaDFYa2FuOUQxZGdEWXhDdU0xNHp0U08vVWNsQ045emhkcFhpcmVx?=
 =?utf-8?B?UjhjaTRXdElPOE1UVFVFc3BRbWxSOVU3TjF4aEZZSnZncXpYMTJjSGw5YTNY?=
 =?utf-8?B?OGlzOEsyQkgzTmdkb09FNlNDOUxvVExzV000WHZSKzlUOFl3d0hWUWVsVGVp?=
 =?utf-8?B?U3hhS21YeWtoTjZqUXZ4NjBpa1Zqc1FEZ1pVZW81Qzl2Vm1meGo3RmszdW5l?=
 =?utf-8?B?TExGbi94L3N5dEZuOVJnZmdkZDRXSVBLMEZnUjNqSC9XbGw0Z3pIZkpNem05?=
 =?utf-8?B?Y093bmNRWS9JTmN6K3hSUVM2RDBFcmNZWldBbEFxNzhxUFRZR2VCV3V2dzNp?=
 =?utf-8?B?YXkyc3FtM29wbDVhNlE3RjBURHo2eHllQll0MUQ3ZDFUZXZaWEFheGNmNmhV?=
 =?utf-8?B?aGxwVFpPQmpnVkxtaDBWa3E0WFpmOXdBNWt4RllyVnA4MzVVeUovZzEvZlBW?=
 =?utf-8?B?SGZYMWZGRHNuRUExVngxdnptNjljYmpocXAwOUU3ckZrTmhIYXp0ZUh5S2ZH?=
 =?utf-8?B?ZkJsdjNPZDkwNGgrdkwwZWZtRFkxeHVjRUdTcWtrNkZid0NxUVk1U1F2eStR?=
 =?utf-8?B?LzJXbVhMcUlVV0pycnV4TmpibnFKeFhyZjZrSHMyM3JXYTRiNWJEYjhkRHQw?=
 =?utf-8?B?MGF6cUhuRkFCaGJ6dXppeisyelFlalZiZDdlakttbXVic3M5amZKQ3dneWtM?=
 =?utf-8?B?UGpvSjI1VlhWYUFzZnlqVTFGbHJ5TnJxVjBFd3FVdk81Y25uRWxSK0plS2tU?=
 =?utf-8?B?d3k1WnduNzROaEEyZEpFZW5BMi9uT0dWZU1yMEhaYUg3eEw3aTBLaTFTQUdt?=
 =?utf-8?B?SVRWTUw0Z1l0WWNhWE84ZUhPQmZCcjh2UXFEL2taSURaUUxaRDd4UGpOaHlC?=
 =?utf-8?B?WmZiY2lwQmhuSnBlNVpuSWRNeXN1UU1qQ3ovKzZUN3FpUFFtSzJrK0NlakFG?=
 =?utf-8?B?eERMVzN1N0pVaEZoVnJBUi9lL3cwUmErYXM5TG5oZXcwa0NndFBBVXpOT1FZ?=
 =?utf-8?B?ZysrT2pBZGM2a3lGb1h0Zm41djNpMHlnOVFZb2draE1wb1lkME5CeXd1NjJG?=
 =?utf-8?B?MEpNbzc5SzRIMngwaXJjT2RtaWwvYTF2dnY1NThEdmdkRlZZMHU3ME1tdHNM?=
 =?utf-8?B?N2lvOEp5cFpYVXdEL3RaSEFtNzh5RFloTTRyTlJ3OCtzazhkOFpBcmwybmtC?=
 =?utf-8?B?VldzQWtrMEFuNDd4OE1HOWxORUZvZWE5bXdMQzdKcGowcElnd2VZYkplUXdK?=
 =?utf-8?B?Wm5QaGF6MWRFaFl5V2JKU3lBZUpVRXo1dmY5LzdJRmtVcm5FOGt4eWVCdEw1?=
 =?utf-8?B?SUFEZS9LNWZvZ05UUGd5dkdFM0RoaEl4NnNUV2JDQVZoUUFZclVyOFRhdm9n?=
 =?utf-8?B?VUg3Z0h1VzlYQlY4MXp5ZmtrVzhpNjgyMUZ5aS95UHZZZER0cFpOdi81L2V0?=
 =?utf-8?B?R3lYRDNwUG9tTmpEd3RYN3BhajRuMmlieSt5aEJZRjJYd1lTL3F6S01qZ01P?=
 =?utf-8?B?ZlI5SFhzaTM5WC9kSENhdTRGKzJsS20rOVJQZEN5RGxBUXB0THYxNlkrZjg1?=
 =?utf-8?B?WjF1dnNIcys3eG0xbVJRdEJkR0gwMGg0cUNZd1I1WDFLMWxuTjN6TmlhdUxx?=
 =?utf-8?B?RWNWZTBheHdMN2ZuSEhoWmJkTW9LZ0IyM1gzdEtiYWQ5dGw0WkdqYlZQN203?=
 =?utf-8?B?UDFaV3hKVEZWbmhraUNLN3BqM1lsbzAyTDhucC8rNEo1KyswQmQreVhPcldB?=
 =?utf-8?Q?oYmv7CXWf6VHJmxIN5+HpPg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Rlq+DgmeMwrw8IVQ9KqoUSvXQeE3tI5vcJFGb/y0OWGXBDLQhKAZ3qHvzxgmy3lny88hSbLuqrpfRJNxQ6HtD/WmJrqoCPtUBO9MR/mx7HHU3J5TX3aDa5dcIK+IYa7BnqPEcC8MALqcZOFlYkSv/dedmjuaWhi3i/MgFsJ1qQF6DFcV8Q4+mhAZwTyemhjRS9IgJuqFRleVaExaQjBRFZSvuFQqzqw2fpoUZ5VGz1lPugaQC+od0g67oq0EpO27OvEHCBEB24JDRhz5eFhctnTGGwWQDe+5ObR/YZaE3KqXs5XXkmAznlcDY2sJmx2KlCyRTiJq03/ypGRK+2WnyaHjMRAy7r3Ovc3XXVHxNPT2vzkUE4gMSFrRPh5Jbo8kE2TW3DKouuZNzNMRZ1f3y+WPf6Hz9+rZVbvi3QXIye5QOQf6W9q2zoXzcv6dGhWcnKb+hzOT9VkogyxS9nV651igY2PiNoilOo9+zSbgJmE+Fc/dQ0WE+F8HXuvS8530+wMl7QvdX1xOiGbRtgnZtm0HrXZWoaHtNc1QlwltY8UQeeLP2ydfssiqBPDcum9ehGKOhwat0HHzq378iPqK2h46I52HxdAfHr4hT4ctA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072ff374-43ad-4289-73e4-08de0b68a9d9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:28:48.8530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO1LYLAxNfbc1mKplTYORA5+ZUemiNDHJ0KSxX44LvI4xa6M63n4QotF1NovE1sfdqluoc2FqPPdM+J8wlMJUXv9jOtTZBo2O2tSh4Xacys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX/P5g3HhhUAWg
 JdfBoXziAuRJxQs5L89/NgsmoEkyWlPmgPy2bJjuVEVb76g7C7STj2GBNmbI6jL+faVdDf8YBr7
 HatiIUw0adGie2CneCr/NBPE0oK1oXONBTjGk3lEdbqOhWDQEEEW84AHVIQhd4xorKkAD8GNbgX
 +OO0MuEbHLXsiMO9Kc+iHXjCMBGKXZsYSDQTTY+Qe0qYOOslct3cPJn4higa/8rLDeHNRaxL3o+
 3BJWYldH+3u6bvlEdYQaDu2Nhd9QZN4cm/KvotIjY7zjxxfX2zfhmvCfGGiX5YLq0sa6vvsUB5V
 wOEP5AWmWQsNkwt6ewcQWkwWb1rAm9R0YbS7Obtv0YZPDoT51YlCIkk+JoWdK+1P1daLavJS/NG
 baEnWTLttvQkPqGqvRLy1nH1Lc2Qhg==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68eec094 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=B_MNZs3Y9oQAeh4xAzAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: boVG-SKZrmmGidOW0pocuVGbd9Wl__lr
X-Proofpoint-GUID: boVG-SKZrmmGidOW0pocuVGbd9Wl__lr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/13/25 1:00 AM, Sairaj Kodilkar wrote:
> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
> to read or write from a given DMA address, IOMMU translates the address
> using page table assigned to that device. Since IOMMU uses per device page
> tables, the emulated IOMMU should use the cache tag of 68 bits
> (64 bit address - 12 bit page alignment + 16 bit device ID).
> 
> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> to 60 bits. This causes failure while setting up the device when guest is
> booted with "iommu.forcedac=1".
> 
> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
> the device ID to construct the 64 bit hash key in order avoid the
> truncation as much as possible (reducing hash collisions).
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
>   hw/i386/amd_iommu.h |  4 ++--
>   2 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index b194e3294dd7..a218d147e53d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
>       uint8_t devfn;
>   } amdvi_as_key;
>   
> +typedef struct amdvi_iotlb_key {
> +    uint64_t gfn;
> +    uint16_t devid;
> +} amdvi_iotlb_key;
> +
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
>                PCI_STATUS_SIG_TARGET_ABORT);
>   }
>   
> -static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
> -{
> -    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
> -}
> -
> -static guint amdvi_uint64_hash(gconstpointer v)
> -{
> -    return (guint)*(const uint64_t *)v;
> -}
> -
>   static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>   {
>       const struct amdvi_as_key *key1 = v1;
> @@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
>                                amdvi_find_as_by_devid, &devid);
>   }
>   
> +static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const amdvi_iotlb_key *key1 = v1;
> +    const amdvi_iotlb_key *key2 = v2;
> +
> +    return key1->devid == key2->devid && key1->gfn == key2->gfn;
> +}
> +
> +static guint amdvi_iotlb_hash(gconstpointer v)
> +{
> +    const amdvi_iotlb_key *key = v;
> +    /* Use GPA and DEVID to find the bucket */
> +    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
> +                   (key->devid & ~AMDVI_PAGE_MASK_4K));
> +}
> +
> +
>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                              uint64_t devid)
>   {
> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +    amdvi_iotlb_key key = {
> +        .gfn = AMDVI_GET_IOTLB_GFN(addr)

Missing a comma at the end of the line above so the definition is 
invalid and fails the build.

> +        .devid = devid,
> +    };
>       return g_hash_table_lookup(s->iotlb, &key);
>   }
>   
> @@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
>   static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
>                                       uint64_t devid)
>   {
> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +    amdvi_iotlb_key key = {
> +        .gfn = AMDVI_GET_IOTLB_GFN(addr)

Same issue here with missing comma after initializer.

Thank you,
Alejandro

> +        .devid = devid,
> +    };
>       g_hash_table_remove(s->iotlb, &key);
>   }
>   
> @@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>       /* don't cache erroneous translations */
>       if (to_cache.perm != IOMMU_NONE) {
>           AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
> -        uint64_t *key = g_new(uint64_t, 1);
> -        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
> +        amdvi_iotlb_key *key = g_new(amdvi_iotlb_key, 1);
> +
> +        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
> +        key->devid = devid;
>   
>           trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>                   PCI_FUNC(devid), gpa, to_cache.translated_addr);
> @@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>           entry->perms = to_cache.perm;
>           entry->translated_addr = to_cache.translated_addr;
>           entry->page_mask = to_cache.addr_mask;
> -        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +        entry->devid = devid;
> +
>           g_hash_table_replace(s->iotlb, key, entry);
>       }
>   }
> @@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> -                                     amdvi_uint64_equal, g_free, g_free);
> +    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
> +                                     amdvi_iotlb_equal, g_free, g_free);
>   
>       s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
>                                        amdvi_as_equal, g_free, g_free);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 38471b95d153..302ccca5121f 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -220,8 +220,8 @@
>   #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
>   
>   /* IOTLB */
> -#define AMDVI_IOTLB_MAX_SIZE 1024
> -#define AMDVI_DEVID_SHIFT    36
> +#define AMDVI_IOTLB_MAX_SIZE        1024
> +#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
>   
>   /* default extended feature */
>   #define AMDVI_DEFAULT_EXT_FEATURES \



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB1ACAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28SK-0000Vr-0U; Fri, 26 Sep 2025 09:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28S9-0000Us-GW
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:25:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28Rx-0005NG-3d
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:25:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDMJQt029017;
 Fri, 26 Sep 2025 13:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=dEkn+452UqOUYPCUF9pTrulbjzJKjoYGPUstMF1Leh4=; b=
 AS486XIUiCnzPzUz0bjZvFrTRIjmQXocR0vU4iPYFYUaI7D3tosdg1sRLX8ysRAE
 kGp9DM8u0RxNxsnvBpjfEOjfLXANzNkeuagZWgRWgLjdqjH54fzwXEEFZEoNxfHc
 PTdsNCYnh+/PjOVYyH9kOXWYguzUivAk0y70TcWVt/TJMNwkntZ8EpSTjOtSUC2E
 Vc9HoPhiPefmah4FwynPnLUVS+0JpmDQrNUo4szzs1PMAoGwwK/h3un+sPB0uRAa
 874G3yUQBSRspfDOLCGKlxWwAGYKOiGPh7IKx+MNKX+gRBVTSetS4LmvXzZ1IB0v
 IFAhqgbFiAGc52XKMdBJJQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dum30090-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:25:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58QCDa1k020962; Fri, 26 Sep 2025 13:25:15 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49dd82jmgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/vk9Zaj67lbL+qGe/08Lsbn1oRcDHtH9XflpyXqdOv3CZvY7WRISFYxxuCcrWiKZ/IUk0OFaiBpTab7bxbGq6fIAie6EssTbhZ0fJ4T6INTtLB644TR7qXDJhYfvqY1eCHGPrOvKjSHREXCaufQ6TpmR0twXYjNbpFBsCuqWhxCHLCb5KDnRe1787/fBQwuv+XR6meVyDlLQu2LuVtvemOiawqPh1N7KsIduyoz0f2tAcadBvx9A3oqzR/4ojqUvpFuMjE5/1v9obU62D20jPO73UBrFcpBZmM6us99h3SChkH15HfSwdudY628GxcJZMVHFpGImM+jBshvNwam9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEkn+452UqOUYPCUF9pTrulbjzJKjoYGPUstMF1Leh4=;
 b=KdGNlsmfF1snxm91ZcWw6BCK9KoDTafP0XpycO7hvL3HBy0Vf6Erk+i7fKagwTTJ1RN8FvSPjFksezfqsmZRzn9LtyPGkQEduAJkamZIhFIH/iGBQNS4W70Bt0Oir8exCc1er+PPTvIFMJFPt+TCFC5fNJujaYNU/HATigEgmeFpZHuXp7u1UjzXyRPGayJ1CluRP6w35VP+14TlG4GOFivVyGcUxpeV2vNrpoZrDL453+6lcHZnbuxtXOwT8huxT0pHWb/mmdec7pKPwzHKzJyd6wJ51LFDkI55YgAB6/o3JbXp9ZNF5gdkRoByDI+u+mKXhHOmuAVEKg0URs5N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEkn+452UqOUYPCUF9pTrulbjzJKjoYGPUstMF1Leh4=;
 b=r83raaOFuCF4qlSf+YrAHOVvMQ4FnE5NE1WDB6lQTHU3uhwaOWmdBxR/KjjOeSLqik6Gxky2J2Hj43hiAQAWF6LMZ+EkZ/sv0wB2wYvJZwQI2jMG66dM57pB5/+NE3DuyRwaaMJLfiNziAU3CQVm1N00ESefGU8gLOncgOOAKaE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 13:25:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 13:25:12 +0000
Message-ID: <65eeef53-6be7-44bc-96f3-0e400c9fc302@oracle.com>
Date: Fri, 26 Sep 2025 09:25:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/container: Remap only populated parts in a
 section
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 David Hildenbrand <david@redhat.com>
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
 <20250926022348.1883776-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250926022348.1883776-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: d2734a66-efba-4868-ad9b-08ddfd001f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGloUzlSRzRjbHUzNXZvR3F5SEVPcVdCKzc3NUZqR0FGZmFlMDlKcDJ2NGta?=
 =?utf-8?B?MWhyK2diTzJ3RUZGai9WN0VMbVhySmJENnMwY1htMGw3RTZmSmw0SFNlRHRU?=
 =?utf-8?B?dWdwR3VPaDZpT2d5bUt1eFo2UVdaN1RCZjhGcWkxRG90TkJhWmRHT083RGRX?=
 =?utf-8?B?c3lYUG9kbzYxUnd2YXFBTkw0ZUgxWkVwcjFRQUxSRUs3dzU5KzBmd1Y2SnYv?=
 =?utf-8?B?b2xjSG8xUldJRlpaeWFPVUl0RzNjczU1ME01REJ6NUxIL0Y3ZnlTN2hQamFK?=
 =?utf-8?B?UWtzQzVEQzk0ZHE0NW5zWGpUaVFDSG05TUNOaUZsWHBJeGpoMVVJZzMyK3ZO?=
 =?utf-8?B?aE14TDBKcjJYL21haEJHaEJ3enhLOHNVUnErNGErYWVyRUQ3bmtpdTJEd25Q?=
 =?utf-8?B?MFdlQXNzOFlzak5wOWJZVHJ6K1BIcnAwdDR0N2xxVVlmZkYwTENZTEYvd1VZ?=
 =?utf-8?B?SmVMZEJ0bG1VOU0xTUcrRnJJdnZNTE45c2FqcGtpeVJkUmtWaFJPcS9jY1N4?=
 =?utf-8?B?L1llWFZqUFlHT3N2VHQ3WlN0UWZpZmgydkUyYnNWcHpvNW5OWmdEV0h6a0NQ?=
 =?utf-8?B?c2k1ZGc4bkIzMXhzMnFseFR1Wm5pT3ZmMkE3aWtTT3Fja2hwclZrcVZTWk5B?=
 =?utf-8?B?aDl4ZEUwYndKNzBmbkk4TWVCR2kyZUdHQWxqK29rM0IwR3lBNHRka0o2dHor?=
 =?utf-8?B?S0xHVmR4TlZzdmxqNzVRdDRKdGpCaXFOOUlHdW9MQTdNNVNjekVGMnJaRFpX?=
 =?utf-8?B?Sm9NZFFYcEg3TG10enNDRHE3QmcyRE5HWFJUMmM2aG9aKzJVRHJRQWRuc2I1?=
 =?utf-8?B?NVlWMzljNkQwaG85bmovMmRMTnJ3TWlWSFIxV2QyaUVhb3p5eVJXNFdlYUU3?=
 =?utf-8?B?VFNOQ3dvYzZ3WTJuRlJ3cld1MHpmL2dxalBpQUdESzJDTW1kV1ZwTWM5TGJT?=
 =?utf-8?B?YzdpVDZnVWhUNjdJcnp3U01FNHVNVU8xaDBPcmhRQ3NNVXZEeWhVOHZUb2V0?=
 =?utf-8?B?RlFzWFFBQUNJN3JCZ2hvY1hXZFg5ZkUzK1grREJxT01NLzBOQTgyVHB4OVA3?=
 =?utf-8?B?VEx2SHUxRUpESFA4QWNGbXpTeHl3V1pjekNmM3ZZcDVpTW9jRHk1L09KVFUv?=
 =?utf-8?B?YS9WbnJKVmxVMFhSYnRPcjBYWDUwZmgvdUZrQUJFU2kxVUxjWG9naVVGNGR6?=
 =?utf-8?B?MmtXZ1ArakJSYVMrWUZVSXp6NnZGK1dvYVVXTUdqMmhVdkZvMGZ4Z09zbGZT?=
 =?utf-8?B?UUVaSXFlWWZZdFo1RkRiZ1NzbEFmU0hrN08zZjlQeDBsWGdkOXhzUlNUOG9P?=
 =?utf-8?B?c1hEbFBGMzI1b1lEeG92T1dQMzhEa1IvemVNZUJZK1BBOGlHZzZjRm5FZmQ1?=
 =?utf-8?B?d0JraW9EQXhHNlhCN0RMVzRTMG15c0pzUjAxcGNyQ2FRQ0F0T3BXdndtV3lq?=
 =?utf-8?B?ajlKbS9SMTZ6NEExNmFYUUk3NnlQSThmQ3VCRHRURktNOElsSkR1V2N0ZzNh?=
 =?utf-8?B?R2wwdHZQZXNwMGRoWGZKd2ROUjFDV2xIVGJpejlXK2pEQmpTVi9MVWJYM0RD?=
 =?utf-8?B?dVB0OEQrM1NMVWVlTjh1VDNDZ3lReXlGL3Nnemp6Ykxhc3l4T0RHanBMemJW?=
 =?utf-8?B?UFJpckJSMU1FQlZqblhvSE9Zb2pXNTJ2TDF5Qk9UckF6TjNMcVZrMEJ6QTA1?=
 =?utf-8?B?NW4xRXNYMmdTN3FFbG5ydThVbE9iQlZHWFFuNFpVSVd2Y2tnZXN4L2dZK3FQ?=
 =?utf-8?B?ZHFsUVAvUmNYd3oyYjc5RExlVmpBMm5XL1hwUzM1ejhGMC93ZjhxNTJMK0M1?=
 =?utf-8?B?YS9oMkhDZi9QYWNKK25jOTdRYzBDSGJVSWw0dGVTWGVEaDJVb2dtZnY4c3F2?=
 =?utf-8?B?UE1Pdm9kQXZFajh2MmxMQmZ2OEJvOEd3K3ZnbHZnRkxJTFZrUXprUk1KcEtQ?=
 =?utf-8?Q?BYy72FIt9Bk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZmVThWZ1NjUTVBK25ZUnZBVUowU0Q4V3FEbmxRd3lPckx4QVJtUTlJRVJh?=
 =?utf-8?B?OUk1YytXdUN5eVNTQkxqNEtqMHIxaDBIOFRZNE1FR0sxNzhsbCt1L2MwQmE0?=
 =?utf-8?B?ckxIM2g2N2FQZ0c0VDZuYkNQOGdqNG4rQ1RmM3RNakJRT1dxcXZRZXh2NGNI?=
 =?utf-8?B?STgzUE9oZm02Z3ZZbDNyaHVDTzNEalpqTzRUNWkySzVoNjZ4MndySjM0eHhN?=
 =?utf-8?B?a0pINkx1S2cxMGNRbW94UWJkN2NpVWdnaDZTUi9QSGUrVEVhNUhPUGFVaVE2?=
 =?utf-8?B?aE5ZVUNpMVhGb2JUZG9FT2lhV09UeVVCMzRKTUN2SFZsSithWElWQlJ3ejkv?=
 =?utf-8?B?cHJrdUtiSWNMdzViOE00R3MxQjJkLzk0VEJvVkhScXlMc2JvajlEaGZ1UjF5?=
 =?utf-8?B?TDhZUmU4bkY5NE41THZKRWdNT29IMTBtTW5Yd1VIclBUaE9vbmJKcDN6YVBC?=
 =?utf-8?B?ZWxkTDdzSXdKUE80cXpsM0hXT1RIVXYycHNiUGdEN3M1OUdUYnNEYWVYU2d6?=
 =?utf-8?B?TDA1OFFFc2NBdUJ3VnlVaTlzNmVIeEpTRzg2aTlxa1FneHlRWHNHZFJ5b0ww?=
 =?utf-8?B?N2k1NnJjN2dSOVI1bHgrMzdxd20vNXpwemdrcFhIenlwTGlUOFpVMTlWNjNx?=
 =?utf-8?B?R2JtZUdIMy82Y09NTU5heEpObmlYN24wRkNqaDJmbmEvcjFaK1FBU1V5QnJ0?=
 =?utf-8?B?SVV6RzR6ZGszdTQyR01yLytqeU5iVXV3a2twbEVYM3ZjOVFrYUh4b1JZUCtl?=
 =?utf-8?B?a2YzN1dTbVpPNjl4TDR1WndoeFdvTXVLMWpURUpTbzJiR0dDRGg1aGdpWG5a?=
 =?utf-8?B?N3dOZkMyak5MbUNZaWZ6R0J5NkJkVVBCV1B5c1B1RXRDVnpCOUhvVXBsaVJs?=
 =?utf-8?B?Q3BIZWw4aS91N1pHZjhaa2RSN0lvY2xmYmtFMHFUMjlxTDl6NHczaWlhMFFC?=
 =?utf-8?B?dExSV1JiZ2hvUVlncUFPTkxVK0xuLzFpMnd4alA3WFEzWHUwRUtNTVlxYnBZ?=
 =?utf-8?B?QlBmanJMSy82NWZIcnk0V01rc1I2SEdyQ1o4TzNRS25jWTQ3OFY1WTRsZHlG?=
 =?utf-8?B?cmtqeVFzdUc1cjd5RzczajVkRkI2UVpEQ3lwUm9IaTNCK0k1bjRrenNnRVVi?=
 =?utf-8?B?MjBWK3NRd0JkNjRYVEh4dFBmcXNYdnlXNjFjS21Md0dYdWFhbHd5V0JkbGhx?=
 =?utf-8?B?Z2tQL1FXZS9OcmRncmtvbWxkazBxYlJUM0w0K3p2M3h6b2ZQS0JmRHdIcXZx?=
 =?utf-8?B?SHVocGdBMEZmQ1NRSVJxaEYvbC9ndkNEOXM5bEI4ZUdTQmpMS1pzR2xCcXhw?=
 =?utf-8?B?aGJScm5QcUtud2U0cHQ3SXRGbWk0YXc5R1h1eXFmTUhoSU16UkNhSVV6dXJZ?=
 =?utf-8?B?TVpabWlQSmJySFZwelhiMmlqMjlYbUJaLzA1RFYyL09rVUQ3bVlQcjRXa1RO?=
 =?utf-8?B?SzBzU1lIK3R6VW5EbktNT2tPb2xrSDFTUDFqT3UzQnZHcURabEtreUI0emZ5?=
 =?utf-8?B?LzdhYTUxbllHOXRFanVIcnoxYU5tS0Vlby82b1NyRWVRbHQrWlpRL0tVKzlB?=
 =?utf-8?B?ZUE1c21TaGxFZlNOdFcxek5NRy9HREN1OWdhcmFjQ1ZGUG9EbU16UUIyWXhG?=
 =?utf-8?B?b2M2ZlViSE8vVTQ1NUx0VytacG5lSTlUQm85ZEU2bUpXN1pMZ1RVUWNaS3p3?=
 =?utf-8?B?L0dpaUZRcG9BYmhCQjJHU3d4Qjl6U0h6TU43MGRVSkJiZThXQnI4ZUNXMnJ2?=
 =?utf-8?B?U2pyY3FVQlloYkRPMkVaN0VQQ1pUU212SXo1V1JhcTNtaWVjbGJhRTJyYWZp?=
 =?utf-8?B?ZnU2WnpyMURyUmNldTFuejZxNTNHRlJPM2pJVVRZS2NsRy95a0VFZXdIQTFZ?=
 =?utf-8?B?MEc5N2VHSDJMeDFycVZmbkQ3N1BQVEdEYm84WHFwTk92MnZydHJ0aE1VbXNi?=
 =?utf-8?B?ci9RYm9sM3FVSWtHb2xmLzNiR3o0dnF6RDJUSUhOZUVQbzB3Qko3R1p6Sndn?=
 =?utf-8?B?V3NEekFsdTFxa04wOFRuanVWSVFMc0I1SkpPTzc3RzdDSWluRENEMTZXNUtK?=
 =?utf-8?B?cU5XSHloaXF5amx4UzZqM3lzeXNDQzBvV0tBUHhEdzF6TjdMbjdzZUw1Q2hQ?=
 =?utf-8?B?Y3BKK2xMTmNUdWRYempvVnJzOUkzMFVpN2RsTm5VTlQ3eW5NTG1VVy9Cd3dJ?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GpJPC33ZvXxjaYQMZD5kx+q+SVYDvvADT5uWUmLvEORSTVvx3aGT9xo1Q8APoGBB6jIdNmRiE4gQ3a97HaeWA+YkaR1BfSIPmxr93vRFO1gRWndSYHbQru8JoQXbkUy7o7TC1KByY+m9Lbw7p4pUADhoyvHLYVIRGToQ3L+X3kcmGb8nImbnFZZrAamnjLue66d8HnMtXQ7xu3bNwCu0TN75VcSVnfxzM9cbH+XCUU4XVDd5IAz+arwhM7mNo8BX1779qoqBmCpqxO9daYjx7ZD+/Wgshv68Z0TsEg/Iik1Cq4j6mgnNGLA7PPXUUDpS57EdOJy2/JwJie/PstBMstupORYyg2GztGhdPyQWjbliwzub3dCs86YV/DdnhUk7rCubD8iClWteD1xaNXrJ8wlvWGKPx7D0g68o4063IMe4xGNjs1ENcqNA9E9Y1sOqO9DZJ0YsV/HVG0p6NR+M8UDVW9tA9feJlz6KWPJtABT5i9nNxhh751hlSFAt/QdCGEKsdw3o6/d7f/EtTXT4ptL9s2qoLigmUiukhie+XD2e0oYnOpjO77vVu5S0Vq0vFsD3Ev6vRHOix/lZKT6PQtV3RO+1r4fY+/DYEZdpmWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2734a66-efba-4868-ad9b-08ddfd001f21
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:25:12.3463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlq3JLUlnlHxfGVAAseqU/Ia7iF9VuxK0BeIxjYmGEuY9twmXQEMUTiGQo7okb3jLBpAVW2J8zNgKhYJEGXiXU7KtOUpjhqYgEYt/N87tBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509260123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyMiBTYWx0ZWRfXxYqAdRww75cC
 gcr5Z7RMkYeEJsc38c0+TuDC+iheanw/kUG/rUQbpCYHvmuShnd7mqEV76iFLWJE7v5A2zIT0AX
 pl+gRCu2TmGMH3r4YFo7Shr86TpVG6gFRmdpZvDvj1sFFr/JoJJuopwkoNMSwieLsuF6YiYpP/x
 lNsx3A/c3UhQvphCxKYSiilr/q9l8zfpE16CWcxYpXIL7MKj0X1m78v3OC9+36inYQ1Uiug0tXH
 V4KZ2gSGaAbH/nQEKlXFT7LlT559lQ1/Dmdgr/QjQZrHurJABAW9Vi7PAxSy7PyXoET/x8eA+gD
 +32pCo6yFURos9eemtWIbckGUVJFH1gFzcQJbEvdv6ApcQl9iKP83cOHGPRgjQT1l/rhbCkh3sp
 Q8tADUDRpu8hfiyPN8wmfnQK6r8n/Q==
X-Authority-Analysis: v=2.4 cv=RLa+3oi+ c=1 sm=1 tr=0 ts=68d6943c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=VhSL8DeNdC7-9hnXtB0A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: wpb0CLtMQnmr9PFuSGIBnxzpljCEc_PI
X-Proofpoint-GUID: wpb0CLtMQnmr9PFuSGIBnxzpljCEc_PI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/2025 10:23 PM, Zhenzhong Duan wrote:
> If there are multiple containers and unmap-all fails for some of them, we
> need to remap vaddr for the other containers for which unmap-all succeeded.
> When ram discard is enabled, we should only remap populated parts in a
> section instead of the whole section.
> 
> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

This is a nice simplification of the previous fix - steve

> ---
>   include/hw/vfio/vfio-cpr.h |  2 +-
>   hw/vfio/cpr-legacy.c       | 20 +++++++++++++++-----
>   hw/vfio/listener.c         |  4 ++--
>   3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index d37daffbc5..fb32a5f873 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -67,7 +67,7 @@ bool vfio_cpr_container_match(struct VFIOContainer *container,
>   void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>                              MemoryRegionSection *section);
>   
> -bool vfio_cpr_ram_discard_register_listener(
> +bool vfio_cpr_ram_discard_replay_populated(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
>   void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 8f437194fa..3ea24d60de 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -224,22 +224,32 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
>       memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>   }
>   
> +static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
> +{
> +    RamDiscardListener *rdl = opaque;
> +
> +    return rdl->notify_populate(rdl, section);
> +}
> +
>   /*
>    * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
>    * succeeding for others, so the latter have lost their vaddr.  Call this
> - * to restore vaddr for a section with a RamDiscardManager.
> + * to restore vaddr for populated parts in a section with a RamDiscardManager.
>    *
> - * The ram discard listener already exists.  Call its populate function
> + * The ram discard listener already exists.  Call its replay_populated function
>    * directly, which calls vfio_legacy_cpr_dma_map.
>    */
> -bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
> -                                            MemoryRegionSection *section)
> +bool vfio_cpr_ram_discard_replay_populated(VFIOContainerBase *bcontainer,
> +                                           MemoryRegionSection *section)
>   {
> +    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       VFIORamDiscardListener *vrdl =
>           vfio_find_ram_discard_listener(bcontainer, section);
>   
>       g_assert(vrdl);
> -    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
> +    return ram_discard_manager_replay_populated(rdm, section,
> +                                                vfio_cpr_rdm_remap,
> +                                                &vrdl->listener) == 0;
>   }
>   
>   int vfio_cpr_group_get_device_fd(int d, const char *name)
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index e093833165..799552781f 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -577,8 +577,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>               if (!vfio_ram_discard_register_listener(bcontainer, section, &err)) {
>                   goto fail;
>               }
> -        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
> -                                                           section)) {
> +        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
> +                                                          section)) {
>               error_setg(&err,
>                          "vfio_cpr_ram_discard_register_listener for %s failed",
>                          memory_region_name(section->mr));



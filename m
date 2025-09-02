Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC3BCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnX-0000vp-F6; Tue, 02 Sep 2025 09:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1utQn5-0000Yl-H4
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1utQn0-0004RT-40
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ctu8M020912;
 Tue, 2 Sep 2025 13:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=89zp3olY5bYVYICfAWhLG/ItTUBLjvW1jfXzA4ysRb0=; b=
 DxplGL0uT5lKr5YEVVoObRbtInoPsV3dPxr1BK6kBHCFJoqWGVQEcAUgQFZbjmDS
 DtZSiNZiAyW3dLLZPbdSUOpUTbU6cG3R7EsdC5LO0xN32FqyQGUog5lbzw1GfskL
 pJKA+hNyvApw3edT/fzgy4WkV/l7LcISDkJevgzQJtwMpJGWXmR3OIxLmQV3yCfT
 XicrbwVh2jcDyzpj/HVqRaQ+aZeSQVBPyyvkvTb6mhRrhCfEoAu9hnLwNXiIAauD
 Wty58SBXM4Cu79GhiTM7fa3zIJSHjvneVp9v35CfqIoWyhYtwqLB1w7Jy9K/snMk
 UA9Afc4arGWz8Dya3KpBnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnc12p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Sep 2025 13:10:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 582BqD4U030968; Tue, 2 Sep 2025 13:10:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48uqr95h75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Sep 2025 13:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKh45fu/1MBWykvm6DrW0gaA4PUblKRveAKPVa7yzP43Gx8Ij6j7l3w8q07W3iWzOipTiQSk0b6TMoHb1w2kxH4iW+whOHQ10AFlmrWFQIWRRAiubRyEIR29jIK8eBGxVUmJTf9NQbIDcu6ryIMmvqx7/PI8rGUpvc7QLz3zBypPnX6/0mG6QOw9JEyShYaZ2A58nXcUJEmtw2j61Mqsbg+Tt445tOcWypN+ciHtvpORuj6J//vS8KRdFpy1lLr4iHPMHOUib1qKTIs/3Ll7Zp7af/PsDS8RmwCAHBN+ThLh1JeGdbgwe8PuoVE8/VeTNs9n48fCegBb9LRy72aZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89zp3olY5bYVYICfAWhLG/ItTUBLjvW1jfXzA4ysRb0=;
 b=q9LRAqq2nd0bcq8/Oz7aji0C1DSzAQeVlogBik5roDCz3egri/LO0tezNAjijudDukvheRZkQ/h3o3/ROVCiLqfY1zjcE/wHMBNdYtrqkGWvurQiNDt4xdEJXMSZVZAZvuS8W2s6prwgJcu9eKxg6xzesW+WJqk+hbF1zpug1XXyVB68XNvNv8G+cYEsaIQOLWBEctTGYHKydjdsR9/qkjmO6SDCRk2uwoOjlZplzSBGSvIAVJRGqK5BA7VA9h/Q/4Tcca7PnYMwzA81GhVK/pYi5EM1/TkY68Rjbe6hAS64dpAoVXQwSF8HArBPYce85kZf6xNM+QaflVAYf6nzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89zp3olY5bYVYICfAWhLG/ItTUBLjvW1jfXzA4ysRb0=;
 b=zsOkLWskx+4ncRSp3B1mMNtjH/J0LfCleal9/MuJY6J4AqXao1j/CFQ/dFVZ0fKQ9A1SadiDqC6cZ9yQQgL3bqThKDXEUxNon0jjqx4PX8rX4FeTeUXlEWqUa1pLTidK4gdKQIe7UFY1Kn9FHEthwOulWHG6QyOHOe0VzKFvl3w=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DS4PPF1F77AB10F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 13:10:44 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:10:44 +0000
Message-ID: <0026017b-770e-467b-ab7d-98cac1c70463@oracle.com>
Date: Tue, 2 Sep 2025 09:10:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Remap only populated parts in a section
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
 <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DS4PPF1F77AB10F:EE_
X-MS-Office365-Filtering-Correlation-Id: b65030b4-683f-4f24-0404-08ddea221fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0E1bkR0RWE2eVZMRzRRZzBLaGltd2RXS2ZlQkFYVFlRaVhBYTVEbTB0VkZw?=
 =?utf-8?B?NVpVY2tvZXZrVkRBeVpoNjNjbms1YWZmR1hjc2RCemVMc3pRTWxVQ09SQ0ho?=
 =?utf-8?B?ZzdwTFRQNUR5ZVcwZFR3Mkk1UFduTTJxbHJkUkhnK3J2QUdxUnlLRUMwNVNJ?=
 =?utf-8?B?VHI2RGpTNUtjZWR5SnM2dGh5UHVzUE5vQ2VMU3hmOXpQUkhyaG5tV094MmFP?=
 =?utf-8?B?aTAwYXJYNysrVCtHc2FURStKSEduM2h0S3hhbnBEZVVVUnBvU1IxQVJvSFd2?=
 =?utf-8?B?QjVhcmNQTWMyUG16ak9zMllGMnFnSUpraXA5Sng2bFlIaWpOYnBaU2NMdlR3?=
 =?utf-8?B?L1ZkUUZaQmdlRjJ6MGl3YmFKaW1JbWRCeUtQM0pXV29iWjFXcXlmSDkwR0cz?=
 =?utf-8?B?dWJNSWpmbjVSeHlVU0NFSWpzdzFtSmR4K3UzNGJRMTEwWG1XUmhNWkl2K21z?=
 =?utf-8?B?ZjFXSkp5REU3Y05Bb3E5d2pocStybmt6NnpaZmduMUlxRmd4Um1BaDdISDRv?=
 =?utf-8?B?YW16YzBTMnFtMWFPaHo3by9PTUkzTytiaFZUMDcvMUZiaVk0MlBUMGFzRmNh?=
 =?utf-8?B?K0NoU2tSOENQT2hsRUMrSmR2T1ZjRU9icWFFbW9LTDd4MFJvV3Nua3hqT1R5?=
 =?utf-8?B?b1hXRVRicDVXd2J2a3llOUdlUDU5aUwwd0lMMnAyQ2R0RklRSkkxR01IV0k2?=
 =?utf-8?B?TTU4UDVsV2xxbGEyb1JiZ2lOVFhpbU4zeTZGVmt4aGdiSnIxUWUyMlVYTE5s?=
 =?utf-8?B?aUQrRmhuZXRZY0MrWGRIM2h3c0JFYnYyVHBMLzZJLzEvaEtzTjlDaStoSjhk?=
 =?utf-8?B?Wit4Tll3NmV5VTk4MXhHbWdIQ0Fzc05MYTV5ZTY0TnpkUi9yM2lXT0FKM1Iz?=
 =?utf-8?B?SmlENWhEQmtMSWYzTVVwZDFBdnlkQUVSK25YUExLaGhYSXBYd1pvWHhXSHpp?=
 =?utf-8?B?cGFlcHRWRjdjK1IvWWVVSlUrcTgzTmlUT2xhSWFXYzJiZGFuL2NHN1ZyVmwr?=
 =?utf-8?B?K2kyeDhDOFFQTjdJeldRR1paRUNXRDQ5Q21WUnpONVpTVXRadytaczd4azRM?=
 =?utf-8?B?RTJIaEZMRW5aWERoZnhjek1uQjl3SlFubWgva2Rjc2JrZ3hySkRxcVBLMEhX?=
 =?utf-8?B?RCtoekJBZ0JNV3lnSGtKampHbnhucmwvbjljM0tDcUpnSm1zaHdWUko2a0Uz?=
 =?utf-8?B?akJjc1dPemE2cW1HVjBnak85SXRYOGphVGUrN3FPZTg3Y1VIMmQ2MlJWY1Mv?=
 =?utf-8?B?ZisvdXI4a2Jad28yQzdzRVYvQU9VMXZHRmVOS29LWlg5RWl4YmNqUmVuNWda?=
 =?utf-8?B?VkZjcWVvVHBRdzNFTkJnWHlhSmtWa0s0K0ZYb2x4Mk4xTTRiUytZRUpIaTlq?=
 =?utf-8?B?QmpTdUdPcENoT0N2L2YySkFaVFFkb1Z6M09nczVDcGloWXlsUnpWWGV4RHVp?=
 =?utf-8?B?K1k5TnFYMENacEZOVXNGbm5aNUYvSW9yYmFxdlA3b29GV2l3OHZ4RE43Z2tj?=
 =?utf-8?B?MFhyQnV3b3BkOVNjZUQzYUQyLzMvam95L1o1T2w3MDZpZ0xnYXo3TGMwL2I1?=
 =?utf-8?B?LzN6T08wckhsdGZ5eU5NSXZ0N01HSVR5OVN2RW9saWxvL3U2cEh2ZlBkY09K?=
 =?utf-8?B?V1lnTEtiamluZ1FJdkgzN3FvY1RZd3NNUTE1RGJZUzc3OU9NUlhITkhOcXhU?=
 =?utf-8?B?ckE0Tjg0YkdjaGY1b2FxRTZWbHM1dXdTbllXSGxEcnBaN0xoSEU5RDVKK1BK?=
 =?utf-8?B?Z0loNjN4MjYrQnhldVpLbFJXdERsaHJ1U3Q1NVNJVU41ZmJ5UjVLOEtsMHVP?=
 =?utf-8?B?M3ZyQW85OVB5a2FXMEZlVXREZ2U3eXR3WlJhNmd1M1BXT2h0ZG5kK21sSkxD?=
 =?utf-8?B?dkNFajdnM1pKY2JjcWgyWDYybVNHd09xekNFbFF2WDNsanc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFXMWs3S2U4RzdhTW9jMUxqcEZCZXY5V0lIRlI2Sk1sejl0bTd4QWtjc25U?=
 =?utf-8?B?VGVHU1pNUThxYnQ5S2VvaHp2ZmM5VEZKamJUcHRQRVBhNHJMbHBlQ09HNXEr?=
 =?utf-8?B?bnBHbHNhcnZlRVJFTGc0c1BwZHdMRlFTSk55b096Q2ozSnNTNjZwVU5pOGtW?=
 =?utf-8?B?d0FGWk1WWnZGVGNkaFZHU0d3czdQKzE5UzF0N3BYeW1pazByNFNNTDNaVlBO?=
 =?utf-8?B?elk5SkxSWmQrNWlqMHVtVUdLQ1hDalEvcG9sWHhIb0Nyb2loZjRVRVpTVVVI?=
 =?utf-8?B?akdwUU1kVDlEYWt4UzJxOGc2Rm1tazB1Z0FyWjZXb2pzZ3hRZ1g3YS81M0dN?=
 =?utf-8?B?SkRtVlFJVmdwNjhJa3BsYUZuZWh2YzlJMkxVY0RlcmIzMEtaZWVlZ2kwUnZY?=
 =?utf-8?B?a3pSTWVsQXVLYWlid25TZUFTTGFXRitxNXJCTEJqNi9nZEhmTTNVcVZDSXJM?=
 =?utf-8?B?eDNZOUtPd1dxSU5pQTJIVGRjRHI0YU94aWxBSUZNRFQxZmg5UGVlbDhyRllW?=
 =?utf-8?B?L01sMk1DSExyaE9SczZGeVZFbjdDOWh1NGZzM2hYZ3ZIenVCbmpoK1cvWVg0?=
 =?utf-8?B?R3JtWWtxcjRSdXlrZklYcFpqNEgva1pmdWgzQmdLTmQxdEZ4T2NpOUdFckE1?=
 =?utf-8?B?Q2N3cHJhSGlOdlhueDBYcnFJQTdCZ01mclcvWnF0QVR5elV6SUFYdTJLUXlL?=
 =?utf-8?B?Tk5GeVh6MmFkb1dTcnZSYnpHTDR5MzhFd1A1R2VSSVdKdlZma1pJdmxLQ3Bt?=
 =?utf-8?B?RjRGMUptcS9Qd0lOMk05WTVNaFZrTzRhU1EyRDFvOUdXL21vTTAxQS81VFR1?=
 =?utf-8?B?eitaeUJRemtTUHJNVVdwSkg0Z1VEM1BQNUhScEovOUNIQ1BZbEc5R2RxVEtR?=
 =?utf-8?B?cGhFMGJkS2dUK2Y4eDVRdEc2L2dzbklxZjgrMis0dXl5TnJvMzZEU0R5TVBj?=
 =?utf-8?B?bExKR2crZnByOVE2NVZPLzlXMUZtM2t4cjNOd1BIVkVjWWY2c3BTSHFPaFdz?=
 =?utf-8?B?S3laK3ovcEJJNEJPSDI0MXBxY2psVWg5SXNhYklnaVMra3Q2WVgvR3R1R0JS?=
 =?utf-8?B?RytYNnNQbDVqYzUzbEJyMkxNM2p4eXJlQWJ3SWJoRkZFc3BSQTIxUzUwTFk3?=
 =?utf-8?B?eG1RdUtCaEZWbUZEWjJXaHhwT09YQmVFakdvcVg5OTJ3UjU3aDlTNDJqV01R?=
 =?utf-8?B?aStoTWExY0xoN1g3WXFteU9xUERwdDhGZnNwTDlHc1dMeGQzUUhLNmlrcVpr?=
 =?utf-8?B?elNvd1VLT0QwOUVRVUxvUXlPSlZwU1JSZnNDVGFXbDcvTkZWWmhvak13MDZS?=
 =?utf-8?B?RzBEMjV4TEczZnBTc3VxZUVpWEdzL0dCK3BiYmQ4dDRDSXAyMlBxZitJR3pL?=
 =?utf-8?B?MHFBNDgwVWNpbGd5YkdOUmFvek8wb1V4d2FEQklVcmhHNGxLYW1vQ252T1Z0?=
 =?utf-8?B?SC9tL2ZTZWJ6RStwQXZaRk1sQ1NuaFhXTmYwbW5aTzkzUEdUYjlCQ1huaXVl?=
 =?utf-8?B?T1A4RDl1M2E2cWFGcjJVUnpISHhDL3hCa0Z1NDFFVms3bW03b3ErTWVkVGV5?=
 =?utf-8?B?c1dnbUo4bzJNNVNGK1NWKzFlcDdVeVZ2RlR3S2tGY0ErM1ZTc1hraHhtVEdH?=
 =?utf-8?B?anpUZDgwL3dqUFRzTWtvekRjQk9tZk1tYWFMdnhjTjFGYTI3ZGpQM2pzNVNG?=
 =?utf-8?B?TEdkaEFNK2U4QTBzYWhLTWt2UWRiZTM1eE5JcTRaOW5UTTJmTFUrbGtkQ3cz?=
 =?utf-8?B?c2NpajVhdzJZOTFlRk5xenRRaGNsaTBWNENzejFISVJMUndkcjYrZDhrY1hh?=
 =?utf-8?B?bWs2emZmMHl5Z0o0ZGlPWGM0eHlzR0RZRHpRRzVYaVRRbkhTY21pclpmTy82?=
 =?utf-8?B?RGZ5UjRGbHVUTGRZc0xZajRzQWVoS1c3M2kwOGNnWFlNdG1ZR3laQStPK3JJ?=
 =?utf-8?B?cjZTbURHandROHhFcFY0WU5kbWV1UGp5MzFKMjhNOHlVeTdBcXhkRytRRjI1?=
 =?utf-8?B?YnlaNlZxRXNHdXo1Ui8xMHdqOVBHVmEzYzBmVWxYRU84S2IzbFpOVWlycGhG?=
 =?utf-8?B?ZmJNQ2V2UWZpRUYxOTYxREFmSTVaWDFsZWZHWXVzU2U0YVI4TVJFZnA1ZFls?=
 =?utf-8?B?TERpNHpXeFErd3A4OXJZNG1GSG5WNXhuczY3TFRHRU5BZHVxRklCSnhwdDUv?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3C2VplY8SQ2pUYSedkLmn5QTZa2luugEtNjVWEJCyfVvHXjVlLCYDjcjpbSMM2U/2ofkUv6vXStuivCn5c5wNmkdaYJoigRo0+diRBQY+Nsje8V9156FV5FtcEAY6AkCudMxzPwFkCK1QGm7blN+h6W6zOH4FlZewKtUu3cj8R1ka0sbahMjmWxscGZtT0sFM/roYRLs+Ciq7Wc1tBxFe23bf6PBx+dm2S1r6YqUj417xnv5Spyj+rto0ZlSSMmXWTG8yAW0Tbxh/Deymt1OYWaw2cWvRVlQRoBSV5mdm/6XzM4c+P/X3IZqnyiW8NZhjWimLhSl0EMMgnO0+zcQr1n+cjQP0y/pgKIloDHMzyq6DGIxECIlJgYSvI6PXGHkSc/+ixrCUHn+AeKZu/BgXgUkEWhYaHvVd0U7SvWfMtopxhtRVxTFCa/WzjH1VbleIC8ge0O22D/95Evc0eLy9RRmQFUg2/Ryq6/H4YPFMxyYOaiJsQ+oaGYshaXJMCYYQO44l2culHqMrdJtVrdmCbkuXte9FtB8HgzT3noRENhYQzsBkZ+wsZB1svq7iVS0h7MaECcqgbU0rdg0hukTr3EJD1fcPZxSJWYKhCagmWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65030b4-683f-4f24-0404-08ddea221fba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:10:44.2539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yoPTyNGfBOTz+E6Wqstj0ZtmHtN8SQcDb0CzpOngHuayrYa2aMZTdZ0VxqvIEHKSBNCovUhPmcxHrok2M/Y1Y5zC7gLF73YRyr2X0Wj+V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1F77AB10F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020130
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b6ecd8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=BaQ7Qcng2SLN0xXjETAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-GUID: z0oitrZnHGTA7HUMUQ6FxoUOfscJy6Zn
X-Proofpoint-ORIG-GUID: z0oitrZnHGTA7HUMUQ6FxoUOfscJy6Zn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX050sbiXcEEy8
 FB42BUR4m5GL9rINwMWTqGgZDOYmeWFupnd8GqBiFPSQWcRgxYnokVB2AIeMcP2euKQ4DwGNYWR
 9WrADas3TVZFOfoStOmnoHIODWC9+DCEEpiU3SqdDMXKDqv6cPkeG1GrP4PCGsH5vN9wp5uCwZ3
 2JT6Wx2dfhVST2gKMequKQhvqczgh4phyCArBvV6H1r98sdMKt+LAj2fwnqE/AdE61HMwosojsC
 evHeJtSUF4m76gNSCGGAIL068m+bfNoKi4nJl9RQnUsNeqrNLy5/7jknThW6LX5XlEzZlsOeSyH
 veHOUFu4L5bVENXGumQpFfLAXyyUMb19FkE4qjV8m7IwEWo0hT/y322rlkIWLz7mGYqtfG3bHX2
 YJWTID2RB/Q2QltVF4fdroQGeBZ4yw==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/31/2025 10:13 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH] vfio/container: Remap only populated parts in a section
>>
>> On 8/13/2025 11:24 PM, Zhenzhong Duan wrote:
>>> If there are multiple containers and unmap-all fails for some container, we
>>> need to remap vaddr for the other containers for which unmap-all
>> succeeded.
>>> When ram discard is enabled, we should only remap populated parts in a
>>> section instead of the whole section.
>>>
>>> Export vfio_ram_discard_notify_populate() and use it to do population.
>>>
>>> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr
>> failure")
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>> btw: I didn't find easy to test this corner case, only code inspecting
>>
>> Thanks Zhenzhong, this looks correct.
>>
>> However, I never liked patch
>>    eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
>>
>> I think it adds too much complexity for a rare case.  In fact, if we
>> examine all the possible error return codes, I believe they all would
>> be caused by other qemu application bugs, or kernel bugs:
>>
>> vfio_dma_do_unmap()
>>    returns -EBUSY if an mdev exists.  qemu blocks live update blocker
>>      when mdev is present.  If this occurs, the blocker has a bug.
>>    returns -EINVAL if the vaddr was already invalidated.  qemu already
>>      invalidated it, or never remapped the vaddr after a previous live
>>      update.  Both are qemu bugs.
>>
>> iopt_unmap_all
>>    iopt_unmap_iova_range
>>      -EBUSY - qemu is concurrently performing other dma map or unmap
>>               operations.  a bug.
>>
>>      -EDEADLOCK - Something is not responding to unmap requests.
>>
>> Therefore, I think we should just revert eba1f657cbb1, and assert that
>> the qemu vfio_dma_unmap_vaddr_all() call succeeds.
>>
>> Thoughts?
> 
> I agree it's a rare case and your suggestion will make code simple, but I feel it's aggressive to kill QEMU instance if live update fails, try to restore and keep current instance running is important in cloud env and looks more moderate.

OK.

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

(but you should also seek an RB from someone who is more familiar with ram discard and
its callbacks).

- Steve


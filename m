Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC2CFA44F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dzI-0004dJ-6I; Wed, 23 Oct 2024 12:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3dzG-0004d8-9V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:13:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3dzD-0004gR-Qr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:13:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfbjO001564;
 Wed, 23 Oct 2024 16:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rHnWNdCdECygWTGxzGmR2CWCRYTf/HBy2rGT5FRxMPs=; b=
 MFV+nSpkLAdjfmqTN68KwkgzFenffdFSGNMfMKYw+UhaPBIuNQ5/yQNXcPeptyqn
 ED2XxKnyGqSZUPSeiXGoUlK18nVtH9ovICgC14IdU3aMHqTvcDW1+pQMIizy1Ms/
 u8+lFYYhseSZEqiv3frD9w5RhzDPGKo6En3bc/RMzXCRaeUfHZBct3DfJgo2/LXh
 qPgkduA5QCnXC4/u91JR0RyO0pTG8CWtahDac8zb/1489dsC+hrOJwL4oqU3GspK
 pzjjbJV+RAUEk86WNNQwjALAATxBGD4eA8wWQ/kGjwV893Jc4rHGsXb7aayFjIs0
 jDuYciMkDhpQPTGBzHhrHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qgjwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 16:13:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NG2d6F018501; Wed, 23 Oct 2024 16:13:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emhjrpj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 16:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHIol9B8q+gUE2Es1xns63QWc1zxqfi+t2nW/bCO275dqU0UGuAi+VnOOltitwsnJeAE1/5KLYchVXgLEOH+eGwC9YwX9iG+QFlv6YYN6WxvgyoHEeQwhErPBnBSBOgvN9eEgWWIWAL4amVULQnZy3Q+8/6GZKK+/KBeR4oMfATHoqXhnMO3nyiNwrJ8824b1C6FJTOmAZsQHoBysvZHn1U+VhxyBY/k3JU9bI1nPmJo0kLWdGoDCMbp6s8Kgg0SD2y6gdfNV4eexnE95cyvJuBCJ6Br7dxKiEg4TPkXb9L7WONap///HzIdL3E38IVyqu7upYsdZkD4Ye5z4eba+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHnWNdCdECygWTGxzGmR2CWCRYTf/HBy2rGT5FRxMPs=;
 b=CR3Dt3exLiGsQyukUTWAc7ouIAnYgQuH/Qbo0QwqeMxCAjILP780GeFVe8GdVnCQ22wzEytHVZpol+9N5SFXZAxi69sChnkejX/Q9VkQRvOOUIFIOEKYcNf4B+pYw4qzcgFEHzC3L+y5XuJfwUCv/rdMJHMhoa8Onw4Pz3E8BL4oheCjmvuvsdxG5fU5ih8oxTNlWU01+p7u40bVDHEF8uFse56G34qFlKzS/W1McUB8XqY1tmRI/Wk5XCVqRTtvENr5kJlIkBiVY1YgNMkZSZa8LEKv5l7HpPAa19ryVL0ixaccv5k4I92BHfP1rZg20xvg+io+MbWak/MTqd32aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHnWNdCdECygWTGxzGmR2CWCRYTf/HBy2rGT5FRxMPs=;
 b=ENOJwVUx1tUbd3sk6C5GltJKKG4o1eFtP2nPX48VssJgw8T2KRVINcMM8EisLayx+pKgIRVmWqgGZJIBumuCIgs6Gn60L66te0TPQPFGfmq/H8bMg2RbiDc17WQELASrna+WYrKoJlmnNSCJ8UMRwoSA4bSjz4MzYPBKqr+3N0s=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 16:13:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 16:13:20 +0000
Message-ID: <2512f1ce-e191-4ee4-8c37-43801fd5e2f7@oracle.com>
Date: Wed, 23 Oct 2024 12:13:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 02/14] accel: accel preinit function
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
 <ZxZrJjGx0tifZf0B@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxZrJjGx0tifZf0B@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b51905d-1d08-4eab-b81b-08dcf37d9cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aksvOHl6T2t2a1NHbUpqQ3ZsenBCNDk4U2hVY2FseW5QaGVSQjZXNXRybmtS?=
 =?utf-8?B?a1dTb2MyL1ZRR3JYM1FqM016bTZiN0pQZ0lEejh6ZmVKd2xXYSsyd3RXZ3VG?=
 =?utf-8?B?WEhpVXlKdEF4OTFwVExjeVRHQ0R1Z2l2cFBtSkFnRjJvWHFEak1hZk1mVklB?=
 =?utf-8?B?Uyt1NEk1ZVJmUDlUY3MyblE1TlcwV1BqVDBjMEY1QkNENFFadGkyL3pvWWJv?=
 =?utf-8?B?cU9BT3dCZk9KRU9ERmZRalQzTWVlbU5qZUIwd3V5YzVUMTZlemJnM3JjdGta?=
 =?utf-8?B?VkpMdlpMZ2Yvb2c2eVpsSEJCSUwwRW9ESnVUQkVWb0dMUjBGOElDNFNYK1ln?=
 =?utf-8?B?a3Z0L1BDVFNKcTh0QWRrU3IvTWt1ajlwTWN0WVkwckgwRDNUNk90bmk2ZlQv?=
 =?utf-8?B?d2V2dGZpTVZKUlFTQWwxNlNUVXdzaFBrejBGakw2RXFTNmNLcTJrY0p1OWZV?=
 =?utf-8?B?b3pkNWh1Z3FsV3BkakxtclNUM1ljaEVYS09WcHZwcTh6b3hXSjZFeDhSbE5x?=
 =?utf-8?B?R1FiR3k5RmFLcFJCU25PM2taVnhyYS93UjlPd1M1N0hzY0lCMUg4NFRvckJZ?=
 =?utf-8?B?TkRFVkZOTGYrcVlCT0RQME14UHlGTW5UK0JUUWFQdlpTYVMrRndzdGlGSTVC?=
 =?utf-8?B?TXZWcENPNVNsTGtBY3k1T25PbytDckFhbGN1eDg0VmljMnkvb1NJZVhRTFV6?=
 =?utf-8?B?Yld2amZGMFdnRjdZc2dpZndWTW1mWUJyZ3lBbEFzSWgyT1RTL1NLOU5XUnNW?=
 =?utf-8?B?Q1RVenJublJkWkt3d3NaMy94aFpTMVhWSmpyaU1lUno1MWhhZlgwaWErN3ZQ?=
 =?utf-8?B?WmJ6bElmV3o5NGZRNWZvUXcvTjZybFZpYVhOMnU4NnI5RElMTzJHZ2dZZTlV?=
 =?utf-8?B?WWNmUzB6ZnowUHJlQTFBOGJ6UVRHZXlMd2kyUEZnc0dlc294b3dGNWZFTzZs?=
 =?utf-8?B?dVZtMXRNRjdxYjdDTjBqNTlTU2RlcTg5dkhhc2NSS3BsRFh0MjlzQnYxb1Ja?=
 =?utf-8?B?a2dnOVZPRXZueFkwLzd0WnpVM204R045VUQ2SldNYVdVcG9VQ2c1T0RVNTBw?=
 =?utf-8?B?RDFCV3czdTlxQ2t5bmVtb3o4elJ0ZEdJaHpLM1ZZMDFHSlhYMjkyT1ZLK0R1?=
 =?utf-8?B?aWJqSm9VSW40amdqVmRpcEdoRWtwY2ZBVHF3YkhlZkg4WHp4Wmk3VmhPcmJB?=
 =?utf-8?B?aEp0L3FEeDMvSXIrVUxIZklQL0UwRXpHYjIvMFVibG5RelJyTjBSM0sxSU1i?=
 =?utf-8?B?aHQyNGUxb2greHZObEhndmZUSGhQMDVuQzZOS3dDZUU3SkNWUkFpbUpiL3Nt?=
 =?utf-8?B?ZFljcm4wOWs2ZGtZV1ZvUjkvVFlxS05YMkxRWTdnc200TjVsY21mczBjRDFB?=
 =?utf-8?B?Q20wQmx6eUo1eWdKaG43Zml3T3hrc1NwZ0x4K3RUVFJZTkhiRWVSVkplWWND?=
 =?utf-8?B?Y2pCQlRzRnUyUVN4c3RNWCtEd05iVWwrSmZOWERiS0VUWFhBYnRXc0VCVEsx?=
 =?utf-8?B?RWZVTGtHaFhHcTJFbDhwOU45NFE0dTVJV3paZjVIaENNMVZ5Qm81ODlUMjY2?=
 =?utf-8?B?WXgrcTJNVEdhZEFIRVBYckV6ZVNJMFlvWlIxOWp5WmI0MVR5bmVhOXI0anUw?=
 =?utf-8?B?T0ZkZkJjZHZFeTVlSy9jaUhoQVhweHIwQmdidmNXQmdZM0lucHMxSmZ6bHkx?=
 =?utf-8?B?eE14MmdpUy94MmZGVVFJVzJ3aWIwLzFLaXFOOWFTZlJXU3phS29kekc5ZnhD?=
 =?utf-8?Q?yvIe/7s4kFJ8+MKModGrSMK2aL/L3FgYkRnI3RM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTd2d3pmcmtUaU96dkFFek1LYXdIZXNIdnZhSURPNFpxbDdOblhVaFNpNjVj?=
 =?utf-8?B?YnMwUHBuMDNNV01uVkRneDhUd1NDVlNleko0ektyMkt5TFUvZWlEMUhQZVhx?=
 =?utf-8?B?enJqaXp4VjM2dndJWTRhNU8wMnlIMVlReVRGdDJsdGtGejJscWYrRlpNOGJD?=
 =?utf-8?B?cDVQZUxQZWdldDBRZkJXYm5BcXRPUGNxSnduY1ZNVkdkVmt6SXFMdnpRZjFn?=
 =?utf-8?B?enVaMDZVVzNGakswcHhrRG5EYzQ4bUxhVW5QR0hzQ2E3OUJaUzRSRXpyRjYy?=
 =?utf-8?B?Qktiejk2aUUyUExwb09YUWYrNUNvVFpjUTVGRnhvVkR3VnhCb21zdGFub1Jk?=
 =?utf-8?B?eGU4dVlTbTN0TTFFMHhRR25aUmR1bUo0MWtFVWtiREx2ZnM1T2dOYW00eTBN?=
 =?utf-8?B?S0dLS1dPUmdEUklaR0t6UnRFSUpYc3B5OWN5WTdlTkRsNThIa2k5cUZLZytx?=
 =?utf-8?B?WDZPZFNQRDFuSU5BeDNIbWFoRG1zajJ6V05vcHVqeU1pTzNLYWRsWGNsMUVj?=
 =?utf-8?B?SlBOenl1WWNjcjFSM2Z4VEtYK1pxdzNtWUlXNTZEajk5c3YxNGhxbG4zODJh?=
 =?utf-8?B?b1NMUTBGQVIwK0RDQTkvMGhIZVBXaGwwQXZhNmlsditqM2Q1b1hCWjNoWHpB?=
 =?utf-8?B?RUsydzdGcmdIREhMMTR3V3NjOWxudnZJc1dkK1JMbGNvYWRYdUFJUFNnWFd3?=
 =?utf-8?B?bmE1c29aYy9jL2FaejM2N2x2bEovdnorVmF5ckZ4cmMvZXRhclpaWG5yeUFN?=
 =?utf-8?B?NURub3dOQXA4WERUWjZ6SU93ejlBRE1QaW12NnpNZWFpOVpjNkNRc0QveW5y?=
 =?utf-8?B?dzh1SnNIN25Pbi9ia1l2dnR5MThVZDlIV25NQ0s0enBIeDZGQitSUEVmQ2da?=
 =?utf-8?B?UmRPWjJ0Y3A1eXNNcGV5YjRKOUNxem1VZ0NrMXdidjZ2UmdSUzI3YUVzK0o0?=
 =?utf-8?B?TXZsWjVFVU9lUXlZbmd5U1VDdjBkWXlKNUw0cGFUMmZGbm9lSlhlSnhtR05u?=
 =?utf-8?B?dFcrNVVYemhjNzJQYUV0c2FBYmlHUE1XMGVWdjdnVzM2amRQbEdMVVB3V0xi?=
 =?utf-8?B?Q2t2ZlVqZkZDaVArcm5YTmNmVzNDQjZaU2lZc3VEc3N5VGU4VHNrQUFaV2p2?=
 =?utf-8?B?T3lVY0xtblJEdDhTVEgyUjBhc2FpQmJBMWhzcE8xaEN5YXluZHFVMjIyYUhw?=
 =?utf-8?B?Tm5td1dWMGQ1YnBIVXlUcVcyNDI3QUtycGRub2puWDVxZFJldWRDU1ZoQTBG?=
 =?utf-8?B?b0J1MWlMQmFqSjVDMmxvQzdoWVJ3d29GaC9zendzZUZlYkNrdGcrRFVCSlVN?=
 =?utf-8?B?YlVUWVpMNFE4bWVwL2ZWR2d0S3BrZGxkRU53U1ZSclZpSlh0a0VEdmhsNzlK?=
 =?utf-8?B?WHk1Z1FmVUo5K3RXZWJGQUdHVzRVT0t0cDVhUVJMUjB6RUpNYUFNVHJodTU2?=
 =?utf-8?B?ZlRxSnZyYTVBNm1vd2hiMFB5UXBKTWZQYzMrV2NuQlFObG43UEdCVTBVN0s5?=
 =?utf-8?B?VHBobE5PMnExKzh5bjFRcmZwMGpCaHlMdTkzaHN2dUlVWk9LZkt0MEkxRFY4?=
 =?utf-8?B?c3EyK1FsSUpQbDhrYWNtL0JKeW5oWFd2WFBORFM0RVhvK2U3ZHNlN09udVlO?=
 =?utf-8?B?VGhFdWdsK1FIOVhibHJBVGg2c3ZONXZubHREZ2RJYnpKVGF6RGhMbnV5OHI3?=
 =?utf-8?B?a0tvbVN3SWNuSFkwQUtqZ2FPVlBwa0FPRm5odnlrMTZyVHdjY1VaY3I4cjNh?=
 =?utf-8?B?RUhqdTNOTlc3MHNyM1BadnpKRkFIdWxOaWttMFkraTFqUjg3dDMrNjBndUxn?=
 =?utf-8?B?dFdSbEJWaFNlS0Y3L0N0Wjk2WTJxdi9VeWFmbm5rS2FKc3d5dDk2WDExUW1y?=
 =?utf-8?B?MUVqSHBvbWlrZkVEemExd2RBZmlDcWNhUUQzZkthdEFPQ3FZSzl6SVFWYmd1?=
 =?utf-8?B?QWVKLzh5MWRzYTFJWWRlQngrbDYzWnk0bFpFVUVLRitVanNCWEFFSHFOWEpG?=
 =?utf-8?B?cG1aSHBZK0lhM2hYL2kwNS9BK0FPamk4QkozMGNPcE9vcFlGTlZ4YkZvZkZK?=
 =?utf-8?B?N0Y0aTVEZ05ValJhNEVlSkhveEtBd0l3Nk9XS3BPeW1kQVBFV1ZYdGVXeGdC?=
 =?utf-8?B?Ny85SXRJb1plNEZOOE1za2R3ZTZXRTJSaGo3OGZobVpQR2h6VUdBanY1OUs1?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cb9ovwmRB9nql3X9TfbbtLI32U7Twh2V1ZNSza6zcw8Y1aPvZKh/JvLMqkt2ow2GTs2NGw5vxeiOOPpYk34Pvna0gdUrOTj547xXkAInCPtbn4UNsusKf6Vscb/BulFk9MtBR1npnhmJiq7bwVHRorsbcC+3g8AB/N7MMzfCfi0yRDLmTgRXpzmUjc4RKJH9IGntADqfZQykfEjIgz22fay7P2zkR29hhw6iNnIMVqrMQVNgPNxmGaJTNZkqNcuH0ONPQ/tLaHHTtJEFeLfJazCBLTi2theoCOfNvuAa/zIQlcFDBK36/bTkdHttUv45TeID7OuO925xwrosYoy5Azyf5AfOWMs4ZQ4rA637Za5PEe6nts4XB8AgEOhxbHXN5wd1zbi0FHteSPMXERsJLuWCkZvNhyJsRNzzmdD4IosKDg1voDjRI65oUp4IT2bFstDqTdMo42Q/Q6HM1T2aUupPKtsWNFJyfgMQHk4w72SnvRWGmovs8pV/raHolRfg282bv8QpVlH/tZMQoO6rTR5PFqELtMzmrGJH+wsi9BNSnrcNRsFGeG9cFSWa0bkLxAseBKcRj+MmwM5yXUKMna9YpPv7zL0neP0Vp6AA1GE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b51905d-1d08-4eab-b81b-08dcf37d9cad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:13:20.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VG+u1BMdU5bGCmbMj/sMbjaLizXbGU1eZKXQNA5NUmMAkSDS4iwZMTLAEuj0fiWPDg3TaA/DI5mNhMmGeLatPQJ4ZMAuNwd2wn+h4tff34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: A72jJqaHK51nXFy2FBZLc0JuCBq30vRm
X-Proofpoint-GUID: A72jJqaHK51nXFy2FBZLc0JuCBq30vRm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/21/2024 10:54 AM, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 08:14:03AM -0700, Steve Sistare wrote:
>> Extract the first part of the AccelState init_machine function into
>> a new function preinit, which can be called without knowing any
>> machine properties.  For now call preinit and init_machine at the
>> same place, so no functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   accel/accel-system.c        |  6 +++++
>>   accel/kvm/kvm-all.c         | 58 +++++++++++++++++++++++++++++----------------
>>   accel/xen/xen-all.c         | 11 ++++++---
>>   include/qemu/accel.h        |  1 +
>>   target/i386/nvmm/nvmm-all.c | 10 +++++++-
>>   target/i386/whpx/whpx-all.c | 14 +++++++----
>>   6 files changed, 70 insertions(+), 30 deletions(-)
>>
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index f6c947d..fef6625 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -36,8 +36,14 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>       int ret;
>>       ms->accelerator = accel;
>>       *(acc->allowed) = true;
>> +    ret = acc->preinit(accel);
>> +    if (ret < 0) {
>> +        goto fail;
>> +    }
>> +
>>       ret = acc->init_machine(ms);
>>       if (ret < 0) {
>> +fail:
> 
> Jump into another failure path's if clause might be error prone in the
> future.

I agree this is ugly, but the diff is small and easy to understand, and patch 3
makes it pretty again:

@@ -36,14 +36,8 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
      int ret;
      ms->accelerator = accel;
      *(acc->allowed) = true;
-    ret = acc->preinit(accel);
-    if (ret < 0) {
-        goto fail;
-    }
-
      ret = acc->init_machine(ms);
      if (ret < 0) {
-fail:
          ms->accelerator = NULL;

- Steve

> Maybe move the error handling out while at it, e.g.:
> 
>      ret = acc->init_machine();
>      if (ret < 0) {
>         goto fail;
>      }
>      object_set_accelerator_compat_props(acc->compat_props);
>      return 0;
> 
> fail:
>      ms->accelerator = NULL;
>      *(acc->allowed) = false;
>      object_unref(OBJECT(accel));
>      return ret;
> 
>>           ms->accelerator = NULL;
>>           *(acc->allowed) = false;
>>           object_unref(OBJECT(accel));
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 905fb84..c7c6001 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2484,6 +2484,42 @@ static int kvm_setup_dirty_ring(KVMState *s)
>>       return 0;
>>   }
>>   
>> +static int kvm_preinit(AccelState *accel)
>> +{
>> +    int ret;
>> +    KVMState *s = KVM_STATE(accel);
>> +
>> +    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>> +    if (s->fd == -1) {
>> +        error_report("Could not access KVM kernel module: %m");
>> +        ret = -errno;
>> +        goto err;
>> +    }
>> +
>> +    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
>> +    if (ret < KVM_API_VERSION) {
>> +        if (ret >= 0) {
>> +            ret = -EINVAL;
>> +        }
>> +        fprintf(stderr, "kvm version too old\n");
>> +        goto err;
>> +    }
>> +
>> +    if (ret > KVM_API_VERSION) {
>> +        ret = -EINVAL;
>> +        error_report("kvm version not supported");
>> +        goto err;
>> +    }
>> +    return 0;
>> +
>> +err:
>> +    assert(ret < 0);
>> +    if (s->fd != -1) {
>> +        close(s->fd);
>> +    }
>> +    return ret;
>> +}
>> +
>>   static int kvm_init(MachineState *ms)
>>   {
>>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>> @@ -2523,27 +2559,6 @@ static int kvm_init(MachineState *ms)
>>       QTAILQ_INIT(&s->kvm_sw_breakpoints);
>>   #endif
>>       QLIST_INIT(&s->kvm_parked_vcpus);
>> -    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>> -    if (s->fd == -1) {
>> -        error_report("Could not access KVM kernel module: %m");
>> -        ret = -errno;
>> -        goto err;
>> -    }
>> -
>> -    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
>> -    if (ret < KVM_API_VERSION) {
>> -        if (ret >= 0) {
>> -            ret = -EINVAL;
>> -        }
>> -        error_report("kvm version too old");
>> -        goto err;
>> -    }
>> -
>> -    if (ret > KVM_API_VERSION) {
>> -        ret = -EINVAL;
>> -        error_report("kvm version not supported");
>> -        goto err;
>> -    }
>>   
>>       kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>>       kvm_guest_memfd_supported =
>> @@ -3891,6 +3906,7 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "KVM";
>> +    ac->preinit = kvm_preinit;
>>       ac->init_machine = kvm_init;
>>       ac->has_memory = kvm_accel_has_memory;
>>       ac->allowed = &kvm_allowed;
>> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
>> index 0bdefce..dfcb90c 100644
>> --- a/accel/xen/xen-all.c
>> +++ b/accel/xen/xen-all.c
>> @@ -75,10 +75,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>>       }
>>   }
>>   
>> -static int xen_init(MachineState *ms)
>> +static int xen_preinit(AccelState *accel)
>>   {
>> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> -
>>       xen_xc = xc_interface_open(0, 0, 0);
>>       if (xen_xc == NULL) {
>>           xen_pv_printf(NULL, 0, "can't open xen interface\n");
>> @@ -97,6 +95,12 @@ static int xen_init(MachineState *ms)
>>           xc_interface_close(xen_xc);
>>           return -1;
>>       }
>> +    return 0;
>> +}
>> +
>> +static int xen_init(MachineState *ms)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>>   
>>       /*
>>        * The XenStore write would fail when running restricted so don't attempt
>> @@ -125,6 +129,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
>>       };
>>   
>>       ac->name = "Xen";
>> +    ac->preinit = xen_preinit;
>>       ac->init_machine = xen_init;
>>       ac->setup_post = xen_setup_post;
>>       ac->allowed = &xen_allowed;
>> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
>> index 972a849..6b3b1cf 100644
>> --- a/include/qemu/accel.h
>> +++ b/include/qemu/accel.h
>> @@ -37,6 +37,7 @@ typedef struct AccelClass {
>>       /*< public >*/
>>   
>>       const char *name;
>> +    int (*preinit)(AccelState *accel);
>>       int (*init_machine)(MachineState *ms);
> 
> Might be nice to add some comment on what should be part of preinit() and
> what should be part of init_machine().
> 
> AFAIU the preinit() was about probing whether an accel is supported. Maybe
> rename it to probe()?  Then it's also clear why some accel (e.g. tcg)
> doesn't need that, because it is always supported and no probe is needed.
> 
>>   #ifndef CONFIG_USER_ONLY
>>       void (*setup_post)(MachineState *ms, AccelState *accel);
>> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>> index 65768ac..ce858a0 100644
>> --- a/target/i386/nvmm/nvmm-all.c
>> +++ b/target/i386/nvmm/nvmm-all.c
>> @@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
>>   /* -------------------------------------------------------------------------- */
>>   
>>   static int
>> -nvmm_accel_init(MachineState *ms)
>> +nvmm_accel_preinit(MachineState *ms)
>>   {
>>       int ret, err;
>>   
>> @@ -1178,6 +1178,13 @@ nvmm_accel_init(MachineState *ms)
>>           error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_size);
>>           return -EPROGMISMATCH;
>>       }
>> +    return 0;
>> +}
>> +
>> +static int
>> +nvmm_accel_init(MachineState *ms)
>> +{
>> +    int ret, err;
>>   
>>       ret = nvmm_machine_create(&qemu_mach.mach);
>>       if (ret == -1) {
>> @@ -1204,6 +1211,7 @@ nvmm_accel_class_init(ObjectClass *oc, void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "NVMM";
>> +    ac->preinit = nvmm_accel_preinit;
>>       ac->init_machine = nvmm_accel_init;
>>       ac->allowed = &nvmm_allowed;
>>   }
>> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
>> index a6674a8..50bfc19 100644
>> --- a/target/i386/whpx/whpx-all.c
>> +++ b/target/i386/whpx/whpx-all.c
>> @@ -2516,6 +2516,14 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>>    * Partition support
>>    */
>>   
>> +static int whpx_accel_preinit(AccelState *accel)
>> +{
>> +    if (!init_whp_dispatch()) {
>> +        return -ENOSYS;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int whpx_accel_init(MachineState *ms)
>>   {
>>       struct whpx_state *whpx;
>> @@ -2529,11 +2537,6 @@ static int whpx_accel_init(MachineState *ms)
>>   
>>       whpx = &whpx_global;
>>   
>> -    if (!init_whp_dispatch()) {
>> -        ret = -ENOSYS;
>> -        goto error;
>> -    }
>> -
>>       whpx->mem_quota = ms->ram_size;
>>   
>>       hr = whp_dispatch.WHvGetCapability(
>> @@ -2713,6 +2716,7 @@ static void whpx_accel_class_init(ObjectClass *oc, void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "WHPX";
>> +    ac->preinit = whpx_accel_preinit;
>>       ac->init_machine = whpx_accel_init;
>>       ac->allowed = &whpx_allowed;
>>   
>> -- 
>> 1.8.3.1
>>
> 



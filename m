Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5EBC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKWP-0002PT-FT; Wed, 11 Jun 2025 08:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPKWA-0002OH-Ak
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:25:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPKW7-0008S5-37
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:25:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B1Cmib029256;
 Wed, 11 Jun 2025 12:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=d10Qlab0EmBFOQPFFiTSdKKJVfcNzFBlJDv5fOEXSLE=; b=
 e/2KC+NhOzEeJoWVEdEJH9r4g6dpCLwQHd6jIRNUESe9w6oVZdD1H7BJDrekLT9U
 fJQ+1hx9IIjYjRyglSNUfwdneaPZMSyhgs7eoPeu7FOLL8wDDhcGAqB1h0VS2SYs
 SoxXMsi1qswqYEUFZUM2Gn0+Z2gYTACO0nGY58QOH79fP690lEg9SUxoVfcQ24ko
 6637pudNFuxiHrr1Au+KqPYYbs47V9REZC35lD+SvSWix1D+5SG/ogKEKsRPUk7q
 uibTa3izqk9x6QXtYZS8rFghViNurdU9mjBJERjlWW3vsdQxUmoBiIMUV5Nv4tSq
 ZQYw3waMn0lSokICpvbRmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14e96t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 12:25:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55BBdxeV003964; Wed, 11 Jun 2025 12:25:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bva3m3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 12:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqN5QkQR5L6+WEjzAozJtZtATJ+JG+RZh0pj0BUdUC9uZckSCJOvUd7QWs/8Kq9wcKl5hkqtj+7WCnGNgmbBWKaShsFymRdS0dgGkn8nWHHDuU22XK9IG4zptirKpi+vady4zygpS+j8qxlRPalBJYG0rR4LKYgyJGT3Bbn84yxE4hhg2/Crum0g+d3NYf/TrAZIhZ/+TML/j2qrKvlmNz5AbNGvD+Ag2iYWJDb5olqe8MeyCIGd4wg4PIERK5T1747A50gJZqLjA2n/Pd/xNzM8KT8MYsfTWO8WAq8KkHulHmUvmQQf+6JP/zUjsqxNsbpCMSWGu8KpOLeDflOwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d10Qlab0EmBFOQPFFiTSdKKJVfcNzFBlJDv5fOEXSLE=;
 b=rqbEJl7gJqdwJrzxlv1bobpcH0Njab4ERwxi/YWIzzrT4ho0vy69YjaVq4odI5C/lsB11ZO1GVTzvpQjG419j82UlnP9XZ/hgZDPjgXy8b3sB3ZMJ7h+PU6w1+DvdfuGk9e0ApXdFV0NwtC0wfLGJQ9q3i3Kp94P+Zhr5tkb2hrFoB3Msg9GLT5aObr0kgpzR8YjaXPaNfsiqkHJ2Rus88KFw1Mb8YHy5fq5CzKZ8iu96flAVs3Nw++dQ+r1UoT4dS1W3ID64gZ5Rk2Xo05p0AydB2ESVPlF3/H0plVgmzsR8HTKG3vwvGSOKyK2zam+uMXh+2b67tvYK/EfVmxDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d10Qlab0EmBFOQPFFiTSdKKJVfcNzFBlJDv5fOEXSLE=;
 b=MpmrWeFsoBkJcEDrVNHda6TM19Do9J9VTSC68AaKaJKV75WJne2cfqFvoSAWWECzyeLxXdMKnOQoLOL0oEgc1UYTmUedxRmX9C8BWt6N3+L4DSPEXIGn4QlcDsWNsEBN9WsubfIzk1U4EfM9zb13HFihszFkZ9DWVR1/yJBPH4U=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5950.namprd10.prod.outlook.com (2603:10b6:8:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 12:25:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 12:25:09 +0000
Message-ID: <791ee7af-8858-4c0e-bd6b-0260cb0be070@oracle.com>
Date: Wed, 11 Jun 2025 08:25:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tests/migration: Setup pre-listened cpr.sock to
 remove race-condition.
To: Fabiano Rosas <farosas@suse.de>, Jaehoon Kim <jhkim@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, peterx@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20250610223342.553744-1-jhkim@linux.ibm.com>
 <87h60mv5ue.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87h60mv5ue.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ac76f4-ac43-456d-0473-08dda8e3017c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Smg5WktwcWtlQmVsc3JJWVJxaDhqZ1VFQmo3VDJKc3lXbUVrcWVLMlQ0RkNq?=
 =?utf-8?B?VVdzdThkQjI0M1lIdnBxVEk1NEgxNHZzQ0tNWVFZcE5hdkFqVysxL1JaRk8r?=
 =?utf-8?B?YW9IUlFsUldtSzZuYzgrYWZaS3pjTmRidXJodGJhM3U4RlB6c3duMzI1SFNJ?=
 =?utf-8?B?RHdxdktrd1BhTjJHRUdaZ0JUOFI3YkppRk5lalYxcml5YmRYYlNpZlhWYy9S?=
 =?utf-8?B?ZkFtVDRGK2tmUkRKMUQwN3lUU0l3SjB2MEkyQVRGekJSSWZzcEllV3BmTG5C?=
 =?utf-8?B?dUEzcU9adEFxU0NleGwyajBSaTRaQkVseGVEcWRsekZXYzgrWi9JY3VVeDFH?=
 =?utf-8?B?b0JlZjNoL2tWK1FSZHdwS3VGY1pySnlOTHhScTlsT0hzcVZYenRadEk5OFd6?=
 =?utf-8?B?MlhrVGhJNGRRWERVSzR6d0p1dkN4Yis5eVRKZ0pFa3l0YVNOQUZGenduUWNx?=
 =?utf-8?B?RWxvOFg1WUpPR0QwOXJEcnp3RHZQTldLRW5sTTVqaC92eWYxSndHckcrTVIy?=
 =?utf-8?B?QjhRU0RkWDVCZUJZMjlmaUpJNGZVU2JBMk5wZkxZUnkwdUZpUDdwU3Q3UVZz?=
 =?utf-8?B?SncyYXFMaGl1MER2clZweXlvNjRMQjE4cVlpZnVZQ3ZMZEwyQUNBL1lFOEVz?=
 =?utf-8?B?MURJbEFOckI2QWx0TjVPNEtXZ1pocDg1UERSRnk4bm1OZGFhTjhhNWxmZ1k1?=
 =?utf-8?B?bmJDaXFXTlpsWEV2SEJpZWhWTXVwNnVzNjZqT1VQeFdZSmg3T0l1QUVwdk56?=
 =?utf-8?B?ZG04cjI3T09pOE10b2FOTUI2ekdTUkxLUTVBL0JxNU96enRRcnF1MDRpL0VX?=
 =?utf-8?B?NTVxSUxXZHAzNm96UGJKbXJnRjNpOXNUUjVCOVR6QWhvRDBsb2VPQzRMam9p?=
 =?utf-8?B?MDV1TVNBYWh4eEszejU1WnBqNFp0UlBsUFdHZjg5YWNyOWxvaVZQdUFaWUNE?=
 =?utf-8?B?QnJ5MytobU1wLzdabGRzdWJEZC9UYm83bVQvc0dBZVk1aVMxQ1BWb0VyTmdz?=
 =?utf-8?B?bktjTGRCd1UyYnViUUtPT09EMElpeWlhamJuazBOZ1paYXZsZU1GL0dxUVZy?=
 =?utf-8?B?WDhUdzlyYlJiVjhXck1kSDBaR29vM1EydkZKS0dkSlBvMFROK1JhMmljWGRY?=
 =?utf-8?B?U0xUU2pSYXMwZGFyMjJBOTB4L1hsZkxpeDJ6ekxnb2xZS3FnU2lVQUEwbndC?=
 =?utf-8?B?RzhhZyt1aEQzWlVDdldIMWdYTVFXVkNvR2NYcTVKbkFXdjdLdGo2cTViTkNp?=
 =?utf-8?B?cWEycW04U2tHSndweU8xeExPSUlsOEdOT0lhREwrcVR2Yk0rdjNNL2h2aFhr?=
 =?utf-8?B?NTlBeSs1SCttZ3ZCNDlZNnE2RjlBZFpBaE14aDlUaENPZ1l2N1RvUDlXZnBQ?=
 =?utf-8?B?Q2xNNTNCL0xtVzh2TkwrMmxnWHpIOFFMdUFscThYeDBCZU5rNFlXRDRUVEV5?=
 =?utf-8?B?VDRscnM1dFpuWDVwbzJySW1oaytwK0FIbXhER3RvdzEzNC9JTTVEUGcyQmtX?=
 =?utf-8?B?WmR1NUlyYzJWR3NDN1J2SDVyWGgyTVYxU2s5ZWk3dS84blVFeVpEL2xIaDFx?=
 =?utf-8?B?SEpDa2Jzb3NWbSs1QjlyVzJaMWx3bVVLYytRRUc2MnRYZXN3azByYzRVNytY?=
 =?utf-8?B?Z21QNUFiYjdxckRzQUpna2kzTVdEeVNFVGgzRitnYmUvbUZRUTNEZ05Sc2sz?=
 =?utf-8?B?UGdkblVMWGgybmVxbEVTZUZRMFR0RHZJKzV3d01nQXNXdFJlbGpnQjQzTXRp?=
 =?utf-8?B?VHBNY2VVTHVhVUl0b1lqWTg4S0RZeDEvVXpGQmdUMlJwVTRDQ2VSbWR5SHZo?=
 =?utf-8?B?U0JpWWVyTS9hZHlBdUVVUlZZQk1rZ0orL0g3alJMSDh2VFV2YitvdGs1ZmZn?=
 =?utf-8?B?Mm5XK1NBdW04NmN4UnJROHJpV1VrQmtVRXdEUVNkcnUzK2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjhyNm5wQWhnRERQZWlzM2tSWU1CVUdRZ2hBVHJYYU1Dc1JIMTJXUHFzQlly?=
 =?utf-8?B?QXJBVExOcEd2WmpUd3Q5QytTWG5HT0FpQXNvZkFaMkJ1QkkwMFd5NWFrYmdS?=
 =?utf-8?B?WTNZOVVaeTNrR3dZYnk1MHpnZ3prTXFqUXdmTmM5THluay9ySFpUQ2xLWlJS?=
 =?utf-8?B?cWdOUXM3b3RDbklSYUNndkFQbTdoU1psTjJHR2Z0ZXh4cEx6MXJ0S0h3UnUw?=
 =?utf-8?B?ays2MlNzQW5Ja2wwMzBrUTd4cXpWaC9MS3EvS2VneUZjMHJmaUdlME9iNGVO?=
 =?utf-8?B?Z2pQUyt1empEYzg5YzdlMitMUURzRzBqOUZ0czQycXk4RTNCeWlsUmYyMEQx?=
 =?utf-8?B?dlp4RTc3Z2hWQXlBTllUMXdLclpvb0FzWHJVTVV6ditqUnJnZjE3T0F2MDUz?=
 =?utf-8?B?SFFtUFdKdzhKa1ZidHVmTERPRGMxcXkrWWV1TC9DSDR3d0F2VFlYN05Hd0xG?=
 =?utf-8?B?MEZwS1ZWa010S1BBeEhPdVpJYjVWWEVNTU4vVE01MzNZaHYycndkdTN6NVVV?=
 =?utf-8?B?NWprQ3R5ck9tc20vRnVERmE4ck1kUkxwcTkxVHRMK3NpY2drcUs1eENiVUtz?=
 =?utf-8?B?ZU14UEN4QnU0QmdWcWFiYnJlTHFxczhMUGk1NVB1c0F2bTNYSHJoWWhCaUQz?=
 =?utf-8?B?RHlXamRHOFU1UFpnQTFhYmd4cFRNUUpFLzhuekdtVllpdkxQdndtV2l1SHlU?=
 =?utf-8?B?WWIydUVWUzIxaTU1RWFWeHQ4V3RRdlBhdFNTZzY1bDV2RDhJdWNheVN2UTh3?=
 =?utf-8?B?K0x0Nit0TFltZ1dDNk5Pcmp5NU9WOUp4S0dCN2JrcExYSUR6SWpZcUk0OS9y?=
 =?utf-8?B?MU0rd0FuSGtFeGxUVVVRQktETkJqQ2RVU01mWkJlWUcra2RsVzVuUlp3Zjht?=
 =?utf-8?B?dHJrdUREbGtJUE9jSDJVYzl5WEJ2S0QrbXZJWFdNR2pkclBkR0pjMWhzTjRJ?=
 =?utf-8?B?Ymc1ajE5MXF5V2oxMUplTWE3VWxUZVlDZ0E1QjVHN3FqS0NoMWlTZmlpM3Ev?=
 =?utf-8?B?WmJhMnVITVplZWt0U0RSL2EvTnVYOGlUNDRWYk1SVWc4Slg5S1FtWWFQci9B?=
 =?utf-8?B?MUFqSUtFMDFwZ0ZNN2lWdmJtQUJGTm01VWZkblVXSURBWkIvejhXZFpqTk03?=
 =?utf-8?B?VUY3R3ZBTmN1VlNGMHM3YUttNFhSODF5NEF2UkJXWStLRVFRSFdWL0FjeC80?=
 =?utf-8?B?NlhmQmlaeDIrMUQ3cVZDWVlOR1ZpOUVQWTM4SUR1dHQ5TW5Yd0Y1b3ZDQXdC?=
 =?utf-8?B?NG5JZ2c3eFFsNzVYSmZDaTBXeTB0TWJlQVJwOXNsWGd1Sk80dk9Lc01MZFNL?=
 =?utf-8?B?TmtpQVVtTzIrN2FCY2tpeDh2aVQzdzlFQWFrRnRGbkpEMm12NFhGUld1aWln?=
 =?utf-8?B?a1BhTEVOUmNIRVY2TXFkYU9uaWZXbkhISTNmTDQrNHF1STIzK0cwdUh0R2px?=
 =?utf-8?B?d2FUcnVZcVlyTGV5UHEzUjRyV3hZektJVnJ1WWJOWXFzNGwzVGNIRFczUDZi?=
 =?utf-8?B?NWRQRGlwbW9iQjNZcm80ZUp2b2hjU1FDVmJGUFhYWlA1ai9LYll6YlJqUE5h?=
 =?utf-8?B?bXFjV0Q2NUtobHM0Vm1jVVROVUhpMzFCZDZLWkVudUhJRzRDdW15elE0SUhN?=
 =?utf-8?B?M2dCOXlWeU16T2xMbUNjem0wYWNhNklEWWtIVUVoWW1mM1drM09HUklOWTJq?=
 =?utf-8?B?RjZhY2hCa1BKTGdUQXF1aC8xUnRvc2VjdGl4bHVCbk13RmJTMG9pNVJDSzZS?=
 =?utf-8?B?T0hVVW45enY3Q0tkdFM5TlFVUzN4NlRsb2VTMHUzdGl5UWtZcU9MZWxNbkJJ?=
 =?utf-8?B?M2VFWSs5dWRId2RpLzFTc2Y2UGROQVlXNHpvR0UyY1VJUlhIWmpia3d4ZGJu?=
 =?utf-8?B?WkV1ZUptUGJxKzM0MVFkcmk3MjYrMGMwYXNTOEdaTkxta1ZZdmpmR3lJOFFU?=
 =?utf-8?B?ZUowa3UveFk5SENsRURlQWVGemdxeXRDREk4NkNubHVEWk1HcDhKZzRxaDRl?=
 =?utf-8?B?dGlLVHZFNEpJN3BudDBsd245MEIzZEFNdmRBaUJGaklvL0ZXUDFjZm0yb1NN?=
 =?utf-8?B?WHRjZHNiWVJmQUVUTTVtVGJIZnZzQzdMN3Y3V0Evay9QdEZuYkRYTzNVY05w?=
 =?utf-8?B?UHNxRis5YVc0M0RyU3hpM2czR3plRVRMdFZNSUR0d25RemFKQ3VySVRDWkRV?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JhMmeQRaAxKK4ciAWRb1qIA3EPoI5OKuSV+hY2AZIghz1QBSgorSTom+RUl94v6fjX7DttGmXPu31Rdvr0KQybmVgBtrDT7Wo8XtaVywjbARfP2d4dyB11faVzwmlV1mDhvHVniZKOLkQhCl93LxT5lIivaPft7L1X6yKW7z8UTk5iZIOqC4r3JUqxaqNKbsRztI0gU1BoTQYw7XWDxIrhOWt+MI3cXxuVTI2B8CWXxD2fho2qmOpMX1K2R2/k/AY3BvVnnoNAlhgQRgX/LeJ2658Y1nREoa4BDYEBs5jOfxLTjXzuBp7scQeAM78iBavIk3G8VUaI+3tysziQCBvCV8pbu2f2aBBoou8YTP81BDaqoUDWAo4WKVVflx7CMRt8YWO5sMwdy9F/XcnDLIXj9DMfr0Hw84jUaU/+OQmq9bRMAu1iSU+ugnol5CeCFhlwXac4DIoYWoIMsslmlg9xGRd9lUNC0UEewhg8MLquoq9NUAdFXqkhQgQdXFqiixSpd+r9A25X0VuepevIZd+WJkJa77pdIKLTr75RrueIclEtApZh+axZuLe+5+eEGZDzQ0lFtY9aN/DVsuQCEU3T0H1FyTlwpIgNjrntWiWzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac76f4-ac43-456d-0473-08dda8e3017c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:25:09.4642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6OpFZXkr/uIE6/8SQMpsMnke6neXWE+CvFFxb/oZ2ifv6JMIPs+dMvSwHhn0AWzgNETHGZ9h9fp2eLFutka4zwvijCCYiLd390YlK3pWSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110106
X-Proofpoint-GUID: VEGO7iLn5LolLWXAj4QvEvzNXEs5D5VZ
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684975aa b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=JzhzQ6guMLj7xYE5ZMMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwNiBTYWx0ZWRfX+8Nemz6/tfxA
 Gq8YMmyJlH8oefsBVOCEAjLuSCZGWHyNDMgqfZUinWLKNkjxdAGuf+TazzUC8wgR9oOdXY6Dt1Y
 J7AhOI4+HMBhfEdLOy9lW+qCvC7g8eXU7GN31J++iOP6n+rqXy2pFpNstfFg6hqeyhndtaBHdK2
 ZVjZd6+bYs98icPAwZLRagW0Isl/TC3ZOyZq4J3jzr6WBFrBjqQq+uAVOH7gyshdaSnOnpilUpH
 PmY08IG3O7eBnZMujryf72JqnpExJkGGmASuTMeXE8+DEVAK5ss6RefqxNqn/WaIgtA3iEMfF30
 8LJTOWtCX7RP9lbSOnQV3CmVmWDXdKL8fb/51BwiF7E2lWMnhWTQftMb2FXj+jT5YHkPJlI2dcb
 VJ8v671k/aRTMNSAeFDAdSJXx+hkXwiM6srnnrxVoi2tRXO+1E+M4rGzLc/UfsobiUcDeXFu
X-Proofpoint-ORIG-GUID: VEGO7iLn5LolLWXAj4QvEvzNXEs5D5VZ
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

On 6/11/2025 8:08 AM, Fabiano Rosas wrote:
> Jaehoon Kim <jhkim@linux.ibm.com> writes:
> 
> Hi,
> 
> These patches should be the other way around, first add the support,
> then add the test.
> 
>> When the source VM attempts to connect to the destination VM's Unix
>> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
>> occur if the socket file isn't ready. This can lead to connection
>> failures when running tests.
>>
>> This patch creates and listens on the socket in advance, and passes the
>> pre-listened FD directly. This avoids timing issues and improves the
>> reliability of CPR tests.
>>
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> ---
>>   tests/qtest/migration/cpr-tests.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 5536e14610..145860c24c 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -60,13 +60,12 @@ static void test_mode_transfer_common(bool incoming_defer)
>>       g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>>       g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>>       g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
>> +    g_autofree char *opts_target;
>>   
>>       const char *opts = "-machine aux-ram-share=on -nodefaults";
>>       g_autofree const char *cpr_channel = g_strdup_printf(
>>           "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>>           cpr_path);
>> -    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
>> -                                                   cpr_channel, opts);
>>   
>>       g_autofree char *connect_channels = g_strdup_printf(
>>           "[ { 'channel-type': 'main',"
>> @@ -75,6 +74,17 @@ static void test_mode_transfer_common(bool incoming_defer)
>>           "              'path': '%s' } } ]",
>>           mig_path);
>>   
>> +    /*
>> +     * Set up a UNIX domain socket for the CPR channel before
>> +     * launching the destination VM, to avoid timing issues
>> +     * during connection setup.
>> +     */
>> +    int cpr_sockfd = qtest_socket_server(cpr_path);
>> +    g_assert(cpr_sockfd >= 0);
>> +
>> +    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
>> +                                  "addr.type=fd,addr.str=%s %s",
>> +                                  g_strdup_printf("%d", cpr_sockfd), opts);
> 
> The sockfd string will leak.

Just use %d in the top-level printf:

     opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
                                   "addr.type=fd,addr.str=%d %s",
                                   cpr_sockfd, opts);

- Steve

> 
>>       MigrateCommon args = {
>>           .start.opts_source = opts,
>>           .start.opts_target = opts_target,



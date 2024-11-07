Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877F8D5D682
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 18:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t970S-0004XB-RL; Thu, 07 Nov 2024 13:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t970R-0004Wu-08
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 13:13:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t970O-0004s9-UY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 13:13:18 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBeti030818;
 Thu, 7 Nov 2024 18:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=KQTkHG4X7dHHNq5LC9ZC7CGXPL4Pkqmw+r5ogTgJvts=; b=
 WxxmkV2gcypnDJnXo5pAjZzCuPRq9vHzaLn7Row5yOTgT7vpLkcJ3zxPVahfnnbl
 MjKxzm/SlFHb8onfDjojdBfEjVnDDyH5oauc5HR/EEvE9QLTMrYveT52J7te3WjU
 j5PHtcgrjq5KPn60L6Si3Gj0PQ/88AbP9AiyPJ7VnAuP3X/20J9khxNdcktUvuOA
 UmLjYv/DnC6ZPvqJAwVe54B53ouri09jKQY56Ip/IjaL33obkDGV+j0UeaHRUhB5
 AOVq3l3LZZhwrwNsxTVUe3WR6ad/AoJ25yHKz3v9lKvIRau2fD+3d0NCQ4ICdYg+
 MBCCS08vpw+AKCkB40WLBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0ck8u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 18:13:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A7HpsKh039067; Thu, 7 Nov 2024 18:13:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahgqgsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 18:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy4gtgftg9ZtpUpWPKXw8AQpOQwv2uNrcv6fUaKHoPVa2cfIhtvppr06owQp/UmQ0QtNBjkXr4X0zdxWR2lNH3YzIvRJ+zm7u1aPK+KrZKUeTRoXEF5kTCLPHitYYgDwC3/5XMbMQiN/Oqp7sbbyWFlOmkdxLvJsPbH+lhSwKAh6BSU8VEjQe07UmuOYRPaAjYjSSEV5aEJZYhZcch1DNqAf7WtOlNYSYkgMxofnyj1IcgtshPByRk/C9Yy/8JyV7hVXfoooY8d/7tyPFXdCwG4GJW8wDPBj9cObPLW1S627In63vfo17FzO0kYEGLVYmfgBywmR08gnESPEbHipSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQTkHG4X7dHHNq5LC9ZC7CGXPL4Pkqmw+r5ogTgJvts=;
 b=EiISMxa6NczPUN5eFlB33kcgSa5TGdA+xuy9VVCQ1w2C6Q5zKpvCU1JeiY9cz9iSwpD0E4MzzqzprAZodHtGw4Z7qvKgKkBUaaQfp42b3L39vLOCQ4FnLC0CAnjOAqibWNgKq9DGcMptwGwaFuqz2OWVUNdoyXuyG9lfg6pH7yctcamdYhNV4z5rkzikfa62LptdOQ+R9JrZc/fHsoe85ATPdnAYQj/SPnajg2IgXpk3w3D7RGhlZEHrUboU9Evz5V6ExEW1fnZsxHPD01upFhXL0olBb5w3AJQ3UZ0wRMiCD+ewi5jrtjSgqUzadU/LnrOPEjRBY8kfnxGT9iEwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQTkHG4X7dHHNq5LC9ZC7CGXPL4Pkqmw+r5ogTgJvts=;
 b=N9kiHwFYEvli+ElfScUbPviFaIiccrjryp2ygfHyixklc4zAO8eG1bLpVeIFjARRL752eQyxzharsHngCtFnqXVAi5eqjzyIYS96tBJpiQtleJ7ZhUPGSl1iw26ucSdzXcQ4Pd5K2EovxHUlDtHv43XL9/wMoWqO2kwNtnDKoNg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7788.namprd10.prod.outlook.com (2603:10b6:a03:568::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 18:13:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 18:13:07 +0000
Message-ID: <ac2bc057-4a3f-4afc-b33b-c9a8ff3bdffa@oracle.com>
Date: Thu, 7 Nov 2024 13:13:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com> <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
 <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
 <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
 <715ddc40-dbce-434d-ab2c-4d4424561f37@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <715ddc40-dbce-434d-ab2c-4d4424561f37@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:408:e7::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4deca6-78bb-4e9f-ab4f-08dcff57d453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk1jWlplcnFrQ0owdUY3YUMxNnpuR1lvZ2UzSGI3VXVPWHQ0SmIvYWJuQlJv?=
 =?utf-8?B?VUs2N1J0cW02UzJhdnNLUE1OOXVWeE1pRmNYZFVMUXVSQnU4azZES0EvNWJq?=
 =?utf-8?B?U2ZodUtMM0RsR2VhcFh6Qk5BWmpSRWJ1dG5rRFN4WjhZRFQ2bXZGT0N5OEZ0?=
 =?utf-8?B?bFJqZXhGSUQwOFNUZWlLU1pkdUFSRjNwbStXa010bndqbGdjNUN3U0xJd3Qw?=
 =?utf-8?B?NUJLT0lNNE5GdGhNVi83QUZsR2QrNnVnNFFPTjZRWTU5cGppWkNWOVgwSUxC?=
 =?utf-8?B?cGlBRldqZTdEZ2d6LzJFODF2MmpCRFg4UXBoMmxMVGlUQ3A5Zi83WjRQclkv?=
 =?utf-8?B?aUlkSTl6Sm1qTFlRTWtVdlp6WVFaNFRkWEx0VHd2M1RlRHMza0JXTmhlUkQv?=
 =?utf-8?B?U0Q1VVY5aDFxSXpEMzNkR2psVEpZTGUwZVBLbGlnZkUwQkJnVURJM1k0a0xv?=
 =?utf-8?B?RlZjNXJNdWlrVGlGVVV0YnF1NmdsWTlySW43VkEwM0RzNzFuZXlCSGQ4QnBB?=
 =?utf-8?B?eUI5MTluUVJDT09YTmN2VjB0QWZ5UmVHeGs4RmF6djd1Vlc1MGdzS2w1RjhK?=
 =?utf-8?B?WlRyc0dEUjlBZGx3eUxUclZMZ0JpdnVxNEJlUG5ac3RpSGQ0Vm1HM3NhR3Br?=
 =?utf-8?B?R3VHYUpUdDFZN3hVdy82WlZIdnhNcUFUc2JxMk9NeS9XbjVHaFBOdnk2cnJK?=
 =?utf-8?B?ZHFuVkZOSGtwUExzbU9SbGY2MzRNQkVNb0dFenFTS2dkWndxTDU3Y0dSUGlF?=
 =?utf-8?B?c3k0ai91OHNDWUs1V2lPbjlndHZKbnVrNkswYy9NNi96V0NvdjEvTTRBZVNy?=
 =?utf-8?B?eHg0dHhmOUNac1ZOWEhWQWlMV0xweC9pRkZEZmxrb0c2OXcrYlJxWE5rVU51?=
 =?utf-8?B?b2ZoMXpiMkVqc0VhYVB2RlFlajlpMmNqa1ZyOG1hMlZ3MlJFM0dobFhKQkpz?=
 =?utf-8?B?dlhUVFFqaFVtUkYzRXd1ZlNFZnhUT2xYMHVBYS9aN2dOdXFFTC9NZlRJUnUy?=
 =?utf-8?B?d1E1YnhZUFE0OC9UemdIUkdyaHlQdFFXTkRyTUVwZ2lrUWxkNlZxcDg1K1BQ?=
 =?utf-8?B?TWN2bHpsV2xXOElDYjVxS1prM2pUdHNkdGV2L1I3T2R4OUtoSFlPNC9HcjdB?=
 =?utf-8?B?NlJlTXE2T1BIRmNkMnNxNlRkeVpldTNhTGNSMDJnZW5pNVJObEl2WVBpWXdJ?=
 =?utf-8?B?RFBzcnBJQUQxNXRVdm42eDZiN2xyS3lFMUhUNlVIQXN5RTAzR3dIM1JvelVO?=
 =?utf-8?B?SnlQdTFTTjRXSnpsOUx3SE1tMFJCQzhTVzBLS2hmTVJsanYrOEhiNHV4a3ZQ?=
 =?utf-8?B?eUVoekxCYmhaWXVqWnIrUUpsalpETHBXRmlRYUt4YVZycWpXNDJFVXRwZFVC?=
 =?utf-8?B?WGc1bDl3K1dWRFQ0VmRMNmtTTWwzeW9kdFRKdlpFRFhhZENBcnRJNldSWFZj?=
 =?utf-8?B?RTVYbFQxSjFySFBMQlcvNkR5TlpySlpoTFhFTFM2cTlzWkRQMXR3aFU3SEZa?=
 =?utf-8?B?OHUrVWNvVWtSTjVtUmxYbTA0RXJFR0JHSWhBT2VzMmlFU2VwbXIzNjlCYkpO?=
 =?utf-8?B?NlVtMkR4YTZhbmNmNVYxWnpoS3VVWEJpZ3ZiWDV3UUdCdzJ6d2ROQWpjZ0xB?=
 =?utf-8?B?VjFlSGtQM0Rua2FZeWEwSlRXZ3h0ZGFkRm5zNmRwenlLSWFxbm1VVGxMY2Jp?=
 =?utf-8?B?YU5oeVNpR0pLaWVYdkdkMTdNQlZZY0dDNzFoNVpESnMxZ25wZTY0S1lyYWpD?=
 =?utf-8?Q?BouoTU5RpCjgjxwZEtGpligcB/SeHN8FT9aQ5fa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21kR2cwQjFWV213UVA5a0JSZkVxT29ISW9Ld2R6aGRWMFFrOVVsZG1WWXNM?=
 =?utf-8?B?TzkybzFDUjJjdzJRMGdJRWM4b1BVRVVBWmE5U1RRelpseTdaTmNRTHpWS1NZ?=
 =?utf-8?B?T29yR0RXRy9xMU5nSW0rSkcveDV0VWhQa01aNjNIdjFOaTZTby9qakV4SVBH?=
 =?utf-8?B?ZTNNTThRVk5pVTE2eTJVbHhxRjc0N3FDN1p0Z2FZSXd5cW1GSnRtSEUwSzVD?=
 =?utf-8?B?VGVWdFk2cVBRWncrOXNMcG0zMHZmZmxNQ0xMeVpqcDk3OUxSV2F1bDNGZDdq?=
 =?utf-8?B?bVVLa0lMTUhaSCszTTlzTEhiUzYweGZWa2pHdXJQbFJZQ1h4L1FNeVE4Z24v?=
 =?utf-8?B?ejhzTmU1ZElMN0ozVGNtb2R6dHpidHBuUDlDeE1ORVZRNnltS1NPK2tMV1U3?=
 =?utf-8?B?dy8xTW12eUIzK0FsSGNTKy9xblVteDRaY3ZEYjdIS2MxOHp5TFFhQ2J3TVRo?=
 =?utf-8?B?dkRaUmtpRlM3aVQ1eWc5RHBBYUJZaUtQNW5RVDEyUkFZV3l2QzBsK2pSOWFj?=
 =?utf-8?B?SVhpeUtvUUlKRTMrUHhVMHJHSlVrNFMwNFkvOG5aL1FIaW83NWRJZWN0WXNy?=
 =?utf-8?B?WVMvdmx0U2JCOUMyZVZaeEhqVlpyNXEybVJaSndRMHlNaU5PT3RXQ2FOU09l?=
 =?utf-8?B?TGxyWW5LZGdQS3RjMHRRQXlDNWUwOXZuOEkxSGxLb2c1aXJhQmFLckpKTVAw?=
 =?utf-8?B?VFdad3ZxSWxZMUhPa3puamtPdC9pM3RSZjFhMml5QkUvekQ1eStwVEU3MlFU?=
 =?utf-8?B?dkFHZU1PS09yWlFjTEhVOEYxZ3hERXJxcG9XRHFCb003R1VTbllaMW5BZ2FI?=
 =?utf-8?B?anBaMXhQWmxLcTR0bENtdHRUZm94VlNUQTZVMFdiSEVhWlYzRzJIRmVySytI?=
 =?utf-8?B?NDhDNlN5RjZLK2dqL2R4dW45dTBHcWNEa3hrZHFyc0c5S2N1ODVjMGJiS1ZG?=
 =?utf-8?B?VEIrWW1JVnB6TG9kL2JucjZEdFRNYUd5WTA5bmNpQk5VVFk4TGF5d0p3dWpY?=
 =?utf-8?B?MC8vd0hqZkVrTGtDempieEpPdXl6VE50aVhCWXo5eTJTOFNEYUpmRFV6ZHV3?=
 =?utf-8?B?TGRKVFpnQXg2eThtQmNTRytoNDB2c2tlMDBlUy9UMXN6NFlVMWJTcWRsWlFm?=
 =?utf-8?B?WDIxa0g4S00yMmlTSm93bS9vcFdEa0JDZnpsRjJCaWFabXoxUlZsS2ZoYVUy?=
 =?utf-8?B?M1Bna1lmTE1uRnZpd25lY0E5bE5CaTlUMWJQT0dBTXVRUmpIcFAvN1BDeFB3?=
 =?utf-8?B?dW55aGRZczl4TW1FM1NOY1Y1cFVhODZwU0cyVk1PelFOVWkrcE1vWTYrQXVJ?=
 =?utf-8?B?enNPT0MybHJiZmllUjlqR3NUcHA4bXlzb29YRSszNklQSGE0cTE4TU9XRWM1?=
 =?utf-8?B?WWhWVFBsTW1FSzhDSW9PRmllcG1QM1h6aGJJLzVuZ0hqeC8zNmw5bFZZRjZJ?=
 =?utf-8?B?YnlVMWFDYVBIZ0pHdXlKaGZEc2FlbkxsWlN5cmNxSzBFSTFrNEVHMjYwSkU3?=
 =?utf-8?B?VVhoSUVsdnlLYlZiNkFWV3I0MEszTTA2VWxvNmNEeVJFR004VzM4MlEzUnZO?=
 =?utf-8?B?TVh2NC9EZzZXZjdGS3hxVURYbHZTQUpCdUtWemR5elIydERHcnBUbTMxTWsz?=
 =?utf-8?B?dkprUUdYcnJXYm9BcmNIeDdVelZIelRvSWpFL2Fab2E4VWZ2UGFUM0VLTkZt?=
 =?utf-8?B?R2xERTFqdC9OUW1zRnZlMDZJUnNJaHk2dzhkTGxtTmhFaU1iUVp2dkEzYmMv?=
 =?utf-8?B?OXMrR1NPVVFNQ0RhUGNaaDlYTG1RUTg3ZUlYblRHSGpPZkVvYkViWitCbG96?=
 =?utf-8?B?NGxJTnd3NUZkb0xOeTZxTk1DQWZYTnMrQUw5eVFHVmtQMnlOQ05lYnArNVlF?=
 =?utf-8?B?YU1wWXlCY1VYcXlkVGpRVWkzVUlYbWZqNjRYWS91RDRzbTNoNEl4WXhYZXo4?=
 =?utf-8?B?Q0FCa2lhY2R1Z1RaenNyQVZYU29hRmorUkdzZGF2Q3RvOHpZUjlrZTZmWVZh?=
 =?utf-8?B?bHNGN01rSzB5UTdOeW9tUkFUeUhFYzRZVFdMd3NXbnpxTUJtU3NyNFlkK0xQ?=
 =?utf-8?B?N0V1WklUeVdDOHVFeVFRdnN5UHlrc0dIV2tqbEJsWnJyMnNoMVIyM2xDSUQ2?=
 =?utf-8?B?aEQwWlZoRFg4NHhGSEpoT3JJQnQ4cWRZNjBZNE5wYU1TWHRYaElEUGt3S1p4?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 28BPNl0xw58zMvEYwKlmIgCph8Hb9xhl/HTKV30qqEO8zfCs02LJ11xOWMlU1Q9b7W5l0EI6zMsFgZsITCcHkmjIG9b6x7e9s8ib2sw023vWblq00WR3LRyqP3xgswAzrv8msX0dvIQ9X/zBkgsmUJh9OYNvwYJR4MGFDqGo21aRX4YiQVUlqmQCShwdNTX6vvf+z7ibZFZ3XjiHRS55calmR5Lnwkc4T3bYZ8VFD05SxlasWhy/08xPFHXKKvGeVwuOjXg1LqnJOueGPL3h3piA5R9QFfT+iPFR7lsjcuRnOaQU9USwFOf9sow3SqLvwPsvqU7JolrbkjRTrrFUwQjSIKVuPHfYcxR2JTBt2j4Oj+JC0Wr+bwhnsmqqhhve6VhNCIdRSvNcTna++ghj8e4WHCZt8d0h4nzjiN6DXQ7ImkKUCQoBIes0e5+T/KBgmqoSQnAf34QrGQrW7dojfu1QTRZqehzFLa09a7Q/tr82YLV+X8D0cpYA3wcXbVjBHNwTtNaBIN6HKiUL9x5cu7199AgHgPnBqhzCEkURBpxHnkSV7M+v0j1luS0T7V/P3+MmWIU03FUldyPokGHBD5eKY8T5i8K+bTlpZCYDqmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4deca6-78bb-4e9f-ab4f-08dcff57d453
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:13:07.1238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSeev3WbeiHkoAzL5EKlbOlfT7SLYmxNAPTwYw0H6KbkE66nhveoQrG3YAdjjgMtl29mHjmcJqUeZljudk4edQKaVwlh65aarmOzHYp3PjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070142
X-Proofpoint-ORIG-GUID: KvZg9GTqbuJlJSh4ycj_n9WSsW_j-QTa
X-Proofpoint-GUID: KvZg9GTqbuJlJSh4ycj_n9WSsW_j-QTa
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/7/2024 11:19 AM, David Hildenbrand wrote:
> On 07.11.24 15:04, Steven Sistare wrote:
>> On 11/7/2024 8:05 AM, David Hildenbrand wrote:
[...]
>> Do you plan to submit the part of your "tmp" patch that refactors
>> shm_backend_memory_alloc and defines qemu_shm_alloc?  If you want,
>> I could include it in my series, with your Signed-off-by.
> 
> My patch went a bit too far I think. And would not work on win32 :)
> 
> We should probably start with this:
> 
> From 124920aeda2756faa104bfa6e934c7c20b1fbbe9 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Mon, 4 Nov 2024 11:29:22 +0100
> Subject: [PATCH] backends/hostmem-shm: factor out allocation of "anonymous
>  shared memory with an fd"
> 
> Let's factor it out so we can reuse it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  backends/hostmem-shm.c | 45 ++++-------------------------------
>  include/qemu/osdep.h   |  1 +
>  system/physmem.c       |  2 +-
>  util/oslib-posix.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
>  util/oslib-win32.c     |  6 +++++
>  5 files changed, 65 insertions(+), 42 deletions(-) 
[...]

Thanks, I see what you fixed.

FYI I deleted this remnant from "tmp":

 > @@ -2089,7 +2089,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 >       new_block->page_size = qemu_real_host_page_size();
 >       new_block->host = host;
 >       new_block->flags = ram_flags;
 > -    ram_block_add(new_block, &local_err);
 > +

and I added this so all programs that link with libqemuutil also link with
rt, which defines shm_open:

diff --git a/meson.build b/meson.build
index e324c49..aa54535 100644
--- a/meson.build
+++ b/meson.build
@@ -3604,9 +3604,13 @@ libqemuutil = static_library('qemuutil',
                               build_by_default: false,
                               sources: util_ss.sources() + stub_ss.sources() + genh,
                               dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc])
+qemuutil_deps = [event_loop_base]
+if host_os != 'windows'
+  qemuutil_deps += [rt]
+endif
  qemuutil = declare_dependency(link_with: libqemuutil,
                                sources: genh + version_res,
-                              dependencies: [event_loop_base])
+                              dependencies: qemuutil_deps)

- Steve



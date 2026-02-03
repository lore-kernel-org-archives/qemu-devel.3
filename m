Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4ACE8B36C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 21:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnON5-0000hU-Fn; Tue, 03 Feb 2026 16:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vnKEp-0002kY-0M
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:30:55 -0500
Received: from mail-eastusazon11012050.outbound.protection.outlook.com
 ([52.101.53.50] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vnKEn-0006yH-9K
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:30:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCCAyDsAeTCYLEG7WHYR5y1SHcR6VWAdB2K71OrQEV3PwaNqEaDiZ9RP3CV9pNTkmRoS0pXcR9tShdwpbne5fauZXBcHvI0ku01tSvAAh5DqQk4DYWkoOz8gi39F4d8An9o+8KYGKzMrSLnrc2QFcgs9CWDOfvvGLI507RR7NuEFPQj1tLxAyjgJf1YpKfp+kRjBYhMVAa0WtUC0r3AP30mBwgrIESUE3IOPTJq1D9AUvCmLK5jjhCywVrLEc8b8KL9jYzbzNMxGpyYdA0vYnQtQVJywA3Cdhmcca3i3vt0T88U58jJcAmhJvu2IobhXMZEhs3/L0ft6G2PQdkV+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAGkPrKh7doa6Q2WIGExi8KF0LLaOLSawydPuKFj/40=;
 b=PEXARNhb5qwuMrVKenR/HIXD2NMU3uHjvaTPVDMqwtux+t+s9OKrONe0s0ePCEmIV+aUuO1lJWbC6Gx1RfNLHDIsrUK9UuDj9/UrbeqjWxXDZM/kM5UAvIek3L2kAI502e70bUja5xgUDt2r2k+DfeThnCibRA57W2WhaDiDTYyqmPxAGaV6KTKKA9fl692VxUrB2kQaUSjaA8LSkTTfymKs7b8S3E1wKyXWJg3ew0QP5ZsQsG/s8a82j1/GLdd/e8/8OObhUWaHKqadhEsGU54/S8Czc0q+w7aqFlENMVgHt1LIQyqLt97i5yrafAe9CyMzplMvwmy+sQ442Zc28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAGkPrKh7doa6Q2WIGExi8KF0LLaOLSawydPuKFj/40=;
 b=En0dOwJHcyYK7I0+tGe9AQFhEFsDZ5Vn4YkbCuEKuWXwuLhGp0QMwfk5OSiOcgEpw1GozBJqEVkcAgQm1ImawHAvPtGbWfneZcd7J4zpO9vatSgC0Hs9cbVpGvY4mvehOM7lQV+g9ki/gaeGThLYHJqGKtEoM4WYqWnsrIpUG9r64cmka2V37mmLb4tNDXwJEHAh8G9bHZKe6+TkVRlTyTRJoRm+/3bggzoRSmHFgDLKE9+LF1RdSikZjN0AKxEBcsaoCb/PMK9NaPa26SrXqNeLF0h2PEOSAXU6lSEhTTxoxnWCi5LWaLZ/l8e2IT43df5YjhL8HgJ00khC6yN/vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 17:25:45 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Tue, 3 Feb 2026
 17:25:45 +0000
Message-ID: <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
Date: Tue, 3 Feb 2026 19:25:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aYIqDAdld4a41VDy@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: b01cead8-a1a8-40e8-d646-08de63494384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmJDMEdDV1lvSFBmQ2VzMkZNRE1iWWhNb3NNOEhsWWVIZHlILzFHVHl4TDVM?=
 =?utf-8?B?MGJtRUNPK01rNlZaNWFEYis4em14L3o4OW53WWFlMmpJaHNqY3VUdXlHU1Vp?=
 =?utf-8?B?WUZDc3E4MHVubWZ0TmJWZ2lUei94QUpGQTN6WVdtS2VFUno1VFpYemNxK2k4?=
 =?utf-8?B?N3N1SFo0dEFNaGZiUWVLcnZ4QXZ1anZPV0loYVplTlM0eGoxV1VYMEdTTU1T?=
 =?utf-8?B?OU1rTUJPdWJKK3ROLzR1WTFoM21NQVJ5WW12eVBMZmRRZDZMOUNKT3M0OUoz?=
 =?utf-8?B?emdZekhNUytESSt0QjVCeHpqMk16OTc5OFNXNTU5VkVmMFdnb2VsOTdXc3F3?=
 =?utf-8?B?WHVyR1krQ1ZjSG12TU9VdzNxWWlQWVc5UjVNYzh2TVc5Uldkd3duRHlQZ1By?=
 =?utf-8?B?NW4xR00yMEwyQ25VeWlMMDg0aXJ5d0ZpdnU3bk82YkZ4WG0ybi9RL0ErR1dp?=
 =?utf-8?B?VXpia0M2UldVL281bDRLelcwZWxZN280ejlVZlBVVUw0UG05bWxCMEd1cHVa?=
 =?utf-8?B?d2YyL1ZRRjR3bkR4aUNWckdPSXJmbHJhZ0lWeTkvVkoxeUJvQjR2cXVObkxI?=
 =?utf-8?B?NVZRMTBnOVYzSkRBcURWTUE2MlorNmRuYmVOSGtzU0RTdXpBVEZmaFdtTXU4?=
 =?utf-8?B?dWpRVlkrQ0V1RW1sUmIwenB6cHErK0JhZU0yUktOT1BHOUpzUjQzMzIvSVpV?=
 =?utf-8?B?Q3J5T2lEYnIwZVlsZGVBa3lHQk1zcHhWV2dqU0tOZlBBMFR3Qkc0c2VpNjJO?=
 =?utf-8?B?Yld1R0FnSDhsaDB0dUV1enlocW1oSnBWUXgwWStaSnBiQjRJR09uWWg4NVVJ?=
 =?utf-8?B?dHg5aDN2UVdZVGpCT1M2dmdqQW93WFVITkJqQkRoSjdqK1c3RFVpR0p6RGtH?=
 =?utf-8?B?SjVBaTVlTzV4Y2Vab3hINkdpYUdMbGZvN3pkV3AwK3dXRldhNmFMTDZ5NkpL?=
 =?utf-8?B?QnZVZUZlOVI1K1F5d25kWVpIdnVuaVNGRkkya2ErcktWajZ6bnJVOWpuVjRq?=
 =?utf-8?B?T0w0S2wyMk1tYmxFTjUvZkoyWCtkOE1Qazc3K2kzS1E1OHkwcVJsN0gyS2V5?=
 =?utf-8?B?MFl3Ritjb0QwQXQ0V1NHZjRUenFzWVk0dFRPZzFWVitPV2VTQkNVVkpHYTJC?=
 =?utf-8?B?V0loSmlNc1dZc0hmK1RTU05rOVpBc1BGZTQyaStMZGJORUdKT2Q3RE1CenFm?=
 =?utf-8?B?WkxUL2taeHlFQ01uaVVMUXlNdytNM1lFVlhOSlFnQnppOVNXb2g4bmxIN0k0?=
 =?utf-8?B?NzUzMFZ3cVBGS3lZSlNXbnY5aE1mdDdQcUR3TFVZSnN5K2tpRmtIK1NkNUZ0?=
 =?utf-8?B?bzRUbjV6RE5EQ3g4bitJR2JCblloK0ZzY1dIb3FMTzNSaWxkZlJWY0RSMjVv?=
 =?utf-8?B?ZkR1RFlrOXJ4UGt3OUZ5QnpPVTJWMXYwT0FQVzZvRC9LMzdYV3Y0NlZPSmx5?=
 =?utf-8?B?QkFZNFU2cnZLcnlraXBwVzNGUWkvTW9NcGl4ZHlWS2dOYnlpY01nUXpwRnpa?=
 =?utf-8?B?OFVlcjZtUUFwMi9rdWtvTnhZMFRQaE96aEtFQmNOSnJyeFptYXZScVlKQUJy?=
 =?utf-8?B?bGFZTVZpS0Z5ZEdTL1ZWK3UxZ2FmRGVzODVZdk9pdHR2M0IvczVKRTVUNnky?=
 =?utf-8?B?MmtxZDdaQkxaU0s0VlpsNjdTUmN2MlpRdWphTmNYY0pSMVVBaWtTTm4zbmVi?=
 =?utf-8?B?eGgyUkZmc1hKeGpoVnk1TS9iUnZEenlmc3MzWE9mMHovL2pyYitmUnBsMmQ4?=
 =?utf-8?B?cVJHZWMzMkJBVlBqb2hSK2lSMUFWaHUrNUN3a2dzaUZmUUZ3NmgrdnRuOUs0?=
 =?utf-8?B?b3RYVVNGd2I1QVhUclVDRy91eTBPWEV2TzBDd1NjZnBYdHFINVEvYjZnQWlC?=
 =?utf-8?B?ankxQmtMUWp2NUVhRVZlVlRtTXJMOFBhMXB3Z1M5clVFQ0JuN0ZJVDkzZHdC?=
 =?utf-8?B?aGY0cWFhNWlHVG5uVGxGY0VpMXQ2TlZZRnFMSGVUd3hDQmNhdkEwR2dYWmlR?=
 =?utf-8?B?bWZTUUVPL1ZOdFErV3VVd3EwRHk0RE9CdmdGZUFvRGUxNnJRYTZaQ01NWFU2?=
 =?utf-8?B?eHBuWnN5NDhOdWNwWnZudGV2dEthMUxsTmRJYWdsYmFUck5rWFNQalJKZ3FG?=
 =?utf-8?Q?tdt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGhjOEdMazR3c3B3aXlXYjR2N3ZPc0JVTGs5OUdUbmc5OURRSWJRZHh3THg2?=
 =?utf-8?B?UHFuKzhaMGV2ODYzbEhLVTV3NFI0OXNCYmVVVjdYUE10c0MySWt3Y2tIeWtw?=
 =?utf-8?B?bzN2WCtUQUxyU250d2c3c1RHeS9kSUVxY3ZFeGlrNG5aN3NhOHpudFFOdjZV?=
 =?utf-8?B?ekFnMzlBc01Pdis2OW5SdW5mcys0SS9WT2Jzbk1QOUo5eS92VHYyRDdLS3Rw?=
 =?utf-8?B?bUIrNkd2T1lsSTdYS3E5UVpGT1lERU9lSHJmQUw2Ris3Mk5qWTNpcldiRU4v?=
 =?utf-8?B?bktrSUFJQ1hxNlB4ZjNvOFRYOXl2WEg1SUYzejV0b0pKN0wwMW10OUQyWWYy?=
 =?utf-8?B?UHRyZnpRRnhkSTBaS1lqb0lyYUtLUXI1Qkx0NWcyZWhCTVR3TUR6ejEzVDB3?=
 =?utf-8?B?L2dRcm41QzFvNGNMNmdkOWdBYmZza3hYSE5jb3Ivd1BnM0d4UlhKWnBFOU80?=
 =?utf-8?B?UW84Sm9DcGw0OGk0ZnhLLzRSbU5RZ3VOOWN6dk9LR3dtbjBielZGNHQvRWtR?=
 =?utf-8?B?TG5HMEd2WWkreFNHM0NSV203RkRJbVYwazd5U2xNZjlQaWo2NXM2Ym9RTjg2?=
 =?utf-8?B?ZmRWOWpsNXNZODhWa1lQUitsTkc1d21zSUl1MGpFOHRLdTZiM2lBWFJxMDdF?=
 =?utf-8?B?cnZxSS85TFZpdFYrcGJ0Z24rNzNVYWQwMW5va0JXeVd5eGx5TEFncVIwZXJu?=
 =?utf-8?B?aGdpT2JEcFV5S2pQbXZnRzk1Y1JKelo5ckVkcEVaK2RvRlB1Rm8vZmYyZ3Bx?=
 =?utf-8?B?NHRHSGZUU3kzSGtwemtEOHBnbEVZWGpNRkhoWVFxRG1VaTFFNGtkNkR6RVBY?=
 =?utf-8?B?UkhmMnRFVVBzY2tlU25Da1RlaGJGb2pWWUJKMXdmVVVPaW42R3NkKzVXNXZ5?=
 =?utf-8?B?elAzMEVuVGxZUU9mQ3gzbHc3MkRtc00rWkJTMEx0RUluZDc2aHNzK2thTHAw?=
 =?utf-8?B?VEJMcmVSbWlaajBUVzZyLzE1ZWhhbzJBTUpjMW9kbmhXUFBoWTl2K2RGOTJG?=
 =?utf-8?B?NitLN2VqZUtLMitlTUtVNkdIbDR5NkhRNlc1SlJYM01RdWo1YmM5YWZYQndL?=
 =?utf-8?B?bWoyMnZ4eTdwVWN4TUdPYy95QlExZnFiNnhuY3JlMUUwUmxQa0xpSXdGMDdJ?=
 =?utf-8?B?VmNqVm8yUGVyWkRNWTZRaUEwN0doQ3R1QmlTQmJnYkk3VFRsTHNKK1hBM1VE?=
 =?utf-8?B?R1dhL2ZOY2RZTEltWmxTUXFmeS9tV2dyUFdaWU9vNmZlMnpEclYvMDJvdE1D?=
 =?utf-8?B?K0xmVFo2REpWdEd6ZnNvZE5Ec2pCK2xVdFVJZENhN3N0UTQ2NzdMUEswaDRm?=
 =?utf-8?B?ZWp5WjM0ZjNsMDNyWmYvS0RWNXdQNkl2dHFnSU01YS9mY1FMNjc4RFVtY1Zj?=
 =?utf-8?B?RjgrMWRlWkNILzI1SVAxM1NxSFRtenMycU5hdTR5Um85WVVUSnNlT0gzd0VZ?=
 =?utf-8?B?SzVCYXFkVWRnRWI0L09xUGxSRHFKN1huNmFkOENJUTdTK09LbmUxaGpJaG05?=
 =?utf-8?B?WndMZ3lKOWlEajhxNC8yM1Z6WFF0Z09kRXJ4cEVEdFdMR3pHQWdsRjk2ZitG?=
 =?utf-8?B?Y1E1dk9IRFNkZ09qdEhBTjdmTzhKUU1iNnFiTnplY1lHZjhDNDhXcDZOaFBC?=
 =?utf-8?B?UkV6d0s3VjZmSExqL2JGY2liZjVPRDNQckdrR1lJYklNWXVvSDBjY2xqeG5J?=
 =?utf-8?B?cE9FSkJXRDVKbEdYTkdmZmp1S2ZidzA4eVpWeFpETzk4VHVuNnZJa01Gd0dV?=
 =?utf-8?B?c2M2Z1NhbkE1Z1RBSzJXTGw3U21BaVlJZU1qMEEwQmw3ZGRmZlUrM0xHU0l5?=
 =?utf-8?B?eWpucGNWRzI3UjlaZzQvTHJHUCs1U0RIYzU3Zkc2YUtMbDhiUGtQdEFac3JH?=
 =?utf-8?B?M2hLTnN1TVR2eXRBK3RLcXhkeFRKUlNLakFQem9saXN4WVBKSVVQaDJMMm5h?=
 =?utf-8?B?VGxpLzVPNnZVUzJMZW5BeStQdml4TmZ0dHp4YU1MT0t1c0xqcW96T1V4djE3?=
 =?utf-8?B?SmZEQ0pJR2dIYkthYjF1NnlTbnBqWTE0NXpjQm5Od0ttUHdFcHBLNjF6WUpm?=
 =?utf-8?B?Q09pZDJkZ09rUzRHV05OblI0UnFSYUtUY2k3T3FkaHFGU3lyQS9Zb0tWV0Y5?=
 =?utf-8?B?Vmx3eXNiZ1dQTDVtYmNEcFVBdVRWVjJvRDZqLzNyQUNSYUtTSGlPZEs4ZFhl?=
 =?utf-8?B?TzFkRm5JWDlCb3E2OHZQVnpEMTJRY1kveXltWnFSNzE0aHpYbVltZDZPenJk?=
 =?utf-8?B?aUFTVEZTdm4wUk01d3Zsdm80ZklaMU8rcCtiek9zZ1VYR1pRMHdjcGVHcHNQ?=
 =?utf-8?B?M2w1dGNEc2YwWndHWUYyenVHbGtRQVdIbDkyT2JuTXJVSUdrSjU5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01cead8-a1a8-40e8-d646-08de63494384
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:25:45.0956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwEcAmzJ4fzSNhFspqN1IK05XWPbQ8bY7KUHmfW2r6dwy+h9LzGFTVAjaoO4Kw5giNMt/WecRjQhUXgbDDatGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
Received-SPF: permerror client-ip=52.101.53.50;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Feb 2026 16:55:42 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2/3/2026 7:02 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Feb 03, 2026 at 05:48:11PM +0100, Cédric Le Goater wrote:
>> Peter, Fabiano,
>>
>> Do you think it would be interesting to send VFIO migration events
>> by default ?
> No objection here.
>
> IIUC it's a matter of why it got introduced with default off in the middle
> of 2024?  If it's about compatibility of any old mgmt which may be
> surprised by these events, then we want to know if they're ready, and then
> if we need a compat field for it in older machine types (or enable it even
> with old machines).

I disabled it by default back then because it was only needed for the 
use case I mentioned here (specifically, it wasn't needed by libvirt).

I guess you can either leave it as is or enable it by default, it won't 
matter.

Thanks.



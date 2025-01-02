Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A729E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 20:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRSR-0002UC-A4; Thu, 02 Jan 2025 15:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTRSK-0002TT-Fg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:06:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTRSI-0008Gq-Lh
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:06:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502JTYl1016388;
 Thu, 2 Jan 2025 20:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=WtDq6chPGktxN3xtQPFlkMsYgQXUN6iDFF7ZpOC7LF0=; b=
 GPULZAnmidfPwOhLXVr+odc2Lpr2DVCo1jicRoJTqGTfGDudyq0VwAbaCXw4j/Lj
 BnjaX8eosi9yQm+hY0ti1M2wBltKPWalfhrx4Jccb/UFHkuMFRm1VQ4Lx+bjLyPF
 5P+Iumy1z+luLKkJePjuH8s1aUfS3XOgp/J+2tpP1MBarnB6UaHvpGg+Vy09ZoK5
 kyM640TMIXfj1uV/1qNNN0EtQznV4jS/slUwVqAPk0FIixuXlOklKagD3CCtH9dJ
 EA+a9aajWCyTmlgRVG3eI/JFq2cXCPJerm2Z6uU5esFJVFL99oxxWBQnpkRp0U7x
 ajJK0dqhugnTN5xbXkhAAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978q18y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 20:06:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502Io6LQ008791; Thu, 2 Jan 2025 20:06:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s8yuca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 20:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lakVEJfVt6hbifE7x8VV4D0Ww8itCs9QYxOz9PZ77brrXGIUy82tbVhXhb6sBouA2lvJg6g6CBu7yhXuAgWAZfPEtwqCU6OlSjhJfCF+5sz+EoEPUJ3rpxOuMigPc2XRoTg3ABy3eglOdmYTrXdJHQdU2DZ7NwEFMNkuxBzL8kXkVKJbaOm7FX6KXz9m/66QIabiNdc2rt88NCeaaqAhm9O09FqSUZhitD2yKbsPuYKkTJOKr4fYqhQXWek9qKEnX2SEkx3gMkyOfZK1JVnOzyQJSoeZrmTm9vFMf9Zmvb6EGPxr6ykWUh8tRAiVS9ndmsKklL7bq7ioT46mFLpuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtDq6chPGktxN3xtQPFlkMsYgQXUN6iDFF7ZpOC7LF0=;
 b=YAAixXab3hms65rsJDxH9DrkSMVYqBtggmOSWGQD1ZJbzEn4EKFXnZCp4C0oAgSZYVaelyMeVbaFhsen9J71rh42YMigShBlh4NjU0buMnzpqM++zkSekEIHfhaMnWQuUZEEVfziVO1pBwqhEZ1iz9QELpdPZ9cXpWxFNqkWlZDOQq/5aO/esC0YwJz7o+peey7XxVZd1kQ8xQkv8f1h9r5aq/ANo3wUS3w+TwrQwgNll8BkbD4+zOKn0YKvGCMqDbKOzX+36hnWz1SzzAikiKbAz7c0Tt9gTWbZ7KPaiY8uiMG9O6Adw8o79MtFHX1D1wbBO04TLWD04VthXTubWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtDq6chPGktxN3xtQPFlkMsYgQXUN6iDFF7ZpOC7LF0=;
 b=kn2E4YaqlslhWyrPmOy0wAv7AYoLLACnGtE64wp/YtNaaI0YdpUIw7f81XJtIgM646XdZtnbp4zgIs1aZA+T7aq/zNTvzx3Shkmeh6L6Lhj6rccaFALMpv2eIe6fZtAjCh5ZY7qkRmVnpDtzMybHJEuEKJKtNr2P3TXs1M1MbUg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 20:05:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 20:05:54 +0000
Message-ID: <ae7170d2-38fd-48e6-8a4c-52670d56e13d@oracle.com>
Date: Thu, 2 Jan 2025 15:05:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <Z2sKXAgsUW3A8ajg@x1n> <72eaea07-ccfc-4134-84c5-1bc044f7ddae@oracle.com>
 <Z3bvnlQ955dWzc-n@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z3bvnlQ955dWzc-n@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0780.namprd03.prod.outlook.com
 (2603:10b6:408:13a::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: c00a9e7a-3c3e-4c19-3d91-08dd2b68dd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjliYXlhQVE1VUJoa3hOWS9kTS84M3ZpblR0S2F0UXlML20yZlhpTkt3Qi9r?=
 =?utf-8?B?QUl6VWNabW84UU5qWGhUMU02TzIxS1dXRzVISExZMXp1RkF5aDRUdnNaY3VV?=
 =?utf-8?B?WHdXS2x0MStoVGpkQ3ZCUTlEOWVTaDg0ZUpnOWtqMFFOYnhOQm1HazQ4S0hv?=
 =?utf-8?B?WWUzbUM3UHhwWkozM3UwaTd0d0JST2w0MjdQU2l4VE9SQm5SMkZqYy9YeTJB?=
 =?utf-8?B?MzZXakkyNUhIbC9VUFBFcUZzV1RXSjU2a1BHblJkWU9sV0xLWUtyUlVkRDQ4?=
 =?utf-8?B?REd5L3cxTFYzNk5UQzFUZjhZcVhJQkhicWc0SHZGbHJpbzFDWWFQM0tIT0lM?=
 =?utf-8?B?eEdEVGpVU3dKblVxVUNrcHJpMUlEQXhMcGZvdWhZN2lBRWNIQmZLZXpIcFF1?=
 =?utf-8?B?ZnpTdUwyVGhINk9UTEJWZDYwOUZybFg3bStSc2Z0aVlSSW5yZ2c1TnBkOXdi?=
 =?utf-8?B?OEJkeG8rVExZZXdjcW4zL3ppTkpTTENmeWRQSUxJVE5NS2pnVG5vUzYvdnMx?=
 =?utf-8?B?TmdTVEZxakNMdFNsbzVkYlVza1hMcFpBTUpZamtLMXRLWkxqdEtvSEhKYWNs?=
 =?utf-8?B?elU5K3NiTW5yQngxNEZsVVpsOVozdUpvbFJZUWNTZHNiSFRKLzlNMGNZc3Iz?=
 =?utf-8?B?N3Z3ZG9DbHp4UENLaVVxajRmdjE0V1JNSmFWR0ZFQU5PbXJlY0ZHY1FnbmxY?=
 =?utf-8?B?cHdtcEhQSHFvaHRnQStIQzRDTW03cG1pQVVCMGlmUFVWc09xQzdsUUd0ZmVy?=
 =?utf-8?B?WkNBNmFHWnJBSEtEOUUwdjhNQ0pOK3NCVktRSmxHWWdRTlRmbjZpaGhqZVlQ?=
 =?utf-8?B?Ymw2Rk5JY1FacnV6RlRoSi9QMllUeGpxQTBnanNaWW5RdU4yZzRRbWVHcE9i?=
 =?utf-8?B?eUdyOXo2d1dVWU1MYjl3Q1VYM0Rhc05NZnBFU1VHT3pZMEJhcGMxZ1M2eEh3?=
 =?utf-8?B?VzlsTStCTmt1M2xoNlIrczRzVHlycTFVRjN2eDh1WWN3WWRJQUZSMkZpWUs1?=
 =?utf-8?B?RzJ6U1NqMk1pVnVMekIxUForSEdlcldKVjFlVk40dGQ3OG41SDNSVFgzQlor?=
 =?utf-8?B?ckgxajZ2dUVBcGxUUDB6WjlNbjJENHc3ZHdQVzJFcWxIbGp4a2ROOFRUZUE4?=
 =?utf-8?B?eVpoWk1wUnU2bHlRV0NHT2lxeEh2eXZNaERtb0M1TUM2SGh4QWZvZGRxOGVQ?=
 =?utf-8?B?K0VjU3pxN2Q0YmxnQWJscFNvcTU2VWJaekRjb1RkMERpeTNlM09XSTBqTzJR?=
 =?utf-8?B?b0lmaW5aTGMrTHpjMnAyYUVwT3hENGp1bEIrZkl5RVZwbGJsdk9tM0RRdnJm?=
 =?utf-8?B?S3BsME4xM2g5T3R2cHA1azRkT2ZndTFlSUxMaFNFVUhnU1dtMUpWTWJxdmxs?=
 =?utf-8?B?WTFpSDNuT2xQQ0Vud1NLcVdSQzIvMG5DZkhPaE9WSG0reGdZKzBidXI1VTRR?=
 =?utf-8?B?YzREQkhXWXFscFA0TEc0RDBHNXNGd2xGYnNIMUlEazlhN1d0Vk84REtrZE4w?=
 =?utf-8?B?bVdDRTJPQmN6a25ZVktvVi94NFVFKzQxc3k2N3hlNE1FdjMxSHVvQWpiOERR?=
 =?utf-8?B?cExmSzQxSlJBMk53QUxqbTJxT2EzeVhzdktoR0ZTa0ZCNWc3TnRkUWlUUXBG?=
 =?utf-8?B?NlBJc3cwdE15WnRPUVNjSUR4bUkvQS94R3F3MW9YUlVVOXlSZ1l2ZW1nNkg2?=
 =?utf-8?B?T3BlaHUxSklEM3hSa2tkSFlNektDSldBSkVPekxSRHpnbi92R1FsSlVxdlZx?=
 =?utf-8?B?Q2kvNHNrKzZ2YytDWTRBZTFXTDdPWEhpcURSVE9QQSs3VmV6alhPK1BKSTB0?=
 =?utf-8?B?WDRBZWVxSEd2ZGYzN2h2Tkg3UXRONnR3V0kxd3JQUDRBRGZPQi9jMnkxazRC?=
 =?utf-8?Q?URrx+eYoQeQ2J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVg5NkpRV0NUWkVtVDBBbzZrbkxzSVRkZlBUT1FieXUxcWd5OUpnN3FDb01I?=
 =?utf-8?B?cFdkVDVlZ0kzWkVGb2NUUFRrdTcvd2xBU2V5U1NMa2RxZjVyVnFiNkRMQU5H?=
 =?utf-8?B?L0FRakJ5NlA4ZFljL2l1VUVWMSt2YzNwdnZ1WkRrem10aG16Z0RBS1R6ckI1?=
 =?utf-8?B?UGFXR09Yb1ZIazRVVDhrYTA1V3JVQUdJWS9vVFZMY2tHRUk3MEMxR0VWTVZz?=
 =?utf-8?B?dDZoTzVSM2VwdUdIR1M0Wld4bmRTbk1oYUxoUWdTUXdEU3laL1RBSjlCSUVz?=
 =?utf-8?B?TzVSSXZnREtKZXlEN3dZL2hmNVpMSnJTTlFuelpCQzcxSzYzUzNaOUJFZi83?=
 =?utf-8?B?OGY2NHdsSEc0R2xLaGZ0TUJvVkRvalczaEJKN0JZek9HM0tENzZ0U1Uzc3dw?=
 =?utf-8?B?aTVmSHdpVWxiVnMxL2R5SnlkUFVxS2ZoaGtmUWhKK3pmQWRHWWNhbGRoRnM0?=
 =?utf-8?B?VXlmYy81MUhVSDdDa2tQSVlGVm85cWRiRU0wMWgyY0h3RWVIK01mSTdBV1l3?=
 =?utf-8?B?ZWc0RXhaS2U3SWNiUU1QUm1pbWZqdGx0SVZEaURFb21pL2VRMkJXbDJYLzRQ?=
 =?utf-8?B?d0xuVXJBRzdXVjlTWDRnbEJmbW8zSzlmYmpyK2p1dGJNMno1WnhJeU9VTkMz?=
 =?utf-8?B?VDdHdEZnSnhsTkRIRkFVNWxKT1FIU2wvWkFmemo5VDAyZHZ6NVl5MlNnS0Rh?=
 =?utf-8?B?bXdwUGt3VGFFMzR2TGlIY0lqWmNTNEJEdlQ3VTl4U0k4dXEySTBzWWNtd0lR?=
 =?utf-8?B?VCtQVGZQdVFhc3ZFSG5HZis5U1hxZXhjNTQvaWY0TVdzd1dOSGg2bzhMOGdk?=
 =?utf-8?B?Vy9sOTk0Rms1QjBsYjhnRGVjUi9oR2VZVG8zN1R2MGpYbEw1eTNLTHc4UzlK?=
 =?utf-8?B?NlNzaXJpVmlJS2tBQWdCUlRNVzVyOXBIdnQ3YXpDcDZ0TFluM3RiVlJTY3R1?=
 =?utf-8?B?SEQ2a1BUaGFGK1JHK2Zia1lLbDNWZndOanFoWlRWT2dydDdiSFVDWHdJd2Vh?=
 =?utf-8?B?R3V0bWRKeDE5NURYdExtMzNsRG8wYUJOcnpQTHZyQmJROVE4SFhQQkkzTE1E?=
 =?utf-8?B?MDlwMDZTWVBEcWJTSW1tSTIxY1JJeHg4SDdzUzNuRVJJOGM1Yy93dFBmWHVW?=
 =?utf-8?B?SXp4eE5OZTBOK2lpNjNDQWpwRkd1U0RBNHJkQkJ2cFNoZFJ2S2wxTEdtcktp?=
 =?utf-8?B?Wmc5OUg5M01ZeVJHME9FQlE2VW5qZWN6bXdzZ0FIeDYzaWVjWlJLdWlBSTM1?=
 =?utf-8?B?a1d2b3I0Z1FnWXljREJiWmR4dmtscERYbWNkRjhMV0lsMWthQVYxZGhaS1RE?=
 =?utf-8?B?Q0Zsa0VCNU1qbnBENUNpNUIwdUhpRkZhK1VGS3A2K2F6OVBzeXkrUm9FdmFG?=
 =?utf-8?B?QWh4OTBTYmZPUDBzWm1tendOOVFIc05SZXRBWHpKWlNFcUlWNUU4OGxXZ0hw?=
 =?utf-8?B?Ykc5ay9sUm9mNDJRTjZYdVdMOTkyYUkySmQzR0ZpNnFtMnB4RHdwRENibXg5?=
 =?utf-8?B?MWx5cklrOFFKUTAvTWNaNnhmOG5FQWlzdzNtVXRGZ29hcFBmTlQ4MERJbEFW?=
 =?utf-8?B?SXVYaDZ3QjlKZ3lGOGZodXdXQXRoenFrTGYzK0FBMU44MDZqNmx3b0RsTzFI?=
 =?utf-8?B?eVNLbThZTHlNZzNRSDBCaDBmOWlIY1dFTlVTUUlVWDh3N2gxd3pMcHF2Y3Jw?=
 =?utf-8?B?MDlBMXFVWHFWdlZHdFp5OUFvM0dXanJvVVNFOWdjSzdGekN1V3VFaE5NMzNm?=
 =?utf-8?B?YW1ickl5cUp4MkJYVXhHS1o5WUlweXQyRXpGL09KMVR0bWxUbEhwdXNCc2Yx?=
 =?utf-8?B?Z3R5dk9yYlNMN0F2TzBWSDNHM2VVMzhXek5xamxocjZKTGF5QUpJbW85a2FM?=
 =?utf-8?B?RGVVL3BkdElUUFVUUnBCV2xLZ3BUNjFBQnU4ZDE5dHlNM2lUK2hQY3dhZE9h?=
 =?utf-8?B?QjcyUDdEUEVlTmI2UzRrM29RaTN6K25iZDFhV09LSk9hYjBvS1JwMitOZWtE?=
 =?utf-8?B?UjU4b2JINEk4eGRyNHZhVXI3dTNZTTNtMWlZNFNsNXM2TWlGSXozNHBiZFMv?=
 =?utf-8?B?Wm42QlJIdlZKZ1lBRjFtRWtJVWxXcm1GV2ZVRTQzVTc3K0t5THpUR3NqcXRl?=
 =?utf-8?B?VU43NHBMNytCREs0bVBiNlVyWThGNGFXZWJ5dW4rMmNCRDhlOWRBWDBCQTJj?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0ecKuldTewGYvNZxwN6gQcIDZsFGSjEfz+Twz/n8dZEb5xUUoGqznW31nM0OG9v/Gtk3q7r5v+7lT88Y/zngJJKJaTFV9y/n0reV5OoQX22SDXhx5majR64746X+/xZb6c50hoRZScblzxaDBtQLp9YkctKmdqBTD255kkv8tIRI2BJYuhbdfr36/bEDjNTuRYLGF2utAV8kc3GJsFWpI5gYvZ4e7GYORpoxkIfozHcrcxLvtf7sIqZCO37Z5iF3Un+KeMpe8bimaJLobcXH42hvrilT5z+T8BQuBUrBDgupxMp+HsRpeitxkmG9kErHi7r0Smic3i+9xS3rAKtLsIp6y6sxGO3OyWGBTxcFmgrx0fR9mmqfuZhavgI0pxSY8rDC67DhawsXIYhwz4glrqZpoLJiJor1PblXy9Yp/bd80p68UMvVEBQEn6ma3j663PC+s6M3OpbjgYsf3HWPs08xcL9FhTjfcKvdlY+8SXK+gndIBJGElxAwj1YAnn3P2399YGB4/WCkVJL+0Kom6sKrN2RK+nVJilZiFr71IW9l1BflJ4s7+GAFJXwntg9bnZOQ24PffpWvBUYUwKzRDZf1bcMm6efyxvXBmkLJnkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00a9e7a-3c3e-4c19-3d91-08dd2b68dd1e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:05:54.3755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXcNE6z8hsOOt3wVc8Uca6mCADeFJyuxEWRGN3Ea8fvdGrJOFp/GumFgML7UQdhLLSy75J/UdG8GEa8J5dG9QjRHcDB0lSBbpXC9Ynu03lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020175
X-Proofpoint-ORIG-GUID: 9HayqmQJ67IL0ajXkn7ywgI-rFrBVEsM
X-Proofpoint-GUID: 9HayqmQJ67IL0ajXkn7ywgI-rFrBVEsM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 1/2/2025 2:57 PM, Peter Xu wrote:
> On Thu, Jan 02, 2025 at 02:21:13PM -0500, Steven Sistare wrote:
>> On 12/24/2024 2:24 PM, Peter Xu wrote:
>>> On Tue, Dec 24, 2024 at 08:17:00AM -0800, Steve Sistare wrote:
>>>> Add the cpr-transfer migration mode, which allows the user to transfer
>>>> a guest to a new QEMU instance on the same host with minimal guest pause
>>>> time, by preserving guest RAM in place, albeit with new virtual addresses
>>>> in new QEMU, and by preserving device file descriptors.  Pages that were
>>>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>>>> descriptor of the device that locked them remains open.
>>>>
>>>> cpr-transfer preserves memory and devices descriptors by sending them to
>>>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>>>> be sent over the normal migration channel, because devices and backends
>>>> are created prior to reading the channel, so this mode sends CPR state
>>>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>>>> prior to creating devices or backends.  The user specifies the cpr channel
>>>> in the channel arguments on the outgoing side, and in a second -incoming
>>>> command-line parameter on the incoming side.
>>>>
>>>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>>>> which allows anonymous memory to be transferred in place to the new process
>>>> by transferring a memory descriptor for each ram block.  Memory-backend
>>>> objects must have the share=on attribute, but memory-backend-epc is not
>>>> supported.
>>>>
>>>> The user starts new QEMU on the same host as old QEMU, with command-line
>>>> arguments to create the same machine, plus the -incoming option for the
>>>> main migration channel, like normal live migration.  In addition, the user
>>>> adds a second -incoming option with channel type "cpr".  The CPR channel
>>>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>
>>>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>>>> a second migration channel of type "cpr" in the channels argument.
>>>> Old QEMU stops the VM, saves state to the migration channels, and enters
>>>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>>>> resumes.
>>>>
>>>> The implementation splits qmp_migrate into start and finish functions.
>>>> Start sends CPR state to new QEMU, which responds by closing the CPR
>>>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>>>> main migration channel.
>>>>
>>>> In summary, the usage is:
>>>>
>>>>     qemu-system-$arch -machine aux-ram-share=on ...
>>>>
>>>>     start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>>>
>>>>     Issue commands to old QEMU:
>>>>       migrate_set_parameter mode cpr-transfer
>>>>
>>>>       {"execute": "migrate", ...
>>>>           {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Feel free to take:
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> I still have a few trivial comments.
>>>
>>> [...]
>>>
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 87bcfdb..584b0b9 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -45,7 +45,7 @@ static const VMStateDescription vmstate_cpr_fd = {
>>>>            VMSTATE_UINT32(namelen, CprFd),
>>>>            VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>>>>            VMSTATE_INT32(id, CprFd),
>>>
>>> Could you remind me again on when id!=0 will start to be used?
>>
>> Each of vfio, iommufd, chardev, and tap will use id != 0.
> 
> I don't remember the details of the planned future series, but just to
> mention that using integer ID can be error prone on device hot plug/unplug.
> 
> QEMU has a known bug even now on some device (e.g. slirp network backends)
> that if the src QEMU originally has two devices (e.g. id=1,2), unplug
> device id=1 (leaving id=2), then migrate, it could fail seeing dest only
> has id=1 (dest QEMU starts with only one device), seeing a mismatched ID.
> 
> I recall PCIe frontend devices are not prone to such issue, that should
> depend on whoever has ->get_id() (qdev_get_dev_path?) properly implemented
> to generate a global unique ID that is not affected by order of device
> realized / created.
> 
> It could boil down to how the IDs are allocated, anything that can be
> allocated on the fly may not work well if there's no solid topology
> information to fetch.
> 
> I wonder if CPR can be prone to this too when using IDs, just FYI.  It
> might be a good idea if ID integers can be avoided somehow.  But you'll
> definitely have the best picture of the whole thing, so it may or may not
> apply.

Thanks for the thought, but I don't use such id's.
I use them for things like vfio interrupt index 0, 1, 2, etc.

- Steve



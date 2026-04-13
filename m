Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBE6EBFD2F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCE52-0003sz-1Q; Mon, 13 Apr 2026 05:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCE4y-0003sZ-Cz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:59:40 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCE4v-00033N-S2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idTcS8m6gvOP4UbM+blMa6cBWz28dU3k4uh6djevG95a1nuDU0gbzEVouHP6XYet6xMPe9imjpvR6c+i/Xu6vzz8ZisMyV9kbyION5e6l9QuLT8LofsvSxroIyoAAfrF76KFCabApXRtb+pO0SSfJeiOqD++46ZKgudgveZc1sqBHJlowt+72WHTWfqBQt/a+1eLMMUMlR/TzC5EjKIu0Lgz9zP5pqcbzYNwBSeqTwe8IuNl3w01sLvGTxvm8c44obnsB7wKyPUQmLce1rYurjm60Dyo00bAAjh796cGTMV7BrjqzTRry2VjiuMzNFC1HvcHjiFQiOxFtE6UJIeVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3VjBGi9/jAFcra/3KlJO1uzf3tt4B6/gLD4tsznKXc=;
 b=kEgbGACqqFB8t8EcsD2iN//7ua3u3dPUbjyYFc+KRk/DehURoAjhl+mf+6PBBMxcqqeES7KGueo5JivIBMJ/zrgExfToPAoeTRNum1SV/T7ya5cQwT6UzmC+hqgvuKhWax79gSTDjdRYLXntC8zpXkENjxQLtWIFEcYZoIo8fZ2X7jidEwNvjoz63jBBX7RnfNeTc+G2Hp6XtIJMVEIoc3lzc+/0Oo6je7ffkZ4Bc0Du1rg1Cyyig83CisTAe118ffwCXl0JROgee/rsHsItopw6lLna/ygtiP+NN8mJo1p2rzX9WGFhEM/lToYP2Wfq/44tbtA+kzuq2EyYKDg2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3VjBGi9/jAFcra/3KlJO1uzf3tt4B6/gLD4tsznKXc=;
 b=WncToKG7LGWbunPDUJED8TB7Om493mUsf9B8lLHpvrIlqv4LmVSV/V2nH24TLrvWzhS6YMtWu9dLkK51xCfFkZUoAvCK2ZtkKwCiXDUqg1FhQ4Z1htUzMwxbOzUWuaRqgUGuH6nyy4ANBUUos8jTMLTj2DcMILuPG3V3vgM0rsIcsPYR6I2iGhLzcvgKwrQR1r2hMH9uDx1fcQ1r9mJtENgkbAGWwY7k14A6WzHPZllqQ8cRKcodyupFpbYxsVXYVK2FU0zEIT1bAg+Lph7wJwr+T88BKx+4MYH42N+V32cb1N6Lm1+wHR3W7nY5SFwFRIIb7nsAIg2vklUw/5PPaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 09:59:28 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9818.014; Mon, 13 Apr 2026
 09:59:28 +0000
Message-ID: <c8f6e104-1346-48e0-bbb1-554c68e573c2@nvidia.com>
Date: Mon, 13 Apr 2026 12:59:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] migration: Use the new save_query_pending() API
 directly
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-6-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260408165559.157108-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffba8de-7e4b-4de8-704c-08de99435a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hemamWvQb1SiNxRTqhegKDy1D23xIwj9kvFClRHMNHy2ltddt6G7NXT3DAqPFB6aIX/sezdV45munIamLe4rNRH2SZPP/d4H8dAdaGx5D3cc3RjxR721v4nGZ5AO/KaPyQUpdq3BIMqbA255KkIwaTorOMWXN6TsrebLeQbZB6C7PQdpJWEOSPbQ9V8JBjvi+37tFLWHiN8T4HXMOljA383hube7m87ffHMn9pDUWgvlbuPOKnkFjPwguwf1/cY6IwafCxHc42B37eiM9WwfQ+CUM1Ra0n7j/2/nzR2ADFsMqTt0GSpyV6QIIq+0TnEjVWfy6q6NH+iW0dMgDQ0onFY5RLHPPhJITrp1zSHt9KAyEYmWiAcTr/lKhwuMGrB1n+1qwgNQk0FaL8mFdPrSophC+iEv9PptGJU4JpdFO9G6dS1NDRT9MkOUrmIcW5R/bZP0Wr8VD6k+wWfdiCkWYVsTEPdvjuSLZq9XUhXT2CkiKK5l4sX0sLX5KTK2QRuVY+TXQjEDBO4IYwYysjb928XFgYtbAPW++z3Mpzs2szYMhUR7VFWY+hOp2cEp+X1rWceNEs7X29o+/4KAQJZoa5vfyFi1Tc8Vn+L6jjmmWZMIn8dzgtY+dC/JXOGzeNem5rnWRO2UfvYHdwjD6v59qv1GFncX2GdmqZ5jPnmRUx8rR/QkznUfV3fxKpB0zRP+60Vyk04JlFc7MZqP3vjySu342omzrlcsAy16+SZRQ0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2QrYTJQNXRENDM5aGZKTnNzZW5Jd0NoeUVUbmI5ZzNwZGxSN2tDa0ZJTkNv?=
 =?utf-8?B?OTIwanVqM1BFSi9oWWVmMWZ2TDlvZHd0M1VVbGhtdzh0OUJ0VWYzUWJZSzRO?=
 =?utf-8?B?QlpNNldXWjUrNXhBWDVIaGdWbGZ2SzNXRTlWaWZmSVVsMFo3Y2M2QUovaFFX?=
 =?utf-8?B?Qmh5RnoxSjBHVy9hTFVrZ3JidkVOa2J1M294T2hrN2cwTTBIK1hXZnVBbzZq?=
 =?utf-8?B?TUxrZy9YV2FqS2tjVU1JUUtlN083OHJJT1dVMTJSM1BIaUlVRmx5M2lMRWow?=
 =?utf-8?B?YUpYTXd3cWwvak8yUnNpZUYxSnF3QnpZcUxxQWc4cEtDeWxEZU9kL2xzbXp1?=
 =?utf-8?B?QzExd3ZUNWQ5Z3R2SGlheGNwN0tUWUliMURCSHBvQjZKUGtJLzFlZlFrd1dt?=
 =?utf-8?B?ME1KRlFGVUwwSGVDb29VdnpBMHIzWnhFcWZVNEJTWTVXRHVNTE12T1lDSkI4?=
 =?utf-8?B?S3hiNXBmZEZ6TjJ0amVXZHIwSTBxY0RsVERCRmNRdXRPdlVVM3N3RC9RUVRL?=
 =?utf-8?B?SFgwMitzeTJaM3JQUWxvWXBGVmhPcVgzcHhYZmVZRGQxdGVlZG9RWW9sNU9q?=
 =?utf-8?B?QTdBN2tXdEZPYlFTZ0d2Rk42M0hwZkRxVFBJRmtNV1g2VzRESzJzTWlPUHFl?=
 =?utf-8?B?MnROa2h6dXg2SnhTbVRnVzJxeGFJZVF2b3F4VVZoK0lHRzlnZkxpUVpMRG12?=
 =?utf-8?B?dENJQk5HUjFNUnN2WWkyMXRPQ0lOS1gzWEtnUURXZ3dPN0drNUMrb2luTTVR?=
 =?utf-8?B?Z1h0SkNJcXhNbFpkUU9GaU4rQ0NzL3NET0o3aWNZSFUyZ0lFM0F0SVdRaFVW?=
 =?utf-8?B?TWw5L2tPSEtsaVI1OStNY1FUNnpPOEU4bkZvaEtlam9EZ3YvMWhDKytQS3Fq?=
 =?utf-8?B?MmRsRS8wdFVBRytBR3FEZFBSUndzQS9DMkVFUWRIV3diK3d4eVBwdkM0bGIw?=
 =?utf-8?B?bmRVQm1TTExzeERhTUhqU0JvS1dQaEFRdyt6SmcvcHZCY3VPOWZwb3RXTFl5?=
 =?utf-8?B?OHEvQlBlOGRuelNUK01xaHhHL2FCd2FSTm5YcitKRjBaMk1xV0NETkw5bGl4?=
 =?utf-8?B?N21rMGkrcXdpby8zck55ZUM3YWRwenNVTVQ5OXdNNHVXR0ZFQkF1QUxhUU51?=
 =?utf-8?B?ZVQ5a0FEWXcyYWVPTzVzSWFPcURadWJNa2UreHhoMUU2eE54cUxzTVRBR1lo?=
 =?utf-8?B?N1QxNWl3YUZKcWtKR2VPeTh4enpQbjViR2ZYL1RtUVoxWVNDVmM0ZzFpZTJJ?=
 =?utf-8?B?U3VpUEZhQUYrR1MrTmQ5WVRLTlZVYTFpWm1EN2ZZOGxJNlpqTUxVVVBGZnBM?=
 =?utf-8?B?d3ptdmZRbTl4MWx0eGVPYUMyZUk1SDZyTDhHRllRTFlxL2RHdGhxbVVQUkl2?=
 =?utf-8?B?SUErMW1jb0hUeDZSQVhUYm5HTkJqdFcwQmRnUnBPbXdhUEJzSnZEYkdNR3NT?=
 =?utf-8?B?UnE2K3ZSdkFhelBJWkZGUHdVNFdwVndhNU1RbmlZOSszdVRTSVhSYXQ3TzF0?=
 =?utf-8?B?QjRZTnpkdUMvYmFIRStLRUYyWmt3cnZaZmhhSHN5QWJzemNORS8zOGJnMDhp?=
 =?utf-8?B?ZG5ETzFjeEhYNjlydkdRQnVEcFFZRGdUcHhEdjZaUzB3Znc4VTNMeWx2U1R2?=
 =?utf-8?B?cTJhNUdOS2JZME51L2pLdS9jR2NOSnRDQkZSa01aV2NwbUphUVJLem9qZHh4?=
 =?utf-8?B?M0Y0UUJ5aUh2dUkwRTBQQUFiUitKbFFMNnBCU0VOdUJHSnZJYXh0VFE0MlZq?=
 =?utf-8?B?VGhFUzhYUmlEa05qaWxZNXBtcTRyd2FNVDZWaUMzOEJkNVZkOGZ2eXFxV1Av?=
 =?utf-8?B?a1l2VktGUHVLUUIrWWFJNktiNnBXMkhmVExzWjdOMVZYWDlNT21yVXVPdDYx?=
 =?utf-8?B?MGpVSEtGVjQzWTdDSGtDdmFvTDE2UmhZamlwVmVaWGZRR0hIeVhpUjJnQVJY?=
 =?utf-8?B?eWs1VkVOMURJdDZEdDJudkhSTnY0NU1TdXRURUpxZ05NcnI0VnI3ZE9EZGZH?=
 =?utf-8?B?NjNTajBPR2JGV0w0b1ZRTUdGd2JzNFlmcCtmdTRsM3UwQTlpYVNWVnVwTFlM?=
 =?utf-8?B?RDJnQVNETU1icmx6SnBETmVRam51Rnd0bEljbDBuNlZDdWY1TFZhMlM3R3FY?=
 =?utf-8?B?YjRhQW5oYklWTTJBMkhHN1Z1cHRGR2VrT3FvMUloa0d0MFFFNTNNSUVSZGYw?=
 =?utf-8?B?Q1RrdmFHd1pySENyY1RwR1IzbFFGelhjNGxPaFI1OGJHeEw4V2puQ3hFN0du?=
 =?utf-8?B?Ukh0c1JOMkkvamhta0JtTzdlMXpnWk9SOFNUSTNkaDJkSk9vYVQxWHYwOUIx?=
 =?utf-8?B?M0lNWTVqa0xDbkNiQktIM2JxTmkyNVZCcW85K1ZISFVBbHptUEJWdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffba8de-7e4b-4de8-704c-08de99435a00
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:59:28.7214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15FG+52BKRuQovv+YyBdQZT+TppOq3clAfKrDEVEl6lCR+5f3qJIXdo7aAEWHPeK7oQD/UfWWlBS1IAHNd7iSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


On 4/8/2026 7:55 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> It's easier to use the new API directly in the migration iterations.  This
> also paves way for follow up patches to add new data to report directly to
> the iterator function.
>
> When at it, merge the tracepoints too into one.
>
> No functional change intended.
>
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/savevm.h     |  4 ----
>   migration/migration.c  | 16 +++++++---------
>   migration/savevm.c     | 23 ++---------------------
>   migration/trace-events |  3 +--
>   4 files changed, 10 insertions(+), 36 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>



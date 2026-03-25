Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E231093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5P1f-0000Vr-19; Wed, 25 Mar 2026 10:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5P1c-0000Ve-H1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:16:00 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5P1a-0006Vo-NP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:16:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbdVHvL2yjoHbSuggWOX4dpnv2lmZt8AV4ak9Ds7f7XA4rSIb3zTbRPnHxGx/lHQ00KxTAgd9jmWR04uimK762DSWWpG4qLZZYjfYmdMORx2VY2TyvByfPJ8sP5ygrduRM6b3kT9hd/rdsH/rdw5Tir1aIviCQq4uYyRhKSO1GQgOUXAixPXP/8oETbu/Mbfq0fH26uYcJdzg6BcAlKten0GAw+ZP7n7hUqW8PmiabOKkRlgisXegr0H6yXN9Y3JiF1qMuu3xC21pRhfwlfkSdQNLmC/H+G4FmUDhp5hxktykoY5BCbVic5ht9c+yT8RXN5Z7R1/4zeJpz9MAioChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAevLbYE+RtQrQBZesVm8JdNZXPkB8mEwNUvP4GMuIk=;
 b=MpmUH8NiNUFq79Wl1/IMeR24rwyOqCrwum+UIVsg2lXJxFnI28CGsopgMT6XFac/kAGZfJZrFVz1u6FAlcLeye325Ri1RR1CPjFYpv4lJRz6t3pVbKrP7lTP1ENISSEFTHnDI8eOOSk5Z/KbDxlYX6lBAEl/qvddw4rLgcJnTxIGM+PIROUrv8aQ6e9DLz+V+mHsLs11v1FdTivq1VJYZsZ6q5NwzipSz/MhE42ikKCIkOCtjUCsXUzkx2MCf1tXjrnRR+GzYmQGrqHBP3gjdJkHUgOMykip2KjriWkc9nxoFXuJnG3a4j/LNjuQF+ylSXif5n0SZGKGxUKt77yBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAevLbYE+RtQrQBZesVm8JdNZXPkB8mEwNUvP4GMuIk=;
 b=lqUCmVAWUs8EwFVCj7Z6uGTkDVZmBb8BXxU6xr4vaYyA50X1wc2XFWCpNY16cEPLRxnP9mzBh09c5lyPvALUn6h/E8fdTsatW6E+p1hwtR9ISuijz1YaQqplKmMp6L0anCjnfPAaZIYIe10wrVOmJ7mRdXRxEQbvwjtQ54x0tfqkJYz0ZZgGc74++MMIO6sVZOwZelxOSgmC8W3Mvbig/9QJ6aZ1z2yzmfNIGPm8vT7zcO7ZbdsOm8Ky5zqfN8Q5mXjqPR+6PKHmocr1TaL8srhehGvedk44aEnRUSST34UIeLe/rUx4nP4sbdgWXNu3LTbGp8BTt54llDc+wsqEfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:15:52 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 14:15:51 +0000
Message-ID: <894ad48a-6779-41f7-bf9f-08008c8e4bde@nvidia.com>
Date: Wed, 25 Mar 2026 16:15:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/12] vfio/migration: Cache stop size in VFIOMigration
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-5-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260319231302.123135-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: b75fb09d-4a67-4a02-a933-08de8a7904ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: ZJWHkW7CzBkbPUCwvG99X43mmgSgA4M1JHAbZfVxdjjsegolf0HoEBFFGeCEj4OoNEW2/OFBbp0taMyAJ8iw7fPPZ5l/rvX4+AcAXNGbBuuxYviJQUKuou6i7pR+tI5mIlFGQs8tjB609rIQEjWafT5vHtD8mb+EKoPuWvzUOzlgliKqYa6vcPpzMBzsCT967g7yoM77MRzEiKucfozuzPMyyNqWQ+0Vz+xlT1+5ngrgBuJ0xnukNu2N58mNG79t60nYMyodxLqMkbx5spqeXM+JNDHzC/FYxbCd6guQbv5YCerfgaF7NxLkJRtVE8P87kF/jfMGZoPU+lqYbnXpoGXPIj7nV1fvQvlaHsGd6BSJAd+c7knVdSnH5UhHud/PXUkzrW/hAUiJ9epyTwukAys9noHBCXdeEU8t/n3wEnkl92sGiQwxB8kqq5010I3iBzQOl/S7wQxUp4G+mO/F1t2sfglwI1DHHsNCwi4Qqcutu/M1odgfuxPfdX5/yxza8sP8tj8s69ebPk9VdElWr0KYR2reYVtFyIc5Xc9w/j9N2E/aG3HaN8OsZ8zfv0UaurY9kB1Zp6q/6BAzFx19rzyq633WwBiqDex+A78fUydOmzQgolpqkWKTIX66jtKN0df4KZE+qT1n/39ZpoWOcljKdCdVDxu5XNbEZDD+EDK9JRJwroCJUZyhLmBaq+/oSRYJI84swQyI6qmqH077xO6ipaldRRHYoL+aVhv3Vfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9sT2FKT2JYL1BXNElNTnNJQVlpOVRQZEUvZVd3NmxVK011MnBCTmNpeUNX?=
 =?utf-8?B?T1Z4YXBaWmlRaS9zWnZuYVZqWHMvVFdDMzI2c1NuVjBwclN4VW41dThQVlVh?=
 =?utf-8?B?dFBRSWZ1cW85T1RSV3ArWmVYZEU5VVN5eGM2Z0ZBckQzVVE2SjUvYmpJSE1N?=
 =?utf-8?B?SVNWdlNGVzh6cnZYRWFxMEpRVnY3NUhNSWZPei9GaFNkcld3cVVCUkpBSEt5?=
 =?utf-8?B?bVFGU2dlNEEwNG12RGFNck54L0hQYkl3N3JWanZEcmZydUdIbTV3TTF0dGtF?=
 =?utf-8?B?MlRIcFRhY09hOGYrOFRrMXlDSkNldWJ5UE45d0xjWWdJcUlnR0VIMElPNER5?=
 =?utf-8?B?WXFYTVZMclJORGtuVzRpQ1hUOTE4ZnY5UllaUTJFVlQ0UlFuMlhxQndoOXcy?=
 =?utf-8?B?bk80V3AzekM4eWh2TUk0M3kvWU5jSnl0bG03KzJOZzE3SkF5ZkdocFN1aVgr?=
 =?utf-8?B?cEF6Q00xMHJ4RnZJbW5lRUNuZHZIdkhCVFB0eTVqOGw3NDF0WUc3MmQwQ3gw?=
 =?utf-8?B?N3RmZjR2R0VxOEY2TEhyaEJaTkRNYkQ5VzVqOVVaMGJIN2VTbmhqRTlFcTRJ?=
 =?utf-8?B?aS9iREFMRVdCNkV4ZmplMHo2K3JydHJnaWcwL3lCZyt2VWIzQzJCaGtsQ3BW?=
 =?utf-8?B?clU1eXk2cWxkSmwyeGwxOFh2ZnhuWnB2SnpHN05yZ3V6cGMzYkpzcWpDNlZE?=
 =?utf-8?B?MUx2VWZ4K2wvZFE4K3ZDeVIyanp3NHBUMi93MEdqTVpSMWRuclJzZnFGVzhl?=
 =?utf-8?B?NzRPMVdjKy83b09uMThJVHhSZFBRcWJiSG5UaW1KMnMvUkZ6SkdRT3VaWWlv?=
 =?utf-8?B?cjBxZTlUSnExcGZaQjhLT1ZKaHNJeEdCazl0dk1QUjVRQ1IxZ09RTmVOVFVt?=
 =?utf-8?B?TGtpSVJjV2grdEhncm12MzM1cGtCbWlXWTg4N1EwQjJkckJHZlljUEdlRTlR?=
 =?utf-8?B?VVBYSlJYMXZGWTJGWlJIaXJJNzdCcG1qcmN6L2tnZzhoODJLTGg4MFM3b1Bx?=
 =?utf-8?B?QkdIdEtzaXpLYmh5UDI0ekxIam5HTWtJM3AzbC8rcThCTmN6b3ZQMlJJWEZE?=
 =?utf-8?B?VGk1SHo5aXlPcjlmdzJkbmJzM2taNTN1dERXVTFXcENXUXpMMzhpUFFxNjJR?=
 =?utf-8?B?MGhtelVLMFhrTnY1d1l6Mnl6SnZNR0ExNTgzam54OGd4TEp5VngyMUEyV0tm?=
 =?utf-8?B?VEVhUmVJVStpbE13WEoyVkJLZG5QMWJUSzFSOHowUk5XZE1HSlhlZTBPdnhZ?=
 =?utf-8?B?TnoyeVlHZFZhSjlUTEFHcWJJZ0VpMUVaVWRhbmR1U3B6VzRNQ1U1SEFoNExV?=
 =?utf-8?B?SklrUzFjTUhoeEw1M1FGckRvZkdkUWRGaG0wWEJocHNjZHJBN0NBUVRNUENz?=
 =?utf-8?B?Y25mQVFGT0V6UTZBTnp2c2J5Q1Q0SWxJQ0E1SFRIWTNHaXgrTGtlSW1DRytL?=
 =?utf-8?B?bWZjb01Fa2lxUmdLKzFJcmNpTUhyTGFxVUNzTlBtRXNRT0lIYlZsZzlyTW9O?=
 =?utf-8?B?aTlCSWJWbytGL3k1eithS1VmNWVNMTJkcmY0ZzFxL1ZaQ25vTU1tdUY1M0F0?=
 =?utf-8?B?VjN0NGpEYU9vTVJLb0hwbisxUityODBSWld6TnMzOStLNjAveGRMNWFic29x?=
 =?utf-8?B?cFFtSXhaR1lDbm91M0pGSEd0SjFOcUJycXBibVVlRGpHcVoyOFMyNng4MmNX?=
 =?utf-8?B?Q2p1enBlVmNubmdXZG5tWGZZUklQTE5MZUFnTURmZmtNQWh0SWMxUkJyakJn?=
 =?utf-8?B?UXRSNVVRUFU1dFNma29RRXpQNFhrMFp6MjZ3dWVBQ3hOZEFjbkR6UDM1Qm9X?=
 =?utf-8?B?VHRCeUFrV2x0eEhSTjJpVEFiZmFScGVDK0R0Rjl6RVJsN0lvT3VvN0dBQnJS?=
 =?utf-8?B?bVFxWUZ4LzJYT1pHZTN0eDM2SU15emdwcTA4cGZqL09LQkUybkdPMGZrbHRC?=
 =?utf-8?B?Z2lpbUdiYWt6eUVnejBTRWRBamF4eUFjbHJOaTQ5VVNYREJrVjZFckp0bW5a?=
 =?utf-8?B?TURIc2VEcTY5bkNlM3A5UUxLMzRJWVJwWjhObTF1WUVqWUIxeFhKY2tua2dK?=
 =?utf-8?B?MklIVXFnbGRTd1ZveEgwVVFHR1NPdVlXb0k4bmxHZGN6RlgvOEtiaWYwcGlt?=
 =?utf-8?B?eklKMEViNWpvUk5vWFFMVTl1SWppeFJOaGZBM0tnbXNXNHpBUkJWemFtT2ph?=
 =?utf-8?B?QW5hb1BoeDJNZDQrc1V2WVBwNzdQc0MwdlhoY2VWcVhWSnliSzVUb2szeEI5?=
 =?utf-8?B?dERBNHZHcHBZZWxxMjZiVUpQNFB2RjZpYjNyVFJPQ2tUc3Z2d2NCalhGZ1B4?=
 =?utf-8?B?MVMvSU9YL2hMb2MvRjAzY3pTS2I3bTFaWDZ5dXZRaGgyQUhqK0NPZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75fb09d-4a67-4a02-a933-08de8a7904ca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:15:51.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCa3JtqShodw1duidprtx2yW0lrrxDW4exAudRlm4j7clPOaqPriBN7AGCO2grbcr3THEajXkUmBLRoahvbjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 3/20/2026 1:12 AM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Add a field to cache stop size.  Note that there's an initial value change
> in vfio_save_setup for the stop size default, but it shouldn't matter if it
> is followed with a math of MIN() against VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/vfio-migration-internal.h |  1 +
>   hw/vfio/migration.c               | 43 +++++++++++++++++--------------
>   2 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
> index 814fbd9eba..08df32c055 100644
> --- a/hw/vfio/vfio-migration-internal.h
> +++ b/hw/vfio/vfio-migration-internal.h
> @@ -47,6 +47,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    uint64_t stopcopy_size;
>       bool multifd_transfer;
>       VFIOMultifd *multifd;
>       bool initial_data_sent;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 851ea783f3..827d3ded63 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -41,6 +41,12 @@
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>
> +/*
> + * Migration size of VFIO devices can be as little as a few KBs or as big as
> + * many GBs. This value should be big enough to cover the worst case.
> + */
> +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
> +
>   static unsigned long bytes_transferred;
>
>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
> @@ -314,8 +320,7 @@ static void vfio_migration_cleanup(VFIODevice *vbasedev)
>       migration->data_fd = -1;
>   }
>
> -static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
> -                                     uint64_t *stop_copy_size)
> +static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>   {
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>                                 sizeof(struct vfio_device_feature_mig_data_size),
> @@ -323,16 +328,22 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>       struct vfio_device_feature_mig_data_size *mig_data_size =
>           (struct vfio_device_feature_mig_data_size *)feature->data;
> +    VFIOMigration *migration = vbasedev->migration;
>
>       feature->argsz = sizeof(buf);
>       feature->flags =
>           VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIG_DATA_SIZE;
>
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +        /*
> +         * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE
> +         * is reported so downtime limit won't be violated.
> +         */
> +        migration->stopcopy_size = VFIO_MIG_STOP_COPY_SIZE;
>           return -errno;
>       }
>
> -    *stop_copy_size = mig_data_size->stop_copy_length;
> +    migration->stopcopy_size = mig_data_size->stop_copy_length;
>
>       return 0;
>   }
> @@ -415,6 +426,9 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>           return;
>       }
>
> +    /* The total size remaining requires separate accounting */
> +    migration->stopcopy_size -= data_size;

stopcopy_size is also an estimation, so I think it's safer to have:

   migration->stopcopy_size -= MIN(migration->stopcopy_size, data_size);

Thanks.

> +
>       if (migration->precopy_init_size) {
>           uint64_t init_size = MIN(migration->precopy_init_size, data_size);
>
> @@ -469,7 +483,6 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> -    uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
>
>       if (!vfio_multifd_setup(vbasedev, false, errp)) {
> @@ -478,9 +491,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>
> -    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> +    vfio_query_stop_copy_size(vbasedev);
>       migration->data_buffer_size = MIN(VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE,
> -                                      stop_copy_size);
> +                                      migration->stopcopy_size);
>       migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
>       if (!migration->data_buffer) {
>           error_setg(errp, "%s: Failed to allocate migration data buffer",
> @@ -576,32 +589,22 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
>                                         migration->precopy_dirty_size);
>   }
>
> -/*
> - * Migration size of VFIO devices can be as little as a few KBs or as big as
> - * many GBs. This value should be big enough to cover the worst case.
> - */
> -#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
> -
>   static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>                                        uint64_t *can_postcopy)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> -    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>
> -    /*
> -     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
> -     * reported so downtime limit won't be violated.
> -     */
> -    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> -    *must_precopy += stop_copy_size;
> +    vfio_query_stop_copy_size(vbasedev);
> +    *must_precopy += migration->stopcopy_size;
>
>       if (vfio_device_state_is_precopy(vbasedev)) {
>           vfio_query_precopy_size(migration);
>       }
>
>       trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> -                                   stop_copy_size, migration->precopy_init_size,
> +                                   migration->stopcopy_size,
> +                                   migration->precopy_init_size,
>                                      migration->precopy_dirty_size);
>   }
>
> --
> 2.50.1
>


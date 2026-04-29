Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87724FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Ge-0006qi-MU; Wed, 29 Apr 2026 14:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wI9Gc-0006q6-RO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:04:10 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wI9Ga-0007Uj-VW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGPvdeVIH8JWWcM0xmeIPmSws7+YiHBCm4JkDVjzUe0jzUmmptzZ/jepbFehViP7IloFUCxDxHeKmyICZvFAtteFzqI1UjzzyM+4pdJxvaVOzChgVYTTuytiEe4qwiSiymjgmm5ybuUMJKMOwVel1s5/KUj9c989XGBYDWuw/Wf8uVVPgLNzRUBfRWk6BIp5EQ5D+vWaEKCCv5dqT/vsDPue8iLlB/wiecD/cEb6C45xIsuL3yGS7fJPhrsFzCxJqREKLCFJ0ySlA7nrID5NnA6Sn+uwYE0WZYt0yG2Dwm1xFoon6e/+xhNDC+mLUQLF3FqKkgDUKe+paJLkf9R5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEB86E/YVyeAmC62VZ5SRGQYycVhKAl7GAFmqDKy9nI=;
 b=x9KHIqgABklTTUvtiW4ZHZlL8Mk0ya/qtmJMtxy3EUSZXzxvSzHMpwZFueQQRCjRaRRYQPPC8PU1yqC6xgxNUpfaJrbEkK7PV71UmoHjilmLMpbPS5WzVAZATvlFpMp03c1TG+j3nsUotnJBfdd6dvEva1fMIMizuWNb/NpKnFCxuAb8mBiqhwZ9cWEd92Mi1WMOxOs409Pc0qfIMUDQIyHjUMJ3iHufwjtPxixxhFbyTqvg8xSPl+tLQlocZFeObCbcY6HsR24Efd18Ysx3zdzPzVI5P40SNlCc+CK9NXeCW2hp4r/HgFOTf1xjmalCpoBpbefqAXSsNCDB9IgqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEB86E/YVyeAmC62VZ5SRGQYycVhKAl7GAFmqDKy9nI=;
 b=jnEiOydxB3pKWcW22/6Tu1gZfonrNnL92xS3e50KBvJnh4N1GaurkDaiiJQ0Yh8+BbaArsOQTNfMTD4B8B9GdF4JwNR+fVzG4SaVCO9ZtxZL1/MPQMHMrfqK0qIt2HamM6CvqG4eAXRmesUZlLN4MztTSw6FGtztwBZUWJhoBMLbAixisOz9ceTASZd6tJZ2PYSt/cDYFwLrSTFAVUgbcKVJ5moXBlLrO46+8aDrkuU1MbWeXjPaV11aiP/6bgWYprWitNtvqxfOqf9Mkm8h6EmX+oKOP6FpNeQbxX8PnnLlttR/qJW1nHdvWZUjJjGoTl05mBAoAWzdku/LsDibLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 18:04:02 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Wed, 29 Apr 2026
 18:04:01 +0000
Message-ID: <6d166a37-7418-4a25-ad1d-90abe0f9d153@nvidia.com>
Date: Wed, 29 Apr 2026 21:03:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] vfio/migration: Add tracepoints for
 precopy/stopcopy query ioctls
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-17-peterx@redhat.com>
 <8943abf6-fdc8-4684-8e2d-3a8c95d59c19@nvidia.com> <afInOIANAJLftQ7w@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <afInOIANAJLftQ7w@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b848a1-b3b3-488e-ec22-08dea619b174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: T45I/0ZRCxiW73M1OS+2ZSSOXvTMul7+XBjPgJjnjfcT3foCfaNxF5hYRuoi6gf1X1DQ5B2o6SaKHXpZAvT5LSAAdriEdA77+DkqGnJ9WkLmwzxKJiPngpzkx09SCSRs9LVjlnQiODDBjxNGGCg4Jb1Oa3sLRGOZSSHpY9WFIuM1+NyJFkRmSkoAR7a0/zOi32JfUTeaLciHK/Zd5rKW8+jY0ozYUDiZRsmCX/arQ17MoSBZagOkcaEYkbiX4DArRYUGYkbD4NCOEEFPaI+lRh1vTuC6oQbqEAABGSkZhxrMTwT4Vd5KTMLfR5lIg19MhBE8pbX0zsjLuf4tDGjtz5XhGm7FiVWBe6Lp2JZC4+rlyJSReS+nrCf85/Nk7xPX2AypWVu4pRjunF+3uDOsqiq/AY1MTtiCi+aQ0IbU2rXaF7LkyI3eFH5wt44J9SMbipX3sq6G41B8xZOkU1Hzd/rLkTYPRODqPwj0ozwQqGNbjmJ2LGxRaH+9sQSP3RpVOo8B1CQN56IDokCcIfO4flS0QpdDJu4EKBAI/mipop0apBPaQtueAPkw/Uc4S44pOX67GDFmhKgNbRsLULnb/tgkJY4hcsV0jjIp7gjsKirz+45LQbA/QCHCQwYTwh80KXYnxKsmr/yFgNkcdKVmY37XGU34ix1IzUJLPi5pBeLV+vz28G/X5i5PB3AM+W3nNpgQqKXFqSjKA1Wy/yTFlNYAzGCxT8QNHQeeZOBuEUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVjc3N6aVpSODhWZkV4MmZRWDlXbERvOU1VSkRDT0pLa3p0dnRCZmhMY2dy?=
 =?utf-8?B?d0xiVENlVEhqOHh0V3UxcGxTNjdRSGdyTmlQR3BzZm95Mk1yRkNITjhNYkQ1?=
 =?utf-8?B?OWdhMWd4N2dPUWs1MVp6RkdKUlNKWjczWmpiNUxhOGt5aFc2dGYyRjVKUzN4?=
 =?utf-8?B?SExtVXkyZzF0RGhqRUM5Q0w3RktncGswRFZOS2ZxSk11OFczU1FvU1hONG9M?=
 =?utf-8?B?U21IZ3ViYW5qeGwveXFvd0NPV1dOWEhDV0xLQWV3dk1NTS9mbEgwckZYSjRH?=
 =?utf-8?B?aWc1SkVKdFU4ZVRUdFNYVnJMbXRlWGdtSFpPSG13Q3lHK0s0YzBadmcxZ3hh?=
 =?utf-8?B?YStUUmdZTHVsbDk4L0RCdE1TVlJ1VVlwZnIxcXA1bHY2RUE4ZlFMWFN5aStw?=
 =?utf-8?B?VUd6Ni9YTkJ3UXk4a01TV0RXNm4yOVZlWlhzLzdBelRxdG9KU3Jmam9tT3RY?=
 =?utf-8?B?SHJNSFBNNUhYNlRRRWtHMlF0dTg5N002OEdGRnIwcG1KVVlNdnNvdEFLU25l?=
 =?utf-8?B?TVpMang4bnA3OXdvbzJjSGZwTUJjS014U3dBTDVReU05YUlnWVNtMnZrdzhW?=
 =?utf-8?B?S3lNM2s4YlNVL3dIWXNoL2huS2F1OVZCTzJUYzRiRUlzRlNIUVpOSmhESzhx?=
 =?utf-8?B?RGJSZm9mNXhTSENBS1h6djZCKzZCMjBFOGZPRjRsTVpHcnZyNkRFN1psamI0?=
 =?utf-8?B?aUhFUzZ1SWtzdGI5aEthRWhRUTBoZExwRVVaY1lxTzZ4c2Z3T1hKL0c4c0RT?=
 =?utf-8?B?RnQvSWdLMlRkNE14ajhxeDVXRUdPbXJmd2lrZGV4dXBXd1JENlpZUE1ISlFY?=
 =?utf-8?B?NVk5T1ZlVm5nT3g0Y0pLU2h3cTl4TGw4dlZlaWNMekFFd3g3cVNqVjdvYnEv?=
 =?utf-8?B?dG8za1hPVWl5V3Z5bWJBK0VYYWdnWktCVVBkSVFwWkIreUVQRHpmOVF2cXF4?=
 =?utf-8?B?ejZOb3VUK1M3dklmc1c2UTRBanV5TU9DUTZ6NkpPV0h1RVNwM1V4bm1SQjlY?=
 =?utf-8?B?QUdOZUIwenUvVmoxc3FQWm1CQVg2SW1PRERaM3d0aHYzQlA4ZHNmMXJtQ0FJ?=
 =?utf-8?B?TFdHVUM1Nnp3ZFRjMVJEU080bzl4N1lad3BxZGxJdWx3cDZHdmQ2OFNoVXhM?=
 =?utf-8?B?MkZKV094VCs5Y1h3bVlVY3FJYk95MXFaSklRWUpUc0lsU1NEL2RDenBFd1JH?=
 =?utf-8?B?WkpvbS8wMEpnSFlWK3pyZ0RLVmN4LzZxMEYzVGVJZm1lR0JjZ0t3NjVUQlRM?=
 =?utf-8?B?ZDFoZkIzUzlpaUxUaDE0azl1b2NuZXNhVXl3bXZ4VlV6MFZKbHFIYnZvTjlm?=
 =?utf-8?B?R2pkeDc1cGMyT0RpaGQ5Q0xWKzR2VGlGQXppN3dQUHByV2Rta0ZvbFMvYmVr?=
 =?utf-8?B?cEdpM1RsZlY0aXZtYTJZU0VUZDBRSFl4QXgxSVd1dkNvL3l1ZGI0NktiMm5y?=
 =?utf-8?B?Y1dKYzRiVURrVGdRbE9OdG9BaW83eTFRWkVUb0JvbXkxSnhQS21ITFdrSVF5?=
 =?utf-8?B?ZEY0NEYzd0VuV0tna2VEdnJEMStRNWpjRHQ1Q2pHZDAwWkw1Ui9GQ05XWWNa?=
 =?utf-8?B?NENDZEcrUTdzTVgwRHloOXRTcG1CVm1ZV2VCSCtlbDEwNmZNd28vc1FZYVJ3?=
 =?utf-8?B?ekxSNXVYZjNiMmx5dGt0ak9qZUN6WGx5eWlDTFdEZVVXOHF0K3F1OW9OeHM3?=
 =?utf-8?B?ckFQZFRUUUU3NDc3SU5YQVV2RG14NWFla2VTbTZ6RDJFNXdFMXVrQmZoQzg0?=
 =?utf-8?B?bFBnYVVXRVBzYVpIeEhBN0xxVkVFM2NJVFdFMmhVd2NnMEh4c1dUR2NLNGxh?=
 =?utf-8?B?L2M0VFdKU1F4QkIweDlQN3hEbllpKy9RUkdWU1hVTUJrK1VST2R5eGZTMGFX?=
 =?utf-8?B?a1UwamlicUVQNEg5cURPdGVWWElrRENVTDFKRTZxU1RqalhmSy96M2o5MjhQ?=
 =?utf-8?B?cUZVVGZQb0VIU1I5MWFLemdCQ21PZGlIeFZLT1lHbUJkSllGY0dYaVpMM3lP?=
 =?utf-8?B?anJJaHhtWXJzbVVuTElJM3V6TnlVdllLQk1CVjlDb05LR3dhbTgwcVA4TkNw?=
 =?utf-8?B?N1RQMWtsVWc2UVY4ZjM5ZzNjd05SVUIrUUdGdVVUWGUyUUp2ak9GMTZpL0Uy?=
 =?utf-8?B?RzVSWVExSHVjZkY4K3lMWmNING1BNndGSUV1OXFibjhwZzhGTGFXakFRQzhq?=
 =?utf-8?B?MnFobG5hZ3lrbkRVUXdrWUpYZVJxUS9kRjR2MkVsOXk2aWtERVQ1MXYySHoz?=
 =?utf-8?B?dU42QTRYSVZmUmpGeEFNbENIM2JHazExYmFwNmZvWkFIYXZMQldsM01TS0w0?=
 =?utf-8?B?azZOMkRUTXVFTUdXazBKSGxnMm9WdmJvRjZkcitKc05yQnZNSmVTUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b848a1-b3b3-488e-ec22-08dea619b174
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 18:04:01.8555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX3C8Lde/10019pWfwOGBOqiNE5hK9AOS7fZ4mNjeoQcpVHBEiOGtg5DuUDxVrb/ZzawopfJb6w5bz9UrNcALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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


On 4/29/2026 18:43, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Apr 29, 2026 at 05:46:19PM +0300, Avihai Horon wrote:
>> Ah sorry, I just noticed this now while doing some other work -- if you
>> respin the series, could you add the device name to both traces? And while
>> at it keep the traces alphabetically sorted?
> Could you help check if below fixup is suitable to be squashed?

Yes, looks good, thanks!

>
> Thanks,
>
> ===8<===
>  From 930723da46e16c2ed5405916a7e10d4f560e22fa Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 29 Apr 2026 11:41:49 -0400
> Subject: [PATCH] fixup! vfio/migration: Add tracepoints for precopy/stopcopy
>   query ioctls
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c  | 6 ++++--
>   hw/vfio/trace-events | 4 ++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 04d9f94edb..150e28656e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -350,7 +350,8 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>           ret = 0;
>       }
>
> -    trace_vfio_query_stop_copy_size(migration->stopcopy_size, ret);
> +    trace_vfio_query_stop_copy_size(vbasedev->name,
> +                                    migration->stopcopy_size, ret);
>
>       return ret;
>   }
> @@ -374,7 +375,8 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>           ret = 0;
>       }
>
> -    trace_vfio_query_precopy_size(migration->precopy_init_size,
> +    trace_vfio_query_precopy_size(migration->vbasedev->name,
> +                                  migration->precopy_init_size,
>                                     migration->precopy_dirty_size, ret);
>
>       return ret;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 854a7e4b19..ab27ff5ea2 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -162,6 +162,8 @@ vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
>   vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
> +vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
> +vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
> @@ -176,8 +178,6 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
>   vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
> -vfio_query_stop_copy_size(uint64_t size, int ret) "stopcopy size %"PRIu64" ret %d"
> -vfio_query_precopy_size(uint64_t init_size, uint64_t dirty_size, int ret) "init %"PRIu64" dirty %"PRIu64" ret %d"
>
>   #iommufd.c
>
> --
> 2.53.0
>
>
> --
> Peter Xu
>


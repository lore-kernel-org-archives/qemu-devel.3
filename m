Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0BFFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6GJ-0002nd-3M; Wed, 29 Apr 2026 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wI6GH-0002nR-8r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:51:37 -0400
Received: from mail-centralusazon11011045.outbound.protection.outlook.com
 ([52.101.62.45] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wI6GF-0005bl-EP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7y9IVaIbKXWbzn3t39nFb3o4InJCXT1VClPt1JL9FNbRH+VuaBrOP14XwAE+UWMGWoaJcpMNmExT6cF3oLGOXpT4fas/Un3tUYeHjx6ZIEbX025/VmBBKGjB/6t7okflGcjYKyRpbjXP6SYmEuSltMPwA/EURZdPzTpGSjTmolGKpKlLMrzn/DgrQvUYGuaVjSV9JaUmF3hG7WlLwYNgAQ0myqP8rteBCLNUB4dM9bkT9940RtB+HWQgK5F2OeOpq1eHufPXYbHx916Jvf01itA7BK/t9RTJfOLYb6VsIRpH1Cn2Ib5rG/dM+hz3sir50yDTGG3WLzFJrirNM1wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+Z+wc7y1TC0jOem8VyzQxeeGvf2KMYfN3p+XEzmlnU=;
 b=s9p+Pi1KT21fPYZ/VSCW1XvRWGWY7jh+EWyhRySj2+jSLwBYF6CAPM1heT19A3mahl6S2z64X38uNKwCCG5OanN2RIoTCrwlhrxERhrSNpZSQ0CK4QnU6LI3TWT8WlC7U33+LlI+PQSvITOedlGwKDGD/EfLgvH/zYcLAqi4mTybHsWyBNoVM6XjsBQLdTMttm6WQAjkS2iaPaLsg5dAlxvMsp1K2MPofmCea5rsTq8LWPkT/RLjKcENhmh/0aTrbEZI+HBfje513ksKglcRLqn0yYVxr9Y+Ou2ILoPhmjxhJun5NSVu68o7ocI+6vzvMKvgrAxSr9owOYJuljlENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+Z+wc7y1TC0jOem8VyzQxeeGvf2KMYfN3p+XEzmlnU=;
 b=AkciBE/6juK4F11UbbFYdLU1iwEL+AHjo9IJzttn3ze3ij0OpCzlAATvP/HDRX0pMgxNggScLU124gbbCAmNugquVugUOQxxh6/9kmCJWcwaHOM9lqcc2jyvWWM9EplqC/Q8qk3WyCw0tWk+dFI+L9AmJduz2rxvRSyrS2LjtCEaICqo4vKtt0p25eav8Ns00RTjxk0aDaEZs3W7n0f1Uw7x09Rx+oewINj9mj0bWGLXn9Jw/j/aEGAy/LwGH0QtenOCU3cpAuj00WWOR9ZFSixY0AQV0op+9rd7pwj3DmtiwZ9AznMyADklScnQHoeYHFM4uyW4BkzvMgv5t5UIOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 14:46:26 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Wed, 29 Apr 2026
 14:46:25 +0000
Message-ID: <8943abf6-fdc8-4684-8e2d-3a8c95d59c19@nvidia.com>
Date: Wed, 29 Apr 2026 17:46:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] vfio/migration: Add tracepoints for
 precopy/stopcopy query ioctls
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-17-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260421202110.306051-17-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a62ccb1-b741-40b0-c87b-08dea5fe16ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ExsNUmt4WpBGwZS1TUnP7cd4KnnIbYLEER80vYlKhLEc1wdFRRCcaBAk7fza7dUox/FIPmR4wvcFnMz+/yMs1RtJv3/TLejQOR5AOwkN+K79KtGKx5Gs0zMVQAvg7+hiG9pcjbVIVKSyxw4Ln7kH7fVNlZUqxZtqubXEfCFIn/cJ1ky3VkKAD1s/DgK8by1WIU++UU/2WdHNd4o7rXyt8RvBFr3oWE26lbm+OyWRyym7djVC624gzMiZHqWo7uXsWV9gJbS4lqFm2r/KANJhAcH6u/tq35APzBqhvB7zPJGJ9MyuCBoDHS7vo3pH3/IPzBbO79Zxcl7//RU9hGh0P2CYzqltOmrdYXyeVeR46pw+Y4Gx9+LMeH/zPt2+pGKhfLtbIOrNXTkBKGWzMDN/b2r2fVHyexBB+nwkcRtSMF9swvsH6uwpJ2MOsbd9nxifuCRl2oCq3Kj+UhVTTDy2Kii4oK+25/xoLgXiLnSRyUGjyyrR6YUvJ9N2K9nZ7xaNKsd5qx47dgGYGTD9A3gMkLWYgzOP+GXOSITZ8P7eNlJlW3G9Xo/u0F9sEEfbQ6S+ekiDmXu7v4JBXOjJApW/avqWHnAOjRSB4kduMHTXl/awA1+lnnCFnPQRjyKrG8xBn7Jz0m048Xm7oUJ127DUPCkUdysDT2DiJ3Qf1+2yp2HDN/7O4fqXr/3FPVaibb5bQJqrlviR0HR+4nJfgzsugNyYBjZembVK0pb1pMUBPFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9uUWpPOWNHSzFvTHBZcStqWFZuaXh4d3p1em9VOWpBVmZMaVlIUVhrQUpF?=
 =?utf-8?B?V1QyZzRYYmg0eUlaOEFZMDBZcStrVEtIZStxMWh2QTBvTExuZlZxVUNQT2Vv?=
 =?utf-8?B?azJLempKM2RvNjN1RzdhNHF3MmJJVW1Ud0VkLzNxWUNSejZzb1h2L3ZhaGZa?=
 =?utf-8?B?RGxqdngrdCtJUVVBd0ZmSVZNcFhHZUdwNWRvdlZ5cVdGam8xd0lIT3N4YXFv?=
 =?utf-8?B?VE5seDEzOGNabGFOaDM5OUp2ZzlHdWNEQjErMW1kd2NnR3AxVTA0cUc1VThY?=
 =?utf-8?B?eURNZHdRc2VxSHN1QzJvUTlqTTc4VCtEc05yMndJWHROZkxlaFR6NEk5VEw1?=
 =?utf-8?B?THlVMnM3dU9IbEt5elUyZklkOHJyQndYbDRjV2hPYW5UeXYwZ2dPMGhtZmJ1?=
 =?utf-8?B?Zm9DVnAwS05QQUlKVWtNNlpPYisvSktzUUhHWGl6bmpmWEoreTlrbGFFSFRB?=
 =?utf-8?B?V0RRbWFlOFgzMmw0RzN4cDJUWEVKRVVNdklzZndRanBvM2daNC9MdllEd2pB?=
 =?utf-8?B?eVE0N0FtOUV6VDFuMm1uV1hxbllRdzBTWlNud1QrK3dyeU5OWFZOM0FmS0hM?=
 =?utf-8?B?TlRBQWxzUU03T2orbk9oWjNmdmJicHhZMjdxRDJFL1QzS2pxR0lsYytYeW9W?=
 =?utf-8?B?MHE5aG4vT0JnNmFwVFpVZ1c0Y0t1ZnNnSG1WUHF6WGgvcGU0TXc0SlIvbFRX?=
 =?utf-8?B?MVVaU1VSVDdVWk8vbmYxWkZUZUFBc1l3L1BZM01McnUySWpvWGFVeVd6SWVt?=
 =?utf-8?B?VS9Bamx0VUR4aEdzUGxYVHlaZjkzY29kbElPSFdzOXVud05NVjR3MjV5WmRN?=
 =?utf-8?B?Rms3ZExLNUZ6c2c0WW5nTTBVZFRDUDV5RzAzZWsxNTgrWGdCWEF2Y3Q4dU5G?=
 =?utf-8?B?UDZTNFZJblA4STJ2bjFabmVhcFNaV0I1bjU4Y1pUd3RxdkNxUlAwWjBoZ2Nr?=
 =?utf-8?B?QUhUdnNydThDRkVFSXhPYWVIZHI4RnJvZzVydm1oSmloV1Q4ZWtDUXBjT09J?=
 =?utf-8?B?Y25TTlQrTGUxZVFBRGQyQVFlZEo1MDhWdVpFdmRvWENwOTZwRFYxUXRncDRF?=
 =?utf-8?B?SVB2UE80QlFtOHA0VVNnbERrdTJhTk9qdWNBd1JESWJVZFRGaU9ldGlNaG1C?=
 =?utf-8?B?MG1oUWZxTldYRWZmQ3NhRmRQZlowcmp0SWdQdGJzd1NaazlCeHh5ajRHaUgv?=
 =?utf-8?B?WmN6aGN0WnBxb1lNTStrL3B4THVacmZIR0N1dGZQQTkxRTJuTVlzOHlTU3Zw?=
 =?utf-8?B?U3hraEJBd2F5NXlYa1hnak83Y1pIWmJseWlHSGZYM0RZYmtjZThWdWRxRzRw?=
 =?utf-8?B?ck52c3IrS0ZTcUlDQ0NjZ0RGNS8vUHgyTkkxdXJOQ1J5OVQ0dnB5UkxIaUJI?=
 =?utf-8?B?bHVBQmhDMmpPRTNtTkF5RC9CcTNYUkxIUjU0clprQ0xqRklIclhDOVVEMkdy?=
 =?utf-8?B?bXJMQkE1dEpNTGkyVm5lYXQ0OC8wOHFMVnc3cmlxelIxbmhiTlVTOVRJVHEr?=
 =?utf-8?B?dWlXSlYvcnhnQkcvUTlUQWx4U21rbUpKNnRncVByd3ovbmdEai9oTTdvYjI2?=
 =?utf-8?B?ODUxb3NOWjRkTVg0WWc3NmpJRVVLVnVXelEvZUF0VUtPY0diY0Z4Um9DMWx6?=
 =?utf-8?B?SDU2c3puc2hSRk1BL3NYWG1kVGdWa2dzNkJmZ3U0NFY0aDNkWnhmK2cyVmt6?=
 =?utf-8?B?RW4yU210WkJ5T0ZOZFVCZkxmeXhqczNPMS9PcUYvVGM5aVBjNDJEcmkzVEUr?=
 =?utf-8?B?YmNhemhWZS9GenEwNk5iYVIxVWRrK3JyVEltTzlCeUM5QzByVU00cS91REVn?=
 =?utf-8?B?eTlqOVlEcWxhQjdxRlBaTUI0c1dzYkpTMGQ2VFJKTmdyZXlSNmUydUZpTU0w?=
 =?utf-8?B?NWZiaG83UnA1UWx1U1RWZllLRy9MYjNsZ2s0RVcyeGtpYWpnQUs4dlhJM29h?=
 =?utf-8?B?a3VTTUNVMzdIcnVkY2thUWJ1K2lQWmJhZFRzWjdOVWNVRFNGZnlOSC9vcGo2?=
 =?utf-8?B?VGlHZWl6a3BDSU81SkxUWUxEQWo1ZkxNdE8rTklvMXR0U1BTQXhEU05YYmZV?=
 =?utf-8?B?bDJmQi8vK3VlVm9qWW5HWDBmajJkeDFRMkIxbU01aWVTaDk2VnBDOFc5WFJH?=
 =?utf-8?B?WGNlTCtra042SGpvcUZnamF2Z0hzNWhWdkkxUW4yZ1JrMmpKaWlHQWV0QWRp?=
 =?utf-8?B?UFVyUU9pMGR2SGI3aGMzYjhneUd5YXdGT3M5clVCZnlFU2djTVgybUVFNUhZ?=
 =?utf-8?B?WjJWc0NuMHJrRk0wKytzZHhGbjFlN1BEVDRrcnAwMWtxRkkwd3NMM25HNEVj?=
 =?utf-8?B?NW1lMm92L3UveVpUaU9TbXhxdHozVy9LTTBIVk1vN3RZK1VBYytsQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a62ccb1-b741-40b0-c87b-08dea5fe16ca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:46:25.7844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omPBvT6OtK14VJTFSwh9M/01xSOzoD2xUbxeQEwm/m2qtTIiKo1SDbXKZlCxj7iVOQNLPaN0l5tB8uD+zKMi5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
Received-SPF: permerror client-ip=52.101.62.45;
 envelope-from=avihaih@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 4/21/2026 23:21, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Add two tracepoints for both precopy and stopcopy query ioctls.  When at
> it, add one warn_report_once() for each of them when it fails.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c  | 33 +++++++++++++++++++++++----------
>   hw/vfio/trace-events |  2 ++
>   2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e6e6a0d53d..04d9f94edb 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -329,6 +329,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>       struct vfio_device_feature_mig_data_size *mig_data_size =
>           (struct vfio_device_feature_mig_data_size *)feature->data;
>       VFIOMigration *migration = vbasedev->migration;
> +    int ret;
>
>       feature->argsz = sizeof(buf);
>       feature->flags =
> @@ -340,12 +341,18 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>            * is reported so downtime limit won't be violated.
>            */
>           migration->stopcopy_size = VFIO_MIG_STOP_COPY_SIZE;
> -        return -errno;
> +        ret = -errno;
> +        warn_report_once("VFIO device %s ioctl(VFIO_DEVICE_FEATURE) on "
> +                         "VFIO_DEVICE_FEATURE_MIG_DATA_SIZE failed (%d)",
> +                         vbasedev->name, ret);
> +    } else {
> +        migration->stopcopy_size = mig_data_size->stop_copy_length;
> +        ret = 0;
>       }
>
> -    migration->stopcopy_size = mig_data_size->stop_copy_length;
> +    trace_vfio_query_stop_copy_size(migration->stopcopy_size, ret);
>
> -    return 0;
> +    return ret;
>   }
>
>   static int vfio_query_precopy_size(VFIOMigration *migration)
> @@ -353,18 +360,24 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>       struct vfio_precopy_info precopy = {
>           .argsz = sizeof(precopy),
>       };
> -
> -    migration->precopy_init_size = 0;
> -    migration->precopy_dirty_size = 0;
> +    int ret;
>
>       if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
> -        return -errno;
> +        migration->precopy_init_size = 0;
> +        migration->precopy_dirty_size = 0;
> +        ret = -errno;
> +        warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
> +                         "failed (%d)", migration->vbasedev->name, ret);
> +    } else {
> +        migration->precopy_init_size = precopy.initial_bytes;
> +        migration->precopy_dirty_size = precopy.dirty_bytes;
> +        ret = 0;
>       }
>
> -    migration->precopy_init_size = precopy.initial_bytes;
> -    migration->precopy_dirty_size = precopy.dirty_bytes;
> +    trace_vfio_query_precopy_size(migration->precopy_init_size,
> +                                  migration->precopy_dirty_size, ret);
>
> -    return 0;
> +    return ret;
>   }
>
>   /* Returns the size of saved data on success and -errno on error */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 287df0b8cb..854a7e4b19 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,6 +176,8 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
>   vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
> +vfio_query_stop_copy_size(uint64_t size, int ret) "stopcopy size %"PRIu64" ret %d"
> +vfio_query_precopy_size(uint64_t init_size, uint64_t dirty_size, int ret) "init %"PRIu64" dirty %"PRIu64" ret %d"

Ah sorry, I just noticed this now while doing some other work -- if you 
respin the series, could you add the device name to both traces? And 
while at it keep the traces alphabetically sorted?

Thanks.

>
>   #iommufd.c
>
> --
> 2.53.0
>


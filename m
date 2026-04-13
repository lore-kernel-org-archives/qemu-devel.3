Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E67CEBFD30
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEcs-0008Mi-CH; Mon, 13 Apr 2026 06:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCEcq-0008MT-9i
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:34:40 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCEcm-00014d-Ns
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0Zomjmjmqq/pwssmNRgw1Wl4jVHhYl5T3jnnnewBInl9NA79LYqeRt1wzN0cE3IDzc7BfMjoFJ92vq0btbv/bHU9cjCNmimZqdpuwU0opTY0SqvGQK97IlpcweQ5hHvzGpa10MW+tjkMJ79Y50IyUM1bzgK9sSmKKBj1qElYusH0FE3KHG4Q6lOaxqiaDGQ7jr2JUc78rKiQAykHKblPpQJTQHwyWUarfQjq5hGnWzMzFAg+elAFP9DmJi8aRiKKsE43jSaJrTCPT72WXataYrEuqdYTwlputkxpOQWFn5Gu9OWeq7+Q/v52gxIzDGDhImP699wI/mPxzOkzhRQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ft9VZCGgfiYOFvppPwpyQB4ZAcDOQh9YTIFo3MMybRI=;
 b=dAaFlWREhOQOY8h3YjCNhwYzbw4ZQr8h7/TArQ+yKkoEWnlirJKgOIQFAfOiGSbmnpJKIGgfM1GaDfw2cc+x/3dnGIjYCns6sdIlm9pDashfCKdIxTAYNSwR+9RE/hoigyKpuVXvXtNdkR6f2CnrtKafaxZQjBcnn3ZDPtMNTzymBfvqOrBLv65rdnJ4L0B6jSLdhisJ8J+niclIdyWtbuybu7JGTZk1yljx7oHAfAK655O2DhQPlSjYDP0ATPOPM29iyr6OtG/djQVJnVBzozo+U7a2OG13qxjELbIXr3dkPL7VfomErU1NaDlMQKRFCrcyRst53zr+NflGFf1TZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft9VZCGgfiYOFvppPwpyQB4ZAcDOQh9YTIFo3MMybRI=;
 b=DSG/2Nf4u0Oku9tW0uSWydKPorVE/bzTCBlwXeDQFYJn35cvc6kFB7Rh4zna7IVoHDDEByDZEsKZTNkk7/YPIhQdOQYfycULSUFnfufZbQmkZcFMiKStB5qZ24GGlUabdcdXjfTHzEAW1JEFHuT5wypmVf/SAI6zHmiQn7J1fTF+pvE3VqkrtDgQn4ADz65l+lnDZRmCd6vWmqW2/ey08Nk3F8ncauq7xig0gXP3t9PAKzooS40+acQQfh53jFXn0JDO1ITK7p0LWQGE+FyLt9VbpSJ7b9ooOXYHTpuBgmdQWAcVVbiHFdEaRvVPsRtToFDN/IQJOk7eBQp7KIHuvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 13 Apr
 2026 10:34:22 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9818.014; Mon, 13 Apr 2026
 10:34:22 +0000
Message-ID: <9e52a221-96f3-4c4c-9693-3235617d2a98@nvidia.com>
Date: Mon, 13 Apr 2026 13:34:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] migration: Introduce stopcopy_bytes in
 save_query_pending()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-7-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260408165559.157108-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b253356-1b12-4cb6-9d7a-08de994839c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iPlgzv93McWfvibmY/QQj/63pWvCK4kg18i6R64yU8+uYiH3I6q93aB7QMzmGymOvdivvvqj5qIRQRJlhK3HGWx+xZwpQr+NYbHHHN4wCA4GRdadYqKH4dQ4HoErpqTnAS0wiwR2w1fvvPhZExgFW7MLTSohcizhF/zf49vKaGEQW4dD4b0gN/rwk1bWSbPvDy6cUJYE2aOW8cetqmUUbT1a6ZfYW5AwcU505Hye5sC+H/6rHdzHky45VOkdKB6dAc+VVr/bMxETAcMZPhAOcitFNrhtchtvfta3Ps6EPgkJavtMCltRzxQA/nPDDkmdW0l/THCX+FzMjOB/57guBef7eo9QjNamhw4/M99IUDuEB1dqbV0FtRCuSbySKCjfTre84UUnv5Xp5bFaV6q+ejsx1FV1GqgvTO36Nmc/okTx+N2g6wCPwUU/eE6qRNG3pBtXwYdeNz0bkhowxIxB0RWPCZXRHchMpRA1QLlIH22lHIDh+hSi13mBT2pceGTLcAxm1imdJdi4347Bq6Arr6eLifa/ozc52iSpoe0lBBWuXE5ts8sUTZUIa6nv/bNd3JmDIUiB1RVb3Na30ZX2N+a4NW+HdvoXNM/Zzrevbdnl2mLL/tZeoZenBBjh4qTS1RuLw/QUhmselwn3neBgYxjdDOmxQNN22a+L99RvFbafq7nsBiXxQHfKc1pnjmzey77Ki4Jw8ScgculDBCPbGTEhrawBk0GD3aBdJe6JYyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm8vTWNKNXVJYWNXQkNsS2Zqb1JDOW1ONy9RbWlSVXdaN21Kem1mdnJ0aVNm?=
 =?utf-8?B?TFJPVGEwcWkwU1VmV0Z5YVlIaDIxVU1ZR3d5elBmZVVuWUFVLzVIbkhocHFX?=
 =?utf-8?B?czZ1S3RadmpZR2hoQzI1UnNuWUlhWld4TXpRQVRlNDVnNERTRHI2eXgrc01s?=
 =?utf-8?B?eDkrbDBJc01XNXVzRThLNzJEVXk0TnZLVTFPdVVvaHRHMSt2cXB5c1Y4dEVa?=
 =?utf-8?B?NXBNRm5xenQvY0VrTjQzVGpZZ3lLODUwS2hOamtBWnMzcHovenpUdVVsMERh?=
 =?utf-8?B?MCtuSlJKeldyeHZ2S0xkdmJxTCtTRktkYkZucEtsN0ZFTHZVdlBNUnlHV09U?=
 =?utf-8?B?VzZxbEUvbW1YZzZlbHJ2ZVNGTlBIZnNjTTVvL2pHWmorOHRUVkppYmxIa1dZ?=
 =?utf-8?B?ZytKOG1yL2hTTEtyYys2VTI4aUFZUjJ1cUVjWTZ3K0ZYWjV0VUhFLzl1NlJw?=
 =?utf-8?B?dVhpcDNGYTMzMDdZK3NkZnhEeURWSS9TS08ybVZVbTJodU9SakVhR2F6QmhB?=
 =?utf-8?B?S3l3VDBNZTUzclJ6Y0pEdlNxOGxUelpKcTc1L0lRL09nSzlCcUNnR01SRHNE?=
 =?utf-8?B?TEh6U013ZUM2WFo0OTNOYXRtVU4zSm42K3FMOXRJb25ZSWhVL1R0U2V0MzBC?=
 =?utf-8?B?RVN5WXlaMDhTdWl5Rko0TkNZcitTSDg2VUlLTGRzTDJtdjJCOHZlZkhuMlF0?=
 =?utf-8?B?WXF6UW94RC9MYVJMVHRCdXd3Z1paWXZZRkw4OHJhcjc0bVFhWVJQdnBQcWZC?=
 =?utf-8?B?cmNNSVRVMnp2ZUVKUjVxK1VOV3ZPV0toT251WVlONWhxVTVvUk1tcmJVaVdY?=
 =?utf-8?B?TkJaT05QNnAzUG9HbnlVUy82WTZCTFd4Nk5BTnlwbmx5Z05iL244cG9iVTRM?=
 =?utf-8?B?K1AwYmVZYndGMUZJcS9BWVFWOUZwcnBUS1M0bnJBVlBISjQwMEZoc0l6MzY0?=
 =?utf-8?B?c2xpajRtRU9QbFQ0Q2hCZFl3UkFiWTJTSm5yMFR1UUV3Zks4SmNkYlhnUlll?=
 =?utf-8?B?THhTcDZpWFByc3dEVkFpcVF2SkZvc2NXOEwrNGdqTkRKTjByZ2pla0ZrYWhz?=
 =?utf-8?B?c2MwbWJWS0drbXpnMkt3NVlNZ2RCWGxKZ3VzZlV2alA5UFBuMXVRc0Q3R0RU?=
 =?utf-8?B?MTM3YjlZSUd2RWVib0hZM2hoU2F1RzlYL1VlaTl4RnFyTEFOSjhEaW1Bd1dl?=
 =?utf-8?B?c2pkN2VCNjcrMytCcnhoMXdiZnFIRUNWUnArM0J0bW1PZnRsUW9YbTRma3NC?=
 =?utf-8?B?VndZSWZCL0ZvTWtsbFpPeXRVSHRoMjd6TVFhYUU4OXI3eWFNemE2YjlLV0FT?=
 =?utf-8?B?bkJDblVLTWx6Y2J3VGhVRWphZWpXb1h0YVBaY0VFY1Q0dytNMjVsbEFGc1Ix?=
 =?utf-8?B?UHg1dmpydmRqMmQrZ1plTHp1YWtnWStwT1h1bFdGYlBDay9Dbkt6bEl0aHkr?=
 =?utf-8?B?WVVHdFhtei95ZVYvNEprQk1LMDZDZTg4b20vSzJUNUwrNExoNWp1cTdwZE05?=
 =?utf-8?B?bGNmMURiSFgxbTVQTU9oZi96UkZQWlllVTk2YzNQMGpUYS9QYnJOQ0tDTENa?=
 =?utf-8?B?R2FBcU14bkRkNVJNVkRUZ2dWdURjWjExZTJHeU9aMzFNajA4eWlUTUtHbzdO?=
 =?utf-8?B?dW5xdm9CVTFXS2J0aEs2MC9VcEVxSnEwRkZvV1ZDZTAwQmVHNCtXWDhlUXZp?=
 =?utf-8?B?YjU3TmFSNThIamdCU2VJS3h6eWdGMHN3MUVkMXpLa1ZKYVFOdTFRcmRRaEFC?=
 =?utf-8?B?VUlROVAxbk8yZXg4N3hnUXFRcFVwYk1zeFpoUlo0cU9Cak9LVTFFbnZjMnlk?=
 =?utf-8?B?MkdqVWYrbWszZXJWZDRXOG4wd1F0MkRNT2V3WThzTTUwR1VKRGRqK1pzbVh5?=
 =?utf-8?B?WjdiZ0xxQ3h6S3ZaV3dTVHVxY3Q1Y1QrbkZXaFVIczRpYmtLQlZIZTZoZEtz?=
 =?utf-8?B?Sjdyc3ZqaHhlS0dxL1A3Mk92K3BDdkxoNW00R3loVHBaSTgyMSs1RDVuMi95?=
 =?utf-8?B?M3QwcGkveHRLVlJrYjA1TzJidXRiQlltL3FiaVlEUlM4K0VBcGtlOW9ucG1R?=
 =?utf-8?B?SE1BWnBncmkrd1N6c3p4dWZldjd1ZER5UW5tczRwWnlTVlVLWGVIaHBMWE5W?=
 =?utf-8?B?STFGbHhQRTFiMUdtRGhDazhiWFA5NHExclhXV2ZUZGRub3hKNzBMbEF4OGRr?=
 =?utf-8?B?c3BUK1R0TXVpV25SaFdONTJiNU5YQThWcDhCWG5TUDJsdGlHVzFCQ1NlQ3cy?=
 =?utf-8?B?dEZpaDhrc1labm5uZnRkbTY5WFdjNjZxdzBHbmE2RkRCejJEbkFzbldrbUNH?=
 =?utf-8?B?MWZacUVVS3hBL3JJRzJwTlExVXRqUzIwQnNKM28raWRnSWNKMTc1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b253356-1b12-4cb6-9d7a-08de994839c8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:34:22.1237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2qW5JGNWf0bBawtLdCO6zLd0Dv3WmYPEvfI6sAKsBndmAG8DvXLS6JE+fnA7frZQL6F6hMNCkvkxf2tydLneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> Allow modules to report data that can only be migrated after VM is stopped.
>
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
>
> However, when there're data only can be migrated in stopcopy phase, it
> means the old "pending_size" may not always be able to reach low enough to
> kickoff an slow version of query sync.
>
> It used to be almost guaranteed to happen as all prior iterative modules
> doesn't have stopcopy only data.  VFIO may change that fact by having some
> data that must be copied during stop phase.
>
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated.  This might be important to VFIO
> to keep making progress even if the downtime cannot yet be satisfied.
>
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
>
> This paves way for VFIO to properly report its pending data sizes, which
> will start to include stop-only data.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/migration/register.h |  7 +++++
>   migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>   migration/savevm.c           |  7 +++--
>   migration/trace-events       |  2 +-
>   4 files changed, 57 insertions(+), 11 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index aba3c9af2f..e822a2a59f 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -21,6 +21,13 @@ typedef struct MigPendingData {
>       uint64_t precopy_bytes;
>       /* Amount of pending bytes can be transferred in postcopy */
>       uint64_t postcopy_bytes;
> +    /* Amount of pending bytes can be transferred only in stopcopy */
> +    uint64_t stopcopy_bytes;
> +    /*
> +     * Total pending data, modules do not need to update this field, it
> +     * will be automatically calculated by migration core API.
> +     */
> +    uint64_t total_bytes;
>   } MigPendingData;
>
>   /**
> diff --git a/migration/migration.c b/migration/migration.c
> index 68cfe2d3bf..bb17bd0e68 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3198,6 +3198,44 @@ typedef enum {
>       MIG_ITERATE_BREAK,          /* Break the loop */
>   } MigIterateState;
>
> +/* Are we ready to move to the next iteration phase? */
> +static bool migration_iteration_next_ready(MigrationState *s,
> +                                           MigPendingData *pending)
> +{
> +    /*
> +     * If the estimated values already suggest us to switchover, mark this
> +     * iteration finished, time to do a slow sync.
> +     */
> +    if (pending->total_bytes <= s->threshold_size) {
> +        return true;
> +    }
> +
> +    /*
> +     * Since we may have modules reporting stop-only data, we also want to
> +     * re-query with slow mode if all precopy data is moved over.  This
> +     * will also mark the current iteration done.
> +     *
> +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> +     * size too large so it will never yet satisfy the downtime with the
> +     * current setup (above check).  Here, slow version of re-query helps
> +     * because we keep trying the best to move whatever we have.
> +     */
> +    if (pending->precopy_bytes == 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void migration_iteration_go_next(MigPendingData *pending)
> +{
> +    /*
> +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> +     * into the core layer.
> +     */
> +    qemu_savevm_query_pending(pending, true);
> +}
> +
>   /*
>    * Return true if continue to the next iteration directly, false
>    * otherwise.
> @@ -3209,12 +3247,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>                           s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>       bool can_switchover = migration_can_switchover(s);
>       MigPendingData pending = { };
> -    uint64_t pending_size;
>       bool complete_ready;
>
>       /* Fast path - get the estimated amount of pending data */
>       qemu_savevm_query_pending(&pending, false);
> -    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
>
>       if (in_postcopy) {
>           /*
> @@ -3222,7 +3258,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>            * postcopy completion doesn't rely on can_switchover, because when
>            * POSTCOPY_ACTIVE it means switchover already happened.
>            */
> -        complete_ready = !pending_size;
> +        complete_ready = !pending.total_bytes;
>           if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
>               (s->postcopy_package_loaded || complete_ready)) {
>               /*
> @@ -3242,9 +3278,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>            * postcopy started, so ESTIMATE should always match with EXACT
>            * during postcopy phase.
>            */
> -        if (pending_size <= s->threshold_size) {
> -            qemu_savevm_query_pending(&pending, true);
> -            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
> +        if (migration_iteration_next_ready(s, &pending)) {
> +            migration_iteration_go_next(&pending);
>           }
>
>           /* Should we switch to postcopy now? */

I agree with Juraj, postcopy condition should also consider stopcopy_bytes.

> @@ -3264,11 +3299,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>            * (2) Pending size is no more than the threshold specified
>            *     (which was calculated from expected downtime)
>            */
> -        complete_ready = can_switchover && (pending_size <= s->threshold_size);
> +        complete_ready = can_switchover &&
> +            (pending.total_bytes <= s->threshold_size);
>       }
>
>       if (complete_ready) {
> -        trace_migration_thread_low_pending(pending_size);
> +        trace_migration_thread_low_pending(pending.total_bytes);
>           migration_completion(s);
>           return MIG_ITERATE_BREAK;
>       }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 397f602257..b75c311a95 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>   {
>       SaveStateEntry *se;
>
> -    pending->precopy_bytes = 0;
> -    pending->postcopy_bytes = 0;
> +    memset(pending, 0, sizeof(*pending));
>
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (!se->ops || !se->ops->save_query_pending) {
> @@ -1779,7 +1778,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>           se->ops->save_query_pending(se->opaque, pending, exact);
>       }
>
> +    pending->total_bytes = pending->precopy_bytes +
> +        pending->stopcopy_bytes + pending->postcopy_bytes;
> +
>       trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> +                                    pending->stopcopy_bytes,
>                                       pending->postcopy_bytes);

Would it be convenient to also log pending->total_bytes?

Other than that:
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

>   }
>
> diff --git a/migration/trace-events b/migration/trace-events
> index f8995b8d0d..2f86ad448e 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>   qemu_loadvm_state_post_main(int ret) "%d"
>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>   qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", postcopy=%"PRIu64
> +qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
>   loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>   loadvm_state_setup(void) ""
>   loadvm_state_cleanup(void) ""
> --
> 2.53.0
>


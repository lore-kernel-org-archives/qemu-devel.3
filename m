Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7763109C04B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5S5l-0005eH-1r; Wed, 25 Mar 2026 13:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5S5h-0005dh-0k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:32:25 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5S5f-00034v-Dq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpmsZsz4Q8MmO8Bk69Zxd5NsaBxFLwv7xu2cEk/R4tZRGF9FNk/4vHozzCuD/1/guWYByjw2+Z4WL5FFDKwwfC4H3fb+3wHmKW7l7fA4bar2wdxKkcOCS5brXEm4O1E6c5ZKj0xVzs4Xn15+4QO6KZzwDRNnME3TylFpIxqboHXoDEAwXTKFjsFyYgC9f8ZNkrxBGdhuBK9AVSz9mpsNywJ72FXN+60/pe/3iMigtS4SfUn5JE1WPAqc+34GHW4mPLVWq34APQJItE8iNzjO/TPASxJUa0vuRHUBV2MlwUhy44kle1jLVvk6kAmEqTpzbdCkqHojGMCv+Q36RIThBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4K0MMqMlK/t6kvk+c/x7vP8DKEg6MHaijHfmLAfy9E=;
 b=gNBMs4r+HVx3IAmyjRX/lC+tCTawSSv/AJDVNFLZ3dt451YecFUehli3XUwc8CWdRqdYhNWEXNNseyXNuJ16wCFPDKxgRk/3ju0tHjOPulKW2qkDtzTwn2H101lHts5nacvPST6AeY3/UKBv1SmVrtGxn02etOIQC7/CBoTf8U6TEbxYVvDTfIOw4FL1/+gPBLWZ3q0negwImqMVYjpeko3gdgxPzfMZpycs43nsHl44YtoHhlYjImhRJbhz85lWyuz/EEK314bXNtArQbKZTFvfqiKyfA5Vjq7Z97KEL5oiGUyJkOUEvzCr6NE245vmBnbS31A4Vzt+aPJeZPvDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4K0MMqMlK/t6kvk+c/x7vP8DKEg6MHaijHfmLAfy9E=;
 b=hGTjun/RkwyPuB+RopWONQCXgxEQJDWK+bcxGnRa6quE2fk7vMIEStxeKxR8L5UzLiZ0O2LkKk0t9kB7hN+bnN+X1n9YeYo38AQJMwOIAeq0JjecIui3zz8zJZ2MUE7b21Vu2if3bW9IyTasM4PEjkIBMZBi7Gsa15CEKCx4dZ+RGoXN3hynMLcTzdYvgYSE8RE2RJfy31+JDZnZYO8jbEb3DFONMkCX1xene3q53Rtc3Ig/LGV2RyiqLgGTsAak6mZy28jy5xbvGRT/KqgUvQJB4SzfvDq8i+IjI7lsJQhk7G63UdGF0/+JnQV+mniRaJxAkitwwbadjK10eeb1oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 17:32:17 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 17:32:17 +0000
Message-ID: <e6a9aaf2-e2ab-4b25-a01d-b6093922668e@nvidia.com>
Date: Wed, 25 Mar 2026 19:32:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/12] vfio/migration: Fix incorrect reporting for
 VFIO pending data
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
 <20260319231302.123135-9-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260319231302.123135-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c3c97a-6df2-4d3b-10bf-08de8a9475fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: eXOkskYtkDXS+0GcNAbyY86VLAXJ4rXnKMnlGUFUzhEUzmOXFX6CNdAaKjK3gJ0vTMxf0FhneRL+bKP2+l86bTz38immmmLXI/VQ0qx+Ie5xZWNc/1rbfUkegqVFREMnrbCixBx64wLRN04Rz5NN/QO048WR9mN8n5KADkUoAuDGcZ5e3aII4eyTDvh/qyZKCHHq+iMu7HpVwycraMsrUalcb8NBuJevA+AYLC2cuLzcG2qGm1J7O2KNJsm7QKdG3oABa4+D7xtbqTGEKP6HTMvLtDUvCzsiHwAmoFCZdgPe1fQuXus51yQhbq1KtqhJ5qP2FnR5cEYOXZD1+6uRLRqIc958SSaWoy1Q6FIY+yRll19mIQxmYQCXP/0OJdjROUVd7Kkke4wfxh1eFVCCccWEAMLGOcPQ+cw4r3Ytxu5M89sa8hBskR3d66oWZPfxRZPsZbqJbVY4iKqk8cp/YHeedLczhZojT2czH8vWwnqvNSzjQh4KWtVrteI2X5xCR51PHDUmYr//lhUAI3YX1gWYpwVz3TGpTE7F8G0HdFMgANWvoZ+SvZRf1id/aQSFB9wRK6dyc64xVSk6RkymIwBWN9yh+Is/O/vYPYJdeFnjkQZhICO2f8seHkAHkIJ3Vxk4NC5BInYRL9JSNF3edxmuSQpAQKPBnFfSPJHeo4Hn5/vCPhSCRs/o0Oa+iVmJW4EDq59TsjsWVnzdwlsneveVyek50HArSTvkM7S3C04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXUrY1NWZG5laTByeDRmamhyVGlXNlQyL04xUkkzbkVWQnFFa1JOOE1iODI4?=
 =?utf-8?B?K3FuSEtMWHc2ekFHOTMwOUsrVkRQMlBhY2oyKzluK2cyL0xLdVBMSW4rbmUv?=
 =?utf-8?B?YlMrcXM3c2NSL0dNcTJ3Mmdya2lGQTdkaEpxYTR5blFUWVM5NjBFOXNGSy9v?=
 =?utf-8?B?blNWMlM5T2p1RVlSMTdteDQ1L1FSaDZjdVZaZ29hN3ZIYzc5SGcxMmliQzhN?=
 =?utf-8?B?RXJOWFg1K2RJdWVqb0w2Z1lYeGNpTGlwWlVVZlFub0R0SnhyQS9XNUl1dmhw?=
 =?utf-8?B?NHNEUHdKUkh3SDc3aXk1YUwzQ0NQWXBPNStjK21SYTlmMHJxWkVveVJxOWl0?=
 =?utf-8?B?b05FWDBKaG0yZ1ltZW96aEF5RWx5eHdLQnpyQ1R5RHpvZW1DMXVoVCsrQVpN?=
 =?utf-8?B?b1RCNFl4c0Q0RTFacm1CL3VrRndiOW5HUHBlQTR4YjEvN2VqaFpmQXJVNk8y?=
 =?utf-8?B?OVBwUHRJWlRQREVBMGtsUXJUeXB2SnhheDlxenNWeTU1Qkl3QmtKVG1CMlMx?=
 =?utf-8?B?UUhMYWNqNTc1MDI2YU5kVk5NMjUvLzU3aXl1QUFYd0FPU0h5ZlRSRE9oK0Rp?=
 =?utf-8?B?cFh4UEFwUktJMDdoenFtellpbFUwMk5rVzNmWGJCV0pZWFpXRjY0MS9HVkVz?=
 =?utf-8?B?UnBuSUFUWVVZVUtZVWZqY1RmMzZuU2FjWW02QmdrazBOejRORDVqTjV5TU44?=
 =?utf-8?B?Ky9NbTY3R3kvaTJwVmNsa0lBWTlXNXJCd1VRZmpmOS9mNUlKTEd2b1FveHNF?=
 =?utf-8?B?OXJXV1FUaEdidzN4YnQ1bHdaVlNBKzRXK1BURnA0S3ZFRU5aK0MzamdtZW50?=
 =?utf-8?B?bmVvb2REN1ZUQ2xUWExBN1VNSEJ6WUlHRWNXcnY4eHhSVzVjbTUrdXRkNzNQ?=
 =?utf-8?B?am1PSjZIN3c0UTdJUjJaQVpURUU0WWVIUFpNUHA5VlBGMGRwa0FxUmN6ZE1t?=
 =?utf-8?B?ZFFFSG5wSzY0ZEhCZFVuck5IQnd1MnBZMG1lRlNvQWoyS2xER001OW1KNlVW?=
 =?utf-8?B?UmpkVEsyM0phV0FJUXIwUmJEZXJJY0hmejNKSUVmNnBqb1EvSlE1bG1HUzhk?=
 =?utf-8?B?TnJyWGdVNWNRMjZ4UmIxMXpNYk9OWFlNWDZJQTJ4SFlFZmJ5NFAzU2dmOGt6?=
 =?utf-8?B?ZTFsS0NkRUNJcVVJaTlyTzZlMm5uRjlJaG1LV1VJNWRtY1RlaVRjelgrbWtQ?=
 =?utf-8?B?djdKT3lveFNtUHBrTmd4Wjg2Nm9ENHcwQWthWDAzL00xa3FwK1pnMXpHYkk3?=
 =?utf-8?B?Z0U3c2VMckg4UWxTMnVBMnBYeEdpay8wUk1QT3VjNFEvc1V5Wk9GSk15em12?=
 =?utf-8?B?Z25VOUpqOW1GNHBJNkhFR2dHTUpzeWFEZVpabmRGSW84TjZENDBnbnlHT2gy?=
 =?utf-8?B?aXA0dHlndnhjZzFUaXZ2bXF0dmR4TTFuVGZXc3ozbGFZMmlkbFF2MlZmWFBx?=
 =?utf-8?B?UW5ZNTZ5MEkvdDR6dkpIMUR1dGlERENVejhxSEV4amVmK3NWekdIWFR0ckMw?=
 =?utf-8?B?Yy9McVhJRFB2azFmVWhDRGhoSlpKVVp1NW15eVBwSThhK0pqWVhPekVvMGJH?=
 =?utf-8?B?d1l3aUxjblE5OWtWbHVkMlMxdVpHRlA5WU1JSUJGR3ZyaUdLR1ZrVXlmSWpr?=
 =?utf-8?B?eFlaS1psR3l2TVA4cEVMS3ptbEdHOWw3d05ucWZwUGYxZWVsb2JqS2h3TG1M?=
 =?utf-8?B?dTFzR0VHVFpsN3BLU0NwYUFlcHpqRCtxK0V0MUlzeFg0SXVhTHg2SU5ZVXhi?=
 =?utf-8?B?K1U2WFdXamZXTkpDeDgvU0hTTHQ4d2RhenJaampxdVBqeFczMG5pRXZvM3VX?=
 =?utf-8?B?YUducDI3UXJTZEdla0UxczB3NDl4OHFORjNPNkJqbkdvSVd5T1dvUmMxc3lD?=
 =?utf-8?B?MjZzdmJEMUVUM04vK1M1VEZ4aU5GWVB6YndsbUtBMFYyeUtFaU1ZbDUxRXV6?=
 =?utf-8?B?MUlncWVZditWS1RhTm1aSmFGZjlrWThvL0xLMU5wK3Y3eHlGaDdxRzQvdGhl?=
 =?utf-8?B?UGEyZGF3RE5ZZi9FUk1SUXh3U1lGdjJ6L1R0RlF2bDNqQXRScS83RFBqZ3NC?=
 =?utf-8?B?QjJBS0JEZU5sOUs0cFVYdTM5QmlHS2tiZXlneHhwMXRwaGlrUTlFblIveHJm?=
 =?utf-8?B?OTMwZDkzQVFUWFVGbkM5eEZPL0JvSmo0cjRhYnZFSUVBLzdsTFJuRXhha1Vj?=
 =?utf-8?B?SFNDRzU2aStrUVRPOVBFK2hhZm0wTzkzdEIwbGlRU01oMHdLTGE0Z2VuaUNi?=
 =?utf-8?B?cmNSQ3lsam5ua21OSUtUVmxPd2R2dVYvOFdSd3MwZlpFMHExb2ZxME1tdnlC?=
 =?utf-8?B?UGVlZFFtRUZUcGlzcnpjRjhmelVuQlpjeU9wTGlCSDRjRFdYbTZJZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c3c97a-6df2-4d3b-10bf-08de8a9475fd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:32:17.3955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySbyJmwzM0W1XOPcrO2oma/TNOEgqTI23dutCrLLiQa/aKqMNdqhZPKb0i47j3w3wOJSk9ZL3OLcC25od0B/6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
> VFIO used to report different things in its fast/slow version of query
> pending results.  It was likely because it wants to make sure precopy data
> can reach 0 hence trigger sync queries.

It was to guarantee precopy data can reach 0 and trigger dirty sync 
queries, since not all VFIO device data may be precopy-able.

>
> Now with stopcopy size reporting facility it doesn't need this hack
> anymore.  Fix this.

Looks good, now the fast/slow path are consistent, plus we get the 
benefit that if VFIO device has much stopcopy data, migration will try 
to reduce RAM/other iterative devices to the minimum continuously 
instead of jumping from fast to slow path as it currently does.

I still want to test this later with a few workloads, just to make sure 
we don't miss anything here.

>
> Copy stable might be too much; just skip it and skip the Fixes.
>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index c054c749b0..9dbe5ad9e9 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -591,6 +591,10 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>                             __func__, migration->precopy_init_size,
>                             migration->precopy_dirty_size,
>                             migration->stopcopy_size);
> +        migration->stopcopy_size = 0;
> +    } else {
> +        migration->stopcopy_size -=
> +            (migration->precopy_init_size + migration->precopy_dirty_size);

Query of stopcopy and precopy are not atomic, so we better use MIN() here:

migration->stopcopy_size -= MIN(migration->stopcopy_size, 
migration->precopy_init_size + migration->precopy_dirty_size);

>       }
>   }
>
> @@ -598,19 +602,18 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> -    uint64_t remain;
>
>       if (pending->fastpath) {
>           if (!vfio_device_state_is_precopy(vbasedev)) {
>               return;
>           }
> -        remain = migration->precopy_init_size + migration->precopy_dirty_size;
>       } else {
>           vfio_state_pending_sync(vbasedev);
> -        remain = migration->stopcopy_size;
>       }
>
> -    pending->precopy_bytes += remain;
> +    pending->precopy_bytes +=
> +        migration->precopy_init_size + migration->precopy_dirty_size;
> +    pending->stopcopy_bytes += migration->stopcopy_size;

Now that migration->stopcopy_size holds only the stopcopy size (and not 
stopcopy+precopy), we should remove these lines from 
vfio_update_estimated_pending_data():

     /* The total size remaining requires separate accounting */
     migration->stopcopy_size -= data_size;

Thanks.

>
>       trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
>                                migration->precopy_init_size,
> --
> 2.50.1
>


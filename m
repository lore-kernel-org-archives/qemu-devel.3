Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D9BC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRfp-0006ri-8X; Mon, 11 Aug 2025 08:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ulRfh-0006pB-SD
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:30:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ulRfc-00084K-Bb
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:30:37 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uEB2004951;
 Mon, 11 Aug 2025 12:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ITuTaSZvGv3pacvThg7NQlM9StdMdyUMjSjEhX4nxBY=; b=
 mdh3e8LXprP9d8eACnLfhoNxfqSZmeF1nRGbENUoa5uKcu2kOECSs86R66iJWcyj
 naXTbnbKd/kxpKu5l2lWBOBkJeeDfmmzWYwJcZGb80VLFFxq+aN2weuxQF9rSf2t
 wQJzuztU3mjJd3SCPPkg9hdX3BlQL8Y0jmtKyyjw+VD+5FwPnvRJ9MPCYj/DfKQ0
 lPAUZko1yq7HeZkZD07v80SKnO9m4YjRcsCg92Fkhp4MWjKwDLvHs7xZgaQimpta
 snKp652CMKS19Pfj5P0a7IdelDe2Wki5FfMR6SY6iTRtMBBn9zhP8QUGWvexGs76
 ckZjwoyNwotV9AnWn3yGLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4acub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 12:30:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57BAkGF6009843; Mon, 11 Aug 2025 12:30:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvseutmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 12:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Owq8dakWNw/cgqfXh4puUGkqsBLQfgRYrtqgT8rLDyuQxcsu+V158L5JPnKXLWmTO9sEQa2KflbdMEnbCrXWwY/fMhXEbSDGBPQm30y6o0cjIE8Kr3UfFZeGvi3Yv+eadq5J0KHmmgiE6a9M6Cqe5xWfesSnuHtOI1cZdZElWnbnZzul/3K5LM6nMME9bmbV4VNbviZrq+cyb2HrlfYi1bouhM5fmuN7wQz6taAuFbgvo4ap+VZUhf7QGObFwFt0yovOa1qAHVOOgbA5AeUkjTOYrjTDRrFFVaIqhC5XhfjatYAuJo2o3CWA/woE3gLYWpg0ftcRJze7U2lLVnOmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITuTaSZvGv3pacvThg7NQlM9StdMdyUMjSjEhX4nxBY=;
 b=b+Xlqe6BjfF1/O8cs8YQMknrHlTL5QWgO6UDgkGju8Ul78sKYPEv9A+GYoG8OdDIWeWkY1XHEy2lyKEkM9qDecombw2UBJK2Vdpiy5XJw0sFc10EgyzFVR2tMGZjAk7/91T+khJR7DVDKOSTkAOxwl3wXM0DuC0TxRBKB54X1n7igPM/50D27Tha38Pmqy0DYMFoBO/3rqqbmUR7vw6soVKPQ666FbH2ZVH8Q1lozIb6DbuNZLoDNksda5f9EujS/cqAUI86OIh09Djf/WqJIgepwlXBwW26YlKC0YWGjf0l+3m93y2Dlc09M936NyjHBxXz93RvD6gm9sirT5U+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITuTaSZvGv3pacvThg7NQlM9StdMdyUMjSjEhX4nxBY=;
 b=ehmNPxplQveKKWKYnz7ugoDIQuCUwOlNpg76DI/wpx2FgewO1CN4dm1PuONRpAwr5CEKw/BoRACknCIHSxQZu2Iysp8ytgk7cwKAH51rAoPru9q8jA4kagFlGpxQfDrKUFkSi8P2FK0jtg0m067PpvxwAv88u0o6rrSA2Q9M+j4=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:30:22 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Mon, 11 Aug 2025
 12:30:22 +0000
Message-ID: <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
Date: Mon, 11 Aug 2025 08:30:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <aJTU641465aGKWRU@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::18) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 6434919e-be8b-410f-a811-08ddd8d2d764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXU2UTBYZDhLeVZobVZRbWFQYWdXTTlOQm1lWG16UWYxUEJJMEpJRW9PRG5z?=
 =?utf-8?B?MVc2aE9rUWllWnZ0eTZ5L3FGMHhaV0E2Z3V1NitoN3lPVkhHc2xXREdNT2w3?=
 =?utf-8?B?cjBVbk5qdGVpK0k4QXp4UWNKTEZUS2tjbUpSOHVQSDJsd0FuV1o2cmxHb3oz?=
 =?utf-8?B?OTVibVlFTHhUOG45OTdJbjB0UkhSclpITDN4WmpTc0U4bXFVMFNyTnQxT1lq?=
 =?utf-8?B?VlI0NjhRa29lYVhlNElibHMyWjJhYUZQbm1PUDB2eHhveHRsM3JBWnlMNW9M?=
 =?utf-8?B?ejdKbnAyRHNzV3c5TGkrZk1UbkhONFVaU2t1RndXc0hBU0FpbUZXbWxDZ2Vt?=
 =?utf-8?B?c2xjWHNvd2tvQ29GTjIvMWkzMTM0NG1SZWJ3ck1saWsycFBPS1FwVW03Smoy?=
 =?utf-8?B?ZVJtRWFMblFERlMyTjBDOHZ3Zm9VUUMwM2o1VlBnSE1tSkFwcVpQVEZhaEgy?=
 =?utf-8?B?bjRLS3M4NWZHVTYwK2E4MEltVjYxTk11bngyN1FIRVZmNXJHR2ZQYnYvK0lM?=
 =?utf-8?B?ZWJSUk4xbGt5aGhtcHdHOHZjSWNDTXowSVVZM2hXOTFpLzZyU1lLUGduSlFl?=
 =?utf-8?B?cGJzT0l1VWtrWldQZmtrSmJta1gyL1Y2VEQvN2g4T0RxZmIxclozOTdvZVh1?=
 =?utf-8?B?TjQ2UEJrVjV5aENZbDRCU1hSeS9WYWhrNGxHK250WW5BYlROTGhCYnQrU2Vz?=
 =?utf-8?B?dlBjWXJTaC9YaXZJekliMkdkbmdKbUJ5MjJ6U0xiQnNGSWVzbTJMaCtlT3FX?=
 =?utf-8?B?L2JweUpqV0YrTGREVmRRNy84UkZKR1R3dStBL0NSYVpKRTNsM0xiS2p5d2NI?=
 =?utf-8?B?SGo0MS9hT1lBMWhCUjBkd3B0L3FMOEhFQmpNeEhEZ1NuV2NZc0I2bVc5NUNh?=
 =?utf-8?B?WW4ydkR4TERmVXI2dHEwS3ZGNmtSaDZLNEJuR0hvWnQ4Nkhod2lqQTBsc29n?=
 =?utf-8?B?aFVuaUdRSEYwQjlhcWdFRTMzZ082Tm1reHBOcDBFeDhrSzY2S2JCa3VZV2VZ?=
 =?utf-8?B?LzBJT2ZVS0MrNXBqTk4wcXFxUmRlQ1NsMTlqb29VbGZOMkNqU1lNS2h0R01Q?=
 =?utf-8?B?eExjS3lndHMzb2VnSGxITDlEcC9YT0dkK3d3UTEwQWVHWXQ3YUtGQ3pLS1lL?=
 =?utf-8?B?VkxNdzZRdzgrZVZCcFlKZmJjK2Y0YzBMYnN3TDNOckNyN1R1aTcyRHRFdVU4?=
 =?utf-8?B?KzhGdk9uQ010Y0VpRkpIbFlxbysvR3JQVHFLbWMxYm05QlVPa21pT1pNdE56?=
 =?utf-8?B?VjdLZE40VDczUUszc3FHWHpIVjNHbEx0UDNKQVVlMTAzT0cxaFErT0dEN1Bv?=
 =?utf-8?B?UVQzU1UvaGlEbXRmS3dGcVZjZ0MyTGxNMUFWOTdiclJUYndIQTQ4NmJNUVJ5?=
 =?utf-8?B?V0hiQ21oV3hqQVNXY3hyVlB3N2IvTnJtTlZWVjFaVE55WHQ5eUVIempKaFR1?=
 =?utf-8?B?WStaYmIvOGtvck9kRG54c2E4OUhLbUNjSnU0UWtYSkJhK2F1M1ZyWC96bFBN?=
 =?utf-8?B?K3V4VzZWWjhDamwvSVIvMmpJL0RyVXZvZDJZOXZya3JKSXNrZHJKczJ1Nmgx?=
 =?utf-8?B?ZERkVWFoa2ozMmJlZmJhV0l2NjFaSWM0UHoxUS9zaGhmcVIxUm5aZ1BGbWFz?=
 =?utf-8?B?Z2VaR2xGZFppaVdPZW5LMFpkaldneDhjd3MwUUpiRmNMaWo1R3dDWTE1S3V3?=
 =?utf-8?B?dTAwaEdZZURLYnJ4QkVMaGJDVGpLelZMdnFkemZOZGFueitaRTFLRWYzemR0?=
 =?utf-8?B?OElqWDczK3J0Z2hiNHJ4T1NYbll5TVdJNFJFeW1RM29md1dYYVFRcFQ2MnYw?=
 =?utf-8?B?cUlaWEFiMkh1ZTZ1UEpZQ3BKSFhEayt5dkJZbXJKR1lMVmMzbVVlUEVDTk9s?=
 =?utf-8?B?Z2pJaFl6VDF5UGd5UjE5a2plUk81eC9RUStzWjVzZTZMUGk3aDgwOHBHaCtm?=
 =?utf-8?Q?Nx5HjBaz5Cc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxwWG54c29rUUV3TElndVZxdjN1TVJiK2lnM1RDR0hYWmEvd1JxSm1sTjVP?=
 =?utf-8?B?WS9oUmNSZDdTVElja0FSQTZVQTYxQ0xtWmFQelQyV0I5b0d2STRvbm9jUGMx?=
 =?utf-8?B?dlkzM3BMQWNiK1p6M1ZKOXg0QThKODhXWHNvU25jSWFUOEpRcm9MR1hZcklW?=
 =?utf-8?B?MHZsVllpbEFlT1JkaGZxSGMzSWY4YTU2QWQ5ZlhyODZPbWJtOHhqMGYxc2Fp?=
 =?utf-8?B?ZVROa0F1bEZIbG1HeTVJNUhtYWozUk80d3VweTJWRHVMNVIzWW93UC8xaGt3?=
 =?utf-8?B?ZjZyb3NuNHd1ekhlOFV6MDBHVzNyV1N2Q3ExYk1ETVA3TzFtN3p4MUEvR20w?=
 =?utf-8?B?ejBXZi9xazlybzM3Q0JlRWxDVy9rekV4Q2gyY2NwM0JUL2lZL25sM0NsTi8y?=
 =?utf-8?B?aWVSajREZEJVM3BUNzl2QVdxNUVSRXY2R29ORTJNaWJIekFSN2Y1T0NUanV2?=
 =?utf-8?B?U0dGUEUwOTZxWE1WUjE4aDVhcGM4Q2F6cGpaTGVxK1crL0NsVWVEZ1FFZzZM?=
 =?utf-8?B?VnhmbGI5ZElCSC9GNE5FTDAxakJLeitNQjNSMnVFRXRpM3FMbzBvZURxZlZt?=
 =?utf-8?B?R1YzZkNVbDhvWVh3eUdEV01KOW1QTHpHV0RSWGlTNXRlWWo0a3BQNU9waUly?=
 =?utf-8?B?OWZ1V1NsM3FJd2x2L0d3a0kxU09ub2I5MGRNaXdoT2tLT2NRQ1l4V082R3VD?=
 =?utf-8?B?ODl6OHJWdG9zOFJweTNPMHZ0ZjFSYnU0Y2ZEdm5jMVJmRWphd3RLTm01TjVp?=
 =?utf-8?B?ZEhRNlQ2Q0xqRzdhWHcxNjZSbUlnMy9WTHJ6OGpqYXk4Nk1ibXlQelNvNStI?=
 =?utf-8?B?dVRxT2RUcWYxSFA3UVhoVmgwQmJzQzRFRi9WUnNlS28yV3h3eUp0MHBkbUhP?=
 =?utf-8?B?M0ZSeFhuN0l1NUNwV09MVEVaSndTbHl6MDJ6b1J0MHdiK3ExNithR2pWTEFx?=
 =?utf-8?B?cDJRVGRwcGhDNkw5NDZTN1VuUXY3S25JSWtsQ2tFY05DblZYSHhvNThocnRl?=
 =?utf-8?B?bXZqNjl5MkdVdEswZGFFTk9VZmRKUTUvYmQrKy9xTFBCdm84djZLWXN1V1k1?=
 =?utf-8?B?djR3eUdndXY0dndlbm9wVlpSanI2dXhOdkhyNGVka2NRMlhYMlV6T3Nzdzdw?=
 =?utf-8?B?bHh0VWVodm1QV0RjamVRL1JpVG1qRllneWRBdVhLQ1N3WXRXQU1Vc200Kzls?=
 =?utf-8?B?REEvYTRYWktqeUdOQ1AzWEdVbU00Si9VSytaa3cyRVZmQUdCNDB1TTdaTnY4?=
 =?utf-8?B?NDFORzhKYk9ZSUh2ZU42emhjUTZ2NW0wY1RKYnR1bHZSNytYUTFNNjdiL1RV?=
 =?utf-8?B?NnlCdEQ0YWp4OVNhRWNrK3VuNWVUODhJTEMzdUc0RmFKcTIvdkFJb05ZVVJ3?=
 =?utf-8?B?Z3JmM1dBUmVsY1BDbGhmS2xrZUIzUVRUK0g3SnhvY0R3c1AyaGFKazZHMjE1?=
 =?utf-8?B?UHZRYWNOTnZzQi9kRlRkaURtenQwVXh1Rms5MjRsN1JqMGVCaUUrVUp2emZL?=
 =?utf-8?B?V0V0ZllYeFdMVXFFUkRRYktvVGYySU0yS0lQbWxEaTFxMmUzeGVWNzJWZURC?=
 =?utf-8?B?QXFyeFRwY2JyTmltYTlRazNCN1ZUN29rdk5TaWVwcW1BR2VvYlNiMHlqM1pI?=
 =?utf-8?B?TWRBcU5JdGhFZENtcVJKdEV2Uzkwd05mNHkvWi96MjExVUNOSnhSUUwvMTN4?=
 =?utf-8?B?M2k5RnZqTXF5MG96bnV0R0J5S3NvbWJHV3V6ZWFCK3dMOUVqRm5CdW5QWkEv?=
 =?utf-8?B?VkNnMm11MmdYMGFvUVhHNTBUS3YzNGhIelAyTWRtTWE3U1FKN2Z6ZzNzM2lW?=
 =?utf-8?B?RzliQTd1alNnVlBJVVp5R0ErOGJPbkR3aWlyVDFCWm9COHNoYTdibUJNYjhh?=
 =?utf-8?B?UnNobjhUUVZtSjlwY1M3Skp6cU1GOHJkQ1BEOERYRi8wVXM2SGZhc0NJRzdD?=
 =?utf-8?B?Rkw1Nno0eUlqc3duSVprVnp4Qm1PMnhmeUZUV0x6aEpQZFZYeFA3WjdFVjM3?=
 =?utf-8?B?L05yWHJXNHA1SGVUMFloaTU1eGlYZlFkblBwbnFCWmxZbmpWdW05aXluOHZC?=
 =?utf-8?B?Q0xQTGlheVdVN1c4UjZGankxTC9YKzRmQll3aktBdk01dWNXcE8wS2QrclJm?=
 =?utf-8?Q?6pLZrYVwSiv/JHPmH/Dw+fRaH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v7dT5vX0J+irORh/bd3yeHJU8qFm1jYahc5QUaHZRY4nnGgIJVbIplSt/outlH6uTBdzvi/2ojuFdQ4ET4oJ0Ar4UHdLQoYVmlD4OBzOXLDTrdlI4i9rSEpdKwaxMVXgRefExnyePVM3zASaB1Vl9jWuIuLl/Yr4cZK/1YTJCvZKEMyLyb7c4NtZHh9xGFw/w5/b0wcnw7nntdZdu+0pyvVsmbgQdf+6NdnGLDBLGjiwBj3B9anpuhs1yJlC3iP67N0irM8lpjyLN9MsUAZqpWTz4oapiUEhxgsYRWJmbs4smNL2Z27fsqvkKgmraVXBSKpv3kXvP60mtDW1sArnClMknmPagLnRu/S2n4coMBPdVH/zCoRbA1huebEPpSxwetnhZwW9HXwLZW9KM2UNJsaJHtadDat+nrQJRXzEM/ETEkGZ3IBpk8lHGXopLF3fJWfXiQC4ZVmYFHQtGKwZQP/m9A+IlL8uxSWmnWYlN/u/TXvxO8s2075LKtdqgV6XWkl5aKa7jYVrvTAqm+dj/fVEyomr+H/3/S07nXv579pdzJY/bJozIpfQTb5yFWtkeSNnOC1BMwcQhRjZikGBbHhFbE10/8UDxG9Dn0R42cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6434919e-be8b-410f-a811-08ddd8d2d764
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:30:22.6430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJJ4tnkmG/jS9yWVcOUyDsQVOUU8Pf5qOR+aW2fqSZSKukGp6dZNz9/c//ICY30VHAqV36AuLXrx184baNKMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MSBTYWx0ZWRfX1ZG9SfGIEGLF
 g07pCzls419SqK6fZETILU2nJpOga0JbNCnJqUQZ+zW4NyfEKBkPrZ/t95YLewSb6oZFimIHF6W
 qbmIKJSWgc8M01/Sbc4m5LfP7vo20CsNJZzVOqwadw7Lss0oxQfhyKWTbL8yjRMIWBl5ac7ps6M
 zMBPCWboTQeRsF3Jzb0t1gG7r3WbmSGsLAXhNyC8Aou9/vUVqNjhz+LtJLlq7Xl65TdTirFIrC/
 mZlW8i3h+zdxICA55i/4QTvZsENs70gxn2Ms18isQHg0mAKX8M7OlcGWhILTnukMuZdccvApP5R
 SF3v4kQCQ5uAs2UG1mMAIdd3t38noCUmUo8gURukbvLflej13SzsB41JcY85lV31TG8LVq4DC8i
 rt7h2LWJOxBxCwI/mOAbulNjWUHzAzpJBII2tTTk0Vx3T09Icfj4eS6SBy5zgxsEkwZ5DnZn
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=6899e262 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=968KyxNXAAAA:8 a=jFA-VIlMxBtzzu4D8psA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: tuH1exDLZfk0gBF0Q6FxsrVluGXH5Ziw
X-Proofpoint-ORIG-GUID: tuH1exDLZfk0gBF0Q6FxsrVluGXH5Ziw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/7/25 12:31 PM, Peter Xu wrote:
> On Thu, Aug 07, 2025 at 10:18:38AM -0400, Jonah Palmer wrote:
>>
>>
>> On 8/6/25 12:27 PM, Peter Xu wrote:
>>> On Tue, Jul 22, 2025 at 12:41:26PM +0000, Jonah Palmer wrote:
>>>> Iterative live migration for virtio-net sends an initial
>>>> VMStateDescription while the source is still active. Because data
>>>> continues to flow for virtio-net, the guest's avail index continues to
>>>> increment after last_avail_idx had already been sent. This causes the
>>>> destination to often see something like this from virtio_error():
>>>>
>>>> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4
>>>
>>> This is pretty much understanable, as vmstate_save() / vmstate_load() are,
>>> IMHO, not designed to be used while VM is running.
>>>
>>> To me, it's still illegal (per previous patch) to use vmstate_save_state()
>>> while VM is running, in a save_setup() phase.
>>
>> Yea I understand where you're coming from. It just seemed too good to pass
>> up on as a way to send and receive the entire state of a device.
>>
>> I felt that if I were to implement something similar for iterative migration
>> only that I'd, more or less, be duplicating a lot of already existing code
>> or vmstate logic.
>>
>>>
>>> Some very high level questions from migration POV:
>>>
>>> - Have we figured out why the downtime can be shrinked just by sending the
>>>     vmstate twice?
>>>
>>>     If we suspect it's memory got preheated, have we tried other ways to
>>>     simply heat the memory up on dest side?  For example, some form of
>>>     mlock[all]()?  IMHO it's pretty important we figure out the root of why
>>>     such optimization came from.
>>>
>>>     I do remember we have downtime issue with number of max_vqueues that may
>>>     cause post_load() to be slow, I wonder there're other ways to improve it
>>>     instead of vmstate_save(), especially in setup phase.
>>>
>>
>> Yea I believe that the downtime shrinks on the second vmstate_load_state due
>> to preheated memory. But I'd like to stress that it's not my intention to
>> resend the entire vmstate again during the stop-and-copy phase if iterative
>> migration was used. A future iteration of this series will eventually
>> include a more efficient approach to update the destination with any deltas
>> since the vmstate was sent during the iterative portion (instead of just
>> resending the entire vmstate again).
>>
>> And yea there is an inefficiency regarding walking through VIRTIO_QUEUE_MAX
>> (1024) VQs (twice with PCI) that I mentioned here in another comment: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com/__;!!ACWV5N9M2RV99hQ!Oyhh-o4V5gzcWsbmSxAkonhYn3xcLBF50-h-a9-D5MiKgbiHvkaAqdu1VZP5SVmuCk5GQu-sjFhL0IUC$
>>
>> This might be better handled in a separate series though rather than as part
>> of this one.
> 
> One thing to mention is I recall some other developer was trying to
> optimize device load from memory side:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/all/20230317081904.24389-1-xuchuangxclwt@bytedance.com/__;!!ACWV5N9M2RV99hQ!Oyhh-o4V5gzcWsbmSxAkonhYn3xcLBF50-h-a9-D5MiKgbiHvkaAqdu1VZP5SVmuCk5GQu-sjBifRrAz$
> 
> So maybe there're more than one way of doing this, and I'm not sure which
> way is better, or both.
> 

Ack. I'll take a look at this.

>>
>>> - Normally devices need iterative phase because:
>>>
>>>     (a) the device may contain huge amount of data to transfer
>>>
>>>         E.g. RAM and VFIO are good examples and fall into this category.
>>>
>>>     (b) the device states are "iterable" from concept
>>>
>>>         RAM is definitely true.  VFIO somehow mimiced that even though it was
>>>         a streamed binary protocol..
>>>
>>>     What's the answer for virtio-net here?  How large is the device state?
>>>     Is this relevant to vDPA and real hardware (so virtio-net can look
>>>     similar to VFIO at some point)?
>>
>>
>> The main motivation behind implementing iterative migration for virtio-net
>> is really to improve the guest visible downtime seen when migrating a vDPA
>> device.
>>
>> That is, by implementing iterative migration for virtio-net, we can see the
>> state of the device early on and get a head start on work that's currently
>> being done during the stop-and-copy phase. If we do this work before the
>> stop-and-copy phase, we can further decrease the time spent in this window.
>>
>> This would include work such as sending down the CVQ commands for queue-pair
>> creation (even more beneficial for multiqueue), RSS, filters, etc.
>>
>> I'm hoping to show this more explicitly in the next version of this RFC
>> series that I'm working on now.
> 
> OK, thanks for the context. I can wait and read the new version.
> 
> In all cases, please be noted that since migration thread does not take
> BQL, it means either the setup or iterable phase may happen concurrently
> with any of the vCPU threads.  I think it means maybe it's not wise to try
> to iterate everything: please be ready to see e.g. 64bits MMIO register
> being partially updated when dumping it to the wire, for example.
> 

Gotcha. Some of the iterative hooks though like .save_setup, 
.load_state, etc. do hold the BQL though, right?

> Do you have a rough estimation of the size of the device states to migrate?
> 

Do you have a method at how I might be able to estimate this? I've been 
trying to get some kind of rough estimation but failing to do so.

> Thanks,
> 



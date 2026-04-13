Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA9CEBFD30
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCE3c-00033O-Ti; Mon, 13 Apr 2026 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCE3T-00032R-Pp
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:58:08 -0400
Received: from mail-southcentralusazon11013016.outbound.protection.outlook.com
 ([40.93.196.16] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCE3S-0002ut-Dc
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:58:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpiE2pKa/VKqGwzD/SrheuO7HGNV86qBFCxkjiO+7FJmaVygD5awl/BKvYRKg81pXjTmD0Q2JUiXdWtUQiD2SvBt1ZVPxjSVGbDe3nT1e4J0C4yAQf6iI/mW1fpRwfhxiFVUZgChOZDSGLeXrFiJe7mwPs1XevQZAI/HV8kU6rAC14omCwFKfXWYNbuw2A7tkq3SUC+Nov+xxqKd7ANACTwqnAQ5eMDjArRg7p3ZjKdH8Rx1s4up/cmMCDx9QppSAv6cjZaxv9IknDqRyLxSh4J43s1TWdTjOB8M43MCSAYMlTNKgSBIW4tj4qtAkJrCrzYe6ReoPLqClgKWBVzpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chJhiUdAn1gfqdYPHJcavYcd3xdJDzeu2JdHAFUPtSE=;
 b=E08PBAGblOaXzsuOxNoetRBOeX2m1fm0NUBWW+CjT8+rC5a9YOxOUATc6SiBuSSU0OsAepbnCeJNl52uru/IdIxjMkfKfihjMLe+tcItxWajIO6uHXf57vQpYuFmV871mqxtHmTAXwJiPd458bwHKubJHm2TTDDQEU1uqjz3Ej6RweX3DLXn93kzLjw5G0v/5/LGmWV/GeL63aRvIEuTu/3RBc9mKpAGsBK5PVfY4l117Bgo+Yv/I3ev56C3Dh4kIDAAx+ralJORLJQzJ/2m4f+Q1N7fXM7rwRsyBR77MrKfmYd1vayOnqXuI+55d+0HeZgNV9EgLxMSDsuH+7J4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chJhiUdAn1gfqdYPHJcavYcd3xdJDzeu2JdHAFUPtSE=;
 b=OuCdv9af5KwF+C0W941J3DIyp9nYsddBIymkXMYdWPtxHpxHUq8DBNZvcpQMWg+luimjqqdv49jHMd+6DVhnmTOB7uc/8z/YS8OHtNaO/n+/iOxEGj7GGriq88HTpob91DtxgTXmARyFOsz7LMaOY2kajxc1kd1q3DegMRhO90JCVWU8Uk/gueQYo7TIedPC9FAgX67dJFNW3MlB4IO46M52nwkdHAvc/iZwirmnXIrr/gconaN6CUoIO1N6Udja6sT8Laa/7ah/52OUdqL+CUvwN1ZPVtYf2yqin6pdgSVCFk57Zf3KgAMAfYSNgyn41IZ12j1bwCZQCi4PGo0MMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 09:53:00 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9818.014; Mon, 13 Apr 2026
 09:52:57 +0000
Message-ID: <a6c3aaf4-bbd4-4cb7-888c-ac498b032b87@nvidia.com>
Date: Mon, 13 Apr 2026 12:52:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] vfio/migration: Cache stop size in VFIOMigration
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-4-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260408165559.157108-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: de68f0a0-6676-4d5d-1cea-08de994270c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jV0FL8N663c6YnSv2QdObGtF0qp2/aDyv5Hi9guQ57LWcsUmzfODeC/u1Xz8zqpX1nOJ8MH2Uq7E9tZlUTXoPxp8xrFCZnxa04qbF1jX3c6/3RJpTJFWXvGTFihF9KmqP0/yOxN+JfUKAXLW9hqei6l8ohVgjYlvy9Qum3sNZeyD4C4eNMNkO8Jy4d1UCeWzM1lRU9gsbPTnYKYJ+dQTZQ1FkCQPlhSJVNEp53mvv12x+37lyJhN2ZzbE+0VXTf93yL16NdW64qxOgrExDT+xvSJG0hMPpBweoNtSQS876vAhZokcNqoiRLhS8KTLsTdq6WhRQqY2UGmPazwVhphrc4nYgtSEwXTNKi0JpIlpyFE/AdjnT3jAw9fxaUTsqHzuTN3cKOgGooRbePUUwHGw0ytt6THjVgkK+UIrdY+bRippl3oQl/VToB6FRxfJyDGnKuxkuPk2eIq4LmpdYmk4Ga6jKDEKA6zJ9mnzuE+ooWr2iRwmCaQ2tXbsQu1xQ2s1mucge+QR/bfTXgllm7BOqnTMBMeUYgKzEBJskDvNRE58LyPUFsgiEbww5ljhhNKpG1la/sifor2y7rIjnxkazUf7T/uOuZBLUR0rDryOtvID5uOM9rhb+kq64ydvumBa92YE2GeqdF/WAU6erdE+8ud9AeaL0bqCssGK9t7XhjTIXq8aZu5hzVGAjW+4+UAy3HXBQI+kNmm3FOwlIEzZisqV79rorakXeCXf746ZSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVd4Smh6ZHo4S1pJZWJvU3dNTDFMZWM5TTQzeWVOd3krSlA5QVBzbGM0dnNS?=
 =?utf-8?B?TkdReTA3SVBsejMwbWczNTVvMXRKL0dCUzNjZDl1Q3BPcXlBNVloeks1Y2NF?=
 =?utf-8?B?Mkg1bWpyYTVPb0JpaUYyVCtpYk5XL0NoZFE2QnEyWTJ2bldTQ2YwTFlyZnJI?=
 =?utf-8?B?ZG9pOThIRkFSZmh0dUprOElDVE1pR1ZnZVcwSGx5d3NZUzZxNkx6YU1hQTQz?=
 =?utf-8?B?QXd2SHZYYnVXMzNKeXVZbkNCZnMyRVhSZnQzYUpVU0RsODVJZWFpVjkzZ1Zi?=
 =?utf-8?B?dy9jVkhwK2hFMzRCbjlJdmt1cTYyeGszWmU2cUNqQzF1TDF1Uk4zZjVLY2lP?=
 =?utf-8?B?WlBaeHhuSndzbm12TVdPY3d0KzhLOGV6Z05keXg3ay9mYmNQc1ZaeldxVUZN?=
 =?utf-8?B?NUx3bHVUNWJKRld2TXFuOE5LWU1YSmJSYU80RkkvWDhDN2prQkhUMFlmcmNs?=
 =?utf-8?B?b1c1MGVPT3FSdTVpeXRzOW1JQXpvcHVJbjhPdldzNk1jWDV6QUFnTU1DYmpw?=
 =?utf-8?B?aVJaVDV3ZXdJcmp3WWxlbWNqNUZTbUV6RmZidkNSUGQwNXZLeCs5aWpvUXVZ?=
 =?utf-8?B?UkVnQXpNV3hXZ08xc0E5Rjl6K3ZieTlCa09NbUVteWN5bTZqSzB1ZUh4eitJ?=
 =?utf-8?B?WHE1bmhsRkhraHRGQy93Mi83SDF1bkRVaVZsSjdRRkNDMnhzNzhZY3Z5Y3pi?=
 =?utf-8?B?aGVtd2NCS21RYlBqMHVFQTRsanF3TlRuYW94TnRUM3FVcUtTYWl6dTd1bWhq?=
 =?utf-8?B?ZDJINW1GN2lYWFA2OWpyK1JORjNyZXp1Vk92cUQ5a0Q2WUdEU1FTcWVDSTZu?=
 =?utf-8?B?WjNibkdVRCtRWkEwR05qdzBKck51Z2h1T1V0WFBCSFZHaytrbjF6MFBZUTY0?=
 =?utf-8?B?ak9ZQWdBZTByVXN6dzlnY1JuODNZNHpwZjEydnlUWVZScGJPd2dUdlphOFZP?=
 =?utf-8?B?NHFveHhYTTgrcTVNTE1NckNEbmxTRU5oL2VYSUVnTUZZMklRMGdSTlBSUVVn?=
 =?utf-8?B?VHBvNnJENkVDdEFSdUx4TGU3bENuOHF1UHY0aG4xZHpZbnZVR0xRNHY0azRH?=
 =?utf-8?B?MWxsUzlZdVE0QWszQS9XZmV4UitXWTlPMnh0bjFXY1hCUmdTRjZhZVovQmY1?=
 =?utf-8?B?bTRRaWlWTWp1dHAxbVhhN28vNUwvY0dVanVOOFU2aWozM2xPNm9oYVRybUt5?=
 =?utf-8?B?T2wvUnNLK3BFSm9EYlI5YlQvMEYyR1AyQXVscytWdHA1QWkrbU9icTNLT0Ey?=
 =?utf-8?B?N2hCWWVUbDczanlaR0hYeVdJcWhKR3pScU8rb2pWRGdaVE95YmJuTlhxK1hR?=
 =?utf-8?B?ZVdyelhaTDhPOThGMmlPWUhHNkphbEkzUHpQbmkzRnFibjNGMytpTVR2eEdn?=
 =?utf-8?B?eVN3MXN0M0FpWVhZaUE4OGhRVVVRMnFNWi8yd3lIbVpuRUkyS3hGUUl0R3dJ?=
 =?utf-8?B?N1EyUmsySUFMTVIrcEdqcTE5c1h0c0tHQ05MSW1ENlpSRXZ0RWFhelR1U3U5?=
 =?utf-8?B?cFdiZk1hbFc2b3VBeERnYlkrY3N0YWJZa215NG04dVl0QzRVaE5kNjQ3dUJa?=
 =?utf-8?B?RXV1K3ZYOW4vbDljazZnRDFpRkNTZkhVeW5seThkMzNwNUxSZVBMM3kralQw?=
 =?utf-8?B?VFdnUnNBYlgzMXlRYmtGeUhNdzc5cVVJbUNHL0x0S0Nma2VxZTJKUncvRzRa?=
 =?utf-8?B?NmJxaWIxNDNweklydGViYjBKN0lEM2FUdEljUWFVK1FIWFlzUld4bVRRN0c3?=
 =?utf-8?B?M0JCazdTcGprTmtZenNlYVgzTEYvYjNTTnRhNkhoYnFNY1Ywa3ROeTNscUsw?=
 =?utf-8?B?ZXptZGtrSUJVOG10eC9KUmI2cURuWTgwOGkzeGRjdHI1ZGxISjRlSDJTNVRI?=
 =?utf-8?B?bGp3OWtnaXNnSmhRKzdEU3kxWkhZUlFCQXF0R1BxeWFKQWtUMGJiOU5HYTl2?=
 =?utf-8?B?VitPMGtLUGxId2ZSbWJzS3JsZmpjV3FmWCs1U29YZkxQWHIrVGI4Y09PcDhZ?=
 =?utf-8?B?Y1lTQXR5VnZsVk11UXk4OWhaSy94Zmw3TGdhNWpWYjl4TzMrMlpiYjcxb0Z2?=
 =?utf-8?B?TUFUbHFuTFRMakZlSjkvaGIyVWFCNW9pc0FPUEZwL0Z2VE9Rd1Fld1JiT0VD?=
 =?utf-8?B?S0lsYitvQVRVMlBpWlQrMThHaFJjSFJuY09IdnNKc1dCdnR5MUM4L1BYTXps?=
 =?utf-8?B?WnRBbC9aRXRvcGxvT0RRcGtWbkZ0dG9mdzYvVTJZQXlPY3NRY0xoQy9tdmV0?=
 =?utf-8?B?RTIvZTBBV2tSMzNFckJzUmlqMWhUeWM4T214Q1RvdE1QWUhaalhXM2paWTBv?=
 =?utf-8?B?b1ZYdGY4aXAwY2Y5RnZpRWQ0YVFQZFUvL3ZjdXNsNHVjZ2RIL0dCdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de68f0a0-6676-4d5d-1cea-08de994270c9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:52:57.3853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2yjiRx56JDkjaMCj8PQ6Fg3wI/tP/lzFx1KDk74PbeVA2e02lcPgoxkemLPwQvn5dmx0QjX6QpVDrmaUREccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
Received-SPF: permerror client-ip=40.93.196.16;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 4/8/2026 7:55 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Add a field to cache stop size.  Note that there's an initial value change
> in vfio_save_setup for the stop size default, but it shouldn't matter if it
> is followed with a math of MIN() against VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE.
>
> Document that all the three sizes we read from VFIO's uAPI on dirty or stop
> sizes are estimates, so QEMU needs to always remember they can be anything.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/vfio-migration-internal.h |  8 +++++
>   hw/vfio/migration.c               | 50 ++++++++++++++++++-------------
>   2 files changed, 38 insertions(+), 20 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>



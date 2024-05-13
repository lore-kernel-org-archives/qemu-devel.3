Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17362C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WpQ-0001My-Qo; Mon, 13 May 2024 10:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6WpN-0001M6-LT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:38:57 -0400
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6WpL-0003WM-Ri
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6q6P/VwLioQY+dLV+Ib20viezjpuGL1OH8WGfrRo8Z0B9RVZRQdXcU9dhYRjoqEFJj5lEkYtAoZByjV/Kz69Vs3uhfLs7vTgZIzMXkmbjJXtUIiV5Yu+lLs69zGXlLxOWk9xA3q3LjGxHGvYiFtJmBW4ABwNKzIeayQtRSn06D7W7dcq/7WPc/hapnYAZqtJZAXcHc5z14Jekj3OY/cB3862pIk94EGsb7x/PA12YO8M/Mx46ofE9NTPZLUm/DGx7ObbVyHs/O0xvj2hjnLzsdtWFGGMzmSvf3TBb/Vz6AFQjTAFfkDfTnqmnv2g5rXGXh9GiClSxLCNG2zrBMdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdJ8xMHJ9B3vY7jcGWgeWU3ZBZgkQRnDxTcSnJ/0zrM=;
 b=i4PN8hcnwPIiLW7/pqRL6jgNmM7XV+/BTNAW2sETFObiEYANmRhRr5z3ZRGWKhwvz64FE515o9jo0kkWloPAz5iC9+6pFG0z8/nmX9GZjB2fwFwryQ/FGUWYc2MQftXaMPYuGaxQpXYKLptPsR32rTtPgPoL4XdECpiHzCjehqUPY0xpWsoEFIO8S8gtKOSJdUaIG4QK2OGXQOVcmRFfn8jMEtQK9pGqNPPSUNqbtN98mGl8Vvto4qA+95t4Hikt7TcInxBhzdUAoXq7xTKhOjRkiGKzizxj+Q2zjjIGqIkU6/Qmmr7XLBSGO8JDxo5s0+aV4jbCbnzQTKf6vZDbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdJ8xMHJ9B3vY7jcGWgeWU3ZBZgkQRnDxTcSnJ/0zrM=;
 b=Z2u0n3d4Qoaqqd7ItwYqk0bF3vmNNrxoc81pYbB5l4ZNC9T7TwKobmv/9rTxQiY0jo2kV8uUeC9PWULtIOrf1tGBhTg2yKuoZD/B0CYOo/5tyq8UIjj2xgbuX/g4uPmZIIQ8VmybRx9/Jf4RJbj8EKu9Cd0AYbf8gtxTildcQ831NlQNIf5xkrNVNKBXSjHkH4nRk82DrKzpQZKM+eZyP9iTA1PNartJiyWXb2YgJFAy48Ecxy/kLbvZj80goaqDE7e0suQi8x3WhhNWemgGUGgp7Q43sPJH36zrPetBTpxs5TalTBRjGWK88XTu41x3719hm6I+1SZJw2tg70C1xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:38:50 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:38:50 +0000
Message-ID: <1eddc908-8b65-4ef7-8488-e134ed372d95@nvidia.com>
Date: Mon, 13 May 2024 17:38:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vfio/migration: Don't emit STOP_COPY VFIO
 migration QAPI event twice
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-4-avihaih@nvidia.com>
 <8bc6d519-5132-4061-92f1-64012fc06e04@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <8bc6d519-5132-4061-92f1-64012fc06e04@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: c07d15b4-ae25-41d5-fe7a-08dc735a6779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1dyL1VqV2NveTJTaXl0UXZuaEd5Q3p0aTVWT1ZITlNKdXJoUXBkUzl3c1lK?=
 =?utf-8?B?eXF5Y21NTDV4VllGTTQyTDZwcGtIKzFXYTJFb2xoUDd2QndNdTNGSHBVbFQx?=
 =?utf-8?B?SVBFdlFwUGd1eUVFQ0lGWGZ1UEhYV24xZWZYRCtNbnNHd1d0USt0RlJDYm1p?=
 =?utf-8?B?UHY0a2hrUjk2ZGxmNVB6dzhRei9zNXRPc2VWenhsOXhibzhibEZ4Yjg1cDVu?=
 =?utf-8?B?T25uRmtTWHV6OTg1dlZJOElJMHlUSTRiZHgvQzNreEh0OXhsNjRVVzlpVFJH?=
 =?utf-8?B?SW9LU0EwaFlyUlV1M2ZHT2g1ZnhKKzlybjVidmVrSWxQRWhRVnR0NGxwUzND?=
 =?utf-8?B?Y0pQNVpXRXFrNmcwWS9mQVc4QTJJb3pMeEs2QzFIMVZLZVRqakhCcE9rN2cv?=
 =?utf-8?B?MzlocXJReDg0RThmcm1WMXdhRDhkWFEydDFZVTNVZlVXYmozeFUrdTNxRWZK?=
 =?utf-8?B?UUxhTXdhL25OaGdpSCtwVEErZDRsVEkzaGRaNG9MZmhLcUIvZkU0N2poMDRs?=
 =?utf-8?B?RmliRFFjY2dWclYwTGZJK1phQWhQMW9oSVZoaUVzSjNpOXBoK3RnRFRzcHZJ?=
 =?utf-8?B?UkJCUGcyUUdqNUVSUm8ydTRnQ3dVaFJSbDJMRHhnMi9YTUxiKzVnODNPSVpQ?=
 =?utf-8?B?dmhnT0c0Y0NzaVp4RGZPOC9KWUFxLzlzV1dVNVIram43a3V5S0hZODJVNlJa?=
 =?utf-8?B?T0Vmdll3YThFQ3hqMDFzY3FTMHZXVlh2eURrY1hKM1dNbDh1SStrOCtVaGJk?=
 =?utf-8?B?d2hpa2o1ZDk1aHpWNS90RjRyOTVPbVBRTkczWTAyWFhEaGl3dVh1cTRmUWkz?=
 =?utf-8?B?MVFVWitjaEdNcUpNTnNqZUhteE1QSll2dmE2OU4wekR6T2xRS3RRRG90c1Nn?=
 =?utf-8?B?NU9QL2pVVnFGWEdsM3dXaDczSlNlNGFMUXZCa3dZSks1SFgzbGZyOGRYeWtM?=
 =?utf-8?B?bzJNK1U5dHRHTXJ5bVpQeEgvb09SUnNVRnBPWDliQlM1RHZTOS9UcUNwYUgy?=
 =?utf-8?B?Ry9oMjV5RHJXTHV4VGMvcUtqQnBQYXN6Mm9QSFNJeVNPWlVDOGIzUFVXUjJM?=
 =?utf-8?B?MGNzcUdFakxZUVpNSkJwdks4dE1uYUVlbDdCYk5FQ1VtWVZDOFRpdlNwK3kz?=
 =?utf-8?B?RVAySE00UzkrMHMrWkpkQVliR1MwR0lmSTNXYnlVMmI4V0pHbVZoa0IwYVl3?=
 =?utf-8?B?eEkzbzRQQlZnd2lqenNsNmdtY0hpT1VubzZrL1VLREJ5MjlPMWh0eXQzYjB6?=
 =?utf-8?B?cEF2L21iYklELzJzczJxWkFWK3ByVjY1ZFg0OHIxb3lVZGE3Z3R0RGlsTE1i?=
 =?utf-8?B?cHRpeGtHNkZPRFRLcW42SXpobEhjZDl5bUpxL09QVGZGdDF5Ykx2bVg5VzVI?=
 =?utf-8?B?NjBXdE01ZGF4MVJmbGVHbzc2SnhxTXhZU2FXNlRwbTVRUFJFRTFSZ3RNcklj?=
 =?utf-8?B?TVprUU9HUXFKVUU0NmZSTlpPamp3Z0IzeEVURXp3MnFpMC9kTjdRTHQ0cER4?=
 =?utf-8?B?RGFmRFpNQlcwdVp5RkcyQXNzY045NmpFc3ZvcnRsR0pMT25FREdPcDN3WUht?=
 =?utf-8?B?Q3Y1c2ZYOTVOaEd1NTh2eWM4M0l3clJOdFhPQ2dDYmhQV2xXaWNCd2xLZlBH?=
 =?utf-8?B?TjZFdmVtU3phQzcrY0hiS2JIcFg0WjZlbXpoSnpyMnIzUE1CazhlTjNveHZ3?=
 =?utf-8?B?UmdaTG5BSTlUb0pFbFFZSXhjaThVSnFRU1lEemNPWktpM3lJNXZQK3pRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNPOGVXVStBaVdlVEdkZ08vUGwvVTV5dmZoVyt6SlduRkxoeGt4cy9hSWN4?=
 =?utf-8?B?QkhxWWVJQy9HVGw1S2tvL2g4Z0F3WEs3QXFVTXZUaVlEbEdhQWJFN0JHQVB2?=
 =?utf-8?B?M1cyciswVjNuemRLOHNra29xYmNIU2lFVzgxOUdSSDJLZGZ6aExXSTB6KytJ?=
 =?utf-8?B?R1B3RlM3bnB6VUVuUWpMMWVUUlVRWEZFWFBHdUgvNHFZU2hFc3ZMMWsraW0y?=
 =?utf-8?B?L1EwQ1pIMklsSVgwSGUvblJSNXpENHQ5M0R3a1NtaGRvcE5LaGwxbDRuQVRM?=
 =?utf-8?B?cUhDWkVBZXF5UllHUW9wQWRlU1ZIYzhhTGkwQjkzTVZkMkhRVTEzbElIZ1Jy?=
 =?utf-8?B?VDhiSGVPTkVMcEhER05TdHRVcm5jS2tjaXB1VnpwNTVWZTFLRTdDNTlvaGU1?=
 =?utf-8?B?ZkJwRGd1eEZGSTFGRy9EQU4rNFFLL2RBQ0k2M0RnYzhlZ1RrZlhGOUV1a2lm?=
 =?utf-8?B?bEx1Z2JEc2lqWFI5SE5XQ1ZnMVA0eUg1czcvNWtsbkl1L0tLdVF3bzVESktE?=
 =?utf-8?B?KzJ3b1VLSE9JOVdtYU9ZWXVORVNTRjVoTUkrem10L0JubE5uLzhxVjEzaVdT?=
 =?utf-8?B?UmFuT3pPUmorOUIwbTEyc2tHSnJoSlNaT0dLNWZLSFE2bFcxaWc2bWw0ZVor?=
 =?utf-8?B?V1UwYVVzb1hGbHFmdEZHMjVTMnNxcHgxVjVwemF1YUxXY2JkaVptd0JRaDZC?=
 =?utf-8?B?OVp2NnJXSjNMVkZVK0FwZm43TVZkYTJ3THJGWkNiSjJma1RvOCtzdTkxbWh1?=
 =?utf-8?B?aWhnYk5JMTBtUHBhTmVJU29CdmFYbkpQVFJvMnJ1N2g0RzYxQ3hMNjFXc3FV?=
 =?utf-8?B?QWp0WTJVQ2djRGlkdWRia2VRb2dhaTRKMkJWa3B4NUVsQVhES3lEVU5oK1l2?=
 =?utf-8?B?Yk1xTXJ6Z1luVUlNZGZwaWFBL0xyRkViL1Zqck85akw1Rm0reG84d295VnAr?=
 =?utf-8?B?QWZDL3ZxTEVuNGRJUFMwWkxtYTZjNXBxOXVlQXhNTk5mWE9lNllLZDBhdXQw?=
 =?utf-8?B?bFlIMWgrT292WFlGd3Yrdkx1T2h6NkZUaHBtZVFkSm01YWtOWk1ZOXNrbHhM?=
 =?utf-8?B?ckpKVzVYK2MzcWRsWkhVOGVBSWZPTXd1UERveWszd25aUzIyVnl4eHllSjhU?=
 =?utf-8?B?NnJqUE1kUGFIMDhReThBZUdTaGVuVU5kTkQzSElDVjl0WTFSV25aYklBUENI?=
 =?utf-8?B?THhQbXJjWTk2M3BYdlBsY3lxOTNIUCtKaVk0NWZGcHE0V1lSdFYwNlNuQ0Z6?=
 =?utf-8?B?TTFNQkZVMlE2eTA5UVdzNHRzcXFha05hWEdDSy9hN1VSakxka2R2QUpBUjNP?=
 =?utf-8?B?em9JeERhRXYyYkFBTWN6VXpDNmcrc2k5dFdla0F1MnlabnpqNTgrNFBDeVpL?=
 =?utf-8?B?dDdOSlR0ZENnTUhOQXVxdkF6UmRFbUs3VjVUWktXUk0xeXkrNEZUNEUwbU04?=
 =?utf-8?B?Rjg2MmpXdlJFQ2FRbWFxblpjYTI2bWpHazN5ZjUwb2RVajdhbWgya3c3SU41?=
 =?utf-8?B?WDdNWjR3TkpOL1luZ2VONU5EYmdKSnBwRUJTYTRrMUdWcVUyaTVCekMzRHBT?=
 =?utf-8?B?dGRHQlg0WFNQUGs3d1ZnRnVpbnYwU0dpM2IvaVpONWZCZlh1UGc2RXl2Q1Rz?=
 =?utf-8?B?RDAvY1AzOHdXbXBnNnd4UWNjdTlVdklQVWJLbjNybDZydjY4dFJpdFhIWENx?=
 =?utf-8?B?SUYrYUVIa3dEU1VWeEhRcDc1VHMrTTV3cS8yYnhZa2ZBbzAyd1lXalRnSXMw?=
 =?utf-8?B?M1Zycng0cEE5bFVMN2ZCNFBNVCtSWjhzYkNoOERCdUd4Y2F3VFlIVGlqM01l?=
 =?utf-8?B?TGJFVnVpWlJDN01wUjNSUEZWTCtuSTYzbzBleDNOT1JPajUwTlpSK1UzS3lE?=
 =?utf-8?B?ZVpHQW1qNHE1VURwZkNBR0x4eUpaUEpCcUx3ZVR4Z2FhditBSm9oeUVKN1Zv?=
 =?utf-8?B?VFAzbkpqYVNGSUlNOTZEOXlNcTNuZGg0Q1NSUEI4WVcrOHNNaFpmOTJGNUxz?=
 =?utf-8?B?VDBZcS9mTkRVSmdobkdUY1hoMUJaZ1h2NGRSNEtTSFIzYXlOQ1c4dzFmQVlU?=
 =?utf-8?B?dldxamV3WU5yVnZtYVdaTXE4Q1Npc0R6blJmdHpjaUNVY2pVQS9PeEJGdDBi?=
 =?utf-8?Q?Boa9FvCbAAmcLwQ3ekimAIhTH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07d15b4-ae25-41d5-fe7a-08dc735a6779
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 14:38:50.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnpAcmF8LbdtHkgyaAE2toEY5eJrhdLdoFpZE0ywfo/JlDYA1OLYiBQERMKbrwls1SAYFxxWWreAkBgaaKzM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 13/05/2024 17:13, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/9/24 11:09, Avihai Horon wrote:
>> When migrating a VFIO device that supports pre-copy, it is transitioned
>> to STOP_COPY twice: once in vfio_vmstate_change() and second time in
>> vfio_save_complete_precopy().
>>
>> The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
>> transition. However, with the newly added VFIO migration QAPI event, the
>> STOP_COPY event is undesirably emitted twice.
>>
>> Prevent this by returning early in vfio_migration_set_state() if
>> new_state is the same as current device state.
>>
>> Note that the STOP_COPY transition in vfio_save_complete_precopy() is
>> essential for VFIO devices that don't support pre-copy, for migrating an
>> already stopped guest and for snapshots.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 5a359c4c78..14ef9c924e 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -143,6 +143,10 @@ static int vfio_migration_set_state(VFIODevice 
>> *vbasedev,
>>           (struct vfio_device_feature_mig_state *)feature->data;
>>       int ret;
>>
>
> I wonder if we should improve the trace events a little to track better
> the state transitions. May be move trace_vfio_migration_set_state()
> at the beginning of vfio_migration_set_state() and introduce a new
> event for the currently named routine set_state() ?
>
> This can come with followups.
>
Yes, this sounds good.

Thanks.

>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
>> +    if (new_state == migration->device_state) {
>> +        return 0;
>> +    }
>> +
>>       feature->argsz = sizeof(buf);
>>       feature->flags =
>>           VFIO_DEVICE_FEATURE_SET | 
>> VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
>


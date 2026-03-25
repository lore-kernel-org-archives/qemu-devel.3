Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DE6109C029
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Q2f-0000Mj-Ql; Wed, 25 Mar 2026 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5Q2d-0000MA-AT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:21:07 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5Q2a-0003Fz-Fe
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:21:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkaeRARb6p1uLZsDqo7UW0jT8hpfseAw9aRYkI0bantOaESGY/YtREUyB91fFy/mj/gocds0QEfC8HBSHAQ+16X6KdIRGo/OMCBopEeHm5MndfkYoJ95PIi4NgQ0sZGqr0DS2veL+VcRNjtQmiEJMYyySg/3FejB4RQpLN52Awh+GS82eeJnDHvN6g6XTLcraokSuIqV6VvLvx0jU5jOnD70zpHvtqqSY7U5GY8JtqiXuAnmaKmDFQZikeVwVTP7mw5pMP1qUxXMiCK5K3FQqYBuIMRPHMYAm0anE0pv6zMHqK/cHXNUhcWoDiYnfYb73uxGZMWc7RQ7TbQDkNYSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzt8k4W7W4sKXD5x3aZ0tu8ktpWDeO5u8/UUJZWyrmg=;
 b=zHCx1c124dtDz3bfDJN4aJ2y5T7pPB2tt7CKsnUKTx3aXu7jGa/VVUx4Q371oOhU+z+O56QTH6fkManh60/UxZVSCTT5yI2602zYmkjf5kRd20ekLUFdTClerv9SbzH/wJWW6/jToIChs0wGeU+kf6x43z1W9pqxok0fBICX/EwieITq2wtZKQF2y1oh00t1ZtIM2dG138BvQkrQsHRtfgD2Bot+y/8uJHIU01d4aOJ6fpBC53ddUdSv7BbXKdvrP8c7JYaKZwf2xC4a568eeMYg4jiDl/sqLeX0ezKdyHZQpytAOGNG13ukciXliDHtzPfT63H/TQJQGsTZ/XVwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzt8k4W7W4sKXD5x3aZ0tu8ktpWDeO5u8/UUJZWyrmg=;
 b=WVud9RqhCH/XIi24iNW08KnwpANWB73dvpp6uwJopsdRzGUyjUVAFeHjNrNyeK48MnqcO056FfHnUsqoFZL3wYarUVUaMHd/nrX3g3WcmVgL5JhXVQpiVuyd8gR/9ak4gcsXFBaCvYKhC3/TRJtqD0IFkE/Kj5xF8t38ifc5cCGTlMHk6OUYb665aDQPzQY0zmCok0Cq9eAcG2fNQvf5m3umaMczFzpIkpkI7Mvn9abqLuMU2ShtlDhAyUEeO6QbOmnOkcJukwPGjgTAYQus2WgaXBZiBYGRnEohMtDHCtgjZhKgS9QZYKlMndlLU1FK2KSpv9+0ZinG0guyr2iihg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 15:20:49 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 15:20:49 +0000
Message-ID: <b957ae39-12e0-40d2-b0b3-8f09bff10bf0@nvidia.com>
Date: Wed, 25 Mar 2026 17:20:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/12] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-6-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260319231302.123135-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: a8805d50-cd58-4341-f34a-08de8a82184b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: USQxAH2la4JGlCGeuw7gfi6KmRxE/YYDPQ7VclvTrZHCmlIL8ZDqUipiTQJwfz6n9RnUSWN+mxNE/aoa4yxX59KjBN0p24JNithIFF2kwaEMHOmqYsjjG6JMq0kVTJro5LsNRkfEHx6f4sAQoTRZz+5uzOBLvQNYsTOi4Ub0CgP9X0PIX4QpyhVmDl39qbUMftKM+DoYRtTzAHYGHO18pXQWzS0U36lY9dhBF1+NI4Twfmnp3iHXE8Lxb2QfGysetWdz2zeS/wE2nvoLbaK21k1bOX8BxRnhN9suUg8786Zuh8+AuKo2cDMThT2ZeeGKnjWaG4BZOnBr+Io1W7m+KMeI+53r+Ti+TztuaMZiho+XbaydpBfoZvM839W8uTUbecLGEprOodQh7EjvNZlRQK+8kZdoWhEQ3+5ynGVpdv/4dIc7iSiBTZfqAbih4LmVpc7oxzbmCDLQt4EwwCQfy5ZoMXFrtpSXvYpSLo0JV7o8GrJqFaTJOhf0C3xApRWCAZXwN4weMyc9g+jAocOPvhQou2UlBxswdjjmlGJ9MUGzG63/F5f+NUPntyqS8cDhGSLSAtnHLyE34aOjUcCxcZMTK/LFDMBx2lOsdPrqxZ1D5bfkJY+sXyU89dRSvIvC0N9Cjgm03t8v3vhWPZONCKcctB058Dxd8iZvJIylw/9ujoPccs2k8w5h95LVEBiHOtOe9UjY8RBVfbWbEQhqKneDORW5e0WqpEsveqzK5OI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1AxSXBFaVRhV3NJVU81TzhndUhqQUpZb2duZ2VvbHFEK3dUblJLNjlDaWJ0?=
 =?utf-8?B?aXFTcGljMGhjR3l0Nytlci8zS1hBcWJMOWNlYm5WdWNGSFV0UjN2dEgwdUpz?=
 =?utf-8?B?MGFvVjdmSy9pOGdXcCt6NWtQaG81OEYycUJOUkIzWW1iZjAxRElUME5HMytv?=
 =?utf-8?B?S2wwbFFSUXU3QzB3ZnZHQU1ycUZGMUVlZEk4QjRqNitnY0VZVUtabWJxM1Ju?=
 =?utf-8?B?aW5tUFhQdnNpRmk0Q2hwN3NiNFhvblppbGswT2JWYWtoUFFrR0JnVFduR0pW?=
 =?utf-8?B?Qm91OFhMVVdQcWt5UHp4TE1JWUZ3TGdsMXByWWdIempqRXo3UU9GRTRQRllM?=
 =?utf-8?B?dG9sbS9DK3ZIcE5BYlVZK2FKbjcvcXE5NzNiKzg5cm9hTTVSMUV3aDlydHZT?=
 =?utf-8?B?Wm1XRWtjZk1PSmVXZUpRTHJlYjcxckdUK3d5cFJhOGVzQ0RjZ0NUenh2VmV3?=
 =?utf-8?B?dW9qK0NzdE0yMEs0cks5c3VHL3pLa2tpdWlWcldNeEJidEZNMURMSjJ6WXNy?=
 =?utf-8?B?M2NRUkQzR1N5bml1WUhtbGp1TnNWaFhvQldFRlRadXZ5YVlOZTE1S1pTMVVq?=
 =?utf-8?B?d09EKzk4aG1xL1dJNldJZmxuMkwrbDVFN2hUY2grRUl0SHBFSzZXb0d1Q29p?=
 =?utf-8?B?YUJiNzhTKzhhMWRMTTFNLzJjWXZUYVNNODgwd0RqeWY5YkRUdFRZRU1jZEQ4?=
 =?utf-8?B?VHVhc0xLUEhDK2RIeCtob1FZNldpNlp4ekM1UWhwMGxJV1B4V29WOG5PckI2?=
 =?utf-8?B?OEZnYkRZQVNhcFlVNjc3emNzY0I0bzBGd2Q5by9xYXU4TFdPdzBTRmJkU3ZY?=
 =?utf-8?B?eUZwOWR5Wk5tZ3lHKzZSNXR6Q3RhY2N0aWpKZnlzeStsS01nQzFjeS9ZMUpX?=
 =?utf-8?B?ZXE4YkFFZjRlWmxjcXJWVEFyZXp3aFVXRUxpZXltL2pRa1YwRTdQek01MW9t?=
 =?utf-8?B?YWY3bEtUa1MzUGorUW04Um1abnBPN2J1cVhpZU9pOCsyN3V1ZGN1TUVSVkZM?=
 =?utf-8?B?ZHh2U1F0WFRTamptU2MyUU1oWlp4aVQxTlhTMTI1bzdHOWRMZ3hJK3VQbm1v?=
 =?utf-8?B?RER0Nm1IRGhuVjRqeDdnYWo4WFBoQmpYb1ZCdG1GdFkxVGcwbFQrUXQyNitE?=
 =?utf-8?B?Mi95R3JzQXMwUlRKZmNHVU12WGdSTVROVDJLaE1GbDlPckFWM0FOUW8zY1JJ?=
 =?utf-8?B?UDlUTENHOFpOdGx2elV0NjZhYnRWNUYvRVY1NVhrenF1UXMvb0g1cC94MDJH?=
 =?utf-8?B?bTd5RFN2aTFHbmpBTEJoMnZFclFteURKUUdyNnlrNXRLdThLdVpSUmNWSlp2?=
 =?utf-8?B?QWltaXNZaHRYNDl5Q3d5SVYvb0NDeWRrOTUveEZpa1ZDM3J1NWJvYUNBcjlK?=
 =?utf-8?B?V0xKRDlaV2NrbWw1YmV2TGNzNi9NSU83T29yU2JyVVZKSVRMOGRBNWF3cHRS?=
 =?utf-8?B?YWlZOWdCaGVjVUhwQ2RFVTJMbjhTZUVRSU53R29lb0VrQmU5UFB6Z0F2TFlu?=
 =?utf-8?B?M3hNQWZ2YnRCMm9xV0thWVkwQlhqcDBCVVY2bVhvOFppOHh3MkFmYmRWVE1w?=
 =?utf-8?B?dDRhYmNkczZTR2dGcGFUWnEzSHVSdVBjeXRCS05Ra0FSbTZuK05mTEtaQjcx?=
 =?utf-8?B?SnA0Mm04bGFnZEpvaHFHd1pJU2FQN01hOGlZQzNNeFM1aTU4WkZaenROb3U1?=
 =?utf-8?B?bFRwdlE1R1h4VnE1WCtTZ2NYUUFsaU5kM0NlM08yOVp5QjRINTVycG1WWk5a?=
 =?utf-8?B?emswdkM0Z3JUdXB4RDQ1WDVScTB0QVBOa2VUYktsb3ozQzNCS2RFM0xvMlFn?=
 =?utf-8?B?YmQvU25EMm1GOTVQVzAzSVVCQWxLQ282UUtXazdDbUQzNHNrSU9XbDJvaEFY?=
 =?utf-8?B?ZUpnNzdYdS9aQ3BSUEgzYWlrcjNJRThWeFYzQkFsSU15MDZSVVFOSysrMnll?=
 =?utf-8?B?TGF0b3dUbGlhVE1EQ2kzSk9TcllSUG43d3pGWkw3THJvRUdILzU3MDlGQlF1?=
 =?utf-8?B?cGVmWFBnZ04yT3JscVpoUkVIajBjRjRmOHQ4blhZUkp6emZDakxMY3A4Rm44?=
 =?utf-8?B?Qy9TMVY1MDVpcG5QK3RVaTBWNHVIL2gvdlhDdmh4d1RkTVFQNjh0NWExWm1Q?=
 =?utf-8?B?Y25zTmlmakwxTHJtZjU1d1RkZVlwT3NUQTU4MkZ1WDBtYUF6RXRHT091dnFW?=
 =?utf-8?B?dFJ6UUdpLytLOFZpVWJYTys2d3ZNS2hISFpoS2prMWVkd05uaVBhVEN2dDBF?=
 =?utf-8?B?ZVVyVFphWmdNQmtOMUxLenJRbDAzb1IrTmk2VjNNdXVnc2pSVktMMUtnME5n?=
 =?utf-8?B?Q0hhMWFldmZla0JBNFJGTFE1TDJNRzU1OCtRTlNXUGxGV2ROQUJzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8805d50-cd58-4341-f34a-08de8a82184b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:20:49.2894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I31BhmbkxVKFgWdEfedcMyqRFZI82aiHaBNtsTZMuyJLhVDv5EdKa7Q13iVwCHtftr7mbb4MfKu7Adb2Ga0uIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=avihaih@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
> These two APIs are a slight duplication.  For example, there're a few users
> that directly pass in the same function.
>
> It might also be slightly error prone to provide two hooks, so that it's
> easier to happen that one module report different things via the two
> hooks. In reality they should always report the same thing, only about
> whether we should use a fast-path when the slow path might be too slow, and
> even if we need to pay with some less accuracy.
>
> Let's just merge it into one API, but instead provide a bool showing if the
> query is a fast query or not.
>
> No functional change intended.
>
> Export qemu_savevm_query_pending().  We should likely directly use the new
> API here provided when there're new users to do the query.  This will
> happen very soon.
>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   docs/devel/migration/main.rst  |  5 ++-
>   docs/devel/migration/vfio.rst  |  9 ++----
>   include/migration/register.h   | 52 ++++++++++--------------------
>   migration/savevm.h             |  3 ++
>   hw/s390x/s390-stattrib.c       |  8 ++---
>   hw/vfio/migration.c            | 58 +++++++++++++++++++---------------
>   migration/block-dirty-bitmap.c |  9 ++----
>   migration/ram.c                | 32 ++++++-------------
>   migration/savevm.c             | 43 ++++++++++++-------------
>   hw/vfio/trace-events           |  3 +-
>   10 files changed, 93 insertions(+), 129 deletions(-)
>
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 234d280249..22c5910d5c 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -519,9 +519,8 @@ An iterative device must provide:
>       data we must save.  The core migration code will use this to
>       determine when to pause the CPUs and complete the migration.

We should also remove the state_pending_exact section above.

>
> -  - A ``state_pending_estimate`` function that indicates how much more
> -    data we must save.  When the estimated amount is smaller than the
> -    threshold, we call ``state_pending_exact``.
> +  - A ``save_query_pending`` function that indicates how much more
> +    data we must save.
>
>     - A ``save_live_iterate`` function should send a chunk of data until
>       the point that stream bandwidth limits tell it to stop.  Each call
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 0790e5031d..33768c877c 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
>   * A ``load_setup`` function that sets the VFIO device on the destination in
>     _RESUMING state.
>
> -* A ``state_pending_estimate`` function that reports an estimate of the
> -  remaining pre-copy data that the vendor driver has yet to save for the VFIO
> -  device.
> -
> -* A ``state_pending_exact`` function that reads pending_bytes from the vendor
> -  driver, which indicates the amount of data that the vendor driver has yet to
> -  save for the VFIO device.
> +* A ``save_query_pending`` function that reports the remaining pre-copy
> +  data that the vendor driver has yet to save for the VFIO device.
>
>   * An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
>     active only when the VFIO device is in pre-copy states.
> diff --git a/include/migration/register.h b/include/migration/register.h
> index d0f37f5f43..2320c3a981 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -16,6 +16,15 @@
>
>   #include "hw/core/vmstate-if.h"
>
> +typedef struct MigPendingData {
> +    /* How many bytes are pending for precopy / stopcopy? */
> +    uint64_t precopy_bytes;
> +    /* How many bytes are pending that can be transferred in postcopy? */
> +    uint64_t postcopy_bytes;
> +    /* Is this a fastpath query (which can be inaccurate)? */
> +    bool fastpath;
> +} MigPendingData ;

Extra space before semicolon.

> +
>   /**
>    * struct SaveVMHandlers: handler structure to finely control
>    * migration of complex subsystems and devices, such as RAM, block and
> @@ -197,46 +206,17 @@ typedef struct SaveVMHandlers {
>       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>
>       /**
> -     * @state_pending_estimate
> -     *
> -     * This estimates the remaining data to transfer
> -     *
> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> -     * pending data.
> -     *
> -     * @opaque: data pointer passed to register_savevm_live()
> -     * @must_precopy: amount of data that must be migrated in precopy
> -     *                or in stopped state, i.e. that must be migrated
> -     *                before target start.
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)
> -     */
> -    void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
> -                                   uint64_t *can_postcopy);
> -
> -    /**
> -     * @state_pending_exact
> -     *
> -     * This calculates the exact remaining data to transfer
> +     * @save_query_pending
>        *
> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> -     * pending data.
> +     * This estimates the remaining data to transfer on the source side.
> +     * It's highly suggested that the module should implement both fastpath
> +     * and slowpath version of it when it can be slow (for more information
> +     * please check pending->fastpath field).
>        *
>        * @opaque: data pointer passed to register_savevm_live()
> -     * @must_precopy: amount of data that must be migrated in precopy
> -     *                or in stopped state, i.e. that must be migrated
> -     *                before target start.
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)
> +     * @pending: pointer to a MigPendingData struct
>        */
> -    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> -                                uint64_t *can_postcopy);
> +    void (*save_query_pending)(void *opaque, MigPendingData *pending);
>
>       /**
>        * @load_state
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b3d1e8a13c..b116933bce 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -14,6 +14,8 @@
>   #ifndef MIGRATION_SAVEVM_H
>   #define MIGRATION_SAVEVM_H
>
> +#include "migration/register.h"
> +
>   #define QEMU_VM_FILE_MAGIC           0x5145564d
>   #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
>   #define QEMU_VM_FILE_VERSION         0x00000003
> @@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>   void qemu_savevm_state_cleanup(void);
>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>   int qemu_savevm_state_complete_precopy(MigrationState *s);
> +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
>   void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                        uint64_t *can_postcopy);
>   void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index d808ece3b9..b1ec51c77a 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -187,15 +187,14 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       return 0;
>   }
>
> -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
> -                               uint64_t *can_postcopy)
> +static void cmma_state_pending(void *opaque, MigPendingData *pending)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>       long long res = sac->get_dirtycount(sas);
>
>       if (res >= 0) {
> -        *must_precopy += res;
> +        pending->precopy_bytes += res;
>       }
>   }
>
> @@ -340,8 +339,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
>       .save_setup = cmma_save_setup,
>       .save_live_iterate = cmma_save_iterate,
>       .save_complete = cmma_save_complete,
> -    .state_pending_exact = cmma_state_pending,
> -    .state_pending_estimate = cmma_state_pending,
> +    .save_query_pending = cmma_state_pending,
>       .save_cleanup = cmma_save_cleanup,
>       .load_state = cmma_load,
>       .is_active = cmma_active,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 827d3ded63..c054c749b0 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -570,42 +570,51 @@ static void vfio_save_cleanup(void *opaque)
>       trace_vfio_save_cleanup(vbasedev->name);
>   }
>
> -static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> +static void vfio_state_pending_sync(VFIODevice *vbasedev)
>   {
> -    VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>
> -    if (!vfio_device_state_is_precopy(vbasedev)) {
> -        return;
> -    }
> +    vfio_query_stop_copy_size(vbasedev);
>
> -    *must_precopy +=
> -        migration->precopy_init_size + migration->precopy_dirty_size;
> +    if (vfio_device_state_is_precopy(vbasedev)) {
> +        vfio_query_precopy_size(migration);
> +    }
>
> -    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
> -                                      *can_postcopy,
> -                                      migration->precopy_init_size,
> -                                      migration->precopy_dirty_size);
> +    /*
> +     * In all cases, all PRECOPY data should be no more than STOPCOPY data.
> +     * Otherwise we have a problem.  So far, only dump some errors.
> +     */

I'm not sure that must be true, as stopcopy and precopy queries are not 
atomic, so device state size can change between the queries.

Thanks.

> +    if (migration->precopy_init_size + migration->precopy_dirty_size <
> +        migration->stopcopy_size) {
> +        error_report_once("%s: wrong pending data (init=%" PRIx64
> +                          ", dirty=%"PRIx64", stop=%"PRIx64")",
> +                          __func__, migration->precopy_init_size,
> +                          migration->precopy_dirty_size,
> +                          migration->stopcopy_size);
> +    }
>   }
>
> -static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> -                                     uint64_t *can_postcopy)
> +static void vfio_state_pending(void *opaque, MigPendingData *pending)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> +    uint64_t remain;
>
> -    vfio_query_stop_copy_size(vbasedev);
> -    *must_precopy += migration->stopcopy_size;
> -
> -    if (vfio_device_state_is_precopy(vbasedev)) {
> -        vfio_query_precopy_size(migration);
> +    if (pending->fastpath) {
> +        if (!vfio_device_state_is_precopy(vbasedev)) {
> +            return;
> +        }
> +        remain = migration->precopy_init_size + migration->precopy_dirty_size;
> +    } else {
> +        vfio_state_pending_sync(vbasedev);
> +        remain = migration->stopcopy_size;
>       }
>
> -    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> -                                   migration->stopcopy_size,
> -                                   migration->precopy_init_size,
> -                                   migration->precopy_dirty_size);
> +    pending->precopy_bytes += remain;
> +
> +    trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
> +                             migration->precopy_init_size,
> +                             migration->precopy_dirty_size);
>   }
>
>   static bool vfio_is_active_iterate(void *opaque)
> @@ -850,8 +859,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_prepare = vfio_save_prepare,
>       .save_setup = vfio_save_setup,
>       .save_cleanup = vfio_save_cleanup,
> -    .state_pending_estimate = vfio_state_pending_estimate,
> -    .state_pending_exact = vfio_state_pending_exact,
> +    .save_query_pending = vfio_state_pending,
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
>       .save_complete = vfio_save_complete_precopy,
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index a061aad817..376a9b43ac 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -766,9 +766,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>       return 0;
>   }
>
> -static void dirty_bitmap_state_pending(void *opaque,
> -                                       uint64_t *must_precopy,
> -                                       uint64_t *can_postcopy)
> +static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data)
>   {
>       DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms;
> @@ -788,7 +786,7 @@ static void dirty_bitmap_state_pending(void *opaque,
>
>       trace_dirty_bitmap_state_pending(pending);
>
> -    *can_postcopy += pending;
> +    data->postcopy_bytes += pending;
>   }
>
>   /* First occurrence of this bitmap. It should be created if doesn't exist */
> @@ -1250,8 +1248,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>       .save_setup = dirty_bitmap_save_setup,
>       .save_complete = dirty_bitmap_save_complete,
>       .has_postcopy = dirty_bitmap_has_postcopy,
> -    .state_pending_exact = dirty_bitmap_state_pending,
> -    .state_pending_estimate = dirty_bitmap_state_pending,
> +    .save_query_pending = dirty_bitmap_state_pending,
>       .save_live_iterate = dirty_bitmap_save_iterate,
>       .is_active_iterate = dirty_bitmap_is_active_iterate,
>       .load_state = dirty_bitmap_load,
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..89f761a471 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3443,30 +3443,17 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>       return qemu_fflush(f);
>   }
>
> -static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> -                                       uint64_t *can_postcopy)
> -{
> -    RAMState **temp = opaque;
> -    RAMState *rs = *temp;
> -
> -    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> -
> -    if (migrate_postcopy_ram()) {
> -        /* We can do postcopy, and all the data is postcopiable */
> -        *can_postcopy += remaining_size;
> -    } else {
> -        *must_precopy += remaining_size;
> -    }
> -}
> -
> -static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
> -                                    uint64_t *can_postcopy)
> +static void ram_state_pending(void *opaque, MigPendingData *pending)
>   {
>       RAMState **temp = opaque;
>       RAMState *rs = *temp;
>       uint64_t remaining_size;
>
> -    if (!migration_in_postcopy()) {
> +    /*
> +     * Sync is only needed either with: (1) a fast query, or (2) postcopy
> +     * as started (in which case no new dirty will generate anymore).
> +     */
> +    if (!pending->fastpath && !migration_in_postcopy()) {
>           bql_lock();
>           WITH_RCU_READ_LOCK_GUARD() {
>               migration_bitmap_sync_precopy(false);
> @@ -3478,9 +3465,9 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
>
>       if (migrate_postcopy_ram()) {
>           /* We can do postcopy, and all the data is postcopiable */
> -        *can_postcopy += remaining_size;
> +        pending->postcopy_bytes += remaining_size;
>       } else {
> -        *must_precopy += remaining_size;
> +        pending->precopy_bytes += remaining_size;
>       }
>   }
>
> @@ -4703,8 +4690,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>       .save_live_iterate = ram_save_iterate,
>       .save_complete = ram_save_complete,
>       .has_postcopy = ram_has_postcopy,
> -    .state_pending_exact = ram_state_pending_exact,
> -    .state_pending_estimate = ram_state_pending_estimate,
> +    .save_query_pending = ram_state_pending,
>       .load_state = ram_load,
>       .save_cleanup = ram_save_cleanup,
>       .load_setup = ram_load_setup,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index dd58f2a705..6268e68382 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1762,46 +1762,45 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>       return qemu_fflush(f);
>   }
>
> -/* Give an estimate of the amount left to be transferred,
> - * the result is split into the amount for units that can and
> - * for units that can't do postcopy.
> - */
> -void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>   {
>       SaveStateEntry *se;
>
> -    *must_precopy = 0;
> -    *can_postcopy = 0;
> +    pending->precopy_bytes = 0;
> +    pending->postcopy_bytes = 0;
> +    pending->fastpath = fastpath;
>
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->state_pending_estimate) {
> +        if (!se->ops || !se->ops->save_query_pending) {
>               continue;
>           }
>           if (!qemu_savevm_state_active(se)) {
>               continue;
>           }
> -        se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
> +        se->ops->save_query_pending(se->opaque, pending);
>       }
>   }
>
> +void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> +                                        uint64_t *can_postcopy)
> +{
> +    MigPendingData pending;
> +
> +    qemu_savevm_query_pending(&pending, true);
> +
> +    *must_precopy = pending.precopy_bytes;
> +    *can_postcopy = pending.postcopy_bytes;
> +}
> +
>   void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                        uint64_t *can_postcopy)
>   {
> -    SaveStateEntry *se;
> +    MigPendingData pending;
>
> -    *must_precopy = 0;
> -    *can_postcopy = 0;
> +    qemu_savevm_query_pending(&pending, false);
>
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->state_pending_exact) {
> -            continue;
> -        }
> -        if (!qemu_savevm_state_active(se)) {
> -            continue;
> -        }
> -        se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
> -    }
> +    *must_precopy = pending.precopy_bytes;
> +    *can_postcopy = pending.postcopy_bytes;
>   }
>
>   void qemu_savevm_state_cleanup(void)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 846e3625c5..7cf5a9eb2d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -173,8 +173,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
> -vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> -vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> +vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>
> --
> 2.50.1
>


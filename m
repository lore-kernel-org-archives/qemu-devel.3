Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DDDE9539E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnd6a-0004wg-4T; Wed, 04 Feb 2026 08:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vnd6Y-0004wR-6B
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:39:38 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vnd6W-0007IW-F3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:39:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anNGePXd7Ci6U2IQBlx0BV7gLH3KxkwocNJjP0k1N5AbyGiOOPpDb8URUc7cnhsSKG+o5Hm58TxvSwMuDEGmuZNJHMW+qKH9fNF3hgfHDaknGFY2+OkBYTVAzqwyCghujrsTq+azp3aX08GKiogjzyR4FkNxmTUQhGEGhOfJkxYNOkQTBpkhU1qlttFUuw7YPzubKWd78W3RDEnqc4Etiw/E0oS1VsMY4p0xlFGAHsWGWbEUXRfHR9ADi9U9rRITb/2NJt3Ie6qwSGIXlwNE4bzPmhbiiSchOMZ8rG+qWPQWbEI4AtfEj2KPOUbQBGBhtf/c+ATD3JEl6OZrIvnkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIycZKgaWX7BoRaFy5trw9lbqOQRgvpSVrkRO+dTNgU=;
 b=VbzBZ7grJtGLBT6zYGpNUp+QNSHfSQTZ+6FWvaIagDBpa9md7DX3WI331BUzfHnp6Aau3QsJ5Z5gjvQv54XofCecBWdM9gAhlCtj0ndPgEDmK0UPxKeuDlJr3CmRl7oyOZWCoY70v1RBCNEyI73ZKn5OF6cllAAyG31AEAUTn7fhbah7Qs0ygCbips2ZxSzXDYpOvCoy3+Wc42Gmh6t69paVCtxYtzPLpzMYab+h8Q7jGm6mDLT1+vBODR49P6VUcSRp43SxNUUT7tqFtZLsKsD0Bh+exAa9woNtyYiBKUtujgS6JO5MYLfCzPmG7OE0p890Ip+lFcOMha0Hb0TF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIycZKgaWX7BoRaFy5trw9lbqOQRgvpSVrkRO+dTNgU=;
 b=EYLPPNO0j9ZAgt0VPidoEwDl5Ip+BZejaN8rsgxmOD4rYBqlYBXZZtI/zniqEPIPyROy4YXZ/BJb2Qf26IhY7oRe9dQCc84UlKoA+ocwWkMxHQHq+SFZ62VgZerwoV1G/CEmiqlA8Xh4/zZor8zAAjE9LdH2WIH6SreWXRMrvFG0FmhjKUIu09aokNW/ABKyHm1lRu4FRsThw0ncy6fZeGswQ9WU5JmEaxby19qhQEAOsaF0ItqkystrxVS7ZiC/5x4o8eCouG1nxxlOZkfbcxxT14v2PNasL7o2mORcFQrLikel0ybz7jKjUCXR4EGWRqGUDJsklmo4nIYO1XP1ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:39:27 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Wed, 4 Feb 2026
 13:39:26 +0000
Message-ID: <af10c110-d2ec-4b92-b33e-7f259c3d7646@nvidia.com>
Date: Wed, 4 Feb 2026 15:39:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <87jywswslz.fsf@pond.sub.org> <87ecn0wsif.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87ecn0wsif.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b867ee-3b1d-4025-78dd-08de63f2d055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTJheHlERmNtZDlxVXpyMGFBUzFHeVErWmdSN0M5anZYSTFoL1U4LzQydjRK?=
 =?utf-8?B?eGE0MHV3OXYvbWZsMWR5cy9zbjNMZmF4SVptWnFwdDE1MmdGWTRNUnlNRVUr?=
 =?utf-8?B?WU13TkkyRkF5Zlo0clJJTmFRU0JnQ00rL0RybDh1d0lGN0NFZWpxUjNBeklI?=
 =?utf-8?B?bGFxUTBmRVZhWkloZ2pWcWJpUXYrZGVNWUtYM3FnZURDYTBEc2RXaTZ4S2cz?=
 =?utf-8?B?ZnRxc21hWmtBenNyanlBOFMwQlFDUGZmdkRvY1d5QUprNEZ1YnUxd2hiNWow?=
 =?utf-8?B?eVNkMHcra0oyRUd0QkFrRllkajFRMkRIc3I4N3I4ZEZOb2JhR3RSdHc0MStL?=
 =?utf-8?B?OXZYM1QrM3pTeEMzcS9KQS9JMWcrQ3BQdXVNeTQ3UWREOCtKY0RmMnRLbkRU?=
 =?utf-8?B?b3RlTU5XYTlBeThsa2NXTDcrZGR2a2EyN2xiUEppYXU2dHU0Wk5QL0RBNmRL?=
 =?utf-8?B?UTF5am1TckhYb0tNei8zZkZuaTBxTGNwa21DdE92ay9lZDBXRjlSYklVSy94?=
 =?utf-8?B?bjlHQUZ5M09uSlEwZmR5WTFSdDA4ZmQ5cEZ1Q0g5c1AvMU9VdDRTcDNyamJh?=
 =?utf-8?B?SFNwazZ3ZGdYQm93NWthR3I5RnlYcm8zNGJpOTZqcWNRdXRUdHh1V2owQlRZ?=
 =?utf-8?B?MnJYR25WTGZvaE9YejRsSFBIa2twTmQ0Uk1PaFlneFc3dCtXOVVBak5ETy9C?=
 =?utf-8?B?ZzlZVUpXYXpjZG9TTnRYL1AzVllMckZIYnVOeU43VDNsQWtFdWZJZkF1Zkcz?=
 =?utf-8?B?YlcxVkRVMzdCNHBPRDR5NFJDTXliMEhYNHM5UlcxWHJiTmgya1U3ZnVmOUx1?=
 =?utf-8?B?V3ZYUGJtZVljdnJFMmFqcXI0UXAxcmpFY1BVU3B1Ump0Vmw3ZFBBNVg5a3ZG?=
 =?utf-8?B?ZHBUNFd3ckpTWnd6alc0RHZ3Nnl1S0laQ2R1Yjd4QXNWeVovNXpUNWRsWHdu?=
 =?utf-8?B?WTJTR2Z4dFBGbVUyVHNkbjRJbHBjSVJ5L3QrZnFjcC9CcFBWQXFLNGZJQXZN?=
 =?utf-8?B?VXpScjhicnFQaFZWY3hicVdDTDkrWmlPcTR0dXRHQ2FBQ0xDSU1QbldUREhp?=
 =?utf-8?B?c1cwblF4QjNxYkxvcUNTaktKVGtnTTdXOWlOektjSGNUTlhWd1RiZk1LczQw?=
 =?utf-8?B?Z0pxTFBqL3IrVld1aWFMdElNbjlYT3NNR0pDRGM0bDcydElMMXprZ3JZQ1F1?=
 =?utf-8?B?ZVBMdFpTZnZRQ0MrZHVjNkZGZVhHaEFwS2Z4b2R3SFVsbFVjMGlISWV6d3di?=
 =?utf-8?B?T0htQmNGclZ2T2JLbnVySkRacW5YTThJVWJNbG80RGt1R0lWOTRzaXhlY0xn?=
 =?utf-8?B?QWJ2Yk15YWVXcEpZN2kzZmxJeDYrR0hCMW1IN1hyb04wOHIzNG9BNHdsQndz?=
 =?utf-8?B?b0ZKaWRucVlCbW5oSGg0VVNCTGVYV2ZlbmJKRzd0YmFlOEk0UVJjdE94WDV3?=
 =?utf-8?B?U3dKYXJZdDJCR2tJdVp5SjVtK1FEckw4aHJTS05pdG5xRVJCcno0NG5WL3Yr?=
 =?utf-8?B?SnIxVTdvalRzTnM4ODdTaDY4N3hXQUhBK0cvMmpUSFQ3dkdjak5RVHlBdmh2?=
 =?utf-8?B?OHNucG84azZGcDlMUVJDeVk0NTBxbUdvaDBxRjcvRWpiRFp4SmE0MEJVN0tX?=
 =?utf-8?B?Q3NVZnhvbW5qbXFwQUxpSEJuUmwwL2x1TkZOeXk4TXlvKy9KeTNFcGt3SS8w?=
 =?utf-8?B?RUVaczJRV2RxWC9WdGUvS05uZXNQa1AwOVIrSExZU2cvVDZCbnZJanVvaHpC?=
 =?utf-8?B?cGN1dEozVkhRdUptemsrL0t3V1hoRmpxS2x1MnRWMW9HeFdqb1VUbU56Qjcv?=
 =?utf-8?B?bEtnWUYzVEdDcmU2d3puSzIrU2VtUisvemZRdHVOTDJvcTZTUlpKVG1lQ2R1?=
 =?utf-8?B?bVY3UWFCNGQ4YkVYdWMzWFpRZTEwa1FEQzIrdUljd05uRHRhY1RZYXhLZGJG?=
 =?utf-8?B?eHJkWHZZdlY5MnNWZFU1aUczdEVkN2ZlUkRTdU04bVJZeGFZczBtM05YK1FL?=
 =?utf-8?B?bEQ1TVdoOEZOTEk5ZVpUYitVKzF2ZWRyRkhSSjhCY1BUSHd3N3N6ZnQ1YUg0?=
 =?utf-8?B?SlU4ZzduRjREQUlyaEhkek1VR0VpYldmR1NHVDFnMlN5QUprQ1QxWlc0Tjc3?=
 =?utf-8?Q?tv6U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1YzVDdXTUpPTWovb0NFWUVseVlXQ2FibGV1TWFDVHZTVGdGK1hqa1BYZWw1?=
 =?utf-8?B?T0RuZnY5QkpuWndYRDZ2WlVYWlJ5TmVLVFBPZE1lMC9QcHByaUhhajVTeG9v?=
 =?utf-8?B?VWwyamNOS1h6b201cDR4anBLbzVVMWkvbU16bUR1eUdMYTh4RmpDZm1EQjNS?=
 =?utf-8?B?M1BjYklhdm5OSVE3S200V2hnbDY4QXpuTzUzcUdWMERhK09Va1V6aUR0dW5r?=
 =?utf-8?B?RHIrWlZVeUpWMjBqK04xbVR1ZkI5TDZiYi9iRnhlSGQ5ZzJxUmIydEtkQ0NG?=
 =?utf-8?B?YjR5UnpPR0hxcFVqT2tJMEZaWUJKUTFPNWcrSmdxdVh2TWxXcFZ0WStRYzhX?=
 =?utf-8?B?SWRBQVJDVTNUVnVFR2kzaUZYMHU4Vks0R2JKV0RuUXpoa3lJby9sNXZJRnJz?=
 =?utf-8?B?dUlnQ0tqcFpkTjk5ZHpnU0lhcUNVMGFnQ3Z5MFk4d3B2bUNJM3MrSWRyd3g0?=
 =?utf-8?B?dG5xdUZrRDdYRXVEdUNOS1ZrZFJ1TCt5ODdDV1pDLzNnVjl6em0zTXFTZk96?=
 =?utf-8?B?ZmxUT2RrMW5Pc28yb1pQU3RYRHhCeHhaazNuemlxZjA3RnVXZGZKMWxiNGdU?=
 =?utf-8?B?ZFVaaFJ2NFhNRTlzbGVDR2NvK0tqbFptemtTL1QzL3I1U3hlTlQvRWJjVnp3?=
 =?utf-8?B?U3Z3Q2FSSHJZbkJXYUdIMWQyYnZmRWJOSDVldE9BYmNhZzA2cnNlNXJKWDZw?=
 =?utf-8?B?R1RvNjBIRi9acVJoWW1QYjEwNkxpT2plRzdaVmI2NTNiMVhibnlieGdVYWll?=
 =?utf-8?B?ZjYyWlgyUS82ZnB4bHZlVzkwTTlsNFVwRWdvVmhuTDlvYU5Zd1RYTTF5WVZr?=
 =?utf-8?B?d2xxcWZrdWZFdVlBeTBvT3JjRjd0UUFtRjRMMVNsS2o3OHdSL0VKREM3dHhB?=
 =?utf-8?B?RlpmQU9SZm16Z3ZsdGNpZGVOQlhseDhUUENTcEhkcjJJNkRKNEZ3Y1MySDZx?=
 =?utf-8?B?WW13TitEckY0ZjdPM241Z1dRQlpmRnZVK0QzVitrclk4dDlLeXJVMXRZTVlN?=
 =?utf-8?B?TytLRTlmYXBrODh3Z3RMT2t4NWVqaURwZ0UyZHNPK1FXd0p1RWpHdEpYaHY0?=
 =?utf-8?B?Q3pmemNiQXJPK2RtMVhsNmVJMlUyMFN4SnYyQVllczJzNTNtMkZ0Z3E1UUFi?=
 =?utf-8?B?OWZrbzN0eXhBVHJ3djh3K1VaeFkzM2F0aHhMRi9xajMzTUtRcnRkWmlEckxX?=
 =?utf-8?B?WFJTY0ZtMlF4WVBGWHJyY1lJSW9BMU9TMk9MRm9RWUdPdTZjSzhmUExGdjFv?=
 =?utf-8?B?NHA5ODVrNU1xTnBrR2F2VEs3aDBFcXZOZm5MSGNMQThnbDl4YTB0ekJ5Y2Yr?=
 =?utf-8?B?b0o1bUxxb3Q1elcrb2xpSC8yRktMKzkvUkdFaXliRmRXWitrS0RqdzJLenRn?=
 =?utf-8?B?TVBXY29iaUREYUNPOGgxRWwwaXgzRzZPREZBOFBzbXVjMmorV2JXK0dxcFNz?=
 =?utf-8?B?UEJ4WnpOZ2FtcGdLTnNHQVRiK1MxS2tEODArbEp3Zk1oRGpHZmZWQ3NreXQx?=
 =?utf-8?B?VjhpQUVwZnkzQnhlVTN3dWQraUV2dzdSalkveXQ1YndXeDUyT2Y1eXBVeUFN?=
 =?utf-8?B?NHBvNGt0RGlDU21acFZWekY3TE9QR3JQUTZBMDYvRnVwME5rZ2I3c29jQVNJ?=
 =?utf-8?B?R3dEU0NuTUJ5V3ZtTUFjUDkvL3Q2MU02Wk5vZ3VmT1VVTGdWcnl2TksxMVdO?=
 =?utf-8?B?OTlydWhoQTBmZDYzWGp3d0traTYvVXh3OUtUaWZiWithMWxpcVZpT0c0UXJX?=
 =?utf-8?B?cFpBNHlGL25XSEVRSDVIbFdsc0M3VTNPMWMrbVM4dkRyS0RmbkFEWjBoMVo2?=
 =?utf-8?B?eGVndTlNWkZ4azhxazNsS1VERXpJMGFFKy9rT0M0azJBMFNjSmRJSndVcFk1?=
 =?utf-8?B?czgrWDI1Um43S3E0eXk4cGdzWU5KZEpObnJnUWQzaTNzTFVCZWNyRHlwSHlU?=
 =?utf-8?B?dUplSCttRjhCaWxLUWEycFNJT29BTTdpTkQ3Wm92ZDlnS2JxV2JER2JWemhM?=
 =?utf-8?B?TXQwVXZUNXdIVklkVG0zSGdpMDZvbStXOGprNnhGMDN2aVJKRFJHTWZJUWRH?=
 =?utf-8?B?ckdWUG94Tk15aHdBbXFVRUNqQ2QvRXdTSHE0TXpqODc2eSs2OEtDZk5nOUNN?=
 =?utf-8?B?czVUK3JzNkhyVk5hdzJIQlJNVFZOK09vOEExVGp1aWRrNE1TZ2FHbHJCVDNI?=
 =?utf-8?B?ZG12Ui9yOU1SK3F4dmxwV0ZYNW1vUGRYSjNhVXBCK2l3b1ZmNTYzb3Z6Tzg4?=
 =?utf-8?B?SlNRTVJJMVlJRWFackxmU2NKa05HbDRmTHhPYzF2VEFFTnBtZmFRYTJ3dG9Z?=
 =?utf-8?B?ZGRTVy83MTFlVHpjemlieThaaDB3cGpPd1Nkc2pkcXpxL08xd2NMdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b867ee-3b1d-4025-78dd-08de63f2d055
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:39:26.8589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZepVs1JQgBZqncQ94Pa+A4yVwrSHMkjHVNGkbfXq5goDvk9uJg85/CwsWCi0XSv9zlYQo5KiXu9XNBoiG1Dv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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


On 2/4/2026 3:24 PM, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Markus Armbruster <armbru@redhat.com> writes:
>
>> Avihai Horon <avihaih@nvidia.com> writes:
>>
>>> The VFIO_MIGRATION event notifies users when a VFIO device transitions
>>> to a new state.
>>>
>>> One use case for this event is to prevent timeouts for RDMA connections
>>> to the migrated device. In this case, an external management application
>>> (not libvirt) consumes the events and disables the RDMA timeout
>>> mechanism when receiving the event for PRE_COPY_P2P state, which
>>> indicates that the device is non-responsive.
>>>
>>> This is essential because RDMA connections typically have very low
>>> timeouts (tens of milliseconds), which can be far below migration
>>> downtime.
>>>
>>> However, under heavy resource utilization, the device transition to
>>> PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
>>> VFIO_MIGRATION event is currently sent only after the transition
>>> completes, it arrives too late, after RDMA connections have already
>>> timed out.
>>>
>>> To address this, send an additional "prepare" event immediately before
>>> initiating the PRE_COPY_P2P transition. This guarantees timely event
>>> delivery regardless of how long the actual state transition takes.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> [...]
>>
>>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>>> index a1a9c5b673..17b6046871 100644
>>> --- a/qapi/vfio.json
>>> +++ b/qapi/vfio.json
>>> @@ -11,7 +11,13 @@
>>>   ##
>>>   # @QapiVfioMigrationState:
>>>   #
>>> -# An enumeration of the VFIO device migration states.
>>> +# An enumeration of the VFIO device migration states.  In addition to
>>> +# the regular states, there are prepare states (with 'prepare' suffix)
>>> +# which indicate that the device is just about to transition to the
>>> +# corresponding state.  Note that seeing a prepare state for state X
>>> +# doesn't guarantee that the next state will be X, as the state
>>> +# transition can fail and the device may transition to a different
>>> +# state instead.
>>>   #
>>>   # @stop: The device is stopped.
>>>   #
>>> @@ -32,11 +38,14 @@
>>>   #     tracking its internal state and its internal state is available
>>>   #     for reading.
>>>   #
>>> +# @pre-copy-p2p-prepare: The device is just about to move to
>>> +#     pre-copy-p2p state.  (since 11.0)
>>> +#
>>>   # Since: 9.1
>>>   ##
>>>   { 'enum': 'QapiVfioMigrationState',
>>>     'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>>> -            'pre-copy', 'pre-copy-p2p' ] }
>>> +            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
>>>
>>>   ##
>>>   # @VFIO_MIGRATION:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
> Except for the subject line: "vfio/migration: Send VFIO_MIGRATION event
> before PRE_COPY_P2P transition" become misleading in v2.

Can you explain why misleading?

Prior to this patch VFIO_MIGRATION event was sent only after 
PRE_COPY_P2P transition.
Now with this patch VFIO_MIGRATION event is sent also before 
PRE_COPY_P2P transition.

Thanks.



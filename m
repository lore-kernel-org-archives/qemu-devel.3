Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A3C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq54r-0002wX-UI; Thu, 06 Mar 2025 01:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tq54Z-0002ui-FK
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:51:13 -0500
Received: from mail-co1nam11on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2416::607]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tq54U-00079w-57
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:51:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFtVG9fK/Ow46FGYD1ouHC6ZM2JH63pEDIdJVg30LAGzNCSGZ7BRRVqd2OxF1FWW7xytjFKYXfyV6IV8M/u1bZAHXakXAP2GDexZeTBkHTsYQ73jZbPFE7VHQWh0FEZPus5YQoRmjSJRUTrHBNjM5gMFJ4WaN0gTmmm/Q/Lax2gCC7orRNvn/8HIpI9ZkaDRj9ESaMK++vlXCqtFgy1Slp3nULk+NrNkOnrT87J/QbZGo6tJkMkj+zTAVVlvp9I9O5OFAknQuOEGtM42Od8YxehXU+JsZqR1sde62oGPWJL18YaSVv4IhqG5scDEEWUdfKiJR6WAMpMuBgf7o8+lfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf3teYYUPNSrHS9A3pC/Mqk+MJ46salQ9RvywXibiCc=;
 b=DZ6rDY6PZClu0aWV9Jx5W+JwLZfl9mo21kyLvdN7N8tZ+RdNmTsXQlfDUtbMWCfRBiTszBw+ZbNRZKxJoTuZsKzWa01bA+IQgSfMttj0FOjfNdnUFE+LFzZwgJczfev93nBk2wscUPKCrRwa9kw7vtueuDiOqOkuAAFo+9oT7VmyfS3ySk1jlzIekTgJg/hmOHZdmMWYiWypth2BlSMclBy2fqHguZ0KtCOj65BXhSb0kswS3sWGWBFNyPQObEc50PuSMmQwbH9V132pL9Hj5b6z+I3GE+oxECr9xbDROdQ7+QEb7ZTYb7lG2lUfyzewHR1CXyIveoIAuUN6K4CAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf3teYYUPNSrHS9A3pC/Mqk+MJ46salQ9RvywXibiCc=;
 b=iiAVtsZc85MdI7St0hjJ0TzCR/7AC08thF6FymyeH7qBx1l6ntqQIRlCE5i8I346rBQie+H/ZaxTGqle48oQvksYEIEUWw0Q5hGllaReFxxTa/oxAGF9QEtqinqsbzZDviZXwRFoclNcR9kH7IR1A9Ve5+NWHCoc8gK6+tu+gltj/qab8YWdlVAdgTCa3Gj1Eca6SlaIzLwJl3Yde6fxvcmyfH5jYZ2Hndrn6DXqZEe/l3yR/UgkJZpxUy9XF49uuuWNhz5leOrgLkHNhM2mw9YjCYudaDrf6bTh4jtW7HjvvDkwNPma+Rb1i9sZxjCNfAadVER3Ikz3z0YObyR2uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 06:50:23 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 06:50:23 +0000
Message-ID: <ea286c83-15da-4c5b-9d71-128412ff559d@nvidia.com>
Date: Thu, 6 Mar 2025 08:50:16 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00/36=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
 <ec8bd66a-ae3a-49c0-aed5-06a83e892491@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ec8bd66a-ae3a-49c0-aed5-06a83e892491@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a83297-10d8-4ae2-6210-08dd5c7b2b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTU0Sm1UaFBWNUV2clZlV2hqaXNFWnhBM0pWZlQwVmFLM200bm5Fb1M2aGlK?=
 =?utf-8?B?TEhrRDNGcjVyQjRlUVRxVkdiMkVmMnMva0FlVmNYL1RXWFcwTjdLOE0ya093?=
 =?utf-8?B?RGM5bmJFWms1VncxTm4zdXZBUlIwODc1MnM3RC9iKy9TU1Bkblh3cEE4L0ty?=
 =?utf-8?B?OGkrQmtFaXkycmZxeHJwa1kvQ3dGcFlpaXhjTjZqTGVoejcyVm1BMUtMQ2dN?=
 =?utf-8?B?RlJBTTc3Nm5KYVFweXJZWWV1U085MU1rN0FuSnNuZlpIeDJ3VjVkbm1zaDdv?=
 =?utf-8?B?RUNvdjl5elg4UE41OG50WVBUTmJCSGJVRWpqalZkV0hhQWZaa3psT2tId0lL?=
 =?utf-8?B?UHlpRHBtcElOSEJHRFIvNTF6SCtNVUN3M0VPYWpiZ3U1a2krbVNSaHoybU1t?=
 =?utf-8?B?TzRYWWFTOXN5aHN0VHcrZUlVZHBSV25ZVUNUbC91cjVOaEJYa3MzelhJZjJp?=
 =?utf-8?B?VkUybTZnRGtTNkFzQTZkUHVPY2UzNU9OeHpnYzEyTWxDeDBZWkZsMTY5SkMx?=
 =?utf-8?B?UUs5WUJqZDRYQlBXQ21SUE1BdkFWWVpGYUl6VTZqaXFZUjFQSmkrMTRzTkV0?=
 =?utf-8?B?OFBhQnQvNkJadjVqU2pCSFZ3QTNjdTU3NzBhYXNZdGlrdmV4L1ZEM3JFMWV0?=
 =?utf-8?B?N1hHTDJmaHNtKzllZUtSTEh6eXl2b1Z0ZkZhS1ZUUE9YOEgrYktQSzUzblcy?=
 =?utf-8?B?VmhLK1VoMDFXOHBHemE4MzNiWGVkcmxvNEtLV3N6WEpDN25oT1E4dGRVNEZD?=
 =?utf-8?B?d0FWdWVuemxSM3ZQV1ZVKzgvaVFNcDV2V2tkVWVCcHI0dHB6UTdyOW9iNE03?=
 =?utf-8?B?cHFoWlJyOWJ4OHhQeTJaZUNMVFBETG5jTStRSTJhQURNWEFDbU1nZ0FMbGV1?=
 =?utf-8?B?V2k5NmVUVVl4NW81WHhtNk1JRm1kakxaWkFqWC9hQmVabXhIT3BRUlE5U2Ur?=
 =?utf-8?B?WHZzd1RYVXY0MUw4dENSVmtNbTlLOTlST3g0b3M1ZG1SOXQ2K0MxdE5RUVdC?=
 =?utf-8?B?a2dnY3lDaDdNQWR6cldBbWJjQUd0UlNaUkpwQWpwUGpSNFljcWw1WUNsUUdi?=
 =?utf-8?B?RXRNN09jSFhWNndoU1RWeElVcXNwNlJXb2w0NWpxWjJMU1R5SUFxN01wdTRw?=
 =?utf-8?B?d0tYaW5tZ2tRZGxSSVZkMkY5b2FtZGRVV3NGUThNZVROVUt5OVJGZnVaR1I5?=
 =?utf-8?B?R2xzakpRa3dFZElaNzR6NmVHT1V3WlhGOWJRb2FSRTRtWWQ3WVQ3K0F3c0Nu?=
 =?utf-8?B?ajFuZC9MQ29ucEt6MWJTYTRaS0xwK0QxeXVWY252ZlVoREhiZW9NcHlseFhW?=
 =?utf-8?B?akFXbHhXQjZJRncxdVhrMXV3UkE5d0ZiYWFyc0JCdm11WXVCRnpLSlFtR2Rk?=
 =?utf-8?B?VjZEVXR1SUlNMFlhRWZBS1l0ZGlJelpZM0xuRFdxK3lvWmZaKzJ5T3hrRGJF?=
 =?utf-8?B?Zmk2NVJ3a0NVOFcyMnBYaUl0QTRUQWFwL2g2biszQW9ZMFJUOHoxWkw4Sll0?=
 =?utf-8?B?eFRjc2plaUtqbjJ1RWRLMU5hNWZMT0NJVUlRaFY3dmt2S3Y2RE1iaDJCUEVY?=
 =?utf-8?B?OW9xZE1oejhMeWk0cERWQ055STFTVm1UaVNvdmRzYTNaODdyQUtqeVBLZ0xH?=
 =?utf-8?B?b3h3NHV0OE16d2ErQUg4Y0VzTlV4REFIVWVpdFJ6WFc5U1IzcWJwQnRGdFU3?=
 =?utf-8?B?K20vZ3FKNzNiVzEvcmxRZzF0NzlnbWs2N2ZqeGVqSXdQRTQrNHBoZ0pvL3gz?=
 =?utf-8?B?bGN4TURaK1I3emFYMHhydFl0VW1sMFpyUXlJNnR5dTZmZ0JWTHVFY0U3ZkJX?=
 =?utf-8?B?N0NzRzJmTHNBaEU0ejNzK2lJbWljSHZLS3lEUnZRWUMrUWI4ZlRsQXNXQkpm?=
 =?utf-8?Q?u96QctgRLrmEx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJUNkZUR20vcC9xK3VQa0ZUUldZekpyUmNGNVRRZjMzSm0wYlUwYmxuamE0?=
 =?utf-8?B?a25zTG9kSHpIWXdXUjlxQXJ4NFZtK0NWTWpQWWhqdjdXMXRvWXVKNGJobEwz?=
 =?utf-8?B?dW1BVEVIa0x4Q2JYWGZWNSswUWZVMW5XMnk2NytZbVpONWt6aGNlWmpEdnFH?=
 =?utf-8?B?WjZNK1IzU0lab3gzSmlia0hERUcyRmVCMWlxTm1UVWtHTGdVNXQ4T3VGS08v?=
 =?utf-8?B?R0dwRDZzV0U1SmxHUERuNXkzUUs5eUs3WHdmbUZyMnAvdEY4SzRFVHgzcEdS?=
 =?utf-8?B?THlKS3BMNndISnEvOWJRTlhFbWJ4VUk1U3ZZZ0kwMkxiOWpwK2JzWFhuRlQ1?=
 =?utf-8?B?WlhVcEFMNU96NlNOK0srdDJ2ejB4cW4vdHFKSi9mdERsN1JNeldHcXE5SGU1?=
 =?utf-8?B?R1NTTzZsR2E1T3J1Rmo1a04vbE5PcmFmNStkUlFaeEd0RjJNOERaM1RxNzlk?=
 =?utf-8?B?RkZmeUpmZUhtUkphOGJzc2tsS3FRdGpRMlRyTmdQVWJIL0hONXdIT01jaksz?=
 =?utf-8?B?ZCtzeW56ZmRCNDFLVGlXTldqTm0xWjY2c05YdjRoZGdoZnd3cjFUa2c0d1dM?=
 =?utf-8?B?b2J0Qm0zZWFnWXZpRVBSZ2ZCZXdPaWxaN2txWjBGZHZBTXJTdHJCMXBGbEtF?=
 =?utf-8?B?djlxbXFzcXBhbkx3OEc2VEhTM21UU0x6WXNIeGRvSjg3S0tVK3B0dE9qelF6?=
 =?utf-8?B?dFFKdm1wejFZS2hveWtlSkM2bXhlWnpFd051bWk4U0pEcUd1T3lBa3BrVWRi?=
 =?utf-8?B?Z0N6ODI5YVJEL3hvYnErSGtDVG55bUl5MENMWlNjWUxVZTMzajRNd3h4SVkw?=
 =?utf-8?B?RkpXYWt1Sy9rWlVpQ3VHSi91Rml6UVk0OGhiR3ZHQ2VEbk42dlRjVEtWTUho?=
 =?utf-8?B?ZGxWWjQrWGlFbkx5ZXlObi9lRndWUkVIZVVwS2lDdHBRb1B0c2JEOFM5UFVP?=
 =?utf-8?B?aUN1TFFCWnBzTmJhZzFURWRKK2RhSC95MnVxa216SnBmN3U3Y1Z3UUlndStt?=
 =?utf-8?B?MkZyNlkrQyttV3dzSHVGRmhLWmlCdUFiQ21qS21RMUtyUTNiSmQzTm5aNVE5?=
 =?utf-8?B?UmxudXRMajRJN0ZjUVlCQVlzcEpReldEUE9JQ051d0pFS2RrOXpuazY5YlUz?=
 =?utf-8?B?MW9OK29TcnozRlU2L004OUFkLzlSSCsxcE16bnhsYTNjajRSQjIyTmx6MVJT?=
 =?utf-8?B?MFc2elhEV2FEMXgxUmxpRXZNMmZsZlR6UTRETzU5L2hmcDZFalpoWEdtRm9Z?=
 =?utf-8?B?bVRLMldXREVnR0hobVVLNldWYm1IaTdibkF0L0UyKzBaQmRNeFcrTzZHc2tJ?=
 =?utf-8?B?S1JsVFZ4a0lqRysrRFZBVFRJVTlnV0dEeW44ZnYxUzdneXJxMlBGMGpJWk0z?=
 =?utf-8?B?Q2FsTmY3V1JDZm80YW9OWmxzZ1RoNURqVThheCtMOHdJbTZpZlFjTk5xYjJX?=
 =?utf-8?B?cXZ2bk45dWdMUWcxd2RPOFJwRTJyMmtFL0dhbDd4Z0FNbVBOR0p5U3prR05p?=
 =?utf-8?B?cEpVSmxrRklpVkc5T1RMcFpLUlFPUGZ1ZVVCeDhYVCtnQ2NCV3BwVWtnVDNN?=
 =?utf-8?B?ZWIrR3E3T0J6eER4cTVheWV6T1Z5RDRLa0ZGRm5lTStYcjFtKzRnOVZCUzBI?=
 =?utf-8?B?ZUt4c29LbkhEcnB4alJRUHJXTUtIYTVNL1ovOXJySjM4aVdkek5ZSjllaVZy?=
 =?utf-8?B?RmFabG1mZjBGcmRxZTRRQU43QTlKMVZJcU84aEN2WU44cGJmU1M4QXVEMVdT?=
 =?utf-8?B?VFNQU3ZiTDdvMHFZbGQ3dGVvSkRiMm5GaDV4VTQ0bXZKKzh1ZWtONFBVY3Vp?=
 =?utf-8?B?eElUWloyTFBGRTV2ZWZYSkozM0IxZkI5QnhBeDJuUG0vVU9hMU9OUWJDcWRo?=
 =?utf-8?B?Q2VjdWhEdlFZTFo4KzlHWFBBaFlIdEthME1mVnFSeSs3NVp6ckVoWjU3ejRu?=
 =?utf-8?B?WUdRL2p5eDZQdkFsYWZuWUMrSnJZTDRmMlQ5RDh3NVVhY21XeWs3SDZpNE9E?=
 =?utf-8?B?eFQ0aVQ3WjVhTjd6Nkx3cGtQUlJOT3JLSVFObE1Bem5WN25nZVRIZkFzT3VS?=
 =?utf-8?B?d0t2czBBUU40MjZUTi9LaFpIODdUUWdacEE3ek9pT251aEZscmp5MVpHeDcz?=
 =?utf-8?Q?qg6hFWnGraBizJuriCDn5dU4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a83297-10d8-4ae2-6210-08dd5c7b2b6c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:50:23.8228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4deOmhmJx8PzuCW5ygtZEBEKQCy6/IP07qOedsBt8zr+VvUlDe99hkQMW93vbHeeyOFAqZXZu968Nhvb05LWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
Received-SPF: softfail client-ip=2a01:111:f403:2416::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 05/03/2025 19:45, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/5/25 10:29, Cédric Le Goater wrote:
>> Hello,
>>
>> On 3/4/25 23:03, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This is an updated v6 patch series of the v5 series located here:
>>> https://lore.kernel.org/qemu-devel/cover.1739994627.git.maciej.szmigiero@oracle.com/ 
>>>
>>>
>>> What this patch set is about?
>>> Current live migration device state transfer is done via the main 
>>> (single)
>>> migration channel, which reduces performance and severally impacts the
>>> migration downtime for VMs having large device state that needs to be
>>> transferred during the switchover phase.
>>>
>>> Example devices that have such large switchover phase device state 
>>> are some
>>> types of VFIO SmartNICs and GPUs.
>>>
>>> This patch set allows parallelizing this transfer by using multifd 
>>> channels
>>> for it.
>>> It also introduces new load and save threads per VFIO device for 
>>> decoupling
>>> these operations from the main migration thread.
>>> These threads run on newly introduced generic (non-AIO) thread pools,
>>> instantiated by the core migration core.
>>
>> I think we are ready to apply 1-33. Avihai, please take a look !
>
> Applied to vfio-next with changes for documentation.
>
> Avihai, I will wait for your input before sending a PR.

Other than the comment I left everything looks fine by me.

Thanks.



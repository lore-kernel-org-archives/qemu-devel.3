Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E2CD4F54
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 06:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR2Vy-0001GY-EM; Sun, 24 May 2026 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wR2Vw-0001GQ-Np
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:40:44 -0400
Received: from mail-westus3azon11012063.outbound.protection.outlook.com
 ([40.107.209.63] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wR2Vs-00044k-V2
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP9nsk+NcNzGNiIprseEOFukwhJDTki1mhbux3sRgk9jH/Ml6BU2iUOWnsUX1+OeBSSxslJrl+cRSCn2QFr3xETR9n2/u+f3wkr3+cCCNI3UqsKCzVWExVshvql8iJhgdZC7orO6hAA09wPY77r+ode8soJiJjogUGn7wAdMRGBMmnuLDvsH7UB3z/ol8+RNi4SWSENzzpl1qCn80uSKeoPH3m1vCQK41DONvvwulgkbFUhqaZHxJbYW1rYzU+zFqc/V4qieebu3MYdVdWu2WIcl+K/jGB0CYkycgQF6t+qW6AQ3syn5tGzQ88jJqptKno98mxcete0gvu0e8M0CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGHrndnABuoOf+twlIYHtPuOtiFlwn7L3JswrQeJRYk=;
 b=WlrWYY+LcPmapkve35uc1cbae/oUdZVSMbe+VHOVuAvxUCwCs9RuJjZEfuLHn2/F8zApvRMuUvKAx3wYo6YqIIdqSiI+8getCr9ORRUgMAedCU5+KGL7GaqkXX9UQPkNuCPsYkrfqBG54sQ1ZyEoLibU3TGvu0NNI+x9zJ/GFg5SGaG4HoJXEJ8KjdPpPUnmdSxHAoKbRr8Q3IHk4kUzpbKLs5QOOfSeoGEFcuFNQt2FGfmTiwdvxBOyE4imGTV6nBLQyH2TPswKYrzTgofbcrVuirUPMBuYFKUSUssIh5rSwNvFMewTWVbVUSh5LSIxjpqSDlrrtP3ROs4kwSZrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGHrndnABuoOf+twlIYHtPuOtiFlwn7L3JswrQeJRYk=;
 b=NEm9I7mNM7gJqh8boeonWVmEYcsGmjUMf2mERCS+u4+1DAPjt5FBWJ/2DH2EWuOY5pDX4Tk6AnjDZSkcLYU7HeuK608NRC7pxjcOoFYwQATyp/Z0bLqvGpn8icAVl4U5HivNk2HDYq8BdFqYnuDPPlR2rYyW51wrX3E6T3C3CNzfJfaY3w5VTc9q5zrh84cIgqGmCCcetB5aO1Oz9g0Ee2inA0ZLOu1MG6vHVVfNG5g2sKzgOKGfDLYVjcT3ZnUnpN58BIfxDCMQanQHNhGoAjQ4916MkWFfLv2WWKmrKfxmut2r0xwxMGF/qbnnkI4iiKY0DgbRpRnpakO7Mez6PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 06:35:30 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 06:35:30 +0000
Message-ID: <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com>
Date: Sun, 24 May 2026 09:34:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com> <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com> <ag8cqIGtAfe80lKW@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ag8cqIGtAfe80lKW@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 53afbf29-bc56-4fd8-a1db-08deb95ea606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003|5023799004|3023799007|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: rXoHPpq/uz2w8MUcZgWl9H+tM2UnXEBbNx8J7BP41IBm9i3saoJYDf/NUgbxSgBICuYFV6bTD0WJ8qoqmUnw+Kvjs1YmydB8z25ddCjpL0J4r9RV0bEYTQdETW6dg88L4XDa2U8UjqzE0ZbkQMWEk4/fwMcZrkgqaTuCpQ1c2D3bvvYUhKcmxTkixyoPOyqJAqs9UGtNgonHk8QRVUfePNEXRFucUJ70oXrCNU8x3L/r2B1qOR8mIp1u4j3QDq4dJ2giBZ4MmCk/z6mdeQTvQvq4Tc2cQe2ZeRwgyn8VfsECUNa5GJC1i2wYzzkbyRv5zP1jphCm0AfKMTIjAlFT0f8ygWcKbLnLb39qlVdu6bwYsE8vBq/IlUa6MBwWxNogcrQ1f9Ae08k89+6Il/bPDhidRfHxyy0qPf+sPgXWmWex0T09UDm1rvhXckiNCTyU3aDMOhkI1sx0OSlXL7qHdj5zWY47mgbrH4WHrryCJVBnaXH32Pzidlqtk3sLRNSm/Uq2Nyt3AJkPyNRF+lgkQ//lMLNI3YkrGx08Ef8plYfxaHPS3nJIMvcXocKe1g94LY1q+Ac52fOyVe7bOC9RZoDij8lIkocV3MW91dKVEd4rl9unCVa6o091KwWxaNHA5uEX5VQj2AfwbfnCrBtSTtHSu+jpAV+B2eUW+ejBaNnQ1fmo2Zy18xra/c+Q8MDx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003)(5023799004)(3023799007)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVU3NHJBUDcvNDZsbXZ2MTRhcy9vdWlDMndsdzZ4UkZ5THRtcVVxTmJ2Tlh4?=
 =?utf-8?B?Y2g5Wi9VUDBCVXV6K3RWVzdCVUx6Rzh5TUpiRytXUjFUa1JhT1FEbXdaa0pJ?=
 =?utf-8?B?a1VObU1lTkFudVIwRUNZOGZseHJDdjRvNXdOUWVHQW1vRmVsb1pNM1Awdlcy?=
 =?utf-8?B?blNzeVFMZHd0dVg4bU9aaTR0M0tjZVhBWHhaTnZVdytmT081dytCcUd1VU9L?=
 =?utf-8?B?QStwK2xmMVloOG1XMjROTW9SbUNzdGtFUVlSY0dTMlV0dHpacmNaMVBTNlRz?=
 =?utf-8?B?RWRzbng1Ni9TTElSWWR4aWhLb1dRbFp4YitZZVpWT01zMEp3QWZ2aDUwWGpk?=
 =?utf-8?B?VDdQRHJiRVhHNnYzZmQ4eHNKTnlIUVRaSzBqNVVjQWoxaHUySnBnMGp5TEdC?=
 =?utf-8?B?S21iYzNRZFZ3NWVXOUJsT0lWMGNKd25vYitRdWdPSFBDWk5oTXFzQVQrSEdJ?=
 =?utf-8?B?R0J3cC8rUTdnV29MZWs0WFlKN09kV2lyMzM3SUxVNFFSWTBZMTBUeUdhaEty?=
 =?utf-8?B?TmR5dUdUOURpS1dqdmcrZk94U0dRQlowbE0rRTYvY0RJUmc1aUhnOUdsLzc1?=
 =?utf-8?B?N3BqU3dnODFsK2E4NXFLbG1zNHhZTnUzWWtxVjk0WG5IaEhJVkNSREM1V3ZI?=
 =?utf-8?B?R3RqeFpmRDMyV2ZwQm1iL2NiMTRkaWlqSFdSa21zV1NqbHlTa0loZEVjcEZI?=
 =?utf-8?B?WGk2TS8renhhbXlpbkhwU00veGIzVnF0UVUwUkxMU1hZTnllNTZZY0dEdHN2?=
 =?utf-8?B?WHdJWFdNNk1GbEhTV2taanNPUjRKZ2hYcEVJa3ZndWs5b2xDS0R0MlpJRHdj?=
 =?utf-8?B?dHFVK2ZCV0IrWWNaTVNuRzVTVFM5NlFnTEpjVHNXbDVzUFVpTkNMdW1vMmZ1?=
 =?utf-8?B?eUNNSjlEUU5RTGtwU3hsWGhPOEFNYjNJcVpqVGl4eWRSRFp5R2ZKa2hnSlpN?=
 =?utf-8?B?UDdLSkV5WDVoK1Fxd3hTR2hUQ1JPb3ozRU1EZEhwUGsxZXZjV0hKREM2NERF?=
 =?utf-8?B?dGgyUnN0VXVMamFrUVZoNmx5SFp3Wk9QWWdaN0FMWEQ2VjVIRmZLcW5EaGRI?=
 =?utf-8?B?MzZqdlFvRUxGQUNXZFRWSUFOM2pnN1ZMZTBUb3QwSDdxSHk2QTdIaW84ZExZ?=
 =?utf-8?B?L28vSS8wb1J1N2tyN21kYW5RUjRmNi8yWEpLTmlUQkEyUithNWZNYUZvcWgv?=
 =?utf-8?B?WE02YXc3bThoTlFlUG0wUVdPSHh0VmVwN2UrQkkzRWgwNUxKL0pBMWdqVGRD?=
 =?utf-8?B?TEYxVkFkMEtad1BYRG9uRTZFazI2ZDNDQW1JWWVVTmFzT1g2anRybll6Q3Qx?=
 =?utf-8?B?aGNhRk5FTHdFak5mcTZnRThkTVBiZWZ6UUNNeGpEK1B5VkZuTGt4NjFONFgv?=
 =?utf-8?B?c01hdUMxQ0I1cmVCcjIxT3NmY09UaDV4aUVzeGtNU2plSW5aK0orL3FyV04r?=
 =?utf-8?B?aERxakNGR3o0VllkNzQxUHVIeTBlU2VUSXRJRnR0cEVEaENoYzFRMFZFQkNu?=
 =?utf-8?B?TVI4eDB2VTRiL3N2eUcxU3JyT21nL0o4ekJyUGhPbWJJRGhWb2pLVnAveGVp?=
 =?utf-8?B?MWxJTFU5NkFnV3JyalZtRk1IQnpGNFlyem0wd0V4eGlDUG1aQk50ZWJIc1E0?=
 =?utf-8?B?aEcycThJZUVaU2JIWmFFdzlMK3hDS1RqTndoYVlPVVhSVFdRT2VNSDIwR1Rn?=
 =?utf-8?B?Z2Nwemc1YkZwdzd6d1YzckMxN2VwODlLWXJsNmhSNWR2ZUJLdFNqWkhwTzRO?=
 =?utf-8?B?V2FnRTRUL2xNNThJckptcVR5YUlOSHJiQ21PNUU3ZkF6VDFwVXgvOU1xbUYy?=
 =?utf-8?B?dkpUNE5CMFY2YWZVZmxtaExBMnFINHU1aVMxaDJ5dzM4aVJIVGtGQlNBK0hO?=
 =?utf-8?B?bG1SRmNyN2tCMGZWZEpsWGhOSjNaR2pYUG55VS9BWGc3MSt6ZEFpOStTVlRu?=
 =?utf-8?B?RTdib09RV1Z3ZGwyNUQ0aGFnaDBjcGo2L2thR09hS3RwZVpEUjFiOHFuWVhK?=
 =?utf-8?B?UkdOWTNuTy90ZjZaYURVK2pJR1kvYlpCZVpicUFKNG4wLzV3NUtrS1ExL24r?=
 =?utf-8?B?SWQzcVJXRkhISEZTbU9rcnowRWEvR0EwRHQrQnFkQzZTRE93ZzZ4QkxkRkNn?=
 =?utf-8?B?eG5zYWNmMW4xMm84Rm1DTXk1UXYvRFFpZEc3Sm1Pdm1weFJ0ZEViOTR6UXFR?=
 =?utf-8?B?MFk2Nnl0ekxpY2FLNW1BVkNabDZHcXpRMDd0S3UwU0xUb1ZDcFdubnk4a1Ns?=
 =?utf-8?B?Sk1OQVkyblEvY1cxWVJUOXlMTnFTN1Y3bFQydElQTFE3dDYya0RCcHhqQ1cr?=
 =?utf-8?B?RHE0MTk1QWRjTjlTTU9UblIyRGNCVE1PdHBaRDVHbEZEbXdjdkFMUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53afbf29-bc56-4fd8-a1db-08deb95ea606
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 06:35:29.9735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLBIdfaKYF5D7dF6nuNrS4IXzl3HLdhNPpCA2TRWVvz0reCE7gcMFFKkf9VF2b6xrCTYmeX7xbOlNaoy4bZT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771
Received-SPF: permerror client-ip=40.107.209.63;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/21/2026 5:54 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 21, 2026 at 04:39:11PM +0300, Avihai Horon wrote:
>> On 5/19/2026 10:48 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, May 05, 2026 at 11:14:16AM +0300, Avihai Horon wrote:
>>>> Switchover-ack is a mechanism to synchronize between source and
>>>> destination QEMU during migration to prevent the source from switching
>>>> over prematurely.
>>>>
>>>> VFIO uses switchover-ack to ensure switchover happens only after
>>>> destination side has loaded the precopy initial bytes. This is important
>>>> for VFIO, as otherwise downtime could be impacted and be higher.
>>>>
>>>> In its current state, switchover-ack is a one-time mechanism, meaning
>>>> that switchover is acked only once and past that another ACK cannot be
>>>> requested again. This was sufficient until now, as VFIO precopy initial
>>>> bytes was defined to be monotonically decreasing. Thus, when precopy
>>>> initial bytes reached zero for all VFIO devices, a single ACK would be
>>>> sent and its validity would hold.
>>>>
>>>> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
>>>> initial bytes to be re-initialized during precopy. Specifically, it
>>>> means that initial bytes can grow after reaching zero, which would
>>>> invalidate a previously sent switchover ACK.
>>>>
>>>> To solve this, make switchover-ack reusable and allow devices to request
>>>> another switchover ACK when needed.
>>>>
>>>> To avoid scattering them all over, switchover ACKs are requested through
>>>> a new request_switchover_ack handler which is called in specific places.
>>>>
>>>> Since now switchover ACK can be requested for a specific device and in
>>>> different times, make switchover ACK per-device (instead of a single ACK
>>>> for all devices) and let source side do the pending ACKs accounting.
>>>>
>>>> Keep the legacy switchover-ack mechanism for backward compatibility and
>>>> turn it on by a compatibility property for older machines. Enable the
>>>> property until VFIO implements the new switchover-ack.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    include/migration/client-options.h |  1 +
>>>>    include/migration/register.h       | 21 +++++++++
>>>>    migration/migration.h              | 15 +++++--
>>>>    migration/savevm.h                 |  4 +-
>>>>    hw/core/machine.c                  |  4 +-
>>>>    hw/vfio/migration.c                |  8 ++--
>>>>    migration/migration.c              | 38 +++++++++++++---
>>>>    migration/options.c                | 10 +++++
>>>>    migration/savevm.c                 | 69 +++++++++++++++++++++++++++++-
>>>>    migration/trace-events             |  4 +-
>>>>    10 files changed, 156 insertions(+), 18 deletions(-)
>>> We may need to also update qapi/migration.json for its behavior change.
>>>
>>> One option is to simplify that rather than mentioning too much details on
>>> legacy / modern behaviors: the QAPI documentatation can describe the
>>> general concept of this feature, leaving impl details to QEMU internals.
>>>
>>> IIUC, the generic concept of this feature is allowing destination QEMU to
>>> acknowledge a switchover decision that source makes, rather than fully
>>> relying on the source QEMU.  The doc can avoid mentioning how many ACKs it
>>> needs, and whether the ACK message is global, or per-device.
>> Sure, I will reword it.
>>
>>>> diff --git a/include/migration/client-options.h b/include/migration/client-options.h
>>>> index 289c9d7762..78b1daa1a6 100644
>>>> --- a/include/migration/client-options.h
>>>> +++ b/include/migration/client-options.h
>>>> @@ -13,6 +13,7 @@
>>>>
>>>>    /* properties */
>>>>    bool migrate_send_switchover_start(void);
>>>> +bool migrate_switchover_ack_legacy(void);
>>>>
>>>>    /* capabilities */
>>>>
>>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>>> index eae4c4ffca..f43f47a679 100644
>>>> --- a/include/migration/register.h
>>>> +++ b/include/migration/register.h
>>>> @@ -30,6 +30,11 @@ typedef struct MigPendingData {
>>>>        uint64_t total_bytes;
>>>>    } MigPendingData;
>>>>
>>>> +enum MigSwitchoverAckRequestStage {
>>>> +    MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP,
>>>> +    MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT,
>>>> +};
>>>> +
>>>>    /**
>>>>     * struct SaveVMHandlers: handler structure to finely control
>>>>     * migration of complex subsystems and devices, such as RAM, block and
>>>> @@ -299,6 +304,22 @@ typedef struct SaveVMHandlers {
>>>>         */
>>>>        int (*resume_prepare)(MigrationState *s, void *opaque);
>>>>
>>>> +    /**
>>>> +     * @request_switchover_ack
>>>> +     *
>>>> +     * Checks if a new switchover ACK is requested. Called only on source side
>>>> +     * in the stages specified in enum MigSwitchoverAckRequestStage.
>>>> +     *
>>>> +     * @stage: the stage in which the handler was called
>>>> +     * @opaque: data pointer passed to register_savevm_live()
>>>> +     * @requester: output pointer to be set to the name of the requester of the
>>>> +     * switchover ACK (for logging purposes). If not set, idstr will be used.
>>>> +     *
>>>> +     * Returns true to request switchover ACK and false otherwise
>>>> +     */
>>>> +    bool (*request_switchover_ack)(enum MigSwitchoverAckRequestStage stage,
>>>> +                                   void *opaque, const char **requester);
>>>> +
>>>>        /**
>>>>         * @switchover_start
>>>>         *
>>>> diff --git a/migration/migration.h b/migration/migration.h
>>>> index 6099bac512..d46ecd967f 100644
>>>> --- a/migration/migration.h
>>>> +++ b/migration/migration.h
>>>> @@ -494,6 +494,12 @@ struct MigrationState {
>>>>         */
>>>>        uint8_t clear_bitmap_shift;
>>>>
>>>> +    /*
>>>> +     * This decides whether to use legacy switchover ack (send ACK once for all
>>>> +     * devices) or new switchover ack (send ACK for each device).
>>>> +     */
>>>> +    bool switchover_ack_legacy;
>>>> +
>>>>        /*
>>>>         * This save hostname when out-going migration starts
>>>>         */
>>>> @@ -503,10 +509,13 @@ struct MigrationState {
>>>>        JSONWriter *vmdesc;
>>>>
>>>>        /*
>>>> -     * Indicates whether an ACK from the destination that it's OK to do
>>>> -     * switchover has been received.
>>>> +     * Indicates the number of pending ACKs from the destination. The value may
>>>> +     * increase or decrease during precopy as new ACKs are requested or
>>>> +     * received. When zero is reached, it's OK to switchover. In legacy
>>>> +     * switchover-ack, it's initialized to 1 and decreased to zero upon ACK.
>>>>         */
>>>> -    bool switchover_acked;
>>>> +    uint32_t switchover_ack_pending_num;
>>>> +
>>>>        /* Is this a rdma migration */
>>>>        bool rdma_migration;
>>>>
>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>> index fd0c4d3329..937acfa84c 100644
>>>> --- a/migration/savevm.h
>>>> +++ b/migration/savevm.h
>>>> @@ -37,6 +37,8 @@ bool qemu_savevm_state_blocked(Error **errp);
>>>>    void qemu_savevm_non_migratable_list(strList **reasons);
>>>>    int qemu_savevm_state_prepare(Error **errp);
>>>>    int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp);
>>>> +int qemu_savevm_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
>>>> +                                       Error **errp);
>>>>    bool qemu_savevm_state_guest_unplug_pending(void);
>>>>    int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>>    void qemu_savevm_send_header(QEMUFile *f);
>>>> @@ -70,7 +72,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>>>>    int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>>>>                               Error **errp);
>>>>    int qemu_load_device_state(QEMUFile *f, Error **errp);
>>>> -int qemu_loadvm_approve_switchover_legacy(const char *approver);
>>>> +int qemu_loadvm_approve_switchover(const char *approver);
>>>>    int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
>>>>    int qemu_savevm_state_non_iterable_early(QEMUFile *f,
>>>>                                             JSONWriter *vmdesc,
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 1b661fd36a..4f82813e8b 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -39,7 +39,9 @@
>>>>    #include "hw/acpi/generic_event_device.h"
>>>>    #include "qemu/audio.h"
>>>>
>>>> -GlobalProperty hw_compat_11_0[] = {};
>>>> +GlobalProperty hw_compat_11_0[] = {
>>>> +    { "migration", "switchover-ack-legacy", "on" },
>>>> +};
>>>>    const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>>>>
>>>>    GlobalProperty hw_compat_10_2[] = {
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 314095235d..2911583ee1 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -828,11 +828,11 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>>>                    return -EINVAL;
>>>>                }
>>>>
>>>> -            ret = qemu_loadvm_approve_switchover_legacy(vbasedev->name);
>>>> +            ret = qemu_loadvm_approve_switchover(vbasedev->name);
>>> This switches the just-renamed legacy function back.  Looks a bit weird.
>> I can drop renaming qemu_loadvm_approve_switchover() to legacy in previous
>> patch.
>> Or I can keep qemu_loadvm_approve_switchover_legacy() exported and have VFIO
>> check migrate_switchover_ack_legacy() and call the right function.
>>
>> Would one of the above be less awkward?
> In the final version, qemu_loadvm_approve_switchover() contains both the
> legacy and modern handling already:
>
> int qemu_loadvm_approve_switchover(const char *approver)
> {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>
>      if (!migrate_switchover_ack()) {
>          return 0;
>      }
>
>      if (migrate_switchover_ack_legacy()) {
>          return qemu_loadvm_approve_switchover_legacy(approver);
>      }
>
>      trace_loadvm_approve_switchover(approver);
>
>      return migrate_send_rp_switchover_ack(mis);
> }
>
> Then option 1 makes more sense to avoid renaming it to _legacy() since the
> start.

Ack.

>
>>>>                if (ret) {
>>>> -                error_report("%s: qemu_loadvm_approve_switchover_legacy "
>>>> -                             "failed, err=%d (%s)",
>>>> -                             vbasedev->name, ret, strerror(-ret));
>>>> +                error_report(
>>>> +                    "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
>>>> +                    vbasedev->name, ret, strerror(-ret));
>>>>                }
>>>>
>>>>                return ret;
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 3c4385b5f7..b86ceea6ff 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -1684,7 +1684,9 @@ int migrate_init(MigrationState *s, Error **errp)
>>>>        s->vm_old_state = -1;
>>>>        s->iteration_initial_bytes = 0;
>>>>        s->threshold_size = 0;
>>>> -    s->switchover_acked = false;
>>>> +    /* Legacy switchover-ack sends a single ACK for all devices */
>>>> +    qatomic_set(&s->switchover_ack_pending_num,
>>>> +                migrate_switchover_ack_legacy() ? 1 : 0);
>>>>        s->rdma_migration = false;
>>>>
>>>>        /*
>>>> @@ -2169,7 +2171,7 @@ void migration_request_switchover_ack_legacy(const char *requester)
>>>>    {
>>>>        MigrationIncomingState *mis = migration_incoming_get_current();
>>>>
>>>> -    if (!migrate_switchover_ack()) {
>>>> +    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
>>>>            return;
>>>>        }
>>>>
>>>> @@ -2425,9 +2427,18 @@ static void *source_return_path_thread(void *opaque)
>>>>                break;
>>>>
>>>>            case MIG_RP_MSG_SWITCHOVER_ACK:
>>>> -            ms->switchover_acked = true;
>>>> -            trace_source_return_path_thread_switchover_acked();
>>>> +        {
>>>> +            uint32_t pending_num;
>>>> +
>>>> +            pending_num = qatomic_dec_fetch(&ms->switchover_ack_pending_num);
>>>> +            trace_source_return_path_thread_switchover_acked(pending_num);
>>>> +            if (pending_num == UINT32_MAX) {
>>>> +                error_setg(&err, "Switchover ack pending num underflowed");
>>>> +                goto out;
>>>> +            }
>>>> +
>>>>                break;
>>>> +        }
>>>>
>>>>            default:
>>>>                break;
>>>> @@ -3221,7 +3232,7 @@ static bool migration_can_switchover(MigrationState *s)
>>>>            return true;
>>>>        }
>>>>
>>>> -    return s->switchover_acked;
>>>> +    return qatomic_read(&s->switchover_ack_pending_num) == 0;
>>>>    }
>>>>
>>>>    /* Migration thread iteration status */
>>>> @@ -3311,9 +3322,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>>>        Error *local_err = NULL;
>>>>        bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
>>>>                            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>>> -    bool can_switchover = migration_can_switchover(s);
>>>> +    bool can_switchover;
>>>>        MigPendingData pending = { };
>>>>        bool complete_ready;
>>>> +    int ret;
>>>>
>>>>        /* Fast path - get the estimated amount of pending data */
>>>>        qemu_savevm_query_pending(&pending, false);
>>>> @@ -3346,8 +3358,18 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>>>             */
>>>>            if (migration_iteration_next_ready(s, &pending)) {
>>>>                migration_iteration_go_next(&pending);
>>>> +            ret = qemu_savevm_request_switchover_ack(
>>>> +                MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT, &local_err);
>>> I agree this is a good spot to report when a new ack will be needed, but
>>> this PENDING_EXACT stage is confusing to me.  Actually, I think it's the
>>> whole concept of this extra "stage" is not easy to understand, and I don't
>>> yet understand why it is needed.
>>>
>>> To me, the module should be able to raise a switch-ack request anytime, and
>>> it doesn't need to have a "stage" passed in.
>>>
>>> The only difference here, IIUC, is for COMPLETE stage the current version
>>> modified qemu_savevm_request_switchover_ack() to fail explicitly.
>>>
>>> It's fine, but we can also move that logic out, say, we can make sure all
>>> modules reported the last time of "whether a new switchover ack needed"
>>> after stopping VM, then read once more switchover_ack_pending_num making
>>> sure it's zero before switching over.  IIUC that removes the last piece of
>>> dependency of this whole "stage" concept.
>>>
>>> IOW, I wonder if we can provide such reporting facility of "we need a
>>> switch-ack" in the save_query_pending() API. For example, we can extend
>>> existing MigPendingData:
>>>
>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>> index 755e590676..4fe495f3af 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -23,6 +23,8 @@ typedef struct MigPendingData {
>>>        uint64_t postcopy_bytes;
>>>        /* Amount of pending bytes can be transferred only in stopcopy */
>>>        uint64_t stopcopy_bytes;
>>> +    /* Report if a new switchover-ack will be needed */
>>> +    uint64_t switchover_ack_pending;
>>>        /*
>>>         * Total pending data, modules do not need to update this field, it
>>>         * will be automatically calculated by migration core API.
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 9150cb93ad..dbe0ed6edd 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1879,6 +1879,18 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>>         */
>>>        mig_stats.dirty_bytes_total = pending->total_bytes;
>>>
>>> +
>>> +    if (pending->switchover_ack_pending) {
>>> +        qatomic_add(&s->switchover_ack_pending_num,
>>> +                    pending->switchover_ack_pending);
>>> +        /*
>>> +         * NOTE: If we rely on migration core to request that on dest, we
>>> +         * need a new type of message sent to dest QEMU to request for
>>> +         * that.  Otherwise we can also rely on per-module protocol to
>>> +         * request it.
>>> +         */
>>> +    }
>>> +
>>>
>>> With that, module can report anytime, where query's @exact can be either
>>> true / false, it doesn't matter.  The one reported in SETUP can be done in
>>> the first query which is guaranteed to happen before switchover.
>> So basically your approach reduced the stages into a single one - during
>> query pending (either exact or estimate) - which allows us to drop the stage
>> param.
>>
>> I agree SETUP can be dropped now that switchover-ack can be requested also
>> in query pending estimate.
>> But how can modules request another switchover-ack past the last query
>> pending (after which we switchover)?
>>
>> IIUC, we would need to issue another query pending after VM stop, but VFIO
>> will fail a query pending exact at that stage (when VM stopped), so we can
>> only issue query estimate pending.
>>
>> This seems a bit weird, so I guess we can add another flavor for query
>> pending which only queries switchover-ack? Or completely split it from query
>> pending into a separate migrate_request_switchover_ack() function?
> It shouldn't be awkward, and IMHO it'll further cleanup the code base,
> further removing some legacy RAM hacks.
>
> In reality / theory, we must do a sync / slow query after VM stopped,
> because that's the only way to collect the ultimate last set of dirty info
> for the whole system, and we must not miss anything or dest QEMU will
> crash.
>
> For RAM (which was the only one that cares before), that was done currently
> in a, IMHO, "hacky" way:
>
> ram_save_complete():
>          if (!migration_in_postcopy()) {
>              migration_bitmap_sync_precopy(true);
>          }
>
> That should really not hide in a complete() callback.  It should be a
> pretty generic concept for all modules.  And now with the
> save_query_pending() API introduced, that slow sync is that generic
> approach.

Ah, right, I totally forgot that RAM does a last query in complete 
phase, I was probably too focused on VFIO which doesn't need such query.

In that case, I agree with you, this should be cleaner.

>
> As a first step, I think we need to move this sync out of RAM's complete(),
> similarly to what I have done in the dependency patch to move some
> ram-specific changes out to generic migration code.
>
> After moving out, it will become a sync query and VFIO should also properly
> handle it.
>
> I'm not sure why currently VFIO mustn't do such a sync query after VM
> stopped, but if there's some nuance that caused it, VFIO will need to
> handle it in its save_query_pending(sync=on) and makes sure:
>
> (1) VFIO won't crash on a sync query during switchover phase, aka, VM
> stopped,
>
> (2) VFIO needs to guarantee sync all through the stack so that all dirty
> data is collected properly (I bet this was always the case, so no real
> concern here..)
>
> Then, it means we'll do a sync query after VM stop, and VFIO (while
> synchronizing dirty info) will report the last switchover-ack request too
> altogether in the same query, as part of "pending data".
>
> Then with that, when switchover_ack_pending_num!=0, we either:
>
> - Fail the migration, as this patchset does for now, or,
>
> - Goes back to iteration phase, which can be TBD in the future, since
>    REINIT shouldn't be common anyway
>
> Do you think such would work out clean?

Yes I think so.

We just need to indicate modules that it’s the last query during 
switchover so they can handle it properly.
Do you think it would be reasonable to add a "bool final" param to 
save_query_pending handler?

For RAM it will be used to indicate we are running under the BQL (since 
currently save_query_pending runs only outside BQL) and to pass the 
proper last_stage param into migration_bitmap_sync_precopy().
For VFIO it will indicate we should not do a query precopy info ioctl 
(which is only valid in VFIO precopy states, not while VM is stopped).

>
>>> So I also left a "NOTE" above, currently IIUC VFIO is responsible for
>>> telling dest QEMU that it needs to emit one more switchover-ack (likely by
>>> VFIO_MIG_FLAG_DEV_INIT_DATA_SENT, which is vfio specific protocol), another
>>> way to do this is requesting that from migration core, then we can send a
>>> new REQUEST_SWITCHOVER_ACK message to dest, routing it to the device.
>>>
>>> Logically relying on migration core should be better: consider in the
>>> future all these things can be reusable by e.g. vDPA or other similar
>>> cases.  But so far I don't have a strong feeling.
>> Note that for VFIO, requesting switchover-ack from source (incrementing
>> switchover_ack_pending_num) and requesting an ack from destination happen in
>> different times - the former happens once we see new init_bytes > 0, and the
>> latter happens when init_bytes = 0 again.
>>
>> I need to think this through, but did you have something specific in mind?
> Not really something useful, but I can share my thoughts.
>
> Currently, VFIO does it in a way that it first push all data, then put a
> tag of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT at the end if all data pushed
> flushed all INIT/REINIT data.
>
> That'll work out, because "ACK" essentially can be emitted on dest as long
> as dest QEMU completely received and applied the prior vfio_save_block()
> dump.  There's nothing special dest needs to do.  IOW, dest is not making
> much decision, but blindly ACK after seeing VFIO_MIG_FLAG_DEV_INIT_DATA_SENT.
> Such sequence will make everything flow.
>
> What I had in mind was allowing src QEMU to send a "Request ACK for device
> XXX instance_id YYY", then dest migration core routes it to the
> corresponding module.  The module then will decide itself on when to ACK.
>
> Now think about it, maybe it's an overkill.  It's more flexible, it can be
> reused by vDPA and others, but it's more than what we need right now.
>
> Also, since VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is already the wire protocol,
> let's stick with it to not introduce confusions.

I see.
Yes, we can keep VFIO_MIG_FLAG_DEV_INIT_DATA_SENT for now and if a new 
module wants to use switchover-ack in the future, we can think of a 
general solution then.

Thanks.

>>>> +            if (ret < 0) {
>>>> +                migrate_error_propagate(s, local_err);
>>>> +                qemu_file_set_error(s->to_dst_file, ret);
>>>> +                return MIG_ITERATE_RESUME;
>>>> +            }
>>>>            }
>>>>
>>>> +        /* Check can switchover after qemu_savevm_request_switchover_ack() */
>>>> +        can_switchover = migration_can_switchover(s);
>>>> +
>>>>            /* Should we switch to postcopy now? */
>>>>            if (can_switchover && postcopy_should_start(s, &pending)) {
>>>>                if (postcopy_start(s, &local_err)) {
>>>> @@ -3638,6 +3660,10 @@ static void *migration_thread(void *opaque)
>>>>        bql_lock();
>>>>        ret = qemu_savevm_state_do_setup(s->to_dst_file, &local_err);
>>>>        bql_unlock();
>>>> +    if (!ret) {
>>>> +        ret = qemu_savevm_request_switchover_ack(
>>>> +            MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP, &local_err);
>>>> +    }
>>> Let's always avoid doing things like this with "if (!ret)"?  We can put it
>>> after the whole unplug event and after the ret check, fail immediately if
>>> ret != 0.
>> Sure.
>>
>> Thanks!
>>
>>>>        qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>                                   MIGRATION_STATUS_ACTIVE);
>>>> diff --git a/migration/options.c b/migration/options.c
>>>> index 7556fbc06b..44327c588f 100644
>>>> --- a/migration/options.c
>>>> +++ b/migration/options.c
>>>> @@ -108,6 +108,9 @@ const Property migration_properties[] = {
>>>>                         preempt_pre_7_2, false),
>>>>        DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
>>>>                         multifd_clean_tls_termination, true),
>>>> +    /* Use legacy until VFIO implements new switchover-ack */
>>>> +    DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
>>>> +                     switchover_ack_legacy, true),
>>>>
>>>>        /* Migration parameters */
>>>>        DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
>>>> @@ -462,6 +465,13 @@ bool migrate_rdma(void)
>>>>        return s->rdma_migration;
>>>>    }
>>>>
>>>> +bool migrate_switchover_ack_legacy(void)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +
>>>> +    return s->switchover_ack_legacy;
>>>> +}
>>>> +
>>>>    typedef enum WriteTrackingSupport {
>>>>        WT_SUPPORT_UNKNOWN = 0,
>>>>        WT_SUPPORT_ABSENT,
>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>> index 687d6761cc..b6076579de 100644
>>>> --- a/migration/savevm.c
>>>> +++ b/migration/savevm.c
>>>> @@ -1472,6 +1472,54 @@ int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp)
>>>>        return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
>>>>    }
>>>>
>>>> +static const char *
>>>> +switchover_ack_stage_to_str(enum MigSwitchoverAckRequestStage stage)
>>>> +{
>>>> +    switch (stage) {
>>>> +    case MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP:
>>>> +        return "SETUP";
>>>> +    case MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT:
>>>> +        return "PENDING_EXACT";
>>>> +    default:
>>>> +        return "UNKNOWN";
>>>> +    }
>>>> +}
>>>> +
>>>> +int qemu_savevm_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
>>>> +                                       Error **errp)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +    uint32_t pending_num;
>>>> +    SaveStateEntry *se;
>>>> +    const char *requester;
>>>> +
>>>> +    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>>> +        if (!se->ops || !se->ops->request_switchover_ack) {
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        requester = NULL;
>>>> +        if (se->ops->request_switchover_ack(stage, se->opaque, &requester)) {
>>>> +            requester = requester ?: se->idstr;
>>>> +            pending_num = qatomic_inc_fetch(&s->switchover_ack_pending_num);
>>>> +            if (pending_num == 0) {
>>>> +                error_setg(errp, "Switchover ack pending num overflowed by %s",
>>>> +                           requester);
>>>> +                return -EOVERFLOW;
>>>> +            }
>>>> +
>>>> +            trace_savevm_request_switchover_ack(
>>>> +                switchover_ack_stage_to_str(stage), requester, pending_num);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    int qemu_savevm_state_resume_prepare(MigrationState *s)
>>>>    {
>>>>        SaveStateEntry *se;
>>>> @@ -2471,7 +2519,7 @@ static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
>>>>    {
>>>>        int ret;
>>>>
>>>> -    if (!migrate_switchover_ack()) {
>>>> +    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
>>>>            return 0;
>>>>        }
>>>>
>>>> @@ -3153,7 +3201,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
>>>>        return 0;
>>>>    }
>>>>
>>>> -int qemu_loadvm_approve_switchover_legacy(const char *approver)
>>>> +static int qemu_loadvm_approve_switchover_legacy(const char *approver)
>>>>    {
>>>>        MigrationIncomingState *mis = migration_incoming_get_current();
>>>>
>>>> @@ -3172,6 +3220,23 @@ int qemu_loadvm_approve_switchover_legacy(const char *approver)
>>>>        return migrate_send_rp_switchover_ack(mis);
>>>>    }
>>>>
>>>> +int qemu_loadvm_approve_switchover(const char *approver)
>>>> +{
>>>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>>>> +
>>>> +    if (!migrate_switchover_ack()) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    if (migrate_switchover_ack_legacy()) {
>>>> +        return qemu_loadvm_approve_switchover_legacy(approver);
>>>> +    }
>>>> +
>>>> +    trace_loadvm_approve_switchover(approver);
>>>> +
>>>> +    return migrate_send_rp_switchover_ack(mis);
>>>> +}
>>>> +
>>>>    bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
>>>>                                       char *buf, size_t len, Error **errp)
>>>>    {
>>>> diff --git a/migration/trace-events b/migration/trace-events
>>>> index d6795c64c7..be3e688c71 100644
>>>> --- a/migration/trace-events
>>>> +++ b/migration/trace-events
>>>> @@ -24,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s:
>>>>    loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>>>>    loadvm_process_command_ping(uint32_t val) "0x%x"
>>>>    loadvm_approve_switchover_legacy(const char *approver, unsigned int switchover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_legacy %u"
>>>> +loadvm_approve_switchover(const char *approver) "Approver %s"
>>>>    postcopy_ram_listen_thread_exit(void) ""
>>>>    postcopy_ram_listen_thread_start(void) ""
>>>>    qemu_savevm_send_postcopy_advise(void) ""
>>>> @@ -40,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
>>>>    savevm_send_recv_bitmap(char *name) "%s"
>>>>    savevm_send_switchover_start(void) ""
>>>>    savevm_state_setup(void) ""
>>>> +savevm_request_switchover_ack(const char *stage, const char *requester, uint32_t pending_num) "Stage %s, requester %s, switchover_ack_pending_num %" PRIu32
>>>>    savevm_state_resume_prepare(void) ""
>>>>    savevm_state_header(void) ""
>>>>    savevm_state_iterate(void) ""
>>>> @@ -189,7 +191,7 @@ source_return_path_thread_loop_top(void) ""
>>>>    source_return_path_thread_pong(uint32_t val) "0x%x"
>>>>    source_return_path_thread_shut(uint32_t val) "0x%x"
>>>>    source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>>>> -source_return_path_thread_switchover_acked(void) ""
>>>> +source_return_path_thread_switchover_acked(uint32_t pending_num) "switchover_ack_pending_num %" PRIu32
>>>>    source_return_path_thread_postcopy_package_loaded(void) ""
>>>>    migration_thread_low_pending(uint64_t pending) "%" PRIu64
>>>>    migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
>>>> --
>>>> 2.40.1
>>>>
>>> --
>>> Peter Xu
>>>
> --
> Peter Xu
>


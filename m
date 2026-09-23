Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3397C98307
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KwW-00076b-Ae; Wed, 23 Sep 2026 07:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9KwC-00075J-5V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:14:59 -0400
Received: from mail-northeuropeazon11020083.outbound.protection.outlook.com
 ([52.101.84.83] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Kw8-00074B-37
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbZ7yh+hkVMeFRAU8HFlFhSxX+QIgSX7zAFvqA1yxghKvo5Dqy/wjwb5URmVsnzoWoiSQyJhfX161SrShn1/kMXb9DYcdubdJOXKWNXiCUKhdd7VFQUBYgiRrANdHuEBG6ONPMroaBckIT0pIALcyslu5B9qOfWwZiuDI9JU1zh/HSUwtYq2h0+CUcqAzaaWz0OFIcAK3x9FZdxkxJ4tf1Ry8A1QrpTKPFiu7bOXNlwOQKwY4dCntZoB8tQkV3Js+p01abuHa8Nf68Vuq3K8dULkU6k4Ah6vSCcrfijwqZ60XtsmgXB4yODyU/MHjtvinw+EjWzpNPJT4yE8F4XMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ndH/18FzUHrzhOPEk4A9R2DdeYlpbENFEYqGtavUMM=;
 b=hSRJbJUWU94aqnXKmFuzDxSlpPMLYlMjtIeTf4bM9b3Gb/OTz5eGyMjBZUCQcSjp1HN6WilKukBuUUwC+P7ttUbzpYtPSq/tvadB+S1q5p+moWZjsbM20D+BduOAPJo5mf/fcXPpelIPXHN9LSQ8wd27Vi8pv1eESShU4HulDzqvvRjjcHmQPS/jFQGPTasvh0FTiHR6Ezw9zXI1nKmqAa0LJfwdnFQjlBfnp2cTzMTQcF93mY9cwLsA1zPW7lW8ZkIcdGXEjPVogfqn5Z5BSlILuH1qp3LfKLTl4rNlW6/6/+jGCj5ZLlv1BsLZ2OqU/WiF5YdpDzjHxI7A3YAmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ndH/18FzUHrzhOPEk4A9R2DdeYlpbENFEYqGtavUMM=;
 b=PgGvBDrMdMNKVXrU7coH+ZRUWGSYzc+fVRCo8zWnwoILVOjRvtDbGp6QgQdeE6j/uNGAz/yWGHXa30teEGgJI6GKcCCjSuFTDIRxxR9Uh7xI7uMyV/GuZ63yybq77NoQS4sDxz+s4kw+vGPhsT43jo6oLLxdgfNnJEWHDWF/8uMhY2eg+rbKL7W5iyENBilSiOYK/JEhTVBrO80rPST4sdOasJNhvx0TEia1INKnZxcBUVzTicGvP8HaEJDKuO5kQ5loCesgYCMfAugqx0x53dH62A7PFGmIHXlseKGxXhMLNDjoRNb+O4uGOJAk5Xr9Ssc7O6qjqbEhmBX6hXkb1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9810.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.5; Wed, 23 Sep
 2026 11:09:42 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:09:41 +0000
Message-ID: <a23f83f6-fa39-47e9-9537-5f9cbaa476b0@virtuozzo.com>
Date: Wed, 23 Sep 2026 14:09:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/16] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-14-6ef9ef033c35@virtuozzo.com>
 <arJGNRq8UC-XSEpW@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arJGNRq8UC-XSEpW@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: af805e79-b705-4472-d16f-08df19632a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: xchdSiIVA8v0bQUfmbymZBiGalZWl72lMhPQrZLCIqhCw9M19y9ItLStqJFZWX56QmZyo67w/N2pI2DoXKrie8aVRhdCFt3BL0J6zUL9G5X2Y7M5Hd9e8CQXgwMcEFgUQ6nbEEE+0yo7pmQl7WAUfIaVFgAjaSZ7BmQ0ZlllKmz4KDDw4otKNuDedwCzLR5+8y7uf4zj6eVKeuQc+zrIgFEXoYJ7T82yiAxF7ECZOtcpGlx2aUR/b4UdIZgMvF1A2wJtyecttSv6Qg9os/6q+ySjgWC55dCAtZePrilNhlZu2xoYxbY545zef7vkHeJnSPzlcfuepMlwoiqUXENF/gCk1LCgSvPUZLLYgj5Ur832+Na7u+fp9yhyOXN3Gpm+Rg+HS9f3Fwv0OimOvCKrOfD3v6xeZk1ZZ7t/K+oyQrDJsoBVYhQV8E9i+sNKLUAh3cA+e5PlftiJVhbzO6s+oZQywcS61IJpTZER13WrXbdtjovlLVAyORTq+6GTXqIn9xYgaOD51+Zpsl5MLQ5ZyH3tMD+asaqqFdTwWNFdf5mfAC5ZmfCLgfQ3R40SSY9b9L/097LTnfCzNVlHkIdNCo5TGZoqghghHbdCtIb464EWYAE84jBZ9+oM+6Dw8cgeycUo18qy+eMxOpv3TXakUBO3iFbCcsnp3J1H4/q/CcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGtGK0dJNmNVQTBSelE1cGtSVjhWc1Z1NGVFL3NKQ2NZK3N4blpuamVqQ2ZW?=
 =?utf-8?B?eG5iU1J4YkI4MVd6eDlzSWlpMEpCMXZhc0J6R2ExbWcvQnJ1Q0tlQkRmOXVz?=
 =?utf-8?B?UkFxWXMwbVM4OVN2NG1KOHY3ZVdiUk9MRlVTMmMyeGgzSlVLY0NPM3NLaHJa?=
 =?utf-8?B?K2I0clFWeUl6NFhHdGlJMzZJQmpRRzlOazZWeFIxakFLMnZ3TFZ3MUxuNTNt?=
 =?utf-8?B?K0ZmRUlmWkVNbFE2TlZjZGxHZHRlcHg4S1dBdlFqS1VvNVpmd3cvcGJzaDdU?=
 =?utf-8?B?MkhKaXlwUGs4L2JTSjB5d1RTZnhDQVBlMW8vVWRYMDUvUU5IZjFrbVYzclJq?=
 =?utf-8?B?VUo2cVVsenU3WkNKQUZ0RENvZmlTRW9mMVFPeFZaZ0RoZlFJN01Mdllpb3NK?=
 =?utf-8?B?c0VlVXpDTDl3MUh3Z21RTEhjYnRkRS9vdEovK1NuT1dncml3YVg5N25SSVpU?=
 =?utf-8?B?ZVdOeFlFNXNtcVRHRzE2MXFNRDg5YzVMZ0xGenlZMU1pNng3cjJlM2VWOWVU?=
 =?utf-8?B?MDd1WC9SaDUxM3FUeHpJUjVKU0xseEVvSDJ4Y2kvU3NuWEpiQ0FtK241SzU4?=
 =?utf-8?B?WGlQY3FmRUNHSk1KN0xzWGZpLzlnRC9vUEdGVjhVaXc3QWNDTDBYU3ZwM0NE?=
 =?utf-8?B?cFByajBuVk5zaDNCYTJFVU9HSHQzSGNteEYvRkIwYW1BRVA5WmM2Y05GbGF4?=
 =?utf-8?B?SXV4Ky91SWhZMThvdGFIRVRsNkd1bkdvbFcycHcvZ1ZBaUpOOVJpbkxKeTVJ?=
 =?utf-8?B?RHgzTVM2QlM1RHJkci9rRlRIaE5tTitEU2xtVTlFL2RqcWdTelhKTmp0NGtX?=
 =?utf-8?B?Skdrc3FCSUFRb3ZrSFZ6d05DbGxWL2NJRGJTaHJUdGhFSVluQitGUlhHM04v?=
 =?utf-8?B?KyswS01NbkpTbzA0MEhaMTBSaEdMaUNUUGhUbExtOEcxRGxKUDJtSE54Qkdq?=
 =?utf-8?B?dmF4aFZmYzZZTk9qeVVWR1ZFZkZnUlQ5VjZSeW53WjJVb3FFRmZsdWJ3L1Zv?=
 =?utf-8?B?b3ZIbTNIdFp1WE9DZU5ndWRBMW8vNFFUVTNwc3VWMy9lN2s2azFpN3hESWt5?=
 =?utf-8?B?S3Z1ZGhGMm9oVHM2ZnVFRENPV3FlQlNmOTZ2UFNPcjVYOEFzZk9EWnE1bFl2?=
 =?utf-8?B?Z2xBUWE4Vlp2WksxUzdUOFNpclk2ZmQwditGeVFHbVpEM3RDR1JPMWE3a2lK?=
 =?utf-8?B?cHh3WmV2SVJsSnJQbU5jeXJpTjdxaWVWYmVKU28reld3YXoxNWhxbnA4enBH?=
 =?utf-8?B?WXl1b01HUmNJT3llWVIxVDhEWW93RjR0a28yY002VnVXUnljVE5JZHo1bEZ6?=
 =?utf-8?B?R2V3OUt5OS9nRll1eTRhRVJORHQ5WmJoeE1JUkp3S00rQnM4YWU4WlZaQmw1?=
 =?utf-8?B?NzloZ2h2a2ZnMGNhNnVWd1NCbDhDQ0p0WVlQNUdVVVZUZTY5UHYyemc4azJo?=
 =?utf-8?B?b2hLdjcwN3I4aVpORmZtZC9MV1ppSlRMWTRPUlY5ck1OT1YzRzBOTVlsVXdl?=
 =?utf-8?B?eFR5ZzFkQTdTMjhyTGVYQTBzdE9QTEdpci9nTVhIRGErS2FudVZESzh0S0FG?=
 =?utf-8?B?QXFycktxOWlMU01NUlBUVHRhQXpCUlgzUy9nbER4SWlnbWhTREpxYTdTMVdP?=
 =?utf-8?B?dHROWWQ2NDNHVjE2YTNqWmRzT2JJUnRwajlZZWwyMnNyelN1U241a0FZd0pw?=
 =?utf-8?B?MjArN2l6NGxzNzhMTHNxNWNRMHloNkQ1bXRUNUtXcDFrWER1Y3AvcTdZWmFC?=
 =?utf-8?B?SGErd0xPcGVaZmx3QmpIdkZwRTc5cFNNUU5NcllJZE53MmhYL3o2b1VLTTVK?=
 =?utf-8?B?MkZGNFNPS2xWSXZTNWY4NlJJRnQxSHkzOHhrT0tQcklKVDErbXM0RHF5ZFRY?=
 =?utf-8?B?bVZWUTlLV2hHMktZUW5haHVCeFdZLzdJSC9ZWDBhMkU1UUF6UlNLZElyZ2Ny?=
 =?utf-8?B?WERibTg0UU1JSlhvb0o3VmgyMUkycnZTSzBQWXFmVDdMU0tXNmFKYzI0bHcr?=
 =?utf-8?B?aVNsRjVPOWszOVVHcUlFVlRUcUxkVm1PWVJyS2x0c2xGOHcyVFhYNERiWDNN?=
 =?utf-8?B?VkxGelR3YVpiNEI5YkVNZVFyWUN5Y3hHZnRSVml6UFZBTEphVGpDMUllbjJn?=
 =?utf-8?B?dE9hRERuWCtJR3hFR01VdE43WkxYRzZmYVhnc1JFUFUreXBzcmc5TDRlU21Z?=
 =?utf-8?B?UjFFQkoyVlBWVzRQc0drLzJuWDd4bGxidDQ5bDBhdjJrSkFGL2JBY1gwTVc5?=
 =?utf-8?B?bnJKWEpyNkM1NW9SbFQwN3d4QzA3YTJTM3NvaUFBbDJyK2dhNWlrcUw5R0c3?=
 =?utf-8?B?QS9GYXRPTGZuT3RQN2dXOFk4aEZhdzkzMnFXbERxN1JpZWlCbHh4cW9GM3VR?=
 =?utf-8?Q?TRdz2wUhpPIHb5VM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af805e79-b705-4472-d16f-08df19632a8a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:09:41.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffo+iqTariJG9IzXZz4oJSJ0y2rssGUhxuppfFBm2ZoQbuGMmeUz5Ht7WXDexv88YKnBXGHSuIh0TiOX53E0X8cFJZZVCxcSFdY4g0UDnJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9810
Received-SPF: pass client-ip=52.101.84.83;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/26 12:26 PM, Stefano Garzarella wrote:
> On Fri, Sep 18, 2026 at 04:47:05PM +0300, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>
>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>    cpr-exec).
>>
>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>    queries the backend features by calling vhost_dev_init_backend().
>>    It doesn't take device ownership and doesn't touch the VQs which
>>    still-running source might use.  The full init is deferred to
>>    .post_load().
>>
>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>    the device is started at vm_start.
>>
>>  - .set_status() refuses to start a device whose init hasn't completed
>>    yet (incoming CPR before post_load).
>>
>>  - .set_status() re-acquires ownership before starting the device if
>>    pre_save released it and this QEMU is about to run the guest again:
>>    the migration failed, or it completed and the management resumed the
>>    source (e.g. cpr-transfer target died).
>>
>> With the handoff in place, lift the CPR blocker.
>>
>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
>> include/hw/virtio/vhost-vsock.h |   2 +-
>> 2 files changed, 128 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 6e89007b2ce..65ba573da4d 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -21,7 +21,6 @@
>> #include "hw/virtio/vhost-vsock.h"
>> #include "monitor/monitor.h"
>> #include "migration/cpr.h"
>> -#include "migration/blocker.h"
>> #include "migration/misc.h"
>>
>> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>> @@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>> {
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>     bool should_start = virtio_device_should_start(vdev, status);
>>     int ret;
>>
>> +    /*
>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>> +     * post_load.  Refuse to start a half-initialised device rather than
>> +     * issue vhost ioctls on it.
>> +     */
>> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
>> +    }
>> +
>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>         return 0;
>>     }
>>
>>     if (should_start) {
>> +        /*
>> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
>> +         * source, after a successful RESET_OWNER op.  If we end up here
>> +         * with this flag set - that means that either CPR migration failed,
>> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>> +         * target died).  In either case, we need to re-acquire device
>> +         * ownership.
>> +         *
>> +         * On failure leave the device stopped.  The next start attempt
>> +         * (guest driver reset, VM stop/cont) retries.
>> +         */
>> +        if (vsock->owner_reset) {
>> +            ret = vhost_dev_set_owner(&vvc->vhost_dev);
>> +            if (ret < 0) {
>> +                error_report("vhost-vsock: cannot re-acquire device "
>> +                             "ownership: %s", strerror(-ret));
>> +                return 0;
>> +            }
>> +            vsock->owner_reset = false;
>> +        }
>> +
>>         ret = vhost_vsock_common_start(vdev);
>>         if (ret < 0) {
>>             return 0;
>> @@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>> }
>>
>> +static int vhost_vsock_pre_save(void *opaque)
>> +{
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>> +    int ret;
>> +
>> +    ret = vhost_vsock_common_pre_save(opaque);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Release the device ownership now for CPR migration.  The device is
>> +     * already stopped at pre_save, and destination reclaims it by calling
>> +     * VHOST_SET_OWNER in post_load.
>> +     */
>> +    if (cpr_incoming_needed(NULL) && migration_is_running() &&
>> +        !vsock->owner_reset) {
>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>> +                         strerror(-ret));
>> +            return ret;
>> +        }
>> +        vsock->owner_reset = true;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> static int vhost_vsock_post_load(void *opaque, int version_id)
>> {
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
>> +    Error *local_err = NULL;
>> +    int vhostfd, ret;
>> +
>>     /*
>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>      * guest cid is unchanged, and the cid-change reset would otherwise
>> @@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>         return vhost_vsock_common_post_load(opaque, version_id);
>>     }
>>
>> +    /*
>> +     * CPR restore case.  The source released device ownership in its
>> +     * pre_save.  Complete the handoff here, before the device is started
>> +     * at vm_start.  Init vhost device on preserved FD, issue
>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>> +     */
>> +    vhostfd = cpr_find_fd(cpr_name, 0);
>> +    if (vhostfd < 0) {
>> +        error_report("vhost-vsock: could not find restored vhost FD");
>> +        return -1;
>> +    }
>> +
>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        cpr_delete_fd(cpr_name, 0);
>> +        return ret;
>> +    }
>> +
>> +    ret = vhost_vsock_set_guest_cid(vdev);
> 
> Why we need to set the CID? Isn't it preserved?
> 
> That said, I don't think it is wrong, it seems just superfluous, but 
> maybe there is a reason.
> 
> The rest LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

You're right that the CID itself is preserved across CPR, the kernel
keeps it hashed.  But the ownership of the device is NOT preserved.  The
ownership must be claimed by the new QEMU.  After we issue RESET_OWNER
in .pre_save() (old QEMU), it must be followed by SET_OWNER in
.post_load() (new QEMU).  So setting the same CID value in this call is
indeed redundant, but that's not the main goal here.

Thanks,
Andrey


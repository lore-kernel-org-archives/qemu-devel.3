Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E32AC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 03:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woCOI-00066p-JX; Sun, 26 Jul 2026 23:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woCOG-00066X-EZ; Sun, 26 Jul 2026 23:52:32 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woCOE-0000ZV-QE; Sun, 26 Jul 2026 23:52:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCwMcMFZ08jKTe3gUQv0GwJzKs98QaTaZNPGJAthSQcq6mA3q0kZl90SL/jNHp8C3RBjl0uioLNCe7TtzBDzREFTf/Obg0GPKOo4ic20O9gJQ1w8oBHXCq+Emv6SyOteEzKtcGGLCsdoD7o5L8t0lNqse9o0dtqwQtfw2SZadSv8BpeoBfiRQkxn82i2EkU6GmvyD7pGBfPMSejuCQdfY9Uf6bX1pRmrvCoMHYbeW4uf7vK38secwI6jpGNYGIy91pgXvc3Zje5TRfJNNi9pd+ZBQakOBafCgE/mEncqlH3RHEL8ynmH/Y7P0NiTfJIZx6M17nUTWY4VRjTe5w9vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59rn4/HxPViq0PRiUWvMljxTcj3/l2hLx2emwgN2HyE=;
 b=xX6d7mp2L+7YWfd2K8FGNtz+qVSt+WeQX6546QJ2vZHIu3WbaNzr8PSKGN3GfWKoq6Z5oWDauyj3f2S39Kta8jNvUW1X1CgKyPShnv4Hvo5TQmlz+JI6U/G9sZ5huBhxlF3CQ4cIOwh8X8kVWdib9Rl3OUIUzLJpg9zEgpL8h8Cvtgewfq2UGL6y/jE70Y5hBnvjYRObonZnH8cSm5A0OiFsSEKIiQ9Bj7DLqdo8c1nvmMf1cd5QWZXzPjGHD9mhQ7ESZPqjMPWSikL+EzYBH266H7N9OqhI2s4/Se/oyY7sGXLm0gnqmvqCRNfnO4/+qPcsFGF+gKwT8xh99RfcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59rn4/HxPViq0PRiUWvMljxTcj3/l2hLx2emwgN2HyE=;
 b=Gpj4udfLsoRlvJ8B52heTLWlna1e6ZT7dMMEcePNg1OY3nv0hI4M2uCHVrrYi8mBl14W9OuqVWwCTCbxalFbE6NrQmRcmCocVZZWN3cJoLQlWObDbgSoAn8Ku5zODSjHYowZQ3bSQJWpBnjvyshhI70GNMf57Llur6nRNl7xWZNKQC7n2fhX7uiYLOtAwUT0JKtxwcHrosG9LYwppaVhXKKDPummMCyHtXeemijigRtc3t6E2b++QkAs48siubzw0i7iS5UjIa4hs9nIKb/53W4hguKj7k2Tc0fYj1tnyaSLPvDqe+YKJUnODK8IwF5n7QOCNDMl2L5+s90TcmUvow==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYPPR04MB9016.apcprd04.prod.outlook.com (2603:1096:405:315::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.9; Mon, 27 Jul
 2026 03:52:23 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0270.006; Mon, 27 Jul 2026
 03:52:23 +0000
Message-ID: <SE3PR04MB892268FDDECD4F751F11DF52F3CC2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 27 Jul 2026 11:52:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
To: flavien.solt97@gmail.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
 <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <7c41b904-9e34-4e3b-a702-0ae78d35e469@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYPPR04MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 71365f6e-1a7f-42d6-b67f-08deeb927697
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|41001999006|19110799012|8060799015|5072599009|23021999003|55001999006|24121999003|19101099003|4140399003|22091999003|25010399006|40105399003|52005399003|26121999007|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkZJM2M4YW1EdTM0aXpwblc2U0tMMHJ5alBXUDV1ZFpFL3p4bm9aeTJoekRk?=
 =?utf-8?B?K2MrTkJnL3pqUkRORVV3azBaNGIvVzFxb3RaY1QrUVFaREltbUxvV0FqTnJH?=
 =?utf-8?B?MDA5bWYwMjlDVzhuYjdTSnR5S0dIUUxFbjNFRElDWmN3SWtOZEk4UzhFUTFG?=
 =?utf-8?B?SXo5RHdYYlBERXpUMU95dXY2UXJ4Yy9odkszNU9Ybkl1NlhSWXIxaG5oSEFz?=
 =?utf-8?B?TEhkVVJVT0pnK0ZNYVNvQWlJa01FTzFXbGYzV0J3cWI3a2ZEQnBQV1RxeTN3?=
 =?utf-8?B?Y1h2eFdIc2tpOERndWRmcTdDeVlPUkNsN0ZPa2tabVE0cURCSkp0VmsxQzcr?=
 =?utf-8?B?ekhNbFlMblRqRFZaemp6SEVpN0laeTAzTThsTjN0NlNJNWVOalRDeEpQZlJm?=
 =?utf-8?B?WnZnb28rdnZzVVZTNTYrK1k4NXFYKzVKOTE4dlFteC81M1ZpZzZ3bFlFUjFC?=
 =?utf-8?B?T2F6UUczMjlZd3F3N3dyeWQyVlpWbGxSd0wwU2FsNWxKdXdLQllpL3podGVN?=
 =?utf-8?B?MlJ4TTZrM29KTDJvTUJNU2Q4U2tTa1FvNnFaSStoT2FLdnlCTWlNRHVnSU9t?=
 =?utf-8?B?bmpwT0c2cUhZL2pCU2pSZVZxU3prT3NBT0QzQjh5aTJOWUhiN29OUnlsd2FI?=
 =?utf-8?B?U3RnQnhtR3lQU3JqeDQ3Zk1TcU1KTjdvUGJheFBPUEZncFQ2SFRIOXFOTzI3?=
 =?utf-8?B?RDk1dW1FYjh4bk9YYlg0bFk3VzZSS0VJVjZVMG9qcE1xeEdyWkpzNmFTWndZ?=
 =?utf-8?B?ZEZ3YlB3N0twYURwckRhRjhEQWhZQkZZN0czNldEYmtzQzJ2M25lem1qVlFX?=
 =?utf-8?B?TlRaN1Y5Tm0wcmlldDBHUTJHeGVTS29Xak9ObVVnNzY3NEQvMHdCeS91VW54?=
 =?utf-8?B?V3Y1NUZQQVdma1ZLN3VObjFSSDBUWmNjVHdtc3pSNnZZRkdRNTRYTGdyU3dR?=
 =?utf-8?B?Mk5FOUNoQytEWWY5bUJ1aXpzN0JLUHlWT3d2eUJycGtGazRkZCtIa2s5eHBU?=
 =?utf-8?B?MUtzUm1zVE9MZ0FZZ3l3UmVtYnRmT090aENsQVgxYTZqS08vNUEvajRSQ1hn?=
 =?utf-8?B?WU5WZEs3STlVRDFBSUl4R2dtWi9ZS01CZ0lxd0Z4Z01ObndFV1Q5eGdGR0o4?=
 =?utf-8?B?YVc5dFIybEZ5ZjBuNnduelNoYkUweVJyeXQvbmk2UnplYzJaTmdEZWhtWmZV?=
 =?utf-8?B?dzQ1RHhhbXVOcjd2WE9JSWNrV05MQjRWanVzNHNBODQxQUg1cnJsVkNnS2N6?=
 =?utf-8?B?N0QvWFMrTjhadlpTd0xTMWZPZVpFeEJ0Y1I1VDJkdkFoazVFd3IzenNKVEx5?=
 =?utf-8?B?ckJieTNSRmhaay9GbGd1REF0dXZ4cndreGJSemlzaHhoK3dIdVN1Y3ZzblI3?=
 =?utf-8?B?QUtmM3YxWk5OOU9XeW5mT29sYmdtYTBEcm9BTWZ2dFVRTTVPSjU1VFk4ai81?=
 =?utf-8?B?N2E3LzB3Q3lrZmdFOG5Vd3pISm1ISXBNNkk5YkQ3WVVjbENUMks3VDdOL2tB?=
 =?utf-8?Q?jtcQ19rP5Uj0u1uldkKSAjGcMzQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGFuQU5aN25xN2h4c3MvQ25FcW9oRndWNXY5UlRFeW5aWUFuMWtYWVplbTZv?=
 =?utf-8?B?MDFSU2UvN3JyQUdZY1NFYTZxTlhtT1dyNHJ5aEkwRFFjQ2svSE1aTmphaitZ?=
 =?utf-8?B?SGJsN1p3NFF5cWtpZ0cvdHJPZVRubVNZRW1SKzlDems2UU12SGU5NGhJNk1T?=
 =?utf-8?B?N01xMm1oZjM3QzFsSDFuVCtmd2ViYjNTZWhUNjI3WkpMaXZVRFJxcWFpVHpu?=
 =?utf-8?B?b2VnWGh6bVVmNnltYUhVUW8vK05zcWN5eUJDOGhaRjJvZXpxUUFTbGJNbnNt?=
 =?utf-8?B?L0o1NGNOTFlVdzlRb1V4emFCT0xhb1pqUXk1cVR6WDBlT2tkODR5Z2VOa1ha?=
 =?utf-8?B?SVFMaUVSMVZkRHJEWC9WTmR6L3FvTmdUN2x0SjBLNE9iSG5CK09Tcit5WVJn?=
 =?utf-8?B?UnRtQXBhYkQ4Wi9MUmsvSWtnWHd3QWdYMFVNTXZIMHZnVFNWaTAzQStvR1RC?=
 =?utf-8?B?bEhYMHo2VktOQzd4S2tGOW9LVDVFemluczBpeUVzZEdnRWc1SkxVMjNRQkxL?=
 =?utf-8?B?Qyt0a0M4WWJlSmtkTUpESUVxeHpTb0V2UmtwRnNVV2Z3NkVMMjNHYUVwTk5P?=
 =?utf-8?B?cGl4NHRmZnRRRDhrd2VrQzYvbEhGTkEvZ252dVhNSHl5Y0hrT3NnN1VIU1Rz?=
 =?utf-8?B?NVR6V2xRd09mSU1IdStFaEYrQ21qTVhpOVVsTWdPMU8za21lMVlhbE1GYkFC?=
 =?utf-8?B?NXlwSzM1S3lGblhJNzJGRUlIUWx4ZUV4eWdWV1RxaE1tRXlkanVCNHNwclp3?=
 =?utf-8?B?NVd6L0VkTFBvbEF6YmJ4Yk1UTUZreWUwL1h2WmJ2aUVFMDMyUGQ0TUs5Qm53?=
 =?utf-8?B?UEpxeDNmTHVSdlQ2dzFBVXovTktFbXdMTGlMNjEwQ2RqYi8rZWVjL3FMakNr?=
 =?utf-8?B?Y2JTTm1IcXdGV0h4R2h4SUk2QS9aR2ludFJOUlhCMXF0Q0ZpYUFVUGE4S1py?=
 =?utf-8?B?ZVZVR0NPUzZpM3IrV0lsR1JPbGZRbzAxejJEWlpzS2JIbHArRGRhcFcxdW5F?=
 =?utf-8?B?OGMxU1FPVVl6YWVwWjNvK0pOOW94NlZHUjU2VzcvL0NkeUw2dXhzZk41eXM1?=
 =?utf-8?B?QkptTnIvVm5SU05Ha3ZZc2MyK1Y3L2pQUVdVTEd4SFFHbXowOCtVbUJWbXJq?=
 =?utf-8?B?U3NZcVRORnJMdzNvVUUwbjFDRFRNbC9CRnBmellUVG9qdmFaZU9qWFhuVDV4?=
 =?utf-8?B?SGdCRURvU3NXQkFCMFUwdVFSS3pheTY0OFMvTVIvZnRvamxjT09wRUJpcE5s?=
 =?utf-8?B?YXgxTlJ3ZEZwbFRxUHdvWDhGR0dKZVJPeERIUmRWUGJZeVZpbi9oR0FKMWtt?=
 =?utf-8?B?N2c4aktCTjkwc1hFTXNpZXFrVmVvdTh5ZFB6OU91TDlBT0F3MzhuZDF1dzda?=
 =?utf-8?B?TEl0NjR1S0JkSmwrY0t4S1VVZy9jM0E0UzNxSTlPN29yWGZvYjJMdUgwUVh5?=
 =?utf-8?B?Zk9hVU80UThBUWlyRDRnZ3dtRmxiekg5TmVETmhORTVEOVhiVVBaSTNRazVY?=
 =?utf-8?B?NWZRWXdZVmNsaGVFNVNBQzhZbHlZUC9XUnUvNFV5d3RJaW9wcmlQWGUycWVm?=
 =?utf-8?B?djdWRUNzbE5nM2pqR0FkWDgrd2M2a3ZWcTlocExIMmdGWmNnTzNZeEZEVTVB?=
 =?utf-8?B?aitoQ256MUMyYXA0U2tjNEJNK2lrQjBnLzhWeXoreU9LQkt5eVQ5UEhIT1NS?=
 =?utf-8?B?V2xMazBzV2h6UWp3OGU5cWk4ZE42Nnk0bnFRdERqK0s1aFo4MEdKUDRPZ2Fv?=
 =?utf-8?B?R0dKRW9iaDYraHRYOTYzZWFUcXh1NW5wV1pNbDBjanAyc2ZtMnlVNExNQWxm?=
 =?utf-8?B?OG5tWlVFY3EyLy9jSFVBV25nUjlnKzV2U3VMNExFOUZsMlEwMHpCSjFZRnNk?=
 =?utf-8?Q?i0A7ytNtNoyvV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 71365f6e-1a7f-42d6-b67f-08deeb927697
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 03:52:22.8079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR04MB9016
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 7/27/2026 10:28 AM, flavien.solt97@gmail.com wrote:
>  From 42f759d7e7f4eca064638622d52aa38be11b956b Mon Sep 17 00:00:00 2001
> From: Flavien Solt <flavien.solt97@gmail.com>
> Date: Sun, 26 Jul 2026 17:52:03 +0800
> Subject: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
>
> The AIA specification requires an IOMMU to send the configured notice
> MSI after storing an MSI to an MRIF, even when the corresponding
> interrupt-enable bit is clear.
>
> riscv_iommu_msi_write() currently reads the MRIF interrupt-enable
> doubleword and suppresses the notice MSI when the matching bit is zero.
> This makes notice delivery depend on a bit that AIA requires the IOMMU
> to ignore.
>
> Remove the enable-word read and send the notice MSI unconditionally
> after updating the MRIF pending bit.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 13 -------------
>   1 file changed, 13 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index f6865d1..2bbac30 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -788,19 +788,6 @@ static MemTxResult
> riscv_iommu_msi_write(RISCVIOMMUState *s,
>           goto err;
>       }
>
> -    /* Get MRIF enable bits */
> -    addr = addr + sizeof(intn);
> -    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
> -    if (res != MEMTX_OK) {
> -        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> -        goto err;
> -    }
> -
> -    if (!(intn & data)) {
> -        /* notification disabled, MRIF update completed. */
> -        return MEMTX_OK;
> -    }
> -
>       /* Send notification message */
>       addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
>       n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |


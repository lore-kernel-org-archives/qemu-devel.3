Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568CFCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDbye-0006y9-1f; Tue, 28 Oct 2025 01:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vDax1-0007uj-D1; Tue, 28 Oct 2025 00:04:51 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vDawy-0006sf-E1; Tue, 28 Oct 2025 00:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev9e8btcGEf/1CTGgIK/7ZW+cWSdJ/SCdRg0LT6gVV11ZEYDtC+HmEkWhhN7ZgpUH4Nitl+0X0zVJJTMzY1N9biEkuhwQ77FjYhqhBJo4r39ufSywla3EEttAKChRD2nc4tvD3K0QxJ3HIN+Lv9l3JNoFHbN7YQr41Yb5iGCLWsQDdOdpz9YsY8eHaM49QTjKRmrzpKBYQqyXkeRgtkEkqxEljKAKex3Dz/vDI7acTKC8vUcWQCdL7t5LxNdaS/xg36uLy/82mF2jfNlbgax59x1n552qlP5VrRZ7pfIxlca0ZgFpNKC56P+PUnhYJumaDCfUpxJMdwAOEt/vK9wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP3947JZZR4FPDATP+Lbzw4iL7BvhlGBkdVHHgph8Rw=;
 b=hvDurVDAKP+/jdrFAgai7n7CBraS1NVjK4VfPow0PqG4MVd2EB8dzUl4on26UWuSDYLNqLxpDEXmcKkJrFhIkBCgsco9Cgsg3XOcXAHE2OaNBMMfzN8bVQXzVSI0EJ5vE9Sme/AXuC8q1tvGUx6w9qcH7xOqXDy4RIH1HsnIlpC2hcdYrLzSmyQA1Ef4JYhI+GSxY6lMU/MdjnKsXFKG7hCl38Qq6ZUiMTYJM2Mr/77TsQtpbplKJQJ0jytub4s6FDOCzHmof+VzLl3gDPxqLqg8Hb8Gi7EgtXFzZ6UKFFPQG+We2OFBEAp5fzBLMJSwyLTUgZhpfTv3GGTGJTBwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP3947JZZR4FPDATP+Lbzw4iL7BvhlGBkdVHHgph8Rw=;
 b=aKyPsKx6NmSzqpiqfmPaxbGSMiisrlGvurW3edY1k4GjaGn5HwjFb2YivDubXiTI313XzafNpppOf4VZzxU0id3xP5i0pifJ+8y4XyBsDJSz1rd/7e4J3wWnUP04MrQyGLD4lk3xvSyoDYdg3IxN2Jnrq3ULaO/tAJ7ZNCdI+JxfiwgGQY4Ju+gLXdqC8SihDCF6svOeSgECTda55hm/AVVjUa/vAJx2m4DQduOK8dvXwWU7bNxZzAUxGoeX6Zlfvyc/xfI5exGuFt8x1F6orDkSGvBYZ7YzcFxzIOdKjIi/PfUaBZ4Hpc5mFFz1+ML8vJyMIcGxa92PeBNVWyV0qg==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by TYSPR04MB7504.apcprd04.prod.outlook.com (2603:1096:400:466::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 04:04:39 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 04:04:39 +0000
Message-ID: <KUZPR04MB926504948DCFEE1620225882F3FDA@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Tue, 28 Oct 2025 12:04:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix MemoryRegion owner
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <37ea3f76-87b5-47a7-9807-a20935befe76@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|TYSPR04MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 81980430-8cd1-4260-5ba6-08de15d71d3f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|37102599003|15080799012|23021999003|461199028|5072599009|8060799015|6090799003|40105399003|52005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnVaZXdNUHpJRGUyWUdOZGhQVHVvNkVwWTBGeGxleEoxV3FSQ3NNY0kzUnYw?=
 =?utf-8?B?YjVnby9DUnlWOWNRTUZWOGJWcVp0Mm9UZFpDL0xrVjl1YUpDOXhQWi9oV3Bm?=
 =?utf-8?B?YlNGV05ocUF0cVJLSk40WWVQZGMydXIwQnB2OGlDdGpNUjgvQlVpL0wyc1Rn?=
 =?utf-8?B?c25abVBYZjdkT0t0ODNzK2c2c3l2UlZXY1JMZXNVWEk4a0JmTmNmNzJXaEVo?=
 =?utf-8?B?OUI1dXZIaWRJU3JYQURpcGljZ1g2QmQycS9FeExHL0s4Y205R3ZuN0ZSdXRO?=
 =?utf-8?B?bm9UdHJ2SVdVanBvdUZ0Nkdtc0NvcTRwekt5SlgzVTkvbkFhcXdCUUMvbEtR?=
 =?utf-8?B?UEFqM1FDYlpCNnFVcEt4V1ZCbU8wMm5SdDNlMWliU0dnVG5oUFVWSnpTQk9H?=
 =?utf-8?B?bjhJK1k3OWsrTTJyYXJXRUgvNmIvb3dVbnBqcTNYNVRXS284R2Z4QytlZ2R1?=
 =?utf-8?B?Z1hJMVBpZ2J2eW56ME5CbXpxc0VFTGJqTS9nNlpMTjdpZzN3dXo2cHJYVStQ?=
 =?utf-8?B?QWt2WkRDTllPZ0FHZ1RsNnA4UFBHQ0lYTC9LbHRaYWlWM3VjeWJKRFBCeDNY?=
 =?utf-8?B?dkVBdllvektKL0RxcWVlSi9WbzYwcWYvdXg2OXZJaVZ0UUlYd1hOcmJVYXZY?=
 =?utf-8?B?STdtYWFScUY3UnI4K00rTWtvOURzKzlqY2M4c250MStOMHlpYkxYQmlrTHJv?=
 =?utf-8?B?NzA4VmZ3ZlFiMzFNSmpyNUNOTDJhVW5tNGRXVWtXV1k0b2JlcUJZbFY3Mytj?=
 =?utf-8?B?L0hxTmJHTVpiU1Y1aWt0MjNyZUZ0UDhSdkZmNUU2QzVMbm16R3B1WGJaRW44?=
 =?utf-8?B?ZFd5SkRmcUpha2Fzd2ZZcHhvRUxTL1hjajlZYlBtUWMwRFV2MHFkOTIwSWVt?=
 =?utf-8?B?UVlhblBvUTlaSkZWcmE5S2QzbkRxSy9JenNlOGVRQzROeTdwSE0rM1VFaEdM?=
 =?utf-8?B?djlidWRvaUZiZ0VVR2ViazIzNk15SVhQMURPMmJJU0RIcXIweHZQYkVkT3di?=
 =?utf-8?B?RlU5aEpxS0ZLdkNscnZ5YkJIZVBPYitWUVZJUFhTMk14NTh1UDkvMDlqczE4?=
 =?utf-8?B?WjE1d2VuNDExenlmc2dtUCttdGpCZmlqeDZxaW9IMUFDRCt3YzE0ZDh1cmsw?=
 =?utf-8?B?Q2Y3ZHFWVlVJNjBQdytCSms0Tk9kT2hTbGFVc3VPVGF5UTJhOTBYcDJYQ2Rv?=
 =?utf-8?B?djRlU1pqekp1OHBkdGpKZ0FtbUJzdHNZdEoxcVFKYzhNZGd0em9jY0JZWFNx?=
 =?utf-8?B?MWE0bUZEOGhzRUpBejluVEQ0MmtiVmZ5ZlU3UzdBcG84ZW9oSEczd3NNc3or?=
 =?utf-8?B?MFc3VXJCMHlDZnZndGsrQ0JYd21kMDA4UlB5Vml0WFNOWWNjN0lyQk5ONUp6?=
 =?utf-8?B?dnhsY1EzNTJ4WVRwenN1UXYzL2tmYjYvM3h6US9BcGNtVnN6aVNob3JXWVJj?=
 =?utf-8?B?UUtGZHVDdVkxOENGL1ErNkk5bCtGbWFEUDhVS0ZsSFNjbnpNeWYvOFh5cWpq?=
 =?utf-8?B?L05kd0lJY3hCdHZsU1lTMTdjenBrUXJlSm53Q2dSeG1kNWhwOFBacGEvemNv?=
 =?utf-8?B?Ymdrang1SGx5VlFlNCtyRllNbFlpMW9OSEtKZmFkWlNDVzl3L1RJQnpEeUhN?=
 =?utf-8?Q?2LmnyL1rUjj8d1bq3ptejqemFHDwbhMbb4qpO1sYczAY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhDN2c5amwvTTViT2pzYnJ1MTkweDByZjhldFNaWDFmUlR1U3puZmFJVEs1?=
 =?utf-8?B?b2Zhb0ZZbVFNaXFyTERDdmFCUWNvZ3h5aWlxREFSR1pHQzFvZGFyRjB0T0xB?=
 =?utf-8?B?MEE5R1N4QVF6OUFZUjNrOFg2ZWY4V3A1dTI2TzZnbkVyVjVqdDV0KzdNZGpx?=
 =?utf-8?B?RWZLSjNwdjVEYUtJZStob1JDUk9YQ2NabjJlM1lBclVLQVNLTm5ibWVZV21M?=
 =?utf-8?B?QUJBWTQ3aW1RejZQa2RJRnRROWNGVEt2OTUvaCtyYWx6bStFZmRyaTRiY0oy?=
 =?utf-8?B?S0ZTRkV4YWRDY240cjc5VTM4eHpWSWp3eHUvQVlJSTQrSjlJbk9JODc2UmJI?=
 =?utf-8?B?OEp6WG5wZFk3aHBGVTJLUVd0U29BcUZSTkRQQzZFK1BiWnRvbmdVaHdPZUpp?=
 =?utf-8?B?RW83c1R0by8zMTZlOENLbDIxRnl5UE1LZEFwcFowRXFXOHpLUmFKbWZrQld2?=
 =?utf-8?B?S2o3eWNQQnJmT2FRcit3S2hEZzVRU3FVc0FYUitZMk1ZdFl0aTVlL3dRQmlX?=
 =?utf-8?B?R3EvSHZobGtaL1pGWURlYnJ3OUE0bjdpN1NRU2NSRUZFaFE1R1A0RVc4WVF6?=
 =?utf-8?B?SE5EUFlLOGdxa0dDWk5pRjM2c2hZUm16UDROZ2hsNFZUUDN5MER6RjRvT3Nq?=
 =?utf-8?B?MUptMzZaSDNucnV6QjIrNVNXT3Nqb3Y5RUp0amNHbzlQTDB3emoxaWxrQk1Z?=
 =?utf-8?B?RkgzQ0JBbnZNVVpCRTA5alpwKzhyYzZiajdoVGloWjhQY3VTQ1dTaTdweStB?=
 =?utf-8?B?Q2Vuc1MydEVUa3psNUQ2WlpxdlNuMDdLaUdYb0U4RVhoY2dlUG9oaDYya0xR?=
 =?utf-8?B?VFNiVTkxbGxoMkk1eDB5L2o4c1FDaFZvTXZ3RDFDV3JVUlpoY2hNOTZOaFBs?=
 =?utf-8?B?M1hZYkVyUEpWUmllcENvVVFLbHBPRitCVWhlV2FLd29sRldLR0krVDM2Y0NW?=
 =?utf-8?B?QW40UHBTb0hHUmp5ZlZsQXFFYXBENGdjTHdtaXFDVVhxK3ZPdEFlVk9zUVlq?=
 =?utf-8?B?Q0RQblJLTnZsSXMxeTJBZS9LK1RyUUVZS1ZwOSt1VWNtSTJiOG5HYjVXbS83?=
 =?utf-8?B?VmpvY21nTjZMRTR5ZXlMeGJ0aVcvd20yL2xDVllpZnhrcFQ2VjFoVXU4MVI1?=
 =?utf-8?B?R21nTmorRkFrQjFtNFVNZjJ2SGliVmNmVHZ1T3U3VnJtbTZMMDdpVGRxbjl2?=
 =?utf-8?B?TnJNOHNaOVRWS0NabExDR1dmUXJweDRzUjIvbWJxTGpZdXl6aHBXTU5MZDVC?=
 =?utf-8?B?aURCalFPU3hacHBDdG00S0tyaEdSK2o4VThLUm13ZU4zb1R2d2JiYWh2UHVB?=
 =?utf-8?B?ZGdwREJpSzhZWnBHVUZxLzU3NEt1RTRKUGJPOWx2SFQxM2tTdlRBOGcwcFVw?=
 =?utf-8?B?emdnK2tSMlVMWm9TMkxObFhhZkpPS0k4a0p4cW5UUEdIaGdmWkdRTlBPRW8x?=
 =?utf-8?B?L3UzR1hhMzE4ck02Wi9QeWpNdkFYSDh5OWRxWXdOZGhqTGJWUWRaaWZiWiti?=
 =?utf-8?B?RzJUWXB5aVBlNVhvdDBkcVFJQXFXRm1kUldEbWx5OEZCTldpNW93OW51K0lY?=
 =?utf-8?B?Qm1yeU5rMU8wZitXTTdCYW5Ud2RUUUdDMzV4RElSQ1QwcGUrb0J4anNraWpU?=
 =?utf-8?Q?6z5FdWKfCxpM72iPWjHOcqQvBSRCmeBYHL8RiFU5oHJY=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-38779.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 81980430-8cd1-4260-5ba6-08de15d71d3f
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 04:04:38.9619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7504
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Oct 2025 01:10:32 -0400
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

On 10/27/2025 1:37 PM, Akihiko Odaki wrote:
> as points to the MemoryRegion itself. s is the device that owns the
> MemoryRegion.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/riscv/riscv-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB2606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=eBi0PD5V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xORoD-0001KQ-WA; Tue, 03 Nov 2026 22:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xORoB-0001Ji-9q; Tue, 03 Nov 2026 22:37:07 -0500
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xORo9-0003Gr-Cz; Tue, 03 Nov 2026 22:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIBjY3ohfKY5l8x1klJiwai4TO0FtZ3RwzsLm7p3BXdiHCVGzJas7TLbos+bHpGMiTIinW7dhDnwSiwrBjKdzZTS+ALjpmdc7UlPE9jQaGdk9yKT+gLCgcl4I/uTmrYvK68ezqf5GZ3xEI8umiE/B+2ntQK8GMGnvuw2firKAVNwSfvD31iJo9IjUlJ0Fp9znaMwOpi6iaGiszxj1RiMMSgC5P0tuSL2oqMCTMAZD0mhj9t5nkAdEj1vNEGFw12/z6iddS0X2fu28hSxGk52ZV7dp6tFv72r1meieofILPX7UYXnLlYdS+8yheHWTWofG2vZ77gMS3pA32eKW93fdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtzVqvfFTC/lcaLATeFlkxMy+SoyAnIOWnLdaHku2d4=;
 b=wnXeVtxtpjkGdjq7gt3AVvWR//waKysnpLJWkWIbfyrhTw5KqdYRdsSSi+d1hdL+8HyIq70gVxFl6rVRQuCKPeab8XuDwr6g05KmRSyobBOIMxvOBSIdCtK0VdsvZIs+cVeQ9uawuC1Qm/PFB2rvnIgz+tIxiUXKuW1y4AAyHMMTdQI66kowPaJOBtUSGfmF7y2s4HErZ6rXaMWeW56952fpFP5XSdhpUBIhW+l9p3AwtuaamjVnHamY0qJMohC3/gq7jnV7poreJAGVjNWjH7e5Gur7Nw76acKRLsLIpNdkNsv5pi5wYFKea1viv9PHXip1wdpjEtZ6cjzThAf2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtzVqvfFTC/lcaLATeFlkxMy+SoyAnIOWnLdaHku2d4=;
 b=eBi0PD5VvjiGTIqF4Bzjg/vo76Ed7wLjEoETmnZvtU2Vve/5ylcuWSc3zzRXsB6Ny1L/4A+r8hd8rrOLIpVg4kagNGV2xQKJI2U8gdtVgX+OPQBQIEzKSQIohsFQ0T9oyRz63wE8bqFexao+iSpRgUAU0NY7GPiWbiQkQfrYoQImIaINQdDXfFi2lD0+VA5PN0YnaOl56H9IgCZuhqCGF6rtTV5LAMviFj4uV9GmxH/fRRwCS5FLJMZjMk/AomjCEuTKWNZr6rysixgEHdBb0K12HI+sakFApKiS/S8lm5xeZwsDIAbRA2vFRPA05IJdCMGWDgt3xMw4K3j4Kmg/ow==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYUPR04MB6859.apcprd04.prod.outlook.com (2603:1096:400:352::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 03:36:56 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 03:36:56 +0000
Message-ID: <TYZPR04MB7491FC7E3A7A62E31127DDB0F3682@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 4 Nov 2026 11:36:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv: Build device-common only for its users
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <878e71a3-187d-4d93-9073-f6fbc5d4a7b3@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYUPR04MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ca29e2-7337-4410-24b6-08df3a24dfde
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|19110799012|55001999006|25010399006|4140399003|6090799003|5072599009|15080799012|19101099003|24121999003|22091999003|51005399006|23021999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODBaUFFkVWlJaW1sN1RZd1AzaWVpaEkvUzcvODZySHRhcjNZSitCdVdnYXNa?=
 =?utf-8?B?Vjc1akcwTlRFbitsUXplbWFnWHVXbnNjaGl0VWJMYS93bXhST2RweWRLVFFa?=
 =?utf-8?B?OXRzcUNsSEU2djZ5UHkxOGJJVVdiNkJoK0FoQ2EzSHFMQ0grV2o1SWg0dThx?=
 =?utf-8?B?MTZPZ2w1eXZ6c0dob2xXQlFNL2NpeE52VUFtazhselp5d3pUTGExb3Uyd3R5?=
 =?utf-8?B?cG1peEcvL0o4R04xeC95NzBWdHg4NHFudHNZa2xsdHYyWjJtNjVMUUFRbE4y?=
 =?utf-8?B?aTVvdm8zWVJKeWhCdFd0M0JZdUsvVkN2TGErWU15VjdOM1ZDdnJzMmhyR2RN?=
 =?utf-8?B?SW9IZThSalFTa25GTmVWRDl0dXhESzVBMzlLRTZ4b1FHQ3R3UkdwZ2tGTkJG?=
 =?utf-8?B?ZGw2Z2kvOGFhZDJBNjFXcWRzQTMvRmgydHlkT1NHdGZ5K3NtMkZsdmdQTzlW?=
 =?utf-8?B?QU1TaE1tL0lGMzZOKzVpQVdjN3hvOTBoUEZ0ZHBHcEFVb01oSzFCNEdUUHNw?=
 =?utf-8?B?ZVZ6REY0U0JEY1pOWGdFcmVrSytPaGQvTy8yb3ZqWEl0VVl4akczejFNNXR2?=
 =?utf-8?B?d3d0UW83TEVzeVNBSTh0b1JLN3NzVVRjYjRtdkVxRXJRMVZTenE5aXk5OFhj?=
 =?utf-8?B?dExiZnRQNklvOXpqZ2g1UEFBdE9ab2tmVW1BSGs4QWNqRXVWTDNkQW1mREVX?=
 =?utf-8?B?N1g0SzQzWmEveDNWUHY3TTlkbFNucllXbnlaTDBzSlBma3ZKeUZ4blBjZ0lx?=
 =?utf-8?B?Zml2elJVNmpENXBVTXRPSnlWRC8vMlZlR0NVcTZUTFNmM2JIZzRsZ1g1VkJt?=
 =?utf-8?B?czJySjFtbFdyUUNtSnNaclVzQXNxa2NudlQ1b3pMRkFBZUxmRFJLWXpseUJr?=
 =?utf-8?B?YmZRQVFTN3QyZWIwbVUxVGtxQk1wV25BLzhlcjVqNnl1YnJMNkdvNGRRbzhJ?=
 =?utf-8?B?dXZ0OVNURDZXTDlneUNWR1NVVEI5NmlnVXZSL0IxRkJZanV0UjFxY2E3cjJ5?=
 =?utf-8?B?L3FpdTh1bVgrVjQrQnQ5di8wNmRGV0dqdVNqbXhmMDBqVmdSZE1yTFBCenZJ?=
 =?utf-8?B?cnpiWEsrWlJaZUhvWXhzblJ1VTNnbGZCZi8zRm9OeDVocXBOQUUwWGxMOCtS?=
 =?utf-8?B?VlB4K0xzWGF5WFVHRnNrOVNtN1RaYXhHVWJVN3BaV0MrR2IvVmpLNnhwNWxG?=
 =?utf-8?B?cUJpVjZvQTU1UjRRT3lYeEtvZGVuQlZDUFJjdG9rQldQZFhiSjFwbEQrUHo2?=
 =?utf-8?B?OEI1cHdyYk1SempZNzUzVFk1bEx5d1ErTGhJV21xTzRHUmNUeGlNN3VrUDhx?=
 =?utf-8?B?eWpjMWNWdlJFUjNIOE93VjBYTS9taXVFbFBFdDJYUGVpY0VxbkdONlJyYTNK?=
 =?utf-8?B?YzdKek81SWNMUWsrdHA1K1lXUzRWb3EwNm5aelFRSmk4eWxtdHlqQjNheU1W?=
 =?utf-8?Q?hPNwQgnm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FaZk5ncXhDbXNkaTFQV2oxa3prRUpIQjcxUnM5Qzczc1ExUktHbVhBL0JL?=
 =?utf-8?B?b2dtSkNwT3BBVnZ1VGxiYXJxUzJYYVRialEvcEZyaHNjbDNxVnI0SVlRdklv?=
 =?utf-8?B?OGNML2I5N2haUURPak9rVXBqZFFPUEwrcXA2V2Q0L1RyMEh3RWhDQ2hKeVh6?=
 =?utf-8?B?M3pCVDQwY2FUWVBWbUZsSTl6VWdlMzNsd3pLSFFOdWpacEliSTBhdkYzWW9X?=
 =?utf-8?B?MytXWFlRbjlPMzlQQUhFMEZCYzFQWC8zMTlIbEVNK1Y0dE9XL245K3c2ZVlT?=
 =?utf-8?B?bzdzSVhuaXJqZXpVcE5qajQzd1IvU2xnMzhXS3UwcFc4ZmFDVVBjRXdKM0FV?=
 =?utf-8?B?Z2hmL0FBZjNKTkxGamNTdGEzeHZwU0JQUmRJYmdpVnhZZUtCZ3M4YUdycXM2?=
 =?utf-8?B?RmprKzJXdEJIYTloWWE2YTB6RHpIYmVCYXNOWXF2ZUY1RkJTZ1lWd2hpL1Zv?=
 =?utf-8?B?YVY1VG9wMDlwUVlBUENudURmT3h4czlZRDA1RmFWTzJnMGVucEZtVEZGR3pj?=
 =?utf-8?B?ZUNOYWxGbkpFWWtrc25hNHF6UVB1bzZhSEc0eUhEVlBJcDE4eEUydjBFTU92?=
 =?utf-8?B?a25YdFpWRWRrKzlYODk4QjFFS0xYYko0OGRiUTIrSTBMRWF4WTlLT2NQYkll?=
 =?utf-8?B?WUVrbjhLYVVyRmNscGtRb24rNUYxWW8yRzN6SVIyRUVVcnVXM20wQk10dnB5?=
 =?utf-8?B?UEVGMFRYWDBIT1BjUGVDRHVRT0R6bzZMdFRZQUxac0ljcHNlVzFTY0hUU01j?=
 =?utf-8?B?TnZNdU45eHdzUUJhTlMwWGxoUG8zc0UyaldkRjN4WVdqSFBCdWNwYm9hTlU4?=
 =?utf-8?B?blFNZ0RoRGpRQ1lqMDg3WVZYcVR4MUNoUWQya0lBSG5pRHo1VFd4djBHUXdl?=
 =?utf-8?B?ME1VMDUxdndlbDJtbHZLR3Z0QU1iMjVqcFJsWHNWNUVDVUdRRC9iRm5LY3BZ?=
 =?utf-8?B?VGp1c082alVYVERqU2VHZHRvSG1iSXZqOStSQVh6U3NZdHpZYUVPT09SSTdh?=
 =?utf-8?B?anVhbVNvWE1URi9OcTljUCtWVk96SWNPd3lDL29jTnhUbW9ZVkdOaVpKY1oz?=
 =?utf-8?B?NFBLODVGWXkwaFA5SGJobDNmMW1NWHloMnVMMHJBWHhWMUdNVXpzN25JYXp6?=
 =?utf-8?B?ZGZua0ZXdjhjUldLMnRtL28za014blZOWHc4TndidUZ5eUNaRmhvZGF1TmN4?=
 =?utf-8?B?WERWdUc5UGVnSFZqcG1Zelhwd2ZISWhKTmtidUdlK1hvcnJ4L3M2eEgycXRv?=
 =?utf-8?B?YlpiYWtoemVFaXJPSDhVZ0x4Y2UvbUVRakQxUHNCeFJyNFZMOFBnZ0t0VXMr?=
 =?utf-8?B?dHhkU1hObHN6RlcrVGZrTVRlNGlqUEg2N1dHellXUVhQWWlCUzRNTEExdDFt?=
 =?utf-8?B?b3JDT0lMVnc5dUtOcXpSaFJ0ZVFjU1lwMkJscEN1ZEtyaTA2am1WNXVYc1Jr?=
 =?utf-8?B?VWNhQ2dEZzlvVFR3QVRjcjVlK2RSZjNYUVVteVNaUHpReW0yOTkxR0xBVnpI?=
 =?utf-8?B?OEZ5REd6STNzNG5Rbzl6SzVvMUg0Sm5aWjkwbzljWXc2ZlhXSXZ6Qlg4czVU?=
 =?utf-8?B?U09uVWhNRjg3aWZ6TFhCZ1oydU8wUEFaYTBJSkhGcGRTRXFTOUN4dmEzcS9I?=
 =?utf-8?B?Q3VyYVhOb0hkWVFwTUZtY3JpMUxDQXNHc2I3bmNBaHVCNGhRWEExM1dtUjVG?=
 =?utf-8?B?SjFnRS9kM3A4OVJBQXgvYS9BalRKRjBHRUQ2a1BJRER5NXFLdzZwNlN2Q2dY?=
 =?utf-8?B?WmRTRTRvTVJ5ZURST0ZBdEo0d2xKdXIxYkV1RWxuRTVIL3RIWEhrYjBpM1NB?=
 =?utf-8?B?MDh4NmVBV1V0U0RDeXY1RWsyOUZ4ZFF0R2h2WHBnNnVQMm5ZS3dDOGc5Z2pB?=
 =?utf-8?Q?v3xwkCSUSZJHN?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ca29e2-7337-4410-24b6-08df3a24dfde
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 03:36:56.1628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6859
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/1/2026 11:15 AM, Tan Chi wrote:
> hw/riscv/device-common.c is built unconditionally, although its
> helpers are only used by the virt and server reference machines.
>
> In minimal builds without these machines, device-common.c can
> reference device implementations that are not built, resulting
> in an undefined reference to gpex_set_irq_num().
>
> Introduce CONFIG_RISCV_DEVICE_COMMON and select it from the two
> machines that use these helpers. Build device-common.c only
> when this option is enabled.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/Kconfig     | 5 +++++
>   hw/riscv/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fb05031228..27f03b687c 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -7,6 +7,9 @@ config RISCV_NUMA
>   config IBEX
>       bool
>   
> +config RISCV_DEVICE_COMMON
> +    bool
> +
>   # RISC-V machines in alphabetical order
>   
>   config MICROCHIP_PFSOC
> @@ -68,6 +71,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select RISCV_DEVICE_COMMON
>   
>   config RISCV_SERVER_PLATFORM_REF
>       bool
> @@ -85,6 +89,7 @@ config RISCV_SERVER_PLATFORM_REF
>       select RISCV_IOMMU
>       select RISCV_NUMA
>       select SERIAL_MM
> +    select RISCV_DEVICE_COMMON
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 957031c07d..b60108787d 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -2,7 +2,7 @@ riscv_ss = ss.source_set()
>   riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
>                if_true: files('aia.c'))
>   riscv_ss.add(files('boot.c'))
> -riscv_ss.add(files('device-common.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_DEVICE_COMMON', if_true: files('device-common.c'))
>   riscv_ss.add(files('fdt-common.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>   riscv_ss.add(files('riscv_hart.c'))


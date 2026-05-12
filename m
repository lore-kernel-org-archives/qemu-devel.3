Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49743CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjri-0008AU-Bw; Tue, 12 May 2026 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wMjrg-00089t-Gb; Tue, 12 May 2026 05:57:24 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wMjrd-0006bA-4M; Tue, 12 May 2026 05:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl9M4q/zmANqu6rGl0OiRRklNWnClEgU56AKITt/x2H2XErjj7YwRzqTsi75B7FIt9SwcXhml3kDBHo5+fQ5h9bBsKZ1cJCqVtmpKqmad4WyY47Rs+NNt/w5f7msxt7cWHP6BOTjhVEGVWqVBINpxebF1C2XphhXjTdzV8JdGFK4E4ln6MoM4S41VlLyJ26xILRzD+boMLCBFTRJXrtbvH7BFGX33PlcqFTqGOQ3Xvi7KQ3J3m8a7WPNEF+e4/Iyyy1O7PtQo867IzPYMxl0Q0Ix8Q40KLlkYfsTab5lRMJ7KvELGthMzClGAt8+plPfEQWaeD2vOhnawLp1s+wKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wwiFXLw2a7yJjXOOrPeqE8FiFd2m4cmu7F7nt2/rKg=;
 b=gd7CMyTvHsI14G63lR28qavAuiICmoM3SWFBVqrSXDyACJQEruuAAOuCqoGnqLcH9e6nwjmSjwDCzxBAZdqGw+L+RJ68NUEgJsDjat68KDj9a2rI3sL9lSj1Hy+5sQcFW8AQnFJmpKWeRkB6YaqoF+ucqcMMsmmbHGP8ALGtX+rn3klzs4BnuTMTlLEGGj2gWJE9H/Vl8yg/yhXPXEad6vw1QpQI+WXpOPGvOyytaG+kfuF+ipKrBMx2/qTRnZPl9qPi/knhsmnaDKPOeD4CFNaykI4JpIPOqyAQ40TXRMWnveoneenhMhJ85f8v7WqwTQgUToeXgg3GDpr/HbqEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wwiFXLw2a7yJjXOOrPeqE8FiFd2m4cmu7F7nt2/rKg=;
 b=Zb8OCbpWxtXKF+0a3BktMDQvA+x0ROw3AH7CpgDCeXWiUqVWEOuSiNb0V8tslG1UiS0jker9kpQmL9wIG4RIdPnmnleo6BXu14L+YJXX4p6g3JcUfpd10Aen+HaXoNx1uEl14kE1dsWdaQmeDKkXJTrgfbzhQsrBHGD8Ifvby6Rp8HXpQ3H0EUJQ/KPSFa+0Ey7M9mpoLE01JCwRJVhcZdeLTmlrXAkUY07oGiMrIq9QjmsiqaxWXfrcbGTMBLXEW4gu8o2yvHTOGGjMHnwZRue15IPcph8fP6skz+0cdKFVktLJhuUHx4g8PFqNv67Y8Pdr6qf7Ynwe8vjzE65nHQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SE2PPFBA3254C3A.apcprd04.prod.outlook.com (2603:1096:108:1::627)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 09:57:11 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:57:11 +0000
Message-ID: <SE3PR04MB89221F003ACE2E6B0443219CF3392@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 12 May 2026 17:57:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, tjeznach@rivosinc.com
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0005.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::15) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <44e43bce-4d81-467d-8f30-98ca8d54bb39@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SE2PPFBA3254C3A:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa81c82-fcc8-4708-16ba-08deb00cd63c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|23021999003|19110799012|15080799012|8060799015|6090799003|5072599009|51005399006|12121999013|45011099003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTRYVzcreEZUSmE1R0VsNjhkY2VOR1craHUrcjVVSVJSN2hRd2NZdXdFRWVD?=
 =?utf-8?B?djgyVHJMOHZxcStWeXVYMHRxaUhWR1FXV3VwNlFaVEVzdUdmLzFsK1o0Ly9n?=
 =?utf-8?B?WTFqYmxpdnZld0ZEcFRURDA3UXFKUFllYjB5blJIMDBBZ3pyK2xyZ0x0cTdl?=
 =?utf-8?B?TW1ZdCtEa2F2eVJVMW4xZ1RhWHpEYVJ3TWk0cWpuNis4ZzFyajJIcFRhNURy?=
 =?utf-8?B?dmVhZzJETjZ5UkVBd09jVWtyVzBiWjEwSEtzSG5tMnduNHg2WVp3OHhOdXNW?=
 =?utf-8?B?NllXanpNZnBpdW93UC80OVVvUENCMWQzN3A0RXNaOGJDU2pTbW5UMVdJUTdD?=
 =?utf-8?B?aW5Hb3NqQWZJQ3ViOFgzM0dVVHRnejcwbUowbFhLbDNSM2dOWVpoSDZqc2JE?=
 =?utf-8?B?dGF4d21wbm0zWFZZTnYraE9KOHlXa1cwams1WUVydkRFZWhSMUJGeTJ4alpM?=
 =?utf-8?B?WVphcTNtR2ZJLzlpd2U0ZnFvWHBFd3FpN3BxcDlCMWliQkkvRVAwa2k2TUxY?=
 =?utf-8?B?UjY3aElBaFFqMGJyN0Uya2FFZzF6aG9LdTY0SnBGOCtSV3FBTXBkaUdES1B5?=
 =?utf-8?B?UFFTTHdPUzlkTE9hb2d6dnpneW1lYkRsb1o1czFQM2xISTZlOURJR3lYYnhk?=
 =?utf-8?B?RG5SaUVGbjlONEpKSUh4VVkydTlDeXJ3dUtpRUw3dTM3R0RaYXhVY0xocG4x?=
 =?utf-8?B?MmdXQ0ZwZVczTGI3OUdRMGs0dHZDSlhPaVd2TFVsdk4wcyt1SkRyWnBzZnBv?=
 =?utf-8?B?RW9VR0NpallPVUdvRmphR1lPbnV4T2t3cC9wUFRrN0crMXIxa29JTm0rNzNN?=
 =?utf-8?B?UG5IRHRaSDVXczZGTUhTS0ZaaEFJMDgxQnBBcWZhOHFvRC96aFRJaFBMYXFQ?=
 =?utf-8?B?bHBLTGlVaUh1VmltWmFNdjFQbjNzVXFaVWxyc0EyaE50RzFoZm5VNFdJMGNG?=
 =?utf-8?B?YWQxaWRIL29GRXJ2OUxrTXpNOUpia2d5eVA2K1RNN0pmWHRWeldHbUtaNjFJ?=
 =?utf-8?B?bFI1bmFjc3M4WjcrTUhDRWloZUlwT0RnbnlVdGRaTUZnVnNaeGVrQXdpRHpO?=
 =?utf-8?B?WDd0YUNRTVBrK3JjdlhPUG0xc1dvVldyazkzOTM1a1FicVRKdS9qM0JJeS9D?=
 =?utf-8?B?bjZqZ1Yvd3JOMjd6aDBSaUROUjRNSXF4VHVWdkdLUGtRbXN6UG1VZWFreVFD?=
 =?utf-8?B?eFhlZGhYZStGVytmVDNhdDFpVHhTcms2TXVHaW9aeGJsdjZRSmtac2hYck1P?=
 =?utf-8?B?Rmo5S0M2NXo5all2TEZTSk1SeExQS2pXVWpJcmRPbEx4d200cVV3cTFHQzhT?=
 =?utf-8?B?aDN5bitReVFDbnlWb0lGdXJtYlIzc29neDJCRVl4Ry9IdUFxOWFwYjd6UWwr?=
 =?utf-8?B?dkRiZzh0cldqdkE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xvUktaTHV3TE55blZuVHpRVHJhd2w1ODZLWm8vaWo4TmNzNnNhNHExZTZO?=
 =?utf-8?B?SEVxWFlNdGVhZ1JtRitzZ3BQRytQSUwzZk9qaytkYnBnN1pncmJnRU5Fa0Jo?=
 =?utf-8?B?ZENZQ1V3M2xJSGFjTXVKTmdHTlcrMS9XbEFmNnR5aEVoc3lqc2lFY0pVdzE0?=
 =?utf-8?B?UVg2aUVCWVdyUTJPdE1hMk5xMWdPNWsxUUhZb2lBMFQyc21nQXY2WDAxaHlF?=
 =?utf-8?B?a01kczhoTEFtYVNWY0U2cldSY3BOajR5cDJVM1d1VzVPQytRUS9ITFNWSVlj?=
 =?utf-8?B?SUxOTkw3N1NqM05xMlBEdTY2K3hSaWdmQnJSc1BmTUZjTjhBV3RuQ3B2L29q?=
 =?utf-8?B?YzRxSVEzZjU1UWFrRTFnMUo4N0YrVXBQZVFIejVFeExnNVB6ejZNeUdoY3lE?=
 =?utf-8?B?ZGFYTk14VkFQRnJ0R1JBYVpQeTJEVXV6QVM1NkNndHdWZG1KNWg5ZWRHUVNB?=
 =?utf-8?B?OE4wSEZIY3UwMnNudW5meFVhUUJLYU5tWGlWa3E3K3MyUmd5VWROVG9GZ25X?=
 =?utf-8?B?VitodGJIQTVoSEhna0NiRXJZc29wbTBJUXFTQXFTd0hMNFNTc21RRGxUYzFV?=
 =?utf-8?B?QjB2RDRDZWdodHJrY2hRSDdXbW9JL2V3bThqeVBTRkJVMVU2RDZUNEtQWDZk?=
 =?utf-8?B?cUtYRlgrRGdoTFNsUDZBU09UM0dWc29vS1F6dnVUa01uam9tUm11MXhoYkt0?=
 =?utf-8?B?eXkyWkUxZk5QOUNML0EyY05rTE1pUTAxbGdXazdGQ1ptdzVIY0FaRlpzOTBs?=
 =?utf-8?B?RWZRcWVCMGZWNzRCc1lRRzZSYzBXY2NjQ0owdWFkMTZDazAwQlZtaFlVS0hs?=
 =?utf-8?B?ZG4zMmFGd001TTFGODlZUzJWTXp3bFFYN3Ara3RvbzBWQVhHdGJucHdLM3V1?=
 =?utf-8?B?eEp1WHEzQzJCS0pUdDJsWHQxalVmaWhSQjRrLzNLaVI1NWpnSytpZTYwNWJD?=
 =?utf-8?B?alBFNWdhMXdtUENSQm5NSXkrWUViWUZ2cEczOU1nVXZwMjEwVXlqN2g0cjNJ?=
 =?utf-8?B?U3d0SzN5TUVpYmF5SGxXNENFR1ZULzhDMVM2WkY2TU1RY0x3c1l1TFF2Zllx?=
 =?utf-8?B?UWRTa3RRL3JRbzNTYjZNNXJIUXAzNGk4U3J3WGorYnk2ZkdmMkZ0c2VoZ0I5?=
 =?utf-8?B?TExwb0VZNFU5K2VhOXFzRXBzcEdzTmlUSkZuRjRkZFBhSmJKL29nNUNLQk5N?=
 =?utf-8?B?UmZOQmdrRDZUbWtjOVNFb3h2b0FtbUVoeXpyV3BxM2V0aWFPcmhLRHNuaWxW?=
 =?utf-8?B?a2U2SVNPZDdJVlp3dTVvWlA5OFdDcW9EaTgyUnh6UHpKWXVSbkNYbWNQbFkv?=
 =?utf-8?B?NFdNV3QySWtpV3FINXhldzdPS0FWdjZZRUxtenRmMGtlNFJPQi9iRjJuSEg5?=
 =?utf-8?B?enZ6ajMrS1BNK0ZpM1dXNEFDNXVJdk43NUl0WGhmK2x3TlVmdE5Ed20zVTJv?=
 =?utf-8?B?bWt5QTRNbjBpcElDV09zd09ObHJLSVpKZi9nTFBsRmUvQXNGWVVmbG5Zb1Bq?=
 =?utf-8?B?UFE0K0FPQ0FwbGtGaHIwaytVMlI1OXhyODFaM2hPc1BYbGhuUjA1ZTN3UWJG?=
 =?utf-8?B?dFBQWExGWmNKZndleXJleUlRbmhhRWdzR3JPMlZuTmtkaWczOG5tSXpMaGtT?=
 =?utf-8?B?S1k1VDcyYVIrOWRHdDdxajhRTjR3NnhXRzhqZHFVSkwyblVISXRrM0p3UnpQ?=
 =?utf-8?B?clNUeHZWWmxzcEJXVG5VZlBQN2xsbjZxUDZqVXVCenY1QjVKVytYUzBxZUlL?=
 =?utf-8?B?ay9GaHEwVHVDdEVvN3NSSGIybDJqZlUxNHZ3eldpSWxDekdyTHBRK3BZMnVx?=
 =?utf-8?B?aW5JV2NFdWYxYllYZEVjUjQrMUdkY1RCNytIbEZkOVNhb0xsMlg1bVdzRkpR?=
 =?utf-8?Q?d97UwKnbp6+4Y?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa81c82-fcc8-4708-16ba-08deb00cd63c
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:57:11.7961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFBA3254C3A
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


On 5/9/2026 4:51 AM, Andrew Jones wrote:
> The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> encoded) PPN directly in the physical address, yielding an address
> 32 KB above the correct base.
>
> Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> the Svnapot handling already present in target/riscv/cpu_helper.c:
>
>    napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
>    napot_mask  = (1 << napot_bits) - 1   /* 0xF */
>    phys_base   = PPN_PHYS(ppn & ~napot_mask)
>    page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))
>
> The spec only defines napot_bits == 4 (64KB); any other value is
> treated as a reserved encoding.
>
> This is a fix, rather than new feature support, because the spec
> says "IOMMU implementations must support the Svnapot standard
> extension for NAPOT Translation Contiguity."
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 25a356d1d366..eb09cc974812 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       return true;
>   }
>   
> +/* Returns the NAPOT page mask, or 0 for reserved encodings. */
> +static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
> +{
> +    int napot_bits = ctz64(ppn) + 1;
> +    hwaddr napot_mask, page_mask;
> +
> +    /* The spec only defines 64KB (napot_bits == 4) */
> +    if (napot_bits != 4) {
> +        return 0;
> +    }
> +
> +    napot_mask = (1ULL << napot_bits) - 1;
> +    page_mask = PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
> +
> +    *out = PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
> +
> +    return page_mask;
> +}
> +
>   /*
>    * RISCV IOMMU Address Translation Lookup - Page Table Walk
>    *
> @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           } else {
>               /* Leaf PTE, translation completed. */
>               sc[pass].step = sc[pass].levels;
> -            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> -            /* Update address mask based on smallest translation granularity */
> -            iotlb->addr_mask &= (1ULL << va_skip) - 1;
> +
> +            if (pte & PTE_N) {
> +                hwaddr mask = riscv_iommu_napot_page_mask(ppn, addr, &base);
> +
> +                if (!mask) {
> +                    break;
> +                }
> +                iotlb->addr_mask &= mask;
> +            } else {
> +                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +                /* Update address mask based on smallest translation granularity */
> +                iotlb->addr_mask &= (1ULL << va_skip) - 1;
> +            }
> +
>               /* Continue with S-Stage translation? */
>               if (pass && sc[0].step != sc[0].levels) {
>                   pass = S_STAGE;
> @@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
>               return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
>           } else {
>               /* Leaf PTE, translation completed. */
> -            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            if (pte & PTE_N) {
> +                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
> +                    return MEMTX_ACCESS_ERROR;
> +                }
> +            } else {
> +                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            }
>               break;
>           }
>   


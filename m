Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47D0EE6440
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 14:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vawqY-0003NG-3V; Wed, 31 Dec 2025 09:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vatOi-0007Ep-Gd; Wed, 31 Dec 2025 05:25:45 -0500
Received: from mail-japanwestazolkn19012059.outbound.protection.outlook.com
 ([52.103.66.59] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vatOg-0003wG-2I; Wed, 31 Dec 2025 05:25:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb6t18xpi4sxa6KabAJ0oTDydsDNpP65Xj2W6hc+56mbE+GAsLvyoZkeISe//exFxmPIf9VNv99ldyNoFsSgjQAm/WSqlwpW9/OL7PIVHlLam303xf/XX9sVV5XMrj8DJOZ1nv9ermcG9qDpwT9uG+3HBRjOf/fnP37qD/0M2NnnFNUkdLGWuCQwcQLfH2QWzMnOQT7uWhp56oGPMfM8OkNEhcV7yHjHRlYYPXno6e6ItdQHKgS4avV3v0Ko4RxPM5W7ZG66DwA3FvEx2PknyJIZWBY5hctdcRoOgReSMFiv61o+c0pofjB1eixq/8eRC7L87mruS+i+8e16VkFbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsB0eYZe8Df+hhn5zD2Q2WOJdZk4PI9UYyV9jj5aIGA=;
 b=oR02YVQyit3r9WmBA9c1xYxDIEDGFBvTdg3XDtwI8yoz9SrwHChFY91O47LTLWoC6AHPW6Q6z9qr67Rh49DMA5co5lyB4smdzDf6+MtBOFFyu27VBLd5xWvCk8bTZqeUofArqyU03PDj1J+gBl1qvYk86cDsyqZ3114onBjTYY/a0fbe+V29lXDs+94g0lvAQ89DvnvqhHeO0tOY68d4T+loedO9+ygw1ALu8Uvg8b6xe2kQHN0Agr1sYtrTS9Re3GWxtp5+E7z9w+vSOfzjL2qGI3wTADpnNxLTlH1PR3RMlaI/5CO5tYyZU4Us0gXdyID5qUGgN2A+wop8Shgtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsB0eYZe8Df+hhn5zD2Q2WOJdZk4PI9UYyV9jj5aIGA=;
 b=b0SXNxEspqVD+aqmJNyLSMcO3s7sT3Bqdl1zYAf47unZPWDlUJX3CNv65k9AxZDD8LCLuBzj6fKMTMZEK6EE2nO/rzj9mFfTng3RLTlq1u9MSUnzEnffSZw2CvWRreyBCsWigflMDTbYSCPtZSWuG3sYmx3QUwKoo37B6ToA6el0eDbbIBEm6Ju3veCtHFMUULk2yY6NnQCckvlRb2XAXw+T0DnYupcjpdPw+fjPc33AIu7rWtJ7n56PmQZhTThLbn7RhhMd12UAIJpmAyWdeKihE6M4RVNrg4GyEf5XNSWeW6rhJie2tSI5cZKd8afP0PdCEAyoUwoMXSPDcwV1eQ==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by JH0PR04MB7464.apcprd04.prod.outlook.com (2603:1096:990:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:20:33 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%5]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:20:33 +0000
Message-ID: <KUZPR04MB9265E2B25DDEF5BB81369DEFF3BDA@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Wed, 31 Dec 2025 18:20:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv: Don't insert DDT cache in Bare mode
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20251211025611.99038-1-jay.chang@sifive.com>
 <20251211025611.99038-2-jay.chang@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20251211025611.99038-2-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To KUZPR04MB9265.apcprd04.prod.outlook.com
 (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <fcb2260e-34b4-4ea1-87e7-787324565816@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|JH0PR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3f7405-7607-4ebb-7e0d-08de48563abb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|41001999006|19110799012|6090799003|23021999003|8060799015|461199028|15080799012|7042599007|5072599009|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzFpU2VFY2VuNUpWMjFia25qU0swMEZFaVRLT3NFaXU0a0RJZVZQZUlObXRR?=
 =?utf-8?B?a2x2L2ZjWVhLaCtjTnc5ajdLMkxSSjdwUkcvTVhIOXFGVWZJRHRYMFV5alh2?=
 =?utf-8?B?MEUxNjZLT0E4c05WTmMwb25GSWM5QldIR2dYdmN6Z2NobHNlUTFkWXhkT29P?=
 =?utf-8?B?cmZSSzRaeWh0QkhMT0pmcEhQUlRidmdjTi9BUkVmNjRLSVBFMjRaT0pMdnNT?=
 =?utf-8?B?SWM4S0xYeUZEZEhmazlyYmtZc05rOTZ1cGlWRW04NDJKVGVNaFltQmkxc2NK?=
 =?utf-8?B?dWVlLzlMU3BvUWhVN01tcC90b1k1TkhBc2JFYU10RHBWSGdwOU9pYXByc0pU?=
 =?utf-8?B?aVBqOXZzdVBZb2tML0ZmeW1rb2ZwbWhUODM5SWlGaGR3dldTRG9yZE02RVJN?=
 =?utf-8?B?YitIUTVHd3RhWUthaDQ3VkFWS2NsWEtKYTkraGtSODNnV1NyMlJGTEEzV1Y5?=
 =?utf-8?B?TFB5NysxK1hIR1ZQSjNmR0laTTN1ZkV0RHFkMFVmMnFwK05oTlVRdEpHajZE?=
 =?utf-8?B?NUV2OTc4TVJXLzBtR2ZlQ0pYaWNNVDJITzZqK3BaamNLVlE0TDB2blhRNFJI?=
 =?utf-8?B?bjF1UGRyNzVKWE5JcG9nSjNxZW1zRVk1MDAxaVlmRC81NVJZenhtT2NQMUJL?=
 =?utf-8?B?TDBac3V1ZXVhWHNTR0hzZDNkN0Zwa3NKeHNYbTRWQkxHRGloZjZoREt1M2dx?=
 =?utf-8?B?aG0xWHY0NnNLMHVKc3J3YXc5OTJQT2dMTjR3SFFXSEN1a0p0cnVLcU1hVXBa?=
 =?utf-8?B?Q0hOS3JFN0VwL2lRVzcvMFpKNlVWN05rZG9GaUFyak43clg2TXo2bGVtb1ZJ?=
 =?utf-8?B?TEpKVm13NElqZG5hTEloY1VPcnRubVdsT0ZaOXdUKzA5QUUzYTFldzlCRzNJ?=
 =?utf-8?B?NmVZSE5EQjFDUk9nL2Zwamhib1BBZmt4NXRhZzhGWDV2NmxXajVweWJ4YlJk?=
 =?utf-8?B?TG1OUGpUZjBjc2hOcHhnUG5RNmM4ejN3RVdRRW9yL01hb3VnRUQ2UDcybDQ5?=
 =?utf-8?B?b2ZYUTNEbE9DNzVtZjFKbm5xcXJOMC80SU9kcTI3aXRoODdDZTdUVk5lUjF5?=
 =?utf-8?B?cWRjSnFSbXIzaWY3LysrR01YMFJSazVsM1ArS2ZSSEpoVUJJV0I4Kzh4SDJR?=
 =?utf-8?B?emJFTU1KWCtoU245RTdxOGR6VFdKM0htMW1aWVNxSVFRTytrVHpOS0VUM2tt?=
 =?utf-8?B?OTFnTTg1QnlzVzRYeFcxTzlzZFdGSEFFd001RjNEWEY4VDRsbEVOYVlXelJn?=
 =?utf-8?B?bzkrWk9GQWhmOWVrLzhncC9kYmRRYWh4cUhsQ3kwRlkwbnFKQWZ6eUNJeDUx?=
 =?utf-8?B?dGZtYTJzMWJVZFlITVZVTTVvWTlZcy9pdUozdm5EMjlKd3NpVnViWDA1UFBw?=
 =?utf-8?B?SC9nK21BV2t1bXdIaGFQU2hCRURsc01GR1ArSnhtSFJqNStEbjh0bVh0UTVO?=
 =?utf-8?B?UVJNUi9OTktxWlozOGFvOU1NdWRXcUQ1U3ZWaW5qc0ZvNHFocm1kOGVwbkxk?=
 =?utf-8?B?T0dNdXdwY1RvTVF3aGR6OUVqazNsMW04Z1JXaUhnYkN2ZVJmQXBnSFlINUpo?=
 =?utf-8?B?RGp1VGxJV1I3Z2tuUFVjeExSRFVybXZJd2NDSjlieGV1bS9OVzRyU081dXpt?=
 =?utf-8?B?eFJMWUh1UzAyQVhhdFVzYWtndWtlWno5Z0o5RURvOTFVMFl2TG9wQnZ2Wi9M?=
 =?utf-8?B?aHV5NDZvTW1mNFEySDY2KzJxNzI0azBTa2xaY242S1daOTFpK3RaY2xPRXMr?=
 =?utf-8?Q?X8BnvVu/4djSRLyKNM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0k2WDVWTERhelp3OE9IZnZyMHhuYjd2TTArVHgxNEJSd05kUmlBQW52T0Vr?=
 =?utf-8?B?SllNWDRUeTZlK0lJeldtb2dZOUdUNDREbHI5VGZ2TTdxdkh2WU9RNnRDZkN0?=
 =?utf-8?B?cjdDMjRuSllFWFMreXY3M0ZKeTFpY1o3SUZtWC9md1MvMUxnRkRJejNna0pr?=
 =?utf-8?B?VzNzNHd3ZzREZ0xJOWt1NjJENGdYT2NYMDVzSWJDdjVtN3gxRDVha1ZyTlZs?=
 =?utf-8?B?WHY5czcxS0szWFloM3JMZmlsekl3TGtxWHRPZW5MMnVhTWlaV1lJSEJVNEc0?=
 =?utf-8?B?dEc5K1Jkam1mK01ta1E0V1ZvajRRbmFqcE5FNng0bkkyVUY5V0xGY2N0WXN4?=
 =?utf-8?B?ZXZFdm9sUXk2czdNcHN6UGZHQ2M4eWdTVFNTRW55Tm5mQmNXaVhUbStlYitW?=
 =?utf-8?B?OURoUERIMXJPeVMwOXVnc0hYbHlnNElQME5zR3hwbW1JZHFQaG1SblVPU3Rq?=
 =?utf-8?B?b2Q3bDBEYVlRSDg5d0NBZ05MUENoWnFWdEJjaVdiUWoydkw5QUFCR2cvQmdZ?=
 =?utf-8?B?V2FjaVhXa1Y5bmpua1FBQnBjaWQycmZEVU1laEd6Z3dES1ZNZUV6eEZNYkQv?=
 =?utf-8?B?VlpodXlNemI5R2Y4ZHdzQkQ5NERubnd3aXlLVjk2N0MwTW5JVXJkbFR6NlZ6?=
 =?utf-8?B?cVpWN2pUeDZBSGpkUFNnWXdkNlQ2b0pCSS9xdkU0T2JwNmxCZFpkSUNTWlNm?=
 =?utf-8?B?RTNrTy9SSjEvU1hOZGhzOC9kV3NPS3g4cFpOSGk1NEFPb1d0UDRSZHJzcmF5?=
 =?utf-8?B?eXJVT1RNYldCd0w3NXQrdS9GdVZKVTJBTU45bWVvaUUxaEFDVkdBMGxDRmlO?=
 =?utf-8?B?cFZyNzd4Q3hiYjVFM1dMdlZPWko2eHNHTDJoRGNSakpsenp6QkhNRm56Q3ZX?=
 =?utf-8?B?dTZRUDRCTmdCcU1rNWd2MjhzNlhDc0RvTEYyemRVMjJyVVpGNjUzZnRUUkti?=
 =?utf-8?B?ZWIwR2JpNXV1b1RqSFA5cHh3K2xhNnBCOUtpcm9wRkpyZ3JBcnF6MFZDOGlW?=
 =?utf-8?B?VnlSa0dpMTNCUzYwSkdPV0FjKzBDVG4yOGFzaHhoRzNkT29GcTdSc28yVk9y?=
 =?utf-8?B?d3diUzZoT3Npcmx0NEZMZWlCRzIwcFYydzh6VnltUG9ROWozS3NVellaS3Fn?=
 =?utf-8?B?T3ZoVUlQQ0Q2UStzSm1UUGJ5aEZJU1QvLytjdlRJbTlpb0dReXdJc0ovbXVv?=
 =?utf-8?B?WTN6aWpmTUdpNTV0Z0hkOWd4b3JxaWh2eWFQd3RWK3p5bUVjQmxPV01EN1M0?=
 =?utf-8?B?R09obXZQVE4vL2FKMWx1cE1tRlJXTVZWdUZVTnNTR0FwM0dxbDYvODZZaUlI?=
 =?utf-8?B?KzgwOUs3ZUt0Zk81Mzh4NkI0emEzYUxIV0RqQkw4YUVCNzkxU0pDWm52Tnht?=
 =?utf-8?B?OTFjL3A5RVE0Q01nQWJsTm5qK1MzMks2OUUrZmJDMjhmMHI5OXRKeUVZOVFW?=
 =?utf-8?B?RE5wVDdEZVFmRE9yM0NzSTZhS0VHQkhpTm1IT3ZuZG4wTjdXUjdIT0RVNHd3?=
 =?utf-8?B?UXkyTTUxK29abDhnR3Y0d0FRaFoxdFBYY01oK3BWdUJNNXUyWlhBLzNjTVVU?=
 =?utf-8?B?bTdGWnNFbVJPeHViVnBvTVBPQlhrSkxXRjh3RGFadkViUjduOFoxTEsxdmlx?=
 =?utf-8?B?YlJTT0Z2bC82d1o1NnVKT1gxb2MyaXdCWTJ2YWNPYS96OVdTK0ViQllSQUw4?=
 =?utf-8?B?TGtLd1NURkVEOE96RllPbFR4UmdFbjNLa3VvazV1YjFLZGRmRm9LK2pvLzNm?=
 =?utf-8?B?eW9qUml2OUhOUUViaWJkNnZsWmtQTlVieC9IY0xBcStPb0Z0Sjl2V3YxdVRB?=
 =?utf-8?B?STdEUnRuYUFYQ1JVQk9vQTZ3MGgyMFU0UWx1WDRoRSs1YldpZzN3NDByWTl5?=
 =?utf-8?Q?hMepRzREcEdN+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3f7405-7607-4ebb-7e0d-08de48563abb
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:20:32.9196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7464
Received-SPF: pass client-ip=52.103.66.59; envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 Dec 2025 09:06:39 -0500
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

On 12/11/2025 10:56 AM, Jay Chang wrote:
> In Bare mode the IOMMU does not perform DDT look-ups, therefore
> caching DDT entries is unnecessary.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>   hw/riscv/riscv-iommu.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 69852f4f13..79eee2e85e 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1312,16 +1312,23 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
>   
>       int fault = riscv_iommu_ctx_fetch(s, ctx);
>       if (!fault) {
> -        if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
> +        if (mode != RISCV_IOMMU_DDTP_MODE_BARE) {
> +            if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
> +                g_hash_table_unref(ctx_cache);
> +                ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
> +                                                  riscv_iommu_ctx_equal,
> +                                                  g_free, NULL);
> +                g_hash_table_ref(ctx_cache);
> +                g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +            }
> +
> +            g_hash_table_add(ctx_cache, ctx);
> +            *ref = ctx_cache;
> +        } else {
>               g_hash_table_unref(ctx_cache);
> -            ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
> -                                              riscv_iommu_ctx_equal,
> -                                              g_free, NULL);
> -            g_hash_table_ref(ctx_cache);
> -            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +            /* Remember ctx so it can be freed */
> +            *ref = ctx;
>           }
> -        g_hash_table_add(ctx_cache, ctx);
> -        *ref = ctx_cache;
>           return ctx;
>       }
>   


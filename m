Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF2EF48C4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjhm-00042J-9a; Thu, 12 Feb 2026 22:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vqjhl-00041s-4i; Thu, 12 Feb 2026 22:18:53 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vqjhj-0006km-M7; Thu, 12 Feb 2026 22:18:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGhI7u7y9mwguUqR51Fezv4fmJV3ewzF55ZE3N7sxBENGeSCmAsdt6rYtQtpw44Edzt1jeYgzMK/hFLzcCcf4N2ZEn/PBspw6IYHXmxdZRGj6IOzFh093bkx7Ag5FxCpW5V3xwkPPXBgvdlHvC5uWfmiiMrEl7S7jbdmjVrYYT05WIAtj4/v29z92zUok49Smc7YcB6kOfC+k0DR2Bi8aDelI50kEC1s+7K42Ccx4uT8FBmwKCty6eU1bypzKCeMcLrOOlKjzdsc/Qjwd7HxaRfN6x8+yqbq6eNpdSgYWSAuRdAf/7x6mE7uBRpaEQhgwp9x1BfrQ+LNJoz7qzlU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sXSFSuPKGldiId8R/bJUEmYZDQeJQa9MC+4ihZd/+w=;
 b=dwIOVLF0c6wUejBMOk2AOkbFWC9BYkJh+8WykJ/KXILUTQC3sfToWaK0lAzs2T+GZpZFZvCjP6PjaMmzzsi4StX8F29XxyGEve8smX5GeRd72RynqAb+m56YkvEnACzZCb7y/EHQf9JFm9d7DQRdZCNq7krLv/QSrk7mR/q2+Iziz6TZI2mE3heHdU0N9VcFh8nNCZCMy0IiuJQyyg6KBlIkP4of73/4oirUcwlj8L5OGworaO5dIVCaRsewBF3COZhExZ5sWq/NYnHHb22My7nHEwkNJOo3Kw0L1Tc4s/D3oRBdjQHsp+UF3yGvB+6CTtbmjXk3EY9RnHfBfoYlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sXSFSuPKGldiId8R/bJUEmYZDQeJQa9MC+4ihZd/+w=;
 b=SvgHCtgXZtRQe9JkYEwYBqXs+05daJFQL12MlKteY8igMRdHWoEXcARhOu6AQsbaAJNk65IZrWDJDF82YFg53/QHUcCmqaOR5ra6L+SQru7vzG8ZDoRVnIz/8APms7YF4Jz7yloJ+A93FoxyNzWzgXdcbm1Pm30sTPDlg1JlekJw2Se4Oya3SC5DsVVjOd/vLdXok+iBFrF8NniP8Cp0Na2fdO8OWnwOwxDkQYxXd6ucyjAYL8jJe+r/QAA3ZJNQAgpX43KDbR2IoW3x7JN7CilGkn+tRtMSpfSZSv77nIZG4NDXawan6izWIVTFp000bAxA2Pga3+FIbCugEEln2A==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSQPR04MB8858.apcprd04.prod.outlook.com (2603:1096:604:428::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 03:18:42 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 03:18:41 +0000
Message-ID: <SE3PR04MB8922CBB7CC00B32968527B44F361A@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 13 Feb 2026 11:18:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] target/riscv: Add the Zvfbfa extension implied rule
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
 <20260127014227.406653-3-max.chou@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260127014227.406653-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::6) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <a10e718a-d5d9-4bf7-9c31-1383091af784@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSQPR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 222ff997-ca22-41da-b928-08de6aae95cd
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|7042599007|5072599009|461199028|15080799012|19110799012|8060799015|51005399006|6090799003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFh4UzNJV2habGNSemszSWNuNUpaSXlPYUprWmwrWkZZZ2dnODdmSGoxbjhN?=
 =?utf-8?B?d0dxUGNCU2hvSW9ha0VZcFBwWnRsOFBUYW8vRks4N2lvbEVadkdya3VJRWZl?=
 =?utf-8?B?ZVV0TjVCMFNTeUVYZ3p5aVp4OEFmY01ld0Q2TURKN1hSODUreldNM0pHTzAy?=
 =?utf-8?B?RDFGczBYK05kSGI1MlZzQ1ZuY1dLc2NGOWdLZlFMUklORDN5R09acU12VlNy?=
 =?utf-8?B?bG5YWUxaN1Y3OExPYk8vYlIyQXpmOWVTVWg5WW44VDZEZDRFY0JNbHQvZTlV?=
 =?utf-8?B?M0tjczhyLzNnTmRkT1BWUHpHZjBRYlZnVkFoUCtFdHBidlp4a3FTV2lKU0k2?=
 =?utf-8?B?SnJweFdJVUlTbmpURUl0b1I5RFNoK3JoTjNBQWhSR1dLaEtKRTJRRzN3WGFy?=
 =?utf-8?B?VFp3S0V6VXhaSWRlcEhyMzd5SGR3ejFYSEh4aTVKMXVFNWsveVlvU0p0MlhF?=
 =?utf-8?B?dk8vMDRQTnR0VDRDbFR3NlJSemdwdExsMWQ4Y0NIcDBYTHZvajMvUjFEOU01?=
 =?utf-8?B?TG12OGdlVVFFZDUzVnN3YllDb1BIUVdDc3Z2ZnF1K0VZVTVFL0lObnk2alUw?=
 =?utf-8?B?MVU2cDJVMXhqaXJCQktTTnJyQ3Z4eExYREtrek1YZm1TeEVZblNldU01c3Mz?=
 =?utf-8?B?UmxHSlYrclNyTTl4aU1OMzZBM0huMURmb28vRTNFcTFGc1Z2Yi9uOTVRNi9r?=
 =?utf-8?B?MUpSdDVRWXJwdzRqUlVrYytYYTFXY0JVQkh0RTlaZklHSHVrN1ZXNlBuMVpT?=
 =?utf-8?B?U2ZYQk9ISk4wVk54b1oyaTRxdEFDcXNwenZRcllpTlVlUElkVitzVDVFeTZt?=
 =?utf-8?B?R0xzaXh2aUIwMEt4M3FkQzNFM2VvRU9Rbkc5NUhTSm1sSVIyZWc0ek1XNEM5?=
 =?utf-8?B?cE1xdzZmVDNubkpGSEIvZGVEM0pFOWJCL1dNQmFGaWQ4bnBTN250djdmNWpw?=
 =?utf-8?B?ZUR3WlRUcVJ4aUpsYXQ5RWc3MnlCdGRwWHRZNGFUVGJQY0MxcmlRZlpjTEtB?=
 =?utf-8?B?NUFmclJZK0QxMTdBaWVuQVVYQkk5dG1hZnhHTWJKblpEemFvTXFiY21TcExz?=
 =?utf-8?B?ZVpXYkRiM2VMMGdWMlRRdFRxanl6eTl2ckN2akNtYzE0NTRlZFVXOUJNT3Nm?=
 =?utf-8?B?Qmp0Rnd3VVJSQytUVTg0aXZ0K2g0MmJtbkJsVGpqblhiVTNmM1NkaVJwRjFy?=
 =?utf-8?B?bEtlYWFRMlBESUQxdnRScm5WN3I2RFlPSEdsVkd1dXViQ2ZXelFTN3RlUDF1?=
 =?utf-8?B?TmFxOFJKOE1XaXd3Z3NnTzB5UVpBbVpyb1dwa3F4eDhYUVhlZHIxNXU4T3px?=
 =?utf-8?B?d3NiQk15NWlVdWl6bkc2dmk1aWgwWHBpYUhyZmdEdkhETnZia2FQclk5ZWll?=
 =?utf-8?B?c0kzRlF1YXNONEN0YWYwSHVHY2tFTVBDVGlHZUZ2Vy9HWmRtNGZoUWliczlQ?=
 =?utf-8?B?dHgvZFZhaTNQWXlOUnBybVQ5WnJ1dWpHRktUQnlTRXZiM3pKQndNRDVVVXp4?=
 =?utf-8?B?L0VuK0p0K05vU2QxUkZINEFNTWFiY095N3pUTjF1MWkxdEYzMHk2dHJlRlBJ?=
 =?utf-8?B?Nlpoc0FUTWFCS0RwdlRDcGgrSGRnbEpweHViM3B1QmNtdWx1NmliWUY1emZY?=
 =?utf-8?Q?Y8mmwX32GF1yt8YBkKuL4DKv7NR2jne6Te5Uvlt+LdtM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hZc2tqcndCb1NOL0FzME9vM2dqeUlLYXRQblhCT0pZR090UHRGcVJWTnhn?=
 =?utf-8?B?Vzh4WDFKS3lRNW5DeENDMWNhK2R5WUZOTUZTSjd6Y0YzbHZGc1IrbEV4OVhX?=
 =?utf-8?B?U1N1K3MyN1BTbG5GV2ZlYm5wb3lYVXc5NGFNT2ZuWVRXN0QrczF2QW52MzhZ?=
 =?utf-8?B?VTFQeFBtdHJIMDVNVEo5NkNTL2JVUEl0NU1ZZTVDdjJ2dXRZT1ZxeEcwdjNH?=
 =?utf-8?B?NXRJbU02bkNjanNXUVRpdWx4YTNWNDFGV0x1OXRHRWQ0Qyt0THdER0E2ZXhp?=
 =?utf-8?B?eUs5VmNjR1hQTG1ra3VycWxuQkpSQWtSc2taeWpvbURMby9KTHpnWk5RRFQ0?=
 =?utf-8?B?empSZWpRanJlL0lvRDJEaXdoc1dtTGp5UGF1dVpvL2FNQWJkemRRQVBETVFK?=
 =?utf-8?B?VEZtN2hCejJXcWJYS3hRUE9wbkdQN3NkbFRkTUoxTHF3T2g2UkJTTlMxTlNx?=
 =?utf-8?B?a0VUN1k2RDRFN1ZoSkR6dTZyZ0h3T05MZXdiOFpnTlBZSk9kaUxKd1d3YUtw?=
 =?utf-8?B?cWJEaGNlWXYzMVJJc0Y4RmVid09XUzhkUWY0NmlBMDY0V3RBeWtnVEgvREFj?=
 =?utf-8?B?NGFPYXd6NTNEQWtTaWlhdXpXdFFVa2w5V1JvdlB0OGpNbGRhbDFURlE4T3Y1?=
 =?utf-8?B?UFhrQmRjYUJFZW0vV1dZa200U0dPTG1xTHRMb0hKeWh6S2RoL0dqOFdFM2dD?=
 =?utf-8?B?d2lxWkFHZjBOY2hMYktvTjljUzV1U0tJQjM0bWo5NVpldXhwUW8xRXlZMlVa?=
 =?utf-8?B?Uk5nZzROenhFN1dIMXpsZ284OGRDYUY1UUZyeU11b01PdVlvVHR0eFlmc3lI?=
 =?utf-8?B?ZDJHOWxiYXJydTlxSnF0b3VETTlIL3p0aVVrZHl4UGgycVkrWEI5N0NKR1FR?=
 =?utf-8?B?VkRzQjcrelpSY1pDSFFYbmphNEN3WWlnL2hhZzRmbEp3SEQrcFhwZVZJendk?=
 =?utf-8?B?UXA3UjMxUVRvZWdVc0hYd3hoRTFvZnRnQUFjZnIrYnV0TkN4Y3V0RGk0RnN4?=
 =?utf-8?B?VDQxQ2tJVVJEMDIzbEJIdzgzRUlSWGQ2K1JhVWFUYnNuckZVSGFsRlRvcnNP?=
 =?utf-8?B?blRnR3R4T0I5TWMyZVlQK1g0WkNObXN2TXlDUTZvNXNrVWQvdDJhY0t5clhl?=
 =?utf-8?B?R0dSTW9haTlCUG15bmFIOGhiSFA0aisrMHJIS1RTNVh4UTE3SExkdDlWK1pn?=
 =?utf-8?B?eUprdDl5S1RkNFdqN2lBK1V6c1JGMzc3ejVBd0NCNDFnc0U0TjhVdUJRTFJB?=
 =?utf-8?B?VTFFQ1JmbThtRVJSZTBoanFiZzRBTzQwR1hZY01GL253R3RnQzJXMis0ZVlu?=
 =?utf-8?B?ZFN1T1VRRFJWZW85bVMvcTNoeXROVWdQWUUzbFBYNTgremVuZ1Y1MlZqK2Qy?=
 =?utf-8?B?NjhvSW5Zc3BRWm1INkxDZzlucCtlN0JZaVZGU1JQSWc5MUo5VkJOc3ZYZ2Q5?=
 =?utf-8?B?YkQ4THBpeHR2SDdSNWJoS1BOd1l6VjkyK2NxOGNHT3JRQnV6MWFWcG12bEpr?=
 =?utf-8?B?NjgxWGRhZHYwY2p6UVRxK0tpcHZWdDliTGdrKythUXFNM1BCODdsZkc1aU5Y?=
 =?utf-8?B?THZLMGhKQnBkWkFDRjVqTFY5ZjVEVVJjWUpFZmpCM3J2U1Z5Mm9sWG1zS21Y?=
 =?utf-8?B?WVlQTmN3cXcwWkJNU0ZRQ21ZcDd3RGNNZzJWdTdqUnd6RFp2Q2Fvb01iMWxm?=
 =?utf-8?B?RGpTeDFoZUVONUpEZENuMnJiS1JkNTdXY0c1TElyK3pYTFZnaGRkM1FKejBl?=
 =?utf-8?B?M24xYWRLVGdZRkVWVHFIdDFrZGdNREFaaE9DV3Q0ajZBSU9wY1JwamNKOVQx?=
 =?utf-8?B?Zmt0NVBQSzVPemFUN29HUEM3RU9wc0pLSzVoZWZLWG5KbjBGUk5ReXBSRndr?=
 =?utf-8?Q?ieKN6ovWH3gLx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 222ff997-ca22-41da-b928-08de6aae95cd
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 03:18:41.2474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8858
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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


On 1/27/2026 9:42 AM, Max Chou wrote:
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/cpu.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
Would it be better to add the patch description ?
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cf237305c5..01cb62bde4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2618,6 +2618,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2631,8 +2640,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
>       &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
>       &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> -    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>       &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>       &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,


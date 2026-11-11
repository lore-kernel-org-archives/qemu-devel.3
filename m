Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD5606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=dIFgs60L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR3uB-0002NL-3i; Wed, 11 Nov 2026 03:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR3u8-0002Mm-Ix; Wed, 11 Nov 2026 03:42:04 -0500
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR3u6-0000o9-2e; Wed, 11 Nov 2026 03:42:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPiv7/EcZSwOwTT7GF4OF4gahIKmd0NfMXytb9E5rBfyJRMgJI+l+6yPTTeoaK1ux8DmYhwAqQUlQnBd4mzylyrGQO5MQzZZPcpS470hqXeIQevl8TK7F91ONlpklEretVH7yJwX4cHks8yckMUDBwf+b2xCkwoFJolpMxiWt7lanBDinfIVOCTCwjQKj0ayxCs1B9kYfVbxbtgb6HQ3m4Pcr9pyMh89B3HplF2i7c77uJBG23i2bpHfGkjkdBJZ3ppsYZl8jwGnrLka0V3g/3M3e6/cpEdilZvrSrNQ4EkKnhjJ1j5RIY0v+OlvkkfAzEWFq6Qi7p0jwRkNYaDNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJyk7bTiRCKYXespneqBQIclfq6ME17slTTXVfZKbJE=;
 b=EK+CGLLB9xf4SVVkhRApNC/MqcEAT7Geju355nk19TaRpUhv/Oj3bYy3ONdLvYMN5LKRPBlIPkeVtvleYOfsHGaHOoTOLL/GjM6XrUINGcatxzH6lpDhqkHZEJq72rEFV3Af78vFh5gtsSrs+6ZAMVo1nMecY4O6k2iJ6FAr97Ko6d2KvqeDbt1/MKYOnlE6MZ9oBlJwbHjuJM6Kp33fDaO+ND/wFSD/hHdJjPEz8rxiaZXbax0zKt9N9/yhyZCtgLxKHZONcNytRM/IURVMajR34/uCPoKX6pnM3Iv2L5cE0gDbO8smJk4wecyTDiuNluLOaRHJ9A59BcxJX/pnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJyk7bTiRCKYXespneqBQIclfq6ME17slTTXVfZKbJE=;
 b=dIFgs60LS8u6p/ml2m1TAhVXyxGQfFIO5tEVTr0mJn2zD6a8eabNMQnDOiyMgPcQCw3w8zqQv1oo/AJqanbtKvHKnJx5D9s8eUwZftpXFNzukzWITavCzznQq7HTJGdPz0qLTpottsol/FKVAQl1sudlhx1S8Imp3GpuJW1OYmi/csxgMq8oyAIkjwdldYqug0X0bvXD6xdmJL7apon1F0IhZUG7o8Dy5DUX+4qkHWaVZrfIAt9/cukPSHrYTw89jyHn/EhT/xLXve//P90zVUlU6UeMtYt6bg+rBJS+v6qpGGROtwRHy2sHCEPH0zqcIf5qjclvDrzcWzFp5+fgCw==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by SEZPR04MB6340.apcprd04.prod.outlook.com (2603:1096:101:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:41:54 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 08:41:53 +0000
Message-ID: <TYZPR04MB7491D242FD1D9B446EF21BA8F3712@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 11 Nov 2026 16:41:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/riscv: iommu: Support automatic PTE A/D updates
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
 <20261108143934.129923-4-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261108143934.129923-4-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0033.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::17) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <e17327b4-babb-479d-a81f-32d3542dd098@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|SEZPR04MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c335ec-d5a4-487b-8167-08df3fcfa295
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|6090799003|12121999013|41001999006|22091999003|24121999003|51005399006|15080799012|5072599009|19110799012|8060799015|25010399006|19101099003|55001999006|4140399003|440099028|3412199025|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3FrWWVRc1JNRFIrc2VUWTJQajV0OU1NUHhoRFBBNjNJekRKcWxXRW1QTkNi?=
 =?utf-8?B?ZTYrZVMyU01WWFhWaHA4NlpxNnAzcktOWGJ2SGtzYjFnbTdjOXFObWc1SFN2?=
 =?utf-8?B?UVpaeXFHWUo5NGF1cnNGakNQZWRsbWFZU1NhVEJkNkRFVGJmTWJvOENHbEtl?=
 =?utf-8?B?ayt2S05YZ1E1bVJkY1NNOUhpWW1GSGVDMmdVelM4MnpJQ0RnQU56dFAwYUJI?=
 =?utf-8?B?MkNtTjBMSEdmWExPaHlYUVVoN3IxRUMzbmVhT3djb3RPejZFNDVpc2RYUGxv?=
 =?utf-8?B?ZTBTYWRHNEgzbVhmeXoyYW5wYlYzSDd6Vmk3azhyVHFSR0lZM2NlRzJrSVNq?=
 =?utf-8?B?T1pFK2RlVGlWYWxaczVkMkhVNndrODBCaG1pb2srMkRDY05wR1hramV1TnNB?=
 =?utf-8?B?My9HRi9RcjB5OE5ZaHJISTFNcVRnMmJXMWtMUmJabEZ2NjQ0T2VzNERzMEM5?=
 =?utf-8?B?aVNhT085T0NYeEU3MTlGTWFJZzRFeUhMQkpNZGVhRFE3THJGRmhhWEVsb0VS?=
 =?utf-8?B?OTRrODlXdERZVC9KT2EwVGRFMWxFN21PamtXTFFOYVBmeTN6R2VvMjRzc1BN?=
 =?utf-8?B?ZEtpZHFZRXJ0cytCTUkvbTJLUVk2Q2c2OTN2S2pyS1NIVHFOSDNSTVV2MkZr?=
 =?utf-8?B?eDhJZ1RXa2IyYU5hcnVVTS9LemJWeFh6UnVlc1QyUlcxQWQyUzVCTUNKb2Fk?=
 =?utf-8?B?Q1lVUmZBQmhtc3JDS1hIcGtQRUNsTkhrdVk4UStMZXpnRUZWZDdrWGp5MlBV?=
 =?utf-8?B?cUhKRS9mQU5ZSjkwdFI3bEcvV20wYUVtZFNiMXA5U2VrYWNHNHdCMGgydFZJ?=
 =?utf-8?B?UHBFMURZeHNva095VDRxUWo3TndkQk5tVXRsVlZHMFhaMUlTdzY1RXRKNjFu?=
 =?utf-8?B?ck13czhpd0VNV1Z6N21OL1M5QlFaMnBhY1J6Z3lac0hDRUdEb0hMbDJFNUcw?=
 =?utf-8?B?RTcvOGY0OUp4RDZqY3hYUUlLM0dOeDhLS2h3TmJsZHFuNkIzYTZNMEJwVVJU?=
 =?utf-8?B?M1h6TXppbk1vdis0UlVVRm43ZWw3TC90d3luZjRrZGxnUi9HajlDNGFKejRB?=
 =?utf-8?B?M3R4aEp3TjUrWkhTUlVUbFNaVHJPSkFQK2V3VnhBUExjOXgvTUwrZS82b21w?=
 =?utf-8?B?OElpanpPeHNEdnI3WWNVdjVmV2xUYXdqRThIbVVYWnh3eWZnSkpZV1hIQmtX?=
 =?utf-8?B?NEdVRExRK24vQi80UEgralpDdUlNNVVZL1NPNmR1dHYveXhGN2VMTDQ2ek1o?=
 =?utf-8?B?bkE5VXdQUnNNZmgvR29tRVNUQWorcS9kYzYycXFNMFp2Yi9RREZLYVVadUVm?=
 =?utf-8?B?N3h1VGh0ZElsZFhXQ01xZlhEMjZXc0hzVDRFVHVTdWFQMGRqTDV1ZG53NXMv?=
 =?utf-8?B?ckJXQlBzcDJtS3hmQlpUcE14ek1wbk5yd0xiQThOT2hnQXlTR2I4TmpnNHJP?=
 =?utf-8?B?MnZTRnJ2Q0NTT1M0ZjhHOWpJd2RJVElRYjhZUkFzMW5uVTFNbk95QnJoalJO?=
 =?utf-8?B?K1ZId1hLaSt6b1E4Z0hnNEFKc25pdnF3Zlc4dS9oTG9RSWZQdmFpU1cwajJh?=
 =?utf-8?B?cXJZZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZkWmJZU3JlQVRDNlJUL3lXclNrU3YxaFRUUmxicGR2bWN2Mm5ZanBPOVJE?=
 =?utf-8?B?MzRIV2NUdWwrYXVzc1A4TWZ0WjNxM2gydUZiM0E2a3lPZHkyR0Q5Y3EyOWdn?=
 =?utf-8?B?b2k1ZTJJU0xVeVpEOWFWS1M3TlV5bzNvSmxjd1VXVUZ0cUJRdU90UTRTREl1?=
 =?utf-8?B?RTFSM3lSYmZGYmVORWpGZXNxU3h5UFExaStRS3Irdy9TdmtaUXVmRXN4MkY3?=
 =?utf-8?B?MHQ4TmdTWjR2amlGcHRhbnlhWWorSGRBdjl6N1NpdWZRM3gyUFIydEJaV0Q2?=
 =?utf-8?B?aTJ1di94eHRCSnEyRmllL2FZRnpRYVRMZ2JxTTYwdVpaZUpEOWVhbFNaYWNu?=
 =?utf-8?B?S1BUWXB1OVB6dUFBOG4xb0FOdks0M1VjaFdHUmFtWm8xa1VqK1J1a1I0cFNN?=
 =?utf-8?B?SCtDRjRQSitNVGNLaVhtbTllREhwaWs3RjBkdHpneTBPdElnUWtZN1ErV2lp?=
 =?utf-8?B?ODhwczFOcUliNll1NGsxSHN4bUxXMjR2Z2xQTEc0WFcyQUMzK3JkVzhvbkc1?=
 =?utf-8?B?cG55dHJlaTQxYmRXcFpTOFk1VTVnRHVHQUFJbmFwcVpCQWR1OGFXVEtkUEZY?=
 =?utf-8?B?K1JpV0lVbmZRcFR4SDhuVk41dVJGd3BCTGZoaHU4WmkyMEp4UnhkcFh5SGh5?=
 =?utf-8?B?VlFGTXpQZnpZMEw5cVp1QzZEV1NkaUxncWhWV3o5RitZdVF3WUZZRldxNTJh?=
 =?utf-8?B?TkU3Q2dJOUt2MUgrc05HZVJuR2RDYjZwUlpKdHZsMDBwQkZBQ2NQaUlVK3cr?=
 =?utf-8?B?Yk9DZ3VqcXBpai9NdUphcVZOTU85cUJoUFRyNDBGQkJmTW9EMzhkREo4b3d2?=
 =?utf-8?B?SnNJblUxUjlwSFBKb0dTUEhhQm9UTkszZGd3dVEzOVd5cWdKREJ6UVJGeUQ4?=
 =?utf-8?B?ZWZzZ21ud1ByZ3RWQnVweGNaZkV6YUgwMUNOUWJnOHJnbzZVQ0s1Q2UxYjgw?=
 =?utf-8?B?QXpaMDA2cnNZRU1GelJuYXRDbzI2QXNJRm42bk9TaFVFRUI0MXk1UE9kcUtK?=
 =?utf-8?B?azFFa2R1ZXNCSXltSlVUOGMwZ28veXlDblBVMFlTUHlHa0lRUWtWSVc0SGJt?=
 =?utf-8?B?VlJhYlhLMVRpVzlhZm9nNTRKVS93bktmaENEYjBGbTZMSDlOWnJWK3pUZmpu?=
 =?utf-8?B?UWdXQWE0RS8zQTZzZzcxTDlIc0xwM3hmY1M0czBDUG9JZkNmOFk3ZHk1YVJv?=
 =?utf-8?B?NGNKQ2lmcWlPc1ZNMnAyNkhneXdNVk5ob0syZW96bm4wZ2VLTThQaUVaTXpO?=
 =?utf-8?B?ckN4elIwMTd5MmJFcG1DNWp0S2p0TndJTEVRK0duMG54YmhQWW9OOGJJZUti?=
 =?utf-8?B?ZVlDbjdnRVQyS3NOb3JvM1M2YjN5bmkvY2Q3bmJhdGJROHJEU0FSTkU4OC9s?=
 =?utf-8?B?RU5mTVgvZUtzNSs1ZDZSRXVabDF1NjhiS29jNEJOY2ZwajgzalBvTDcyWXlt?=
 =?utf-8?B?c1FUcTNzZmRYOElDTE1ia0Q1OWRZZ25IVWZMdjJIdnlFUVZqa2VOWXVJZW9Z?=
 =?utf-8?B?ZGtrWFZIVXZMMEtkTEhONnFxTCtxUi8vcGNkbDBzRVNycW9nWDgyTGxCRnRU?=
 =?utf-8?B?YTJvbFdHbWZWWTRmY1VLUUlCZHhDWGxwOTRSNEpGZmo4TFhqdkRBZWltMlZO?=
 =?utf-8?B?b2FwV1lnbDZ3T29DNm5XeElHemMrWXZNZU9NSW1NODY0WmM5OTRPSGsvNC9L?=
 =?utf-8?B?KzN4SWxZWENrMnZScmJ1eFpxKzBIbkpFNHRpeGpTYmZlU0tzNGdlZFE4VHFp?=
 =?utf-8?B?ZlJkeEpaNEVOSCtYbTh3Q1A4UGZQME5Uenk2Q3Z4V0Mxc0R1OVVQQlhDREdm?=
 =?utf-8?B?Q3R4aVVINHpGL21kUmRBRlpCOWV2VmhDV3N6eGhOVWRjUnpEQUpQSjdzcGhi?=
 =?utf-8?Q?4C5igBmcOwZoe?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c335ec-d5a4-487b-8167-08df3fcfa295
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:41:53.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6340
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


On 11/8/2026 10:39 PM, Tan Chi wrote:
> Add support for the AMO_HWAD capability to automatically update the
> accessed and dirty bits of leaf PTEs when SADE or GADE is enabled.
>
> Use atomic compare-and-exchange to update PTEs, restarting the
> page-table walk if a concurrent modification is detected.
>
> For nested translation, check G-stage write permissions before updating
> an S-stage PTE. Restart the walk if the write translation resolves to a
> different physical address.
>
> Avoid caching write permission when the PTE's dirty bit is clear, so
> subsequent writes can trigger the required update.
>
> Expose the capability through the new "amo-hwad" device property,
> disabled by default.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 196 ++++++++++++++++++++++++++++++++++++++++-
>   hw/riscv/riscv-iommu.h |   1 +
>   2 files changed, 193 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 6760699eb8..04d50cd620 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -265,6 +265,128 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
>       return page_mask;
>   }
>   
> +typedef enum RISCVIOMMUADResult {
> +    RISCV_IOMMU_AD_SUCCESS,
> +    RISCV_IOMMU_AD_RETRY,
> +    RISCV_IOMMU_AD_FAULT,
> +} RISCVIOMMUADResult;
> +
> +/*
> + * Atomically update the A/D bits of a leaf PTE.
> + * Retry the page-table walk if the PTE has changed.
> + */
> +static RISCVIOMMUADResult
> +riscv_iommu_ad_update(RISCVIOMMUState *s, hwaddr pte_addr,
> +                      unsigned int pte_size, uint64_t pte, uint64_t updated_pte)
> +{
> +    MemoryRegion *mr;
> +    hwaddr offset, len = pte_size;
> +    uint64_t old_pte;
> +    void *pte_ptr;
> +
> +    if (pte_addr & (pte_size - 1)) {
> +        return RISCV_IOMMU_AD_FAULT;
> +    }
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    mr = address_space_translate(s->target_as, pte_addr, &offset,
> +                                 &len, true, MEMTXATTRS_UNSPECIFIED);
> +
> +    if (len < pte_size || !memory_region_is_ram(mr)) {
> +        /*
> +         * The entire PTE must be backed by a single RAM region
> +         * for an atomic update.
> +         */
> +        return RISCV_IOMMU_AD_FAULT;
> +    }
> +
> +    pte_ptr = qemu_map_ram_ptr(mr->ram_block, offset);
> +
> +    if (pte_size == 4) {
> +        uint32_t expected = cpu_to_le32((uint32_t)pte);
> +        uint32_t desired = cpu_to_le32((uint32_t)updated_pte);
> +
> +        old_pte = qatomic_cmpxchg((uint32_t *)pte_ptr, expected, desired);
> +        old_pte = le32_to_cpu(old_pte);
> +    } else {
> +        uint64_t expected = cpu_to_le64(pte);
> +        uint64_t desired = cpu_to_le64(updated_pte);
> +
> +        old_pte = qatomic_cmpxchg((uint64_t *)pte_ptr, expected, desired);
> +        old_pte = le64_to_cpu(old_pte);
> +    }
> +
> +    if (old_pte != pte) {
> +        return RISCV_IOMMU_AD_RETRY;
> +    }
> +
> +    return RISCV_IOMMU_AD_SUCCESS;
> +}
> +
> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    IOMMUTLBEntry *iotlb, bool implicit_write, uint64_t *fault_iotval2);
> +
> +/*
> + * Updating a first-stage leaf PTE requires an implicit write.
> + * Translate its GPA through the G-stage, checking write permission
> + * and updating the G-stage's A/D bits as needed.
> + */
> +static int riscv_iommu_check_pte_write(RISCVIOMMUState *s,
> +                                       RISCVIOMMUContext *ctx,
> +                                       dma_addr_t pte_gpa,
> +                                       IOMMUAccessFlags req_perm,
> +                                       hwaddr *pte_spa,
> +                                       uint64_t *fault_iotval2)
> +{
> +    RISCVIOMMUContext gctx = *ctx;
> +    uint64_t iotval2 = 0;
> +    int fault;
> +
> +    IOMMUTLBEntry iotlb = {
> +        .iova = pte_gpa,
> +        .target_as = s->target_as,
> +        .addr_mask = ~0ULL,
> +        .perm = IOMMU_WO,
> +    };
> +
> +    gctx.satp = RISCV_IOMMU_DC_FSC_MODE_BARE;
> +
> +    fault = riscv_iommu_spa_fetch(s, &gctx, &iotlb, true, &iotval2);
> +
> +    if (fault) {
> +        *fault_iotval2 = iotval2;
> +
> +        if (fault == RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS ||
> +            fault == RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS) {
> +            /*
> +             * Per the RISC-V IOMMU Fault/Event Queue format, iotval2[0]
> +             * indicates an implicit first-stage access and iotval2[1]
> +             * indicates an implicit write. Report the fault for the
> +             * original DMA access rather than the implicit write.
> +             */
> +            *fault_iotval2 = (pte_gpa & ~3ULL) | 3;
> +
> +            fault = (req_perm & IOMMU_WO) ?
> +                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
> +        } else if (fault == RISCV_IOMMU_FQ_CAUSE_RD_FAULT ||
> +                   fault == RISCV_IOMMU_FQ_CAUSE_WR_FAULT) {
> +            /*
> +             * A physical access fault also uses the original
> +             * DMA access type.
> +             */
> +            fault = (req_perm & IOMMU_WO) ?
> +                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT :
> +                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
> +        }
> +        return fault;
> +    }
> +
> +    *pte_spa = iotlb.translated_addr;
> +    return 0;
> +}
> +
>   /*
>    * RISCV IOMMU Address Translation Lookup - Page Table Walk
>    *
> @@ -277,14 +399,15 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
>    * @ctx             : Translation context for device id and process
>    *                    address space id.
>    * @iotlb           : translation data: physical address and access mode.
> + * @implicit_write  : Whether this is an implicit write to a first-stage PTE.
>    * @fault_iotval2   : Fault address and implicit-access flags for iotval2.
>    * @return          : success or fault cause code.
>    */
>   static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> -    IOMMUTLBEntry *iotlb, uint64_t *fault_iotval2)
> +    IOMMUTLBEntry *iotlb, bool implicit_write, uint64_t *fault_iotval2)
>   {
>       IOMMUAccessFlags trans_perm = IOMMU_NONE;
> -    dma_addr_t addr, base;
> +    dma_addr_t addr, base, s_base_gpa = 0;
>       uint64_t satp, gatp, pte;
>       bool en_s, en_g;
>       struct {
> @@ -308,6 +431,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>        * effective leaf permission for the translation cache.
>        */
>       const IOMMUAccessFlags req_perm = iotlb->perm;
> +    const hwaddr addr_mask = iotlb->addr_mask;
> +    const hwaddr translated_addr = iotlb->translated_addr;
>   
>       satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>       gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> @@ -326,7 +451,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>        * means we can't do an early MSI check unless we have
>        * strictly !en_s.
>        */
> -    if (!en_s && (req_perm & IOMMU_WO) &&
> +    if (!implicit_write && !en_s && (req_perm & IOMMU_WO) &&
>           riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>           iotlb->target_as = &s->trap_as;
>           iotlb->translated_addr = iotlb->iova;
> @@ -413,6 +538,17 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       /* S/G stages translation tables root pointers */
>       gatp = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
>       satp = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
> +
> +restart:
> +    sc[S_STAGE].step = 0;
> +    sc[G_STAGE].step = 0;
> +    trans_perm = IOMMU_NONE;
> +    iotlb->addr_mask = addr_mask;
> +    iotlb->translated_addr = translated_addr;
> +    iotlb->perm = req_perm;
> +    s_base_gpa = 0;
> +    *fault_iotval2 = 0;
> +
>       addr = (en_s && en_g) ? satp : iotlb->iova;
>       base = en_g ? gatp : satp;
>       pass = en_g ? G_STAGE : S_STAGE;
> @@ -540,8 +676,51 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                   iotlb->addr_mask &= (1ULL << va_skip) - 1;
>               }
>   
> +            /* Automatically update the leaf PTE's A/D bits when enabled. */
> +            uint64_t updated_pte = pte;
> +            if (ade) {
> +                updated_pte |= PTE_A;
> +
> +                if (acc_perm & IOMMU_WO) {
> +                    updated_pte |= PTE_D;
> +                }
> +            }
> +            if (updated_pte != pte) {
> +                if (pass == S_STAGE && en_g) {
> +                    const dma_addr_t s_pte_gpa =
> +                        s_base_gpa + idx * sc[pass].ptesize;
> +                    hwaddr write_spa;
> +
> +                    int fault = riscv_iommu_check_pte_write(
> +                        s, ctx, s_pte_gpa, req_perm, &write_spa,
> +                        fault_iotval2);
> +                    if (fault) {
> +                        return fault;
> +                    }
> +
> +                    if (write_spa != pte_addr) {
> +                        goto restart;
> +                    }
> +                }
> +
> +                RISCVIOMMUADResult result = riscv_iommu_ad_update(
> +                    s, pte_addr, sc[pass].ptesize, pte, updated_pte);
> +
> +                if (result == RISCV_IOMMU_AD_RETRY) {
> +                    goto restart;
> +                }
> +                if (result == RISCV_IOMMU_AD_FAULT) {
> +                    return (req_perm & IOMMU_WO) ?
> +                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT :
> +                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
> +                }
> +                pte = updated_pte;
> +            }
> +
>               /* Continue with S-Stage translation? */
>               if (pass && sc[0].step != sc[0].levels) {
> +                /* Save the S-stage page-table GPA for A/D updates. */
> +                s_base_gpa = addr;
>                   pass = S_STAGE;
>                   addr = iotlb->iova;
>                   continue;
> @@ -552,6 +731,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                                            ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO) :
>                                            IOMMU_RO;
>   
> +            /* Do not cache write permission until the D bit is set. */
> +            if (!(pte & PTE_D)) {
> +                leaf_perm &= ~IOMMU_WO;
> +            }
> +
>               trans_perm = trans_perm == IOMMU_NONE ?
>                            leaf_perm : trans_perm & leaf_perm;
>   
> @@ -1794,7 +1978,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
>   
>       /* Translate using device directory / page table information. */
> -    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, &fault_iotval2);
> +    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, false, &fault_iotval2);
>   
>       if (!fault && iotlb->target_as == &s->trap_as) {
>           /* Do not cache trapped MSI translations */
> @@ -2732,6 +2916,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>       if (s->enable_ats) {
>           s->cap |= RISCV_IOMMU_CAP_ATS;
>       }
> +    if (s->enable_amo_hwad) {
> +        s->cap |= RISCV_IOMMU_CAP_AMO_HWAD;
> +    }
>       if (s->enable_s_stage) {
>           s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
>                     RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
> @@ -2891,6 +3078,7 @@ static const Property riscv_iommu_properties[] = {
>           LIMIT_CACHE_IOT),
>       DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>       DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
> +    DEFINE_PROP_BOOL("amo-hwad", RISCVIOMMUState, enable_amo_hwad, false),
>       DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>       DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
>       DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 403d10b321..8cf228f698 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -44,6 +44,7 @@ struct RISCVIOMMUState {
>       bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>       bool enable_msi;      /* Enable MSI remapping */
>       bool enable_ats;      /* Enable ATS support */
> +    bool enable_amo_hwad; /* Enable hardware A/D updates */
>       bool enable_s_stage;  /* Enable S/VS-Stage translation */
>       bool enable_g_stage;  /* Enable G-Stage translation */
>   


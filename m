Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3EBC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB2kr-0000MR-F4; Mon, 28 Sep 2026 00:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xB2kM-0000IF-FG; Mon, 28 Sep 2026 00:13:52 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xB2kJ-0000lC-1v; Mon, 28 Sep 2026 00:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZSCUmZNlRebR29VFnziu2TKHmR+STThjm9OITr5dOu746fj5/wipxhS795XE9AVqQVWvtamnJHbWgtZ53IPUIJOiFp/9X8fGDCJ45DfsnIca86pzGq11FNcUDl9nz/2cxKrZLuXUAM+Hmznb2hZt//nosJIH3hQiLaO5SGNxg2y6zX21wpxT39KdHi82hSDumewWDiXyjVoX1Ku6xkzZUQvlKK+81F6B9UqX1Ah3eVu10ow1UhCtMRZet2lVtiMEbB8/NXP1/M6DBn3xelW7nhXkl1pKn6g97luPwY6XbI1DPfswY60h+Fu+rLvoJn6f/aquKPexQmCRRqWjwsauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo7En3CfMth05NGleL+1AWiDHLBG4daFLY0vJ4P6o3I=;
 b=UZgjsBdZwRHXxah/SGrvjkl6/6WMw4B0ZzG7Uv7EsToucoryw0k0Vej3IlF5KcjOm0glzS+Aa4lxQ9xxwQhN55xZssQW+OhHIdvRQASOyQ2YAAMB79XICRIenpTkl5nIarc36A+pjvpH5Y5SWb6CTmwIIPdnPCTtjOutdKGlIWFjapQoNEsVB54AD4Ns2ajX5qAYKvox15v29SK0Tbn28jPNM96Guwj6ncWaE9Msw3Avx1oi4eRI4tRsLfCushOn+DYxUA5buzEiRD0FTFxyIR5Q/DiLAjryDzlzvPczyxRNDwZkxfzK2LxgAzQw27Th/LW6HH13+yytAlZm+/xTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo7En3CfMth05NGleL+1AWiDHLBG4daFLY0vJ4P6o3I=;
 b=C22AfDvKJ/GOgorX5SdUgvu6DIq15l7XDc5NvTW4C75aT5X6z1eKmtALhVJpES8IYYR8IvQe0hfoZsTQb2Dau0aPIdhRXWl44NiQsyHjVhhjwO1SBAAvH6OSW/SJfuv/df4AwXBL9l+NZvcETuYKAEMoZwWQZcN2NZ217Cyk7sNUiyV9sCUJDVXzfItvBAAm5ZoH13TTr6vp87T+n0K/xaneQGZmYmX7S93WrfS0bYOvqF2oJxgCkF6hjHOwMiHVtTKKGgUvPBmGwd+H5s6Een72ePSCnD1tmnrDT16VKResig9JIH66OPIiclTGhbLIU64BnF9NGtNCS7ZhGUGGqg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SE3PR04MB9156.apcprd04.prod.outlook.com (2603:1096:101:2ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:13:34 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:13:34 +0000
Message-ID: <SE3PR04MB89221C4FD20AA426C68057B6F38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 12:13:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] target/riscv: add sdext debug CSRs state
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-2-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260909144841.1766921-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0057.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::8)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <701d314d-81f3-4c9a-9759-42116a80250a@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SE3PR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cb491c-f977-4585-2f03-08df1d16dcad
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|5072599009|15080799012|6090799003|24121999003|25010399006|51005399006|4140399003|8060799015|19110799012|16051099003|55001999006|19101099003|22091999003|41001999006|12121999013|440099028|3412199025|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVlrZ0IzZVBWYWRYZ3diS3pEVU90QVpFR3lscXZSQk1qNjlWODlzQnVlWXFi?=
 =?utf-8?B?eVN0eUlvd1phRDFSOFRQV3dTbWxoQW5jbHp6bUxjdTBEOUUycnNSTzhienFF?=
 =?utf-8?B?cWNwN3hoakl6MUFFWm12eWJkQlVPWGRvT2VBWXFpQ3R3b3VGMElaU0d1bzFN?=
 =?utf-8?B?bGRTYnFXVHJYVzBBWkpsN3pycU5BWno5cmkwNjF5aTZWcWZNTzVXT3ZkM0lD?=
 =?utf-8?B?VnkxY2g4V3NtREwwaEhhS3V4OWhkaDlpODV6cE52UG4yem00N2RDRjd0TE9N?=
 =?utf-8?B?d25kcUdmY3hRak5haS9rdmRpSVNNSnpad3E5MDJialhrMTRRU1lYOHErb1Bs?=
 =?utf-8?B?MlJSTmZNakxSWUdtRkt0WjlnZ0IwcTA4dHFtTnJ0OGJkZ0hrUWpGK1Jza1J2?=
 =?utf-8?B?MzkreVIvMEtVdE1XZEVlYWZIbWV4RG05VS9VQmUrMjdxWllQZGRSWFZDM3NF?=
 =?utf-8?B?cXdTdzdNSStUbmRtTHNIMXB6d0VkdWJUYmE1R3hBc3J3VTlDTGZ1WTBYWGpZ?=
 =?utf-8?B?aVJkQ2xDckQ1NHc4aitmRHIvY0M4MEpaalo0VHJoNnZWc25XSjZpZk85ZXQ3?=
 =?utf-8?B?R2RSanB6UGVHQjRJb2V2RUVKb2ZiQm5UNVhiWGMrNXpqUWtRUUhJd0g5WCtV?=
 =?utf-8?B?Wjd5ZG41dUVKSllpbXkydHZmWmNwclBHTUNVR25BMUduWTJBMm1VejB5VGZU?=
 =?utf-8?B?RFczUkpINWcxRVE3d2h4N3U5b3A3dGtZcTRSSXZqM29yamRlU2lnc2orNWhP?=
 =?utf-8?B?TWtBZzNHeGk1YlV5NW9GVHBlRjdFNlFRUkRab2syMFU2N002TUpCVTZpT1FN?=
 =?utf-8?B?NTY2KzA4VVFYcWpqSitZZk0vUDdjelNORTRySEZwWnpyTXVSUWE5N1cwYlBH?=
 =?utf-8?B?aFkyb2ozRkdsRVdIZVZCYzdHVklUcWdPUHR4MmJoRkphUjJiUlJIM3pTbENE?=
 =?utf-8?B?VG9EUGpFRXlUZkNrczlyNEQ4alRxOWdUTVlkUXNmUTk4RE11cUJpbGVWWWF6?=
 =?utf-8?B?bUdJSkVwNWl2UFFuNC8reUlzNzEreWs4YnFNd0s4ZUxLbHpubXVDVjJDQVJX?=
 =?utf-8?B?MHd3YkdOb1dJZzUzMEppb0NRN05BSDJtcmVDZ1oydXZHVHlQV3ZzTVl6UTh2?=
 =?utf-8?B?Nk5sMzR1enR5ajg3bjNRY2FRNVJNSVBROFV5c0tGd2RkWG5JY2dJSGpXN2dZ?=
 =?utf-8?B?NXFBRnJzYVl1T2kxMEtQZW14Y3owTDI2QWlldWtmKzlncDRJdUxWUDdvNHM1?=
 =?utf-8?B?NU1FYXhYaTNscEhhNWY0a3RFSXlwOENhZS9ldHg2d0c1YVRTd050MC9oMG5K?=
 =?utf-8?B?eGRhblRvS003aElKeGV3WGg1MHNkaml4bU5IQ01vR2hJVUpmLy91ek1qYUJq?=
 =?utf-8?B?c1V1Sm02bzFlbURPdHJnaVUwdmZDc0R4OGZObHRyUEhuWlN0UFhLdEpTTDUr?=
 =?utf-8?B?Z1luOUs5dkJuaDlWZ2NtcVlCeEtXUjY5Z2c2bHloSGJmalhwb0J1QjlIS2xW?=
 =?utf-8?B?M1VqSGtGNmovYlpKMElZa3d5RUkraTR3cHB2YlpqdER3LzF0S1oxcWdHQnB3?=
 =?utf-8?Q?AbQ09Y2CrW4Vmr54oLKXzpmCm5VmizCXIhd2KxMvBDy8XZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm1sRWRwS0dnRzJ2czZPaWJkZ2NqNE9pVmJnS3FDdHBMaWhXZGE2NlNnKzlC?=
 =?utf-8?B?VXI0UFY3L2cwNytXeHd3YlE2aG1IZ3pwZ1NTRGNTYjNGMC95ZXYwV1pCU21t?=
 =?utf-8?B?cUdKZjhzUmp0OWZvYldraVd1SGEzMjVZSWdMMDk3eGZjSmd6aUFkYlh2ekI4?=
 =?utf-8?B?d2dOQTFtNjM2ZkQ4NDRFU3I5cDBYeUE5Ritzb3FUNzdKK3I3aEVlUlllTE1U?=
 =?utf-8?B?OWVydzhBbG8vOXAwNDBXTStQRm1aZWRiKzFtWkltMHJWU0hzamhlTXNPZmRC?=
 =?utf-8?B?V3VBNTU2dXhYMXQ0NTNVRGkya3p1VkVweldsak1BOHZjbzllZGhjU01ISW9D?=
 =?utf-8?B?aVFBbHBZdWw4WUsxVWYzaHpLV014bjhIVzFvUmp2d3BNb0FNNVAxQ1M4SU1U?=
 =?utf-8?B?NFMwUHZINm8zZTljaDRXVWptekdzK0U5cUNaNVhodGhRMWJmblBHUHZyZ2JQ?=
 =?utf-8?B?WDdqSVprZ1ZRK3hsVnVxQjZtYnVnNU54VnFVTDhQUHUvSnRaL0lWWmRtcTF4?=
 =?utf-8?B?UTUyMkExTXVkVVNjc0FkM2d6N3hHVkNKell0OE41WFI2bTBBQkNiZzA3SmZE?=
 =?utf-8?B?UWgxZlNDVHpGaG1rOXpCbVI2UHVDUG5MRE9TVGJzRld1WnhHWXczRnI3L1kz?=
 =?utf-8?B?RktmRkNyMW1MWDJZT3lpeHJYK1p0aFVuVGNKbkpLVk82a3NZSlhDUlBFUkg0?=
 =?utf-8?B?WFp3TVZEeWJiMURnQUN0NENvcEpzUUxkZDcxdytkcXY2SVNOOE44dUZOQmds?=
 =?utf-8?B?VHZZc21BTmdaSzI1N3NNWEtpaEhqZCtXeFB3RnVwQkVrZDRWTk55SEhNV0px?=
 =?utf-8?B?c1N1K1VHYUU1L2xobTRBTFhxV2dTWk1aRGNFNFgvOHVWbHR5UW9PcWRWQkFk?=
 =?utf-8?B?cDI1K1k3eXptaGI4RHNCVkgzYndmbytqb2lzR3VCbGFmck1CTVc5bnBVKzcz?=
 =?utf-8?B?QlFldjh1djJ0TEszd3dWZnN3RUd2N2xJODU3dDc0dnlScTRlM2UzOXoxV1Vw?=
 =?utf-8?B?YW92aXlkdGdaWWhHTTM1QWNudXhpU28vYnY0Nk1RdnRsakk3OGYreGtIVm4x?=
 =?utf-8?B?ejh6TGw1SC9ucHpJUUpZMWlrOHoxdEo2SnpRT1RwZ0k4R2NPakhiMmwvcXc1?=
 =?utf-8?B?ejB1T09yN2xhcFZWNU1qTVBoUjJISUFneS9oTGREa1l4Vm5PL1Y0WDN3MkRr?=
 =?utf-8?B?enpoMHpmWlRoZnhpRG9IVnowMHA4aDNlSnNvY2ZVMUVtS2d4WW1TWWVXeitM?=
 =?utf-8?B?V0hFdmZjd0dYQzVRMEpmeGZUSHZyeTg2NFNGdFFEQXRTdy9zdXRMOTVtcGJU?=
 =?utf-8?B?dFZHdHpTdFN0NGNsYWJJRVduUmluTDlNaHU0NEhzRDJMZEhMWVFodit2MGNz?=
 =?utf-8?B?TE5tMy9CODVvRG1aTFNOOGtZQUo0UTExZzkrU3lLM1FuaHZqMzVJTTJrUngw?=
 =?utf-8?B?dW5IZzc2SjlncTg1ZDBPVlN0S29yazBjQ1VGN3pGZElnc3ZIS0hOc0puRTVv?=
 =?utf-8?B?N2NGZ0d2djNJUk8vRm9QenlQSkd2OUVsaFhoaXNic3ZWMm14cjU4eGhrRmsy?=
 =?utf-8?B?OFRyNVh1US9SQU9uamw3RVc2ZXNVSE03NEFuT2lGamdZQW5Melg0eEZXeTNa?=
 =?utf-8?B?UGhER1J4cFE1NGdSOUJhSkZiZjFFYjJaVXFJakVYeTduMjUycnEvK2dzZmRL?=
 =?utf-8?B?ampsNVI4MjFFOE9jNkdQbkVCWWExZFJFVGxhN1BXM3l3NkRaYUlKTkllNUhG?=
 =?utf-8?B?ajdOOGFNR2pZbUE3M2RHemhtaTVMZVQ4Zi9PaUxZcWdYbmV5ZzduaStpL3RU?=
 =?utf-8?B?SkU4S0xqemNiTmVBWnoxUWg4c3gzSWNSeDVsYUt1ZmpVSWcxU3RwTHdva1JD?=
 =?utf-8?Q?4LHmemnm92VI0?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cb491c-f977-4585-2f03-08df1d16dcad
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:13:34.5746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR04MB9156
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


On 9/9/2026 10:48 PM, Daniel Henrique Barboza wrote:
> From: Chao Liu <chao.liu.zevorn@gmail.com>
>
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
>
> Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
> and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
> them to Debug Mode (or host debugger access).
>
> The Sdext is not fully implemented, so it is disabled by default.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu.c                |   7 ++
>   target/riscv/cpu.h                |   4 +
>   target/riscv/cpu_bits.h           |  33 ++++++++
>   target/riscv/cpu_cfg_fields.h.inc |   1 +
>   target/riscv/machine.c            |  20 +++++
>   target/riscv/tcg/csr.c            | 126 ++++++++++++++++++++++++++++++
>   6 files changed, 191 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5fff9d745e..0fe9762022 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
>       ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>       ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
>                                   has_priv_1_12),
> @@ -1091,6 +1092,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>   
>   #ifndef CONFIG_USER_ONLY
>   #ifdef CONFIG_TCG
> +    env->debug_mode = false;
> +    env->dcsr = DCSR_DEBUGVER(4);
> +    env->dpc = 0;
> +    env->dscratch[0] = 0;
> +    env->dscratch[1] = 0;
> +
>       if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>           riscv_trigger_reset_hold(env);
>       }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c2138dbd4b..7b343d7a3e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -507,6 +507,10 @@ struct CPUArchState {
>   
>       /* True if in debugger mode.  */
>       bool debugger;
> +    bool debug_mode;
> +    target_ulong dcsr;
> +    target_ulong dpc;
> +    target_ulong dscratch[2];
>   
>       uint64_t mstateen[SMSTATEEN_MAX_COUNT];
>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index c01050ce2b..769c945517 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -467,6 +467,39 @@
>   #define CSR_DCSR            0x7b0
>   #define CSR_DPC             0x7b1
>   #define CSR_DSCRATCH        0x7b2
> +#define CSR_DSCRATCH1       0x7b3
> +
> +/* DCSR fields */
> +#define DCSR_XDEBUGVER_SHIFT    28
> +#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
> +#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
> +#define DCSR_EXTCAUSE_SHIFT     24
> +#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
> +#define DCSR_CETRIG             BIT(19)
> +#define DCSR_PELP               BIT(18)
> +#define DCSR_EBREAKVS           BIT(17)
> +#define DCSR_EBREAKVU           BIT(16)
> +#define DCSR_EBREAKM            BIT(15)
> +#define DCSR_EBREAKS            BIT(13)
> +#define DCSR_EBREAKU            BIT(12)
> +#define DCSR_STEPIE             BIT(11)
> +#define DCSR_STOPCOUNT          BIT(10)
> +#define DCSR_STOPTIME           BIT(9)
> +#define DCSR_CAUSE_SHIFT        6
> +#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
> +#define DCSR_V                  BIT(5)
> +#define DCSR_MPRVEN             BIT(4)
> +#define DCSR_NMIP               BIT(3)
> +#define DCSR_STEP               BIT(2)
> +#define DCSR_PRV_MASK           0x3u
> +
> +#define DCSR_CAUSE_EBREAK       1
> +#define DCSR_CAUSE_TRIGGER      2
> +#define DCSR_CAUSE_HALTREQ      3
> +#define DCSR_CAUSE_STEP         4
> +#define DCSR_CAUSE_RESET        5
> +#define DCSR_CAUSE_GROUP        6
> +#define DCSR_CAUSE_OTHER        7
>   
>   /* Performance Counters */
>   #define CSR_MHPMCOUNTER3    0xb03
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index f91c780299..24f3606f94 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_sdext)
>   BOOL_FIELD(ext_sdtrig)
>   BOOL_FIELD(ext_smaia)
>   BOOL_FIELD(ext_ssaia)
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index bf203bffce..8658d43643 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -301,6 +301,25 @@ static const VMStateDescription vmstate_debug = {
>           VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
>                                 env.num_triggers, 0,
>                                 vmstate_info_uint64, uint64_t),
> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_sdext = {
> +    .name = "cpu/sdext",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = debug_needed,
> +    .post_load = debug_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -576,6 +595,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_ctr,
>           &vmstate_sstc,
>           &vmstate_mseccfg,
> +        &vmstate_sdext,
>           NULL
>       }
>   };
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index bd4b6dc114..988261cccf 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3207,6 +3207,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +#if !defined(CONFIG_USER_ONLY)
> +static RISCVException sdext(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_sdext) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (!env->debug_mode && !env->debugger) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static target_ulong dcsr_visible_mask(CPURISCVState *env)
> +{
> +    target_ulong mask = (target_ulong)-1;
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!riscv_has_ext(env, RVH)) {
> +        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
> +    }
> +    if (!riscv_has_ext(env, RVS)) {
> +        mask &= ~DCSR_EBREAKS;
> +    }
> +    if (!riscv_has_ext(env, RVU)) {
> +        mask &= ~DCSR_EBREAKU;
> +    }
> +    if (!cpu->cfg.ext_zicfilp) {
> +        mask &= ~DCSR_PELP;
> +    }
> +    if (!cpu->cfg.ext_smdbltrp) {
> +        mask &= ~DCSR_CETRIG;
> +    }
> +
> +    return mask;
> +}
> +
> +static RISCVException read_dcsr(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
> +{
> +    *val = env->dcsr & dcsr_visible_mask(env);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static target_ulong dcsr_writable_mask(CPURISCVState *env)
> +{
> +    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
> +                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
> +                        DCSR_STEP | DCSR_PRV_MASK;
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    mask |= DCSR_MPRVEN;
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
> +    }
> +    if (riscv_has_ext(env, RVS)) {
> +        mask |= DCSR_EBREAKS;
> +    }
> +    if (riscv_has_ext(env, RVU)) {
> +        mask |= DCSR_EBREAKU;
> +    }
> +    if (cpu->cfg.ext_zicfilp) {
> +        mask |= DCSR_PELP;
> +    }
> +    if (cpu->cfg.ext_smdbltrp) {
> +        mask |= DCSR_CETRIG;
> +    }
> +
> +    return mask;
> +}
> +
> +static RISCVException write_dcsr(CPURISCVState *env, int csrno,
> +                                 target_ulong val, uintptr_t ra)
> +{
> +    target_ulong mask = dcsr_writable_mask(env);
> +    target_ulong new_val = env->dcsr;
> +
> +    new_val &= ~mask;
> +    new_val |= val & mask;
> +    new_val &= ~DCSR_XDEBUGVER_MASK;
> +    new_val |= DCSR_DEBUGVER(4);
> +    env->dcsr = new_val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_dpc(CPURISCVState *env, int csrno,
> +                               target_ulong *val)
> +{
> +    *val = env->dpc & get_xepc_mask(env);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_dpc(CPURISCVState *env, int csrno,
> +                                target_ulong val, uintptr_t ra)
> +{
> +    env->dpc = val & get_xepc_mask(env);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_dscratch(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
> +
> +    *val = env->dscratch[index];
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_dscratch(CPURISCVState *env, int csrno,
> +                                     target_ulong val, uintptr_t ra)
> +{
> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
> +
> +    env->dscratch[index] = val;
> +    return RISCV_EXCP_NONE;
> +}
> +#endif /* !CONFIG_USER_ONLY */
> +
>   /* Execution environment configuration setup */
>   static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>                                      target_ulong *val)
> @@ -6435,6 +6555,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
>       [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
> +#if !defined(CONFIG_USER_ONLY)
> +    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
> +    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
> +    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
> +    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
> +#endif
>   
>       [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
>       [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },


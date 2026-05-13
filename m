Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880C6CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN211-0006hx-UM; Wed, 13 May 2026 01:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN210-0006fI-1y; Wed, 13 May 2026 01:20:14 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN20y-0005r9-24; Wed, 13 May 2026 01:20:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhFXyxArK09Ku8Zso9y5WtksHECE4uzZ9kkcC/+mfrwHuSUUz39VmpGfpWZMZupb/c6jnkr12JnWKvSEPba1k2wsEtJsJhv4/Pki2tepzyuZZ33Q4w5u9KiXbYRAk5TT2o8E4ZVoatYdgzJkrTl0hT2S5idSMtu6/w091VbkVm9CNAaNbTjqF6pEuJIepLTDVHSb0JhZcUuZNgtsvHKYtlkewqMVGJbITmKdW64hxqEMO6QoYaTfTH16oVxtZIlzdJLJ0UmVS80YSCV+mw5xjdFz+eITlItSyb0cKiZ5j4E+A29aIQKFnkl+lfLHgQLRy5fyzV8CNuJIDl5wvQQAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcdPi7fr1QbEVziPe/yI7+O214KcwRUOle7/Kzg0hvQ=;
 b=cn/DelwrK8jAlQToZ71Wr93f/hgBdSYNA4NeGIY03HeF0tgbcF2WJFHvI4/qhaBH4tWShaAUOOAddjvYTytgiMW0+hWjqj+CfUg/MXWM/wXVZDdBDFdXP2PcpoYqNc6ba0cyJ5NaJWBDIvHuckZDsWBo+5/HssDhOMjYZM7xoOAf/PjQSROmujtRmf84RNh8yhVct1ndmt+erRvJhNpH3DTliBgwp31hz5srdJhhm6tvOoiLfmieTZJL6N7ojlmxPZ5Wil2I/LKlpXoU5Kp52qwJRbqGZCdD7RJZyJY4YZsxRW+PZu/T1I6yw4TXoyavI4lBEr6nMtr2rcq1jAnCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcdPi7fr1QbEVziPe/yI7+O214KcwRUOle7/Kzg0hvQ=;
 b=i1Bn024uyp2v53GsnlTK6dRp26Fbhcpji4bgMl6Ide0gC8GH0TCBHKRDYsWGJ/T2IlRdgHJ/J7b8eKHRbAZ8HXNKga1LZQ1cBQDBI/PJ72UTY9Vn6nh0NIgfwHm+4s2+BQG2bA9FrQp7sHh905zdBVBJ6FX35ovglDS5RjmHdlbU2kfSSjkoakd36llyzQVir568RkzeOJKSEQvkrgqewtPqU+5dsLxeO0nPxlTr8xPrgdU1WczzqPDfaTF/QxnpP/mTLEyOTeeMW1S+taNZl5PGvQ8aEc71nnfcnHZahCwzWpDtAb3/Gi9Sjf1w2Bty6GPiE+PU8kbWdwUrevG4iQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYSPR04MB8002.apcprd04.prod.outlook.com (2603:1096:405:94::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Wed, 13 May
 2026 05:20:04 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 05:20:04 +0000
Message-ID: <SE3PR04MB8922A4B5EA9E5188DC38BE42F3062@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 13 May 2026 13:19:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] target/riscv: Enable SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
 <20260511124705.28161-7-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260511124705.28161-7-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <4ca4faed-396d-4e6d-b709-712092ed5a6d@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYSPR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c7dab2-6e55-4b0d-4008-08deb0af4942
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|45011099003|8060799015|6090799003|19110799012|15080799012|5072599009|23021999003|51005399006|40105399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWhHV1I4RSs1ZkZDZUhMWTVxb3E4dUk4WGlvUFRMcXNnV3NPRk8zVUcxR1J2?=
 =?utf-8?B?UFhGWFlSdWdFaUxWbXRGekViU01wdittNlVSVnpKbU5QTzRsemxMWlh0WEw3?=
 =?utf-8?B?R2kzQUwxek5EWnpMeGR0NWdrSHczRTZ6TDBXTmRPNmxwcU42U0gweGF6Q2VY?=
 =?utf-8?B?eUl0UkMwYUZaQU9HUWE3clZLaTMyN1NDYXhqcStSanRRQnErWmtLdmE1d3Rm?=
 =?utf-8?B?c3NpYXBVWUM3cEtOSy9ubzlNVU5BL1Q2a1Z3ai8zN3FMRGE5a3k1dzdVN1Z0?=
 =?utf-8?B?Rmk4aEZQOE5iT3M5NGJ0dHVJM0had1N0cUJRenVlQ0wwK0RJb0E1TWJBaThB?=
 =?utf-8?B?UmJyUHNzZGo5TXdnSUw5alFzOHczTjhwT0N0dTN4NEI2WFZTTkErc3FCKzZ2?=
 =?utf-8?B?YjVJSml3N2h0RXdvbzQ4ZTA5NEJ0MVRDbllIU1hCTjU1cWtyMUJ3L1JWR3NX?=
 =?utf-8?B?SGU1MmdWMmMrNWtmQ1JuQ2lMbkdUN28yWjczcWxzR2hodnF4SGwzRXp3cmhK?=
 =?utf-8?B?SlR6ZFFZMnUyNktvaE11MnRXRDhqdkxzSVBWS3RKTVVURWZFVUpiR3R1YS9m?=
 =?utf-8?B?dGpOaHVPYXZyUWIrOERvN3dwNXV6Y0kwMTEwdXJmK1VOSHV6WWc3d2dHL0lW?=
 =?utf-8?B?QmgxZDdpY3JwZk1tMlpVOWVQK2o4dHk0MHZxVERmRWFkaHh1emZtQy9oemJW?=
 =?utf-8?B?SzhpdzFYQkJ4VVRhMXI0aWJzMHJnbVhkeERTSG83dEtYV2hLVm1Ock9KZVZa?=
 =?utf-8?B?ZEU1SEk3S1pYRDl3SEx3a0xzRFpzZzM1bGI4djlBZVA4L290dW1NT00xS3pa?=
 =?utf-8?B?RlRpS3JQelFtKzJyZEJXOGh3MUhDZTRQV3B0YmNsTUpRSVovZER6Y2RKbEEr?=
 =?utf-8?B?bWdvZUxmSVZBa2NNeFlTUVRreGpGZUhhM1FySC80MTJ2OVd1NXR4Zms0Q0Q5?=
 =?utf-8?B?aWZRb3hkMFRRRlRENDlDM3J3aFJrWDI5bjNjTTFhemxxaWpvQkVjSUhQaXZB?=
 =?utf-8?B?Z0hKVG5mYUw0b3Zxc1Z6a3ZVbWsxTndTbzRueFdjcGE0WlZxK010OThlUzhn?=
 =?utf-8?B?UTVEVEMydzRaemJTazlKRGdIaDFpMHhaZFNveDFJOW9haE84WURTb1lJWGxs?=
 =?utf-8?B?bUJiNzJPZkJWTHM3UU5rV1ZiM09JaUNxYzVMZTRnTUVOZXJ1VDJHbVQ5YkFr?=
 =?utf-8?B?ZTIzekJBV1hLekR2MXV4OHhVUHBaQlg3SWd5d1hoZVFPcGNqcnpSQ2tLUUtT?=
 =?utf-8?B?NmhJdEpUQXcrVDhuZXh3M21KU1ZicTVyYzJDN0EvcFl2VnJyM3NlMmZWR0Y4?=
 =?utf-8?Q?sEWuAYAtGcvAuUPZlKJPxfgCLwZ5osVAno?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3Q5OTNqZ1ZhQzRlSzQ2ZEpoL3ozU043MVdkb1BCV0FIREphbTZqdUZYd2ZU?=
 =?utf-8?B?cE5HSklQSmtOSjhtNFlQSy8rQlB2SXdyMXRZOHpvbVV1dE9mejRXK1VLL1Bl?=
 =?utf-8?B?ZXFTbXBQdjRKUkJFNWQ1U21aQ1RRV1R1T0hKeVo2NlJPWDl4ZVJGWmFxS0xX?=
 =?utf-8?B?cUNiRXppRGdwTHE4ZU9DU0V4cGxaQ3J2S2dlZ1VDTHVVN2RaWnZxOE9wM0w4?=
 =?utf-8?B?Mk4xaVYrMDQ3WXVvUE1SSVc5UzRWWHJrSCtvMVJ0T2crVXZvYWVnQkRLOTg4?=
 =?utf-8?B?UTA1Q0dTQ3luZ0tqM1E5bXp3ZWdKUlFBSy80TU9UcExiOHZXeUY1b1cybklU?=
 =?utf-8?B?ZVVXNE81VEpMZ2pFeGc0NzRjU3Q2cW54K0ZTT09SOTN5SlRmSm15eE4yQ2E3?=
 =?utf-8?B?M3NxU1lSckhSR1N5WjR1UTJncEJOWjBWN0JvdW41bmR5bEpMWXZHcWY2dFpa?=
 =?utf-8?B?VnlwdmdrYkhkK3BlTXIrRk5HU2JOT0FHdEpRaWtSTFl0SDZ5YkVPRWI2eThw?=
 =?utf-8?B?bFFFOXVMM0ErcHZFNy9leHZsbXhDWUIzdmxSMnljWWVFWjg3QlhRNlM5bFpj?=
 =?utf-8?B?clpjZUxZVmpPUXN2Qi9tb0x0Wng4eVFRWnVEUFBHWXo0SXBZeWdSL21uamlh?=
 =?utf-8?B?Y1V5c3lWQWV3NWdZT0tGa1FubVpwMDg2OHNZa0gwNVB3MDYwcFN2MHVkNHRN?=
 =?utf-8?B?M1hvNVF6eUJENDJ6R01aMVYxRThZRHg2UERYazBla3orVjI2RVpiTlZVR1A5?=
 =?utf-8?B?TUNqdHBGQTBXZlhVb2VGU2RFRTgreU1XS3ZiVDQ4VTZxbkdqajdxZUFjRXdW?=
 =?utf-8?B?WU90OEYwWHpSSkxpV0pYNFcyU0V3VlpEdFp4Si9pUS9aVk84ZzUrTmJCa3lZ?=
 =?utf-8?B?dm5kcXVvUmNFRS9oWUhRSW5MbjJWMjBscnhqaUpVdUJYcHV1Tjk0TXdFcmZq?=
 =?utf-8?B?a3Z3Uk9Zc0lEV1FmL3dYWjFnTHR2NzdianRrTXp6S2ovdkVPYVl2RWJla1dN?=
 =?utf-8?B?clovN013clBOYzNsbXFNeGVFcDAvRUZXVm5xMUlFNXlha3JzK3hPZk9PdUlh?=
 =?utf-8?B?bFhzZG1GcXdCSWlabitxZ0ZiZVhMcFpPUW9LQjBIajBxb2VCTk0xTFJ1L3Fr?=
 =?utf-8?B?TU9WOHV5cytzV3ZIWDcrZThGVnRJNzl3cnp2RHBMUXg1SjJUdW8wYVRjbVV3?=
 =?utf-8?B?Q3ErWmxSbkpjMkVyVHhhczlkVTRoWlJxOExMdjVKREI1TVd0TXI2Smp4NlJw?=
 =?utf-8?B?ZFkzK0I0Unhjd3ByUWRuc25qb1dTVDVtekZpdml5YkxjRFlNM2tJaHpQem9X?=
 =?utf-8?B?Tlhhck5KNGtnSEZMVG5relpoTEhiZkxHTm15RllCMzlqa05aU2tRM1N2bjdX?=
 =?utf-8?B?UytqQnpJdWxySXozbVhzZEhSSUgzVGUyUGtuWWJKUStNMzBCTVRGeTNQTXYy?=
 =?utf-8?B?WUVFNDA5NlBsV1FPRExhM0FwRmxFZTUzSHBaV1BlazJGbXM1K2U3dWIxcHpW?=
 =?utf-8?B?dUZsd2lmNVlUWFFrQ2tZK1h5ZDQ0c0ZXdi9ETytISjZzMDU1U05sUGJsUHM3?=
 =?utf-8?B?OUQ3UG9yNyt3L0R3SmxCU1JTY2NiQ0FQV0xWQVRzWTUrWnRWSCtTMGVXR29G?=
 =?utf-8?B?aFd5MXNONXZWeXRMaDV2cllPMlFmSHdtNlFkTUVFN3FsWGVFK1U3T20vdmxk?=
 =?utf-8?B?aTN0ZjlNZ3RZSDgyRnY1aFpicFJIangyVWNmVTNDbk5EUURLV0RQM0RvMDY2?=
 =?utf-8?B?SFhxaVBrSCtWMVlmMWE1Z0dYRHI2Z1ZHMVNxdHdBNW13RVV2QURwTFJFNU1R?=
 =?utf-8?B?UTl3ZnkyL0ErN3hYdC9YVS9scFZ6QVhYME1XdTdmV2RCdkFETVBzUjJpOHYx?=
 =?utf-8?Q?MvquUSUtfEizA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c7dab2-6e55-4b0d-4008-08deb0af4942
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:20:03.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8002
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


On 5/11/2026 8:47 PM, LIU Zhiwei wrote:
> This patch implements v0.3.4 SMMPT
> specification(https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index dd54c2fa1e..31e59cd081 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -226,8 +226,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> @@ -1383,6 +1385,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>   
>   /* These are experimental so mark with 'x-' */
>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
> +    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
> +    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>   
>       { },
> @@ -2633,6 +2637,15 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule SMMPT_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_smmpt),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_smsdid),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2652,7 +2665,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
>       &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
> -    NULL
> +    &SMMPT_IMPLIED, NULL
>   };
>   
>   static const Property riscv_cpu_properties[] = {


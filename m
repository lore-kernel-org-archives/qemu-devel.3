Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B915BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEeU-0006kf-KQ; Mon, 27 Jul 2026 02:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woEeQ-0006il-8b; Mon, 27 Jul 2026 02:17:22 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woEeL-0007Fd-Gr; Mon, 27 Jul 2026 02:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkY1CrEnkINsE8h3FzBE3jdtXJVPq6XSicPfeo+mr1grNSF/a2zdGv6PBMvgYks3xpf5cHMLAtG+fhsGYuKw6vT07s7l3mHqfOLnA1JqWFtX0b+uOusOoTy04sOf9Dbst8vGqSF6IeECRoegA6x3OJAc/ShREvuhA34oedwTZE73YfvYM6CzsFgLz87kx1E1QH4nb/Ashd9v23d4E8A6UFI3xQUSP3wza0pbjGhE6CC6pbvltQfs1waoPVnTPogRdV8I9Da4JAhxCzRToEfz3ucZcol0JwgCdDbe2tAUKjyv6c4cgn3opTQibhUZwVYhpcjUyZaUfzRHU3vcPmXjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/wWft+k4peG9mWJm08bD1hnGp7Aw+4AnYphNZjxWto=;
 b=H2KvwQ4NbxeiR3dFLwGEx4HqIHOG8UYInUzLgzxDuz45LRrFD19h7pwgkd0dl4YZu6Nz5/gQ4PSS1WzQj4jqRENhsJ1G4DRF7HTog6rRxulgD3sW94p9exvj6NQ/acl3tSGLxOXBX1iMWiQlemYWxoJZr0t98FXd9Hq3U86+KkqbMBrIJs4HP7frrwhYTMH1egTLTf1kGL4MknEhhhSWWcKWVQVQzTbb51fz0i6kGjYjCxifhoUW9AqZEaRZJEwNm8bJEkaIXHRHs/IbgB/a/ECxi7GhcgLBf4CvcSBXhtLrxZytf6zhrR9VXjeFyrFUoukhdK/VZcseFSvEbfc5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/wWft+k4peG9mWJm08bD1hnGp7Aw+4AnYphNZjxWto=;
 b=SjCpaM5i557j50rMFwq2I5UysFFuYA/NVKDlfPtV/z5/xEqePbtxorNEnvZXcM1qkunIe3PvRr9jqwPn6xXfewcLKq3iSQYMtx75mVnqqo/SqCPZOML1u1whLhPvSuX7Ub5YZxBAnVk0qAUAhINzIdsvYjMKyclCkoki5WPMKeukztAqdLgq0kWEmjS0yAf7lkTlmkvcGRg+mx6eY+8+0ayuo5P5r+sKZij8LLL2cNIvSW7KojiG1os3nX4JX5tJYtkN2j+TUKhrFrvLYSeflLfQKKsHsc2zgYZ6w/bJtmPbvoOr1tbKV09Kfv+pm+lEjDb0+Od9LknbeJt7BxqVCA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB6921.apcprd04.prod.outlook.com (2603:1096:400:33b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.9; Mon, 27 Jul
 2026 06:17:10 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0270.006; Mon, 27 Jul 2026
 06:17:10 +0000
Message-ID: <SE3PR04MB8922D8CDCA7F04FA5F4409E7F3CC2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 27 Jul 2026 14:16:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] target/riscv: Add packed SIMD helper framework
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <d19adffe-58d9-437c-a471-b2c6efc6c3d1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: f7646cf9-33b1-4454-6840-08deeba6b0ff
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24121999003|22091999003|6090799003|8060799015|19110799012|23021999003|41001999006|15080799012|19101099003|55001999006|4140399003|25010399006|5072599009|52005399003|40105399003|26121999007|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDhWdC9RcXpGcXdRNDI0bG8xWkVZTXlNWHpRY040dklIb3MxSmh4WkxUUWE2?=
 =?utf-8?B?RkRWa0ZDVC9nbitEdEdYckVybFlhYmpvZHpjenF5MnVqaDNQa0FYU056Uit3?=
 =?utf-8?B?dzkzeVM4eTFOcWh0bW1EWnpFZ1JHMzhRTzZOZlZpU0dXcHNQUC95bjN1cFlP?=
 =?utf-8?B?UFhrRDR6VVlya3oyZDRoSTdNVGJGaTF5cjFPcWlVM0huK3lpK25YNS93bkVm?=
 =?utf-8?B?N01pTnBUQUFTWUtVdktYKzZiQWcvcDFkVk1TS3RaZnQ3UlEwVkRIdU5VYThR?=
 =?utf-8?B?MlJrOUlWVWRFREJzcmFBdnlwWEcxczBtWFpVeC93MDhDYUZPcFJNRlI2akU0?=
 =?utf-8?B?cEFkMXpsMkV6QW50b1htWUlXQk4rZitQNmJlZUJlc0EzVzlPZklFdEoxOVhP?=
 =?utf-8?B?bTJ2R0gxbGNtRlQ3NDNtbXpWVGVqV0hMVTFXMTZia2pNQ0RvUVFxM25sMkhW?=
 =?utf-8?B?NDZtNjNzMDFncEt2QWVnWTBjRUE3SlFGeEpQOWFRUm5vTzZBK0h2MmU5WU01?=
 =?utf-8?B?M0d2cktQUjVMYXlIbnJTTnpNcGc4WFVNb0NZMU5DUkUwQmh6WldpaWN0OVVP?=
 =?utf-8?B?cktWbEJ5SWMwQVdMY1pmM0dXZjU4WmROU0YwenY0WDRtc3FPRDhuR2Y3NHVp?=
 =?utf-8?B?OE50N2lkVEs3UXZ3MEZ6Z3BOVGpZQVFZaU40WVdaTm5QaWgwRTdDUW1XRWVF?=
 =?utf-8?B?VGNRdGx0eC91OGFYL3ppWmlhR3JzVVR5bm9yTWQ3VlcvZzJsT21aNjIxTHRG?=
 =?utf-8?B?SWN6TDFxUDh2OTdLb3FQTi81YzY4ai9iV0xyUDl6bVdvL0tkNGdlS0h1akd4?=
 =?utf-8?B?S1U3ZFljNjVNUXlrVkVsbStSZ3A4clF1ZFlaR2tuVXZza1BjRWZ0VnM5K3RG?=
 =?utf-8?B?eXIxSk5TRFBaOWZEMHM1OXBwamdTcmNEMjdneDJyU2VHYTNMMkJ6R2pzcUZI?=
 =?utf-8?B?WWRFRWsvaE9xNGFaUTVHYUJyL0Rlc0ZLbWJBTlllVUJpRVhNUWt2TDQvWW1y?=
 =?utf-8?B?ZjM4RTY2SkNzM29teEF6bFpTc05WRUIxTFBhQTIvT1FIYlVGNjlJcjlDcGRH?=
 =?utf-8?B?VkFNYzVuYy9yV0kxL21DWG5jYnNVSEdMemNEVS9NT2NvYUJvVjJCMkJoUXIv?=
 =?utf-8?B?K3ArRksySHZ4Qit2cWhwMTN6RkFxWEtIL1ZRd2JPQ2t5K0NYWGxCZVRWY0p6?=
 =?utf-8?B?cGdGSFFqWUZ2cmc5T09QMDVpcnBXSXNYQXNCbi9EcVhFSkhoRThhREtsOUFY?=
 =?utf-8?B?YzdEN1NRSUtjWnpIeUVBR2orSW1LM2U5VE5hRnBheW1OMXJCY2Vta3FvNTVC?=
 =?utf-8?B?OCtDUVZKTXk5dDBmYkNMelBScVN1TW95MzhyOFRXeFlmZDA3d3NZTlp4bVRm?=
 =?utf-8?B?VmFGM1ZGQWhUV2lLSTNCMndUQUFoeTJmQldicXhpN2x1LytvMTlmc2p3WndI?=
 =?utf-8?B?UytVMzUwN3pmL01jUE9NeHVSMHE3SHJrV1k5ZC9TbXhYcGs3TFg5S3dORU9v?=
 =?utf-8?Q?rKrZZLwyvHhOakR5HX+lLC1A4cb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3NDQ0RQWWlwVE1wU1NxWGpLdWJTSGg0UjEyRnFhYTdOM3FWd3ZoZkVFczdR?=
 =?utf-8?B?NFVmbVRNa0NaaWRzWThXckwrbGRPaWQwbExzN2tweTQ0cU5tR0xPR3M4N3Yw?=
 =?utf-8?B?R1VJMjZWaFVoTEsxR0J1MnVsdEpwS3h2UTVVYXk2YTdLRWI0djJMR2pZdDdE?=
 =?utf-8?B?cHppTVJYenlkSXd1ZmZQL3VycDg0SzI2YmhLQmVYOVF4R0o0dk4rcVRKeVNl?=
 =?utf-8?B?OVpnREpaVHhWOWxUeUM0YmlrcElQQXA3TUhGVFBXMWx2ZTlGekgzaE0rTldJ?=
 =?utf-8?B?M01hL01GeExtU3BIeGRLNm9jNlpPVndCUVk4V1JldGxDMTlsSWU5TWx4K3Bo?=
 =?utf-8?B?MDBHWm9nYS9iZy83MS8zQXlmNktURWpUZEhGUW1rbmhSd3BmTGJwQmpMVTd4?=
 =?utf-8?B?eWhabGVjTm1OWnVKamVjcTBjRjE4VXFEeXZoTUpRNTRWQW8zRjEvZ3hKUldn?=
 =?utf-8?B?SUhSTmpDcE1tUVlQK0dMbFdqMUxqWWpKY0Z3M1RMcVFHRmw2TTRrdkRTa25t?=
 =?utf-8?B?eG1tS1dYeGJVd1l6eTkzaitGcWVmdGVkR0dicm1EUGtmYVRYUnhWOHFRVDlo?=
 =?utf-8?B?MVNlbHBORlVtV3FVYiszb0lWYW1tTTRGRnRQUWl4bmR3SUNheFdvamNnUUFj?=
 =?utf-8?B?clpmVG1PV3c3RnBpRC9xaGcybkE4Z2dRSi9wNlhIak1YclU4ckpScEdxejkw?=
 =?utf-8?B?UEtacGg3MVRtYWJvQU9ad24rcGRja3ZaM0tnSlZvYkZpdVZqcU5jWWVRKzZ1?=
 =?utf-8?B?ajUrVDd2VnhETldNMDFDK0pJR0kzMW1yTCs3MWpaRWlBRXZjQWlDS3lIWS85?=
 =?utf-8?B?K1RWeDFlckd3REZwTG1mdVNOdFRlU2E4Zk10c0xCWDFwRVROcGdVMGVZT041?=
 =?utf-8?B?R3JwZ1dsU2Z5NThZNWlFRlA4MU1SQS80eUZ0MVhhR243K0lScUNVdmp6cFha?=
 =?utf-8?B?c2dMOVM0dTBnVUJ4VGl1U2FYN1B0M29VWlZVZ09HTUo1KzJ2bmZxUjdHRHRE?=
 =?utf-8?B?eEhUVFcxNU5MenRhOU1TVStKVTJhbkdsdWV4VmVqUGh5Z2dOVzJBenFOWTRY?=
 =?utf-8?B?Tjg0d3NtREtMSXV4ekFPeUd4K0xtNkhsSktHTDlNampYMnNuY0VLY0dKUFZH?=
 =?utf-8?B?RmFwdklUUnYraEJOaTZiZUdBK1RjRkdFVGI1dWwvRVlWbVFZZGVsQ3hVUUNO?=
 =?utf-8?B?ODVjaG1NQ2FrL0t1SER0UFhBRE5kMVdWK0ppNndZSDMzbTlvQzM4Q2NJL2pK?=
 =?utf-8?B?ZDhxUGdTZVZBT2R1T1VqK3hwbjB1TmdPbkoyc2txendycFZhSHQrWlExcUti?=
 =?utf-8?B?cHozc3A5dUZ6WUZsNkdBRDdGVVBveHBnVUpmVDRJRGJ4WE54UXNZZlRpbnpW?=
 =?utf-8?B?OGc3S2owclhKeWFtTlg3KzVwNzJTYU5kWjJOREt4S0xkc3FOeWhMajVRRXRO?=
 =?utf-8?B?Q1hGTTR5V1FiNll5OVdoZDVobHV0TUNOMVpnNUxuc2E1dkRwcW1yM1JJWC9a?=
 =?utf-8?B?OU9QeUtCdGNPNXF1dFdNVXo4QjBuRnAySi9KeFRPaEhybFduOTVNZzZLeW05?=
 =?utf-8?B?OG5Ndk5sdE9WME9qVGVjeExSVUcwUFFvai9CeEhnakkvcXVKYW5SalVISTNB?=
 =?utf-8?B?TDd0VFo2ZEovNzBBT1EvYzdDNTY1RzgySktlNGRUTFNLd2FzWld6NlZ5dngz?=
 =?utf-8?B?SHV5S2ticTBvVDdVeVFwOHA3ZFV0MUJsbzN6RFkyYTdDU0tnMTlQYWE2VjRX?=
 =?utf-8?B?WFUrU2ErRWxPNFAyaDRFczJWMWdYMTExR2VxSHlWL3k3UVR2akNIc05najVB?=
 =?utf-8?B?SlhSajAzTGZ1WXBxSjZ5RFpLUysvdlcvQmVHektpRnZqZnlHVG9Iclg2d2o4?=
 =?utf-8?Q?Ak9IuFjghOXEV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7646cf9-33b1-4454-6840-08deeba6b0ff
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:17:10.4575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6921
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


On 7/17/2026 6:06 PM, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
It would be better to add some description for this series.
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/tcg/meson.build    |    3 +-
>   target/riscv/tcg/psimd_helper.c | 1656 +++++++++++++++++++++++++++++++
>   2 files changed, 1658 insertions(+), 1 deletion(-)
>   create mode 100644 target/riscv/tcg/psimd_helper.c
>
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index a05ab642f41..cc438d7c0d2 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -15,7 +15,8 @@ riscv_ss.add(files(
>     'vcrypto_helper.c',
>     'vector_helper.c',
>     'vector_internals.c',
> -  'zce_helper.c'))
> +  'zce_helper.c',
> +  'psimd_helper.c'))
>   
>   
>   riscv_system_ss.add(files(
> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
> new file mode 100644
> index 00000000000..2948bbb2a86
> --- /dev/null
> +++ b/target/riscv/tcg/psimd_helper.c
> @@ -0,0 +1,1656 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* RISC-V Packed SIMD Extension Helpers for QEMU. */
> +/* Copyright (C) 2026 ISRC ISCAS. */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "qemu/host-utils.h"
> +#include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> +#include "internals.h"
> +
> +
> +/* Helper macros */
> +
> +/* Element count calculations */
> +#define ELEMS_B(target) (sizeof(target) * 8 / 8)    /* byte elements count */
> +#define ELEMS_H(target) (sizeof(target) * 8 / 16)
> +#define ELEMS_W(target) (sizeof(target) * 8 / 32)   /* word elements count */
> +#define ELEMS_D(target) (sizeof(target) * 8 / 64)
> +
> +/* Element extraction macros - unsigned to avoid sign extension */
> +#define EXTRACT8(val, idx)  (((val) >> ((idx) * 8)) & 0xFF)
> +#define EXTRACT16(val, idx) (((val) >> ((idx) * 16)) & 0xFFFF)
> +#define EXTRACT32(val, idx) (((val) >> ((idx) * 32)) & 0xFFFFFFFF)
> +#define EXTRACT64(val, idx) (((val) >> ((idx) * 64)) & 0xFFFFFFFFFFFFFFFFULL)
> +
> +/* Element insertion macros */
> +#define INSERT8(val, res, idx) \
> +    ((val) | ((target_ulong)(uint8_t)(res) << ((idx) * 8)))
> +#define INSERT16(val, res, idx) \
> +    ((val) | ((target_ulong)(uint16_t)(res) << ((idx) * 16)))
> +#define INSERT32(val, res, idx) \
> +    ((val) | ((target_ulong)(uint32_t)(res) << ((idx) * 32)))
> +#define INSERT32_64(val, res, idx) \
> +    ((val) | ((uint64_t)(uint32_t)(res) << ((idx) * 32)))
> +#define INSERT64(val, res, idx) \
> +    ((val) | ((uint64_t)(res) << ((idx) * 64)))
> +
> +/* Saturation constants */
> +static const int8_t   SAT_MAX_B = 127;
> +static const int8_t   SAT_MIN_B = -128;
> +static const int16_t  SAT_MAX_H = 32767;
> +static const int16_t  SAT_MIN_H = -32768;
> +static const int32_t  SAT_MAX_W = 2147483647;
> +static const int32_t  SAT_MIN_W = -2147483648LL;
> +static const uint8_t  USAT_MAX_B = 255;
> +static const uint16_t USAT_MAX_H = 65535;
> +static const uint32_t USAT_MAX_W = 4294967295U;
> +
> +
> +/* Saturation helper functions */
> +
> +/**
> + * Signed saturation for 8-bit elements
> + * Returns saturated value and sets *sat if saturation occurred
> + */
> +static inline int8_t signed_saturate_b(int32_t val, int *sat)
> +{
> +    if (val > SAT_MAX_B) {
> +        *sat = 1;
> +        return SAT_MAX_B;
> +    }
> +    if (val < SAT_MIN_B) {
> +        *sat = 1;
> +        return SAT_MIN_B;
> +    }
> +    return (int8_t)val;
> +}
> +
> +/**
> + * Signed saturation for 16-bit elements
> + */
> +static inline int16_t signed_saturate_h(int32_t val, int *sat)
> +{
> +    if (val > SAT_MAX_H) {
> +        *sat = 1;
> +        return SAT_MAX_H;
> +    }
> +    if (val < SAT_MIN_H) {
> +        *sat = 1;
> +        return SAT_MIN_H;
> +    }
> +    return (int16_t)val;
> +}
> +
> +/**
> + * Signed saturation for 32-bit elements
> + */
> +static inline int32_t signed_saturate_w(int64_t val, int *sat)
> +{
> +    if (val > SAT_MAX_W) {
> +        *sat = 1;
> +        return SAT_MAX_W;
> +    }
> +    if (val < SAT_MIN_W) {
> +        *sat = 1;
> +        return SAT_MIN_W;
> +    }
> +    return (int32_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 8-bit elements
> + */
> +static inline uint8_t unsigned_saturate_b(uint32_t val, int *sat)
> +{
> +    if (val > USAT_MAX_B) {
> +        *sat = 1;
> +        return USAT_MAX_B;
> +    }
> +    return (uint8_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 16-bit elements
> + */
> +static inline uint16_t unsigned_saturate_h(uint32_t val, int *sat)
> +{
> +    if (val > USAT_MAX_H) {
> +        *sat = 1;
> +        return USAT_MAX_H;
> +    }
> +    return (uint16_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 32-bit elements
> + */
> +static inline uint32_t unsigned_saturate_w(uint64_t val, int *sat)
> +{
> +    if (val > USAT_MAX_W) {
> +        *sat = 1;
> +        return USAT_MAX_W;
> +    }
> +    return (uint32_t)val;
> +}
> +
> +static inline target_ulong psimd_abdsumu_b(target_ulong rs1,
> +                                           target_ulong rs2,
> +                                           target_ulong sum)
> +{
> +    int elems = ELEMS_B(rs1);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint8_t diff = (e1 > e2) ? (e1 - e2) : (e2 - e1);
> +        sum += diff;
> +    }
> +
> +    return sum;
> +}
> +
> +#define PSIMD_DO_ADD(N, M) ((N) + (M))
> +#define PSIMD_DO_SUB(N, M) ((N) - (M))
> +#define PSIMD_DO_ABD(N, M) ((N) >= (M) ? (N) - (M) : (M) - (N))
> +#define PSIMD_DO_EQ_MASK(N, M) ((N) == (M) ? -1 : 0)
> +#define PSIMD_DO_LT_MASK(N, M) ((N) < (M) ? -1 : 0)
> +#define PSIMD_DO_MIN(N, M) ((N) < (M) ? (N) : (M))
> +#define PSIMD_DO_MAX(N, M) ((N) > (M) ? (N) : (M))
> +#define PSIMD_DO_SLL(N, M) ((N) << (M))
> +#define PSIMD_DO_SRL(N, M) ((N) >> (M))
> +#define PSIMD_DO_SRA(N, M) ((N) >> (M))
> +
> +#define GEN_PSIMD_BINOP(NAME, RTYPE, STYPE, DTYPE, EXTRACT, INSERT,       \
> +                        ELEMS, OP)                                        \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        STYPE e1 = (STYPE)EXTRACT(rs1, i);                                \
> +        STYPE e2 = (STYPE)EXTRACT(rs2, i);                                \
> +        DTYPE res = (DTYPE)OP(e1, e2);                                    \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_BINOP_SCALAR(NAME, RTYPE, ETYPE, EXTRACT, INSERT,       \
> +                               ELEMS, OP)                                 \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    ETYPE e2 = (ETYPE)EXTRACT(rs2, 0);                                    \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res = OP(e1, e2);                                           \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SHIFTOP(NAME, RTYPE, STYPE, DTYPE, EXTRACT, INSERT,     \
> +                          ELEMS, SHMASK, OP)                              \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    uint8_t shamt = rs2 & (SHMASK);                                       \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        STYPE e1 = (STYPE)EXTRACT(rs1, i);                                \
> +        DTYPE res = (DTYPE)OP(e1, shamt);                                 \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SAT_SHIFTOP(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT, \
> +                              ELEMS, SHMASK, SAT_FN)                      \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +    uint8_t shamt = rs2 & (SHMASK);                                       \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        WTYPE shifted = (WTYPE)e1 << shamt;                               \
> +        ETYPE res = SAT_FN(shifted, &sat);                                \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_ROUND_SRAI(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,  \
> +                             ELEMS, SHMASK)                               \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    uint8_t shamt = rs2 & (SHMASK);                                       \
> +                                                                          \
> +    if (shamt == 0) {                                                     \
> +        return rs1;                                                       \
> +    }                                                                     \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        WTYPE rounded = (((WTYPE)e1 >> (shamt - 1)) + 1) >> 1;            \
> +        rd = INSERT(rd, (ETYPE)rounded, i);                               \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SAT_BINOP(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
> +                            ELEMS, OP, SAT_FN)                            \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE e2 = (ETYPE)EXTRACT(rs2, i);                                \
> +        WTYPE val = OP((WTYPE)e1, (WTYPE)e2);                             \
> +        ETYPE res = SAT_FN(val, &sat);                                    \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_USUB_SAT(NAME, RTYPE, ETYPE, EXTRACT, INSERT, ELEMS)    \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE e2 = (ETYPE)EXTRACT(rs2, i);                                \
> +        ETYPE res = (e1 >= e2) ? (e1 - e2) : 0;                           \
> +        if (e1 < e2) {                                                    \
> +            sat = 1;                                                      \
> +        }                                                                 \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_AVG_BINOP(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
> +                            ELEMS, OP)                                    \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        WTYPE e1 = (WTYPE)(ETYPE)EXTRACT(rs1, i);                         \
> +        WTYPE e2 = (WTYPE)(ETYPE)EXTRACT(rs2, i);                         \
> +        ETYPE res = (ETYPE)(OP(e1, e2) >> 1);                             \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SHADD(NAME, RTYPE, ETYPE, EXTRACT, INSERT, ELEMS,       \
> +                        SHAMT)                                            \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE e2 = (ETYPE)EXTRACT(rs2, i);                                \
> +        ETYPE res = (e1 << (SHAMT)) + e2;                                 \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SAT_SHADD(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
> +                            ELEMS, SHAMT, SH_MIN, SH_MAX, SAT_MIN,        \
> +                            SAT_MAX, SAT_FN)                              \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE e2 = (ETYPE)EXTRACT(rs2, i);                                \
> +        WTYPE shifted;                                                    \
> +                                                                          \
> +        if (e1 > (SH_MAX) || e1 < (SH_MIN)) {                             \
> +            shifted = (e1 < 0) ? (SAT_MIN) : (SAT_MAX);                   \
> +            sat = 1;                                                      \
> +        } else {                                                          \
> +            shifted = (WTYPE)e1 << (SHAMT);                               \
> +        }                                                                 \
> +                                                                          \
> +        WTYPE sum = shifted + e2;                                         \
> +        ETYPE res = SAT_FN(sum, &sat);                                    \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SATI(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,        \
> +                       ELEMS, IMMMASK)                                    \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE imm)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int range = (imm & (IMMMASK)) + 1;                                    \
> +    WTYPE max = ((WTYPE)1 << (range - 1)) - 1;                            \
> +    WTYPE min = -((WTYPE)1 << (range - 1));                               \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (e1 > max) {                                                   \
> +            res = max;                                                    \
> +            sat = 1;                                                      \
> +        } else if (e1 < min) {                                            \
> +            res = min;                                                    \
> +            sat = 1;                                                      \
> +        } else {                                                          \
> +            res = e1;                                                     \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_USATI(NAME, RTYPE, ETYPE, UTYPE, WTYPE, EXTRACT,        \
> +                        INSERT, ELEMS, ONE)                               \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE imm)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    WTYPE max = ((WTYPE)(ONE) << imm) - 1;                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (e1 < 0) {                                                     \
> +            res = 0;                                                      \
> +            sat = 1;                                                      \
> +        } else if ((UTYPE)e1 > max) {                                     \
> +            res = max;                                                    \
> +            sat = 1;                                                      \
> +        } else {                                                          \
> +            res = e1;                                                     \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_ABS(NAME, RTYPE, ETYPE, EXTRACT, INSERT, ELEMS,         \
> +                      MINVAL, MAXVAL)                                     \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1)                         \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (e1 == (MINVAL)) {                                             \
> +            res = (MAXVAL);                                               \
> +            sat = 1;                                                      \
> +        } else if (e1 < 0) {                                              \
> +            res = -e1;                                                    \
> +        } else {                                                          \
> +            res = e1;                                                     \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_SCALAR_ABS(NAME, RTYPE, STYPE, UTYPE)                   \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1)                         \
> +{                                                                         \
> +    STYPE value = (STYPE)rs1;                                            \
> +    UTYPE result = (UTYPE)value;                                         \
> +                                                                          \
> +    if (value < 0) {                                                      \
> +        result = (UTYPE)0 - result;                                      \
> +    }                                                                     \
> +    return (RTYPE)(STYPE)result;                                         \
> +}
> +
> +#define GEN_PSIMD_VAR_SSHA(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,    \
> +                           ELEMS, BITS, SAT_FN)                           \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                  \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (shamt >= 0) {                                                 \
> +            WTYPE shifted = (WTYPE)e1 << shamt;                           \
> +            res = SAT_FN(shifted, &sat);                                  \
> +        } else {                                                          \
> +            int right = -shamt;                                           \
> +            if (right >= (BITS)) {                                        \
> +                res = (e1 < 0) ? -1 : 0;                                  \
> +            } else {                                                      \
> +                res = e1 >> right;                                        \
> +            }                                                             \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_VAR_SSHAR(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
> +                            ELEMS, BITS, SAT_MIN, SAT_MAX, SAT_FN)        \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                  \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (shamt >= 0) {                                                 \
> +            if (shamt >= (BITS)) {                                        \
> +                if (e1 == 0) {                                            \
> +                    res = 0;                                              \
> +                } else if (e1 > 0) {                                      \
> +                    res = (SAT_MAX);                                      \
> +                    sat = 1;                                              \
> +                } else {                                                  \
> +                    res = (SAT_MIN);                                      \
> +                    sat = 1;                                              \
> +                }                                                         \
> +            } else {                                                      \
> +                WTYPE shifted = (WTYPE)e1 * ((WTYPE)1 << shamt);          \
> +                res = SAT_FN(shifted, &sat);                              \
> +            }                                                             \
> +        } else {                                                          \
> +            int right = -shamt;                                           \
> +            if (right >= (BITS)) {                                        \
> +                res = 0;                                                  \
> +            } else {                                                      \
> +                WTYPE rounded = ((e1 >> (right - 1)) + 1) >> 1;           \
> +                res = (ETYPE)rounded;                                     \
> +            }                                                             \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_VAR_USHL(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,    \
> +                           ELEMS, BITS, SAT_FN)                           \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                  \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (shamt >= 0) {                                                 \
> +            WTYPE shifted = (shamt >= (BITS)) ?                           \
> +                            ((WTYPE)e1 << (BITS)) :                       \
> +                            ((WTYPE)e1 << shamt);                         \
> +            res = SAT_FN(shifted, &sat);                                  \
> +        } else {                                                          \
> +            int right = -shamt;                                           \
> +            if (right >= (BITS)) {                                        \
> +                res = 0;                                                  \
> +            } else {                                                      \
> +                res = e1 >> right;                                        \
> +            }                                                             \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_VAR_USHLR(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
> +                            ELEMS, BITS, SAT_FN)                          \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                  \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (shamt >= 0) {                                                 \
> +            WTYPE shifted = (shamt >= (BITS)) ?                           \
> +                            ((WTYPE)e1 << (BITS)) :                       \
> +                            ((WTYPE)e1 << shamt);                         \
> +            res = SAT_FN(shifted, &sat);                                  \
> +        } else {                                                          \
> +            int right = -shamt;                                           \
> +            if (right > (BITS)) {                                         \
> +                res = 0;                                                  \
> +            } else {                                                      \
> +                WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;           \
> +                res = (ETYPE)(rounded >> 1);                              \
> +            }                                                             \
> +        }                                                                 \
> +                                                                          \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define PSIMD_DO_SRA64(A, B) ((A) >> (B))
> +#define PSIMD_DO_RNDSRA64(A, B)                                          \
> +    ((int64_t)((((__int128_t)(A) >> ((B) - 1)) + 1) >> 1))
> +
> +#define GEN_PSIMD_VAR_SRA64(NAME, RIGHT_OP)                               \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    int64_t a = (int64_t)rs1;                                            \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                 \
> +                                                                          \
> +    if (shamt >= 0) {                                                     \
> +        return (uint64_t)(a << shamt);                                    \
> +    }                                                                     \
> +                                                                          \
> +    int right = -shamt;                                                   \
> +    if (right >= 64) {                                                    \
> +        return (a < 0) ? (uint64_t)-1 : 0;                               \
> +    }                                                                     \
> +    return (uint64_t)RIGHT_OP(a, right);                                  \
> +}
> +
> +#define PSIMD_DO_SRL64(A, B) (((B) >= 64) ? 0 : ((A) >> (B)))
> +#define PSIMD_DO_RNDSRL64(A, B)                                          \
> +    (((B) > 64) ? 0 : ((((A) >> ((B) - 1)) + 1) >> 1))
> +
> +#define GEN_PSIMD_VAR_SRL64(NAME, RIGHT_OP)                               \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                 \
> +                                                                          \
> +    if (shamt < 0) {                                                      \
> +        return RIGHT_OP(rs1, -shamt);                                     \
> +    }                                                                     \
> +    return (shamt >= 64) ? 0 : (rs1 << shamt);                           \
> +}
> +
> +#define GEN_PSIMD_XPAIR_BINOP(NAME, RTYPE, ETYPE, EXTRACT, INSERT,        \
> +                              ELEMS, OP_LO, OP_HI)                        \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i += 2) {                                  \
> +        ETYPE s1_lo = (ETYPE)EXTRACT(rs1, i);                             \
> +        ETYPE s1_hi = (ETYPE)EXTRACT(rs1, i + 1);                         \
> +        ETYPE s2_lo = (ETYPE)EXTRACT(rs2, i);                             \
> +        ETYPE s2_hi = (ETYPE)EXTRACT(rs2, i + 1);                         \
> +        ETYPE res_lo = OP_LO(s1_lo, s2_hi);                               \
> +        ETYPE res_hi = OP_HI(s1_hi, s2_lo);                               \
> +        rd = INSERT(rd, res_lo, i);                                       \
> +        rd = INSERT(rd, res_hi, i + 1);                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_XPAIR_SAT_BINOP(NAME, RTYPE, ETYPE, WTYPE, EXTRACT,     \
> +                                  INSERT, ELEMS, OP_LO, OP_HI, SAT_FN)    \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i += 2) {                                  \
> +        ETYPE s1_lo = (ETYPE)EXTRACT(rs1, i);                             \
> +        ETYPE s1_hi = (ETYPE)EXTRACT(rs1, i + 1);                         \
> +        ETYPE s2_lo = (ETYPE)EXTRACT(rs2, i);                             \
> +        ETYPE s2_hi = (ETYPE)EXTRACT(rs2, i + 1);                         \
> +        WTYPE val_lo = OP_LO((WTYPE)s1_lo, (WTYPE)s2_hi);                 \
> +        WTYPE val_hi = OP_HI((WTYPE)s1_hi, (WTYPE)s2_lo);                 \
> +        ETYPE res_lo = SAT_FN(val_lo, &sat);                              \
> +        ETYPE res_hi = SAT_FN(val_hi, &sat);                              \
> +        rd = INSERT(rd, res_lo, i);                                       \
> +        rd = INSERT(rd, res_hi, i + 1);                                   \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_XPAIR_AVG_BINOP(NAME, RTYPE, ETYPE, WTYPE, EXTRACT,     \
> +                                  INSERT, ELEMS, OP_LO, OP_HI)            \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i += 2) {                                  \
> +        ETYPE s1_lo = (ETYPE)EXTRACT(rs1, i);                             \
> +        ETYPE s1_hi = (ETYPE)EXTRACT(rs1, i + 1);                         \
> +        ETYPE s2_lo = (ETYPE)EXTRACT(rs2, i);                             \
> +        ETYPE s2_hi = (ETYPE)EXTRACT(rs2, i + 1);                         \
> +        ETYPE res_lo = (ETYPE)(OP_LO((WTYPE)s1_lo, (WTYPE)s2_hi) >> 1);   \
> +        ETYPE res_hi = (ETYPE)(OP_HI((WTYPE)s1_hi, (WTYPE)s2_lo) >> 1);   \
> +        rd = INSERT(rd, res_lo, i);                                       \
> +        rd = INSERT(rd, res_hi, i + 1);                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_REDSUM(NAME, RTYPE, SUMTYPE, ETYPE, EXTRACT, ELEMS,     \
> +                         INIT)                                            \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    SUMTYPE sum = (INIT);                                                 \
> +    int elems = ELEMS(rs1);                                               \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        sum += e1;                                                        \
> +    }                                                                     \
> +                                                                          \
> +    return (RTYPE)sum;                                                    \
> +}
> +
> +#define PSIMD_PAIR_LO(V, MASK, SHIFT) ((V) & (MASK))
> +#define PSIMD_PAIR_HI(V, MASK, SHIFT) (((V) >> (SHIFT)) & (MASK))
> +
> +#define GEN_PSIMD_PAIR_PACK(NAME, RTYPE, ETYPE, EXTRACT, INSERT, ELEMS,   \
> +                            MASK, SHIFT, HI_SEL, LO_SEL)                 \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = EXTRACT(rs1, i);                                       \
> +        ETYPE e2 = EXTRACT(rs2, i);                                       \
> +        ETYPE res = (HI_SEL(e2, MASK, SHIFT) << (SHIFT)) |                \
> +                    LO_SEL(e1, MASK, SHIFT);                              \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_PAIR_WORD(NAME, RS1_IDX, RS2_IDX)                       \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    uint32_t e1 = EXTRACT32(rs1, RS1_IDX);                                \
> +    uint32_t e2 = EXTRACT32(rs2, RS2_IDX);                                \
> +                                                                          \
> +    return ((uint64_t)e2 << 32) | e1;                                     \
> +}
> +
> +#define GEN_PSIMD_SIGN_EXTEND(NAME, RTYPE, STYPE, DTYPE, EXTRACT, INSERT, \
> +                              ELEMS, SCALE)                               \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1)                         \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        STYPE e1 = (STYPE)EXTRACT(rs1, i * (SCALE));                      \
> +        rd = INSERT(rd, (DTYPE)e1, i);                                    \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_ZIP(NAME, ETYPE, EXTRACT, ELEMS, BITS, START)           \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = EXTRACT(rs1, (START) - i);                             \
> +        ETYPE e2 = EXTRACT(rs2, (START) - i);                             \
> +        rd = (rd << (2 * (BITS))) | ((uint64_t)e2 << (BITS)) | e1;        \
> +    }                                                                     \
> +                                                                          \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_UNZIP(NAME, EXTRACT, ELEMS, BITS, OFFSET)               \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        uint64_t e1 = (uint64_t)EXTRACT(rs1, 2 * i + (OFFSET)) <<         \
> +                      ((BITS) * i);                                       \
> +        uint64_t e2 = (uint64_t)EXTRACT(rs2, 2 * i + (OFFSET)) <<         \
> +                      (32 + (BITS) * i);                                  \
> +        rd = rd | e2 | e1;                                                \
> +    }                                                                     \
> +                                                                          \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_BIT_SELECT(NAME, MASK, TRUE_VAL, FALSE_VAL)             \
> +target_ulong HELPER(NAME)(CPURISCVState *env, target_ulong rs1,           \
> +                          target_ulong rs2, target_ulong rd)              \
> +{                                                                         \
> +    return (~(MASK) & (FALSE_VAL)) | ((MASK) & (TRUE_VAL));               \
> +}
> +
> +#define GEN_PSIMD_NCLIP_PACK(NAME, ITYPE, OTYPE, EXTRACT, INSERT, ELEMS,  \
> +                             SAT_FN)                                      \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ITYPE lo = (ITYPE)EXTRACT(rs1, i);                                \
> +        ITYPE hi = (ITYPE)EXTRACT(rs2, i);                                \
> +        OTYPE res_lo = SAT_FN(lo, &sat);                                  \
> +        OTYPE res_hi = SAT_FN(hi, &sat);                                  \
> +                                                                          \
> +        rd = (uint64_t)INSERT(rd, res_lo, i);                             \
> +        rd = (uint64_t)INSERT(rd, res_hi, i + (ELEMS));                   \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_CLS(NAME, RTYPE, UTYPE, CLRSB)                          \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1)                         \
> +{                                                                         \
> +    return CLRSB((UTYPE)rs1);                                             \
> +}
> +
> +#define PSIMD_MUL_S32(A, B)  ((int32_t)(A) * (int32_t)(B))
> +#define PSIMD_MUL_SU16(A, B) ((int16_t)(A) * (uint16_t)(B))
> +#define PSIMD_MUL_SU32(A, B) ((int32_t)(A) * (uint32_t)(B))
> +#define PSIMD_MUL_U32(A, B)  ((uint32_t)(A) * (uint32_t)(B))
> +#define PSIMD_MUL_S64(A, B)  ((int64_t)(A) * (int64_t)(B))
> +#define PSIMD_MUL_SU64(A, B) ((int64_t)(A) * (uint64_t)(B))
> +#define PSIMD_MUL_U64(A, B)  ((uint64_t)(A) * (uint64_t)(B))
> +
> +#define GEN_PSIMD_MUL_HIGH(NAME, RTYPE, E1TYPE, E2TYPE, PTYPE, HTYPE,     \
> +                           EXTRACT, INSERT, ELEMS, SHIFT, ROUND, OP)     \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i);                              \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i);                              \
> +        PTYPE prod = OP(e1, e2) + (ROUND);                                \
> +        HTYPE high = (HTYPE)(prod >> (SHIFT));                            \
> +        rd = INSERT(rd, high, i);                                         \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_MUL_HIGH_SEL(NAME, RTYPE, E1TYPE, E2TYPE, PTYPE,        \
> +                               HTYPE, EXTRACT1, EXTRACT2, INSERT, ELEMS, \
> +                               SCALE, OFFSET, SHIFT, OP)                 \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT1(rs1, i);                             \
> +        E2TYPE e2 = (E2TYPE)EXTRACT2(rs2, i * (SCALE) + (OFFSET));        \
> +        PTYPE prod = OP(e1, e2);                                          \
> +        HTYPE high = (HTYPE)(prod >> (SHIFT));                            \
> +        rd = INSERT(rd, high, i);                                         \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_MUL_ELEM_INDEXED(NAME, RTYPE, E1TYPE, E2TYPE, PTYPE,    \
> +                                   OTYPE, EXTRACT, INSERT, ELEMS, SCALE, \
> +                                   OFFSET1, OFFSET2, OP)                 \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET1));        \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET2));        \
> +        PTYPE mul = OP(e1, e2);                                           \
> +        rd = INSERT(rd, (OTYPE)mul, i);                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_MUL_ELEM_SCALAR(NAME, RTYPE, E1TYPE, E2TYPE, PTYPE,     \
> +                                  EXTRACT, OFFSET1, OFFSET2, OP)         \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    E1TYPE e1 = (E1TYPE)EXTRACT(rs1, OFFSET1);                            \
> +    E2TYPE e2 = (E2TYPE)EXTRACT(rs2, OFFSET2);                            \
> +    PTYPE mul = OP(e1, e2);                                               \
> +                                                                          \
> +    return (RTYPE)mul;                                                    \
> +}
> +
> +#define GEN_PSIMD_MUL_HIGH_ACC(NAME, RTYPE, E1TYPE, E2TYPE, DTYPE, PTYPE, \
> +                               HTYPE, OTYPE, EXTRACT, INSERT, ELEMS,     \
> +                               SHIFT, ROUND, OP)                         \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i);                              \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i);                              \
> +        DTYPE d = (DTYPE)EXTRACT(dest, i);                                \
> +        PTYPE prod = OP(e1, e2) + (ROUND);                                \
> +        HTYPE high = (HTYPE)(prod >> (SHIFT));                            \
> +        OTYPE res = (OTYPE)(high + d);                                    \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_MUL_HIGH_ACC_SEL(NAME, RTYPE, E1TYPE, E2TYPE, DTYPE,    \
> +                                   PTYPE, HTYPE, OTYPE, EXTRACT1,        \
> +                                   EXTRACT2, INSERT, ELEMS, SCALE,       \
> +                                   OFFSET, SHIFT, OP)                    \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT1(rs1, i);                             \
> +        E2TYPE e2 = (E2TYPE)EXTRACT2(rs2, i * (SCALE) + (OFFSET));        \
> +        DTYPE d = (DTYPE)EXTRACT1(dest, i);                               \
> +        PTYPE prod = OP(e1, e2);                                          \
> +        HTYPE high = (HTYPE)(prod >> (SHIFT));                            \
> +        OTYPE res = (OTYPE)(high + d);                                    \
> +        rd = INSERT(rd, res, i);                                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_MUL_ACC_INDEXED(NAME, RTYPE, E1TYPE, E2TYPE, DTYPE,     \
> +                                  PTYPE, OTYPE, EXTRACT, EXTRACTD,       \
> +                                  INSERT, ELEMS, SCALE, OFFSET1,         \
> +                                  OFFSET2, OP)                           \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET1));        \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET2));        \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE mul = OP(e1, e2);                                           \
> +        rd = INSERT(rd, (OTYPE)(d + mul), i);                             \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_QMUL(NAME, RTYPE, ETYPE, PTYPE, OTYPE, EXTRACT, INSERT, \
> +                       ELEMS, SHIFT, ROUND, MINVAL, MAXVAL)              \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE e2 = (ETYPE)EXTRACT(rs2, i);                                \
> +        OTYPE result;                                                     \
> +                                                                          \
> +        if ((e1 == (ETYPE)(MINVAL)) && (e2 == (ETYPE)(MINVAL))) {         \
> +            sat = 1;                                                      \
> +            result = (OTYPE)(MAXVAL);                                     \
> +        } else {                                                          \
> +            PTYPE prod = (PTYPE)e1 * (PTYPE)e2 + (ROUND);                 \
> +            result = (OTYPE)(prod >> (SHIFT));                            \
> +        }                                                                 \
> +        rd = INSERT(rd, result, i);                                       \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_QMUL_ACC_INDEXED(NAME, RTYPE, E1TYPE, E2TYPE, DTYPE,    \
> +                                   PTYPE, STYPE, OTYPE, EXTRACT,         \
> +                                   EXTRACTD, INSERT, ELEMS, SCALE,       \
> +                                   OFFSET1, OFFSET2, SHIFT, ROUND, OP)   \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET1));        \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET2));        \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE prod = OP(e1, e2) + (ROUND);                                \
> +        STYPE scaled = (STYPE)(((__int128_t)prod) >> (SHIFT));            \
> +        rd = INSERT(rd, (OTYPE)(d + scaled), i);                          \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_Q2ADD(NAME, RTYPE, ETYPE, PTYPE, STYPE, OTYPE, EXTRACT, \
> +                        INSERT, ELEMS, SCALE, SHIFT, ROUND, OP)          \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE s1_0 = (ETYPE)EXTRACT(rs1, i * (SCALE));                   \
> +        ETYPE s1_1 = (ETYPE)EXTRACT(rs1, i * (SCALE) + 1);               \
> +        ETYPE s2_0 = (ETYPE)EXTRACT(rs2, i * (SCALE));                   \
> +        ETYPE s2_1 = (ETYPE)EXTRACT(rs2, i * (SCALE) + 1);               \
> +        PTYPE prod0 = OP(s1_0, s2_0) + (ROUND);                          \
> +        PTYPE prod1 = OP(s1_1, s2_1) + (ROUND);                          \
> +        STYPE scaled0 = (STYPE)(((__int128_t)prod0) >> (SHIFT));          \
> +        STYPE scaled1 = (STYPE)(((__int128_t)prod1) >> (SHIFT));          \
> +        rd = INSERT(rd, (OTYPE)(scaled0 + scaled1), i);                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_Q2ADDA(NAME, RTYPE, ETYPE, DTYPE, PTYPE, STYPE, OTYPE,  \
> +                         EXTRACT, EXTRACTD, INSERT, ELEMS, SCALE,        \
> +                         SHIFT, ROUND, OP)                               \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE s1_0 = (ETYPE)EXTRACT(rs1, i * (SCALE));                   \
> +        ETYPE s1_1 = (ETYPE)EXTRACT(rs1, i * (SCALE) + 1);               \
> +        ETYPE s2_0 = (ETYPE)EXTRACT(rs2, i * (SCALE));                   \
> +        ETYPE s2_1 = (ETYPE)EXTRACT(rs2, i * (SCALE) + 1);               \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE prod0 = OP(s1_0, s2_0) + (ROUND);                          \
> +        PTYPE prod1 = OP(s1_1, s2_1) + (ROUND);                          \
> +        STYPE scaled0 = (STYPE)(((__int128_t)prod0) >> (SHIFT));          \
> +        STYPE scaled1 = (STYPE)(((__int128_t)prod1) >> (SHIFT));          \
> +        rd = INSERT(rd, (OTYPE)(d + scaled0 + scaled1), i);               \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define PSIMD_COMB_ADD(D, A, B) ((D) + (A) + (B))
> +#define PSIMD_COMB_SUB(D, A, B) ((D) + (A) - (B))
> +
> +#define GEN_PSIMD_2WAY_MUL(NAME, RTYPE, E1TYPE, E2TYPE, PTYPE, OTYPE,     \
> +                           EXTRACT, INSERT, ELEMS, SCALE, OFFSET10,      \
> +                           OFFSET11, OFFSET20, OFFSET21, OP, COMBINE)   \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE s1_0 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET10));     \
> +        E1TYPE s1_1 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET11));     \
> +        E2TYPE s2_0 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET20));     \
> +        E2TYPE s2_1 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET21));     \
> +        PTYPE prod0 = OP(s1_0, s2_0);                                     \
> +        PTYPE prod1 = OP(s1_1, s2_1);                                     \
> +        rd = INSERT(rd, (OTYPE)COMBINE(0, prod0, prod1), i);              \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_2WAY_SAT_MUL(NAME, OFFSET10, OFFSET11, OFFSET20,        \
> +                               OFFSET21)                                 \
> +target_ulong HELPER(NAME)(CPURISCVState *env, target_ulong rs1,           \
> +                           target_ulong rs2)                              \
> +{                                                                         \
> +    target_ulong rd = 0;                                                  \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < ELEMS_W(rd); i++) {                               \
> +        int16_t s1_0 = (int16_t)EXTRACT16(rs1, i * 2 + (OFFSET10));       \
> +        int16_t s1_1 = (int16_t)EXTRACT16(rs1, i * 2 + (OFFSET11));       \
> +        int16_t s2_0 = (int16_t)EXTRACT16(rs2, i * 2 + (OFFSET20));       \
> +        int16_t s2_1 = (int16_t)EXTRACT16(rs2, i * 2 + (OFFSET21));       \
> +        uint32_t result;                                                  \
> +                                                                          \
> +        if (s1_0 == INT16_MIN && s1_1 == INT16_MIN &&                    \
> +            s2_0 == INT16_MIN && s2_1 == INT16_MIN) {                    \
> +            result = INT32_MAX;                                          \
> +            sat = 1;                                                      \
> +        } else {                                                          \
> +            int32_t prod0 = (int32_t)s1_0 * s2_0;                        \
> +            int32_t prod1 = (int32_t)s1_1 * s2_1;                        \
> +            result = (uint32_t)(prod0 + prod1);                           \
> +        }                                                                 \
> +        rd = INSERT32(rd, result, i);                                     \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_2WAY_MUL_ACC(NAME, RTYPE, E1TYPE, E2TYPE, DTYPE, PTYPE, \
> +                               OTYPE, EXTRACT, EXTRACTD, INSERT, ELEMS,  \
> +                               SCALE, OFFSET10, OFFSET11, OFFSET20,      \
> +                               OFFSET21, OP, COMBINE)                   \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        E1TYPE s1_0 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET10));     \
> +        E1TYPE s1_1 = (E1TYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET11));     \
> +        E2TYPE s2_0 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET20));     \
> +        E2TYPE s2_1 = (E2TYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET21));     \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE prod0 = OP(s1_0, s2_0);                                     \
> +        PTYPE prod1 = OP(s1_1, s2_1);                                     \
> +        rd = INSERT(rd, (OTYPE)COMBINE(d, prod0, prod1), i);              \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_4WAY_MUL(NAME, RTYPE, E1TYPE, E2TYPE, PTYPE, OTYPE,     \
> +                           EXTRACT, INSERT, ELEMS, SCALE, OP)            \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        PTYPE prod0 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE)),              \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE)));             \
> +        PTYPE prod1 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE) + 1),          \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE) + 1));         \
> +        PTYPE prod2 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE) + 2),          \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE) + 2));         \
> +        PTYPE prod3 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE) + 3),          \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE) + 3));         \
> +        rd = INSERT(rd, (OTYPE)(prod0 + prod1 + prod2 + prod3), i);       \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_4WAY_MUL_ACC(NAME, RTYPE, E1TYPE, E2TYPE, DTYPE, PTYPE, \
> +                               OTYPE, EXTRACT, EXTRACTD, INSERT, ELEMS,  \
> +                               SCALE, OP)                                \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2, RTYPE dest)  \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE prod0 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE)),              \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE)));             \
> +        PTYPE prod1 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE) + 1),          \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE) + 1));         \
> +        PTYPE prod2 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE) + 2),          \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE) + 2));         \
> +        PTYPE prod3 = OP((E1TYPE)EXTRACT(rs1, i * (SCALE) + 3),          \
> +                         (E2TYPE)EXTRACT(rs2, i * (SCALE) + 3));         \
> +        rd = INSERT(rd, (OTYPE)(d + prod0 + prod1 + prod2 + prod3), i);   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_WIDEN_BINOP(NAME, ETYPE, WTYPE, OTYPE, ELEMS, IBITS,    \
> +                              OBITS, IMASK, OP)                          \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((rs1 >> (i * (IBITS))) & (IMASK));             \
> +        ETYPE e2 = (ETYPE)((rs2 >> (i * (IBITS))) & (IMASK));             \
> +        WTYPE res = OP((WTYPE)0, (WTYPE)e1, (WTYPE)e2);                   \
> +        rd |= ((uint64_t)(OTYPE)res) << (i * (OBITS));                    \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_WIDEN_BINOP_ACC(NAME, ETYPE, WTYPE, OTYPE, ELEMS,       \
> +                                  IBITS, OBITS, IMASK, OMASK, OP)        \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,     \
> +                      uint64_t dest)                                      \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((rs1 >> (i * (IBITS))) & (IMASK));             \
> +        ETYPE e2 = (ETYPE)((rs2 >> (i * (IBITS))) & (IMASK));             \
> +        WTYPE acc = (WTYPE)((dest >> (i * (OBITS))) & (OMASK));           \
> +        WTYPE res = OP(acc, (WTYPE)e1, (WTYPE)e2);                        \
> +        rd |= ((uint64_t)(OTYPE)res) << (i * (OBITS));                    \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_WIDEN_MUL(NAME, E1TYPE, E2TYPE, PTYPE, OTYPE, ELEMS,    \
> +                            EXTRACT, OBITS, OP)                          \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i);                              \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i);                              \
> +        PTYPE prod = OP(e1, e2);                                          \
> +        rd |= ((uint64_t)(OTYPE)prod) << (i * (OBITS));                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_WIDEN_MUL_ACC(NAME, E1TYPE, E2TYPE, DTYPE, PTYPE,       \
> +                                OTYPE, ELEMS, EXTRACT, EXTRACTD, OBITS,  \
> +                                OP)                                      \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,     \
> +                      uint64_t dest)                                      \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        E1TYPE e1 = (E1TYPE)EXTRACT(rs1, i);                              \
> +        E2TYPE e2 = (E2TYPE)EXTRACT(rs2, i);                              \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE prod = OP(e1, e2);                                          \
> +        rd |= ((uint64_t)(OTYPE)(d + prod)) << (i * (OBITS));             \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_WIDEN_QMUL_ACC(NAME, ETYPE, DTYPE, PTYPE, STYPE,        \
> +                                 OTYPE, ELEMS, EXTRACT, EXTRACTD, SCALE, \
> +                                 OFFSET, SHIFT, ROUND, OBITS, OP)        \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,     \
> +                      uint64_t dest)                                      \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i * (SCALE) + (OFFSET));           \
> +        ETYPE e2 = (ETYPE)EXTRACT(rs2, i * (SCALE) + (OFFSET));           \
> +        DTYPE d = (DTYPE)EXTRACTD(dest, i);                               \
> +        PTYPE prod = OP(e1, e2) + (ROUND);                                \
> +        STYPE scaled = (STYPE)(((__int128_t)prod) >> (SHIFT));            \
> +        rd |= ((uint64_t)(OTYPE)(d + scaled)) << (i * (OBITS));           \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_DW_2WAY_MUL(NAME, E1TYPE, E2TYPE, PTYPE, EXTRACT,       \
> +                              OFFSET10, OFFSET11, OFFSET20, OFFSET21,    \
> +                              OP, COMBINE)                               \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)     \
> +{                                                                         \
> +    E1TYPE s1_0 = (E1TYPE)EXTRACT(rs1, OFFSET10);                         \
> +    E1TYPE s1_1 = (E1TYPE)EXTRACT(rs1, OFFSET11);                         \
> +    E2TYPE s2_0 = (E2TYPE)EXTRACT(rs2, OFFSET20);                         \
> +    E2TYPE s2_1 = (E2TYPE)EXTRACT(rs2, OFFSET21);                         \
> +    PTYPE prod0 = OP(s1_0, s2_0);                                        \
> +    PTYPE prod1 = OP(s1_1, s2_1);                                        \
> +                                                                          \
> +    return (uint64_t)COMBINE(0, prod0, prod1);                            \
> +}
> +
> +#define GEN_PSIMD_DW_2WAY_MUL_ACC(NAME, E1TYPE, E2TYPE, DTYPE, PTYPE,     \
> +                                  EXTRACT, OFFSET10, OFFSET11, OFFSET20, \
> +                                  OFFSET21, OP, COMBINE)                \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,     \
> +                      uint64_t dest)                                      \
> +{                                                                         \
> +    E1TYPE s1_0 = (E1TYPE)EXTRACT(rs1, OFFSET10);                         \
> +    E1TYPE s1_1 = (E1TYPE)EXTRACT(rs1, OFFSET11);                         \
> +    E2TYPE s2_0 = (E2TYPE)EXTRACT(rs2, OFFSET20);                         \
> +    E2TYPE s2_1 = (E2TYPE)EXTRACT(rs2, OFFSET21);                         \
> +    DTYPE d = (DTYPE)dest;                                                \
> +    PTYPE prod0 = OP(s1_0, s2_0);                                        \
> +    PTYPE prod1 = OP(s1_1, s2_1);                                        \
> +                                                                          \
> +    return (uint64_t)COMBINE(d, prod0, prod1);                            \
> +}
> +
> +#define GEN_PSIMD_WIDEN_SHIFT(NAME, ETYPE, WTYPE, OTYPE, ELEMS, IBITS,    \
> +                              OBITS, IMASK, SHMASK)                      \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +    uint8_t shamt = rs2 & (SHMASK);                                       \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((rs1 >> (i * (IBITS))) & (IMASK));             \
> +        WTYPE res = (WTYPE)e1 << shamt;                                   \
> +        rd |= ((uint64_t)(OTYPE)res) << (i * (OBITS));                    \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_DW_ZIP(NAME, EXTRACT, ELEMS, STRIDE, BITS)              \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)     \
> +{                                                                         \
> +    uint64_t rd = 0;                                                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        uint64_t e1 = (uint64_t)EXTRACT(rs1, i) << ((STRIDE) * i);        \
> +        uint64_t e2 = (uint64_t)EXTRACT(rs2, i)                           \
> +                      << ((STRIDE) * i + (BITS));                         \
> +        rd |= e2 | e1;                                                    \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_DW_REDSUM(NAME, SUMTYPE, INITTYPE, ETYPE, EXTRACT,      \
> +                            ELEMS)                                        \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint32_t rs1_lo,                \
> +                      uint32_t rs1_hi, uint32_t rs2)                      \
> +{                                                                         \
> +    SUMTYPE sum = (INITTYPE)rs2;                                          \
> +    uint64_t s1 = ((uint64_t)rs1_hi << 32) | rs1_lo;                      \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        sum += (ETYPE)EXTRACT(s1, i);                                     \
> +    }                                                                     \
> +    return (uint32_t)sum;                                                 \
> +}
> +
> +#define GEN_PSIMD_NARROW_SRL(NAME, ETYPE, OTYPE, ELEMS, IBITS, OBITS,     \
> +                             IMASK, SHMASK)                               \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        OTYPE result = (OTYPE)(e1 >> shift);                              \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NARROW_SRA_PACK(NAME, ETYPE, STYPE, OTYPE, ELEMS,       \
> +                                  IBITS, OBITS, IMASK, SHMASK)            \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        STYPE shx = (STYPE)e1 >> shift;                                   \
> +        OTYPE result = (OTYPE)shx;                                        \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NARROW_RNDSRA_PACK(NAME, ETYPE, STYPE, OTYPE, ELEMS,    \
> +                                     IBITS, OBITS, IMASK, SHMASK, RMASK)  \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        STYPE e1_s = (STYPE)e1;                                           \
> +        uint64_t shx = (((uint64_t)e1_s << 1) >> shift) & (RMASK);        \
> +        OTYPE result = (OTYPE)((shx + 1) >> 1);                           \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NCLIP_SIGNED_PACK(NAME, ETYPE, STYPE, CTYPE, OTYPE,     \
> +                                    ELEMS, IBITS, OBITS, IMASK, SHMASK,   \
> +                                    MIN, MAX, MIN_RES, MAX_RES)           \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        CTYPE shx = (CTYPE)((STYPE)e1 >> shift);                          \
> +        OTYPE result;                                                     \
> +                                                                          \
> +        if (shx < (MIN)) {                                                \
> +            sat = 1;                                                      \
> +            result = (MIN_RES);                                           \
> +        } else if (shx > (MAX)) {                                         \
> +            sat = 1;                                                      \
> +            result = (MAX_RES);                                           \
> +        } else {                                                          \
> +            result = (OTYPE)shx;                                          \
> +        }                                                                 \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NCLIPR_SIGNED_PACK(NAME, ETYPE, STYPE, CTYPE, OTYPE,    \
> +                                     ELEMS, IBITS, OBITS, IMASK, SHMASK,  \
> +                                     RMASK, MIN, MAX, MIN_RES, MAX_RES)   \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        STYPE e1_s = (STYPE)e1;                                           \
> +        uint64_t shx = (((uint64_t)e1_s << 1) >> shift) & (RMASK);        \
> +        CTYPE round_shx = (CTYPE)((shx + 1) >> 1);                        \
> +        OTYPE result;                                                     \
> +                                                                          \
> +        if (round_shx < (MIN)) {                                          \
> +            sat = 1;                                                      \
> +            result = (MIN_RES);                                           \
> +        } else if (round_shx > (MAX)) {                                   \
> +            sat = 1;                                                      \
> +            result = (MAX_RES);                                           \
> +        } else {                                                          \
> +            result = (OTYPE)round_shx;                                    \
> +        }                                                                 \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NCLIP_UNSIGNED_PACK(NAME, ETYPE, WTYPE, OTYPE, ELEMS,   \
> +                                      IBITS, OBITS, IMASK, SHMASK, MAX)   \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        WTYPE shx = (WTYPE)e1 >> shift;                                   \
> +        OTYPE result;                                                     \
> +                                                                          \
> +        if (shx > (MAX)) {                                                \
> +            sat = 1;                                                      \
> +            result = (OTYPE)(MAX);                                        \
> +        } else {                                                          \
> +            result = (OTYPE)shx;                                          \
> +        }                                                                 \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NCLIPR_UNSIGNED_PACK(NAME, ETYPE, WTYPE, OTYPE, ELEMS,  \
> +                                       IBITS, OBITS, IMASK, SHMASK, MAX)  \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint32_t rd = 0;                                                      \
> +    uint8_t shift = shamt & (SHMASK);                                     \
> +    int sat = 0;                                                          \
> +                                                                          \
> +    for (int i = 0; i < (ELEMS); i++) {                                   \
> +        ETYPE e1 = (ETYPE)((s1 >> (i * (IBITS))) & (IMASK));              \
> +        WTYPE shx = ((WTYPE)e1 << 1) >> shift;                            \
> +        WTYPE round_shx = (shx + 1) >> 1;                                 \
> +        OTYPE result;                                                     \
> +                                                                          \
> +        if (round_shx > (MAX)) {                                          \
> +            sat = 1;                                                      \
> +            result = (OTYPE)(MAX);                                        \
> +        } else {                                                          \
> +            result = (OTYPE)round_shx;                                    \
> +        }                                                                 \
> +        rd |= ((uint32_t)result) << (i * (OBITS));                        \
> +    }                                                                     \
> +                                                                          \
> +    if (sat) {                                                            \
> +        env->vxsat = 1;                                                   \
> +    }                                                                     \
> +    return rd;                                                            \
> +}
> +
> +#define GEN_PSIMD_NARROW_SRA(NAME)                                        \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    __int128_t s1_s128 = (__int128_t)((int64_t)s1);                       \
> +    __int128_t s1_s96 = (s1_s128 << 32) >> 32;                            \
> +                                                                          \
> +    return (uint32_t)(s1_s96 >> (shamt & 0x3F)) & 0xFFFFFFFF;             \
> +}
> +
> +#define GEN_PSIMD_NARROW_RNDSRA(NAME)                                     \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    __int128_t s1_s128 = (__int128_t)((int64_t)s1);                       \
> +    __int128_t s1_s96 = (s1_s128 << 32) >> 32;                            \
> +    __uint128_t shx_97bit = ((__uint128_t)s1_s96 << 1);                   \
> +    uint64_t shx = (uint64_t)(shx_97bit >> (shamt & 0x3F)) & 0x1FFFFFFFF; \
> +                                                                          \
> +    return (uint32_t)((shx + 1) >> 1);                                    \
> +}
> +
> +#define GEN_PSIMD_NARROW_ALIAS(NAME, TARGET)                              \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    return HELPER(TARGET)(env, s1, shamt);                                \
> +}
> +
> +typedef struct {
> +    __uint128_t low;
> +    uint8_t high;
> +} PsImdUint129;
> +
> +static inline PsImdUint129 psimd_uint129_lshift1(__int128_t val)
> +{
> +    PsImdUint129 result;
> +    __uint128_t uval = (__uint128_t)val;
> +
> +    result.low = uval << 1;
> +    result.high = (uval >> 127) & 0x1;
> +    return result;
> +}
> +
> +static inline PsImdUint129 psimd_uint129_rshift(PsImdUint129 val,
> +                                                uint32_t shamt)
> +{
> +    PsImdUint129 result;
> +
> +    if (shamt == 0) {
> +        return val;
> +    } else if (shamt >= 129) {
> +        result.low = 0;
> +        result.high = 0;
> +    } else if (shamt == 128) {
> +        result.low = val.high;
> +        result.high = 0;
> +    } else {
> +        result.low = (val.low >> shamt) |
> +                     ((__uint128_t)val.high << (128 - shamt));
> +        result.high = val.high >> shamt;
> +    }
> +    return result;
> +}
> +
> +#define GEN_PSIMD_NCLIP(NAME)                                             \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    __int128_t s1_s128 = (__int128_t)((int64_t)s1);                       \
> +    int64_t shx = (int64_t)(s1_s128 >> (shamt & 0x3F));                  \
> +                                                                          \
> +    if (shx < -2147483648LL) {                                            \
> +        env->vxsat = 1;                                                   \
> +        return 0x80000000U;                                               \
> +    } else if (shx > 2147483647LL) {                                      \
> +        env->vxsat = 1;                                                   \
> +        return 0x7FFFFFFFU;                                               \
> +    } else {                                                              \
> +        return (uint32_t)(shx & 0xFFFFFFFF);                              \
> +    }                                                                     \
> +}
> +
> +#define GEN_PSIMD_NCLIPR(NAME)                                            \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    __int128_t s1_s128 = (__int128_t)((int64_t)s1);                       \
> +    PsImdUint129 shx_129bit = psimd_uint129_lshift1(s1_s128);             \
> +    PsImdUint129 shx = psimd_uint129_rshift(shx_129bit, shamt & 0x3F);    \
> +    int64_t round_shx = (int64_t)((shx.low + 1) >> 1);                    \
> +                                                                          \
> +    if (round_shx < -2147483648LL) {                                      \
> +        env->vxsat = 1;                                                   \
> +        return 0x80000000U;                                               \
> +    } else if (round_shx > 2147483647LL) {                                \
> +        env->vxsat = 1;                                                   \
> +        return 0x7FFFFFFFU;                                               \
> +    } else {                                                              \
> +        return (uint32_t)round_shx;                                       \
> +    }                                                                     \
> +}
> +
> +#define GEN_PSIMD_NCLIPU(NAME)                                            \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    uint64_t shx = s1 >> (shamt & 0x3F);                                  \
> +                                                                          \
> +    if (shx > 4294967295ULL) {                                            \
> +        env->vxsat = 1;                                                   \
> +        return 0xFFFFFFFFU;                                               \
> +    } else {                                                              \
> +        return (uint32_t)(shx & 0xFFFFFFFF);                              \
> +    }                                                                     \
> +}
> +
> +#define GEN_PSIMD_NCLIPRU(NAME)                                           \
> +uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
> +{                                                                         \
> +    __uint128_t shx_65bit = (__uint128_t)s1 << 1;                         \
> +    __uint128_t shx = shx_65bit >> (shamt & 0x3F);                        \
> +    uint64_t round_shx = (shx + 1) >> 1;                                  \
> +                                                                          \
> +    if (round_shx > 4294967295ULL) {                                      \
> +        env->vxsat = 1;                                                   \
> +        return 0xFFFFFFFFU;                                               \
> +    } else {                                                              \
> +        return (uint32_t)(round_shx & 0xFFFFFFFF);                        \
> +    }                                                                     \
> +}
> +
> +/* Basic addition operations (non-saturating) */
> +


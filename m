Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C6DCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2wV-0000EM-UT; Wed, 13 May 2026 02:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN2vz-0008Rz-8k; Wed, 13 May 2026 02:19:14 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN2vt-0006yG-3q; Wed, 13 May 2026 02:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/08nS60a4j5FjGLM6kVGyuRXy8yGui8NouADDjc/EbFzwmSQMhDh8TtR4xvlaM7qz86kfXcXd61GrBvfCeFvjWauVissVpwdy0OIcP6GupdqWSvZI1/69dY3kDixnDTxXSF6hknUmoAiB7bmgz6IbWOCgHtaBnvp2no/ff2hS9zEuAeHgOyQxJJEWxzulEVJ/2vvhZ3CY/l110MS5H3rH62w3tkEZEyhpjqgxh+DCfF6Y97bxZ5tfw8LMyZyE8NQ2FNJDE505viVf5oNXiPlPjADPwBKYG4nw/LjvRkaGDgdYVPuETAk4UkSjJZqpxCTGYYAyTg8tM2F9aqpkT79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsNMlxnsvdz379nphafqar95wXQB7Cs92ZmVMAl1XZ0=;
 b=nuuP9DXlHnKUSRdYpDJ1YwMeb262uPGtCrqhQQaclFHt1hSwlltAeKGgLUlrgbmg2qmz+oenEy7kJe/e2LiY8aIdvKkMqlMdj1UL5NBJ6hZDXPfrbD0d6eigxz8z7MDi2UCX4rQvX+EL0+KL/WK+73kQDRBWVPY4fHA9mQix0JIMJbT5W4wvrsSoYQHAVU/bVqA/QfOmuBWGYxnJOaej8BT96+JAPaActAnR8IDJj1tcfRhR+MHBLDh0t9RkQ5OFZT2aUTrj99p6lHsEuDpydqIU+jO/XUt+wzF9XmcetJbElDqNMBtrcg3GBpuOuBpMXJIXE/hZ0rmoRyFM9JzmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsNMlxnsvdz379nphafqar95wXQB7Cs92ZmVMAl1XZ0=;
 b=J6LP6iZqvrzQ8FlG7JlPEsRbM2d9FtMAAx1IZsGtFDsEKzFEgWoTMvPEpAxdwuGmXU0KOA+nm1dhv6W8R2sj47muiFzayDB5rMm94uIgS/3AfEjScLtJn3KNbDnu8skURIZXeLA45SZjS48f3PfCwORyqWDvJYDUyGWFGspzXg8O1knimWQ4D46bwDU3PQpEtNC7OBXKvXM02SRgKYTlMc7uYwaP2HZOSlfUJ/RQkUt10Vwhcs4bEURTwBFTQgtgN4TFIIDcx11QMW4KdPFjXgVSgfHhRZcActC3TK0jXjEltHEIs+L6KZBmf27ARVmhuUR10+TJCUon//0qjMrTUw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR04MB7745.apcprd04.prod.outlook.com (2603:1096:820:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 06:18:51 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 06:18:50 +0000
Message-ID: <SE3PR04MB89220769593142A04964D9F5F3062@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 13 May 2026 14:18:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] target/riscv: Implement core SMMPT lookup logic
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
 <20260511124705.28161-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260511124705.28161-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <50add3ae-9350-482b-a97c-4ee2d6af747a@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 60206389-8a43-4a29-74a8-08deb0b77f87
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|45011099003|51005399006|41001999006|5072599009|6090799003|8060799015|12121999013|23021999003|15080799012|19110799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWZPYlNOTUh2dEdERkx0dXFhVmpvWEp3c3pjV1ptMFpzMXBBTkcybHhReXBB?=
 =?utf-8?B?YkVOSllacFZZVUd0Nk81YTNHQ0ZUdjBIZWpWRlh0Q0tnUzZpS0FLcTFBM0R0?=
 =?utf-8?B?dXZWQmt4NGxQM2twa0x2VFRyWmlBbGYrKzFvamxiMnVtcEhJVitsSDRZZndJ?=
 =?utf-8?B?clF0UFA5RlFwM2lOQnRoR0RjSHZoNXBIT2duUys0Z09RTnh4MzN4QksvdzVy?=
 =?utf-8?B?dUtqMVhBRnN6NW51M2htb1NIRm5vVHpVKzJKMXNqWVJpb2Fkc2dPRWUrc0h0?=
 =?utf-8?B?dEZKQ0tmaGgzZWYyaUpOUno1Umo5YjZpM0ZhTFpoM0oyZ0RYdzBPZTRkUDlW?=
 =?utf-8?B?aUNmeEp6c3F4bzdVZDZPZjNweDlkb0ZPcjdieHdGakgvdVhiWlRJUXY2VkVP?=
 =?utf-8?B?VWxEWEhjYnlLeThsNGtkL0NNKzJMaGVSZFVCa0t2UmtHbHl5ZVhPcmVzcWxM?=
 =?utf-8?B?QkhtbkExWFo3d3hjSTdHdmhabzg5UlROcUlkQTd4aFVLczI3WlFHdzFmbGZM?=
 =?utf-8?B?Z2VxeGtyRVZqcTRQUGJYbGY1TkNNVGlVMFVETTY4cVd6SzFlU1cycjdsSkRL?=
 =?utf-8?B?dUFtOFJESXY2RzFjV2dRaGZ6Um9pUHQ4cWlvZHU0bTJiYkkrVVR0dG5vTjAx?=
 =?utf-8?B?cGRLK0hwU0VJVStmU01zc0pHZzRkWDVQeVluaytOeW5WTEMzNTR5Um4xTi85?=
 =?utf-8?B?eE1WTXRaOHRvMnF6T1k2N0lSeE1PRUNnVFd2UXAveno4Q2xJWi80SFVYcGxS?=
 =?utf-8?B?b00vbG02ZU1sQ1RZb3dTN05hMld5TnpMYnJKUURvbE1sZ2NMZi9rK3ZZcmZK?=
 =?utf-8?B?YlNzUlpwV2NQM1E3SVBLZ21ZaFZSL0FMYnNhcFQwR0x2QkEva0RJNFhrVmZI?=
 =?utf-8?B?U3Y5cTRZV1lzWGJRMkcxQmNITkY0aWtSRklPSG9mS1FxbklUUmMySm9vZ3BD?=
 =?utf-8?B?TEdMTk9UTFhCMFpxTGtnQWVCQlE2S21hV3IzUUFiTmtmeWdUc05TY2JwVWZs?=
 =?utf-8?B?blVnT25DN0RXOWJoY2NOaGZMRXh0eEpVeFZEZ2o5ck9oaHlPKzZpOFVpa2xJ?=
 =?utf-8?B?U3pZKzQ4MW5hSFdhQmNrN0Q0YjVTYVI5OGJQR2U5U3J2eit4SkU5cVZaa1Ev?=
 =?utf-8?B?aHJCK2I5MGJCbWJXaWhGQmFFK3dGUGZCTzhraW12cklyNHNVZXZNR3BMaWdB?=
 =?utf-8?B?NDRsbjBOK0I1L0dCZWU0NTI2OWJYRzZQZTI2a0NBTm9ULzFHTWNha0dwMlE1?=
 =?utf-8?B?MDVrMi9YZktIY0V4WmZEeVhRNkdiRE5lZjBiV0hEL2FmbkpFaDFTRnd4Mmxh?=
 =?utf-8?B?ODQ4Rnp2d2J2QjBwQkFteE9BdS9iRXl0bmxkSW5ZaFBZdHBzMm9VSzJUbUdP?=
 =?utf-8?Q?mW5Gy3dkrrYQMEOrF6K3JeatOotpwfLY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTFobkNLdUVUb0lzU1Rkc3ZvZE5Vb1RKUlB4QXJ2OWdOWHRHcFhRcmJHTHJv?=
 =?utf-8?B?blhlOUpUS1QzZkdFZ3RWQW8zMWJCWmNpbWZRbkNnK2kvbWEvSCtaK0JJZmc2?=
 =?utf-8?B?Y2pldmFyQ0lOK2VGYTJwTmxMOU1vMDhPZFYwVGxtbkxvVjdCT0RYanJrNFZl?=
 =?utf-8?B?NmZKRDFLaGNNZ211SWxHRXJGdnpNTHd1a3A4TnNqcm5zcWZxS1Roeit5SFlu?=
 =?utf-8?B?MHJEa0dybHlLVDN3cjBwUU1tVGRCT0tHRGRIejdNamVPNDI0OGwyWVN1MU1o?=
 =?utf-8?B?dGhUc01VUVJ6UUxjNnJOZGQvYVQxNll6SFlmVCszYUMwdWJRNXJLVnVHdUdm?=
 =?utf-8?B?dkk5bDl2QmhGSW81aklMUzRVV1dwUGE1RWtFSHRGMVBkVEVEcUN0WVA5SFNJ?=
 =?utf-8?B?VGFBTGZkWjhZalc4WHE0L25SalIreU1MUE9iZU9RcWpROGYxZnN6eGFWc05I?=
 =?utf-8?B?dmoreWdlZVpTQ0M2VVFsajhrREViRmE4TG0wNU9GREJNcnpjdzY1Ni9mWStn?=
 =?utf-8?B?VXBES01CV2d1N1k4UTFRK0hOQXZxdWJ5b2FRRmd5YnN0YXBZNkpRKzI1cTR5?=
 =?utf-8?B?cGVqRkRpWEdoR1NSTjZ3dFJGeTVtYWhvMmdmU0FWRDNJQXJwZVRqOUtsUm1O?=
 =?utf-8?B?Qy83QUpCS2cwUmZ3ZjV0Wlgzb283RnZyeWxyTXc0d3JoSmc2WjhjT01mODBp?=
 =?utf-8?B?cng2UWJQWDNjNHpaa0RYa3dQWlJubjVJc1l1QUNGRGJ0QUMyV0JvTCtBUnh6?=
 =?utf-8?B?NXZadGt3eVRDODZZNGVQcTRjcTdKakpRRjVGMEtENVlCQ2lBOFBUWXBDRUIr?=
 =?utf-8?B?dmgvZDFyb1BmeG9icWhISERueWlhRHowZlNpbmh3ajlvcTJKTElXNWlxNGhS?=
 =?utf-8?B?Tm1jT2l5bmlReGZpOUx6M1EvRDRJb01nSWgvRnZmVkhWeFJaV012WEw2WUxG?=
 =?utf-8?B?Z3o1UWdkQ3VBK2NmbjYxL3J2VEJpYzB2OGVKdG1sTTREM0lnaXh3bldQV01a?=
 =?utf-8?B?S2xJT2p0NmMyNW51OWE2aEdPcVRwZy9KV2ZLVGhuT0tGWnVkK0Zpc09kdy9O?=
 =?utf-8?B?ajBxb2NJSFVoRi9YU2cxcFJmdDlvSHI3ekFIRFp0dHc4ak5PTXZreEpzRXhL?=
 =?utf-8?B?K04yZmRtb1RYUXR5NVZ5Y252QTIyTWkvZXFSRS94OTdjUitXMVluK2YyRGRE?=
 =?utf-8?B?bEVRSE5lc3JpVGw4QWYvaDRmb0pJNVdmUnBESDBZQlJ4ekxzRms0UmR3SmE3?=
 =?utf-8?B?OVBKY1UyTUcrajdJYWdmam1tZTNjQ0xrQkZUS3h2eXplalVxQ1RKeTh3TWtK?=
 =?utf-8?B?Mm9kSExPNFhTUTB6ZG9pMmJDREJrd2szYmpDRnZNREJ2YlZpdHVXK3JVZmdZ?=
 =?utf-8?B?TGQ0YzVSNjE4eWpTM1hXbEhwM3VPSmtaMERTM2NKUHRUN1U4YzB3SDMvaHRj?=
 =?utf-8?B?QnVvd3lTU0kvYzlvOHc3cWhRY2ZIa1IwMzZydnpuNW4wOUQ2bXNPRTBrQTZ2?=
 =?utf-8?B?WHVMalRxYnhDK2VKUkNkalRyTDBDOXFwampMcWZGQXFMcE9rYUZ4dnhTejFz?=
 =?utf-8?B?MHNKUmFJWVdXVlM3eTMyaVFYancvRGUzRVhRb05IOWdBTlNlU0h1b1RFYTBt?=
 =?utf-8?B?NTA2YkIxTm1xamd3a2JSWXVFUk9CQkFKcnkyMXFpN3BDa1Z0aGRZT3VFZ1ha?=
 =?utf-8?B?d0hBdVZKY0FUWnBKSHRxQkVTQVVJbEUvZi8zbDgxbmV4TU9qVERJRUl0elNW?=
 =?utf-8?B?YjRKMTZySVVzVndaY3lNYU12enZGbDI1SDQzSSt6djhZRVpTMHU3dFNjaUZi?=
 =?utf-8?B?cHJoZ3NuNndXWUM2Qm16ZE1Sb3RCcXhSY3pQYmR6Q2hnTjE1QWh5YlBBcHFj?=
 =?utf-8?Q?sXAxMEKqBWvDg?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60206389-8a43-4a29-74a8-08deb0b77f87
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:18:50.4281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7745
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
> This patch introduces the core implementation for the Memory Protection Table
> (MPT) walk, which is the central mechanism of the SMMPT extension.
>
> A new file, `riscv_smmpt.c`, is added to encapsulate the MPT logic. It
> implements the `smmpt_lookup()` function, which performs a multi-level
> page table-like walk starting from the physical address specified in the
> `mptppn` CSR field. This walk determines the access permissions (read,
> write, execute) for a given physical address.
>
> The implementation supports various SMMPT modes (SMMPT34, SMMPT43, etc.) and
> correctly handles leaf and non-leaf entries, including reserved bit
> checks. Helper functions for parsing MPT entries and converting access
> permissions are also included in the new `riscv_smmpt.h` header.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu_helper.c  |   5 +-
>   target/riscv/meson.build   |   1 +
>   target/riscv/pmp.h         |   3 +
>   target/riscv/riscv_smmpt.c | 227 +++++++++++++++++++++++++++++++++++++
>   target/riscv/riscv_smmpt.h |   5 +
>   5 files changed, 238 insertions(+), 3 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 39c3486ae0..d0f0e77dfe 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1139,9 +1139,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>    * @access_type: The type of MMU access
>    * @mode: Indicates current privilege level.
>    */
> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> -                                    int size, MMUAccessType access_type,
> -                                    int mode)
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type, int mode)
>   {
>       pmp_priv_t pmp_priv;
>       bool pmp_has_privs;
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 79f36abd63..568ea4bd88 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -35,6 +35,7 @@ riscv_system_ss = ss.source_set()
>   riscv_system_ss.add(files(
>     'arch_dump.c',
>     'pmp.c',
> +  'riscv_smmpt.c',
>     'debug.c',
>     'monitor.c',
>     'machine.c',
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 17307ef88a..02d6d712ba 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -87,6 +87,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
>   uint32_t pmp_get_num_rules(CPURISCVState *env);
>   int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
>   void pmp_unlock_entries(CPURISCVState *env);
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type,
> +                             int mode);
>   
>   #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
>   #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
> diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
> new file mode 100644
> index 0000000000..3e9eccf70e
> --- /dev/null
> +++ b/target/riscv/riscv_smmpt.c
> @@ -0,0 +1,227 @@
> +/*
> + * QEMU RISC-V Smmpt (Memory Protection Table)
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "riscv_smmpt.h"
> +#include "pmp.h"
> +#include "exec/page-protection.h"
> +#include "system/memory.h"
> +
> +typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
> +                               MemTxAttrs, MemTxResult *);
> +
> +static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
> +                              MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldl_le(as, addr, attrs, result);
> +}
> +
> +static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
> +                              MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldq_le(as, addr, attrs, result);
> +}
> +
> +/*
> + * MPT entry bit field positions:
> + *
> + * 32-bit leaf:     v[0], l[1], rsv1[6:2], perms[30:7], n[31]
> + * 32-bit nonleaf:  v[0], l[1], rsv1[9:2], ppn[31:10]
> + * 64-bit leaf:     v[0], l[1], rsv1[9:2], perms[57:10], rsv2[62:58], n[63]
> + * 64-bit nonleaf:  v[0], l[1], rsv1[9:2], ppn[61:10], rsv2[62], n[63]
> + */
> +
> +static inline bool mpte_is_leaf(uint64_t mpte)
> +{
> +   return mpte & 0x2;
> +}
> +
> +static inline bool mpte_is_valid(uint64_t mpte)
> +{
> +    return mpte & 0x1;
> +}
> +
> +static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    bool leaf = mpte_is_leaf(mpte);
> +
> +    if (mxl == MXL_RV32) {
> +        /* leaf32.rsv1 = bits[6:2], nonleaf32.rsv1 = bits[9:2] */
> +        return leaf ? extract32(mpte, 2, 5) : extract32(mpte, 2, 8);
> +    }
> +    if (leaf) {
> +        /* leaf64.rsv1 = bits[9:2], leaf64.rsv2 = bits[62:58] */
> +        return (extract64(mpte, 2, 8) << 5) | extract64(mpte, 58, 5);
> +    }
> +    /* nonleaf64.rsv1 = bits[9:2], nonleaf64.rsv2 = bit[62] */
> +    return (extract64(mpte, 2, 8) << 1) | extract64(mpte, 62, 1);
> +}
> +
> +static uint64_t mpte_get_perms(CPURISCVState *env, uint64_t mpte)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +
> +    /* leaf32.perms = bits[30:7], leaf64.perms = bits[57:10] */
> +    return (mxl == MXL_RV32) ? extract32(mpte, 7, 24) : extract64(mpte, 10, 48);
> +}
> +
> +static bool mpte_check_nlnapot(CPURISCVState *env, uint64_t mpte, bool *nlnapot)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    uint64_t n_bit, ppn;
> +
> +    if (mxl == MXL_RV32) {
> +        *nlnapot = false;
> +        return true;
> +    }
> +    /* nonleaf64.n = bit[63], nonleaf64.ppn = bits[61:10] */
> +    n_bit = extract64(mpte, 63, 1);
> +    ppn = extract64(mpte, 10, 52);
> +    *nlnapot = n_bit;
> +    return n_bit ? (ppn & 0x1ff) == 0x100 : true;
> +}
> +
> +static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte, int pn,
> +                             bool nlnapot)
> +{
> +    RISCVMXL mxl = riscv_cpu_mxl(env);
> +    /* nonleaf64.ppn = bits[61:10], nonleaf32.ppn = bits[31:10] */
> +    uint64_t ppn = (mxl == MXL_RV32) ? extract32(mpte, 10, 22)
> +                                     : extract64(mpte, 10, 52);
> +
> +    if (nlnapot) {
> +        return deposit64(ppn, 0, 9, pn & 0x1ff);
> +    }
> +    return ppn;
> +}
> +
> +/* Caller should assert i before call this interface */
> +static int mpt_get_pn(hwaddr addr, int i, mpt_mode_t mode)
> +{
> +    if (mode == SMMPT34) {
> +        return i == 0
> +            ? extract64(addr, 15, 10)
> +            : extract64(addr, 25, 9);
> +    } else {
> +        int offset = 16 + i * 9;
> +        if ((mode == SMMPT64) && (i == 4)) {
> +            return extract64(addr, offset, 12);
> +        } else {
> +            return extract64(addr, offset, 9);
> +        }
> +    }
> +}
> +
> +/* Caller should assert i before call this interface */
> +static int mpt_get_pi(hwaddr addr, int i, mpt_mode_t mode)
> +{
> +    if (mode == SMMPT34) {
> +        return i == 0
> +            ? extract64(addr, 12, 3)
> +            : extract64(addr, 22, 3);
> +    } else {
> +        int offset = 16 + i * 9;
> +        return extract64(addr, offset - 4, 4);
> +    }
> +}
> +
> +static bool smmpt_lookup(CPURISCVState *env, hwaddr addr, mpt_mode_t mode,
> +                         int *prot, MMUAccessType access_type)
> +{
> +    MemTxResult res;
> +    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> +    CPUState *cs = env_cpu(env);
> +    hwaddr mpte_addr, base = (hwaddr)env->mptppn << PGSHIFT;
> +    load_entry_fn *load_entry;
> +    uint32_t mptesize, levels, xwr;
> +    int pn, pi, pmp_prot, pmp_ret;
> +    uint64_t mpte, perms;
> +
> +    switch (mode) {
> +    case SMMPT34:
> +        load_entry = &load_entry_32; levels = 2; mptesize = 4; break;
> +    case SMMPT43:
> +        load_entry = &load_entry_64; levels = 3; mptesize = 8; break;
> +        break;
> +    case SMMPT52:
> +        load_entry = &load_entry_64; levels = 4; mptesize = 8; break;
> +    case SMMPT64:
> +        load_entry = &load_entry_64; levels = 5; mptesize = 8; break;
> +    case SMMPTBARE:
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return true;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    for (int i = levels - 1; i >= 0 ; i--) {
> +        /* 1. Get pn[i] as the mpt index */
> +        pn = mpt_get_pn(addr, i, mode);
> +        /* 2. Get mpte address and get mpte */
> +        mpte_addr = base + pn * mptesize;
> +        pmp_ret = get_physical_address_pmp(env, &pmp_prot, mpte_addr,
> +                                           mptesize, MMU_DATA_LOAD, PRV_M);
> +        if (pmp_ret != TRANSLATE_SUCCESS) {
> +            return false;
> +        }
> +        mpte = load_entry(cs->as, mpte_addr, attrs, &res);
> +        /* 3. Check valid bit and reserve bits of mpte */
> +        if (!mpte_is_valid(mpte) || mpte_get_rsv(env, mpte)) {
> +            return false;
> +        }
> +
> +        /* 4. Process non-leaf node */
> +        if (!mpte_is_leaf(mpte)) {
> +            bool nlnapot = false;
> +            if (i == 0) {
> +                return false;
> +            }
> +            if (!mpte_check_nlnapot(env, mpte, &nlnapot)) {
> +                return false;
> +            }
> +            base = mpte_get_ppn(env, mpte, pn, nlnapot) << PGSHIFT;
> +            continue;
> +        }
> +
> +        /* 5. Process leaf node */
> +        pi = mpt_get_pi(addr, i, mode);
> +        perms = mpte_get_perms(env, mpte);
> +        xwr = (perms >> (pi * 3)) & 0x7;
> +        switch (xwr) {
> +        case PAGE_READ:
> +            *prot = PAGE_READ;
> +            return access_type == MMU_DATA_LOAD;
> +        case PAGE_EXEC:
> +            *prot = PAGE_EXEC;
> +            return access_type == MMU_INST_FETCH;
> +        case PAGE_READ | PAGE_EXEC:
> +            *prot = PAGE_READ | PAGE_EXEC;
> +            return (access_type == MMU_DATA_LOAD ||
> +                    access_type == MMU_INST_FETCH);
> +        case PAGE_READ | PAGE_WRITE:
> +            *prot = PAGE_READ | PAGE_WRITE;
> +            return (access_type == MMU_DATA_LOAD ||
> +                    access_type == MMU_DATA_STORE);
> +        case PAGE_READ | PAGE_WRITE | PAGE_EXEC:
> +            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +    return false;
> +}
> +
> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
> +                        int *prot, MMUAccessType access_type)
> +{
> +    mpt_mode_t mode = env->mptmode;
> +
> +    return smmpt_lookup(env, addr, mode, prot, access_type);
> +}
> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
> index 74dcccf4be..c15637036e 100644
> --- a/target/riscv/riscv_smmpt.h
> +++ b/target/riscv/riscv_smmpt.h
> @@ -9,6 +9,9 @@
>   #ifndef RISCV_SMMPT_H
>   #define RISCV_SMMPT_H
>   
> +#include "cpu.h"
> +#include "exec/mmu-access-type.h"
> +
>   typedef enum {
>       SMMPTBARE = 0,
>       SMMPT34   = 1,
> @@ -18,4 +21,6 @@ typedef enum {
>       SMMPTMAX
>   } mpt_mode_t;
>   
> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
> +                        int *prot, MMUAccessType access_type);
>   #endif


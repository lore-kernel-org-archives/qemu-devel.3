Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ABBEE6428
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 14:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vawqX-0003NJ-Qi; Wed, 31 Dec 2025 09:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vatU2-0000H9-Bt; Wed, 31 Dec 2025 05:31:14 -0500
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vatU0-00053M-T5; Wed, 31 Dec 2025 05:31:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ7+tvwCm+7H7Bl2rBumbArEXTSEWsKkSrW7c+cVT4TvsEfxqkS5CvIWgX1JGWn94dRQx89H1U+B1KIw8EO4Sv2ERkFXN91w/XbH8a0KYPFXCxAUw74aPz4CB5aRztZoVuXFUlsAMGdOcgcNaMi/Ym0uY3wBgWX9OkfXa4QtTQNuO5DXd09PIwPjk6aCXSU8eLCSXMYMscqk21feJOPoX6dWUBxxjK+SjOf1tZFMaIQbvH20ipCODIVKXJGXtWrpOS64nTZDfI75SdDhbdIxVYYqau2HRxPBPPd2dxjFsRHXOLRV3f3Z/OKY43/CiHbLgHiDBUiZQIqlOMh1atCjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NYWBBPC7RTt1kx3mQxy8XzMqz1+6zkzITP0CD4UgHM=;
 b=kpKLak7+Z1SPW12dfbGTnG/MA/f8TEYqCxwNIIAZ4F1F5oVMe8f6rFOTlsWJ/uUL9rg/4JqjkDieBWcDh/gEU61AtGLQcb63niVNNfhOK0UiKG4weIYnyT+A8+pbvpC/vMUHzdyD9OhYzg2zz6kC74m2XYS7s0CA/Ujxog1YiT2z7MoS0WDjhj3ylHvgg8jhp9vX6YBpBf0GjiKDqwD3tgVc0IUYABPcV+X37YZwrxN9rwPndoXfzaVNl3Z8f9m9z8tGEWTIbW5/iRT1GU+wYat8ArjcqrdQeGBoesSSah8wsItm1KWFDYEcm1mPVrujJQxbq/MlWVDjn6VgBfD9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NYWBBPC7RTt1kx3mQxy8XzMqz1+6zkzITP0CD4UgHM=;
 b=WryNJamxvkRGY5v1RRgTAJbzj84hv4qw/FFs0kKMOekLM0S1/kHesIsBkJ981DMiUv4NvS8om4ZXFM2vfhw967Turz7bCKp4SYBhtKKY7yCl9qfABS0dVxr1mYlSRL72urEvoXwVrvE6VnKgwayNcusEO10ECGDTYcsTotZFrPab39oEzMrBXbdGBjLDLpFWWvXSHZNzxuJC9sh/wxIUXjHK5DGjZRuC20rjd3LGoli2Aou1Jpuakoa9FxfLvcfsSAbCj1zkZntV2OGApwYwSLRxQy/58Ts7GihpIxMhAuV9+hLZmDE4CEhn7m4+LwMm81qNddwAHH5ZD8KarL/vyw==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by TY2PPFE9D860EDA.apcprd04.prod.outlook.com (2603:1096:408::af2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 10:31:06 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%5]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:31:06 +0000
Message-ID: <KUZPR04MB92653B14744CA21D70EF915BF3BDA@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Wed, 31 Dec 2025 18:31:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20251219040943.1570449-1-frank.chang@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20251219040943.1570449-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To KUZPR04MB9265.apcprd04.prod.outlook.com
 (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <be8b251c-9fe4-407b-8a75-0c1ac628956d@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|TY2PPFE9D860EDA:EE_
X-MS-Office365-Filtering-Correlation-Id: 24668d9f-d0e4-47b1-c285-08de4857b480
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7042599007|461199028|12121999013|8060799015|23021999003|6090799003|15080799012|51005399006|19110799012|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWxiSk5BTFRXM1NpdWpFUGZ6RHhPMUFVYjhDWmt2eWl5ekRIeWJNT0Z6ZTIy?=
 =?utf-8?B?MjI1MjBueUVreVFyVVRhS3FrOURJM3BWcEhHQ1V6dmw0aXV5RDNqZWthK1JT?=
 =?utf-8?B?K3lRcHEvSU1Uc1Avclc3cEFCdHBuMUNjWkMwL2YxUUsrMXNwdzlhQVhUZUFN?=
 =?utf-8?B?RmN5Vkl1WENVa05rT0JiUmhwemEwSVBsdm1tVjhITUIwZytIZzRGaVk5T21O?=
 =?utf-8?B?UExlZGw5cG5zSUtpTHo3cDlNb3B2NlVPVWY1djhVKzY4WUxKUGZINlByZHg5?=
 =?utf-8?B?ZEI3VDVlbUJWOVJUZ1Frek1GL1VTaDQ2RUwrdHJPV1ZmMnIzcWtlNEowUnY3?=
 =?utf-8?B?RE9GMVhtMnhLcHQrblljWEl3dXkyT3RLTFM1MXd6OVFmN3dBdEhRVG1sWHJF?=
 =?utf-8?B?RVMwTHh0QkU4V2dQeHNOQm44Z1MzQzJXMGcycTdGVW5WQWE5UmFlTXNSb216?=
 =?utf-8?B?WUU1azF1czhiamlHelkxQVZTN3ZUYVpOQnhiVk9QUWRCZVBBWUFudS9LN0Nk?=
 =?utf-8?B?WU9SeUhCcjRKQnY4VGxTekMyVGU1SUpQOVJjSHovQmNQczhhK2VQSkphVEFY?=
 =?utf-8?B?dUV1eWMyc3NIZU53WlFoNkhNSG10Zm42bis4bUpvaHByWHAzY0lqSXU1T0ti?=
 =?utf-8?B?ZmlBcHRhelQ4S2xYclZ6b3ZLaHVEM0NYdDQ3bWFsM2NGam5ISnJCclNOaTZB?=
 =?utf-8?B?Z0NGOUZXaFZ2dWZ0K2FNeEhVQUhodm4vYXlESC9lMk5WUjhhLzVRRHpvbU9P?=
 =?utf-8?B?MG1sTEpHOVU4dklkbjdLQlZhRG4rbUxXRkowNTlXNjNsYlZJM0FCTVlRTkxu?=
 =?utf-8?B?STlhNHZER0xhUE40QWt1ZnUydEFRbXhlcitHclorSWxLOVI0aTNRalhONHpH?=
 =?utf-8?B?MVY4dWR4dlRrZEpUamdhNlFvUWlYN05KTnVkdUxvMHBUamhUVURlenJlS1Z5?=
 =?utf-8?B?SVV1WHdLSWRqTEp4d3dEdzlodFRmVW5NOEV5bzlpR1RuUkZTWHFjVDZHVFph?=
 =?utf-8?B?bUpPOXg3K1ZiVXg0d2VpNmZxbm9UY2I2SUhsTUtxREN2aFRGTkFpTktsY2Nt?=
 =?utf-8?B?YTVSYk9vR3ZrN2NOdmhQaWxTSkVrTkYrVmZPeFpCWEFQM29WcW5OSitLR1Nn?=
 =?utf-8?B?NDdETnJvVVloSWdVYlNvbFpBL0ZSeXNjck9lRmdEblY1dDJJVDJYY0FhSGk1?=
 =?utf-8?B?MjIxSk9jQU9MOC9Pbit2UjFpckJRTm9sNm9GcGdUcTQxV2R3TU0zMWdrTmtU?=
 =?utf-8?B?M2FHdGdSUmFJT1h1bVREOEpzWTJNWlg1dUpyLzdCTnFPRUFEVEp0cW01OEFY?=
 =?utf-8?B?L2l4bFFEUGlqbjZnbnQzR2RhMllJdEo3T0J3azFNOW81U1JsWXRwTDY5VUxM?=
 =?utf-8?B?WkdNNXJhL0tuaGR4aWVSSk1YSys4Y3VocXhUM2ZWaEJvVlJFQnMrNmFRT294?=
 =?utf-8?B?N2tsaHEzN1pCZjdIK1dubDdxNlg2LzVtVEdhVGs3d0t3SjNvSnNnQjVzNDEy?=
 =?utf-8?B?cmhaMVFTS3kxclZha21Ra016dkZzTklPeEVwZGQxWHBjTmZJT3ZuOXdaci8y?=
 =?utf-8?B?SnlJdTViU3JyejNEZkpjREpvRmI3ak9FZENOVUxUa3QwUFRWNVpqZHpzUm4r?=
 =?utf-8?B?T3E4dHlNZ2N6MHFuY0NkS095TU5qclpvS2JENnpIeDl3d01YMURCVXBYRnBY?=
 =?utf-8?B?RUJPRFc0T2pCdHJBblpiN1lYSElxdmhtT2krbkFGbWVuakJ3TGRuUDNRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnRhNHJQakQ0TlVaZ0Q4VGJzNGVqN0Z1RVQzRHBvV0lTemRXSlJPRXZ4bHNP?=
 =?utf-8?B?SmltYVlyUkJrNjdxRTYwb0FiVlBOdmwwMElTRWpiK3pDVkxveTNFbDYyRjln?=
 =?utf-8?B?LzlTVDZEQ254ejd6SFphdHJnZmRubmVyL1NQVU1SMmNBS29sMWt6akZXbmQr?=
 =?utf-8?B?ZGQ0UHVLYkFaNXVOdDd0YngxbmhqYkNXYXBhMXZVVmJKbDBEVGdHeUwzVEpQ?=
 =?utf-8?B?R1A1V0xMRE50RGFEWEZFTE5hY0hjR200c3AycjFiTE1rTzB3cFFTYkt1UlBh?=
 =?utf-8?B?R1JXS0EyUElWazc5NFM4Z0xpTVYvZGZ3TzBxZGhUWkxZWmdRVzFlRE5paHYr?=
 =?utf-8?B?YU5oR3dZSFJmOWRacWJyS1ZRR0Y4Zkt6YlJ6bVd5MmIxcHRIUVZPQmxjaGw4?=
 =?utf-8?B?OUpweGVTZDhsQnpXQVd5OUZlWkdoRTVpVm1jSzVxUXJUejhiM1VsN1o2Zytr?=
 =?utf-8?B?STdYU1dmZjVob3NrYzY3MnpxSFVQQ284L3BYM0JSZ08rbldWaFpKMkswTjhq?=
 =?utf-8?B?RmZiOUFVcVI0TitiWlhXSjhxTy83akl3aXRBNmt4NGNRcG9IRi9oWUxMS2pM?=
 =?utf-8?B?aVRuR0VFZUpNYlMyOHhNenV6QUxveUJmUnYzRDI4aC9YU1ZxbmFPVWRZU1l5?=
 =?utf-8?B?ckM2SndWUUIxOVVRN05hSW9EQktTODBTdjVwL0JORThaWWdGVS83QkptY2Fm?=
 =?utf-8?B?Y2dlVFQ1aVlhOVlZTmFMVUxobm5kWE5RZ3hoUmg5dlNzMkhydThsK3RGYmVI?=
 =?utf-8?B?N3ZscjY5WGY3MERYSmhqc051U2FNYXhTaWpWZy9KTUVmWWZlRXZVZFlQSnNn?=
 =?utf-8?B?S203a2Z0YmVuQWtiZDA3MzBnRnpmc0dNUWpqMnpkeHR0bVhONU1MQ3U2akhB?=
 =?utf-8?B?Sys1THMxR0xyNHRWYVNhNmdYU1RvbzJnUE9ucjN3bEJaSTY3STFFSEdtbW5Y?=
 =?utf-8?B?T1VoRjJyUkZnMU4rL2FLN05zdFFEYm5XTHk3MGZ6U2JZTFBqc2N1cTlhNmND?=
 =?utf-8?B?MmE1VHlxeU01Tlh0SFRSM2FpR1pSaVMwVkxGemlkWmNESGVHTUl6ejc3R2lD?=
 =?utf-8?B?ZHMrRXlYejY1eGpjc0hYajdUUlRHbjcrY21QZkRJbW9KT2l1MHFIZ0x1ZHY3?=
 =?utf-8?B?Qkx6ME04eU9UZU9LU2lPY2VVQ2hzTXBraVM4UVVxcm1qcUg3NVNtdHVGMjJL?=
 =?utf-8?B?VWlBa0Fvd3BXSlJHdkxhUURpT3ViQTFQaVdMdkJ4eC80dVdsWjB5RGFuM3Ur?=
 =?utf-8?B?Q2dGSGx3aklNd083VEZHMUNtdnczbGxzZWEydVIrMWhQYW1CVWo0eVFhUFl1?=
 =?utf-8?B?R2tzVVowZFpGSUhOVUVLQzl3dnozMmFjVXdXUVNITndUU2NKcU41alhybmNN?=
 =?utf-8?B?MHZxNEVOSHUzZmhDQTlQYkliV0N4Q0xTTVFjKzdvL2lQN29YVjA2cno4MG5i?=
 =?utf-8?B?MWNCV3Axcy9ZQ2N0ZURNLzNoajh3QjY3U3YrSFU3emx3bFcyK0g0TXlTdERz?=
 =?utf-8?B?NSs5cmhIZGVraCt3bkxJYU9PQktCT0NjK0thOVBkUlBHTXNZbHNRblYxbWE2?=
 =?utf-8?B?NEZUcGl3azVaM3RZdi9laElDVkl2ZUM0UndlNDgxdC9WVE1EUDhwT21WRGh4?=
 =?utf-8?B?TzlUR2VnUlZDU2MyQk1HNis1dTgya05VN01IZHZtU0J0bWVFaEM3SzJHRzN1?=
 =?utf-8?B?UlFLOEE4dS9OWFVNczRaQVdhR1V1M1FEejAzUnlaTHAyd0x4VDA1OTZTanBl?=
 =?utf-8?B?VC9weU8zUDNTQXNVZmwzQ29HM1JtUzBEWHU3UG9wODlveFJtYk1nZm12dlM4?=
 =?utf-8?B?RnBjdEY5N2xXcGxuT3ZFZjlObU5qbUF6SVU5ZEVxdXJaTXNpNkFKcEJZVkls?=
 =?utf-8?Q?VcUpkXc4TQhDY?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 24668d9f-d0e4-47b1-c285-08de4857b480
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:31:06.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFE9D860EDA
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
X-Mailman-Approved-At: Wed, 31 Dec 2025 09:06:40 -0500
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

On 12/19/2025 12:09 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
>
> Use designated initializers to initialize riscv_excp_names[] and
> riscv_intr_names[] so that we don't have to explicitly add "reserved"
> items. Also, add the missing trap names: sw_check, hw_error,
> virt_illegal_instruction, semihost, s_guest_external, and
> counter_overflow.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
>   1 file changed, 45 insertions(+), 44 deletions(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty


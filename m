Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F4CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN222-0007Ju-B7; Wed, 13 May 2026 01:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN21b-0007C7-E6; Wed, 13 May 2026 01:20:54 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN21Z-00064d-M4; Wed, 13 May 2026 01:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI3/dTlNic786wBGk54CTd8eOqqNSNUuobqYGfScFGt7uqvf+A8T4I79kP+m5rT2MsaHNTIANXYwhf8omLR0F23IR3MoLwi4/f6LvOqD77DyJMIWEFWT0vKeQYy9jM6Z2eiiJC68xE9a2WTDJgDzDCCffx8LNV15pewlzLsXqoYvbD1Z8/Ga3SdiubNIrz6EDXwQU+LyvmI8HnReNHQhBD8r67bmDqP5VAeT59WTBuJ29zMkDLb86gDJ4GR3XOxoMgHsDN7dyqdCSya+kBLF2XQWKc2qABOmK7rF3NvpdXQNC1Pzm2PgM+bV9J0l5+WNSGiPkdJqxOU4vKRRIrQsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODTK8hM8jdw0fXVcURokRuntNFvwjpSaRfxO/5ycIvc=;
 b=YiKFGH4iqTuzKrEcnn98b+SmeWS7p8ZHB1axxx83EzIyjt5+7Y2qoItlI5J8FznyVh5g+pqQtc3p3rxBKwqCcgknF1jY01wu1NZwhm83T7iWm6bQFfWIy3Nbbhgi7HymtTk5C6Kr/jJ8xpuz62oQXzZfUA9GXWn3TdcbfxBVV5/VOKxdRpj0QU6VLWEd/aIQ895ar5/KNMazmsFhLiyKNByCr922YA2VcNUIA+n/8tupggGkswEHhzPHnjoXa95PTze9F+yDi7YFJeFLLhPs7+F/eg2Y31NmS/6mzzf13sY8SAVcnltFNQ9Duj1l20mr0QiH4uKkWoYi2hRtolrMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODTK8hM8jdw0fXVcURokRuntNFvwjpSaRfxO/5ycIvc=;
 b=iLaGvYj1y7sNFnMa7hjCKCqdqcM1zlyPw9viHOWQz5Oy2n6H5U/05YevroeVA/Ay14Te7SGHbOr9gEGrz2NcV8YVgYoFuFkxcWXtCsKDfXabwl0af2ZT0S9Pdjgw/IZIMnryUIzu0DTGuGoPiuFtEVJ+PbZgU6lgAYQytACGRdvglld1CMk4qNUywlDreVTyKSveeB4AQqkqNGHuqvURghkg+Xzi1tChM9AcwrpsIY1vZ0jAGZi9CRYmgnL9V+c83DVs0IexxnWDTOlA+J6WiJ7/BOx/NHhtGlAWKaE5gdZx/LRFzZ2duD4dPKp0p2afZr+BSkPdI4hDWLYQ7XlkmQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR0401MB6394.apcprd04.prod.outlook.com (2603:1096:820:9b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 05:20:40 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 05:20:40 +0000
Message-ID: <SE3PR04MB892262F85695893263E7046BF3062@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 13 May 2026 13:20:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] target/riscv: Implement SMMPT fence instructions
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
 <20260511124705.28161-5-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260511124705.28161-5-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <7317290c-24eb-4d59-b6ed-10620e96c465@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR0401MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 864b34b0-0288-4218-e856-08deb0af5fbc
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|6090799003|51005399006|45011099003|23021999003|41001999006|8060799015|19110799012|15080799012|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2d6WXFoRExyUWp6cU1GOEE5dEZINlBPQlNWNWpPNmpZMVlIeHFpenY1VUJR?=
 =?utf-8?B?ajhkTWtIMk1ObGF0YzNuc3dScDZhV2kwRitBL0ZZWUY5dFh5TVJTNnFNekMv?=
 =?utf-8?B?WlRYRFNoeGVIYXRkNmp4ekxKNVRkbkY3L3BZT2ZpbGhzTHBYc25mVVM3WHpH?=
 =?utf-8?B?RTFVWDl1WlRIOTlDcU5aNE9QNUJRRTl5WE8zN3BFUkpLb2NGeVJxYUtRMmRG?=
 =?utf-8?B?UkxUS253NXJOOWRoWWJlUlA4QXJ5Y3dNdkMxamdtMDRUbnBqcGVjS0dNcGJI?=
 =?utf-8?B?QTJaNm40ZHU1L0R6SFB0YS8vQlZVSzBTeUlzV3dHOVp6VEpjRURpeitieCtV?=
 =?utf-8?B?V05wZUJESE9GTjRVZ3VnWmFuRXBuQzZpOHMxZWswQXJNd1FIcW81YzVWUGc0?=
 =?utf-8?B?SU5POFhDUXVpSnhpV0pSTk5QZlRWaUVpS3I3bkNnN0Y5RWdsVFpWNlpHSW1u?=
 =?utf-8?B?SjBRQWJRZVdRZ0E5VlZKOHFTNzBGcWF0Uk9BOEtYS09mKzVpTXhPSk1qdXFw?=
 =?utf-8?B?ZUVSQ01nMU9xUmhwT0lhMEZ1ejdWczJzblVCZkJrSEErYUF0NTZqbE9TMksz?=
 =?utf-8?B?clZSUkRFMkZUM0Y5WUNobktyN2FkZm5NNmdDL29kUXZ1UDVKMStyZXVXZVBm?=
 =?utf-8?B?YlRQMHJUOUZvMHlqMU5yb0xCeWtKZUxHNE4zU3QvWkhDNS9xQldJZ1BLRVBy?=
 =?utf-8?B?aHZzYk04WFEwbFd4U2dpSXR1VnZqSUlDVzBVRzJqRmJJd0NNczE0UEZvYnZu?=
 =?utf-8?B?SjZtRTVVVFJDNGFraXVidVNMOHRBd3NNZkkxdnFsZmZTczhPK3V1clpHSXY4?=
 =?utf-8?B?R3RMU3U4UWRyUUl1L0NvcnNkSGVrUUV6WFZwZUFIbm5yeWwxS0g3dHlQNGRN?=
 =?utf-8?B?NThRSXJVSWkrbFQ4SmIzNXRidk9RbjAwSGtrbDVrOTZ1aFd1dUx4NXpzSkxa?=
 =?utf-8?B?MWg4WVpXNC9aUXVTeTZrY2F0N0JrOXJsU0orOW9WSGVBdDVFOGhCdUpubk9t?=
 =?utf-8?B?MGtYRHdSc2srQTM3ZDRTYU9EMjRZV1dVZklPSDB2NGxzOWtYMVBtb3plcW5P?=
 =?utf-8?B?MjZhVmhqZ2E0c3BBczYxcGNqNW82NmtRRS80elQrdFdzZHpid25Mc3BIaktO?=
 =?utf-8?B?RTdmUWVGcmt2L0tRcjR3Y0U0aTdjSFJBQndNeWZHTlUvaEpVR1ZQMVJDQ0pU?=
 =?utf-8?B?bCtaUXRQQzQ2WEtVVCtrcmFRT0ZYUjkvckh0RWR1MDYvTTBhVGRWWG93cGl3?=
 =?utf-8?B?SEl2ZXNSNFExNzgwYjAzU3pQTTNWZTY1YTByV1lVMml1SERYWElUaW5oVklp?=
 =?utf-8?B?RnFCM0NvMjh5bG9haXpOZkVUbkZtdjYyTTJWaGduUzFJbU1lMU1DZ1NtNDVT?=
 =?utf-8?Q?DnBxGj5S5exQuTfal3VO0qoCOJjq2abs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0xIWHlxVW10UEM5VWZxdUFMOFVqc21POUQ0cVdzclMybkVzWjEzQjdkVGc1?=
 =?utf-8?B?aEJ1cStKSnFxYmdienhSS2RMbUo4eUVSK3JaSHFvV0dvRzBQZDBvN2QrZW13?=
 =?utf-8?B?WG1QQThlZXJhTVdNM2FkZFNremk0d01RM0dMWFJHSXc2UG1aWWlOWTFTMklk?=
 =?utf-8?B?OFhpVGdGaVhoZ3NZdWpoZGh3U3Zubm82OTBYNjFGRFFaemNxTVR4NFZYeDBW?=
 =?utf-8?B?eXZhd3FVQ2gyaVJzMmd0em5EWUlxTTZFVG9KUkFZUlh2Q2w2K0d6TmhneFZN?=
 =?utf-8?B?UURWcGYvZi9HNlBIendhSThvcFJHay9TTjMrYS9TVXlGMjE1Slo5Zmo2SHZp?=
 =?utf-8?B?eUp0eXNGM2F2Qjh2UDlhQlI4Y2h0NWtzWkpVU1dmY09Hdmh3Tk5hVE5mcGxn?=
 =?utf-8?B?blFwSXhuY3VGaGFJMGNDNzJZMS9OMW1BVXZzNlYxRXN4SWFOaVl4TENNUVZT?=
 =?utf-8?B?UW9KVXNwalhGM01MbVY1SXhrTzdQWDZKVjcvaDZJN2k5S3BieWlzZkJKK3Rp?=
 =?utf-8?B?cjV4OVB5OGxtNjBmNHNBS2lSWG90WjJTK0cvek9DYjhXclZ0dVlTcnlVZ3Bn?=
 =?utf-8?B?R1ludUF3VmF4Nm9PQTB6SDFZeFF3R0s2b01jY1ExeXNXbnA4WHFoQkpGRFlz?=
 =?utf-8?B?UmhwVytNLys3aC9lSkx1eUttNjNkUFRCTXUwTjR5M2pMZi9SRDQ3R3FDR2NY?=
 =?utf-8?B?MjRtL0IrRHZoNlBUVEtsNHE4TzFKbG5UWUFWcEsrUnV3SStFUFRPQmZFZjlZ?=
 =?utf-8?B?VUxWL1YvaW1Kcjh6ckhiWHVpWDZoK2o1djh6WDdaTVJiMzNHMXpwWThWckx0?=
 =?utf-8?B?ZzExeGFMWExZQ3dnYWJ0V0x5SVY3MDlSb0J2YnJsQVRhdXlIamZZdmdQcFo5?=
 =?utf-8?B?VWdJTTMvRmdoekVURGJsUmpETFQwL2tkeTd5VUlSRnlsWWw4U3doL2hDTHRq?=
 =?utf-8?B?aUpGK2VNc1RqdE1MU2F2S2doU2RIY241Q3NWaWJML3ZSWSt6US93UW5XTjZy?=
 =?utf-8?B?UW1JWUFzQ29OUS9RaE5ldU53K1R1SGlHTUdTUExvWmRmU0IyNGJMMkRKK09l?=
 =?utf-8?B?WklOdHZPdmF5YWlRWWZvWGh4bnY0Y1AxOGhoVktrYjk3b1NmRWZVeEdNRzBw?=
 =?utf-8?B?amttOXdDRHdNMXFnU2NBL214Tm0ySzE3czdGc0FxeHd1UlNTYlowV3VwU0RZ?=
 =?utf-8?B?Wm1CeWJPV2VlTmN5a2trWkRsZzN4MzFlcGR5S2g4L1RCYmZ5Q3lVakRmaXJH?=
 =?utf-8?B?Y292RzRPM1QxbUYxNEVmWlcxUHhvb1RHb0t2RU0za0FBRG5aOUd2VlhaS2lV?=
 =?utf-8?B?TmVHZDI0QTdwNGphcEkrRnhONGJDSUdSYUZWR3VBMFE4MnY0TTM2QnVWQXdh?=
 =?utf-8?B?Z2xMdjJPSWp6eU5tVmkzbFZSdDV3WnB2cm4rd3l4blV1ZnBnTHRRSnJrZGFO?=
 =?utf-8?B?Zk1SR21veE9FclRNb1I1TzJHUVJ2eUhMZjVTbTVid01Cc0ZIMEk2UzVBNWc4?=
 =?utf-8?B?YjFiMFpCVVViQjJUSlFvcFUvdmFGWUpOM3p4R3l1UmUreDdKcHVXRHhpWWgr?=
 =?utf-8?B?OCs1bW9tZGJBUzhDNVdTSWVoeEdsNlpTZUJ1YkVYZ0Q5N1g3NVJoOGFxYkx5?=
 =?utf-8?B?SHYxbStKS0FmS1hJdnlnNVVSNloxeVd2NnI1QjJiMy83cm5rY0JQMUl1Wml4?=
 =?utf-8?B?bVhLblVzUUNUYlFkL25hcTlOWEpTZlNObzJ2M3M0YW5YZWtTL2ZZV05xYlNI?=
 =?utf-8?B?RGZBU3puaVVvVFVXMGhYSDRmZFdacUI5ZC9Ib1cvZUN4OWdkbXRtdHlMSUxM?=
 =?utf-8?B?dHdLaHVSQmxNTjNZdVA2ZkFaSHppekVhbkQ2RXdrcFNodzB0RE5IL1JmTkdk?=
 =?utf-8?Q?8JHeR/I86zBV5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 864b34b0-0288-4218-e856-08deb0af5fbc
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:20:40.7911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6394
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> This patch completes the SMMPT implementation by adding support for the
> new fence instructions: `mfence.spa` and `minval.spa`.
>
> According to the specification, these instructions act as memory ordering
> fences for MPT updates. In QEMU's TCG model, this is conservatively
> implemented by flushing the entire TLB, which ensures that any subsequent
> memory accesses will re-evaluate permissions and see the effects of any prior
> MPT modifications.
>
> The instructions are privileged and will cause an illegal instruction
> exception if executed outside of M-mode.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/insn32.decode                    |  2 ++
>   .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
>   2 files changed, 32 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..84cec57daf 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
>   wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
> +minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
>   
>   # *** NMI ***
>   mnret       0111000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..5ec6bf5991 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   #endif
>       return false;
>   }
> +
> +#define REQUIRE_SMSDID(ctx) do {          \
> +    if (!ctx->cfg_ptr->ext_smsdid) {      \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool do_mfence_spa(DisasContext *ctx)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMSDID(ctx);
> +    if (ctx->priv != PRV_M) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    gen_helper_tlb_flush_all(tcg_env);
> +    return true;
> +#endif
> +    return false;
> +}
> +
> +static bool trans_mfence_spa(DisasContext *ctx, arg_mfence_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}
> +
> +static bool trans_minval_spa(DisasContext *ctx, arg_minval_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}


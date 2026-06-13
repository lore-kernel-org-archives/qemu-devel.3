Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FB6CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYHQh-00019I-UO; Sat, 13 Jun 2026 02:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wYHQc-000182-Ej; Sat, 13 Jun 2026 02:01:10 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wYHQZ-0003lR-7o; Sat, 13 Jun 2026 02:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6OcyOqV5EEpV3KPlT6pnGV2kRuPz8CZMxl+2CINQQBezdqTYI8LiYelx6nOAvQzJBWz8M5KBaQPVQ6UBqjOfHdQ/EXD+0r8ZfIjxiW/pGg2RqomWvC+i0/KekQDTAljJKKQWvCs6JIJ5qlSXmfam5cAsmIDbYb2P99i3ZVs+vSvtfRG53g3gyOwKUTrNiYbxMqhWKrpV6a/21gkmTkuF8EVxq7F7TSbTa2Ts+qqqZ7CFX0BJ+sZynM8GOmCYUOvElOckqye/Nc2ZmxyLvx0HoeZfoLCtkgX3DFJXY81lZeFpb0o1ffZnFVoZc9DeycBz8sTZZnc40qAU2VHHZL83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nMRQydtaE76BhnJlcto2SbSjppWEWxdHnc4vt+ibHM=;
 b=C2cLwd/sATQFLfmMjo0lBCBh5EIvhgCpz2nM2zi1j+IK7+PfySmxFIsmFwfKzy2y60sZdoH3ewhUFQTS5HGE3HXAJLEmdbiQhzWAEYiajfC91n4EdaGxa09kiFry2GVaSff9SLAbjDcEr30rFq39Vjyt8MNB5eUC/qAZ6tXiz7ZiGc5jL1L2GqBV9qpQDX/AvrEY9YBtcYe2BozMuwIvcLfB0aPucxr9rSuSzo37ixwwR+A0GiKE/Ev1O1fW2LciGeVo7TULYxF7EZOAolo1Zte4na/04Hrs7ZFDb0BFs86VE6ioPSn3DmBk09rbUlqV09RLstTQizwmAWYrPMEU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nMRQydtaE76BhnJlcto2SbSjppWEWxdHnc4vt+ibHM=;
 b=FzMkoBRzIPK1b+gcL4PDol1QLCMNa/DR5vaNY/VdLsabOSNSL9BNbMw98yd1/SOqyQ05KBuax3t7CUieUFX/CNRm1FvTbSnWxAWun0SJAt6I/2W6DMSqWQL42AfmTjem5TSJ4j+9b4TCwXrHntjVLIIBYx5NzRBYA4EspFRPJEsr1mNVVdKYLzoukk02tD7k1W2nM8ffSbCdA/sDzI0zUK8cLuIyJGqIVTSiLSN7p0aoJ75Hqh7jL0kR42O+aqNFhmBQUrmpa+9hAybpViYeqmEZYHdOTexAREeijUzepu1q054lbghAircaNB1dWqGwu82muk9+3PrE+20pl8vflA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSNPR04MB9742.apcprd04.prod.outlook.com (2603:1096:604:484::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 06:00:58 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 06:00:58 +0000
Message-ID: <SE3PR04MB892229E1EC786B85478BBFC4F3192@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Sat, 13 Jun 2026 14:00:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] target/riscv: add thead-c908 cpu support
To: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peng Jiang <3160104094@zju.edu.cn>
References: <cover.1781246408.git.chao.liu@processmission.com>
 <a3e232ace12afd93adb60aed198cac3284daa56c.1781246408.git.chao.liu@processmission.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <a3e232ace12afd93adb60aed198cac3284daa56c.1781246408.git.chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <21a17371-3f29-472d-8985-0f2134b21f37@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSNPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e54cd5-d844-404c-9749-08dec9112371
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19101099003|41001999006|19110799012|6090799003|15080799012|5072599009|8060799015|51005399006|3412199025|440099028|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWEwRzVMZVJ2Q1UyREFiOXd1T0xITnIwQ2hPaDAyMi91dVZ0M2pKTzk3UmdX?=
 =?utf-8?B?RTJ2NHROKzBmOVBaL0plQlpYVWRJZXNlZGZqV2s0ZFBwVnQ0RkorUlA0MUJM?=
 =?utf-8?B?WDVXU21oRlppSzVmczVGS3dWa1FJOXpEV0xvNFpJS1A1a1JGVUpnS244SUZk?=
 =?utf-8?B?ZlR3YTFiK1hxNi9mcWVXNHVHNk1mRFlOY2h0N1JEamZvSVlyUFkzeXFBdWI1?=
 =?utf-8?B?cFpFN29CMmlMeDhQbm4yVk9MUTAySENaV0Y5RXY2K3lOSThQemt3Qy9MeUVV?=
 =?utf-8?B?OVYwc255SGJWQThEeW85NTFocGszUDRIVmd4V2NrS0NvNC9rRXB1Qm5xNjRG?=
 =?utf-8?B?WnVPdjdFcXFOSlJta092ekFNeXVwbUkzTUV2VUtzSGtNeFFkanhuZWxNYXJv?=
 =?utf-8?B?L0VqbmEyZlVRSi9KRjNBZkJTM05OanRwTm9hQzF3Z29xQ09TdlVYRGNyZnhw?=
 =?utf-8?B?YVZOSXZqNXZrSmZReDVIL2NjUHRmcmJzR281V253N2VHSXRsQzNYL01TY2hp?=
 =?utf-8?B?eHdhaDliQm43WENLSUhDK2s3Q3JxY0dDTGxkc0dVYmdRRGd2R2pLeFNPTStV?=
 =?utf-8?B?VCtHem13Zmp5dUVSNHlyZHhYamxGT3lVc05yUVlyVjlyM0hIdkVlS0s4MDEw?=
 =?utf-8?B?RUdZUFVzbXk0Vkl6QVUzcTM0UTVIRDllTHhrOUQxZjhnNHFxUFBYUi8raHpm?=
 =?utf-8?B?dm0xazhxV3FZTGJaK0JoWHo3MG85bGFZMGpFM2hTa1l2VWlXcVN2Y1JxL3gz?=
 =?utf-8?B?TXdCS1gwZVdHZjVvTHJsNW9vMWY1RW1zclQ0MmRMcGJtREFmS3VJTVAybHpx?=
 =?utf-8?B?YURoVU9IRE1UVmZZakZWUXdCMXhTbmtLRTlXUzlzYzZQb2QxM1VkK0hXRTBD?=
 =?utf-8?B?VFh0YmlaczhTUEpmQUxIMURjdWJQdXFxWnkxbmttZ01nbENOOE1VZ1dOQ04y?=
 =?utf-8?B?WVlDWXlzWGRiU2h4STMra09XcmZRTklpTEs1VDF6cnk4Y2tKYVc3MTFwMDRI?=
 =?utf-8?B?dVBUTm1OWEhwd05BSWxrZnFQWnhtandwZG9NM1lhUS9OYXRWWE1pNkNHYWg3?=
 =?utf-8?B?RCsrVG51TjM1aVNTZ0pIQTMvMHMvWW5NYUlxWWRPOTU1d0lTbTNUWStyeHVt?=
 =?utf-8?B?UlZuTE9SdUtLZDRhekxsVURUakNKVUZZRW1KcDVNd3pmdTFUS3lMUHBYQ2xi?=
 =?utf-8?B?ZzhOUkVnZmdKNXgvY1FsbmMybFVsRjBlUDZOWjJSSkZKbG5VT0NxSGtnTzhw?=
 =?utf-8?B?ZmMxQVl4ZGJ3NzlMRjJzaFhqbXlzME50cDQ3VG5jOHVZcHB6b00wQUlDdkM5?=
 =?utf-8?B?cHlRemlpQjRTR3JoSUx4Qjl2V01aajhISHY0SHZoNlpxWldBQXc1cXVuUGpm?=
 =?utf-8?B?YllDUTdNRGFnS1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9iQTBybTlpei9CL2htSlBJUzJ4RnpYb3BkRUJ0WEZKUGVxU3ZlSW1tV0hM?=
 =?utf-8?B?eUpTdkQ0b203akVoTnoxaDNOQjdRbmUyZ0QzZjJ1aDBMdkdyZE9XOGV4bW5W?=
 =?utf-8?B?ckN1ZHJYTDlVKzM1NHlMVGZuTyt2N2w0M1ZXSjdSRTJYdWI5ZVdGY2ZVN2pq?=
 =?utf-8?B?ZVNtUUhBZVJYUjB3ZmpVajYvQ0crVUljRnFFQ0NnMlEwSHdZZUlheDJka1dF?=
 =?utf-8?B?NGZYa1k0bjhydVRaWlZQMlBlMzcyaHEza3VTL2M0Mm51VmRaVVgxYXhUNXNK?=
 =?utf-8?B?bVB6emZObStWS2drSUpQclFJQTNMSkllT0FIWEt6Z3Fnc2ZKQzlWVy9vK3FD?=
 =?utf-8?B?ckUybXN3cUFhSnAzWWphT09SUlFZZ3F3MHMybjJmcVNXMzNBRnk3Ylg2NlZt?=
 =?utf-8?B?NUJzVVVRNUtFNW5wQ0tQczAzZXVwNG1PSXZiaDM4Qzhia3pHRzg5SjJ2K3dk?=
 =?utf-8?B?NENXMjNNY2t6Y3JvTkxrUkd1SkVoK0NOOVd4RU5ZR3NmMVFGNDBiV1Q3dVly?=
 =?utf-8?B?dnMwQW9LYlJ6cWNGWVQ1M0JpbFBjeWV0akM4WnRCY1RSVUVGQzJoSnVWZlJi?=
 =?utf-8?B?bU8vb1lZQXFlVUJmSko1bWVaWDl0UTN1dnFRdUpGcWorNGZ0WFYzdGdqeldN?=
 =?utf-8?B?c2pIY2o2dkcvZEZFQ0pZaFRkMUV1YUhONGNwY0NYTkVDdGJXdm8xN2hsalB3?=
 =?utf-8?B?QzVxZm4zQ3E2djNVWCtzUUZoMTRJU3lHVGV4QjJpUW4xQXVpZlJOcG8zczRD?=
 =?utf-8?B?bXBzZDVVWUFJS3dkSm5JQ1hGQkZiMno2c3FVMTI1UHlLM0k5UGN0SnFIQ1NW?=
 =?utf-8?B?Qi9BTjkreUNrazBZTitRNW9pZlYrNzE4THg5OWdNNWV5TnRtUHRwSk9OKytY?=
 =?utf-8?B?ZUgyWUl4UDVpanA5NU4xc3hzMVI0Z1dFQ1pOUTQ5ejBYMXBtczN5ZWF4cjBq?=
 =?utf-8?B?dmk5YzlCQXA0V3dDN1ZOdVdXZnpnOTE4MllnMzJxSFFsUytkQ3ZqQ0h0dEFD?=
 =?utf-8?B?UTdONGMvNUloVm5wNkRPYzhIc2s3N3RvWllGRU95NldUQ05uK1ZCNG94M3NM?=
 =?utf-8?B?blRreTloY0tZajRVRDhPaG1wVDZPTE9hV2JLSzEzcEtqUFpkUUh2MjhZMmlw?=
 =?utf-8?B?VUp3cHlzS0ordjVKcGdWVGl5UG1JZmFJdUtuREhXeWpBbEREcmlza2I5cGpP?=
 =?utf-8?B?UldPY3I2VUlNajhBajZCbTBpcUVDb1FLdURMdTlEV3B0RDRrRzNvZUd0NVRa?=
 =?utf-8?B?Ry9xcGtPZEkzMXZ4L25xeVRsbDMxUFlLWExMRXM2VUNqanliUmRZaVREOUwv?=
 =?utf-8?B?bTNKK3ExMVhxU2J5M1dqNzE5eGYwUFAwd3Vzcm9vclB0TmdhSk1zb0dFRUZ1?=
 =?utf-8?B?Vk8zYjVId1BJMWovSG9CblVScVJJREpja3ppTGFSa0VNZkpCVmIyTUU5M05J?=
 =?utf-8?B?czlpL3R3T2h6ZFlXS0FWV3FWUkZsUE5pTUlmUSs2OXgyK3lLZ1JFSGF3aFNn?=
 =?utf-8?B?MWFLdWlRbks3VE1GV2VBZlNhUXQrbHVaQTBzNkI3LzNmUjh5dk1ZWUVqeHRj?=
 =?utf-8?B?VGRxZDNKVTYyZGp6SHFYMXB5aXJ5Q1U1T2EyWWdMbk5jTjZlVUpyMXR6RVNq?=
 =?utf-8?B?NUFWNlpRSmZmU3F4aUE0MjUwT0ZTNlZZZlhETFQxZy9yMDRuOGFLU3dVNmFO?=
 =?utf-8?B?Q1pTV1ZrNVBzZDltNzZTNmdzalBFWGZ1RDdoTnBHSCtvbVpjbDFSN3VYSzFJ?=
 =?utf-8?B?ZWEwYzlnNjhSSC9semFpVGVoNlc4QkUyVHh2V0F1dHkyek9TT2FMSTBtem5u?=
 =?utf-8?B?ZHE0bjJTZGsyRGlwTXlQQzl6aVVtU21OdkJhRlFLRVRCUno1OEZ0MC9xR1ND?=
 =?utf-8?Q?xCyGO1faerCG1?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e54cd5-d844-404c-9749-08dec9112371
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 06:00:58.5442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9742
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


On 6/12/2026 3:04 PM, Chao Liu wrote:
> From: Chao Liu <chao.liu@zevorn.cn>
>
> The C908 processor is based on the RV64GCB[V] instruction
> set, compatible to RVA22 Profile and implements the XIE
> (XuanTie Instruction Extension) technology.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Tested-by: Peng Jiang <3160104094@zju.edu.cn>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu-qom.h |   2 +
>   target/riscv/cpu.c     |  51 ++++++
>   target/riscv/th_csr.c  | 376 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 428 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..1a28f1369c 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -52,6 +52,8 @@
>   #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
>   #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
>   #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
> +#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c908")
> +#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>   #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>   #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a74384a091..fa497e5e8a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3121,6 +3121,57 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>   #endif
>       ),
>   
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec = PRIV_VERSION_1_12_0,
> +
> +        /* ISA extensions */
> +        .cfg.ext_xtheadba = true,
> +        .cfg.ext_xtheadbb = true,
> +        .cfg.ext_xtheadbs = true,
> +        .cfg.ext_xtheadcmo = true,
> +        .cfg.ext_xtheadcondmov = true,
> +        .cfg.ext_xtheadfmv = true,
> +        .cfg.ext_xtheadfmemidx = true,
> +        .cfg.ext_xtheadmac = true,
> +        .cfg.ext_xtheadmemidx = true,
> +        .cfg.ext_xtheadmempair = true,
> +        .cfg.ext_xtheadsync = true,
> +        .cfg.ext_smepmp = true,
> +        .cfg.ext_sscofpmf = true,
> +        .cfg.ext_sstc = true,
> +        .cfg.ext_svpbmt = true,
> +        .cfg.ext_svinval = true,
> +        .cfg.ext_svnapot = true,
> +        .cfg.ext_zba = true,
> +        .cfg.ext_zbb = true,
> +        .cfg.ext_zbc = true,
> +        .cfg.ext_zbs = true,
> +        .cfg.ext_zkt = true,
> +        .cfg.ext_zbkc = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zihintpause = true,
> +        .cfg.ext_zicbom = true,
> +        .cfg.ext_zicboz = true,
> +
> +        .cfg.pmp = true,
> +        .cfg.mmu = true,
> +        .cfg.max_satp_mode = VM_1_10_SV48,
> +
> +        .cfg.marchid = 0x8d143000,
> +        .cfg.mvendorid = THEAD_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs = th_csr_list,
> +#endif
> +    ),
> +
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV,
> +        .vext_spec = VEXT_VERSION_1_00_0,
> +    ),
> +
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
>           .misa_mxl_max = MXL_RV64,
>           .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index a4ea4ce391..431f4cc286 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -2,6 +2,9 @@
>    * T-Head-specific CSRs.
>    *
>    * Copyright (c) 2024 VRULL GmbH
> + * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * For more information, see XuanTie-C908-UserManual_xrvm_20240530.pdf
>    *
>    * This program is free software; you can redistribute it and/or modify it
>    * under the terms and conditions of the GNU General Public License,
> @@ -21,13 +24,84 @@
>   #include "cpu_vendorid.h"
>   #include "target/riscv/csr.h"
>   
> -#define CSR_TH_SXSTATUS 0x5c0
> +/* Extended M-mode control registers of T-Head */
> +#define CSR_TH_MXSTATUS        0x7c0
> +#define CSR_TH_MHCR            0x7c1
> +#define CSR_TH_MCOR            0x7c2
> +#define CSR_TH_MCCR2           0x7c3
> +#define CSR_TH_MHINT           0x7c5
> +#define CSR_TH_MRVBR           0x7c7
> +#define CSR_TH_MCOUNTERWEN     0x7c9
> +#define CSR_TH_MCOUNTERINTEN   0x7ca
> +#define CSR_TH_MCOUNTEROF      0x7cb
> +#define CSR_TH_MCINS           0x7d2
> +#define CSR_TH_MCINDEX         0x7d3
> +#define CSR_TH_MCDATA0         0x7d4
> +#define CSR_TH_MCDATA1         0x7d5
> +#define CSR_TH_MSMPR           0x7f3
> +#define CSR_TH_CPUID           0xfc0
> +#define CSR_TH_MAPBADDR        0xfc1
> +
> +/* TH_MXSTATUS bits */
> +#define TH_MXSTATUS_UCME        BIT(16)
> +#define TH_MXSTATUS_MAEE        BIT(21)
> +#define TH_MXSTATUS_THEADISAEE  BIT(22)
> +
> +/* Extended S-mode control registers of T-Head */
> +#define CSR_TH_SXSTATUS        0x5c0
> +#define CSR_TH_SHCR            0x5c1
> +#define CSR_TH_SCER2           0x5c2
> +#define CSR_TH_SCER            0x5c3
> +#define CSR_TH_SCOUNTERINTEN   0x5c4
> +#define CSR_TH_SCOUNTEROF      0x5c5
> +#define CSR_TH_SCYCLE          0x5e0
> +#define CSR_TH_SHPMCOUNTER3    0x5e3
> +#define CSR_TH_SHPMCOUNTER4    0x5e4
> +#define CSR_TH_SHPMCOUNTER5    0x5e5
> +#define CSR_TH_SHPMCOUNTER6    0x5e6
> +#define CSR_TH_SHPMCOUNTER7    0x5e7
> +#define CSR_TH_SHPMCOUNTER8    0x5e8
> +#define CSR_TH_SHPMCOUNTER9    0x5e9
> +#define CSR_TH_SHPMCOUNTER10   0x5ea
> +#define CSR_TH_SHPMCOUNTER11   0x5eb
> +#define CSR_TH_SHPMCOUNTER12   0x5ec
> +#define CSR_TH_SHPMCOUNTER13   0x5ed
> +#define CSR_TH_SHPMCOUNTER14   0x5ee
> +#define CSR_TH_SHPMCOUNTER15   0x5ef
> +#define CSR_TH_SHPMCOUNTER16   0x5f0
> +#define CSR_TH_SHPMCOUNTER17   0x5f1
> +#define CSR_TH_SHPMCOUNTER18   0x5f2
> +#define CSR_TH_SHPMCOUNTER19   0x5f3
> +#define CSR_TH_SHPMCOUNTER20   0x5f4
> +#define CSR_TH_SHPMCOUNTER21   0x5f5
> +#define CSR_TH_SHPMCOUNTER22   0x5f6
> +#define CSR_TH_SHPMCOUNTER23   0x5f7
> +#define CSR_TH_SHPMCOUNTER24   0x5f8
> +#define CSR_TH_SHPMCOUNTER25   0x5f9
> +#define CSR_TH_SHPMCOUNTER26   0x5fa
> +#define CSR_TH_SHPMCOUNTER27   0x5fb
> +#define CSR_TH_SHPMCOUNTER28   0x5fc
> +#define CSR_TH_SHPMCOUNTER29   0x5fd
> +#define CSR_TH_SHPMCOUNTER30   0x5fe
> +#define CSR_TH_SHPMCOUNTER31   0x5ff
> +#define CSR_TH_SMIR            0x9c0
> +#define CSR_TH_SMLO0           0x9c1
> +#define CSR_TH_SMEH            0x9c2
> +#define CSR_TH_SMCIR           0x9c3
> +
> +/* Extended U-mode control registers of T-Head */
> +#define CSR_TH_FXCR            0x800
>   
>   /* TH_SXSTATUS bits */
>   #define TH_SXSTATUS_UCME        BIT(16)
>   #define TH_SXSTATUS_MAEE        BIT(21)
>   #define TH_SXSTATUS_THEADISAEE  BIT(22)
>   
> +static RISCVException mmode(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException smode(CPURISCVState *env, int csrno)
>   {
>       if (riscv_has_ext(env, RVS)) {
> @@ -37,11 +111,31 @@ static RISCVException smode(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> +static RISCVException any(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static bool test_thead_mvendorid(RISCVCPU *cpu)
>   {
>       return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
>   }
>   
> +static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    /* We don't set MAEE here, because QEMU does not implement MAEE. */
> +    *val = TH_MXSTATUS_UCME | TH_MXSTATUS_THEADISAEE;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_unimp_th_csr(CPURISCVState *env, int csrno,
> +                                        target_ulong *val)
> +{
> +    *val = 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
>                                          target_ulong *val)
>   {
> @@ -51,10 +145,290 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
>   }
>   
>   const RISCVCSR th_csr_list[] = {
> +    {
> +        .csrno = CSR_TH_MXSTATUS,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mxstatus", mmode, read_th_mxstatus }
> +    },
> +    {
> +        .csrno = CSR_TH_MHCR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mhcr", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCOR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcor", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCCR2,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mccr2", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MHINT,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mhint", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MRVBR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mrvbr", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCOUNTERWEN,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcounterwen", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCOUNTERINTEN,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcounterinten", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCOUNTEROF,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcounterof", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCINS,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcins", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCINDEX,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcindex", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCDATA0,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcdata0", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MCDATA1,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcdata1", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MSMPR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.msmpr", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_CPUID,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.cpuid", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_MAPBADDR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mapbaddr", mmode, read_unimp_th_csr }
> +    },
>       {
>           .csrno = CSR_TH_SXSTATUS,
>           .insertion_test = test_thead_mvendorid,
>           .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
>       },
> +    {
> +        .csrno = CSR_TH_SHCR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shcr", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SCER2,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.scer2", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SCER,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.scer", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SCOUNTERINTEN,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.scounterinten", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SCOUNTEROF,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.scounterof", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SCYCLE,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.scycle", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER3,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter3", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER4,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter4", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER5,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter5", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER6,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter6", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER7,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter7", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER8,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter8", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER9,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter9", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER10,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter10", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER11,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter11", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER12,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter12", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER13,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter13", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER14,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter14", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER15,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter15", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER16,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter16", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER17,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter17", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER18,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter18", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER19,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter19", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER20,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter20", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER21,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter21", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER22,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter22", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER23,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter23", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER24,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter24", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER25,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter25", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER26,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter26", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER27,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter27", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER28,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter28", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER29,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter29", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER30,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter30", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SHPMCOUNTER31,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.shpmcounter31", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SMIR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.smir", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SMLO0,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.smlo0", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SMEH,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.smeh", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_SMCIR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.smcir", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno = CSR_TH_FXCR,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.fxcr", any, read_unimp_th_csr }
> +    },
>       { }
>   };


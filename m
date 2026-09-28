Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E6CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAaI-0006sf-26; Mon, 28 Sep 2026 08:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xBAaG-0006mC-J0; Mon, 28 Sep 2026 08:35:52 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xBAaE-0001Fg-Pd; Mon, 28 Sep 2026 08:35:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkICVL/bcfXATXlW2/LPWiJGjlGiKliw2RHNwZIwfsLt12AjRukEpR0o9HccjjzaTz3B3Wk0H//cLzE2sscKP+coyeFyzzkV7r8f3lGXD9OINE5vBVJWKWkxktGZOp34GLKm4pSQXFrHLD691u94ocM9cn/gQPe3fRGwp0wbO1dgjPJ3XVDJAVa92VGUowaDxm2iZZuMlQWc7EWTqIoReKarzikSY7+gNzvl17UJzZLRDd78seZWRFpVGezN1mil1XcvX+XpGnvZGAzV/mw6x1MgVwJ0xzcqxCunelUBsQfMkfj2chfnmMi1MU+e6EVq+5UE2Wm1EOsWs0bzU+o9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUxT102bbtc8z8XAK6pWcCgg30+Oa4xxrAhV7lAmc/4=;
 b=o5kk6pCX0F2KpoHKWPhQQAYwzWgRrH1Eb+Iosgjcbs5OKvzQ2p5dn4OifzX9HFZcYTyoMC2D7N4JncpEMwLNaomr4v4h84UtGnFlmVpSBhwVX4A6lxfx1ixiAvJnQmJlAOW/OT+RElhGCTrhM85CsehFCVA73gb0l4XL1uV93IClc/vN3rE1gC+4KorZIY4ve7cQ0uaWJ+wv5Oc9Upx5K37oI0vesblfWcRvIetbocOBAOF+dPMAQFdbjh5F1crHMrzoHTqrVCIkUhsSrV6dFuJaUfRGDLRYMtCnu6nISGLH3ynu4opXnJM6N669I4et9vk/DgcHqJ1LPOCorb5ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUxT102bbtc8z8XAK6pWcCgg30+Oa4xxrAhV7lAmc/4=;
 b=k81awL0x+CGEXc5gnPmp4rveQQhwWgr0UfNSTqZm0W5IeyXznFQRWRbQ2FXplUCBDZdnUQDAm5KqDzj+dyoVTScgl7g+koHZyiLMFg1DFRcclTHDwg6F/ETCM0UeAPm0A+tJuPeU56Z03GHHUFaOAEMwoS+Uw0xR5SvRBu308BCNPFWhhlHgvNOMLfCj4dpumBgqKxgyf2VLPgwelHdQOV/0Rat4BvX2AW+RInQvi6VIrobC9IQ29eo98rpPG2QBZLHrYwOWsEcQNCtstzDdjRgr+zDxQQlP2mBMeRyPzQMFRePUrO7Qk3cn3lEFHgBMTf0gdtNgIK78/ToXfEVbnw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SI4PR04MB9355.apcprd04.prod.outlook.com (2603:1096:4:29b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:35:41 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:35:41 +0000
Message-ID: <SE3PR04MB8922CB9511A2FE34BF4669D8F38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 20:35:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] target/riscv: add sdext enter Debug Mode on ebreak
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-5-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260909144841.1766921-5-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <5e8836a8-b0d3-447b-b88f-6144cba15597@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SI4PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e3e0aa-bf77-4401-c782-08df1d5d020f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|41001999006|55001999006|19101099003|5072599009|2604032031799003|23021999003|22091999003|24121999003|25010399006|8060799015|19110799012|4140399003|51005399006|440099028|3412199025|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy9pMTdNekhIeVdsWVdiazFLR2hVSjF4YzR2QkRWc2R4ak5pZGoyNzV5QTBC?=
 =?utf-8?B?U0h1TDducGpPOGZlVncwWUVESExYTHBWbG9yS1JjMjZFT1l1Qjc0NCsyY1pT?=
 =?utf-8?B?c1E0NDJuVFZ6d1AzOXozK08xOXJicDRzcCtPQnNaL21CVVdyMlhyMnZNc0pl?=
 =?utf-8?B?SzdXZDBsOGJnMHNVK3UrdTNYcm1aeStHckEwSDdXZ3NjU1pyeHlHYWNhQWNT?=
 =?utf-8?B?T25uVmNDOWVldDQyZnUwOXM2cEhTQ0w2WTJJWTBOUWI0OWthclJPcXhuYWxI?=
 =?utf-8?B?eHFibkJzbjZwbWp1SEZSVUw3TEI2ODBneVdTbjZCN0hhdVMwN0tZN08wWFRI?=
 =?utf-8?B?TDlDR1dZMHBIOGZ3eVhvNjZaY2R5L0dHdjl3OWEwQ2hPdVhTbGpzM1RNd1oz?=
 =?utf-8?B?MEI0NkorTU5PTkVVWjFEMnhTQkhDZjBqN1d1MnlyeXFSc3dsMHNDN3E5MjRk?=
 =?utf-8?B?SjJaYlBYb1VxWWlvK2E0djBNMmNqTVJrN2pEcFE4Y3RMR01LRC9aeGFTQTRm?=
 =?utf-8?B?NkVsK2hnbUVmb1BheWJ0QS9OdVRIUUFFOTVRMlh2dFIyWDlsZXlBZmpYTi9R?=
 =?utf-8?B?bXVtYnlmV28zWHBTL0R5MGJucVRhSXhOZndVbUpvdWQzeE43bzAybTBIRHli?=
 =?utf-8?B?MUJRZVZ4MHVLemdOMFFvUlN0UW5pOEZyYUIvc3lyZnI2N1BiZkpiTzhzZ2pI?=
 =?utf-8?B?K05mWTF5UktiR0R5bHV6UXNVSTZNd1F2SmYxQjNnMFZHUTlLWjk5aCt0WUlw?=
 =?utf-8?B?MzRYcFVNbmtVcXdIRHA0Ym1JdW5SS0tZSjJSbjFRMEVmcVp5MVlKdHI4VFZV?=
 =?utf-8?B?N3hxMTRFc05jK2hKenZ1S2NObFpCSGRPZFNEMStIZVF0RjN5N2hIOGpheGdk?=
 =?utf-8?B?d3Q5V09WaDlxdlBqcENRQUJ6MDQ5TzNWK2tKcE5mZVZsRVJrRGhzMkhJMlk3?=
 =?utf-8?B?TGtTazY2UWZBVkw3MXFQUnoyZml3NnpZQ2dsTEQwVDJ3YVJ4ZmNLMEZ6eWY1?=
 =?utf-8?B?SmkwRW15dHlNYVhJRUVNMnR2blBBUUNBZTdpdHNSMDFTY0ZqN1hIc3d0ZVdU?=
 =?utf-8?B?T1lWY2h4L1hlaWp3WitOb1phNkN0VlQxdkNicmY0K2tndGVmQlk3V0xWbUt1?=
 =?utf-8?B?TWZWZStEdUZPRWNYcDdRODhPdlZNMkVnYXBoalBhZE9PYlR1TU1RcEJlUXlk?=
 =?utf-8?B?YmVmenVXQ1NPMXE3WEFzTUE3eGxMMzlYcFB2K2lld0gyL3FYNzBUVjBSRTgr?=
 =?utf-8?B?V1RFWGZFSk4vVkVjdTV0TVBxeDJXUVpJK3g3YXdhTThHTkFYdEdrbGJZb1lw?=
 =?utf-8?B?alE5V3p6VnRRUzdISno0WW5Fd2tLUXlrWWRFZDUrUllNUzVkSktWdUZEWHFp?=
 =?utf-8?B?WGFTUWgrRVJjQmgwbjZlbkVaMTZNbU1LRFk4aFZKRW93ZjdOcE14RWFsR3M4?=
 =?utf-8?B?STdkUXdyRXVQem5paGhPVlp2UkRaaFpMd2tQTzhTNXZUVlNlQ2NvbFJvR0Rj?=
 =?utf-8?B?aWNsaGF2OUlSVVNqeFFvYVNSM0dRakRBbU94UEQ2ZG9yRThsbEw0Q1UwOTA0?=
 =?utf-8?Q?Ui+VqpfKZ8cwPuOaXw+AoagQo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhjRWJpQmtKTHNnTnMrUHZUWVpmakU2NlJ1N2xUeXh3TjVJQUZybEtTU0ll?=
 =?utf-8?B?NnBldzVlU25ObWM0R2Z5bS8xVDd1QWdER01IcWptOEtsV3dNaS9SdXVSOEU2?=
 =?utf-8?B?Y1lNbUkwL2VKdGdzTXJjSVM0ZFBCeGZkcDBJU1dyckNNelZTVVlDMzBnUEJj?=
 =?utf-8?B?K3hTUHJBNk44ZFFvblpvSzFkTXRhSVVXNGtVS0VOejZFZkdOSzljQ0hYeU50?=
 =?utf-8?B?ckJhVnEvVDkraTk3Slo5cVpXekxoQWVIWVc4ZEppejVIZ0RMN3lTbGJHM2tp?=
 =?utf-8?B?eGFEaktBdVJ3d1FCamRobFN5QjQvN1loRUVyY3BWZnB4d3VOQVVqMTQ0ZGlH?=
 =?utf-8?B?SGxUVXhDTmowYXVCeWk5YUROK3ZuVnI1Q3JuNVc1ZVlDWC9EejhEWThSdlBx?=
 =?utf-8?B?a3JldGdIeWRlblRVVjdOYzZRa01MRkZDdzBpeldsSTVQT0NNM2E2ZGE0aG1K?=
 =?utf-8?B?Z0Rzb0ZNTHdCMGtEUDZHWGhuOHRuN2VGL2FIRWEvZDJENi84ZXI5YXhoa0Zr?=
 =?utf-8?B?ck9XTTM3Tm9lY1FLYmZRZHVpQkZMelVOa1pqaEhwUWs3WnpnaEtPbkx5RS9H?=
 =?utf-8?B?bi93NFFIMnQvOEFCOGhiMUhaR0M0MFo5bXJGWmFTbURoT0JDM205V0hpZHdh?=
 =?utf-8?B?dmdhVVRmbWQ1ZjYwOG42bDdlMzRhV1R3YnpFdjFHRTRrcmNIdWthWGxGM1I4?=
 =?utf-8?B?ME5DejFkdUZKTTNKVDgrblpHZzJWeWpkbHhodFYwNitrL2Fpell1Sm9CRk5t?=
 =?utf-8?B?MHA1cHI2Nk8vd0xHTHZNOTJabGIvdk5tbkV0ZytRWCtXa0p6NTlIa0FsTkVK?=
 =?utf-8?B?NHdWeTlZenpYRnhiMHVrRmZyT1N2WVNKNEtkRFdQUUJlUmFmRUhXVUk5S3lt?=
 =?utf-8?B?c0dSK1IvTFpjNVV1eGw1SzRiSllCd0tWS05ObG5Cc3lYUy9uanNKRkJTb0pR?=
 =?utf-8?B?c0ZvZEhCbXlFUC9ERm92ZlFlRHlkM21ReTd1VHpreDVnbllESERPTUtBNmhE?=
 =?utf-8?B?UmxhczJVZXVwTGEzczhUbll3RDEwaXhXYk93czZvckdjeklWQmdCUzlJS3kv?=
 =?utf-8?B?WjRBNmROZEoyMDc0RXNEQmliQXlKc2ZVS2tEUTVHS0R4d0VCUVo4MFpITnlq?=
 =?utf-8?B?byt4bE9NbnZJSitCNy9DRGJleWJBeFhYQ3ZKSXJkaWhGSSsxcGJ0MTltbzZt?=
 =?utf-8?B?eWR6eGt3R0tMeDVidWkrdS83VEUrSnY3ZzVBQnhWMzhhNFFJblJLcDVCRG1s?=
 =?utf-8?B?TndXdWkxTkZ5WW9LTjNHbXBZbFFRTW9BSk94RnRhN1RyNVdveG5jcnpXV2JB?=
 =?utf-8?B?NFNISUJ1TGRzR3ZmQjdFY1kyMkV5ZXhsbEovY1hFTDMyNVhUcG0yMDVBci9X?=
 =?utf-8?B?bXFyL2RiWjRkS051Z29BOWRhOEo3eEo0V1MzZ2RrRmN2V1BJckdSR1ZkMmNM?=
 =?utf-8?B?dDdnaVVSN2xKRXFJTVF1aCtKcUU1VVdmaHRsbDZwSDczc3FDWURHaTZJeXpB?=
 =?utf-8?B?eVVaZkxpNzg1aVBvY1ZVYmxsbHlxVld5L3k5TUpNKzNIelVTdlorQ2RjVzdi?=
 =?utf-8?B?YUIrZmliQzN4MVR2NFpOeXBua29uYThvUyt5TTI3RnduR1BIYUN3ekpqYlY2?=
 =?utf-8?B?MmFYelBKMmYrOUJ0T0ZNdWtYN3Y0ZnVZcS85UHhzYzNmZ010c2J5VVN5WFZ1?=
 =?utf-8?B?cWlOZVczaVlwL2ZWYVNEem5JeDF6cTVGMXZpTC93MytyblFUMHloT042VWE0?=
 =?utf-8?B?RXhTNlhiWU1FYUFnNk1rc2FMTkxvaUx3dFExWmVFKzhreDNrU3RydWNkaW00?=
 =?utf-8?B?N2pxV05OMkgxdlpzMHpnV0d3TzFpVmZVUFJmclJNRWRDaHN2dGlScmJaUTJx?=
 =?utf-8?Q?L6BXnsUpLEXNC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3e0aa-bf77-4401-c782-08df1d5d020f
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:35:41.7119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR04MB9355
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


On 9/9/2026 10:48 PM, Daniel Henrique Barboza wrote:
> From: Chao Liu <chao.liu.zevorn@gmail.com>
>
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
>
> Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
> matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
> and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/helper.h                         |  1 +
>   .../tcg/insn_trans/trans_privileged.c.inc     |  6 ++++
>   target/riscv/tcg/op_helper.c                  | 34 +++++++++++++++++++
>   3 files changed, 41 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b4c47d0738..0d9ae15e3e 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
>   DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>   /* Native Debug */
>   DEF_HELPER_1(itrigger_match, void, env)
> +DEF_HELPER_2(sdext_ebreak, void, env, tl)
>   #endif
>   
>   /* Hypervisor functions */
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index 4e57901880..42bf2ffb53 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>       if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
>           generate_exception(ctx, RISCV_EXCP_SEMIHOST);
>       } else {
> +#ifndef CONFIG_USER_ONLY
> +        gen_update_pc(ctx, 0);
> +        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
> +        ctx->base.is_jmp = DISAS_NORETURN;
> +#else
>           tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
>                         offsetof(CPURISCVState, badaddr));
>           generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
> +#endif
>       }
>       return true;
>   }
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 54269efee1..5db4f6aacd 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -489,6 +489,40 @@ target_ulong helper_dret(CPURISCVState *env)
>   #endif
>   }
>   
> +void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
> +{
> +    CPUState *cs = env_cpu(env);
> +    bool enter_debug = false;
> +
> +    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
> +        if (env->virt_enabled) {
> +            if (env->priv == PRV_S) {
> +                enter_debug = env->dcsr & DCSR_EBREAKVS;
> +            } else if (env->priv == PRV_U) {
> +                enter_debug = env->dcsr & DCSR_EBREAKVU;
> +            }
> +        } else {
> +            if (env->priv == PRV_M) {
> +                enter_debug = env->dcsr & DCSR_EBREAKM;
> +            } else if (env->priv == PRV_S) {
> +                enter_debug = env->dcsr & DCSR_EBREAKS;
> +            } else if (env->priv == PRV_U) {
> +                enter_debug = env->dcsr & DCSR_EBREAKU;
> +            }
> +        }
> +    }
> +
> +    env->badaddr = pc;
> +
> +    if (enter_debug) {
> +        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
> +        cs->exception_index = EXCP_DEBUG;
> +        cpu_loop_exit_restore(cs, GETPC());
> +    }
> +
> +    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
> +}
> +
>   target_ulong helper_mnret(CPURISCVState *env)
>   {
>       target_ulong retpc = env->mnepc;


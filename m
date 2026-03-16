Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3884F013F8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w247q-0005NR-C3; Mon, 16 Mar 2026 05:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1w247o-0005N0-Fl; Mon, 16 Mar 2026 05:20:36 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1w247m-00011x-E5; Mon, 16 Mar 2026 05:20:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmrscmAdyR/sKeIDd3OJSOTZsObeRuETPPc9EgJ7q5w0DADUuT+ZMcnkd6AkOeuPdHeBeR2J2jn2SB375gQwyvJLrWgLmf5fPkwH1hrtRqHtzpsTHxNti4NRhI2No0kbryOob4oWRxBbvWzf70NyS3zCTMIRzUgIf4RRjQjC0dKvtiCYmzsj2Es9Eg3zUt5n3OI22ueREwE0DAt5bLcv5lOlszMG18UPrEcsAxtJgkJ6e3Q0Jr+7B4qU+8igD18m75IMNWfSi84t8VgZQ+ShGUvNwfC72WJBXyatsdwk1Js2lXiba/6cGGCDBKynLeONxQHcIAosl+BktFvvLdBEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJRT3bbozl4isFQ8jqgFl2cVTv3Qj8QzfC24nzJwKiU=;
 b=HzlJYGT55JuGCbunm8RloYy1YrYH5gFjkt+oKUNkYqEDwCkxVSg0Ap0S72kwRBhTDGWwy1H+AZBmQSeS+1AUsfxl3RiWMZLTuoDnoAZndpgmlkeEfO4TVSeZ7IIIoZ8k5aC8G1P3AZBC+8JVaWmaZimXPD8L9MKQRIT4co7PcHz8kEC8lI6MMJXkOG8rMna6PWaEHOrKrkezvO2Do+zye85JN5YXb5I8CHE1upPQNiOxzuSj/WcMRRap2sOkEX0hJjhShbuTbqKRneQb4SwTi7PfUq5fPgzbQfAut/uCcyLjnaa1psNN1yrN4mvTHsW/i+K4XoY9sx+ex5PFDduA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJRT3bbozl4isFQ8jqgFl2cVTv3Qj8QzfC24nzJwKiU=;
 b=RcSIT3HByHHAPFnSOSN4ZYw/s0znotZui5FJbTyN/qn7WtI9Arq6bOGn0NHN49ltw1eiTmx+ihNiYBGymm5U9T5C5Ui65WseQ840HFepEhbWdgHOQJQWWQ/Wg4AhwI7bdyfQxv5sRDyj7q1JAWQnkxb8BWAGTOjt80JghzrrnyWJYETfkmIv+8T/hXOJmfSljWjGuitvultF3gz+daLPxlCDse+6cnEzXO3kQTfAYlCAa4IvMc6ehd5X9OmFHTeerdpUCp71qltaeZd+B3rcD2YEsUbFUDRrmH/DgZ+fZBZCKbSfcxOfhtalpmrFmKSsGuJL8mEtgEg3p/8J4KgtRg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEYPR04MB9198.apcprd04.prod.outlook.com (2603:1096:101:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Mon, 16 Mar
 2026 09:20:26 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 09:20:26 +0000
Message-ID: <SE3PR04MB892289278480EF2E769ED7F0F340A@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 16 Mar 2026 17:20:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-4-max.chou@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260306071105.3328365-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <ee5bdeea-05ad-44db-b113-5b358e91d3e6@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEYPR04MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 332eebac-c82c-4471-9dc9-08de833d41e1
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|51005399006|6090799003|19110799012|23021999003|15080799012|461199028|8060799015|41001999006|7042599007|40105399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzB5MHk5RmJVZExnK2dmamlIK085NVhlYjRrcnQrV3AxY3ErU3pzV0t2TjlV?=
 =?utf-8?B?MnZQcUdaOXozSkZQamdDaVdnVmZoVlFHODd6RnV4WnZUQS9kMWx2U0pPcmtQ?=
 =?utf-8?B?SmszblV0MTB2aFpyY2xKbUwveWhNTzNJUFJtNHZlekg1bUg3ZHBCNDZWMSty?=
 =?utf-8?B?WmxYSlRycFNaVzNWd2lER2NlTlJJeDBHaDFlcHpTaHQ3SXZiTnRZaUhVM3gy?=
 =?utf-8?B?OUV4MUFvVjMyS1lWTVZQS3BSbW40QlBlY2VXS0JuS3JDRVhYUHhnL0ovNG0x?=
 =?utf-8?B?NXp0ZXRoWHdrTmVUQWNCNUdDQjZhZWhNMW55NG1JTHNmMkorbTkySXJZMG0x?=
 =?utf-8?B?RHlkMGwwMEMyN09Jc0hCZG5DNHhOWkZ6NXIrOG0wSW8wUkx4bUIrUmZJeGZ4?=
 =?utf-8?B?WTcyQmdpNEdPcDNoVDlqT1drT0o4WjZjdzg0OHB5U3QrMXdycG1BMDJiMktp?=
 =?utf-8?B?Y283SXN3Z1JQVkhpZTVDc3A0UUQ5YW0wNS90aHB6QTNBbnRya0REMzl5b043?=
 =?utf-8?B?YXJQTVVENVhyblIzdDFEb3h5Zkd5VHJNdVJVcXlMVUNFOTNkek5kdzVTRG5S?=
 =?utf-8?B?VG0ySHEraXoySnlVZjAxSjFnS0xsK2pDLzJJTnljZW1NanVQN3JkVE90allo?=
 =?utf-8?B?K3I5Znd0TVBuQkovU1hFZkEySnZQM1NuOGZDcnpETnpSMnBXRzJaaDdpSmYy?=
 =?utf-8?B?SC9STkdOREw0S2czRHdqajZzQjVIN05QWUxDS281Yk9UeGxjT0VuM1lyeitl?=
 =?utf-8?B?anNYdzEzdXRXSitIQlNpbFRmWW9WVytZdDVXV0dYaWF6ZERZK2EzMEYwS1BT?=
 =?utf-8?B?aVoxUHhJME5tWjZ5ODRoY05PRERDOTNHOUIxUE1UVmE4SHJJd0NFcEQ3Z3dL?=
 =?utf-8?B?eUg1NG91RWlKZTN0YjJrcEZyTlJZWEVxNFllcDJZejBTVVYybjlWdk5xU1RL?=
 =?utf-8?B?MCt0UkxYbXRYdUZrbWovZ0hEalZDUE9UeW80MUJMeVJYQUg0NzUwdXVocEg3?=
 =?utf-8?B?NXRBL1YzUk54UE5USm4xS0haek9RQzJZLzg4QnVzTm9SdWZoSEJaWjZZcVBu?=
 =?utf-8?B?UVR6dGZlaTh1ZjVkelNtRjc5K01HUkZ1ZVlUY09Lc2VUQ3R5dlhOZXJielFN?=
 =?utf-8?B?Z3RlaDBJeDZCMnZWVFhJa3dPM0M1ZWxBZjI1RTRFOUdHbERicmt4RHRSZSt4?=
 =?utf-8?B?TzhRQS9sT1pEY3lSNE1xaCtTWG16VExjR2QvK0xrTFdaKzExU2FMbUUxTkRC?=
 =?utf-8?B?bE5lS3VOZzVkRmFKN2NHME9FcHVTSm9RR1lNRTVBSHdtVW9ZNk1lVXRQZkk2?=
 =?utf-8?B?UFNHSSs0RWQ5OFkwaWpoa0NXVTFHRXZ2MGM4WnlxYkYxRHM5eDFCajZrYzZh?=
 =?utf-8?B?d1h0S2ZManhnbVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0N6M2ZvcDlaZGFxd3QrejY2dmt0dHpReExjSGFtTG5IcUd2QVI3ZXVTNTdp?=
 =?utf-8?B?MTFGVkZwYmMwUnlROWZJazV5dkxWYkc5bjVVRE1jeDBRcXQ1OTZUZlRBbVJ0?=
 =?utf-8?B?K1B0VloyUE4vL2tGczhscFFtOUtZcEhNMmFBT2tIRXpyRDJsRFA2cDByeDdJ?=
 =?utf-8?B?a1lFdU0rQzZoZndZdU9rY01uMjB6Rm5sTEQ3THlGVkdiLzREUGhOQTVFbnl5?=
 =?utf-8?B?dTR3Q0tua2x3bTRydEIvWUhlQ3lSRFp5SHYxUkQrSG9uMnBkZ25JKzhrOHpt?=
 =?utf-8?B?MnZoSnBuQWVUSmdpSmFPMXVid3ZXOUpNMzd4QzZSSjNLTHp3NmhOVG1JSnhm?=
 =?utf-8?B?WWNZWjdDcU9LSFhlcDNMbHowelEwQTJSWURwZXpxK0RrMm5DQnUrUzhwaVhR?=
 =?utf-8?B?Sk81WHk1Szgwc1lmNmRGRTJxYjl6SmN5ZlkrbmNTSUdITkx6L3llOUJpZGo0?=
 =?utf-8?B?a21EQVFTbEFuOGhuOEo4T3Q5Z0piZE92ZWswb3EwOGhJQ0wyanl0Y3UyeXpS?=
 =?utf-8?B?YVJNTEIzaXJhekdZelRuQlgrUzdiTGxmc3pSK3ZUK2ZxaEFPbjBiQWw4TXc2?=
 =?utf-8?B?RGovYUt2dTJ4blBWZ0d5cUtJelVDZWtzdERBSTV0VHQySFVpUEtaNUxwSnNy?=
 =?utf-8?B?dkR3ckt6aXhKMCtaejRLNGhwQWN3WlQzN1pNZEhYeDU2ZjF3UEV6bTRUQXR2?=
 =?utf-8?B?Mkdjc0dnbVJMaFRIODI2RGs4TGQ2NEovY09tTk1uU3VOeUNBbjJHd3VlZXAw?=
 =?utf-8?B?Vk96dnRpSVlVNkdvUi9mT2haSjU5cWJlNk5DNVBNZEF1Q2lOWEhXZTFtK05P?=
 =?utf-8?B?VCt1eXEzSGNNdWJKOTRHamU2WmRLS3pJOGI1ZnM0YUJVbnIwL0lmMGUrUUU3?=
 =?utf-8?B?N2NTQlFRVnJVZWFxTmh2UGVjci9DOEg4c2Z2RlF3cWJNWkttRk1tL25obTBG?=
 =?utf-8?B?TXN2WDdRRVlCWlcxRmZOZVV3SmduMmdQU1RuQVBGT3c1cmMzN2JUMkxVak5l?=
 =?utf-8?B?amhjSWFWSzEwRUU1N0poZitKU0RrM0s5clFaZmNxUnl0NHpOWW54VVNlZEZN?=
 =?utf-8?B?TjFKM0FNYzZMVU45dTVqdzdJZjFWOUtFYmlsdkg5N1BiL29CcVJPSHF2T3A3?=
 =?utf-8?B?NDdmN0ZEUDZ3QkNwSWNQWWtPT29iUlFlTnVjNmpXdVBIKzlVMjhJQ0V6ZkVs?=
 =?utf-8?B?QmVmaG5lbnZXdCtQS1VUVThaSVp2T0pWTW1NSThrTGVsL0hqSzJrR3g4Y3Vh?=
 =?utf-8?B?ZmRiSFFoNjNBZVJSZ0dVNGIrb1Y2VEJQVitRTzJ5KzJDMDM3V1RKcXJYK0Z6?=
 =?utf-8?B?L242dWhxdGM0d3JqZTdNbFVVYjZSWStieGdrcmpPaU10TGVMNEdxMGRXekdB?=
 =?utf-8?B?OXU3by9Pd0xobHJVZ1UvNkF3WktJYk9aWHplZnkwOFRLaTN1SWp3cGJ3OEdY?=
 =?utf-8?B?Z1d0b05MMCtQeXhJRUIxN0dpaWxRVmZYM09NTW93ZjZ5RnFPd01GNGJsOHFr?=
 =?utf-8?B?Q0t0eVRoQWpNNFRuV3ZkQnd1czhIMmtyT0t2NW13SUkweVdpSHNNUExWRllZ?=
 =?utf-8?B?MDVwcXNmV09zZzNHeGpDNEhDTkRUODJVak43UmxuYllZUXNRaXo4N1pUMEdN?=
 =?utf-8?B?VkttSC9DeEh3ZjRDbUphSiszUEpwSlpOZVRoZHhVbkN2aDVuVENoYkFUaTZZ?=
 =?utf-8?B?QVpuWDh6Z280bEI4czYxb0NqeXBSb2pLUTNsc2JVa0JleGJuNFlPc0xqNzV5?=
 =?utf-8?B?ZURiZTVlbVplQS92NG8zQmVRK0hBSG9KTzZYdXBWVTVwZEd2VDIybC9rMUs2?=
 =?utf-8?B?dUJPeXlzZ0tkVGNCYktJVzllYjl6MUJSMjJuREM3N2M3andPZHpoWnZxSkNJ?=
 =?utf-8?Q?XVlsCQGOGQWJV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 332eebac-c82c-4471-9dc9-08de833d41e1
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:20:26.3502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB9198
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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


On 3/6/2026 3:10 PM, Max Chou wrote:
> According to the Zvfbfa ISA spec v0.1, the vtype CSR adds a new field:
> altfmt for BF16 support.
> This update changes the layout of the vtype CSR fields.
>
> - Removed VEDIV field (bits 8-9) since EDIV extension is not planned to
>    be part of the base V extension
> - Added ALTFMT field at bit 8
> - Changed RESERVED field to start from bit 9 instead of bit 10
>
> When Zvfbfa is disabled, bits 8+ are treated as reserved (preserving
> existing behavior for altfmt bit). When Zvfbfa is enabled, only bits 9+
> are reserved.
>
> Reference:
> - https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu.h           |  4 ++--
>   target/riscv/vector_helper.c | 39 +++++++++++++++++++++++++++++++-----
>   2 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..962cc45073 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -191,8 +191,8 @@ FIELD(VTYPE, VLMUL, 0, 3)
>   FIELD(VTYPE, VSEW, 3, 3)
>   FIELD(VTYPE, VTA, 6, 1)
>   FIELD(VTYPE, VMA, 7, 1)
> -FIELD(VTYPE, VEDIV, 8, 2)
> -FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
> +FIELD(VTYPE, ALTFMT, 8, 1)
> +FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
>   
>   typedef struct PMUCTRState {
>       /* Current value of a counter */
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index caa8dd9c12..7575e24084 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -33,6 +33,22 @@
>   #include "vector_internals.h"
>   #include <math.h>
>   
> +static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
> +{
> +    int xlen = riscv_cpu_xlen(env);
> +    target_ulong reserved = 0;
> +
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> +                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> +    } else {
> +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
> +                                           xlen - 1 - R_VTYPE_ALTFMT_SHIFT);
> +    }
> +
> +    return reserved;
> +}
> +
>   target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                               target_ulong s2, target_ulong x0)
>   {
> @@ -41,12 +57,10 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
>       uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
>       uint16_t sew = 8 << vsew;
> -    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
> +    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
> +    bool ill_altfmt = true;
>       int xlen = riscv_cpu_xlen(env);
>       bool vill = (s2 >> (xlen - 1)) & 0x1;
> -    target_ulong reserved = s2 &
> -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> -                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>       uint16_t vlen = cpu->cfg.vlenb << 3;
>       int8_t lmul;
>   
> @@ -63,7 +77,22 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>           }
>       }
>   
> -    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
> +    switch (vsew) {
> +    case MO_8:
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        break;
> +    case MO_16:
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    if (altfmt && ill_altfmt) {
> +        vill = true;
> +    }
> +
> +    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
>           /* only set vill bit. */
>           env->vill = 1;
>           env->vtype = 0;


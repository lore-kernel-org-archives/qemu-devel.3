Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=PXt+atWT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLynj-00062i-H8; Wed, 28 Oct 2026 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLynf-00061s-Gx; Wed, 28 Oct 2026 04:14:23 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLync-0006pf-Qg; Wed, 28 Oct 2026 04:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXYvh0dpUi9yK1iW/eaS12HeAmfD2CnKTlAImXNrm2s/d7r2uslwxeqkIUZafYVT9IamWCGrnKJ/fendWimBMVBXuxvYhTC/taGsqBC+yZkCTyWOPD03F/dUtHM8BdOwMefyn5SUgyQ3WH450S+VFkNF9YdCR180TblVSEjPLnsIv2x4Ghme4VMlh7sIUBG9sSdpUeD6wAc9h+m82tM7kGZp6YI0gMAqR3LA0McqT0UvtmAcFyzPCTO5fBrl97GlxRgpdoEwPJBW3PuEMBhwa9+U8FXj1nOyyxu3y5//1u9wQnHMMgFENsEqc+22gC5N0j+c9hDjFO4jg2XdTe+FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dLkUKqIWr2UXzwkus1WVcPH1IsiToFOqWnwDQiB9dY=;
 b=Bu/xWd5MZzgwVGqAiFN7iuu8l2c96LUOi+j9TTIwaonW47DH613Fwohm7uX6DhRZThoq4p5meqqHR+zhq8bNwLgl1fWftoC6aki7vdceMxxc8gXgpKqYl62WBeAvT4SrJK1qWFyiiJIdt24nxvGmtHGohyWuAT9OwBsHUILkZsFL7LFG8EnwrrE5QIE9NnAEdXoIfglV6znOX1uV7P4nKw79pUvcYz78kSdP8zw0Wn1j6lGNrYlUsHEInVUUhUSuvE1oysR+Ugn+0L+lm6JlKEUzp9BqEQRffks7GUfAvUiOqfQpV7Xp7zfpP5U6AktO3xdgl9Hvb28eniGZ/JViAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dLkUKqIWr2UXzwkus1WVcPH1IsiToFOqWnwDQiB9dY=;
 b=PXt+atWTSRA+bX4YS7DJC64dGrqJl0RIr08cIlr/Ws11jgCPP8aeQuyDDzW2bpkwCWbDsUjaqLDVxd1ftfawE4y6X5ElihZYzRJxA4+c8XVw9E2rTnSTxnroJ6ILZmyPsrVBN9YdEx78jxsHdM7OP61Yc2w0AWqu8mlKIQ4dNKJ/8hrej4+Mwxdj7kbx29fSORyWcA/MSHGUMg8iRMM70RoEPsS1in1V2EU2fTexk9nHn+ZjOd7HgwAQztFnSP8qxfN596/UWpjSvGUJzCUepNgELh8TZyTRH1gX0anQPEMRby55jwMPaeJN1/qjBa3R8a5iBpVZZyCsGiIa2zGs0g==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by OSNPR04MB9767.apcprd04.prod.outlook.com (2603:1096:604:482::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:14:13 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:14:13 +0000
Message-ID: <TYZPR04MB74910D812571C6215551151BF36F2@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 28 Oct 2026 16:14:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] hw/intc/riscv_aplic: Add in-kernel aplic save and
 restore function
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
 <20261026024048.630015-3-wang.yechao255@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261026024048.630015-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <ed647e54-b146-4b0d-85bc-89680e1c73aa@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|OSNPR04MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e1fc4b-d6c7-4a7f-d9d4-08df34cb727a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|55001999006|19101099003|19110799012|8060799015|25010399006|4140399003|41001999006|22091999003|24121999003|23021999003|5072599009|6090799003|15080799012|51005399006|12091999003|11031999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SENkMXZ6MEN4bTRJblNvNWRjNmJQazBSZWdmcldDcHUraTFiWlV4S2xPblhF?=
 =?utf-8?B?TFlCejZ4SHg1UGZaZW05eWxiQmk4UUVtSzFQNlZFMWZ0S3UrSHk5MG5Udncr?=
 =?utf-8?B?d1NQckR4WncxRzBBVUd0UnNoS0Q4YWZSMGFiMjJZL1QyN1F1Y3hjK0MwQzdX?=
 =?utf-8?B?dVFuUHNBb0Z0a0FvZjUyR1BHL0RkRXJ3bTBoUXlWNkNFOFRvei9WNUxXUW9L?=
 =?utf-8?B?OThqOURYTjJ6TDMzRkZEaGV2eFdaUHNzcHlMVGNrMkUwK1VJWW8xZmNmamQ4?=
 =?utf-8?B?UEVQSjJGNTRVdVlHSytQREFac0ZSRmYxWXJjRnNaNG9CbUhBazRHb281YVo4?=
 =?utf-8?B?M2twa0ZRSzhxUWNBRG1PZVoyNHV0UWpRaGNGdDQycGo0ZkljWHJJWFkrOGl5?=
 =?utf-8?B?UTJ4RlBVb1RJdXVrRng5eFFhZzFwb0ZMdDZoQ2JxTngrTlFuWFJEdGVwL2V4?=
 =?utf-8?B?ZFduYmloTUNrZFNTWnpldnMvamQ1ZU9hTzZzbGxRMjhaMjM5cEdRd2Vwd3Q2?=
 =?utf-8?B?MlgvUVZKOGFLSklBN0dHNjlrMTgwdUFjU3RWUVZZU1pTcXFtQi9UeHpvcmNU?=
 =?utf-8?B?aFE2ZUlCQUdjUmZ5WG5JK05BMUZPSVR6dk9ROGhBM1RvTU42bjNvakQySDRx?=
 =?utf-8?B?WXlERmxJUkZGMGZGcyttWTBuaS84UUNjQ3RyNldYMnRRUFNEMHVUU3hPSktR?=
 =?utf-8?B?YkNCaTlZYlpNZ3lUYU5wQTUxd3p0cnN2MC9OMmlFM05OMXFWWThPcTBMUSs4?=
 =?utf-8?B?aThYRGxxRHZEelo5SW45dVdnbjhlOWFUZ1FISitDSVhiV1pMQ0ZLdmRrWVpY?=
 =?utf-8?B?OXNTbEo1MWxwMjV4VnVPa0FZdk9KWCtFZk5OdEFoUFRPNk1rb0FkSzRvQ3NI?=
 =?utf-8?B?ak15MHo0VE1CZXIvYXZUdGRVQWFyWVdKL0VnRjY1Q1ZNN3lpL1FiWWpqUTRI?=
 =?utf-8?B?dGs3VTZwUlhZOWRVZjZBald4QkZaM1dKdFBzUHJiNEVFbjltREpQVzVDZDJu?=
 =?utf-8?B?SnRTOVoxczlxNVBrVXRnYUVhYk8zTVBNYXdFYzdTbEFOUWduS3V1OElXZTBR?=
 =?utf-8?B?ZW5nNFp0d3lDendIRjdCcURnZDQ4K3hDOEZoTldpWXhDSVZSeExWTDVFcFdJ?=
 =?utf-8?B?cmxIVGwyeGtjM3BrMXlwd3ZDd3B4R0x3c2tiYTd4aUM4RnJzRVBFMmVvcHZh?=
 =?utf-8?B?ME9DMUZweUhOWkZoc2lGODhUMDFRR1lEdDhiM1BWTFhSNnltM3gxc1NxSis5?=
 =?utf-8?B?VWw5WnVuYWhCb2NLdnNlRWVtck4xelFrUkN6TnBuajlzWExUc0pFbEZFTjc5?=
 =?utf-8?B?N2g0V2dRK0kvdWZFYnhnN3J3LzFNSDRvUmM2YkM5bytVUHQ3ck5WU2ZlNmpJ?=
 =?utf-8?B?QTZSZmlCOEt3cnJuVVd0dXVLcDF1Q0l4ZlBzbEtZY1dXVytWbVdKYUFxN3pG?=
 =?utf-8?B?blBuSE1vWmlibHhzYnFMbzhrSWQxdGVXbzRyY2JZYkVYUGU4Mkl2US9uNk1F?=
 =?utf-8?B?eFV0WThBSVp0VnJmeU9IZVdueFAvb3UwbEJLY0xBZ1M4bmhGaEFyazZEYlRF?=
 =?utf-8?B?c0pSZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxSaVRTc3BQdU9tbnJpQnVRVTdiN1J4Q0x1eDZLb1dtZTI3TGdTU3F6WFNW?=
 =?utf-8?B?bEtWSDR4Z3JUMXQ1YnpxQTRNYW9IY3VQMitnWkZRbDN3dVVPMUpjQlBmQU9H?=
 =?utf-8?B?WnpYdEwrbG1OWldUYUFqVHhUS2l3K0tWUU1kMnNvbUEybWpmZnRiRmFzemhH?=
 =?utf-8?B?dGVtV0JSbGdYaEtNcUhCS1pHeEpWR0xKVzIxWEZnMXJhQ090STNCRjNSUjcx?=
 =?utf-8?B?UGFid1Y5YUFqMklYSHVPRnUrSC8vdzF3dWJUTkZwaWlCV2tiMjhvTi9zZ3c5?=
 =?utf-8?B?OWxoVkNHcllpNUJzMS9WTEdOZmJuOExzQXdMdGVNMmhqSXRabzRRV3Z5bGRH?=
 =?utf-8?B?TTJRODcxWm1qdEJrN1NBeGp0d3BZcjZlMW85YkVBaithaTZBditsU253L0Fi?=
 =?utf-8?B?eHZCU29IK29WQU91Zk9kenQ2M3VCNjkvV3Y3aitwOUVEcU9mL2U1Nk1FeEM1?=
 =?utf-8?B?dmNyakhsVHp6MGJIWHpsN3l0RUtpWHh5MzQxL2NTMnpvbHlnQ20zNmdYTUxL?=
 =?utf-8?B?dmxaR3d6WUVpanNXNkpkNVRHMWxRMmtvZ0xGOHZRVWNxNmpDVFhETnB3Y1l1?=
 =?utf-8?B?N2llR242RzY5L2VSVmZLT0VxbEtMNUhNL2R0MnRLMWVGUlhsRWEwWVpBT0RF?=
 =?utf-8?B?WkVNZ002M3czT2g3NHVKYkZ1aks1NFpQT2N2OWlWZDAvSi8rNzRJd1VTK3Iw?=
 =?utf-8?B?QzhHQTgrTFhrSktpREZnMmwrRk9YTmJuOHVmK0xQY2dPMjVDVFNEcmphQ1Vh?=
 =?utf-8?B?NVZMOTcwaXpwNG5WcUdRRStBak80RW9oRW9iRi82OHFLTEtockgvZmVpUEdE?=
 =?utf-8?B?MVpxNnRjRk9FcUhYU1BnbTNNZFp5OGN5QVIxR3E0N0Mralk3blB4NmxYdk5J?=
 =?utf-8?B?Nk9UMDZDL3dMTUQ2aDRxU1BoUlBzRDZrS2Ntcm4yL3dQVWZzTVo3b0tKcVMr?=
 =?utf-8?B?eTdpRTlIMWlTam4rTGFGM2VzQ01ucnl2OUc3bks1Z2s3T1I3SlNyR1BaZkNP?=
 =?utf-8?B?TEVkT2t5MFNYZGJBUEZEWndob0Z4ZXhINEltNnhoRDdpbVNWNk9mMDFCbDhE?=
 =?utf-8?B?RmxJeTFjNHBtVkEzMjZzL1phNCtUSll5N2JCQW9JMk92NHdEZFhsS2drOXBo?=
 =?utf-8?B?MVBvMjNGRVFKbE9SQXJ4OCtwanZYQ3lKQ1hJanpNL2s0NGg1aWh0NzZLZmtX?=
 =?utf-8?B?a243bHFIdEowcDJUT2g1KytpTUxUSjBKblVCUDN2VFNDdmxlUm93V25lcUlI?=
 =?utf-8?B?Y2lUZUFYQ2Z1cTkwamNMU01RMnVXeGp2MkxZOUxaSEtUTUcvVGxQYURkUk9O?=
 =?utf-8?B?VmRmUWt3YitUdTRqQlFzRHlaZXlGd3BhNWlKdzZMdEVUWlg3OGJqRlBZelpL?=
 =?utf-8?B?MkQ0YTlxelZFRHN4cG5yVGN2Y2h1Qm85aUplMFl3RnZyQVVFa0pGdUFRcnBy?=
 =?utf-8?B?ejlqNUlua2JiTHhEL3Z3SWkxQ0RaSXRRSEt1KzFhVmxQNU1ub0VYTEdQdTNO?=
 =?utf-8?B?R2JFMmx2aFdIcTBDM1c1MFV5R0VTTndHcjdCNjhlNGgrUWdnMzhnR3N5R21G?=
 =?utf-8?B?ZHZzK3RadFQ4aVZuSDFJVWE2SWQyM2g0cDNkRzJaZzByQUhCeXU1eUl2SWJk?=
 =?utf-8?B?YVNxUFlVY0hPbGV4THU0bnVGbjRIQjJkR0JDQUNSd3NOdGRWTHBqRnoyT3h1?=
 =?utf-8?B?NTVUY3NpbGpmOVlFeXFBVkxCekhWZE1Cek0vajB4VzJYcU1GTUtIbVFldURH?=
 =?utf-8?B?M1JsSUE1WnBtWmZXOE90WVdqOTBBcTRsR29HVENvclVKUFBsM1RpNnVjVG45?=
 =?utf-8?B?Zlg1VDhwcXVhb3ZMOXczSmEwVisvT3lyZTNLUHl4SE5ZMmpqc0JBK0oxaEQw?=
 =?utf-8?Q?cCKWyuGzVLyxg?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e1fc4b-d6c7-4a7f-d9d4-08df34cb727a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:14:12.9293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9767
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/26/2026 10:40 AM, Wang Yechao wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Add save and restore function if riscv_use_emulated_aplic return
> false, it is to get and set APLIC irqchip state from KVM kernel.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/intc/riscv_aplic.c         | 201 +++++++++++++++++++++++++++++-----
>   include/hw/intc/riscv_aplic.h |   4 +
>   2 files changed, 179 insertions(+), 26 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 03a0852b8b..a3d209ca23 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -979,9 +979,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           }
>   
>           aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
> -        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
>           aplic->state = g_new0(uint32_t, aplic->num_irqs);
> -        aplic->target = g_new0(uint32_t, aplic->num_irqs);
>           aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
>           aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>           aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
> @@ -993,8 +991,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           if (kvm_enabled()) {
>               aplic->kvm_splitmode = true;
>           }
> +    } else {
> +        aplic->nr_words = BITS_TO_U32S(aplic->num_irqs);
> +        aplic->setip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->setie = g_new0(uint32_t, aplic->nr_words);
>       }
>   
> +    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
> +    aplic->target = g_new0(uint32_t, aplic->num_irqs);
> +
>       /*
>        * Only root APLICs have hardware IRQ lines. All non-root APLICs
>        * have IRQ lines delegated by their parent APLIC.
> @@ -1020,47 +1026,190 @@ static const Property riscv_aplic_properties[] = {
>       DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>   };
>   
> -static bool riscv_aplic_state_needed(void *opaque)
> +static bool riscv_emulated_aplic_state_needed(void *opaque)
>   {
>       RISCVAPLICState *aplic = opaque;
>   
>       return riscv_use_emulated_aplic(aplic->msimode);
>   }
>   
> +static const VMStateDescription vmstate_emulated_aplic_state = {
> +    .name = "riscv_aplic/emulated_aplic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_emulated_aplic_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +                              num_irqs, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> +        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +#ifdef CONFIG_KVM
> +static bool kvm_riscv_aplic_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    return !riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
> +static int kvm_riscv_aplic_state_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIP_BASE + i * 4,
> +                                 aplic->setip + i, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_CLRIP_BASE + i * 4,
> +                                 aplic->clrip + i, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIE_BASE + i * 4,
> +                                 aplic->setie + i, false);
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_aplic_state_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIP_BASE + i * 4,
> +                                 aplic->setip + i, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_CLRIP_BASE + i * 4,
> +                                 aplic->clrip + i, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIE_BASE + i * 4,
> +                                 aplic->setie + i, true);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_kvm_aplic_state = {
> +    .name = "riscv_aplic/kvm_aplic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_riscv_aplic_state_needed,
> +    .pre_save = kvm_riscv_aplic_state_pre_save,
> +    .post_load = kvm_riscv_aplic_state_post_load,
> +    .fields = (const VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, false);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, true);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +#else
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    return 0;
> +}
> +#endif
> +
>   static const VMStateDescription vmstate_riscv_aplic = {
>       .name = "riscv_aplic",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> -    .needed = riscv_aplic_state_needed,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
> +    .pre_save = riscv_aplic_pre_save,
> +    .post_load = riscv_aplic_post_load,
>       .fields = (const VMStateField[]) {
>               VMSTATE_UINT32(domaincfg, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>               VMSTATE_UINT32(genmsi, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> -            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
> -                                  num_irqs, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
>               VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
>               VMSTATE_END_OF_LIST()
> -        }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_emulated_aplic_state,
> +#ifdef CONFIG_KVM
> +        &vmstate_kvm_aplic_state,
> +#endif
> +        NULL
> +    }
>   };
>   
>   static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index 62d2b33ade..de0fed4748 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -53,6 +53,9 @@ struct RISCVAPLICState {
>       uint32_t *idelivery;
>       uint32_t *iforce;
>       uint32_t *ithreshold;
> +    uint32_t *setip;
> +    uint32_t *clrip;
> +    uint32_t *setie;
>   
>       /* topology */
>   #define QEMU_APLIC_MAX_CHILDREN        16
> @@ -66,6 +69,7 @@ struct RISCVAPLICState {
>       uint32_t num_harts;
>       uint32_t iprio_mask;
>       uint32_t num_irqs;
> +    uint32_t nr_words;
>       bool msimode;
>       bool mmode;
>   


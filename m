Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674EBEB7EB5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjF8-0001A6-SI; Wed, 04 Mar 2026 05:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vxjF3-00019m-Ls; Wed, 04 Mar 2026 05:14:10 -0500
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vxjF0-0007z6-4X; Wed, 04 Mar 2026 05:14:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhOJ+DW7E3I0oxRXZDWzd9oynR+Aa2OuL8/hZLyxxs8lDax2UNwuyavD7Dal/TvBe79vEOal7yo5LNTPvU9MvTdASxhYOD9X/IYnXuAeZ7PY4WQ429NV6tEDjUEAFL5f0vYbdn4XNJZOhOFclkvrtAvkJMm2nUm5ooQJpaPl7EaqustEhgPhCcXF0fFKEewMCXn4hQBBi03uklqSok1hPe4ZgfIjgd+GLdFAgEtHGP+1uDIaEohh3shCj6BKQsy9XMNiRZdVRvpmI9BFCDf9r2Cj1AEOnYFkJPKh4SoaAmt3yMwA7xQ7PSAVvQPpuo5z3XNrt0VVtddjV9/4jzW44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUGQddPNys18PRzmkKSAFJTIZfBSgFXVrqJBUS2nL4k=;
 b=kS9VBg0USPP7E8bA4n/EudTSWioG7d2XTssQwH3e82/1iUl5+g/yzvXGuUXWjWNJBdcrW9yXv5SFz1OGvLkITXvVBeQo2TNTQYD3DBp7pE9LFxjowjZGav4G7AbCNv2bJGho/86yJtwga+Tby4V9Fwf6VGey6UhZjglt2KEgSiGgHx3e1CdTW5Tqk0Y2MOs5ZkDYTWI5QSBGBpZbbwBOvGVXKxR5Uq6bO2/FVtmsHn1F9G9bFj9FfG7Rtls/XtPSbg26lWB54SK4+YRXcHDPFzU9GdjY8j20nsGms7t8mR0J7D4PJFeRzaLubM+wsVggPwRh2CD8R0AQ/eiNgHz3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUGQddPNys18PRzmkKSAFJTIZfBSgFXVrqJBUS2nL4k=;
 b=vNTLdDJ8fvVrfri8Qreevt8y4FpJOJ2RtTiw7WlZqcCUYOLrnZ5k5X1JWlUCaNfuulE7/HpcxuoYywLYG+n21JWEf4k9pdJxfslo83W71tD1xNelyCrjfcgpzPruo5crD/ldP8b7y3fXyiBvEi1GpuGq/OV91yERMr01MIlNNPbTx3vt8sTVpZI0lpWSDorFQgnEfP0swTgq4Qcii/KtOa0US8O4skyLfQDM+yn3+2ZQllDyjlDRGsgu+qCJIPauB8gDfNkbHnRwSSgddqnn3moS2sO8l/yW0YL8MVQNHRgRHXyvuxzmQs14RaZ7f24Nz5WxvlSfZFnV0hp2L8x3bg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR04MB7122.apcprd04.prod.outlook.com (2603:1096:820:f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Wed, 4 Mar
 2026 10:13:51 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 10:13:49 +0000
Message-ID: <SE3PR04MB892292C4C25BE24E25E3B431F37CA@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 4 Mar 2026 18:13:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>
References: <20260304040959.47267-1-jay.chang@sifive.com>
 <20260304040959.47267-3-jay.chang@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260304040959.47267-3-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <52f749df-a2af-42e6-99d8-75569a1e7ad9@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR04MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7042d9-5e74-439b-4392-08de79d6b89f
X-MS-Exchange-SLBlob-MailProps: vuaKsetfIZmcv7cN2CQdJd4XVKwegu/4uZqsT57xel+0AS8sysXPzcRXl0L+177tAptNeC3fkSfqTF3BPRKDBafNiTxtMexIlOL6To6/pa/IA3BOWp/wKO+ih6fgvGpUsAOeZhLkbyf2wt1uPQQh0ZsdPyUUpparWnqSkKmNDdlYcWnXSJalpW0H6u36JP9bmC00IqpDTiX87xJE0oDj/c54u60PWkLlsXsvhKdmljjhaznHKbyi0lepBYGRpbtuY8bTrKHQzujfT43op9EUf4WoocfMvo2amwlPbndwuHKh4QyxJvX6HgTDM2ayYahL1GJ6JHMe6rwpoWfg/+qeHMzWKuc6NONUS12MZAua9NOUgJc1he6pu2+f42mv9ZTT+CuZBE+FDyPPFDC/EwmFH/E/4/7jtM4+E0gYI5yJBqYJpz/uR5EORqwEQ1LYl01b6Ec1QeVfiew5qMhW06qTpAVl0ig4kbDpuvE2h3gURl7dbDRzAko7wjxnp1NBPMLPayQE2ETsqErF7xeuDvzPqQTFr/gabZZKmAiBG1cLanQIOB1aes3UtJdUEVulG6+Tbp06qaLtDxtOUWiH6M9kbxmvypymV+sVcbLXJiA6os9BB8abzJ6VzQpaTJG3eYVZJnSPy3/fBS6bF3vLNgnA8kKU2iFhutT4xOYGE1CUMitC6EDZdiCzTiRQ6Ge4oK2a0U4aA2vS4QGIUdyhXozVYHw1aubp09fvSxlhvKnbG0WI2L/TJnisbOEIEzIiahwf9EfKuXCFXWfy4G3ZoQe5Qe3EomNK9tDw7yM6rCfSQZ5rB4wDTxVy9vYpyzuwBEdG
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7042599007|461199028|5072599009|23021999003|19110799012|15080799012|8060799015|6090799003|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzFidmEwVkYvQXNlZ1dQUFZ6YmdiQy8xYk1YSWZCKzlDS1NscUxOTXNrejYw?=
 =?utf-8?B?REF2Z1Q5SlI3NVRYZGpXVWtNd3RndWpZWGtISThZYitxRkgzUTJYZUZCeGUr?=
 =?utf-8?B?d1FBeWhmcHEvRUZvSFVyZTN2dzdMenN2c2M1UngvUXZxZXdTSVE3ZU9hdlJZ?=
 =?utf-8?B?cEtlRzlDOU9jaFJkRllGSWRoeFVsTFNHdGVCaUZRanR5UDZUSjlPOG9TUGRW?=
 =?utf-8?B?Y0xrMEZwZFZ0U2lHWlZheFZnSzhXTFpYTWFDU2xibE5PaXkvNXFtL2NlQkV3?=
 =?utf-8?B?NlBUM2NJNVJIM0JBWFZOZGFpK0Q2Sys0Y2I4YTFLK1BzSXEwV3hIdXlBMnZV?=
 =?utf-8?B?ZUllYUIwQ3VaTmduNEpJVUVTdFVSeGtaZThoUGNWODV3THpveUNueDhKVEE2?=
 =?utf-8?B?OXgzUjg4clVEZmE0cmRkU2V3UmIyRVFjdk5ZQWJMdUROTWEvZ0NtcWhXVHBx?=
 =?utf-8?B?eFhTaFB4UlBKekRRSmFWblRNUFJTL2J1ajQxT2UvN2ZJNWFoZEx6VjcvU2wr?=
 =?utf-8?B?TStmRUR0aGh2Y3BNSWhHMEtyMnk0N09oWjh4ZWhZTmhIMExEVS85OWtVMkYz?=
 =?utf-8?B?c0lZTFJtVmxEa0dGV01maXdSaWYrTW0wT0xtQThwM2hoUnpaMkdLN3pWR1Mv?=
 =?utf-8?B?OGtubUZ2Wm9wL0Jodk9yN2lOdExmUk10U3ZzMkJXeHpJYlc0b3VQa3pCc3I4?=
 =?utf-8?B?azRrY2NGSFhpVWNXT2tDMTN2Vi9EcmsxWDJOLzgyblNPMW5kQ05pN0NkMGpw?=
 =?utf-8?B?YnhBQkhLV3BPWU5JSlplSm90OWh2OUxKelhvc1cxbUxqL3kyNUVmcllhR2tz?=
 =?utf-8?B?bU5KMG5taHFwbVdtcVZUczdVV2lQdytsSDVacXl2OEw5R21WeDJUMXBCUTNa?=
 =?utf-8?B?REZyNmJOa2FUTVBhTHlNY1RmVi9uRThxVlVhclJrZFVPbHBBdmoxSkpvSkNP?=
 =?utf-8?B?QWdMWStxWFBJRFVNeGM5b3lJNjJ4TDdMZS83dnVHTU1kV2dMZjN4Z24wNHI5?=
 =?utf-8?B?VHQzb2sreVNNNkViUHVSZ1h0MHJxdVBlTVkyYXZ6NW1TRnI3OFRyNm9vUzU1?=
 =?utf-8?B?dFppZWd1TllzSHlUVEtxMmdTaTQrcUhVcktkWDUxNE4xMUJReXJhTllQTnpN?=
 =?utf-8?B?MGsrQklNNnBtNC9RUjJ5MEduVU5zaWExSGxjcU13eURRd2lXalhxa3hCV2ly?=
 =?utf-8?B?VDI5aUYvS0VBRHRtaENrRWJPVmNBR1g2Y3duMGh4OTNDaFJsY1BpU2xUQTBz?=
 =?utf-8?B?NHdjMVoxaVRYUW9PNHBFdmJOcVBZcWJjVEJEamc3RHFKK2Fqdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFGeDAvWjIvT0hHUTA2akJWQUY2cjRLbFZ0SUJNUVczMWM2MjBQQlVXakFQ?=
 =?utf-8?B?L3FtNzRZUTkrejRjZHMzYnR5L0lRY2tCSkNHWFlibDRZMTlkZkh5c1R2TWsv?=
 =?utf-8?B?MDVLVG4yd1VFdm5sVmdLRmFLWjUvM1RiZGp1aldaMzIxWlp6YmlkVm9NcGk2?=
 =?utf-8?B?STdXdDByS3FPbGl4U09JUXNXYW1TbFA5UGhsSk9qbDdoem8rQzlHNXRmekIw?=
 =?utf-8?B?NmhCU1dGNWIxcDdJbWtZZDlObTV1UkdWcDlBWTROVjRFdHlTSVA0Z2NFNnM4?=
 =?utf-8?B?UEtSSHM3YzZiNUhxc3NCVGNmeFJTV3JKYVpuV2t1NzBCTlVrWGNlcjhKR3gx?=
 =?utf-8?B?WUJaYU1oNVpXYmtvdW1uV0pGdGpJUDZRcnoycXY0ZE1Od2JLZ3ZiVUtQZC9i?=
 =?utf-8?B?N1gya0diOHdna2tGMUFWdGk5eWxWcklzemd2NUxVakgxajQrNVdRYnNQaDJC?=
 =?utf-8?B?U3lIdERDWS9nWnFwOE83Si9IaWdKaUczUkZuRDMxU0dtY1BuLzh4bUphOXM0?=
 =?utf-8?B?QnEzOC9sSVdlRFdsVHYwYlZldjJ6b3BoTnU1aU9zQ1U1Q2YwM2IrQnRnWjdj?=
 =?utf-8?B?akJJVndveGZaMXM3Y3F1STA5NExwNWpkbjBmL2VXQisvQWpIZUt5SVVHelZU?=
 =?utf-8?B?UjZ2QlpCcVZ0VUNHdUdObVRaWHBoQUxscWo2RkpSZ2tzWmtvRk1ZNXJaZ1JF?=
 =?utf-8?B?cko1WUErNVpCTmhCY2MzeEFVL3BVUkJCZXljek5nWXZkeXdzczBHdTFUeUN5?=
 =?utf-8?B?MUxWUjFjTG5BNFFLTWZaZjk4Z3RjTndDWXh3N3hSSy9Fdk1LaHRMQlEvS1RF?=
 =?utf-8?B?aUhyQWZFYzJwZ25Ma0U1UWVocy85TkdLNjNocTNaU281b1BETHJNRkkyOHVS?=
 =?utf-8?B?ZFBSVklVWWV0SUlxOTRybTVPNEFrdXRkSFhMYTQ3ckh6eitHQUpZc3dsdFUr?=
 =?utf-8?B?bDQ4dHdEcUJkMFFTeHhWYkNhaW1qSEpMcWI4OHBMUDFsc3ArWGtLb2ZQSXpL?=
 =?utf-8?B?bXBwcnRkVmNlV2YxcFY5cTdPb0owRHY1QXAvcjlQNGJiV1RiOWZJZDdhcWVN?=
 =?utf-8?B?WkdVN0Y1TkxRTUNVSG5yd09uY2o5UFIwSk1vSHo4TG5FbFZOR2g2Z2ltQXZH?=
 =?utf-8?B?aUMwTnIrZlFFQ3REbVR2TUMzb0I3WURQaiszUUoxcytFOWNGZkh2Y2g2aklD?=
 =?utf-8?B?N3JkK3o2VjFhMlZoZXRKREhhcTRqYWtrS1BlSC9hU1VqcDBPMUVwZjRIMW1Z?=
 =?utf-8?B?a250VXZsbXJUZVY0TXN6RTBVZXlxdXplRklROTMyTEMwNXlveHRNWEdqcGIx?=
 =?utf-8?B?ejl5UE1FM0cyVzRnZjhlaFMxUnJPRXV4Yk5Kc01hd2E0SXp4T0JmRnVVSENq?=
 =?utf-8?B?bS9ZcVk4T1JlNjh3QnFqZ2M1eCtTY3RVYjFPV3dJNHhjU25VYVRvU0VXTkU5?=
 =?utf-8?B?QkpFeXVUNWVIN05Za0lkSFhKbVZCWHlKcHREcEtYOEtmRGx5eXU3d05zMVRh?=
 =?utf-8?B?T1ZaZ1plWElua1ZRM3lGQXdWK2YzSnptT0RqWjFUT3V5ekwvNWQvQk56RWQ3?=
 =?utf-8?B?N2YvV3BqakZlT2NIaDdSV3ZUZVduWlRQUWZxSnVKcWRkUkhWVnRCbnlEVEtt?=
 =?utf-8?B?UjNCTThOK2M5Q0hFMXBQdlgzY0kzNzgvSGsxMmFsaG5NMXpCR0txdHdHY2Ft?=
 =?utf-8?B?UGJaNEhMM2Fmd3M5U3JlUkpkU0tnQVowaVZmc0ltYmFpZDNLMnl3U0U0SDly?=
 =?utf-8?B?RG43UHFtbzJYSFd2VzNmRzVnSHNYc3U5bEVheXZkcmxZSE5Tbmtoc01MeUZR?=
 =?utf-8?B?Rm9zQ1ZOUHZKeWt2R25tdngydlJaNENseFArSG1BMW40bXZqSjdyL3d5QnRu?=
 =?utf-8?Q?3MgXtNStcaqkA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7042d9-5e74-439b-4392-08de79d6b89f
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:13:49.7101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7122
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


On 3/4/2026 12:09 PM, Jay Chang wrote:
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/riscv/riscv-iommu-bits.h | 1 +
>   hw/riscv/riscv-iommu.c      | 4 ++++
>   2 files changed, 5 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 47fe01bee5..a938fd3eb4 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -189,6 +189,7 @@ enum riscv_iommu_ddtp_modes {
>   #define RISCV_IOMMU_REG_IPSR            0x0054
>   #define RISCV_IOMMU_IPSR_CIP            BIT(0)
>   #define RISCV_IOMMU_IPSR_FIP            BIT(1)
> +#define RISCV_IOMMU_IPSR_PMIP           BIT(2)
>   #define RISCV_IOMMU_IPSR_PIP            BIT(3)
>   
>   enum {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 98345b1280..610cdebac2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2153,6 +2153,10 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
>           ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
>       }
>   
> +    if (!(data & RISCV_IOMMU_IPSR_PMIP)) {
> +        ipsr_clr |= RISCV_IOMMU_IPSR_PMIP;
> +    }
> +
According to the following description of 'pmip' in the specification:
"The performance-monitoring-interrupt-pending is set to 1 when OF bit 
iniohpmcycles or in any of the iohpmctr1-31 registers transitions
from 0 to 1."

Would it be better to handle like the following ?

     if (data & RISCV_IOMMU_IPSR_PMIP) {
         ipsr_set ...
     } else {
          ipsr_clr ...
     }

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>       if (data & RISCV_IOMMU_IPSR_PIP) {
>           pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
>   


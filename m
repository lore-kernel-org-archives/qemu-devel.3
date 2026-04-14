Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7FF531F1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 06:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCXdS-0003TZ-1Q; Tue, 14 Apr 2026 02:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wCXdK-0003Sg-6O; Tue, 14 Apr 2026 02:52:26 -0400
Received: from mail-koreacentralazolkn19013083.outbound.protection.outlook.com
 ([52.103.74.83] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wCXdE-0004OQ-Qv; Tue, 14 Apr 2026 02:52:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wx7BWcZY0Xk89ufTn+93zb+kHvcvHXlHMspa+e5qog/2mbkwEcqY7UXeeGTL4MmSR80Y+0Uo3lGyTUoQpSG+CbqBaDMO0S/z3FtXRze3srrf5HICGWTPChQKrd8q6n8tEEnIE5LPVsrqu+7QKT795I0ExSPE/wMuvUwJNQntwOjUPWDn9YtJTB4zkP7I7pHL8mZCelByVUSveXJriTAMm2+IJxHieq9V4ZIKvZbW01ngaLI5W+mSig0Xut+yuCtRA2igfLpCKTMwaM4jEi+PDP/JmRRvvIeYct47YOB0UPjeX6dYwsNKCf3shbQcbN+xaXXJjN9cifQiclOp2aVwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra/h0wnN4Po0UD0mIvxTNWei997HFe4f1+6U04kPS8w=;
 b=r2NSM9B49tqE33O0RQuwGB5DL3umfE3N6ysuSIHBn5tQW70zrhFU63vFGZjRhHKQsW8JLP1BSIqGFTmsJnEK6F693letjggrixkCRScelayLLntW9i31rE7NMkkj/tjcmihYGFXfs3EV1ziG7HMx0Ix7gs96TFWp1//eDuEtDg8cemVHoFVGiD252E/K4boKW+I7xt7Rb9CErcURSudlJjyC/JdbtiRa8r0TVhboSELmagmF1bIzv0hn/ZwCXkzC8gZxJo77VTafVa7pvag6FhQe7jFH6t7zH3FdE/qYNJngZur/r4f52i9jXgLuDCL3k0oEzl7dJezP/MlbSlNi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra/h0wnN4Po0UD0mIvxTNWei997HFe4f1+6U04kPS8w=;
 b=jtf5p5gvxxFd8j3e4EugFkWNjwv/701BJSyFFJ4EArPOLEOHzbH5MynksgITAOxvUxzmN04T0H3ju5S0iztlLnZpCnCI+QunS1jsUhJDxhffrOxxNK8/cqcCxSmgqUBUC3z7/r0g34cQTz1J7hDL34MFOsKaLuHoyMtL/1btAXY9kzD326VGKgMtFAohLI0uq5d8/qpwZ1+NwTuQCu4ZGXXPM0U9M1tDi9eT21b6wKfzwj2NKTtn4y4Gj5dqHs/SRAoYSl2+jV5018c2W1EtCmRDYUQW2trLFwac6UbkCzov5f5Eh9TmBjtdU5PmdOTMUFdYgC/9RgjHrdP0n2QkVg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEYPR04MB5881.apcprd04.prod.outlook.com (2603:1096:101:80::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 06:47:10 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 06:47:10 +0000
Message-ID: <SE3PR04MB8922C7A27B6E05B8D45F6422F3252@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 14 Apr 2026 14:47:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
 <20260402125234.1371897-6-max.chou@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260402125234.1371897-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <4fb14285-18eb-4f6f-befb-23ec13e4a64c@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEYPR04MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 591059e2-cb1f-433c-25e5-08de99f1a64a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|23021999003|8060799015|5072599009|15080799012|6090799003|51005399006|461199028|3412199025|440099028|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzdPTURTQUM0WDErNWdwMlNTMEJKclYwWmp0REtxeXQ2ZzkwUVBrdWVJQk1r?=
 =?utf-8?B?MHVlRnovYTRaa0pXQXJIRDBUT1FpTHYvNFk0b1lORGFUdkxJVWlCblNRY0x0?=
 =?utf-8?B?OHJzY3ZkN0dzdFpRUEowcG4zRXVsUzF4ZC9Gc3dmMmZzd09HS0ozbGwyWWxY?=
 =?utf-8?B?UTZCWnUwaFFwYzJvVVFGSmtWcGo0OXQ2VnJ4OWh2S2ZOeDFVMUZnekRXbHZU?=
 =?utf-8?B?U2haTnQwdDIzSGFYcUxIWGYxSzRpTEdkWTZYUGZMN0pyaTVIZ1BIUVlYVFBw?=
 =?utf-8?B?MXB4ZmZ6RzFNZGN0clZyMDc3V0lhZ2dWNTZ3SjFJcnpUejNmOFliOGZWR2U4?=
 =?utf-8?B?NWJVUWZXQmRFb3A5dVd0WHNJaUljakg5TEo0c1FXa2FhY2t1NUpSTmJEamJz?=
 =?utf-8?B?aEU3Zk9ib1hUS29MU3l3VHc4ekRYTjF1NVNBckk0SDEyOGpiKzlZcnBhcXBk?=
 =?utf-8?B?YTh4T3JMSnhhODhERlNvWTZjWE8vandDeExKdk0xRWNrMGRqT1lDOFNwbW9s?=
 =?utf-8?B?LytqTUhiWjVSdnhPMXVGYm51WlJqMVFhME1JaXZUYTRRSCtvWXh2YUNYcGxx?=
 =?utf-8?B?dnZLSWFUSnZlRllzNHE5cll0WjZ6MU1YMGNJMXhiVmdTTGF6YlRYVnVld0I5?=
 =?utf-8?B?QXNXT1hxL1VWVzVNSUk0eUlSSUhvM1lnWWMxUDlLdy9wMUZDUkR3bEljSTh4?=
 =?utf-8?B?Z2JNY3I1MmlQT2QzSTFCYlFEOUNzeUtMWmcyaDBvRGNXV3lqY2c2WW9Qc3pa?=
 =?utf-8?B?OFAzSkZidEp0eEFhb3ZERCtuSkFDdUVBNm9FVmFXcXRhekw1Y0FXTHdDL1F2?=
 =?utf-8?B?MDZkWFNldlpzRWR3aEZXazRzVkMrUUVzOFhJdUFzbHdBZEpKSFNCUDlJNDRX?=
 =?utf-8?B?R1VURnFXT2s5R0hoeHNXWXBhbXZENk16aC8zY2V2M2pzSFlESDFXa2tYTGVp?=
 =?utf-8?B?MDErMmxQalIxUEJ0YStpMGUwOElGYWdRV3BKNFVjaDRUVVFkRTRGL251eE5Q?=
 =?utf-8?B?ejdyYUl5ZzBCOVZTVHhwMm5vSGMrbFlEUlhBa3BEdy8vUHI5azBQZVBpVk9S?=
 =?utf-8?B?cnBVS1g2a3BnTE0wamdTcktka0MxMEU0RVMvVW5jcHRITm5sOGlBYzFQNTJj?=
 =?utf-8?B?Q3pqSTFQV29IaUdoUStXeWxJdlgvOXB2cVlOUEFUVTVkcUJheTZ1eElPTGV6?=
 =?utf-8?B?ZEduY0RZNndlZDZBcGdmUnloNWYxZmUrVTBIWFc5eHczQ2hNU1RCbW83akVs?=
 =?utf-8?B?bHlJcTBQUVhETGp2K1N3YnFQaE1KR1ZsL25uVHhVMk9EdG9ZZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHN5Y0NsdU4zSmxuNmNobThsdWVsS0dmUWxJaERXZ0dtbEowZ0R6Q2lpQi8z?=
 =?utf-8?B?RVEwaUxXWGYzNzFYQkU1UVZuM3VYWkkxdXRLMFdRTEdIR2Y2eSs3Nld2eDF4?=
 =?utf-8?B?ZlVPb0UweGpuVnFDRmhwMUxqTU5oQkw2S2ZYdTFpaitGbWFpUXgxdjJpcHFz?=
 =?utf-8?B?ZFJNV3oxUGxsakVrckhGSnp2T003R2taaVhKMjVpdkdqUWJTcW1DbGVyRDdl?=
 =?utf-8?B?VHpOdTFJTHBBQVlRZUlYVlowYkFsdmgxZDR3ZzNUQXorcllzUGM0NHdycDM4?=
 =?utf-8?B?TWE4ampDRktGNjVFUmZQOHN4SG5lVzZDSW0vRHJIOGZCcTBkeS94b09NT1FU?=
 =?utf-8?B?MUhkQ0hKOTFjZ2xxdEx6bkVIWGxBd1g4RHVzOU0wVWxtalkvdHAzaDFQSkF1?=
 =?utf-8?B?OTA1QStGdEt0ak81TkN4Z1drc3cwMjVUUE5PVXM5ZlhZUm5Hd3BWY3BqcFFD?=
 =?utf-8?B?Q2d4UW5tN0tNY1JhWkdBQjNNUy9KSllIbGR1SEhGZlF6NlhuUVV5bXpYNGVE?=
 =?utf-8?B?MWpvUE1WMitNMUdMVWE2QzJDN3p0MGxqdlJEdFRIMHVJdDhGcjJreFRHRENo?=
 =?utf-8?B?VVdjbEM1VDFzbnZXKzRxdDY3OUZaRHRGRGdISlFFZjNlTi9URDJOa0luVDZm?=
 =?utf-8?B?NHlKUWVOMkJkNmxXcldPdFFLeTRaQjlkeHMzTnZrRXAreU41ekRIZEtNZEFz?=
 =?utf-8?B?eG5WK0dEV2RKaWdKZ3Z6eGJLSHR6QmFvQzlYalBlc2VzQzZlZmoyUndlNmpT?=
 =?utf-8?B?Yk1tT2IvdDk0b3VCZitkQmc3WFloc1kvT2NvalFrQ1d4aHpJTFg1akluQmwv?=
 =?utf-8?B?cHozVVRzaWZiSTlPd0RRdVBOZUMvdkFIUWZKNWg5UzVQcEVXMnY0MUd2c2FI?=
 =?utf-8?B?Nkd3ZDI2OVBKVFJTQVFnY3ltSkt5RGNOak9CQUMzZUJ3NEhTbW1EaEcyYjha?=
 =?utf-8?B?N2k4WVhqTy9ZWVREeVo2VEc2RGJJZ2k4aGNsdE9uQWRBY0QxUG9aeTZvNUlH?=
 =?utf-8?B?VXVvZkJwOFd1YlJ3V2xGNzVFR21RRWg1RFMrOXNVRVZlYTJoWXhVYjkxaVVV?=
 =?utf-8?B?YS85SWpCRFE4OXFJQWd2eXBvVmFnNzVUSHQ3bEVpM25hZVFFTVBaWW1QTTdk?=
 =?utf-8?B?UEJUWVRjWDdXL08zZTdIbG1xUFREVU40SUZ2RlRZem1TOGs4a3RYc2FHQy91?=
 =?utf-8?B?NzRoTVRPMlBzSHVaMHd6SGROc2RJTjRGYVFCN2tuRnVMVUxraEc3VTRhZ3lO?=
 =?utf-8?B?UWtwWE1nbllpcmU2OVhHVEI0a0c4cWI5d3E4TkY5SjZaVEZGbS9jVVFPcG93?=
 =?utf-8?B?SEkvTGU1SDNSTFArNlU3Wlluamh1ZGEwVUEvcCtybnFLTkczVmJMTzZOa1BC?=
 =?utf-8?B?bGN5QTQxZEptK1FJekhiZFZHbncxeW4ydEM3aVluU3N0cnlWOTlFYzRndUtU?=
 =?utf-8?B?UkRpRWo2dVBvVXlGRm9ONWNrSmxCWkhMSWVZZGhZMFdudm56MDJIWnBSUE1C?=
 =?utf-8?B?eHVzMkFURTNNTnlhZGdhMlI3d0JBK2pyeUM2MWh6VFZVRkp3VFJsa0p5QnFp?=
 =?utf-8?B?K3FCSWUrVVpIR0ZNVDVVNUdsWnNzam52S2tmQXQwRnRRRE02S0JIeHlPYzkx?=
 =?utf-8?B?V3p5VU5KeW1TZm53WExTZXJsTDdWbitxYTJyYldRT09pTmNsU01WY1E3VXFY?=
 =?utf-8?B?RHBiZFpQalVKRkVaSWxRcy8zcE4veUIxN3UwNnluZmRwRkhJQW5YcmFKdGVu?=
 =?utf-8?B?Qk9rd3NLR0M1Vk4wRW1uUUFYbjNUbElBM1IyYWdvMHFuWjZsV0RXbFdZemNq?=
 =?utf-8?B?UTFiUzNtUGJOV1AvRmtyOVl0bEdzZmx0blFxQ3JtZ1ptbThnb0JxQnVoOXh1?=
 =?utf-8?Q?wmhqBdvR4TLxv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 591059e2-cb1f-433c-25e5-08de99f1a64a
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 06:47:09.7736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5881
Received-SPF: pass client-ip=52.103.74.83; envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 4/2/2026 8:52 PM, Max Chou wrote:
> We have more than 32-bits worth of state per TB, so use the
> tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty


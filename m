Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F4BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYHSF-0002Wv-4n; Sat, 13 Jun 2026 02:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wYHSC-0002W3-P1; Sat, 13 Jun 2026 02:02:48 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wYHSA-0004qc-AH; Sat, 13 Jun 2026 02:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV/4a56Mb/egZS4pJlV8P8h5O6DAQqC+y/Aqvann/fPzSJwChsnzkhBoLvqLN8xlvNUKc4cjr2vA/CjMqacxfP9VJ26GFFHQSBQQd1thIqxlFXAM/URGyIP0VTtcYltHi9ZLjuYiIU6VbBJGBsxQsPhZcbreOwxZ26Gt3oZ5pCvbq9RrQxDyYMScbInbBdm28ysOgZw8619/M/lAWcYN1UadUTTvRQMFdtKGXuYvI1B4XHmoMPXtgJf8rXwLWCzbA9bVdGo735E+ZyU3fTNIV3MxFosMQvyJeFUdyrb83HIWFYhysvCu68lsEftfW3Y6hzdbPMXoF2pO/UXj/dOk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXoEdTb3jh60VLUTpITDBuX26RRLPavsdA7WTnS47Ec=;
 b=Up6272eRAKScejL2mpjT8TKvCchCtU0uN8kPqc9bU2MGIwO4RmZ4W2jrhe52zt5tlC9EHt6Xs4Avlv43KV5lmthEbZ+zJalHoKHnrSBc2hAfmMQ46vtRs1M4je6U3ldrWjx4zsQcepvANwBUYHKZmyUPp5V0JRLcAwjZVii+9ac5qMd2upd4k1VNeBKLhAkAMmiGd2xv4jWaAIm5k/essHSCP8GH7FDwSz6ancp3hBcx8PL6f/Mcn8qoJxVaUw7qLAw7T/MukeGAc5GYUX3uqn2fei9E7huybPkCtz7iXZOep4Q7iPDo0bHCK0QsLyHU21N78P6i5psXDgyDIxckvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXoEdTb3jh60VLUTpITDBuX26RRLPavsdA7WTnS47Ec=;
 b=CtXoNN80+P6zPCYg0VGX3Kw0gzR3JSLm1z/M5s1TXMuLktK328kddGyW2BiEVwze4d2mhluwZv85Y2+F3CxK38fZGPj8TlU+m16BBbcBppfoIq6upraCjCJ+2OzMYo4m5sIo1pHp6fcFBkTmlFuQ54zwo4vhPfQiHsMTvSIXY0eAdAtY3KmhsGCQMj1bCXvcTiVx4ZtoaG+/slqRgZbnbGeD30OaSOtcT6Zsxgs4FVuKTb+DPaqPWJDwfx2kC4+vBwkrrGIAwmdk8EmWCsbSwXRR7rwpM9quVyY5g30Xv1fJhV1UFR8DLwgKaWBzSQZJeIgU7qFennpVobrKbUAvcw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSNPR04MB9742.apcprd04.prod.outlook.com (2603:1096:604:484::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 06:02:40 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 06:02:40 +0000
Message-ID: <SE3PR04MB8922CDBD04EC47A6B3B1DD1BF3192@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Sat, 13 Jun 2026 14:02:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] tests/qtest: add test for K230 watchdog
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
 Mig Yang <temashking@foxmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <cover.1781246408.git.chao.liu@processmission.com>
 <791beb1d8db07e4d1011cbeb4a8ac3add5b24f09.1781246408.git.chao.liu@processmission.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <791beb1d8db07e4d1011cbeb4a8ac3add5b24f09.1781246408.git.chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <c6456089-e90d-4348-a7df-a08b4e8ac3b1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSNPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: b2646dcd-97c7-416c-4aa9-08dec9116011
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19101099003|41001999006|19110799012|12121999013|6090799003|15080799012|5072599009|8060799015|51005399006|10035399007|3412199025|4302099013|440099028|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDJoZEwvQU5TZHN5aTdSOVoxU215UWRLaTFRYnhLNld1NEpPbHpLWC91bkxi?=
 =?utf-8?B?b005eEF1U1BsUExQeXhqZ01pVkpxa1Y1c240YVdCQmNRM1AxZHJybEMzbXdX?=
 =?utf-8?B?RmcwdWMybUJEUkVCUUNmRkkvUGNBYWRuaGRkTW9EWGpGNXVDN2lBSWJGZFFs?=
 =?utf-8?B?M1dNa1FaM3JOMDNkb0tuUkg4K3pBdWxRWHlhY3RsdGRPeXlkUHlTOE5CZlJx?=
 =?utf-8?B?MzhTM3RPSGZIajVDc3NGb2VPTmlwZ0ZOYk1xVFFVWDNaaGlJRmpuTVYrQTVh?=
 =?utf-8?B?N25TZXhqWS9ERDNyMVFaVWx4dG1DZ0duMURKZzh6VDErOGlVb1ZwdmlQK2g1?=
 =?utf-8?B?ekppVnltL3ZOK29xSzR1MnZKY1IrS1VLT0R4a1luR0RFM0I1Ymt6cXZTV0Yw?=
 =?utf-8?B?TlNSbVZHY2hmQ2oycFJzTVVDaGR3VE9GMFJQUjBTZlUrb1FkL0hpbk9KY3Fq?=
 =?utf-8?B?OTNLcTlHVkpYQy9ISjBRL2lDVHcreDUrTjY4RjBXSzRrODM5VWIzSDZmMXhV?=
 =?utf-8?B?WjFPcDh6V2dTNVJLTjBidW9yZUF5WUxHTjlQYXhRVnhKakdteEZtcExobXJj?=
 =?utf-8?B?aVdCU3dXRFlZejl1Z25JUzYzS1VlYjFnblNMOGF6b28yUHZTd3E2Um12cWhW?=
 =?utf-8?B?cW5JbVFxMjloRHQ2Ty9HTW1GWng1cm1zalM2SWVFcWtGVklFSDg1ZzhKbWFi?=
 =?utf-8?B?ZHFFYWR0WFArcms1c2hMS2VMSSswYXdPV1dJbHlhRm51cjdPT1dNT29Icy9J?=
 =?utf-8?B?ckE2dXM5OEVLTGt6dDZNRDJuVjQzcTVmNHgrdWg3MHNOV2pjOHpwa1BrUTND?=
 =?utf-8?B?ZkZackV3ekFKSnhMQkNCSkI1WE1tTFE0dHJwMGFqRWtBemVCL0ZNeGV5NzRX?=
 =?utf-8?B?N1ZJMGdHa1RxN2hLRjhURzA0RWpnYVYxbGNxMWJDd0R5VW1acWhyU2Rmdldt?=
 =?utf-8?B?QXdraCtPRW95K3g0dEVYZ3UyVExHVmNocndKQmR0VHBHY0RwT3N5aWgzcWRV?=
 =?utf-8?B?bTFMZWx1dnZFdTduM3JneHpsckJuR3AzclZKYzMvUkJwZmsxQ0t5eUFrckkz?=
 =?utf-8?B?TXp4TVVIYkZzQ21pZVFvQ2t6eU4vWUFBR3pUdGd3Kzlsa2VXblNxb2ZHU00y?=
 =?utf-8?B?UGM2WmRmUitYMGYyQkdjaUxqODJaK0QvSWxNM0xWeWRQeGhtcGFlN2s3VWFz?=
 =?utf-8?B?ZVB1TzZaaGJjS2RDc0YwdzdDRTNPNVFtbThLWkowaEpVVnVXOHltNk1ZZFdL?=
 =?utf-8?B?R0RxTFFjSGhZWEJ3YVJtNndhM2crK0dEWFVYRjI2b1VycndPQ0ErRERxaGNa?=
 =?utf-8?B?VHRTNXZxd0VXRkFYTldodzJZd0tXUWI1OWJJQnlvWVl6RmZSQkx2bXhjYk9O?=
 =?utf-8?B?RXUrN0thT21NQzhNbDNFdE11UStzSWVGaDVXUS9UVm5XMFZhM0FBZXFMckw2?=
 =?utf-8?Q?+nA853ZO?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG8zSk0xUUt2RXJXZVhjMUZiVlZsS3U0Y0FmdWU2dlQ1Z2kzQ2V2MTM2TGlS?=
 =?utf-8?B?MlZwYXZBdzhzVnlFcE1mWWowKytRckRIVnFGY29LMTlFcGxlOWRlZTVSdk4w?=
 =?utf-8?B?cVhiTjhweWpWRkVJWVBCcXdJMzZIME9TUVo5VUh5WU8vYnpIZ0VqTjNvMEo4?=
 =?utf-8?B?V0dRTXh3aUI5Wmk0VDlZbi91OE5tellsb2VDK2JWdFEvdXhWMmtXQk1DV1Ja?=
 =?utf-8?B?WHpmSUJGVVpPQ0g1d1RkRk5vK09mcWQ0QThaQU9ESmI4WXdqYVlYdHk0OC9E?=
 =?utf-8?B?Uk81S3V4cmRpbVRuMkIrUWF0bUJhRTlpMDNPM0g1Vng2ME0vVVIzcjRRRzhQ?=
 =?utf-8?B?ZWJMalUrRVRBVDkwRlNRWk9YU0tVSjNBcTBiaGNIR0pxV1d4U2FDcVVjMDZS?=
 =?utf-8?B?bnRoR3R4SWN1d1RFTkZxa0ZyaHhmQUhGUHI0akM1d3NmWUVzNmxyV05lRTZP?=
 =?utf-8?B?VU52WmVIcDhEOFFzUW5UZUpQaDg1YXZUZ2RPVi9MSkJYOUpsU1JLUlFaNjlv?=
 =?utf-8?B?dVowa0dEU3hIeVdiWlNXWHRZbk1KaGd1c2tIQVkvTEx4Nkg1dzFYYWwxRHJa?=
 =?utf-8?B?TXREd294YUZWWS85b05NUElJRFN6OVNvcmRmM3lKZFlKWVFha3dKdzd4Mklr?=
 =?utf-8?B?ZVUvV0hxRXVwRGsyeWg0TmdHYllJeTBoSjFZNnFTaHE4TE1VZW1zeFNPTytu?=
 =?utf-8?B?a2RnajZZazFlaFZ5Mlp4YzB2Y3h2amFmTUt1M21QRnIzemVxMkNQM2ZiSHBw?=
 =?utf-8?B?TDRjSGZLNzZ0cGRzeGt4ank1SnhlcE5uSG9UZTdqYlRjRVRxRDc5MDFZTk9R?=
 =?utf-8?B?cXNHaDNjL2dnOUxUNXNRUkN6S296K1Y1TDlqM0ovUUk2R2hXSGxKZVp0OGhP?=
 =?utf-8?B?dExaTVlNS1dFNXNKNlZWdEZXRC9DbWVBUnQwcjBLazkraXJ5ZmRrYUx5R2xv?=
 =?utf-8?B?QWVzNEdRSVF4Q1Q3UmdKSkRTODdoY3ppeUo3YzlRS041S3huTHQrTkM5NkZD?=
 =?utf-8?B?RnZEWXhQcmtSWFZkL05yVVVIUjJiNkx3V2hTSHFxbk9ibVFuVEtrRUhRS1lp?=
 =?utf-8?B?RGJJOHFMRXBRbzRJc3poMlhhWXMyb3ZGSElpamhpTmRhL2hBcTNwUnlVUnZW?=
 =?utf-8?B?VVBYRU5ERU91ZHB1c294c3hBVUFqWSt4aVowaGJZRWhwYVlGOGxsVFJiM0o5?=
 =?utf-8?B?bkR0UmhTd0JoSW9LNXpua0drVFh6U2RaR0lWQ3oxcjY3ZC9sYWxILzR5WFMr?=
 =?utf-8?B?WlhydU9xekpkMU1oZHVTa25jWGoxTnpySmpNWXhwalBGNTBzMUkrMEJFZ2pT?=
 =?utf-8?B?UXBFblN2NWxMVUROMy8vdkw5M090M2VQakZKL1ZKeXIxVUtZK3FldzJRQmxr?=
 =?utf-8?B?ZE5wZS9PdUoxOUtyb2FZUWw5WUlGS243TFMzT0FHMVhRcFc3R2ZWTUJ3Nmtk?=
 =?utf-8?B?d2tmM1l5dzVnaXJSSC9mNS9VNzN0SzdhdkZhTGZrT2VNOEo1aWdRbmdXZFlr?=
 =?utf-8?B?NEgvS0RYdEg2YjJ6MWtsdXVNaDRGdDQvWkJ2QzF0UkEwK2t5SGt4T0tGQ0Vx?=
 =?utf-8?B?Wjc1RElldnVtc1ljUnJMelNqV3pOSHJqRmNBK1EvNGxjRDM4WVhCZTY1UmZY?=
 =?utf-8?B?bFA0ZG10dzhHeEFkS1JvdHppSW94STc3NVFDdjR3QWlnRzFHcVBzU1hvVWV5?=
 =?utf-8?B?aGlQTTltaTJNckI0d2w2TG1SVXJZTnZjUUdWKytlbnVaUkJMQW56K1pmT2RQ?=
 =?utf-8?B?QUZNc2dOT2FXbER0S1FPS0h3K3loYXI5R0N4akQ1ZXFUV0VXbWFiSGNNK3F1?=
 =?utf-8?B?UjdGWm5tRDNBZVlqRkl0V3JGRmFvM1RuTUJEZW9FWlJrQWtZYnJXK25uelll?=
 =?utf-8?Q?SN52oow2V3CP9?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2646dcd-97c7-416c-4aa9-08dec9116011
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 06:02:39.9733 (UTC)
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
> Testing the Basic Functions of K230 WDT:
> 1. Reset Function
> 2. Timeout Check
> 3. Interrupt Function
>
> Signed-off-by: Mig Yang <temashking@foxmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   MAINTAINERS                 |   1 +
>   tests/qtest/k230-wdt-test.c | 189 ++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build     |   3 +-
>   3 files changed, 192 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/k230-wdt-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06db33a107..44654b5798 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1794,6 +1794,7 @@ F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
> +F: tests/qtest/k230-wdt-test.c
>   
>   RX Machines
>   -----------
> diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
> new file mode 100644
> index 0000000000..c8eaeaf1ae
> --- /dev/null
> +++ b/tests/qtest/k230-wdt-test.c
> @@ -0,0 +1,189 @@
> +/*
> + * QTest testcase for K230 Watchdog
> + *
> + * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the kendryte K230 SDK
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "qemu/bitops.h"
> +#include "libqtest.h"
> +#include "hw/watchdog/k230_wdt.h"
> +
> +/* K230 WDT0 base address */
> +#define K230_WDT0_BASE 0x91106000
> +#define K230_WDT1_BASE 0x91106800
> +
> +/* Test WDT0 by default */
> +#define WDT_BASE K230_WDT0_BASE
> +
> +static void test_register_read_write(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Test Control Register (CR) read/write */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_CR), ==,
> +                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
> +                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> +
> +    /* Test Timeout Range Register (TORR) read/write */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_TORR), ==,
> +                    K230_WDT_TORR_TOP_MASK);
> +
> +    /* Test Protection Level Register read/write */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_PROT_LEVEL, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_PROT_LEVEL), ==, 0x7);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_counter_restart(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Enable watchdog and set timeout */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x5); /* TOP = 5 */
> +
> +    /* Read current counter value */
> +    uint32_t initial_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> +    g_assert_cmpuint(initial_count, >, 0);
> +
> +    /* Restart counter with magic value */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CRR, K230_WDT_CRR_RESTART);
> +
> +    /* Wait for time */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
> +
> +    /* Counter should be reset to timeout value */
> +    uint32_t new_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> +    g_assert_cmpuint(new_count, >, 0);
> +    g_assert_cmpuint(new_count, !=, initial_count);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_interrupt_mode(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
> +
> +    /* Set interrupt mode and enable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR,
> +                 K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
> +
> +    /* Wait for timeout to trigger interrupt */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);
> +
> +    /* Check interrupt status */
> +    uint32_t stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
> +    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, K230_WDT_STAT_INT);
> +
> +    /* Clear interrupt */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_EOI, 0x1);
> +    stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
> +    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_reset_mode(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230 -no-reboot");
> +
> +    /* Set reset mode and enable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
> +
> +    /* Wait for timeout to trigger reset */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
> +
> +    /* In reset mode, the system should reset */
> +    /* This test verifies that reset mode is properly configured */
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_timeout_calculation(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Test different timeout values */
> +    for (uint32_t top = 0; top <= 15; top++) {
> +        qtest_writel(qts, WDT_BASE + K230_WDT_TORR, top);
> +        qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +
> +        /* Read current counter value */
> +        uint32_t count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> +        g_assert_cmpuint(count, >, 0);
> +
> +        /* Disable watchdog for next iteration */
> +        qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_wdt1_registers(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Test WDT1 registers (second watchdog) */
> +    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_CR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_CR), ==,
> +                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
> +                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> +
> +    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_TORR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_TORR), ==,
> +                    K230_WDT_TORR_TOP_MASK);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_enable_disable(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Initially disabled */
> +    uint32_t cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
> +
> +    /* Enable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, K230_WDT_CR_WDT_EN);
> +
> +    /* Disable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
> +    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-wdt/register_read_write", test_register_read_write);
> +    qtest_add_func("/k230-wdt/counter_restart", test_counter_restart);
> +    qtest_add_func("/k230-wdt/interrupt_mode", test_interrupt_mode);
> +    qtest_add_func("/k230-wdt/reset_mode", test_reset_mode);
> +    qtest_add_func("/k230-wdt/timeout_calculation", test_timeout_calculation);
> +    qtest_add_func("/k230-wdt/wdt1_registers", test_wdt1_registers);
> +    qtest_add_func("/k230-wdt/enable_disable", test_enable_disable);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 45ea497fa5..37ca38f9e7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -291,7 +291,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
> -   ['iommu-riscv-test'] : [])
> +   ['iommu-riscv-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
>   
>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CF1C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6i9-0006Ex-Dt; Tue, 21 Jul 2026 05:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wm6i7-0006EA-KW; Tue, 21 Jul 2026 05:24:23 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wm6i5-0001h9-VI; Tue, 21 Jul 2026 05:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKw+GvryZ1RMltAWFcmlV5TK6Xk6YxpKMKZlYMlGTn8OltlI9qev/j173Drjhwp4l8kbDgVWkJ6BeqtcWvgQsuM/mInrXmaVtU11+F7YIXjlHi2X5/VQXi+sCQAupgw3rrwO6cEX936Fv/9HitmkUVp7m32wLLJ/GT51lLIcSXDEDsgLckUeo0IEj3h97n1jMbxlkSp8Ud7ZQanXG7F4qKbv9jth6tpwqLlF2SQrzKGE3klvJNy4CqHOutzKAlr4PHVO7c3Oj5FCJSegKxPSTShewVDBITz5+TtctPgm6aPewc+RVezboXrALy18mg9zf0S7qzpX0//whYpU9Q4XQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIDpaqZKFMDwcaLe7vxZo+kTDfMP6/EVxGXZs/6eaVw=;
 b=wUBZrnHBNPOoOCC9FsT/cc0mhJqOdTVWDMQj9EW9VS8LUqsCeJgKXNZqDXzspRZfyYMWdJ3FWcfYmqhLYw4n9hv2mfei2I5a8BFKbSxn1q55EE1upONXpe+ksgLLhK1FSCP0c9QQfApnd63wsptAGRPIqTVyRsyEKhN4tQoszk1ADcL3IK9sr13TKp9w4udn4pb/Ufn0Sbi8fsy6XuRvEbxMgnvmdP3IIH7O/XlQ9tsirQXgX7cDsAKy4616HRiUnVD3Faqtj3vttaFIP8VVMXrEoltHoa3Ktn7b/74uXKbtTVy4Sfpmx7aYBlGy858ptVB6CHF3bpSEFLQrlIv5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIDpaqZKFMDwcaLe7vxZo+kTDfMP6/EVxGXZs/6eaVw=;
 b=HGm9iG2ys/PLW6gZ05sPLRkBExjdwKk1d++wMrvUW1C2/PB8PzO8vuDiQgTCscw1JH95qJNykTaddBKZg8tBoUoI5IOGAEmWvJrWSUVbny0mAwkzL3Zi3tHxz+ZltLVH2K2enEe25MlEVL41Sx+Xzs18pYfAX+DlIjOdYJyTD3Hu5zrdhLIE1SVSYu6pG9Oa0BjNn9A9HudJmpdNyCk1KbUs+0ABI7GyoKiFfzWVd/ehQVOyLq2v7rJxKGdOgnwfMPcBEj//0VBqLIMVYkH7EBkuUkM6//UmEzVscs4vEGU9Q4Nx7TpITU4TGt/7OHw36WSOBfG5y9ZtI+M0QfPv1w==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SETPR04MB9714.apcprd04.prod.outlook.com (2603:1096:101:317::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:24:16 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 09:24:16 +0000
Message-ID: <SE3PR04MB8922C6C73BB1982D8F66BC4FF3C22@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 21 Jul 2026 17:24:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix U-bit check to apply only to
 leaf S/VS-stage PTEs
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com
References: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <64218c7c-2039-4546-96cc-1ff344d04c10@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SETPR04MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9142d187-1101-4b27-35f5-08dee709d56f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|4140399003|25010399006|19110799012|8060799015|22091999003|5072599009|12121999013|19101099003|55001999006|24121999003|15080799012|6090799003|41001999006|440099028|3412199025|40105399003|52005399003|26121999007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlE4enRBNzJuZXRuYzZZQkNIVFRMY0hXSDcreGE4bTI0RnlTcHR3czZSVSs2?=
 =?utf-8?B?VTNpcVJmaEEybER4YkwzT3ZORHpwb0pIaUl6QVA4cGFxRTBnV1lHYitGUVcv?=
 =?utf-8?B?ZmVPYWFtQ2ZFVUo4NjdNcStRdWtsaFhuSXg1UVQ4MnN2blc4Uk9hbS9jRERK?=
 =?utf-8?B?N01qaEdONWhmbEgvK3ZOSVRJLzNMYW9VQlBBR0s2Q3drcmVvVVV5V3BYYTkz?=
 =?utf-8?B?bXcvNWs0RDdid3RkY1hoZDExWVRCZEZabjM4ai9TL3FheEhvQzBMZ0NmdGc1?=
 =?utf-8?B?ZDNCdUVpR05WMDNrMHB5L05EM090NERNWkZ5VkpiK0hiNHJHSGdSdGpzK2h4?=
 =?utf-8?B?L2R5QzNzdlJLbkJ6NDFTVlUzbHBzRy9rbUNkYjNnNERQNUF5RlRCTWVTYncw?=
 =?utf-8?B?YVZCS0xjTCtoUFJhbWdQTXhPYlI4OVprWEROR2lGOUpNbi96R01XNk5EaTJP?=
 =?utf-8?B?QVdxZjlIRUwvVGZUNkdQQldXTDFrWVNRTVhwY2lvcVpteUcrWXZMc1d0elpT?=
 =?utf-8?B?NjV4M0lwQXZwNXp4V1RWVDRqUmhRSkpPMGRtRndOR1FDd3gzOXhiYnV5SjlW?=
 =?utf-8?B?RnIxd1piSzVhdkEzVFA0emFuVEZraUJXYitUS2dveGxydTVoVFFvSjlrV01a?=
 =?utf-8?B?a1hpMXE0cU9scHZ2ODlGeUdzSTBXYUM0dmlTNU5XK3RnTFBoaUpiOC9kQ3lZ?=
 =?utf-8?B?eUFvM3l0L0h6MXlBWkJlSGN1MGZDM2xtdDVNcDJzekFpczFRUmxkVE9qd1JH?=
 =?utf-8?B?V0xRVTZMUCt0OEZzcFNVYzFkWCtPQ3ZRNDdsczYwSUkzcmNCelEwbGZyRnR6?=
 =?utf-8?B?OFZacmdHaTF0Uy8yTzNWM2JWWWFMSURma1ZGdHVYNCtXdDRhTCsvTWF2Q3Fn?=
 =?utf-8?B?SmNuaDNjZmhLNVFoM0hxc2dQT3VpWEtvZmd6ZUlzT2dxb1R0OFVjTGl3Vm5p?=
 =?utf-8?B?RUsxQWMwN2kwZ0Mwd1BhZUJNVUlUbGRoU2xMTzNaUHZPMWxnR1FRNUVFKzFO?=
 =?utf-8?B?cmloU0tGVXZOK0FWY1NLZnpTYTcvWjFLLzA4RTlRWjlMMmJlUlJLMU54RERy?=
 =?utf-8?B?UDQ4QnpSR0FVUnZIZVVaZ1EvR2pKY3RpcDY4RWNvNTAxTTRMTS9UdzlWMlRu?=
 =?utf-8?B?UDNFNWdib1dUanJCeHM2Ym5xcWhyU200ZXRpN0JRUFE5UFJVWGx5a1NnZFBS?=
 =?utf-8?B?UU82MFVqTHVJb1RzeUVjUDVyMDdYTnZ4S1QwRmozYXU2U1FMQWxHOENpWUd3?=
 =?utf-8?B?anV1ZndiQVRsdzFzUTF5RWthZDE2TTFKV2dxQ015RS9rT2MvT2s2UVQ0YWJE?=
 =?utf-8?B?NWM1Z0NwT2dSNWFmQUNhQzRsdWpHUXZ0TVM1ZG9vZHhoaC9WUmY1Qjd1WGRO?=
 =?utf-8?B?eVlRWU5JUHZ2VUFzSHhoVkxiMktZZFU4TEZFUjRTR3A2L3E2dmxtSTdDRHpG?=
 =?utf-8?B?MldHYkRpcFdQUXZ6U09lZWFnY3RGQkdLMGhlVVVBdVp0bVB6eGU3RURQVm9N?=
 =?utf-8?B?WWlxTG1sdHhqYlJ1a3NaeVFoZXZQVVUxN2NnUmxYR0hHVU1DTGtQODFoUGNq?=
 =?utf-8?B?eG5YZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBydndGUE44bjZBSFBiQWRlYy9LVmNXZ0ZGak9NSmtEV0hxRjZ1cVZrdkVF?=
 =?utf-8?B?ckhiWmFraGVuL3ZkS1p5bHBmZzdtcmNYd2I0UkFNVUhxV0hZYWVzdkxPUHhB?=
 =?utf-8?B?dUJOanJiQWltM0xIQmlpaFF2dWNpaWt6andBWXYyZndRWEk5M0VMd2VncjRm?=
 =?utf-8?B?M3FBQ1l3Mi9pOFRSYVh0Z0NuU3R5aUxsTHhiUDBINlRHOVlYMldGU05ZNEpD?=
 =?utf-8?B?dUVpOTIvUHk0WFhPTjloUWQzUGUzWUhPQ2FRbFZPUnFhczZxODFnaGpTVmg4?=
 =?utf-8?B?b0xVOEQrMk8vQm5jRzZKTE4zQ1RUa0RtTzViZnhERHVVdHRpRStUdllZa2Nu?=
 =?utf-8?B?UUl0MldsZFYwRmFHcThkd0ZSQ1prQ3R5Tm16Ykk1ZWJDdEZpR3pzbFZIMHpu?=
 =?utf-8?B?Q3RBWm9zU09UT21GMEZaekw5SktlM1RTdS80aFB6dW94U0ZKR250bGIxQWJr?=
 =?utf-8?B?Ky9xNjBvUW43VEYzaWswL20xSHFoNGZNQ2UzaGFrK3p6ZDJscVJXaFAzMURM?=
 =?utf-8?B?eUxZaEZwa2pOYkhJTmtDUVVEWGg2c3Rsc0NDUEJ0LzF3a0dFTHhnS1NzczZu?=
 =?utf-8?B?dHhoc0p5K215NUExbGtMMU03UTRpUnE5ZWxBMCtHWktRNzhKK3lrdzFZb2Y0?=
 =?utf-8?B?bFVzdXY5QjdzeU1uSmxOTHJMbWM5L3I3bGVyWW05UW53L21ZR3lxaWxUb3Zr?=
 =?utf-8?B?QW9zSTNqMkdNQUF5bmc2WEN4KzQ2dElQK3BFbms1SmxOZVBMVnl6b3JPMFdQ?=
 =?utf-8?B?a3YvUHgrZUNUbWw2bTNxVlUzaytXQlB0TXNlN09jVW9VSjk3WEZCODllYnhU?=
 =?utf-8?B?TnorZ0U5a08yeGp1dkM2QzU4ZVpMN05YNVhiMHNIQ1hrK2lRL01pTjk3SFBn?=
 =?utf-8?B?MlpwVmpySVFUSm80U1c5QmtFdlNnOUVGcGhzbFZDMy9HUG11T0lYeWhpOUVi?=
 =?utf-8?B?di9lVmFDQnNKcEQ4LzczckJEeC9hN1RrRW41YlFBZnpGNis2azlGV2ZuakFY?=
 =?utf-8?B?WmZyaldZVHJ1WkdHQ1pIN2oxVjVrVlJrdFhWN1RISXVwRmpEMWtDZi9MQmhs?=
 =?utf-8?B?dml5cWxpYU5ZZGorTE91MUp4UXNEUFRkSWMxNUJySnJvbThBcjBkQVZKYzlK?=
 =?utf-8?B?Qlhmc1RML1F2MmJITThKNjlnZzA1MUhLUi9EeE9LWDJXLzM3djFRblg0R2ZE?=
 =?utf-8?B?Um8yTlNqRW5rakVaNWJUbVIra0xjWE81NnlDVGJMV1hXTThreTNyeDlOOURO?=
 =?utf-8?B?YWk2R1ppVTd5N2pxSXI5dnVEMHJ2TDU4NDJwVEpRVGxOQVpXUGhzOTNIeU11?=
 =?utf-8?B?SFlocFFKOXlxelNDN2lKWTJhcHhaODJpREV1VHd5V1dvVVVra1QvOCtsa0tL?=
 =?utf-8?B?MVpZdFdPZmtDQUtnR0lPZ3pKaE41eDNWcnNNSWprUk8vQjZZUnMwd3JoSnZ4?=
 =?utf-8?B?YXdMbHN3ODF3V1FXa1FHQWdtQXZ3S1NvQkRRS1RySVdRVUtWV2pqS0xGbi9I?=
 =?utf-8?B?OHVBUFZHOXkxUVVpejdBaVRWd0Y2WURIT29UdDFXM1FxSUhQN3ZNbG40QUla?=
 =?utf-8?B?aGJBSE9NL1NHWU5NRzR4VS9FbnNSMXVKWjF0alVlemFDZVRhRFl6ZElGeXlq?=
 =?utf-8?B?U1RJbDZWMHk4dWM4R0l2SWJXTHJMdU56OCsyMjZVdUswUnhrcElQOC8rcjZu?=
 =?utf-8?B?T1Y3TTU2OWIwV1J3MnNYeTJyeTVLd3FDeGllR0p5YVRzRE1FSWhmSjJnRW9V?=
 =?utf-8?B?a3UxbndMeGVoQU15aHVoY3FuZTFvaldoTEJMNXRYU1BEVVRDeEt3WFRoallu?=
 =?utf-8?B?QkRzZ0xLaFJhZHZrV2NIMzF6RDFoV1V4Q2hiTEtaUVhPYjZSVWlEeXNoS25v?=
 =?utf-8?Q?/NPUjSfQcbukA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9142d187-1101-4b27-35f5-08dee709d56f
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:24:15.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR04MB9714
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


On 7/17/2026 7:23 PM, Andrew Jones wrote:
> Commit b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and
> no priv access") placed its check ahead of the leaf-vs-non-leaf
> branch in riscv_iommu_spa_fetch(), so it fires on every PTE walked,
> including non-leaf/table entries. Per the RISC-V privileged spec's
> address translation algorithm (Sv39/Sv48/etc., the "leaf PTE has
> been reached" step, followed separately by the U-bit permission
> check), the U bit is only defined and checked for the leaf PTE
> reached at the end of the walk -- non-leaf PTEs don't carry a
> meaningful U bit at all.
>
> Move the check after the leaf/non-leaf branch, alongside the other
> leaf-only checks, mirroring how the G_STAGE U-bit check (added in
> 9158c900ab30) is already correctly placed.
>
> Fixes: b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index f6865d1e164e..ed9fb09f8bc7 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -476,13 +476,6 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               break;                /* Invalid PTE */
>           } else if (pte & PTE_RESERVED(false)) {
>               break;                /* Reserved PTE bits set */
> -        } else if (!(pte & PTE_U) && !pv) {
> -            /*
> -             * All accesses are assumed to be User mode unless
> -             * process_id is valid (pv).  In case we have a
> -             * non-user mode PTE and !pv we need to fault.
> -             */
> -            break;
>           } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>               base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>           } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> @@ -491,6 +484,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
>           } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
>               break;                /* Misaligned PPN */
> +        } else if (!(pte & PTE_U) && !pv) {
> +            /*
> +             * All accesses are assumed to be User mode unless
> +             * process_id is valid (pv).  In case we have a
> +             * non-user mode leaf PTE and !pv we need to fault.
> +             */
> +            break;
>           } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
>               break;                /* Read access check failed */
>           } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {


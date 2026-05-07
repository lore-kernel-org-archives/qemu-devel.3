Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3663CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsZE-0001Af-MO; Thu, 07 May 2026 02:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wKsYi-00011H-TR; Thu, 07 May 2026 02:50:14 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wKsYY-0006G5-TB; Thu, 07 May 2026 02:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFs/DkVqiTn77xhWSoMclZWtbj6sMjXZRqMdcWthsAKi8x0T/qJzwuIyqgQtwzqncWpkRZ/IzQn6He3S7H6dZsNlq2/V2JHHU+iQNZ2LFQtgm5Uy5RokWw0ykKjH/VgoqWg/HAogjqWwWivVFt4Nb5Uob0E+CL/bZ3YC/BqIUy9l4nx1WE+M6Z6qeqtK8yRYQdFC1UMccULHHuM2qhlBbIhIMxQGt60l900XDG6IZ+BHuL0AxshzV60aA0dRHeVm9aOsZEHxOUtQQaHnopUn0jSeN5x9AnKFQHdSh3gKfbMz54Yzgpb+3MX82HVEq3+RxzxbBu605Z/bZ9XnnYuisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v05B7ZEGxgpakIjdGiS4zEYFGtnyMhqtnlUQW3iqWiM=;
 b=cT0S0gYkcS6IpLqdKxUhVtyd6+Go2S/b2wHue4UQobfKevGvagejuJFBpVGwgEpIXBDxP5o1lbZAq+WKfArN39cvUQ2k+19jO2xnIQa5eKKGGjWnbKKVLPn3Xg8YDLtwAgcYiZSV7dpIYrQ687ujY8SF8XCU+pLNScj7zSI4c6g/8XC9wlD144ZXJWqbiGCgm7j15o+hHMc8G7U4dXyeS7n9eSVdG/Ed7YjjDKkFVMM0oop1zeGyXqDxBt8cZ7BCS44lqEtEW3sjt228PZIp0GeFLflrePrisYM21n1HWxsak+3/J34Gw2nj45Q/JVNqNYq6cZkhhQwiA5+FFtEgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v05B7ZEGxgpakIjdGiS4zEYFGtnyMhqtnlUQW3iqWiM=;
 b=bC29UGUzQa1QC/fMshy73jgnkKzONK5DEGQV1UehmQafS2pixOBrHv5IJvTi5rZi17inhHt5MQV3f3IQoo8deEdfdmLREWzRYOSBDiDWh9vcjxCsZOFBqY681VGaxVZ1in8rJdTPKOXdORgrP5E5MmFBJrSn+cqfP2zLxOcG6PRaFGGE9vK/gecSqARpgPABa4WvUWMasOFQZy9GuTBw1cS0X+CNGA6enIJJICWNRf0JsD9JA3+m+XppZfOmnfTGBYLKHrUrjVscUOO7HlL6GWtOGCLZgh8ZdhCH2FlIesWL9ho6jLSJ6Sn1uBDUB8FbQgqTFVEYd2q6UYxfNT/KEA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYPPR04MB9163.apcprd04.prod.outlook.com (2603:1096:405:385::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 06:49:10 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:49:10 +0000
Message-ID: <SE3PR04MB89224C7AECDD82D06FFF631CF33C2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 7 May 2026 14:49:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/riscv: iommu-trap: remove .impl.unaligned = true
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-2-peter.maydell@linaro.org>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260428093339.2087081-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <9b51c0ef-0ecc-4c90-a3a4-bc87546be63e@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYPPR04MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: b9360687-993e-4698-fa04-08deac04bd10
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|15080799012|461199028|45011099003|51005399006|8060799015|6090799003|19110799012|5072599009|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkdkNFBXaDd0YzlpT0ZKZnBUT1pXdHZlWVB6Wk01dVB5OW5GeDM5ck95TU5n?=
 =?utf-8?B?VEwvVzVTVlgwb25XMkpvRTNUWGZyVURURDBHaU1vMEM1MStFSnV4UUVVMmU4?=
 =?utf-8?B?UHhEcFlkMURJM0JwelljRWNaN3ZHR1BZSUFxL3hkbm04bFJtN1lreTNkMUxP?=
 =?utf-8?B?UnRVT3dPMjA5WFVnaklZWFArRXNlWEVmZXJNdXhxVVNtMUJKdmZZNkozMEpt?=
 =?utf-8?B?d3lvWGhCNlByRmNUVEdxaXFUYms5SXMvYnZvRWdMdWdaMlFQdktiOHMvcGV6?=
 =?utf-8?B?OTAzNFlJaHllQkFHMi9wTytMOGZ4QngyVHVhVTN2TDlsT0tpbUdubHBGZUxz?=
 =?utf-8?B?Z2E4cVROcWNrSWhqVGNyTEd2a0ZUMmxJMEpYdGd6REdQdmhpTVRabzdscXlk?=
 =?utf-8?B?WlJ5R1hQSGZQNlVnd3ZrR2syVmJ2YU5kMDl0TkpjdnlIdHkxZjBOdEtHNFFD?=
 =?utf-8?B?NHhmZ1BRdkNzMG5pTVEyRXZPUXNmeUFsQTI0bTZSSmVmNHI3SFZ0dFlJUEpG?=
 =?utf-8?B?UEtZRTR2L1dFMzFOSmpHd0p6eXdpWXcwdWR4b2lSUUR2OU0zbGtsd2R5M2gz?=
 =?utf-8?B?QUxhN1ByUDlGeWtsV1ppdXJGaEl5U3FOQ0FscWRrekc3V2YzMDhxVE91ajVz?=
 =?utf-8?B?bDIvTEM0M25td09IMTRFZFlUc2lrQ1Z5OUU5SGRjZmg5eFVENllnYkM4dGJr?=
 =?utf-8?B?RzJyMFVUSndLcEplSEQ5TFN0cTkyRGtzUmVUZHR4b0UrcjhyQTFmalZ3TGFH?=
 =?utf-8?B?ZDlEZ2kzaHFIbjF5YXpja3NrZGZZNWJHNWtNZ09oSkFMSTd3bjIxWWdDelQ3?=
 =?utf-8?B?b29yOTNqV3BUTGxXUkJyeW1tVU5aZUlIRnBnTUc4TDFHZk12M2ZZOS9HWkJF?=
 =?utf-8?B?K20rWkgwWmREdk5SRVdtTFJoRE5COFhpRUVWTlZIYUNuT0M4bnNYY1pYT2lo?=
 =?utf-8?B?cEw1NXByZHFtcGtpWCtqM3Y5b05hOG1JeW84R2ZXSnowQUk1OVFxZ0t3U3hx?=
 =?utf-8?B?UDhXWU9scDhObThVbTBhVXk4OUJRSDc3US92UFJUNU5URWc3c24wN25kczdB?=
 =?utf-8?B?S01aMnlsOVo2cWhRdmZlaEI5OXF5bmwvRU5DN01QSU81WG9rWTlzWlV4SjFM?=
 =?utf-8?B?MU1NSG9uam5peEtIdlBhM1ZkdlRMNzl5dStqSXZsYk9pcXY1NDI0NE1zMU1a?=
 =?utf-8?B?NHJqNFozSEx3TzlQMVJ5TWtpVFJDN2tJVlVNa3NEZXFQd3Q2YUZJbk5POW8v?=
 =?utf-8?B?dFpmTHN0bDlQMzhpQit3OTJlNHhCd1dSdWJQditlMDc0T05DUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJzNTNYMHJLbnNqbjhyYm5TNEZiNkNKdTlZZExTaFBFZG01LzJ0SldKc2h4?=
 =?utf-8?B?RlNZV3k2NXRvdnpaSVpQU0ZvZlR2a3kxelhXZmZEZkp5b0MxWWZOa0RTRzlm?=
 =?utf-8?B?V0kzWXZab2lsdkZwVFdIVmNMalNSTG9JOTRxdFBnMGVXMVpkbFZPYzFCNlR5?=
 =?utf-8?B?RWJGRWFNRDV1UlcxeXdydHl6Z0c2cGFTWEN4RDViYkxlVHFyVm5BdkhRWGQy?=
 =?utf-8?B?alphdEVuU1E1ZzBlRmU5VDJZS0lna2w2TTJZWHBpU3BFaFdlZHFHeE13L2F1?=
 =?utf-8?B?RzVBWFhIekIwWUVuemlQcklZRFNvUzhud3p1d0lHYUMyc1Qva1VQSVdNY09L?=
 =?utf-8?B?cXlyd0xWTTd1cWdScVdwZnRNZGNVM2ZyZFQ5WHMzSWFGaHVkMmhHVWZBS3du?=
 =?utf-8?B?SUEyL0krYkh4SnBWUHBpV3RZNEI2R3VySXJFaDVTMzFSV0FVMkUxYnpiS3RB?=
 =?utf-8?B?RnE1Q0FOUlljdFVmTmhWSHNlZGxFdC9ndytFL0dCYVAzSUI3MTNmZnpYNUx2?=
 =?utf-8?B?bk9MUW1lYmFwRGhnS0RpMTZZNGRnSUxMbXYxNUd3TllwS1UzN2dYSWc4TW9w?=
 =?utf-8?B?cjY3RHM4WVA0R3JFN0RPM1VkaytDTlNhNjdhT2xhbEVZaXF5dkZhWFBIVXNv?=
 =?utf-8?B?TCsvbDlTam50aDV3VU4zMDRndWI0L2hGVnl3VE1SRmlpN2ZDeTU1Wm9NRXI2?=
 =?utf-8?B?R0RJeElaTnFKYlFhMldWNWYzSEVKZkw2STlOZnIyQTdIbTg4akVaSkw4UkN2?=
 =?utf-8?B?cm5jRmNERDVsQkR6TURTRG1TZzJzbEdXcytMak43RDRpNEFMM1QyMUhDQTBv?=
 =?utf-8?B?YzA4WUFRbW1acmpZais0WTNRRS85T0F0TGgybE9GZ3ZDUUhTMDZ6VkgrcmEy?=
 =?utf-8?B?RTU3TDZBcWNMSnRUckZJNXNscFBNVTZlUzUzMDhzWk9scjRCUldOTkh0S0Zi?=
 =?utf-8?B?TXVtLzMxUFpvYmV6VmVWdTB4VVIxdHhaWlZpczVFeXFsVXBlRDlYS21jNTZo?=
 =?utf-8?B?RkJqc1pkZzVGT0t2OElyOFF1R3loUmd4ejdtWHlpS2tOSEt2QTExdTc1bjNZ?=
 =?utf-8?B?YllhSnNIRkphTUFEcThvY1U4U0ZwYmtKaVlNMzN5dHV1WWFZY0VlKzNZZkl2?=
 =?utf-8?B?TEtDVkdRdXhtOUNWcm1YMXBhR2I5d0RrK0RKMkJ5cmNPR0sxK1VNTGFwY3RW?=
 =?utf-8?B?TE1mMlNqWmhzbW94d3p5RFZsRHd5RmVXMFE3Mlh1OFpxUi9Ua2JHbm0ycnRz?=
 =?utf-8?B?akM1aDNsZVh5VzVOM2JZMXlwUk9sQWlDQ3hMYkZSNjJOM1BPeUhlMzRzTmQr?=
 =?utf-8?B?VHhRWlUyMkp1bmttYWVtZnZOUjVjbWZaMElKY2VpdjE4aGFTNVpQNEF1dnJS?=
 =?utf-8?B?UnREaHF2RXlnVmlDK0RsdFZtdE5vOFpuVkxMMUlPY1Z3dmRYOFhDV1p3WHh6?=
 =?utf-8?B?dmd2Q3ppaWJtUXNBaDIxY1lzTXhsdVR5TkVSMjFQZ2podFAvS2ZIcnJnekM1?=
 =?utf-8?B?MytqUWVLbGpoOFZjK24wWWUvR0dNZC9reVdSdUpyYi9jY1gzcUgvTS9pdkRk?=
 =?utf-8?B?RlBUU0ppZnJ3Q3pwd1F5Y2V6Vm1HLzR3YUROQjJhcXVpZ2ZaejlOeXduaE9u?=
 =?utf-8?B?T1V5N0JSWjhhcnlLOFlqLzlQTWJOcU5WaHUwTlE0TlZnVXBZcFUwWU8rL1pw?=
 =?utf-8?B?bzlCRUZzSVlOMGdSdElEWUlBOWpNbE5DRWc4YnVMb2lVaTRNT2FrcWk5UEIr?=
 =?utf-8?B?TzkxWHRFTE9uUzBncFNBbEZ5aVN6Q1BmZjdZTGR5eXYvaUhXZ05LaERjZXFS?=
 =?utf-8?B?V0NOSkw3b2xGOGFlWUIwUVF5cVVpbTJERjVkb296M2dqcEpoS3lzOFlUaWoy?=
 =?utf-8?Q?X90ew2En02URZ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b9360687-993e-4698-fa04-08deac04bd10
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:49:10.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR04MB9163
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


On 4/28/2026 5:33 PM, Peter Maydell wrote:
> From: CJ Chen <cjchen@igel.co.jp>
>
> The riscv_iommu_trap_ops MemoryRegionOps specifies that
> unaligned accesses are not valid for this device but that
> it does implement them. This doesn't make much sense, and
> we want to add an assertion that registered MRs don't specify
> this invalid combination of settings.
>
> Drop .impl.unaligned = true, with no behaviour change.
>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> [PMM: reworded commit message]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c3c9ed6469..f0de264a10 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2433,7 +2433,6 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
>       .impl = {
>           .min_access_size = 4,
>           .max_access_size = 8,
> -        .unaligned = true,
>       },
>       .valid = {
>           .min_access_size = 4,


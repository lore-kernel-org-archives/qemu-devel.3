Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27ACCD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaP2-0002Qq-7t; Thu, 11 Jun 2026 04:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXaOx-0002Qb-07; Thu, 11 Jun 2026 04:04:35 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXaOm-0007r6-Nu; Thu, 11 Jun 2026 04:04:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7xEpO6vzc3hzBnGZXUSq5lQZM0ZTNo+ujvQDwu5Z0hmPDIcwpREUEhBlhgxTCAUBeK8WwmZXdAgiAY/uTkK85kiHgi1SFP4gErPWvrnkykr8m7N1JOhuxnjxvLZuB2eAtFwVYi8THdIZipdGBalWhGHCJ5QF8oXBhZ0qeopAmabt8EjVX2V5gUzk3kAY9ZRDtLKYfhkaV4/DkF08jkFrRwPNcwYLuhe6xxH5q+iCu0YRzWiwrUFHg0T7K5rBmn1D8LBQ+TqrtRWrqymYvLdS4oawu3rLWmPfSufUaN2LuMLnYa5sDfwSdZjLm+Ya/9BtkUTU3tKF1szI7JD2Qdz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAIrWwtXvf7Iu7rHntof4RXPCNLOZQdX4dOCcu8FAxc=;
 b=eRu0yiG5TCsRFgAbtLBuQDCUtZndXmvmPaXo4ZwZIdJeq+2EaWv9qsVt7AcQLIO5DW0TCQ3B10REkH9uK7udHOydRtx+noXrAUs8Klg3vPpnYtfuDd0C/Tax1DDXDmQPgg3LYGNSxpolT1vbwXRnEL6FvOMP2WfdANM1hZRlX0gjYI8J1bHU9mG7XmPqDZYAx+qHZB+SxcmzVqR69LiSEaRDDCNhfxxI6ia5GzQGbS5tVW6nUyVIENKyk+3sXa/eab0MI9zJsM4vXNPM1zo6PZV4KXeRG///jBCfNXJC8FwMq9FI0IfBsdt/nU2Q+097V1iImsaRQP6wxtNdFMq9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAIrWwtXvf7Iu7rHntof4RXPCNLOZQdX4dOCcu8FAxc=;
 b=ZRw/R0TrA4EOmvTZjQ6LrD4g+WwcRleGeDMNhfQ1yZiay8QsPJPG4casY2Ue7uyqnjSRDt/digL0k4gMNlLgevsVpNJNYxM/aYBeOtbGjTVL4PZFtGEK4PatBaqcV2Fz/89Xl8JXjGVrpuF9OW+8qdY1RoDWJ1+auU7LzIXt8aqINfcaWEcegLoO3PfLFszznPodOdm0q/N2fufBjSr1B9IcF34vVGiSl7Ze/uye29fTuxrh1s6g0jfoEytov8ekakrL5z0mrlwPqa0wcp7tlFxmVKI8ocx1dn8w7TT+VPmbEisTaQZm046+ImDDvyhGrAesC7Qa+Jn3q1NNw3e0MQ==
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com (2603:1096:d10:46::5)
 by TYPPR04MB9210.apcprd04.prod.outlook.com (2603:1096:405:381::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 08:04:16 +0000
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d]) by KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 08:04:15 +0000
Message-ID: <KUZPR04MB892516822A39D2E7417499F3F31B2@KUZPR04MB8925.apcprd04.prod.outlook.com>
Date: Thu, 11 Jun 2026 16:04:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] hw/riscv: server platform reference machine
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Fei Wu <wu.fei9@sanechips.com.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To KUZPR04MB8925.apcprd04.prod.outlook.com
 (2603:1096:d10:46::5)
X-Microsoft-Original-Message-ID: <ae8577d1-6478-4cda-9abf-3fdaa1d8e8b7@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB8925:EE_|TYPPR04MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 830019b5-8173-4b1c-86b9-08dec790071c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|19101099003|5072599009|12121999013|23021999003|19110799012|41001999006|8060799015|51005399006|6090799003|40105399003|440099028|3412199025|12091999003|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THJsZ0xZb2w0ZG51Y1lCVzZXMlIxcXVMRWtOM0ZhdWJyT2txb20ydlppNUdH?=
 =?utf-8?B?WWVzQ1JJMm5OMEprSmhXS0JPQTk1eGp1OTZaZ0NBQndmUmh5d0M1cVgyY2t4?=
 =?utf-8?B?ZmtGdFpwVTZvQmU0SDhjeWNWT25QQXJjYnRwOFg3L2Nra0xYcVJ6cUpoYlVQ?=
 =?utf-8?B?SThIckIzenhNWnh0RFcyZDF1L3BRcDZWVXlvdHE2RlFTV1d0MDNCK1BObksx?=
 =?utf-8?B?YkwxYWhxRDZScXJXWXdpTnY1MlhGUHVUMDdEakY2R1R0LytxV0svMkgyZzZx?=
 =?utf-8?B?cHB3S2NnbTZ6VmZOVDBOaXR5R013bFB4YTFsQXNxQXFsbFpWRFpLRGx2OE9C?=
 =?utf-8?B?S3UxWFNrc3JFRTZzbDI5M2dOL2wrWGlDcnA0WHRaVGsxUWxDaDRSZUhGMG1X?=
 =?utf-8?B?cHI2NHpRVTQyVnVVelJhNFlHL2UzRmJ5cXo4V3REcFFTOXdXTldlUnlwenZk?=
 =?utf-8?B?OTZkZnlsWkRoUjFxWlhGSzJVVXFyZ2Q0dThsWTJQd0Noa0xtN3NzTDQxQThs?=
 =?utf-8?B?OGJqTWs3UHd1QUI2VkpnSFZ2ZVBnZTMzSkhmdHlwcXNuZTJDeTFlcVdTd0Qz?=
 =?utf-8?B?bjQyeC91S0xndUM1V1gxZXd2S0k2RjZCVEc1RUpKdGF3eFp0N2RsRmNrNFNs?=
 =?utf-8?B?TmVwUFVCeFZHUFFHTHRxQjFRSlMzZ0hzWVRSK244Q1RYTURJVzJHZ216cTEx?=
 =?utf-8?B?a04veGdVVG1qOGp5RVArOHNvdXBVcWtIbG9yenhENEk1RkNKTGFQVEVsNk1T?=
 =?utf-8?B?RjhPdm5oUitDdEJzWDFCZEUvRDVHSVc5WGZ4YWNLdG1xcXFaVy9qbktkSFBR?=
 =?utf-8?B?ZllVWnd5bGZGMHVzRE1IRFFSdzUveCtxdnFmUTBuRXBvTmdBYVlXMVBTRTM1?=
 =?utf-8?B?WG1lVnkvemMvL2ZVOWZid2Z1YlQ4VmVtMnlXMVNsbDJtNFg1R0k3SnZHRHVZ?=
 =?utf-8?B?RnNWakdrZUJ3a1JwT2IzeFZmZmtZYW5zcEoremJmd2dIVFoyNGZoVnJCNTh2?=
 =?utf-8?B?b3MxdmY4NFZqTjY2eGVIbmJoVTh0WURMQ3pLUnlGR3VQRlh6d1lEYmV5NDVa?=
 =?utf-8?B?ZkxqZmxCZkF4THJwYXhuUDV4V3lSRkJsNTZNS3hJbDluYWhwd2wxaGF3TFlw?=
 =?utf-8?B?UzZrM05FU0J2YTlUeWVwRFZaT3R2RVEwN1Axd1pyaTNnY1VvTEJiWmdNcURR?=
 =?utf-8?B?MlZ3Z0cvRXRJWDl0WVJFcDVzOGlkMFVtZFZsRjA4SnRWdHZpTUNqZmVsZ3Za?=
 =?utf-8?B?ZjZzV2F0a1kxcGVTU0NXVDEzKzZjb0FtTGVkRHhxNWg1QzZYQ3hXQksyNGFr?=
 =?utf-8?B?MkN5dHVUeXRtTjJBdXkxRnZmMTZhWkRCMVAwQkRSQ285TDQxa3piWVdwT2FN?=
 =?utf-8?B?UENEb09GejNCRExPU2lSSmxvSEl5VmRNQXpzdFB6aTlTODhydjNndS9uaThN?=
 =?utf-8?B?M2dVY0dLMnJkaDhmMUIwaTJ4ZDB5ZDJza2pEcy9vaXVQK1hIUHcyVkpaYVRL?=
 =?utf-8?Q?fCY1oY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9qRFRhYnVKa2xtVkhiN284MlJDRnJ4QWhHeUY3dmQzdjFYSjFxT0g1Ymow?=
 =?utf-8?B?dExqY0lHbmxBN002bms1UXBuOTVwMkJ4NGdKZ1pEMTRzbTgvVmx3OGZrQmUx?=
 =?utf-8?B?WjNxSkZmWkdETkNoV1pYTjZoSlF4MFVNL0NINlQrQmpTRzh1aFEyRysveFRU?=
 =?utf-8?B?ODIvc3JEVzFsMUtPK1lLbi9RSWdoa0w0Z0c3dmhOcENKeitmVFBpREJOT2pp?=
 =?utf-8?B?c1VPT1pJZk4zcXpKTlpVeTNWcTBvcW5JTGEvZlR5VXRLcGowVnB6NStCVWJT?=
 =?utf-8?B?SllCbkFlMDVxT1Y3aEhsZzRYd3hpbVE5amc1dVVjbHl6cUN6Y0tDQ3JKNjd3?=
 =?utf-8?B?MHpHbWl6dVA4ZldjYjk2MGU0RkQrbnhxS05TQXd6ZTR2czlUejRlSHlnWnBt?=
 =?utf-8?B?MWZ0a3pSYWhGZnplbHdTVmZkcU9TOTRid1FTRTlZVWgrRjdwWVI5SHRJcysx?=
 =?utf-8?B?UU1xS1ZXOU1FMjlmaTd3SmE2cWR6SWdHdHd1ZG4zOVNpQWtrNUNDb0drZ3VB?=
 =?utf-8?B?WXp1aWhMRnV6bmIxZk9taitiYWdSVWRMeWlMWVU4UlFDTmtCbTFQVys5Rndq?=
 =?utf-8?B?WlgzYWoyRm04OFFCT0pua2pkL2tvL2I1SEQzVEdSRE96QStJSTRsQTZjRWJZ?=
 =?utf-8?B?a1JLRUhKZHFDRzUreXE0OTYwRlhWd2kzMUxqRURXWW9BOVdEOWt0NGtJMit2?=
 =?utf-8?B?RSszS1c1MkladFBJcXRXU2o3a2JwcDgvc042R2srNzVGTzZGNUJzc1gzd2w4?=
 =?utf-8?B?NzAyaGp6WjJ5ZStsczNwcy9WcWhhYmhOSzhiNW8xUUJSOFNmZWg0MVBTTmVB?=
 =?utf-8?B?MUFTaVIzMzBiSHg5WmNrQTIzbFlmYldPVGZwRGJsditKZzZDRWZlZFFLQWtj?=
 =?utf-8?B?WDZIZTVyNkhIQlNjNjQ3dTdIYkEyZjVOQnBmT2JsUWRlNzNuM2N0ZnRUSGFk?=
 =?utf-8?B?MjJKZkJpTjFFcjQvbXpMZCs0VFRoWDlmbnlmcHlQZ1l3Wm1iQ0dwQU81T2h0?=
 =?utf-8?B?L1lEeWdKRWZIVDhYT0wyQ3JCTlRIeFQ1S0lYZ04yRXZDL1Z0Nmc4NHpEWjN6?=
 =?utf-8?B?Yy9uM1JpTmpOaitnU1c5ak55T0dUUnZsTnRnMnN2U0RBWXJXQjBnQmxxQlcx?=
 =?utf-8?B?SG00Zm56VzVuQWhsMHhjTkZ5RzF2TkZMb0I0ZTkzNXBBWVp5NU1aQWVBTUs3?=
 =?utf-8?B?TGRvRTdaMms1WGVHRTlibmRSR3IvYnhqOGdDVXh6YVdVN2tFeld0QmJLUVp4?=
 =?utf-8?B?WWRDbDl1anhjbVNORnAwMDNWZTFsazlRRW1FNVRGcFlmdkNrZ0ZWbTBOcS9J?=
 =?utf-8?B?VDZsMEVnWG0vQzlXYnAvaUppNkhxak0rQk5HUGNKOTkvTkw2Lzh6ckdKVHR2?=
 =?utf-8?B?SW5SUzZpdUhrbERGSXh2MDVpeXNONUxoSm11VDZGbVZJZnZKbGQwRXNDbkd5?=
 =?utf-8?B?UTNDbEd4dmMwRmd4ZzMxek1WSmVSaU93QzBHejFrN1NOWnpLUUZ0UStRSVJl?=
 =?utf-8?B?K2VLYzF6Q2ZIQ3N2OExYQ1FEbmNvdTBDUHFFMjFRZU96WVpZRXIzdklXWUxT?=
 =?utf-8?B?dFVoWTlMUWNteXVvMnpDc3k0UmdseUdzalBHVVNzNnpWWGVXUFh0dnRCRGtB?=
 =?utf-8?B?WVZnMHczcFQwMmVmMVI4SFJGdGUyditjODNQeUkxVkJEMXo0RDZZdGs1dzhh?=
 =?utf-8?B?ODBzdXpuSEdFTXBsd3BpbGcvS1RXWEZ3MDhweWIzd25EVk9Xd2dMQ0M2bWh0?=
 =?utf-8?B?TENDM3JXWU14K29BNEorRk1GVW1WeVNsOFlucHIzcDdwWE8wc0o0MGZ3UGlW?=
 =?utf-8?B?WVZEQXowVlVrOUhhZnJDZ0RuV3p2QkVOZG45dmg0ZGVER0V5T3ZJL0NNenVq?=
 =?utf-8?Q?KcxvrA1Q1feyJ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 830019b5-8173-4b1c-86b9-08dec790071c
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB8925.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:04:15.8407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR04MB9210
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 6/11/2026 5:41 AM, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> The main features included in this emulation are:
>
> - Based on riscv virt machine type;
> - A new memory map as close as virt machine as possible;
> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>    IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> - AIA;
> - PCIe AHCI;
> - PCIe NIC;
> - No virtio device;
> - No fw_cfg device;
> - No ACPI table provided;
> - Only minimal device tree nodes.
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform
>
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   configs/devices/riscv64-softmmu/default.mak |    1 +
>   hw/riscv/Kconfig                            |   15 +
>   hw/riscv/meson.build                        |    1 +
>   hw/riscv/server_platform_ref.c              | 1389 +++++++++++++++++++
>   4 files changed, 1406 insertions(+)
>   create mode 100644 hw/riscv/server_platform_ref.c
>
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
> index a8e4d0ab33..ae3f62e2d4 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -9,6 +9,7 @@
>   # CONFIG_SIFIVE_E=n
>   # CONFIG_SIFIVE_U=n
>   # CONFIG_RISCV_VIRT=n
> +# CONFIG_RISCV_SERVER_PLATFORM_REF=n
>   # CONFIG_MICROCHIP_PFSOC=n
>   # CONFIG_SHAKTI_C=n
>   # CONFIG_XIANGSHAN_KUNMINGHU=n
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2518b04175..1807c423ff 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -69,6 +69,21 @@ config RISCV_VIRT
>       select ACPI
>       select ACPI_PCI
>   
> +config RISCV_SERVER_PLATFORM_REF
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select RISCV_IOMMU
> +
>   config SHAKTI_C
>       bool
>       default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 533472e22a..74944cca84 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>   riscv_ss.add(files('riscv_hart.c'))
>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
>   riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>   riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>   riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> new file mode 100644
> index 0000000000..7e626c6eb7
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c
> @@ -0,0 +1,1389 @@
> +/*
> + * QEMU RISC-V Server Platform Reference Board (riscv-server-ref)
> + *
> + * Copyright (c) 2024 Intel, Inc.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "hw/core/boards.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/char/serial.h"
> +#include "hw/block/flash.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/machines-qom.h"
> +#include "hw/riscv/numa.h"
> +#include "hw/riscv/iommu.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "chardev/char.h"
> +#include "hw/char/serial-mm.h"
> +#include "system/device_tree.h"
> +#include "system/runstate.h"
> +#include "system/system.h"
> +#include "system/tcg.h"
> +#include "system/qtest.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +#include "net/net.h"
> +
> +#define RVSERVER_CPUS_MAX_BITS             9
> +#define RVSERVER_CPUS_MAX                  (1 << RVSERVER_CPUS_MAX_BITS)
> +#define RVSERVER_SOCKETS_MAX_BITS          2
> +#define RVSERVER_SOCKETS_MAX               (1 << RVSERVER_SOCKETS_MAX_BITS)
> +
> +#define RVSERVER_IRQCHIP_NUM_MSIS 255
> +#define RVSERVER_IRQCHIP_NUM_SOURCES 96
> +#define RVSERVER_IRQCHIP_NUM_PRIO_BITS 3
> +#define RVSERVER_IRQCHIP_MAX_GUESTS_BITS 3
> +#define RVSERVER_IRQCHIP_MAX_GUESTS \
> +    ((1U << RVSERVER_IRQCHIP_MAX_GUESTS_BITS) - 1U)
> +
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_APLIC_ADDR_CELLS  0
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +#define NUM_SATA_PORTS  6
> +
> +#define SYSCON_RESET     0x1
> +#define SYSCON_POWEROFF  0x2
> +
> +#define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
> +
> +struct RISCVServerRefMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +    RISCVHartArrayState soc[RVSERVER_SOCKETS_MAX];
> +    DeviceState *irqchip[RVSERVER_SOCKETS_MAX];
> +    PFlashCFI01 *flash[2];
> +
> +    int fdt_size;
> +    int aia_guests;
> +    const MemMapEntry *memmap;
> +};
> +
> +enum {
> +    RVSERVER_DEBUG,
> +    RVSERVER_MROM,
> +    RVSERVER_RESET_SYSCON,
> +    RVSERVER_RTC,
> +    RVSERVER_IOMMU_SYS,
> +    RVSERVER_ACLINT,
> +    RVSERVER_APLIC_M,
> +    RVSERVER_APLIC_S,
> +    RVSERVER_UART0,
> +    RVSERVER_IMSIC_M,
> +    RVSERVER_IMSIC_S,
> +    RVSERVER_FLASH,
> +    RVSERVER_DRAM,
> +    RVSERVER_PCIE_MMIO,
> +    RVSERVER_PCIE_PIO,
> +    RVSERVER_PCIE_ECAM,
> +    RVSERVER_PCIE_MMIO_HIGH
> +};
> +
> +enum {
> +    RVSERVER_UART0_IRQ = 10,
> +    RVSERVER_RTC_IRQ = 11,
> +    RVSERVER_PCIE_IRQ = 0x20, /* 32 to 35 */
> +    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
> +};
> +
> +/*
> + * The server soc reference machine physical address space used by some of the
> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
> + * of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by RVSERVER_SOCKETS_MAX_BITS, RVSERVER_CPUS_MAX_BITS,
> + * and RVSERVER_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of
> + * server reference machine physical address space.
> + */
> +
> +#define RVSERVER_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
> +#if RVSERVER_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(RVSERVER_CPUS_MAX_BITS, RVSERVER_IRQCHIP_MAX_GUESTS_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define RVSERVER_IMSIC_MAX_SIZE            (RVSERVER_SOCKETS_MAX * \
> +                                        RVSERVER_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < RVSERVER_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif
> +
> +static const MemMapEntry rvserver_ref_memmap[] = {
> +    [RVSERVER_DEBUG] =          {        0x0,         0x100 },
> +    [RVSERVER_MROM] =           {     0x1000,        0xf000 },
> +    [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },
> +    [RVSERVER_RTC] =            {   0x101000,        0x1000 },
> +    [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
> +    [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
> +    [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
> +    [RVSERVER_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
> +    [RVSERVER_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
> +    [RVSERVER_UART0] =          { 0x10000000,         0x100 },
> +    [RVSERVER_FLASH] =          { 0x20000000,     0x4000000 },
> +    [RVSERVER_IMSIC_M] =        { 0x24000000, RVSERVER_IMSIC_MAX_SIZE },
> +    [RVSERVER_IMSIC_S] =        { 0x28000000, RVSERVER_IMSIC_MAX_SIZE },
> +    [RVSERVER_PCIE_ECAM] =      { 0x30000000,    0x10000000 },
> +    [RVSERVER_PCIE_MMIO] =      { 0x40000000,    0x40000000 },
> +    [RVSERVER_DRAM] =           { 0x80000000, 0xff80000000ull },
> +    [RVSERVER_PCIE_MMIO_HIGH] = { 0x10000000000ull, 0x10000000000ull },
> +};
> +
> +#define RVSERVER_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *rvserver_flash_create(RISCVServerRefMachineState *s,
> +                                          const char *name,
> +                                          const char *alias_prop_name)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the ARM virt board.
> +     */
> +    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", RVSERVER_FLASH_SECTOR_SIZE);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);
> +
> +    object_property_add_child(OBJECT(s), name, OBJECT(dev));
> +    object_property_add_alias(OBJECT(s), alias_prop_name,
> +                              OBJECT(dev), "drive");
> +
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void rvserver_flash_map(PFlashCFI01 *flash,
> +                               hwaddr base, hwaddr size,
> +                               MemoryRegion *sysmem)
> +{
> +    DeviceState *dev = DEVICE(flash);
> +
> +    assert(QEMU_IS_ALIGNED(size, RVSERVER_FLASH_SECTOR_SIZE));
> +    assert(size / RVSERVER_FLASH_SECTOR_SIZE <= UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / RVSERVER_FLASH_SECTOR_SIZE);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
> +                                                       0));
> +}
> +
> +static void rvserver_flash_maps(RISCVServerRefMachineState *s,
> +                                MemoryRegion *sysmem)
> +{
> +    hwaddr flashsize = rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
> +    hwaddr flashbase = rvserver_ref_memmap[RVSERVER_FLASH].base;
> +
> +    rvserver_flash_map(s->flash[0], flashbase, flashsize, sysmem);
> +    rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem);
> +}
> +
> +static void create_pcie_irq_map(RISCVServerRefMachineState *s,
> +                                void *fdt, char *nodename,
> +                                uint32_t irqchip_phandle)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride = 0;
> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
> +                          FDT_MAX_INT_MAP_WIDTH] = {};
> +    uint32_t *irq_map = full_irq_map;
> +
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
> +        int devfn = dev * 0x8;
> +
> +        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
> +            int irq_nr = RVSERVER_PCIE_IRQ +
> +                         ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
> +            int i = 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] = cpu_to_be32(devfn << 8);
> +            i += FDT_PCI_ADDR_CELLS;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] = cpu_to_be32(pin + 1);
> +            i += FDT_PCI_INT_CELLS;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] = cpu_to_be32(irqchip_phandle);
> +            irq_map[i++] = cpu_to_be32(irq_nr);
> +            irq_map[i++] = cpu_to_be32(0x4);
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride = i;
> +            }
> +            irq_map += irq_map_stride;
> +        }
> +    }
> +
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> +                     PCI_NUM_PINS * PCI_NUM_PINS *
> +                     irq_map_stride * sizeof(uint32_t));
> +
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> +                           0x1800, 0, 0, 0x7);
> +}
> +
> +static void create_fdt_socket_cpus(RISCVServerRefMachineState *s, int socket,
> +                                   char *clust_name, uint32_t *phandle,
> +                                   uint32_t *intc_phandles)
> +{
> +    int cpu;
> +    uint32_t cpu_phandle;
> +    MachineState *ms = MACHINE(s);
> +    bool is_32_bit = riscv_is_32bit(&s->soc[0]);
> +    int8_t satp_mode_max;
> +
> +    for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
> +        RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
> +        satp_mode_max = cpu_ptr->cfg.max_satp_mode;
> +        g_autofree char *cpu_name = NULL;
> +        g_autofree char *core_name = NULL;
> +        g_autofree char *intc_name = NULL;
> +        g_autofree char *sv_name = NULL;
> +
> +        cpu_phandle = (*phandle)++;
> +
> +        cpu_name = g_strdup_printf("/cpus/cpu@%d",
> +            s->soc[socket].hartid_base + cpu);
> +        qemu_fdt_add_subnode(ms->fdt, cpu_name);
> +
> +        if (satp_mode_max != -1) {
> +            sv_name = g_strdup_printf("riscv,%s",
> +                                      satp_mode_str(satp_mode_max, is_32_bit));
> +            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
> +        }
> +
> +        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
> +
> +        if (cpu_ptr->cfg.ext_zicbom) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
> +                                  cpu_ptr->cfg.cbom_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicboz) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-size",
> +                                  cpu_ptr->cfg.cboz_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicbop) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-size",
> +                                  cpu_ptr->cfg.cbop_blocksize);
> +        }
> +
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv");
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
> +            s->soc[socket].hartid_base + cpu);
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "device_type", "cpu");
> +        riscv_socket_fdt_write_id(ms, cpu_name, socket);
> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "phandle", cpu_phandle);
> +
> +        intc_phandles[cpu] = (*phandle)++;
> +
> +        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
> +        qemu_fdt_add_subnode(ms->fdt, intc_name);
> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "phandle",
> +            intc_phandles[cpu]);
> +        qemu_fdt_setprop_string(ms->fdt, intc_name, "compatible",
> +            "riscv,cpu-intc");
> +        qemu_fdt_setprop(ms->fdt, intc_name, "interrupt-controller", NULL, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "#interrupt-cells", 1);
> +
> +        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
> +        qemu_fdt_add_subnode(ms->fdt, core_name);
> +        qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
> +    }
> +}
> +
> +static void create_fdt_socket_memory(RISCVServerRefMachineState *s,
> +                                     const MemMapEntry *memmap, int socket)
> +{
> +    g_autofree char *mem_name = NULL;
> +    hwaddr addr, size;
> +    MachineState *ms = MACHINE(s);
> +
> +    addr = memmap[RVSERVER_DRAM].base + riscv_socket_mem_offset(ms, socket);
> +    size = riscv_socket_mem_size(ms, socket);
> +    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(ms->fdt, mem_name);
> +    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
> +        addr >> 32, addr, size >> 32, size);
> +    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
> +    riscv_socket_fdt_write_id(ms, mem_name, socket);
> +}
> +
> +static void create_fdt_socket_aclint(RISCVServerRefMachineState *s,
> +                                     const MemMapEntry *memmap, int socket,
> +                                     uint32_t *intc_phandles)
> +{
> +    int cpu;
> +    g_autofree char *name = NULL;
> +    hwaddr addr, size;
> +    uint32_t aclint_cells_size;
> +    g_autofree uint32_t *aclint_mtimer_cells = NULL;
> +    MachineState *ms = MACHINE(s);
> +
> +    aclint_mtimer_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> +
> +    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> +        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
> +    }
> +    aclint_cells_size = s->soc[socket].num_harts * sizeof(uint32_t) * 2;
> +
> +    addr = memmap[RVSERVER_ACLINT].base +
> +           RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket;
> +    size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
> +
> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "riscv,aclint-mtimer");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
> +        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> +        0x0, RISCV_ACLINT_DEFAULT_MTIME);
> +    qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
> +        aclint_mtimer_cells, aclint_cells_size);
> +    riscv_socket_fdt_write_id(ms, name, socket);
> +}
> +
> +static uint32_t imsic_num_bits(uint32_t count)
> +{
> +    uint32_t ret = 0;
> +
> +    while (BIT(ret) < count) {
> +        ret++;
> +    }
> +
> +    return ret;
> +}
> +
> +static void create_fdt_one_imsic(RISCVServerRefMachineState *s,
> +                                 hwaddr base_addr,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t msi_phandle,
> +                                 bool m_mode, uint32_t imsic_guest_bits)
> +{
> +    int cpu, socket;
> +    g_autofree char *imsic_name = NULL;
> +    MachineState *ms = MACHINE(s);
> +    int socket_count = riscv_socket_count(ms);
> +    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
> +    g_autofree uint32_t *imsic_cells = NULL;
> +    g_autofree uint32_t *imsic_regs = NULL;
> +    static const char * const imsic_compat[2] = {
> +        "qemu,imsics", "riscv,imsics"
> +    };
> +
> +    imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
> +    imsic_regs = g_new0(uint32_t, socket_count * 4);
> +
> +    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> +        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        imsic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
> +    }
> +
> +    imsic_max_hart_per_socket = 0;
> +    for (socket = 0; socket < socket_count; socket++) {
> +        imsic_addr = base_addr + socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
> +        imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
> +                     s->soc[socket].num_harts;
> +        imsic_regs[socket * 4 + 0] = 0;
> +        imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
> +        imsic_regs[socket * 4 + 2] = 0;
> +        imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
> +        if (imsic_max_hart_per_socket < s->soc[socket].num_harts) {
> +            imsic_max_hart_per_socket = s->soc[socket].num_harts;
> +        }
> +    }
> +
> +    imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
> +                                 (unsigned long)base_addr);
> +    qemu_fdt_add_subnode(ms->fdt, imsic_name);
> +    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
> +                                  (char **)&imsic_compat,
> +                                  ARRAY_SIZE(imsic_compat));
> +
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
> +                          FDT_IMSIC_INT_CELLS);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
> +                     imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> +                     socket_count * sizeof(uint32_t) * 4);
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,num-ids",
> +                          RVSERVER_IRQCHIP_NUM_MSIS);
> +
> +    if (imsic_guest_bits) {
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,guest-index-bits",
> +                              imsic_guest_bits);
> +    }
> +
> +    if (socket_count > 1) {
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,hart-index-bits",
> +                              imsic_num_bits(imsic_max_hart_per_socket));
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-bits",
> +                              imsic_num_bits(socket_count));
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-shift",
> +                              IMSIC_MMIO_GROUP_MIN_SHIFT);
> +    }
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
> +}
> +
> +static void create_fdt_imsic(RISCVServerRefMachineState *s,
> +                             const MemMapEntry *memmap,
> +                             uint32_t *phandle, uint32_t *intc_phandles,
> +                             uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
> +{
> +    *msi_m_phandle = (*phandle)++;
> +    *msi_s_phandle = (*phandle)++;
> +
> +    /* M-level IMSIC node */
> +    create_fdt_one_imsic(s, memmap[RVSERVER_IMSIC_M].base, intc_phandles,
> +                         *msi_m_phandle, true, 0);
> +
> +    /* S-level IMSIC node */
> +    create_fdt_one_imsic(s, memmap[RVSERVER_IMSIC_S].base, intc_phandles,
> +                         *msi_s_phandle, false,
> +                         imsic_num_bits(s->aia_guests + 1));
> +
> +}
> +
> +/* Caller must free string after use.  Copied from hw/riscv/virt.c.  */
> +static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
> +{
> +    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
> +}
> +
> +static void create_fdt_one_aplic(RISCVServerRefMachineState *s, int socket,
> +                                 unsigned long aplic_addr, uint32_t aplic_size,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t aplic_phandle,
> +                                 uint32_t aplic_child_phandle,
> +                                 bool m_mode, int num_harts)
> +{
> +    int cpu;
> +    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> +    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
> +    MachineState *ms = MACHINE(s);
> +    static const char * const aplic_compat[2] = {
> +        "qemu,aplic", "riscv,aplic"
> +    };
> +
> +    for (cpu = 0; cpu < num_harts; cpu++) {
> +        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
> +    }
> +
> +    qemu_fdt_add_subnode(ms->fdt, aplic_name);
> +    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
> +                                  (char **)&aplic_compat,
> +                                  ARRAY_SIZE(aplic_compat));
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
> +                          FDT_APLIC_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
> +                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
> +    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
> +
> +    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
> +                           0x0, aplic_addr, 0x0, aplic_size);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
> +                          RVSERVER_IRQCHIP_NUM_SOURCES);
> +
> +    if (aplic_child_phandle) {
> +        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
> +                              aplic_child_phandle);
> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> +                               aplic_child_phandle, 0x1,
> +                               RVSERVER_IRQCHIP_NUM_SOURCES);
> +    }
> +
> +    riscv_socket_fdt_write_id(ms, aplic_name, socket);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
> +}
> +
> +static void create_fdt_socket_aplic(RISCVServerRefMachineState *s,
> +                                    const MemMapEntry *memmap, int socket,
> +                                    uint32_t msi_m_phandle,
> +                                    uint32_t msi_s_phandle,
> +                                    uint32_t *phandle,
> +                                    uint32_t *intc_phandles,
> +                                    uint32_t *aplic_phandles,
> +                                    int num_harts)
> +{
> +    unsigned long aplic_addr;
> +    uint32_t aplic_m_phandle, aplic_s_phandle;
> +
> +    aplic_m_phandle = (*phandle)++;
> +    aplic_s_phandle = (*phandle)++;
> +
> +    /* M-level APLIC node */
> +    aplic_addr = memmap[RVSERVER_APLIC_M].base +
> +                 memmap[RVSERVER_APLIC_M].size * socket;
> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSERVER_APLIC_M].size,
> +                         msi_m_phandle, intc_phandles,
> +                         aplic_m_phandle, aplic_s_phandle,
> +                         true, num_harts);
> +
> +    /* S-level APLIC node */
> +    aplic_addr = memmap[RVSERVER_APLIC_S].base +
> +                 memmap[RVSERVER_APLIC_S].size * socket;
> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSERVER_APLIC_S].size,
> +                         msi_s_phandle, intc_phandles,
> +                         aplic_s_phandle, 0,
> +                         false, num_harts);
> +
> +    aplic_phandles[socket] = aplic_s_phandle;
> +}
> +
> +static void create_fdt_pmu(RISCVServerRefMachineState *s)
> +{
> +    g_autofree char *pmu_name = g_strdup_printf("/pmu");
> +    MachineState *ms = MACHINE(s);
> +    RISCVCPU *hart = &s->soc[0].harts[0];
> +
> +    qemu_fdt_add_subnode(ms->fdt, pmu_name);
> +    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
> +    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name);
> +}
> +
> +static void create_fdt_sockets(RISCVServerRefMachineState *s,
> +                               const MemMapEntry *memmap,
> +                               uint32_t *phandle,
> +                               uint32_t *irq_mmio_phandle,
> +                               uint32_t *irq_pcie_phandle,
> +                               uint32_t *msi_pcie_phandle)
> +{
> +    int socket, phandle_pos;
> +    MachineState *ms = MACHINE(s);
> +    uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
> +    uint32_t xplic_phandles[MAX_NODES];
> +    g_autofree uint32_t *intc_phandles = NULL;
> +    int socket_count = riscv_socket_count(ms);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> +                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
> +
> +    intc_phandles = g_new0(uint32_t, ms->smp.cpus);
> +
> +    phandle_pos = ms->smp.cpus;
> +    for (socket = (socket_count - 1); socket >= 0; socket--) {
> +        g_autofree char *clust_name = NULL;
> +        phandle_pos -= s->soc[socket].num_harts;
> +
> +        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
> +        qemu_fdt_add_subnode(ms->fdt, clust_name);
> +
> +        create_fdt_socket_cpus(s, socket, clust_name, phandle,
> +                               &intc_phandles[phandle_pos]);
> +
> +        create_fdt_socket_memory(s, memmap, socket);
> +
> +        create_fdt_socket_aclint(s, memmap, socket,
> +            &intc_phandles[phandle_pos]);
> +    }
> +
> +    create_fdt_imsic(s, memmap, phandle, intc_phandles,
> +        &msi_m_phandle, &msi_s_phandle);
> +    *msi_pcie_phandle = msi_s_phandle;
> +
> +    phandle_pos = ms->smp.cpus;
> +    for (socket = (socket_count - 1); socket >= 0; socket--) {
> +        phandle_pos -= s->soc[socket].num_harts;
> +
> +        create_fdt_socket_aplic(s, memmap, socket,
> +                                msi_m_phandle, msi_s_phandle, phandle,
> +                                &intc_phandles[phandle_pos],
> +                                xplic_phandles,
> +                                s->soc[socket].num_harts);
> +    }
> +
> +    for (socket = 0; socket < socket_count; socket++) {
> +        if (socket == 0) {
> +            *irq_mmio_phandle = xplic_phandles[socket];
> +            *irq_pcie_phandle = xplic_phandles[socket];
> +        }
> +        if (socket == 1) {
> +            *irq_pcie_phandle = xplic_phandles[socket];
> +        }
> +    }
> +
> +    riscv_socket_fdt_write_distance_matrix(ms);
> +}
> +
> +static void create_fdt_iommu_sys(RISCVServerRefMachineState *s,
> +                                 uint32_t irq_chip,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *iommu_sys_phandle)
> +{
> +    const char comp[] = "riscv,iommu";
> +    void *fdt = MACHINE(s)->fdt;
> +    uint32_t iommu_phandle;
> +    g_autofree char *iommu_node = NULL;
> +    hwaddr addr = s->memmap[RVSERVER_IOMMU_SYS].base;
> +    hwaddr size = s->memmap[RVSERVER_IOMMU_SYS].size;
> +    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
> +    };
> +
> +    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx,
> +                                 s->memmap[RVSERVER_IOMMU_SYS].base);
> +    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
> +                           addr >> 32, addr, size >> 32, size);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
> +
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
> +        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
> +
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
> +
> +    *iommu_sys_phandle = iommu_phandle;
> +}
> +
> +static void create_fdt_pcie(RISCVServerRefMachineState *s,
> +                            const MemMapEntry *memmap,
> +                            uint32_t irq_pcie_phandle,
> +                            uint32_t msi_pcie_phandle,
> +                            uint32_t iommu_sys_phandle)
> +{
> +    g_autofree char *name = NULL;
> +    MachineState *ms = MACHINE(s);
> +
> +    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_PCIE_ECAM].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
> +        FDT_PCI_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> +        FDT_PCI_INT_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "pci-host-ecam-generic");
> +    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
> +        memmap[RVSERVER_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
> +        memmap[RVSERVER_PCIE_ECAM].base, 0, memmap[RVSERVER_PCIE_ECAM].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> +        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +        2, memmap[RVSERVER_PCIE_PIO].base, 2, memmap[RVSERVER_PCIE_PIO].size,
> +        1, FDT_PCI_RANGE_MMIO,
> +        2, memmap[RVSERVER_PCIE_MMIO].base,
> +        2, memmap[RVSERVER_PCIE_MMIO].base, 2, memmap[RVSERVER_PCIE_MMIO].size,
> +        1, FDT_PCI_RANGE_MMIO_64BIT,
> +        2, memmap[RVSERVER_PCIE_MMIO_HIGH].base,
> +        2, memmap[RVSERVER_PCIE_MMIO_HIGH].base, 2,
> +           memmap[RVSERVER_PCIE_MMIO_HIGH].size);
> +
> +    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> +
> +    qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> +                           0, iommu_sys_phandle, 0, 0x10000);
> +}
> +
> +static void create_fdt_reset(RISCVServerRefMachineState *s,
> +                             const MemMapEntry *memmap,
> +                             uint32_t *phandle)
> +{
> +    char *name;
> +    uint32_t test_phandle;
> +    MachineState *ms = MACHINE(s);
> +
> +    test_phandle = (*phandle)++;
> +    name = g_strdup_printf("/soc/reset_syscon@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_RESET_SYSCON].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_RESET_SYSCON].base,
> +        0x0, memmap[RVSERVER_RESET_SYSCON].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
> +    test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/reboot");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_RESET);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/soc/poweroff");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_POWEROFF);
> +    g_free(name);
> +}
> +
> +static void create_fdt_uart(RISCVServerRefMachineState *s,
> +                            const MemMapEntry *memmap,
> +                            uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name = NULL;
> +    MachineState *ms = MACHINE(s);
> +
> +    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_UART0].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_UART0].base,
> +        0x0, memmap[RVSERVER_UART0].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +                          irq_mmio_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> +                           RVSERVER_UART0_IRQ, 0x4);
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +}
> +
> +static void create_fdt_rtc(RISCVServerRefMachineState *s,
> +                           const MemMapEntry *memmap,
> +                           uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name = NULL;
> +    MachineState *ms = MACHINE(s);
> +
> +    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_RTC].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "google,goldfish-rtc");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_RTC].base, 0x0, memmap[RVSERVER_RTC].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +                          irq_mmio_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> +                           RVSERVER_RTC_IRQ, 0x4);
> +}
> +
> +static void create_fdt_flash(RISCVServerRefMachineState *s,
> +                             const MemMapEntry *memmap)
> +{
> +    MachineState *ms = MACHINE(s);
> +    hwaddr flashsize = rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
> +    hwaddr flashbase = rvserver_ref_memmap[RVSERVER_FLASH].base;
> +    g_autofree char *name = g_strdup_printf("/flash@%"HWADDR_PRIx, flashbase);
> +
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +                                 2, flashbase, 2, flashsize,
> +                                 2, flashbase + flashsize, 2, flashsize);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
> +}
> +
> +static void finalize_fdt(RISCVServerRefMachineState *s)
> +{
> +    uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> +    uint32_t irq_pcie_phandle = 1, iommu_sys_phandle;
> +
> +    create_fdt_sockets(s, rvserver_ref_memmap, &phandle, &irq_mmio_phandle,
> +                       &irq_pcie_phandle, &msi_pcie_phandle);
> +
> +    create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
> +                         &iommu_sys_phandle);
> +
> +    create_fdt_pcie(s, rvserver_ref_memmap, irq_pcie_phandle,
> +                    msi_pcie_phandle, iommu_sys_phandle);
> +
> +    create_fdt_reset(s, rvserver_ref_memmap, &phandle);
> +
> +    create_fdt_uart(s, rvserver_ref_memmap, irq_mmio_phandle);
> +
> +    create_fdt_rtc(s, rvserver_ref_memmap, irq_mmio_phandle);
> +}
> +
> +static void create_fdt(RISCVServerRefMachineState *s,
> +                       const MemMapEntry *memmap)
> +{
> +    MachineState *ms = MACHINE(s);
> +    uint8_t rng_seed[32];
> +
> +    ms->fdt = create_device_tree(&s->fdt_size);
> +    if (!ms->fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/", "model", "qemu,riscv-server-ref");
> +    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-server-ref");
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
> +
> +    /*
> +     * This versioning scheme is for informing platform fw only. It is neither:
> +     * - A QEMU versioned machine type; a given version of QEMU will emulate
> +     *   a given version of the platform.
> +     * - A reflection of level of server platform support provided.
> +     *
> +     * machine-version-major: updated when changes breaking fw compatibility
> +     *                        are introduced.
> +     * machine-version-minor: updated when features are added that don't break
> +     *                        fw compatibility.
> +     *
> +     * It's the same as the scheme in arm sbsa-ref.
> +     */
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-major", 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-minor", 0);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc");
> +    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus");
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/chosen");
> +
> +    /* Pass seed to RNG */
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
> +                     rng_seed, sizeof(rng_seed));
> +
> +    create_fdt_flash(s, memmap);
> +    create_fdt_pmu(s);
> +
> +}
> +
> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
> +                                          DeviceState *irqchip,
> +                                          RISCVServerRefMachineState *s)
> +{
> +    DeviceState *dev;
> +    PCIHostState *pci;
> +    PCIDevice *pdev_ahci;
> +    AHCIPCIState *ich9;
> +    DriveInfo *hd[NUM_SATA_PORTS];
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> +    hwaddr ecam_base = rvserver_ref_memmap[RVSERVER_PCIE_ECAM].base;
> +    hwaddr ecam_size = rvserver_ref_memmap[RVSERVER_PCIE_ECAM].size;
> +    hwaddr mmio_base = rvserver_ref_memmap[RVSERVER_PCIE_MMIO].base;
> +    hwaddr mmio_size = rvserver_ref_memmap[RVSERVER_PCIE_MMIO].size;
> +    hwaddr high_mmio_base = rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIGH].base;
> +    hwaddr high_mmio_size = rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIGH].size;
> +    hwaddr pio_base = rvserver_ref_memmap[RVSERVER_PCIE_PIO].base;
> +    hwaddr pio_size = rvserver_ref_memmap[RVSERVER_PCIE_PIO].size;
> +    MachineClass *mc = MACHINE_GET_CLASS(s);
> +    qemu_irq irq;
> +    int i;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
> +                            ecam_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
> +                            ecam_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
> +                             mmio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)),
> +                            PCI_HOST_BELOW_4G_MMIO_SIZE,
> +                            mmio_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
> +                             high_mmio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)),
> +                            PCI_HOST_ABOVE_4G_MMIO_SIZE,
> +                            high_mmio_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
> +                            pio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
> +                            pio_size, NULL);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, ecam_size);
> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
> +
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, mmio_base, mmio_size);
> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
> +
> +    /* Map high MMIO space */
> +    high_mmio_alias = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
> +                             mmio_reg, high_mmio_base, high_mmio_size);
> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
> +                                high_mmio_alias);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> +
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        irq = qdev_get_gpio_in(irqchip, RVSERVER_PCIE_IRQ + i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSERVER_PCIE_IRQ + i);
> +    }
> +
> +    pci = PCI_HOST_BRIDGE(dev);
> +    pci_init_nic_devices(pci->bus, mc->default_nic);
> +    /* IDE disk setup.  */
> +    pdev_ahci = pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
> +    ich9 = ICH9_AHCI(pdev_ahci);
> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
> +    ide_drive_get(hd, ich9->ahci.ports);
> +    ahci_ide_create_devs(&ich9->ahci, hd);
> +
> +    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(GPEX_HOST(dev))->bus;
> +    return dev;
> +}
> +
> +static DeviceState *rvserver_ref_create_aia(int aia_guests,
> +                                            const MemMapEntry *memmap,
> +                                            int socket,
> +                                            int base_hartid, int hart_count)
> +{
> +    int i;
> +    hwaddr addr;
> +    uint32_t guest_bits;
> +    DeviceState *aplic_s = NULL;
> +    DeviceState *aplic_m = NULL;
> +    bool msimode = true;
> +
> +    /* Per-socket M-level IMSICs */
> +    addr = memmap[RVSERVER_IMSIC_M].base +
> +           socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
> +    for (i = 0; i < hart_count; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> +                           base_hartid + i, true, 1,
> +                           RVSERVER_IRQCHIP_NUM_MSIS);
> +    }
> +
> +    /* Per-socket S-level IMSICs */
> +    guest_bits = imsic_num_bits(aia_guests + 1);
> +    addr = memmap[RVSERVER_IMSIC_S].base +
> +           socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
> +    for (i = 0; i < hart_count; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> +                           base_hartid + i, false, 1 + aia_guests,
> +                           RVSERVER_IRQCHIP_NUM_MSIS);
> +    }
> +
> +    /* Per-socket M-level APLIC */
> +    aplic_m = riscv_aplic_create(memmap[RVSERVER_APLIC_M].base +
> +                                 socket * memmap[RVSERVER_APLIC_M].size,
> +                                 memmap[RVSERVER_APLIC_M].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 RVSERVER_IRQCHIP_NUM_SOURCES,
> +                                 RVSERVER_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, true, NULL);
> +
> +    /* Per-socket S-level APLIC */
> +    aplic_s = riscv_aplic_create(memmap[RVSERVER_APLIC_S].base +
> +                                 socket * memmap[RVSERVER_APLIC_S].size,
> +                                 memmap[RVSERVER_APLIC_S].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 RVSERVER_IRQCHIP_NUM_SOURCES,
> +                                 RVSERVER_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, false, aplic_m);
> +
> +    (void)aplic_s;
> +    return aplic_m;
> +}
> +
> +static uint64_t rvserver_reset_syscon_read(void *opaque, hwaddr addr,
> +                                           unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void rvserver_reset_syscon_write(void *opaque, hwaddr addr,
> +                                        uint64_t val64, unsigned int size)
> +{
> +    switch (val64) {
> +    case SYSCON_POWEROFF:
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        return;
> +    case SYSCON_RESET:
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        return;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps rvserver_reset_syscon_ops = {
> +    .read = rvserver_reset_syscon_read,
> +    .write = rvserver_reset_syscon_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN
> +};
> +
> +static void rvserver_ref_machine_done(Notifier *notifier, void *data)
> +{
> +    RISCVServerRefMachineState *s = container_of(
> +        notifier, RISCVServerRefMachineState, machine_done);
> +    const MemMapEntry *memmap = rvserver_ref_memmap;
> +    MachineState *machine = MACHINE(s);
> +    hwaddr start_addr = memmap[RVSERVER_DRAM].base;
> +    target_ulong firmware_end_addr, kernel_start_addr;
> +    const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
> +    uint64_t fdt_load_addr;
> +    uint64_t kernel_entry = 0;
> +    BlockBackend *pflash_blk0;
> +    RISCVBootInfo boot_info;
> +
> +    /*
> +     * An user provided dtb must include everything, including
Nit: s/An user/A user

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +     * dynamic sysbus devices. Our FDT needs to be finalized.
> +     */
> +    if (machine->dtb == NULL) {
> +        finalize_fdt(s);
> +    }
> +
> +    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
> +                                                     &start_addr, NULL);
> +
> +    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
> +    if (pflash_blk0) {
> +        if (machine->firmware && !strcmp(machine->firmware, "none")) {
> +            /*
> +             * Pflash was supplied but bios is none and not KVM guest,
> +             * let's overwrite the address we jump to after reset to
> +             * the base of the flash.
> +             */
> +            start_addr = rvserver_ref_memmap[RVSERVER_FLASH].base;
> +        } else {
> +            /*
> +             * Pflash was supplied but either KVM guest or bios is not none.
> +             * In this case, base of the flash would contain S-mode payload.
> +             */
> +            riscv_setup_firmware_boot(machine);
> +            kernel_entry = rvserver_ref_memmap[RVSERVER_FLASH].base;
> +        }
> +    }
> +
> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
> +
> +    if (machine->kernel_filename && !kernel_entry) {
> +        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
> +                                                         firmware_end_addr);
> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
> +        kernel_entry = boot_info.image_low_addr;
> +    }
> +
> +    fdt_load_addr = riscv_compute_fdt_addr(memmap[RVSERVER_DRAM].base,
> +                                           memmap[RVSERVER_DRAM].size,
> +                                           machine, &boot_info);
> +
> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
> +
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
> +                              rvserver_ref_memmap[RVSERVER_MROM].base,
> +                              rvserver_ref_memmap[RVSERVER_MROM].size,
> +                              kernel_entry,
> +                              fdt_load_addr);
> +
> +}
> +
> +static bool rvserver_aclint_allowed(void)
> +{
> +    return tcg_enabled() || qtest_enabled();
> +}
> +
> +static void rvserver_ref_machine_init(MachineState *machine)
> +{
> +    const MemMapEntry *memmap = rvserver_ref_memmap;
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> +    MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
> +    DeviceState *mmio_irqchip, *pcie_irqchip, *iommu_sys;
> +    int i, base_hartid, hart_count;
> +    int socket_count = riscv_socket_count(machine);
> +
> +    /* Check socket count limit */
> +    if (RVSERVER_SOCKETS_MAX < socket_count) {
> +        error_report("number of sockets/nodes should be less than %d",
> +            RVSERVER_SOCKETS_MAX);
> +        exit(1);
> +    }
> +
> +    if (!rvserver_aclint_allowed()) {
> +        error_report("'aclint' is only available with TCG acceleration");
> +        exit(1);
> +    }
> +
> +    /* Initialize sockets */
> +    mmio_irqchip = pcie_irqchip = NULL;
> +    for (i = 0; i < socket_count; i++) {
> +        g_autofree char *soc_name = g_strdup_printf("soc%d", i);
> +
> +        if (!riscv_socket_check_hartids(machine, i)) {
> +            error_report("discontinuous hartids in socket%d", i);
> +            exit(1);
> +        }
> +
> +        base_hartid = riscv_socket_first_hartid(machine, i);
> +        if (base_hartid < 0) {
> +            error_report("can't find hartid base for socket%d", i);
> +            exit(1);
> +        }
> +
> +        hart_count = riscv_socket_hart_count(machine, i);
> +        if (hart_count < 0) {
> +            error_report("can't find hart count for socket%d", i);
> +            exit(1);
> +        }
> +
> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
> +                                TYPE_RISCV_HART_ARRAY);
> +        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
> +                                machine->cpu_type, &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
> +                                base_hartid, &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
> +                                hart_count, &error_abort);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
> +
> +        /* Per-socket ACLINT MTIMER */
> +        riscv_aclint_mtimer_create(memmap[RVSERVER_ACLINT].base +
> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +            base_hartid, hart_count,
> +            RISCV_ACLINT_DEFAULT_MTIMECMP,
> +            RISCV_ACLINT_DEFAULT_MTIME,
> +            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> +
> +        /* Per-socket interrupt controller */
> +        s->irqchip[i] = rvserver_ref_create_aia(s->aia_guests,
> +                                                memmap, i, base_hartid,
> +                                                hart_count);
> +
> +        /* Try to use different IRQCHIP instance based device type */
> +        if (i == 0) {
> +            mmio_irqchip = s->irqchip[i];
> +            pcie_irqchip = s->irqchip[i];
> +        }
> +        if (i == 1) {
> +            pcie_irqchip = s->irqchip[i];
> +        }
> +    }
> +
> +    s->memmap = rvserver_ref_memmap;
> +
> +    /* register system main memory (actual RAM) */
> +    memory_region_add_subregion(system_memory, memmap[RVSERVER_DRAM].base,
> +        machine->ram);
> +
> +    /* boot rom */
> +    memory_region_init_rom(mask_rom, NULL, "riscv_rvserver_ref_board.mrom",
> +                           memmap[RVSERVER_MROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[RVSERVER_MROM].base,
> +                                mask_rom);
> +
> +    memory_region_init_io(reset_syscon_io, NULL, &rvserver_reset_syscon_ops,
> +                          NULL, "reset_syscon_io",
> +                          memmap[RVSERVER_RESET_SYSCON].size);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[RVSERVER_RESET_SYSCON].base,
> +                                reset_syscon_io);
> +
> +    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +
> +    serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
> +        0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
> +        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    sysbus_create_simple("goldfish_rtc", memmap[RVSERVER_RTC].base,
> +        qdev_get_gpio_in(mmio_irqchip, RVSERVER_RTC_IRQ));
> +
> +    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
> +        /* Map legacy -drive if=pflash to machine properties */
> +        pflash_cfi01_legacy_drive(s->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
> +    }
> +    rvserver_flash_maps(s, system_memory);
> +
> +    /* load/create device tree */
> +    if (machine->dtb) {
> +        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
> +        if (!machine->fdt) {
> +            error_report("load_device_tree() failed");
> +            exit(1);
> +        }
> +    } else {
> +        create_fdt(s, memmap);
> +    }
> +
> +    iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
> +    object_property_set_uint(OBJECT(iommu_sys), "addr",
> +                             s->memmap[RVSERVER_IOMMU_SYS].base,
> +                             &error_fatal);
> +
> +    object_property_set_uint(OBJECT(iommu_sys), "base-irq",
> +                             IOMMU_SYS_IRQ,
> +                             &error_fatal);
> +
> +    object_property_set_link(OBJECT(iommu_sys), "irqchip",
> +                             OBJECT(mmio_irqchip),
> +                             &error_fatal);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
> +
> +    s->machine_done.notify = rvserver_ref_machine_done;
> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> +}
> +
> +static void rvserver_ref_machine_instance_init(Object *obj)
> +{
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
> +
> +    s->flash[0] = rvserver_flash_create(s, "riscv-server-ref.flash0",
> +                                        "pflash0");
> +    s->flash[1] = rvserver_flash_create(s, "riscv-server-ref.flash1",
> +                                        "pflash1");
> +}
> +
> +static char *rvserver_ref_get_aia_guests(Object *obj, Error **errp)
> +{
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
> +    char val[32];
> +
> +    sprintf(val, "%d", s->aia_guests);
> +    return g_strdup(val);
> +}
> +
> +static void rvserver_ref_set_aia_guests(Object *obj, const char *val,
> +                                        Error **errp)
> +{
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
> +
> +    s->aia_guests = atoi(val);
> +    if (s->aia_guests < 0 || s->aia_guests > RVSERVER_IRQCHIP_MAX_GUESTS) {
> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
> +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
> +                          RVSERVER_IRQCHIP_MAX_GUESTS);
> +    }
> +}
> +
> +static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    char str[128];
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +        TYPE_RISCV_CPU_RVSERVER_REF,
> +    };
> +
> +    mc->desc = "RISC-V Server SoC Reference board";
> +    mc->init = rvserver_ref_machine_init;
> +    mc->max_cpus = RVSERVER_CPUS_MAX;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSERVER_REF;
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mc->pci_allow_0_address = true;
> +    mc->default_nic = "e1000e";
> +    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
> +    mc->numa_mem_supported = true;
> +    /* platform instead of architectural choice */
> +    mc->cpu_cluster_has_numa_boundary = true;
> +    mc->default_ram_id = "riscv_rvserver_ref_board.ram";
> +
> +    object_class_property_add_str(oc, "aia-guests",
> +                                  rvserver_ref_get_aia_guests,
> +                                  rvserver_ref_set_aia_guests);
> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
> +                 "should be between 0 and %d.", RVSERVER_IRQCHIP_MAX_GUESTS);
> +    object_class_property_set_description(oc, "aia-guests", str);
> +}
> +
> +static const TypeInfo rvserver_ref_typeinfo = {
> +    .name       = TYPE_RISCV_SERVER_REF_MACHINE,
> +    .parent     = TYPE_MACHINE,
> +    .class_init = rvserver_ref_machine_class_init,
> +    .instance_init = rvserver_ref_machine_instance_init,
> +    .instance_size = sizeof(RISCVServerRefMachineState),
> +    .interfaces = riscv64_machine_interfaces,
> +};
> +
> +static void rvserver_ref_init_register_types(void)
> +{
> +    type_register_static(&rvserver_ref_typeinfo);
> +}
> +
> +type_init(rvserver_ref_init_register_types)


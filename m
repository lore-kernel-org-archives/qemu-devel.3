Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742ADC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemAJ-0006gs-58; Wed, 01 Jul 2026 00:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wemAG-0006fv-WD; Wed, 01 Jul 2026 00:03:09 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wemAF-000451-6N; Wed, 01 Jul 2026 00:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxTMgb9KN49ltDWGu36ZneMuWtKMnGLRjeW/xIdU3qvHnuccEHQjf7/X8arAG7msYq6EBalsnCr2AvIRBDp/iXv4RMciTUVD4L1TYOY2+gM4/u2atiNy6uj1wb8EzG95xD4ZKF/UUex++zVUf9tRsWfAPitLYTIwvFENjAhdSzdaU+Qsgiw3Z8Gl0IaTvfpyqfG0IXquJgE8ZaxNHsSaSAx8pEOZ+l3RDnHo9ozkpem4qqC0FVS2f6Pei9wEJzCvPMTL0NEqNbqAEtQIndCqjHWfiRTQ7XmzfFPVJxXDLEly7YGyGoFkdG2+6IJPaCdamd+TdT47j4m/O0HIZRDh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eOtNNzqFsVBhUC4eEs+vRlGWPm7KvQVmrCvzIQhwSw=;
 b=pr9pOBcy4xmRDXuMRqEynWbz3XT9cBGHLa+OzJEigrHLDnUUcPUgalLG3omCrntvMBq1RTXxnOvyinb9kgVVSdbVGj9nfMAHoJH8I2EG7Vg2r8uUsIApWVOfDaM6ntK7dSd4gedmxwVhIHzr+AWo1qK685o4itdr28EnA1X1Hd1YBatjpCfn3BkDL06Jwosca6N6Epk2urtRK+aeI0wPn+cI9UlwRwG4AjHSrsswbIfYIk0v4T+D4o87DGvgrHiZV6KUlinc/E8SAKGTpufi//TD8fW4p4XgKQF0AkG4ZghX2He8Bu0Q5OE6yB0byMHLuLWoXRMKuvdK3rnm2N+ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eOtNNzqFsVBhUC4eEs+vRlGWPm7KvQVmrCvzIQhwSw=;
 b=ZMuIf7BfuGd8/yj6WtW10cpDkJ5vKLzZmroVybJclsyPwFuN0F0eQOMYjD6UjuA2Ma+UJC1j+15wwSX+Pds6eDJZE4nIWty7m7w9iv+V0JceHSCKntSZIZIt3TTyP7cN+7lMXkxl8nZvhS4tqyI17Vb1ASOE+ZpfiY/ICGulQLhNKUcH1YZ+5tm0mZiuQ48BAskI1LF8Dmv47ifeX4W5mMkxIVD5qzR+ROEa9n4e+S28bYvXi13CEIKJKkS/VCqZOfgx+khbFSiyXuWtLpHHlBsy3G0+1jOOVzhWP8L5IEJXS4+A3zJj+8kTvYFwFJ5a5/KBnThd18wp6mcGbFRGOw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEZPR04MB7458.apcprd04.prod.outlook.com (2603:1096:101:1eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 04:02:58 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:02:58 +0000
Message-ID: <SE3PR04MB892210C486C30552B7FCCE09F3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 1 Jul 2026 12:02:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260630203155.2103084-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260630203155.2103084-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <ea550e57-95a7-4049-ba68-b83948403a70@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEZPR04MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 671f50a4-102d-4498-cb0d-08ded725a2f8
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|15080799012|8060799015|19110799012|41001999006|23021999003|19101099003|6090799003|12121999013|55001999006|5072599009|25010399006|10035399007|40105399003|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG5wWkZFVVdvZW96eGRFR3hLcWJCSHRPaDV0bW8zRFBJeHE0aHl0ZXI5MFdy?=
 =?utf-8?B?ZElFanpzQU93TEhrZlBUUW9tMys3Rk5xK05BRTV0eGE3d3N2NU9wb0lUdUdi?=
 =?utf-8?B?eW1MZHZtSThhcHI5TUs1bmI3Uk5GTjBSbHYxclJGV0hoWVNHZUJ4amd0K0pF?=
 =?utf-8?B?ZnZERmNQemxLL1hldEtEREMzM21QM1VKYlRnVnh1SDk2TjdRYlJ0U0hRYU9s?=
 =?utf-8?B?S3diVFAxUEFqa2Npa283TEJKRDJwZGpQSitlNjVPYzczdjBNcXZiMkkyUzVP?=
 =?utf-8?B?dHZ1U0s4K2ZPQmpldDdncnpyejBSOWlGZGZiK051RlpUSVZYZzFFTWVVZnVN?=
 =?utf-8?B?cUhudFR1N2ZoVzU0Q0MxMVVPS2N0dkwvTktyTE9QTzlWc1lFaGpEUWp1K1hV?=
 =?utf-8?B?bHBRMHJSZlJ6UDVqbnNrTmZLY1VmZFJVU1QwNk9HS0NmWTFoZXNRbDFQOXg1?=
 =?utf-8?B?WVBaT0o2UzFWN1Z1OHVJOHA3bkpoMnlDK083OWlua0pGeXVsc2MzZncyZDlS?=
 =?utf-8?B?NU45UHFUT0owUi9mZDVSbTZ0VEErUk9XUGl4MEVJNWQ2d1piZEtKK3JJYnYr?=
 =?utf-8?B?Zy92WlVTa2VTLzd0MW5PZFZTT2FMeWZRM0NWUHVvZkJna1kzbk1qbXJzalcv?=
 =?utf-8?B?YUFmOVNYODNxemhSVGtEU3lSK0RvSStydTEvVDJReGh5UUNWc3FHc1FnYUxr?=
 =?utf-8?B?L3JsQjlTaTFxa3FaaW1LM1JJYkFDaFFjZFREY092UHZ3d2pNT0xQOFFEMXgz?=
 =?utf-8?B?czVVMVBXcGFlK1NnMERINDZ2b01vZU5RSlZNZS9RVFhIRC9nZm1YTG9Xb2dn?=
 =?utf-8?B?MWt2OHZsdkVORkt2eVJwaFRPeXVwN0lobGp5YStTK0UvK3NLc3F0ZlFacGc4?=
 =?utf-8?B?SWhRWUhsQ2xMSjZLYW13cGlwWnVJWW1zMEVnT2sxS1NwVzh2S3lLTDZPUlVj?=
 =?utf-8?B?K2JieTNFbHVCaWpNWWtpSUxWdEJBUkFFZzBLYStGZlRMM1UwQTNRV2VDYmcz?=
 =?utf-8?B?Ujc5WWxwRkRtZk4zMUd5SmEvOGFSWkFlNmg4dW85US93eldNM3lJZ3FlYUxE?=
 =?utf-8?B?Wkt6dzVjMnhxK2g1eGRIU1B6M2hrYk5nbXM4NkI2Y3hEQVk1T2F3WXc1RlBm?=
 =?utf-8?B?YUM4TmZBVkVJdUJreDlRV25VKzc5Ly93YmdsQ29MMUFwSy9NNCtCZnlCL29k?=
 =?utf-8?B?SGtLclFUWHhlL3Z0anc4Q2xpbEFKeWpQd1dXeXRjSGhFQVlLTk9Oc0Y5MWFO?=
 =?utf-8?B?Y2JhNlNGL3laa1NRTnlQRk1tZms4aWVPdzlDLzYveUR3eHhVSHBwUDBSM3l2?=
 =?utf-8?B?S3l5WDcwMUVGZmxjdWhiS2FRWW1tMVFORGNRWWlKdTU2eERUTTJoZWpnSVJK?=
 =?utf-8?B?NWl6SUNxOFBWaHZ3cnJpLzY0cm1OTUhIVUhOSlRLNnU2UDIvalhVQzFLaW9s?=
 =?utf-8?B?eUtmSE1vY2o2WGV1SXZNODNCcWxkQXE2NmsrazcxOHIreDN0eUgxZ1lpU2Nr?=
 =?utf-8?B?OVZ4QW81N3l0dHJXRmFtS2VzdXJMdm5kdnhqTTgzRlNEdjVYZDhuWE5BYjl1?=
 =?utf-8?Q?H+sKvc67sy7nP5jteO/Ny8vMU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FnQ29Ub3FuZElEeDMyQzlFVDd2ajA2eUdCZlZJUHNRbWdpVFhuR2UzQXJR?=
 =?utf-8?B?MlpxSnNsbjMxV3B6NUY5S05WNHl5YnVKNEExWVJaQzYvQkV3UFh1eEFNcW8v?=
 =?utf-8?B?ZFVvQXZWVWpsMnBLaFBTY0hQZTdzQzZiRFBZdVN0RTc0cENhcVhEcGdVeGpG?=
 =?utf-8?B?T3RWVStaRFlpckxMMFpKZ0pxL2hCb1o3NDBiRDl6M2RDQUNrRm8wV01tUlJF?=
 =?utf-8?B?RE4rR3hCVG9GVERienpVcXZvRlRwei9YNnBlTmsxeUxSQkhtcDFvenVLUXBw?=
 =?utf-8?B?S0FmTzR2R0RYUCtjNFlCbWJnZnFTYlpEY1V6d1ZTWFl3WE42TW9vcXJkT054?=
 =?utf-8?B?aW5jOTlmWGtiV1FmTXY3Yk04Zzh2eHZyS1N4OVpIN2kxVjlTQmM5anpGR2x4?=
 =?utf-8?B?c1V0Q3ZEN0N3UFBVK3R4dGFaWXhzaThyd0doWEFjdXFHMXB6RlRuQ21TNlBm?=
 =?utf-8?B?dlJrakFjNkU3aVF3WW11enlpTEx2MnlBdURrV1ZRaU0zOTNaRWYvdjFjRVYr?=
 =?utf-8?B?eWQ3RVhMSHZmc1IwdnZsZEZkZ3hTdUJFZHhNWnBhbE01b2prSkRuVXZsUE16?=
 =?utf-8?B?TDkwYVljRW5PeWQrdk9PZXlyM0doRUQ5c3RrOWVROFFwYW1Kd1ZORzJnUXdo?=
 =?utf-8?B?UC83djFrY1c1YzA4QWFkb1JCbGtxS0ViYk9aSWQ5U3pLN0IyOTdBbXhnNld6?=
 =?utf-8?B?cGZZbTZVNkNoYldkdFhjY3drRTVKeUNad3N1M2p1d0hERmRpS0lvQ1J0U0JG?=
 =?utf-8?B?Qk9nUUFFb3BWTjNla3ZNUGt2SkQrMWFNc05ETWg2N0FSaU9yQTZNTFZ0Vjh5?=
 =?utf-8?B?RjZUNEJBUVBTcHpDUHpvV1FqcVpmdzNvSkJqVTdvQWxFbmxZOE5RY2JvK0th?=
 =?utf-8?B?VzluZWREd1Y3UFZ4d1NJTE5VWitKd0JxZ1NBa2RPczVCRmRUTnJtcDQrZ0Fn?=
 =?utf-8?B?TkJWTkcwbHNqc3FmQUVsYUUydzJyYjJJZGFxNzRaZTgvU3JUT0w4RklEbFAx?=
 =?utf-8?B?SU1sWUpJVmhwRERLUk51TEpKRG1rTUdxRC81RXNtV3QwM2JMcGpuTVV5bldC?=
 =?utf-8?B?U3IrZkpRVGszK05yam93T1BPNHlwblFUNUx2dll0UDlOaEQ2bzRVVTdpTFBw?=
 =?utf-8?B?amdXK3M4Wk5kUE1RYkhsNk1GbkZ0SDFVblV3eTZlUnE4L2F0ZmQ0Z1JiZmUv?=
 =?utf-8?B?QU0vVGhzQVdSVDMwVWtrVzB0SVRLMGh5V2o2RjBTYXpXbXV3REpDampueXJT?=
 =?utf-8?B?M28zTnlKUW44RnFSby9nWEYyMmhZQnlTdjRjQXNhOGwvMGhRdW9IbGNJTDBC?=
 =?utf-8?B?aUYxN2FyekNMT0cwR0NidDdraEdyU1RwaFRzcXhXNEdneGd2NjJRblVnYVc2?=
 =?utf-8?B?R1RNanB0ZkNBMTY4U2pUcUY5anVET3YrcnhXdFNUaDVxVkJnQzY3WDNNbWFV?=
 =?utf-8?B?d09pMVd0QTZORSt4UEdzdHlXclNUM1lGN0hpT0dJMXIyTC9oS0c4Sy90OCtz?=
 =?utf-8?B?VnFFVkxnMVRXZm1jUys2dkFPNSt1QlFHa2NxdTQwNlpiZnJ0TFdkdHF2dy8w?=
 =?utf-8?B?M1UvcHE1TTgwS29mZkU3c1lWTlcva2dGZlZ5SjZOQXZSWXAyNnYrS09XcHpl?=
 =?utf-8?B?TVVMcVFFZUU4OFZFYjhBY3REY0YrT3JCS05QVUpDc042Qms1aWI2cGtENWth?=
 =?utf-8?B?Q2RVcmhVdTNiZFJZY1ZvTThvZnRodWdGMTlqajRQSXcrdWpaMjNrbFhaSEp6?=
 =?utf-8?B?SWNMdnUyZ3NhUWNMbmYxbGozbTBzanBPeXJCYkozdHNQTytjZW9jWVZUdnZ2?=
 =?utf-8?B?YThJTVRvUUFQejcrZDhPTVE5eHFJMjlpOXY5dEsxdGtxZnpqay9wY0pjUk53?=
 =?utf-8?Q?p8TJlctMhHNzS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 671f50a4-102d-4498-cb0d-08ded725a2f8
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:02:58.7291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7458
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


On 7/1/2026 4:31 AM, Daniel Henrique Barboza wrote:
> We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.
>
> qos-riscv-iommu.h needs change too since G_IOHGATP must now be 16kb
> aligned too.
>
> Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/riscv-iommu.c               | 14 ++++++++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h |  2 +-
>   2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 891a56e731..09990c640f 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -795,6 +795,20 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
>           return false;
>       }
>   
> +    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
> +        uint64_t iohgatp_ppn = get_field(ctx->gatp,
> +                                         RISCV_IOMMU_DC_IOHGATP_PPN);
Seems it should be like the following:

+        uint64_t iohgatp_ppn = PPN_PHYS(get_field(ctx->gatp,
+                                        RISCV_IOMMU_DC_IOHGATP_PPN));

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +        /*
> +         * One of the conditions for a misconfigured DDT entry
> +         * according to the riscv-spec: "DC.iohgatp.MODE is not
> +         * Bare and the root page table determined by DC.iohgatp.PPN
> +         * is not aligned to a 16-KiB boundary."
> +         */
> +        if (iohgatp_ppn & ((1ULL << 14) - 1)) {
> +            return false;
> +        }
> +    }
> +
>       fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
>   
>       if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
> diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
> index 90e69a5d73..4a972401f5 100644
> --- a/tests/qtest/libqos/qos-riscv-iommu.h
> +++ b/tests/qtest/libqos/qos-riscv-iommu.h
> @@ -46,7 +46,7 @@
>   #define QRIOMMU_L1_PTE_VAL          0x0000000000012000ull
>   #define QRIOMMU_L2_PTE_VAL          0x0000000000013000ull
>   
> -#define QRIOMMU_G_IOHGATP           0x0000000000020000ull
> +#define QRIOMMU_G_IOHGATP           0x0000000008000000ull
>   #define QRIOMMU_G_L0_PTE_VAL        0x0000000000021000ull
>   #define QRIOMMU_G_L1_PTE_VAL        0x0000000000022000ull
>   


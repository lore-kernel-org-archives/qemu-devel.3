Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D18CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 06:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOra8-0005nV-HB; Mon, 18 May 2026 02:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wOra4-0005mx-Bu; Mon, 18 May 2026 02:36:00 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wOra2-0002I9-M9; Mon, 18 May 2026 02:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4GaJ3sx9M/8+2Z+58bZeqsOqF3NAdxqYmBD/gA0uo1nL9k++BnGcqFDHwd8LBj610ZYB0fQNC/lUA+Rxh+rHmxOx/b6S7wFpRKjaqUNf1+Qf1ADKQbfnxMb3nfJSlpAomZQN9hQ1Z8jTF5jqhPre4sHICrv4tWsmJdpEeTCCgCKxOMLTB5p8RcVM897V7/0joGcWbu1QPgZ6+0/WeA10H9ToBUZmD4ahSOTPkWgM3lpJLMTXH46OA5ycgD7WRgkja3bRINcdrPztM1krp3uRElR+4V93wcxU9XTW+02n8j/uZvWtU8m0+SSadameqTUu7hCeoeC1emGaY8ABGqBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frJ/eWSgfFslY/hq1J9QE9laJdPRLVmxjGeHwfW19e8=;
 b=sgnzRHAccPd7XRjXP+k8NdriXu52FHWF/c/IGyjV7UQZ90JHDg1Ep8VV5RlMCo/qTJK7mJ51oZypqawE570NGb8j95NbEGQuEwFjbPyk9SYvQFu1RsZt+j8k+Np37LvxmNW4Nxqr4z1Dj4lUT1/2UT6PfSM6PuF2woXV3kLSfUBLdCctPzmOGwozOx9aQWWYxt3okvDtDWpPFdoYYV/gsixvEdou2DVkc1kIyywjZNTMleUiG42438bC2ApfOHMPQf1S2EtfWM9fBj0tqwxSSuLVw+bdxtLX5kTBHhsNxE/G8GYpet32GV3k79kwwDcDccjDrnjtzR4n36UF5j5rhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frJ/eWSgfFslY/hq1J9QE9laJdPRLVmxjGeHwfW19e8=;
 b=STEuDPmD9HfNDEHgbEiasT7notV4zQycEd39UycJZ8r3T4HNuC2QeYI/l5Ior6aZaelWMJRzR5+lsVtg6QbKuYJLWbdW1IGoiwUe2WWWXB0CbbGB4LhMG6T1OZLZ52rXKOVUFK3NGHJchQxyjG6dC9BMxMkTSCdsjojvG8YQMEF1vIQpi7slrHjpfRTRpMHs3OW39OZb4My7wFdRQpaCRH/CNsG6OFJJWvrbMNAW9liTffzTjeRAE3ICUD6mqkvJt7gYsP38v+fYhV1MJeZduvhquOsMsB1GW1DiIkfz4Ue9gRNLnvPq+NZ6MvqxF7D7iVCPjscAfLGO4iNbgdsd9w==
Received: from TYQPR04MB8919.apcprd04.prod.outlook.com (2603:1096:405:2ff::8)
 by SE1PPFAAD5227FC.apcprd04.prod.outlook.com (2603:1096:108:1::523)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 18 May
 2026 06:35:48 +0000
Received: from TYQPR04MB8919.apcprd04.prod.outlook.com
 ([fe80::9fd0:3e67:e02d:4a4f]) by TYQPR04MB8919.apcprd04.prod.outlook.com
 ([fe80::9fd0:3e67:e02d:4a4f%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 06:35:48 +0000
Message-ID: <TYQPR04MB8919C057B4964DA56DA7A341F3032@TYQPR04MB8919.apcprd04.prod.outlook.com>
Date: Mon, 18 May 2026 14:35:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
To: fangyu.yu@linux.alibaba.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, tjeznach@rivosinc.com
Cc: guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::12) To TYQPR04MB8919.apcprd04.prod.outlook.com
 (2603:1096:405:2ff::8)
X-Microsoft-Original-Message-ID: <cdab92d0-1151-448c-9ec4-bfc8445fb9a7@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYQPR04MB8919:EE_|SE1PPFAAD5227FC:EE_
X-MS-Office365-Filtering-Correlation-Id: 402cf9e7-e16e-4660-69e5-08deb4a7b28a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|6090799003|15080799012|23021999003|5072599009|41001999006|8060799015|51005399006|45011099003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0tGeHlHWmlrakI2SUJPNFRQUkNCM0krcTFrNCt1S1FGeWpSTXVZUzZWQlgr?=
 =?utf-8?B?Z2d1YS92MHBRWTJWZHRYZk4xRVNBV1oybGxoM21tajdVcUI0T0s0dmZyMzBr?=
 =?utf-8?B?VHVITGI2T1d4R0dkY2RBQ1lTZ3loNzVuend0VGp2T2RnRXoxTllqenlwZlo0?=
 =?utf-8?B?R0wydkpUVnVEd3BDOU1IQk1ESlNNeVZBRFpGK2NGZE9WNnExSG5NZ2ZxUE9P?=
 =?utf-8?B?Zi8vc1ZIdG8yTmV4ZTRIdksxQmJrNTFsT2dNRUM2VE54WTViWjdVMyt2NkdZ?=
 =?utf-8?B?RHBVekUvVUdUWVU1dVhkYWwrc1ZSTkR6Tmp6cjUvK3JRVXIvZDl3ZEd1SElL?=
 =?utf-8?B?VTRZblNvclBtK0p1bFJnenhGZmdyeGVMa0RZYzdCVWJ4ek5kWElZREdNd1Ux?=
 =?utf-8?B?Y3NTODdHZTcydFRQTHR2dEs1eGtPQllERHhXeTN0QUpXYXgvS2dITDhPTUVa?=
 =?utf-8?B?bHdadURnSWF3TjBleUkyS2k4OW1vbEZ0TTJMK25TdVh4MjlHRkRGVlFrc1dq?=
 =?utf-8?B?QWhzZXkzNVRjdmJPQ0pOdkZSdGlEb2JRVU1NbjVGSDU5T3R6ZXgwQnFYay9v?=
 =?utf-8?B?MS80MU5scHUvTjZHZFhYY3hnM1M2a2VpMGVPRjkrNDk3dEdBeTFmdk54QTUr?=
 =?utf-8?B?a3pWajhBOEp4bnZEUVo2M1R6TGZTMWlvQ2lRaVk4eXNoY05INDVwNFVtbUpT?=
 =?utf-8?B?dmlOaFNMQWY4bkRsakxYaC96UjdkZUp5Vk1tQXI4ekJsK0xrMlRQdWRyTWww?=
 =?utf-8?B?TW9jMWROTm1iUzVkbGdxT0p2ZUNqQ3NsdHRaU3RYUE9DSjBWN21lMGRld0tE?=
 =?utf-8?B?aUxNVURYYUtSZ0R6SHdGbWJkQ0tlYkNMVnlkdUxVbml6UEIreExEQXptclBn?=
 =?utf-8?B?b3B5bXNIVTJ2Wk91VEd1bktkQ2xwcTl2Q2w2VWNMM2Q5RG51TDl4L2VwcVdT?=
 =?utf-8?B?R05OTlJnNmU3RzZ3a1BKRlQ5eWxuYkh3OWlyZDVrUzJlNTJZMWxUWUM1R285?=
 =?utf-8?B?WkNKNEdOM2xueVV3UzVaQTRaYWVQMGkyUmZxNjJMb2lWbFhlQUxXR1p1bTN1?=
 =?utf-8?B?NXBFcW9kUkR3aTE0NEt1R0RDZ1hSRG5Ob1paMlVEbkVIbkI2UllZT202R052?=
 =?utf-8?B?OWlZdFNJQjQ3U2ttYmxmQnFJQlY2V20rLzBYdUNPRlYrZ2F6ZzBFejZsTmQx?=
 =?utf-8?B?TXFYZCs2bWw2WTVkUEJ1WnFkVFlFcXhJWlBvNEg0K2psQzZ4aXI3SE8zVy8w?=
 =?utf-8?B?bEdWWjV6RExEZFY3M29ES3NsdW9EdU9MVHpkcjlyRDdBc3NjT3ZnTmhVTHp2?=
 =?utf-8?Q?tgiUJq43vJyn8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXFtOEhwVW8xb3FhR3RqU2VNMkhtMTQzOVJLWWg1S1lOWldZdFpPalRPY0VE?=
 =?utf-8?B?dlBlWC83azREYlQwVHRBTFZKaExDeHgzeVpyVUZCU2Y3Sy9KRERnZGNWcSt5?=
 =?utf-8?B?eWMwd2MrMTRjZnpiQ0JpNXJEWUFXL0phWHFzeS9KaEFDMjQ0SEFMdXdYRmdm?=
 =?utf-8?B?T3hTdms1MjVkbGFoN0NGcjBNcGlyWlZuSjNaRlR4elUxR1ZvOHIxVG5iaURN?=
 =?utf-8?B?YjhLT3RrUlZDQVMwUGlyOW51YzlFSytiUVNsYVBXOGZvRTFWY1Z0TTZabHla?=
 =?utf-8?B?Vng0MlBxWTJSNVNPalRSWXRsMWRETnFLTnpUbGNkTkZkbEU5ZmhYWUlRbTRH?=
 =?utf-8?B?NUZXOHYvVVBQb3I2N3ZQVWl2YVlxZnV6S0VMbG1NazBydGlPenRLZ2V6b2JQ?=
 =?utf-8?B?WVNIY0VHY05YYU5DTjkxSzBCMWdLam10eGhDWVZUVDdaRWFJZjBDOXVIbFkz?=
 =?utf-8?B?RG1ETW5OMVJtOXJSbnAyd2swME54NG0xZFpLZjZSdU55bnAvblFjbUlKd2Qx?=
 =?utf-8?B?MU1zUzZSeTErY0NkWG93OHFuWGR1R2tQektlK3RKamJrZisyWjQrRU1YbXNN?=
 =?utf-8?B?RzRuSnRFSlRPdkpEV2pwVHZyVktnRFJ1SWJMS3dGNnE2T3l1Z2E4UlpvWitk?=
 =?utf-8?B?cVdwV1J1NlRST3ZYakptdEJVeDlJaGtGTWhuTmU4V3cxeC8xdFl5ZHhsejRx?=
 =?utf-8?B?eVhtMWZ2dkhMSVVDQlNzMzF4L2JkUDhpTkh6dzAvME91dDUvZ1pVZEtFOHg0?=
 =?utf-8?B?TFhwL0xVUkFGUFJtTzBRY1RtVC9BaVdZMUg5dDYzZU9CVVI5QUlRdE80cWRJ?=
 =?utf-8?B?OWM4ZFNuOHFNWWF3MlhtUnVDTVNhaWJWaWgwdW5sR09CYXFCYzZqOTNKdXY3?=
 =?utf-8?B?aUU3aE5oWnN1b2ptekM2WWlnM253ZFZQeEZ4bWFQY3NLQjZNcEtFd2laMWM0?=
 =?utf-8?B?N0NJa3lTRk1pNjZoMng5VHpSWkErNStyWmRvaSsrK0E3Sm5yVFd2STdQTWpi?=
 =?utf-8?B?VUtqcHJIWWdBR2ViYnN4c0JqNTFCSW9QQU0zdE0xU2xocTJzZDZPMWZ1QkZS?=
 =?utf-8?B?T2JtdDlXdFhRWE85L2FTRDBwRnZXTGxBRzhZZitxcUEwQzFieVNjdVB3NTUy?=
 =?utf-8?B?MFdaSDVrbnQ2MVZyUHBUbndxbWtWOHY0UnZlNFluMzc3L09SUEZkY05DYkJ4?=
 =?utf-8?B?WXdTRkdWbWNjSjRPYkhjbVBIM0IwUXQ2cjhKWExGUU0xQndPWXNLRUxaa2hU?=
 =?utf-8?B?dzlZZjhWdU5MckthR0hySFk0Y3A1UDNsMUliYnlWQTdORk5pc0VMdm9YMXNm?=
 =?utf-8?B?UWZkVnkvN3BLTEozVW90a3VUSERGSmxtQVdUU1VzSVhHM3U0QUx4NFk2bUhz?=
 =?utf-8?B?Vk1naDZURVBOa3h0OUZMMUhMRThreTkxUTlQenByQnZaLzk0QkJoYzVBL1I1?=
 =?utf-8?B?VzkrVTZPVFg4TDBOa0xkK0wvcjJmaG9PZzliamp4b3Judit5T2NSWVBBYnd1?=
 =?utf-8?B?VmJxR1pFcmFpaTVzM3NDZExOQk0wY2g4Nm9EUjV4eXREL2JCUmpaaTVyM2xB?=
 =?utf-8?B?T3Zkd3AzeWRmcG5IV3Uyb2M1MURJKzMvbWZGSkV1TmxweU5yRG1CZzUyQ1By?=
 =?utf-8?B?dnMra1VGVGhiOEZtcnRhWTV2WnYxMVVubFVyMjBJQjIrOWNBVXdqYXQvOXgr?=
 =?utf-8?B?SDRSVUs3VTJrQzkzbzlRQ2NmRGpkZ0hsc1FkOVVkcmFPSjV5cmZPZFNwY1N3?=
 =?utf-8?B?VytQL0JPSXdvdDdqSkNmSFBiRU5HQ1VzbEJrNHllMG1OVHQybjZSTE5rY2Vw?=
 =?utf-8?B?bEFwOHVKdEc1UGxWUE03WDZGZWtzVnBPeG54N28vVmRrbmk0SGs4b2V1WUZN?=
 =?utf-8?Q?WFrHylI1ULDG7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 402cf9e7-e16e-4660-69e5-08deb4a7b28a
X-MS-Exchange-CrossTenant-AuthSource: TYQPR04MB8919.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:35:48.6490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFAAD5227FC
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


On 5/9/2026 3:49 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Fix IOCOUNTINH.CY toggle detection by comparing normalized CY bit
> rather than XORing whole register with boolean.
>
> Fixes: 2cf2a6c027ba ("hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu-hpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index e8d284ac8b..5bf80a8db9 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -245,7 +245,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
>           s, RISCV_IOMMU_REG_IOCOUNTINH);
>   
>       /* We only need to process CY bit toggle. */
> -    if (!(inhibit ^ prev_cy_inh)) {
> +    bool cy_inh = !!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY);
> +    if (cy_inh == prev_cy_inh) {
>           return;
>       }
>   


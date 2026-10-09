Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB6CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF567-0002qP-NU; Fri, 09 Oct 2026 03:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xF55m-0002oG-Ok; Fri, 09 Oct 2026 03:32:42 -0400
Received: from mail-japaneastazolkn19013072.outbound.protection.outlook.com
 ([52.103.43.72] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xF55j-0000YP-HN; Fri, 09 Oct 2026 03:32:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnaMRQMOrsGJdeSjng/n1z9WX+KAXq72v1W0V/RWUEwaVkbPSW2o/z8zyzBHkR3cIoisOTaIbS4L6ntUT1rWZkCMZ3LGVZnLz2kMcNChyTbGEvoMkau6Rg2BFx6ZYnap+HeMy3ReeGE/rJxeI1PfWU9sooqIaqJbeOIpDfCcY8BOqmMFIBvUK1tNmYtRRVOkRAb8xY5DxYTxDPtAaO6AfcM0K5iRF4JpHvoDxhoPFfM7nbXNmVq5znZGOgfunL6PVELZIHEjsrfCJmj47+GAE/KQab2mTEWbXOO+ZlBmGL+QdI231u9wo/WE1pS+O3t8fr2epv9upWZAIBe2V0Nkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvBUW+m0DQHX1RKulXOm5gtGuC1BIDvYbtX5I93Ar4w=;
 b=XxpZuAGig2mbMx3k9mWYDGezEqmZqJi9usJoJ8ywahI7BuTYScgBVC8Ob+RG+NEmIrLRe4k7QNl3/nXSeoICemFnMXxckJktpNa2hLpmzIBObeROPAW+AdKw8bdGPcIrIEXzft5HfQhiNGhIxB4OavQ8XOWczfTgy8Ttpk/C0pNxk5fRjK3BpTOFsvGAmvGxe/w4H8wYCV6cfcWU5un7ppjr1b7ggkvAjMGRdnkMg20uVIi27JamioDKN9Q17ZT3B8IOhJAQ/9juWhfxwTTho09Rn79gIoenaYDJMJbvkvjE1LEg4aZGeqil/PtnQ5vKV4U17VhAg4vRT/C8kQ8giQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvBUW+m0DQHX1RKulXOm5gtGuC1BIDvYbtX5I93Ar4w=;
 b=ko7N3q0jubfgOD8wXyrG/4g4Ed7qrtCPkotebmQPfc5CkN16WCTZrAcGPKanc45aEpPaSfy8tLBuS1qPzlz49tq1B2HlFqXr8EHodWjFgRwvQAV7n+XnBkAagH4WiBHObnXFOV08uo1PwV81OvbaE9Qm/JBlog16jAD3s62rWFsJtpC4ydYtsaoIPTBGDWzhWVPcNKnDmBRkhiHVXgzxFTVMjGo6nbe05kTqxvGCHTZOBwprN/SDBbWr9fdgkiupKuPkmXKuGism/a7407VJRRd85WjsXMuPxtJcMNzN8OHFIuG/UDru7gVClFPCmq1fV4Fm69aiqhIoBDi8Cm6KWQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by KUZPR04MB9049.apcprd04.prod.outlook.com (2603:1096:d10:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 07:27:20 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 07:27:20 +0000
Message-ID: <TYZPR04MB7491A45D5B5281E76392DA06F3922@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Fri, 9 Oct 2026 15:27:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-stable@nongnu.org
References: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <a3800c04-b930-4632-9bff-3c462edd8cdf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|KUZPR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd8cd5-0a5e-4a6b-6593-08df25d6c0d2
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|15080799012|24121999003|55001999006|22091999003|19101099003|41001999006|19110799012|51005399006|6090799003|4140399003|8060799015|25010399006|5072599009|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXc5UVQ2U2ZPUEtieVJ5YkV6dStZbGlsZzFIQ254WWFHNHZ1YlpTbEF6QjhH?=
 =?utf-8?B?Z1p0MFpnZ0NTeGZXeXlYaWxlQmhPNkZQYW1QcUZkNXYxU05GdURaY0VPSlVJ?=
 =?utf-8?B?NDg2Q3k0Q0NKcGk1RmVGcS9lZGd5bDJKMzlzL2M1c3Nxd0J1WXp2SENvREky?=
 =?utf-8?B?T2VaaEtxeGxvcHRVZE1LS0wzdSs5R0JHVjU2bHpuSk9EZ2FJclZ2RWJSSEVK?=
 =?utf-8?B?Ti8zdHArWWl0RTE5TjBVMFE2ZTJqYjU5SjFYbnpXOVpkektGK3pmRVVFTXJz?=
 =?utf-8?B?QW9GT21SeEI2YTFETE9nWWlsbUFleGVTWkJrWHovOVo2UnJsSDZtOEJkN3BN?=
 =?utf-8?B?NndWSlh1VXB6cmhBVm80WGJpRGJMVWdkc3EwM2U4cjhFOWQ5bGthNlNpeE9U?=
 =?utf-8?B?aE55SUtBN281NVZ6L3YyKzFCWDBFbDk2R0JLekVvUUxRdzZRMm1ONTdwbzhX?=
 =?utf-8?B?aEM0VHN3blNJUTViWnlNMWlhWlZxNzRNUUZ5NXZjQUI5Smp4bFlFZ0cvZzY2?=
 =?utf-8?B?UVF5UEswcDNySkVzQUcvN244TitaUWlNdHRhMkRVNlFIOXFvbUdHVzY3aXRK?=
 =?utf-8?B?VDNWK2dWR2VaMG81YURoRlducVNiVjBDelNlOTIrbkthcFBSaVIrVnBVMjdu?=
 =?utf-8?B?MXBCNlpEK1Jtd1Rha2JnbVJxbnFHQWpkYlpaR0pUNUVNNWpXbW5tN2ZMUFpY?=
 =?utf-8?B?TS84RlRDYk9nUUpCOTl5WVkxUFNSc01nMzZ3dHQwS0VPQlFlaVd1RG5FNmhJ?=
 =?utf-8?B?aWdQamJNRnprQ3NoR2VQdnJOejNjWXVlMUtVbzI2UUYzWW5uZldFL1JCZXZr?=
 =?utf-8?B?aldYYlhLUktXSHUxTTRBdFN5VUtwM3N5RWtLMEtyMndjOEFMbjhFVTVMUS8y?=
 =?utf-8?B?UFhaNHFyeldFN1dOMUN3cFFpaWdmMEF2RlRSMVAvSk1QNHMvbmJqK3R2UWti?=
 =?utf-8?B?aGRTWXJKVnhuYWc5MGk0bk40dlR2R3JpWlRVcThJaWtiMHFZZHBUTnBTMk9z?=
 =?utf-8?B?VUpWZXNqK1EyWXJmaTEwMlZKODB4MCtodkhpMzRNTEFGa0RVT3JiQlRRQzQ0?=
 =?utf-8?B?R2VrSVo3NTYvSlNQanlxNFdQMnRrYXFRNTVtRnZPZ3RNYjhNTmt2eXFoWDhC?=
 =?utf-8?B?RStGZTBBSWZycVJ0bWhlM0s5ZFc0S0JBeW1VUVZnS3pjOGZsZTNObzkrMFFj?=
 =?utf-8?B?S1FXd0I2NjByMGhnWUNZb0hpYUV5YmMvVUVjeTdHNlI5ZEJhNGRaV0k2Tkp0?=
 =?utf-8?B?b0tPOVVyVUo1RXF3R2ZtVmJKYW9JeHA3cEJJM1pydkdGcld4QkV6T0hJeFQ2?=
 =?utf-8?B?U3Rlb2dxMUZiOTlYckh4TGdtSUlzZTY4STA5RHM5WEhoK1E0NWQzVUtYY1Nn?=
 =?utf-8?B?TzV4YTBvckgrQlFrWUNzalh2Ykhhdm04Zm9KUTYvZGxWdTVZUXJBSFp3UmZn?=
 =?utf-8?B?UGVzTkRtSkhXa1l6T1F6anpkVS9tcVJLMkgrRUxnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBEbGFoYlBYOHdqUmxRVXZzck5VZHZ1QnJZWUpJcmhXT0VlZUlFK3FJdG81?=
 =?utf-8?B?YXhCOS9FNmJHdk5nZ0NoTEc0bEgrRE03VVY0WjdNcGsxOW1GRUJRQnpFVTBt?=
 =?utf-8?B?ck5GVytteUxLem1ZUldHTktnWERjVU1GeVA0TDUvS00rdjhFQmd2RlJORkZ1?=
 =?utf-8?B?TVNyMFVCam9HaDRBdTdCUlpFa1ZOSjcvVUxSVS9WQkJJTWNhSTVIbHBlQU84?=
 =?utf-8?B?MnZ3TnNRUk9TRzgvSFQ0MFNpT3RCMmpVTU1PKytlMnBjWFZmVHV4cWtLWG1S?=
 =?utf-8?B?bGU4ZldoeGlSSTB3cENPVjJMamtxTmQ1VUhhd01vS0JaSTlWbXhlM0VZZTBl?=
 =?utf-8?B?T3ZvRVpSY3B5RXR0bFkyeTMxQ1lRdVh3QUNwbjBZK2dJblh0WkhmR2pVTFhm?=
 =?utf-8?B?dmZ6bGNCUVA2VHRpYkNFQlRiTVhEYUJ6eTF0MGRXK3QvdXNOc0pzUEg4aW1j?=
 =?utf-8?B?WE9Nak9KbzhtMVZpbFY4bDVaMG1JQ1ZtYVdnb3B6bm4zMWxRczdpK1JFbjFP?=
 =?utf-8?B?d2ZncjNUcTF5eTMwVmZMaHEwYUlyeU9tYTdscE5BR2NoOVhMVmpZZk5UU2k4?=
 =?utf-8?B?b3dna2JOR3I5VUhnNU03MVNwNW1LUXFEckdDVGpQL0RLcnpRVVhTT1JpWmRB?=
 =?utf-8?B?aTI1NkoyMERoenhEL2xKbTdMRmVmOFk0cXhKRVdsa05SUjV6N2NJOERiV0Js?=
 =?utf-8?B?VXBBckd6a1l2NlpDUHdSOVk1M0NJR1dxOTVRdWd3d3l1c3Y4UmNVaWdkZTU5?=
 =?utf-8?B?MVNMMHdwUEEzZ3B2ZUpnUUVwWlZrOTdrR1N2eGxvUVhVN2E3cmtoUkxwbjZq?=
 =?utf-8?B?T3JXRjZFc1lmK2NIUSsyNU95TS8zSHp3MUdkMUZiYzJCbDZkS0o4K0Z1dU83?=
 =?utf-8?B?aHZ0MkdudFovZDhkNlFkNnJtemNUeVBaZzRNdGFpVy84SnJCQitXcVdCeVc1?=
 =?utf-8?B?Rk1PblVWK3ppMlpmUWZXMWg5bTZBTnpuU0NqeHBydzg5ZFRxUlg4Wk9scC8v?=
 =?utf-8?B?bDVoWmZJQVhwUzdTS0gydmRUdnNlOGFPY2grRUx3aWxvYXk1ZzNGWkRsSGZF?=
 =?utf-8?B?dWJwRWFVL3J5SXVmUlJyR2VjZ09NN0R5alk4SndZZjZVZXdMVjBwdmV0cVdO?=
 =?utf-8?B?VTFZeDc4UitpTisxa3ZybE13OElJMjVZUytqazc5a3JoSU1QV3ZXNlJDR2dN?=
 =?utf-8?B?M0FSSjljc0UzNVJjakdPN0UwTCtOMDRVdk9QUlFlSTZUWGw4Z1ZsR1gyaWJy?=
 =?utf-8?B?NVVVN2N2Mmg3K3phbktiUHNLdWJBTVUremc5SDdDdE4yWTl5Wm1PNDcrRkVI?=
 =?utf-8?B?azh3K1oyR2p5d1pRN29YVU5Makd3M1htVm1xaGNqOUJLdFNJeDI1Z3RKZEJH?=
 =?utf-8?B?SWVjMkpabkEwamJsbWtLVVMydzJoU1VhVFVuaUhPYm1HNUdqeUZxVjVXbE1n?=
 =?utf-8?B?VlZ6MkkzOVp1azJzNVQ3elVXV3FCWUVzYkNVaFhVbUd2RlJEeWE5WlFhQm0r?=
 =?utf-8?B?azRDZklmdFQ0RWp4cEJKelJPK0pmVUppVEQ3N3IrR0xTN1F1aDhNcXAxUktl?=
 =?utf-8?B?bm41VTR3Sld4MkJxaW05aXpLQUErbXNsQytsMlJwa1hmbjQvSnhQdmNEd2VS?=
 =?utf-8?B?YUNrYkNHTy9Yem9uSzVjNis2YVUveG9VZ29HRnV5TVFFTFV4MWo0SXFNcldR?=
 =?utf-8?B?VllCbGVvTjNxTDRsWW1PaDJRL0R6STh2ME1IbEp3aVBsZ0VLOVNLOUxzelNo?=
 =?utf-8?B?bUpwaUU5ZDJWaHJmRHJ4c0JxWXFTVk5nT3dVL0JjUVE4SEJxaWQ0TWJzc3gz?=
 =?utf-8?B?OVFvSUE3Z1o5Uk5VWUdWM0JIUWlqVkxnK0YrZ0t6dHQrSUxob05xWHd6UUxJ?=
 =?utf-8?Q?3cRtTF4HLfDkI?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd8cd5-0a5e-4a6b-6593-08df25d6c0d2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:27:20.2918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB9049
Received-SPF: pass client-ip=52.103.43.72; envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 10/5/2026 7:15 PM, Tan Chi wrote:
> riscv_iommu_translate() allocates an IOATC entry before passing it to
> riscv_iommu_iot_update(). The update helper normally transfers ownership
> to the hash table.
>
> When ioatc-limit is zero, however, the helper returns without inserting or
> freeing the entry. Every cacheable non-identity translation therefore leaks
> one RISCVIOMMUEntry.
>
> Avoid this by disabling caching at the caller when ioatc-limit is zero,
> so riscv_iommu_translate() does not allocate an IOATC entry in the first
> place. This avoids special-casing entry freeing in riscv_iommu_iot_update()
> and keeps the ownership semantics simpler.
>
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Fixes: 9d085a1c3cb2 ("hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
> v2:
> - Disable caching when ioatc-limit is zero instead of freeing the
>    allocated entry in riscv_iommu_iot_update().
>
>   hw/riscv/riscv-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 323a041b4a..866f49cc39 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2919,7 +2919,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
>           /* Translation disabled or invalid. */
>           iotlb.addr_mask = 0;
>           iotlb.perm = IOMMU_NONE;
> -    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb,
> +                                     as->iommu->iot_limit > 0)) {
>           /* Translation disabled or fault reported. */
>           iotlb.addr_mask = 0;
>           iotlb.perm = IOMMU_NONE;


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD6606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=gGpdXsOw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQztE-0003hR-Pg; Tue, 10 Nov 2026 23:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xQztD-0003hB-6m; Tue, 10 Nov 2026 23:24:51 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xQztB-0003NT-2V; Tue, 10 Nov 2026 23:24:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXy3z9hdUdJJVNhkKjgd42mBX91H4AfFRHyk+1ZATx/scWSVHBTNAsoD1z3N/ijshpozCse5ZG1wE9U5XtUCu1/VJFcHB2F4wNXrhaNaqgRUCZLOChQCaPI3qfyyGMHX/lfBj0hKlgUBgF2noBCOyNXQ6nOjXxECS3Bd3ARvCxoFFAJvCAR41pV5H5F1ff8uojM1haJic7YCCRqFAjZSbFD3tP77L9P0CB6cvwpjU6fUy+Ln97yyjEy7gbzcauY2q6yJIThlMZrqanKQXtNCqhhUv8sFDBHzGDncBc1RXJJPBDJE7tddhUIOkN3I6LY1M/sCUkAJyTlks+iUDIThcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjlTV7YeC5xf380RDSJIcBlhYx1ck9/wGv1a/s27+Wc=;
 b=WZ+IiLvCEYUSwCBeCCxySzdB2+zEc0tduP1kRiDnzYVL10GhPPjfIkZaiUwZ59dVURDOCfNmFNyu0kbYGYNz/Hj2Tm62g6DxXhajFLooswN9OiAAo/F7CgSyVVLGIg+H89vyA/BGjKXWZtNrd81I+pOueTSzqRkdsnnUV5Jyz4LqR0/K0Hacx30KleKUrC3cQ4+9C7auv/pnMtRSZoIL00gktTw7j5+9zdVhIzQgpMNnuutsJElZGblBg30rVqKc2dP8i5f0Nrcy4T1ZGZHL32UqOJc0gcUzVao/zUdHbwxRUXcd5yVlny6Q9WiukQsh1+zTA8s6NKYr2GKXU/X3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjlTV7YeC5xf380RDSJIcBlhYx1ck9/wGv1a/s27+Wc=;
 b=gGpdXsOwBQDsPxFFruFITB98kfNW+wE8s++irevqMrhNPtwEBrxCaWsSal43ITTSwapTYKl0iLtBh5slqMNUAsqjXL+Hta85cNp/y/XfKyDZ8PZwdFlvVPMJPM6d0jEkoVU8WGWlLOVeDl/z7PrTDKuo3e0n/PJJM9ZcqFkDqbvjZugsuSJJAm0kCSZ2LOW6D/gVemHdCq+13L1CZz0hFVQj264qKpItAc4l7JRBaeqaIF/QMjOEmyy2mJX1vrOmoLRiSE0VDg7Sqw+5v774hR24UzEooiSJ6Dx2IpknSldg/U/greOqYTdF7jARUkf1wcCrlNWSp74R1fJ+JyEtYw==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYZPR04MB5655.apcprd04.prod.outlook.com (2603:1096:400:1c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:24:42 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 04:24:42 +0000
Message-ID: <TYZPR04MB7491B13C729621DAB9873EE2F3712@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 11 Nov 2026 12:24:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/riscv: iommu: Fix implicit G-stage page-table
 accesses
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
 <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <0b03506f-4909-458f-b788-3fb1a4404a8b@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYZPR04MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 567f3b05-4a2f-4dc5-52e6-08df3fabb49b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|23021999003|51005399006|22091999003|41001999006|8060799015|19110799012|6090799003|12121999013|24121999003|5072599009|19101099003|4140399003|25010399006|55001999006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWpXMWN0M0VKc05CTStQQ0xwclp3RkwxZUM5NjZvSFhqRkx4ZnJuV2ZxdnMz?=
 =?utf-8?B?Q010dmhVV0FFdGJUcHg1eHhJOW1SYktvZFA3aVZNOVp3aCtYd1dmTXVEVzFE?=
 =?utf-8?B?OVEvcXg3b1kxMjNHclkzN1BMUW5TTUxRYkVlWnJmZ0NuQ2llMDJoT3ZvcDlH?=
 =?utf-8?B?SE45OC9uNzNETUdQYVZQU3NJeVpldWwrZFR6cU8wVjJPMUhjaEVuMmpvWEZ2?=
 =?utf-8?B?MW0xYkQ4Z3I4RWFTdEQrOEQ0ZmQ5akl2cERsTVA3QW9Ob0U1RnhkSnk3ME1q?=
 =?utf-8?B?ZGtEMktKYUNUN3ZiN3lGTnBoSi80OFg2RzNZL1JwZDZ2WUZBTkoyOHNqUTFK?=
 =?utf-8?B?KzFLVTFqcitoQmxicFQ5ZjJZak5wdTNhL2V2bC9VWXZhMDJBUWZkQnkxNCtO?=
 =?utf-8?B?RGhlTzg1UHZjKzRwbUltZjlWU2U2cFl2Q3ZreWdzNXZ0TFFlalBDcHNWcTFS?=
 =?utf-8?B?eTVFRXFGSUtPODhzcWgxUHNwbnRzU0Zkd1RoZHZORUE2ZDQ1THcxYlZNY0Qy?=
 =?utf-8?B?VHBoWWJXQ1F5bFFidmhhRTJ3UVd0UXBUWWY4cEdaM213NVhJSTZnK1hHTU9u?=
 =?utf-8?B?OUJwUFJIV1UxczhqTkdYOGJQcDQ1aHZ1allKOFlkeEtJSVV0N2RhYlFmaWpP?=
 =?utf-8?B?Nm5rWWxEeHZiMGYydVRxR2pvRkNBSUlLaFFlekNMN2VrUHVVWVFLaTFMWVdX?=
 =?utf-8?B?YVV5NlRHbWN3aEQ1eEdaMlRhQmN4NGg2T0ZHdE9SbXliTmZyY3ovam5NS1o0?=
 =?utf-8?B?TldVUWMzVzNuNEx1WmpveXh1Y2pBbzBSMWJNSmxDSGx1anE0anNSaUJaWCtZ?=
 =?utf-8?B?QXN6L0VEa3ROdGUxU1piWk1NdExqN1NlaUJPajBNaVdJOXR1TFBFQlgxbDV1?=
 =?utf-8?B?S1Y1a05mOVE1ekdXM0huN0JyaGhTemN3cmdJOFNsbnM0M1cvWktwWmxvVzB3?=
 =?utf-8?B?TUhpRUNRT3lDNnp2ZXBtSjEwMlNhZ0JpWnlXaFpTdXQyQkNiSXV6UzVRZFdp?=
 =?utf-8?B?dTFmZ01oUUNvL0xLaHFYTytIcDFvN0ZtWkhaL01GUU0vWnRRdmJLNE9rZnJz?=
 =?utf-8?B?Zk1WZEN5am5Bbk9RSVo1TVBJZ3hJY0hTWXZobTgwOEdPTVBDM0RsSzU4Q25N?=
 =?utf-8?B?anRVY3hsTU40Wm5SWnR4SzFsbVd2S0N6TkJucnhnTDBLbkUwa1VLYktNTHZO?=
 =?utf-8?B?djB6NmxhU2Z3c0tldXdiNlBtL3hYRUo5Y1h4dHdqWVBBRU8vd0xVOVVJcXRG?=
 =?utf-8?B?YUZ4WDdFU3hRZnEzSWh2RW9LU2RmRWF0SWNZTktnbVQxa1NqZGtmc0JXaWZr?=
 =?utf-8?B?dUYvTEZUdytHc2FlK1BRN2pGb2YrM21zUXhHV3VMalV4b1hYVlkzSXNBaUdr?=
 =?utf-8?B?Nms1L29QQVRNTHpGeGFJVCtjRnUxdzBnYzlHVmRtVXZmZk0xWERMTkJyWUlo?=
 =?utf-8?B?ZnZFQnJ4d2tNUVhubTdFUm1qTkxkY1ZhYzN6bS8yWnd4eGdwa0hkdDdlVml5?=
 =?utf-8?Q?4iFs4MATEanQZAR53qlzuRxipkZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJWcXpjNUVtRzEvcy9BK0J4dVM0aEdqZWpVU0ZseC9oVVBFR3oxWWFOREZ0?=
 =?utf-8?B?WUhiSVU2ajBWRyt1QXBLbDdWUEpZYUFpeEVwSERIQUhnWlBBaFBEUnZEbzhK?=
 =?utf-8?B?MHRGWnpnS0RmcDRGVnp0MUpidnpWZmZFZkF3WmFjRm9ZWnVFeUtCa2J3andM?=
 =?utf-8?B?VzQzUTBNVjJ6dGRFUnNjYTR5MzYwbC9vaXVwYUE4bUxFcDZFS1RacFZFRXZz?=
 =?utf-8?B?R1oveTgxSXZyN1djY1AxNHYvdk42aHNDZGNlQkg1RnJKYmdxTWIza1VYdy82?=
 =?utf-8?B?OUZGcXNFTm14WmFMdUJidUN5QkJ2eEpRVk1zT2tEWkViamlvNHpnOGd0NE1D?=
 =?utf-8?B?OVBiWmZ4NzF6QndEd1dOanVIc0k3TUJ4MHJibzJrMDczL1JRNzZzNk5wRVRo?=
 =?utf-8?B?cmhZTm1iZlFIL0FTTFRJTkJDU3J2aUJzK1RNcy9paEpaRmorVjEraWcwSCtV?=
 =?utf-8?B?RnhxZjdHbzN5MVp4b3pVaXplbExaUERMY1RnbGI5WmdackpGR05GQmVDVGVV?=
 =?utf-8?B?SzFXV0U4OVlEc0ZBVytrR280YmUrY1pnTDFEYVVKOEhzK0g5YzhZMEYrTHBa?=
 =?utf-8?B?VmF4R0pDZXhDemlWQjFjUncxNTRKT2ZyYjBQRndYT29vWkVGWE40ZlJsTmky?=
 =?utf-8?B?S2hRNWdzbDlJK3UzeDhNLzZiOUYrdDM5Q2QvOXFFKzJnZThEc0hRZnpUTTZ0?=
 =?utf-8?B?YXlEakp2ZzRGWStocVI1RnA2TG9zekFESll5VDdGQmFVS01wOWxLZGlEMDho?=
 =?utf-8?B?cUdtY1d5dmdOcUZrQXpCR1VHOFkzaFhGVXFQTFRZUUpKcEE4UmVwKytUS3hZ?=
 =?utf-8?B?YWprQ2RXeWxsLzJ3bEgyai9Rb2NnUWE1NWpwbFdmd2NHV09VV1Ircml3WEJV?=
 =?utf-8?B?aFF0YjQ5Qks4dUdoTzlJckxuVkZpSUtIaHh6QUNyTWVmTitiVGZxWDQxWDFr?=
 =?utf-8?B?bFJlK2RLZ2Jqd3YwQ0c0WXVoMzNDT2tZcllZakFzcmQ2eUl3aFJtSitXbFdH?=
 =?utf-8?B?dDFmN2NzbVRqanFXS25UbzNUcElnTWVYaXIwZURCYzNvUjh3RVFNYkRaT0sy?=
 =?utf-8?B?K1M0QWRjT3ZuTys2ajhWM1FuZ0t3M3hwTVc4TDRzNHF5OEtacytsdFdFNHNH?=
 =?utf-8?B?dVB5Y0FTemwxL2JjQmt6WkdEcndjOEZnVzNabTVQR0lMQjB3M2k0REFINUdj?=
 =?utf-8?B?R09Lcjl2Y1k1Wmd6OVZKKzVQelhqOHd4a3I4b2JtaXZwOHk1aE5tNUdnNjhu?=
 =?utf-8?B?enlMcXE0ZlRjRHpTNFM3cGhUN2xjNGlHNlJPRmRkYmZSVkJ5eldXTWRLTWwz?=
 =?utf-8?B?UzN2dEM1MzBESGJIdFpCNi9ka09BUzZXNE9WUnZMYWV0NWc0YjV2OVFtTkZk?=
 =?utf-8?B?NFRxb2c2ajBJMkE1UWlYeHp1d2JMQ3N2QndMcENvYm1zK0VlWXJrQ0hrZFM3?=
 =?utf-8?B?UkRxYnppTno0VjNDQXNOVDFsOWtwRGhGNERhbzhEVCs3clRDam0weWpRUmIz?=
 =?utf-8?B?dXVkRnFuNExzdHljMWc1QzR0cXNMVDBDTEVQaGdlbkUxc2hNSVIrSzU0V3dm?=
 =?utf-8?B?RjdIblZJd0JkVnVzZlpJSU1iZ2hWTFRXbXRSUjVDVThDYm1WZ05rK0o0T1hu?=
 =?utf-8?B?QmN6dVhRWFNQWERYSnBCRVkrM0kvY2Z4bk5xSTd5T0lHbXJES2pZWVZjZkVU?=
 =?utf-8?B?bk9sdGQ2aGhIbFFtU3lUdms1QUluNldjOWpKWDlEZXJoVHFLaEdoU0l4Z0Nl?=
 =?utf-8?B?SFUwaGc3ZXB0SjErZFQrMk5GczJpUkZpcVdEQ21PMFFIc3VHdzNyN0xwV29T?=
 =?utf-8?B?MGtJWjM0ZEJndnI0SjM5ZlI5QTdLdU0va1UzZEhHS2RtQldTR3ZZUmgyejFP?=
 =?utf-8?Q?N1ykeLOuCRZaa?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 567f3b05-4a2f-4dc5-52e6-08df3fabb49b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:24:41.8290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5655
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/8/2026 10:39 PM, Tan Chi wrote:
> When translating a DMA write, G-stage accesses to first-stage page
> tables are implicit reads. The current implementation checks permissions
> using the original DMA access type, which may incorrectly require write
> permission for these reads.
>
> Use read permission for implicit page-table accesses while preserving
> the original DMA access type for the final translation and fault
> reporting.
>
> Also track the fault address separately from the translation result and
> set the implicit-access flag in iotval2 for guest-page faults. Route
> address-range failures through the common page-fault path to report the
> correct fault address.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>   hw/riscv/riscv-iommu.c | 60 ++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 0e6970773a..2dcc528599 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -273,13 +273,15 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
>    * Keeping them separate for now, as error reporting and flow specifics are
>    * sufficiently different for separate implementation.
>    *
> - * @s        : IOMMU Device State
> - * @ctx      : Translation context for device id and process address space id.
> - * @iotlb    : translation data: physical address and access mode.
> - * @return   : success or fault cause code.
> + * @s               : IOMMU Device State
> + * @ctx             : Translation context for device id and process
> + *                    address space id.
> + * @iotlb           : translation data: physical address and access mode.
> + * @fault_iotval2   : Fault address and implicit-access flags for iotval2.
> + * @return          : success or fault cause code.
>    */
>   static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> -    IOMMUTLBEntry *iotlb)
> +    IOMMUTLBEntry *iotlb, uint64_t *fault_iotval2)
>   {
>       IOMMUAccessFlags trans_perm = IOMMU_NONE;
>       dma_addr_t addr, base;
> @@ -299,10 +301,10 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       MemTxResult ret;
>       bool pv = !!ctx->process_id;
>       /*
> -     * Keep the request permission separate from iotlb->perm.  G-stage
> +     * Keep the request permission separate from iotlb->perm. G-stage
>        * walks translate S-stage PTE addresses before the real leaf is
>        * reached, but permission checks and fault types must still use the
> -     * original request.  A successful walk leaves iotlb->perm with the
> +     * original request. A successful walk leaves iotlb->perm with the
>        * effective leaf permission for the translation cache.
>        */
>       const IOMMUAccessFlags req_perm = iotlb->perm;
> @@ -424,6 +426,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
>           const bool ade =
>               ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
> +        /*
> +         * G-stage accesses to S-stage page tables are implicit reads.
> +         * The original DMA permission is used for the final data access.
> +         */
> +        const bool implicit_read =
> +            pass == G_STAGE && en_s && sc[S_STAGE].step != sc[S_STAGE].levels;
> +        const IOMMUAccessFlags acc_perm =
> +            implicit_read ? IOMMU_RO : req_perm;
>   
>           if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
>               /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
> @@ -442,15 +452,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                   masked_msbs = (addr >> (va_len - 1)) & mask;
>   
>                   if (masked_msbs != 0 && masked_msbs != mask) {
> -                    return (req_perm & IOMMU_WO) ?
> -                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
> -                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
> +                    goto page_fault;
>                   }
>               } else {
>                   if ((addr & va_mask) != addr) {
> -                    return (req_perm & IOMMU_WO) ?
> -                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> -                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
> +                    goto page_fault;
>                   }
>               }
>           }
> @@ -499,13 +505,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                * non-user mode leaf PTE and !pv we need to fault.
>                */
>               break;
> -        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
> +        } else if ((acc_perm & IOMMU_RO) && !(pte & PTE_R)) {
>               break;                /* Read access check failed */
> -        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
> +        } else if ((acc_perm & IOMMU_WO) && !(pte & PTE_W)) {
>               break;                /* Write access check failed */
>           } else if (!ade && !(pte & PTE_A)) {
>               break;                /* Access bit not set */
> -        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +        } else if ((acc_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>               break;                /* Dirty bit not set */
>           } else if (pass == G_STAGE && !(pte & PTE_U)) {
>               /*
> @@ -587,13 +593,22 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           }
>       } while (1);
>   
> +page_fault:
>       /*
>        * riscv_iommu_translate() will receive a fault and then call
> -     * riscv_iommu_report_fault() using iotlb->translated_addr
> -     * as iotval2.  Update translated_addr it with the latest
> -     * translated addr we have.
> +     * riscv_iommu_report_fault() using fault_iotval2 as iotval2.
> +     * Update fault_iotval2 with the latest translated address.
> +     * For guest-page faults, set the implicit first-stage
> +     * page-table access flag in the low bit.
>        */
> -    iotlb->translated_addr = addr;
> +    *fault_iotval2 = addr;
> +
> +    if (pass == G_STAGE) {
> +        bool implicit_read =
> +            en_s && sc[S_STAGE].step != sc[S_STAGE].levels;
One nit pick:
Duplicated `implicit_read` declaration and computation.

Suggest to declare `implicit_read`  within function scope.
Like:
      const IOMMUAccessFlags req_perm = iotlb->perm;
+    bool implicit_read;
      ...
      do {
            ...
+        implicit_read =
+            pass == G_STAGE && en_s &&
+            sc[S_STAGE].step != sc[S_STAGE].levels;
          ...
      } while (1);

  page_fault:
      *fault_iotval2 = addr;
      if (pass == G_STAGE) {
          *fault_iotval2 = (addr & ~3ULL) | (implicit_read ? 1 : 0);
      }

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +        *fault_iotval2 = (addr & ~3ULL) |
> +                         (implicit_read ? 1 : 0);
> +    }
>   
>       return (req_perm & IOMMU_WO) ?
>                   (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> @@ -1740,6 +1755,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       bool enable_pri;
>       hwaddr phys = 0;
>       int fault;
> +    uint64_t fault_iotval2 = 0;
>   
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>   
> @@ -1776,7 +1792,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
>   
>       /* Translate using device directory / page table information. */
> -    fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
> +    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, &fault_iotval2);
>   
>       if (!fault && iotlb->target_as == &s->trap_as) {
>           /* Do not cache trapped MSI translations */
> @@ -1827,7 +1843,7 @@ done:
>           }
>   
>           riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pid,
> -                                 iotlb->iova, iotlb->translated_addr);
> +                                 iotlb->iova, fault_iotval2);
>           return fault;
>       }
>   


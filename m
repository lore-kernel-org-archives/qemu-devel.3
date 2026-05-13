Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859FECD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2xL-0001DS-11; Wed, 13 May 2026 02:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN2xJ-00016Z-19; Wed, 13 May 2026 02:20:29 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN2xE-0007Yp-B7; Wed, 13 May 2026 02:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGo6XXuLEHFST3GhIGyXtiDDc6fXcFis6IZ87ledjTIeHcWVCHBOXsapmBSTpb4TlVnI4JhY/ZlMxVxra/zBPgLX981YlhuwIAK3L+x21HJtv9lukdt/i/OxSLzs5/Umn2gjLbRNMQJclTmWeEs6I9fujbehnmO5I9LkFkFcr+pc6VzKaHtrhLhcad4nBGx3EA+3yptMoi2jRkmT23j/tgj31e+RoFct0r3iVc2BYXbDz3kFt8yFVjf0Cyelse1kg2HXD7zmfQG8nVD8GgzImz7hFHQ8FFJpeA2pgJu5ZmWkuhhzxxXtW3PpqnNiR0Ygw1Zm0RkoxQTESCNNaEqqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1AwNwvRkUwZZYk29zLup4xExzqj2mg0dmfjmg+YBBU=;
 b=mvEyQioEnALXmmCrKbQOhgn+/1jaSru2twpYVwCiRc7KDxXVN8C+SU3U4vHYU2/Fati7RzcP9RO25ztdAbUqGh4s16YdAFHuAcxNwg7/5yU9nmoi9ZkVC54BQuT2VeIREUVpdmVvb063FUJHS/XrNESE7Gs1TuMmXjELaJoYzglLG88TzZbK+MbtjFIdZw5ceKc9S5AMpcaEjWDs8NIb/Ox1W9OAZxZVdytZPlnD0LOvOZwee1tyJxecboK2N1rb0l8E7GflIEEd2R9S7HdYta0WBN8TgdsuCmtRVp9sqCf9dXn0oIs8tFA/7Pr0Za2lr5lOJxywXLptecruFcDMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1AwNwvRkUwZZYk29zLup4xExzqj2mg0dmfjmg+YBBU=;
 b=fSIQecjhu2f6OMDds0MjHRcWSMQnR9AN1YdHhxGB4CvAohBrgNIwGwKV1T2X7xZJeXyUXVi/X39KMfX9KT//wVyKaZJjZjCkjICifG30DpUPDWJ/vHi2OC5aDlXptoi6s/i8DDA/l8F3T+Cd/FBFMxBDMTiDSgm05wJ4f6uWlrFlPBtGHUH1But6kAYe5KHaQxYnuevwoF0rOTo1oeosNfQ8wehPbnz8sHZue+Ho8gFsTPl1TfjizWBGlXpweXACfQyOj9rc5iIeQXreoc4oyt2ggULNQCvlYFPDUKWDTDi1GMK3GImDZTV/Ul0MRur8PT7DNApavKv8DO29Lkm5/w==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB7558.apcprd04.prod.outlook.com (2603:1096:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 06:20:15 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 06:20:14 +0000
Message-ID: <SE3PR04MB89220B977520EF4E64566FD8F3062@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 13 May 2026 14:20:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] target/riscv: Integrate SMMPT checks into MMU and
 TLB fill
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
 <20260511124705.28161-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260511124705.28161-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <8f928654-2bf5-43b5-b42a-c667ad15d392@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb914e2-343b-401e-39e0-08deb0b7b1f7
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|15080799012|12121999013|6090799003|45011099003|51005399006|8060799015|5072599009|19110799012|23021999003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yys5ZmZXa2ZrT2plOHhKUDc1NVdKS0ltbXhabFJCZmZHdy9mYTVyWVQ5N2ZW?=
 =?utf-8?B?Sndsd21kUjVQY1I1eWREQ1BZNENoOHlTTDBabXl0VTNoY05TL0dBbDZtRUZV?=
 =?utf-8?B?Wk5tMG1aWlNBenIrZnB2d1NDQkVsVjJWazhXdWkzQmhXWStCYUxiNWx4eHRL?=
 =?utf-8?B?eWtEa2dqSk1NWHNVaWxpVUxKMmpucVJ1Y1ROWG9Nc242NC8xaFpTMGRzc00y?=
 =?utf-8?B?eGlCR2JZTHFScjVyYVVlcnNWK0Z4ZnBWUXNGZGFNeFVHUkREWkhGYTFxYnVa?=
 =?utf-8?B?NjRRMnVUVUlobVVwVzluR2wyS1YrT2orbVNuTmZ4dGR1cTB1WkdqRnU4a2Ew?=
 =?utf-8?B?RUNZZ3ViRnlSdUZMYmp4Uy9nMGNmR2VkM3BhckZURDFScU9ocWN5djRPNmtm?=
 =?utf-8?B?YVdnM2hrdjhaenl1elFKMDhKTFEyT0dGd1krM3hCc0o1c0ZCT2doMU10cDMv?=
 =?utf-8?B?RGZyVC8zVW9CYzA2MzVZT0p5c0pEZm0zdDd1WEc3ZGpIV3V6SWdLR2VtYnUy?=
 =?utf-8?B?cmRJRHpFVld2NWpYUXV6UktKRFpTY0t4a1ZXVEdHdlk0cXBXTC9GN3NQWWFQ?=
 =?utf-8?B?MUZxL3liZzMvcjJqaVJoS202dFhyTHdnN3dNaWdodzk4ZmsvQkp2L3l1cG5M?=
 =?utf-8?B?bElvS2Nram1mUGF3SnppcjRia1BkeC94MGFWS1pFNnRPRVNNN3RVdWh0UUdG?=
 =?utf-8?B?MFQwZEZtZWZSeTlFOG56eHpDenVFM0pyMk1LaWNoZmtjemxITlk2R3ljSXQ2?=
 =?utf-8?B?ZzdtWnd1dmROWmEzTFhFRi9HMVJmbkVHV0xORndYVEVyNzM1dUF0NkVLd1Uw?=
 =?utf-8?B?UWVQTEVoZkpTWDI3Ky9ZWHBFSzZqSDFXK29PUjNSWG1DUU9VNDB3TmJqc3FX?=
 =?utf-8?B?RzNZdVBVcWxlQkdQeDlXTGNWTkFQU3d2MVltNlEzNVREaVlxaUhZUjlid0NY?=
 =?utf-8?B?Ly9Ed3lYT0R6L1Q2WnllY056bUZkZWJneG5rY0dPYlBOZUxMMjlUUnVnTlUx?=
 =?utf-8?B?djdqb0lGVEFPQ1JrM1krOGVuZHJOZnhJYzU5Vk9BclFZYjR6aEFKZDFKWTB3?=
 =?utf-8?B?TkJPSUM5VDFaMkFCczgwYUdYLzUvQTYyL1hCU2lnU1dxN1c1SmRGNjJEdzI2?=
 =?utf-8?B?LzcvRU95Y0lFY0dkT1M3SnNWM202VVRnVjd1cFZVRmxOUVBPYlJaSTRJRjF4?=
 =?utf-8?B?R21YazZrZ1pYSFcvM01yZjB2QzBPT2laOWZFQk8yRCttUGpra1JkZnV3cUIv?=
 =?utf-8?B?azlMS0E4a3A3dzhQUU5rNC9PaWNuWFZuTm5EN3c4TGQvemU4MlNjVi9zclhM?=
 =?utf-8?B?NlJYelNjSkpGQ0xnMFhuZ3RxSnpGYzl3VllQcnNOdUs5RjNnN1BEQjVGY1pL?=
 =?utf-8?Q?lzj+eISsxsw40/8kkgrXtG8AUwiDoQxE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdiRVZtU1ZkZmR1eFFML3ZDTVVnZlV2ZHl1L0x1a2w4QjV2U25XenhMM0du?=
 =?utf-8?B?aG5rN1UyK1dYdG5MN2RTSFo2WFArdzV3eVlvaWxUcVlQTDkxKzVuL2pJTzZk?=
 =?utf-8?B?SXJWRkFmcytrSXJEdnBmd2lKeXcrNzltSHM1QVJUdVRSQmt2TmNEald3ZXNC?=
 =?utf-8?B?VGRjWElHZ1pFL0F5Tnd1QU9LVVJLUVFLaXNsOERkMzdFd0ZYY1BtK3RxRTEx?=
 =?utf-8?B?b2R1L25HNHVFZjZZRTlzK1FBZ2NpYlZERTdUT01PdExsZU9iM1NyUW9pcll4?=
 =?utf-8?B?bU41TzhQdy9qbVk4R0MydFdnQUxCNVpsdkpIVUpMcnpuZXpaNWNVR29KV25q?=
 =?utf-8?B?U1hJYjlxYWdJbkp4VThWT0IrMWJuNlBUR0U4UnpaRlRFU011WGtHUGxQZWYw?=
 =?utf-8?B?UWZrVU5QV0ZOZ2Z5UjRicnFKNkN4NTB3eXJqVWR0bzY2WmhSR285RnpEZWdD?=
 =?utf-8?B?ZXA5WVBEeDN6N1E5RVBVZ0ZKRXdZbFVlQmIwKzZ2NWQxRHhneG8zZmVDb05y?=
 =?utf-8?B?MVYvYkQxNER0cnBwa1JlM245cHFjc2NUSDlyR3V2aCswRGZJQnNlZ2pFa3pa?=
 =?utf-8?B?bHgwZUd4ekR0TXo4RC9Xb2VxcGVMQ1p5amxSVTY3QzEycXJZSEI0ZWhxLytM?=
 =?utf-8?B?ZXRJdThMbngxTVFBaEpIRUJoZU9vOFZ1RHdjcnFYOGJxWVpCM0V3WVAwRjQ2?=
 =?utf-8?B?ZGxkN0xKcGdZYUFPVnJzY3dwUjQvRzJmc0I0WmlweDgrKzhMb2FIQzlOSHlC?=
 =?utf-8?B?a2tibUxjamlSOXV0NzBJeW92aVYvNnp4bmx2TWZmcldEcEx5ai9HS0JWbkps?=
 =?utf-8?B?RG05NExWbHZIRXdIME9SY0lGNkk1RnVmSHduNENJZnBXbWxUQVZCeldEdXZx?=
 =?utf-8?B?NXl4Mzh0a2pwMFFlMVhPaGgvclk4b1lFZkRqTmFQeTNsTmtqcXpYTytEZXZt?=
 =?utf-8?B?VGMybXVHVUlWdVQ5Z1NHUHE0T1hnMCsxaXFyQ3RXdHBpSzJFRFlsZlZFZlRt?=
 =?utf-8?B?QXJOOVBrdlhnaS9QN0FBVlFmQUdPMEVhQmhqOG12Nmx2TmVTQ21WSW90cG1p?=
 =?utf-8?B?UnI0UVRRTXRjc3ozWXhRMGthcHlESWZ6SjM4VEtFTlVoUW9XdWFWdk5JODR2?=
 =?utf-8?B?cFoydFZpY1N5T1pXQ2laWnNTdi9GeVF0YWFZbE9xekhubExxdDBsb2N5dXk1?=
 =?utf-8?B?MHR3bHAvVXAyWTFQRmxnOG9IdjJ0YWJBUkJ2dm9PQmN6MDFrTUkvRDkvWjJw?=
 =?utf-8?B?YlVyMmU2Z3crL0RGY1F0YnJSSlE4YjdaakZBRWtqbXdKcHJVK0hCRDl3MlM5?=
 =?utf-8?B?ZEl5ZGtWU1RpTzF0azEwb3V6R2JBMGJsMDRxK2gxM1ZlY0ZDVWVnSGxxUkly?=
 =?utf-8?B?VFNVa2lRL0FSamhDMkRMS1F5WTcrYUZweVhVakU1WFNhY0VBZllPT0J5MUZP?=
 =?utf-8?B?NUlJRmxBdXpuNkM0UEZXS29aOTRQSXJHRVFDc3BQTmNtRGdCdFovUTVCQjVP?=
 =?utf-8?B?eDMwc3NUWE80UURtS05iczQ5eXZhODNNOUNIMk5ESis0YzJtVUgveSswbURv?=
 =?utf-8?B?M3Q2NHJJcDkvdEpnUWVVd2dmMzBLNnFPTElhc2l4YWxuRHU4djQxZVAwQlBT?=
 =?utf-8?B?ekUyb0EzME9SNFpIbHlUdVFDUlNVMGRQNVZFUjk3MEQ0VlZwcmFYNVZnTHlk?=
 =?utf-8?B?bEZnYUVLdDNKQXlWcWw1OCtoS2g0d0xCRFQ4eU53Nm5jMkNvOXQ2aG50NGZQ?=
 =?utf-8?B?SVYwdTl0dWZxWC85YjN4cmN5MEd1T2Q4ZUZmL1ZPVVNrN2FWRkV3L09PbTBU?=
 =?utf-8?B?TUhiSDFUbEVrZ2tvekhzS3ExQzh0SllXbnI4d0JaeWJDSnVPSTdRTTNsczFT?=
 =?utf-8?Q?c/71VCMNG9p8y?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb914e2-343b-401e-39e0-08deb0b7b1f7
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:20:14.7582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7558
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/11/2026 8:47 PM, LIU Zhiwei wrote:
> With the core MPT lookup logic in place, this patch integrates the
> permission checks into QEMU's main MMU processing functions.
>
> A new helper, `get_physical_address_mpt`, is introduced to check the
> permissions for a given physical address against the MPT. This helper
> is then called at two critical points:
>
> 1. During page table walks (`get_physical_address`): The physical
>     address of the Page Table Entry (PTE) itself is checked to ensure
>     the supervisor has permission to read it.
>
> 2. After successful address translation (`riscv_cpu_tlb_fill`): The final
>     guest-physical address is checked against the MPT before the access
>     is allowed to proceed.
>
> This ensures that SMMPT protection is enforced for both the translation
> process and the final memory access, as required by the specification.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu_helper.c | 112 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 99 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d0f0e77dfe..f0126bf534 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1211,6 +1211,53 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
>       return !high_bit;
>   }
>   
> +/*
> + * get_physical_address_mpt - check mpt permission for this physical address
> + *
> + * Lookup the Memory Protection Table and check permission for this
> + * physical address. Returns 0 if the permission checking was successful
> + *
> + * @env: CPURISCVState
> + * @prot: The returned protection attributes
> + * @addr: The physical address to be checked permission
> + * @access_type: The type of MMU access
> + * @mode: Indicates current privilege level.
> + */
> +static int get_physical_address_mpt(CPURISCVState *env, int *prot, hwaddr addr,
> +                                    MMUAccessType access_type, int mode)
> +{
> +    /*
> +     * If the extension is not supported or the mmpt.mode is Bare,
> +     * there is no protection, return success.
> +     */
> +    if (!riscv_cpu_cfg(env)->ext_smmpt || env->mptmode == SMMPTBARE) {
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return TRANSLATE_SUCCESS;
> +    }
> +
> +    /*
> +     * MPT is checked for all accesses to physical memory, unless the
> +     * effective privilege mode is M.
> +     *
> +     * Data accesses in M-mode when the MPRV bit in mstatus is set and
> +     * the MPP field in mstatus contains S or U are subject to MPT checks.
> +     *
> +     * In riscv_env_mmu_index, The MPRV and MPP bits are already checked and
> +     * encoded to mmu_idx, So we do not need to check it here.
> +     */
> +    if (mode == PRV_M) {
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return TRANSLATE_SUCCESS;
> +    }
> +
> +    if (!smmpt_check_access(env, addr, prot, access_type)) {
> +        *prot = 0;
> +        return TRANSLATE_MPT_FAIL;
> +    }
> +
> +    return TRANSLATE_SUCCESS;
> +}
> +
>   /*
>    * get_physical_address - get the physical address for this virtual address
>    *
> @@ -1408,6 +1455,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               pte_addr = base + idx * ptesize;
>           }
>   
> +        int mpt_prot;
> +        int mpt_ret = get_physical_address_mpt(env, &mpt_prot, pte_addr,
> +                                               MMU_DATA_LOAD, PRV_S);
> +        if (mpt_ret != TRANSLATE_SUCCESS) {
> +            return mpt_ret;
> +        }
> +
>           int pmp_prot;
>           int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
>                                                  sxlen_bytes,
> @@ -1818,7 +1872,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       CPURISCVState *env = &cpu->env;
>       vaddr im_address;
>       hwaddr pa = 0;
> -    int prot, prot2, prot_pmp;
> +    int prot, prot2, prot_pmp, mpt_prot;
>       bool pmp_violation = false;
>       bool first_stage_error = true;
>       bool two_stage_lookup = mmuidx_2stage(mmu_idx);
> @@ -1872,26 +1926,42 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>               prot &= prot2;
>   
>               if (ret == TRANSLATE_SUCCESS) {
> -                ret = get_physical_address_pmp(env, &prot_pmp, pa,
> -                                               size, access_type, mode);
> -                tlb_size = pmp_get_tlb_size(env, pa);
> +                ret = get_physical_address_mpt(env, &mpt_prot, pa,
> +                                               access_type, mode);
> +                if (riscv_cpu_cfg(env)->ext_smmpt) {
> +                    qemu_log_mask(CPU_LOG_MMU,
> +                                  "%s MPT address=" HWADDR_FMT_plx " ret %d"
> +                                  " prot %d\n",
> +                                  __func__, pa, ret, mpt_prot);
> +                }
> +                prot &= mpt_prot;
>   
> -                qemu_log_mask(CPU_LOG_MMU,
> -                              "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
> -                              " %d tlb_size %" HWADDR_PRIu "\n",
> -                              __func__, pa, ret, prot_pmp, tlb_size);
> +                if (ret == TRANSLATE_SUCCESS) {
> +                    ret = get_physical_address_pmp(env, &prot_pmp, pa,
> +                                                   size, access_type, mode);
> +                    tlb_size = pmp_get_tlb_size(env, pa);
> +
> +                    qemu_log_mask(CPU_LOG_MMU,
> +                                  "%s PMP address=" HWADDR_FMT_plx
> +                                  " ret %d prot %d tlb_size %"
> +                                  HWADDR_PRIu "\n",
> +                                  __func__, pa, ret, prot_pmp,
> +                                  tlb_size);
>   
> -                prot &= prot_pmp;
> +                    prot &= prot_pmp;
> +                }
>               } else {
>                   /*
>                    * Guest physical address translation failed, this is a HS
>                    * level exception
>                    */
>                   first_stage_error = false;
> -                if (ret != TRANSLATE_PMP_FAIL) {
> +                if (ret != TRANSLATE_PMP_FAIL &&
> +                    ret != TRANSLATE_MPT_FAIL) {
>                       env->guest_phys_fault_addr = (im_address |
>                                                     (address &
> -                                                   (TARGET_PAGE_SIZE - 1))) >> 2;
> +                                                   (TARGET_PAGE_SIZE - 1)))
> +                                                 >> 2;
>                   }
>               }
>           }
> @@ -1906,6 +1976,18 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                         HWADDR_FMT_plx " prot %d\n",
>                         __func__, address, ret, pa, prot);
>   
> +        if (ret == TRANSLATE_SUCCESS) {
> +            ret = get_physical_address_mpt(env, &mpt_prot, pa,
> +                                           access_type, mode);
> +            if (riscv_cpu_cfg(env)->ext_smmpt) {
> +                qemu_log_mask(CPU_LOG_MMU,
> +                              "%s MPT address=" HWADDR_FMT_plx " ret %d"
> +                              " prot %d\n",
> +                              __func__, pa, ret, mpt_prot);
> +            }
> +            prot &= mpt_prot;
> +        }
> +
>           if (ret == TRANSLATE_SUCCESS) {
>               ret = get_physical_address_pmp(env, &prot_pmp, pa,
>                                              size, access_type, mode);
> @@ -1919,8 +2001,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>               prot &= prot_pmp;
>           }
>       }
> -
> -    if (ret == TRANSLATE_PMP_FAIL) {
> +    /*
> +     * Both MPT (Machine-level Memory Protection Table, Smmpt extension) and
> +     * PMP (Physical Memory Protection) follow the same exception reporting
> +     * rule when an access violation is detected
> +     */
> +    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_MPT_FAIL) {
>           pmp_violation = true;
>       }
>   


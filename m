Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01187606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=B1wdsqSu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xORnF-00019E-1q; Tue, 03 Nov 2026 22:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xORnD-00018a-1c; Tue, 03 Nov 2026 22:36:07 -0500
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xORnA-0003FY-FE; Tue, 03 Nov 2026 22:36:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVHchsIThmAPLJKNu5uHVaPgvF5ZKI7tw71RxcHf5YDuk8bqE7UOl8nXbC/7txa6LzLdafheJZV5XOC2ouJ4fPz8k8KjpPGP4gaUmHyyEPO/VpJoEw4IeOXearFM5cVK7jedOiRJc9vfV32rL/7B8qD872smaWV8IbES3hpbzIgnknuRKAfZ6IvVeb4y6u5sTiqNsdYHLznLqE5uCEwDUcn8O4f/Xo1v64MZCNQGBvtm/V7CmlGCL3gTTdNVyAzMelHfp1tVnmh9bBQeiqkE9DjX6cXl7gzosAFvfAkHu6AschJgD5HacG+2Nesn3COL54ZP4vdUqQEoJc/2Wi8dPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozGR/qwimFUbDfa3ZJRZOJ1bby84DyMIsEWluNvQMEI=;
 b=Dv0qXfdPGvwKPzpvmvbuu1GevCqaLaDC8qMyNXBMiBl5Lfb101v3jLVygNa4HCV79eIticD1mrfRVUWB55KGGXkNW97b80Suhjcb0rEUj+m51GxegC08c5wVrGVB2CCvb34T83LmwhChz3a/etVXvYYWWx2gH3UiP2Nq6Q34pSqeI+ZaJg3XDB0cKNctvSha3td5ijTdIenEYWobmmCln7J3ydZg/+XCzjeydV1SEX8caPAoHIeYBr+FgAh42AXXKwJez/xOCqj9oHdTSw+a+AJB3OKiMCkg4AjSZUMaIbBy+PKdDr6Ky3RMIMDsou/vx0n9CJXw0br/zWUQWlRJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozGR/qwimFUbDfa3ZJRZOJ1bby84DyMIsEWluNvQMEI=;
 b=B1wdsqSuwPYemn2pa6BNP0n9h/TlVmMgoeADOfopLB/EwIXSJt+NWzxUKnJZFPrIrvvdmEvnHuKebcBTGtRJzBt2nCYH94DSMrsH7fDHO/X7Cl9hrmyzL4bvtNdYEUZnhNv53D4G/mwcHhsoJFXKugPa6K2gJQqAYrD4e8R80CCBo1AmNxbTdlhIErHYdg3xKEt930p7CKfa9DHzGP4xu+W0IAevPrc9g6bx34qyhFu5284wJoOBA6lOUJPb0apx8R2AQjOAPu7bnExTY8IQdskLbBzTliza9ZLddOUf9eECqUSTnQqW8nmBKDbm/3M15NEIHczYtRBj+se8392GfQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYUPR04MB6859.apcprd04.prod.outlook.com (2603:1096:400:352::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 03:35:56 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 03:35:56 +0000
Message-ID: <TYZPR04MB74910CC8F397763E4A0CE30FF3682@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 4 Nov 2026 11:35:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/riscv: Build AIA glue only with APLIC and IMSIC
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-2-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261101031547.125591-2-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::13) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <bbe4be0a-d3f1-4296-92c3-c18a0f0ec929@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYUPR04MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: c124eaf9-2637-4aae-6c21-08df3a24bc56
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|19110799012|55001999006|25010399006|4140399003|6090799003|5072599009|15080799012|19101099003|24121999003|22091999003|51005399006|23021999003|41001999006|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGRKYWhjOFpDbFlidjhJNFBTZW5LZ0ZxNkFkbWtYNi9vWHJzWVpEbGEzMHhF?=
 =?utf-8?B?OUZUQUF3cHJTSlplZ1FGOW84WEI3c00vcGdHYlJFUHFja2Vua3M1aXVGTkZ0?=
 =?utf-8?B?SnZVcnViT2ZDaWs1V0gzTDFNeGJZVzJvUk80RDhBcW41TDlRNUk1bURnc0Ez?=
 =?utf-8?B?Y2ZWR0ZaS2hML2VqUXZIRUVwWXVMcDA2OHFIODFBTGl5UGxkYU1odGlWVjhz?=
 =?utf-8?B?T2YvNHUvOEdVWXRQbDdTNzNVcm11ZG5pY3hXZzZ2VUNqek5mU1ZUVzZsSGVP?=
 =?utf-8?B?R2tvdEpQZDZFWFczZ04xZEMzOVg2M0NRWndNQWJ0ZmxRV1lXS0FUazZPRWxz?=
 =?utf-8?B?dE1PSjJieEw5bXdQVFh0U1BXaWxXemNzcU9IdFN6U2s1dGlSVnFMVmc4bjJK?=
 =?utf-8?B?Z3VSZU82Wllrbk93YUtqR05JY3VjaWdpRTBxNDhqalZBN2dXR2pDOFBSRm5z?=
 =?utf-8?B?bkVKWmZPUm9XbDVEMkM0Ny9yMzRmbGJXZ3lXYXZXMWhsT1cvM0NQbytWb0ZZ?=
 =?utf-8?B?OU9Zc1pUaldvQzdWOHFUdDNBL0dCckkraHNZUkdRbkpyYkhkaVBLb1JRRjYv?=
 =?utf-8?B?TUQ1V0I1QjlsNnM0OTBuTTY1dzhuaUdlaDhDckZ1eDExSDBBeGttc0JQd2VQ?=
 =?utf-8?B?U0Q1ZDdzd1JmUnc4TXc0amJjTzB1QlFCdmhCSUZQQm5ZVTVWVE13N20vR1V1?=
 =?utf-8?B?ZXlleWMydm9KTkJVSXdqWTUzV3Y5S1Z2UVI2NjZLVGFXZ29pQ09OSVpDbnNw?=
 =?utf-8?B?ck9RSTUyc29nd0VkTzBOSlpjSTNZSWV3VTZJeUJWa3BYaTA1ZzdiNmJZWFZN?=
 =?utf-8?B?TWthOEdjQm9jZVdWak5mcUNyNkZidDI5YlFYZEI5K0cvL2hGb0Y2VjhPRDQv?=
 =?utf-8?B?TzB1dHFGNzBwKzF6OElwL2p2S2s2bFpTcEN2Z0ZrVjEzTzc0N2ZtN3NrV2F4?=
 =?utf-8?B?Y2R3QnhuVm9MaHpWSndralVBelhtTDFmenNHZEpWL3B6dUhqVUlyQ3BSd1hK?=
 =?utf-8?B?YVQ2eSsxSDdaMjd1aGc3YW12MUxVbWx4N0RGUTdyc3VxRUZFVVhPUzVkb0FS?=
 =?utf-8?B?Vm5DMDVuUXFsaVQ3dFRIL2U0SitJTm8vNGhVYlRtdmtSTEhsVWhYWWRwWitD?=
 =?utf-8?B?b3Q5OVRWcmJIUHVoWnlFMXdCTnI4MlEyRGVzSU4rNnhXNXVpOEZHZVVKZWx3?=
 =?utf-8?B?WTQ0alEwTGxOQUZ3clpSSWF2SFVyUkowcGNkd1pwd3c4UllZTVNyZHVnOE5N?=
 =?utf-8?B?VTRmY2xra052em9lSmwyb0xUbUpyRXdWRW5vYlpqVmVURTlMT3ZDNkYzU0Mv?=
 =?utf-8?B?NHF3bmZiVTZheWdPelZPOGlqOGJ4NTUzOHViTzhZZVpVTENPMHRXUWlaVnNX?=
 =?utf-8?B?eW9xS3VDNmFBZ0ptWisrWC93RDhWbVRZeS9WR1NOL2RITU1tNUN2bjd6NG5n?=
 =?utf-8?B?WnNweHpkaEN0M25Sd21Xek0wV3hQRVZyYkdpbWtBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFBdXAxa1JwTDFaaE15U3VKQndHU2F0QlFiTC9qa2RJWW0yZTlFV2lHYWdP?=
 =?utf-8?B?SlkyMFp4UjJBZXFIak5PSG55d2VQWFdzSENJdXVhTFUxRGhQejNHVGwwcXlU?=
 =?utf-8?B?RStqVWtGMkRKc0piSDZZbVMwVXN4SkcvTHdhNVF0cXM3cll0Nk0rMnNISWdE?=
 =?utf-8?B?Q2wyTHova2s1cHBaUTFCcGVzZUFEcCtlMFpFRHo2KzBiME5JQ1dYZjVLY3Uv?=
 =?utf-8?B?cTlyeVpHcXhWbzBrZTlJVXVWNTI5blJOSVlFUWp3R3pGQ2h1RXV1b3Z4TGJM?=
 =?utf-8?B?VEZ2M01wcnBKTklZeXJLaU55U05TMkNvL3VaTHp3OFJsbjEwRFMxUXZIcWpQ?=
 =?utf-8?B?Y1Ryc1FkVm9KTDlwZ1BMTlJLWlhjSFZTNUlyalRURTZVc053d2E3QUt2VjJl?=
 =?utf-8?B?VWxFNE00cDlLd2ZSSkk1NHhBZ21TbHY2UlY5TzV5TTNUVENRVlJ6eTFkalJm?=
 =?utf-8?B?MStiUEZNNjdFV2wya0hWMVZjWWoxQUZhYUhBY1IyWTVkNGo5d0VEb0wvY0pU?=
 =?utf-8?B?KzdrK2RlRTUwUGI4MFIyNjhJQW8wT0RQa1ZhVlNjU0dIYzFES1FxKzVGOEJG?=
 =?utf-8?B?S2U5VzgwZ090QXRkaXY0a3RxbUIvbjF5SE5IcGhDV1kxS3k5RmtvT0gvWUIv?=
 =?utf-8?B?emVXVzdrbDczVDZkNnplT242T1VZbHNxSk5ya2V1YmhIUWpZTk1BSDNlc0JW?=
 =?utf-8?B?aXo3bUNDSVIwZUhjc1Q0N2VDSXlIWFlOTkpwUTBrWEV4cFgrNkhpNWdyUFM0?=
 =?utf-8?B?L1pWY2FIVVQyK0pXYjlQS1phWXNaZzV2WXhMazRjKzNFaE5BaFdGZkU1bk03?=
 =?utf-8?B?Mlg0d0NsWklrU3pIYy9oa3FpK0Z0S0g3Z29jdVZ1VVpXUzJKNldIMlVMUzB2?=
 =?utf-8?B?V2RtclM5elFEWWxJRkNRc2dCTHJ2RTNNTTR4bzJIWlo0ZnVPNXE3dlJYdUZx?=
 =?utf-8?B?VDFHVWZKTFRtMUZxVGR5SXE0OUMycTFxWE1ZVjFPT0MvSnpHcFdhRFhyVVhr?=
 =?utf-8?B?ejU2ckJXZ2U2ckhoeWFYYmpSU0RqdEw1Q0RFWitFd1o3c2FEMnk1QzZkWTc3?=
 =?utf-8?B?ZlhKVW1UL3VVVFRTY3FVZVZBR0ZYK3NCRklISU1JUGtrSXF4KytQVjN1MUxw?=
 =?utf-8?B?QmJxQnJDL1l1RFNjQyszc0ZlMjZGc091Z0p3NlFndlZ2eG1qRW93YUt4bDhE?=
 =?utf-8?B?elJBbUFZWW12VWRjNlR3WGxiNldkWTFCOGFXbkl0MzZ6NGFaWkxvM040Z2ZH?=
 =?utf-8?B?SXByU2Z0YkQ2WE1KRXpHbW5lci95Rm00Skg5UFdnOGxwdmgwbGhnU2N0Uitj?=
 =?utf-8?B?RThYbEVYc3NJSEtoKzE5K3pNLzZ4bVNCTVdTWENjNTRwYXhpVHcxNVNNcC9S?=
 =?utf-8?B?MFVZdUtMQWJDRlJzVWptbUtubTVjUXdBd21IRThsbUZWcWk0Y3VibFM1L2xI?=
 =?utf-8?B?MklxQ1R5RGpOMWxkNUFDYW9EcnI2QlRHUk1qVWRheHZyQVNKTk5kL05kZnB4?=
 =?utf-8?B?dFJZVlZpV0lBZm5DeTlwbmY0SExYTXVoQ1FHVHU3NURwNTZvRHVTWVVJZ2I1?=
 =?utf-8?B?c3FYdUVtZGdyUytqQlR0R0paWTM0VEtmdHZTb3lTUmh4VnBBZDJwWU80cGdz?=
 =?utf-8?B?dERxaXlsdmtnSDgrUzhINldkeWxvWlBFNmtiQ0Z5QUNGR1JlMzN0QlN1SUNI?=
 =?utf-8?B?V1NkNzVPdE5EL2VmY1g1VGJHTGQ5WWp6TEVCeDJOc2VtZ0lLYmZjcmZWT2VM?=
 =?utf-8?B?Q2lEVDlkQUtUTVkwUTFpUWl2Wm5ERkZIYWZiMWdRdE91R1NFNWhIWS9sbDB5?=
 =?utf-8?B?OFpkcVpaMnJJUENGN0V3K2JYZEowdUlPZWZEN1pNZWsxM2VmY0x4UkR1M0cw?=
 =?utf-8?Q?GfUxJL1LNzP4B?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c124eaf9-2637-4aae-6c21-08df3a24bc56
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 03:35:56.6312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6859
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


On 11/1/2026 11:15 AM, Tan Chi wrote:
> hw/riscv/aia.c is built unconditionally, but riscv_create_aia()
> references the APLIC and IMSIC device implementations, which are
> only built when their respective Kconfig options are enabled.
>
> This causes undefined references to riscv_aplic_create() in
> minimal RISC-V builds that do not include APLIC.
>
> Build aia.c only when both CONFIG_RISCV_APLIC and
> CONFIG_RISCV_IMSIC are enabled. Move imsic_num_bits() to aia.h
> as a static inline helper, since it is also used by FDT and
> ACPI code independently of the AIA device creation helper.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/aia.c       | 11 -----------
>   hw/riscv/aia.h       | 12 +++++++++++-
>   hw/riscv/meson.build |  3 ++-
>   3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 56fc064533..4463ea2be8 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -13,17 +13,6 @@
>   
>   #include "aia.h"
>   
> -uint32_t imsic_num_bits(uint32_t count)
> -{
> -    uint32_t ret = 0;
> -
> -    while (BIT(ret) < count) {
> -        ret++;
> -    }
> -
> -    return ret;
> -}
> -
>   DeviceState *riscv_create_aia(MemoryRegion *container,
>                                bool msimode, int aia_guests,
>                                uint32_t m_imsic_stride,
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 5df3292610..e4dcc5aae0 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -10,8 +10,18 @@
>   #define HW_RISCV_AIA_H
>   
>   #include "exec/hwaddr.h"
> +#include "qemu/bitops.h"
>   
> -uint32_t imsic_num_bits(uint32_t count);
> +static inline uint32_t imsic_num_bits(uint32_t count)
> +{
> +    uint32_t ret = 0;
> +
> +    while (BIT(ret) < count) {
> +        ret++;
> +    }
> +
> +    return ret;
> +}
>   
>   DeviceState *riscv_create_aia(MemoryRegion *container,
>                                bool msimode, int aia_guests,
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 6bdabb9544..957031c07d 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -1,5 +1,6 @@
>   riscv_ss = ss.source_set()
> -riscv_ss.add(files('aia.c'))
> +riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
> +             if_true: files('aia.c'))
>   riscv_ss.add(files('boot.c'))
>   riscv_ss.add(files('device-common.c'))
>   riscv_ss.add(files('fdt-common.c'))


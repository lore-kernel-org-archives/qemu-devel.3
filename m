Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F8606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=QKepSD/L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTnj-00069u-T4; Wed, 04 Nov 2026 00:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xOTnh-00069L-UM; Wed, 04 Nov 2026 00:44:45 -0500
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xOTnf-0005TN-Q3; Wed, 04 Nov 2026 00:44:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmqmZi7UO55xnLaeqmRRk3+fM7UlJEPtxSupGNHkdOC8jrJl6VCoHybToF3La05AdI7vbcdE/h8eFjStey1w3H+nGfAv6EIG6ZDc6l1N9TXt02kQ9ZF8SdeK50lcA/ajOyrKSVudFt8wtd9nTA1rGrrm3y3qvff7Iip2RtYTM35sCZhcfMcXb0XZQ+04WnT4IPro+R8vikP5cd9H7t4E8kf9kTfNULnT901q3zzj1weasgecLgY58irkDB1Rh5pFAtcL5h1vZtJMd9Doa0OJtEjxbQyq7dcgQp1udRKK9TD8AN1Qp2DsoIBOvjpig0THNytJj/5h3TBYHN17u9oMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTfm/v95D9RIMttn9qTniDq6XbZm6AcSlQdSTe5NRMk=;
 b=kn3Xx184zhtKo4bVWPufB/LXL5xprfwAxSm4qZuzAIz/dir6MoPnnbk+E5DZfw38MVvKu0UWsaCMoOA3XNZ+pd2oseSozc5W6UeudSKqVWZKSNVnohQYarR1CWaehzZ0jHMJKqBy0bGR79ikBx71eTvhI00ZVUQ5afzXyIIWA4esTt+NSvUCjMNVhfyxLhrUCRjeRRs+FEkIH8Yyq2gGBTvjCZz7aHUFq2gkxB251nxmCm6i9kWsPBBBWilnyEa5525M0x2Ta5zdaxAoi6jRYyIKYCck/ktnA4SFs3j+/nULZnfhzY3JO5QfpvmVXlEYWgt8HJyQfq9z6AldTHCYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTfm/v95D9RIMttn9qTniDq6XbZm6AcSlQdSTe5NRMk=;
 b=QKepSD/LJdyGKeQGLuXbucm9a777R9wmGXqdgdi2wx6aODqDrQzhujPX8I4zGpPx7QtwtQrJjxqgzuELRf39gF+jgOm2o2qwqERiTRO8cTfmnhRoYyz2/VaEf8k+K1VgtzwCiP5iHpbApr+t22BnP3kCPcP7VDOdlOuLfcz//J7MbNDezn1tvAyXT8w6EbNoDUnHuIHoSd4dMjw/05O3QttB347J7Ff3ONP1Ha72rROslGEXGnmv48OcrIxHY5PYvbQdTK+KdQMfqeJICkYu+Jwi0GBpzuS3oQ8sCkzp/dAc3iKjGS3OEHNCAfEIMtM9mkj1C57mNReGDY5tkTQaDQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by OSQPR04MB7780.apcprd04.prod.outlook.com (2603:1096:604:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 05:44:35 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:44:35 +0000
Message-ID: <TYZPR04MB74913F97510C0B1B70A3221FF3682@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 4 Nov 2026 13:44:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/riscv: Move platform bus FDT creation to machine
 code
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-4-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261101031547.125591-4-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY6P301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <3680928c-2282-4512-9093-8baf745ce10c@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|OSQPR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: f4794d42-e7dc-4eb6-8a2e-08df3a36b49d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19101099003|6090799003|15080799012|23021999003|22091999003|5072599009|24121999003|51005399006|41001999006|55001999006|8060799015|25010399006|19110799012|4140399003|3412199025|440099028|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmErWjVGa29FeDZHaENNZUEyZnhPenFRdjFpYWxmMmR0MkJQdnFMTzRqc3lh?=
 =?utf-8?B?bUw1WC9TaFo0bW9hVEtIZC8vWjhQQWdPV2Z6b1J6cXV2NzcreTh3bFBIaWdZ?=
 =?utf-8?B?ZGZFTFl2eHdVTklURVp2SmNzOGtwdis2RERJY2J5VmpFbXJlN3RkYy80MWlQ?=
 =?utf-8?B?akZ4WHBmTEJ3TGkxQ1NqOCtjeUJxQkF3UlNKNksxUXB1Z0RLMEo4bXpnQ1E5?=
 =?utf-8?B?NkNHUmk0UnljT0lEc3dMcEpUeEJzdU92ck1FNS9SOVQvcE1FRTNIWWU1Sk9o?=
 =?utf-8?B?dVNxby9jRjJVUVRSemxqbjh0Wms5MzZwTWQ1c3B0ZVFlT2Z3b015aElPWVVE?=
 =?utf-8?B?ejdib1EvbUZlVUFnK2k0aWNVKzMxb3RiR2Z5bGNpSnpZNmhxQmNBQUd6V1FV?=
 =?utf-8?B?ajZJUjRKQjlvdXE3M20wVi92c0xOK3BrMWNQT2VSZTloMTBUa0JJOUo3dmx3?=
 =?utf-8?B?eStXYlQxbVpYckNZdEVTemwzRE5hVnA0UGg1aksreGJUdW5FbjZtOVFQalVw?=
 =?utf-8?B?QUpMQlNuWGJvVlVEMjlQTXZzMG1ZdXgrU3IwQmFUajFyTWRZVVRCRGtPcmdm?=
 =?utf-8?B?UEtIS2FqbmtreG5FUGp0RDJnRmNVL0w4d1k0Y3FWL0FtMk5jOFJjLyt5dUhW?=
 =?utf-8?B?MkNUbnpNaktRdjI0S1A1VUo4VUZrQ1Q4M2VxTXJ3YzVaaE80NWhJRlprSHpZ?=
 =?utf-8?B?RlBScGl4NzhIVWQxZ3NUMTFPY3IzK1hLbDdDZ0ZhQUNLNk44Ynp6WnpRdUNv?=
 =?utf-8?B?dm9iaU1BNVkwVFduSGhkbVJHeU5icSsvZVlkWkxLdjZVUGZLZjd5SmFZS05z?=
 =?utf-8?B?bmk3eFVlVzVmcEVsNThNUjROY1hYd0NyQStKMFJOZkdEbkF3VXR6eVpVcTha?=
 =?utf-8?B?Nnp6TDU1N2lVSjh0MFI5UGtxb3NDT0czbU5Rd1NNSDUzVWRLUXJVQ2c0NUY0?=
 =?utf-8?B?ODJaa1NZSVYvV1FSc3BzajZaUGNTVVlycCtEdlBnS3lDNi9sNS9VQ2lpeStv?=
 =?utf-8?B?Vzc4Q29sNmtlUEQzNTAxdVJFelVLVllZbmJKVGgyd3ZnOVQxSzNzWVZKVm1B?=
 =?utf-8?B?aVk0dExzL3UwWEdLU0N6U25saWxWbzRyQzNTTEhaRzFadk5kOU1uVkRxdnRn?=
 =?utf-8?B?b2RkdTJ6VTZIaUF4aC8rRDJhejk4a3pQVGlxeWVQWm5iVkJCUHJxOVFrODlj?=
 =?utf-8?B?a3hwcDhrNHUyelZnemtJclljMHIwSDJmUnZ5d3FHb1JwQ21JdmQ2SXExSmZj?=
 =?utf-8?B?Z0Rjemx1TGRlUk9MWkRTQ3lVS05WTk5uZTdXWThNZXJPRFlhRFkyZWdSSGU1?=
 =?utf-8?B?cllTVDQvTndKbW9JMnJVcEpleWNmb1VRNE9HNVB1Q2kweXRTdEtkN2lHNjlZ?=
 =?utf-8?B?R0xadXRNVTluZ3FvaUVsTTJOUGVuSHRSS2tKdFoxZHo0cHh4MDRkdlh2d1cx?=
 =?utf-8?B?YTBxeTAxNUxPOTFDVUc5bUhyVnppNXMvMHNOZzBoMEo4RmVXdklmZUdIL3JM?=
 =?utf-8?Q?RAKhtXw6hf4TRwk4Is34Qr9zh9O?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y051aVE5L1VKM1F5S0xtVnd4NkhsYzR5ZmhBQTM0aGhjQWlWRkFHczQxZXYv?=
 =?utf-8?B?b2JTemh1V0FkZ21sMUxiVnZoYVZMT0h2M3JtRGlGTjg5cWFlYXV0NEpYZmM1?=
 =?utf-8?B?bFpWMGZQaFBzL1VXRm9NdTdZK1VjY0x2WGRqQjE4RHRYYndNczY3dE5qSnlY?=
 =?utf-8?B?YUZxL1pFQkJ5eFB1ZTN1aDFPcXFpT1p3aWpQUjUvWVorajJ6TSs1K3h5OVVG?=
 =?utf-8?B?MzVNMmJxQ3U5aHQ1KzY2ZkdTNWFWbGQ1ZTd1ZkFMdVlocEZVL3I1REVNU3Zx?=
 =?utf-8?B?eFgxVWtBOG9LcWIvdnZ5NTFjRTErakFnU1RmdWpJalVnMjdoV1BxUDc5c3JF?=
 =?utf-8?B?TnpUVEEydERZanpLeU1BN285YjJWYVVHL3RYbENPbS9MazVGTnFFNUN1SnVV?=
 =?utf-8?B?QUlqYkwwc2d4V1NmQjdNa1NHTm4wY1JZa0xDQTBGUlpvSGh5dmdoSGQvUzZT?=
 =?utf-8?B?VXVoVFJ3SFNPdkZPYy9rOTFKK1JJd2JIWnh2Y1NGQzczZ1ZNR3BSalVldDBi?=
 =?utf-8?B?cTBBdHBTbUk4eWpTdkQwbW1YdCt4N1FscEwwb3NTeU9talV3UWFnS2pOdnlU?=
 =?utf-8?B?UVBYa3djT2VQQnNmbjFyQmMvbkFrTEdtb0NxZE5rdlUwbDMvNWNjYjV6M1pT?=
 =?utf-8?B?NmEvd3dXcnY3S25Lait1Y2RPOS9RSEV5QVo2N1dsbUNmRDUxelRVVE5oY2NJ?=
 =?utf-8?B?d2FoMTFkR1h2WDhrOThES0cwaENzb01Ed2VJaEw5cEUzbHVjZDRYWUhES2RM?=
 =?utf-8?B?SXJSRXkrcy95UDQvTmZ1cUdlMVVSSTlWTzVFdi9XSWRMSVI2NWR2Y01OMm01?=
 =?utf-8?B?Y1Q1UG10Y01LR1l6RVNPK0FHTmJHYzZjdW51bFhBc1lPcjN4VlZ1MG9GU1po?=
 =?utf-8?B?QWtxdk1lTUpxazNwUWN6WGkzWUF1YkpWcWJUVHZqVXdzd2hzZDVtcHJiUjNl?=
 =?utf-8?B?R0piVzdqeWYyVjlHSG16OE5vVGwzNVlNaW81N2J0N3NNRzVXcCtqUkhPdzh6?=
 =?utf-8?B?MnFFKzNLc0tNZWJsT0pySW04eXJvWnpDRGJvZSttdmw3YytJbm8zWXF2bll6?=
 =?utf-8?B?RWdCYlJSTHN1bnNWNHk5UTd3TGJ3MDhSSDQ1ZDQ2SVk1ZWlubko4NCtMV0R0?=
 =?utf-8?B?ZG92MlVGOXZBZ2EzWVkwQUtSU0ZiYTU1OUordk84ZUl0d0RDSUVkM01zR1RV?=
 =?utf-8?B?c0ZyS2FUNFVxazE4L0plSFEyK0FLTmJ6MTJVdTJwT29iZlI0bGRpbitGU1Zl?=
 =?utf-8?B?Y2MrdVQ4RU1xSTlLQ0tLcFBvNUp6cFBBbmFzcENZbUNmNG5EalM3MWdkTGti?=
 =?utf-8?B?Q1JMNURpOXc5aVR4TUpUSTVaVEJkL2EzdE1mVkgwM0dFUGZRUGlIV28ycGdG?=
 =?utf-8?B?VXp4MUtBOFNpMHV0VGxQTmhZd0pieEE2bVp1Rk1iVCtxQWhiUlVqdHBwVldm?=
 =?utf-8?B?WjlkeXVlSmhMazllcFByNnJDRzc2eDNkZUFMRmhXbUhoNDBKTnVIa1RNR3Ji?=
 =?utf-8?B?TWdIZGsvb014Z3hlbjhicXNMTC9FR3BUcGp4NmhWbThTYWdoNzZMaVBQZFZl?=
 =?utf-8?B?VlEyYU5OZHVoNEpmRTdIMGtIbEZwMXJQaTI2bHBlV1M4OUxyM1BUZU9VdDk3?=
 =?utf-8?B?SjRzb01UN3QzMnp4dTRadUdQcUVIb1o3VWwzaFdVTVJyOXJ3MVVQTkUxdUdu?=
 =?utf-8?B?REQ1YllQaTdITGtZN29GUDRFTjJpdjFVd1VTc3VhZUo3cHNtWjhKTXBienc0?=
 =?utf-8?B?K051NmFpM0pXeXdtUXRya0Q3NUNNUy9ZYTVQWHJqSENhT01jN0NzOW1uUEVV?=
 =?utf-8?B?QkIxV1IwdEc4Q2h3eTR0K1Zic2Y2Mk9rWC9TRlFNVHJWYm5aSG9YMSs5OFYz?=
 =?utf-8?Q?hNkDOxsrF+fkF?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f4794d42-e7dc-4eb6-8a2e-08df3a36b49d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 05:44:34.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7780
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
> riscv_create_fdt_socket_aplic() contains a direct reference to
> platform_bus_add_all_fdt_nodes(), even though fdt-common.c is
> built unconditionally and CONFIG_PLATFORM_BUS may be disabled.
>
> This causes an undefined reference in minimal RISC-V builds
> without platform bus support.
>
> Move platform bus FDT creation to the virt and server reference
> machines, which both select CONFIG_PLATFORM_BUS. Export a helper
> to obtain the APLIC node name and remove the platform bus fields
> from APLICFdtProps.
>
> This removes the dependency from the common APLIC FDT helper
> while preserving the platform bus interrupt-parent configuration.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/fdt-common.c          | 13 ++-----------
>   hw/riscv/server_platform_ref.c |  9 +++++++--
>   hw/riscv/virt.c                | 11 +++++++++--
>   include/hw/riscv/fdt-common.h  |  3 +--
>   4 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index ce2dcb43b4..e90502b1bc 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -11,7 +11,6 @@
>   #include "qemu/error-report.h"
>   #include "system/device_tree.h"
>   #include "hw/core/boards.h"
> -#include "hw/core/sysbus-fdt.h"
>   #include "hw/riscv/fdt-common.h"
>   #include "target/riscv/cpu_bits.h"
>   #include "hw/riscv/riscv-iommu-bits.h"
> @@ -599,7 +598,7 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
>   }
>   
>   /* Caller must free string after use */
> -static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
> +char *riscv_fdt_get_aplic_nodename(hwaddr aplic_addr)
>   {
>       return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
>                              aplic_addr);
> @@ -613,7 +612,7 @@ static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
>                                    uint32_t aplic_child_phandle,
>                                    bool m_mode)
>   {
> -    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> +    g_autofree char *aplic_name = riscv_fdt_get_aplic_nodename(aplic_addr);
>       g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
>       static const char * const aplic_compat[2] = {
>           "qemu,aplic", "riscv,aplic"
> @@ -695,14 +694,6 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>                            aplic_s_phandle, 0,
>                            false);
>   
> -    if (!props->socket && props->platform_bus_irq) {
> -        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> -        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
> -                                       props->platform_bus->base,
> -                                       props->platform_bus->size,
> -                                       props->platform_bus_irq);
> -    }
> -
>       aplic_phandles[props->socket] = aplic_s_phandle;
>   }
>   
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index 5f485b1c79..3526c80d79 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -192,6 +192,7 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
>   {
>       int socket, phandle_pos;
>       MachineState *ms = MACHINE(s);
> +    g_autofree char *aplic_name = NULL;
>       uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
>       uint32_t xplic_phandles[MAX_NODES];
>       g_autofree uint32_t *intc_phandles = NULL;
> @@ -251,8 +252,6 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
>       aplic_fdt_props.aplic_m = !kvm_enabled()
>                                 ? &memmap[RVSERVER_APLIC_M] : NULL;
>       aplic_fdt_props.aplic_s = &memmap[RVSERVER_APLIC_S];
> -    aplic_fdt_props.platform_bus = &memmap[RVSERVER_PLATFORM_BUS];
> -    aplic_fdt_props.platform_bus_irq = RVSERVER_PLATFORM_BUS_IRQ;
>       aplic_fdt_props.num_harts = ms->smp.cpus;
>       aplic_fdt_props.numa_enabled = numa_enabled;
>       aplic_fdt_props.irqchip_num_sources = RVSERVER_IRQCHIP_NUM_SOURCES;
> @@ -270,6 +269,12 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
>                                         xplic_phandles);
>       }
>   
> +    aplic_name = riscv_fdt_get_aplic_nodename(memmap[RVSERVER_APLIC_S].base);
> +    platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> +                                   memmap[RVSERVER_PLATFORM_BUS].base,
> +                                   memmap[RVSERVER_PLATFORM_BUS].size,
> +                                   RVSERVER_PLATFORM_BUS_IRQ);
> +
>       for (socket = 0; socket < socket_count; socket++) {
>           if (socket == 0) {
>               *irq_mmio_phandle = xplic_phandles[socket];
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f..7ec7596b24 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -290,8 +290,6 @@ static void create_fdt_sockets(RISCVVirtState *s,
>       if (s->aia_type != VIRT_AIA_TYPE_NONE) {
>           aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
>           aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
> -        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
> -        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
>           aplic_props.socket = 0;
>           aplic_props.num_harts = ms->smp.cpus;
>           aplic_props.numa_enabled = numa_enabled;
> @@ -347,6 +345,15 @@ static void create_fdt_sockets(RISCVVirtState *s,
>           }
>       }
>   
> +    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
> +        g_autofree char *aplic_name =
> +            riscv_fdt_get_aplic_nodename(s->memmap[VIRT_APLIC_S].base);
> +        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> +                                       s->memmap[VIRT_PLATFORM_BUS].base,
> +                                       s->memmap[VIRT_PLATFORM_BUS].size,
> +                                       VIRT_PLATFORM_BUS_IRQ);
> +    }
> +
>       riscv_socket_fdt_write_distance_matrix(ms);
>   }
>   
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index eb9db8278d..b3b14ada0a 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -54,8 +54,6 @@ typedef struct IMSICFdtProps {
>   typedef struct APLICFdtProps {
>       const MemMapEntry *aplic_m;
>       const MemMapEntry *aplic_s;
> -    const MemMapEntry *platform_bus;
> -    int platform_bus_irq;
>       int socket;
>       int num_harts;
>       bool numa_enabled;
> @@ -129,6 +127,7 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>   void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>                                       uint32_t *intc_phandles);
>   /* Caller must free the returned string.  */
> +char *riscv_fdt_get_aplic_nodename(hwaddr addr);
>   char *riscv_fdt_get_uart_nodename(hwaddr addr);
>   void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>                              int uart_irq, int aia_type,


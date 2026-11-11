Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E31606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=H+W1zSAJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR25D-0003by-ES; Wed, 11 Nov 2026 01:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR259-0003bX-TE; Wed, 11 Nov 2026 01:45:21 -0500
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR258-0005tU-16; Wed, 11 Nov 2026 01:45:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/wibIZcfkK10sifnNqC74glPL5ROSHdUFHVDz4FHmlHoknDQMq76ULO9n/0tgp6UpcThu/bQgNT6BKOG3jWfayBY0HrHUzyHxU261cuRiNKMatonzqlEwHskXeNry3UMJ/aeKDoDgeCzv05AoFf923GESNyDAumF1HX44FzAEoZEj7MX7wsy8SbXx5Hew0cZJUfnJ8braoCx3MtAQS0YBhzw4FqNB1FlovPvnQUXfhQgxRoub1Bl2FT2wH6Pi7homLEUpaYthNC0X/+hB6jL0mAfq41SIxF3jaLV/E4QnThi5Qzu7jtZfONq5zIai3aYS5f0U5El69vYdOtV6vtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4rYX8wj/ZAhWwrbIhBcqwinzS1uA2IfX14O/CvTGE4=;
 b=DA0f6ZYaVAZA8TdnrecV/KQDAKmRw3PDQgg5NAlj5B+75bNqdeyw04RrjGPXjLRee8oXwWOiTBnpN78++/QO699F3qTtE2ABsvqRAx7VTjAXW0LtwMAXY14/XidMXk/Bi2SNxjQ1uNsJVflaBvPepWsVoWoPsNkNvTFDeINJAevEekodC1z6KXkH7wqkTYm/3y3bSSf9n+ka/FE7VLfFfL3cbPWpc6NePJmKoDYHRxDD3Y5IJZs6iy+JNh3nD+6jvSGhXjNBa7avIDODBSTfuepcgunN4U5UB3yxOTxKYxKW8KkaSlSE6ApENJljkAs4vh7sQfgnMQ+xcpOknqY0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4rYX8wj/ZAhWwrbIhBcqwinzS1uA2IfX14O/CvTGE4=;
 b=H+W1zSAJknFwstR/pCXGVlkWfQo67nnpCCMo+kPrsnclL9MCQqYMfaSQUQAO0CQqWt+cYNcfQRRZMGLA+FI0KbfZ3dt3V1JJDdxRTT0o0X9VvDrfxNfYAE8C4n1M0Qwzs+b4OuJLWVidrZniTRIemUi9jAIJxPyuGwwOjxBxDrPkKhPrzA3YJ0A1/7p5OkT+W2YUqgf8DaVPL3qyAsu4dzbqo/xfG0iXqjQREY05q4kzGqR34WKjCB+y4rLsn5DCj63/GM3TGvQSpudCSCTv4nMPTrbz+gfSPxDlYmrgv1eGTJEIytvzo+O30RXzWghR7ah3aILfE5OYJr/+FNZClw==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TY8PR04MB9769.apcprd04.prod.outlook.com (2603:1096:405:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:45:09 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 06:45:09 +0000
Message-ID: <TYZPR04MB74917C93A61B55EDF55FDE60F3712@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 11 Nov 2026 14:45:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/riscv: iommu: Check permissions on IOATC hits
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
 <20261108143934.129923-3-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261108143934.129923-3-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <61b4e38d-2a0b-4e75-a7ef-478fe65f0ccb@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TY8PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3b9008-dbe9-448f-f13a-08df3fbf53b1
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|24121999003|15080799012|19101099003|19110799012|8060799015|51005399006|22091999003|55001999006|25010399006|4140399003|5072599009|12121999013|6090799003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2cyaGplbFpEb2xDcGpjTHY0bmhKbEhrQVE0RDd2a0kzK3AxK20vdnUwSW8r?=
 =?utf-8?B?QkpuM016TFhGUWNnOTVZZkRQSzhuTVpPTE0vbEF6UVJYY1ZTcmJ0eUVmMW9Z?=
 =?utf-8?B?RWR4Q1I2emNDVFkxLzRuS0xBdEE0eHFJWTRPeEhjN1NJMEdMMk9jQWZrTWls?=
 =?utf-8?B?UnRtZmFZRVFrTG9HM01iTUphK2c5RXAxQjFkanJka2w1VURJWXlEN2IvSEJB?=
 =?utf-8?B?MGFUb2RMZGRxWDk1MnVNTUhpK3Z6QjhTK0VneU9MaUVielZEK1p2U2hkRk1a?=
 =?utf-8?B?cGh6RlNWaXU5cEFNMUZ6MEFxOHFGOE9nMXZaT0w3VXViOVUrSlRwa2Q2TnZw?=
 =?utf-8?B?V0MwOHljTWRja1VFaW9pV1QyNnNxR3h4TUdIU2IwS2o4R1Q5TnZ2WjdLQm1p?=
 =?utf-8?B?R3NISlVZRnR5Q0tCY1VZWGRmbVV6aitYOE50L09lNDg0S2t3VkszMGE3cTFi?=
 =?utf-8?B?UFZnSkg4dTl6WGhpZnl6VWt4SlpLdDJQRUwvcjhKN2lzRTI2ZEdkZGY4QUJY?=
 =?utf-8?B?YjRuVFdjK255ZEM5cTFBQnpqdHBaMkdVT0t0dEU5MndiU0wzRTVhK3VqclNo?=
 =?utf-8?B?bzhiT1UrUk1raWtWMDlTV1BOZjFJZ2ErVkk1cFVDeHpSUGxJeFZzQUlUaFEz?=
 =?utf-8?B?M3dldThnTUpMSTZHSUlRSUJyaDNmOHZzQjJ3aWhrUEI5OUdIRERSa2NCM1kz?=
 =?utf-8?B?T2JDZjlQek9pUGh1YUpkVmtMd25DZDY4T3pabG01R1FnR0xHRlRJckxmaGlJ?=
 =?utf-8?B?QkdXU1Y0VVhoS3FZb2k1RWgrT01MbmJrZG1jcjhqSDBYdFhXZVBNUGV2cnBu?=
 =?utf-8?B?S3drdCt0d20xK0xGTjMrcGhlSzF0eEFNOGVHUjFJNUEyMmZWMkZIb2ozVHg2?=
 =?utf-8?B?NnZsU3pGZy93VVlMci9wbUM2ZVdTUkwrTVdLMjVrYUlOQkx2M2hpTXlWL2RI?=
 =?utf-8?B?dzZmK1MzNW5ndlUxUnc2Z0tWZXB2anRxNi9EYmxxR0dCSWtJZlpJR3N5RFNC?=
 =?utf-8?B?cjhLanR2dlN0OFRwbjlBM3JQSjludTJ3NkpIckk0dy9ZYk9qSy9OaGJOZ2pB?=
 =?utf-8?B?OWJ1MkRYaDZEcjhQajI0WEdIb3lyclBySzFuUXl2clFmYWlOWndXMk1UZ053?=
 =?utf-8?B?cDJXSnowNjJwV0JURmdhV0E0TkprU1JSbEVqV08rTGt6bmQveG1TbkIzeSsv?=
 =?utf-8?B?MXpubkQ5UkIwQXdZT0sxT3JrOG1JQlliV3ppV3dxeHFJQ3BtZzFVNk9mWTkv?=
 =?utf-8?B?Sy8ydjZkY1ZNcldITXZNUE9vNHV4Vms1cXhhL0x6MHk0Ty9oQ3A5Umo0blV2?=
 =?utf-8?B?dlF2OHU2a1U2MTZjQTBETHBvTXBsaHluKzgyZU5OckVIK2VYTWJtbHZHQ0JY?=
 =?utf-8?B?My9xWm9CRjF0SFd4cXJtNkNUQlJCblpYcWdDdlk4dVc4eVpxR3VPMWwwMkJp?=
 =?utf-8?B?elhzYTdqZ3h3NEVkcmlXdjY3bnpIdXdmUFp5STBRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZOMXpSUFNXM3ZGNjU1NWU0VjRESThldjhNQ1UzWFcyRGlWNG0zSStlRGNh?=
 =?utf-8?B?TDFPbU9qazdyWUFBM3hUTzJGWnZiL3Jsd2RqNFVsemlKcEZJMFZyeFlTcTBM?=
 =?utf-8?B?WGRKOC9DY2hmVGorT3MrSEZ6UmZvRVBpV0F6dGlCQUhwSVdTOU9mK0t2SkNB?=
 =?utf-8?B?WDN3RzhxK3JqSlc2Qk4zUjgyY2dLTzhCNGVzeGRsWnBwMlhXVTdUZ2hlWmgz?=
 =?utf-8?B?clBjb0FhU1orcWNYN2hpaDNiMTBDS094M1FuUUp4dXBFUTdxMDZhSkdDZ0tt?=
 =?utf-8?B?VzlkVjZkZ0ltVXJyZUcrYWZOZWgycXZOVENXR29VZm5ZK3o3S0NxSDRkanlF?=
 =?utf-8?B?K0ZGY0ZacnRsV01hdDZYU2lMRlFCZWRaZTViNktzMlpTeVVkY0FwczBSdVI2?=
 =?utf-8?B?Ny9jUUQxakxhYVc3UmFQZk9mVXFKUElVOWtUVGU5UmtNMmtybGQ4UFc5Z2ZF?=
 =?utf-8?B?Z0s3RVZHczRMeUlRb2JtWWxIczBYMXZ5dHRoYUVHd3VzU2dQWE9ja2U0cXRR?=
 =?utf-8?B?bGdnUVhnZDJhSjk2bnV1THpGM2NHU0RjanR1ZFBaYlFSOEk3a01SYmlJS0pn?=
 =?utf-8?B?MTRLcDIvdVpkVDZwUFgray9jNGdWVlVjSXIycHJzR2h1TmZjanJTSTBiYXpm?=
 =?utf-8?B?VWU5SElEV3hnTndpTHh5aTNIVXk5TlJybmZkbjUvYnRudnVzakZSYUx6eDcz?=
 =?utf-8?B?eEU1MjRtU3Q2aVR4VXB2empuN1R4cDh2MlBWZ3lBR293aVRTTm0wZ0NtS2ZO?=
 =?utf-8?B?eHBsSG1NaDhhaS8zN1g4NGE0M2tScld0TG5rWkl2cnZuT2p2RFlsUHcxOEYy?=
 =?utf-8?B?bTVJSDVIRHZzdVR3OFZOWFJtUVZPZ3VEWC9NbDQ3TUVtQU1rMlJQOWJQblhU?=
 =?utf-8?B?T1p3KzBDUHJueGFQRWJKOHpGSTZZdWVvUGhSeis0V1BLV0pWYitSU2h5Y04v?=
 =?utf-8?B?ZHZ4U2ZndEFiTG9YZ3ZvVGhXUkVJUnhlYWdvQ1hlcXh2SVEwcnVrZVB4OTFh?=
 =?utf-8?B?cVUvNmtnbVlSMk85c2ticncrb2RyOWh0YTQ4QTZIWFFWeW4xeFBxeWY1WlJE?=
 =?utf-8?B?RS9tWkZqakwrSDlOb3JHODc1Slloa0dWajFabWJvUno4TVdwWjlKaWZJMU1q?=
 =?utf-8?B?dnU1aWdKVFB5TFBMcTNqUlI3eFZEZWNmWXVKSHg4OGxkQXZBaDNuVE5xbEJk?=
 =?utf-8?B?VUpkQlNnVTAzK3g2UVh4Y2RocjhoRHZEWTNUSFcwaUtpdTRDcldUVE9WQjlB?=
 =?utf-8?B?ZXd2MEs1Tm4zQ25JWUtNSHgzNjRNRWg4OUVURHdqeXJFUVVyaEFMSjcxQ2U4?=
 =?utf-8?B?b3ptaVpaNkpxRjQyWkd3WnlwbDhmNVZSTUxVYVllWmNmTFRGTjFqbnVKS1lO?=
 =?utf-8?B?eERLRWtaZHNMak15QU9UUi9DcVFnMWRTM2VkdHpTcUk0VlpQRDBkUjlQWm9h?=
 =?utf-8?B?MjJLY3RuWm5RL01YTVNkZ3VzRXJEMzFtRU1VR09oVWtzWUNLeVVVWm9rVlVJ?=
 =?utf-8?B?MGtyK3grV3YyV0MvYTZLNFlkV3hydE54QUVkeUJKQjM2b3IvWDFUWXpEMm9N?=
 =?utf-8?B?TXc0R2NHTUxTZEVZKzlDSitiM1BXNjI2Wmg1VkxneDhzS1hxZ3JZZ21Ec1Fj?=
 =?utf-8?B?dHdxa01sZmFRT2pUeWNmRDg5OTQ5U0ZYeEY5QlhNSHVuajV4M0ZveU0zSFNt?=
 =?utf-8?B?eU9jeUtVMW1mM2syYURha1p4NlVaaHVBdERNQXZqNGNoc2FPUnRmc2dxNUZI?=
 =?utf-8?B?VUZTa3BpZlJ3KzhVSy9Dd016WDZJY29OWmRjTTZiZmtVQm41MWxwMW1Hcysy?=
 =?utf-8?B?eHVQTGxRYlRoTjhyZWEzQ1pkbWFwdnhTNjBLM3ZhOEI3S3hCYWNFTUhuZURX?=
 =?utf-8?Q?OKCx3+CYn5N4F?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3b9008-dbe9-448f-f13a-08df3fbf53b1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:45:09.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR04MB9769
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
> The current implementation reuses cached translations without checking
> whether their permissions satisfy the requested access.
>
> Only reuse an IOATC entry when its permissions cover the current
> request. Otherwise, perform a page-table walk to check the requested
> access. Preserve the existing behavior for requests with IOMMU_NONE.
>
> This is also needed for hardware A/D updates, where mappings with a
> clear D bit must not cache write permission until the bit has been set.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 2dcc528599..6760699eb8 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1781,7 +1781,9 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           phys = iot->phys;
>       }
>       qemu_mutex_unlock(&s->iot_lock);
> -    if (perm != IOMMU_NONE) {
> +    if (perm != IOMMU_NONE &&
> +        (iotlb->perm == IOMMU_NONE ||
> +         (perm & iotlb->perm) == iotlb->perm)) {
>           iotlb->translated_addr = PPN_PHYS(phys);
>           iotlb->addr_mask = ~TARGET_PAGE_MASK;
>           iotlb->perm = perm;


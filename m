Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64E0EE6446
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 14:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vawqX-0003Mv-DT; Wed, 31 Dec 2025 09:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vatLP-0006VY-4R; Wed, 31 Dec 2025 05:22:19 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vatLN-0003ZD-Iv; Wed, 31 Dec 2025 05:22:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ4TdW8vWNqMpr2dSeXFUReqMoehJj2uwtCbwcts4yiPJlDA6qEsCHklUyofZ5hLeXYT6KjyqERNPir11q92P4ChJX0L2/S12yx/Oxaj9LUvGgvTkJ73Z/+1/QQF1GFJHtTBYRwuCbbOysaOcE3NSK6tcEzApwuga3ALLh/GBzhmvqSrlT07Mdf+FYNTFzkdlfy9ou6bNFp2pKU+5bUkgBA17+vRd+pOArA9xpBNNQmxnr8wAKv5UxT2HXNMM4Tr+AJ/W8G1Qm3zUF5VsT72T9wgK8oJxeEyq9Ivk0h7Af9+W5nFwHYkTowFHykFetqsAibapRzFbR4MD8T41LZqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEZRNFpjfQtC6s8K5BlXt15ylRm5esXV7pnVToCZt9w=;
 b=GDO5H9O+Bsq5/PuxJtYDmoC569o1itqRHqGQY2OwT82k8vpJnhCRmGDyNO/UUFozJr7YCgGb9qbiAj1h5iGpO3VMFeSt1Y+CBb0WjDBDcbL8odRlV/zHoplXgY40wvbQaQEKDGX351IOiQX8ZCJcPpXFWw0+4riA9pd/lhPidFQyLqRf5rewEowv1xNhX7Td0JMVlzSIUkwEBf3y154FwQo9iwrI7Xgu18iPLH+BTj09igpck5Sji77gb5nBtUY4WdAdg6ej1Asbvv88E8sKllEHsLgJaZuT4Ked0wIqeYOSmB42jeWet/cipoinYJpqa2sxZ28sAgj5xm7jmaHXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEZRNFpjfQtC6s8K5BlXt15ylRm5esXV7pnVToCZt9w=;
 b=ha0j3ZZdTu4fiKF8ONaHQKJyDVUNCN2+Qa5e2I2IDvwSLvbA/uQKslWIUj7CJJ9mxtR3BfV7C48s9ShSIm1qfLaZXpv6WFuAXtSzwnU2u3MovGn+8fbZP7HEQ/xERwzC1TRcut8A0Vik9sXh8m3YMG/HQj+mV3LV0GPq4acpMmCouaMhhfS5f0WF18s8ci7F8aMZi9BdrRMYMYNAbJpB6pDLtw4BPG7QYyD3HDWdVzqRLR7Ms1xjvlfhkZe7pa6VbKv/uc3TdxLvINTePo7lkZPlFd2RgrKGKRCBEpR7DO1R87FTO/kfnxm+h2Hngt37CBxG1RwFhgyw90BGdQE12Q==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by JH0PR04MB7464.apcprd04.prod.outlook.com (2603:1096:990:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:21:37 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%5]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:21:37 +0000
Message-ID: <KUZPR04MB9265D5918E0DFA99C8326A4DF3BDA@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Wed, 31 Dec 2025 18:21:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv: Refactor riscv_iommu_ctx_put() for Bare
 mode handling
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20251211025611.99038-1-jay.chang@sifive.com>
 <20251211025611.99038-3-jay.chang@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20251211025611.99038-3-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To KUZPR04MB9265.apcprd04.prod.outlook.com
 (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <e147f464-e0b9-41d1-ac4c-0fd158d116d3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|JH0PR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: e13f992e-b71d-4cbd-6622-08de48566133
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|41001999006|19110799012|6090799003|23021999003|8060799015|461199028|15080799012|7042599007|5072599009|56899033|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SklOTzNZVldLdG9JSWxZaHlUbHFHTnFwSnEzS1ZTM2U0YllQSnYyTFhCeUJX?=
 =?utf-8?B?TEhyNk8wV3VPS1ZLVG5EdEdCQlNhWEVzblRKS1E1YUpZQWpudkVFUkgyUVgy?=
 =?utf-8?B?cGkwWDgwZ2haaytEOTY2K1ZGNW14SFZlRlE2TnB1RE5kcHJUWVphbnJlU1BQ?=
 =?utf-8?B?T3cyNXFMRXF5bTNDa0JQY1dDUHh0WTJmSnhlTnhJTE90OHN0ZVZpWUVJaW84?=
 =?utf-8?B?SDlZVlpnVUI0UkRLdjI4aWcwQ2JvUjQ5UXlHR01vc21aK0s2bXdNSlRBU2tJ?=
 =?utf-8?B?ZkF2aG9pdVIxanRWempyaGhKcktHOGFrSUdjejgwb0RZZ05nMGJQZDNWZTUw?=
 =?utf-8?B?L2U3eUxERnR1STIrT1Y5Q0NiZ1V3Y0EwbXBsWXZDMkdjUU1iZEFIWjdIQTJu?=
 =?utf-8?B?U3B1QVJQK2pidTZ0dXpJd09DMWoxeGttMkdURTdRTzYrWUc1Qk0vcFVhbFQ4?=
 =?utf-8?B?cjBWRGltZG9Bd3k3VG8rbUpTVmVTRXY0Y0pzVjRCWjBNaThIZXFUZ2s0QVA3?=
 =?utf-8?B?WENqOXB6RW42TVVhTWY0T0ZVODlmK0FDWTVwQ0dUcXMyVmZ1Y0hNd2VJWTRU?=
 =?utf-8?B?T2RkcWdINUtLV1R4NmVXQnFqNWNJSnlvZTRiT1M5dGI5V1I3Wm40UzM5bURs?=
 =?utf-8?B?SktsYnh4T1FBelliZFdXTDN0U1lQcHFtTWlYLzZKdll6RWVFYzZKWmZLS2Uz?=
 =?utf-8?B?b0Z1UDltYVpnbm9BbWhLNXYzTmdCbTNkVTBmdFhtbktQdFZiUlRIRitaRk9H?=
 =?utf-8?B?QWJCWXdWL1ZKQVFPeHJjYkxOVzQxejhDeVBzdTBFbzhkR1dqYVBBdU1lam5q?=
 =?utf-8?B?bUE1NWhUTkNCc0RzbmkyekMvMTJHWHM0d0xjeEk4WEY1WFY4UGhDNGwwQVdk?=
 =?utf-8?B?TkExd01RSFZHSmw2allhZEJKRW5ibWF0S213bng5TGtrWmVGaVd1bC93TGdY?=
 =?utf-8?B?dzl5ay9kV1FGRkNXSTQrWTNSMm5sNlhNdjlBdGFSMTU1eUdGazI2VHVpOVhs?=
 =?utf-8?B?NGlRbUE1bGJCRTUrT1FXS1YreWZiaUkrdDVyVWdzeXNrZmNHVTdIcnB0L1Ri?=
 =?utf-8?B?MlFjeHVpNVdibjczVEkvaU5ZQXF5QStUNVVxOFh6TmFLdSswMEpma2tLYytw?=
 =?utf-8?B?d3ZmNU44K0ZzZnVRRlhXZ1ZGUDQ1aDdSNmhZUW5ycGFSRXh1Nk1vZUJ0UnZN?=
 =?utf-8?B?dUUyRTI4eHRvKzljVGtCY0NLSTgwVTFscy8yMFg5Qnc4SnhOT1llTnpVVGtp?=
 =?utf-8?B?NHlwYVBoUTZTTjBiVUdBeE9mWG4wM2Y0VmozUE5BbVdLUVQ5elMzQUFOaXpj?=
 =?utf-8?B?Y04xVDNmK2VpQmxOSGhQSzVYZEhqOHE3cXNLTXVSalFqS1hEaCtvMjZBWXZh?=
 =?utf-8?B?SEpUUk05NVpNVDNzTW9Ld2R5UW9WTmJHb2FvSGQvcVZZbEpkNHZ3NkFKV0Y4?=
 =?utf-8?B?QmcyNVErdXg1RXc4TEsyY0RPUHJScGIzK05pMzJXSGQ4ZUljcDBpQlJ1NDFZ?=
 =?utf-8?B?OWhKTGpKNXQ4K3pUTlowczBITEMxS1pLSTBlaS9wRC9uTGZWV0IwZllBK0h5?=
 =?utf-8?B?STVWVW1nYXA4cCtyVUN3RTJhRjd3Nm9wK0czZWRnWTZWbFYvaTBPWXBMVzNP?=
 =?utf-8?B?S3V6YlVQaWNOYXNLTE9kOVJFQVVzbXc1UUVBRTdXcC9jcVJ2VnY4dGZWQXMz?=
 =?utf-8?B?OC9GT1ZIZkpqUGcxMDhya2dwTXd4MFc1Zit3Y1lwbzM0VVBZMUtWOVIwUVpO?=
 =?utf-8?Q?Ryo50aaiKhc/A2Jtao=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktlNFE0a0xCcDBHTFVQTzNPOG01OVUzaCtFRHcwcC9ieGw2RWt6UmF2TTli?=
 =?utf-8?B?b3hzU25uN2xxaldRZkVuMUt3bUpRYWliWjdjSmJVeHZoMTh6bEt6UEpDY3Zt?=
 =?utf-8?B?VkwwZXFkQktjRDc2OHp3Ullxcm5Sa2xyK3dqblpLTVk5RFhxVm4zc2lCZGxT?=
 =?utf-8?B?QU9aVStrcGE0UW90cHd2VnRKNnhhTW1mRVExYXV4SUZDV21IWFZQQXAxNHYz?=
 =?utf-8?B?ak5TdHJRRjBpejMwQ0syek5lM00raGZJbzdnaVZkZVZreC9OSStrblM4eWI4?=
 =?utf-8?B?aEZTcEJCbCtCNTNjdFg5cTVKZWZzQmoxYVMyWTVnbGI0RWFKajY2SEd1Vnlr?=
 =?utf-8?B?NDNyKyttODM4VXdwNmpSVlVhR1NKdUJBbXhxRVAzamhWaDB3OEQxYXJlWURH?=
 =?utf-8?B?aUIwdVVCRUNOVkRQTnlqRnhTb0tGOENrK2k3RDVhR21Jd0VTbjFlNG9YUjE3?=
 =?utf-8?B?bUtjeENmNjErVE9tQkxTcGZNRDRiZlBzUThXZy9BNngrcVdDanpjbWtyc0Z5?=
 =?utf-8?B?TGhSZWFFQnMwK3lxMHJjaE9wZDlwVTZYZUx2R0Noc0ZoWERSSERpR081eGdI?=
 =?utf-8?B?VXVpZk42aldpbnZibjFzeTRpbVdyZGtSSU9FZjFQdm9XK3Vwd3Fydy8waTFR?=
 =?utf-8?B?aWNCSE1tajNFZVhIcE80VFlEdEdTbEtXOUdPcVBRcTFZL1JUSGsvM0Z2RDlD?=
 =?utf-8?B?NkYzTHJoc3VqTFo3TzRqTjVjdm4xbGhBQ0NpZ2F0QjMvcGxxZUFMUlp6S2hY?=
 =?utf-8?B?ZVhPbG94TStqQ2NKbzNDdit3N3ZMRzUvOXVYbE8yOU1XVzFoOE5MQldIUjJw?=
 =?utf-8?B?aUo3MjNOaEhxSHAzbjcwU3hVWTV0WDNBS2lCUC9ybmt3U1ZORHdHVHE1blcr?=
 =?utf-8?B?YWxkZzc0WUp5RmNMalJVTVh5OWwycjRhZ1F3YlJ5OXVDSFJzTUpVTzcyVlhI?=
 =?utf-8?B?UFJQTkZLaXByNXhSN3dUdkN2M1dhNUJLbFFuUk1tLzBFdDhNZTBjRWNTeGJn?=
 =?utf-8?B?UkF1R3o1OTgrN0g3TlkzOUZBSHRienVoNFVOdXhpYnArdi9LZDIzRllITnhJ?=
 =?utf-8?B?N2JVdERSQ21Pekl5SHZiK0lFNUtZODUvVkRqSFQya3lxRVI1SUlDd2JQRDdQ?=
 =?utf-8?B?MUFQT2I4ODZxa0lPMStRa0JCV0tyUFNJc3NiOCtFUFFpaXQ3UFh5a0k2VlZR?=
 =?utf-8?B?MXpMSU9iQjJET2JFdS9FQ2tOLzhFWTNLeFpkYmVrSG55SDFqY1ZJRnVnUnFl?=
 =?utf-8?B?NnRrcWU2RlJEZkw1d0ErSGtnYUZpQXU0cCtDMVFENW0vWmZIc1VrQ3lzeDhw?=
 =?utf-8?B?bEZDWExFSlQ2aW1JU1F1NEdDU2krQkxES0c4RkRoZG9ad3ZZanowM1FWdDNY?=
 =?utf-8?B?V3g4enQxYlArSm5HWUF5OEtxVE9aaFA2TU9NUmJTbW5MdlJXU1NXdFV3cUgv?=
 =?utf-8?B?SEZwYjkwSFdPQ0ZxL3B3Y2QxNE84VmFzKzgrWkNjNHFxNk1ycVpwSWxBN0R2?=
 =?utf-8?B?eTVXcllrdG1GTDZvSkV1YkhzNUtiSk5QUmdpQUJEYkZsZjhKRWJOViszQnNo?=
 =?utf-8?B?cndmOHhnZnplWHRHb1hRaFZ1SXBzLzRCQzQvQlRialBaMlF1VkZVYnR6VnRo?=
 =?utf-8?B?L3Mrcjh2NjAwVnN3cDUrRFlsMSs1Vk41RGJjVklSc2o2QUtERDF5eTQ5WlA1?=
 =?utf-8?B?UEl1VWpBK1NXZmRzVTNHYi9UaFhuak1JUnIrMkoyK2YyZFU1WVJCaXNLWFlF?=
 =?utf-8?B?RFJwSXF6eWRQem8wRlpPN3BQcEMxVWNWcG1WMGRWOEZpQVVTWHRNOVlsZmcv?=
 =?utf-8?B?RTdpVWFxa0xwaDhNSSt2WVQxZmRUK2FrUXlrUzE5eVAxODhMa014Y25WUjl4?=
 =?utf-8?Q?Uq/S/P0PJvfPW?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e13f992e-b71d-4cbd-6622-08de48566133
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:21:37.0717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7464
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 Dec 2025 09:06:38 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/11/2025 10:56 AM, Jay Chang wrote:
> Align SPEC: Bare mode contexts are not cached, so they require
> direct memory deallocation via g_free instead of hash table cleanup.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>   hw/riscv/riscv-iommu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 79eee2e85e..fca5763858 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1344,7 +1344,16 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
>   
>   static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
>   {
> -    if (ref) {
> +    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
> +
> +    if (!ref) {
> +        return;
> +    }
> +
> +    /* ref is pointing to ctx in Bare mode. Bare mode ctx is not cached */
> +    if (mode == RISCV_IOMMU_DDTP_MODE_BARE) {
> +        g_free(ref);
> +    } else {
>           g_hash_table_unref((GHashTable *)ref);
>       }
>   }


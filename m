Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6592FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsy2-0007qA-0L; Mon, 18 May 2026 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wOsxz-0007pc-8V; Mon, 18 May 2026 04:04:48 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wOsxx-00052l-AE; Mon, 18 May 2026 04:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYrz8Q4PxRU/b8YhoWswwybCFoly4jKaQb2Cmu6GLxQDATs3pwCJiIT2pMNKbzoy4dGu75MYoRfnaOxY7ryGaBSnJhmIxlUnR1QTAh0SfEIb/xvthfducXZ+nnjB5nsHV80pnSL3PBKffO96Ol2e7FSE1sGlnXUlPwq6tnDHpEWI5597dFz/NylpGMv8utPK1SbhsxmJ29sAP7EKAw0FGH//XXVCHGmzEYMrhR97dMky7JGkOnwN5qy+6u0nIGfSyxA6SCg/HWoVpT2JWNlw2p9rF0hd5sJiHVYOI6gcr5sxhhlmofRHFDStu+7N/9AMJQPc0ahS3oUuW/R/iBeIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGnclxtpHkVxBYYdBeR51CJPGuH6eTJ7Uxjw30/BV5o=;
 b=LuBSpiTON+GsZ1zA58eWgffMIjjyI6uJW1ZTDdyZgdjnevl7EWEU4iuthBT4UhkcxMQlyvwy+dly1OnsAVnZSAI81uabuM/Mg1Zv2w2s1xwRn0GV9d/fJJw/BGEqDA7MDsITwxn9elqzBK/OxWcFjk2Tzc/DcB+9fMQtU4RVvYDBBZN4fB1KEwnHEuxFvH8YM5l4DPh+jzxXZXF8QATlrhkfb4faBjiE1PuXNXg/D/smXVNQyrrgnJicTpPK+y18/AvcyDaiKpG56kADgHEEUIRPUiewGhFeLS9AnlYyJUYE7HTR+IWOu0y/mGWjPFLCZoylFFcx7COKDS0KliKp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGnclxtpHkVxBYYdBeR51CJPGuH6eTJ7Uxjw30/BV5o=;
 b=BvrifmwDOqhN/Dz3wuEikNdwoEZAK9+N76C+xLpcBjkL5uFi/v6iwq3prGiT95JAyQ12VC0yodKVkVEna6T7z5ztahfKNNov+YAOoOTzhBqxySvoecCP5CuqBXV0pI1XN0tbkIGAWfoWxvpGtJ7KNNbfRrV5PUtBYY1IGHuAsZYgS7cBDJyJBARXuO9ij43oRzKARDd2VMIiTavK8ZeIqV7p3ATxjcIlC5CNUZHBq/bQLQJ6HlqPnpdzN9tdmcOTs50/z6atKXkE2b2r8cz/ZywtHNFhcnzEY2W2/twz9JrbO1dZuAjMGP8pHsN+U88Js9/IwSvJH+fBCUgpIo973Q==
Received: from TYQPR04MB8919.apcprd04.prod.outlook.com (2603:1096:405:2ff::8)
 by SEYPR04MB8914.apcprd04.prod.outlook.com (2603:1096:101:2d5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:04:38 +0000
Received: from TYQPR04MB8919.apcprd04.prod.outlook.com
 ([fe80::9fd0:3e67:e02d:4a4f]) by TYQPR04MB8919.apcprd04.prod.outlook.com
 ([fe80::9fd0:3e67:e02d:4a4f%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 08:04:38 +0000
Message-ID: <TYQPR04MB8919508A10DEA9A3A3DDBA3FF3032@TYQPR04MB8919.apcprd04.prod.outlook.com>
Date: Mon, 18 May 2026 16:04:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>
References: <20260518070143.8405-1-jay.chang@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260518070143.8405-1-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To TYQPR04MB8919.apcprd04.prod.outlook.com
 (2603:1096:405:2ff::8)
X-Microsoft-Original-Message-ID: <2aac71b4-1da0-4d53-aa67-822d29d0fa55@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYQPR04MB8919:EE_|SEYPR04MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f9e113-4cd6-4cc7-721e-08deb4b41b27
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|45011099003|5072599009|8060799015|23021999003|12121999013|6090799003|15080799012|51005399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0hVV0JRelJsQWhpODhtdENnK0tEdXViTjV3aENpK3UvbTdOdXJHR2tnWmwy?=
 =?utf-8?B?ODJEemFDMUo3MjRBSHJDNE5uRkV5Zi95eGpYKzduL1hybTM5THZBM291ejhS?=
 =?utf-8?B?WlNuOHgwSzk4ZklIZnh5OHNJUTViTHE4NmxXTlh3Z1ByY2puU3RmaTA5UVpl?=
 =?utf-8?B?K21HRE1TMTRpaHVNREFmbFYwdkN2cldrUlhweWNkSURmK0g4Ri90aGM2TnJn?=
 =?utf-8?B?UWlRVlhzYTBENGY2VkN5UkdGa2hPOVF2MXlCcDg1SE1XRmJGZmJEdkxkS1pq?=
 =?utf-8?B?cm9TVi82U29pNTI2RFFhd2crN05LeDNUYjlPRXRKWU85RWxrK05DZ1BBZGcz?=
 =?utf-8?B?Zm5sWDBrWTkrU2M4TEJWOWZpVWY4UnRaRzRKcXB5ZHZmbWREQjNYVnFtMlYv?=
 =?utf-8?B?aG10MmlXK3VQZ3BsSGFxZHhRdmJHVWpENSsxM25McWpzZENraUFpMDNUdmNt?=
 =?utf-8?B?NnVqY0VCM0pPMmtWYm9ZbHVJcGs4ZjRXeG9rS2FGVUZ6alczVEtNYlhWdWx5?=
 =?utf-8?B?Sm13bnEwRXZHdWM3UGxaeVlNMTdsaCtoUEFvM00yU3FWRi9ZVGtKOEpVTmd4?=
 =?utf-8?B?R3phaTNRNXYwNFhzTjQ3dVp6LzR0S3B2ZU5vd2tEVG56U1dJK1phTDVNMEpi?=
 =?utf-8?B?SHZZdCthMmN5WUVGME9ZdHJzZmFtS3V6dFY4aGkyb2gvdCszRzBzdWZrU0Nr?=
 =?utf-8?B?MWlRRmdjRW1GY29ZOTl0eU9UUUVvNW5aRVRMM05PSFF2cmlXOGZka2NZdEU1?=
 =?utf-8?B?NHpKZHFqLzZ4ZjBGUnROZWJ5Y0FnektGbHdoMU8vNEphQWlJTmpBUGRyRkV5?=
 =?utf-8?B?Z1hLbDhVNWtoNU5zYi9EZUF6RnI2U3I1THQwTWl1UU54NGFEOHIzSWhrUHRU?=
 =?utf-8?B?WkpPdmoxcFpmTU1zNldGTXZTM3pjNEFSeFNKR01NMGVWU3IrS0lPTm1KNzg4?=
 =?utf-8?B?VU5GdlllVlcwQmMrNjhidjUrM1BMYjJxM2ZzY0FQMEVZVUZ4ck5xaG92TThI?=
 =?utf-8?B?WjNCenNoZnVCc0pzSk5nN3B5QURCbkhkMjF5TTl5d1ZoUzRsUjlhSFVDeXdi?=
 =?utf-8?B?ZTl2RGZPWWlEZDFSNFNOM2pESUd0Z04xU293L3gvQlBJRDBMT0FhKzgrL25x?=
 =?utf-8?B?Q09DNWp6SStjL011bHN0NFlYMDFBSVFpeHRnWWtzMm5Lc2VJNGNuZ0JJVk1u?=
 =?utf-8?B?WGNLazF6enFOUEJhQXFpSnJiZXVHb2VSRTUvTnJhZTRvRDR5YVRaY2hLQzJK?=
 =?utf-8?B?UGZSZ2E1YTl0eE53a2MxNndwMDJhUVgwSy8rdW9tNk8xeDR5Y3FiT1U4cHF5?=
 =?utf-8?Q?YtUD5DaDj/l93m/OwR4ELab4fhHAGvCqQR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25CTG00N1IyN0tRSnlyNnhNMFhpS2hBMmd6bUw4NnB1ZlAwN3AzbktUdFdz?=
 =?utf-8?B?cUhkRnRxQisvSDRMYWpkZmhnZUpldmZiN1AxQU5nWHRRT1ZRRnZKb3NJZnN0?=
 =?utf-8?B?ZjF0V2o5aklla2ZMa2laMGgxdCtLWVJtUzJGT2NuZ1Rkcjd1bVdjaEZ2cWlk?=
 =?utf-8?B?VXp5cXJENGNVYkVPNXAwUXY3MVgwcVdGeENydGpXaWpEMFlrK0dvVk9UZHho?=
 =?utf-8?B?dFNNTWwrS2RIVGxSRFBBcHNaSjJTb0g3ZlgxMVRoUTNxdlNBVkw1SElJc3RX?=
 =?utf-8?B?NEw4ZXMwNWlCZG9jRkNEUUlsRlpZNnBvQ3h3MEpleVRIK2ZVaE5VQ2UvNldC?=
 =?utf-8?B?ZjhvN3A4MERJRGowM3NQOUdJZWN2U1dQM3o0YUJXUzFxMHhaKzJ3Z0NWc21F?=
 =?utf-8?B?bG5RUFRQN0JSNHJsNGlpWnphaHh0Wmx2NUNQUkZJbDNvWlgzaHgxaVBURFBj?=
 =?utf-8?B?ZndrQUFGWVZFZHhJWjNiTHhWOEZQbVBGYWM5RGx2SFZrWGxyUmtZWURJWEgw?=
 =?utf-8?B?UHloSFExdjl0YXdCU0NkSEcwekhjYUxVNGVheitiR05EZml2c3N3L2lIQU5C?=
 =?utf-8?B?dC9BeVlVMXFIQ2xpRm41R0I2eUdVaTZEL1pJcStZei83RG9wbVN3SjBIdHU3?=
 =?utf-8?B?UzBXNVdUMHRSc1c5cEVPMkorRFJLNG93YUlhclNyWWJucG4zK1hzWmVhY3R6?=
 =?utf-8?B?MnJ6OE9XdGowTkk1ak5Zc2IyZFlkT3htV2tpUnljYStMaVJleWlHVThMVjY2?=
 =?utf-8?B?d2Q0UzdMRVpzUHI4bVNMMUtTZlBCaXZ4NlBEVlRGR2xTYi81aVRsNngyejd1?=
 =?utf-8?B?dFFMSXBrUHdBaHk0VEM3RWxDclRjSVpTQ1lNNGNTUnBvYk5wYitjaEV5RmNz?=
 =?utf-8?B?aHBBNGk1MCt2cXRFa0VFNHV3ajhPZTZJaXZ2K1VnM3NmZ1ZrZXd0RlRIL0hn?=
 =?utf-8?B?WEVvMS95M2Y0cTNxenQwVXd3d3gwWEZaNUxIclJDSzBaR2Mrb29SQ0l5bFhD?=
 =?utf-8?B?RVNxRE5EOEw0SEQ4M0JyUlE0Q0o3aFIrTXVIOXRzNDVaOGxSOWJ4NnFWTG1Q?=
 =?utf-8?B?bmxOQml4RkM4QWJsSjR2OUtNMThCb3FNSGZUVXRWYjhEZlN4OU5tZHM4SzA4?=
 =?utf-8?B?c0Nhc2E3ME9nZ2xhWnRJTHVwOFZFMEtDUFpMWS9EWnkwMGRSZXlvd2wrRllE?=
 =?utf-8?B?eTkxQ2kzK3pobnNsZkUza1BhRkpTM3NXaDI2a1JmWE9xOTgwSjVadWpKcE54?=
 =?utf-8?B?WU1oVDNqQlFLeFhONmtRSWpDeEs2UDVITitudy9xamdFeXhKUnJBb1lYa1ZX?=
 =?utf-8?B?YTJmQ2dQSVBaTVRTcVRaT1dkSEY2U1RLVEVxSW1yck1uYjZCU21FY05nd1E1?=
 =?utf-8?B?N3UwVXROSjhNZ3BRK1BIV0RtbFhLbXVLK2dmaHdhUWlPeFB2aDFON3oyUTRL?=
 =?utf-8?B?MGJPcmdNZmE4Z0dBTDB4L0VHbkZ6MEl6dzR0REc0MGJ6T09UcENkeGxjN3dB?=
 =?utf-8?B?V1JoUEQ5RU8rZ1hzeDM1dDJEa0NVMmxNK0xRQ0x5bkFxaTNqMUNUek9pU0tL?=
 =?utf-8?B?YXhCb2FvTDEzSnliWlF1ZW5Ia0VGR0dJaTJab3l5UXBGRldSakl2Q0Q2Rjg1?=
 =?utf-8?B?Nng1ZnZ1cU5FcG9jcGpHMzRJd2dEaE5Pb1BobzNPZkN6V0dEYm8vVmpBMjhL?=
 =?utf-8?B?WXpWMlBFbGpqNTN6TTRPdnNYWTc0MHRENHdyb2ZXbCtrbkd6R1NHSW1WbnIv?=
 =?utf-8?B?RElzNElUSUtuWjUrSnprUzQ4RTJxOStPQnJoUUNoNVJGWmpRUlp3cmxjcm5x?=
 =?utf-8?B?VVBrei8yQlZMRWU4ZDlJWnpVTkdIWGdiLzBYRnF0TTdBUnFrOTcwNFFHcitM?=
 =?utf-8?Q?6n+lgmzuR7bbr?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f9e113-4cd6-4cc7-721e-08deb4b41b27
X-MS-Exchange-CrossTenant-AuthSource: TYQPR04MB8919.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:04:38.1228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB8914
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


On 5/18/2026 3:01 PM, Jay Chang wrote:
> When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
> the IOMMU should re-check the command queue and continue processing
> pending commands if head != tail.
>
> Per RISC-V IOMMU specification :
> If command-queue access leads to a memory fault then the
> command-queue-memory-fault bit is set to 1 and the commandqueue
> stalls until this bit is cleared. To re-enable command
> processing, software should clear this bit by writing 1.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 5bc2472a83..1b8a8e9ef2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2034,6 +2034,16 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
>       }
>   
>       riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
> +
> +    /*
> +     * After clearing error bits (CMD_ILL, CQMF), if queue is still active,
> +     * re-process pending command.
> +     */
> +    ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
> +        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF))) {
> +        riscv_iommu_process_cq_tail(s);
> +    }
>   }
>   
>   static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)


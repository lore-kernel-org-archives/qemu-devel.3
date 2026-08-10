Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE620C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYDT-000564-TI; Mon, 10 Aug 2026 18:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtYDS-00055w-Bv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:11:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtYDQ-00047V-Hr
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:11:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXCOs2883139
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pIBW9DqQ4AbzHGokUlAbRrpbTnXwQq6O7wKUjUPK1iI=; b=JOUMZRI2SwAGZnSW
 B6Ciqa0nTJSJGKdgn3+fLa4erZhaRv0yDy1edc4lTjiPDnwSnYVaF8VMbBT6+JTW
 oF2sNLir+9Nx4DsSZZ/ahm/ejUnxhPHY3SKe5M9UXsBHYWepNwHGd7rZjFY6UJoi
 ZbkmlCDoE7G7LC8jnFn0sxPEkwuLPAvP21TBn8DJrcuNNMGezympTfcB7WFZVPpd
 JJKsCm8fZGGCeN7lZwSQuNzaolWnMKd6aOnrubbOBHQqXVcYiSMXDpY/DCsWKgvE
 jU/RK9fyh4J7GQtFyBMLIijBm95MBLVzNvEjTU9F4rQ1MEsPvH0Fu7BXI4LOT6Pq
 VsVcRQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk21ae2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:11:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0199faafso28735201cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786399886; x=1787004686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pIBW9DqQ4AbzHGokUlAbRrpbTnXwQq6O7wKUjUPK1iI=;
 b=K1JBoYDGMNMpagAuxKZGDBKuumbPAE1KYvNG2WyTyWHVAkw5rrfGqh5aVXqjZ6MeLh
 RNGwRrPbrO7TJ9ZEIcSGUSh2XLuk5DgRpAq6dWMWaMxXWOAAqqQAaezPEFSKBUcy9R2o
 nfN0zVDycWdFb4PUpEeYnfY9j3JVPz1UlCVxH6/O37+emY/5j/cUUSxgSSgMx0zF/9DI
 2UmBkstr0wmpxdEXA0iBQy2eS5xOVPb8ConTOIxmfd3pcZ1rRrfmiIg+pB2H1J3Fn56D
 DOZZUtuBulb+9inJL306EfuIx0WEld2MlgYLf3RlI7J9KKReZgLn+4sl+4PMeYZ0zHmU
 Q4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399886; x=1787004686;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIBW9DqQ4AbzHGokUlAbRrpbTnXwQq6O7wKUjUPK1iI=;
 b=Z74dn2xoEkM78R4gO6j0qgosZ8i3Y1XT8C/GVW2zQ2QlDxrJevO6p+ecI2ZH3OodB4
 vCyK6qfs0UF4guqbWB+bb8SGJg9H30T8vYS9019EZZJ4ZwZrBBNcRiuiLkbrKns52an+
 64s25qTFJbHm0QxTHykiXpl/DE2B8XmANZ5mzOSZTlmrm2KX9c0LNUDkbz9lWEqo8nTW
 kGVoEcEgr/+u58WDvoeDhpNBMH3TcOp3pRk/zhW+3sR+5GFk99RiJwIeWEJZhcUP4ERM
 ltBeKOCg/GAn+KO5vU7MXA51gPzDs/aRun0zQRhR1GZR0Zy9c8Zcqymwi7z2fWDhX6fu
 +tDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVZN5ZilgrJOoh8iszqAkiXuIJOAGTl6tCZ9yqDFFsP/nKnAovdxCxJ8FIxxbSEGPYs+gLmcVG45jx@nongnu.org
X-Gm-Message-State: AOJu0YzmUqDQ3p5H7n/Beii+pjrYt/uiy6FlZG/rx+HsWJzpPNznng8S
 UGstrW4VcKOLwfpW4rQEKcoEW3M7fP+302Cfz6eKn01R5a+Tpxp9JFdDZscfSEyHX9UDVa2jkgA
 x9TJe9TTygYbokhe9zfknmD023lX1NIbtD1XmaSD/N2bPeTv7AOP7QgtNXg==
X-Gm-Gg: AR+sD11Rybh+t1sq0NL83vQWd37LSMoAA75mbcHHJGHy+SuCjrF66dyBu5ZGMkAVX+c
 mv5QUMoA+jE4us0qaq/Z0LzHMZsBc1BET5JVmH5QY5eVd8Eh+wtT94MU82+UvP89VmIGEr72Ld2
 p4s4MR/n8BLaexzyt+lBPIYcphPJ5F65f3vLpeo+iYLPZLfZNc/LXweI93HFA49DDLP8iLvBRxc
 pBq/22c3t+p+R/A0p7t25hrSbd6uKjyB4QtPfttHbKdFE8AiP/XuuHmxxXoZjU5s1AONbTHewDo
 zE32Ee1gNOwGDezb4PudTqHQ6RMWUQX3Lqgt8nWp1Xs6ILTyfXUhy4ZZgWY1o6b9TNhItz/Wnur
 9ifSXKDMPz4+7FEj5LD8l4qTCXQ7bTdI5JjAr3mpv
X-Received: by 2002:a05:622a:1805:b0:528:3882:3869 with SMTP id
 d75a77b69052e-52ce5fb99cemr477823381cf.13.1786399885640; 
 Mon, 10 Aug 2026 15:11:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1805:b0:528:3882:3869 with SMTP id
 d75a77b69052e-52ce5fb99cemr477822861cf.13.1786399885246; 
 Mon, 10 Aug 2026 15:11:25 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506desm36248582f8f.10.2026.08.10.15.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:11:24 -0700 (PDT)
Message-ID: <61c41ecb-7a81-4420-ac04-624d283060cd@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 00:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/tricore: add System Control Unit (SCU) device
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com, David Brenken <david.brenken@efs-auto.de>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-7-1c39053e5e95@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-7-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4OCBTYWx0ZWRfX3zVx2hMeqibM
 4MfDOG3+ygcWlUUVVR1T1INWNjCI51/a3VE0YTfvTLWZm3f7EY+zdZMNaWjRlpByqf+iqj9eU8c
 09DJhpvagw/ysXPWt0/yTDtNrZEJeqE=
X-Proofpoint-GUID: _LiWW2-_A2Gaa1sY3gMBYxVU8Uv-oovm
X-Proofpoint-ORIG-GUID: _LiWW2-_A2Gaa1sY3gMBYxVU8Uv-oovm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4OCBTYWx0ZWRfX087e3YfwHo8K
 sLrScNxtDGfMaXScJkhXnhCedAm6Mo/du++RXNEt27RunaBFfhQlnktouY7+7DTk1dyPE2yNC8I
 5hRz51gW+Ag3pgBADi+LwrIYSmEMTgoGTJ5sQN19R90H9Rhl5GKg1TuLN1RYzr59MpkWOyJwkm1
 eu645K+d6NE1aJenoLAess9ZUD/UCfj8xuSi/EluRX75uqaAVJNgHIW3PBhlrpoMWeyqDV08Dzn
 ZNcWBhRHuAOwkXWwKymz5L2PGeUbvD0clwCqFxOK90ENaot/egU2wr7IZpcZC1/6Qc8vzbZAZKA
 LKha1P9h9uA5wNLPQAFUFr4ppr/XBMbnG09++NcXn8s/IzAliHuyS0KfGyukawtUlygMX76z87U
 fe2vZAz3MphTBgLu6YyYfp9teM4rYVAu9So5wNnZY4xSNEJllVA1y0ZOHzm/7QF4jK+CTFifcOf
 9V1fdJ8KgEq238g6DqA==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7a4c8e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bUQKSiCPAAAA:8 a=vU9dKmh3AAAA:8 a=EUspDBNiAAAA:8 a=vgAr5bqUwA5qrKrOYT4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=-fHZXUhsFbuwFN3fwQAr:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 31/5/26 11:30, Parthiban Nallathambi wrote:
> Stub the PLL, oscillator and clock control registers that
> firmware reads during boot.  PLL always reports locked so
> startup code does not time out.
> 
> Originally-by: David Brenken <david.brenken@efs-auto.de>
> Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   hw/tricore/meson.build           |   2 +
>   hw/tricore/tricore_scu.c         | 240 +++++++++++++++++++++++++++++++++++++++
>   include/hw/tricore/tricore_scu.h | 103 +++++++++++++++++
>   3 files changed, 345 insertions(+)


> diff --git a/hw/tricore/tricore_scu.c b/hw/tricore/tricore_scu.c
> new file mode 100644
> index 0000000000..4baabc7d82
> --- /dev/null
> +++ b/hw/tricore/tricore_scu.c


> +static const MemoryRegionOps tricore_scu_ops = {
> +    .read = tricore_scu_read,
> +    .write = tricore_scu_write,

Better be explicit:

       .impl = {
           .min_access_size = 4,
           .max_access_size = 4,
       },

> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};


> diff --git a/include/hw/tricore/tricore_scu.h b/include/hw/tricore/tricore_scu.h
> new file mode 100644
> index 0000000000..9cb7c916d0
> --- /dev/null
> +++ b/include/hw/tricore/tricore_scu.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU TriCore System Control Unit (SCU)
> + *
> + * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
> + * Copyright (c) 2024 Infineon Technologies AG
> + */
> +
> +#ifndef HW_TRICORE_SCU_H
> +#define HW_TRICORE_SCU_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_TRICORE_SCU "tricore_scu"
> +OBJECT_DECLARE_SIMPLE_TYPE(TriCoreSCUState, TRICORE_SCU)
> +
> +/* OSCCON bit positions (iLLD IfxScu_bf.h) */
> +#define MASK_OSCCON_PLLLV               0x00000002  /* bit 1 */
> +#define MASK_OSCCON_PLLHV               0x00000100  /* bit 8 */
> +
> +/* PLLCON0 fields */
> +#define MASK_PLLCON0_VCOBYP             0x00000001
> +#define MASK_PLLCON0_SETFINDIS          0x00000010
> +#define MASK_PLLCON0_CLRFINDIS          0x00000020
> +#define MASK_PLLCON0_NDIV               0x0000FE00
> +#define MASK_PLLCON0_PDIV               0x0F000000
> +
> +/* PLLCON1 fields */
> +#define MASK_PLLCON1_K1DIV              0x007F0000
> +#define MASK_PLLCON1_K2DIV              0x0000003F
> +
> +/* PLLSTAT fields */
> +#define MASK_PLLSTAT_VCOBYST            0x00000001
> +#define MASK_PLLSTAT_VCOLOCK            0x00000004
> +#define MASK_PLLSTAT_FINDIS             0x00000008
> +
> +/* CCUCON fields */
> +#define MASK_CCUCON0_SRIDIV             0x00000F00
> +#define MASK_CCUCON0_SPBDIV             0x000F0000
> +#define MASK_CCUCON0_UP                 0x40000000
> +#define MASK_CCUCON1_STMDIV             0x00000F00
> +#define MASK_CCUCON1_INSEL              0x30000000
> +#define MASK_CCUCON1_INSEL_BACKUP       0x00000000
> +#define MASK_CCUCON1_INSEL_OSC0         0x10000000
> +#define MASK_CCUCON1_UP                 0x40000000
> +#define MASK_CCUCON5_UP                 0x40000000
> +
> +/* Reset values */
> +#define RESET_TRICORE_OSCCON            0x00000112
> +#define RESET_TRICORE_PLLSTAT           0x00000038
> +#define RESET_TRICORE_PLLCON0           0x0001C600
> +#define RESET_TRICORE_PLLCON1           0x0002020F
> +#define RESET_TRICORE_PLLCON2           0x00000000
> +#define RESET_TRICORE_PLLERAYSTAT       0x00000038
> +#define RESET_TRICORE_PLLERAYCON0       0x00012E00
> +#define RESET_TRICORE_PLLERAYCON1       0x000F020F
> +#define RESET_TRICORE_CCUCON0           0x01120148
> +#define RESET_TRICORE_CCUCON1           0x00002211
> +#define RESET_TRICORE_CCUCON2           0x00000002
> +#define RESET_TRICORE_CCUCON3           0x00000000
> +#define RESET_TRICORE_CCUCON4           0x00000000
> +#define RESET_TRICORE_CCUCON5           0x00000041
> +#define RESET_TRICORE_FDR               0x00000000
> +#define RESET_TRICORE_EXTCON            0x00000000
> +#define RESET_TRICORE_WDTSCON0          0xFFFC000E
> +#define RESET_TRICORE_WDTSCON1          0x00000000
> +#define RESET_TRICORE_WDTCPU0CON0      0xFFFC000E
> +
> +/* Clock frequencies */
> +#define SCU_FBACKUP                     100000000
> +#define SCU_XTAL1                       20000000

Please keep masks / reset values / freq in source file.

> +
> +#define SCU_REG_SIZE                    0x1000
> +#define SCU_NUM_REGS                    (SCU_REG_SIZE / 4)
> +
> +struct TriCoreSCUState {
> +    /* private */
> +    SysBusDevice parent_obj;
> +
> +    /* public */
> +    MemoryRegion iomem;

Drop private/public.

> +
> +    /* CCU registers */
> +    uint32_t osccon;
> +    uint32_t pllstat;
> +    uint32_t pllcon[3];
> +    uint32_t plleraystat;
> +    uint32_t plleraycon[2];
> +    uint32_t ccucon[6];
> +    uint32_t fdr;
> +    uint32_t extcon;
> +
> +    /* Watchdog stub registers */
> +    uint32_t wdtscon0;
> +    uint32_t wdtscon1;
> +    uint32_t wdtcpu0con0;
> +
> +    /* Backing store for remaining offsets */
> +    uint32_t regs[SCU_NUM_REGS];
> +};
> +
> +#endif

QDev modelling:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>



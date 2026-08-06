Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4553C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrwaV-00073B-2Q; Thu, 06 Aug 2026 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwaT-00072m-Hz
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:48:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwaR-0007bP-RJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:48:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6769nkRS865666
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 11:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JFepXyNTr9YGzCIWdOTUK8chG8iP69v5+6Ox8XREm6g=; b=Vikd1oFz/btht0NK
 0BWj2nPXpVmx2uwcyWIJGtCc69PWKLCCoKRl/ZYOoZ938OnkTAZSOW9f1jBMX0pI
 iwXUaHlkKleB2sgk0EICQ2OFoy3PyBUNmya1Bvung/J65mY8kWOqmrnCdpdclwK+
 TY4ilVQ2QypLac7gFVandJTOtpCd1RjBdpK7epXER8kxiErLBExY7U3ZzW/DtnlM
 sEwH5+xVF/5YYB5bJAvf5yEbCYlFlkrx78A1OYs6ZHRCK+KejSeZBJOT0V+UP5hE
 o//cQk9AI9oz0IAdeWDJXQDytjz8XD/E+b3oPre/0ShWK8JbRg78DCEjTLndNwif
 Aw43wA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5c25g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 11:48:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so20405161cf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786016913; x=1786621713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFepXyNTr9YGzCIWdOTUK8chG8iP69v5+6Ox8XREm6g=;
 b=eUkSi4Y7HS52WdZHisT0cPUghXyjPpf8pH+N1dd07tWtg9yxHz/TDrfiwHy0Rhddss
 9TdkNd0TS80mrsoZfRfExrk2PJT050v4/LW9wUL80XCLS/iNlEd6cFekT0tPPKNv6tLj
 uJN3aSFbGnGDwBARDgba40NPUEpnLn8Q8laBCFbQPV7nYlq4LkeE5jsVUbiLdU8RXYU9
 bwaVekrmnmwAGmKZcqJjTWgw+6z4HzVwiFDgMgOI7rc07uXWXdM1i/IpmNmFuXBblrX3
 IB+ZweWi1Gt7KLtv7SEfskZGhIKrELRu2qEmeXDJlbnYghakjutIyCbkvqEQungNuLiZ
 2e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016913; x=1786621713;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFepXyNTr9YGzCIWdOTUK8chG8iP69v5+6Ox8XREm6g=;
 b=OIttcWILurqfB0RljbkP8M29sIuPnVp25t6XzJ7AQqGhzAcy9r1mjeavfIHI5bDXYv
 ci5Srlg0fpXP8KktuNJ1PWrvPrRh/aYSWSrZ6TZ8sFCtp1338sqfJvzdogs9EBwTzSIo
 a4caUScEIDwUjBlECyd/wKJiyMkkkERLVA2Ndfrun+TKwfc3+Njd+lEycAOSyyurfJs6
 H78b1AMyhthKJcTKDLezfGPtHsxfuRaKKP3abzoO0nVEYr3msnwfw5pvUIR4dCpEWX5d
 uSQX2GoDItohAMAttnjhm108gcb2yBxCISMzqrN9ndOCs5mWhv/0j6bpOD/pDwvPPTQj
 9oCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSSjjcJP4AT0c7fhorflUDvW2uBi+H+02Zg1e69xw5gD/1pexrueHzoJJ+jXzH9lRy7nWwTvzI/6dB@nongnu.org
X-Gm-Message-State: AOJu0Ywv0XziWblndqNeYo25ueTZdR8sKNpY+SyD1LF1fMTxQTyX2cGq
 JqNH2mwd4So+FPmAPa+PQnhODRk8SuIkZj2mc+lmapa3C39fwTrZpCrWidmwxkSs4zR6ihWIRTD
 mCCbpriDQdASX9xV0EdWzWQtrQokHNPNgxJ1ntB8gC0NZu6xQppb7Bt14DQ==
X-Gm-Gg: AR+sD13TlBNQH7ydHXbHd3ExmVvognSW1zkQ8uVeVF0Lpf4lgzhcUekt3xynxfV1ME3
 Cefk3EVnLGUF/mCl5WIyZY4hA3+d/10gTPbxnI1yJgD/BGnazETzXJ4QkQ85jwDFBHIE/yDHogl
 /xG/T4IFmn8kynM5finIrueenIL7K8GQQuKIzfcSc+UlW1JlQvQYk/fhJOHWcWqvb/nfofpNqTI
 FsoaHhO6h6I462bWHhEV2n74gGc5d+aQBTx5nxUsroSX/Uzm55v/nmR9k7imuPAR4Gm8lbDsZeV
 KxR3bsLB4aesQKV8JDPXBlqE+yn3lKx4TpRYEERQ/5Wlep+1sSdB9K88Q0L74cu07X7WZioO76r
 EAaboQM8ELyun1WYjbykqkeziTEOsCf6VCt55
X-Received: by 2002:a05:622a:428c:b0:51f:636c:8eae with SMTP id
 d75a77b69052e-52ce5ff21c5mr151631661cf.14.1786016912896; 
 Thu, 06 Aug 2026 04:48:32 -0700 (PDT)
X-Received: by 2002:a05:622a:428c:b0:51f:636c:8eae with SMTP id
 d75a77b69052e-52ce5ff21c5mr151631051cf.14.1786016912420; 
 Thu, 06 Aug 2026 04:48:32 -0700 (PDT)
Received: from [192.168.15.12] ([177.196.135.131])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce87d09casm36378041cf.8.2026.08.06.04.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:48:31 -0700 (PDT)
Message-ID: <92b88bd5-c220-40b2-b366-d34a6616c416@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 08:48:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/riscv: k230: add decomp gzip in K230 board
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260727155702.36484-1-dingtao0430@163.com>
 <20260727155702.36484-6-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727155702.36484-6-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HrtTe7smTfgfm2FlaIi17UPArvZA3opF
X-Proofpoint-ORIG-GUID: HrtTe7smTfgfm2FlaIi17UPArvZA3opF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MyBTYWx0ZWRfX1hN2gC0lm95Z
 ePbTQyzdPs7gV/hf7WcSAzYTgbSbzXintc8//e0wPI/CxZa6c7VVJeuXqZ+HNw0C3mnfl1iHQy2
 aaKYELuaD0QKt8Bk+xQnuNOcDsTwGyw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MyBTYWx0ZWRfX1DhoyDRa3C5O
 PiVTtXfXPiah/Ikoz52WIGrNrg7gLJ+bhiA+YkYSSjBePrJDjjIq1xy6bEgKIoZcEQ99LEVHKnH
 Wci/GUfVvvYIU7SLQple63P16NAjCg6ZaJ/ezUcCFOeUZk1N2HKTPWotoOX0+ml7yFJOddxrjLY
 PyLqfbFkLwd5uyMzxEZrEORuqkEh6ksV1U/hMgLs2Mdw2z8OXBcN+0K1b6DiD8gAYhVk257qURk
 N/+EN4qQQ6QM0RDsazjjD1+uw0B48i3NN28PBFH09Dcea7Ehr5W5gtYhdJIrBf0kfxaNX2UESm1
 wTWia+XpqLGz5AlCa80JwTqLDHQrGdEggpOY+MkN0QBIPoSfGtQ22IBCCo58QnvvG4dMoK5stD+
 D5UQw3zFy+/q7x3OJ2nZIw47nmfI0RaHQdLybAX7RwWdGnawVqWpS+NmQzIvzzNiFSpYVjiHreo
 oarg3xmj8yZsccPvouQ==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a747491 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=TqADvzrrTdHTq19dv/zLaQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=x2GlTaQBcllRsYBM52sA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 7/27/2026 12:57 PM, Tao Ding wrote:
> This commit replaces the unimplemented part of Decomp_gzip in K230.
> Connect to the handshake interface of GSDMA.
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> Reviewed-by: Junze Cao <caojunze424@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/Kconfig        |  1 +
>   hw/riscv/k230.c         | 23 +++++++++++++++++++----
>   include/hw/riscv/k230.h |  2 ++
>   3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d28ac06043..d06ac26648 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -163,3 +163,4 @@ config K230
>       select UNIMP
>       select K230_WDT
>       select K230_GSDMA
> +    select K230_DECOMP_GZIP
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index c80bd65694..7fd1ec4c25 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -111,6 +111,8 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
> +    object_initialize_child(obj, "k230-decomp-gzip", &s->decomp_gzip,
> +                            TYPE_K230_DECOMP_GZIP);
>   
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -215,6 +217,23 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
>                          qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
>   
> +    /* Decomp gzip */
> +    qdev_prop_set_uint64(DEVICE(&s->decomp_gzip), "sram-base",
> +                         memmap[K230_DEV_SRAM].base);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->decomp_gzip), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->decomp_gzip), 0,
> +                    memmap[K230_DEV_DECOMP_GZIP].base);
> +    for (int i = 0; i < K230_DECOMP_GZIP_NUM_GPIOS_OUT; i++) {
> +        qdev_connect_gpio_out(DEVICE(&s->decomp_gzip), i,
> +                              qdev_get_gpio_in(DEVICE(&s->gsdma), i));
> +    }
> +    for (int i = 0; i < K230_DECOMP_GZIP_NUM_GPIOS_IN; i++) {
> +        qdev_connect_gpio_out(DEVICE(&s->gsdma), i,
> +                              qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
> +    }
> +
>       /* unimplemented devices */
>       create_unimplemented_device("kpu.l2-cache",
>                                   memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -233,10 +252,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
>                                   memmap[K230_DEV_DMA].size);
>   
> -    create_unimplemented_device("decomp-gzip",
> -                                memmap[K230_DEV_DECOMP_GZIP].base,
> -                                memmap[K230_DEV_DECOMP_GZIP].size);
> -
>       create_unimplemented_device("2d-engine.non-ai",
>                                   memmap[K230_DEV_NON_AI_2D].base,
>                                   memmap[K230_DEV_NON_AI_2D].size);
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 156a386edc..a12d36965a 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -19,6 +19,7 @@
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
>   #include "hw/dma/k230_gsdma.h"
> +#include "hw/misc/k230_decomp_gzip.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> @@ -35,6 +36,7 @@ typedef struct K230SoCState {
>   
>       K230WdtState wdt[2];
>       K230GSDMAState gsdma;
> +    K230DecompGzipState decomp_gzip;
>       MemoryRegion sram;
>       MemoryRegion bootrom;
>   



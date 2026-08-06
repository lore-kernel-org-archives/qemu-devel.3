Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4120C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrwNK-0003Nc-Gi; Thu, 06 Aug 2026 07:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwNE-0003Md-IW
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:34:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwNC-0005mR-Id
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:34:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6769o1DO2105641
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 11:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bc9SAqb86Ob7BUq9ZJNQMRp45giNLFQ44njRcImFGg4=; b=jLIo6eEkaifnZLZg
 wiB2X6OT/e4hTREQUaQdTNzp9uYZOUZdYWTX42inu1fKSJ8uHMHN/LjAVKzhX0iB
 pPPNj1/wojHEZIsHmSR1s35/p9dYAqIch6Riex9076g4twPrNxy7dQZRznnD8XAq
 Z3rNwFiynfTvc3/XvAUJ7RemG/3wv7gPc58tCxP2Ft9obxXN5c6sVT5JfDHbMlSK
 m2nFXWrNG41NJCws+IQPiWHuZCM+XOGacyvfMU3LX7aoufVasDaUxfoSYbQS3/+b
 sUgQIo60JKGSfDXX9I/3pMgJ/eJ571OqMkaIQgdJ6aOTJlSdXKzfA/f82OK84hyU
 HbZ8ug==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq730rf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 11:34:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so16259111cf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786016092; x=1786620892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bc9SAqb86Ob7BUq9ZJNQMRp45giNLFQ44njRcImFGg4=;
 b=KEBIMSyIHkT8ozXRndX/PaAmO6uZT801YpJbqKh32xgC1IPpzeUSXiBLGfa0okwcqt
 92s75MhIX1Qv78Nbk4GJuzB9kRI4RGjcIa1308SVnzjbU6qkZ8JxXsTBghL8aAGu95uV
 +opvajmpHBZuNWj4YgVZpPhN/yuFA7vVfH5JMHKkdJYmrzc/zFWMGsGvmTDvtFut9RzN
 ThGXen9hx1Gwt+SN7ajtY+9cMCLk02IqzZVbTtxrRxS3wRhSm1lgcHrQ8Y4Esjd6AiQ7
 bFnikUYlFl5Cinm3xoIQ2LQQqe/6OgLso8QUxGUy/IepCr3ilGopwFVVIIZrZ/T6VqiV
 iBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016092; x=1786620892;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bc9SAqb86Ob7BUq9ZJNQMRp45giNLFQ44njRcImFGg4=;
 b=JvcWYK1CH7NnW4yfArsvkNWe2V59e6QR0X1ktIzjWcSsIct/e3NTDNWs6aT0JoHOXi
 ak4BGU1ro0aRehgGE+NNhxpsCUKwmJvd1pgOU4HIco1POUON9enUNf1qjDqCgmSVzBxx
 JNHrqIf1dACC7Sr1thqTFkVygtRkZhtf5LNIt9vbTLE/g3Oct0JQkUxhMzaj4hT+iHaH
 vWBr8hXwz6E6vk3ZCMml7O7UA/aa9W6BdFJKJloGOlePOTasYNzO2HkVFwQMzxA/PAig
 yel1HAvDX7AwviBE5nqtbvqIIMqhLwjFpGJ3l8fRAc6FlvFTNhPmmIbWtOFmiHiB8chR
 ZKng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqdscluvgplv7nhk0dKCm7BXhUUbMckZtYy4qiUV6iFq0QxEcbCSeuc9yKZiFA3c/XqsEhYGo44/ruf@nongnu.org
X-Gm-Message-State: AOJu0YxvXfnZo6nkXvTvHA87o06G9QoPQPMNZAL92O5mcyh0DXYX+USf
 SQL6iSjJ4EPYvCL8Hp6Rzlwq7mzgfL/yPSw/b3xG0i1EslKnpEbRBLoYv6KNWFX82dbHHgPlrqy
 fBAPEwolun8bjYYEbBrb9/T0CdLrJVLMGh/3wAcQHDT9acTjs+AntA5X4gw==
X-Gm-Gg: AR+sD11DOCjTq1zISNIAGhFnK739bBxilvuBtiF0tZw0lLE0ZufdPekgmRYEq5r5s45
 9quOvXF6HWunO1UkAGJc0ZH+NqqKEigg1NH855aLZNIK1bjS+k9x8FwKze2KOVrQktTDymLLAPu
 VYS2cv2pXDstXwdl7XB3dR+liB7Hxi4cAAFibHnBJfChLDxiHA2gbF2rwybtUn4sctwM9HOpyCT
 yUpBReJNzZNM587KLNhHPRM7jDGRVl6+JQf7XfL6lgcWTrqCZCKygDu4P9kUixyyg9ajWT3xZKy
 2FCVeBXTtPShH2A5GNDnCt+exIbvFkunwto8rBhMxL7lAZpRdVgyIW7+RfSIs043PRvS39yd/y4
 HQEVf9MQrB9Sx3gQi7aRAtmBRIfjiq8Cq/S6l
X-Received: by 2002:a05:622a:509:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52ce602ce1fmr137060791cf.16.1786016092146; 
 Thu, 06 Aug 2026 04:34:52 -0700 (PDT)
X-Received: by 2002:a05:622a:509:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52ce602ce1fmr137060211cf.16.1786016091681; 
 Thu, 06 Aug 2026 04:34:51 -0700 (PDT)
Received: from [192.168.15.12] ([177.196.135.131])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce87a9c3fsm36895181cf.5.2026.08.06.04.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:34:51 -0700 (PDT)
Message-ID: <9d592f16-8cf3-4e0c-a238-d745d5139691@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 08:34:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] hw/riscv: k230: add gsdma in K230 board
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260727155702.36484-1-dingtao0430@163.com>
 <20260727155702.36484-3-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727155702.36484-3-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX08JbiW8ylzRj
 Wo0+5QwxYTxg59SsDDCPrpYhURtgkcnSM2lAogKadLq/Ru4k0hGrGKQuZ1jEpC0qt8EE+c3gZyi
 401W88OBOi9P9DjBvmK5ZdQn5zyW6MhNs/2WPXf1888xLpgDgHPT8HTk3q5qgl/k2unEfM62Hx0
 jhFI5SfoXDRmMDBoRkovUCETsBtLlETTs3KpTCPDWew6YvvO/PNGggrhStzxj7t2qd5zzqmqh0a
 30udnHDCB6vKnck2WKLO2l7k+i1JhGeaJSaNeovCIIsSauEo6s0xVl7eRIFiJoHaiUAWx6kjCDD
 j6/uOc6q7yN9dqMdCk7o5KUNObjPLw3YGfVyfub8ap9+SYv4eRh1/9wn5B54AoqCoe7ScNNWvNH
 y7jvpHLq0sR6Jd96LmnzrcFQi3AqsPacLW3JEGIBaTBTJBen5EGxMnMc9KyHuawpQwqsJelURlA
 aZn2Dk9fmY784dK1VhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX1kOYnJ5pmX3i
 kNQn9mjnQfUH6maAjOFEv27YpD0VGAXSrsVimoWdBTuz9e1syIy+iQHgyAslItJ0RVGX/YrMW7X
 zJAL07dyfrLyWY+JlYYSKTE2qFm0W3U=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a74715d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=TqADvzrrTdHTq19dv/zLaQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fSw-O1yPuj2pjOr4s8MA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: KER3Ha7hObdpC0zgid-dFCY13LSjQOkp
X-Proofpoint-GUID: KER3Ha7hObdpC0zgid-dFCY13LSjQOkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/27/2026 12:56 PM, Tao Ding wrote:
> This commit replaces the unimplemented part of GSDMA in K230. And connect the interrupt to plic.
> 
> Update K230.rst.
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> Reviewed-by: Junze Cao <caojunze424@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   docs/system/riscv/k230.rst |  1 +
>   hw/riscv/Kconfig           |  1 +
>   hw/riscv/k230.c            | 12 +++++++++---
>   include/hw/riscv/k230.h    |  3 +++
>   4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..a426a1d776 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
>   * Platform-Level Interrupt Controller (PLIC)
>   * 2 K230 Watchdog Timer
>   * 5 UART
> +* System Direct Memory Access (SDMA)
>   
>   Boot options
>   ------------
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..d28ac06043 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>       select SERIAL_MM
>       select UNIMP
>       select K230_WDT
> +    select K230_GSDMA
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..c80bd65694 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
>   
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -206,6 +207,14 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                          qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>   
> +    /* Gsdma */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gsdma), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gsdma), 0, memmap[K230_DEV_GSDMA].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
> +                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
> +
>       /* unimplemented devices */
>       create_unimplemented_device("kpu.l2-cache",
>                                   memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -221,9 +230,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>                                   memmap[K230_DEV_AI_2D_ENGINE].base,
>                                   memmap[K230_DEV_AI_2D_ENGINE].size);
>   
> -    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
> -                                memmap[K230_DEV_GSDMA].size);
> -
>       create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
>                                   memmap[K230_DEV_DMA].size);
>   
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..156a386edc 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
> +#include "hw/dma/k230_gsdma.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>       RISCVHartArrayState c908_cpu; /* Small core */
>   
>       K230WdtState wdt[2];
> +    K230GSDMAState gsdma;
>       MemoryRegion sram;
>       MemoryRegion bootrom;
>   
> @@ -129,6 +131,7 @@ enum {
>       K230_UART4_IRQ  = 20,
>       K230_WDT0_IRQ   = 107,
>       K230_WDT1_IRQ   = 108,
> +    K230_GSDMA_IRQ  = 140,
>   };
>   
>   #define K230_UART_COUNT 5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C49C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQKE-0007qH-C9; Thu, 16 Jul 2026 13:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQKD-0007pt-7j
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:56:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQKB-0007OY-6I
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:56:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGT2lu3302305
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uth6HxSHLVTBtnzhYD3gU2jGBzxiUdED6sir8hW69DM=; b=fyae1m1VE/bu15nt
 QuOCCGyWZs4j9UvJfbkqIf8mi1THWF+NFsyuQOyZbD0pyMrvSMHN5Mj3A21MdUtB
 k3Az0SQlg7kZkq7Wc/pl1x6WBOQyhE+KRpRz6DnCEyqwgePYop6Gcxd46tPf/QeP
 Fz5aNjM3h8cuaYWWtVDtdOpxCpw2fqGuWmbx+jvUPI0QZc08ZeqdmAkBl0b/UwQU
 uhC5a87WlED07k4LAC4qPngjEbvzLDdjrDycz0elTfyKZUa0AU9ejI9Uyw/k1lJ/
 +v8++8VO5cu/Y8N52uYrTcUVlGPNd6JFynbQrLcfNAYSJYUohG3GbJ9FgHWLFbSM
 icz2TQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex2m2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:56:39 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-667d0d587e0so371534d50.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784224596; x=1784829396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uth6HxSHLVTBtnzhYD3gU2jGBzxiUdED6sir8hW69DM=;
 b=GFdjEe3NFbxI1QvHhxBtH2+sh/DLLXeH7TqOf+X4mnHAuV6hcD5ju9Zm++6vQ51vjl
 c/XbEhTIz0SBQRzH3xQiQqnGPjOJWE5Hrla+eEuQy9o4D+85BU+NrHGxu9L1dsSnak1A
 gFXolh9hyyCKSWZt7t99oXBVlnusRi/kP7UXbDMi1TuHvhGk0IzieIq4WDq1FqABk2fO
 YFmDscuFnNWzBtBr+ayqUkO+8AvbDUNBdoxTZrPqVQ+j1ILg+WKWEVACypFKPlwD6X9d
 oK1BENLe+uyj7dDU2SkF0vnEmAIcjuqygPnaXceiGnm+2CmRoak1VBTpn7wqIK8ka4Os
 7xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784224596; x=1784829396;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uth6HxSHLVTBtnzhYD3gU2jGBzxiUdED6sir8hW69DM=;
 b=G17QHlRmcZEZSRAvtYVLrldGgZiGpGxRkBpYsvP/9grJPkGWML048TsxVu3KUjaoAm
 0mDgJ7SONh4bMioUS2uDCVG6TQmjhLSyZcAgBPerlvXDjs9QEQCsZLa+epkjP8TL9csn
 6LF92WUQUTTrLezCeQUEcGGbTBZwsslYFhBAoBfNIcvNRDd6ags0tmgZeIdqyFpnDScb
 rTcQeVa//DDICOUwyc9adN5x5B26F0VFBGkgWzOrd8qVt9cX3DgJotbIF4C4lLjWy2DL
 erudW4PiOmRIsxWc/JtIFqMNh4YKwkhI3Gm5me8gS+vkIOkboV03ExaK6pSB9KH0yYgB
 iLyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3iPJngPouecdvS2Fu26rWDGvfO/m88jdtCbMcbmaPcz0rPpAjeG3gfl/X4mNmuKofQIo0EeOPlSOK@nongnu.org
X-Gm-Message-State: AOJu0YxEa8Yn4n/bzxdDiGuYuEq3EQ3SwwZSogDjM3fo0svfBxIpeK4K
 DP+JCEkdrJdbzbEOD/dlCaKjgRhcd+nkfH/vE1usaphMnTEWphqTeBEgte6AuBirgSaaNpsR2D3
 +5kBX+F2OXcEXFiBwmQ64zfZq/Ly6ctEcHbVtouz92VTl+6BpGNrhnn5zpw==
X-Gm-Gg: AfdE7cl7mE38XJEUL/7gXtYdH+vDS69Kt2ONurwrkB5aZTOwlh9mHOvo230CXKie7kp
 cjyPh0UcGfHmX31JMSKCpB4hPwSicRgC8urjngvmIGfWntFvyor0Cikb37XSc7e3LzE1MPn49NV
 f3dyIJoXVAI604FOz9t9h0LVCntL8SfXuXPYMEqU9ODPGSzB7XiZI3r3bPx82fqrvZihjkGqYMA
 YOa/MlT2PvgKRz6bOb8WuQLVzKex1zoPqF/BTbjJUOv4a0WX/ue16prwKBOddvSnoOS/x6Ex2Ml
 afsw6s4pU4F1gHIiUKMSMTjA44ZTM6WTa5XhYzh9EZg7K9tE8m0O9uTAHAptCYi3ugIYbkoyoq+
 /G64RQLE2jzJKrep5Csg3GV84MS7b++/UkaXzOA==
X-Received: by 2002:a53:ad89:0:b0:667:b91e:cdd6 with SMTP id
 956f58d0204a3-668133c6f08mr4578046d50.64.1784224596343; 
 Thu, 16 Jul 2026 10:56:36 -0700 (PDT)
X-Received: by 2002:a53:ad89:0:b0:667:b91e:cdd6 with SMTP id
 956f58d0204a3-668133c6f08mr4578018d50.64.1784224595769; 
 Thu, 16 Jul 2026 10:56:35 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.123.183])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6681fbd8c5esm4064458d50.3.2026.07.16.10.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 10:56:35 -0700 (PDT)
Message-ID: <9e600f36-96ac-4eb9-a901-47d4ea6cc748@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:56:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] hw/riscv/k230: wire up the RMU device
To: jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:K230 Machines" <qemu-riscv@nongnu.org>
References: <20260709031237.21284-1-163wangjack@gmail.com>
 <20260709031237.21284-3-163wangjack@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709031237.21284-3-163wangjack@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a591b57 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=szoPuAicwqWYzOEwwuIrwA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=zbSpUncYuYwdhI30rcEA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-ORIG-GUID: N8Se9s842V80vva_4lS0VpTISdTZBkQW
X-Proofpoint-GUID: N8Se9s842V80vva_4lS0VpTISdTZBkQW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MyBTYWx0ZWRfX9iKlB0L0nny7
 qbOO39QclXdxsWWjP8E5HaKK/LGQCxIdfSgdEg2STEERimXRdOU8bON2L15Gk+x6UHsPjf7IyTu
 Qh/lHjepVWsQ0wbrfp75/n3Y+yyTJ/0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MyBTYWx0ZWRfXz3ERrD5VnQXt
 YFki0jBWU+d4FqaYB6ZqZXpHu4ntUlSksx2eHL4mpdtkgd04y+sB4G675XUy7q7g0TcvKKio4AI
 NpvqaHC4Bubf8a3M7/punXKr50st2SsyNO2J4laVl9dG7Q7jqNx2bR67Nl+cGn9w1bPyAxZ9BGi
 /MCvhILyNRf7gG3w+ae2YFQnZwcR132ds1ktTAhEA+0IlVYre4egCZeZ7UI9fG8NNUzaLm6RH1b
 NGZbKNO+9wnggf/nbDekFvctshQ9T5ThOBC0cH4ucQddGZLeX8D7ku1j1xGcL9hLKWMsaVcrW8x
 rLocK5IJHQzNfqxdsh8g47/ed+sFqQK2iKzT0a0rPHNPJ+GTr7Gkn75VPPD0OnoQEeGrNJrbTNp
 Err6F5GafPKmeUe5OJ2vFEtm0v7mFaoMXEQt3/QzN0YaKlp6VRyo6uU2svjWxaMuHiHJEo08k4S
 TNbK+ONcDSkt6po2/WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On 7/9/2026 12:12 AM, jack wang wrote:
> From: Jack Wang <163wangjack@gmail.com>
> 
> Replace the "rmu" create_unimplemented_device() stub with a real
> K230RmuState instance mapped at the K230_DEV_RMU memmap entry, select
> K230_RMU from the K230 Kconfig, and document the device.

So, as I said in patch 1, applying this patch will fix the qtest that you
introduced there.  I believe we want to either squash this patch in patch
1 or move the qtest creation to this patch.  Both are fine to me.

> 
> Closes: gevico/qemu-camp-2026-k230#11

Not sure what gevico is (seems like a bootcamp, according to Google at least)  but
the "Closes" tag usually contains a gitlab bug or any other link that is publicly
available.  It's better to remove it.


Thanks,
Daniel


> Signed-off-by: Jack Wang <163wangjack@gmail.com>
> ---
>   docs/system/riscv/k230.rst |  1 +
>   hw/riscv/Kconfig           |  1 +
>   hw/riscv/k230.c            | 10 +++++++---
>   include/hw/riscv/k230.h    |  2 ++
>   4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..3f2313a127 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -19,6 +19,7 @@ The ``k230`` machine supports the following devices:
>   * Core Local Interruptor (CLINT)
>   * Platform-Level Interrupt Controller (PLIC)
>   * 2 K230 Watchdog Timer
> +* K230 Reset Management Unit (RMU)
>   * 5 UART
>   
>   Boot options
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 54e41a6afc..bffa4e69c8 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -149,3 +149,4 @@ config K230
>       select SERIAL_MM
>       select UNIMP
>       select K230_WDT
> +    select K230_RMU
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 502281c52c..b55e90c0d2 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-rmu",  &s->rmu,    TYPE_K230_RMU);
>   
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -206,6 +207,12 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                          qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>   
> +    /* RMU (reset management unit) */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rmu), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rmu), 0, memmap[K230_DEV_RMU].base);
> +
>       /* unimplemented devices */
>       create_unimplemented_device("kpu.l2-cache",
>                                   memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -268,9 +275,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
>                                   memmap[K230_DEV_CMU].size);
>   
> -    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
> -                                memmap[K230_DEV_RMU].size);
> -
>       create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
>                                   memmap[K230_DEV_BOOT].size);
>   
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..13f2a1ab0b 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
> +#include "hw/misc/k230_rmu.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>       RISCVHartArrayState c908_cpu; /* Small core */
>   
>       K230WdtState wdt[2];
> +    K230RmuState rmu;
>       MemoryRegion sram;
>       MemoryRegion bootrom;
>   



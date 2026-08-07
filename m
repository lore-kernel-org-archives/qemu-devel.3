Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1A5C5AC9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNbK-00008o-21; Fri, 07 Aug 2026 12:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNbI-00005m-ER
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:39:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsNbG-0003Ql-QA
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:39:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GOGfA769888
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 16:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zfbbJ9R83COrdPTxLGowC8v4XsbBmjNId46+n6rpieo=; b=dZpdYfdYtfMwVGfS
 BWapaFVlahSSUnnOsDhQ8t2XJsOp78v8o2I/KUSbZduX3rlG3570dz7l6ycti38v
 0W8t/AMcmsJ5DnKp5MTCp5e+8nz/gvHdZEnQuxXiU2PCe6pVctVqvZ910UWSwAIN
 ruYRofP8OwrHRt+IQ0AAlGmGvywAVVQqUsXlkTdtQTiXThSlPaGQMWl2LfDoi3Kc
 vYYFJwUB9p8WMde0Xa8HB0dDl1uU6I8HumoCWwwq1ECSTqMX9pmuviOPn3zXNDLT
 1PyQyOWcrRq0pIWaXKnavvH1IzhEBF6e4XsdTXAp6itEQjZ+ol/5Jrpw1n8EsY7M
 POA/iw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu2dec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 16:39:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a236220so33429211cf.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786120752; x=1786725552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zfbbJ9R83COrdPTxLGowC8v4XsbBmjNId46+n6rpieo=;
 b=MpFBYoGVi2LpDx0wXSnkc+Qnwqea+yaswgCyNuGYda/Qd3A+7BQ6Tf7Ea8maWv2nMV
 P/nd1apIeUNArHg0ds17kNU2LW0PUNs/6Rj8bZjLD66yOyAq+l1ZQZVBe+2290qZw4/S
 nBEYBAGlNz5tSQ7ZlHW2xZnqVHlidHqIpSieF4Yh85mT1xeQbRZ1Fbk6C/+od6BQ8tLb
 nEVl9UQjfznSSYSxVn9C4/ngzOWBsmhKPDk1u0BM8/NcebkcV4xgOQTZzivFcF4feG9M
 wwzOmUMonHeLr2Q7PB+dIu4Gu5klFuFd1aq2ZXbjlKrlFBvqnE8qRbQQ8KSEUHeLcHRD
 ihjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786120752; x=1786725552;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zfbbJ9R83COrdPTxLGowC8v4XsbBmjNId46+n6rpieo=;
 b=WlsJnHrl0kkIL8p1sXJ9P9huXkdNbSkvYvUh7Pv5bntfqC5vh0D1AB5PGJOELQKYLa
 5AfqFv6TJMv8Gh9KJXXTwweHjh6ykyLL/IicyAKFhGK4jajq1md6lblFGwI5vUvLNiu8
 OXXyy+p6QzaGyKgpd+Ra6XFpxAqpPjucOSltn4dQSgUVKfwpTpjjlIR57Zz+5nC+hVts
 H4d1NadUwwDHxTPKskQvQiq2MDca32rk9gqP2yVYw/oZW9j9vJbWv+pNmV8x3z45jKXQ
 LvaFr+FqsbWTgJuiNdmvZZ0V+iNAyhK7p7JtHtuZYcgHOkL4ebH23wi1rn4OsXLSSsHw
 /6wA==
X-Gm-Message-State: AOJu0Ywmkainookf1AYdPE02z+G0FHzjO9EvJmiNW+8fCtlxlrQjoY3B
 1OwXN0/T1V5+RUnADX42XpHo96wd3RM8EBKEZUE0vBiajdAG9KE+OTsIgkgdiaFsDCMmDPoTRSG
 Fqxix4T8UgBBulqodMqirW4hH8aJXb3xExudsIYUHpaXwvWgDcqyKiODnRA==
X-Gm-Gg: AR+sD11KKANb3Jptjv9Zm3ewET2LWrdGXItx2CyEKsb2dE8DMer0pN+yvHK0B8uEqCY
 oST+DKY1WHdHt+cj3ZziF1QQ7REcBrX3IIa7xKfGZQEEpjPi0R4nlvxODBXLzLD0QjZVSYx2Onw
 aqH8r9dB/mcO2H179EQukdpfsFUQUaLa4JhOEElXh+cckPhxl9oEpAnFKIlc3AuCj60n+Z5Vipz
 rOLdnai18AwXkEHcOTVEvADhuXuR/uGWhjg8oXXrjzAEl7Ld67EnnKDqdWmV+FNvqynd65aQPG3
 W8S7ildt2pKcA3sX1VJy3dlDPi4nBTNzNNVuI+p3YCwMS8tnj3f4XkEOZa442ow0QHMU7FAvTGC
 j5sNsUBDoXuDmumTWBTn1ssIJ2VYxUKzN4FAs
X-Received: by 2002:a05:622a:1484:b0:519:e020:6087 with SMTP id
 d75a77b69052e-52ce5fb8b85mr250345181cf.11.1786120752324; 
 Fri, 07 Aug 2026 09:39:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1484:b0:519:e020:6087 with SMTP id
 d75a77b69052e-52ce5fb8b85mr250344641cf.11.1786120751863; 
 Fri, 07 Aug 2026 09:39:11 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a918eb4asm13057396d6.7.2026.08.07.09.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 09:39:11 -0700 (PDT)
Message-ID: <bb8cf7a9-f761-48e7-bc4c-d10b82076616@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 13:39:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv: instantiate K230 I2C controllers
To: Wang Zhongyu <wzy15515798875@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260807152830.6833-1-wzy15515798875@gmail.com>
 <20260807152830.6833-3-wzy15515798875@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260807152830.6833-3-wzy15515798875@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gXRGnhucL50Z4Z0GtX6lMUnb-iB716Nf
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a760a31 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=D47K7NXmnVvAYYZL0Z0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMCBTYWx0ZWRfX3Bc8YlXlnAui
 PtInXduKTTR0j1LQxDz7UfLZ8uVA5e7n3nz8EQApdnlICMQMxRnIyklvBSvJAx7G5rGwZOeIbs3
 m+74hR8kxpexFnrngR/03cxHo4/Lz8w=
X-Proofpoint-GUID: gXRGnhucL50Z4Z0GtX6lMUnb-iB716Nf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMCBTYWx0ZWRfX5C8wysM9xBOk
 i9vz0MgX4kHZN66Acpis0hERuZNB38725mcQ4rftpPbjMXy7ZDjoDrZZwrgpEqcvcYz0ntCf0la
 XhICWyBSylL5lRQR9leXm4EihreVuoAIbzXMcj6PrWWYCSqPkBNJVlnLprqsJNgS71YWUfpG9wq
 N7A9u81lrT98yqiToJtR1kfDPwTslYBC+f5oWIGodQz0RpVDxKSmd0wuPhd/j1CKSTd1qba2eGV
 6ZpyNLwckGN7IikrZOWSq7CQUWHb49iLaC66cMHrss6Fdi3ADEpX9BBISuN5B1NdHKrNbGSu7bX
 SDhLJXQ6kYoS8nV34+cznMDjnpifXb9GFnoM1S1F+25X28HPxofVZUC902mv9bHOLvspS7BlZEF
 gHUcQTqLtu6ZUQhlQc+OGsSKhkCexwbGzcf68W2t5h4ckLXxooiLoB9ADk2BOiGwqiIlB1eH0jX
 JS7wfCEIHiZhVedWLmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070130
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



On 8/7/2026 12:28 PM, Wang Zhongyu wrote:
> Instantiate the five K230 I2C controllers, map their MMIO regions,
> and connect IRQs 21 through 25 to the PLIC.
> 
> Select the K230 I2C model in the machine configuration and update
> the K230 machine documentation.
> 
> Signed-off-by: Wang Zhongyu <wzy15515798875@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   docs/system/riscv/k230.rst |  1 +
>   hw/riscv/Kconfig           |  1 +
>   hw/riscv/k230.c            | 36 +++++++++++++++++++++---------------
>   include/hw/riscv/k230.h    |  8 ++++++++
>   4 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..7a011903ab 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -19,6 +19,7 @@ The ``k230`` machine supports the following devices:
>   * Core Local Interruptor (CLINT)
>   * Platform-Level Interrupt Controller (PLIC)
>   * 2 K230 Watchdog Timer
> +* 5 K230 I2C controllers
>   * 5 UART
>   
>   Boot options
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..d2bd41173d 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>       select SERIAL_MM
>       select UNIMP
>       select K230_WDT
> +    select K230_I2C
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..a42f896c0a 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,11 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-i2c0", &s->i2c[0], TYPE_K230_I2C);
> +    object_initialize_child(obj, "k230-i2c1", &s->i2c[1], TYPE_K230_I2C);
> +    object_initialize_child(obj, "k230-i2c2", &s->i2c[2], TYPE_K230_I2C);
> +    object_initialize_child(obj, "k230-i2c3", &s->i2c[3], TYPE_K230_I2C);
> +    object_initialize_child(obj, "k230-i2c4", &s->i2c[4], TYPE_K230_I2C);
>   
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -191,6 +196,22 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>           k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
>       }
>   
> +    /* I2C */
> +    for (int i = 0; i < K230_I2C_COUNT; i++) {
> +        int i2c_dev = K230_DEV_I2C0 + i;
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0,
> +                        memmap[i2c_dev].base);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
> +                        qdev_get_gpio_in(DEVICE(s->c908_plic),
> +                                            K230_I2C0_IRQ + i));
> +    }
> +
>       /* Watchdog */
>       for (int i = 0; i < 2; i++) {
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
> @@ -304,21 +325,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("security", memmap[K230_DEV_SECURITY].base,
>                                   memmap[K230_DEV_SECURITY].size);
>   
> -    create_unimplemented_device("i2c0", memmap[K230_DEV_I2C0].base,
> -                                memmap[K230_DEV_I2C0].size);
> -
> -    create_unimplemented_device("i2c1", memmap[K230_DEV_I2C1].base,
> -                                memmap[K230_DEV_I2C1].size);
> -
> -    create_unimplemented_device("i2c2", memmap[K230_DEV_I2C2].base,
> -                                memmap[K230_DEV_I2C2].size);
> -
> -    create_unimplemented_device("i2c3", memmap[K230_DEV_I2C3].base,
> -                                memmap[K230_DEV_I2C3].size);
> -
> -    create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
> -                                memmap[K230_DEV_I2C4].size);
> -
>       create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
>                                   memmap[K230_DEV_PWM].size);
>   
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..4ea927a63b 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,8 +18,10 @@
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
> +#include "hw/i2c/k230_i2c.h"
>   
>   #define C908_CPU_HARTID   (0)
> +#define K230_I2C_COUNT    5
>   
>   #define TYPE_RISCV_K230_SOC "riscv.k230.soc"
>   #define RISCV_K230_SOC(obj) \
> @@ -33,6 +35,7 @@ typedef struct K230SoCState {
>       RISCVHartArrayState c908_cpu; /* Small core */
>   
>       K230WdtState wdt[2];
> +    K230I2CState i2c[K230_I2C_COUNT];
>       MemoryRegion sram;
>       MemoryRegion bootrom;
>   
> @@ -127,6 +130,11 @@ enum {
>       K230_UART2_IRQ  = 18,
>       K230_UART3_IRQ  = 19,
>       K230_UART4_IRQ  = 20,
> +    K230_I2C0_IRQ   = 21,
> +    K230_I2C1_IRQ   = 22,
> +    K230_I2C2_IRQ   = 23,
> +    K230_I2C3_IRQ   = 24,
> +    K230_I2C4_IRQ   = 25,
>       K230_WDT0_IRQ   = 107,
>       K230_WDT1_IRQ   = 108,
>   };



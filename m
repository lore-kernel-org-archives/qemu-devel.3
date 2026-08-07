Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A82C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJ0I-0000RV-8d; Fri, 07 Aug 2026 07:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsJ0G-0000RC-FH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:44:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsJ0D-0004if-01
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:44:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6777hleb3533965
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 11:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7BJlS16x5+i1zGlwTbpz658TRHx5Fe9UoAcRBShlFGM=; b=g4L8uqypPtKlEnIy
 JUP376XIEPYSsrKPhrqDHVQ01XaJRegCg46JLoN3vU6rhegdMdb/tlVtknRgwAEo
 aqe/atANDOHauXH94r/BItn/VupDvLhRRvIl7nHTP/+iCLdSTjnY9DmaODnlKUG8
 mMXDNsYCoTn4J9WnPJZxvqtRbtsRK0KYTuecOpT6nOhZW0W4vc+k1F/Ly93fzQkg
 HnOoyw4asd4b+5q7om95wrvq/3RYqpCMekuwLhPLmZCgvZmSq3zdbD9DGuEFgaM2
 0iMVyTSkfAkPPY8T3Oj1dDBqziJ9+5AZvPzQ4EFU+WMmK40rNKY1bhlhqQ/96m0u
 2yNkwQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6futjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 11:44:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9349c5af52bso577581285a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786103078; x=1786707878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BJlS16x5+i1zGlwTbpz658TRHx5Fe9UoAcRBShlFGM=;
 b=F4iPCZuPNQIQJNmLx99am2wEqvQQsK2aGeusw82x3gq0eormItUavb4IU2zwRSP+z5
 +ZRq25VNYqn/2WmOOc8406JE8FTDcZ8mHshPnP6RzDPIZDWxBymGNXGRzgMU94igCndg
 0Y8UoLTcwctMab09onlIUXrLqtIjZlh0ZQqhWRBqSjrxVoUeHbjWAzGOOoTIKkMx0aVa
 st5+iuKVOBLQs+ACNYyqjROzhldzJG61IQ6FJUxY1u1PKXpwymKRBqKKGMNPZoWtbtjq
 6O5HhAmkQIQq3mPAQSQh2rvEYGlGUsio5BzV4hKt8kM4Xnaamb3ifZcqIlWCnaMKF5or
 IHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786103078; x=1786707878;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7BJlS16x5+i1zGlwTbpz658TRHx5Fe9UoAcRBShlFGM=;
 b=ltwu7XQHooAW6iI862vwyUkAky2cj7H2kogUsfSAr4uOyegilGQ15HgVZ/fdEKZALn
 4EBOukWurLDxUxAeAtCYgFCg62ofyr6PoShrmRafyJ4jcf842D+5C0O1YBKoRUuX20Bp
 ooKicZC/mdgmSzX17uQKDqY0uLIOgmOLGLJ0VDvVIA4IlPZYR0vsNHlXRlfcpxXSED9v
 qJQ31GrnhrrmtcLJTs6KXNjSe5nQUAY0O4Y5cy7AtsUXN1rvFk0QbbwkatC6cmucCuQT
 02CMqARL+5gZHGU9WXC4Birbg0iM7d916bMBO3ViFH5omk4b+52OiZ0Tq6u7Asy3o5v0
 eyLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpojTtMmey893x7z6ytSU0Sc/Q/0J36LRyXRxeBSS3XQBAeQ2CxZ5HMt2Ns/pY6rlaQICIJ/v2jPsRe@nongnu.org
X-Gm-Message-State: AOJu0YxkUnG0y66evwbDGcaWxxFrsfQsk41E0T4kLQGyZQfqnEF3pWha
 BmhJ1022Pi7xkBLtvxNlrqQOtyu1ZUllEQ0uwR+7RtbjaNM/T91yKEZ6dHAIuZIgYpahQeXdEE3
 +fsr6Co3XsbdvIczpbPy3hIkVDEoq6VQEQ5m2i6V0AUGZSegKWvINqDmS3g==
X-Gm-Gg: AR+sD13Q/GDBOwd3+6ZzRXt2dy840aLI2t7zOp/MZoLbq7eDhn4WR7hORxVaGq0OCJx
 ozyCXiF/ZXbY5KPNYYA5Dt1myT0aW9RC5Jw/1gPmTPb7nGWuFMk6vwtQIPpEWKdJ82hoBhsalDY
 lit7ZPd0OCBUc7KkWcIiFSN9r+/OixDX791B7DIr9cBG1InbHiiaR2NVd+d7B4oCclS1UZD0u6L
 vMj1M7ciwSjc+McCfTWcD/CeKAw+kC/u+UYL2xKDceA+Y09oPy5f6IMbyh0JOLsHvoBbgWfKBTe
 sBHiDAbDmx9POjXu1o53fd6UGTFe63ygoV74CiI2Pv0s6syQv8EyUzl5L7QORdhbyCvtR2iGFLu
 ncAoJnOhP6xRSOd+Csn2Wo6Q85jZs3ukvdAzy
X-Received: by 2002:a05:620a:a494:b0:930:f735:1377 with SMTP id
 af79cd13be357-93649097cf0mr2112542685a.19.1786103078095; 
 Fri, 07 Aug 2026 04:44:38 -0700 (PDT)
X-Received: by 2002:a05:620a:a494:b0:930:f735:1377 with SMTP id
 af79cd13be357-93649097cf0mr2112534585a.19.1786103077484; 
 Fri, 07 Aug 2026 04:44:37 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e2c211csm128588685a.47.2026.08.07.04.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 04:44:36 -0700 (PDT)
Message-ID: <8217d3c4-cd7a-41ea-a244-44ef0f459ba8@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 08:44:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/gpio: add K230 GPIO controller model
To: guochun.wang@foxmail.com, qemu-devel@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, qemu-riscv@nongnu.org
References: <20260805151455.99076-1-guochun.wang@foxmail.com>
 <tencent_7080159426F5C824AE07916CF4FF9944EB08@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_7080159426F5C824AE07916CF4FF9944EB08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MCBTYWx0ZWRfX0m0uOK9EtIXL
 Pe5YPMnelEMply4EeHCVue5EdcxeRDfMCiIBQBZtMuDxg09N7njwEfbVFDhukLkMHPoLqc1thUo
 AsiSxS3Sa+j2OrYrmCHocihKwfBTegTWl5NV9YquxRXTZDeFzSI5R1S5geos/OMPObcxkfRXEI3
 YiE3EHvUzPGu/w7xCeWtMvoOS7ofkkp3d1MrsCTVVuh9m1EWNLSPk9vPF+gwWwT3vccFNdR6tJb
 yF8MBzRowE0ee8jeEPgKScO5QN4Pa5qbTWan4+5okmUJwYDidpu7aF2GFcRu8CkcWgXe9K6+ELg
 sF9nYVjqrTifmqUGd7BYwgnMVykGMmEslJMsW0eh0SK8t7t8L9UDTFawKz6jwZlU5BzWA9/chkq
 kf2TC7TdIx7ooNrvDcP3zze//tNYx87DxiEDnz+7KZkogLzLOzPpCMbEHPd80OS5gZlw2o7aEF9
 PL4h+Zohu2ULmVFxoIQ==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a75c527 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e57ZSKXAAAAA:20 a=bDN84i_9AAAA:8 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8
 a=pGLkceISAAAA:8 a=-lSXbi9S4Krr9TSAB1gA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=J2PsDwZO0S0EpbpLmD-j:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: yH4lzbe2ByT_wHEb-6DWBnGV4DvqFvv0
X-Proofpoint-GUID: yH4lzbe2ByT_wHEb-6DWBnGV4DvqFvv0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MCBTYWx0ZWRfX0t0FkpGlzY10
 flsgHtIMBkda7z4Jm4F/amJnFV5BHtDdcoOPFObZTvCNJ5QrUGCTDjBMlwGmyHaf/q5nWB8YayM
 IZly+QFX6vL+R5K4puW6mViJyLeve4k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hello,

On 8/5/2026 12:14 PM, guochun.wang@foxmail.com wrote:
> From: guochun wang <guochun.wang@foxmail.com>
> 
> Implement a K230 SoC APB GPIO controller model for QEMU, derived from
> the Synopsys DesignWare APB GPIO (the Linux gpio-k230 driver is based
> on gpio-dwapb.c and shares the same register layout), with a
> Canaan-specific compatible ("canaan,k230-apb-gpio") and hardlock
> integration. The model is capable of running the Linux gpio-k230 driver
> and driving external input/output lines. Behaviour follows the K230
> Technical Reference Manual v0.3.1.
> 
> Implemented:
>    - Port A registers: SWPORTA_DR/DDR/CTL, EXT_PORTA, INTEN, INTMASK,
>      INTTYPE_LEVEL, INT_POLARITY, INTSTATUS, RAW_INTSTATUS, DEBOUNCE,
>      LS_SYNC, INT_BOTHEDGE, PORTA_EOI, ID_CODE, VER_ID_CODE,
>      CONFIG_REG1/2
>    - Software control mode: DR drives output pad, DDR selects direction,
>      EXT_PORTA multiplexes external input vs. DR by DDR
>    - Per-pin IRQ output lines (single interrupt scheme), 32 per group
>    - Edge detection: rising / falling / both-edge via INT_BOTHEDGE
>    - Level-sensitive interrupts: active-high / active-low
>    - PORTA_EOI clears edge interrupts only; level interrupts cleared by
>      source removal or INTMASK
>    - INTMASK masking and INTEN gating
>    - DDR/CTL mode switching: no new interrupts while output/hardware mode,
>      pending interrupts preserved; on switch back to input/software mode,
>      level interrupts re-evaluated against current ext level, edge left
>      untouched, per TRM v0.3.1
>    - Three-phase Resettable API (enter/hold); VMState migration
> 
> Not implemented (no observable effect under QEMU):
>    - Hardware control mode (aux_porta_out/en/in signals, single-ctl params)
>    - Debounce logic (dbclk, glitch filtering, both-edge debounce timing)
>    - Combined interrupt output (gpio_intr_flag OR of all lines)
>    - Clock-domain synchronization (pclk_intr, ls_sync metastability
>      registers, gpio_intrclk_en output)
>    - Config-time parameters GPIO_PA_SYNC_EXT_DATA / GPIO_PA_SYNC_INTERRUPTS
>      / GPIO_INT_BOTH_EDGE / GPIO_PORTX_SINGLE_CTL
> 
> Two controllers are instantiated in the K230 SoC (gpio0 at 0x9140B000,
> gpio1 at 0x9140C000), replacing the previous unimplemented-device
> placeholders. Each controller exposes 32 per-pin IRQ lines connected
> to the PLIC:
>    - GPIO0: PLIC sources 32..63
>    - GPIO1: PLIC sources 64..95
> 
> Signed-off-by: guochun wang <guochun.wang@foxmail.com>
> ---

LGTM.  Some comments below:

>   MAINTAINERS                 |   2 +
>   hw/gpio/Kconfig             |   3 +
>   hw/gpio/k230_gpio.c         | 362 ++++++++++++++++++++++++++++++++++++
>   hw/gpio/meson.build         |   1 +
>   hw/riscv/Kconfig            |   1 +
>   hw/riscv/k230.c             |  27 ++-
>   include/hw/gpio/k230_gpio.h |  73 ++++++++
>   include/hw/riscv/k230.h     |   5 +
>   8 files changed, 468 insertions(+), 6 deletions(-)
>   create mode 100644 hw/gpio/k230_gpio.c
>   create mode 100644 include/hw/gpio/k230_gpio.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218..4301d29f7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1827,8 +1827,10 @@ M: Chao Liu <chao.liu@processmission.com>
>   L: qemu-riscv@nongnu.org
>   S: Maintained
>   F: docs/system/riscv/k230.rst
> +F: hw/gpio/k230_gpio.c
>   F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
> +F: include/hw/gpio/k230_gpio.h
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
>   F: tests/functional/riscv64/test_k230.py
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index a209294c20..2d37a8bb6f 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -16,6 +16,9 @@ config SIFIVE_GPIO
>   config STM32L4X5_GPIO
>       bool
>   
> +config K230_GPIO
> +    bool
> +
>   config PCA9552
>       bool
>       depends on I2C
> diff --git a/hw/gpio/k230_gpio.c b/hw/gpio/k230_gpio.c
> new file mode 100644
> index 0000000000..a589d94712
> --- /dev/null
> +++ b/hw/gpio/k230_gpio.c
> @@ -0,0 +1,362 @@
> +/*
> + * QEMU K230 GPIO Controller
> + *
> + * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18), section 12.5 GPIO
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + */
> +
> +#include "hw/gpio/k230_gpio.h"
> +#include "hw/core/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +static void k230_gpio_update_int(K230GPIOState *s)
> +{
> +    uint32_t masked_status = s->raw_intstatus & ~s->intmask & s->inten;
> +    for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        if (s->irq[i]) {
> +            qemu_set_irq(s->irq[i], extract32(masked_status, i, 1));
> +        }
> +    }
> +}
> +
> +static void k230_gpio_set_int_line(K230GPIOState *s, int line, int level)
> +{
> +    if (line >= K230_GPIO_PINS_PER_GROUP) {
> +        return;
> +    }
> +
> +    uint32_t prev_level = extract32(s->ext_porta, line, 1);
> +    uint32_t curr_level = level;
> +
> +    s->ext_porta = deposit32(s->ext_porta, line, 1, curr_level);
> +
> +    if (extract32(s->swporta_ddr, line, 1)) {
> +        return;
> +    }
> +
> +    if (extract32(s->swporta_ctl, line, 1)) {
> +        return;
> +    }
> +
> +    uint32_t pol = extract32(s->int_polarity, line, 1);
> +    uint32_t both = extract32(s->int_bothedge, line, 1);
> +    uint32_t is_level = !extract32(s->inttype_level, line, 1);
> +
> +    if (both) {
> +        if (prev_level != curr_level) {
> +            s->raw_intstatus |= (1U << line);
> +        }
> +    } else if (is_level) {
> +        if (curr_level == pol) {
> +            s->raw_intstatus |= (1U << line);
> +        } else {
> +            s->raw_intstatus &= ~(1U << line);
> +        }
> +    } else {
> +        if (prev_level != curr_level && curr_level == pol) {
> +            s->raw_intstatus |= (1U << line);
> +        }
> +    }
> +}
> +
> +static void k230_gpio_set(void *opaque, int line, int level)
> +{
> +    K230GPIOState *s = K230_GPIO(opaque);
> +
> +    k230_gpio_set_int_line(s, line, level);
> +    k230_gpio_update_int(s);
> +}
> +
> +static void k230_gpio_set_all_output_lines(K230GPIOState *s)
> +{
> +    int i;
> +
> +    for (i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        if (extract32(s->swporta_ddr, i, 1) && s->output[i]) {
> +            qemu_set_irq(s->output[i], extract32(s->swporta_dr, i, 1));
> +        }
> +    }
> +}
> +
> +static uint64_t k230_gpio_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    K230GPIOState *s = K230_GPIO(opaque);
> +
> +    switch (offset) {
> +    case K230_GPIO_SWPORTA_DR:
> +        return s->swporta_dr;
> +    case K230_GPIO_SWPORTA_DDR:
> +        return s->swporta_ddr;
> +    case K230_GPIO_SWPORTA_CTL:
> +        return s->swporta_ctl;
> +    case K230_GPIO_INTEN:
> +        return s->inten;
> +    case K230_GPIO_INTMASK:
> +        return s->intmask;
> +    case K230_GPIO_INTTYPE_LEVEL:
> +        return s->inttype_level;
> +    case K230_GPIO_INT_POLARITY:
> +        return s->int_polarity;
> +    case K230_GPIO_INTSTATUS:
> +        return s->raw_intstatus & ~s->intmask;
> +    case K230_GPIO_RAW_INTSTATUS:
> +        return s->raw_intstatus;
> +    case K230_GPIO_DEBOUNCE:
> +        return s->debounce;
> +    case K230_GPIO_EXT_PORTA:
> +        return (s->ext_porta & ~s->swporta_ddr) |
> +               (s->swporta_dr & s->swporta_ddr);
> +    case K230_GPIO_LS_SYNC:
> +        return s->ls_sync;
> +    case K230_GPIO_ID_CODE:
> +        return s->id_code;
> +    case K230_GPIO_INT_BOTHEDGE:
> +        return s->int_bothedge;
> +    case K230_GPIO_VER_ID_CODE:
> +        return s->ver_id_code;
> +    case K230_GPIO_CONFIG_REG2:
> +        return s->config_reg2;
> +    case K230_GPIO_CONFIG_REG1:
> +        return s->config_reg1;
> +    case K230_GPIO_PORTA_EOI:
> +        return 0;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
> +                      HWADDR_PRIx "\n", TYPE_K230_GPIO, __func__, offset);
> +        return 0;
> +    }
> +}
> +
> +static void k230_gpio_write(void *opaque, hwaddr offset, uint64_t value,
> +                            unsigned size)
> +{
> +    K230GPIOState *s = K230_GPIO(opaque);
> +
> +    switch (offset) {
> +    case K230_GPIO_SWPORTA_DR:
> +        s->swporta_dr = value;
> +        k230_gpio_set_all_output_lines(s);
> +        break;
> +    case K230_GPIO_SWPORTA_DDR: {
> +        uint32_t prev_ddr = s->swporta_ddr;
> +        s->swporta_ddr = value;
> +        k230_gpio_set_all_output_lines(s);
> +        for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +            /* Skip pins whose direction did not change */
> +            if (extract32(prev_ddr, i, 1) == extract32(s->swporta_ddr, i, 1)) {
> +                continue;
> +            }
> +            /*
> +             * When switching back to input mode (and still in software
> +             * control), re-evaluate level-sensitive interrupts. Edge
> +             * interrupts are left untouched, matching the manual TRM v0.3.1.
> +             */
> +            if (!extract32(s->swporta_ddr, i, 1) &&
> +                !extract32(s->swporta_ctl, i, 1)) {
> +                uint32_t is_level = !extract32(s->inttype_level, i, 1);
> +                if (is_level) {
> +                    uint32_t curr_level = extract32(s->ext_porta, i, 1);
> +                    uint32_t pol = extract32(s->int_polarity, i, 1);
> +                    if (curr_level == pol) {
> +                        s->raw_intstatus |= (1U << i);
> +                    } else {
> +                        s->raw_intstatus &= ~(1U << i);
> +                    }
> +                }
> +            }


This is a cosmetic/style suggestion so feel free to ignore it.

I like what you did in the 'skip pins' code above with the early 'continue'. IMO
you should do the same here since you're only doing things after 3 conditions
are met.  I.e. this:


 > +            if (!extract32(s->swporta_ddr, i, 1) &&
 > +                !extract32(s->swporta_ctl, i, 1)) {
 > +                uint32_t is_level = !extract32(s->inttype_level, i, 1);
 > +                if (is_level) {
 > +                    uint32_t curr_level = extract32(s->ext_porta, i, 1);
 > +                    uint32_t pol = extract32(s->int_polarity, i, 1);
 > +                    if (curr_level == pol) {
 > +                        s->raw_intstatus |= (1U << i);
 > +                    } else {
 > +                        s->raw_intstatus &= ~(1U << i);
 > +                    }
 > +                }
 > +            }

Can be written as:

               if (extract32(s->swporta_ddr, i, 1)
                   || extract32(s->swporta_ctl, i, 1)
                   || extract32(s->inttype_level, i, 1))
                  continue;

               /* At this point is_level is true */
               uint32_t curr_level = extract32(s->ext_porta, i, 1);
               uint32_t pol = extract32(s->int_polarity, i, 1);
               if (curr_level == pol) {
                   s->raw_intstatus |= (1U << i);
               } else {
                   s->raw_intstatus &= ~(1U << i);
               }

This will spare us 2 identation levels and, at least to me, is a bit clearer.


  In case you agree I believe you'll have to declare 'curr_level' and 'pol' at
k230_gpio_write() start to avoid creating variables in the middle of a block
too.

Again, just a cosmetic suggestion.


> +        }
> +        k230_gpio_update_int(s);
> +        break;
> +    }
> +    case K230_GPIO_SWPORTA_CTL: {
> +        uint32_t prev_ctl = s->swporta_ctl;
> +        s->swporta_ctl = value;
> +        for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +            /* Skip pins whose control mode did not change */
> +            if (extract32(prev_ctl, i, 1) == extract32(s->swporta_ctl, i, 1)) {
> +                continue;
> +            }
> +            /*
> +             * When switching back from hardware to software control (and DDR
> +             * is input), re-evaluate level-sensitive interrupts. Edge
> +             * interrupts are left untouched, matching the manual TRM v0.3.1.
> +             */
> +            if (!extract32(s->swporta_ddr, i, 1) &&
> +                !extract32(s->swporta_ctl, i, 1)) {
> +                uint32_t is_level = !extract32(s->inttype_level, i, 1);
> +                if (is_level) {
> +                    uint32_t curr_level = extract32(s->ext_porta, i, 1);
> +                    uint32_t pol = extract32(s->int_polarity, i, 1);
> +                    if (curr_level == pol) {
> +                        s->raw_intstatus |= (1U << i);
> +                    } else {
> +                        s->raw_intstatus &= ~(1U << i);
> +                    }
> +                }
> +            }

Likewise.

> +        }
> +        k230_gpio_update_int(s);
> +        break;
> +    }
> +    case K230_GPIO_INTEN:
> +        s->inten = value;
> +        k230_gpio_update_int(s);
> +        break;
> +    case K230_GPIO_INTMASK:
> +        s->intmask = value;
> +        k230_gpio_update_int(s);
> +        break;
> +    case K230_GPIO_INTTYPE_LEVEL:
> +        s->inttype_level = value;
> +        break;
> +    case K230_GPIO_INT_POLARITY:
> +        s->int_polarity = value;
> +        break;
> +    case K230_GPIO_DEBOUNCE:
> +        s->debounce = value;
> +        break;
> +    case K230_GPIO_PORTA_EOI:
> +        for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +            if (extract32(value, i, 1) && extract32(s->inttype_level, i, 1)) {
> +                s->raw_intstatus = deposit32(s->raw_intstatus, i, 1, 0);
> +            }
> +        }
> +        k230_gpio_update_int(s);
> +        break;
> +    case K230_GPIO_LS_SYNC:
> +        s->ls_sync = value;
> +        break;
> +    case K230_GPIO_ID_CODE:
> +        break;
> +    case K230_GPIO_INT_BOTHEDGE:
> +        s->int_bothedge = value;
> +        break;
> +    case K230_GPIO_VER_ID_CODE:
> +        break;
> +    case K230_GPIO_CONFIG_REG2:
> +        break;
> +    case K230_GPIO_CONFIG_REG1:
> +        break;
> +    case K230_GPIO_INTSTATUS:
> +        break;
> +    case K230_GPIO_RAW_INTSTATUS:
> +        break;
> +    case K230_GPIO_EXT_PORTA:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
> +                      HWADDR_PRIx "\n", TYPE_K230_GPIO, __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps k230_gpio_ops = {
> +    .read = k230_gpio_read,
> +    .write = k230_gpio_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static const VMStateDescription vmstate_k230_gpio = {
> +    .name = TYPE_K230_GPIO,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(swporta_dr, K230GPIOState),
> +        VMSTATE_UINT32(swporta_ddr, K230GPIOState),
> +        VMSTATE_UINT32(swporta_ctl, K230GPIOState),
> +        VMSTATE_UINT32(inten, K230GPIOState),
> +        VMSTATE_UINT32(intmask, K230GPIOState),
> +        VMSTATE_UINT32(inttype_level, K230GPIOState),
> +        VMSTATE_UINT32(int_polarity, K230GPIOState),
> +        VMSTATE_UINT32(intstatus, K230GPIOState),

It seems to me that you're not using/writing s->intstatus througout the
code.  IIUC you're using 'raw_intstatus' for everything, and when intstatus
is required you use raw_intstatus and intmask to derive it.  E.g.:

 > +    case K230_GPIO_INTSTATUS:
 > +        return s->raw_intstatus & ~s->intmask;


I believe we're better off by removing s->intstatus entirely.  The logic
doesn't use it and we'll spare a field in the migration stream.

One more thing:


> +        VMSTATE_UINT32(raw_intstatus, K230GPIOState),
> +        VMSTATE_UINT32(debounce, K230GPIOState),
> +        VMSTATE_UINT32(ext_porta, K230GPIOState),
> +        VMSTATE_UINT32(ls_sync, K230GPIOState),
> +        VMSTATE_UINT32(int_bothedge, K230GPIOState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_gpio_enter_reset(Object *obj, ResetType type)
> +{
> +    K230GPIOState *s = K230_GPIO(obj);
> +
> +    s->swporta_dr = 0;
> +    s->swporta_ddr = 0;
> +    s->swporta_ctl = 0;
> +    s->inten = 0;
> +    s->intmask = 0;
> +    s->inttype_level = 0;
> +    s->int_polarity = 0;
> +    s->intstatus = 0;
> +    s->raw_intstatus = 0;
> +    s->debounce = 0;
> +    s->porta_eoi = 0;
> +    s->ext_porta = 0;
> +    s->ls_sync = 0;
> +    s->id_code = 0;
> +    s->int_bothedge = 0;
> +    s->ver_id_code = 0;
> +    s->config_reg2 = 0;
> +    s->config_reg1 = 0;
> +}
> +
> +static void k230_gpio_hold_reset(Object *obj, ResetType type)
> +{
> +    K230GPIOState *s = K230_GPIO(obj);
> +
> +    k230_gpio_update_int(s);
> +}
> +
> +static void k230_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    K230GPIOState *s = K230_GPIO(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    int i;
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &k230_gpio_ops, s,
> +                          TYPE_K230_GPIO, K230_GPIO_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    qdev_init_gpio_in(DEVICE(s), k230_gpio_set, K230_GPIO_PINS_PER_GROUP);
> +    qdev_init_gpio_out(DEVICE(s), s->output, K230_GPIO_PINS_PER_GROUP);
> +
> +    for (i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +    }
> +}
> +
> +static void k230_gpio_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = k230_gpio_realize;
> +    rc->phases.enter = k230_gpio_enter_reset;
> +    rc->phases.hold = k230_gpio_hold_reset;
> +    dc->vmsd = &vmstate_k230_gpio;
> +    dc->desc = "K230 GPIO controller";
> +}
> +
> +static const TypeInfo k230_gpio_info = {
> +    .name = TYPE_K230_GPIO,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230GPIOState),
> +    .class_init = k230_gpio_class_init,
> +};
> +
> +static void k230_gpio_register_types(void)
> +{
> +    type_register_static(&k230_gpio_info);
> +}
> +
> +type_init(k230_gpio_register_types)
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 6a67ee958f..94b5d9e2fa 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
>   system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> +system_ss.add(when: 'CONFIG_K230_GPIO', if_true: files('k230_gpio.c'))
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..410877425c 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>       select SERIAL_MM
>       select UNIMP
>       select K230_WDT
> +    select K230_GPIO
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..62967a67d0 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,8 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-gpio0", &s->gpio[0], TYPE_K230_GPIO);
> +    object_initialize_child(obj, "k230-gpio1", &s->gpio[1], TYPE_K230_GPIO);
>   
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -206,6 +208,25 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                          qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>   
> +    /* GPIO */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gpio[0]), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[0]), 0,
> +                    memmap[K230_DEV_GPIO0].base);
> +    for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[0]), i,
> +                           qdev_get_gpio_in(DEVICE(s->c908_plic),
> +                                            K230_GPIO0_IRQ_BASE + i));
> +    }
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gpio[1]), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[1]), 0,
> +                    memmap[K230_DEV_GPIO1].base);
> +    for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[1]), i,
> +                           qdev_get_gpio_in(DEVICE(s->c908_plic),
> +                                            K230_GPIO1_IRQ_BASE + i));
> +    }
> +
>       /* unimplemented devices */
>       create_unimplemented_device("kpu.l2-cache",
>                                   memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -322,12 +343,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
>                                   memmap[K230_DEV_PWM].size);
>   
> -    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
> -                                memmap[K230_DEV_GPIO0].size);
> -
> -    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
> -                                memmap[K230_DEV_GPIO1].size);
> -
>       create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
>                                   memmap[K230_DEV_ADC].size);
>   
> diff --git a/include/hw/gpio/k230_gpio.h b/include/hw/gpio/k230_gpio.h
> new file mode 100644
> index 0000000000..2e52bbf760
> --- /dev/null
> +++ b/include/hw/gpio/k230_gpio.h
> @@ -0,0 +1,73 @@
> +/*
> + * QEMU K230 GPIO Controller
> + *
> + * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18), section 12.5 GPIO
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + */
> +
> +#ifndef HW_K230_GPIO_H
> +#define HW_K230_GPIO_H
> +
> +#include "qemu/osdep.h"

Please do not add osdep.h in header files.  Move it to k230_gpio.c.


Thanks,
Daniel

> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_GPIO "k230.gpio"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230GPIOState, K230_GPIO)
> +
> +#define K230_GPIO_MEM_SIZE 0x1000
> +
> +#define K230_GPIO_SWPORTA_DR      0x00
> +#define K230_GPIO_SWPORTA_DDR     0x04
> +#define K230_GPIO_SWPORTA_CTL     0x08
> +#define K230_GPIO_INTEN           0x30
> +#define K230_GPIO_INTMASK         0x34
> +#define K230_GPIO_INTTYPE_LEVEL   0x38
> +#define K230_GPIO_INT_POLARITY    0x3c
> +#define K230_GPIO_INTSTATUS       0x40
> +#define K230_GPIO_RAW_INTSTATUS   0x44
> +#define K230_GPIO_DEBOUNCE        0x48
> +#define K230_GPIO_PORTA_EOI       0x4c
> +#define K230_GPIO_EXT_PORTA       0x50
> +#define K230_GPIO_LS_SYNC         0x60
> +#define K230_GPIO_ID_CODE         0x64
> +#define K230_GPIO_INT_BOTHEDGE    0x68
> +#define K230_GPIO_VER_ID_CODE     0x6c
> +#define K230_GPIO_CONFIG_REG2     0x70
> +#define K230_GPIO_CONFIG_REG1     0x74
> +
> +#define K230_GPIO_PINS_PER_GROUP 32
> +
> +struct K230GPIOState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t swporta_dr;
> +    uint32_t swporta_ddr;
> +    uint32_t swporta_ctl;
> +    uint32_t inten;
> +    uint32_t intmask;
> +    uint32_t inttype_level;
> +    uint32_t int_polarity;
> +    uint32_t intstatus;
> +    uint32_t raw_intstatus;
> +    uint32_t debounce;
> +    uint32_t porta_eoi;
> +    uint32_t ext_porta;
> +    uint32_t ls_sync;
> +    uint32_t id_code;
> +    uint32_t int_bothedge;
> +    uint32_t ver_id_code;
> +    uint32_t config_reg2;
> +    uint32_t config_reg1;
> +
> +    qemu_irq irq[K230_GPIO_PINS_PER_GROUP];
> +    qemu_irq output[K230_GPIO_PINS_PER_GROUP];
> +};
> +
> +#endif
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..5fccea7fd5 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
> +#include "hw/gpio/k230_gpio.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>       RISCVHartArrayState c908_cpu; /* Small core */
>   
>       K230WdtState wdt[2];
> +    K230GPIOState gpio[2];
>       MemoryRegion sram;
>       MemoryRegion bootrom;
>   
> @@ -127,8 +129,11 @@ enum {
>       K230_UART2_IRQ  = 18,
>       K230_UART3_IRQ  = 19,
>       K230_UART4_IRQ  = 20,
> +    K230_GPIO0_IRQ_BASE  = 32,
> +    K230_GPIO1_IRQ_BASE  = 64,
>       K230_WDT0_IRQ   = 107,
>       K230_WDT1_IRQ   = 108,
> +
>   };
>   
>   #define K230_UART_COUNT 5



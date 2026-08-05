Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E119EC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrhpr-00046f-FH; Wed, 05 Aug 2026 16:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrhpd-00040I-SS
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:03:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrhpY-00058D-Kt
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:03:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HS6tN3888529
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 20:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XR10QZzNm4Vl16+RhWmWxk1SacnYYvZaYdlfDiGaqkk=; b=V4qsM2vDXJ4irQdx
 3hT2awTII8eSdIQBCulbzzqseWMlZCDV3tY+6lXJ8LYBRvy9ss7bkFpzWhLpYZyv
 z2m35SBbFjcNTtl9c2YkmvFV45BynerrLimeX5xlNP9ZvgkBBj8xzrOav+yaeb1f
 nL4WAK8wdiWKvaoCNhBBoCTX7oD5lWBJM1IgCEOxZCrDBRkbTOt6kKQjmak0wl6Q
 qsZz43defwNlq6pJ0mANvIZZ/mvvNsbZwTUAUKztkfjCchg4e+PyYSHJVVtU/Fpz
 pby/t2RW28sizttdyxRl4YdAAxtn3OEKOt7knqPEBWwp21yA4llQ+lbhxOakAcv3
 /5yKCA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5sw5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:03:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934979ee9f1so148260485a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785960187; x=1786564987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XR10QZzNm4Vl16+RhWmWxk1SacnYYvZaYdlfDiGaqkk=;
 b=BI4h8kKaQsVQ1szyjinMBX9YGoIBXn59uLLbceEaA+BoqKF5DgkJ5+SF4+TMRssP7F
 BD7V/p1T5SG/PXT9mC9rEzWRU9ydAnm7xI1uBTCaf+66HkkZ5V/pQPjL8kRUQhM5PrCN
 tYJTCFE8kqpS78DUjj8J5uWczeTPo5XugOLHQ3Q5ujte0I5fIqeqJZVxLKsf6FMc+/Gm
 VqdFxxSyUyIvAC/HRXcPvBlHKRne7qfMWd+EpFmxi41SLnBaE3NEaIEKkcTrhASYFycf
 35u3jvWHCaCLT93ZvORschkovVJ25KXeSPAZJJOquuVzK3WIeS6VGY01x3bqyEZ+JxH9
 86DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960187; x=1786564987;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XR10QZzNm4Vl16+RhWmWxk1SacnYYvZaYdlfDiGaqkk=;
 b=ketapN7BkiZ2I2B1LM1b1oU9KPi+V9fL779LqB8JyN4Vkr09LERNkJnWepXI4W6fVm
 iAfvCi9h2rzuPA/bqHTU1XUjirQZyr187i5/UJFRkD2SItIQXr3gzPjxLAI9QNi6xm02
 yR/U5RMolN5a4AGFY8226lt/qO8+l0pOCsKNjQ7K1SxyhUUMFyhhI0DuE9Rz57aNoLIp
 E/ANNmTmMbGBlBspbTRww8sOrEJc6qMkwtpTlf/2s6enWfiAqVso4IJDNuNpfrghIURf
 Vo2Zs3P4I2+sThsc6hznRsRxHSbsrZxjC+8LYeYke/4C6hDW/iRNtKVsHcgBN/SX+Frr
 za6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0wowAhnJGNgyDlMU1yfQFoKxbCMNvJJY0cOVvc2TXs84vQpn3/JEXjitfv4MDoRGNtDNkhuZrYPhA@nongnu.org
X-Gm-Message-State: AOJu0YwkYbSJiHJwTpTp75fNlnHc188o9DpTsriHrwyO6+4F5l2foSiJ
 jfijyV3LlnF239SGLiiIYDjTFcpwbt1nSxJ8s0Us8XcJ3jQ6xIjeHPKQfx0to9agzDfGSKZMTYx
 5EAhvt9t4WsVwSjNwTua+BXKUOf5YrD8+RZza4CbViYG8JRktFk66kCfDLQ==
X-Gm-Gg: AR+sD11xrGEyjzvg+3Er/EO9xO9LJGhZcwRWqX11fKizNPnLtJDM/FB6V1a41LEUZbs
 t49ZbqhMpjLnBLOwBXauqauJUZWSeiyoXut8OxsplRDymGPL235W6NMtkWE796AQiWxJYyoXccd
 GpswgBr6xdRp9Uf4UYMpNDV8Ls9P727O5rTImDeFKScjVAYyjrW469tlpmHOx5uuxoyUuIFcZJm
 Q05CMNmJvWejIsynLQNDWyLXGa+sHbXwWTcwWZOskYJyx6Lfh+O/yHhX0E4SHc3MfXV0klBFhm5
 fqyU0mgnkAgHJfwuYssiJKwYz66KDVXN+3m8sl8fFhHo2OVma2uJCBiXQ6aaId5Cr5NFe/emKI8
 WKmrhhE6iTL9QY/w3EMpTooGnWEPWAw+d1Nic
X-Received: by 2002:a05:620a:13cf:b0:92e:76a1:96d3 with SMTP id
 af79cd13be357-9364929b239mr685896585a.34.1785960187331; 
 Wed, 05 Aug 2026 13:03:07 -0700 (PDT)
X-Received: by 2002:a05:620a:13cf:b0:92e:76a1:96d3 with SMTP id
 af79cd13be357-9364929b239mr685819885a.34.1785960181963; 
 Wed, 05 Aug 2026 13:03:01 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a58d356sm226710285a.41.2026.08.05.13.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 13:03:01 -0700 (PDT)
Message-ID: <7a8a14f9-f501-499e-b4b4-1de92a161beb@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 17:02:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/3] hw/riscv: k230: connect DW 8250 UART
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com>
 <20260725-feat-k230-uart-v2-v2-2-d5fe82c47c28@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260725-feat-k230-uart-v2-v2-2-d5fe82c47c28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Xea5Co55 c=1 sm=1 tr=0 ts=6a7396fc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oS42Cadbgcrl33LgFjoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 0DxDkgX8TT7uH7gyfWKKNpLECxbKnYpg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX/+eaQtYXpPEO
 DdMbJH8qYeP3FrIAtvlJV+02GHjSkqF+lmh1wlrF+nsC6JC45UB3NAJeejEfjABMULQwmRh9po8
 7w9gVzPDlHgFCgBb+CjsFaGIHlbwAd/TjMSLQKQD8JL0Z+ZO62VdDpIUChbowam9/d801m2OC6X
 /jTFYZ2UVlvR3JIB+PCNqi6Y1uRoUeM/xNmTAepcWbLCITciih/gndEOeb7ZOMgnTY2qNkdccfz
 cwPa8vkWedk60zBdJGkpgsIJg0t9G35c5b5ulASDL5/kJD8VtcGELHwaTWDSzDFCYudgyQqK+Qw
 yGDpUa41PDhUq7U5ZtvOl3qbAMgZ3NuiGqOVASkH5/g7esQhPzvLOYHN35pMyHOwaBGNwxtk1xm
 vTYDPyUKMMTfQdSjmhgyB6thq2xEiSJZiyKpnl+CpLUPPg33PSDJjxQWfDSnrB9wkFkpTHo4QIZ
 9AKXiQNMQ3O/vvlKllg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX6crwjobrqckr
 EH9g7PPNqJDcsIH7FBq22wzVgKMtpPdJslV4EHI3Zdd3T4DIsr7edmInezfZWAZZDL3MmPLw0JO
 Ee3a0qF9Slr3DgtlqUns7F5GNPg31KE=
X-Proofpoint-ORIG-GUID: 0DxDkgX8TT7uH7gyfWKKNpLECxbKnYpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/25/2026 12:52 AM, WX Chen wrote:
> Replace the generic serial-mm device with the K230 DW 8250-compatible
> UART model added in the previous patch.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/k230.c         | 33 ++++++++++++++++++++++-----------
>   include/hw/riscv/k230.h |  6 ++++--
>   2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 502281c52cff1dce6febb7487dfdefefe6363e9c..d49fa23448f38dfed45a570eb5bece64519bfe27 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -29,7 +29,6 @@
>   #include "hw/riscv/machines-qom.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/intc/sifive_plic.h"
> -#include "hw/char/serial-mm.h"
>   #include "hw/misc/unimp.h"
>   
>   /* Align K230_SDK k230_canmv_defconfig */
> @@ -111,6 +110,11 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
>   
> +    for (int i = 0; i < K230_UART_COUNT; i++) {
> +        g_autofree char *name = g_strdup_printf("k230-uart%d", i);
> +        object_initialize_child(obj, name, &s->uart[i], TYPE_K230_UART);
> +    }
> +
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
>       qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
> @@ -136,19 +140,26 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
>                                 memmap[K230_DEV_PLIC].size);
>   }
>   
> -static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
> -                             int index)
> +static void k230_create_uart(K230SoCState *s, DeviceState *plic, int index)
>   {
>       int uart_dev = K230_DEV_UART0 + index;
> -    g_autofree char *name = g_strdup_printf("uart%d", index);
> +    g_autofree char *unimpl_name = g_strdup_printf("uart%d", index);
> +    DeviceState *dev = DEVICE(&s->uart[index]);
>   
> -    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
> -    create_unimplemented_device(name, memmap[uart_dev].base,
> -                                memmap[uart_dev].size);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(index));
>   
> -    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
> -                   qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
> -                   399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, memmap[uart_dev].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(plic, K230_UART0_IRQ + index));
> +
> +    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
> +    create_unimplemented_device(unimpl_name,
> +                                memmap[uart_dev].base + 0x100,
> +                                memmap[uart_dev].size - 0x100);
>   }
>   
>   static void k230_soc_realize(DeviceState *dev, Error **errp)
> @@ -188,7 +199,7 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>   
>       /* UART */
>       for (int i = 0; i < K230_UART_COUNT; i++) {
> -        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
> +        k230_create_uart(s, DEVICE(s->c908_plic), i);
>       }
>   
>       /* Watchdog */
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf8a8f8a1c66653ff9b568fbfe98a3ea..fed0357c2b9e1f5254cb157e0cd4d75d4946d1a1 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -17,10 +17,13 @@
>   
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
> +#include "hw/char/k230_uart.h"
>   #include "hw/watchdog/k230_wdt.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> +#define K230_UART_COUNT 5
> +
>   #define TYPE_RISCV_K230_SOC "riscv.k230.soc"
>   #define RISCV_K230_SOC(obj) \
>       OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
> @@ -32,6 +35,7 @@ typedef struct K230SoCState {
>       /*< public >*/
>       RISCVHartArrayState c908_cpu; /* Small core */
>   
> +    K230UartState uart[K230_UART_COUNT];
>       K230WdtState wdt[2];
>       MemoryRegion sram;
>       MemoryRegion bootrom;
> @@ -131,8 +135,6 @@ enum {
>       K230_WDT1_IRQ   = 108,
>   };
>   
> -#define K230_UART_COUNT 5
> -
>   /*
>    * Integrates with the interrupt controller (PLIC),
>    * which can process 208 interrupt external sources
> 



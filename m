Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16348CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGiE-00055n-8H; Thu, 01 Oct 2026 09:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCGiB-00055X-4m
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:20:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCGi8-0004g7-Uz
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:20:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691CLN25396234
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 13:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aevunFh2VR3OoiMZUjBR7R6IVa6O/WCam1NH2fHd7HY=; b=ocUcGTxZP5obctKL
 cXZrOF5e9Szchbi9HN9zQhr/bSc7GHnLyvpUPlOlun+vaIOvRzPimd1l0mPlweT2
 Os2Jk+LbbNig3FDNujVBXzN1homjO0b4gj8D67xI4QCDJ9Mqh7ogBWeR7ZHJXRLv
 Y59rRP4GPil033QjfuYCGrBTVMoE//zNJDy1rCQPnyMHqIzdjgO9L4xho+/spv2r
 EwI3Wl/fKTtXwxp+JNZNzfa+2XXQYmuB6JRVhz7977gBvC4TVoM+rWTdLebB1nph
 D7VSxrHPekRz9pcw3QCYccAWDMjS10iyNcGQN7Lq20E0SUMLy7JyHGRPo1eqfd1h
 yL+2pg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5b5r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:20:29 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-892be308686so86295927b3.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790860828; x=1791465628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aevunFh2VR3OoiMZUjBR7R6IVa6O/WCam1NH2fHd7HY=;
 b=K325QemLnSqk4QS9qTENyc5WkkZ35QnjO4VkKPCiEhMlTMEyD3Q/zJMzZbYEaaOvZ3
 DZ2EClstUynq8EbmRdgWuGbS9zIucKNhX8+scjpJkiyEad8J8eUuHoLEpKUKLF4u66Bs
 86gkcrRE7GWV3U5ZDgN01gdIi37uMksWSr/eWPM69JOmRylIxR4GMLHYBn4/eHneTQC+
 cfOoWJgp2w78X5Aj0l3ClJ/cZ4HlPO8zrZj+WzoUKtyfiBxHaokl2eFrVDUr0OUviIbn
 j1PH+dLfUFbZns4UMm4UN7j2prXZhRW7MatUmJMLdK0bGrKdBOQ2Q06NS4z8tjYF0bpo
 yvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790860828; x=1791465628;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aevunFh2VR3OoiMZUjBR7R6IVa6O/WCam1NH2fHd7HY=;
 b=p4UtffKNLQ1fNkOi2MQHvHkEYr9N2QK68RlKARo+T/SMQq2K/rMo9r884wPDxFaYxm
 5RMufQBlgT1CJpF8fW4x5Gta9xxYKdo5ZcQoKs0U4EKGWl5t1ijPs73GZyjuNWWrg7MB
 zImewnzU1jU0mqmPENFfIeldM2UdzWwkQb5ZbvDbRwy4kYKHOT9jFAGNzow7uA7dVOLI
 EnxEhat+h0XISQgnLltJWiyLnIbRtFgepkTtEqI71NAooSPXeRoJ+5qs5zd4Z5mcXvIv
 3SQsiViwSYurjtSYeZsylAtWzPptretaM9cKwdEEBaAmu96QUkwTPrZJCWB2YZir1tNo
 GZnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT8XajFUqPJP26UXQiphp8Zbto9Wn34kBnO8bzHpLByrv/wa1f2j8E7lhchR4u4XrSWKcSiq0EoCWy@nongnu.org
X-Gm-Message-State: AFq9FYLXGb8J/yrUMEEDmg4fmdrzeFlAEdOADgpIEt390D4vA7f1BWZB
 Xd4SJzdWkU0MvVZLS8ivyUyv+NTwKpuIRZFG8SOyw4Pt7dpjYkmNwVKxfrZQd3koY/kvw6DqA13
 PVryirARAFhDKllEBkvZ6YMEydd4GEBeUyHUidUMceeqr5EriciHGcx+ocA==
X-Gm-Gg: AYBFou1QDZpCjvrlr7hDUtxThGjs8j0KrlJZnjVKRJzAxGlnW1d8jBwHvJ0NOx/1ZQP
 ThpATT2V4RKcWwh92Pzg4rTqx46JogZmFzqHO9qSGnZMQXKrZNHpCBtS2AcYBUeI5hYu/3wCfHo
 JyiRhNnwoPuviOPu/XLArLV5Vf6UnkkXqKdjKPm5IROp4PGYdJMj3kv1UcDpIamsnDm7hoZxwn9
 4VD7FXiYzRkSAcT7YcK/a3kNXbWQ/BTy8fFmRPeVovfgWDi2akpbeqIjUkRMcn+0lrpkn+AxAob
 2gucKbztY2cnusRwMzVhumRcgXD8gj2N8cezq1AStVBbHD7i2rJgPTq5nGZBZWu34WPBcQuSZ3N
 ftsKC78uV6EhxdFSLVcnn9CTy7avCvJ2PJg==
X-Received: by 2002:a05:690e:4411:b0:671:471d:c3b8 with SMTP id
 956f58d0204a3-676834473e3mr1925503d50.17.1790860828349; 
 Thu, 01 Oct 2026 06:20:28 -0700 (PDT)
X-Received: by 2002:a05:690e:4411:b0:671:471d:c3b8 with SMTP id
 956f58d0204a3-676834473e3mr1925473d50.17.1790860827684; 
 Thu, 01 Oct 2026 06:20:27 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a89a52e1sm26474366d6.13.2026.10.01.06.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 06:20:27 -0700 (PDT)
Message-ID: <369a6f46-65f5-4aa5-a9f6-d60f10b266e7@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 10:20:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/riscv/atlantis: Use dw8250 UART model
To: 'Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>
References: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
 <20261001031720.2334056-2-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001031720.2334056-2-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXwhD/5C+j/vAY
 6Be/fgfqjC/A4mB4TLA5+7gR/uQ7ticjNTIRyTbadJ6dFlrqM/oIHHAb4fq7LzVX5f+XeKYONBb
 ZBadZljdjSewf0eeu9j73nkHRgnEYSQdrdIvMwojjem9d3NNzz1lP1AAwe7hv4A990MJav2vNq5
 e8cZ//A9VsrwbIsJuBMQLF3uaretT92VFJLRBzhxaG/W5LmIFvAXzZvTeaODHTQXP4l3aws1LrE
 ph7N5b94NqBfp0wOZWonUVSjtQR2RctxnW+T7AC6JYSExrwXyOckIsGeETMh+MK9B2FghAB41Kb
 G2K0lphie1E9ZuquRPfthfgezGDT4+YgFVP+o2dyyn0hvnjJ5IV51sPbILyXPSuc57YXqGKZQ0z
 eqaW9Si35nV9VByAad95orhkDWdiWwVb8MtX/8JURyhokrknveuw82i2EVClxSLLbJsTkxZM3OE
 haIneq0xUsbXTr4j7Eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXzEjdHXmrtMUi
 Av+ApXn7Nl7rD/erZdzFFtf3FukNuJN27K69ucGuAPD9rgx2X9ILJFZ/F1t0Z5o3JluiOCqJM3h
 taAWLs6Z2BKzgFpeTSwlIukYRt5ZhGY=
X-Proofpoint-ORIG-GUID: 7cn9vsVRBvBZyYrqyHx03qHBBFKL8HjB
X-Proofpoint-GUID: 7cn9vsVRBvBZyYrqyHx03qHBBFKL8HjB
X-Authority-Analysis: v=2.4 cv=NrJE4MdJ c=1 sm=1 tr=0 ts=6abe5e1d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=xQOczflb7_0DwEsGZi4A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053
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



On 10/1/2026 12:17 AM, 'Portia Stephens wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> Replace the ns16550 UART with a Designware UART now that a model is
> available. The hack which sets the rest of the UART register space as
> unimplemented can be removed.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/Kconfig               |  2 +-
>   hw/riscv/tt_atlantis.c         | 45 +++++++++++-----------------------
>   include/hw/riscv/tt_atlantis.h |  4 +--
>   3 files changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..5d2abdbb67 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -127,7 +127,7 @@ config TENSTORRENT
>       select RISCV_ACLINT
>       select RISCV_APLIC
>       select RISCV_IMSIC
> -    select SERIAL_MM
> +    select DW8250
>       select DEVICE_TREE
>       select DESIGNWARE_I2C
>       select DS1338
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 8a219afef7..70815e12ef 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -24,9 +24,8 @@
>   #include "hw/riscv/fdt-common.h"
>   #include "hw/riscv/riscv_hart.h"
>   
> -#include "hw/char/serial-mm.h"
> +#include "hw/char/dw8250.h"
>   #include "hw/intc/riscv_aclint.h"
> -#include "hw/misc/unimp.h"
>   
>   #include "system/system.h"
>   #include "system/device_tree.h"
> @@ -262,11 +261,15 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
>   static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
>                               int irqchip_phandle)
>   {
> +    static const char * const compat[2] = {
> +        "snps,dw-apb-uart", "ns16550a"
> +    };
>       g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
>                                               mem->base);
>   
>       qemu_fdt_add_subnode(fdt, name);
> -    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_string_array(fdt, name, "compatible",
> +                                 (char **)&compat, ARRAY_SIZE(compat));
>       qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
>       qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
>       qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> @@ -409,17 +412,6 @@ static void load_fdt(TTAtlantisState *ams)
>       create_fdt_memory(ms->fdt, &ams->soc);
>   }
>   
> -static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
> -                                   const char *name, hwaddr addr, uint64_t size)
> -{
> -    qdev_prop_set_string(DEVICE(dev), "name", name);
> -    qdev_prop_set_uint64(DEVICE(dev), "size", size);
> -    sysbus_realize(dev, &error_abort);
> -
> -    memory_region_add_subregion_overlap(memory, addr,
> -                                        sysbus_mmio_get_region(dev, 0), -1000);
> -}
> -
>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>   {
>       TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
> @@ -488,8 +480,7 @@ static void tt_atlantis_soc_init(Object *obj)
>   
>       object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
>   
> -    object_initialize_child(obj, "uart1", &s->uart1,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
>   
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
>           object_initialize_child(obj, "i2c[*]", &s->i2c[i],
> @@ -584,21 +575,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>                                   &s->bootrom);
>   
>       /* UART1, the soc console (UART0 is for the boot microcontroller) */
> -    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
> -                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
> -                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> -    /*
> -     * Atlantis contains a DesignWare uart while the QEMU machine
> -     * uses the serial_mm model with the base ns16550 register set.
> -     * Linux's dw driver writes outside of serial_mm's 0x20 sized
> -     * mapping and faults.
> -     *
> -     * Create an unimplemented device region so writes don't fault
> -     * and reads return zero, which keeps Linux happy.
> -     */
> -    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
> -                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
> -                           s->memmap[TT_ATL_UART1].size);
> +    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
> +    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
> +    memory_region_add_subregion(s->memory,
> +                                s->memmap[TT_ATL_UART1].base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
> +                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
>   
>       /* I2C */
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 3923308b7c..000988c037 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -13,7 +13,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/i2c/designware_i2c.h"
>   #include "hw/intc/riscv_imsic.h"
> -#include "hw/misc/unimp.h"
> +#include "hw/char/dw8250.h"
>   #include "hw/riscv/riscv_hart.h"
>   
>   #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
> @@ -39,7 +39,7 @@ struct TTAtlantisSoCState {
>       RISCVHartArrayState cpus;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> -    UnimplementedDeviceState uart1;
> +    DW8250State uart1;
>       MemoryRegion bootrom;
>   
>       uint32_t num_harts;



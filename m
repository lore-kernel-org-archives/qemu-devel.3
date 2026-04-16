Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39FEF8DFCB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUK3-00046X-BG; Thu, 16 Apr 2026 17:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUK1-000469-EM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:32:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUJy-0000Oh-Ed
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:32:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483487335c2so35075e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776375141; x=1776979941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xC4LaGfN1cnh++zqLJpM1fZQxifhsAfHwRcq3djkkAw=;
 b=her7azTi+5/kpEGvALS5oIQEycGsIn30vA2BLI8xbnrH6lV3FCEUEYE58hqdGREaED
 GflXKDYFt1WIBztCkbKw3XHYNf1MhMpsFJq5wIlQHIXWIQD1DvxpBSehL8fkQAA13TOX
 LvQb2D7L+WyiDIp2k2Qotr7OoJiG+Sgt8T46lcgX4orgx+vxmNMC9hB64RJqQxOXeqYN
 gogQsGnZjnculJ1pdWiLClq6Bqpr2YsIuPAAvzIzCaXu/WNUnbGlFFJc/xhmDRmjnyVR
 4jSTbPZ5k2jP/zZMwovkUIYyfqz1DpjSstQUuUa7N/S0oYeH2w/dyESvDYkDm8+l1dfu
 tUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375141; x=1776979941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xC4LaGfN1cnh++zqLJpM1fZQxifhsAfHwRcq3djkkAw=;
 b=OwYAIIf1bSunxceU+uM9U4RK8v2ez75Ow8xT2URdIzusz88qr7Mv4mw7DRKfG/2OX9
 yXhpghMVP7PXHuLp1bsRgaCHCjM9uI3/1DCzBboblzhRJYXfwzyVVi97yzG6C+1pyjbw
 oMaWoy17sNWRhelxpfRfvmvo5h3Y5AlwZfyWteaeiMexzat2HKu2eR0fKCHhcyFezUvz
 PqRKF3G1Jn1uE1B7ERPaS5fspFb05eoSIO3BPs8g0Lcn356oImwMS8uvWl9C4JNKScZp
 xhCI0kMKe7//g7EyA6zuSVsqDytFF73/v/hPYAWZMHa4A/8IlvcVUaNI1gNtXVNcP9N4
 Ufrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ977jekIx1bjWu3GX5C11GmiV6dS9NRxsyIpCxqhnTAcVWi/Yqn+dmWpG9BntzDwFQC98HbdCVnAvGd@nongnu.org
X-Gm-Message-State: AOJu0Yzd6ssFWcrEn8GXMPH68Yvz/nnGkL1a3KDSj2jVTqqilytHumrp
 FNE2TG2pxI9UISRu6kTVtI3GPa7FV9qDhZ1FoZAdNVzMHyANSPam2lVLAOjdPNi/PFA=
X-Gm-Gg: AeBDieuY0vXXQBeEkN2TG52wISZRj5Q9/x2m19dZlPsgxquvL73JI49VVkqSPEGT4Aq
 VSK9259BLM+cHUSN1gwbg/fo3WTiplQdjymx0AC/c7zLR/tUTDW99Wk8HQZ4viQ0HZbW/w7GmF6
 XOquFBy/MPejwu2PmaRI5kVXRVAppOT71Nx+uXQF48u9VGsSbGxRJ/j9kkO//4LSkfiDuXIVFPV
 BWm7KAlbHvMzyYvZOAcLB1Q2eDxmLojc95RxljDQlRmhQDesRNM5NF+hW6THVXYS0tt7bOstnQ6
 3RBUk7EX3xuBelhn/sfdnVIYNWrC98zBjA4kV8G5evHWJDVXADZjqRR8hib9ZUgnRId7ba3G055
 t2Pp9qIxhnQuK3I0P7TiCXVhxC4cU3EWE9gHMQUuYGRfBjTwNrb4eaeguKa85cj+en0feJqdGCF
 HCwrsS3yIjE2gUqvk0D70K18NItUaLoePIRQGewWoCbevEE82z/HuGDr82YMFs2kVYFKa2KcuHQ
 l4YjFL1Crazt1w=
X-Received: by 2002:a05:600c:c118:b0:488:7a24:9ddf with SMTP id
 5b1f17b1804b1-488fb79ca52mr2147335e9.28.1776375140392; 
 Thu, 16 Apr 2026 14:32:20 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d6409sm16975194f8f.23.2026.04.16.14.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:32:19 -0700 (PDT)
Message-ID: <edb437fa-66b4-43f2-bf88-1ccf8ea5d3e9@linaro.org>
Date: Thu, 16 Apr 2026 23:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/hexagon: Define hexagon "virt" machine
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 16/4/26 23:03, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   configs/devices/hexagon-softmmu/default.mak |   1 +
>   configs/targets/hexagon-softmmu.mak         |   1 +
>   include/hw/hexagon/virt.h                   |  43 ++
>   hw/hexagon/virt.c                           | 456 ++++++++++++++++++++
>   target/hexagon/cpu.c                        |   2 +
>   hw/hexagon/Kconfig                          |  10 +
>   hw/hexagon/meson.build                      |   2 +
>   tests/qemu-iotests/testenv.py               |   1 +
>   8 files changed, 516 insertions(+)
>   create mode 100644 include/hw/hexagon/virt.h
>   create mode 100644 hw/hexagon/virt.c
> 
> diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
> index 08e709aea72..37b4f9f3237 100644
> --- a/configs/devices/hexagon-softmmu/default.mak
> +++ b/configs/devices/hexagon-softmmu/default.mak
> @@ -3,5 +3,6 @@
>   # Uncomment the following lines to disable these optional devices:
>   
>   # Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_HEX_VIRT=y
>   # CONFIG_HEX_DSP=y
>   # CONFIG_L2VIC=y
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> index fdfa29b4f39..a77c100f0c5 100644
> --- a/configs/targets/hexagon-softmmu.mak
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> +TARGET_NEED_FDT=y
> diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
> new file mode 100644
> index 00000000000..a54eac5cf00
> --- /dev/null
> +++ b/include/hw/hexagon/virt.h
> @@ -0,0 +1,43 @@
> +/*
> + * Definitions for hexagon virt board.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGONVIRT_H
> +#define HW_HEXAGONVIRT_H
> +
> +#include "hw/core/boards.h"
> +#include "target/hexagon/cpu.h"
> +
> +struct HexagonVirtMachineState {
> +    /*< private >*/

(remove this unuseful comment)

> +    MachineState parent_obj;
> +
> +    int fdt_size;
> +    MemoryRegion *sys;
> +    MemoryRegion cfgtable;
> +    MemoryRegion ram;
> +    MemoryRegion tcm;
> +    MemoryRegion vtcm;
> +    MemoryRegion bios;
> +    DeviceState *l2vic;
> +    Clock *apb_clk;
> +};
> +
> +void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
> +
> +enum {
> +    VIRT_UART0,
> +    VIRT_QTMR0,
> +    VIRT_QTMR1,
> +    VIRT_GPT,
> +    VIRT_MMIO,
> +    VIRT_FDT,
> +};

Do we really need to expose this enum? Otherwise it could go in the source.

> +
> +#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
> +
> +#endif /* HW_HEXAGONVIRT_H */
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> new file mode 100644
> index 00000000000..ff93b5221ba
> --- /dev/null
> +++ b/hw/hexagon/virt.c
> @@ -0,0 +1,456 @@
> +/*
> + * Hexagon virt emulation
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hexagon/virt.h"
> +#include "elf.h"
> +#include "hw/char/pl011.h"
> +#include "hw/core/clock.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/hexagon/hexagon.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/register.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qemu/units.h"
> +#include "elf.h"
> +#include "machine_cfg_v68n_1024.h.inc"
> +#include "system/address-spaces.h"
> +#include "system/device_tree.h"
> +#include "system/reset.h"
> +#include "system/system.h"
> +#include <libfdt.h>
> +
> +static const int VIRTIO_DEV_COUNT = 8;
> +
> +static const MemMapEntry base_memmap[] = {
> +    [VIRT_UART0] = { 0x10000000, 0x00000200 },
> +    [VIRT_MMIO] = { 0x11000000, 0x1000000, },
> +    [VIRT_GPT] = { 0xab000000, 0x00001000 },
> +    [VIRT_FDT] = { 0x99800000, 0x00400000 },
> +};
> +
> +static const int irqmap[] = {
> +    [VIRT_MMIO] = 18, /* ...to 18 + VIRTIO_DEV_COUNT - 1 */
> +    [VIRT_GPT] = 12,
> +    [VIRT_UART0] = 15,
> +    [VIRT_QTMR0] = 2,
> +    [VIRT_QTMR1] = 4,
> +};
> +
> +
> +static void create_fdt(HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    void *fdt = create_device_tree(&vms->fdt_size);
> +    uint8_t rng_seed[32];
> +
> +    if (!fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    ms->fdt = fdt;
> +
> +    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x1);
> +    qemu_fdt_setprop_string(fdt, "/", "model", "hexagon-virt,qemu");
> +    qemu_fdt_setprop_string(fdt, "/", "compatible", "qcom,sm8150");
> +
> +    qemu_fdt_add_subnode(fdt, "/soc");
> +    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x1);
> +    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> +
> +    qemu_fdt_add_subnode(fdt, "/chosen");
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
> +}
> +
> +static void fdt_add_hvx(HexagonVirtMachineState *vms,
> +                        const struct hexagon_machine_config *m_cfg,
> +                        Error **errp)
> +{
> +    const MachineState *ms = MACHINE(vms);
> +    uint32_t vtcm_size_bytes = m_cfg->cfgtable.vtcm_size_kb * 1024;
> +    if (vtcm_size_bytes > 0) {
> +        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram", vtcm_size_bytes,
> +                               errp);
> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base << 16,
> +                                    &vms->vtcm);
> +
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/vtcm");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/vtcm", "compatible",
> +                                "qcom,hexagon_vtcm");
> +
> +        assert(sizeof(m_cfg->cfgtable.vtcm_base) == sizeof(uint32_t));
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/vtcm", "reg", 0,
> +                               m_cfg->cfgtable.vtcm_base << 16,
> +                               vtcm_size_bytes);
> +    }
> +
> +    if (m_cfg->cfgtable.ext_contexts > 0) {
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/hvx");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/hvx", "compatible",
> +                                "qcom,hexagon-hvx");
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-max-ctxts",
> +                               m_cfg->cfgtable.ext_contexts);
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
> +                               m_cfg->cfgtable.hvx_vec_log_length);
> +    }
> +}
> +
> +static int32_t irq_hvm_ic_phandle = -1;

Maybe better to pass these handles as pointer argument?

> +static void fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,
> +                                 const struct hexagon_machine_config *m_cfg)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    irq_hvm_ic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "interrupt-parent",
> +                          irq_hvm_ic_phandle);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc/interrupt-controller");
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#address-cells", 2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#interrupt-cells", 2);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc/interrupt-controller", "compatible",
> +                            "qcom,h2-pic,hvm-pic");
> +    qemu_fdt_setprop(ms->fdt, "/soc/interrupt-controller",
> +                     "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller", "phandle",
> +                          irq_hvm_ic_phandle);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->l2vic), 1,
> +                    m_cfg->cfgtable.fastl2vic_base << 16);
> +}
> +
> +
> +static void fdt_add_gpt_node(HexagonVirtMachineState *vms)
> +{
> +    g_autofree char *name = NULL;
> +    MachineState *ms = MACHINE(vms);
> +
> +    name = g_strdup_printf("/soc/gpt@%" PRIx64,
> +                           (int64_t)base_memmap[VIRT_GPT].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +                            "qcom,h2-timer,hvm-timer");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqmap[VIRT_GPT], 0);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0,
> +                           base_memmap[VIRT_GPT].base,
> +                           base_memmap[VIRT_GPT].size);
> +}
> +
> +static int32_t clock_phandle = -1;

(ditto)

> +static void fdt_add_clocks(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    clock_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    qemu_fdt_add_subnode(ms->fdt, "/apb-pclk");
> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "compatible", "fixed-clock");
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "#clock-cells", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "clock-frequency", 24000000);
> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "clock-output-names",
> +                            "clk24mhz");
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "phandle", clock_phandle);
> +}
> +
> +static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart)
> +{
> +    char *nodename;
> +    hwaddr base = base_memmap[uart].base;
> +    hwaddr size = base_memmap[uart].size;
> +    assert(uart == 0);
> +    int irq = irqmap[VIRT_UART0 + uart];
> +    const char compat[] = "arm,pl011\0arm,primecell";
> +    const char clocknames[] = "uartclk\0apb_pclk";
> +    MachineState *ms = MACHINE(vms);
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev = qdev_new(TYPE_PL011);
> +    s = SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    qdev_connect_clock_in(dev, "clk", vms->apb_clk);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, base);
> +    if (vms->l2vic) {
> +        sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->l2vic, irq));
> +    }
> +
> +    nodename = g_strdup_printf("/pl011@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +
> +    /* Note that we can't use setprop_string because of the embedded NUL */
> +    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, size);
> +    if (vms->l2vic) {
> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> +                               32 + irq, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                              irq_hvm_ic_phandle);
> +    }
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks", clock_phandle,
> +                           clock_phandle);
> +    qemu_fdt_setprop(ms->fdt, nodename, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
> +
> +    g_free(nodename);
> +}
> +
> +static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
> +
> +    /* cpu nodes */
> +    for (int num = ms->smp.cpus - 1; num >= 0; num--) {
> +        char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
> +                              qemu_fdt_alloc_phandle(ms->fdt));
> +        g_free(nodename);
> +    }
> +}
> +
> +
> +static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    /* VirtIO MMIO devices */
> +    for (int i = 0; i < VIRTIO_DEV_COUNT; i++) {
> +        char *nodename;
> +        int irq = irqmap[VIRT_MMIO] + i;
> +        size_t size = base_memmap[VIRT_MMIO].size;
> +        hwaddr base = base_memmap[VIRT_MMIO].base + i * size;
> +
> +        nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "virtio,mmio");
> +        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 1,
> +                                     size);
> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                              irq_hvm_ic_phandle);
> +
> +        sysbus_create_simple(
> +            "virtio-mmio", base,
> +            qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_MMIO] + i));
> +
> +        g_free(nodename);
> +    }
> +}
> +
> +static void virt_instance_init(Object *obj)
> +{
> +    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
> +
> +    create_fdt(vms);
> +}
> +
> +void hexagon_load_fdt(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    hwaddr fdt_addr = base_memmap[VIRT_FDT].base;
> +    uint32_t fdtsize = vms->fdt_size;
> +
> +    g_assert(fdtsize <= base_memmap[VIRT_FDT].size);
> +    /* copy in the device tree */
> +    rom_add_blob_fixed_as("fdt", ms->fdt, fdtsize, fdt_addr,
> +                          &address_space_memory);
> +    qemu_register_reset_nosnapshotload(
> +        qemu_fdt_randomize_seeds,
> +        rom_ptr_for_as(&address_space_memory, fdt_addr, fdtsize));
> +}
> +
> +static uint64_t load_kernel(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    uint64_t entry = 0;
> +    if (load_elf_ram_sym(ms->kernel_filename, NULL, NULL, NULL, &entry, NULL,
> +                         NULL, NULL, 0, EM_HEXAGON, 0, 0, &address_space_memory,
> +                         false, NULL) > 0) {
> +        return entry;
> +    }
> +    error_report("error loading '%s'", ms->kernel_filename);
> +    exit(1);
> +}
> +
> +static uint64_t load_bios(HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    uint64_t bios_addr = 0x0;  /* Load BIOS at reset vector address 0x0 */
> +    int bios_size;
> +
> +    bios_size = load_image_targphys(ms->firmware ?: "",
> +                                    bios_addr, 64 * 1024, NULL);
> +    if (bios_size < 0) {
> +        error_report("Could not load BIOS '%s'", ms->firmware ?: "");
> +        exit(1);
> +    }
> +
> +    return bios_addr;  /* Return entry point at address 0x0 */
> +}
> +
> +static void do_cpu_reset(void *opaque)
> +{
> +    HexagonCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +    cpu_reset(cs);
> +}
> +
> +static void virt_init(MachineState *ms)
> +{
> +    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(ms);
> +    const struct hexagon_machine_config *m_cfg = &v68n_1024;
> +    const char *cpu_model;
> +    DeviceState *gsregs_dev;
> +    DeviceState *tlb_dev;
> +    HexagonCPU *cpu_0;

Maybe directly to only use a single cast:

        DeviceState *cpu0;

> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
> +
> +    vms->sys = get_system_memory();
> +
> +    /* Create APB clock for peripherals */
> +    vms->apb_clk = clock_new(OBJECT(ms), "apb-pclk");
> +    clock_set_hz(vms->apb_clk, 24000000);
> +
> +    memory_region_init_ram(&vms->ram, NULL, "ddr.ram", ms->ram_size,
> +                           &error_fatal);
> +    memory_region_add_subregion(vms->sys, 0x0, &vms->ram);
> +
> +    if (m_cfg->l2tcm_size) {
> +        memory_region_init_ram(&vms->tcm, NULL, "tcm.ram", m_cfg->l2tcm_size,
> +                               &error_fatal);
> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.l2tcm_base << 16,
> +                                    &vms->tcm);
> +    }
> +
> +    memory_region_init_rom(&vms->cfgtable, NULL, "config_table.rom",
> +                           sizeof(m_cfg->cfgtable), &error_fatal);
> +    memory_region_add_subregion(vms->sys, m_cfg->cfgbase, &vms->cfgtable);
> +    fdt_add_hvx(vms, m_cfg, &error_fatal);
> +    cpu_model = ms->cpu_type;
> +
> +    if (!cpu_model) {
> +        cpu_model = HEXAGON_CPU_TYPE_NAME("v68");

Can that happen? There is a default defined...

> +    }
> +
> +    gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
> +    object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
> +    qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
> +    qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
> +
> +    tlb_dev = qdev_new(TYPE_HEXAGON_TLB);

Where is hw/hexagon/hexagon_tlb.h?

> +    object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
> +    qdev_prop_set_uint32(tlb_dev, "num-entries",
> +                         m_cfg->cfgtable.jtlb_size_entries);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
> +
> +    cpu_0 = NULL;
> +    for (int i = 0; i < ms->smp.cpus; i++) {

I suppose they belong to a cluster. In the future we'd create
them within a TYPE_CPU_CLUSTER.

> +        HexagonCPU *cpu = HEXAGON_CPU(object_new(ms->cpu_type));
> +        qemu_register_reset(do_cpu_reset, cpu);
> +
> +        if (i == 0) {
> +            cpu_0 = cpu;
> +            if (ms->kernel_filename) {
> +                uint64_t entry = load_kernel(vms);
> +                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr", entry);
> +            } else if (ms->firmware) {
> +                uint64_t entry = load_bios(vms);
> +                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr", entry);
> +            }
> +        }
> +        qdev_prop_set_uint32(DEVICE(cpu), "htid", i);
> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
> +        object_property_set_link(OBJECT(cpu), "global-regs",
> +                                 OBJECT(gsregs_dev), &error_fatal);
> +        object_property_set_link(OBJECT(cpu), "tlb",
> +                                 OBJECT(tlb_dev), &error_fatal);
> +
> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal)) {
> +            return;
> +        }
> +    }
> +    /* TODO: enable l2vic when l2vic device arrives */
> +    if (object_class_by_name("l2vic")) {
> +        vms->l2vic = sysbus_create_varargs(
> +            "l2vic", m_cfg->l2vic_base,
> +            qdev_get_gpio_in(DEVICE(cpu_0), 0),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 1),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 2),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 3),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 4),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 5),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 6),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 7), NULL);
> +
> +        fdt_add_hvm_pic_node(vms, m_cfg);
> +        fdt_add_virtio_devices(vms);
> +        fdt_add_gpt_node(vms);
> +    }
> +
> +    fdt_add_cpu_nodes(vms);
> +    fdt_add_clocks(vms);
> +    fdt_add_uart(vms, VIRT_UART0);
> +
> +    rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
> +                          sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
> +                          &address_space_memory);
> +
> +
> +    hexagon_load_fdt(vms);
> +}
> +
> +
> +static void virt_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "Hexagon Virtual Machine";
> +    mc->init = virt_init;
> +    mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v68");

(this is the default CPU type)

> +    mc->default_ram_size = 4 * GiB;
> +    mc->max_cpus = 8;
> +    mc->default_cpus = 8;
> +    mc->is_default = false;
> +    mc->default_kernel_irqchip_split = false;
> +    mc->block_default_type = IF_VIRTIO;
> +    mc->default_boot_order = NULL;
> +    mc->no_cdrom = 1;
> +    mc->numa_mem_supported = false;
> +    mc->default_nic = "virtio-mmio-bus";
> +}
> +
> +
> +static const TypeInfo virt_machine_types[] = { {
> +    .name = TYPE_HEXAGON_VIRT_MACHINE,
> +    .parent = TYPE_MACHINE,
> +    .instance_size = sizeof(HexagonVirtMachineState),
> +    .class_init = virt_class_init,
> +    .instance_init = virt_instance_init,
> +} };
> +
> +DEFINE_TYPES(virt_machine_types)
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 355abb4fd24..01781a76caf 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -68,6 +68,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>   
>   static const Property hexagon_cpu_properties[] = {
>   #if !defined(CONFIG_USER_ONLY)
> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
> +                     HexagonTLBState *),
>       DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
>       DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>           TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> index cdf7770a305..52065ab3b22 100644
> --- a/hw/hexagon/Kconfig
> +++ b/hw/hexagon/Kconfig
> @@ -2,3 +2,13 @@ config HEX_DSP
>       bool
>       default y
>       depends on HEXAGON
> +
> +config HEX_VIRT
> +    bool
> +    default y
> +    depends on HEX_DSP && FDT
> +    select DEVICE_TREE
> +    select VIRTIO_MMIO
> +    select PL011
> +    select VIRTIO_BLK
> +    select VIRTIO_SCSI
> diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
> index f528d2bc4ab..5b6a5e11a17 100644
> --- a/hw/hexagon/meson.build
> +++ b/hw/hexagon/meson.build
> @@ -4,3 +4,5 @@ hexagon_ss.add(files('hexagon_globalreg.c'))
>   hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c'))
>   
>   hw_arch += {'hexagon': hexagon_ss}
> +
> +hexagon_ss.add(when: 'CONFIG_HEX_VIRT', if_true: files('virt.c'))
> diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
> index c357e6ebf50..86bcdf7cfad 100644
> --- a/tests/qemu-iotests/testenv.py
> +++ b/tests/qemu-iotests/testenv.py
> @@ -259,6 +259,7 @@ def __init__(self, source_dir: str, build_dir: str,
>               ('arm', 'virt'),
>               ('aarch64', 'virt'),
>               ('avr', 'mega2560'),
> +            ('hexagon', 'virt'),
>               ('m68k', 'virt'),
>               ('or1k', 'virt'),
>               ('riscv32', 'virt'),



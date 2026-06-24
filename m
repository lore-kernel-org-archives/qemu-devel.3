Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5768ACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQgs-0002Zp-1I; Wed, 24 Jun 2026 12:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcQgq-0002ZQ-Ci
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:43:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcQgo-0002fb-84
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:43:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfLtO3301062
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 08xMVtcPU9aNDwBr/6YtUFxpftYU+nnvK8OHIg9s0mk=; b=fui+YcFtBcrRvaZ9
 SKYSbDMAFp/cM0zcwevjsWu89TN3LVkwZGTOoXvgp9KqwNR/4vLE25P71GHMaeLO
 c1j+6K5pohkvx9QolAF0HMoYgw2NjB7DNJqRGLpeRT0Z220cJ7YLFAxZUH5FpvLH
 2xNiIyeYxdvp2SR6bmquxUttZVf3ssqUR3oC5SiqZXkwN5xFUpCcsr6IWe+XwQCy
 MoUT5pPQLh0xecRW1HKBuuNroWPU2k7xFPZLyDjYI8O/A6/5hhnueMgbYmWZNlph
 Z0K04tcYdlzqFgh8H6f97r6MkOb3EAEqLEZ95sKEEWgd0o83M2nUM71g3cYh1/Tc
 8VVlJg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aqb9yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:42:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c17f62afdso44069eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782319379; x=1782924179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08xMVtcPU9aNDwBr/6YtUFxpftYU+nnvK8OHIg9s0mk=;
 b=MOQivOJ0Wf/ELQ4YeotUHGmvHWNmDbYCvXQtoyWEp/66Bhve/IH8Rx4RoVhjki02IF
 4TGtXP56adtdcuRjlzic35iJ6qHumY4oOSjahjjP3aoRgqHkx0X6k7BdfeNWdYMKdLJC
 +JW/IN5mhFuHPR91etDoSf3hFckAsgtcLt8bwp5i3BxPrz5wR9LCsan7GOZbGN02JNkj
 vQbwtzkZWkLE7OQEYj/rvHLJRwze92haf/27PDOWPZ3/5dcB9FcsJdoHJlsYWFCMUsO8
 9p29ADsIYYqvKOPmbtAgG6UsOOq//KLAXdHYVmnZ8dFe9D9bUQY/ltvaZc7RhKt9AR9O
 WbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782319379; x=1782924179;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08xMVtcPU9aNDwBr/6YtUFxpftYU+nnvK8OHIg9s0mk=;
 b=BUnPjUnXJ1uizrVmklkSlsdkvSCnT/Vd7BdWjGZfRbnrdHze09TK8kleBaY0dcLKKq
 4cN23f4wnqYMdmSExfy1tluY9taiL4djpTcFNDoOSYPZRA4PSKSWEf0FZikkAKPUuoFA
 NOkOhq5ZM+jMxr/K5N4mTqlrVtnzvwxPg+dn0k8VsiM5B7MLyLZgxacBi5mBRc89Xv1v
 2xN1SfIZwt7vH+VIy7wMj2xbKJcya8bzwSb12sYGzfy7x/9ar9VsHPh9lRXt/GZqmy4F
 OjagnzwPf09MNnMC/d8+Vs1YqsXry/fehfEZ2/Yg+9J6ZYQzoM9dCChHwiOKE+qRZLY6
 0mwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHF8JFh5OSgowfxxwlPBpB95vmhBjNOotCEXEqBrdhU2IxpipIOu2Gbr+BGcg8UiiDEu9PWYEQEBw3@nongnu.org
X-Gm-Message-State: AOJu0YzIe6SJ/CYr+WleTDYTCkSKUX1PL4DQXO/XwZgTKZKx8+iqq1FA
 pwRk8h7dRDRZhzyvOjB6wf/xGCagYhMfX1Sq8PRyJ2bRUww0fx6ropesMvfpizmoUAJYnCMjLyO
 zK1gc2JIMHVew5VDvssjnBhHYhCRaag61BVpeUSjJYTfKcJjWjvKLstyK8A==
X-Gm-Gg: AfdE7cnQDNJSuyE2WtRipKWzVnDPhwLJr1ds1QjmSUbqdcCigFaDn7ZQG0DP9iyUreM
 585TNjwIxqHY+mSGAv2kMQLDo1W3NV1uEgWteb6cu21zOAot/0C6XW9vRG8r88T7G+EfBTQjV5n
 pS6whTaufVeVuk0gsemLt6EaFNIy7exQZF8WLs5lXOBbL2X7/FQNHdpvLf0f7v9ujLqybbio/rH
 FcraYW7vuJfngIEO/y3pFMN/MQO7c7Ci3E9zxGUhN1lxLxF2d8yNWXdPIjxG0/RLQM8Qlv37VK3
 husPypJimOJvfialk8NQbHY9BNMdz/eZBn8lNO1VRx4Xd3F6w9gQ3LCiKg0/C6UK89/QmxoqZZJ
 zLY5rYv5Znjqov1vih6xy2hzp+dGMLnJekap/xy13z3Ha
X-Received: by 2002:a05:7301:7106:b0:2f4:d190:37bf with SMTP id
 5a478bee46e88-30c5563f2e8mr4507537eec.16.1782319378827; 
 Wed, 24 Jun 2026 09:42:58 -0700 (PDT)
X-Received: by 2002:a05:7301:7106:b0:2f4:d190:37bf with SMTP id
 5a478bee46e88-30c5563f2e8mr4507498eec.16.1782319378075; 
 Wed, 24 Jun 2026 09:42:58 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm400755eec.16.2026.06.24.09.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:42:57 -0700 (PDT)
Message-ID: <9279723a-b079-4749-b3a5-e6e7ecfd2121@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 13:42:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
To: Chen Pei <cp0613@linux.alibaba.com>, jic23@kernel.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, dave.jiang@intel.com,
 alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com,
 guoren@kernel.org
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-2-cp0613@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618093827.3507-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MCBTYWx0ZWRfXzfdYlVg5H5lC
 sDxgho8C5Q2FcFUHM9+Taw/5D2IYwZCyCq/EGWpEQGavlQHMT5fEDLaMeZPKWJFZiguzpRv8GWQ
 aghtNwfqIcmq41XOcCwB4XZQ+l+FHCk=
X-Proofpoint-GUID: w2uElITmQXWm2fR-Dt_acSV1h-ljzZ2o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MCBTYWx0ZWRfX4x9C3K3Fw86U
 T6difVidffEoWZd/L4Lz/pKTQYH8UF1vqto1XORCqcXHSwkwaB/NNK2I4hYIlMGXqeNUIWFXDSf
 lkTfplEaQBSu+DEe0g9ZZ7LwdjCRfoqtPwsEHvaAXdecq+wVFmArRhlCICRJBFoufxVeV1HwAb+
 8WZ/eN0/lHFLLoEHVUfoZM0RxvGydJGiYA1O3xq2b4n/D1VjHTtT/wlrKMJrjyzGyfKnytCT5L8
 zwA3v7x1875ez81aKYS5uTkBoCKXVeHlCv+xhhRSSAwwZj6AzN0MNdkzDCkWnRbByNLC/TZeZMv
 oSvvGqCYgdU3T3JwxU/h10llnU35ATULyqPPlwrs3WVFEyvBbGV06hL+pWCFb+vb8YZ7WzmqWIP
 882BnLFG//PLlOwYBguld8sdp9xrpw==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3c0913 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=SRrdq9N9AAAA:8 a=OKAgqmDqJgUB0MQQqyQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: w2uElITmQXWm2fR-Dt_acSV1h-ljzZ2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 6/18/2026 6:38 AM, Chen Pei wrote:
> Enable CXL support on the RISC-V virt machine following the same
> approach used by the ARM virt machine:
> - Add PXB and ACPI_CXL Kconfig selections
> - Add CXLState and PCIBus pointer to RISCVVirtState
> - Register CXL machine properties via cxl_machine_init()
> - Create CXL host register region above the PCIe high MMIO region
> - Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
>    machine_done time
> - Map Fixed Memory Windows above the CXL host register region
> - Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   hw/riscv/Kconfig           |  2 ++
>   hw/riscv/virt-acpi-build.c | 20 +++++++++++++++++++
>   hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h    |  3 +++
>   4 files changed, 65 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2518b04175..ebd0355f09 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -66,8 +66,10 @@ config RISCV_VIRT
>       select VIRTIO_MMIO
>       select FW_CFG_DMA
>       select PLATFORM_BUS
> +    select PXB
>       select ACPI
>       select ACPI_PCI
> +    select ACPI_CXL
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70e..309d64b322 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -29,12 +29,16 @@
>   #include "hw/acpi/aml-build.h"
>   #include "hw/acpi/pci.h"
>   #include "hw/acpi/utils.h"
> +#include "hw/acpi/cxl.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/nvram/fw_cfg_acpi.h"
>   #include "hw/pci-host/gpex.h"
> +#include "hw/pci/pci_bus.h"
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/numa.h"
>   #include "hw/virtio/virtio-acpi.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>   #include "kvm/kvm_riscv.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> @@ -503,6 +507,17 @@ static void build_dsdt(GArray *table_data,
>           acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
>       }
>   
> +    if (s->cxl_devices_state.is_enabled) {
> +        Aml *cxl_dev = aml_device("CXLM");
> +        aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +        Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0B)));
> +        aml_append(cxl_dev, method);
> +        build_cxl_dsm_method(cxl_dev);
> +
> +        aml_append(scope, cxl_dev);
> +    }
> +
>       aml_append(dsdt, scope);
>   
>       /* copy AML table into ACPI tables blob and patch header there */
> @@ -910,6 +925,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>                      s->oem_table_id);
>       }
>   
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
> +                       s->oem_id, s->oem_table_id, &s->cxl_devices_state);
> +    }
> +
>       if (ms->numa_state->num_nodes > 0) {
>           acpi_add_table(table_offsets, tables_blob);
>           build_srat(tables_blob, tables->linker, s);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7..84b91b4322 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,8 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
> @@ -1259,9 +1261,27 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>       }
>   
>       GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
> +    s->pci_bus = PCI_HOST_BRIDGE(dev)->bus;
>       return dev;
>   }
>   
> +static void create_cxl_host_reg_region(RISCVVirtState *s)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &s->cxl_devices_state.host_mr;
> +    hwaddr base;
> +
> +    if (!s->cxl_devices_state.is_enabled) {
> +        return;
> +    }
> +
> +    base = virt_high_pcie_memmap.base + virt_high_pcie_memmap.size;
> +    base = ROUND_UP(base, 64 * KiB);
> +
> +    memory_region_init(mr, OBJECT(s), "cxl_host_reg", 64 * KiB * 16);
> +    memory_region_add_subregion(sysmem, base, mr);
> +}
> +
>   static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>   {
>       FWCfgState *fw_cfg;
> @@ -1426,6 +1446,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
>                                        machine_done);
>       MachineState *machine = MACHINE(s);
>       hwaddr start_addr = s->memmap[VIRT_DRAM].base;
> +
> +    cxl_hook_up_pxb_registers(s->pci_bus, &s->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
>       hwaddr firmware_end_addr;
>       vaddr kernel_start_addr;
>       const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
> @@ -1663,6 +1690,17 @@ static void virt_machine_init(MachineState *machine)
>               ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
>       }
>   
> +    create_cxl_host_reg_region(s);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        hwaddr cxl_base = virt_high_pcie_memmap.base +
> +                          virt_high_pcie_memmap.size;
> +        cxl_base += memory_region_size(&s->cxl_devices_state.host_mr);
> +        cxl_base = ROUND_UP(cxl_base, 256 * MiB);
> +        cxl_fmws_set_memmap(cxl_base, UINT64_MAX);
> +        cxl_fmws_update_mmio();
> +    }
> +

create_cxl_host_reg_region() is doing the same check:

if (!s->cxl_devices_state.is_enabled) {
(...)

Maybe we could squash these update_mmio() lines in the same helper to have
everything CXL related in the same place.  The helper would need to be
renamed to something more appropriate (e.g. cxl_host_state_init() since we're
at init time).


Patch LGTM otherwise. Thanks,
Daniel

>       /* register system main memory (actual RAM) */
>       memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
>                                   machine->ram);
> @@ -1769,6 +1807,8 @@ static void virt_machine_instance_init(Object *obj)
>       s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
> +
> +    cxl_machine_init(obj, &s->cxl_devices_state);
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a3..7d559ac610 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -24,6 +24,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/block/flash.h"
>   #include "hw/intc/riscv_imsic.h"
> +#include "hw/cxl/cxl.h"
>   
>   #define VIRT_CPUS_MAX_BITS             9
>   #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -64,6 +65,8 @@ struct RISCVVirtState {
>       struct GPEXHost *gpex_host;
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
> +    CXLState cxl_devices_state;
> +    PCIBus *pci_bus;
>   };
>   
>   enum {



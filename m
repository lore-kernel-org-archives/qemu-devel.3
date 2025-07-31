Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00ACC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOnl-0000Fj-FF; Thu, 31 Jul 2025 04:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOnh-00008w-B2
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:38:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOnf-0001GG-8K
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:38:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78315ff04so128462f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753951085; x=1754555885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QZouWCq7sM5ReNYJGnXKYGBgi6nDBmqzwiiUsottSk4=;
 b=aEeudZlP3m5TXbXV+5DfvFbE5f+4sa2RgyKB9SF/NFDevb0JNtju1FFl5Jz/o/ighG
 CE/9UZAXfpx2ejSJ8017YxMCDWEVw0pyBd+GVEOQzLtlUHxbTdqoRwDI9rWXDrMmU3e1
 XtN3vPKtcpt1e6FrEZKJZBm/SS/N+ca5zVgrx0e3GOndrkAoIi7lHOcDq2DcaOGUXMxs
 7uB6StYPCLvpAvy2bsyxVQPfUN1Xqsnemz93TMQRhEXmC0q/R8xFHM7kRr6+nAe3TWAq
 8yM+AMLeDiyhOK6rBNqZD6wUZkQeGGDHoOz5TIEcStcC8uLY22sgTDpv1s+LEKEa1S1p
 +85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753951085; x=1754555885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZouWCq7sM5ReNYJGnXKYGBgi6nDBmqzwiiUsottSk4=;
 b=kqPVapd6+mANO5W6lbJL5TFJVtQh5fgQCuNfIyCg5hlEf6tAiwjsiPXayz6TAICspN
 UAbWbKViiAYklV20kmHyQyb0c0SWUCtQUeUwNg79613GDeQklUcAW0d0rJYt6M9ro2Ju
 dhbKSr5q3/GoI7QQB5DFZpaRouiOLCfhDT2WgSvX5kBvZJvbc7lNGNQ4l8x73vI4BKbC
 KXbpeQxeFc2uz8QnrX+a5lUQ4KTto01mS7K9FTf5ucSc5kFIxdZI7ayN+YK3iM0dfRVw
 JWjpIuQyzOxevJ4je6n9y3HrQOSrBRMehLzkg3fNqL1CfnTwOhEUe21JeJ0M6Jzn2tvY
 ciuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGrqG3vWU7/7eKXi+Fr3YvmlxHiW7hlYUuynd6yORQ+beDZEWTujJ5fjuFSnthUuiloTq2MsWxjrHH@nongnu.org
X-Gm-Message-State: AOJu0YyR/peHvEXmwMjs6jHITnRB0VYQroVR9JJiFpWfc5iseeph9amt
 jaq8v/NvRKZhikYs5a3H+5s6pNaicxlQZgDXGvOFwsgY7uJ0NiPxvo3E8EJxkMRH+zE=
X-Gm-Gg: ASbGnct6q132XMt8zub/YNMYBLJrTtXn5XPrupCGgItcr2ZsLMP1zX0yulgRWKJisoB
 EHlO0iZLRTWbScUesliCAJ4HOg09c1j7dnIYYm9RaeKSbxpAyuqdyYSeYJiaBnkZ186Y6IuIboN
 5hX5zOAMnKLnXCPe/1nc84BxyY5Sa60XeEny4byY7ELkwAtSC3lViyo+kWTBwWEOjfptnwtlrBt
 WzubiQjU9K3mfC/o8DTa+dCOiXT8lbeO8C1Q/7ARMu8pAqoHLQuzNqO/a40eNWgpcfoHkPfF35B
 mB6kWsv+hBBedcuAWSGYylamjKRIj+/m/kYpXa4Bm2cJeTkyb8eWuRrdiBPfcbe1M1ll3+pD31P
 IPAv0Y/qp3D0sjepGOp0xnOh36+T87B0nGdiCJ4uAAOUKWxnRJsAnD76KJ+68FyYgLw==
X-Google-Smtp-Source: AGHT+IGEc8ookV2byj6Cx4+GSYkckIs95s9xXwz4b+Bt7VjKqbGPooeG/lq7i8brfycBeFXPCn1c4g==
X-Received: by 2002:a05:6000:4203:b0:3b7:9dde:2a4 with SMTP id
 ffacd0b85a97d-3b79dde06a8mr997853f8f.55.1753951085128; 
 Thu, 31 Jul 2025 01:38:05 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458981d0b06sm57535905e9.5.2025.07.31.01.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 01:38:04 -0700 (PDT)
Message-ID: <6dcd45eb-8189-4492-ba05-d36c743ee7b2@linaro.org>
Date: Thu, 31 Jul 2025 10:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Manos,

On 30/7/25 14:21, Manos Pitsidianakis wrote:
> NVDIMM is used for fast rootfs with EROFS, for example by kata
> containers. To allow booting with static NVDIMM memory, add them to the
> device tree in arm virt machine.
> 
> This allows users to boot directly with nvdimm memory devices without
> having to rely on ACPI and hotplug.
> 
> Verified to work with command invocation:
> 
> ./qemu-system-aarch64 \
>    -M virt,nvdimm=on \
>    -cpu cortex-a57 \
>    -m 4G,slots=2,maxmem=8G \
>    -object memory-backend-file,id=mem1,share=on,mem-path=/tmp/nvdimm,size=4G,readonly=off \
>    -device nvdimm,id=nvdimm1,memdev=mem1,unarmed=off \
>    -drive file=./debian-12-nocloud-arm64-commited.qcow2,format=qcow2 \
>    -kernel ./vmlinuz-6.1.0-13-arm64 \
>    -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=off"
>    -initrd ./initrd.img-6.1.0-13-arm64 \
>    -nographic \
>    -serial mon:stdio

Should we add a functional test covering this non-ACPI case?

> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/arm/boot.c | 39 +++++++++++++++++++++++++++++++++++++++
>   hw/arm/virt.c |  8 +++++---
>   2 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d391cd01bb1b92ff213e69b84e5a69413b36c4f8..a0c1bcdf946ca98bb5da63f1a518018eb578dd81 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -25,6 +25,7 @@
>   #include "hw/boards.h"
>   #include "system/reset.h"
>   #include "hw/loader.h"
> +#include "hw/mem/memory-device.h"
>   #include "elf.h"
>   #include "system/device_tree.h"
>   #include "qemu/config-file.h"
> @@ -515,6 +516,26 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
>       qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>   }
>   
> +static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells,
> +                             int64_t mem_base, int64_t size, int64_t node)
> +{
> +    int ret;
> +
> +    g_autofree char *nodename = g_strdup_printf("/pmem@%" PRIx64, mem_base);
> +
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
> +    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells,
> +                                       mem_base, scells, size);
> +    /* only set the NUMA ID if it is specified */
> +    if (!ret && node >= 0) {
> +        ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
> +                                    node);
> +    }
> +
> +    return ret;
> +}
> +
>   int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                    hwaddr addr_limit, AddressSpace *as, MachineState *ms,
>                    ARMCPU *cpu)
> @@ -525,6 +546,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>       unsigned int i;
>       hwaddr mem_base, mem_len;
>       char **node_path;
> +    g_autofree MemoryDeviceInfoList *md_list = NULL;
>       Error *err = NULL;
>   
>       if (binfo->dtb_filename) {
> @@ -628,6 +650,23 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>           }
>       }
>   
> +    md_list = qmp_memory_device_list();
> +    for (MemoryDeviceInfoList *m = md_list; m != NULL; m = m->next) {
> +        MemoryDeviceInfo *mi = m->value;
> +
> +        if (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> +            PCDIMMDeviceInfo *di = mi->u.nvdimm.data;
> +
> +            rc = fdt_add_pmem_node(fdt, acells, scells,
> +                                   di->addr, di->size, di->node);
> +            if (rc < 0) {
> +                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx64" node\n",
> +                        di->addr);
> +                goto fail;
> +            }
> +        }
> +    }
> +
>       rc = fdt_path_offset(fdt, "/chosen");
>       if (rc < 0) {
>           qemu_fdt_add_subnode(fdt, "/chosen");
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef6be3660f5fb38da84235c32dc2d13a5c61889c..910f5bb5f66ee217a9140f9128804a5b9f69b5b6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2917,7 +2917,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       const MachineState *ms = MACHINE(hotplug_dev);
>       const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>   
> -    if (!vms->acpi_dev) {
> +    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
>           error_setg(errp,
>                      "memory hotplug is not enabled: missing acpi-ged device");
>           return;
> @@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>           nvdimm_plug(ms->nvdimms_state);
>       }
>   
> -    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> -                         dev, &error_abort);
> +    if (vms->acpi_dev) {
> +        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> +                             dev, &error_abort);
> +    }
>   }
>   
>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> 
> ---
> base-commit: 9b80226ece693197af8a981b424391b68b5bc38e
> change-id: 20250730-nvdimm_arm64_virt-931a764bbe0c
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 



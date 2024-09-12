Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E9FEDE996
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 03:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soaTM-00049n-4x; Wed, 11 Sep 2024 23:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soaTJ-00048d-Jb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 23:26:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soaTF-0008NT-1b
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 23:26:17 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxtuhIX+JmgWwFAA--.11587S3;
 Thu, 12 Sep 2024 11:26:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMAxa8ZFX+JmJkgFAA--.24414S3;
 Thu, 12 Sep 2024 11:25:59 +0800 (CST)
Subject: Re: [RFC PATCH V2 3/5] hw/loongarch: Add KVM extioi device support
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1725969898.git.lixianglai@loongson.cn>
 <f359346bb865fcc4d52552c8c0fc27123c858aad.1725969898.git.lixianglai@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <9abdad1a-4a23-00b6-f3ef-51ba4ea6bebb@loongson.cn>
Date: Thu, 12 Sep 2024 11:25:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f359346bb865fcc4d52552c8c0fc27123c858aad.1725969898.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMAxa8ZFX+JmJkgFAA--.24414S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Cw18ArW3Kr18AF15ZrWUGFX_yoW8GFWxuo
 WUJFsFvr4rJr97ZrZ5JwsrtF43tr409FW5AFW7Zw43uF47tFW5Ja1DK3WFkryxWFs8KryD
 GasIgFs7Ja42yw1rl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25Ef
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.499,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2024/9/10 下午8:18, Xianglai Li wrote:
> Added extioi interrupt controller for kvm emulation.
> The main process is to send the command word for
> creating an extioi device to the kernel.
> When the VM is saved, the ioctl obtains the related
> data of the extioi interrupt controller in the kernel
> and saves it. When the VM is recovered, the saved data
> is sent to the kernel.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   hw/intc/Kconfig                |   3 +
>   hw/intc/loongarch_extioi_kvm.c | 250 +++++++++++++++++++++++++++++++++
>   hw/intc/meson.build            |   1 +
>   hw/loongarch/Kconfig           |   1 +
>   hw/loongarch/virt.c            |  51 ++++---
>   5 files changed, 285 insertions(+), 21 deletions(-)
>   create mode 100644 hw/intc/loongarch_extioi_kvm.c
> 
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 5201505f23..df9352d41d 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -112,3 +112,6 @@ config LOONGARCH_PCH_MSI
>   
>   config LOONGARCH_EXTIOI
>       bool
> +
> +config LOONGARCH_EXTIOI_KVM
> +    bool
> diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
> new file mode 100644
> index 0000000000..139a00ac2a
> --- /dev/null
> +++ b/hw/intc/loongarch_extioi_kvm.c
> @@ -0,0 +1,250 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * LoongArch kvm extioi interrupt support
> + *
> + * Copyright (C) 2024 Loongson Technology Corporation Limited
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/typedefs.h"
> +#include "hw/intc/loongarch_extioi.h"
> +#include "hw/sysbus.h"
> +#include "linux/kvm.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "sysemu/kvm.h"
> +
> +static void kvm_extioi_access_regs(int fd, uint64_t addr,
> +                                       void *val, bool is_write)
> +{
> +        kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_REGS,
> +                          addr, val, is_write, &error_abort);
> +}
> +
> +static void kvm_extioi_access_sw_status(int fd, uint64_t addr,
> +                                       void *val, bool is_write)
> +{
> +        kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_SW_STATUS,
> +                          addr, val, is_write, &error_abort);
> +}
> +
> +static void kvm_extioi_save_load_sw_status(void *opaque, bool is_write)
> +{
> +    KVMLoongArchExtIOI *s = (KVMLoongArchExtIOI *)opaque;
> +    KVMLoongArchExtIOIClass *class = KVM_LOONGARCH_EXTIOI_GET_CLASS(s);
> +    int fd = class->dev_fd;
> +    int addr;
> +
> +    addr = KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_NUM_CPU;
> +    kvm_extioi_access_sw_status(fd, addr, (void *)&s->num_cpu, is_write);
> +
> +    addr = KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_FEATURE;
> +    kvm_extioi_access_sw_status(fd, addr, (void *)&s->features, is_write);
> +
> +    addr = KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE;
> +    kvm_extioi_access_sw_status(fd, addr, (void *)&s->status, is_write);
> +}
> +
> +static void kvm_extioi_save_load_regs(void *opaque, bool is_write)
> +{
> +    KVMLoongArchExtIOI *s = (KVMLoongArchExtIOI *)opaque;
> +    KVMLoongArchExtIOIClass *class = KVM_LOONGARCH_EXTIOI_GET_CLASS(s);
> +    int fd = class->dev_fd;
> +    int addr, offset, cpuid;
> +
> +    for (addr = EXTIOI_NODETYPE_START; addr < EXTIOI_NODETYPE_END; addr += 4) {
> +        offset = (addr - EXTIOI_NODETYPE_START) / 4;
> +        kvm_extioi_access_regs(fd, addr,
> +                               (void *)&s->nodetype[offset], is_write);
> +    }
> +
> +    for (addr = EXTIOI_IPMAP_START; addr < EXTIOI_IPMAP_END; addr += 4) {
> +        offset = (addr - EXTIOI_IPMAP_START) / 4;
> +        kvm_extioi_access_regs(fd, addr, (void *)&s->ipmap[offset], is_write);
> +    }
> +
> +    for (addr = EXTIOI_ENABLE_START; addr < EXTIOI_ENABLE_END; addr += 4) {
> +        offset = (addr - EXTIOI_ENABLE_START) / 4;
> +        kvm_extioi_access_regs(fd, addr,
> +                               (void *)&s->enable[offset], is_write);
> +    }
> +
> +    for (addr = EXTIOI_BOUNCE_START; addr < EXTIOI_BOUNCE_END; addr += 4) {
> +        offset = (addr - EXTIOI_BOUNCE_START) / 4;
> +        kvm_extioi_access_regs(fd, addr,
> +                               (void *)&s->bounce[offset], is_write);
> +    }
> +
> +    for (addr = EXTIOI_ISR_START; addr < EXTIOI_ISR_END; addr += 4) {
> +        offset = (addr - EXTIOI_ISR_START) / 4;
> +        kvm_extioi_access_regs(fd, addr,
> +                               (void *)&s->isr[offset], is_write);
> +    }
> +
> +    for (addr = EXTIOI_COREMAP_START; addr < EXTIOI_COREMAP_END; addr += 4) {
> +        offset = (addr - EXTIOI_COREMAP_START) / 4;
> +        kvm_extioi_access_regs(fd, addr,
> +                               (void *)&s->coremap[offset], is_write);
> +    }
> +
> +    for (cpuid = 0; cpuid < s->num_cpu; cpuid++) {
> +        for (addr = EXTIOI_COREISR_START;
> +             addr < EXTIOI_COREISR_END; addr += 4) {
> +            offset = (addr - EXTIOI_COREISR_START) / 4;
> +            addr = (cpuid << 16) | addr;
> +            kvm_extioi_access_regs(fd, addr,
> +                              (void *)&s->coreisr[cpuid][offset], is_write);
> +        }
> +    }
> +}
> +
> +static int kvm_loongarch_extioi_pre_save(void *opaque)
> +{
> +    kvm_extioi_save_load_regs(opaque, false);
> +    kvm_extioi_save_load_sw_status(opaque, false);
> +    return 0;
> +}
> +
> +static int kvm_loongarch_extioi_post_load(void *opaque, int version_id)
> +{
> +    KVMLoongArchExtIOI *s = (KVMLoongArchExtIOI *)opaque;
> +    KVMLoongArchExtIOIClass *class = KVM_LOONGARCH_EXTIOI_GET_CLASS(s);
> +    int fd = class->dev_fd;
> +
> +    kvm_extioi_save_load_regs(opaque, true);
> +    kvm_extioi_save_load_sw_status(opaque, true);
> +
> +    kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
> +                      KVM_DEV_LOONGARCH_EXTIOI_CTRL_LOAD_FINISHED,
> +                      NULL, true, &error_abort);
> +    return 0;
> +}
> +
> +static void kvm_loongarch_extioi_realize(DeviceState *dev, Error **errp)
> +{
> +    KVMLoongArchExtIOIClass *extioi_class = KVM_LOONGARCH_EXTIOI_GET_CLASS(dev);
> +    KVMLoongArchExtIOI *s = KVM_LOONGARCH_EXTIOI(dev);
> +    struct kvm_create_device cd = {0};
> +    Error *err = NULL;
> +    int ret, i;
> +
> +    extioi_class->parent_realize(dev, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (s->num_cpu == 0) {
> +        error_setg(errp, "num-cpu must be at least 1");
> +        return;
> +    }
> +
> +
> +    if (extioi_class->is_created) {
> +        error_setg(errp, "extioi had be created");
> +        return;
> +    }
> +
> +    if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
> +        s->features |= EXTIOI_VIRT_HAS_FEATURES;
> +    }
> +
> +    cd.type = KVM_DEV_TYPE_LOONGARCH_EXTIOI;
> +    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno,
> +                         "Creating the KVM extioi device failed");
> +        return;
> +    }
> +    extioi_class->is_created = true;
> +    extioi_class->dev_fd = cd.fd;
> +
> +    ret = kvm_device_access(cd.fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
> +                            KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU,
> +                            &s->num_cpu, true, NULL);
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno,
> +                         "KVM EXTIOI: failed to set the num-cpu of EXTIOI");
> +        exit(1);
> +    }
> +
> +    ret = kvm_device_access(cd.fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
> +                            KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_FEATURE,
> +                            &s->features, true, NULL);
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno,
> +                         "KVM EXTIOI: failed to set the feature of EXTIOI");
> +        exit(1);
> +    }
> +
> +    fprintf(stdout, "Create LoongArch extioi irqchip in KVM done!\n");
> +
> +    kvm_async_interrupts_allowed = true;
> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
> +    if (kvm_has_gsi_routing()) {
> +        for (i = 0; i < 64; ++i) {
> +            kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
> +        }
> +        kvm_gsi_routing_allowed = true;
> +    }
Does memory region need be created to extioi with irqchip_in_kernel mode?

> +}
> +
> +static const VMStateDescription vmstate_kvm_extioi_core = {
> +    .name = "kvm-extioi-single",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_save = kvm_loongarch_extioi_pre_save,
> +    .post_load = kvm_loongarch_extioi_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(nodetype, KVMLoongArchExtIOI,
> +                             EXTIOI_IRQS_NODETYPE_COUNT / 2),
> +        VMSTATE_UINT32_ARRAY(bounce, KVMLoongArchExtIOI,
> +                             EXTIOI_IRQS_GROUP_COUNT),
> +        VMSTATE_UINT32_ARRAY(isr, KVMLoongArchExtIOI, EXTIOI_IRQS / 32),
> +        VMSTATE_UINT32_2DARRAY(coreisr, KVMLoongArchExtIOI, EXTIOI_CPUS,
> +                               EXTIOI_IRQS_GROUP_COUNT),
> +        VMSTATE_UINT32_ARRAY(enable, KVMLoongArchExtIOI, EXTIOI_IRQS / 32),
> +        VMSTATE_UINT32_ARRAY(ipmap, KVMLoongArchExtIOI,
> +                             EXTIOI_IRQS_IPMAP_SIZE / 4),
> +        VMSTATE_UINT32_ARRAY(coremap, KVMLoongArchExtIOI, EXTIOI_IRQS / 4),
> +        VMSTATE_UINT8_ARRAY(sw_coremap, KVMLoongArchExtIOI, EXTIOI_IRQS),
> +        VMSTATE_UINT32(features, KVMLoongArchExtIOI),
> +        VMSTATE_UINT32(status, KVMLoongArchExtIOI),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
It is duplicated with structure vmstate_loongarch_extioi in file
hw/intc/loongarch_extioi.c

> +
> +static Property extioi_properties[] = {
> +    DEFINE_PROP_UINT32("num-cpu", KVMLoongArchExtIOI, num_cpu, 1),
> +    DEFINE_PROP_BIT("has-virtualization-extension", KVMLoongArchExtIOI,
> +                    features, EXTIOI_HAS_VIRT_EXTENSION, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
Ditto, it is duplicated.

> +
> +static void kvm_loongarch_extioi_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    KVMLoongArchExtIOIClass *extioi_class = KVM_LOONGARCH_EXTIOI_CLASS(oc);
> +
> +    extioi_class->parent_realize = dc->realize;
> +    dc->realize = kvm_loongarch_extioi_realize;
> +    extioi_class->is_created = false;
> +    device_class_set_props(dc, extioi_properties);
> +    dc->vmsd = &vmstate_kvm_extioi_core;
Do we need reset interface for irqchip_in_kernel mode?

Regards
Bibo Mao

> +}
> +
> +static const TypeInfo kvm_loongarch_extioi_info = {
> +    .name = TYPE_KVM_LOONGARCH_EXTIOI,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(KVMLoongArchExtIOI),
> +    .class_size = sizeof(KVMLoongArchExtIOIClass),
> +    .class_init = kvm_loongarch_extioi_class_init,
> +};
> +
> +static void kvm_loongarch_extioi_register_types(void)
> +{
> +    type_register_static(&kvm_loongarch_extioi_info);
> +}
> +
> +type_init(kvm_loongarch_extioi_register_types)
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index f55eb1b80b..85174d1af1 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -76,3 +76,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_IPI_KVM', if_true: files('loongarch_ipi_
>   specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
>   specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
>   specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
> +specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI_KVM', if_true: files('loongarch_extioi_kvm.c'))
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index f8fcac3e7b..99a523171f 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -17,6 +17,7 @@ config LOONGARCH_VIRT
>       select LOONGARCH_PCH_MSI
>       select LOONGARCH_EXTIOI
>       select LOONGARCH_IPI_KVM if KVM
> +    select LOONGARCH_EXTIOI_KVM if KVM
>       select LS7A_RTC
>       select SMBIOS
>       select ACPI_PCI
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 3b28e8e671..8ca7c09016 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -828,28 +828,37 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>       }
>   
>       /* Create EXTIOI device */
> -    extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
> -    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> -    if (virt_is_veiointc_enabled(lvms)) {
> -        qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
> -    }
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> -    memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
> -                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
> -    if (virt_is_veiointc_enabled(lvms)) {
> -        memory_region_add_subregion(&lvms->system_iocsr, EXTIOI_VIRT_BASE,
> -                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
> -    }
> +    if (kvm_enabled() && kvm_irqchip_in_kernel()) {
> +        extioi = qdev_new(TYPE_KVM_LOONGARCH_EXTIOI);
> +        qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> +        if (virt_is_veiointc_enabled(lvms)) {
> +            qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
> +        }
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> +    } else {
> +        extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
> +        qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> +        if (virt_is_veiointc_enabled(lvms)) {
> +            qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
> +        }
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> +        memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
> +                       sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
> +        if (virt_is_veiointc_enabled(lvms)) {
> +            memory_region_add_subregion(&lvms->system_iocsr, EXTIOI_VIRT_BASE,
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
> +        }
>   
> -    /*
> -     * connect ext irq to the cpu irq
> -     * cpu_pin[9:2] <= intc_pin[7:0]
> -     */
> -    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> -        cpudev = DEVICE(qemu_get_cpu(cpu));
> -        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
> -            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
> -                                  qdev_get_gpio_in(cpudev, pin + 2));
> +        /*
> +         * connect ext irq to the cpu irq
> +         * cpu_pin[9:2] <= intc_pin[7:0]
> +         */
> +        for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> +            cpudev = DEVICE(qemu_get_cpu(cpu));
> +            for (pin = 0; pin < LS3A_INTC_IP; pin++) {
> +                qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
> +                                      qdev_get_gpio_in(cpudev, pin + 2));
> +            }
>           }
>       }
>   
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D3C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 11:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Z0q-00037y-WC; Thu, 16 May 2024 07:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s7Z0j-00037l-VF
 for qemu-devel@nongnu.org; Thu, 16 May 2024 07:10:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s7Z0h-0002gh-2c
 for qemu-devel@nongnu.org; Thu, 16 May 2024 07:10:57 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxKPGx6UVmD4ANAA--.32628S3;
 Thu, 16 May 2024 19:10:42 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxorit6UVmKPAiAA--.3049S3; 
 Thu, 16 May 2024 19:10:40 +0800 (CST)
Subject: Re: [PATCH v2 1/2] hw/intc/loongarch_extioi: Add extioi virt
 extension definition
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240514090756.988096-1-gaosong@loongson.cn>
 <20240514090756.988096-2-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ba7eb8cf-2a8c-3ccb-13f9-e80cafa95fad@loongson.cn>
Date: Thu, 16 May 2024 19:10:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240514090756.988096-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxorit6UVmKPAiAA--.3049S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF43Jw4ruFy5GF47Zr4kKrX_yoWxtF43pr
 yUCFyfKF4UJFsrJw4UK3W5ZFyDCr4Sg342gFy2g3W5GF4UCryv934qg3s3tr4rC34kX34S
 v3Wru3WUGFWqyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE
 -erUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.033,
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



On 2024/5/14 下午5:07, Song Gao wrote:
> On LoongArch, IRQs can be routed to four vcpus with hardware extioi.
> This patch adds the extioi virt extension definition so that the IRQ can
> route to 256 vcpus.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   include/hw/intc/loongarch_extioi.h | 21 +++++++
>   hw/intc/loongarch_extioi.c         | 92 ++++++++++++++++++++++++++++--
>   2 files changed, 109 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
> index 410c6e1121..d4646fab9f 100644
> --- a/include/hw/intc/loongarch_extioi.h
> +++ b/include/hw/intc/loongarch_extioi.h
> @@ -41,6 +41,24 @@
>   #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
>   #define EXTIOI_SIZE                  0x800
>   
> +#define EXTIOI_VIRT_BASE             (0x40000000)
> +#define EXTIOI_VIRT_SIZE             (0x1000)
> +#define EXTIOI_VIRT_FEATURES         (0x0)
> +#define  EXTIOI_HAS_VIRT_EXTENSION     (0)
> +#define  EXTIOI_HAS_ENABLE_OPTION      (1)
> +#define  EXTIOI_HAS_INT_ENCODE         (2)
> +#define  EXTIOI_HAS_CPU_ENCODE         (3)
> +#define  EXTIOI_VIRT_HAS_FEATURES      (BIT(EXTIOI_HAS_VIRT_EXTENSION)  \
> +                                        | BIT(EXTIOI_HAS_ENABLE_OPTION) \
> +                                        | BIT(EXTIOI_HAS_INT_ENCODE)    \
> +                                       | BIT(EXTIOI_HAS_CPU_ENCODE))
> +#define EXTIOI_VIRT_CONFIG           (0x4)
> +#define  EXTIOI_ENABLE                 (1)
> +#define  EXTIOI_ENABLE_INT_ENCODE      (2)
> +#define  EXTIOI_ENABLE_CPU_ENCODE      (3)
> +#define EXTIOI_VIRT_COREMAP_START    (0x40)
> +#define EXTIOI_VIRT_COREMAP_END      (0x240)
> +
>   typedef struct ExtIOICore {
>       uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
>       DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
> @@ -52,6 +70,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
>   struct LoongArchExtIOI {
>       SysBusDevice parent_obj;
>       uint32_t num_cpu;
> +    uint32_t features;
> +    uint32_t status;
>       /* hardware state */
>       uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
>       uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
> @@ -65,5 +85,6 @@ struct LoongArchExtIOI {
>       qemu_irq irq[EXTIOI_IRQS];
>       ExtIOICore *cpu;
>       MemoryRegion extioi_system_mem;
> +    MemoryRegion virt_extend;
>   };
>   #endif /* LOONGARCH_EXTIOI_H */
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index 0b358548eb..89afdb1c3c 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -143,10 +143,13 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
>   
>       for (i = 0; i < 4; i++) {
>           cpu = val & 0xff;
> -        cpu = ctz32(cpu);
> -        cpu = (cpu >= 4) ? 0 : cpu;
>           val = val >> 8;
>   
> +        if (!(s->status & BIT(EXTIOI_ENABLE_CPU_ENCODE))) {
> +            cpu = ctz32(cpu);
> +            cpu = (cpu >= 4) ? 0 : cpu;
> +        }
> +
>           if (s->sw_coremap[irq + i] == cpu) {
>               continue;
>           }
> @@ -265,6 +268,61 @@ static const MemoryRegionOps extioi_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> +static MemTxResult extioi_virt_readw(void *opaque, hwaddr addr, uint64_t *data,
> +                                     unsigned size, MemTxAttrs attrs)
> +{
> +    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
> +
> +    switch (addr) {
> +    case EXTIOI_VIRT_FEATURES:
> +        *data = s->features;
> +        break;
> +    case EXTIOI_VIRT_CONFIG:
> +        *data = s->status;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult extioi_virt_writew(void *opaque, hwaddr addr,
> +                          uint64_t val, unsigned size,
> +                          MemTxAttrs attrs)
> +{
> +    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
> +
> +    switch (addr) {
> +    case EXTIOI_VIRT_FEATURES:
> +        return MEMTX_ACCESS_ERROR;
> +
> +    case EXTIOI_VIRT_CONFIG:
> +        /*
> +         * extioi features can only be set at disabled status
> +         */
> +        if ((s->status & BIT(EXTIOI_ENABLE)) && val) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +
> +        s->status = val & s->features;
> +        break;
> +    default:
> +        break;
> +    }
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps extioi_virt_ops = {
> +    .read_with_attrs = extioi_virt_readw,
> +    .write_with_attrs = extioi_virt_writew,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 8,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>   static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
>   {
>       LoongArchExtIOI *s = LOONGARCH_EXTIOI(dev);
> @@ -284,6 +342,16 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
>       memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
>                             s, "extioi_system_mem", 0x900);
>       sysbus_init_mmio(sbd, &s->extioi_system_mem);
> +
> +    if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
> +        memory_region_init_io(&s->virt_extend, OBJECT(s), &extioi_virt_ops,
> +                              s, "extioi_virt", EXTIOI_VIRT_SIZE);
> +        sysbus_init_mmio(sbd, &s->virt_extend);
> +        s->features |= EXTIOI_VIRT_HAS_FEATURES;
> +    } else {
> +        s->status |= BIT(EXTIOI_ENABLE);
> +    }
> +
>       s->cpu = g_new0(ExtIOICore, s->num_cpu);
>       if (s->cpu == NULL) {
>           error_setg(errp, "Memory allocation for ExtIOICore faile");
> @@ -304,6 +372,16 @@ static void loongarch_extioi_finalize(Object *obj)
>       g_free(s->cpu);
>   }
>   
> +static void loongarch_extioi_reset(DeviceState *d)
> +{
> +    LoongArchExtIOI *s = LOONGARCH_EXTIOI(d);
> +
> +    /* use legacy interrupt routing method by default */
> +    if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
> +        s->status = 0;
> +    }
How about clear status without checking with BIT(EXTIOI_HAS_VIRT_EXTENSION)?


> +}
> +
>   static int vmstate_extioi_post_load(void *opaque, int version_id)
>   {
>       LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
> @@ -333,8 +411,8 @@ static const VMStateDescription vmstate_extioi_core = {
>   
>   static const VMStateDescription vmstate_loongarch_extioi = {
>       .name = TYPE_LOONGARCH_EXTIOI,
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .post_load = vmstate_extioi_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOI, EXTIOI_IRQS_GROUP_COUNT),
> @@ -347,12 +425,17 @@ static const VMStateDescription vmstate_loongarch_extioi = {
>   
>           VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOI, num_cpu,
>                            vmstate_extioi_core, ExtIOICore),
> +
It seems that there is redundant empty line.

Regards
Bibo Mao
> +        VMSTATE_UINT32(features, LoongArchExtIOI),
> +        VMSTATE_UINT32(status, LoongArchExtIOI),
>           VMSTATE_END_OF_LIST()
>       }
>   };
>   
>   static Property extioi_properties[] = {
>       DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
> +    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOI, features,
> +                    EXTIOI_HAS_VIRT_EXTENSION, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -361,6 +444,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->realize = loongarch_extioi_realize;
> +    dc->reset   = loongarch_extioi_reset;
>       device_class_set_props(dc, extioi_properties);
>       dc->vmsd = &vmstate_loongarch_extioi;
>   }
> 



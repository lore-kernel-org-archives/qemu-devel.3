Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1093C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbasa-0003tM-BD; Wed, 07 Aug 2024 03:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sbasY-0003sq-JX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:14:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sbasV-0005v6-4w
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:14:38 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxOurQHrNmLxQKAA--.31754S3;
 Wed, 07 Aug 2024 15:14:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxnWfKHrNmjJ4HAA--.9501S3;
 Wed, 07 Aug 2024 15:14:23 +0800 (CST)
Subject: Re: [PULL 01/28] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240806125157.91185-1-philmd@linaro.org>
 <20240806125157.91185-2-philmd@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <c5d485dc-72eb-207a-c348-b445303b41a4@loongson.cn>
Date: Wed, 7 Aug 2024 15:14:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240806125157.91185-2-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxnWfKHrNmjJ4HAA--.9501S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw45WFW3ury5Gr18Ar45twc_yoWrZF1UpF
 ZIka1YgF13KrWUArs3GasrGF48Cr98C3srKFW2kry0gF9xXw1UuF1kJayaywsrZFyrKrn0
 vFZ09rWUGa17K3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.843,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Philippe,

I checkout the latest code, it works well.
Thanks for your efforts.

Regards
Bibo Mao

On 2024/8/6 下午8:51, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao <maobibo@loongson.cn>
> 
> We'll have to add LoongsonIPIClass in few commits,
> so rename LoongsonIPI as LoongsonIPIState for clarity.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Tested-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Message-Id: <20240805180622.21001-2-philmd@linaro.org>
> ---
>   include/hw/intc/loongson_ipi.h |  6 +++---
>   hw/intc/loongson_ipi.c         | 16 ++++++++--------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
> index 3f795edbf3..efb772f384 100644
> --- a/include/hw/intc/loongson_ipi.h
> +++ b/include/hw/intc/loongson_ipi.h
> @@ -31,10 +31,10 @@
>   #define IPI_MBX_NUM           4
>   
>   #define TYPE_LOONGSON_IPI "loongson_ipi"
> -OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
> +OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPIState, LOONGSON_IPI)
>   
>   typedef struct IPICore {
> -    LoongsonIPI *ipi;
> +    LoongsonIPIState *ipi;
>       MemoryRegion *ipi_mmio_mem;
>       uint32_t status;
>       uint32_t en;
> @@ -45,7 +45,7 @@ typedef struct IPICore {
>       qemu_irq irq;
>   } IPICore;
>   
> -struct LoongsonIPI {
> +struct LoongsonIPIState {
>       SysBusDevice parent_obj;
>       MemoryRegion ipi_iocsr_mem;
>       MemoryRegion ipi64_iocsr_mem;
> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
> index 682cec96f3..903483ae80 100644
> --- a/hw/intc/loongson_ipi.c
> +++ b/hw/intc/loongson_ipi.c
> @@ -64,7 +64,7 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
>                                               uint64_t *data,
>                                               unsigned size, MemTxAttrs attrs)
>   {
> -    LoongsonIPI *ipi = opaque;
> +    LoongsonIPIState *ipi = opaque;
>       IPICore *s;
>   
>       if (attrs.requester_id >= ipi->num_cpu) {
> @@ -160,7 +160,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
>                                               MemTxAttrs attrs)
>   {
>       IPICore *s = opaque;
> -    LoongsonIPI *ipi = s->ipi;
> +    LoongsonIPIState *ipi = s->ipi;
>       int index = 0;
>       uint32_t cpuid;
>       uint8_t vector;
> @@ -214,7 +214,7 @@ static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
>                                               uint64_t val, unsigned size,
>                                               MemTxAttrs attrs)
>   {
> -    LoongsonIPI *ipi = opaque;
> +    LoongsonIPIState *ipi = opaque;
>       IPICore *s;
>   
>       if (attrs.requester_id >= ipi->num_cpu) {
> @@ -277,7 +277,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
>   
>   static void loongson_ipi_realize(DeviceState *dev, Error **errp)
>   {
> -    LoongsonIPI *s = LOONGSON_IPI(dev);
> +    LoongsonIPIState *s = LOONGSON_IPI(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       int i;
>   
> @@ -320,7 +320,7 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
>   
>   static void loongson_ipi_unrealize(DeviceState *dev)
>   {
> -    LoongsonIPI *s = LOONGSON_IPI(dev);
> +    LoongsonIPIState *s = LOONGSON_IPI(dev);
>   
>       g_free(s->cpu);
>   }
> @@ -344,14 +344,14 @@ static const VMStateDescription vmstate_loongson_ipi = {
>       .version_id = 2,
>       .minimum_version_id = 2,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPI, num_cpu,
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPIState, num_cpu,
>                            vmstate_ipi_core, IPICore),
>           VMSTATE_END_OF_LIST()
>       }
>   };
>   
>   static Property ipi_properties[] = {
> -    DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
> +    DEFINE_PROP_UINT32("num-cpu", LoongsonIPIState, num_cpu, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -369,7 +369,7 @@ static const TypeInfo loongson_ipi_types[] = {
>       {
>           .name               = TYPE_LOONGSON_IPI,
>           .parent             = TYPE_SYS_BUS_DEVICE,
> -        .instance_size      = sizeof(LoongsonIPI),
> +        .instance_size      = sizeof(LoongsonIPIState),
>           .class_init         = loongson_ipi_class_init,
>       }
>   };
> 



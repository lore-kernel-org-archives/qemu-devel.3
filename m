Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F83C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3st-0006eG-0F; Mon, 04 Mar 2024 03:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rh3sb-0006bj-Ff
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:41:07 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rh3sX-0006Pz-Jz
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:41:01 -0500
Received: from loongson.cn (unknown [117.67.130.223])
 by gateway (Coremail) with SMTP id _____8BxSOgTieVligEUAA--.31061S3;
 Mon, 04 Mar 2024 16:40:51 +0800 (CST)
Received: from [192.168.2.12] (unknown [117.67.130.223])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxLs8SieVlJ6xNAA--.8190S3; 
 Mon, 04 Mar 2024 16:40:51 +0800 (CST)
Subject: Re: [PATCH 3/5] hw/loongarch: Add compat machine for 9.0
To: Bibo Mao <maobibo@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240220124126.1164081-1-maobibo@loongson.cn>
 <20240220124126.1164081-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e34ca6da-d0d9-abf5-07fa-182783fb63f6@loongson.cn>
Date: Mon, 4 Mar 2024 16:40:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20240220124126.1164081-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLs8SieVlJ6xNAA--.8190S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw17Ww4rGw1UCw43XFy3Jrc_yoW5WFW5pF
 98Zrs8Cw4DWFsxurWfJa1DXF15Kr4kGFy2vFs7Zw40yF98CryqvrW8C34qka97ArWktF1r
 ZF4kCa47Wa15ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.301, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



ÔÚ 2024/2/20 20:41, Bibo Mao Ð´µÀ:
> Since migration test case requires compat machine type support,
> compat machine is added for qemu 9.0 here.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c | 60 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 13 deletions(-)
> 
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index d0827aafab..a7d700497d 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -46,6 +46,32 @@
>   #include "hw/block/flash.h"
>   #include "qemu/error-report.h"
>   
> +#define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> +    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> +                                                    void *data) \
> +    { \
> +        MachineClass *mc = MACHINE_CLASS(oc); \
> +        virt_machine_##major##_##minor##_options(mc); \
> +        mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
> +        if (latest) { \
> +            mc->alias = "virt"; \
> +        } \
> +    } \
> +    static const TypeInfo machvirt_##major##_##minor##_info = { \
> +        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
> +        .parent = TYPE_VIRT_MACHINE, \
> +        .class_init = virt_##major##_##minor##_class_init, \
> +    }; \
> +    static void machvirt_machine_##major##_##minor##_init(void) \
> +    { \
> +        type_register_static(&machvirt_##major##_##minor##_info); \
> +    } \
> +    type_init(machvirt_machine_##major##_##minor##_init);
> +
> +#define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
> +    DEFINE_VIRT_MACHINE_LATEST(major, minor, true)
> +#define DEFINE_VIRT_MACHINE(major, minor) \
> +    DEFINE_VIRT_MACHINE_LATEST(major, minor, false)
>   
>   struct loaderparams {
>       uint64_t ram_size;
> @@ -1151,18 +1177,26 @@ static void virt_class_init(ObjectClass *oc, void *data)
>   #endif
>   }
>   
> -static const TypeInfo virt_machine_types[] = {
> -    {
> -        .name           = TYPE_VIRT_MACHINE,
> -        .parent         = TYPE_MACHINE,
> -        .instance_size  = sizeof(VirtMachineState),
> -        .class_init     = virt_class_init,
> -        .instance_init = virt_machine_initfn,
> -        .interfaces = (InterfaceInfo[]) {
> -         { TYPE_HOTPLUG_HANDLER },
> -         { }
> -        },
> -    }
> +static const TypeInfo virt_machine_info = {
> +    .name           = TYPE_VIRT_MACHINE,
> +    .parent         = TYPE_MACHINE,
> +    .abstract       = true,
> +    .instance_size  = sizeof(VirtMachineState),
> +    .class_init     = virt_class_init,
> +    .instance_init = virt_machine_initfn,
> +    .interfaces = (InterfaceInfo[]) {
> +    { TYPE_HOTPLUG_HANDLER },
> +    { }
> +    },
>   };
>   
> -DEFINE_TYPES(virt_machine_types)
> +static void machvirt_machine_init(void)
> +{
> +    type_register_static(&virt_machine_info);
> +}
> +type_init(machvirt_machine_init);
> +
> +static void virt_machine_9_0_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
> 



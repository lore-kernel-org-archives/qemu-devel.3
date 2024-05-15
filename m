Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1984FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7AD4-0000GB-4H; Wed, 15 May 2024 04:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s7AD1-0000B5-Q3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:41:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s7ACz-00083P-Nv
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:41:59 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxFvCdckRmgf4MAA--.31564S3;
 Wed, 15 May 2024 16:30:21 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id AQAAf8DxsribckRmjEggAA--.0S3; 
 Wed, 15 May 2024 16:30:21 +0800 (CST)
Subject: Re: [PATCH v5 1/3] hw/loongarch: Add compat machine for 9.1
To: Bibo Mao <maobibo@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20240511034220.3030560-1-maobibo@loongson.cn>
 <20240511034220.3030560-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ea3e6e07-e8b4-8ddb-a46b-84b067c7512d@loongson.cn>
Date: Wed, 15 May 2024 16:30:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240511034220.3030560-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxsribckRmjEggAA--.0S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1ruw1fXw1kur1kCrWrXrc_yoW5Wr17pF
 98ZFs0kF4UWFsxurWfJa1DZF15Grs7GFy2vFs7Zw4vyF98Cryqvry8C34qka9rA3yktF4r
 Za1kCa42ga15ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
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
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.127, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/5/11 ÉÏÎç11:42, Bibo Mao Ð´µÀ:
> Since migration test case requires compat machine type support,
> compat machine is added for qemu 9.1 here.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/virt.c | 61 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 48 insertions(+), 13 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index f0640d2d80..f24ff5fcf4 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1231,18 +1231,53 @@ static void virt_class_init(ObjectClass *oc, void *data)
>   #endif
>   }
>   
> -static const TypeInfo virt_machine_types[] = {
> -    {
> -        .name           = TYPE_LOONGARCH_VIRT_MACHINE,
> -        .parent         = TYPE_MACHINE,
> -        .instance_size  = sizeof(LoongArchVirtMachineState),
> -        .class_init     = virt_class_init,
> -        .instance_init  = virt_initfn,
> -        .interfaces = (InterfaceInfo[]) {
> -         { TYPE_HOTPLUG_HANDLER },
> -         { }
> -        },
> -    }
> +#define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> +    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> +                                                    void *data) \
> +    { \
> +        MachineClass *mc = MACHINE_CLASS(oc); \
> +        virt_machine_##major##_##minor##_options(mc); \
> +        mc->desc = "QEMU " # major "." # minor " LoongArch Virtual Machine"; \
> +        if (latest) { \
> +            mc->alias = "virt"; \
> +        } \
> +    } \
> +    static const TypeInfo machvirt_##major##_##minor##_info = { \
> +        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
> +        .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
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
> +
> +static const TypeInfo virt_machine_info = {
> +    .name           = TYPE_LOONGARCH_VIRT_MACHINE,
> +    .parent         = TYPE_MACHINE,
> +    .abstract       = true,
> +    .instance_size  = sizeof(LoongArchVirtMachineState),
> +    .class_init     = virt_class_init,
> +    .instance_init  = virt_initfn,
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
> +static void virt_machine_9_1_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)



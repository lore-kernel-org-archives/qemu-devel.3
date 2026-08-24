Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51295C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 00:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJ0h-0004db-Np; Sun, 23 Aug 2026 20:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wyJ0f-0004be-CH; Sun, 23 Aug 2026 20:57:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1wyJ0c-0006uH-FM; Sun, 23 Aug 2026 20:57:57 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axj9EHl4tqYiUEAA--.11925S3;
 Mon, 24 Aug 2026 08:57:43 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxX88Fl4tqXPUPAA--.28041S2;
 Mon, 24 Aug 2026 08:57:42 +0800 (CST)
Subject: Re: [PATCH 06/12] hw/loongarch/virt: prefix ACPI helper with
 loongarch_virt_
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, David Hildenbrand <david@kernel.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov
 <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-7-luoyonggang@gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b5850b95-25cc-ae1f-1852-16e061811d36@loongson.cn>
Date: Mon, 24 Aug 2026 09:00:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260823150731.896-7-luoyonggang@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxX88Fl4tqXPUPAA--.28041S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyUArWkAF15GFyxXFy7Arc_yoW5Ary3pF
 ZrC3ZYyw1UWry7urZFy3s8WFn8Arn3u342qF1a9r40krsrWr1UWry8Z39FyFWUZ3ykXF40
 vr1kGa4xXF47ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUd529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
 XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUeVpB3UUUU
 U==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.251, SPF_HELO_NONE=0.001,
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

ÔÚ 2026/8/23 ÏÂÎç11:07, Yonggang Luo Ð´µÀ:
> - virt_acpi_setup is the same C symbol used by ARM and RISC-V virt.
>    Rename it now so a later combined binary does not need meson -D
>    prefixes for LoongArch.
> - Rename the file-local virt_is_acpi_enabled to
>    loongarch_virt_is_acpi_enabled to match.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   hw/loongarch/virt-acpi-build.c | 6 +++---
>   hw/loongarch/virt.c            | 2 +-
>   include/hw/loongarch/virt.h    | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index a0b445f297b..bbbac289b49 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -674,7 +674,7 @@ static const VMStateDescription vmstate_acpi_build = {
>       },
>   };
>   
> -static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
> +static bool loongarch_virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
>   {
>       if (lvms->acpi == ON_OFF_AUTO_OFF) {
>           return false;
> @@ -682,7 +682,7 @@ static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
>       return true;
>   }
>   
> -void virt_acpi_setup(LoongArchVirtMachineState *lvms)
> +void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms)
>   {
>       AcpiBuildTables tables;
>       AcpiBuildState *build_state;
> @@ -692,7 +692,7 @@ void virt_acpi_setup(LoongArchVirtMachineState *lvms)
>           return;
>       }
>   
> -    if (!virt_is_acpi_enabled(lvms)) {
> +    if (!loongarch_virt_is_acpi_enabled(lvms)) {
>           ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
>           return;
>       }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6693dea647b..74c9668b6e6 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -242,7 +242,7 @@ static void virt_done(Notifier *notifier, void *data)
>       LoongArchVirtMachineState *lvms = container_of(notifier,
>                                         LoongArchVirtMachineState, machine_done);
>       virt_build_smbios(lvms);
> -    virt_acpi_setup(lvms);
> +    loongarch_virt_acpi_setup(lvms);
>       virt_fdt_setup(lvms);
>   }
>   
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index d39a9bbf5dd..72268466def 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -132,7 +132,7 @@ struct LoongArchVirtMachineState {
>   
>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
>   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
> -void virt_acpi_setup(LoongArchVirtMachineState *lvms);
> +void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms);
>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>   
>   static inline bool virt_has_dmsi(LoongArchVirtMachineState *lvms)



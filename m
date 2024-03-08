Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7F0C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVqB-00008G-RP; Fri, 08 Mar 2024 03:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVqA-000081-CF
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:44:30 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVq8-0005c9-FA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:44:30 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Dx6ujqz+pltjoWAA--.35095S3;
 Fri, 08 Mar 2024 16:44:26 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDBPqz+plCi5RAA--.18901S3; 
 Fri, 08 Mar 2024 16:44:26 +0800 (CST)
Subject: Re: [PATCH v6 15/17] hw/loongarch: fdt remove unused irqchip node
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-16-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <7ed0bcd7-bd53-4930-8ea0-7c1ce4aaa724@loongson.cn>
Date: Fri, 8 Mar 2024 16:44:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-16-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDBPqz+plCi5RAA--.18901S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWxtw1ktr1rAw18trWkGrX_yoW8Kr45pF
 W3Za9rXa17Jr1vgrZ2v3s8ur13Arn8GrW2qw17Kr4SkFyDuwnxXrWxC34IyFy8G348Aa4Y
 vFs0grZ7X3W2grcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 CztUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/3/8 上午12:48, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-16-gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 31 +------------------------------
>   1 file changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index d00343f0c2..c80732a223 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -446,34 +446,6 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams,
>       g_free(nodename);
>   }
>   
> -static void fdt_add_irqchip_node(LoongArchMachineState *lams)
> -{
> -    MachineState *ms = MACHINE(lams);
> -    char *nodename;
> -    uint32_t irqchip_phandle;
> -
> -    irqchip_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> -    qemu_fdt_setprop_cell(ms->fdt, "/", "interrupt-parent", irqchip_phandle);
> -
> -    nodename = g_strdup_printf("/intc@%lx", VIRT_IOAPIC_REG_BASE);
> -    qemu_fdt_add_subnode(ms->fdt, nodename);
> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 3);
> -    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 0x2);
> -    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
> -
> -    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
> -                            "loongarch,ls7a");
> -
> -    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
> -                                 2, VIRT_IOAPIC_REG_BASE,
> -                                 2, PCH_PIC_ROUTE_ENTRY_OFFSET);
> -
> -    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", irqchip_phandle);
> -    g_free(nodename);
> -}
> -
>   static void fdt_add_memory_node(MachineState *ms,
>                                   uint64_t base, uint64_t size, int node_id)
>   {
> @@ -1011,8 +983,7 @@ static void loongarch_init(MachineState *machine)
>   
>       /* Initialize the IO interrupt subsystem */
>       loongarch_irq_init(lams);
> -    fdt_add_irqchip_node(lams);
> -    platform_bus_add_all_fdt_nodes(machine->fdt, "/intc",
> +    platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
>                                      VIRT_PLATFORM_BUS_BASEADDRESS,
>                                      VIRT_PLATFORM_BUS_SIZE,
>                                      VIRT_PLATFORM_BUS_IRQ);
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>



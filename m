Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C52CF6498
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 07:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suobR-0000d3-LW; Sun, 29 Sep 2024 03:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1suobP-0000bq-KB
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 03:44:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1suobN-0001G1-ML
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 03:44:23 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxNOlTBflmS7YDAA--.3312S3;
 Sun, 29 Sep 2024 15:44:19 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMAxU+RSBflmcdUXAA--.21162S3;
 Sun, 29 Sep 2024 15:44:19 +0800 (CST)
Subject: Re: [PATCH v3 2/2] hw/loongarch/virt: Add FDT table support with acpi
 ged pm register
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
References: <20240918014206.2165821-1-maobibo@loongson.cn>
 <20240918014206.2165821-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <db5c3e20-6eee-4628-f7ff-fcb403aeae21@loongson.cn>
Date: Sun, 29 Sep 2024 15:45:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240918014206.2165821-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMAxU+RSBflmcdUXAA--.21162S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1xWr43Kw1xGryDKrWUWrX_yoW5ZF47pF
 Z7Ca95X347XF12vrs3Xa4Yk3Z3Ar1xuFy7ur47Gr48Cr4DXwn3XF4UC3y8AFy8X34Fq3WY
 vFs0qr9Fg3WIgrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.165,
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

在 2024/9/18 上午9:42, Bibo Mao 写道:
> ACPI ged is used for power management on LoongArch virt platform, in
> general it is parsed from acpi table. However if system boot directly from
> elf kernel, no UEFI bios is provided and acpi table cannot be used also.
>
> Here acpi ged pm register is exposed with FDT table, it is compatbile
> with syscon method in FDT table, only that acpi ged pm register is accessed
> with 8-bit mode, rather with 32-bit mode.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 81b1f9486f..1b85ba80c9 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -280,6 +280,44 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
>       g_free(nodename);
>   }
>   
> +static void fdt_add_ged_reset(LoongArchVirtMachineState *lvms)
> +{
> +    char *name;
> +    uint32_t ged_handle;
> +    MachineState *ms = MACHINE(lvms);
> +    hwaddr base = VIRT_GED_REG_ADDR;
> +    hwaddr size = ACPI_GED_REG_COUNT;
> +
> +    ged_handle = qemu_fdt_alloc_phandle(ms->fdt);
> +    name = g_strdup_printf("/ged@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, base, 0x0, size);
> +    /* 8 bit registers */
> +    qemu_fdt_setprop_cell(ms->fdt, name, "reg-shift", 0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "reg-io-width", 1);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", ged_handle);
> +    ged_handle = qemu_fdt_get_phandle(ms->fdt, name);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/reboot");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", ged_handle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", ACPI_GED_REG_RESET);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", ACPI_GED_RESET_VALUE);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/poweroff");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", ged_handle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", ACPI_GED_REG_SLEEP_CTL);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", ACPI_GED_SLP_EN |
> +                          (ACPI_GED_SLP_TYP_S5 << ACPI_GED_SLP_TYP_POS));
> +    g_free(name);
> +}
> +
>   static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>                                 uint32_t *pch_pic_phandle, hwaddr base,
>                                 int irq, bool chosen)
> @@ -737,6 +775,7 @@ static void virt_devices_init(DeviceState *pch_pic,
>                            qdev_get_gpio_in(pch_pic,
>                            VIRT_RTC_IRQ - VIRT_GSI_BASE));
>       fdt_add_rtc_node(lvms, pch_pic_phandle);
> +    fdt_add_ged_reset(lvms);
>   
>       /* acpi ged */
>       lvms->acpi_ged = create_acpi_ged(pch_pic, lvms);



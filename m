Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5DEC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 03:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRk8A-00066j-5T; Wed, 10 Jul 2024 23:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRk88-00066F-M5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 23:06:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRk85-00049M-Ry
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 23:06:00 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxXesSTI9mnhkDAA--.9290S3;
 Thu, 11 Jul 2024 11:05:54 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx68YQTI9m03pDAA--.23059S3; 
 Thu, 11 Jul 2024 11:05:54 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Change the tpm support by default
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240624032300.999157-1-lixianglai@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <5420e0aa-14e3-ed57-ff49-7d7e4fccc45b@loongson.cn>
Date: Thu, 11 Jul 2024 11:06:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240624032300.999157-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx68YQTI9m03pDAA--.23059S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1DAw15Cry7Zw1DGw15trc_yoW8XrWkpa
 srZ3Wq9r1DXrsrt3y7t34DuF9xXrn7Gw17uF4ft348KF90gwn5ur40yrZFvFZrZ3yrJFWk
 uw1rGa48ua1UJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I3
 8UUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.148, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/6/24 ÉÏÎç11:23, Xianglai Li Ð´µÀ:
> Add devices that support tpm by default,
> Fixed incomplete tpm acpi table information.
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/Kconfig      | 1 +
>   hw/loongarch/acpi-build.c | 3 +++
>   2 files changed, 4 insertions(+)
>
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index 90a0dba9d5..89be737726 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -8,6 +8,7 @@ config LOONGARCH_VIRT
>       imply VIRTIO_VGA
>       imply PCI_DEVICES
>       imply NVDIMM
> +    imply TPM_TIS_SYSBUS
>       select SERIAL
>       select VIRTIO_PCI
>       select PLATFORM_BUS
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index af45ce526d..72bfc35ae6 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -646,6 +646,9 @@ void loongarch_acpi_setup(LoongArchVirtMachineState *lvms)
>                                                build_state, tables.rsdp,
>                                                ACPI_BUILD_RSDP_FILE);
>   
> +    fw_cfg_add_file(lvms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
> +                    acpi_data_len(tables.tcpalog));
> +
>       qemu_register_reset(acpi_build_reset, build_state);
>       acpi_build_reset(build_state);
>       vmstate_register(NULL, 0, &vmstate_acpi_build, build_state);



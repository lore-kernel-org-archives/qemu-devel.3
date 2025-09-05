Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA4CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuS1d-0002TF-0p; Fri, 05 Sep 2025 04:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uuS1Z-0002Sj-50
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:42:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uuS1S-0007OL-MM
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:42:23 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxidFmorpoTwEHAA--.14730S3;
 Fri, 05 Sep 2025 16:42:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxXMFkorpoKcR_AA--.22179S3;
 Fri, 05 Sep 2025 16:42:14 +0800 (CST)
Subject: Re: [PATCH v6 03/11] hw/loongarch: add misc register supoort avecintc
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-4-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f84a1c1b-ddfe-bfe7-b40f-bbc10b5e6434@loongson.cn>
Date: Fri, 5 Sep 2025 16:40:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904121840.2023683-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXMFkorpoKcR_AA--.22179S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4xZr47AF4kurWDJw1fAFc_yoW8Ary5p3
 y8Aa4rWayjqr4xWa93u3s8ZrnxZrn7trZFgr42krWIgrZ8Ww1rAr1UAasxAFyDA3srArsY
 grn3G34DCF4qvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yrW7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
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



On 2025/9/4 下午8:18, Song Gao wrote:
> Add feature register and misc register for avecintc feature checking and
> setting
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 1a2aa92c25..124f96af03 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -560,6 +560,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
>               return MEMTX_OK;
>           }
>   
> +        if (val & BIT(IOCSRM_AVEC_EN)) {
> +            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
> +        }
> +
how about adding virt_has_avecintc(lvms) here, such as
            if (virt_has_avecintc(lvms) && val & BIT(IOCSRM_AVEC_EN)) {
                lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
            }

Otherwise looks good to me.
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


Regards
Bibo Mao

>           features = address_space_ldl(&lvms->as_iocsr,
>                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
>                                        attrs, NULL);
> @@ -595,6 +599,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           break;
>       case FEATURE_REG:
>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
> +        if (virt_has_avecintc(lvms)) {
> +            ret |= BIT(IOCSRF_AVEC);
> +        }
>           if (kvm_enabled()) {
>               ret |= BIT(IOCSRF_VM);
>           }
> @@ -624,6 +631,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>           }
> +        if (virt_has_avecintc(lvms) &&
> +            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
> +            ret |= BIT_ULL(IOCSRM_AVEC_EN);
> +        }
>           break;
>       default:
>           g_assert_not_reached();
> 



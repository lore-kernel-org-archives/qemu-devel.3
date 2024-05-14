Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4A9C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6q1h-0005jJ-7O; Tue, 14 May 2024 07:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s6q1X-0005cq-TK
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:08:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s6q1V-0006rh-V4
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:08:47 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax6uk4RkNmB6QMAA--.18554S3;
 Tue, 14 May 2024 19:08:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx0VU2RkNmtVkeAA--.37554S3; 
 Tue, 14 May 2024 19:08:40 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Add VM mode in IOCSR feature register in
 kvm mode
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240514025109.3238398-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ba7bb779-a3f4-fe11-5d12-b3ef977c6d9f@loongson.cn>
Date: Tue, 14 May 2024 19:08:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240514025109.3238398-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx0VU2RkNmtVkeAA--.37554S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFykXr15AFWkZr1xKw1ruFX_yoW8Xw43pF
 95AF4kCa1Utr13KF9rur9xXF15Can7GF12qr429rWI9r98uw1v9w1ktwnF9FWI939rJFsF
 9Fn3GFZ8Ca1DXrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
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

ÔÚ 2024/5/14 ÉÏÎç10:51, Bibo Mao Ð´µÀ:
> If VM runs in kvm mode, VM mode is added in IOCSR feature register.
> So guest can detect kvm hypervisor type and enable possible pv functions.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/virt.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index d87d9be576..44bcf25aee 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -10,6 +10,7 @@
>   #include "qapi/error.h"
>   #include "hw/boards.h"
>   #include "hw/char/serial.h"
> +#include "sysemu/kvm.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/qtest.h"
>   #include "sysemu/runstate.h"
> @@ -840,18 +841,23 @@ static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
>   
>   static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
>   {
> +    uint64_t ret;
> +
>       switch (addr) {
>       case VERSION_REG:
>           return 0x11ULL;
>       case FEATURE_REG:
> -        return 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
> -               1ULL << IOCSRF_CSRIPI;
> +        ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
> +        if (kvm_enabled()) {
> +            ret |= BIT(IOCSRF_VM);
> +        }
> +        return ret;
>       case VENDOR_REG:
>           return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
>       case CPUNAME_REG:
>           return 0x303030354133ULL;     /* "3A5000" */
>       case MISC_FUNC_REG:
> -        return 1ULL << IOCSRM_EXTIOI_EN;
> +        return BIT_ULL(IOCSRM_EXTIOI_EN);
>       }
>       return 0ULL;
>   }



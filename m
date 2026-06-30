Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B455C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWvc-0001Be-N8; Tue, 30 Jun 2026 07:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1weWva-0001BP-RD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:46:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1weWvX-0007Ib-Ke
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:46:58 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxh_GnrENq2wUAAA--.251S3;
 Tue, 30 Jun 2026 19:46:47 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCx2+CnrENqZQG5AA--.23768S3;
 Tue, 30 Jun 2026 19:46:47 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Enable TARGET_PAGE_BITS_VARY for
 loongarch64 user-only
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: b4-sent@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@mailo.com>, Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>
References: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8efb6df1-0951-2b4c-8d14-14704ab1c336@loongson.cn>
Date: Tue, 30 Jun 2026 19:49:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCx2+CnrENqZQG5AA--.23768S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7GF18Zr43KF1DtF13uF18CrX_yoW8JF1xpF
 ZxAw1qyw4kJrZFka1Sqa4fArn3ZFWxGr4IvanrKrW8Jws0q3y8uF1vkwna9F9rXay8CrWx
 uFnYq34YgFsrZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
 Z7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2026/6/30 下午3:56, Miao Wang via B4 Relay 写道:
> From: Miao Wang <shankerwangmiao@gmail.com>
>
> Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
> working on hosts with 16K page size.
>
> Fixes: 1d832c19db1e ("target/loongarch: Support 4K page size")
> Fixes: qemu-project/qemu#3651
>
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   target/loongarch/cpu-param.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
> index 3bcf77b3755abdc302699c22c7aa99e2e8c3bbf3..6abe72ff5cab46e246fde4fa76bce05ba7c1cd20 100644
> --- a/target/loongarch/cpu-param.h
> +++ b/target/loongarch/cpu-param.h
> @@ -10,6 +10,11 @@
>   
>   #define TARGET_VIRT_ADDR_SPACE_BITS 48
>   
> -#define TARGET_PAGE_BITS 12
> +#ifdef CONFIG_USER_ONLY
> +/* Allow user-only to vary page size from 4k */
> +# define TARGET_PAGE_BITS_VARY
> +#else
> +# define TARGET_PAGE_BITS 12
> +#endif
>   
>   #endif
>
> ---
> base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
> change-id: 20260630-loong64-vary-page-sz-253ded0be884
>
> Best regards,



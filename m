Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D4FD5312
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtdy-0001Vy-6b; Fri, 27 Feb 2026 03:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vvtdu-0001Vd-Ky
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:56:14 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vvtds-0001ok-3a
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:56:14 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax_6kiXKFpBsIVAA--.7029S3;
 Fri, 27 Feb 2026 16:56:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxPMIcXKFpDH1LAA--.9874S3;
 Fri, 27 Feb 2026 16:56:01 +0800 (CST)
Subject: Re: [PATCH v5 2/5] target/loongarch: Add default cpucfg3 with LA464
 CPU
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260225014131.1487362-1-maobibo@loongson.cn>
 <20260225014131.1487362-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <be7b3e09-faa4-2baa-d6e5-cfedab5e15ac@loongson.cn>
Date: Fri, 27 Feb 2026 16:57:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260225014131.1487362-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxPMIcXKFpDH1LAA--.9874S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw45GFykWw4rXFykJFW7KFX_yoW8XFW3pr
 W7Cr4YgF9rtF1xCw13XFWUKrn5Zrs7Kw12vF4xJrWDZ39rW3WDXaykJFs7AFy2y343AF40
 vFW5Ar95WFs8AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.855, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
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

ÔÚ 2026/2/25 ÉÏÎç9:41, Bibo Mao Ð´µÀ:
> The features shown in cpucfg3 mostly are relative with cache capability,
> QEMU does not support cache emulation and discard these features.
> However it will be better if it is the same with host machine.
>
> Here add default cpucfg3 feature information with LA464 CPU.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index f04558027d..93980e62a3 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -321,6 +321,22 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG2, LAM, 1);
>       env->cpucfg[2] = data;
>   
> +    data = 0;
> +    data = FIELD_DP32(data, CPUCFG3, CCDMA, 1);
> +    data = FIELD_DP32(data, CPUCFG3, UCACC, 1);
> +    data = FIELD_DP32(data, CPUCFG3, LLEXC, 1);
> +    data = FIELD_DP32(data, CPUCFG3, SCDLY, 1);
> +    data = FIELD_DP32(data, CPUCFG3, LLDBAR, 1);
> +    data = FIELD_DP32(data, CPUCFG3, ITLBHMC, 1);
> +    data = FIELD_DP32(data, CPUCFG3, ICHMC, 1);
> +    data = FIELD_DP32(data, CPUCFG3, SPW_LVL, 4);
> +    data = FIELD_DP32(data, CPUCFG3, SPW_HP_HF, 1);
> +    if (kvm_enabled()) {
> +        data = FIELD_DP32(data, CPUCFG3, RVA, 1);
> +        data = FIELD_DP32(data, CPUCFG3, RVAMAX, 7);
> +    }
> +    env->cpucfg[3] = data;
> +
>       env->cpucfg[4] = 100 * 1000 * 1000; /* Crystal frequency */
>   
>       data = 0;



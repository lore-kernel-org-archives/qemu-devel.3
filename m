Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97042C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 08:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9h3K-00039a-F3; Wed, 22 May 2024 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9h3H-000391-6S
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:10:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9h33-0000Cl-LW
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:10:22 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxFehbqE1mU5cCAA--.2028S3;
 Wed, 22 May 2024 16:10:04 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfcdZqE1mPEkFAA--.15287S3; 
 Wed, 22 May 2024 16:10:03 +0800 (CST)
Subject: Re: [PATCH 1/2] target/loongarch: Add loongarch vector property
 unconditionally
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240521080549.434197-1-maobibo@loongson.cn>
 <20240521080549.434197-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <735a6db8-b6a8-d6e6-ce10-93746f995a57@loongson.cn>
Date: Wed, 22 May 2024 16:10:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240521080549.434197-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxfcdZqE1mPEkFAA--.15287S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4fCry5Kry5tFyrtr4kXwc_yoW8Xr4Dpr
 ZxuFW2gFWjqFZ7A34DJay5Wr1vvr4xWr12qF1Sk34xurs8Jw1jqF10y39FqF97A3yxCF12
 gw1kK3W3Xa17JabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
 q2_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.405, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/5/21 ÏÂÎç4:05, Bibo Mao Ð´µÀ:
> Currently LSX/LASX vector property is decided by the default value.
> Instead vector property should be added unconditionally, and it is
> irrelative with its default value. If vector is disabled by default,
> vector also can be enabled from command line.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   target/loongarch/cpu.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index a0cad53676..b5c1ec94af 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -645,16 +645,10 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
>   
>   void loongarch_cpu_post_init(Object *obj)
>   {
> -    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> -
> -    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
> -        object_property_add_bool(obj, "lsx", loongarch_get_lsx,
> -                                 loongarch_set_lsx);
> -    }
> -    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
> -        object_property_add_bool(obj, "lasx", loongarch_get_lasx,
> -                                 loongarch_set_lasx);
> -    }
> +    object_property_add_bool(obj, "lsx", loongarch_get_lsx,
> +                             loongarch_set_lsx);
> +    object_property_add_bool(obj, "lasx", loongarch_get_lasx,
> +                             loongarch_set_lasx);
>   }
>   
>   static void loongarch_cpu_init(Object *obj)



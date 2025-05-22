Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CBFC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 04:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHx8u-0005ED-1C; Thu, 22 May 2025 00:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uHx8r-0005DE-GR
 for qemu-devel@nongnu.org; Thu, 22 May 2025 00:02:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uHx8m-00072d-So
 for qemu-devel@nongnu.org; Thu, 22 May 2025 00:02:49 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxvOLYoS5oVu31AA--.6688S3;
 Thu, 22 May 2025 12:02:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxn8XVoS5o+hvnAA--.3305S3;
 Thu, 22 May 2025 12:02:31 +0800 (CST)
Subject: Re: [PATCH] check loongarch64 vldi immediates Resolves:
 https://gitlab.com/qemu-project/qemu/-/issues/2971 Signed-off-by: Lorenz
 Hetterich <lorenz.hetterich@cispa.de>
To: Lorenz Hetterich <lorenz.hetterich@cispa.de>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 bibo mao <maobibo@loongson.cn>
References: <20250522020837.9080-1-lorenz.hetterich@cispa.de>
From: gaosong <gaosong@loongson.cn>
Message-ID: <53b791d6-4e0d-8654-747c-2ba935d317db@loongson.cn>
Date: Thu, 22 May 2025 12:05:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250522020837.9080-1-lorenz.hetterich@cispa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxn8XVoS5o+hvnAA--.3305S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWrGry3Kr13Zw13KFWfJFc_yoW8XF17pr
 4a9F4UCr4jqFWfZF93Jw4UAFn8Gw4Sqw47Was3twnYvrZ8Xr1kWFW8tw4akFWfWF1qvr1S
 vFs5A34Ygay2qacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.279,
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

在 2025/5/22 上午10:08, Lorenz Hetterich 写道:
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..5589a9e865 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3460,6 +3460,16 @@ TRANS(xvmskltz_d, LASX, gen_xx, gen_helper_vmskltz_d)
>   TRANS(xvmskgez_b, LASX, gen_xx, gen_helper_vmskgez_b)
>   TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   
> +static bool vldi_check_value(DisasContext *ctx, uint32_t imm)
> +{
> +    if (((imm >> 8) & 0xf) > 12) {
> +        generate_exception(ctx, EXCCODE_INE);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +
>   #define EXPAND_BYTE(bit)  ((uint64_t)(bit ? 0xff : 0))
>   
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
> @@ -3588,6 +3598,9 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>       sel = (a->imm >> 12) & 0x1;
>   
>       if (sel) {
> +        if (!vldi_check_value(ctx, a->imm)) {
> +            return true;
> +        }
Hi , sorry for not reply on gitlab,com,  my accout disabled.
this is incorrect ,  we should't skip  imm > 12.  imm > 12 is a invalid.
you can keep this patch  on your code if you want imm >12 not get  an error.

Thanks.
Song Gao

>           value = vldi_get_value(ctx, a->imm);
>           vece = MO_64;
>       } else {



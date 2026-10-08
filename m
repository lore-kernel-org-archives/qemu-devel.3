Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD9CCA5FFD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEekk-0007me-TA; Wed, 07 Oct 2026 23:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xEekd-0007mB-S3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 23:24:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xEeka-0004At-IF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 23:24:59 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxjdICDcdqApQTAA--.57051S3;
 Thu, 08 Oct 2026 11:24:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx3c7+DMdqhNYpAA--.23235S2;
 Thu, 08 Oct 2026 11:24:48 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: delete CSR_OFF_FUNCS
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
References: <20261008031055.38788-1-prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f6e79819-199d-7c01-6d46-984d24b255fb@loongson.cn>
Date: Thu, 8 Oct 2026 11:26:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20261008031055.38788-1-prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c7+DMdqhNYpAA--.23235S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4DGrykWr4xtw4kZr1xCrX_yoW8GFWfpF
 13uFWrKFWUJrWF9a4Dt3Wag3ZrWFWfG340qw1UArWkta1Fqw1vgFy09a1Ygry5XF4rJryS
 vry09Fn3XFnrGrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UiiSdU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.591,
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



On 2026/10/8 上午11:10, SignKirigami wrote:
> Now csr helpers are set by SET_CSR_FUNC in trans_privileged.c.inc, so this
> macro is unneeded.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---
>   target/loongarch/csr.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
> index d2ac39dee9..e474941337 100644
> --- a/target/loongarch/csr.c
> +++ b/target/loongarch/csr.c
> @@ -6,21 +6,20 @@
>   #include "cpu.h"
>   #include "csr.h"
>   
> -#define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
> +#define CSR_OFF_FLAGS(NAME, FL)                            \
>       [LOONGARCH_CSR_##NAME] = {                             \
>           .name   = (stringify(NAME)),                       \
>           .offset = CSR_OFFSET(CSR_##NAME),                  \
> -        .flags = FL, .readfn = RD, .writefn = WR           \
> +        .flags  = FL                                       \
>       }
>   
> -#define CSR_OFF_ARRAY(NAME, N)                                \
> -    [LOONGARCH_CSR_##NAME(N)] = {                             \
> -        .name   = (stringify(NAME##N)),                       \
> -        .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
> -        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
> +#define CSR_OFF_ARRAY(NAME, N)                             \
> +    [LOONGARCH_CSR_##NAME(N)] = {                          \
> +        .name   = (stringify(NAME##N)),                    \
> +        .offset = CSR_OFFSET(CSR_##NAME[N]),               \
> +        .flags  = CSRFL_BASIC                              \
>       }
>   
> -#define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
>   #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
>   
>   static CSRInfo csr_info[] = {
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>



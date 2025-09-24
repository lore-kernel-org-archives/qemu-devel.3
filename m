Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1L0F-0000FE-Sk; Wed, 24 Sep 2025 04:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v1L0D-0000Ez-JY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:37:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v1L0B-00064s-4z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:37:29 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxxtDCrdNojwEOAA--.29469S3;
 Wed, 24 Sep 2025 16:37:22 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxG8G_rdNodwarAA--.47862S3;
 Wed, 24 Sep 2025 16:37:21 +0800 (CST)
Subject: Re: [PATCH v4 08/13] target/loongarch: Change return value type with
 loongarch_tlb_search_cb()
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250906070441.3749413-1-maobibo@loongson.cn>
 <20250906070441.3749413-9-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <cc231948-f716-5573-a24c-10b8f292f8fd@loongson.cn>
Date: Wed, 24 Sep 2025 16:37:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250906070441.3749413-9-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxG8G_rdNodwarAA--.47862S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1kur43XF1DZFyUWry7twc_yoW8KFyUpr
 W3ua9xKF1UCrnrJa4Sg34Y9Fn8Zr1Ik3ySqayak34rCrs8Gr1DXr1ktayqkF18tay8Wr42
 qF1xAF1UuF1qqFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.829, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/9/6 ÏÂÎç3:04, Bibo Mao Ð´µÀ:
> With function loongarch_tlb_search_cb(), change return value type from
> bool type to pointer LoongArchTLB *, the pointer type can be use directly
> in future.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 5b78146769..c7f30eaf15 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -203,8 +203,9 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
>    * field in tlb entry contains bit[47:13], so need adjust.
>    * virt_vpn = vaddr[47:13]
>    */
> -static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
> -                                    int *index, int csr_asid, tlb_match func)
> +static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
> +                                             vaddr vaddr, int csr_asid,
> +                                             tlb_match func)
>   {
>       LoongArchTLB *tlb;
>       uint16_t tlb_asid, stlb_idx;
> @@ -229,8 +230,7 @@ static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
>   
>               if (func(tlb_g, csr_asid, tlb_asid) &&
>                   (vpn == (tlb_vppn >> compare_shift))) {
> -                *index = i * 256 + stlb_idx;
> -                return true;
> +                return tlb;
>               }
>           }
>       }
> @@ -248,12 +248,11 @@ static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
>               vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>               if (func(tlb_g, csr_asid, tlb_asid) &&
>                   (vpn == (tlb_vppn >> compare_shift))) {
> -                *index = i;
> -                return true;
> +                return tlb;
>               }
>           }
>       }
> -    return false;
> +    return NULL;
>   }
>   
>   static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
> @@ -261,10 +260,17 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
>   {
>       int csr_asid;
>       tlb_match func;
> +    LoongArchTLB *tlb;
>   
>       func = tlb_match_any;
>       csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> -    return loongarch_tlb_search_cb(env, vaddr, index, csr_asid, func);
> +    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
> +    if (tlb) {
> +        *index = tlb - env->tlb;
> +        return true;
> +    }
> +
> +    return false;
>   }
>   
>   void helper_tlbsrch(CPULoongArchState *env)



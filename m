Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7866C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbUl-0005Hr-A9; Fri, 04 Jul 2025 04:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uXbUh-0005EQ-CW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:10:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uXbUc-0006JP-VB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:10:03 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxquBQjGdo_UUiAQ--.33834S3;
 Fri, 04 Jul 2025 16:09:53 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxQMJOjGdoewcJAA--.47885S3;
 Fri, 04 Jul 2025 16:09:52 +0800 (CST)
Subject: Re: [PATCH 3/3] target/loongarch: Remove unnecessary page size
 validity checking
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20250618062607.1479699-1-maobibo@loongson.cn>
 <20250618062607.1479699-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <854e0c64-2ef5-e0cc-707e-b07dc712a60f@loongson.cn>
Date: Fri, 4 Jul 2025 16:12:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250618062607.1479699-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxQMJOjGdoewcJAA--.47885S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF15CF48CF4rXr4UGr15trc_yoW5GrWkpr
 sIk3929a48KrZrC3Z3tas0kw13Zr1xGws2q3s3GryFvrnxX34xXrWFg347KryIy345Aw4x
 ZFsIyry5uFWUZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.932, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/6/18 ÏÂÎç2:26, Bibo Mao Ð´µÀ:
> Page size of TLB entry comes from CSR STLBPS and pwcl register. With
> huge page, it is dir_base + dir_width from pwcl register. With normal
> page, it is field of PTBASE from pwcl register.
>
> So it is ok to check validity in function helper_ldpte() and function
> helper_csrwr_stlbps(). And it is unnecessary in tlb entry fill path.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index dc48b0f4d2..21381ba59f 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -173,12 +173,6 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
>           lo1 = env->CSR_TLBELO1;
>       }
>   
> -    /*check csr_ps */
> -    if (!check_ps(env, csr_ps)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "csr_ps %d is illegal\n", csr_ps);
> -        return;
> -    }
> -
>       /* Only MTLB has the ps fields */
>       if (index >= LOONGARCH_STLB) {
>           tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
> @@ -340,23 +334,16 @@ void helper_tlbfill(CPULoongArchState *env)
>   
>       if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>           entryhi = env->CSR_TLBREHI;
> +        /* Validity of pagesize is checked in helper_ldpte() */
>           pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
>       } else {
>           entryhi = env->CSR_TLBEHI;
> +        /* Validity of pagesize is checked in helper_tlbrd() */
>           pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
>       }
>   
> -    if (!check_ps(env, pagesize)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "pagesize %d is illegal\n", pagesize);
> -        return;
> -    }
> -
> +    /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
>       stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -    if (!check_ps(env, stlb_ps)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "stlb_ps %d is illegal\n", stlb_ps);
> -        return;
> -    }
> -
>       if (pagesize == stlb_ps) {
>           /* Only write into STLB bits [47:13] */
>           address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
> @@ -651,6 +638,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>           if (odd) {
>               tmp0 += MAKE_64BIT_MASK(ps, 1);
>           }
> +
> +        if (!check_ps(env, ps)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Illegal huge pagesize %ld\n", ps);
> +            return;
> +        }
>       } else {
>           badv = env->CSR_TLBRBADV;
>   



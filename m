Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE36606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW40g-0007Xy-8Y; Tue, 24 Nov 2026 22:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xW40c-0007XA-NQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 22:49:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xW40Z-0001dk-Li
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 22:49:26 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxNrW6WgZrFMwiAA--.5498S3;
 Wed, 25 Nov 2026 11:49:14 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBx5cy3WgZrUTI3AA--.17496S2;
 Wed, 25 Nov 2026 11:49:13 +0800 (CST)
Subject: Re: [PATCH v6 26/26] target/loongarch: exit to vm level 0 for fpd,
 sxd and asxd of vm level 0
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
References: <cover.1794558695.git.prcups@krgm.moe>
 <a94445d9ea2bf32832a62b62a446d90ecda03985.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <09864c25-abe2-1871-3451-4848752f72ba@loongson.cn>
Date: Wed, 25 Nov 2026 11:50:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a94445d9ea2bf32832a62b62a446d90ecda03985.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx5cy3WgZrUTI3AA--.17496S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArW3XryUWFWkXr1DWw45urX_yoW5uryUpa
 1xCF90krWFgrZ7Awn3tF45tF15uw48uw48Za4Igr15trZ8Xr1F93Wktws8KF4jkw13ZF4U
 ZFnaya429Fy3G3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 8xvIeVASjx0E3wC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8PCzJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/13 下午4:45, SignKirigami wrote:
> When vm level 0 fpe, sxe and asxe is set to 0, although on vm level 1 these
> are enabled, in TCGTBCPUState flags corresponding bit should not be set, and
> when handling exceptions, executing trigger_vm_exit() in this situation.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---
>   target/loongarch/tcg/op_helper.c | 20 ++++++++++++++++++++
>   target/loongarch/tcg/tcg_cpu.c   | 17 ++++++++++++-----
>   2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index 3b32e04268..3eaf2cfd69 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -20,9 +20,29 @@
>   /* Exceptions helpers */
>   void HELPER(raise_exception)(CPULoongArchState *env, uint32_t exception)
>   {
> +    CPUSysState *host;
> +    int vm_exit = 0;
> +
>       if (exception == EXCCODE_GSPR || exception == EXCCODE_HVC) {
> +        vm_exit = 1;
With target_vm_level added in do_raise_exception():
    target_vm_level = env_vm_level(env) + 1;
> +    } else if (env_vm_level(env)) {
> +        host = get_sys(env, VM_LEVEL0);
> +        if (exception == EXCCODE_FPD &&
> +            FIELD_EX64(host->CSR_EUEN, CSR_EUEN, FPE) == 0) {
> +            vm_exit = 1;
> +        } else if (exception == EXCCODE_SXD &&
> +            FIELD_EX64(host->CSR_EUEN, CSR_EUEN, SXE) == 0) {
> +            vm_exit = 1;
> +        }
> +        if (exception == EXCCODE_ASXD &&
> +            FIELD_EX64(host->CSR_EUEN, CSR_EUEN, ASXE) == 0) {
> +            vm_exit = 1;
> +        }
It will be better to check register CSR_EUEN in current VM level, 
otherwise the next VM level.

Regards
Bibo Mao
> +    }
> +    if (vm_exit) {
>           trigger_vm_exit(env);
>       }
> +
>       do_raise_exception(env, exception, GETPC());
>   }
>   
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 1301a9c6ad..523e0e02a1 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -261,16 +261,23 @@ static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
>   static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> -    CPUSysState *sys = env_sys(env);
> -    uint32_t flags;
> +    CPUSysState *sys = env_sys(env), *host;
> +    uint32_t flags, fpe, sxe, asxe;
>   
>       flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
> +    fpe = FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE);
> +    sxe = FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE);
> +    asxe = FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE);
>       if (env_vm_level(env) == VM_LEVEL1) {
>           flags |= HW_FLAGS_GUEST_MODE;
> +        host = get_sys(env, VM_LEVEL0);
> +        fpe &= FIELD_EX64(host->CSR_EUEN, CSR_EUEN, FPE);
> +        sxe &= FIELD_EX64(host->CSR_EUEN, CSR_EUEN, SXE);
> +        asxe &= FIELD_EX64(host->CSR_EUEN, CSR_EUEN, ASXE);
>       }
> -    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
> -    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
> -    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
> +    flags |= fpe * HW_FLAGS_EUEN_FPE;
> +    flags |= sxe * HW_FLAGS_EUEN_SXE;
> +    flags |= asxe * HW_FLAGS_EUEN_ASXE;
>       flags |= is_va32(env) * HW_FLAGS_VA32;
>   
>       return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
> 



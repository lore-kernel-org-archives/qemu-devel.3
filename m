Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8425CA6004
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 01:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEcyf-0008D4-4g; Wed, 07 Oct 2026 21:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xEcxj-00086n-Uf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 21:30:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xEcxf-0003qd-CC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 21:30:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxQNEd8sZquI0TAA--.57801S3;
 Thu, 08 Oct 2026 09:30:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxTs8a8sZqQ8spAA--.22973S2;
 Thu, 08 Oct 2026 09:30:04 +0800 (CST)
Subject: Re: [PATCH 10/27] target/loongarch: Register
 CPUClass::exception_name() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-11-philmd@oss.qualcomm.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <fee64403-79ea-634f-76e6-e5cc4956463d@loongson.cn>
Date: Thu, 8 Oct 2026 09:31:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20261007094516.75732-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs8a8sZqQ8spAA--.22973S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWDtF1fGr48KrWxXr4UJrc_yoW7Zr4xpF
 s7C3srKF48J3srZrykJ3yYgF98Gr4UWr42k3Z7XayftFnYvr1vgF4ktayqgF13C3yDGr42
 vF4rAryUta1rArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
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

On 2026/10/7 下午5:44, Philippe Mathieu-Daudé wrote:
> Move loongarch_exception_name() out of tcg_cpu.c and expose
> the prototype so non-TCG code path can access it. Register
> it as the CPUClass::exception_name() handler, so the common
> exception logging can resolve LoongArch exception codes to
> names. Remove the qemu_log_mask() call in do_raise_exception()
> because it would duplicate the one in log_raise_exception().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/loongarch/internals.h   |  2 ++
>   target/loongarch/cpu.c         | 38 ++++++++++++++++++++++++++++
>   target/loongarch/tcg/tcg_cpu.c | 45 ----------------------------------
>   3 files changed, 40 insertions(+), 45 deletions(-)
> 
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index ff956823fd7..e7fed3afde5 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -42,6 +42,8 @@ bool loongarch_cpu_has_work(CPUState *cs);
>   bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
>   #endif /* !CONFIG_USER_ONLY */
>   
> +const char *loongarch_exception_name(int exception);
> +
>   uint64_t read_fcc(CPULoongArchState *env);
>   void write_fcc(CPULoongArchState *env, uint64_t val);
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 54c26998979..fc9c5ab5ac2 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -835,6 +835,43 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   }
>   
> +static const struct {
> +    int32_t exccode;
> +    const char * const name;
> +} excp_names[] = {
> +    {EXCCODE_INT, "Interrupt"},
> +    {EXCCODE_PIL, "Page invalid exception for load"},
> +    {EXCCODE_PIS, "Page invalid exception for store"},
> +    {EXCCODE_PIF, "Page invalid exception for fetch"},
> +    {EXCCODE_PME, "Page modified exception"},
> +    {EXCCODE_PNR, "Page Not Readable exception"},
> +    {EXCCODE_PNX, "Page Not Executable exception"},
> +    {EXCCODE_PPI, "Page Privilege error"},
> +    {EXCCODE_ADEF, "Address error for instruction fetch"},
> +    {EXCCODE_ADEM, "Address error for Memory access"},
> +    {EXCCODE_SYS, "Syscall"},
> +    {EXCCODE_BRK, "Break"},
> +    {EXCCODE_INE, "Instruction Non-Existent"},
> +    {EXCCODE_IPE, "Instruction privilege error"},
> +    {EXCCODE_FPD, "Floating Point Disabled"},
> +    {EXCCODE_FPE, "Floating Point Exception"},
> +    {EXCCODE_DBP, "Debug breakpoint"},
> +    {EXCCODE_BCE, "Bound Check Exception"},
> +    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
> +    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
> +    {EXCP_HLT, "EXCP_HLT"},
> +};
> +
> +const char *loongarch_exception_name(int exception)
> +{
> +    for (size_t i = 0; i < ARRAY_SIZE(excp_names); i++) {
> +        if (excp_names[i].exccode == exception) {
> +            return excp_names[i].name;
> +        }
> +    }
> +    return "Unknown";
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/core/sysemu-cpu-ops.h"
>   
> @@ -875,6 +912,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, const void *data)
>                                          &lacc->parent_phases);
>   
>       cc->class_by_name = loongarch_cpu_class_by_name;
> +    cc->exception_name = loongarch_exception_name;
>       cc->dump_state = loongarch_cpu_dump_state;
>       cc->set_pc = loongarch_cpu_set_pc;
>       cc->get_pc = loongarch_cpu_get_pc;
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 4b1d44a1644..933b9b2d221 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -18,57 +18,12 @@
>   #include "tcg_loongarch.h"
>   #include "internals.h"
>   
> -struct TypeExcp {
> -    int32_t exccode;
> -    const char * const name;
> -};
> -
> -static const struct TypeExcp excp_names[] = {
> -    {EXCCODE_INT, "Interrupt"},
> -    {EXCCODE_PIL, "Page invalid exception for load"},
> -    {EXCCODE_PIS, "Page invalid exception for store"},
> -    {EXCCODE_PIF, "Page invalid exception for fetch"},
> -    {EXCCODE_PME, "Page modified exception"},
> -    {EXCCODE_PNR, "Page Not Readable exception"},
> -    {EXCCODE_PNX, "Page Not Executable exception"},
> -    {EXCCODE_PPI, "Page Privilege error"},
> -    {EXCCODE_ADEF, "Address error for instruction fetch"},
> -    {EXCCODE_ADEM, "Address error for Memory access"},
> -    {EXCCODE_SYS, "Syscall"},
> -    {EXCCODE_BRK, "Break"},
> -    {EXCCODE_INE, "Instruction Non-Existent"},
> -    {EXCCODE_IPE, "Instruction privilege error"},
> -    {EXCCODE_FPD, "Floating Point Disabled"},
> -    {EXCCODE_FPE, "Floating Point Exception"},
> -    {EXCCODE_DBP, "Debug breakpoint"},
> -    {EXCCODE_BCE, "Bound Check Exception"},
> -    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
> -    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
> -    {EXCP_HLT, "EXCP_HLT"},
> -};
> -
> -static const char *loongarch_exception_name(int32_t exception)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
> -        if (excp_names[i].exccode == exception) {
> -            return excp_names[i].name;
> -        }
> -    }
> -    return "Unknown";
> -}
> -
>   void G_NORETURN do_raise_exception(CPULoongArchState *env,
>                                      uint32_t exception,
>                                      uintptr_t pc)
>   {
>       CPUState *cs = env_cpu(env);
>   
> -    qemu_log_mask(CPU_LOG_INT, "%s: exception: %d (%s)\n",
> -                  __func__,
> -                  exception,
> -                  loongarch_exception_name(exception));
>       cs->exception_index = exception;
>   
>       cpu_loop_exit_restore(cs, pc);
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9F8C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 03:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x88Le-0003kT-KE; Sat, 19 Sep 2026 23:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x88Lb-0003jw-5M
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 23:36:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x88LY-0001pF-JX
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 23:36:10 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxTNKdVK9q29QNAA--.40122S3;
 Sun, 20 Sep 2026 11:35:57 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxBc2WVK9q79oiAA--.46840S2;
 Sun, 20 Sep 2026 11:35:55 +0800 (CST)
Subject: Re: [PATCH RESEND] target/loongarch: select sys state by VM level
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
References: <20260920024305.18296-2-prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e6c28327-27b1-d085-90c3-dfd8649b14ba@loongson.cn>
Date: Sun, 20 Sep 2026 11:35:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260920024305.18296-2-prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxBc2WVK9q79oiAA--.46840S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zry8Kw1ruF1rZF1xtF4DWrX_yoW8trykpr
 ZrAFyYga18KFZrAan7A3s8Grn8XrnrGrW29ayI9348tF45Jry5G3Wkt39rKF1DJ34kCFyx
 Za1rCr45Xay2q3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8PC
 zJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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



On 2026/9/20 上午10:43, SignKirigami wrote:
> Define VM_LEVEL0 and VM_LEVELS for the available VM levels. Replace
> set_sys_state(), which accepted a CPUSysState pointer, with set_sys(),
> which selects a state by VM level. There is no function change in this
> patch.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---
> This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05968.html
> 
>   target/loongarch/cpu.c | 4 ++--
>   target/loongarch/cpu.h | 7 +++++--
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index c71531c1cf..9d944dcb29 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -304,7 +304,7 @@ static void loongarch_la464_initfn(Object *obj)
>       uint32_t data = 0, field;
>       int i;
>   
> -    set_sys_state(env, &env->sys_states[0]);
> +    set_sys(env, VM_LEVEL0);
>       for (i = 0; i < 21; i++) {
>           env->cpucfg[i] = 0x0;
>       }
> @@ -433,7 +433,7 @@ static void loongarch_la132_initfn(Object *obj)
>       uint32_t data = 0;
>       int i;
>   
> -    set_sys_state(env, &env->sys_states[0]);
> +    set_sys(env, VM_LEVEL0);
>       for (i = 0; i < 21; i++) {
>           env->cpucfg[i] = 0x0;
>       }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 477a5dee7d..c0edcc9065 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -321,6 +321,9 @@ typedef struct CPUTimerState {
>       CPUState *cs;
>   } CPUTimerState;
>   
> +#define VM_LEVEL0   0
> +#define VM_LEVELS   1
> +
>   #define CPU_VENDOR_LOONGSON   "Loongson"
>   #define CPU_MODEL_3A5000      "3A5000"
>   #define CPU_MODEL_1C101       "1C101"
> @@ -507,9 +510,9 @@ static inline CPUSysState *env_sys(CPULoongArchState *env)
>       return env->sys_state;
>   }
>   
> -static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
> +static inline void set_sys(CPULoongArchState *env, int vm_level)
>   {
> -    env->sys_state = sys;
> +    env->sys_state = &env->sys_states[vm_level];
>   }
>   
>   static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>



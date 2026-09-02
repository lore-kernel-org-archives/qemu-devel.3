Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E4DC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1bPk-0001wJ-Py; Tue, 01 Sep 2026 23:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x1bPg-0001w3-BK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:13:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x1bPd-0006BF-4J
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:13:24 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxOvCYk5dq9pwHAA--.21946S3;
 Wed, 02 Sep 2026 11:10:17 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCx9cyUk5dqYUoZAA--.25748S2;
 Wed, 02 Sep 2026 11:10:14 +0800 (CST)
Subject: Re: [PATCH v4 04/14] target/loongarch: Add LVZ CPU model support
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <bfcdf85a59d800eb40457871691b1dea111e0019.1787739852.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <12282a14-3124-b4b4-1178-15fd938a1811@loongson.cn>
Date: Wed, 2 Sep 2026 11:09:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bfcdf85a59d800eb40457871691b1dea111e0019.1787739852.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx9cyUk5dqYUoZAA--.25748S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3uw4xKryrKFyUZr17Ww43CFX_yoWkCw1kpr
 4jkFZF9345Kr4xZr43JFs8t3W5Zr4xGw1xK3s2kr13Z34kXr4fXaykWF1fKFyjyw1Sya18
 uFn3Xa9rGFs8AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.635,
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



On 2026/8/26 下午6:30, SignKirigami wrote:
> Add the LVZ CPU property and initialize the host and guest state banks
> for the LA464 model. Reset always returns to the host CSR and TLB bank
> and initializes the implemented guest ID width.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c | 145 +++++++++++++++++++++++++----------------
>   1 file changed, 90 insertions(+), 55 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 0f6a211949..c5c7f3e0e3 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -114,12 +114,12 @@ static void loongarch_la464_init_csr(DeviceState *dev)
>       static bool initialized;
>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>       CPULoongArchState *env = &cpu->env;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
There is set_sys_state() called in loongarch_la464_initfn(), it is host 
sysstate in the beginning, I think that it is not necessary to change 
this piece of code.
>       int i, num;
>   
>       if (!initialized) {
>           initialized = true;
> -        num = FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
> +        num = FIELD_EX64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
>           for (i = num; i < 16; i++) {
>               set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
>           }
> @@ -251,11 +251,32 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
>       cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, value);
>   }
>   
> +static bool loongarch_get_lvz(Object *obj, Error **errp)
> +{
> +    return LOONGARCH_CPU(obj)->lvz != ON_OFF_AUTO_OFF;
> +}
> +
> +static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    cpu->lvz = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +
> +    if (kvm_enabled()) {
> +        return;
> +    }
This can be removed if lvz property is only added in TCG mode.
> +
> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ, value);
> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ_VER,
> +                                    value ? 1 : 0);
> +}
> +
>   static void loongarch_cpu_post_init(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>   
>       cpu->lbt = ON_OFF_AUTO_OFF;
> +    cpu->lvz = ON_OFF_AUTO_AUTO;
>       cpu->pmu = ON_OFF_AUTO_OFF;
>       cpu->lsx = ON_OFF_AUTO_AUTO;
>       cpu->lasx = ON_OFF_AUTO_AUTO;
> @@ -267,6 +288,8 @@ static void loongarch_cpu_post_init(Object *obj)
>                                loongarch_set_msgint);
>       object_property_add_bool(obj, "ptw", loongarch_get_ptw,
>                                loongarch_set_ptw);
> +    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
> +                             loongarch_set_lvz);
Can lvz property be added only in TCG mode?
>       /* lbt is enabled only in kvm mode, not supported in tcg mode */
>   
>       if (kvm_enabled()) {
> @@ -278,7 +301,8 @@ static void loongarch_la464_initfn(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>       CPULoongArchState *env = &cpu->env;
> -    CPUSysState *sys;
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
Variable name sys had better keep unchanged, so that smallest modification.
> +    CPUSysState *guest = get_sys(env, LOONGARCH_VM_LEVEL_GUEST);
>       uint32_t data = 0, field;
>       int i;
>   
> @@ -322,6 +346,8 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG2, FP_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LSX, 1),
>       data = FIELD_DP32(data, CPUCFG2, LASX, 1),
> +    data = FIELD_DP32(data, CPUCFG2, LVZ, 1);
> +    data = FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
Add LVZ feature checking here only if LVZ feature is enabled.

>       data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
>       data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
> @@ -386,19 +412,19 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
>       env->cpucfg[20] = data;
>   
> -    sys = env_sys(env);
> -    sys->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
> +    host->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
> +    guest->CSR_ASID = host->CSR_ASID;Had better add lvz feature checking, such as
       if (cpu->lvz == ON_OFF_AUTO_ON) {
           guest->CSR_ASID = host->CSR_ASID;
       }
>   
> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
> -    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
> +    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
>   
> -    sys->CSR_PRCFG2 = 0x3ffff000;
> +    host->CSR_PRCFG2 = 0x3ffff000;
>   
> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
> -    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
> +    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>   
>       cpu->msgint = ON_OFF_AUTO_OFF;
>       cpu->ptw = ON_OFF_AUTO_OFF;
> @@ -439,6 +465,7 @@ static void loongarch_la132_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG1, CRC, 1);
>       env->cpucfg[1] = data;
>       cpu->msgint = ON_OFF_AUTO_OFF;
> +    cpu->lvz = ON_OFF_AUTO_OFF;
>       cpu->ptw = ON_OFF_AUTO_OFF;
>   }
>   
> @@ -600,7 +627,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       CPUState *cs = CPU(obj);
>       LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
>       CPULoongArchState *env = cpu_env(cs);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
Had better keep name *sys* unchanged for smallest modification.

Regards
Bibo Mao
>   
>       if (lacc->parent_phases.hold) {
>           lacc->parent_phases.hold(obj, type);
> @@ -624,61 +651,69 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   
>       int n;
>       /* Set csr registers value after reset, see the manual 6.4. */
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
> -
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
> -
> -    sys->CSR_MISC = 0;
> -
> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
> -
> -    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
> -    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
> -    sys->CSR_CPUID = cs->cpu_index;
> -    sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
> -    sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
> -    sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
> -    sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
> -    sys->CSR_TID = cs->cpu_index;
> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, PLV, 0);
> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, IE, 0);
> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DA, 1);
> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, PG, 0);
> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DATF, 0);
> +    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DATM, 0);
> +
> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, FPE, 0);
> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, SXE, 0);
> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, ASXE, 0);
> +    host->CSR_EUEN = FIELD_DP64(host->CSR_EUEN, CSR_EUEN, BTE, 0);
> +
> +    host->CSR_MISC = 0;
> +
> +    host->CSR_ECFG = FIELD_DP64(host->CSR_ECFG, CSR_ECFG, VS, 0);
> +    host->CSR_ECFG = FIELD_DP64(host->CSR_ECFG, CSR_ECFG, LIE, 0);
> +
> +    host->CSR_ESTAT = host->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
> +    host->CSR_RVACFG = FIELD_DP64(host->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
> +    host->CSR_CPUID = cs->cpu_index;
> +    host->CSR_TCFG = FIELD_DP64(host->CSR_TCFG, CSR_TCFG, EN, 0);
> +    host->CSR_LLBCTL = FIELD_DP64(host->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
> +    host->CSR_TLBRERA = FIELD_DP64(host->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
> +    host->CSR_MERRCTL = FIELD_DP64(host->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
> +    host->CSR_TID = cs->cpu_index;
> +    host->CSR_GSTAT = 0;
> +    host->CSR_GCFG = 0;
> +    host->CSR_GINTC = 0;
> +    host->CSR_GCNTC = 0;
> +    host->CSR_GTLBC = 0;
>       /*
>        * Workaround for edk2-stable202408, CSR PGD register is set only if
>        * its value is equal to zero for boot cpu, it causes reboot issue.
>        *
>        * Here clear CSR registers relative with TLB.
>        */
> -    sys->CSR_PGDH = 0;
> -    sys->CSR_PGDL = 0;
> -    sys->CSR_PWCH = 0;
> -    sys->CSR_EENTRY = 0;
> -    sys->CSR_TLBRENTRY = 0;
> -    sys->CSR_MERRENTRY = 0;
> +    host->CSR_PGDH = 0;
> +    host->CSR_PGDL = 0;
> +    host->CSR_PWCH = 0;
> +    host->CSR_EENTRY = 0;
> +    host->CSR_TLBRENTRY = 0;
> +    host->CSR_MERRENTRY = 0;
>       /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
> -    if (sys->CSR_PRCFG2 == 0) {
> -        sys->CSR_PRCFG2 = 0x3fffff000;
> +    if (host->CSR_PRCFG2 == 0) {
> +        host->CSR_PRCFG2 = 0x3fffff000;
>       }
> -    tlb_ps = ctz32(sys->CSR_PRCFG2);
> -    sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
> -    sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
> +    tlb_ps = ctz32(host->CSR_PRCFG2);
> +    host->CSR_STLBPS = FIELD_DP64(host->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
> +    host->CSR_PWCL = FIELD_DP64(host->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
>       for (n = 0; n < 4; n++) {
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV0, 0);
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV1, 0);
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV2, 0);
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV3, 0);
> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV0, 0);
> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV1, 0);
> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV2, 0);
> +        host->CSR_DMW[n] = FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV3, 0);
> +    }
> +    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ)) {
> +         host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, GIDBIT, 8);
>       }
>   
>   #ifndef CONFIG_USER_ONLY
>       env->pc = 0x1c000000;
>   #ifdef CONFIG_TCG
> -    memset(env->tlb, 0, sizeof(env->tlb));
> +    memset(host->tlb, 0, sizeof(host->tlb));
>   #endif
>       if (kvm_enabled()) {
>           kvm_arch_reset_vcpu(cs);
> 



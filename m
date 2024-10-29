Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A218BD2AB15
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5t8A-0001fY-Ir; Tue, 29 Oct 2024 16:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t5t7l-0001Qf-2K; Tue, 29 Oct 2024 16:47:51 -0400
Received: from smtp1-g21.free.fr ([2a01:e0c:1:1599::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t5t7e-0004Zg-Sg; Tue, 29 Oct 2024 16:47:32 -0400
Received: from zimbra83-e15.priv.proxad.net (unknown [172.20.243.252])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 26D9FB00571;
 Tue, 29 Oct 2024 21:47:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1730234829;
 bh=v1TWAZb8OQG85dxrs0Bpz+2OwcB3hwa+95QE6bHQBWQ=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=NpeQpjVNekdk3JY11mQ9HiM9iFpxgRJ5aD8+eAV4GNPEkHuOjc8OkmolL3Nl/DZo3
 hvEkKY4U/w2PJ24oRp3MsQBsURIE4uCxM/2gLUi9MIUwlb7G5Ci09Suxqie9m4+Wfa
 4Wo/mXSN/4qcVZoxcEXh1nLadV6jL8K/ubL1exMXxZ+goPyuXGA/mkzH8fqlBOEawU
 WlzHVrgVyp2DQZzjAbj3BKmug1ORtACamNC6Hz5YHSYkfTMLbJFilyQ69GgeXu9Hqk
 XlMw9ygeSlZljxt71JGPCsl/AOWlhany49QC4o/J9PC/e6dxKVYDHBW27zCvjdZuD/
 ZBZJHZzfkh3uA==
Date: Tue, 29 Oct 2024 21:47:09 +0100 (CET)
From: castet.matthieu@free.fr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM cores" <qemu-arm@nongnu.org>
Message-ID: <605361231.417554090.1730234829057.JavaMail.root@zimbra83-e15.priv.proxad.net>
In-Reply-To: <CAFEAcA9JQNJBfk+g8iYcczVcTSqEOJZ5=LGtBupHqreUX-2MkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: Add cortex-m0+ support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a01:cb00:13da:d200:7cf5:aa34:e526:681b]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: castet.matthieu@free.fr
Received-SPF: pass client-ip=2a01:e0c:1:1599::10;
 envelope-from=castet.matthieu@free.fr; helo=smtp1-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Peter,

>On Tue, 22 Oct 2024 at 21:34, Matthieu Castet <castet.matthieu@free.fr> wrote:
>>
>> Signed-off-by: Matthieu Castet<castet.matthieu@free.fr>
>
>Hi; thanks for this patch. I have some initial code review comments,
>but the change looks broadly correct to me and I don't think
>there's anything obvious missing.
>
>The commit message body here is empty. Commits should
>almost always have some description in the body of
>what they are doing and why.

Thanks for the review. When I sent the patch, I didn't put my
last version and some of your comment were already fixed.
Sorry for that.

>
>(You don't need a separate cover-letter email for
>single-patch patches, by the way -- only for multi-patch series.)
>

ok

>> ---
>>  hw/intc/armv7m_nvic.c    | 38 +++++++++++++++++++++++++++++++++-----
>>  target/arm/cpu.c         |  4 ++--
>>  target/arm/ptw.c         | 23 +++++++++++++++++++----
>>  target/arm/tcg/cpu-v7m.c | 21 ++++++++++++++++++++-
>>  4 files changed, 74 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index 98f3cf59bc..ed084e9db3 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -1386,7 +1386,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>>          }
>>          return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);
>>      }
>> -    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
>> +    case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */
>>      case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
>>      case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
>>      case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
>
>The v6M spec says that it doesn't have the _A* aliases
>for RBAR and RASR so we should have a check to make those
>goto bad_offset in both read and write functions.

ok, I will add the bad_offset to read



>
>> @@ -1876,6 +1876,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>>              return;
>>          }
>>
>> +        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
>> +                if (offset != 0xd9c)
>> +                        goto bad_offset;
>
>Our coding style says all if() statements need braces, even
>one-line ones. The indentation here also seems to be off --
>our indent is four-space.
>

I will fix the code

>> +
>> +                /* do not support size less than 256 */
>> +                value &= ~0xe0;
>
>This line doesn't look like it does what the comment suggests.
>A region size of 256 bytes would be a SIZE field of 7, where
>the size field is bits [5:1]. This &= ~0xe0 will (unless I've
>got confused) zero bits [3:1], which would turn a SIZE of 7
>into an invalid SIZE of 0.

The code is checking region address alignement, not region size.
ADDR is encoded on bits [31:8] on armv6-m and bits [31:5]
on armv7-m.

I will update the comment to 

                /* armv6-m do not support region address with alignement 
                 * less than 256. Force alignement.
                 */


>
>More generally: in QEMU if we're enforcing limits on the
>values a register field can hold we typically do it on the
>guest-write path. Then the read path can just return the
>value in the register, which we already know to be in-range.

Ok



>> -    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
>> -    case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
>> -    case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
>> -    case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
>> +    case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */
>> +    case 0xda8: /* MPU_RASR_A1 (v6M/v7M), MPU_RLAR_A1 (v8M) */
>> +    case 0xdb0: /* MPU_RASR_A2 (v6M/v7M), MPU_RLAR_A2 (v8M) */
>> +    case 0xdb8: /* MPU_RASR_A3 (v6M/v7M), MPU_RLAR_A3 (v8M) */
>
>v6M doesn't have the RASR_A* aliases, so those lines shouldn't change.

ok


>
>>      {
>>          int region = cpu->env.pmsav7.rnr[attrs.secure];
>> +        int rsize;
>>
>>          if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
>>              /* PMSAv8M handling of the aliases is different from v7M:
>> @@ -1926,6 +1935,25 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>>              return;
>>          }
>>
>> +        rsize = extract32(value, 1, 5);
>> +        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
>> +            if (offset != 0xda0)
>> +                goto bad_offset;
>> +            /* for armv6-m rsize >= 7 (min 256) */
>> +            if (rsize < 7) {
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                        "MPU region size too small %d\n", rsize);
>> +                return;
>> +            }
>> +        }
>> +
>> +        /* for armv7-m rsize >= 4 (min 32) */
>> +        if (rsize < 4) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                    "MPU region size too small %d\n", rsize);
>> +            return;
>> +        }
>
>You don't need to handle and log too-large region
>sizes both in the register-set codepath and then again
>later when we do the address translation. If you're ruling
>them out here then they'll never happen later.

Ok, let's handle it here in the write path.


>
>Duplicating the qemu_log_mask() line is awkward -- maybe
>better to have
>  rsize_min = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 4 : 7;
>  if (rsize < rsize_min) {
>      qemu_log_mask(...)
>  }
>

Ok, I will do that



>> +
>>          if (region >= cpu->pmsav7_dregion) {
>>              return;
>>          }
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 1320fd8c8f..875e3aab69 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -508,7 +508,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
>>                             sizeof(*env->pmsav8.rlar[M_REG_S])
>>                             * cpu->pmsav7_dregion);
>>                  }
>> -            } else if (arm_feature(env, ARM_FEATURE_V7)) {
>> +            } else if (arm_feature(env, ARM_FEATURE_M)) {
>>                  memset(env->pmsav7.drbar, 0,
>>                         sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
>>                  memset(env->pmsav7.drsr, 0,
>> @@ -2454,7 +2454,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>      }
>>
>>      if (arm_feature(env, ARM_FEATURE_PMSA) &&
>> -        arm_feature(env, ARM_FEATURE_V7)) {
>> +        arm_feature(env, ARM_FEATURE_M)) {
>>          uint32_t nr = cpu->pmsav7_dregion;
>>
>>          if (nr > 0xff) {
>
>These changes don't look correct -- they will break the handling
>of R-profile PMSAv7 CPUs like the Cortex-R5.

You are right, I changed it to : 



@@ -508,7 +508,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                            sizeof(*env->pmsav8.rlar[M_REG_S])
                            * cpu->pmsav7_dregion);
                 }
-            } else if (arm_feature(env, ARM_FEATURE_V7)) {
+            } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                       arm_feature(env, ARM_FEATURE_M)) {
                 memset(env->pmsav7.drbar, 0,
                        sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
                 memset(env->pmsav7.drsr, 0,
@@ -2454,7 +2455,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+        (arm_feature(env, ARM_FEATURE_V7) || arm_feature(env, ARM_FEATURE_M))) {
         uint32_t nr = cpu->pmsav7_dregion;
 
         if (nr > 0xff) {


Is that correct ?

>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index dd40268397..fa771907e3 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -2383,6 +2383,13 @@ static bool pmsav7_use_background_region(ARMCPU *cpu, ARMMMUIdx mmu_idx,
>>      return regime_sctlr(env, mmu_idx) & SCTLR_BR;
>>  }
>>
>> +/* armv6m PMSAv6 is mostly compatible with PMSAv7,
>> + * main difference :
>> + * - min region size is 256 instead of 32
>> + * - TEX can be only 0 (Tex not used by qemu)
>> + * - no alias register
>> + * - HardFault instead of MemManage
>> + */
>
>Our coding style for multiline comments says
>/*
> * they look like this, with the opening and closing markers on
> * lines of their own
> */

I will changed that.

It do not seem to be followed in In hw/intc/armv7m_nvic.c, but my new comment should also follow
this rule in this file ?


>
>This comment might be better placed at the point below where
>we call get_phys_addr_psav7(), because it is the explanation
>for why on M-profile we call that function even if we don't
>have PMSAv7.

ok

>
>>  static bool get_phys_addr_pmsav7(CPUARMState *env,
>>                                   S1Translate *ptw,
>>                                   uint32_t address,
>> @@ -2423,11 +2430,19 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
>>                  continue;
>>              }
>>
>> -            if (!rsize) {
>> +            /* Issue warning for invalid values
>> +             * for armv7-m rsize >= 4 (min 32)
>> +             * for armv6-m rsize >= 7 (min 256)
>> +             */
>> +            if (!rsize ||
>> +                (arm_feature(env, ARM_FEATURE_M) && (
>> +                       rsize < 7 ||
>> +                       (rsize < 4 && !arm_feature(env, ARM_FEATURE_V7))))) {
>>                  qemu_log_mask(LOG_GUEST_ERROR,
>> -                              "DRSR[%d]: Rsize field cannot be 0\n", n);
>> +                              "DRSR[%d]: Rsize field cannot be %d\n", n, rsize);
>>                  continue;
>>              }
>> +
>>              rsize++;
>>              rmask = (1ull << rsize) - 1;

I will remove this modification. Size check is done in write.


>>
>> @@ -3515,8 +3530,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
>>              /* PMSAv8 */
>>              ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
>>                                         result, fi);
>> -        } else if (arm_feature(env, ARM_FEATURE_V7)) {
>> -            /* PMSAv7 */
>> +        } else if (arm_feature(env, ARM_FEATURE_V7) || arm_feature(env, ARM_FEATURE_M)) {
>> +            /* PMSAv7 or PMSAv6 */
>
>This is specifically M-profile PMSAv6. R-profile PMSAv6
>(which we do not implement) is a bit different.

I change the comment to "armv6-m PMSAv6".



>>  static void cortex_m3_initfn(Object *obj)
>>  {
>>      ARMCPU *cpu = ARM_CPU(obj);
>> @@ -111,6 +125,7 @@ static void cortex_m4_initfn(Object *obj)
>>      set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
>>      cpu->midr = 0x410fc240; /* r0p0 */
>>      cpu->pmsav7_dregion = 8;
>> +    /* VFPv4-SP */
>>      cpu->isar.mvfr0 = 0x10110021;
>>      cpu->isar.mvfr1 = 0x11000011;
>>      cpu->isar.mvfr2 = 0x00000000;
>> @@ -141,6 +156,7 @@ static void cortex_m7_initfn(Object *obj)
>>      set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
>>      cpu->midr = 0x411fc272; /* r1p2 */
>>      cpu->pmsav7_dregion = 8;
>> +    /* VFPv5 DP */
>>      cpu->isar.mvfr0 = 0x10110221;
>>      cpu->isar.mvfr1 = 0x12000011;
>>      cpu->isar.mvfr2 = 0x00000040;
>> @@ -173,6 +189,7 @@ static void cortex_m33_initfn(Object *obj)
>>      cpu->midr = 0x410fd213; /* r0p3 */
>>      cpu->pmsav7_dregion = 16;
>>      cpu->sau_sregion = 8;
>> +    /* VFPv5 DP */
>>      cpu->isar.mvfr0 = 0x10110021;
>>      cpu->isar.mvfr1 = 0x11000011;
>>      cpu->isar.mvfr2 = 0x00000040;
>> @@ -209,7 +226,7 @@ static void cortex_m55_initfn(Object *obj)
>>      cpu->revidr = 0;
>>      cpu->pmsav7_dregion = 16;
>>      cpu->sau_sregion = 8;
>> -    /* These are the MVFR* values for the FPU + full MVE configuration */
>> +    /* These are the MVFR* values for the FPv5-D16-M + full MVE configuration */
>>      cpu->isar.mvfr0 = 0x10110221;
>>      cpu->isar.mvfr1 = 0x12100211;
>>      cpu->isar.mvfr2 = 0x00000040;
>
>These comment additions/changes don't seem to be related to the
>Cortex-M0+. If you want to make them, put them in a
>separate commit with its own commit message saying why.

I will remove this comments, and may be send them in extra patch.

If everything is ok, I will send a V2 patch with your review.

Thanks

Matthieu


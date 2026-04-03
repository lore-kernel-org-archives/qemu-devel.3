Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3696EE85379
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 16:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8hVH-00079s-KO; Fri, 03 Apr 2026 12:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8hVE-000796-0S
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 12:36:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8hV9-0002CZ-Jj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 12:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775234124; bh=ZygCmhJ6FGimZGUaRCh/LVeW2TF2mti+4hdr6c6OXvg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ufhfyg9ZDTk9Yivc0xT+1Q4Q9/5KvV7iiKpirwH0AaBxW5FWEa1wm2tYIFvGaGZl/
 bHFvj5NGxsJFi8/PhW1387h0XesB53DJWhYtWMls5KyXuYB7kuaA/cEVWhImbW3HXC
 YpcPKaFAAJpLacpsKFpu2RNYS+Ys1tWHkVeLe/zT2Ek+rtIUF56nnBBgTh2+SUEgDX
 sefqC/5KvijR3Ne0gvpYQbATI3QwNpss7iEAusXxYrPxpUXzOK6uHNtBzWmMP6UaGf
 PFE2IoxhrZz9U6AbUN+S0OyGGg4ZMr8+bj/5ZjKtzgW2JsvM1hAJmMigNhGGGYAVPb
 GVqslENbEHyKA==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id BCE5D19A8D8;
 Fri, 03 Apr 2026 19:35:24 +0300 (MSK)
Message-ID: <7d3db657-510d-48af-be69-66b66627aff8@tls.msk.ru>
Date: Fri, 3 Apr 2026 19:36:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 5/6] qom: Restrict compat properties API to
 system emulation
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-6-mjt@tls.msk.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsFNBGYpLkcBEACsajkUXU2lngbm6RyZuCljo19q/XjZTMikctzMoJnBGVSmFV66kylUghxs
 HDQQF2YZJbnhSVt/mP6+V7gG6MKR5gYXYxLmypgu2lJdqelrtGf1XtMrobG6kuKFiD8OqV6l
 2M5iyOZT3ydIFOUX0WB/B9Lz9WcQ6zYO9Ohm92tiWWORCqhAnwZy4ua/nMZW3RgO7bM6GZKt
 /SFIorK9rVqzv40D6KNnSyeWfqf4WN3EvEOozMfWrXbEqA7kvd6ShjJoe1FzCEQ71Fj9dQHL
 DZG+44QXvN650DqEtQ4RW9ozFk3Du9u8lbrXC5cqaCIO4dx4E3zxIddqf6xFfu4Oa5cotCM6
 /4dgxDoF9udvmC36qYta+zuDsnAXrYSrut5RBb0moez/AR8HD/cs/dS360CLMrl67dpmA+XD
 7KKF+6g0RH46CD4cbj9c2egfoBOc+N5XYyr+6ejzeZNf40yjMZ9SFLrcWp4yQ7cpLsSz08lk
 a0RBKTpNWJdblviPQaLW5gair3tyJR+J1ER1UWRmKErm+Uq0VgLDBDQoFd9eqfJjCwuWZECp
 z2JUO+zBuGoKDzrDIZH2ErdcPx3oSlVC2VYOk6H4cH1CWr9Ri8i91ClivRAyVTbs67ha295B
 y4XnxIVaZU+jJzNgLvrXrkI1fTg4FJSQfN4W5BLCxT4sq8BDtwARAQABzSBNaWNoYWVsIFRv
 a2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLBlAQTAQoAPhYhBJ2L4U4/Kp3XkZko8WGtPZjs3yyO
 BQJmKS5HAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGGtPZjs3yyOZSAP
 /ibilK1gbHqEI2zR2J59Dc0tjtbByVmQ8IMh0SYU3j1jeUoku2UCgdnGKpwvLXtwZINgdl6Q
 cEaDBRX6drHLJFAi/sdgwVgdnDxaWVJO/ZIN/uJI0Tx7+FSAk8CWSa4IWUOzPNmtrDfb4z6v
 G36rppY8bTNKbX6nWFXuv2LXQr7g6+kKnbwv4QFpD+UFF1CrLm3byMq4ikdBXpZx030qBL61
 b7PrfXcBLao0357kWGH6C2Zu4wBnDUJwGi68pI5rzSRAFyAQsE89sjLdR1yFoBH8NiFnAQXP
 LA8Am9FMsC7D/bi/kwKTJdcZvzdGU1HG6tJvXLWC+nqGpJNBzRdDpjqtxNuL76vVd/JbsFMS
 JchLN+01fNQ5FHglvkd6md7vO+ULq+r9An5hMiDoRbYVUOBN8uiYNk+qKbdgSfbhsgPURqHi
 1bXkgMeMasqWbGMe7iBW/YH2ePfZ6HuKLNQDCkiWZYPQZvyXHvQHjuJJ5+US81tkqM+Q6Snq
 0L/O/LD0qLlbinHrcx0abg06VXBoYmGICJpf/3hhWQM4f+B/5w4vpl8q0B6Osz01pBUBfYak
 CiYCNHMWWVZkW9ZnY7FWiiPOu8iE1s5oPYqBljk3FNUk04SDKMF5TxL87I2nMBnVnvp0ZAuY
 k9ojiLqlhaKnZ1+zwmwmPmXzFSwlyMczPUMSzsFNBGYpLkcBEAC0mxV2j5M1x7GiXqxNVyWy
 OnlWqJkbkoyMlWFSErf+RUYlC9qVGwUihgsgEhQMg0nJiSISmU3vsNEx5j0T13pTEyWXWBdS
 XtZpNEW1lZ2DptoGg+6unpvxd2wn+dqzJqlpr4AY3vc95q4Za/NptWtSCsyJebZ7DxCCkzET
 tzbbnCjW1souCETrMy+G916w1gJkz4V1jLlRMEEoJHLrr1XKDdJRk/34AqXPKOzILlWRFK6s
 zOWa80/FNQV5cvjc2eN1HsTMFY5hjG3zOZb60WqwTisJwArjQbWKF49NLHp/6MpiSXIxF/FU
 jcVYrEk9sKHN+pERnLqIjHA8023whDWvJide7f1V9lrVcFt0zRIhZOp0IAE86E3stSJhZRhY
 xyIAx4dpDrw7EURLOhu+IXLeEJbtW89tp2Ydm7TVAt5iqBubpHpGTWV7hwPRQX2w2MBq1hCn
 K5Xx79omukJisbLqG5xUCR1RZBUfBlYnArssIZSOpdJ9wWMK+fl5gn54cs+yziUYU3Tgk0fJ
 t0DzQsgfd2JkxOEzJACjJWti2Gh3szmdgdoPEJH1Og7KeqbOu2mVCJm+2PrNlzCybOZuHOV5
 +vSarkb69qg9nU+4ZGX1m+EFLDqVUt1g0SjY6QmM5yjGBA46G3dwTEV0/u5Wh7idNT0mRg8R
 eP/62iTL55AM6QARAQABwsF8BBgBCgAmFiEEnYvhTj8qndeRmSjxYa09mOzfLI4FAmYpLkcC
 GwwFCRLMAwAACgkQYa09mOzfLI53ag/+ITb3WW9iqvbjDueV1ZHwUXYvebUEyQV7BFofaJbJ
 Sr7ek46iYdV4Jdosvq1FW+mzuzrhT+QzadEfYmLKrQV4EK7oYTyQ5hcch55eX00o+hyBHqM2
 RR/B5HGLYsuyQNv7a08dAUmmi9eAktQ29IfJi+2Y+S1okAEkWFxCUs4EE8YinCrVergB/MG5
 S7lN3XxITIaW00faKbqGtNqij3vNxua7UenN8NHNXTkrCgA+65clqYI3MGwpqkPnXIpTLGl+
 wBI5S540sIjhgrmWB0trjtUNxe9QcTGHoHtLeGX9QV5KgzNKoUNZsyqh++CPXHyvcN3OFJXm
 VUNRs/O3/b1capLdrVu+LPd6Zi7KAyWUqByPkK18+kwNUZvGsAt8WuVQF5telJ6TutfO8xqT
 FUzuTAHE+IaRU8DEnBpqv0LJ4wqqQ2MeEtodT1icXQ/5EDtM7OTH231lJCR5JxXOnWPuG6el
 YPkzzso6HT7rlapB5nulYmplJZSZ4RmE1ATZKf+wUPocDu6N10LtBNbwHWTT5NLtxNJAJAvl
 ojis6H1kRWZE/n5buyPY2NYeyWfjjrerOYt3er55n4C1I88RSCTGeejVmXWuo65QD2epvzE6
 3GgKngeVm7shlp7+d3D3+fAAHTvulQQqV3jOodz+B4yzuZ7WljkNrmrWrH8aI4uA98c=
In-Reply-To: <20260403104327.1163942-6-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.04.2026 13:43, Michael Tokarev wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Move compat properties API definitions to their own file
> unit, compile it only when system emulation is configured.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

This one breaks user-only build on a few architectures:

https://buildd.debian.org/status/fetch.php?pkg=qemu&arch=amd64&ver=1%3A11.0.0%7Erc2%2Bds-1&stamp=1775233181&raw=0
https://buildd.debian.org/status/fetch.php?pkg=qemu&arch=amd64&ver=1%3A11.0.0%7Erc2%2Bds-1&stamp=1775233181&raw=0
https://buildd.debian.org/status/fetch.php?pkg=qemu&arch=ppc64el&ver=1%3A11.0.0%7Erc2%2Bds-1&stamp=1775233277&raw=0

cc -m64  -o qemu-aarch64 libcommon.a.p/accel_accel-common.c.o 
libcommon.a.p/hw_core_cpu-common.c.o 
libcommon.a.p/hw_core_machine-smp.c.o libcommon.a.p/cpu-common.c.o 
libcommon.a.p/page-vary-common.c.o libcommon.a.p/target-info.c.o 
libcommon.a.p/disas_capstone.c.o libcommon.a.p/disas_disas-host.c.o 
libcommon.a.p/disas_disas-target.c.o libcommon.a.p/disas_objdump.c.o 
libcommon.a.p/disas_disas-common.c.o libcommon.a.p/fpu_softfloat.c.o 
libcommon.a.p/meson-generated_.._gdbstub_gdbstub-xml.c.o 
libcommon_arm.a.p/target_arm_mmuidx.c.o 
libcommon_arm.a.p/target_arm_tcg_arith_helper.c.o 
libcommon_arm.a.p/target_arm_tcg_crypto_helper.c.o 
libuser.a.p/semihosting_user.c.o libuser.a.p/semihosting_guestfd.c.o 
libuser.a.p/accel_accel-user.c.o libuser.a.p/accel_tcg_cpu-exec.c.o 
libuser.a.p/accel_tcg_cpu-exec-common.c.o 
libuser.a.p/accel_tcg_tcg-runtime.c.o 
libuser.a.p/accel_tcg_tcg-runtime-gvec.c.o 
libuser.a.p/accel_tcg_tb-maint.c.o libuser.a.p/accel_tcg_tcg-all.c.o 
libuser.a.p/accel_tcg_tcg-stats.c.o 
libuser.a.p/accel_tcg_translate-all.c.o 
libuser.a.p/accel_tcg_translator.c.o libuser.a.p/accel_tcg_user-exec.c.o 
libuser.a.p/accel_tcg_user-exec-stub.c.o 
libuser.a.p/hw_core_cpu-user.c.o libuser.a.p/hw_core_qdev-user.c.o 
libuser.a.p/gdbstub_gdbstub.c.o libuser.a.p/gdbstub_syscalls.c.o 
libuser.a.p/gdbstub_user.c.o libuser.a.p/cpu-target.c.o 
libuser.a.p/tcg_optimize.c.o libuser.a.p/tcg_region.c.o 
libuser.a.p/tcg_tcg.c.o libuser.a.p/tcg_tcg-common.c.o 
libuser.a.p/tcg_tcg-op.c.o libuser.a.p/tcg_tcg-op-ldst.c.o 
libuser.a.p/tcg_tcg-op-gvec.c.o libuser.a.p/tcg_tcg-op-vec.c.o 
libuser.a.p/tcg_perf.c.o libuser.a.p/common-user_safe-syscall.S.o 
libuser.a.p/common-user_safe-syscall-error.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_gdbstub.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_cpu.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_cpregs-gcs.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_cpregs-pmu.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_debug_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_vfp_fpscr.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_el2-stubs.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_common-semi-target.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_debug.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_hflags.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_neon_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_tlb_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_vec_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_vfp_helper.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_aarch64_cpu_loop.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_aarch64_elfload.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_aarch64_signal.c.o 
libqemu-aarch64-linux-user.a.p/target-info-stub.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_cpu64.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_gdbstub64.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_cpu32.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_gengvec.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-m-nocp.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-mve.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-neon.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-vfp.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_m_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_mve_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_op_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_cpu64.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_gengvec64.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-a64.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-sve.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_translate-sme.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_helper-a64.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_mte_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_pauth_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_sme_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_sve_helper.c.o 
libqemu-aarch64-linux-user.a.p/target_arm_tcg_vec_helper64.c.o 
libqemu-aarch64-linux-user.a.p/semihosting_syscalls.c.o 
libqemu-aarch64-linux-user.a.p/semihosting_arm-compat-semi.c.o 
libqemu-aarch64-linux-user.a.p/accel_accel-target.c.o 
libqemu-aarch64-linux-user.a.p/gdbstub_user-target.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_elfload.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_exit.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_fd-trans.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_linuxload.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_main.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_mmap.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_signal.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_strace.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_syscall.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_thunk.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_uaccess.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_uname.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_flatload.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_semihost.c.o 
libqemu-aarch64-linux-user.a.p/linux-user_aarch64_mte_user_helper.c.o 
libhwcore.a.p/hw_core_bus.c.o libhwcore.a.p/hw_core_gpio.c.o 
libhwcore.a.p/hw_core_qdev-properties.c.o libhwcore.a.p/hw_core_qdev.c.o 
libhwcore.a.p/hw_core_resetcontainer.c.o 
libhwcore.a.p/hw_core_resettable.c.o 
libhwcore.a.p/hw_core_vmstate-if.c.o libhwcore.a.p/hw_core_irq.c.o 
libhwcore.a.p/hw_core_clock.c.o libhwcore.a.p/hw_core_qdev-clock.c.o 
libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o 
libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o 
libevent-loop-base.a.p/event-loop-base.c.o -Wl,--as-needed 
-Wl,--no-undefined -pie -static-pie -fstack-protector-strong 
-Wl,-z,relro -Wl,-z,now -g -O2 -Werror=implicit-function-declaration 
'-ffile-prefix-map=/build/reproducible-path/qemu-11.0.0~rc2+ds=.' 
-fstack-protector-strong -fstack-clash-protection -Wformat 
-Werror=format-security -fcf-protection -ffile-prefix-map=../../= 
-Wdate-time -D_FORTIFY_SOURCE=2 -DPROVIDE_STUBS_FOR_STATIC -Wl,-z,relro 
-Wl,--as-needed -Wl,-Map=%.map,--no-print-map-discarded 
-Wl,--start-group libqemuutil.a /usr/lib/x86_64-linux-gnu/libcapstone.a 
/usr/lib/x86_64-linux-gnu/libz.a -lm -pthread 
/usr/lib/x86_64-linux-gnu/libglib-2.0.a 
/usr/lib/gcc/x86_64-linux-gnu/15/libatomic.a 
/usr/lib/x86_64-linux-gnu/libsysprof-capture-4.a -Wl,-z,nodelete 
/usr/lib/x86_64-linux-gnu/libpcre2-8.a -Wl,--end-group
/usr/bin/x86_64-linux-gnu-ld.bfd: 
libhwcore.a.p/hw_core_qdev-properties.c.o: in function 
`qdev_prop_set_globals':
./b/user/hw/core/qdev-properties.c:1021:(.text+0x1913): undefined 
reference to `object_apply_global_props'
/usr/bin/x86_64-linux-gnu-ld.bfd: 
./b/user/hw/core/qdev-properties.c:1021:(.text+0x194a): undefined 
reference to `object_apply_global_props'
/usr/bin/x86_64-linux-gnu-ld.bfd: libhwcore.a.p/hw_core_qdev.c.o: in 
function `device_post_init':
./b/user/hw/core/qdev.c:689:(.text+0x3ee): undefined reference to 
`object_apply_compat_props'
collect2: error: ld returned 1 exit status
[1743/1778] cc -m64  -o qemu-aarch64_be 
libcommon.a.p/accel_accel-common.c.o 
libcommon.a.p/hw_core_cpu-common.c.o 
libcommon.a.p/hw_core_machine-smp.c.o libcommon.a.p/cpu-common.c.o 
libcommon.a.p/page-vary-common.c.o libcommon.a.p/target-info.c.o 
libcommon.a.p/disas_capstone.c.o libcommon.a.p/disas_disas-host.c.o 
libcommon.a.p/disas_disas-target.c.o libcommon.a.p/disas_objdump.c.o 
libcommon.a.p/disas_disas-common.c.o libcommon.a.p/fpu_softfloat.c.o 
libcommon.a.p/meson-generated_.._gdbstub_gdbstub-xml.c.o 
libcommon_arm.a.p/target_arm_mmuidx.c.o 
libcommon_arm.a.p/target_arm_tcg_arith_helper.c.o 
libcommon_arm.a.p/target_arm_tcg_crypto_helper.c.o 
libuser.a.p/semihosting_user.c.o libuser.a.p/semihosting_guestfd.c.o 
libuser.a.p/accel_accel-user.c.o libuser.a.p/accel_tcg_cpu-exec.c.o 
libuser.a.p/accel_tcg_cpu-exec-common.c.o 
libuser.a.p/accel_tcg_tcg-runtime.c.o 
libuser.a.p/accel_tcg_tcg-runtime-gvec.c.o 
libuser.a.p/accel_tcg_tb-maint.c.o libuser.a.p/accel_tcg_tcg-all.c.o 
libuser.a.p/accel_tcg_tcg-stats.c.o 
libuser.a.p/accel_tcg_translate-all.c.o 
libuser.a.p/accel_tcg_translator.c.o libuser.a.p/accel_tcg_user-exec.c.o 
libuser.a.p/accel_tcg_user-exec-stub.c.o 
libuser.a.p/hw_core_cpu-user.c.o libuser.a.p/hw_core_qdev-user.c.o 
libuser.a.p/gdbstub_gdbstub.c.o libuser.a.p/gdbstub_syscalls.c.o 
libuser.a.p/gdbstub_user.c.o libuser.a.p/cpu-target.c.o 
libuser.a.p/tcg_optimize.c.o libuser.a.p/tcg_region.c.o 
libuser.a.p/tcg_tcg.c.o libuser.a.p/tcg_tcg-common.c.o 
libuser.a.p/tcg_tcg-op.c.o libuser.a.p/tcg_tcg-op-ldst.c.o 
libuser.a.p/tcg_tcg-op-gvec.c.o libuser.a.p/tcg_tcg-op-vec.c.o 
libuser.a.p/tcg_perf.c.o libuser.a.p/common-user_safe-syscall.S.o 
libuser.a.p/common-user_safe-syscall-error.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_gdbstub.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpu.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpregs-gcs.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpregs-pmu.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_debug_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_vfp_fpscr.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_el2-stubs.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_common-semi-target.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_debug.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_hflags.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_neon_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_tlb_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_vec_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_vfp_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_cpu_loop.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_elfload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_signal.c.o 
libqemu-aarch64_be-linux-user.a.p/target-info-stub.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpu64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_gdbstub64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_cpu32.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_gengvec.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-m-nocp.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-mve.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-neon.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-vfp.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_m_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_mve_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_op_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_cpu64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_gengvec64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-a64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-sve.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-sme.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_helper-a64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_mte_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_pauth_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_sme_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_sve_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_vec_helper64.c.o 
libqemu-aarch64_be-linux-user.a.p/semihosting_syscalls.c.o 
libqemu-aarch64_be-linux-user.a.p/semihosting_arm-compat-semi.c.o 
libqemu-aarch64_be-linux-user.a.p/accel_accel-target.c.o 
libqemu-aarch64_be-linux-user.a.p/gdbstub_user-target.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_elfload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_exit.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_fd-trans.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_linuxload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_main.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_mmap.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_signal.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_strace.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_syscall.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_thunk.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_uaccess.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_uname.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_flatload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_semihost.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_mte_user_helper.c.o 
libhwcore.a.p/hw_core_bus.c.o libhwcore.a.p/hw_core_gpio.c.o 
libhwcore.a.p/hw_core_qdev-properties.c.o libhwcore.a.p/hw_core_qdev.c.o 
libhwcore.a.p/hw_core_resetcontainer.c.o 
libhwcore.a.p/hw_core_resettable.c.o 
libhwcore.a.p/hw_core_vmstate-if.c.o libhwcore.a.p/hw_core_irq.c.o 
libhwcore.a.p/hw_core_clock.c.o libhwcore.a.p/hw_core_qdev-clock.c.o 
libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o 
libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o 
libevent-loop-base.a.p/event-loop-base.c.o -Wl,--as-needed 
-Wl,--no-undefined -pie -static-pie -fstack-protector-strong 
-Wl,-z,relro -Wl,-z,now -g -O2 -Werror=implicit-function-declaration 
'-ffile-prefix-map=/build/reproducible-path/qemu-11.0.0~rc2+ds=.' 
-fstack-protector-strong -fstack-clash-protection -Wformat 
-Werror=format-security -fcf-protection -ffile-prefix-map=../../= 
-Wdate-time -D_FORTIFY_SOURCE=2 -DPROVIDE_STUBS_FOR_STATIC -Wl,-z,relro 
-Wl,--as-needed -Wl,-Map=%.map,--no-print-map-discarded 
-Wl,--start-group libqemuutil.a /usr/lib/x86_64-linux-gnu/libcapstone.a 
/usr/lib/x86_64-linux-gnu/libz.a -lm -pthread 
/usr/lib/x86_64-linux-gnu/libglib-2.0.a 
/usr/lib/gcc/x86_64-linux-gnu/15/libatomic.a 
/usr/lib/x86_64-linux-gnu/libsysprof-capture-4.a -Wl,-z,nodelete 
/usr/lib/x86_64-linux-gnu/libpcre2-8.a -Wl,--end-group
FAILED: [code=1] qemu-aarch64_be
cc -m64  -o qemu-aarch64_be libcommon.a.p/accel_accel-common.c.o 
libcommon.a.p/hw_core_cpu-common.c.o 
libcommon.a.p/hw_core_machine-smp.c.o libcommon.a.p/cpu-common.c.o 
libcommon.a.p/page-vary-common.c.o libcommon.a.p/target-info.c.o 
libcommon.a.p/disas_capstone.c.o libcommon.a.p/disas_disas-host.c.o 
libcommon.a.p/disas_disas-target.c.o libcommon.a.p/disas_objdump.c.o 
libcommon.a.p/disas_disas-common.c.o libcommon.a.p/fpu_softfloat.c.o 
libcommon.a.p/meson-generated_.._gdbstub_gdbstub-xml.c.o 
libcommon_arm.a.p/target_arm_mmuidx.c.o 
libcommon_arm.a.p/target_arm_tcg_arith_helper.c.o 
libcommon_arm.a.p/target_arm_tcg_crypto_helper.c.o 
libuser.a.p/semihosting_user.c.o libuser.a.p/semihosting_guestfd.c.o 
libuser.a.p/accel_accel-user.c.o libuser.a.p/accel_tcg_cpu-exec.c.o 
libuser.a.p/accel_tcg_cpu-exec-common.c.o 
libuser.a.p/accel_tcg_tcg-runtime.c.o 
libuser.a.p/accel_tcg_tcg-runtime-gvec.c.o 
libuser.a.p/accel_tcg_tb-maint.c.o libuser.a.p/accel_tcg_tcg-all.c.o 
libuser.a.p/accel_tcg_tcg-stats.c.o 
libuser.a.p/accel_tcg_translate-all.c.o 
libuser.a.p/accel_tcg_translator.c.o libuser.a.p/accel_tcg_user-exec.c.o 
libuser.a.p/accel_tcg_user-exec-stub.c.o 
libuser.a.p/hw_core_cpu-user.c.o libuser.a.p/hw_core_qdev-user.c.o 
libuser.a.p/gdbstub_gdbstub.c.o libuser.a.p/gdbstub_syscalls.c.o 
libuser.a.p/gdbstub_user.c.o libuser.a.p/cpu-target.c.o 
libuser.a.p/tcg_optimize.c.o libuser.a.p/tcg_region.c.o 
libuser.a.p/tcg_tcg.c.o libuser.a.p/tcg_tcg-common.c.o 
libuser.a.p/tcg_tcg-op.c.o libuser.a.p/tcg_tcg-op-ldst.c.o 
libuser.a.p/tcg_tcg-op-gvec.c.o libuser.a.p/tcg_tcg-op-vec.c.o 
libuser.a.p/tcg_perf.c.o libuser.a.p/common-user_safe-syscall.S.o 
libuser.a.p/common-user_safe-syscall-error.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_gdbstub.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpu.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpregs-gcs.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpregs-pmu.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_debug_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_vfp_fpscr.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_el2-stubs.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_common-semi-target.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_debug.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_hflags.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_neon_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_tlb_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_vec_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_vfp_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_cpu_loop.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_elfload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_signal.c.o 
libqemu-aarch64_be-linux-user.a.p/target-info-stub.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_cpu64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_gdbstub64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_cpu32.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_gengvec.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-m-nocp.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-mve.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-neon.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-vfp.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_m_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_mve_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_op_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_cpu64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_gengvec64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-a64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-sve.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_translate-sme.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_helper-a64.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_mte_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_pauth_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_sme_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_sve_helper.c.o 
libqemu-aarch64_be-linux-user.a.p/target_arm_tcg_vec_helper64.c.o 
libqemu-aarch64_be-linux-user.a.p/semihosting_syscalls.c.o 
libqemu-aarch64_be-linux-user.a.p/semihosting_arm-compat-semi.c.o 
libqemu-aarch64_be-linux-user.a.p/accel_accel-target.c.o 
libqemu-aarch64_be-linux-user.a.p/gdbstub_user-target.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_elfload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_exit.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_fd-trans.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_linuxload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_main.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_mmap.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_signal.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_strace.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_syscall.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_thunk.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_uaccess.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_uname.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_flatload.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_semihost.c.o 
libqemu-aarch64_be-linux-user.a.p/linux-user_aarch64_mte_user_helper.c.o 
libhwcore.a.p/hw_core_bus.c.o libhwcore.a.p/hw_core_gpio.c.o 
libhwcore.a.p/hw_core_qdev-properties.c.o libhwcore.a.p/hw_core_qdev.c.o 
libhwcore.a.p/hw_core_resetcontainer.c.o 
libhwcore.a.p/hw_core_resettable.c.o 
libhwcore.a.p/hw_core_vmstate-if.c.o libhwcore.a.p/hw_core_irq.c.o 
libhwcore.a.p/hw_core_clock.c.o libhwcore.a.p/hw_core_qdev-clock.c.o 
libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o 
libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o 
libevent-loop-base.a.p/event-loop-base.c.o -Wl,--as-needed 
-Wl,--no-undefined -pie -static-pie -fstack-protector-strong 
-Wl,-z,relro -Wl,-z,now -g -O2 -Werror=implicit-function-declaration 
'-ffile-prefix-map=/build/reproducible-path/qemu-11.0.0~rc2+ds=.' 
-fstack-protector-strong -fstack-clash-protection -Wformat 
-Werror=format-security -fcf-protection -ffile-prefix-map=../../= 
-Wdate-time -D_FORTIFY_SOURCE=2 -DPROVIDE_STUBS_FOR_STATIC -Wl,-z,relro 
-Wl,--as-needed -Wl,-Map=%.map,--no-print-map-discarded 
-Wl,--start-group libqemuutil.a /usr/lib/x86_64-linux-gnu/libcapstone.a 
/usr/lib/x86_64-linux-gnu/libz.a -lm -pthread 
/usr/lib/x86_64-linux-gnu/libglib-2.0.a 
/usr/lib/gcc/x86_64-linux-gnu/15/libatomic.a 
/usr/lib/x86_64-linux-gnu/libsysprof-capture-4.a -Wl,-z,nodelete 
/usr/lib/x86_64-linux-gnu/libpcre2-8.a -Wl,--end-group
/usr/bin/x86_64-linux-gnu-ld.bfd: 
libhwcore.a.p/hw_core_qdev-properties.c.o: in function 
`qdev_prop_set_globals':
./b/user/hw/core/qdev-properties.c:1021:(.text+0x1913): undefined 
reference to `object_apply_global_props'
/usr/bin/x86_64-linux-gnu-ld.bfd: 
./b/user/hw/core/qdev-properties.c:1021:(.text+0x194a): undefined 
reference to `object_apply_global_props'
/usr/bin/x86_64-linux-gnu-ld.bfd: libhwcore.a.p/hw_core_qdev.c.o: in 
function `device_post_init':
./b/user/hw/core/qdev.c:689:(.text+0x3ee): undefined reference to 
`object_apply_compat_props'
collect2: error: ld returned 1 exit status

So apparently something else is needed here.

It looks like this patchset is a bit more difficult.

I'll dig deeper.

Thnks,

/mjt

> ---
>   qom/compat-properties.c | 116 ++++++++++++++++++++++++++++++++++++++++
>   qom/meson.build         |   3 ++
>   qom/object.c            | 100 ----------------------------------
>   3 files changed, 119 insertions(+), 100 deletions(-)
>   create mode 100644 qom/compat-properties.c
> 
> diff --git a/qom/compat-properties.c b/qom/compat-properties.c
> new file mode 100644
> index 0000000000..f8d9b0036a
> --- /dev/null
> +++ b/qom/compat-properties.c
> @@ -0,0 +1,116 @@
> +/*
> + * QEMU Object Model
> + *
> + * Copyright IBM, Corp. 2011
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/compat-properties.h"
> +#include "qom/qom-qobject.h"
> +#include "hw/core/qdev.h"
> +
> +bool object_apply_global_props(Object *obj, const GPtrArray *props,
> +                               Error **errp)
> +{
> +    int i;
> +
> +    if (!props) {
> +        return true;
> +    }
> +
> +    for (i = 0; i < props->len; i++) {
> +        GlobalProperty *p = g_ptr_array_index(props, i);
> +        Error *err = NULL;
> +
> +        if (object_dynamic_cast(obj, p->driver) == NULL) {
> +            continue;
> +        }
> +        if (p->optional && !object_property_find(obj, p->property)) {
> +            continue;
> +        }
> +        p->used = true;
> +        if (!object_property_parse(obj, p->property, p->value, &err)) {
> +            error_prepend(&err, "can't apply global %s.%s=%s: ",
> +                          p->driver, p->property, p->value);
> +            /*
> +             * If errp != NULL, propagate error and return.
> +             * If errp == NULL, report a warning, but keep going
> +             * with the remaining globals.
> +             */
> +            if (errp) {
> +                error_propagate(errp, err);
> +                return false;
> +            } else {
> +                warn_report_err(err);
> +            }
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Global property defaults
> + * Slot 0: accelerator's global property defaults
> + * Slot 1: machine's global property defaults
> + * Slot 2: global properties from legacy command line option
> + * Each is a GPtrArray of GlobalProperty.
> + * Applied in order, later entries override earlier ones.
> + */
> +static GPtrArray *object_compat_props[3];
> +
> +/*
> + * Retrieve @GPtrArray for global property defined with options
> + * other than "-global".  These are generally used for syntactic
> + * sugar and legacy command line options.
> + */
> +void object_register_sugar_prop(const char *driver, const char *prop,
> +                                const char *value, bool optional)
> +{
> +    GlobalProperty *g;
> +    if (!object_compat_props[2]) {
> +        object_compat_props[2] = g_ptr_array_new();
> +    }
> +    g = g_new0(GlobalProperty, 1);
> +    g->driver = g_strdup(driver);
> +    g->property = g_strdup(prop);
> +    g->value = g_strdup(value);
> +    g->optional = optional;
> +    g_ptr_array_add(object_compat_props[2], g);
> +}
> +
> +/*
> + * Set machine's global property defaults to @compat_props.
> + * May be called at most once.
> + */
> +void object_set_machine_compat_props(GPtrArray *compat_props)
> +{
> +    assert(!object_compat_props[1]);
> +    object_compat_props[1] = compat_props;
> +}
> +
> +/*
> + * Set accelerator's global property defaults to @compat_props.
> + * May be called at most once.
> + */
> +void object_set_accelerator_compat_props(GPtrArray *compat_props)
> +{
> +    assert(!object_compat_props[0]);
> +    object_compat_props[0] = compat_props;
> +}
> +
> +void object_apply_compat_props(Object *obj)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
> +        object_apply_global_props(obj, object_compat_props[i],
> +                                  i == 2 ? &error_fatal : &error_abort);
> +    }
> +}
> diff --git a/qom/meson.build b/qom/meson.build
> index 8192243430..bd6f4aadd7 100644
> --- a/qom/meson.build
> +++ b/qom/meson.build
> @@ -5,6 +5,9 @@ qom_ss.add(files(
>     'object_interfaces.c',
>     'qom-qobject.c',
>   ))
> +if have_system
> +  qom_ss.add(files('compat-properties.c'))
> +endif
>   
>   qmp_ss.add(files('qom-qmp-cmds.c'))
>   system_ss.add(files('qom-hmp-cmds.c'))
> diff --git a/qom/object.c b/qom/object.c
> index 838b1d2b22..f00d659ef0 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -440,106 +440,6 @@ static void object_post_init_with_type(Object *obj, TypeImpl *ti)
>       }
>   }
>   
> -bool object_apply_global_props(Object *obj, const GPtrArray *props,
> -                               Error **errp)
> -{
> -    int i;
> -
> -    if (!props) {
> -        return true;
> -    }
> -
> -    for (i = 0; i < props->len; i++) {
> -        GlobalProperty *p = g_ptr_array_index(props, i);
> -        Error *err = NULL;
> -
> -        if (object_dynamic_cast(obj, p->driver) == NULL) {
> -            continue;
> -        }
> -        if (p->optional && !object_property_find(obj, p->property)) {
> -            continue;
> -        }
> -        p->used = true;
> -        if (!object_property_parse(obj, p->property, p->value, &err)) {
> -            error_prepend(&err, "can't apply global %s.%s=%s: ",
> -                          p->driver, p->property, p->value);
> -            /*
> -             * If errp != NULL, propagate error and return.
> -             * If errp == NULL, report a warning, but keep going
> -             * with the remaining globals.
> -             */
> -            if (errp) {
> -                error_propagate(errp, err);
> -                return false;
> -            } else {
> -                warn_report_err(err);
> -            }
> -        }
> -    }
> -
> -    return true;
> -}
> -
> -/*
> - * Global property defaults
> - * Slot 0: accelerator's global property defaults
> - * Slot 1: machine's global property defaults
> - * Slot 2: global properties from legacy command line option
> - * Each is a GPtrArray of GlobalProperty.
> - * Applied in order, later entries override earlier ones.
> - */
> -static GPtrArray *object_compat_props[3];
> -
> -/*
> - * Retrieve @GPtrArray for global property defined with options
> - * other than "-global".  These are generally used for syntactic
> - * sugar and legacy command line options.
> - */
> -void object_register_sugar_prop(const char *driver, const char *prop,
> -                                const char *value, bool optional)
> -{
> -    GlobalProperty *g;
> -    if (!object_compat_props[2]) {
> -        object_compat_props[2] = g_ptr_array_new();
> -    }
> -    g = g_new0(GlobalProperty, 1);
> -    g->driver = g_strdup(driver);
> -    g->property = g_strdup(prop);
> -    g->value = g_strdup(value);
> -    g->optional = optional;
> -    g_ptr_array_add(object_compat_props[2], g);
> -}
> -
> -/*
> - * Set machine's global property defaults to @compat_props.
> - * May be called at most once.
> - */
> -void object_set_machine_compat_props(GPtrArray *compat_props)
> -{
> -    assert(!object_compat_props[1]);
> -    object_compat_props[1] = compat_props;
> -}
> -
> -/*
> - * Set accelerator's global property defaults to @compat_props.
> - * May be called at most once.
> - */
> -void object_set_accelerator_compat_props(GPtrArray *compat_props)
> -{
> -    assert(!object_compat_props[0]);
> -    object_compat_props[0] = compat_props;
> -}
> -
> -void object_apply_compat_props(Object *obj)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
> -        object_apply_global_props(obj, object_compat_props[i],
> -                                  i == 2 ? &error_fatal : &error_abort);
> -    }
> -}
> -
>   static void object_class_property_init_all(Object *obj)
>   {
>       ObjectPropertyIterator iter;



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BCDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApYb-0001By-9Y; Fri, 02 May 2025 08:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApXr-0000sx-Lt
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:31:20 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApXm-0002GQ-Ib
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:31:10 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef60e500d7so17649027b3.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746189065; x=1746793865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UniOiXHVdMdpdxGGj01tC38CGn7tbFhoDRs6dSjrA7Y=;
 b=R0iepS9UKQdXw8tyr7y19JWmwaKt808OFtxlFbWdIRFYPlon829oZUtg8093/rTlvK
 e+i+PxulfU0n8Qs3ZsxZjQDyhZjwu2MUZmd57W6ltE5/lXXjbIwrQOAxa5Q+RsHgVLCf
 2dGsVwepc3akysh1Vmll4SHlbW+vtIefgGMdYZh2+vGfDEWwpRRMYczSdrcRv9BZlUkM
 6J9C3BMrpEMJK2/F4UEu5RQCvES6MfKYEgI9fed00eIV6MJoZQuQGbJFCOaBsmsK6jft
 bqQoPx4GMgq0CSib6/QUi1pQf/3aztmNL9zPRbzar2pfFrtumjy+mqbXB4N8GUfqCels
 UARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746189065; x=1746793865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UniOiXHVdMdpdxGGj01tC38CGn7tbFhoDRs6dSjrA7Y=;
 b=stO0d3ew0LRcJOHSQJ4OB4i3WFwv49azdIN9k3e3cP4EjlIMq3HvmseKqLRA6VJYSK
 z2uuy5kC6DQoWF6Dct0MV16RgxZLe8JO1gjrhdyrklchMGcmHXqv9uFYHv1rpjgfEuqq
 WvpvvZpoH/25Pbw2z/f4Oluh9W+fB7uINEH9gAqeV9qIQvbBb0tqCx4vRCFiLOBh2NfB
 nRWmbcODiS2bg8aokJzjz39lzsEzyMSL52l0c5K+O+sEcxhcXfUDrvOTVuzQiazVRsi+
 vQNTBRJlc561lPm8hLV7jOkx5WzLj7c0Spgxjffap4p0FP8rrjcSz2d5nFEf4qt2IrS1
 XwgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA1U7G04WM7s9TpnLAjA1PdrkTeVJuMZLJNGFKE2vUdFTrQHB1OYntLc971Ifdxb8oDSrv2Ys+g91Z@nongnu.org
X-Gm-Message-State: AOJu0YyHdsmQ8brjG/tzEj9E10VSZpBARv3Bws4cuRUpZ0MvGa3RrzeO
 OFmqz9pbB6fL+XLl7PgPHF8V7J8u78o2Byz6/CBQb0lALyIsMlJ7ZgfYzL+9IX/zPTSokxdrlqh
 wL1Vr8DGav1uetE+9oLr0dFwwXWrFrRC/c8Ojkw==
X-Gm-Gg: ASbGncursd2G8IbIiAMPiMoO8I+M12y0NQ8JbyrEo36LrlxRU3JJjKuFu+MfDTbe3QX
 y/XyqVAoeio0Heh3mlbQoVX4pAkuGDiEjcWfDAxJj68B9OStDYjKliYtYtSC+se3xeou1TVRo3N
 dZ18F7dZTLY95QyTvQcxyWHBo=
X-Google-Smtp-Source: AGHT+IHuexwlRLmcmrGmxkg9t0WcF1vMGutXM5onQEt+Ugw2NIR+13ocWM1yzsSqVpwvjn5R8Bw3NJEG3/lS+tmL8Y8=
X-Received: by 2002:a05:690c:6f05:b0:706:aee5:162a with SMTP id
 00721157ae682-708cee25a85mr41459507b3.36.1746189064941; Fri, 02 May 2025
 05:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250318114222.1018200-1-peter.maydell@linaro.org>
In-Reply-To: <20250318114222.1018200-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 13:30:52 +0100
X-Gm-Features: ATxdqUGxtCzORlO3ip9FS5Eiv9af1_H6IwXBDmRTgut-LxcnH5FW_tMIugNEm_Y
Message-ID: <CAFEAcA9Dd8YRV7jL7UhjPCO003167XgbXCfRRqOdvt0kh9WU8w@mail.gmail.com>
Subject: Re: [PATCH for-10.1] target/arm/kvm: Drop support for kernels without
 KVM_ARM_PREFERRED_TARGET
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ping for code review, please?

thanks
-- PMM

On Tue, 18 Mar 2025 at 11:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Our KVM code includes backwards compatibility support for ancient
> kernels which don't support the KVM_ARM_PREFERRED_TARGET ioctl.  This
> ioctl was introduced in kernel commit 42c4e0c77ac91 in September
> 2013 and is in v3.12, so it's reasonable to assume it's present.
>
> (We already dropped support for kernels without KVM_CAP_DEVICE_CTRL,
> a feature added to the kernel in April 2013, in our commit
> 84f298ea3e; so there are only about six months' worth of kernels,
> from v3.9 to v3.11, that we don't already fail to run on and that
> this commit is dropping handling for.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/kvm_arm.h      |  7 +----
>  target/arm/arm-qmp-cmds.c |  2 +-
>  target/arm/kvm.c          | 55 ++++++---------------------------------
>  3 files changed, 10 insertions(+), 54 deletions(-)
>
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 05c3de8cd46..5f17fc2f3d5 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -97,10 +97,6 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
>  #ifdef CONFIG_KVM
>  /**
>   * kvm_arm_create_scratch_host_vcpu:
> - * @cpus_to_try: array of QEMU_KVM_ARM_TARGET_* values (terminated with
> - * QEMU_KVM_ARM_TARGET_NONE) to try as fallback if the kernel does not
> - * know the PREFERRED_TARGET ioctl. Passing NULL is the same as passing
> - * an empty array.
>   * @fdarray: filled in with kvmfd, vmfd, cpufd file descriptors in that order
>   * @init: filled in with the necessary values for creating a host
>   * vcpu. If NULL is provided, will not init the vCPU (though the cpufd
> @@ -113,8 +109,7 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
>   * Returns: true on success (and fdarray and init are filled in),
>   * false on failure (and fdarray and init are not valid).
>   */
> -bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
> -                                      int *fdarray,
> +bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>                                        struct kvm_vcpu_init *init);
>
>  /**
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 883c0a0e8cc..a1a944adb43 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -46,7 +46,7 @@ static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
>  #ifdef CONFIG_KVM
>      int fdarray[3];
>
> -    if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
>          return;
>      }
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb234..568561c6d54 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -100,8 +100,7 @@ static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
>      return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_FINALIZE, &feature);
>  }
>
> -bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
> -                                      int *fdarray,
> +bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>                                        struct kvm_vcpu_init *init)
>  {
>      int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> @@ -150,40 +149,13 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>          struct kvm_vcpu_init preferred;
>
>          ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
> -        if (!ret) {
> -            init->target = preferred.target;
> +        if (ret < 0) {
> +            goto err;
>          }
> +        init->target = preferred.target;
>      }
> -    if (ret >= 0) {
> -        ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
> -        if (ret < 0) {
> -            goto err;
> -        }
> -    } else if (cpus_to_try) {
> -        /* Old kernel which doesn't know about the
> -         * PREFERRED_TARGET ioctl: we know it will only support
> -         * creating one kind of guest CPU which is its preferred
> -         * CPU type.
> -         */
> -        struct kvm_vcpu_init try;
> -
> -        while (*cpus_to_try != QEMU_KVM_ARM_TARGET_NONE) {
> -            try.target = *cpus_to_try++;
> -            memcpy(try.features, init->features, sizeof(init->features));
> -            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
> -            if (ret >= 0) {
> -                break;
> -            }
> -        }
> -        if (ret < 0) {
> -            goto err;
> -        }
> -        init->target = try.target;
> -    } else {
> -        /* Treat a NULL cpus_to_try argument the same as an empty
> -         * list, which means we will fail the call since this must
> -         * be an old kernel which doesn't support PREFERRED_TARGET.
> -         */
> +    ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
> +    if (ret < 0) {
>          goto err;
>      }
>
> @@ -259,17 +231,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      uint64_t features = 0;
>      int err;
>
> -    /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
> -     * we know these will only support creating one kind of guest CPU,
> -     * which is its preferred CPU type. Fortunately these old kernels
> -     * support only a very limited number of CPUs.
> -     */
> -    static const uint32_t cpus_to_try[] = {
> -        KVM_ARM_TARGET_AEM_V8,
> -        KVM_ARM_TARGET_FOUNDATION_V8,
> -        KVM_ARM_TARGET_CORTEX_A57,
> -        QEMU_KVM_ARM_TARGET_NONE
> -    };
>      /*
>       * target = -1 informs kvm_arm_create_scratch_host_vcpu()
>       * to use the preferred target
> @@ -300,7 +261,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          features |= 1ULL << ARM_FEATURE_PMU;
>      }
>
> -    if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
>          return false;
>      }
>
> @@ -1835,7 +1796,7 @@ uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
>
>          probed = true;
>
> -        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, &init)) {
> +        if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
>              error_report("failed to create scratch VCPU with SVE enabled");
>              abort();
>          }
> --
> 2.43.0


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09840C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPvR-0002Ny-Ut; Thu, 18 Jul 2024 08:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUPvO-0002Mm-AB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:07:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUPvK-000092-7Q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:07:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so832211a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721304466; x=1721909266; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QS+i/qWgg92JCDQnNoCb860uCH44CrJEZk7eK6ps8uI=;
 b=rwogVxkJY0v0ba1a76fLHXz+6XcuhKbCnOA43s4cbAapRUb4gsqIRWoFdFzcHvURrq
 AeR0mR9U1tGaV6+DzWpLWAm/+1CEaac+XFwCK8jg/QQXkRyBRtOT8zlS/rgQ7o5qmpZn
 s7CkaA6uOAfysWchWCj8BP+YUtwzfqcOpfBJfphAw3+BhqMv6iaKRt4k2AZ0432mzdvo
 0RS0whKmYxqFaJuwiKTPY2CicYtnni+ht/b1XvtyCqMNEUMNOQbNkfPN9J/7ExE0KFhi
 hwl8NNlKp1KMPcgkt1j+Ty6gkgXpkGZ2af8W4JvFrnype/Vcl+1oDR1J5MyKzwXBM1zH
 SkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721304466; x=1721909266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QS+i/qWgg92JCDQnNoCb860uCH44CrJEZk7eK6ps8uI=;
 b=ngr2j/qoja31dVWNPpenG8ZEohXhtb1WgH81/ZGHiKvD6Q5yqoSBqd5Xv+4xzI1dZn
 2kO99Ot313NrUrXge9V7a0wvAnIC+J+v0C/mR6uQDAzPqxzF0cJl6/WfAyrR41PhuXeF
 bFsMQjWOhqdC9oIiXHTTgECoetqi7Aj+zCHgkolYBUkImTNPmMETxeFYSBRb3U55rJcq
 a0XoMzYSkVwBl/VfIXbVy062wfxNLS974AIdi/SmY0nMbfZAf21LIeVsmKvbSCBG3bt+
 BqzcvfETffp4aTDDDzLsiJoKcusZKWJ2McEI5CDU8+5WnUNuqULctvLG1OFrk2Jv52wH
 X8uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuL1lvmHezpBDVMv6BtoU8QKYmiDmZfMipC3BqdFL4SF6AAxEghq+DGGi5DAYpCnGQAEPU3XmKBvwOwmPmJXmraQsgtDQ=
X-Gm-Message-State: AOJu0Yy7cCeFBB3YpzADE6YkypteceRo7Q+XWnPLUFr7QlBiTyO96HkW
 LAxCG8lu9vGxPEYYoz0HAsL4OYzvQ0Vqu0QmLzDy+nlpaJZXjFxEEMP60B0f4coa8c0k47752wB
 KIgh8YTKbxqAzJWqtSSn3tOH6URG/KVUvqfFDoA==
X-Google-Smtp-Source: AGHT+IHFGt0xHYBCKTNuSvjJPRvjtTalXNDkcWMmH3r0U3DrU1aS/tKuOudUHiM1VD3JpXP+axxgH3tmtyttyMWxLkQ=
X-Received: by 2002:a05:6402:430a:b0:57c:a77d:a61e with SMTP id
 4fb4d7f45d1cf-5a05b22a336mr4519482a12.7.1721304466515; Thu, 18 Jul 2024
 05:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <20240716-pmu-v3-2-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-2-8c7c1858a227@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 13:07:35 +0100
Message-ID: <CAFEAcA8tFtdpCQobU9ytzxvf3_y3DiA1TwNq8fWgFUtCUYT4hQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] target/arm/kvm: Fix PMU feature bit early
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm_arm_get_host_cpu_features() used to add the PMU feature
> unconditionally, and kvm_arch_init_vcpu() removed it when it is actually
> not available. Conditionally add the PMU feature in
> kvm_arm_get_host_cpu_features() to save code.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/kvm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 70f79eda33cd..849e2e21b304 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      if (kvm_arm_pmu_supported()) {
>          init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>          pmu_supported = true;
> +        features |= 1ULL << ARM_FEATURE_PMU;
>      }
>
>      if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
> @@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      features |= 1ULL << ARM_FEATURE_V8;
>      features |= 1ULL << ARM_FEATURE_NEON;
>      features |= 1ULL << ARM_FEATURE_AARCH64;
> -    features |= 1ULL << ARM_FEATURE_PMU;
>      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>
>      ahcf->features = features;
> @@ -1888,13 +1888,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>      }
> -    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
> -        cpu->has_pmu = false;
> -    }
>      if (cpu->has_pmu) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
> -    } else {
> -        env->features &= ~(1ULL << ARM_FEATURE_PMU);
>      }
>      if (cpu_isar_feature(aa64_sve, cpu)) {
>          assert(kvm_arm_sve_supported());

Not every KVM CPU is necessarily the "host" CPU type.
The "cortex-a57" and "cortex-a53" CPU types will work if you
happen to be on a host of that CPU type, and they don't go
through kvm_arm_get_host_cpu_features().

(Also, at some point in the future we're probably going to
want to support "tell the guest it has CPU type X via the
ID registers even when the host is CPU type Y". It seems
plausible that in that case also we'll end up wanting this
there too. But I don't put much weight on this because there's
probably a bunch of things we'll need to fix up if and when
we eventually try to implement this.)

thanks
-- PMM


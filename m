Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3560A6F7B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kBtzMLMU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMjvb-0005lr-6O; Fri, 30 Oct 2026 06:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjvZ-0005lR-4R
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:33:41 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjvX-0006Uz-7u
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:33:40 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso4685617b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793356418; cv=none;
 d=google.com; s=arc-20260327;
 b=NyC5ZVyZyV3Jr0b8E0Kl3QSnmplvnBMEM5LFOiVwSwBaqPqlYOqxyizbzNni2ryLBs
 yWqf+8VbZjvuPGNWdgO7wGGVRzTz2XJoJLH9cAIu+KuRGCqa1LHpcR1uZxKOu8RWk9lH
 eAZwVfe6iKt7Yo878bJeSCN2rm4FntmFPql2eNKMquG3e+ZL6zZeddvwwIvKCHc91Kf2
 1GDk8jd37228z13IAksXfXDzgf8LMGov4x8VhMs2glxfi4z4s5PhNcOOpw50iwFciMgN
 vpwIL8RqfzMZFq78JNoIF9xLf1nrDZt73A/ASbl15VV30tzcOrF5lz0MYJxg47erVDys
 Hneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RqxMkiKAT+i3Znypo/JSv251103/vMVoMoahZCq0plg=;
 fh=jJIJQh/XanegZOFeos895/3XHVYNIb15PvJzZ/vMKyo=;
 b=Vk6QmjSu8NLR7WLl00ZTMhwD2f6b8RDJj0VfXHAXE921CBDu1AgGHYlRSBG49RTRwg
 4AX1BRsU4AqfTDCjbqdkl1h4rcRU29bBlVzyI55EEroUiwIYeDg0x2QmicROnG2kQfnZ
 2Ru22PSFE9H7mhFKtcHfP9Qta+vxYrljUIzeZ95gC0eG0GinBQPWzq1RM7Uo1utGwz3+
 f3wPNwVYyTYnVubGmqjyscErGX3G34eTg3yDLEXs3bhuFmyubiv3K+M+4HgEfWWPnfCt
 aphs9XxomNvQDBLylk+jaMON5/e2ZiAWmX9P/MzKN3IBxypYfbr/2bFddTZTOXkZpc2M
 3mYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793356418; x=1793961218; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RqxMkiKAT+i3Znypo/JSv251103/vMVoMoahZCq0plg=;
 b=kBtzMLMUekUJ/ZqOGeE2lhag5WjwE4V9YCzt+OrQNlWqgWXKWqIGS6wm4QL2iPzdAp
 H0+LhF0BB331x6GMM4wHm9vy4uVuFC8smbXthnFp98+O67EAWCrCS4ugy1NTP6TBhVSs
 8FhakPZDJ9F+B4WxKe0KmK9rlhB0p723VikamFZC34LQ745D+soP/x4C98nwJHG822cH
 6nYiwHmB8FJE2VBhs+p+sa1s1Bzj+KyHtMD3uSFl0FZYSuf6ZR3WwaWTLnGDcVFgDbNQ
 NW8VIVgON2xainM3OLIS+NUYNMw9jv8WcMfc7n83et4IP2rrxP9H9sOrVxUG8yBDgZAi
 3g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356418; x=1793961218;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RqxMkiKAT+i3Znypo/JSv251103/vMVoMoahZCq0plg=;
 b=v1FOfNQ7pTRG2BCVCAp5zG9OcZRgZnXGoyzyUIWxwc32Cg0WnJxUXrOP4/ZN/iTfDf
 tkYyPBtgKNdW0TswGoJmRyV9r3+TIMNZmeEQ1q1RIKvv/eojb/0nFpu9j38o+A0MiZtu
 ts7R+sggTdg9CS3EvoP7yDQ3AVUQQLHLdf6kwBHGxB7xbGuzf4NeNlo7ldwBNucTsQHw
 8hsr2KJfeijJl9aln9O3m7+Z7khog11eqotZiTVvWY7xPlqiWPztTPAkaRa7+PNbqLMy
 p9aMtT6igB3HaERg51X3tnGnSyfGpYLnlI9DyHZGVm2b/U9WyrMND7uBBDRMn8+dV0Iw
 x8GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMMkyqLpIoBks7U1x5EtQSjdvUymehQ8tgi5OUy3SjvZ/PwcQb7ttHp8+Iu12W8G+PT+PpJLksVSRD@nongnu.org
X-Gm-Message-State: AFq9FYJihKCpB2yAMJ+Vdmnlzln/Lz66Wpe4QCPxZam7M83Stbs3bbdi
 er9N1ioy1NG0TeNXqEkLjfqG8sCaayUkR4tPA1a/btpp5C6eyHrj3wN97IyP5b2b7W5oex0oi4A
 +RyXPdF1wNJ8j+q1dP61IvKWpPj//2P/moAUkChFopg==
X-Gm-Gg: AYBFou1I6/tbYLR2rS6PPX4VKzrqiSkT/gc15O9AZI2qza3VhVXemELBjDKOx/D8y+m
 Dnn2kyJcXLPmxA5GJMxedtA+o+O6LG4WCaU6HVI2l1oLj31oOwiixjTqw+v26blf8Z+T4iNs6Wy
 h1+His3jooI3CZFopuSt/P6yoTJls3qOHGTfcYrQQZp+MWbQXhVrJXL6ZrrNmFHqgTcD13o/R98
 8GGyRfIRYaYaTkM+G7CwF2Y2pBEim+0QwcrGS5+xeMNXov3Rc3+uPI8bsna1ig5o+Kn7x0/a9qE
 TZnuxIDePDpLuvSAltVoWmZK8qP+9Ols//w3zsCljcznZS1920dThjaNCuvGZabl+8oTYhkapPQ
 CHQ3WDE4flxerpn15s5Ev/1kk3PPxKozgcaNYA5HzON4wq9VJvYvPcjB9fsluhc4gwDCRcOZI7t
 jgVOUT8k/sd0zzfEjijb/v
X-Received: by 2002:a05:690c:2001:b0:8a3:7828:58b3 with SMTP id
 00721157ae682-8b2b65983e1mr11034107b3.7.1793356417347; Fri, 30 Oct 2026
 03:33:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030072956.402425-1-eric.auger@redhat.com>
 <20261030072956.402425-10-eric.auger@redhat.com>
In-Reply-To: <20261030072956.402425-10-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 10:33:24 +0000
X-Gm-Features: AclHuK9-iAaXWmQGLEeiGDDoIDiP7_kjI2XNUGRoVwgQtYV9L7oNT3K5TZSqWyo
Message-ID: <CAFEAcA8R=m2a8HU5nMxXeNDCV2Fk3D+TsaQ4qphsp5Hm4rPgJA@mail.gmail.com>
Subject: Re: [PATCH v3 for-11.2 09/10] target/arm: Directly store cpu probe
 failure error
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com, 
 mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 07:31, Eric Auger <eric.auger@redhat.com> wrote:
>
> In case *_arm_host_cpu_features() fails, we currently
> record that state in cpu->host_cpu_probe_failed to later
> report the error on realize().
>
> Replace the boolean by an error handle to allow
> more precise error reports.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h           |  5 +++--
>  target/arm/cpu.c           |  9 +++++----
>  target/arm/hvf/hvf.c       |  3 ++-
>  target/arm/kvm.c           | 24 +++++++++++-------------
>  target/arm/whpx/whpx-all.c |  3 ++-
>  5 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5c5f551dac..dae79539b5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1075,10 +1075,11 @@ struct ArchCPU {
>      /* Uniprocessor system with MP extensions */
>      bool mp_is_up;
>
> -    /* True if we tried kvm_arm_host_cpu_features() during CPU instance_init
> +    /*
> +     * Set if we tried *_set_cpu_features_from_host() during CPU instance_init
>       * and the probe failed (so we need to report the error in realize)
>       */
> -    bool host_cpu_probe_failed;
> +    Error *host_cpu_probe_err;
>
>      /* QOM property to indicate we should use the back-compat CNTFRQ default */
>      bool backcompat_cntfrq;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index aba45b66f8..67d48ebc07 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1838,12 +1838,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>       * then it's possible that might have failed in the initfn, but
>       * this is the first point where we can report it.
>       */
> -    if (cpu->host_cpu_probe_failed) {
> +    if (cpu->host_cpu_probe_err) {
>          if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
> -            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
> -        } else {
> -            error_setg(errp, "Failed to retrieve host CPU features");
> +            error_append_hint(&cpu->host_cpu_probe_err,
> +                              "The 'host' CPU type can only be used with KVM, HVF or WHPX\n");

I don't think we should be doing this as error_append_hint(). If
the accelerator isn't one that supports 'host' then "host
can only be used with KVM, HVF or WHPX" is the entire and
correct thing to report to the user, and whatever specifically
might have been the trigger for us to notice this is irrelevant.

>          }
> +        error_propagate(errp, cpu->host_cpu_probe_err);
> +        cpu->host_cpu_probe_err = NULL;
>          return;
>      }

Don't we also need to free the Error in finalize, to catch the case
where we did "instance_init -> finalize" and don't get here ?


> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 4b947e9ba5..2f2a46644d 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1287,7 +1287,8 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
>               * We can't report this error yet, so flag that we need to
>               * in arm_cpu_realizefn().
>               */
> -            cpu->host_cpu_probe_failed = true;
> +            error_setg(&cpu->host_cpu_probe_err,
> +                       "failed to retrieve host CPU features");
>              return;
>          }
>      }
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4b20c5dc2..fc9551411e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -312,7 +312,7 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
>      return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
>  }
>
> -static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> +static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  {
>      /* Identify the feature bits corresponding to the host CPU, and
>       * fill out the ARMHostCPUClass fields accordingly. To do this
> @@ -330,7 +330,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      ahcf->dtb_compatible = "arm,armv8";
>
>      if (!kvm_enabled()) {
> -        return;
> +        return false;
>      }
>
>      /*
> @@ -372,7 +372,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      }
>
>      if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
> -        return;
> +        return false;
>      }
>
>      int fd = fdarray[2];
> @@ -502,7 +502,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      kvm_arm_destroy_scratch_host_vcpu(fdarray);
>
>      if (err < 0) {
> -        return;
> +        return false;
>      }
>
>      /*
> @@ -521,27 +521,25 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>
>      ahcf->target = init.target;
>      ahcf->features = features;
> +    return true;
>  }

I don't think you need to change the return type of this function
and introduce a static probe_ok variable in the caller. The
thing that tells you that the probe succeeded is that it set
ahcf->target to something other than QEMU_KVM_ARM_TARGET_NONE,
which it only does right at the very end when it has definitely
succeeded.

(It is a bit obscure that the contract between kvm_arm_get_host_cpu_features()
and its caller is "ahcf->dtb_compatible NULL means we haven't tried a
probe yet; ahcf->kvm_target still TARGET_NONE after probe means the
probe failed". We could probably add a comment about this, but that's
separate from what this patch is doing.)

>  void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>  {
>      CPUARMState *env = &cpu->env;
> +    static bool probe_ok;
>
>      if (!arm_host_cpu_features.dtb_compatible) {
> -        kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
> +        probe_ok = kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
>      }
>
> -    cpu->kvm_target = arm_host_cpu_features.target;
> -
> -    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
> -        /*
> -         * We can't report this error yet, so flag that we need to
> -         * in arm_cpu_realizefn().
> -         */
> -        cpu->host_cpu_probe_failed = true;
> +    if (!probe_ok) {
> +        error_setg(&cpu->host_cpu_probe_err,
> +                   "failed to retrieve host CPU features");
>          return;
>      }
>
> +    cpu->kvm_target = arm_host_cpu_features.target;
>      cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
>      cpu->isar = arm_host_cpu_features.isar;
>      cpu->sve_vq.supported = arm_host_cpu_features.sve_vq_supported;


-- PMM


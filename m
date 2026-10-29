Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A61606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HbRe3J/7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRGK-0006D4-By; Thu, 29 Oct 2026 10:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMRGI-0006CN-O5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:37:50 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMRGG-0007Me-SX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:37:50 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ac525c1f05so23341557b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284667; cv=none;
 d=google.com; s=arc-20260327;
 b=I3lAYYuc83o7ChSD5lfGFC8g0lNJAcDmXHB8yz/okTv87Ebclyw9LU/q4U0eQa5HHB
 i9m3FZtrtcquUmmOzHYINwXv7WJ+iaIiTMqcfeBvXEA4Mw3wP/OTGqhzTaoeHqxwRGGr
 k8E7sr4FbEkWGl2JaJVnx39Wn4FFMPCWToeLHxbv7kyo8c+HeO1LyCYgH02V8ittodF5
 Pc3kuceUl5pDcD/GuPkmjRrjy/Y0mR9k7V4iNxWbar++N0IKrFbgHwaFfOqwPGY9+n5U
 bguEzc1mCcRci1NaBsBsKu7i2s9357MN9jO6k1foZIs/hKeJoUrbyd9D9ggZTNa0OCSi
 SWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EJu8JaOtMVyjxhYmH6az1U+IMB+/mqpM4Q2vtHCT9mc=;
 fh=46hDf80j3FbQN4qeuje8XZdDFGXnUDZ7Qyjv+ZVNNpU=;
 b=NLBoyRLpgnUEHR9Lao0GhXQEPiGViWDVgH7oLJ7WgvhRLQ/+J8jFT+whJnJfzL4AxB
 tFFZOV3GOy7apsSt8QGAylqKVtiQTKChH93rJ5p1DPl4pskCvUryQ5g6v52MhBMIHKq7
 SrqyEXmWmj2rqQrJNdLo9fpL7NS5OFL8EBWcnhA9MY/gtAoioNXB79IkAAcoc7kz8UFl
 nAKvqSy6Szb3P5mlgamNNVxLlA9yrASzbtHrjT33TvMVY33Gxz2oUHnmLQi9uPU97pyQ
 OZOJiDT4y81ZrEy5ZsMzZDXpbHvcZpeCri438bMgUZDOqExcLbgtYqsptOqcE1XdHJOT
 w1hw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793284667; x=1793889467; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EJu8JaOtMVyjxhYmH6az1U+IMB+/mqpM4Q2vtHCT9mc=;
 b=HbRe3J/7Yrki0e2/C6KQm+WyKzFpB3vhHtuGYKmHpRZLiNh2mMZ1EIYgVU/o6I8nG/
 yJrKrSprIXHnoEllV4FAhbL+wwGA02K/gqnXKLCx8IKZDIih4y2tGQcdVS2AIuDrZ1ve
 zmS6vsfrACc907jq1BhqdseLQojPesmjL/ErJ2A7jtzN4/IdZJV1PxPKHAch3RF1zSpp
 8v+TA2fu1GFGxrJr+rjfgchztK2gZNiawS390wmc23vMi4fTO913JRMA25LEI1GwrXwO
 Fd43QHYlNZcjCzqIVEr6q97245Czxb3SfI32Uy56PSQAIQQwPNZXd77tYe6Rpuz/pQo4
 cuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793284667; x=1793889467;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EJu8JaOtMVyjxhYmH6az1U+IMB+/mqpM4Q2vtHCT9mc=;
 b=aqCrRiZIsFaagxTI/iz6vas5lMlAxLKlpUgBgoN8djmz8jnP0nCbLC8JaZPUJ8TwTZ
 8FUcenif9mf/1jfmIXN5Lg8p6FkOxAlTGJBiwJTlj837fOv9sGapVNhYXKz4x0u9jpqn
 kbbV7Kvf9rDkbH3rHtUZd4vl7tmiRG1EX+h90x4C8s+iSRhqr/LwjMYZ5sUJCfAgEM3k
 txs1rhvooM4LHT0pWQSNw9mbt70i8JdzuksrUYe5x+STmVB1lH2OlexGrKlgSPSF7ovV
 ipkzEL/SPS9E3o2kqHA1P9n0X3Vkt2IQjuq1tG5KXKs0Nz2q0YPtA5hMG4kZhEnn/s5S
 1ODg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhSmAiXpkUX+nJAZBHwDvxREHc2LnbFV3ldsaRUg+6WUsEUHxhpKPGUUPF+ZeeBaFu0UGlwLte3+/g@nongnu.org
X-Gm-Message-State: AFq9FYK5XhB/tR0Jn1vpLITe2c2h2ZFr/fkssM7XJTqF7qqhv8zr8ToL
 +Fa1V53eNbCOoBO/7cY3zENrdik0J2MR+M76XaDqCfwC4Cfta9HFX2lkIaZgmQSfWeH0zU27U/g
 wcY3MkY8iSEOI9NcvtuLHq7UPXpu7hbcUFW8EolrDjw==
X-Gm-Gg: AYBFou1H3Sv4umes/l4UryzKqWAdiwlEcbW5Pjl835IQ9LI2wpzQbBbdmgN5Jm5pnmE
 6ixZppDkCJ60ZPlwJ21EhGcrPYTAd6cMyOwXl6skweoj07PzrqYNoQKrPb5EtEaJpk+SXY3U7hU
 GwlZhGYi2B3vM0gMb1VFxbGgcUNwRgxuHwZoioh2b1uifkKM0AJ/bAlAF0fCROGHQNnLH5pGrc5
 LjzEyadt7uK8HHmcBPSBRG8eHQ3qG9/jz73mtfAvtmo0rX9y0hezKDp+ROBI8ZGey63vp7lToK3
 PckDAjOL1qckXPnUTkCYhu+bCJuRNnMEclYdYa4GcWKldWm8mlTYKzenCZm2Gb2RAMTrwk4yFdy
 vZhh6yefeNbRQg2lC4cLLoBZNyJCS8+dOjE9Z2iEq/EnluN045qgzkvosQ6+i6W3Gi1QX9ZuPFf
 XcggBD0Q35LZRYnuX4dyvwwJ0Bzi0tnANHuzce6N8fmA==
X-Received: by 2002:a05:690c:4dc5:20b0:88e:edf8:e375 with SMTP id
 00721157ae682-8b1b599b9a9mr35676977b3.5.1793284667333; Thu, 29 Oct 2026
 07:37:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-6-eric.auger@redhat.com>
In-Reply-To: <20261029092307.281287-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 14:37:35 +0000
X-Gm-Features: AclHuK8kyLtiydSZILjWZ_u10MgbnyFmTUzVOtrq1CQu5UG3yEW5DFvGmmRXkcM
Message-ID: <CAFEAcA-v2s39f5n0b+9ZD4QHd5irxUwqzUfsYUb8x0GTqU_z4Q@mail.gmail.com>
Subject: Re: [PATCH for-11.2 5/9] target/arm/kvm: Pass an error handle to
 kvm_arm_create_scratch_host_vcpu
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 29 Oct 2026 at 09:23, Eric Auger <eric.auger@redhat.com> wrote:
>
> This allows to report a precise error message if any error occurs.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>



> @@ -371,7 +377,8 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          features |= 1ULL << ARM_FEATURE_PMU;
>      }
>
> -    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, &local_err)) {
> +        error_report_err(local_err);
>          return;
>      }

This isn't supposed to report an error here. The caller of
this function is kvm_arm_set_cpu_features_from_host(), which
sets cpu->host_cpu_probe_failed for any failures. That is
later checked by arm_cpu_realizefn(), which reports either
that you didn't use an accelerator type you should have or else
the rather vague "Failed to retrieve host CPU features".

If you want to make that more specific, I think you need to save
that more specific error information instead of the plain
boolean host_cpu_probe_failed, so you have it in arm_cpu_realizefn
where you can report it up.

> @@ -2653,8 +2660,10 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
>  void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
>  {
>      int fdarray[3];
> +    Error *local_err = NULL;
>
> -    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL, &local_err)) {
> +        error_report_err(local_err);
>          return;
>      }

The only caller of arm_gic_cap_kvm_probe() is qmp_query_gic_capabilities(),
which has an Error parameter. So here we should be passing the error
up to it to report, not reporting it locally.

thanks
-- PMM


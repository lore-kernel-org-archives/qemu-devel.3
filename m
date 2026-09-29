Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9605ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfGB-0007ti-6Z; Tue, 29 Sep 2026 17:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3viu8agsKCmMDPMUPOMFXJTHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--coltonlewis.bounces.google.com>)
 id 1xBfG7-0007sO-L3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:21:07 -0400
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3viu8agsKCmMDPMUPOMFXJTHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--coltonlewis.bounces.google.com>)
 id 1xBfG5-0003VX-VN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:21:07 -0400
Received: by mail-oi1-x246.google.com with SMTP id
 5614622812f47-4b28dbf4197so8423960b6e.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790716863; x=1791321663; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lDp8WWU/0UlLYBNjAv5MLJXqSdTj0yxp/bLRhzLI/Qc=;
 b=jQEDAs3cxDpfwO9zRj9JugkkBJMVlfW0IYXyBKNLRPfinJMBiamFzEn2myAwuBe7Zx
 wX/iafscwhjxJYIaeFKIn//wQXa0qd32bZa6ydc17+wAIAloC2lVEGO86rlaQ/VzVhq5
 x6ALiL+xWYw2HFbJRNjWEi28S9pCd4ZYcaDxJ+zouZOVTfcw8D78A+AmVLLUpqHHsG1r
 i7/SoBGX2kHsFmBhmeu2HEdh3eQwm+kuuCi1XQJobd6WCPUvEmR5agTUYMh+xcsd2dPO
 5falTG0XGAUSOZy7WgCsq8fW1hmlWvngroGg7INIXduefWmcENPohvaFDVTl6V6RXsxq
 SQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790716863; x=1791321663;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lDp8WWU/0UlLYBNjAv5MLJXqSdTj0yxp/bLRhzLI/Qc=;
 b=RX+IvmknvazPhTnjUQmLqTHBb5XrsTvggxJv6tBq9ktpTCMpdyB+Un9vNY6atv5z6h
 Jn7QbHLzgxLHxTPH1gWBm83LnixsLh5TX+wIMIe+rWJYaLlJkdKLqXiV16JUHl+H/TTE
 ctYDQXvGGs4IbwuTkBdsesotFSi0nmW6h+WyxcfHERjdnlM+XUiAFRoqS6Xjv0aocdhu
 Brv9P76V084JFWY1NPB4j6EzNtHVXuoqijfchRnTMm66Mb90kAyXull+gxPcBGgQR1Rk
 BHLxnqB/5di+X2h+1k8wu/Yi2P6xqav6SQZ2ImsVnGwYR4t6KIbR2QPU0Lv51JLSQiaV
 2/Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKrLZs860W/FDrqHfwBls1pgX9K0+XzP6chA/mq0EW4Pk7iMU4THcY9lKXU3bTJbXDZh/3I+cPEVHO@nongnu.org
X-Gm-Message-State: AFuF++mwPMJd6CmKWkKTOMWP+SSS6Fm6zhILAKsNFIlSPoUJczUNayjZ
 JxSaT/U0XLFLzsjgNXKz7UR4jsuy+u0jX+0Pbs3nvl1OmYgBJ8pKqU0RPSRcTvhpXU/mav4MARM
 gFmACcIxwr7sGe7bmdthpaH1NtQ==
X-Received: from ioia10.prod.google.com ([2002:a05:6602:888a:b0:9c4:b6b4:bf53])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f21:b0:4bc:336d:7494 with SMTP id
 5614622812f47-4f0751c3a87mr763966b6e.30.1790716862759; 
 Tue, 29 Sep 2026 14:21:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 21:21:02 +0000
In-Reply-To: <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924173051.2117637-1-coltonlewis@google.com>
 <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929212102.3659389-1-coltonlewis@google.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
From: Colton Lewis <coltonlewis@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mingwei Zhang <mizhang@google.com>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::246;
 envelope-from=3viu8agsKCmMDPMUPOMFXJTHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--coltonlewis.bounces.google.com;
 helo=mail-oi1-x246.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter,

Thanks for reviewing!

On Mon, Sep 28, 2026 at 03:01:32PM +0100, Peter Maydell wrote:
> FYI for next time around, QEMU patches that depend on not-yet-accepted
> kernel ABI changes should be tagged RFC, please.

Ack, sorry about that. I will tag future versions with RFC until the
kernel uAPI is accepted.

> > ---
> >  target/arm/cpu.c | 20 ++++++++++++++++++++
> >  target/arm/cpu.h |  4 ++++
> >  target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
>
> New CPU properties should be documented in docs/system/arm/cpu-features.rst .

Will document them there in the next revision.

> > +static bool arm_get_pmu_partition(Object *obj, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    return cpu->kvm_pmu_partition;
> > +}
> > +
> > +static void arm_set_pmu_partition(Object *obj, bool value, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    cpu->kvm_pmu_partition = value;
> > +}
>
> If your getter/setter are only updating the struct field,
> you can use a DEFINE_PROP_BOOL to avoid having to have them
> (compare arm_cpu_has_el2_property etc.)

Thanks, I will switch to DEFINE_PROP_BOOL.

> >      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> >          cpu->has_pmu = true;
> >          object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> > +        object_property_add_bool(obj, "pmu-partition",
> > +                                 arm_get_pmu_partition,
> > +                                 arm_set_pmu_partition);
> > +        object_property_add_uint32_ptr(obj, "pmu-num-counters",
> > +                                       &cpu->kvm_pmu_nr_counters,
> > +                                       OBJ_PROP_FLAG_READWRITE);
>
> What should we do with these properties if we're not using KVM
> (i.e. for TCG, hvf, etc) ?

PMU partitioning is specific to KVM, so moving it into
kvm_arm_add_vcpu_properties() (which is only called when kvm_enabled())
and naming it "kvm-pmu-partition" per the KVM VCPU Features convention
in docs/system/arm/cpu-features.rst seems to make the most sense.

For the counter limit property, would you prefer that it also live in
kvm_arm_add_vcpu_properties() as "kvm-pmu-num-counters" (KVM-only), or
keep "pmu-num-counters" general so TCG can also use it to override
PMCR_EL0.N in reset_pmcr_el0?

Thanks,
Colton


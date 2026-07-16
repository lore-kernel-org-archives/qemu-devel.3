Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E5AC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkT6D-0002nG-LF; Thu, 16 Jul 2026 16:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wkT6B-0002mf-Ap
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 16:54:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wkT69-0000M4-II
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 16:54:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso3969504b3a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784235263; x=1784840063; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BJzIIFDdDzqLtCWmyUzRxr6o/+lBrb/0M6xgQK1DoGI=;
 b=bPDPIAmR9rEJlPKpOYkxTaAVklorxwjEONIU1WO3hlUY8M3CrYkNO/FS9qi9SW3YW4
 dIC+NHisosWU+h/raqTD+n+GIi6E8PFWyOw4AwkePZWD769d9K3imDhRaQRc+9rF8gQu
 x/MUaULe9XfPk8jRU/is7ePFSlxfFvn7k82oXPhipQxIki5s+IgkbuhB9cRI17+YhEN6
 IqMF0jCzJvLm3daLkrDQqEo5oZcwb/NeWKog3DjtqHU4k1zSbQervpxIzjpkjCykYqZp
 nWk+hlJGZwqM5ectyLMpJLafAnSzNRjezcFl/e3Mb2CmgVLkqSPziPh9x7F6ANp52bLi
 /TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784235263; x=1784840063;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BJzIIFDdDzqLtCWmyUzRxr6o/+lBrb/0M6xgQK1DoGI=;
 b=n3ax9bCO1XMd0nBzyb+99fZ/oQbhR8CrZxX26TkXGAXhPpDhqAaOXw7lnrTUxTLMiU
 J8vjO2lWQ/9iBt2jK8Fy06lRYfTUN43fFeFzP1weiUc+BuncF2lDgt277/C38dSRnR2F
 GsKmIUBdgRHkYUdZEuPmVKcGfaYd+dIRiX79iKcluM0MHjBIy7HGnn36jdKQvSsUrqfQ
 LGmJiUcRZwWXLaTvCyQglr8lRhuNr5ObTVKUXQuE1yZNyztSzIi+55Y9nKJ+v/cEpWWB
 NpDcGeaZFWpVjoW67CUIIElY6CDTtkgTt8EN7EgGXEuHQxCxZFev4V3yQgkWxpWegm3u
 dGcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RotqnzKAKO2BFh5PbbfpzIp1yl7dDe5+CVziLCtPuz6x3DA5EpKUYdWDG191XHsuTpKrJDNqgLjekLB@nongnu.org
X-Gm-Message-State: AOJu0Ywt99nUKP+db3SI14pMb5NgRI30AXtPaIvKrGtS4XBHljXgGa8d
 ZkwNbUD5NxxneQmxmOM7HPWH2Mugcz3diyRPsO61PUgWUwdqcgjD/rU5qKKLe1O+GjE=
X-Gm-Gg: AfdE7cmWlxT+Ej2xcnBr3ts7Qo9cp+s1qkVs6x1JgAG5kjHL/ip+clUdK0/HViECXwZ
 zVNmB5IcVFrDiOJl3Z3HY0N4fH0Rrbvuz5fMv4nXbMMwkablmYYH1WQBG3cxYmeadWbDL76J+Yg
 NM/CoF82OXVYaErf8LcmGb/I/i0POeRY0Rj4lcUAb4/oUwtlQh3dLFZH9TbFMczTjAxnbk3taYz
 0nFpF97wWME11tD0Z+YX44dIjv+DsBs6FfdCJ+8Wdx4a2vhjRrOIUAVsX2ISbzD0K8K1GzGvPVk
 oco0TwsSdIN37qvEPwaKA6w+DkrBfLppjUE6b16D2xqguV5tl9lFFTSoUG1PPA8/GyAlZFpX69u
 93i5wE0gUQBSZGbYVXfT3lBUvzkGx8i1rmsBVxj3sM2x+W8Y51D2EOPhCzlEY8b7ZDWhkMN2wW0
 DU3n5g1g==
X-Received: by 2002:a05:6a00:1808:b0:848:6698:2d5a with SMTP id
 d2e1a72fcca58-84a6726c042mr7950638b3a.20.1784235263350; 
 Thu, 16 Jul 2026 13:54:23 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc13:5578:20b0:9bee])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb258eb856dsm2492407a12.6.2026.07.16.13.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:54:22 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:54:20 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 08/25] target/arm/kvm: Use kvm_vm_check_extension()
 where necessary
Message-ID: <allE_PUn5T4FRTXr@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-9-mathieu.poirier@linaro.org>
 <3ac5a5b7-e41d-499e-a4d2-e9a5a78f8c0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac5a5b7-e41d-499e-a4d2-e9a5a78f8c0c@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 13, 2026 at 10:43:37AM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > The Arm KVM code can return different values from KVM_CHECK_EXTENSION
> > depending on the VM type. Use kvm_vm_check_extension() where necessary
> > to ensure we get the right response from KVM.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> 
> I'm putting a note here so that we won't forget. The following changes are needed
> so that capability KVM_CAP_ARM_NISV_TO_USER won't be enabled for realm guest since
> it has been hidden from the realm guest in (v14) host series.
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 3d5e16a21c..4c52ee7e1b 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -623,7 +623,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          return -EINVAL;
>      }
> -    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> +    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {

Addressed.

>          if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
>              error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
>          } else {
> 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 6aa1cd04e484..c69b5310c184 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -328,7 +328,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >                                1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
> >       }
> > -    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
> > +    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
> >           init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
> >           pmu_supported = true;
> >           features |= 1ULL << ARM_FEATURE_PMU;
> > @@ -654,11 +654,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >           }
> >       }
> > -    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
> > +    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
> >       hw_watchpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWWatchpoint), max_hw_wps);
> > -    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
> > +    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
> >       hw_breakpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWBreakpoint), max_hw_bps);
> > @@ -1905,7 +1905,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
> >   void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
> >   {
> > -    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
> > +    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
> >       if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
> >           if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> 


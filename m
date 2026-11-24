Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27D606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=L3GuM2ft
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpCe-0002dw-3U; Tue, 24 Nov 2026 07:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xVpBb-00028u-PH; Tue, 24 Nov 2026 06:59:48 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xVpBa-0005XW-4o; Tue, 24 Nov 2026 06:59:47 -0500
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id B284A20B716E; Tue, 24 Nov 2026 03:59:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B284A20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795521580;
 bh=3FygYI9vTTyON8+Gu1XrkYH+X5UqcpMCOHXFsFT4d6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L3GuM2ftBNvQrrk4kHLKwjEliZ1j3IifrCAuQ0U4I0kbFboOBojT7Xy1tfHSB942M
 III1kYm5r0moA6JhQaDjMZD9Od+Qu5hwPlOZ0f8f+MR27DbZ6x/g23qG4KED/z9a0L
 OMxExJxGDtlXBn3ZDM0i1xkciMS4JeVR4pG7IJ/g=
Date: Tue, 24 Nov 2026 03:59:40 -0800
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 06/14] target/arm: convert host CPU feature ifdef
 ladder to runtime checks
Message-ID: <awV8LDva4nT01Gir@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-6-aefe5e76a0e3@linux.microsoft.com>
 <av8jIWEKN9QSc4pn@example.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av8jIWEKN9QSc4pn@example.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 19, 2026 at 05:26:09PM +0100, Magnus Kulke wrote:
> On Thu, Oct 01, 2026 at 10:52:51AM +0000, Aastha Rawat wrote:
> > Replace the compile-time #if/#elif preprocessor ladder in
> > aarch64_host_initfn() with runtime calls and add mshv_enabled() to it.
> > This ensures the correct accelerator is selected at runtime when
> > multiple accelerators are compiled in.
> > 
> > Add CONFIG_MSHV to the aarch64_cpus[] guard so that mshv accelerator can
> > register the "host" CPU type.
> > 
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > ---
> >  target/arm/cpu64.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index dcd0d698b3..a9e346049d 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -811,17 +811,21 @@ void aarch64_host_initfn(Object *obj)
> >      }
> >  #endif
> >  
> > +    if (mshv_enabled()) {
> > +        mshv_arm_set_cpu_features_from_host(cpu);
> 
> as pointed out by Peter, we probably want to keep the defines, but
> this fn is also not present in this commit yet, so it might need a
> stub or reordering.

I'll move this call to the commit that introduces it.
 
> > +    } else if (kvm_enabled()) {
> >  #if defined(CONFIG_KVM)
> > -    kvm_arm_set_cpreg_mig_tolerances(cpu);
> > -    kvm_arm_set_cpu_features_from_host(cpu);
> > -    aarch64_add_sve_properties(obj);
> > -#elif defined(CONFIG_HVF)
> > -    hvf_arm_set_cpu_features_from_host(cpu);
> > -#elif defined(CONFIG_WHPX)
> > -    whpx_arm_set_cpu_features_from_host(cpu);
> > -#else
> > -    g_assert_not_reached();
> > +        kvm_arm_set_cpreg_mig_tolerances(cpu);
> >  #endif
> > +        kvm_arm_set_cpu_features_from_host(cpu);
> > +        aarch64_add_sve_properties(obj);
> > +    } else if (hvf_enabled()) {
> > +        hvf_arm_set_cpu_features_from_host(cpu);
> > +    } else if (whpx_enabled()) {
> > +        whpx_arm_set_cpu_features_from_host(cpu);
> > +    } else {
> > +        g_assert_not_reached();
> > +    }
> >      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> >          aarch64_add_pauth_properties(obj);
> >      }
> > @@ -830,7 +834,8 @@ void aarch64_host_initfn(Object *obj)
> >  static const ARMCPUInfo aarch64_cpus[] = {
> >      { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
> >      { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
> > -#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
> > +#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || \
> > +    defined(CONFIG_WHPX) || defined(CONFIG_MSHV)
> >      { .name = "host",               .initfn = aarch64_host_initfn },
> >  #endif
> >  };
> > 
> > -- 
> > 2.45.4


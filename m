Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B421606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YosxI4uY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwnz-0000I7-UA; Thu, 05 Nov 2026 07:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOwny-0000HZ-DQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:42:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOwnv-0004Z3-Rk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793882574;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHwGtuZGSoSmZ44KiRLicjxswY71YMk8SxPY/4EOfwE=;
 b=YosxI4uYPDMK2i6ekWsXcRY5XUvoCVJHlxZq56VjjzZPXxh4srgiz72WqPlvqbwfpenmiS
 VPxTlkU54ir8rdkT9RDn+aTRaqRskAbdoHJrw+r/URsfH+Gu5hDsCIhYgHO09AnuPsvxwm
 sAxm1QABckl7m9UbF+PB7JOMmxwd53k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-V12lDsDtPFG-llF3X8AsuA-1; Thu,
 05 Nov 2026 07:42:51 -0500
X-MC-Unique: V12lDsDtPFG-llF3X8AsuA-1
X-Mimecast-MFC-AGG-ID: V12lDsDtPFG-llF3X8AsuA_1793882568
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC61195607C; Thu,  5 Nov 2026 12:42:47 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA2EF1848D40; Thu,  5 Nov 2026 12:42:42 +0000 (UTC)
Date: Thu, 5 Nov 2026 12:42:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
Message-ID: <aux5vwTnbV3cXcFX@redhat.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
 <auxgsFyzv-5UiyNk@redhat.com>
 <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 07:14:35PM +0800, Yonggang Luo wrote:
> On Thu, Nov 5, 2026 at 6:55 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Sun, Nov 01, 2026 at 12:40:01AM +0800, Yonggang Luo wrote:
> > > max-v8 was one TypeInfo whose instance initializer was chosen from the
> > > selected target at registration. Register both initializers, and let
> > > target_arm() and target_aarch64() select which type is available.
> > >
> > > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > ---
> > >  target/arm/cpu.c            |  1 +
> > >  target/arm/cpu.h            |  1 +
> > >  target/arm/tcg/cpu-max-v8.c | 16 ++++++++++++----
> > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > > index 510fc9eeb3b..6eb55242980 100644
> > > --- a/target/arm/cpu.c
> > > +++ b/target/arm/cpu.c
> > > @@ -2695,6 +2695,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
> > >          .instance_init = arm_cpu_instance_init,
> > >          .class_init = info->class_init ?: cpu_register_class_init,
> > >          .class_data = info,
> > > +        .is_available = info->is_available,
> > >      };
> > >
> > >      type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
> > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > > index add993ef101..3240a8633ee 100644
> > > --- a/target/arm/cpu.h
> > > +++ b/target/arm/cpu.h
> > > @@ -1203,6 +1203,7 @@ typedef struct ARMCPUInfo {
> > >      const char *deprecation_note;
> > >      void (*initfn)(Object *obj);
> > >      void (*class_init)(ObjectClass *oc, const void *data);
> > > +    bool (*is_available)(void);
> > >  } ARMCPUInfo;
> > >
> > >  /**
> > > diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> > > index 65f851f2006..e819d07e6ce 100644
> > > --- a/target/arm/tcg/cpu-max-v8.c
> > > +++ b/target/arm/tcg/cpu-max-v8.c
> > > @@ -121,10 +121,18 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> > >
> > >  static void cpu_max_v8_register_type(void)
> > >  {
> > > -    static const ARMCPUInfo max_v8[2] = {
> > > -        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
> > > -        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
> > > +    static const ARMCPUInfo max_v8_aarch32 = {
> > > +        .name = "max-v8",
> > > +        .initfn = aarch32_max_v8_tcg_initfn,
> > > +        .is_available = target_arm,
> > >      };
> > > -    arm_cpu_register(&max_v8[target_aarch64()]);
> > > +    static const ARMCPUInfo max_v8_aarch64 = {
> > > +        .name = "max-v8",
> > > +        .initfn = aarch64_max_v8_tcg_initfn,
> > > +        .is_available = target_aarch64,
> > > +    };
> > > +
> > > +    arm_cpu_register(&max_v8_aarch32);
> > > +    arm_cpu_register(&max_v8_aarch64);
> > >  }
> > >  type_init(cpu_max_v8_register_type)
> >
> > Conceptually these are two separate CPUs one 32-bit featureset
> > and one 64-bit featureset, but both given the same name. The
> > current code registers them only in the respective arm and aarch64
> > target binaries, but this CPU is an oddity overall.
> 
> This is the one I did before
> https://lore.kernel.org/qemu-devel/20261013195606.152-1-luoyonggang@gmail.com/
>
> target/arm: defer max-v8 initializer selection until CPU creation
> but rejected, and I think it's fine.

So that essentially matches the historical semantics where one
CPU class magically changes its behaviour based on what target
is running.  So in that sense, it works, and is no worse than
the semantics we've had for 'max' models forever.

Splitting into 2 distinct types is worthwhile if we want to
make it possible for the aarch64 emulator to support a runtime
choice of both 32-bit and 64-bit "max" models.

This patch doesn't allow that though, as it is creating two
classes with the same name and filtering which is registered.
If we don't intend to allow 64-bit target to ever use a 32-bit
'max' CPU, then your original patch is better IMHO.

> > More generally the aarch64 emulator includes all the 32-bit CPUs
> > that the arm emulator includes, and just adds extra 64-bit CPUs.
> > IOW, excluding the 32-bit max-v8 CPU is a special case - if it
> > were not for the clashing name, it would be included like all the
> > other 32-bit CPUs.
> >
> > Thus rather than using is_available to continue to exclude it,
> > we must instead resolve the naming problem, such that both
> > models can be included concurrently.
> 
> I have already implemented the TypeBucket over targets/arch_mask that works
> properly. That same QOM name will have multiple TypeImpl.

I'm not sure what you mean by TypeBucket, but my general thought is that
at the QOM class/type naming level everything must always be unique,
such that we have a single object modelk across QEMU.

Any ambiguitity & its resolution (if needed) should live outside core
QOM typework, such as with aliases in machines/CPUs.

If we have a common pattern for aliases, perhaps we could create a
standard QOM Interface for resolving aliases.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



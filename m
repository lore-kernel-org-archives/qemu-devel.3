Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D2606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uz5ZT4k0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Wd-0006X6-05; Mon, 16 Nov 2026 16:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4WV-0006Tz-QM
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4WT-0003oh-P9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794865557;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHeAW8Rhpd7c2SrWyyuPtG1l0e/NjwPKadW8ZqCZqsM=;
 b=Uz5ZT4k0GIGt3qaDvHUoo8hvmVaIr/s88g/EqZ7ugNXHzcflhVeh5QE8vlpK3sst3JEkZ1
 Nh2iASU7mX24mHuHonHvxuAcHx8+kYuol5Q6ns46VwlolzIvfBa1DzAOPas6saJLF7ePZq
 bfHyCy7sAKt/YJWkGv61u4VitJumS08=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-o0SyNY-DN0-L6PpciMwySA-1; Mon,
 16 Nov 2026 16:45:53 -0500
X-MC-Unique: o0SyNY-DN0-L6PpciMwySA-1
X-Mimecast-MFC-AGG-ID: o0SyNY-DN0-L6PpciMwySA_1794865552
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 249B01955D57; Mon, 16 Nov 2026 21:45:52 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D83D81956054; Mon, 16 Nov 2026 21:45:50 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:45:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
Message-ID: <avt5jDfUKmxvuxBu@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
 <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 08:36:41PM +0800, Yonggang Luo wrote:
> On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > All QOM types must have a globally unique typename, however, for
> > user convenience, some might also want to have aliases which are
> > permitted to be ambiguous. Define an "Aliased" interface which
> > can be implemented by types which want to support aliases.
> >
> > When resolving an alias, if there are multiple QOM types with a
> > matching alias this is considered an error. Ambiguity can be
> > resolved by matching system state, with the selected target
> > being the currently implemented filter.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
> >  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
> >  2 files changed, 134 insertions(+)
> >
> > diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> > index d222a3d7481..010e37d63f7 100644
> > --- a/include/qom/object_interfaces.h
> > +++ b/include/qom/object_interfaces.h
> > @@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
> >
> >  typedef struct TargetSpecific TargetSpecific;
> >
> > +#define TYPE_ALIASED "aliased"
> > +
> > +typedef struct AliasedClass AliasedClass;
> > +DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
> > +                       TYPE_ALIASED)
> > +#define ALIASED(obj) \
> > +     INTERFACE_CHECK(Aliased, (obj), \
> > +                     TYPE_ALIASED)
> > +
> > +typedef struct Aliased Aliased;
> > +
> >  /**
> >   * UserCreatableClass:
> >   * @parent_class: the base class
> > @@ -242,4 +253,70 @@ bool target_specific_class_creatable(ObjectClass *oc);
> >  ObjectClass *target_specific_class_check(ObjectClass *oc,
> >                                           Error **errp);
> >
> > +/**
> > + * AliasedClass
> > + * @parent_class: the base class
> > + *
> > + * Interface for classes that want to declare they have aliases
> > + * for their primary type name.
> > + *
> > + * While QOM type names are required to be unique, aliases allow
> > + * for ambiguity across classes. The ambiguity is resolved at
> > + * runtime based on system state, typically by the selection of
> > + * a specific target. If ambiguity cannot be resolved, the user
> > + * will need to use the unique QOM type name instead.
> > + */
> > +struct AliasedClass {
> > +    InterfaceClass parent_class;
> > +
> > +    const char *const *aliases; /* NULL terminated list of typenames */
> 
> 
> Hi Daniel,
> I have a though that can we specify the target for each alias, so for example
> "aarch64-virt" will pair with QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64)
> and
> "arm-virt" will pair with QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM),
> so that when select name aarch64-virt, we will automatically infer the
> QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64) out.

I don't believe we need to distinguish aliases "arm-virt" and
"aarch64-virt" - this series proposes just using "arm-virt"
unconditionally.  Likewise for the other targets where there
is a 32/64 variant - eg  this series adds 'riscv-virt' as the
alias, not "riscv64-virt" or "riscv32-virt".

With that, the list of aliases we need is fixed per machine
class, and doesn't need to be associated directly with a
subset of targets the machine is compatible with.



> Also
> "virt" will pair with QEMU_ARCH_ALL, this is for single-target binary.
> So that the paired target can be either QEMU_ARCH_ALL or single
> QEMU_ARCH_BIT(target_arch).
> After this design,  the TYPE_TARGET_SPECIFIC won't be needed anymore and
> we can use machine names to select "target_arch" in an explicit way(As
> each alias name is
> mapped to explicit QEMU_ARCH_BIT(target_arch)). for QEMU_ARCH_ALL is
> only work for single-target binary.
> 
> And we can add some helper macro to generate the pair easily.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



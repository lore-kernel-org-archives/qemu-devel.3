Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46CFCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHitF-0002rD-S2; Fri, 16 Oct 2026 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHitD-0002qc-LI
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHitB-0007GG-Jh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792160787;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7n4iZ4ComhfcCVp1PkEGP1+7z4EwMMCEz02WurFs1qo=;
 b=akeHGtcuwnDXYv+ilalQhPhi4Jd5AGnmuidszc1sjmqGvY+5Hx6MZPorMJPrr7ILo8f0U1
 NKGYeemHD8rNVJPWgPnCle2f60hcmIhE9O0OjdHppqMsvc5QkWLynjTksRlcAM6nKi4Qz9
 hCGEeKE2ja6LH4ElTbOZJM112R80Pgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-XGRp31ypM1C1a-v6MRZv5Q-1; Fri,
 16 Oct 2026 14:26:23 +0000
X-MC-Unique: XGRp31ypM1C1a-v6MRZv5Q-1
X-Mimecast-MFC-AGG-ID: XGRp31ypM1C1a-v6MRZv5Q_1792160781
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B9991956094; Fri, 16 Oct 2026 14:26:21 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADB4C26C; Fri, 16 Oct 2026 14:26:19 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:26:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
Message-ID: <atI0CCfUsBR2kqkB@redhat.com>
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com> <atHu0kCSQTD9E34p@redhat.com>
 <CAFEAcA9PTB=1V_hV1P0xpEW4aY+4LajYyzKzyTOJj=bb9=oPvA@mail.gmail.com>
 <atICMoFG2gkoHWJ-@redhat.com>
 <CAFEAcA8hJ_WK+4itRtQiJBtDnd5TfA5jrtrcF2qPAj0cnJ+U9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8hJ_WK+4itRtQiJBtDnd5TfA5jrtrcF2qPAj0cnJ+U9Q@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 16, 2026 at 03:09:55PM +0100, Peter Maydell wrote:
> On Fri, 16 Oct 2026 at 11:53, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Oct 16, 2026 at 11:14:16AM +0100, Peter Maydell wrote:
> > > On Fri, 16 Oct 2026 at 10:31, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > > > +#define qdev_realize_chain_parent(dev, dc, errp) \
> > > > +    DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(dc)))->realize(dev, errp)
> > >
> > > I'm tempted to suggest that we drop the 'dc' argument here and
> > > have the macro get the class from the dev:
> > >     DEVICE_CLASS(object_class_get_parent(object_get_class(OBJECT(dev))))->realize(dev,
> > > errp)
> > >
> > > because I think almost all realize methods wanting to chain back up
> > > won't have the class pointer to hand.
> > >
> > > We could maybe have an extra layer of abstraction here such that
> > > you write something like:
> > >
> > >    parent_invoke(DEVICE_CLASS, dev)->realize(dev, errp);
> > >
> > > Or is that trying to be too clever?
> >
> > This won't work if we have multiple levels in the class hierarchy
> > that need chaining up, as object_class_get_parent(object_get_class(dev))
> > will always just get the first level parent class of 'dev'.
> 
> Isn't that always what you want, though? In a class hierarchy
> Object->Device->A->B->C, C's realize method always wants to
> chain to B's realize method, and more generally "invoke the
> superclass method" from C wants B's implementation, not A's
> (assuming B actually implemented it).

Yes, C wants to invoke B's realize method, but then B also
wants to invoke A's realize method.

> > Somewhere/how we need to identify the current class level we're
> > calling from, so we know what parent to ask for.
> >
> > Another option is to do what GObject does and provide a simple
> > helper for getting the parent class, from OBJECT_DEFINE_TYPE*
> > macros:
> >
> >     ...
> >     static inline ObjectClass * \
> >     module_obj_name##_parent_class() { \
> >         return object_class_by_name(TYPE_##PARENT_MODULE_OBJ_NAME); \
> >     } \
> >     ...
> >
> > which would be used
> >
> >     DeviceClass *dc = DEVICE_CLASS(pl050_kbd_parent_class());
> >
> >     dc->realize(dev, errp);
> >
> > but many (most) of qdev impls don't use the relatively new
> > OBJECT_DEFINE_TYPE macros. They would have to instead explicitly
> > reference the parent type name:
> >
> >     DeviceClass *dc = DEVICE_CLASS(object_class_by_name(TYPE_PL050));
> >     dc->realize(dev, errp);
> 
> I still don't understand why we need to get the parent's
> object class by name here, rather than saying "give me
> the parent class of this object's class".

No matter which realize() method we are executing in, the "dev"
object parameter will always be an instance of the leaf class "C"
and thus the result of object_class_get_parent(objct_get_class(dev))
will always be B. That is only correct if executgnig "C"s realize
method, so breaks if we need to chain up realize many times.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



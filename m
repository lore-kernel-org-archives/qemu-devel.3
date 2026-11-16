Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=buf7rbB8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4eN-0004uy-Ni; Mon, 16 Nov 2026 16:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4eL-0004ub-I7
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:54:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4eG-0007mC-L4
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794866040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMO92H3IHMbw7U6gFQR6TevJ95bVwMA722vhRMZTG7A=;
 b=buf7rbB8tPBXCawiNX5PXyNa5R5lViVK/gyHRHI8tUfn6VGimasGVwVaGI6ua+233q61DO
 A200fjicpToxIOEKJiUWTDkxNnGLDWrxwq+5KFyzjIzIMptwt9FTa01HwiakDySUc7eq2S
 n/SDciUWfAXR5N3/bxQnzaskq9xrUMs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-SbwFZecSNPK6bo9ZpS_Cpg-1; Mon,
 16 Nov 2026 16:53:53 -0500
X-MC-Unique: SbwFZecSNPK6bo9ZpS_Cpg-1
X-Mimecast-MFC-AGG-ID: SbwFZecSNPK6bo9ZpS_Cpg_1794866032
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD4C81956057; Mon, 16 Nov 2026 21:53:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 167341800543; Mon, 16 Nov 2026 21:53:49 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:53:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
Message-ID: <avt7apWvO-6QwI_u@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
 <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
 <1447ca17-52a6-c069-d3b0-f778c60dca20@eik.bme.hu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1447ca17-52a6-c069-d3b0-f778c60dca20@eik.bme.hu>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 04:31:01PM +0100, BALATON Zoltan wrote:
> On Sun, 15 Nov 2026, Yonggang Luo wrote:
> > On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > All QOM types must have a globally unique typename, however, for
> > > user convenience, some might also want to have aliases which are
> > > permitted to be ambiguous. Define an "Aliased" interface which
> > > can be implemented by types which want to support aliases.
> > > 
> > > When resolving an alias, if there are multiple QOM types with a
> > > matching alias this is considered an error. Ambiguity can be
> > > resolved by matching system state, with the selected target
> > > being the currently implemented filter.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
> > >  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
> > >  2 files changed, 134 insertions(+)
> > > 
> > > diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> > > index d222a3d7481..010e37d63f7 100644
> > > --- a/include/qom/object_interfaces.h
> > > +++ b/include/qom/object_interfaces.h
> > > @@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
> > > 
> > >  typedef struct TargetSpecific TargetSpecific;
> > > 
> > > +#define TYPE_ALIASED "aliased"
> > > +
> > > +typedef struct AliasedClass AliasedClass;
> > > +DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
> > > +                       TYPE_ALIASED)
> > > +#define ALIASED(obj) \
> > > +     INTERFACE_CHECK(Aliased, (obj), \
> > > +                     TYPE_ALIASED)
> > > +
> > > +typedef struct Aliased Aliased;
> 
> I wonder if it would be simpler to add the possibility to define aliases to
> all QOM objects as standard instead of by an interface? This is useful for
> other cases, it came up here too for example:
> https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00113.html
> Or maybe this could be done with this interface by common super classes
> implementing it such as device and machine allowing aliases that commonly
> need it to use it but then it would be quite widespread use to consider just
> adding it to object right away which may also help interaction with arch.
> Why separating it into an interface is better when we need it for most
> objects?

We really don't need it for most objects. It is somewhat common for
machine classes, just because we have many called 'virt', but even
they are a minority of all machines. The number of places we might
need it outside of machines will likely not exceed single digits.

The core QOM framework tries to be a fairly "pure" object model
without QEMU specific aspects to its design. It is somewhat
inspired by GObject, and I still rather regret that QEMU is not
using GObject as it would have done everything we need and made
life easier.

Stuff that starts to get QEMU specific is pushed into interfaces
like UserCreatable, or abstract base classes like "Device". IMHO
it is beneficial to retain this conceptual division, as it lets
us understand the behaviour of QOM as a framework in isolation
from the bulk of QEMU.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C30D62613
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vis68-0000qY-Va; Thu, 22 Jan 2026 05:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vis65-0000qI-LQ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vis63-0006dv-34
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769078365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGdv90XXh8msA511nPdVamGcuIccPguss5F3Ju7xRJU=;
 b=VcPe8NDCfcRINncYQLfip1yysrcxw6tiE3ZD9JrC5qV71QpG8QkwJ1VXcHb9mth7N6Fsev
 /LsVFrTIDT0Ly3VQotcqHxSuWJibGDW14EV9GlQgcSbvC9/+1837T1GlQlCPAAkOBBw0yx
 hu4Q/sLXgdK7blSqCwLaeS8KoR1Y6dI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220--YW5eXeRM8iMGNXAJN6c8w-1; Thu,
 22 Jan 2026 05:39:21 -0500
X-MC-Unique: -YW5eXeRM8iMGNXAJN6c8w-1
X-Mimecast-MFC-AGG-ID: -YW5eXeRM8iMGNXAJN6c8w_1769078360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DBE81800378; Thu, 22 Jan 2026 10:39:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38F4B1958DC1; Thu, 22 Jan 2026 10:39:13 +0000 (UTC)
Date: Thu, 22 Jan 2026 10:39:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aXH-TlzxZ1gDvPH2@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 22, 2026 at 02:22:28PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jan 22, 2026 at 2:14 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> > > Hi Marc-André,
> > > I haven't seen discussion about the project ideas you posted, so I'll
> > > try to kick it off here for the mkosi idea here.
> > >
> > > Thomas: Would you like to co-mentor the following project with
> > > Marc-André? Also, do you have any concerns about the project idea from
> > > the maintainer perspective?
> > >
> > > === Reproducible Test Image Building with mkosi ===
> >
> > > This project proposes using mkosi to build minimal, reproducible test
> > > images directly from distribution packages. mkosi is a tool for
> > > building clean OS images from distribution packages, with excellent
> > > support for Fedora and other distributions. It should be able to
> > > produces deterministic outputs.
> >
> > Aside from what I mentioned already, the other issue I anticipate
> > with mkosi is the mismatch between what hardware QEMU needs to be
> > able to cover, vs what hardware the distros actually support.
> >
> > Fedora in particular is pretty narrow in its coverage. Debian is
> > considerably broader.
> >
> > Neither will support all the QEMU targets, let alone all the
> > machine types within the target.
> 
> 
> That's right, the goal here is not to cover all possible images though.
> 
> I picked Fedora here as an example, because it is the best supported
> distribution in mkosi.

IMHO to be worth the effort of integrating mkosi *and* maintaining its
use in QEMU long term, it has to address a broad set of problems that
we face in the functional tests.

IMHO the inherant dependency on distros is the underlying problem
we have, as we try to achieve testing coverage across all the
machine types in QEMU.  It leads us to having a random selection
of different approaches, and mkosi does not look like it will
reduce that problem, or help us fill in the gaps we have.

> > While there is value in testing a full blown OS image, IMHO,
> > for most of what we need it is considerable overkill, and
> > thus makes functional tests slower than they would otherwise
> > need to be.
> 
> mkosi can produce initrd images, which can be small enough and
> customizable. Although I lack the details of what is possible, this is
> part of the project research.
> 
> Imho, building all images from scratch cannot be sustainable.

I'd say the opposite - relying on distros, whether using mkosi
or not, is not sustainable.

Once we have written some scripts that can build gcc, binutils, linux,
busybox we've opened the door to be able to support every machine type
on every target, provided there has been a gcc/binutils/linux port at
some time (which covers practically everything). Adding new machines
becomes cheap then - just a matter of identifying the Linux Kconfig
settings, and everything else stays the same. Adding new targets means
adding a new binutils build target, which should again we relatively
cheap, and also infrequent. This has potential to be massively more
sustainable than a reliance on distros, and should put us on a pathway
that would let us cover almost everything we ship.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



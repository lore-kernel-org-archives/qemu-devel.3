Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F83D30CC0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 20:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfkd6-0003c6-RF; Tue, 13 Jan 2026 15:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vfkd4-0003bS-Nu; Tue, 13 Jan 2026 15:04:38 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vfkd2-0007vI-MJ; Tue, 13 Jan 2026 15:04:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 59B1E4376D;
 Tue, 13 Jan 2026 20:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB965C116C6;
 Tue, 13 Jan 2026 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768334673;
 bh=Yt7WZzZlEyOF/hmM4ffb9LNBFiydhSiYJWhMX3a7mxs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bjhAnr8vRJCb3HpWdph9h5Orxkb1vUrQ8mR7KAg3tblTR5SiM3/vs3vC4iRZ0T9fB
 NiLtdnOv2uWT5ikO7mC8ldx2B7fsj1jo13Q9ZjruBWDNpfCyZ3OmELjH/qQszuRq/d
 ff0rZ9N1dJYoiek/fv+0wZRTuQFYQ8QVTWkm39htevHZQ2kHqSVmk7O5ieefZONoii
 2FXXYx0daFmucckpLzbwG2XOQTHLR48H39dH1v3ib6WlbGetz/HwaB0yR3ZannRq6q
 ZKjHScKzUfBoDe1nIvyolBNHelhkJBDLn0EFrU/Wr+PG8t9syLrD62dMzId0ZuVpvk
 9NJ3Te7wyGfYA==
Date: Tue, 13 Jan 2026 21:04:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/1] Sync kernel-doc.py with Linux upstream
Message-ID: <20260113210427.632e9550@foz.lan>
In-Reply-To: <CAFn=p-YzSP_v0TAzGOGH+mGMczqQLpN5OTda3c1MdbNGETcd4A@mail.gmail.com>
References: <cover.1767716928.git.mchehab+huawei@kernel.org>
 <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
 <aWY10BYoJjck3xX8@redhat.com>
 <CAFn=p-YzSP_v0TAzGOGH+mGMczqQLpN5OTda3c1MdbNGETcd4A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Tue, 13 Jan 2026 14:52:56 -0500
John Snow <jsnow@redhat.com> escreveu:

> On Tue, Jan 13, 2026 at 7:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> >
> > On Tue, Jan 13, 2026 at 11:44:51AM +0000, Peter Maydell wrote: =20
> > > On Tue, 6 Jan 2026 at 16:38, Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote: =20
> > > >
> > > > Hi Peter/John,
> > > >
> > > > There were several updates at kernel-doc upstream fixing bugs,
> > > > doing cleanups and a couple of improvements.
> > > >
> > > > Better to keep QEMU in sync with such changes.
> > > >
> > > > Worth mentioning that we did some changes on Linux at the
> > > > kernel-doc.py script itself, to avoid Kernel build to crash
> > > > with too old Python versions, as there docs build is a
> > > > separate target, and python >=3D 3.6 is a new requirement
> > > > there.
> > > >
> > > > On kernel, if python < 3.6, it will simply ignore docs
> > > > build (emitting a warning).
> > > >
> > > > I opted to not backport such changes, but if you prefer
> > > > doing that, I can do that on a v2.
> > > > ---
> > > >
> > > > For now, I opted to keep kernel-doc libraries at the same
> > > > directory as before - e.g. at scripts/lib/kdoc. On Linux,
> > > > we ended moving it to tools/lib/python/kdoc. It could make
> > > > sense to move it on QEMU too, as it makes a little bit
> > > > easier to keep things in sync.
> > > >
> > > > What do you think? =20
> > >
> > > Hi; thanks for doing this backport. I checked that the output
> > > with this patch applied is still the same as with the old
> > > kernel-doc, and eyeballed the diffs between our kernel-doc
> > > and the Linux version, to confirm that we have kept our two
> > > minor QEMU-specific modifications and haven't missed anything
> > > from Linux's version that we ought to have. So:
> > >
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > >
> > > On your two questions:
> > >
> > > (1) As Dan says, QEMU already enforces a new enough
> > > Python version, so we don't need to handle 3.6. I think
> > > the main thing driving a choice to backport or not those
> > > changes would be simply keeping in sync with Linux's
> > > version of the script so we don't diverge. We want to
> > > make future re-syncing of the script as easy as possible.
> > >
> > > (2) Regarding the location of the kernel-doc libraries:
> > > we seem to have two things here, possibly in tension:
> > >  - we don't want to gratuitously diverge from Linux
> > >  - QEMU's directory hierarchy is not the kernel's
> > >
> > > In particular, I'm not sure tools/ is where we would
> > > naturally put python libraries used during the build
> > > process. Maybe that would be python/ for us, but I defer
> > > to John or another Python expert on that. =20
> >
> > I tend to see the 'python' directory as being for stuff we formally
> > maintain as a python API for use by multiple internal consumers. =20
>=20
> I more or less agree with Dan - that is how it is currently arranged.
>=20
> In the past, however, I have suggested moving certain other modules
> that are bigger than a single file into python/ for the sake of being
> able to maintain them more aggressively: i.e. I do not regularly check
> for Python regression and compatibility issues for things under
> scripts/, except for qapi, which is also something I proposed moving
> to python/ before.
>=20
> The current state of things is that I aggressively check and test these t=
hings:
>=20
> - python/*
> - scripts/qapi/
> - docs/sphinx/qapi_domain.py
> - docs/sphinx/qapidoc.py

Giving my 2 cents here: at Linux Kernel, we're moving documentation
to tools/docs document because just scripts/ became too messy. Also,
having a directory specifically for python modules makes sense.
So, we just moved libraries to tools/python/lib.=20

> Everything else is just "best effort" which generally means "I fix it
> when I notice that it is broken". If it is not a multi-file module and
> not necessary for configure+build to run, I think for now it is best
> kept outside of python/.

In the specific case of kernel-doc + modules this is required at build
time, if docs are enabled.

> > This is just a bunch of helper files exclusively for use by the kernel-=
doc
> > tool, and so the scripts/ directory is a decent fit for it, given that =
this
> > dir is for a collection of arbitary supporting tools & scripts.

Not quite: those files are the actual kernel-doc implementation.

The exec is just a shell to call them. At the Linux Kernel, we don't even
run kernel-doc exec anymore: they're called directly by the Sphinx=20
kerneldoc extension. We use the exec just to allow us to run manually,=20
as it can be helpful to see the ReST result when problems rise.

Right now on QEMU we're still running the exec, but this can change
some day.

> >
> > As precedent, see the tracetool, which keeps all its helpers under
> > scripts/tracetool too.
> >
> > TL;DR: I would not want to see a new top level tools/ directory
> > created, and don't think it fits in python/ either; scripts/ is
> > a fine home.
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
> > =20
>=20



Thanks,
Mauro


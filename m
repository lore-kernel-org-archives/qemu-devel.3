Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCECCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU4PW-0003Rp-0K; Mon, 01 Jun 2026 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU4PM-0003IX-BS
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU4PJ-0004Ik-Vq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780327104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zt3eyMH0ipYhRk9m1oEQ4cSndFpI0aHFkvbSlW+mJ4A=;
 b=dhQUaFyr0ewTo17wmRRWtns78dPP3x+9tEI5L/M16P4bEqalFEoT4CnUIGSyFAnRaeQ+kQ
 VQ5JhCi+kNmuddPbSJYRPw3o+IirNUKiXpT6DXmxq9Feh7gaWiTfpGaRjG2wM1dQC6hOZE
 /dnp9dKvgGuy3RZtPGz8WLXYqsyMl0A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-pfvITQBVNVynAQHGWMtMBA-1; Mon,
 01 Jun 2026 11:18:21 -0400
X-MC-Unique: pfvITQBVNVynAQHGWMtMBA-1
X-Mimecast-MFC-AGG-ID: pfvITQBVNVynAQHGWMtMBA_1780327099
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 115BF1956095; Mon,  1 Jun 2026 15:18:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63D201684; Mon,  1 Jun 2026 15:18:16 +0000 (UTC)
Date: Mon, 1 Jun 2026 11:18:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260601151815.GC411459@fedora>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HQ4jA1N2etY42/kr"
Content-Disposition: inline
In-Reply-To: <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--HQ4jA1N2etY42/kr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 04:27:46PM +0200, Albert Esteve wrote:
> On Mon, Jun 1, 2026 at 3:51=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Mon, Jun 1, 2026 at 9:12=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > > > On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > > > > >  But also because, in my opinion, separating
> > > > > > the specification would improve development agility by decoupli=
ng
> > > > > > specification development from QEMU's review and release cycles.
> > > > >
> > > > > Generally for QEMU this will be less agility, unless I misunderst=
and
> > > > > what is proposed)
> > > > >
> > > > > Because presumably there will need to be spec releases then?
> > > > >
> > > > > So
> > > > >         new feature -> spec tree -> spec release -> qemu implemen=
tation -> qemu release
> > > > >
> > > > > is surely longer that what we have now.
> > > >
> > > > I see your point.
> > > >
> > > > However, we do not really need to introduce a heavy release managem=
ent
> > > > layer. We could just operate it as a living document, where the main
> > > > branch is the authoritative source of truth.
> > > >
> > > > For the workflow, development doesn't have to be strictly sequential
> > > > either. A contributor can propose the spec update while working on =
the
> > > > implementation, much like we do for VirtIO updates. Actually, this =
way
> > > > one update/change supports the other.
> > > >
> > > > I guess my point is that a dedicated repository could lower the
> > > > barrier for new changes AND keep QEMU's own development speed mostly
> > > > unaffected.
> > > >
> > > > BR,
> > > > Albert
> > >
> > > Something something submodule? Possibly. If you want to make progress
> > > on this, pls think of the process, try it out.
> >
> > If I understand correctly, the motivation for moving the spec
> > somewhere else is to replace the email patch review process with a git
> > forge review process?
> >
> > This seems like a superficial change and is not worth in my opinion if
> > you consider we'll have to redirect from the old spec location and
> > move the community over to the new repo.
>=20
> The core issue from my perspective is project neutrality and
> decoupling lifecycles.
>
> Currently, protocol updates are tied to QEMU's tree rules and release
> freezes for example. Since these changes also affect other projects
> (like rust-vmm, crosvm, DPDK, etc.), separating them may make sense
> and could streamline the process.

I don't see a reason to block vhost-user.rst changes during QEMU's
freeze. If Michael sent a vhost-user spec pull request during freeze I
would merge it.

> >We could actually lose spec
> > change reviewers in the process either because they don't know what's
> > going on or decide that they prefer to spend time elsewhere when faced
> > with switching processes (the people who review and participate in
> > discussion do so out of personal interest and as far as I'm aware no
> > one is employed to work on vhost-user as their #1 priority).
>=20
> This is a fair concern. I hope we maintain reviewer engagement. But it
> could also be argued that contributors from other communities may be
> more comfortable with a dedicated project-neutral home. It could well
> go both ways, but it also represents an opportunity to grow.
>=20
> >
> > Having said that, here is what I imagine it would involve:
> >
> > 1. Michael creates a new repo on a git forge (if he wants it to be
> > under the GitLab qemu-project organization I can help with creating
> > the repo, otherwise he creates a new organization and repo).
> > 2. Discussion happens in Issues.
> > 3. Spec changes are proposed in Merge Requests. Michael merges them
> > once consensus has been reached.
>=20
> Mostly yes, though we wouldn't necessarily need Michael as the sole
> gatekeeper. We could invite co-maintainers from other key projects to
> share the reviewer load.
>
> Also I'd want to clarify that although I am advocating for this
> change, I do not claim to have the definitive roadmap. I am just
> sharing my view on why this could be a positive evolution. Consensus
> may end up being to remain with the current status quo, or any of the
> other options proposed by Alex.

I get a sense that this is about politics in the end. Do people feel
they are not represented and would like to have more influence in the
vhost-user spec?

You bring up project neutrality and a model where Michael is no longer
the sole maintainer. It will be necessary to propose a concrete roadmap
and also to explain the concerns about neutrality more so it's clear
they won't be an issue anymore in the future system.

Why is the current system not neutral and how will the new system solve
that?

Who should be a co-maintainer?

Stefan

--HQ4jA1N2etY42/kr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodorcACgkQnKSrs4Gr
c8hXJAgAxVdjUSAgTFp31oFqwGcwdKTPiiBXlpCbBdIq2oWW0N0+xIbmowne/48I
zjsG+6JgWNqnzZ5U7FFCQ9EuD72ovhkCo0RHvYA3YEg/i70vqaeG8d68UDJRE5YZ
21dAoXmjVGgJJaMpfho5DXGylcm/hp38rAe6qEqCNA0U2VJX74chbRdcZrS1rV6O
g8hdgasuFd0cuiYBqs5Swk9GN3YLAQx/zxFFmUJImSOYvASQ/ha67N+UguLeFbtN
muEPBSq83QIkwbGN8Nk0OdKlqwDoKDUOapjEp/rrTTOA85NFbFQC/WAOZEFEqltL
v8Nst8Xif4sIOnpYurLrsu6bVUlRsA==
=mxa9
-----END PGP SIGNATURE-----

--HQ4jA1N2etY42/kr--



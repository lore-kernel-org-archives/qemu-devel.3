Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A8BCD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVB64-0000vs-Hr; Thu, 04 Jun 2026 12:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVB63-0000vM-FP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVB61-00058T-LK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780591144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2r+fzOpo5enQdSe1jmJ0C+/wa4xJ8Pn+LBWPFKbjY40=;
 b=HDTp/d38Cdfd5jFTXvsgB47gTMthC6mIIbNkPnOIwXQG5oGKMMn3uEbEj3LMmsyg7gOIrX
 RpQBqBTeYEtahX3mY9t4f1WMa37U6qoCjodMBYqT1CG/hrhsCAOIFu5bnCa8F/OmBdTNcZ
 4lr8hzN014c4CW2HITVqHsBOom+Ozr0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-D4xkaiw8Op2hCC6E435Jgg-1; Thu,
 04 Jun 2026 12:39:01 -0400
X-MC-Unique: D4xkaiw8Op2hCC6E435Jgg-1
X-Mimecast-MFC-AGG-ID: D4xkaiw8Op2hCC6E435Jgg_1780591139
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8032180034C; Thu,  4 Jun 2026 16:38:58 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4458A27A; Thu,  4 Jun 2026 16:38:56 +0000 (UTC)
Date: Thu, 4 Jun 2026 12:28:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260604162853.GC115597@fedora>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DetFCX6AZnDHq900"
Content-Disposition: inline
In-Reply-To: <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--DetFCX6AZnDHq900
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 12:38:27PM +0200, Dorinda Bassey wrote:
> Hi All,
>=20
> Following up on this discussion: Albert, Stefano and I are organizing
> a BoF session on vhost-user for Linux Plumbers Conference, so this
> thread is very timely.
>=20
> > I get a sense that this is about politics in the end. Do people feel
> > they are not represented and would like to have more influence in the
> > vhost-user spec?
>=20
> I think the core issue is that vhost-user has grown beyond just QEMU.
> The spec is now implemented by rust-vmm, cloud-hypervisor, crosvm,
> libkrun, and others. All of these projects depend on the spec as their
> source of truth for interoperability.

vhost-user was always an effort spanning multiple projects - that is
fundamentally the purpose of the vhost-user protocol - so it bothers me
when it is framed this way. CrosVM implemented a vhost-user front-end
years ago. Features have been added to the spec that are not used by
QEMU because the spec is for all front-ends and back-ends and their
different use cases, not just QEMU.

I'm fine with moving the spec to a separate project if it makes
day-to-day work easier, but it's not accurate to portray vhost-user and
the work that has been done by people from many projects in this way.

> There are also concrete technical friction points. Let me share some
> examples from rust-vmm:
>=20
> rust-vmm SHMEM PR https://github.com/rust-vmm/vhost/pull/251
> We had to wait for QEMU spec acceptance before merging the
> implementation. The spec update was delayed with the comment
> "should get picked for the next round" after QEMU freeze.

I am happy to merge a vhost-user spec PR into qemu.git during the freeze
if other projects need the spec change.

> rust-vmm PR https://github.com/rust-vmm/vhost/pull/339 : was
> kept as draft "waiting for QEMU spec changes to be finalized."
> It was eventually merged when they decided the spec was
> "stable enough" even though QEMU hadn't finalized it yet,
> which felt awkward.

In this particular case the QEMU patch series could have been split into
just the spec change and the QEMU implementation with a note in the
cover letter requesting to merge the spec change right away. I don't
think anything was fundamentally blocking the spec change, although
maintainers might be skeptical about rushing something that is still
work in progress. There was a lack of communication here.

> When multiple independent implementations wait on one
> project's release cycles, it raises the question of whether the
> governance model matches the ecosystem reality.

If the experience with QEMU's release cycle is the main point of
friction, then that is easy to solve by merging spec changes even during
freeze.

>=20
> > Why is the current system not neutral and how will the new system solve
> > that?
>=20
> For example the virtio-spec has OASIS governance where changes
> are proposed and merged independently of any implementation's release
> cycle. Whether that's the right model for vhost-user is worth discussing.
>
> > You bring up project neutrality and a model where Michael is no longer
> > the sole maintainer. It will be necessary to propose a concrete roadmap
> > and also to explain the concerns about neutrality more so it's clear
> > they won't be an issue anymore in the future system.
>=20
> You're right that we need a concrete roadmap before making changes.
> More reason to discuss in the BoF - to work this out with the people
> actually doing the work: you, Michael, Albert, and others who've been
> deeply involved. Maybe in the end the solution might be to "improve
> QEMU's process" (like Michael's submodule suggestion) rather than
> "move the spec." or something else? that's what we need to figure out
> together.
>=20
> Would folks here be interested in joining the discussion at Plumbers?

Plumbers in October? How about scheduling a video call in the next few
days instead of waiting. That will allow anyone to attend.

Stefan

--DetFCX6AZnDHq900
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmohp8UACgkQnKSrs4Gr
c8gICggAmfO31ycvI1saRRHQ8FbegJUjYWapIIaTNsyfKsiRkbF8eHyFSE8n5yHk
63/8TepFvCR96RWl0vs3g3iNenamRF6Entd7RsgmuLF+ZIYuw7l8a9TebV8niit7
cJ7gy7k7si2TSkoD+GcLhDZTQQQOLrO1tbTnYXiZhRoR0+Ja2hUnXQxZY8puL4ES
eNV/5XeXI3UFLZJmaQ4lL4eXl+kvFVXMOk7I8tfScY5KBTxEALJx5nFvcpwxRZUn
NF60X86/jcXqEJFKy36JCZkxKEYG1GXa9m2fIflLxlZofbDG/HdmIeZop3ADZbE2
77yByygMc2FyUBlUDcPHuozmYB1AHg==
=pPYA
-----END PGP SIGNATURE-----

--DetFCX6AZnDHq900--



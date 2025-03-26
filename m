Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50BFC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRCE-0003yc-1c; Wed, 26 Mar 2025 09:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txRC8-0003xF-9c
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txRC6-0002UX-Jt
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742997200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bfDzmsWlUwF7J6hxY5lIe1L8gpPE8N7iisO+7RvgFd0=;
 b=d40MltxzVKRRp8KPHwL2KFe+zAVA3GvZuyhuL9nyJqgjF8h0IvdDVkZmlrjkcGATeZrm5j
 PTPpL3ZKxS7mPCEnxqIti1R6PQVjnnWdDCxOt0zlPCowKPMHR3LF5NZh2me2ECRaC+Isgu
 FiwqhzoaEfZMjkcgAro4U97RZhewve8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-GX2vTOJ2MP-RrYNi8CvvYg-1; Wed,
 26 Mar 2025 09:53:16 -0400
X-MC-Unique: GX2vTOJ2MP-RrYNi8CvvYg-1
X-Mimecast-MFC-AGG-ID: GX2vTOJ2MP-RrYNi8CvvYg_1742997195
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D30F118EBE99; Wed, 26 Mar 2025 13:53:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DDDD1955D81; Wed, 26 Mar 2025 13:53:12 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:53:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: vitalif@yourcmc.ru
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Can I contribute Vitastor block driver? Or maybe introduce a
 QAPI plugin system?
Message-ID: <20250326135311.GA783416@fedora>
References: <bd5c6126f8c345b1eeac617d4023fa58@yourcmc.ru>
 <871pukb08s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WtsyDcb1nTGtoBhz"
Content-Disposition: inline
In-Reply-To: <871pukb08s.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--WtsyDcb1nTGtoBhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:38:11AM +0100, Markus Armbruster wrote:
> I'm not speaking for the QEMU project.  I hope to be helpful anyway.  I
> am the QAPI maintainer, so my thoughts carry a bit more weight there.
>=20
> I understand your block driver depends on your libvitastor_client
> library.
>=20
> Dependencies that aren't available on at least one supported build
> platform (and thus covered by CI) are problematic.  For Linux,
> "available" generally means "provided by the distribution".  I doubt
> there's a way around getting your library packaged by distributions.
>=20
> The QAPI schema is (for better or worse) fixed at compile time by
> design.  Changing that would be a major undertaking.  Whether the
> benefits could justify the costs and risks seems rather doubtful to me.
>=20
> In my experience, the project invites contributions, not out-of-tree
> extensions.  The latter require external interfaces, which can only be
> harder to maintain than internal ones.  There's also the risk of abuse
> to circumvent the GPL (I have absolutely no reason to assume you'd try
> that!).

I want to share experience with QEMU block drivers over the years.
Special-purpose QEMU block drivers are being used less in favor of host
kernel drivers. Kernel drivers make the storage available to all
workloads (e.g. containers) on the system, not just QEMU VMs. In
particular, it reduces the amount of QEMU-specific support needed to
integrate into orchestration software (e.g. Kubernetes). Just a single
storage plugin for, say, Kubernetes, enables both container and VM
workloads if you provide a host kernel driver for your storage.

There can be performance advantages of implementing a QEMU block driver
compared to a host kernel driver, but I think in the long term it's
worth prioritizing a host kernel driver because it will reduce
maintenance for you and make your storage usable with more types of
workloads.

But the decision is up to you. A QEMU block driver might be preferrable.

Some more details about what Markus mentioned:

The first step is to ensure that dependencies are under licenses that
are compatible with the GPLv2.

If you want the block driver to be widely available to users, the next
step is to get dependencies packaged for for popular Linux distros. The
distro's QEMU packages need to link against the dependencies, so they
need to be in the distribution's package repositories, not in
third-party repositories.

Alternatively, if you will continue to distribute your own QEMU and do
not want to go through the effort of getting the dependencies into
distros, then you could contribute continuous integration (CI) jobs that
build with the third-party dependencies. However, the disadvantage is
that most users will be unable to use the block driver and the userbase
will be greatly limited.

Both of these approaches put the block driver (and associated QAPI
schema changes) in qemu.git/master and you would be the maintainer of
the block driver.

Stefan

--WtsyDcb1nTGtoBhz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfkBscACgkQnKSrs4Gr
c8ggogf+Ilh+hrcKSH7naTOekSmCPGL39Qmft7jBIYw0rJW7JZRFCfBD+fAOZEdk
KZJVKKxpemviCsPEpRQMg9T16Vveri509dt/eCS2qhw+6ObO9fPp3DzO8v6whVVQ
4tA0jnM1RLOFJ9GYxM+HmZrIdwzpBERfyc/mkd523jpoGi3PhU0aPNtGf2lv+c/s
q43wuSSS7pP/hjLqJnCvrceicDjZOAulDLBmLoXedct+03AqFnduE8YpUvjoCNbB
bU6NaWDOVTFdDUUqwtfDvlwSA2aaAvha20R0YsGxu43omztM4Ec6iaTHQKy/dPJ3
mrrINwIKiJgWrFOw4HjRatPVSOsiAg==
=PUOL
-----END PGP SIGNATURE-----

--WtsyDcb1nTGtoBhz--



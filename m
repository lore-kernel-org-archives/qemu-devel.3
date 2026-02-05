Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F0E91297
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0Lm-0005vy-HL; Thu, 05 Feb 2026 09:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vo0Lk-0005mk-S1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vo0Li-0008Nl-G3
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770301729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFteZ2+Uw8FcJX3AH82Qy03uqI7C9vH6wAHLKqQei38=;
 b=NiR92I+oHLchFPVTHEEgem3DtQdaQAwPfUwiJDnx1aBU1MDeEwMenDYaXRVC5QLWYND7Gl
 x26y0l+QLhbwGgoInwwvEM5kF23q2t5ALv8W0twOyj1WjDmOQXm3xUikB0bdEjwkrfBIoX
 fj1htSAv3owAnu+fm0C4+KL2kigErv4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-rfWDFL8HOnW5lpyOs5f74w-1; Thu,
 05 Feb 2026 09:28:47 -0500
X-MC-Unique: rfWDFL8HOnW5lpyOs5f74w-1
X-Mimecast-MFC-AGG-ID: rfWDFL8HOnW5lpyOs5f74w_1770301726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5482B1955E7E; Thu,  5 Feb 2026 14:28:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 817DA18003F6; Thu,  5 Feb 2026 14:28:45 +0000 (UTC)
Date: Thu, 5 Feb 2026 09:28:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260205142844.GB36872@fedora>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RYSsR4JzeCjlV4k7"
Content-Disposition: inline
In-Reply-To: <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--RYSsR4JzeCjlV4k7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:52:33PM +0100, Martin Wilck wrote:
> On Wed, 2026-02-04 at 13:32 -0500, Stefan Hajnoczi wrote:
> > On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > Getting back to the application vs DM-Multipath advantages: I think
> > it's
> > worth simplifying things for applications because there are many
> > applications and only one DM-Multipath.
>=20
> TBH, I don't see so many applications. Actually I am having trouble
> finding any application at all that uses the generic linux PR
> functionality. I haven't even found a basic command line tool that
> encapsulates the ioctls, are you aware of one? That would be the first
> thing we need, be it only for testing the kernel.

blkpr(8) is part of util-linux:
https://github.com/util-linux/util-linux/blob/master/sys-utils/blkpr.c

> As for applications using SCSI/NVMe PRs, I also don't see many, at
> least not in the Linux / open source realm. Actually, qemu is the only
> one that immediately comes to my mind. I can imagine that storage
> management tools for e.g. OpenStack or Kubernetes would want to use
> PRs, but I don't know any details.

HA/clustering frameworks as well.

> Wrt sockets, not sure what's so painful about them. multipathd recently
> enabled a pathname sockets for qemu-pr-helper in KubeVirt [1].

This is a good example. KubeVirt has code to:
- Create a pr-helper container image with qemu-pr-helper,
  libmpathpersist, and a multipath.conf file.
- Run the pr-helper container with the host's multipathd socket and
  /etc/multipath directory passed through.
- Run a multipath-monitor daemon that remounts the multipathd UNIX
  domain socket bind mount when it changes (multipathd restart?).

And that's just at the KubeVirt level. Libvirt and QEMU also have code
to make this possible.

That is a lot of setup! All of this goes away if QEMU can use
<linux/pr.h> ioctls instead of libmpathpersist. It's just not needed.

Stefan

>=20
> Thanks,
> Martin
>=20
> [1] https://github.com/opensvc/multipath-tools/issues/111
>=20

--RYSsR4JzeCjlV4k7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmEqRwACgkQnKSrs4Gr
c8j1KggArppbQqNV0mqFtcjG7RKw3iWvERbsp6RP1kxShcdpkmS/kjutOi/816SW
xams/qmF5AaIqPTdxZkMo2+CQIbDOt6X5B75Jnejt+zBUfgdwbCWQl4YQnsvbx6T
nZjzoWjo0KsxPuke5/bEeR+AHNAekb6c47TgKOJKGJfAv537lPkWoqD9heVmVPGY
LNGNOWpxMKhDGko/OsOQK5RbthUkuuEbWpC1w7jaIeGS6cfHkAes3rn7ud1m3sgy
YJt6MtN+HwqL3BFCO6JeYByiGIONiI3xLHP296nnm2gRqJ+FePhjxQirmfSLx2eR
bB8RTxhsXFxKTDWCAsSUtRvW9g+kHw==
=n2cU
-----END PGP SIGNATURE-----

--RYSsR4JzeCjlV4k7--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA0CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2WU-00005m-OH; Thu, 23 Oct 2025 17:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WS-0008WA-PI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WP-0004SW-SL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761253617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMEgnYJDKdowTPvz/3408q2rHSgYXGdIAzOGDMufmEs=;
 b=JIGL6Q+GIHHQOVs1/903zv3n4nxp3cNYtEG/ibeo7xpi0J2zoC8s5NFFqHT9r+KtbsIeDA
 6ImWffXTgT7xedpLPq0ckxAK2KLNzJ+cu7T8o9J+DOiilKxF+EE4mrkkgjpTbabRURw+oD
 vU+FgH6DCScXk40AoTc/VoOzcVetC4w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-QjYylVzJNrq2al-xMeAKmw-1; Thu,
 23 Oct 2025 17:06:53 -0400
X-MC-Unique: QjYylVzJNrq2al-xMeAKmw-1
X-Mimecast-MFC-AGG-ID: QjYylVzJNrq2al-xMeAKmw_1761253612
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CD1B195608E; Thu, 23 Oct 2025 21:06:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 843BF30002DB; Thu, 23 Oct 2025 21:06:51 +0000 (UTC)
Date: Thu, 23 Oct 2025 16:47:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 05/12] aio: remove aio_context_use_g_source()
Message-ID: <20251023204755.GA196190@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-6-stefanha@redhat.com>
 <aOfY8TgysdujAL-l@redhat.com> <aOfp6I_v6N3dc-YB@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="unDAq983oZjGUA6F"
Content-Disposition: inline
In-Reply-To: <aOfp6I_v6N3dc-YB@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--unDAq983oZjGUA6F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:59:20PM +0200, Kevin Wolf wrote:
> Am 09.10.2025 um 17:46 hat Kevin Wolf geschrieben:
> > Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > > There is no need for aio_context_use_g_source() now that epoll(7) and
> > > io_uring(7) file descriptor monitoring works with the glib event loop.
> > > AioContext doesn't need to be notified that GSource is being used.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> >=20
> > We should probably mention in the commit message that this causes the
> > default fdmon on Linux to change from poll to io_uring. It's a small
> > code change, but it makes QEMU use a completely different code path by
> > default.
>=20
> Just to make sure, I ran 'make check' after this patch and it's failing
> for me:
>=20
>  10/401 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test                 =
   TIMEOUT        150.02s   killed by signal 15 SIGTERM
> 133/401 qemu:unit / test-aio                                             =
   TIMEOUT         30.01s   killed by signal 15 SIGTERM
> 137/401 qemu:unit / test-bdrv-drain                                      =
   TIMEOUT         30.01s   killed by signal 15 SIGTERM
> 142/401 qemu:unit / test-block-iothread                                  =
   TIMEOUT         30.01s   killed by signal 15 SIGTERM
> 192/401 qemu:doc+rust / rust-bql-rs-doctests                             =
   FAIL             0.84s   exit status 101
> 311/401 qemu:block / io-qcow2-267                                        =
   ERROR            3.20s   exit status 1
> 321/401 qemu:block / io-qcow2-copy-before-write                          =
   TIMEOUT        180.01s   killed by signal 15 SIGTERM
>=20
> Some of them look unrelated, but I have confirmed that the three unit
> tests still pass before this patch (and still hang after the complete
> series).

I pushed my latest rebased code with many of your review comments
addressed here:
https://gitlab.com/stefanha/qemu/-/tree/aio_add_sqe

It doesn't contain any fixes specifically for the hangs, but it's what
I've been testing here.

Stefan

--unDAq983oZjGUA6F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj6lHsACgkQnKSrs4Gr
c8hdlgf/XkYKzWoyk3OfsQU5jMaIf8nnOlbIVVxXXu/G7VyGGVHrFfMrJi+u5XkR
wLlYBNlJ2/oPeUFQx7lHxjY9WxTuRBw8IemBGlFpAtyKc9USntyyLJ1UdwTYvsgW
ZgsEfHCu4FCItCOiX7TV55Birhlq4PS3Gmy6o3XaQCv5+57fDyN/ypzSdVLlTwxY
aLRmvt9rl02E9FNz+TIplmKxFJj1o3wZk4Vlxp88fSHEKTF4x6jcsY9E/y5221Dl
TmqarnLHavVHKyIsN4E/3jHvz5WTw+dCpiFGQNkEo0J5F3pQfjpTKk2JCMoemTdA
Hyfm9OuA+Sma4lsuCywLR1SKBEFR5A==
=cT9h
-----END PGP SIGNATURE-----

--unDAq983oZjGUA6F--



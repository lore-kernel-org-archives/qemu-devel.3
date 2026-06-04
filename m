Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F55DCD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVE2n-0006FB-4v; Thu, 04 Jun 2026 15:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVE2i-0006EU-AV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVE2g-0007tU-Lx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780602467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXSafxI5C+ejocUzXL62dyic+kxzIbswd9XrqBAojEA=;
 b=YnOLsDw3ZxNUksZRqeDBxZ1vDpjWPT/ijqycMHQYRE48918if2rcZ/bMQ9uXYcmyf1WTEM
 cTv2zlnFV3yaaUKnF8+E+3PXRSZDcgPEN8ctkeLxDYgv6OjHWbPjt0S58/Dp0E0hVgNxYM
 HNg2hPGu3IdiBX5T5pzJapwGK2/vg1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-L3ALPqjCODiFwUVJnQXf0w-1; Thu,
 04 Jun 2026 15:47:46 -0400
X-MC-Unique: L3ALPqjCODiFwUVJnQXf0w-1
X-Mimecast-MFC-AGG-ID: L3ALPqjCODiFwUVJnQXf0w_1780602465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A7CA1956046; Thu,  4 Jun 2026 19:47:45 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56BB4180049F; Thu,  4 Jun 2026 19:47:44 +0000 (UTC)
Date: Thu, 4 Jun 2026 15:47:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 hreitz@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 gmaglione@redhat.com
Subject: Re: [PATCH v2 2/3] libvhost-user: look for available vq buffers upon
 SET_VRING_KICK
Message-ID: <20260604194743.GA149856@fedora>
References: <20260519191548.335082-1-stefanha@redhat.com>
 <20260519191548.335082-3-stefanha@redhat.com>
 <ah_rtghBvzQgN8fy@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OjUM0IJowJDEy75W"
Content-Disposition: inline
In-Reply-To: <ah_rtghBvzQgN8fy@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--OjUM0IJowJDEy75W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 11:03:18AM +0200, Stefano Garzarella wrote:
> On Tue, May 19, 2026 at 03:15:47PM -0400, Stefan Hajnoczi wrote:
> > When a vring is started the back-end must look for available vq buffers
> > and process them. This scenario can happen if the back-end is stopped
> > with unprocessed available buffers and then started again.
> >=20
> > The inflight I/O tracking code already did this, but it should also be
> > done when inflight I/O tracking is not enabled. Move the code.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > subprojects/libvhost-user/libvhost-user.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/li=
bvhost-user/libvhost-user.c
> > index 9c630c2170..2e286ea6d9 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -1390,11 +1390,6 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
> >         vq->counter =3D vq->resubmit_list[0].counter + 1;
> >     }
> >=20
> > -    /* in case of I/O hang after reconnecting */
> > -    if (eventfd_write(vq->kick_fd, 1)) {
> > -        return -1;
> > -    }
> > -
> >     return 0;
> > }
> >=20
> > @@ -1436,6 +1431,11 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg =
*vmsg)
> >         vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
> >     }
> >=20
> > +    /* Inject a kick to look for available vq buffers */
> > +    if (eventfd_write(dev->vq[index].kick_fd, 1)) {
>=20
> Should we check if kick_fd is not -1 like we already do in other places in
> this function? (mainly when `nofd` is true)
>
> > +        return -1;
>=20
> This function returns boolean, -1 is `true` and IIUC means that we ask fo=
r a
> reply which is not the case here. We should fix it.

Thanks for catch these things. I'm going to redo this patch. Not sure
what I was thinking :).

Stefan

--OjUM0IJowJDEy75W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoh1l8ACgkQnKSrs4Gr
c8g+IQf+JBMZ/ZIgzXkUb8MPAeNPMzc3Y+yr7m/E9PaIVnDxDPzHATCgCXqiybKx
yTZryijUx0xEplBZMXweOyDUO8KkBaLmp1ajhWWnylS6LAiwycq7nJqaGwDReiK/
rM5mEbb6gtAie2qBpvCKThMhDPeEoD4YrZWJljQpwH6GkDdFPlMHgag064nXgxyJ
sJ3jDIEPBEGKGXzqgY4Knsa6zlBkVvMJJvCjjWlI6JFpoyOwKTcCWQU7lrPXEtrM
AhjOLLNjtx0RGl0GQcreSEYNLNq4A6XEezekKR+gQp3NPsQQ4/eCGfORhUtgCbV9
4IabUPb8XmLD0PB+n1Hi5oYCGc+oYw==
=gt1e
-----END PGP SIGNATURE-----

--OjUM0IJowJDEy75W--



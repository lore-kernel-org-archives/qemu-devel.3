Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0864CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 18:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPPCR-0001ux-5K; Tue, 19 May 2026 14:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPCO-0001ui-TU
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPCM-0004Zz-5f
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779215383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54PMew2yak8E7NR+rfJzynaCRq8iFNdRLqBv7E4o2SU=;
 b=Xm2xVGk8sznGHzgIGBLFJZA1syFhqn5D+DtRfOtJDNMlir/ptX43AvD9mBboeAmlvf5V7G
 q00DPo4Yl162zlT5Z8/g0RnO5+sWtK5JY5pHlspjOoM51lijCqxpENC4s6BaGqAbwshd5+
 sBMKHCA0ZKMy+Z615GnhLH6riQZWFzg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-bF_IwdhpPWWVQiG-Czy8mQ-1; Tue,
 19 May 2026 14:29:39 -0400
X-MC-Unique: bF_IwdhpPWWVQiG-Czy8mQ-1
X-Mimecast-MFC-AGG-ID: bF_IwdhpPWWVQiG-Czy8mQ_1779215378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E8D180061A; Tue, 19 May 2026 18:29:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E556D1956053; Tue, 19 May 2026 18:29:36 +0000 (UTC)
Date: Tue, 19 May 2026 14:29:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jorge Moreira <jemoreira@google.com>
Subject: Re: [RFC] vhost-user.rst: clarify when rings are started
Message-ID: <20260519182935.GC119642@fedora>
References: <20260429185504.221124-1-stefanha@redhat.com>
 <afxjPwqPAfTz2vzs@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y6LTXPNL0NYhtXVF"
Content-Disposition: inline
In-Reply-To: <afxjPwqPAfTz2vzs@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--y6LTXPNL0NYhtXVF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 12:17:14PM +0200, Stefano Garzarella wrote:
> On Wed, Apr 29, 2026 at 02:55:04PM -0400, Stefan Hajnoczi wrote:
> > Jorge Moreira <jemoreira@google.com> pointed out that the ring state
> > machine is underspecified. In the discussion that followed, we
> > discovered that the spec says one thing and implementations do something
> > else. This patch updates the spec to reflect how things are actually
> > implemented across widely-used front-ends and back-ends including QEMU,
> > crosvm, rust-vmm, and DPDK. Do this while taking care not to make any
> > other existing implementations non-compliant by changing the sepc.
> >=20
> > The spec says rings are started when a kick is received but the
> > implementations actually start rings when VHOST_USER_SET_VRING_KICK is
> > received.
> >=20
> > Reconcile this as follows:
> > - Clarify that a ring can be stopped and then started again. The
> >  back-end must resume processing available requests when the ring is
> >  restarted.
> > - Update the spec to say rings are started when
> >  VHOST_USER_SET_VRING_KICK is received.
> > - Ensure compatibility by saying front-ends SHOULD inject a kick in case
> >  the back-end strictly implemented the old spec.
> > - Avoid future back-end dependencies on injected kicks by saying that
> >  back-ends SHOULD NOT expect a kick to start rings.
> >=20
> > This way implementors have clarity on how things work while still
> > allowing compatibility for existing implementations.
> >=20
> > Reported-by: Jorge Moreira <jemoreira@google.com>
> > Cc: "Michael S . Tsirkin" <mst@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > This is an RFC because I will update hw/virtio/vhost-user.c and
> > libvhost-user once we've agreed on the spec wording.
> >=20
> > docs/interop/vhost-user.rst | 24 ++++++++++++++++++------
> > 1 file changed, 18 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 137c9f3669..72d792930e 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -462,12 +462,24 @@ Rings have two independent states: started/stoppe=
d, and enabled/disabled.
> > * started and enabled: The back-end must process the ring normally, i.e.
> >   process all requests and execute them.
> >=20
> > -Each ring is initialized in a stopped and disabled state.  The back-end
> > -must start a ring upon receiving a kick (that is, detecting that file
> > -descriptor is readable) on the descriptor specified by
> > -``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
> > -``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
> > -``VHOST_USER_GET_VRING_BASE``.
> > +Each ring is initialized in a stopped and disabled state.  Rings are s=
tarted
> > +with ``VHOST_USER_SET_VRING_KICK`` and stopped with
>=20
> In the VHOST_USER_SET_VRING_KICK description we say:
>=20
>                                    Note that if the protocol feature
>   ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` has been negotiated
>   this message isn't necessary as the ring is also started on the
>   ``VHOST_USER_VRING_KICK`` message, it may however still be used to
>   set an event file descriptor (which will be preferred over the
>   message) or to enable polling.
>=20
> I think we need to clarify a bit more what happens if
> VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is negotiated. In that case, I
> don't think we can necessarily require the frontend to send
> VHOST_USER_SET_VRING_KICK to start the rings.
>=20
> What about: Rings are started with ``VHOST_USER_SET_VRING_KICK`` (or
> ``VHOST_USER_VRING_KICK`` if negotiated) ...
>=20
> ... A stopped ring enters the started state again with
> ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if negotiated)
> and the back-end resumes processing requests.

Sounds good to me. I will send a non-RFC version including this change.

Stefan

--y6LTXPNL0NYhtXVF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMrA4ACgkQnKSrs4Gr
c8gQJAgAlFIyixK/rnjTYTjrgpPeuh9M0ja/35zq5/SL6+8CpTlykLPJe8Pbnq0k
vB2Pu7z/DhFgqWcScOgdT934rstOYAZhOUoki+JsgRb54Nn9b+SGZthaCRh81LPr
FIM8Hm4JulqU0+6zlH98LMJkTlxGoW3PMxm+RYNR5slGVYbq3xxEjof7QhDVd+fo
1gw8YE8Z6slzjdzZ612TDDLtCKNX0c7LO+GSpuBgy8no9uZTBKOzZjOPmGLaUfZb
5FYFEOZ4oB0jJoWUubysG3KLzFvDb567Uqvk3EjcJjmPD0a1Z9S/id2g1pQjkO6w
Yuk1TlqGnG7CjEb4Vup8L5Xn2yjAMQ==
=pd1m
-----END PGP SIGNATURE-----

--y6LTXPNL0NYhtXVF--



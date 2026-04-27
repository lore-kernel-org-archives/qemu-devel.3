Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AECFF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHUiJ-0003y3-JS; Mon, 27 Apr 2026 18:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHUiI-0003xg-Kj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 18:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHUiC-0005GE-4h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 18:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777329954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KY+Qxr4Xuu4B/qsQnNyEQkfKF5LUndllTW761FqOerg=;
 b=VA2nUOx3yCt9mRmi20N9sOqUXrSxV0KmExe0enPI/IpaBNi1nb4x6p/DfReCJnPrpEK+0N
 aA6c66joxbAJDWi09PUCOwhw7mpCSecO0WkKK5fons8140/VR0U5Gkq5c+5h96hXtc29al
 06Ci9Q0AbnDFzxBbSCqtP3uc9LLCW8g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-0VynG02dNASKyydY448d6A-1; Mon,
 27 Apr 2026 18:45:51 -0400
X-MC-Unique: 0VynG02dNASKyydY448d6A-1
X-Mimecast-MFC-AGG-ID: 0VynG02dNASKyydY448d6A_1777329950
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD28818003FC; Mon, 27 Apr 2026 22:45:49 +0000 (UTC)
Received: from localhost (unknown [10.44.48.31])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1334D300070A; Mon, 27 Apr 2026 22:45:47 +0000 (UTC)
Date: Mon, 27 Apr 2026 18:45:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260427224545.GH218226@fedora>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="woZ49ArodzuJ24yY"
Content-Disposition: inline
In-Reply-To: <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--woZ49ArodzuJ24yY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wrot=
e:
> > >
> > > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > >
> > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > > > While starting the vrings on SET_VRING_KICK could solve the state
> > > > > machine issue, it still won't notify the back-end that buffers are
> > > > > ready (the driver won't do this). Non-polling back-ends depend on=
 this
> > > > > kick, especially for queues where data flows only from the driver=
 to
> > > > > the back-end. Most implementations likely attempt to read from the
> > > > > queue only after receiving the kick.
> > > >
> > > > This is an interesting question to clarify in the spec.
> >
> > Yep, which is in part related to what I wrote in the other reply:
> > "I think the main issue to clarify is what the device should do
> > when the vrings are configured, but the driver has already been
> > initialized (which is usually the case after migration)."
> >
> > > >
> > > > Stefan
> > >
> > > This is the question that interests me most, to be honest. I'd rather
> > > have the discussion about when to activate the vrings in a different
> > > thread and keep this one focused on whether the front-end should send
> > > the kick or if the back-end is expected to check if there are "new"
> > > buffers in the vring after restore.
> > >
> >
> > IMO we don't need anything from the VMM. When the device receives
> > SET_VRING_KICK, it can check if the vring already contains buffers
> > (and this is the part we might need to clarify) and wake-up the other
> > threads (or always wake-ups them, as crosvm does IIUC, and let them
> > perform this check).
> > After sending the SET_VRING_KICK message to the device, the VMM has
> > the exact same knowledge of the vring state as the device, therefore,
> > it's still unclear to me why we need to inject that kick.
> >
> > Stefano
> >
>=20
> Is it possible to activate a vring after it has been deactivated with
> VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
> kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> reactivate it?

Hi Jorge and Stefano,
Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs when
a VM is paused and then resumed.

You can stress test this by driving I/O using iperf (virtio-net) or fio
(virtio-blk) inside the guest and sending 'stop'/'cont' commands to
QEMU's monitor.

Here is QEMU's code for starting (including re-starting) rings:
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?ref_ty=
pe=3Dheads#L1341

QEMU does not inject a kick. The back-end must check the rings itself.

I'm not sure that all vhost-user back-ends actually check the rings. I
think back-ends should do it, but we should also update the spec with an
front-end implementation note recommending injecting a kick after
VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
with implementations that follow the current spec wording. And at the
same time I think the spec should also be changed to say that
VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check the
vring upon processing the message.

That seems like it would clean up the issues without introducing
compatibility issues or making existing implementations non-compliant
with the updated spec.

What do you think?

Stefan

--woZ49ArodzuJ24yY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnv5xkACgkQnKSrs4Gr
c8gwnwf/dVH0le+pTq7BbMCkB4E4a+YwsKleNNIn/eO4lviE0pP2VPriuES38VKo
UidbQ0+4StxArA6Rq0/qe2BEr5hTeBgzfQRRnaNpf18aZ8sOpzCRnGZ4oTk+3/pI
wOvPCme59bY7RNXS/GnNUSG9rEKsF6AVKOdXu/p+pr4bLuuNEe0Euj+N7zwMnzJc
DPbAoLo0fanHX0XN1toca/8au+mLKHEXwFase33wXY/0S6W5kI1akvG73jp/f1tj
Vad3B/Uek4O82+QSn5OU3EVbd5oMsjRZ45MQ62q+6vD19ObWb/3/YLwKPBZlB9wi
AQuZMI7FbKvwZLRmZfgwdv0zPVwLFQ==
=cr/Z
-----END PGP SIGNATURE-----

--woZ49ArodzuJ24yY--



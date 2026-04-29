Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39B3CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI7Bw-0006Lu-EY; Wed, 29 Apr 2026 11:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7Br-0006Kc-ST
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7Bp-0004kx-BI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777477862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISZEAZ7VMWWT4Bw50hN9nNn/vvnM1Q6eoaJ/YXhlgHo=;
 b=CEA7+A6B6Ab5cOpCnNjhZuuSHlQVZsKFgjXon+T2M5N3fVbeGO0TEKxfAxGQpKSmuffkIk
 PxOtmBYNRyPVWDbRtT6/gjFtXa3bIv0mRVduyd7i1wmzI1CgthnZ7Jbmgvb4vxsTdw/PyG
 wK2SR5PhOOibbLzupePj60YY/7JlHLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-Ruk4-R88OtWHpOkqF94hRA-1; Wed,
 29 Apr 2026 11:51:00 -0400
X-MC-Unique: Ruk4-R88OtWHpOkqF94hRA-1
X-Mimecast-MFC-AGG-ID: Ruk4-R88OtWHpOkqF94hRA_1777477859
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D470F195608D; Wed, 29 Apr 2026 15:50:58 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95DD11800480; Wed, 29 Apr 2026 15:50:56 +0000 (UTC)
Date: Wed, 29 Apr 2026 11:50:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jorge Moreira <jemoreira@google.com>,
 Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260429155055.GA12211@fedora>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
 <20260428025111-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pIKY3MKqzu32nLxz"
Content-Disposition: inline
In-Reply-To: <20260428025111-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--pIKY3MKqzu32nLxz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 02:59:58AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 27, 2026 at 06:45:45PM -0400, Stefan Hajnoczi wrote:
> > On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> > > On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarzare@=
redhat.com> wrote:
> > > >
> > > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> =
wrote:
> > > > >
> > > > > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha=
@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > > > > > While starting the vrings on SET_VRING_KICK could solve the s=
tate
> > > > > > > machine issue, it still won't notify the back-end that buffer=
s are
> > > > > > > ready (the driver won't do this). Non-polling back-ends depen=
d on this
> > > > > > > kick, especially for queues where data flows only from the dr=
iver to
> > > > > > > the back-end. Most implementations likely attempt to read fro=
m the
> > > > > > > queue only after receiving the kick.
> > > > > >
> > > > > > This is an interesting question to clarify in the spec.
> > > >
> > > > Yep, which is in part related to what I wrote in the other reply:
> > > > "I think the main issue to clarify is what the device should do
> > > > when the vrings are configured, but the driver has already been
> > > > initialized (which is usually the case after migration)."
> > > >
> > > > > >
> > > > > > Stefan
> > > > >
> > > > > This is the question that interests me most, to be honest. I'd ra=
ther
> > > > > have the discussion about when to activate the vrings in a differ=
ent
> > > > > thread and keep this one focused on whether the front-end should =
send
> > > > > the kick or if the back-end is expected to check if there are "ne=
w"
> > > > > buffers in the vring after restore.
> > > > >
> > > >
> > > > IMO we don't need anything from the VMM. When the device receives
> > > > SET_VRING_KICK, it can check if the vring already contains buffers
> > > > (and this is the part we might need to clarify) and wake-up the oth=
er
> > > > threads (or always wake-ups them, as crosvm does IIUC, and let them
> > > > perform this check).
> > > > After sending the SET_VRING_KICK message to the device, the VMM has
> > > > the exact same knowledge of the vring state as the device, therefor=
e,
> > > > it's still unclear to me why we need to inject that kick.
> > > >
> > > > Stefano
> > > >
> > >=20
> > > Is it possible to activate a vring after it has been deactivated with
> > > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
> > > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> > > reactivate it?
> >=20
> > Hi Jorge and Stefano,
> > Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs when
> > a VM is paused and then resumed.
> >=20
> > You can stress test this by driving I/O using iperf (virtio-net) or fio
> > (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
> > QEMU's monitor.
> >=20
> > Here is QEMU's code for starting (including re-starting) rings:
> > https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?re=
f_type=3Dheads#L1341
> >=20
> > QEMU does not inject a kick. The back-end must check the rings itself.
>=20
>=20
> I would worry that there could be buggy drivers that expect buffers not
> consumed until the 1st kick.

This describes the behavior today. I'm not sure whether you are
commenting on the paragraph I wrote below suggesting how to change
things or whether you are commenting on the current state?

> A safer thing to do would be for source to record the fact there
> was a kick after reset and for destination to then inject/check.

Can you rephrase that, it's unclear to me what "source" and
"destination" mean?

Thanks,
Stefan

> > I'm not sure that all vhost-user back-ends actually check the rings. I
> > think back-ends should do it, but we should also update the spec with an
> > front-end implementation note recommending injecting a kick after
> > VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
> > with implementations that follow the current spec wording. And at the
> > same time I think the spec should also be changed to say that
> > VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check the
> > vring upon processing the message.
> >=20
> > That seems like it would clean up the issues without introducing
> > compatibility issues or making existing implementations non-compliant
> > with the updated spec.
> >=20
> > What do you think?
> >=20
> > Stefan
>=20
>=20

--pIKY3MKqzu32nLxz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnyKN4ACgkQnKSrs4Gr
c8hG9wf8C88jPEDgW2AmKGwYu6wYS++24GO+D9lkftmwB+FTqx40JzH0SPD4PPu9
7JomubO95MgKjMmuo48siGGSwaVpBBHfMVPe8U5UKZcnR0YDEoml/NkW67ncYq4Z
yeKlrmPX7CBrzz62Xvt5eehF9j9+xW/A26jdBlnCP/pRli1EWH/RNhglKkRy0zdT
+c+8a0dFH8Ossk2VSxhiiCmF9BAjZEd9WZsotKnKIvaxlYfszTiChwVDjeG4X7Vd
YWegXw5L08wBrOr0W/1itiR3k0B7830Zm9e71TC1K/m+ehUds9skMuu9KoV+eURG
82tVwTxYCCe5/mu+X+/pYQ0A5D/aHQ==
=gDNZ
-----END PGP SIGNATURE-----

--pIKY3MKqzu32nLxz--



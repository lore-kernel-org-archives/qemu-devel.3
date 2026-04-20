Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A506DF5A8A6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEtCh-00075D-El; Mon, 20 Apr 2026 14:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wEtCf-00074m-Eu
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wEtCd-0007al-0j
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776709112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Mw3UxDSlWQfIQBESt1iS3hcZaoIuJju3aVW2QdXnhg=;
 b=Dq7UaGBE/fML7lvqJfM0oWcG10gAwn9O3GOoqu2OR8up/IoS/BRkjEvt0q8w7AVS0Ak8jP
 zTzSDRGHdgtSOaonlsFGcEFxJaWnFRPbIkesNMyfgUmeCuMm5q2QORLFbHiqbqZfQENYs5
 6JwyB99l31/+ktY/QiN4mqWKRrp+r+M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-GXxPUj2TPYCvxLCFNmlEAw-1; Mon,
 20 Apr 2026 14:18:28 -0400
X-MC-Unique: GXxPUj2TPYCvxLCFNmlEAw-1
X-Mimecast-MFC-AGG-ID: GXxPUj2TPYCvxLCFNmlEAw_1776709107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A86B18002C6; Mon, 20 Apr 2026 18:18:27 +0000 (UTC)
Received: from localhost (unknown [10.44.48.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32F1D180047F; Mon, 20 Apr 2026 18:18:25 +0000 (UTC)
Date: Mon, 20 Apr 2026 14:18:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Jorge E. Moreira" <jemoreira@google.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260420181818.GC405461@fedora>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ua8tN7kV5wsX8Nm1"
Content-Disposition: inline
In-Reply-To: <aeYvCK2qhZd1W9sA@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ua8tN7kV5wsX8Nm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 04:49:04PM +0200, Stefano Garzarella wrote:
> Thanks for starting the discussion here, let me add also Hanna, German, a=
nd
> Stefan in CC that can help us.
>=20
> On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > Migration of back-end state happens while the device is suspended (i.e
> > all vrings are stopped). To resume normal operation on the destination,
> > the vrings need to be started again with a kick (either a write on the
> > FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While
>=20
> It's true that in the spec we have:
>   "Each ring is initialized in a stopped and disabled state. The   back-e=
nd
> must start a ring upon receiving a kick (that is, detecting   that file
> descriptor is readable) on the descriptor specified by
> VHOST_USER_SET_VRING_KICK or receiving the in-band message
> VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving
> VHOST_USER_GET_VRING_BASE."
>=20
> But IMO this applies when a driver is not yet loaded.
> When we are migrating, the driver could be already loaded. So, in the new
> device running in the destination, IMO we should consider the ring already
> started or add some messages to tell to the device: "hey, the device was
> already started, this is a migration and it's completed".
>=20
> Sending a kick from the frontend, seems more an hack here.
>=20
> That said, for example, in subprojects/libvhost-user/libvhost-user.c IIUC
> the virtqueue is started when the SET_VRING_KICK is handled by
> vu_set_vring_kick_exec(), but not sure how compliant it is.
>=20
> > these notifications are typically sent by the driver, it has no reason
> > to send them in the destination if it already sent them in the source as
> > the driver is unaware that a migration took place. Therefore it should
> > be the responsibility of the vhost-user front-end to ensure these vrings
> > are started. This is particularly necessary for queues where data only
> > flows from device to driver, such as those used by the vsock and input
> > devices.
>=20
> Exactly, so IMO we should not use the kick, but maybe add something new or
> clarify what to do after the migration.
>=20
> For example in the "Migrating back-end state" we have:
>   "Migrating device state involves transferring the state from one
> back-end, called the source, to another back-end, called the   destinatio=
n.
> After migration, the destination transparently resumes   operation without
> requiring the driver to re-initialize the device at   the VIRTIO level."
>=20
> So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly to
> inform the new device about the state: "there isn't any state to transfer,
> but I notify you that the device was already initialized, so the vrings c=
an
> be started".
>=20
> >=20
> > This behavior is already used by some qemu vhost-user front-ends (e.g
> > vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosVm).
>=20
> I looked at vhost-user-blk frontend, but I don't see it. I mean I see the
> code around the comment "/* Kick right away to begin processing requests
> already in vring */" but that one IIUC was introduced more to fix devices
> violating specs, so not sure it's a good example to follow:
>=20
> commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> Author: Yongji Xie <elohimes@gmail.com>
> Date:   Wed Jun 6 21:24:48 2018 +0800
>=20
>     vhost-user-blk: start vhost when guest kicks
>     Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs ear=
ly")
>     kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This violates
>     the virtio spec. But virtio 1.0 transitional devices support this beh=
aviour.
>     So we should start vhost when guest kicks in this case.
>     Signed-off-by: Yongji Xie <xieyongji@baidu.com>
>     Signed-off-by: Chai Wen <chaiwen@baidu.com>
>     Signed-off-by: Ni Xun <nixun@baidu.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>=20
> > Adding it to the vhost-user documentation makes it explicit that this
> > strategy is permitted and suggest it to vhost-user front-end authors.
> > Explicitly documenting it is necessary because vring kicks appear
> > designed to originate in the driver, so having some originate in the
> > front-end can be counterintuitive and cause developers to waste time
> > looking for other alternatives or face pushback during code review.
>=20
> As I pointed out in our discussion in
> https://github.com/rust-vmm/vhost-device/pull/936
> IMO we should use some in-band messages and not relaying on kicks that
> should be used only by the driver to notify the device about new available
> buffers.
>=20
> That said, I agree that we need to clarify in the specifications exactly
> what the backend and frontend should do after a migration to start vrings=
 if
> there is no need to exchange a state.
>=20
>=20
> Any other opinion?

IMO no protocol changes are needed but the vhost-user spec should be
tweaked. Hanna worked on device state migration and can confirm/deny
what I'm about to describe.

QEMU's libvhost-user implementation already starts the ring when
VHOST_USER_SET_VRING_KICK is received. This makes more sense than
waiting for the kick fd since a back-end that uses polling (peeking at
the vring in memory) shouldn't need to monitor the kick fd. See below
though about races between the kick fd and vhost-user protocol messages.

All of this boils down to the ring state machine. libvhost-user's
behavior is:
1. Virtqueues are started by VHOST_USER_SET_VRING_KICK.
2. Virtqueues are stopped by VHOST_USER_GET_VRING_BASE.
3. Virtqueues are enabled/disabled by VHOST_USER_SET_VRING_ENABLE.

The same sequence of vhost-user protocol messages that is used to
start/stop a device locally (e.g. pause and resume a VM) is the same
that can be used during migration. The ring state machine already exists
and needs to be used when migrating device state.

The following changes to the vhost-user spec would make this clearer:

1. Mention that virtqueues are started by VHOST_USER_SET_VRING_KICK.
   Note that monitoring the kick fd may be used to avoid races between
   the kick fd and vhost-user protocol messages, so in practice back-end
   implementors may still want to start the virtqueue when the kick fd
   becomes readable.

2. Add a clarification to "Migrating back-end state" that the device
   must be suspended (see _suspended_device_state) when
   VHOST_USER_SET_DEVICE_STATE_FD is sent and device state is
   transferred. This is already implicit in "Device state transfer
   parameters", but it's not obvious when reading the "Migrating
   back-end state" section.

Stefan

--ua8tN7kV5wsX8Nm1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnmbeoACgkQnKSrs4Gr
c8jLvwf9FhXcIL982XFWu76746P13WAlMPmwtWVhVGXZUdMmKnEp9u+HMVy1k8Iy
tF2xl7TSXvzzaq3RuTxZLN2vLPr/geZDySbSm5hI6yTUn3oJhCUkGZD+5qP+fTiy
bAjYjjvGKp16m6Czrm02hq0sattFKGO1AbEtepnt+maLJaRByD5UGpYWzBAZPKaM
MkVzah68IiMTHAtmy2eDq4tdyyiqwfU5Kl60mrHwCMzZYME9Hybl6D1cX64GJM7N
YeV4z2W4jEObnb7fgFjyMhn0Z+gSo30iSlRxuNC8gjmKXAW8K7Sl2hzh7rQijgU3
C+WZ2R6oA8GjTafovY7o5mmulVVtuA==
=b488
-----END PGP SIGNATURE-----

--ua8tN7kV5wsX8Nm1--



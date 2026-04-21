Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D79DF94CB0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFI4t-0004Jm-UQ; Tue, 21 Apr 2026 16:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFI4q-0004GR-TM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFI4m-0002lv-Mm
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776804725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ea3zwc2wn3K95K/QjGVXD/jUPwnnNZC074GbjF9/bH0=;
 b=XVULFGWetAvBkVNclxzCwixyqUqJO8//vWVOltFhFUAaukCa5KYEzr5n7zYqNCjoGBukUk
 fTrpuue5KUEiyUPtC3nINZFVvF9vXxQziXQNEY41YheJXuBdTQyTueweeLnSgSJMNr2OXL
 iXWs38j/w0WgC8xpymciA6CYtQQOS48=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-hjgoLUJqMcSxwvF_8xCkkA-1; Tue,
 21 Apr 2026 16:52:01 -0400
X-MC-Unique: hjgoLUJqMcSxwvF_8xCkkA-1
X-Mimecast-MFC-AGG-ID: hjgoLUJqMcSxwvF_8xCkkA_1776804720
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B558195605E; Tue, 21 Apr 2026 20:52:00 +0000 (UTC)
Received: from localhost (unknown [10.44.32.90])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0B491800446; Tue, 21 Apr 2026 20:51:58 +0000 (UTC)
Date: Tue, 21 Apr 2026 16:51:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Jorge E. Moreira" <jemoreira@google.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260421205156.GB466778@fedora>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat>
 <CAGxU2F7=XQfc4PUEM=k5yc-tytRs-MkrRKFeRXAETVEY5eggZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x+H2wE6hLyK1WtYW"
Content-Disposition: inline
In-Reply-To: <CAGxU2F7=XQfc4PUEM=k5yc-tytRs-MkrRKFeRXAETVEY5eggZQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--x+H2wE6hLyK1WtYW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 05:57:40PM +0200, Stefano Garzarella wrote:
> On Mon, 20 Apr 2026 at 16:49, Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
> >
> > Thanks for starting the discussion here, let me add also Hanna, German,
> > and Stefan in CC that can help us.
> >
> > On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > >Migration of back-end state happens while the device is suspended (i.e
> > >all vrings are stopped). To resume normal operation on the destination,
> > >the vrings need to be started again with a kick (either a write on the
> > >FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While
> >
> > It's true that in the spec we have:
> >    "Each ring is initialized in a stopped and disabled state. The
> >    back-end must start a ring upon receiving a kick (that is, detecting
> >    that file descriptor is readable) on the descriptor specified by
> >    VHOST_USER_SET_VRING_KICK or receiving the in-band message
> >    VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving
> >    VHOST_USER_GET_VRING_BASE."
> >
> > But IMO this applies when a driver is not yet loaded.
> > When we are migrating, the driver could be already loaded. So, in the
> > new device running in the destination, IMO we should consider the ring
> > already started or add some messages to tell to the device: "hey, the
> > device was already started, this is a migration and it's completed".
> >
> > Sending a kick from the frontend, seems more an hack here.
> >
> > That said, for example, in subprojects/libvhost-user/libvhost-user.c
> > IIUC the virtqueue is started when the SET_VRING_KICK is handled by
> > vu_set_vring_kick_exec(), but not sure how compliant it is.
> >
> > >these notifications are typically sent by the driver, it has no reason
> > >to send them in the destination if it already sent them in the source =
as
> > >the driver is unaware that a migration took place. Therefore it should
> > >be the responsibility of the vhost-user front-end to ensure these vrin=
gs
> > >are started. This is particularly necessary for queues where data only
> > >flows from device to driver, such as those used by the vsock and input
> > >devices.
> >
> > Exactly, so IMO we should not use the kick, but maybe add something new
> > or clarify what to do after the migration.
> >
> > For example in the "Migrating back-end state" we have:
> >    "Migrating device state involves transferring the state from one
> >    back-end, called the source, to another back-end, called the
> >    destination. After migration, the destination transparently resumes
> >    operation without requiring the driver to re-initialize the device at
> >    the VIRTIO level."
> >
> > So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly to
> > inform the new device about the state: "there isn't any state to
> > transfer, but I notify you that the device was already initialized, so
> > the vrings can be started".
> >
> > >
> > >This behavior is already used by some qemu vhost-user front-ends (e.g
> > >vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosVm=
).
> >
> > I looked at vhost-user-blk frontend, but I don't see it. I mean I see
> > the code around the comment "/* Kick right away to begin processing
> > requests already in vring */" but that one IIUC was introduced more to
> > fix devices violating specs, so not sure it's a good example to follow:
> >
> > commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> > Author: Yongji Xie <elohimes@gmail.com>
> > Date:   Wed Jun 6 21:24:48 2018 +0800
> >
> >      vhost-user-blk: start vhost when guest kicks
> >
> >      Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs =
early")
> >      kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This viol=
ates
> >      the virtio spec. But virtio 1.0 transitional devices support this =
behaviour.
> >      So we should start vhost when guest kicks in this case.
> >
> >      Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> >      Signed-off-by: Chai Wen <chaiwen@baidu.com>
> >      Signed-off-by: Ni Xun <nixun@baidu.com>
> >      Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >
> > >Adding it to the vhost-user documentation makes it explicit that this
> > >strategy is permitted and suggest it to vhost-user front-end authors.
> > >Explicitly documenting it is necessary because vring kicks appear
> > >designed to originate in the driver, so having some originate in the
> > >front-end can be counterintuitive and cause developers to waste time
> > >looking for other alternatives or face pushback during code review.
> >
> > As I pointed out in our discussion in
> > https://github.com/rust-vmm/vhost-device/pull/936
> > IMO we should use some in-band messages and not relaying on kicks that
> > should be used only by the driver to notify the device about new
> > available buffers.
> >
> > That said, I agree that we need to clarify in the specifications exactly
> > what the backend and frontend should do after a migration to start
> > vrings if there is no need to exchange a state.
> >
> >
> > Any other opinion?
> >
> > Thanks,
> > Stefano
> >
> > >
> > >Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
> > >---
> > > docs/interop/vhost-user.rst | 5 ++++-
> > > 1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > >index 137c9f3669..ad5aba3430 100644
> > >--- a/docs/interop/vhost-user.rst
> > >+++ b/docs/interop/vhost-user.rst
> > >@@ -656,7 +656,10 @@ destination, following the usual protocol for est=
ablishing a connection
> > > to a vhost-user back-end: This includes, for example, setting up memo=
ry
> > > mappings and kick and call FDs as necessary, negotiating protocol
> > > features, or setting the initial vring base indices (to the same value
> > >-as on the source side, so that operation can resume).
> > >+as on the source side, so that operation can resume). The vhost-user =
front-end
> > >+may also write to the kick FDs of vrings containing unused buffers or=
 send
> > >+``VHOST_USER_VRING_KICK`` if negotiated to start those vrings in the =
destination
> > >+since the driver likely already kicked them in the source and won't d=
o it again.
>=20
> After discussing this with Hanna, we came to the conclusion that your
> idea of injecting the kick is the least invasive option for now and
> complies with the spec (even though I still don=E2=80=99t think it=E2=80=
=99s a nice
> thing to do).
>=20
> So it=E2=80=99s fine to continue in this direction, but I might add these
> words more in the "Migration" section than here, since we=E2=80=99re talk=
ing
> about an optional state migration here. For example after "No further
> update must be done before rings are restarted."
> Or in the "Ring states" section, where we can clarify how to restart a
> ring after a migration. Or in both :-)
>=20
> WDYT?
>=20
> Then instead of "may" I'd use "should". And I would refer to the fact
> that migration is transparent to the driver, so the front-end should
> kick all initialized vrings to comply with what we described in the
> "Ring states" section.

I don't agree. Here is my thinking about how to solve this:

Device state migration uses the ring state machine to suspend the device
on the source host and start rings on the destination host after loading
state.

Starting rings is not specific to migration, it is covered by the ring
state machine that's also used when pausing and resuming a VM locally,
for example. We need to fix the ring state machine section in the spec
rather than making changes to the migration or device state fd sections.

Given that there are vhost-user back-ends like DPDK that do not rely on
the kick fd (they do not use it when running in poll mode), injecting a
kick cannot be necessary. Adding anything to the spec that requires the
kick fd is at best a no-op and at worst could break those back-ends.

The spec must be updated to say that rings are started by
VHOST_USER_SET_KICK, which is what implementations already do today.

If you want to add a note that front-ends may send a kick after
VHOST_USER_SET_KICK completes to ensure that rings are started according
to the old spec wording, then that is fine, but it should be clear that
kicks are not the primary mechanism for starting rings since it would be
dangerous to rely on that (it breaks poll-mode back-ends).

Stefan

--x+H2wE6hLyK1WtYW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnn42wACgkQnKSrs4Gr
c8jkrwf/cob9xsroEpQ0UddOzBiA+00v3ChYaIuQ7LOF/u5pa+IP+c7eesBaHhGo
+EOXkldnWs9PTPu7JHCTe+FjbFFACgNMG6nQrn6TuJUToyYYei/2JCBwvE3h8sgx
D4ScwbnAttcTVyVvxKO8h0To98aZM4ED/V6lz4oVhjNbc1SoqH4ev2zeBqm+VBIb
ejQKOGkKPGNPTzamA15uT6yQjqlZo4aeOUlCPFelt7FuLseGDTOkwMppWRo3zOJb
tRWfqWdqdLRIkz4c9AWk9ybFyS/rVnHBpw/FyibHog/Xzdmi8EfUtcibGTbskdkB
g2Zd5qQYXYYWB5EZEeEZjxefHxovoQ==
=DPvm
-----END PGP SIGNATURE-----

--x+H2wE6hLyK1WtYW--



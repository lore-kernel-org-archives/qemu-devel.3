Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F2EC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 19:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXRBr-0002ai-IX; Tue, 06 Feb 2024 14:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXRBp-0002aC-MW
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXRBn-0005Kl-Ln
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707247983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iD9g5mZXa+9PM6IqNV85tbFxsotsxvnCidk2AFYDFjk=;
 b=ErJb8K4H7xbnhXCwCPwdD6z5yMneaBM4y5W1DNiQEPj5CXytNoHMF+hlFFm61kVfLYx4yU
 +t3Jxg7LlrdQDRvHDMIPIlVx09PGsTHIltxgzsc4nziXR5AG2Bc/LqQG5SQPyKHjnJUTut
 xTUfxMg91ZsLoX2NxkAJ7hj2pzeLT9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-SvtoviIPPvOth69uJarsCg-1; Tue, 06 Feb 2024 14:32:59 -0500
X-MC-Unique: SvtoviIPPvOth69uJarsCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3686D10201EE;
 Tue,  6 Feb 2024 19:32:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E71B40C9444;
 Tue,  6 Feb 2024 19:32:58 +0000 (UTC)
Date: Tue, 6 Feb 2024 14:32:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <20240206193256.GG66397@fedora>
References: <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
 <ZbOxI9Ar-YDn51Z0@redhat.com>
 <4c4173f2-b8fc-4c6f-88e1-8c31c4411837@redhat.com>
 <20240131203537.GC396296@fedora>
 <0a3e8d2a-add1-432b-b6b9-456ee0b17882@redhat.com>
 <20240201142817.GA516672@fedora>
 <6cb18310-c0cf-4747-a71d-540adba262cf@redhat.com>
 <82f1a65f-9821-480a-b2d2-cb5d6bf55c5b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JY8/ky4fcQYW3qPd"
Content-Disposition: inline
In-Reply-To: <82f1a65f-9821-480a-b2d2-cb5d6bf55c5b@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--JY8/ky4fcQYW3qPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:32:39PM +0100, Hanna Czenczek wrote:
> On 01.02.24 16:25, Hanna Czenczek wrote:
> > On 01.02.24 15:28, Stefan Hajnoczi wrote:
>=20
> [...]
>=20
> > > Did you find a scenario where the virtio-scsi AioContext is different
> > > from the scsi-hd BB's Aiocontext?
> >=20
> > Technically, that=E2=80=99s the reason for this thread, specifically th=
at
> > virtio_scsi_hotunplug() switches the BB back to the main context while
> > scsi_device_for_each_req_async_bh() is running.=C2=A0 Yes, we can fix t=
hat
> > specific case via the in-flight counter, but I=E2=80=99m wondering whet=
her
> > there=E2=80=99s really any merit in requiring the BB to always be in
> > virtio-scsi=E2=80=99s context, or whether it would make more sense to s=
chedule
> > everything in virtio-scsi=E2=80=99s context.=C2=A0 Now that BBs/BDSs ca=
n receive
> > requests from any context, that is.
>=20
> Now that I know that wouldn=E2=80=99t be easy, let me turn this around: A=
s far as I
> understand, scsi_device_for_each_req_async_bh() should still run in
> virtio-scsi=E2=80=99s context, but that=E2=80=99s hard, so we take the BB=
=E2=80=99s context, which
> we therefore require to be the same one. Further, (again AFAIU,)
> virtio-scsi=E2=80=99s context cannot change (only set in
> virtio_scsi_dataplane_setup(), which is run in
> virtio_scsi_device_realize()).=C2=A0 Therefore, why does the
> scsi_device_for_each_req_async() code accommodate for BB context changes?

1. scsi_disk_reset() -> scsi_device_purge_requests() is called without
   in-flight requests.
2. The BH is scheduled by scsi_device_purge_requests() ->
   scsi_device_for_each_req_async().
3. blk_drain() is a nop when there no in-flight requests and does not
   flush BHs.
3. The AioContext changes when the virtio-scsi device resets.
4. The BH executes.

Kevin and I touched on the idea of flushing BHs in bdrv_drain() even
when there are no requests in flight. This hasn't been implemented as of
today, but would also reduce the chance of scenarios like the one I
mentioned.

I think it's safer to handle the case where the BH runs after an
AioContext change until either everything is thread-safe or the
AioContext never changes.

Stefan

--JY8/ky4fcQYW3qPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCiWgACgkQnKSrs4Gr
c8jvIggArpYn6gQU0Tgul6LtOOiyCUowpaq9s7JXL8v/I9tx+pBeihl7UhviTZuN
jhU5J9yxqxeMEi4QD6QOsky+OXhCDZNVQvFICXQnD9AJwEaBgyCa65Pr4XP+NY3B
KCCyWkpeRPYhi/mtkbFrsL88yN6l0w65LKKiaopM4StIp/zAMKfsURAcZHUpS9mC
PKvjxzDPJ2jzfLKe+SVnngjHqgajr0RKTDBr2qa31yWwTbWdpxITn6saAYTfAIYM
amOaQXV9TXE2eDm+xPxQJRpu1bw2VjQ563wxMtky47s4Te7CGuebhn3hUglVzW4K
jCJD3vQTwrsR/SgDRO6A+Hdg3KWh6Q==
=0tGa
-----END PGP SIGNATURE-----

--JY8/ky4fcQYW3qPd--



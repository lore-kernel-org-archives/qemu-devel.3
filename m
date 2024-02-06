Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E472C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOhc-0001ti-Ig; Tue, 06 Feb 2024 11:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXOha-0001sp-9o
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXOhX-0007iv-FZ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707238417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xrd29HG6N5Qa6lF2jWKMZM/p6uwRPoodG71XXeTSXvM=;
 b=dbDyF50IlGOkr44ta+LohibvEapFjAFmaZ1y9OPWW1maW04+gAQBLgGBTxwPXEEIux3iOw
 kMRUJDvHXc4CifOrzx5iiSMtj693UFbzEt2TnEM3fp/f+jn6ekCDaPaB9HbgIHWRfrO/F9
 ytbl4RATcD1Zya+pbi6ML4oLxVSl5j8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-SeZkpQ9xMSS4WWIOFHYGSg-1; Tue, 06 Feb 2024 11:53:33 -0500
X-MC-Unique: SeZkpQ9xMSS4WWIOFHYGSg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F173185A781;
 Tue,  6 Feb 2024 16:53:33 +0000 (UTC)
Received: from localhost (unknown [10.39.195.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E5F6492BC7;
 Tue,  6 Feb 2024 16:53:32 +0000 (UTC)
Date: Tue, 6 Feb 2024 11:53:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/2] block: Allow concurrent BB context changes
Message-ID: <20240206165330.GB66397@fedora>
References: <20240202144755.671354-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/HW2OnulM3aGawcA"
Content-Disposition: inline
In-Reply-To: <20240202144755.671354-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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


--/HW2OnulM3aGawcA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 03:47:53PM +0100, Hanna Czenczek wrote:
> Hi,
>=20
> Without the AioContext lock, a BB's context may kind of change at any
> time (unless it has a root node, and I/O requests are pending).  That
> also means that its own context (BlockBackend.ctx) and that of its root
> node can differ sometimes (while the context is being changed).
>=20
> blk_get_aio_context() doesn't know this yet and asserts that both are
> always equal (if there is a root node).  Because it's no longer true,
> and because callers don't seem to really care about the root node's
> context, we can and should remove the assertion and just return the BB's
> context.
>=20
> Beyond that, the question is whether the callers of
> blk_get_aio_context() are OK with the context potentially changing
> concurrently.  Honestly, it isn't entirely clear to me; most look OK,
> except for the virtio-scsi code, which operates under the general
> assumption that the BB's context is always equal to that of the
> virtio-scsi device.  I doubt that this assumption always holds (it is
> definitely not obvious to me that it would), but then again, this series
> will not make matters worse in that regard, and that is what counts for
> me now.
>=20
> One clear point of contention is scsi_device_for_each_req_async(), which
> is addressed by patch 2.  Right now, it schedules a BH in the BB
> context, then the BH double-checks whether the context still fits, and
> if not, re-schedules itself.  Because virtio-scsi's context is fixed,
> this seems to indicate to me that it wants to be able to deal with a
> case where BB and virtio-scsi context differ, which seems to break that
> aforementioned general virtio-scsi assumption.

I don't agree with the last sentence: virtio-scsi's context isn't fixed.

The AioContext changes when dataplane is started/stopped. virtio-scsi
switches AioContext between the IOThread's AioContext and the main
loop's qemu_aio_context.

However, virtio-scsi virtqueue processing only happens in the IOThread's
AioContext. Maybe this is what you meant when you said the AioContext is
fixed?

The BH function is aware that the current AioContext might not be the
same as the AioContext at the time the BH was scheduled. That doesn't
break assumptions in the code.

(It may be possible to rewrite virtio-blk, virtio-scsi, and core
VirtIODevice ioeventfd code to use the simpler model where the
AioContext really is fixed because things have changed significantly
over the years, but I looked a few weeks ago and it's difficult work.)

I'm just pointing out that I think this description is incomplete. I
*do* agree with what this patch series is doing :).

> Unfortunately, I definitely have to touch that code, because accepting
> concurrent changes of AioContexts breaks the double-check (just because
> the BB has the right context in that place does not mean it stays in
> that context); instead, we must prevent any concurrent change until the
> BH is done.  Because changing contexts generally involves a drained
> section, we can prevent it by keeping the BB in-flight counter elevated.
>=20
> Question is, how to reason for that.  I=E2=80=99d really rather not inclu=
de the
> need to follow the BB context in my argument, because I find that part a
> bit fishy.
>=20
> Luckily, there=E2=80=99s a second, completely different reason for having
> scsi_device_for_each_req_async() increment the in-flight counter:
> Specifically, scsi_device_purge_requests() probably wants to await full
> completion of scsi_device_for_each_req_async(), and we can do that most
> easily in the very same way by incrementing the in-flight counter.  This
> way, the blk_drain() in scsi_device_purge_requests() will not only await
> all (cancelled) I/O requests, but also the non-I/O requests.
>=20
> The fact that this prevents the BB AioContext from changing while the BH
> is scheduled/running then is just a nice side effect.
>=20
>=20
> Hanna Czenczek (2):
>   block-backend: Allow concurrent context changes
>   scsi: Await request purging
>=20
>  block/block-backend.c | 22 +++++++++++-----------
>  hw/scsi/scsi-bus.c    | 30 +++++++++++++++++++++---------
>  2 files changed, 32 insertions(+), 20 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--/HW2OnulM3aGawcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCZAoACgkQnKSrs4Gr
c8izUQf8D5vS3vMLhSH9ubrtDx3IieirDruWDGKuV2aLU6Hk8pJ6ndIzZu3E/aQN
w8fiVo3eqCuVSkMoNwoL7E961ZggRNnBg0lc9/f3qqyrNE42B0rqy7RrCO/21U4y
0Mw7MA1vQ/ioPRN29J5L/0T2xVCZ4h+BUDeNs6rvynlrhx9KCr3QL84KXcyh2wgm
G7q0+8IeWk5bw3CapScx1Q/72BRGXzB2P2BO+QnXxTfjY5mo0cb47EMGUzQqUNwY
DMaqXuTr1PbdSO9qHqBloiDI0k1v1DlQLk2wqJBGlx73zMQwo7cNmiwDHhiQHta7
AiaVzO7nN5ZpRRzIEpyS1ywIRp+OQg==
=cfTa
-----END PGP SIGNATURE-----

--/HW2OnulM3aGawcA--



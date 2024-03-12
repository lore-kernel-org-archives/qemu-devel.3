Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0iy-00051V-Nn; Tue, 12 Mar 2024 07:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk0iv-0004zl-NY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk0ir-0006bS-7O
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710244507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tMEMoR3icCTuVbPoJ2Cpw7yvBKgCw2zlKNjuhIDNF+0=;
 b=NQ0bxPkLF2pohcaLyIC+mDNs8THThR6qcM0wPsBC3SUPcyjaRh9Z9CDlJN+xtHYerLIryn
 QRm1Vp71043zamNnQPcZyflCHieyGScn6nXD/fEhTL4R43ayeumzvS2dQutaTtAOUwYnft
 95VN1g9mjTzh9xbH4gJGRsvqs/KMSls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-CTr-FpbyM1CYUqjP5GKN8w-1; Tue, 12 Mar 2024 07:55:03 -0400
X-MC-Unique: CTr-FpbyM1CYUqjP5GKN8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7053B800265;
 Tue, 12 Mar 2024 11:55:03 +0000 (UTC)
Received: from localhost (unknown [10.39.194.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 975741121337;
 Tue, 12 Mar 2024 11:55:02 +0000 (UTC)
Date: Tue, 12 Mar 2024 07:55:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>
Subject: Re: [PATCH] virtio-blk: iothread-vq-mapping coroutine pool sizing
Message-ID: <20240312115500.GA405123@fedora>
References: <20240311201423.387622-1-stefanha@redhat.com>
 <ZfA7bhciuvDtO3fI@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhxse36WNB2G4TbT"
Content-Disposition: inline
In-Reply-To: <ZfA7bhciuvDtO3fI@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--zhxse36WNB2G4TbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 12:24:30PM +0100, Kevin Wolf wrote:
> Am 11.03.2024 um 21:14 hat Stefan Hajnoczi geschrieben:
> > It is possible to hit the sysctl vm.max_map_count limit when the
> > coroutine pool size becomes large. Each coroutine requires two mappings
> > (one for the stack and one for the guard page). QEMU can crash with
> > "failed to set up stack guard page" or "failed to allocate memory for
> > stack" when this happens.
> >=20
> > Coroutine pool sizing is simple when there is only one AioContext: sum
> > up all I/O requests across all virtqueues.
> >=20
> > When the iothread-vq-mapping option is used we should calculate tighter
> > bounds: take the maximum number of the number of I/O requests across all
> > virtqueues. This number is lower than simply summing all virtqueues when
> > only a subset of the virtqueues is handled by each AioContext.
>=20
> The reasoning is that each thread has its own coroutine pool for which
> the pool size applies individually, and it doesn't need to have space
> for coroutines running in a different thread, right? I'd like to have
> this recorded in the commit message.

Right, I'll update the commit description to mention this.

I also forgot to include Joe Mario in the Reported-by tags. Joe has been
helping investigate the issue.

> Of course, this also makes me wonder if a global coroutine pool size
> really makes sense or if it should be per thread. One thread could be
> serving only one queue (maybe the main thread with a CD-ROM device) and
> another thread 32 queues (the iothread with the interesting disks).
> There is no reason for the first thread to have a coroutine pool as big
> as the second one.

Agreed. The main loop thread, in particular, has very different
coroutine pool sizing requirements from the IOThreads that are
performing the bulk of the I/O.

> But before we make the size thread-local, maybe having thread-local
> pools wasn't right to begin with because multiple threads can run main
> context code and they should therefore share the same coroutine pool (we
> already had the problem earlier that coroutines start on the vcpu thread
> and terminate on the main thread and this plays havoc with coroutine
> pools).
>=20
> Maybe per-AioContext pools with per-AioContext sizes would make more
> sense?

That's a good observation. Originally I hoped we could keep the
coroutine code independent of AioContext, but it is already connected in
other ways (e.g. co->ctx) so there's no reason to avoid it.

I'm not happy with how coroutine pools perform. I reproduced the
max_map_count failures that Sanjay, Boaz, and Joe have encountered and
found that one IOThread had 10k coroutines pooled while another
IOThread's pool was empty. Using timers to decay the pool size when it's
not actively in use has come to mind.

On the other hand, the fundamental problem is that the guest has access
to more virtqueue space than QEMU can allocate coroutines. Adding timers
to decay the pool size might hide issues but a guest could fill all
virtqueues at once and still crash.

QEMU needs to be reliable and run out of resources. There is no
accounting code in place capable of tracking all possible coroutine
usage, but maybe QEMU should refuse to launch when the virtqueue
resources promised to the guest exceed vm.max_map_count...

> > This is not a solution to hitting vm.max_map_count, but it helps. A
> > guest with 64 vCPUs (hence 64 virtqueues) across 4 IOThreads with one
> > iothread-vq-mapping virtio-blk device and a root disk without goes from
> > pool_max_size 16,448 to 10,304.
> >=20
> > Reported-by: Sanjay Rao <srao@redhat.com>
> > Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Either way, this should already strictly improve the situation, so I'm
> happy to apply this change for now.

Thanks, I will send a v2.

Stefan

--zhxse36WNB2G4TbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwQpQACgkQnKSrs4Gr
c8hMQAgAt6AoaNXUdr+IpkkNLOKZaxXGzqjpdKd9g4MjyTEoEshJqEx4nYG9QvvO
RvxI0qXRrzvp51ZbqwggW2SFwhlm8JGa7ww7Bz8ttCRdmHavLF+K+oCvWdFjpMr3
Zq8AmI6sNN3ZY0AWnPRkyaRyXmJfg7QO2fGHBrwV4fXbY0tbH+qF6FcbrhbhjWKu
W5yPfbakbFqdOSg6bPM3xxk3Gt9DUzcyUhIrGj5+woeJ8oIk3CUpZQQgDaLqUdXK
1wa8Te5B0HAY2leSodljWZyGNQtYQFh71lCuOQJ3nPGHz3kwyIs1dHjmo8TRlf64
veLesev1lD31qtYK/M6nJvnhPCPtmg==
=+HJ1
-----END PGP SIGNATURE-----

--zhxse36WNB2G4TbT--



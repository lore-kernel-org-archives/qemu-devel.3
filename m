Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2547BC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyhg-0001O4-0e; Tue, 12 Mar 2024 05:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rjyhe-0001MA-LG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rjyhb-0006sb-IB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710236743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkGjmOvqo3I37GHaM8XEncTPsE8aEkOzyS/Fmwhbqh8=;
 b=U8PfAzG6KQIqx28zg7/low5ObhdSjGDFus/jkuQPDvSG69tpAbPiSK7bwt/6BfzWSmvalb
 h8uV86GXouO6ScgNIg0p/Ivq6OfIAw0hQxDJixWPBabas0vaXOcHfcosQaN0uvjGBB58mK
 WO+5Lzkpw3vuA1+PGqseJtwlHNlbXNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-fbKE9rdIPZOY0Qmtxr-pFg-1; Tue, 12 Mar 2024 05:45:36 -0400
X-MC-Unique: fbKE9rdIPZOY0Qmtxr-pFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9451871BE7;
 Tue, 12 Mar 2024 09:45:36 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BABC33C20;
 Tue, 12 Mar 2024 09:45:35 +0000 (UTC)
Date: Tue, 12 Mar 2024 10:45:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <ZfAkPhiAnyaEV9jQ@redhat.com>
References: <20240311054333.1264776-1-ppandit@redhat.com>
 <20240311130908.GA327967@fedora> <Ze8l1fzr0oxIFxO1@redhat.com>
 <20240311193641.GA384474@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vthtM8zupCSHQyQs"
Content-Disposition: inline
In-Reply-To: <20240311193641.GA384474@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--vthtM8zupCSHQyQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.03.2024 um 20:36 hat Stefan Hajnoczi geschrieben:
> On Mon, Mar 11, 2024 at 04:40:05PM +0100, Kevin Wolf wrote:
> > Am 11.03.2024 um 14:09 hat Stefan Hajnoczi geschrieben:
> > > On Mon, Mar 11, 2024 at 11:13:33AM +0530, Prasad Pandit wrote:
> > > > From: Prasad Pandit <pjp@fedoraproject.org>
> > > >=20
> > > > Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> > > > asynchronous I/O operations, by flushing out file data to the
> > > > disk storage.
> > > >=20
> > > > Enable linux-aio to submit such aio request. This helps to
> > > > reduce latency induced via pthread_create calls by
> > > > thread-pool (aio=3Dthreads).
> > > >=20
> > > > Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> > > > ---
> > > >  block/file-posix.c | 12 ++++++++++++
> > > >  block/linux-aio.c  |  5 ++++-
> > > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > > >=20
> > > > v2: if IO_CMD_FDSYNC is not supported by the kernel,
> > > >     fallback on thread-pool flush.
> > > >   -> https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg01=
986.html
> > > >=20
> > > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > > index 35684f7e21..4f2195d01d 100644
> > > > --- a/block/file-posix.c
> > > > +++ b/block/file-posix.c
> > > > @@ -2599,6 +2599,18 @@ static int coroutine_fn raw_co_flush_to_disk=
(BlockDriverState *bs)
> > > >      if (raw_check_linux_io_uring(s)) {
> > > >          return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH=
);
> > > >      }
> > > > +#endif
> > > > +#ifdef CONFIG_LINUX_AIO
> > > > +    if (raw_check_linux_aio(s)) {
> > > > +        ret =3D laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
> > > > +        if (ret >=3D 0) {
> > > > +            /*
> > > > +             * if AIO_FLUSH is supported return
> > > > +             * else fallback on thread-pool flush.
> > > > +             */
> > > > +            return ret;
> > > > +        }
> > >=20
> > > Falling back every time on an older host kernel might be a noticeable
> > > performance regression. That can be avoided with a variable that keeps
> > > track of whether -EINVAL was seen before and skips Linux AIO in that
> > > case.
> > >=20
> > > However, it appears that popular distributions starting from Debian 1=
0,
> > > Ubuntu 20.04, Fedora 27, CentOS 8, and OpenSUSE Leap 15.5 have the
> > > necessary minimum Linux 4.18 kernel:
> > > https://repology.org/project/linux/versions
> > >=20
> > > Fallback should be very rare, so I don't think it needs to be optimiz=
ed:
> > >=20
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > We might need this approach for a different reason: This is an
> > io_submit() error, so while we retry the flush with the fallback path,
> > other requests in the same batch may incorrectly return errors. This
> > probably explains the errors Prasad saw in the guest when the kernel
> > doesn't have support for flush in Linux AIO.
> >=20
> > So in order to avoid this, we'll probably have to send one flush just to
> > probe (while making sure that no other request is pending - maybe
> > immediately when opening the image?) and then remember whether it
> > worked.
> >=20
> > Or we'd have to change the error handling around io_submit(), so that we
> > don't always fail the first request in the batch, but first fail any
> > flushes and only then the rest of the requests.
>=20
> I don't see the behavior you are describing in the code. My
> interpretation of ioq_submit() is that only the flush request fails.
> Other queued requests (before and after the flush) are submitted
> successfully:
> [...]

You're right. I missed that io_submit() returns failure only if the
first request in the queue is invalid, and returns a "short submission"
for errors in later entries.

Kevin

--vthtM8zupCSHQyQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmXwJD4ACgkQfwmycsiP
L9aIdBAAxCEH+w+36d+valgZTtwUwiT9NgRFXaESsZP4HzQrT1mZc2GvkLIW1maj
SZj42vNi7aDlbEvn/hqNOo3xWKyhmivAgORXO5/KjaR7mPvNV8hu29qEdcJnK+gU
EIrtWIiw4uPcU3yq/emzACLfmCrGn2yhyvWrLPISHAaHzyAD2rCVwH9sqIwPu5XS
NDyayRhD9V3+5G9mLgVGJZ5IeSGuSZzFSGEOglkSJqNuxhCzRWWdrqud6w3LEfjg
6qKGw4PVvJu+PilT6SeXRx2Yt/uAt+2MQeoR1YbT6f6fhRkeb6PBXJ1c9lX50Z2A
noYOGm+ufHkYBujoQXtvhk5RAafRLtmtP66Oqk1aJEdQI94YuSc1pJR++KHoj5rQ
wNqSQGTDZZeTqQZLzWDmk+Oqe99Ols29eihn8KLEqsGCiWtMQPIv1oyCH7TvbPpj
iNyCrttpJa04dHnUeTFzqBpUmv18P01LNzUMPWkJN4o70XbkqO3JF3uQqA1xGlAn
hJ937c1WZg+IfU/6jVxLegCzP2qVr9UykNFJkc65nd2wuRk6RzAmvuwDTZ5Ty53f
Xf/ImtT8Kbn8XNvpSLgYm0kXeZQ4zSX75b0mCWflU06u8lgVaxwRVHYdGnCnU9Pg
hbUDO8iVUE7RHd7FQ0q4e9VL3izkrXYNnICl210eKi0EF4toz5A=
=JYOL
-----END PGP SIGNATURE-----

--vthtM8zupCSHQyQs--



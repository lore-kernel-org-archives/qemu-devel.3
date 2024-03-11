Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB81C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfP6-0008Sn-2P; Mon, 11 Mar 2024 09:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rjfP3-0008Rx-Qd
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rjfP1-0001u7-Lv
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710162553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGbbLfnAhukb5AZeno7MtSN8ZHC7V5YEOnJzxhTH8PM=;
 b=QWvqayz3ciCQb0QIEKUH9OzRYYyJbOC9Fo2xAVEbrs2Gd/ralOqop/bQBMKbKCSaOdaQ5B
 4yQ/NjhAQK0PtrK/XgSJHrFFDjFgSFznpE8buIWuUrRtTLglW/PPNw9s/v6rmwn3YasVyx
 QH5qtknfl/gM8Mg9cLYOUXPYNGsIyzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-mwJvxgR-M62LxHUGnZd_vA-1; Mon, 11 Mar 2024 09:09:10 -0400
X-MC-Unique: mwJvxgR-M62LxHUGnZd_vA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65AFA803F60;
 Mon, 11 Mar 2024 13:09:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4731C04120;
 Mon, 11 Mar 2024 13:09:09 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:09:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <20240311130908.GA327967@fedora>
References: <20240311054333.1264776-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZkhtkXqFyv6s9Ic5"
Content-Disposition: inline
In-Reply-To: <20240311054333.1264776-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--ZkhtkXqFyv6s9Ic5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:13:33AM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
>=20
> Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> asynchronous I/O operations, by flushing out file data to the
> disk storage.
>=20
> Enable linux-aio to submit such aio request. This helps to
> reduce latency induced via pthread_create calls by
> thread-pool (aio=3Dthreads).
>=20
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  block/file-posix.c | 12 ++++++++++++
>  block/linux-aio.c  |  5 ++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> v2: if IO_CMD_FDSYNC is not supported by the kernel,
>     fallback on thread-pool flush.
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg01986.ht=
ml
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..4f2195d01d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2599,6 +2599,18 @@ static int coroutine_fn raw_co_flush_to_disk(Block=
DriverState *bs)
>      if (raw_check_linux_io_uring(s)) {
>          return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH);
>      }
> +#endif
> +#ifdef CONFIG_LINUX_AIO
> +    if (raw_check_linux_aio(s)) {
> +        ret =3D laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
> +        if (ret >=3D 0) {
> +            /*
> +             * if AIO_FLUSH is supported return
> +             * else fallback on thread-pool flush.
> +             */
> +            return ret;
> +        }

Falling back every time on an older host kernel might be a noticeable
performance regression. That can be avoided with a variable that keeps
track of whether -EINVAL was seen before and skips Linux AIO in that
case.

However, it appears that popular distributions starting from Debian 10,
Ubuntu 20.04, Fedora 27, CentOS 8, and OpenSUSE Leap 15.5 have the
necessary minimum Linux 4.18 kernel:
https://repology.org/project/linux/versions

Fallback should be very rare, so I don't think it needs to be optimized:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> +    }
>  #endif
>      return raw_thread_pool_submit(handle_aiocb_flush, &acb);
>  }
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index ec05d946f3..d940d029e3 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -384,6 +384,9 @@ static int laio_do_submit(int fd, struct qemu_laiocb =
*laiocb, off_t offset,
>      case QEMU_AIO_READ:
>          io_prep_preadv(iocbs, fd, qiov->iov, qiov->niov, offset);
>          break;
> +    case QEMU_AIO_FLUSH:
> +        io_prep_fdsync(iocbs, fd);
> +        break;
>      /* Currently Linux kernel does not support other operations */
>      default:
>          fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
> @@ -412,7 +415,7 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offs=
et, QEMUIOVector *qiov,
>      AioContext *ctx =3D qemu_get_current_aio_context();
>      struct qemu_laiocb laiocb =3D {
>          .co         =3D qemu_coroutine_self(),
> -        .nbytes     =3D qiov->size,
> +        .nbytes     =3D qiov ? qiov->size : 0,
>          .ctx        =3D aio_get_linux_aio(ctx),
>          .ret        =3D -EINPROGRESS,
>          .is_read    =3D (type =3D=3D QEMU_AIO_READ),
> --=20
> 2.44.0
>=20

--ZkhtkXqFyv6s9Ic5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXvAnQACgkQnKSrs4Gr
c8gXEggAtv/wvZgkCA2jbu92h/5mbgJihbwbCSrghMphmKCQt4kXLRQNpqbPU3kL
VbQyzq+3UFVHZzNa2QuHu+aQWf0K6jA+QElOf64g/12U8Sw0joAfzxfx4K401a+B
BxastA7m0tfgFro3Sm0C8XnfD0+fjuNPobUaAa15jmsGaLhJ/dsMvmHY5rMYvg77
UpLKglyPw5kduhRaD1L42230HTRZ9+ubsIbmmNSEsYYFJuByICvsmi4RbhUhNZlm
GwcucH/aTcfGGW/c4d9Y/diwwTonWowfGqYFSgcNTDMvE+ta9fSz91dPG9fJxsH0
cieXJh7BmF5IUKanmq4+ePUiuJHP3g==
=w9SR
-----END PGP SIGNATURE-----

--ZkhtkXqFyv6s9Ic5--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B185FCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVwd-00026X-Ni; Mon, 11 May 2026 15:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMVwb-00026B-9S
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMVwZ-0007mt-9V
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778526328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PEVDEYCNuIIAg0922CyPoNbODUS80bicA9t+3R0Nxg=;
 b=Q9VqFrCjXLMU6QjJLpOJyRl4VSoei3b0AwC3uWjqKTk0DqfUkA1XF7m9gu1ntPV8iBgRKT
 EGlj4mnUjoVzX+INlQNDeW+8aakthqaV3jaZQ1TRh1QqNhzl9ImKsFf3NE4jtxg+DTl8s5
 PLp7BWctWgp42utpnQnTLowZH7biYqA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-FcNjnXITOIO5GbvUp3O1fQ-1; Mon,
 11 May 2026 15:05:26 -0400
X-MC-Unique: FcNjnXITOIO5GbvUp3O1fQ-1
X-Mimecast-MFC-AGG-ID: FcNjnXITOIO5GbvUp3O1fQ_1778526325
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A720180061B; Mon, 11 May 2026 19:05:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89D62180034E; Mon, 11 May 2026 19:05:24 +0000 (UTC)
Date: Mon, 11 May 2026 15:05:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V7 04/14] blockdev: Update tracking iothread users with
 holder name
Message-ID: <20260511190523.GF536999@fedora>
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-5-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LaADuwiADXDBieAv"
Content-Disposition: inline
In-Reply-To: <20260511140416.28271-5-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--LaADuwiADXDBieAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:04:06PM +0800, Zhang Chen wrote:
> Currently, x-blockdev-set-iothread changes the AioContext but does not
> track the IOThread object itself within the block layer. This makes it
> difficult to manage IOThread reference counting (put/get) during
> dynamic context switching.
>=20
> Introduce an 'iothread' field to BlockDriverState to store the current
> assigned IOThread. Update qmp_x_blockdev_set_iothread to perform
> proper reference counting using iothread_ref/put when moving nodes
> between an IOThread and the main loop.
>=20
> This ensures 'info iothreads' (holders) accurately reflects the block
> device attachment state after dynamic migrations.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  blockdev.c                       | 6 +++++-
>  include/block/block_int-common.h | 5 +++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 6e86c6262f..6e20579187 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3683,8 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *node_=
name, StrOrNull *iothread,
>              goto out;
>          }
> =20
> -        new_context =3D iothread_get_aio_context(obj);
> +        new_context =3D iothread_ref_and_get_aio_context(obj, node_name);
> +        bs->iothread =3D obj;
>      } else {
> +        if (bs->iothread) {
> +            iothread_put_aio_context(bs->iothread, node_name);
> +        }
>          new_context =3D qemu_get_aio_context();
>      }

This command is the wrong place to associate an IOThread with a
BlockDriverState:
1. Do we need to call iothread_put_aio_context() on the current IOThread
   when x-blockdev-set-iothread is called with a new IOThread?
2. Is the AioContext leaked when x-blockdev-set-iothread iothread=3Dnull
   is not called before the BlockDriverState is freed?

Every BlockDriverState would need to get/put the IOThread AioContext in
bdrv_change_aio_context() or related functions.

However, the QEMU block layer has been moving away from having a
per-BlockDriverState AioContext. It is possible to use a
BlockDriverState from any AioContext (including multiple AioContexts at
the same time). I'm in favor of not associating BlockDriverStates with
IOThreads and instead relying on their device owners (e.g. emulated
storage controllers) to be the IOThread holders. That means you could
use iothread->ctx directly or create an
iothread_unsafe_get_aio_context() API to document that this is a
low-level unsafe way of getting the AioContext.

> =20
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 147c08155f..6edaf53377 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -1101,6 +1101,8 @@ typedef struct BdrvBlockStatusCache {
>      int64_t data_end;
>  } BdrvBlockStatusCache;
> =20
> +typedef struct IOThread IOThread;
> +
>  struct BlockDriverState {
>      /*
>       * Protected by big QEMU lock or read-only after opening.  No special
> @@ -1289,6 +1291,9 @@ struct BlockDriverState {
> =20
>      /* array of write pointers' location of each zone in the zoned devic=
e. */
>      BlockZoneWps *wps;
> +
> +    /* Track the iothread for detach aio context*/
> +    IOThread *iothread;
>  };
> =20
>  struct BlockBackendRootState {
> --=20
> 2.49.0
>=20

--LaADuwiADXDBieAv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoCKHMACgkQnKSrs4Gr
c8iUdQf+Mbdv/GDFYBdw/T5DlM2gArQDZJlI0ly1yeOb3hOgBOm4UVgNzLeFuF0g
yJ7cfRc8f2SqTtHXtuIZclBQlSu/D+yupk3U1Vz3kXAR1o9m3aENbYhhycKGsNx3
75DSEOPKLGjncQESgq2o/LeCaSRpyR7hN8JzWbvBFeKAhauuCKZv1rXgVZ39x11c
hCknxOa9hvw8rV0cKq4V8goPcUvqmyhoMmCKBeeue/e1vwr4jwe3hSw86AxClC2r
QG2qndQOPJ7bzuA99zZJdyqrWxp9GgkcE/Xha/1cGfFiu2t4YdAcj7qCHXWmZ4ez
U6A3SllQGneh/l9gGomnir4aWSAYSA==
=e89Q
-----END PGP SIGNATURE-----

--LaADuwiADXDBieAv--



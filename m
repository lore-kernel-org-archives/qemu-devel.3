Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BBBC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rombD-0006xo-7G; Mon, 25 Mar 2024 11:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rombB-0006w2-Rj
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1romb9-00042t-Uf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711381854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y5NJNAYJlU6XyJ66Zbz/x5b/AW7OYrwzOpmH0bJNseo=;
 b=YAz2TC2LsvM5vopyXNUpIxRv6XUC1W72wygX0me0H76p0UmlSKBjo77NKqjNe5EDqrZV5l
 YXdKL1up5Dzg1w/SkHg5IWdU9TZxy5Pl//e/6fbFbM8AZkMx9OipC1mZBaxkranFz2tedB
 isFXVH85jkg3zRjUkuiqPa07JB1qEO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-c9UYRla2N2G952Fqd76GlQ-1; Mon, 25 Mar 2024 11:50:48 -0400
X-MC-Unique: c9UYRla2N2G952Fqd76GlQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C4318007A6;
 Mon, 25 Mar 2024 15:50:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFD35492BD0;
 Mon, 25 Mar 2024 15:50:46 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:50:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zhuyangyang <zhuyangyang14@huawei.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 luolongmin@huawei.com, suxiaodong1@huawei.com,
 chenxiaoyu48@huawei.com, wangyan122@huawei.com,
 yebiaoxiang@huawei.com, eblake@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Message-ID: <20240325155041.GA1898401@fedora>
References: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QZtAWGn1GszBZLEb"
Content-Disposition: inline
In-Reply-To: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--QZtAWGn1GszBZLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang wrote:
> If g_main_loop_run()/aio_poll() is called in the coroutine context,
> the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> may be disordered.

aio_poll() must not be called from coroutine context:

  bool no_coroutine_fn aio_poll(AioContext *ctx, bool blocking);
       ^^^^^^^^^^^^^^^

Coroutines are not supposed to block. Instead, they should yield.

> When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
> some listened events is completed. Therefore, the completion callback
> function is dispatched.
>=20
> If this callback function needs to invoke aio_co_enter(), it will only
> wake up the coroutine (because we are already in coroutine context),
> which may cause that the data on this listening event_fd/socket_fd
> is not read/cleared. When the next poll () exits, it will be woken up aga=
in
> and inserted into the wakeup queue again.
>=20
> For example, if TLS is enabled in NBD, the server will call g_main_loop_r=
un()
> in the coroutine, and repeatedly wake up the io_read event on a socket.
> The call stack is as follows:
>=20
> aio_co_enter()
> aio_co_wake()
> qio_channel_restart_read()
> aio_dispatch_handler()
> aio_dispatch_handlers()
> aio_dispatch()
> aio_ctx_dispatch()
> g_main_context_dispatch()
> g_main_loop_run()
> nbd_negotiate_handle_starttls()

This code does not look like it was designed to run in coroutine
context. Two options:

1. Don't run it in coroutine context (e.g. use a BH instead). This
   avoids blocking the coroutine but calling g_main_loop_run() is still
   ugly, in my opinion.

2. Get rid of data.loop and use coroutine APIs instead:

   while (!data.complete) {
       qemu_coroutine_yield();
   }

   and update nbd_tls_handshake() to call aio_co_wake(data->co) instead
   of g_main_loop_quit(data->loop).

   This requires auditing the code to check whether the event loop might
   invoke something that interferes with
   nbd_negotiate_handle_starttls(). Typically this means monitor
   commands or fd activity that could change the state of this
   connection while it is yielded. This is where the real work is but
   hopefully it will not be that hard to figure out.

> nbd_negotiate_options()
> nbd_negotiate()
> nbd_co_client_start()
> coroutine_trampoline()
>=20
> Signed-off-by: zhuyangyang <zhuyangyang14@huawei.com>
> ---
>  util/async.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/async.c b/util/async.c
> index 0467890052..25fc1e6083 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -705,7 +705,18 @@ void aio_co_enter(AioContext *ctx, Coroutine *co)
>      if (qemu_in_coroutine()) {
>          Coroutine *self =3D qemu_coroutine_self();
>          assert(self !=3D co);
> -        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
> +        /*
> +         * If the Coroutine *co is already in the co_queue_wakeup, this
> +         * repeated insertion will causes the loss of other queue element
> +         * or infinite loop.
> +         * For examplex:
> +         * Head->a->b->c->NULL, after insert_tail(head, b) =3D> Head->a-=
>b->NULL
> +         * Head->a-b>->NULL, after insert_tail(head, b) =3D> Head->a->b-=
>b...
> +         */
> +        if (!co->co_queue_next.sqe_next &&
> +            self->co_queue_wakeup.sqh_last !=3D &co->co_queue_next.sqe_n=
ext) {
> +            QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_ne=
xt);
> +        }
>      } else {
>          qemu_aio_coroutine_enter(ctx, co);
>      }
> --=20
> 2.33.0
>=20

--QZtAWGn1GszBZLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYBnVEACgkQnKSrs4Gr
c8jiwAgAsTfvFZw3ymV1gOznrLqSolRNNv2FEq5qBZAo63dq3IvsburN4DRbEWzB
RxY5rj4M/uuX3ZALTQo562Q8O0jrZ+/VF7BcGJChtA0Ta8LAvOLmwMyUKIcYeKj+
QXgXIAEM40GSetueUDblgcuZYx+t6W50BTdqB2MBMnJznmF+qtGzPz768vg0q7Ww
bhQaehodoyDrcU8AFLOZtd6A2ev9Q6S4Y0yktlQbgaKaGgvSb+Iizx7IYRiLlsIc
Q7sH/gtVnR9RUMfq29otpmO9+qThcBMvHFWctU6o1k6nmZFc/G7Dwoihn9hfKX4/
08MESBRq2wHXqeDdjtvEZl8R1kwHUw==
=loDI
-----END PGP SIGNATURE-----

--QZtAWGn1GszBZLEb--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B6E81A28
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 14:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs03J-0000Qw-VZ; Mon, 16 Feb 2026 09:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vs03I-0000Qf-HP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vs03G-00077K-Dv
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771253896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc3eskw6EjXADVVe2Fh/wrvyTVBGJzr0Vp7RB93fmQU=;
 b=DiBzIBzp+mC+XJi+Kv5SCwPGom/A5kNQV1MFqlKNr+4a0WusMRfbEYC0fQpVGRe7ao3l0K
 asEkl406+jPh39bR4D4mui2UzN7u8H93uFmymZXuJ5LCyt6pW1Ef3DduSGm+Zcd+PIpx1z
 ogZ7hJ80V0E9wS1fgdMr8D1ybQA90qI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-5eX4HhTyOKqZIOW4gNT33A-1; Mon,
 16 Feb 2026 09:58:13 -0500
X-MC-Unique: 5eX4HhTyOKqZIOW4gNT33A-1
X-Mimecast-MFC-AGG-ID: 5eX4HhTyOKqZIOW4gNT33A_1771253891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE99C1955D99; Mon, 16 Feb 2026 14:58:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EFC319560AD; Mon, 16 Feb 2026 14:58:08 +0000 (UTC)
Date: Mon, 16 Feb 2026 09:58:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 1/3] aio-poll: avoid unnecessary polling time
 computation
Message-ID: <20260216145807.GA396170@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-2-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5BAxZ5spNFCCpeKd"
Content-Disposition: inline
In-Reply-To: <20260113174824.464720-2-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--5BAxZ5spNFCCpeKd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:48:22AM -0600, Jaehoon Kim wrote:
> Nodes are no longer added to poll_aio_handlers when adaptive polling is
> disabled, preventing unnecessary try_poll_mode() calls. Additionally,
> aio_poll() skips try_poll_mode() when timeout is 0.

Do these two changes need to be made together? If not, please split them
into two commits. This will make the commit descriptions easier to
understand.

>=20
> This avoids iterating over all nodes to compute max_ns unnecessarily
> when polling is disabled or timeout is 0.
>=20
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  util/aio-posix.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index e24b955fd9..7ddf92a25f 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -306,9 +306,8 @@ static bool aio_dispatch_handler(AioContext *ctx, Aio=
Handler *node)
>       * fdmon_supports_polling(), but only until the fd fires for the fir=
st
>       * time.
>       */
> -    if (!QLIST_IS_INSERTED(node, node_deleted) &&
> -        !QLIST_IS_INSERTED(node, node_poll) &&
> -        node->io_poll) {
> +    if (ctx->poll_max_ns && !QLIST_IS_INSERTED(node, node_deleted) &&
> +        !QLIST_IS_INSERTED(node, node_poll) && node->io_poll) {
>          trace_poll_add(ctx, node, node->pfd.fd, revents);
>          if (ctx->poll_started && node->io_poll_begin) {
>              node->io_poll_begin(node->opaque);
> @@ -630,7 +629,7 @@ static void adjust_polling_time(AioContext *ctx, AioP=
olledEvent *poll,
>  bool aio_poll(AioContext *ctx, bool blocking)
>  {
>      AioHandlerList ready_list =3D QLIST_HEAD_INITIALIZER(ready_list);
> -    bool progress;
> +    bool progress =3D false;
>      bool use_notify_me;
>      int64_t timeout;
>      int64_t start =3D 0;
> @@ -655,7 +654,9 @@ bool aio_poll(AioContext *ctx, bool blocking)
>      }
> =20
>      timeout =3D blocking ? aio_compute_timeout(ctx) : 0;
> -    progress =3D try_poll_mode(ctx, &ready_list, &timeout);
> +    if ((ctx->poll_max_ns !=3D 0) && (timeout !=3D 0)) {
> +        progress =3D try_poll_mode(ctx, &ready_list, &timeout);
> +    }
>      assert(!(timeout && progress));

Can you walk me through the timeout =3D=3D 0 case when polling is active?

Further down in aio_poll():

  /* If polling is allowed, non-blocking aio_poll does not need the
   * system call---a single round of run_poll_handlers_once suffices.
   */
  if (timeout || ctx->fdmon_ops->need_wait(ctx)) {

My concern is that aio_poll(timeout=3D0) could return without polling or
waiting for fds when polling is active. Maybe I've missed something that
prevents this?

Stefan

--5BAxZ5spNFCCpeKd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmTMH8ACgkQnKSrs4Gr
c8h5IAf+M2TbNPK+0XpZ03LnNcRUcREnEfeC4zAv/aYxtw35ehk4scAqHqsmRkjM
vD0nI5LDMG+q683KAuXrAYvwsMu0uQsVs4wKDHPes4LKPTUVZ0tbW8RwAw46sA6i
G5GUVXGgNek3y4mtELC3QUzkDW6CssMa1RL093Iw4i0V0Be3IOSZ3wt9HJ5XITz0
Ybj6xDS7gKfDndv0qpLg4FJhub87RSOix1rY8nz5be/g6YVS3+/Db3awJd8hL0hZ
Ag/gc/yiHZlceOACR1h69KqGrImGeXTKWYnGiX4Qxh3NXsYmn8URghdoWSxjzMX3
DypEd4II3q1IKs7QwKY00i6VEhA1oA==
=Vwbi
-----END PGP SIGNATURE-----

--5BAxZ5spNFCCpeKd--



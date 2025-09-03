Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF419CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvblC-0001Of-4r; Mon, 08 Sep 2025 09:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvbku-0001Jw-MC
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvbkg-0000WI-DH
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757337448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqR8npKklbOBXRqCKeqE1ClhsvPaMO6dnnorz324Qbg=;
 b=cYZuH+ucEup369A2KxSGL2+uNZXYixfHsEvivA/7g4Yd2le6nqC/ICQKrCzwYN5H2NBdYD
 khzDuF31ZX2UfI5rCJbTg5KOLanpc75+Yzbcgixm5KwbzqpQFuY2w29NbCshcQNc1x3d5y
 EFWe6iLtlWQMJoQVFFTAel44zxbAc6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-plwIajoZMbCe9otIKHFa0Q-1; Mon,
 08 Sep 2025 09:17:24 -0400
X-MC-Unique: plwIajoZMbCe9otIKHFa0Q-1
X-Mimecast-MFC-AGG-ID: plwIajoZMbCe9otIKHFa0Q_1757337443
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53BCD180057B; Mon,  8 Sep 2025 13:17:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB1DA1800452; Mon,  8 Sep 2025 13:17:22 +0000 (UTC)
Date: Wed, 3 Sep 2025 13:51:08 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
Message-ID: <20250903115108.GD106431@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9nNHia54bSfr63d3"
Content-Disposition: inline
In-Reply-To: <20250830025025.3610-3-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--9nNHia54bSfr63d3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:50:23PM -0400, Brian Song wrote:
> https://docs.kernel.org/filesystems/fuse-io-uring.html
>=20
> As described in the kernel documentation, after FUSE-over-io_uring
> initialization and handshake, FUSE interacts with the kernel using
> SQE/CQE to send requests and receive responses. This corresponds to
> the "Sending requests with CQEs" section in the docs.
>=20
> This patch implements three key parts: registering the CQE handler
> (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
> process_request), and sending response results (fuse_uring_send_
> response). It also merges the traditional /dev/fuse request handling
> with the FUSE-over-io_uring handling functions.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 309 insertions(+), 148 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 19bf9e5f74..07f74fc8ec 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops =3D=
 {
>  };
> =20
>  #ifdef CONFIG_LINUX_IO_URING
> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
> +
> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)

This function appears to handle exactly one cqe. A singular function
name would be clearer than a plural: co_fuse_uring_queue_handle_cqe().

> +{
> +    FuseRingEnt *ent =3D opaque;
> +    FuseExport *exp =3D ent->rq->q->exp;
> +
> +    /* Going to process requests */
> +    fuse_inc_in_flight(exp);

What is the rationale for taking a reference here? Normally something
already holds a reference (e.g. the request itself) and it will be
dropped somewhere inside a function we're about to call, but we still
need to access exp afterwards, so we temporarily take a reference.
Please document the specifics in a comment.

I think blk_exp_ref()/blk_exp_unref() are appropriate instead of
fuse_inc_in_flight()/fuse_dec_in_flight() since we only need to hold
onto the export and don't care about drain behavior.

> +
> +    /* A ring entry returned */
> +    fuse_uring_co_process_request(ent);
> +
> +    /* Finished processing requests */
> +    fuse_dec_in_flight(exp);
> +}
> +
> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
> +{
> +    FuseRingEnt *ent =3D container_of(cqe_handler, FuseRingEnt, fuse_cqe=
_handler);
> +    Coroutine *co;
> +    FuseExport *exp =3D ent->rq->q->exp;
> +
> +    if (unlikely(exp->halted)) {
> +        return;
> +    }
> +
> +    int err =3D cqe_handler->cqe.res;
> +
> +    if (err !=3D 0) {
> +        /* -ENOTCONN is ok on umount  */
> +        if (err !=3D -EINTR && err !=3D -EAGAIN &&
> +            err !=3D -ENOTCONN) {
> +            fuse_export_halt(exp);
> +        }

How are EINTR and EAGAIN handled if they are silently ignored? When did
you encounter these error codes?

--9nNHia54bSfr63d3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi4K6wACgkQnKSrs4Gr
c8je9QgAmkIyV3XxMBxfitb812vk+gHEN9YTdhmzQWiGBJJrTAOY4mCyvwAUFBAm
AJZp1nNdWsLNn4sXkaDpfoX8b6OD1zUdPXN7xO7D/b9VJ2i6eojtTNQDnrpsKe4v
f5ZqTl1mv3Diz/fT91Xu0HmSZyekCCqiooqaUuiOtWDQnQ0JwWuAUQR1UKL3m0k5
OfX40J2X+ucchpDLAVgpvzb+oHOsvyZHQWWz0XjjKYWzOzcaFYeuimz3B1BFwnLh
GP8fmRHXNN5Vf3HoOOS2TekJ03G4atI1J0Voe8M4jiN3xFk5ljVNg8+qxDreARg8
k9pp1/2/l1DgyTbLF4HCStRBzj8hOQ==
=sLsM
-----END PGP SIGNATURE-----

--9nNHia54bSfr63d3--



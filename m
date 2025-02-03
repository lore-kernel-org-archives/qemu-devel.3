Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329BAC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1yu-0004DL-Ff; Mon, 03 Feb 2025 14:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1yo-00046H-QA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1ym-0008CB-7z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738610371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRPOvXwBFqsddyoV1JdV/+3f7kPx7kXAOXxi+EjjvZg=;
 b=Z8Kgp3pS5xlt18/01sVcOFm34l2sZJZOq6axLVcjKDAdb8Jn4t9bBjoRKe3RX0VH5XrRZw
 yX/LPTv6AHqL8px1nvqzs9XzdX8oW/vqGHXrZqEIvXHDO9jYbJjFCsN1aXvoqzCG6BC4as
 bM5sN3YyfQGs3eYPkuAGg9Bo5WnCK1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-6sIrYJaKN3KpzWZxIifKwg-1; Mon,
 03 Feb 2025 14:19:28 -0500
X-MC-Unique: 6sIrYJaKN3KpzWZxIifKwg-1
X-Mimecast-MFC-AGG-ID: 6sIrYJaKN3KpzWZxIifKwg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9FB9195604F; Mon,  3 Feb 2025 19:19:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FE1B180035E; Mon,  3 Feb 2025 19:19:26 +0000 (UTC)
Date: Mon, 3 Feb 2025 14:19:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/15] nbd/server: Support inactive nodes
Message-ID: <20250203191925.GN268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tmL3nVsalkbdz10b"
Content-Disposition: inline
In-Reply-To: <20250131095051.49708-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--tmL3nVsalkbdz10b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 10:50:48AM +0100, Kevin Wolf wrote:
> In order to support running an NBD export on inactive nodes, we must
> make sure to return errors for any operations that aren't allowed on
> inactive nodes. Reads are the only operation we know we need for
> inactive images, so to err on the side of caution, return errors for
> everything else, even if some operations could possibly be okay.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  nbd/server.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index f64e47270c..2076fb2666 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2026,6 +2026,7 @@ static void nbd_export_delete(BlockExport *blk_exp)
>  const BlockExportDriver blk_exp_nbd =3D {
>      .type               =3D BLOCK_EXPORT_TYPE_NBD,
>      .instance_size      =3D sizeof(NBDExport),
> +    .supports_inactive  =3D true,
>      .create             =3D nbd_export_create,
>      .delete             =3D nbd_export_delete,
>      .request_shutdown   =3D nbd_export_request_shutdown,
> @@ -2920,6 +2921,22 @@ static coroutine_fn int nbd_handle_request(NBDClie=
nt *client,
>      NBDExport *exp =3D client->exp;
>      char *msg;
>      size_t i;
> +    bool inactive;
> +
> +    WITH_GRAPH_RDLOCK_GUARD() {
> +        inactive =3D bdrv_is_inactive(blk_bs(exp->common.blk));
> +        if (inactive) {
> +            switch (request->type) {
> +            case NBD_CMD_READ:
> +                /* These commands are allowed on inactive nodes */
> +                break;
> +            default:
> +                /* Return an error for the rest */
> +                return nbd_send_generic_reply(client, request, -EPERM,
> +                                              "export is inactive", errp=
);
> +            }
> +        }
> +    }

Hmm...end of lock guard. What prevents the race where inactive changes
before the request is performed?

> =20
>      switch (request->type) {
>      case NBD_CMD_CACHE:
> --=20
> 2.48.1
>=20

--tmL3nVsalkbdz10b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehFrwACgkQnKSrs4Gr
c8hOawgApX27dga9fIv37wxgvVLhDtRXN7ewR6gHcASd702AddIKncUTX2KsqGgM
+Qbz/ZNkcmVX/DgBXAqUvz0nO5dpoOMeXIOZtUnuJgpGpLLU89R6v4VpoFkb1GbU
HV8gLR8B79vaycEHU2JzWUwr1XXv3VqPDe0KV/UZ0vGdaEr+0cl8kM8la1CjedbY
XgXR9osii4p7nvBUYOmBK7N630jg6QYXWo8c1jmKrBmx13qUoCaR91GcDSRIqO2K
KxNl9Rtm6UoA1yXeqaT51kmWl43Ea+gXBFBR6Yc4U0N5nJ55gdbBJHqf4eggqT13
tiQfkVMh5LajZeT8M2JETB9x/iTc2A==
=MRrg
-----END PGP SIGNATURE-----

--tmL3nVsalkbdz10b--



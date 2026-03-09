Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09492EF370F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVnM-0003Ib-W3; Mon, 09 Mar 2026 04:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVlh-0002Ld-Fx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVlf-0003zH-Vb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773044110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kYo5zwTXKSpB+8xzwxC1SC56MIoInwghTipG2oXJj/c=;
 b=GKu7++QH8Q5DXEOPrpVNTY+iBKkHFbGGj1ebzN8LCJAuBUaYKkLBU0kr13kVIhZRUv5f0U
 JqiKZLMv+kOfG+FTc/7zrF9VFWF4uHJyJMWziqzULeoJNjbR5bgrb6X4ZQGw2Obgi+geE7
 Bw1+8zpf2X4RuRWV5EVX5ZgxrEYAiwk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-HZlTMLtXMuGR-fswLP_M7A-1; Mon,
 09 Mar 2026 04:15:07 -0400
X-MC-Unique: HZlTMLtXMuGR-fswLP_M7A-1
X-Mimecast-MFC-AGG-ID: HZlTMLtXMuGR-fswLP_M7A_1773044106
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437611956059; Mon,  9 Mar 2026 08:15:06 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0586D180049D; Mon,  9 Mar 2026 08:15:04 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:15:02 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 armbru@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
Message-ID: <20260309081502.GC39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5fThf1NTULKGb5Su"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-5-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--5fThf1NTULKGb5Su
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> Update the usage of "iothread_get_aio_context()".
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  blockdev.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 6e86c6262f..01ccf64b3f 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char *node_=
name, StrOrNull *iothread,
>              goto out;
>          }
> =20
> -        new_context =3D iothread_get_aio_context(obj);
> +        char *path =3D object_get_canonical_path(OBJECT(bs));

CCing Kevin and Markus in case they have an opinion on this.

BlockDriverState is not a QOM Object so using OBJECT(bs) is undefined
behavior and may crash.

node_name is unique across block driver graph nodes and could be used.
Unfortunately it's not connected to the QOM Object hierarchy. Maybe it's
best to build a holder name that is an invalid QOM path so there can be
no collisions between QOM paths and block driver graph nodes.

  g_autofree char *holder =3D g_strdup_printf("BlockDriverState %s", node_n=
ame);

(A cleaner long-term solution would be making BlockDriverStates QOM
Objects so they have a proper path.)

> +        /*
> +         * For this qmp case, hard to find the point put aio context ???
> +         * It looks like a pairing function is needed:
> +         * qmp_x_blockdev_del_iothread()
> +         */
> +        new_context =3D iothread_get_aio_context(obj, path);
> +        g_free(path);

Who calls iothread_put_aio_context()?

--5fThf1NTULKGb5Su
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmugYYACgkQnKSrs4Gr
c8hLgQf/ZokL3LkE9BYi86csKhOTiUDThODDINEX5VrFqAjXqDPvJYCzRgYcJP7e
P76U0DGbY5hlZtYn1Bk784+qTzQoqX4uf2/2e4m0StgebJ9E0MJam9ziS0xAj2pu
RHrUM0fq8je2agbkXY9Z7DOSrzodFerMOCnYLgjuSvoX2LW5jY9Wn4dIkF8OM7/X
TksKPd+gjY0ps6kClGUz8vmo+dmyqRaCtOrSrqK3Aa3Hym1eq62uxnF/DSgJpH5h
Teuncxiq9FLWbDNblNi0idKWpknj8F5na8wknwPWu9m/9mn1w2SSzlgE3/Mpaw2r
87UqyiXckoNQsd7Tflrrd8xAsjalkA==
=mvxs
-----END PGP SIGNATURE-----

--5fThf1NTULKGb5Su--



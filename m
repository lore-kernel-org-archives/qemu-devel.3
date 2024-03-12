Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38605C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OD-0002hh-3F; Tue, 12 Mar 2024 15:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7O8-0002gR-AH
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7O4-0005GA-5R
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hv9lhU99pUSNTR3RVVRjelenMP8k22L+YjIcDh7PNUg=;
 b=DebAo0tIy0zPIZ0/RT210QYSBuIApylrLWsiJFPuLOY+ZQK4a8xr9DpET4aOR4i/gPDrjv
 3GRtlGZYBQ/wYDKD2EJHyw1hOq7KwRnFiSD0RrZ+d0ezLdkZN2rbJ9yDsAyXSok+VSBBc2
 dlU+BWsv/4tyV8881SODCHxqwgKAfTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-DrpNYdq4NFWwkn0bI6-jqw-1; Tue, 12 Mar 2024 15:02:05 -0400
X-MC-Unique: DrpNYdq4NFWwkn0bI6-jqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E519A87A387;
 Tue, 12 Mar 2024 19:02:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 446122166AE4;
 Tue, 12 Mar 2024 19:02:03 +0000 (UTC)
Date: Tue, 12 Mar 2024 14:41:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Message-ID: <20240312184106.GC389553@fedora>
References: <20240312120431.550054-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+q6CGGAFNnxF8uth"
Content-Disposition: inline
In-Reply-To: <20240312120431.550054-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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


--+q6CGGAFNnxF8uth
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 01:04:31PM +0100, C=E9dric Le Goater wrote:
> The block .save_setup() handler calls a helper routine
> init_blk_migration() which builds a list of block devices to take into
> account for migration. When one device is found to be empty (sectors
> =3D=3D 0), the loop exits and all the remaining devices are ignored. This
> is a regression introduced when bdrv_iterate() was removed.
>=20
> Change that by skipping only empty devices.
>=20
> Cc: Markus Armbruster <armbru@redhat.com>
> Suggested: Kevin Wolf <kwolf@redhat.com>
> Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")

It's not clear to me that fea68bb6e9fa introduced the bug. The code is
still <=3D 0 there and I don't see anything else that skips empty devices.
Can you explain the bug in fea68bb6e9fa?

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+q6CGGAFNnxF8uth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwocIACgkQnKSrs4Gr
c8hF0wf/UuTJ5zj2VdVOY4FLuSmdbN7IoynUemxKq93t2AVt7Aipbn1Jd25HByV+
ycV5S/7Gq/yJpWc+laolWhQE+/GHc/MABNmI49X1cOeb+qI2RXYY0jREyVAw//cJ
mf3pcXKlijGBoX7Tea3rHgQDde9HEatwLM2bdp2dQdOGO1+f6AzA6+Ir4RI13dzT
nwbHRDo49RhNZGFxsVk7zrXd5LNANm3iiQlpdbiGBluKQgHJWnOSftN2KJv8x0+A
ZsuPY4FrPG8BoACFQpHM78HFJvh7U1umei/mTAeS0N4wqKM3QN4mvHXC5pPdc0p9
YX/QjV9nRxhPqzOrMEGNMaelRFkDgw==
=Ck5Q
-----END PGP SIGNATURE-----

--+q6CGGAFNnxF8uth--



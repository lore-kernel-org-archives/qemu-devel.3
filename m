Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E37C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1V9-0007xi-Nd; Mon, 03 Feb 2025 13:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1V7-0007xH-4g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1V5-00056Z-Qr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6JtL0wQc+Ll22ei9gBkRj/PBJik0I8AKhJ4VTTKdG50=;
 b=CaM3jedf2Y99/NjyygoiOodHdDzRBamem1EDZYB7T11TuyAPbNdNwuPlHq7v2M3JXCe+r4
 cAPs7i1HmcGyq6XDReghdTD9MSff0IWZfIs7j9EF0CrvWYzUIXj4VdeRCvF2m8Hxso30K+
 BzH/iAskXcqAo5krUgHzXRx5zlNzayY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-xb-FWDJJOH-S-NjKH3mHyw-1; Mon,
 03 Feb 2025 13:48:46 -0500
X-MC-Unique: xb-FWDJJOH-S-NjKH3mHyw-1
X-Mimecast-MFC-AGG-ID: xb-FWDJJOH-S-NjKH3mHyw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 892FB1801F16; Mon,  3 Feb 2025 18:48:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6EA0195608E; Mon,  3 Feb 2025 18:48:44 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:48:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/15] block: Inactivate external snapshot overlays
 when necessary
Message-ID: <20250203184843.GD268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h5k3eLBzuaNY3Npe"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--h5k3eLBzuaNY3Npe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:33PM +0100, Kevin Wolf wrote:
> Putting an active block node on top of an inactive one is strictly
> speaking an invalid configuration and the next patch will turn it into a
> hard error.
>=20
> However, taking a snapshot while disk images are inactive after
> completing migration has an important use case: After migrating to a
> file, taking an external snapshot is what is needed to take a full VM
> snapshot.
>=20
> In order for this to keep working after the later patches, change
> creating a snapshot such that it automatically inactivates an overlay
> that is added on top of an already inactive node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--h5k3eLBzuaNY3Npe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehD4sACgkQnKSrs4Gr
c8iPtggAhR1vpjEezWTRvWE3Cx2Tt4weKjGsRc+vYq52q/QPj0jQK7feh8StWc/c
voQZ4nk3Hd4F618cnoXsfOTL12yQKNEa1c6lvaG25YkexclsfmQ2me3LE1M90JrJ
7gclY2CeKOZ9Vbn+aCqDsKbxeuAp7s9qMuEH5HD2kdBLuYRQDQXwJa+WbCHX1NEW
WYguv4jOXVMZFGSB2U1ZAC741SOyHN7R4yf9lJIG/m6uVT5jcjN4s2moUvEhqgLa
jNCK9cXfxoRp0IJriH+UyzweWBJJJeHAa8SAioSqW5qXF7KKeKuC7rwwhboVv/Xe
TMfshpbq4HLC6SDwRIFu/Rh4QQDdfg==
=hUWf
-----END PGP SIGNATURE-----

--h5k3eLBzuaNY3Npe--



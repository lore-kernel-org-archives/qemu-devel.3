Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0065DC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 17:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfre-0001yH-KS; Mon, 09 Jun 2025 13:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOfrX-0001xh-9r
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 13:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOfrU-00069i-Qt
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 13:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749488438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5GmvFpyMl3C/0ldOlELVEg1affgyr1iCNf8mbQ6z74=;
 b=X+OWsNoy+YVS12ikUlg6NNRf8AI/OqCX4Sygppm6oASReMyK0gIXSpUKkzTc42eDcai8P8
 xk7D08kJqcHJCaUgCDv+71jmUWJYvd98NZOrpP5kdPkJD4NUNZkhEsCpW3G4p5ibyZ9dFs
 8TC6Wmr3OjWfUF3lLmzeysIWo+TSA7c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-4nQCgWNVM0qRg9KPphmUQw-1; Mon,
 09 Jun 2025 13:00:36 -0400
X-MC-Unique: 4nQCgWNVM0qRg9KPphmUQw-1
X-Mimecast-MFC-AGG-ID: 4nQCgWNVM0qRg9KPphmUQw_1749488436
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0C271800366; Mon,  9 Jun 2025 17:00:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 465CA1956087; Mon,  9 Jun 2025 17:00:35 +0000 (UTC)
Date: Mon, 9 Jun 2025 13:00:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 16/21] block/export: Add multi-threading interface
Message-ID: <20250609170034.GI29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-17-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="10kcsb3mv8raIhRA"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-17-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--10kcsb3mv8raIhRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:08PM +0200, Hanna Czenczek wrote:
> Make BlockExportType.iothread an alternate between a single-thread
> variant 'str' and a multi-threading variant '[str]'.
>=20
> In contrast to the single-thread setting, the multi-threading setting
> will not change the BDS's context (and so is incompatible with the
> fixed-iothread setting), but instead just pass a list to the export
> driver, with which it can do whatever it wants.
>=20
> Currently no export driver supports multi-threading, so they all return
> an error when receiving such a list.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block-export.json               | 34 +++++++++++++++++---
>  include/block/export.h               | 12 +++++--
>  block/export/export.c                | 48 +++++++++++++++++++++++++---
>  block/export/fuse.c                  |  7 ++++
>  block/export/vduse-blk.c             |  7 ++++
>  block/export/vhost-user-blk-server.c |  8 +++++
>  nbd/server.c                         |  6 ++++
>  7 files changed, 111 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--10kcsb3mv8raIhRA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhHEzIACgkQnKSrs4Gr
c8iYNAgAvcLlKmHKZXjzM+bWqsdd9/ZaAEsgPhfqt9XEPwvIty521h+BkBFBNWj9
BnI+q72pqFnRp/ehRDiuFYZA/bgh2cXYjmrdYHIbjK/bCY7f4DzBkE7rB5NKWCx6
wVvptkvRVCqB++5k+bQxDVnqwPjNEyb3wLX4pGs6AQrjWTw7HefpEOX4GpGOfrga
oCuGPpSby5dDBQVvLGbN378O7cJdX/20FSo8tIFnpnbjuGUE+zfQxyyGTuUPeVhL
SVR7cicZpF5JEGM/dUV0wN7iGvX9lUFGiWCxzwiI6p+zbzARxoARCX+nX5fG4ZBp
/ksPN5kaJPlto025kzNgBGcsDpoQLQ==
=kgLu
-----END PGP SIGNATURE-----

--10kcsb3mv8raIhRA--



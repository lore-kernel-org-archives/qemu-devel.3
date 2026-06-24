Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A3DCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTAP-0002js-ID; Wed, 24 Jun 2026 15:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcTAI-0002jY-2u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcTAF-0007Xc-UM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782328894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaeg/PA7yWdgOgQBl7bkcl6SdBl5SL48gt6NzwYzObE=;
 b=al6Qbp3xScGkpNDupDEcSn52uZNGIJyxcFyD2dCtOTpvW6dDvTykCELrTZ/H1VgYPfAAOI
 8VqSECTLSo6Hv9SlfmGyXf2FkjJ9xL3wGOH+G2kiAoVAbaVxB6P5Fh536tX4l29BKjFqUE
 mPmFsTayQoOZ6/ExCpwgNcBX9Oqy1Ds=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-se_5FLeZPR2Tr6UZNwQu-Q-1; Wed,
 24 Jun 2026 15:21:29 -0400
X-MC-Unique: se_5FLeZPR2Tr6UZNwQu-Q-1
X-Mimecast-MFC-AGG-ID: se_5FLeZPR2Tr6UZNwQu-Q_1782328887
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 952EC18001F3; Wed, 24 Jun 2026 19:21:27 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD2721956041; Wed, 24 Jun 2026 19:21:26 +0000 (UTC)
Date: Wed, 24 Jun 2026 15:21:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 3/5] virtio-blk: do not merge writes across a zone
 boundary
Message-ID: <20260624192125.GG109308@fedora>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RMdWOKqZmxKwB+oz"
Content-Disposition: inline
In-Reply-To: <20260623184830.373232-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--RMdWOKqZmxKwB+oz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 08:48:28PM +0200, Sam Li wrote:
> virtio_blk_submit_multireq() fuses adjacent in-zone writes into a
> single request. On a zoned backend, a merged zone append request
> that straddles a zone boundary is rejected by the device because
> each write must stay within a single zone.
>=20
> Add a bail condition to the merge coalescer: if combining the
> candidate request into the current batch would cross a zone
> boundary, flush the current batch and start a new one.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/block-backend.c             | 11 +++++++++++
>  hw/block/virtio-blk.c             | 22 +++++++++++++++++++++-
>  include/system/block-backend-io.h |  1 +
>  3 files changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RMdWOKqZmxKwB+oz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo8LjUACgkQnKSrs4Gr
c8iLPQf+MYIX/kI6qETg0Ky+InEYlTIjmb/moKq9/4yD6FM9qsHWJKMKug0dfpVp
fUUjphzmbVpvMFbrl/VWxZhrJu6t5LTSCYyhwnb+nsj8i43p5jurhhbPzvskCvHZ
NP5sqsbqkZIUyQoRqeGqz5ubG1phrdEc2jfD+u3zVz3cvoBRRa+wXo1LITdMBvhu
o+zkEuO+Kgscp1bX492aKabKJ2faXZ8zP/MeTq74bvyfZTGIHmoSGt77ptWeqf0w
DNZCzxS4tG5R8qlrFnpxNtOpyUGUU4sLqinuh/NbmcZIKzv1S9izcq+8X0IsrBq2
4Y8+SGCHBTjZXIISWReAvHC0urLSAw==
=WZbE
-----END PGP SIGNATURE-----

--RMdWOKqZmxKwB+oz--



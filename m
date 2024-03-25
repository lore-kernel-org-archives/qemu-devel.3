Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB26C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 20:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roqdt-00044p-BK; Mon, 25 Mar 2024 16:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqdl-000435-DJ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqdj-0007tA-C8
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711397390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F6QJ6kRN7vV9tijucp6vVQOscc3kDVl26a1G82aqAIw=;
 b=LSOPIUDmug56VjGDs2l4ckFizMDIkMNu+sl3OrXlc/cIUfdd+bI7cHh9yDd6T8KMTE92fy
 FMqUttvZ2mMQDb69wrgAdGpsNa3+WuFKg5KDbqdUOXrTBjb56raV5P2EhT2V/YLxgiNWZv
 U80+groDenR727HydIGhPHFkLy9/3bY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-Oj_nrBpnNfyGkmevQXdhdA-1; Mon,
 25 Mar 2024 16:09:46 -0400
X-MC-Unique: Oj_nrBpnNfyGkmevQXdhdA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A46D91C0514F;
 Mon, 25 Mar 2024 20:09:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AD12492BD3;
 Mon, 25 Mar 2024 20:09:44 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:09:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: Re: [PATCH v3 4/4] iotests: add test for stream job with an
 unaligned prefetch read
Message-ID: <20240325200939.GD1944176@fedora>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-5-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dVkCbGD1Aen6iqTi"
Content-Disposition: inline
In-Reply-To: <20240322095009.346989-5-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--dVkCbGD1Aen6iqTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:50:09AM +0100, Fiona Ebner wrote:
> Previously, bdrv_pad_request() could not deal with a NULL qiov when
> a read needed to be aligned. During prefetch, a stream job will pass a
> NULL qiov. Add a test case to cover this scenario.
>=20
> By accident, also covers a previous race during shutdown, where block
> graph changes during iteration in bdrv_flush_all() could lead to
> unreferencing the wrong block driver state and an assertion failure
> later.
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> No changes in v3.
> New in v2.
>=20
>  .../tests/stream-unaligned-prefetch           | 86 +++++++++++++++++++
>  .../tests/stream-unaligned-prefetch.out       |  5 ++
>  2 files changed, 91 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
>  create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dVkCbGD1Aen6iqTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYB2gMACgkQnKSrs4Gr
c8irMQf/e2+BKy+hOAsqcn57EimFa/dL5BWFqLVnN2ae9EwLFu4EvP56vJNrHMDy
eakJ942UCOXdjl8v1aAsQayUF+8rrZJMKlUK1UW8yaYvIl7u3rjCx88tMq+3m/ci
Df93MLx064L0xaYMvvnqwJESUUdBO+2Yp8aa1Tf0wzM4b+DCtuCyF/pCGsx5BSIk
IejvGMl4mSi0sD3etaSwNblLWsz9VGnFqSOZ0LYeFTVkLqJtt22jR1rQ2R74qFD6
60LWu4aLq3YtnfIaCKM1pYEJlORdjz9TWiirdt3mmINww8eppvx90A55sfD+dhho
qR0LmHhqceVaYuBLtxLdqCR5JnYfeQ==
=o0rV
-----END PGP SIGNATURE-----

--dVkCbGD1Aen6iqTi--



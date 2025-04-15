Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F8C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4iIJ-00077q-63; Tue, 15 Apr 2025 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4iIG-00076s-85
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4iIC-0006Nc-Qc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744731221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Lnj871fcScrcXI/r2vvOwd5+1zP89VbaiLYnX7f84k=;
 b=SlCKDDRhzPNONKYGOsqfCRkUmJ7sjzKs3phi22zegFKJsZ6n5ejUdcpGTVutv7ziwXMn19
 kTDn0hdEPyA+ykS/qQKXkrFY4Z6RzPDMWr1dxVs7lB0LJQHKR8SrpOBhQf552TMawP6uCO
 fyiRbfoKyL10SpPjDPJSKIdYqUF0w7Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-cFHQLHjGPT-3ZB-kATAy4Q-1; Tue,
 15 Apr 2025 11:33:36 -0400
X-MC-Unique: cFHQLHjGPT-3ZB-kATAy4Q-1
X-Mimecast-MFC-AGG-ID: cFHQLHjGPT-3ZB-kATAy4Q_1744731215
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99CD81955DCF; Tue, 15 Apr 2025 15:33:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.210])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E77319560AD; Tue, 15 Apr 2025 15:33:34 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:33:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] Revert "virtio-net: Copy received header to buffer"
Message-ID: <20250415153333.GA283305@fedora>
References: <20250408145345.142947-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hyOw1qXYGLUM+zLv"
Content-Disposition: inline
In-Reply-To: <20250408145345.142947-1-adamhet@scaleway.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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


--hyOw1qXYGLUM+zLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 04:53:33PM +0200, Antoine Damhet wrote:
> This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
>=20
> The goal was to remove the need to patch the (const) input buffer
> with a recomputed UDP checksum by copying headers to a RW region and
> inject the checksum there. The patch computed the checksum only from the
> header fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> ---
> v2: Rebased on master due to conflict with c17ad4b11bd2 (
> "virtio-net: Fix num_buffers for version 1")

Applied for QEMU 10.0, thanks!

Stefan

--hyOw1qXYGLUM+zLv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf+fE0ACgkQnKSrs4Gr
c8iO7ggAuH21mP9pVY5LF2TcTDZ2s+0sYjfk7HGiiJhmLDWRfZ3/c+KcR3UVznMo
eF8yfVuBntCg3XhBBmRSyF695I07zSUpW6yd1EU9751Z7fjvgHh7L+dQHhHskbJA
YvK/kDjPizoYP1GGNRf/BH/tO0pMtGxUTlykHPnEU/J+vEQRFcgIZai0Ir0a3x5U
dgUNEGSb/6xopTIY9jQ1A3zYP3JSCIGE8j4zP//s9GKVe8ZnZ6csIaHIEsxgLCuP
iCjN2z/w5yNb7fRKi2iPVXCRTprVER3olZ8W2yKNoTGlcC/5AgJwvm0naEPYl1Bd
jnFsrZX+UYiyqzQHF641S3g/70L9sQ==
=bnPR
-----END PGP SIGNATURE-----

--hyOw1qXYGLUM+zLv--



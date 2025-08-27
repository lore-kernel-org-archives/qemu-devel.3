Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D159ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 19:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urLZR-0002dT-0S; Wed, 27 Aug 2025 15:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLZN-0002c3-OC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLZG-00057e-31
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756321929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HP4fcrPHwWdMLO/wQnV74P1E6wRQWYb0BzDzVanmcIQ=;
 b=h50De55RNX6byDvY4FOXZ6ViUKBww5IOMv6TwGZyi6kY/SEi8eXhz+PnZIPZeSTTSi7cuX
 gHy6s1dC8bgbG9CjgdJqwA5sld6QfeN3iA1QgvI2izLdhd/MFH5oK+r/VawYwaHYW2CODx
 ShFYTsixYDQJAG9eCZoPFvKjlAPvmeg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-EE7ZtsA9PNu8VkFPe9wwYg-1; Wed,
 27 Aug 2025 15:12:05 -0400
X-MC-Unique: EE7ZtsA9PNu8VkFPe9wwYg-1
X-Mimecast-MFC-AGG-ID: EE7ZtsA9PNu8VkFPe9wwYg_1756321924
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E790195609F; Wed, 27 Aug 2025 19:12:04 +0000 (UTC)
Received: from localhost (unknown [10.2.17.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95C7E1955F24; Wed, 27 Aug 2025 19:12:03 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:12:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 02/14] rust: move dependencies to rust/Cargo.toml
Message-ID: <20250827191202.GA228377@fedora>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CmpdG409zqZIczzy"
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--CmpdG409zqZIczzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 02:26:43PM +0200, Paolo Bonzini wrote:
> As more crates start using the same dependencies, it's better to not
> repeat the versions and move the dependency declarations to the workspace.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml          | 5 +++++
>  rust/qemu-api/Cargo.toml | 6 +++---
>  2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CmpdG409zqZIczzy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmivWIIACgkQnKSrs4Gr
c8gXQgf/QCGzjh1PYvtEUx2wNxjzxY9bBNBsc/WDRtn5t6saTxSGSfN1pAmkefZl
qhWa03O2FO/Eiha+20OzAPFFeLg5Wf/PA4ak5ovVhI/5CvpsqxFLYX/KFv0QgUj5
o7TwnI4o4azAls9rbzkaShFj6SHY0dNe2EoFI7ObEng1R4n0KA300pz7pDrA/OrZ
MhGPvlcSzrBkQihnEIA9lM/tvO5sxGj+lgUBUmNqCoSplPxyvjHIyWjskuVBtTVj
Ntj+wB9BLcah+9K4MWsF/FvCoP2UAKa66AqrtEM75Q0IoxPB1fH0HNN8R/ikXju7
iTwDfAp/fK6nERGw4+9EmwdeuxxBrw==
=IfRb
-----END PGP SIGNATURE-----

--CmpdG409zqZIczzy--



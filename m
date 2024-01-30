Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDEBC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUba9-00030c-Li; Mon, 29 Jan 2024 19:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUba5-000308-Vt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUba4-00018M-Gs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706572943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmCfdCncqUQG9Ln0T7VbzkYRZvJ2vHqZ635cLCjYBR0=;
 b=RHFnwrqfiKcqX3+7dMj2JLIjxbwWU59zIqJVZsMbnfKvTvAKymYnk1sireZltxDWO3ByN+
 REs1zTUzXM12C7X1Q6aPrBSl8PCqbpOoZZlgcG+d8Avw1eb+k3CpRP9cwHJee7WB6l2ZVQ
 U8bQ07dkO/NK01V6jP7GuH660cHBJpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Qvpatom-OB-OTmBH3Z00vQ-1; Mon, 29 Jan 2024 19:02:17 -0500
X-MC-Unique: Qvpatom-OB-OTmBH3Z00vQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28ED21013669;
 Tue, 30 Jan 2024 00:02:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82BEB112131D;
 Tue, 30 Jan 2024 00:02:16 +0000 (UTC)
Date: Mon, 29 Jan 2024 19:02:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 1/2] hw/core/qdev.c: add qdev_get_human_name()
Message-ID: <20240130000214.GB217529@fedora>
References: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
 <5fb58797083e7786fd3556d2c247609565b8637d.1706023972.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nJfSoF3BL3SQ+32x"
Content-Disposition: inline
In-Reply-To: <5fb58797083e7786fd3556d2c247609565b8637d.1706023972.git.manos.pitsidianakis@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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


--nJfSoF3BL3SQ+32x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 05:35:30PM +0200, Manos Pitsidianakis wrote:
> Add a simple method to return some kind of human readable identifier for
> use in error messages.
>=20
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/core/qdev.c         |  8 ++++++++
>  include/hw/qdev-core.h | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nJfSoF3BL3SQ+32x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW4PIYACgkQnKSrs4Gr
c8io4Af+OZz2Yum4eBCN8HyF+r+mwzBQAbLVhU4uXcr/W+zRD8+lmEgomaJ0iWak
e+g2/jUsBs8qsEL0N1cnLvbfr/y8GoqchabNB9QRLI75pByBugz5SDEBstc2zH4l
XxRyM23lF3ZeG1bOg3+S30oJrsdtsgvxc90Ix0tUXj7ILWTndYikRy208Ypwtgis
RzABkvnMHdr/llisAgZ6X99m+TgaD3Psk9QG+H97guokNXboUnCe0RzL8fk7Gnsl
gDd87iO8kxvbC7zYhWQiijsYrwjnh721uddVoMjaCJtDRoEE6IjaUiYztlqh3rJD
PhPA+nf8wYIIA216POIpfEJoKZl20g==
=DIxG
-----END PGP SIGNATURE-----

--nJfSoF3BL3SQ+32x--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78C1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18LR-0004Fk-AK; Tue, 23 Sep 2025 15:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18LP-0004Dp-Q7
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18LO-0004yo-FO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758654389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bH8xDDp+uaceo19uhiRfWeRSPKvhy3f7TVKJ0KX6DHo=;
 b=ZZ0JZozi9WgKUqqu84ONlH8ghoUJAVrQPVY64LpfoAmBWSjDSPIWoImUj+Bb3/WaTnpGnp
 IcYpGOTZNS1gx4MGMx/O5N0b7QTSH7lUZO3dlQV5+YPh2om954PfWgHiYFBWFWFdBZ57Yx
 ru4u9oQxGrbd5aZ62uwEeVN8xI1Ck4g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-MOXRWCXUPnClF6LPDxhUrg-1; Tue,
 23 Sep 2025 15:06:24 -0400
X-MC-Unique: MOXRWCXUPnClF6LPDxhUrg-1
X-Mimecast-MFC-AGG-ID: MOXRWCXUPnClF6LPDxhUrg_1758654383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E57419560B2; Tue, 23 Sep 2025 19:06:23 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC35E1800446; Tue, 23 Sep 2025 19:06:22 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:06:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 01/16] tracetool: fix usage of try_import()
Message-ID: <20250923190621.GH509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NQorKe51TMqShg1A"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-2-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--NQorKe51TMqShg1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:21PM +0200, Paolo Bonzini wrote:
> try_import returns a tuple of a boolean and the requested module or attri=
bute.
> exists() functions return tracetool.try_import("tracetool.format." + name=
)[1]
> but they should return the boolean value instead.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/backend/__init__.py | 2 +-
>  scripts/tracetool/format/__init__.py  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NQorKe51TMqShg1A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS760ACgkQnKSrs4Gr
c8itfQgAlyTQEXkhTAxUun9SmdWAH4RtFjZpyvPk+5qJ1cbEuH5TrUnbVeuIXGqV
CDEtgrbz9zGNiQV8fWrsvi15aAFQt6z0q0XC0yMzz37cRMAg4eThLgsvl37mvBfm
JbXlM3jF40o5kA7XKUeCjN2vP0FB1fO05hqguhldmz/NJ2O2TbTEnY/7x5DV2qvh
Dn95UXfmJt93zQXCdxtTx8ktXGiHOK7jBIfsjjJRKpbk820yfMdaA9U9GmYvrmQH
Juzlk6CT7Q1YRPowCkSDu1oJZm19TgNzQRSu9xkuYCjG5LITO8jUt7028x1Hfe7c
Iut+wTaqXE4sGTU24QsxdsGuCkjvVg==
=Jzmw
-----END PGP SIGNATURE-----

--NQorKe51TMqShg1A--



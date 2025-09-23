Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40BACAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18hz-0006Tu-T7; Tue, 23 Sep 2025 15:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18hv-0006Qj-W6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18ht-0007gr-HW
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758655783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uUXpNc/aJxHAGgbGBMw8wNEYjf09AOouRPvsns6ucVE=;
 b=OdpE+K5Ny4SCmy3rKe4HStgyPsPyeqV+JeOgSFM4X1/tv1PISNGvpOGpAQz7usNg/U4jUM
 KcK8x78LDE6Hr5V1ePG1n9dRGC4WQQQcoQjhcuKvB/LXCK69tOn8QURlnvfjn8lpAFTnEW
 Pi6mpldeqL7+DoXkJ4H/kDw6abD3qR0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-I4eC8CX-M7SV5O44DZyRUA-1; Tue,
 23 Sep 2025 15:29:39 -0400
X-MC-Unique: I4eC8CX-M7SV5O44DZyRUA-1
X-Mimecast-MFC-AGG-ID: I4eC8CX-M7SV5O44DZyRUA_1758655778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB1F180832E; Tue, 23 Sep 2025 19:29:08 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00D14180044F; Tue, 23 Sep 2025 19:29:07 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:29:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 09/16] rust: add trace crate
Message-ID: <20250923192906.GM509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t6TkOeyLIoOOjkEs"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-10-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--t6TkOeyLIoOOjkEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:29PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> The trace crate is a minimal container for dependencies of tracepoints
> (so that they do not have to be imported in all the crates that use
> tracepoints); it also contains a macro called "include_trace!" that is
> able to find the right include file from the trace/ directory.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> [Write commit message, add #[allow()]. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock        |  4 ++++
>  rust/Cargo.toml        |  1 +
>  rust/meson.build       |  2 +-
>  rust/trace/Cargo.toml  | 16 ++++++++++++++++
>  rust/trace/meson.build | 19 +++++++++++++++++++
>  rust/trace/src/lib.rs  | 35 +++++++++++++++++++++++++++++++++++
>  trace/meson.build      |  8 +++++++-
>  7 files changed, 83 insertions(+), 2 deletions(-)
>  create mode 100644 rust/trace/Cargo.toml
>  create mode 100644 rust/trace/meson.build
>  create mode 100644 rust/trace/src/lib.rs

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t6TkOeyLIoOOjkEs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS9QIACgkQnKSrs4Gr
c8g7QwgAkHHGqy1GsHTDJTpKdkG6A1Ruj5uz1XHr6O1Zfyy+a+tbwWfbw5Xf7EmX
ySi8nU0+hU6X7alKCoXbHYIXWMluh5G0z7XqdqH1RKWpzGsmcmjAsesIcFX4rHmF
GVUVQGkXwa6YD6wzofipfEU2oDzKwnOtWLuAezemUx0qTpR40TTLQrL+Fx7Yc/55
fJKy6M1u+NHsIT7gVtzikoniqGNXePR605pRNI4vcoDR+z+pRpJ/WMXyuy4u2D4o
7e1x7ZPyxRFa1hqPPcNI7iUsp6StamP0PD1OBi6s3QMKhVLUrQ1klrHi3bUq62+t
4RvGKJOWkADL0vSum1fl3HqfsswQYA==
=wrim
-----END PGP SIGNATURE-----

--t6TkOeyLIoOOjkEs--



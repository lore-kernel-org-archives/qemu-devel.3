Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B54CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18pi-0002Tn-MM; Tue, 23 Sep 2025 15:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18pQ-0002Q0-N0
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18pP-0000Lh-0V
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758656248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jwyeMEvn5YmknXR4pqYL4RbQX2qzqgcqQZ7xtyz/uY=;
 b=FVZxsLpYSZLRw+TnGrnBwLLR6he6Wv43KK0aP5nDddkj6W0qodHttS6JDexG1Ro3xWJiWe
 knIrmQlSMb+CGMnGpaK4oeCF3gzXsToaPpLpWwA5K5my+IHKYygKTQdwfnejc7jDmE6jFj
 wnfqD1GTV9jXmgaCWlcoWGZU8Ko0ajI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-oNSH7ZRpNciUv6eYvxeT2g-1; Tue,
 23 Sep 2025 15:37:24 -0400
X-MC-Unique: oNSH7ZRpNciUv6eYvxeT2g-1
X-Mimecast-MFC-AGG-ID: oNSH7ZRpNciUv6eYvxeT2g_1758656243
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ABEC1955BDD; Tue, 23 Sep 2025 19:37:23 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C205D1800452; Tue, 23 Sep 2025 19:37:22 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:37:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 16/16] tracetool/syslog: add Rust support
Message-ID: <20250923193721.GR509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+7O0pHL/LqUT/tO"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-17-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--d+7O0pHL/LqUT/tO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:36PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> The syslog backend needs the syslog function from libc and the LOG_INFO e=
num
> value; they are re-exported as "::trace::syslog" and "::trace::LOG_INFO"
> so that device crates do not all have to add the libc dependency, but
> otherwise there is nothing special.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock                     |  3 +++
>  rust/trace/Cargo.toml               |  3 +++
>  rust/trace/src/lib.rs               |  4 +++
>  scripts/tracetool/backend/syslog.py |  7 ++++-
>  tests/tracetool/syslog.rs           | 40 +++++++++++++++++++++++++++++
>  tests/tracetool/tracetool-test.py   |  2 +-
>  6 files changed, 57 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tracetool/syslog.rs

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--d+7O0pHL/LqUT/tO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS9vEACgkQnKSrs4Gr
c8gN4ggAvOQ/3sFv03WmxIWwx1OPztbEttiYci5j3uFN6pk8yh28CofA57gk0tOD
NXF6cUNqjGPWOKuCXOEIjri82i2JCAuTvhW1DIxZuh5K1iuySNc7o8DXwiBHYQNe
G9pDv2JaiqOmHLlRHdTE0t6k3f/v0K0VhXmDJlU8ZPEuIDRVjWWiUomqRZJBynnJ
WtATpqvSJLDCHJaL38qe3U989S9IBzAUe5cFwtuM10iVus193+jn2pFkOcjGpiUz
7TdC+nV0j+Yx12rhdM5DMrY+bSEFiicOIsy7secTenctLwUelrB1BVdndXGoGpie
ydN8uRZrUjheqj56ePn1fr1X8KddLA==
=EcUA
-----END PGP SIGNATURE-----

--d+7O0pHL/LqUT/tO--



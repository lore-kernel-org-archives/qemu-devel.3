Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63647C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcqA-0002vc-Kn; Mon, 09 Jun 2025 09:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOcq3-0002tR-WE
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOcq1-0001vI-6A
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749476814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hV9+Ya9sSZryZs9SUEawYWiw5YKPD16P2itO83LznZ8=;
 b=Bmje/FVbRITH2rajybUCzp0Owa2SgSSfg4UWnYuCpics6icLDCx2DcjkVhtdVF6rkQvct4
 Tkep12RAdkndihbJ6/QCaMfeIoXOJOQ5i69LyA4uMFDuzn3yN9z4dd5GFf4EHjNmCjJ9kc
 5GvwTLWqMi5C7uIDVsk2hLCoB1XiFKY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-DWTrbm0aMq6ksFdAwLPGTA-1; Mon,
 09 Jun 2025 09:46:50 -0400
X-MC-Unique: DWTrbm0aMq6ksFdAwLPGTA-1
X-Mimecast-MFC-AGG-ID: DWTrbm0aMq6ksFdAwLPGTA_1749476808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51EB41809C88; Mon,  9 Jun 2025 13:46:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 391B5195608D; Mon,  9 Jun 2025 13:46:46 +0000 (UTC)
Date: Mon, 9 Jun 2025 09:46:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/4] system: Forbid alloca()
Message-ID: <20250609134645.GA29452@fedora>
References: <20250605193540.59874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JazMeH5Ktse/7gSQ"
Content-Disposition: inline
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--JazMeH5Ktse/7gSQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 09:35:36PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Eradicate alloca() uses on system code, then enable
> -Walloca to prevent new ones to creep back in.
>=20
> Philippe Mathieu-Daud=E9 (4):
>   hw/gpio/pca9552: Avoid using g_newa()
>   backends/tpmL Avoid using g_alloca()
>   tests/unit/test-char: Avoid using g_alloca()
>   buildsys: Prohibit alloca() use on system code
>=20
>  meson.build                 | 4 ++++
>  backends/tpm/tpm_emulator.c | 4 ++--
>  hw/gpio/pca9552.c           | 2 +-
>  tests/unit/test-char.c      | 3 +--
>  4 files changed, 8 insertions(+), 5 deletions(-)

Modulo the comments that have already been discussed:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JazMeH5Ktse/7gSQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhG5cQACgkQnKSrs4Gr
c8hkUggAgeVKubOsPeGI4LdB0ueNexdgP9rvelpyaSbbhdghxylxc0bYfBITDM55
qH4+0Gfya7e98jEu+DCBvNm57oFEGO32Yk3VVZBcrZaQco1FQ7D9bxsM61COowmO
WYXdP8B5x5rUnVbakULqr1d8uUKffDMlHpphp8lQMyOIuFZ8Q/jKjU85tP3MqMHD
trOcz4Ekii8OVWeamufvByOrL+9w2uVD/xPbemCiQsoz8yeIZWO4YVj0qu0q7dN1
CHZpzrFHnxCzuuB80ssPkHPz3es7/X0pD4ExHnRXUf+YYtinlLuBneljglc6ETKv
/UlLFKwoqodCsvcfMNGQCFsJGpf+Tw==
=qCY4
-----END PGP SIGNATURE-----

--JazMeH5Ktse/7gSQ--



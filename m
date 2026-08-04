Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF73C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrJ7x-0000Bd-PY; Tue, 04 Aug 2026 13:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrJ7n-00009W-Oi
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrJ7l-00069R-AT
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785865219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHFNQRMkSw1O5vgqcxFkJTsLjm4VTVfbvR4N+kXACrg=;
 b=f37JCM2Jjr6jvJ4ekVw0NeUvxV45j1MFUOX432ewAsaW7mJHKHuzdo5tnVhu9KDQE/CWAX
 3KNynEQL7USjUOa6dFqpbxalwQs/LLZbYf2shweestfIFZlrAQmnBwrlz1Ri+QYbrYFKKN
 CZZ8D6D3Ea+k6uo2VFYyEdPuZoa8YJU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-Hein4XdGPnKCht55WnhWWA-1; Tue,
 04 Aug 2026 13:40:16 -0400
X-MC-Unique: Hein4XdGPnKCht55WnhWWA-1
X-Mimecast-MFC-AGG-ID: Hein4XdGPnKCht55WnhWWA_1785865215
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E88A81964CCC; Tue,  4 Aug 2026 17:40:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D35C19539A8; Tue,  4 Aug 2026 17:40:11 +0000 (UTC)
Date: Tue, 4 Aug 2026 13:40:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-11.1] gitlab: disable provenance attestations to work
 around CI bug
Message-ID: <20260804174007.GA488200@fedora>
References: <20260804165414.480435-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CweOObyvg/XZHcDT"
Content-Disposition: inline
In-Reply-To: <20260804165414.480435-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--CweOObyvg/XZHcDT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026 at 12:54:14PM -0400, Stefan Hajnoczi wrote:
> QEMU's CI pipeline involves building container images that will be used
> to run builds and tests. A recent Docker change triggered the following
> error:
>=20
>   $ docker push "$TAG"
>   ...
>   error from registry: blob unknown to registry - sha256:4401f6f779caf884=
1cafd5f483e642fcac56a23a4e4a59523231e101c890dad9
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/15701875927#L2372
>=20
> This happens because Docker now pushes out-of-order and the GitLab
> Container Registry rejects due to an unknown reference:
> https://forum.gitlab.com/t/started-yesterday-docker-push-error-from-regis=
try-blob-unknown-to-registry/134733/5
>=20
> It is unclear at this point whether GitLab will modify the behavior of
> Container Registry or whether Docker will ship a fix.
>=20
> The current workaround is to disable the provenance attestation that is
> involved in this issue. QEMU's CI pipeline container images are used
> internally for testing and are not widely distributed. Provenance
> attestation can be disabled as there are no external consumers of these
> images. Expect to revert this commit in the future when GitLab or Docker
> have released their own fixes.
>=20
> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Daniel P. Berrang=E9 <berrange@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Note that this is an urgent patch so that the CI will pass again and I
> can tag v11.1.0-rc3 later today. Currently it is failing due to this
> issue!
>=20
>  .gitlab-ci.d/container-template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://gitlab.com/stefanha/qemu/commits/staging

Stefan

--CweOObyvg/XZHcDT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyI/cACgkQnKSrs4Gr
c8iB3QgAuKPO6Ng2t4o7Gmy1p7BHX7wByo15bTGk6trzeux6gxmfYNmWxefix36z
g3XPzO75Rip7lilWY56FLD4uxif8eB3w02t9W5vUbecBtm8CZDtTv7TyMtN3yRDK
T2LcTQbcANr7xdorqC5cKRL/cPn+iR8fp7PolBZ5ykQs8xGPyNm9tJfBysPSLEW7
1+xVNESHsXQgnO7SrTbUtPAND/sEOG7fmnR+rMy+ahn4Ixmbflbur0QGHVcI8Yta
G0NMzBNGNgx4yg/lflEGDP6Mx5MEwBjliMqZi2qOkiD41QEAFGlzJ+RMiBgO38SU
G2frMFEbJFWhfH7UYkC195G+As2Mvg==
=/+vt
-----END PGP SIGNATURE-----

--CweOObyvg/XZHcDT--



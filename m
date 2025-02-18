Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF036C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHLI-0000Zm-VB; Tue, 18 Feb 2025 01:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkHLF-0000VV-FI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkHLE-0006eZ-3h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739861063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+9rYT9Mv6FHrCDfGMr6hJAjdkveHp1dAcoN/qyjbzY=;
 b=VcUlYQZCJc7kJJ9BAjLnC7M8OUO97eZl2XpywDen8PCMVfnK/aaXrhJHZxv0s1ob92kwMn
 QwaCsHhpSjgAncCFP/9vRmO9lpIPEjDL2MwWgcUQjGa4K4kLatF8zhi6lutwYJ5ShbtQ60
 hFkgPLU5cMqMwLjJhafdflC5S7q13XQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-3ctRfNEpNXa8B42yeG6g4A-1; Tue,
 18 Feb 2025 01:44:21 -0500
X-MC-Unique: 3ctRfNEpNXa8B42yeG6g4A-1
X-Mimecast-MFC-AGG-ID: 3ctRfNEpNXa8B42yeG6g4A_1739861060
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EA7D1800374; Tue, 18 Feb 2025 06:44:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0313B19560AA; Tue, 18 Feb 2025 06:44:17 +0000 (UTC)
Date: Tue, 18 Feb 2025 14:44:15 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 2/9] vhost_user.rst: Align VhostUserMsg excerpt members
Message-ID: <20250218064415.GF10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fidW+CeC/oxF8UZM"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-3-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--fidW+CeC/oxF8UZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:05PM +0100, Albert Esteve wrote:
> Add missing members to the VhostUserMsg excerpt in
> the vhost-user spec documentation.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fidW+CeC/oxF8UZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0LD8ACgkQnKSrs4Gr
c8hSwggArWiwPOQ5pwg6KFFFkZaZMzbhLH9XaPtFSwNq6pamyEUtj9LR1N+mOhsO
iijuVeqSbEteMJYMeFCGQkVFwckDWThh4KTW+4tqoz84Ni4dYMIAnD7DzHf8B1Oe
EKwjOCMV5Kdxbf4TzHtf3xIDHbRUDS+julWkPWIhf4CRFf9oFh4KMfr9xFJyViod
TjTwrF7cxbuepQ1wbdCDjOumvEcguwUV5zr7Z3FFrKUn4Mbf/rJmF19RRg6jipuK
PDZAEwrYMi78uZda8q132Z0BCiKqTcs42gFdFe6srnd71OGxAv5LL5Vw2+m2WKT5
OVK4tQ0CjOXCNLv3iRT/ejW4zcihPg==
=ZCDl
-----END PGP SIGNATURE-----

--fidW+CeC/oxF8UZM--



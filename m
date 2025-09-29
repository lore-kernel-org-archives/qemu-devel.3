Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A112CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JVy-0005mS-Up; Mon, 29 Sep 2025 15:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3JVv-0005kw-SS
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3JVk-0001ta-Qg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759173966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTVbHcL/oK777tdgtuv4/KRn3LtkYQiiKItUWin2IpM=;
 b=Neh+zqfEQWB183yPH5GATXkOYk50JLsmzUcK5CX9g7HfFUY6MmBM1SmdE/uHRyUbBAdPvR
 Aj8GBUGEH+wt7ugrl7MQUm7Ixe4onnNL29Av8jhp8T209YC+aQnIgE/HHhjp2KGeWOAVoU
 u9l+CusAsf3QzAiutn6Gpl/z53JBihw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-q-qIS-dqMdmfahVdnoNw2g-1; Mon,
 29 Sep 2025 15:26:04 -0400
X-MC-Unique: q-qIS-dqMdmfahVdnoNw2g-1
X-Mimecast-MFC-AGG-ID: q-qIS-dqMdmfahVdnoNw2g_1759173963
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 097411800578; Mon, 29 Sep 2025 19:26:03 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C7A8180047F; Mon, 29 Sep 2025 19:26:02 +0000 (UTC)
Date: Mon, 29 Sep 2025 15:26:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] .gitpublish: use origin/master as default base
Message-ID: <20250929192601.GK81824@fedora>
References: <20250929134348.1589790-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LuMqZw+uVrLT9rvO"
Content-Disposition: inline
In-Reply-To: <20250929134348.1589790-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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


--LuMqZw+uVrLT9rvO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:43:48PM +0100, Alex Benn=E9e wrote:
> This is very much the result of my recent fat finger but I think it's
> safer to assume that origin/master points to a recent commit (or at
> least a commit a given branch is based on) than master.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  .gitpublish | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--LuMqZw+uVrLT9rvO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja3UkACgkQnKSrs4Gr
c8gNGAgAkShuHRxQf1tMjYfToZrm2YnxTe3WikXyesU6gWrNcB30DTLWyTjYUcVE
fwsPv9N/LilHLAUFmtX8obF5fZBsB6FDJkPq3OLq6XyANFx8pctyKPRXx6TIclBW
jaAd3zF6rQ+bEenvv07RZKB+c240klXCtLU/WLr17cLV+05LoYEVBMFrBUox+jNS
j+15WI03EPRiRNyf96c0NR+Fc99OSaJFlOColL5Us1cI0FzUYCcnE2744ugEc0a2
Xsig2L5ZjVIF8kr/Exvlo3XUwLaUe5RwRExj5OCdzQObRY8ucjWWmirlRVbUuBhs
ECaE6BdMOnygwB7qvqsJ6e8ZajlkRQ==
=ekos
-----END PGP SIGNATURE-----

--LuMqZw+uVrLT9rvO--



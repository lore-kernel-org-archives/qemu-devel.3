Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AAECAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18ol-0001m2-Fw; Tue, 23 Sep 2025 15:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18oZ-0001ki-PF
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18oV-0000D4-WF
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758656194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUci4dDbwOvtcWgdrPXBU5lrllbleDmGUHakvyGv35o=;
 b=IgiIHeC7M+0+qEUea22hJ4u/lmvjKm43pXgI6r2RJAoNJRWaIg4PxMxu2ITHRB3HEf0OCX
 sfLG8S4tcLX5gVE1vx0L5y8YRjjVkENWj2KVXCmlDYDWUnRf0oIp5Du25b7cWsNeaL6g3t
 QUhUKprai11AQYXYDcdEelcdB2O9/cY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-pk1Ql6ZQPomlHBGmYf6R6g-1; Tue,
 23 Sep 2025 15:36:29 -0400
X-MC-Unique: pk1Ql6ZQPomlHBGmYf6R6g-1
X-Mimecast-MFC-AGG-ID: pk1Ql6ZQPomlHBGmYf6R6g_1758656188
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A243819560B1; Tue, 23 Sep 2025 19:36:28 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1499F3000198; Tue, 23 Sep 2025 19:36:27 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:36:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 15/16] tracetool/ftrace: add Rust support
Message-ID: <20250923193626.GQ509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6JkSU666EK2cF6Wj"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-16-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--6JkSU666EK2cF6Wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:35PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/backend/ftrace.py |  8 +++++-
>  tests/tracetool/ftrace.rs           | 40 +++++++++++++++++++++++++++++
>  tests/tracetool/tracetool-test.py   |  2 +-
>  3 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tracetool/ftrace.rs

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6JkSU666EK2cF6Wj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS9roACgkQnKSrs4Gr
c8j1uQgAhyyWMhuQKPbq9Vfk1WxiMi0TOImA5nsW7a/BuiDgNzpyhGMaYNjQu5SC
NZopNAxFWzvcZ2p812EigcgmPSZh2jcEPg5fX6fzqVR1B/HkBdli0goGJSGLWsrx
7mIZBXlbywPVneLPUvqLUnH+gmWfNun5M7PP3MaycksWdCoAQh4Zu1B7hOW8eJY5
1IwqfOxlBLnEYuNbV/o2KjTl7EXsAvJircL2xnEXsuY6Ze+7ZGVtRYV6qPDgmWoU
XJY/kSF8zS5QItHL9Z8rbsBVgV/zc3Mxp2UalGQI+2i204K5VamtqNhmdOeE88U0
i6kx/dJh0SuBFjyUgwjC3VEFIEnE/w==
=+OkD
-----END PGP SIGNATURE-----

--6JkSU666EK2cF6Wj--



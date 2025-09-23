Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1D6CAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18Ln-0004L6-QP; Tue, 23 Sep 2025 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18LV-0004Gr-5V
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18LT-0004z2-QK
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758654395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LuCCGGgFZkx/6QvmMMGXEeo5ksDCxIJjSwL4fB1/YQ=;
 b=YW0oKWC7UY9xZhbjnB1Bwb+P9J3HftDdcLoV9DYILJeK9Sy0UXkrVPQRkIE6NSWL6X6b3g
 Jl+qWX0396rJqfdF1vy1przijyqewhzmNc1XHIQI2pmTOeI6/r1vrBOz+aU9+PbK8Nkund
 +SUy9CplCslpV1wrLh2FalBMdcKj5kk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-UfiZMmEXMG-rP4W125iI-g-1; Tue,
 23 Sep 2025 15:06:31 -0400
X-MC-Unique: UfiZMmEXMG-rP4W125iI-g-1
X-Mimecast-MFC-AGG-ID: UfiZMmEXMG-rP4W125iI-g_1758654389
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46EBA195608C; Tue, 23 Sep 2025 19:06:29 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F38F1800577; Tue, 23 Sep 2025 19:06:28 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:06:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 02/16] tracetool: remove dead code
Message-ID: <20250923190627.GI509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h8XQWtLnIYlT8SwF"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--h8XQWtLnIYlT8SwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:22PM +0200, Paolo Bonzini wrote:
> There are no tcg-exec events anymore and the sub-event functionality was
> only used for it.  Excise it from tracetool.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 44 +++++------------------------------
>  scripts/tracetool/format/h.py |  5 ----
>  2 files changed, 6 insertions(+), 43 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--h8XQWtLnIYlT8SwF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS77MACgkQnKSrs4Gr
c8jErQf5Aakz6y7dXCcdv9u9ZO09yi2KWOqepQ4QpfEjWDcvzf5ESQbIw26rDBHE
PmFaRt9fKg+JuoLI61Q4tCvsymUWkn4g/mmTlW92DH1BpA0eUUSeh3nk3AVrZWpW
zrtERVumeANOUD3/OmeVfYzaaJrglQK+mUKRMI0rKX1djCQtaATbchtEzCBxJwSx
De9MHrB+hDHm0c3NWFPJhAizk1crhaFy6R2RmzAxRklb2/O5we9XRs+qwWEtQ9tz
k2Vn9EsafsMwf/CnjkVAnMlFuOk4nTu5IQBl/PK0OLD7QNQLfnHpv/XDv7j4s4+4
Y2Wm+ujbtPqgqZWbC+Z4jUb+L/Ye5w==
=gDag
-----END PGP SIGNATURE-----

--h8XQWtLnIYlT8SwF--



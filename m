Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E117CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18oJ-0001YK-6W; Tue, 23 Sep 2025 15:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18oG-0001U0-57
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18oE-0000Am-9s
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758656176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2qkGBt3Q27w24rBE/4MT8SlmzUWPMY7Nj/FN06LmwA=;
 b=d1e7RFCdg53GU3gURKdQ2lY4yBqhBnoTRNxdEg/duSYvRPCfvnDRIarJ96pc0D9IK6NRIY
 3Y5A81lF9DjakyIxn/30AWai3SFI6lBFb0czAVCX6GRbIO3YhRYP1XjBey4iAcQfl6SZYd
 YseAYVJArZvIyK5jjpj8C64Zyf/N9xE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-d6m0S2FZPGW8bWHfigmRWg-1; Tue,
 23 Sep 2025 15:36:06 -0400
X-MC-Unique: d6m0S2FZPGW8bWHfigmRWg-1
X-Mimecast-MFC-AGG-ID: d6m0S2FZPGW8bWHfigmRWg_1758656165
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 471331800357; Tue, 23 Sep 2025 19:36:04 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B82361800447; Tue, 23 Sep 2025 19:36:03 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:36:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 14/16] tracetool/log: add Rust support
Message-ID: <20250923193602.GP509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G0uXh/d1tg20XaDz"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-15-pbonzini@redhat.com>
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


--G0uXh/d1tg20XaDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:34PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/backend/log.py  | 10 ++++++-
>  tests/tracetool/log.rs            | 44 +++++++++++++++++++++++++++++++
>  tests/tracetool/tracetool-test.py |  2 +-
>  3 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tracetool/log.rs

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--G0uXh/d1tg20XaDz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS9qIACgkQnKSrs4Gr
c8jwCAf9GTyrsOTs+cCvSIovgDdbyuMUrUqmD2ZVLK8N7ZVsuOctX/RZ04tNPqIF
NrxaFhYD1DBm8tmwuNMYrvkYYgGciEDLMpFSgdKaLsbku7KS6Swekw/kxHNoZ5fQ
Vu5r3vQq+ohDvfOaFcOagBG9Hy5RFPUKo135HN5SpkyaiW9J/oevUA96HP6FG1z9
HAi6E3X1SJA2sWLUXNl6PLPnkI3RA7c9zNy6Q6Dp1JzN9OQofaPYnSR5nv+D7+l9
FUhQmNE0XA74omKvCpd6OPqEdPpSViow/l0RXEMe2mFTPGjoEaqkKKsaXFeAgd5Z
85NS6p182TVIH+saH9U/1GG5DBLOVg==
=ZuoJ
-----END PGP SIGNATURE-----

--G0uXh/d1tg20XaDz--


